#import "../template.typ": *
#show: note.with(
  title: "数理统计",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)

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
      假设 $sumBrN1(lambda_i) = 1$，则 $sumBrN1(lambda_i x_i)$ 总是无偏估计。但计算均方误差不难发现，除非 $lambda_i = lambda_j$，否则 $Xbar$ 总比它有效。
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
      假设 $X$ 服从指数分布族，则 $sumBrN1(T_j (x_i)), forall j$ 是一个充分统计量。
    ]
    #definition[完全统计量][
      称 $U = phi(Xs)$ 是 $theta$ 的完全统计量，如果对于任何可测函数 $u$，有：
      $
        forall theta, E_theta (u(U)) = 0 -> forall theta, u(U) =^("以概率" 1) 0
      $
    ]
    #example[][
      - 在两点分布中，$U := sumBrN1(x_i) tilde B(n, p)$，如果：
        $
          E_p u(U) = 0, forall p
        $
        则：
        $
          sumBrN1(C_n^i p^i (1 - p)^(n - i) u(i) = 0), forall p
        $
        前式是关于 $p$ 的多项式，如果它对所有 $p$ 都成立，则它的系数都为零，因此 $u(i) = 0$。

        然而，$(sum_(i = 1^k) x_i, sum_(i = k + 1)^n x_i)$ 并不是完全统计量，取 $u = (sum_(i = 1^k) x_i)/k - (sum_(i = k + 1)^n x_i)/(n - k)$ 就可将期望归零，但显然它不会以概率 $1$ 为零。
    ]
    某种意义上，充分性是保留了数据的所有特征，完全性是说没有保留更多的信息（独立性）。

    #theorem[][
      设参数空间是开集，则指数分布族中 $sumBrN1(T_j (x_i)), forall i$ 就是完全统计量。
    ]
    #theorem[Blackwell-Lehmann-Scheffe][
      设 $phi$ 是一个完全充分统计量，$psi(phi)$ 是 $g(theta)$ 的无偏估计，那么 $psi(phi)$ 就是 $g(theta)$ 的 MVUE。同时，在几乎处处相等的意义下，它是唯一的最小方差无偏估计。
    ]
    #example[][
      对于正态变量，样本均值和样本方差就是完全充分统计量。因此，它们是正态分布参数的 MVUE。
    ]
    注意无偏估计有时不存在。例如，设 $X tilde B(n, p)$，对于任意的估计 $psi$ 均有：
    $
      E_p psi(X) = sumBrN1(C_n^i p^i (1 - p)^(n - i) psi(i) )
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
        &= sumBrN1(partialDer(ln f, theta)) product_i f(x_i, theta)
      $
      所以：
      $
        g'(theta) &= integral phi sumBrN1(partialDer(ln f, theta)) product_i f(x_i, theta) dif bx\
        &= E_theta (phi sumBrN1(partialDer(ln f, theta)) )\
      $
      而：
      $
        E_theta (sumBrN1(partialDer(ln f, theta)) ) = sumBrN1(E_theta (partialDer(ln f, theta) ))\
      $
      利用柯西不等式：
      $
        (g'(theta))^2 &<= E phi E (sumBrN1(partialDer(ln f, theta)))\
        &= var(phi) var(sumBrN1(partialDer(ln f, theta)))\
        &= n var(phi) var(partialDer(ln f, theta))\
        &= n var(phi) I_theta\
      $
      证毕。
    ]
    #remark[][
      - C - R 不等式表明，无偏估计的方差至少也是 $1/n$ 量级，和中心极限定理的结论是一致的。
      - 若一个估计达到了 C - R 不等式的等号，则其一定为 MVUE。
      - C - R 不等式的下界未必可以取得。
    ]
    #example[][
      - 两点分布 $X tilde B(1, p)$，有：
        $
          I(p) = E_p (X/p - (1 - X)/(1 - p))^2 = 1/(p(1 - p))
        $
        同时，$var(Xbar) = 1/(n I(p))$，说明 $Xbar$ 达到了 C-R 不等式的下界。
      - 指数分布 $X tilde "Exp"(lambda)$，有：
        $
          I(lambda) = E_lambda (1/lambda - X)^2 = 1/lambda^2
        $
        同时，$var(Xbar) = 1/n 1/lambda^2$，而 C-R 不等式的右侧为：
        $
          (g'(lambda)^2)/(n I(lambda)) = 1/(n lambda^2)
        $
        达到了 C-R 不等式的下界。
      - 正态分布 $X tilde N(mu, sigma^2_0)$，其中方差已知
        $
          I(mu) =  E_mu (X - mu)^2/(sigma_0^4) = sigma_0^(-2)
        $
        而 $Xbar$ 的方差为 $sigma_0^2/n = 1/(n I(mu))$，也达到了 C-R 不等式的下界。从表达式也可以看出，方差越小，Fisher 信息量越大，也就是每个数据带给我们的信息越多。
      - 泊松分布中，若估计 $e^(-2lambda)$ ，可以计算得到作为指数分布族的最小方差无偏估计并不能达到 C-R 不等式的下界。
      - 若 $X tilde U(0, theta)$，之前提过 MLE 为 $max_i X_i$，矩估计为 $2 Xbar$，两者都有不足。令 $hat(theta) = (n + 1)/n max_i X_i$，可以证明它是无偏估计，同时方差以 $O(1/n^2)$ 速度趋向于零，比 C-R 不等式的速度快。这是因为 C-R 不等式依赖于 $X$ 的支撑与 $theta$ 无关，而 $U(0, theta)$ 的支撑明显与 $theta$ 有关。
    ]
    C-R 不等式可以推广到多元情形，这里不再赘述。

    从根本上来说，统计量并没有根本上的“最优”标准，大多时候某些标准在某种意义下更好，但在另一种意义下可能就不好了。
  == 置信区间
    之前考虑的都是点估计，也就是由数据只得到一个估计的数值。有时，我们要考虑区间估计，也就是找到一个区间，使得目标参数 $theta$ 以相当大的概率落在这个区间内。
    #definition[置信区间][
      设 $gamma in (0, 1)$，$phi_1(Xs) <= phi_2(Xs)$ 是两个统计量，$theta$ 是待估计量。称 $[phi_1(Xs), phi_2(Xs)]$ 是 $g(theta)$ 的置信水平为 $gamma$ 的置信区间，若：
      $
        P (phi_1(Xs) <= g(theta) <= phi_2(Xs)) >= gamma, forall theta
      $
      通常而言，置信区间都是有限的，但有时也可能故意取逻辑上的上下界，此时另一端的值通常称为置信上限/下限。

      注意置信水平严格来说并非*参数落入区间的概率*，而是*在重复抽样的情况下，这个区间包含真实参数的概率*。
    ]
    通常来说置信区间没有严格的标准，但明显在相同的数据上，置信区间越窄越好。

    === 枢轴量方法
      一般的随机变量的置信区间求法可能相当复杂，这里主要介绍求正态分布的置信区间的方法，包括以下几种：
      - 已知方差，求期望的置信区间\
        此时，有：
        $
          Xbar tilde N(mu, sigma_0^2/n)\
          eta := (Xbar - mu)/(sqrt(sigma_0^2/n)) tilde N(0, 1)
        $ 
        只需查标准正态分布表即可。常用的数据有：
        $
          P(abs(eta) <= 2.58) = 0.99\
          P(abs(eta) <= 1.96) = 0.95\
          P(abs(eta) <= 1.65) = 0.90\
        $
        注意，事实上这里取的都是对称的置信区间。原则上来说，也可以取成不对称的置信区间，不过对于正态分布这种单峰分布，采用对称型的置信区间往往是平均最窄的。
      - 未知方差，求期望的置信区间。此时不能再采取之前的方法，思路是使用无偏估计 $S^2 = 1/(n - 1) sumBrN1((Xbar - X_i)^2)$ 代替 $sigma^2$，如此得到新的统计量：
        $
          T = (Xbar - mu)/(S^2/sqrt(n))
        $
        它不再服从正态分布。
        #theorem[][
          设 $X_i$ 独立同分布的标准正态，则 $sum_(i=1)^n X_i^2$ 服从 $Gamma(n/2, 1/2)$，或称 $n$ 个自由度的 $chi^2$ 分布，记为 $chi^2_n$。
          
          同时，可以得到 $E(chi^2_n) = n$ 且 $chi^2$ 分布具有可加性。
        ]
        $chi^2$ 分布从根本上是指 $n$ 个独立同分布的标准正态分布的平方和的分布，刻画的是样本方差的分布。历史上，Fisher 对孟德尔的豌豆实验数据进行了分析，用正态分布作为伯努利分布的近似，发现其方差的分布与 $chi^2$ 分布相比显著偏小。
        #theorem[][
          设 $X_i tilde N(mu, sigma^2)$ 独立同分布，则：
          + $Xbar tilde N(mu, sigma^2/n)$
          + $1/sigma^2 sumBrN1((X_i - Xbar)^2) tilde chi^2(n-1)$
          + $Xbar$ 与 $sumBrN1((X_i - Xbar)^2)$ 相互独立
        ]
        #proof[
          + 显然
          + 无妨设 $E X = 0$，做正交变换使得 $Y = U X$ 且 $Y_1 = sqrt(n) Xbar$，则有：
            $
              sumBrN1((X_i - Xbar)^2) = sumBrN1(X_i^2) - n Xbar^2 = sumBrN1(Y_i^2) - Y_1^2 = sum_(i = 2)^n Y_i^2
            $
            注意到 $E Y = 0$，因此：
            $
              sum_(i = 2)^n Y_i^2 tilde chi^2(n - 1)
            $
          + 根据上面的变换，$Y_1$ 当然与 $sum_(i = 2)^n Y_i^2$ 相互独立。
        ]
        如果令：
        $
          T = (Xbar - mu)/(sqrt(S^2 / n))
        $
        则有：
        $
          T = (sqrt(n) (X - mu)/sigma)/(1/((n - 1)sigma^2) sumBrN1((X_i - Xbar)^2))
        $
        其中分子是标准正态分布，分母是 $(chi^2(n-1))/(n - 1)$，且分子分母相互独立，因此已经是已知分布，与未知参数 $mu, sigma$ 无关。
        #definition[t-分布/学生分布][
          称 $n$ 个自由度的 $t$ 分布为 $t(n)$ ，其分布密度为：
          $
            p_n (t) = Gamma((n + 1)/2)/(Gamma(n / 2) sqrt(n pi)) (1 + t^2/n)^(- (n + 1)/2)
          $
          （不用背）
        ]
        $t$ 分布的密度函数形状类似正态分布，关于 $0$ 对称，在 $0$ 处取最大值，无穷处趋于零。然而 $t$ 分布的尾部很重，趋于零的速度比正态分布慢很多。

        最早使用 t-分布的统计学家是 Gosset，其笔名为 Student，因此 t-分布也被称为学生分布。
        #lemma[][
          $
            lim_(n -> +infinity) p_n (t) = 1/(sqrt(2 pi)) e^(-t^2/2)
          $
        ]
        #theorem[][
          设 $xi tilde N(0, 1), eta tilde chi^2(n)$ 相互独立，则：
          $
            t = xi/sqrt(eta/n) tilde t(n)
          $
        ]
        回到原先的问题，立刻有（*注意这里的自由度是 $n-1$*）：
        $
          T = (Xbar - mu)/(S^2/n) tilde t(n - 1)
        $
        给定置信水平 $gamma$，只需解临界值 $lambda$ 使得：
        $
          P(abs(T) <= lambda) = gamma
        $
        解得 $lambda$ 即可得到置信区间：
        $
          [Xbar - lambda sqrt(S^2/n), Xbar + lambda sqrt(S^2/n)]
        $
      - 未知期望，求方差的置信区间：
        前面已经证明：
        $
          Y := ((n - 1)S^2)/sigma^2 tilde chi^2(n - 1)
        $
        对于给定的 $gamma$，求临界值 $lambda_1 < lambda_2$ 使得：
        $
          P( Y < lambda_1) = P(Y > lambda_2) = (1 - gamma)/2
        $
        如此就有：
        $
          P(lambda_1 < Y < lambda_2) = gamma
        $
        也就是：
        $
          P(((n - 1)S^2)/(lambda_2) < sigma^2 < ((n - 1)S^2)/(lambda_1)) = gamma
        $
        置信区间为：
        $
          [1/lambda_2 sumBrN1((X_i - Xbar)^2), 1/lambda_1 sumBrN1((X_i - Xbar)^2)]
        $
        注意这个过程中，我们也选择两侧遗留概率恰为 $(1 - gamma)/2$，这主要是基于早期计算方便，由于 $chi^2$ 分布并无对称性，这个区间也未必是最窄的区间。有时，我们也取 $lambda_1 = 0$ 或者 $lambda_2 = 0$，得到置信下限或者置信上限。
      上面提到的三种方法统一称为枢轴量方法，特点为：
      - 表达式中包含且只包含感兴趣的参数
      - 其分布已知，与未知参数无关
      三种情况的枢轴量分别为：
      - $(Xbar - mu)/(sqrt(sigma^2 / n))$
      - $(Xbar - mu)/(sqrt(S^2 / n))$
      - $((n - 1) S^2)/sigma^2$
    === 统计量方法\*
      设 $X_i tilde F(x, theta)$，$g(theta)$ 是目标统计量， $phi$ 是一个统计量，则：
      $
        G(u, theta) = P(phi >= u)
      $
      容易证明它是 $u$ 的左连续减函数。给定一组样本，计算得到 $u = phi(x_1, ..., x_n)$，令：
      $
        g_l (u) = inf_(G(u, theta) >= 1 - gamma) g(theta)\
        g_u (u) = sup_(G(u + 0, theta) <= gamma) g(theta)
      $
      #theorem[][
        对于任意 $phi$，$g_l, g_u$ 确实是 $g(theta)$ 的置信水平为 $gamma$ 的置信上限/下限，即：
        $
          P(g(theta) >= g_l (phi)) >= gamma\
          P(g(theta) <= g_u (phi)) >= gamma
        $
      ]
      #proof[
        只证明上限。事实上：
        $
          g(theta) < g_l (u) => G(u, theta) < 1 - gamma => P(phi < u) <= gamma\
          P (g(theta) < g_l (phi)) = P_(u tilde phi(Xs)) (g(theta) < g_l (u)) <= P_(u tilde phi(Xs)) (P(phi < u) <= gamma) = gamma
        $
      ]
      #corollary[][
        $[g_l, g_u]$ 是置信水平为 $2 gamma - 1$ 的置信区间 
      ]
      当然，如果涉及多个参数，还有置信域的概念。现实统计问题中，难以构造准确的置信区间，往往也会采用中心极限定理，构造近似的置信区间。
  == 分布函数和密度函数的估计
    之前我们讨论的都是参数估计问题，也就是所有可能分布产生于有限个参数。然而很多时候，我们在某个复杂的函数空间（可能无穷维）中寻找一个较好的函数，这也被称为非参数的估计。有时，问题处于两者之间，也就是一部分是参数的，一部分是非参数的。
    === 分布函数的估计
      最简单的想法是：
      $
        P(X <= x) approx 1/n sum_i 1_((-infinity, x])(X_i)
      $
      不难证明它是 $F(x)$ 的无偏统计量，且强相合，也即：
      $
        P(lim_(n -> +infinity) 1/n sum_i 1_((-infinity, x])(X_i) = F(x)) = 1, forall x
      $
      #definition[经验分布函数][
        称 $F_n (x) = 1/n sum_i 1_((-infinity, x])(X_i)$ 为经验分布函数。
      ]
      显然，经验分布函数是右连续单调增加的阶梯函数，每个相邻阶梯的差为 $k/n$
      #theorem[Glicenko-Cantelli][
        $
          P(lim_(n -> +infinity) sup_(x in RR) |F_n (x) - F(x)| = 0) = 1
        $
      ]
      #proof[
        略
      ]
      换言之，经验分布函数应该一致的强收敛于真实的分布函数。
    === 密度函数的估计
      注意到：
      $
        P(c < X <= d) approx f(x) (d - c) approx 1/(n(d - c)) sumBrN1(1_(c < X_i <= d) (X_i))
      $
      实际上，我们会利用所谓的直方图法：
      + 将 $X_i$ 重新按照顺序排列，得到 $X_(1) <= X_(2) <= ... <= X_(n)$
      + 选取 $a$ 略小于 $X_(1)$，$b$ 略大于 $X_(n)$，将 $[a, b]$ 分成 $m$ 个左开右闭（只是习惯）的区间，其内的密度函数用样本在其中的频率估计
      可以证明直方图一定条件下是相合的。它很简单，易于理解。


    
