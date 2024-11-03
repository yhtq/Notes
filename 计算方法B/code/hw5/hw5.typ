#import "../../../template.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 7.
  取初值 $x_0 = vec(1, 1)$，有：
  $
    A^k x_0 &= (lambda I + mat(0, 1;0, 0))^k vec(1, 1)\
    &= (lambda^k I + k lambda^(k - 1) mat(0, 1;0, 0)) vec(1, 1)\
    &= lambda^k vec(1, 1) + k lambda^(k - 1) vec(1, 0)\
    &= lambda^(k-1) vec(lambda + k, lambda)
  $
  不难验证 $(A^k x_0) / norm(A^k x_0) -> vec(1, 0)$
  $
    B^k x_0 &= (lambda mat(1, 0;0, -1) + mat(0, 1;0, 0))^k vec(1, 1)\
    &= (lambda^k mat(1, 0;0, (-1)^k) + k lambda^(k - 1) mat(0, 1;0, 0)) vec(1, 1)\
    &= lambda^(k - 1) mat(lambda, k;0, (-1)^k lambda) vec(1, 1)\
    &= lambda^(k - 1) vec(lambda + k, (-1)^k lambda)\
  $
  同样不难验证幂法收敛于 $vec(1, 0)$
= 9.
  求最佳的 $mu$ 等价于：
  $
    min_mu max(abs((lambda_2 - mu)/(lambda_1 - mu)), abs((lambda_n - mu)/(lambda_1 - mu))) \
    s.t. abs(lambda_1 - mu) > abs(lambda_n - mu) and abs(lambda_1 - mu) > abs(lambda_2 - mu)
  $
  - 首先，事实上约束条件是无用的，只要 $max(abs((lambda_2 - mu)/(lambda_1 - mu)), abs((lambda_n - mu)/(lambda_1 - mu))) < 1$ 则两个条件当然都满足。
  - 其次， $f(mu) := max(abs((lambda_2 - mu)/(lambda_1 - mu)), abs((lambda_n - mu)/(lambda_1 - mu)))$ 对于 $mu$ 在 $lambda_1$ 两侧是连续的，且除去 $lambda_2, lambda_1, abs((lambda_2 - mu)/(lambda_1 - mu)) = abs((lambda_n - mu)/(lambda_1 - mu))$ 的若干点外，函数都是单调的，不可能取最小值，只需计算：
  $
    lim_(mu -> infinity) f(mu) = 1\
    lim_(mu -> lambda_1) f(mu) = +infinity\
    f(lambda_2) =  (lambda_2 - lambda_n)/(lambda_1 - lambda_2)\
    f(lambda_n) =  (lambda_2 - lambda_n)/(lambda_1 - lambda_n)\
    abs((lambda_2 - mu)/(lambda_1 - mu)) = abs((lambda_n - mu)/(lambda_1 - mu)) => abs(lambda_2 - mu) = abs(lambda_n - mu) => mu = (lambda_2 + lambda_n)/2\
    f((lambda_2 + lambda_n)/2) = abs((lambda_2 - lambda_n)/2) / abs(lambda_1 - (lambda_2 + lambda_n)/2)\
  $
  而事实上，有：
  $
    abs((lambda_2 - lambda_n)/2) / abs(lambda_1 - (lambda_2 + lambda_n)/2) = abs(lambda_2 - lambda_n) / abs((lambda_1 - lambda_2) + (lambda_1 - lambda_n)) = (lambda_2 - lambda_n) / ((lambda_1 - lambda_2) + (lambda_1 - lambda_n))
  $
  不难看出 $f((lambda_2 + lambda_n)/2)$ 是函数的最小值，并且不难验证 $f((lambda_2 + lambda_n)/2) < 1$，因此约束条件也成立
= 11.
  取 $x_0 = vec(1, 0, 0)$，计算得近似特征向量：
  $
    vec(0.7887, -0.5773, 0.2113)
  $
= 14.
  $
    A_0 = mat(1, 0;1, -1) = mat(sqrt(2)/2, sqrt(2)/2 ;sqrt(2)/2,-sqrt(2)/2) mat(sqrt(2), -sqrt(2)/2;0, sqrt(2)/2)\
    A_1 = mat(1/2, 3/2;1/2, -1/2)\
    A_2 = mat(1, 0;1, -1)
  $
  因此 QR 迭代不收敛
= 23
  #lemmaLinear[][
    设 $A$ 是上三角矩阵，对角元为 $a_(i i)$，若对 $k$ 满足：
    $
      a_(i i) != 0, i > k
    $
    则方程组：
    $
      A x = 0
    $
    的解等价于方程组：
    $
      A_((k - 1) k) x = 0
    $
    的解后面加上足够多的 $0$
  ]
  #proof[
    简单验证即可
  ]
  为了计算所有特征向量，只需对所有 $i$ 解：
  $
    (A - a_(i i) I) x = 0
  $
  不难看出其解空间维数为 $1$，解法如下：
  - 对于任意 $i$，不难看出 $A - a_(i i) I$ 满足引理中 $k = i$ 条件，因此只需解一个形如：
    $
      mat(a_(1 1), a_(1 2), ..., a_(1 (i - 1)), a_(1 i);0, a_(2 2), ..., a_(2 (i - 1)), a_(2 i);0, 0, ..., a_((i-1) (i-1)), a_((i-1) i)) x = 0
    $
    的方程即可，其中对角元 $a_(i i)$ 非零。因为解空间维数为 $1$，只需找到一个解即可，不妨取 $x_i = -1$，方程组化为：
    $
      mat(a_(1 1), a_(1 2), ..., a_(1 (i - 1));0, a_(2 2), ..., a_(2 (i - 1));0, 0, ..., a_((i-1) (i-1))) x = vec(a_(1 i), a_(2 i), ..., a_((i-1) i))
    $
    按照解上三角线性方程组的解法解出即可。
  总的复杂度约为：
  $
    sum_(i = 1) ^ n (i-1)^2 approx 1/3 n^3
  $