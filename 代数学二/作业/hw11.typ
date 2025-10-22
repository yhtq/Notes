#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业11",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= p125
  == 1
    注意到：
    $
    dim A_m = dim A = dim(k[x_1, ..., x_n] quo (f)) = n-1
    $
    设 $P = (p_1, ..., p_n)$，将有：
    $
    m = (x_1 - p_1, ..., x_n - p_n)\
    f in m
    $
    容易验证 $P$ 是非奇异点当且仅当 $f in.not m^2$，而在 $A_m$ 中有：
    $
    m quo m^2 = (x_1 - p_1, ..., x_n - p_n) quo( (x_1 - p_1, ..., x_n - p_n)^2 + (f))
    $
    维度条件意味着 $A_m$ 是正规局部环当且仅当上式是 $n-1$ 维 $k-$线性空间
    - 若 $f in (x_1 - p_1, ..., x_n - p_n)^2$，上式显然是 $n$ 维线性空间
    - 否则，可设：
      $
      f in f_1 + (x_1 - p_1, ..., x_n - p_n)^2
      $
      且 $f_1$ 是 $x_1 - p_1, ..., x_n - p_n$ 的线性组合，这表明 $m quo m^2 = ((x_1 - p_1, ..., x_n - p_n) quo (x_1 - p_1, ..., x_n - p_n)^2) quo (f_1)$ 恰为 $n-1$ 维线性空间
    证毕
  == 2
    首先存在同态 $k[t_1, t_2, ..., t_d] -> A$，且由定理给出的代数独立性这是单射。取完备化（注意到完备化在有限生成模上正合，$A$ 诺特确保前者作为理想有限生成）可得 $k[[t_1, ..., t_n]] -> A$ 的单射。

    对于第二个命题：
    - 首先证明 $G(A)$ 在 $G(k[t_1, ..., t_d]) = k[t_1, ..., t_d]$ 上有限生成。既然 $G(A)$ 是 $A_0  = A quo m = k$ 的有限生成模，当然也是 $k[t_1, ..., t_d]$ 的有限生成模。
    - 其次，注意到 $G(k[t_1, ..., t_d]) = G(k[[t_1, ..., t_d]])$，利用上节定理可得 $A$ 在 $k[[t_1,...,t_d]]$ 上有限生成
  == 3
    #let kclo = $overline(k)$
    #let kA = $k[x_1, ..., x_d]$
    #let kB = $kclo[x_1, ..., x_d]$
    注意到 $kclo$ 中所有元素当然在 $k$ 上整，继而在 $kA$ 上整。而 $x_1, ..., x_n in kB$ 当然也在 $kA$ 上整，由整元的代数封闭性 $kB$ 在 $kA$ 上整。\
    此外，$kA$ 当然在分式域中整闭。任取 $kB$ 的极大理想 $m$，则 $m inter kA$ 也是极大理想，且 $dim kA_(m inter kA) = dim kB_(m)$

    回到定理的证明，类似利用诺特正规化构造 $B = kA, m$ 是任意极大理想，由上面的命题和书上引理将有：
    $
    dim B_m = dim kB_m
    $ 
    利用原定理即可得到上式为 $d$，证毕
  == 4
    设 $p_i = (x_(m_i + 1), ..., x_(m_(i+1))), d = m_(i+1) - m_i$，$p_i$ 是素理想是容易的，而它的高度也即：
    $
    k[x_1, ..., x_d]
    $
    中 $(x_1, ..., x_d)$ 的高度，换言之就是 $k[x_1, ..., x_d]$ 的维度，熟知它恰为 $d = m_(i+1) - m_i$\
    利用定义验证可得 $S = A - union p_i$ 确实是乘法封闭的，做局部化可得 $Inv(S) A$ 是诺特的，但含于 $p_i$ 的素理想与含于 $Inv(S) p_i$ 的素理想一一对应，继而 $Inv(S) p_i$ 的高度也是 $m_(i+1) - m_i$，它将趋于无穷。
  == 5
    不难发现设 $lambda$ 是加性函数，则：
    $
    0 -> M' -> M -> M'' -> 0
    $
    导出 $lambda(M') - lambda(M) + lambda(M'') = 0$\
    进而 $lambda$ 诱导了 Grothendick 群 $K(A_0) -> ZZ$ 的同态。反之，这样的群同态当然也是一个加性函数。从而庞卡莱级数也可看作：
    $
    sum_(n=0)^(+infinity) lambda(a_n) t^n, lambda in Hom(K(A_0), ZZ), a_n in K(A_0)
    $
  == 6
    取 $f: A -> A[x]$ 是嵌入，熟知 $f^*: Spec(A[x]) -> Spec(A)$ 成为保序的满射。任取 $A[x]$ 的素理想链：
    $
    p_0 < p_1 < p_2 < ... < p_s
    $
    注意到在 $p_i inter A$ 处的纤维同胚于 $k(p_i) tensorProduct A[x] = k[x]$，维度为 $1$，因此上式中至多连着两项拉回 $A$ 的到相同的素理想，换言之：
    $
    dim A + 1 >= (s + 1)/2\
    s <= 2 dim A + 1
    $
    可得 $dim A[x] <= 2 dim A + 1$

    对于另一个方向，任取 $A$ 中素理想升链：
    $
    q_0 < q_1 < q_2 < ... < q_s
    $
    这里无妨设 $q_s$ 是极大理想，则:
    $
    q_0[x] < q_1[x] < q_2[x] < ... < q_s[x] < q_s[x] + (x)
    $
    （注意到 $q_s[x] + (x)$ 极大）当然是一个素理想升链，因此当然有 $1 + dim A <= dim A[x]$，证毕
  == 7
    任取素理想 $p$ 并设其高度为 $m$\
    首先在 $A_p$ 上利用维度定理，存在 $a_1, a_2, ..., a_m$ 满足 $(a_1, ..., a_m)$ 是 $p A_p-$primary 理想，继而 $p$ 就是 $a = (a_1, ..., a_m) subset A$ 中的极小素理想，进而 $p[x]$ 是 $a[x]$ 的极小素理想。此时，在 $A[x]_(p[x])$ 中利用维度定理立得 $"height" p[x] <= m$\
    另一方面，$A$ 上素理想当然可以延拓到 $A[x]$ 上，因此  $"height" p[x] >= m$，两者结合即得 $"height" p[x] = m$

    取 $A[x]$ 中最长的素理想升链：
    $
    q_0 < ... < q_(s - 1) < q_s
    $
    若 $q_i inter A != q_(i - 1) inter A, forall i$，则 $s <= dim A$ 与之前的下界矛盾。\
    因此设 $q_i inter A = q_(i-1) inter A = p_i$，显有 $q_i, q_(i-1) subset p_i [x] + (x)$ 而后者是极大理想。之前证明了纤维维度为 $1$，进而必有 $q_i = p_i [x] + (x)$，由极大性可得 $i$ 只能为 $s$，进而 $s = dim A + 1$，证毕