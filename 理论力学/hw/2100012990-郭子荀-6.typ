#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业6",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
#let bq = $bold(q)$
#let bp = $bold(p)$
#let bP = $bold(P)$
#let bQ = $bold(Q)$
= 胡 280
  == 1
    这是定轴转动，由机械能守恒，此时动能为：
    $
      T = sqrt(2) / 2 m g a = 1/2 I omega^2
    $
    其中 $I$ 是绕均匀杆一端转动的转动惯量，$I = 1/3 m (2 a)^2 = 4/3 m a^2$，因此：
    $
      1/2 4/3 m a^2 omega^2 = sqrt(2) / 2 m g a  =>  omega = sqrt((3 sqrt(2)) / 4 g / a)
    $
    注意到我们还有：
    $
      vt(G_A) = vt(bI_A omega bk) = vt(omega) bI_A bk = vt(omega) I bk = Xv_c times m bold(g)\ 
      m at(Xv_c) = m bold(g) + F\
      Xv_c = a e_theta\
      vt(Xv_c) = a omega e_theta^orthogonal\
      at(Xv_c) = a vt(omega) e_theta^orthogonal - a omega^2 e_theta\
    $
    其中 $F$ 是杆约束力。因此：
    $
      F = m (a vt(omega) e_theta^orthogonal - a omega^2 e_theta - bold(g))\
      = m (a (bk dot X_c times m bold(g))/I e_theta^orthogonal - a omega^2 e_theta - bold(g))\
      = m ((3 sqrt(2)) / 8 g e_theta^orthogonal - a omega^2 e_theta - (sqrt(2) / 2 g e_theta + sqrt(2) / 2 g e_theta^orthogonal))\
      = m (- sqrt(2) / 8 g e_theta^orthogonal - (5 sqrt(2))/4 g e_theta)\
    $
  == 2
    设摆对转轴的转动惯量为 $I$，就有：
    $
      I at(theta) = bk dot bX_c times m bold(g)\ = a m g sin theta\
      I / (a M) at(theta) = g sin theta\
    $
    比照单摆，相当于摆长为 $I / (a M)$ 的单摆。同时，根据平行轴定理有：
    $
      I = I_c + M a^2 = M (k_c^2 + a^2)\
    $
    因此等价的单摆的摆长为：
    $
      (k_c^2 + a^2) / a\
    $
  == 4
    $C$ 着地时，$A, B$ 两点瞬时静止，是瞬心，因此系统总动能为：
    $
      T = 2 dot 1/2 I omega^2\
    $
    其中 $I$ 是均匀杆绕一端转动的转动惯量，$I = 1/3 m l^2$。由机械能守恒：
    $
      sqrt(2)/2 m g l = I omega^2\
      omega = sqrt(3 sqrt(2) g / l)\
    $
    因此 $C$ 点速度为 $l omega = sqrt(3/3 sqrt(2) g l) = sqrt(3 g h)$
  == 6
    设板与球接触点为 $bX_0$，则球心速度为：
    $
      vt(bX_c) = vt(bX_0) + omega r bj\
      at(bX_c) = at(bX_0) - vt(omega) r bj 
    $
    同时，有：
    $
      M_2 at(bX_c) = f\
      I vt(omega) = r f\
    $
    其中 $I$ 是圆盘绕中心的转动惯量，$I = 1/2 M_2 r^2$，从而有：
    $
      f / M_2 = a - 2 f / M_2\
      f = 3 M_2 a
    $
    与此同时，对板有：
    $
      F - mu (M_1 + M_2) - f = M_1 a\
      F - mu (M_1 + M_2) - 3 M_2 a = M_1 a\
      a = (F - mu (M_1 + M_2)) / (M_1 + 3 M_2)
    $
  == 7
    受到的摩擦力为：
    $
      f = mu M g
    $
    因此，有：
    $
      I vt(omega) = - r f\
      vt(omega) = - 2 (mu g) / r\
      omega = omega_0 - 2 (mu g) / r t\
    $
    以及对质心有：
    $
      M at(X_c) = - f\
      at(X_c) = - mu g\
      vt(X_c) = - mu g t\
    $
    若要做纯滚动，有：
    $
      vt(X_c) + omega r = 0\
      r (omega_0 - 2 (mu g) / r t) = mu g t\
      3 mu g t = r omega_0\
      t = (r omega_0) / (3 mu g)
    $
  == 8
    摩擦力为：
    $
      f = sqrt(2) / 2 mu M g
    $
    只需考虑质心的运动，有：
    $
      M at(X_c) = sqrt(2) / 2 (1 - mu) M g\
      at(X_c) = sqrt(2) / 2 (1 - mu) g\
      vt(X_c) = sqrt(2) / 2 (1 - mu) g t\
      X_c = sqrt(2) / 4 (1 - mu) g t^2\ 
    $
    质心运动 $sqrt(2) h$ 时间为：
    $
      sqrt(2) / 4 (1 - mu) g t^2 = sqrt(2) h, t = 2 sqrt(h / ((1 - mu) g))
    $
    同时，有：
    $
      1/2 M r^2 vt(omega) = - r f\
      r vt(omega) = - 2 f / (M) \
      r omega = - 2 f/M t
    $
    当 $r omega + vt(X_c) <= 0$ 时可能纯滚动，也即：
    $
      - 2 f / M t + sqrt(2) / 2 (1 - mu) g t <= 0\
      (- 2 sqrt(2) / 2 mu + sqrt(2) / 2 (1 - mu)) g t <= 0\
      (1 - 3 mu) <= 0 => mu >= 1/3\
    $
    若做纯滚动，则：
    $
      vt(X_c) = r omega\
      1/2 M r^2 vt(omega) = r f\
      f = 1/2 M r vt(omega)\
      M at(X_c) = sqrt(2) / 2 M g - f \
      =  sqrt(2) / 2 M g - 1/2 M r vt(omega)\
      =  sqrt(2) / 2 M g - 1/2 M at(X_c)\
      at(X_c) = sqrt(2) / 3 g\
      X_c = sqrt(2) / 6 g t^2\
    $
    因此质心运动 $sqrt(2) h$ 时间为：
    $
      sqrt(2) / 6 g t^2 = sqrt(2) h, t = sqrt(6 h / g)
    $
  == 3
    相当于接触点是瞬心。过程中有：
    $
      I vt(omega) = h F\
      I Delta omega = h I_F
    $
    其中 $I$ 是绕该杆一端转动的转动惯量。同时，质心速度为：
    $
      vt(X_c) = 3/4 l Delta omega\
    $
    同时对整体有：
    $
      2 m vt(X_c) = I_F
    $
    代入就有：
    $
      I Delta omega = h 3/2 M l Delta omega\
      h = 2/3 I / (M l) 
    $
    只需计算 $I$ 即可。事实上：
    $
      I = integral_(0)^(l) m / l x^2  dif x + m x^2 = 4/3 m l^2\
    $
    因此 $r = 8/9 l$
  == 9
    根据之前习题的结论，做纯滚动之前，有：
    $
      vt(X_c) = v_0 - sqrt(2) / 3 g t\
      r omega = 2 (1/3 sqrt(2)/2 g t) = sqrt(2) / 3 g t\
    $
    当：
    $
      v_0 - sqrt(2) / 3 g t = r omega = sqrt(2) / 3 g t\
      t = 3/(2 sqrt(2)) v_0 / g
    $
    时，开始纯滚动。这段时间内，沿斜面运动距离为：
    $
      s_1 = v_0 t - 1/2 sqrt(2) / 3 g t^2 = 9/16 sqrt(2) v_0^2 / g
    $
    之后做纯滚动，有：
    $
      at(X_c) = - sqrt(2) / 3 g\
      vt(X_c) = v_1 - sqrt(2) / 3 g t\
      X_c = v_1 t - 1/6 sqrt(2) g t^2 + X_(c 1)
    $
    到达最高处时，$t = v_1 / (sqrt(2) / 3 g)$，代入计算得：
    $
      X_c = 1/4 v_1/(1/6 sqrt(2) g) = 3/4 sqrt(2)  v_1^2 / (g) = 3/16  sqrt(2)  v_0^2 / (g)
    $
    综上，总上升高度为 $3/4 v_0^2 / g$
  == 10
    离开墙前，有：
    $
      m at(Xv_c) = N_A bi + N_B bj - m g bj\
      2/3 m a^2 vt(omega) bk = (A - Xv_c) times N_A bi + (B - Xv_c) times N_B bj\
      =^(e_phi = (-cos phi, sin phi)^T) a(N_A e_phi times bi - N_B e_phi times bj)\ 
      = (- a N_A sin phi + a N_B cos phi) bk\
      2/3 m a vt(omega) = - N_A sin phi + N_B cos phi\
    $
    此外，还有：
    $
      bi dot vt(A) = bi dot (vt(Xv_c) + omega bk times (A - Xv_c)) = 0\
      0 = bi dot (vt(Xv_c) - omega a e_phi^orthogonal)\
      omega a sin phi = bi dot vt(Xv_c)\
      bj dot vt(B) = bj dot (vt(Xv_c) + omega bk times (B - Xv_c)) = 0\
      0 = bj dot (vt(Xv_c) + omega a e_phi^orthogonal)\
      - omega a cos phi = bj dot vt(Xv_c)\
    $
    这表明：
    $
      vt(Xv_c) = omega a vec(sin phi, - cos phi) = - a omega e_(-phi)^orthogonal\
      at(Xv_c) = - a vt(omega) e_(-phi)^orthogonal + a omega^2 e_(-phi)\
      = - 3/2 (N/m dot e^orthogonal_(-phi)) e_(-phi)^orthogonal + a omega^2 e_(-phi)\
      = - 3/2 ((at(Xv_c) + m g bj) dot e^orthogonal_(-phi)) e_(-phi)^orthogonal + a omega^2 e_(-phi)\
      (I + 3/2 e_(-phi)^orthogonal e_(-phi)^(orthogonal T)) at(Xv_c) = a omega^2 e_(-phi) - 3/2 m g (bj dot e^orthogonal_(-phi)) e_(-phi)^orthogonal\
      at(Xv_c) = Inv(I + 3/2 e_(-phi)^orthogonal e_(-phi)^(orthogonal T)) ( a omega^2 e_(-phi) - 3/2 m g (bj dot e^orthogonal_(-phi)) e_(-phi)^orthogonal)
    $
    这就得到了加速度表达式。脱离后，有 $N_A = 0$，上面的方程变为：
    $
      m at(Xv_c) = N_B bi - m g bj\
      2/3 m a vt(omega) = N_B cos phi\
      bj dot vt(Xv_c) = - omega a cos phi\
    $ 
    再次求解即可。
  == 11
    设力的冲量为 $I_F$，则有：
    $
      M vt(X_c) = I_F\
      1/2 M R^2 omega_1 = h I_F = h M vt(X_c)\
      omega_1 = 2 h / R^2 vt(X_c) = 2 h / R^2 v_0
    $
    之后，摩擦力为：
    $
      f = mu M g
    $
    之后一段时间，有：
    $
      M at(X_c) = f\
      at(X_c) = mu g\
      vt(X_c) = v_0 + mu g t\
      1/2 M R^2 vt(omega) = - R f = - R mu M g\
      R vt(omega) = - 2 mu g\
      R omega = R omega_1 - 2 mu g t\
    $
    最终纯滚动时，有：
    $
      vt(X_c) - R omega = 0\
      v_0 + mu g t - (2 h / R v_0 - 2 mu g t) = 0\
      mu R g t = (R - 2 h) v_0\
      mu g t = (R - 2 h) v_0 / (R) 
    $
    由条件，就有：
    $
      9/7 v_0 = v_0 + mu g t = v_0 + (R - 2 h) v_0 / (R)\
      9/7 = 1 + (1 - 2 h/R)\
      2 h / R = 5/7 \
      h = 5/14 R
    $
  == 13
    注意到：
    $
      bk dot (omega times G) 
      &= bk dot ((omega_(x y) + omega_z) times (I_1 omega_(x y) + I_2 omega_z))\
      &= (I_1 - I_2) bk dot (omega_(x y) times omega_z)\
      &= (I_1 - I_2) omega_(x y) dot (omega_z times bk) \
      &= 0
    $
    这就表明三向量共面。注意到 $bk dot omega, bk dot (I omega) = I_2 bk dot omega$ 同号，因此 $omega, G$ 在 $z$ 的一侧，谁在中间取决于 $I_2$ 与 $1$ 的大小关系。
  == 14
    书上的计算结果显然适用一般的欧拉情形的对称陀螺，因此正规进动性总是成立的。根据书上计算结果，有：
    $
      norm(S_0) = omega sin a\
      omega' = (I_z - I_x)/(I_x) omega cos a\
      vt(psi) = (omega sin a) / (sin theta)\
      vt(phi) = - omega'\
      omega cos a = omega sin a cot theta - omega'\
      theta = arctan((omega sin a)/(omega' + omega cos a))\
    $
  == 15
  根据上一题结论，相当于已知：
  $
    vt(phi) = omega_1, theta = pi/3, omega' = omega cos a = - omega_1\
    - omega_1 = omega sin a sqrt(3) / 3 + omega_1\
    omega sin a = - 2 sqrt(3) omega_1 = sin theta vt(psi) = sqrt(3) / 2 vt(psi) \
    vt(psi) = - 4 omega_1
  $
  == 16
    代入欧拉运动学方程就有：
    $
      omega_z = omega_2 cos theta + omega_1\
      omega_y = omega_2 sin theta sin phi\
      omega_x = omega_2 sin theta cos phi\
    $
    求导就有：
    $
      vt(omega_z) = -omega_2 sin theta + omega_1\
      vt(omega_y) = omega_2 sin theta cos phi vt(phi) + omega_2 cos theta sin phi vt(theta)\
      vt(omega_x) = - omega_2 sin theta sin phi vt(phi) + omega_2 cos theta cos phi vt(theta)\
    $
    代入欧拉动力学方程即可。
  == 18
    设轮子中心为 $O'$，进动角速度为 $vt(psi)$，总的角速度为：
    $
      omega = vt(psi) bk + omega O O'
    $
    角动量：
    $
      G = I_1 vt(psi) bk + I omega O O'\
      vt(G) = I omega vt(O O') = I omega vt(psi) (bk times O O') = I omega vt(psi) (L sin beta + l) bi
    $
    力矩：
    $
      L = O A times T
    $
  == 19
    设质心指向圆形路径中心的水平方向向量为 $bi$，水平面内垂直其的向量为 $bj$，竖直向上为 $bk$。设车轮轴的垂直方向为 $bi'$，则 $phi$ 就是 $bi$ 与 $bi'$ 的夹角。考虑一个车轮，其自转角速度为：
    $
      omega = v / l bi'
    $
    观察车轮与地面的接触轴，角动量包括：
    - 整体平动角动量：
      $
        G_1 = 2 M v l 
      $
    - 两个车轮的转动角动量
      $
        G_2 = 2 I (v / l) = 2 m l v
      $
    总之，角动量为：
    $
      G = -(2 M v l + 2 m v l) bi' =  - (2 M v l + 2 m v l) cos phi bi - (2 M v l + 2 m v l) sin phi bk
    $
    因此：
    $
      vt(G) = - (2 M v l + 2 m v l) cos phi vt(bi) = - (2 M v l + 2 m v l) cos phi v / R bj
    $
    相应的外力矩由重力提供，也就是：
    $
      L = - 2 M g l sin phi bj
    $
    立刻有：
    $
      - (2 M v l + 2 m v l) cos phi v / R bj = - 2 M g l sin phi bj\
      tan phi = (M + m)/M v^2 / (g R) 
    $
  == 20
    按照书上的坐标系，总角速度为：
    $
      omega_1 bk + theta' bi + Omega
    $
    因此：
    $
      G = I_3 omega_1 bk + I_1 theta' bi + I (0, bj, bk) Omega\
    $
    因此：
    $
      vt(G) = I_3 vt(omega_1) bk + I_1 at(theta) bi + I_3 (omega_1 + Omega_z) (vt(theta)' bi + Omega) times bk \
      approx I_3 vt(omega_1) bk + I_1 at(theta) bi + I_3 omega_1 (vt(theta)' bi + Omega_j bj) times bk
    $
    在 $bi$ 方向有：
    $
      I_1 at(theta) + I_3 omega_1 Omega_j = 0
    $
    在 $bk$ 方向有：
    $
      I_3 vt(omega_1) bk = 0
    $
    这表明 $omega_1$ 是常量，恰为 $omega_1$，则第一个方程变成：
    $
      I_orthogonal at(theta) + I_x omega Omega sin theta = 0
    $
    当 $theta$ 较小时，近似成线性方程，上面方程的解就是频率为：
    $
      sqrt((I_x omega_1 Omega) / I_orthogonal)
    $
    的振动。
  
    对于第二个问题，相当于原有 $Omega$ 用 $Omega cos lambda$ 代入，同时增加一个 $bi$ 方向的 $Omega$ 分量 $Omega sin lambda$，而 $bi$ 方向可以近似认为不动，因此根据之前的问题结果就是：
    $
      sqrt((I_x omega_1 Omega cos lambda) / I_orthogonal)
    $
  = P371
    == 3
      重力势能为：
      $
        V = m g a cos theta
      $
      动能为：
      $
        T = 1/2 quadFormSym(Omega, I)\
        = 1/2 I_1 ((psi' sin theta sin phi + theta' cos phi)^2 + (psi' sin theta cos phi - theta' sin phi)^2) + 1/2 I_3 (psi' cos theta + phi')^2\
        = 1/2 I_1 (psi'^2 sin^2 theta + theta'^2) + 1/2 I_3 (psi'^2 cos^2 theta + phi'^2 + 2 psi' phi' cos theta)
      $
      拉氏量为：
      $
        L = T - V\
        = 1/2 I_1 (psi'^2 sin^2 theta + theta'^2) + 1/2 I_3 (psi'^2 cos^2 theta + phi'^2 + 2 psi' phi' cos theta) - m g a cos theta
      $
      广义动量为：
      $
        P_theta = partialDer(L, theta') = I_1 theta'\
        P_phi = partialDer(L, phi') = I_3 (phi' + psi' cos theta)\
        P_psi = partialDer(L, psi') = I_1 psi' sin^2 theta + I_3 (psi' cos^2 theta + phi' cos theta)
      $
      哈密顿量为：
      $
        H = P_theta theta' + P_phi phi' + P_psi psi' - L\
        = I_1 theta'^2 + I_3 (phi' + psi' cos theta) phi' + (I_1 psi' sin^2 theta + I_3 (psi' cos^2 theta + phi' cos theta)) psi' - L\
        = 1/2 I_1 (psi'^2 sin^2 theta + theta'^2) + 1/2 I_3 (psi'^2 cos^2 theta + phi'^2 + 2 psi' phi' cos theta) + m g a cos theta\
      $
      它不显含 $t$，因此是守恒量（就是总能量）。
  == 3
    设摆动角为 $theta$，则：
    - 重力势能为：
      $
        V = M g l_0 (1 - cos theta)
      $
    - 动能为（根据柯尼西定理）：
      $
        T = 1/2 M l_0^2 theta'^2 + 1/2 I theta'^2 = 1/2 M (l_0^2 + k_0^2) theta'^2
      $
    - 拉氏量为：
      $
        L = T - V = 1/2 M (l_0^2 + k_0^2) theta'^2 - M g l_0 (1 - cos theta)
      $
    - 广义动量为：
      $
        P_theta = partialDer(L, theta') = M (l_0^2 + k_0^2) theta'\
        theta' = P_theta / (M (l_0^2 + k_0^2))
      $
    - 哈密顿量为：
      $
        H = P_theta theta' - L\
        = P_theta^2 / (2 M (l_0^2 + k_0^2)) + M g l_0 (1 - cos theta)
      $
    - 正则方程为：
      $
        vt(theta) = partialDer(H, P_theta) = P_theta / (M (l_0^2 + k_0^2))\
        vt(P_theta) = - partialDer(H, theta) = - M g l_0 sin theta
      $
= 戈 p282
  == 11
    系统包含三个自由度，设杆的摆动角度为 $alpha$，圆盘圆心的摆动角度为 $theta$，圆盘自转角度为 $phi$。则有：
    - 重力势能为：
      $
        V = - m g l cos alpha - M g r cos theta
      $
    - 动能为：
      $
        T = 1/2 (1/3 m l^2 vt2(alpha)) + 1/2 M a^2 vt2(theta) + 1/2 (1/2 M a^2 vt2(phi))
      $
    - 拉格朗日方程为：
      $
        1/3 m l^2 at(alpha) = m g l sin alpha\
        M a^2 at(theta) = M g r sin theta\
        1/2 M a^2 at(phi) = 0
      $
  == 18
    这就是对称刚体的自由运动问题，之前已经解过。
  == 24
    根据机械能守恒：
    $
      1/2 I_1 (omega_x^2 + omega_y^2) + 1/2 I_3 omega_z^2 + m g a cos theta = E_0\
    $
    而同时可以解出 $omega_z$ 是常量，这样就得到了 $omega^2_x + omega^2_y$ 只与 $theta$ 有关的表达式。自然的，若要 $G$ 均匀，即大小保持不变，则 $theta$ 角也不变。

