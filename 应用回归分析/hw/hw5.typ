#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
Page 270 10a.3, 10a.4\
Page 280 10b.2, 10b.3,\
Page 295 10c.4\
Page 301 10d.2\
Page 315 10e.1\
Page 327 10f.3\
page 399 12a.2\
page 413 12b.3
= 10a
  == 3
    == (a)
      注意到 $e = (I - H) epsilon$，因此 $e_i = alpha_i^T (I - H) epsilon$，其中：
      $
        alpha_i = vec(0, 0, dots.v, 1, dots.v, 0, 0)
      $
    == (b)
      $
        r_i^2/(n - p) = 1/(n - p) e_i^2/(S^2 (1 - h_i)) = quadFormSym(epsilon, (I - H) alpha_i alpha_i^T (I - H))/((1 - h_i) quadFormSym(epsilon, I - H))
      $
      上下 $epsilon$ 除掉 $sigma$ 即得到结论
    == (c)
      显然 $Q$ 是对称的，而：
      $
        Q^2 
        &= 1/((1 - h_i)^2) (I - H) alpha_i alpha_i^T (I - H) (I - H) alpha_i alpha_i^T (I - H) \
        &= 1/((1 - h_i)^2) (I - H) alpha_i alpha_i^T (I - H) alpha_i alpha_i^T (I - H)\
        &= 1/((1 - h_i)^2) (I - H) alpha_i (alpha_i^T (I - H) alpha_i) alpha_i^T (I - H)\
        &= 1/((1 - h_i)^2) (I - H) alpha_i (1 - h_i) alpha_i^T (I - H)\
        &= 1/(1 - h_i) (I - H) alpha_i alpha_i^T (I - H)\
        &= Q
      $
    == (d)
      首先不难发现 $Q H = H Q = 0$，结合 $Q, H$ 都是投影矩阵，$I - H - Q$ 当然也是。同时，$Q (I - H - Q) = 0$ 给出 $quadFormSym(Z, Q)$ 与 $quadFormSym(Z, I - H - Q)$ 之间独立。注意到：
      $
        quadFormSym(Z, Q) tilde chi^2(tr(Q)) = chi^2(1)\
        quadFormSym(Z, I - H - Q) tilde chi^2(tr(I - H - Q)) = chi^2(n - p - 1)
      $
      因此就有：
      $
        r_i^2/(n - p) = quadFormSym(Z, Q)/(quadFormSym(Z, Q) + quadFormSym(Z, I - H - Q)) tilde Beta(1/2, (n - p - 1)/2)
      $
  == 4
    注意到：
    $
      (I - H)^2 = I - H
    $
    展开就有：
    $
      (1 - h_i)^2 + sum_(j != i) H_(i j)^2 = 1 - h_i
    $
= 10b
  == 2
    #figure(
      image("./Rplot0.png")
    )
    可见残差与 $x_2$ 明显相关，且 $g$ 的形状接近题设的 $abs(x)^(1/3)$

    #figure(
      image("./Rplot21.png")
    )
    可见形状与之前相近。
  == 3
    $rho = 0.999$ 时：
    #figure(
      image("./Rplot54.png")
    )
    可见部分残差与协变量有明显的相关性。
    $rho = 0$ 时：
    #figure(
      image("./Rplot55.png")
    )
    可见部分残差较小，且与协变量无明显相关性。
= 10c.4
  设 $omega(mu) = mu^2/r$，只需取：
  $
    f = integral_()^() 1/(sqrt(mu^2/r)) dif mu = sqrt(r) ln mu 
  $
  即可。
= 10d.2
  == (a)
    注意到：
    $
      p_y (y) = p_g (g(y, lambda)) abs(partialDer(g(y, lambda), y)) = 1/sqrt(2 pi sigma^2) e^(-1/2 (g(y, lambda) - x_i^T beta)^2/(sigma^2)) abs(partialDer(g(y, lambda), y))
    $
    因此对数似然函数为：
    $
      sum_i -1/2 ln (2 pi) - 1/2 ln sigma^2 - 1/(2 sigma^2) (g(y_i, lambda) - x_i^T beta)^2 + ln abs(partialDer(g(y_i, lambda), y_i))
    $
    展开就是题目中形式
  == (b)
    此时：
    $
      partialDer(g(y, lambda), y) = sgn(y) (lambda sgn(y) (abs(y) + 1)^(lambda - 1))/lambda\
      abs(partialDer(g(y, lambda), y)) = (abs(y) + 1)^(lambda - 1)\
      ln abs(partialDer(g(y, lambda), y)) = (lambda - 1) ln (abs(y) + 1)
    $
    结合上一题结论即可。
= 10e.1
  熟知：
  $
    hbeta(i) - hbeta = (Inv(tMul(X)) e_i x_i)/(1 - h_i)\
    d^T hbeta(i) - d^T hbeta = 1/(1 - h_i) e_i (x_i^T Inv(tMul(X))) d\
    =  1/(1 - h_i) e_i (alpha_i^T X Inv(tMul(X))) d\
    =  1/(1 - h_i) e_i alpha_i^T (C^T d)\
    =  1/(1 - h_i) e_i (C^T d)_i\
  $
= 10f.3
  #let Xstar = $X^*$
  #let Xs = $X_s$
  $
    X_s^T X_s = mat(n, 0;0, Xstar^T Xstar)\
    Inv(V) = mat(c, 0;0, k I)\
    X_s^T X_s + Inv(V) = mat(n + c, 0;0, Xstar^T Xstar + k I)\
    Inv(X_s^T X_s + Inv(V)) = mat(1/(n + c), 0;0, Inv(Xstar^T Xstar + k I))\
    Inv(X_s^T X_s + Inv(V)) Xs^T Y = mat(1/(n + c), 0;0, Inv(Xstar^T Xstar + k I)) vec(1^T Y, Xstar^T Y)
  $
  则 $gamma$ 的后验估计就是：
  $
    Inv(Xstar^T Xstar + k I) Xstar^T Y
  $
= 12a.2
  #let tgamma1 = $tilde(gamma)_1$
  == (a)
    设 
    $
      U = (1, X, Z)\
      V = (1, X)\
    $
    则有：
    $
      hgamma' = vec(1, tgamma1) = Inv(tMul(V)) V^T Y
    $
    $
      E (hy - alpha - gamma_1 x - gamma_2 z)^2
      &= E (hy - E y)^2\
      &= E ((1, x) hgamma' - (1, x, z) gamma)^2\
      &= var ((1, x) hgamma') + ((1, x) E hgamma' - (1, x, z) gamma)^2\
      &= var ((1, x) hgamma') + ((L^T vec(1, x) - z) gamma_2)^2\
      &= (1, x) var(hgamma') vec(1, x) + gamma_2^2 (Z^T V Inv(tMul(V)) vec(1, x) - z)^2\
      &= (1, x) var(hgamma') vec(1, x) + gamma_2^2 ((0, Z^T X) Inv(mat(n, 0;0, 1)) vec(1, x) - z)^2\
      &= (1, x) var(hgamma') vec(1, x) + gamma_2^2 (r x - z)^2\
      &= sigma^2 (1, x) Inv(tMul(V)) vec(1, x) + gamma_2^2 (r x - z)^2\
      &= sigma^2 (1, x) Inv(mat(n, 0;0, 1)) vec(1, x) + gamma_2^2 (r x - z)^2\
      &= sigma^2 (1, x) mat(1/n, 0;0, 1) vec(1, x) + gamma_2^2 (r x - z)^2\
      &= sigma^2 (1/n + x^2) + gamma_2^2 (r x - z)^2\
    $
  == (b)
    若采用全模型，有：
    $
      E (hy - alpha - gamma_1 x - gamma_2 z)^2
      &= E (hy - E y)^2\
      &= E ((1, x, z) hgamma - (1, x, z) gamma)^2\
      &= var ((1, x, z) hgamma)\
      &= (1, x, z) var (hgamma) vec(1, x, z)\
      &= sigma^2 (1, x, z) Inv(tMul(U)) vec(1, x, z)\
      &= sigma^2 (1, x, z) Inv(mat(n, 0, 0;0, 1, r;0, r, 1)) vec(1, x, z)\
      &= sigma^2 (1, x, z) mat(1/n, 0, 0;0, 1/(1 - r^2), -r/(1 - r^2);0, -r/(1 - r^2),  1/(1 - r^2)) vec(1, x, z)\
      &= sigma^2 (1/n + 1/(1 - r^2) (x^2 + z^2 - 2 r x z))\
    $
    因此只要：
    $
      sigma^2 (1/n + x^2) + gamma_2^2 (r x - z)^2 <= sigma^2 (1/n + 1/(1 - r^2) (x^2 + z^2 - 2 r x z))
    $
    则 $hY$ 就是更好的估计。
= 12b.3 
  $
    "KL"(f, g) &= integral_()^() ln f(y)/g(y) f(y) dif y\
    &>= integral_()^() (1 - g(y)/f(y)) f(y) dif y\
    &= integral_()^() f(y) - g(y) dif y\
    &= 1 - 1\
    &= 0\
  $


