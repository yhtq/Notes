#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

#show: note.with(
  title: "作业10",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 3.1.3
  注意到：
  $
    im K = union_(n = 1)^(+infinity) K(closedBall(0, n))\
    X = union_(n = 1)^(+infinity) Inv(A)(K(closedBall(0, n)))
  $
  由 Baire 纲定理可知，存在某个 $n$ 使得 $B(x_0, epsilon_0) subset Inv(A)(K(closedBall(0, n)))$，相当于：
  $
    A(B(x_0, epsilon_0)) subset K(closure(B(x_0, epsilon_0)))
  $
  上式右侧是紧集，因此左侧预紧。通过平移、伸缩不难验证 $A(B(0, 1))$ 也预紧，证毕
= 3.1.4
  假设 $A$ 是紧算子，不妨设 $A$ 是满射，从而 $A$ 是开映射，可设：
  $
    B(x_0, epsilon_0) subset A(B(0, 1))\
  $
  类似的，这导致 $B(0, 1)$ 预紧，由 Risez 引理可知 $Y$ 有限维
= 3.1.6
  只需证明任取 $norm(x_n^0) <= M$ 都有 $T x_n$ 有收敛子列。依次构造：
  - 取 $x^0_n$ 的一个子列 $x^1_n$ 使得 $x^1_n (1)$ 收敛
  - 取 $x^1_n$ 的一个子列 $x^2_n$ 使得 $x^2_n (2)$ 收敛
  - ...
  我们考虑序列 $x^n_n$，它仍然是 $x_n^0$ 的子列，断言 $T x^n_n$ 收敛，事实上，对于任何 $epsilon > 0$ ：
  $
    abs(T x^n_n (k) - T x^m_m (k)) = abs(omega_k (x^n_n (k) - x^m_m (k)))\
  $
  设 $k > K$ 时，$abs(omega_k) < epsilon$，而注意到 $n > K$ 时，$x^n_n$ 是 $x^K_n$ 的子列，因此对于 $k = 1, 2, ..., K$ 总有 $x^n_n (k)$ 收敛，取 $n, m$ 充分大使得 $forall k = 1, 2, ..., K$ 都有 $abs(x^n_n (k) - x^m_m (k)) < epsilon / (sum_(k = 1)^K abs(omega_k))$，立刻有：
  $
    (sum_(k = 1)^(+infinity) abs(T x^n_n (k) - T x^m_m (k))^p)^(1/p) <= sum_(k = 1)^K abs(omega_k) abs(x^n_n (k) - x^m_m (k)) + (sum_(k = K + 1)^(+infinity) abs(omega_k)^p abs(x^n_n (k) - x^m_m (k))^p)^(1/p)\
    <= epsilon + epsilon (sum_(k = K + 1)^(+infinity)  abs(x^n_n (k) - x^m_m (k))^p)^(1/p) <= epsilon + 2 M epsilon
  $
  由 $epsilon$ 任意性，$T x^n_n$ 柯西，进而收敛，证毕
= 3.1.7
  $f = 0$ 时当然可测，反之，设 $F$ 是紧算子，考虑序列：
  $
    x_n (t) = cases(
      n "if" f(t) != 0,
      0 "else"
    )
  $
  则序列：
  $
    f(t) dot x_n (t)
  $
  应该有收敛子列，这意味着：
  $
    (n_k -n_s)^2 integral_(f(t) != 0)^() f(t)^2  dif t
  $
  关于 $k, s$ 有界，显然这表明 $integral_(f(t) != 0)^() f(t)^2 dif t = 0$ 进而 $f$ 几乎处处为零
= 3.1.11
  #let ixy = $i_(X -> Y)$
  #let iyz = $i_(Y -> Z)$
  #let ixz = $i_(X -> Z)$
  我们用 #ixy, #iyz, #ixz 记嵌入映射。如若不然，则存在序列 $x_n$ 使得：
  $
    norm(ixy x_n) > epsilon norm(x_n) + alpha_n norm(ixz x_n)
  $
  其中 $alpha_n -> +infinity$由于这是齐次式，不妨设 $norm(x) = 1$，由于 $ixy$ 是紧的，不妨设 $ixy x_n -> y$，我们得到：
  $
    norm(ixy x_n) > epsilon + alpha_n norm(ixz x_n)
  $
  取极限发现，上式左侧 $-> norm(y)$，而右侧 $norm(ixz x_n) -> norm(iyz y)$ $epsilon + alpha_n norm(ixz x_n) -> +infinity$，矛盾！
= 1.
  设 $A(I - B) = I$，注意到此时 $(I - B)$ 是单射，由 Fredholm 理论可知它也是满射，因此有右逆，而熟知一个元素同时有左右逆则左右逆相等，因此结论成立。另一侧是类似的
= 2.
  #lemmaLinear[][
    设 $e_n$ 是规范正交族，$A e_n -> x$，则 $x = 0$
  ]
  #proof[
    $
      inner(x, x) = limn(inner(x, A e_n)) = limn(inner(duel(A) x, e_n))
    $
    而熟知 $sumi1inf(inner(duel(A) x, e_i))$ 收敛，因此一定有 $limn(inner(duel(A) x, e_n)) = 0$，证毕
  ]
  假设 $A$ 是紧算子，引理表明预紧集中序列 $A v_n$ 的每个收敛子列极限都为 $0$，进而一定有 $A v_n -> 0$

  设 $I = {A in L(X) | forall "规范正交族" v_n, A v_n -> 0}$，断言：
  - $I$ 加法封闭：显然
  - $I$ 是左理想：显然
  - $I$ 是右理想：设 $B in L(X), A in I$，往证：
    $
      A B v_n -> 0
    $
    注意到：
    $
      B = (B + duel(B))/2 + i (B - duel(B))/(2 i)
    $
    其中 $(B + duel(B))/2, (B - duel(B))/(2 i)$ 都是自伴的，由线性性不妨设 $B$ 自伴且 $norm(B) < 1$，此时就有：
    $
      B = (B + i sqrt(1 - B^2))/2 + (B - i sqrt(1 - B^2))/(2)
    $
    这是两个酉算子的和，而对于酉算子 $U$ 有 $U v_n$ 是规范正交族表明 $A U v_n -> 0$，综上就有结论成立
  - $I$ 是闭的：显然
  - $C(X) subset I$：前已证
  - $1 in.not I$：显然
  综上，$I$ 是 Hilbert 空间的非平凡双边理想，因此只能恰为 $C(X)$，证毕

  另证：只需对 $x_n weakConverge 0$ 证明 $A x_n -> 0$，选取 $n_1 = 1, V_1 = x_1$，递归选取，由条件有：
  $
    (sum_(i = 1)^k duel(V_i)/norm2(V_i)) x_n -> 0 
  $
  因此可取：
  $
    norm((sum_(i = 1)^k duel(V_i)/norm2(V_i)) x_(n_(k + 1))) < 1/(k + 1)
  $
  以及：
  $
    V_(k + 1) = x_(n_(k + 1)) - sum_(i = 1)^k inner(V_i, x_(n_(k + 1)))/norm2(V_i) V_i
  $
  可以验证 $forall i = 1, 2, ..., k, V_k orthogonal V_i$。同时，熟知 $x_n$ 有界，不妨设 $norm(x_n) <= 1$，就有：
  $
    norm(V_(k + 1)) <= 1 + 1/(k + 1) < 2
  $
  如此构造，就有 $V_k$ 是有界的正交族，由条件有：
  $
    A V_k -> 0\
    A x_(n_k) = A V_k + A (x_(n_k) - V_k) -> 0
  $
  表明 $A x_n$ 有子列收敛于零。同理，$A x_n$ 的所有子列都有收敛于零的子列，这就意味着 $A x_n -> 0$
= 3.1.5
  第一个结论就是 3.1.5，对于第二个结论只需注意到：
  $
    X quo ker A eqv im A
  $

  // - 设对于所有规范正交集都有 $A v_n -> 0$，若 $A$ 不是紧算子，取一列 $norm(x_n) = 1$ 使得 $A x_n$ 没有收敛子列，设 $v_n$ 是 $x_n$ 的标准正交化，则条件给出 $A v_n -> 0$，考察 $v_n$ 的定义这相当于：
  //   $
  //     norm(A (I - P_n) x_(n + 1)) -> 0
  //   $
  //   其中 $P_n$ 是到 $span(v_1, v_2, ..., v_n) = span(x_1, x_2, ..., x_n)$ 的投影算子
  // 对任何有界序列 $x_n$，我们有：
  // $
  //   inner(e_n, duel(A) x_n) = inner(A e_n, x_n) -> 0
  // $
  // 任取 $E$ 是一组规范正交基，对于任何有界列 $norm(x_n) <= M$，它们只涉及至多可数个基，不妨设为 $e_n$，就有：
  //   $
  //     x_n = sum_(i = 1)^(+infinity) inner(x_n, e_i) e_i\
  //     A x_n = sum_(i = 1)^(+infinity) inner(x_n, e_i) A e_i\
  //   $
  //   为了证明 $A x_n$ 有收敛子列，只需证明 $A|_(span(e_n))$ 是紧算子即可。因此事实上，不妨设 $span(e_n) = X$。记 $P_n$ 是到 $span(e_1, e_2, ..., e_n)$ 的投影算子，则有：
  //   $
  //     norm(duel(A) - P_n duel(A)) = sup_(norm(x) = 1) norm((I - P_n) duel(A) x) = sup_(norm(x) = 1) sum_(i = n + 1)^(+infinity) inner(duel(A) x, e_i) e_i\
  //     = sup_(norm(x) = 1) sum_(i = n + 1)^(+infinity) inner(x, A e_i) e_i\
  //     = sup_(norm(x) = 1) sqrt(sum_(i = n + 1)^(+infinity) norm(inner(x, A e_i))^2)\
  //   $ 
  //   注意到 $sum_(i = 1)^(+infinity) norm(inner(x, A e_i))^2$ 收敛，因此取 $n$ 充分大，一定有 $sum_(i = n)^(+infinity) norm(inner(x, A e_i))^2$