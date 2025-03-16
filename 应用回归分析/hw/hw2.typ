#import "../../template.typ": *
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
Page 41, 3a.2, 3a.3, 3a.7\
Page 44, 3b.2, 3b.4\
Page 47, 3c.1\
Page 49, 3d.1\
Page 53, 3e.3\
Page 58, 3f.2, 3f.3\
Page 62, 3g.2, 3g.3\
Page 64, 3h.1\
Page 65, 3i.4, 3i.5\
page 69, 3k.5\
page 72, 3l.1\
#let hY = $hat(Y)$
= 3a
  == 2
    $
      sumBrN1(Y_i - hY_i) = 1_n^T (Y - hY) = 1_n^T (I - P) Y 
    $
    注意到 $X$ 的第一列恰为 $1_n$，因此：
    $
      P 1_n = 1_n\
      (I - P) 1_n = 0\
      1_n^T (I - P) = 0
    $
    继而上式 $= 0$
  == 3
    $
      Y = mat(1, 0;2, -1;1, 2)vec(theta, phi) + epsilon
    $
    其中 $X = mat(1, 0;2, -1;1, 2)$ 列满秩，只需解方程：
    $
      X^T X vec(theta, phi) = X^T Y\
      mat(6, 0; 0, 5) vec(theta, phi) = mat(1, 2, 1;0, -1, 2) Y\
      vec(theta, phi) = mat(1/6, 1/3, 1/6; 0, -1/6, 1/3) Y
    $
  == 7
    $
      sumBrN1(hY_i (Y_i - hY_i)) = hY^T (Y - hY) = (P Y)^T (I - P) Y = quadFormSym(Y, P(I-P)) = 0
    $
= 3b
  == 2
    设第一种估计的观测值为 $X_i$，第二种为 $Y_i$，第三种为 $Z_i$，因此有：
    $
      E X_i = theta\
      E Y_i = theta + phi\
      E Z_i = theta - 2 phi
    $
    #let hphi = $hat(phi)$
    #let n1 = $1_n$
    #let m1 = $1_m$
    残差平方和为：
    $
      &norm2(X - htheta n1) + norm2(Y - (htheta + hphi) n1) + norm2(Z - (htheta - 2 hphi) m1) \
      &= n htheta^2  - 2 X^T n1 htheta + norm2(X) + n (htheta + hphi)^2 - 2 Y^T n1 (htheta + hphi) + norm2(Y) + m (htheta - 2 hphi)^2 - 2 Z^T m1 (htheta - 2 hphi) + norm2(Z) \
    $
    求导得：
    $
      2 n htheta - 2 X^T n1 + 2 n (htheta + hphi) - 2 Y^T n1 + 2 m (htheta - 2 hphi) - 2 Z^T m1 = 0\
      2 n (htheta + hphi) - 2 Y^T n1 - 4 m (htheta - 2 hphi) + 4 Z^T m1 = 0
    $
    也即：
    $
      (2 n + m) htheta + (n - 2 m) hphi = X^T n1 + Y^T n1 + Z^T m1\
      (n - 2 m) htheta+ (n + 4 m) hphi = Y^T n1 - 2 Z^T m1 
    $
    解之即得最小二乘估计。而对上述方程组取期望得：
    $
      (2 n + m) E htheta + (n - 2 m) E hphi = n theta + n (theta + 2 phi) + m (theta - 2 phi) \
      (n - 2 m) E htheta + (n + 4 m) E hphi = n (theta + phi) - 2 m (theta - 2 phi)
    $
    若 $m = 2n$ 就有：
    $
      4 E htheta - 3 E hphi = theta + theta + phi + 2 theta - 4 phi\
      -3 E htheta + 9 E hphi = theta + phi + 4 theta - 8 phi
    $
    不难解出 $htheta, hphi$ 都是无偏的。
    
    // 设模型为：
    // $
    //   // vec(theta, phi) = vec(theta_x^T, phi_x^T) X  + vec(theta_y^T, phi_y^T) Y + vec(theta_z^T, phi_z^T) Z + epsilon
    //   vec(theta, phi) = A_x X + A_y Y + A_z Z + epsilon
    // $
    // #let Ax = $A_x$
    // #let Ay = $A_y$
    // #let Az = $A_z$
    // #let tht(x) = $theta_(#x)^T$
    // #let thtx = $tht(x)$
    // #let thty = $tht(y)$
    // #let thtz = $tht(z)$
    // #let phit(x) = $phi_(#x)^T$
    // #let phix = $phit(x)$
    // #let phiy = $phit(y)$
    // #let phiz = $phit(z)$
    // 残差平方为：
    // $
    //   &E(norm2(vec(theta, phi) - Ax X - Ay Y - Az Z))\
    //   =& norm2(E(vec(theta, phi) - Ax X - Ay Y - Az Z)) + tr(var(vec(theta, phi) - Ax X - Ay Y - Az Z))\
    //   =& norm2(vec(theta, phi) - theta Ax n1 - (theta + phi) Ay n1 - (theta - 2 phi) Az m1) + tr(var(Ax X)) + tr(var(Ay Y)) + tr(var(Az Z))\
    //   =& norm2(vec(theta, phi) - theta Ax n1 - (theta + phi) Ay n1 - (theta - 2 phi) Az m1) + tr(Ax^T var(X) Ax) + tr(Ay^T var(Y) Ay) + tr(Az^T var(Z) Az)\
    //   =& norm2(vec(theta, phi) - theta Ax n1 - (theta + phi) Ay n1 - (theta - 2 phi) Az m1) + sigma_x^2 tr(Ax^T Ax) + sigma_y^2 tr(Ay^T Ay) + sigma_z^2 tr(Az^T Az)
    // $
    // #lemmaLinear[][
    //   设 $A X = beta$，则：
    //   $
    //     tr(A^T A) <= norm2(beta)/norm2(X)
    //   $
    //   当且仅当 $A = alpha X^T$ 时取得 
    // ]
    // #proof[
    //   设 $A = autoVecN(A^T, n)$，则：
    //   $
    //     tr(A^T A) = tr(A A^T) = sumBrN1(A_i A_i^T) = sumBrN1(norm2(A_i))
    //   $
    //   条件给出：
    //   $
    //     A_i^T X = beta_i`
    //   $
    //   由柯西不等式：
    //   $
    //     norm2(beta_i) = norm2(A_i^T X) <= norm2(A_i) norm2(X)
    //   $
    //   求和得：
    //   $
    //     norm2(X) sumBrN1(norm2(A_i)) >= sumBrN1(norm2(A_i^T X)) = sumBrN1(norm2(beta_i)) = norm2(beta)
    //   $
    //   由柯西不等式的取等条件，得证。
    // ]
    // #let ax = $alpha_x$
    // #let ay = $alpha_y$
    // #let az = $alpha_z$
    // 由上面的引理并观察形式，为了让残差平方最小，当然是在 $A_x 1_n, A_y 1_n, A_z 1_m$ 保持不动的情况下，保证 $tr(tMul(Ax)), tr(tMul(Ay)), tr(tMul(Az))$ 最小，因此可设：
    // $
    //   Ax = ax 1_n^T\
    //   Ay = ay 1_n^T\
    //   Az = az 1_m^T
    // $
    // 上式化简为：
    // $
    //   &norm2(vec(theta, phi) - theta Ax n1 - (theta + phi) Ay n1 - (theta - 2 phi) Az m1) + sigma_x^2 tr(Ax^T Ax) + sigma_y^2 tr(Ay^T Ay) + sigma_z^2 tr(Az^T Az)\
    //   =& norm2(vec(theta, phi) - n theta ax - n (theta + phi) ay - m (theta - 2 phi) az) + n sigma_x^2 norm2(ax) + n sigma_y^2 norm2(ay) + m sigma_z^2 norm2(az)\
    //   // =& norm2(vec(theta, phi) - (n ax, n ay, m az) vec(theta, theta + phi, theta - 2 phi) ) + n sigma_x^2 norm2(ax) + n sigma_y^2 norm2(ay) + m sigma_z^2 norm2(az)\
    //   // =& norm2(vec(theta, phi) - (n ax, n ay, m az) mat(1, 0;1, 1;1, -2) vec(theta, phi)) + n sigma_x^2 norm2(ax) + n sigma_y^2 norm2(ay) + m sigma_z^2 norm2(az)\
    //   // =&  + n sigma_x^2 norm2(ax) + n sigma_y^2 norm2(ay) + m sigma_z^2 norm2(az)\
    // $
    // 求导得：
    // $
    //   (n sigma_x^2 + n^2 theta^2) ax = n theta (vec(theta, phi) - n (theta + phi) ay - m (theta - 2 phi) az)\
    //   (n sigma_y^2 + n^2 (theta + phi)^2) ay =  n (theta + phi) (vec(theta, phi) - n theta ax - m (theta - 2 phi) az)\
    //   (m sigma_z^2 + m^2 (theta - 2 phi)^2) az = m (theta - 2 phi) (vec(theta, phi) - n theta ax - n (theta + phi) ay)
    // $
    // $
    //   (n sigma^2 + n^2 theta^2) ax = n theta vec(theta, phi)
    // $
    // // $
    // //   &E (norm2(theta - thtx X - thty Y - thtz Z) + norm2(phi - phix X - phiy Y - phiz Z)) \
    // //   =& (E (theta - thtx X - thty Y - thtz Z))^2 + (E (phi - phix X - phiy Y - phiz Z))^2 \
    // //    &+ var(thtx X + thty Y + thtz Z) + var(phix X + phiy Y + phiz Z)\
    // //   =& (theta - thtx n1 - thty n1 - thtz m1 )^2 + (phi - phix n1 - phiy n1 - phiz m1)^2 \
    // //    &+ var(thtx X + thty Y + thtz Z) + var(phix X + phiy Y + phiz Z)\
    // // $
  == 4
    由题设有：
    $
      X = (1_n, X_1 - Xbar_1, X_2 - Xbar_2)\
      Y = X vec(beta_0, beta_1, beta_2) + epsilon\
    $
    由熟知结论：
    $
      var(vec(hbeta_0, hbeta_1, hbeta_2)) = sigma^2 Inv(tMul(X))
    $
    因此：
    $
      var(hbeta_1) = sigma^2 Inv(tMul(X))_(22)
    $
    而：
    $
      X^T X = mat(n, 1_n^T (X_1 - Xbar_1), 1_n^T (X_2 - Xbar_2); 
      1_n^T (X_1 - Xbar_1), norm2(X_1 - Xbar_1), (X_2 - Xbar_2)^T (X_1 - Xbar_1); 1_n^T (X_2 - Xbar_2), (X_2 - Xbar_2)^T (X_1 - Xbar_1), norm2(X_2 - Xbar_2))\
    $
    注意到：
    $
      1_n^T (X_1 - Xbar_1) = 0 = 1_n^T (X_2 - Xbar_2)\
    $
    记：
    $
      S_1^2 =  norm2(X_1 - Xbar_1), S_2^2 = norm2(X_2 - Xbar_2), S_(12)^2 = (X_2 - Xbar_2)^T (X_1 - Xbar_1)
    $
    #let S12 = $S_(12)^2$
    #let S1 = $S_1^2$
    #let S2 = $S_2^2$
    #let E1 = $E_1$
    #let E2 = $E_2$
    则：
    $
      X^T X = mat(n, 0, 0; 0, S_1^2, S12; 0, S12, S_2^2)\
      det(X^T X) = n (S1 S2 - (S12)^2)
    $
    以及：
    $
      (X^T X)_(2 2) = 1/(det(X^T X)) Det(n, 0; 0, S2) = (n S2)/(n (S1 S2 - (S12)^2)) = S2/(S1 S2 - S1 S2 r^2) = 1/(S1 (1 - r^2))\
    $
    代回即得结论。
= 3c
  == 1
    === (a)
      可以证明：
      $
        ((n - p) S_n^2)/sigma^2 tilde chi^2_(n - p)
      $
      因此：
      $
        var(((n - p) S_n^2)/sigma^2) = 2(n - p)\
        var(S_n^2) = 2 sigma^4/(n - p)
      $
    === (b)
      $
        E(quadFormSym(Y, A_1)) 
        &= sigma^2 tr(A_1) + quadFormSym(X beta, A_1)\
        &= sigma^2 tr(A_1) + 1/(n - p + 2) quadFormSym(X beta, I - X Inv(tMul(X)) X^T)\
        &= sigma^2 tr(A_1) + 1/(n - p + 2) quadFormSym(beta, X^T X - X^T X)\
        &= (n - p)/(n - p + 2) sigma^2
      $
      因此：
      $
        E(quadFormSym(Y, A_1) - sigma^2)^2 = (E(quadFormSym(Y, A_1) - sigma^2))^2 + var(quadFormSym(Y, A_1)) 
      $
      注意到：
      $
        (n - p + 2) A_1 = I - P
      $
      因此：
      $
        (n - p + 2)/sigma^2 quadFormSym(Y, A_1) tilde chi^2_(n - p)\
        var((n - p + 2)/sigma^2 quadFormSym(Y, A_1)) = 2(n - p)\
        var(quadFormSym(Y, A_1)) = (2(n - p) sigma^4)/(n - p + 2)^2
      $
      总之，前式等于：
      $
        (2/(n - p + 2) sigma^2)^2 + (2(n - p) sigma^4)/(n - p + 2)^2 = (4 + 2 (n - p))/(n - p + 2)^2  sigma^2
      $
    === (c)
      注意到 $S^2$ 是无偏估计，因此均方误差就是方差。计算：
      $
        (2 sigma^4/(n - p))/((4 + 2 (n - p))/(n - p + 2)^2  sigma^2) = (n-p+2)^2/(2(n - p) + (n - p)^2) = ((n - p)^2 + 4(n - p) + 4)/(2(n - p) + (n - p)^2) > 1
      $
      说明 $S^2$ 总是具有更大的均方误差。
= 3d
  == 1
    考虑线性模型：
    $
      Y = 1_n beta_0 + epsilon\
    $
    其中 $p = 1$\
    正规化方程为：
    $
      1_n^T 1_n beta_0 = 1_n^T Y\
      beta_0 = Ybar
    $
    同时：
    $
      (n - 1) S^2 = norm2(Y - 1_n Ybar) = Q
    $
    由 $hbeta$ 与 $S^2$ 独立，有 $Ybar$ 与 $Q$ 独立。同时：
    $
      Q/sigma^2 = ((n - 1) S^2)/sigma^2 tilde chi^2_(n - 1)
    $
= 3e
  == 3
    === (a)
    $
      X^T X &= mat(W^T W, W^T x_p; x_p^T W, tMul(x_p))\
      &= mat(W^T W, 0; 0, 1) mat(I, Inv(tMul(W)) W^T x_p; x_p^T W, tMul(x_p))\
      &= mat(W^T W, 0; x_p^T W, 1) mat(I, Inv(tMul(W)) W^T x_p; 0, tMul(x_p) - x_p^T W Inv(tMul(W)) W^T x_p)\
    $
    因此：
    $
      det(X^T X) = det(W^T W) (tMul(x_p) - x_p^T W Inv(tMul(W)) W^T x_p)
    $
    === (b)
      $
        det(W^T W) / det(X^T X) = 1/(quadFormSym(x_p, I - W Inv(tMul(W)) W^T))\
      $
      注意到 $W Inv(tMul(W)) W^T$ 对称幂等，因此半正定，进而：
      $
        quadFormSym(x, I - W Inv(tMul(W))) <= norm2(x)
      $
      因此：
      $
        1/(quadFormSym(x_p, I - W Inv(tMul(W)))) >= 1/norm2(x_p)
      $
      由矩阵逆的伴随矩阵表示，有：
      $
        var(hbeta_p) = sigma^2 det(W^T W) / det(X^T X) >= sigma^2 1/norm2(x_p)
      $
      若取等，有：
      $
        quadFormSym(x_p, W Inv(tMul(W)) W^T) = 0\
        quadFormSym(x_p, (W Inv(tMul(W)) W^T)^T W Inv(tMul(W)) W^T) = 0\
        W Inv(tMul(W)) W^T x_p = 0\
        Inv(tMul(W)) W^T x_p = 0 (W "列满秩")\
        W^T x_p = 0
      $
      等价于 $inner(x_j, x_p) = 0. forall j < p$
= 3f
  == 2
    $
      0 = der(quadFormSym(Y - Z gamma,R), gamma) = - 2 (Y - Z gamma)^T R Z\
      Z^T R (Y - Z gamma)  = 0\
      Z^T R Z gamma = Z^T R Y\
      gamma = Inv(Z^T R Z) Z^T R Y
    $
    注意到先对 $beta$ 求最小二乘，再对 $gamma$ 求最小二乘的结果应当与一次性求最小二乘一致，因此这个最小值应当就是 $quadFormSym(Y, R_G)$
  == 3
    由定理结论：
    $
      var(hbeta_G) = sigma^2 (Inv(tMul(X)) + L M L^T)\
      var(hbeta_G) - var(hbeta) = sigma^2 (L M L^T)\
    $
    由于 $M$ 的半正定性，$L M L^T$ 也是半正定的，因此对角线元素非负，进而 $var(hbeta_G^i) >= var(hbeta^i)$
= 3g
  == 2
    只需证明；
    $
      inner(Y - hY, hY - hY_H) = 0
    $
    事实上：
    $
      inner(Y - hY, hY - hY_H) &= inner(Y - hY, X (hbeta - hbeta_H))\
      &= inner((I - P) Y, X (hbeta - hbeta_H))\
      &= inner(Y, (I - P) X (hbeta - hbeta_H))\
      &= 0
    $
  == 3
    $
      hbeta_H = (I - Inv(tMul(X)) quadFormSym(A, Inv(A Inv(tMul(X)) A^T ))) hbeta + ......
    $
    因此：
    $
      var(hbeta_H) = sigma^2 (I - Inv(tMul(X)) quadFormSym(A, Inv(A Inv(tMul(X)) A^T ))) Inv(tMul(X)) (I - Inv(tMul(X))  quadFormSym(A, Inv(A Inv(tMul(X)) A^T )))^T\
      = sigma^2 (Inv(tMul(X)) - Inv(tMul(X))  quadFormSym(A, Inv(A Inv(tMul(X)) A^T )) Inv(tMul(X)))(I - quadFormSym(A, Inv(A Inv(tMul(X)) A^T )) Inv(tMul(X)))\
      = sigma^2 (Inv(tMul(X)) - Inv(tMul(X))  quadFormSym(A, Inv(A Inv(tMul(X)) A^T )) Inv(tMul(X))) 
    $
    由 $X^T X$ 的半正定性，可以逐层验证 $Inv(tMul(X))  quadFormSym(A, Inv(A Inv(tMul(X)) A^T )) Inv(tMul(X))$ 半正定，因此结论是成立的。
= 3h
  == 1
    $
      norm2(Y - X hbeta) = quadFormSym(hbeta, X^T X) - 2 Y^T X hbeta + norm2(Y) = hbeta^T X^T Y - 2 Y^T X hbeta + norm2(Y) \
      = norm2(Y) - Y^T X hbeta
    $
    因此只需证明 $X hbeta_1 = X hbeta_2$ 即可，事实上：
    $
      quadFormSym(hbeta_1 - hbeta_2, X^T X) = 0 => X(hbeta_1 - hbeta_2) = 0
    $
= 3i  
  == 4
    可设：
    $
      beta = gInv(tMul(X)) X^T Y\
      tMul(X) beta = tMul(X) gInv(tMul(X)) X^T Y 
    $
    $a^T beta$ 可估计当且仅当 $a in im X^T$，同时注意到：
    $
      im X^T X subset im X\
      rank(im X^T X) = rank(X^T X) = rank(X^T) = rank(im X^T)
    $
    因此 $im X^T = im X^T X$，这也等价于：
    $
      tMul(X) gInv(tMul(X)) a = a 
    $
    注意到取转置运算在矩阵的广义逆空间是封闭的双射，因此这也等价于：
    $
      a^T gInv(tMul(X)) tMul(X) = a^T
    $
    证毕
  == 5

    设 $a^T = b^T X$，则：
    $
      var(a^T hbeta) = var(b^T X gInv(tMul(X)) X^T Y) = sigma^2 b^T X gInv(tMul(X)) X^T X (gInv(tMul(X)))^T X^T b
    $
    类似的，由于 $X^T b in im X^T = im X^T X$，因此：
    $
      X^T X (gInv(tMul(X)))^T (X^T b) = X^T b ("注意到" (gInv(tMul(X)))^T "也是广义逆")
    $
    从而上式 $= sigma^2 b^T X gInv(tMul(X)) X^T b = sigma^2 a^T gInv(tMul(X)) a$
= 3k
  == 5
    === (a)
    注意到 $Y - X beta^*$ 服从正态分布，且：
    $
      E (Y - X beta^*) = 0\
      var(Y - X beta^*) = var(K (Z - B beta^*)) = K var(Z - B beta^*) K^T 
    $
    而：
    $
      var(Z - B beta^*) = var((I - P) Z) = sigma^2 (I - P) = sigma^2 (I - B Inv(tMul(B)) B^T)
    $
    因此：
    $
      var(Y - X beta^*) = sigma^2 (V - X Inv(tMul(B)) X^T) = sigma^2 (V - X Inv(quadFormSym(X, Inv(V))) X^T)
    $
    故：
    $
      Inv(V)/sigma^2 var(Y - X beta^*) = I - Inv(V) X Inv(quadFormSym(X, Inv(V))) X^T
    $
    这是幂等矩阵，而：
    $
      rank(I - Inv(V) X Inv(quadFormSym(X, Inv(V))) X^T) = n - tr(Inv(V) X Inv(quadFormSym(X, Inv(V))) X^T) \
      = n - tr(X^T Inv(V) X Inv(quadFormSym(X, Inv(V)))) = n - p
    $
    因此结论成立
    === (b)
      根据卡方分布的性质和期望，它当然是非负无偏估计。使用前面的定理也可以说明它是最佳的二次非负无偏估计。
    === (c)
      $
        X beta^* = X Inv(quadFormSym(X^T, Inv(V))) X^T Inv(V) Y
      $
      因此 $P^* = X Inv(quadFormSym(X^T, Inv(V))) X^T Inv(V)$，有：
      $
        (X Inv(quadFormSym(X^T, Inv(V))) X^T Inv(V))(X Inv(quadFormSym(X^T, Inv(V))) X^T Inv(V)) = X Inv(quadFormSym(X^T, Inv(V))) X^T Inv(V)\
        (X Inv(quadFormSym(X^T, Inv(V))) X^T Inv(V))^T = Inv(V) X Inv(quadFormSym(X^T, Inv(V))) X^T\
      $
      因此是幂等的但通常不对称。
= 3l
  == 1
    #let Pbar = $overline(P)$
    #let Ytil = $tilde(Y)$
    #let Ptil = $tilde(P)$
    注意到 $1_n in ker tilde(X)$，因此 $Ptil 1_n = 0$，有：
    $
      quadFormSym(Ytil, I - Ptil) = norm2(Ytil) - quadFormSym(Y - Ybar 1_n, Ptil) = norm2(Ytil) - quadFormSym(Y, Ptil) = "RSS"("由之前结果")
    $
    


      