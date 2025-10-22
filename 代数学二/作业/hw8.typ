#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为4月23日）
#let Supp = math.op("Supp")
#set heading(numbering: none)
= p67
  == 1
    将 $phi$ 分解为 $i compose pi$，其中 $pi: A -> A quo ker phi$ 是商同态，$i: A quo ker phi tilde.eq im phi -> B$ 是嵌入，只需要分别验证 $i^*, pi^*$ 都是闭映射即可\
    事实上，$pi$ 作为商映射，根据对应原理成为闭映射是容易的，只需验证 $i$ 是闭映射\
    任取 $V(alpha) subset Spec(B)$ 是闭集，由于 $phi$ 是整同态， $i$ 当然也是，而 $i$ 是嵌入，利用熟知的结论可得 $i^*$ 是满射，前面的习题证明了 $overline(i^*(V(alpha))) = V(Inv(i)(alpha))$，只需证明 $V(Inv(i)(alpha)) subset i^*(V(alpha))$ 即可\
    事实上：
    $
    p_A  in V(Inv(i)(alpha)) <=> Inv(i)(alpha) subset p_A\
    $
    既然 $B$ 在 $im phi$ 上整，自然有 $B quo alpha$ 在 $im phi quo Inv(i)(alpha)$ 上整，因此：
    $
    Inv(i)(alpha) subset p_A => overline(p_A) in Spec(im phi quo Inv(i)(alpha)) => exists overline(p_B) in Spec(B quo alpha), overline(Inv(i))(overline(p_B)) = overline(p_A)  
    $
    其中当然有 $p_B in V(alpha)$ 且 $i^*(p_B) = p_A => p_A in i^*(V(alpha))$，得证
  == 2
    #align(center)[#commutative-diagram(
    node((0, 0), $A$, 1),
    node((0, 1), $B$, 2),
    node((1, 0), $A quo (ker f := p_A)$, 3),
    node((1, 1), $B quo p_B$, 4),
    arr(1, 2, $$, inj_str),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $$, inj_str),
    node((3, -1), $Omega$, 5),
    node((2, 0), $k_(A quo p_A)$, 6),
    node((2, 1), $k_(B quo p_B)$, 7),
    arr(1, 5, $f$),
    arr(3, 5,$exists f_1$),
    arr(3, 6, $$),
    arr(4, 7, $$),
    arr(6, 7, $$, inj_str),
    arr(6, 5, $exists f_2$),
    arr(7, 5, $exists f'$)
    )]
    其中：
    - $p_A = ker f$ 当然是 $A$ 的素理想，因此存在 $p_B in Spec(B)$ 使得 $p_B inter A = p_A$ 并有第二层的交换图表和自然的嵌入 $f_1$
    - $A quo p_A, B quo p_B$ 都是整环，$k_(A quo p_A), k_(B quo p_B)$ 是其上的分式域，$f_2$ 利用环到域的同态延拓到分式环上产生
    - 利用 $Omega$ 是代数闭域和域中的同态延拓定理，$f_2$ 可被延拓到 $f'$
    由于整个交换图表成立，不难验证 $(B -> B quo p_B -> k_(B quo p_B) -> Omega)$ 在 $A$ 上的限制就是 $f$，证毕
  == 3
    任取 $b' tensorProduct 1 in B' tensorProduct C$（当然 $B' tensorProduct C$ 中元素均形如 $b' tensorProduct c = c b' tensorProduct 1$，不妨就设为 $b' tensorProduct 1$），由于 $B'$ 在 $B$ 上整，故存在首一多项式使得：
    $
    b'^n + b_1 b'^(n-1) + ... + b_n = 0, b_n in B
    $ 
    将有：
    $
    (b' tensorProduct 1)^n + (b_1 tensorProduct 1) (b' tensorProduct 1)^(n-1) + ... + (b_n tensorProduct 1) = 0 tensorProduct 1 = 0
    $
    这就产生了一个 $b' tensorProduct 1$ 的首一零化多项式，系数均在 $B tensorProduct C$ 中，因此 $B tensorProduct C$ 在 $B' tensorProduct C$ 上整，得证
  == 5
    === i)
      设 $Inv(x) in B$ 在 $A$ 上的零化多项式为：
      $
      x^(-n) + a_1 x^(-n+1) + ... + a_n = 0, a_n in A
      $
      从而有：
      $
      x^(-1) + a_1 + ... + a_n x^(n-1) = 0
      $
      上式除第一项外都在 $A$ 中，自然 $Inv(x)$ 也在，证毕
    === ii)
      由整性 $phi^*: Spec(B) -> Spec(A)$ 将诱导 $max(B) -> max(A)$ 上的满射，因此：
      $
      inter max(B) inter A = (sect_(m_B in max(B)) m_B) inter A = sect_(m_B in max(B)) m_B inter A \
      = sect_(m_B in max(B)) phi^*(m_B) = sect_(m_A in max(A)) m_A = inter max(A)
      $
  == 7
    任取 $x in B - A$，则：
    - $x + A subset B - A$ ，否则不难得到 $x in A$，矛盾！
    - $x(x + A) = x^2 + A x subset B - A$，既然 $B-A$ 对乘法封闭
    - ...
    - 以此类推，将有 $x^(n-1) + sum_(i=0)^(n-1) A x^i subset B - A$ 不可能为零，自然 $x$ 不可能存在首一零化多项式，证毕
  == 8
    === i)
      取 $B$ 的分式域的代数闭包 $Omega$，并设 $f, g$ 在 $Omega$ 中被分解为：
      $
      f = product_(i=1)^n (x - a_i), g = product_(j=1)^m (x - b_j) 
      $
      注意到 $f g in C[x]$，因此 $a_i, b_i$ 都在 $C$ 上整，故 $f, g$ 的系数（它们都含于 $C[a_i], C[b_i]$）在 $C$ 上整。然而这些系数都在 $B$ 之中，且 $C$ 在 $B$ 中已经整闭，故当然系数都在 $C$ 中，得证
    === ii)
      设任取 $B$ 中素理想 $p$，则当然有：
      $
      A quo (p inter A) subset C quo (p inter C) subset B quo p
      $
      且都是整环，由上题结论得 $overline(f), overline(g)$ 的所有系数落在 $A quo (p inter A)$ 的整闭包中，进而在其上整。\
      #lemmaLinear[][
        设 $x in B$ 且任取素理想 $p in Spec(B)$ 均有 $overline(x) in B quo p$ 在 $A quo (p inter A)$ 上整，则 $x$ 在 $A$ 上整
      ]
      #proof[
        令:
        $
        S = {f(x) | f in A[x] "首一"} subset B
        $
        它将是 $B$ 的乘性子集，注意到 $Inv(S) B$ 一定有素理想，因此 $B$ 中一定有与 $S$ 不交的素理想 $p$，然而条件给出：
        $
        exists a_i, x^n + (a_i + p) x^(n-1) + ... + (a_n + p) in p\
        x^n + a_i x^(n-1) + ... + a_n in p
        $
        当然与假设矛盾
      ]
      由引理，结论立即成立
  == 9
    设 $f in B[x]$ 在 $A[x]$ 上整，则：
    $
    f^n + a_(1) f^(n-1) + ... + a_(n) = 0, a_(n) in A[x]\
    $
    设 $f = x^r + f'$，则：
    $
    (x^r + f')^n + a_(1) (x^r + f')^(n-1) + ... + a_(n) = 0\
    f'^n + a'_(1) f'^(n-1) + ... + a'_(n) = 0\
    -f'(f'^(n-1) + a'_(1) f'^(n-2) + ... + a'_(n-1)) = a'_(n)
    $
    当 $r$ 足够大时，$a'_n$ 的首项为 $x^(r n)$ 因此首一，利用上题结论可得 $f$ 的系数在 $A$ 上都是整的，也即 $f in C[x]$，证毕
  == 10
    === i)
      ==== a $=>$ b
        只需证明设 $p_1 subset p_2, p_1 = f^*(q_1)$ 则存在 $q_2 supset q_1$ 使得 $p_2 = f^*(q_2)$\
        前面的习题证明了 $overline(f^*(V(q_1))) = V(Inv(f)(q_1))$，因此 $f$ 是闭映射表明：
        $
        f^*(V(q_1)) = V(Inv(f)(q_1)) = V(p_1)
        $
        由于 $p_2 in V(p_1)$，当然有 $exists q_2 in V(q_1), f^*(q_2) = p_1$，得证
      ==== b $=>$ c
        任取 $p' A quo p in Spec(A quo p)$，则 $p'$ 是包含 $p$ 的素理想，由 going up 性质知存在 $q' supset q$ 使得:
        $
        f^*(q') = p'
        $
        观察交换图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $B$, 2),
        node((1, 0), $A quo p$, 3),
        node((1, 1), $B quo q$, 4),
        arr(1, 2, $f$),
        arr(1, 3, $$),
        arr(2, 4, $$),
        arr(3, 4, $overline(f)$),)]
        将有：
        $
        Inv(f)(Inv((B -> B quo q))(q' B quo q)) = Inv(f)(q') = p'\
        p' = Inv(f)(Inv((B -> B quo q))(q' B quo q)) = Inv((A -> A quo p))(overline(f^(-1))(q' A quo p)) \
        p' A quo p = overline(f^(-1))(q' A quo p)
        $
        证毕
      ==== c $=>$ b
        只需证明设 $p_1 subset p_2, p_1 = f^*(q_1)$ 则存在 $q_2 supset q_1$ 使得 $p_2 = f^*(q_2)$\
        在满射 $overline(f)^*: Spec(B quo q_1) -> Spec(A quo p_1)$ 中，取 $overline(f)^*(q_2) = p_2$，由类似上面的过程可以证明 $f^*(q_2) = p_2$
  === ii)
    ==== a $=>$ c
      利用：
      $
      B_q = union_(x in B - q) B_x = directLimit B_x\
      f^*(Spec(B_q)) = sect_(x in B - q) f^*(Spec(B_x)) 
      $
      然而 $Spec(B_x)$ 是（$Spec(B)$ 中）包含 $q$ 的开集，以及 $f^*$ 是开映射，因此 $f^*(Spec(B_x))$ 是包含 $f^*(q) = p$ 的开集 $Spec(A) - V(alpha), alpha subset.not p$，显然 $V(alpha)$ 中没有含于 $p$ 的理想，因此前式一定包含 $Spec(A_p)$，证毕
    ==== b $<=>$ c
      与之前类似，可以证明 $Spec(B_q) -> Spec(A_p)$ 是满射当且仅当 $forall p' in Spec(A), p' subset p => exists q' subset q, f^*(p') = q'$，由 $p, q$ 的任意性这就是 going down 性质
  == 11
    验证上题中的 c'，设 $p = Inv(f)(q)$ ，考虑诱导的 $f': A_p -> B_q$ 也是平坦同态。事实上，注意到 $A -> B -> B_q$ 由传递性平坦，而：
    $
    Inv((A - p)) (A -> B -> B_q) = A_p -> Inv((A - p)) B_q = A_p -> B_q = f'
    $
    由局部化函子的正合性也是平坦同态\
    熟知局部环之间的平坦同态一定忠实平坦，继而 $Spec(B_q) -> Spec(A_p)$ 是满射，得证
  == 12
    任取 $x in A$ ，设：
    $
    f(t) = product_(sigma in G) (t - sigma(x))  
    $
    不难验证 $f(x) = 0$ 且任取 $sigma in G, sigma(f) = f$，因此 $f$ 的系数都在 $A^G$ 之中，这就是所求的首一零化多项式

    有交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $A$, 1),
    node((0, 1), $A$, 2),
    node((1, 0), $Inv(S) A$, 3),
    node((1, 1), $Inv(S) A$, 4),
    arr(1, 2, $sigma$),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $sigma'$),)]
    其中 $sigma'$ 来自于 $A -> A -> Inv(S) A$ 由局部化产生的延拓，为此验证：
    $
    (A -> A -> Inv(S) A)(S) = (A -> Inv(S) A)(sigma(S)) subset (A -> Inv(S) A)(S) subset U(Inv(S) A)
    $
    因此延拓确实存在\
    注意到 $S^G$ 当然也满足 $sigma(S^G) = S^G$ 因此有：
    #align(center)[#commutative-diagram(
    node((0, 0), $A$, 1),
    node((0, 1), $A$, 2),
    node((1, 0), $Inv(S^G) A$, 3),
    node((1, 1), $Inv(S^G) A$, 4),
    node((2, 0), $Inv(S) A$, 5),
    node((2, 1), $Inv(S) A$, 6),
    arr(1, 2, $sigma$),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $sigma''$),
    arr(3, 5, $$),
    arr(4, 6, $$),
    arr(5, 6, $sigma'$),
    
    )]
    此外，不难验证：
    $
    (sigma'' compose (A -> Inv(S^G) A))|_(A^G) = ((A -> Inv(S^G) A) compose sigma)|_(A^G) = A^G -> Inv(S^G) A^G
    $
    换言之，$sigma''|_(Inv(S^G) A^G)$ 是 $(Inv(S^G)) A^G$ 上的自同态，且有：
    #align(center)[#commutative-diagram(
    node((0, 0), $A^G$, 1),
    node((0, 1), $A^G$, 2),
    node((1, 0), $Inv(S^G) A^G$, 3),
    node((1, 1), $Inv(S^G) A^G$, 4),
    arr(1, 2, $id$),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $sigma''|_(Inv(S_G) A^G)$),)]
    由局部化延拓的唯一性知 $sigma''|_(Inv(S_G) A^G) = id$\
    类似也可以证明 $sigma'|_(Inv(S) A^G) = id$，由 $sigma$ 的任意性当然就有：
    $
    im((Inv(S^G)) A^G -> Inv(S) A) subset (Inv(S) A)^G
    $
    反过来也可以证明：
    $
    //sigma'|_((Inv(S) A)^G) = id => sigma''|_(Inv(((Inv(S^G)) A^G -> Inv(S) A)) (Inv(S) A)^G) = id
    sigma'|_((Inv(S) A)^G) = id => sigma|_(Inv((A-> Inv(S) A)) ((Inv(S) A)^G)) = id
    $
    由任意性可知：
    $
    (Inv((A-> Inv(S) A)) ((Inv(S) A)^G)) subset A^G \
    => (Inv(S) A)^G subset Inv(S) A^G = im((Inv(S^G)) A^G -> Inv(S) A)
    $
    因此 $(Inv(S^G)) A^G -> (Inv(S) A)^G$ 构成满射，只需证明它也是单射。\
    为此，设 $a'/s' in (Inv(S^G)) A^G$ 在 $Inv(S) A$ 中为零，即：
    $
    exists s in S, a' s = 0
    $
    立刻有：
    $
    a' product_(sigma in G) sigma(s) = 0 
    $
    而 $product_(sigma in G) sigma(s) in S'$，可得 $a'/s' = 0$，证毕
  == 13
    任取 $p_1, p_2 in P, x in p_1$，注意到：
    $
     product_(sigma in G) sigma(x) in A^G inter p_1 = p subset p_2
    $
    由素理想定义存在某个 $sigma$ 使得 $sigma(x) in p_2$，因此：
    $
    union_(sigma in G) sigma(p_1) supset p_2
    $
    注意到 $p_2$ 是素理想，由 prime avoidance lemma 知存在 $sigma in G$ 使得 $sigma(p_1) supset p_2$\
    为了证明 $sigma(p_1) = p_2$，注意到：
    $
    sigma(p_1) inter A^G = sigma(p_1 inter Inv(sigma)(A^G)) = sigma(p_1 inter A^G) = p = p_2 inter A^G
    $
    结合 $A$ 在 $A^G$ 上整以及 $sigma(p_1) supset p_2$ 知它们取等，证毕
  == 14
    为了证明 $sigma(B) = B$，首先 $A = sigma(A) subset sigma(B)$,断言：
    - $sigma(B)$ 当然在 $L$ 中整闭，否则设 $x in L - sigma(B)$ 使得：
      $
      x^n + sigma(b_1) x^(n-1) + ... + sigma(b_n) = 0\
      (Inv(sigma)(x))^n + b_1 (Inv(sigma)(x))^(n-1) + ... + b_n = 0 
      $ 
      由 $B$ 整闭知 $Inv(sigma)(x) in B, x in sigma(B)$，矛盾！
    - $sigma(B)$ 在 $A$ 上整，因此任取 $sigma(x) in sigma(B)$，由 $B$ 的整性存在：
      $
      x^n + a_1 x^(n-1) + ... + a_n = 0\
      sigma(x)^n + sigma(a_1) sigma(x)^(n-1) + ... + sigma(a_n) = 0\
      sigma(x)^n + a_1 sigma(x)^(n-1) + ... + a_n = 0\
      $
      当然就表明 $sigma(x)$ 在 $A$ 上整\
    由整闭包的唯一性知 $sigma(B) = B$

    对于第二个命题，首先当然有 $A subset B^G$，其次由域论知识得：
    $
    B^G = B inter L^G = B inter K subset K
    $
    并且 $B^G$ 当然在 $A$ 上整，由 $A$ 的整闭性知 $B^G subset A$，证毕
  == 15
    - 设 $L quo K$ 是可分扩张，则只需要取其正规闭包 $L'$，对 $L' quo K$ 利用上题结论立得：
      $
      B^(Gal(L' quo K)) = A
      $
      再利用之前的结论即可得到所求有限性
    - 设 $L quo K$ 是纯不可分扩张，设 $q in Spec(B), p in Spec(A)$ 满足 $q inter A = p$\
      注意到 $B$ 中任意元素都是纯不可分元，其最小多项式形如：
      $
      x^(r^n) - a = 0, a in K, r = char(K)
      $
      结合 $B$ 在 $A$ 上整，$A$ 在分式域中整闭，可得上式中 $a in A$\
      下设 $x in q$，则：
      $
      x^(r^n) = a in q inter A = p
      $
      令 $q_p = {x in B | exists n in NN, x^(r^n) in p}$，往证 $q_p = q$
      - 首先，容易验证 $q'$ 是素理想（乘法是简单的，加法只需注意到 $(x + y)^(r^n) = x^(r^n) + y^(r^n)$）
      - 其次，往证若 $x^(r^n) in p$，则其最小多项式形如 $x^(r^m) - a, a in p$\
        事实上，首先由最小性知 $m <= n$，继而：
        $
        x^(r^n) = (x^(r^m))^(r^(n-m)) in p
        $
        由于 $p$ 是素理想，当然有 $x^(r^m) in sqrt(p) = p$，得证
      - 进一步，断言它是素理想，因为设 $x y in q$，分别设三个最小多项式:
        $
        x^(r^n) = a_1 in A\
        y^(r^m) = a_2 in A\
        (x y)^(r^(t)) = a in p
        $
        不妨设 $m <= n$，继而：
        $
        (x y)^(r^n) = x^(r^n) (y^(r^m))^(r^(n - m)) = a_1 a_2^(r^(n-m)) in A  
        $
        由最小性，$a_1 a_2^(r^(n-m))$ 一定是 $a$ 的次幂，进而 $a_1 a_2^(r^(n-m)) in p$，结合素理想定义一定有 $a_1 in p or a_2 in p$，得证
      - 最后，$q subset q_p$ 是显然的，而 $q inter A = p, q_p inter A = sqrt(p) = p$，由 $B$ 在 $A$ 上整立得 $q = q_p$
      注意到以上构造对任何素理想都成立，因此 $Spec(B) -> Spec(A)$ 是双射\
    - 一般的，设 $L' subset L$ 是 $K$ 的可分闭包（此时 $L quo L'$ 是纯不可分扩张），$B'$ 是 $A$ 在 $L'$ 中的整闭包，$B$ 是 $B'$ 在 $L$ 中的整闭包（由传递性也是 $A$ 的整闭包），任取 $q in Spec(A)$，若 $p in Spec(B)$ 使得 $p inter A = q$，则：
      $
      q = (p inter B') inter A
      $
      由可分的情形，这样的 $p inter B'$ 至多只能有有限个，而对每个 $p inter B'$ 由纯不可分的情形将可以唯一确定一个 $p$，因此结论成立
