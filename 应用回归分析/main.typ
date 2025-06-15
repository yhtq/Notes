#import "../template.typ": *
#show: note.with(
  title: "应用回归分析",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let cov = "Cov"
#let var = "Var"
#let approxVar(Y) = $overline(Y)$
#let sum2 = sumi1n2
#let sumi = sumi1n
= 前言  
  - Instructor: Ruibin Xi
  - Office: 智华楼470
  - TA: 唐语阳（tangyuyang\@stu.pku.edu.cn）
  - Email: ruibinxi\@math.pku.edu.cn
  - Office hour: 周二 14:00-15:00 智华楼470
  - Text book: Seber, G. A. F. and Lee, A. J. (2003). Linear Regression Analysis (2nd ed.). Wiley.
  - 作业：两周一次
  - 作业 15% + 期中 35% + 期末 50%
  - 考试以理论推导为主，作业会有一些上机
  #definition[线性模型][
    若有两个随机变量（向量）$X, Y$，一个线性模型是指：
    $
      Y = beta^T X + epsilon
    $
    其中：
    - $X$ 常常被称为 predictor, independent variable, covarient, ...
    - $Y$ 常常被称为 response variable, dependent variable, ...
    - $epsilon$ 是误差项。通常来说，假设其服从 $N(0, sigma^2)$（也可以做其他假设）。有些时候，会遇到误差项根据 $X$ 的不同而有不同的方差，可能需要做额外处理。
  ]
  线性回归分析是非常普遍的情形。事实上，假设 $f_i$ 是一组函数，则形如：
  $
    Y = sum_i beta_i f_i (X) + epsilon
  $
  的模型本质上也是线性回归问题。

  对于线性回归问题，核心问题是：
  - 如何估计 $beta$
  - 如何进行假设检验，例如 $beta < 0$ 的检验
  - 如何进行预测。注意预测和估计 $beta$ 并非相同的问题，它们的目标并不相同，最优的方法也并不完全相同。例如有些时候参数的数量远超样本的数量，这时候找到一个估计的 $beta$ 非常容易，但是预测的效果可能并不好。
  == 预备知识
    #definition[随机矩阵][
      设 $Z = (z_(i j))_(m times n)$，其中 $z_(i j)$ 是随机变量，则称 $Z$ 为随机矩阵。定义期望：
      $
        E(Z) = (E(z_(i j)))_(m times n)
      $
    ]
    #lemma[][
      - $E(A Z B + C) = A E(Z) B + C$，其中 $A, B, C$ 为常数矩阵。
      - $E(X + Y) = E(X) + E(Y)$
    ]
    #definition[协方差][
      设 $X, Y$ 为两个随机变量，则定义协方差矩阵：
      $
        cov(X, Y) = (cov(x_i, y_j))_(m times n) = E((X - E(X)) (Y - E(Y))^T)
      $
      进一步，定义：
      $
        var(X) = cov(X, X) = (cov(x_i, x_j))_(m times m) \
        = E((X - E(X)) (X - E(X))^T) = E(X X^T) - E(X) E(X)^T
      $
      显然，$var(X)$ 是一个对称矩阵。
    ]
    #lemma[][
      设 $A, B$ 为常数矩阵，则：
      $
      cov(A X, B Y) = A cov(X, Y) B^T\
      cov(X + Y, Z) = cov(X, Z) + cov(Y, Z)\
      cov(X, Y + Z) = cov(X, Y) + cov(X, Z)
      $
      从而 $cov$ 是一个双线性函数。特别的，有：
      $
        var(A X) = A var(X) A^T
      $
    ]
    #theorem[][
      $var(X) >= 0$，等于 $0$ 当且仅当 $X$ 中各变量线性相关
    ]
    #proof[
      $
      c^T var(X) c = c^T cov(X, X) c = cov(c^T X, c^T X) = var(c^T X) >= 0
      $  
      显然等于零当且仅当 $c^T X$ 几乎处处为零。
    ]
    #theorem[][
      设 $A$ 是对称常矩阵，则：
      $
        E(X^T A X) = tr(A var(X)) + E(X)^T A E(X)
      $
      进一步，若 $var(X) = sigma^2 I$（例如 $X$ 是独立同分布的正态随机变量），则上式等于：
      $
        sigma^2 tr(A) + E(X)^T A E(X)
      $
    ]
    #proof[
      $
        E(X^T A X) = E(tr(X^T A X)) = E(tr(A X X^T)) = tr(A E(X X^T)) \
        = tr(A(var(X) + E(X) E(X)^T)) = tr(A var(X)) + E(X)^T A E(X)
      $
    ]
    #example[][
      求：
      $
        E((x_1 - x_2)^2 + (x_2 - x_3)^2 -... - (x_(n - 1) - x_n)^2)
        
      $
      设:
      $
        T = mat(1, -1, 0, ..., 0;0, 1, -1, ..., 0; dots.v, dots.v, dots.v, ..., dots.v;0, ..., 0, 1, -1)
      $
      则：
      $
        E((x_1 - x_2)^2 + (x_2 - x_3)^2 -... - (x_(n - 1) - x_n)^2) \
        = E(x^T T^T T x) = tr(T^T T var(x)) + E(x)^T T^T T E(x)
      $
    ]
    #example[][
      设 $cov(x_i, x_i) = 1, cov(x_i, x_j) = rho$，可以计算得：
      $
        E(sum_(i = 1)^n (x_i - overline(x))^2) = sigma^2 (1 - rho) (n - 1)
      $
    ]
    #definition[矩母函数][
      设 $X$ 为随机变量，则称：
      $
        M_X (t) = E(e^(t^T X))
      $
      为 $X$ 的矩母函数（未必存在）。
    ]
    #definition[特征函数][
      设 $X$ 为随机变量，则称：
      $
        phi_X (t) = E(e^(i t^T X))
      $
      为 $X$ 的特征函数（一定存在）。
    ]
    #theorem[][
      - 若在某个开集上有 $phi_Y = phi_X$，则 $X$ 和 $Y$ 的分布相同。
      - 若 $X, Y$ 独立，则:
        - $phi_(X, Y)(t) = phi_x (t_1) phi_y (t_2)$
        - $phi_(X + Y) (t) = phi_x (t) phi_y (t)$
    ]
    #example[][
      设 $X tilde chi_(k_1)^2, Y tilde chi_(k_2)^2$，则：
      $
        phi_X (t) = (1 - 2 i t)^(- k_1 / 2)\
        phi_Y (t) = (1 - 2 i t)^(- k_2 / 2)
        phi_(X + Y) (t) = (1 - 2 i t)^(- (k_1 + k_2) / 2)
      $
      可见 $chi^2$ 分布具有可加性
    ]
    #definition[多元正态分布][
      称：
      $
        NormalDisN(x, mu, Sigma, n)
      $
      为 $n$ 元正态的分布函数，其中 $Sigma$ 通常是正定矩阵。此时，记：
      $
        Y tilde N(mu, Sigma)
      $
      并且有：
      $
        E Y = mu, var Y = Sigma
      $
      对于标准正态分布，有：
      $
        M_Z (t) = e^(1/2 t^T t)
      $
      因此可以证明：
      $
        M_Y (t) = e^(t^T mu + 1/2 t^T Sigma t)\
        phi_Y (t) = e^(i t^T mu - 1/2 t^T Sigma t)
      $
    ]
    #theorem[][
      设 $Y tilde N(mu, Sigma)$，$C$ 满秩，则：
      $
        C Y + d tilde N(C mu + d, C Sigma C^T)
      $
      特别的，若 $T tilde N(0, 1)$，则：
      $
        C Y + d tilde N(d, C C^T)
      $
    ]
    #proof[
      $
        M_(C Y + d) (t) = E(e^(t^T (C Y + d))) = E(e^((C^T t)^T Y)) e^(t^T d) = e^(t^T (C mu + d) + 1/2 (t^T C Sigma C^T t))
      $
    ] 
    高维正态分布有非常好的性质，$x_i, x_j$ 独立当且仅当 $Sigma$ 的 $i j$ 元为零（协方差为零），非常便于计算。
    #example[][
      假设 $T tilde N(mu, Sigma)$，其中：
      $
        Y = vec(Y_1, Y_2), mu = vec(mu_1, mu_2), Sigma = mat(Sigma_11, Sigma_12; Sigma_21, Sigma_22)
      $
      则：
      $
        Y_1 = (1, 0) Y := B Y
      $
      由上面的结论得：
      $
        Y_1 tilde N(B mu, B Sigma B^T) = N(mu_1, Sigma_1)
      $
      同时，若设 $y_2 = Y_1 | Y_2$，则：
      $
        y_2 tilde N(mu_1 + Sigma_(12) Inv(Sigma_22) (Y_2 - mu_2), Sigma_11 - Sigma_12 Inv(Sigma_22) Sigma_21)
      $
      这是因为若设：
      $
        A = mat(1, - Sigma_12 Inv(Sigma_22);0, 1)
      $
      则：
      $
        u := A (Y - mu) 
      $
      满足 $E u = 0$ 且：
      $
        var mu = A Sigma A^T = mat(
          Sigma_11 - Sigma_12 Inv(Sigma_22) Sigma_21, 0;0, Sigma_22
        )
      $
      这表明 $u_1, u_2$ 相互独立，进而：
      $
        u_1 | u_2 tilde u_1 tilde N(0, Sigma_11 - Sigma_12 Inv(Sigma_22) Sigma_21)\
        ((Y_1 - mu_1) - Sigma_12 Inv(Sigma_22) (Y_2 - mu_2)) | (Y_2 - mu_2) tilde N(0, Sigma_11 - Sigma_12 Inv(Sigma_22) Sigma_21)\
        Y_1 | (Y_2 - mu_2) tilde N(mu_1 + Sigma_12 Inv(Sigma_22) (Y_2 - mu_2), Sigma_11 - Sigma_12 Inv(Sigma_22) Sigma_21)\
        Y_1 | Y_2 tilde N(mu_1 + Sigma_12 Inv(Sigma_22) (Y_2 - mu_2), Sigma_11 - Sigma_12 Inv(Sigma_22) Sigma_21)\
      $
    ]
    #theorem[][
      假设 $Y$ 是 $n$ 维随机变量，期望和方差存在，则它是多元正态分布当且仅当每个分量的任意线性组合都服从正态分布（或者每个一维边缘分布都是正态分布）。
    ]
    #theorem[][
      设 $Y$ 是多元正态的，则 $A Y$ 与 $B Y$ 独立当且仅当：
      $
        cov(A Y, B Y) = A Sigma B^T = 0
      $
    ]
    #example[][
      设 $Y tilde N(mu, sigma^2)$，令：
      $
        approxVar(Y)_n = 1/n sum_i Y_i\
        S_n^2 = 1/(n - 1) sum_i (Y_i - approxVar(Y))^2
      $
      则 $approxVar(Y), S_n^2$ 独立
    ]
    #proof[
      只需证明 $approxVar(Y)$ 与 $Y_i - approxVar(Y)$ 都独立即可。事实上，设：
      $
        I = vec(1, 1, dots.v, 1)\
        W = vec(Y_1 - approxVar(Y), Y_2 - approxVar(Y), dots.v, Y_n - approxVar(Y))
      $
      则有：
      $
        approxVar(Y) = 1/n I^T Y\
        W = Y - 1/n I I^T Y 
      $
      并且：
      $
        cov(approxVar(Y), W) = 1/n^2 I^T (cov(Y, Y) - 1/n cov(Y, Y) I^T I) = 0
      $
      由上面的定理可知它们独立。
    ]
    
    #theorem[][
      设 $Y tilde N(0, 1)$ ，$A$ 对称，幂等，则：
      $
        Y^T A Y tilde chi_(rank(A))^2
      $
    ]
    #proof[
      对 $A$ 做对角化，设：
      $
        A = T^T D T
      $
      则：
      $
        Y^T A Y = (T Y)^T A (T Y)
      $
      同时，$Z := T Y tilde N(0, 1)$，上式形如：
      $
        sum_(i = 1)^r Z_i^2 tilde chi_r^2
      $
      证毕
    ]
    #theorem[][
      设 $Y tilde N(0, 1)$ ，$A$ 对称，则：
      $
        Y^T A Y tilde chi_(r)^2
      $
      当且仅当 $A$ 幂等且 $rank(A) = r$
    ]
    #proof[
      类似的，无妨设 $A$ 是对角矩阵，则：
      $
        M_Y (t) = product_i (1 - 2 d_i t)^(-1/2) = (1 - 2 t)^(-r/2)
      $
    ]
    #example[][
      设 $Y tilde N(mu I, sigma^2 I)$，则：
      $
        ((n - 1) S_n^2) / sigma^2 tilde chi_(n - 1)^2
      $
      事实上，设：
      $
        W = 1/sigma vec(Y_1 - approxVar(Y), Y_2 - approxVar(Y), dots.v, Y_n - approxVar(Y)) = (1 - 1/n I I^T) (Y - mu)/sigma
      $
      则：
      - $(Y - mu)/sigma tilde N(0, 1)$
      - $(1 - 1/n I I^T)$ 幂等，且 $rank(1 - 1/n I I^T) = tr(1 - 1/n I I^T) = n - 1$
      因此 $((n - 1) S_n^2)/sigma^2 = W^T W tilde chi_(n - 1)^2$ 
    ]
    #theorem[][
      设 $Y tilde N(0, 1)$ ，$A$ 对称，且：
      $
        Y^T A Y tilde chi_(r)^2
      $
      则 $Y^T (I - A) Y tilde chi_(n - r)^2$
    ]
    #proof[
      注意到此时一定有 $A$ 幂等，进而 $rank(A) + rank(I - A) = n$，且 $I - A$ 也幂等，结论是显然的
    ]
    #theorem[][
      设 $A, B$ 对称，$Y^T A Y$ 和 $Y^T B Y$ 都服从 $chi^2$ 分布，则它们独立当且仅当 $A B = 0$
    ]<chi-square-indep>
    #proof[
      - 一方面，独立的 $chi^2$ 变量的和还是 $chi^2$ 变量，导出 $A + B$ 幂零，因此 $A B = 0$ 是必要条件
      - 另一方面，假设 $A B = 0$，则有 $A Y$ 与 $B Y$ 独立，当然就有 $norm(A Y) = quadFormSym(Y, A)$ 与 $norm(B Y) = quadFormSym(Y, B)$ 独立。

      // $
      //   phi (t) = E eXi(t_1 Y^T A Y + t_2 Y^T B Y) = E eXi((Y^T (t_1 A + t_2 B) Y))
      // $
      // - 注意到：
      //   $
      //     Y^T B Y = (B Y)^T B Y < x^2 <=> norm(B Y) < x\
      //     Y^T A Y = (A Y)^T A Y < x^2 <=> norm(A Y) < x
      //   $
      //   若 $A B != 0$，则存在 $X$ 使得 $A B u != 0$. 由线性代数知识，将存在 $v$ 使得 $A v = B u != 0$. 此时，若 $x < norm(A v), y > norm(A v)$，记：
      //   $
      //     S_1 = {Y | norm(B Y) < x}\
      //     S_2 = {Y | norm(A Y) < y} 
      //   $
      //   则 $u in.not S_1, v in S_2$. 设 $u in B$ 是一小开球且 $B subset.not S_1, Inv(A) (B) subset S_2$. 这将导致 $Inv(A) (B)$ 是 $Y^T A Y < y^2$ 的可行区域，但不是 $Y^T A Y < y^2 | Y^T B Y < x^2$ 的可行区域，矛盾！
    ]
    #example[][
      设 $Y tilde N(theta, sigma^2 I), P_i$ 对称，$Q_i = 1/sigma (Y - theta)^T P_i (Y- theta)$. 若 $Q_i tilde chi_(r_i)^2 and Q_1 - Q_2 >= 0$，则 $Q_1 - Q_2 $ 和 $Q_2$ 是独立服从 $chi_(r_1 - r_2)^2$ 和 $chi_(r_2)^2$ 的随机变量
    ]
    #proof[
      注意到：
      $
        Q_1 - Q_2 = 1/sigma (Y - theta)^T (P_1 - P_2) (Y - theta)
      $
      由条件，$P_1 - P_2 >= 0$. 同时：
      $
        (P_1 - P_2)^2 = P_1 + P_2 - P_1 P_2 - P_2 P_1 
      $
      断言 $P_2 P_1 = P_2$，这是因为假设 $P_2 (I - P_1) x != 0$，则有：
      $
        x in.not im P_1 => x in ker P_1\
        x in.not ker P_2
      $
      从而：
      $
        x^T (P_1 - P_2) x = - x^T P_2 x < 0
      $
      矛盾！

      进而 $P_2 = P_2^T = P_1^T P_2^T = P_1 P_2$，因此 $P_1 - P_2$ 是幂等矩阵，且：
      $
        rank(P_1 - P_2) = tr(P_1) - tr(P_2) = rank(P_1) - rank(P_2) 
      $
      同时，$(P_1 - P_2) P_2 = 0$，上面的定理给出它们独立
    ]
    #theorem[][
      设 $Y tilde N(0, Sigma), A$ 是对称矩阵，则 $Y^T A Y$ 是 $chi_r^2$ 分布当且仅当 $A Sigma$ 恰有 $r$ 个 $1$ 作为特征值，其余均为零
    ]
    #proof[

      - 假设 $Y^T A Y$ 满足条件，设 $Sigma = R R^T$（$R$ 未必是方阵）。取标准正态变量 $Z$，则 $R Z$ 与 $Y$ 同分布，进而 $(R Z)^T A (R Z) tilde chi^2_r$，由之前的定理知 $R^T A R$ 幂等，秩为 $r$. 熟知 $R^T A R$ 与 $A R R^T = A Sigma$ 有相同的非零特征值，并且 $tr(R^T A R) = tr(A R R^T)$ 因此 $1$ 特征值的数量也相等，结论成立。
      - 反之，由于 $R^T A R$ 特征值仅有 $0, 1$，当然幂等，其余推理是类似的。
    ]
    #corollary[][
      设 $Y tilde N(mu, Sigma), Sigma > 0$，则 $(Y - mu)^T Inv(Sigma) (Y - mu) tilde chi_n^2$
    ]<chi-square-cond>
= 最小二乘法
  #let proj(X) = $#X Inv(tMul(#X))#X^T$
  #let RSS = "RSS"
  给定模型：
  $
    Y = X beta + epsilon
  $
  目标是估计其中的 $beta$. 定义：
  $
    RSS(beta) = norm(Y - X beta)^2
  $
  为残差。我们希望它达到极小，也就是计算：
  $
    hat(beta) = argmin_beta RSS(beta)
  $
  事实上，${beta | X beta}$ 是一线性空间，最小取值当然就是正交投影，也即：
  $
    X^T (Y - X beta) = 0\
    X^T X beta = X^T Y
  $
  该方程通常被称为正则化方程。线性代数知识可以证明它一定有解，当然解未必唯一。若 $X$ 满秩，则上述方程有唯一解。

  == $beta$ 的估计
    若 $X$ 满秩 $r$，则取：
    $
      P = X (X^T X)^(-1) X^T
    $<P-def>
    可以验证 $P$ 就是将向量投影到 $X$ 空间的投影算子（显然是幂等/对称的，且秩就是 $X$ 的秩）。令 $hat(Y) = X hat(beta) = P Y, e = Y - hat(Y)$，则残差：
    $
      RSS = norm(e)^2 = (Y - P Y)^T (Y - P Y) = norm(Y)^2 - norm(hat(Y))^2
    $
    同时，不难发现：
    $
      E(hat(beta)) = E((X^T X) X^T Y) = (X^T X) X^T E Y = (X^T X) X^T X beta = beta\
    $
    进而，如果假设 $var(epsilon) = sigma^2 I$，则：
    $
      var(hat(beta)) = Inv((X^T X)) X^T var(Y) X Inv((X^T X)) = sigma^2 Inv((X^T X))
    $
    #theorem[][
      设 $hat(theta)$ 是最小二乘估计，假设 $theta = X beta, $, $X$ 未必满秩。对于任意 $c in RR^n$，任意线性函数 $A$， $A c$ 是 $c^T theta$ 的无偏估计，则 $var (A c) >= var(c^T theta)$。换言之，$c^T theta$ 是最好的线性无偏估计（best linear unbiased estimator, BLUE）。
    ]
    #proof[
      取 $P$ 是某个线性投影算子，则：
      $
        E(hat(theta)) = P E Y = P X beta = X beta = theta
      $
      当然 $c^T hat(theta)$ 是无偏的估计，也是线性的估计。

      进一步，假设 $d^T Y$ 是一个 $c^T theta$ 的无偏线性估计，有：
      $
        c^T theta = E(d^T Y) = d^T E Y = d^T theta\
        (c - d)^T X = 0 => P(c - d) = 0 => P c = P d
      $
      因此：
      $
        var (d^T Y) - var(c^T hat(theta))\
        = sigma^2 d^T d - sigma^2 (P c)^T (P c)\
        = sigma^2 d^T d - sigma^2 (P d)^T (P d)\
        = sigma^2 d^T (I - P) d >= 0
      $
      若等号成立，则：
      $
        (I - P) d = 0, d = P d = P c, d^T Y = c^T P Y = c^T hat(theta)
      $
    ]
    #remark[][
      上面定理的限定条件很多。例如假如我们不要求无偏，可能能找到方差更小的估计。
    ]
  == $epsilon$ 的 RSS 估计
    接下来，我们考虑对 $epsilon$ 的估计。注意到：
    $
      epsilon = Y - X beta = Y - P Y = (I - P) Y
    $
    假设 $epsilon$ 的每个分量是独立同分布的（暂时不假设正态分布），则 $sigma^2 = E(1/n sumBrN1(epsilon_i^2))$，我们自然会考虑 $norm(Y - P Y)^2$ 是否能作为估计值。事实上，可以计算得到：
    $
      E(Y - P Y)^2 = E (quadFormSym(Y, I - P))\
      = tr((I - P) Sigma) + quadFormSym(X beta, I - P)\
      = tr((I - P) sigma^2 I)\
      = sigma^2 rank(I - P)
    $
    若设 $r = rank(X)$，最终上式就是 $(n - r) sigma^2$，很自然的：
    #theorem[][
      $
        S_n^2 &:= 1/(n - r) norm(Y - htheta)^2\
              &= 1/(n - r) sumBrN1((Y_i - htheta_i)^2)\
              &= 1/(n - r) "RSS"\
      $
      就是 $sigma^2$ 的无偏估计。
    ]
    一个很重要的话题是，$S_n^2$ 是不是最优的估计值？一般来说可以证明，假设 $epsilon_i$ 的分布满足 $mu_4 = 3 sigma^4$，则 $S_n^2$ 是最优的。

    之后，我们假设 $epsilon$ 是正态的，我们考虑估计量的概率分布：
    - 显然有 $Y tilde N(X beta, sigma^2 I)$
    - $hat(beta) = Inv(tMul(X)) X^T Y tilde N(beta, sigma^2 Inv(tMul(X)) X^T)$
    - 由 @chi-square-cond，有：
      $
        quadFormSym(hat(beta) - beta, Inv(sigma^2 Inv(tMul(X)) X^T)) tilde chi_r^2
      $
    - 类似的：
      $
        ((n - r)S_n^2)/sigma^2 tilde chi_(n - r)^2
      $
    #lemma[][
      $tilde(epsilon) = Y - hat(theta) = (I - P) Y$ 与 $hat(beta) = Inv(tMul(X)) X^T Y$ 相互独立。进而 $hat(beta)$ 与 $S_n^2$ 独立。
    ]
    #proof[
      只需验证协方差为零即可。（注意到 $P$ 有表达@P-def）
    ]
  == 极大似然估计
    另一种经典的估计方法就是极大似然估计：
    $
      L(beta, sigma^2) = NormalDisN(Y, X beta, sigma^2 I, n)\
      ln L = - n/2 ln (w pi) - n/2 ln sigma^2 - 1/(2 sigma^2) norm(Y - X beta)^2
    $
    求导得：
    $
      partialDer(L, beta) = 1/sigma^2 X^T (Y - X beta) = 0\
      partialDer(L, sigma^2) = - n/2 1/sigma^2 + 1/(2 sigma^4) norm(Y - X beta)^2 = 0
    $
    #definition[Fisher 信息][
      设有极大似然函数 $L$，则称：
      $
        E (partialDerN(L, theta, 2))
      $
      为 Fisher 信息。
    ]
    在该问题的情形下，Fisher 信息事实上就是：
    $
      mat(1/sigma^2 tMul(X), 0;0, n/(2 sigma^4))
    $
    可以证明，最大似然函数在 $n -> +infinity$ 的意义上可以达到 C-R bound，因此是一定意义下方差最小的估计。
  == forward-stagewise regression
    有些时候，我们会遇到这样的问题：先根据一部分数据得到了估计值：
    $
      Y = X beta + epsilon
    $
    之后，数据多了一部分，希望找到更好的估计：
    $
      Y = X beta + Z delta + epsilon
    $
    如果假设 $X$ 的列向量都是正交的，将这些列向量记为 $x_i$，可以计算得：
    $
      hat(beta) = Inv(tMul(X))X^T Y\
      hat(beta)_j = inner(x_j ,Y)/inner(x_j, x_j)
    $
    可以发现，$hat(beta)_j$ 其实只和 $x_j$ 有关，我们可以按照下面的方式逐个更新：
    - 先只考虑 $x_0$，有：
      $
        hat(beta)_0 = inner(x_0, Y)/inner(x_0, x_0)\
        e^1 = Y - x_0 hat(beta)_0
      $
    - 再考虑 $x_1$，有：
      $
        hat(beta)_1 = inner(x_1, Y)/inner(x_1, x_1) = inner(x_1, Y - x_0 hat(beta)_0)/inner(x_1, x_1) = inner(x_1, e^1)/inner(x_1, x_1)\
        e^2 = e^1 - hat(beta)_1 x_1
      $
    - 该过程可以一直进行，每次只需要关于之前的残差做更新即可
    该方法称为 forward-stagewise regression。当然，这个方法一次只更新一个向量，当然也可以一次更新多个向量，方法是类似的。

    一般情形下，假设有问题：
    $
      Y = (X, Z) vec(beta, gamma) + epsilon := W delta + epsilon
    $
    其中 $X, Z$ 分别是 $p, t$ 列满秩。如果之前已经做过只含 $X, beta$ 的估计，有：
    $
      hat(beta) = Inv(tMul(X)) X^T Y
    $
    同时，新模型的估计应该是：
    $
      hat(delta) = Inv(tMul(W)) W^T Y
    $
    如果假设 $X, Z$ 的列向量互相正交，就有：
    $
      tMul(W) = mat(tMul(X), 0;0, tMul(Z))
    $
    立刻可以计算得：
    $
      hat(delta) = Inv(tMul(X)) Y, Inv(tMul(Z)) Y)
    $
    一般的，设 $P$ 是 $X$ 列空间的投影算子，可以做分解：
    $
      Z = (I - P) Z + P Z
    $
    其中 $(I - P) Z$ 的列空间与 $X$ 的列空间正交，因此：
    $
      X beta + Z gamma = X beta + P Z gamma + (I - P) Z gamma\
      = X beta + proj(X) Z gamma + (I - P) Z gamma\
      = X(beta + Inv(tMul(X)) X^T Z gamma) + (I - P) Z gamma
    $ 
    令 $alpha := beta + Inv(tMul(X)) X^T Z gamma$，利用上面的结果可以得到：
    $
      hat(alpha) = Inv(tMul(X)) X^T Y\
      hat(gamma) = Inv(tMul((I - P) Z)) Z^T (I - P)^T Y\
      = Inv(quadFormSym(Z, I - P)) Z^T (I - P)^T Y
    $
    根据表达式反推得到 $beta$ 的估计值：
    $
      hat(beta) = hat(alpha) - Inv(tMul(X)) X^T Z hat(gamma)\
      = Inv(tMul(X)) X^T (Y - Z hat(gamma))
    $
    类似于先在 $(I - P) Z$ 做回归，再对残差关于 $X$ 做回归。

    如果用 $hat(beta)$ 记小模型的估计值，则大模型的残差为：
    $
      norm(Y - X hat(alpha) - (I - P) Z hat(gamma))^2 &= norm(Y - X hat(beta))^2 + norm((I - P) Z hat(gamma))^2 -2 inner(Y - X hat(beta), (I - P) Z hat(gamma))\
      &= norm(Y - X hat(beta))^2 + norm((I - P) Z hat(gamma))^2 -2 inner((I - P) Y, (I - P) Z hat(gamma))\
      &= norm(Y - X hat(beta))^2 + inner((I - P) Z hat(gamma), (I - P) Z hat(gamma)) -2 inner(Y, (I - P) Z hat(gamma))\
      &= norm(Y - X hat(beta))^2 + inner(Y, (I - P) Z hat(gamma)) -2 inner(Y, (I - P) Z hat(gamma))\
      &= norm(Y - X hat(beta))^2 - inner(Y, (I - P) Z hat(gamma))\
      &= quadFormSym(Y - Z hat(gamma), I - P)
    $
    以及可以计算方差：
    $
      var(hat(delta)) = var(Inv(mat(I, L;0, I)) vec(hat(alpha), hat(gamma)))
    $
    而 $alpha, gamma$ 是相互正交的的，其方差为：
    $
      var(vec(hat(alpha), hat(gamma))) = sigma^2 mat(Inv(tMul(X)), 0;0, Inv(quadFormSym(Z, I - P)))
    $
    因此：
    $
      var(hat(delta)) = sigma^2 Inv(A) mat(Inv(tMul(X)), 0;0, Inv(quadFormSym(Z, I - P))) (Inv(A))^T\
      = sigma^2 mat(Inv(tMul(X)) + L M L^T, -L M; - M^T L, M)
    $
    其中 $M = Inv(quadFormSym(Z, I - P)), L = Inv(tMul(X)) X^T Z$

    特别的，假设只加入一个参数 $beta_p$，则由上面的公式有：
    $
      hat(beta)_p = quadFormSym(Z, I - P) Z^T (I - P) Y\
      = quadForm(x_p, I - P, Y)/quadFormSym(x_p, I - P)
    $
    而其余的参数：
    $
      hat(beta)' = hat(beta) - Inv(tMul(X)) X^T x_p hat(beta)_p\
    $
  == 带约束的线性回归
    #let hb = $hat(beta)$
    #let hb0 = $hat(beta)_0$
    有时，我们会在线性回归的基础上添加额外的形如 $A beta = c$ 的线性条件。假设 $A$ 可逆，则可以解出 $beta = Inv(A) c$，再代入回归方程，但这样的操作相对麻烦，与全局情形也不统一。因此，我们直接考虑如下的优化问题：
    $
      min norm(Y - X beta)^2, suchThat A beta = c
    $
    使用拉格朗日乘子法：
    $
      L = norm(Y - X beta)^2 + lambda^T (A beta - c)\
      partialDer(L, beta) = - 2 X^T (Y - X beta) + A^T lambda = 0\
      A beta = c
    $
    解出：
    $
      hat(beta) = Inv(tMul(X)) (X^T Y - 1/2 A lambda) = hat(beta)_0 - 1/2 Inv(tMul(X)) A^T lambda\
      - 1/2 lambda = Inv(A Inv(tMul(X)) A^T) (A hat(beta)_0 - c)
    $
    其中 $hat(beta)_0$ 是不带约束条件的最小二乘估计。从形式上可以看出，它相当于对原有的最小二乘估计做出修正。

    同时，注意到：
    $
      norm(Y - X beta)^2 = norm(Y - X hat(beta)_0)^2 + norm(X hat(beta)_0 - X beta)^2
    $
    其中：
    $
      norm(X hat(beta)_0 - X beta)^2 &= norm(X(hb - hb0))^2 + 2 (hb0 - hb)^T tMul(X) (hb - beta) + norm(X (hb0 - beta))^2\
      &=  norm(X(hb - hb0))^2 + norm2(X (hb0 - beta)) + lambda^T A Inv(tMul(X)) tMul(X)  (hb - beta)\ 
      &=  norm(X(hb - hb0))^2 + norm2(X (hb0 - beta)) + lambda^T A (hb - beta)\ 
      &=  norm(X(hb - hb0))^2 + norm2(X (hb0 - beta)) + lambda^T (c - c)\ 
      &=  norm(X(hb - hb0))^2 + norm2(X (hb0 - beta))\ 
    $
    可见，$hb$ 确实是原问题的最优解。同时，也得到：
    $
      norm(Y - X hb)^2 = norm(Y - X hb)^2 + norm(X (hb0 - hb))^2
    $
  == 不满秩情形的最小二乘
    #definition[广义逆矩阵][
      称 $gInv(A)$ 是 $A$ 的广义逆矩阵，如果它满足：
      $
        A gInv(A) A = A
      $
    ]
    #lemma[][
      线性方程 $A X = Y$ （若有解）的解总可以写作：
      $
        X = gInv(A) Y 
      $
    ]
    #proof[
      设 $X_0$ 是解，则：
      $
        Y = A X_0 = A gInv(A) A X_0 = A gInv(A) Y
      $
      - 一方面，假设 $X = gInv(A) Y$，则：
        $
          A X = A gInv(A) Y = A Y
        $
      - 另一方面略    
    ]
    #definition[][
      假设 $gInv(A)$ 还满足：
      - $gInv(A) A gInv(A) = gInv(A)$
      - $(A gInv(A))^T = A gInv(A)$
      - $(gInv(A) A)^T = gInv(A) A$
      则 $gInv(A)$ 是唯一的，称为 Moore-Penrose 逆，记作 $MPInv(A)$，可以证明它是唯一的。
    ]
    #example[][
      - 设 $D$ 是对角阵，则将其所有非零对角元取逆即是 $D$ 的 Moore-Penrose 逆
      - 假设 $B$ 可以写作：
        $
          B = mat(B_11, B_12; B_21, B_22)
        $
        其中 $B_11$ 满秩，秩恰为 $B$ 的秩，则令：
        $
          V = mat(Inv(B_11), 0;0, 0) 
        $  
        计算得：
        $
          B V B = mat(B_11, B_12; B_21, B_21 Inv(B_11) B_12) 
        $
        考虑 $B$ 的行变换及秩关系可得 $B_21 Inv(B_11) B_12 = B_22$，因此 $V$ 是广义逆。
    ]
    假设 $X$ 不满秩，则 $beta$ 仍然存在但不再唯一。此时它仍然满足方程：
    $
      tMul(X) beta = X^T Y
    $
    往往使用广义逆（注意广义逆不唯一）写作：
    $
      hb = gInv(tMul(X)) X^T Y
    $

    当然，$X$ 不满秩时存在无穷多个 $beta$ 使得 $X beta$ 相等，因此 $beta$ 是不可估计的，但投影 $P$ 仍然是唯一的，$P Y = htheta$ 也是唯一的。
    #definition[][
      称 $a^T beta$ 是可估计的，如果存在 $b$ 使得 $b^T Y$ 是 $a^T beta$ 的无偏估计。换言之：
      $
        a^T beta = E(b^T Y) = b^T E(Y) = b^T X beta
      $
      由 $beta$ 的任意性，有：
      $
        a = X^T b
      $
      事实上，$a^T beta$ 可估计当且仅当 $a in im X^T$
    ]
  == 其他情形
    假设 $var(epsilon) = sigma^2 V$，可以做如下处理：
    - $V = K K^T$
    - $Inv(K) Y = Inv(K) X beta + Inv(K) epsilon$
    由于 $var(Inv(K) epsilon) = sigma^2 I$，因此可以使用通常的方法估计。这个结果也等价于对 $beta$ 做最大似然估计。

    此外，处理时我们往往会做中心化，也就是将数据各个分量减均值除标准差。这样在计算上会比较稳定，同时也保证不同维度的尺度一致。
= 假设检验
  == 满秩情形
    #let hsigma = $hat(sigma)$
    #let hY = $hat(Y)$
    给定模型 $Y = X beta + epsilon$，其中 $X$ 列满秩，$epsilon$ 服从 $N(0, sigma^2 I)$. 我们有时会关心某个条件是否成立，也即：
    $
      H: A_(q times p) beta = C
    $
    一种标准的方法是，比较承认假设和不承认时的极大似然估计，计算得：
    $
      Lambda = L' / L = (hat(sigma)^2/hat(sigma)_H^2)^(n / 2)
    $
    其中：
    $
      n hsigma^2 = norm2(Y - P Y)\
      n hsigma_H^2 = norm2(Y - P_H Y)
    $
    因此：
    $
      hsigma^2_H / hsigma^2 - 1 = (norm2(Y - P_H Y) - norm2(Y - P Y)) / norm2(Y - P Y) = norm2(P_H Y - P Y) / norm2(Y - P Y) 
    $
    #let RSSd = $"RSS"_H - "RSS"$
    #let BX = $A Inv(tMul(X)) A^T$
    可以使用上节结论得到：
    #theorem[][
      $
        RSSd = norm2(P_H Y - P Y) = quadFormSym(A hbeta - c, Inv(A Inv(tMul(X)) A^T) )
      $
    ]
    同时，注意到如果 $A beta = c$ 成立，则：
    $
      Z := A hat(beta) tilde N(A beta - c, sigma^2 A Inv(tMul(X)) A^T) = N(0, sigma^2 A Inv(tMul(X)) A^T)
    $
    进而：
    $
      RSSd / sigma^2 tilde chi_(q)^2
    $
    然而通常 $sigma$ 是未知的，不能采用该式作为假设检验。同时，即使假设不成立，也有：
    #theorem[][
      $
        E (RSSd) = E quadFormSym(Z, Inv(BX)) \
        = tr(Inv(BX) var Z) + quadFormSym(A beta - c, Inv(BX))
      $
    ]
    #theorem[][
      若设：
      $
        F := (RSSd / q) / (RSS / (n - p))
      $
      当假设成立时，有：
      $
        F tilde F_(q, (n - p))
      $
    ]
    #proof[
      前面证明了：
      - $1/sigma^2 RSSd / q tilde chi^2_q$
      - $1/sigma^2 RSSd / (n - p) tilde chi^2_(n - p)$
      只需证明他们独立即可。注意到：
      - $RSS = quadFormSym(Y, I - P)$
      - $RSSd = quadFormSym(Y, P - P_H)$
      而 $(I - P)(P - P_H) = P - P - P_H + P P_H$，注意到 $P_H$ 是 $P$ 投影的一部分，因此 $P P_H = P_H$，上式等于零，由 @chi-square-indep 即可得证。
    ]
    因此，上面的 $F$ 便可作为假设检验问题的统计量。
    #corollary[][
      $
        F = (n - p)/q quadFormSym(Y, P - P_H)/quadFormSym(Y, I - P)
      $
    ]
    #example[][
      给定模型：
      $
        Y = beta_0 + beta_1 x_1 + beta_2 x_2 + ... + beta_(p - 1) x_(p - 1) + epsilon
      $
      检验假设 $H : beta_j = c, j > 0$，它也形如 $a^T beta = c$

      若假设：
      $
        Inv(tMul(X)) = mat(l, m^T;m, D)
      $
      则：
      $
        quadFormSym(a, Inv(tMul(X))) = D_(j j)\
        a^T hbeta = hat(beta)_j\
        RSSd = (hbeta_j - c)^2 / D_(j j)
      $
      因此：
      $
        F = (hbeta_j - c)^2/(D_(j j))/(RSS / (n - p)) = (hbeta_j - c)^2/(S^2 d_(j j)) tilde F_(1, n - p) = t^2_(n - p)
      $

      一般的，对于任意形如 $a^T beta = c$ 的假设，可以得到：
      $
        F = 1/sigma^2 (a^T hbeta - c)^2 / (a^T Inv(tMul(X)) a) tilde F_(1, n - p)
      $

      注意大到，此时有：
      $
        a^T hbeta tilde N(0, sigma^2 a^T Inv(tMul(X)) a)
      $
      而 $S^2 orthogonal hbeta$，因此：
      $
        (a^T hbeta - c) / sqrt(sigma^2 a^T Inv(tMul(X)) a) tilde N(0, 1)
      $ 
      进而：
      $
        U := (a^T hbeta - c) / sqrt(S^2 a^T Inv(tMul(X)) a) tilde t_(n - p)
      $
    ]
    #example[][
      最简单的情形，假设：
      $
        Y = beta_0 + beta_1 x + epsilon \
        H: beta_1 = c
      $
      则：
      $
        hbeta_0 = overline(Y) - hbeta_1 Xbar\
        hbeta_1 = (sumBrN1((Y_i - overline(Y))(X_i - Xbar)))/(sumBrN1((X_i - Xbar)^2))
      $
      可以计算得：
      $
        F = (hbeta_1 - c)^2/(S^2/(sumBrN1((X_i - Xbar)^2))) tilde F_(1, n - 2)
      $
      以及：
      $
        (n - 2)S^2 = sumBrN1((Y_i - overline(Y))^2) - hbeta_1 sumBrN1((X_i - Xbar)^2) = sumBrN1(Y_i - overline(Y))^2 - sumBrN1(hat(Y)_i - overline(Y))
      $
      同时：
      $
        (n - 2) S^2 = sumBrN1((Y_i - hat(Y)_i)^2)
      $
      因此还可以得到等式：
      $
        sumBrN1(Y_i - overline(Y))^2 = sumBrN1((Y_i - hat(Y)_i)^2) + sumBrN1(hat(Y)_i - overline(Y))
      $
      往往记：
      $
        r^2 = (sumBrN1((hat(Y)_i - overline(Y))^2))/(sumBrN1((Y_i - overline(Y))^2)) = (hbeta_1^2 sumBrN1((x_i - Xbar)))/(sumBrN1((Y_i - overline(Y))^2)) = (sumBrN1((Y_i - overline(Y))(X_i - Xbar)))^2/(sumBrN1((Y_i - overline(Y))^2) sumBrN1((X_i - Xbar)^2))
      $
      就有：
      $
        RSS = (1 - r^2) sumBrN1((Y_i - overline(Y))^2)
      $
      显然 $r^2 = 1$ 时，$RSS = 0$，表明模型完全拟合。此外，如果假设就是 $beta_1 = 0$ 可以计算得：
      $
        F = (n - 2) r^2 / (1 - r^2)
      $
      说明 $r$ 可以判断 $X, Y$ 的线性相关性。
      // $
      //   sumBrN1((Y_i - hat(Y)_i)(hat(Y_i) - overline(Y))) = sumBrN1((Y_i - overline(Y)) hat(Y)_i) - n overline(Y)^2
      // $
    ]
    事实上，在一元情形下，还有：
    $
      hat(Y) = Ybar + hbeta_1 (X - Xbar)
    $
    因此：
    $
      r = (sumBrN1((Y_i - Ybar)(X_i - Xbar)))/sqrt(sumBrN1((Y_i - Ybar)^2) sumBrN1((X_i - Xbar)^2)) = (hbeta sumBrN1((Y_i - Ybar)(X_i - Xbar)))/sqrt(hbeta^2 sumBrN1((Y_i - Ybar)^2) sumBrN1((X_i - Xbar)^2))\
      = (sumBrN1((Y_i - Ybar)(hat(Y) - Ybar)))/sqrt(sumBrN1((Y_i - Ybar)^2) sumBrN1((hat(Y) - Ybar)^2)) = cor(Y, hat(Y))
    $
    #definition[coefficient of determination][
      定义：
      $
        R^2 = cor(Y, hat(Y))^2 
      $
      是真实值 $Y$ 与预测值 $hat(Y)$ 的相关系数的平方。下面将证明它也是预测值的方差占原始方差的比例，在实际统计实践中经常用到。
    ]
    #theorem[][
      一元线性回归问题中，有：
      $
        r = cor(X, Y) = cor(Y, hat(Y)) = R
      $
    ]
    #theorem[][
      通常线性回归中，有：
      - 
        $
        sumBrN1((Y_i - Ybar)^2) = sumBrN1((Y_i - hY_i)^2) + sumBrN1((hY_i - Ybar)^2)
        $
      - 
        $
        sumi((Y_i - Ybar) (hY_i - Ybar)) = sum2(hY_i - Ybar)
        $
      - 
        $
          R^2 = = sumBrN1((hat(Y)_i - Ybar)^2)/sumBrN1((Y_i - Ybar)^2) = 1 - RSS/sumi2n2(Y_i - Ybar)
        $
    ]
    #proof[
      通常，有：
      $
        hY = P Y
      $
      令 $P_1$ 是到 $span(1_n)$ 的投影，有：
      $
        Ybar 1_n = P_1 Y
      $
      我们有：
      $
        sum2(Y_i - Ybar) = inner(Y - P_1 Y, Y - P_1 Y) = quadFormSym(Y, I - P_1) = quadFormSym(Y, I - P + P - P_1)\
        = norm2((I - P) Y) + norm2((P - P_1) Y) = sum2(Y_i - hY_i) + sum2(hY_i - Ybar)
      $
      因此第一个等式成立。对于第二个等式，有：
      $
        sumi((Y_i - Ybar) (hY_i - Ybar)) 
        &= inner(Y - P_1 Y, P Y - P_1 Y) \
        &= inner((I - P_1) Y, (P - P_1) Y) \
        &= inner((I - P + P - P_1) Y,  (P - P_1) Y)\
        &= inner((I - P + P - P_1) Y,  (P - P_1) Y)\
        &= inner((I - P) Y,  (P - P_1) Y) + inner((P - P_1) Y,  (P - P_1) Y)\
        &= inner(Y, (I - P) (P - P_1) Y) + inner((P - P_1) Y,  (P - P_1) Y)\
        &= inner((P - P_1) Y,  (P - P_1) Y)\
        &= sum2(hY_i - Ybar)
      $

      将前两个等式代入 $R^2$ 定义就是第三个等式。
    ]
    #example[][
      设有模型：
      $
        Y = beta_0 + beta_1 x_1 + ... + epsilon
      $
      希望检验假设：
      $
        H : beta_1 = beta_2 = .. = beta_(p - 1) = 0
      $
      它形如：
      $
        H : I_((p - 1) times p) beta = 0
      $
      假设成立时显然 $RSS_H = sum2(Y_i - Ybar)$，我们有：
      $
        F = (RSS_H - RSS)/(p - 1) / (RSS / (n - p)) tilde F_(p - 1, n - p)
      $
      同时：
      $
        F &= (n - p)/(p - 1) (sum2(Y - Ybar) - sum2(Y_i - hY_i))/RSS\ 
        &= (n - p)/(p - 1) (sum2(Y - Ybar) - (1 - R^2) sum2(Y_i - Ybar))/((1 - R^2) sum2(Y_i - Ybar))\
        &= (n - p)/(p - 1) R^2/(1 - R^2)\
      $
      显然，$R$ 较小时，更有道理接受原假设，也就是表明数据之间的线性关系较弱。
    ]
  == 非满秩情形
    假设 $X$ 不满秩，我们也可以做类似的假设检验。先假设：
    $
      H : A beta = 0
    $
    则它等价于：
    $
      beta in ker A <=> theta = X beta in X ker A := omega
    $
    则假设成立时最优的当然就是 $P_omega Y$，因此往往使用等价的假设：
    $
      H : theta in omega
    $
    其中 $omega$ 是某个子空间。当然，有 $theta = P_omega Y$
    // 不过，此时我们往往更加关心形如：
    // $
    //   H : theta = P Y in omega
    // $
    // 其中 $omega$ 是某个子空间
    #definition[][
      定义：
      $
        F = (RSS_H - RSS)/q / (RSS / (n - r)) = (quadFormSym(Y, I - P_omega) - quadFormSym(Y, I - P))/q / (quadFormSym(Y, I - P) / (n - r))
      $
      其中 $r$ 是 $X$ 的秩，$q = r - rank(omega)$
    ]
    #theorem[][
      $
        F tilde F_(q, n - r)
      $
    ]
    $
      beta in omega_A
      X beta in X omega_A
    $
    #proof[
      可以证明：
      $
        F = (quadFormSym(epsilon, P - P_omega))/q / (quadFormSym(epsilon, I - P) / (n - r))
      $
      同时：
      $
        rank(P - P_omega) = tr(P) - tr(P_omega) = q
      $
      分子分母的独立性也是容易的。
    ]
= 多重检验问题 
  任取向量 $a_j$，我们希望给出一个 $a_j^T beta$ 的置信区间。熟知：
  $
    a_j^T hbeta tilde N(a_j^T beta, a_j^T sigma^2 Inv(tMul(X)) a_j)
  $
  因此：
  $
    (a_j^T hbeta - a_j^T beta)/sqrt(a_j^T sigma^2 Inv(tMul(X)) a_j) tilde N(0, 1)
  $
  然而 $sigma$ 未知，使用 $S^2 = RSS/(n - p)$ 代替 $sigma^2$，有：
  $
    (a_j^T hbeta - a_j^T beta)/sqrt(a_j^T S^2 Inv(tMul(X))) tilde t_(n - p)
  $
  因此，置信区间为：
  $
    (a_j^T hbeta - a_j^T beta)/sqrt(a_j^T S^2 Inv(tMul(X))) in [-t_(n - p)^(alpha/2), t_(n - p)^(alpha/2)]
  $
  然而，有时我们要同时对多个 $a_j$ 讨论置信区间，也就是希望：
  $
    P(product (a_j^T hat(beta) in I_j)) >= 1- alpha 
  $
  然而熟知：
  $
    P(product (a_j^T hat(beta) in I_j)) >= 1 - sum P(a_j^T hat(beta) in.not I_j) >= 1 - k alpha
  $
  因此每个独立构造置信区间是低效的。

  类似的，有时我们同时给出 $k$ 个假设。当假设全部成立时，我们也会平均错误的拒绝约 $k alpha$ 个假设。
  
  直观上，我们应该总体控制错误率。在置信区间问题中，设：
  $
    E_j = {a_j^T hbeta in I_j}
  $
  目标是控制总体的：
  $
    P(prodj1n(E_j)) >= 1 - alpha
  $
  其中 $P(prodj1n(E_j))$ 被称为 family error rate。最保守的方法是，对每个 $j$ 使用 $1 - alpha/n$ 的置信区间，这样总体的 family error rate 就是 $alpha$。这个置信区间被称为 Bonferron 置信区间，这个方法称为 Bonferron 方法。当然，这个方法往往过于的保守。

  另一种方法是 Scheffe method，首先设 $A = autoVecN(a^T, n), rank(A) = d$，则：
  $
    A hbeta - A beta tilde N(0, A sigma^2 Inv(tMul(X)) A^T)
  $
  因此可以验证：
  $
    (quadFormSym(A hbeta - A beta, Inv(A Inv(tMul(X)) A^T)))/(d S^2)
  $
  服从 $F_(d, (n - r))$
  #lemma[][
    设 $L$ 正定，则：
    $
      sup_h (h^T b)^2/(quadFormSym(h, L)) = quadFormSym(b, Inv(L))
    $
  ]
  因此：
  $
    1 - alpha 
    &= P(quadFormSym(A hbeta - A beta, Inv(A Inv(tMul(X)) A^T)) <= d S^2 F_(d, n- p)^alpha) \
    &= P(sup_h (h^T (A hbeta - A beta))^2/(quadFormSym(h,(A Inv(tMul(X)) A^T))) <= d S^2 F_(d, n- p)^alpha)\
    &= P(forall h, (h^T (A hbeta - A beta))^2 <= d S^2 F_(d, n- p)^alpha quadFormSym(h,(A Inv(tMul(X)) A^T)))\
    &= P(forall h, abs(h^T (A hbeta - A beta)) <= sqrt(d S^2 F_(d, n- p)^alpha quadFormSym(h,(A Inv(tMul(X)) A^T))))\
  $
  注意到其中 $h$ 是任意的，只需分别代入 $h = e_j$ 就可以得到所有的置信区间。

  更现代的办法是，控制 False discovery rate，也就是要求 $E_j$ 中出错的比例不超过 $alpha$，这里不再介绍。
= 多项式回归
  有些时候，线性模型并不能很好的拟合数据，这时我们可以考虑非线性模型，也就是：
  $
    E(Y | X) = f(X)
  $
  如果取 $f$ 是多项式，可以转换为线性模型：
  $
    Y = X beta + epsilon
  $
  其中：
  $
    X = mat(1, x, x^2, ..., x^p)
  $
  然而，如果假设 $x$ 被正规化到 $0, 1$ 之间，上面矩阵的奇异值可能变得非常小，导致数值计算上极其不稳定，方法也会变得很大。接下来，我们定义多项式的内积：
  $
    inner(f, g) = sumi(f(x_i) g(x_i)) 
  $
  假如能找到一组正交基 $p_i$ ，则：
  $
    X = (p_j (x_i))
  $
  就有：
  $
    X^T X = diag(sumj1n(p_j (x_i)^2))
  $
  这样还有一个好处，可以直接求得 $gamma_k$ 的估计值：
  $
    hat(gamma)_j = inner(Y, p_j)/norm2(p_j)
  $
  不妨假设 $x in [-1, 1], phi_0 = 0$，则有：
  #theorem[][
    $
       phi_1 = 2(x - Xbar)\
      phi_(r + 1) = 2(x - a_(r + 1)) phi_r (x) - b_r phi_(r - 1) (x)\
      where a_(r + 1) = inner(x phi_r, phi_r)/norm2(phi_r)\
      b_r = norm2(phi_r)/norm2(phi_(r - 1))
    $
    就确定了这样一组正交基。
  ]
  #proof[
    之前已经确定了 $phi_0$，设：
    $
      psi_1 = 2 x phi_0
    $
    取 $P_0$ 是到 $span(phi_0)$ 的投影，则：
    $
      phi_1 := (I - P_0) psi_1 
    $
    就有：
    $
      inner(phi_1, phi_0) = 0
    $
    同时：
    $
      P_0 phi_1 = inner(psi_1, phi_0)/norm2(phi_0) phi_0 = 2 Xbar
    $
    立刻就有：
    $
      phi_1 = 2 (x - Xbar)
    $

    一般的，假设已经确定 $autoRListN(phi, r)$，做施密特正交化：
    $
      psi_(r + 1) = 2 x phi_r \
      phi_(r + 1) = psi_(r + 1) - sum_(i = 0)^(r) inner(psi_(r + 1), phi_i)/norm2(phi_i) phi_i\
      = 2 x phi_r - sum_(i = 0)^(r) inner(2 x phi_r, phi_i)/norm2(phi_i) phi_i\
      = 2 x phi_r - sum_(i = 0)^(r) inner(2 phi_r, x phi_i)/norm2(phi_i) phi_i\
    $
    注意到有：
    $
      x phi_i in span(autoRListN(phi, i + 1))
    $
    因此当 $i < r - 1$ 时内积全为零，继而上式恰为：
    $
      phi_(r + 1)
      &= 2 x phi_r - inner(2 x phi_r, phi_r)/norm2(phi_r) phi_r - inner(2 phi_r, x phi_(r - 1))/norm2(phi_(r - 1)) phi_(r - 1)\
      &= 2(x - a_(r + 1)) phi_r - inner(phi_r, 2 x phi_(r - 1))/norm2(phi_(r - 1)) phi_(r - 1)\
      &= 2(x - a_(r + 1)) phi_r - inner(phi_r, phi_r + 2 a_r phi_(r - 1) + b_r phi_(r - 2))/norm2(phi_(r - 1)) phi_(r - 1)\
      &= 2(x - a_(r + 1)) phi_r - inner(phi_r, phi_r)/norm2(phi_(r - 1)) phi_(r - 1)\
      &= 2(x - a_(r + 1)) phi_r - b_r phi_(r - 1)\
    $
    得证。
  ]
  #theorem[][
    上面定义的多项式满足：
    $
      phi_r (x) = 1/2 C_0^1 T_0 (x) + sumi(C_1^(r) T_i (x))
    $
    其中：
    $
      T_(0) (x) = 1\
      T_(1) (x) = x\
      T_(r + 1) (x) = 2 x T_r (x) - T_(r - 1) (x)\
      C_j^(r + 1) = C_(j + 1)^r + C_(j - 1)^r - 2 a_(r + 1) C_j^r - b_r C_(j )^(r - 1)
    $
  ]
= Analysis of variance (ANOVA) model
  假如我们想研究小鼠的饮食对凝血时间的影响，实验得到了表格：
  #table(
  columns: 2,
  stroke: none,
  inset: 10pt,
  align: horizon,
  table.header(
    [*Diet*], [*Coagulation Time*],
  ),
  table.hline(),
  [A], table.vline(), [#grid(column-gutter: 10pt, columns: 4, [62], [60], [63], [59])],
  [B],  [#grid(column-gutter: 10pt, columns: 6, [63], [67], [71], [67], [68], [68])],
  [C],  [#grid(column-gutter: 10pt, columns: 6, [68], [66], [71], [67], [68], [68])],
  [D],  [#grid(column-gutter: 10pt, columns: 8, [56], [62], [60], [61], [63], [64], [63], [59])],
  // [A],
  // $ pi h (D^2 - d^2) / 4 $,
  // [
  //   $h$: height \
  //   $D$: outer radius \
  //   $d$: inner radius
  // ],
  // [B],
  // $ sqrt(2) / 12 a^3 $,
  // [$a$: edge length]
)
  如果设 $Y$ 是凝血时间，则 $Y$ 可以分解为基础平均凝血时间，治疗效果和误差。也即：
  $
    Y_i = mu + alpha_i + epsilon_i
  $
  其中 $mu$ 是基础平均凝血时间，$alpha_i$ 是治疗效果（通常我们需要  $sumi(alpha_i)= 0$）。这种问题被称为 one-way ANOVA model。

  再例如，研究新鲜猪油和变质猪油对小鼠的影响，实验得到了表格：
  #table(
    columns: 3,
    stroke: none,
    inset: 10pt,
    align: horizon,
    table.header(
      [], align(center)[*新鲜*], align(center)[*变质*],
    ),
    [雄性], grid(column-gutter: 10pt, columns: 3, [709], [679], [649]), table.vline(),
    grid(column-gutter: 10pt, columns: 4, [592], [538], [476]),
    table.hline(),
    [雌性], grid(column-gutter: 10pt, columns: 3, [687], [597], [677]), grid(column-gutter: 10pt, columns: 4, [508], [605], [539]),
    )
  此时，模型受到了两个因素的影响，这种问题被称为 two-way ANOVA model。这种模型可以有两种选择：
  $
    Y_(i j) = mu + alpha_i + beta_j + epsilon_(i j)
  $
  或者：
  $
    Y_(i j) = mu_(i j) + epsilon_(i j)
  $
  注意到下面的写法考虑了两个因素的交互作用，因此参数更多，更复杂一些。
  == One-way anova
    #let sumJi(x) = $sum_(j = 1)^(J_i) autoBraceIfAddOrSub(#x)$
    我们设：
    - $I$ 为影响因素的所有可能取值
    - $J_i$ 是每组实验的样本个数
    - $Y_(i j)$ 是第 $i$ 组第 $j$ 个样本的观测值，我们假设 $Y_(i j) tilde N(mu_i, sigma^2)$ 且 $epsilon_(i j)$ 之间相互独立。
    我们往往将模型写作：
    $
      Y = theta + epsilon
    $
    其中 $theta = (mu_i 1_(J_i))$，取：
    $
      X = diag(1_(J_i))
    $
    则模型形如：
    $
      Y = X mu + epsilon\
      rank(X) = I
    $
    其中 $mu$ 是我们关心的值。检验这些方案有没有效果相当于检验：
    $
      H : mu_1 = mu_2 = ... = mu_I
    $
    使用之前的方法，就有：
    $
      F = (RSS_H - RSS)/(I - 1) / (RSS / (n - I)) tilde F_(I - 1, n - I)
    $
    注意到我们的模型事实上是：
    $
      Y_i = mu_i + epsilon_i
    $
    显然无约束时，$mu_i$ 的最优值就是 $Ybar_i$，因此：
    $
      RSS = sumi(sumJi((Y_(i j) - Ybar_i)^2))
    $
    类似的，假设成立时，$mu$ 的最优值应该就是 $Ybar := sumi(Ybar_i)$，因此：
    $
      RSS_H = sumi(sumJi((Y_(i j) - Ybar)^2))
    $
    前面提到过有：
    $
      RSS_H - RSS &= norm2(P_H Y - P Y)\
      &= norm2(hY_H - hY)\
      &= sumi(J_i (Ybar_i - Ybar)^2)\
    $
    故：
    $
      F = (sumi(J_i (Ybar_i - Ybar)^2) / (I - 1)) / (sumi(sumJi((Y_(i j) - Ybar)^2)) / (n - I))
    $
    注意到分子上的项类似于每组之间的方差，分母上类似于组内方差的和，不难想象 $H$ 成立时组间方差应该和组内方差是比较接近的。

    然而，这个问题还有其他的参数化方式。例如：
    - 将第 $I$ 个均值作为基准，也即令：
      $
        mu = mu_I\
        alpha_i = mu_i - mu_I
      $
      模型写出：
      $
        Y_i = (mu + alpha_i) 1 + epsilon_i
      $
      当然，我们要求 $alpha_I = 0$，它也可以写成矩阵形式：
      $
        Y = (1, diag(1_(J_i))) vec(mu, alpha_1, alpha_2, dots.v, alpha_(I - 1)) + epsilon
      $
      此时：
      $
        H: alpha_1 = alpha_2 = ... = alpha_(I - 1) = 0 
      $
    - 将 $mu = 1/I sumi(mu_i)$ 作为基准，令 $alpha_i = mu_i - mu$，其他的和上面情况类似。
    - 将全局的均值 $Ybar$ 作为基准，令 $alpha_i = mu_i - mu$，其他的和上面情况类似。

    有些时候，我们也会对下面的形式：
    $
      theta = sumi(c_i mu_i)
    $
    估计置信区间。事实上有：
    $
      E(htheta) = sumi(c_i Ybar_i)\
      var(htheta) = sigma^2 sumi(c_i^2/J_i)
    $
    用：
    $
      S^2 = 1/(n - I) sumi(sumJi((Y_(i j) - Ybar_i)^2))
    $
    替代 $sigma^2$，得到统计量：
    $
      (htheta - theta)/sqrt(S^2 sumi(c_i^2/J_i)) tilde t_(n - I)
    $
    类似的，也可以使用 Scheffe method 同时得到多个置信区间。

    #definition[][
      设 $Y_i tilde N(0, sigma^2), w = min_j Y_j - max_j Y_j$，$S^2$ 与 $Y_i$ 独立，是 $sigma^2$ 的无偏估计，且：
      $
        (nu S^2)/sigma^2 tilde chi^2_nu
      $
      则有：
      $
        w/S tilde q_(n, nu)
      $
    ]
    用上面这个分布，就可以得到一种假设均值相同时，估计 $mu_i - mu_j$ 的置信区间的方法，这种方法被称为 Tukey method。对于那些 $|mu_i - mu_j| > w/S$ 的 $i, j$，我们就可以拒绝假设。
  == two-way ANOVA
    两因素 ANOVA 模型是：
    $
      Y_(i j) = (mu + alpha_i + beta_j + gamma_(i j)) 1 + epsilon_(i j), i in I, j in J
    $
    往往令：
    $
      k_(i j) = rank(Y_(i j))
    $
    类似的，我们有 $mu_(i j)$ 的最佳值就是 $Ybar_(i j)$，而全局的 $mu$ 最优值就是 $Ybar$，因此：
    $
      RSS/sigma = 1/sigma^2 sum_(i j k) (Y_(i j k) - Ybar)^2\ tilde chi^2_(n - abs(I) abs(J))
    $
    当然也可以将模型写作：
    $
      Y_(i j) = mu + alpha_i + beta_j + gamma_(i j)
    $
    其中 $alpha, beta$ 将满足若干约束条件（否则会过参数化）。通常而言对于对称的参数，也即满足：
    $
      sum alpha_i = 0\
      sum beta_j = 0\
      sum_i gamma_(i j) = sum_j gamma_(i j) = 0
    $
    $alpha$ 的自由度为 $I - 1$，$beta$ 的自由度为 $J - 1$，$gamma$ 的自由度为 $(I - 1)(J - 1)$，最后恰有 $1 + (I - 1) + (J - 1) + (I - 1)(J - 1) = I J$ 个自由度。

    一个很有实际意义的问题是因素之间是否有相互作用，也就是检验：
    $
      H_(A B)(H_1): gamma_(i j) = 0, forall i, j\
      mu_(i j) = mu + alpha_i + beta_j
    $
    有时，还会额外考虑：
    $
      H_A (H_(1 3)) : alpha_i = 0, gamma_(i j) = 0\
      mu_(i j) = mu + beta_j
    $
    对称的：
    $
      H_B (H_(1 3)) : beta_j = 0, gamma_(i j) = 0\
      mu_(i j) = mu + alpha_i
    $
    继而：
    $
      H_(123) (H_1) : alpha_i = 0, beta_j = 0, gamma_(i j) = 0\
    $
    令 $gamma = vec(mu 1^T, alpha^T, beta^T, gamma^T)$ 是所有参数构成的矩阵。检验 $H_1$ 是标准的，计算标准的 $F-$ 检验即可。然而对于其他的检验，自然的会产生如何选择基底的模型的问题。

    最简单的，对于 $H_1$，检验统计量就是：
    $
      F = ((RSS_1 - RSS) / ((I - 1) (J - 1)))/(RSS / (n - I J ))
    $
    对于其他的检验，有如下几种方法：
    === Type I procedure
      我们可以递归的进行假设检验，也就是：
      - 检验 $H_1$
      - 在 $H_1$ 下检验 $H_(1 2)$，此时：
        $
          F_(1 2) = ((RSS_12 - RSS_1)/(J - 1))/(RSS_1 / (n - I - J + 1))\
        $
      - 在 $H_(1 2)$ 下检验 $H_(1 2 3)$，此时：
        $
          F_(1 2 3) = ((RSS_(1 2 3) - RSS_1)/(I - 1))/(RSS_1 / (n - I))\
        $
      #lemma[][
        $
          RSS_(123) = RSS + (RSS_1 - RSS) + (RSS_12 - RSS_1) + (RSS_123 - RSS_12)\
          = RSS + R(gamma | mu, alpha, beta) + R(beta | mu, alpha) + R(alpha | mu)
        $
        并且 $RSS, RSS_1, RSS_(12), RSS_(123)$ 相互独立
      ]
      #proof[
        分解是显然的。对于独立性，将三个问题的投影算子依次记作 $P_omega, P_1, P_(12), P_(123)$，简单计算即可
      ]
    === Type II procedure
      对于 $H_(12), H_(123)$，都直接与 $H_1$ 做比较。此时就没有上面分解式的性质了
    === Type III procedure
      #let lH = $overline(H)$
      令：
      $
        lH_A : mu_(1 *) = mu_(2 *) = ... = mu_(I *)\
        lH_B : mu_(* 1) = mu_(* 2) = ... = mu_(* J)\
      $
      用 $lH$ 替代原先的 $H$ 做检验。在对称约束下，等价于 $alpha_i = 0$，统计量为：
      $
        F = (R(alpha | mu, beta, gamma)/(I - 1))/(RSS/(n - I J))\
      $
    #theorem[][
      如果每组的样本数 $k_(i j)$ 全部相等，则三种方法的结果是一样的，也即：
      $
       R(alpha | mu, beta, gamma) = R(alpha | mu, beta) = R(alpha | mu) 
      $
    ]
    期中考试内容到此为止
= 其他误差项
  之前的讨论，我们总是基于 $epsilon$ 的某些良好性质。有时，这些性质是不存在的
  == underfitting 
    典型的情形是，真实的关系形如：
    $
      Y = X beta + Z gamma + epsilon
    $
    但测量时，我们只测量了 $X$，没有测量 $Z$，假设 $(X, Z)$ 是满秩的。此时，按照之前方法估计得到的 $hb$ （通常）不再是 $beta$ 的无偏估计，$S^2$ 也（通常）不再是 $sigma^2$ 的无偏估计。可以计算得：
    $
      E hb = Inv(tMul(X)) X^T (X beta + Z gamma) = beta + Inv(tMul(X)) X^T Z gamma\
      E S^2 = sigma^2 + (quadFormSym(Z gamma, I - P))/(n - p)\
      E (Y - hY) = (I - P) Z gamma\
      var (Y - hY) = sigma^2 (I - P)
    $
  == overfitting
    另一种情形是，我们考虑的模型是：
    $
      Y = (X_1, X_2) vec(beta_1, beta_2) + epsilon = X beta + epsilon
    $
    然而真实的关系只是：
    $
      Y = X_1 beta_1 + epsilon
    $
    换言之，$beta$ 的后半部分全为零，此时：
    $
      E hb = Inv(tMul(X)) X^T X_1 beta_1 = Inv(tMul(X)) X^T X beta = beta
    $
    也就是 $hb$ 仍然是无偏的，同时：
    $
      var(hb) = var(hb_1) + L M L^T [j; j] >= var(hb_1) 
    $
    表明方差可能增大了。
  == 误差不同方差
    如果真实情形是 $var(epsilon) = sigma^2 V$，仍按照标准的方法估计，可以计算得：
    $
      E(hb) = beta\
      var(hb) != Inv(tMul(X)) sigma^2
    $
    导致假设检验等就失效了。以及：
    $
      E S^2 = sigma^2/(n - p) tr((I - p) V)
    $

  == 误差非正态 
    如果误差项不是正态的，则参数估计不会出现问题，但 F-检验就不再成立。不过可以证明：
    $
      F = ((RSS_H - RSS)/(q - 1))/(RSS/(n - p))\
    $
    在一些条件下（例如 $n$ 较大时），仍然近似服从 $F$ 分布（但自由度可能变化）
  == $X$ 有随机性
    之前的讨论中，我们认为对 $X$ 的观察都是准确且无随机性的。然而许多情况下，$X$ 是带有随机性或者噪声的。此时，设：
    $
      V = U beta, U "有随机性但可观测"\
      Y = V + epsilon\
      E (Y | U) = V
    $
    将之前所有推断换成 $| U$ 下的条件推断，则结论都是不变的。在做统计推断时，可能对结果产生一些影响，但影响很小。

    另外，如果认为 $X$ 不能精确测量，也即设：
    $
      U = E X\
      Y = (E X) beta + epsilon = X beta + epsilon + delta beta where delta = X - E X\
    $
    如果假设 $var(delta) = sigma_1^2 I$，此时：
    $
      hb = Inv(tMul(X)) X^T Y = Inv(tMul(X)) X^T (X beta + epsilon + delta beta)\
      E hb = E (E (hb | X)) = E (Inv(tMul(X)) X^T (X - delta) beta) = beta - E_delta (Inv(tMul(X)) X delta beta)
    $ 
    可以证明：
    $
      E_delta (Inv(tMul(X)) X delta beta) approx n Inv(tMul(U) + n D) D beta\
      E (tMul(X)) = tMul(U) + n D
      where D = tMul(delta)
    $
    进而可以利用其他统计量做一些校正。不过实际的线性回归中，很少考虑这种情形。
  == 异常值
    距离其他数据较远的点称为*异常点*。有些点的 $x$ 值正常，但 $y$ 值偏离回归曲线，这种点称为 $y-$ 异常点。也有些点的 $x$ 值脱离其他数据，这种点称为 $x-$ 异常点或者*高杠杆点*。还有一些点的 $x$ 和 $y$ 都偏离其他数据，这种点称为*双异常点*。异常点的存在会影响线性回归的结果，导致 $hb$ 和 $S^2$ 的估计不准确。本节中，我们往往假设 $X$ 是列中心化的，也即：
    #let tildeX = $tilde(X)$
    $
      X = (1, tilde(X))
    $
    此时:
    $
      P = X Inv(tMul(X)) X^T\
      = (1, tildeX) mat(1/n, 0; 0, Inv(tMul(tildeX))) (1, tildeX)^T\
      = 1/n 1 1^T + tildeX Inv(tMul(tildeX)) tildeX^T\
    $
    可以计算得：
    $P_(i i) = 1/n + quadFormSym(X^i - Xbar_i 1, Inv(tMul(tildeX)))$，（$X^i$ 指 $X$ 的第 $i$ 行的转置）上式第二项实际上是用正定矩阵 $Inv(tMul(tildeX))$ 度量的，$X_i$ 与 $Xbar_i 1$ 的距离。此外，$P$ 是对称的投影矩阵，就有：
    $
      P^2 = P\
      P_(i i)  = P_(i i)^2 + sum_(j != i) P_(i j)^2\
      P_(i i) >= P_(i i)^2 => P_(i i) <= 1\
    $
    注意到：
    $
      hY_i = P_(i i) Y_i + sum_(j != i) P_(i j) Y_j\
    $
    假如第 $i$ 个数据是异常值，则 $X_i$ 前面提到的它与平均值的偏离就会很大，$P_(i i)$ 也会很大，导致 $hY_i$ 的预测值很大程度上就是 $Y_i$ 本身。因此 $P_(i i)$（有时也记作 $h_i$）就是一个判别 $x$ 方向异常值的标准。

    接下来，考虑 $Y$ 方向的异常值，假设真实的情形是：
    $
      Y_i = X_i^T beta + Delta_i + epsilon_i\
    $
    也就是真实模型为：
    $
      Y = X^T beta + Delta + epsilon\
    $
    其中 $Delta$ 仅有第 $i$ 个分量非零。此时：
    $
      E hY = P E Y = P(X^T beta + Delta) = X^T beta + P Delta\
      E hY_i = X_i^T beta + P_(i i) Delta_i\
    $
    可以看出，如果异常点不是高杠杆点，$P_(i i)$ 相对较小，即使 $Y$ 方向出现了异常造成的影响相对较小。
  == 病态矩阵
    #let Rxx = $R_(x x)$
    有时，尽管 $X$ 是满秩的，但列之间的线性相关性很强，导致 $X^T X$ 相当病态，计算上会造成困难。线性回归中有：
    $
      var hY = sigma^2 Inv(tMul(X))\
    $
    因此 $tMul(X)$ 奇异时，$hY$ 的方差可能会相当大。假设数据是列中心化，标准化的，此时：
    $
      X = (1, tildeX)\
      Y = (1, tildeX) vec(gamma_0, gamma) + epsilon 
    $
    熟知：
    $
      var(vec(gamma_0, gamma)) = sigma^2 Inv(tMul(X))\
      = sigma^2 mat(1/n, 0; 0, Inv(tMul(tildeX)))
    $
    因此：
    $
      var hgamma = sigma^2 Inv(tMul(tildeX)) := sigma^2 Inv(Rxx)
    $
    事实上，$Rxx$ 就是样本之间的相关系数组成的矩阵，$Rxx (i, j) = inner(X_i, X_j)$
    若设：
    $
      Rxx = mat(1, r^T; r, Rxx')\
    $
    则有：
    $
      Inv(Rxx) = mat(1/(1 - quadFormSym(r, Inv(Rxx'))), ...;..., ...)
    $
    进而：
    $
      var(hgamma_1) = sigma^2/(1 - quadFormSym(r, Inv(Rxx')))\
    $
    若设 $X(-j)$ 是 $X$ 去掉第 $j$ 列的矩阵，$P(-j)$ 是相应的投影矩阵（相当于去掉第 $j$ 个变量做回归），此时用其他列线性逼近 $X_j$ 的 RSS 为：
    $
      quadFormSym(X_j, I - P(-j)) = tMul(X_j) - quadFormSym(X_j, X(-j) Inv(tMul(X(-j))) X(-j)^T)\
      = 1 - quadFormSym(X_j, X(-j) Inv(tMul(X(-j))) X(-j)^T)
    $
    若 $j = 1$ 就有上式：
    $
      = 1 - r^T Inv(Rxx') r\
    $
    两式结合，一个变量如果能被其他变量很好的线性逼近，对应参数的拟合方差就会极为严重。此时：
    $
      R_j^2 = 1 - RSS_j/(sum_i (X_j (i) - Xbar_j)^2) = 1 - RSS_j
    $
    #let VIF = $"VIF"$
    我们定义 #VIF (varience inflation factor) 为：
    $
      VIF_j = 1/(1 - R_j^2)\
    $
    则 $var(hgamma_j) = sigma^2 VIF_j$

    另一方面，$Rxx$ 可以对角化，设：
    $
      Rxx = T Lambda T^T\
    $
    则：
    $
      var(hgamma_j) = sigma^2 (T Inv(Lambda) T^T)_(j j)\
      = sigma^2 sum_(i = 1)^(p - 1) T_(j i)^2 / lambda_i\
    $
    如果有 $lambda_i$ 很小，就会导致 $var(hgamma)$ 可能很大。注意到还有：
    $
      VIF_j = sum_(i = 1)^(p - 1) T_(j i)^2 / lambda_i\
      <= sum_(i = 1)^(p - 1) T_(j i)^2 / lambda_min\
      <= lambda_min\
      <= lambda_max / lambda_min("可以证明" lambda_max >= 1)\
      = kappa(Rxx)^2
    $
    因此 $Rxx$ 矩阵的条件数也可以作为一个判断共线性的度量。

    上面表明，数据的线性相关性对于参数估计有着很大的影响。然而，接下来会说明，它对预测的影响相对而言是较小的。当 $X$ 中心化后，一定有：
    $
      Y = Ybar + (X_0 - Xbar 1) gamma + epsilon
    $
    前面计算过， $cov(Ybar, gamma) = 0$，因此：
    $
      var(hY) = var(Ybar) + var((X_0 - Xbar_0 1) gamma)\
      = sigma^2 (1/n +  quadFormSym(X_0 - Xbar 1, Inv(tMul(tildeX))) ) 
    $
    只要 $X_0$ 偏离数据较小，$hY$ 的方差就不会很大。也即 $X$ 的线性相关性对 $hY$ 的影响是相对较小的。
  == Residuels and hat matrix diagonal
    有时，我们也把投影矩阵 $P$ 记作 hat matrix $H$，熟知：
    $
      e = Y - hY = (I - H) Y\
      E e = 0\
      var(e) = sigma^2 (I - H)\
      E hY = X beta\
      var(hY) = sigma^2 H\
      cov(e, hY) = 0\
    $
    这些等式表明，$var(e_i) = sigma^2 (1 - H_i)$，表明 $e$ 不再是同方差的。
    #definition[internally studentized residuals][
      定义：
      $
        r_i = e_i/(S sqrt(1 - H_i))\
      $
      其中 $S^2 = RSS/(n - p)$ 是 $sigma^2$ 的无偏估计。
    ]
    #lemma[][
      $
        H_i = x_i^T Inv(tMul(X)) x_i
      $
    ]
    #lemma[Kook 1983][
      $
        r_i^2/(n - p) tilde B(1/2, 1/2 (n - p - 1))
      $
    ]
    #definition[externally studentized residuals][
      定义：
      $
        t_i = e_i/(S_i sqrt(1 - H_i))\
      $
      其中 $S_i^2 = RSS_i/(n - p - 1)$，$RSS_i$ 是去掉第 $i$ 个观测值，使用其他数据做拟合计算得到的残差平方和。
    ]
    #theorem[][
      记 $hbeta$ 是全模型拟合的参数，$hbeta_i$ 是去掉第 $i$ 个分量拟合得到的参数，则：
      $
        hbeta - hbeta_i = (Inv(tMul(X)) X_i e_i)/(1 - h_i)
      $
    ]
    #proof[
      设 $X(i)$ 是 $X$ 去掉第 $i$ 行 ，就有：
      $
        hbeta_i = Inv(tMul(X(i))) X(i)^T Y(i)\
      $
      以及（做矩阵计算可得）：
      $
        tMul(X(i)) = tMul(X) - x_i x_i^T\
        X(i)^T Y(i) = X^T Y - x_i Y_i 
      $
      #lemma[Sherman-Morision-Woodbury][
        $
          Inv(A + U B V) = Inv(A) - Inv(A) U B Inv(B + B V Inv(A) U B) B U Inv(A)
        $
      ]
      就有：
      $
        Inv(tMul(X) - x_i x_i^T) = Inv(tMul(X)) + (Inv(tMul(X)) x_i x_i^T Inv(tMul(X)))/(1 - x_i^T Inv(tMul(X)) x_i) 
      $
      代入计算得：
      $
        hbeta(i) 
        &= hbeta - Inv(tMul(X)) x_i Y_i + (Inv(tMul(X)) x_i x_i^T hbeta)/(1 - h_i) - (Inv(tMul(X)) mulT(x_i) Inv(tMul(X)) x_i)/(1 - H_i) Y_i\
        &= hbeta - (Inv(tMul(X)) x_i)/(1 - H_i) ((1 - H_i) Y_i - x_i^T hbeta + h_i Y_i)\
        &= hbeta - (Inv(tMul(X)) x_i)/(1 - H_i) (Y_i - x_i^T hbeta)\
        &= hbeta - (Inv(tMul(X)) x_i)/(1 - H_i) e_i\
      $
    ]
    有时，我们会考虑如下的量：
    $
      Y_i - hY(i) 
      &= Y_i - x_i^T beta + quadFormSym(x_i, Inv(tMul(X)))/(1 - h_i) e_i\
      &= e_i + h_i/(1-h_i) e_i\
      &= 1/(1 - h_i) e_i\
    $
    同时，注意到 $Y_i$ 和 $hY(i)$ 是独立的，因此：
    $
      var(Y_i - hY(i)) = var(Y_i) + var(hY(i)) = sigma^2 + sigma^2 quadFormSym(x_i, Inv(tMul(X(i))))
    $
    #definition[Jack knife studentized residuals][
      定义：
      $
        t_i = (Y_i - hY(i))/(S(i) sqrt(1 + quadFormSym(x_i, Inv(tMul(X(i))))))
      $
    ]
    #lemma[][
      $
        quadFormSym(x_i, Inv(tMul(X(i)))) = H_i / (1 - H_i)
      $
    ]
    #proof[
      $
        quadFormSym(x_i, Inv(tMul(X(i)))) = quadFormSym(x_i, Inv(tMul(X))) + (quadFormSym(x_i, Inv(tMul(X))))^2/(1 - H_i) = H_i + H_i^2/(1 - H_i)= H_i / (1 - H_i)
      $
    ]
    此外：
    $
      (n - p - 1) S(i)^2 = norm(Y(i) - X(i)^T hbeta(i))^2\
      = norm2(Y - X^T hbeta(i)) - (Y_i - x_i^T hbeta(i))^2\
      = norm2(Y - X^T hbeta + (X^T Inv(tMul(X)) x_i e_i)/(1 - h_i)) - (Y_i - x_i^T hbeta(i))^2\
      = norm2(e + ((Y_i - x_i^T hbeta(i))^2 Inv(tMul(X)) x_i e_i)/(1 - h_i)) - (Y_i - x_i^T hbeta(i))^2\
    $
    与此同时：
    $
      (n - p - 1) S(i)^2 
      &= sum_(j != i) (y_i - x_i^T hbeta(i))^2\
      &= sum_(j != i) (y_i - x_i^T (hbeta - (Inv(tMul(X) )x_i e_i)/(1 - h_i))))^2\
      &= sum_(j != i) (e_j + ( x_j^T Inv(tMul(X)) x_i e_i)/(1 - h_i))^2\
      &= sum_(j != i) (e_j + (H_(j i) e_i)/(1 - h_i))^2\
      &= sum_(j) (e_j + (H_(j i) e_i)/(1 - h_i))^2 - e_i^2/(1 - h_i)^2\
      &= sum_(j) e_j^2 + sum_j 2 (H_(j i) e_i e_j)/(1 - h_i) +  sum_j (H_(j i) e_i)^2/(1 - h_i)^2 - e_i^2/(1 - h_i)^2\
    $
    注意到：
    $
      H e = H (I - H) Y = 0\
      H^2 = H\
      sum_j H_(j i) e_j = 0\
      sum_j H_(i j)^2 = H_i\
      tr(H) = sum_j H_j
    $
    因此上式等于：
    $
      RSS_i 
      &= sum_(j) e_j^2 + (H_I e_i^2)/(1 - h_i)^2 - e_i^2/(1 - h_i)^2\
      &= RSS  - e_i^2/(1 - H_i)\
      &= RSS - S^2 r_i^2\
      &= (n - p - r_i^2) S^2
    $
    综上：
    $
      t_i = e_i/(S sqrt((n - p - r_i^2)/(n - p - 1)) (1 - h_i) sqrt(1 + h_i/(1 - h_i)))
    $
    化简后就有：
    #lemma[][
      $
        (n - p - 1) S(i)^2 = (n - p - r_i^2) S^2\
        t_i = r_i sqrt((n - p -1)/(n - p - r_i^2))
      $
    ]
    注意到 $r_i$ 是同分布的，因此 $t_i$ 也是同分布的。使用以上同分布的观测值，我们就可以检查一个点是否在 $y-$方向上有异常。
    #definition[Cook's distance][
      定义：
      $
        D_i = quadFormSym(hbeta(i) - hbeta, tMul(X))/(p S^2)
      $
    ]
    前面提到过：
    $
      hbeta - hbeta(i) = (Inv(tMul(X)) x_i)/(1 - h_i) e_i\
    $
    因此可以计算得：
    $
      D_i = r_i^2 h_i/(p(1 - h_i))\
    $
    Cook 建议，如果 $D_i > F_(p, n - p)^(0.10)$，则该点可能是潜在的异常点。
  == 错误的线性回归
    #let he = $hat(e)$
    假设真实的关系形如：
    $
      E (Y | X) = beta_0 + beta_1 g(x_1) + beta x_2
    $
    其中 $g(x_1)$ 是非线性项。如果拟合得到线性模型：
    $
      Y = hbeta_0 + hbeta_1 x_1 + hbeta_2 x_2 + he\
    $
    其中：
    $
      he approx hbeta_1 (g(x_i) - x_i) + epsilon
    $
    因此一种想法是，检查 $he$ 与 $x_i$ 的相关性。如果相关，则说明其中蕴含非线性关系，否则若不相关，则说明 $x_i$ 与 $g(x_i)$ 之间可能没有非线性关系。有时，也可以观察：
    $
      e^* = he + hbeta_1 x_1 approx hbeta_1 g(x_1)
    $
    与 $x_1$ 的相关性。
    #definition[Box-Cox transforamation][
      假设 $X$ 都非负，下面一类变换：
      $
        g(x, lambda) = cases(
          (x^lambda - 1)/lambda "if" lambda != 0,
          ln (x) "if" lambda = 0
        )
      $
      称为 Box-Cox 变换。通常而言，数据取对数之后往往会变得更加正态/线性。
    ]

    还有一种情形是，$Y$ 不接近于正态分布，此时 Box-Cox 变换也可以用于 $Y$ 相对缺失正态性时，将 $Y$ 变得更加符合正态分布。然而，很多时候无法确定哪个 $lambda$ 最好，常见做法是采用将 $lambda$ 作为参数，进行最大似然估计。此时：
    $
      L = (2 pi sigma^2)^(-n/2) e^(-1/(2 sigma^2) tMul(Y' - X beta)) det(J)\
      where J = det(der(Y', Y)) = product_(i = 1)^n Y_i^(lambda - 1)\
    $
    求解之即可。有时，我们也可以对 $X$ 也做类似的变换，得到模型：
    $
      g(Y_i, lambda) = g(X_i^T beta, lambda) + epsilon_i\
    $
    也可以利用极大似然方法求解。
  == 误差不同方差的检测 
    之前我们都假设 $var(epsilon_i) = sigma^2$，但有时数据不是同方差的，下面我们讨论如何检测这种现象：
    
    若 $var(epsilon_i) = sigma_i^2$（仍然相互独立）此时我们有：
    $
      var(e) = (I - H) Sigma (I - H)\
      E(e) = 0\
      var(e_i) = (1 - h_i)^2 sigma_i^2 + sum_(k != i) H_(i k)^2 sigma_k^2
    $
    （这里 $H$ 是投影矩阵，$h_i$ 是 $H$ 的 $i i$ 元）
    如果设：
    $
      b_i = e_i^2/(1 - h_i)
    $
    可以计算得，当 $epsilon_i$ 同方差时，有：
    $
      E b_i = ((1 - h_i)^2 sigma^2 + sum_(k != i) H_(i k)^2 sigma^2)/(1 - h_i)\
      = (1 - h_i) sigma^2 + sum_(k != i) H_(i k)^2/(1 - h_i) sigma^2\
    $
    由 $I - H$ 幂等性，有：
    $
      (1 - h_i)^2 + sum_(k != i) H_(i k)^2 = 1 - h_i\
    $
    代入计算可得 $E b_i = sigma^2$，因此可以利用 $b_i$ 检测是否同方差，当然也可以利用前面提到的 $r_i, t_i$ 等

    如果检查出异方差，常见做法是假设 $sigma_i^2$ 是某些协变量的函数，也就是对某个（确定的）核函数 $w$，设：
    $
      sigma_i^2 = w(z_i, lambda)
    $
    通常假设：
    - 在某个 $lambda_0$ 处 $w(z, lambda_0)$ 与 $z$ 无关（从而该函数族可以包含常方差情形）
    接下来，进行最大似然估计：
    $
      L(beta, lambda) = C - 1/2 (ln det(Sigma) + quadFormSym(Y - X beta, Inv(Sigma)))\
      = C - 1/2 (sum_(i = 1)^n ln w_i + sum_(i = 1)^n (Y_i - X_i^T beta)^2/w_i)\
      where w_i = w(z_i, lambda)\
    $
    通常的做法是使用拉格朗日乘子法，迭代求解 $lambda$ 和 $beta$，或者迭代地，通过拉格朗日方程求得 $beta$，再用最小二乘法估计 $lambda$
  == ridge regression
    对于已经中心化、标准化的 $X$，在 $X$ 共线性较强时，可以使用以下的形式：
    $
      min norm2(Y - X gamma) + k norm2(gamma)\
    $
    替代通常的最小二乘估计，这被称为 ridge regression。可以证明它有显式解：
    $
      gamma = Inv(tMul(X) + k I) tMul(X) Y\
    $
    增加 $k$ 的偏置后，$gamma$ 的方差会稳定，但是：
    $
      E X hgamma' = (I + k Inv(Rxx)) hgamma
    $
    其中 $hgamma$ 是标准的最小二乘估计，这意味着 ridge regression 不是无偏估计。
= 模型选择和变量选择
  很多时候，我们可选择的变量数目非常多。理论上，变量越多回归的效果越好，但会导致模型更加复杂，可解释性更差，预测效果可能往往变差。因此，我们常常希望从中只选出一部分有效的变量。假设协变量数目为 $p$ ，我们往往有如下几种思路：
  - 穷举 $2^p$ 种选择，选出某种标准下最好的模型。显然在 $p$ 较大时，这种方法是不可行的。
  - 贪婪方法，有多种变种，大致思想是每次添加（或删去）若干变量，逐步进行。
  - Shrinkage 方法：在标准的最小二乘回归中增加某种惩罚项。包括 ridge regression 和 LASSO 等方法。
  为了衡量变量选择的好坏，当然不能使用通常的 RSS。一个常见的想法是，考虑模型在新数据上预测的好坏。
  == 预测误差
    #definition[（平方）预测误差][
      设有独立于训练数据的 $m$ 个独立新数据 $Y', X'$，以及 $E Y' = mu = X' beta$，则模型的预测误差定义为：
      $
        E_Y' norm2(Y' - X' hbeta)  = E norm2(Y' - E Y' + E Y' - X' hbeta) = E norm2(Y' - mu) + norm2(mu - X' hbeta)\
        = m sigma^2 + norm2(mu - X' hbeta)\
      $  
      其中 $norm2(mu - X' hbeta)$ 称为模型误差（ME）。有时，我们考虑的是 $X = X'$ 的情形，就有：
      $
        "ME" = norm2(mu - hY) = norm2((I - P)mu - P epsilon) = quadFormSym(mu, I - P) + quadFormSym(epsilon, P)\
      $
      此时：
      $
        E "ME" = quadFormSym(mu, I - P) + sigma^2 tr(P) =  quadFormSym(mu, I - P) + sigma^2 p\
        E "PE" = (n + p) sigma^2 + quadFormSym(mu, I - P)\
      $
      可以看到，$p$ 变大时，上式第一项相对变小，但第二项变大，这体现了参数数量不能过多也不能变少之间的权衡。
    ]
    #definition[][
      我们称：
      - $quadFormSym(mu, I - P)$ 为模型的 total bias
      - $sigma^2 tr(P) = p sigma^2$ 为模型的 total variance
    ]
    假设：
    $
      Y = (X_1, X_2) vec(beta_1, beta_2) + epsilon\
    $
    其中 $X$ 有 $k + 1$ 列，$X_1$ 有 $p$ 列。我们希望讨论是否可能通过去掉 $X_2$ 得到更好的预测误差。简单起见，设 $m = 1$，新数据为 $X'^T = (X_1'^T, X_2'^T)$ 则有：
    $
      E "PE" = sigma^2 + E norm2(X'^T beta - X_1'^T hbeta_1)\
      = sigma^2 + var(X_1'^T hbeta_1) + (X'^T beta - X_1'^T E hbeta_1)^2
    $
    假设 $hbeta_1$ 是只用 $X_1$ 估计得到的参数，之前章节给出：
    $
      E hbeta_1 = beta_1 + L beta_2 where L = Inv(tMul(X_1)) X_1^T X_2\
    $
    因此可以计算得：
    $
      X'^T beta - X_1'^T E hbeta_1 = (L^T X_1' - X_2')^T beta_2\
      E "PE" = sigma^2 + var(X_1'^T hbeta_1) + (L^T X_1' - X_2')^T beta_2 := sigma^2 + var(X_1'^T hbeta_1) + h^T beta_2
    $
    同时，如果采用全模型，就有：
    $
      E "PE" = sigma^2 + E norm2(X'^T beta - X'^T hbeta) = sigma^2 + var(X'^T hbeta)
    $
    由前面的结果：
    $
      var(X'^T hbeta) = var(X'^T hbeta_1) + sigma^2(L^T X'_1 - X'_2)^T M (L^T X'_1 - X'_2) \
      where M = Inv(quadFormSym(X_2, I - P_1)), P_1 = X_1 Inv(tMul(X_1)) X_1^T\
    $
    因此，只要：
    $
      (h^T beta_2)^2 < sigma^2 quadFormSym(h, M)
    $
    就有去掉一部分变量后，模型的预测误差方而更小了。可以证明：
    $
      (h^T beta_2)^2 <= quadFormSym(h, M) quadFormSym(beta_2, M)
    $
    因此，只要：
    $
      sigma^2 > quadFormSym(beta_2, M)
    $
    就足以保证去掉 $X_2$ 后，模型的预测误差更小。简单来说，就是当 $sigma^2$ 很大或者某些变量对 $Y$ 的影响很小时，可以考虑去掉这些变量。
  == 模型的评估准则
    实践上，前面提到的预测误差通常是不可计算的。常常会采用以下的指标：
    #definition[Adjusted $R^2$][
      定义：
      $
        overline(R)^2 = 1 - (1 - R^2) n/(n - p)
      $
      称为 *调整后的 $R^2$*，它是对 $R^2$ 的一种修正，不会随着变量数目的增加而增加。
    ]
    它的想法来自于对只采用 $X_1$ 做回归是否显著做假设检验，就有：
    $
      F = ((RSS_H - RSS) quo (k + 1 - p))/(RSS quo (n - k - 1))\
      R^2_p = 1 - RSS_p/(sum (Y_i - Ybar)^2)\
      F =  (sum (Y_i - Ybar)^2 (R^2_(k + 1) - R^2_p)) / (sum (Y_i - Ybar)^2 (1 - R^2_(k + 1))) dot (n - k -1) / (k + 1 - p)\
      = (R^2_(k + 1) - R^2_p) / (1 - R^2_(k + 1)) dot (n - k -1) / (k + 1 - p)
    $
    就可以计算得：
    $
      overline(R)^2 = 1 - (1 - R_(k + 1)^2) n/(n - k - 1) ((k + 1 - p) F + n - k - 1)/(n - p)
    $
    若 $F$ 检验显著，例如 $F > 1$，就有 $overline(R)_p^2 <= overline(R)_(k + 1)^2$

    另一种想法是，我们确实收集 $m$ 个测试数据，用 $norm2(Y' - X' hbeta)$ 做评估。然而有时，我们不能收集新的数据，就可以采用*交叉验证方法*，也就是轮流在数据中选出一部分作为训练数据，剩下的作为测试数据。
    #let CV = "CV"
    #definition[n-fold cross validation/Jackknife/leave-one-out][
      定义：
      $
        CV(1) = 1/n sum_(i = 1)^n (Y_i - hY(i)_i)^2\
      $
      是留一法交叉验证产生的测试误差。
    ]
    前面计算过：
    $
      hbeta - hbeta(i) = (Inv(tMul(X)) x_i)/(1 - h_i) e_i\
    $
    因此可以计算得：
    $
      Y - hY(i) = (Y_i - x_i^T hbeta) 1/(1 - h_i)
    $
    （这里 $x_i^T$ 是 $X$ 的第 $i$ 行）最终就有：
    $
      CV(1) = 1/n sum_(i = 1)^n ((Y_i - hY_i)/(1 - h_i))^2
    $
    然而，可以证明，$CV$ 往往会高估误差。事实上：
    $
      E n CV(1) 
      &= sum_(i = 1)^n E ((Y_i - hY_i)/(1 - h_i))^2 \
      &= sum_(i = 1)^n E ((I - P) Y)_i^2/(1 - h_i)^2\
      &= sum_(i = 1)^n E ((I - P) (mu + epsilon))_i^2/(1 - h_i)^2\
      &= sum_(i = 1)^n ((I - P) mu)_i^2/(1 - h_i)^2 + E ((I - P) epsilon)_i^2/(1 - h_i)^2\
      &= sum_(i = 1)^n ((I - P) mu)_i^2/(1 - h_i)^2 + E (quadFormSym(epsilon, (I - P) D_i (I- P)))/(1 - h_i)^2\
      &= sum_(i = 1)^n ((I - P) mu)_i^2/(1 - h_i)^2 + (sigma^2 tr((I - P) D_i (I - P)))/(1 - h_i)^2\
      &= sum_(i = 1)^n ((I - P) mu)_i^2/(1 - h_i)^2 + (sigma^2 tr((I - P) D_i))/(1 - h_i)^2\
      &= sum_(i = 1)^n ((I - P) mu)_i^2/(1 - h_i)^2 + (sigma^2 (1 - h_i))/(1 - h_i)^2\
      &= sum_(i = 1)^n ((I - P) mu)_i^2/(1 - h_i)^2 + (sigma^2)/(1 - h_i)\
      &>= sum_(i = 1)^n ((I - P) mu)_i^2 + (1 + h_i) (sigma^2)\
      &= norm2((I - P) mu) + (n + p) sigma^2\
      &= E "PZ"\

      where D_i &= diag(0, 0, ..., 1, ..., 0)\
    $
    #definition[Mellow's CP][
      对于线性模型，选择 $X' = X$ 就有：
      $
        RSS_p = Y^T (I - P) Y\
        E RSS_p = quadFormSym(mu, I - P) + (n - p) sigma^2\
        = E "ME" + (n - 2 p) sigma^2
      $
      因此：
      $
        (E "ME")/sigma^2 = (E RSS_p)/sigma^2 + (2 p - n)\
      $
      受此启发，假设 $htheta^2$ 是 $sigma^2$ 的估计值，定义：
      $
        C_p := RSS_p/htheta^2 + 2 p - n\
      $
    ]
    显然，若 $mu in im X$ 就有：
    $
      C_p approx p
    $
    #definition[K-L 散度][
      定义：
      $
        "KL"(f, g) = integral_()^() ln f(y)/g(y) f(y) dif y
      $
      常常用来度量两个分布之间的相似性。
    ]
    假设有一族函数 $g(y, theta)$，我们有：
    $
      "KL"(f, g(y, theta)) = C - E_(x tilde f) ln g(x, theta)
    $
    其中 $C$ 与 $theta$ 无关。如果我们的目标是找到最优的 $theta$，则可以直接考虑 $-E ln g(x, theta)$
    #let AIC = $"AIC"$
    #let BIC = $"BIC"$
    #definition[Akaike information criterion/Bayesian information criterion][
      定义：
      $
        AIC = -2 ln g(Y, htheta(Y)) + 2 r
      $
      其中 $r$ 是 $theta$ 的维数，$htheta(Y)$ 是根据 $Y$ 估计的参数的值。如果将 $2 r$ 换成 $a_n r$ 常见的 $a_n = ln n$，则称为 BIC(Bayesian information criterion)。
    ]
    在线性模型中，$Y tilde N(X beta, sigma^2 I)$，就有：
    $
      - ln g(Y, theta) = n/2 ln(2 pi sigma^2) + 1/(2 sigma^2) tMul(Y - X beta)\
    $
    如果使用极大似然估计 $hsigma^2 = RSS/n$：
    $
      htheta(Y) = P Y\
      Delta := - E_(Y_0 tilde f) ln g(Y_0, hbeta(Y)) = n/2 ln(2 pi hsigma^2) + 1/(2 hsigma^2) E_(Y_0) tMul(Y_0 - X hbeta(Y))\
      = n/2 ln(2 pi hsigma^2) + 1/(2 hsigma^2) (n sigma^2 + norm2(mu - X hbeta(Y)))\
      E_Y (2 Delta) = n E ln(2 pi hsigma^2) + (n sigma^2) E 1/hsigma^2 + E norm2(mu - X hbeta(Y)) dot 1/hsigma^2\
      =^"独立性" n E ln(2 pi hsigma^2) + (n sigma^2) E 1/hsigma^2 + E norm2(mu - X hbeta(Y)) E 1/hsigma^2\
      = n E ln(2 pi hsigma^2) + (n sigma^2) E 1/hsigma^2 + E "ME" E 1/hsigma^2\
      = n E ln(2 pi hsigma^2) + (n sigma^2) E 1/hsigma^2 + (lambda + p) sigma^2 E 1/hsigma^2\
      = n E ln(2 pi hsigma^2) + (n + lambda + p) E sigma^2/hsigma^2\
      where lambda = quadFormSym(mu, I - P)/sigma^2
    $
    比照 $E (2 Delta)$ 和 $AIC$，主要差别在于将 $lambda + p$ 换成 $2(p + 1)$，其余部分都是比较接近的。进一步，如果假设 $mu in im X$，则 $(n hsigma^2)/sigma^2 tilde chi^2(n - p). E sigma^2/hsigma^2 = n/(n - p - 2)$，此时：
    $
      E 2 Delta = n E ln(2 pi hsigma^2) + (n (n + p))/(n - p -2)\
      E (AIC - 2 Delta) = 2 (p + 1) - (2 n (p + 1))/(n - p - 2) approx^(n "充分大") 2
    $
    虽然它仍然并不是零，然而我们可以可以采用以下修正的 AIC:
    $
      AIC_c = n ln (2 pi hsigma^2) + (n(n - p))/(n - p -2)
    $
    立刻就有 $E AIC_c = E 2 Delta$

    假设 $sigma^2$ 是已知的，则：
    $
      AIC = RSS/sigma^2 + 2 p\
      BIC = RSS/sigma^2 + a_n p\
    $
    有时也用以下的值：
    $
      BIC = - 2 ln L + a_n p
    $
    替代之前的表达式，这里 $L$ 是似然函数。这里 $a_n$ 最常见的取值是 $ln n$。BIC 也被称为 SIC(Schwarz)，可以用贝叶斯推断的角度理解，它接近于后验概率的对数。
  == Shrinkage 方法
    前面提到过，可以通过增加正则项来降低预测误差。
    === Stein shrinkage
      假设 $Z in P(RR^p) tilde N(mu. sigma^2 I)$，如果要找 $mu$ 的估计值，在无偏估计中 $Z$ 本身当然就是最好的，然而事实上，可能找到更好的有偏估计。事实上：
      $
        E norm2(Z) = p sigma^2 + norm2(mu) > norm2(mu)
      $
      这表明估计值的模和真实值的模可能有相当大的偏差。如果使用 $c Z$ 做 $mu$ 的估计值，其平方损失：
      $
        E norm2(c Z - mu) = tr(var(c Z)) + norm2(E(C Z - mu))\
        = c^2 p sigma^2 + (1 - c)^2 norm2(mu)\
      $
      求导可得，$c - norm2(mu)/(p sigma^2 + norm2(mu))$ 时上式最小，且：
      $
        tilde(mu) = (1 - (p sigma^2)/(p sigma^2 + norm2(mu))) Z\
      $
      然而 $p sigma^2 + norm2(mu)$ 是未知的，之前已经计算得到 $norm2(Z)$ 是它的无偏估计，因此可以采用：
      $
        tilde(mu) = (1 - (p sigma^2)/(norm2(Z))) Z\
      $
      作为估计。可以证明，它比选择 $Z$ 的平方误差更小。同时，可以证明，在一族预测值：
      $
        tilde(mu) = (1 - b/(norm2(Z))) Z\
      $
      中：
      $
        tilde(mu) = (1 - ((p - 2) sigma^2)/(norm2(Z))) Z\
      $
      是平方误差最优的，称为 *Stein 估计*。这也可以从贝叶斯的角度理解，如果：
      $
        Z_i tilde N(mu_i, sigma^2), mu_i tilde N(0, sigma_0^2)
      $
      则：
      $
        mu | Z tilde N((1 - w) Z, w sigma_0^2 I)\
        where w = sigma^2/(sigma^2 + sigma_0^2)
      $
      自然的，$mu$ 的贝叶斯估计就是：
      $
        hat(mu) = (1 - w) Z
      $
      然而现实情况是，$sigma_0$ 并不确定。我们可以采用所谓的经验贝叶斯方法，考虑：
      $
        f(Z | sigma_0^2) = integral_()^() f(Z | mu, sigma_0^2) f(mu | sigma_0^2) dif mu = N(0, (sigma^2 + sigma_0^2) I)\ 
      $
      因此：
      $
        norm2(Z)/(sigma^2 + sigma_0^2) tilde chi^2(p)\
        E((sigma^2 + sigma_0^2)/norm2(Z)) = 1/(p - 2)\
        E (p - 2)/norm2(Z) = sigma^2 + sigma_0^2
      $
      用这个无偏估计代入 $(1 - w) z$，就可计算得：
      $
        hat(mu) approx (1 - ((p - 2) sigma^2)/(norm2(Z))) Z\
      $
      可见，Stein 估计就是参数先验分布为正态分布时，经验贝叶斯方法给出的估计值。

      类似的，在线性回归问题中，若设：
      $
        Y tilde N(X beta, sigma^2 I)\
        beta tilde N(0, 1/k sigma^2)
      $
      可以计算得，$beta$ 的贝叶斯估计就是：
      $
        hbeta = Inv(tMul(X) + k I) X^T Y = Inv(I + k Inv(tMul(X))) Inv(tMul(X)) X^T Y
      $
      事实上，这就是 ridge regression 的解。
      #theorem[][
        使用上面的 ridge regression 方法，则存在一个 $k$ 使得其 ME 小于标准线性回归的 ME
      ]
      #proof[
        $
          E("ME") = E_(X_0) norm2(X hbeta - X beta)\
          = E norm2(X C hbeta_0 - X beta)\
          = E norm2(X C hbeta_0 - X C beta + X C beta - X beta)\
          = E norm2(X C hbeta_0 - X C beta) + E norm2(X C beta - X beta) + 2 (E (X C hbeta_0 - X C beta))^T (E (X C beta - X beta))\
          = E norm2(X C hbeta_0 - X C beta) + norm2(X C beta - X beta)
        $
        若设 $X^T X = T Lambda T^T, alpha = T^T beta$，则可以计算得：
        $
          E norm2(X C hbeta_0 - X C beta) = tr(C^T X^T X C var (hbeta_0)) = sigma^2 tr(C^T X^T X C Inv(tMul(X)))
        $
        同时：
        $
          C = Inv(I + k Inv(tMul(X)))\
          = T Inv(I + k Inv(Lambda)) T^T
        $
        因此：
        $
          C^T tMul(X) C Inv(tMul(X)) = T Inv(I + k Inv(Lambda)) Lambda Inv(I + k Inv(Lambda)) Inv(Lambda) T^T\
        $
        其中除了 $T$ 外，中间的矩阵都是对角的，因此容易计算出其 trace。另一部分可以做类似的计算，总之我们有原式：
        $
          = sum_(j = 1)^p (alpha_i^2 k^2 lambda_i + sigma^2 lambda_i^2)/(k + lambda_i)^2
        $
        求导得：
        $
          sum_(j = 1)^p (2 lambda_j^2 (alpha_j^2 k - sigma^2))/(k + lambda_j)^2 
        $
        显然 $k = 0$ 时的 ME 就是标准回归的结果，而导数在 $0$ 附近为负，因此当 $k$ 较小时，确实有 ME 更小。
      ]
      至于具体的 $k$ 的选取，我们可以采用之前所说的 Jackknife 方法，也就是交叉验证方法。可以计算：
      $
        CV(1) = 1/n sum_(i = 1)^n (Y_i - x_i^T hbeta(k))/(1 - a_n (k))
      $
      其中 $a_n (k)$ 是 $X Inv(tMul(X) + k I) X^T$ 的 $i i$ 元。有时，也将分母统一替代为：
      $
        1/n tr(X Inv(tMul(X) + k I) X^T)
      $
      此时得到的值称为 _GCV(Generized cross-valiadation)_
    === Garrot estimate
      因为 ridge regression 无法直接用于变量选择，1995年人们提出了 Garrot estimate 方法。假设 $hbeta$ 是最小二乘估计，并设：
      $
        tbeta = diag{c_1, c_2, ..., c_(p)} hbeta
      $
      使得 $c_i >= 0, sum c_i <= s$，然后求解：
      $
        min_c norm2(Y - X tbeta) with c_i >= 0, sum_i c_i <= s
      $
      得到的结果就称为 _Garrot estimate_。事实上：
      $
        norm2(Y - X tbeta) = norm2(Y - X hbeta) + norm2(X (tbeta - hbeta)) + 2 inner(Y - X hbeta, X (tbeta - hbeta)) \
        = RSS + norm2(X (tbeta - hbeta))\
      $
      #lemma[][
        设 $alpha, beta in KK^n, diag(x)$ 是 $x$ 中元素组成的对角矩阵，则：
        $
          diag(alpha) beta = diag(beta) alpha
        $
      ]
      由引理，显然就有：
      $
        RSS + norm2(X (tbeta - hbeta)) = RSS + norm2(X diag(hbeta) C - X hbeta) := RSS + norm2(A C - d)
      $
      因此，原问题等价于：
      $
        min_C norm2(A C - d) with C >= 0, norm(C)_1 <= s
      $
      这是一个凸优化问题，可以利用凸优化的方法求解。我们考虑一个特殊情境，即 $X^T X = I$ 时，就有：
      $
        norm2(X (tbeta - hbeta)) = norm2(tbeta - hbeta) = norm2((I - diag(C)) hbeta)
      $
      直观上来说，应该将 $c_i$ 分配给比较大的 $hbeta_i$，因此可设解为：
      $
        c_j = cases(
          1 - lambda / hbeta_i "if" lambda <= hbeta_i,
          0 "otherwise"
        )
      $
      可见，此时确实有许多 $c_j = 0$，也就相当于在变量选择时抛离了。
    === Lasso estimate
      Lasso 方法是另一种 shrinkage 方法，相当于在 ridge 回归中，将 2 - 范数换为 1 - 范数，也就是：
      $
        min_beta norm2(Y - X beta) + lambda norm(beta)_1\
      $
      它的对偶问题是：
      $
        min_beta norm2(Y - X beta) with norm(beta)_1 <= s\
      $
      仍然考虑 $X$ 正交的简单情形，此时有：
      $
        norm2(Y - X beta) lambda norm(beta)_1 = RSS + norm2(X (beta - h beta)) + lambda norm(beta)_1\
        = RSS + norm2(beta - hbeta) + lambda norm(beta)_1\
        = RSS + sum_j (beta_j - hbeta_j)^2 + lambda abs(beta_j)
      $
      事实上，求和的每一项之间没有什么关系，只需要考虑：
      $
        min_beta_j (beta_j - hbeta_j)^2 + lambda abs(beta_j)
      $
      可以计算得：
      $
        beta_j = cases(
          sgn(hbeta_j) (abs(hbeta_j) - lambda) "if" lambda/2 <= abs(hbeta_j),
          0 "otherwise"
        )
      $
      相当于将 $hbeta$ 的分量向 $0$ 压缩，较小的分量直接压缩到零，因此就将这些变量筛选掉了。或者考虑到此时 $hbeta_j = X_i^T Y$，我们有：
      $
        beta_j = cases(
          X_i^T Y - sgn(X_i^T Y) lambda "if" lambda/2 <= abs(X_i^T Y),
          0 "otherwise"
        )
      $

      接下来，设 $tbeta$ 是 Lasso 估计，我们需要考虑： 
      - model error:
        $
          norm2(X beta - X tbeta)
        $
      - parameter error:
        $
          norm2(beta - tbeta)
        $
      - model selection(consistency):
        $
          P("supp"(beta) = "supp"(hbeta))
        $
      一般来说，直接计算这些值是比较困难的。常见的方法是构造事件 $A$ 使得 $P(A) = 1 - epsilon$，并且在 $A$ 成立时，上面的性质比较容易分析。

      事实上，若设：
      $
        A = {2 norm(epsilon^T X)_infinity < lambda}
      $
      则在 $A$ 成立时有：
      $
        2 abs(X_i^T Y) = 2 abs(X_i^T (X beta + epsilon)) = 2 abs(beta_j + X_i^T epsilon)
      $
      若还有 $beta_j = 0$，立刻有 $2 abs(X_i^T epsilon) <= lambda => tbeta_i = 0$。而若 $abs(beta_j) > lambda$，可以计算得：
      $
        2 abs(X_i^T Y) = 2 abs(beta_j + X_i^T epsilon) >= 2 abs(beta_j) - 2 norm(epsilon^T X)_infinity >= lambda
      $
      也就有 $tbeta_j != 0$

      这就意味着，只要 $beta$ 满足非零分量的绝对值不小于 $lambda$，就有：
      $
        "supp" (beta) = "supp"(tbeta)\
      $
      #let hbetao = $hbeta^("oracle")$
      接下来，设 $S = {j | beta_j != 0}, s = abs(S), X_S$ 是 $X$ 中 $S$ 对应的列形成的矩阵，$hbetao$ 是仅使用这些数据得到的最小二乘估计：
      $
        hbetao = Inv(tMul(X_S)) X_S^T Y
      $
      在 $A$ 上，我们有：
      $
        norm(tbeta - beta) = norm(tbeta_s - beta_s) \
        <= norm(tbeta_s - hbetao) + norm(hbetao - beta_s)\
        = sqrt(sum_(i in S) (sgn(X_i^T Y) lambda)^2) + norm(hbetao - beta_s)\
        = lambda sqrt(abs(S)) + norm(hbetao - beta_s)\
      $
      当数据足够多时，上式后项应该较小。而当 $lambda$ 比较小时，前项也比较小，就有参数的误差比较小。由于我们假设 $X$ 正交，就有：
      $
        norm2(X beta - X tbeta) = norm2(beta - tbeta)
      $
      因此，模型误差和参数误差是相同的。

      注意到：
      $
        norm2(Y - X tbeta) + lambda norm(tbeta)_1 <= norm2(Y - X beta) + lambda norm(beta)_1\
        = tMul(Y) + beta^T X^T X beta - 2 Y^T X beta + lambda norm(beta)_1\
        = tMul(Y) - beta^T X^T X beta - 2 epsilon^T X beta + lambda norm(beta)_1\
      $
      可以类似计算得：
      $
        norm2(Y - X tbeta) + lambda norm(tbeta)_1 = tMul(Y) + tbeta^T X^T X tbeta - 2 beta^T X^T X beta - 2 epsilon^T X beta + lambda norm(beta)_1
      $
      不等式给出：
      $
        tbeta^T X^T X tbeta - 2 beta^T X^T X beta - 2 epsilon^T X beta + lambda norm(beta)_1 <= - beta^T X^T X beta - 2 epsilon^T X beta + lambda norm(beta)_1\
        norm2(X (tbeta - beta)) <= 2 epsilon^T X (tbeta - beta) + lambda (norm(beta)_1 - norm(tbeta)_1)\
      $
      Holder 不等式给出，$A$ 成立时：
      $
        2 abs(epsilon^T X (tbeta - beta)) <= 2 norm(epsilon^T X)_infinity norm(tbeta - beta)_1\
        <= lambda norm(tbeta - beta)_1
      $
      因此：
      $
        norm2(X (tbeta - beta)) <= lambda (norm(tbeta - beta)_1 + norm(tbeta)_1 - norm(beta)_1)\
        <= 2 lambda norm(beta)_1\
      $
      （上面的推导在不假设 $X$ 正交的情形下也成立）
      #lemma[][
        设 $Z_j tilde N(0, sigma^2), j = 1, 2, ..., p$ 独立同分布，则:
        $
          E(max Z_j) <= sigma sqrt(2 ln (2 p))\
        $
      ]
      注意到 $epsilon^T X_j$ 独立同分布，由正态分布的性质有：
      $
        E norm(epsilon^T X)_infinity <= sigma sqrt(2 ln (2 p))
      $
      因此由熟知的不等式：
      $
        P (norm(epsilon^T X)_infinity >= a/2) <= (E norm(epsilon^T X)_infinity) / (a / 2) <= sigma sqrt(8 ln (2 p)) / a\
      $
      这就得到了 $P(A)$ 的一个控制。事实上，有时我们也会设：
      $
        X^T X = n I
      $
      问题重缩放为：
      $
        norm2(Y - X beta) + lambda sqrt(n) norm(beta)_1\
      $
      最终，我们可以得到下面的结论：
      #theorem[][
        对一般的 $X$ 我们有：
        $
          norm2(X(beta - tbeta)) <= 2 epsilon^T X (tbeta - beta) + lambda (norm(beta)_1 - norm(tbeta)_1)\
        $
        如果 $norm2(X_i) = 1$，设 $cal(A) = 2 norm2(epsilon^T X) <= lambda$ 成立，则：
        $
          norm2(X(beta - tbeta)) <= 2 lambda norm(beta)_1\
          P(A) >= 1 - Inv(A) where lambda >= A sqrt(8 ln (2 p) sigma^2)
        $
      ]
      #theorem[][
        若 $X^T X = n I$，则对 $lambda > A sqrt(Inv(n) ln (2p) sigma^2)$，在 $cal(A)$ 成立时有：
        $
          norm2(X (beta - tbeta))/n <= 2 lambda/sqrt(n) norm(beta)_1
        $
        并且：
        $
          cal(A) = {2 norm(1/sqrt(n) epsilon^T X)_infinity <= lambda}\
          p(cal(A)) >= 1 - Inv(A)
        $
      ]
      接下来，我们考虑一般的 $X$. 设 $lambda_0 > 0, lambda > 2 lambda_0$，则在 $cal(A)(lambda_0) = {2 norm(epsilon^T X)_infinity <= lambda_0}$ 上有：
      $
        norm2(X(beta - tbeta)) + lambda norm(tbeta)_1 <= 2 epsilon^T X (tbeta - beta) + lambda norm(beta)_1\
        <= 2 norm(epsilon^T X)_infinity norm(tbeta - beta)_1 + lambda norm(beta)_1\
        <= lambda_0 norm(tbeta - beta)_1 + lambda norm(beta)_1\
        <= lambda/2 norm(tbeta - beta)_1 + lambda norm(beta)_1\
      $
      仿照之前的方法定义 $S$ 就有：
      $
        norm(tbeta)_1 = norm(tbeta_S)_1 + norm(tbeta_(S^c))_1 >= norm(beta_S)_1 - norm(beta_S - tbeta_S)_1 + norm(tbeta_(S^c))_1\
        norm(tbeta - beta)_1 = norm(tbeta_S - beta_S)_1 + norm(tbeta_(S^c) - beta_(S^c))_1 = norm(tbeta_S - beta_S)_1 + norm(tbeta_(S^c))_1\
        norm(beta)_1 = norm(beta_S)_1
      $
      代入前式，化简得：
      $
        2 norm2(X(beta - tbeta)) + lambda norm(tbeta_(S^C))_1 <= 3 lambda norm(tbeta_S - beta_S)_1
      $
      这表明：
      - $norm(tbeta_(S^C))_1 <= 3 norm(tbeta_S - beta_S)_1$，表明在支集之外，参数的估计不会太大
      - $2 norm2(X(beta - tbeta)) <= 3 lambda norm(tbeta_S - beta_S)_1$，若设 $sigma_min$ 是 $X$ 的最小奇异值，立刻有：
        $
          2 sigma_min^2 norm2(beta - tbeta) <= 3 lambda norm(tbeta_S - beta_S)_1 <= 3 lambda sqrt(abs(S)) norm(tbeta_S - beta_S)_2\
          <= 3 lambda sqrt(abs(S)) norm(tbeta - beta)_2
        $
        也即：
        $
          norm2(beta - tbeta) <= (3 lambda sqrt(abs(S)))/ sigma_min^2\
        $
        当然如果 $p > n$，就导致 $sigma_min = 0$，此时上面的结果是无效的。
      当然，上面的放缩还可以更加精细。
      #definition[][
        设:
        $
          v_S = {v in RR^p | norm(v_(S^C))_1 <= 3 norm(v_S)_1}\
        $
        称 $X$ 在其上的 restricted eigenvalue 是：
        $
          Phi_s = argmin_(v in v_s) norm(X v)_2/norm(v)_2
        $
        以及：
        $
          Phi = min_(abs(S) <= abs(S_0)) Phi_s
        $
      ]
      由上面的结果我们有：
      $
        2 norm2(X(tbeta - beta)) + lambda norm(tbeta - beta)_1 = 2 norm2(X(tbeta - beta)) + lambda norm(tbeta_S - beta_S)_1 + lambda norm(tbeta_(S^C))_1\
        <= 4 lambda norm(tbeta_S - beta_S)_1 <= 4 lambda sqrt(abs(S)) norm(tbeta_S - beta_S)_2\
        <= 4 lambda sqrt(abs(S)) norm(X (tbeta - beta))/Phi\
        <= norm2(X (tbeta - beta)) + 4 (lambda^2 S)/Phi^2
      $
      因此：
      $
        norm2(X(tbeta - beta)) + lambda norm(tbeta - beta)_1 <= 4 (lambda^2 S)/Phi^2
      $

      当然，Lasso 还有一些改进，例如使用弹性网惩罚 $lambda (alpha norm(beta) + (1 - beta) norm(beta)_1)$，它在预测问题上可能更好，但参数更多，超参数通常不好选择。

      前面提到过，如果假设 $beta$ 服从正态的先验分布，则得到的贝叶斯估计就是 ridge regression 的解。事实上，Lasso 也可以看作是贝叶斯方法的结果。同样的，如果假设 $beta$ 服从双指数分布，则得到的贝叶斯估计就是 Lasso 的解。

