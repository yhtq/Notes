#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1
  $
    L &= product_i p(1 - p)^(x_i - 1)\
    ln L &= sum_i ln p + (x_i - 1) ln (1 - p)\
         &= n ln p + ln (1 - p) sum_i (x_i - 1)\
  $
  令其最大，令：
  $
    0 = der(ln L, p) = n / p - (sum_i (x_i - 1))/(1 - p)\
    n (1 - p) = p sum_i (x_i - 1)\
    (n + sum_i x_i - n) p = n\
    p = n / (sum_i x_i)
  $
= 2
  $
    L &= product_i 1/(2 sigma) e^(- 1/sigma abs(x_i))\
    ln L &= sum_i (- 1/sigma abs(x_i) - ln (2 sigma))\
         &= - 1/sigma sum_i abs(x_i) - n ln (2 sigma)\
    0 = der(ln L, sigma) &= 1/sigma^2 sum_i abs(x_i) - n / (sigma)\
    sigma &= (sum_i abs(x_i)) / n
  $
= 4
  $
    L &= product_i (1/2 NormalDis(x_i, 0, 1) + 1/2 NormalDis(x_i, mu, sigma))\
    &= (1/2 1/sqrt(2 pi))^n product_i (eNX2dY(x_i, 2) + 1/sigma eNX2dY(x_i - mu, 2 sigma^2))\
    ln L &= n ln (1/2 1/sqrt(2 pi)) sum_i ln(eNX2dY(x_i, 2) + 1/sigma eNX2dY(x_i - mu, 2 sigma^2))\
    // der(ln L, mu) &= 
    // sum_i ( 1/sigma  (x_i - mu)/sigma^2 (x_i - mu)^2/(2 sigma^2) e^(- (x_i - mu)^2/(2 sigma^2))) 
    // / 
    // (eNX2dY(x_i, 2) + 1/sigma eNX2dY(x_i - mu, 2 sigma^2))
  $
  假设 $x_i = 0$，上式变成：
  $
    n ln (1/2 1/sqrt(2 pi)) sum_i ln(eNX2dY(0, 2) + 1/sigma e^(- mu^2/(2 sigma^2)))
  $
  显然 $mu = 0$ 时最优，然而此时随着 $sigma -> 0$，上式一直增大，因此 $sigma$ 没有最佳的估计值
= 5
  相当于 $n = 70$ 个两点分布 $P(X = 1) = p$ 的简单样本，有：
  $
    L = p^12 (1 - p)^58\
    ln L = 12 ln p + 58 ln (1 - p)\
    der(ln L, p) = 12 / p - 58 / (1 - p) = (12 - 70 p)/(p(1-p))
  $
  因此当 $p >= 12/70$ 时，上式一直减小。在 $1/2 <=p <= 2/3$ 范围内最大似然估计为 $p = 1/2$，无范围时 $p$ 的最大似然估计为 $12 / 70$
