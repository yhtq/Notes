#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业1",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 1
  == 戈 P37
    === 7
      假设存在 $f, H$ 使得：
      $
        dif H(x, y, theta, phi) = f(x, y, theta, phi) (dif x - a sin theta dif phi)\
        (partial^2 H)/(partial theta partial phi) = 0 = partialDer(a sin theta f, theta)\
        partialDer(f sin theta, theta) = sin theta partialDer(f, theta) + f cos theta = 0\
        (partial^2 H)/(partial theta partial x) = 0 = partialDer(f, theta)
      $
      以上两式给出 $f cos theta = 0, forall theta$，由于 $cos theta$ 仅在有限个点处非零，必须有 $f$ 几乎处处为零，这表明符合要求的积分因子不存在。
  == 胡 P318
    === 8.1
      #let bO = $bold(O)$
      #let bD = $bold(D)$
      #let bA = $bold(A)$

      设 $O, D$ 点在 $x$ 轴上，坐标分别为 $0, bD$，$A$ 点坐标为 $bA$。取广义坐标 $psi$，就有：
      - $Q$ 所做虚功为：
        $
          - Q partial bA_y = - Q l_2 cos psi partial psi
        $
      - $P$ 所做虚功为：
        $
          P partial bD_x = P partial (l_2 - l_1) cos psi = - P (l_2 - l_1) sin psi partial psi
        $
      由虚功原理，平衡时应当有：
      $
        - Q l_2 cos psi - P (l_2 - l_1) sin psi = 0\
        P / Q = - l_2 / (l_2 - l_1) cot psi
      $
    === 8.2
      设绳圈所在平面与球心距离为 $h$，选其为广义坐标：
      - 重力所做虚功为：
        $
          - m g partial h
        $
      - 绳子长度为：
        $
          2 pi sqrt(R^2 - h^2)
        $
        弹力为：
        $
          k (2 pi sqrt(R^2 - h^2) - l_0)
        $
        所做虚功为：
        $
          k (2 pi sqrt(R^2 - h^2) - l_0) partial (2 pi sqrt(R^2 - h^2)) = k (2 pi sqrt(R^2 - h^2) - l_0) (2 pi h/sqrt(R^2 - h^2)) partial h
        $
      因此平衡方程为：
      $
        m g = k (2 pi sqrt(R^2 - h^2) - l_0) (2 pi h/sqrt(R^2 - h^2)) 
      $
    === 8.4 
      设小环圆心连线与水平方向连线夹角为 $phi$。以圆环中心建立直角坐标系，取球坐标 $theta, phi$，则小环的位置为 $vec(a cos theta cos phi, a sin theta cos phi, a sin phi)$，并且有约束：
      $
        vt(theta) = omega\
        theta = omega t
      $
      因此小环的位置为：
      $
        vec(a cos omega t cos phi, a sin omega t cos phi, a sin phi)
      $
      其中 $phi$ 是广义坐标。
      - 重力所做虚功为：
        $
          0 = - m g partial (a sin phi) = - m g a cos phi partial phi\
        $
      - 离心力所做虚功为：
        $
          - m omega^2 a cos phi partial (a cos phi) = m omega^2 a^2 sin phi cos phi partial phi\
        $
      若可能在除底部外的位置平衡，则：
      $
        m omega^2 a^2 sin phi cos phi partial phi - m g a cos phi partial phi = 0\
        sin phi = g / (omega^2 a)
      $
      可见，只要 $g / (omega^2 a) <= 1$，都有解。
= 2
  == 戈 P37
    === 8
      设轴方向向量为 $bO = vec(cos theta, sin theta)$，发向量为 $bO^orthogonal = mat(0, 1;-1, 0) bO := H bO$， 两轮中心分别为 $Xv_1, Xv_2$，就有：
      - 根据刚体约束：
        $
          Xv_2 - Xv_1 = b bO\
          vt(Xv_2) - vt(Xv_1) = b vt(bO)
        $
      - 两轮都做纯滚动，因此：
        $
          vt(Xv_1) = a vt(phi) bO^orthogonal\
          vt(Xv_2) = a vt(phi') bO^orthogonal
        $
        结合前式有：
        $
          a (vt(phi') - vt(phi)) bO^orthogonal times bO = l vt(bO) times bO\
          a (vt(phi') - vt(phi))  = b vt(bO) times bO = b vt(theta)
        $
        做积分就得到：
        $
          a (phi' - phi) +C = b theta
        $
      - 
        对于杆上点 $Xv$，根据刚体运动，有：
        $
          D = (Xv_1 - Xv)/(Xv_1 - Xv_2) = (vt(Xv_1) - bv) / (vt(Xv_1) - vt(Xv_2))\
          vt(Xv_1) - bv = D a (vt(phi) - vt(phi')) bO^orthogonal\
          bv = vt(Xv_1) - D a (vt(phi) - vt(phi')) bO^orthogonal\
          = a vt(phi) bO^orthogonal - D a (vt(phi) - vt(phi')) bO^orthogonal\
        $
        进而：
        $
          sin theta vt(x) - cos theta vt(y) = v dot bO^orthogonal = a (vt(phi) - D (vt(phi) - vt(phi')))\
          cos theta vt(x) + sin theta vt(y) = v dot bO = 0
        $
        （题上结果有误（？））
    === 9
      记该固定点坐标为 $Xv_0 = vec(f(t), 0, )$，动点位置为 $Xv$，则约束可以写成：
      $
        vt(Xv) times (Xv - Xv_0) = 0\
        vec(vt(x), vt(y)) times vec(x - f(t), y) = 0\
        vt(x) y - vt(y) (x - f(t)) = 0\
        // y^2 vt(x/y) + f(t) vt(y) = 0\
        // vt(x/y) - f(t) vt(1/y) = 0
      $

      // #let bH = $bold(H)$
      // 假设存在积分因子，使得：
      // $
      //   dif H = g(Xv, t) (y dif x - (x - f(t)) dif y)
      // $
      // 将有：
      // - 
      //   $
      //     partialDer(g y, y) = partialDer(- g (x - f(t)), x)\
      //     g + y partialDer(g, y) = - g - (x - f(t)) partialDer(g, x)\
      //     2 g + y partialDer(g, y) + (x - f(t)) partialDer(g, x) = 0\
      //   $
      // 以及：
      // - 
      //   $
      //     partialDer(-g (x - f(t)), t) = partialDer(0, y) = 0\
      //     - (x - f(t)) partialDer(g, t) + g partialDer(f, t) = 0\
      //     1/g partialDer(g, t) = 1/(x - f(t)) partialDer(f, t)\
      //     ln g = integral_()^() 1/(x - f(t)) partialDer(f, t) dif t + C(x, y)\
      //     g = A(x, y) exp(integral_()^() 1/(x - f(t)) partialDer(f, t) dif t)\ 
      //   
      // 
    === 12
      #let bsigma = $bold(sigma)$
      题目表明：
      $
        U = V + m bsigma dot Xv times vt(Xv)\
        F^T = - partialDer(U, Xv) = - partialDer(V, Xv) - m (bsigma times vt(Xv))^T\
        F = - partialDer(V, Xv)^T + m bsigma times vt(Xv)
      $
      这就是 $F$ 的直角坐标表达式。极坐标系中，只需代入 $Xv = rho be, be = vec(cos theta cos phi, cos theta sin phi, sin theta)$ 就有：
      $
        dif e = mat(-sin theta cos phi, - cos theta sin phi;
        -sin theta cos phi, cos theta cos phi;
        cos theta, 0) vec(dif theta, dif phi) \
        F = - partialDer(V, rho be)^T + m vt(rho be) times bsigma\
        = - partialDer(V, rho be)^T + m (vt(rho) be + rho vt(be)) times bsigma\ 
      $
      依广义力的表达式，在极坐标系下：
      $
        Q = (partialDer(rho be, (rho, theta, phi)))^T F\
      $（不知道这一问是要求做什么）

      极坐标系下有运动方程：
      $
        m at(rho be) = - partialDer(V, rho be)^T + m (vt(rho) be + rho vt(be)) times bsigma\
        m (at(rho) be + 2 vt(rho) vt(be) + rho at(be)) = - partialDer(V, rho be)^T + m (vt(rho) be + rho vt(be)) times bsigma\
      $
      
      
      // 注意到拉氏函数为：
      // $
      //   L = T - q phi + q/c bA dot bv
      // $
      // 变换后拉氏函数变为：
      // $
      //   L' = T - q (phi - 1/c partialDer(psi, t)) + q/c (bA + nabla psi) dot bv = L + q/c (partialDer(psi, t) + bv dot nabla psi)
      // $
      // 注意到偏差项仅与位置，时间有关，由熟知的结论该项不影响拉氏方程，因此变换不影响运动方程。
= 3
  == 胡 P319
    === 8.5 
      选择小球 $1$ 的极坐标 $rho, theta$ 作为广义坐标，绳长为 $l$，则有：
      - 位置向量为：
        $
          Xv_1 = rho be, be = vec(cos theta, sin theta, 0), dif be = vec(-sin theta, cos theta, 0) dif theta\
          Xv_2 = (l - rho) epsilon_z
        $
      - 动能为：
        $
          T = 1/2 m_1 norm2(vt(Xv_1)) + 1/2 m_2 norm2(vt(Xv_2))\ 
          = 1/2 m_1 norm2(vt(rho) be + rho vt(be)) + 1/2 m_2 (vt(rho))^2\
          = 1/2 (m_1 + m_2) (vt(rho))^2 + 1/2 m_1 rho^2 norm2(vt(be))\
          = 1/2 (m_1 + m_2) (vt(rho))^2 + 1/2 m_1 rho^2 (vt(theta))^2\
        $
      - 势能为：
        $
          V = m_2 g (l - rho)\
          T - V = 1/2 (m_1 + m_2) (vt(rho))^2 + 1/2 m_1 rho^2 (vt(theta))^2 - m_2 g (l - rho)
        $
      - 拉氏方程为：
        $
          0 = dif/(dif t) partialDer(T - V, vt(rho)) - partialDer(T - V, rho) \
          = dif/(dif t) ((m_1 + m_2) vt(rho)) - (m_1 rho (vt(theta))^2 + m_2 g)\
          = (m_1 + m_2) at(rho) - m_1 rho (vt(theta))^2 - m_2 g\
          0 = dif/(dif t) partialDer(T - V, vt(theta)) - partialDer(T - V, theta) \
          = dif/(dif t) (m_1 rho^2 vt(theta)) - 0\
          = 2 rho vt(rho) vt(theta) + m_1 rho^2 at(theta)
        $
        显然第二个方程有初次积分：
        $
          m_1 rho^2 vt(theta) = C
        $
        以及能量积分：
        $
          H = #TODO
        $
    === 8.7
      选取 $O$ 为坐标原点，$theta, phi$ 为广义坐标，两小球位置为 $Xv_1, Xv_2$，套管位置为 $Xv_3$，则有：
      - 位置向量为：
        $
          Xv_1 = l vec(cos phi sin theta, sin phi sin theta, cos theta)\
          Xv_2 = l vec(-cos phi sin theta, -sin phi sin theta, cos theta)\
          Xv_3 = 2 l cos theta epsilon_z
        $
      - 动能为：
        $
          T_1 = 1/2 m norm2(vt(Xv_1)) = 1/2 m l^2 (vt(theta))^2 + 1/2 m l^2 sin^2 theta (vt(phi))^2\
          T_2 = T_1\
          T_3 = 1/2 M (4 l^2 sin^2 theta (vt(theta))^2) = 2 M l^2 sin^2 theta (vt(theta))^2\
          T = T_1 + T_2 + T_3 = m l^2 ((vt(theta))^2 + sin^2 theta (vt(phi))^2) + 2 M l^2 sin^2 theta (vt(theta))^2
        $
      - 势能为：
        $
          V = - 2 m g l cos theta
        $
      - 拉氏函数为：
        $
          L = m l^2 ((vt(theta))^2 + sin^2 theta (vt(phi))^2) + 2 M l^2 sin^2 theta (vt(theta))^2 + 2 m g l cos theta
        $
      - 拉氏方程为：
        $
          0 = dif/(dif t) partialDer(L, vt(theta)) - partialDer(L, theta)\
          = 2 m l^2 at(theta) + 4 M l^2 sin^2 theta at(theta) + 8 M l^2 sin theta cos theta (vt(theta))^2  \ 
          -2 sin theta cos theta (vt(phi))^2 + 4 M l^2 sin theta cos theta (vt(theta))^2 - 2 m g l sin theta\
          0 = dif/(dif t) partialDer(L, vt(phi)) - partialDer(L, phi)\
          = dif/(dif t) (2 m l^2 sin^2 theta vt(phi)) - 0\
          = 4 m l^2 sin theta cos theta vt(theta) vt(phi) + 2 m l^2 sin^2 theta at(phi)
        $
      - 显然第二式给出首次积分：
        $
          2 m l^2 sin^2 theta vt(phi) = C
        $
        以及能量积分：
        $
          H = #TODO
        $
    === 8.9
      使用题设 $L$ 列出的拉氏方程为：
      $
        0 = dif/(dif t) partialDer(L, vt(q)) - partialDer(L, q)\
        = dif/(dif t) e^(lambda t) m vt(q) - e(lambda t) kappa q\
        = lambda t e^(lambda t) m vt(q) + e^(lambda t) m at(q) - e^(lambda t) kappa q\
        m at(q) + lambda m vt(q) + kappa q = 0 
      $
      它的形式显然与标准的受阻尼振子相同。
    === 8.10
      稳定电磁场中，带电粒子的拉氏方程为：
      $
        dif/(dif t) partialDer(T - V', vt(Xv)) - partialDer(T - V', Xv) = 0\
      $
      也即：
      $
        0 = dif/(dif t) partialDer(T - e (phi - bv dot bA), vt(Xv)) - partialDer(T - e (phi - bv dot bA), Xv)\
        = dif/(dif t) (m vt(Xv) + e bA) - e bE\
        = m at(Xv) - e bE
      $
      因此（对任何曲线做曲线积分）：
      $
        0 = integral_()^() (m at(Xv) - e bE) dot dif Xv\
        = integral m vt(Xv) dif vt(Xv) + e phi\
        = 1/2 m norm2(vt(Xv)) + e phi + C\
        = T + e phi + C\
      $
      证毕
= 4
  #let sumbeta = sumfBr.with(config: (
    Var: $beta$,
    Lower: [],
    Upper: [],
  ))
  #let sumgamma = sumfBr.with(config: (
    Var: $gamma$,
    Lower: [],
    Upper: [],
  ))
  == 戈 P38
    === 11
      只需证明：
      $
        dif/(dif t) partialDer(T, vt(q_alpha)) = partialDer(vt(T), vt(q_alpha)) - partialDer(T, q_alpha)
      $
      事实上：
      $
        // dif/(dif t) partialDer(T, vt(q_alpha)) = dif/(dif t)partialDer(sum 1/2 m_i norm2(vt(Xv_i)), vt(q_alpha))\
        // = dif/(dif t) sum m_i vt(Xv_i) dot partialDer(vt(Xv_i), vt(q_alpha))\
        // = dif/(dif t) sum m_i vt(Xv_i) dot partialDer(Xv_i, q_alpha)
        
        // partialDer(vt(T), vt(q_alpha)) = partialDer(sum m_i vt(Xv_i) dot at(Xv_i), vt(q_alpha))\
        // = sum m_i partialDer(vt(Xv_i), vt(q_alpha)) dot at(Xv_i) + sum m_i vt(Xv_i) dot partialDer(at(Xv_i), vt(q_alpha))\
        // = sum m_i partialDer(Xv_i, q_alpha) dot at(Xv_i) + sum m_i vt(Xv_i) dot partialDer(at(Xv_i), vt(q_alpha))\
        // 
        dif/(dif t) partialDer(T, vt(q_alpha)) = sumbeta((partial^2 T)/(partial q_beta partial vt(q_alpha)) vt(q_beta) + (partial^2 T)/(partial vt(q_beta) partial vt(q_alpha)) at(q_beta)) + (partial^2 T)/(partial t partial vt(q_alpha))\
        partialDer(vt(T), vt(q_alpha)) = partialDer(sumbeta(partialDer(T, q_beta) vt(q_beta) + partialDer(T, vt(q_beta)) at(q_beta)) + partialDer(T, t), vt(q_alpha))\
        = sumbeta((partial^2 T)/(partial q_beta partial vt(q_alpha)) vt(q_beta)) + partialDer(T, q_alpha) + sumbeta((partial^2 T)/(partial vt(q_beta) partial vt(q_alpha)) at(q_beta)) + partialDer(T, vt(q_beta)) partialDer(at(q_beta), vt(q_beta)) + (partial^2 T)/(partial t partial vt(q_alpha))\
      $
      考虑到 $q_beta$ 是独立变量，有 $partialDer(at(q_beta), vt(q_beta)) = 0$，进而两式相等，证毕。
    === 13
      选取极坐标 $rho, theta$ 作为广义坐标，则：
      $
        Q = (partialDer(rho be, (rho, theta)))^T F = (partialDer(rho be, (rho, theta)))^T norm(F) be\
        = (be, rho partialDer(be, theta))^T norm(F) be = norm(F) vec(1, 0)
      $
      要找到广义势，只需确定 $V'$ 使得：
      $
        dif/(dif t) partialDer(T - V', vt(rho)) - partialDer(T - V', rho) = 0\
      $ 
      也即：
      $
        dif/(dif t) partialDer(V', vt(rho)) - partialDer(V', rho) = norm(F) = 1/rho^2 (1 - ((vt(rho))^2 - 2 at(rho) rho)/c^2 )
      $
      记：
      $
        L V' = dif/(dif t) partialDer(V', vt(rho)) - partialDer(V', rho)
      $
      则：
      $
        L (1/rho (vt(rho))^2) = 1/rho^2 (2 rho at(rho) - 2(vt(rho))^2 + (vt(rho))^2) = 1/rho^2 (2 rho at(rho) - (vt(rho))^2)\
        L (1/rho) = 1/rho^2\
        L (1/rho (1/c^2 (vt(rho))^2 +1) ) = norm(F)
      $
      这就是所求的广义势函数
    === 16
      有：
      $
        L' = m/2 quadFormSym(vt(Xv), A) - K/2 quadFormSym(Xv, A)
      $
      其中：
      $
        A = mat(a, b;b, c)
      $
      拉氏方程形如：
      $
        dif/(dif t) partialDer(L', vt(Xv)) - partialDer(L', Xv) = 0\
        dif/(dif t) (m A vt(Xv)) + K A Xv = 0\
        m A at(Xv) + K A Xv = 0\
      $
      根据条件，$A$ 可逆，上式化简为：
      $
        m at(Xv) + K Xv = 0
      $
      这表明，系统就是简谐振动。显然，若无此条件，则方程对于 $ker A$ 空间内的运动无任何约束。通常来说，系统拉氏函数为：
      $
        L = m/2 norm2(vt(Xv)) - K/2 norm2(Xv)
      $
      对于矩阵 $A$ 总可以找到矩阵 $C$（可能为复矩阵）使得 $C^T C = A$，做变换 $Xv = C Xv$ 就有：
      $
        L = m/2 quadFormSym(vt(Xv), C^T C) - K/2 quadFormSym(Xv, C^T C) = L'
      $
      这就给出了所求的点变换。
    === 18
      运动方程为：
      $
        dif/(dif t) (1/3 m^2 (vt(x))^3 + 2 m vt(x) V(x)) - m (vt(x))^2 partialDer(V, x) + 2 V(x) partialDer(V, x) = 0\
        m^2 (vt(x))^2 at(x) + 2 m V(x) at(x) - m (vt(x))^2 partialDer(V, x) + 2 V(x) partialDer(V, x) = 0\
        (m at(x) - partialDer(V, x)) m (vt(x))^2+ 2 V(x) (m at(x) + partialDer(V, x)) = 0
      $
      上式表明，系统的动能 $T$ 与“势能”$V$ 按照一定系数加权总和守恒为零。
= 5
  == 例 1
    假设恒力为 $bF$，有拉格朗日方程：
    $
      dif / (dif t) partialDer(L, vt(Xv)) - partialDer(L, Xv) = bF^T
    $
    其中：
    $
      L = - m_0 c^2 sqrt(1 - norm2(vt(Xv)) / c^2) 
    $
    代入计算得：
    $
      bF = dif/(dif t) (m_0 vt(Xv)/sqrt(1 - norm2(vt(Xv))/c^2))\
      m_0 vt(Xv)/sqrt(1 - norm2(vt(Xv))/c^2) = bF t + bC\
      m_0^2 (norm2(vt(Xv)))/(1 - norm2(vt(Xv))/c^2) = norm2(bF t + bC)\
      m_0^2 (norm2(vt(Xv)))/(c^2 - norm2(vt(Xv))) = c^2 norm2(bF t + bC)\
      norm2(vt(Xv)) = (c^4 norm2(bF t + bC))/(m_0^2 + c^2 norm2(bF t + bC))\
      m_0 vt(Xv)/sqrt(1 - (c^2 norm2(bF t + bC))/(m_0^2 + c^2 norm2(bF t + bC))) = bF t + bC\
      m_0 vt(Xv)/sqrt((m_0^2)/(m_0^2 + c^2 norm2(bF t + bC))) = bF t + bC\
      sqrt(m_0^2 + c^2 norm2(bF t + bC)) vt(Xv) = bF t + bC\
      Xv - Xv_0 = integral_(0)^(t) (bF t + bC)/sqrt(m_0^2 + c^2 norm2(bF t + bC)) dif t \
    $
    （对于一般的 $bC$ 没有找到简单形式）
  == 例 2
    根据总能量守恒：
    $
      m_0 c^2/sqrt(1 - v^2/c^2) + V = C\
      (m_0 c^2)/(V - C)^2 = 1 - v^2/c^2\
      (m_0 c^4)/(V - C)^2 = c^2 - v^2\
      v^2 = c^2 - (m_0 c^4)/(V - C)^2
    $
  == 例 3
    显然可得运动方程：
    $
      vt(bp) = q/(m) (bp times bB)\
      bp dot vt(bp) = 0 => vt(norm2(bp)) = 0
    $
    因此动量大小不变，也即速度大小不变，继而 $m$ 是一定值。这就保证粒子的运动状态和非相对论情形完全相同。