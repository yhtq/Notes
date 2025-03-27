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
    ]
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
    ]
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
    ]
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
    #theorem[Banach-Steinhaus][
      设 $T_n in L(X, Y)$，$X, Y$ 都是 Banach 空间，若：
      $
        forall x in X, sup_n norm(T_n x) < +infinity
      $
      则：
      $
        sup_n norm(T_n) < +infinity
      $
    ]