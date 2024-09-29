#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业12",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
```hs
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Sequence (Seq (Empty))

type Variable = String

data Exp
  = Lit Int
  | Var Variable
  | Add Exp Exp
  | Sub Exp Exp
  | Mul Exp Exp
  deriving (Eq)

instance Show Exp where
  show (Lit n) = show n
  show (Var x) = x
  show (Add e1 e2) = show e1 ++ " + " ++ show e2
  show (Sub e1 e2) = show e1 ++ " - " ++ show e2
  show (Mul e1 e2) = show e1 ++ " * " ++ show e2

data UnitCommand
  = SkipU
  | AssignU Variable Exp
  | IfThenElseU Exp
  | IfEnd
  | WhileU Exp
  | WhileEnd
  deriving (Eq)

-- 判断稍后是否合并，Control Command 不合并
isControlCommand :: UnitCommand -> Bool
isControlCommand SkipU = False
isControlCommand (AssignU _ _) = False
isControlCommand _ = True

instance Show UnitCommand where
  show SkipU = "Skip"
  show (AssignU x e) = x ++ " := " ++ show e
  show (IfThenElseU e) = "If " ++ show e
  show IfEnd = "EndIf"
  show (WhileU e) = "While " ++ show e
  show WhileEnd = "EndWhile"

data Command
  = Skip
  | Assign Variable Exp
  | Seq Command Command
  | IfThenElse Exp Command Command
  | While Exp Command
  deriving (Eq, Show)

newtype Node = Node [UnitCommand] deriving (Eq)

instance Show Node where
  show (Node cs) = join $ map show cs
    where
      join [] = ""
      join (x : xs) = show x ++ ";" ++ join xs

data EdgeLabel = IfTrue | IfFalse | WhileTrue | WhileFalse | LoopBack | EmptyLabel deriving (Eq, Show) -- 用于标记边的类型

data Graph v = Graph
  { nodes :: Map Int v,
    edges :: [(Int, Int, EdgeLabel)],
    start_node :: Int,
    end_node :: Int
  }
  deriving (Eq, Show, Functor)

succNodesExceptBack :: Graph v -> Int -> [Int]
succNodesExceptBack g n = [m | (n', m, l) <- edges g, n' == n && l /= LoopBack]

mergeNode :: (v -> v -> v) -> Graph v -> Int -> Int -> Graph v -- 将两个节点合并，将第二个节点的所有出边改为从第一个节点出
mergeNode f g n1 n2 =
  let nodes1 = Map.insert n1 (f (nodes g Map.! n1) (nodes g Map.! n2)) (nodes g)
      nodes2 = Map.delete n2 nodes1
   in Graph
        { nodes = nodes2,
          edges = [(if n' == n2 then n1 else n', if m == n2 then n1 else m, l) | (n', m, l) <- edges g, not ((n', m) == (n1, n2) || (n', m) == (n2, n1))], -- 防止自环
          start_node = if start_node g == n2 then n1 else start_node g,
          end_node = if end_node g == n2 then n1 else end_node g
        }

updateNode :: v -> Graph v -> Int -> Graph v -- 更新节点的值
updateNode v g n = Graph {nodes = Map.insert n v (nodes g), edges = edges g, start_node = start_node g, end_node = end_node g}

data GraphR a = Plain a | Component (Graph (GraphR a)) deriving (Eq, Show, Functor) -- 课上的 Component 实现

type GraphC = Graph (GraphR Node)


mergeNodeC :: (Node -> Node -> Node) -> GraphC -> Int -> Int -> GraphC -- 假设 n1, n2 都是 plain 节点，将其合并
mergeNodeC f g n1 n2 = mergeNode (\(Plain (Node l1)) (Plain (Node l2)) -> Plain $ Node (l1 ++ l2)) g n1 n2

indexTrans :: Graph a -> (Int -> Int) -> Graph a -- 将图中的节点编号转换，需要保证 f 的单射性
indexTrans g f =
  Graph
    { nodes = Map.mapKeys f (nodes g),
      edges = [(f n, f m, l) | (n, m, l) <- edges g],
      start_node = f (start_node g),
      end_node = f (end_node g)
    }

connectGraph :: Graph a -> Graph a -> EdgeLabel -> Graph a -- 将两个图连接起来，前者的 end 连接到后者的 start
connectGraph g1 g2 l =
  Graph
    { nodes = Map.union (nodes g1) (nodes g2'),
      edges = edges g1 ++ edges g2' ++ [(end_node g1, start_node g2', l)],
      start_node = start_node g1,
      end_node = end_node g2'
    }
  where
    g2' = indexTrans g2 (\x -> x + (maximum $ Map.keysSet (nodes g1))) -- 为了避免节点编号冲突，将 g2 的节点编号加上一个偏移量，值为 g1 的节点编号的最大值（假设编号都正）

nodeToGraphC :: Node -> GraphC
nodeToGraphC n =
  Graph
    { nodes = Map.fromList [(1, Plain n)],
      edges = [],
      start_node = 1,
      end_node = 1
    }

-- 构建控制流图
toCFG :: Command -> GraphC
toCFG Skip = nodeToGraphC (Node [SkipU])
toCFG (Assign s e) = nodeToGraphC (Node [AssignU s e])
toCFG (Seq c1 c2) =
  let g1 = toCFG c1
      g2 = toCFG c2
   in connectGraph g1 g2 EmptyLabel -- 这里我们直接将两张图连接起来，不再创建更上层的图
toCFG (IfThenElse e c1 c2) =
  let g1 = toCFG c1
      g2 = toCFG c2
   in Graph
        { nodes = Map.fromList [(1, Plain $ Node [IfThenElseU e]), (2, Component g1), (3, Component g2), (4, Plain $ Node [IfEnd])],
          edges = [(1, 2, IfTrue), (1, 3, IfFalse), (2, 4, EmptyLabel), (3, 4, EmptyLabel)],
          start_node = 1,
          end_node = 4
        }
toCFG (While e c) =
  Graph
    { nodes = Map.fromList [(1, Plain $ Node [WhileU e]), (2, Component $ toCFG c), (3, Plain $ Node [WhileEnd])],
      edges = [(1, 2, WhileTrue), (2, 1, LoopBack), (1, 3, WhileFalse)],
      start_node = 1,
      end_node = 3
    }

-- 合并相邻的顺序语句，第一个参数是开始节点的编号
mergeSeq' :: Int -> GraphR Node -> GraphR Node
mergeSeq' _ (Plain n) = Plain n
mergeSeq' start (Component g) =
  let start_point = (nodes g) Map.! start
   in let succ_of_start = succNodesExceptBack g start -- 注意这里要丢掉 while loop 返回的边
       in case start_point of
            Plain (Node l) ->
              if length succ_of_start == 1 -- 仅有一个后继节点，检查后继节点是否 plain
                then
                  let next = (head succ_of_start)
                      next_point = (nodes g) Map.! next
                   in case next_point of
                        Plain (Node l') ->
                          -- 将两个 plain 节点合并
                          if isControlCommand (head l') -- 若下个节点是控制节点，无法合并
                            then mergeSeq' next (Component g) -- 当前无法合并，考虑向后移动
                            else
                              let new_graph = mergeNodeC (\(Node l1) (Node l2) -> Node (l1 ++ l2)) g start next
                               in mergeSeq' start (Component new_graph) -- 注意合并后 next 出边被移到 start 上，因此递归进行即可
                        _ -> mergeSeq' next (Component g) -- 当前无法合并，考虑向后移动
                else foldr mergeSeq' (Component g) succ_of_start -- 有多个后继节点，从每个节点都开始对图更新一次
            Component g' ->
              let new_g = Component $ updateNode (mergeSeq (Component g')) g start -- 进入子 Component 处理并更新 start 节点
               in foldr mergeSeq' new_g succ_of_start -- 再从后继的每个节点开始递归处理

mergeSeq :: GraphR Node -> GraphR Node
mergeSeq (Plain n) = Plain n
mergeSeq (Component g) = mergeSeq' (start_node g) (Component g)

seqs :: [Command] -> Command
seqs = foldr1 Seq

testC :: Command
testC =
  seqs
    [ Assign "x" (Lit 1),
      Assign "y" (Lit 0),
      While
        (Var "x")
        ( seqs
            [ Assign "x" (Sub (Var "x") (Lit 1)),
              Assign "y" (Add (Var "y") (Lit 1)),
              IfThenElse (Var "x") (Assign "y" (Lit 1)) (Assign "y" (Lit 2)),
              Skip
            ]
        )
    ]

main :: IO ()
main = do
  print $ toCFG testC
  print $ mergeSeq (Component $ toCFG testC)
-- Component (Graph {
--     nodes = fromList [(1,Plain "x := 1";"y := 0";),(3,Plain "While x";),(4,Component (Graph {nodes = fromList [(1,Plain "x := x - 1";"y := y + 1";),(3,Plain "If x";),(4,Component (Graph {nodes = fromList [(1,Plain "y := 1";)], edges = [], start_node = 1, end_node = 1})),(5,Component (Graph {nodes = fromList [(1,Plain "y := 2";)], edges = [], start_node = 1, end_node = 1})),(6,Plain "EndIf";"Skip";)], edges = [(3,4,IfTrue),(3,5,IfFalse),(4,6,EmptyLabel),(5,6,EmptyLabel),(1,3,EmptyLabel)], start_node = 1, end_node = 6})),(5,Plain "EndWhile";)], edges = [(3,4,WhileTrue),(4,3,LoopBack),(3,5,WhileFalse),(1,3,EmptyLabel)], start_node = 1, end_node = 5
-- })

```