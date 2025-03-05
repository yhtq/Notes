#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
P59 3, 6, 9, $7^*$
= 3
  $
    L = product_i 1_([theta, theta + 1])  (x_i)
  $
  因此所有满足 $forall i, x_i in [theta, theta + 1]$ 的估计都是最大似然估计。（假如没有，则任何估计都是最大似然估计）

  注意到：
  $
    E Xbar = E theta = theta + 1/2
  $
  因此 $Xbar - 1/2$ 就是一个无偏估计。
= 6
  #let sumf = $sumf(lower: 1, upper: n)$
  #let sumfB(body) = $sumfBr(body, lower: 1, upper: n)$
  #let prodf = $prodf(lower: 1, upper: n)$
  （假设 $min x_i >= theta_1$）
  $
    ln L &= sumfB(ln(1/theta_2 e^(- 1/theta_2 (x_i - theta_1))))\
    &= sumfB(-ln theta_2 - 1/theta_2 (x_i - theta_1))\
    &= - n ln theta_2  + n theta_1/theta_2 - 1/theta_2 sumfB(x_i)\
  $
  注意到上式随着 $theta_1$ 变大而变大，由取值范围得 $theta_1 = min x_i$
  $
    der(ln L, theta_2) = - n/theta_2 - n theta_1/theta_2^2 + 1/theta_2^2 sumfB(x_i) = 0\
    sumfB(x_i) = n theta_2 + n theta_1\
    theta_2 = sumf(x_i - theta_1) / n =  sumf(x_i - min x_i) / n
  $
  这就找到了最大似然估计。
= 9
  $
    Xbar = E X &= integral_(0)^(1) x (Gamma(theta + 1)/(Gamma(theta) Gamma(1))) x^(theta - 1) dif theta \
    &= integral_(0)^(1) Gamma(theta + 1)/(Gamma(theta) Gamma(1)) x^theta dif theta \
    &= Gamma(theta + 1)/((theta + 1) Gamma(theta) Gamma(1)) \
    &= (theta Gamma(theta))/((theta + 1) Gamma(theta) Gamma(1)) \
    &= (theta)/(theta + 1) \
  $
  因此：
  $
    theta = Xbar/(1 - Xbar)
  $
= 7
  $
    ln L &= sumfB(ln alpha - alpha ln eta + (alpha - 1) ln x_i - (x_i / eta)^alpha)\
    &= n ln alpha - n alpha ln eta + (alpha - 1) sumfB(ln x_i) - sumfB((x_i / eta)^alpha)\
  $
  - 对于任意 $alpha$，上式在 $eta -> 0, +infinity$ 时 $-> -infinity$，因此一定存在（关于 $eta$）的最大值
    // $
    //   der(ln L, eta) = -(n alpha)/eta + sumfB(alpha x_i/eta^2 (x_i/eta)^(alpha - 1)) = 0\
    //   sumfB(alpha x_i (x_i/eta)^(alpha - 1)) = n alpha eta\
    //   sumfB(x_i (x_i/eta)^(alpha - 1)) = n eta\
    // $
  - 对于上述最大值点 $eta_0$，上式在 $alpha -> 0$ 时 $-> -infinity$，而 $alpha -> +infinity$ 时，观察各项系数，除非：
    $
      x_i <= eta_0, forall i\
      sumfB(ln x_i) > n ln eta_0
    $
    否则不会 $-> +infinity$， 进而 $L$ 有最大值。事实上，上述条件是矛盾的，这是因为假设 $x_i < eta$，一定有：
    $
      sumfB(ln x_i) < sumfB(ln eta_0) = n ln eta_0
    $
    这就表明条件不能同时成立。
P60 10 11 12 8\*
= 10
  $
    Xbar = E X = c\
    overline(X^2) = E X^2 = integral_(c - theta)^(c + theta) 1/(2 theta) x^2 dif x = 1/6 (4 c^2 + (c - theta)^2 + (c + theta)^2) = c^2 + 1/3 theta^2\
    = Xbar^2 + 1/3 theta^2\
    theta = plus.minus sqrt(3 (overline(X^2) - 3 Xbar^2))
  $
= 11
  注意到 $X_i - Xbar tilde N(0, (n - 1)/n sigma^2)$，因此：
  $
    E (sumBrN((X_i - Xbar)^2)) = sumBrN(E (X_i - Xbar)^2) = sumBrN(((n - 1)/n sigma^2)) = (n - 1) sigma^2
  $
  $
    E ((lambda sumBrN((X_i - Xbar)^2) - sigma^2)^2) &= lambda^2 E (sumBrN((X_i - Xbar)^2))^2 - 2 lambda sigma^2 E (sumBrN((X_i - Xbar)^2) + sigma^4\
    &= lambda^2 E (sumBrN((X_i - Xbar)^2))^2 - 2 (n - 1) lambda sigma^4 + sigma^4\
  $
  其中：
  $
    E (sumBrN((X_i - Xbar)^2))^2 &= E (sumBrN((X_i - Xbar)^4) + 2 sum_(i < j) (X_i - Xbar)^2 (X_j - Xbar)^2)\
    &= sumBrN(E ((X_i - Xbar)^4)) + 2 sum_(i < j) E (X_i - Xbar)^2 (X_j - Xbar)^2\
    &= sumBrN(3 ((n - 1)/n sigma^2)^2) + 2 sum_(i < j) E (X_i - Xbar)^2 (X_j - Xbar)^2
  $
  #let Xip = $X'_i$
  #let Xjp = $X'_j$
  为了计算 $E (X_i - Xbar)^2 (X_j - Xbar)^2$，设 $Z = 1/n sum_(k != i, j) (X_k - mu), Xip = X_i - Xbar, Xjp = X_j - Xbar$，则：
  $
  Xip tilde N(0, sigma^2)\
  Xjp tilde N(0, sigma^2)\
  Z tilde N(0, (n - 2)/n^2 sigma^2)
  $ 
  它们相互独立，且：
  $
    X_i - Xbar = (n - 1)/n Xip - 1/n Xjp - Z\
    X_j - Xbar = (n - 1)/n Xjp - 1/n Xip - Z
  $
  因此：
  $
    E (X_i - Xbar)^2 (X_j - Xbar)^2 &= E ((n - 1)/n Xip - 1/n Xjp - Z)^2 ((n - 1)/n Xjp - 1/n Xip - Z)^2\
    &= E (-(n-1)/n^2 (Xip^2 + Xjp^2) + (n^2 - 2 n + 2)/n^2 Xip Xjp + Z^2 - (n - 2)/n (Xip + Xjp) Z)^2\
    &= E (-(n-1)/n^2 (Xip + Xjp)^2 + Xip Xjp + Z^2 - (n - 2)/n (Xip + Xjp) Z)^2\
    &= (n - 1)^2/n^4 E (Xip + Xjp)^4 + E (Xip Xjp)^2 + E Z^4 + (n - 2)^2/n^2 E (Xip + Xjp)^2 Z^2 \ &- 2 (n - 1)/n^2 E(Xip Xjp (Xip + Xjp)^2)-  2 (n - 1)/n^2 E Z^2 E (Xip + Xjp)^2\
    &= (n - 1)^2/n^4 E (Xip + Xjp)^4 + E (Xip Xjp)^2 + E Z^4 + (n^2 -6 n + 6)/n^2 E (Xip + Xjp)^2 Z^2 \ &- 4 (n - 1)/n^2 E(Xip^2 Xjp^2)   \
    &= (n - 1)^2/n^4 (12 sigma^4) + sigma^4 + 3 ((n - 2)/n^2 sigma^2)^2 + (n^2 -6 n + 6)/n^2 dot (n - 2)/n^2 (2 sigma^4) \ &- 4 (n - 1)/n^2 sigma^4\
    &= (12(n-1)^2 + n^4 + 3 (n - 2)^2 + 2(n-2)(n^2 -6 n + 6) - 4 n^2 (n - 1))/n^4 sigma^4\
    &= (n^4 - 2 n^3 + 3 n^2)/n^4 sigma^4\
    &= (n^2 - 2 n + 3)/n^2 sigma^4\
    // &= (n - 1)^2/n^4 E (Xip^2 + Xjp^2)^2 + (n^2 - 2 n + 2)^2/n^4 E (Xip Xjp)^2 + E Z^4 + (n - 2)^2/n^2 E (Xip + Xjp)^2 Z^2 \ &- 2 (n - 1)/n^2 E Z^2 E (Xip^2 + Xjp^2)\
    // &= (n - 1)^2/n^4 (3 sigma^4 + 3 sigma^4 + 2 sigma^4) + (n^2 - 2 n + 2)^2/n^4 sigma^4 + 3 ((n - 2)/n^2 sigma^2)^2 + (n - 2)^2/n^2 dot (n - 2)/n^2 (2 sigma^4) \ &- 2 (n - 1)/n^2 dot (n - 2)/n^2 2 sigma^4\
    // &= (8(n-1)^2 + (n^2 - 2 n + 2)^2 + 3 (n- 2)^2 + 2 (n - 2)^3 - 2 (n - 1) (n - 2))/n^4 sigma^4\
    // &= (9(n-1)^2  + 3 (n- 2)^2 + 2 (n - 2)^3 - 2 (n - 1) (n - 2))/n^4 sigma^4\
    // &= (2 n^3 - 2 n^2 + 1)/n^4 sigma^4\
    // &= (E ((n - 1)/n Xip - 1/n Xjp - Z) ((n - 1)/n Xjp - 1/n Xip - Z))^2 + var((n - 1)/n Xip - 1/n Xjp - Z) ((n - 1)/n Xjp - 1/n Xip - Z))\
    // &= ((n - 2)/n^2 sigma^2 - (2(n - 1))/n^2 sigma^2)^2 + var((n - 1)/n Xip - 1/n Xjp - Z) ((n - 1)/n Xjp - 1/n Xip - Z)\
    // &= (1/n sigma^2)^2 + var((n - 1)/n Xip - 1/n Xjp - Z) ((n - 1)/n Xjp - 1/n Xip - Z)\
    // &= (1/n sigma^2)^2 + 2 (n-1)^2/n^4 2 dot sigma^4 + 2 (n-2)^2/n^4 sigma^4\
    // &= E ((n - 1)/n Xip - 1/n Xjp - Z)^2 E (((n - 1)/n Xjp - 1/n Xip - Z)^2) \ &+ cov(((n - 1)/n Xip - 1/n Xjp - Z)^2, ((n - 1)/n Xjp - 1/n Xip - Z)^2)\
    // &= (((n-1)^2/n^2 + 1/n^2 + (n-2)/n^2) sigma^2)^2  + cov(((n - 1)/n Xip - 1/n Xjp - Z), ((n - 1)/n Xjp - 1/n Xip - Z))\
    // &= ((n - 1)/n sigma^2)^2  + cov(((n - 1)/n Xip - 1/n Xjp - Z)^2, ((n - 1)/n Xjp - 1/n Xip - Z)^2)\
    // &= ((n - 1)/n sigma^2)^2  + (n - 1)/n^2 (var Xip + var Xjp) + var Z\
    // &= ((n - 1)/n sigma^2)^2  + (2 n - 2)/n^2 sigma^2 + (n - 2)/n^2 sigma^2\
    // &= ((n - 1)^2 + 3 n - 4)/n^2 sigma^4\
    // 
    // #(12 + 16 - 16)/(16)
  $
  综上:
  $
    E (sumBrN((X_i - Xbar)^2))^2 &= (3 (n-1)^2/n + (n - 1) (n^2 - 2 n + 3)/n) sigma^4\
    &= (n-1)/n (3 (n - 1) + n^2 - 2 n + 3) sigma^4\
    &= (n-1)/n (n^2 + n) sigma^4\
    &= (n-1)(n + 1) sigma^4\
  $
  均方误差为：
  $
    (lambda^2 (n-1)(n + 1) - 2 (n - 1)lambda + 1) sigma^4
  $
  作为 $lambda$ 的二次函数，极小值点为 $1/(n + 1)$，因此 $lambda$ 越靠近 $1/(n + 1)$，均方误差越小。
= 12
  $
    L = product_i beta^alpha / Gamma(alpha) x_i^(alpha - 1) e^(- beta x_i)\
    = beta^(n alpha) / Gamma(alpha)^n (product_i x_i)^(alpha - 1) e^(- beta sum_i x_i)
  $
  结论是显然的
= 8
  设：
  $
    L = beta^(n alpha) / Gamma(alpha)^n A^(alpha - 1) e^(- beta B)
  $
  其中 $A, B$ 是上述统计量，则：
  $
    ln L = n alpha ln beta - n ln Gamma(alpha) + (alpha - 1) ln A - beta B
  $
  - 对于 $beta$，无论其他参数如何，当 $beta -> 0, +infinity$ 时上式都 $-> -infinity$，因此一定有最大值点
  - 对于 $alpha$，无论其他参数如何，当 $alpha -> 0, +infinity$ 时上式也都 $-> -infinity$，因此一定也有最大值点
  综上，最大似然函数一定有最大值点。