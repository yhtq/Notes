#import "../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 1.4.2 (2)
  对于任意 $x in l^infinity$，定义：
  $
    f(x) = "由" {(i/n, x(n_i)) mid(|) n_i "是" x "非零元素构成的子列" } "构成的分段线性函数"
  $
  则不难验证 $norm(f(x)) = norm(x)$，因此 $l^infinity$ 与 $f$ 的像集等距同构
= 1.4.5
  == (1)
    #let int0inf(f) = $integral_0^infinity #f dif x$
    - $norm(f) = 0 <=> int0inf(e^(-a x) abs(f(x))^2) = 0 <=> e^(-a x) abs(f(x))^2 = 0 <=> f(x) = 0$
    - $norm(lambda f) = (int0inf(e^(-a x) abs(lambda f(x))^2))^(1/2) = abs(lambda) (int0inf(e^(-a x) abs(f(x))^2))^(1/2) = abs(lambda) norm(f)$
    - $norm(f + g)^2 = (int0inf(e^(-a x) abs(f(x) + g(x))^2)) = norm(f)^2 + norm(g)^2 + (int0inf(e^(-a x) 2 abs(f(x) g(x))))$\
      同时：
      $
        (norm(f) norm(g))^2 &= (int0inf(e^(-a x) abs(f(x))^2)) (int0inf(e^(-a x) abs(g(x))^2)) \
        &= (int0inf((e^(-a/2 x) abs(f(x)))^2)) (int0inf((e^(-a/2 x) abs(g(x)))^2))\
        &>=^("柯西不等式") (int0inf(e^(-a x) abs(f(x) g(x))))^2
      $
      因此就有：
      $
        norm(f + g)^2 <= norm(f)^2 + norm(g)^2 + 2 norm(f) norm(g) = (norm(f) + norm(g))^2
      $
      证毕
  == (2)
    不妨设 $a < b$，不难发现恒有：
    $
      norm(f)_b <= norm(f)_a
    $
    设：
    $
      f_n (x) = cases(
        e^((a + b)/4 x) space x < n,
        e^((a + b)/4 n) space x >= n
      )
    $
    则 $f_n$ 当然是有界连续的，同时：
    $
      norm(f_n)^2_a &= integral_(0)^(n) e^((b - a)/2 x) dif x + e^((a + b)/2 n) integral_(n)^(+infinity) e^(-a x) dif x ->^(n -> +infinity) +infinity\
      norm(f_n)^2_b &= integral_(0)^(n) e^(- (b - a)/2 x) dif x + e^((a + b)/2 n) integral_(n)^(+infinity) e^(-b x) dif x \
      &<= int0inf(e^(- (b - a)/2 x)) + e^((a + b)/2 n) integral_(n)^(+infinity) e^(-b x) dif x\
      &= 2/(b - a) + e^((a + b)/2 n)/b (e^(-b n))\
      &->^(n->+infinity) 2/(b - a) 
    $
    可见 $b$ 范数不可能控制 $a$ 范数
= 1.4.7
  #let cX =$cal(X)$
  - 设 $cX$ 完备，则对于满足条件的序列 $x_n$ 有：
    $
      norm(sum_(i = 1)^(m) x_i - sum_(i = 1)^(n) x_i) = norm(sum_(i = n + 1)^m x_i ) <= sum_(i = n + 1)^m norm(x_i) 
    $
    而由 $sum_(i = 1)^(+infinity) norm(x_i) < +infinity$，只要 $n, m$ 充分大上式即可充分小，继而 $sum_(i = 1)^n x_i$ 是关于 $n$ 的柯西列，进而有极限
  - 设题设条件满足，$x_i$ 是任一柯西列，按照以下方式构造 $i_n$:
    + 设 $i_0 = 0, i_1 = 1$
    + 对于任意 $k > 1$，由 $x_n$ 的柯西性，设：
      $
        forall n, n, m >= N => norm(x_n - x_m) < 1/2^k
      $ 
      则取 $i_k = max(N, i_(k - 1))$
    进一步，定义 $d_n = x_(i_n) - x_(i_(n - 1)) (x_0 = 0)$，立刻有：
    $
      forall n > 1, norm(d_(n + 1)) = norm(x_(i_(n + 1)) - x_(i_n)) < 1/2^n
    $
    则：
    $
      x_(i_n) = sum_(i = 1)^n d_i\
      sum_(i = 1)^n norm(d_i) = norm(d_1) + norm(d_2) + sum_(i = 3)^n norm(d_i) <= norm(d_1) + norm(d_2) + sum_(i = 3)^n 1/2^(i - 1) < +infinity
    $
    则由条件，$sum_(i = 1)^n d_i$ 收敛，意味着 $x_n$ 有子列收敛，由柯西性，$x_n$ 收敛
= 1.4.13
  等价于证明 $forall y, inf_(x in cX_0) norm(y - x) = 0$. 反设 $inf_(x in cX_0) norm(y - x) = d > 0$，设 $delta > 0$，由下确界定义，可以找到 $x_0$ 使得：
  $
    norm(y - x_0) < (1 + delta) d
  $
  然而注意到：
  $
    inf_(x' in cX_0) norm((y - x) - x') <= c norm(y - x) < (1 + delta) c d
  $
  因此可以找到 $x'$ 使得：
  $
    norm((y - x_0) - x') < (1 + delta)^2 c d
  $
  令 $x' + x_0 = x_1$，有：
  $
    norm(y - x_1) < (1 + delta)^2 c d
  $
  以次类推，可以找到 $x_n$ 使得：
  $
    norm(y - x_n) < (1 + delta)^n c^(n - 1) d
  $
  因此，只要取得 $1 + delta < 1/c$ （这是容易的），上式便在 $n->infinity$ 时 $-> 0$，与 $d = inf_(x in cX_0) norm(y - x)$ 矛盾！
= 1.4.14
  == (1)
    由级数的线性，$M$ 显然是线性子空间。同时，假设 $x_n in M -> x$，则：
    $
      sum_(n = 1)^infinity (x(n))/2^n = sum_(n = 1)^infinity (x(n) - x_k (n))/2^n + sum_(n = 1)^infinity (x_k (n))/2^n = sum_(n = 1)^infinity (x(n) - x_k (n))/2^n
    $
    而当 $k$ 充分大时，上式中 $abs(x(n) - x_k (n))$ （对于任何 $n$ ）充分小，进而当然有 $sum_(n = 1)^infinity (x(n))/2^n = 0$
  == (2)
    假设 $z in M$，有：
    $
     max_n abs((x_0 - z) (n)) >= sum_(n = 1)^infinity ((x_0 - z)(n))/2^n = 1 - sum_(n = 1)^infinity (z(n))/2^n = 1
    $
    同时，上式取等当且仅当 $x_0 - z$ 的所有项均相等，换言之：
    $
      z = (2 + a, a, a, ...)
    $
    结合收敛到零，$a = 0$，这是不可能的。因此上式中不等号严格成立。

    #let ze = $z_epsilon$
    而对任何 $0 < epsilon < 1$，构造 $ze$ 如下：
    - $ze (1) = 1 - epsilon$
    - 若 $sum_(k = 1)^n ze(k)/2^k >= 1/(2^(n + 1))$，则 $ze(n + 1) = - 1$
    - 若 $0 < sum_(k = 1)^n ze(k)/2^k < 1/(2^(n + 1))$，则 $ze(n + 1) = - 2^(n + 1) (sum_(k = 1)^n ze(k)/2^k)$
    - 若 $sum_(k = 1)^n ze(k)/2^k = 0$，则 $ze(n + 1) = 0$
    注意到：
    $
      (1 - epsilon)/2 - sum_(k = 2)^infinity 1/2^k = - epsilon/2 < 0
    $
    因此以上构造中，一定会在有限步达到最后一种情况，因此 $ze$ 收敛于零。由构造容易验证 $ze in M$ 且 $norm(x_0- ze) = 1 + epsilon$，由 $epsilon$ 的任意性，距离的下确界不超过 $1$，而不等式保证了只能为 $1$
= 1.4.17
  == (2)
    线性性是显然的。而：
    $
      norm(phi(x) - phi(y)) = inf_(s in cX_0) norm(x - y + s) = inf_(s_1, s_2 in cX_0) norm((x + s_1) - (y + s_2)) <= inf_(s_1, s_2 in cX_0) norm(x + s_1) + norm(y + s_2)\
      = norm(x) + norm(y)
    $
    因此 $phi$ 是 Lipschitz 连续的
  == (3)
    取 $z in cX_0$ 使得：
    $
      norm(x - z) <= 2 norm(x + cX)
    $
    当然有：
    $
      phi(x - z) = phi(x) = x + cX\
      norm(x - z) <= 2 norm(x + cX)
    $
    证毕
  == (4)
    取映射：
    $
      funcDef(phi, cX, KK, f, f(0))
    $
    容易验证：
    - $phi$ 是线性的
    - $phi$ 是满的
    - $ker phi = cX_0$
    因此 $phi$ 可被唯一的提升到 $overline(phi): cX quo cX_0 -> KK$，由同构定理 $overline(phi)$ 将是线性同构。只需证明它保模长即可：
    $
      overline(phi) (x + cX_0) = phi(x) = x(0)\
      norm(overline(phi) (x + cX_0)) = norm(x(0))
    $
    只需证明 $norm(x + cX_0) = norm(x(0))$ 即可。
    - 一方面，有：
      $
        forall z in cX_0, d(z, x) >= d(z(0), x(0)) = norm(x(0)) => inf_(z in cX_0) d(z, x) >= norm(x(0))\
      $
    - 另一方面，取 $z = x - x(0)$，当然有 $d(z, x) = norm(x(0))$ 且 $z in cX_0$
    因此 $norm(x + cX_0) = norm(x(0))$，证毕
= 1
  假设 $x in K$ 是内点，由赋范空间（拓扑的）平移、伸缩不变性无妨设 $x = 0, B(0, 1) subset K$，然而：
  - 度量空间中紧集一定是闭的，从而 $overline(B(0, 1)) subset K$
  - 度量空间中紧集的闭子集还是紧的，因此 $overline(B(0, 1)) $ 是紧的
  然而，由 Riesz 定理以上结果表明空间是有限维的，矛盾！
= 2
  - 假设 $K$ 完全有界，则 $K$ 当然有界，且选择一个有限的网，这些向量张成的有限维空间当然也逼近 $K$
  - 假设题设两条性质成立，对于任何 $epsilon > 0$，选取有限维线性子空间 $Y$ 使得 $forall x in K, d(x, Y) < epsilon$.\
    设 $K$ 有界 $M$，考虑 $Y inter B(0, M + 2 epsilon)$，这是有限维空间中的有界集，当然完全有界，因此存在有限个 $xi_i in X$ 使得：
    $
      Y inter B(0, M + 2 epsilon) subset union_i B(xi_i, epsilon)
    $
    此时，任取 $x in K$，选取 $y$ 使得 $d(x, y) < 2 epsilon$，不难发现一定有 $y in Y inter B(0, M + 2 epsilon)$，因此设 $y in B(xi_i, epsilon)$，一定有：
    $
      d(x, xi_i) <= d(x, y) + d(y, xi_i) < 3 epsilon
    $
    这就证明了：
    $
      K subset union_i B(xi_i, 3 epsilon)
    $
    由 $epsilon$ 的任意性，$K$ 完全有界