#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "软件分析",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let sup = math.union.sq
= 前言
  == 基本概念
    给定软件系统，回答关于系统行为有关问题的技术称为软件分析技术。能否彻底避免软件中出现特定类型（例如内存泄漏）的缺陷？逻辑上而言这是不可能的，既然编程语言中总有无法证明的表达式 $T$，则以下程序：
    ```c
    a = malloc(10);
    if (T) free(a);
    return
    ```
    显然程序有内存泄漏当且仅当 $T$ 不是永真式。仿照停机问题，也可以构造：
    ```c
    void Evil() {
      int a = malloc();
      if (LeakFree(Evil)) return;
      else free(a); return;
    }
    ```
    称存在算法判定的问题为可判定问题，否则称为不可判定问题。
    #theorem[Rice][
      假设将任意程序看成输入到输出的函数，则关于这个函数的任何非平凡属性都不可判定。其中平凡属性指对所有程序都成立或都不成立的属性（命题）。
    ]
    #proof[
      给定非平凡性质 $P$，不妨假设空集（无输出，包括不停机的程序）不满足 $P, "ok_prog"$ 满足性质 $P$，并假设检测该性质的算法为 $"P_holds"$，如下程序：
      ```c
      Bool Halt(program q){
        void evil(Input n){
          Output v = ok_prog(n);
          q();
          return v;
        }
        return P_holds(evil);
      }
      ```
      是一个判定停机问题的程序，这是荒谬的。
    ]
    #remark[][
      - Rice's theorem 中将程序抽象成函数，涉及程序结构的问题并不在讨论范围内，例如说程序中使用变量是否超过 50 个，这不是程序对应函数的性质。
      - 上述的讨论均针对抽象的u图灵机或者无限的自动机，然而真实计算机内存是有限的，事实上现实计算机只是有限状态机，其停机性是可判定的。这个技术称为模型检查，在硬件领域被广泛应用，但在软件领域因为状态数过多无法应用。
    ]
    现实中的软件分析往往采用工程式的思想，虽然不能给出完全正确的算法，但可以设计一些“近似”算法，允许它检查出一些程序，不能检查出另外的程序。
    - 只判定“是”或者“不知道”的近似称为下近似/must analysis，例如问题是程序是否有某种 Bug，则测试是一种 must analysis
    - 只判定“否”或者“不知道”的近似称为上近似/may analysis
    对于非判定问题，同样也可以有下近似或者上近似，例如返回目标集合的超集或者子集。

    另外，我们还有一些逻辑用语：
    - 正确性：Soundness，指逻辑系统的推导规则是正确的，即如果前提为真，则结论也为真，类似于 Must 分析
    - 完备性：Completeness，指逻辑系统的推导规则是完备的，即如果结论为真，则可以被推导出来，类似于 May 分析
    #remark[][
      程序分析早期源于编译器优化，在优化领域 Soundness 往往指编译器的改写是正确的（也叫 Safety），此时具体而言可能是 Must 分析和 May 分析的其中一个。
    ]
    本门课程涉及的技术本质来说可以分为抽象和搜索。
  == 抽象
    给定表达式语言：
    #let pterm = ``` term {x > 0}```
    #let nterm = ``` term {x < 0}```
    #let zterm = ``` term {x = 0}```
    #let term = ``` term```
    ```haskell
    term := term + term 
          | term * term 
          | term - term 
          | integer
          | variable
    ```
    若 $a, b, c >= 0$，希望得到 $a + b * c >= 0$，一般而言我们会设置：
    - 抽象域：将所有输出分成几类，例如 #pterm, #nterm, #zterm, #term
    - 计算规则，例如：
      - #pterm $+$ #pterm = #pterm
      - #pterm $*$ #pterm = #pterm
      - ......
    运用规则对抽象域进行运算即可。

    更广泛的，抽象技术被广泛用于程序分析的过程分析。

  == 搜索
    判断以下程序是否发生内存泄漏：
    ```c
    if (a == b && c == d && a != b) x = malloc();
    return;
    ```
    为了判断程序是否内存泄漏，理论上我们就是要搜索输入空间，判断是否存在输入使得程序发生内存泄漏。当然实践上通常引入各种剪枝和推断等方法。具体而言，表达式 ```c a == b && c == d && a != b``` 只是三个布尔变量的和，我们可以先枚举所有布尔值，再去判断是否存在输入恰好满足对应的布尔值。

    一般而言，抽象给出的是所有执行情况的不精确分析，搜索考虑一部分执行的精确分析。两者往往结合使用，例如抽象出程序的执行情况，再搜索其中的一部分情况。
  == 程序语言基础知识
    - 语法（syntax)：程序的静态书写方式
    - 语义（semantic）：程序的动态执行行为
    #definition[文法][
      文法是一个四元组 $(N, T, P, S)$，其中 $N$ 是非终结符集合，$T$ 是终结符集合，$P$ 是产生式集合，$S in N$ 是开始符号。

      例如，取 $N = {S, A}, T = {a, b}, P = {S -> a A b, a A -> a a A b, A -> epsilon}$，则通过变化：
      $
      S &=> a A b\
      &=> a a A b b\
      &=> a a a A b b b\
      &=> a a a b b b
      $
      可以得到一个终结符号串。所有这样的终结符号串的集合称为文法 $G$ 生成的语言。

      文法可以分成以下几类：
      - 正则文法：只有一种产生式形式 $A -> a B$ 或者 $A -> a$ 或者 $S -> epsilon$
      - 上下文无关文法：产生式左边只有单个非终结符，例如 $A -> a B$
      - 上下文有关文法：允许书写 $alpha A beta -> alpha gamma beta$，但不允许上下文 $alpha, beta$ 改变
      - 任意文法，等价于图灵机
    ]
    #remark[][
      习惯上，现代程序语言使用正则语言将字符串解析成 token，再将 token 作为终结符采用上下文无关文法描述整个语言。对于更复杂的文法，目前还没有高效的解析算法，也并不常用。
    ]
    对于语义，我们往往采取以下几种：
    - 操作语义：将程序元素解释为计算步骤
    - 指称语义：解释为数学中严格定义的符号
    - 公理语义：严格写出前条件，后条件，使用霍尔逻辑推导
    某种意义上，程序分析就是输入程序语法，返回程序语义的问题。通常程序分析涉及的层面是：
    - 抽象语法树：表示程序的抽象语法结构
    - 三地址码：将复杂程序简化到每个语句只有一个运算，控制语句全部简化成 goto 的中间代码
    - 控制流图：（一般在三地址码的基础上），程序的执行构成一个图。控制流指语句执行的顺序，控制流图的节点表示一个不含跳转的单元，边表示跳转关系。
    #example[IMP][
      定义非常简单的命令式语言 IMP:
      ```haskell
      data UnitCommand = SkipU
      | AssignU string exp
      | IfThenElseU exp
      | IfEnd
      | WhileU exp
      | WhileEnd
      data Command = Skip 
      | Assign string exp 
      | Seq Command Command
      | IfThenElse exp Command Command
      | While exp Command
      ```
      以及图结构：
      ```haskell
      newtype Node = Node UnitCommand 
      data Graph v = {
        nodes :: Map Int v,
        edges :: List (Int, Int),
        start_node :: Int,
        end_node :: Int
      }
      data GraphR = PlainGraph (Graph Node) | ComponentGraph (Graph GraphR) -- 递归的图类型
      graphNode :: Node -> GraphR
      graphNode n = PlainGraph $ Graph {
          nodes = Map.fromList [(0, n)],
          edges = [],
          start_node = 0,
          end_node = 0
      }
      ```
      
    ]
    #algorithm[][
      在上面的例子中，可以给出到控制流图的翻译：
      ```haskell
      toCFG :: Command -> GraphR
      toCFG Skip = graphNode (Node SkipU)
      toCFG (Assign s e) = graphNode (Node (AssignU s e))
      toCFG (Seq c1 c2) =
        let g1 = toCFG c1
            g2 = toCFG c2
        in GraphR (ComponentGraph (Graph {
          nodes = Map.fromList [(1, g1), (2, g2)],
          edges = [(1, 2)],
          start_node = 1,
          end_node = 2
        }))
      toCFG (IfThenElse e c1 c2) =
        let g1 = toCFG c1
            g2 = toCFG c2
            gIF = graphNode (Node IfThenElseU e)
            gEnd = graphNode (Node IfEnd)
        in GraphR (ComponentGraph (Graph {
          nodes = Map.fromList [(1, gIF), (2, g1), (3, g2), (4, gEnd)],
          edges = [(1, 2), (1, 3), (2, 4), (3, 4)],
          start_node = 1,
          end_node = 4
        }))
      toCFG (While e c) =
        let gWhile = graphNode (Node WhileU e)
        in GraphR (ComponentGraph (Graph {
          nodes = Map.fromList [(1, gWhile), (2, toCFG c), (3, graphNode (Node WhileEnd))],
          edges = [(1, 2), (2, 1), (2, 3)],
          start_node = 1,
          end_node = 3
        }))
      ```
    ]
    #algorithm[三地址码的控制流图][
      对于三地址码，没有结构化的 if-else 和 while，需要详细分析 goto 的目标
      + 首先，基本块就是每两个 goto 语句之间的代码块
      + 然后，基本块之间的跳转关系就是 goto 语句的目标
    ]

= 基于抽象解释的程序分析
  == 数据流分析
    === 基本数据流分析
      #definition[][
        记 $A$ 为抽象域的集合，$X$ 为真实值的集合，记：
        - $Gamma : A -> P(X)$ 将抽象域映射到真实值的集合
        - $alpha : X -> A$ 将具体值映射到抽象域，需要满足 $alpha(Gamma(a)) = {a}$
      ]
      所谓的数据流分析，就是要在带有条件，循环等控制流的程序中，处理类似前言中表达式正负的问题。数据流分析的常见手法是：
      - 将全局状态（变量到值的映射）转换成抽象状态（变量到抽象值的映射）
      - 为每个程序语句设计抽象状态函数，实时改变抽象状态
      #algorithm[抽象状态计算][
        - 对于一般的顺序语句，抽象状态函数是显然的
        - 对于条件语句，抽象状态函数是两个分支的抽象状态函数的上确界
        - 对于循环语句，考虑：
            ```c
            x = 100;
            y = 1;
            while (y > x) {
              x *= -100;
              y += 1;
            }
            ```
            尽管我们不知道循环会执行多少次终止，从逻辑上我们仍然可以得到一些结果。为了实现，我们假设抽象域中有符号 $bot$ 使得 $Gamma(bot) = emptyset$，假设每个节点处符号的初始值都是 $bot$，从 entry 的后继节点开始，分析时随机选取节点使用分支合并更新状态，使用宽度优先方法，如果某节点更新就将其后继加入待更新节点，直至没有节点待更新。
      ]
      #theorem[][
        上面的算法是正确的，也即保证每个变量的值符合抽象状态。同时，它也保证停止，并且停止的结果与最开始选取的节点无关。
      ]
      #remark[][
        这种分析方法产生了以下几种不精确性：
        - 将值抽象成有限个值的集合
        - 值的运算抽象到集合上，加大了不精确性
        - 发生分支时，往往事实上只有一个分支被执行，但我们假设两个都有可能执行
        - 状态合并时，也会产生不精确性
      ]
      #example[可达定值分析][
        给定程序，判断每个变量的值可能在哪些行被赋值。这与数据流分析很接近，其中具体域是所有程序行号，转换函数是在赋值语句处替换，其他语句不变。注意算法中需要初始将所有节点全部加入待更新节点，否则非赋值语句可能保持 $bot$ 不变，导致算法停止。
      ]
      #example[可用表达式分析][
        给定程序，如果从入口到某一位置 $p$ 的所有路径都计算了表达式 $e$，并且最后一次执行后没有改变与 $e$ 相关的变量，则称 $e$ 是 $p$ 处的一个可用表达式。这个问题中的具体域是程序中的所有表达式，每个节点的初始值是程序表达式的全集，转换函数是计算表达式时增加，变量赋值时删去相关的的表达式，分支合并时取交而非并。 
      ]
      #example[活跃变量分析][
        给定程序，如果语句 $s$ 执行前，一个变量的值在 $s$ 或后续的语句仍然使用，则称之为活跃变量。与之前问题的主要区别在于我们需要倒着程序的执行顺序进行分析，抽象值含义是从当前位置开始任意长度的具体执行序列的集合（注意由于程序会无限执行，在倒着分析的时候不能假设所有的执行序列都在最后的节点终止）初始值为空集，每个节点处先删去写入的变量，再加入读取的变量，分支合并时取并。
      ]
      #remark[][
        一般来说，数据流分析只能考虑从 entry 开始或者从 exit 结束的有限执行序列。对于可能无穷的执行序列，逻辑上无法分析。对于活跃变量分析，我们可以转而证明在任意位置结束的有限执行序列都正确，进而保证时间上的正确性。
      ]
      一般而言，数据流分析有以下步骤：
      - 设计抽象域
      - 编写节点转换函数，注意可能需要处理复杂表达式，此时可以对递归的表达式结构进行分析，或者直接对三地址码进行分析。
      - 处理控制流路径的分叉和合并

      之前都没有讨论算法的终止性和合流性（节点选择顺序不影响结果），为此我们引入一套数据流分析的框架，并基于该框架进行证明。
      #definition[半格 semilattice][
        称 $(S, sup)$ 为半格，如果满足：
        - 幂等性：$x sup x = x$
        - 交换性：$x sup y = y sup x$
        - 结合性：$(x sup y) sup z = x sup (y sup z)$
        它是幂等的交换半群。不难验证，$x subset y := x sup y = y$ 是偏序关系，$sup$ 实际上是求上确界运算。

        有最小值 $bot$ 的半格称为有界半格，它是幂等的交换幺半群。

        称一个有界半格的高度指其中全序子集元素个数的最大值。
      ]
      #theorem[不动点定理][
        给定有限高度的有界半格 $S$ 和单调函数 $f: S -> S$，则 $bot, f(bot), ..., $ 一定在有限步停止在 $f$ 的最小不动点
      ]
      #proof[
        - 首先证明序列终止。不难验证：
          $
          bot subset f(bot) => f(bot) subset f(f(bot)) => ...
          $
          说明该序列是链，而有限高度意味着链有限长，进而最终稳定，而稳定的值当然是不动点。
        - 其次，为了证明它是最小不动点，取 $x$ 是一个不动点，则：
          $
          bot subset x => f(bot) subset f(x) = x => ...
          $
          反复应用可得结论
      ]
      #definition[数据流单调分析框架][
        可以定义一般框架：
        - 一个控制流图 $G$
        - 一个有限高度的有界半格 $S$
        - 一个 entry 
        - 一个单调函数 $f$
        可以证明，对于该框架（对应的随机选取节点进行更新的算法称为工单算法），依次选取节点更新的算法称为轮询算法），容易证明轮询算法一定收敛到更新函数的最小不动点，而工单算法也会收敛到该点，因此一定收敛并且收敛到相同值
      ]
      #definition[分配性][
        假设转换函数 $f_v$  满足 $f_v (x) sup f_v (y) = f_v (x sup y)$，则称满足分配性。满足分配性的数据流分析不会因为提前合并引入不精确性。由集合交/并操作构造的转换函数都满足分配性。
      ]
    === 数据流分析拓展：条件压缩
      在上面的近似方案中，我们认为所有分支都会执行从而得到分析结果，这当然是荒谬的。为了使结果更精确，我们需要更精细地处理这个问题。一个常见的方案是增加条件压缩节点，也就是：
      ```c
      if (x > 0)
      {
        x += 1;
      }
      else
      {
        x = 1;
      }
      ```
      转换成：
      ```c
      if (x > 0)
      {
        assert(x > 0);
        x += 1;
      }
      else
      {
        assert(x <= 0);
        x = 1;
      }
      ```
      这里，我们的任务是要通过 assert 节点反解出 $x$ 满足的条件，这被称为*反向执行语义*。

      这里，我们拓展抽象域的定义以满足布尔值：
      $
      {bot, T, F, top}
      $ 
      #let Inv = $"Inv"$
      其中 $gamma(bot) = {}, gamma(top) = {T, F}$，定义规则：
      - $Inv(and) (bot) = (bot, bot)$
      - $Inv(and) (T) = (T, T)$
      - $Inv(and) (\_) = (top, top)$
      - $Inv(> 0)(bot) = bot$
      - $Inv(> 0)(T) = {x: "int"  > 0}$
      - ...
      事实上，我们可以做更精确的压缩，结合目前已知的信息给出更精确的结果，例如：
      $
      Inv(and) ((T, top), F) = (T, F)
      $
      其中前一个参数指变量当前的抽象状态，后一个参数指表达式的抽象值，结果是变量的新抽象状态。注意在实际的复杂表达式，例如：
      $
      x > 0 and y > x and z > y = T
      $
      时，我们要先正向执行，得到：
      $
      (x > 0, y > x, z > y): (top, top, top)
      $
      反向压缩得到：
      $
      (x > 0, y > x, z > y): (T, T, T)\
      (x, y, z) : (>0, top, top)
      $
      不难看出这个过程并未终止，可以再次进行，迭代几次后可以得到：
      $
      (x, y, z) : (>0, >0, >0)
      $
      一般的，如果反向执行的规则足够单调，则这样的迭代会收敛，然而实践上往也会使用不能保证收敛的反向执行语义。
    === 区间分析：加宽和变窄
      对于下面的程序：
      ```c
      x = 1;
      for (int i = 0; i < b; i++) {
        x += 1;
      }
      ```
      求出一个 $x$ 的上界和下界，这样的分析称为区间分析。实际结果为 $[0, +infinity]$ ，然而如果使用通常的数据流分析技术，我们无法真正得到 $+infinity$，或者说半格的高度是无穷的，导致无法收敛。有些时候，即使有限高度，高度也会过高导致收敛过慢。为此我们引入加宽和变窄的概念：
      - 加宽：通过降低精度加快分析过程，包括：
        - 简易加宽：降低格的高度，例如在上面的问题中，抽象域不取全体整数，而是例如：
          $
          -infinity, 1, 2, ..., 100, +infinity
          $
          实际计算时，寻找与抽象域中格点接近的，保证正确的结果。尽管会导致精度损失，但安全性和收敛性往往容易保证。
        - 通用加宽：根据趋势猜测结果。具体来说，引入加宽算子 $a nabla b$，其中 $a$ 是该节点旧值，$b$ 是一轮更新后得到的新值，定义：
          $
          [a, b] nabla [c, d] = (m, n) where\
          m = "if" c >= a "then" a "else" -infinity\
          n = "if" b <= d "then" b "else" +infinity
          $
          换言之，只要发现新结果的上界变大，就直接加宽到正无穷，否则采纳旧值（这里采纳旧值新值均可，采纳旧值可以更快收敛，采纳新值可能会造成无穷震荡）；下界变小，就直接加宽到负无穷。这样收敛的速度很快。不幸的是，加宽函数往往没有单调性，目前并没有容易判断的属性保证通用加宽的收敛性，在除了循环之外的场景往往也会导致奇怪的问题。实践上往往只会在循环的入口处使用通用加宽。
      - 变窄：加宽可以提高效率，然而往往会损失很多精确性。为此我们引入变窄技术，基本思想是在加宽收敛后，进行一轮普通的数据流分析，就可以得到较为精确的结果。
      #theorem[][
        设普通数据流分析更新函数为 $F$（具有单调性），添加加宽算子后为 $G$ ，并且满足 $G(x) >= F(x)$，则加宽-变窄是安全的
      ]
      #proof[
        假设 $x_0$ 是 $F$ 的不动点，也就是当前抽象域下最精确的估计。不难发现：
        $
        x <= x_0 => F(x) <= x_0 => G(x) <= x_0
        $
        蕴含着 $G$ 是加宽是安全的。为了考虑变窄，假设加宽 $n$ 次后采取变窄，得到结果：
        $
        F(G^n (bot))
        $
      ]
    === 抽象解释
      #definition[][
        假设具体域为 $D$，抽象域为 $A$
        称 $gamma: A -> D$ 为具体化函数，$alpha: A -> D$ 为抽象化函数，称他们构成一个 Galois 连接，如果满足：
        $
        alpha(X) <= Y <=> X <= gamma(Y) 
        $
      ]
      #remark[][
        事实上假设将偏序集看作范畴，一对 Galois 连接就是一对伴随函子。
      ]
      #proposition[][
        $alpha, gamma$ 是 Galois 连接当且仅当以下性质全部成立：
        - $forall X in D, X <= gamma (alpha(X))$
        - $forall Y in A. alpha(gamma(Y)) <= Y$
        - $forall X, Y in D, X <= Y => alpha(X) <= alpha(Y)$
        - $forall X, Y in A, X <= Y => gamma(X) <= gamma(Y)$
      ]
      #definition[][
        设 $alpha, gamma$ 是 Galois 连接，$f: A -> A, g: D -> D$，则：
        - $f$ 是 $g$ 的安全抽象，如果：
          $
          (alpha compose g compose gamma) (X) <= f(X)
          $
          也等价于：
          $
          (g compose gamma) (X) <= (gamma compose f) (X)
          $
        - $f$ 是 $g$ 的最佳抽象，如果：
          $
          alpha compose g compose gamma = f
          $
        - $f$ 是 $g$ 的精确抽象，如果：
          $
          g compose gamma = gamma compose f
          $
        显然最佳抽象总是存在的，但精确抽象不一定存在。
      ]
      取具体域为程序执行踪迹的集合，抽象域为分析结果，并令：
      - $alpha$ 为踪迹集合对应的精确分析结果，也即 $alpha(X) := sup_(x in X) beta(x)$
      - $gamma(Y) = {x | beta(x) <= Y}$
      容易证明这构成一个 Galois 连接。事实上，一个精确的程序分析应该满足：
      #align(center)[#commutative-diagram(
      node((0, 0), $"抽象输入"$, 1),
      node((0, 1), $"分析结果"$, 2),
      node((1, 0), $"输入轨迹集合"$, 3),
      node((1, 1), $"执行踪迹集合"$, 4),
      arr(1, 2, $"抽象语义"$),
      arr(3, 1, $beta$),
      arr(4, 2, $alpha$),
      arr(3, 4, $"具体语义"$),)]
      而通常如果保证：
      #align(center)[#commutative-diagram(
      node((0, 0), $"抽象输入"$, 1),
      node((0, 1), $"分析结果"$, 2),
      node((1, 0), $"输入轨迹集合"$, 3),
      node((1, 1), $"执行踪迹集合"$, 4),
      arr(1, 2, $"抽象语义"$),
      arr(3, 1, $beta$),
      arr(4, 2, $alpha <= $),
      arr(3, 4, $"具体语义"$),)]
      #let trans = $"trans"$
      #let State = $"State"$
      #let Set = $"Set"$
      #let Step = $"Step"$
      #let List = $"List"$
      #let Node = $"Node"$
      #let Trace = $"Trace"$
      #let Step = $"Step"$
      就称之为安全的。具体而言，这里我们将单个节点 $v$ 的程序语义抽象成状态转换函数：
      ```hs
      trans: Node -> State -> Set State
      ```
      程序的一个具体执行序列 $T: Trace$ 定义为：
      ```hs
      Trace := [(Node, State)]
      ```
      则给定一个执行序列 $T$ ，可以定义：
      ```hs
      Step T : Trace -> Set Trace
      Step T = do
          next_node <- next v 
          let (v, s) = last T
          next_state <- trans v s
          return $ T ++ [(next_node, next_state)]
      Step_inf : Trace -> [Set Trace]
      Step_inf T = iterate (\ma -> ma >>= Step) (return T)
      ```
      有了这些定义，我们可以详细地证明程序分析在语义上的正确性。
    === 敏感性
      我们往往用敏感性表示程序分析的精确性，往往包括：
      - 流敏感性：分析结果忽略了程序的控制流，任意交换语句顺序不改变分析结果。数据流分析是流敏感的。如果在数据流分析中，直接认为所有节点都是当前节点的前驱，则产生的就是流不敏感的分析。
      - 路径敏感：对于控制流不同的路径，分析结果可能不同。带有条件压缩的数据流分析是路径敏感的。
      #block(width: 100%)[
        $dots$
      ]
  == 过程间分析
  == 指针分析
    
= 基于约束求解的程序分析
  == SAT
  == SMT
  == 符号执行
= 软件分析应用
  == 程序合成
  == 缺陷分析
  == 缺陷修复