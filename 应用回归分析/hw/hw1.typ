
#import "../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 1.a
  == 3
    注意到：
    $
      mat(1, 0, ..., 0;
          -1, 1, ..., 0';
          dots.v, dots.v, dots.down, dots.v;
          0, 0, ..., 1) X := A X = Y
    $
    因此：
    $
      var(X) = var(Inv(A) Y) = Inv(A) var(Y) (Inv(A))^T = Inv(A) (Inv(A))^T\
      = mat(1, 1, 0, ..., 0;
            1, 2, 1, ..., 0;
            dots.v, dots.v, dots.v, dots.down, dots.v;
            0, 0, 0, ..., 2)
            )
    $
  == 4
    不难发现：
    $
      X_i = rho^(i - 1) X_1
    $
    因此：
    $
      var(X) = (cov(X_i, X_j))_(i j) = (rho^(i + j - 2) cov(X_1, X_1))_(i j) = (rho^(i + j - 2) sigma^2)_(i j)
    $
= 1.b
  == 2
    #let Xbar = $overline(X)$
    $
      Xbar = 1/N I_n^T X\
      sum_i (X_i - Xbar)^2 = ((1 - 1/N I_n I_n^T) X)^T ((1 - 1/N I_n I_n^T) X) = X^T (1 - 1/N I_n I_n^T) X 
    $
    因此 
    $
    E(sum_i (X_i - Xbar)^2) 
    &= tr((1 - 1/N I_n I_n^T) var(X)) + (E X)^T (1 - 1/N I_n I_n^T) (E X)\
    &= tr((1 - 1/N I_n I_n^T) var(X)) + mu^2 I_n^T (1 - 1/N I_n I_n^T) I_n\
    &= tr((1 - 1/N I_n I_n^T) var(X))\
    &= sum_i sigma_i^2 (1 - 1/N)\
    &= (N - 1)/N sum_i sigma_i^2\
    $
    同时：
    $
      var(Xbar) = 1/n^2 sum_i sigma^2
    $
    因此结论显然正确
  == 4
    === (a)
      $
        Xbar^2 &= 1/n^2 (I_n^T X)^T (I_n^T X) = 1/n^2 X^T I_n I_n^T X\
        E Xbar^2 &= 1/n^2 (tr(I_n I_n^T var(X)) + mu^2 I_n^T (I_n I_n^T) I_n)\
        &= mu^2 + 1/n^2 tr(I_n I_n^T var(X))\
        &= mu^2 + 1/n ((n - 1) sigma^2 rho + sigma^2)\
      $
      因此：
      $
        var(Xbar) = E Xbar^2 - (E Xbar)^2 = 1/n ((n - 1) sigma^2 rho + sigma^2)
      $
      由 $var(Xbar) >= 0$ 得到：
      $
        rho >= - 1/(n - 1)
      $
      而 $rho <= 1$ 是显然的
    === (b)
      $
        E(sum_i X_i^2) = sum_i E(X_i^2) = n(sigma^2 + mu^2)\
        E((sum_i X_i)^2) = n^2 E Xbar^2 = n^2 mu^2 + n sigma^2 ((n - 1) rho + 1) 
      $
      不难发现只能有：
      $
        a = 1/((n - 1)(1- rho)), b = -1/(n (n - 1)(1- rho))
      $
      此时：
      $
        Q = 1/((n - 1)(1 - rho)) (sum_i X_i^2 - 1/n (sum_i X_i)^2) = 1/((n - 1)(1 - rho)) sum_i (X_i - Xbar)^2
      $
  == 5
    // $
    //   var(S^2) = 1/(n - 1)^2 sum_i var((X_i - Xbar)^2) + 2 sum_(1 <= i <j <= n) cov((X_i - Xbar)^2, (X_j - Xbar)^2)\
    // $
    // 分别计算：
    // $
      
    // $
    === (a)
      注意到：
      $
        S^2 = 1/(n - 1) X^T (1 - 1/n I_n^T I_n)^T (1 - 1/n I_n^T I_n) X = 1/(n - 1) X^T (1 - 1/n I_n I_n^T) X
      $
      同时，$(1 - 1/n I_n I_n^T)$ 是半正定矩阵，且秩恰为 $n - 1$，因此可设：
      $
        (1 - 1/n I_n I_n^T) = P^T P
      $
      其中 $P$ 为 $(n - 1) times n$ 的行满秩矩阵。设 $Y = P X$，则有：
      $
        S^2 = 1/(n - 1) Y^T Y
      $
      以及：
      $
        E(Y) = E(P X) = P E(X) = mu P I_n\
        var(Y) = var(P X) = P var(X) P^T = sigma^2 P P^T 
      $
      然而：
      $
        (P I_n)^T (P I_n) = I_n^T P^T P I_n = I_n^T (1 - 1/n I_n I_n^T) I_n = 0 => P I_n = 0 => E(Y) = 0
      $
      同时，注意到 $P P^T$ 与 $P^T P = (1 - 1/n I_n I_n^T)$ 有相同的特征值，而后者是幂等半正定矩阵，因此前者也是。再由 $rank(P P^T) = rank(P) = n - 1$ 可得：
      $
        1/sigma^2 Y^T Y tilde chi^2_(n - 1)\
        var(1/sigma^2 Y^T Y) = 2(n - 1)\
        var(S^2) = 1/(n-1)^2 var(Y^T Y) = (2 sigma^4)/(n - 1)
      $
      同时：
      $
        var((P - E P)^T (P - E P)) &= var(P^T P - 2 (E P) P + (E P)^T (E P)) \
        &= var(P^T P - 2 (E P) P)\
      $
    === (b)
      注意到：
      $
        Q = 1/(2(n - 1)) (D X)^T (D X) 
      $
      其中：
      $
        D = mat(-1, 1, 0, ..., 0, 0;
                0, -1, 1, ..., 0, 0;
                dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
                0, 0, 0, ..., -1, 1)_((n - 1) times n)\
      $
      因此：
      $
        E Q &= 1/(2(n - 1)) (tr(D^T D var(X)) + E X^T D^T D E X)\
        &= 1/(2(n - 1)) sigma^2 tr(D^T D)\
        &= sigma^2
      $
    === (c)
      设 $Z tilde N(0, sigma^2)$，则：
      $
        var(Z^2) = E(Z^4) - (E Z^2)^2 = 3 sigma^4 - (sigma^2)^2 = 2 sigma^4
      $
      设 $Z_1, Z_2 tilde N(0, sigma^2)$ 且独立，则：
      $
        cov(Z_1^2, (Z_1 - Z_2)^2) = E(Z_1^2 (Z_1 - Z_2)^2) - E(Z_1^2) E((Z_1 - Z_2)^2) \
        = E Z_1^4 - 2 E Z_1^3 Z_2 + E Z_1^2 Z_2^2 - 2 sigma^4\
        = 3 sigma^4 + sigma^4 - 2 sigma^4\
        = 2 sigma^4
      $
      计算：
      $
        E Q^2 &= 1/(4(n - 1)^2) E(sum_i (X_(i + 1) - X_i)^2)^2\
              &= 1/(4(n - 1)^2) sum_i E(X_(i + 1) - X_i)^4 + 2 sum_i E((X_(i + 1) - X_i)^2 (X_(i + 2) - X_(i + 1))^2)\
              &= 1/(4(n - 1)^2) sum_i 3 dot 4 sigma^4 + 2 sum_i E((X_(i + 1) - X_i)^2 (X_(i + 2) - X_(i + 1))^2) + 4 ((n - 1) (n - 2) - 2(n - 2)) sigma^4\
              &= 1/(4(n - 1)^2) sum_i 3 dot 4 sigma^4 + 2 sum_i E((X_(i + 1) - X_i)^2 (X_(i + 2) - X_(i + 1))^2) + 4 ((n - 1)(n - 1) - 2(n - 2) - n - 1) sigma^4\
              &= 1/(4(n - 1)^2) sum_i 3 dot 4 sigma^4 + 2 sum_i E((X_(i + 1) - X_i)^2 (X_(i + 2) - X_(i + 1))^2) + 4 ((n - 1)(n - 1) - n + 3) sigma^4\
              &= 1/(4(n - 1)^2) sum_i 3 dot 4 sigma^4 + 2 sum_i sigma^4 + 3 sigma^4 + sigma^4 + sigma^4 \
              &= 1/((n - 1)^2) 3 (n - 1) sigma^2 + 3 (n - 2) sigma^2 \
              &= 1/((n - 1)^2) sigma^4 \
      $
      $
        var(Q) &= 1/(4(n - 1)^2) var(sum_i (X_(i + 1) - X_i)^2)\
        &= 1/(4(n - 1)^2) (sum_i var((X_(i + 1) - X_i)^2) + 2 sum_(1 <= i < j <= n) cov((X_(i + 1) - X_i)^2, (X_(j + 1) - X_j)^2))\
        &= 1/(4(n - 1)^2) (sum_i 2 (sqrt(2) sigma)^4 + 2 sum_i cov((X_(i + 2) - X_(i + 1))^2, (X_i - X_(i + 1))^2))\
        &= 1/(4(n - 1)^2) (sum_i 2 (sqrt(2) sigma)^4 + 2 sum_i E((X_(i + 2) - X_(i + 1))^2 (X_i - X_(i + 1))^2) - 4 sigma^4)\
        &= 1/(4(n - 1)^2) (sum_i 2 (sqrt(2) sigma)^4 + 2 sum_i 6 sigma^4 - 4 sigma^4)\
        &= 1/(4(n - 1)^2) (4 dot 2 (n - 1) sigma^4 + 4 (n - 2)sigma^4)\
        &= 1/((n - 1)^2) (2 (n - 1) sigma^4 + (n - 2)sigma^4)\
        // &= 1/(4(n - 1)^2) (sum_i 2 (sqrt(2) sigma)^4 + 2 sum_i cov((X_(i + 2) - X_(i + 1))^2, (X_(i + 2) - X_(i + 1) - (X_(i + 2) - X_i))^2))\
        // &= 1/(4(n - 1)^2) (sum_i 2 (sqrt(2) sigma)^4 + 2 sum_i 2 (sqrt(2) sigma)^4) \
        // &= 1/(4(n - 1)^2) ((n - 1) 2 (sqrt(2) sigma)^4 + 4 (n - 2) (sqrt(2) sigma)^4) \
        // &= 1/((n - 1)^2) ((n - 1) 2 sigma^4 + 4 (n - 2)  sigma^4) \
        // &= 1/(4(n - 1)^2) (8 (n -1)sigma^4 + 2 sum_i cov((X_(i + 2) - X_(i + 1))^2, (X_(i + 1) - X_i)^2))\
        // &= 1/(4(n - 1)^2) (8 (n -1)sigma^4 + 2 sum_i (cov(X_(i + 2) - X_(i + 1), X_(i + 1) - X_i)^2 + var((X_(i + 1) - X_i)(X_(i + 2) - X_(i + 1))) - sigma^4))\
        // &= 1/(4(n - 1)^2) (8 (n -1)sigma^4 + 2 sum_i var((X_(i + 1) - X_i)(X_(i + 2) - X_(i + 1))))\
        // &= 1/(4(n - 1)^2) (8 (n -1)sigma^4 + 2 sum_i var(X_(i+2) X_(i + 1) - X_(i + 2) X_i - X_(i + 1)^2 + X_i X_(i + 1)))\
        // &= 1/(4(n - 1)^2) (8 (n -1)sigma^4 + 4 sum_i - cov(X_(i + 2) X_(i + 1), X_(i + 2) X_i) - cov(X_(i + 2) X_(i + 1), X_(i + 1)^2))\
      $
      显然 $n -> +infinity$ 时，$(var(Q))/(var(S)) -> 3/2$

= 1.c3
  $
    cov(X, X^2) = E X dot X^2 - (E X) (E X^2) = E X^3 = 0
  $
= 2a.2
  任取（可测）区域 $S$，应当有：
  $
    P (Y in S) = P (A (U + c) Y in S) = P (U in A^(-1) S - c)
  $
  因此：
  $
    integral_(S)^() f(y) dif y = integral_(A^(-1) S - c)^() g(u) dif u
  $
  而由重积分换元：
  $
    integral_(S)^() f(y) dif y = integral_(A^(-1) S - c)^() f(y) |det(A)| dif u
  $
  由 $S$ 的任意性可得：
  $
    f(y) |det(A)| = g(u)
  $
= 2b
  == 4
    注意到：
    $
      vec(a^T Y, b^T Y) = vec(a^T, b^T) Y := C Y
    $
    因此 $vec(a^T Y, b^T Y)$ 服从：
    $
      E vec(a^T Y, b^T Y) = vec(a^T, b^T) E Y = mu vec(a^T, b^T) I_n \
      var(vec(a^T Y, b^T Y)) = C C^T = mat(a^T a, 0;0, b^T b)
    $ 
    的多元正态分布，进而 $a^T Y, b^T Y$ 独立
  == 7
    $
     p(x_2) &= integral_(-infinity)^(+infinity) 1/(2 pi) e^(-1/2 (x_1^2 + x_2^2)) (1 - (x_1 x_2)/((1 + x_1^2) (1 + x_2^2))) dif x_1 \
     &= integral_(-infinity)^(+infinity) 1/(2 pi) e^(-1/2 (x_1^2 + x_2^2))  dif x_1 - integral_(-infinity)^(+infinity) 1/(2 pi) e^(-1/2 (x_1^2 + x_2^2))  (x_1 x_2)/((1 + x_1^2) (1 + x_2^2)) dif x_1\
     &= e^(- 1/2 x_2^2)integral_(-infinity)^(+infinity) 1/(2 pi) e^(-1/2 x_1^2)  dif x_1 - integral_(-infinity)^(+infinity) 1/(2 pi) e^(-1/2 (x_1^2 + x_2^2))  (x_1 x_2)/((1 + x_1^2) (1 + x_2^2)) dif x_1\
     &= 1/(sqrt(2 pi)) e^(- 1/2 x_2^2) - integral_(-infinity)^(+infinity) 1/(2 pi) e^(-1/2 (x_1^2 + x_2^2))  (x_1 x_2)/((1 + x_1^2) (1 + x_2^2)) dif x_1\
     &=^("对称性") 1/(sqrt(2 pi)) e^(- 1/2 x_2^2)
    $
    因此 $X_2$ 服从标准正态分布，$X_1$ 同理可得
  == 8
    #let Ybar = $overline(Y)$
    #let prod1 = $prodf(lower: 1, upper: n, var: i)$
    #let prod0 = $prodf(lower: 0, upper: n, var: i)$
    #let sum1 = $sumf(lower: 1, upper: n, var: i)$
    $
      M(t) &= E e^(t_0 Ybar) prod1 e^(t_i (Y_i - Ybar))\
      &= E prod1 e^(Y_i (t_i - 1/n sum_j t_j - 1/n t_0))\
      &= prod1 E e^(Y_i (t_i - 1/n sum_j t_j - 1/n t_0))\
      &= prod1 e^(1/2 (t_i - 1/n sum_j t_j  - 1/n t_0)^2)\
      &= e^(sum1 1/2 (t_i - 1/n sum_j t_j  - 1/n t_0)^2)\
    $
    从而该变量服从多元正态分布。同时 $1/2 cov(Z_0, Z_i)$ 恰为上式指数中 $t_0 t_i$ 项的系数，计算$(i != 0)$：
    $
      -2 1/n  + sum1 2 1/n 1/n = 2/n - 2/n = 0
    $
    表明 $cov(Z_0, Z_i) = 0$，进而不相关，由多元正态知独立性，从而当然有 $Z_0$ 与 $sum1 Z_i^2$ 独立
= 2c.1
  由它们两两独立，可得 $Sigma$ 为对角阵，进而这些变量相互独立。
= 2d
  == 2
    === (a)
      假设：
      $
        A = U^T D U
      $
      并记 $Z = U Y$，则：
      $
        var(Z) = U var(Y) U^T = 1
      $
      因此 $Z tilde N(0, 1)$
      $
        M(t) = E e^(t Y^T A Y) = E e^(t Z^T D Z) = prod1 E e^(t d_i Z_i^2) = prod1 (1 - 2 t d_i)^(- 1/2) = (prod1 (1 - 2 t d_i))^(- 1/2) \
        = (det (1 - 2 t A))^(- 1/2)
      $
    === (b)
      若 $A$ 幂等，则 $d_1$ 只能为 $0, 1$，且 $1$ 个个数恰为 $r$，因此：
      $
        (prod1 (1 - 2 t d_i))^(- 1/2) = (1 - 2 t)^(- r/2)
      $
    === (c)
      设：
      $
        Sigma = V^T V
      $
      并设：
      $
        Z = V Y
      $
      则：
      $
        var(Z) = V var(Y) V^T = 1
      $
      $
        M(t) = E e^(t Y^T A Y) = E e^(t (Inv(V) Z)^T A (Inv(V) Z)) = E e^(t Z^T (Inv(V) A Inv((V^T))) Z) \
        = (det(1 - 2 t (Inv(V) A Inv((V^T))))^(- 1/2)
      $
  == 3
    注意到：
    $
      a(Y_1 - Y_2)^2 + b(Y_1 + Y_2)^2 = Y mat(a + b, b - a; b - a, a + b) Y
    $
    由条件，矩阵满秩幂等，只能为单位阵，因此 $a = b = 1/2$
  == 5
    $
      M(s, t) = E e^(t Y^T A Y + s Y^T B Y) = E e^(Y^T (t A + s B) Y) = det(1 - 2 t A - 2 s B)^(- 1/2)
    $
    若 $A B = 0$，则设：
    $
      A = C^T C\
      B = D^T D\
      U = C X\
      Y = D X
    $
    （其中 $C D$ 行满秩）则有：
    $
      quadFormSym(Y, A) = tMul(U)\
      quadFormSym(Y, B) = tMul(V)\
      tMul(C) tMul(D) = 0 => C D^T =0 =>cov(C X, D X) = 0 => U, Y "独立"\
    $
    因此当然有 $tMul(U), tMul(Y)$ 独立