#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
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