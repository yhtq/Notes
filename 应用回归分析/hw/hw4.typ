#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
Page 196 8a.1, 8a.2, 8a.4\
Page 205 8b.1, 8b.2, 8b.3\
Page 209 8c.1, 8c.2, 8c.3\
Page 225 MISCELLANEOUS EXERCISES 8.1, 8.2, 8.3\
Page 231 9a.2\
Page 232 9b.2\
Page 262 9d.2, 9d.4\
Page 263  MISCELLANEOUS EXERCISES 9.2\
= p196
  == 8a.1
    注意到：
    $
      mu = autoVecN(mu, I)
    $
    因此取：
    $
      A = mat(1, -1, 0, ..., 0;
              1, 0, -1, ..., 0;
              dots.v, dots.v, dots.v, dots.down, dots.v;
              1, 0, 0, ..., -1;
      )
    $
    即可。事实上，也可以取：
    $
      A = mat(1, -1, 0, ..., 0, 0;
              0, 1, -1, ..., 0, 0;
              dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
              0, 0, 0, ..., 1, -1;
      )
    $
    由于它们都表示同一个线性方程组，应当可以通过行变换得到，也即存在可逆矩阵 $C$ 使得：
    $
      A = C A_1
    $
  == 8a.2
    令：
    $
      Y = autoVecN(Y, I)
    $
    以及用 $1$ 表示 $autoVecNF(#(i => $1$), n)$，尺寸根据与其计算的向量和矩阵一致。

    则结论变为：
    $
      norm2(Y - 1/J 1^T Y 1) = norm2(Y - autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) ) + norm2(autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) - 1/J 1^T Y 1)
    $
    显然，只需验证：
    $
       inner(Y - autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) ,autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) - 1/J 1^T Y 1) = 0
    $
    事实上：
    $
      &inner(Y - autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) ,autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) - 1/J 1^T Y 1) \
      &= sum_i inner(Y_i - 1/J_i 1^T Y_i 1, 1/J_i 1^T Y_i 1 - 1/J 1^T Y 1) \
      &= sum_i inner(Y_i - 1/J_i 1^T Y_i 1, (1/J_i 1^T Y_i  - 1/J 1^T Y) 1) \
      &= 0\
    $
    // 事实上：
    // $
    //   inner(Y - autoRVecNF(#(i => $onen(Y_i)^T$), I) Y,autoRVecNF(#(i => $onen(Y_i)^T$), I) Y - onen(Y)^T Y) &= inner((I))
    // $
    // 证毕
  == 8a.4
    计算：
    $
      norm2(autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) - 1/J 1^T Y 1) &= sum_i norm2(1/J_i 1^T Y_i 1 - 1/J 1^T Y 1)\
      &= sum_i J_i Ybar_i^2 + J_i Ybar^2 - 2 J_i Ybar_i Ybar\
      &= sum_i J_i Ybar_i^2 + n Ybar^2 - 2 Ybar sum_i J_i Ybar_i\
      &= sum_i J_i Ybar_i^2 + n Ybar^2 - 2 Ybar n Ybar^2\
      &= sum_i J_i Ybar_i^2 - n Ybar^2\
    $
    这就是结论。

    类似的：
    $
      norm2(Y - autoVecNF(#(i => $1/J_#i 1^T Y_#i 1$), I) ) &= sum_i norm2(Y_i - Ybar_i 1) \
      &= sum_i norm2(Y_i) + J_i Ybar_i^2 - 2 inner(Y_i, Ybar_i 1)\
      &= sum_i norm2(Y_i) + J_i Ybar_i^2 - 2 Ybar_i  inner(Y_i, 1)\
      &= sum_i norm2(Y_i) + J_i Ybar_i^2 - 2 J_i Ybar_i^2\
      &= sum_i norm2(Y_i) - J_i Ybar_i^2\
      &= norm2(Y) - sum_i J_i Ybar_i^2\
    $
    // 注意到：
    // $
    //   norm2(autoVecNF(#(i => $onen(Y_i)$), I) - onen(Y)) = norm2(autoVecNF(#(i => $(1/J_#i - 1/J) 1_(J_#i)$), I)) 
    // $
= p205
  == 8b.1
    - $H_(A B) => H_(A B 1)$ 显然
    - $H_(A B) => H_(A B 2)$ 显然
    - $H_(A B 1) => H_(A B)$ 由条件有：
      $
        mu_(i_1 j_1) - mu_(I j_1) - mu_(i_1 J) + mu_(I J) = 0
      $<eq-1>
      $
        mu_(i_1 j_2) - mu_(I j_2) - mu_(i_1 J) + mu_(I J) = 0
      $<eq-2>
      $
        mu_(i_2 j_1) - mu_(I j_1) - mu_(i_2 J) + mu_(I J) = 0
      $<eq-3>
      $
        mu_(i_2 j_2) - mu_(I j_2) - mu_(i_2 J) + mu_(I J) = 0
      $<eq-4>
      //   mu_(i_1 j_2) - mu_(I j_2) - mu_(i_1 J) + mu_(I J) = 0\
      //   mu_(i_2 j_1) - mu_(I j_1) - mu_(i_2 J) + mu_(I J) = 0\
      //   mu_(i_2 j_2) - mu_(I j_2) - mu_(i_2 J) + mu_(I J) = 0\
      // $
      @eq-1 $+$ @eq-4 $-$ @eq-2 $-$ @eq-3 就有：
      $
        mu_(i_1 j_1) + mu_(i_2 j_2) - mu_(i_1 j_2) - mu_(i_2 j_1) = 0
      $
      这就是结论。
    - $H_(A B 2) => H_(A B)$ 同理
    - $H_(A B) => H_(A B 3)$ 课本已经证明
    - $H_(A B 3) => H_(A B 2)$ 有：
      $
        mu_(i j) - mubar_i - mubar_j + mubar = 0\
        mu_(i 1) - mubar_i - mubar_1 + mubar = 0\
        mu_(1 j) - mubar_1 - mubar_j + mubar = 0\
        mu_(1 1) - mubar_1 - mubar_1 + mubar = 0
      $ 
      就有：
      $
        mu_(i j) + mu_(1 1) - mu_(i 1) - mu_(1 j) = 0
      $
  == 8b.2
    $
      sum_(i j) mu_(i j) = sum_(i j) mu + alpha_i + beta_j + (alpha beta)_(i j) = n mu => mu = 1/n sum_(i j) mu_(i j)\
      sum_i mu_(i j) = I_j (mu + beta_j)  => beta_j = 1/I_j sum_i mu_(i j) - mu\
      sum_j mu_(i j) = J_i (mu + alpha_i)  => alpha_i = 1/J_i sum_j mu_(i j) - mu\ 
      (alpha beta)_(i j) = mu_(i j) - mu - alpha_i - beta_j\
    $
  == 8b.3
    熟知：
    $
      RSS_H - RSS = norm2(hY - hY_H) = sum_(i j) I_(i j) (Ybar_(i j) - Ybar)^2\
      RSS = sum_(i j k) (Y_(i j k) - Ybar_(i j))^2\ 
    $
    因此：
    $
      F = ((sum_(i j) I_(i j) (Ybar_(i j) - Ybar)^2) / (I J - 1)) / ((sum_(i j k) (Y_(i j k) - Ybar_(i j))^2) / (n - I J))\
    $
    并且：
    $
      E ((sum_(i j) I_(i j) (Ybar_(i j) - Ybar)^2) / (I J - 1)) = 1/(I J - 1) sum_(i j) I_(i j) E (Ybar_(i j) - Ybar)^2\
    $
    而：
    $
      E (Ybar_(i j) - Ybar)^2 &= var(Ybar_(i j) - Ybar) = var(Ybar_(i j)) + var(Ybar) - 2 cov(Ybar_(i j), Ybar)\
      &= 1/(I_(i j)) sigma^2 + 1/n sigma^2 - 2 cov(Ybar_(i j), sum_(i j) I_(i j)/n Ybar_(i j))\
      &= 1/(I_(i j)) sigma^2 + 1/n sigma^2 - 2 cov(Ybar_(i j), I_(i j)/n Ybar_(i j))\
      &= 1/(I_(i j)) sigma^2 + 1/n sigma^2 - 2 I_(i j)/n var(Ybar_(i j))\
      &= 1/(I_(i j)) sigma^2 + 1/n sigma^2 - 2 I_(i j)/n 1/(I_(i j)) sigma^2\
      &= 1/(I_(i j)) sigma^2 - 1/n sigma^2
    $
    因此原式等于：
    $
       1/(I J - 1) sum_(i j) I_(i j) (1/(I_(i j)) sigma^2 - 1/n sigma^2)= 1/(I J - 1) (I J - 1) sigma^2 = sigma^2
    $
= p209
  == 8c.1
    === (a)
      将 $K$ 方向合并，就是 8a.4

      类似的：
      $
        &sum_(i j k) (Ybar_(i j) - Ybar_i - Ybar_j + Ybar)^2 \
        &= K sum_(i j) Ybar_(i j)^2 + J K sum_i Ybar_i^2 + I K sum_j Ybar_j^2 + I J K Ybar^2 \
        &- 2 K sum_(i j) Ybar_(i j) Ybar_i - 2 K sum_(i j) Ybar_(i j) Ybar_j + 2 K sum_i Ybar_i sum_j Ybar_j\
        &= K sum_(i j) Ybar_(i j)^2 + J K sum_i Ybar_i^2 + I K sum_j Ybar_j^2 + I J K Ybar^2 - 2 J K sum_(i) Ybar_i^2 - 2 I K sum_(j) Ybar_j^2 + 2 I J K Ybar^2\
        &= K sum_(i j) Ybar_(i j)^2 - J K sum_i Ybar_i^2 - I K sum_j Ybar_j^2 + 3 I J K Ybar^2\
      $
    === (b)
      $
        E((I - 1) S_A^2) = E(J K sum_i halpha_i^2) = J K sum_i E(halpha_i^2) = J K sum_i var(halpha_i) + J K sum_i alpha_i^2 
      $
      其中：
      $
      var(halpha_i) &= var(Ybar_i - Ybar) \
      &= var(Ybar_i) + var(Ybar) - 2 cov(Ybar_i, Ybar) \
      &= var(Ybar_i) + 1/(I J K) sigma^2 - 2 cov(Ybar_i, sum_(i) 1/I Ybar_(i)) \
      &= var(Ybar_i) + 1/(I J K) sigma^2 - 2 cov(Ybar_i, 1/I Ybar_(i)) \
      &= var(Ybar_i) + 1/(I J K) sigma^2 - 2/I var(Ybar_i) \
      &= (1 - 2/I) 1/(J K) sigma^2 + 1/(I J K) sigma^2  \
      &= (1/(J K) - 1/(I J K)) sigma^2  \
      $
      因此原式等于：
      $
        J K sum_i var(halpha_i) + J K sum_i alpha_i^2  = (I - 1) sigma^2 + J K sum_i alpha_i^2
      $
      其余两个等式是类似的
  == 8c.2
    === (a)
      $
        sum_i mu_i alpha_i = sum_i mu_i (sum_j nu_j mu_(i j) - mu) = sum_(i j) mu_i nu_j mu_(i j) - sum_i mu_i mu = mu - mu = 0
      $
      $sum_j nu_j beta_j$ 同理
      $
        sum_i mu_i (alpha beta)_(i j) = sum_i mu_i (mu_(i j) - A_i - B_j + mu) = sum_i mu_i (mu_(i j) - alpha_i - B_j) = sum_i mu_i (mu_(i j) - B_j)\
        = sum_i mu_i mu_(i j) - B_j = 0
      $
      $sum_j nu_j (alpha beta)_(i j)$ 同理
    === (b)
      $
      sum_(i j) mu_i nu_j mu_(i j) = mu + 0 + 0 + 0 = mu\
      sum_i mu_i mu_(i j) = mu + 0 + beta_j + 0 = mu + beta_j\
      sum_j nu_j mu_(i j) = mu + 0 + 0 + alpha_i = mu + alpha_i\
      (alpha beta)_(i j) = mu_(i j) - mu - alpha_i - beta_j
      $
      以上式子足以唯一解出参数
    === (c) 
      假设在权重 $mu, nu$ 下，$(alpha beta) = 0$，则当权重为 $mu', nu'$ 时，有：
      $
        mu_(i j) = mu' + alpha'_i + beta'_j + (alpha' beta')_(i j)\
      $
      代入上题结论：
      $
        0 = (mu' + alpha'_i + beta'_j + (alpha' beta')_(i j)) - sum_i mu_i ((mu' + alpha'_i + beta'_j + (alpha' beta')_(i j))) \ 
        - sum_j nu_j ((mu' + alpha'_i + beta'_j + (alpha' beta')_(i j))) + sum_(i j) mu_i nu_j (mu' + alpha'_i + beta'_j + (alpha' beta')_(i j))\
        = (alpha' beta')_(i j) - sum_s mu_s (alpha' beta')_(s j) - sum_t nu_t (alpha' beta')_(i t) + sum_(s t) mu_s nu_t (alpha' beta')_(s t)\
      $
      继而：
      $
        0 = sum_(i j) mu'_i nu'_j ((alpha' beta')_(i j) - sum_s mu_s (alpha' beta')_(s j) - sum_t nu_t (alpha' beta')_(i t) + sum_(s t) mu_s nu_t (alpha' beta')_(s t)) \
        = sum_(s t) mu_s nu_t (alpha' beta')_(s t)\
        0 = (alpha' beta')_(i j) - sum_s mu_s (alpha' beta')_(s j) - sum_t nu_t (alpha' beta')_(i t) 
      $
      $
        0 = sum_i mu'_i ((alpha' beta')_(i j) - sum_s mu_s (alpha' beta')_(s j) - sum_t nu_t (alpha' beta')_(i t))\
        = sum_s mu_s (alpha' beta')_(s j), forall j
      $
      同理：
      $
        0 = sum_t nu_t (alpha' beta')_(i t), forall i
      $
      代回即得 $(alpha' beta')_(i j) = 0, forall i j$
  == 8c.3
    使用按照提示的 $mu_i$ 和 $nu_j$ 作为系数，就有：
    $
      sum_(i j k) alpha_i = K sum_i mu_i alpha_i = 0\
      sum_(i j k) beta_j = K sum_j nu_j beta_j = 0\  
    $
    当 $H$ 成立时，残差为：
    $
      RSS &= sum_(i j k) (Y_(i j k) - mu - alpha_i - beta_j)^2\
      &= sum_(i j k) (Y_(i j k) - mu)^2 + alpha_i^2 + beta_j^2 - 2 sum_(i j k) (Y_(i j k) - mu) alpha_i - 2 sum_(i j k) (Y_(i j k) - mu) beta_j\
    $
    $mu$ 的最小二乘估计当然是 $Ybar$，代入上式：
    $
      sum_(i j k) (Y_(i j k) - Ybar)^2 + alpha_i^2 + beta_j^2 - 2 sum_(i j k) (Y_(i j k) - mu) alpha_i - 2 sum_(i j k) (Y_(i j k) - mu) beta_j\
      =  sum_(i j k) (alpha_i -( Y_(i j k) - Ybar))^2 + sum_(i j k) (beta_j - (Y_(i j k) - Ybar))^2 - sum_(i j k) (Y_(i j k) - Ybar)^2\
    $
    可以看出 $alpha_i$ 的最小二乘估计应当就是 $Ybar_i - Ybar$，同时：
    $
      sum_i mu_i alpha_i = 1/K sum_i K_i (Ybar_i - Ybar) 0
    $
    说明它也满足约束。类似的，$beta_j$ 的最小二乘估计就是 $Ybar_j - Ybar$，上式也给出了：
    $
      RSS_H = sum_(i j k) (Y_(i j k) - Ybar_i)^2 + sum_i (Y_(i j k) - Ybar_j)^2 - sum_j (Y_(i j k) - Ybar)^2\
    $
    以及熟知：
    $
      RSS = sum_(i j k) (Y_(i j k) - Ybar_(i j))^2
    $
    得到 $F$ 统计量：
    $
      F = ((RSS_H - RSS) / (I J - I - J + 1)) / (RSS / (n - I J))\
    $
= p225
  == 8.1
    考虑 ANOVA 模型：
    $
      Y_(i j) = mu + alpha_i + beta_j + epsilon_(i j)
    $
    满足对称约束，则题中前式是假设 $alpha_i = 0$ 下的 $RSS_H - RSS$，后式是一般的 $RSS$，当然是独立的。
  == 8.2
    $
      RSS = sum_(i j) (Y_(i j) - mu - alpha_i)^2
    $
    拉格朗日函数为：
    $
      L = sum_(i j) (Y_(i j) - mu - alpha_i)^2 - lambda sum_i d_i alpha_i
    $
    求导得：
    $
      0 = partialDer(L, mu) = - 2 sum_(i j) (Y_(i j) - mu - alpha_i)\
      0 = partialDer(L, alpha_i) = - 2 sum_(j) (Y_(i j) - mu - alpha_i) - lambda d_i\
      sum_i d_i alpha_i = 0
    $
    求和得：
    $
      0 = - 2 sum_(i j) (Y_(i j) - mu - alpha_i) = lambda sum_i d_i
    $
    立刻得到 $lambda = 0$，只需解：
    $
      sum_(i j) Y_(i j) = I J mu + J sum_i alpha_i\
      sum_i d_i alpha_i = 0\
      J alpha_i = sum_j (Y_(i j) - mu)\
      0 = J sum_i d_i alpha_i = sum_(i j) d_i Y_(i j) - J sum_(i) d_i mu
    $
    因此：
    $
      mu  = 1/(J sum_(i) d_i) sum_(i j) d_i Y_(i j)\
      alpha_i = 1/J sum_j (Y_(i j) - mu)\
    $
  == 8.3
    == (a)
      熟知最小二乘估计为：
      $
        mu = Ybar\
        alpha_i = Ybar_i - Ybar\
        beta_(i j) = Ybar_(i j) - Ybar_i
      $
      而：
      $
        cov(alpha_i, beta_(i j)) = cov(Ybar_i - Ybar, Ybar_(i j) - Ybar_i)
        &= cov(1/J sum_j Ybar_(i j) - 1/(I J) sum_(i j) Ybar_(i j), Ybar_(i j)) - cov(Ybar_i - 1/I sum_i Ybar_i , Ybar_i)\
        &= cov(1/J Ybar_(i j) - 1/(I J) Ybar_(i j), Ybar_(i j)) - cov(Ybar_i - 1/I Ybar_i , Ybar_i)\
        &= (1/J - 1/(I J)) var(Ybar_(i j)) - (1 - 1/I) var(Ybar_i)\
        &= (1/J - 1/(I J)) 1/K sigma^2 - (1 - 1/I) 1/(J K) sigma^2\
        &= 0
      $
      注意到它们都是多元正态变量 $Y$ 的线性组合，因此它们不相关导出独立
    == (b)
      $
        RSS = sum_(i j k) (Y_(i j k) - Ybar_(i j))^2\
      $
      $H_1$ 成立时，不难看出最小二乘估计为 $mu = Ybar, alpha_i = Ybar_i - Ybar$，因此：
      $
        RSS_H_1 = sum_(i j k) (Y_(i j k) - Ybar_i)^2 \
        F_1 = ((RSS_H_1 - RSS) / (I J - I))/(RSS / (I J K - I J))
      $
      而 $H_2$ 也成立时，当然：
      $
        RSS_H_2 = sum_(i j k) (Y_(i j k) - Ybar)^2 \
        F_2 = ((RSS_H_2 - RSS_H_1) / (I - 1))/(RSS_H_1 / (I J K - I))
      $
= p231
  == 9a.2
    $
      E(Y - X hbeta) = E Y - E X_1 beta_1 = 0\
      var(Y - X hbeta) = E(quadFormSym(Y, I - P)) = (n - p) sigma^2
    $
= p232
  == 9b.2
    设 $Inv(V) X = X W$，则：
    $
      beta^* = Inv(W^T X^T X) W^T X^T Y = Inv(X^T X) X^T Y = hbeta
    $
= p262
  == 9d.2
    注意到：
    $
      1 - R_j^2 = norm2((I - P_j) X_j) = inner(X_j, X_j - P_j X_j) = 1 - inner(X_j, P_j X_j)
    $
    因此 $R_j^2 = 0 <=> inner(X_j, P_j X_j) = 0$，这就是说 $X_j$ 与其他列独立
  == 9d.4 
    #let Rxx = $R_(x x)$
    熟知 $Rxx$ 是对称正定的，题目所求为：
    $
      1 <= rho(Rxx) <= p - 1
    $
    其中 $rho$ 是谱半径。事实上我们有：
    $
      rho(Rxx) <= norm(Rxx)_F = p -1
    $
    以及：
    $
      rho(Rxx) >= norm(Rxx vec(1, 0, dots.v, 0)) = 1
    $
    就得到了结论。接着，我们有：
    $
      "VIF"_j = sum_(l = 1)^(p - 1) t_(j l)^2 / lambda_l <= sum_(l = 1)^(p - 1) t_(j l)^2 / lambda_min = 1 /lambda_min <= lambda_max/lambda_min = kappa^2
    $
= p263
  == 9.2
    这是 underfitting 的情况，我们有：
    $
      E(e) = (I - X_1 Inv(tMul(X_1)) X_1^T) X_2 beta_2 = X_2 beta_2 -  X_1 Inv(tMul(X_1)) X_1^T X_2 beta_2
    $
    就可以得到结论。