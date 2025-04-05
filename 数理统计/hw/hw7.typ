#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
p140 8 11 10\*
= 8
  这是单参数指数型检验问题，熟知:
  $
    sumi1n(X_i) tilde "Poisson" (n lambda)
  $
  是一个完全充分统计量。只需求常数 $C$ 使得：
  $
    P_(X tilde "Poisson" (n lambda_0)) (X > C) = alpha
  $
  可以构造检验法：
  $
    phi(x) = 1_(sumi1n(X_i) > C)
  $
  断言这是 UMP 检验法，这是因为设 $phi'$ 是另一个水平为 $alpha$ 地检验法，任取 $lambda' in Theta - Theta_0 = (lambda_0, + infinity)$，我们断言该检验法是两点假设检验问题：
  $
    H_0: lambda = lambda_0 <-> H_1: lambda = lambda'
  $
  的 UMP 即可。首先计算似然比：
  $
    lambda(X) = prodi1n(e^(-lambda_0) lambda_0^X_i / (X_i !)) / prodi1n(e^(-lambda') lambda'^(X_i) /(X_i !))\
    = prodi1n(e^((-lambda_0 - lambda')) (lambda_0 / lambda')^(X_i) )\
    = e^((-lambda_0 - lambda')) (lambda_0 / lambda')^(sumi1n(X_i))\
  $
  这就表明 $lambda(X) > lambda_0$ 当且仅当 $sumi1n(X_i) > C$，并且：
  $
    E_(lambda_0) phi(x) = P_(lambda_0) (sumi1n(X_i) > C) = alpha
  $
  因此该检验法是 N-P 引理给出的检验法，继而是两点检验的 UMP，由 $lambda'$ 的一般性它也是原问题的 UMP
= 10
  设计检验法：
  $
    phi(X) = 1_(max(X) > C)
  $
  这里 $C$ 满足：
  $
    P_(theta_0) (max(X) > C) = alpha\
    <=> P_(theta_0) (max(X) <= C) = 1 - alpha\
    <=> P_(theta_0) (prodi1n(X_i <= C)) = 1 - alpha\
    <=> prodi1n(P_(theta_0) (X_i <= C)) = 1 - alpha\
    <=> P_(theta_0) (X <= C) = (1 - alpha)^(1/n)\
    <=> C / theta_0 = (1 - alpha)^(1/n)\
    <=> C = theta_0 (1 - alpha)^(1/n)\
  $
  为了验证它是 UMP，任取 $theta' in Theta - Theta_0 = (theta, +infinity)$，只需证明它是两点检验的 UMP 即可。设 $phi'$ 是另一个水平不超过 $alpha$ 的检验法，考虑：
  - $phi$ 的二类错误概率为：
    $
      P_theta' (max(X) <= C) = (C/theta')^n = (1 - alpha) (theta/theta')^n\
    $
  - $phi'$ 的二类错误概率为：
    $
      integral_(max(X) < theta')^() (1/theta')^n (1 - phi'(X)) dif X
    $
    而一类错误概率为：
    $
      integral_(max(X) < theta)^() (1/theta)^n phi'(X) dif X <= alpha
    $
    不难注意到：
    $
      &integral_(max(X) < theta')^() (1/theta')^n (1 - phi'(X)) dif X \
      &= integral_(max(X) < theta)^() (1/theta')^n (1 - phi'(X)) dif X + integral_(X_i in [theta, theta'))^() (1/theta')^n (1 - phi'(X)) dif X\
      &= (theta/theta')^n - (theta/theta')^n integral_(max(X) < theta)^() (1/theta)^n phi'(X) dif X + integral_(X_i in [theta, theta'))^() (1/theta')^n (1 - phi'(X)) dif X\
      &>= (theta/theta')^n - (theta/theta')^n alpha\
      &= (1 - alpha) (theta/theta')^n\
    $
    证毕。
= 11
  == (1)
    这是单参数的指数型分布检验，只需求常数 $C$ 使得：
    $
      P_0 (sumi1n(X_i) > C) = alpha\
      <=> P_0 (sumi1n(X_i)/sqrt(n) > C/sqrt(n)) = alpha\
      <=> P_(X tilde N(0, 1)) (X > C/sqrt(n)) = 0.025\
    $
    查表得 $C/sqrt(n) = 1.96$，其功效函数为：
    $
      rho(mu) = P_mu (sumi1n(X_i) > C) = P_mu (sumi1n(X_i - mu) > C - n mu) = P_(X tilde N(0, 1)) (X > C/sqrt(n) - sqrt(n) mu)\
    $
  == (2)
    $mu >= 0.5$ 时上面的功效函数最小值为：
    $
       P_(X tilde N(0, 1)) (X > 1.96 - 0.5 sqrt(n)) >= 0.9
    $
    查表得 $1.96 - 0.5 sqrt(n) < -1.3, n > #calc.pow((1.96 + 1.3) * 2, 2)$，
    因此 $n$ 至少取 $43$
  == (3)
    $mu <= -0.1$ 时有功效函数的最大值为：
    $
      P_(X tilde N(0, 1)) (X > 1.96 + 0.1 sqrt(n)) <= 0.001
    $
    查表得 $1.96 + 0.1 sqrt(n) >= 3.09, n >= #calc.pow((3.09 - 1.96) * 10, 2)$，因此 $n$ 至少取 $128$
  
  // 我们计算似然比：
  // $
  //   lambda(X) = ("if" max(X) <= theta_0 "then" (1/theta_0)^n "else" 0)/("if" max(X) <= theta' "then" (1/theta')^n "else" 0)\
  //   = ite(max(X) > theta', "undef", 
  //   (ite(max(X) <= theta, (theta'/theta_0)^n, 0)))
  // $
  // 事实上，$P(max(X) > theta') = 0$，因此可以不用考虑 $max(X) > theta'$ 情形，上式变为：
  // $
  //   ite(max(X) <= theta, (theta'/theta_0)^n, 0)
  // $
  // 因此：
  // $
  //   lambda(X) > 0 <=> max(X) <= theta_0
  // $
  // 同时在上面的检验法中，有：
  // $
  //   E_(theta_0) phi(X) = P_(theta_0) (max(X) > C) = 1 - P_(theta_0) (max(X) <= C)\
  //   = 1 - P_(theta_0) (prodi1n(X_i <= C))\
  //   = 1 - prodi1n(P_(theta_0) (X_i <= C))\
  // $