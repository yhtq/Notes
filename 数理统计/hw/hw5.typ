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
p61 23 28 26\*
= 23
  显然有：
  $
    X/theta tilde U(0, 1)
  $
  因此：
  $
    P (alpha'/2 <= X_i/theta <= 1 - alpha'/2) = 1 - alpha'\
    P(X_i/(1 - alpha'/2) <= theta <= X_i/(alpha'/2)) = 1 - alpha'
  $
  注意到这对任何 $i$ 都成立，因此：
  $
    P(inter.big_i (X_i/(1 - alpha'/2) <= theta <= X_i/(alpha'/2))) = product_i P(X_i/(1 - alpha'/2) <= theta <= X_i/(alpha'/2)) = (1 - alpha')^n
  $
  因此，只需取 $(1 - alpha') = (1 - alpha)^(1/n)$，就有：
  $
    P((max X_i)/(1 - alpha'/2) <= theta <= (min X_i)/(alpha'/2)) = 1 - alpha
  $
  当 $alpha = 0.95, n = 5$ 时：
  #let alpha1 = 1 - calc.pow(0.95, 1/5)
  #let round2(x) = calc.round(x, digits: 5)
  #let alpha1s = round2(alpha1)
  $
    alpha' = 1 - 0.95^(1/5) = #alpha1s
  $
  置信区间为：
  $
    [(0.89)/(1 - #alpha1s/2), (0.08)/(#alpha1s/2)] = [#round2((0.89)/(1 - alpha1/2)), #round2((0.08)/(alpha1/2))]
  $
= 28
  熟知：
  $
    ((Xbar - mu)/(sqrt(n) sigma))/(sqrt(S^2/sigma^2)) = (Xbar - mu)/(sqrt(S^2/n)) tilde t(n - 1)
  $
  因此取 $gamma$ 使得 $P(-gamma <= T_11 <= gamma) = 1 - alpha$，就有：
  $
    P(-gamma <= (Xbar - mu)/(sqrt(S^2/n)) <= gamma) = 1 - alpha\
    P(- sqrt(S^2/n) gamma <= Xbar - mu <= sqrt(S^2/n) gamma) = 1 - alpha\
    P(Xbar - sqrt(S^2/n) gamma <= mu <= Xbar + sqrt(S^2/n) gamma) = 1 - alpha
  $
  查表得 $gamma = 2.201$，计算得：
  #let data = (40, 45, 23, 40, 31, 33, 49, 33, 34, 43, 26, 39)
  $
    Xbar = #round2(calcMean(data))\
    S^2 = #round2(calcSampleVariance(data))\
  $
  #let xbar = calcMean(data)
  #let s2 = calcSampleVariance(data)
  置信区间为：
  $
    [#round2(xbar - calc.sqrt(s2/12) * 2.201), #round2(xbar + calc.sqrt(s2/12) * 2.201)]
  $
= 26
  == (1)
    #let Xi = $X_((i))$
    $
      P(Xi <= x) = P("至少" i "个样本落在" (-infinity, x]) = P(B(n, P(X <= x)) >= i)\
      = sum_(k = i)^n C_n^k F(x)^k (1 - F(x))^(n - k)
    $
    注意到：
    $
      integral_(0)^(F(x)) (t x + 1 - x)^n dif x 
      &= 1/(t - 1) integral_(0)^((t - 1)F(x)) ((t - 1) x + 1)^n dif (t - 1) x\
      &= 1/(t - 1) 1/(n + 1) ((t - 1)F(x) + 1)^(n + 1) - 1)\
      &= 1/(t - 1) 1/(n + 1) (sum_(k = 0)^(n + 1) C_(n + 1)^k t^k F(x)^k (1 - F(x))^(n +1-k) - 1)\ 
      &= 1/(t - 1) 1/(n + 1) (sum_(k = 0)^(n + 1) C_(n + 1)^k t^k F(x)^k (1 - F(x))^(n +1-k) - sum_(k = 0)^(n + 1) C_(n + 1)^k  F(x)^k (1 - F(x))^(n +1-k))\ 
      &= 1/(t - 1) 1/(n + 1) (sum_(k = 0)^(n + 1) C_(n + 1)^k (t^k - 1) F(x)^k (1 - F(x))^(n +1-k))\ 
      &= 1/(n + 1) (sum_(k = 1)^(n + 1) C_(n + 1)^k (t^k - 1)/(t - 1) F(x)^k (1 - F(x))^(n +1-k))\ 
      &= 1/(n + 1) (sum_(k = 1)^(n + 1) C_(n + 1)^k sum_(j=0)^(k - 1) t^j F(x)^k (1 - F(x))^(n +1-k))\ 
      &= 1/(n + 1) (sum_(j=0)^n t^j (sum_(k = j + 1)^(n + 1) C_(n + 1)^k  F(x)^k (1 - F(x))^(n +1-k)))\ 
    $
    另一方面：
    $
      integral_(0)^(F(x)) (t x + 1 - x)^n dif x = sum_(k = 0)^n C_n^k t^k integral_(0)^(F(x)) x^k (1 - x)^(n - k) dif x\
    $
    比照系数得：
    $
      1/(n + 1)(sum_(k = j + 1)^(n + 1) C_(n + 1)^k  F(x)^k (1 - F(x))^(n +1-k)) = C_n^j  integral_(0)^(F(x)) x^j (1 - x)^(n - j) dif x\
      sum_(k = i)^(n) C_(n)^k  F(x)^k (1 - F(x))^(n-k) = n C_(n - 1)^(i - 1)  integral_(0)^(F(x)) x^(i - 1) (1 - x)^(n - i) dif x\
    $
    上式右侧即为结论。
  == (2)
    $
      E(F(Xi)) &= integral_(-infinity)^(infinity) P(X <= Xi) dif Xi\
      &= integral_(0)^(1) P(X <= x) der(P(Xi <= x), F(x)) dif F(x)\
      &= integral_(0)^(1) F(x) n C_(n - 1)^(i - 1)  F(x)^(i - 1) (1 - F(x))^(n - i) dif F(x)\
      &= n C_(n - 1)^(i - 1) integral_(0)^(1) F(x)^i (1 - F(x))^(n - i) dif F(x)\
      &= n!/((i - 1)!(n - i)!) ((n-i)! i!)/((n + 1)!)\
      &= i/(n + 1)\
      E (F(Xi))^2 &= n C_(n - 1)^(i - 1) integral_(0)^(1) F(x)^(i + 1) (1 - F(x))^(n - i) dif F(x)\
      &= n!/((i - 1)!(n - i)!) ((n-i)! (i + 1)!)/((n + 2)!) = (i(i + 1))/((n + 1)(n + 2))\
      var(F(Xi)) &= E(F(Xi))^2 - E(F(Xi))^2 \
      &= i(i + 1)/((n + 1)(n + 2)) - i^2/(n + 1)^2 \
      &= i(n - i + 1)/((n + 1)^2(n + 2))
    $