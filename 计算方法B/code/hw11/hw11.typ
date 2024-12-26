#import "../../../template.typ": *
#show: note.with(
  title: "作业11",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 2.
  如果取：
  $
    inner(a, b) = a^T G b
  $
  则容易验证它是一个内积，共轭向量组就是该内积下的正交向量组，当然是线性无关的。
= 3.
  设 $G$ 对称正定，则可设：
  $
    G = P^(-1) Lambda P
  $
  其中 $P$ 是正交矩阵，$Lambda$ 是对角矩阵，且对角元均正。设：
  $
    D = sqrt(Lambda)
  $
  (也就是对 $Lambda$ 所有对角元开根)容易证明：
  $
    D^2 = Lambda\
    (P^(-1) D P)^2 = G
  $
  而 $P^(-1) D P$ 是对称正定矩阵，这就是 $G$ 的平方根。

  再证明它的唯一性，设：
  $
    A^2 = B^2
  $
  其中 $A, B, A^2$ 都对称正定，注意到：
  $
    abs(lambda I - A) abs(lambda I + A) = abs(lambda I - A^2) = abs(lambda I - B^2) = abs(lambda I - B) abs(lambda I + B)
  $
  任取 $A$ 的特征值 $lambda > 0$，显然有 $abs(lambda I + A) != 0, abs(lambda I + B) != 0$，因此它也是 $B$ 的特征值，同时有相同的重数。反之亦然，因此 $A, B$ 有相同的特征多项式。设：
  $
    A = P Lambda P^(-1), B = Q Lambda Q^(-1)
  $
  其中 $P, Q$ 都是正交的，立刻有：
  $
    P Lambda^2 P^T = Q Lambda^2 Q^T\
    Lambda^2 = (P^T Q Lambda Q^T P)^2\
  $
  令 $C = P^T Q Lambda Q^T P$，有：
  $
    Inv(C) = Lambda^(-2) C
  $
  然而 $Inv(C)$ 当然是对称矩阵，因此：
  $
    C Lambda^(-2) = Lambda^(-2) C
  $
  由 $C$ 与对角矩阵交换，可知 $C$ 是分块对角矩阵，其中分块对应 $Lambda$ 的重特征值。进一步，如果：
  $
    C_i^2 = k_i^2 I
  $
  其中 $C_i$ 也对称正定，将有：
  $
    (1/k_i C_i)^2 = I
  $
  则 $C_i$ 的特征值均为 $k_i$，继而：
  $
    C_i = k_i I
  $
  总之：
  $
    C = Lambda
  $
  倒回即得原结论
= 7.
  利用和第二题相同的内积定义，这就是标准的 Gram-Schmidt 正交化过程，当然能得到共轭向量组。
= 8.
  注意到：
  $
    f(x) = x^T mat(1, 0;0, 4) x - (4, 8) x\
    g(x) = x^T mat(2, 0;0, 8) - (4, 8)
  $
  递归证明 4.10a 和 4.10b：
    // $
    //   d_k^T G d_i = (-g_k + (g_k^T g_k)/(g_(k-1)^T g_(k-1)) g_(k-1))^T G d_i\
    // $
    根据精确线搜索准则有：
    $
      g_k^T d_(k - 1) = 0
    $
    首先证明：
    $
      g_k^T g_i = 0, i < k
    $
    当 $i < k - 1$ 时有：
    #let gk = $g_k$
    #let gk1 = $g_(k - 1)$
    #let dk = $d_k$
    #let dk1 = $d_(k - 1)$
    #let di = $d_i$
    $
      g_k^T g_i = (gk - gk1)^T g_i = alpha_(k - 1) d_(k-1)^T G g_i = alpha_(k - 1) g_i^T (G d_(k - 1))\
      = alpha_(k - 1) (-d_i + beta_(i-1) d_(i - 1))^T G d_(k-1) = 0
    $
    当 $i = k - 1$ 时有：
    $
      gk^T gk1 = gk^T (dk1 - beta_(k-2) d_(k-2)) = -beta_(k-2) gk^T d_(k - 2) = -beta_(k-2) (gk - gk1)^T d_(k - 2)\
      = -beta_(k -2) alpha_(k-1) d_(k-1)^T G d_(k-2) = 0
    $
    注意 $i = 0$ 时该证明失效，然而此时有：
    $
      g_1^T g_0 = - g_1^T d_0 = 0
    $
    命题同样成立。

    再证明：
    $
      d_k^T G d_i = 0, i < k
    $
    当 $i < k - 1$ 时有：
    $
      dk^T G di &= (-gk + (gk^T gk)/(gk1^T gk1) dk1)^T G di\
      &= - gk^T G di\
      &= - 1/alpha_(i) gk^T (g_(i+1) - g_i)\
      &= 0 
    $
    当 $i = k-1$ 时有：
    $
      dk^T G di &= (-gk + (gk^T gk)/(gk1^T gk1) dk1)^T G dk1\
      &= 1/alpha_k (-gk + (gk^T gk)/(gk1^T gk1) dk1)^T (gk - gk1)\
      &= 1/alpha_k (-gk^T gk - (gk^T gk)/(gk1^T gk1) dk1^T gk1)\
      &= (gk^T gk)/(alpha_k (gk1^T gk1)) (-gk1^T gk1 - dk1^T gk1)\
      &= - (gk^T gk)/(alpha_k (gk1^T gk1)) (gk1 + dk1)^T gk1\
      &= - (gk^T gk)/(alpha_k (gk1^T gk1)) (beta_(k-2) d_(k-2))^T gk1\
      &= 0
    $
    证毕。

    而 $i = 0$ 时有
    $
      gk1 + dk1 = 0
    $
    因此结论同样成立。

    #let invG = $Inv(G)$
    对于第二个命题，在二次函数上拟牛顿法当然相当于普通的牛顿法。事实上，可以递归证明 $H_k = invG$：
    #let sk = $s_k$
    $
      H_(k + 1) &= H_k + (1 + (y_k^T H_k y_k)/(y_k^T s_k)) (s_k s_k^T)/(y_k^T s_k) - (s_k y_k^T H_k + H_k y_k s_k^T)/(y_k^T s_k)\
      &= invG + (1 + (sk^T G sk)/(sk^T G sk)) (sk sk^T)/(sk^T G sk) - (sk sk^T + sk sk^T)/(sk^T G sk)\
      &= invG 
    $
    因此，更新方向满足：
    $
      d'_k = - invG g_k (k > 0)
    $
    事实上，本例中空间维数为 2，因此迭代两步就会终止，只需第二步时两种方法等价，计算：
    $
      d'_1^T G d_0 = - g_1^T  g_0  = 0
    $
    因此 $d'_1, d_1$ 都是 $d_0$ 的共轭方向，由于空间维数为 $2$，两者一定共线。同时两者都是下降方向，因此第二步两方法的下降方法相同。
    // $
    //   dk - dk1 = - gk + (beta_(k-1) - 1) dk1\
    //   = - gk + (gk^T gk - gk1^T gk1)/(gk1^t gk1) dk1\
    //   = - gk + (gk^T (gk - gk1) - gk1^T gk1)/(gk1^t gk1) dk1\
    // $
    // $
    //   (-gk + (gk^T (gk - gk1))/(gk1^t gk1) gk1)^T G di\
    //   = (-gk + (gk^T G (x_k - x_(k -1 )))/(gk1^t gk1) gk1)^T G di\
    //   = (-gk + (gk^T G (alpha_(k - 1) d_(k - 1)))/(gk1^t gk1) gk1)^T G di\
    // $