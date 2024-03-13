#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, der, partialDer
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
  - 教师：卲嗣洪
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
      #theorem[][
        设:
        $
        h' = min_(x in RR^n)(sum_((i, j) in E) |x_i - x_j|)/(min_(c in RR) sum_(i in V) d_i |x_i - c|)
        $
        则 $h' = h$
      ]
      #proof[
        记 $I(x) = sum_((i, j) in E) |x_i - x_j|, N(x) = min_(c in RR) sum_(i in V) d_i |x_i - c|$\
        断言：
        - 
          $
          N(x) = min_(c in RR) sum_(i in V) d_i |x_i - c| := min_(c in RR) g(c_i, x)
          $
          在 $c^*$ 取最小值的当且仅当 $c^* in "median"(x)$
        如此我们仿照之前的操作进行 $c$ 平移，结合平移不变性，原式化为：
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


