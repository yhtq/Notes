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

= 3.2.1
  由题设可设：
  $
    X = span(autoRListN(x, n)) directSum M
  $
  且 $x_i$ 线性无关。取 $tau: X -> duel(duel(X))$，则 $tau(x_i)$ 也线性无关，由课上引理存在 $f_i in duelSpace(X)$ 使得：
  $
    inner(tau(x_i), f_j) = inner(f_i, x_i) = delta_(i j)
  $
  取 $P : X -> span(autoRListN(x, n))$ 是投影算子（后面的习题说明投影算子的存在性），断言：
  $
    inter_(k = 1)^n ker f_i P = M
  $
  事实上，不难验证 $M subset inter_(k = 1)^n ker f_i P$，而另一方面，对于任何 $x in inter_(k = 1)^n ker f_i P$，设 $x = sum_i c_i x_i + m$，就有：
  $
    0 = f_i P (sum_i c_i x_i + m) = c_i ,forall i => x in M
  $
  此外由定义容易验证，$f_i|_span(autoRListN(x, n)) = duel(x_i)$ 线性无关，当然 $f_i P$ 也无关
= 3.2.4 
  == (1)
    取 $pi : X -> X quo ker T$，注意到：
    $
      norm(pi x) = inf_(y in ker T) norm(x + y) 
    $
    只需证明右侧下确界可以取得即可。事实上，我们有：
    $
      norm(x + y) >= norm(y) - norm(x)
    $
    表明 $norm(y)$ 充分大时，$norm(x + y)$ 也充分大，因此它只能在 $ker T$ 的一个有界范围内取得。由 Fredholm 理论，$ker T$ 是有限维空间，而有限维空间中的有界闭集是紧的，而 $y arrowb norm(x + y)$ 是连续函数，因此最小值可以取得。
  == (2)
    假设方程有一个解 $x_0$，则熟知其所有解形如：
    $
      x_0 + ker T
    $
    换言之，只需证明存在 $y in ker T$ 使得 $norm(x + y) = inf_(y in ker T) norm(x + y)$，这就是上一问结论。
= 3.2.6
  == (1)
    可设：
    $
      X = M directSum N, where N eqv X quo N
    $
    则 $P := m + n arrowb m$ 就是一个线性的投影算子。同时，等价范数定理的推论给出：
    $
      norm(P(m + n)) <= norm(m) <= norm(m) + norm(n) <= c norm(m + n)
    $
    说明 $P$ 是有界算子。
  == (2)
    我们有：
    $
      (I - P)^2 = I - 2 P + P^2 = I - P
    $
    因此 $I - P$ 是到 $im I - P$ 的有界幂等线性算子
  == (3)
    - 任取 $x in X$，有 $x = P x + (I - P) x$，表明 $X = M + N$
    - 设 $y in M inter N$，则 $P u = (I - P) v = y, v = P(u + v) => y = (I - P) P (u + v) = 0$，因此 $M inter N = 0$
    表明 $X = M directSum N$
  == (4)
    代数意义下结论是熟知的。拓扑意义下，我们证明：
    #lemmaLinear[][
      设 $M, N$ 是闭子空间，$X = M directSum N$，则拓扑意义下有：
      $
        X eqv M times N
      $
      且投影映射分别为 $P, I - P$
    ]
    #proof[
      考虑：
      $
        funcDef(f, M times N, M directSum N, (m, n), m + n)
      $
      则显然它是 Banach 空间之间的线性双射（注意到采用 $norm((m, n)) = norm(m) + norm(n)$，则 $M times N$ 当然也是 Banach 空间），同时，我们有：
      $
        norm(m + n) <= norm(m) + norm(n) <= norm((m, n))
      $
      表明 $f$ 是有界的，由 Banach 逆算子定理，它的逆算子也是有界的，继而 $f$ 是拓扑同胚。
    ]
    由引理，结论是显然的。
= 3.3.1
  == (1)
    - 假设 $A in L(l^1)$，则：
      $
        norm(A e_i) = norm(a_i e_i) = abs(a_i) <= norm(A) norm(e_i) = norm(A) 
      $
      因此 $sup abs(a_n) <= norm(A)$
    - 假设 $sup abs(a_n) <= c$，则：
      $
        norm(A x) = sumi1infnr(a_i x_i) <= sup abs(a_i) sumi1infnr(x_i) = sup abs(a_i) norm(x)
      $
  == (2)
    不难验证：
    $
      Inv(A) (x_1, x_2, ...) = (1/a_1 x_1, 1/a_2 x_2, ...)
    $
    因此由 (1) 可知结论成立
  == (3)
    - 若 $A in C(l^1)$，不难验证 $a_n$ 都是 $A$ 的特征值，而紧算子的特征值只能以零为聚点，因此 $limn(a_n) = 0$
    - 若 $limn(a_n) = 0$，习题 3.1.6 给出 $A$ 是紧算子
= 3.3.4
  （不妨设 $m != 0$）只需验证：
  - $ker T^m = ker T^(m + 1)$，任取 $x in ker T^(m + 1)$，由题设可设：
    $
      x = u + T^m v, u in ker T^m 
    $
    则 $T^(m + 1) u + T^(2 m + 1) v = 0 => T^(2 m + 1) v = 0 => T^(m + 1) v in ker T^m inter im T^m => T^(m + 1) v= 0$

    由此，不难验证：
    $
      T^M x = T^m u + T^(2 m) v = 0
    $
  - $im T^m = im T^(m + 1)$，任取 $T^m x$，由题设可设：
    $
      x = u + T^m v, u in ker T^m\
      T^m x = T^(2 m) v = T^(m + 1) (T^(m - 1) v)
    $
    这就表明 $T^m x in im T^(m + 1)$
= 3.3.7
  注意到：
  $
    A x = f(x) x_0\
    A^2 x = f(x) A x_0 = f(x) f(x_0) x_0 = f(x) x\
  $
  从而 $A = A^2$，进而 $T = I - A$ 也是幂等的，当然 $p = 1$
= 1.
  首先，不难发现：
  $
    I = {f in CC[x] | f(A) "是紧算子"}
  $
  是非空理想，因此是主理想，可设 $I = (m(x))$，其中：
  $
    m(x) = prodi1n(x - lambda_i)
  $
  #lemmaLinear()[][
    设 $lambda != lambda_i, forall i$，则 $dim ker (lambda I - A) < +infinity$ 且 $im (lambda I - A)$ 是闭的
  ]
  #proof[
    设：
    $
      m(x) = (lambda - x) p(lambda - x) + C 
    $
    由条件，$C != 0$，以及：
    $
      m(A) = (lambda I - A) p(lambda I - A) + C I\
      - 1/C (lambda I - A) p(lambda I - A) = I - 1/C m(A)
    $
    而 $m(A)$ 是紧算子，这表明：
    $
      dim ker (lambda I - A) p(lambda I - A) < +infinity
    $
    同时显然：
    $
      ker (lambda I - A) subset ker (lambda I - A) p(lambda I - A)
    $
    因此结论成立。
    
    再证明 $im (lambda I - A)$ 是闭的。设 $tilde(T)$ 是 $X quo (ker (lambda I - A)) -> X$ 的诱导映射，只需证明 $inf norm(T x)/norm(x) > 0$；否则，不妨设 $x_n$ 满足：
    - $norm(pi x_n) = 1$
    - $tilde(T) pi x_n = lambda x_n - A x_n -> 0$
    - $1 <= norm(x_n) <= 2$
    - $m(A) x_n -> omega$
    则有：
    $
      m(A) x_n = p(lambda I - A) (lambda x_n - A x_n) + C x_n -> omega\
      p(lambda I - A) (lambda x_n - A x_n) -> 0\
      x_n -> omega / C\
      A omega = lambda omega\
      omega in ker (lambda I - A)\
      pi omega = 0
    $
    显然，这已经与 $norm(pi x_n) = 1$ 相矛盾！
  ]
  接下来，假设 $lambda != lambda_i$ 证明之后的命题：
  == (2)
    === $->:$
      假设 $ker (lambda I - A) = 0$，由算子升降链的性质，只需证明降链 $im (lambda I - A) >= im (lambda I - A)^2 >= ...$ 在有限步终止，立刻就有 $X = 0 directSum im (lambda I - A)$ 表明结论成立。事实上，设 $p(x)$ 是 $n$ 次多项式，
      我们有：
      $
        im (lambda I - A) >= im (lambda I - A) p(lambda I - A) >= im (lambda I - A)^(n + 1)
      $
      立刻就有：
      $
        im (lambda I - A)^r >= im ((lambda I - A) p(lambda I - A))^r >= im (lambda I - A)^(r (n + 1))
      $
      由紧算子性质，不妨假设 $im ((lambda I - A) p(lambda I - A))^r$ 已经终止，就有：
      $
        im (lambda I - A)^(r (n + 2)) >= im ((lambda I - A) p(lambda I - A))^(r (n + 2)) = im (lambda I - A)^(r) >= im (lambda I - A)^(r (n + 1))
      $
      继而 $im (lambda I - A)^(r (n + 2)) = im (lambda I - A)^(r (n + 1))$，表明结论成立。
    === $<-:$
      假设 $im (lambda I - A) = X$，而 $ker lambda I - A$ 有限维，升链一定终止，因此升降链同时在 $1$ 处终止，也即：
      $
        X = im (lambda I - A) directSum ker (lambda I - A)\
      $
      当然就有 $ker (lambda I - A) = 0$
  == (3)
    熟知：
    $
      im (lambda I - A) eqv^f orthogonalCom(ker (lambda I - duel(A)))
    $
    以及：
    $
      X = ker (lambda I - A) directSum im (lambda I - A)\
      ker (lambda I - A) = span(autoRListN(x, n))
    $
    由与书上类似的证明，可设：
    $
      ker (lambda I - duel(A)) = span(autoRListN(f, n))\
      X = span(autoRListN(y, m)) directSum orthogonalCom(ker (lambda I - duel(A)))\
      f_i (y_j) = delta_(i j)\
    $
    假设 $m > n$，类似构造：
    $
      funcDef(T', X, X, sum_i c_i x_i + z, sum_i c_i y_i + (lambda I - A) z)
    $
    就有：
    $
      T' (sum_i c_i x_i + z) = lambda (sum_i c_i x_i + z) - A z + sum_i c_i (y_i - lambda x_i) 
    $
    由于 $sum_i c_i x_i + z arrowb sum_i c_i (y_i - lambda x_i)$ 是有限秩算子，不难验证存在多项式 $q(x)$ 使得：
    $
      q (sum_i c_i x_i + z arrowb A z - sum_i c_i (y_i - lambda x_i)) "是紧算子"
    $
    结合不难验证 $T'$ 是单射，则 $T'$ 是满射，矛盾！因此 $m <= n$ 也即 $dim ker (lambda I - duel(A)) <= dim ker (lambda I - A)$，进一步有：
    $
      dim ker (lambda I - A) <= dim ker (lambda I - duel(duel(A))) <= dim ker (lambda I - duel(A)) <= dim ker (lambda I - A)
    $
    因此全部取等。
