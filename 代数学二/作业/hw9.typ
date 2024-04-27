#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, AModule, lemma1, tensorProduct, directSum, directLimit
#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为4月30日）
#set heading(numbering: none)
= p69
  == 16
    设 $A = k[x_1, x_2, ..., x_n]$，可以找到 $x_1, x_2, ..., x_n$ 的一个极大代数无关组，不妨设为 $x_1, x_2, ..., x_r$（若其中全部都是 $k$ 上的代数元则 $r = 0$，否则选出一个超越元成为 $x_1$，再寻找是否存在 $k[x_1]$ 上的代数元，以此类推） 若 $r = n$ 或 $r = 0$ 结论已经成立，下设 $0 < r < n$\
    此时，当然有 $x_1, x_2, ..., x_r, x_n$ 代数相关，因此设 $n$ 次多项式 $f != 0$ 满足：
    $
    0 = f(x_1, x_2, ..., x_r, x_n) :=  sum_(d_n = 0)^n (sum_(l_1 + l_2 + ... +l_(r) + d_n <= n) a_(l_1, l_2, ..., l_(r), d_n) x_1^(l_1) x_2^(l_2) ... x_(r)^(l_(r))) x_n^(d_n)
    $
    - 首先，设：
      $
      f'(x) = sum_(d_n = 0)^n (sum_(l_1 + l_2 + ... +l_(r) + d_n <= n) a_(l_1, l_2, ..., l_(r), d_n) x_1^(l_1) x_2^(l_2) ... x_(r)^(l_(r))) x^(d_n)
      $
      当然就有 $f'(x_n) = 0$。同时，$f'$ 不可能是零多项式，否则每个系数都是 $x_1, x_2, ..., x_r$ 的零化多项式，由代数无关性这些多项式也是零多项式，表明 $f = 0$ ，与假设矛盾\

      然而它未必首一。观察发现 $f'$ 的 $n$ 次项仅有常系数，若恰非零则除去可逆元后成为首一多项式，但可能为零导致 $f'$ 不是首一多项式。为此，希望取得 $lambda_i$ 以及 $x'_i = x_i - lambda_i x_n, i = 1, 2, ..., r$，代入上式将有：
      $
      0 =  sum_(d_n = 0)^n (sum_(l_1 + l_2 + ... +l_(r) + d_n <= n) a_(l_1, l_2, ..., l_(r), d_n) (x'_1 + lambda_1 x_n)^(l_1) (x'_2 + lambda_2 x_n)^(l_2) ... (x'_r + lambda_2 x_r)^(l_(r))) x_n^(d_n)
      $  
      不难发现它关于 $x_n$ 的 $n$ 次项系数为：
      $
      sum_(l_1 + l_2 + ... +l_(r) + d_n = n) a_(l_1, l_2, ..., l_(r), d_n) lambda_1^(l_1) lambda_2^(l_2) ... lambda_r^(l_r)
      $
      若设 $f$ 的 $n$ 次项恰为 $F(x_1, x_2, ..., x_r, x_n) != 0$，上式就是 $F(lambda_1, lambda_2, ..., lambda_r, 1)$ 为了证明可以取到一组 $lambda_i$ 使得前式非零（进而可逆，可以将多项式化为首一），注意到 $F$ 形如：
      $
      sum_(d_n = 0)^n (sum_(l_1 + l_2 + ... +l_(r) + d_n = n) a_(l_1, l_2, ..., l_(r), d_n) x_1^(l_1) x_2^(l_2) ... x_(r)^(l_(r))) x_n^(d_n)
      $
      假设对于所有 $lambda_i$ 都有前式为零，由无限域的性质将有代入 $x_n = 1$ 的结果：
      $
      sum_(d_n = 0)^n (sum_(l_1 + l_2 + ... +l_(r) + d_n = n) a_(l_1, l_2, ..., l_(r), d_n) x_1^(l_1) x_2^(l_2) ... x_(r)^(l_(r)))
      $
      是零多项式，观察形式将有每个系数 $a_(l_1, l_2, ..., l_(r), d_n)$ 都是零，进而 $F$ 是零，这是荒谬的。因此我们希望的 $lambda_i$ 是存在的。
    - 上面结果已经表明，存在系数落在 $k[x'_1, x'_2, ..., x'_r] subset A' := k[x'_1, x'_2, ..., x'_r, x_(r+1), ..., x_(n-1)]$ 之中的 $x_n$ 的首一零化多项式，也即 $x_n$ 在 $A'$ 上整。$A'$ 的生成元个数严格减少，因此可以归纳并假设存在 $y'_1, ..., y'_s$ 代数无关并且 $A'$ 在 $k[y'_1, ..., y'_s]$ 上整，进而由传递性 $x_n$ 在其上整，同时由 $x_i = x'_i + lambda_i x_n$ 及 $x'_i in A', i = 1, 2, ..., r$ 知 $x_i$ 也在其上整，$x_(r+1) ... x_n$ 当然也整，因此 $A$ 的所有生成元都在其上整，证毕
    - 对于第二个结论，注意到 $A = k[t_1, ..., t_n] quo I(X)$ 是有限生成 $k-$代数，由该题结论存在 $y_1 + I(X), ..., y_r + I(X) in A$ 满足上述的条件。\
      由第一章的习题，这 $r$ 个多项式产生多项式映射 $Phi: k^n -> k^r$，往证 $Phi|_X$ 确实是满射。为此，任取 $y' in k^r$，令：
      $
      funcDef(f_(y'), k[y_1 + I(x), y_2 + I(x), ..., y_r + I(x)], k, f(y_1, y_2, ..., y_r), f(y'_1, y'_2, ..., y'_r))
      $
      不难验证这是一个 $k-$代数同态，由之前的习题它可以被提升到 $f'_(y') : A -> k$\
      注意到 $f_(y')$ 是满射，$f'_(y')$ 自然也是，由同构定理不难得到 $ker f'_(y')$ 是极大理想。我们暂且利用希尔伯特零点定理，设其形如：
      $
      ker f'_(y') = m_x = {f in A | f(x) = 0}
      $
      再取：
      $
      f'_x : f: A -> f(x) : k
      $
      不难发现 $f'_x$ 与 $f'_(y')$ 都诱导 $A quo m_x tilde.eq k$ 的域自同构，结合它们都是 $k-$ 代数同态可得它们相等，立得：
      $
      y'_i = f'_(y') (y_i) = y_i (x), forall i = 1, 2, ..., r
      $
      这就给出了 $x in X$ 成为 $y'$ 的原像，证毕 

  == 17
    题干似乎应该是若设 $X = Z(alpha)$ 且 $alpha != (1)$ 则 $X$ 非空\
    若这个事实成立，则极大理想 $alpha$ 对应的 $Z(alpha)$ 非空，结合极大性知只能是单点集，如此立得 $alpha = m_x$ 也即结论成立。\
    然而看起来上面的事实并不容易从上题结论推出（何况上题第二个结论已经利用了希尔伯特零点定理的结果）
  == 18
    #lemma1[
      设 $A$ 是唯一分解整环，则 $A$ 是整闭的
    ]
    #proof[
      设 $x = a/b$ 位于 $A$ 的分式环中，不妨设 $a, b$ 互素。若它在 $A$ 上整，则：
      $
      x^n + a_(n-1) x^(n-1) + ... + a_0 = 0\
      (a/b)^n + a_(n-1) (a/b)^(n-1) + ... + a_0 = 0\
      a^n + a_(n-1) a^(n-1) b + ... + a_0 b^n = 0
      $
      然而观察上式立得 $b | a$ ，除非 $x in A$ 否则这是荒谬的
    ]
    设 $B = k[x_1, x_2,..., x_n], A = k[x_1], k_A = k(x_1)$\
    利用归纳法，$B$ 将是 $k_A$ 的有限代数扩张，假设 $x_1$ 在 $k$ 上代数则由传递性结论显然，否则 $A$ 当然是唯一分解整环，继而 $A$ 是整闭的。
    由有限代数扩张，$x_2, ..., x_n$ 在 $k_A$ 上有首一的零化多项式。注意到这些系数都位于 $k(x_1)$ 之中，不妨设其公分母为 $f$，进而 $B$ 在 $A_f supset k_A$ 上整，然而 $A$ 整闭表明 $A_S$ 也整闭，这表明：
    $
    A_f = k_A
    $
    然而注意到 $A$ 是整环，$A$ 可以嵌入 $A_f$ 继而 $A_f = A[1/f]$ 是有限生成 $A-$代数，但由 $x_1$ 的超越性 $k(x_1)$ 当然不是 $k[x_1]$ 的有限生成代数，矛盾！
  == 19
    任取 $m$ 是极大理想，考虑 $k' := k[t_1, t_2, ..., t_n] quo m$
    - 它是有限生成 $k-$代数
    - 它是域
    因此它是 $k$ 的有限代数扩张，然而 $k$ 是代数闭域，表明：
    $
    k' tilde.eq k
    $
    设同构 $sigma: k' -> k$，上述过程表明一定有 $sigma(x + m) = x, forall x in k$，继而：
    $
    sigma(t_i - sigma(t_i) + m) = sigma(t_i) - sigma(t_i) = 0 => t_i - sigma(t_i) in m
    $
    表明 $(t_1 - sigma(t_1), ..., t_n - sigma(t_n)) subset m$ ，而左侧已经是极大理想，因此取等，证毕
  == 20
    设 $A$ 的分式域为 $k$，则 $k tensorProduct B$ 是有限生成代数。由正规化引理存在 $x_i in k tensorProduct B$ 使得：
    - $x_i$ 代数独立
    - $k tensorProduct B$ 在 $k[x_1, x_2, ..., x_n]$ 上整
    设 $B = plus.circle_(i) A b_i$，则：
    $
    k tensorProduct B = k tensorProduct (plus.circle_(i) A b_i) = plus.circle_(i) (Inv(S) A) tensorProduct A b_i = plus.circle_(i) (A) tensorProduct (S A b_i) = plus.circle_(i) A (1 tensorProduct b_i)
    $
    由假设 $1 tensorProduct b_i$ 都是 $k[x_1, x_2, ..., x_n]$ 上整元，因此存在各自的首一多项式 $f_i in (k[x_1, x_2, ..., x_n])[t]$ 将其零化。不妨设所有这些多项式的系数有公分母 $s$，继而：
    $
    f_i in (A_s [x_1, x_2, ..., x_n])[t]
    $
    继而 $B$ 在 $A_s [x_1, x_2, ..., x_n]$ 上整\
    同时，设 $x_i = a_i tensorProduct b'_i$，再取 $s' = s a_1 ... a_n$，断言：
    - $b'_i$ 在 $A$ 上代数独立，否则 $f(b'_1, ..., b'_n) = 0 => (a_1 a_2 ... a_n)^m f(1 tensorProduct b'_1, ..., 1 tensorProduct b'_n) = 0$ \
      只要 $m$ 充分大，上式将给出一个 $x_1, ..., x_n$ 的零化多项式，结合整环无零因子可得 $f = 0$
    - $B_s'$ 在 $(A[b'_1, ..., b'_n])_s'$ 上整，这是因为显然有 $B_s'$ 在：
      $
      (A_s [x_1, x_2, ..., x_n])_s' = A_s' [(x_1)_s', ..., (x_n)_s']
      $ 上整，而 $(b'_i)_s'$ 与 $(x_i)_s' = (a_i (1 tensorProduct b'_i))_s' $ 只差可逆元，因此结论成立
    这就表明结论成立
= p99
  == 1
    注意到若 $A$ 是整闭的一维诺特整环，则 $Inv(S) A$ 当然也是，进而它要么是域要么是戴德金整环。

    考虑理想类群，为了保证 $H -> H'$ 是满射，注意到 $H'$ 中元素均形如 $i P_(Inv(S) A)$ 其中 $i$ 是 $Inv(S) A$ 的分式理想，它是 $K$ 上的有限生成模 $(a_1/b_1, a_2/b_2, ..., a_n/b_n)$ ，不妨通分设生成元为 $(a_1/s, a_2/s, ..., a_n/s)$，而：
    $
    (a_1/s, a_2/s, ..., a_n/s)  P_(Inv(S) A) = (a_1/s, a_2/s, ..., a_n/s)  (s) P_(Inv(S) A) = (a_1, a_2, ..., a_n) P_(Inv(S) A) 
    $
    上式左侧是一个拓展理想，因此 $H -> H'$ 是满射
  == 2
    任取极大理想做局部化，可以不妨设 $A$ 是局部环，进而由 $A$ 是戴德金整环它将成为离散赋值环。可设：
    $
    c(f) = (t^r)\
    c(g) = (t^s)
    $
    因此可设：
    $
    f = t^r (a'_n x^n + ... + a'_0)\
    g = t^s (b'_m x^m + ... + b'_0)
    $
    其中 $(a'_n, ..., a'_0) = (b'_m, ..., b'_0) = (1)$（否则可以再次提出 $t$）\
    如此：
    $
    f g = t^(r+s) (a'_n x^n + ... + a'_0)(b'_m x^m + ... + b'_0)
    $
    设 $(a'_n x^n + ... + a'_0)(b'_m x^m + ... + b'_0)$ 系数的生成理想为 $(t^l)$，断言 $l = 0$，否则考虑 $A quo (t)$ （这是域）中将有 $(a'_n x^n + ... + a'_0)(b'_m x^m + ... + b'_0) = 0 => (a'_n x^n + ... + a'_0) = 0 or (b'_m x^m + ... + b'_0) = 0$，这意味着 $(a'_n, ..., a'_0) subset (t)$ 或者 $(b'_m, ..., b'_0) subset (t)$ ，都与假设矛盾！
  == 3
    一方面离散赋值环当然是诺特的赋值环，另一方面，赋值环中有限生成理想都是主理想，而诺特环中理想都是主理想，因此 $A$ 是（局部）主理想整环，它当然是离散赋值环，证毕！
    
  == 4
    设 $m = (x)$，任取非零元素 $t$，可设：
    $
    x^r in (t), x^(r-1) in.not (t)
    $
    （否则将有 $I subset sect_m (x^m) = 0$）\
    不难验证 $r$ 对每个 $t$ 是唯一定义的（对于可逆元 $t$ 定 $r = 0$）\
    进一步，我们证明 $t$ 与 $x^(v(t))$ 只差一个可逆元。事实上由定义，可设：
    $
    t = k x^(v(t))\
    k = s x^(v(k))\
    t = s x^(v(t) + v(k))
    $
    而由 $v(t)$ 的最小性，一定有 $v(k) = 0 => k in.not m$ 表明 $k$ 是可逆元\
    进而可以验证 $v$ 是离散赋值：
    - $v(t) >= 0$ 显然
    - $s = u x^(v(s)), t = v x^(v(t)) => s t = u v x^(v(s)+v(t))$ 而 $u, v, u v$ 是可逆元，表明 $v(s t) = v(s) + v(t)$\
    - 设 $v(s) <= v(t)$ 则可设 $s = u x^(v(s)), t = v x^(v(t)) = v x^(v(t) - v(s)) x^(v(s))$，进而：
      $
      x^(v(s)) | s + t => v(s + t) >= v(s)
      $
    这就验证了离散赋值的定义
  == 5
    由之前的习题，无挠/平坦都是局部性质，因此不妨设 $A$ 是局部环，进而是离散赋值环，设其极大理想为 $(x)$。\
    之前已经证明局部环上的有限生成理想平坦当且仅当自由，因此只需证明无挠当且仅当自由即可。自由模当然无挠，而若 $M$ 无挠，不妨设 $x_1, ..., x_n$ 是数量最少的生成元，只需证明这是一组基。假设存在非零的线性组合使得：
    $
    sum_i a_i x_i = 0
    $
    - 若存在某个 $a_i$ 为可逆元，则相应 $x_i$ 被其他元素表示，与生成元数量最少矛盾！
    - 反之，取最大的 $r$ 使得：
      $
      a_i = a'_i x^r, forall i
      $
      将有：
      $
      x^r (sum_i a'_i x_i) = 0
      $
      由无挠性，将有 $sum_i a'_i x_i = 0$，而 $a'_i$ 中一定有可逆元（否则 $r$ 可以取更大），继而回到上一种情形
  == 6
    不妨设 $M!=0$\
    - 断言 $"Supp"(M)$ 有限集，这是因为若设 $x_i$ 是一组生成元，则：
      $
      "Supp"(M) = union_i "Supp"(x_i)
      $
      只需证明 $"Supp"(x_i) = V(Ann(x_i))$ 有限。事实上,$Ann(x_i) != 0(arrow.double.l x_i in T(M))$ 可被唯一素理想分解：
      $
      Ann(x_i) = p_1^(n_1) p_2^(n_2) ... p_k^(n_k)
      $ 
      继而 $V(Ann(x_i)) = {p_1, p_2, ..., p_k}$
    - 设 $p in "Supp"(M)$ 先处理 $M_p$，对其利用主理想整环上的有限生成模分类，将有：
      $
      M_p = plus.circle_(i) A_p quo (alpha_i) 
      $
      然而 $A_p$ 是离散赋值环，上式也可写作：
      $
      M_p = plus.circle_(i) A_p quo (p A_p)^(n_i^p) 
      $
      令 $M' = plus.circle_(p in "Supp"(M)) plus.circle_(i) A quo p^(n_i^p)$，不难验证 $"Supp"(M') = "Supp"(M)$，且它们在每个素理想处的局部化都相等，继而 $M = M'$ 证毕
  == 7
    考虑 $alpha$ 的素分解：
    $
    alpha = p_1^(n_1) p_2^(n_2) ... p_k^(n_k)
    $
    由中国剩余定理（注意到这些素理想都极大，因此互素，而互素理想的幂次也互素）：
    $
    A quo alpha = A quo p_1^(n_1) times A quo p_2^(n_2) times ... times A quo p_k^(n_k)
    $
    - 首先由于 $p_i$ 是非零素理想，显然包含 $p_i^(n_i)$ 的素理想仅有 $p_i$，因此 $A quo p_1^(n_1)$ 是只有一个素理想的局部环，进而：
      $
      A quo p_i^(n_i) = (A quo p_i^(n_i))_(p_i quo p_i^(n_i)) = A_(p_i) quo (p_i A_(p_i)) ^(n_i)
      $
      但上式右侧当然是主理想环，因此左侧也是
    - 其次，既然环直积的理想都形如理想的直积，主理想环的直积当然也是主理想环，证毕

    对于第二个结论，任取 $x in alpha$，将有 $alpha quo (x)$ 是主理想，当然 $alpha$ 由至多两个元素生成 
  == 8
    不妨设 $A$ 是局部环，进而可设：
    $
    a = (x^u)\
    b = (x^v)\
    c = (x^w)
    $
    计算：
    $
    a sect (b + c) = (x^u) sect (x^v + x^w) = (x^u) sect (x^(min(v, w))) = (x^(max(u, min(v, w))))\
    (a sect b) + (a sect c) = (x^(max (u, v))) + (x^(max(u, w))) = (x^(min(max(u, v), max(u, w))))
    $
    不难验证两式相等

    $
    a + (b sect c) = (x^(min(u, max(v, w))))\
    (a + b) sect (a + c) = (x^(max(min(u, w), min(u, v))))
    $
    类似的两式相等
  == 9
    首先，证明 $A -> plus.circle_(i) A quo alpha_i -> directSum_(i < j) A quo (alpha_i +alpha_j)$ 正合。由于可做局部化，不妨设 $A$ 是局部环，进而是离散赋值环。\
    此时注意到理想之间存在全序，因此不妨设 $alpha_1 subset alpha_2 ... subset alpha_n$，因此：
    $
    directSum_(i < j) A quo (alpha_i +alpha_j) = directSum_(i < j) A quo alpha_j 
    $
    任取 $(x_i + alpha_i) in ker(plus.circle_(i) A quo alpha_i -> directSum_(i < j) A quo (alpha_i +alpha_j))$，将有：
    $
    forall i < j, x_i - x_j in alpha_j
    $
    因此：
    - $x_2 - x_1 in alpha_2 => x_1 + alpha_2 = x_2 + alpha_2$
    - $x_3 - x_1 in alpha_3 => x_1 + alpha_3 = x_3 + alpha_3 = x_2 + alpha_3$
    - ...
    因此可以不妨设 $x_1 = x_2 = ... = x_n$ ，证毕

    由此正合列，方程组有解 $x$ 当且仅当 $x in ker(plus.circle_(i) A quo alpha_i -> directSum_(i < j) A quo (alpha_i +alpha_j)) = im(A -> plus.circle_(i) A quo alpha_i)$
    


