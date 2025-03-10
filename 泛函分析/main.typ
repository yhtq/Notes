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
        连续函数将预紧集映成预紧集
      ]
      #proof[
        设 $B = f(A)$，则：
        - $f(overline(A)) subset overline(B)$: 显然
        - 假设 $f(overline(A)) != overline(B)$，则可以取得点 $p in overline(B) - f(overline(A))$. 由定义，可设：
          $
            exists p_i in B, p_i -> p
          $
          换言之：
          $
            exists a_i in overline(A), f(a_i) -> p
          $
          然而 $overline(A)$ 是紧集，连续函数在紧集上的像是闭的，因此 $p in f(overline(A))$，矛盾！
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
      #theorem[Arzela-Ascoli][
        设 $M$ 是紧的度量空间，$Y$ 是度量空间，则 $F subset C(M, Y)$ 预紧当且仅当 $F$ 点预紧且等度连续
      ]
      #proof[
        - 假设 $F$ 预紧：取：
          $
            funcDef(tau_x, C(X, Y), Y, f, f(x))
          $
          则它是连续函数，由连续函数保持预紧性，$F(x)$ 是预紧的。而等度连续的证明与之前类似。
        - 假设 $F$ 点列紧且等度连续，证明完全有界同前。同时，还要证明 $F$ 的闭包是完备的。设 $f_n$ 是柯西列，注意到 $f_n (x)$ 对于任何 $x$ 都柯西，而 $F(x)$ 是预紧的，因此 $f_n (x)$ 收敛，记极限为 $f(x)$，只需验证：
          - $f_n -> f$: 任取 $epsilon$，可设 $n, m > N$ 时，$d(f_n, f_m < epsilon)$，进而：
            $
              d(f_n (x)) - d(f(x)) = d(f_n (x) - f_m (x)) + d(f_m (x) - f(x)) < epsilon + d(f_m (x) - f(x))
            $
            令 $m$ 充分大，上式 $<= 2 epsilon$，证毕
          - $f in C(X, Y)$：注意到上面的收敛事实上是一致收敛，因此 $f$ 是连续的
      ]
      AA 定理的经典应用是在 ODE 中证明 Peano 定理和 Picard 定理，构造欧拉折线并证明欧拉折线满足 AA 定理的条件，进而存在一个收敛子列。类似的想法在 PDE 中也有很多应用。
  == 赋范空间/Norm Vector Space 
    === 线性空间
      我们使用与线性代数相同的定义。这里为了区分清楚，将纯代数意义上的基称为 Hamel Basis。
      #theorem[][
        - 设 $X$ 是非零的线性空间，则 $X$ 中存在 Hamel 基
        - 线性空间中，两个 Hamel 基等势
      ]
      #proof[
        设 $A$ 是 $X$ 中所有线性无关子集构成的集合
        -  $A$ 非空：显然单个非零向量构成的集合是线性无关的
        -  $A$ 有上界：显然 $A$ 本身是一个上界
        -  每个链有最大值：假设 $Z_i$ 是一个增链，则 $union.big_i Z_i$ 是该增链的最大值。只需证明它线性无关，而注意到线性有关只涉及有限个向量，因此这些向量一定被包含在某个 $Z_i$ 中，进而线性无关。
        因此 $A$ 有极大元 $Gamma$，而极大的线性无关子集当然就是 Hamel 基。

        对于第二个命题，假设 $E, F$ 是两个 Hamel Basis，则对于任意 $f in F$，设：
        $
          v = sum_(i in I) lambda_i e_i\
          E(f) = {i in I | lambda_i != 0}  
        $ 
        显然 $E(f) subset E, union.big_(f in F) E(f) subset E$. 同时，显然 $union.big_(f in F) E(f)$ 是一个基，因此当然有 $E = union.big_(f in F) E(f)$。当 $E$ 有限时 $F$ 当然也有限，线性代数知识足以给出结论，而假设两者都无限时有：
        $
          abs(E) = abs(union.big_(f in F) E(f)) <= abs(union.big_(f in F) NN) <= abs(F times NN) = abs(F)
        $
        同理有 $abs(F) <= abs(E)$，因此 $abs(E) = abs(F)$
      ]
      大多数情况下，无穷维空间的 Hamel 基是无法直接找出的。一个特例是多项式空间，${1, x, x^2, ...}$ 就是一个自然的 Hamel 基。注意在 $prodf() RR$，${1_i}$ 并不构成一组基，因为无穷个位置非零的元素不能由有限个线性组合得到。
    === 赋范空间
      自然的，我们会想到如何在线性空间上定义距离。事实上，按照直觉应当有：
      $
        d(x, y) = d(x - y, 0)
      $
      因此只需考虑如何定义 $d(x, 0)$ 就足够了。这样的函数被称为范数。
      #definition[范数][
        设 $X$ 是线性空间，称 $n : X -> RR$ 是范数，如果：
        - $n(x) >= 0, n(x) = 0 <=> x = 0$
        - $n(lambda x) = |lambda| n(x)$
        - $n(x + y) <= n(x) + n(y)$
        往往在给定范数的情况下，用 $norm(-)$ 表示范数。对于带有范数的线性空间，称之为赋范空间或者 $B^*$ 空间。 
      ]
      #remark[][
        范数可以自然的诱导一个度量，即 $d(x, y) = norm(x - y)$. 同时，若一个度量是与线性空间的线性结构相容的，则它也可以诱导一个范数。
      ]
      #definition[Banach 空间][
        称赋范空间 $X$ 是 Banach 空间，如果 $X$ 是完备的。有时也记为 $B-$ 空间。
      ]
      #theorem[][
        任何赋范空间可以完备化到一个 Banach 空间
      ]
      #example[][
        - $C[0, 1], norm(f) = sup norm(f)$ 是完备的度量空间
        - $C[0, 1], norm(f) = integral_(0)^(1) abs(f) dif t$ 不是完备的，它的完备化是 $L^1[0, 1]$
        - 取 $directSum_(n = 1)^(+infinity) KK$，$norm(x)_p = (sum_i abs(x_i)^p)^(1/p)$，则对 $p >= 1$ 都是 Banach 空间
      ]
      #definition[][
        假设 $n_1, n_2$ 是 $X$ 上的两个范数，称 $n_1$ 强于 $n_2$，如果存在 $C > 0$ 使得 $n_1 (x) <= C n_2 (x)$ 

        如果还有 $n_2 (x) <= C n_1 (x)$，则称 $n_1, n_2$ 等价
      ]
      #theorem[][
        $n_1$ 强于 $n_2$ 当且仅当所有 $n_2$  范数收敛于零的序列在 $n_1$ 范数下也收敛于零
      ]
      #proof[
        一方面是显然的。另一方面，假设存在一列数使得：
        $
          norm(x_n)_1 > n norm(x_n)_2
        $
        则取 $Z_n = x_n/(norm(x_n)_1)$，不难发现：
        $
          norm(Z_n)_2 -> 0\
          norm(Z_n)_1 = 1
        $
        矛盾！
      ]
    === 有限维空间
      #theorem[][
        设 $X$ 是有限维线性空间，则 $X$ 上所有范数等价
      ]
      #proof[
        取 $e_i$ 是一组基，先取通常的范数（2-范数），同时再取另外一个范数 $norm(*)_2$，设：
        $
          funcDef(f, X, RR, (xi_1, xi_2, ..., xi_i), norm(sum_i xi_i e_i)_2)
        $
        计算：
        $
          norm(f(xi) - f(eta)) <= norm(sum_i (xi_i - eta_i) e_i)_2 <= sqrt(sum_i norm(xi_i - eta_i)^2 sum_i norm(e_i)_2^2) = C norm(xi - eta)
        $
        因此 $f$ 是 Lipschitz 连续的。取单位球 $S = {xi in X | norm(xi) = 1}$，由于连续函数在紧集上有最大值最小值，$f$ 在 $S$ 上有界，换言之，可设：
        $
          forall xi in S, A <= f(xi) <= B
        $
        同时，可以证明 $A, B > 0$，其中 $B > 0$ 是显然的，$A > 0$ 是因为检查 $f$ 的定义发现 $f$ 在 $S$ 上不可能取零。

        上式事实上就是：
        $
          forall xi in X, A <= f(xi)/norm(xi) <= B
        $
        然而，事实上 $f(xi) = norm(xi)_2$，因此：
        $
          forall xi in X, A <= norm(xi)_2/norm(xi) <= B
        $
        证毕
      ]
      #corollary[][
        - 有限维线性空间都是完备的
        - 任何两个维数相同的有限维线性空间同时是代数/拓扑/度量意义上的同构
        - 任何线性空间的有限维子空间都是闭的（既然有限维空间是完备的）
        - 如果 $KK$ 是有界闭的，则 $KK^n$ 是有界闭的
      ]
      上面的事实表明，有限维空间总是几乎和 $KK^n$ 相同，这是符合直觉的。
      #proposition[][
        设 $X$ 是无穷维线性空间，则 $X$ 上总存在不等价的范数
      ]
      #proof[
        取 $X$ 的一个 Hemel 基 ${e_alpha}$，对于任何 $x in X$，取定 $J(x) subset {e_alpha}$ 是有限集，使得：
        $
          x = sum_(alpha in J(x)) lambda_alpha^x e_alpha
        $
        定义以下两种范数：
        $
          norm(x)_1 = sum_(alpha in J(x)) |lambda_alpha^x|\
          norm(x)_infinity = max_(alpha in J(x)) |lambda_alpha^x|
        $
        可以验证它们都是范数，且 $infinity$ 范数控制 $1$ 范数，但是反之 $1$ 范数不可能控制 $infinity$ 范数。事实上，取 $e_i$ 基中的一列，$x_n = sum_(j = 1)^n 1/n e_j$，将有：
        $
          norm(x_n)_infinity = 1/n -> 0\
          norm(x_n)_1 = 1
        $
        因此 $1$ 范数不可能控制 $infinity$ 范数
      ]
      #lemma[Risez][
        设 $X$ 是 NVS，$X_0$ 是闭的非平凡子空间，则对于任意 $epsilon > 0$，可以找到 $y_0 in X suchThat norm(y_0) = 1, dist(y_0, X_0) >= 1 - epsilon$
      ]
      #proof[
        由于 $X_0 in.not X$，设 $Z_0 in X - X_0$，则肯定有：
        $
          d := dist(Z_0, X_0) > 0
        $
        取比较小的 $eta$，可以找到 $x_0$ 使得：
        $
          d <= d(Z_0, x_0) <= d + eta
        $
        则考虑向量 $Y_0 := (Z_0 - x_0)/norm(Z_0 - x_0)$，不难发现任给 $x in X$，有：
        $
          norm(Y_0 - x) = norm((Z_0 - x_0)/norm(Z_0 - x_0) - x) = norm(Z_0 - x_0 - x norm(Z_0 - x_0))/norm(Z_0 - x_0)\
          = norm(Z_0 - (x_0 + x norm(Z_0 - x_0)))/norm(Z_0 - x_0)\
        $
        注意到 $(x_0 + x norm(Z_0 - x_0)) in X$，因此有：
        $
          norm(Z_0 - (x_0 + x norm(Z_0 - x_0)))/norm(Z_0 - x_0) >= d/(d + eta)
        $
        显然只要 $eta$ 足够小就有上式 $>= 1 - epsilon$，证毕
      ]
      #remark[][
        上面的引理中，我们只找到了与 $z_0$ 尽可能远的向量，一般而言，最远的向量（恰好垂直）未必是存在的，例如假设取：
        $
          X = C([-1, 1]), norm(f) = sup_x norm(f(x))\
          X_0 = {f in X mid(|) integral_(0)^(1) f = integral_(-1)^(0) f = 0 }
        $ 
        取 $g$ 使得：
        $
          integral_(-1)^(0) g = -1\
          integral_(0)^(1) g = 1 
        $
        将有：
        $
          integral_(0)^(1) g - f = 1 => sup_(x in [0, 1]) (g - f) >= 1\
          integral_(-1)^(0) g - f = -1 => inf_(x in [-1, 0]) (g - f) <= -1
        $
        同时，这些函数都是闭区间上的连续函数，上下确界均可取得。而假设它们严格相等，将会有 $g = -1, forall x in [-1, 0]; g = 1, forall x in [0, 1]$，与连续性是矛盾的。因此一定有：
        $
          sup_(x in [-1, 1]) (g - f) > 1\
        $
        因此 $dist(g, X_0) >= 1$

        另外，取一串 $g_n$ 逼近 $- 1_[-1, 0] + 1_[0, 1]$，则 $dist(g_n, X_0) arrow.b-> 1$，进而 $dist(g, X_0)$ 恰好为 $1$
      ]
      下面的 Riesz 定理是刻画有限维 NVS 的一个重要定理：
      #theorem[Riesz][
        设 $X$ 是 NVS，以下说法等价：
        + $X$ 是有限维的
        + 单位球 $B = {x in X | norm(x) <= 1}$ 是紧的
        + 单位球面 $S = {x in X | norm(x) = 1}$ 是紧的
      ]
      #proof[
        - $1 => 2$ 显然
        - $2 => 3$ 检查列紧性即可
        - $3 => 1$ 假设 $X$ 是无穷维的，取 $x_0, x_1 in S$，$X_1 = <x_1>$，则由 Riesz lemma 可以找到 $x_2$ 使得 $d(x_1, X_1) >= 1/2$\
          再取 $X_2 = <x_1, x_2>$，以此类推进行。由于空间不是有限维的，这个操作可以一直进行，从而构造出单位球面上的无穷序列，其中每个元素都与前面的元素距离至少 $1/2$。然而条件表明这个序列应该列紧，至少有一个聚点，这是荒谬的。
      ]
    === 商空间与乘积空间
      代数上，可以在线性空间中对子空间做商得到新的线性空间。事实上，我们可以把范数也延拓到商空间上。
      #definition[][
        假设 $X$ 是 NVS，则 $X quo X_0$ 上可以定义函数：
        $
          f(x + X_0) = inf_(z in X_0) norm(x - z)
        $
        则它是良定义的范数。同时，若 $X$ 是完备的，则 $X quo X_0$ 也是完备的
      ]
      #proof[
        - 容易验证 $f$ 是良定义的
        - 若 $f(x + X_0) = 0$，则存在一列 $z_i in X_0 -> x$. 由于 $X_0$ 是闭的，当然 $x in X_0$
        - $norm(lambda (x + X_0)) = norm(lambda x + X_0) = lambda norm(x + X_0)$，容易验证
        - $norm(x + y + X_0) <= norm(x + z_x + y + z_y) <= norm(x + z_x) + norm(y + z_y)$，再由 $z_x, z_y$ 的任意性可得：
          $
            norm(x + y + X_0) <= norm(x + X_0) + norm(y + X_0)
          $
        接下来，假设 $X$ 完备，往证 $X quo X_0$ 完备。给定商空间上柯西列 ${alpha_i + X_0}$，我们希望从中选出适当的代表元使得代表元也是柯西的。

        - 取 $n_k$ 使得 $forall n, m >= n_k$ 有：
          $
            norm((alpha_m - alpha_n) + X_0) < 1/2^k
          $
        - 记 $y_1 = 0$. 由范数定义，存在 $y_2$ 使得：
          $
            norm((alpha_(n_1) - alpha_(n_2)) + y_2) < 1
          $
          存在 $y_3$ 使得：
          $
            norm(((alpha_(n_2) - y_2)  - (alpha_(n_3) - y_3))) < 1/2
          $
        - 以此类推，构造出的 $alpha_(n_i) - y_i$ 一定是一个柯西列。由完备性，假设它收敛到 $x^*$，容易验证 $x_(n_k) -> x^*$，而柯西列的子列收敛足以表明柯西列收敛，证毕。
      ]
      #theorem[][
        假设 $X_0, X quo X_0$ 都完备，则 $X$ 也完备
      ]
      #proof[
        略
      ]
      接下来，考虑（有限的）乘积空间。线性空间的乘积是非常熟悉的，其上的范数有着多种自然的选择。选取一个自然的范数，可以证明（假设 $X, Y$ 非空），$X, Y$ 完备当且仅当 $X times Y$ 完备。由于本门课程中不会涉及较为复杂的无限乘积空间，因此这里不再详细讨论。
  == 内积空间
    #definition[][
      设 $X$ 是线性空间，假设 $inner(-, -) : X times X -> RR$ 是双线性函数，并且满足：
      + $inner(x, y) = inner(y, x)$
      + $inner(x, x) >= 0$
      + $inner(x, x) = 0 <=> x = 0$
      则称 $X$ 是（实）内积空间

      类似的，假设 $inner(-, -) : X times X -> CC$ 对第一个变量线性，对第二个共轭线性，并且满足：
      + $inner(x, y) = overline(inner(y, x))$
      + ...
      则称 $X$ 是复内积空间
    ]
    #theorem[Cauthy Schwarz][
      $
        |inner(x, y)|^2 <= inner(x, x) inner(y, y)
      $
    ]
    #proof[
      略
    ]
    #theorem[][
      - 内积空间上，$sqrt(inner(x, x)), sqrt(inner(x, y)^2)$ 就是自然的范数和内积定义
    ]


