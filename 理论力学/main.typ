#import "../template.typ": *
#show: note.with(
  title: "理论力学",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let rv = $bold(r)$
= 拉格朗日方程
  == 约束
    #example[][
      对于单摆体系，本质而言，体系中只有一个约束：
      $
        f(x, y) = x^2 + y^2 - l^2 = 0
      $
      该约束与时间无关，称为稳定约束。
    ]
  == 虚位移，虚功
    在传统的牛顿力学中，一个体系往往要引入大量的方程来约束，很难求解。拉格朗日创立了虚位移和虚功的概念，从而大大简化了问题。
    #definition()[虚位移][
      假设有完全约束 $f(x, t) = 0$，$t_0$ 时刻约束允许的质点的所有可能位移方向称为虚位移，记作 $diff r$。事实上，是该时刻下约束曲线/曲面的所有切方向。有：
      $
        0 = diff f(x, y, z, t_0) = partialDer(f, x) diff x + partialDer(f, y) diff y + partialDer(f, z) diff z\
        = nabla f dot diff rv
      $
      换言之，就是梯度为法向量确定的平面。

      在稳定约束下，实际位移是虚位移的其中之一。而在不稳定约束下，结果较为复杂。
    ]
    #definition[虚功][
      称：
      $
        delta(x) = F dot diff rv
      $
      为虚功。往往拆分为：
      $
        F dot diff rv = F^a dot diff rv + N dot diff rv
      $
      其中 $F^a$ 是主动力，$N$ 是约束产生的约束力。
    ]
    假设体系中有 $n$ 个点，则有：
    $
      sum delta(x)_i = sum (F^a_i + N_i) dot diff rv_i = sum F^a_i dot diff rv_i + sum N_i dot diff rv_i
    $
    #definition[理想约束][
      称体系的理想约束为：
      $
        sum N_i dot diff rv_i = 0
      $
      常见的情形例如刚体约束、光滑面约束、理想定滑轮约束等。

      一个特殊的例子是，假设膨胀的气球上有一个蚂蚁，则支持力对于蚂蚁实际做功为正，但虚位移总是和支持力垂直的，因此仍然满足理想约束。
    ]
    在理想约束下，我们有：
    $
      sum delta(x)_i = sum F^a_i dot diff rv_i
    $
  == 虚功原理
    #proposition[虚功原理][
      在理想约束下，体系处于平衡状态的充要条件是 $sum F_i^a diff rv_i = 0$
    ]
    #proof[
      牛顿力学中，平衡条件是 $F_i^a + N_i = 0$，当然这个条件比虚功原理所要求的更强。反之，由理想约束，有：
      $
        sum_i (F_i^a + N_i) dot diff rv_i = sum F_i^a dot diff rv_i + sum N_i dot diff rv_i = sum F_i^a dot diff rv_i = 0
      $

    ]
  == 广义坐标、广义力
    #definition[广义坐标][
      设系统中有 $s$ 个独立的自由度，则：
      $
        X_i = X_i (q_1, q_2, ..., q_s, t)  (i = 1, 2, ..., 3n - k)
      $
      为质点的广义坐标。其中 $k$ 是约束的维度。
    ]
    在单摆中，取 $q = theta$，则 $x = l cos theta, y = l sin theta$ 就是一组广义坐标。在广义坐标下，虚位移表示为：
    $
      diff X = sum_i partialDer(X, q_i) diff q_i
    $
    而虚功表示为：
    $
      delta(x) = sum_i F_i dot diff X_i = sum_i F_i dot (sum_j partialDer(X_i, q_j) diff q_j) = sum_j (sum_i F_i dot partialDer(X_i, q_j)) diff q_j
    $
    我们就定义：
    $
      sum_i F_i dot partialDer(X_i, q_j) = Q_j
    $
    为体系中的第 $j$ 个*广义力*（并非对某个质点）。于是有：
    $
      delta(x) = sum_j Q_j diff q_j
    $
    由于 $diff q_j$ 是独立的，因此 $delta(x) = 0 <=> Q_i = 0, forall i$，也就是说虚功原理可以表述为：
    #align(center)[
      在理想约束下，体系处于平衡状态的充要条件是所有广义力为零
    ]
    #example[][
      仍然考虑单摆，取 $q = theta$，则有：
      $
        x = l cos theta, y = l sin theta
      $
      利用虚功原理，将 $theta$ 作为广义坐标，计算系统的广义力为：
      $
        Q_theta = G dot partialDer(r, theta) = m g partialDer(l cos theta, theta) = -l m g sin theta 
      $
      显然，系统平衡当且仅当 $theta = 0$
    ]
    #example[][
      考虑定滑轮系统，两侧物体质量分别为 $m_1, m_2$，则虚功原理给出平衡条件为：
      $
        0 = m_1 g diff x_1 + m_2 g diff x_2 = (m_1 g - m_2 g) diff x_1
      $
      因此若要平衡，只能 $m_1 = m_2$   
      ]
  == 保守力
    #definition[保守力][
      称力 $F$ 为保守力，若存在势能函数 $V(r, t)$ 使得：
      $
        F = -nabla V
      $
    ]
    若体系中只有统一的保守力，则可以计算体系的广义力：
    $
      Q_alpha = sum_i F_i dot partialDer(X_i, q_alpha) = - sum_i nabla V_i dot partialDer(X_i, q_alpha) = sum_i partialDer(V, X_i) dot partialDer(X_i, q_alpha) = - partialDer(V, q_alpha)
    $
    这就有了非常简单的形式。
    #example[][
      两根长度为 $l$，质量为 $m g$ 的均质硬杆相连，挂在墙上，第二根末端用 $F$ 的恒力拉，求平衡位置：

      假设两个杆与墙/前一根杆的夹角分别为 $alpha, beta$，显然这就是一组广义坐标。利用虚功原理：
      $
        diff w = m g diff c_1 + m g diff c_2 + F dot diff y_2\
      $
      其中 $c_1, c_2$ 分别为两个杆的重心，$y_2$ 为第二根杆末端的位置。计算得：
      $
        diff w = m g diff (l/2 sin alpha) + m g diff (l/2 sin beta + l sin alpha) + F dot diff (l (sin alpha + sin beta), l (cos alpha + cos beta)))\
        = l (3/2 m g cos alpha diff alpha + 1/2 m g cos beta diff beta + F dot (cos alpha diff alpha + cos beta diff beta, -sin alpha diff alpha - sin beta diff beta)\
      $
      平衡条件为：
      $
        0 = 3/2 m g cos alpha - F_y sin alpha + F_x cos alpha\
        0 = 1/2 m g cos beta - F_y sin beta + F_x cos beta\ 
      $
      解出即可。

      如果还要求天花板对杆的支持力，可以用以下方法：假想将约束解开，并加以力 $N$ 使得系统仍然在之前位置保持平衡。仍然利用虚功原理：
      $
        0 = diff w = N dot diff X_0 + m g diff c_1 + m g diff c_2 + F dot diff y_2
      $
      其中 $X_0$ 是杆的左上角。计算得：
      $
        0 = diff w = N dot diff X_0 + m g diff (x_0 + l/2 sin alpha) + m g diff (x_0 + l sin alpha + l/2 sin beta) \ + F dot diff X_0 + F dot diff (l (sin alpha + sin beta), l (cos alpha + cos beta)))\
        = l (3/2 m g cos alpha diff alpha + 1/2 m g cos beta diff beta + F dot (cos alpha diff alpha + cos beta diff beta, -sin alpha diff alpha - sin beta diff beta)\
        + N dot diff X_0 + 2 m g diff x_0 + F dot diff X_0
      $
      由于平衡条件与之前一样，前式前项平衡时为零，后项也为零，也即：
      $
        N dot diff X_0 + 2 m g diff x_0 + F dot diff X_0 = 0\
        N + (2 m g, 0) + F = 0
      $
      这就求得了 $N$
    ]
    #example[][
      设 $O D,O A, A B$ 是刚体杆，光滑连接，$O :(0, 0), D$ 固定， $B$ 在 $O D$ 上滑动，$angle D O x = alpha, angle A O B = beta$. 不妨设杆长为 $2 l$，计算平衡条件为：
      $
        diff w &= 1/2 m g diff y_A + m g diff (y_A + 1/2 (y_B - y_A))\ 
        &= m g diff (l sin (alpha + beta)) + m g (diff (2 l sin (beta + alpha)) + diff (l sin (alpha - beta)))\
      $
      解出即可。
    ]
    #example[][
      假设链条两端悬挂在 $h$ 高的位置，求链条形状：

      只考虑右半边，设曲线为 $y = f(x)$，对上面任何点 $(x, y)$ 想象链条沿原曲线滑动 $diff s$，则有：
      $
        diff w = - F_0 diff s + F_A diff s - rho g diff s y 
      $
      其中 $rho g diff s y$ 是滑动过程中重力做功（可以想象成底端的 $diff s$ 端被移动到上端，其他不变）

      同时，考虑总体受力一定有：
      $
        F_0 = F_A cos theta
      $

      结合 $tan theta = y'$，有：
      $
        F_0 (1/(cos theta) - 1) - rho g y = 0\
        F_0^2 1/(cos theta)^2 = (F_0 + rho g y)^2\
        F_0^2 (1 + y'^2) = (F_0 + rho g y)^2\
        y'^2 = (1 + (rho g y / F_0))^2 - 1 
      $
      求积分即可。
    ]
    以上就是分析力学的静力学部分。
  == 达朗伯原理
    牛顿力学中，有：
    $
      F = m derN(X, t, 2)
    $
    在系统中，我们自然就有：
    $
      F_i - m derN(X_i, t, 2) = 0\
      sum_i (F_i - m derN(X_i, t, 2)) dot diff X_i = 0
    $
    如果理想约束成立，就有：
    $
      sum_i (F_i^a - m derN(X_i, t, 2)) dot diff X_i = 0
    $
    这与虚功原理很相近，只需要把 $- m derN(X_i, t, 2)$ 看作一种“力”，这常常被称为*倒转有效力*或者*逆转力* 。
    #example[机械能守恒][
      设体系中有稳定约束（进而 $dif X_i in diff X_i$），且体系中只有保守力，则有：
      $
        dif X_i = der(X_i, t) dif t\
      $
      在虚功原理：
      $
        sum_i (F_i^a - m derN(X_i, t, 2)) dot diff X_i = 0
      $
      中，将 $dif X_i$ 代入得：
      $
        sum_i (F_i^a - m derN(X_i, t, 2)) dot der(X_i, t) dif t = 0\
        sum_i (F_i^a dot dif X_i - dif(1/2 m (der(X_i, t))^2)) = 0\
      $
      这就是常见的机械能守恒定律。
    ]
  == 第一类拉格朗日方程
    #let Xv = $bold(X)$
    之前提到的虚功原理和达朗伯原理，理论上已经足够强，但实践上不好操作。拉格朗日提出了更为简洁的方式，利用 $lambda$ 乘子进行计算。假设体系中有 $k$ 个约束：
    $
      f_i (Xv_1, Xv_2, Xv_n, t) = 0, i = 1, 2, ..., k 
    $
    取变分可得：
    $
      sum_j partialDer(f_i, Xv_j) dot diff Xv_j = 0
    $
    进而：
    $
      lambda_i sum_j partialDer(f_i, Xv_j) dot diff Xv_j = 0
    $
    结合达朗伯原理，有：
    $
      sum_i (F_i^a - m_i derN(Xv_i, t, 2) + sum_j lambda_j partialDer(f_j, Xv_i)) diff Xv_i = 0\
    $
    由于 $lambda$ 的任意性，我们直接令：
    $
      F_i^a - m_i derN(Xv_i, t, 2) + sum_j lambda_j partialDer(f_j, Xv_i) = 0, forall i\
      f_j (Xv_1, Xv_2, ..., Xv_n, t) = 0, forall j
    $<lagrange1>
    假设@lagrange1 有解，则解一定是原方程组的解。该方程组称为*第一类拉格朗日方程*。
    #example[][
      假设光滑斜面底部长 $a$，高度为 $b$，上有一物体，尝试使用第一类拉格朗日方程：
      - 约束方程为：
        $
          y = (a - x) tan alpha (tan alpha = b / a)
        $
      - 拉格朗日方程为：
        $
          (tan alpha, 1) Xv = a tan alpha\
          (tan alpha, 1) derN(Xv, t, 2) = 0\
          vec(0, - m g) - m derN(Xv, t, 2) + lambda der(y - (a - x) tan alpha, Xv) = 0\
          vec(0, - m g) - m derN(Xv, t, 2) + lambda vec(tan alpha, 1) = 0\
          - m g + lambda (1 + tan^2 alpha) = 0\
          lambda = m g cos^2 alpha\
          derN(Xv, t, 2) = vec(0, - g) + g cos^2 alpha vec(tan alpha, 1) = vec(g sin alpha cos alpha, - g sin^2 alpha)
        $
    ]
    #example[][
      垂直的上半圆周轨道，周长为 $R$，求何时离开球面：
      - 约束方程为 $Xv^T Xv >= R^2$，只需求何时约束不再是紧约束，先设：
        $
          Xv^T Xv = R^2\
          2 Xv^T der(Xv, t) = 0\
          derN(Xv^T, t, 2) Xv + 2 der(Xv^T, t) der(Xv, t)  + Xv^T derN(Xv, t, 2) = 0\
          Xv^T derN(Xv, t, 2) + norm(der(Xv, t))^2 = 0
        $
      - 拉格朗日方程为：
        $
          vec(0, - m g) - m derN(Xv, t, 2) + 2 lambda Xv = 0\
          X^T vec(0, - m g) + m norm2(der(Xv, t)) + 2 lambda R^2 = 0\
        $
        约束变为松弛约束时，$lambda = 0$，解出：
        $
          norm2(der(Xv, t)) = g y
        $
        接下来，利用机械能守恒：
        $
          vec(0, - m g) der(Xv, t) - m derN(Xv, t, 2) der(Xv, t) + 2 lambda Xv der(Xv, t) = 0\
          (0, g) der(Xv, t) + derN(Xv^2, t, 2) der(Xv, t) = 0\
          (0, g) (Xv - Xv_0) + 1/2 (norm2(der(Xv, t)) - norm2(der(Xv_0, t))) = 0\
        $
        就可以解出 $Xv$
    ]
    #example[][
      小环受主动力为 $F(Xv) = vec(k^2 x, - m g)$，约束为：
      $
          Xv^T Xv = R^2\
          2 Xv^T der(Xv, t) = 0\
          derN(Xv^T, t, 2) Xv + 2 der(Xv^T, t) der(Xv, t)  + Xv^T derN(Xv, t, 2) = 0\
          Xv^T derN(Xv, t, 2) + norm(der(Xv, t))^2 = 0
      $
      求平衡位置：
      - 拉格朗日方程为：
        $
          vec(k^2 x, - m g) - m derN(Xv, t, 2) + 2 lambda Xv = 0\
          Xv^T vec(k^2 x, - m g) + m norm2(der(Xv, t)) + 2 lambda r^2 = 0\
        $
        平衡时：
        $
          vec(k^2 x, - m g) + 2 lambda Xv = 0\
          4 lambda^2 R^2 = k^4 x^2 + m^2 g^2\
          2 lambda = plus.minus(sqrt(k^4 x^2 + m^2 g^2) / (2 R))\
          Xv = 1/(2 lambda) vec(- k^2 x, m g) = plus.minus(R / sqrt(k^4 x^2 + m^2 g^2)) vec(- k^2 x, m g)\
        $
    ]
  == 拉格朗日方程（第二类）
    #let Qv = $bold(Q)$
    仍然从达朗伯原理出发：
    $
      sum_i (F_i^a - m derN(Xv_i, t, 2)) dot diff Xv_i = 0
    $ 
    如果可以取广义坐标：
    $
      Xv_i = Xv_i (Qv_1, Qv_2, ..., Qv_s, t)
    $
    使得约束全部满足，带回就有：
    $
      sum_i (F_i^a - m derN(Xv_i, t, 2)) (sum_j partialDer(Xv_i, Qv_j) diff Qv_j) = 0\
    $


