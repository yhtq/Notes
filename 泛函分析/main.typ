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
      ]
      #remark[][
        定义中 $x_i$ 是否属于 $E$ 是无关紧要的。即使它们都在 $X$ 中，只需取开球中在 $E$ 中的点以及两倍大小的开球即可。
      ]
      #theorem[][
        设 $X$ 是度量空间，$E subset X$，以下命题等价：
        - $E$ 是紧致的
        - $E$ 的任何无穷子集都有聚点
        - $E$ 列紧
        - $E$ 是完备的并且完全有界
      ]

