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
        phi(g : F A -> B) = (G g) compose eta_A where eta_A = phi(id : F A -> F A)
      $
    ]
    #proof[
      #TODO
    ]
    #lemma[][
       假设 $F, G$ 是一对同构，则它们是一对伴随函子
    ]
    #proof[
      仿照上面，定义：
      $
        phi(g : F Y -> X) = (G g) compose eta_Y
      $
      其中 $eta$ 是 $1 -> G F$ 的自然变换，验证：

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
    #definition[单位/余单位][
      设 $F ~ G$ 是一对伴随函子，同构为 $phi$，定义自然变换 $eta : 1 -> G F$，使得 $eta_A = phi(id : F A -> F A)$，称其为伴随对的单位。同理，定义 $epsilon : F G -> 1$，使得 $epsilon_B = Inv(phi)(id : G B -> G B)$，称其为伴随对的余单位
    ]

    这可以表明，伴随关系是等价关系的一种推广。
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
    #example[][
      设 $R, R'$ 是两个环/代数，如果 $R, R'$ 的模范畴同构，则 $R, R'$ Morita 等价。它比代数意义上的环同构要粗。
    ]
    #example[][
      设 $R$ 是交换环，则 $ModCat(R) eqv ModCat(M_n (R))$
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

