#import "../../../template.typ": *
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1.
  $
  A = mat(1, 2;3, 4;5, 6) b = vec(1, 1, 1)\
  A^T = mat(1, 3, 5; 2, 4, 6) \
  A^T A = mat(35, #(2 + 12 + 30) ; 44, #(4 + 16 + 36))\
  A^T b = vec(1 + 3 + 5, 2 + 4 + 6) = vec(9, 12)\
  mat(35, 44 ; 44, 56) X = vec(9, 12)\
  mat(35, 44 ; 9, 12) X = vec(9, 3)\
  mat(35, 44 ; 3, 4) X = vec(9, 1)\
  mat(2, 0 ; 3, 4) X = vec(-2, 1)\
  mat(1, 0 ; 3, 4) X = vec(-1, 1)\
  mat(1, 0 ; 0, 4) X = vec(-1, 4)\
  mat(1, 0 ; 0, 1) X = vec(-1, 1)\
  X = vec(-1, 1)\
  $
= 3.
  令：
  $
  v = vec(0, alpha, 0, 0, 3, 4)\
  v^T v = alpha^2 + 25
  $
  则：
  $
  H x = (I - 2/(v^T v) v v^T)x = x - (2 v^T x)/(v^T v) v\
  = x - (2 * 25)/(alpha^2 + 25)vec(0, alpha, 0, 0, 3, 4)
  $
  只要 $alpha^2 + 25 = 50 => alpha^2 = 25$，立刻有：
  $
  H x = vec(1, -alpha, 4, 6, 0, 0) 
  $
  为使 $-alpha$ 为正，$alpha = - 5$ 即可
= 5.
  计算发现，只需：
  $
  - s x_1 + c x_2 = 0
  $
  - 若 $x_2 = 0$，则取单位矩阵即可
  - 否则，有：
    $
    (r c) = (r s) (x_1 / x_2), r in RR - {0}
    $
    由于 $r c in RR$，取：
    $
    r s = overline((x_1 / x_2)), r c = norm(x_1 / x_2)^2
    $
    即可满足上式，再做单位化：
    $
    s =  overline((x_1 / x_2))/sqrt((r s)^2 + (r c)^2), c = norm(x_1 / x_2)/sqrt((r s)^2 + (r c)^2)
    $
= 7.
  设：
  $
  H = I - 2 v v^T, norm(v) = 1
  $
  从目标等式不难看出 $abs(alpha) = norm(x) / norm(y)$ ，并对等式进行变形：
  $
  (I - 2 v v^T) x = alpha y\
  x - 2 (v^T x) v = alpha y\
  x - alpha y = 2 (v^T x) v\
  $
  由于之前已经确定 $alpha$，若 $x = alpha y$ 则取 $v=0$ 即可，否则对 $x - alpha y$ 做单位化得到：
  $
  v = (x - alpha y)/norm(x - alpha y)
  $
  不难验证它的确满足上述方程
= 11.
  假设第 $k - 1$ 轮消去了 $beta_k$ 且余下对角元均正，第 $k$ 轮我们利用子矩阵：
  $
  mat(alpha_1, rho_(k + 1);beta_(k + 1), alpha_(k + 1))
  $
  来消去 $beta_(k + 1)$，具体而言，假设：
  $
  mat(c, s;-s, c) mat(alpha_1, rho_(k + 1);beta_(k + 1), alpha_(k + 1))
  $
  是对角阵，那么：
  $
  - s alpha_1 + c beta_(k + 1) = 0
  $
  假设 $beta_(k + 1) = 0$ 则直接跳过，否则取：
  $
  s = beta_(k + 1)/sqrt(alpha_1^2 + beta_(k + 1)^2), c = alpha_1/sqrt(alpha_1^2 + beta_(k + 1)^2)
  $
  我们构造 Givens 变换矩阵：
  $
  H^(k + 1)_(i j) = &"match (i, j) with"\
  | &(1, 1) => c\
  | &(k + 1, k + 1) => c\
  | &(1, k + 1) => s\
  | &(k + 1, 1) => -s\
  | &(x, x) => 1\
  | &\_ => 0
  $
  则 $H^(k + 1) A$ 恰好消去 $A$ 第一列中的 $beta_(k + 1)$，并且不改变 $A$ 下三角部分以及已经消去的部分。为了保证 QR 分解得到的上三角矩阵对角元非负，可能需要在该轮再乘 $mat(plus.minus 1, 0;0, plus.minus 1)$
  反复进行该过程即可。该算法每轮计算都是常数级的，因此总的复杂度为 $O(n)$