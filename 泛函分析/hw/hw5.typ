#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 2.3.3
  #lemmaLinear[][
    设 $A in L(H),a, b > 0$，且：
    $
      a norm(x) <= norm(A x), forall x in H 
    $ 
    则 $A$ 可逆且 $Inv(A) in L(H)$
  ]
  #proof[
    事实上，条件给出 $A$ 是一个开/闭映射。取 $E$ 是一个正交基
    $
      overline(span(E)) = overline(Union_(F subset E "有限") span(F))
    $
    由线性代数知识，$A$ 在任何有限维空间上可逆（立刻给出 $A$ 是单射），同时：
    $
      H = overline(E) = overline(Union_(F subset E "有限") span(F)) = overline(Union_(F subset E "有限") A (Inv(A)_F span(F))) = overline(A (Union_(F subset E "有限") (Inv(A)_F span(F))))\
      = A(overline(Union_(F subset E "有限") (Inv(A)_F span(F)))
    $
    这就表明 $A$ 是满射。因此 $A$ 可逆，并显然有：
    $
      a norm(Inv(A) x) <= norm(x) => norm(Inv(A)) <= 1/a
    $
  ]
  注意到：
  $
    norm(A x) norm(x) >= abs(inner(A x, x)) >= m norm2(x) => norm(A x) >= m norm(x) 
  $
  由引理立刻得到结论
= 2.3.4
  == (1)
    设 $(x_i, A x_i) in G(A) -> (x, y)$，显然有 $x_i -> x, A x_i -> y$，但连续性给出 $A x_i -> A x$，因此 $y = A x$，表明 $(x, y) in G(A)$，进而 $G(A)$ 是闭集。
  == (2)
    $G(A)$ 是闭集保证 $pi_Y G(A) = A (D)$ 也是，因此 $A(D)$ 作为完备空间的闭子集完备。而 $A$ 是连续的，进而有界，可以证明一定有 $Inv(A)(A(D)) = D$ 完备，因此 $D$ 是闭的。
  == (3)
    取 $tau = (x, y) arrowb (y, x)$，断言：
    $
      G(A) = tau(G(Inv(A)))
    $
    事实上：
    $
      tau(G(Inv(A))) = {(Inv(A) y, y) | y in im A} = {(x, A x) | x in D} = G(A)
    $
    而 $tau$ 当然是同胚，因此 $G(A)$ 闭保证 $G(Inv(A))$ 也是闭的。
  == (4)
    显然 $Inv(A)$ 是线性的，(3) 保证 $Inv(A)$ 是闭算子，(2) 给出 $im A$ 是闭的，而稠密的闭集当然是全集
= 2.3.7
  我们设 $A_n$ 的极限函数为 $A$，有：
  $
    A(x + y) = lim_n A_n(x + y) = lim_n A_n x + lim_n A_n y = A x + A y\
    A(lambda x) = lim_n A_n (lambda x) = lambda lim_n A_n x = lambda A x\
    norm(A x) = lim_n norm(A_n x) = liminf_n norm(A_n x) <= liminf_n norm(A_n) norm(x) => norm(A x)/norm(x) <= liminf_n norm(A_n) 
  $ 
  只需要证明 $liminf_n norm(A_n)$ 有限即可。事实上，条件表明：
  $
    forall x, sup_n norm(A_n x) < +infinity
  $
  Banach-Steinhaus 定理给出 $sup_n norm(A_n) < +infinity$，因此 $liminf_n norm(A_n)$ 当然有限。
= 2.3.8
  取 $T_n := (xi_k) arrowb sumk1n(alpha_k xi_k)$，则条件表明：
  $
    forall x, sup_n norm(T_n x) < +infinity
  $
  Banach-Steinhaus 定理给出 $sup_n norm(T_n) < +infinity$，也就是：
  $
    sup_n (sumk1n(|alpha_k|^p))^(1/p) < +infinity
  $
  意味着 ${alpha_k} in l^p$.

  赫尔德不等式给出：
  $
    abs(f x) = abs(sumk1inf(alpha_k xi_k)) <= (sumk1inf(abs(alpha_k)^q))^(1/q) (sumk1inf(abs(xi_k)^p))^(1/p) = (sumk1inf(abs(alpha_k)^q))^(1/q) norm(x)
  $
  意味着 $abs(f x)/norm(x) <= (sumk1inf(abs(alpha_k)^q))^(1/q)$，同时由于 $xi_k = abs(alpha_k)/(alpha_k) abs(alpha_k)^(q/p)$ 时不等式取等，因此：
  $
    norm(f) = sup_(x != 0) abs(f x)/norm(x) = (sumk1inf(abs(alpha_k)^q))^(1/q)
  $
= 2.3.11
  将 $A$ 分解成 $pi: X -> X quo ker A$ 和 $overline(A) : X quo ker A -> Y$，熟知 $overline(A)$ 是双射，逆算子给出它的逆也是有界线性算子。显然复合有界线性算子不影响结论，因此只需对 $pi$ 证明题设性质即可。
  
  先设 $y_0 = 0$，取 $x_n in y_n with norm(x_n) <= 3/2 dist(y_n, 0)$，就有：
  $
    pi x_n = y_n\
    norm(x_n) <= 3/2 dist(y_n, 0) = 3/2 norm(y_n)
  $
  令 $n -> +infinity$，显然 $norm(x_n) -> 0 => x_n -> 0$

  而当 $y_0 != 0$ 时，设 $pi x_0 = y_0$ 可做类似构造使得：
  $
    norm(x_n - x_0) <= 3/2 norm(y_n - y_0)\
    norm(x_n) <= norm(x_n - x_0) + norm(x_0) <= 3/2 norm(y_n - y_0) + norm(x_0) <= 3/2 norm(y_n) + 3/2 norm(y_0) + norm(x_0)
  $
  显然 $norm(y_n)$ 有界，而 $norm(y_0) > 0$，因此当然存在充分大的 $C$ 使得 $norm(x_n) <= C norm(y_n)$ 成立



  // 我们断言构造过程中第 $k$ 步的 $n_k$ 逐渐趋于无穷：否则，设其存在最大值 $N$，然而由极限定义，存在 $K$ 使得：
  // $
  //   forall i >= K, y_i in A(B_(N + 1))
  // $
  // 因此 $n$ 应该继续增大，矛盾！$n_k -> +infinity$ 立刻保证了 $x_n -> x_0$，而构造过程保证了 $A x_n -> y_0$. 此外，有：
  // $
  //   norm(x_k) <= norm(x_0) + 1/(n_k)
  // $
  // 而 $n_k -> +infinity$，同时：
  // - 若 $y_0 = 0$，可以取 $x_0 = 0$，同时，将 $y_n$ 分成非零子列和零子列，零子列对应的 $x_n$ 全取零，非零子列按照上面的取法取
= 1
  == (a) $=>$ (b)
    $
      abs(B(x + Delta x, y + Delta y) - B(x, y)) = abs(B(Delta x, y) + B(x, Delta y) + B(Delta x, Delta y)) <= C (norm(y) norm(Delta x) + norm(x) norm(Delta y) + norm(Delta x) norm(Delta y))
    $
    显然连续
  == (b) $=>$ (c)
    显然
  == (c) $=>$ (a)
    首先对于任意 $y$ 有：
    $
      abs(B(x, y)) <= C(x) norm(y)
    $
    假设 $sup_y abs(B(x, y))/(norm(y) norm(x))$ （上式保证有限）关于 $x$ 有界 $C$ 则结论成立，反设其无上界，也就存在 $x_n$ 使得：
    $
      norm(x) = 1 and sup_y abs(B(x_n, y))/norm(y) > n
    $<assume1>
    取：
    $
      T_n (y) = B(x_n, y)
    $
    任取 $y$，由连续性设：
    $
      norm(T_n y) <= norm(x_n) C'(y) = C'(y)   
    $
    因此：
    $
      sup_n norm(T_n y) <= C'(y) < +infinity
    $
    由 Banach-Steinhaus 定理，$sup_n norm(T_n) < +infinity$，也就是：
    $
      exists M, forall y, norm(T_n y)/norm(y) = abs(B(x_n, y))/norm(y) <= M
    $
    这与@assume1 显然是矛盾的！

  == 反例
    设 $S$ 是所有在 $RR$ 上有有限支集的实函数，范数取 $max f$ ，并取 $B(f, g) = integral_(RR)^() f g dif x$，显然：
    $
      abs(B(f, g)) <= norm(f) abs(integral_(RR)^() f dif x) 
    $
    对另一个分量类似，因此它对分量连续。然而设：
    $
      f_n = 1_[0, n^2] 1/n
    $
    则不难发现 $norm(f_n) = 1/n$，但：
    $
      B(f_n, f_n) = integral_0^(n^2) 1/n^2 dif x = 1
    $
    因此 $abs(B(f_n, f_n))/(norm(f_n) norm(f_n)$ 无上界
= 2
  记 $QQ' = QQ inter [0, 1], S = (p : QQ') times {q : QQ' | q > p}$
  任取 $p < q in QQ inter [0, 1]$，取 $U_(p q)$ 为 $[p, q]$ 上单调函数的集合。取 $L^infinity$ 范数，证明：
  - $U_(p q)$ 是闭的：设 $f in closure(U_(p q))$，令 $U^+, U^-$ 分别是 $U_(p, q)$ 中单调增，单调减的函数，则 $f$ 显然至少属于 $closure(U^+), closure(U^-)$ 的其中其中一个，不妨设前者成立，就有：
    $
      forall x <= y in [p, q], (f(x) - f(y)) &in ((f arrowb f(x) - f(y)) (closure(U^+))) \
      &=^((f arrowb f(x) - f(y)) "是闭映射") closure(((f arrowb f(x) - f(y)) (U^+)))\
      &subset [0, +infinity]
    $
    因此 $f in U^+$
  - $U_(p q)$ 一定是无处稠密的：显然对于任何在 $[p, q]$ 上单调的函数，可以通过修改某一小段为反向的折线使得其在 $[p, q]$ 上不单调，而两者差的范数随着折线的变窄可以任意小。
  
  同时有 $X - E = Union_((p, q) in S) U_(p q)$，因此 $X - E$ 作为无处稠密集的可数并是无处稠密的，继而 $E$ 稠密 
= 3
  // #let f1 = $overline(f)$
  // 任取 $f in Omega$，逆算子定理给出 $f$ 诱导 $L(X quo ker f, Y)$ 中的同胚 $f1$
  // $
  //   norm(A x - x) <= delta norm(x)
  // $
  取 $T in Omega$，若其不是内点，则存在一列 $T_n$ 不是满射使得 $T_n -> T$，考虑：
  $
    // S := liminf_n (Y - im T_n) = Inter_(n = 1)^(+infinity) Union_(k = n)^(+infinity) (Y - im T_k) \
    // T := limsup_n (Y - im T_n) = Union_(n = 1)^(+infinity) Inter_(k = n)^(+infinity) (Y - im T_k) \
    S = Inter_(n = 1)^(+infinity) Union_(k = n)^(+infinity) im T_k
  $

  - $Union_(k = n)^(+infinity) im T_k$ 是稠密集：事实上，任取 $y in Y$，设 $A x = y$，则显然有：
    $
      norm(A_n x - y) -> 0
    $
    换言之，$y in closure(Union_(k = n)^(+infinity) im T_k)$
  - 由 BCT 定理，$S$ 也是稠密集
  - 事实上，$S$ 就是全集         


