#import "../../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 4
  == 
    假设范畴 $A, B$ 通过 $F: A -> B, G: B -> A$ 等价，则：
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
  == 反变函子的 Yoneda 引理
    设 $F: A -> SetCat$ 是一个反变函子，则对于任意对象 $C: A$，都有自然同构：
    $
      Hom(Hom(*, C), F) eqv F C
    $
    - 给定 $y in F C$，定义：
      $
        sep(eta, y) &:: Hom(Hom(*, C), F)\
        sep(eta, y, (D : A)) &:: Hom(D, C) -> F D\  
        sep(eta, y, D) &= (f: Hom(D, C)) |-> (F f : F C -> F D) (y)
      $
      验证其自然性，只需证明：
      #align(center)[#commutative-diagram(
      node((0, 0), $Hom(D_1, C)$, 1),
      node((0, 1), $F D_1$, 2),
      node((1, 0), $Hom(D_2, C)$, 3),
      node((1, 1), $F D_2$, 4),
      arr(1, 2, $sep(eta, y)$),
      arr(1, 3, $Hom(f, C)$),
      arr(2, 4, $F f$),
      arr(3, 4, $sep(eta, y)$),)]
      事实上，对任何 $h: Hom(D_1, C)$，有：
      $
        (F f)(sep(eta, y, h)) = (F f) ((F h) y)\
        sep(eta, y, (Hom(f, C) h)) = sep(eta, y, (h compose f)) = (F (h compose f)) y = (F f) ((F h) y)
      $
      因此交换图表是成立的。更进一步，断言 $sep(eta, y)$ 是关于 $y$ 的单射。这是因为如果：
      $
        sep(eta, y) = sep(eta, y')
      $
      立刻有：
      $
        forall (D: A) (f: Hom(C, D)), (F f) y = (F f) y'
      $
      取 $D = C, f = id$ 立刻有 $y = y'$
    - 接下来，验证 $eta : F C -> Hom(Hom(*, C), F)$ 是关于 $y$ 的满射。任取自然变换 $epsilon : Hom(Hom(*, C), F)$，对任何 $C, D, f : D -> C$ 有图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $Hom(C, C)$, 1),
      node((0, 1), $F C$, 2),
      node((1, 0), $Hom(D, C)$, 3),
      node((1, 1), $F D$, 4),
      arr(1, 2, $epsilon$),
      arr(1, 3, $Hom(f, C)$),
      arr(2, 4, $F f$),
      arr(3, 4, $epsilon$),)]
      立刻有：
      $
        (F f) (epsilon id) = epsilon (Hom(f, C) id) = epsilon f
      $
      因此，取 $y = epsilon id : F C$，有：
      $
        sep(eta, y, D, (f: Hom(D, C))) = (F f) y = (F f) (epsilon id) = epsilon (D) f
      $
      这就表明 $sep(eta, y) = epsilon$。这表明 $eta$ 是一一的，更进一步，我们有：
      $
        sep(Inv(eta), epsilon) = epsilon (id : Hom(C, D))
      $
    - 我们还要验证它是自然的，也即：
      #align(center)[#commutative-diagram(
      node((0, 0), $F C_1$, 1),
      node((0, 1), $Hom(Hom(*, C_1), F)$, 2),
      node((1, 0), $F C_2$, 3),
      node((1, 1), $Hom(Hom(*, C_2), F)$, 4),
      arr(1, 2, $eta$),
      arr(1, 3, $F f$),
      arr(2, 4, $Hom(Hom(*, f), F)$),
      arr(3, 4, $eta$),)]
      对任何 $C_1, C_2, f$ 都要成立。事实上：
      $
        sep(eta, ((F f) y), (D : A)) = (h: Hom(D, C_2)) |-> (F h) ((F f) y) \
        sep(Hom(Hom(*, f), F), eta, y, D) = Hom(Hom(D, f), F) ((h: Hom(D, C_2)) |-> (F h) y) \
        = ((h: Hom(D, C_2)) |-> (F h) y) compose Hom(D, f)\
        = ((h: Hom(D, C_1)) |-> (F (f compose h)) y)\
        = ((h: Hom(D, C_1)) |-> ((F h) compose (F f)) y)\
        = ((h: Hom(D, C_1)) |-> (F h) ((F f) y))\
      $
      证毕。
= 5
  == 1
    $phi: Hom(F X, Y) -> Hom(X, G Y)$
    - 一方面，只需证明：
      $
        forall f, phi f = G f compose (phi id_(F X))
      $
      熟知有交换图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $Hom(F X, F X)$, 1),
      node((0, 1), $Hom(X, G F X)$, 2),
      node((1, 0), $Hom(F X, Y)$, 3),
      node((1, 1), $Hom(X, G Y)$, 4),
      arr(1, 2, $phi$),
      arr(1, 3, $Hom(F X, f)$),
      arr(2, 4, $Hom(F X, G f)$),
      arr(3, 4, $phi$),)]
      立刻有：
      $
        Hom(F X, G f) (phi id) = (G f) compose (phi id)\
        phi (Hom(F X, f) id) = phi f
      $
      相等，因此原结论成立。
    - 另一方面，只需要证明：
      $
        eta = (G id) compose eta\
        id = phi(epsilon_Y) = G epsilon_Y compose eta 
      $
      前式是显然的，后式就是条件
  == 2
    - 一方面，只需证明：
      $
        G epsilon compose eta = id
      $
      由上一题前半部分结论，有：
      $
        G epsilon compose eta = phi (epsilon) = phi(Inv(phi) id) = id
      $
    - 另一方面，只需证明：
      $
        epsilon compose F eta = id
      $
      由类似的结论，有：
      $
        epsilon compose F eta = Inv(phi) (eta) = Inv(phi) (phi id) = id
      $
