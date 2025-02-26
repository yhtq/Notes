#import "../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 1.2.1
  假设 ${(xi_i)^k}_k$ 是一柯西列，断言：
  $
    {xi_i^k}_k
  $
  对于所有的 $i$ 都是柯西列，这是因为：
  $
    rho((xi_i)^s, (xi_i)^t) = sum_k 1/2^k abs(xi_k^s - xi_k^t)/(1 + abs(xi_k^s - xi_k^t)) >= 1/2^i abs(xi_i^s - xi_i^t)/(1 + abs(xi_i^s - xi_i^t))
  $
  因此对于任意 $epsilon > 0$，（无妨设 $epsilon < 1/2$），选择 $N$ 使得 $forall s, t > N, rho((xi_i)^s, (xi_i)^t) < 1/2^i epsilon$，立刻有：
  $
    abs(xi_i^s - xi_i^t)/(1 + abs(xi_i^s - xi_i^t)) < epsilon\
    abs(xi_i^s - xi_i^t) < epsilon/(1 - epsilon) < 2 epsilon
  $
  这就验证了上述柯西列，因此定义：
  $
    xi_i^0 := lim_k xi_i^k
  $
  只需证明 $(xi_i)^k -> (xi_i)^0$:
  对于任意 $epsilon > 0$
  - 选取 $K$ 使得 $sum_(i = K + 1)^infinity 1/2^i < epsilon$
  - 前面已经证明对于任意 $i$，存在 $N_i$ 使得 $forall s, t > N_i, abs(xi_i^s - xi_i^t) < epsilon => forall s > N_i, abs(xi_i^s - lim_s xi_i^s) < 2 epsilon$. 令 $N = max_(1 <= i <= K) N_i$
  - 于是有：
    $
      forall s > N&:\
      rho((xi_i)^s, (xi_i)^0) &= sum_i 1/2^i abs(xi_i^s - lim_j xi_i^j)/(1 + abs(xi_i^s - lim_j xi_i^j)) \
      &<= sum_(i = 1)^K 1/2^i abs(xi_i^s - lim_j xi_i^j)/(1 + abs(xi_i^s - lim_j xi_i^j)) + sum_(i = K + 1)^(+infinity) 1/2^i abs(xi_i^s - lim_j xi_i^j)/(1 + abs(xi_i^s - lim_j xi_i^j)) \
      &<= sum_(i = 1)^K 1/2^i abs(xi_i^s - lim_j xi_i^j)/(1 + abs(xi_i^s - lim_j xi_i^j)) + sum_(i = K + 1)^(+infinity) 1/2^i \
      &<= sum_(i = 1)^K 1/2^i abs(xi_i^s - lim_j xi_i^j)/(1 + abs(xi_i^s - lim_j xi_i^j)) + epsilon\
      &<= sum_(i = 1)^K 1/2^i abs(xi_i^s - lim_j xi_i^j)/(1 + abs(xi_i^s - lim_j xi_i^j)) + epsilon\
      &<= sum_(i = 1)^K 1/2^i epsilon/(1 + epsilon) + epsilon\
      &<= 2 epsilon
    $
  证毕
= 1.2.3 
  找一列数列：
  $
    x^n = (1, 1/2\, 1/3\, ...\, 1/(n - 1), 0, 0, ...)
  $
  断言：
  - $x^n in F$: 显然
  - $x^n$ 是柯西列：不难发现：
    $
      forall i > j, sup_k abs(x_k^i - x_k^j) = 1/j 
    $
    因此当 $i, j$ 充分大时上式小于 $epsilon$
  - $x^n$ 无极限。事实上假设 $x^n -> x$，则：
    $
      forall i, abs(x^n_i - x_i) <= sup_i abs(x^n_i - x_i) -> 0 
    $
    因此 $x_n = 1/n in.not F$，矛盾！
  事实上，它的完备化空间是 $RR$ 上所有收敛到零的数列 $F'$，度量为：
  $
    d(x, y) = sup_k abs(x_k - y_k)
  $
  （由于序列收敛，因此 $abs(x_k - y_k)$ 是有界集合，上确界一定存在）\
  嵌入映射是平凡的。为了验证它是完备化空间，只需验证 $F$ 在 $F'$ 中是稠密的即可。事实上，对于任意 $y in F'$，定义：
  $
    x^n_i = cases(
      y_i space i <= n,
      0 space i > n
    )
  $
  则：
  - $x^n in F$
  - $d(x^i, y) = sup_(k > i) y_i -> 0$
  因此 $F$ 在 $F'$ 中是稠密的，证毕
= 1.2.4
  // 设 $mu(p)$ 将 $[0, 1]$ 上的多项式映到系数数列。注意到：
  // $
  //   d(p, q) &= integral_(0)^(1) abs(p(x) - q(x)) dif x \
  //   &<= sum_i 1/(i + 1) (mu(p)_i - mu(q)_i) \
  // $
  // 断言 $p_n$ 是柯西列当且仅当 $mu(p_n)$ 在上题的度量意义下是柯西列。这是因为：
  // - 若
  取多项式：
  $
    f_n = 1 + 1/(2!) x + ... + 1/(n!) x^n
  $
  则：
  $
    forall i < j, rho(f_i, f_j) = sum_(k = i + 1)^j integral_(0)^(1) 1/(k!) x^k dif x = sum_(k = i + 1)^j 1/(k + 1)! <  sum_(k = i + 1)^j 1/((k + 1)k)
  $
  显然 $i, j -> +infinity$ 时上式 $-> 0$

  将多项式空间嵌入 $[0, 1] -> RR$ 的连续函数空间，上述数列的极限恰为 $e^x$ 显然不在多项式空间之中。

  由数学分析结论，闭区间上多项式在 $L^1$ 空间中稠密，而 $L^1$ 空间恰好是完备的，因此其完备化就是 $L^1$ 空间。
= 1.2.4
  由熟知定理，只需证明它是 $A$ 完全有界的充要条件。
  - 假设 $A$ 完全有界，也即：
    $
      forall epsilon > 0, exists a_i, A subset union_i B(a_i, epsilon) 
    $
    对于任意 $n in NN$，取 $epsilon = 1/2 dot 1/2^n$，得到 $a_i$ 使得：
    $
      A subset union_i B(a_i, 1/2 dot 1/2^n)
    $
    构造 $C_n = max_i abs(a_i (n)) + 2$，则有对于任意 $x in A$，设 $x in B(a_i, 1)$，从而：
    $
      1/2 dot 1/2^n > d(x, a_i) = sum_k 1/2^k abs(x(k) - a_i (k))/(1 + abs(x(k) - a_i (k))) > 1/2^n abs(x(n) - a_i (n))/(1 + abs(x(n) - a_i (n))) \
      abs(x(n) - a_i (n)) < 1\
      abs(x(n)) - abs(a_i (n)) < abs(x(n) - a_i (n)) < 1\
      abs(x(n)) < 1 + abs(a_i (n)) < C_n
    $
    证毕
  - 反之，假设题设命题成立，对于任意 $epsilon > 0$，选择 $K$ 使得：
    $
      sum_(k = K + 1)^infinity 1/2^k < epsilon
    $
    考虑以下集合：
    $
      S := {autoVecNF(#(k => $x (#k)$), K) mid(|) x in A} subset RR^K
    $
    则由条件，$S$ 是有界集合（使用 $d(x, y) = max_k abs(x(k) - y(k))$ 作为度量），进而完全有界，也即存在 $u_i in RR^K$ 使得：
    $
      forall x in S, exists i, forall k = 1, 2, ..., K, abs(x(k) - u_i (k)) < epsilon
    $<ieq1>
    #let lu = $overline(u)$
    进而，构造 $lu_i in RR^NN$ 使得其前 $K$ 项与 $u_i$ 相同，其余项为零。对于任意 $x in A$，取 $u_i$ 满足@ieq1，都有：
    $
      d(x, lu_i) &= sum_(k = 1)^K 1/2^k abs(x(k) - lu_i (k))/(1 + abs(x(k) - lu_i (k))) + sum_(k = K + 1)^infinity 1/2^k abs(x(k))/(1 + abs(x(k)))\
      &<= sum_(k = 1)^K 1/2^k abs(x(k) - lu_i (k))/(1 + abs(x(k) - lu_i (k))) + sum_(k = K + 1)^infinity 1/2^k\
      &<= sum_(k = 1)^K 1/2^k abs(x(k) - lu_i (k))/(1 + abs(x(k) - lu_i (k))) + epsilon\
      &<= sum_(k = 1)^K 1/2^k abs(x(k) - lu_i (k)) + epsilon\
      &<= sum_(k = 1)^K 1/2^k epsilon + epsilon\
      &<= 2epsilon
    $
    由 $epsilon$ 的任意性，这表明 $A$ 完全有界，证毕。
#let lA = $overline(A)$
= 1.
  - 一方面，假设 $lA$ 完全有界，则当然 $A subset lA$ 完全有界
  - 另一方面，注意到：
    $
      A subset union_i B(a_i, epsilon) => lA subset overline(union_i B(a_i, epsilon)) = union_i overline(B(a_i, epsilon)) subset union_i B(a_i, 2 epsilon)
    $
    因此 $A$ 完全有界当然导出 $lA$ 完全有界
= 2.
  - $(a) => (b)$： 如若不然，则存在 $x_0, epsilon_0$ 使得：
    $
      forall i, exists x_i in B(x_0, 1/i) suchThat d(f(x_i), f(x_0)) > epsilon_0
    $ 
    不难发现 $x_i -> x_0$ 但 $f(x_i)$ 不可能以 $f(x_0)$ 为极限，矛盾！
  - $(b) => (c)$：任取 $x in Inv(f) (V)$，往证 $x$ 是内点。由 $V$ 是开集，$f(x) in V$ 是 $V$ 内点，因此存在 $epsilon > 0$ 使得 $B(f(x), epsilon) subset V$。同时，对此 $epsilon$ 利用条件得到：
    $
      exists delta > 0, f(B(x_0, delta)) subset B(f(x_0), epsilon) subset V\
      => exists delta > 0, B(x_0, delta) subset Inv(f) (V) 
    $
    证毕
  - $(c) => (a)$：对于任意 $epsilon > 0$，条件表明：
    $
      Inv(f) (B(f(x_0), epsilon)) "是开集"
    $
    同时，显然 $x_0 in Inv(f) (B(f(x_0), epsilon))$，因此可设 $delta$ 使得：
    $
      B(x_0, delta) subset Inv(f) (B(f(x_0), epsilon))
    $
    由 $x_n -> x_0$，当然有 $n$ 充分大时 $x_n in B(x_0, delta)$，立刻得到：
    $
      x_n in Inv(f) (B(f(x_0), epsilon)) => f(x_n) in B(f(x_0), epsilon)
    $
    由 $epsilon$ 的任意性，这就表明 $f(x_n) -> f(x_0)$，证毕
= 3.
  == (1)
    设 $f_n in B(X, Y)$ 是柯西的，则对任意 $x in X$，注意到：
    $
      d(f_m (x), f_n (x)) <= sup_x d(f_m (x), f_n (x)) = d(f_m, f_n)
    $
    因此序列 $f_i (x)$ 总是柯西的，由完备性它有极限，定为 $f(x)$.

    只需证明 
    - $f_n -> f$:
      对于任意 $x$，找到充分大的 $m_x > n$ 使得 $d(f_(m_x) (x), f(x)) < epsilon$，则：
      $
        d(f_n (x), f(x)) <= d(f_n (x), f_(m_x) (x)) + d(f_(m_x) (x), f(x)) < d(f_n (x), f_(m_x) (x)) + epsilon \ 
        <= d(f_n, f_(m_x)) + epsilon
      $
      由 $f_n$ 的柯西性，$n$ 充分大（与 $x$ 无关）时即有上式 $< 2 epsilon$
    - $f$ 有界：由极限，将存在 $n$ 使得：
      $
        d(f_n, f) < 1
      $
      自然有：
      $
        d(f(x), f(y)) <= 2 d(f, f_n) + d(f_n (x), f_n (y)) < 2 + r_n
      $
      证毕
  == (2)
    事实上就是证明有界连续函数的极限仍然是有界连续函数，假设 $f_i$ 是有界连续的，且极限为 $f$. 对于任意 $x in X, epsilon > 0$，设 $f_n$ 满足：
    $
      d(f_n, f) < epsilon
    $
    由 $f_n$ 的连续性，设：
    $
      f_n (B(x, delta)) subset B(f_n (x), epsilon)
    $
    立刻有：
    $
      f (B(x, delta)) subset B(f_n (x), 2 epsilon) subset B(f (x), 3 epsilon)
    $
    证毕
  == (3)
    
    - 一方面，取 $X = (0, 1) subset RR$，${x^n}_n$ 收敛于 $0$，因此预列紧，但它不可能等度连续，否则将 $X$ 扩大到 $[0, 1]$ 上应该也等度连续（当然是一致有界的），将在 $C([0, 1], RR)$ 中预列紧，然而它的（点）极限函数不是连续函数，矛盾！
    - 另一方面，取 $X = NN$ 以及离散度量，设： 
      $
        f_n (m) = cases(
          m / n space m <= n,
          0 space m > n
        )
      $
      显然它们一致有界，而离散度量下的函数当然都是连续/等度连续的，假设它有子列收敛到 $f$，对于任意 $m$，由于该度量下收敛保证函数点收敛，因此一定有 $f(m) = lim_(i -> +infinity) f_(n_i) (m) = 0$，进而 $f = 0$. 然而不难发现：
      $
        d(0, f_n) = 1 - 1/n
      $
      因此不可能有子列收敛到 $0$，矛盾！


