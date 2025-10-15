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
（考试不太会有具体例子）
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
    #definition()[][
      - 称对象 $I$ 是始(Initial)对象，如果对任意对象 $A$，存在唯一态射 $I -> A$
      - 称对象 $T$ 是终(Terminal)对象，如果对任意对象 $A$，存在唯一态射 $A -> T$
      - 称对象 $Z$ 是零(null)对象，如果它既是始对象又是终对象
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
    #definition()[][
      - 若 $F$ 在态射集合上的作用是单的，则称 $F$ 是忠实的
      - 若 $F$ 在态射集合上的作用是满的，则称 $F$ 是全的
    ]
    #definition[同构][
      称 $eta : F -> G$ 是函子间的同构，如果对每一个 $X, eta : F X -> G X$ 都是同构
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
    
  == 线性范畴
    #definition()[$R$-线性范畴][
      设 $R$ 是交换环，称范畴 $C$ 是 $R$-线性范畴，如果对任意对象 $A, B in C$，$Hom(A, B)$ 是 $R$-模，
    ]
  == universal
    #definition()[][
      设 $G : B -> B$ 是函子，称 $Y_0 : B$ 到 $G$ 的一个 universal 是 $(X_0, Y_0 -> G X_0)$，使得以下交换图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $Y_0$, 1),
      node((0, 1), $G X_0$, 2),
      node((1, 0), $G X$, 3),
      arr(1, 2, $$),
      arr(3, 2, $exists ! G (f : X -> X_0)$, dashed_str, label-pos: right),
      arr(1, 3, $$),)]
      它是一个逗号范畴的初始对象，因此是唯一的
    ]
    #proposition[][
      设 $(X_0, Y_0)$ 是 $G$ 的 universal，则有：
      $
        Hom(X_0, -) eqv Hom(Y_0, G -)
      $
      反之，若两函子同构，则 $(X_0, Y_0)$ 是 $G$ 的 universal
    ]
    #proof[
      #TODO
    ]
    #example[][
      - 初始对象就是 $id$ 函子的 universal
      - 设 $D$ 是整环的范畴（只包含单射作为态射），$F$ 是所有域构成的全子范畴，$G : F -> D$ 是自然的遗忘函子，任取 $R$，则 $(Q(R), R -> Q(R))$ 就是 $R$ 到 $G$ 的 universal
      - 设 $M$ 是度量空间范畴，$C$ 是完备度量空间范畴，$G$ 是 $C -> M$ 的遗忘函子，则任何一个度量空间的完备化就是 $G$ 的 universal
    ]
  == 伴随
    #definition[伴随][
      设 $F : C -> D, G : D -> C$ 是两个函子，如果双函子之间存在同构：
      $
        Hom_D (F *, -) eqv Hom_C (*, G -)
      $
      则称 $F$ 是 $G$ 的左伴随，$G$ 是 $F$ 的右伴随，记作 $F ~ G$
    ]
    #proposition()[][
      - 对固定函子 $F$，它的左/右伴随函子在同构意义下是唯一的
      - 同一个函子的左伴随与右伴随未必是同构的
    ]
    这些结论我们后面再证明。
    #lemma[][
      设伴随对的同构为 $phi$，则：
      $
        phi(g : F A -> B) = (G g) compose eta_A where eta_A = phi(id : F A -> F A)\
        Inv(phi) (f: A -> G B) = epsilon_B compose (F f) where epsilon_B = Inv(phi)(id : G B -> G B)
      $
    ]<unit-counit-lemma>
    #proof[
      #TODO
    ]
    #lemma[][
      @unit-counit-lemma 中定义的 $eta, epsilon$ 构成自然变换
    ]
    #definition[单位/余单位][
      设 $AdjoinPair(F, G)$ 是一对伴随函子，同构为 $phi$，定义自然变换 $eta : 1 -> G F$，使得 $eta_A = phi(id : F A -> F A)$，称其为伴随对的单位。同理，定义 $epsilon : F G -> 1$，使得 $epsilon_B = Inv(phi)(id : G B -> G B)$，称其为伴随对的余单位。
    ]
    #proposition()[][
      给定函子 $F, G$ 以及 $eta : id -> G F, epsilon : F G -> id$，则可以定义 $phi$ 使得 $eta, epsilon$ 恰好成为单位、余单位以及$AdjoinPair(F, G)$
    ]
    #corollary()[][
      我们有：
      $
        G epsilon compose eta = id\
        epsilon compose F eta = id
      $
    ]
    #proof[
      展开定义，就是：
      $
        G epsilon compose eta = phi (epsilon) = phi(Inv(phi) id) = id\
      
      $
    ]
    下面的引理表明，伴随关系是等价关系的一种推广。
    #lemma[][
       假设 $F, G$ 是一对同构，则它们是一对伴随函子
    ]
    #proof[
      仿照上面，定义：
      $
        phi(g : F Y -> X) = (G g) compose eta_Y
      $
      其中 $eta$ 是 $id -> G F$ 的自然变换，验证：

      #TODO
    ]
    上面两个例子表明，伴随对与自然变换 $1 -> G F$ 有着密切的关系。对偶的，也可以与自然变换 $F G -> 1$ 建立联系：
    #align(center)[#commutative-diagram(
    node((0, 0), $Hom(F G X, X)$, 1),
    node((0, 1), $Hom(G X, G X)$, 2),
    node((1, 0), $Hom(F G X, X')$, 3),
    node((1, 1), $Hom(G X, G X')$, 4),
    arr(1, 2, $phi$),
    arr(1, 3, $Hom(F G X, g)$),
    arr(2, 4, $Hom(G X, G g)$),
    arr(3, 4, $phi$),)]
    上面的交换图表来自于伴随，给出 $epsilon_X := Inv(phi)(1) : F G X -> X$，为了证明自然性，任取 $g : X -> X'$，只需证明下面的图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $F G X$, 1),
    node((0, 1), $X$, 2),
    node((1, 0), $F G X'$, 3),
    node((1, 1), $X'$, 4),
    arr(1, 2, $epsilon$),
    arr(1, 3, $F G g$),
    arr(2, 4, $g$),
    arr(3, 4, $epsilon$),)]
    计算：
    $
      g compose epsilon_X = g compose Inv(phi)(1)\
      epsilon compose F G g = Inv(phi)(1) compose (F G g) = Hom(F G g, X') (Inv(phi)(1))
    $
    前面的图表给出：
    $
      Hom(F G X, g) compose Inv(phi) = Inv(phi) compose Hom(G X, G g)\
      g compose Inv(phi)(1) = Inv(phi)(G g compose 1) = Inv(phi) (G g)
    $
    我们还有图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $Hom(F G X, X')$, 1),
    node((0, 1), $Hom(G X, G X')$, 2),
    node((1, 0), $Hom(F G X', X')$, 3),
    node((1, 1), $Hom(G X', G X')$, 4),
    arr(1, 2, $$),
    arr(3, 1, $Hom(F G g, X')$),
    arr(4, 2, $Hom(G g, G X')$),
    arr(3, 4, $$),)]
    就有：
    $
      Hom(F G g, X') (Inv(phi)(1)) = Inv(phi)(G g)
    $
    这就证明了原来的结论。

    #example[Cartan 同构][
      考虑 $A, B$ 是代数/环，$M$ 是左 $A$ 右 $B$ 双模，则有：
      $
        M tensorProduct_B *, Hom_A (M, *)
      $
      是一对伴随函子，也就是：
      $
        Hom_A (M tensorProduct_B Y, X) eqv Hom_B (Y, Hom_A (M, Y))
      $
    ]
    #example[][
      #let Fix = math.op("Fix")
      #let CoFix = math.op("CoFix")
      #let Triv = math.op("Triv")
      设 $G$ 是有限群，$k$ 是域，设：
      $
        Fix : Mod(k g) -> kVect(k)\
        CoFix : Mod(k g) -> kVect(k)
      $
      定义为：
      $
        Fix(X) = {x in X | g x = x, forall g in G}\
        CoFix(X) = X / (span({g x - x | g in G, x in X}))
      $
      可以证明：
      $
        Fix eqv Hom(k, *)\
        CoFix eqv k tensorProduct_(k G) *
      $
      考虑 $Triv : kVect(k) -> Mod(k g) = k tensorProduct_k * = Hom_k (k, *)$，它把$k$-线性空间看作平凡的$k g$-模，则 $(Triv, Fix), (CoFix, Triv)$ 都是伴随对。这是因为：
      - $k tensorProduct_k * ~ Hom_(k G)(k, *)$
      - $k tensorProduct_(k G) * tilde Hom_k (k, *)$
      然而，$Fix, CoFix$ 并不一定是同构的。例如假设特征为 $p$，$G = (ZZ quo p ZZ) times (ZZ quo p ZZ) = (alpha) times (beta)$，取群作用为：
      $
        alpha -> mat(1, 0, 1;0, 1, 0;0, 0, 1)\
        beta -> mat(1, 0, 0;0, 1, 1;0, 0, 1)
      $
      可以计算出 $Fix, CoFix$ 的维数分别为 $2, 1$
    ]
    #proposition()[][
      假设 $AdjoinPair(F, G)$，则 $F Y, eta : Y -> G F Y$ 是一个 $Y$ 到 $G$ 的 universal
    ]<adjoin-universal>
    #example[][
      - 设 $F$ 是某种构造函子（例如分式域，完备化等），$G$ 是遗忘函子，则往往有 $AdjoinPair(F, G)$
    ]
    #proposition()[][
      设 $AdjoinPair(F, G), AdjoinPair(F', G)$，则 $F eqv F'$
    ]
    #proof[
      由 @adjoin-universal 可知，$F Y, eta$ 和 $F' Y, eta'$ 都是 $Y$ 到 $G$ 的 universal，因此它们同构。#TODO
    ]
    #definition()[biadjoint pair][
      称 $F, G$ 是一对双伴随，如果 $F$ 同时是 $G$ 的左伴随和右伴随（一般情况下当然是未必成立的）
    ]
    #lemma[][
      设 $A$ 是环，$M$ 是左 $A$ 模，则 $M$ 是 $A$ 的自同态环的右模，且是双模。
    ]
    #definition()[][
      设 $R$ 是环，定义 tr 映射：
      $
        tr : "End"_R X -> X' directSum X -> R
      $
    ]
    #definition()[对称代数][
      称 $A$ 是一个 $R$ 对称代数，如果：
      - $R$ 是 $A$ 代数，且是投射模
      - 存在 $R$ 线性映射 $l : A -> R$ 使得：
        $
          l(a b) = l(b a)\
        $
        并且诱导同构 $A -> duel(A)(Hom(A, -))$
      它等价于 $A, duel(A)$ 在左 $R$ 右 $"End"R$ 模范畴中是同构的
    ]
    #definition()[][
      设 $A, B$ 是 $R$ 的对称代数，$M$ 是左 $A$ 右 $B$ 双模，$N$ 是左 $B$ 右 $C$ 双模，若存在双线性映射：
      $
        M times N -> R
      $
      则称 $M, N$ 是一对伴随双模
    ]


  == 范畴同构
    #definition()[范畴的同构][
      设 $A, B$ 是两范畴，$F : A -> B, G : B -> A$，如果：
      - $F compose G eqv id_B$
      - $G compose F eqv id_A$
      则称 $A, B$ 是同构的范畴
    ]
    同构范畴的实际结构可能是相差比较大的，但同构对象的的等价类是一一对应的。例如 $NN$ 和 $NN_(k - "vec")$ 是同构范畴，但对象相差很大。
    #theorem()[][
      设 $F : C -> D$ 是函子，则存在 $G$ 使得 $F, G$ 是一对等价当且仅当 $F$ 是全忠实的，并对每一个 $D$ 中对象 $A'$，存在 $C$ 中对象 $A$ 使得 $F A eqv A'$
    ]
      #proof[ 假设范畴 $A, B$ 通过 $F: A -> B, G: B -> A$ 等价，则：
      - 对于任何 $D$，注意到有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $D$, 1),
        node((0, 1), $F G D$, 2),
        node((1, 0), $D$, 3),
        node((1, 1), $F G D$, 4),
        arr(1, 2, $$, bij_str),
        arr(1, 3, $id$),
        arr(2, 4, $id$),
        arr(3, 4, $$, bij_str),)]
        这表明 $D$ 与 $F G D$ 同构，意味着 $F$ 是本质满的。同理，任何 $C$ 也与 $G F C$ 同构。
      - 根据自然同构 $G F ~ id$，对于任何对象 $C_1, C_2: A$，都有：
        $
          (G : Hom(F C_1, F C_2) -> Hom(G F C_1, G F C_2)) compose (F : Hom(C_1, C_2) -> Hom(F C_1, F C_2))
        $
        是同构，此时必有 $F : Hom(C_1, C_2) -> Hom(F C_1, F C_2)$ 是单射。同理，由 $F G ~ id$ 知：
        $
          (F : Hom(G F C_1, G F C_2) -> Hom(F G F C_1, F G F C_2)) \
          compose (G : Hom(F C_1, F C_2) -> Hom(G F C_1, G F C_2))
        $
        也是同构，也即 $F: Hom(G F C_1, G F C_2) -> Hom(F G F C_1, F G F C_2)$ 总是满射。对于任何 $g: F C_1 -> F C_2$，有：
        #align(center)[#commutative-diagram(
        node((0, 0), $C_1$, 1),
        node((0, 1), $G F C_1$, 2),
        node((0, 2), $F G F C_1$, 3),
        node((1, 0), $C_2$, 4),
        node((1, 1), $G F C_2$, 5),
        node((1, 2), $F G F C_2$, 6),
        node((0, 3), $F C_1$, 7),
        node((1, 3), $F C_2$, 8),
        arr(1, 2, $epsilon$, bij_str),
        arr(4, 5, $$, bij_str),
        arr(1, 4, $epsilon compose h compose Inv(epsilon)$),
        arr(2, 5, $exists h, F h \
        = F Inv(epsilon) compose g compose F epsilon$),
        arr(3, 6, $F Inv(epsilon) compose g compose F epsilon$),
        arr(3, 7, $F Inv(epsilon)$, bij_str),
        arr(6, 8, $$, bij_str),
        arr(7, 8, $g$)
        )]
        容易验证，$F(epsilon compose h compose Inv(epsilon)) = g$，这就得到了 $F$ 的全忠实性。
      反之，假设函子 $F: A -> B$ 满足这些性质，对于范畴 $B$ 中元素，可以构造函子 $G : B -> A$，在元素上它把任何对象映为该对象所在等价类在 $im F$ 中取得的代表元（每个等价类只取一个代表元）的一个逆，态射上把 $f$ 映为 $Inv(F)(Inv(omega) compose f compose omega)$，其中 $omega$ 代表代表元 $F x$ 到对象 $y : B$ 的同构态射（同样对于每个对象只取一个固定的同构态射）。不难验证：
      $
        G (id) = Inv(F)(Inv(omega) compose omega) = id\
        G (g compose f) = Inv(F)(Inv(omega) compose (g compose f) compose omega) \
        = Inv(F)(Inv(omega) compose g compose (omega compose Inv(omega)) compose f compose omega) \
        = Inv(F)(Inv(omega) compose g compose omega compose Inv(omega) compose f compose omega) \
        = G(g) compose G(f)
      $
      因此它是函子。可以验证，$Inv(omega)$ 给出 $id -> F G$ 的自然同构，在对象上由定义成立，而：
      #align(center)[#commutative-diagram(
      node((0, 0), $D_1$, 1),
      node((0, 1), $F G D_2$, 2),
      node((1, 0), $D_2$, 3),
      node((1, 1), $F G D_1$, 4),
      arr(1, 2, $Inv(omega)$),
      arr(1, 3, $f$),
      arr(2, 4, $F G f = Inv(omega) compose f compose omega$),
      arr(3, 4, $Inv(omega)$),)]
      因此在态射上也成立。另一方向上，注意到总有 $F G F C eqv^(omega compose Inv(omega)) F C$，只需验证：
      #align(center)[#commutative-diagram(
      node((0, 0), $G F C_1$, 1),
      node((0, 1), $C_1$, 2),
      node((1, 0), $G F C_2$, 3),
      node((1, 1), $C_2$, 4),
      arr(1, 2, $Inv(F) (omega compose Inv(omega))$),
      arr(1, 3, $G F f$),
      arr(2, 4, $f$),
      arr(3, 4, $Inv(F) (omega compose Inv(omega))$),)]
      事实上，注意到：
      $
        F G F f = Inv(omega) compose (F f) compose omega\
        F (Inv(F) (omega compose Inv(omega)) compose G F f) = omega compose Inv(omega) compose Inv(omega) compose (F f) compose omega\
        = omega compose Inv(omega) compose (F f) compose omega\
        = (F f) compose omega\
        F (f compose (omega compose Inv(omega))) = (F f) compose omega compose Inv(omega)\
        = (F f) compose omega 
      $
      其中：
      - 由于代表元到代表元的 $omega = id$，因此 $Inv(omega) compose Inv(omega) = Inv(omega)$
      - 由于 $F G$ 的像都是代表元，因此 $Inv(omega_(F G F C_1)) = id$
      以上等式标明交换图表在 $F$ 作用下成立。由全忠实性知，交换图表本身成立。综上，$F G ~ id, G F ~ id$，因此 $A, B$ 等价。
    ]
    #example[][
      设 $R, R'$ 是两个环/代数，如果 $R, R'$ 的模范畴同构，则 $R, R'$ Morita 等价。它比代数意义上的环同构要粗。
    ]
    #example[][
      设 $R$ 是交换环，则 $ModCat(R) eqv ModCat(M_n (R))$（可能考证明）
    ]
    #theorem[Skolen-Noether][
      $M_n (R)$ 作为 $R$ 代数的的所有自同构都是内自同构。也就是说所有这样的同构都是 $A -> P A P^(-1)$ 的形式
    ]
    #proof[
      先以 $kVect(k)$ 为例，其中不可分解的（不能写成子模直和的）的模只有唯一一个（也就是一维空间 $k$），由范畴等价，$ModCat(M_n (k))$ 中应该也只有唯一的不可分解对象 $k^n$. 现任取 $alpha$ 是 $M_n (k)$ 的自同构，定义 $Alpha_M : ModCat(M_n (k))$ 为：
      $
        a dot m = alpha(a) m, forall a in M_n (k), m in M
      $
      特别的，它应该是模范畴的自同构，$Alpha_(k^n)$ 仍然是不可分解的，因此就应该有：
      $
        k^n eqv^g Alpha_(k^n)
      $
      以及：
      $
        g(a m) = a dot g(m) = alpha(a) g(m)\
      $
      当然，熟知 $g$ 应该形如某个矩阵，以及：
      $
        forall m, g a m = alpha(a) g m => g a Inv(g) = alpha(a)
      $
      证毕
    ]
    #theorem[][
      对于函子 $F, G$，以下命题等价：
      - $F, G$ 是一对范畴等价
      - $AdjoinPair(F, G)$ 是双伴随对，且所有单位和余单位都是同构
      - $AdjoinPair(F, G)$ 是双伴随对，且存在一侧的单位和余单位都是同构
      - $AdjoinPair(F, G)$ 是双伴随对，且两侧的单位都是同构
      - $AdjoinPair(F, G)$ 是双伴随对，且两侧的余单位都是同构

    ]
  == 拓扑空间上的 presheave, sheaves
    #let Open(X) = $bold("Open")(#X)$
    #definition[预层][
      设 $X$ 是拓扑空间，$Open(X)$ 是其开集构成的范畴，态射是包含映射。称反变函子 $F : Open(X) -> C$ 是 $C$-index 预层。通常的，记：
      $
        rho_(V U)^F = F(U -> V) : F V -> F U
      $
    ]
    #definition[层][
      若 $F : Open(X) -> Set$ 是 $Set$-index 预层。称其为 $X$ 上的层，如果以下性质成立：
      - 任给 $U in Open(X)$ 及其开覆盖 $U_i subset U$，任取 $s, t in F U$，只要 $s|_U_i = t|_U_i$ 对所有 $i$ 成立，则 $s = t$
      - 任给 $U in Open(X)$ 及其开覆盖 $U_i subset U$，任取 $s_i in U_i$ 使得 $s_i|_(U_i inter )$
      它的另一个等价定义是，对于任何 $U$ 和其开覆盖 $U_i subset U$，存在等化子图表：
      $
        F U arrow.dashed product_i F U_i arrow.double^p_q product_(i, j) F(U_i inter U_j) 
      $
      其中 $p = product F (U_i inter U_j -> U_i), q = product F (U_i inter U_j -> U_j)$
    ]
    #definition[子函子][
      称函子 $Q : C -> Set$ 是 $P$ 的子函子，如果：
      - $Q A subset P A, forall A$
      - $forall f : A -> B, Q f = P f |_Q(A)$
    ]
    #definition[sieve][
      称一些到 $C$ 的态射的集合 $S$ 是一个 $C$ 点上的 sieve，如果：
      $
        forall f in S, forall h, f compose h in S
      $
    ]
    假设 $Q subset Hom(-, C)$，则：
    $
      S = {f | exists A, f : A -> C and f in Q(A)}
    $
    是一个 sieve。验证：
    $
      forall f : A -> C in S, forall h : D -> A, f compose h = Hom(h, C) f = (Q h) f in Q(D) 
    $
    即可。反之，任给 $C$ 点的 sieve $S$，定义 $Q(A) = {f in Hom(A, C) | f in S}$ 也得到一个子函子。

    设 $X$ 是拓扑空间，$U$ 是其中的开集，则 $Hom(-, U)$ （在包含映射组成的范畴 $O(X)$ 中）是一个反变函子，也就是 presheave. 假设 $S$ 是 $U$ 点上的 sieve，考察定义就会发现，不严格地说，$S$ 相当于满足：
    $
      forall V in S, forall V' in Open(V), V' in S
    $
    根据上面的论述，当然 $S$ 可以确定一个 $Hom(-, U)$ 的子函子。同时，通过任何一些 $U$ 的开子集，很容易产生一个包含它们的最小的 sieve。
    #definition[][
      - 称一个 sieve 是 principal 的，如果它是由一个开子集产生的。
      - 称一个 sieve 是覆盖 sieve 的，如果它是一个开覆盖产生的。

    ]
    #proposition()[][
      预层 $P$ 是曾当且仅当对于任何开集 $U$ 以及它的覆盖 sieve $S$，函子的包含（作为自然态射）：
      $
        i_S : Q_S -> Hom(-, U)
      $
      诱导同构：
      $
        Hom(Hom(-, U), P) eqv^(Hom(i_S, P)) Hom(Q_S, P)
      $
      其中 $Hom(i_S, P)$ 是指函子范畴上的 $Hom$ 函子作用于 $i_S$)
    ]
    #proof[
      由 Yoneda 引理，有：
      $
        P U eqv Hom(Hom(-, U), P)
      $
      设开覆盖 $U_i$ 生成 $S$，等化子图表形如：
      $
        E arrow.dashed^d product_i P U_i arrow.double product_(i, j) P(U_i inter U_j)
      $
      同时，还可以考虑 $S$ 生成的等化子图表：
      $
        E' arrow.dashed^d' product_(V in S) P V arrow.double product_(V, W in S) P(V inter W)
      $
      显然，下面的图表只是上面图表的一个加细，很自然的 $E'$ 与 $E$ 之间应该有一个同构。事实上，前面的图表可以使用限制构造到下面图表的映射，而下面的图表可以使用投影映射产生到前面图表的映射。分别利用泛性质，可以得到 $E', E$ 之间同构。

      其次，可以证明 $E' eqv Hom(Q_S, P)$，这是因为任取

      结合以上的事实，我们得到了结论成立相当于说 $P U$ 一定是上面两个图表中的等化子，而这恰好就是层的定义。
    ]
    上面的命题看起来非常的晦涩，但它是把预层和层的概念推广到一般的（小）范畴上的重要步骤。
  == sheaves
    #definition()[Grothendieck 拓扑][
      给定小范畴 $C$，$J$ 是一个函数使得对每个对象 $C, J(C)$ 是一些 sieves 的集合，使得：
      - $t_C = {f : * -> C} in J(C)$
      - （稳定性）若 $S in J(C)$，则 $forall h : C -> D`, h^*(S) ={h f | f in S} in J(D)$
      - （传递性）若 $S in J(C), R$ 是任何一个 $C$ 点上的 sieve，使得 $forall h, h^*(R) in J(D)$，则 $R in J(C)$
    ]
    #definition[层][
      设 $C$ 是小范畴，$J$ 是其 Grothendieck 拓扑。称反变函子 $F : C -> Set$ 是 $J$-层，如果对于每个对象 $C$ 及其覆盖 sieve $S in J(C)$，函子的包含：
      $
        i_S : Q_S -> Hom(-, C)
      $
      诱导同构：
      $
        Hom(Hom(-, C), F) eqv^(Hom(i_S, F)) Hom(Q_S, F)
      $
    ]
= 特殊范畴
    == 线性范畴
      #definition()[$R$-线性范畴][
        设 $R$ 是交换环，称范畴 $C$ 是 $R$-线性范畴，如果对任意对象 $A, B in C$，$Hom(A, B)$ 是 $R$-模，
      ]
      #definition()[核][
        称 $(X', iota)$ 是 $f$ 的 $ker$，如果 $f iota = 0$，且对于任何 $g$ 使得 $f g = 0$ 都有：
        #align(center)[#commutative-diagram(
        node((0, 0), $X$, 1),
        node((0, 1), $Y$, 2),
        node((1, 0), $X'$, 3),
        node((1, 1), $Z$, 4),
        arr(1, 2, $f$),
        arr(3, 1, $iota$),
        arr(4, 1, $g$),
        arr(4, 3, $exists! h$, dashed_str))]
      ]
      #definition()[余核][
        称 $(Y', pi)$ 是 $f$ 的 $coker$，如果 $pi f = 0$，且对于任何 $g$ 使得 $g f = 0$ 都有：
        #align(center)[#commutative-diagram(
        node((0, 0), $X$, 1),
        node((0, 1), $Y$, 2),
        node((1, 0), $Z$, 3),
        node((1, 1), $Y'$, 4),
        arr(2, 1, $f$),
        arr(1, 3, $pi$),
        arr(1, 4, $g$),
        arr(3, 4, $exists! h$, dashed_str))
        ]
      ]
      #lemma[][
        核映射 $iota$ 一定是单态射（右消去），余核映射 $pi$ 一定是满态射（左消去）
      ]
      #proof[
        在线性范畴中，只需证明 $iota g = 0 => g = 0$。事实上，若 $iota g = 0$，则对于 $iota g$，存在唯一 $h$ 使得 $iota g = iota h = 0$. 注意到 $h = 0, h = g$ 都满足条件，由唯一性自然 $g = 0$ 
      ]
      #example[][
        一般来说，单态射未必是核映射的一部分。例如在无挠交换群范畴中 $2 * : ZZ -> ZZ$ 是单态射，但它不能作为某个核。
      ]
      #definition()[][
        定义：
        $
          im f = ker (Y -> coker f)\
          coim f = coker (ker f -> X)
        $
        （假设存在）
      ]
      #lemma[][
        假设 $im, coim$ 都存在，则存在唯一的 $h$ 满足图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        arr(2, 3, $f$),
        arr(6, 7, $exists! h$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$)
        )]
      ]<coim-to-im>
      #proof[
        注意到 $(X -> coker f) compose f = 0$，由 $ker$ 的泛性质有：
                #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$)
        )] 
        同时，注意到：
        $
          (im f -> X') compose rho compose (ker f -> X) = f compose (ker f -> X) = 0
        $
        而 $im f -> X'$ 是单态射，由右消去知：
        $
          rho compose (ker f -> X) = 0
        $
        自然的，由 $coim$ 作为 $coker$ 的泛性质，就有：
                        #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(6, 7, $exists! h$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$)
        )] 
        证毕
      ]
    == Abel 范畴
      #definition()[Abel 范畴][
        称 $R$-线性范畴 $C$ 是 Abel 范畴，如果：
        - $C$ 中每个态射都有核和余核
        - 任意单态射都是某个态射的核，任意满态射都是某个态射的余核
      ]
      #theorem()[Mitchell][
        每个 Abeliean $R-$线性范畴都同构于某个 $A$-模范畴的满子范畴，其中 $A$ 是某个 $R-$代数（未必交换）
      ]
      #proposition()[][
        Abel 范畴中，@coim-to-im 给出的态射是同构
      ]
      #proof[
        #TODO
      ]
      #definition()[][
        称 $X'$ 是 $X$ 的子对象，如果存在单态射 $iota : X' -> X$。称 $Y'$ 是 $Y$ 的商对象，如果存在满态射 $pi : Y -> Y'$。
      ]
      #definition()[不可分解][
        称对象 $X$ 是不可分解的（或者单的）如果它没有非平凡的子对象
      ]
      #definition()[][
        称序列 $X_i$ 是 $X$ 的 Jordan-Hölder 序列，如果：
        - $X_0 = 0, X_n = X$
        - $X_(i - 1) subset X_i$ 是子对象
        - $X_i quo X_(i - 1)$ 是不可分解的
      ]
      #theorem[Jordan-Hölder][
        设 $X$ 有 Jordan-Hölder 序列，则任何两个 Jordan-Hölder 序列的长度相同，且不可分解商对象的同构类也是相同的（不考虑顺序）
      ]
      #definition()[Grothendieck 群][
        设 $C$ 是 Abel 范畴，定义其 Grothendieck 群 $Grp(C)$ 为 $C$ 中所有不可分解的对象的同构类生成的自由 Abelian 群。假设 $C$ 中所有对象都是有限长度的，则 $Grp(C)$ 也等价于：
        - 生成元是 $C$ 中对象的同构类 $[X]$
        - 商掉关系 $[X] = [X_1 + X_2]$ 如果有短正合列：
          $
            0 -> X_1 -> X -> X_2 -> 0
          $
        生成的 Abelian 群。
      ]
      #definition()[][
        若函子保持左正合列，则称其是左正合的；若保持右正合列，则称其是右正合的；若保持短正合列，则称其是正合的。
      ]
      #lemma[][
        $
          Hom(X, *), Hom(*, X) 
        $
        都是左正合函子，但未必是右正合的。例如在 $ModCat(A)$ 中，$0 -> 2 ZZ -> ZZ -> ZZ quo 2 ZZ -> 0$ 是正合列，但在 $Hom(ZZ quo 2 ZZ, *)$ 作用下，变成了：
        $
          0 -> 0 -> 0 -> ZZ quo 2 ZZ -> 0
        $
      ]
      #proof[
        #let arrij(i, j) = $X_(#i) -> X_(#j)$
        #let arrhomij(i, j) = $Hom(X, X_(#i)) -> Hom(X, X_(#j))$
        给定左正合列：
        $
          0 -> X_1 -> X_2 -> X_3
        $
        往证：
        $
          0 -> Hom(X, X_1) -> Hom
          (X, X_2) -> Hom(X, X_3)
        $
        也是左正合的。
        - 首先证明：
          $
            (arrhomij(2, 3)) compose (arrhomij(1, 2)) = 0
          $
          显然它就是：
          $
            Hom(X, arrij(2, 3) compose arrij(1, 2)) = Hom(X, 0) = 0
          $
      ]



