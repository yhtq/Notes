#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 2.3.6
  由题设，任取 $x in X, lambda_n : RR^+ -> 0$ 有：
  $
     liminfn(p(lambda_n x)) = liminfn(lambda_n) p(x) = 0 >= p(0)
  $
  因此 $p(0) = 0$，设：
  $
    B_n = Inv(p)([0, n])
  $
  则：
  $
    X = Union_n B_n
  $
  - 断言 $B_n$ 是闭集：任取 $x_i -> x_0$ 使得 $p(x_i) <= n$，都有：
    $
      p(x_0) <= liminfn(p(x_i)) <= n
    $
    因此 $x_0 in B_n$
  - 由 BCT 定理，必然存在某个 $n$ 使得其有内点，也即：
    $
      p(B(x_0, delta_0)) subset B_n
    $
    由 $p$ 的伸缩性，不妨设：
    $
      p(B(x_0, delta_0)) subset B_1
    $
    因此对于一般的 $x$ 就有：
    $
      p(x) = p(x_0 + x - x_0) <= p(x_0) + p(x - x_0) <= 1 + (2norm(x - x_0))/delta_0 p(delta_0/(2norm(x - x_0)) (x - x_0))\
      <= 1 + 2/delta_0 norm(x - x_0) \
      <= 1 + 2/delta_0 norm(x_0) + 2/delta_0 norm(x)\
    $
    由于 $p$ 的伸缩性，$p(x) <= M norm(x)$ 成立只需对模充分大的 $x$ 成立即可，因此上式蕴含结论
  // $
  //   x arrowb p(x) + p(-x) + norm(x) 
  // $
  // 构成 $X$ 上一个范数，且显然控制 $norm(*)$，断言该范数是完备的。事实上，任取该范数下柯西列 $x_n$，也即有 $n, m$ 充分大时：
  // $
  //   x arrowb p(x) + norm(x) < epsilon
  // $
  // 由范数的控制关系，显然 $x_n$ 是原范数下的柯西列，设其在原范数下收敛于 $x_0$，就有：
  // $
  //   liminf_(n -> +infinity) p(x_n - x_0) + norm(x_n - x_0) >= p(limn(x_n - x_0)) 
  // $
= 2.3.10
  对于一族有界线性算子 $T_n$，定义：
  $
    p(x) = sup_n (norm(T_n x))
  $
  （条件蕴含 $p(x) < +infinity$），我们验证 $p$ 满足上面的所有性质：前三条是容易的，对于最后一条，假设 $x_n -> x_0$，注意到：
  $
    norm(T_k x_n) >= norm(T_k (x_n - x_0)) + norm(T_k x_0) >= norm(T_k x_0)\
    sup_k norm(T_k x_n) >= sup_k norm(T_k x_0)
  $
  当然就有：
  $
    liminfn(p(x_n)) >= p(x_0)
  $
  因此可以得到结论：
  $
    sup_n (norm(T_n x)) <= M norm(x), forall x
  $
  显然就有 $norm(T_n) <= M, forall n$，证毕
= 2.3.12
  == (1)
    任取 $x_n -> x_0, x_n in N(T)$，有：
    $
      (x_n, 0) -> (x_0, 0)
    $
    由 $T$ 的图像是闭的，就有 $T x_0 = 0$，证毕
  == (2)
    - 假设 $N(T) = 0$ 且 $R(T)$ 是闭的，则 $T$ 产生 $X -> R(T)$ 的可逆线性映射，同时 $R(T)$ 也是完备的，逆算子定理立刻给出结论。
    - 假设 $norm(T x) >= alpha norm(x)$，首先容易验证 $T x = 0 => norm(T x) = 0 => norm(x) = 0 => x = 0$，因此 $T$ 是单射。此外，闭算子定理给出 $T$ 是有界线性算子，因此：
      $
        alpha norm(x) <= norm(T x) <= norm(T) norm(x)
      $
      将 $T$ 视作 $X -> R(T)$ 的双射，上式表明如果在 $R(T)$ 上赋予范数：
      $
        norm(y)_2 = norm(Inv(T) y)
      $
      则：
      - $T$ 是保范数的同构，因此 $R(T)$ 在新范数下完备
      - 新范数和原范数等价，因此 $R(T)$ 在原范数下也完备
      这就蕴含了 $R(T)$ 是闭的。
  == (3)
    记 $T' : X quo N(T) -> Y$ 是由 $T$ 诱导的映射，则总有 $N(T') = 0$，由 2 可知 $R(T)$ 是闭的当且仅当：
    $
      exists alpha > 0, norm(T' pi(x)) >= alpha norm(pi(x)), forall x in X\
      where pi : X -> X quo N(T) "是自然映射"
    $
    用商空间范数的定义立刻得到上式就是：
    $
      exists alpha > 0, norm(T' x) >= alpha d(x, N(T))
    $
= 2.4.4
  #let hx = $hat(x)$
  取 $hx_n = f arrowb f x_n in duelSpace(duelSpace(X))$，就有 $forall x in duelSpace(duelSpace(X)), sup_n norm(hx_n x) <+infinity$，Banach-Steinhaus 定理给出 $sup_n norm(hx_n) < +infinity$，同时：
  $
    norm(hx_n) = sup_(f != 0) norm(hx_n f)/norm(f) = sup_(f != 0) norm(f x_n)/norm(f)
  $
  由 Hahn-Banach 定理的推论，可以构造 $f$ 使得 $norm(f) = 1, f x_n = norm(x_n)$，因此有：
  $
    norm(x_n) <=  norm(hx_n)
  $
  进而 $x_n$ 有界
= 2.4.5
  不难发现：
  $
    rho(x, X_0) &= norm(pi(x))_(X quo X_0)\
    sup {abs(f(x)) | f in duelSpace(X), norm(f) = 1, f(X_0) = 0}
    &= sup {abs(f(x)) | f in duelSpace((X quo X_0)), norm(f) = 1}\
    &= norm(hat(pi(x)))
  $
  上面证明了 $norm(x) <=  norm(hx)$，事实上也有 $norm(hx) >= norm(x)$，这是因为：
  $
    norm(f x)/norm(f) <= (norm(f)norm(x))/norm(f) = norm(x)
  $
  因此 $norm(hx) = norm(x)$，得到题中结论成立
= 1.
  == (1)
    若 $P$ 是不超过 $n$ 次的多项式，注意到 $L_n P$ 是 $n$ 次多项式，且在 $n + 1$ 个点上与 $P$ 相同，当然就有 $L_n P = P$. 对于范数，显然有：
    $
      norm(L_n f) <= norm(f) norm(sumj0n(p_j (x))) <= norm(f) norm(sumj0n(abs(p_j (x))))
    $
    表明 $norm(L_n) <= sup_x (sumj0n(abs(p_j (x))))$，另一方面，取 $a_n$ 使得 $(sumj0n(abs(p_j (a_n)))) -> sup_x (sumj0n(abs(p_j (x))))$，而对每个 $n$，设 $f_n$ 在 $x_k$ 的取值是 $sgn p_k (a_n)$（这样的连续函数很容易构造），这样就有：
    $
      norm(f_n) = 1\
      norm(L_n f_n) = sumj0n(abs(p_j (a_n)))
    $
    令 $n -> +infinity$ 就有
    $
      norm(L_n) = sup_x (sumj0n(abs(p_j (x))))\
    $
  == (2)
    $
      sumj0n(abs(p_j (x))) = sumj0n(product_(i = 0, i!= j)^n abs(x - x_i)/abs(x_j - x_i))
    $
    取 $x = 1/(2n)$。计算：
    $
      product_(i = 1)^n abs(x - x_i) = product_(i = 1)^n abs(1/(2n) - i/n) = product_(i = 1)^n (i/n - 1/(2n))\
      = product_(i = 1)^n (2i - 1)/(2n) = (2n - 1)!!/(2n)^n = (2n)!/(2^(2n) n! n^n) approx sqrt(4 pi n) (2n)^(2n)/(2^(2n) n! n^n e^(2n)) approx  sqrt(2) 1/(e^(n)) = sqrt(2) e^(-n)
    $
    以及：
    $
      - ln product_(i = 0, i!= j)^n 1/abs(x_j - x_i) &= sum_(i < j) ln (x_j - x_i) + sum_(i > j) ln (x_i - x_j)\
      &= sum_(i < j) ln ((j-i)/n) + sum_(i > j) ln ((i - j)/n)\
      &<= integral_(0)^(j) ln((j - x)/n) dif x + integral_(j)^(n) ln((x - j)/n) dif x\ 
      &= integral_(0)^(j) ln(x/n) dif x + integral_(0)^(n - j) ln(x/n) dif x\ 
      &= integral_(0)^(j) ln(x) dif x + integral_(0)^(n - j) ln(x) dif x - n ln n\  
      &= j ln j - j + (n - j) ln(n - j) - (n - j) - n ln n\ 
      &= j ln j  + (n - j) ln(n - j) - n ln n - n\ 
      // &= sum_(i < j) ln (1 - (n - j + i)/n) + sum_(i > j) ln (1 - (n - i + j)/n)\
      // &<= sum_(i < j) (n - j + i)/n + sum_(i > j) (n - i + j)/n\
      // &= j (n - j)/n + (j (j - 1))/(2 n)  + (n - j) (n + j)/n - ((j + 1 + n)(n-j))/(2 n)\
      // &approx n/2 - j^2/n
    $
    因此：
    $
      sumj0n(product_(i = 0, i!= j)^n abs(x - x_i)/abs(x_j - x_i)) &>= sumj0n(prodi0n(abs(x - x_i))/(product_(i = 0, i!= j)^n abs(x_j - x_i)))\
      &approx sum_(j=0)^(n) sqrt(2) e^(-n + n ln n + n - j ln j - (n - j) ln(n - j))\
      &= sum_(j=0)^(n) sqrt(2) e^(n ln n - j ln j - (n - j) ln(n - j))\
      &approx 2 sum_(j=0)^(ceil(n/2)) sqrt(2) e^(n ln n - j ln j - (n - j) ln(n - j))\
      // &= sum_(j=0)^(n) sqrt(2) e^(n ln n - j ln (n - j) + j ln((n - j)/j) - (n - j) ln(n - j))\
      // &= sum_(j=0)^(n) sqrt(2) e^(n ln n - n ln (n - j) + j ln((n - j)/j))\
      // &= sum_(j=0)^(n) sqrt(2) e^(n ln (1 - j/n) + j ln((n - j)/j))\
      // &>= sum_(j=0)^(floor(n/4)) sqrt(2) e^(n ln (1 - 1/4) + j ln(3))\
      // &= sqrt(2) (3/4)^n sum_(j=0)^(floor(n/4)) 3^j\
      // &approx C (3/4)^n 3^(n/4)
      // &= sum_(j=0)^(floor(n/2)) sqrt(2) (1 - j/n)^(n)\
    $
    设 $f(x) = n ln n - x ln x - (n - x) ln (n - x)$，就有：
    $
      f'(x) = - ln x - 1 + ln(n - x) + 1 = ln(n/x - 1)
    $
    而 $f(0) = 0$，因此：
    $
      (f(x) - f(0))/(x - 0) = f'(xi) >= ln(n/x - 1)\
      f(x) >= x ln(n/x - 1)\
    $
    因此上式：
    $
      &>= 2 sum_(j=1)^(ceil(n/2)) sqrt(2) e^(j ln(n/j - 1))\
      &>= 2 sum_(j=1)^(ceil(n/4)) sqrt(2) e^(j ln(n/j - 1))\
      &>= 2 sum_(j=1)^(ceil(n/4)) sqrt(2) e^(j ln(3))\
      &>= 2 sum_(j=1)^(ceil(n/4)) sqrt(2) 3^j\
      &approx C 3^(n/4)\
    $
    故原式趋于无穷，由 Banach-Steinhaus 定理可能不可能对于任何 $f$ 都有 $L_n f -> f$
  == (3)
    设 $u(x) = (f(x) - L_n f)/(prodj0N(x - x_j))$，注意分子是可导的且在 $x_j$ 处均为零，因此该函数也是可导的。我们有：
    $
      f(z) - L_n f(z) - (prodj0N(z - x_j)) u(x) 
    $
    在 $z = x_j$ 时均取零，依次利用罗尔定理就存在 $xi$ 使得：
    $
      derN(f(xi) - L_n f(xi) - (prodj0N(z - x_j)) u(x) , z, n + 1) = 0
    $
    化简即为：
    $
      derN(f(xi), z, n) = (n + 1)! u(x)
    $
    这就是题中所要的结论。进而若下面的条件成立，就有：
    $
      abs(1/(n + 1)! f^((n + 1))(xi) prodj0N(x - x_j)) <= C^(n + 1)/(n + 1)! abs(prodj0N(x - x_j)) <= C^(n + 1)/(n + 1)! -> 0, forall x
    $
    继而 $limn(norm(L_n f - f)) = 0$
= 2
  
  若严格凸则显然有该条件成立（取 $lambda = 1/2$ 即可），反之由 Hahn-Banach 定理的推论，构造线性泛函 $f$ 使得 $norm(f) = 1, f((x + y)/2) = 1$，进而：
  $
    norm(f x) <= norm(f) norm(x) = 1\
    norm(f y) <= norm(f) norm(y) = 1\
    1 = norm((f x)/2 + (f y)/2) <= (norm(f x) + norm(f y))/2 = 1
  $
  因此不等式全部取等，同时由于 $CC$ 是严格凸的，若 $f x != f y$ 应该有 $norm((f x)/2 + (f y)/2) < 1$，进而只能有 $f x = f y = 1$，因此：
  $
    f(lambda x + (1 - lambda) y) = lambda f x + (1 - lambda) f y = 1
  $
  就有：
  $
    1 = norm(f(lambda x + (1 - lambda) y)) <= norm(f) norm(lambda x + (1 - lambda) y) < 1
  $
  矛盾！
  // $
  //   norm(1 - lambda) norm(y) = norm(lambda x + (1 - lambda) y - lambda x) <= norm(lambda x + (1 - lambda) y) + lambda norm(x)
  // $
  // 因此：
  // $
  //   norm(1 - lambda) < 1 + norm(lambda)
  // $
  // 此外：
  // $
  //   norm(lambda) = norm(lambda x + (1 - lambda) y - (1 - lambda) y) < 1 + norm(1 - lambda) 
  // $
  // 也即：
  // $
  //   norm(1 - lambda) > norm(lambda) - 1
  // $
  // 综上：
  // $
  //   norm(lambda) - 1 < norm(lambda - 1) < norm(lambda) + 1
  // $
  // 如果严格凸不成立，设 $norm(x/2 + y/2) = 1$（显然不可能 $> 1$），类似的有：
  // $
  //   2 norm(lambda) = norm(lambda x + (1 - lambda) y + (2 lambda - 1) y) < 1 + norm(2 lambda - 1)\
  //   2 norm(1 - lambda) = norm(lambda x + (1 - lambda) y + (1 - 2 lambda) x) < 1 + norm(1 - 2 lambda)\
  //   1 < norm(lambda x + lambda y + (1 - 2 lambda) y) <= 2 norm(lambda) + norm(2 lambda - 1)\
  //   1 < norm(1 - lambda) + norm(2 lambda - 1)\
  // $
  // 平行四边形公式给出：
  // $
  //   2 (norm(lambda)^2 + norm(1 - lambda)^2) = 1 + norm(2 lambda - 1)^2
  // $
  // 上两式给出：
  // $
  //   (2 norm(lambda) - 1)^2 < 2 (norm(lambda)^2 + norm(1 - lambda)^2) - 1\
  //   2 norm2(lambda) - 4 norm(lambda)  + 2 < 2 norm2(1 - lambda)\
  //   (norm(lambda) - 1)^2 < norm(1 - lambda)^2\
  //   norm(1 - lambda) > norm(lambda) - 1 and norm(1 - lambda) > 1 - norm(lambda)\
  // $
  // 同理可得：
  // $
  //   (norm(1 - lambda) - 1)^2 < norm(lambda)^2\
  //   norm(lambda) > norm(1 - lambda) - 1 and norm(lambda) > 1 - norm(1 - lambda)\
  // $
  // $
  //   norm(2 lambda - 1) <= 2 norm(lambda) + 1\
  //   2 (norm(lambda)^2 + norm(1 - lambda)^2) - 1 <= 4 norm2(lambda) + 4 norm(lambda) + 1\
  //   norm(1 - lambda)^2 <= (norm(lambda) + 1)^2
  // $
  // $
  //   norm(1/2(x + y) + i k (x + y)) < 1
  // $
  // 由实数情形，可设对于任何实数 $a$ 都有 $norm(a x + (1 - a) y) = 1$
  // $
  //   abs(1 - 2 b) <= norm(a x + (1 - a) y + b i (x + y)) < 1\
  //   b in (0, 1/2)\
  //   sqrt(a^2 + b^2) - sqrt((1 - a)^2 + b^2) = (a^2 - (1 - a)^2)/(sqrt(a^2 + b^2) + sqrt((1 - a)^2 + b^2))
  // $