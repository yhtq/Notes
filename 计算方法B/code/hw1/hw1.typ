#import "../../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1.
  设 $A$ 是下三角矩阵，求其逆就是要解：
  $
  A X = I
  $
  只需对两边同时做行变换即可：
  ```rust
  let mut X = I;
  for i in 1..n {
    X[i] /= A[i][i]; 
    A[i][i] = 1;
    for j in i + 1..n {
      X[j] -= X[i] * A[j][i];
      A[j][i] = 0;
    }
  }
  ```
  计算量约为 $n^2$
= 4.
  不难发现：
  $
  mat(1, 0, 0;2, 1, 0; 2, 1, 0)vec(2, 3, 4) = vec(2, 7, 8)
  $
= 5.
  假设 $A$ 有两种 $L U$ 分解：
  $
  A = L U = L' U'
  $
  注意到 $L, U$ 都可逆，因此：
  $
  Inv((L')) L = Inv(U) U'
  $
  而熟知上三角矩阵的逆，上三角矩阵乘上三角矩阵都是上三角矩阵，下三角同理，因此上式同时是上三角矩阵和下三角矩阵，只能是对角矩阵，又不难验证 $Inv((L')) L$ 是单位下三角矩阵，因此是单位矩阵，即 $L = L'$，同理 $U = U'$，因此 $L U$ 分解唯一。
= 8.
  设 $A$ 的一步 Gauss 消去得到 $A'$，将有：
  $
  A'[i] = A[i] -  (A[i][1]) / (A[1][1]) A[1]
  $
  因此：
  $
  a'_(k k) &= a_(k k) - (a_(k 1)) / (a_(1 1)) a_(1 k)\
  sum_(j=1, j != k)^k abs(a'_(k j)) &= sum_(j=1, j != k)^k abs(a_(k j) - (a_(k 1)) / (a_(1 1)) a_(1 j))\
  &<= sum_(j=2, j != k)^k (abs(a_(k j)) + abs((a_(k 1)) / (a_(1 1)) a_(1 j)))\
  &= sum_(j=2, j != k)^k abs(a_(k j)) + (a_(k 1)) / (a_(1 1)) sum_(j=2, j != k)^k abs( a_(1 j))\
  &< abs(a_(k k)) - abs(a_(k 1)) + (a_(k 1)) / (a_(1 1)) (abs(a_(1 1)) -a_(1 k) )\
  & = abs(a_(k k)) - (a_(k 1)) / (a_(1 1)) a_(1 k) + (a_(k 1))/(a_(1 1)) abs(a_(1 1))  - abs(a_(k 1))\
  & <= abs(a_(k k)) - (a_(k 1)) / (a_(1 1)) a_(1 k) + abs(a_(k 1))/abs(a_(1 1)) abs(a_(1 1))  - abs(a_(k 1))\
  & <= abs(a_(k k)) - (a_(k 1)) / (a_(1 1)) a_(1 k)\
  & = a'_(k k)\
  $
  证毕
= 10.
  无妨设 $a_(1 1) = 1$，并设：
  $
  A = mat(1, a_(1 2)^T; a_(2 1), A_(2 2))
  $
  则有：
  $
  A_2 = A_(2 2) - a_(2 1) a_(1 2)^T 
  $
  任取非零向量 $x$，则：
  $
  x^T A_2 x = x^T (A_(2 2)) x - (x^T a_(2 1)) (x^T a_(1 2))
  $
  而：
  $
  (t, x^T) A vec(t, x) 
  &= (t, x) mat(1, a_(1 2)^T; a_(2 1), A_(2 2)) vec(t, x)\
  &= t^2 + (x^T a_(2 1) + a_(1 2)^T x) t + x^T A_(2 2) x
  $
  对于任何 $t$ 都正，换言之：
  $
  4 x^T A_(2 2) x > (x^T a_(2 1) + a_(1 2)^T x)^2 > 4 (x^T a_(2 1)) (x^T a_(1 2)) => x^T a_2 x > 0
  $
  证毕
= 14. 
  注意到：
  $
  A X = e_j
  $
  的解 $X$ 就是 $Inv(A)$ 的第 $j$ 列，而已知 LU 分解，上面方程是容易解出的，因此 $Inv(A)$ 的 $i j$ 元也容易得到。
= 19. 
  将等式 $A = L L^T$ 分块分解为：
  $
  mat(A_i, B^T; B, C) = mat(L_i, 0; B, I) mat(L_i^T, B^T; 0, I)
  $
  立得 $A_i = L_i L_i^T$，而 $L_i$ 当然是对角元均正的下三角矩阵。