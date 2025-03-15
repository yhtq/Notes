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