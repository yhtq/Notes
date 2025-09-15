#import "../template.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "同调代数",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let Set = $bold("Set")$
#let Top = $bold("Top")$
#let Grp = $bold("Grp")$
#let Ab = $bold("Ab")$
#let kVect(k) = $bold(k - "Vect")$
#let Ring = $bold("Ring")$
#let calu = $cal("u")$

= 范畴论
  == 范畴
    #definition[子范畴][
      设 $C, D$ 是范畴，如果 $C$ 的对象集，态射集都是 $C$ 的子集，则称 $C$ 是 $D$ 的子范畴
    ]
    #definition[单/满态射][
      设 $f : A -> B$ 是范畴 $C$ 中的态射，如果：
      - 对任意 $g, h : X -> A$，$f compose g = f compose h$ 蕴含 $g = h$，则称 $f$ 是单态射
      - 对任意 $g, h : B -> X$，$g compose f
        = h compose f$ 蕴含 $g = h$，则称 $f$ 是满态射
    ]
  == 极限
    #definition[（余）极限][
      设 $C, D$ 是范畴，$F : C -> D$ 是函子。称 $F$ 的（余）极限是一个 $D$ 中对象 $L$，使得 $D$ 是唯一一个满足：
      - （余极限）：存在唯一 $L$，对所有图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $F C_1$, 1),
        node((0, 1), $F C_2$, 2),
        node((1, 0), $L$, 3),
        node((1, 1), $N$, 4),
        arr(1, 2, $F f$),
        arr(3, 1, $$),
        arr(3, 2, $$),
        arr(4, 3, $exists !$, dashed_str),
        arr(4, 2, $$),
        arr(4, 1, $$)
        )]
        均成立
      - （极限）：存在唯一 $L$，对所有图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $F C_1$, 1),
        node((0, 1), $F C_2$, 2),
        node((1, 0), $L$, 3),
        node((1, 1), $N$, 4),
        arr(1, 2, $F f$),
        arr(1, 3, $$),
        arr(2, 3, $$),
        arr(3, 4, $exists !$, dashed_str),
        arr(2, 4, $$),
        arr(1, 4, $$)
        )]
        均成立
    ]
    #definition[积][
      设 $A, B$ 是范畴中两个对象，所有对象 $C, C'$ 配上态射使得：
      
      #diagram(cell-size: 15mm, $
        C edge(->) edge("d", ->) edge("rd", ->) & C' edge("ld", ->) edge("d", ->)\
        A & B \
        \
      $)

      交换，则其极限称为 $A$ 和 $B$ 的积，记作 $A times B$，全部反向则称为余积
      
    ]
    #definition[等化子][
      假设 $f, g : A -> B$ 是两个态射，所有对象 $C, C'$ 配上态射使得：

      #diagram(cell-size: 15mm, $
        C edge(->) edge("d", ->) & C' edge("dl", ->) \
        A edge(=>, f\, g) & B \
      $)
      均交换，则其极限称为 $f$ 和 $g$ 的等化子，全部反向则称为余等化子。
    ]
  == 函子
    #example[][
      - $Hom(X, *)$ 是协变函子，$Hom(*, X)$ 是反变函子
    ]
    #definition[自然变换（函子范畴的态射）][
      称 $epsilon : F -> G$ 是函子 $F, G$ 的自然变换，如果所有 $X ->^f Y$ 均有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $F X$, 1),
      node((0, 1), $G X$, 2),
      node((1, 0), $F Y$, 3),
      node((1, 1), $G Y$, 4),
      arr(1, 2, $epsilon$),
      arr(1, 3, $F f$),
      arr(2, 4, $G f$),
      arr(3, 4, $epsilon$),)]
      如果所有的 $epsilon$ 都同构，则称 $epsilon$ 是自然同构
    ]
    #example[][
      - $k-$ 维线性空间范畴中，从 $id$ 到双对偶函子 $V -> duelSpace(duelSpace(V))$ 存在自然态射，其中 $epsilon (v : V)= (f : duel(V)) |-> f v$，验证交换性：
      $
        (epsilon compose f)(x) = epsilon (f(x)) = g |-> g(f(x))\
        (duel(duel(f)) compose epsilon)x g = (duel(duel(f)))(epsilon(x))g = (h |-> h compose duel(f) )(epsilon(x))g = (epsilon(x) compose duel(f)) g = epsilon(x) (g compose f) = (g compose f)(x)
      $ 
    ]
    #lemma[Yoneda][
      任给范畴 $cal(u), A : calu$ 和 $F : calu -> Set$，$Hom(A, *)$ 到该函子的所有态射可以被确定下来。事实上：
      $
        Hom(Hom(A, *), F) eqv F A
      $
    ]
    #proof[
      一方面，给定 $a in F A$，我们构造 $epsilon : Hom(Hom(A, *), F)$，相当于：
      - 对任何 $B$ 建立态射 $eta_B : Hom(A, B) -> F B = k |-> (F k)a$
      - 验证交换性：给定 $f : B -> C$，计算：
        #align(center)[#commutative-diagram(
        node((0, 0), $Hom(A, B)$, 1),
        node((0, 1), $F B$, 2),
        node((1, 0), $Hom(A, C)$, 3),
        node((1, 1), $F C$, 4),
        arr(1, 2, $eta_B$),
        arr(1, 3, $Hom(A, f)$),
        arr(2, 4, $F f$),
        arr(3, 4, $epsilon$),)]
        $
          (eta compose Hom(A, f))x = eta(Hom(A, f) x) = eta(f compose x) = (F(f compose x)) a 
        $

      事实上，上面定义的映射是满的。给定 $epsilon : Hom(Hom(A, *), F)$，需要构造 $a in F A$ 使得 $eta_a = epsilon$. 注意到交换图表：
      #align(center)[#commutative-diagram(
        node((0, 0), $Hom(A, A)$, 1),
        node((0, 1), $F A$, 2),
        node((1, 0), $Hom(A, B)$, 3),
        node((1, 1), $F B$, 4),
        arr(1, 2, $epsilon$),
        arr(1, 3, $Hom(A, f)$),
        arr(2, 4, $F f$),
        arr(3, 4, $epsilon$),)]
    ]
    取 $id : A -> A$ 可以看出：
    $
      epsilon (Hom(A, f) compose id) = epsilon(f) = (F f)(epsilon(id))  
    $
    对任何 $f$ 都成立。换言之：
    $
      
    $
  == presheave, sheaves
    #let Open(X) = $bold("Open")(#X)$
    #definition[预层][
      设 $X$ 是拓扑空间，$Open(X)$ 是其开集构成的范畴，态射是包含映射。称反变函子 $F : Open(X) -> C$ 是 $C$-index 预层。通常的，记：
      $
        rho_(V U)^F = F(U -> V) : F V -> F U
      $
    ]
    #definition[层][
      若 $F : Open(X) -> C$ 是 $C$-index 预层， $C$ 是集合范畴的子范畴。称其为 $X$ 上的层，如果以下性质成立：
      - 任给 $U in Open(X)$ 及其开覆盖 $U_i subset U$，任取 $s, t in F U$，只要 $s|_U_i = t|_U_i$ 对所有 $i$ 成立，则 $s = t$
      - 任给 $U in Open(X)$ 及其开覆盖 $U_i subset U$，任取 $s_i in U_i$ 使得 $s_i|_(U_i inter )$
    ]

