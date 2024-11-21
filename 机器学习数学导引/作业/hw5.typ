#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: true
)
= #empty
  == #empty
    令：
    $
      r_x (y) = f(y) - f(x) - inner(nabla f(x), y - x)
    $
    则：
    $
      nabla r_x (y) = nabla f(y) - nabla f(x)\
      norm(nabla r_x (y)) = norm(nabla f(y) - nabla f(x)) <= L * norm(y - x)\
      r_x (y) = r_x (y) - r_x (x) = integral_(x -> y "的线段") nabla r_x (z) dif z <= integral_(x -> y "的线段")  L  norm(z - x) dif z = 1/2 L norm(y - x)^2 
    $
    证毕
  == #empty
    由 $r_(x^*) (y)$ 定义，有 $r_(x^*) (y) >= 0, forall y$，因此：
    $
      0 &<= r_(x^*) (y) = f(y) - f(x^*) = (f(y) - f(x)) + (f(x) - f(x^*))\
      &<= inner(nabla f(x), y - x) + 1/2 L norm(y - x)^2 + (f(x) - f(x^*))\
      &= 1/2 L (norm(y - x)^2 + inner(2/L nabla f(x), y - x))+ (f(x) - f(x^*))\
      &= 1/2 L (norm(y - x - 1/L (nabla f(x))^T)^2 - 1/L^2 norm(nabla f(x))^2)+ (f(x) - f(x^*))\
    $
    因此可取 $y = x + 1/L (nabla f(x))^T$，立刻有：
    $
      0 <= -1/(2 L)  norm(nabla f(x))^2 + (f(x) - f(x^*))
    $
    整理立得原式
= #empty
  注意到：
  $
    f(x_(t + 1)) - f(x_t) <= inner(nabla f(x_t), x_(t + 1) - x_t) + 1/2 L norm(x_t - x_(t + 1))^2\
    = -eta inner(nabla f(x_t), "sign" nabla f(x_t)) + 1/2 L eta^2 norm("sign" nabla f(x_t))^2\
    = - eta norm(nabla f(x_t))_1 + 1/2 L eta^2 d
  $
  因此：
  $
    f(x_0) - inf_x f(x) >=  f(x_0) - f(x_(T + 1)) = sum_(i = 0)^(T) f(x_t) - f(x_(t + 1)) >= sum_(i = 0)^(T) (eta norm(nabla f(x_t))_1 - 1/2 L eta^2 d)\
    = eta sum_(i = 0)^(T) norm(nabla f(x_i))_1 - 1/2 L (T + 1) eta^2 d T >= eta (T + 1) min_i norm(nabla f(x_i))_1 - 1/2 L eta^2 d T 
  $
  整理即得原式
= #empty
  == #empty
    GF 方程给出：
    $
      der(x(t), t) = - nabla f(x(t))\
      der(f(x(t)), t) = nabla (f(x(t))) der(x(t), t) = - (nabla f(x(t)))^2 <= - mu f(x(t))^alpha\
      der(f(x(t))^(1 - alpha), t) = (1 - alpha) f(x(t))^(-alpha) der(f(x(t)), t) <= - mu (1 - alpha)\
      integral_(0)^(t) der(f(x(u))^(1 - alpha), t)  dif u <= - mu (1 - alpha) t\
      f(x(t))^(1 - alpha) - f(x(0))^(1 - alpha) <= - mu (1 - alpha) t\
    $
    整理即得：
    $
      f(x(t)) <= 1/(f(x(0))^(1 - alpha) + mu (alpha - 1) t)^(1/(alpha - 1)) tilde t^(-1/(alpha - 1))
    $
  == #empty
    ......
  == #empty
    同 (1)
  == #empty
    以 $f(x) = x^alpha$ 为例，有 GF：
    $
      der(x(t), t) = - alpha x(t)^(alpha - 1)\
      x(t)^(1 - alpha) dif x(t) = - alpha dif t\
      1/(1 - alpha) x(t)^(2 - alpha) = - alpha t + C\
    $
    当 $alpha < 2$ 时，解都只在有限区间成立，而 GD 的迭代方程：
    $
      x_t = x_(t - 1) + eta alpha 1/x_(t - 1)^(alpha - 1)
    $
    不难验证不可能有有限的极限（否则两边令 $t -> +infinity$，只能有 $x_t -> +infinity$）
= #empty
  // 计算：
  // $
  //   nabla cal(R)(beta) = X^T (X beta - y) 
  // $
  // 同时，不难验证它是凸的 L-光滑函数，并且课上已经给出它满足 PL 条件

  // 往证：
  #let lbeta = $overline(beta)$
  // $
  //   norm(beta_t) <= norm(lbeta)
  // $
  // 事实上，$t = 0$ 时显然，而：
  // 注意到：
  // $
  //   norm(lbeta - beta_(t + 1)) = norm(lbeta - beta_t + eta X^T (X beta_t - y)) = norm( lbeta - beta_t + eta X^T (X beta_t - X lbeta))\
  //   = norm((lbeta - beta_t) + eta X^T X (beta_t - lbeta))\
  //   <= norm(lbeta - beta_t) norm(I - eta X^T X)
  // //   <= norm(I - eta X^T X) norm(beta) + eta norm(X X^T) norm(lbeta)\
  // //   <= (norm(I - eta X^T X) + eta norm(X X^T)) norm(lbeta)\
  // $
  // 而当 $eta$ 充分小时，$norm(I - eta X^T X) = 1$，因此:
  // $
  //   norm(lbeta - beta_(t + 1)) <= norm(lbeta - beta_t)
  // $
  // 进而：
  不难计算得：
  $
    lbeta - beta_(t + 1) = beta_t - eta X^T (X beta_t - y) = (I - eta X^T X) (lbeta - beta_t) = ... = (I - eta X^T X)^(t + 1) lbeta\
    = (I - eta X^T X)^t (lbeta - eta X^T y)\
    beta_(t + 1) = (I - (I - eta X^T X)^t) lbeta\
    norm(beta_(t + 1)) <= norm((I - (I - eta X^T X)^t)) norm(lbeta)
  $
  而当 $eta$ 充分小时，$(I - eta X^T X)^t$ 的特征值均在 $[0, 1]$ 之间，因此：
  $
    norm((I - (I - eta X^T X)^t)) <= 1
  $
  可得：
  $
    norm(beta_(t + 1)) <= norm(lbeta)
  $
  任取 $beta_t$ 的收敛子列，设其极限为 $beta^*$，由 KL 条件有：
  $
    X beta^* = y
  $
  同时有：
  $
    norm(beta^*) <= norm(lbeta)
  $
  由定义，有：
  $
    beta^* = lbeta
  $
  证毕

  // 设 $X^T X$ 的最大，最小特征为 $lambda, lambda'$，则 $eta$ 充分小时上式等于:
  // $
  //   (1 - eta (lambda' - lambda)) norm(lbeta) <= norm(lbeta)
  // $
    // 我们分别有：
    // $
    //   f(x^*) <= f(x) + inner(nabla f(x), x^* - x) + 1/2 L norm(x^* - x)^2\
    //   f(x) <= f(x^*) + 1/2 L norm(x - x^*)^2
    // $
    // 以及：
    // $
    //   norm(nabla f(x)) = norm(nabla f(x) - nabla f(x^*)) <= L norm(x - x^*)
    // $
    // 因此：
    // $
    //   f(x) - f(x^*) >= inner(nabla f(x), x - x^*) - 1/2 L norm(x - x^*)^2 
    // $
    // $
    //   f(x) - f(x^*) >= L/2 norm(x - x^*)^2
    // $
= #empty
  计算：
  $
    nabla cal(R)(beta) = 1/n sum_i der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i)) Phi(x_i)
  $
  用归纳法，$t = 0$ 时显然，而：
  $
    beta^(t + 1) = beta^t - eta_t 1/B  sum_i der(l(sum_j beta_j phi_j (x_(omega_i)), y_i), sum_j beta_j phi_j (x_(omega_i))) Phi(x_(omega_i))\
    = beta^t - eta_t 1/B sum_i omega(i) der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i)) Phi(x_i)\
  $
  其中 $omega(i) = abs({k | omega_k = i})$
  $
    f(x\; beta_(t + 1)) = sum_(j = 1)^m beta_(j + 1)^(t + 1) phi_j (x)\
    = sum_(j = 1)^m beta_(j + 1)^(t) phi_j (x) - inner(eta_t 1/B sum_i omega(i) der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i)) Phi(x_i), Phi(x))\
    = sum_(i) alpha_t (i) k(x_i, x) - inner(eta_t 1/B sum_i omega(i) der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i)) Phi(x_i), Phi(x))\
    = sum_(i) alpha_t (i) k(x_i, x) - eta_t 1/B omega(i) der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i)) inner( Phi(x_i), Phi(x))\
    = sum_(i) alpha_t (i) k(x_i, x) - eta_t 1/B omega(i) der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i)) k(x_i, x)\
    = sum_(i)( alpha_t (i) - eta_t 1/B omega(i) der(l(sum_j beta_j phi_j (x_i), y_i), sum_j beta_j phi_j (x_i))) k(x_i, x)\
  $
  证毕
= #empty 
  == #empty
    注意到：
    $
      nabla L(theta) = 1/(n) sum_i (f(x_i\;theta) - y_i) nabla f(x_i\;theta)  := 1/n sum_i r_i (theta)
    $
    因此：
    $
      xi_t &= r_(i_t) (theta) - 1/n sum_i r_i (theta_t)\
      E norm(xi_t)^2 
      &= 1/n sum_j  (r_(j) (theta_t) - 1/n sum_i r_i (theta_t))^2\
      &= 1/n sum_j (r_j^2 (theta_t) - 2/n^2 sum_(i) r_j (theta_t) r_i (theta_t)) + 1/n^2 sum_(i, j) r_i (theta_t) r_j (theta_t)\ 
      &= 1/n sum_j r_j^2 (theta_t) - 1/n^2 sum_(i, j) r_i (theta_t) r_j (theta_t)\ 
      &= 1/n sum_j (f(x_i\;theta_t) - y_i)^2 (nabla f(x_i\;theta_t))^2 - 1/n^2 (sum_(i) r_i (theta_t))^2\ 
      &<= 1/n sum_j (f(x_i\;theta_t) - y_i)^2 (nabla f(x_i\;theta_t))^2\ 
      &<= 1/n sum_j C_1^2 (f(x_i\;theta_t) - y_i)^2 \ 
      &<= 2 C_1^2 L(theta_t) \ 
    $
  == #empty
    注意到：
    $
      E norm(theta_(t + 1) - theta^*)^2 = E norm(theta_t - eta g_t - theta^*)^2\
      = E norm(theta_t - theta^*)^2 - 2 eta E inner(g_t, theta_t - theta^*)_(i_t) + eta^2 E norm(g_t)^2\
      = E norm(theta_t - theta^*)^2 - 2 eta E_(theta_t) E (inner(g_t, theta_t - theta^*)_(i_t) | theta_t) + eta^2 E_(theta_t) E (norm(g_t)^2 | theta_t)\
      = E norm(theta_t - theta^*)^2 - 2 eta E_(theta_t) inner(nabla L(theta_t), theta_t - theta^*) + eta^2 E_(theta_t) (sigma_t^2 + norm(nabla L(theta_t))^2) \
    $
    表明：
    $
      - 1/(2 eta) (E norm(theta_(t + 1) - theta^*)^2 - E norm(theta_t - theta^*)^2) = E_(theta_t) inner(nabla L(theta_t), theta_t - theta^*) - eta/2 E_(theta_t) norm(nabla L(theta_t))^2 - eta/2 sigma_t^2
    $
    同时：
    $
      E(L(theta_(t + 1)) | theta_t) <= L(theta_t) - eta/2 norm(nabla L(theta_t))^2 + (eta C_2 sigma_t^2)/2\
      E (L(theta_(t + 1))) = E_(theta_t) E (L(theta_(t + 1)) | theta_t) <= E_(theta_t) L(theta_t) - eta/2 E_(theta_t) norm(nabla L(theta_t))^2 + (eta^2 C_2 sigma_t^2)/2\
      = - 1/(2 eta) (E norm(theta_(t + 1) - theta^*)^2 - E norm(theta_t - theta^*)^2) + E_(theta_t) L(theta_t) - E_(theta_t) inner(nabla L(theta_t), theta_t - theta^*) + (eta + C_2 eta^2)/2 sigma_t^2\
      = - 1/(2 eta) (E norm(theta_(t + 1) - theta^*)^2 - E norm(theta_t - theta^*)^2) + E_(theta_t) (L(theta_t) + inner(nabla L(theta_t), theta^* - theta_t)) + (eta + C_2 eta^2)/2 sigma_t^2\
      
    $
  == #empty
    在前式中求和，得：
    $
      s_(t + 1) - L(theta_0) <= 1/(2 eta) (E norm(theta_0 - theta^*)^2 - E norm(theta_t - theta^*)^2) + sum_(i = 0)^(t) (eta + C_2 eta^2)/2 sigma_i^2\
      <= 1/(2 eta) norm(theta_0 - theta^*)^2 + (eta + C_2 eta^2)/2 sum_(i = 0)^(t) sigma_i^2\
      <= 1/(2 eta) norm(theta_0 - theta^*)^2 + (eta + C_2 eta^2) C_1 sum_(i = 0)^(t) E (L(theta_t)) \
      <= 1/(2 eta) norm(theta_0 - theta^*)^2 + (eta + C_2 eta^2) C_1 s_t \
    $
    整理即得原式
  == #empty
    由凸性：
    $
      E L(overline(theta_T)) <= 1/T s_t 
    $
    而前式给出：
    $
      s_(t + 1) - (norm(theta_0 - theta^*)^2 + 2 eta L(theta_0))/(2 eta (1 - C_1^2 eta - C_1^2 C_2 eta^2)) <= C_1^2(eta + C_2 eta^2) (s_t - (norm(theta_0 - theta^*)^2 + 2 eta L(theta_0))/(2 eta (1 - C_1^2 eta - C_1^2 C_2 eta^2)))
    $
    $eta$ 充分小时，有：
    $
      s_1 - (norm(theta_0 - theta^*)^2 + 2 eta L(theta_0))/(2 eta (1 - C_1^2 eta - C_1^2 C_2 eta^2)) <= 0
    $
    上式表明：
    $
      s_t - (norm(theta_0 - theta^*)^2 + 2 eta L(theta_0))/(2 eta (1 - C_1^2 eta - C_1^2 C_2 eta^2)) <= 0
    $
    进而：
    $
      E L(overline(theta_T)) <= 1/T (norm(theta_0 - theta^*)^2 + 2 eta L(theta_0))/(2 eta (1 - C_1^2 eta - C_1^2 C_2 eta^2))
    $
  == #empty
    注意到：
    $
      sigma_(t+1)^2 <= 2 C_1^2 E (L(theta_(t + 1)) | theta_t)
    $
    以及：
    $
      E (L(theta_(t + 1)) | theta_t) 
    $
    类似课上定理的证明：
    $
      E (L (theta_(t + 1))) <= (1 - (mu eta)/2) E (L( theta_(t))) + (C_2 eta^2)/2 sigma_t^2\
      <= (1 - (mu eta)/2) E (L (theta_(t))) + (C_1^2 C_2 eta^2) L(theta_t)
    $
    两边再取期望，得：
    $
      E (L (theta_(t + 1))) <= (1 - (mu eta)/2) E (L( theta_(t))) + (C_2 eta^2)/2 sigma_t^2\
      <= (1 - (mu eta)/2 + C_1^2 C_2 eta^2) E (L (theta_(t)))
    $
    递归得：
    $
      E (L (theta_T)) <= (1 - (mu eta)/2 + C_1^2 C_2 eta^2)^T L(theta_0)
    $
= #empty
  == #empty
    类似课上证明，有：
    $
      E (f(x_(t + 1)) - f(x^*)) <= (1 - mu eta_t) E (f(x_(t)) - f(x^*)) + (L eta^2_t sigma^2 )/2
    $
    令 $P_t = 1/ (product_(k = 0)^(t - 1) (1 - mu eta_k))$，立刻有：
    $
      P_(t + 1) E (f(x_(t + 1)) - f(x^*)) <= P_t E (f(x_t) - f(x^*)) + P_(t + 1) (L eta^2_t sigma^2 )/2\
    $
    求和得：
    $
      P_(t + 1) E (f(x_(t + 1)) - f(x^*)) <= P_0 E (f(x_0) - f(x^*)) + sum_(k = 0)^(t - 1) P_(k + 1) (L eta^2_k sigma^2 )/2\
    $
    整理即得原式
  == #empty
    注意到：
    $
      product_(l = k)^t (1 - mu eta_l) -> 0 <=>  sum_(l = k)^t ln (1 - mu eta_l) -> -infinity
    $
    一方面，有：
    $
      sum_(l = k)^t ln (1 - mu eta_l) <= sum_(l = k)^t - mu eta_l <= - mu sum_(l = k)^t eta_l
    $
    因此右推左成立，另一方面：
    $
      sum_(l = k)^t ln (1 - mu eta_l) >= sum_(l = k)^t - mu eta_l - (mu^2 eta_l^2) / 2 = sum_(l = k)^t - mu (1 + (mu eta_l)/2) eta_l
    $
    显然 $(1 + (mu eta_l)/2) -> 1$，同时级数定号，因此上式表明左推右成立 
  == #empty
    注意到：
    $
      sum_(i = 0)^t eta_k^2 product_(l = k + 1)^t (1 - mu eta_l) \
      =  sum_(i = 0)^t eta_k^2 product_(l = k + 1)^infinity (1 - mu eta_l) + sum_(i = 0)^t eta_k^2 (product_(l = k + 1)^t (1 - mu eta_l) - product_(l = k + 1)^infinity (1 - mu eta_l))\
      =  sum_(i = 0)^t eta_k^2 (product_(l = k + 1)^t (1 - mu eta_l) - product_(l = k + 1)^infinity (1 - mu eta_l))\
    $
    若设 $sum_(i = N)^infinity eta_k^2 < epsilon $，则有：
    $
      sum_(i = 0)^t eta_k^2 (product_(l = k + 1)^t (1 - mu eta_l) - product_(l = k + 1)^infinity (1 - mu eta_l))\
      <= sum_(i = 0)^N eta_k^2 (product_(l = k + 1)^t (1 - mu eta_l) - product_(l = k + 1)^infinity (1 - mu eta_l)) + 2 epsilon
    $
    令 $t -> +infinity$，立得：
    $
      sum_(i = 0)^t eta_k^2 product_(l = k + 1)^t (1 - mu eta_l) < 2 epsilon
    $
    由任意性知原式收敛于 $0$
  == #empty
      由前三问，结论是显然的
  == #empty
    考虑函数 $1/x$，假设 $g_t = der(1/x, x_t) = - 1/x_t^2$，迭代方程为：
    $
      x_(t + 1) = x_t + eta_t 1/x_t^2
    $
    若取：
    $
      eta_t = 1/t^2
    $
    则显然有（不妨设 $x_t > 1$）：
    $
      x_(t + 1) = x_t + 1/t^2 1/x_t^2 <= x_t + 1/t^2
    $
    这将导致：
    $
      x_(t + 1) - x_0 <= sum_(i = 0)^(t - 1) 1/(i + 1)^2 <= pi^2/6
    $
    结合单调性，$x_t$ 将有有限极限，但显然不是原函数的最小值点。