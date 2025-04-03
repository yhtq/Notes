#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
p139 1 2 3 5\*
= 1
  - 第一类错误也即 $p = 1/2$ 时：
    $
      P(x_1 + x_2 + x_3 >= 2) = P(X >= 2) = P(X = 2) + P(X = 3) = 3 (1/2)^3 + (1/2)^3 = 1/2 
    $
  - 第二类错误也即 $p = 3/4$ 时：
    $
      P(x_1 + x_2 + x_3 < 2) = P(X = 0) + P(X = 1) = (1/4)^3 + 3 (1/4)^2 (3/4) = 1/64 + 9/64 = 5/32
    $
  - 备择假设成立时的功效就是 $1 - $ 第二类错误概率 $= 27/32$
= 2
  - 第一类错误也即 $f(x) = f_0 (x)$ 时：
    $
      P(X in W) = integral_(W)^() f_0 (X) dif X
    $
  - 第二类错误也即 $f(x) = f_1 (x)$ 时：
    $
      P(X in.not W) = 1 - integral_W f_1 (X) dif X 
    $
= 3
  取:
  $
    phi (x) = cases(
      1 quad X > 7/2,
      0 quad X <= 7/2
    )
  $
  显然原假设成立时，$P(X <= 7/2) = 1$，而备择假设成立时，$P(X > 7/2) = 1$，因此两类错误的概率都是零。
= 5
  对于任何检验法 $delta$ 有：
  $
    alpha = E(delta | theta = theta_0) = integral_()^() delta(x) L(x, theta_0) dif x\
    beta = E(1 - delta | theta = theta_1) = integral_()^() (1 - delta(x)) L(x, theta_1) dif x
  $
  因此：
  $
    a alpha + b beta &=  integral_()^() (a L(x, theta_0) - b L(x, theta_1)) delta(x) dif x + integral_()^() L(x, theta_1) dif x\
    &= integral_()^() (a L(x, theta_0) - b L(x, theta_1)) delta(x) dif x + 1\
    &= integral_(a L(x, theta_0) - b L(x, theta_1) >= 0)^() (a L(x, theta_0) - b L(x, theta_1)) delta(x) dif x + integral_(a L(x, theta_0) - b L(x, theta_1) < 0)^() (a L(x, theta_0) - b L(x, theta_1)) delta(x) dif x + 1\
    &>=^(delta(x) in [0, 1]) integral_(a L(x, theta_0) - b L(x, theta_1) < 0)^() a L(x, theta_0) - b L(x, theta_1) dif x + 1
  $
  根据上面的放缩，显然对于检验法：
  $
    delta(x) = 1_(a L(x, theta_0) - b L(x, theta_1) < 0)
  $
  是取等的，这个检验法和 $delta^*$ 几乎处处相等，因此就证明了：
  $
    a alpha + b beta >= a alpha^* + b beta^* 
  $
p139 4 6 7 14^\*
= 4
  由 N-P 引理，使用似然比检验法即可。计算：
  $
    lambda(X) = (L_2 (x))/(L_1 (x)) = prodi0n(2 X_i)
  $
  临界值满足：
  $
    P_(f_0 (x)) (prodi0n(2 X_i) > lambda_0) = alpha\
    P_(f_0 (x)) (sumi0n(-ln X_i) <= C) = alpha\
  $
  而 $- ln X_i tilde "Exp"(1), sumi0n(-ln X_i) tilde Gamma(n, 1)$，根据 $Gamma$ 分布找到临界值即可。
= 6
  这些问题都是单参数指数型检验，且 $S^2 = sumi1n2(X_i - mu_0)$ 是一个完全充分统计量
  == (1)
    只需求临界值使得：
    $
      P_(sigma_0) (S^2 > C) = alpha\
      P_(sigma_0) (S^2/sigma_0^2 > C/sigma_0^2) = alpha\
    $
    而 $S^2/sigma_0^2 tilde chi^2(n)$，因此可以求得 $C$，检验法为：
    $
      phi(X) = 1_(S^2(X) > C) (X) 
    $
  == (2)
    只需求临界值使得：
    $
      P_(sigma_1) (S^2 in (C_1, C_2)) = alpha\
      P_(sigma_2) (S^2 in (C_1, C_2)) = alpha\
    $
    取 $X tilde chi^2(n)$，则上面的方程等价于：
    $
      P(X in (C_1/sigma_1^2, C_2/sigma_1^2)) = alpha\
      P(X in (C_1/sigma_2^2, C_2/sigma_2^2)) = alpha\
    $
    找到临界值，得到的检验法为：
    $
      phi(X) = 1_(S^2(X) in (C_1, C_2)) (X)
    $
= 7
  这是单参数指数型检验问题，$Xbar$ 是一个充分统计量。只需求临界值使得：
  $
    P_(mu_1) (Xbar in (C_1, C_2)) = alpha\
    P_(mu_2) (Xbar in (C_1, C_2)) = alpha\
  $
  取 $Z tilde N(0, 1)$，上面的方程等价于：
  $
    P(Z in ((C_1 - mu_1)/sqrt(n), (C_2 - mu_1)/sqrt(n))) = alpha\
    P(Z in ((C_1 - mu_2)/sqrt(n), (C_2 - mu_2)/sqrt(n))) = alpha\
  $
  找到临界值，得到的检验法为：
  $ 
    phi(X) = 1_(Xbar(X) in (C_1, C_2)) (X)
  $
= 14
  
  根据 $Gamma$ 函数的性质有：
  $
    limn(Gamma((n + 1)/2)/(Gamma(n/2) sqrt(n / 2))) = 1\
    limn(Gamma((n + 1)/2)/(Gamma(n/2) sqrt(n))) = 1/sqrt(2)\
  $
  而：
  $
    limn((1 + x^2/n)^(- (n + 1)/2)) = e^(-x^2/2)
  $
  因此：
  $
    limn(f_n (x)) = NormalDis(x, 0, 1)\
    si1N
  $