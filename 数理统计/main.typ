#import "../template.typ": *
#show: note.with(
  title: "数理统计",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let sumBrN(body) = sumfBr(body, lower: $1$, upper: $n$)
#let Xs = $autoRListN(X, n)$
#let xs = $autoRListN(x, n)$
= 前言
  - 教师：刘力平，智华楼 335，liping\@math.pku.edu.cn
  - 教材：陈家鼎等《数理统计学讲义》
  - 参考书：
    - 陈希孺《数理统计引论》，适合作为参考
    - D. Freedman. 《统计学》，较为面向实践
    - Lehmann. 《Theory of Point Estimation》
    - Lehmann. 《Testing Statistical Hypothesis》
    - 陈希孺《数理统计学简史》
  - 作业：每节课留，每周三交，可延期至周五
  - 作业 20% + 期中考试 20% + 期末考试 60%
  + 习惯上，用大写字母 $X_i$ 表示抽样前样本对应的随机变量，用小写字母 $x_i$ 表示抽样后样本的观测值。
  + 通常情况下，我们处理的都是独立同分布的样本，称为简单随机样本。
  + 通常称一个样本的（可测）函数为一个统计量 
= 估计
  == 参数估计的方法
    假设我们已知总体的分布类型，只是其中某些参数不知道，希望由数据对参数做出估计，这种问题称为参数估计问题。
    === 最大似然估计（Maximum Likelihood Estimate, MLE）
      最大似然估计是最常见的参数估计方法，也是对于任何问题往往第一个考虑的方法。最大似然估计的思想是，使用最可能产生数据的参数作为估计值。
      #definition(footer: [122])[最大似然][
        称：
        $
          L(x_1, x_2, ..., \; theta) = product_i f(x_i \;theta)
        $
        为参数 $theta$ 关于样本 $x_1, x_2, ...$ 的似然函数。假设它关于 $theta$ 有最大值点 $htheta := phi(x_1, ..., x_n)$，则称 $htheta$ 为 $theta$ 的最大似然估计。
      ]
      从定义可以看出，在比较经典的情况下最大似然估计总是存在的。存在时，它往往具有比较好的性质，在某些标准下最优。
      #definition[相合性][
        假设 $n$ 是样本量，$hat(theta)_n$ 是样本数为 $n$ 时的参数估计：
        - 若：
          $
            P(lim_(n -> +infinity) hat(theta)_n = theta) = 1
          $
          则称参数估计是强相合的（几乎处处收敛）。
        - 若：
          $
            forall epsilon > 0, lim_(n -> +infinity) P(norm(hat(theta)_n - theta) < epsilon) = 1
          $
          则称参数估计是相合/弱相合的（依测度收敛）。概率论的知识表明，强相合的估计一定是相合的。
      ]
      在概率论研究中，人们往往很强调不同收敛性的区别。然而在统计学中，处理的往往是概率论意义下比较经典的情形，几乎不会碰到在较弱意义下收敛，较强意义下不收敛的情形，因此在统计学中有时会淡化它们的区别。
      #example[常见分布的最大似然估计][
        + 两点分布 $X_i tilde B(1, p)$：
          $
            ln(L(p)) = sum_i x_i ln p + (n - sum_i x_i) ln(1 - p)
          $
          最大似然估计为：
          $
            hat(p) = 1/n sum_i x_i := xbar
          $
          事实上，也就是用频率估计概率。强大数率可以保证强相合性。
        + 指数分布 $X_i tilde "Exp"(lambda) tilde ExpDis(x, lambda)$：
          最大似然估计为：
          $
            hat(lambda) = n/( sum_i x_i)
          $
          直观来说，也就是平均寿命。强大数率可以保证强相合性。
        + 正态分布 $X_i tilde N(mu, sigma^2) tilde NormalDis(x, mu, sigma)$：
          $
            log(L(mu, sigma)) = n ln C - n/2 ln sigma^2 - 1/(2 sigma^2) sum_i (x_i - mu)^2
          $
          求导解得：
          $
            cases(
              mu = 1/n sum_i x_i = xbar,
              sigma^2 = 1/n sum_i (x_i - xbar)^2
            )
          $
          强大数率保证了（强收敛）：
          $
            xbar_n -> E X = mu\
            1/n sum_i x_i^2 -> E X^2 = sigma^2 + mu^2\
            1/n sum_i (x_i - xbar)^2 -> sigma^2
          $
        + 均匀分布 $X tilde U[a, b]$：
          $
            L(a, b) = 1/(b - a)^n product_i 1_([a, b]) (x_i)
          $
          事实上，假设 $a <= min x_i, b >= max x_i$，则总有：
          $
            L(a, b) = 1/(b - a)^n
          $
          否则 $L(a, b) = 0$，不难发现最大似然估计就是：
          $
            hat(a) = min x_i, hat(b) = max x_i
          $
          其相合性证明相对复杂，需要用到实变函数的方法。
      ]
    === 矩估计法（Moment Estimate）
      设 $X$ 的密度为 $f(x\; theta)$，其中 $theta in RR^n$，若 $X$ 的 $n$ 阶矩都存在，也即：
      $
        V_i = E X^i exists
      $
      对应的，可以从样本计算出样本矩：
      $
        overline(V)_i = 1/n sum_i x_i^i
      $
      一定条件下，根据大数率可以保证：
      $
        overline(V)_i -> V_i
      $
      #definition[矩估计][
        设有方程：
        $
          overline(V)_i = E X^i (theta)
        $
        若方程组能解出一个 $htheta$，则称其为 $theta$ 的矩估计。
      ]
      历史上，Pearson 比较推崇矩估计，但后来 Fisher 力推最大似然估计，二十世纪四五十年代，人们也发现很多时候当问题比较复杂时，最大似然估计往往可证明以很快的速度收敛，而矩估计略差一些。
      #example[][
        + 两点分布：$1/n sum_i x_i = E X = p$
        + 指数分布：$1/n sum_i x_i = 1/lambda$
        + 正态分布：$1/n sum_i x_i = mu, 1/n sum_i x_i^2 = sigma^2 + mu^2$
        + 均匀分布 $X tilde U[0, theta]$
          $
            E X = theta/2 = xbar\
            theta = 2 xbar
          $
          与 MLE 估计并不一致。与 MLE 的估计值相比：
          - MLE 的估计值 $max x_i$ 概率为 $1$ 地小于真实值
          - 矩估计可能在明知存在 $x_i > 2 xbar$ 时，还使用明显错误的 $2 xbar$ 作为估计值
      ]
      #example[序列号估计/离散均匀分布][
        二战时期，盟军为了估计德军生产了多少量坦克，希望通过德军坦克的序列号来估计。换句话说，假设 $N$ 未知，$X_i$ 是 $n$ 个从 $(1, 2, ..., N)$ 上的均匀分布选出的样本，希望估计 $N$：
        - 直观来说，可以先估计平均间隔：
          $
            overline(i) := 1/(n - 1) sum_i (k_i - k_(i - 1) - 1)
          $
          再用 $k_n + overline(i)$ 作为估计值。可以证明，这是一个无偏估计。
        - 一种改进是，假设 $k_0 = 0$，继续使用平均间隔估计，最后计算得：
          $
            (n + 1)/n k_n - 1
          $
          也可证明它是无偏的，但是方差更小。
      ]
  == 估计的优良性标准
    做参数估计时，当然希望估计值与真实值越接近越好。然而由于估计值是随机变量，因此定义距离的方法也并不统一。
    #definition[][
      称 $phi(autoRListN(X, n))$ 是 $g(theta)$ 的无偏估计，如果：
      $
        E_theta phi(autoRListN(X, n)) = g(theta), forall theta
      $
    ]
    #definition[均方误差][
      对于估计 $htheta$，定义均方误差为：
      $
        M_theta(htheta) = E_theta (htheta - theta)^2
      $
      假设 $htheta$ 是无偏的，则它就是方差。
    ]
    #definition[有效][
      对于 $g(theta)$ 的两个估计 $phi_1, phi_2$，若 $M_theta (phi_1) >= M_theta (phi_2)$，则称 $phi_1$ 不次于 $phi_2$。若等号不恒成立，则称 $phi_1$ 比 $phi_2$ 有效。
    ]
    #example[][
      假设 $sumBrN(lambda_i) = 1$，则 $sumBrN(lambda_i x_i)$ 总是无偏估计。但计算均方误差不难发现，除非 $lambda_i = lambda_j$，否则 $Xbar$ 总比它有效。
    ]
    注意通常来说，我们找不到“最好的”估计。例如我们始终使用 $theta_0$ 进行估计，则最好情况下均方误差为零，最坏情况下则可能很大。
    #definition[（一致）最小方差无偏估计（MVUE）][
      若 $phi$ 是 $g(theta)$ 的无偏估计，且对于任何无偏估计 $phi'$，有 $M_theta (phi) <= M_theta (phi'), forall theta$，则称 $phi$ 是 $g(theta)$ 的最小方差无偏估计。
    ]
    在许多常见情形下，MVUE 是存在的并且可以求出。注意 MVUE 只是均方误差意义上的最佳，不代表在其他意义上最佳。
    #definition[充分统计量][
      称 $U := phi(Xs)$ 为充分统计量（sufficient statistic），如果似然函数可表示为：
      $
        L = q(phi(xs), theta) dot h(xs)
      $
      等价于对于任何可测集 $A$：
      $
        P((Xs) in A | U = u_0) " 与" theta "无关"
      $
    ]
    显然 $(Xs)$ 是充分统计量，但通常没有意义。因为充分统计量的目的往往是降低数据的维数和复杂度。
    #example[][
      - 对于两点分布，估计 $p$ 时，$Xbar$ 就是一个充分统计量。
      - 对于指数分布，$Xbar$ 也是一个充分统计量。
      - 对于正态分布，$Xbar, S_n$ 是一个充分统计量。
    ]
    #definition[][
      假设存在函数 $h(x), S(theta), k, C_j (theta), T_j (x)$，使得随机变量的密度函数形如：
      $
        f(x, theta) = S(theta) h(x) exp(sum_(j) C_j (theta) T_j (x))
      $
      则称其服从指数族分布。指数分布族包含许多常见分布，包括两点分布，二项分布，指数分布，正态分布，泊松分布等。
    ]
    #theorem[][
      假设 $X$ 服从指数分布族，则 $sumBrN(T_j (x_i)), forall i$ 是一个充分统计量。
    ]
    #definition[完全统计量][
      称 $U = phi(Xs)$ 是 $theta$ 的完全统计量，如果对于任何可测函数 $u$，有：
      $
        forall theta, E_theta (u(U)) = 0 -> forall theta, u(U) =^("以概率" 1) 0
      $
    ]
    #example[][
      - 在两点分布中，$U := sumBrN(x_i) tilde B(n, p)$，如果：
        $
          E_p u(U) = 0, forall p
        $
        则：
        $
          sumBrN(C_n^i p^i (1 - p)^(n - i) u(i) = 0), forall p
        $
        前式是关于 $p$ 的多项式，如果它对所有 $p$ 都成立，则它的系数都为零，因此 $u(i) = 0$。

        然而，$(sum_(i = 1^k) x_i, sum_(i = k + 1)^n x_i)$ 并不是完全统计量，取 $u = (sum_(i = 1^k) x_i)/k - (sum_(i = k + 1)^n x_i)/(n - k)$ 就可将期望归零，但显然它不会以概率 $1$ 为零。
    ]
    某种意义上，充分性是保留了数据的所有特征，完全性是说没有保留更多的信息（独立性）。

    #theorem[][
      设参数空间是开集，则指数分布族中 $sumBrN(T_j (x_i)), forall i$ 就是完全统计量。
    ]
    #theorem[Blackwell-Lehmann-Scheffe][
      设 $phi$ 是一个完全充分统计量，$psi(phi)$ 是 $g(theta)$ 的无偏估计，那么 $psi(phi)$ 就是 $g(theta)$ 的 MVUE。同时，在几乎处处相等的意义下，它是唯一的最小方差无偏估计。
    ]
    #example[][
      对于正态变量，样本均值和样本方差就是完全充分统计量。因此，它们是正态分布参数的 MVUE。
    ]
    注意无偏估计有时不存在。例如，设 $X tilde B(n, p)$，对于任意的估计 $psi$ 均有：
    $
      E_p psi(X) = sumBrN(C_n^i p^i (1 - p)^(n - i) psi(i) )
    $
    这是关于 $p$ 的至多 $n$ 次多项式。可见，设 $g$ 不是小于 $n$ 次的多项式，则 $g(p)$ 都不可能存在无偏估计。

    同时，无偏估计可能是完全不合理的，例如设 $X$ 服从泊松分布，样本量为 $1$，$g(theta) = e^(- 2 theta)$，则 $g(theta)$ 的唯一无偏估计为：
    $
      (-1)^x
    $
    然而 $g$ 是非负的，$-1$ 显然是不合理的估计值。所幸，上面的反例通常不是非常常见，因此在大多数情况下，我们可以找到一个合理的无偏估计。
    #theorem[Crammer-Rao (C-R)不等式][
      设 $X$ 的密度函数为 $f(x, theta), theta in (a, b)$（$a, b$ 可能为无穷），$(Xs)$ 是 $X$ 的简单随机样本，$phi$ 是 $g(theta)$ 的无偏估计，则在下列条件下：
      + $f$ 的支集 $Inv(f)((0, +infinity))$ 与 $theta$ 无关
      + $g' (theta), partialDer(f, theta)$ 都存在，且：
        - $
            integral_()^() partialDer(f, theta) dif x = partialDer(integral_()^() f dif x, theta) = 0 
          $
        - $
            partialDer(
              integral phi product_i f(x_i, theta) dif bx, theta 
            ) = 
            integral phi partialDer(, theta) product_i f(x_i, theta) dif bx
          $
      则有：
      $
        var(phi(Xs)) >= (g'(theta))^2/(n I(theta))
      $
      其中：
      $
        I(theta) = E_theta (partialDer(ln f(X, theta), theta))^2
      $
      称为 Fisher 信息量。
    ]
    #proof[
      不妨设 $var(phi(Xs)), I(theta)$ 都有限。注意到：
      $
        partialDer(space, theta) product_i f(x_i, theta) &= sum_j (product_(i != j) f(x_i, theta) partialDer(f(x_j, theta), theta))\
        &= 
      $
      所以：
      $
        g'(theta) &= integral phi sumBrN(partialDer(ln f, theta)) product_i f(x_i, theta) dif bx\
        &= E_theta (phi sumBrN(partialDer(ln f, theta)) product_i f(x_i, theta))\
      $
      而：
      $
        E_theta (sumBrN(partialDer(ln f, theta)) product_i f(x_i, theta)) = sumBrN(E_theta (partialDer(ln f, theta) product_i f(x_i, theta)))\
      $
      利用柯西不等式：
      $
        (g'(theta))^2 &<= E phi E (sumBrN(partialDer(ln f, theta)))\
        &= var(phi) var(sumBrN(partialDer(ln f, theta)))\
        &= n var(phi) var(partialDer(ln f, theta))\
        &= n var(phi) I_theta\
      $
      证毕。
    ]
    #remark[][
      - $C - R$ 不等式表明，无偏估计的方差至少也是 $1/n$ 量级，和中心极限定理的结论是一致的。
      - 若一个估计达到了 $C - R$ 不等式的等号，则其一定为 MVUE。
      - $C - R$ 不等式的下界未必可以取得。
    ]