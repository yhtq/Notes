#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
p142 21 22 25 26\*
= 21.
  这是未知均值的方差检验问题，我们有：
  $
    S^2/sigma^2 tilde chi^2(8)
  $
  假设为：
  $
    H_0 : sigma <= 0.005
  $
  检验法为 $1_(S^2 > C)$，其中 $C$ 满足：
  $
    P_(X tilde chi^2(8)) (X > C/0.005^2) = 0.05
  $
  查表得：
  $
    C/0.005^2 = 15.51\
    C = #(15.51 * 0.005 * 0.005)\
  $
  计算得：
  $
    S^2 = #(calc.pow(0.007, 2)) < C
  $
  因此不拒绝假设，没有充分证据表明标准差显著偏大
= 22.
  #let data1 = (6.2, 5.7, 6.5, 6.0, 6.3, 5.8, 5.7, 6.0, 6.0, 5.8, 6.0)
  #let data2 = (5.6, 5.9, 5.6, 5.7, 5.8, 6.0, 5.5, 5.7, 5.5)
  这是多正态总体检验，假设为：
  $
    H_0 : sigma_0 = sigma_1
  $
  #data1.len()
  $
    F = (S^2_2) / (S^2_1) tilde F_(8, 10)
  $
  检验法形如 $1_(F < C_1 or F > C_2)$，其中：
  $
    P_(X tilde F_(8, 10)) (X < C_1) = 0.025\
    P_(X tilde F_(8, 10)) (X > C_2) = 0.025
  $
  查表得：
  $
    C_1 = 1 / 4.3 = #(1 / 4.3)\
    C_2 = 3.85
  $
  而：
  $
    F = #(calcSampleVariance(data2) / calcSampleVariance(data1))
  $
  因此不拒绝原假设
= 25
  #let data1 = (1.9, 0.8, 1.1, 0.1, -0.1, 4.4, 5.5, 1.6, 4.6, 3.4)
  #let data2 = (0.7, -1.6, -0.2, -1.2, -0.1, 3.4, 3.7, 0.8, 0, 2.0)
  #let S12 = calcSampleVariance(data1)
  #let S22 = calcSampleVariance(data2)
  #let Xb = calcMean(data1)
  #let Yb = calcMean(data2)
  这是方差不相等的均值检验，假设为：
  $
    H_0 : mu_X = mu_Y
  $
  统计量为：
  $
    T = (Xbar - Ybar) / sqrt(1/10(S_1^2 + S_2^2)) = #((Xb - Yb) / calc.sqrt(1 / 10 * (S12 + S22)))\
    m^* = ((S_1^2 +S_2^2) / 10)/(1/9 ((S_1^2/10)^2 + (S_2^2/10)^2)) = #((S12 + S22) / 10 / (1 / 9 * (calc.pow(S12 / 10, 2) + calc.pow(S22 / 10, 2))))\
  $
  因此 $T$ 近似服从 $t(25)$，近似检验法为 $1_(abs(T) > C)$，其中 $C$ 满足：
  $
    P_(X tilde t(25)) (abs(X) > C) = 0.05
  $
  查表得 $C = 2.06$，因此不拒绝原假设
= 26
  #let SXY2 = $S_(X Y)^2$
  #let XYb = $overline(X Y)$
  首先：
  $
    L(X, Y) = (prodi1n(1/sqrt(2 pi sigma^2) e^(-(X - mu_X)^2 / (2sigma^2)))) * (prodi1n(1/sqrt(2 pi sigma^2) e^(-(Y - mu_Y)^2 / (2sigma^2))))\
    ln L(X, Y) = sumi1n(-1/2 (ln (2 pi) + ln sigma^2) - (X - mu_X)^2 / (2sigma^2)) + sumi1m(-1/2 (ln (2 pi) + ln sigma^2) - (Y - mu_Y)^2 / (2sigma^2))\
    partialDer(ln L, sigma^2) = sumi1n(-1/2 1/sigma^2 + (X - mu_X)^2 / (2sigma^4)) + sumi1m(-1/2 1/sigma^2 + (Y - mu_Y)^2 / (2sigma^4)) = 0\
    sumi1n(1 - (X - mu_X)^2 / (sigma^2)) + sumi1m(1 - (Y - mu_Y)^2 / (sigma^2)) = 0\
    sigma^2 = 1/(n + m) (sumi1n(X - mu_X)^2 + sumi1m(Y - mu_Y)^2) := SXY2\
  $
  熟知不加假设时，$mu_X = Xbar, mu_Y = Ybar$，而加假设时 $mu = 1/(n + m) (sumi1n(X_i) + sumi1m(Y_i)) := XYb$， 再记 $F_1 = SXY2_2/SXY2_1$ 就有：
  $
    lambda &=  ((prodi1n(1/sqrt(2 pi SXY2_1) e^(-(X - mu_X)^2 / (2SXY2_1)))) * (prodi1n(1/sqrt(2 pi SXY2_1) e^(-(Y - mu_Y)^2 / (2SXY2_1)))))
    /
    ( (prodi1n(1/sqrt(2 pi SXY2_2) e^(-(X - mu)^2 / (2SXY2_2)))) * (prodi1n(1/sqrt(2 pi SXY2_2) e^(-(Y - mu)^2 / (2SXY2_2)))))\
    &= prodi1n( sqrt(F_1) e^(- ((X - mu_X)^2 / (2SXY2_1) - ((X - mu)^2 / (2SXY2_2))) )) * prodi1m( sqrt(F_1) e^(- ((Y - mu_Y)^2 / (2SXY2_1) - ((Y - mu)^2 / (2SXY2_2))) ))\
    &= F_1^((n + m)/2) e^(-(sumi1n(X - mu_X)^2 / (2SXY2_1) + sumi1m(Y - mu_Y)^2 / (2SXY2_1) -  (sumi1n(X - mu)^2 / (2SXY2_2) + sumi1m(Y - mu)^2 / (2SXY2))))\
    &= F_1^((n + m)/2)\
  $
  另一方面：
  $
    F_1 &= (sumi1n2(X - XYb) + sumi1m2(Y - XYb)) / (sumi1n(X - Xbar)^2 + sumi1m(Y - Ybar)^2)\
    &= (sumi1n2(X - Xbar) + n (Xbar - XYb)^2 + sumi1n2(X - Xbar) + m (Ybar - XYb)^2) / (sumi1n(X - Xbar)^2 + sumi1m(Y - Ybar)^2)\
    &= 1 + (n (Xbar - XYb)^2 + m (Ybar - XYb)^2) / (sumi1n(X - Xbar)^2 + sumi1m(Y - Ybar)^2)\
    &:= 1 + F_2
  $
  熟知 $Xbar$ 与 $sumi1n(X - Xbar)^2$ 独立，继而 $XYb$ 与 $sumi1n(X - Xbar)^2$ 独立，类似可得 $F_2$ 的分子与分母独立。此外:
  $
    F_2 = ((n (Xbar - XYb)^2 + m (Ybar - XYb)^2) \/ sigma^2) / ((sumi1n(X - Xbar)^2 + sumi1m(Y - Ybar)^2) \/ sigma^2) 
  $
  当假设成立时，记：
  $
    Z = vec(X, Y) tilde N(mu 1, sigma^2 I)
  $
  上式分子为：
  $
    n (1/n 1_x^T Z - 1/(m + n) 1^T Z)^2 + m (1/m 1_y^T Z - 1/(m + n) 1^T Z)^2\
    = quadFormSym(Z, n (1/n 1_x - 1/(m + n) 1) (1/n 1_x - 1/(m + n) 1)^T + m (1/m 1_y - 1/(m + n) 1) (1/m 1_y - 1/(m + n) 1)^T)\
    = quadFormSym(Z, 1/n 1_x 1_x^T - 2/(m + n) 1_x 1^T + n/(m + n)^2 1 1^T + 1/m 1_y 1_y^T - 2/(m + n) 1_y 1^T + m/(m + n)^2 1 1^T)\
    = quadFormSym(Z, 1/n 1_x 1_x^T - 2/(m + n) 1 1^T + 1/(m + n) 1 1^T + 1/m 1_y 1_y^T  )\
    = quadFormSym(Z, 1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T )\
  $
  注意到：
  $
    (1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T) (1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T) \
    = 1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T - 2/(m + n) 1 1^T (1/n 1_x 1_x^T + 1/m 1_y 1_y^T)\
    = 1/n 1_x 1_x^T + 1/m 1_y 1_y^T + 1/(m + n) 1 1^T - 2/(m + n) 1 (1_x^T + 1_y^T)\
    = 1/n 1_x 1_x^T + 1/m 1_y 1_y^T + 1/(m + n) 1 1^T - 2/(m + n) 1 1^T\
    = 1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T\
  $
  因此是幂等矩阵，其秩为：
  $
    rank(1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T) = tr(1/n 1_x 1_x^T + 1/m 1_y 1_y^T - 1/(m + n) 1 1^T) = 1
  $
  继而 $F_2$ 分子服从 $chi^2(1)$，分母服从 $chi^2(n + m -2)$ 且前面已经说明相互独立，因此 $(n + m - 2) F_2 tilde F(1, n + m - 2)$，由此构造检验法即可。
p143 28 29\*
p219 1 2
= 28
  #let data = (74, 92, 83, 79, 80, 73, 77, 75, 76, 91)
  #let calcT(data) = {
      let n = data.sum()
      data.map(
        v => calc.pow(v / n - 1 / data.len(), 2) * (n / (1 / data.len()))
      ).sum()
  }
  这是均匀分布的拟合优度检验，使用 $chi^2$ 检验法，计算：
  $
    T = calcT(data)
  $
  它近似服从 $chi^2 (9)$，因此取临界值 $C$ 使得：
  $
    P_(X tilde chi^2(9)) (X > C) = 0.05
  $
  查表得 $C = 16.9$，因此不拒绝原假设，认为是匀称的。
= 1
  == (1)
    有熟知的恒等式：
    $
      inner(X - Xbar 1, Y - Ybar 1) = inner(X, Y) - n Xbar Ybar\
    $
    代入即得两式相等
  == (2)
    注意到：
    $
      inner(X - Xbar 1, Y - Ybar 1) = inner(X - Xbar 1, Y) - Ybar  inner(X - Xbar 1, 1) = inner(X - Xbar 1, Y) - Ybar  (n Xbar - n Xbar) \
      = inner(X - Xbar 1, Y)
    $
    因此结论成立
  == (3)
    与 (2) 同理
= 2
  #let ha = $hat(a)$
  #let hb = $hat(b)$
  $
    inner(1, Y - hY) = inner(1, Y - ha 1 - hb X) = inner(1, Y - (Ybar - hb Xbar) 1 - hb X)\
    = inner(1, (Y - Ybar 1) - hb (X - Xbar 1)) = inner(1, Y - Ybar 1) - hb inner(1, X - Xbar 1) = 0
  $
  $
    inner(X, Y - hY) = inner(X, (Y - Ybar 1) - hb (X - Xbar 1)) =^("前面结论") inner(X - Xbar 1, (Y - Ybar 1) - hb (X - Xbar 1))\
    = inner(X - Xbar 1, (Y - Ybar 1) - (inner(X - Xbar 1, Y - Ybar 1))/norm2(X - Xbar 1) (X - Xbar 1)) = 0
  $