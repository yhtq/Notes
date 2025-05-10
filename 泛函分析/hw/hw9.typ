#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 2.6.2
  设 $X_0 = span(x_1, x_2, ..., x_n)$，不难发现 $A X_0 subset X_0$，因此 $A |_(X_0)$ 是有限维空间上的线性自同态，并且 $lambda_1, lambda_2, ..., lambda_n$ 都是它的特征值，表明 $dim X_0 >= n$，继而 $x_i$ 线性无关。
= 2.6.3
  首先不难验证 $A$ 是可逆的，因此下面都设 $lambda != 0$，我们有：
  $
    (A x) (i) = x(i + 1)\
    ((lambda I - A) x) (i) = lambda x(i) - x(i + 1)\
    sum_(k = i)^(+infinity) 1/lambda^k ((lambda I - A) x) (k) = sum_(k = i)^(+infinity) 1/lambda^k (lambda x(k) - x(k + 1))\
    = sum_(k = i)^(+infinity) x(k)/(lambda^(k - 1)) - x(k + 1)/lambda^k\
    = x(i)/(lambda^(i - 1)) - limn(x(n + 1)/lambda^n)
  $
  因此只要 $abs(lambda) > 1$，就可以定义线性泛函：
  $
    B_lambda x (i) = lambda^(i - 1) sum_(k = i)^(+infinity) 1/lambda^k x (k)
  $
  立刻就有：
  $
    B_lambda (lambda I - A) = I
  $
  以及：
  $
    ((lambda I - A) B_lambda x) (i) = (lambda I - A) (i arrowb lambda^(i - 1) sum_(k = i)^(+infinity) 1/lambda^k x (k)) (i) \
    = lambda lambda^(i - 1) sum_(k = i)^(+infinity) 1/lambda^k x (k) - lambda^(i) sum_(k = i + 1)^(+infinity) 1/lambda^k x (k)\
    = lambda^i 1/lambda^i x(i) = x(i)
  $
  因此 $B_lambda$ 就是 $lambda I - A$ 的逆。而当 $abs(lambda) < 1$ 时，注意到：
  $
    sum_(k = -infinity)^(i - 1) 1/lambda^(k + 1) ((lambda I - A) x) (k) = sum_(k = -infinity)^(i - 1) 1/lambda^(k + 1) (lambda x(k) - x(k + 1))\
    = - x(i)/lambda^i
  $
  因此可以定义：
  $
    B_lambda x (i) = - lambda^i sum_(k = -infinity)^(i - 1) 1/lambda^(k + 1) x (k)
  $
  同样可以验证它是 $lambda I - A$ 的逆。

  接下来，假设 $abs(lambda) = 1$，仿照上面的计算可以得到：
  $
    sum_(k = -infinity)^(+infinity) 1/lambda^k ((lambda I - A) x) (k) = 0
  $
  然而另一方面，容易在 $l^2$ 中取得 $y$ 使得 $sum_(k = -infinity)^(+infinity) 1/lambda^k y (k) != 0$，例如就取 $y(k) = 1/n^2 lambda^k$ 就容易验证前式不成立，因此 $lambda I - A$ 总不是满射，继而 $sigma (A)$ 就是单位圆盘。接下来，证明：
  - $lambda I - A$ 总是单射：事实上，若： 
    $
      (lambda I - A) x = 0 <=> forall i, lambda x(i) = x(i + 1)\
    $
    则立刻有：
    $
      x(i) = lambda^i x(0)\
    $
    然而 $x in l^2$，也即：
    $
      sum_(k = -infinity)^(+infinity) abs(lambda^i x(0))^2 = sum_(k = -infinity)^(+infinity) abs(x(0))^2 < +infinity
    $
    只能是 $x(0) = 0 => x = 0$
  - $closure(im (lambda I - A)) = l^2$，只需取 $y in orthogonalCom(im (lambda I - A))$，证明 $y = 0$ 即可。我们有：
  $
    inner(y, (lambda I - A) x) = inner((overline(lambda) I - duel(A)) y, x) = 0, forall x => y in ker (overline(lambda) I - duel(A))
  $
  可以验证 $duel(A)$ 就是左平移，而仿照 $lambda I - A$ 是单射的证明，$overline(lambda) I - duel(A)$ 也是单射，进而 $y = 0$ 证毕。

  以上事实足以说明 $sigma(A) = sigma_c (A) = $ 单位圆盘 
= 1.  
  == (1)
    $
      lambda I - (T + z I) = (lambda - z) I - T\
      lambda I - z Y = z (lambda / z I - Y)
    $
    因此结论是容易的
  == (2)
    此时显然有 $lambda != 0$，注意到：
    $
      lambda I - Inv(A) = Inv(A) lambda (A - 1/lambda I)
    $
    而 $Inv(A) lambda$ 可逆，因此上式可逆当且仅当 $A - 1/lambda I$ 可逆，也即 $1/lambda in sigma(A), lambda in Inv(sigma(A))$
  == (3)
    #lemmaLinear[][
      设 $A B = B A$，则 $A B$ 不可逆当且仅当 $A$ 不可逆或 $B$ 不可逆
    ]
    #proof[
      显然若 $A B$ 不可逆则 $A$ 或 $B$ 不可逆，反之，设 $A B$ 可逆，也即：
      $
        C A B = A B C = I\
      $ 
      立刻表明：
      $
        (C A) B = B (A C) = I\
      $
      熟知若环上的元素同时有左右逆，则左右逆相等，且恰为其逆，这就证明了 $B$ 可逆，同理 $A$ 也可逆。
    ]
    任取 $lambda in sigma(A^2)$，可设 $lambda = mu^2$，因此：
    $
      mu^2 I - A^2 = (mu I - A)(mu I + A)\
    $
    不可逆，进而 $mu I - A, mu I + A$ 至少有一个不可逆，因此 $lambda in (sigma(A))^2 => sigma(A^2) subset (sigma(A))^2$，另一方面，设 $mu in sigma(A)$，则引理保证：
    $
      (mu I - A)(mu I + A)
    $
    不可逆，因此 $mu^2 in sigma(A^2) => (sigma(A))^2 subset sigma(A^2)$
  == (4)
    #lemmaLinear[][
      $A$ 可逆当且仅当 $duel(A)$ 可逆
    ]
    #proof[
      - 若 $A$ 可逆，设 $B$ 是其逆，不难验证 $duel(B)$ 是 $duel(A)$ 的逆
      - 若 $duel(A)$ 可逆，设其逆为 $B$，则有：
        $
          inner(duel(A) y, x) = inner(y, A x)\
          inner(y, x) = inner(B y, A x)
        $
        - 若 $A x = 0$，则 $forall y, inner(y, x) = 0$，导致 $x = 0$，因此 $A$ 是单射
        - 若 $closure(im A) != X$，由 Hahn-Banach 定理推论可以构造 $y$ 使得 $y |_(closure(im A)) = 0, y != 0$，代入上式就有 $forall x, inner(duel(A) y, x) = 0 => duel(A) y = 0 => y = 0$ 矛盾！
        注意到：
        $
          norm(A x)/norm(x) 
          &= sup_y (inner(y, A x))/(norm(x) norm(y)) \
          &= sup_y (inner(duel(A) y, x))/(norm(x) norm(y))\
          &=  sup_y (inner(y, x))/(norm(x) norm(B y))\
          &>=  sup_y (inner(y, x))/(norm(x) norm(y) norm(B))\
          &= 1/norm(B)
        $
        因此 $norm(A x) >= 1/norm(B) norm(x)$，这意味着 $norm(A x)$ 是与 $norm(x)$ 等价的范数，进而 $im A$ 是闭的，结合上面的结论就有 $im A = X$，$A$ 是双射，证毕。
    ]
    注意到 $duel(lambda I - A) = lambda I - duel(A)$，由引理结论是显然的。
= 2.
  题干表明：
  $
  (lambda I - T) x_n -> 0 <=> \
  forall f, inner(f, (lambda I - T) x_n) = inner((lambda I - duel(T)) f, x_n) = inner(tau(x_n), (lambda I - duel(T)) f) -> 0
  $
  而 $norm(tau(x_n)) = 1$，熟知 $duel(duel(X))$ 中的单位球面#weakSCompact，因此不妨设 $tau(x_n) weakSConverge z$，继而：
  $
    forall f, inner(tau(x_n), (lambda I - duel(T)) f) -> inner(z, (lambda I - duel(T)) f) = 0\
  $
  假如 $lambda I - duel(T)$ 可逆，上式导致 $forall f, inner(z, f) = 0 => z = 0$，这是荒谬的，因此 $lambda in sigma(duel(T)) = sigma(T)$，证毕
= 3.  
  对于 $abs(lambda) > 1$ 注意到：
  $
    sum_(k = 0)^(+infinity) 1/lambda^(k) ((lambda I - A) f) (x + k t_0) = sum_(k = 0)^(+infinity) 1/lambda^(k) (lambda f(x + k t_0) - f(x + (k + 1) t_0))\
    = f(x) - limn(f(x + (n + 1) t_0)/lambda^(n))\
  $
  注意到 $f$ 有界，上式第二项为零，因此上式就是 $f(x)$，定义泛函：
  $
    B_lambda f (x) = lambda^k sum_(k = 0)^(+infinity) 1/lambda^(k) ((lambda I - A) f) (x + k t_0)
  $
  仿照之前习题，$B$ 就是 $lambda I - A$ 的逆。$abs(lambda) < 1$ 的情况类似。而当 $abs(lambda) = 1$ 时，考虑函数：
  $
    g(x) = 1/lambda^k f(x - k t_0) "if" x in [k t_0, (k + 1) t_0)\
  $
  其中 $f$ 是任何在 $0, t_0$ 之间有定义且 $f(0) = f(t_0)$ 的连续函数，可以验证此时 $g(x)$ 是有界连续函数，且 $(lambda I - A) g = 0$. 显然只要 $f$ 非零就有 $g$ 非零，因此 $lambda in sigma(A)$

  综上，$sigma(A) = $ 单位圆盘
= 4.
  == (1)
    用归纳法，$n = 0$ 时显然，否则：
    $
      (V (t arrowb 1/n! integral_(0)^(t) (t - y)^n f(y) dif y)) (x) &= integral_(0)^(x)1/n! integral_(0)^(t) (t - y)^n f(y) dif y dif t\ 
      &= integral_(0)^(x)1/n! f(y) integral_(y)^(x) (t - y)^n  dif t dif y\ 
      &= integral_(0)^(x)1/(n + 1)! f(y) (x - y)^(n + 1) dif y\ 
    $
    证毕。注意到:
    $
      norm(1/n! integral_(0)^(x) (x - y)^n f(y) dif y) <= 1/n! norm(f) max_(x in [0, 1]) integral_(0)^(x) (x - y)^n dif y = 1/(n + 1)!  norm(y)
    $
    继而 $norm(V^(n + 1)) <= 1/(n + 1)!$，由谱半径：
    $
      r(V) <= limn((1/n!))^(1/n) = 0
    $
    因此只能有 $sigma(V) = {0}$（注意到 $sigma(V)$ 非空）
  == (2)
    首先证明 $V$ 是单射（相当于 $0$ 不是特征值），设 $V f = 0$，也即：
    $
      forall x, integral_(0)^(x) f(y) dif y = 0 => forall x, der(integral_(0)^(x) f(y) dif y, x) = f(x) = 0
    $
    因此 $f = 0$

    其次，注意到若 $f in im V$，显然有 $f(0) = 0$，进而 $closure(im V) (0) = 0$ 因此对 $f$ 满足 $f(0) != 0$ 都有 $f in.not closure(im V)$，也即 $0$ 是剩余谱
= 5.  
  熟知：
  $
    sumi0N(A^n/n!) = 1/(2pi i) integral_(Gamma_r) (sumi0N(z^n/n!) Inv(z - A)) dif z \
    =  1/(2pi i) integral_(Gamma_r) (e^z Inv(z - A)) dif z - 1/(2 pi i) integral_(Gamma_r) (sum_(i = N + 1)^(+infinity) (z^n/n!) Inv(z - A)) dif z\
  $
  令 $N -> +infinity, norm(sum_(i = N + 1)^(+infinity) (z^n/n!))$ 充分小，进而上式第二项充分小，就得到了结论。进而：
  $
    e^((t + s) A) = (sumi0inf(t^i A^i/i!))(sumi0inf(s^i A^i/i!)) = sumi0inf(A^i/i! sum_(k = 0)^i (t^k s^(i - k)) i!/(k!(i - k)!)) = sumi0inf(((t + s) A)^i/i!)\
    e^(0) = 1/(2 pi i) integral_(Gamma_r)^() e^z/z I dif z =^("Cauthy 积分") e^0 I = I\ 
  $
  以及：
  $
    der(e^(t A), t) = sumi0inf(der(t^i, t) A^i/i!) = sumi0inf(i t^(i - 1) A^i/i!) = A e^(t A)\
  $