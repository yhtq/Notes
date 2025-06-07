#import "../template.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#show: note.with(
  title: "泛函分析/Functional Analysis",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let complete(x) = $tilde(#x)$
#let Re = math.op("Re")
#let Im = math.op("Im")
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
      ]<compact-condition>
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
      ]<Arzela-Ascoli>
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
    #definition[同构][
      设 $X_1, X_2$ 是两个内积空间，称 $sigma: X_1 -> X_2$ 是内积空间的同构，如果它是保持内积的线性同构
    ]
    下面我们一般采用复内积，因为实内积是复内积的一个特例（共轭等于自身）
    #theorem[Cauthy Schwarz][
      $
        |inner(x, y)|^2 <= inner(x, x) inner(y, y)
      $
    ]
    #proof[
      略
    ]
    #corollary[][
      内积空间上，$sqrt(inner(x, x)), sqrt(inner(x, y)^2)$ 就是自然的范数和内积定义
    ]
    #lemma[][
      $
        norm(x) = sup_(norm(y) <= 1) abs(inner(x, y))
      $
    ]
    #proof[
      无妨设 $x != 0$，则由 Cauthy-Schwarz 不等式：
      $
        abs(inner(x, y)) <= norm(x) norm(y)
      $
      因此：
      $
        sup_(norm(y) <= 1) abs(inner(x, y)) <= norm(x)
      $
      此外，取 $y = x$，则恰有 $norm(x) = abs(inner(x, y))$
    ]
    #lemma[平行四边形法则][
      $
        norm2(x + y) + norm2(x - y) = 2(norm2(x) + norm2(y))
      $
    ]<law-of-parallelogram>
    #proof[
      展开计算即可。
    ]
    #theorem[][
      设 $X$ 是赋范空间，则存在内积与其上的范数相容当且仅当范数满足平行四边形法则
    ]<law-of-norm-which-has-inner>
    #proof[
      假设有内积，则 @law-of-parallelogram 给出了平行四边形法则。反之，假设范数满足平行四边形法则，数域为 $CC$ 时定义：
      $
        inner(x, y) = 1/4 sum_(k=0)^3 i^(k) norm2(x + i^k y)   
      $
      为 $RR$ 时定义：
      $
        inner(x, y) = 1/4 (norm2(x + y) - norm2(x - y) )
      $
      我们只证明较为复杂的 $CC$ 情形：
      + $inner(x, x) = 1/4 sum_(k=0)^3 2^(k) norm2(x + i^k x) = 1/4(4 norm2(x) + 2 i norm2(x)^2 - 2 i norm2(x)^2) = norm2(x)$
      + $overline(inner(y, x)) = overline(1/4 sum_(k=0)^3 i^(k) norm2(y + i^k x)) = 1/4 sum_(k=0)^3 (-i)^(k) norm2((-i)^k y + x)) = inner(x, y)$
      + 线性性：
        $
          inner(x_1 + x_2, y) - inner(x_1, y) - inner(x_2, y) &= 1/4 sum_(k=0)^3 i^k (norm2(x_1 + x_2 + i^k y) - norm2(x_1 + i^k y) - norm2(x_2 + i^k y))\
          &= 1/4 sum_(k=0)^3 i^k (norm2(x_1 + x_2 + i^k y) - 1/2(norm2(x_1 + x_2 + 2 i^k) + norm2(x_1 - x_2)))\
          &= 1/4 sum_(k=0)^3 i^k (norm2(x_1 + x_2 + i^k y) + norm2(y) - norm2(y) - 1/2(norm2(x_1 + x_2 + 2 i^k) + norm2(x_1 - x_2)))\
          &= 1/4 sum_(k=0)^3 i^k (1/2 (norm2(x_1 + x_2 + 2 i^k) + norm2(x_1 + x_2)) - norm2(y) - 1/2(norm2(x_1 + x_2 + 2 i^k) + norm2(x_1 - x_2)))\
          &= 1/4 sum_(k=0)^3 i^k (1/2 (norm2(x_1 + x_2) - norm2(x_1 - x_2)) - norm2(y)))\
          &= 0
        $
        以及：
        $
          inner(i x, y) = 1/4 sum_(k=0)^3 i^k norm2(i x + i^k y) = 1/4 i sum_(k=0)^3 i^(k - 1) norm2(x + i^(k-1) y) = i inner(i x, y)
        $
        这些性质结合我们定义的内积的连续性，足以验证内积对于任何复系数都是线性的。

    ]
    #definition[Hilbert 空间][
      完备的内积空间称为 Hilbert 空间。任何一个内积空间都可以进行完备化。
    ]
    #proof[
      内积空间完备化的步骤是：
      - 先对度量空间做完备化
      - 验证范数可以诱导到完备化空间
      - 验证完备化空间的范数满足平行四边形法则
      - 验证完备化空间上的范数诱导内积与原内积一致
    ]
    // #let orthogonal = $tack.t$
    #definition[正交][
      - 若 $inner(x, y) = 0$，则称 $x, y$ 正交
      - 设 $M subset X$，则定义 $M$ 的正交补 $orthogonalCom(M)$ 
    ]
    #lemma[][
      - $x orthogonal M => x orthogonal span(M)$
      - $x orthogonal y_n, y_n -> y => x orthogonal y$
      - $orthogonalCom(M)$ 一定是闭的线性空间
      - $y orthogonal z => norm2(y + z) = norm2(y) + norm2(z)$
    ]
    #lemma[][
      设 $X$ 是 Hilbert 空间，$C$ 是闭的凸集，则存在唯一Re inner(u_0, x)的 $X_0 in C$ 使得：
      $
        norm(X_0) = inf_(z in C) norm(Z)
      $
    ]
    #proof[
      假设 $inf_(z in C) norm(Z) = 0$，由 $C$ 的闭性可得 $0 in C$，因此取 $0$ 即可，否则取一列 $Z_n$ 使得 $norm(Z_n) -> inf_(z in C) norm(Z)$，有：
      $
        norm2(Z_n - Z_m) + norm2(Z_n + Z_m) = 2(norm2(Z_n) + norm2(Z_m))\
        norm2(Z_n - Z_m) + 4 norm2((Z_n + Z_m)/2) = 2(norm2(Z_n) + norm2(Z_m)) >= norm2(Z_n - Z_m) + 4 inf_(z in C) norm(Z)
      $
      $n, m$ 充分大时，$norm2(Z_n - Z_m) -> 0$，可知 $Z_n$ 是柯西列，因此存在极限 $Z_0$，当然 $norm(Z_0) = inf_(z in C) norm(Z)$

      再证明唯一性，假设 $Z_1, Z_2$ 都满足该性质，则取上面的序列为 $Z_1, Z_2, Z_1, Z_2, ...$ 显然满足上面的假设，因此收敛，继而 $Z_1 = Z_2$
    ]
    #corollary[][
      设 $X$ 是 Hilbert 空间，$C$ 是闭的凸集，则对任意 $y in X$，存在唯一的 $X_0 in C$ 使得：
      $
        norm(X_0 - y) = inf_(Z in C) norm(Z - y) = dist(y, C)
      $
    ]
    #lemma[][
      设 $X$ 是 Hilbert 空间，$C$ 是闭的凸集，则对任意 $y in X$，$x_0 = argmin_(x in C) norm(x - y)$ 当且仅当：
      $
        forall z in C, Re(inner(x_0 - y, y - z)) <= 0
      $
    ]
    #proof[
      设:
      $
        f(t) = norm2(x - ((1 - t) y_0 + y z)), t in [0, 1]
      $
      可以计算得：
      $
        f(t) - f(x_0) = t(2 Re(inner(x_0 - y, y - z)) + t norm2(y - z)) 
      $
      显然 $forall t, f(t) - f(x_0) >= 0 <=> Re(inner(x_0 - y, y - z))$
      
      因此，我们证明了假设 $x_0$ 是逼近点，则后面的性质成立。反之，若性质总成立，利用上面的构造和计算也可以证明 $x_0$ 是逼近点
    ]
    #theorem[正交分解][
      设 $M subset X$, $X$ 是 Hilbert 空间，$M$ 是闭子空间，则：
      $
        X = M directSum orthogonalCom(M)
      $
    ]
    #proof[
      对于任何 $x in X$，取 $y$ 是最佳逼近点（唯一），断言 $x - y orthogonal M$. 事实上，任取 $z in C$，考虑：
      $
        f(t) = norm2(x - y + t z), t in CC
      $
      由最佳逼近性，$f(t)$ 当且仅当 $t = 0$ 时取最小值。同时，有：
      $
        norm2(x - y + t z) = norm2(x - y) + 2 Re (overline(t) inner(x - y, 2 z)) + norm2(t) norm2(z)\
        // = norm2(x - y) + 2 Re t inner(x - y, z) + norm2(t z)
      $
      讨论关于 $t$ 的最小值，可得：
      $
        inner(x - y, z) = 0
      $
      因此 $x = y + (x - y)$

      另外，注意到显然有 $M inter orthogonalCom(M) = 0$，因此是直和。

    ]
    #corollary[][
      设 $M$ 是 Hilbert 空间的闭子空间，则：
      $
        orthogonalCom(orthogonalCom(M)) = M
      $
    ]
    #remark[][
      之前的证明本质上只利用平行四边形法则计算了 $norm(Z_n - Z_m)$，其他性质在 Banach 空间中都能得到，因此可以适当放松范数的性质，仍然可以得到相应的结论。
    ]
  == 赋范空间和内积空间的基
    #definition[Schouder 基][
      设 $X$ 是赋范空间，$E$ 是 $X$ 的至多可数集，若对 $forall x in X$，都存在唯一的 $lambda_alpha$ 使得：
      $
        x = sum_(alpha in E) lambda_alpha alpha
      $（允许无穷和）
      则称 $E$ 是 Schouder 基
    ]<schouder-basis>
    然而，Schouder 基会遇到无穷求和换序的问题，将容易导致奇怪的事情发生，因此我们往往只有在换序不影响结果时，才会讨论 Schouder 基。
    #definition[正交族][
      设 $X$ 是 Hilbert 空间，$S subset X$
      - 若 $forall x, y in S, x orthogonal y$，则称 $S$ 是正交族
      - 若 $S$ 是正交族，且 $forall x in S, norm(x) = 1$，则称 $S$ 是标准正交族
      - 若 $S$ 满足 $orthogonalCom(S) = 0$，则称 $S$ 是完备的
      - 若 $S$ 的张成空间稠密，则称 $S$ 是极大的
    ]
    #lemma[][
      Hilbert 空间中，一族函数极大当且仅当完备
    ]
    #proof[
      假设正交族极大，则任取 $x in orthogonalCom(S)$ 都有：
      $
        x orthogonal overline(span(S)) => x orthogonal x => x = 0
      $

      反之，假设正交族完备，则任取 $x in X$，令：
      $
        x = x_1 + x_2, x_1 in overline(span(S)), x_2 in orthogonalCom(S)
      $
      则 $x_2 orthogonal S => x_2 = 0 => x in overline(span(S))$
    ]
    #definition[Hilbert 基][
      设 $X$ 是 Hilbert 空间，$E$ 是 $X$ 的规范正交族，若 $E$ 是完备/极大的，则称 $E$ 是 Hilbert 基
    ]
    #theorem[][
      Hilbert 基总是存在的
    ]
    #proof[
      利用 Zoun's lemma 即可
    ]
    #lemma[Bessel 不等式][
      设 $X$ 是内积空间，$S$ 是正交族，则任给 $x in X$ 有：
      $
        sum_(e in S) norm2(inner(x, e)) <= norm2(x)
      $
      （注意这里可能出现不可数求和，这里不可数求和的定义是所有有限求和的上确界）
    ]<Bessel-inequality>
    #proof[
      设 $S' subset S$ 是有限集，则：
      $
        norm2(x - sum_(e in S') inner(x, e) e) = norm2(x) - sum_(e in S') norm2(inner(x, e)) >= 0
      $
      由无穷求和的定义结论成立。
    ]
    #corollary[][
      设 $X$ 是内积空间，$S$ 是正交族，则：
      $
        Omega_n = {e in S | norm2(inner(x, e)) >= 1/n}
      $
      是有限集，进而 
      $
      Omega = union_n Omega_n = {e in S | inner(x, e) != 0}
      $
      至多可数。因此，上面引理中的不可数求和也可以换成至多可数求和。
    ]
    #corollary[][
      设 $X$ 是 Hilbert 空间，$S$ 是正交族，则
      $
        sum_(e in S) inner(x, e) e
      $
      收敛，且在换序下保持不变，且：
      $
        norm2(x - sum_(e in S) inner(x, e) e) = norm2(x) - sum_(e in S) norm2(inner(x, e))
      $
    ]<cor-bessel>
    #proof[
      事实上，@Bessel-inequality 说明了 $sum_(e in S) inner(x, e) e$ "绝对收敛"（仿照 $RR$ 时情形，细节略去），因此收敛且经过在换序下不变。而第二个等式在任何有限子集上成立，取极限即可。
    ]
    #theorem[][
      设 $X$ 是 Hilbert 空间，$S$ 是正交族，则以下说法等价：
      -  $S$ 是 Hilbert 基
      - 
        $
          forall x in X, x = sum_(e in S) inner(x, e) e
        $
      - Parseval 等式 $norm2(x) = sum_(e in S) norm2(inner(x, e))$ 成立
    ]
    #proof[
      - $1 => 2$
        $
          x - sum_(e in S) inner(x, e) e orthogonal S => x - sum_(e in S) inner(x, e) e = 0
        $
      - $2 => 3$: @cor-bessel
      - $3 => 1$，假设 $y in orthogonalCom(S)$，则 Parseval 等式给出：
        $
          norm2(y) = sum_(e in S) norm2(inner(y, e)) = 0 => y = 0
        $
        进而 $S$ 完备
    ]
    #example[][
      - $l^2$ 空间中，$S = {e_j}$ 就是 Hilbert 基
      - $L^2 [0, 2pi]$ 中，$K= CC$，$S = {eiB(n theta)/norm(eiB(n theta)) | n in ZZ}$，或者 $K = RR$，$S = {(sin n theta)/norm(sin n theta), (cos n theta)/norm(cos n theta) | n in NN}$
      - $L^2 [-1, 1]$ 中，$K = RR$，考虑 $f_n (x) = x^n, n >= 0$，则 ${f_n}$ 不是正交的，但是是完备的，利用正交化过程即可得到 Hilbert 基。事实上，可以计算出一个显式结果：
        $
          e_n = sqrt(n + 1/2)/(2^n n!) derN(((x^2 - 1)^n), x, n)
        $
        这些多项式称为 Legendre 多项式
      - $L^ [0, +infinity), K = RR, f_n = x^n e^(-x)$，可以证明这些 $f_n$ 也是完备的，正交化的结果是：
        $
          L_n (x) = 1/n! e^(x/2) derN((x^n e^(-x)), x, n)
        $
        这些函数称为 Laguerre 函数
      - $L^2(RR), K = RR, f_n = x^n e^(-x^2/2)$，类似的可以证明完备，可以得到 Hermite 函数：
        $
          H_n (x) = (-1)^n 1/(2^n n! sqrt(2 pi)) e^(x^2/2) derN((e^(-x^2)), x, n)
        $
    ]
  == 可分的 Hibert 空间
    #definition[][
      设 $X$ 是度量空间，若存在至多可数的稠密子集，则称 $X$ 是可分的
    ]
    #theorem[可分的 Hibert 空间][
      设 $X$ 是 Hilbert 空间，域 $K$ 可分，则 $X$ 可分当且仅当存在至多可数的 Hilbert 基
    ]
    #proof[
      - 一方面，假设有至多可数的 Hilbert 基，则它们的以 $K$ 的至多可数稠密子集为系数张成的空间当然是稠密的至多可数子集
      - 另一方面，假设 $X$ 可分，取至多可数的稠密集，依次 Gram-Schmidt 正交化，得到的就是至多可数的 Hilbert 基
    ]
    #corollary[][
      设 $X$ 是可分的 Hilbert 空间，则 $X$ 同构于 $K^n$ 或 $l^2$
    ]
= 线性映射和线性泛函
  == 基础知识 
    #lemma[][
      设 $f : X -> Y$ 是线性的，则它点点连续当且仅当在 $0$ 处连续
    ]
    #proof[
      线性函数在任何点的附近都类似在零点附近，因此结论显然
    ]
    #definition[有界][
      称线性映射 $T$ 是有界的，如果 $norm(T x)/norm(x)$ 有界 
    ]
    #lemma[][
      线性映射有界等价于连续
    ]
    #proof[
      - 若线性映射有界，容易证明在 $0$ 处连续
      - 若线性映射不有界，则可取一列 $x_n$ 使得 $norm(x_n) = 1$，$norm(T x_n) -> +infinity$. 取：
        $
          z_n = x_n/norm(T x_n)
        $
        显然 $z_n -> 0, norm(T z_n) = 1$，因此 $T$ 不连续
    ]
    #remark[][
      有时我们也要讨论子空间上的线性函数，尤其是对于某些无界算子，它在子空间上线性，但往往不能延拓到一个完备的 Banach 空间，只能延拓到一个稠密子空间。例如求导算子只能定义在 $L^2$ 的子空间 $C^1$ 上，并且容易验证是无界的。
    ]
    #definition[][
      设 $X, Y$ 是同一个域上的赋范空间，则定义：
      $
        L(X, Y) = {f : X -> Y mid(|) f "有界线性"}
      $
      线性运算定义为通常的函数运算，范数定义为：
      $
        norm(T) = sup_(norm(x) = 1) norm(T x) = sup_(x != 0) norm(T x)/norm(x)
      $
      （容易验证这是一个范数）

      特别的，记 $L(X) := L(X, X), X^* ("对偶空间"):= L(X, K)$
    ]
    #lemma[][
      假设 $Y$ 是 Banach 空间，则 $L(X, Y)$ 也是 Banach 空间
    ]
    #proof[
      任给 $T_n$ 是柯西列，则对所有 $x, T_n x$ 是柯西列，因此可以定义极限函数 $T$
      - $T$ 是线性的：取极限即可
      - $T$ 是有界的：由柯西性，$norm(T_n)$ 有上界，因此可以证明 $T$ 有界
    ]
    #lemma[][
      设 $T : X -> Y$ 线性，且 $X$ 有限维，则 $T$ 一定有界
    ]
    #proof[
      任取 $X$ 的基，则 $T$ 等价于一个有限维矩阵
    ]
    #example[][
      - 设 $X$ 是 Hilbert 空间，$M$ 是闭子空间，则 $M$ 上的正交投影就是有界线性的（事实上，模恰为 $1$）
      - 设 $X = L^2 [0, 1], T f = integral_(0)^(x) f(t) dif t$，容易证明是线性的，且 $norm(T) = 1/2$
    ]
  == Riesz 表示定理
    当 $X$ 是 Hilbert 空间时，$X^*$ 有非常好的结构。任给 $y in X, f_y (x) = inner(x, y)$ 就是一个 $X^*$ 中的算子，且柯西-施瓦茨不等式保证了它是有界的，模恰为 $norm(y)$. 可以证明，$X^*$ 中所有的元素都可以表示为这种形式。
    #lemma[][
      设 $X$ 是 Banach 空间，$f in duelSpace(X)$，则：
      $
        Inv(f) (0)
      $
      是闭子空间，且
    ]
    #theorem[][
      设 $X$ 是 Hilbert 空间，则 $duelSpace(X)$ 中的每个元素 $f$ 都可以被唯一表示为 $f_y$ 的形式，即：
      $
        exists! y in X, f = inner(*, y)
      $
      并且 $norm(f) = norm(y)$
    ]
    #proof[
      定义：
      $
        M = Inv(f) (0)
      $
      容易验证它是闭子空间，因此可设：
      $
        X = M directSum orthogonalCom(M)
      $
      若 $orthogonalCom(M)$ 为空，则 $M = X$，进而 $f = 0$，取 $y = 0$ 即可。否则，断言 $orthogonalCom(M)$ 是一维的，事实上，注意到：
      $
        f(z/f(z) - y/f(y)) = 0, forall z, y in orthogonalCom(M)
      $
      因此 $z/f(z) - y/f(y) in M => z/f(z) - y/f(y) = 0$，继而 $z, y$ 线性相关。因此取 $orthogonalCom(M)$ 的非零元 $y_0$，有：
      $
        x = f(x)/f(y_0) y_0 + (x - f(x)/f(y_0) y_0), forall x
      $
      并且：
      $
        inner(x, y_0) = f(x)/f(y_0) norm(y_0)
      $
      解得：
      $
        f(x) = inner(x, overline(f(y_0))/norm2(y_0) y_0)
      $
      存在性得证。其他性质是简单的。
    ]
    #corollary[][
      定义：
      $
        funcDef(sigma, duelSpace(X), X, f, y_f)
      $
      则 $sigma$ 是线性/共轭线性的双射。
    ]
    #corollary[][
      设 $X$ 是 Hibert 空间，则 $duelSpace(X)$ 也是，内积定义为：
      $
        inner(f, g) = overline(inner(sigma(f), sigma(g)))
      $
      并且有
      $duelSpace(X) eqv X$
    ]
    #proof[
      有：
      $
        inner(f + g, h) = overline(inner(sigma(f + g), sigma(h))) = overline(inner(sigma(f), sigma(h)) + inner(sigma(g), sigma(h))) = inner(f, h) + inner(g, h)\
        inner(h, f + g) = overline(inner(sigma(h), sigma(f + g))) = overline(inner(sigma(h), sigma(f)) + inner(sigma(h), sigma(g))) = inner(h, f) + inner(h, g)\
        inner(lambda f, g) = overline(inner(sigma(lambda f), g)) = overline(inner(overline(lambda) sigma(f), g)) = lambda inner(f, g)\
        inner(f, lambda g) = overline(inner(sigma(f), overline(lambda) sigma(g))) = overline(lambda) inner(f, g)
      $
      内积的其他性质是显然的，并且 $overline(*) compose sigma$ 是双射，因此 $duelSpace(X) eqv X$
    ]
    #theorem[Lax-Milgram][
      设 $X$ 是 Hilbert 空间，$a$ 是 $X$ 上的 sesquilinear form，且满足：
      - $|a(x, y)| <= M norm(x) norm(y)$
      那么就存在唯一的 $A in L(X)$ 使得：
      $
        a(x, y) = inner(A x, y)
      $
      以及：
      $
        norm(A) = sup_(x, y !=0) norm(a(x, y))/(norm(x) norm(y))
      $
      若还有：
      - $norm(a(x, x)) >= b norm2(x)$
      则 $A$ 可逆，$norm(A) <= 1/b$
    ]<Lax-Milgram>
    #proof[
      有：
      $
        Hom(X tensorProduct Y, KK) eqv Hom(X, Hom(Y, KK)) = Hom(X, Y^*) eqv Hom(X, Y)
      $
      最后一项是因为 Risez 表示定理。事实上，有显式表达式：
      $
        a(x, y) = inner(x, A y)
      $
      其中 $A in Hom(X, Y)$，还要验证有界，这是因为：
      $
        norm2(A y) = norm(inner(A y, A y)) = norm(a(A y, y)) <= M norm(A y) norm(y) => norm(A y) <= M norm(y)
      $
      此外，有：
      $
        norm(a(x, y)) = inner(x, A y) <= norm(x) norm(A y) <= norm(x) norm(A) norm(y)
      $
      因此：
      $
        norm(A) >= norm(a(x, y))/(norm(x) norm(y))
      $
      同时：
      $
        norm(a(A y, y))/(norm(A y) norm(y)) = norm(A y)/norm(y) 
      $
      取上确界就有：
      $
        sup_(x, y !=0 ) norm(a(x, y))/(norm(x) norm(y)) >= sup_(y != 0) norm(a(A y, y))/(norm(A y) norm(y)) = sup_(y != 0) norm(A y)/norm(y) = norm(A)
      $
      这就证明了：
      $
        norm(A) = sup_(x, y !=0) norm(a(x, y))/(norm(x) norm(y))
      $

      若假设后面的条件成立，往证 $A$ 可逆：
      - $A x = 0 => a(x, x) = inner(x, A x) = 0 => 0 >= b norm2(x) => x = 0$
      - $im A$ 是闭的：注意到：
        $
          b norm2(x) <= norm(inner(x, A x)) <= norm(x) norm(A x) => norm(A x) >= b norm(x)
        $
        因此设 $x_n -> x_0$，则：
        $
          norm(A x_n - A x_m) = norm(A (x_n - x_m)) >= b norm(x_n - x_m)
        $
        表明 $A x_n$ 是柯西列，进而收敛，极限当然就是 $A x_0$
      - $orthogonalCom(im A) = {0}$：任给 $x in orthogonalCom(im A)$，则有：
        $
          0 = inner(x, A x) = a(x, x) => b norm2(x) = 0 => x = 0
        $
      这就表明 $A$ 可逆，而 $norm(A) <= Inv(b)$ 是容易的。
    ]
    #corollary[Lax-Milgram2][
      设 $X$ 是 Hilbert 空间，$a$ 是 $X$ 上的 sesquilinear form，且满足：
      - $|a(x, y)| <= M norm(x) norm(y)$
      - $norm(a(x, x)) >= b norm2(x)$
      那么对任何 $f in duelSpace(X)$，存在唯一的 $Z_f in X$ 使得：
      $
        f(x) = a(x, Z_f)
      $
    ]<Lax-Milgram2>
    #proof[
      可设 $f(x) = inner(x, y)$，则：
      $
        f(x) = inner(x, y) = inner(x, A Inv(A) y) = a(x, Inv(A) y)
      $
    ]
    #example[][
      设 $Omega subset RR^n$ 是开区域，函数 $u$ 满足：
      $
        cases(
          - Delta u = f,
          u|_(diff Omega) = 0 
        )
      $
      其中 $f in L^2(Omega)$。为了判断该方程是否有解，可以考虑：
      - 设 $C^M_0 (Omega) = {u in C^m (closure(Omega)) | u = 0 "in a neighborhood of" diff u}$
      - 假设 $u in C^2(Omega)$ 符合方程，则任取 $v$ 都有：
        $
          integral_(Omega)^() (Delta u - f) v dif x = 0
        $
        而分部积分可以将上式重写成：
        $
          integral_Omega (Delta u Delta v - f v) dif x = 0
        $
        我们检查该积分方程是否有解。该积分方程的解称为*弱解*，现代偏微分方程中，我们往往先找出弱解，再将弱解的性质转化为强解的性质。我们在这里只证明弱解存在。
      - 设：
        $
          H_0^m (Omega)
        $
        是在模为：
        $
          norm2(u) = sum_(abs(alpha) <= m) integral_()^() norm2(diff^alpha u) dif x` 
        $
        的 $C_0^m (Omega)$ 的完备化空间。
      - 定义：
        $
          X = H_0^1 (Omega), inner(f, g) = sum_(abs(alpha <=1)) integral_Omega diff^2 f diff^2 g dif x
        $
        以及双线性函数：
        $
          a(f, g) = sum_(abs(alpha = 1)) integral_Omega diff^alpha f diff^alpha g dif x = integral_()^() nabla f nabla g dif x
        $
        我们验证 $a$ 满足之前的条件。条件 1 是显然的，条件 2 相当于：
        $
          integral_(Omega)^() norm2(nabla f) dif x >= C integral_(Omega)^() norm2(f) + norm2(nabla f) dif  
        $
        也就是 $norm(f)$ 是否能被 $norm(nabla f)$ 控制，之后我们会证明它成立。
      - 取：
        $
          F(v) = integral_Omega f v dif x
        $
        它是线性泛函，由 Lax-Milgram 定理，存在唯一的 $u in X$ 使得：
        $
          integral_Omega f v dif x = F(v) = a(v, u) = sum_(abs(alpha) = 1) integral_Omega diff^alpha v diff^alpha u dif x  = integral_Omega nabla v nabla u dif x
        $
    ]
    #lemma[Poincare's 不等式][
      设 $Omega subset RR^n$ 是有界开区域，$f in C_0^m (Omega)$，则：
      $
        norm(u) <= C norm(nabla u)
      $
      （范数是前面定义的范数）
    ]
    #proof[
      只证 $m = 1$ 情形，其他的递推即可。也就是：
      $
        integral_(Omega)^() abs(f)^2 dif x <= C integral_(Omega)^() abs(nabla f)^2 dif x
      $
      由有界性，可设：
      $
        Omega subset D(a)
      $
      其中 $D(a)$ 是各个分量由 $[-a, a]$ 组成的立方体。同时，由 $f$ 的性质，$f$ 可以零延拓到 $D$ 上。有：
      #let x2n = $x_2, x_3, ..., x_n$
      $
        f(autoRListN(x, n)) = f(-a, x2n) + integral_(-a)^(x_1) diff_1 f(t, x2n) dif t\
        = integral_(-a)^(x_1) diff_1 f(t, x2n) dif t
      $
      （这里由延拓的性质，一定有 $f(-a, x2n) = 0$），因此：
      $
        abs(f(x))^2 <= integral_(-a)^(x_1) (diff_1 f(t, x2n))^2 dif t integral_(-a)^(x_1) 1 dif t \
        <= abs(x_1 + a) integral_(-a)^(a) (diff_1 f(t, x2n))^2 dif t
      $
      进而：
      $
        integral_(Omega)^() abs(f)^2 dif x = integral_()^() integral_(-a)^(a) abs(f)^2 dif x_1 dif x2n\
        <= integral integral_(-a)^(a) abs(x_1 + a) integral_(-a)^(a) (diff_1 f(t, x2n))^2 dif t dif x_1 dif x2n\
        <= integral integral_(-a)^(a) abs(x_1 + a) dif x_1 integral_(-a)^(a) (diff_1 f(t, x2n))^2 dif t dif x2n\
        = (integral_(-a)^(a) abs(x + a) dif x) integral_(Omega)^() abs(diff_1 f)^2 dif x 
      $
      证毕。
    ]
    #remark[][
      - 显然上面的不等式依赖于 $f$ 在边界上取零，否则 $f$ 取 $1$ 即可得到反例
      - 结论对 $H_0^m$ 也成立，取极限即可。
    ]
    #theorem[Hahn-Banach][
      设 $X$ 是 Hibert 空间，$X_0$ 是闭子空间，设 $f_0 : X_0 -> KK$ 是有界线性泛函，则存在唯一的 $f : X -> KK$ 是有界线性泛函，满足它是 $f_0$ 的延拓，且：
      $
        norm(f)_(duelSpace(X)) = norm(f_0)_(duelSpace(X_0))
      $
    ]<Hahn-Banach-Hilbert>
    #proof[
      设 $P = P_(X_0)$，则令：
      $
        f(x) = f_0(P x)
      $
      由定义，性质的验证都是简单的。

      接下来证明唯一性：假设 $g$ 也满足条件，设：
      $
        g(x) = inner(x, z), norm(g) = norm(z)
      $
      则：
      $
        g(x) = inner(x, z) = f_0 (x)
      $
      同时：
      $
        inner(x, z) = inner(P x, z) = inner(x, P z), forall x in X_0
      $
      因此显然：
      $
        norm(z) = norm(g) = norm(f_0)_(duelSpace(X_0)) = norm(P z)
      $
      说明 $z = P z$，因此：
      $
        g(x) = inner(x, z) = inner(x, P z) = inner(P x, z) = f_0 (P x) = f(x)
      $
      证毕。
    ]
    #remark[][
      - $X_0$ 放松到一般子空间是容易的，既然有界线性泛函可以很容易的延拓到闭包上
      - 一般而言，$X$ 是 Banach 空间时存在性也是正确的，但这个定理的证明更具有构造性
    ]
  == The great theorems in linear functional analysis I(Baire Category Thm)
    #definition[][
      设 $X$ 是度量空间，称 $E subset X$ 是无处稠密/疏集/nowhere dense，如果 $closure(E)$ 的内部为空（等价于 $closure(E)$ 的补集稠密）
    ]
    #example[][
      - 有限集都是无处稠密的
      - 康托集是无处稠密的
    ]
    #lemma[][
      $E$ 无处稠密当且仅当对于任意 $B(x_0, r_0)$，其中都存在 $B(x_1, r_1)$ 使得：
      $
        closedBall(x_1, r_1) inter closure(E) = emptyset
      $
    ]
    #proof[
      假设 $closure(E)$ 有内点，则内点附近找到的球就不符合条件，因此右推左显然。

      对于左推右，由定义有：
      $
        B(x_0, r_0) subset.not closure(E)
      $
      也就是：
      $
        B(x_0, r_0) inter X - closure(E) != emptyset
      $
      而上面的集合是两个开集的交，当然也是开集，在其中找一个开球即可。
    ]
    #theorem[Baire Category Theorem v1][
      设 $X$ 是完备度量空间，则 $X$ 不能写成可数个无处稠密集的并
    ]
    #proof[
      反证法，假设 $X = Union E_n$，其中 $E_n$ 是无处稠密集，无妨设 $E_n$ 是闭的（否则取闭包即可）。任取 $B(x_0, r_0)$，由 $E_1$ 无处稠密有：
      $
        exists x_1, r_1, B(x_1, r_1) subset B(x_0, r_0) inter X - E_1 and r_1 < 1/2 r_0
      $
      类似的，有：
      $
        exists x_2, r_2, B(x_2, r_2) subset B(x_1, r_1) inter X - E_2 and r_2 < 1/2 r_1
      $
      不断进行下去，得到一列 $x_n$，它是柯西列，因此收敛到 $x$，而不难验证 $x$ 不在任何 $E_n$ 之中，矛盾！
    ]
    #theorem[Baire Category Theorem v2][
      设 $X$ 是完备度量空间，$u_n$ 是开的稠密集，则它们的 $Inter u_n$ 也是稠密的
    ]
    #proof[
      任给 $B(x, epsilon)$，往证 $B(x, epsilon) inter Inter u_n != emptyset$. 由 $u_1$ 的稠密性，有：
      $
        B(x, epsilon) inter u_1 != emptyset
      $
      因此：
      $
        exists x_1, epsilon_1 < epsilon/2, B(x_1, epsilon_1) subset closure(B(x_1, epsilon_1)) subset B(x, epsilon) inter u_1
      $
      类似的，有：
      $
        exists x_2, epsilon_2 < epsilon/2, B(x_2, epsilon_2) subset closure(B(x_2, epsilon_2)) subset B(x_1, epsilon_1) inter u_2
      $
      不断进行下去，得到一列 $x_n$，它是柯西列，因此收敛到 $x$，不难验证 $x in B(x, epsilon) inter Inter u_n$，证毕。
    ]
    #theorem[Baire Category Theorem v3][
      设 $X$ 是完备度量空间，$E_n$ 是无处稠密集，则 $Union E_n$ 也是无处稠密的
    ]
    #definition[][
      设 $X$ 是度量空间，称 $E subset X$ 是第一纲集/first category set，如果 $E$ 可以写成可数个无处稠密集的并。如果 $X$ 不是第一纲集，则称其是第二纲集/second category set
    ]
    #corollary[][
      完备度量空间都是第二纲的
    ]
    #example[][
      - $RR^n$ 不能写成可数个超平面的并
      - 若 $X$ 是无穷维 Banach 空间，则 Hamel 基不可能是可数的。否则，前 $n$ 个 Hamel 基的张成空间是闭的无处稠密集，这些集合的并是全空间，矛盾！
    ]
    #theorem[][
      设 $X = C[0, 1], E subset X$ 是无处可导函数，则 $X - E$ 是第一纲集（可数个无处稠密集合的并），进而 $E$ 是稠密集。
    ]
    #proof[
      考虑：
      $
        A_n = {f in X | exists x in [0, 1], sup_(h != 0) abs((f (x + h) - f(x))/h) <= n}
      $
      显然 $A_n$ 单调增加，且若 $f$ 在某点可导，则 $f in lim A_n = union.big A_n$，换言之：
      $
        X - E subset union.big A_n
      $
      + $A_n$ 是闭集：对于 $f_k -> f$，它们都有对应的一点 $a_k$，不妨设 $a_k$ 收敛于 $a$，则：
        $
          abs((f_k (a_k + h) - f_k (a_k))/h) -> abs((f (a + h) - f(a))/h)
        $
        （一致收敛性保证上式成立）\
        而上式左端 $<= n$，右端也 $<= n$，因此 $f in A_n$
      + $A_n$ 是无处稠密的。只需证明 $A_n$ 不是内点，任取 $f in A_n$，取多项式 $p$ 使得 $norm(p - f) <= epsilon$，再取 $M_0 = sup_(x in [0, 1]) abs(p' (x))$，接下来只需构造一个函数 $R(x)$ 与 $p$ 很近但差分很大即可。事实上，取 $r(x)$ 使得：
        - $norm(r(x)) < epsilon$
        - $forall x, sup_h abs((r(x + h) - r(x))/h) > n + 1 + M_0$
        即可，这样的函数很好取得，只需取波动很大的折线即可。
        接下来：
        $
          norm(p + r - f) <= 2 epsilon
        $
        以及：
        $
          sup_h abs(((r + p)(x + h) - (r + p)(x))/h) >= n + 1 + M_0 - M_0 = n + 1
        $
        因此这就找到了 $f$ 附近的一个不在 $A_n$ 中的点。
      因此可设 $X - E subset F$，其中 $F$ 是第一纲集。然而显然 $F inter E = emptyset$，因此 $F = X - E$，故 $X - E$ 是第一纲集。
    ]
  == BCT 定理的应用：重要定理
    设 $X, Y$ 都是 Banach 空间，假设 $T in L(X, Y)$，并且 $T$ 是双射，则可以定义 $Inv(T)$，然而 $Inv(T)$ 是否有界是一个问题。注意到 $Inv(T)$ 有界等价于 $Inv(T)$ 连续，等价于 $T$ 是开映射/闭映射。因此只需要研究有界线性函数是否是开映射/闭映射即可。
    #theorem[开映射定理][
      设 $X, Y$ 是 Banach 空间，$T in L(X, Y)$ 是满射，则 $T$ 是开映射。
    ]<open-mapping-theorem>
    #proof[
      记 $B_n = B(0, n) subset X$
      #lemmaLinear[][
        存在 $delta > 0$ 使得 $B(0, delta) subset closure(T(B_1))$
      ]
      #proof[
        因为 $T$ 是满射，故：
        $
          Y = union.big T(B_n) subset union.big closure(T(B_n)) subset Y
        $
        因此 $Y = closure(T(B_n))$. 注意到 $T(B_n)$ 是闭的，由 BCT 定理它们中至少有一个是有内点的，因此可设：
        $
          B(y_0, delta_0) subset closure(T(B_n))
        $
        进而：
        $
          B(0, delta_0) subset B(y_0, delta_0) - B(y_0, delta_0) subset closure(T(B_n)) - closure(T(B_n)) subset closure(T(B_(2 n))))
        $
        由定义，显然有：
        $
          B(0, (delta_0)/(2 n)) subset closure(T(B_1))
        $
        证毕
      ]
      #lemmaLinear[][
        存在 $delta > 0$ 使得 $B(0, delta) subset closure(T(B_1))$
      ]
      #proof[
        先取 $delta$ 是之前引理的 $delta$，因此任取 $y in B(0, delta)$，可以找到 $x_1$ 使得：
        $
          norm(T x_1 - y) < delta/2
        $
        然而我们有：
        $
          B(0, delta/2) subset closure(T(B_(1/2)))
        $
        因此可以找到 $x_2$ 使得：
        $
          norm(T x_2 - (y - T x_1)) < delta/2^2
        $ 
        反复进行，可以得到 $x_i in B_(1/2^i)$，并且：
        $
          norm(T(sumi1n(x_i)) - y) <= delta/(2^n)
        $
        注意到 $norm(x_i) < norm(1/(2^n))$，因此 $sumi1inf(x_i)$ 存在，因此取极限即有：
        $
          T(sumi1inf(x_i)) = y
        $
        同时：
        $
          norm(sumi1inf(x_i)) <= 2
        $
        故：
        $
          y in T(B_3)
        $
        由 $y$ 的任意性就有 $B(0, delta) subset T(B_3)$，也即 $B(0, delta/3) subset T(B_1)$，证毕
      ]
      有了之前的引理，假设 $Omega$ 是开集，任取 $y_0 = T x_0 in T(Omega)$，将前面的结论平移得到：
      $
        B(y_0, delta) subset T(B(x_0, 1))
      $
      由于 Omega 是开集，由伸缩性无妨设 $B(x_0, 1) subset Omega$，就有：
      $
        B(y_0, delta) subset T(B(x_0, 1)) subset T(Omega)
      $
      证毕。
    ]
    之后的几个定理也非常重要，且与开映射定理也都是等价的。
    #theorem[Banach 逆算子定理][
      设 $T in L(X, Y)$，$X, Y$ 是 Banach 空间，$T$ 是双射，则 $Inv(T) in L(X, Y)$ 
    ]<Banach-inverse-operator>
    #theorem[等价范数][
      设 $X$ 上有两个范数，它们构成 Banach 空间。只要一个范数控制另一个范数，那么它们是等价的。
    ]<equivalent-norm>
    #proof[
      条件意味着 $id$ 映射是有界线性双射，则 @Banach-inverse-operator 给出逆映射也是。
    ]
    #definition[图像][
      设 $T$ 是线性算子，它的图像定义为：
      $
        G(T) = {(x, T x) | x in X} subset X times Y
      $
      若 $G(T)$ 是闭的，则称 $T$ 是闭算子
    ]
    #theorem[闭图像定理/closed graph][
      Banach 空间之间的闭算子就是有界算子
    ]
    #proof[
      在 $X$ 上可以定义额外的范数：
      $
        norm(x)_T = norm(x) + norm(T x)
      $
      被称为图模。只要图模是完备的，而通常的模显然被图模控制，由 @equivalent-norm 立刻得到结论。

      然而不难注意到，若设 $i: X -> G(T)$，则：
      $
        norm(i x) = norm(x)_G
      $
      同时，$i$ 是线性的双射，$G(T) subset X times Y$ 是完备空间的闭子集，当然也是完备的，因此 $i$ 构成赋范空间的同构，当然就有图模完备。
    ]
    #theorem[Banach-Steinhaus / Uniform boundedness][
      设 $T_n in L(X, Y)$，$X$ 是 Banach 空间，若：
      $
        forall x in X, sup_n norm(T_n x) < +infinity
      $
      则：
      $
        sup_n norm(T_n) < +infinity
      $
    ]<uniform-boundedness>
    #proof[
      - 一种证明是直接使用 BCT，考虑：
        $
          X_n = {x in X | norm(T_k x) <= n, forall k}
        $
        可以证明 $X_n$ 是闭的（连续性），设：
        $
          X = Union_(k = 1)^(+infinity) X_k
        $
        由 BCT，可设：
        $
          B(x_0, delta) subset X_(k_0)
        $
        因此若设 $norm(x) = 1$ 就有：
        $
          norm(T_n (x_0 + delta/2 x)) <= k_0, forall n
        $
        继而：
        $
          norm(T_n (delta/2 x)) <= k_0 + sup_n norm(T_n (x_0)), forall n
        $
        由 $x$ 的任意性立刻得到结论
      - 另一种证明是使用等价范数定理：在 $X$ 上定义额外的范数：
        $
          norm(x)_2 = norm(x) + sup_n norm(T_n x)
        $
        显然新范数更强。如果证明了完备性，等价范数定理给出两个范数等价，因此就有：
        $
          norm(x) + sup_n norm(T_n x) <= M norm(x)
        $
        因此只要证明完备性。任取新范数的柯西列，也就是：
        $
          norm(x_n - x_m) + sup_k norm(T_k (x_n - x_m)) < epsilon 
        $
        显然在原范数下是柯西的，因此在原范数下有极限 $x_0$，而新范数下，注意到有：
        $
          norm(T_k (x_n - x_m)) < epsilon, forall k
        $
        令 $m -> +infinity$ 就是：
        $
          norm(T_k (x_n - x_0)) <= epsilon, forall k
        $
        因此在新范数下当然也以 $x_0$ 为极限。
    ]
    #theorem[Banach-Steinhaus][
      设 $X, Y$ 是 Banach 空间，$T_n in L(X, Y)$，以下说法等价：
      + $forall x, T_n x$ 收敛
      + $sup_n norm(T_n) < +infinity$ 并且 $T_n x$ 对于某个稠密子集上的 $x$ 收敛
      + $sup_n norm(T_n) < +infinity$ 并且存在 $T in L(X, Y)$ 使得：
        $
          T_n x -> T x, forall x\
          norm(T) <= lim inf norm(T_n)
        $
      事实上，$1 <=> 3$ 只需要 $Y$ 的完备性，$2 <=> 3$ 只需要 $X$ 的完备性
    ]<Banach-Steinhaus>
    #proof[
      - $3 => 1, 2$ 是平凡的
      - $1 => 3$：由 @uniform-boundedness 就有 $sup norm(T_n) < +infinity$，记 $T$ 是 $T_n$ 的极限算子，不难证明它是线性的，同时：
        $
          norm(T x) &= lim_(n -> +infinity) norm(T_n x) \
          &= liminf_(n -> +infinity) norm(T_n x) \
          &<= liminf_(n -> +infinity) norm(T_n) norm(x)
        $
        这就证明了结论
      - $2 => 1$：任取 $x in X$，往证 $T_n x$ 是柯西的。事实上，有：
        $
          norm(T_n x - T_m x) <= norm((T_n - T_m) (x - x')) + norm(T_n x' - T_m x')\
          <= norm((T_n - T_m)) norm(x - x') + norm(T_n x' - T_m x')\
        $
        其中 $x'$ 是任何属于 $M$ 的点。由稠密性，$x - x'$ 任意小，因此上式当 $n, m$ 充分大时趋于零，证毕。
    ]
    #remark[][
      该定理还有另一种表述：
      
      设 $A_n, A in L(X, Y)$，则 $A_n x -< A x, forall x$ 当且仅当 存在稠子集 $M$ 使得 $sup norm(A_n) < +infinity$ 并且 $A_n x -> A x, forall x in M$

      证明和上面是类似的，不过这里不需要 $Y$ 的完备性，只需要 $X$ 的完备性。
    ]
    #remark[][
      $X$ 上仍然可能找到不等价的范数，使得两个范数都是完备的。这个例子并不好构造。取 $X = l^1$，第一个范数就是 $l^1$ 范数；对于第二个，有如下事实：
      #lemma[][
        $l^1$ 空间的 Hamel 基与 $l^infinity$ 空间的 Hamel 基是等势的
      ]
      #proof[
        - $x : l^1 arrowb x : l^infinity$ 是线性的单射
        - $(x_i) : l^1 arrowb (x_i/i^2) : l^infinity$ 也是线性的单射
      ]
      如此，就有基之间的双射，延拓到向量空间的同构，使用该同构将 $l^infinity$ 范数迁移过来（由于 $l^infinity$ 是完备的，该范数下的空间等距同构于 $l^infinity$，因此当然完备） ，此外，可以证明 $l^1$ 有可数稠子集（取所有位置都是有理数即可），但 $l^infinity$ 没有（任何两个 $0, 1$ 列的距离都是 $1$，但 $0, 1$ 列有 $alef^1$ 个），因此两个空间的拓扑不同，范数当然不可能等价。
      
      这个例子也提供了一个无界线性算子，但它的 $ker = {0}$ 是闭的。
    ]
    #remark[][
      从非完备空间出发，可能得到无界的闭算子。例如取 $X = C^1[0, 1], Y = C[0, 1] $，求导算子就是无界的：
      $
        norm(x^n) = 1\
        norm(T x^n) = norm(n x^(n - 1)) = n\
        norm(T x^n) = n norm(x^n) 
      $
      因此无界，但是其图像为：
      $
        (f, f')
      $
      假设 $(f_n, f'_n) -> (g, h)$，这里都收敛对应一致收敛，数学分析的结论表明此时一定有 $h = g'$，因此 $(g, h) in G(T)$
    ]
    #theorem[][
      设 $X$ 是 Banach 空间，$X_1, X_2$ 是闭子空间，且：
      $
        X = X_1 directSum X_2
      $
      则 $norm(x_1) + norm(x_2) <= c norm(x_1 + x_2)$
    ]
    #proof[
      由条件，在 $X$ 上可以使用 $norm(x_1) + norm(x_2)$ 作为另一个完备的范数（乘积范数），且：
      $
        norm(x_1 + x_2) <= norm(x_1) + norm(x_2)
      $
      由等价范数定理，两个范数等价，就有：
      $
        norm(x_1) + norm(x_2) <= c norm(x_1 + x_2)
      $
    ]
    #corollary[][
      设 $X = X_1 directSum X_2$，则 $X -> X_1, X -> X_2$ 的投影算子是有界的。
    ]
    #theorem[Helly-Toeplitz][
      设 $X$ 是 Hibert 空间，$T : H -> H$ 线性且：
      $
        inner(T x, y) = inner(x, T y), forall x, y in H
      $
      则 $T$ 是有界线性算子
    ]
    #proof[
      只需证明 $T$ 是闭算子，设 $(x_n, T x_n) -> (a, b)$，则：
      $
        inner(b - T a, z) 
        &= inner(b, z) - inner(T a, z)\
        &= inner(b, z) - inner(a, T z)\
        &= lim_(n -> +infinity) inner(T x_n, z) - inner(x_n, T z)\
        &= 0
      $
      因此 $b - T a = 0$，证毕
    ]
    #theorem[Douglas Factorization][
      设 $X, Y, Z$ 是 Banach 空间，$A in L(X, Y), B in L(Z, Y)$ 且 $A$ 是单射，则以下说法等价：
      - $im B subset im A$
      - 
        #diagram(cell-size: 15mm, $
          X edge(A, "hook->")  & Y\
          Z edge("u", exists T, "-->") edge("ur", B, ->)
        $)
        其中 $T in L(X, Y)$
    ]
    #proof[
      $2 => 1$ 是平凡的，对于 $1 => 2$，考虑：

      #align(center)[#diagram(
        $
          X edge(A, <->) &im A  edge(i, ->>) &Y \
          Z edge("ur", exists B', "-->") edge("urr", B, ->) edge("u", Inv(A) B', "->", label-side: #left)
        $
      )]

      只需证明 $Inv(A) B$ 有界。利用闭算子定理，假设：
      $
        x_n -> x, Inv(A) B x_n -> y
      $
      则当然有 $B x_n -> A y$，但 $B x_n -> B x$，因此 $A y = B x, y = Inv(A) B x$，证毕
    ]
  == Banach-Steinhaus 定理应用：Fourier 级数
    熟知 ${sin n x, cos n x}$ 是 $L^2[-pi, pi]$ 的一组正交基，任取 $f$ 它的 Fourier 级数是：
    $
      1/(2 pi) integral_(-pi)^(pi) f(s) dif s \
      + sumi1inf(
        1/pi integral_(-pi)^(pi) f(s) cos(i s) dif s cos(i x) + 1/pi integral_(-pi)^(pi) f(s) sin(i s) dif s sin(i x)
      )
    $
    我们知道它在 $L^2$ 意义下收敛，但是是否能在 $L^infinity$ 意义下逼近？然而结论是，存在连续的函数 $f$ 使得它的三角级数在 $L^infinity$ 意义下不收敛。我们来证明这个结论。

    下面取范数都是 $L^+infinity$ 范数。设 $S_N : C[-pi, pi] -> C[-pi, pi]$ 是把函数变成其三角级数的前 $N$ 项算子，不难证明它是有界线性的，Banach-Steinhaus 定理给出如果 $forall f, S_N f -> f$，则 $sup_N norm(S_N) < +infinity$，接下来，我们做一些繁琐的计算：
    $
      S_N (f) (x) &= 1/pi integral_(-pi)^(pi) f(y) (1/2 + sumi1N(sin i x sin i y + cos i x cos i y)) dif y \
      &= 1/pi integral_(-pi)^(pi) f(y) (1/2 + sumi1N(cos (i(x - y)))) dif y\
      &= 1/pi integral_(-pi)^(pi) f(y) (sin (N + 1/2) (x - y))/(2 sin (x - y)/2 ) dif y\
      &= 1/pi integral_(-pi)^(pi) f(y) D_N (x - y) dif y\
    $ 
    因此：
    $
      abs(S_N (f) (x)) <= norm(f) 1/pi integral_(-pi)^(pi) abs(D_N (x - y)) dif y = norm(f) 1/pi integral_(-pi)^(pi) abs(D_N (y)) dif y\
    $
    并且有：
    $
      S_N f(0) = 1/pi integral_(-pi)^(pi) f(y) D_N (-y) dif y
    $
    设 $h = sgn D_N (y)$ 就有：
    $
      1/pi integral_(-pi)^(pi) h(y) D_N (-y) dif y = 1/pi integral_(-pi)^(pi) abs(D_N (y)) dif y
    $
    当然 $h$ 不是连续函数，但它可以被连续函数 $L^1$ 逼近，因此：
    $
      norm(S_N (f)) = 1/pi integral_(-pi)^(pi) abs(D_N (y)) dif y
    $
    只需要计算上式即可，有：
    $
      integral_(-pi)^(pi) abs(D_N (y)) dif y 
      &= integral_(-pi)^(pi) abs((sin (N + 1/2) z)/(2 sin z/2)) dif z\
      &>= C  integral_(-pi)^(pi) abs((sin (N + 1/2) z)/z) dif z\
      &>= C  integral_(-(N + 1/2) pi)^((N + 1/2) pi) abs((sin z)/z) dif z\
    $
    根据数学分析结论，$N$ 充分大时上式充分大。
  == The great theorems in linear functional analysis II(Hahn-Banach Thm)
    在有限维的 Banach 空间中，显然可以很容易的构造足够多（可分离）的线性泛函。对于无穷维的 Banach 空间，我们仍然希望讨论类似的事实，然而在无穷维空间中，我们还希望构造的线性泛函是有界/连续的，这带来了额外的麻烦。

    下面的定理告诉我们，如何将子空间的线性泛函延拓到全空间中：
    #theorem[Hahn-Banach for real vector space][
      设 $X$ 是 $RR$ 上的线性空间，$p : X -> RR$ 是 sublinear 的，也即：
      - $p(x + y) <= p(x) + p(y)$
      - $p(alpha x) = alpha p(x), forall alpha > 0$
      （有时也称这样的 $p$ 是 quasi-norm）\
      设 $X_0$ 是 $X$ 子空间，$l_0 : X_0 -> RR$ 是线性泛函，且：
      $
        l_0 (x) <= p(x), forall x in X_0
      $
      则存在 $l : X -> RR$ 是线性泛函，且：
      - $l|_(X_0) = l_0$
      - $l(x) <= p(x), forall x in X$
    ]<Hahn-Banach-Basic>
    #proof[
      不妨设 $X_0 != X$。我们的思路是先证明可以进行一维延拓，再利用 Zoun 引理。
      
      任取 $z in X - X_0$，设 $X_1 = span(X, z)$，我们来讨论是否存在满足要求的到 $X_1$ 上的延拓。注意到 $X_1 = X directSum span(z)$ 任取 $y in X_1$，可设：
      $
        y = x + lambda z
      $
      因此：
      $
        f(y) = f(x) + lambda f(z)
      $
      若 $f$ 就是满足要求的线性泛函，则：
      $
        f(y) = l_0 (x) + lambda f(z)
      $
      以及范数条件：
      $
        l_0 (x) + lambda f(z) <= p(x + lambda z)
      $
      意味着：
      - $lambda > 0$ 时:
        $
          f(z) <= (p(x + lambda z) - l_0 (x))/lambda
        $
      - $lambda < 0$ 时:
        $
          f(z) >= (p(x + lambda z) - l_0 (x))/lambda
        $
      断言：
      $
        sup_(x in X_0, lambda < 0) (p(x + lambda z) - l_0 (x))/lambda <= inf_(
      x in X_0, lambda > 0) (p(x + lambda z) - l_0 (x))/lambda
      $
      进而 $f(z)$ 是可以选出的。

      注意到：
      $
        (p(x + lambda z) - l_0 (x))/lambda = p(x/lambda + z) - l_0 (x/lambda) := p(y + z) - l_0(y) "when" lambda > 0
      $
      $
        (p(x + lambda z) - l_0 (x))/lambda = l_0 (x/(-lambda)) - p(x/(-lambda) - z) := l_0(w) - p(w - z) "when" lambda < 0
      $
      而条件保证了：
      $
        l_0 (y) + l_0 (w) = l_0 (y + w) <= p(y + w) <= p(y + z) + p(-z + w)\
        l_0(w) - p(w - z) <= p(y + z) - l_0 (y), forall w, y in X_0
      $
      因此断言是正确的。

      接下来，利用 Zoun 引理，定义：
      $
        cal(F) = {(X', f') | X_0 subset X' subset X, f' : X' -> RR with f'|_(X_0) = l_0, f'(x) <= p(x), forall x in X'}
      $
      定义偏序关系：
      $
        (X_1, f_1) <= (X_2, f_2) <=> X_1 subset X_2 and f_2|_(X_1) = f_1
      $
      对于全序子集 $X_(Lambda)$，定义：
      $
        Y = Union_(alpha in Lambda) X_alpha\
        f(x) = f_alpha (x) "if" x in X_alpha\ 
      $
      可以验证它确实是上界。Zoun's lemma 保证 $cal(F)$ 有极大元 $(X^*, f^*)$，而之前的步骤表明有限步的延拓总可以进行，因此 $X^*$ 一定就是 $X$，对应的 $f^*$ 就是我们要找的延拓，证毕。
    ]
    许多时候，我们就取上面的 $p$ 是 $X$ 上的范数。
    #remark[][
      回顾 @Hahn-Banach-Hilbert，当空间是 Hilbert 空间时，证明更具有构造性，并且有唯一性保证。一般来说，没有唯一性保证，例如 $X = C[0, 1], X_0 = {f in X | f(0) = f(1)}$，设 $l_0(f) = f(0), l_1(f) = f(1)$，不难验证 $l_0$ 和 $l_1$ 在 $X_0$ 上有相同的限制，且范数条件也成立。
    ]
    #theorem[Hahn-Banach for complex vector space][
      设 $X$ 是 $CC$ 上的线性空间，$p : X -> RR$ 是 semi-norm，也即满足：
      - $p(x + y) <= p(x) + p(y)$
      - $p(x) >= 0$
      - $p(alpha x) = norm(alpha) p(x), forall alpha in CC$
      设 $X_0$ 是 $X$ 子空间，$l_0 : X_0 -> CC$ 是线性泛函，且：
      $
        norm(l_0 (x)) <= p(x), forall x in X_0
      $
      则存在 $l : X -> CC$ 是线性泛函，且：
      - $l|_(X_0) = l_0$
      - $norm(l(x)) <= p(x), forall x in X$
    ]
    #proof[
      注意到复线性空间也是实线性空间，而 $l_0$ 的实部是实泛函，用上面的结论可以得到 $l_0$ 的实部的延拓。

      同时，事实上复的线性泛函可以被实部唯一确定。假设 $T$ 是线性泛函，则：
      $
        T (a + b i) = T a + i (T b)
      $
      其中 $a, b$ 都是实数，因此上式的值被 $T$ 的实部唯一决定了。只需要验证模的控制，注意到可设：
      $
        l(x) = e^(i theta) r\
        l(e^(-i theta) x) = r in RR => l(e^(-i theta) x) <= p(e^(-i theta) x) = p(x) => r <= p(x) => norm(l(x)) <= p(x)\
      $
    ]
    #corollary[Hahn-Banach in normed space][
      设 $X$ 是赋范空间，$X_0$ 是子空间，$f_0 in duelSpace(X_0)$，则存在 $f in duelSpace(X)$ 使得：
      - $f|_(X_0) = f_0$
      - $norm(f) = norm(f_0)$
    ]<Hahn-Banach-B>
    #proof[
      在之前的空间中取 $p(x) = norm(f_0) norm(x)$，利用之前的结论存在 $f$ 使得：
      - $f|_(X_0) = f_0$
      - $norm(f (x)) <= norm(f_0) norm(x) => norm(f) <= norm(f_0)$
      但另一方面，一定有：
      $
        norm(f (x)) >= sup_(x in X_0, x != 0) norm(f (x))/norm(x)  = norm(f_0)
      $
      因此就有：
      $
        norm(f) = norm(f_0)
      $
    ]
    #theorem[分离性][
      设 $X$ 是赋范空间，$X_0$ 是非空子空间，则任取 $x in X$，存在 $f in duelSpace(X)$ 使得 $norm(f) = 1, norm(f(x)) = norm(x)$
    ]<separation>
    #proof[
      在 $span(x)$ 上定义泛函 $f(lambda x) = lambda norm(x)$，显然 $norm(f) = 1$ ，利用 @Hahn-Banach-B 做延拓即可
    ]
    #corollary[][
      设 $X$ 是赋范空间，对于任意的 $x != y in X$ 存在有界泛函 $f$ 使得 $f(x) != f(y)$
    ]
    #proof[
      对 $x - y$ 利用上面的结论，得到 $f(x - y) = norm(x - y) != 0 => f(x) != f(y)$
    ]
    #corollary[Characterization norm][
      设 $X$ 是赋范空间，则：
      $
        norm(x) = sup_(f in duelSpace(X), norm(f) = 1) norm(f(x))
      $
    ]
    #proof[
      显然有：
      $
        norm(f(x)) <= norm(f) norm(x) = norm(x)
      $
      而取等由 @separation 保证。
    ]
    #lemma[Vanishing functional][
      设 $X$ 是赋范空间，$X_0$ 是闭子空间，则任取 $z in.not X_0$，则存在 $f in duelSpace(X)$ 使得：
      - $f|_(X_0) = 0$
      - $norm(f) = 1$
      - $f(z) = dist(z, X_0)$
    ]
    #proof[
      设 $X_1 = span(z, X_1) = span(z) directSum X_1$，定义：
      $
        f_1 (x + lambda z) = lambda dist(z, X_0)\
      $
      不难验证：
      - $f_1|_(X_0) = 0$
      - $f_1 (z) = dist(z, X_0)$
      - $norm(f_1) = sup_(x in X_0, lambda) norm(f_1(x + lambda z))/norm(x + lambda z) = sup_(x in X_0, lambda) (lambda dist(z, X_0))/norm(x + lambda z) = sup_(x in X_0, lambda) (dist(z, X_0))/norm(x/lambda + z) = (dist(z, X_0))/(inf_(x in X_0, lambda) norm(x/lambda + z))\
      = (dist(z, X_0))/(inf_(x in X_0) norm(x + z)) = 1
      $
      利用 @Hahn-Banach-B 做延拓即可。
    ]
    如果在 Hilbert 空间中，上面的函数就是在 $orthogonalCom(X_0)$ 上的投影。
    #corollary[][
      设 $X$ 是赋范空间，$Y$ 是子空间，则 $closure(Y) = X$ 当且仅当 $forall f in duelSpace(X), f|_Y = 0 <=> f = 0$
    ]
    #proof[
      - 若 $closure(Y) = X$，后面的性质显然成立（用连续性即可）
      - 若后面的性质成立，假设 $z in.not closure(Y)$，前面的引理给出泛函 $f$ 在 $Y$ 上为零，在 $z$ 上不为零，矛盾！
    ]
    有时，我们希望讨论延拓的唯一性，当然这并不容易
    #theorem[Taylor-Foguel][
      设 $X$ 是赋范空间，则：
      #align(center)[任何从子空间到全空间的保范延拓是唯一的]
      当且仅当：
      #align(center)[$duelSpace(X)$ 是严格凸的]

      其中严格凸的含义是 $norm(x) = norm(y) = 1 and x != y => norm((x + y)/2) < 1$
    ]
    #proof[
      一方面，假如严格凸成立，设 $l_1, l_2$  是 $X_0$ 上 $l_0$ 的延拓，无妨设 $l_0$ 范数为 $1$，条件给出：
      $
        norm((l_1 + l_2)/2) < 1
      $
      然而，不难验证 $(l_1 + l_2)/2$ 也是 $l_0$ 的延拓，就有：
      $
        norm((l_1 + l_2)/2) >= norm(l_0) = 1
      $
      矛盾！

      另一方面，假设 $norm(l_1) = norm(l_2) = 1, l_1 != l_2$，考虑：
      $
        X_0 = ker (l_1 - l_2)
      $
      由条件，它不是全空间，且是闭子空间。在 $X_0$ 上定义 $l_0 (x) = l_1 (x)$，则有 $norm(l_0) <= norm(l_1)$，并且不可能 $norm(l_0) = 1$，因为 $l_1, l_2$ 都是 $l_0$ 的延拓，由条件不可能都是保范延拓，因此不能有 $norm(l_0) = 1$

      #lemma[][
        $l$ 是 $l_0$ 的延拓当且仅当 $l = lambda l_1 + (1 - lambda) l_2$
      ]
      #proof[
        注意到:
        $
          X = (ker (f_1 - f_2)) directSum span(x_0)
        $
        显然可设：
        $
          l(x_0) = lambda l_1 (x_0) + (1 - lambda) l_2 (x_0)
        $
        而在 $ker (f_1 - f_2)$ 当然也成立上式，因此就有：
        $
          l(x) = lambda l_1 (x) + (1 - lambda) l_2 (x), forall x in X\
        $
      ]
      简单期间，下面假设 $KK = RR$。若假设 $l_0$ 保距延拓 $l$ 得到现在就有 $l, l_1, l_2$ 三点共线。同时，注意到：
      $
        norm(lambda a + (1 - lambda) b) <= lambda norm(a) + (1 - lambda) norm(b)\
      $
      可以断言 $l$ 一定位于 $l_1, l_2$ 之间（否则与范数条件矛盾），换言之：
      $
        l = lambda l_1 + (1 - lambda) l_2, 0 < lambda < 1
      $
      接下来，无妨假设 $(l_1 + l_2)/2 in (l_1, l]$，立刻就有：
      $
        norm(l_1 + l_2)/2) <= theta norm(l_1) + (1 - theta) norm(l_2) < 1
      $

      对于 $K = CC$ 需要采用其他方法证明：假设 $norm((x + y)/2) = 1$，由 Hahn-Banach 定理的推论，构造线性泛函 $f$ 使得 $norm(f) = 1, f((x + y)/2) = 1$，进而：
      $
        norm(f x) <= norm(f) norm(x) = 1\
        norm(f y) <= norm(f) norm(y) = 1\
        1 = norm((f x)/2 + (f y)/2) <= (norm(f x) + norm(f y))/2 = 1
      $
      因此不等式全部取等，同时由于 $CC$ 是严格凸的，若 $f x != f y$ 应该有 $norm((f x)/2 + (f y)/2) < 1$，进而只能有 $f x = f y = 1$，因此：
      $
        f(lambda x + (1 - lambda) y) = lambda f x + (1 - lambda) f y = 1
      $
      就有：
      $
        1 = norm(f(lambda x + (1 - lambda) y)) <= norm(f) norm(lambda x + (1 - lambda) y) < 1
      $
      矛盾！
    ]
    上面都是从分析的角度来讨论 Hahn-Banach 定理，它在几何上也有重要的意义。
    #lemma[][
      设 $I$ 是一族凸集，则 $Inter I$ 也是凸集
    ]
    #definition[凸包/Convex hull][
      设 $A subset X$，记 $A$ 的凸包是所有包含 $A$ 的凸集的交集。事实上，有：
      $
        convexHull(A) = {sum_(i=1)^n lambda_i a_i mid(|)  a_i in A, lambda_i >= 0, sum_(i=1)^n lambda_i = 1}
      $
    ]
    #proposition[][
      设 $X$ 是赋范空间，$A$ 是凸的，则：
      - $A^o, closure(A)$ 都是凸的
      - $closure(convexHull(A)) = Inter_(B supset A, B "闭且凸") B$
    ]
    #proof[
      仅有 $A^o$ 的证明比较复杂：设 $x, y in A^o$，设 $B(x, delta), B(y, delta) subset A$，可以证明 $B(t x + (1 - t) y, delta) subset A, forall t in [0, 1]$，进而结论显然
    ]
    #definition[Minkowski funtional][
      设 $X$ 是赋范空间，$C$ 是凸的且 $0 in C$，定义：
      $
        funcDef(p, X, [0, +infinity], x, inf {lambda | lambda > 0, x/lambda in C})
      $
    ]
    #lemma[][
      + $p(0) = 0$
      + $p(lambda x) = lambda p(x), forall lambda > 0$
      + $forall lambda > p(x), x/lambda in C$
      + $p(x + y) <= p(x) + p(y)$
      + $x in C^0 => p(x) < 1$
      + 若 $C$ 是闭的，则 $C = Inv(p)([0, 1])$
      + 若 $C$ 是开的，则 $C = Inv(p)([0, 1))$
      + 若 $0$ 是内点，则存在 $M$ 使得 $p(x) <= M norm(x)$
      + 若 $C$ 是有界的，则 $p(x) = 0 <=> x = 0$，事实上有存在 $delta > 0$，$p(x) >= delta norm(x)$
    ]
    #proof[
      + 显然
      + 显然
      + 任取一列 $lambda_n$ 使得 $lambda_n < lambda, lambda_n -> p(x), x / lambda_n in C$，我们有：
        $
          x/lambda = lambda_n/lambda x/lambda_n + (1 - lambda_n/lambda) 0
        $
        而 $0 < lambda_n/lambda < 1, x/lambda_n in C, 0 in C$，继而 $x/lambda in C$，证毕
      + 注意到：
        $
          (x + y)/(lambda_1 + lambda_2) = lambda_1/(lambda_1 + lambda_2) x/lambda_1 + (1 - lambda_1/(lambda_1 + lambda_2)) y/(lambda_2)\
        $
        显然，若设 $x/lambda_1 in C, y/lambda_2 in C$，就有：
        $
          (x + y)/(lambda_1 + lambda_2) in C
        $
        表明：
        $
          lambda_1 + lambda_2 >= p(x + y)\
        $
        对 $lambda_1, lambda_2$  取下确界即由：
        $
          p(x + y) <= p(x) + p(y)
        $
      + 显然
      + 不难证明若 $C$ 是闭的则：
        $
          x/p(x) in C
        $
        因此 $x in C <=> p(x) <= 1$
      + 一方面已经证明 $C subset Inv(f)([0, 1))$，另一方面设 $x/lambda in C, lambda < 1$，则前面的结论表明：
        $
          x/1 = x in C
        $
      + 显然
      + 显然
    ]
    #definition[][
      当 $K = RR$ 时，称 $C$ 是对称的，如果：
      $
        x in C <=> -x in C
      $
      当 $K = CC$ 时，称 $C$ 是平衡的，如果：
      $
        forall norm(alpha) = 1, alpha x in C <=> x in C
      $
    ]
    #lemma[][
      设 $C$ 是对称的/平衡的，就有：
      $
        p(alpha x) = norm(alpha) p(x), forall alpha in K, x in X
      $
    ]
    #definition[超平面/Hyper plane][
      对于任意 $f != 0 in duelSpace(X), r in RR$，称：
      $
        H_f^r = Inv(f)(r) 
      $
      为一个超平面。同时，将超平面的两侧定义为：
      $
        Inv(f)((r, +infinity))\
        Inv(f)((-infinity, r))\
      $
      （取 $[r, +infinity)$ 也可）
    ]
    #definition[可分离][
      称 $A, B in X$ 是可被超平面分离的，如果存在 $f != 0 in duelSpace(X)$ 使得：
      $
        exists r in RR, Re f(A) <= r <= Re f(B)
      $
    ]
    #theorem[][
      设 $X$ 是 $RR$ 上的赋范空间，$A, B$ 是两个非空凸集：
      - 若 $A^o != emptyset, A inter B = emptyset$，则 $A, B$ 可被超平面分离
      - 若 $A$ 是闭的，$B$ 是紧的，则存在 $r, delta$ 使得：
        $
          f(A) <= r - delta < r + delta <= f(B)
        $
    ]
    #proof[
      无妨设 $0$ 是 $A$ 的内点（否则平移即可）
      #lemmaLinear[][
        设 $y_0 in.not A$，则 $y_0$ 和 $A$ 可被超平面分离
      ]
      #proof[
        设 $p$ 是关于 $A$ 的 Minkowski 泛函，则 $p(y_0) >= 1$ 且由前面的性质，$p$ 满足 @Hahn-Banach-Basic 中的控制函数的要求。在 $span(y_0)$ 上可以定义泛函使得 $l_0 (y_0) = 1$，可以验证 $p(y) >= l(y)$， @Hahn-Banach-Basic 给出 $l_0$ 的延拓 $l$，并且：
        $
          l(x) <= p(x)
        $
        前面的性质表明 $p(x) <= M norm(x)$，因此 $l(x) <= M norm(x), - l(x) = l(- x) <= M norm(x)$，进而 $l in duelSpace(X)$
        显然 $l(y_0) = 1$，而 $l(A) <= p(A) <= 1$，因此：
        $
          l(A) <= 1 <= l(y_0)
        $
        证毕。
      ]
      一般的，显然 $A - B$ （集合元素做差）有内点 $x_0$ 且 $0 in.not A - B$，令：
      $
        C = A - B - {x_0}
      $
      则 $-x_0 in.not C, 0$ 是 $C$ 的内点，立刻有存在 $f in duelSpace(X)$ 使得：
      $
        f(C) <= r <= f(-x_0)\
        f(A) - f(B) - f(x_0) <= r <= -f(x_0)\
        f(A) - f(B) <= r + f(x_0) <= 0
      $
      这就表明：
      $
        sup f(A) <= inf f(B)
      $
      取 $r in [sup f(A), inf f(B)]$ 立刻有：
      $
        f(A) <= r <= f(B)
      $
      因此第一个结论成立。

      对于第二个结论，熟知可以定义：
      $
        dist(x, A)
      $
      并且 $dist(x, A) = 0 <=> x in A$，熟知 $dist(x, A)$ 在紧集 $B$ 上有最小值 $delta$，必须有 $delta > 0$. 定义：
      $
        A' = {x in X | dist(x, A') <= delta/3}\
        B' = {x in X | dist(x, B') <= delta/3}\
      $
      可以证明 $A', B'$ 都是凸的且不交，因此可以找到 $f, r$ 使得：
      $
        f(A') <= r <= f(B')
      $
      任取 $w, w'$ 使得 $norm(w) <= 1, norm(w') <= 1$，就有：
      $
        f(A + w/(delta/3)) <= r <= f(B + w'/(delta/3))\
        f(A) + 3/delta f(w) <= r <= f(B) + 3/delta f(w')\
      $
      由 $w, w'$ 的任意性就有：
      $
        f(A) + 3/delta norm(f) <= r <= f(B) - 3/delta norm(f)
      $
      证毕
    ]
    #corollary[][
      设 $E$ 是凸的闭集，则任取 $x_0 in.not E$，存在 $f, r$ 使得：
      $
        f(E) < r < f(x_0)
      $
    ]
    #proof[
      显然 ${x_0}$ 是紧的凸集，因此显然。
    ]
  == 对偶空间
    #theorem[][
      设 $X$ 是赋范空间，则 $duelSpace(X)$ 是 Banach 空间
    ]
    回顾 Hibert 空间的情形，对偶空间与原空间是同构的。对于一般的赋范空间，$duelSpace(X)$ 和 $X$ 之间的关系就没有那么简单了。然而，在某些特例下仍然有这样好的性质：
    #theorem[][
      $duelSpace(l^p) = l^q, forall p in [1, +infinity), 1/p + 1/q = 1$
    ]
    #proof[
      先设 $p > 1$，任取 $y in l^q$，定义:
      $
        f_y (x) = sumi0inf(x_i y_i)\
      $
      Holder 不等式（及取等条件）给出：
      $
        norm(f_y) = norm(y)_q
      $
      取：
      $
        T := y arrowb f_y\
      $
      则有 $norm(T) = 1, T$ 是单射，同时对于任何 $f in duelSpace(l^p)$，不难验证：
      $
        f = T (i arrowb f(e_i))\
        i arrowb f(e_i) in l^q
      $

      对于 $p = 1$ 情形，证明是类似的，只需要一些小修改
    ]
    #remark[][
      当 $p = infinity$ 时，上面的 $T$ 仍然可以定义，性质也是类似的，但并不是满射
    ]
    #theorem[][
      设：
      $
        C_0 = {x in l^infinity | limn(x_n) = 0}
      $
      则 $duelSpace(C_0) = l^1$
    ]
    #proof[
      事实上，之前定义的 $T$ 的值域就是 $C_0$，这是因为任取 $f in duelSpace(C_0)$，总有：
      $
        f = T(i arrowb f(e_i))\
      $
      只需要验证 $i arrow_C_0b f(e_i) in l^1$，注意到：
      $
        sumi0M(abs(y_i)) = sumi0M(y_i sgn(y_i)) = 
      $
    ]
    #corollary[][
      上面诱导了映射 $l^1 -> duelSpace(l^infinity)$，这个映射不是满射
    ]
    #proof[
      前面证明了 $duelSpace(C_0) eqv l_1$，使用 Hahn-Banach 定理，可以构造泛函 $f != 0$ 使得 $f|_C_0 = 0$，使用该 $f$ 即产生矛盾
    ]
    #theorem[][
      $duelSpace(L^p) = L^q, forall p in [1, +infinity)$
    ]
    #proof[
      思路类似，但涉及一些实变的知识，在此略过。
    ]
    #theorem[][
      给定测度空间 $L^p (X, Omega, mu)$，则：
      $
        duelSpace(L^p (X, Omega, mu)) = L^q (X, Omega, mu), 1/p + 1/q = 1, p in (1. +infinity)
      $
    ]
    #proof[
      略
    ]
    #remark[][
      $L^infinity$ 空间的对偶空间会变得比较复杂。事实上，可以证明 $L^infinity (X, Omega, mu)$ 的对偶空间是所有有限可加的，绝对连续的（将零测集映为零测集）的测度所构成的集合。
    ]
  == 自反空间
    #definition[bi-duel space][
      设 $X$ 是赋范空间，称 $duelSpace(duelSpace(X))$ 称为 $X$ 的 bi-duel space（第二共轭空间）
    ]
    #lemma[][
      定义典范的映射：
      $
        funcDef(tau, X, duelSpace(duelSpace(X)), x, (f arrowb f x))
      $
      则：
      - $tau$ 是线性的单射
      - $norm(tau(x)) = x$
    ]
    #proof[
      - Hahn-Banach 定理的分离性给出单射
      - Hahn-Banach 定理的推论
    ]
    #definition[][
      设 $X$ 是赋范空间，称 $X$ 是自反空间，如果 $tau$ 是满射（此时 $tau$ 是保距双射，显然 $X$ 是 Banach 空间）
    ]
    #remark[][
      存在一个空间 $X$，使得 $duelSpace(duelSpace(X))$ 与 $X$ 同构，但并不是通过 $tau$ 同构
    ]
    #example[][
      - Hibert 空间是自反空间
      - $l^p, L^p$ 对于 $p in (1, +infinity)$ 都是自反的
    ]
    #definition[][
      记：
      $
        inner(f, x) -> f x
      $
      也即 $inner(-, -)$ 是 $duelSpace(X) times X -> KK$ 的双线性映射
    ]
    #theorem[][
      设 $X$ 是 Banach 空间，则：
      - $X$ 是自反空间 当且仅当 $duelSpace(X)$ 也是
      - 若 $X$ 是自反空间，$Y$ 是闭子空间，则 $Y, X quo Y$ 都是自反空间
    ]
    #proof[
      - 先假设 $X$ 是自反空间，只需任取 $z in duelSpace(duelSpace(duelSpace(X)))$，将其拉回到 $duelSpace(X)$ 上。考虑：
        $
          z compose (tau : X -> duelSpace(duelSpace(X))) : X -> K
        $
        不难验证它是有界线性泛函，只需证明：
        $
          tau (z compose tau) = z\
          inner(tau (z compose tau), x) = inner(z, x)\
          inner(x, z compose tau) = inner(z, x)\
          inner(tau (Inv(tau) x), z compose tau) = inner(z, x)\
          inner(z compose tau, Inv(tau) x) = inner(z, x)\
          inner(z, tau (Inv(tau) x)) = inner(z, x)\
        $
        上式显然成立。

        再考虑 $duelSpace(X)$ 是自反空间，如果 $tau(X) != duelSpace(duelSpace(X))$，则利用 Hahn-Banach 定理，可以找到 $z in duelSpace(duelSpace(duelSpace(X)))$ 使得 $z != 0, z|_tau(X) = 0$，利用 $duelSpace(X)$ 的自反性可设：
          $
            tau(y : duelSpace(X)) = z
          $
          则任给 $x in X$，有：
          $
            inner(y, x) = inner(tau(x), y) = inner(tau(y), tau(x)) = inner(z, tau(x)) = 0\
          $
          换言之，$y = 0 => z = 0$，矛盾！
      - 首先证明 $Y$ 是自反的。显然有 $duelSpace(duelSpace(Y)) subset duelSpace(duelSpace(X))$，任取 $z in duelSpace(duelSpace(Y))$，则当然有 $Inv(tau)(z) : X$，只需证明 $Inv(tau)(z) : Y$，如若不然，利用 Hahn-Banach 定理，可以找到 $f : duelSpace(X), f(Inv(tau) (z)) != 0, f |_Y = 0$，将有：
        $
          inner(f, Inv(tau) (z)) = inner(z, f)  = 0
        $
        矛盾！

        再证明 $X quo Y$ 是自反的，注意到有典范映射 $pi : X -> X quo Y$，定义：
        $
          orthogonalCom(Y) = {f : duelSpace(X) | f |_Y = 0}\
          i : Y -> X
        $
        则显然 $orthogonalCom(Y) = ker duel(i)$，我们有：
        $
          ker duel(i) eqv^duel(pi) duelSpace(X quo im i) 
        $
        就得到 $duel(Inv(duel(pi))) : duelSpace(duelSpace((X quo Y))) -> duelSpace(orthogonalCom(Y))$，利用 Hahn-Banach 定理得到 $duelSpace(orthogonalCom(Y)) -> duelSpace(duelSpace(X))$，最后得到：
        $
          duelSpace(duelSpace((X quo Y))) ->^duel(Inv(duel(pi))) duelSpace(orthogonalCom(Y)) ->^l duelSpace(duelSpace(X)) ->^Inv(tau) X ->^pi X quo Y\
        $
        以及：
        $
          inner(tau compose pi compose Inv(tau) compose l compose duel(Inv(duel(pi))) a, y : duel(X quo Y)) = inner(y, pi compose Inv(tau) compose l compose duel(Inv(duel(pi))) a)\
          = inner(y compose pi, Inv(tau) compose l compose duel(Inv(duel(pi))) a)\
          = inner(l compose duel(Inv(duel(pi))) a, y compose pi)\
        $
    ]
  == 可分空间
    #theorem[][
      设 $X$ 是赋范空间：
      - 若 $duelSpace(X)$ 是可分的，则 $X$ 是可分的
      - 若 $X$ 是可分且自反的，则 $duelSpace(X)$ 是可分的
    ]
    #proof[
      - 任取 $f_n$ 是 $duelSpace(X)$ 的稠密子集，则可取得 $x_n : X, norm(x_n) = 1, norm(f_n x_n) > 1/2 norm(f_n)$，设 $Q$ 是 $KK$ 的可数稠密子集，考虑：
        $
          Omega = directSum_n Q x_n
        $
        断言它是可数稠子集，否则由 Hahn-Banach 定理，可设 $f != 0, f |_(closure(Omega)) = 0$，由条件，设 $f_(n_k) -> f$，则：
        $
          inner(f_(n_k) - f, x_(n_k)) = inner(f_(n_k), x_(n_k)) >= 1/2 norm(f_(n_k))\
        $
        但另一方面：
        $
          inner(f_(n_k) - f, x_(n_k)) <= norm(f_(n_k) - f) -> 0
        $
        这意味着 $f_(n_k) -> 0$，因此 $f = 0$，矛盾！
      - 条件给出 $duelSpace(duelSpace(X))$ 可分，继而由上面的结论 $duelSpace(X)$ 可分
    ]
    #example[][
      注意到 $l^1$ 是可分的，$l^+infinity$ 不是可分的，因此不可能有 $duelSpace(l^infinity) = l^1$，进而 $C_0, l^1, l^infinity$ 都不是自反的。
    ]
    #example[][
        设 $M$ 是无穷的紧集，则 $C(M)$ 不是自反的。以 $X = C[0, 1]$ 为例，考虑：
        $
          X_0 = {f in X | f(1/n) = 0, forall n in NN^+}
        $
        显然 $X_0$ 是闭子空间，设：
        $
          C = {l in l^infinity | lim l exists}
        $
        构造映射：
        $
          funcDef(pi, X quo X_0, C, f, (f(1/i)))
        $
        可以验证 $pi$ 是双射，但 $C$ 是 $C_0$ 的闭子集，因此 $C$ 不是自反的， $X quo X_0$ 也不是自反的，继而 $X$ 也不是自反的。这里的构造中，$1/n$ 的选择当然是可以推广的，一般来说只要取一个互不相等的柯西列即可。
    ]
  == 对偶算子
    #definition[][
      设 $A : L(X, Y)$，算子 $B : L(duelSpace(Y), duelSpace(X))$ 称为 $A$ 的对偶，如果：
      $
        inner(B y, x) = inner(y, A x), forall y in duelSpace(Y), x in duelSpace(X)
      $
    ]
    #theorem[][
      对偶算子是存在唯一的，且：
      $
        norm(duelSpace(A)) = norm(A)
      $
    ]
    #proof[
      事实上，定义式已经给出了存在性（除了范数条件）和唯一性，至于范数，有：
      $
        norm(duel(A)) = sup (norm(duel(A) y))/norm(y) = sup_(x, y) inner(duel(A) y, x)/(norm(x) norm(y)) = sup_(x, y) inner(y, A x)/(norm(x) norm(y)) 
      $
      由 Hahn-Banach 定理的推论，有：
      $
        norm(A x) = sup_y inner(y, A x)/norm(y)
      $
      因此：
      $
        sup_(x, y) inner(y, A x)/(norm(x) norm(y)) = sup_x norm(A x)/norm(x) = norm(A)
      $
      证毕
    ]
    #lemma[][
      - $duel(B compose A) = duel(A) duel(B)$
      - $duel(id) = id$
      - 有交换图表：
        #align(center, diagram(
          $
          X edge("d", ->, A) edge(->, tau) & duelSpace(duelSpace(X))  edge("d", ->, duel(duel(A)))\
          Y edge(->, tau) edge(->, tau) & duelSpace(duelSpace(Y))
          $
        ))
    ]
    #let leftOrthogonal(x) = $attach(#x, tl: orthogonal)$
    #definition[][
      定义：
      $leftOrthogonal(M) = {f in duelSpace(X) | inner(f, x) = 0, forall x in M}$\
      对于 $N subset duelSpace(X)$，定义：
      $
        orthogonalCom(N) = {x in X | inner(f, x) = 0, forall f in N}\
      $
    ]
    #lemma[][
      设 $T in L(X)$，则 $closure(im T) = orthogonalCom(ker(duel(T)))$
    ]<im-equal-orthogonalCom-ker-duel>
    #proof[
      任取 $T x in im T$，有：
      $
        forall f in ker(duel(T)), inner(f, T x) = inner(duel(T f), x) = 0
      $
      因此 $im T subset orthogonalCom(ker(duel(T))) => closure(im T) subset orthogonalCom(ker(duel(T)))$，假设它们不相等，设 $y in orthogonalCom(ker(duel(T)))- closure(im T)$，由 Hahn-Banach 定理，设 $f$ 满足 $f(y) != 0, f|_(closure(im T)) = 0$，因此：
      $
        0 = inner(f, T x) = inner(duel(T f), x)
      $
      这对任何 $x$ 都成立，因此 $f in ker duel(T) => inner(f, y) = 0$，矛盾！
    ]
    #lemma[][
      设 $A in L(X, Y)$，则 $A$ 可逆当且仅当 $duel(A)$ 可逆
    ]
    #proof[
      左推右显然成立，至于右推左，我们有 $duel(duel(T))$ 可逆，交换图表：
      #align(center, diagram(
          $
          X edge("d", ->, A) edge(->, tau) & duelSpace(duelSpace(X))  edge("d", ->, duel(duel(A)))\
          Y edge(->, tau) edge(->, tau) & duelSpace(duelSpace(Y))
          $
      ))
      给出 $A$ 是单射。只要证明 $A$ 是满射，根据 @im-equal-orthogonalCom-ker-duel 只要证明 $im  A$ 是闭的，这也直接由交换图表给出。
    ]
  == 弱/弱\*拓扑（Weak & Weak\* toplogy）
    在经典情形下，紧性/列紧性是非常好用的性质，然而在无穷维空间中，这么好的性质通常是不成立的。一个思想是，换用一个更粗的拓扑，这个做法需要一定时间的铺垫。我们在这里采用一种简便的方法，直接定义什么是新拓扑意义下的收敛。
    #definition[][
      设 $X$ 是赋范空间，称 $x_n$ 弱收敛于 $x$，如果任给 $f in duelSpace(X)$ 都有 $f x_n -> f x$，记作 $x_n weakConverge x$
    ]
    #lemma[][
      - 有穷维空间中，强收敛等价于弱收敛
      - 弱极限是唯一的
      - 在 Hibert 空间中，若 $x_n weakConverge x, norm(x_n) -> norm(x)$，则 $x_n -> x$
      - $x_n weakConverge x$ 当且仅当 $x_n$ 有界，且 $f x_n -> f x$ 对于 $f$ 属于某个稠密子集都成立。进一步，有 $norm(x) <= liminf f norm(x_n)$
    ]
    #proof[
      - 只需证明弱收敛保证强收敛，事实上取 $duel(e_i)$ 就有：
        $
          duel(e_i) (x_n) -> duel(e_i) x
        $
        换言之，$x_n$ 的每个分量都收敛于 $x$ 的这个分量，当然就有 $x_n -> x$
      - 熟知只要 $x != y$，就存在 $f$ 使得 $f x != f y$，取该 $f$ 即可得到矛盾
      - 注意到：
        $
          norm(x_n - x)^2 = norm(x_n)^2 + norm(x)^2 - inner(x_n, x) - inner(x, x_n)
        $
        注意到弱收敛保证 $inner(x_n, x) -> inner(x, x) = norm(x)^2$，因此显然上式趋于零
      - 取 $T_n = tau(x_n)$，利用 @Banach-Steinhaus 即可
    ]
    #lemma[Mazur][
      设 $x_n weakConverge x$，则任意 $epsilon > 0$，存在 $N$，以及 $lambda_i in [0, 1], sumi1N(lambda_i) = 1$ 使得：
      $
        norm(x - sumi1N(lambda_i x_i)) < epsilon
      $
    ]
    #proof[
      设 $S = {x_1, ..., x_n, ...}$，结论等价于：
      $
        x in closure(cov(S))
      $
      如若不然，则由 Hahn-Banach 定理的几何版本，就存在 $f$ 使得：
      $
        f(x) < a - delta < a + delta < f(y), forall y in closure(cov(S))
      $
      然而，由定义 $f(x) in closure(f(S))$，导致矛盾！
    ]
    #definition[][
      考虑 $duelSpace(X)$，我们有不同的收敛性：
      - $f_n -> f$
      - $f_n weakConverge f <=> forall z in duelSpace(duelSpace(X)), z f_n -> z f$
      还可以定义更弱的收敛：
      $
        f_n weakSConverge f := forall z in tau(X), z f_n -> z f
      $
      它也等价于：
      $
        forall x in X, f_n x -> f x
      $
      或者利用 @Banach-Steinhaus，等价于：
      $
        f_n x -> f x , forall x in "某个稠子集" and norm(f_n) "有界"
      $
    ]
    #definition[][
      考虑 $L(X, Y)$，我们也有不同的收敛性：
      - $T_n -> T$，也就是一致收敛
      - $T_n x -> T x, forall x$，通常会称强收敛，有时也记 $T_n -> x$
      - $z T_n x -> z T x, forall x in X, y in duelSpace(Y)$
    ]
    #example[][
      在 $X = l^2$ 中，令：
      $
        T x = (0, x_1, x_2, ...)\
        S x = (x_2, x_3, ...)\
        T_n = T^n, S_n = S^n
      $
      - 注意到 $norm(S_n x) -> 0 => forall x, S_n x -> 0$，也即 $S$ 强收敛到 $0$，但不难验证 $norm(S_n) = 1$，因此并不一致收敛
      - 注意到 $norm(T_n x) = norm(x)$，但：
        $
          abs(inner(y, T_n x)) = abs(sum_k y_(n + k) x_k) ->^("Cauthy-Schwarz") 0
        $
        因此 $T_n$ 弱收敛于零，但并不强收敛于零
    ]
    之前提到，引入收敛性是为了获得更好的紧性，下面是两个非常重要的定理，但它们的证明非常复杂，接下来只会证明简单的版本，完整证明可以参考 Salamon。
    #let weakS = [弱\*]
    #let weakCompact = [弱紧]
    #let weakSCompact = [弱\*紧]
    #theorem[Banach-Alaeslu][
      设 $X$ 是赋范数空间，则 $duelSpace(X)$ 中的单位球#weakSCompact
    ]<Banach-Alaeslu>
    #proof[
      我们只证明一种特殊情况：
      #align(center)[
        若 $X$ 可分，则 $duelSpace(X)$ 中的单位球弱\*列紧
      ]
      取 $x_n$ 是可数稠密集，$f_i : duelSpace(X) in B(0, 1)$
      - 首先：
        $
          f_n (x_1)
        $
        是有界的，因此有收敛子列，找出一个收敛子列
      - 重复该步骤不断构造，取对角线，即可得到在 $x_n$ 上收敛的子列，由 Banach-Steinhaus 就有该子列#weakS\收敛

    ]
    #theorem[][
      $X$ 自反当且仅当  $duelSpace(X)$ 中的单位球#weakCompact
    ]
    #proof[
      我们只证明左推右的单边情形，并且只证明列紧性。取 $x_n : duelSpace(X) in B(0, 1)$，设 $X_0 = closure(span(x_n))$，这是自反空间的闭子空间，因此 $X_0$ 也是自反的。同时，显然 $X_0$ 是可分的，因此 $duelSpace(duelSpace(X_0))$ 也是可分的，进而 $duelSpace(X_0)$ 是可分的。由前面的 @Banach-Alaeslu，我们就有 $duelSpace(duelSpace(X_0))$ 中的有界列#weakS\收敛，因此对于 ${x_n}$，可设 $forall f, tau(x_(n_k)) f -> tau(x) f$，也即 $forall f : duelSpace(X_0), f x_(n_k) -> f x$

      最后，对于任何 $f : duelSpace(duelSpace(X))$，只需要做限制得到 $duelSpace(X_0)$，不难证明有 $f x_(n_k) -> f x$，这就表明 $x_(n_k) weakConverge x$，证毕。 
    ]
    #example[][
      - 当 $X = L^2[0, 1]$，$f_n (x) = sin n x$，可以证明：
        - $f_n$ 没有极限
        - $f_n weakConverge 0$（就是 R-L 引理）
      - 当 $X = L^2(RR^n)$ 或者 $L^p (RR^n), f_n (x) = f(x - n)$，可以证明：
        - $f_n$ 保持范数，没有极限
        - $f_n weakConverge 0$，注意到可设：
          $
            inner(z, f_n) = integral_()^() g(x) f_n (x) dif x
          $
          假设 $f$ 有紧支集（一般的可以逼近），则 $n$ 充分大时上式分成 $f$ 较小和 $g$ 较小的两部分，因此趋于零
      - 当 $X = L^2(RR^n)$ 或者 $L^p (RR^n), f_n (x) = f(x/n) n^(-n/p)$，可以证明：
        - $f_n weakConverge 0$
    ]
  == 谱
    对于有限维空间上的自线性映射（方阵），我们有特征值、特征向量的概念。这个概念可以被推广到无穷维空间上。这里，我们只处理有界线性算子。
    #definition[特征值][
      设 $X$ 是 $CC$ 上的赋范空间，$A : L(X)$ 是有界线性算子，定义：
      $
        rho(A) = {lambda in CC | lambda I - A "可逆"}}\
      $
      称 $rho(A)$ 为预解集(resolvent set)，$sigma (A) = CC - rho(A)$ 称为谱（spectrum），更准确的，定义：
      $
        sigma_p (A) = {lambda in CC | lambda I - A "不是单射"}\
      $
      称为点谱（point spectrum），以及：
      $
        sigma_c (A) = {lambda in CC | lambda I - A "是单射，不是满射，但" closure(im (lambda I - A)) = X}\
      $
      称为连续谱（continuous spectrum），以及：
      $
        sigma_r (A) = {lambda in CC | lambda I - A "是单射，不是满射，且" closure(im (lambda I - A)) != X}\
      $
      称为剩余谱（residual spectrum）
    ]
    #remark[][
      - Banach 逆算子定理保证了，只要 $lambda I - A$ 可逆，其逆算子当然也是有界算子
      - 对于一大类算子，例如自伴算子，$sigma_r (A) = emptyset$，因此它被称为剩余谱
    ]
    #lemma[][
      在有限维空间中，$sigma(A) = sigma_p (A)$
    ]
    #proof[
      注意到 $X -> X$ 的单射就是满射，因此 $sigma_c (A) = sigma_r (A) = emptyset$
    ]
    #example[][
      - $X = C[0, 1], A f(t) = t f(t)$，计算 $sigma(A)$ 也即：  
        $
          (lambda I - A) f(t) = (lambda - t) f(t) 
        $
        如果 $lambda in.not [0, 1]$，就有：
        $
          f(t) = 1/(lambda - t) (lambda I - A) f(t)
        $
        继而 $lambda I - A$ 可逆，因此：
        $
          sigma(A) subset [0, 1]
        $
        另一方面，任取 $lambda in [0, 1]$，注意到若：
        $
          (lambda I - A) f(t) = (lambda - t) f(t) = 0\
        $
        由连续性可以证明 $f = 0$，因此算子 $lambda I - A$ 是单射。然而，任取 $g in im (lambda I - A)$，一定有 $g(lambda) = 0$，进而对于 $g in closure(im (lambda I - A))$ 也有 $g(lambda) = 0$，故：
        $
          sigma(A) = sigma_r (A) = [0, 1]
        $
      - 在 $L^2 [0, 1]$ 中讨论上述问题，大部分讨论是一样的，包括：
        $
          sigma(A) subset [0, 1]\
          sigma_p (A) = emptyset\
          forall g in im (lambda I - A), g(lambda) = 0\
        $
        然而任取 $g in L^2 [0, 1]$，定义：
        $
          g_n (t) = cases(
            0 "if" t in [lambda - 1/n, lambda + 1/n],
            g(t) "otherwise"
          )
        $
        可以验证 $g_n in im (lambda I - A)$，进而我们有：
        $
          X = closure(im (lambda I - A))\
          sigma(A) = sigma_c (A) = [0, 1]\
        $
      - $X = l^2, A x = (lambda_i x_i)$ 以及 $sup abs(lambda_i) < +infinity$，设 $Lambda = closure({lambda_i})$:
        - 对于 $lambda in.not Lambda$，可设 $abs(lambda - lambda_i) > d > 0$，进而：
          $
            1/(lambda - lambda_i) (A x) (i) = x (i)
          $
          因此 $lambda in rho(A)$，这表明 $sigma(A) subset Lambda$. 事实上，$lambda I - A$ 可逆当且仅当 $forall x in l^2, i arrowb 1/(lambda - lambda_i) x (i) in l^2$，因此就有 $CC - Lambda = rho(A), Lambda = sigma(A)$
        - 对于 $lambda in Lambda$：
          - 若 $lambda = lambda_i$，显然 $lambda in sigma_p (A)$，因此 $(lambda_i I - A) e_i = 0$
          - 否则，容易验证 $(lambda I - A) x = 0 => x = 0$，因此是单射

          进一步，设：
          $
            I_n = {i mid(|) abs(lambda_i - lambda) < 1/n}
          $
          任取 $y in l^2$，设：
          $
            y_n (j) = cases(
              0 "if" j in I_n,
              y(j) "otherwise"
            ) 
          $
          可以验证 $y_n in im (lambda I - A)$ 以及 $y_n -> y$，进而 $closure(im (lambda I - A)) = l^2$，因此 $sigma(A) = sigma_p (A) union sigma_c (A) = Lambda$，也即：
    ]
    #definition[][
      设 $lambda in rho(A)$，称：
      $
        R_lambda (A) = Inv(lambda I - A)
      $
      为 $A$ 的 resolvent
    ]
    #lemma[第一预解式恒等式][
      $
        R_lambda (A) - R_mu (A) = (mu - lambda) R_lambda (A) R_mu (A)
        = (mu - lambda) R_mu (A) R_lambda (A)\
      $
    ]
    #definition[全纯函数][
      设 $Omega$ 是 $CC$ 中开集，$f : Omega -> X$ 是连续的，定义：
      $
        f' (z) = lim_(lambda -> z) (f(lambda) - f(z))/(lambda - z)
      $
      若 $f' (z)$ 处处存在且连续，则称 $f$ 是全纯（holomorphic）的
    ]
    #theorem[][
      $R_lambda : rho(A) -> L(X)$ 是全纯的
    ]
    #proof[
      首先证明它是连续的。事实上，有：
      $
        norm(R_lambda (A) - R_lambda_0 (A)) = norm(lambda_0 - lambda) norm(R_lambda (A) R_lambda_0 (A))\
      $
      只要证明上式后项有界即可。注意到：
      $
        lambda I - A = (lambda_0 I - A) + (lambda - lambda_0) I = Inv(lambda_0 I - A) (I + ((lambda - lambda_0) I) R_lambda (A))\
        Inv(lambda I - A) = Inv(I + ((lambda - lambda_0) )I R_lambda (A))\
        = norm(sumi0inf((-1)^n (((lambda - lambda_0) I) R_lambda (A))^n))\
        <= sumi0inf((norm(lambda - lambda_0) norm(R_lambda (A)))^n)\
      $
      只要 $lambda - lambda_0$ 充分小，显然上式有界
      计算得：
      $
        (R_lambda (A) - R_lambda_0 (A))/(lambda - lambda_0) = - R_lambda (A) R_lambda_0 (A) -> - R_lambda_0 (A)^2\
      $
      这也表明导数也是连续的。
    ]
    #theorem[][
      $R_lambda$ 是有界的
    ]
    #proof[
      当 $abs(lambda) > 2 norm(A)$ 时：
      $
        R_lambda (A) = Inv(lambda I - A) = 1/lambda Inv(I - 1/lambda A)\
        norm(R_lambda (A)) <= 1/abs(lambda) norm(Inv(I - 1/lambda A)) = 1/abs(lambda) norm(sumi0inf(A^n/lambda^n))\
      $
      显然上式有界。而 $abs(lambda) <= 2 norm(A)$ 是紧集，连续函数在其上也有界。
    ]
    #theorem[Liouville][
      设 $f : CC -> X$ 是全纯的，且在 $CC$ 上有界，则 $f$ 是常函数
    ]
    #proof[
      注意到任取 $h in duelSpace(L(X))$，有：
      $
        g(x) = inner(h, f(x)) : CC -> CC
      $
      可以证明：
      - $g$ 是全纯的
      - $g$ 是有界的，因为 $norm(g(x)) <= norm(h) norm(f(x))$
      由复变函数的 Liouville 定理，$g$ 是常函数。为了导出矛盾，假设 $f$ 不是常函数，则可设 $f (x) != f(y)$，由 Hahn-Banach 定理的推论，存在有界泛函 $h$ 将 $f(x)$ 与 $f(y)$ 分开，此时 $g$ 不是常数，矛盾！
    ]
    #theorem[Cauthy-Hadamard][
      设 $X$ 是 Banach 空间，$A_k in X$：
      - 若 $limsup norm(A_n)^(1/n) = c < 1$ 则 $sumk0inf(A_k)$ 收敛
      - 若 $limsup norm(A_n)^(1/n) = c > 1$ 则 $sumk0inf(A_k)$ 发散
    ]<Cauthy-Hadamard>
    #proof[
      - 将 $norm(A_k)$ 与 $norm(c^k)$ 作比较即可得到绝对收敛，进而收敛
      - 取上极限的子列，与 $norm(c^k)$ 作比较即可得到单项的模不趋于零
    ]
    #theorem[][
      设 $X$ 是 $CC$ 上的 Banach 空间，$A in L(X)$，则：
      - $rho(A)$ 是开集
      - $sigma(A) subset closure(B(0, norm(A)))$
      - $sigma(A)$ 是非空紧集
      - $r_sigma (A) = sup {abs(lambda) mid(|) lambda in sigma(A)}$ 称为谱半径，有：
        $
          r_sigma (A) = limn(norm(A^n))^(1/n)
        $
    ]
    #proof[
      这个定理的结论非常简洁，但证明十分繁琐。
      #lemma[][
        $norm(A) < 1 => I - A$ 可逆
      ]<norm_lt_one_then_inv>
      #proof[
        注意到 $sumi0inf(A^n)$ 收敛，并且容易验证：
        $
          (I - A) sumi0inf(A^n) = sumi0inf(A^n) (I - A) = I\
        $
      ]
      #corollary[][
        $sigma(A) subset closedBall(0, norm(A))$
      ]
      #proof[
        若 $abs(lambda) > norm(A)$，上面的引理给出 $lambda I - A$ 可逆，因此 $lambda$ 不在谱中
      ]
      上面的事实表明，$sigma(A)$ 是有界的。接下来，我们证明它是闭的，也即 $rho(A)$ 是开的。
      #lemma[][
        $rho(A)$ 是开的
      ]
      #proof[
        设 $lambda_0 in rho(A), norm(lambda - lambda_0) < epsilon$，则：
        $
          lambda I - A = (lambda I - lambda_0 I) + (lambda_0 I - A) = Inv(lambda_0 I - A) (I + (lambda_0 I - A) (lambda I - lambda_0 I) )\
        $
        注意到：
        $
          norm((lambda_0 I - A) (lambda I - lambda_0 I)) <= norm(lambda_0 I - A) epsilon\
        $
        取 $epsilon$ 足够小，上式小于 $1$，由 @norm_lt_one_then_inv 可知上式可逆，证毕。
      ]
      这就意味着 $sigma(A)$ 是有界闭集，接下来，我们证明它非空。事实上，如果 $sigma(A) = emptyset$，则 $rho(A) = CC$，继而 $R_lambda$ 是 $CC$ 上的有界全纯函数，由 Liouville 定理可得 $R_lambda$ 是常函数，这是荒谬的。

      接下来，考虑谱半径公式：
      #lemma[][
        设 $A in L(X)$，则 $limn(norm(A^n)^(1/n))$ 存在且恰为 $inf_n norm(A^n)^(1/n)$
      ]
      #proof[
        取 $r = inf_(n >= 1) norm(A^n)^(1/n)$，设 $N$ 满足：
        $
          r(A) <= norm(A^N)^(1/N) < r + epsilon\
        $
        对于任何 $n$，做整除设 $n = q_n N + r_n$，就有：
        $
          norm(A^n)^(1/n) = norm(A^(q_n N + r_n))^(1/n) <= norm(A^(q_n N))^(1/n) norm(A^(r_n))^(1/n)\
          <= norm(A^N)^(q_n/n) norm(A^(r_n))^(1/n)\
          <= (norm(A^N)^(1/N))^((q_n N)/(q_n N + r_n)) norm(A^(r_n))^(1/n)\
        $
        由于 $r_n$ 有界，不难证明 $n$ 充分大时上式 $<= r + 2 epsilon$，由 $epsilon$ 任意性即可得到结论。
      ]
      回到谱半径公式，设 $r(A) = limn(norm(A^n)^(1/n))$：
      - 若 $abs(lambda) > r(A)$，则：
        $
          limsup norm(A^n/lambda^(n + 1))^(1/n) < 1
        $
        由 @Cauthy-Hadamard 可知 $sumk0inf(A^k/lambda^(k + 1))$ 收敛，进而 $lambda I - A$ 可逆，表明 $sigma(A) subset B(0, r(A)) => r_sigma (A) <= r(A)$
      - 另一方面，前面提到 $R_lambda (A)$ 是 $rho(A)$ 上的全纯函数，特别的，它是 $CC - closedBall(0, r_sigma (A))$ 上的全纯函数。任取 $f in duelSpace(L(X))$，就有 $inner(f, R_lambda (A))$ 在 $CC - closedBall(0, r_sigma (A))$ 上解析，因此有唯一的 Laurent 展开：
        $
          R_lambda (A) = sum_(n = -infinity)^(+infinity) 1/lambda^n a_n
        $
        而前面提到过，在 $lambda > norm(A) + 1$ 时有：
        $
          R_lambda (A) = sumi0inf(A^n/lambda^(n + 1))\
          inner(f, R_lambda (A)) = sumi0inf(inner(f, A^n)/lambda^(n + 1))\
        $
        由 Laurent 级数的唯一性，两个级数是相同的，进而也表明 $sumi0inf(inner(f, A^n)/lambda^(n + 1))$ 在 $CC - closedBall(0, r_sigma (A))$ 上都收敛。进而有：
        $
          abs(inner(f, A^n)/lambda^(n + 1)) <= M
        $
        取 $lambda = r_sigma (A) + epsilon$，就有：
        $
          abs(inner(f, A^n /(r(A) + epsilon)^n)) = abs(inner(tau(A^n /(r(A) + epsilon)^(n + 1)), f)) <= M
        $
        这表明，对于任何 $f in duelSpace(L(X))$，一族算子 $tau(A^n /(r(A) + epsilon)^n)$ 作用在 $f$ 上都有界，由 Banach-Steinhaus 定理可知：
        $
          norm(A^n /(r(A) + epsilon)^(n + 1)) < K\
        $
        也即：
        $
          norm(A^n)^(1/n) <= K^(1/n) (r_sigma (A) + epsilon)^((n + 1)/n)
        $
        令 $n -> +infinity$ 即得：
        $
          r(A) <= r_sigma (A) + epsilon\
        $
        再由 $epsilon$ 任意性可得 $r(A) <= r_sigma (A)$



    ]
    #definition[][
      设 $X$ 是 Hibert 空间，$A in L(X)$ 满足 $duel(A) A = A duel(A)$，则称 $A$ 为正规算子
    ]
    #lemma[][
      设 $A$ 是正规算子，则：
      - $norm(A x) = norm(duel(A) x)$
      - $r(A) = norm(A)$
      - $sigma_r (A) = emptyset$
    ]<spectrum_of_normal_operator>
    #proof[
      - 
        $
          inner(A x, A x) = inner(duel(A) A x, x) = inner(A duel(A) x, x) = inner(duel(A) x, duel(A) x)\
        $
      - 
        $
          norm(A x)^2 = inner(duel(A) A x, x) <= norm(duel(A) A x) norm(x) = norm(A A x) norm(x) <= norm(A^2) norm(x)^2
        $
        但显然有 $norm(A^2) <= norm(A)^2$，因此 $norm(A^2) = norm(A)^2$，因此：
        $
          r(A) = limn(norm(A^n)^(1/n)) = limn(norm(A^(2^n))^(1/2^n)) = norm(A)\
        $
    ]
    #example[][
      设 $X$ 是 Hibert 空间：
      - 称 $A$ 是自伴算子，如果 $A = duel(A)$，则显然 $A$ 是正规算子，前面的性质都成立。特别的，设 $lambda = a + b i, b != 0$，则可以计算得：
        $
          norm((lambda I - A) x)^2 = norm((a I - A) x)^2 + b^2 norm(x)^2
        $
        我们立刻有：
        - $ker(lambda I - A) = 0$
        - $im (lambda I - A)$ 是闭的
        - 设 $y in orthogonalCom(im (lambda I - A))$，则：
          $
            inner(y, (lambda I - A) x) = inner((overline(lambda) I - A) y, x) = 0, forall x\
          $
          这表明 $y in ker ((overline(lambda) I - A) = 0$，继而 $lambda I - A$ 是满的
        上面的事实表明，其谱中的元素都是实数
      - 称 $u$ 是酉（unitary）算子，如果 $duel(u) u = u duel(u) = I$，则：
        - $u$ 是可逆的正规算子
        - $inner(u x, u y) = inner(x, y)$
        - $norm(u x) = norm(x) => norm(u) = 1$
        - 设 $lambda != 0 in sigma(u)$，也即 $lambda I - u$ 不可逆，注意到：
          $
            lambda I - u = (Inv(u) - Inv(lambda) I) lambda u
          $
          因此 $Inv(lambda)$ 也在 $Inv(u)$ 的谱之中，而 $Inv(u)$ 也是正交的，表明 $norm(lambda) <= 1$ 且 $norm(Inv(lambda)) <= 1$，继而 $norm(lambda) = 1$
    ]
    #example[][
      设 $X = l^2, A (x_1, x_2, ...) = (0, x_1, ...)$，则有：
      - $norm(A^n) = 1 => r(A) = 1$
      - 若 $(lambda I - A) x = 0$，则：
        $
          lambda x_1 = 0\
          lambda x_(n + 1) = x_n
        $
        显然 $lambda = 0$ 时 $x = 0$，因此 $ker(lambda I - A) = 0$，因此 $sigma_P (A) = emptyset$
      - 任取 $y in orthogonalCom(closure(im (lambda I - A)))$，则：
        $
          inner(y, (lambda I - A) x) = inner((overline(lambda) I - duel(A)) y, x) = 0, forall x\
        $
        这表明 $y in ker ((overline(lambda) I - duel(A)) = 0$，事实上可以直接验证，$duel(A)$ 就是左平移，此时可以计算得：
        $
          y = y_1 (overline(lambda), overline(lambda^2), ...)
        $
        若设 $L_x = span((overline(lambda), overline(lambda^2), ...))$，则当 $norm(lambda) < 1$ 时 $L_x$ 确实是 $L^2$ 的子空间，且可以验证 $L_x = orthogonalCom(closure(im (lambda I - A)))$。而当 $norm(lambda) = 1$ 时，上面的结果表明 $orthogonalCom(closure(im (lambda I - A))) = 0$
      - 若 $norm(lambda) = 1, z = (lambda I - A) x$，可以计算得：
        $
          sumi1N(lambda^(i - 1) z_i) = lambda^N x^N 
        $
        继而 $sumi1N(lambda^(i - 1) z_i) -> 0$，因此不难验证 $(1/(i lambda^(i - 1)))$ 不在 $im (lambda I - A)$ 之中   
    ]
    #lemma[][
      设 $P$ 是投影算子，则：
      $
        sigma(A P) = sigma(A|_(im P)) union {0}
      $
    ]<projection-sigma>
    #proof[
      设 $X_1 = im P, X_2 = ker P, i : im P -> X$，注意到：
      $
        lambda I - A P = lambda I_(X_2) directSum lambda I_(X_1) - A|_(X_1)\
      $
      - 假设 $lambda in.not sigma(A P)$，则上式可逆，当然有分量可逆，因此 $lambda I_(X_1) - A|_(X_1)$ 可逆，$lambda in sigma(A_X_1)$
      - 反之，假设 $lambda in.not sigma(sigma(A|_(im P)))$ 且 $lambda != 0$，就可以得到 $lambda I - A P$ 可逆，故 $lambda in sigma(A P)$
    ]
  == Holomorphic functional calculus\*
    设 $X$ 是 $CC$ 上的 Banach 空间，$A in L(x)$，任取函数 $f$，能否定义 $f(A)$? 熟知 $f$ 是多项式时结果是自然的，这里我们将推广到 $f$ 是解析函数的情形，事实上之后还可以推广到 $f$ 是可测函数的情形。
    #definition[][
      设 $g(t) : [0, 1] -> X$ 是连续函数，则可以仿照黎曼积分定义：
      $
        integral_0^1 g(t) dif t
      $
      且可以利用 Hahn-Banach 定理证明它是唯一的。
    ]
    #definition[Dunfod Integral][
      设 $u subset CC$ 是开集，且 $sigma(A) subset u$，记：
      $
        gamma = (gamma_1, gamma_2, ..., gamma_m)
      $
      为 loops，如果 $gamma_i$ 是 $u - sigma(A)$ 上的曲线，且 $gamma_i (0) = gamma_i (1)$，以及：
      $
        omega(gamma, lambda) = 1 ,forall lambda in sigma(A)\
        omega(gamma, lambda) = 0 ,forall lambda in CC - u\
      $
      其中 $omega(gamma, lambda)$ 是所有 $gamma_i$ 到 $lambda$ 的缠绕数之和。

      设 $f$ 是 $u -> CC$ 的全纯函数，定义：
      $
        f(A) = 1/(2 pi i) integral_(gamma)^() f(z) Inv(z I - A) dif z 
      $
      这里，$f(z) Inv(z I - A)$ 是 $gamma -> L(X)$ 的连续函数（注意到 $gamma$ 中的曲线到 $sigma(A)$ 存在最小距离，因此逆是有界的），利用上面所叙述的积分定义得到
    ]
    #lemma[][
      + 上面定义的积分不依赖于 $gamma$
      + $(f + g) (A) = f(A) + g(A)$
      + $(lambda f)(A) = lambda f(A)$
      + $(f g) (A) = f(A) g(A)$
      + 若 $f$ 是多项式，则 $f(A)$ 就是符合直观定义的 $f(A)$
      + $(g compose f) (A) = g(f(A
      ))$
    ]
    #proof[
      + 假设 $gamma, gamma'$ 都符合之前的条件，则：
        $
          f_gamma (A) - f_gamma' (A) = 1/(2 pi i) integral_(gamma - gamma') f(z) Inv(z I - A) dif z 
        $
        利用 Hahn-Banach 定理，任取 $duel(y) in duelSpace(L(X))$，则：
        $
          inner(duel(y), f_gamma (A) - f_gamma' (A)) = 1/(2 pi i) integral_(gamma - gamma') f(z) inner(duel(y), Inv(z I - A)) dif z 
        $
        这是标准的复函数积分，而被积函数非解析部分曲线的缠绕数为零，进而上式总是零，得证。
      + ...
      + ...
      + ...
      + 由前面的性质，只需验证 $f = 1, z$ 即可
        - 对于 $f= 1$ 只需计算：
          $
            integral_(norm(z) = r)^() Inv(z I - A) dif z = integral_(0)^(2pi) Inv(r e^(i theta) I - A) r e^(i theta)  dif theta = integral_(0)^(2pi) I + Inv(r e^(i theta) I - A) A dif theta
          $
          事实上，有：
          $
            norm(1/(2 pi) integral_(0)^(2pi) Inv(r e^(i theta) - A) A dif theta) <= 1/(2 pi) integral_0^(2 pi) norm(Inv(r e^(i theta) - A)) norm(A) dif theta\
            <= 1/(2pi) integral_0^(2 pi) norm(A)/(r - norm(A)) dif theta = norm(A) / (r - norm(A))
          $
          令 $r -> +infinity$ 上式 $-> 0$，而定义不依赖于 $r$，因此上式就是零
      + 稍后证明
    ]
    #theorem[Spectral Mapping][
      $
        f(sigma(A)) = sigma(f(A))
      $
    ]<spectral-mapping>
    #proof[
      任取 $lambda in sigma(A)$，注意到：
      $
        g(z) = (f(z) - f(lambda)).(z - lambda)
      $
      在 $u$ 上是全纯的，因此：
      $
        f(z) - f(lambda) = (z - lambda) g(z)
      $
      继而：
      $
        f(A) - f(lambda I) = (A - lambda I) g(A)
      $
      表明 $f(A) - f(lambda I) = f(A) - f(lambda) I$ 不可逆，因此 $f(lambda) in sigma(A)$

      另一方面，设 $mu in.not f(sigma(A))$，注意到 $f(sigma(A))$ 是紧的，因此可设 $dist(u, f(sigma(A))) = delta > 0$，此时 $g(z) = 1/(f(z) - u)$ 在包含 $sigma(A)$ 的某个开集上良定义，进而解析，因此：
      $
        1 = g(z) (f(z) - u)
      $ 
      进而：
      $
        1 = g(A) (f(A) - u I)
      $
      表明 $f(A) - u I$ 可逆，这就证明了 $mu in.not sigma(f(A))$
    ]
    回到 $g(f(A)) = (g compose f)(A)$ 的证明：
    #proof[
      设 $f: u -> v, g : v -> CC$， 我们需要 @spectral-mapping 保证 $sigma(f(A)) = f(sigma(A))$，因此 $g(f(A))$ 是良定义的。考虑 $sigma(A)$ 的一个 cycles $beta$，令：
      $
        K = beta union {lambda in U mid(|) omega(beta, lambda) != 0}\
      $
      由定义，$K$ 是紧的，且包含 $sigma(A)$，因此 $f(K)$ 也是紧的且包含 $f(sigma(A))$。在 $v - f(K)$ 上取 cycles $gamma$，就有：
      $
        g(f(A)) = 1/(2 pi i) integral_(gamma)^() g(z) Inv(z I - f(A)) dif z\
        = 1/(2 pi i) integral_(gamma)^() integral_(beta) g(z) 1/(z - f(lambda)) Inv(lambda I - A) dif lambda dif z
      $ 
      注意到此时 $1/(z - f(lambda))$ 是全纯的，因此可以换序，就有：
      $
        = 1/(2 pi i) integral_(beta) integral_(gamma)^() g(z) 1/(z - f(lambda)) Inv(lambda I - A) dif z dif lambda\
        = 1/(2 pi i) integral_(beta) g(f(lambda)) Inv(lambda I - A) dif lambda\
      $
    ]
    #theorem[][
      设 $sigma(A) = Sigma_1 union Sigma_2$，$Sigma_i$ 是不交的紧集。若 $u_i$ 是包含 $Sigma_i$ 的不交开集，定义：
      $
        funcDef(f, u_1 union u_2, CC, z, cases(
          1 "if " z in u_1,
          0 "if" z in u_2
        ))
      $
      则 $P = f(A)$ 就是投影算子，进一步，设：
      $
        X_1 = ker P\
        X_2 = im P
      $
      则 $X = X_1 directSum X_2$，我们有：
      $
        sigma(A|_X_2) = sigma(A P) = Sigma_1\
        sigma(A|_X_1) = sigma(A (I - P)) = Sigma_2\
      $
    ]
    #proof[
      设 $f' = 1 - f$，容易验证：
      $
        f^2 = f\
        f'^2 = f'\
        f f' = f' f = 0\
      $
      提升后就有：
      $
        P^2 = P\
        P A = A P("由定义")\
        P'^2 = P'\
        P' A = A P'\
        P P' = P' P = 0\
      $
      这足以表明 $P, P'$ 就是一对投影算子，以及：
      $
        sigma(A P) = sigma((id * f) (A)) = (id * f) (sigma(A)) = Sigma_1 union {0}
      $
      只需证明：
      $
        sigma(A|_X_0) = sigma(A P)
      $
      @projection-sigma 给出：
      $
        sigma(A|_X_0) union {0} = sigma(A P) union {0}
      $
      然而这不能给出最终的结论。我们转而考虑：
      $
        A|_X_1 directSum c id_X_2 = A P + c (I - P) = (id * f + c f') (A)
      $
      因此：
      $
        sigma(A|_X_1 directSum c id_X_2) = Sigma_1 union {c}
      $
      现在，对于任何 $lambda in.not Sigma_1$，取 $c != lambda$，利用 @projection-sigma 相同的技巧可以得到 $lambda I - A_X_2$ 可逆，表明 $sigma(A_X_2) subset Sigma_1$。反之，若 $lambda in.not sigma(A_X_2)$，取 $c != lambda$，我们可以得到 $lambda in CC - (Sigma_0 union {c}) => lambda in Sigma_0$，这就得到了结论
    ]
= 紧算子和 Fredholm 算子
  == 紧算子
    #definition[紧算子][
      设 $X, Y$ 是 Banach 空间，$A$ 是线性算子，称 $A$ 为紧算子，如果 $A$ 将任何有界集映为预紧集。记 $C(X, Y)$ 为 $X -> Y$ 所有紧算子的集合（有时也用 $K(X, Y)$）
    ]
    #lemma[][
      紧算子一定是有界算子
    ]
    #proof[
      设 $B_1 = closedBall(0, 1)$，则它有界，$A(B_1)$ 预紧，因此由 @compact-condition 它完全有界，进而有界，相当于 $A$ 是有界算子。   
    ]
    #example[][
      - $A$ 是有界算子，且 $im A$ 有限维，则 $A$ 把有界集映为有界集，而有限维空间中有界集当然就是预紧的，因此 $A$ 是紧算子。后面会证明，所有紧算子都接近于这种算子
      - $X = C(Omega), Omega$ 是 $RR^n$ 中紧集，$K(x, y) in C(Omega times Omega)$，定义：
        $
          T f (x) = integral_Omega K(x, y) f(y) dif y\
        $
        这是一个紧算子。这是因为由 @Arzela-Ascoli，只要证明对于有界集 $F, T F$ 等度连续，一致有界：
        - 一致有界：
          $
            abs(T f(x)) <= norm(K) norm(f) abs(Omega) <= M norm(K) abs(Omega)
          $
          这是一与 $f$ 无关的常数
        - 等度连续：利用 $K$ 的一致连续性：
          $
            abs(T f(x) - T f(x')) = abs(integral_Omega (K(x, y) - K(x', y)) f(y) dif y) <= epsilon M abs(Omega)
          $
          这表明 $T f$ 是一致连续的
      - 类似的，可以证明：
        $
          T f (x) = integral_0^x f(y) dif y\
        $
        是紧算子
    ]
    #proposition[][
      设 $B_1 = B(0, 1)$， 以下事实等价：
      + $closure(A(B_1))$ 是紧的
      + $A$ 是紧算子
      + 对于 $x_n$ 有界，$A x_n$ 总有收敛子列 
    ]
    #proof[
      注意到度量空间中紧和列紧等价，推理是容易的
    ]
    #proposition[][
      $C(X, Y)$ 是 $L(X, Y)$ 的闭线性子空间
    ]
    #proof[
      线性性是显然的，只证明闭性。设 $A_n -> A$ 且 $A_n$ 是紧算子，任取 $epsilon$，设 $norm(A_n - A) < epsilon$，而 $A_n (B_1)$ 预紧，因此完全有界，可设：
      $
        A_n (B_1) subset union_(i = 1)^z B(x_i, epsilon)\
      $
      显然就有：
      $
        A (B_1) subset union_(i = 1)^z B(x_i, 2 epsilon)\
      $
      由 $epsilon$ 任意性，$A(B_1)$ 也完全有界，因此预紧。
    ]
    #proposition[][
      设 $A in C(X, Y), X_0 subset X$ 是闭子空间，则 $A|_X_0 subset C(X_0, Y)$
    ]
    #theorem[][
      设 $A$ 是紧算子，则 $im A$ 可分
    ]
    #proof[
      注意到：
      $
        im A = union_(n = 1)^(+infinity) A (closedBall(0, n))\
      $
      而 $A (closedBall(0, n))$ 总是完全有界的，进而是可分的，可分空间的可数并当然也是可分的。
    ]
    #theorem[][
      设 $X ->^A Y ->^B Z$ 且 $A, B$ 是有界算子，则只要 $A, B$ 其中之一是紧算子，则 $B A$ 是紧算子。特别的，$C(X)$ 是 $L(X)$ 中的闭理想。
    ]
    #proposition[][
      $A$ 是紧算子当且仅当 $duel(A)$ 是紧算子
    ]
    #proof[
      - 设 $A$ 是紧算子，$y_n in duel(Y)$ 是有界集合。注意到 $closure(A(B_1))$ 是紧的，取 $i : closure(A(B_1)) -> Y$，则 $duel(i) y_n$ 是紧集上的连续函数，往证：
        - $duel(i) z$ 一致有界：
          $
            abs(inner(duel(i) y_n, z)) = inner(y_n, i z) <= norm(y_n) norm(z) <= norm(y_n) <= M
          $
        - $duel(i) z$ 等度连续：
          $
            abs(inner(duel(i) y_n, z - z')) <= norm(y_n) norm(z - z') <= M norm(z - z')\
          $
        由 @Arzela-Ascoli，$duel(i) y_n$ 有收敛子列。不妨就设 $duel(i) y_n$ 收敛。注意到我们有：
        $
          norm(duel(A) y_n - duel(A) y_m) 
          &= sup_(norm(x) <= 1) abs(inner(duel(A) y_n - duel(A) y_m, x))\
          &= sup_(norm(x) <= 1) abs(inner(y_n - y_m, A x))\
          &= sup_(y in closure(A(B_1))) abs(inner(y_n - y_m, i y))\
          &= sup_(y in closure(A(B_1))) abs(inner(duel(i) y_n - duel(i) y_m, y))\
          &= norm(duel(i) y_n - duel(i) y_m)\
        $
        由前面的假设，当然就有 $duel(A) y_n$ 收敛
      - 设 $duel(A)$ 是紧算子，前面的结论给出 $duel(duel(A))$ 也是，而 $A$ 无非是 $duel(duel(A))$ 在闭子空间上的限制，因此也是紧算子
    ]
  == 全连续算子
    #definition[][
      设 $A in L(X, Y)$，称 $A$ 是全连续的，如果：
      $
        x_n weakConverge x => A x_n -> A x\
      $
    ]
    #lemma[][
      - 紧算子都是全连续的
      - 若 $A$ 是全连续的，且 $X$ 是自反的，则 $A$ 是紧算子
    ]
    #proof[
      - 如若不然，设 $x_n weakConverge x, norm(A x_n - A x) >= epsilon_0$，前面已经证明 $x_n$ 一定有界，因此 $A x_n$ 有收敛子列，不妨设其收敛于 $z$，然而显然有 $A x_n weakConverge A x$，因此 $A x = z$，这是荒谬的。
      - 任取 $x_n$ 有界，前面证明了自反空间中单位球是弱紧的，因此 $x_n$ 有弱收敛子列，设 $x_n_k weakConverge x$，前面证明了 $A x_n_k -> A x$，因此 $A x_n$ 有收敛子列。由 $x_n$ 的任意性，$A$ 是紧算子。 
    ]
  == 有限秩算子
    #definition[][
      设 $X, Y$ 是 Banach 空间，$A in L(X, Y)$，称 $A$ 是有限秩算子，如果 $im A$ 是有限维的。记有限秩算子的全体为 $F(X, Y)$
    ]
    #lemma[][
      $A in F(X, Y)$ 当且仅当 $A = sum_(i = 1)^N y_i tensorProduct f_i <=> A x = sum_(i = 1)^N f_i (x) y_i$ 
    ]
    显然，我们有 $closure(F(X, Y)) subset C(X, Y)$，那么是否有 $closure(F(X, Y)) = C(X, Y)$ 呢？1932 年 Banach 提出了这个问题，1973年，人们才给出了最终的结论：答案是否定的。但是，人们发现该性质只依赖于 $Y$ 的性质，而在许多相对简单的情况下，答案是肯定的。
    #lemma[][
      设 $Y$ 是 Hilbert 空间，则 $closure(F(X, Y)) = C(X, Y)$
    ]
    #proof[
      任取 $A$ 是紧算子，$epsilon > 0$，注意到 $A(B(0, 1))$ 预紧，因此完全有界，可设：
      $
        A(B(0, 1)) subset union_(i = 1)^z B(x_i, epsilon)\
      $
      记 $E_epsilon = span(z_i), B_epsilon = orthogonalCom(E_epsilon), A_epsilon = P_epsilon A$. 显然 $A_epsilon$ 是有限秩的，而：
      $
        norm(A - A_epsilon) = sup_(x in B(0, 1)) norm(A x - A_epsilon x)\
      $
      设 $norm(A x - z) <= epsilon, z in E_epsilon$，就有上式:
      $
        <= norm(A x - z) + norm(z - A_epsilon x)\
        <= epsilon + norm(P_epsilon z - P_epsilon A x)\
        <= epsilon + norm(P_epsilon) norm(z - A x)\
        <= 2 epsilon\
      $
    ]
    对于一般的 Banach 空间，如果它可分，我们可以考虑 @schouder-basis（对于不可分情形，也许也可以使用类似的方法研究，不过基本不会碰到）
    #definition[][
      称一个 Schouder 基是无条件 Schouder 基，如果其中任何求和都是可换序的。
    ]
    #example[][
      - 在 $l^p, p < +infinity$ 中，$e_n = i arrowb ite(i = n, 1, 0)$ 就是一个无条件 Schouder 基（注意在 $l^infinity$ 中它不再是 Schouder 基了）
      - 在 $C_0 = {x in l^(+infinity) | limn(x(n)) = 0}$ 中，上面定义的 $e_n$ 也是一个（无条件？） Schouder 基
      - 在 $C = {x in  l^(+infinity) | limn(x(n)) exists}$ 中，$f_n = i arrowb ite(i <= n, 0, 1)$ 是 Schouder 基，但不是无条件的 Schouder 基
    ]
    人们自然会考虑，是否每个可分空间都有 Schouder 基呢？答案也是否定的。
    #lemma[][
      设 $X$ 是 Banach 空间，$e_n$ 是一个 Schouder 基，则取坐标映射 $C_i := sum c_n e_n -> c_i$ 是有界线性算子
    ]<coordinate-bounded>
    #proof[
      线性是显然的。对于有界性，定义：
      $
        norm(x)_1 = sup_N norm(sum_(i = 1)^N c_i (x) e_i)\
      $
      可以验证，$norm(x)_1$ 也是一个范数，且 $norm(x) <= norm(x)_1$。为了利用等价范数定理，验证它也是完备的。任取柯西列 $x_n, epsilon > 0$，可设：
      $
        sup_N (S_N (x_n - x_m)) < epsilon
      $
      显然这表明对于每个 $i$ 都有 $norm(c_i (x_n - x_m)) < epsilon$，因此每个系数都构成柯西列，定义系数的极限，可以验证这就是原序列的极限。

      利用等价范数定理，就有：
      $
        norm(x)_1 <= M norm(x)\
      $
      表明 $norm(S_i) <= M, norm(S_(i + 1)) <= M, norm(c_i) <= 2/norm(e_i) M$，证毕
    ]
    #theorem[][
      设 $Y$ 是有 Schouder 基的 Banach 空间，则 $closure(F(X, Y)) = C(X, Y)$
    ]
    #proof[
      设 $A$ 是紧算子，$epsilon > 0$，仿照之前在 Hilbert 空间的证明，依旧设 $A(B(0, 1)) subset union_(i = 1) B(z_i, epsilon)$，取 $K$ 足够大使得：
      $
        norm(z_i - sum_(k = 1)^K c_k (z_i) e_k) < epsilon 
      $
      考虑 $S_K (x) = sum_(k = 1)^K c_k (x) e_k, A_epsilon = S_K A$，注意到 $S_K$ 是有限秩的，因此 $A_epsilon$ 也是，而：
      $
        norm(A - A_epsilon) = sup_(x in B(0, 1)) norm(A x - A_epsilon x)\
      $
      仍取 $z$ 使得 $norm(A x - z) <= epsilon$，就有上式：
      $
        &<= norm(A x - z) + norm(z - A_epsilon x)\
        &<= epsilon + norm(z - S_K z) + norm(S_K z - A_epsilon x)\
        &<= epsilon + norm(z - S_K z) + norm(S_K z - S_K A x)\
        &<= 2 epsilon + norm(S_K) norm(z - A x)\
        &<= 2 epsilon + norm(S_K) epsilon\
      $
      （@coordinate-bounded 给出 $norm(S_K)$ 有限）因此结论成立
    ]
  == Risez-Fredholm 理论
    在有限维空间中，我们有若 $A in L(X)$，则 $ker A = 0 <=> im A = X$，将它推广到 $I - A$ 其中 $A$ 是紧算子，就得到了 Risez-Fredholm 理论
    #lemma[][
      设 $A$ 是紧算子，$T = I - A$，则 $ker T, ker duel(T)$ 都是有限维空间
    ]
    #proof[
      考虑空间 $ker T$ 中的单位球 $B$，任取 $x_n in B$，将有：
      $
        T x_n = x_n - A x_n = 0 => A x_n = x_n\
      $
      由 $A$ 是紧算子，$A x_n$ 有收敛子列，$x_n$ 就有收敛子列，进而 $B$ 预紧，由 Risez 引理 $ker T$ 是有限维的。

      对于第二个结论，注意到 $duel(T) = I - duel(A)$，而 $duel(A)$ 也是紧算子，因此结论成立
    ]
    #lemma[][
      设 $A$ 是紧算子，$T = I - A$，则 $im T$ 是闭的 
    ]
    #proof[
      #let tildeT = $tilde(T)$
      设 $tildeT : X quo ker T -> Y$ 是 $T$ 的诱导算子，只需证明 $im tildeT$ 是闭的。只需证明 $exists c, norm(tildeT(x)) >= c norm(x)$，如若不然，则存在序列 $x_n, norm(pi x_n) = 1$ 使得 $norm(tildeT(pi x_n)) < 1/n$，事实上，可以假设 $norm(pi x_n) <= norm(x_n) <= 2 norm(pi x_n)$，则 $x_n$ 有界，$A x_n$ 有收敛子列，不妨设 $A x_n -> w$，注意到 $tildeT(pi x_n) -> 0$
    ]
    #lemma[][
      设 $A$ 是紧算子，$T = I - A$，则 $ker T = 0 => im T = X$
    ]<Fredholm-1>
    #proof[
      假设 $im T != X$，断言 $im T > im T^2 > ...im T^n > ...$，且它们都是闭的，之后，由 Risez Lemma，取 $x_m in im T^m - T^(m - 1)$ 使得 $norm(x_m) = 1, d(x_m, T^(m + 1)) > 1/2$，
    ]
    #lemma[][
      设 $X$ 是 Banach 空间，$X_0$ 是有限维子空间，则存在 $X_1$ 是闭子空间使得：
      $
        X = X_1 directSum X_0
      $
    ]<finite-space-orthogonal-complement>
    #proof[
      设 $x_i$ 是 $X_0$ 的一组基，构造 $f_i in duel(X_0)$ 使得 $f_i (x_j) = delta_(i j)$，由 Hahn-Banach 定理它们可以延拓到 $X$ 中得到 $tilde(f)_i$。设：
      $
        X_1 = inter ker(tilde(f)_i)
      $
      显然 $X_1$ 是闭子空间，$X_1 inter X_0 = 0$，以及对于任何 $x in X$，设：
      $
        y = x - sum_i tilde(f)_i (x) x_i\
      $
      则可以验证 $tilde(f)_i (y) = 0, forall i => y in X_1$，进而 $x in X_0 + X_1 => X_0 + X_1 = X$，这就验证了直和成立。
    ]
    #lemma[][
      设 $X$ 是 Banach 空间，$f_i in duelSpace(X)$ 线性无关，则存在 $y_i in X$ 使得 $f_i (y_j) = delta_(i j)$
    ]<duel-basis>
    #proof[
      用归纳法，$n = 1$ 时显然，假设 $n = m$ 时成立，熟知 $"codim" ker f_(m + 1) = 1$，也即可设：
      $
        X = {z} directSum ker f_(m + 1)\
      $
      将 $f_1, f_2, ..., f_m$ 限制在 $ker f_(m + 1)$. 断言它们的限制也是线性无关的，否则存在线性组合 $f$ 使得 $f|_(ker f_(m + 1)) = 0$，此时 $f, f_(m + 1)$ 的值只由在 $z$ 上的值确定，它们必然线性相关，与线性无关性矛盾！由归纳假设存在 $y_1, y_2, ..., y_m in ker f_(m + 1)$ 使得 $f_i (y_j) = delta_(i j)$

      最后，取：
      $
        y_(m + 1) = (z - sum_(i = 1)^m f_i (z) y_i)/(f_(m + 1) (z))\
      $
      可以验证就有 $y_i$ 满足条件。
    ]
    #lemma[][
      设 $A$ 是紧算子，$T = I - A$，则 $dim ker T = dim ker duel(T)$
    ]
    #proof[
      前面已经证明两个空间都是有限维的，设：
      $
        ker T = span(x_1, x_2, ..., x_n)\
        ker duel(T) = span(f_1, f_2, ..., f_m)\
      $
      由 @finite-space-orthogonal-complement 可设：
      $
        X = ker T directSum X_1\
      $
      由 @duel-basis 可设：
      $
        f_i (y_j) = delta_(i j)\
      $
      断言：
      $
        X = span(y_1, ..., y_m) directSum orthogonalCom(ker duel(T))\
      $
      这是因为：
      - 任取 $x in X$，考虑：
        $
          y = x - sum_i f_i (x) y_i\
        $
        则可以验证 $f_i (y) = 0$，因此 $y in ker duel(T)$，因此 $x in ker duel(T) + orthogonalCom(ker duel(T))$
      - 显然 $span(y_1, ..., y_m) inter orthogonalCom(ker duel(T)) = 0$
      注意到 @im-equal-orthogonalCom-ker-duel 给出 $im T = orthogonalCom(ker duel(T))$，而 $X_1$ 与 $im T$ 之间应该有双射。假设 $m > n$，设：
      $
        funcDef(tilde(T), X, X, sum c_i x_i + z, sum c_i y_i + T z)
      $
      则可以验证：
      $
        tilde(T) (sum c_i x_i + z) = sum c_i x_i + z - A z + sum_i c_i (y_i - x_i)\
      $
      注意到：
      - $sum c_i x_i + z arrowb A z$ 是紧算子
      - $sum c_i x_i + z arrowb sum_i c_i (y_i - x_i)$ 是有限秩算子
      因此 $tilde(T)$ 形如 $I -$紧算子，由 @Fredholm-1 以及不难验证它是单射，则它是满射，然而这与 $m > n$ 矛盾！这就证明了：
      $
        dim ker T >= dim ker duel(T) >= dim ker duel(duel(T)) 
      $
      然而熟知 $dim ker duel(duel(T)) >= dim ker T$，因此上面的式子全部取等。
    ]
    #lemma[][
      设 $A$ 是紧算子，$T = I - A$，则 $im duel(T) = leftOrthogonal(ker T)$
    ]
    #proof[
      容易验证：
      - $ker T subset ker duel(duel(T))$
      - $dim ker T = dim ker duel(duel(T)) < +infinity$
      表明 $ker T = ker duel(duel(T))$，接下来验证定义即可。
    ]
    #lemma[][
      设 $A$ 是紧算子，$T = I - A$，则 $im T = X => ker T = 0$
    ]
    #proof[
      此时，$im T = X => "codim" im T = 0 => dim ker T = 0 => ker T = 0$
    ]
    #theorem[Fredholm 二择一律][
      设 $A$ 是紧算子，$T = I - A$，则：
      - $T$ 是单的当且仅当是满的
      - $sigma(T) = sigma(duel(T))$
      - $dim ker T = dim ker duel(T) < +infinity$
      - $im(duel(T)) = leftOrthogonal(ker T), im T = orthogonalCom(ker T)$
      - $"codim" im T =  dim (X quo (im T)) = dim ker T$
    ]
  == Riesz-Schauder Theory
    #theorem[][
      设 $X$ 是 Banach 空间，$A in C(X)$，则：
      - 只要 $X$ 是无穷维的，则 $0 in sigma(A)$
      - $sigma(A) - {0} = sigma_p (A) - {0}$
      - $sigma(A)$ 的聚点只能是 $0$（$0$ 未必是聚点）
      - $sigma(A)^1 subset {0}$
    ]
    #proof[
      - 若 $A$ 可逆，$I = Inv(A) A$ 是紧算子，表明单位球预紧，导致有限维
      - 设 $lambda in sigma(A) - {0}$，则 $I - A / lambda$ 是不可逆的，由 Risez-Fredholm 理论，$I - A / lambda$ 单当且仅当满，而它已经不可逆，因此一定既不单又不满
      - 假设 $lambda$ 是非零聚点，$lambda_n in sigma(A) - {0} -> lambda$，则 $lambda_n$ 都是特征值，可设特征向量分别为 $x_n$ 且 $norm(x_n) = 1$. 设：
      $
        E_n = span(x_1, x_2, ..., x_n)
      $
      由 Risez 引理，可以找到 $y_(n + 1) in E_(n + 1) - E_n, norm(y_(n + 1)) = 1, dist(y_(n + 1), E_n) >= 1/2$，由 $A$ 是紧的，$A y_n$ 有收敛子列，然而 $m >n$ 时：
      $
        (A y_(m))/lambda_(m) - (A y_n)/lambda_n in y_m + E_n
        => norm((A y_m)/lambda_m - (A y_n)/lambda_n) >= 1/2
      $
      表明 $(A y_n)/lambda_n$ 不可能有收敛子列，矛盾！
    ]
    #corollary[][
      设 $X$ 无穷维，$A$ 是紧算子，则 $sigma(A)$ 只有以下几种可能：
      - $sigma(A) = {0}$
      - $sigma(A)$ 有限
      - $sigma(A) = {0} union {lambda_n}, lambda_n -> 0$
    ]
    #example[][
      - 设 $X = C[0, 1], T f = integral_(0)^(x) f(t) dif t$，则 $T$ 是紧算子，设 $lambda$ 是非零特征值，就有：
        $
          integral_(0)^(x) f(t) dif t = lambda f(x)\
        $ 
        解微分方程就有 $f(x) = C e^(1/lambda x)$，然而结合 $f(0) = 0$ 就有 $f(x) = 0$，表明它的谱就是 ${0}$（当然，也可以计算谱半径 $= 0$）
      - $X = l^2, A x = (lambda_1 x_1, lambda_2 x_2, ..., lambda_n x_n, 0, 0, ...)$，显然 $A$ 是有限秩算子，$sigma(A) = {0, lambda_1, ..., lambda_n}$
      - 对于任何 $lambda_n -> 0, X = l^2, (A x)(i) = lambda_i x(i)$，前面证明过 $sigma(A) = closure({lambda_n}) = {0} union {lambda_i}$，且它可被上面的有限秩算子逼近，因此是紧算子。
    ]
  == 紧算子的结构
    对于有限维线性变换，我们有 Jordan 标准形唯一描述了线性变换的结构。对于紧算子，我们也可以做出类似的结果。
    #proposition[][
      对于 $T in L(X)$，我们有：
      $
        ker T <= ker T^2 <= ... <= ker T^n <= ...\
        im T >= im T^2 >= ... >= im T^n >= ...\
      $
      并且若其中某两项相等，则后面的都相等。
    ]
    #proof[
      序关系是显然的。
      - 假设 $ker T^p = ker T^(p + 1)$，任取 $x in ker T^(p + 2)$ 也即 $T^(p + 2) x = 0 => T^(p + 1) T x = 0 => T^p T x = 0 => T^(p + 1) x = 0 => x in ker T^(p + 1)$
      - $im$ 的证明也是类似的。
    ]
    #lemma[][
      假设 $ker, im$ 链都在有限步终止，则它们在相同的步数 $p$ 终止，且：
      $
        X = ker T^p directSum im T^p\
      $
    ]
    #proof[
      设 $ker T^p = ker T^(p + 1), im T^(q) = im T^(q + 1)$ 且 $p, q$ 都是最小的
      - 假设 $p < q$，则 $forall y in X, T^q y = T^(q + 1) z => T^q (y - T z) = 0 => T^p (y - T z) = 0 => T^p y = T^(p + 1) z$，由任意性就有 $im T^p = im T^(p + 1)$，矛盾！
      - 假设 $p > q$，取 $y in ker T^(q + 1) - ker T^q$，也即：
        $
          T^(q + 1) y = 0, T^q y != 0
        $
        然而 $im T^(q + 1) = im T^q$，因此可设：
        $
          T^(q + 1) y' = T^q y
        $
        可以验证 $y' in ker T^(q + 2) - ker T^(q + 1)$，反复进行下去就有 $ker$ 链一直增加，与假设矛盾！
      因此我们就有 $p = q$，且：
      $
        x = (x - T^p x) + T^p x\
      $
      其中 $x - T^p x in ker T^p, T^p x in im T^p$，只需证明两者不交即可。设：
      $
        T^p (T^p x) = 0 => T^(2 p) x = 0 => x in ker T^(2 p) = ker T^p =? T^p x = 0 
      $
      证毕。
    ]
    #remark[][
      显然对于任何 $k$，都有 $ker T^k$ 是 $T-$不变的。而假设 $p(T) = q(T) < +infinity$，则很明显 $im T^p$ 也是 $T^k$ 不变的。
    ]
    #lemma[][
      设 $p(T) = q(T) < +infinity$，则 $T|_(im T^p)$ 是双射
    ]
    #proof[
      显然它是满射。对于单射，设：
      $
        T (T^p x) = 0
      $
      立刻有：
      $
        x in ker T^(p + 1) = ker T^p => T^p x = 0\ 
      $
      因此是单射。
    ]
    #let pre = [设 $A in C(X), T = I - A$]
    #lemma[][
      #pre，则 $p(T) = q(T) < +infinity$
    ]
    #proof[
      假设 $im$ 链一直下降，注意到 $T^k = (I - A)^k$ 也是紧算子，因此 $im T^k$ 都是紧的。由 Risez 可取 $x_n in im T^n - im T^(n + 1), norm(x_n) = 1, d(x_n, im T^(n + 1)) >= 1/2$，显然 $A x_n$ 有收敛子列，然而若设 $m > n$ ：
      $
        norm(A x_n - A x_m) = norm(T x_m - T x_n - (x_m - x_n)) = norm(x_n - (x_m + T x_m - T x_n)) >= d(x_n, im T^(n + 1)) >= 1/2
      $
      矛盾！同时：
      $
        dim ker T^k = "codim" im T^k < +infinity
      $
      而 $im$ 链稳定，表明 $dim ker T^k$ 稳定，因此 $ker T^k$ 当然也稳定。
    ]
    前面提到过，$sigma_p (A)$ 至多可数个，设为 $lambda_i$，则 $T_(lambda_i) = A - lambda_i I$ 也形如某个 $T$，因此可设 $p_i = p(T_(lambda_i))$. 就有：
    $
      X = ker T_(lambda_i)^(p_i) directSum im T_(lambda_i)^(p_i)\
    $
    注意到，$T_(lambda_i)$ 是有限维空间 $ker T_(lambda_i)^(p_i)$ 上的幂零线性变换，因此由线性代数的结论 $tilde(T)_(lambda_i)$ 有 Jordan 标准形（分解成循环子空间），不难验证 $ker T_(lambda_i)^(p_i)$ 也是 $A$ 的不变子空间，$A$ 在其上当然就有 Jordan 标准型。总之，我们就有：
    #proposition[][
      #pre，则 $A$ 在 $directSum_i ker T_(lambda_i)^(p_i)$ 上有 Jordan 标准型。
    ]
    #proof[
      只需证明它们是直和即可，也就是证明：
      $
        S := ker T_(lambda_i)^(p_i) inter directSum_(j in E) ker T_(lambda_j)^(p_j) = 0\
      $
      其中 $E$ 是不含 $i$ 的有限集。首先，不难验证 $S$ 是 $A-$ 不变的有限维子空间。同时：
      $
        (lambda_i - x)^(p_i), product_(j in E) (lambda_j - x)^(p_j)\
      $
      都是 $A$ 的零化多项式，然而显然这两个多项式互素，因此 $A|_S = 0$，因此：
      $
        0 = T_(lambda_i)^(p_i)|_S = (A - lambda_i I)^(p_i)|_S = (-lambda_i)^(p_i) I
      $
      显然，除非 $S = 0$，否则矛盾！
    ]
  == Hilbert-Schmidt 理论
    本节中都假设 $H$ 是 $CC$ 上的 Hibert 空间
    #definition[自伴算子][
      设 $A in L(H)$，称 $A$ 是自伴算子，如果 $inner(A x, y) = inner(x, A y), forall x, y in H$，也即 $A = duel(A)$
    ]
    #lemma[][
      - 若 $A$ 自伴，则 $sigma(A) subset RR, sigma_r (A) = emptyset$
      - $A$ 自伴当且仅当 $forall x, inner(A x, x) in RR$
      - $norm(Inv(lambda I - A) x) <= 1/(abs(Im lambda)) norm(x), forall lambda in.not RR$
      - 若 $A$ 自伴， $H_1$ 是 $A$ 不变的子空间，则 $A|_(H_1)$ 是自伴算子
      - 若 $A$ 自伴，设 $lambda, lambda'$ 是不同的特征值，则特征子空间相互正交
      - 若 $A$ 自伴，则 $norm(A) = sup_(norm(x) = 1) abs(inner(A x, x))$
    ]<property-of-self-adjoint-operator>
    #proof[
      - 由 @spectrum_of_normal_operator 即得
      - @law-of-norm-which-has-inner 的证明中，用到了：
        $
          inner(A x, y) = 1/4 sum_(k = 0)^e i^k inner(A (x + i^k y), x + i^k y)\
        $
        而：
        $
          inner(x, A y) &= overline(inner(A y, x))\ 
          &= 1/4 overline(sum_(k = 0)^e i^k inner(A (y + i^k x), y + i^k x))\
          &= 1/4 sum_(k = 0)^e (-i)^k inner(A (y + i^k x), y + i^k x)\
          &= 1/4 sum_(k = 0)^e (-i)^k inner((-i)^k A (y + i^k x), (-i)^k (y + i^k x))\
          &= 1/4 sum_(k = 0)^e (-i)^k inner(A (x + (-i)^k y),  x + (-i)^k y)\
          &= 1/4 sum_(k = 0)^e i^k inner(A (x + i^k y),  x + i^k y)\
          &= inner(A x, y)\
        $
        证毕。
      - 设 $lambda = a + b i$，可以计算得：
        $
          norm2((lambda I - A) y) = norm2((a I - A) y) + norm2(b y)
        $
        因此：
        $
          norm(b y) <= norm((lambda I - A) y)
        $
        由于 $A$ 是正规算子，$sigma(A) subset RR$，因此 $lambda I - A$ 可逆，立刻就得到了结论。
      - 显然
      - 设：
        $
          x in ker lambda I - A, y in ker lambda' I - A
        $
        则：
        $
          lambda inner(x, y) = inner(lambda x, y) = inner(A x, y) = inner(x, A y) = inner(x, lambda' y) = lambda' inner(x, y)
        $
        因此 $lambda = lambda'$ 或者 $inner(x, y) = 0$，因此特征子空间相互正交。
      - 显然 $C := sup_(norm(x) = 1) abs(inner(A x, x)) <= norm(A)$，而熟知：
        $
          norm(A) = sup_(norm(x) = 1, norm(y) = 1) abs(inner(A x, y))
        $
        可以计算得：
        $
          inner(A(x + y), x + y) - inner(A (x - y), x - y) = 4 Re inner(A x, y)\
        $
        因此：
        $
          4 abs(Re inner(A x, y)) <= C (norm2(x + y) + norm2(x - y))\
          <= 2 C (norm2(x) + norm2(y))
        $
        若取 $norm(x) = norm(y) = 1$ 就有：
        $
          abs(Re inner(A x, y)) <= C
        $
        用 $i x$ 替代 $x$，就有：
        $
          abs(Im inner(A x, y)) <= C
        $
        足以表明：
        $
          norm(inner(A x, y)) <= C
        $
        因此结论成立。
    ]
    #let pre = [设 $A in C(X)$ 是自伴算子]
    #lemma[][
      #pre，则 $exists norm(x_0) = 1, norm(A) = abs(inner(A x_0, x_0))$，且 $A x_0 = abs(inner(A x_0, x_0)) x_0$
    ]
    #proof[
      注意到 $inner(A x, x)$ 总是实数，因此不妨设 $norm(A) = sup_(norm(x) = 1) inner(A x, x)$（否则取 $A = -A$）。设 $f(x) = inner(A x, x)$，取 $norm(x_n) = 1, f(x_n) -> norm(A)$，不妨设 $x_n weakConverge x_0$（Hilbert 空间中单位球弱紧），紧算子的性质表明 $A x_n -> A x_0$。断言 $inner(A x_n, x_n) -> inner(A x_0, x_0)$，这是因为：
      $
        inner(A x_n, x_n) - inner(A x_0, x_0) = inner(A (x_n - x_0), x_n) + inner(A x_0, x_n - x_0)\
      $ 
      其中 $x_n$ 有界，$A (x_n - x_0) -> 0, x_n - x_0 weakConverge 0, A x_0$ 是常数，因此上式 $-> 0$.

      由弱收敛性，有：
      $
        norm(x_0) <= lim inf norm(x_n) = 1
      $
      同时：
      $
        norm(A) = abs(inner(A x_0, x_0)) <= norm(A) norm(x_0)^2
      $
      因此 $norm(x_0) = 1$. 设：
      $
        phi(t) = inner(A (x_0 + t y), x_0 + t y)/(inner(x_0 + t y, x_0 + t y))\
      $
      显然 $phi(t) <= norm(A), phi(0) = norm(A)$，因此它在零点处取最大值。求导得：
      $
        phi' (t) = ((inner(A x_0, y) + inner(A y, x_0)) norm2(x_0 + t y) - inner(A (x_0 + t y), x_0 + t y) (inner(y, x_0) + inner(x_0, y)))/norm(x_0 + t y)^4\
        0 = phi' (0) = Re (inner(A x_0, y) - norm(A) inner(x_0, y))  
      $
      用 $i y$ 代替 $y$ 就有：
      $
        0 = Im (inner(A x_0, y) - norm(A) inner(x_0, y))  
      $
      因此：
      $
        inner(A x_0, y) - norm(A) inner(x_0, y) = inner((A - norm(A) I) x_0, y) = 0
      $
      这对任何 $y$ 都成立，因此：
      $
        (A - norm(A) I) x_0 = 0\
      $
      表明 $x_0$ 是特征向量，且对应的特征值为 $norm(A) = abs(inner(A x_0, x_0))$
    ]
    #corollary[][
      #pre, 则 $norm(A) in sigma_p (A)$
    ]
    #theorem[谱定理/自伴紧算子的对角化][
      #pre，则存在向量组 $E$ 构成单位正交基，$i : E -> sigma_p (A)$，使得：
      $
        forall x = sum_(e in E) inner(x, e) e, A x = sum_(e in E) i(e) inner(x, e) e\
      $
      换言之，$A$ 在这组基上是对角的。同时对 $lambda != 0 in sigma_p (A)$，$Inv(i) (lambda)$ 是有限的。
    ]
    #proof[
      设：
      $
        tau : sigma_p (A) -> P(X)
      $
      使得 $tau(lambda)$ 是 $ker (lambda I - A)$ 的标准正交基，以及：
      $
        E = union_(lambda in sigma_p (A)) tau(lambda)
      $
      注意到 $A$ 
      $E$ 也标准正交。往证：
      $
        H' = closure(span(E)) = directSum_(lambda in sigma_p (A)) ker (lambda I - A) = H
      $
      取 $M = orthogonalCom(H')$，断言 $M$ 是 $A-$不变的，这是因为：
      $
        A x in M <=> forall e in E, inner(A x, e) = 0\
        <=> forall e in E, inner(x, A e) = 0\
        <=> forall lambda in sigma_p (A), e in tau(lambda), inner(x, lambda e) = 0\
        <=> forall lambda in sigma_p (A) - {0}, e in tau(lambda), inner(x, e) = 0\
        arrow.double.l forall lambda in sigma_p (A), e in tau(lambda), inner(x, e) = 0\
        <=> x in M\
      $<AM-and-M>
      以及：
      - $forall lambda in sigma_p (A), lambda I - A|_M$ 是单射，否则设 $x in M, A x = lambda x => x in ker lambda I - A => x in ker(lambda I - A) subset H'$，这是荒谬的
      - $A|_M$ 是紧算子：显然
      由 Fredholm 理论，若还有 $lambda != 0$，则 $lambda I - A|_M$ 是满射，因此 $(sigma_p (A) - {0}) inter sigma (A|_M) = emptyset$，导致一定有：
      $
        sigma(A|_M) = {0} = sigma_c (A|_M)
      $
      然而，前面的定理给出一定有 $norm(A) in sigma_p (A)$，矛盾！
    ]
    #theorem[min-max 分类][
      #pre，则：
      $
        min sigma_p^+ (A) = inf_(E_(n - 1)) sup_(x in orthogonalCom(E_(n - 1))) inner(A x, x)/inner(x, x)\
        max sigma_p^- (A) = sup_(E_(m - 1)) inf_(x in orthogonalCom(E_(m - 1))) inner(A x, x)/inner(x, x)\
      $
      其中 $E_(n - 1)$ 是任何 $n - 1$ 维子空间,$n = abs(sigma_p^+ (A)), m = abs(sigma_p^- (A))$
    ]
    #proof[
      只证明第一个，第二个是类似的。由谱定理，设：
      $
        A x = sum_e i(e) inner(x, e) e\
        inner(A x, x) = sum_e i(e) abs(inner(x, e))^2\
        inner(x, x) = sum_e abs(inner(x, e))^2\
      $
      记：
      $
        mu_n = inf_(E_(n - 1)) sup_(x in orthogonalCom(E_(n - 1))) inner(A x, x)/inner(x, x)
      $
      - 取 $E^0_(n - 1)$ 是 $A$ 的除 $lambda_max$ 外的正特征值对应特征向量组成的空间，显然有：
        $
          inner(A x, x)/inner(x, x) <= min sigma_p^+ (A)
        $
        这就表明 $mu_n <= min sigma_p^+ (A)$
      - 对于任何 $E_(n - 1)$，断言存在 $x_0 in E^0_(n - 1)$ 使得 $x_0 orthogonal E_(n - 1)$（这是有限维线性代数问题，正交化即可），则：
        $
          sup_(x in orthogonalCom(E_(n - 1))) inner(A x, x)/inner(x, x) >= inner(A x_0, x_0)/inner(x_0, x_0)\
          = (sum_(lambda in sigma_p^+ (A)) lambda abs(inner(x_0, e(lambda)))^2)/(sum_e abs(inner(x_0, e(lambda)))^2)\
          >= min sigma_p^+ (A)
        $
    ]
    #corollary[][
      设 $A, B in C(X)$ 都自伴，且 $inner(A x, x) >= inner(B x, x)$，则 $min sigma_p^+ (A) >= min sigma_p^+ (B)$
    ]
  == Polar decomposition\*
    #definition[][
      设 $H$ 是 $CC$ 上的 Hibert 空间，$A in L(H)$，称 $A$ 是正定的，如果：
      $
        inner(A x, x) >= 0, forall x in H
      $
    ]
    #corollary[][
      正定算子都是自伴的
    ]
    #proof[
      由 @property-of-self-adjoint-operator 立得
    ]
    #lemma[][
      设 $A in L(H)$ 正定，则存在唯一的正定算子 $B in L(H)$ 使得 $A = B^2$\
      进一步，对于任何 $C in L(H)$ 满足 $[C, A] = C A - A C = 0$，则 $C B - B C = 0$
    ]
    #proof[
      由分析知识可以知道：
      $
        (1 - x)^(1/2) = sum C_n x^n
      $
      在 $x in [-1, 1]$ 上都绝对收敛。对于题中 $A$，不妨设 $norm(A) < 1$，则：
      $
        norm(I - A) = sup_(norm(x) = 1) abs(inner((I - A) x, x)) = sup_(norm(x) = 1) abs(1 - inner(A x, x)) < 1
      $
      设：
      $
        B = sum C_n (I - A)^n
      $
      由于级数绝对收敛，上式是良定义的，且 $B^2 = A$，并有：
      $
        inner(B x, x) = inner(x, x) + sum_(n > 1) C_n inner((I - A)^n x, x) 
      $
      同时，当 $n > 1$ 时有 $C_n < 0$，因此上式：
      $
        >= inner(x, x) + sum_(n > 1) C_n norm(x)\
        = (sum_n C_n) norm(x)\
        = 0
      $
      级数表达式容易给出交换性。对于唯一性，设 $B'$ 也满足要求，则由交换性以及 $B', A$ 交换，有 $B' B = B B'$，则：
      $
        (B - B') B (B - B') + (B - B') B' (B - B') = 0
      $
      而容易验证上式两项都是正定算子，因此两个正定算子的和为零，只能两项均为零，相减就有：
      $
        (B - B')^3 = 0
      $
      注意到 $B - B'$ 是自伴算子，上式给出它的特征值只有零，继而 $B - B' = 0$
    ]
    #definition[][
      对于任何 $A in L(H)$，定义：
      $
        abs(A) = sqrt(duel(A) A)
      $
    ]
    #lemma[Polar decomposition][
      设 $A in L(H)$，则存在唯一的 $U$ 使得 $A = U abs(A)$，其中 $U$ 是部分正交算子（对于 $x in orthogonalCom(ker U)$ 有 $norm(U x) = norm(x)$），且 $ker U = ker A$
    ]
    #proof[
      注意到：
      $
        norm2(abs(A) y) = inner(abs(A) y, abs(A) y) = inner(y, abs(A)^2 y) = inner(y, duel(A) A y) = norm2(A y)\
      $
      这也表明 $abs(A) z_1 = abs(A) z_2 => A z_1 = A z_2$，
      进而定义：
      $
        funcDef(u, im abs(A), im A, abs(A) z, A z)
      $
      显然就有 $u$ 在 $im abs(A)$ 上保范。$u$ 可以简单的延拓到闭包上，再取 $P$ 是到 $closure(im abs(A))$ 的投影算子，设：
      $
        U = u P
      $
      可以验证：
      - $ker U = orthogonalCom(im abs(A)) = ker abs(A) = ker A$
      - $forall x, U abs(A) x = u (abs(A) x) = A x$
      因此 $U$ 就是满足条件的算子。至于唯一性，设 $U'$ 也满足条件。显然：
      $
        U' (I - P) = U (I - P) = 0
      $
      而对于任何 $x$，可设 $P x = abs(A) y$，就有：
      $
        U' P x = U' abs(A) y = A y = U P x
      $
      因此 $U' P = U P$，就有 $U' = U$
    ]
    #definition[trace][
      - 对于 $A$ 正定，定义：
        $
          tr(A) = sumi1inf(inner(A e_i, e_i))
        $
        可以证明，它是不依赖基的
      - 对于一般的 $A$，定义：
        $
          tr(A) = tr(abs(A))
        $
      - 称：
        $
          {A in L(H) | tr(A) < +infinity}
        $
        构成 trace class. 可以证明，它是 $L(H)$ 中的一个理想。
    ]
  == Fredholm 算子\*
    #let ind = "ind"
    #let Fredholm = $cal(F)_r$
    #definition[][
      设 $X, Y$ 是 Banach 空间，称 $A in L(X, Y)$ 是 Fredholm 算子，如果：
      - $dim ker A < +infinity$
      - $im A$ 是闭的
      - $dim (X quo im A) < +infinity$
      记 Fredholm 算子的全体为 $Fredholm(X, Y)$，并且对其中元素定义：
      $
        ind(A) = dim ker A - dim coker A
      $
      称为 $A$ 的指标。
    ]
    #example[][
      - 若 $A$ 是可逆的，则 $A$ 是 Fredholm 算子，且 $ind(A) = 0$
      - 若 $X, Y$ 是有限维空间，则 $A$ 是 Fredholm 算子，$ind(A) = dim X - dim Y$
      - 设 $A$ 是紧算子，则 $I - A$ 是 Fredholm 算子，且 $ind(I - A) = dim ker A - dim (X quo im A) = 0$
      - 在 $X = l^2$ 中，$A$ 是右平移算子，则可以验证 $A$ 也是 Fredholm 算子，$ker A = 0, dim coker A = 1, ind(A) = -1$
    ]
    #theorem[][
      设 $A in L(X, Y), dim coker A < infinity$，则 $im A$ 是闭的
    ]<closed-image-lemma>
    #proof[
      自然的，不妨假设 $A$ 是单的（否则诱导到 $X quo ker A$ 即可），只需证明 $norm(A x) >= c norm(x)$. 取：
      $
        y_1, y_2, ..., y_n in Y
      $
      使得 $pi y_i$ 构成 $coker A = Y quo im A$ 的一组基，设：
      $
        tilde(X) = X directSum RR^n\
        tilde(A) = A directSum (alpha arrowb alpha^T autoRVecN(y, n))
      $
      可以验证，$tilde(A)$ 是双射，立刻就有逆算子定理：
      $
        norm(tilde(A) (x + alpha)) >= c (norm(x) + norm(alpha))
      $
      特别的，取 $alpha = 0$，就得到了结论。9

    ]
    #theorem[][
      设 $X, Y$ 完备，$A$ 是有界算子，则以下说法等价：
      - $A in Fredholm(X, Y)$
      - 存在 $B$ 使得 $I - B A, I - A B$ 是紧算子
      - 存在 $B_1, B_2$ 使得 $I - B_1 A, I - A B_2$ 是紧算子
    ]<Fredholm-characterization>
    #proof[
      - $1 => 2$:
        由于 $ker A, coker A$ 是有限维，可设：
        $
          X = ker A directSum X_1\
          Y = Y_0 directSum im A\
        $
        其中 $X_1, Y_0$ 都是闭的。取 $tilde(A) : X_1 -> im A$ 是 $A$ 诱导出的映射。注意到 $X_1, im A$ 都是完备空间，定义：
        $
          funcDef(B, Y, X, y_0 + y_1, Inv(tilde(A)) (y_1))
        $
        则 $P$ 是投影与有界算子的复合，是有界的。容易验证，$im I - B A subset ker A, im I - A B subset Y_0$，可见两者都是有限秩算子，自然是紧的。
      - $2 => 3$ 显然
      - $3 => 1$ 注意到 $ker (A) subset ker(B_1 A)$，而 $I - B_1 A$ 是紧算子，当然 $ker(B_1 A)$ 有限维，$ker(A)$ 也是有限维。类似的，$im A B_2 subset im A, Y quo (im A) subset Y quo im A B_2$，因此 $Y quo (im A)$ 有限维。由 @closed-image-lemma 可知结论成立。
    ]
    #remark[][
      在上面的条件 2 中，显然 $B$ 也是 Fredholm 算子。（事实上 3 中的 $B_1, B_2$ 也是但并不容易）
    ]
    #lemma[][
      设 $V^i ->^(T^i) V^(i + 1)$ 是有限维算子构成的正合列，且第一项和最后一项是零，就有：
      $
        sum_(j = 1)^n (-1)^j dim V^j = 0
      $
    ]<exact-sequence-lemma>
    #proof[
      注意到：
      $
        dim V^j = dim ker T^j + dim im T^j\
        = dim ker T^j + dim ker T^(j + 1)
      $
      不难验证结论成立。
    ]
    #theorem[][
      设 $A, B$ 是 Fredholm 算子，则 $B A$ 也是，且：
      $
        ind(B A) = ind(A) + ind(B)
      $ 
    ]
    #proof[
      根据 @Fredholm-characterization 可设：
      $
        I - C A, I - A C\
        I - D B, I - B D
      $
      都是紧算子。因此（考虑在商掉紧算子的空间中）：
      $
        I - C D B A = I - C A = 0\
        I - B A C D = I - B D = 0
      $
      由 @Fredholm-characterization 可知 $B A$ 是 Fredholm 算子。对于 $ind$，考虑：
      $
        0 -> ker A -> ker B A ->^A ker B ->^pi Y quo (im A) ->^B Z quo (im B A) -> Z quo (im B) -> 0
      $
      可以验证它是正合列，由 @exact-sequence-lemma 立刻得到结论。
    ]
    #theorem[][
      设 $A$ 是 Fredholm 算子，$K$ 是紧算子，则 $A + K$ 也是，且 $ind(A + K) = ind A$
    ]
    #theorem[][
      对于 $A in Fredholm$，存在 $epsilon > 0$ 使得 $B(A, epsilon) subset Fredholm$
    ]
    #proof[
      设 $I - A B, I - B A$ 是紧的。注意到：
      $
        (A + T) B = A B + T B = I + T B - (I - A B)
      $
      熟知只要 $T$ 充分小，就有 $I + T B$ 可逆，计算可得：
      $
        (A + T) B Inv(I + T B) = I - (I - A B) Inv(I + T B)
      $
      这就找到了 $A + T$ 的“右逆”，类似的也可以找到左侧的。
    ]
    以上的事实可以总结为，Fredholm 算子是可逆算子的推广，例如当 $X = Y$ 时，Fredholm 算子就是 $L(X) quo C(X)$ 中的可逆元，$ind$ 函数也可以提升到 $Fredholm(X) quo C(X) -> ZZ$
    #theorem[][
      $
        A in Fredholm <=> duel(A) in Fredholm\
        ind(A) = ind(duel(A))\
      $
    ]

