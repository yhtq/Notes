#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
Page 102, 4a.2, 4a.3, 4a.4\
Page 109, 4b.2, 4b.3, 4b.5\
Page 113, 4c.1, 4c.3\
Page 114 4d.2\
Page 136  MISCELLANEOUS EXERCISES    5.6, 5.7\

= 4a
  == 2
    将模型变为：
    $
      Y' := Y - X beta = X beta' + epsilon
    $
    假设变为：
    $
      A (beta + beta') = c <=> A beta' = 0
    $
    显然该变换不会影响残差，由定理可得：
    $
      F = (n - p)/q (quadFormSym(Y', P - P_H))/quadFormSym(Y', I - P)
    $
    然而我们知道 $Y'$ 事实上就是 $epsilon$，因此：
    $
      F = (n - p)/q (quadFormSym(epsilon, P - P_H))/quadFormSym(epsilon, I - P)
    $
  == 3
    #let lam = $hat(lambda)_H$
    我们有：
    $
      RSS_H - RSS = quadFormSym(A hbeta - c, Inv(A Inv(tMul(X)) A^T))\
      lam = -2 Inv(A Inv(tMul(X)) A^T) (A hbeta - c)\
      var(lam) = 4  Inv(A Inv(tMul(X)) A^T) A var(hbeta) A^T Inv(A Inv(tMul(X)) A^T) \
      = 4 sigma^2 Inv(A Inv(tMul(X)) A^T) 
    $
    因此：
    $
      sigma^2 quadFormSym(lam, Inv(var(lam))) = quadFormSym(A hbeta - c, Inv(A Inv(tMul(X)) A^T))
    $
    证毕
  == 4
    将 $X$ 做类似划分，模型变为：
    $
      Y = X_1 beta_1 + X_2 beta_2 + epsilon
    $
    假设为：
    $
      A_1 beta_1 + A_2 beta_2 = 0 => beta_2 = - Inv(A_2) A_1 beta_1
    $
    假设成立时，模型变为：
    $
      Y = (X_1 - X_2 Inv(A_2) A_1) beta_1 + epsilon
    $
    因此 $X_1 - X_2 Inv(A_2) A_1$ 就是我们要找的 $X_A$。注意到：
    $
      (X_1, X_2) mat(1, 0; -Inv(A_2) A_1, 1) = (X_1 - X_2 Inv(A_2) A_1, X_2)
    $
    因此 $rank((X_1, X_2)) = rank((X_1 - X_2 Inv(A_2) A_1, X_2))$，而 $X$ 列满秩，因此这些子矩阵都列满秩。
= 4b
  == 2
    === (1)
      熟知：
      $
        var(beta) = sigma^2 Inv(tMul(X)) = sigma^2 Inv(mat(n, sumi(X_i);sumi(X_i), sum2(X_i)))\
        = sigma^2 1/(n sum2(X_i) - (sumi(X_i))^2) mat(sum2(X_i), -sumi(X_i);-sumi(X_i), n)
      $
      因此：
      $
        cor(hbeta_0, hbeta_1) = - sumi(X_i)/(sqrt(n sum2(X_i)))
      $
    === (2)
      有：
      $
        F = (hbeta_0^2 Inv(var(beta_0)/sigma^2))/S^2 =  hbeta_0^2 (n sum2(X_i) - (sumi(X_i))^2))/(S^2 sum2(X_i))\
        = (n - 2) (hbeta_0^2(n sum2(X_i) - (sumi(X_i))^2))/(sum2(Y_i - hY_i) sum2(X_i))
      $
  == 3
    假设成立时，模型变为：
    $
      Y = beta + X beta + epsilon = (1_n + X) beta + epsilon
    $
    则 $hY := k (1_n + X)$ 满足：
    $
      inner(Y, hY) = inner(hY, hY)\
      k inner(Y, 1_n + X) = k^2 norm2(1_n + X)\
      k = inner(Y, 1_n + X)/norm2(1_n + X)
    $
    残差为：
    $
      RSS_H = inner(Y, Y - hY) = norm2(Y) - k inner(Y, 1_n + X) = norm2(Y) - inner(Y, 1_n + X)^2/norm2(1_n + X)
    $
    因此：
    $
      F = 2 (norm2(Y) - inner(Y, 1_n + X)^2/norm2(1_n + X))/(norm2(Y - hY)) = 2 (norm2(Y) norm2(1_n + X) - inner(Y, 1_n + X)^2)/(norm2(Y - hY) norm2(1_n + X))
    $
  == 5
    有：
    #let one = $1_3$
    #let oneT = $1_3^T$
    $
      Y = mat(1, 0, 0;0, 1, 0;0, 0, 1; -1, -1, -1) beta + epsilon := X beta + epsilon
    $
    其中 $beta = vec(theta_1, theta_2, theta_3)$，待检验假设为：
    $
      (1, 0, -1) beta = 0
    $
    计算：
    $
      X^T X = (I, -1_3) vec(I, -1_3) = I + 1_3 1_3^T\
    $
    注意到：
    $
      (I + 1_3 1_3^T)(I + k 1_3 1_3^T) = I + (k + 1) 1_3 1_3^T + 3 k 1_3 1_3^T = I + (4 k + 1) 1_3 1_3^T
    $
    因此取 $k = -1/4$，有：
    $
      Inv(X^T X) = I - 1/4 1_3 1_3^T
    $
    因此：
    $
      Inv(X^T X) X^T = (I - 1/4 1_3 1_3^T) (I, -1_3) = (I - 1/4 1_3 1_3^T, 1/4 one)\
      hbeta = Inv(X^T X) X^T Y = (I - 1/4 1_3 1_3^T, 1/4 one) Y\
      A hbeta = (1, 0, -1) (I - 1/4 1_3 1_3^T, 1/4 one) Y = (1, 0, -1, 0) Y\
      P = mat(I - 1/4 1_3 1_3^T, -1/4 one; -1/4 oneT,3/4)\
      I - P = mat(1/4 1_3 1_3^T, 1/4 one; 1/4 oneT, 1/4) = 1/4 1_4 1_4^T
    $
    同时：
    $
      A Inv(tMul(X)) A^T = (1, 0, -1) (I - 1/4 1_3 1_3^T) (1, 0, -1)^T = 2
    $
    注意到：
    $
      hbeta = Inv(tMul(X)) X^T Y
    $
    因此：
    $
      F = ((Inv(2) tMul(A hbeta))/1)/(RSS/1) = 1/2 norm2(A hbeta)/norm2((I - P) Y) = 1/22 (Y_1 - Y_3)^2/norm2(1/4 1_4 1_4^T Y) = 2 (Y_1 - Y_3)^2/inner(1/4 1_4 1_4^T Y, 1/4 1_4 1_4^T Y)\
      = 1/2 (Y_1 - Y_3)^2/inner(1/4 1_4^T 1_4 1_4^T Y, 1/4 1_4^T Y) = 2 (Y_1 - Y_3)^2/(Y_1 + Y_2 + Y_3 + Y_4)^2
    $
= 4c
  == 1
    此时有：
    $
      Y tilde N(beta_0 1_n, sigma^2 I)\
      hY tilde N(beta_0 1_n, sigma^2 P)\
      1/sigma^2 norm2(hY - Ybar) tilde chi^2(p - 1)\ 
      // hY = P Y tilde N(beta_0 P 1_n, sigma^2 P) = N(beta_0 1_n, sigma^2 P)\
      // 1/sigma^2 norm2(hY - Ybar) = quadFormSym(hY, 1/sigma^2 (I - 1/n 1_n 1_n^T))\
      1/sigma^2 RSS = norm2((I - P)Y)/sigma^2 tilde chi^2(n - p)
    $
    // 注意到：
    // $
    //   1/sigma^2 (I - 1/n 1_n 1_n^T) sigma^2 P = (I - 1/n 1_n 1_n^T) P
    // $
    // 是幂等矩阵，秩为 $rank(P) - rank(1/n 1_n 1_n^T) = p - 1$，因此：
    // $
    //   1/sigma^2 norm2(hY - Ybar) tilde chi^2(p - 1)
    // $
    同时，有：
    $
      Y - Ybar 1_n = (I - 1/n 1_n 1_n^T) Y\
    $
    而：
    $
      (P - 1/n 1_n 1_n^T) (I - P) = 0
    $
    因此 $RSS$ 与 $norm2(hY - Ybar)$ 独立，故：
    $
      R^2 = RSS/(RSS + norm2(hY - Ybar)) tilde Beta((n - p)/2, (p - 1)/2)
    $
    而：
    $
      E R^2 = (p - 1)/(n - p + p - 1) = (p - 1)/(n - 1)
    $
  == 3
    == (a)
      $
        F = ((RSS_H - RSS)/1)/(RSS/ (n - p)) = (n - p) (RSS_H - RSS)/RSS = (n - p)((1 - R_H^2)norm2(Y - 1_n Y) - (1 - R^2) norm2(Y - hY))/((1 - R^2) norm2(Y - hY))\
        = (n - p) (R^2 - R_H^2)/(1 - R^2)
      $
    == (b)
      显然 $F$ 是非负的，因此 $R^2 >= R_H^2$
= 4d
  == 2
    #let RSS12 = $RSS_(1 2)$
    #let RSS2 = $RSS_2$
    将两次观测得到的 $omega$ 分别记为 $Omega_1, Omega_2$，记 $RSS12$ 是数据 1 得到的回归参数计算得到的数据 2 的 RSS，$RSS2$ 是数据 2 的 RSS，因此：
    $
      (RSS12 - RSS2)/RSS
    $
    就是一个检验假设是否成立的统计量。这相当于标准的假设检验格式：
    $
      H : beta = hbeta_1
    $
    因此：
    $
      F = p/(n - p) quadFormSym(hbeta_2 - hbeta_1, tMul(X))/RSS
    $
    就是该假设检验问题的统计量
    // 当假设成立时，有：
    // $
    //   RSS12 = norm2(Y_2 - P_(1) Y_2)\
    //   RSS2 = norm2(Y_2 - P_2 Y_2)\
    //   RSS12 - RSS2 = norm2(Y_2 - Omega_2 hbeta_1) - norm2(Y_2 - P_2 Y_2) 
    // $
    // 注意到：
    // $
    //   hbeta_1 = Inv(tMul(Omega_1)) Omega_1^T Y_1 \
    //   Omega_2 hbeta_1 = Omega_2 Inv(tMul(Omega_1)) Omega_1^T Y_1\
    //   norm2(Y_2 - Omega_2 hbeta_1) = norm2(Y_2 - Omega_2 Inv(tMul(Omega_1)) Omega_1^T Y_1) \
    //   = tMul(Y_2)  - 2 Y_2^T Omega_2 Inv(tMul(Omega_1)) Omega_1^T Y_1 + Y_1^T Omega_1 Inv(tMul(Omega_1)) tMul(Omega_2) Omega_1^T Y_1\
    // $
    // 可以得到：
    // $
    //   RSS12 - RSS2 = (Y_1^T, Y_2^T) mat()
    // $
= p136
  == 5.6
    在 Scheffe method 中取 $A = I$ 就有：
    $
      P(forall h, abs(h^T (hbeta - beta)) <= sqrt(2 S^2 F_(2, n - 2)^alpha h^T Inv(tMul(X))) h) = 1- alpha
    $
    因此任给参数 $a_0, a_1$，在上式中取 $h = vec(a_0, a_1)$ 便可得到对应的置信度至少为为 $1 - alpha$ 的置信区间
  == 5.7
    一般而言，总是可以将 $x_0$ 单位化。因此我们可以假设 $x_0 = 1$。$beta_0 = 0$ 对推理没有影响，只是使得 $p$ 变为 $p - 1$