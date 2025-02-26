#import "../template.typ": *
#show: note.with(
  title: "数理统计",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
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