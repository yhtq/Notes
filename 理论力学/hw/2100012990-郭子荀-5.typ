#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业5",
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
= 胡 P145
  == 1
    直接代入比内公式，有：
    $
      derN(u, theta, 1) = - 2 a (sin theta)/(2 a cos theta)^2\
      derN(u, theta, 2) = - 2 a (cos theta (2 a cos theta)^2 + 2 a sin^2 theta (2 a cos theta))/(2 a cos theta)^4\
      = - 2 a (2 a cos^2 theta + 2 a sin^2 theta)/(2 a cos theta)^3\
      = - (2 a)^2 u^3\
    $
    因此：
    $
      - m c^2 u^2 (1/(2 a)^2 1/(cos theta)^3 + u) = F\
      - m c^2 u^2 (- (2 a)^2 u^3 + u) = F\
      F = - m c^2 (u^3 - 4 a^2 u ^5)\
      = - m c^2 (1/(2 a cos theta)^3 - 4 a^2/(2 a cos theta)^5)\
      = - m c^2 ((4 a^2 cos^2 theta - 4 a^2)/r^5)\
      = (4 m c^2 a^2 sin^2 theta)/r^5 
    $
  == 2
    代入比内公式：
    $
      - m c^2 u^2 (derN(u, theta, 2) + u) = - m (mu^2/r^2 + nu^2/r^3)\
      derN(u, theta, 2) + u = (mu^2 / c^2) + (nu^2 / c^2) u\
      derN((1 - (nu^2 / c^2)) u, theta, 2) + (1 - (nu^2 / c^2)) u = mu^2 / c^2\
    $
    熟知它的解形如：
    $
      (1 - (nu^2 / c^2)) u = mu^2 / c^2 + A cos(theta - theta_0)\
    $
    这就给出了轨道方程
  == 3
    根据能量守恒式：
    $
      1/2 m vt2(r) + l^2/(2 m r^2) + V(r) = E
    $
    就有：
    $
      1/2 m a^2 / r^2 + l^2/(2 m r^2) + V(r) = E\
      V(r) = E - C / r^2, where C = (1/2 m a^2 + l^2/(2 m))\
    $
    代入比内公式：
    $
      - m c^2 u^2 (derN(u, theta, 2) + u) = - der(V, r) = - 2 C/r^3\
      m c^2 u^2 (derN(u, theta, 2) + u) = 2 C u^3\
      derN(u, theta, 2) + u = (2 C)/(m c^2) u
    $
    熟知它的解形如：
    $
      (1 - (2 C)/(m c^2)) u = A cos(theta - theta_0)\
      r = ((1 - (2 C)/(m c^2)))/(A cos(theta - theta_0))
    $
  == 8
    由于碰撞过程动量守恒，设碰前速度为 $v_1$，则碰后速度为 $1/2 v_1$，动能从：
    $
      1/2 m v_1^2
    $
    变为：
    $
      1/2 (2 m) (1/2 v_1)^2 = 1/4 m v_1^2
    $
    再考虑势能，考虑之前轨迹为抛物线，因此：
    $
      V_1 = - 1/2 m v_1^2 = V_2 = - (G M m)/r 
    $
    碰后势能不变。总之，碰撞后的总机械能为：
    $
      E_2 = 1/4 m v_1^2 + V_1 + V_2 = - 3/4 m v_1^2 = - 3/2 (G M m)/r
    $
    由于碰撞位置为近日点，因此：
    $
      r = p / 2\
      c_1^2 = G M p = 2 G M r\
    $
    碰撞前后角动量不变，因此 $c_2 = 1/2 c_1$，代入离心率公式：
    $
      e &= sqrt(1 + (2 E c^2)/((2 m) (G M)^2))\
        &= sqrt(1 - 3/2 1/r (c_2^2)/(G M))\
        &= sqrt(1 - 1/r 3/8 (c_1^2)/(G M))\
        &= sqrt(1 - 3/4)\
        &= 1/2\
    $
  == 9
    在任何位置 $bX$，根据能量守恒都有：
    $
      1/2 m v^2 - K/norm(bX - bC) = E where K = G m M\
      v = sqrt(2/m (E + K/norm(bX - bC)))\
    $
    因此：
    $
      v_1 v_2 = 2 / m sqrt((E + K/norm(bX - bC)) (E + K/norm(bX + bC)))\
      = 2 / m sqrt(E^2 + (E K (norm(bX + bC) + norm(bX - bC)) + K^2)/(norm(bX - bC) norm(bX + bC)))\
      = 2 / m sqrt(E^2 + (2 a E K + K^2)/(norm(bX - bC) norm(bX + bC)))\
    $
    注意到：
    $
      a = - (G M m)/(2 E)
    $
    因此：
    $
      2 a E K + K^2 = 0
    $
    故 $v_1 v_2 = 2/m norm(E)$ 与 $bX$ 无关，根据对称性它一定就是 $v_b^2$
  == 12
    设发射速度为 $bv_1$，则其摆脱地球引力场后，速度满足：
    $
      1/2 m norm2(bv_2) = 1/2 m norm2(bv_1) - (G M_"地" m) / R_"地"\
      norm2(bv_2) = norm2(bv_1) - 2 (G M_"地") / R_"地"\
    $
    再设其相对太阳的速度为 $bv'_2$，有：
    $
      bv'_2 = bv_2 + bv_"地"\
    $
    （#TODO 正确答案为椭圆轨道，与金星轨道相切即可）
    根据条件，它应该在半径为 $0.7 R$ 的绕太阳圆周轨道上运动，因此能量满足：
    $
      E = 1/2 m norm2(bv'_3) - (G M_"太阳" m)/(0.7 R) = 1/2 m norm2(bv'_2) - (G M_"太阳" m)/(R)\
    $
    其中 $bv'_3$ 为在该轨道上的速度，有：
    $
      (G M_"太阳" m) / (0.7 R)^2 = m norm2(bv'_3) / (0.7 R) \ 
      norm2(bv'_3) = (G M_"太阳") / (0.7 R)\
    $
    代入就有：
    $
      1/2 m norm2(bv'_2) - (G M_"太阳" m)/(R) = -1/2 m (G M_"太阳")/(0.7 R)\
      norm2(bv'_2) = (2 - 1/0.7) (G M_"太阳") / R\
      norm2(bv_2 + bv_"地") = (2 - 1/0.7) (G M_"太阳") / R <= norm2(bv_2) + norm2(bv_"地") = norm2(bv_1) - 2 (G M_"地") / R_"地"
    $
    总之：
    $
      norm2(bv_1) >= (2 - 1/0.7) (G M_"太阳") / R + 2 (G M_"地") / R_"地"
    $
    代入数据即可知道最小速度
  == 14

    设 $r = norm(O M)$，系统动能为：
    $
      T = 1/2 (m + M) vt2(r) + 1/2 m r^2 vt2(theta_m) + 1/2 M (l - r)^2 vt2(theta_M)
    $
    根据拉氏方程，就有：
    $
      m r^2 vt(theta_m) = C_1\
      m M (l - r)^2 vt(theta_M) = C_2\
      (m + M) at(r) = m r vt2(theta_m) - M (l - r) vt2(theta_M) 
    $
    注意到：
    $
      vt(r) = der(r, theta_m) vt(theta_m) = der(r, theta_m) C_1/(m r^2)\
      at(r) = vt(der(r, theta_m)) C_1/(m r^2) - 2 der(r, theta_m) C_1/(m r^3) vt(r)\ 
      = vt(der(r, theta_m)) C_1/(m r^2) - 2 der(r, theta_m) C_1/(m r^3) der(r, theta_m) C_1/(m r^2)\
      = derN(r, theta_m, 2) C_1^2/(m^2 r^4) - 2 (der(r, theta_m))^2 C_1^2/(m^2 r^5)
    $
    // 记 $btheta = vec(theta_m, theta_M)$ 注意到：
    // $
    //   vt(r) = der(r, btheta) vt(btheta) = der(r, btheta) vec(C_1 / (m r^2), C_2 / (M (l - r)^2))\
    //   derN(r, t, 2) = (C_1 / (m r^2), C_2 / (M (l - r)^2)) (vt(der(r, btheta)))^T  + der(r, btheta) vec(-2 C_1/(m r^3), 2 C_2/(m (l - r)^3)) vt(r)\
    //   = quadFormSym(vec(C_1 / (m r^2), C_2 / (M (l - r)^2)), derN(r, btheta, 2)) + der(r, btheta) vec(-2 C_1/(m r^3), 2 C_2/(m (l - r)^3)) der(r, btheta) vec(C_1 / (m r^2), C_2 / (M (l - r)^2))\
    //   = quadFormSym(vec(C_1 / (m r^2), C_2 / (M (l - r)^2)), derN(r, btheta, 2)) + der(r, btheta) vec(-2 C_1/(m r^3), 2 C_2/(m (l - r)^3)) (C_1 / (m r^2), C_2 / (M (l - r)^2)) (der(r, btheta))^T\
    // $
    代回之前的方程就是：
    $
      (m + M) C_1^2/(m^2 r^5) (r derN(r, theta_m, 2) - 2 (der(r, theta_m))^2 ) = C_1^2/(m r^3) - C_2^2/(M^2 (l - r)^3)\
    $
  == 16
    逃逸速度满足：
    $
      v_e = sqrt(2 (G M) / R)\
    $
    无论射弹的轨道如何，其距月球质心最近距离：
    $
      r_"min" = p / (1 + e) = c^2 / (G M) / (1 + sqrt(1 + 2 (E c^2) / (G^2 M^2 m )))
    $
    设射弹初始位置距离直射线为 $d$，直射线距月球质心距离为 $r_0$，则有：
    $
      c = r^2 vt(theta) = l / m = d v_0\
      E = 1/2 m v_0^2 - (G M m) / sqrt(r_0^2 + d^2) approx 1/2 m v_0^2 \
    $
    要使其击中月球，一定要有：
    $
      c^2 / (G M) / (1 + sqrt(1 + 2 (E c^2) / (G^2 M^2 m ))) <= R\
      (d^2 v_0^2)/(G M)/R <= 1 + sqrt(1 + 2 (E c^2) / (G^2 M^2 m )) \
      2 (d^2 v_0^2)/(R^2 v_e^2) <= 1 + sqrt(1 + 8/R^2 ((1/2 v_0^2) d^2 v_0^2) / (v_e^4)) \
      2 d^2 v_0^2 <= R^2 v_e^2 + sqrt(R^4 v_e^4 + 4 R^2 d^2 v_0^4 ) \
      4 d^4 v_0^4 - 4 d^2 R^2 v_e^2 v_0^2 + R^4 v_e^4 <= R^4 v_e^4 + 4 R^2 d^2 v_0^4 \
      d^4 v_0^2 - R^2 v_e^2 - R^2 d^2 <= 0\
      d^2 <= (R^2 + sqrt(R^4 + 4 R^2 v_e^2))/(2 v_0^2)\
    $
    这就给出了碰撞截面的半径 $d$
  == 18
    对于圆轨道有：
    $
      0 = e = sqrt(1 + (2 m E c^2)/(k^2))\
      E = - 1/2 (k^2 m^2)/ G_0^2\
      G_0 = sqrt(-1/2 (k^2 m^2) / E)
    $
    其中：
    $
      k = 1/(4 pi epsilon_0) q^2\
    $
    这就给出了角动量。对于氮核，有：
    $
      k' = 7 k\
      -1/2 (k^2 m^2) / E = G_0^2 = -1/2 (k'^2 m^2) / E'\
      E' = 49 E\
    $
    轨道半径满足：
    $
      r = (m c^2) / (7 k) = G_0^2 / (7 m k)
    $
  == 19
    根据带电粒子的计算过程可以知道，两电子的轨迹分别为：
    $
      r = p/(1 + e cos theta)\
      r = - p/(1 + e cos theta)
    $
    由于出射角就是 $r -> infinity$ 时的角度，因此它们的出射角都满足 $e cos theta = - 1$，是一致的。
  == 20
    力形如：
    $
      F(r) = k (a/r e^(-a/r) - e^(- a / r))/r^2\
      = k (a/r^3 e^(-a/r) - 1/r^2 e^(- a / r))\
      F'(r) = k (a^2  r e^(-a/r) - 3 r^2 a e^(-a/r))/r^6 - k (a e^(-a / r)- 2 r e^(-a / r))/r^4
    $
    稳定性条件为：
    $
      F(r_0) + r_0/3 F'(r_0) < 0\
    $
    代入就是：
    $
      (a / r_0 - 1)/r_0^2 + r_0/3 ( (a^2 r_0 - 3 r_0^2 a)/r_0^6 - (a - 2 r_0)/r_0^4 ) < 0\
      a - r_0 + 1/3 ((a^2 - 3 r_0 a)/r_0 - a + 2 r_0) <= 0\
      3 a r_0 - 3 r_0^2 + a^2 - 3 r_0 a - a r_0 + 2 r_0^2 <= 0\
      r_0^2 + a r_0 - a^2 >= 0\
    $
    这就是稳定条件
  == 21
    有：
    $
      F(r) = - n k r^(- n - 1)
    $
    按照书上条件，就是：
    $
      - n - 1 > - 3\
      n < 2
    $
= 戈  P144
  == 1
    设旋转抛物面方程为：
    $
      z = a (x^2 + y^2) = a r^2
    $
    取质点坐标为 $(r cos theta, r sin theta, z = a r^2)$，则：
    - 动能为：
      $
        T = 1/2 m (vt2(r) + r^2 vt2(theta) + 4 a^2 r^2 vt2(r))\
        = 1/2 m ((1 + 4 a^2 r^2) vt2(r) + r^2 vt2(theta))\
      $
    - 势能为：
      $
        V = m g z = m g a r^2
      $
    - 拉氏方程为：
      $
        dif/(dif t) (m r^2 vt(theta)) = 0\
        dif/(dif t) (m (1 + 4 a^2 r^2) vt(r)) - 4 m a^2 r vt2(r) - m r vt2(theta) + 2 m g a r = 0\
        4 a^2 r vt2(r) + (1 + 4 a^2 r^2) at(r)  - r vt2(theta) + 2 g a r = 0 
      $
      这两个拉氏方程就给出了等效的一维问题。假设轨道是圆，则 $vt(r) = 0$，代入有：
      $
        m r^2 vt(theta) = C\
        2 g a r = r vt2(theta)\
        vt(theta) = sqrt(2 g a)\
        r = sqrt(C/(m vt(theta))) = sqrt(C/(m sqrt(2 g a)))
      $
      质点初速度大小为：
      $
        v_0 = r vt(theta) = sqrt((C sqrt(2 g a)) / m)
      $
      假设做微扰 $Delta r$，就有：
      $
        0 = 4 a^2 (r + Delta r) vt2(Delta r) + (1 + 4 a^2 (r + Delta r)^2) at(Delta r) - C'^2/(m^2 (r + Delta r)^3) + 2 g a (r + Delta r) \
        approx (1 + 4 a^2 r^2) at(Delta r) - C'^2/m^2 (1/r^3 - 3 Delta r 1 / r^4) + 2 g a r + 2 g a Delta r\
        = (1 + 4 a^2 r^2) at(Delta r) + ((3 C'^2)/(m^2 r^4) + 2 g) Delta r + ... 
      $
      其周期为：
      $
        omega^2 = ((3 C'^2)/(m^2 r^4) + 2 g)/(1 + 4 a^2 r^2)\
      $
  == 25
    类似之前 19 题，轨道相当于原来轨道的 $r$ 取相反值。
  == 27
    假设入射角（也即粒子在 $r = a$ 的点上，入射速度方向与球心径向的夹角）为 $theta$，入射时动能为 $E = T = 1/2 m v_0^2$，则根据机械能守恒，穿过截面后，有：
    $
      T' - V_0 = E\
      1/2 m v_1^2 = 1/2 m v_0^2 + V_0\
      v_1 = sqrt(v_0^2 + 2 V_0 / m)
    $
    另外，速度的变化应该是沿径向的。因此切向速度保持 $v_0 sin theta$ 不变，进而出射角 $theta'$ 满足：
    $
      sin theta' = (v_0 sin theta) / v_1\
      (sin theta) / (sin theta') = v_1 / v_0
    $
    上式即为等效折射率，它等于：
    $
      sqrt(1 + V_0 / (1/2 m v_0^2)) = sqrt((E + V_0) / E)
    $
    设出射时折射角为 $theta ''$，则根据几何关系有：
    $
      sin theta '' = sin theta
    $
    以及出射角为：
    $
      Theta = theta'' + theta - 2 theta' = 2 theta - 2 theta'\
    $
    此外，$theta$ 与 $s$ 的关系为：
    $
      sin theta = s / a
    $
    因此：
    $
      theta = arcsin(s / a)\
      theta' = arcsin((sin theta) / n) = arcsin(s / (a n))
    $
    故：
    $
      Theta = 2 arcsin(s / a) - 2 arcsin(s / (a n))\
      der(Theta, s) = 2 / sqrt(a^2 - s^2) - 2 / (n sqrt(a^2 - s^2 / n^2))\
      sigma(Theta) = a / (der(Theta, s)) = 1/a 1/(2 / sqrt(a^2 - s^2) - 2 / (n sqrt(a^2 - s^2 / n^2)))
    $
    总截面为：
    $
      integral_(0)^(2 pi) 2 pi sin Theta sigma(Theta) dif Theta 
    $