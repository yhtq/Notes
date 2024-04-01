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
#let absSigmaI(i) = $abs(x_sigma(#i))$
#let fL = $f^L$
（应交事件为4月1日）
= 3.20
  == 
    $
    h_max = max_(x in RR^n)(sum_((i, j) in E) |x_i - x_j|)/(2 norm(x) "vol" V - min_(c in RR) sum_(i in V) d_i |x_i - c|)
    $
  ==
    设 $f, g: P_2 (V) -> [0, +infinity]$，且对任意 $(A, B) in P_2 (V) - {(emptyset, emptyset)}$ 有 $g(A, B) > 0$，则我们有：
        $
        max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = max_(x in RR^n - {0}) (f^L (x))/(g^L (x))
        $
    #proof[
      - 首先要证明右侧的最大值存在。事实上前面证明了 $f^L, g^L$ 是一次齐次的连续函数，因此可以在任何一个有界闭集上取得最大值，例如 ${x | norm(x) = 1}$，其上的最大值也是它在整个定义域上的最大值
      - 其次，显然有：
        $
        max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f^L (1_(A, B)))/(g^L (1_(A, B))) <= max_(x in RR^n - {0}) (f^L (x))/(g^L (x))
        $
        因此只要证明另一侧不等式
      - 任取 $x !=0 $:
        $
        (f^L (x))/(g^L (x)) = (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i)))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) 
        $
        注意到我们总可以取得 $(C, D) in P_2 (V)$ 使得：
        $
        (f(C, D))/(g(C, D)) = max_(0<= i <= n-1) (f(V^+_(sigma(i)), V^-_(sigma(i)))) /(g(V^+_(sigma(i)), V^-_(sigma(i))))
        $
        有：
        $
        &(f^L (x))/(g^L (x)) - (f(C, D))/(g(C, D))  \
          &=
          (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i))) - (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) (f(C, D))/(g(C, D))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) \
          &<= (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i))) - (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i))) (f(V^+_(sigma(i)), V^-_(sigma(i))))/(g(V^+_(sigma(i)), V^-_(sigma(i)))))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i))))\
          &= 0
        $
        因此 
        $
        max_(x in RR^n - {0}) (f^L (x))/(g^L (x)) <= (f(C, D))/(g(C, D)) <= max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B))
        $
        证毕
    ]
  ==
    $
    h_max = max_(x in RR^n)(sum_((i, j) in E) |x_i - x_j|)/(2 norm(x) "vol" V - min_(c in RR) sum_(i in V) d_i |x_i - c|)
    $
    #let vol = math.op("vol")
    #proof[
      与之前问题的分子是完全一致的，而由 Cheeger 问题计算得到的结论，有：
      $
      integral_(0)^(norm(x)) min {vol(V_t^+), vol(V - V_t^+)} + min {vol(V_t^-), vol(V - V_t^-)} dif t = min_(c in RR) sum_(i in V) d_i abs(x_i - c)
      $
      因此当然有：
      $
      G^L (x) 
        &= integral_(0)^(norm(x)) max {vol(V_t^+), vol(V - V_t^+)} + max {vol(V_t^-), vol(V - V_t^-)} dif t\
        &= 2 norm(x) vol V - integral_(0)^(norm(x)) min {vol(V_t^+), vol(V - V_t^+)} + min {vol(V_t^-), vol(V - V_t^-)} dif t\
        &= 2 norm(x) vol V - min_(c in RR) sum_(i in V) d_i abs(x_i - c)
      $

    ]
  ==
    注意到有积分形式：
    $
      f^L (x) = integral_0^(norm(x)_infinity) f(V_t^+ (x), V_t^- (x)) dif t
    $
    容易看出当且仅当 $f(V_t^+ (x), V_t^- (x))$ 关于 $t$ 递增时它是凸函数。它当然不总是凸函数，至少可以取 $g = -f$ 不可能与 $f$ 同时关于 $t$ 递增。

    再例如取：
    $
    V = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}\
    x_i = i, i=1,2, 3...,10\
    f(A, B) = (min_(i in A) i)(10-min_(i in A) i)
    $
    则容易看出 $f(V_t^+ (x), V_t^- (x))$ 关于 $t in [0,1]$ 先增后减，当然对应的 $f^L (x)$ 不是凸函数或者凹函数
=
  == 
    不妨设 $x$ 取有界闭区域 $I$ 并取定 $x_0 in I$，记 $g (x, t) = f(t) + x g(t)$，它是二元连续函数，进而在紧集：
    $
    I times [0, 1]
    $
    上一致连续，因此任意 $epsilon > 0$，存在 $delta > 0$ 使得：
    $
    forall (x_1, t_1), (x_2, t_2), norm((x_1, t_1) - (x_2, t_2)) <  delta => |g(x_1, t_1) - g(x_2, t_2)| < epsilon
    $
    无妨设使得 $h(x_0)$ 取最值的 $t$ 为 $t_0$，对于任意 $x$ 满足 $abs(x - x_0) < delta$，我们断言：
    $
    abs(min_(t in [0, 1]) g(x, t) - g(x_0, t_0)) <= epsilon
    $
    事实上，设上式最小值在 $t_1$，由条件知：
    $
    g(x, t_1) <= g(x, t_0) < g(x_0, t_0) + epsilon\
    g(x_0, t_0) <= g(x_0, t_1) < g(x, t_1) + epsilon
    $
    整理不等式可得原式成立，进而得证
  ==
    证明一般的结果：
    #theorem[Dinkerbach 迭代][
      设 $A$ 是紧集，$P, Q$ 是连续函数，针对分式规划问题：
      $
      max_(x in A) P(x)/Q(x)
      $
      可以构造迭代
      $
      cases(
        x^(k+1) = argmin_(x in A) {Q(x) r^k - P(x) },
        r^(k+1) = P(x^(k+1))/Q(x^(k+1))
      )
      $
      - 述迭代产生的序列 ${r^k}$ 单调递增
      - 若原问题有最优值，则上述迭代产生的序列收敛于原问题的解
    ]
    #proof[
      注意到：
      $
      r^k Q(x^(k+1)) - P(x^(k+1)) <= r^k Q(x^(k)) - P(x^(k)) = 0\
      r^k <= P(x^(k+1))/Q(x^(k+1)) = r^(k+1)
      $
      设原问题的最优值为 $r_max$，自然每个 $r_n$ 都不超过 $r_(max)$，因此序列单调有上界，进而有极限 $r <= r_(max)$\
      同时，设 $x_0$ 是取得原问题最大值的点，将有：
      $
      r^n Q(x^(n+1))-  P(x^(n+1)) <= r^n  Q(x_0) - P(x_0)
      $
      注意到 $x^n$ 是紧集上的序列，可取其一个收敛子列，不妨设它本身就收敛，上式取极限立得：
      $
      r >= r_(max)
      $
    ]
    最小值形式的 Dinkerbach 迭代取倒数即可，形式为：
    $
    cases(
        x^(k+1) = argmin_(x in A) {P(x) - Q(x) r^k},
        r^(k+1) = P(x^(k+1))/Q(x^(k+1))
      )
    $
    在 Cheeger 问题中，$P(x) = I(x) = sum_({i, j} in E) abs(x_i - x_j), Q(x) = N(x) = min_(c in RR) sum_(i in V) d_i abs(x_i -c)$，收敛性已经证明
  ==
    显然 $P 2$ 是 $P 3$ 的一种情况，只需在 $P 3$ 的条件下恢复 $P 2$ 即可\
    事实上，给定 $X$ 使得 $"rank" (X) = 1$ 且半正定，熟知一定存在 $v$ 使得：
    $
    X = v v^T
    $
    结合 $1 = X_(i i) = v_i^2$，可得 $abs(v_i) = 1$，这就是 $P 2$ 的最优化条件，得证
  ==
   一般的 SDP 问题形如：
   $
   min_(X in SS^n) inner(C, X) "with" &inner(A_i, X) <= b_i, i = 1, 2, ..., m\
    &X "semi-definite"
   $
   严格来说，目前并没有针对一般 SDP 问题的多项式算法，对其复杂度我们只知道它不是 NP 完全问题，除非 $"NP" = "co-NP"$。然而在一定更强的条件，或者限制一定计算精度，SDP 问题可以通过内点法，椭球法等经典方法在多项式时间解决
    
