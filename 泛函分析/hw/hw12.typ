#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

#show: note.with(
  title: "作业11",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)

= 3.4.2
  由题设，$A$ 是单的正定自伴算子，因此所有特征值都是正的。利用谱定理，设 $A e = lambda(e) e$，对于 $x = sum_(e) inner(x, e) e$，有：
  $
    A x = sum_(e) lambda(e) inner(x, e) e\
    norm2(A x) = sum_e lambda(e)^2 abs(inner(x, e))^2\
    inner(A x, x) = sum_e lambda(e) abs(inner(x, e))^2\
    norm(A) = r(A)
  $
  显然就有：
  $
    norm(A) inner(A x, x) = sum_e r(A) lambda(e) abs(inner(x, e))^2 >= sum_e lambda(e)^2 abs(inner(x, e))^2 = norm2(A x)
  $
= 3.4.3 
  == (1)
    考虑 $A' = A - ((m (A) + M(A))/2) I$，显然此时有：
    $
      m(A') <= 0 <= M(A')
    $
    由熟知结论：
    $
      r(A') = norm(A') = sup_(norm(x) = 1) abs(inner(A' x, x)) = max {abs(M(A')), abs(m(A'))} = (M(A) - m(A))/2
    $
    显然这就蕴含
    $
      sigma(A') subset [-(M(A) - m(A))/2, (M(A) - m(A))/2]\
      sigma(A) subset [m(A), M(A)]
    $
    其次，再考虑 $A'' = A - ((m (A) + 2 M(A))/3) I$，此时可以验证：
    $
      r(A'') = M(A'') = 2/3 (M(A) - m(A))\
      m(A'') = -1/3 (M(A) - m(A))\
    $
    由于 $sigma(A'') subset RR$ 是闭集，一定有 $r(A'') in sigma(A'')$ 或 $-r(A'') in sigma(A'')$，由上面的式子，一定有 $r(A'') = M(A'') in sigma(A'')$，就有：
    $
      M(A) in sigma(A)\
    $
    类似的，可以证明 $m(A) in sigma(A)$

    对于之后两个结论，已经证明对于紧算子，$sigma(A) - {0} = sigma_p (A) - {0}$，因此结论是显然的。
= 3.4.5
  - 一方面，显然正交投影算子是幂等的。对于对称性，有：
    $
      inner(P x, y) = inner(P x, P y + (I - P) y) = inner(P x, P y) = inner((I - P) x + P x, P y) = inner(x, P y)
    $
  - 假设 $P$ 对称幂等，由于：
    $
      P (I - P) = 0
    $
    则 $sigma(P) subset {0, 1}$，结合 $r(P) = norm(P)$ 可得 $norm(P) <= 1$. 同时，熟知：
    $
      H = im P directSum im (I - P)
    $
    并且容易验证 $im P = ker (I - P), im (I - P) = ker P$，以及熟知 $ker (I - P), ker P$ 正交（不同特征值的特征子空间），因此 $im P orthogonal im (I - P)$，$P$ 就是到 $im P$ 的正交投影算子。
= 2.4.6
  #lemmaLinear[][
    设 $P, Q$ 是自伴有界算子，且：
    $
      forall x, inner(P x, x) = inner(Q x, x)
    $
    则 $P = Q$
  ]
  #proof[
    由题设，有：
    $
      inner(P (x + y), x + y) = inner(Q (x + y), x + y)\
      inner(P y, x) + inner(P x, y) = inner(Q y, x) + inner(Q x, y)\
      Re inner(P y, x) = Re inner(Q y, x), forall x, y
    $
    用 $i x$ 替代 $x$ 就有：
    $
      im inner(P y, x) = im inner(Q y, x), forall x, y\
    $
    也即：
    $
      forall x, y, inner((P - Q) y, x) = 0 
    $
    足以表明 $P = Q$
  ]
  必要性是平凡的，对于充分性，由题设及熟知结论可得 $P$ 是对称的，且：
  $
    inner(P x, x) = inner(P x, P x) = inner(P^2 x, x), forall x
  $
  由引理，$P = P^2$，结合前面的习题可得结论成立。
= 3.4.8
  必要性是平凡的。对于充分性，若 $L$ 不是 $M$ 的子空间，则可在 $L$ 中取得 $L inter M$ 的正交补，就存在 $y != 0 in L$ 使得 $y orthogonal M$，此时：
  $
    inner((P_M - P_L) y, y) = inner(P_M y, y) - inner(P_L y, y) = - norm2(y)
  $
  由题设，只能有 $y = 0$，矛盾！
= 3.4.9
  // #lemmaLinear[][
  //   $NN$ 的度量采用 $abs(x - y)$，$Y$ 是完备度量空间，对于 $F subset C(NN, Y)$ 是闭集，且 $F$ 点预紧，等度连续，则 $F$ 是紧的。
  // ]
  // #proof[
  //   显然 $NN$ 的每个有限集都是紧的，由 Ascoli-Arzelà 定理，$F$ 在每个有限集的限制上都是紧的。我们证明对于任何序列 $F_0$ 都有收敛子列。递归构造：
  //   - $F_1 subset F_0$ 在 ${1} -> CC$ 上有唯一聚点 $y_1, d(F_1, y_1) < 1$
  //   - $F_2 subset F_1$ 在 ${1, 2} -> CC$ 上有唯一聚点 $y_2, d(F_2, y_2) < 1/2$
  //   - $F_n subset F_(n-1)$ 在 ${1, 2, ..., n} -> CC$ 上有唯一聚点 $y_n, d(F_n, y_n) < 1/n$
  //   - ...
  //   不难证明，$y_n|_{1, 2, ..., n - 1} = y_(n - 1)$，定义 $y_n$ 的点极限 $y$，任取 $x_n in F_n$，断言：
  //   $
  //     sup_(i in NN) abs(x_n (i) - y(i)) -> 0
  //   $
  //   事实上：
  //   $
  //     // abs(x_n (i) - y(i)) <= abs(x_n (i) - x_i (i)) + abs(x_i (i) - y_i (i)) + abs(y_i (i) - y (i))
  //     // <= abs(x_n (i) - x_i (i)) + 1/i
  //     abs(x_n (i) - y(i)) <= abs(x_n (i) - y_n (i)) + abs(y_n (i) - y_i (i)) + abs(y_i (i) - y(i))\
  //     <= 1/n + abs(y_n (i) - y_i (i))
  //   $
  // ]
  == 1
    将 $l^2$ 的元素看作 $NN -> CC$，取 $F = {x_n} subset l^2$ 使得 $norm(x_n) <= 1$ ，只需找到 $A (F)$ 的一个聚点即可。递归构造：
    - $A(F_1) subset A(F)$ 在 ${1} -> CC$ 上一致收敛于 $y_1, d_{1}(A(F_1), y_1) < 1$
    - $A(F_2) subset A(F_1)$ 在 ${1, 2} -> CC$ 上一致收敛于 $y_2, d_{1, 2}(A(F_2), y_2) < 1/2^2$
    - ...
    - $A(F_n) subset A(F_(n-1))$ 在 ${1, 2, ..., n} -> CC$ 上一致收敛于 $y_n, d_{1, 2, ..., n} (A(F_n), y_n) < 1/(2^n)$
    定义 $y$ 是 $y_n$ 的点极限，任取 $x_n in F_n$，断言：
    $
      A x_n -> y
    $
    事实上：
    $
      norm(A x_n - y) <= norm(A x_n - y_n) + norm(y_n - y) <= 1/2^n + norm(y_n - y) 
    $
    只需证明 $y_n -> y$，为此，对 $m > n$ 计算：
    $
      norm(y_n - y_m) <= norm(A s - A t) + 1/2^n + 1/2^m
    $
    其中 $s in F_n, t in F_m$，注意到 $F_m subset F_n$，因此对 $i <= n$ 都有：
    $
      abs(A s(i) - A t(i)) <= d_n (A s, y_n) + d_n (A t, y_n) <= 2/2^n
    $
    继而：
    $
      norm2(A s - A t) = sum_(i = 1)^n (A s(i) - A t(i))^2 + sum_(i = n + 1)^infinity (A s(i) - A t(i))^2\
      <= (2 n)/2^n + sum_(i = n + 1)^infinity (A s(i) - A t(i))^2\
      <= (2 n)/2^n + sum_(i = n + 1)^infinity (sum_(j = 1)^infinity a_(i j) s(j) -sum_(j = 1)^infinity a_(i j) t(j))^2\
      <= (2 n)/2^n + sum_(i = n + 1)^infinity (sum_(j = 1)^infinity a_(i j) (s(j) - t(j)))^2\
      <= (2 n)/2^n + sum_(i = n + 1)^infinity (sum_(j = 1)^infinity a_(i j)^2) norm(s - t)\
      <= (2 n)/2^n + 2 sum_(i = n + 1)^infinity (sum_(j = 1)^infinity a_(i j)^2)\
    $
    由于 $sum_(i = 1)^infinity (sum_(j = 1)^infinity a_(i j)^2) < +infinity$，因此上式在 $n, m$ 充分大时 $-> 0$，证毕
  == 2
    $
      inner(A x, y) 
      &= sumi1inf(sumj1inf(a_(i j) x_j) overline(y_i))\
      &= sumj1inf(sumi1inf(a_(i j) overline(y_i)) x_j)\
      &= sumj1inf(x_j sumi1inf(a_(i j) overline(y_i)) )\
      &= sumi1inf(x_i sumj1inf(a_(j i) overline(y_j)) )\
      &= sumi1inf(x_i sumj1inf(overline(a_(i j) y_j )) )\
      &= inner(x, A y)
    $
    证毕
= 3.4.10
  设 $E$ 是题设正交基，$lambda(e : E) : sigma_p (A)$ 是 $e$ 对应的特征值。任取 $epsilon > 0$，设：
  $
    sigma_epsilon = sigma_p (A) - [-epsilon, epsilon]\
    H_epsilon = directSum_(lambda in sigma_epsilon) ker (lambda I - A)\
  $
  则 $H_epsilon$ 是有限维空间，再取 $P$ 是到 $H_epsilon$ 的正交投影，$A_epsilon = A P_epsilon$，计算：
  $
    norm(A - A_epsilon) = norm(A (I - P)) 
  $
  而任取 $x = sum_(e in E) inner(x, e) e$，有：
  $
    norm(A (I - P) x)^2 
    &= norm2(sum_(e in E - Inv(lambda) (sigma_epsilon)) lambda(e) inner(x, e) e)\
    &= sum_(e in E - Inv(lambda) (sigma_epsilon)) lambda(e)^2 abs(inner(x, e))^2\
    &<= sum_(e in E - Inv(lambda) (sigma_epsilon)) epsilon^2 abs(inner(x, e))^2\
    &<= epsilon^2 sum_(e in E - Inv(lambda) (sigma_epsilon))  abs(inner(x, e))^2\
    &<= epsilon^2 norm2(x)\
  $
  进而 $norm(A - A_epsilon) <= epsilon$，而 $A_epsilon$ 是有限秩算子。由 $epsilon$ 的任意性，$A$ 可以被有限秩算子任意逼近，因此 $A$ 是紧算子。
= 1
  取 $E$ 是 $duel(A) A$ 特征向量组成的正交基，$sigma = sigma_p (duel(A) A) = sigma_p (A duel(A))$, $lambda(e : E) : sigma$ 是对应的特征值。注意到：
  $
    forall e in E, A duel(A) A e = lambda(e) A e
  $
  换言之，$A e$ 是 $A duel(A)$ 对应特征值 $lambda(e)$ 的特征向量。然而 $A duel(A) = duel(A) A$，这表明对于任何 $lambda != 0 in sigma, ker (lambda I - duel(A) A)$ 是 $A$ 的不变子空间。进一步，不难发现 $duel(A) A e = 0 => inner(A e, A e) = 0 => A e = 0$，因此 $ker A = ker duel(A) A$，总之就有：
  $
    forall lambda in sigma, A (ker (lambda I - duel(A) A)) subset ker (lambda I - duel(A) A)
  $
  - 对于 $lambda != 0$，由熟知结论 $ker (lambda I - duel(A) A)$ 是有限维空间，利用有限维空间的结论，$A|_(ker (lambda I - duel(A) A))$ 可被对角化。
  - 对于 $lambda = 0$，显然只需任取一组正交基就构成 $A$ 的特征向量。
  综上，结合 $duel(A) A$ 的特征空间正交分解，我们就得到了 $A$ 的特征空间正交分解。