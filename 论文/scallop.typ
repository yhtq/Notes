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

- 深度学习（梯度下降......）和符号推理（Datalog 式的逻辑编程）的结合
- 符号推理是离散的，深度学习需要可微性。将离散问题连续化的一个常见思路就是概率化建模
- 通常的概率建模计算复杂度是指数的，往往不可接受，因此我们需要采用某种替代策略，进行精度与效率的权衡

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

== 概率化建模
  #let tP = $tilde(P)$
  假设 $X$ 是一些离散值（例如 $X = {T, F}$） $X$ 上可以建立概率空间 $cal(X)$，它由一个映射：
  $
    P : X -> [0, 1] with sum_(x in X) P(x) = 1
  $
  唯一决定。显然它也可以由向量 $tP in RR^abs(X)$ 唯一确定，其中#footnote[
  当然实际的深度学习中我们往往不会使用上面这种比较硬的计算。一种替代是 Softmax 函数，但想法是差不多的。
  ]：
  $
    P(x_i) = tP_i / norm(tP)_1
  $
== 概率的传播
  设 $f: X -> Y$ 是函数，显然 $f(cal(X))$ 应该是一个概率空间。其上的概率非常典范的定义为：
  $
    P(y) = sum_(x in Inv(f) (y)) P(x) 
  $
  其中 $Inv(f) (y) = {x in X | f(x) = y}$ ，若 $f$ 已经给定，则它是非常容易计算的。上式右侧无非是一些求和，因此可以继承可微性。
== 二元函数
  设 $f: X times Y -> Z$ 是二元函数，则 $Z$ 上的概率定义为：
  $
    P(z) = sum_((x, y) in Inv(f) (z)) P(x, y)
  $
  公式并没有问题，然而 $P(x, y)$ 的计算并不显然。注意到它不是简单的 $P(x) P(y)$，既然我们很可能不能假设 $cal(X), cal(Y)$ 独立。

  很明显，我们需要更细致地考察命题的构建过程。事实上，如果我们暂时不考虑变元，那么命题无非是：
  - 原子命题
  - 逻辑与
  - 逻辑或
  而我们可以假设，原子命题之间的概率分布是独立的，接下来无非是拆解成原子命题。
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
== 证明的构建
  Scallop 实际上不去建立命题的真值的概率分布，而是建立命题的证明的概率分布。对于任何一个命题 $X$，我们可以把它视作一个类型，其中的值是所有 $X$ 的证明#footnote[原论文实际上没有使用“类型”而是简单的使用集合语言。不过这里也只是换一个术语，应该比集合套集合清晰一些]。自然的，原子命题只有一个证明，而：
  $
  A and B := A tensorProduct B, A or B := A directSum B
  $
  当然，不难验证 $tensorProduct, directSum$ 运算在命题空间上构成半环结构，称为 proof semiring#footnote[原文没有使用这套“命题等同于命题的所有证明”的语言，导致了非常拗口的“命题的所有证明构成的集合上的半环”]。可以想象，Datalog 程序的计算将给出任意一个命题所有证明树，沿着证明树计算最终命题的概率的问题称为 Weighted Model Counting（带权的模型计数），当然这个问题看起来就比 SAT 更难，所以我们需要更有实践性的方案。

