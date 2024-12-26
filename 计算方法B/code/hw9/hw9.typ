#import "../../../template.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 3.
  计算梯度：
  $
    nabla (x_1^2 + 2 x_2^2 + 4 x_1 + 4 x_2) = (2 x_1, 0) + (0, 4 x_2) + (4, 4) = (2 x_1 + 4, 4 x_2 + 4)
  $
  因此：
  $
    x^(k + 1) = x^k - alpha_k (mat(2, 0;0, 4) x^(k) + vec(4, 4))
  $
  再使用精确线搜索，应当有：
  $
    (mat(2, 0;0, 4) x^(k + 1) + vec(4, 4))^T (mat(2, 0;0, 4) x^(k) + vec(4, 4)) = 0\
    (mat(2, 0;0, 4) x^(k) + vec(4, 4) - alpha_k (mat(4, 0;0, 16) x^(k) + vec(8, 16)))^T (mat(2, 0;0, 4) x^(k) + vec(4, 4)) = 0\
    (mat(2 - 4 alpha_k, 0;0, 4 - 16 alpha_k) x^(k) + vec(4 - 8 alpha_k, 4 - 16 alpha_k))^T (mat(2, 0;0, 4) x^(k) + vec(4, 4)) = 0\
  $
  这是关于 $alpha_k$ 的线性方程，解应当唯一，因此代入递推公式，验证：
  $
    (mat(2, 0;0, 4) vec(2/3^(k + 1) - 2, (-1/3)^(k + 1) - 1) + vec(4, 4))^T (mat(2, 0;0, 4) vec(2/3^(k) - 2, (-1/3)^(k) - 1) + vec(4, 4)) \
    = vec(4/3^(k + 1), 4 (-1/3)^(k + 1))^T vec(4/3^(k), 4 (-1/3)^(k))\
    = 16/3^(2 k + 1) + 16 (-1)^(2k + 1) 1/3^(2 k + 1) = 0
  $
  另外：
  $
    x^(k + 1) - x^k = vec(2/3^(k + 1) - 2/3^k, (-1/3)^(k + 1) - (-1/3)^k) = vec(-4/3^(k +1), -2 (-1/3)^(k + 1))\
    = -1/3 (mat(2, 0;0, 4) x^(k) + vec(4, 4))
  $
  表明 $x_(k + 1)$ 确实如公式给出
= 5.
  计算：
  $
    g(x) = 66/546 x^5 - 76/182 x^3 + x\
    G(x) = (11 dot 30)/546 x^4 - (19 dot 12)/182 x^2 + 1\
    = 55/91 x^4 - 114/91 x^2 + 1
  $
  令 $g(x) = 0$ 得：
  $
    x(66/546 x^4 - 76/182 x^2 + 1) = 0
  $
  计算得 $Delta < 0$ 因此二阶导数恒正。迭代公式为：
  $
    x_(k + 1) = x_k - Inv(G(x_k)) g(x_k) = x_k - (66/546 x_k^5 - 76/182 x_k^3 + x_k)/(55/91 x_k^4 - 114/91 x_k^2 + 1)\
    = x_k (1 - (66/546 x_k^4 - 76/182 x_k^2 + 1)/(55/91 x_k^4 - 114/91 x_k^2 + 1))\
    = x_k (44 x_k^4 - 76 x_k^2)/(55 x_k^4 - 114 x_k^2 + 91)\
    // = x_k (44 (x_k^2 - 1)^2 + 12 (x_k^2 - 1) - 32)/(55 x_k^4 - 114 x_k^2 + 91)\
    // = x_(k - 1) (44 x_(k - 1)^4 - 76 x_(k - 1)^2)/(55 x_(k - 1)^4 - 114 x_(k - 1)^2 + 91) (44 x_k^4 - 76 x_k^2)/(55 x_k^4 - 114 x_k^2 + 91)
    
    \

    // x_(k + 2) = x_k - Inv(G(x_k)) g(x_k) - Inv(G(x_k - Inv(G(x_k)) g(x_k))) g(x_k - Inv(G(x_k)) g(x_k))
  $<x-iter>
  令 $t_k = x_k^2 - 1$，有：
  $
    t_(k + 1) + 1 = (t_k + 1) (44 (t_k + 1)^2 + 76 (t_k + 1))^2/(55 (t_k + 1)^2 - 114 (t_k + 1) + 91)^2
  $
  计算得：
  $
    t_(k + 1) = t_k (1936 t_k^4 - 33 t_k^2 - 1176 t_k^2 - 6976 t_k^2 + 512)/(32 + t_k (55 t_k - 4))^2
  $
  不难发现若令 $t_k$ 较为接近 $0$，则 $t_(k + 1)/t_k -> 1/2$，换言之 $t_(k + 1)$ 将更接近 $0$，结合初值选取可以验证 $t_k -> 0$。
  
  注意到：
  $
    f_k = 11/546 (t_k + 1)^3 - 19/182 (t_k + 1) + 1/2 (t_k + 1)
  $<f-iter>
  可以验证上式右侧在 $0$ 附近单调减少，而 $t_k$ 单调趋于零，因此 $f_k$ 也单调减少。

  再由@x-iter 可以看出，$x_(k + 1)$ 与 $x_k$ 一定异号，因此只能有 $x_(2 k) -> 1, x_(2 k + 1) -> -1$

  不难计算得到 $g(1) = - g(-1) != 0$，因此梯度不收敛于零。进一步，假设存在 $rho > 0$ 使得对 $k$ 恒有：
  $
    f_(k + 1) <= f_k - rho g_k^T g_k
  $
  则 $f_(k + 1)$ 将无限下降，显然与@f-iter 矛盾
= 7
  注意到：
  $
    (sigma Inv(A) - Inv(A) u v^T Inv(A)) (A + u v^T)\
    = sigma I - Inv(A) u v^T + sigma Inv(A) u v^T - (Inv(A) u v^T) (Inv(A) u v^T)\
    = sigma I - Inv(A) u v^T + sigma Inv(A) u v^T - Inv(A) u (v^T Inv(A) u) v^T\
    = sigma I - Inv(A) u v^T + sigma Inv(A) u v^T - (v^T Inv(A) u) Inv(A) u  v^T\
    = sigma I + (sigma - 1 - (v^T Inv(A) u))Inv(A) u v^T\
    = sigma I
  $
  因此只要 $sigma$ 非零，$A$ 就可逆，且上式给出了逆矩阵。反之，假设 $sigma = 0$ 并且 $A$ 可逆，将有：
  $
    Inv(A) u v^T Inv(A) = 0\
    u v^T = 0\
    0 = 1 + v^T Inv(A) u\
    0 = u + (u v)^T Inv(A) u\
    u = 0\
    0 = 1
  $
  矛盾！
= 8.
  计算：
  $
    (A + R S T^T)(Inv(A) - Inv(A) R Inv(U) T^T Inv(A)) \
    = I - R Inv(U) T^T Inv(A) + R S T^T Inv(A)- R S T^T Inv(A) R Inv(U) T^T Inv(A)\
    = I - R (Inv(U) - S + S T^T Inv(A) R Inv(U)) T^T Inv(A)\
    = I - R (I - S U + S T^T Inv(A) R) Inv(U) T^T Inv(A)\
    = I - R (I - S (Inv(S) + T^T Inv(A) R) + S T^T Inv(A) R) Inv(U) T^T Inv(A)\
    = I\
  $
= 10.
  只需要找到 $phi$ 使得：
  $
    ((s_k - H_k y_k)(s_k - H_k y_k)^T)/((s_k - H_k y_k)^T y_k) = phi ((1 + (y_k^T H_k y_k)/(y_k^T s_k)) (s_k s_k^T)/(y_k^T s_k) - (s_k y_k^T H_k + H_k y_k s_k^T)/(y_k^T s_k)) + \
    (1 - phi) ((s_k s_k^T)/(s_k^T y_k) - (H_k y_k y_k^T H_k)/(y_k^T H_k y_k))\
    = (1 + phi (y_k^T H_k y_k)/(y_k^T s_k)) (s_k s_k^T)/(y_k^T s_k) - phi/(s_k^t y_k) (s_k y_k^T H_k + H_k y_k s_k^T) + (phi - 1)/(y_k^T H_k y_k) (H_k y_k y_k^T H_k) 
  $<eq-1>
  比对系数，只需要：
  $
    (phi - 1)/(y_k^T H_k y_k) = 1/((s_k - H_k y_k)^T y_k)\
    phi/(s_k^t y_k) = 1/((s_k - H_k y_k)^T y_k)\
    (1 + phi (y_k^T H_k y_k)/(y_k^T s_k)) = 1/((s_k - H_k y_k)^T y_k)
  $
  验证得：
  $
    phi = (s_k^T y_k)/(y_k^T H_k y_k)
  $
  即满足上三式。由条件，有
  $
    s_k^T y_k > 0\
    y_k^T H_k y_k > 0\
  $
  足以给出 $phi > 0$。若 $phi <= 1$，则由@eq-1 结合 DFP BFGS 方法保持正定性，将有：
  $
    ((s_k - H_k y_k)(s_k - H_k y_k)^T)/((s_k - H_k y_k)^T y_k) "正定"
  $   
  从而：
  $
    s_k^T y_k > y_k^T H_k y_k\
    phi > 1
  $
  矛盾！因此一定有 $phi > 1$