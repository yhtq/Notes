#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 2.4.6
  设 $X_0 = span(x_1, x_2, ..., x_n)$，记：
  $
    funcDef(f_0, X_0, KK, x_i, C_i)
  $
  显然题设条件前件等价于：
  $
    "存在" f "是" f_0 "的延拓且" norm(f) <= M
  $
  后件等价于：
  $
    norm(f_0) <= M
  $
  由 Hahn-Banach 定理可得 $f_0$ 一定有保范延拓，取之即得上两式等价
= 2.4.10
  由实数情形结论，可设存在泛函 $f$ 使得：
  $
    Re f(x) < u < Re f(x_0), forall x in E
  $
  此外，我们有：
  $
    forall norm(a) = 1, a x in E
  $
  因此有：
  $
    Re f (a x) = Re a f(x) < u < Re f(x_0) <= abs(f(x_0)), forall norm(a) = 1, x in E
  $
  在上式中取 $a = overline(f(x))/norm(f(x))$ 立刻有：
  $
    Re (f(x) overline(f(x)))/norm(f(x)) = norm(f(x)) < u < abs(f(x_0))
  $
  证毕
= 2.4.11
  #lemmaLinear[][
    设 $f$ 是线性泛函，在 $B(x_0, epsilon)$ 中有最大值点 $x_0$，则 $f = 0$
  ]
  #proof[
    对于任何 $norm(x) = 1$，注意到：
    $
      f(x_0 + epsilon/2 x) = f(x_0) + epsilon/2 f(x) <= f(x_0)\
      f(x_0 - epsilon/2 x) = f(x_0) - epsilon/2 f(x) <= f(x_0)
    $
    上两式表明 $f(x) = 0$，足以表明 $f = 0$
  ]
  首先，由 Hahn-Banach ，可设存在 $f != 0$ 使得：
  $
    f(x) <= a <= f(y), forall x in F, y in E
  $
  而注意到 $forall x in E$ 有 $-x in E$，因此：
  $
    f(x) <= a <= f(y) and -f(x) <= a <= f(y) => abs(f(x)) <= a <= f(y) <= abs(f(y)), forall x, y
  $
  取下确界即得：
  $
    abs(f(x)) <= inf_(y in E) abs(f(y)), forall x in E
  $
  只需证明上式不能取等。否则，反设 $abs(f(x_0)) = inf_(y in E) abs(f(y))$，无妨设 $f(x_0) = inf_(y in E) abs(f(y))$（否则取 $-x_0$ 即可），再取 $y_n$ 使得 $abs(f(y)) -> f(x_0)$，有：
  $
    f(x_0) <= a <= f(y_n), forall n
  $
  不妨设 $a >= 0, f(y_n) >= 0$，上式表明：
  $
    f(y_n) -> a = f(x_0)
  $
  进而，$f$ 在 $E$ 上有最大值点 $x_0$，然而 $E$ 是开的凸集，引理给出 $f = 0$，这是荒谬的
= 2.4.13
  设 $E = B(x, d(x))$，显然 $d(x) > 0$，$E$ 是非空凸集，且 $E$ 与 $M$ 不交（注意到对 $M$ 中点恒有 $norm(x - y) >= d(x)$，但 $E$ 中点总有 $norm(x - y) < d(x)$ ，则由 Hahn-Banach 定理，存在 $f$ 使得：
    $
      f(y) <= f(x + r t) = f(x) + r f(t), forall y in M, r < d(x), t 
    $
    两边同除 $norm(f)$，可不妨设 $norm(f) = 1$，在上式中取上下确界就有：
    $
      sup_y f(y) <= inf_(r < d(x), t) f(x) + r f(t) = f(x) - d(x) norm(f) = f(x) - d(x)
    $
= 2.5.4
  熟知对于有限维空间 $X$ 有 $dim X = dim duelSpace(X) = dim duelSpace(duelSpace(X))$，因此典范映射 $pi : X -> duelSpace(duelSpace(X))$ 是维数相同的有限维空间之间的单射，继而是同构。
= 1.
  凸集是显然的。为了证明稠密，只需证明它在 $C[-1, 1]$（以 $L^2$ 为范数）中稠密即可。事实上，对于任何连续函数 $f$ 总可以取得连续函数 $u(x)$ 使得：
  - $u(0) = f(0) - alpha => f - u in E_alpha$
  - $norm(u)$ 任意小
  进而稠密性成立。

  当 $alpha != beta$ 时，显然交集为空。
  #lemmaLinear[][
    设 $E, F$ 是两个稠密集，则它们不可能被超平面分开
  ]
  #proof[
    否则，设存在 $f != 0$ 使得：
    $
      f(x) <= f(y), forall x in E, y in F
    $
    换言之：
    $
      sup f(E) <= inf f(F) 
    $
    然而由 $f$ 连续，$E, F$ 稠密，就有：
    $
      closure(f(X)) = closure(f(closure(E))) = closure(f(E))
    $
    进而 $sup f(E) = sup f(X)$，类似的有 $inf f(F) = inf f(X)$，结合前式这导致 $f = 0$，矛盾！
  ]
  由引理可得，两个集合不可能被超平面分开。
= 2. 
  先对 $C_0 subset C = {x in C | limn(x_n) = 0}$ 证明存在性。对于任何 $y in l^1$，定义：
  $
    funcDef(f, l^1, C_0^*, (y_i), ((x_i) arrowb sumi1inf(x_i y_i)))
  $
  验证:
  - $((x_i) arrowb sumi1inf(x_i y_i))$ 有界。事实上：
    $
      abs(sumi1inf(x_i y_i)) <= sup_i abs(x_i) sumi1inf(abs(y_i)) = norm(x)_infinity norm(y)_1
    $
    因此 $norm((x_i) arrowb sumi1inf(x_i y_i)) <= norm(y)_1$，事实上可以取等，只需取：
    $
    x^n (i) = (ite(i < n, sgn(y_i), 0) )in C_0
    $
    则不难验证 $norm(x^n) = 1, f(y)(x^n) -> norm(y)_1$
  - $f$ 是单射：取 $x = e_i$ 即可
  - $f$ 是满射：任取 $k in C_0^*$，注意到：
    $
      norm(x - sumi1N(x_i e_i))_infinity = sup_(i > N) abs(x_i) -> 0\ 
      k(x) = k(sumi1inf(x_i e_i)) = sumi1inf(x_i k(e_i))
    $
    因此 $f((k(e_i)) = k$
  之后，对于 $x in C$，显然 $x - limn(x_n) in C_0$

  一般而言，定义：
  $
    funcDef(pi, C, C_0, x, x - (limn(x)) (1, 1, ...))
  $
  #let restrict = "restrict"
  不难验证 $pi$ 是线性的满射，$ker pi eqv RR$，此外，取自然的映射 $restrict : duelSpace(C) -> duelSpace(C_0)$ 以及任意 $z in duel(C)$
  // ，可以得到 $duel(pi) compose restrict : duelSpace(C) -> duelSpace(C)$，以及：
  // $
  //   inner((duel(pi) compose restrict) f, x) = inner(duel(pi) (restrict f), x) = inner(f, pi (x))
  // $
  设：
  $
    y = Inv(f)(restrict z)\
    f y = restrict z\
    duel(pi) (f y) = duel(pi) (restrict z)\
  $
  而：
  $
    inner(duel(pi) (f y), x) = inner(f y, pi (x)) = sumi1inf((x_i - limn(x)) y_i) = sumi1inf(x_i y_i) - limn(x) (sumi1inf(y_i)) \
    := sumi1inf(x_i y_i) + lambda_1 limn(x)
  $<eq1>
  （由绝对收敛性，$lambda_1$ 存在）\
  以及：
  $
    inner(duel(pi) (restrict z), x) - inner(z, x) = inner(z, pi(x) - x) = - inner(z, (limn(x)) (1, 1, ...)) := C limn(x)
  $<eq2>
  因此：
  $
    inner(z, x) = inner(duel(pi) (restrict z), x) - C limn(x) = inner(duel(pi) (f y), x) - C limn(x) \
    = sumi1inf(x_i y_i) + (lambda_1 - C) limn(x)
  $
  这就得到了存在性，至于唯一性：
  - 先说明 $y$ 的唯一性，显然对于满足条件的 $y$ 都有：
    $
      restrict z = f y
    $
    由于 $f$ 是单射，当然 $y$ 是唯一的
  - 只要任取 $x$ 使得 $limn(x_n)$ 非零，不难验证不可能有两个不同的 $lambda$ 使得题中式子成立，因此 $lambda$ 的唯一性是显然的
  任取 $norm(x) = 1$，有：
  $
    abs(inner(z, x)) <= abs(sumi1inf(x_i y_i)) + abs(lambda) abs(limn(x_n)) <= norm(y_1) + abs(lambda)abs(limn(x_n)) <= norm(y_1) + abs(lambda)
  $
  同时，取：
  $
    x^n (i) = (ite(i < n, sgn(y_i), sgn(lambda)) ) in C
  $
  就有：
  $
    norm(x^n) = 1\
    inner(z, x^n) -> norm(y_1) + abs(lambda)
  $
  因此：
  $
    norm(z) = norm(y)_1 + abs(lambda)
  $
= 3
  #let dX = $duelSpace(X)$
  #let dY = $duelSpace(Y)$
  #let dXY = $duelSpace((X quo Y))$
  #let ddX = $duelSpace(duelSpace(X))$
  #let ddY = $duelSpace(duelSpace(Y))$
  #let ddXY = $duelSpace(duelSpace((X quo Y)))$
  #let di = $duel(i)$
  #let dpi = $duel(pi)$
  #let ddi = $duel(duel(i))$
  #let ddpi = $duel(duel(pi))$
  #let dre = $duel(restrict)$
  #lemmaLinear[][
    设 $i$ 是赋范空间 $X, Y$ 之间的有界线性单射，则存在线性映射（未必有界） $g : dX -> dY$ 使得：
    $
      di compose g = id
    $
  ]
  #proof[
    设 $E$ 是 $dX$ 的一个 Hamel 基，对其中每个元素 $e$，利用 Hahn-Banach 定理选定一个 $e' : dY$，定义：
    $
      funcDef(g, dX, dY, e, e')
    $
    则容易验证，$(di compose g)|_E = id$，进而 $di compose g = id$ 
  ]
  #lemmaLinear[][
    设 $f$ 是连续线性映射，则：
    - 若 $f$ 是满射，则 $duel(f)$ 是单射
    - 
      $
        duelSpace((Y quo closure(im f))) eqv ker duel(f)
      $
  ]
  #proof[
    - 假设 $duel(f) x = 0$，则：
      $
        forall y, 0 = inner(duel(f) x, y) = inner(x, f y)
      $
      由 $f$ 满，上式等价于：
      $
        forall y, 0 = inner(x, y) => x = 0
      $
    - 记：
      $
        X ->^f Y ->^pi Y quo overline(im f)\
        duelSpace((Y quo closure(im f))) ->^dpi  dY ->^duel(f) dX
      $
      由于：
      $
        duel(f) compose duel(pi) = duel(pi compose f) = 0 
      $
      因此 $im pi^* subset ker duel(f)$，同时，由于 $pi$ 是满射，因此 $dpi$ 是单射，只需证明 $im pi^* = ker duel(f)$ 即可。任取 $x in ker duel(f) => duel(f) x = 0 => x|_(im f) = 0$，当然就可将 $x$ 延拓到 $x' in Y quo closure(im f) -> KK = duel((Y quo closure(im f)))$，并且显有 $dpi(x') = x$，证毕
  ]
  熟知 $X = Y directSum X quo Y$，
  // ，因此：
  // $
  //   Hom(X, KK) = Hom(Y, KK) directSum Hom(X quo Y, KK)\
  //   Hom(Hom(X, KK), KK) = Hom(Hom(Y, KK), KK) directSum Hom(Hom(X quo Y, KK), KK)\
  // $
  取 $i : Y inja X$ 和 $pi : X surja X quo Y$，容易验证它们都是有界的。
  - 注意到：
    $
      di' : dX quo (ker di) -> dY
    $
    是单射（$di$ 连续，$ker di$ 是闭子空间），引理给出映射 $g :  duelSpace((dX quo (ker di))) -> ddY$ 保证：
    $
      restrict compose g =  duel(di') compose g = id 
    $
    再取 $j : ker duel(i) inja dX, pi_j : dX -> (dX quo ker di), duel(pi_j) : duel((dX quo ker di)) eqv ker duel(j)$，注意到：
    $
      di = i'^* compose pi_j
    $

    此外，熟知：
    $
      X = Y directSum X quo Y\
      ddX = ker duel(j) directSum ddX quo ker duel(j)
    $
    构造：
    $f_1 = i compose Inv(tau : Y eqv ddY) compose g compose Inv(duel(pi_j)) : ker duel(j) -> X$，它满足：
      $
        inner(tau(f_1 (duel(pi_j) (z))), y : dX) &= inner(y, f_1 (z)) \
        &= inner(y, (i compose Inv(tau : Y eqv ddY)  compose g) z) \
        &= inner(di y, (Inv(tau : Y eqv ddY)  compose g) z) \
        &= inner(g z, (i'^* compose pi_j) y)\
        &= inner((pi_j^* compose duel(i'^*)) g z, y)\
        &= inner(pi_j^* z, y)\
      $
      由于 $pi_j^*$ 是满射，这表明：
      $
        tau compose f_1 = id
      $
      进而：
      $
        ker duel(j) subset im tau 
      $
  - 往证：
    $
      ddpi (ker duel(j)) = 0
    $
    计算：
    $
      inner(ddpi (duel(pi_j) z), y : dXY) = inner(duel(pi_j) z, dpi y) = inner(z, pi_j (dpi y))\
      di (dpi y) = duel((pi compose i)) y = 0 => dpi y in ker di => pi_j (dpi y) = 0\
    $
    表明前式成立，因此可设 $u : ddX quo ker duel(j) -> ddXY$ 是 $ddpi$ 的延拓，也即：
    $
      u compose (ddX -> ddX quo ker duel(j)) = ddpi
    $

    此外，引理给出 $dpi : dXY eqv ker di$
    进而构造 $f_2$ 使得：
    $
      f_2 = (X quo Y -> X ("来自直和")) compose Inv(tau : X quo Y -> ddXY) compose u compose (ddX -> ddX quo ker duel(j)) \
      : ddX -> X
    $
    
    验证：
    $
      inner(tau(f_2  z), j y) &= inner(j y, f_2 z) \
      &= inner(dpi Inv(dpi) j y, f_2 z) \
      &= inner(Inv(dpi) j y, pi f_2 z) \
      &= inner(Inv(dpi) j y, (Inv(tau : X quo Y -> ddXY) compose u) (ddX -> ddX quo ker duel(j)) z) \
      &= inner(u (ddX -> ddX quo ker duel(j)) z, Inv(dpi) j y) \
      &= inner(ddpi z, Inv(dpi) j y) \
      &= inner(z,dpi Inv(dpi) j y) \
      &= inner(z, j y) \
    $
    换言之：
    $
      forall z, ((tau compose f_2) - id) z in ker duel(j)
    $
  - 最后，考虑：
    $
      f = f_2 - f_1 compose ((tau compose f_2) - id) : ddX -> X
    $
    我们有：
    $
      tau compose f = tau compose f_2 - tau compose f_1 compose ((tau compose f_2) - id) = tau compose f_2 - ((tau compose f_2) - id) = id
    $
    证毕！
    // 表明：
    // $
    //   tau compose f_2 ((ddX -> ddX quo ker duel(j)) z) = ddpi z
    // $
  
  

  