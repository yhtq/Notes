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