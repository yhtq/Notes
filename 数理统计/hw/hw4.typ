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
P60 17 19 22 20\*
= 17
  $
    E (ln (1 + X)) &= integral_0^infinity ln (1 + x) theta/(1 + x)^(theta + 1) dif x\
    &= - integral_0^infinity ln (1 + x) dif 1/(1 + x)^(theta)\
    &= integral_0^infinity 1/(1 + x)^(1+theta) dif x\
    &= 1/theta
    // &= integral_0^infinity ln (1 + x) theta e^(-(1 + theta) ln (1 + x)) dif x\
    // &= - integral_0^infinity theta/(1 + theta) dif e^(-(1 + theta) ln (1 + x))\
  $
  因此 $ln (1 + X)$ 就是无偏统计量
= 19
  使用 MLE：
  $
    ln L = - n ln pi - sumBrN1(ln (1 + (x_i - theta)^2))\
    0 = partialDer(ln L, theta) = - sumBrN1(2(theta - x_i)/(1 + (theta - x_i)^2))
  $
  对于上式右侧，$theta >= max x_i$ 时为负，$theta <= min x_i$ 时为正，因此一定有解，其解作为 $theta$ 的最大似然估计。 
= 22
  由于 $E Xbar = E X = lambda$，强大数律给出它就是强相合的估计
= 20
  记 $S = sumBrN1(x_i)$，则：
  $
    ln L(theta) = cases(
      S ln theta + (n - S) ln (1 - theta) quad theta in QQ,
      // (1 - theta)^S theta^(n - S) quad theta in QQ^c
      S ln (1 - theta) + (n - S) ln theta quad theta in QQ^c
    )
  $
  第一种情况求导得：
  $
    0 = S/theta - (n - S)/(1 - theta) => (1 - theta) S - (n - S) theta = 0 => theta = S/n 
  $
  第二种情况求导得：
  $
    0 = -S/(1 - theta) + (n - S)/theta => theta S - (n - S) (1 - theta) = 0 => theta = S/n
  $
  因此一定有 $htheta = Xbar$

  然而：
  $
    E Xbar = E X = cases(
      theta quad theta in QQ,
      1 - theta quad theta in QQ^c
    )
  $
  显然 $E Xbar = theta$ 不恒成立。
  
p65 24 25 27 21\*
= 24
  $n$ 较大时，中心极限定理给出：
  $
    (Xbar - n p)/(sqrt(n p q)) tilde N(0, 1)
  $
  因此选择 $lambda > 0$ 使得：
  $
    P(-lambda <= X <= lambda) = 1 - alpha
  $
  其中 $X tilde N(0, 1)$，再反解：
  $
    -lambda <= (Xbar - n p)/(sqrt(n p (1 - p))) < lambda\
    (Xbar - n p)^2 <= lambda^2 n p (1- p)\
    (n^2 + n lambda^2) p^2 - (2 n Xbar + lambda^2 n)p + Xbar^2 <= 0
  $
  解出 $p$ 即得置信水平为 $1 - alpha$ 的置信区间
= 25
  熟知：
  $
    ((n - 1)S^2)/sigma^2 tilde chi^2(n - 1)
  $
  因此：
  $
    var(((n - 1)S^2)/sigma^2) = 2(n - 1)\
    var(S^2) = (2 sigma^4)/(n - 1)
  $
= 27
  #let xs = (249, 254, 243, 268, 253, 269, 287, 241, 273, 306, 303, 280, 260, 256, 278, 344, 304, 283, 310)
  #let S2 = calcSampleVariance(xs)
  熟知 $((n - 1)S^2)/sigma^2 tilde chi^2_(n - 1)$，取临界值 $lambda_1, lambda_2$ 使得：
  $
    P(X <= lambda_1) = (1 - beta)/2\
    P(X > lambda_2) = (1 - beta)/2
  $
  查表得 $beta = 0.95$ 时，$lambda_1 = 8.231, lambda_2 = 31.526$，反解：
  $
    lambda_1 <= ((n - 1)S^2)/sigma^2  < lambda_2\
     ((n - 1)S^2)/lambda_2 approx #calc.round(((19 - 1) * S2 / 31.526), digits: 2) < sigma^2 <= #calc.round(((19 - 1) * S2 / 8.231), digits: 2) approx ((n - 1)S^2)/lambda_1\
    #calc.round(calc.sqrt((19 - 1) * S2 / 31.526), digits: 2) < sigma <= #calc.round(calc.sqrt((19 - 1) * S2 / 8.231), digits: 2)
  $
= 21
  $
    L = prodBrN1(1/2 e^(- abs(x_i - theta))) = (1/2)^n e^(- sumBrN1(abs(x_i - theta)))\
  $
  最大似然转换为求 $sumBrN1(abs(x_i - theta))$ 的最小值。事实上，不难验证其最小值点就是所有 $x_i$ 的中位数。因此取 $htheta$ 为 $x_i$ 的中位数就是最大似然估计。同时，可以计算 $htheta$ 的分布函数：
  $
    P(htheta <= x) = P("至少" ceil(n/2) "个样本落在" (-infinity, x]) = sum_(k = ceil(n/2))^n C_n^k p^k (1 - p)^(n - k)
  $
  其中 $p = P(X <= x)$
  #lemmaLinear[][
    假设随机变量 $X$ 存在唯一的中位数 $m$，则样本中位数强收敛于 $m$
  ]
  #proof[
    记前 $n$ 个样本的中位数为 $m_n$，对于任何的 $n$ 和 $epsilon > 0$ 有：
    $
      P(m_n > m + epsilon) = P("至少" ceil(n/2) "个样本落在" (m + epsilon, +infinity))\
      = P(X_p >= ceil(n/2))
    $
    其中 $X_p tilde B(n, p := P(X > m + epsilon))$，同时由 $X$ 的中位数唯一，一定有 $p < 1/2$

    中心极限定理表明 $n$ 充分大时有：
    $
      (X_p - n p)/sqrt(n p (1 - p)) tilde N(0, 1)
    $
    也即：
    $
      P(X_p >= ceil(n/2)) approx P(Z >= (ceil(n/2) - n p)/sqrt(n p (1 - p)))\
    $
    其中 $Z tilde N(0, 1)$，注意到：
    $
      (ceil(n/2) - n p)/sqrt(n p (1 - p)) = (1/2 - p)/sqrt(p (1 - p))  sqrt(n)
    $
    而：
    $
      integral_(t)^(+infinity) NormalDis(x, 0, 1) dif x <= 1/t integral_(t)^(+infinity) x NormalDis(x, 0, 1) dif x tilde O(e^(-t^2/2)/t)
    $
    总之：
    $
      P(m_n > M + epsilon) = P(X_p >= ceil(n/2)) = O(e^(-n^2/2)/sqrt(n))\
      sumBrN1inf(P(m_n > M + epsilon)) < sumBrN1inf(O(e^(-n^2/2)/sqrt(n))) < +infinity
    $
    同理可证：
    $
      sumBrN1inf(P(m_n < M - epsilon)) < +infinity
    $
    因此：
    $
      sumBrN1inf(P(abs(m_n - m) > epsilon)) < +infinity  
    $
    由 B-C 引理和 $epsilon$ 的任意性，一定有 $m_n ->^("a.s.") m$
  ]
  回到原题，显然 $theta$ 就是唯一的中位数，因此最大似然估计是强相合的。