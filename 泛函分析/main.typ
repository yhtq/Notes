#import "../template.typ": *
#import "@local/fletcher:0.5.5" as fletcher: diagram, node, edge
#show: note.with(
  title: "泛函分析/Functional Analysis",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let complete(x) = $tilde(#x)$
= 前言  
  - 教师：刘保平 baoping\@math.pku.edu.cn
  - 教材：张恭庆《泛函分析讲义》
  - 内容：Ch1 Ch2 Ch4
  - 参考书：
    - Bulher & Salamon 《Functional Analysis》
    - Yoshiida 《Functional Analysis》
    - Lax 《Functional Analysis》
    - Muscat 《Functional Analysis》
    - Ciarlet 《Linear & Nonlinear Functional Analysis with Applications》 
  - 作业：每周一布置，周一课间收作业，不接受迟交。少计一次最低分
  - 作业 20% + 期中 30% + 期末 50%，考试包括一些作业题
  泛函分析在二十世纪二三十年代一度是数学研究的热门，而现在基本成为了许多数学分支需要的语言。
= 空间理论：度量空间，Banach 空间，Hilbert 空间
  == 度量空间
    #definition[度量空间][
      设 $X$ 是一个集合，$d : X times X -> RR$，且满足：
      - $d(x, y) >= 0, d(x, y) = 0 <=> x = y$
      - $d(x, y) = d(y, x)$
      - $d(x, y) <= d(x, z) + d(z, y)$
      则称 $d$ 是度量/距离函数，称 $(X, d)$ 为度量空间
    ]
    #example[][
      - 欧式空间 $RR^n$ 与欧式度量
      - $QQ^n$ 与欧式度量
      - $X$ 是任意集合，$d(x, y) = delta_(x y)$ 称为离散度量
      - $X = C([a, b])$，度量使用 $d(f, g) = sup (f - g)$
      - $X$ 为 $RR^2$ 中的可测集，商掉差集等于零测的等价关系。度量定为差集的测度
    ]
    #definition[乘积空间][
      设 $(X, d_X), (Y, d_Y)$ 是度量空间，可以有多种方式在 $X times Y$ 上定义度量，例如：
      - $d((x_1, y_1), (x_2, y_2)) = max(d_X (x_1, x_2), d_Y (y_1, y_2))$
      - $d((x_1, y_1), (x_2, y_2)) = d_X (x_1, x_2) + d_Y (y_1, y_2)$
      - ...
    ]
    #definition[度量拓扑][
      设 $(X, d)$ 为度量空间：
      - $B_r (p) = {x in X | d(p, x) < r}$ 称为开球
      - 设 $E subset X$，称 $p$ 是 $E$ 的内点，如果存在 $r > 0$ 使得 $B_r (p) subset E$
      - 设 $E subset X$，称 $E$ 是开集，如果 $E$ 中的每个点都是 $E$ 的内点
      - 设 $E subset X$，称 $E$ 是闭集，如果 $X - E$ 是开集
      - 定义 $E$ 的内部为 $E$ 中最大的开集，也即内部所有开集的并
      - 定义 $E$ 的闭包为包含 $E$ 的最小闭集，也即所有包含 $E$ 的闭集的交
    ]
    #definition[稠密集/dense][
      设 $(X, d)$ 是度量空间，$E subset X$，称 $E$ 是稠密的，如果 $E$ 的闭包是 $X$
    ]
    #definition[保距/同构][
      设 $(X, d_X), (Y, d_Y)$ 是度量空间，$f : X -> Y$ 称为保距映射，如果 $d_Y (f(x), f(y)) = d_X (x, y)$. 显然保距映射一定是单射。\
      如果 $f$ 是满的保距映射（此时一定是双射），则称 $f$ 是同构。
    ]
    === 完备性/Completeness
      #definition[完备度量空间][
        设 $(X, d)$ 是度量空间
        - 称 $x_n$ 是柯西列，如果 $forall epsilon > 0, exists N, n, m > N => d(x_n, x_m) < epsilon$
        - 如果 $X$ 中的柯西列都收敛，则称 $X$ 是完备的
      ]
      通常来说，我们希望研究完备的度量空间。仿照 $QQ -> RR$ 的过程，事实上任何度量空间都可以进行完备化，保距地嵌入一个完备的度量空间。事实上，我们可以找到一个最小的完备化：
      #definition[完备化][
        设 $X$ 是度量空间，如果 $complete(X)$ 是完备的，且满足泛性质:

        // #diagram(cell-size: 15mm, $
        //   G edge(f, ->) edge("d", pi, ->>) & im(f) \
        //   G slash ker(f) edge("ur", tilde(f), "hook-->")
        // $)
      ]
      #theorem[][
        每个度量空间都有一个完备化，且原空间在完备化之中是稠密的。
      ]
      #proof[
        设 $X$ 是度量空间：
        + 定义 $complete(X)$ 为 $X$ 中所有的柯西列，商掉等价关系 $d(x_n, y_n) -> 0$（注意到可以证明 $d(x_n, y_n)$ 是关于 $n$ 的柯西列，由 $RR$ 的完备性它总有极限）
        + 定义 $complete(d)({x_n}, {y_n}) = lim_n d(x_n, y_n)$，可以验证定义是良好的
        + 验证 $complete(d)$ 确实是度量
        + 验证稠密性。事实上取嵌入 $i$，则对于任何 $complete(X)$ 中元素 $(x_n)$，往证 $i(x_n) -> (x_n)$. 事实上，对于任何 $epsilon > 0$，取 $N$ 使得 $forall n, m > N, d(x_n, x_m) < epsilon$，则 $d(i(x_(N + 1)), x_n) = lim_n d(x_n, x_(N + 1)) < epsilon$
        + 验证泛性质：假设 $X$ 嵌入 $Y$，断言 $X$ 在 $Y$ 中闭包同构于 $complete(X)$
        + 验证完备性。设 $(xi_k)$ 是 $complete(X)$ 中的一个柯西列。取：
          $
            x_k in X space s.t. space d(i(x_k), xi_k) < 1/2^k
          $
          断言 $x_k$ 是 $X$ 中柯西列。事实上有：
          $
            d(x_k, x_l) = d(i(x_k), i(x_l)) <= d(i(x_k), xi_k) + d(xi_k, xi_l) + d(xi_l, i(x_l)) < 1/2^k + 1/2^l + d(xi_k, xi_l)
          $
          由 $xi_k$ 是柯西列，当然有上式在 $k, l$ 充分大时趋于零。\
          进而，取 $theta = (x_k) in complete(X)$，断言 $xi_k -> theta$，计算：
          $
            d(xi_k, theta) <= d(xi_k, i(x_k)) + d(i(x_k), theta) < 1/2^k + d(i(x_k), theta)
          $
          显然 $k$ 充分大时，$d(i(x_k), theta) -> 0$，证毕
      ]
    === 紧性/Compactness
      #definition[紧性][
        - 称 $E subset X$ 是紧的，如果所有 $E$ 的开覆盖都有有限子覆盖
        - 称 $E$ 是预紧的，如果 $E$ 的闭包是紧的
      ]
      #definition[列紧性][
        - 称 $E subset X$ 是列紧的，如果 $E$ 中的任何序列都有收敛子列
        - 称 $E$ 是预列紧的，如果 $E$ 的闭包是列紧的
        （教材上的 (列紧，自列紧) 等同于这里的 (预列紧，列紧)）
      ]
      #example[][
        取 $RR$ 上的离散度量，则 $RR$ 是有界闭的，然而并不是紧/列紧的
      ]
      #definition[完全有界][
        称 $E subset X$ 是完全有界的，如果对于任何 $epsilon > 0$，存在有限个点 $x_1, x_2, ..., x_n (in E)$ 使得 $E subset union.big B_epsilon (x_i)$
      ]<complete-bounded>
      #remark[][
        - @complete-bounded 中，$x_i$ 是否属于 $E$ 是无关紧要的。即使它们都在 $X$ 中，只需取开球中在 $E$ 中的点以及两倍大小的开球即可。
        - 列紧/紧致显然是 $RR$ 上类似性质的推广。然而 $RR$ 上完全有界等价于有界，这一般来说是不成立的。
      ]
      #theorem[][
        设 $X$ 是度量空间，$E subset X$，以下命题等价：
        + $E$ 紧致
        + $E$ 列紧
        + $E$ 是完备的并且完全有界
      ]
      #proof[
        #lemmaLinear[][
          - 设 $A$ 列紧，则 $A$ 完备且完全有界
          - 设 $A$ 完全有界，则 $A$ 中任意序列存在柯西子列。
        ]
        #proof[
          - 
          - 设 $x_i$ 是 $A$ 中无穷序列。对于任何 $epsilon > 0$，存在一个有穷网格：
            $
              union_i B(z_i, epsilon)
            $
            使得 $A subset union_i B(z_i, epsilon)$. 由于只有有穷个球，因此不妨设 $B(z_1, epsilon)$ 中包含无穷个 $x_i$，并取所有其中元素构成子列 $x_i^1$\
            该过程可以对于逐渐下降 $-> 0$ 的 $epsilon_i$ 重复进行，产生 $x_i^1, x_i^2, ...$，等序列。断言 $x_i^i$ 是一个柯西列，事实上由构造方式可以看出：
            $
              forall j > i, d(x_i^i, x_j^j) < 2 epsilon_i 
            $
            因此柯西性是显然的。
        ]
        作为推论，$2 <=> 3$

        再证明 $1 => 2$. 设 $A$ 紧致但不列紧，则存在序列 ${x_i}$ 其任何子列都不收敛。进而，对于每个 $x in A$ 它都不是 $A$ 的聚点，因此可设对于任意 $x$，均有 $exists epsilon_x, B(x, epsilon_x) inter A$ 有限。然而由 $A$ 紧致，存在有限个 $B(x_i, epsilon_i)$ 覆盖 $A$. 这将导致 $A$ 中只有有限个点，而有限集总是列紧的，矛盾！

        最后证明 $3 => 1$，假设 $A$ 不紧致，则存在开覆盖 $U_i$ 无有限子覆盖。由完全有界，存在有限个开球 $B(x_i, epsilon)$ 覆盖 $A$，进而可不妨设 $B(x_1, epsilon)$ 不能被有限个 $U_i$ 覆盖。对 $epsilon_i -> 0$ 重复这一过程，产生序列 $x_i$，并显然该序列是柯西的。假设 $x_i -> x_0$，$x_0 in B(x_0, delta) subset U_k$，则当 $i$ 充分大时，一定有 $B(x_i, epsilon_i) subset B(x_0, delta) subset U_k$，这与每个 $B(x_i, epsilon_i)$ 不能被有限个 $U_i$ 覆盖矛盾！
      ]<compact-lemma>
      #corollary[][
        在度量空间中，以下命题等价：
        - $E$ 预列紧
        - $E$ 预紧
        - $E$ 是完全有界并且每个柯西列都在原空间收敛
      ]<precompact-lemma>
    === 连续函数
      #definition[连续函数][
        设 $X, Y$ 是度量空间，称 $f : X -> Y$ 是连续函数，如果：
        - 对于任何 $x in X, epsilon > 0$，存在 $delta > 0$ 使得 $d(x, y) < delta => d(f(x), f(y)) < epsilon$
        - 等价地，$f$ 在开集上的原像总是开集

        记 $X -> Y$ 的连续函数集合为 $C(X, Y)$
      ]
      #lemma[][
        连续函数 $f$ 将紧集映成紧集。特别的，实值连续函数在紧集上的像有界且有最大最小值。
      ]
      #lemma[][
        紧集上的连续函数一致连续
      ]
      #definition[][
        设 $M$ 是紧的度量空间，$Y$ 是度量空间，便可如下定义 $C(M, Y)$ 上的度量：
        $
          d(f, g) = sup_(x in M) d(f(x), g(x))
        $
        注意由于 $d(f(x), g(x))$ 是 $M$ 上的连续函数，因此上面的 $sup$ 有限存在。
      ]
      #lemma[][
        若 $Y$ 是完备空间，则 $C(M, Y)$ 是完备空间
      ]
      #proof[
        设 $f_n in C(M, Y)$ 是柯西的，则对任意 $x in M$，序列 $f_i (x)$ 都是柯西的，因此有极限，定为 $f(x)$.

        只需证明：
        - $f_n -> f$:
          对于任意 $x$，找到充分大的 $m_x$ 使得 $d(f_(m_x) (x), f(x)) < epsilon$，则：
          $
            d(f_n (x), f(x)) <= d(f_n (x), f_(m_x) (x)) + d(f_(m_x) (x), f(x)) < d(f_n (x), f_(m_x) (x)) + epsilon
          $
          由 $f_n$ 的柯西性，$n$ 充分大（与 $x$ 无关）时即有上式 $< 2 epsilon$
        - $f(x)$ 是连续函数：对于任意 $epsilon > 0$，设 $d(f_n, f) < epsilon$，再由 $f_n$ 在 $M$ 上一致连续，设 $forall d(x, y) < delta, d(f_n (x), f_n (y)) < epsilon$，立刻有对于任何 $x, y$ 都有：
          $
            d(f(x), f(y)) <= d(f(x), f_n (x)) + d(f_n (x), f_n (y)) + d(f_n (y), f(y)) < 3 epsilon
          $
          因此 $f$ 一致连续，当然连续
      ]
      通常来说，我们希望研究 $C(M, Y)$ 中何种集合是紧/列紧的，这样我们便可以找到函数序列的收敛子列。
      #definition[][
        设 $f_i (x) in C(X, RR)$，则称：
        - $f_i (x)$ 一致有界，如果存在 $M > 0$ 使得 $forall x in X, |f_i (x)| < M$
        - $f_i (x)$ 等度连续，如果对于任何 $epsilon > 0$，存在 $delta > 0$ 使得 $|x - y| < delta => |f_i (x) - f_i (y)| < epsilon$
      ]
      #lemma[Arzala-Asali][
        设 $X$ 紧，则 $F subset C(X, RR)$ 预紧当且仅当 $F$ 一致有界且等度连续
      ]
      #proof[
        由 @precompact-lemma，只需证明 $F$ 完全有界当且仅当 $F$ 一致有界且等度连续。
        - 设 $F$ 完全有界，则对于任何 $epsilon > 0$，存在 $f_1, f_2, ..., f_n in F$ 使得 $F subset union_i B (f_i, epsilon)$. 可以看出：
          - $F$ 一致有界，既然每个 $f_i$ 都有界，而 $F subset union_i B (f_i, 1)$ 中每个函数都有一致的界
          - $F$ 等度连续，既然对于任何 $epsilon > 0$ 可以假设：
            $
              forall d(x, y) < delta, d(f_i (x), f_i (y)) < epsilon
            $
            因此就有：
            $
              forall f in F, d(x, y) < delta, d(f (x), f (y)) < d(f(x), f_i (x)) + d(f_i (x), f_i (y)) + d(f_i (y), f(y))\
              exists i, d(f, f_i) < epsilon => exists i, d(f(x), f_i (x)) + d(f_i (x), f_i (y)) + d(f_i (y), f(y)) < 3 epsilon\
              forall f in F, d(x, y) < delta, d(f (x), f (y)) < 3 epsilon
            $
            得证
        - 设 $F$ 一致有界且等度连续，则对于任何 $epsilon > 0$，由等度连续可设：
          $
            forall d(x, y) < delta, f in F, d(f (x), f (y)) < epsilon
          $
          不难发现 $forall x in M, B(x, epsilon)$ 是 $M$ 的开覆盖，则它有有限开覆盖 $B(x_i, epsilon)$\
          注意到 $F((x_1, x_2, ..., x_p)) subset RR^p$ 是完全有界，则存在有限个点 $f_i (...)$ 使得：
          $
            forall f in F, exists f_i suchThat |f (x_j) - f_i (x_j)| < epsilon, forall j
          $<ieq2>
          这表明对于任何 $f in F$，均有：
          $
            d(f(x), f_i (x)) <= d(f(x), f(x_j)) + d(f(x_j), f_i (x_j)) + d(f_i (x_j), f_i (x)) < 3 epsilon
          $
          其中 $i$ 是@ieq2 中 $i$，$j$ 是有限开覆盖 $B(x_i, epsilon)$ 中对应 $j$     
      ]
      接下来，我们希望将上面的定理推广到一般的度量空间中：
      #definition[][
        称 $F subset C(M, Y)$ 是点预紧(point-wise pre-compact)的，如果对于任何 $x in M$，$F(x)$ 是 $Y$ 中的预紧集
      ]
      #theorem[][
        设 $M$ 是紧的度量空间，$Y$ 是完备的度量空间，则 $F subset C(M, Y)$ 预紧当且仅当 $F$ 点预紧且等度连续
      ]


