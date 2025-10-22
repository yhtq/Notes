#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交事件为3月18日）
= 3月4日
  == 
    不妨设 $x_i$ 从小到大排列。容易发现所求函数是分段线性的，分段点分别为：
      $
      x_1, x_2, ..., x_n
      $
      从左到右，每段的斜率为：
      $
      - sum_(i in V) d_i, 2 d_1 - sum_(i in V) d_i, 2d_1 + 2d_2  - sum_(i in V) d_i, ... , sum_(i in V) d_i
      $
      显然函数取最小值当且仅当斜率在其左侧非正，右侧非负，因此最小值点恰在 $"median"(d)$ 对应的 $x$ 区间取得（题上写错了？）
  ==

    考虑两点以及之间的边构成的图，容易计算得 $h = 1/1 = 1$，而:
    $
    lambda_2 = min (y^T L y)/(y^T D y) =min_(y^T y= 1) y^T mat(1, -1;-1, 1) y = 2
    $
    恰有 $lambda_2 = 2 h$

    对于另一侧，经过尝试和查阅相关资料并没有找到实际取等的例子，但是可以证明在 $4 n$ 阶圈图上量级是紧的。事实上，设向量：
    $
    x_i = cases(
      i - n/4\, quad i <= n/2,
      (3n)/4 - i\, quad i > n/2
    )
    $
    容易验证它与 $overline(1)$ 垂直，计算其 Rayleigh 商为：
    $
    lambda_2 <= (x^T L x)/(2 x^T x) = (O(n))/(O(n^3)) = O(1/n^2)
    $
    而 $h(G)$ 是 $O(1/n)$ 的，表明不等式的量级是紧的
  ==
    用 Mathematica 计算得，答案在附件之中。可以看出取绝对值后，采用 $93 - 337$ 之间的值作为取整阈值均可
= 3月11日
  == 
    === 
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
      注意到绝对值函数是凸函数，由引理知 $abs((epsilon_i - epsilon_j)^T X) = abs(x_i - x_j)$ 是凸函数，注意到凸函数的和还是凸函数，继而 $I(x)$ 也是凸函数

      类似的：
      $
      N'(x, c) := sum_(i in V) d_i abs(x_i - c)
      $
      是凸函数
      #lemma[][
        设 $f(x, y): RR^m times RR^n -> RR$ 是凸函数，且 $min_(y in RR^n) f(x, y)$ 总存在，则：
        $
        g(x) = min_(y in RR^n) f(x, y)
        $
        也是凸函数
      ]
      #proof[
        // $
        // g(t x_1 + (1-t) x_2) &= min_(y in RR^n) f(t x_1 + (1-t) x_2, y) \
        // &<= min_(y in RR^n) (t f(x_1, y) + (1-t) f(x_2, y)) 
        // $
        // $
        // t g(x_1) + (1-t) g(x_2) = min_(y in RR^n) t f(x_1, y) + min_(y in RR^n) (1-t) f(x_2, y)
        // $
        $
        f(t x_1 + (1-t) x_2, t y_1 + (1-t) y_2) <= t f(x_1, y_1) + (1-t) f(x_2, y_2)
        $
        两边令 $y_1$ 遍历 $RR^n$ 取最小值：
        $
        min_(y_1 in RR^n) f(t x_1 + (1-t) x_2, t y_1 + (1-t) y_2) <= t g(x_1) + (1-t) f(x_2, y_2)
        $
        然而注意到：
        $
        min_(y_1 in RR^n) f(t x_1 + (1-t) x_2, t y_1 + (1-t) y_2) \
        = min_(t y_1 + (1-t) y_2 in RR^n) f(t x_1 + (1-t) x_2, t y_1 + (1-t) y_2) = g(t x_1 + (1-t) x_2)
        $
        从而有：
        $
        g(t x_1 + (1-t) x_2) <= t g(x_1) + (1-t) f(x_2, y_2), forall y_2 in RR^n
        $
        再对 $y_2$ 取最小值，立得：
        $
        g(t x_1 + (1-t) x_2) <= t g(x_1) + (1-t) g(x_2)
        $
        表明 $g$ 是凸函数
      ]
      由引理，结论是显然的
    ===
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
    === 
      #let h1 = $accent(h, tilde)$
      设 $x_0$ 可使 $h1$ 取最小的的 $x$，不妨设 $x in [-1, 1]^n$。\
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
  ==
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
  ==
    #let Sgn = $"Sgn"$
    在三角形图中，有：
    $
    B = mat(0, 1, 1;-1, 0, 1;-1, -1, 0)\
    B x = vec(x_2 + x_3, x_3 - x_1, -x_1 -x_2)\
    B^T = mat(0, -1, -1;1, 0, -1;1, 1, 0)\
    B^T Sgn(B x) = vec(Sgn(x_3 - x_1)+Sgn(x_1 + x_2), Sgn(x_3 + x_2)+Sgn(x_1 +x_2), Sgn(x_2 +x_3) + Sgn(x_3-x_1))\
    mu D Sgn(x) = 2 mu vec(Sgn(x_1), Sgn(x_2), Sgn(x_3))
    $
    容易想到 Cheeger 问题的一个最优解为 $h = 1, x = vec(1, 0, 0)$，代入得：
    $
    B^T Sgn(B x) = vec(2, [0, 2], [0, 2])\
    mu D Sgn(x) = 2 mu vec(1, [-1, 1], [-1,1])
    $
    显然可取 $mu = 2$ ，对应的一个特征向量为 $vec(1, 0, 0)$
= 3月13日
  == 
    不太懂这里应该有什么“几何”的意义，比如某种意义上 $Delta_1 = 0$ 和 $Delta_2 = 0$ 都可以理解为某种“梯度”的“散度”稳定，或者说在每一点附近函数的变化率都在一定程度上稳定
  ==
    ===
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
    ===
      熟知 $norm(x) = max abs(x_i)^p$ 作为若干凸函数的最大值仍是凸函数，因此仿照之前的理论我们希望：
      $
      diff I_p (x) inter mu diff norm(x) != emptyset
      $
      - 先计算 $diff I_p (x)$:
        $
        diff sum_({i, j} in E) abs(x_i - x_j)^p = p sum_({i, j} in E) abs(x_i - x_j)^(p-1) "Sgn"(x_i - x_j)
        $
    == 
      我们需要在 $pi = {x | norm(x) = 1}$ 上最大化 $f(x)$，也即希望：
      $
      diff I_p (x) inter mu norm(x) != emptyset 
      $
      分别计算：
      - 
        $
        diff I_p (x) = p sum_({i, j} in E) abs(x_i - x_j)^(p-1) "Sgn"(x_i - x_j) (epsilon_i - epsilon_j)
        $
      - 
        #lemma[][
          $
          diff max(f, g) = 1/2 diff (abs(f + g) + abs(f - g)) = 1/2 "Sgn"(f + g)(diff f + diff g) + 1/2 "Sgn"(f - g) (diff f - diff g)
          $
        ]
        由引理，将有：（假设链式法则成立）
        $
        diff norm(x) = diff max{abs(x_i)^p} = p/2^n sum_(k in {1, -1}^n) "Sgn"(sum_(i in V) k_i abs(x_i)^p) (sum_(i in V)  k_i abs(x_i)^(p-1) Sgn(x_i)epsilon_i) \
        = sum_(i in V)  (sum_(k in {1, -1}^n)  "Sgn"(sum_(i in V) k_i abs(x_i)^p) (sum_(i in V)  k_i abs(x_i)^(p-1) Sgn(x_i)))epsilon_i
        $

    