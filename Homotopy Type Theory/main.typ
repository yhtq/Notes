#import "../template.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/curryst:0.5.0": rule, prooftree
#show: note.with(
  title: [HOTT #link("https://scripta.io/c/id-ab970eb8-da21-44eb-a09e-ab7053420579")[(reference)]],
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
// #set text(font: "Noto Serif CJK SC", lang: "zh")
// #show emph: it => {
//     text(it, weight: "bold")
//   }
// #set par(justify: true, first-line-indent: (
//       amount: 22pt,
//       all: false
//     ))
// #set par(spacing: 1.2em)
// #show math.equation: set text(font: ("Noto Serif CJK SC", "New Computer Modern Math"))
// #show math.equation: it => {
//     show block: set align(center)
//     it
//     }
#let Term = "Term"
#let Type = "Type"
#let hasType(tm, ty) = $#tm \: #ty$
#let formula(x) = $#x$
#let evalTo = math.arrow.squiggly
= Martin-Löf Type Theory
  == 形式系统
    作为例子，我们定义最简单的自然数的形式系统：
    $
      prooftree(
        rule(
          NN\: "type"
        )
      )
      prooftree(
        rule(
          "zero"\: NN
        )
      )
      prooftree(
        rule(
          "succ" k\: NN,
          k\: NN
        )
      )
    $
    常用的形式系统是 Lambda Calculus，它包括：
    - 自由变元 $x_i$
    - 生成规则：
      $
        prooftree(
        rule(
          x_i \: Term
        )
      )
      $
      $
        prooftree(
        rule(
          hasType(lambda x_i. t, Term),
          hasType(t, Term),
        )
      )
      $
    - $beta-$reduction:
      $
        (lambda x_i. t) v evalTo t[x_i := v]
      $
    以及 Simple Typed Lambda Calculus，它包括：
    - 自由变元 $x_i$
    - 原子类型 $A_i$
    - 类型规则：
      $
        prooftree(
          rule(
            hasType(A_i, Type)
          )
        )
        prooftree(
          rule(
            hasType(A -> B, Type),
            hasType(A, Type),
            hasType(B, Type),
          )
        )
        prooftree(
          rule(
            hasType(lambda x. b, A -> B),
            hasType(x : A tack b, B),
            hasType(B, Type),
          )
        )
        prooftree(
          rule(
            hasType(f, A -> B),
            hasType(x, A),
            hasType(f B, B),
          )
        )
      $
    Martin-Löf Type Theory 的规则很多，可以参考 #link("https://ncatlab.org/nlab/show/Martin-L%C3%B6f+dependent+type+theory")[ncatlab]
  == 宇宙
    由于类似罗素悖论的存在，我们不能希望一个类型的类型是 $Type$，只能将类型分成不同的层级：
    $
      u_0 : u_1 : u_2 : ... : u_n : ... 
    $
    以及以下规则：
    $
      prooftree(
        rule(
          hasType(NN, u_0)
        )
      )\
      prooftree(
        rule(
          hasType(A -> B, u_n),
          hasType(A, u_n),
          hasType(B, u_n),
        )
      )\
      prooftree(
        rule(
          hasType(A, u_m),
          hasType(A, u_n),
          formula(n < m),
        )
      )\
    $
    #definition[Type family][
      设 $A :u_(n + 1)$，注意到 $u_n : u_(n + 1)$，由上面的规则可以得到：
      $
        A -> u_n : u_(n + 1)
      $
      这样的 type 被称为 type family
    ]
    // ```haskell
    // Variable := Text
    // AbstractVariable := Text -- Most of time, `AbstractVariable` is exactly one logical term. But in loop, it' s actually `any possible value` in this loop 
    // BoolOp := LT | GT | LE | GE | EQ
    // NumOp := Add | Sub 
    // NumExp := NumOp NumExp NumExp
    //   | Var Variable
    //   | RawInt Int

    // BoolExp := BoolOp NumExp NumExp
    //   | Not BoolExp
    //   | Imply BoolExp BoolExp
    //   | RawBool Bool

    // Program := Skip
    //   | Assign Variable NumExp
    //   | If BoolExp Program Program
    //   | While BoolExp BoolExp Program -- the first BoolExp is the condition, the second is the loop invariant
    //   | Seq Program Program
    
    // Context = {
    //   values : Set AbstractVariable,
    //   variableValues : Map Variable AbstractVariable,
    //   propositions : Set BoolExp
    // }
    // ```
  
  == Identity type
    #let sep(..xs) = xs.pos().join($space$)
    在 MLTT 中，最基本的 Identity type （即类型 $x = y$），是尤为重要的。Identity type 的 elimination rule 表明，如果我们能够定义：
    $
      sep(f, x, x) "refl"\
    $
    我们就可以定义：
    $
      f space x space y space (p : x = y)
    $
    继而，我们有以下事实：
    - symm: $(sep(x, y) : A) -> (x = y) -> (y = x)$
    - trans: $(sep(x, y, z) : A) -> (x = y) -> (y = z) -> (x = z)$
    - congr: $(f : A -> B) -> (sep(x, y) : A) -> (x = y) -> (f x = f y)$
    它们都可以比较简单的推导出来。
    #example[][
      证明 $(n : NN) -> n + 0 = n$：

      由 $NN$ 的 elimination rule，只需证：
      - $0 + 0 = 0$ 使用 refl 即可
      - $(n + 1) + 0 = (n + 1)$，我们有： 
        - refl $: (n + 1) + 0 = n + (1 + 0)$
        - refl $: 1 + 0 = 1$
        - congr $:n + (1 + 0) = n + 1$
        - trans $: (n + 1) + 0 = n + 1$
    ]
    #example[][
      在通常的类型论视角下，$n + 0$ 与 $0$ 是定义相等的，但 $0 + n$ 与 $0$ 却不是，它只是一个非空的类型。
    ]
    #definition[][
      称类型系统中的 Identity Type 是 UIP 的，如果成立 $forall u, A : u -> (x y : A) -> (p q : x = y) -> (p = q)$，换言之，所有的 Identity Type 都至多只有一个元素。

      称类型系统是 K 的，如果成立：
      $
        forall x, (t : x = x): t = "refl"
      $
    ]
    #remark[][
      很长一段时间，人们试图在 Martin-Löf Type Theory 中证明 UIP，但利用模型论证明了，K 和 UIP 是独立于 MLTT 的，不难发现 K 比 UIP 更弱。一方面，人们可以假设 UIP 成立，得到 MLTT + UIP；另一方面，人们为 MLTT 加上了 univalence axiom，就得到了 Homotopy Type Theory (HoTT)，不过 univalence axiom 与 UIP 是不相容的。

    ]
    #definition[][
      称类型 $A$ 是 Set 的，如果类型：
      $
        "Set"(A) = (x y : A) -> (p q : x = y) -> (p = q)
      $
      非空
    ]
    #definition[Decideable Equality][
      称类型 $A$ 是 Decidable Equality 的，如果类型：
      $
        "decEq"(A) = (x y : A) -> (x = y) + (x eq.not y)
      $
      非空
    ]
    #lemma[][
      - 有限类型都是 Decidable Equality 的
      - 若 $A, B$ 是 Decidable Equality 的，则 $A times B, A + B$ 都是，但 $A -> B$ 未必
    ]
    #theorem[][
      若 Decidable Equality 对 $A$ 成立，则 Set 也对 $A$ 成立
    ]
    #lemma[][
      $NN$, Bool 都具有 Decidable Equality，进而是 Set 的
    ]
  == 排中律 (Law of Exclude Middle, LEM)
    在直觉主义逻辑中，排中律是无法证明的。事实上，我们可以找到一个直觉主义的模型使得排中律不成立。
    #definition[Heyting algebra][
      Heyting algebra 是一种逻辑系统的模型。具体来说，定义赋值函数 $v : cal(L) -> T$，$T$ 是拓扑空间，其中：
      - $v("True") = top$
      - $v(p or q) = v(p) union v(q)$
      - $v(p and q) = v(p) inter v(q)$
      - $v(not p) = (RR - v(p))^o$
      - $v(p -> q) = v(not p or q)$
      这种赋值下，所有命题对应的集合都是开的。
    ]
    在上面的赋值下，如果取 $T = RR, v(p) = {x > 0}$，可以计算得 $v(p or not p) = {x != 0} != v("True")$，因此该模型下排中律不成立。
  == Homotopy, Univalence
    #definition[][
      - 称 $f tilde g$ 或者 $f$ 与 $g$ 同伦，如果：
        $
          (f tilde g) : (x : A) -> (sep(f, x) =sep(g, x))
        $
        非空
      - 若存在 $f : A -> B, g : B -> A$ 满足：
        $
          f compose g tilde id\
          g compose f tilde id
        $
        则称 $A$ 与 $B$ 同伦等价，或记 $A eqv B$
    ]
        #let transport = "transport" 
    #example[][
      设 $A$ 是一个类型，若以其中的 term 作为对象，对象之间的相等类型的元素作为态射，则这自然构成一个范畴。UIP 成立时，每两个对象之间至多有一个态射，而 univalence axiom 成立时，两个对象间可能有不同的态射。

      在这样的定义下，$f : A -> B$ 自然的产生一个函子 $A -> B$，其中态射上的映射由 congr 给出。
    ]
    #definition[Transport][
      我们可以定义：
      $
        transport : {A : u} -> {P : A -> u} -> {sep(x, y) : A} -> (p : x = y) -> (sep(P, x) -> sep(P, y))
      $
      使用 Identity type 的 elimination，定义：
      $
        transport "refl" := id      
      $
      特别的，可以定义：
      $
        "idToEquiv" : {sep(A, B) : u} -> (A = B) -> (A eqv B)
      $
    ]
    #lemma[][
      transport 具有函子性，也即:
      - $transport ("refl") ~ id$
      - $transport (p compose q) ~  (transport q) compose (transport p)$
    ]
    #definition[Univalence Axiom][
      Univalence Axiom 是指，存在一个函数：
      $
        "ua" : u -> (sep(A, B) : u) -> (A eqv B) -> (A = B) 
      $
      使得：
      $
        "ua" compose "idToEquiv" = id\
        "idToEquiv" compose "ua" = id
      $
      它和 Martin-Löf Type Theory 是相容且独立的。
    ]
    #lemma[][
      在 Homotopy type theory 中，宇宙不是 Set
    ]

  == Curry-Howard correspond
    HOTT 为通常的 Curry-Howard correspond 提供了新的拓扑的视角。
    #align(center, table(
      columns: 2,
      [*Type Theory*], [*Topology*],
      [Type A], [Space A],
      [Term], [Point],
      [Identity Type], [Path in Topology space], 
    ))

    #definition[广群/Groupoid][
      称一个范畴是广群，如果态射都是同构，也即所有态射都存在逆态射。
    ]
    #example[][
      假设群 $G$ 作用在 $X$ 上，以对象为 $X$，态射为 $G$ 的元素在该对象上的所有作用，则该范畴是广群。
    ]
    #definition[Homotopy Hypothesis][
      Grothendieck 提出的 Homotopy Hypothesis 认为，拓扑空间都可以用无穷广群来表示。
    ]