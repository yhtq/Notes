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
#let RSS = "RSS"
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
          T = (Xbar - mu)/sqrt(S^2/n)
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
      ]<Glicenko-Cantelli>
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

      更加改进的方法是核估计法。使用核估计法得到的的结果有更好的数学性质，例如连续。
      #definition[核估计][
        - 若 $K$ 非负且 $integral_(-infinity)^(infinity) K(x) dif x = 1$，则称 $K$ 为核函数。
        - 对于任何一个核函数 $K$ 以及窗宽 $h$，称：
          $
            hat(f)_n (x) = 1/(n h) sumBrN1(K((x - X_i)/h))
          $
          类似于数据在 $K$ 意义上的加权平均。对于通常的核函数，数据离 $x$ 越近数据贡献越大。窗宽越小，说明越重视靠近 $x$ 的数据，核估计波动较大。通常数据量小时窗宽取得较大，数据量大时窗宽取得较小。
      ]
      通常，$K$ 选取关于原点对称的单峰函数，常用的包括：
      - $K_0 (x) = 1/2 1_([-1, 1])$\
        注意到此时有：
        $
          f_n (x) = 1/(2 h) (F_n (x + h) - F_n (x - h))
        $
        其中 $F_n$ 是经验分布函数。这被称为 Rosenblatt 估计，是最早的核估计。
      - $K_1 (x) = NormalDis(x, 0, 1)$
      - $K_2 (x) = 1/(pi (1 + x^2))$
      显然核函数连续时，核估计也连续。同时在一定条件下，可以证明核估计是强相合的。关于窗宽的选择，人们也已经开发了许多成熟的方法。
      #remark[][
        上面这些估计都是非参数估计，很难达到参数估计的 $O(n^(-1/2))$ 收敛速度
      ]
= 假设检验
  == 提出问题
    假设检验是统计学的重要问题。往往，我们结合实际情况提出一个假设（Hyphothesis）$H_0$，往往称为*零假设* /Null hypothesis），其反面称为*备择假设*（Alternative）然后根据数据来判断这个假设是否成立。事实上，假设检验的思想有点类似反证法，只是因为随机性的存在，并不能导出绝对的矛盾。因此，往往思路是先假设零假设成立，检查某些小概率事件是否发生，如果发生，则拒绝零假设。
    #example[][
      某人声称可以判断不透明盒子中硬币正反面，做试验 $n$ 次，猜对 $m$ 次，能否认为他确实有这个能力？这就是要检验零假设 $H_0 : p = 1/2$（也就是没有这个能力）
    ]
    #example[][
      用仪器间接测量温度 $n$ 次，若已知真值，能否认为仪器准确？这就是要检验零假设 $H_0 : E X = mu_0$（也就是仪器准确）
    ]
    #example[独立性检验][
      研究抽烟与慢性支气管炎的关系，已知 $X, Y$ 的联合频次，检验 $X, Y$ 是否独立。
    ]
    #example[][
      给定一组数据，如何判断它是否服从某一个给定的分布？
    ]
    解决这类问题的方法是，找到从样本空间到 $[0, 1]$ 的可测函数 $phi$，对于数据 $X$，我们以概率 $phi(X)$ 拒绝 $H_0$，以概率 $1 - phi(X)$ 接受 $H_0$。有时，$phi$ 只取 $0, 1$，此时将 $S_1 := Inv(phi) (0)$ 称为接受域，$S_2 := Inv(phi) (1)$ 称为拒绝域。 

    $phi$ 不只取 $0, 1$ 时称为随机化检验法。理论上来讲，随机化检验法可能有更好的最优性，但实践中由于相同数据下可能有不同结果，因此会产生其它问题。

    通常，我们称：
    - $H_0$ 成立，但被拒绝为*第I类错误*（Type I error），以真为假
    - $H_0$ 不成立，但被接受为*第II类错误*（Type II error），以假为真
    通常而言，I 类错误概率低和 II 类错误概率低是矛盾的，因此我们需要权衡这两者。历史上，人们通常采用以下方法：给定检验水平 $alpha$，对于所有第 I 类错误概率小于 $alpha$ 的检验，找到第 II 类错误概率最小的检验。
    #definition[][
      称：
      $
        beta_phi (theta) = E_theta phi(X)
      $
      为检验法的功效函数。称 $L_phi (theta) = 1 - beta_phi (theta)$ 为检验法的操作函数。显然（在假设成立时） $beta$ 就是 I 类错误的概率，（假设不成立时）$L$ 就是 II 类错误的概率。
    ]
    #definition[][
      称 $phi$ 是水平为 $alpha$ 的检验法，如果 $beta_phi (theta) <= alpha, forall theta in Theta_0$. 称 $phi$ 是水平为 $alpha$ 的一致最大功效检验法（UMP），如果其检验水平为 $alpha$，且在所有检验水平为 $alpha$ 的检验法中，其功效函数在 $Theta - Theta_0$ 中一致最大。
    ]
    很多时候，UMP 检验并不存在。因此我们稍微放松一些：
    #definition[][
      称 $phi$ 是水平 $alpha$ 的无偏检验，如果：
      $
        beta_phi (theta) >= alpha, forall theta in Theta - Theta_0
      $
      也就是：
      - 若 $H_0$ 成立，拒绝的概率不超过 $alpha$
      - 若 $H_0$ 不成立，拒绝的概率不小于 $alpha$
    ]
    #definition[一致最优无偏检验（UMPU）][
      称 $phi$ 是水平为 $alpha$ 的一致最优无偏检验，如果它是水平为 $alpha$ 的无偏检验，且对于任何水平为 $alpha$ 的无偏检验 $phi'$，其功效函数在 $Theta - Theta_0$ 中一致最大。
    ]
    常见情况下，UMPU 往往是存在的。
  == N-P 引理及似然比检验法
    本节，我们处理参数空间只包含两点 $Theta = {theta_1, theta_2}$ 的情况，其中 $Theta_0 = {theta_1}$，$H_0 : theta = theta_1$. 不失一般性，假设两种参数下密度函数不恒等，则两种似然函数为：
    $
      L(x, theta) = prodBrN1(f(x_i, theta))
    $
    #definition[似然比][
      称：
      $
        lambda(x) = L(x, theta_2)/L(x, theta_1)
      $
      它是一个统计量。
    ]
    直观上，如果似然比大，说明参数更有可能取 $theta_2$，因此我们可以拒绝 $H_0$。反之，如果似然比小，说明参数更有可能取 $theta_1$，因此我们接受 $H_0$。
    #theorem[Neyman-Pearson (N-P)引理][
      给定 $alpha in (0, 1)$，设：
      $
        W_0 := {x | lambda(x) > lambda_0}
      $
      取检验函数：
      $
        phi_0 (x) = 1_(W_0) (x)
      $
      其中 $lambda_0$ 满足 $integral_W_0 L(x, theta_1) dif x = E_(theta_1) phi_0 (x) = beta_(phi_0) (theta_1) = P(x in W_0) = alpha$，则对任何水平不超过 $alpha$ 的检验函数 $phi$，有：
      $
        beta_phi (theta_2) <= beta_(phi_0) (theta_2) 
      $
    ]<N-P-lemma>
    #proof[
      任取 $phi$ 是检验水平不超过 $alpha$ 的检验。
      - 如果 $lambda(x) > lambda_0$，则有 $phi_0 (x) = 1$，因此 $phi_0 (x) >= phi(x)$
      - 反之，总有 $phi_0 (x) <= phi(x)$
      因此：
      $
        ((L(x, theta_2)/L(x, theta_1)) - lambda_0) (phi_0 (x) - phi(x)) >= 0\
        L(x, theta_2) (phi_0 (x) - phi(x)) >= lambda_0 L(x, theta_1) (phi_0 (x) - phi(x))
      $<ineq-N-P>
      继而：
      $
        beta_(phi_0) (theta_2) - beta_phi (theta_2) = E_(theta_2) (phi_0 (x) - phi(x)) = integral_()^() L(x, theta_2) (phi_0 (x) - phi(x)) dif x \
        >= lambda_0 integral_()^() L(x, theta_1) (phi_0 (x) - phi(x)) dif x = lambda_0 (beta_(phi_0) (theta_1) - beta_phi (theta_1)) >= 0
      $<int-N-P>
    ]
    #remark[][
      该引理表明，只要 $lambda_0$ 存在，似然比检验法就是 UMP，但有时 $lambda_0$ 可能不存在，例如：
      $
        f(x, theta_1) = cases(
          1/3 quad x in [0, 1],
          2/3 quad x in (1, 2]
        )\
        f(x, theta_2) = 1 - f(x, theta_1)
      $
      可计算得：
      $
        lambda(x) = cases(
          2 quad x in [0, 1],
          1/2 quad x in (1, 2]
        )
      $
      此时，功效函数是阶梯的，当且仅当 $alpha = 1/3$ 时满足 N-P 引理的 $lambda_0$ 存在。如果允许使用随机化检验法，使用相应的 N-P 引理可以在此种情形下找到 UMP 检验法。
    ]
    #example[][
      扔 10 次硬币，$H_0 : p = 1/2, H_1 : p = 3/4$，求检验水平为 $0.05$ 的检验法：

      首先，@N-P-lemma 中我们要求的是 $lambda(x) > lambda_0$，但熟知似然函数是 $X := sumBrN1(X_i)$ 的函数，且 $X$ 越大似然比越大，因此可以将条件等价为 $X > C$. 当 $H_0$ 成立时，可以计算得：
      $
        P(X >= 9) approx 0.0107\
        P(X >= 8) approx 0.0547
      $
      因此不存在一个 $C$ 使得 $X > C$ 的概率恰为 $alpha$，当然可以采用随机化检验得到一个 UMP 检验法。
    ]
    #theorem[][
      若密度函数的支撑与 $theta$ 无关，$lambda(x)$ 在 $theta = theta_1$ 是分布函数连续，则 @N-P-lemma 中的 $lambda_0$ 存在，且（在密度函数的支集上几乎处处相等的意义下）唯一的 UMP 检验。
    ]
    #proof[
      记 $S$ 是密度函数的支集，注意到 $lambda_0$ 的条件是：
      $
        P_(theta_1) (lambda(x) <= lambda_0) = 1 - alpha
      $
      由 $lambda$ 的连续性，当然能取得（不需要唯一）。

      记 $D_0 = {x | lambda(x) = lambda_0} inter S$，有：
      $
        P_(theta_1) (X in D_0) = 0 = integral_(D_0)^() L(x, theta_1) dif x 
      $
      因此 $D_0$ 是零测集。假设存在水平不超过 $alpha$ 的 UMP 检验法 $phi$，利用 UMP 定义可得@int-N-P 中不等号全部取等，因此@ineq-N-P 不取等的部分零测。事实上，其不取等的部分恰为：
      $
        S inter {x | phi_0 (x) != phi(x)}
      $
      因此结论成立。
    ]
    #lemma[][
      UMP 检验总是无偏的
    ]
    #proof[
      考虑随机化检验法 $phi_0(x) = alpha$，利用 UMP 的定义与其比较即可
    ]
  == 单参数检验
    假设参数空间 $Theta$ 是一维的，假设检验往往有以下四种类型：
    - $H_0: theta <= theta_1, H_1 : theta > theta_1$
    - $H_0 : theta in.not (theta_1, theta_2), H_1 : theta in (theta_1, theta_2)$
    - $H_0 : theta in [theta_1, theta_2], H_1 : theta in.not [theta_1, theta_2]$
    - $H_0 : theta = theta_0, H_1 : theta != theta_0$
    通常，零假设的区域都是闭的，这只是一个数学习惯。
    #definition[单参数指数分布][
      设分布函数（或概率函数）形如：
      $
        f(x, theta) = S(theta) h(x) e^(Q(theta) T(x))
      $
      其中 $Q$ 是严格增函数，则称该分布为单参数指数分布。其中 $T$ 就是一个完全充分统计量。
    ]
    回顾 @N-P-lemma，事实上可以发现得到的检验法与根本与 $theta_2$ 无关。直觉上，该检验法应该可以直接用于检验：
    $
      H_0 : theta = 0, H_1 : theta > 0
    $
    再复杂一点，也可以用于检验：
    $
      H_0 : theta <= theta_0, H_1 : theta > theta_0
    $
    #theorem[][
      设 $X$ 的分布是单参数指数型，检验问题为：
      $
        H_0 : theta <= theta_0, H_1 : theta > theta_0
      $
      若检验水平 $alpha in (0, 1)$，且存在 $C$ 使得 $P_(theta_0) (sumBrN1(T(X_i)) > C) = alpha$，则此问题的水平为 $alpha$ 的 UMP 检验法为：
      $
        phi_0 (x) = 1_(sumBrN1(T(x_i)) > C) (x)
      $
    ]
    #proof[
      尽管 $Theta_0 ,Theta_1$ 中均有无穷多点，但实际验证定义时只需要比较两点，利用 @N-P-lemma 即可。
    ]
    #remark[][
      如此构造的检验法，第 II 类错误的概率的上确界高达 $1 - alpha$，所幸实际问题中遇到这种极端情况的机会很小。同时，从构造方法也能看出，统计上对于第 I 类错误和第 II 类错误的权衡是不对称的，往往更重视第 I 类错误的概率不要过大。换言之，对于相同的问题，将零假设和备择假设互换可能会得到不同的结果。
    ]
    #example[][
      - 已知方差的正态分布 $N(mu, sigma^2_0)$，可以验证 $Q(mu) = mu/(sigma_0^2), T(x) = x$，则检验法为：
        $
          phi_0 (x) = 1_(sumBrN1(x_i) > C) (x)
        $
        其中：
        $
          P_(mu_0) (sumBrN1(X_i) > C) = alpha
        $
        注意到 $sumBrN1(X_i)$ 服从正态分布，因此这样的 $C$ 是容易查表得到的。例如 $alpha = 0.05$ 时，查表可得：
        $
          C = n(mu_0 + 1.65/sqrt(n) sigma_0)
        $
      - 已知期望的正态分布，检验方差：
        $
          H_0 : sigma^2 <= sigma^2_0, H_1 : sigma^2 > sigma^2_0
        $
        此时熟知 $Q(sigma^2) = -1/sigma^2 "单调增加，" T(x) = (x - mu_0)^2$，因此可以构造检验法：
        $
          phi_0 (x) = 1_(sumBrN1((X_i - mu_0)^2) > C) (x)
        $
        其中:
        $
          P_(sigma^2_0) (sumBrN1((X_i - mu_0)^2)/sigma^2 > C/sigma^2) = alpha
        $
        而 $sumBrN1((X_i - mu_0)^2)/sigma^2$ 服从 $chi^2(n)$ 分布，因此可以查表得到 $C$。
    ]
    #theorem[][
      设 $X$ 是单参数指数型，对于检验问题：
      $
        H_0 : theta in.not (theta_1, theta_2), H_1 : theta in (theta_1, theta_2)
      $
      若存在常数 $C_1, C_2$ 使得 $beta_(phi_0) (theta_i) = alpha, i = 1, 2$，而：
      $
        phi_0 (x) = 1_(sumBrN1(T(x_i)) in (C_1, C_2)) (x)
      $
      则 $phi_0$ 就是 UMP 检验法。
    ]
    #theorem[][
      设 $X$ 是单参数指数型，对于检验问题：
      $
        H_0 : theta in [theta_1, theta_2], H_1 : theta in.not [theta_1, theta_2]
      $
      若存在常数 $C_1, C_2$ 使得 $beta_(phi_0) (theta_i) = alpha, i = 1, 2$，而：
      $
        phi_0 (x) = 1_(sumBrN1(T(X_i)) < C_1 or sumBrN1(T(X_i)) > C_2) (x)
      $
      则它是该问题的 UMPU 检验。注意此时 UMP 检验是不存在的，因为总可以在一侧抬高功效函数，在另一侧降低功效函数。
    ]
    #theorem[][
      设 $X$ 是单参数指数型，其中 $Q'(theta) > 0$，对检验问题：
      $
        H_0 : theta = theta_0, H_1 : theta != theta_0
      $
      若存在常数 $C_1, C_2$ 使得：
      - $beta_(phi_0) (theta_0) = alpha$
      - $E_(theta_0) (phi_o (X) sumBrN1(T(X_i))) = alpha E_(theta_0) sumBrN1(T(X_i))$
      其中：
      $
        phi_0 (x) = 1_(sumBrN1(T(X_i)) < C_1 or sumBrN1(T(X_i)) > C_2) (x)
      $
      则 $phi_0$ 是该问题的 UMPU 检验。直观上，这类似于之前的情景将 $theta_1, theta_2$ 靠近。类似之前的情形，此时的 UMP 检验也不存在。
    ]<eq-testing>
    #remark[][
      @eq-testing 讨论的是很理论的情形。事实上可以证明，样本量无穷大时我们将概率为 $1$ 地否定 $H_0$，这就产生了悖论！不过实际情境中许多时候人们确实比较关心这样的结果。
    ]
    #example[][
      方差已知的正态分布，在 @eq-testing 中的情形中，直观上 $C_1, C_2$ 应该以 $mu_0$ 对称。可以证明，由对称性和条件 1 求出的 $C_1, C_2$ 也符合条件 2。
    ]
    #remark[][
      事实上，上面几种方法给出的肯定域都是某种意义上的置信区间，也就是说，对于某个参数的目标值（或者目标的上下确界），做假设检验等价于目标值是否落入当前数据下，给定水平的置信区间。
    ]
  == 广义似然比检验法
    在复杂的假设检验问题中，功效函数可能很复杂，因此统计学家往往会优先考虑广义似然比检验法。
    #definition[][
      假设似然函数为 $L(x, theta)$，则广义似然比统计量为：
      $
        lambda(X) = (sup_(theta in Theta) L(x, theta))/(sup_(theta in Theta_0) L(x, theta))
      $
      显然 $lambda(X) >= 1$. 理论上往往需要 $lambda$ 可测，实践上一般忽略。
    ]
    计算上，广义似然比的计算归结于带约束的最大似然估计问题。直观上，$lambda$ 太大时，$Theta_0$ 不太合理，应该否定 $H_0$。同时，假设 $t(x)$ 是 $theta$ 的充分统计量，则广义似然比就是充分统计量的函数。
    #definition[][
      给定检验水平 $alpha > 0$，若存在 $lambda_0 > 0$，使得 $sup_(theta in Theta_0)(beta_(phi_0) (theta)) = alpha$，其中：
      $
        phi_0 (x) = 1_(lambda(x) > lambda_0) (x)
      $
      则称 $phi_0$ 是水平为 $alpha$ 的广义似然比检验法。
    ] 
    #definition[相合][
      称检验法 $phi$ 是相合的，若 $theta in Theta - Theta_0$，有：
      $
        lim_(n -> +infinity) beta_phi (theta) = 1
      $
    ]
    #example[单个正态分布][
      - 已知方差的正态分布检验 $H_0: mu = mu_0$，则：
        $
          sup_(mu in Theta_0) L(x, mu) = L(x, mu_0)\
          sup_(mu in Theta) L(x, mu) = L(x, xbar)
        $
        计算得到广义似然比就是 $(xbar - mu_0)^2$ 的单调函数，根据正态分布得到第一类错误率恰为 $alpha$ 即可
      - 未知方差的正态分布检验 $H_0: mu = mu_0$，则：
        $
          sup_(mu in Theta_0, sigma > 0) L = L(x, mu_0, 1/n sumi1n2(x_i - mu_0))("最大似然估计")\
          sup_(mu, theta) = L(x, xbar, 1/n sumi1n2(x_i - xbar))
        $
        计算得到广义似然比就是 $T^2$ 的单调函数，根据 $t$ 分布得到第一类错误率恰为 $alpha$ 即可
      - 未知方差的正态分布，检验：
        $
          H_0: mu <= mu_0
        $
        此时，需要先计算 $xbar$，如果 $xbar <= mu_0$ 则广义似然比就是 $1$，否则最优的 $mu = mu_0$，计算得：
        $
          lambda(x) = cases(
            (1 + T^2(n - 1))^(n/2) quad xbar > mu_0,
            1 quad "else"
          )
        $
        当然，它还是 $T$ 的单调函数，根据 $t$ 分布得到 $mu = mu_0$时第一类错误率恰为 $alpha$ 即可（注意这就可以保证一般的情况下第一类错误的概率不超过 $alpha$）
      - 未知均值的正态分布函数，检验方差：
        $
          H_0: sigma^2 = sigma^2_0
        $
        此时，可以计算得：
        $
          lambda(x) = e^(-n/2) n^(n/2) u^(-n/2) e^(u/2)\
          where u = 1/sigma_0^2 sumi1n2(x_i - xbar)
        $
        此时检验法形如 $u in [C_1, C_2]$ 时不拒绝 $H_0$，这里我们又遇到了双侧取值的问题。尽管理论上可以证明可以取得精确的 $C_1, C_2$ 得到 UMPU 检验，但实践上往往还是取较为简单的两侧余留概率恰为 $alpha/2$，同时，当然不存在 UMP 检验。
      - 未知均值的正态分布函数，检验方差：
        $
          H_0: sigma^2 <= sigma^2_0
        $
        可以计算得：
        $
          lambda(x) = cases(
            e^(-n/2) n^(n/2) u^(-n/2) e^(u/2) quad u > n,
            1 quad "else"
          )
        $
        此时得到的形式是 $u > C_2$ 时否定 $H_0$，这个检验法是 UMPU 的。
    ]
    #definition[F 分布][
      设 $X_1, X_2$ 独立且服从 $chi^2(n_1), chi^2(n_2)$，则称：
      $
        F = (X_1/n_1)/(X_2/n_2)
      $
      为 $F$ 分布，记为 $F_(n_1, n_2)$
    ]
    #lemma[][
      若 $T tilde t(n)$，则 $T^2 tilde F(1, n)$
    ]
    #lemma[][
      设 $X tilde F_(n, n)$，则：
      $
        P(X > C) = P(X < 1/C)
      $
    ]
    #example[两个正态总体][
      下面我们假设 $X, Y$ 独立且服从正态分布
      - $H_0: sigma_1^2 = sigma_2^2$，此时 $Theta$ 维数为 $4$，可以计算得：
        $
          lambda(x, y) = ((n_1 - 1)/((n_1 + n_2)(n_2 - 1))F + 1/(n_1 + n_2))^((n_1 + n_2)/2)/(((n_1 - 1)/(n_1 (n_2 - 1)))^(n_1/2) (1/n_2)^(n_2/2) F^(n_1/2) )\
          where F = (sumi1n2(x_i - xbar)/(n_1 - 1))/(sumi1n2(y_i - ybar)/(n_2 - 1)) = s_1^2/s_2^2\
        $
        其中当假设成立时，$F$ 是独立的 $chi^2_(n_1 - 1)/(n_1 - 1)$ 与 $chi^2_(n_2 - 2)/(n_2 - 2)$ 的商，这种分布称为 *$F_(n_1 - 1, n_2 - 1)$分布*，原问题的检验法形如当 $F in [C_1, C_2]$ 时不拒绝原假设。实用中，$C_1, C_2$ 的取法往往也是两侧各余 $alpha/2$（同样也不是最优的）
      - $H_0 : sigma_1^2 <= sigma_2^2$，此时检验法形如 $F > C_2$ 时拒绝原假设。
      - 若已知 $sigma_1^2 = sigma_2^2$，$H_0 : mu_1 = mu_2$则 $lambda(x, y)$ 是 $abs(T)$ 的增函数，其中：
        $
          T = sqrt((n_1 n_2 (n_1 + n_2 - 2))/(n_1 + n_2)) (xbar - ybar)/(sqrt(sumi1n2(x_i - xbar) + sumi1n2(y_i - ybar)))
        $
        可以证明，假设成立时，$T tilde t(n_1 + n_2 - 2)$
      - 若已知 $sigma_1^2 = sigma_2^2$，$H_0 : mu_1 <= mu_2$，则检验法形如 $T <= C$ 时不拒绝原假设。
      - $H_0: mu_1 = mu_2$，此时用 $S^2$ 替代各自的 $sigma^2$，得到统计量：
        $
          T = (Xbar - Ybar)/sqrt(S_1^2/n_1 + S_2^2/n_2)
        $
        然而此时 $T$ 的精确分布仍然是未知的。可以证明，$n_1, n_2$ 较大时，$T$ 近似服从 $t(m)$，其中 $m$ 是接近于某个可计算数的整数。
    ]
    #example[成对数据的比较][
      设 $X$ 服从二元正态分布，$X_i$ 是若干独立同分布样本，这种问题称为成对数据。
      - $H_0: mu_1 = mu_2$，直接检验 $(1, -1) X$ 的对应 $mu = 0$ 即可。
    ]
    #example[指数分布][
      设 $X tilde 1/theta_1 e^(-x/theta_1), Y tilde 1/theta_2 e^(-x/theta_2)$，检验 $H_0 : theta_1 <= theta_2$，可以验证 $lambda(x, y)$ 可以表示成 $sumi1n(X_i)/sumi1n(Y_i)$ 的单调增函数。并且有：
      $
        sumi1n(X_i) tilde Gamma(n_1, 1/theta_1)\
        (2 T_1)/theta_1 tilde Gamma(n_1, 1 / 2) = chi^2_(2 n_1)
      $
      类似的，$(2 T_2) /theta_2 tilde chi^2_(2 n 2)$，因此若 $theta_1 = theta_2$，则：
      $
        ((2 T_1)/theta_1 quo (2 n_1))/((2 T_2)/theta_2 quo (2 n_2)) tilde F_(2 n_1, 2 n_2)
      $
    ]
    当然，广义似然比检验法未必好，但多数常用情况下，广义似然检验是好的。

    同时，注意假设检验和置信区间某种意义上是等价的。在水平 $alpha$ 下不否定 $H_0 : theta = theta_0$ 当且仅当 $1 - alpha$ 水平的置信区间包含 $theta_0$; 不否定 $H_0 : theta <= theta_0$ 当且仅当 $1 - alpha$ 水平的置信上限超过 $theta_0$，这也提供了一种将两种问题互相转换的方法。
  == 临界值与 p 值
    p-值是一个实践上很常见的统计概念，但在每个问题中往往有不同的定义。例如设 $X tilde N(mu, 10)$，若统计得 $n = 10, Xbar = 13.9, H_0 L mu = 12$，记 $eta = (Xbar - 12)/sqrt(10 / n) = 1.9$，我们称此时的 p 值为：
    $
      P(eta <= - 1.9) + P(eta >= 1.9) = 5.74%
    $
    若考虑 $H_0 : mu <= 12$，称此时的 p 值为：
    $
      P(eta >= 1.9) = 2.87%\
    $
    不严格地说，p 值是当 $H_0$ 成立时，模型产生数据与观测数据一样古怪或更古怪的概率（显然意义随着 $H_0$ 的不同而变化）。显然 p 值很小时，说明数据很古怪，$H_0$ 应当受到怀疑。
  == 拟合优度检验(Goodness-of-fit)
    建立模型是统计分析的基础，检验该模型拟合的好不好是统计学中非常重要的问题。有时，我们可以通过先验知识确定模型分布，例如大量独立变量的和服从正态分布。当不能确定时，就要进行拟合优度检验。
    === $chi^2$ 检验
      设 $X$ 是取 $t_0, t_1, ..., t_m$ 的离散随机变量（注意可能取值数为 $m + 1$），令 $H_0 : X tilde F_0$，则取 $p_k = P_(X tilde F_0) (X = t_k)$，总记 $n$ 个数据，取 $t_k$ 的频数为 $nu_k$，则令：
      $
        V = sumk0m((nu_k/n - p_k)^2 n / p_k) = sumk0m((nu_k - n p_k)^2 / (n p_k))
      $
      $V$ 近似是某种用频率逼近概率的加权残差。可以证明，若 $H_0$ 成立，则当 $n$ 充分大时，$V$ 依分布收敛于 $chi^2(m)$（事实上是中心极限定理的推论），因此当样本量足够多时，使用渐进分布 $chi^2(m)$ 找到近似的临界值，若 $V$ 超过临界值则应该拒绝 $H_0$。注意 $m$ 的选取应当和 $n$ 的规模匹配，$n$ 不大时 $m$ 不宜过大，若过大应当将取值适当合并。

      若 $X$ 是连续性随机变量，自然的想法是在实轴上适当取 $m$ 个点，将 $RR$ 分为：
      $
        (-infinity, t_1], (t_1, t_2], ..., (t_(m - 1), t_m], (t_m, +infinity)
      $
      考虑 $X$ 落入的区间，就得到了离散随机变量，再按之前的方法进行检验。

      更一般的，我们往往只想要检验样本是否来源于某种类型的分布，例如正态分布，并没有一个给定的 $F_0$，这种假设称为复杂假设。一般的思路往往是，先做参数估计得到一族分布中最好的分布，再对该具体分布做上面的检验。注意此时，假设参数个数为 $k$，则最终的自由度应该是 $m - k$，因为做 $k$ 次参数估计已经消耗了 $k$ 个自由度。
    === 独立性检验
      设 $X, Y$ 是两个离散随机变量，无妨设 $X$ 的值域为 $1, 2, ..., s, Y$ 的值域为 $1, 2, ..., t$，则可以构造一个 $s * t$ 的列联表，$i, j$ 元素为 $P(X = i, Y = j)$。我们希望检验 $X, Y$ 是否独立，思路是将其看作复杂假设检验问题：
      $
        H_0 : p_(i j) = p_i p_j
      $
      其中 $p_i, p_j$ 是分布族的待定参数。因此先做最大似然估计，得到：
      $
        p_i = n_i/n\
        p_j = n_j/n\
      $
      我们的参数估计消耗了 $s - 1 + t - 1$ 个自由度（注意最后一个估计已经由前面的估计得到，不计入自由度），得：
      $
        V = sum_(i = 1)^s sum_(j = 1)^s (n_(i j) - n p_i p_j)^2/(n p_i p_j)
      $
      近似服从 $s t - 1 - (s - 1) - (t - 1) = (s - 1)(t - 1)$

      类似的，连续性变量也可以离散化后再处理。
    === Kolmogorov-Smirnov 检验
      由 @Glicenko-Cantelli，自然的想到直接比较经验分布函数 $F_n$ 与目标分布 $F$，注意到分布函数单调有界，用 $L^infinity$ 范数比较 $F_n$ 与 $F$ 的方法就称为 Kolmogorov-Smirnov (K-S)检验。

      设 $X$ 是连续性随机变量，分布函数为 $F$，则有 $F(X) tilde U(0, 1)$，因此记 $Y = F_0(X)$，当假设成立时有 $Y tilde U(0, 1)$，并有：
      $
        d(F_n, F_0) = sup{abs(F_n (Inv(F_0)(y)) - y)} = sup{abs(tilde(F_n) (y) - y)}
      $
      这里 $y = F_0 (x)$，这就把值的分布变化到了均匀分布上，可以查表得到临界值。同时，还有以下结论：
      #theorem[][
        设 $X$ 的分布函数为连续函数 $F_0$，有：
        $
          lim_(n -> +infinity) P(sqrt(n) d(F_n, F_0) <= z) = Q(z)\
          where Q(z) = cases(
            sum_(k in ZZ) (-1)^k e^(-2 k^2 z^2) quad z > 0,
            0 quad "else"
          )
        $
      ]
    === 小结
      之前提到过，传统假设检验对于两类错误的态度是不均等的。第一类错误的概率往往是控制的，但第二类错误的概率最大可能很大。也就是说，我们总是倾向于不否定零假设。这就导致，对于多个互相矛盾的零假设，很可能这些假设同时被接受。这就意味着，在实际问题中，如何选择零假设是需要其他的先验判断的。期中考试范围到此为止。
= 回归分析与线性模型
  回归（Regression）最早是十九世纪英国科学家 Galton 在研究遗传规律时使用，他认为父子的身高/智商存在一种"回归"现象。在统计上，我们往往将关心的变量定为自变量和因变量，建立模型：
  $
    Y = f(X) + epsilon\
  $
  其中 $epsilon$ 是误差项，涵盖了所有未考虑的因素。最简单也是最常用的模型是线性模型：
  $
    Y = X beta + epsilon
  $
  习惯上，认为 $X$ 是非随机的给定误差，$epsilon$ 的随机性决定 $Y$ 的随机性。研究的问题包括：
  - 判断哪些 $X$ 与 $Y$ 相关和相关性强弱（检验）
  - 找出 $Y$ 与 $X$ 的近似关系式（估计）
  - 从新的 $X$ 预测 $Y$ 的值（预测）
  - 控制
  == 一元线性回归
    一元模型为：
    $
      y = a + b x + epsilon\
    $
    假设 $X$ 是 $x$ 的一个观测，就有：
    $
      Y = a 1_n + b X + epsilon\
    $
    通常我们假设：
    - $E(epsilon) = 0$
    - $var(epsilon) = sigma^2$
    - $cov(epsilon_i, epsilon_j) = 0, i != j$
    - $epsilon tilde N(0, sigma^2 I)$
    这些假设根据需要选择即可。
    === 最小二乘估计
      如果采用残差平方和 RSS 作为度量，就有：
      $
        RSS = norm2(Y - a 1_n - b X)
      $
      这是二次多项式，在很宽泛的条件下最小值存在，且可以求得：
      $
        hat(b) = (sumi1n((x_i - xbar)(y_i - ybar)))/(sumi1n((x_i - xbar)^2))\
        hat(a) = ybar - hat(b) xbar\
      $
      为了检验是否有效，可以检验问题：
      $
        H_0 : b = 0, H_1 : b != 0
      $
      如果不否定 $H_0$，说明没有道理确信 $X$ 与 $Y$ 有线性关系。在正态假设下，显然有 $b$ 也服从某个正态分布。
      #definition[][
        通常有下列统计量：
        - 残差 $e_i = Y_i = hY_i$
        - 偏差平方和 $l_(y y) = norm2(Y - Ybar 1_n)$
        - 回归平方和 $U = norm2(hY - Ybar 1_n)$
        - 残差平方和 $Q = norm2(Y - hY)$
      ]
      #lemma[][
        $l_(y y) = U + Q$
      ]
      #proof[
        只需证明：
        $
          inner(Y - hY, hY - Ybar 1_n) = 0\
        $ 
        而：
        $
          inner(Y - hY, hY - Ybar 1_n) = inner(Y - P Y, P Y - Ybar 1_n) = inner((I - P) Y, P Y - Ybar 1_n)\
          = inner(Y, (I - P)(P Y - Ybar 1_n)) = inner(Y, Ybar (I - P) 1_n) = 0
        $
      ]
      可以证明：
      $
        F = (U)/(Q/(n - 2)) tilde F(1, n - 2)
      $
      用该统计量即可检验原假设。
    
