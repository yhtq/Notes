#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业9",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
（11.20 日作业）
= P89
== 5
  (1). \
     $R$ 中元素 $x$ 可逆当且仅当 $gcd(x, p^n) = 1 <=> gcd(x, p) = 1$\
     因此 $R$ 中所有不是 $p$ 的倍数的元素都是可逆元。是 $p$ 的倍数的元素 $x$ 均有 $x^n = 0$，因此结论成立
  (2). \
      设 $I$ 是 $R$ 中某个素理想，注意到：
      $
      p dot p^(n-1) = 0 in I => p in I or p^(n-1) in I
      $
      表明 $(p) subset I or (p^(n-1)) subset I$。
      - 若 $(p) subset I$，则 $I = (p)$（注意到 $I$ 中没有可逆元，否则成为平凡理想）
      - 若 $(p^(n-1)) subset I$，则有：
        $
        p dot p^(n-2) = p^(n-1) in I => p in I or p^(n-2) in I
        $
        以此类推，最终有 $p in I$，因此 $I = (p)$
  (3). \
      容易验证 $I$ 也是极大理想，从而商环当然是域
== 7
  由同构定理
  $
  quotient(im(phi), (Q inter im(phi)) ) tilde.eq quotient(R, Inv(phi)(Q inter im(phi)))
  $
  由于 $Q$ 是素理想，故 $Q inter im(phi)$ 也是 $im(phi)$ 中素理想，因此上式前者是整环，因而后者也是整环，表明 $Inv(phi)(Q inter im(phi)) = Inv(phi)(Q)$ 也是素理想

  对于极大理想，结论不成立。例如考虑 $ZZ_6 -> QQ$ 的嵌入映射，$QQ$ 中的极大理想 ${0}$ 的原像为 ${0}$，但 ${0}$ 不是 $ZZ_6$ 的极大理想
== 8
  #lemma[][
    设 $P$ 是素理想，$product_(i = 1)^n x_i in P$，则 $exists i: x_i in P$
  ]
  #proof[
    用归纳法，$n = 1$ 时显然成立。假设 $n = k$ 时成立，考虑 $n = k + 1$ 的情况：
    - 若 $x_1 in P$，则结论成立。
    - 若 $x_1 in.not P$，则 $product_(i = 2)^n x_i in P$，由归纳假设，$exists i: x_i in P$，因此结论成立
  ]
  如若不然，对于每个 $i$，可以取得 $x_i != 0$ 使得：
  - $x_i in I_i$
  - $x_i in.not P$
  从而 $product_i x_i in inter.big_i I_i subset P$，由引理，$exists i: x_i in P$，这与 $x_i in.not P$ 矛盾！
== 9
  用归纳法，显然 $n = 1$ 时情形成立。假设 $n-1$ 时情形成立，考虑 $n$ 的情形。不妨设 $I inter P_i$ != ${0}$。\
  假设对于每个 $i$，都存在 $x_i$ 使得：
  - $x_i in I$
  - $x_i in P_i$
  - $x_i in.not P_j (j != i)$
  则考虑：
  $
  sum_(i= 1)^n product_(j != i) x_j
  $
  注意到 $product_(j != i) x_j in P_k, forall k != i$。同时，$product_(j != i) x_j in.not P_i$（否则与引理和假设矛盾）。\
  这表明 $sum_(i= 1)^n product_(j != i) x_j$ 中有且恰有一项 $in.not P_i$，因此它不在任何一个 $P_i$ 中，但它在 $I$ 中，矛盾！\
  从而假设不成立，故存在某个 $i$ 使得：
  $
  I inter P_i subset P_j
  $
  从而可以去掉 $P_i$，用归纳假设即知原命题成立。
== 10
  #lemma[][
    有限整环是域
  ]
  #proof[
    设 $R$ 是有限整环，$x in R, x != 0$，考虑映射 $f: R -> R$，$f(y) = x y$。\
    由于 $R$ 是有限集，$f$ 是单射，因此 $f$ 是双射，从而存在 $y$ 使得 $x y = 1$，即 $x$ 可逆
  ]
  设 $R$ 是有限环，则：
  $
  I "是素理想" <=> quotient(R, I) "是整环" <=> quotient(R, I) "是域" <=> I "是极大理想"
  $
== 11
  $Z_((p))$ 就是 ${n/(k p + r) | n in ZZ, k in ZZ, r in {1, 2, ..., p}}$
== 13
  (1)\
    易知 $a (I R_p) = (a I) R_p subset I R_p$，结论成立
  
  (2)\
    设 $a_1/b_1, a_2/b_2 in R_p, q in Q, a_3/b_3 in R_p$，且：
    $
    a_1/b_1 a_2/b_2 = q a_3/b_3
    $
    则：
    $
    q a_3 b_1 b_2 = a_1 a_2 b_3 in Q
    $
    由于 $Q$ 是素理想，这表明 $a_1, a_2, b_3$ 中必有一个在 $Q$ 中。
    - 若 $b_3$ 在 $Q$ 中，则 $1 = b_3 1/b_3 in Q R_P => Q R_P = (1)$
    - 若恒有 $a_1$ 或 $a_2$ 在 $Q$ 中，则是素理想
  (3) \
    设 $I$ 是 $R_P$ 的非平凡理想，则对任意 $a/b in I$，断言 $a in P$，否则：
    $
    a in R - P => 1/a in R_P => a/b dot 1/a dot b = 1 in I
    $
    表明 $I subset P R_P$，进而结论成立。
  (4)\
    由 $(2)$ 的证明看出若 $Q subset P$ 是 $R$ 的素理想，则 $Q R_P$ 是 $R_P$ 的素理想。\
    同时承接 $(3)$ 的证明，若 $I$ 是 $R_P$ 的素理想，断言：
    $
    I = (I inter P) R_P
    $
    且 $I inter P$ 是 $R$ 的素理想。\
    事实上，$(I inter P) R_P subset I$ 是显然的，而对任意 $a/b in I$，显有 $a in P, b in R - P$，从而 $a = a/b dot b in I inter P$，进而 $(I inter P) R_P = I$。\
    同时设 $a_1, a_2 in R$，则：：
    $
    a_1 a_2 in I inter P => a_1 a_2 in in I => a_1 in I or a_2 in I => a_1 in I inter R or a_2 in I inter R \
    => a_1 in I inter P or a_2 in I inter P
    $
    足以给出题目所设构成一一映射。
= 补充题
== 
  由对应定理：
  $
  quotient(R, I) tilde.eq quotient(R', phi(I))\
  quotient(R, Inv(phi)(j)) tilde.eq quotient(R', J)
  $
  结合素（极大）理想与商环性质的等价性，所有结论都成立
== 
  - 设 $I$ 是素理想，$x^n = 0$，往证 $x in I$：
    \
    对 $n$ 进行归纳，事实上：
    $
    x dot x^(n-1) = 0 in I => x in I or x^(n-1) in I
    $
    - $n = 2$ 时，两者都表明 $x in I$
    - $n > 2$ 时，若前者成立则结论成立，若后者成立则归纳可知 $x in I$，结论成立
  - 记 $P$ 是所有幂零元构成的集合。上面已经证明了它含于所有素理想。为了证明它是所有素理想的交，只需验证任取 $x in R - P$，$x$ 不在某个素理想中即可。\
    显然 $x != 0$。考虑包含 $(x+1)$ 的极大理想，它将成为素理想，且 $x$ 不在其中（否则 $1$ 将在其中，成为平凡理想），这就表明结论成立。
==
  #lemma[][
    主理想环的商环还是主理想环
  ]
  #proof[
    设 $R$ 是主理想环，$I$ 是其一个理想，$J$ 是 $quotient(R, I)$ 的理想，则由对应定理，$Inv(phi)(J)$ 成为 $R$ 的理想，因此可设：
    $
    Inv(phi)(J) = (a)
    $
    另一方面，之前习题证明了 $phi((a)) = (phi(a))$，故：
    $
    J = phi(Inv(phi)(J)) = phi((a)) = (phi(a))
    $
    因此结论成立。
  ]
  - 之前习题证明了有限环的素理想就是极大理想，这里只考虑素理想即可。同时由引理，所有理想都是主理想。\
  显然 $ZZ_n$ 中所有幂零根恰为所有包含所有 $p_i$ 的整数的集合，也就是 $(p_1 p_2 ... p_k)$\

  设 $P$ 是 $ZZ_n$ 中素理想，我们有：
  $
  p_1 p_2 ... p_k in P
  $
  由素理想的性质，这表明 $exists i: p_i in P$，进而 $(p_i) subset I$。\
  事实上，由引理可设 $I = (m)$，从而 $m | p_i => m = p_i$，故 $I = (p_i)$。同时容易验证 $(p_i)$ 确实是素理想，因此它就是所有的素理想。
==
  用归纳法，$n = 1$ 时显然。假设 $n - 1$ 时情形成立。\
  假设存在 $x_i$ 使得：
  $
  x_i in I_i\
  x_i in.not I_j (j != i)
  $
  从而对每个 $i$，均有 $x_i in.not P$，故：
  $
  product_i x_i in.not P
  $
  但是:
  $
  product_i x_i in inter.big_i I_i = P
  $
  矛盾！
  从而必有某个 $I_i$ 含于另一个，消去较大的利用归纳法即得。
   
==
  #lemma[][
    设 $R$ 是主理想整环，$(a)$ 是素理想，$b in.not (a)$，则 $(a)$ 与 $(b)$ 互素
  ]
  #proof[
    由条件，可设：
    $
    (a) + (b) = (m)
    $
    而 $(a) subset (a) + (b) = (m)$，表明：
    $
    a = k m in (a) => k in (a) or m in (a) 
    $
    - $k in (a) => k = a u$，则：
      $
      a = k m = a u m => a (1 - u m) = 0 => 1 = u m => (m) = (1)
      $
      进而结论成立
    - $m in (a) => (m) = (a)$，则：$(b) subset (a) => b in (a)$，矛盾！
  ]
  设 $R$ 是主理想整环，$P = (a)$ 是一个素理想。取自然同态 $phi: R -> quotient(R, P)$往证 $quotient(R, P)$ 是域。\
  事实上，任取 $b in.not (a)$，将有：
  $
  (b) + (a) = (1) => phi((b)) = phi((1)) => (phi(b)) = (phi(1))
  $
  换言之，$quotient(R, P)$ 中所有元素可逆，进而是域，从而结论成立。
==
  设 $f(x)$ 可逆，由代入同态，$f(0)$ 也可逆，故 $a_0$ 可逆\
  不妨设 $a_0 = 1$：
  - 假设 $f(x)$ 所有系数都幂零，则：
    $
    a_i x^i, i =1, 2,3 .., n
    $
    都幂零，因此它们的和也幂零。设 $A = - sum_(i=1)^n a_i x^i$，将有 $A$ 幂零，且：
    $
    f = 1 - A
    $
    由之前习题，$1 - A$ 幂零，因此 $f$ 幂零
  - 若 $f(x) g(x) = sum_(i=1)^n a_i x^i sum_(j=1)^m b_j x^j = 1$，比照系数知：
    $
      a_n b_m =1\
      a_n b_(m-1) + a_(n-1) b_m = 0 => (a_n)^2 b_(m-1) = 0 \
      a_n b_(m-2) + a_(n-1) b_(m-1) + a_(n-2) b_m = 0 => (a_n)^3 b_(m-2) = 0 \
      ...
      (a_n)^m dot b_0 = 0
    $
    同时 $b_0$ 是可逆元，因此 $(a_n)^m = 0$，表明 $a_n$ 是幂零元，进而 $a_n x^n$ 幂零。\
    由于单位减去幂零元也是单位，故以此类推可得所有系数都幂零。
==
  $125 = 5^3$，只需要在 $ZZ_5$ 上寻找三次不可约多项式即可。\
  可以验证：
  $
  x^3 + 2 x^2 + 2 x + 3
  $
  没有根，因此它是不可约多项式，进而 $x^3 + 2 x^2 + 2 x + 3$ 是 $ZZ_5$ 上的三次不可约多项式，故：
  $
  quotient(ZZ_5, (x^3 + 2 x^2 + 2 x + 3)) 
  $
  就是 $125$ 阶域








