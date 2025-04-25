#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 2.5.6
  首先 $R(T)$ 作为完备空间 $duelSpace(duelSpace(X))$ 的子空间，是闭的当且仅当是完备的。其次，熟知 $tau$ 是保持范数的单射，因此是 $X -> R(T)$ 的保范同构，当然就有 $R(T)$ 完备当且仅当 $X$ 完备
= 2.5.15
  设 $S = span(e_n)$，显然 $S$ 稠密，并且典范的保范映射 $f s = x arrowb inner(x, s)$ 下，$f(S)$ 也稠密，注意到 $X$ 是自反的，因此弱收敛等价于弱\*收敛。由 Banach-Steinhaus 定理的结论，有 $x_n weakConverge x_0 <=> tau(x_n) weakSConverge tau(x)$ 当且仅当：
  - $norm(x_n)$ 有界
  - $
    &forall t in f(S), t x_n -> t x\
    <=>& forall s in S, (f s) x_n -> (f s) x\
    <=>& forall s in S, inner(x_n, s) -> inner(x, s)\
    <=>& forall k in NN, inner(x_n, e_k) -> inner(x, e_k)\
    $
= 2.5.23
  #lemmaLinear[][
    闭凸集是弱拓扑下的闭集
  ]
  #proof[
    设 $x_n in M weakConverge x_0$，由 Mazur 定理得：
    $
      x_0 in closure(cov(M)) = M
    $
    证毕
  ]
  经过伸缩，不妨设 $M$ 是单位球的子集。注意到 $duelSpace(X)$ 也是自反空间，Banach-Alaoglu 定理给出 $duelSpace(duelSpace(X))$ 中的单位球弱列紧，通过典范的保范同构 $tau$ 得到 $X$ 中单位球也弱列紧，进而由引理 $M$ 作为弱拓扑下的闭集也是。现任取 $x_n in M$ 使得 $f x_n -> sup_(x in M) f x ("可能为" infinity)$，由弱列紧性，不妨设 $x_n weakConverge x_0$，换言之 $f x_n -> f x_0$，这表明 $f x_0 = sup_(x in M) f x$，因此 $x_0$ 就是最大值点。最小值点同理。
= 2.5.24
  仿照上面的证明，设 $x_n in M$ 使得 $norm(x_n) -> inf_(x in M) norm(x)$，不妨设 $x_n weakConverge x_0$. 熟知：
  $
    norm(x) = sup_(f in duelSpace(X), norm(f) = 1) abs(f x)
  $
  设 $norm(f) = 1$，我们有：
  $
    abs(f x_n) <= norm(x_n)
  $
  令 $n -> infinity$ 有：
  $
    abs(f x_0) <= limn(norm(x_n)) = inf_(x in M) norm(x)
  $
  这对所有 $f$ 成立，继而：
  $
    norm(x_0) = sup_(f in duelSpace(X), norm(f) = 1) abs(f x_0) <= inf_(x in M) norm(x)
  $
  然而另一方面当然有 $norm(x_0) >= inf_(x in M) norm(x)$，因此 $norm(x_0) = inf_(x in M) norm(x)$，证毕
= 1
  #lemmaLinear[][
    设 $E$ 是 Banach 空间的紧子集，若 $x_n in E$ 的所有收敛子列都收敛于 $a$，则 $x_n -> a$
  ]
  #proof[
    注意到 $x_n -> a$ 当且仅当 $norm(x_n - a) -> 0$，如若不然，则存在子列使得 $norm(x_(n_k) - a) arrow.not 0$，再取 $x_(n_k)$ 的收敛子列，则它的极限不可能为 $a$，然而它也是原序列的收敛子列，矛盾！

  ]
  设 $x_n weakConverge x_0$，对 $x_n$ 的任何收敛子列 $x_(n_k) -> a$，都有 $x_(n_k) weakConverge a$，继而 $a = x_0$，由引理可得 $x_n -> x_0$
= 2
  #lemmaLinear[][
    设 $x_n$ 不收敛，则存在两个子列 $a_n, b_n$ 以及 $delta > 0$ 使得：
    $
      norm(a_n - b_n) >= delta
    $
  ]
  #proof[
    若序列无界则结论显然，否则考虑序列 $a_n = sup_(i, j > n) norm(x_i - x_j)$，$x_n$ 不收敛当且仅当 $a_n$ 不收敛于 $0$（否则与柯西列收敛矛盾），这就保证了有无穷多对 $(i, j)$ 使得：
    $
      norm(x_i - x_j) >= 1/2 limsup_(n -> infinity) a_n > 0
    $
    排成两个子列即可。
  ]
  为了方便起见，在严格凸的定义中补充 $epsilon(0) = 0$，可以验证此时不需要 $x != y$ 也有 $norm((x + y)/2) <= 1 - epsilon(norm(x - y))$，同时 $epsilon$ 仍在非零处非零，其他性质同样成立。

  无妨设 $x != 0$，否则 $norm(x_n) -> 0 => x_n -> 0$，设：
  $
    alpha_n = 1/norm(x_n) x_n
  $
  可以证明 $alpha_n weakConverge x_0/norm(x_0)$. 假设 $alpha_n$ 不收敛，则取引理中两个子列 $a_n, b_n$，注意到显然有 $(a_n + b_b)/2 weakConverge x_0/norm(x_0)$，由 Mazur 得：
  $
    x_0/norm(x_n) in closure(cov({(a_n + b_n)/2}))
  $
  也即对于任何 $epsilon > 0$，可设：
  $
    norm(x_0/norm(x_0) - sumi1inf(lambda_i (a_n + b_n)/2)) < epsilon
  $
  其中 $sumi1inf(lambda_i) = 1$ 且 $lambda_i$ 仅有有限个非零，进而：
  $
    norm(sumi1inf(lambda_i (a_n + b_n)/2)) >= norm(x_0/norm(x_0)) - epsilon = 1 - epsilon
  $
  然而：
  $
    norm(sumi1inf(lambda_i (a_n + b_n)/2)) <= sumi1inf(lambda_i norm(a_n + b_n)/2) <= sumi1inf(lambda_i (1 - epsilon(norm(a_n - b_n)))) \
    = 1 - sumi1inf(lambda_i epsilon(norm(a_n - b_n))) <= 1 - epsilon(delta)
  $
  表明：
  $
  &epsilon(delta) < epsilon, forall epsilon \
  &=> epsilon(delta) = 0 \
  &=> delta = 0
  $
  矛盾！因此 $alpha_n$ 有极限，而 $alpha_n weakConverge x_0/norm(x_0)$，因此只能 $alpha_n -> x_0/norm(x_0)$，进而 $x_0 = norm(x_n) alpha_n -> norm(x_0) x_0/norm(x_0) = x_0$
= 3
  对于所有 $n$，序列 $x_n, x_(n + 1), ... $ 弱收敛于 $x$，由 Mazur 定理可得：
  $
    x in closure(cov({x_n, x_(n + 1), ...}))
  $ 
  因此可设 $y_n$ 使得：
  $
    y_n in cov({x_n, x_(n + 1), ...}), norm(x - y_n) < 1/n
  $
  显然这列 $y_n$ 就满足题目要求
= 4
  假设 $x_n weakConverge x_0$ 但不强收敛，就有 $x_n - x_0 arrow.not 0$，也即 $norm(x_n - x_0) arrow.not 0$，不妨设 $norm(x_n - x_0) > delta > 0$（否则取子列即可），进而 $(x_n - x_0)/norm(x_n - x_0)$ 满足 $norm((x_n - x_0)/norm(x_n - x_0)) = 1, (x_n - x_0)/norm(x_n - x_0) weakConverge 0$，因此不妨设 $norm(x_n) = 1, x_n weakConverge 0$

  接下来，首先取得 $N_1$ 使得：
  $
    sum_(i = N_1)^infinity abs(x_1 (i)) < 1/100
  $
  由 $sumi1inf(abs(x_1 (i))) < +infinity$ 这是容易的。接下来，取得 $M_1$ 使得：
  $
    sum_(i = 1)^N_1 abs(x_(M_1) (i)) < 1/100
  $
  这是因为对于 ${1, 2, ..., N_1}$ 的任何子集 $S$，考虑：
  $
    f_S (i) := ite(
      i <= N_1, (ite(
        i in S, 1, -1
      )), 0
    )
  $
  显然 $f_S in l^infinity = duelSpace(l^1)$，由弱收敛性：
  $
    forall S in P({1, 2, ..., N_1}), inner(f_S, x_n) -> 0\
  $
  而 $P({1, 2, ..., N_1})$ 是有限集，因此取 $M_1$ 使得：
  $
    forall S in P({1, 2, ..., N_1}), inner(f_S, x_M_1) < 1/100\
  $
  由定义可以验证：
  $
    exists S in P({1, 2, ..., N_1}), inner(f_S, x_M_1) = sum_(i = 1)^N_1 abs(x_(M_1) (i))
  $
  这就保证了 $sum_(i = 1)^N_1 abs(x_(M_1) (i)) < 1/100$

  同理，取得 $N_2 > N_1$ 使得 $sum_(i = N_2)^infinity abs(x_M_1 (i)) < 1/100$，取得 $M_2 > M_1$ 使得 $sum_(i=1)^(N_2) abs(x_(M_2) (i)) < 1/100$，以此类推产生 $N_k$ 和 $M_k$

  构造 $y in l^infinity$ 使得：
  $
    y(i) = ite(N_k <= i < N_(k + 1), sgn(x_(M_k) (i)), 0)
  $
  则：
  $
    inner(y, x_(M_k)) &= sum_(i = 1)^(N_k) x_(M_k) (i) y(i) + sum_(i = N_k)^(N_(k + 1)) abs(x_(M_k) (i)) + sum_(i = N_(k + 1))^infinity x_(M_k) (i) y(i)\
    &= norm(x_(M_k)) + sum_(i = 1)^(N_k) x_(M_k) (i) y(i) - abs(x_(M_k)) + sum_(i = N_(k + 1))^infinity x_(M_k) (i) y(i) - abs(x_(M_k) (i))\
    &>= norm(x_(M_k)) + sum_(i = 1)^(N_k) -2abs(x_(M_k) (i)) + sum_(i = N_(k + 1))^infinity -2abs(x_(M_k) (i))\
    &>= 1 - 1/25 = 24/25\
  $
  然而由弱收敛性，应当有 $inner(y, x_(M_k)) -> 0$，矛盾！


