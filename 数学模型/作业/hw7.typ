#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 1
  #let ek(x) = $e^(- (#x)/2)$
  不难验证 $n$ 次正交多项式构成线性空间。注意到任取 $p_(n-1), p_(n-2)$ 是 $n-1, n-2$ 次正交多项式，$i = 1, 2, ..., d$ ，下面的递推式都可产生 $n$ 次正交多项式 $p_n$：
  $
  p_n = (x_i + a)p_(n-1) + b p_(n-2) \
  where inner(x_i p_(n-1), p_(n-1)) + a inner(p_(n-1), p_(n-1)) = 0\
  inner(x_i p_(n-1), p_(n-2)) + b inner(p_(n-2), p_(n-2)) = 0\
  $
  先考虑小一点的 $n$
  - $n = 1$ 时，多项式 $sum a_i x_i + c$ 是正交多项式就是说：
  $
  integral_(RR^d)^()  (sum a_i x_i + c) ek(norm(x)^2) dif x = 0
  $
  由对称性，当且仅当 $c = 0$，因此 $a_i$ 可以任取，共同零点当然只有 $0$
  - $n = 2$ 时，多项式 $sum a_(i j) x_i x_j + sum_i b_i x_i + c$ 是正交多项式意味着：
    $
    integral_(RR^d)^()  (sum a_(i j) x_i x_j + sum_i b_i x_i + c) ek(norm(x)^2) dif x = 0\
    integral_(RR^d)^()  x_k (sum a_(i j) x_i x_j + sum_i b_i x_i + c) ek(norm(x)^2) dif x = 0, forall k\
    $
    仍然利用对称性化简得：
    $
    integral_(RR^d)^()  (sum a_(i i) x_i^2 +  c) ek(norm(x)^2) dif x = 0\
    integral_(RR^d)^()    b_k x_k^2 ek(norm(x)^2) dif x = 0, forall k\
    $
    当且仅当 $b_k = 0$ 且：
    $
    sum 2 pi a_(i i)  + 2 pi c = 0\
    sum a_(i i) + c = 0
    $
    其余 $a_(i j)$ 自由调整，无共同零点。
  我们断言 $n$ 为偶数时无共同零点，为奇数时只有 $0$ 作为共同零点，为此：
  #lemmaLinear[][
    设 $f(x)$ 是 $RR$ 上一维 $n$ 次正交多项式（权函数为 $ek(x^2)$），则 $forall i, f(x_i)$ 都是 $RR^d$ 上 $n$ 次多项式
  ]<lemma1>
  #proof[
    任取小于 $n$ 次多项式 $p(x_1, x_2, ..., x_n) = sum_i p_i (x_2, ..., x_n) x_1^i$，将有：
    $
    integral_(RR^d)^() sum_i p_i (x_2, ..., x_n) x_1^i f(x_1) ek(norm(x)^2) dif X\
    = sum_i  integral_(RR^d)^() p_i (x_2, ..., x_n) x_1^i f(x_1)ek(norm(x)^2) dif X\
    = sum_i  integral_(RR^d)^() p_i (x_2, ..., x_n) x_1^i f(x_1)ek(x_1^2) ek((x_2^2 + ... + x_n^2)) dif X\
    = sum_i  integral_(RR^(d-1))^() p_i (x_2, ..., x_n) ek((x_2^2 + ... + x_n^2)) dif x_2 dif x_3 ... dif x_n integral_RR x_1^i f(x_1)ek(x_1^2)  dif x_1\
    $
    当然有 $i < n$，因此上式为零
  ]
  #lemmaLinear[][
    设 $f(x)$ 是 $RR$ 上一维 $n >= 2$ 次正交多项式（权函数为 $ek(x^2)$），则：
    - $n$ 为奇数时，$f$ 形如 $x g(x^2)$; $n$ 为偶数时，$f$ 形如 $g(x^2)$
    - $f$ 以 $0$ 为零点当且仅当 $n$ 为奇数
  ]<lemmaNonZero>
  #proof[
    $n = 1, 2$ 时前面已经给出了结论，对于更大的 $n$，注意到有递推式：
    $
    p_n = (x + a)p_(n-1) + b p_(n-2) \
    where inner(x p_(n-1), p_(n-1)) + a inner(p_(n-1), p_(n-1)) = 0\
    inner(x p_(n-1), p_(n-2)) + b inner(p_(n-2), p_(n-2)) = 0\
    $
    递归证明结论：
    - 若 $n$ 是偶数，往证 $a = 0$，这是因为：
      $
      inner(x p_(n-1), p_(n-1)) = inner(x^2 g(x^2), x g(x^2)) = integral_(RR)^() x^3 g(x^2) ek(x^2) dif x = 0 
      $
      （对称性给出）\
      继而：
      $
      p_n = x p_(n-1) + b p_(n-2)
      $
      容易归纳证明上面结论都成立。
    - 若 $n$ 是奇数，同样往证 $a = 0$，这是因为：
      $
      inner(x p_(n-1), p_(n-1)) = inner(x g(x^2), g(x^2)) = integral_(RR)^() x g(x^2) ek(x^2) dif x = 0 
      $
      （对称性给出）\
      继而类似可以论证
  ]
  #lemmaLinear[][
    设 $U$ 是任意正交变换，$f(X)$ 是 $n$ 次正交多项式，则 $f(U X)$ 也是 $n$ 次正交多项式
  ]<lemma2>
  #proof[
    注意到正交变换不改变多项式的次数，做简单的积分换元即可。
  ]
  由一元正交多项式的结论，设 $f_n$ 是 $RR$ 上 $n$ 次正交多项式，有 $n$ 个不同的根 $x_1, x_2, ..., x_n$，令 $Z_1 = {x_1, ..., x_n}$\
  假设 $RR^d$ 上 $n$ 次正交多项式的共同零点集为 $S$，断言：
  - $S subset Z_1^d$，既然由 @lemma1 $f_n (x_1), f_n (x_2), ..., f_n (x_d)$ 都是 $n$ 维正交多项式，结论是显然的
  - 设 $G$ 是 $RR^d$ 上所有正交变换构成的群，则 $G Z = Z$，这是 @lemma2 的直接推论
  然而 $Z_1^d$ 是离散点集，$G$ 在每个非零点的轨道都是一个圆，显然以上两者同时成立蕴含 $Z = {0} orC emptyset$\
  @lemmaNonZero 表明 $n$ 为偶数时，$f_n (x_i)$ 不以零为零点，当然就有 $Z = emptyset$\
  而当 $n$ 为奇数时，设 $f(x)$ 是 $n$ 次 $d$ 维正交多项式。对 $n, d$ 作归纳，$n = 1 orC d = 1$ 时已经证明，注意到若设：
  $
  f(x) = sum_(i= 0)^n p_i (x_2, ..., x_n) x_1^i
  $
  则任取小于 $n$ 次的多项式 $q(x_2, ..., x_n)$ 将有：
  $
  0 = inner(q(x_2, ..., x_n), sum_(i= 0)^n p_i (x_2, ..., x_n) x_1^i) \
  = sum_(i= 0)^n inner(q(x_2, ..., x_n), p_i (x_2, ..., x_n)) c_i \
  = inner(q(x_2, ..., x_n), sum_(i= 0)^n c_i p_i (x_2, ..., x_n)) \
  where c_i = integral_(RR^d)^() x_1^i ek(norm(x_1)^2) dif x_1 
  $
  表明 $sum_(i= 0)^n c_i p_i (x_2, ..., x_n)$ 要么恰为 $0$ ，要么是 $d-1$ 维的 $n$ 次正交多项式，无论何者都可得到：
  $
  sum_(i= 0)^n c_i p_i (0) = 0
  $
  类似的，任取小于 $n-2$ 次的多项式 $q$，将有：
  $
  0 = inner(q(x_2, ..., x_n) x_1^2, sum_(i= 0)^n p_i (x_2, ..., x_n) x_1^i)
  $
  （事实上 $i$ 为奇数时 $c_i = 0$）
  类似可以证明：
  $
  sum_(i= 0)^n c_(i+2) p_i (0) = 0\
  sum_(i= 0)^n c_(i+4) p_i (0) = 0\
  ...
  $
  不算入 $i$ 是奇数的情形，共计 $(d + 1)/2$ 个变量和方程，并且可以验证系数矩阵满秩，因此 $p_i (0) = 0$，这就证明了 $Z = {0}$
== 2
  #let sumn0(i) = $sum_(#i = 0)^(n-1)$
  由定义：
  $
  D_n^* (P) = 1/n sumn0(i) 1_(y > x_i) - integral_(0)^(1) 1_(y > x) dif x
  $
  我们希望上式取最大/最小值。不难发现验证若增大 $k$ 分量 $y_k$，只要前项不发生变化后项便不断减小，进而最大/最小值点处一定有：
  $
  exists i, y_k = x_(i k)
  $

  先证明一维情形下，假设 $b^r <= n < b^(r+1)$，上述定义就是：
  $
  1/n sumn0(i) 1_(x_k > x_i) - x_k\
  $
  设：
  $
  k = sum_(s = 0)^infinity a_s (k) b^s\
  i = sum_(s = 0)^infinity a_s (i) b^s\
  $
  则：
  $
  x_k > x_i <=> sum_(s = 0)^infinity a_s (k) b^(-s -1) > sum_(s = 0)^infinity a_s (i) b^(-s -1)
  $
  统计使得 $x_k > x_i$ 的所有情况
  - $a_0 (k) > a_0 (i)$，也即 $i = 0, 1, ..., a_0 (k) - 1$，这些数的数量在以下两者之间：
    $
    a_0 (k) [n/b], a_0 (k) ([n/b] + 1)
    $
  - 否则，$a_0 (k) = a_0 (i), a_1 (k) > a_1 (i)$，则使得上式成立的 $i$ 的个数在以下两者之间：
    $
    a_1(k) [n/b^2], a_1(k) ([n/b^2] + 1)
    $
  - 以此类推，最终得到：
  $
  1/n sumn0(i) 1_(x_k > x_i) - x_k >= 1/n sum_(s = 0)^r a_s (k) ([n/b^(s+1)] - n/b^(s+1)) >= -1/n sum_(s = 0)^r a_s (k) >= -1/n r (b-1)\
  1/n sumn0(i) 1_(x_k > x_i) - x_k <= 1/n sum_(s = 0)^r a_s (k) ([n/b^(s+1)] - n/b^(s+1) + 1) <= 1/n sum_(s = 0)^r a_s (k) <= 1/n r (b-1)
  $
  从而 $abs(D_n^*(P)) <= 1/n r (b-1) <= (b - 1)/n (log n)/(log b) $

  对于高维情形，由于 $b_i$ 都互素，因此由中国剩余定理各个维度上是独立的，类似即可证明：
  $
  abs(D_n^*(P)) <= 1/n product_(i)  (b_i - 1) (log n)/(log b_i)
  $
