#import "../../template.typ": *
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 1.6.5
  熟知：
  $
    orthogonalCom(M) = orthogonalCom(overline(span(M)))\
    orthogonalCom(orthogonalCom(M)) = orthogonalCom(orthogonalCom(overline(span(M)))) = overline(span(M))
  $ 
= 1.6.7
  由于平移常数无关紧要，不妨设 $a = 0$
  == (1)
    - $b = 1$ 时就是傅里叶级数的经典结论。
    - $b < 1$ 时，注意到 $f$ （经过任意的延拓）能在 $[0, 1]$ 上被 ${e^(2 n i pi x)}$ 逼近，当然在 $[0, b]$ 上也能被逼近，继而 $S$ 是完备的，等价于是极大的。
  == (2)
    如若不然，则 $S$ 是完备的。然而不难发现 $S$ 中函数都以 $1$ 为周期，取函数：
    $
      f(x) = cases(
        1 quad x in [0, 1],
        0 quad "else"
      )
    $
    显然不可能被 $S$ 逼近。
= 1.6.8
  分别验证：
  - 规范：
    $
      1/i integral_(abs(z) = 1)^() abs(z^n/(sqrt(2 pi)))^2/z dif z = 1/(2 pi i) integral_(abs(z) = 1)^() 1/z dif z = 1
    $
  - 正交（无妨设 $m > n$）：
    $
      1/(2 pi i) integral_(abs(z) = 1)^() (z^m overline(z)^n)/z dif z = 1/(2 pi i) integral_(abs(z) = 1)^() z^(m - n - 1) abs(z)^n dif z = 0
    $
  - 完备：复变函数知识给出任取 $f in cal(X)$，$f$ 可以被幂级数在闭单位圆盘一致逼近，当然在题设内积下也是逼近。
= 1.6.9
  不妨设 ${e_i}$ 完备，假设 ${f_i}$ 不完备，取 $x = sumBrN1inf(lambda_i e_i)$，$norm(x) = 1$ 且 $x orthogonal {f_i}$，不难发现：
  $
    norm2(sumBrN1inf(lambda_i e_i) - sumBrN1inf(lambda_i f_i)) <= (sumBrN1inf(norm(lambda_i) norm(e_i - f_i)))^2 <= sumBrN1inf(norm(lambda_i)^2) sumBrN1inf(norm(e_i - f_i)^2) < 1
  $
  但另一方面：
  $
    norm2(x - sumBrN1inf(lambda_i f_i)) = norm(x) + sumBrN1inf(norm(lambda_i)^2) = 2
  $
  显然是荒谬的。
  // 任取 $f_n$，设：
  // $
  //   f_n = a + b, a in overline(span(e_i)), b in orthogonalCom(overline(span(e_i)))
  // $
  // 则：
  // $
  //   norm2(f_n - e_n) = 2 - 2 inner(a, e_n) < 1\
  //   inner(a, e_n) > 1
  // $
  // 然而：
  // $
  //   inner(a, e_n)^2 <= norm2(a) norm2(e_n) <= norm2(a)
  // $

= 1.6.12
  对任意 $N$ 都有：
  $
    (sumBrN1(inner(x, e_i) overline(inner(y, e_n))))^2 <= sumBrN1(norm2(inner(x, e_i))) sumBrN1(norm2(inner(y, e_i))) <= norm2(x) norm2(y)
  $
  令 $N -> +infinity$ 立刻有原结论
= 1.6.16
  考虑：
  $
    f(x) = a(x, x)/norm2(x)
  $
  容易验证它是连续实值函数，因此可设 $f$ 在 ${x | norm(x) = 1}$ 上最小/最大值分别为 $delta, M$。同时由齐次性，不难得到：
  $
    delta <= f(x) <= M, forall x
  $
  这就意味着：
  $
    delta norm2(x) <= a(x, x) <= M norm2(x), forall x
  $
  根据上面的结论得到：
  $
    a(x, x) - Re inner(u_0, x) >= delta norm2(x) - norm(u_0) norm(x) 
  $
  这是关于 $norm(x)$ 的二次函数，当然有最小值，因此题设函数在 $C$ 上有下界，进而可设：
  $
    d = inf_(x in C) a(x, x) - Re inner(u_0, x)
  $ 
  并设 $x_i in C$ 使得 $a(x_i, x_i) - Re inner(u_0, x_i) -> d$，则可以验证平行四边形法则：
  $
    a(x_i - x_j, x_i - x_j) + 1/4 a((x_i + x_j)/2, (x_i + x_j)/2) = 2 (a(x_i, x_i) + a(x_j, x_j))
  $
  其中：
  $
    a((x_i + x_j)/2, (x_i + x_j)/2) >= d + Re inner((x_i + x_j)/2, u_0)
  $
  因此：
  $
    a(x_i - x_j, x_i - x_j) + 4 d + 4 Re inner((x_i + x_j)/2, u_0) <= 2 (a(x_i, x_i) + a(x_j, x_j))\
    a(x_i - x_j, x_i - x_j)  <= 2 ((a(x_i, x_i) - Re inner(u, x_i)) + (a(x_j, x_j) - Re inner(u, x_j))) - 4 d\
  $
  当 $i, j$ 充分大时上式 $-> 0$，相当于在 $a$ 诱导的内积对应度量下是柯西的。由于 之前证明了 $a$ 诱导的度量与原度量等价，因此在原度量下也是柯西的，进而收敛，极限点当然就是最小值点。

  对于任意 $x in C$，定义函数：
  $
    u(t) = a(y, y) - Re inner(u_0, y) where y = x_0 + t (x - x_0), t in [0, 1]
  $
  则函数应当在 $t = 0$ 处取最小值。同时：
  $
    u(t) = a(x_0, x_0) + t^2 a(x - x_0, x - x_0) + 2 t Re a(x_0, x - x_0) - t Re inner(u_0, x - x_0) - Re inner(u_0, x_0)\
  $
  这是二次函数，有最小值条件求导有：
  $
    Re (2 a(x_0, x - x_0) - inner(u_0, x - x_0)) >= 0
  $
  证毕
  // 在 $cal(X)$ 上定义新的内积：
  // $
  //   inner(x', y') = a(x, y)
  // $
  // 前面的结论保证了该内积对应的度量与原度量等价，因此有相同的拓扑。同时，题设函数变为：
  // $
  //   x' -> norm2(x') - 
  // $
= 1
  == (a)
    取函数：
    $
      f(x, y) = 1 - norm((x + y)/2), forall x, y in {x | norm(x) = 1}
    $
    注意到有限维 Banach 空间中，这是紧集上的连续函数，因此一致连续。换言之：
    $
      forall epsilon > 0, exists delta > 0, abs(x_1 - x_2) < delta and abs(y_1 - y_2) < delta => abs(f(x_1, y_1) - f(x_2, y_2)) < epsilon(delta) 
    $
    在上式中，如果总是取 $y_1 = x_2 = y_2 := y, x_1 := x$，则：
    $
      forall epsilon > 0, exists delta > 0, abs(x - y) < delta => abs(f(x_1, y_1)) < epsilon
    $
    在上面公式中选取 $epsilon_n = 1/n$，便可得到对应的 $delta_n$，无妨设 $delta_n$ 单调减少 $->0$，并取：
    $
      epsilon(delta) = cases(
        1 quad delta > delta_1,
        1/n quad delta_(n + 1) <= delta < delta_n
      )
    $
    可以验证：
    - $epsilon(delta)$ 单调增加
    - $lim_(delta -> 0+) epsilon(delta) = 0$
    - 任取 $x, y$：
      - 若 $norm(x - y) > delta_1$，则：
        $
          norm((x + y)/2) <= 1 + 1 = 1 + epsilon(norm(x - y))
        $
      - 若 $norm(x - y) < delta_n$，则：
        $
          abs(f(x, y)) < 1/n => norm((x + y)/2) <= 1 + 1/n <= 1 + epsilon(norm(x - y))
        $
    因此 $epsilon(delta)$ 就是我们要找的函数
  == (b)
    $dist(y_0, M) = 0$ 的情形是平凡的，下设 $dist(y_0, M) := d > 0$
    #lemmaLinear[][
      设 $norm(x) = norm(y) = r$
      $
        norm((x + y)/2) <= r(1 - epsilon((norm(x - y))/r))
      $
    ]
    #proof[
        $
          norm((x + y)/2) = r norm((x/r + y/r)/2) <= r (1 - epsilon(norm(x/r - y/r))) = r (1 - epsilon(norm(x - y)/r))
        $
    ]

    取一列 $x_i$ 使得 $norm(y_0 - x_i) -> d := dist(y_0, M)$，则：
    // $
    //   d <= norm(y_0 - (x_i + x_j)/2) = norm((y_0 - x_i)/2 + (y_0 - x_j)/2) < 1/2 (norm(y_0 - x_i) + norm(y_0 - x_j)) (1 - epsilon(norm(x_i - x_j)))\
    //   1 - epsilon(norm(x_i - x_j)) >= (2 d)/(norm(y_0 - x_i) + norm(y_0 - x_j))\
    // $
    $
      d <= norm(y_0 - (x_i + x_j)/2) = norm((y_0 - x_i)/2 + (y_0 - x_j)/2)
    $
    设：
    $
      alpha_i = d/(norm(y_0 - x_i)) (y_0 - x_i), beta_i = y_0 - x_i - alpha_i
    $
    显然有：
    $
      norm(alpha_i) = d\
      norm(beta_i) = (1 - d/(norm(y_0 - x_i))) norm(y_0 - x_i) -> 0 => beta_i -> 0\
      x_i = alpha_i + beta_i
    $
    同时：
    $
      d <= norm((y_0 - x_i)/2 + (y_0 - x_j)/2) = norm((alpha_i + alpha_j)/2 + (beta_i + beta_j)/2) <= norm((alpha_i + alpha_j)/2) + norm(beta_i + beta_j)/2\
      <= d(1 - epsilon(norm(alpha_i - alpha_j)/r)) + norm(beta_i)/2 + norm(beta_j)/2
    $
    令 $i, j$ 充分大，不难发现一定有 $epsilon(norm(alpha_i - alpha_j)/r) -> 0$，由 $epsilon$ 的性质只能 $norm(alpha_i - alpha_j) -> 0$，因此 $alpha_i$ 具有柯西性，进而收敛。另外，由于 $x_i = alpha_i + beta_i$ 而 $beta_i -> 0$，因此 $x_i$ 也收敛，极限点当然就是最小值点。

    之前的结论事实上意味着对于任意满足 $norm(y_0 - x_i) -> d$ 的数列 $x_i$ 都有 $x_i$ 收敛，假设有两个最小值点 $x_1, x_2$，则数列 $x_1, x_2, x_1, x_2, ...$ 当然满足上面的条件，继而收敛，只能 $x_1 = x_2$，这意味着最小值点唯一。
  == (c)
    设 $norm(x) = norm(y) = 1$，使用 Clarkson 不等式：
    - $p >= 2$ 时有： 
      $
        norm(x + y)^p + norm(x - y)^p <= 1/2 (norm(x)^p + norm(y)^p) = 1\
        norm(x + y)^p <= 1 - norm(x - y)^p\
        norm(x + y) <= (1 - norm(x - y)^p)^(1/p) <= 1 - 1/p norm(x - y)^p
      $
    - $1 < p < 2$ 时有：
      $
        norm(x + y)^q + norm(x - y)^q <= (1/2 (norm(x)^p + norm(y)^p))^(q/p) = 1\
        norm(x + y)^q <= 1 - norm(x - y)^q\
        norm(x + y) <= (1 - norm(x - y)^q)^(1/q) <= 1 - 1/q norm(x - y)^q
      $
    显然一致凸性成立。
    // 首先，设:
    // $
    //   f(t) = abs((x + (x + t))/2)^p - 1/2 abs(x)^p - 1/2 abs(x + t)^p, abs(x + t), abs(x) <= 1
    // $
    // 注意到：
    // $
    //   abs(f'(t)) <= p/2 abs((x + (x + t))/2)^(p - 1) + p/2 abs(x + t)^(p - 1) <= p
    // $
    // 因此：
    // $
    //   f(t) - f(0) <= p abs(t)
    // $
    // 也就是：
    // $
    //   abs((x + y)/2)^p <= 1/2 abs(x)^p + 1/2 abs(y)^p 
    // $
    // 设 $x, y in l^p, norm(x) = norm(y) = 1$，则由 $abs(x)^p$ 的凸性：
    // $
    //   abs(x_i + y_i)^p = abs(t (x_i)/t + (1-t) y_i/(1 - t))^p <= abs(x_i)/t^(t-1) + abs(y_i)/(1 - t)^(1-t)
    // $