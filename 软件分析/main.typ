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
    过程间分析（Inter-procedural Analysis），有时也称为全程序分析。在 C/C++ 这种编译，链接分开的语言中，也称之为链接时分析，也就是在引入函数调用的情况下，考虑控制流分析。基本思路是对不同过程采用不同抽象域，在调用和返回时添加节点来转换信息。换言之，将不同过程的控制流图以调用-开始，返回-结束调用连接起来。
  
    如果过程中涉及全局变量，则全局变量应该出现在所有过程的抽象域之中。然而，把所有全局变量加到所有过程中十分浪费资源。直观来说，可以将全局变量加入到使用全局变量的过程和这些过程的直接或间接调用者。

    上面的方法会引入严重的不精确性，假如 A, B 都调用了 C,则控制流图上将产生 A -> C -> B 这样不可能发生的路径。为了改善这个问题，我们需要增强上下文敏感性。
    === 基于克隆的上下文敏感分析
      简单来说，将每次函数调用的代码复制到调用处即可。这样遇到的问题主要是：
      - 当调用层数增加时，克隆的次数会指数爆炸
      - 递归调用无法处理
      一个简单的解决方案是，只对最近的 $k$ 次调用（调用链的前 $k$ 层）区分上下文。对于递归函数，也可以控制调用的深度。超出次数/深度限制的函数调用就停止克隆操作。其他解决方案包括：
      - 基于函数名字而不是调用位置的上下文，也就是只区分这个函数被哪个函数调用
      - 在面向对象语言中，根据 $x$ 的不同类型区分上下文。这在面向对象语言中非常常用
      - 根据上下文状态进行分类，每个分类视作同一组上下文
      事实上，过程内分析中也可以应用克隆的思想。例如循环的前几次调用往往对结果影响比较大，同样可以先做 $k$ 层展开。
    === 精确的上下文敏感分析
      克隆的方法并不能完美的消除上下文造成的不精确性。事实上，设计出完全消除这种不精确性的分析方法是有可能的。历史上人们提出了多种模型：
      ==== CFL 可达性分析
        CFL（Context-Free Language）可达性分析在 1995 年由 Reps 等人提出，能够优化出高效的算法，能覆盖任意的具备分配性的数据流分析。基于此模型，人们还讨论清楚了若干可判定性问题。

        在 CFL 分析中，我们借助以下定义的上下文无关文法 Dyck-CFL：
        ```
        S := 
        | {_i S }_i
        | S S
        | epsion
        ```
        在调用图上，每次调用-返回的边标注上匹配的左右括号。一条路径是合法的，当且仅当对应的括号匹配语言合法。在数据流分析中，我们一般不记录该抽象值的来源，但在这种情况下我们必须记录。理论上这种路径记录可以通过下推自动机完成，但相当复杂。但如果我们保证数据流分析的分配性（先合并再更新等于先更新再合并），则更新函数就可以抽象成一个二分图上的可达性。更进一步，在过程间分析中，可以将不同函数对应的二分图按照可能情况连接起来，连接的边上标上符合之前文法左右括号。最终，数据流分析问题转化成图上的可达性问题，要求路径合法（所有括号符合 Dyck-CFL 文法或者至少符合文法前缀），这个问题称为上下文无关语言可达性问题：
        #definition[上下文无关语言可达性问题][
          给定一个图，图上有标签。给定一个上下文无关文法，问对于给定的起点和终点，是否存在一条路径，使得路径上的标签符合文法。
        ]
        #algorithm[][
          解决该问题的思想是将图可达算法与解析算法结合起来。
          - 首先对产生式变形，使得产生式右侧至多两个符号
          - 对于所有标有非终结符 $A$ 的边，按照以下规则加边：
            - 若有生成式： $A -> epsilon$，则给每个节点加自环，标为 $A$
            - 若有生成式 $A -> B$，则对每个标 $B$ 的边，加一条平行边，标为 $A$
            - 若有生成式 $A -> B C$，则对每对相邻两条分别标为 $B$ 和 $C$ 的边，加一条边连接起点和终点，标为 $A$
          - 不断反复上面的过程，最终停止时若两点间有边则可达
        ]<IFDS-1>
        可以证明，上面的方法满足：
        - 安全性
        - 精确性：一定比 $k$ 次克隆的上下文敏感分析精确
        能够用该方法解决的问题又称为 IFDS 问题，解决框架称为 IFDS 框架或 IFDS 方法。当然在实践中上面的算法并不高效，实践中往往采用之后介绍的优化算法。

        学术界对于上下文敏感分析的精确性的意义有很多讨论。一般认为在面向对象语言中，上下文敏感分析明显更为精确。
        #algorithm[IFDS 方法优化][
          之前的加边算法有以下问题：
          - 往往我们只关心从固定起点开始的路径，上面的方法却考虑了所有路径，大部分都是无效的
          - 两点之间可能有多种路径可达，这些分析都是重复的
          我们可以采用如下策略，简单来说就是以下几种简单的图变换规则
          - 对于起点，添加自环
          - 如果带自环的边与某个节点无标签可达，则两点之间加边
          - 若 $A$ 节点有自环，且有到 $B$ 的边，$B -> C$ 有一次函数调用，则给 $C$ 点添加自环
          - 若 $A, C$ 节点有自环，$A -> B$ 有边，$B -> C$ 是函数调用 $1$，$C -> D$ 有边，$D -> E$ 是函数返回 $1$，则添加边 $A -> D$
        ]<IFDS-2>
        可以证明，@IFDS-1 的复杂度约为 $O(n^3)$，而 @IFDS-2 的复杂度约为 $O(E D^3)$，其中 $E$ 是控制流图的节点数，$D$ 是每个节点展开的图节点数，与抽象域的元素个数有关。像符号分析这种状态数很少的，它的效率就非常高。
      ==== 基于函数摘要的加速技术
        之前的 @IFDS-2 利用了动态规划的思想合并重复计算，本质上还是自底向上的分析，因此也叫 Top-down. 在现代语言中，往往有一个巨大的标准库，我们会需要提前对通用的库函数以函数的级别进行分析。简单来说，我们希望将一个函数调用合并成一个数据流分析中的转换函数。事实上这并不困难，无非是在 IFDS 问题中，先对函数内部节点进行分析，就可以得到局部结果。但在实践上，库函数往往带有极多的全局变量，导致 @IFDS-2 中每个节点的展开数 $D$ 很大，最终算法并不高效。

        在原始的控制流图上，我们也可以直接对转换函数进行合并。此时，我们需要引入函数的 $compose, sup$，并且满足：
        $
          (f compose g) (x) = f(g(x))\
          (f sup g) (x) = f(x) sup g(x)
        $
        在实践上，我们需要建立函数的一个表示 $r: S -> T$，其中 $S$ 是某个可计算的集合，$T$ 是转换函数集合，$r$ 是单射且便于计算，并且：
        $
          f_"unit" in r(S)\
          f_1, f_2 in r(S) => f_1 sup f_2 in r(S)\
          f_1, f_2 in r(S) => f_1 compose f_2 in r(S)
        $ 
        #let gen = $"gen"$
        #let kill = $"kill"$
        在数据流分析的 gen-kill 标准型中，容易计算一个表示：
        $
          (f compose g) (x) &= gen_f union (g(x) - kill_f)\
          &= gen_f union ((gen_g union (x - kill_g)) - kill_f)\
          &= gen_f union (gen_g - kill_f) union ((x - kill_g) - kill_f)\
          &= (gen_f union (gen_g - kill_f)) union (x - (kill_f union kill_g))
        $
        并的计算也是类似的，我们因此我们可以用二元组 $(gen, kill)$ 来表示一个转换函数，运算定义为：
        $
          (gen_1, kill_1) compose (gen_2, kill_2) = (gen_1 union (gen_2 - kill_1), kill_1 union kill_2)\
          (gen_1, kill_1) sup (gen_2, kill_2) = (gen_1 union gen_2, kill_1 sect kill_2)
        $

        事实上，计算进入节点到当前节点转换函数的表示本身也是标准的数据流分析，对于循环的处理方式也可以采用与数据流分析完全相同的方式，也即计算一个不动点。更进一步，它是满足单调性和分配性（因此等价于分别计算每一条路径，也就意味着与原来数据流分析相比是完全精确的）

        对于过程间调用，也可以采用过程间一般分析的思想，作出 super-CFG。特别的，在这个问题中我们讨论的是转换函数本身，上下文不起作用，因此不需要考虑上下文敏感性的问题。

      CFL 和函数摘要都可以完成精确的过程间分析。对于输入集合较大，而单个转换函数较小时，函数摘要可能更为高效。同时，基于摘要的方法往往只能获得出口的信息，不太好获得中间点的信息。
      
  == 过程内指针分析
    === 指向分析
      指针分析中，最基本的是指向分析，也就是分析两个指针可能指向的地址。假设先不考虑堆上的内存，也不考虑结构体，数组等复杂结构
      #example[][
        ```c
        o = &v;
        q = &p;
        if (a > b)
        {
          p = *q;
          p = o;
        }
        *q = &w;
        ```
      ]
      #let ba = $bold(a)$
      #let bb = $bold(b)$
      #let bv = $bold(v)$
      #algorithm[Anderson][
        Anderson 算法是最基本的流非敏感指针分析算法，它的基本思想是，对于每个指针，维护一个可能指向的地址集合。对于每个基本的赋值语句，我们可以得到一个不等式：
        - `a = &b` : ${b} <= ba$
        - `a = b` : $bb <= ba$
        - `a = *b` : $forall bv in bb, v <= ba$
        - `*a = b` : $forall bv in ba, bb <= v$
        对于一个具体程序，我们可以得到一个不等式系统。进一步，按照以下规则，对于某个变元 $p$，产生标准的迭代式：
        - 若不等式系统包含 $o <= p$，则 $p = p union o$
        - 若不等式系统包含 $forall v in q, v <= p$，则 $p = p union (union_(v in q) v)$
        - 若不等式系统包含 $forall v in p, q <= v$，则 #TODO
        接下来，迭代求解即可。实际上，我们可以把所有变量和原子都构造节点，有依赖关系的连边，按照 worklist 算法更新即可。总复杂度约为 $O(n^3)$

        实践中，有一个非常实用的优化：上面的图中，强连通子图的节点之间集合必然是相等的，因此整个强连通子图可以缩成一个节点。
      ]
      #algorithm[流敏感的指针分析][
        流敏感的指针分析是按数据流分析的思路进行设计，转换函数为：
        - `a = &b` : $f(V) = V[bv -> {b}]$
        - `a = b` : $f(V) = V[ba -> bb]$
        - `a = *b` : $f(V) = V[ba -> union_(v in bb) v]$
        - `*a = b` : $f(V) = forall v in ba, V[v -> bb union V[v]]$
        最后一条规则也可以加强为当 $abs(ba) = 1$ 时，将其直接赋值为 $bb$

        实践中往往不会采用这样的指针分析，而是后面介绍的稀疏分析。
      ]

      接下来，我们考虑堆上分配的内存。显然这样的内存分配是动态的，不可能考虑所有的可能分配。为此，我们将其抽象为在某个语句位置分配的地址。

      此外，当考虑结构体时，我们可以采用：
      - 域非敏感分析：不区分结构体的不同域，将所有域看作一个整体
      - 基于域的分析：不区分结构体的不同对象，但区分结构体的不同域
      - 域敏感分析：区分结构体的不同域，将结构体的不同域拆成不同的地址

      接下来，比较复杂的结构还有数组和指针运算。对于数组，我们可以采用：
      - 数组粉碎：直接用一个抽象值描述数组中所有值，被广泛使用于指针分析
      - 数组扩展：为每一维建立一个变量保存抽象值，也可以只保留至多 $k$ 个抽象值。这种方法必须先通过区间分析得到索引的范围。
      - 数组分区：抽象为从索引区间到抽象值的映射，和上一种类似，只是在数组的不同分区情况不同时才分裂。

      对于指针运算，大部分实践中的分析工具索性不支持，直接返回 unsound。部分分析可能对特定形式的指针运算做处理，例如单独处理 $*(p + exp)$ ，直接将其视作数组。

      指向分析一个实用的目的是用于别名分析。一般的，别名分析导出如下结果：
      - must aliases：一定指向同一地址，如果指向分析导出 $ba = bb and abs(ba) = abs(bb) = 1$
      - must not aliases：一定不指向同一地址，如果 $ba sect bb = emptyset$
      - may aliases：可能指向同一地址
    === 其他指针分析
      ==== CFL 指针分析
        上面介绍的 CFL 可达性的思想也可以用于域敏感分析，基本思想是对一个域的读和写应该成对出现，因此可以设计文法，只有匹配的读写才是可能的值传播途径。
      ==== Steensgaard 指向分析
        Anderson 指向分析中，只有确定了两个节点之间强可达才合并，这是是精确的，但效率不高，复杂度约为 $O(n^3)$。Steensgaard 指向分析则是将所有可达节点都合并（换言之，将一个指针可能指向的所有值全部合并），复杂度大大降低。这种方法被称为 
  == 过程间指针分析
    === 域敏感与上下文敏感
      已经证明，域敏感，上下文敏感的指向分析是不可判定的。简单来说，上下文敏感性、域敏感性是独立的上下文无关属性，我们希望同时满足这两个属性，也就是两个上下文无关文法的交，它未必是上下文无关文法。因此，我们只能采用近似方法，包括：
      - 降低上下文敏感性，将上下文展开 $k$ 次
      - 降低域敏感性。具体而言，对于通常的约束 $p in o$，可以将其画在可达性图上，但对于含有全称量词的约束 $forall x in a, x."next" subset b$，则必须进行近似处理。最粗糙的方式是，将所有对域的访问（包括 `*`）合并成一个，进行完全域非敏感分析。同时，我们还可以展开 $k$ 次，也就是对于访问链：
      ```c
      a -> next -> next -> ...
      ```
      只对前 $k$ 次进行建模，而将之后的访问合并。例如假设 `a, b` 是链表节点，则 $a = b$ 产生：
      - $b subset a$
      - $b-> "next" subset a -> "next"$
      - $a -> "next" subset b -> "next"$
      $a->"next" = b$ 产生：
      - $b subset a -> "next"$
      - $a -> "next" subset b -> "next"$
      - $b -> "next" subset a -> "next"$
      （这里后两个约束来自于我们将两次访问直接合并成一次）

      目前学术界对于域敏感和上下文敏感的权衡的研究并不多。主流框架更多采用精确域敏感性，用克隆接近上下文敏感性。
    === 函数指针分析
      一旦涉及函数指针，控制流图就无法直接给出，必须要先进行指针分析。这就导致指针分析和控制流图的构造必须同步进行。当函数调用目标不能确定时，就需要额外进行确定调用目标的分析，也就是产生控制流图，这种分析称为控制流分析。
      - Class Hierarchy Analysis：在面向对象语言中，类的继承关系可以帮助确定调用目标。例如 `A` 的所有子类为 `B`, `C`，则 `A` 的函数调用无非只可能是 `B` 或 `C` 的函数调用。这种分析非常简单快速，但非常不精确，尤其是 `Object.equals()` 这种大量派生的函数
      - Rapid Type Analysis：类似 CHA，但只考虑在程序中可能创建而对象，可以有效过滤掉库函数中大量的派生函数。实际执行时，同时维护 Method, Calls, Classes 三个集合。Classes 指可能创建对象的类，Calls 指可能的函数调用，Method 指可能调用的过程，反复更新三者直至收敛。
      以上两种分析非常简单，但不够精确。接下来介绍一种精确的分析方法，学术界往往也称之为 CFA-算法。具体而言，假设 `f` 函数中有如下调用：
      ```java
      x = y.g(a, b)
      ```
      则产生约束：
      $
        forall y in y_f, &forall m in "targets" (y, g):\
        &"ret"_m subset x_f\
        &"filter"(y_f, "declared"(m)) subset "this"_m\
        &f_a subset a_m\
        &f_b subset b_m
      $
      用类似 Anderson 算法的方法求解这个约束即可。这个方法是上下文不敏感的，如果需要敏感可以复制 $k$ 次上下文，称为 $k-$CFA。一般认为，C 等命令式语言中流敏感性更加重要，而 Java, C++ 等面向对象语言中上下文敏感性更加重要。主流框架往往倾向于上下文敏感性。
  == 静态单赋值和稀疏分析
    之前介绍的数据流分析大量关于变量中保存了什么值，包括符号分析，区间分析等。标准的分析框架在每个节点都维护一个抽象域，值的变化沿每个边依次传递。然而实际程序中，每个节点中大部分变量根本不会改变，没有必要经过这个节点传递变化情况。
    #definition[定义-使用关系][
      对于特定变量 $x$，如果节点 $A$ 可能改变 $x$ 的值，节点 $B$ 可能使用节点 $A$ 改变后 $x$ 的值，则称 $A$ 和 $B$ 有定义-使用关系。
    ]
    假设我们已经知道了定义-使用关系，我们可以基于此将控制流图转化成定义-使用图，其上只有产生定义使用关系的节点连边（边上标记变量名），每个节点只存储与自己相关的变量抽象值。通常这个图比控制流图稀疏很多，分析效率大大提高。
    
= 基于约束求解的程序分析
  所谓约束求解，就是给定一组约束，检查这组约束是否可满足。如果可满足，尽量给出一组赋值。如果不可满足，尽量给出较小的矛盾集。自然的，绝大多数约束求解都不可判定，但有些子问题是可判定的。实践上的策略往往是尽可能把可判定的子问题组合起来。程序分析中常见的约束求解包括：
  - SAT solver
  - Linear solver
  - Array solver
  - String solver
  == SAT
    SAT （Boolean Satisfiability Problem）是最基本的约束求解问题，也是第一个被证明是 NP 完全的问题。也就是给出一个命题逻辑的公式，检查是否存在一个变量赋值使得公式为真。关于 SAT 的研究已经非常多。历史上 SAT 求解的速度一直很慢，但 2000 年以来速度有了极大地提升，在大多数情境下几乎可以达到线性求解。

    通常来说，SAT 问题往往化归到合取范式，其中每一个子项称为子句，子句中的元素称为文字。解 SAT 的基本方法当然是穷举，但效率较低，实践中会采用多种多样的优化策略：
    === 基础优化
      - 冲突检测：当一个子句中的所有文字都为假时，原问题一定不可满足
      - 赋值推导：若某个子句中，除一个文字外所有文字已经为假，则该文字必然为真。它也等价于另一种推导方式（称为 Unate），也就是直接删去子句中为假的赋值，同时删去已经为真的子句
      以上两种方法组合起来称为 DPLL 算法，在 1962 年被提出。
    === 预处理
      同时，也有一些常用于预处理的技术：
      #definition[归结][
        归结是一个逻辑上的概念。简单来说，假设 $q$ 不在其他子句中出现，则：
        $
        (p_1 or q) and (p_2 or not q) "可满足" <-> p_1 or p_2 "可满足" 
        $
        多子句也可以做类似处理。解 SAT 问题时可以采用归结方法进行预处理。事实上，早期也存在完全基于归结的 SAT 算法，但效率不如 DPLL 算法。
      ]
      以及：
      - Pure literal elimination：如果一个文字只以真或假出现，则包含该变量的子句可以直接删除
      - Equivalent literal elimination：如果两个文字等价，则可以直接删除其中一个
    === 变量选择
      算法中下一步选择的变量对求解器的效率影响很大。目前没有通常的办法，只能采用各种不同的启发式方法：
      - 基于子句集的：优先选择较短子句中的变量
      - 基于历史的：优先选择历史上导致冲突的变量
    === CDCL 冲突导向的子句学习
      2000 年初期，CDCL 算法的提出和实现让 SAT 的速度大幅提升。CDCL 的基本思想是在搜索过程中学习问题的性质，加入约束集合中。具体而言，在 DPLL 搜索过程中，我们可以记录下变量的依赖关系（例如 $1 = T -> 2 = F, 1 = F, 2 = T -> 3 = T$）构成图。执行过程中如果遇到矛盾：
      $
      i = T, i = F
      $
      就立刻检查两个值的前驱节点。矛盾意味着这些前驱节点的值不能都同时成立，必须有一个改变，因此可以创建新的子句，代表这一组值可能产生矛盾。结束之后，直接跳回这些导致矛盾的前驱节点（新加子句相关赋值的倒数第二次位置），重新搜索（实践表明尽管浪费了一些推导，但这样的技巧可以改善启发式选择变量的效果）。

      事实上，这样的方法保证了我们永远不会碰到相同的一组冲突，所以甚至不需要记录之前遍历过的赋值，每次任意选择剩下的变量和赋值即可。最后如果空赋值就能推出不可满足，则判定不可满足，否则继续进行。

      注意在之前的算法中，“选择一组能够推出矛盾赋值的前驱节点”的方法也是任意的。目前常见的策略是先找出唯一蕴含点，也就是最后一次赋值到冲突的所有路径都要经过的节点（包括最后一次赋值自身）。之后，找到距离冲突点最近的唯一蕴含点，切割所有该点的后继节点以及所有通往该点之后的冲突路径的汇入边。这样切割可以保证尽可能小。

      CDCL 还有一些重要的优化：
      - 高效的单元传播检测：单元传播时，需要检测当前单元是否除一个文字之外都为假。简单的方式是记录当前子句为假的文字数量，但这会导致大量遍历。可以设计一种巧妙的数据结构，每个子句设计两个指针指向两个变量，指针全部指向未赋值变量。赋值更新时，指针向后查找到第一个未被赋值变量。如果找不到未被赋值变量，则另一个指针指向的变量立刻可以进行单元传播。回溯时，指针不做任何移动。
      -  VSIDS（Variable State Independent Decaying Sum)：一种新的变量选择策略，包括：
        - 初始时，根据出现次数给变量打分
        - 添加新子句时给其中子句中的变量加分
        - 每隔一段时间把所有变量的分数除以一个常数
    === 另一种方法：本地搜索
      大部分问题 CDCL 表现较好，但有些问题上本地搜索方法更好。其基本思路是，首先先猜测一个解，如果已经满足则结束，否则选择其中某些变量进行翻转。猜测解和翻转的策略是其中的重点，甚至可以借助神经网络进行猜测。
  == SMT
    #definition[可满足性模理论 Satisfiability Modulo Theories][
      通常的程序逻辑中往往还有加减法等函数，不可能不考虑它们的语义。我们称一个公式集是一个理论（Theory），判定在该公式集下公式的可满足性的问题就称为 SMT
    ]
  == 符号执行
= 软件分析应用
  == 程序合成
  == 缺陷分析
  == 缺陷修复