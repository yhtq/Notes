#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, der, partialDer, inner, fourierTrans
#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "数学模型",
  author: "YHTQ",
  date: none,
  logo: none,
)
#let vol = $"vol"$
= 前言
  - 教师：邵嗣烘
  - 没有教材，每次具体留作业
  主要涉及的数学模型：
  + 图模型
  + 0-1表示模型
  + 图灵机模型
  + 微分方程模型
  + 随机模型
= 图模型
  #definition[图][
    图是由顶点集合和边集合组成的一个二元组$G=(V,E)$，其中$V$是顶点集合，$E$是边集合。
  ]
  #definition[图割问题][
    考虑简单无向图 $G$，任给 $V$ 的两个不相交子集 $A, B$，定义之间的割值为：
    $
    "cut"(A, B) = sum_(a in A, b in B) w(a, b)
    $
    约定：
    $
    "cut"(A) = "cut"(A, V-A)\
    vol(A) = sum_(a in A) d(a)
    $
    经典的四类图割问题：
    - 最小割问题
      $
      h_(min) := min "cut"(A)/(1/2 vol(V))
      $
    - 最大割问题
      $
      h_(max) := max "cut"(A)/(1/2 vol(V))
      $
    - cheeger 问题（均匀最小割）
      $
      h := min "cut"(A) / min("vol"(A), vol(V-A))
      $
    - 反 cheeger 问题
      $
      h_("anti") := max "cut"(A) / max("vol"(A), vol(V-A))
      $
    上述四个问题中，最小割问题有多项式时间算法，其余三个问题都是 NP 完全的。
  ]
  #example[][
    例如并行计算中，我们可以将任务抽象为图，节点表示任务计算量，边表示数据依赖关系和通信量。假如我们有 $k$ 个对等的机器，我们希望将任务分配到机器上，使得每台机器的计算量尽量均衡，同时尽量减少机器之间的通信量。这就是一个图割问题。
  ]
  == cheeger 问题的估计
    #definition[指示向量][
      对于图 $G$ 和集合 $A$，定义：
      $
      x_i = cases(
        1\, quad i in A,
        -1\, quad i not in A
      )
      $
    ]
    #theorem[][
      - $"cut"(A) = sum_({i, j} in E(A, V - A)) w(i, j) = sum_({i, j} in E) |x_i - x_j| = sum_({i, j} in E) (x_i - x_j)^2$
      - $"vol"(A) = sum_(i in V) d_i x_i = sum_(i in V) d_i x_i^2$
      - $"vol"(V - A) = sum_(i in V) d_i (1 - x_i)^2$
      - 
        $
        min("vol"(A), vol(V - A)) = min_(c in {0, 1}) sum_(i in V) d_i (x_i - c)^2
        $
    ]
    任取图的一个定向，定义关联矩阵 $B$，我们发现：
    $
    sum_({i, j} in E) (x_i - x_j)^2 = norm(B x) = x^T B^T B x
    $
    #definition[组合 Laplace 矩阵][
      称 $L = B^T B = D - W$ 为图 $G$ 的组合 Laplace 矩阵，其中 $D$ 为图的度矩阵，$W$ 为图的邻接矩阵。
    ]
    至此，我们将所有式子化成了实解析的形式。接下来只需要将 $c, x$ 看成 $RR$ 上变元就可以得到估计。通过一些拉格朗日乘子法，我们可以得到：
    $
    min (x^T L x)/(x^T D x)\
    "with" x dot (D arrow(1)) = 0
    $
    其中 $L$ 是拉普拉斯矩阵，$D = "diag"(d_1, d_2, ..., d_n)$ 为每个顶点的度 。
    - 先解决前者。这个形式也被称为广义特征值问题。\
      该问题可以化为标准的特征值问题，事实上由于 $D$ 是正定的对角矩阵，可取 $D = C^2$，并利用拉格朗日乘子法，问题化为：
      $
      L v = lambda C^2 v\
      Inv(C) L v = lambda (C v)\
      (Inv(C) L Inv(C)) v = lambda v
      $
      （$lambda$ 是拉格朗日乘子，可以计算得到它也是上面最优化问题的最优值）\
      这是标准的特征值问题，且 $Inv(C) L Inv(C)$ 是实对称矩阵，故其特征值都是实数，且在记重数的情况下恰有 $n$ 个。\
      这里注意到了 $L = B^T B$ 是半正定矩阵，$Inv(C) L Inv(C)$ 合同于 $L$，故这些特征值都是非负数。\
      我们将特征值从小到大排列得到 $lambda_1 <= lambda_2 <= ... <= lambda_n$\
      此外，可以计算得到 $L arrow(1) = 0$，因此 $L$ 有广义特征值 $0$
    - 对于后者，我们发现 $D arrow(1)$ 事实上刚好是 $0$ 所对应的特征向量，因此只是在说不考虑该特征值/特征向量（注意特征向量都正交）
    综合而言，我们发现第二特征值 $lambda_2$ 就是我们给出的 $h$ 的估计。注意到当 $lambda_2$ 非零时，它就是最小特征值，是很容易计算的。接下来我们需要估计 $lambda_2$ 与实际 $h$ 的差距。
    === $lambda_2$ 与 $h$
    假设 $A$ 是一个取得 $h$ 的图割，也就是：
    $
    h(G) = "cut"(A)/(min("vol"(A), vol(V-A)))
    $ 
    令指示向量 
    $
    y_i = cases(
      1 / (vol A)\, quad i in A,
      -1 / (vol (V-A))\, quad i not in A
    )
    $我们试图反过来去计算 $lambda_2$，断言：
    - $y dot D arrow(1) = 0$\
      验证：
      $
      sum_(i in V) d_i y_i = sum_(i in A) d_i / ("vol"A) - sum_(i in V-A) d_i / ("vol"(V-A)) = 0
      $
    因此由定义，当然有 
    $
    lambda_2 <= (y^T L y)/(y^T D y) = (sum_(i, j in E) (y_i - y_j)^2)/(sum_(i in V) d_i y_i^2)\
    = "cut"(A)(1/("vol"A) + 1/("vol"(V-A))) \
    <= 2 h(G)
    $
    #theorem[Cheeger][
      $lambda_2/2 <= h(G)$
    ]
    至此，我们给出了 $h(G)$ 的上界。自然的，我们要思考是否可以给出上界。

    对于任意的 $y in RR^n$，定义：
    $
    R(y) = (y^T L y)/(y^T D y)
    $
    称为 $y$ 的 Rayleigh 商。由于 $y$ 是任取的，因此通过估计 $R(y)$，可以得到 $h(G)$ 的一个上界。
    #lemma[][
      $forall y in RR^n$，存在 $V$ 的非空子集 $S$ 使得：
      $
      "cut"(S)/("vol"(S)) <= sqrt(2 R(y))
      $
      且：
      $
      S subset V_1 (y) = {i in V | y_i != 0}
      $
    ]
    #proof[
      注意到 $R(y)$ 关于 $y$ 齐次，因此不妨设 $y in [-1, 1]^n$\
      我们的目标是将不是两值向量的向量取整，称为 Rounding\
      取 $t ~ U(0, 1)$ 也就是服从 $(0, 1)$ 上随机分布的数\
      令：
      $
      S_t = {i in V | y_i^2 >= t}
      $
      我们的目标是：
      $
      E ("cut"(S_t) - sqrt(2 R(y)) "vol"(S_t)) <= 0
      $
      - 先计算第一个期望
        $
        E("cut" S_t) = integral_0^1 "cut"(S_t) dif t = integral_0^1 sum_({i, j} in E) i_A (t) dif t
        $
        其中 $i_(A_(i j)) (t)$ 是 $A_(i j) = {t in [0, 1] | y_i^2 <=t < y_j^2 or y_j^2 <= t < y_i^2}$ 的特征函数\
        上式等于：
        $
        sum_({i, j} in E) integral_0^1  i_(A_(i j)) (t) dif t\
        = sum_({i, j} in E) |y_j^2 - y_i^2| \
        = sum_({i, j} in E) |(y_j - y_i)(y_j+y_i)|\
        <= sqrt( sum_({i, j} in E) (y_j - y_i)^2) sqrt(sum_({i, j} in E) (y_j + y_i)^2)("柯西-施瓦兹不等式")\ 
        <= sqrt( sum_({i, j} in E) (y_j - y_i)^2) sqrt(sum_({i, j} in E) 2(y_i^2 + y_j^2))\ 
        = sqrt( sum_({i, j} in E) (y_j - y_i)^2) sqrt(sum_(i in V) 2 d_i y_i^2)\
        = sqrt(2 R(y)) (sum_(i in V) d_i y_i^2)
        $
      - 再计算第二个期望
        $
        E(vol(S_t)) = integral_0^1 vol(S_t) dif t = integral_0^1 sum_(i in V) i_(B_i) (t) d_i dif t\
        = sum_(i in V) d_i integral_0^1 i_(B_i) (t) dif t\
        = sum_(i in V) d_i y_i^2 dif t\
        $
        其中 $B_i = {t in [0, 1] | t <= y_i^2}$
      两式合并不难发现原结论成立
    ]
    #theorem[Cheeger][
      $h(G) <= sqrt(2 lambda_2)$
    ]
    为了证明这个结论，设 $x$ 是 $lambda_2$ 对应的广义特征向量。为了实现估计，我们当然希望 $x$ 是两值的向量，但是实际上往往与两值向量相去甚远。为此，我们尝试取得 $c in RR$ 以此作为对实向量两值化的阈值。同时为了使得分母的 $min("vol"(A), "vol"(V - A))$ 便于计算，我们希望：
    $
    "vol"{i in V | x_i < C} <= 1/2 "vol"(V)\
    "vol"{i in V | x_i > C} <= 1/2 "vol"(V)
    $
    事实上，我们不妨设 $x_i$ 从小到大排列，考虑：
    $
    sum_(i=1)^k d_i, forall k = 1, 2, ..., n
    $
    只需找到一个 $k$ 使得：
    $
    sum_(i=1)^k d_i <= 1/2 "vol"(V)\
    sum_(i=1)^(k+1) d_i >= 1/2 "vol"(V)
    $
    取 $C = x_(k+1)$ 即可，某种意义上只是在取中位数。我们把所有这样的取值集合称为 $"median"(x)$
    
    #proof[
      设 $x$ 是 $lambda_2$ 所对应的特征向量，取 $c in "median"(x)$，进而有：
      $
      vol{i in V | x_i < c} <= 1/2 vol(V)\
      vol{i in V | x_i > c} <= 1/2 vol(V)
      $
      令 $y = x - c dot 1$，断言：
      - $y^t L y = x^t L x$（平移不变性）
      - $y^T D y >= x^T D x$
        $
        y^T D y = x^T D x - 2 c 1^T D x + c^2 1^T D 1
        $
        注意到 $x dot (D 1) = 0$（这是之前的约束条件），因此该结论成立
      进而有：
      $
      lambda_2 = (x^T L x)/(x^T D x) >= (y^T L y)/(y^T D y)\
      = (y^T L y)/(y^T_+ D y_+ + y^T_- D y_-)\
      >= (y^T_+ L y_+ + y^T_- L y_-)/(y^T_+ D y_+ + y^T_- D y_-) (y^T_+ L y_- <= 0)\
      >= min {(y^T_+ L y_+)/(y^T_+ D y_+), (y^T_- L y_-)/(y^T_- D y_-)}
      $
      由引理，将有：
      $
      sqrt(2 R_(y_+)) >= ("cut" S)/(vol S) = ("cut" S)/(min {vol(S), vol(V - S)}) >= h(G) 
      $
      进而连上之前的不等式，结果成立
    ]
    #remark[][
      尽管我们做出了很大的努力，实际尝试就会发现我们给出的上下界是非常宽松的（尽管确实是紧的）。一大问题在于我们将连续的向量二值化的过程中产生了严重的损失，调整取整方法或许能一定情况下改善这一点。
    ]
    === 另一条道路 $mu_2$
      $
      h = min "cut"(A) / min("vol"(A), vol(V-A))\
      = min_(x in {0, 1}^n) (sum_((i, j) in E) |x_i - x_j|)/min("vol"(A), vol(V-A))\
      = min_(x in {0, 1}^n) (sum_((i, j) in E) |x_i - x_j|)/(min_(c in {0, 1}) sum_(i in V) d_i |x_i - c|)\
      $
      我们尝试另一条道路，不用二次型将上式光滑化，而是保持绝对值，将取值范围放松。我们将会惊喜地得到以下结果
      #lemma[][
          $
          N(x) = min_(c in RR) sum_(i in V) d_i |x_i - c| := min_(c in RR) g(c_i, x)
          $
          在 $c^*$ 取最小值的当且仅当 $c^* in "median"(x)$
      ]<median-min>
      #theorem[][
        设:
        $
        h' = min_(x in RR^n)(sum_((i, j) in E) |x_i - x_j|)/(min_(c in RR) sum_(i in V) d_i |x_i - c|)
        $
        则 $h' = h$
      ]
      #proof[
        记 $I(x) = sum_((i, j) in E) |x_i - x_j|, N(x) = min_(c in RR) sum_(i in V) d_i |x_i - c|$\
        由引理，我们仿照之前的操作进行 $c$ 平移，结合平移不变性，原式化为：
        $
        min_(0 in "median"(x)) I(x)/(norm(x)_d)
        $
        注意到上式也是齐次式，因此令 $S = {x in RR^n | norm(x)_d = 1}, pi = {x in S | 0 in "median"(x)}$，上式等于：
        $
        min_(x in pi) I(x)
        $
        设 $A$ 是取得 $h$ 的最小割，我们计算 $A$ 上的 $h'$\
        令
        $
        y_i = cases(
          1 / (vol A) quad i in A,
          -1 / (vol (V-A)) quad i in.not A
        )
        $
        显然 $h' <= I(y)/N(y)$，仿照之前的计算得：
        $
        I(x) = "cut"(A)(1/(vol A) + 1/(vol (V-A)))\
        N(x) = min {sum_(i in A) d_i (1/(vol A) + 1/(vol(V - A))), sum_(i in V-A) d_i (1/(vol A) + 1/(vol(V - A)))}
        $
        其中第二式利用了 $N(x)$ 的形式是关于 $c$ 的一元折线函数的和的最小值，取值点恰在在 $"median"(x)$ 之中，而此时 $x$ 只有两值，当然应该是两者之一\
        计算得 $h' <= ("cut"(A))/(min {vol(A), vol(V - A)}) = h$

        现在考虑另一个方向，我们希望得到 $h <= h'$，我们希望仿照 Cheeger 不等式的另一侧

        #lemma[][
          任取 $x in RR^n$，存在一个 $S subset U_plus.minus (x)$，使得：
          $
          ("cut"(S))/("vol"(S)) <= I(x)/N(x)
          $
        ]
        #proof[
          任意取定 $x in RR^n$，不妨设 $x_i in [-1, 1]^n$ \
          对于某个阈值 $t in RR$，令：
          $
          S_t = {i in V | abs(x_i) > t} subset U_plus.minus (x)
          $
          显然 $S_0 = U_plus.minus (x), S_1 = emptyset$\
          只需证明：
          $
          exists t in [0, 1], N(x) "cut" S_t <= I(x) "vol"(x)
          $
          为此，我们证明：
          $
          E (N(x) "cut" S_t - I(x) "vol"(x)) <= 0
          $<target>
          足以说明原式
          - 先计算 $E ("cut" S_t)$，有：
            $
            E ("cut" S_t) &=  E (sum_({i, j} in E) abs(1^t_i - 1^t_j)) "（其中" 1^t "是" S_t "的指示向量）" \
            &= sum_({i, j} in E) E (abs(1^t_i - 1^t_j))  \
            &= sum_({i, j} in E) E (1^t_i - 1^t_j | 1^t_i > 1^t_j) P(1^t_i > 1^t_j) + E (1^t_j - 1^t_i | 1^t_i < 1^t_j) P(1^t_i < 1^t_j)  \
            &= sum_({i, j} in E) E (1^t_i - 1^t_j | 1^t_i > 1^t_j) P(1^t_i > 1^t_j) + E (1^t_j - 1^t_i | 1^t_i < 1^t_j) P(1^t_i < 1^t_j)  \
            $
            注意到 $P(1^t_i > 1^t_j), P(1^t_i < 1^t_j)$ 由 $abs(x_i), abs(x_j)$ 的大小关系决定，且两者至多一个不是零
            - 当 $abs(x_i) = abs(x_j)$ 时，两者同时为零
            - 当 $abs(x_i) < abs(x_j)$ 时，有：
              $
              &E (1^t_i - 1^t_j | 1^t_i > 1^t_j) P(1^t_i > 1^t_j) + E (1^t_j - 1^t_i | 1^t_i < 1^t_j) P(1^t_i < 1^t_j) \
              =& E (1^t_j - 1^t_i | 1^t_i < 1^t_j) P(1^t_i < 1^t_j)\
              =& 1 dot (abs(x_j) - abs(x_i))\
              =&  abs(x_j) - abs(x_i)
              $
            - 类似的，若 $abs(x_i) > abs(x_j)$，则原式等于 $abs(x_i) - abs(x_j)$
            综上，有：
            $
            &sum_({i, j} in E) E (1^t_i - 1^t_j | 1^t_i > 1^t_j) P(1^t_i > 1^t_j) + E (1^t_j - 1^t_i | 1^t_i < 1^t_j) P(1^t_i < 1^t_j)\
            &= sum_({i, j} in E) abs(abs(x_i) - abs(x_j))
            $
          - 再计算 $E ("vol"(x))$，有：
            $
            E ("vol"(x)) = E(sum_(i in V) d_i 1^t_i) = sum_(i in V) d_i E (1^t_i) = sum_(i in V) d_i P(abs(x_i) > t) = sum_(i in V) d_i abs(x_i)
            $
          综上，有：
          $
          E (N(x) "cut" S_t) = (min_(c in RR) sum_(i in V) d_i abs(x_i - c)) (sum_({i, j} in E) abs(abs(x_i) - abs(x_j)))\
          E (I(x) "vol"(x)) = (sum_(i in V) d_i abs(x_i)) (sum_({i, j} in E) abs(x_i - x_j))
          $
          显然有：
          $
          0 <= min_(c in RR) sum_(i in V) d_i abs(x_i - c) <= sum_(i in V) d_i abs(x_i)\
          0 <= sum_({i, j} in E) abs(abs(x_i) - abs(x_j)) <= sum_({i, j} in E) abs(x_i - x_j)
          $
          因此@target 成立！
        ]
        #let h1 = $h'$
        回到目标，设 $x_0$ 可使 $h1$ 取最小的的 $x$，不妨设 $x in [-1, 1]^n$。\
        注意到：
        $
        I(x)/N(x) = (sum_({i, j} in E) abs(x_i - x_j)) / (min_(c in RR) sum_(i in V) d_i abs(x_i - c) )
        $
        上下齐次且分子分母都在平移下保持不变，因此可设 $x in [0,1]^n$\
        取 $c in "median"_d (x)$，将有：
        $
        "vol"({i in V | x_i < c}) <= 1/2 "vol"(V)\
        "vol"({i in V | x_i >= c}) <= 1/2 "vol"(V)
        $
        并设：
        $
        y = x - c
        $
        我们的目标是：
        $
        h1(x) = h1(y) = I(y)/N(y) = (I(y^+) + I(y^-))/(N(y^+) + N(y^-)) >= min(I(y^+)/N(y^+), I(y^-)/N(y^-)) >= h(G)
        $
        其中仅有第三个等号：
        $
        I(y)/N(y) = (I(y^+) + I(y^-))/(N(y^+) + N(y^-))
        $
        并不平凡，我们需要证明：
        - $I(y) = I(y^+) + I(y^-)$
          我们只需要逐项验证：
          - $x_i  x_j >= 0$ 时，$abs(x_i - x_j)$ 恰为 $abs(x_i^+ - x_j^+), abs(x_i^- - x_j^-)$ 其中之一（另一个是零）
          - $x_i x_j < 0$，不妨设 $x_i > 0, x_j < 0$，则：
            $
            abs(x_i - x_j) = abs(x_i) + abs(x_j) = abs(x_i^+ - x_j^+) + abs(x_i^- - x_j^-)
            $
            表明 $abs(x_i - x_j) = abs(x_i^+ - x_j^+) + abs(x_i^- - x_j^-)$ 总是成立
        - $N(y) = N(y^+) + N(y^-)$
          注意到 $0 in "median"_d (y)$ 表明：
          $
          N(y) = sum_(i in V) d_i abs(y_i) = sum_({i in V | y_i >= 0}) d_i abs(y_i) + sum_({i in V | y_i < 0}) d_i abs(y_i) = N(y^+) + N(y^-)
          $
        得证
      ]

       延续 $I(x), N(x)$ 的定义，接下来需要考虑如何解决这个绝对值函数的最优值。我们仍然希望使用拉格朗日乘子法，由于 $I(x)/N(x)$ 齐次，依然只在 $norm(x)_d = sum_i d_i abs(x_i) = 
       1$ 上讨论，更进一步，按照之前的讨论，我们有：
       $
       h(G) = min_(x in pi) I(x), pi = {x | norm(x)_d = 1 and 0 in "median"(x)}
       $
       容易验证 $pi$ 是闭集\
       我们需要处理绝对值，虽然理论上不能求导，但我们可以不严格的求导得到：
       $
       diff I(x) = mu diff norm(x)_d
       $<informallyD>
       为了拓展拉格朗日乘子法，注意到我们在这里处理的函数都是凸的，一元的情形上它单侧导数总存在，且几乎处处可微
       #definition[次梯度][
        设 $f$ 为凸函数，对于任意 $x in X$，定义：
        $
        G = {g in RR^n | forall y in X, f(y) >= f(x) + g^T (y - x)}
        $
        称 $G$ 中所有元素都是 $f$ 在 $x$ 处的某个次梯度，有时也将 $G$ 记作 $diff f$，称为 $f$ 的次梯度\
        当 $f$ 具有一些良好性质时，次梯度是存在（非空）的
       ]
       #proposition[][
        设 $f$ 是开区域 $C$ 上的凸函数：
        - 若于 $x$ 点，可微，则 $diff x = {triangle.b f(x)}$
        - 若 $alpha >0$，则 $diff (alpha x) = alpha diff x$\
        - 设 $g$ 是另一个区域上的凸函数，则：
          $
          diff(f + g) = diff f + diff g
          $
        - 以上两条给出 $diff$ 是（半空间意义下）的线性算子
        - $diff f$  是闭的凸集
        - 设 $f$ 一次齐次，则：
          - 任取 $s in diff f(x)$，将有 $f(x) = s^T x$
          - 任取 $s in diff f(y)$，将有 $f(x) >= s^T x$
        - $diff abs(x) = "Sgn(x)"$，其中：
          $
          "Sgn"(x) = cases(
            {1} quad x> 0,
            {-1} quad x < 0,
            [-1, 1] quad x = 0
          )
          $
       ]
       #lemma[][
          设 $C$ 是开区域，$x$ 是其上的最小值点，则：
          $
          0 in diff f(x)
          $
          反之，若上式成立，则 $x$ 是最小值点
       ]
       在@informallyD 中，等号不应该理解为集合间的相等，而是集合相交非空。计算：
       $
       (diff norm(x))_j = d_j "Sgn"(x_j) := D "Sgn"(x)
       $
       其中 $"Sgn"(x)$ 定义为 $product_i "Sgn"(x_i) in RR^n$（作为子集的外积）\
       对于另一侧，将 $I(x)$ 看作复合函数 $I(x) = norm(B x)_1$，其中 $B$ 是关联矩阵，$norm(x)_1 = sum_i abs(x_i)$ 
       #lemma[][
        设 $h$ 是凸函数，$f$ 是线性函数，则 $h compose f$ 是凸函数
        ]<convexity>
        #proof[
          设定义域为凸集 $X$, 任取 $x, y in X, t in [0, 1]$，计算:
          $
          h(f(t x + (1 - t) y)) = h(t f(x) + (1-t) f(y)) <= t h(f(x)) + (1-t) h(f(y))
          $
          由定义知 $h compose f$ 是凸函数
        ]
       #lemma[][
        若 $A$ 列满秩，有（某种意义上的链式法则）：
        $
        diff f = A^T diff h(A x + b)
        $
       ]
       #proof[
        利用@convexity，这当然是凸函数。为了计算 $diff f(x_0)$，设：
        $
        forall x in RR^n, f(x) - f(x_0) >= g^T (x - x_0)
        $
        上式化简为：
        $
        h(A x + b) - h(A x_0 + b) >= g^T  (x - x_0)
        $<eq1>
        任取 $t in diff h(A x_0 + b)$，有：
        $
        h(y) - h(A x_0 + b) >= t^T (y - A x_0 - b)
        $<eq2>
        - 设 $t  in diff h(A x_0 + b)$，在@eq2 中取 $y = A x + b, g = A^T t$ 即得@eq1 恒成立，进而 $A^T t in diff f(x_0)$，故 $A^T diff h(A x_0 + b) subset diff f(x_0)$
        - 反之，若 $x -> A x + b: RR^m -> RR^n$ 是满射，任取 $g = A^T t in diff f(x_0)$，有：
          $
          forall y = A x + b in RR^m, h(y) - h(A x_0 + b) >= (t^T) (y - A x_0 - b)
          $
          换言之 $t in A^T diff h(A x_0 + b) => diff f(x_0) subset A^T diff h(A x_0 + b)$
        综上，当上述映射是满射（也即 $A$ 列满秩）时，有 $diff f(x_0) = A^T diff h(A x_0 + b)$
       ]
       由引理我们得到：
       $
       diff I(x) = B^T "Sgn"(B x)\
       = {sum_({i, j} in E) z_(i j)(x) | z_(i j) in "Sgn"(x_i - x_j) and z_(i j) = - z_(j i), forall i, j}
       $
       #definition[][
        称 $(u, x)$ 是 $Delta_1-$特征对，如果：
        $
        diff I(x) sect mu D "Sgn"(x) != emptyset
        $
        
       ]
       #theorem[][
          对于任意一组特征对 $mu, x$，存在 $V$ 的子集 $A$ 使得 $mu = "cut"(A)/("vol"(A))$
       ]
       #proof[
          - 设 $x$ 是 $mu$ 的特征向量 ，并且满足有：
          - 保号性 $x_i >= 0 => y_i >=0, x_i <= 0 => y_i <= 0$
          - 保序性：$x_i >= x_j => y_i >= y_j, x_i <= x_j => y_i <= y_j$
          则 $x, y$ 的凸组合将也是特征向量
          由引理，对任意 $x$ 是特征向量，令：
          $
          y_i = cases(
            0 quad x_i <=0,
            1 quad x_i > 0
          )
          $
          由引理得知 $y$ 也是特征向量，令:
          $
          A = {i in V | y_i = 1}
          $
          则取 $v in diff I(y) sect mu D "Sgn"(y)$，将有：
          $
          "cut"(A) = I(y) = v^T y = sum_(i in A) v_i = sum_(i in A) mu d_i = mu "vol"(A)
          $
          （这里运用了 $I(y)$ 一次齐次，因此 $I(y) = v^T y, forall y in diff I(y)$
          证毕
       ]

      接下来考虑如何研究所有的 $mu$，显然由上面的等式可以看出，所有可能的 $mu$ 不多于可能的割的数量，而割当然只有有限个。

      回到之前的最优化问题，我们添加了约束：
      $
      0 in "median"_d (x)
      $
      仿照之前的 $lambda_2$ ，有定理：\
      #theorem[][
        $0 in  "median"_d (x) <=> 0 in sum_(i in V)d_i "Sgn"(x_i)$
      ]
      #proof[
        设 $g(c, x) = sum_(i in V) d_i abs(x_i -c)$，则：
        $
        0 in diff g(0, x) = sum_(i in V) d_i "Sgn"(x_i) <=> c = 0 "是 " g(c, x) "的最小值点" <=> 0 in "median"_d (x) 
        $
      ]        

      容易验证 $(0, arrow(1))$ 成为一个 $Delta_1$ 特征对，从而设 $mu > 0$ 是非零的特征值 $x$ 是一个对应的特征向量，我们希望依次验证：
      - $mu = I(x)$\
        类似的，取 $v in I(x) sect mu D "Sgn"(x)$，有：
        $
        I(x) = v^T x = mu sum_(i in V) d_i "Sgn"(x_i) x_i = mu norm(x)_(1, d) = mu
        $
      - 若 $mu > 0$，则 $0 in sum_(i in V) d_i "Sgn"(x_i)$\
        取：
        $
        v_i = sum_({i, j in E}) z_(i j)(x), z_(i j) = -z_(j i) in  mu d_i "Sgn"(x_i)\
        sum_(i in V) v_i = 0 in sum_(i in V) mu d_i "Sgn"(x_i)
        $
        若 $mu != 0$，则上式表明 $0 in sum_(i in V)  d_i "Sgn"(x_i) $
      - $h(G)$ 确实是特征值\
        这里注意到 $pi = {x in RR^n|0 in "median"_d (x) and norm(x)_(1, d) =1}$ 是有界闭集，也是紧集，连续函数在紧集上当然可以取得最小值，前面已经证明了最小值就是 $h(G)$，因此可以 $x in pi$  使得 $I(x) = h(G)$
        由 $0 in "median"_d (x)$ 知可以取得 $v in diff norm(x)_(1, d)$ 使得 $v^T 1 = 0$\
        往证：$forall y in RR^n, I(y) - h(G) v^T y >= 0 = I(x) - h(G) norm(x)_(1, d)$
        - 如若不然，设 $y$ 使得上式不成立，令：
          $
          y' = y - alpha 1, alpha in "median"_d (x)\
          y'' = y'/(norm(y)_(1, d)) in pi
          $
          注意到：
          $
          I(y'') - h(G) v^T y'' &= 1/(norm(y)_(1, d)) (I(y')-h(G)v^T y') \
          &= 1/(norm(y)_(1, d)) (I(y - alpha 1)-h(G)v^T (y - alpha 1))\
          &= 1/(norm(y)_(1, d)) (I(y)-h(G)v^T y) < 0
          $
          表明 $I(y'') < h(G) v^T y <= h(G) norm(y)_(1,d) = h(G)$，注意到 $y in pi$，矛盾！\
          （这里利用了若 $f(x)$ 是一次齐次的凸函数，则 $f(y) >= v^T y, v in diff f(x)$）

        因此，我们有 $0 in diff(I(x) - h(G) v^T x) = diff I(x) - h(G) v subset diff I(x) - h(G) diff norm(x)_(1, d) $\
        上式即说明 $h(G), x$ 是一个特征对，证毕
  == 从 cheeger 问题到最大割
    或许我们会想用类似的思路解决最大割问题，然而稍加尝试便可发现，最大割问题将是在求凸函数的最大值，这使得我们用过的许多性质不再成立。类似的对 $p in{1, 2}$，（这个 $p$ 并不重要，只是和之前的结果统一）定义：
    $
    I_p (x) = sum_({i, j} in E) abs(x_i -x_j)^p\
    norm(x)_p = max abs(x_i)^p
    $
    类似于之前的两值向量，希望取 $x in {-1, 1}^n$ 模拟凸函数的最大值问题（它总是应该在边界处取得）\
    注意到：
    $
    h_(max) (G) = max_(x in {0, 1}^n, x != 0) (I_p (x))/(2^(p-1)  "vol"V )
    $

    #theorem[][
      $
      h_(max)(G) = max_(x != 0) (I_p (x))/(2^(p-1) norm(x) "vol"V )
      $
    ]
    #proof[
      #lemma[][
        凸函数在有界闭凸集内的最大值可以在边界处取得
      ]
      #proof[
        如若不然，设 $x_0 in X$ 是凸函数 $f$ 在有界闭凸集 $X$ 内的最大值点，而 $x_0$ 不在 $X$ 的边界上，并且：
        $
        f(diff X) subset (-infinity, f(x_0))
        $
        此时 $x_0$ 是内点，不妨任取一个方向向量 $v$ 可设：
        $
        h(t) = x_0 + t v\
        T = {t in [-infinity, +infinity] |h(t) subset X} = Inv(h)(X)
        $
        显然 $T$ 是闭集（由 $h$ 连续性）且有界（否则 $X$ 无界），因此可取：
        $
        t_0 = cases(
          sup T quad abs(sup T) < abs(inf T),
          inf T quad abs(sup T) >= abs(inf T)
        )
        $
        这是为了保证 $x_0 plus.minus t v in X$，由凸性有：
        $
        1/2 (f(x_0 + t_0 v) + f(x_0 - t_0 v)) >= f(x_0)
        $
        注意到 $x_0$ 已经是最大值点，因此一定有：
        $
        f(x_0 + t_0 v) = f(x_0 - t_0 v) = f(x_0)
        $
        但 $x_0 plus.minus t v$ 至少有一个在边界上，矛盾！
      ]
      回到目标，注意到：
      $
      f(x) = (I_p (x))/(2^(p-1) norm(x) "vol" V)
      $
      是齐次函数，因此：
      $
      max_(x in RR - {0} ) f(x)&= max_(abs(x) = 1) (I_p (x))/(2^(p-1) norm(x) "vol" V) \
      &= max_(abs(x) = 1) (I_p (x))/(2^(p-1) "vol" V)\
      &= 1/(2^(p-1) "vol" V) max_(abs(x) = 1) I_p (x)\
      &= 1/(2^(p-1) "vol" V) max {max_(x in [-1, 1]^n quo [-1, 1]) I_p (x)|_(x_i = 1) | i in 1, 2, 3, ...,n}\
      $
      这里 $max_(x in [-1, 1]^n quo [-1, 1]) I_p (x)|_(x_i = 1)$ 就是如下的最大值问题：
      $
      max_(x' in [-1, 1]^(n-1)) I'(x')
      $
      由引理，它的最大值应该在边界处取得，也即至少一个 $x_i = 1$，进而：
      $
      max_(x' in [-1, 1]^(n-1)) I'(x') = max {max_(x' in [-1, 1]^(n-1) quo [-1, 1]) I' (x')|_(x_i = 1) | i in 1, 2, 3, ..., n-1}
      $
      归纳进行即得最大值 $I_p (x)$ 的最大值点 $x_0 in {-1, 1}^n$，因此：
      $
      max_(x in RR - {0} ) f(x)= max_(x in {-1, 1}^n)f(x)
      $<eq11>
      另一方面，容易计算得到：
      $
      h_(max) (G) = max_(x in {0, 1}^n) (I_p (x))/("vol" V) 
      $
      定义一一映射：
      $
      phi: {0, 1} &<-> {-1,1}\
      0 &<-> -1\
      1 &<-> 1
      $
      将其广播得到的一一映射映射 ${0, 1}^n <-> {-1,1}^n$ 也记作 $phi$，容易验证：
      $
      I_p (x) = 1/2^(p-1) I_p (phi(x))
      $
      进而有：
      $
      max_(x in {0, 1}^n) (I_p (x))/("vol" V) = max_(phi(x) in {-1, 1}^n) (I_p (x))/("vol" V) = max_(phi(x) in {-1, 1}^n) (I_p (phi(x)))/(2^(p-1) "vol" V)
      $
      将 $phi(x)$ 换成 $x$ 结合@eq11 即得结论成立
    ]
    然而凸函数在凸区域的上的最大值问题并不容易，上面的证明本质上只有形式上的意义，丝毫没有减少求最大值的困难。
  == Lovasz 延拓
    回顾之前的过程，我们发现我们总是在将一个离散的最值问题延拓到连续区间，变成连续的优化问题。更加广泛地说，我们发现解决连续的问题往往比解决离散的问题更加简单，因此当然希望能把离散的问题延拓到连续的问题进行求解。
    
    显然，对于任何一个离散最优化问题，我们可以找到无穷个连续曲线使得它们有相同的最优解。而给出一个具体的并不容易，本节就给出了一种具体的方法
    #let absSigmaI(i) = $abs(x_sigma(#i))$
    #let fL = $f^L$
    #definition[Lovasz 延拓][
      $forall x in RR^n, sigma: V union {0} -> V union {0}$ 使得 $abs(x_(sigma(i))) <= abs(x_sigma(i+1) ) $\
      约定：
      $
      sigma(0) = 0\
      x_(sigma(0)) = 0
      $
      对于 $i in {0, 1, 2..., n}$ 定义如下集合：
      $
      V_(sigma(i))^plus.minus = {j in V | plus.minus x_j > abs(x_(sigma(i)))}
      $
      对于任给的函数：
      $
      f: P_2 (V) -> RR
      $
      其中 $P_2 (V) = {(a, b) in V times V | a sect b = emptyset}$\
      称其 Lovasz 延拓为：
      $
      f^L (x) = sum_(i=0)^(n-1) (abs(x_(sigma(i+1))) - abs(x_(sigma(i)))) f(V_(sigma(i))^plus, V_(sigma(i))^minus)
      $
    ]
    #example[][
      对于 $(A, B) in P_2 (V) - {(emptyset, emptyset)}$，定义：
        $
        1_(A, B) = 1_A - 1_B in {-1, 0, 1}^n
        $
        则：
        $
        f^L (1_(A, B)) = (1 - 0)f(V_sigma(i)^+, V_sigma(i+1)^-)
        $
        其中 $sigma(i) = 0, abs(sigma(i+1)) = 1$\
        从而：
        $
        V_sigma(i)^+ = {j in V| x_j > 0} = A\
        V_sigma(i)^- = {j in V| x_j < 0} = B
        $
        进而 $f^L (1_(A, B)) = f(A, B)$
    ]
    #proposition[][
      - 设 $f: P_2 (V) -> RR$ 满足 $f(emptyset, emptyset)$，则有：
        $
        forall (A, B) in P_2 (V), f^L (1_(A, B)) = f(A, B)
        $
      - Lovasz 延拓有积分表示，也即：
        $
        f^L (x) = integral_0^(norm(x)_infinity) f(V_t^+ (x), V_t^- (x)) dif t
        $
        其中 $V_t^(plus.minus) (x) = {i in V | plus,minus x_i > t}$\
        这给出 $f^L$ 是连续函数，事实上被积函数是分段常函数
      - $forall alpha > 0, f^L (alpha x) = alpha f^L (x)$
    ]
    #proof[
      - 只是在上面的计算中补充了平凡情况
      - 当 $absSigmaI(i) < t < absSigmaI(i+1)$ 时，有：
        $
        V_t^+ (x) = V_(sigma(i))^+\
        V_t^- (x) = V_(sigma(i))^-
        $
        从而：
        $
        f^L (x) &= sum_(i=0)^(n-1) (abs(x_(sigma(i+1))) - abs(x_(sigma(i)))) f(V_(sigma(i))^plus, V_(sigma(i))^minus) \
        &= sum_(i=0)^(n-1)integral_(absSigmaI(i))^(absSigmaI(i+1)) f(V_t^+ (x), V_t^- (x)) dif t\
        &= integral_0^(norm(x)_infinity) f(V_t^+ (x), V_t^- (x)) dif t
        $
        证毕
      - 做积分变换即可
    ]
    #theorem[Lovasz 延拓][
      设 $f, g: P_2 (V) -> [0, +infinity]$，且对任意 $(A, B) in P_2 (V) - {(emptyset, emptyset)}$ 有 $g(A, B) > 0$，则我们有：
      $
      min_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = min_(x in RR^n - {0}) (f^L (x))/(g^L (x))\
      max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = max_(x in RR^n - {0}) (f^L (x))/(g^L (x))
      $
    ]
    #proof[
      + 先证明最小值形式，最大值形式同理可得
        - 首先要证明右侧的最小值存在。事实上前面证明了 $f^L, g^L$ 是一次齐次的连续函数，因此可以在任何一个有界闭集上取得最小值，例如 ${x | norm(x) = 1}$，其上的最小值也是它在整个定义域上的最小值
        - 其次，显然有：
          $
          min_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = min_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f^L (1_(A, B)))/(g^L (1_(A, B))) >= min_(x in RR^n - {0}) (f^L (x))/(g^L (x))
          $
          因此只要证明另一侧不等式
        - 任取 $x !=0 $:
          $
          (f^L (x))/(g^L (x)) = (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i)))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) 
          $
          注意到我们总可以取得 $(C, D) in P_2 (V)$ 使得：
          $
          (f(C, D))/(g(C, D)) = min_(0<= i <= n-1) (f(V^+_(sigma(i)), V^-_(sigma(i)))) /(g(V^+_(sigma(i)), V^-_(sigma(i))))
          $
          有：
          $
          &(f^L (x))/(g^L (x)) - (f(C, D))/(g(C, D))  \
            &=
            (
              sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i)))
               - 
              (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) (f(C, D))/(g(C, D)))
               /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i))))
              \
              &>= (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i))) 
              - 
              (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) (f(V^+_(sigma(i)), V^-_(sigma(i))))/(g(V^+_(sigma(i)), V^-_(sigma(i)))))
             /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i))))\
            &= 0
          $
          因此 
          $
          min_(x in RR^n - {0}) (f^L (x))/(g^L (x)) >= (f(C, D))/(g(C, D)) >= min_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B))
          $
          证毕
    ]
    我们得到了很强的结论，但是会发现最大割问题或者 Cheeger 问题要求集对是图割而不是一般的集对，因此必须使用下面的引理进行处理
    #lemma[][
      设 $f, g: P(V) -> [0, +infinity]$ 是对称的函数，也即：
      $
      f(A) = f(V - A)\
      g(A) = g(V - A)
      $
      且满足 $g > 0$\
      记：
      $
      F(A, B) = f(A) + f(B)\
      G(A, B) = g(A) + g(B)
      $
      则：
      $
      min_(A in P(V)) (f(A))/(g(A)) = min_((A, B) in P_2 (V)) (F(A, B))/(G(A, B))\
      $
      最大值形式也对
    ]
    #proof[
      以最小值形式为例，设 $(A_0, B_0)$ 使得上式右侧取得最小值，不妨设：
      $
      (f(A_0))/(g(A_0)) <= (f(B_0))/(g(B_0))
      $
      于是：
      $
      (f(A_0) + f(B_0))/(g(A_0) + g(B_0)) - (f(A_0))/(g(A_0)) = (f(B_0) -(f(A_0))/(g(A_0))g(B_0))/(g(A_0) + g(B_0))  >= 0
      $
      给出：
      $
      min_((A, B) in P_2 (V)) (F(A, B))/(G(A, B)) = (f(A_0) + f(B_0))/(g(A_0) + g(B_0)) >= (f(A_0))/(g(A_0)) >= min_(A in P(V)) (f(A))/(g(A))
      $
      另一侧也是类似的
    ]
    #example[][
      对于最大割问题，可设：
      $
      f(A) = "cut"(A)\
      g(A) = 1/2 "vol"(A)
      $
      则：
      $
      h_(max)(G) = max_(A in P(V)) (f(A))/(g(A)) = max_((A, B) in P_2 (V)) (F(A, B))/(G(A, B)) = max_((A, B) in P_2 (V)) ("cut"(A) + "cut"(B))/("vol"(A))
      $
      只需计算：
      $
      F^L (x) &= integral_0^(norm(x)_infinity) ("cut"(V_t^+ (x)) + "cut"(V_t^- (x))) dif t\
      &= integral_0^(norm(x)_infinity) "cut"(V_t^+ (x)) dif t + integral_0^(norm(x)_infinity)  "cut"(V_t^- (x)) dif t\
      &= sum_({i, j} in E) integral_0^(norm(x)_infinity) chi_{x_j <= t < x_i} (t) + chi_{x_i <= t < x_j} (t) dif t \ &+ integral_0^(norm(x)_infinity) chi_{x_j <= -t < x_i} (t) + chi_{x_i <= -t < x_j} (t) dif t\ 
      &"（注意这里积分可以改变有限个点值，因此正负号无所谓）"\
      &= sum_({i, j} in E) integral_0^(norm(x)_infinity) chi_{x_j <= t < x_i} (t) + chi_{x_i <= t < x_j} (t) dif t \ &+ integral_(-norm(x)_infinity)^(0) chi_{x_j <= t < x_i} (t) + chi_{x_i <= t < x_j} (t) dif t\ 
      &= sum_({i, j} in E) integral_(-norm(x)_infinity)^(norm(x)_infinity) chi_{x_j <= t < x_i} (t) + chi_{x_i <= t < x_j} (t) dif t \
      &= sum_({i, j} in E) abs(x_i - x_j)\
      G^L (x) &= integral_0^(norm(x)_infinity) "vol"(V) dif t = "vol"(V) norm(x)_infinity
      $
      这就可以得到和之前一致的结论

      对于 cheeger 问题，会这里有些小问题，如果允许 $x = 0, 1$，则可能出现 $0/0$ 的问题，我们需要修改一下定理，利用：
      #corollary[][
        设 $f, g: P_2(V) -> [0, +infinity]$ 是集对函数，并且满足：
        $
        f(emptyset, V) = f(V, emptyset) = 0
        $
        记：
        $
        P'_2(V) = P_2(V) - {(emptyset, V), (V, emptyset), (emptyset, emptyset)}
        $
        若 $g(x) > 0, forall x in P'_2(V)$
        则：
        $
        min_((A, B) in P'_2 (V)) (f(A, B))/(g(A, B)) = min_(x in RR^n - {0, 1}) (f^L (x))/(g^L (x))\
        $
        最大值形式也对
      ]
      回到具体的计算，与上面的例子相比分子是一样的，只对：
      $
      G (x) = min {vol(A), vol(V - A)} + min {vol(B), vol(V - B)}
      $
      进行计算：
      $
      G^L (x) &= integral_(0)^(norm(x)) min {vol(A), vol(V - A)} + min {vol(B), vol(V - B)} dif t\
      &= integral_(0)^(norm(x)) min {vol(V_t^+), vol(V - V_t^+)} + min {vol(V_t^-), vol(V - V_t^-)} dif t\
      &= integral_(-norm(x))^(norm(x)) min {vol(V_t^+), vol(V - V_t^+)} dif t\
      $
      取 $sigma in S_n$ 使得：
      $
      x_(sigma(1)) <= x_(sigma(2)) <= ... <= x_(sigma(n))
      $
      则一定存在 $k_0$ （中位数）使得：
      $
      sum_(i=1)^(k_0 - 1) d_(sigma(i)) < 1/2 "vol" V <= sum_(i=1)^(k_0) d_(sigma(i)) 
      $
      则有：
      $
      min {vol(V_t^+), vol(V - V_t^+)} = cases(
        vol(V - V_t^+) quad t < x_(sigma(k_0)),
        vol(V_t^+) quad t >= x_(sigma(k_0))
      )
      $
      原式化为：
      $
      &quad integral_(-norm(x))^(norm(x)) min {vol(V_t^+), vol(V - V_t^+)} dif t\
      &= integral_(-norm(x))^(x_(sigma(k_0))) vol(V - V_t^+) dif t + integral_(x_(sigma(k_0)))^(norm(x)) vol(V_t^+) dif t\
      &= sum_(i=1)^(k_0 - 1) (x_sigma(i+1) - x_(sigma(i))) sum_(j=1)^i d_(sigma(i)) + sum_(i=k_0)^(n - 1) (x_sigma(i+1) - x_(sigma(i))) sum_(j=i+1)^n d_(sigma(i))\
      &"（利用阿贝尔变换）"\
      &= sum_(i=1)^(k_0 - 1) d_(sigma(i)) (x_sigma(k_0) - x_sigma(i) ) + sum_(i=k_0 + 1)^(n - 1) d_(sigma(i)) (x_sigma(i) - x_sigma(k_0) )\
      &= sum_(i=1)^(n_1) d_(sigma(i)) abs(x_sigma(k_0) - x_sigma(i) ) \
      $
      使用 @median-min，注意到 $k_0$ 是一个中位数，上式恰为：
      $
      min_(c in RR) sum_(i=1)^n d_i abs(x_i - c)
      $

      
    ]
  == 图模型算法简介
    本节我们给出一些近似算法。以最大割问题为例，前面已经证明答案就是：
    $
    h_(max) (G) = max_(x in RR^n - {0}) I(x)/(norm(x) vol V)
    $
    我们发现比例式的形式颇为常见，往往将这种问题称为 分式规划|fractional programming
    #theorem[Dinkerbach 迭代][
      设 $A$ 是紧集，$P, Q$ 是连续函数，针对分式规划问题：
      $
      max_(x in A) P(x)/Q(x)
      $
      可以构造迭代
      $
      cases(
        x^(k+1) = argmin_(x in A) {Q(x) y^k - P(x) },
        y^(k+1) = P(x^(k+1))/Q(x^(k+1))
      )
      $
      - 述迭代产生的序列 ${y^k}$ 单调递增
      - 若原问题有最优值，则上述迭代产生的序列收敛于原问题的解
    ]
    #example[][
      对于最大割问题迭代方法是：
      $
      cases(
        x^(k+1) = argmin_(norm(x) = 1) {r^k norm(x) vol V - I(x)},
        r^(k+1) = I(x^(k+1))/(norm(x^(k+1)) vol V)
      )
      $
      则对任意初始点 $x_0$ 满足 $norm(x_0) = 1$，上述迭代产生的序列 ${r^k}$ 单调递增，且收敛于原问题的解。\
      然而对于该问题，由于迭代过程本身也有难解的优化问题，我们需要进一步采用所谓的*次梯度下降*，问题变成：
      $
      cases(
        x^(k+1) = argmin_(norm(x) = 1) {r^k norm(x) vol V - s^(k) dot x},
        r^(k+1) = I(x^(k+1))/(norm(x^(k+1)) vol V),
        s^(k+1) in partial I(x^(k+1))
      )
      $
      虽然如何选取次梯度以及收敛性更为困难，但至少它在计算上已经没有了困难。

      事实上，我们可以证明 $r^k$ 仍然单调，但未必能收敛到原问题的最优解。如果次梯度选取恰当，它可以收敛到原问题的局部最优解。在此不会证明这些结果。
    ]
    #proof[
      注意到：
      $
      r^k norm(x^(k+1)) vol V - I(x^(k+1)) <= r^k norm(x^k) vol V - I(x^k) = 0\
      r^k <= I(x^(k+1))/(norm(x^(k+1)) vol V) = r^(k+1)
      $
      注意到最大割问题的解 $r_(max)$ 存在，且每个 $r_n$ 都不超过 $r_(max)$，因此序列单调有上界，进而有极限 $r <= r_(max)$\
      同时，设 $x_0$ 是取得原问题最大值的点，将有：
      $
      r^n norm(x^(n+1)) vol V - I(x^(n+1)) <= r^n norm(x_0) vol V - I(x_0)
      $
      注意到 $x^n$ 是紧集上的序列，可取其一个收敛子列，不妨设它本身就收敛，上式取极限即得：
      $
      r >= r_(max)
      $
      或者定义 $f(r) = min_(norm(x) = 1) {r norm(x) - I(x)} in C(RR)$，计算得：
      $
      f(r^k) = norm(x) (r^k - r^(k+1))
      $
      取极限的 $f(r) = 0$，进而 $r norm(x_0) - I(x_0) >= 0 => r >= r_(max)$，得证
    ]

    这是使用 $norm(x)_1 = max_(i) abs(x_i)$ 的结果，但已有的结果更多是使用 $norm(x)_2 = max_i x_i^2$，也就是要解最优化问题：
    $
    max_(x in {-1, 1}^n)  1/8sum_(i, j in V) w_(i j) (x_i - x_j)^2 where w_(i j) = 1 "if" (i, j) in E "else" 0
    $
    上式化为：
    $
    max_(x in {-1, 1}^n)  1/4 sum_(i, j in V) w_(i j) (1 - x_i x_j) := P_1
    $
    简化一下，只需要：
    $
    min_(x in {-1, 1}^n) sum_(i, j in V) w_(i j) x_i x_j\
    <=> min sum_(i, j in V) w_(i j) x_i x_j with abs(x_i) = 1 := P_2\
    $
    令 $X = x x^T$，将问题转化为
    $
    min inner(W, X) with "rank"(X) = 1, X_(i i) = 1, X >= 0 := P_3
    $
    #lemma[][
      $P_2, P_3$ 两个问题是等价的
    ]
    解决半正定矩阵空间上最优化问题的学科称为 SDP(semi-definite programming)，由于半正定矩阵空间是凸的，这本质是凸优化问题，有很多成熟的结论。然而秩 1 的要求是很困难的，因此有下面的松弛形式（往往称为秩 2 松弛）：
    $
    min inner(W, X) with "rank"(X) <= 2, X_(i i) = 1, X >= 0 := P_6\
    <=>^(X = V^T V) min sum_(i j) w_(i j) inner(v_i, v_j)  with inner(v_i, v_j) = 1, v_i in SS^1 := P_7\
    where SS^1 = {(x, y) in RR^2 | x^2 + y^2 < 1}
    $
    再用参数表示 $SS^1$，经计算可得：
    $
    min_(theta in RR^n) sum_(i, j) w_(i j) cos(theta_i - theta_j) := P_8
    $
    这种算法称为 Circut，不过我们还面临如下问题：
    + 如何计算上面的最优化
    + 如何从上面的问题回到最初的 cut
    + $P_8$ 的解与 $P_3$ 的解有什么关系
    这已经是非常前沿的问题，这里不再赘述。这种算法的误差很好，但是计算量大，主要问题还没有非常快的方法解决 $P_8$ 

    回到之前的 $P_3$，还有更激进的方法是在 $P_3$ 中放弃秩 1 的要求，放弃后的最优化问题称为 $P_4$。这种算法是所谓的 Goemans-Williamson (G-W) 算法，问题转化为了标准的 SDP 问题，已经是多项式内可解。

    假设 $P_4$ 的最优值点是 $X^*$，反推代回原问题可以得到最大割问题的一个近似解 $Z_("SDP")$，我们还要面临如何恢复 cut 以及近似解的估计问题，G-W 算法采取的策略是
    - 首先将 $X^*$ 分解为 $u^T u$，再设 $u$ 的列向量组为 $u_i$。注意到由约束条件，$u_i in SS^(n-1)$，为了将其恢复到 ${-1, 1}$ 上，以均匀分布在 $SS^(n-1)$ 上随机选择 $a in SS^(n-1)$，再令 $u_i$ 取 $a, -a$ 中夹角为锐角的一方 $u'_i$（也就是以 $a$ 为轴分成两个半球，取 $u_i$ 在的一方），最后取 $x_i := u'_i / a$ 
    - 计算这个 $X$ 对应的割值，记为 $z$
    #theorem[][
      $
      E z >= alpha h_(max "cut") where alpha = min_(theta in [0, pi]) {2/pi theta/(1 - cos theta)} approx 0.879 
      $
    ]
    #proof[
      $
      E z &= E (sum_(i < j) 1/2(1- x_i x_j) w_(i j))\
          &= 1/2 sum_(i < j) w_(i j) E (1 - x_i x_j)\
          &= 1/2 sum_(i < j) w_(i j) (0 P(x_i x_j = 1) + 2 P(x_i x_j = -1 ))\
          &= sum_(i < j) w_(i j) P(x_i x_j = -1 )\
      $
      #lemma1[
        $P(x_i x_j = -1 ) = theta/pi$，其中 $theta$ 是 $u_i, u_j$ 夹角中的锐角
      ]
      #proof[
        考虑 $0, u_i, u_j$  构成的平面，在该平面做 $a$ 的垂线 $v$ 。由构造过程，$x_i x_j = -1$ 意味着直线 $v$ 穿过 $x_i, x_j$ 的夹角之内。由对称性直线的角度在圆盘上均匀分布，因此这个概率就是 $theta/pi$
      ]
      由引理，继续化简可得：
      $
      E z &= E (sum_(i < j) 1/2(1- x_i x_j) w_(i j))\
          &= sum_(i < j) w_(i j) P(x_i x_j = -1 )\
          &= 1/pi sum_(i < j) w_(i j) theta_(i j)\
      $
      取：
      $
      alpha = min_(theta in [0, pi]) {2/pi theta/(1 - cos theta)}
      $
      则有：
      $
      theta/pi >= alpha/2 (1- cos theta)
      $
      从而：
      $
      1/pi sum_(i < j) w_(i j) theta_(i j) &>= alpha/2 sum_(i < j) w_(i j) (1 - cos theta_(i j)) \
      &= alpha/2 sum_(i < j) w_(i j) (1 - u_i^T u_j) \
      &= alpha/4 sum_(i, j in V) w_(i j) (1 - u_i^T u_j) \
      $
      回顾上面的松弛过程，应当有：
      $
      sum_(i, j in V) w_(i j) u_i^T u_j &= inner(W, X) \
      &<=  min inner(W, X) "with" "rank"(X) = 1, X_(i i) = 1. X >= 0\
      &= min_(x in {-1, 1}^n) sum_(i, j in V) w_(i j) x_i x_j\
      $
      因此：
      $
      &quad alpha/4 sum_(i, j in V) w_(i j) (1 - u_i^T u_j)\
      &= alpha/4 sum_(i, j in V) w_(i j)  - alpha/4 sum_(i, j in V) w_(i j) u_i^T u_j\
      &>= alpha/4 sum_(i, j in V) w_(i j)  - alpha/4 min_(x in {-1, 1}^n) sum_(i, j in V) w_(i j) x_i x_j\
      &= alpha/4 max_(x in {-1, 1}^n) sum_(i, j in V) w_(i j) (1 - x_i x_j)\
      &= alpha/4 sum_(i, j in V) w_(i j) (1 - x_i x_j)\
      &= alpha h_(max "cut")
      $
    ]

    然而，这个算法的实际表现往往不如一些简单的启发式算法，只不过它作为有理论保证的算法具有重要意义。  
= 高维模型
  高维模型往往追求精度与效率的平衡
  == 傅里叶级数
    对于可积函数 $f(x)$，可以写出形式傅里叶级数：
    $
    f(x) &tilde a_0/2 + sum_(n=1)^infinity (a_n cos(n pi x) + b_n sin(n pi x)) \
    where
    &a_n = integral_(-pi)^pi f(x) cos(n x) dif x\
    &b_n = integral_(-pi)^pi f(x) sin(n x) dif x
    $
    它当然未必取等。由分析学的知识，我们接下来的讨论都在 $L^2$ 空间中进行，可以保证取得等号。\
    傅里叶技术有更常用的复形式，也称之为平面波形式。将 $e^(i x) = cos x + i sin x$ 代入上面的级数，在收敛性较好的情况下可以重排，得到：
    $
    a_0/2 + sum_(n=1)^infinity (a_n cos(n pi x) + b_n sin(n pi x))  = sum_(n = -infinity)^(infinity) c_n e^(n x i)
    $
    （注意最后一个求和是主值意义下的极限也即 $lim_(N -> +infinity) sum_(n = -N)^(N) c_n e^(n x i)$）\
    其中：
    $
    c_n = cases(
      (a_n - i b_n)/2 quad n>=0,
      (a_(n) + i b_(n))/2 quad  n<0
    )
    $\

    注意到$sin n x \/ cos n x \/ e^(i n x)$ 都是周期函数，周期为 $(2 pi )/n$，换言之 $n$ 恰好是其对应的频率。因此在实际应用中往往会将 $n$ 看作频率。在复形式的求和式中，$n >= 0$ 的部分称为正频，$n < 0$ 的部分称为负频，它们往往都很关键，往往应该对称考虑而不能只考虑一部分。
    
  == 函数空间与傅里叶变换
    令 $E([-pi, pi])$ 为 $(-pi, pi]$ 上所有复值连续函数构成的线性空间：
    $
    E([-pi, pi]) = {f(x) + i g(x) | f, g in C([-pi, pi])}
    $ 
    并且定义复内积：
    $
    (f, g) = integral_(-pi)^pi f(x) overline(g(x))  dif x
    $
    易知 ${1/sqrt(2 pi ) e^(i n x) | n in ZZ}$ 构成一组标准正交基，进而函数 $f$ 的傅里叶系数 $c_n$ 满足：
    $
    c_n sqrt(2 pi) = (f, 1/sqrt(2 pi) e^(i n x)) => c_n = 1/(2 pi) (f, e^(i n x))
    $
    一般的，对函数在区间 $[-l, l]$ 上做 $2l$ 为傅里叶展开的结果是：
    $
    f(x) = sum_(n = -infinity)^(infinity) c_n e^(i omega_n x)\
    where &c_n = 1/(2 l) (f, e^(i omega_n x))\
          &omega_n = (n pi)/l
    $<fourier-discrete>
    往往认为 $triangle.t omega_n = omega_n - omega_(n-1) = pi/l$ 是频谱上最小的区分间隔，计算发现：
    $
    f(x) = 1/(2 pi) sum_(n = -infinity)^(infinity) triangle.t omega_n integral_(-l)^(l) f(t) e^(i omega_n (x- t)) dif t
    $
    不严格地说，令 $l -> +infinity$，上式几乎化为：
    $
    f(x) = 1/(2 pi) integral_(-infinity)^infinity dif omega integral_(-infinity)^(infinity) f(t) e^(i omega (x- t)) dif t
    $<fourier-continuous>
    在实际应用中，$[-l, l]$ 往往代表了输入信号的时间。假如输入更长的时间，采用更高的频率分辨率，可以想象估计得到的函数将会更加准确，这就是上面式子的含义，进而引出了下面的傅里叶变换。
    #definition[傅里叶变换][
      设 $f in E(RR)$，则称：
      $
      fourierTrans(f)(omega) = 1/sqrt(2 pi) integral_(-infinity)^(infinity) f(x) e^(-i omega x) dif x
      $
      为傅里叶变换，对应的还有傅里叶逆变换：
      $
      f(x) = 1/sqrt(2 pi) integral_(-infinity)^(infinity) fourierTrans(f)(omega) e^(i omega x) dif omega
      $
      以上两个积分都是主值意义下的无穷积分，具体的存在性/收敛性和两者互逆的条件这里不作说明，至少在比较良好的条件下这是成立的。
    ]
    #remark[][
      在@fourier-discrete 中，系数 $c_n$ 的衰减速度可以表现有限截断的误差，同时也在 $fourierTrans(f)$ 中体现为在无穷处的衰减速度（事实上，如果衰减过慢，可能导致 $fourierTrans(f)$ 的逆变换不存在）。一些较为复杂的分析表明，这个衰减速度与 $f$ 的光滑性有密切的关系，光滑性越好，衰减速度越快。
    ]
  == 谱方法
    在更加现实的问题中，我们往往不知道 $u(x)$ 的所有值，只知道它在个别点的值，因此如何构造一个谱逼近是一个十分经典的问题。假设总共有 $N$ 个点，均匀采样自然是最简单的方法，令：
    $
    x_j = j (2 pi)/N, j = 0, 1, 2, ..., N - 1\
    u_j = u(x_j)
    $
    #let (hu, tu) = ($hat(u)$, $tilde(u)$)
    目标是逼近：
    $
    hu_k = 1/(2 pi) integral_(0)^(2 pi ) u(x) e^(-i k x) dif x 
    $
    最简单的想法当然是用黎曼和，用：
    $
    tu_k := 1/N sum_(j = 0)^(N - 1) u_j e^(-i k x_j)
    $
    最后函数的估计式是：
    $
    u(x) approx sum_(k = -A)^(A) tu_k e^(i k x)
    $
    自然我们需要解决：
    - 最多能确定多少 $A$\
      当然了，有限个点总不能区分比较接近的原函数，这种现象称为混淆。\
      事实上，容易验证 $tu_(k+N) = tu_k$，表明约 $A = N/2$ 是较好的选择。继而，我们得到的逼近空间是：
      $
      g_N = {sum_(i = -N/2)^(N/2) tu_k e^(i k x) | tu_(N/2) = tu_(-N/2)}
      $ 
      同时，应该处理一下边界情况，实际使用：
      $
      tu_k := 1/N 1/c_k sum_(j = 0)^(N - 1) u_j e^(-i k x_j)\
      c_k = cases(
        2 quad k = N/2,
        1 quad "else"
      )
      $
      计算上面的系数，效果更好
    - 逼近的效果如何：\
      令：
      $
      I_N (u: L^2(omega)) = x: omega -> sum_(k = -N/2)^(N/2) tu_k e^(i k x)  
      $
      #theorem[][
        $
        I_N (u)(x_j) = u(x_j)
        $
      ]
      #proof[
        #definition[Dirichlet 核][
          $
          D_N (x) = sum_(k=-N)^N e^(i k x) = (e^(-i N x)(1 - e^((2 N + 1) i x)))/(1 - e^(i x))\
          = (e^(i (N+1/2) x) - e^(- i (N + 1/2) x))/(e^(1/2 x) - e^(-1/2 x))\
          = sin((N + 1/2) x)/sin(x/2) 
          $
        ]
        计算可得：
        $
        sum_(k = - N/2)^(N/2) hu_k e^(i k x) = 1/(2 pi) integral_(0)^(2 pi) D_(N/2)(x-tau) hu(tau) dif tau
        $
        进而：
        $
        I_N (u)(x) = sum_(k = - N/2)^(N/2) (1/N 1/c_k sum_(j=0)^(N-1) u_j e^(-i k x_j)) e^(i k x_j)\
        = 1/N sum_(j=0)^(N-1) u_j sum_(k = - N/2)^(N/2) 1/c_k e^(i k (x - x_j))\
        = 1/N sum_(j=0)^(N-1) u_j D_(N/2 - 1)(x - x_j) +1/2 e^(i N/2 (x - x_j)) + 1/2 e^(-i N/2 (x - x_j))\
        = 1/N sum_(j=0)^(N-1) u_j (sin ((N-1) (x-x_j)/2))/ (sin (x-x_j)/2) + cos (N (x-x_j)/2)\
        = 1/N sum_(j=0)^(N-1) u_j sin(N (x-x_j)/2) cot ((x-x_j)/2) \
        $
        代入 $x_j$ 取极限即可
      ]
      因此，称上面的 $I$ 为插值算子

      更进一步，可以进一步求导数构造导数的逼近。当然有两种求导数方式，一种是计算导数的傅里叶系数，另一种是计算刚刚逼近的导数。

      #theorem[谱精度][
        任意 $u in H_p^m (omega), m > 1/2$，将有：
        $
        norm((I(u) - u)^((mu)))_mu <= k N^(mu - m) abs(u)_mu
        $
        其中 
        - $H_p^m (omega)$ 是指 ${u in L^2(Omega) | forall mu = 0, 1, 2, ..., m, u^((mu))(x) in L^2(Omega) "且以" 2 pi "为周期"}$
        - $norm(u) = (sum_(k = -infinity)^(+infinity) (1+k^2)^mu norm(hu_k)^2)^(1/2)$
        - $abs(u)_mu =  (sum_(k = -infinity)^(+infinity) (k^2)^mu norm(hu_k)^2)^(1/2)$
        - $mu in NN^+, k$ 是与 $N$ 无关的常数
      ]
      #proof[
        从现在开始我们索性假设有 $2 N$ 个点，既然只关心 $N$ 的阶
        #let hp = $hat(P)$
        #definition[投影算子][
          定义投影算子：
          $
          hp_N (u)(x) = sum_(k = -N)^(N) hu_k e^(i k x)
          $
          也就是取出傅里叶级数的有限项
        ]
        #lemma[][
          $forall u in H_p^m (Omega)$，将有：
          $
          norm(hp_N u - u)_mu <= k N^(mu-m) abs(u)_m
          $
        ]<projection-approx>
        #proof[
          考虑 $hp_N u - u$ 的傅里叶系数，将有：
          $
          norm(hp_N u - u)_mu^2 = sum_(abs(k) > N) (1+k^2)^mu norm(hu_k)^2\
          = sum_(abs(k) > N) (k^2)^(m-mu) (1+k^2)^mu (1/k^2)^m_mu norm(hu_k)^2\
          <= (1/N^2)^(m - mu) sum_(abs(k) > N) ((1+k^2)/k^2)^mu (k^2)^m norm(hu_k)^2
          $
          注意到上式中 $((1+k^2)/k^2)^mu$ 是有界量，自然有：
          $
          <= M (1/N^2)^(m - mu) sum_(abs(k) > N)  (k^2)^m norm(hu_k)^2\
          <= M (1/N^2)^(m - mu) sum_(k)  (k^2)^m norm(hu_k)^2
          $
          得证
        ]
        #lemma[][
          $
          c_k tu_k = hu_k + sum_(r) hu_(k plus.minus 2 N r)
          $
        ]
        #proof[
          由定义：
          $
          c_k tu_k = 1/(2 N) sum_(j = 0)^(2 N - 1) (sum_(norm(n) < infinity) hu_n e^(i n x_i)) e^(-i k x_j) \
          = sum_(norm(n) < infinity) 1/(2 N) hu_n sum_(j = 0)^(2 N - 1) e^(i (n - k) x_j)\
          = sum_(norm(n) < infinity) 1/(2 N) hu_n sum_(j = 0)^(2 N - 1) e^(i (n - k) (pi)/n j)\
          $
          为了利用等比数列求和，稍微讨论一下特殊情况，也即 $n = k$ 时求和恰为 $2 N$。计算可得上式就是：
          $
          sum_(norm(n) < infinity) hu_(k + 2 N n)
          $
        ]
        #lemma[][
          $
          norm(P_N u - I_N u) <= k N^(-m) abs(u)_m
          $
        ]
        #proof[
          利用正交性：
          $
          norm(P_N u - I_N u)^2 = (P_N u - I_N u, P_N u - I_N u)\
          = sum_(abs(k) <= N) abs(hu_k - tu_k)^2\
          = sum_(abs(k) < N) abs(hu_k - tu_k)^2 +1/4 sum_(abs(k) = N) abs(2 hu_k - 2 tu_k)^2\
          <= sum_(abs(k) < N) abs(hu_k - tu_k)^2 + 1/2 sum_(abs(k) = N) abs(hu_k - 2 tu_k)^2 + 1/2 sum_(abs(k) = N) abs(hu_k)^2\
          <= sum_(abs(k) <= N) abs(hu_k - c_k tu_k)^2 + 1/2 sum_(abs(k) = N) abs(hu_k)^2\
          <= sum_(abs(k) <= N) abs(sum_(abs(r) < infinity) hu_(k + 2 N r) )^2 + 1/2 abs(hu_(-N))^2 + 1/2 abs(hu_N)^2\
          <= sum_(abs(k) <= N) abs((sum_(abs(r) < infinity) (k+2 N r)^(-2m))(sum_(abs(r) < infinity) (k+2 N r)^(2m)abs(hu_(k+2 N r))^2 ) ) + 1/2 abs(hu_(-N))^2 + 1/2 abs(hu_N)^2\
          "（利用柯西不等式）"\
          <= k abs((sum_(abs(r) < infinity) (1 + 2 N r)^(-2m))) sum_(abs(k) <= N) (sum_(abs(r) < infinity) (k+2 N r)^(2m)abs(hu_(k+2 N r))^2 )  + 1/2 abs(hu_(-N))^2 + 1/2 abs(hu_N)^2\
          "（调和级数的收敛性）"\
          <= k N^(-2 m) 2 abs(u)_m^2  + 1/N^(2 m) sum_(abs(k) > N) abs(k)^(2m) abs(hu_k)^2)\
          <= k' N^(-m) abs(u)_m
          $
        ]
        最后，我们只剩下对导函数的谱逼近
        #lemma[][
          $
          forall u in "Span"{e^(i k x) | -N <= k <= N},\
          norm(u^(mu) (x)) <= N^(mu) norm(u)
          $
        ]<anti-der>
        #proof[
          只需证明 $mu = 1$，之后逐次求导即可\
          有：
          $
          u(x) = sum_(k = -N)^(N) c_k e^(i k x)\
          u' (x) = sum_(k = -N)^(N) i k c_k e^(i k x)\
          norm(u' (x)) = sum_(k = -N)^(N) k^2 abs(c_k)^2 <= N^2 sum_(k = -N)^(N) abs(c_k)^2 = N^2 norm(u)
          $
        ]
        这个不等式被称为反不等式，因为它利用了函数值去估计导数值。我们终于可以估计导数的谱逼近：
        $
        norm((I_N u - u)') <= norm((I_N u - P_N u)') + norm((P_N u - u)') \
        $
        分别利用 @anti-der 和 @projection-approx，可得上式：
        $
        <= N^mu norm(I_N u - P_N u) + N^(mu - m) abs(u)_m\
        <= N^mu k N^(-m) abs(u)_m + N^(mu - m) abs(u)_m\
        $
        证毕
        
      ]
  == 快速傅里叶变换
    用最朴素的方法，计算 $N$ 个傅里叶级数的系数需要 $O(N^2)$ 的时间，这在 $N$ 较大时是不可接受的。因此，我们需要一种快速算法，这就是快速傅里叶变换（FFT, Fast Fourier Transformation）。它的出现确保了谱分析方法的实用性。\
    #let FFT = math.op("FFT")
    #let IFFT = math.op("InverseFFT")
    #definition[DFT][
      离散傅里叶变换/反离散傅里叶变换是指两个向量上的算法，使得：
      $
      "DFT"(X) &= (sum_(j=1)^n X_j w_n^((j - 1)(k-1))) := W X\
      "InverseDFT"(Y) &= 1/n (sum_(j=1)^n Y_j w_n^(-(j - 1)(k-1)))\
      &where w_n = e^(-2 pi i/n)
      $
      这里从 $1$ 开始是为了和 Matlab 统一，与之前的记号有对应：
      $
      u_j = X_(j + 1)\
      tu_k = cases(
        1/N Y_(k+1) quad k = 0\, 1\, ...\, N/2 - 1,
        1/N Y_(N+k+1) quad k = - N/2 + 1\, - N/2 + 2\, ...\, -1,
        1/(2 N) Y_(N/2 + 1) quad k = plus.minus N/2
      )
      $
    ]
    #FFT/#IFFT 是解决上述问题的高效算法，利用了适当的分治来减少重复计算。为了方便，接下来不妨设 $n = 2^k$
    #let pOdd = $p_("odd")$
    #let pEven = $p_("even")$
    #let odd = $"odd"$
    #let even = $"even"$
    #definition[FFT][
      快速傅里叶变换是指一个递归算法，使得：
      $
      FFT(X)_k &= p(w^(k-1)) := Y_k\
      where p(theta) &= x_1 + x_2 theta + x_3 theta^2 + ... + x_n theta^(n-1)\ 
      $
      计算 $p(theta)$ 时，进行奇偶分拆：
      $
      p(theta) = pOdd (theta^2) + theta pEven (theta^2)\
      $
      将有：
      $
      Y_k = pOdd (w^(2(k-1))) + w^(k-1) pEven (w^(2(k-1)))
      $
      在上式中将 $k$ 换成 $n/2$ 发现：
      $
      Y_(k + n/2) = pOdd (w^(2(k-1) + n)) + w^(k-1 + 2/ n) pEven (w^(2(k-1) + n))\
      = pOdd (w^(2(k-1))) - w^(k-1) pEven (w^(2(k-1)))
      $
      （注意到 $w$ 是 $n$ 次单位根）\
      此外，由定义得对于 $k <= n/2$
      $
      Y_k &= pOdd (w^(2(k-1))) + w^(k-1) pEven (w^(2(k-1))) \
          &= FFT_(n/2)(odd(X))_k + w^(k-1) FFT_(n/2)(even(X))_k\
      where &odd(X) = (x_1, x_3, ..., x_(n-1))^T\
            &even(X) = (x_2, x_4, ..., x_n)^T
      $
      因此，分别计算 $FFT_(n/2)(odd(X)), FFT_(n/2)(even(X))$ 再按上面的公式即得 $FFT(X)$
    ]
    #proposition[][
      $FFT(X)$ 的时间复杂度为 $O(n log n)$
    ]
    #proof[
      设 $n$ 阶 $FFT$ 的乘法次数为 $M_n$，加法次数为 $A_k$ ，有：
      $
      M_1 = 0, A_1 = 0
      $
      根据上面的过程，将有：
      $
      M_k = 2 M_(k/2) + k/2\
      A_k = 2 A_(k/2) + k
      $
      设 $k = 2^m$ 并令 $a_m = M_(2^m), b_m = A_(2^m)$，有：
      $
      a_m = 2 a_(m-1) + 2^(m-1)\
      2^(-m) a_m = 2^(-(m-1))  a_(m-1) + 1/2\
      2^(-m) a_m = 1/2 m => a_m = 1/2 m 2^m\
      b_m = 2 b_(m-1) + 2^m\
      2^(-m) b_m = 2^(-(m-1))  b_(m-1) + 1\
      2^(-m) b_m = m => b_m = m 2^m
      $
      化简得 $A_k, M_k$ 都是 $O(n log n)$ 的，证毕
    ]
  == 高维模型中的维度灾难
    #let kv = $bold(k)$
    #let xv = $bold(x)$
    #let toKB(x) = x/1024
    #let toMB(x) = x/1024/1024
    #let toGB(x) = x/1024/1024/1024
    #let FG = $"FG"$
    #let absMix(x) = $abs(#x)_"mix"$
    #let absMix2(x) = $abs(#x)_"mix"^2$
    设 $xv, kv$ 是 $d$ 维向量，注意到有简单的计算式：
    $
    e^(i kv^T xv) = product_(k) e^(i kv_k xv_k) 
    $
    表明高维的平面波可以自然地分裂成一维平面波的乘积，也称其为张量形式。用这种形式可以进行函数逼近：
    $
    u(xv) approx u_N (xv) = sum_(k in FG_N) tu_kv e^(i kv^T xv)\
    $
    其中 $FG_N$ 是指全网格（Full grid），具体定义为：
    $
    FG_N = ([-N, N] sect ZZ)^d
    $
    容易计算其中约有 $(2 N)^d$ 个网格点。即使有高效算法 $FFT$ 在维度较高的情况下计算量也是不可接受的，这是维度灾难的体现之一，例如 $d = 6, n = 100$ 时假设使用两字节的浮点数，将需要空间：
    $
    2 dot 2^6 dot 100^6 "Byte" = #(toGB(2*calc.pow(100, 6)*calc.pow(2, 6))) "GB"
    $
    同时，谱精度也会随着 $d$ 增加快速衰减，这也是十分糟糕的。


    因此，我们当然需要更好的解决方法，有以下几个目标：
    - 复杂度不随 $d$ 指数增长
    - 精确度不随 $d$ 快速衰减
  == 稀疏网格方法
    #let SG = $"SG"$
    上面的两个目标当然无法轻易实现，需要很多的设计和取舍。例如一个经典的方法是所谓的*双曲截断*，考虑到系数在每个维度上衰减都十分迅速，因此应该取那些合适的格点使得每个维度都不要取过高项的系数。具体来说，取格点：
    $
    SG_N = {kv | product_(j=1)^n max(abs(kv_j), 1) := absMix(kv) <= N}
    $
    此时，近似函数所在的函数空间为：
    $
    Sigma_N = "span"{ e^(i kv xv)| kv in SG_N }
    $
    我们需要解决：
    - 使用该方法取格点的精度如何，有定理：
      #let absKpm(x) = $abs(#x)_K_p^m$
      #let absKpm2(x) = $abs(#x)_(K_p^m)^2$
      #theorem[][
        若：
        $
        u(xv) = sum_(kv in ZZ^n) hu_kv e^(i kv^T xv)
        $
        则称 $u$ 函数有平面波展开\
        任取 $u in K_p^m (Omega)$，有结论：
        $
        inf_(v in  Sigma_N) norm(u - v)_(K_p^mu) <= k N^(mu - m) absKpm(u)
        $
        其中：
        - $absKpm2(sum_(kv in ZZ^n) hu_kv e^(i kv^T xv)) = sum_(kv in ZZ^n) (absMix(kv))^(2m) abs(hu_kv)^2$
        - $K_p^m (Omega) = {u(xv) | u "可被平面波展开且" absKpm(u) < infinity}$
        - $mu = 0, 1, 2, ..., m$
      ]
      #proof[
        左侧取得接近下确界的最佳估计当然是投影，也即
        $
        inf_(v in ZZ_n) norm(u - v)_(K_p^mu)^2
        &<=  norm(u - sum_(kv in SG_N) hu_kv e^(i kv^T xv))_(K_p^mu)^2\
        &= norm(sum_(kv in ZZ^n - SG_N) hu_kv e^(i kv^T xv))_(K_p^mu)^2\
        &= norm(sum_(kv in ZZ^n - SG_N) hu_kv e^(i kv^T xv))_(K_p^mu)^2\
        &= sum_(kv in ZZ^n - SG_N) absMix(kv)^(2 mu) abs(hu_kv)^2\
        &= sum_(absMix(kv) > N) absMix(kv)^(2 mu) abs(hu_kv)^2\
        &< 1/N^(2 m - 2mu)sum_(absMix(kv) > N) absMix(kv)^(2m) abs(hu_kv)^2\
        &< 1/N^(2 m - 2mu) absKpm2(u)
        $
        证毕
      ]
      #remark[][
        上面的定理说明了投影可以保持精度，理论上还要证明插值也保持投影的精度，这里不再赘述。

        这里函数空间的限制（也即 $absKpm(u) < infinity$ ）是非常重要的，不难看出一旦失去了这个条件精度便会失去估计。从形式上看，这需要 $tu_k$ 衰减地非常之快，谱方法中它确实往往有较好的收敛速度，但在一般的数值方法中未必。

        然而有趣的是，双曲截断方法的提出在历史上并非最早为了谱逼近方法提出，而是为了在谱方法之前更加常用的分片常数/多项式逼近设计的。
        
      ]<approx-remark>

    - 使用该方法需要取多少格点，也即稀疏性如何。为此，希望计算 $abs(SG_N)$
      #theorem[][
        $d$ 维的稀疏网格满足：
        $
        abs(SG_N) = O(N (log N)^(d-1))
        $
      ]
      #proof[
        利用数学归纳法
        - $d = 1$ 是容易的
        - 一般的：
          $
          {kv | product_(j=1)^n max(abs(kv_j), 1) := absMix(kv) <= N} \
          = union_(s =0)^N {kv | product_(j=1)^n max(abs(kv_j), 1) <= N, abs(kv_1) = s}\
          = (union.big_(s =1)^N {kv | product_(j=2)^n max(abs(kv_j), 1) <= N/s, abs(kv_1) = s}) union {kv | product_(j=2)^n max(abs(kv_j), 1) <= N,  abs(kv_1) = 0}\
          $
          上式中均为不交并，因此对其计数并利用归纳假设，有：
          $
          abs(SG_N^d) = 2 sum_(s=1)^N abs(SG_(N/s)^(d-1)) + abs(SG_N^(d-1))\
          = sum_(s=1)^N O(N/s (log (N/s))^(d-2)) + O(N (log N)^(d-2))\
          = N sum_(s=1)^N O(1/s (log N - log s)^(d-2) )+ O(N (log N)^(d-2))
          $
          只需要估计 $sum_(s=1)^N O(1/s (log N - log s)^(d-2) )$，利用积分有：
          $
          sum_(s=1)^N O(1/s (log N - log s)^(d-2) )&<= integral_(1)^(N) 1/x (log N - log x)^(d-2) dif s\
          &=^(t = log s) k integral_(0)^(log N) (log N - t)^(d-2) dif t\ 
          &=^(u = log N - t) k integral_(0)^(log N) u^(d-2) dif u\ 
          &= O((log N)^(d-1))
          $
          故原式约为 $O(N (log N)^(d-1)) + O(N (log N)^(d-2)) = O(N (log N)^(d-1))$，证毕
      ]
      这个结果当然比之前的全网格好得多，我们只需要稍微劣于线性的复杂度就可以取得足够多的项。
    == 分片线性逼近中的稀疏网格
      #let oddl = $odd_l$
      @approx-remark 中提到了稀疏网格方法的历史问题，为了完善起见我们论述如何在更加简单的分片线性逼近中实现稀疏网格方法。核心而言，我们要：
      - 找到合适的正交基。在谱方法中我们采用了三角函数的振荡正交，而在这里我们索性简单地将不同基的非零部分（称为*支集*）分开。
      - 找到指数级别的衰减性。一般的分片逼近并无如此强的衰减性，我们必须迅速增加分点个数以保证高速衰减。
      #definition[分片线性逼近][
        令：
        $
        Phi(x) = cases(
          1 - abs(x) quad abs(x) <= 1,
          0 quad "else"
        )
        $
        对 $[0, 1]$ 做均匀划分，网格步长为 $h_l = 2^(-l)$，分点为：
        $
        0 = x^l_0 < x^l_1 < ... < x^l_(2^l) = 1
        $
        以这些分点构造分片线性基函数：
        $
        Phi_(l i) = Phi((x - x^l_(i))/h_l)
        $
        其紧支集为 $[x^l_i - h_l, x^l_i + h_l]$\
        记 $V_l = "span" {Phi_(l i) | i = 0, 1, ..., 2^l}$，称为分片线性函数逼近空间。\
        方便起见，不妨设函数在边界为零，因此不需要再考虑 $Phi_(l 0), Phi_(l 2^l)$

        考虑如下的嵌套基组：
        $
        W_l = "span" {Phi_(l i) | i in {1, 3, 5, ..., 2^l - 1} := oddl}\
        $
        不难发现 $W_l$ 中每两个函数之间的紧支集至多交于一点，且 $W_l$ 中任何一个基函数在 $W_(l+1)$ 中恰好分成两个函数（所谓的嵌套关系）
      ]
      #proposition[][
        在不考虑边界的情况下，有：
        $
        V_L = plus.circle_(1 <= l <= k) w_l 
        $
        继而任取 $u in V_L$ 将有：
        $
        u(x) = sum_(l=1)^L sum_(i in oddl) hu_(l i) Phi_(l i)(x) 
        $<linear-approx>
      ]
      #let diffI(y, h) = $I_((#y, #h))$
      #theorem[][
        在上面的命题中，有：
        $
        hu_(l i) = diffI(x_(l i), h_l) u(x) \
        where diffI(y, h) u(x) = u(y) - 1/2(u(y-h) + u(y+h))
        $
      ]
      #proof[
        注意到 $I$ 具有线性，以 $I$ 作用于 @linear-approx 将有：
        $
        diffI(x_(l i), h_l) u(x) = sum_(l'=1)^L sum_(i' in oddl) hu_(l' i') diffI(x_(l i), h_l) (Phi_(l' i')(x) )
        $
        只需计算：
        $
        diffI(x_(l i), h_l) (Phi_(l' i')(x) ) = Phi_(l' i')(x_(l i)) - 1/2(Phi_(l' i')(x_(l i) - h_l) + Phi_(l' i')(x_(l i) + h_l))\
        $
        - $l' < l$ 时，$x_(l i) plus.minus h_l$ 一定落在 $Phi_(l' i')$ 中的同一个线性分支上（线性增加/减少/支集之外），观察 $I$ 的表达式可得一定为零
        - $l' > l$ 时，观察发现 $x_(l i) plus.minus h_l$ 在高层基函数的取值均为零，当然也是零
        - $l = l'$ 时，由不重叠性非零除非 $i = i'$，此时 $Phi_(l' i')(x_(l i) + h_l) = 1$
        综上，$Phi_(l' i')(x_(l i) + h_l) = delta_(i, i') delta_(l, l')$，代回即可得到所证式子
      ]
      #corollary[][
        在上面的命题中，有：
        $
        hu_(l i) = integral_(0)^(1) (-1/2) 2^(-l) Phi_(l, i) (x) u''(x) dif x
        $
      ]
      #proof[
        $
        integral_(0)^(1) (-1/2) 2^(-l) Phi_(l, i) (x) u''(x) dif x
        &= - 2^(-l-1) integral_(x_l^i - h_l)^(x_l^i + h_l) Phi_(l, i) (x) u''(x) dif x\
        &"（利用分部积分计算并展开）"\
        &=  - 2^(-l-1)  (integral_(x_l^i - h_l)^(x_l^i ) (u'(x))/(h_l) dif x - integral_(x_l^i )^(x_l^i + h_l ) (u'(x))/(h_l) dif x)\
        &= - 1/2 (integral_(x_l^i - h_l)^(x_l^i ) u'(x) dif x - integral_(x_l^i )^(x_l^i + h_l ) u'(x) dif x)\
        &= diffI(x_(l i), h_l) u(x)
        $
      ]