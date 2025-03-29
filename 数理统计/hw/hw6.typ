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