#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业2",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 胡 P343
  == 1
    $
      der(V, r) = epsilon r_0 (12 (r_0/r)^5 - 12 (r_0/r)^11)\
      = 12 epsilon r_0 (r_0 / r)^5 (1 - (r_0/r)^6)\
      derN(V, r, 2) = epsilon r_0^2 (-60 (r_0/r)^4 + 132 (r_0/r)^10)\
    $
    因此 $r = r_0$ 时极小，极小值为 $-epsilon$，深度为 $epsilon$

    在题设情况下，取 $x$ 和 $r$ 为广义坐标（另一物体位置为 $x + r$） 
    - 系统动能为：
      $
        1/2 m norm2(vt(bX)) = 1/2 m norm2(mat(1, 1;1, 0) dif/(dif t) vec(x, r))\
        = 1/2 m quadFormSym(vec(vt(x), vt(r)), mat(1, 1;1, 0)^2 )\
        = 1/2 m quadFormSym(vec(vt(x), vt(r)), mat(2, 1;1, 0))\
      $
    - 
      之前结论得知：
      $
        derN(V, r, 2)(r_0) = 72 epsilon r_0^2
      $
      因此势能约为：
      $
        36 epsilon (r - r_0)^2/r_0^2 = quadFormSym(vec(x, r - r_0), mat(0, 0;0, 36 epsilon/r_0^2))
      $
    - 代入拉氏方程得：
      $
        dif/(dif t) partialDer(T, (vt(x), vt(r))) + partialDer(V, (x, r)) = 0\
        m mat(2, 1;1, 0) dif^2/(dif t^2) vec(x, r) + mat(0, 0;0, 72 epsilon / e_0^2) vec(x, r - r_0) = 0\
        m mat(2, 1;1, 0) dif^2/(dif t^2) vec(x, r - r_0) + mat(0, 0;0, 72 epsilon / e_0^2) vec(x, r - r_0) = 0\
      $
      广义特征值满足：
      $
        det(lambda^2 mat(2 m, m;m, 0) - mat(0, 0;0, 72 epsilon / e_0^2)) = 0\
        Det(2 m lambda^2, m lambda^2;m lambda^2, -72 epsilon / e_0^2) = 0\
        Det(2, 1;m lambda^2, -72 epsilon / e_0^2) = 0\
        m lambda^2 = -144 epsilon / e_0^2\
        lambda = plus.minus 12 i sqrt(epsilon / (m r_0^2))
      $
      因此系统频率为 $12 sqrt(epsilon / (m r_0^2))$
  == 2
    设质点位置为 $vec(x, 0)$，$O$ 点坐标为 $vec(0, l)$，有：
    - 动能为：
      $
        T = 1/2 m (vt(x))^2
      $
    - 势能为：
      $
        V = 1/2 k (sqrt(l^2 + x^2) - l_0)^2\
        = 1/2 k (l^2 + x^2 - 2 l_0 sqrt(l^2 + x^2) + l_0^2)
      $
      有：
      $
        der(V, x) = 1/2k (2 x + 2 l_0 x/sqrt(l^2 + x^2))\
        derN(V, x, 2) = 1/2 k (2 + 2l_0 (sqrt(l^2 + x^2) - x x/sqrt(l^2 + x^2) )/(l^2 + x^2))
      $
      可能的平衡位置包括 $x = 0$ 以及 $sqrt(l^2 + x^2) = l_0$\
    - 对于 $x = 0$ 的平衡位置，有：
      $
        derN(V, x, 2)(0) = 1/2 k (2 + 2 l_0/l)
      $
      拉氏方程为：
      $
        m at(x) + k (2 + 2 l_0/l) x = 0
      $
      频率为：
      $
        sqrt(k (2 + 2 l_0/l)/m)
      $
    - 对于 $sqrt(l^2 + x^2) = l_0$ 的平衡位置（此时必有 $l < l_0$），有：
      $
        derN(V, x, 2) = 1/2 k (2 + 2 l_0 (l_0 - x^2/l_0)/l_0^2)\
        = 1/2 k (2 + 2 (l_0^2 - x^2)/l_0^2)\
        = 1/2 k (2 + 2 l^2/l_0^2)\
      $
      类似的，拉氏方程为：
      $
        m at(x) + k (2 + 2 l^2/l_0^2) x = 0
      $
      频率为：
      $
        sqrt(k (2 + 2 l^2/l_0^2)/m)
      $
  == 3
    分别设两质点位置为 $x_1, x_2, Xv = vec(x_1, x_2)$，则：
    - 体系动能为：
      $
        T = 1/2 m norm2(vt(Xv))
      $
    - 体系势能为：
      $
        V = 1/2 k ((x_1 - l_0)^2 + (x_2 - x_1 - l_0)^2 + (2 l_0 - x_2)^2)\
        = 1/2 k ((x_1 - l_0)^2 + ((x_2 - 2 l_0) - (x_1 - l_0))^2 + (x_2 - 2 l_0)^2)\
        = 1/2 k quadFormSym(vec(x_1 - l_0, x_2 - 2 l_0), mat(2, -1;-1, 2))
      $
    - 拉氏方程为：
      $
        LagrangeEquationTV(T, V, Xv)\
        m at(Xv) + k mat(2, -1;-1, 2) vec(x_1 - l_0, x_2 - 2 l_0) = 0\
        m at(Xv - vec(l_0, 2 l_0)) + k mat(2, -1;-1, 2) (Xv - vec(l_0, 2 l_0)) = 0\
      $
      广义特征值满足：
      $
        det(lambda^2 m I + k mat(2, -1;-1, 2)) = 0\
        Det(2 k + lambda^2 m, -k;-k, 2 k + lambda^2 m) = 0\
        (2 k + lambda^2 m)^2 - k^2 = 0\
        2 k + lambda^2 m = plus.minus k\
        m lambda^2 = -k, -3 k\
        lambda = plus.minus i sqrt(k/m), plus.minus i sqrt(3 k/m)
      $
      表明体系有两个频率，分别为 $sqrt(k/m)$ 和 $sqrt(3 k/m)$
    若质点带电，此时势能为：
    $
      V = 1/2 k ((x_1 - l_0)^2 + ((x_2 - 2 l_0) - (x_1 - l_0))^2 + (x_2 - 2 l_0)^2) + C/(x_2 - x_1)\
      autoTrans(der(V, Xv)) = k mat(2, -1;-1, 2) vec(x_1 - l_0, x_2 - 2 l_0) + C/(x_2 - x_1)^2 vec(1, -1)\
      derN(V, Xv, 2) = k mat(2, -1;-1, 2) + (2 C)/(x_2 - x_1)^3 mulT(vec(-1, 1))  \    
    $
    其中 $C = q^2/(4 pi epsilon_0)$. 解 $autoTrans(der(V, Xv)) = 0$ 得：
    $
      0 = k mat(2, -1;-1, 2) vec(x_1 - l_0, x_2 - 2 l_0) + C/(x_2 - x_1)^2 vec(1, -1)\
      0 = k (1, -1) mat(2, -1;-1, 2) vec(x_1 - l_0, x_2 - 2 l_0) + 2 C/(x_2 - x_1)^2\
      = 3 k (1, -1) vec(x_1 - l_0, x_2 - 2 l_0) + 2 C/(x_2 - x_1)^2\
      = 3 k (l_0 - (x_2 - x_1)) + 2 C/(x_2 - x_1)^2\
      = 3 k (l_0 - r_0) + 2 C/r_0^2\
      r_0^3 - l_0 r_0^2 + 2 C/(3 k) = 0
      
      
    $
    代入小振动的拉氏方程有：
    $
      m at(Xv) + ( k mat(2, -1;-1, 2) + (2 C)/r_0^3 mat(1, -1;-1, 1)) Xv = 0
    $
    其中 $r_0$ 为平衡点处的 $x_2 - x_1$，广义特征值满足：
    $
      det(lambda^2 m I +  k mat(2, -1;-1, 2) + (2 C)/r_0^3 mat(1, -1;-1, 1))\
      Det(lambda^2 m + 2 k + 2 C/r_0^3, -k - 2 C/r_0^3;
        -k - 2 C/r_0^3, lambda^2 m + 2 k + 2 C/r_0^3 
      ) = 0\
      lambda^2 m + 2 k + 2 C/r_0^3 = k + 2 C/r_0^3\
      lambda = plus.minus sqrt(k/m) i\
      "或者"
      lambda^2 m + 2 k + 2 C/r_0^3 = - (k + 2 C/r_0^3)\
      lambda^2 m = - (3k + 4 C/r_0^3)\
      lambda = plus.minus i sqrt((3 k + 4 C/r_0^3)/m)
    $
    这就给出了 $r_0$ 处平衡点的两个频率。
  == 4
    定义 $be(theta) = vec(cos theta, sin theta)$，则：
    $
      vt(be(theta)) = vec(-sin theta, cos theta) vt(theta)\
      = be(theta)^orthogonal vt(theta)\
      vtnorm2(be(theta)) = (vt(theta))^2 
    $
    取 $theta, phi$ 使得 $A, B$ 坐标分别为：
    $
      A = l be(theta)\
      B = l (be(theta) + be(phi))
    $
    则：
    - 动能为：
      $
        T = 1/2 I (vt(theta))^2 + 1/2 m (vt(A))^2 + 1/2 I (vt(phi))^2
      $
      其中 $I$ 是均匀杆绕一端转动的转动惯量，$I = 1/3 m l^2$，因此：
      $
        T = 1/2 m l^2 (1/3 vt2(theta) + 1/3 vt2(phi) + vtnorm2(be(theta)))) \
        = 1/2 m l^2 (4/3 vt2(theta) + 1/3 vt2(phi))
      $
    - 势能为：
      （注意 $x$ 方向是竖直方向）
      $
        V = - m g (1, 0) (1/2 A) - m g (1, 0) (1/2 (B + A))\
        = - 1/2 m g (1, 0) (A + B + A)\
        = - 1/2 m g l (1, 0) (2 be(theta) + be(theta) + be(phi))\
        = - 1/2 m g l (1, 0)  (3 be(theta) + be(phi))\
        der(V, (theta, phi)) = - 1/2 m g l (1, 0) (3 be^orthogonal (theta), be^orthogonal (phi))\
        derN(V, (theta, phi), 2) = 1/2 m g l (1, 0) diag(3 be (theta), be(phi))
      $
    对于小振动，代入拉氏方程：
    $
      LagrangeEquationTV(T, V, (theta, phi))
    $
    有：
    $
      m l^2 diag(4/3, 1/3) at(vec(theta, phi)) + m g l diag(3 cos theta_0, cos phi_0) vec(theta, phi) = 0
    $
    其中 $theta_0, phi_0$ 是平衡位置。广义特征值满足：
    $
      det(lambda^2 m l^2 diag(4/3, 1/3) + m g l diag(3 cos theta_0, cos phi_0)) = 0\
    $
    显然两个频率分别是：
    $
      sqrt((9 g cos theta_0)/(8 l)), sqrt((3 g cos phi_0)/(l))
    $
    平衡位置满足：
    $
      (1, 0) (3 be^orthogonal (theta_0), be^orthogonal (phi_0)) = 0\
      (- 3 sin theta_0, - sin phi_0) = 0\
    $
    显然只有 $theta_0 = 0, phi_0 = 0$ 满足该条件，因此频率为：
    $
      sqrt((9 g)/(8 l)), sqrt((3 g)/(l))
    $
  == 5
    设细杆两端为 $A, B$，取 $theta$ 使得：
    $
      A = R be(theta)
    $
    此时有：
    $
      B = R beo(theta)
    $
    - 势能为（$y$ 方向为竖直向下方向）：
      $
        V = - m g (0, 1) (1/2 (A + B))\
        = - 1/2 m g R (0, 1) (be(theta) + beo(theta))\
        = - 1/2 m g R (sin theta + cos theta)\
        der(V, theta) = - 1/2 m g R (cos theta - sin theta)\
        derN(V, theta, 2) = 1/2 m g R (cos theta + sin theta)
      $
      显然平衡位置为 $theta = pi/4$，此时 $derN(V, theta, 2) = 1/2 sqrt(2) m g R$
    - 动能为：
      $
        T = 1/2 integral_(0)^(1)  vtnorm2(lambda A + (1 - lambda) B) m/l norm(dif (lambda A + (1 - lambda) B))\
        = 1/2 integral_(0)^(1)  vtnorm2(lambda A + (1 - lambda) B) m/l norm(A - B) dif lambda\
        = 1/2 m integral_(0)^(1)  vtnorm2(lambda A + (1 - lambda) B) dif lambda\
        = 1/2 m integral_(0)^(1)  norm2(lambda vt(A) + (1 - lambda) vt(B)) dif lambda\
        = 1/2 m integral_(0)^(1)  norm2(lambda R beo(theta) vt(theta) - (1 - lambda) R be(theta) vt(theta)) dif lambda\
        = 1/2 m R^2  vt2(theta) integral_(0)^(1)  norm2(lambda beo(theta) - (1 - lambda) be(theta)) dif lambda\
        = 1/2 m R^2  vt2(theta) integral_(0)^(1)  lambda^2 + (1 - lambda)^2 dif lambda\
        = 1/2 m R^2  vt2(theta) 2 integral_(0)^(1)  lambda^2 dif lambda\
        = 1/2 dot 2/3 m R^2  vt2(theta) \
      $
    平衡位置附近有拉氏方程：
    $
      2/3 m R^2 at(theta) + sqrt(2) m g R theta = 0\
    $
    振动频率为：
    $
      sqrt((3 sqrt(2) g) / (2 R))
    $
  == 6
    设棒重心位置坐标为 $bO = vec(0, y)$ 两端坐标分别为:
    $
      bA = bO + 1/2 l be(theta)\
      bB = bO - 1/2 l be(theta)
    $
    - 细棒动能为：
      $
        T = 1/2 I (vt(theta))^2 + 1/2 m vt2(y)\
        = 1/2 ((1/12 m l^2) vt2(theta) + m vt2(y))\
        = 1/2 quadFormSym(vec(vt(theta), vt(y)), diag(1/12 m l^2, m))
      $
    - 势能为：
      $
        V = - m g y + 1/2 k ((y + 1/2 l sin theta - l_0)^2 + (y - 1/2 l sin theta - l_0)^2)\
        = - m g y + 1/2 k (2 (y - l_0)^2 + 2 (1/2 l)^2 sin^2 theta)\
        der(V, (y, theta)) = - m g vec(1, 0) + 2 k vec(y - l_0, (1/2 l)^2 sin theta cos theta)\
        derN(V, (y, theta), 2) = 2 k diag(1, (1/2 l)^2 (cos^2 theta - sin^2 theta))\
      $
      平衡位置满足：
      $
        - m g vec(1, 0) + 2 k vec(y - l_0, sin theta cos theta) = 0\
        y - l_0 = m g/(2 k), sin theta cos theta = 0\
      $
      显然应该抛弃 $theta = pi/2$ 的情况，因此平衡位置只有 $theta = 0$，此时：
      $
        derN(V, (y, theta), 2) = 2 k diag(1, 1/4 l^2)
      $
    平衡位置附近就有：
    $
      diag(1/12 m l^2, m) vec(at(theta), at(y)) + 2 k diag(1/4 l^2, 1) vec(theta, y) = 0
    $
    因此两个频率分别为：
    $
      sqrt((6 k)/m), sqrt((2 k)/m)
    $
  == 7
    设系统势能形式为 $V(norm(Xv_3 - Xv_2), norm(Xv_2 - Xv_1))$，记：
    $
      Xv = vec(Xv_1, Xv_2, Xv_3)\
      rv = vec((Xv_3 - Xv_2), (Xv_2 - Xv_1)) = mat(0, -1, 1;-1, 1, 0) Xv\
      Xv = mat(0, 1; (0, 1), 1; (1, 1), 1) vec(rv_1, Xv_1)\
      = mat(0, 0;0, 1;1, 1) rv + vec(Xv_1, Xv_1, Xv_1) \
    $
    则：
    - 动能为：
      $
        T = 1/2 quadFormSym(vt(Xv), M) where M = diag(m_1, m_2, m_3)\
        partialDer(T, vt(rv)) = (vt(Xv))^T M partialDer(vt(Xv), vt(rv))\
        = (vt(Xv))^T M partialDer(Xv, rv)\

        partialDerN(T, vt(rv), 2) = (partialDer(Xv, rv))^T M partialDer(vt(Xv), vt(rv)) + (partial/(partial vt(rv)) partialDer(Xv, rv))^T M vt(Xv)\
        = quadFormSym(partialDer(Xv, rv), M)
      $
    - 势能为：
      $
        V((Xv_3 - Xv_2), (Xv_2 - Xv_1))\
        partialDer(V, Xv) = partialDer(V, rv) partialDer(rv, Xv)\
        partialDerN(V, Xv, 2) = quadFormSym(partialDer(rv, Xv), partialDerN(V, rv, 2)) + (partialDerN(Xv, rv, 2))^T (partialDer(V, rv))^T\
        = quadFormSym(partialDer(rv, Xv), partialDerN(V, rv, 2)) 
      $（注意到 $Xv$ 和 $rv$ 是线性关系）
    使用绝对坐标列出方程为：
    $
      2 partialDerN(T, vt(Xv), 2) at(Xv) + 2 partialDerN(V, Xv, 2) Xv = 0\
      M at(Xv) + 2  quadFormSym(partialDer(rv, Xv), partialDerN(V, rv, 2)) Xv = 0
    $
    广义特征值问题为：
    $
      det(lambda^2 M + quadFormSym(partialDer(rv, Xv), partialDerN(V, rv, 2))) = 0
    $
    由于第二项不满秩，故 $lambda = 0$ 是一个解。此外，因为可以验证 $partialDer(r, Xv) partialDer(Xv, rv) = I$：
    $
      det(lambda^2 (partialDer(Xv, rv))^T M partialDer(Xv, rv) + (partialDer(Xv, rv))^T quadFormSym(partialDer(rv, Xv), partialDerN(V, rv, 2)) partialDer(Xv, rv))  = 0\
      det(lambda^2 (partialDer(Xv, rv))^T M partialDer(Xv, rv) + partialDerN(V, rv, 2)) = 0\
    $
    该方程给出剩余的非零频率。同时，使用相对坐标列出方程为：
    $
      2 partialDerN(T, vt(rv), 2) at(rv) + 2 partialDerN(V, rv, 2) rv = 0\
      2 quadFormSym(partialDer(Xv, rv), M) at(rv) + 2 partialDerN(V, rv, 2) rv = 0
    $
    它的广义特征值方程与上面一致，因此两个问题得到的频率是相同的。
  == 8
    设阻力为：
    $
      F = - K vt(Xv)
    $
    （带有广义力的）拉氏方程为：
    $
      A at(Xv) + V Xv = - K vt(Xv) \
      A at(Xv) + K vt(Xv) + V Xv = 0
    $
    若设 $bY = vec(Xv, vt(Xv))$，立刻有：
    $
      vt(bY) = mat(0, 1; - Inv(A) V, -Inv(A) K) bY
    $
    一个基础解矩阵为：
    $
      exp{mat(0, 1; - Inv(A) V, -Inv(A) K)}
    $
    计算频率只需求上矩阵的特征值，不妨设 $lambda !=0 $，则：
    $
      Det(lambda I, 1;-Inv(A) V, lambda I - Inv(A) K) = 0\
      Det(lambda I, 1;0, lambda I - Inv(A) K + 1/lambda Inv(A) V) = 0\
      det(lambda I - Inv(A) K + 1/lambda Inv(A) V) = 0\
      det(lambda^2 A - lambda K + V) = 0\
    $
    这些特征值的虚部即是新的频率，而实部代表了系统的衰减。
= 戈 p321
  == 1
    设质点位置为 $Xv = vec(x, a x^4)$，则：
    - 动能为：
      $
        T = 1/2 m (1 + (4 a x^3)^2) vt2(x)
      $
    - 势能为：
      $
        V = m g a x^4
      $
    拉氏方程为：
    $
      dif/(dif t) (m (1 + 16 a^2 x^6) vt(x)) + 4 m g a x^3 = 0\
      m (1 + 16 a^2 x^6) at(x) + 96 m a^2 x^5 vt2(x) + 4 m g a x^3 = 0\
      (1 + 16 a^2 x^6) at(x) + 96 a^2 x^5 vt2(x) + 4 g a x^3 = 0\
    $
    能量积分为：
    $
      T + V = 1/2 m (1 + (4 a x^3)^2) vt2(x) + m g a x^4 = E\
      abs(vt(x)) = sqrt(2/m (E - m g a x^4)/(1 + 16 a^2 x^6))\
    $
    忽略小量并只考虑一半部分，有：
    $
      vt(x) = sqrt(2/m (E - m g a x^4))\
      1/sqrt(2/m (E - m g a x^4)) dif x = dif t\
    $
    令 $F(x') = integral_(0)^(x') 1/sqrt(2/m (E - m g a x^4)) dif x$，则运动方程为：
    $
      x = Inv(F) (t), y = a x^4
    $
  == 2
    取 $theta, phi$ 使得：
    $
      A = l be(theta)\
      B = l (be(theta) + be(phi))
    $
    - 势能为（$x$ 方向为竖直向下方向）：
      $
        V = - (1, 0) (m_A g l be(theta) + m_B g l (be(theta) + be(phi)))\
        = - g l (m_A + m_B) cos theta - m_B g l cos phi\
        partialDerN(V, (theta, phi), 2) = g l diag((m_A + m_B) cos theta, m_B cos phi)
      $
    - 动能为：
      $
        T = 1/2 m_A l^2 vtnorm2(be(theta)) + 1/2 m_B l^2 vtnorm2(be(theta) + be(phi))\
        = 1/2 m_A l^2 vt2(theta) + 1/2 m_B l^2 (vt2(theta) + 2 beo(theta)^T beo(phi) vt(theta) vt(phi) + vt2(phi))\
      $
      平衡位置处，$beo(theta)^T beo(phi) = (0, 1) vec(0, 1) = 1$，有：
      $
        partialDerN(V, (theta, phi), 2) = g l diag((m_A + m_B), m_B)\
        T = 1/2 quadFormSym(vec(vt(theta), vt(phi)), mat(m_A + m_B, m_B;m_B, m_B))
      $
      因此振动方程为：
      $
        mat(m_A + m_B, m_B;m_B, m_B) l^2 at(vec(theta, phi)) + 2 g l diag((m_A + m_B), m_B) vec(theta, phi) = 0
      $
      广义特征值问题为：
      $
        det(lambda^2 l mat(m_A + m_B, m_B;m_B, m_B) + 2 g diag((m_A + m_B), m_B)) = 0\
        Det((lambda^2 l + 2 g) (m_A + m_B), lambda^2 l m_B; lambda^2 l m_B, (lambda^2 l + 2 g) m_B) = 0\
        Det((lambda^2 l + 2 g) (m_A + m_B), lambda^2 l; lambda^2 l m_B, (lambda^2 l + 2 g)) = 0\
        (lambda^2 l + 2 g)^2 (m_A + m_B) = lambda^4 l^2 m_B\
        lambda^2 sqrt(m_B l^2) = (lambda^2 l + 2 g) sqrt(m_A + m_B)\
        lambda^2 = - (2 g sqrt(m_A + m_B))/(l (sqrt(m_A + m_B) -sqrt(m_B)))\
        lambda = plus.minus i sqrt((2 g (sqrt(m_A + m_B)))/(l (sqrt(m_A + m_B) - sqrt(m_B))))\
        "或者"\
        lambda^2 sqrt(m_B l^2) = - (lambda^2 l + 2 g) sqrt(m_A + m_B)\
        lambda^2 = - (2 g sqrt(m_A + m_B))/(l (sqrt(m_A + m_B) + sqrt(m_B)))\
        lambda = plus.minus i sqrt((2 g (sqrt(m_A + m_B)))/(l (sqrt(m_A + m_B) + sqrt(m_B))))
      $
      注意到：
      $
        sqrt(m_A + m_B)/(sqrt(m_A + m_B) - sqrt(m_B)) = (sqrt(m_A + m_B) (sqrt(m_A + m_B) + sqrt(m_B)))/(m_A)\
        = (m_A + m_B + sqrt(m_B (m_A + m_B)))/(m_A)\
        sqrt(m_A + m_B)/(sqrt(m_A + m_B) + sqrt(m_B)) = (m_A + m_B - sqrt(m_B (m_A + m_B)))/(m_A)\
      $
      当然 $m_B$ 远小于 $m_A$ 时，上面两式都近似为 $1$。

      对于后面的结论，注意到设：
      $
        bY = vec(theta, phi, vt(theta), vt(phi))
      $
      则微分方程等价于：
      $
        vt(bY) = mat(0, I; - Inv(A) V, 0) bY
      $
      方程通解为：
      $
        bY = P diag(e^(i omega_1 t), e^(- i omega_1 t), e^(i omega_2 t), e^(- i omega_2 t)) bC
      $
      也即：
      $
        vec(theta, phi) = (I, 0) P diag(e^(i omega_1 t), e^(- i omega_1 t), e^(i omega_2 t), e^(- i omega_2 t)) bC \
        vt(vec(theta, phi)) = (0, I) P diag(e^(i omega_1 t), e^(- i omega_1 t), e^(i omega_2 t), e^(- i omega_2 t)) bC \
      $
      其中 $P$ 是特征向量矩阵。计算广义特征向量：
      $
        mat((lambda^2 l + 2 g) (m_A + m_B), lambda^2 l m_B; lambda^2 l m_B, (lambda^2 l + 2 g) m_B) alpha = 0\
        ((1 + (2 g)/(lambda^2 l))(m_A + m_B), m_B) alpha = 0
      $
      - $lambda^2 l = - (2 g sqrt(m_A + m_B))/((sqrt(m_A + m_B) -sqrt(m_B)))$ 时：
        $
          ((m_A + m_B - (m_A + m_B - sqrt(m_B) sqrt(m_A + m_B))), m_B) alpha = 0\
          (sqrt(m_A + m_B), sqrt(m_B)) alpha = 0\
          alpha = vec(sqrt(m_B), - sqrt(m_A + m_B))\
        $
      - $lambda^2 l = - (2 g sqrt(m_A + m_B))/((sqrt(m_A + m_B) +sqrt(m_B)))$ 时：
        $
          ((m_A + m_B - (m_A + m_B + sqrt(m_B) sqrt(m_A + m_B))), m_B) alpha = 0\
          ( - sqrt(m_A + m_B), sqrt(m_B)) alpha = 0\
          alpha = vec(sqrt(m_B), sqrt(m_A + m_B))\
        $
      因此：
      $
        (I, 0) P = mat(sqrt(m_B), sqrt(m_B), sqrt(m_B), sqrt(m_B); - sqrt(m_A + m_B),- sqrt(m_A + m_B), sqrt(m_A + m_B), sqrt(m_A + m_B))\
        = diag(sqrt(m_B), sqrt(m_A + m_B)) mat(1, 1, 1, 1; -1, -1, 1, 1)\
        (I, 0) P diag(e^(i omega_1 t), e^(- i omega_1 t), e^(i omega_2 t), e^(- i omega_2 t)) bC = diag(sqrt(m_B), sqrt(m_A + m_B)) mat(e^(i omega_1 t), e^(- i omega_1 t), e^(i omega_2 t), e^(- i omega_2 t); - e^(i omega_1 t), - e^(- i omega_1 t), e^(i omega_2 t), e^(- i omega_2 t)) bC\
      $
      代入 $t = 0$ 情形：
      $
        vec(theta_0, 0) = diag(sqrt(m_B), sqrt(m_A + m_B)) mat(1, 1, 1, 1;-1, -1, 1, 1) bC\
        vec(0, 0) = diag(sqrt(m_B), sqrt(m_A + m_B)) mat(omega_1, - omega_1, omega_2, -omega_2; -omega_1 , omega_1, omega_2, - omega_2) bC\
        vec(0, 0) = mat(omega_1, - omega_1, 0, 0; 0, 0, omega_2, - omega_2) bC\
      $
      以上结合有：
      $
        mat(1, -1, 0, 0;0, 0, 1, -1; 1, 1, -1, -1) bC = 0\
      $
      换言之：
      $
        bC = k vec(1, 1, 1, 1)\
        theta = k_1 (omega_1 cos (omega_1 t) + omega_2 cos (omega_2 t))\
        phi = k_2 (- omega_1 cos (omega_1 t) + omega_2 cos (omega_2 t))\
      $
      因此每半个周期，一个质点位于静止位置，另一个质点达到最大偏离位置。