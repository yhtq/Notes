#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业10",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
= 11.30 P101
== 1 <exercise>
    断言 $QQ[x, x^(1/2), x^(1/3), ..., x^(1/n), ...]$ 不满足因子链条件。事实上，在这个环上定义通常的次数，同样有：
    $
    deg(f g) = deg(f) + deg(g)
    $
    从而 $x^r, r!= 0$ 将成为不可逆元。同时：
    $
    x^r = (x^(r/2))^2
    $
    表明 $x^r$ 不是不可约元\】】
    现设：
    $
    x = product_{i=1}^m f_i (x)
    $
    并设 $f_i$ 的最低次项次数为 $a_i/b_i$\
    由于仅有有限多个 $f_i$，可取：
    $
    n = lcm(b_1, b_2, ..., b_m)
    $
    从而：
    $
    x^n = product_{i=1}^m f_i (x^n)
    $
    此时等式两端所有多项式都 $in QQ[x]$，进而：
    $
    f_i (x^n) = x^(m_i) => f_i(x) = x^(m_i/n)
    $
    （这是因为：$phi := [f(x) | f(x) -> f(x^2)]$ 是环上的自同态，且 $ker(phi) = {0}$ 表明 $phi$ 是单射）\
    然而已经证明了这样的元素不是 $QQ[x, x^(1/2), x^(1/3), ..., x^(1/n), ...]$ 中不可约元，因此 $x$ 不能写成有限个不可约元的乘积。
== 2
  - 假设 $R$ 是唯一分解整环，断言 $a, b$ 的唯一分解中，（在相伴意义下）最长的公共部分就是它们的最大公约数。也即可设：
    $
    a = d p_1 p_2 ... p_m\
    b = d q_1 q_2 ... q_n
    $
    其中 $p_1 p_2 ... p_m$ 与 $q_1 q_2 ... q_n$ 之间任何两元素都不相伴。\ 此时 $d$ 显然是公因子。为了证明它是最大公因子，设：
    $
    d' | a, d' | b
    $
    同时设 $d, d'$ 的唯一分解分别为：
    $
    d = d_1 d_2 ... d_k\
    d' = d'_1 d'_2 ... d'_l
    $
    由于 $R$ 中不可约元就是素元，因此对每个 $i$，$d'_i | d'_1 d'_2 ... d'_l | a, b$ 表明存在 $j, k$ 使得 $d'_i | p_j, q_k$，进而 $d'_i$ 与 $p_j, q_k$ 相伴。这就表明 $p_j$ 与 $q_k$ 相伴，因此 $p_j, q_i | d => d'_i | d$。\
    换言之，$d$ 包含 $d'$ 所有素因子，同时容易验证每个素因子在 $d$ 中的次数不小于在 $d'$ 中的次数，因此 $d | d'$，即 $d$ 是 $d'$ 的因子。\
    综上，$d$ 是 $a, b$ 的最大公因子。
  - 假设 $R$ 中任意两元素都有最大公因子，我们来证明 $R$ 中不可约元就是素元。事实上，设 $p$ 是不可约元，且：
    $
    a b = r p
    $
    则设 $d$ 是 $a, p$ 的最大公因子。若其恰为（相伴于）$p$，则 $p | a$，因此 $p$ 是素元。否则由不可约性，可设 $d = 1$，将有：
    $
    b = b (a, p) = (a b, b p) = (r p, b p) = p (r, b) 
    $
    这就表明 $p | b$，证毕
== 4
  容易验证：
  $
  R = {a+2 b i | a, b in ZZ} 
  $
  是 $ZZ[i]$ 的一个子环，而后者是唯一分解子环。断言：
  - $2i$ 是 $R$ 中不可约元

    事实上，$a, b in R, a b = 2 i => - i a b = 2$，而 $2$ 在 $ZZ[i]$ 中不可约，当然在 $R$ 中不可约，因此：
    $
    &{a, b} = plus.minus 1{i, 2} " 或"\
    &{a, b} = plus.minus 1{1, 2i}
    $
    而 $i in.not R$，因此 ${a, b} = plus.minus 1{2i, 1}$，这表明 $2i$ 是 $R$ 中不可约元。
  - $4 = 2 dot 2 = -(2i) dot (2i)$，而 $2, 2i$ 都是 $R$ 中不可约元，因此 $4$ 存在两种不同的不可约分解，因而 $R$ 不是唯一分解整环。
== 5
  注意到：
  $
  ZZ[sqrt(-5)] tilde.eq quotient(ZZ[x], (x^2 + 5))
  $
  而 $x^2 + 5$ 在 $ZZ[x]$ 中是不可约的，$ZZ[x]$ 是唯一分解整环，但 $ZZ[sqrt(-5)]$ 不是唯一分解整环。\
== 6
  若 $f(x)$ 是常多项式，则 $(f(x), x^2)$ 当然是更大的非平凡理想。\
  反之，取 $k$ 使得它与 $f(x)$ 所有系数均互素，此时断言 $(f(x), k)$ 是更大的非平凡理想
  - 若 $k in (f(x)) => k = f(x)g(x)$，显然 $f(x)$ 一定是常多项式，回到常多项式的情形
  - 反之，$(f(x), k)$ 一定较 $(f(x))$ 更大，只需证明这是非平凡理想。事实上，若：
    $
    1 = f(x)u(x) + k v(x)
    $
    取自然同态：$phi: ZZ[x] -> (quotient(ZZ, k ZZ))[x]$，将有：
    $
    1 = phi(f(x))phi(u(x))
    $
    这意味着 $phi(f(x))$ 将成为 $(quotient(ZZ, k ZZ))[x]$ 上的可逆元，但这样的多项式（由上节习题）必然满足所有非常数项系数都是幂零元，而这与之前假设所有系数均与 $k$ 互素（从而成为 $quotient(ZZ, k ZZ)$ 中可逆元）矛盾！\
    从而 $1 in.not (f(x), k)$，表明这不是平凡理想
  == 12
    #lemma[][
      代数整数集合对加法封闭
    ]
    #proof[
      设 $alpha, beta$ 是两个 $K$ 上的代数整数，以其为根的多项式分别为 
      $
      f(x) = sum_i a_i x^i, g(x) = sum_i b_i x^i
      $
      （这里我们排除 $alpha$ 或 $beta$ 恰好为 $0$ 的平凡情况，从而两个多项式至少是一次的）\
      事实上，我们可以假设它们已经在 $ZZ[x]$ 上不可约了。如果可约，例如：
      $
      f(x) = i(x)j(x)
      $
      则 $i(alpha), j(alpha)$ 将至少有一个为零，不妨取其为新的 $f(x)$（$i(x), j(x)$ 当然是 $ZZ[x}$ 上首 1 的多项式）。由于这样的操作每次都会降低多项式的次数，因此总可以在有限步终止，从而得到不可约的 $f(x)$。\
      再令：
      $
      l(x, y) = sum_i a_i (x-y)^i = f(x-y)\
      $
      容易看出 $l(alpha + beta, beta) = 0$\
      我们的目标是寻找 $h(x) in (l(x, y), g(y))$，从而这样的 $h(x)$ 满足：
      $
      h(x) = u(x, y)l(x, y) + v(x, y)g(y) \
      => h(alpha + beta) = u(alpha + beta, beta)l(alpha + beta, beta) + v(alpha + beta, beta)g(beta) = 0
      $<cond-h>
      //（这里暂时不要求 $h(x)$ 首 1）\
      事实上，设 $ZZ[x]$ 的分式域为 $Frac[x]$，我们不妨在 $(Frac[x])[y]$ 中考虑上述等式，最后去掉 $h(x), u(x, y), v(x, y)$ 的公分母就可以得到满足@cond-h 的 $h(x)$\
      而 $Frac[x]$ 是域，$(Frac[x])[y]$ 是欧几里得整环，因此这就相当于证明 $g(y), l(x, y)$ 在其中互素。\
      另一方面，注意到我们将 $ZZ[y]$ 上的不可约多项式 $g(y)$ 做了以下系数的延拓：
      $
      ZZ[y] -> (ZZ[x])[y] -> (Frac[x])[y]
      $
      - 第一步不改变其不可约性，只需考虑自同构： 
        $
        [f | f(x, y) -> f(y, x)] : ZZ[x, y] -> ZZ[x, y]
        $
        它将 $g(y)$ 变为整环 $ZZ[x]$ 上的零次多项式，而整环上的零次多项式不可约当然等价于其本身不可约。
      - 第二步也不改变其不可约性，只需注意到 $ZZ[x]$ 是唯一分解整环，$Frac[x]$ 是其分式域，我们又假设了 $deg(g) >= 1$，因此这就是高斯引理的结果。

      从而 $g(y)$ 成为 $(Frac[x])[y]$ 上不可约多项式，当然有：
      $
      (g(y)) + (l(x, y)) = (Frac[x])[y]
      $
      进而@cond-h 的结果成立。\
    ]
    回到题设，考虑 $QQ[sqrt(d)]$ 上的代数整数：
    - 显然 $forall a, b in ZZ, a, b sqrt(d)$ 都是代数整数，因此 ${a + b sqrt(d) | a, b in ZZ}$ 都是代数整数
    - 设 $a + b sqrt(d)$ 是代数整数，则取共轭知 $a - b sqrt(d)$ （它们是同一个整系数多项式的两个根）也是代数整数，从而 $2 a, 2 b$ 应当都是整数，换言之，$a, b = n/2, m/2$，其中 $n, m in ZZ$

    从而我们只需考虑形如 $a/2 + b/2 sqrt(d)$ 的数，它在 $QQ$ 中的最小多项式为：
    $
    (x-a/2)^2-(b^2 d)/4 = 0\
    x^2 - a + (a^2 - b^2 d)/4 = 0
    $
    要使 $a/2 + b/2 sqrt(d)$ 为代数整数，上面的多项式必须是整系数多项式，因此 $(a^2 - b^2 d)/4$ 是整数：
    - 若 $d = 1 mod 4$，则 $a^2 - b^2  = 0 mod 4$，因此 $(a, b) mod 2$ 的可能结果为：
      - $(1, 1)$
      - $(0, 0)$
    - 若 $d = 2, 3 mod 4$，则 $a^2 - b^2 d = 1 mod 4$，因此 $(a, b) mod 2$ 的可能结果仅有 $(0, 0)$
    从而结果就是题目中结果，同时容易验证对乘法封闭，因此构成环。
  == 13
    #let AlgebraZ(a, b) = $#a + #b (1 + sqrt(-3))/2$
    取自然的模函数：
    $
    N(AlgebraZ(a, b)) = ((2a+b)^2 + 3b^2)/4 = a^2 + b^2 + a b
    $
    自然满足 $N(x y) = N(x) N(y)$\
    在 $QQ[sqrt(-3)]$ 上，设：
    $
    AlgebraZ(a, b)/AlgebraZ(c, d) = AlgebraZ((m + Delta m), (n + Delta n))
    $
    其中 $|Delta m|, |Delta n| <= 1/2$\
    如此便有：
    $
    AlgebraZ(a, b) \
    = (AlgebraZ(m, n))(AlgebraZ(c, d)) + (AlgebraZ(Delta m, Delta n))(AlgebraZ(c, d))
    $
    且：
    $
    N((AlgebraZ(Delta m, Delta n))(AlgebraZ(c, d))) = N(AlgebraZ(Delta m, Delta n))N(AlgebraZ(c, d))\
    <= (1/4 + 1/4 + 1/4)N(AlgebraZ(c, d)) = 3/4 N(AlgebraZ(c, d))
    $
    这表明欧几里得整环成立。
  == 14
    #let AlgebraZ(a, b) = $#a + #b sqrt(2)$
    取自然的模函数：
    $
    N(AlgebraZ(a, b)) = |a^2 - 2b^2|
    $
    自然满足 $N(x y) = N(x) N(y)$\
    在 $QQ[sqrt(2)]$ 上，设：
    $
    AlgebraZ(a, b)/AlgebraZ(c, d) = AlgebraZ((m + Delta m), (n + Delta n))
    $
    其中 $|Delta m|, |Delta n| <= 1/2$\
    类似的，只需验证：
    $
    N(AlgebraZ(Delta m, Delta n)) = |Delta m^2 - 2 Delta n^2| <= max{Delta m^2, 2 Delta n^2} <= 1/2 < 1
    $
    从而结论成立
  == 15
    #let AlgebraZ(a, b) = $#a + #b (1 + sqrt(5))/2$
    取自然的模函数：
    $
    N(AlgebraZ(a, b)) = |((2a+b)^2 - 5b^2)/4| = |a^2 + a b - b^2| 
    $
    自然满足 $N(x y) = N(x) N(y)$\
    在 $QQ[sqrt(-3)]$ 上，设：
    $
    AlgebraZ(a, b)/AlgebraZ(c, d) = AlgebraZ((m + Delta m), (n + Delta n))
    $
    其中 $|Delta m|, |Delta n| <= 1/2$\
    类似的，只需验证：
    $
    N(AlgebraZ(Delta m, Delta n)) = |Delta m^2 + Delta m Delta n -Delta n^2| <= max{Delta m^2 + Delta m Delta n, Delta n^2}\
    <= 1/2 < 1
    $
    从而结论成立
  == 17
    #let AlgebraZ(a, b) = $#a + #b sqrt(-1)$
    #let ConjAlgebraZ(a, b) = $#a - #b sqrt(-1)$
    首先 $ZZ[sqrt(-1)]$ 是欧几里得整环，因此其上素元等价于不可约元。\
    取自然的模函数：
    $
    N(AlgebraZ(a, b)) = a^2 + b^2
    $
    题中等式可化为：
    $
    (AlgebraZ(a, b))(ConjAlgebraZ(a, b)) = p
    $<equ>
    #lemma[][
      @equ 有解当且仅当 $p$ 在 $ZZ[sqrt(-1)]$ 中可约
    ]<lemma-irreducible>
    #proof[
      必要性是显然的。充分性是由于设：
      $
      p = x y
      $
      其中 $x, y$ 都不是可逆元，则：
      $
      N(x)N(y) = p^2 => N(x) = N(y) = p
      $
      从而 $N(x) = x overline(x) = p = x y$，由整环性质知 $y = overline(x)$ 从而就是上述方程的解。
    ]
    从而我们只需要证明 $p$ 可约即可。事实上，假设 $p$ 不可约，从而 $(p)$ 成为素理想
    $
    quotient(ZZ[i], (p)) 
    $
    成为整环。（所有元素无非是 $ZZ_p + i ZZ_p$）\
    但另一方面，$quotient(ZZ,(p))$ 是域，其上的乘法群也是循环群，取其生成元为 $a in ZZ_p$ ，则有：
    $
    ord(a) = p - 1 (a in ZZ[i])\
    a^((p-1)/2) = -1 mod p\
    (a^((p-1)/4)+i)(a^((p-1)/4)-i) = a^((p-1)/2) + 1 = 0 mod p
    $
    由于 $quotient(ZZ[i], (p))$ 是整环，因此：
    $
    a^((p-1)/4)+i = 0 mod p or a^((p-1)/4) = -i mod p
    $
    但 $a^((p-1)/4) in ZZ$，故这显然是荒谬的。
  == 18
    #lemma[][
      设 $p$ 为一素数，$a in ZZ[sqrt(-1)]$ ，$N(a) = p => a$ 不可约
    ]
    #proof[
      设 $a = x y => N(x)N(y) = p $，不妨设 $N(x) = 1$, 进而：
      $
      x = 1, -1, i, -i
      $
      这些都是可逆元，从而当然有 $a$ 不可约。
    ]
    #lemma[][
      设 $x in ZZ[i]$ 是不可约元，则 $N(x) = p$ 或 $x ~ p$，其中 $p$ 为素数
     ]
    #proof[
      由于 $(x)$ 是 $ZZ[i]$ 中素理想，考虑嵌入同态：
      $
      phi: ZZ -> ZZ[i]
      $
      将有 $Inv(phi)((x))$ 成为 $ZZ$ 中素理想，因此存在素数 $p$ 使得：
      $
      exists k in ZZ[i], k x = p in ZZ
      $
      进而 $N(k)N(x) = N(p) = p^2 $，进而要么：
      $
      N(p) = p
      $
      要么：
      $
      N(k) = 1 => x ~ p
      $
      因此结论成立
    ]
    我们考虑所有 $ZZ$ 上素数 $p$：
    + $p=2$ 时，$N(x) = p, p^2$ 的元素仅有：
      $
      1 plus.minus i\
      $
      它们是不可约元
    + $p = 1 mod 4$ 时，由上题结论存在 $x$ 使得：
      $
      x overline(x) = p, N(x) = p
      $
      由引理这些元素当然是不可约元。同时，之前也证明了 $p$ 不是不可约元，因此由引理不存在 $N(x) = p^2$ 的不可约元
    + $p = 3 mod 4$ 时，@lemma-irreducible 的结论同样成立，由于平方数 $mod 4$ 的结果只能为 $0, 1$，因此@equ 无解，进而 $p$ 成为不可约元，没有 $N(x) = p$ 的元素


= 补充题
  == 
    - 乘法单位元存在，加法构成子群是显然的
    - 对于乘法封闭性，注意到：
      $
      (a + x^2f(x))(b + x^2g(x)) = a b + x^2(a f(x) + b g(x)) + x^4f(x) g(x)
      $
      因此对乘法也封闭。
    注意到 $x^2, x^3$ 在 $F[x]$ 上的分解只能为：
      $
      x^2 = x x\
      x^3 = x x x， x^2 x
      $
    在题中子环上这些分解都不存在，因此是不可约元。\
    但另一方面：
      $
      x^2, x^3 | x^6 = x^2 x^4 = x^3 x^3\
      $
    但 $x^2, x^4$ 都不是 $x^3$ 的倍数，$x^3, x^3$ 都不是 $x^2$ 的倍数，因此不是素元
  == 
    取 $a in P$，找到 $a$ 的唯一素分解：
    $
    a = product_i p_i
    $
    由于 $product_i p_i in P$，由素理想性质知必然存在 $p_j in P$，这个 $p_j$ 就是我们要找的素元
  ==
    设：$phi: R -> R'$ 是满同态，且 $R$ 是 Noether 环。由对应原理，$R'$ 中的理想与 $R$ 中包含 $ker(phi)$ 的理想一一对应，且生成元也互相对应。但 $R$ 中理想都是有限生成的，从而 $R'$ 中理想当然也有限生成。\
    注意到 $ZZ[sqrt(-5)] tilde.eq quotient(ZZ[x], (x^2+5))$ 不是 UFD，但可以取 $ZZ[x]-> ZZ[sqrt(-5)]$ 的自然同态，表明它是 Noether 环。\
    @exercise 给出了不是 Noether 环的整环，取其分式域当然是 Noether 环，从而它存在不是 Noether 环的子环。
  ==
    取 $c$ 的唯一素分解：
    $
    c = product_i p_i^(alpha_i)
    $
    其中 $p_i$ 互不相同。由于 $a, b$ 互素，每个 $p_i$ 要么是 $a$ 的因子，要么是 $b$ 的因子。同时 $a b = c^n$ 中，$p_i$ 的个数为 $n alpha_i$，进而 $p_i^(n alpha_i)$ 要么是 $a$ 的因子，要么是 $b$ 的因子。\
    同时，$a, b$ 不会有其他素因子，这意味着在相伴意义下，有：
    $
    a ~ product_k p_(i_k)^(n alpha_(i_k))\
    \ 
    b ~ product_k p_(j_k)^(n alpha_(j_k))\
    \   
    $
    进而结论成立
  ==
    不难发现：
    $
    (x+sqrt(2)i)(x-sqrt(2)i) = y^3
    $
    我们在唯一分解整环 $ZZ[sqrt(2)i]$ 上考虑问题。\
    取唯一素分解：
    $
    x+sqrt(2)i = p_1 p_2 ... p_n
    $
    同时设（用 $||$ 表示恰好整除）：
    $
    p_i^(alpha) || x + sqrt(2)i\
    p_i^(beta) || x - sqrt(2)i
    $
    表明：
    $
    p^(alpha + beta) || (x + sqrt(2)i)(x - sqrt(2)i) = y^3
    $
    进而 $alpha + beta$ 一定是三的倍数、
    但另一方面，不难验证 $x+sqrt(2)i$ 不会有实整数因子，而若 $p_i | x + sqrt(2), p_i | x - sqrt(2)i$，取共轭知 $overline(p_i) | x + sqrt(2), overline(p_i) | x - sqrt(2)$ 进而 $p_i overline(p_i) | x + sqrt(2)$，与其没有整数因子矛盾！\
    因此一定有 $beta = 0$，进而 $x+sqrt(2)i$ 是立方数。\
    令：
    $
    x+sqrt(2)i = (a + b sqrt(2)i)^3=>
    x+sqrt(2)i = a^3 +3a^2 b sqrt(2) i -6 a b -2 b^3 sqrt(2)i
    $  
    这告诉我们：
    $
    a^3 - 6 a b = x\
    3a^2 b - 2b^3 = 1 => b(3a^2-2b^2) = 1 => b = plus.minus 1
    $
    - $b=1$ 时，有 $a=plus.minus 1, x = plus.minus 5, y=3$
    - $b = -1$ 时，无解
  ==
    首先，由于 $R$ 可以看作 $R[x]$ 的子环，因此有条件知 $R$ 至少是整环。\
    其次，注意到 $R tilde.eq quotient(R[x], (x))$ ，由对应法则它将 $R$ 上的理想映成 $R[x]$ 中包含 $(x)$ 的理想，而这样的理想仅有两个平凡理想，因此 $R$ 一定是域。
  ==
    对 $a, 1$ 做辗转相除，将有：
    $
    1 = b dot a + r
    $
    且 $delta(r) < delta(a)$ 表明 $r=0$ 也即 $a$ 可逆。
  ==
    我们只要证明它在 $R[x]$ 中不可约，从而由高斯引理自然在 $F[x]$ 中不可约。\
    假设它在 $R[x]$ 中可约，设：
    $
    f(x) = g(x)h(x) = (sum_(i=0)^n c_i x^i)(sum_(i=0)^m b_i x^i)
    $
    由条件我们有：
    $
    p | b_0 c_0
    $
    且不会同时整除，不妨设 $p|b_0$ 有：
    $
    p | a_0 b_1 + a_1 b_0 => p | a_0 b_1 => p | b_1\
    p | a_0 b_2 + a_1 b_1 + a_2 b_0 => p | a_0 b_2 => p | b_2
    $
    以此类推，将有 $p | b_i$ ，但这将表明  $p | a_n$ ，矛盾！

= 12.4 P112
  == 3
    首先，不难验证合法的域嵌入只能将 $QQ$ 嵌入到 $CC$ 的子域 $QQ$\
    其次，这意味着域嵌入保持多项式：
    $
    x^2 + 1
    $
    将它的根映成它的根，从而只能将 $i$ 映为 $i$ 或 $-i$\
    这就给出了所有域嵌入。
  == 4
    同样的，域嵌入在 $QQ$ 上保持不动，因此保持多项式：
    $
    x^2 + 1
    $
    将它的根映成它的根。\
    但这个多项式在 $QQ[i]$ 中恰有两根，在 $QQ[sqrt(2)]$ 中没有根，因此不存在合法的域嵌入。
  == 5
    由于对于任意 $n$ ：
    $
    [f(x) in Frac(x) | x -> x^n]
    $
    都是 $Frac(x)$ 到自身的不同嵌入，而 $K(alpha) tilde.eq Frac(x)$ 故结论成立
  == 6
    + 显然：
      $
      (x - a)^2 + b^2 
      $
      是其一个零化多项式，且在 $QQ$ 上已经不可约（在 $QQ$ 上没有根），因此就是它的极小多项式
    + 显然：
      $
      x^p + 1
      $
      是其一个零化多项式，它可被分解为：
      $
      (x+1)(x^(p-1) - x^(p-2) + ... + 1) := f(x)g(x)
      $
      显然 $e^((2 pi i)/p)$ 不是前者的根，因此它是后者的根，从而后者是一个零化多项式。\
      同时，用 $x = x - 1$ 代入 $x^p + 1$ ，得：
      $
      (x-1)^p + 1 = sum_(i=1)^p (-1)^i C_p^i x^i = x (sum_(i=1)^(p) (-1)^i C_p^i x^(i-1))
      $
      上式后者当然就是 $g(x-1)$ ，它恰好符合 Eisenstein 判别法的要求，因此是不可约多项式，进而 $g(x)$ 就是一个最小多项式
  == 7
    $[F(alpha) : F] | [K : F] => [F(alpha) : F] = [K : F] => F(alpha) = K$
  == 8
    $n = [F(alpha) : F] | [K : F]$
  == 9
    注意到 $F(alpha^2) <= F(alpha)$，因此：
    $
    [F(alpha)^2 : F] | [F(alpha) : F] 
    $
    另一方面，若 $f(x)$ 是 $alpha^2$ 的零化多项式，则当然有 $f(x^2)$ 是 $alpha$ 的零化多项式，因此：
    $
    [F(alpha) : F] <= 2 [F(alpha^2) : F] 
    $
    同时 $[F(alpha) : F]$ 是奇数，上式无法取等，两式结合即得结论
  == 10
    设 $n = d m$，注意到代入同态：
    $
    [f(x) | x -> x^d]
    $
    是 $K[x]$ 上的单同态，同时不会将不可逆元映为可逆元，从而保持不可分解性。因此若 $x^m - a$ 不可分解，它的像 $x^n - a$ 也不可分解
  == 11
    + $1, sqrt(2), sqrt(3), sqrt(6)$ 足以作为一组基
    +
      显然 $omega in QQ[i, sqrt(3)]$\
      因此 $1, i, sqrt(3), sqrt(3)i$ 足以作为一组基
    +
      $e^((2i pi)/p), i = 0, 1, 2, ..., p-2$ 足以作为一组基（注意到这些元素除了 $1$ 以外最小多项式是 $p-1$ 次的，因此扩张次数就是 $p-1$）
  == 12
    $
    [E K : F] = [E K : K][K : F] = [E K : E] [E : F] 
    $
    因此必要性显然。\
    充分性，设 $E = F(alpha_1, alpha_2, ..., alpha_n), K = F(beta_1, beta_2, beta_m)$，其中 $alpha_i, beta_i$ 分别是域扩张的基。\
    容易验证 $alpha_i beta_j$ 这些元素可以线性表出 $E K$ 上所有元素，因此当然有 $[E K : F]$ 有限，且 $[E K : F] <= [E : F][K : F]$。\
    同时有：
    $
    [E : F] | [E K : F]\
    [K : F] | [E K : F]
    $
    从而 $[E : F][K : F]$ 互素时有：
    $
    [E : F][K : F] | [E K : F]
    $
    从而 $[E K : F] = [E : F][K : F]$，结论成立。
  == 13
    设 $phi$ 是 $F$ 自同态，任取 $alpha in K$, 设其在 $F$ 上的最小多项式为 $m(x)$\
    由于 $phi$ 保持 $m(x)$ 不变，因此把 $m(x)$ 的根映成根。而 $m(x)$ 的根仅有有限个，同时 $phi$ 是单射，因此 $phi$ 在这些根上的作用无非是全置换，从而存在某个根的像恰为 $alpha$\
    这就证明了 $phi$ 是满射，从而是自同构。\
= 补充题
  ==
    只需证明 $L - F$ 中的元素都可逆即可。\
    事实上，任取 $alpha in L - K$ ，取它在 $F$ 中的最小多项式（注意到 $a_0 !=0$ 否则与最小多项式不可约矛盾）：
    $
    sum_(i=0)^n a_i alpha^i = 0 =>  sum_(i=1)^n -(a_i)/(a_0) alpha^i = 1 => alpha sum_(i=1)^n -(a_i)/(a_0) alpha^(i-1) = 1
    $
    这就给出了 $alpha$ 的逆（显然在 $L$ 中），证毕。
  ==
    注意到 $root(5, 3)$ 的最小多项式为：
    $
    x^5 - 3 = 0
    $
    （由 Eisenstein 它确实是不可约多项式）\
    而它是五次多项式，表明 $[QQ[root(5, 3)] : QQ] = 5$，而它是素数，因而不存在任何非平凡的子扩张，故结论成立。
  ==
    取 $F = QQ(root(3, 2)), alpha = e^((2 pi i)/3)$\
    $[F : Q] = 3$ 是显然的。同时注意到：
    $
    x^3 - 1
    $
    在 $F$ 上仍然是不可约多项式（没有根），因此第二次扩张也是三次扩张。
  ==
    + \
      常多项式当然是代数元，而对一般的有理分式，显然不存在多项式使其为零（观察首项即可）
    + \
      设 $alpha = u(x)/v(x) = (sum_i a_i x^i)/(sum_i b_i x^i)$，从而：
      $
      alpha v(x) = sum_j b_j alpha x^j = u(x)\
      alpha v(x) - u(x) = 0
      $
      将上式左侧看作以 $F(alpha)$ 上元素为系数的多项式，这就给出了 $x$ 的一个零化多项式
    + \
      注意到：
      $
      1/alpha = (x^3 + x + 1)/(x^2 - 1) = x + (2x+1)/(x^2 - 1) in F(alpha)
      $
      因此：
      $
      (1/alpha)(x^2 - 1) = x^3 + x + 1\
      x^3 - (1/alpha) x^2 + x  + (1 + 1/alpha) = 0
      $
      同时，假设 $f(x) in F(alpha)$ 是上式的根，反推之，有：
      $
      alpha = (f(x)^2 - 1)/(f(x)^3 + f(x) + 1)
      $
      由于 $f(x)$ 本身也是 $g(alpha)$ 的形式，其中 $g(x) in F(x)$，上式将表明：
      $
      alpha = (g(alpha)^2 - 1)/(g(alpha)^3 + g(alpha) + 1)
      $
      这将给出 $alpha$ 的一个系数在 $F$ 上的零化多项式，这与第一问的结果矛盾！因此上述多项式已经没有根，从而成为不可约多项式，因此就是 $x$ 的最小多项式。
  == 5
    #lemma[][
      设 $F$ 是包含 $QQ$ 的域，$sqrt(a), sqrt(b), sqrt(a b) in.not F$，则：
      $
      [F(sqrt(a), sqrt(b)) : F] = 4
      $
    ]
    #proof[
      只需证明 $sqrt(b) in.not F(sqrt(a))$ 即可。如若不然，则有：
      $
      x + y sqrt(a) = sqrt(b) => x^2 + 2 x y sqrt(a) + y^2 a = b
      $
      由于 $x, y in FF$ ，且 $1, sqrt(a)$ 是一组基，故我们有：
      $
      x y = 0
      $
      - 若 $x = 0$，则 $sqrt(b) = y sqrt(a) => sqrt(a) sqrt(b) = y a in F$ 矛盾
      - 若 $y = 0$，则 $sqrt(b) = x => b = x^2 in F$ 矛盾
    ]
    这首先表明 $[F(sqrt(a_1), sqrt(a_2)) : F] = 4, [F(sqrt(a_1), sqrt(a_3)) : F] = 4, [F(sqrt(a_1), sqrt(a_2 a_3)) : F] = 4$\
    进一步，我们有 $a_2, a_3, a_2 a_3 in.not F(sqrt(a_1))$，再次利用引理便有：
    $
    [F(sqrt(a_1), sqrt(a_2), sqrt(a_3)) : F(sqrt(a_1))] = 4 => [F(sqrt(a_1), sqrt(a_2), sqrt(a_3)) : F] = 8
    $
    反复进行即得原结论
  == 6
    显然 $QQ[sqrt(alpha_1), sqrt(alpha_2), sqrt(alpha_3), ..., sqrt(alpha_n): QQ]$ 将是 $2$ 的幂次，但对任意 $F$ 满足 $root(6, 2)$ 至少有 $3 | [F : QQ]$ ，因此结论成立。
  == 7
    //$
    //a_1 := root(3, 7) + 2i\
    //a_2 := (root(3, 7) + 2i)^2 = root(3, 7^2) + 4 i root(3, 7) - 4 \
    //a_3 := (root(3, 7) + 2i)^3 = 7 + 6 i root(3, 7) - 6 root(3, 7^2) - 8i
    //$
    //显然 $a_1, a_2, a_3$ 的任意运算都在 $QQ[a_1]$ 中，我们只需要消去 $root(3, 7)$ 即可。\
    //这是容易的，取：
    //$
    //6 a_2 + a_3 = 30i root(3, 7) -24 + 7 - 8i = 30i root(3, 7) -8i - 17\
    //4a_1 + 6a_2 + a_3 + 17 = (30 i + 4)root(3, 7)\
    //(4a_1 + 6a_2 + a_3 + 17)^3 = 7(30i + 4)^3
    //$
    令 $a_1 = root(3, 7) + 2i$ ，计算得：
    $
    (a_1 - i)^3 = 7 = a_1^3 - 3 a_1^2 i + 3 a_1 i^2 - i^3 = a_1^3 - 3a_1 - 3a_1^2 i\
    i = (a_1^3 - 3a_1 - 7)/(3a_1^2)
    $
    整理即得 $i in QQ(root(3, 7) + 2i)$ ，从而 $QQ(root(3, 7) + 2i) = QQ(i, root(3, 7))$\
    同时，我们熟知（由于 $2, 3$ 互素） $[QQ(root(3, 7), 2i) : QQ] =6$，因此 $a_1$ 的最小多项式应该是六次的。\
    继续化简上式得：
    $
    -1 = (a_1^3 - 3a_1 - 7)^2/(9a_1^4) \
    9a_1^4 = (a_1^3 - 3a_1 - 7)^2
    $
    这便是一个六次的零化多项式，从而是最小多项式
  == 8
    熟知 $RR$ 上不可约多项式只能为一次或二次多项式。考虑 $K = RR[alpha]$
    - 若 $alpha$ 最小多项式为一次，则 $alpha in RR => K = RR$
    - 若 $alpha$ 最小多项式为二次，则:
      $
      alpha = a + b i, a, b in RR => i in K
      $
     从而 $K = CC$
  == 9
    - 假设 $quotient(E, F)$ 是代数扩张
      - 任取 $alpha in F$ 和它在 $E$ 上的最小多项式 $m_(E, alpha)(x)$ ，显然这也是它在 $H$ 上的一个零化多项式，因此它在 $quotient(E, H)$ 中也是代数的，这表明 $quotient(E, H)$ 是代数扩张。
      - 由于 $H <= F$ ，显然所有 $F$ 中的元素都在 $E$ 上代数，因此 $quotient(E, H)$ 是代数扩张。
    - 假设 $quotient(E, H), quotient(H, F)$ 都是代数扩张。
      //任取 $alpha_i$ 是 $quotient(E, H)$ 一组基，$beta_i$ 是 $quotient(H, F)$ 一组基。\
      //对任意 $x in E$ 有：
      //$
      //x = (alpha_1, alpha_2, ..., alpha_n)X, X in H^n
      //$
      //而 $H$ 中任意元素又可被 $beta_i$ 线性表出，因此可设：
      //$
      //X = Y vec(beta_1, beta_2, dots.v, beta_m), Y in M_(n times m)(F)\
      //(alpha_1, alpha_2, ..., alpha_n) = (beta_1, beta_2, ..., beta_m)A, A in M_(m times n)(F)
      //$
      //两式结合即有：
      //$
      //x = (beta_1, beta_2, ..., beta_m)A Y vec(beta_1, beta_2, dots.v, beta_m)
      //$
      任取 $alpha in E$ ，找其在 $H$ 上的最小多项式 $m_(H, alpha)(x)$。由于这个多项式中只涉及有限多个 $H$ 中元素，不妨设为 $beta_1, beta_2, ..., beta_m$，因此有：
      $
      m_(H, alpha)(x) in F(beta_1, beta_2, ..., beta_m)[x]
      $
      而 $F(beta_1, beta_2, ..., beta_m)$ 是有限代数扩张，我们当然有：
      $
      [F(beta_1, beta_2, ..., beta_m)(alpha) : F] \
      = [F(beta_1, beta_2, ..., beta_m)(alpha) : F(beta_1, beta_2, ..., beta_m)][F(beta_1, beta_2, ..., beta_m) : F] \< infinity 
      $
      因此 $alpha$ 在 $F$ 上代数，由 $alpha$ 的任意性，这表明 $quotient(E, F)$ 是代数扩张。
  == 10
    +
      注意到 $ZZ_2$ 上的二次多项式分别为：
      $
      x^2 , x^2 + x = x(x +1), x^2 + x + 1, x^2 + 1 = (x+1)^2
      $  
      其中仅有 $x^2 + x + 1$ 不可约，而容易验证它不是 $x^5 + x^4 + x^2 + x + 1$ 
      的因子，因此 $x^5 + x^4 + x^2 + x + 1$ 没有二次不可约因子。\
      同时，它也没有根，因此不含一次因子。\
      因此它是不可约多项式。
    +
      设 $E = QQ[omega], K = QQ[root(5, 2), omega], H = K(alpha)$ 其中 $omega$ 是五次单位根。\
      由于 $[E : QQ] = 4, [QQ(root(5, 2)) : QQ] = 5$，故显有 $[K : QQ] = 20$
      容易验证，对 $i = 1, 2, 3, 4, 5$:
      $
      root(5, 2) -> root(5, 2) omega^i
      $
      诱导出一个 $H$ 上的 $E-$ 自同构，且这些自同构构成群。
      - 由于 $alpha in H$，则由于 $G$ 保持 $QQ$ 不动，从而保持 $f(x)$ 不动，从而将它的根映为它的根。\ 
        设 $f(x)$ 在 $K$ 中有 $m$ 个不同的根，则 $G$ 作用于这些根构成的集合 $X$ 上构成群作用，诱导出群同态 $phi: G -> S_m$。\
        另一方面，被 $G$ 中所有元素保持不动的 $K$ 中元素恰为 $QQ(omega)$，而五元群没有非平凡子群，表明以下两者有且只有一个成立：
        + $ker(phi) = G$，进而 $X subset QQ(omega)$ 。考虑扩张次数这是荒谬的
        + $ker(phi) = {e}$，进而 $G$ 同构与 $S_m$ 的某个子群，这就给出 $m >= 5$。而 $f(x)$ 至多有五个不同的根，因此 $m = 5$（同时表明 $f(x)$ 无重根）
      - 注意到要么 $alpha in K$，要么 $alpha in.not K$
        - 若前者成立，则 $K = H$ 将拥有 $f(x)$ 的所有根。考虑 $f(x)$ 于 $QQ(root(5, 2))$ 上的可约性：
          - 若它是二次和三次不可约多项式的乘积，则在 $K$ 中将出现最小多项式为三次的元素，这与 $[K : QQ(root(5, 2))] = 20$ 是矛盾的。
          因此 $f(x)$ 在 $QQ(root(5, 2))$ 一定有根，不妨设 $alpha in QQ(root(5, 2))$\
          进而 $QQ(root(5, 2)) = QQ(alpha)$，设：
          $
          root(5, 2) = a + b alpha + c alpha^2 + d alpha^3 + e alpha^4
          $
          只需令 $(root(5, 2))^5 = 2$。事实上，由于这是首一多项式，因此可设这些系数都是整数。\
          对系数 $mod 5$ 考虑，有：
          $
          2 = (a + b alpha + c alpha^2 + d alpha^3 + e alpha^4)^5 = a^5 + b^5 alpha^5 + c^5 alpha^10 + d^5 alpha^15 + e^5 alpha^20\
          $
          注意到 $alpha^5 in QQ(alpha)=> QQ(alpha^5) <= QQ(alpha) => [QQ(alpha^5) | QQ] | [QQ(alpha) | QQ] = 5$，因此在 $QQ$ 上 $alpha^5$ 的最小多项式次数只能为 $1, 5$\
          同时，若 $alpha^5 in QQ$，则 $alpha$ 将在 $QQ$ 上拥有不高于四次的零化多项式，与 $f(x)$ 不可约矛盾，因此 $alpha^5 in.not QQ$，进而 $alpha^5$ 的最小多项式次数为 $5$，这就表明 $alpha^5, alpha^10, alpha^15, alpha^20$ 在 $ZZ$ 上也线性无关。\
          故 $a = 2 mod 5, b, c, d, e = 0 mod 5$\
          再对系数 $mod 25$ （此时非零项至少选取四次 $a$）有：
          $
          2 = (a + b alpha + c alpha^2 + d alpha^3 + e alpha^4)^5 = a^5 + a^4(b alpha + c alpha^2 + d alpha^3 + e alpha^4)
          $
          这表明 $a^4 = 0 mod 5 => 5 | a$，进而 $a, b, c, d$ 全部都是 $5$ 的倍数，显然与等式矛盾。
          因此此种情况不成立。
          //$
          //20 = [K : QQ] = [H : QQ] = [H : QQ(root(5, 2), alpha)][QQ(root(5, 2), alpha) : QQ] >= 5 [H : QQ(root(5, 2), alpha)]
          //$
          //同时，由于五次单位根的循环性，故 $[H : QQ(root(5, 2), alpha)]$ 只能是 $4$ 或 $1$
          //- $[H : QQ(root(5, 2), alpha)] = 4 => [QQ(root(5, 2), alpha) : QQ] = 5$，进而 $QQ(alpha) = QQ(root(5, 2))$\
          //- $[H : QQ(root(5, 2), alpha)] = 1 => omega in QQ(root(5, 2), alpha)$，从而上述推理仍然可以进行，进而 $QQ(root(5, 2), alpha)$ 将包含 $f(x), x^5 - 2$ 的所有根。\
          //  再考虑 $f(x)$ 在 $QQ[root(5, 2)]$ 中的可约性，此时一定可约（否则 $[QQ(root(5, 2), alpha) : QQ] = 25$）。若其能写成二次和三次不可约多项式的乘积，则 $QQ[root(5, 2), alpha]$ 中将出现三次
        - 若后者成立，则类似可以证明 $f(x)$ 在 $K$ 中一定没有根（否则拥有所有的根）。\
          同时，若 $f(x)$ 在 $K$ 中是二次和三次不可约多项式的乘积，取 $g(x)$ 是三次因子，三个根分别构成集合 $Y$。利用类似上面的论证可以知道 $Y subset QQ(omega)$，这是荒谬的。 \
          这表明 $f(x)$ 在 $K$ 中仍然不可约，从而在 $QQ[root(5, 3)]$ 中不可约，进而结论成立。
  == 11
    +
      保持乘法和乘法单位元是显然的。对于加法，只需注意到：
      $
      0^p = 0\
      (phi(x) + phi(y))^p = phi(x)^p + phi(y)^p\
      (-phi(x))^p = -phi(x)^p
      $
      同态性质也成立。
    +
      首先证明它是单射，事实上显然有：
      $
      x^p = 0 => x = 0
      $
      其次，有限域上的单射就是满射，因此它是同构。
    +
      容易验证 $F$ 也是特征 $p$ 的域。同时，因此由上面知单射性。然而，显然不存在 $f(x)$ 使得：
      $
      (f(x))^p = x
      $
      （考察次数即可）
      因此不是满射
  == 12
    +
      显然只需以 $F$ 为系数， $t$ 足以生成 $K$ 上所有元素，当然有 $K = E(t)$
    +
      $
      p(t) = h(t)g(t) - f(t) = 0
      $
    +
      考察 $p(x)$ （化简前的）的最高次项。若只出现在 $f(x)$ 或 $g(x)$ 中，结论当然成立。\
      若同时出现，设分别为 $a x^n,b x^n, a, b in K$，则 $p(x)$ 的 $n$ 次系数为：
      $
      a h(t) + b
      $
      显然它不是零，否则 $h(t) in K$
    +
      设：
        $
        h(t)f(x) - g(x) = k(x)l(x) = sum_i a_i (h(t)) x^i
        $
      考虑二元有理分式式：
        $
        y f(x) - g(x) - sum_i a_i (y) x^i
        $
      将其视作各项系数都在 $Frac(y)$ 上的分式多项式。若某项系数不是零有理分式项式，则成为 $h(t)$ 的一个非零零化多项式，与 $h(t)$ 在 $F$ 上超越是矛盾的。\
      因此有：
        $
        y f(x) - g(x) = k(x, y)l(x, y)
        $
      相等是在 $(Frac(y))[x]$ 意义下的相等。我们只需考虑 $y f(x) - g(x)$ 在该多项式环下的可约性即可。\
      又由高斯引理（注意到 $F[y]$ 是唯一分解整环），$y f(x) - g(x)$  在 $(Frac(y))[x]$ 上的不可约性等价于 $(F[y])[x]$ 上的不可约性，因此不妨假设 $k, l in (F[y])[x]$。\
      再将两侧视作 $y$ 的多项式，观察次数不难发现 $k, l$ 恰有一个是 $(F[x])[y]$ 上的常多项式，另一个是一次多项式，不妨设:
      $
      k(x, y) = k(x)\
      l(x, y) = u(x)y + v(x)
      $
      计算不难发现：
      $
      k(x)u(x) = f(x)\
      k(x)v(x) = g(x)
      $
      但由于 $f, g$ 互素，故 $k(x) ~ 1$，进而 $k(x, y) ~ 1$ ，这就表明原式不可约！

           



