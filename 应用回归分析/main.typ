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
        E(x^T A x) = tr(A var(X)) + E(x)^T A E(x)
      $
      进一步，若 $var(X) = sigma^2 I$（例如 $X$ 是独立同分布的正态随机变量），则上式等于：
      $
        sigma^2 tr(A) + E(x)^T A E(x)
      $
    ]
    #proof[
      $
        E(x^T A x) = E(tr(x^T A x)) = E(tr(A x x^T)) = tr(A E(x x^T)) \
        = tr(A(var(X) + E(X) E(X)^T)) = tr(A var(X)) + E(x)^T A E(x)
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
      - 另一方面，假设 $A B = 0$，则任取 $RR$ 中可测集 $(-infinity, x)$，有：
      $
        (Y^T A Y)^(-1) ((-infinity, x)) = {Y | norm(A Y) < sqrt(x)} = Inv(A) ({Y | norm(Y) < sqrt(x)})\
        (Y^T B Y)^(-1) ((-infinity, y)) = Inv(B) ({Y | norm(Y) < sqrt(y)})
      $
      由于 $A B = B A = 0$，我们有：
      $
        im B subset ker A, im A subset ker B\
      $
      因此：
      $
        Inv(A) ({Y | norm(Y) < sqrt(x)}) inter Inv(B) ({Y | norm(Y) < sqrt(y)})
      $

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
        var (d^Y) - var(c^T hat(theta))\
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
      &=  norm(X(hb - hb0))^2 + norm(X (hb0 - beta)) + lambda^T A Inv(tMul(X)) tMul(X)  (hb - beta)\ 
      &=  norm(X(hb - hb0))^2 + norm(X (hb0 - beta)) + lambda^T A (hb - beta)\ 
      &=  norm(X(hb - hb0))^2 + norm(X (hb0 - beta)) + lambda^T (c - c)\ 
      &=  norm(X(hb - hb0))^2 + norm(X (hb0 - beta))\ 
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
      - $(B gInv(B))^T = B gInv(B)$
      - $(gInv(B) B)^T = gInv(B) B$
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
      称 $a^T beta$ 是可估计的，如果存在 $a^T b$ 使得 $b^T Y$ 是 $a^T beta$ 的无偏估计。换言之：
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
  #let hsigma = $hat(sigma)$
  #let hY = $hat(Y)$
  给定模型 $Y = X beta + epsilon$，其中 $X$ 列满秩，$epsilon$ 服从 $N(0, sigma^2 I)$. 我们有时会关心某个条件是否成立，也即：
  $
    H: A beta = C
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
      (n - 2)S^2 = sumBrN1(Y_i - overline(Y)) - hbeta_1 sumBrN1((X_i - Xbar)^2) = sumBrN1(Y_i - overline(Y))^2 - sumBrN1(hat(Y)_i - overline(Y))
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
      r^2 = (sumBrN1((hat(Y)_i - overline(Y))^2))/(sumBrN1((Y_i - overline(Y))^2)) = (hbeta_1^2 sumBrN1((x_i - Xbar)))/(sumBrN1((Y_i - overline(Y))^2)) = sumBrN1((Y_i - overline(Y))(X_i - Xbar))^2/(sumBrN1((Y_i - overline(Y))^2) sumBrN1((X_i - Xbar)^2))
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
  #definition[][
    定义：
    $
      R^2 = (sumBrN1((hat(Y)_i - overline(Y))^2))/(sumBrN1((Y_i - overline(Y))^2))
    $
    相当于预测值的方差占原始方差的比例，也是真实值 $Y$ 与预测值 $hat(Y)$ 的相关系数的平方。
  ]
