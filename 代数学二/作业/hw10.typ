#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
（应交时间为5月14日）
#let sect1(n) = $sect_(#n = 1)^infinity$
= p114
  == 1
    - 首先，注意到 $p A = 0$，因此由逆向极限定义的完备化当然有 $hat(A) = A$
    - 其次，设 $B = directSum_(n >= 1) ZZ quo p^n ZZ$，则有：
      $
      (p^k) B = directSum_(n >= k + 1) ZZ quo p^n ZZ\
      alpha(A) = directSum_(n >= 1) p^(n-1) ZZ quo p^n\
      (p^k) B inter alpha(A) = directSum_(n >= k + 1) p^(n-1) ZZ quo p^n ZZ\
      Inv(alpha)((p^k) B inter alpha(A)) = directSum_(n >= k + 1) ZZ quo p ZZ\
      A quo Inv(alpha)((p^k) B inter alpha(A)) = directSum_(n <= k) ZZ quo p ZZ\
      inverseLimit A quo Inv(alpha)((p^k) B inter alpha(A)) = product ZZ quo p ZZ\
      $
    - 最后，有正合列：
      $
      A ->^alpha B -> B quo alpha(A) -> 0
      $
      取 $p-$adic 完备化，习题证明了若 $A, B quo alpha(A)$ 都取 $B$ 的诱导拓扑，则仍然正合。然而此时 $B quo alpha(A)$ 的完备化确实来自于诱导拓扑，但 $A$ 的完备化与诱导拓扑的完备化不同，故完备化后的结果不可能正合。
  == 2
    前面计算的结果给出：
    $
    A_n = directSum_(k >= n + 1) ZZ quo p ZZ\
    A quo A_n = directSum_(k <= n) ZZ quo p ZZ\
    $
    取逆向极限后变成：
    $
    0 -> 0 -> directSum_n ZZ quo p ZZ -> product_n ZZ quo p ZZ -> 0 
    $
    然而 $directSum_n ZZ quo p ZZ -> product_n ZZ quo p ZZ$ 当然不是满射，故不正合，并有：
    $
    inverseLimit^1 A_n = (product_n ZZ quo p ZZ) quo (directSum_n ZZ quo p ZZ)
    $
  == 3
    注意到：
    $
    sect1(n) alpha^n M = {x in M | exists y in I, (1 - y) x = 0 <=> x = y x}
    $
    而由前面的习题，$exists y, x = y x <=> A x = alpha x M$ 当且仅当对于每个极大理想 $m supset alpha$ 都有 $(A x)_m = 0 => x_m = 0$，进而结论正确

    注意到 $hat(M) = 0$ 当且仅当 $sect1(n) alpha^n M = M$，也即：
    $
    forall m supset alpha, M_m = 0
    $
    这里任意极大理想当然可以换成任意素理想（只需在 $A quo alpha$ 上考虑，上式等价于 $M quo alpha M = 0$），继而就是结论
  == 4
    考虑正合列：
    $
    0 -> A ->^x (x)
    $
    取 $p-$adic完备化得正合列：
    $
    0 -> hat(A) ->^(hat(x)) (hat(x))
    $
    （这里的模当然都是有限生成的）\
    表明 $hat(x)$ 不是零因子

    第二个推导是不正确的，既然 $hat(A)$ 中还可能有其它元素。例如容易证明 $y^2 - x$ 是 $k[x, y]$ 中不可约多项式，$y^2 - x$ 是素理想，$k[x, y] quo (y^2 - x)$ 是诺特整环。再取 $I = (x - 1)$ 做完备化，泰勒公式给出 $sqrt(1 + (x- 1)) = sqrt(x)$ 存在，进而：
    $
    (y + sqrt(x))(y - sqrt(x)) = 0
    $
    注意到由构造 $sqrt(x)$ 是 $x - 1$ 的形式幂级数，不可能 $= plus.minus y$，故上式给出零因子
  == 5
    注意到：
    $
    (M^a)^b = (M tensorProduct A^a) tensorProduct A^b
    $
    因此只需证明 $A^a tensorProduct A^b = A^(a + b)$ 即可
    #lemmaLinear[][
      任取理想 $a$，有限生成模 $M$ 有：
      $
      inverseLimit (A quo a^m tensorProduct M) tilde.eq (inverseLimit A quo a^m) tensorProduct M
      $
    ]
    #proof[
      根据熟知的定理，等价于证明：
      $
      inverseLimit (M quo a^m M) = M^a
      $
      这就是完备化的定义
    ]
    注意到：
    $
    A^a tensorProduct A^b = (inverseLimit_m A quo a^m) tensorProduct (inverseLimit_n A quo b^n) = inverseLimit_(m, n) (A quo a^m tensorProduct A quo b^n) \
    = inverseLimit_(m, n) A quo (a ^m + b^n)\
    = inverseLimit_(n) A quo (a ^n + b^n)
    $
    再结合 $(a + b)^(2 n) subset a^n + b^n subset (a + b)^n$ 知上面的极限就是 $A^(a + b)$，证毕。
  == 6
    由定义，在 $alpha$ 拓扑下极大理想 $m$ 是闭集当且仅当 $m$ 包含 $alpha$，因此结论显然
  == 7
    $
    hat(A) "忠实平坦" &<=> forall "有限生成模"M, M -> hat(M) "是单射" \
    &<=> forall "有限生成模"M, inter a^n M  = 0\
    &<= alpha subset "Jacobson 根" \
    &"（这是 Krull's 的推论）"\
    $
    此时，环当然是 Zariski 环
  == 8
    （容易验证本题中的 $A, B, C$ 都是整环）\
    注意到若有收敛的 $n$ 元幂级数 $f$，只要 $f(0) != 0$ 一定有 $f$ 在 $0$ 的某个邻域内可逆，且其逆仍是幂级数，进而 $f$ 是 $B$ 中单位。同时，$f(0) = 0 <=> f in (z_1, z_2, ..., z_n)$，因此后者就是唯一的极大理想。

    注意到 $CC[z_1, z_2, ..., z_n]$ 关于 $(z_1, z_2, ..., z_n)$ 的完备化是 $C$，而 $CC[z_1, z_2, ..., z_n] subset A subset B subset C$，因此 $A, B$ 关于对应极大理想的完备化应当也是 $C$

    进一步，若 $B$ 诺特，$A$ 当然也诺特，由之前的习题及 $A, B$ 是局部环知 $C$ 在 $A, B$ 上忠实平坦，由第三章习题 $B$ 将在 $A$ 上平坦
  == 9
    递归构造 $g_k (x), h_k (x)$ 使得 $g_k h_k - f in m^k A[x]$ 且 $g_k, h_k$ 在 $A quo m^k [x]$ 中互素
    - $k = 1$ 时取 $g_1, h_1$ 是 $overline(g), overline(h)$ 的任意一个原像即可
    - 
      假设 $k$ 时已经构造完成，设：
      $
      g_k h_k - f = sum_(i=0)^n c_i x^i 
      $
      其中 $c^i in m^k$\
      由互素性，可设：
      $
      x^i + r_i (x) = a_i (x) h_k (x) + b_i (x) g_k (x)
      $
      其中 $deg a_i, b_i <= n-r, r$ 并且 $r_i (x) in m^(k) [x]$

      不难发现将有：
      $
      c_n x^n = c_n a_n (x) h_k (x) + c_n b_i (x) g_k (x) - c_n r_n (x)\
      sum_(i=0)^(n-1) c_i x^i =  g_k (x) h_k (x) - f(x) - (c_n a_n (x) h_k (x) + c_n b_i (x) g_k (x) - c_n r_n (x))\
      = (g_k (x) - c_n a_n (x))(h_k (x) - c_n b_n (x)) - f(x) + c_n r_n (x) - c_n^2 a_n (x) b_n (x)
      $
      其中 $c_n r_n (x) - c_n^2 a_n (x) b_n (x) in m^(k+1) [x]$，反复进行以上步骤，令
      $
      g' (x) = g_k (x) - sum_(k=0)^n c_k a_k (x)\
      h' (x) = h_k (x) - sum_(k=0)^n c_k b_k (x)
      $
      ，注意到：
      $
      1 + r_0 (x) = a_0 (x) h_k (x) + b_0 (x) g_k (x)
      $
      故：
      $
      a_0 (x) h' (x) + b_0 (x) g' (x) = 1 + r_0 (x) - sum_(k=0)^n c_k (a_0(x) a_k (x) + b_0(x) b_k (x)) := 1 + r' (x)\
      r' a_0 h' + r' b_0 g' = r' + r'^2
      $
      两式相减：
      $
      (1-r')a_0 h' + (1-r') b_0 g' = 1 -r'^2
      $
      而当然有 $-r'^2 in m^(k+1) [x]$，进而 $h', g'$ 确实在 $A quo m^(k+1) [x]$ 中互素，完成了归纳的构造。
    有了构造之后，只需取这些 $g_k, h_k$ 的极限为 $g, h$，则 $g h - f$ 在逆向极限中每一项都是零，当然在极限中是零。同时由 $A$ 的完备性极限就是本身，因此结论成立。
  == 10
    === (i)
      由条件，设 $overline(f(x)) = (overline(x) - alpha)overline(g(x))$，其中 $overline(g)(alpha) != 0$\
      由 Hensel's Lemma，将乘积延拓到 $A[x]$，可设：
      $
      f(x) = (x - a)g(x)
      $
      其中 $a = alpha mod m$, g(a) != 0（既然 $overline(g(a)) = overline(g)(alpha) != 0$） 表明 $a$ 是单根
    === (ii)
      注意到 $7-$adic 环 $ZZ_7$ 以 $(7)$ 为唯一极大理想，而 $ZZ_7 quo 7 ZZ_7 = ZZ quo 7 ZZ$\
      考虑 $f(x) = x^2 - 2$，不难验证在 $ZZ quo 7 ZZ$ 中 $3$ 是其单根，这意味着它在 $ZZ_7$ 中也有单根，证毕
    === (iii)
      设 $A = k[x], B = k[[x]]$，则 $B$ 是局部环，以 $(x)$ 为唯一极大理想。同时，$f(x, y)$ 关于是其上关于 $y$ 的多项式，并且在 $B quo (x) = k$ 中有单根 $a_0$（既然 $f(x, y) = f(0, y) in B quo (x)$）\
      由第一问结论，$f(x, y)$ 将在 $B$ 中有单根 $y(x)$ 使得：
      $
      f(x, y(x)) = 0
      $
      这里 $y(x) in B$ 是 $x$ 的形式幂级数，证毕
  == 12
    设 $B = A[[x_1, x_2, ..., x_n]]$ ，首先熟知 $B$ 在 $A$ 上平坦，同时 $A -> B$ 的伴随映射 $Spec(B) -> Spec(A)$ 是满射（第一章习题），这足以说明 $B$ 在 $A$ 上忠实平坦。
    
      