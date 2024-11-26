#import "@preview/touying:0.5.3": *
#import "../template.typ": *
#import themes.simple: *

#show: note.with(
  withChapterNewPage: false,
  withOutlined: false,
  withTitle: false,
  withHeadingNumbering: false,
)
#show: simple-theme.with(aspect-ratio: "16-9")
#set text(size: 20pt)

= Scallop

== 基本思想

- 深度学习（梯度下降......）和符号推理（Datalog 式的逻辑编程）的结合。例如说对于手写公式的求值问题，完全依赖两种模式的其中之一听起来都令人两眼一黑，需要将两者适当的结合起来。
- 符号推理是离散的，深度学习需要可微性。将离散问题连续化的一个常见思路就是概率化建模
- 通常的工作流可能是先识别出符号，再用经典方法求值。但这需要中间变量的数据被显式给出（比如已有大量的图片与其代表的符号的对应），而许多时候中间变量可能是隐式的。同时，这样做也会丢失最后结果的信息反馈。
== #empty
  #align(center)[#commutative-diagram(
  node((0, 0), $"Graph(data)"$, 1),
  node((0, 1), $"Exp(data)"$, 2),
  node((0, 2), $"Res"$, 3),
  node((1, 0), $"Graph(logic)"$, 4),
  node((1, 1), "Exp(logic)", 5),
  arr(1, 2, $partialDer(r, theta)$),
  arr(2, 3, $partialDer(y, r)$),
  arr(4, 5, $$),
  arr(5, 3, "RL", label-pos: right),
  arr(1, 4, $$),
  arr(2, 5, "Repr", label-pos: right),
  )]
  这里: 
  - $partialDer(r, theta)$ 代表已有的深度学习框架的学习机制，而 $partialDer(y, r)$ 是需要设计的 differential reasoning engine
  - Repr 是数据的表示
  - RL (Reasoning Language) 是基于表示进行推理的逻辑语言

== #empty
  因此主要工作就分成三部分：
  - 数据表示：关系型
  - 推理语言：基于 Datalog，支持递归，否定和聚合
  - 自动微分引擎：provenance semiring 和近似算法的概率计算
== 例子
  ```rust
  // Knowledge base facts
  rel is_a("giraffe", "mammal")
  rel is_a("tiger", "mammal")
  rel is_a("mammal", "animal")

  // Knowledge base rules
  rel name(a, b) :- name(a, c), is_a(c, b)

  // Recognized from an image, maybe probabilistic
  rel name = {
    0.3::(1, "giraffe"),
    0.7::(1, "tiger"),
    0.9::(2, "giraffe"),
    0.1::(2, "tiger"),
  }

  // Count the animals
  rel num_animals(n) :- n = count(o: name(o, "animal"))
  ```
== provenance
  某种意义上，程序的执行结果就是函数值，而如果我们做微分，就要对函数的执行做出拓展。Scallop 将程序计算的代数结构抽象为一个 provenance，也就是包含以下运算：
  $
    directSum, tensorProduct, minus.circle, eq.circle
  $
  以及 $0, 1$ 的代数结构。其中 $directSum, tensorProduct, 0, 1$ 构成半环（同时为了递归的安全，还需要额外的 absorptive），negation, saturation 也要满足一些性质。provenance 中的元素称为 tag，类似于概率的推广。

  有了这些定义，我们就可以在更加广泛的意义下去执行 Datalog 程序。Scallop 会先转换成 low-level representation *SclRam* ，程序的输入被称为 extensional database（EDB），最终的执行结果称为 intentional database（IDB）。provenance 既实现了普通的 Datalog 执行，也实现了概率化的 Datalog 程序以及梯度的传播。（当然每个具体的实现都会基于一些比较复杂的算法）。
  #image("./屏幕截图 2024-11-15 173540.png") 
  其中 $sigma_beta$ 是用 $beta$ 筛选，$pi_alpha$ 是用 $alpha$ 做 map, $gamma_g$ 指用 $g$ 做 aggregation。当然，如果没理解错的话这应该只是个理论模型，实际实现很大程度上还是一种 provenance 对应一种算法。
== 集成其他模型
  似乎 AI 那边认为语言模型从自然语言中产生结构化数据的能力还不错，同时其他模型很多直接输出的就是结构化数据，因此可以基于 Scallop 的概率计算能力，将这些模型作为一个纯函数集成在内，再通过 Scallop 的逻辑能力进行计算（而不是让语言模型直接输出结果）。这样就可以在一个统一的框架下进行推理，甚至集成多个不同的模型。
```Datalog
type Expr = Const(f32) | Add(Expr, Expr) | Sub(Expr, Expr) | Mult(Expr, Expr) | Div(Expr, Expr)

type eval(bound e: Expr, v: f32)
rel eval(e, v) = case e is Const(v)
rel eval(e, v1 + v2) = case e is Add(e1, e2) and eval(e1, v1) and eval(e2, v2)
rel eval(e, v1 - v2) = case e is Sub(e1, e2) and eval(e1, v1) and eval(e2, v2)
rel eval(e, v1 * v2) = case e is Mult(e1, e2) and eval(e1, v1) and eval(e2, v2)
rel eval(e, v1 / v2) = case e is Div(e1, e2) and eval(e1, v1) and eval(e2, v2)

@gpt(
    prompt="""
Suppose we have the following symbolic expression language:

Expr ::= Const(float) | Add(Expr, Expr) | Sub(Expr, Expr) | Mult(Expr, Expr) | Div(Expr, Expr)

Please semantically parse the following question into a symbolic expression:

Question: {{x}}
Symbolic Program: {{y}}
""",
    examples=[
        (
            "Natalia sold clips to 48 of her friends in April, and then she sold half as many clips in May. How many clips did Natalia sell altogether in April and May?",
            "Add(Const(48), Mult(Const(0.5), Const(48)))"
        ),
        // (
        //     "Lisa, Jack, and Tommy earned $60 from washing cars all week. However, half of the $60 was earned by Lisa. Tommy earned half of what Lisa earned. How much more money did Lisa earn than Tommy?",
        //     "Sub(Mult(Const(0.5), Const(60)), Mult(Const(0.5), Mult(Const(0.5), Const(60)))"
        // ),
        // (
        //     "Arnel had ten boxes of pencils with the same number of pencils in each box.  He kept ten pencils and shared the remaining pencils equally with his five friends. If his friends got eight pencils each, how many pencils are in each box?",
        //     "Add(Const(10), Mult(Const(5), Const(8)))"
        // ),
        // (
        //     "Colton had 72 dolphin stickers. He gave 4 stickers each to 3 friends.  He also gave his friend Mandy 2 more than he gave his three friends total.   And he gave Justin 10 less than Mandy.  How many stickers does Colton have left?",
        //     "Sub(Sub(Sub(Const(72), Mult(Const(4), Const(3))), Add(Const(2), Mult(Const(4), Const(3)))), Sub(Add(Const(2), Mult(Const(4), Const(3))), Const(10)))"
        // ),
    ],
    model="gpt-4",
    debug=true,
) 
type semantic_parser(bound x: String, y: Entity)

type question(ctx: String)

rel parsed_expr(s) = question(q) and semantic_parser(q, s)
rel result(v) = parsed_expr(e) and eval(e, v)

query result
```
// == 概率化建模
//   #let tP = $tilde(P)$
//   假设 $X$ 是一些离散值（例如 $X = {T, F}$） $X$ 上可以建立概率空间 $cal(X)$，它由一个映射：
//   $
//     P : X -> [0, 1] with sum_(x in X) P(x) = 1
//   $
//   唯一决定。显然它也可以由向量 $tP in RR^abs(X)$ 唯一确定，其中#footnote[
//   当然实际的深度学习中我们往往不会使用上面这种比较硬的计算。一种替代是 Softmax 函数，但想法是差不多的。
//   ]：
//   $
//     P(x_i) = tP_i / norm(tP)_1
//   $
// == 概率的传播
//   设 $f: X -> Y$ 是函数，显然 $f(cal(X))$ 应该是一个概率空间。其上的概率非常典范的定义为：
//   $
//     P(y) = sum_(x in Inv(f) (y)) P(x) 
//   $
//   其中 $Inv(f) (y) = {x in X | f(x) = y}$ ，若 $f$ 已经给定，则它是非常容易计算的。上式右侧无非是一些求和，因此可以继承可微性。
// == 二元函数
//   设 $f: X times Y -> Z$ 是二元函数，则 $Z$ 上的概率定义为：
//   $
//     P(z) = sum_((x, y) in Inv(f) (z)) P(x, y)
//   $
//   公式并没有问题，然而 $P(x, y)$ 的计算并不显然。注意到它不是简单的 $P(x) P(y)$，既然我们很可能不能假设 $cal(X), cal(Y)$ 独立。

//   很明显，我们只能更细致地考察命题的构建过程，自底向上的计算概率分布。事实上，如果我们暂时不考虑变元，那么命题无非是：
//   - 原子命题
//   - 逻辑与
//   - 逻辑或
//   而我们可以假设，原子命题之间的概率分布是独立的，接下来无非是拆解成原子命题。
// == 带标签的概率传播
  
// == Sentential Decision Diagram
//   // 考虑以下的程序：
//   // ```rust
//   // rel 0.2::A()
//   // rel 0.1::B()
//   // rel C() = A() or B()
//   // rel D() = A() or C()
//   // ```
//   // 可以画出下面的依赖图：
//   // #align(center)[#commutative-diagram(
//   // node((3, 2), $A$),
//   // node((3, 0), $B$),
//   // node((3, 1), $A times B$),
//   // node((2, 2), $A times C$),
//   // node((2, 1), $C$),
//   // node((1, 1), $D$),
//   // arr($A times B$, $A$ ,$$),
//   // arr($A times B$, $B$ ,$$),
//   // arr($A times B$, $C$ ,$or$),
//   // arr($A times C$, $A$ ,$$),
//   // arr($A times C$, $C$ ,$$),
//   // arr($A times C$, $D$ ,$or$),
//   // )
//   // ]
//   #image("./屏幕截图 2024-11-06 204619.png")
//   简单来说就是把所有东西拆成若干原子命题之间的演算即可
// == 证明的构建
//   Scallop 实际上不去建立命题的真值的概率分布，而是建立命题的证明的概率分布。对于任何一个命题 $X$，我们可以把它视作一个类型，其中的值是所有 $X$ 的证明#footnote[原论文实际上没有使用“类型”而是简单的使用集合语言。不过这里也只是换一个术语，应该比集合套集合清晰一些]。自然的，原子命题只有一个证明，而：
//   $
//   A tensorProduct B := A and B = A times B, A directSum B := A or B = A + B
//   $
//   当然，不难验证 $tensorProduct, directSum$ 运算在命题空间上构成半环结构，称为 proof semiring。可以想象，Datalog 程序无非是由原子命题和 $tensorProduct, directSum$ 构成的表达式，因此我们可以得到析取范式：
//   $
//     P = directSum_j (tensorProduct_i A_(i j))
//   $
//   其中 $A_(i j)$ 是一些原子命题，根据 $A_(i j)$ 的概率计算 $P$ 的概率的问题称为 WMC（Weighted Model Counting）问题。当然这个计算过程听起来复杂度就是指数级的，因此需要一些近似算法。
// == top-k
//   上面的思路无非是用逻辑演算构造一个分类问题，而分类问题中我们可以期望概率分布是相当不平衡的，大部分概率集中在少数几个类别上。因此，我们可以只考虑那些概率比较大的证明。具体来说，在上一页的公式中，我们可以只考虑 $P$ 中概率最大的 $k$ 个证明，这样就得到了 top-k 算法。换言之，重新定义：
//   $
//     A tensorProduct B := "Top"_k (A and B) , A directSum B := "Top"_k (A or B) 
//   $
//   可以证明这样定义的运算仍然构成半环，因此可以在其上高效地计算 WMC
// == 梯度传播
//   可以想象梯度的计算和概率的计算应该是一体的。因此为了能够计算梯度，只需要在计算概率的同时再加一个梯度的记录即可，论文中将其称为 _gradient semiring augmented WMC procedure_
