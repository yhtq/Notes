#import "../template.typ": *
#show: note.with(
  title: "理论力学",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let rv = $bold(r)$
#let vt(x) = $der(#x, t)$
#let at(x) = $derN(#x, t, 2)$
= 拉格朗日方程
  == 约束
    #example[][
      对于单摆体系，本质而言，体系中只有一个约束：
      $
        f(x, y) = x^2 + y^2 - l^2 = 0
      $
      该约束与时间无关，称为稳定约束。
      11
    ]
  == 虚位移，虚功
    在传统的牛顿力学中，一个体系往往要引入大量的方程来约束，很难求解。拉格朗日创立了虚位移和虚功的概念，从而大大简化了问题。
    #definition()[虚位移][
      假设有完全约束 $f(x, t) = 0$，$t_0$ 时刻约束允许的质点的所有可能位移方向称为虚位移，记作 $d r$。事实上，是该时刻下约束曲线/曲面的所有切方向。有：
      $
        0 = d f(x, y, z, t_0) = partialDer(f, x) d x + partialDer(f, y) d y + partialDer(f, z) d z\
        = nabla f dot d rv
      $
      换言之，就是梯度为法向量确定的平面。

      在稳定约束下，实际位移是虚位移的其中之一。而在不稳定约束下，结果较为复杂。
    ]
    #definition[虚功][
      称：
      $
        delta(x) = F dot d rv
      $
      为虚功。往往拆分为：
      $
        F dot d rv = F^a dot d rv + N dot d rv
      $
      其中 $F^a$ 是主动力，$N$ 是约束产生的约束力。
    ]
    假设体系中有 $n$ 个点，则有：
    $
      sum delta(x)_i = sum (F^a_i + N_i) dot d rv_i = sum F^a_i dot d rv_i + sum N_i dot d rv_i
    $
    #definition[理想约束][
      称体系的理想约束为：
      $
        sum N_i dot d rv_i = 0
      $
      常见的情形例如刚体约束、光滑面约束、理想定滑轮约束等。

      一个特殊的例子是，假设膨胀的气球上有一个蚂蚁，则支持力对于蚂蚁实际做功为正，但虚位移总是和支持力垂直的，因此仍然满足理想约束。
    ]
    在理想约束下，我们有：
    $
      sum delta(x)_i = sum F^a_i dot d rv_i
    $
  == 虚功原理
    #proposition[虚功原理][
      在理想约束下，体系处于平衡状态的充要条件是 $sum F_i^a d rv_i = 0$
    ]
    #proof[
      牛顿力学中，平衡条件是 $F_i^a + N_i = 0$，当然这个条件比虚功原理所要求的更强。反之，由理想约束，有：
      $
        sum_i (F_i^a + N_i) dot d rv_i = sum F_i^a dot d rv_i + sum N_i dot d rv_i = sum F_i^a dot d rv_i = 0
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
      d X = sum_i partialDer(X, q_i) d q_i
    $
    而虚功表示为：
    $
      delta(x) = sum_i F_i dot d X_i = sum_i F_i dot (sum_j partialDer(X_i, q_j) d q_j) = sum_j (sum_i F_i dot partialDer(X_i, q_j)) d q_j
    $
    我们就定义：
    $
      sum_i F_i dot partialDer(X_i, q_j) = Q_j
    $
    为体系中的第 $j$ 个*广义力*（并非对某个质点）。于是有：
    $
      delta(x) = sum_j Q_j d q_j
    $
    由于 $d q_j$ 是独立的，因此 $delta(x) = 0 <=> Q_i = 0, forall i$，也就是说虚功原理可以表述为：
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
        0 = m_1 g d x_1 + m_2 g d x_2 = (m_1 g - m_2 g) d x_1
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
        d w = m g d c_1 + m g d c_2 + F dot d y_2\
      $
      其中 $c_1, c_2$ 分别为两个杆的重心，$y_2$ 为第二根杆末端的位置。计算得：
      $
        d w = m g d (l/2 sin alpha) + m g d (l/2 sin beta + l sin alpha) + F dot d (l (sin alpha + sin beta), l (cos alpha + cos beta)))\
        = l (3/2 m g cos alpha d alpha + 1/2 m g cos beta d beta + F dot (cos alpha d alpha + cos beta d beta, -sin alpha d alpha - sin beta d beta)\
      $
      平衡条件为：
      $
        0 = 3/2 m g cos alpha - F_y sin alpha + F_x cos alpha\
        0 = 1/2 m g cos beta - F_y sin beta + F_x cos beta\ 
      $
      解出即可。

      如果还要求天花板对杆的支持力，可以用以下方法：假想将约束解开，并加以力 $N$ 使得系统仍然在之前位置保持平衡。仍然利用虚功原理：
      $
        0 = d w = N dot d X_0 + m g d c_1 + m g d c_2 + F dot d y_2
      $
      其中 $X_0$ 是杆的左上角。计算得：
      $
        0 = d w = N dot d X_0 + m g d (x_0 + l/2 sin alpha) + m g d (x_0 + l sin alpha + l/2 sin beta) \ + F dot d X_0 + F dot d (l (sin alpha + sin beta), l (cos alpha + cos beta)))\
        = l (3/2 m g cos alpha d alpha + 1/2 m g cos beta d beta + F dot (cos alpha d alpha + cos beta d beta, -sin alpha d alpha - sin beta d beta)\
        + N dot d X_0 + 2 m g d x_0 + F dot d X_0
      $
      由于平衡条件与之前一样，前式前项平衡时为零，后项也为零，也即：
      $
        N dot d X_0 + 2 m g d x_0 + F dot d X_0 = 0\
        N + (2 m g, 0) + F = 0
      $
      这就求得了 $N$
    ]
    #example[][
      设 $O D,O A, A B$ 是刚体杆，光滑连接，$O :(0, 0), D$ 固定， $B$ 在 $O D$ 上滑动，$angle D O x = alpha, angle A O B = beta$. 不妨设杆长为 $2 l$，计算平衡条件为：
      $
        d w &= 1/2 m g d y_A + m g d (y_A + 1/2 (y_B - y_A))\ 
        &= m g partial (l sin (alpha + beta)) + m g (partial (2 l sin (beta + alpha)) + partial (l sin (alpha - beta)))\
      $
      解出即可。
    ]
    #example[][
      假设链条两端悬挂在 $h$ 高的位置，求链条形状：

      只考虑右半边，设曲线为 $y = f(x)$，对上面任何点 $(x, y)$ 想象链条沿原曲线滑动 $partial s$，则有：
      $
        partial w = - F_0 d s + F_A d s - rho g d s y 
      $
      其中 $rho g d s y$ 是滑动过程中重力做功（可以想象成底端的 $d s$ 端被移动到上端，其他不变）

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
      sum_i (F_i - m derN(X_i, t, 2)) dot d X_i = 0
    $
    如果理想约束成立，就有：
    $
      sum_i (F_i^a - m derN(X_i, t, 2)) dot d X_i = 0
    $
    这与虚功原理很相近，只需要把 $- m derN(X_i, t, 2)$ 看作一种“力”，这常常被称为*倒转有效力*或者*逆转力* 。
    #example[机械能守恒][
      设体系中有稳定约束（进而 $dif X_i in d X_i$），且体系中只有保守力，则有：
      $
        dif X_i = der(X_i, t) dif t\
      $
      在虚功原理：
      $
        sum_i (F_i^a - m derN(X_i, t, 2)) dot d X_i = 0
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
      sum_j partialDer(f_i, Xv_j) dot d Xv_j = 0
    $
    进而：
    $
      lambda_i sum_j partialDer(f_i, Xv_j) dot d Xv_j = 0
    $
    结合达朗伯原理，有：
    $
      sum_i (F_i^a - m_i derN(Xv_i, t, 2) + sum_j lambda_j partialDer(f_j, Xv_i)) d Xv_i = 0\
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
      sum_i (F_i^a - m_i derN(Xv_i, t, 2)) dot d Xv_i = 0
    $ 
    如果可以取广义坐标：
    $
      Xv_i = Xv_i (Qv_1, Qv_2, ..., Qv_s, t)
    $
    使得约束全部满足，带回就有：
    $
      sum_i (F_i^a - m_i derN(Xv_i, t, 2)) (sum_j partialDer(Xv_i, Qv_j) d Qv_j) = 0\
      sum_j (sum_i (F_i^a - m_i derN(Xv_i, t, 2)) partialDer(Xv_i, Qv_j)) d Qv_j = 0\
      sum_j (Q_j - sum_i m_i derN(Xv_i, t, 2) partialDer(Xv_i, Qv_j)) d Qv_j = 0\
      sum_j (Q_j - sum_i m_i (der(vt(Xv_i) partialDer(Xv_i, Qv_j), t) - vt(Xv_i) der(partialDer(Xv_i, Qv_j), t))) d Qv_j = 0\
      sum_j (Q_j - dif/(dif t) sum_i m_i vt(Xv_i) partialDer(Xv_i, Qv_j) + sum_i m_i vt(Xv_i) dif/(dif t) partialDer(Xv_i, Qv_j))) d Qv_j = 0\
    $
    注意到：
    $
      vt(Xv_i) = sum_j partialDer(Xv_i, Qv_j) vt(Qv_j) + partialDer(Xv_i, t)
    $
    假设 $Qv_j, vt(Qv_j)$ 独立，则有：
    $
      partialDer(vt(Xv_i), vt(Qv_j)) = partialDer(Xv_i, Qv_j)\
      dif/(dif t) partialDer(Xv_i, Qv_j) = sum_beta (partialDer(partialDer(Xv_i, Qv_j), Qv_beta) vt(Qv_beta)) + partialDer(partialDer(Xv_i, Qv_j), t)\
      = d/(d Qv_j) (sum_beta (partialDer(Xv_i, Qv_beta) vt(Qv_beta)) + partialDer(Xv_i, t)) = d/(d Qv_j) vt(Xv_i)
    $
    代回就有原式：
    $
      = sum_j (Q_j - dif/(dif t) sum_i m_i vt(Xv_i) partialDer(vt(Xv_i), vt(Qv_j)) + sum_i m_i vt(Xv_i) dif/(dif t) partialDer(Xv_i, Qv_j))) d Qv_j\
      = sum_j (Q_j - dif/(dif t) sum_i 1/2 m_i partialDer((vt(Xv_i))^2, vt(Qv_j)) + m_i sum_i vt(Xv_i) d/(d Qv_j) vt(Xv_i))) d Qv_j\
      = sum_j (Q_j - dif/(dif t) sum_i 1/2 m_i partialDer((vt(Xv_i))^2, vt(Qv_j)) + sum_i 1/2 m_i partialDer(vt(Xv_i)^2, Qv_j))) d Qv_j\
      = sum_j (Q_j - dif/(dif t) (d)/(d vt(Qv_j)) sum_i 1/2 m_i (vt(Xv_i))^2 + d/(d Qv_j) sum_i 1/2 m_i (vt(Xv_i))^2) d Qv_j\
      = sum_j (Q_j - dif/(dif t) (d)/(d vt(Qv_j)) T + d/(d Qv_j) T) d Qv_j\
    $
    再由广义坐标的独立性，立刻有：
    $
      Q_j = dif/(dif t) (d)/(d vt(Qv_j)) T - d/(d Qv_j) T
    $
    #proposition()[（第二类）拉格朗日方程][
      设体系中有 $s$ 个独立的自由度，且可以取广义坐标 $Qv_i$ 使得约束全部满足，则有：
      $
        dif/(dif t) (d)/(d vt(Qv_j)) T - d/(d Qv_j) T = Q_j
      $<lagrange2-ori>
      其中 $T = sum_i 1/2 m_i (vt(Xv_i))^2$ 是体系的动能，$Q_j = sum_i F_i^a partialDer(Xv_i, Qv_j)$ 是体系的第 $j$ 个广义力。
    ]
    #corollary()[][
      在保守力场中，有：
      $
        Q_j = - d/(d Qv_j) V
      $
      代入上面的方程，就是：
      $
        dif/(dif t) (d)/(d vt(Qv_j)) T - d/(d Qv_j) (T - V) = 0\
        dif/(dif t) (d)/(d vt(Qv_j)) (T - V) - d/(d Qv_j) (T - V) = 0\
      $<lagrange2-field>
      我们称 $L := T - V$ 为拉格朗日函数，或者特殊函数，特征函数，它是 $Qv_j, vt(Qv_j), t$ 的函数。上面的推导表明，它唯一决定了系统的运动状态。

      更进一步，对于一般的系统，可以有：
      $
        dif/(dif t) (d)/(d vt(Qv_j)) L - d/(d Qv_j) L = Q_j
      $
      其中 $Q_j$ 是非保守力产生的广义力。
    ]
    #example()[][
      推导平面极坐标体系的的加速度，我们有：
      $
        Xv = r vec(cos theta, sin theta)\
        v = (vt(r), r vt(theta))vec(e_r, e_theta)\
        T = 1/2 m ((vt(r))^2 + r^2 (vt(theta))^2)\
        Q_theta = F dot partialDer(Xv, theta) = F dot r vec(- sin theta, cos theta) = r F dot e_theta\
         Q_r = F dot partialDer(Xv, r) = F dot vec(cos theta, sin theta) = F dot e_r\
      $
      产生 $theta$ 的方程：
      $
        dif/(dif t) (d)/(d vt(theta)) T - d/(d theta) T = r F dot e_theta\
        m dif/(dif t) r^2 vt(theta) = r F dot e_theta\
        m 2 r vt(r) vt(theta) + m r^2 at(theta) = r F dot e_theta\
        at(theta) = 1/r a dot e_theta - 2/r vt(r) vt(theta) 
      $
      $r$ 的方程：
      $
        dif/(dif t) (d)/(d vt(r)) T - d/(d r) T = F dot e_r\
        m dif/(dif t) vt(r) - m r (vt(theta))^2 = F dot e_r\
        at(r) - r (vt(theta))^2 = F/m dot e_r\
        at(r) - r (vt(theta))^2 = a dot e_r\
        at(r) = r (vt(theta))^2 + a dot e_r\
      $
    ]
    #example[][
      两个定滑轮中间挂一动滑轮，三个滑轮依次挂重物质量为 $m_1, m_2, m_3$，绳长固定，广义坐标为两侧绳长 $l_1, l_2$，中间绳长 $l_3 = 1/2(l - l_1 - l_2)$，动能：
      $
        T = 1/2 (m_1, m_2, m_3) vec(vt(l_1)^2, vt(l_2)^2, vt(l_3)^2)
      $
      势能：
      $
        V = - g (m_1, m_2, m_3) vec(l_1, l_2, l_3)
      $
      代入方程进行计算即可。
    ]
    #theorem[][
      若使用：
      $
        L_1 = L + der(f, t)
      $
      替代 $L$，得到的方程仍然成立，其中 $f$ 是任何关于 $Qv_i, t$ 且对 $t$ 连续可微的函数
    ]
    #proof[
      只需证明：
      $
        dif/(dif t) (d)/(d vt(Qv_j)) der(f, t) - d/(d Qv_j) der(f, t) = 0
      $
      注意到：
      $
        vt(f) = sum_i partialDer(f, Qv_i) vt(Qv_i) + partialDer(f, t)
      $
      由独立性：
      $
        d/(d Qv_j) der(f, t) = sum_i (d^2 f)/(d Qv_j d Qv_i) vt(Qv_i) + (d^2 f)/(d Qv_j d t)\
        = dif/(dif t) partialDer(f, Qv_j)
      $
      以及：
      $
        (d)/(d vt(Qv_j)) vt(f) = partialDer(f, Qv_j)
      $
      这就证明了原结论。
    ]
    #example[耦合摆][
      两个细杆光滑地连接在一起，第一根与天花板连接，第二根末端有质量 $m_2$，两根的连接点有质量 $m_1$，设第一根杆与墙的法线为 $theta_1$，第二根与第一根夹角为 $theta_2$，则有：
      - 势能：
        $
          V = -m_1 g l_1 cos theta_1 - m_2 g (l_1 cos theta_1 + l_2 cos(theta_1 + theta_2))\
        $
        $
          T_1 = 1/2 m_1 (l_1 vt(theta_1))^2\
          Xv_2 = vec(l_1 cos theta_1 + l_2 cos theta_2, l_1 sin theta_1 + l_2 sin theta_2)\
          v_2 = vec(- l_1 sin theta_1 vt(theta_1) - l_2 sin theta_2 vt(theta_2), l_1 cos theta_1 vt(theta_1) + l_2 cos theta_2 vt(theta_2))\
          T = 1/2((m_1 + m_2) l_1^2 (vt(theta_1))^2 + 2 m_2 l_1 l_2 vt(theta_1) vt(theta_2) cos (theta_1 + ]./theta_2) + m_2 l_2^2 (vt(theta_2))^2)\
        $
    ]
    #example[][
      质量为 $M$ 的大环上固定质量为 $m$ 的小环，两者向前滚动。
      - 大环动能为：
        $
          1/2 M a^2 (vt(theta))^2 + 1/2 M (vt(x))^2
        $
      - 小环动能为：

    ]
  == 非稳定约束\*
    #example()[][
      三维空间中，有一圆盘，其法向量为 $v = vec(1, 0, 0)$，圆盘中心为 $vec(x, y, 0)$，沿方向 $v$ 做速度为 $v$ 的匀速运动
    ]
  == 对称性和守恒量 
    #let Pv = $bold(P)$
    #definition()[][
      设拉氏方程中，$L$ 不显含某个广义速度 $q_beta$，则称 $q_beta$ 是*循环坐标*。方程给出：
      $
        p_alpha := partialDer(L, vt(q_beta)) = C
      $
      它的积分被称为*初次积分*。

      一般的，我们称 $p_alpha$ 为*广义动量*，$(q_alpha, p_alpha)$ 为一对*共轭变量*。
    ]
    #proposition()[][
      在保守力场中，设 $L$ 不显含 $t$，则有：
      $
        der(L, t) = sum_i partialDer(L, Qv_i) dot vt(Qv_i) + sum_i partialDer(L, vt(Qv_i)) dot at(Qv_i) \
        = sum_i vt(partialDer(L, vt(Qv_i))) dot vt(Qv_i) + sum_i partialDer(L, vt(Qv_i)) dot at(Qv_i)\
        = sum_i vt(Qv_i) dot vt(Pv_i) + sum_i Pv_i dot at(Qv_i)\
        = sum_i vt((vt(Qv_i) dot Pv_i))\
      $
      这表明：
      $
        dif/(dif t) (sum_i vt(Qv_i) dot Pv_i - L) = 0
      $<Hamiltonian>
      一般的，我们称：
      $
        H := sum_i vt(Qv_i) dot Pv_i - L
      $
      上面的事实表明，$H$ 是与时间无关的守恒量，称为*哈密顿量*。@Hamiltonian 相较@lagrange2-field 而言，更加对称且微分次数少一次。
    ]
    #proposition()[][
      由定义得：
      $
        L = T - V\
      $
      其中：
      $
        T = sum_i 1/2 m_i norm2(vt(Xv_i))\
        = sum_i 1/2 m_i norm2(sum_j partialDer(Xv_i, Qv_j) vt(Qv_j) + partialDer(Xv_i, t))\
        = sum_i 1/2 m_i (sum_j norm2(partialDer(Xv_i, Qv_j) vt(Qv_j)) + sum_(j k) (partialDer(Xv_i, Qv_j) vt(Qv_j) dot partialDer(Xv_i, Qv_k) vt(Qv_k)) +2 sum_j partialDer(Xv_i, Qv_j) vt(Qv_j) dot partialDer(Xv_i, t) + norm2(partialDer(Xv_i, t)))\
        = sum_(j k) sum_i 1/2 m_i (partialDer(Xv_i, Qv_j) dot vt(Qv_j) partialDer(Xv_i, Qv_k) dot vt(Qv_k)) + sum_j (sum_i m_i partialDer(Xv_i, Qv_j) dot partialDer(Xv_i, t)) vt(Qv_j) + sum_i 1/2 m_i norm2(partialDer(Xv_i, t))\
        := 1/2 sum_(j k) vt(Qv_j)^T a_(j k) (Qv, t) dot vt(Qv_k) + sum_j b_j (Qv, t) dot vt(Qv_j) + c(Qv, t)
        := T_2 + T_1 + T_0\
        = vt(Qv)^T A(Qv, t) vt(Qv) + b(Qv, t) dot vt(Qv) + c(Qv, t)
      $
      由@Hamiltonian 有：
      $
        H = sum_i partialDer(L, vt(Qv_i)) dot vt(Qv_i) - L\
        = sum_i (partialDer(T, vt(Qv_i)) dot vt(Qv_i) - L)\
        = sum_i (partialDer(T_2 + T_1 + T_0, vt(Qv_i)) dot vt(Qv_i) - L)\
        = 2 T_2 + T_1 - (T_2 + T_1 + T_0 - V) \
        = T_2 - T_0 + V\
      $
      其中：
      $
        T_2 = quadFormSym(vt(Qv), (sum_i 1/2 m_i partialDer(Xv_i, Qv) partialDer(Xv_i, Qv)^T)) = quadFormSym(vt(Qv), A(Qv, t))\
      $
      我们将 $T_2 - T_0 + V$ 称为*广义能量* 或者*能量初积分*。如果约束是稳定的，则 $T_0 = 0$，进而广义能量就是系统的总能量。
    ]
  == 瞬时拉格朗日方程
    #proposition()[][
      在@lagrange2-ori 中，积分得到：
      $
        integral_(0)^(Delta t) dif / (dif t) ((partialDer(L, vt(Qv_i))) - partialDer(L, Qv_i)) dif t = integral_(0)^(Delta t) Q_i dif t\ 
      $
      考虑一个短时的冲击过程，$Q_i$ 可能很大，称：
      $
        I_alpha := integral_(0)^(Delta t) Q_i dif t
      $
      为广义冲量。而式子左侧，$partialDer(L, Qv_i)$ 中，考虑前面的动能分解式可以知道，$partialDer(L, Qv_i)$ 关于空间位置应该是连续变化的，因此在短时内积分近似为零。总之，可以得到：
      $
        partialDer(L, vt(Qv_i))|_(t = Delta t) - partialDer(L, vt(Qv_i))|_(t = 0) = I_i
      $
      或者：
      $
        partialDer(T, vt(Qv_i))|_(t = Delta t) - partialDer(T, vt(Qv_i))|_(t = 0) = I_i
      $
      如果不是短时过程，也可以使用下面的方程，但要将势能产生的保守力放到 $I_i$ 里面。
    ]
    #remark[][
      注意球之间的作用一定是虚功和为零的作用，因此不需要考虑约束力产生的冲量。
    ]
    #example[][
      设一菱形边长为 $l$，中心为 $(0, 0)$，顶点光滑地在 $x, y$  轴上，其中一边与 $y$  轴夹角为 $theta$，每边有均匀的质量 $l$，下端 $(0, -l cos theta)$  处施加冲量 $I = (0, -)$，则体系自由度两个，质心 $y$  坐标 $y_c$  以及角度 $theta$，有：
      - 动能：
        $
          T = 1/2 4 m (vt(y_c))^2 + 4 (1/2 m (1/2 l vt(theta))^2 + 1/2 I (vt(theta))^2)
        $
        其中 $I$  是棍绕中心转动的转动惯量，$I = 1/12 m l^2$
      - 计算：
        $
          partialDer(T, vt(y_c)) = 4 m vt(y_c)\
          partialDer(T, vt(theta)) = (1/2 m l^2 + 1/6 m l^2) vt(theta) = 4/3 m l^2 vt(theta)
        $
      - 计算广义冲量为：
        $
          I_(y_c) = integral_0^(Delta t) partialDer(Xv_A, y_c) dot F_A dif t integral_0^(Delta t)  F_A dif t = I\
          I_(theta) = integral_0^(Delta t) partialDer(Xv_A, theta) dot F_A dif t = integral_0^(Delta t) l sin theta F_A dif t
        $
        注意到 $Delta T$  时间较小，因此可以认为 $theta approx pi/4$(初始值)，就有 $I_theta = l / sqrt(2) I$
      - 列出公式：
        $
          4 m vt(y_c) (t) = I => vt(y_c) (t) = I / (4 m)\
          4/3 m l^2 vt(theta) (t) = sqrt(2)/2 l I => vt(theta) (t) = 3 sqrt(2) I / (8 m l)
        $
      仍以上面情景为例，设菱形本来以 $vec(0, -v)$  速度匀速运动，突然在下端 $A$  点被固定。上面大多数公式都成立，但 $F$  未知，而是知道最终 $A$  点速度：
      $
        vec(0, vt(y_c) (t) + l sin theta (t) vt(theta) (t)) = 0
      $
      以及：
      $
        4 m vt(y_c) (t) + 4 m v = I\
        4/3 m l^2 vt(theta) (t) = sqrt(2)/2 l I\
      $

    ]
  == 两体问题
    假设两物体质心为 $Xv_0$，相对坐标 $Xv_1 - Xv_2 := Xv$，可以解得：
    $
      Xv_1 = Xv_0 + m_2 / (m_1 + m_2) Xv\
      Xv_2 = Xv_0 - m_1 / (m_1 + m_2) Xv\
    $
    可以计算得：
    $
      L = T - V = 1/2 (m_1 + m_2) norm2(vt(Xv_0)) + 1/2 (m_1 m_2)/(m_1 + m_2) norm2(vt(Xv)) - V(Xv)
    $
    通常，我们假定 $V(norm(Xv))$  可以写成 $V(Xv_0) + V(Xv_1)$  的形式，例如地月体系中，太阳距离很远，角度很小，可以认为太阳的引力势能就是质心处的势能。如此，代入拉格朗日方程，有：
    $
      dif/(dif t) (partialDer(L, vt(Xv_0))) - partialDer(L, Xv_0) = 0\
      dif/(dif t) (partialDer(L, vt(Xv))) - partialDer(L, Xv) = 0\
      (m_1 + m_2) at(Xv_0) - partialDer(V(Xv_0), Xv_0) = 0\
      (m_1 m_2)/(m_1 + m_2) at(Xv) + partialDer(V(Xv), Xv) = 0
    $
    有时，我们会称 $(m_1 m_2)/(m_1 + m_2)$ 为*折合质量*，在上面的假设下，相当于地月体系在质心处受到折合质量的引力作用即可。
  == 电磁场中的广义势
    假设带电粒子在磁场中运动，则洛伦兹力理应做虚功，这带来了一些麻烦。实际上，可以使用*广义势*的概念来解决这个问题。假设电场为 $E$，磁场为 $B$，做变换：
    $
      E = - nabla phi - partialDer(A, t)\
      B = nabla times A
    $
    其中 $phi, A$ 都是位置和时间的函数。就有：
    $
      F= e(E + v times B)\
      = e (- nabla phi - partialDer(A, t) + vt(Xv) times (nabla times A))\
    $
    可以证明：
    $
      vt(Xv) times (nabla times A)) = partialDer(v dot A, Xv) - (vt(Xv) dot nabla) A
    $
    事实上，有：
    $
      vt(Xv) times (nabla times A) = der(A, t) - partialDer(A, t)
    $
    总之，最终可以得到广义的拉氏函数：
    $
      L = T - q phi + q bA dot bv
    $
    #example[][
      设带电粒子质量为 $m$ 电荷为 $q$，$E = vec(0, e, 0), B = vec(0, 0, b)$，求解运动：

      首先，找到电磁场中的标势和矢势，我们有：
      $
        phi(Xv) = (0, e, 0) Xv\
        Delta times A = vec(0, 0, b)\
        A Xv = mat(0, 0, 0;b, 0, 0;0, 0, 0) Xv 
      $ 
      则：
      $
        L' = 1/2 m norm2(vt(Xv)) - q ((0, e, 0) Xv) + q Xv^T  mat(0, b, 0;0, 0, 0;0, 0, 0) vt(Xv)\
        0 = dif/(dif t) partialDer(L', vt(Xv)) - partialDer(L', Xv) = dif/(dif t) (m vt(Xv) + q mat(0, 0, 0;b, 0, 0;0, 0, 0) Xv) + vec(0, e q, 0) - q mat(0, b, 0;0, 0, 0;0, 0, 0) vt(Xv)
      $
    ]
  == 摩擦力和耗散系数 
    常见的流体导致的摩擦力与速度正相关。速度不太大时，近似有：
    $
      F_i = - B vt(Xv_i)
    $
    对于此种阻力，我们同样可以定义广义势函数处理它。事实上，定义：
    $
      J(Xv) = 1/2 quadFormSym(vt(Xv), B)
    $
    立刻就有：
    $
      dif/(dif t) (partialDer(L, vt(Qv))) - partialDer(L, Qv) = - partialDer(Xv, Qv) partialDer(J, vt(Xv)) = - partialDer(vt(Xv), vt(Qv)) partialDer(J, vt(Xv)) = - partialDer(J, vt(Qv)) 
    $
    我们往往称 $J$ 为体系的耗散函数。上面的方程可以看出，它也可以放进 $L$ 之中，表明系统的“总能量”应该随着时间衰减。可以证明，假设系统中 $T + V$ 与位置无关，$Xv$ 是 $Qv$ 的函数（不含时间），则有：
    $
      1/2 vt(T + V) = - J
    $
    这就是为什么它被称为耗散函数
  == 相对论情形
    相对论情形下，力的概念是相似的，但动能的概念无法确定。基本上来说，有：
    $
      F = vt(m v) = vt(p)\
      p = m v\
      m = m_0/sqrt(1 - v^2 / c^2)
    $
    可以证明，相对论情形下只要把 $L$ 换成：
    $
      L = - m_0 c^2 sqrt(1 - v^2 / c^2) - V
    $
    则拉氏方程同样成立。事实上：
    $
      dif/(dif t) partialDer(L, vt(Xv)) - partialDer(L, Xv) = dif/(dif t) (m_0/sqrt(1 - v^2 / c^2) (vt(Xv))^T)\
      = dif/(dif t) m (vt(Xv))^T\
      = dif/(dif t) p^T\
      = F^T 
    $
= 小振动理论
  == 运动方程
    假设有 $n$ 个质点，保守体系，$s$ 个自由度，所有约束皆为稳定约束。所谓小振动，是指系统在稳定点附近小范围振动。因此：
    $
      V = V(0) + (partialDer(V, Qv)) Qv + 1/2 quadFormSym(Qv, partialDerN(V, Qv, 2)) + ...\
    $
    由于是稳定点，因此可以认为 $partialDer(V, Qv) = 0$，并且忽略高阶项，因此：
    $
      V = V(0) + 1/2 quadFormSym(Qv, K)
    $
    其中 $K = partialDerN(V, Qv, 2)$，通常我们认为它是正定的。类似的：
    $
      T = 1/2 quadFormSym(vt(Xv), M) = 1/2 quadFormSym(vt(Qv), (quadFormSym(partialDer(Xv, Qv), M)))
    $
    注意它本身就是二次项，因此我们近似认为：
    $
      T = 1/2 quadFormSym(vt(Qv), A)
    $
    其中 $A = (quadFormSym(partialDer(Xv, Qv), M)) (0)$，之后，就可以得到拉氏方程：
    $
      dif/(dif t) (partialDer(L, vt(Qv))) - partialDer(L, Qv) = 0\
      dif/(dif t) (A vt(Qv)) + K Qv = 0\
      A at(Qv) + K Qv = 0
    $
    设 $bY = vt(bX)$，则方程等价为：
    $
      dif/(dif t) vec(bX, bY) = mat(0, I; - Inv(A) K, 0) vec(bX, bY)
    $
    它的基础解矩阵为：
    $
      e^(mat(0, I; - Inv(A) K, 0) t)
    $
    因此原方程的特解为：
    $
      S e^(mat(0, I; - Inv(A) K, 0) t) S^T
    $
    设 $M := mat(0, I; - Inv(A) K, 0)$，则其特征值满足：
    $
      Det(lambda I, -I;Inv(A) K, lambda I) = 0\
      Det(lambda I, -I;lambda^2 I + Inv(A) K, 0) = 0\
      det(lambda^2 I + Inv(A) K) = 0
    $
    或者：
    $
      det(lambda^2 A + K) = 0
    $
    事实上，注意到：
    $
      Inv(A) K = Inv(sqrt(K))(sqrt(K) Inv(A) sqrt(K)) sqrt(K)
    $
    而 $sqrt(K) Inv(A) sqrt(K)$ 对称正定，因此特征值都是正的，且可设：
    $
      sqrt(K) Inv(A) sqrt(K) = P D^2 Inv(P)
    $
    就有：
    $
      Inv(A) K = Inv(sqrt(K)) P D^2 Inv(P) sqrt(K) := C^2
    $
    因此 $Inv(A) K = C^2$
    
    因此，$mat(P, 0;0, P) e^(i D t)$ 也是一个特解。其中：
    $
      D^2 = Inv(A) K
    $
    $D$ 的特征值被称为 *本征频率* 或者 *本征值*。
    #example()[][
      设有两个参数为 $l, m$ 的单摆，水平距离为 $l$，两个球通过弹簧连接在一起，弹簧原长度恰为 $l$. 取两个单摆摆动角度 $theta_1, theta_2$，则：
      - 动能为：
        $
          1/2 m (norm2(vt(l sin theta_1)) + norm2(vt(l sin theta_2))) approx 1/2 m l^2 ((vt(theta_1))^2 + (vt(theta_2))^2)
        $
      - 势能为：
        $
          V approx m g l (1 - cos theta_1) + m g l (1 - cos theta_2) + 1/2 k (l (theta_1 - theta_2))^2\
          approx 1/2 m g l (theta_1^2 + theta_2^2) + 1/2 k (l (theta_1 - theta_2))^2
        $
      在小振动问题中，拉氏函数总是广义坐标的二次函数，不会有一次项
    ]

  

    

