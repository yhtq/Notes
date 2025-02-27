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
