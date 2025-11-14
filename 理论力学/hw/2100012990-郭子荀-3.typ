#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业3",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 胡 P371
  == 1
    设 $Qv in RR^n, Pv, Pv' in duel(RR^n)$ （也就是行向量）
    按题意，有：
    $
      Pv' := - partialDer(H(Qv, Pv, t), Qv)\
      L'(Pv', Pv, t) = -H(Qv, Pv, t) - Pv' Qv
    $
    因此：
    $
      partialDer(L', Pv) = - partialDer(H, Qv) partialDer(Qv, Pv) - partialDer(H, Pv) - Pv' partialDer(Qv, Pv) = - partialDer(H, Pv)\
      partialDer(L', Pv') = - partialDer(H, Qv) partialDer(Qv, Pv') - Qv - Pv' partialDer(Qv, Pv') = -Qv
    $
    根据正则方程有：
    $
      vt(Qv) = partialDer(H, Pv) = - partialDer(L', Pv)\
    $
    因此：
    $
      dif/(dif t) (partialDer(L', Pv')) = - vt(Qv) = partialDer(L', Pv)
    $
    表明原方程成立。
  == 4
    拉氏量为：
    $
      L = T - V = 1/2 m vt2(x) - 1/2 (k_1 (x - l_1)^2 + k_2 (x - l_2)^2)
    $
    广义动量为：
    $
      p = partialDer(L, vt(x)) = m vt(x)
    $
    哈密顿量为：
    $
      H(p, x) = p vt(x) - L = 1/2 m vt2(x) + 1/2 (k_1 (x - l_1)^2 + k_2 (x - l_2)^2)\
      = 1/2 p^2/m + 1/2 (k_1 (x - l_1)^2 + k_2 (x - l_2)^2)
    $
    正则方程为：
    $
      vt(x) = partialDer(H, p) = p/m\
      vt(p) = - partialDer(H, x) = - (k_1 (x - l_1) + k_2 (x - l_2))
    $
    也即：
    $
      vt(vec(k_1 (x - l_1) + k_2 (x - l_2), p)) = mat(0, (k_1 + k_2)/m; -1, 0) vec(k_1 (x - l_1) + k_2 (x - l_2), p)
    $
    令 $k_1 (x - l_1) + k_2 (x - l_2), p = x'$，方程变为：
    $
      vt(vec(x', p)) = mat(0, (k_1 + k_2)/m; -1, 0) vec(x', p)
    $
    将系数矩阵对角化，先求特征值：
    $
      Det(-lambda, (k_1 + k_2)/m; -1, -lambda) = lambda^2 + (k_1 + k_2)/m = 0\
      lambda = plus.minus i sqrt((k_1 + k_2)/m)
    $
    再求特征向量：
    $
      mat(-i sqrt((k_1 + k_2)/m), (k_1 + k_2)/m; -1, -i sqrt((k_1 + k_2)/m)) bX_1 = vec(0, 0)\
      bX_1 = vec(i sqrt((k_1 + k_2)/m), -1)\
    $
    $
      mat(i sqrt((k_1 + k_2)/m), (k_1 + k_2)/m; -1, i sqrt((k_1 + k_2)/m)) bX_2 = vec(0, 0)\
      bX_2 = vec(i sqrt((k_1 + k_2)/m), 1)
    $
    因此方程通解为：
    $
      exp(mat(0, (k_1 + k_2)/m; -1, 0) t) bC\
      = (bX_1, bX_2) exp(mat(i sqrt((k_1 + k_2)/m), 0; 0, -i sqrt((k_1 + k_2)/m)) t) Inv((bX_1, bX_2)) bC\
      = (bX_1, bX_2) mat(e^(i sqrt((k_1 + k_2)/m) t), 0; 0, e^(-i sqrt((k_1 + k_2)/m) t)) bC'\
    $
    其中 $bC'$ 由初值决定。
  == 5
    设悬点坐标为：
    $
      bX = vec(x, a x^2)\
      vt(bX) = vec(1, 2 a x) vt(x)
    $
    单摆坐标为：
    $
      bY = bX + l e(theta) = vec(x + l cos theta, a x^2 + l sin theta)\
      vt(e(theta)) = vec(-sin theta, cos theta) vt(theta) = e^orthogonal (theta) vt(theta)
    $
    - 动能为：
      $
        T = 1/2 m norm2(vt(bX) + l vt(e(theta)))\
        = 1/2 m norm2(vec(1, 2 a x) vt(x)) + 1/2 m l^2 vt2(theta) + m l (1, 2 a x) e^orthogonal (theta) vt(x) vt(theta)\
        = 1/2 m (1 + 4 a^2 x^2) vt2(x) + 1/2 m l^2 vt2(theta) + m l (1, 2 a x) e^orthogonal (theta) vt(x) vt(theta)\
        = 1/2 m quadFormSym(vec(vt(x), vt(theta)), mat(1 + 4 a^2 x^2, l (1, 2 a x) e^orthogonal (theta); l (1, 2 a x) e^orthogonal (theta), l^2))
      $
    - 势能为：
      $
        V = m g (a x^2 + l sin theta)
      $
    - 广义动量为：
      $
        Pv = partialDer(T - V, vt(vec(x, theta))) = m (vt(x), vt(theta)) mat(1 + 4 a^2 x^2, l (1, 2 a x) e^orthogonal (theta); l (1, 2 a x) e^orthogonal (theta), l^2)
      $
    - 哈密顿量为：
      $
        H = Pv vec(vt(x), vt(theta)) - (T - V)\
        = 1/2 m quadFormSym(vec(vt(x), vt(theta)), mat(1 + 4 a^2 x^2, l (1, 2 a x) e^orthogonal (theta); l (1, 2 a x) e^orthogonal (theta), l^2)) + m g (a x^2 + l sin theta)
      $
  == 6
    之前习题给出广义势为：
    $
      V = 1/r (1/c^2 vt2(r) + 1)
    $
    记：
    $
      Qv = vec(r, theta, phi)\
      e(theta, phi) = vec(sin theta cos phi, sin theta sin phi, cos theta)\
      partialDer(e, vec(theta, phi)) = mat(cos theta cos phi, -sin theta sin phi; cos theta sin phi, sin theta cos phi; -sin theta, 0) := e^orthogonal (theta, phi)\
      e^T e^orthogonal (theta, phi) = 0\
      tMul(e^orthogonal (theta, phi)) = mat(1, 0;0, sin^2 theta)
    $
    质点坐标为：
    $
      bX = r e(theta, phi) = r vec(sin theta cos phi, sin theta sin phi, cos theta)\
      vt(bX) = vt(r) e(theta, phi) + r vt(e(theta, phi))\
      = vt(r) e(theta, phi) + r partialDer(e(theta, phi), vec(theta, phi)) vec(vt(theta), vt(phi))\
      vtnorm2(bX) = vt2(r) + r^2 quadFormSym(vec(vt(theta), vt(phi)), mat(1, 0;0, sin^2 theta))
    $
    - 动能为：
      $
        T = 1/2 m vtnorm2(bX) = 1/2 m (vt2(r) + r^2 quadFormSym(vec(vt(theta), vt(phi)), mat(1, 0;0, sin^2 theta)))\
        = 1/2 m quadFormSym(vt(Qv), mat(1, 0, 0;0, r^2, 0;0, 0, r^2 sin^2 theta))
      $
    - 广义势为：
      $
      V = 1/r (1/c^2 vt2(r) + 1) = 1/r (quadFormSym(vt(Qv), mat(1/c^2, 0, 0;0, 0, 0;0, 0, 0)) + 1)
      $
    - 拉氏函数为 $L = T - V = ...$
    - 广义动量为：
      $
        Pv = partialDer(L, vt(Qv))\
        = autoTrans(vt(Qv)) (m mat(1, 0, 0;0, r^2, 0;0, 0, r^2 sin^2 theta) - 2/r mat(1/c^2, 0, 0;0, 0, 0;0, 0, 0))\
        vt(Qv) = Inv(m mat(1, 0, 0;0, r^2, 0;0, 0, r^2 sin^2 theta) - 2/r mat(1/c^2, 0, 0;0, 0, 0;0, 0, 0)) autoTrans(Pv)\
        = diag(1/(m - 2/r 1/c^2), 1/(m r^2), 1/(m r^2 sin^2 theta)) autoTrans(Pv)
      $
    - 哈密顿量为：
      $
        H = Pv vt(Qv) - L\
        = quadFormSym(vt(Qv), (m mat(1, 0, 0;0, r^2, 0;0, 0, r^2 sin^2 theta) - 2/r mat(1/c^2, 0, 0;0, 0, 0;0, 0, 0))) \
        - 1/2 m quadFormSym(vt(Qv), mat(1, 0, 0;0, r^2, 0;0, 0, r^2 sin^2 theta)) \
        + 1/r (quadFormSym(vt(Qv), mat(1/c^2, 0, 0;0, 0, 0;0, 0, 0)) + 1)\
        = quadFormSym(vt(Qv), 1/2 (m mat(1, 0, 0;0, r^2, 0;0, 0, r^2 sin^2 theta) - 2/r mat(1/c^2, 0, 0;0, 0, 0;0, 0, 0))) + 1/r\
        = 1/2 Pv vt(Qv) + 1/r\
        = 1/2 quadFormSym(Pv^T, diag(1/(m - 2/r 1/c^2), 1/(m r^2), 1/(m r^2 sin^2 theta))) + 1/r
      $
  == 7
    === (1)
      拉氏函数为：
      $
        L = 1/2 m norm2(bX) - (V(bX) + e (vt(bX))^T bA)
      $
      广义动量为：
      $
        Pv = partialDer(L, vt(bX)) = m autoTrans(vt(bX)) - e autoTrans(bA)
      $
      哈密顿量为：
      $
        H = Pv vt(bX) - L\
        = m norm2(vt(bX)) - e autoTrans(bA) vt(bX) - 1/2 m norm2(vt(bX)) + V(bX) + e autoTrans(bA) vt(bX)\
        = 1/2 m norm2(vt(bX)) + V(bX)\
        = 1/2 1/m norm2(Pv + e bA^T) + V(bX)\
      $
    === (2)
      注意到哈密顿量是坐标无关（在不同坐标下有相同的值）的，这是因为 $L$ 是坐标无关的，而假设 $Qv$ 和 $Qv'$ 是两个坐标，有：
      $
        Pv' = partialDer(L, vt(Qv')) = partialDer(L, vt(Qv)) partialDer(vt(Qv), vt(Qv')) = Pv partialDer(Qv, Qv')\
        Pv' vt(Qv') = Pv partialDer(Qv, Qv') partialDer(Qv', Qv) vt(Qv) = Pv vt(Qv)
      $
      采用旋转的坐标系，设新坐标系基为 $(e'_1, e'_2, e'_3) = E'$，则有：
      $
        E' = (e_1, e_2, e_3) mat(R(omega t), 0;0, 1)
      $
      其中 $R(theta)$ 是旋转矩阵：
      $
        R(theta) = mat(cos theta, -sin theta; sin theta, cos theta)
      $
      因此：
      $
        Xv = (e_1, e_2, e_3) Xv = (e'_1, e'_2, e'_3) Xv' =  (e_1, e_2, e_3) mat(R(omega t), 0;0, 1) Xv'\
        partialDer(Qv', Qv) = partialDer(E', (e_1, e_2, e_3)) = mat(R(omega t), 0;0, 1)\
        Pv = Pv' mat(R(omega t), 0;0, 1)\
      $
      综上：
      $
        H = 1/2 1/m norm2(Pv' mat(R(omega t), 0;0, 1) + e bA^T) + V(mat(R(omega t), 0;0, 1) Xv')\
      $
  == 8
    熟知动能为：
    $
      T = 1/2 m vt2(x)
    $
    势能为：
    $
      V = 1/2 k (x - l_0)^2
    $
    拉氏函数为：
    $
      L = T - V 
    $
    广义动量为：
    $
      p = partialDer(L, vt(x)) = m vt(x)
    $
    哈密顿量为：
    $
      H = p vt(x) - L = 1/2 p^2/m + 1/2 k (x - l_0)^2
    $
    注意到它不显含时间，因此它是一个守恒量。泊松形式的正则方程为：
    $
      vt(x) = [x, H] = (partialDer(x, x) partialDer(H, p) - partialDer(x, p) partialDer(H, x)) = p/m\
      vt(p) = [p, H] = (partialDer(p, x) partialDer(H, p) - partialDer(p, p) partialDer(H, x)) = - k (x - l_0)
    $
    运动方程为：
    $
      at(x) = - k/m (x - l_0)
    $
= 戈 p443
  == 5
    注意到：
    $
      L = quadFormSym(vt(Qv), mat(1, 1/2 k_2;1/2 k_2, 1/(a + b q_1^2))) + k_1 q_1^2
    $
    因此广义动量为：
    $
      Pv = partialDer(L, vt(Qv)) = 2 vt(Qv)  mat(1, 1/2 k_2;1/2 k_2, 1/(a + b q_1^2))\
      = autoTrans(vt(Qv)) mat(2, k_2; k_2, 2/(a + b q_1^2))\
      vt(Qv) = 1/(4/(a + b q_1^2) - k_2^2) autoTrans(Pv) mat(2/(a + b q_1^2), -k_2; -k_2, 2)
    $
    哈密顿量为：
    $
      H = Pv vt(Qv) - L\
      = 2 quadFormSym(vt(Qv), mat(1, 1/2 k_2;1/2 k_2, 1/(a + b q_1^2))) - (quadFormSym(vt(Qv), mat(1, 1/2 k_2;1/2 k_2, 1/(a + b q_1^2))) + k_1 q_1^2)\
      = 1/2 quadFormSym(vt(Qv),  mat(2, k_2; k_2, 2/(a + b q_1^2))) - k_1 q_1^2\
      = 1/2 1/(4/(a + b q_1^2) - k_2^2) quadFormSym(Pv^T, mat(2/(a + b q_1^2), -k_2; -k_2, 2)) - k_1 q_1^2
    $
    正则方程给出：
    $
      vt(Qv) = partialDer(H, Pv) = 1/(4/(a + b q_1^2) - k_2^2) autoTrans(Pv) mat(2/(a + b q_1^2), -k_2; -k_2, 2)\
      vt(Pv) = - partialDer(H, Qv) = - (1/2 ((8 q_1)/(a + b q_1^2)) 1/(4/(a + b q_1^2) - k_2^2)^2 quadFormSym(Pv^T, mat(2/(a + b q_1^2), -k_2; -k_2, 2))  + 1/2 1/(4/(a + b q_1^2) - k_2^2) quadFormSym(Pv^T, mat(-(4 q_1)/(a + b q_1^2)^2, -k_2; -k_2, 2)) - 2k_1 q_1 , 0)^T
    $
  == 6
    可设悬挂点坐标为：
    $
      bO = a e(omega t) = a vec(cos(omega t), sin(omega t))
    $
    因此质点坐标为：
    $
      bX = bO + l e(theta) = a vec(cos(omega t), sin(omega t)) + l vec(cos theta, sin theta)
    $
    动能为：
    $
      T = 1/2 m norm2(vt(bX))\
      = 1/2 m norm2(a omega e^orthogonal (omega t) + l e^orthogonal (theta) vt(theta))\
      = 1/2 m (a^2 omega^2 + l^2 vt2(theta) + 2 a l omega e^orthogonal (omega t)^T e^orthogonal (theta) vt(theta))
    $
    势能为：
    $
      V = m g (a sin(omega t) + l sin theta)
    $
    广义动量为：
    $
      p = partialDer(L, vt(theta)) = partialDer(T, vt(theta)) = m (l^2 vt(theta) + a l omega e^orthogonal (omega t)^T e^orthogonal (theta))\
      p/m = l^2 vt(theta) + a l omega cos(theta - omega t)\
      vt(theta) = p/(m l^2) - a omega/(l) cos(theta - omega t)
    $
    哈密顿量为：
    $
      H = p vt(theta) - L\
      = m (l^2 vt2(theta) + a l omega e^orthogonal (omega t)^T e^orthogonal (theta) vt(theta)) - (1/2 m (a^2 omega^2 + l^2 vt2(theta) + 2 a l omega e^orthogonal (omega t)^T e^orthogonal (theta) vt(theta)) - m g (a sin(omega t) + l sin theta))\
      = 1/2 m (l^2 vt2(theta) - a^2 omega^2) + m g (a sin(omega t) + l sin theta)\
    $
= 戈 P91
  == 2
    设球面上一闭合曲线为：
    $
      bX(t) = vec(theta(t), phi(t)),\
      Phi(t) = e(bX(t)) = vec(cos theta(t) cos phi(t), cos theta(t) sin phi(t), sin theta(t)), t in [0, 1]\
      e^orthogonal (theta, phi) = partialDer(e(theta, phi), vec(theta, phi)) = mat(- sin theta cos phi, -cos theta sin phi; -sin theta sin phi, cos theta cos phi; cos theta, 0)\
      e'^T e = 0
    $
    则其长度为：
    $
      integral_(0)^(1) norm(dif Phi(t)) = integral_(0)^(1) norm(e^orthogonal (theta(t), phi(t)) vec(dif theta(t), dif phi(t)))\
      integral_(0)^(1) norm(e^orthogonal (theta(t), phi(t)) vec(theta'(t), phi'(t))) dif t\
    $
    记 $E = tMul(e^orthogonal) = mat(1, 0;0, sin^2 theta)$，有：
    $
      f = norm(e^orthogonal (theta(t), phi(t)) vec(theta'(t), phi'(t)))\
      \
      partialDer(f, bX) = 1/(2 f) quadFormSym(bX', partialDer(E, bX))\
      partialDer(f, bX') = 1/(2 f) (2 bX'^T E)
    $
    有守恒量：
    $
      1/(f) theta' = c\
      theta' = c f\
    $
    不失一般性，可设 $theta'(0) = 0, theta(0) = 0$，而根据曲线的要求一定有 $f(0) != 0$ 立刻就有：
    $
      theta' = 0
    $
    这就得到了结论。
    // 继而 $E$ 是常数，$partialDer(f, bX) = 0$，有：
    // $
    //   bX'^T E = C^T f\
    //   C = vec(0, (sin^2 theta_0 phi' (0))/( f(0)))\
    //   f = 1/(C^T C) bX'^T E C\
    //   L = integral_()^() 1/(C^T C) bX'^T E C dif t\
    //   = ((bX(1) - bX(0))^T E C)/(C^T C)\
    //   = (bX(1) - bX(0))^T vec(0, f(0) / (phi' (0) ))\
    //   = (phi(1) - phi(0)) phi' (0) sqrt(cos^2 theta_0)/(phi'(0))\
    //   // phi' sin^2 theta_0 = c_0 sqrt((cos phi sin theta_0 - sin phi sin theta_0) phi')\
    //   // phi' = c_0^2/(sin^3 theta_0) (cos phi - sin phi)
    // $
    // $
    //   e''^T (e' times e) = (e_2 bX' bX' + e^orthogonal bX'')^T (e^orthogonal bX' times e bX)\
    // $
    // 欧拉-拉格朗日方程为：
    // $
    //   dif/(dif t) (partialDer(f, bX')) - partialDer(f, bX) = 0\
    //   ((autoTrans(bX') partialDer(E, bX) bX' + autoTrans(bX'') E)f - (bX'^T E) f')/f^2 \
    //   = 1/(2 f) quadFormSym(bX', partialDer(E, bX))\
    //   quadFormSym(bX', partialDer(E, bX)) + 2 autoTrans(bX'') E - 2 f'/f bX'^T E = 0\

    //   quadFormSym(bX', partialDer(E, bX)) + 2 autoTrans(bX'') E- 2 (1/(2 f^2) (quadFormSym(Xv', E))') bX'^T E = 0\
    //   quadFormSym(bX', partialDer(E, bX)) + 2 autoTrans(bX'') E-  ((quadFormSym(Xv', E))')/(quadFormSym(Xv', E)) bX'^T E = 0\
    //   quadFormSym(bX', partialDer(E, bX)) + 2 autoTrans(bX'') E-  (quadFormSym(Xv', partialDer(E, bX)) Xv' + 2 bX'^T E bX'' )/(quadFormSym(Xv', E)) bX'^T E = 0\
    //   quadFormSym(Xv', partialDer(E, bX)) (quadFormSym(Xv', E) I  - mulT(bX') E) + 2 autoTrans(bX'') E (quadFormSym(Xv', E) I - mulT(bX') E) = 0\
    //   (quadFormSym(Xv', partialDer(E, bX)) + 2 autoTrans(bX'') E) (quadFormSym(Xv', E) I  - mulT(bX') E) = 0\
    //   quadFormSym(Xv', partialDer(E, bX)) + 2 autoTrans(bX'') E = c bX'^T E
    //   // quadFormSym(bX', partialDer(E, bX)) + 2 E bX''-  bX'^T E  (quadFormSym(Xv', partialDer(E, bX)) Xv' + 2 bX'^T E bX'' )/(quadFormSym(Xv', E)) = 0\
    //   // (partialDer(e^orthogonal, bX) bX' f - e^orthogonal f')/f = partialDer(e^orthogonal, bX) bX'\
    //   // e^orthogonal f' = 0\
    //   // norm(e^orthogonal f') = 0\
    //   // f' = 0\
    //   // f = C\
    //   // tMul(e^orthogonal (theta(t), phi(t)) vec(theta'(t), phi'(t))) = C^2\
    //   // tMul(Phi') = C^2\
    //   // autoTrans(Phi') Phi'' = 0

    //   // e^orthogonal 1/(2 f) (bX''^T autoTrans(e^orthogonal) + bX'^T autoTrans(partialDer(e^orthogonal, bX) bX')) = 0\
    //   // (e^orthogonal bX'' + partialDer(e^orthogonal, bX) bX' bX') autoTrans(e^orthogonal) = 0\
    // $
    // $
    //   a b' + 2 a' b 
    // $
  == 3
    直接求带初动能情形。设曲线为 $Phi(t), t in [0, 1]$ 下降时间为：
    $
      T = integral_(0)^(1) (dif norm(Phi(t)))/norm(v(Phi(t))) dif t\
      = integral_(0)^(1) norm(bX')/sqrt(2/m (E_0 - m g z)) dif t 
    $
    因此：
    $
      f = norm(bX')/sqrt(2/m (E_0 - m g z))
    $
    欧拉-拉格朗日方程为：
    $
      dif/(dif t) (partialDer(f, bX')) - partialDer(f, bX) = 0
    $
    若设：
    $
      bX = vec(Pv, z)
    $
    则上面方程给出守恒量：
    $
      partialDer(f, Pv') = bC^T\
      partial/(partial Pv') (sqrt(norm2(Pv') + z'^2)/sqrt(2/m (E_0 - m g z))) = C^T\
      1/sqrt(2/m (E_0 - m g z))) 1/(2 sqrt(norm2(Pv') + z'^2)) 2 Pv'^T = bC^T
    $
    换言之，$Pv'$ 有固定方向，继而 $Pv$ 在某条直线上。可设 $Pv = bC r(t)$，并不失一般性设 $norm(bC) = 1$ 就有：
    $
      1/sqrt(2/m (E_0 - m g z)) 1/(sqrt(r'^2 + z'^2)) r' = r_0\
      r'^2 = 2 r_0^2 (E_0/m - g z) (r'^2 + z'^2)\
    $
    做变量代换：
    $
      r' = rho cos alpha,\
      z' = rho sin alpha
    $
    方程变为：
    $
      rho^2 cos^2 alpha = 2 r_0^2 (E_0/m - g z) rho^2\
      cos^2 alpha = 2 r_0^2 (E_0/m - g z)\
      - 2 sin alpha cos alpha = - 2 r_0^2 g z'\
      sin alpha cos alpha = r_0^2 g rho sin alpha\
    $
    $alpha = 0$ 的情形可以舍去，就有：
    $
      cos alpha = r_0^2 g rho\
      rho = 1/(r_0^2 g) cos alpha\
      z = E_0/(m g) - 1/(2 r_0^2 g) cos^2 alpha\
      = E_0/(m g) - 1/(4 r_0^2 g) (cos 2 alpha + 1)\
      = E_0/(m g) - 1/(4 r_0^2 g) - 1/(4 r_0^2 g) cos 2 alpha\
      r' = rho cos alpha = 1/(r_0^2 g) cos^2 alpha\
      r = 1/(r_0^2 g) integral cos^2 alpha dif t\
      = 1/(2 r_0^2 g) (sin alpha cos alpha + alpha) + r_0\
      = 1/(4 r_0^2 g) (sin 2 alpha + 2 alpha) + r_0
    $
    这就得到了结论。