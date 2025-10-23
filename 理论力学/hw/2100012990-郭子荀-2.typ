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
  == 4
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
        V = - m g (1, 0) (1/2 (A + B))\
        = - 1/2 m g R (1, 0) (be(theta) + beo(theta))\
        = - 1/2 m g R (cos theta - sin theta) 
      $
    - 动能为：
      $
        T = 1/2 integral_(0)^(1)  vt2(lambda A + (1 - lambda) B) m/l norm(dif (lambda A + (1 - lambda) B))\
        = 1/2 integral_(0)^(1)  vt2(lambda A + (1 - lambda) B) m/l norm(A - B) dif lambda\
        = 1/2 m integral_(0)^(1)  vt2(lambda A + (1 - lambda) B) dif lambda\
      $
