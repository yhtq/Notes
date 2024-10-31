#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
#let index = $bold(1)$
#let Var = $"Var"$
= #empty
  == #empty
    $
      E e_(n, h) (x) &= E (hat(rho)_(n, h)(x) - rho^* (x))\
      &= E (1/h sum_(j = 1)^m n_j / n 1_(B_j) (x) - rho^* (x))\
      &= E (1/h sum_(j = 1)^m 1 / n (sum_(i = 1)^n 1_(B_j) (x_i)) 1_(B_j) (x) - rho^* (x))\
      &= 1/(h n) sum_(i = 1)^n sum_(j = 1)^m E (1_(B_j) (x_i) 1_(B_j) (x)) - rho^* (x)\
      &= 1/(h n) sum_(i = 1)^n sum_(j = 1)^m p_j^* 1_(B_j) (x) - rho^* (x)\
      &= 1/(h n) sum_(i = 1)^n sum_(j = 1)^m 1_(B_j) (x) integral_(B_j)^() rho^* (t) dif t  - rho^* (x)\
      &= 1/(h n) sum_(i = 1)^n sum_(j = 1)^m (1_(B_j) (x) integral_(B_j)^() rho^* (t) dif t  - rho^* (x))\
      &=^(exists j) 1/(h n) sum_(i = 1)^n  (integral_(B_j)^() rho^* (t) dif t  - h rho^* (x))
    $
    则有：
    $
      abs(E e_(n, h) (x)) &<= 1/(h n)sum_(i = 1)^n  abs(integral_(B_j)^() rho^* (t) dif t  - h rho^* (x))\
      &= 1/(h n) sum_(i = 1)^n  abs(h (rho(*) - rho(x)))\
      &<= h L^*
    $
    类似的，可以得到：
    $
      Var(e_(n, h) (x)) &= 1/(h n)^2 sum_(i = 1)^n sum_(j = 1)^m Var (1_(B_j) (x_i) 1_(B_j) (x))\
      &= 1/(h n)^2 sum_(i = 1)^n sum_(j = 1)^m 1_(B_j) (x) (p_j - p_j^2)\
      &=^(exists j) 1/(h n)^2 sum_(i = 1)^n ((p_j - p_j^2))\
      &= 1/(h n)^2 sum_(i = 1)^n (p_j^* - p_j^*^2) \
      &= (p_j^* - p_j^*^2) / (h^2 n)\
    $
  == #empty
    假设 $x$ 是服从 $[0, 1]$ 上均匀分布的随机变量，问题等价于求：
    $
      E_(S, x) e_(n, h)^2 (x) &= E_x E_S e_(n, h)^2 (x) \
      &= E_x (E_S e_(n, h) (x))^2 + E_x Var_S (e_(n, h) (x))\
      &<= (L^* h)^2 + E_x (p_j^* - p_j^*^2) / (h^2 n)\
      &<= (L^* h)^2 + 1/m sum_(j = 1)^m (p_j^* - p_j^*^2) / (h^2 n) \
      &<= (L^* h)^2 + 1/(n h) (1 - sum_(j = 1)^m p_j^*^2)  \
      &<= (L^* h)^2 + 1/(n h)   \
    $
= #empty
= #empty
= #empty
  #block[
    #show "x": $bold(x)$
    等价于证明：
    $
      sum_(i = 1)^n norm(x_i - U V^T x_i)^2 >= sum_(i = 1)^n norm(x_i - U U^T x_i)^2 
    $ 
    计算：
    $
      sum_(i = 1)^n norm(x_i - U V^T x_i)^2 - norm(x_i - U U^T x_i)^2 &= sum_(i = 1)^n x_i^T (U - V) U^T (2I - U V^T - U U^T) x_i  \
      &space + x_i^T (I - U U^T) (I - U V^T) x_i - x_i^T (I - V U^T) (I - U U^T) x_i\
      &= sum_(i = 1)^n x_i^T ((U - V) U^T (2I - U V^T - U U^T) + V U^T - U V^T + U V^T - V U^T) x_i\
      &= sum_(i = 1)^n x_i^T (U - V) U^T (2I - U V^T - U U^T)  x_i\
      &= sum_(i = 1)^n x_i^T (U - V)  (2 U^T - V^T - U^T)  x_i\
      &= sum_(i = 1)^n x_i^T (U - V)  (U^T - V^T)  x_i\
      &>=0
    $
    证毕
  ]
= #empty
  注意到：
  $
    a^T a - b^T b = (a^T - b^T)(a + b) -a^T b + b^T a
    abs(inner(f_W (x_i), f_W (x_j)) - inner(x_i, x_j)) &= abs(norm(1/sqrt(K) W(x_i - x_j))^2 - norm(x_i - x_j)^2)\
    &= 1/norm(x_i - x_j)^2 abs(norm(1/sqrt(K) W(x_i - x_j))^2/norm(x_i - x_j)^2 - 1)\
  $
  若 $1/norm(x_i - x_j)^2 abs(norm(1/sqrt(K) W(x_i - x_j))^2/norm(x_i - x_j)^2 - 1) < 1/2 epsilon$，则有：
  $
    abs(norm(1/sqrt(K) W(x_i - x_j))^2/norm(x_i - x_j)^2 - 1) < 1/2 epsilon / norm(x_i - x_j)^2 <= epsilon
  $
  对 $x_(i j), i = 1, 2, ..., n, j = 1, 2, ..., n$ 这 $(n (n-1))/2$ 个向量，利用 Johnson-Lindenstrauss 引理立刻有结论成立
= #empty
  == #empty 
    计算：
    $
      &quad sum_k sum_(x_i in C_k^t) norm(x_i - alpha_k^(t - 1))^2 - norm(x_i - alpha_k^(t))^2 \
      &=  sum_k sum_(x_i in C_k^t) norm(x_i - alpha_k^(t - 1))^2 - norm(x_i - alpha_k^(t))^2\
      &= sum_k sum_(x_i in C_k^t) (alpha_k^(t) - alpha_k^(t - 1))^T (2 x_i - alpha_k^(t) - alpha_k^(t - 1))\
      &= sum_k (alpha_k^(t) - alpha_k^(t - 1))^T sum_(x_i in C_k^t)  (2 x_i - alpha_k^(t) - alpha_k^(t - 1))\
      &= sum_k (alpha_k^(t) - alpha_k^(t - 1))^T abs(C_k)  (2 alpha_k^t - alpha_k^(t) - alpha_k^(t - 1))\
      &= sum_k abs(C_k) (alpha_k^(t) - alpha_k^(t - 1))^T  (alpha_k^t - alpha_k^(t - 1))\
      &>= 0
    $
    证毕
  == #empty
    只需证明：
    $
      sum_k sum_(x_i in C_k^t) norm(x_i - alpha_k^(t - 1))^2 <= sum_k sum_(x_i in C_k^(t-1)) norm(x_i - alpha_k^(t - 1))^2
    $
    等价于：
    $
      sum_i norm(x_i - alpha_(k(i, t))^(t - 1))^2 <= sum_i norm(x_i - alpha_(k(i, t - 1))^(t - 1))^2
    $
    注意到从 $C_k^t$ 来自于对所有 $x_i$ 选择最近的 $alpha_k^(t-1)$，因此当然有：
    $
      norm(x_i - alpha_(k(i, t))^(t - 1))^2 <= norm(x_i - alpha_(k(i, t - 1))^(t - 1))^2, forall i
    $
    不难得知原命题成立
  == #empty
    理想的划分是：
    $
      {(0, 0), (0, 1)} {(4, 0), (4, 1)}
    $
    然而考虑划分：
    $
      {(0, 0), (4, 0)} {(0, 1), (4, 1)}
    $
    不难验证算法迭代一次后在该划分下稳定，这是一个局部极小值点。
= #empty
  == #empty
    #let Nor(x, mu, sigma) = $1/sqrt((2 pi)^d abs(Sigma_k))e^(-1/2 (#x - mu)^T Inv(sigma) (#x - mu))$
    #let lnNor(x, mu, sigma) = $-1/2 (d ln (2 pi) + ln abs(Sigma_k) + (#x - mu)^T Inv(sigma) (#x - mu))$
    $
      p(z = k | x_i, theta_t) = product_i Nor(x_i, mu_k, Sigma_k)/(sum_j pi_j Nor(x_i, mu_j, Sigma_j))\
      // ln p(z | x_i, theta_t) = sum_i lnNor(x_i, mu_z, Sigma_z) - ln(sum_j pi_j Nor(x_i, mu_j, Sigma_j))\
      // E_(z | x_i) ln p(z | x_i, theta_t) = E_(z | x_i) sum_i lnNor(x_i, mu_z, Sigma_z) - ln(sum_j pi_j Nor(x_i, mu_j, Sigma_j))\
      // 
      p(x_i, z = k | theta) = p(x_i | z = k, theta) p(z = k)\
      Q(theta | theta_t) = sum_i E_(z | x_i, theta_t) ln p(x_i, z | theta) = sum_i E_(z | x_i, theta_t) ln pi_z + lnNor(x_i, mu_z, Sigma_z)\
      = sum_i sum_k  (product_i Nor(x_i, mu^(theta_t)_k, Sigma^(theta_t)_k)/(sum_j pi_j Nor(x_i, mu^(theta_t)_j, Sigma^(theta_t)_j)))(ln pi_k -1/2 (d ln (2 pi) + ln abs(Sigma_l^theta) + (x_i - mu_k^theta)^T Inv(Sigma_l^theta) (x_i - mu_k^theta)))
    $
  == #empty
    目标函数为：
    $
    sum_i sum_k p(z = k | x_i, theta_t) (ln pi_k -1/2 (d ln (2 pi) + ln abs(Sigma_l^theta) + (x_i - mu_k^theta)^T Inv(Sigma_l^theta) (x_i - mu_k^theta)))
    $
    注意到有约束：
    $
      sum_k pi_k = 0
    $
    因此我们引入拉格朗日乘子，得到拉格朗日函数：
    $
      sum_i sum_k p(z = k | x_i, theta_t) (ln pi_k -1/2 (d ln (2 pi) + ln abs(Sigma_l^theta) + (x_i - mu_k^theta)^T Inv(Sigma_l^theta) (x_i - mu_k^theta))) \
      + lambda (sum_k pi_k - 1)
    $
    对 $pi_k$ 求导，得：
    $
      sum_i p(z = k | x_i, theta_t)/pi_k - lambda = 0\
      pi_k = (sum_i p(z = k | x_i, theta_t))/lambda\
      1 = sum_k (sum_i p(z = k | x_i, theta_t))/lambda\
      lambda = sum_i sum_k p(z = k | x_i, theta_t)\
      pi_k = (sum_i p(z = k | x_i, theta_t))/(sum_i sum_k p(z = k | x_i, theta_t))
    $
    对 $mu_k$ 求导，得：
    $
      0 = sum_i p(z = k | x_i, theta_t) (x_i - mu_k)^T Sigma^(-1)_k\
      0 = sum_i p(z = k | x_i, theta_t) (x_i - mu_k)^T\
      sum_i p(z = k | x_i, theta_t) mu_k = sum_i p(z = k | x_i, theta_t) x_i\
      mu_k = (sum_i p(z = k | x_i, theta_t) x_i)/( sum_i p(z = k | x_i, theta_t))\
    $
    对 $Sigma_k$ 求导，得：
    $
      0 = Sigma^(-1)_k - sum_i p(z = k | x_i, theta_t) (x_i - mu_k) (x_i - mu_k)^T  Sigma^(-2)_k\
      Sigma_k = sum_i p(z = k | x_i, theta_t) (x_i - mu_k) (x_i - mu_k)^T\
    $
