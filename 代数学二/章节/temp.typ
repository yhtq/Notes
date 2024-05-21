#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram
#show: note.with(
  title: "代数学二",
  )
= 代数学二
  #corollary[][
    $deg kai_q (n) = deg kai_m (n)$ 且首项相等
  ]
  #proof[
    注意到：
    $
    m subset q subset m^r\
    m^n subset q^n subset m^(r n)
    $
    由长度的定义可得：
    $
    kai_m (n) <= kai_q (n) <= kai_m (r n)
    $
    令 $n -> infinity$ 可得结论
  ]
  #definition[][
    设 $A$  是诺特的局部环，则令：
    $
    d(A) = deg kai_q (n) = deg kai_m (n) = deg( n -> "length"(A quo m^n)) = d(G_m (A))\
    where G_m (A) = directSum (m^i quo m^(i+1))
    $

  ]
  == 诺特局部环的维度
    #definition[][
      设 $A$  是诺特的局部环，令 $delta(A)$  为 $A$  中 $m-$ primary 理想的最小生成元数量。
    ]
    本节的目标是：
    $
    delta(A) = d(A) = dim (A)
    $
    为此，我们证明：
    $
    delta(A) >= d(A) >= dim (A) >= delta(A)
    $
    #proposition[][
       设 $M$  是有限生成 $A-$ 模，$x$ 不是零因子，则：
       $
       deg kai_q^(M quo x M) <= deg kai_q (M) - 1
       $
    ]
    #proof[
      令 $N := x M$，作为 $AModule(A)$  同构于 $M$\
      再令 $M' = M quo x M$\
      由 Artin-Rees 可知 $N_n = N sect q^n M$  是稳定 $q-$filtration\
      由正合列：
      $
      0 -> N quo N_n -> M quo q^n M -> M' quo q^n M' -> 0
      $
      由长度的加性，$n$ 充分大时有：
      $
      l(N quo N_m) - kai_q^M (n) + kai_q^M' (n) = 0
      $
      既然 $N$  与 $M$  同构且 $q-$filtration 兼容，$l(N quo N_m), kai_q^M (n)$  有相同的次数和首项，因此 $kai_q^M' (n)$  必然比其至少低一次
    ]
    #proposition[][
      $d(A) >= dim(A)$
    ]
    #proof[
      做归纳：
      - 若 $d(A) = 0$，则 $n$ 充分大时 $A quo m^n$ 的长度的常值，继而：
        $
        l(m^n quo m^(n+1)) = 0
        $
        注意到它是 $A quo m$ 上的向量空间，因此 $m^n = m^(n+1)$,这是标准的 Artin 条件，故 $A$ 是 Artin 的，$dim A = 0$
      - 一般的，任取素理想升链：
        $
        p_0  < ... < p_l
        $
        取 $x in p_1 - p_0, A' = A quo p_0$ 是整环，继而由之前的命题：
        $
        d(A' quo x) <= d(A') - 1
        $
        注意到 $A quo m^n$ 到 $A' quo m'^n$ 存在满射，因此：
        $
        l(A quo m^n) >= l(A' quo m'^n)\
        d(A) >= d(A') >= d(A' quo x) + 1
        $
        由归纳假设，有：
        $
        d(A' quo x)>= dim (A' quo x)
        $
        然而由最开始的素理想升链可得 $dim(A' quo x')$ 不小于 $dim A - 1$，结合上式即得结论
    ]
    #corollary[][
      - $dim(A)$ 有限
      - 对于一般的诺特环 $A$，每个素理想的降链都有限长
    ]
#proposition[][
  设 $A$ 是诺特的局部环，$dim A = d$，则存在 $m-$primary 理想恰有 $d$ 个生成元。换言之，$delta(A) <= d$
]
#proof[
  归纳构造 $x_i$ 使得每个包含 $(x_1, x_2, ..., x_i)$ 的素理想的 height 都至少为 $i$\
  假设 $x_1, ..., x_(i-1)$ 已经构造，令 $p_j$ 是包含 $(x_1, ..., x_(i-1))$ 的极小素理想且高度恰为 $i -1$，也就是 $Ass(A quo (x_1, ..., x_(i-1)))$ 中极小元（仅有有限个）\
  既然 $i - 1< d = dim A$ 而 $m$ 的高度就是 $d$，因此 $p_j$ 不是 $m$，取 $x_i in m - union p_j$\
  设 $q$ 是任意包含 $(x_1, ..., x_i)$ 的素理想，则 $q$ 包含某个包含 $(x_1, ..., x_(i-1))$ 的极小素理想 $p$
  - 若 $p = p_j$，则 $x_i in q - p$ 表明 $p subset.neq q$，表明 $q$ 的高度至少是 $p$ 的高度加一，结论成立
  - 否则，由于刚才取得了所有高度为 $i - 1$ 的极小素理想，$p$ 的高度至少为 $i$，继而 $q$ 也至少有高度 $i$
]
#example[][
  之前证明了多项式环的幂级数是 $1 / (1-t)^n$ ，因此它的维度也是 $n$
]
#corollary[][
  设 $A$ 是诺特的局部环，$k$ 是留域，则 $dim A <= dim_k m quo m^2$
] 
#proof[
  取 ${x_i} subset m$ 使得它们的像构成 $m quo m^2$ 的一组基，此时 $x_i$ 必然生成 $m$（利用 Nakayama 引理的推论），因此有：
  $
  dim A = delta(A) <= dim_k m quo m^2
  $
]
#corollary[][
  设 $A$ 是不一定局部的诺特环，$x_1, ..., x_r in A$，则每个包含 $x_1, ..., x_r$ 的极小素理想的高度都不大于 $r$
]
#proof[
  在 $A_p$ 中当然有：
  $
  sqrt((x_1, ..., x_n)) = p A_p
  $
  表明：
  $
  r >= delta(A_p) = dim A_p = "height"(p)
  $
]
#theorem[Krull's principal ideal theorem][
  设 $A$ 诺特，$x$ 不是单位或零因子，$p$ 是包含 $x$ 的极小素理想，则 $p$ 的高度就是 $1$
]
#proof[
  由上面的引理，$p$ 的高度只能为零或一
  - $"height" (p) = 0$，之前证明过这样的素理想（也就是环上的极小素理想）其中每个元素都是零因子，与 $x in p$ 是矛盾的
  因此只能为 $1$
]
#corollary[][
  $dim A = dim hat(A)$
]
#proof[
  注意到：
  $
  A quo m^n tilde.eq hat(A) quo hat(m)^n
  $
  当然特征多项式是一致的
]
#definition[][
  设 $A$ 是诺特局部环，$d = dim A$， 若 $sqrt((x_1, ..., x_d)) = m$，则称 $x_1, ..., x_d$ 是一个参数系统|system of parameters
]
#proposition[][
  设 $q = (x_1, ... x_d)$ 是参数系统，$f(t_1, ..., t_d)$ 是 $s$ 次齐次多项式，且系数落在 $q^(s + 1)$ 中，则这些系数也落在 $m$ 中
]
#proof[
  考察：
  $
  funcDef(phi, A quo q [t_1, ..., t_d], G_q (A),t_i, x_i)
  $
  容易验证它是满射\
  假设 $f$ 有系数不在 $m$ 中，由前面的习题有 $phi(f)$ 不是零因子，将有：
  $
  d(G_m (A)) <= d( (A quo q [t_1, ..., t_d]) quo (phi(f))) <= d (A quo q [t_1, ..., t_d]) - 1 = d - 1
  $
  #TODO
  矛盾！

]
#corollary[][
  设 $k = A quo m, x_1, ..., x_d$ 是参数系统，则 $x_1, ..., x_d$ 代数独立
]
#proof[
  假设有这样的多项式 $f$，取出其中最低非零次 $s$ 齐次部分 $f_s$，断言：
  $
  f_s (x_1, ..., x_d) = 0 in q^s quo q^(s+1), q = (x_2, ..., x_d)\
  $
  由上面的引理，$f_s$ 的系数全在 $m$ 中，与假设矛盾！ 
  
]
#definition[Regular Local Ring][
  设 $A$ 是诺特的局部环，$dim A = d, m$ 是极大理想，$k = A quo m subset A$，若以下等价条件成立：
  - $G_m (A) tilde.eq k[t_1, ..., t_d]$
  - $dim_k m quo m^2 = d$
  - $m$ 可被 $d$ 个元素生成
]
#proof[
  - 1 $=>$ 2 计算庞卡莱级数即可#TODO
  - 2 $=>$ 3 Nakayama
  - 3 $=>$ 1 前面定义了典范的满射 $k[x_1, ..., x_n] -> G_m (A)$，由上一个命题的代数独立性这里 $ker$ 为零，继而是同构
]
#lemma[][
  设 $A$ 是环，$I$ 是理想且 $sect I^n = 0$，假设 $G_I (A)$ 是整环，则 $A$ 是整环
]
#proof[
  任取 $x, y != 0$，取最大的 $r, s$  使得：
  $
  x in I^r\
  y in I^s
  $
  则 $x y$ 在 $G_I (A)$ 中的像非零，当然就有 $x y != 0$
]
#corollary[][
  - Regular Local Ring 是整的
  - Regular Local Ring 是整闭的
]
#proof[
  - $k[t_1, .., t_d]$ 当然是整环
  - $dim = 1$ 时，由于离散赋值环等价于切空间 $m quo m^2$ 恰为一维，故结论成立。一般的证明略。
]
#proposition[][
  若 $A quo m subset A$，则
  $A$ regular $<=> hat(A)$ regular
]
#proof[
  注意到 $G_m (A) = G_(hat(m)) (hat(A))$，结论显然
]
#corollary[][
  设 $A$ 是 regular local ring ,$k$ 是留域，则 $hat(A)$ 同构于 $k[[t_1, ..., t_d]]$
]

= 常微：幂级数解法
  == 一般幂级数
    本章中 $y$ 允许多元函数
    #lemma[][
      设微分方程：
      $
      cases(
        der(y, x) = f(x, y),
        y(x_0) = y_0
      )
      $
      其中 $f$ 在 $x_0$ 附近解析，则它的解存在唯一，且是解析函数。
    ]
    #proof[
      前面 Picard 序列的证明中给出了这个推论
    ]
    理论上来说，幂级数展开并比对系数可以将一般的微分方程化为代数方程。然而一般的情形仍然难以计算，最常见的情形是对线性方程做展开。
    #example[][
      - $der(y, x) = y - x$，令 $y = sum_i a_i x^i$，计算得：
        $
        sum_(i >= 1) i a_i x^(i-1) = sum_i a_i x^i - x
        $
        有：
        $
        a_1 = a_0\
        2 a_2 = a_1 - 1\
        (i+1) a_(i+1) = a_i\
        $
        可以递推解得 $a_i$
      - $y'' - 2 x y' + 4 y = 0$，令 $y = sum_i a_i x^i$，计算得：
        $
        sum_i (i+1)(i+2)a_(i+2)x^i - 2 sum_i i a_(i) x^i - 4 sum_i a_i x^i = 0 
        $
        得到一般的递推关系：
        $
        (i+1)(i+2)a_(i+2) = 2 i a_i + 4 a_i\
        (i+1) a_(i+2) = 2 a_i
        $
      - $y'' = x y$，计算得：
        $
        sum_i (i+1)(i+2)a_(i+2)x^i = sum_i a_(i-1) x^i
        $
        有：
        $
        a_2 = 0\
        (i+1)(i+2)a_(i+2) = a_(i-1)
        $
        可以解得：
        $
        a_(3 k + 2) = 0\
        a_(3 k) = ((3k - 3)!!!)/((3k) !) a_0
        $
    ]
    #remark[][
      对于形如：
      $
      u(x) der(y, x) = v(x, y)
      $
      的微分方程，如果 $u(x) > 0$，将其除掉即可得到解的解析性。但若 $u(x)$  有零点情形未必。例如：
      $
      cases(
        x^2 der(y, x) = y - x,
        y(0) = 0
      )
      $
      若其有解析解，比对系数发现一定有 $a_n = n!$，但是这个幂级数不收敛，因此是荒谬的。下节的目标便是处理这种方程。
    ]
  == 广义幂级数 
    #definition[广义幂级数][
      称：
      $
      sum_(n=0)^(+infinity) a_n x^(n + alpha), alpha in RR
      $
      为广义幂级数。
    ]
    #theorem[][
      设二阶微分方程：
      $
      y'' + p(x) y' + q(x) y = 0
      $
      其中 $p, q$ 可能以 $0$ 为奇点，但 $x p, x q^2$ 都在 $0$ 处解析，则它在 $0$ 附近有广义幂级数解
    ]
    #proof[
      方程等价于：
      $
      x^2 y'' + x (sum_i a_i x^i) y' +  (sum_i b_i x^i) y = 0
      $
      设 $y = sum_(n=0)^(+infinity) c_n x^(n + alpha)$，代入得：
      $
      x^(alpha)(sum_(n=2)^(+infinity) c_n (n+alpha)(n+alpha-1) x^(n) \
      + (sum_(n=1)^(+infinity) c_n (n+alpha) x^(n))(sum_(i=0)^infinity a_i x^i) \
      + (sum_(n=0)^(+infinity) c_n  x^(n))(sum_(i=0)^infinity a_i x^i)) = 0
      $
    ]
    #example[贝塞尔方程][
      方程：
      $
      y'' + 1/x y' + (x^2 - n^2) / x^2 y = 0
      $
      称为贝塞尔方程，由上面的定理它在 $0$  附近有广义幂级数解，并且计算可得 $n$ 是正整数时解是整函数。
    ]
