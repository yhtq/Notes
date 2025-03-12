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
p60 13 15 18 14\*
= 13
  由泊松分布的可加性，不难得到 $E Xbar = lambda$。只需计算：
  $
    E 1/(n - 1) sumBrN1((X_i - Xbar)^2) &= 1/(n - 1) sumBrN1(E (X_i - Xbar)^2)\
    &=1/(n - 1) sumBrN1(var (X_i - Xbar))\
    &=1/(n - 1) sumBrN1(var X_i + var Xbar - 2 cov(X_i, Xbar))\
    &=1/(n - 1) sumBrN1(var X_i + 1/n var X_i - 2/n cov(X_i, X_i))\
    &=1/(n - 1) sumBrN1(var X_i - 1/n var X_i)\
    &= var X_i\
    &= lambda\
  $
  当然还有其它无偏估计，显然上面两个统计量的任何线性组合 $alpha_1 Xbar + (1 - alpha_1) S^2$ 都是 $lambda$ 的无偏估计。
= 14
  根据熟悉的计算过程可得：
  $
    E Xbar = E X = m theta\
    E S^2 = var X = m theta (1 - theta)
  $
  因此显然 $(Xbar - S^2)/m$ 就是 $theta^2$ 的无偏估计。
= 15
  $
    E (1/n sumBrN1(X_i^2)) &= 1/n sumBrN1(E X_i^2)\
    &= 1/n sumBrN1(var X_i + (E X_i)^2)\
    &= 1/n sumBrN1(lambda + lambda^2)\
    &= lambda + lambda^2\
  $
  因此 $1/n sumBrN1(X_i^2) - Xbar$ 就是 $lambda^2$ 的无偏估计。
= 18
  注意到指数分布属于指数分布族，从形式可以看出 $Xbar$ 将是一个完全统计量。而由指数分布方差可得:
  $
    E Xbar = theta
  $
  因此 $Xbar$ 也是充分统计量，$Xbar$ 是无偏估计，进而是最小方差无偏估计。而：
  $
    var Xbar = (var X)/n = theta^2/n
  $
  这就是 $theta$ 的无偏估计的方差下界。
  // 假设 $phi(Xs)$ 是 $theta$ 的一个无偏估计，则有：
  // $
  //   theta = E phi(Xs) = integral_(0)^(infinity) phi 1/theta e^(- 1/theta) dif x_i 
  // $
  // 求导得：
  // $
  //   1 = integral_(0)^(infinity) phi (-1/theta^2 e^(- 1/theta) + 1/theta^3 e^(- 1/theta)) dif x_i \
  //   theta^3/(1 - theta) e^(1/theta) = integral_(0)^(infinity) phi dif x_i \
  // $
  // 而:
  // $
  //   var phi = E phi^2 - theta^2 = integral_(0)^(infinity) phi^2 1/theta e^(- 1/theta) dif x_i - theta^2\
  // $