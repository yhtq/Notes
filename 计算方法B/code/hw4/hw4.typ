#import "../../../template.typ": *
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1.
  Jacobi 迭代的迭代矩阵分别为：
  $
    M_1 = - diag{1/2, 1, -1/2} mat(0, -1, 1;1, 0, 1;1, 1, 0) = mat(0, -1/2, 1/2;1, 0, 1;-1/2, -1/2, 0)\
    M_2 = - diag{1, 1, 1} mat(0, 2, -2;1, 0, 1;2, 2, 0)
  $
  计算可得 $M_1$ 有特征值 $-5/4$，而 $M_2$ 特征值只有 $0$，因此 Jacobi 迭代对于 $M_1$ 不收敛，对于 $M_2$ 收敛。
  G-S 迭代的迭代矩阵分别为：
  $
    M_1 = - mat(2, 0, 0;1, 1, 0;1, 1, -2)^(-1) mat(0, 1, 1;0, 0, 1;0, 0, 0)\
    = - mat(1/2, 0, 0;-1/2, 1, 0;0, 1/2, -1/2) mat(0, 1, 1;0, 0, 1;0, 0, 0)\
    = mat(0, 1/2, 1/2;0, -1/2, 1/2; 0, 0, 1/2)\
    M_2 = - mat(1, 0, 0;1, 1, 0;2, 2, 1)^(-1) mat(0, 2, -2;0, 0, 1;0, 0, 0)\
    = -mat(1, 0, 0;-1, 1, 0;0, -2, 1)mat(0, 2, -2;0, 0, 1;0, 0, 0)\
    = - mat(0, 2, -2;0, -2, 3;0, 0, -2)
  $
  $M_1$ 的特征值为 $0, plus.minus 1/2$，因此 G-S 迭代收敛。$M_2$ 的特征值为 $0, plus.minus 2$，因此 G-S 迭代不收敛。
= 2.
  注意到 $B$ 的特征多项式为：
  $
    x^n 
  $
  因此 $B^n = 0$。此外，假设 $x$ 是精确解，熟知：
  $
    (x_(k+1) - x) = B^k (x_1 - x)
  $
  因此取 $k = n$ 立得：
  $
    x_(n + 1) = x
  $
= 3.  
  == (1)
    使用顺序主子式的判别法，矩阵正定当且仅当所有顺序主子式均正，也即当且仅当：
    $
      1 - a^2 > 0 <=> a in (-1, 1)
    $
  == (2)
    迭代矩阵为：
    $
      M = - diag{1, 1, 1}mat(0, 0, a;0, 0, 0;a, 0, 0) = - mat(0, 0, a;0, 0, 0;a, 0, 0)
    $
    特征多项式为 $lambda (lambda - a)(lambda + a)$，可见收敛当且仅当 $a in (-1, 1)$
  == (3)
    迭代矩阵为：
    $
      M = - mat(1, 0, 0;0, 1, 0;a, 0, 1)^(-1) mat(0, 0, a;0, 0, 0;0, 0, 0)\
      = - mat(1, 0, 0;0, 1, 0;-a, 0, 1) mat(0, 0, a;0, 0, 0;0, 0, 0)\
      = - mat(0, 0, a;0, 0, 0;0, 0, -a^2)
    $
    特征多项式为 $lambda^2 (lambda + a^2)$，收敛当且仅当 $a in (-1, 1)$
= 5.
  注意到严格对角占优或不可约对角占优矩阵的 $abs(a_(i i)) > 0$，因此下三角矩阵 $D - L$ 是可逆的。假设迭代矩阵有特征值 $lambda$，即：
  $
    Inv((D - L)) U x = lambda x\
    U x = lambda (D - L) x\
    (lambda D - lambda L - U) x = 0
  $
  然而，假若 $abs(lambda) > 1$，将有 $lambda D - lambda L - U$ 仍是严格对角占优/不可约对角占优的，因此它非奇异，进而 $x = 0$，这是荒谬的。
