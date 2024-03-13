#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为3月5日）
#set heading(numbering: none)
= 2.
  == i)
    - 若 $a_0$ 是单位，其余 $a_i$ 是幂零元，将有：
      - $a_i x^i, i = 1, 2, ..., n$ 是幂零元
      - $sum_(i=1)^n a_i x^i$ 作为幂零元的和是幂零元
      - $a_0 + sum_(i=1)^n a_i x^i$ 作为单位 + 幂零元是单位
    - 若 $f$ 是单位：
      - 任取 $A$ 的素理想 $P$，取自然同态 $pi: A[x] -> (A quo P)[x]$，将有 $pi(f)$ 成为 $(A quo P)[x]$ 的单位\
        然而注意到 $A quo P$ 是整环，因此 $(A quo P)[x]$ 上的单位只能是 $A quo P$ 中单位，这就给出 $a_i in P, i = 1, 2, ..., n$\
        因此这些 $a_i$ 属于所有素理想，自然是幂零元
      - 此外，这给出 $a_0$ 在所有素理想的商环中都是单位。假如 $a_0$ 在 $A$ 中不是单位，考虑 $(a_0)$ 扩充成的极大理想 $I$，这是素理想但 $a_0 + I = 0 + I$ 不可能是单位，矛盾。故 $a_0$ 是单位
  == ii)
    - 若 $a_i, i = 0, 1, 2, ..., n$ 都幂零，则 $a_i x^i$ 也幂零，它们的和当然也幂零，因此 $f$ 是幂零元
    - 若 $f$ 是幂零元，类似的任取 $A$ 中素理想 $P$ 和自然同态 $pi: A[x] -> (A quo P)[x]$，$pi(f)$ 也幂零。然而 $(A quo P)[x]$ 是整环，因此 $pi(f) = 0$。\
      因此 $f$ 的所有系数都在 $P$ 之中。由于 $P$ 是任取的，因此 $f$ 的所有系数都是幂零元
  == iii)
    - 假如存在 $a in A - {0}$ 使得 $a f = 0$，则 $f$ 当然是零因子
    - 反之，设 $f$ 是零因子，则 $I = {g in A[x] | f g = 0}$ 是 $A[x]$ 中的理想。只需证明 $I sect A != emptyset$\
      如若不然，取 $g in I - {0}$ 是 $I$ 中最低次元素之一，设:
       $
       f(x) = sum_(i = 0)^n a_i x^i, g(x) = sum_(i = 0)^m b_i x^i
       $
      则观察得 $a_n b_m = 0$\
      因此 $a_n g in I$ 的次数比 $g$ 更低，因此 $a_n g = 0$\
      以此类推可得 $a_i g = 0, i = 0, 1, 2, .., n$\
      特别的，$a_i b_0 = 0, i = 0, 1, 2, ..., n$，故 $b_0 f = 0$，证毕
  == iv)
    记多项式 $f$ 的所有系数生成的理想为 $I_f$
    - 若 $f, g$ 都是本原多项式，假设 $f g$ 不是本原多项式，设其系数生成的非平凡理想为 $I := I_(f g)$ 并取自然同态 $pi: A[x] -> (A quo I)[x]$\
      显然将有 $pi(f g) = 0$
      + $pi(f), pi(g) != 0$，这表明 $pi(f), pi(g)$ 是 $(A quo I)[x]$ 中的零因子，由上题结论知存在 $a + I, b + I != 0 in A quo I$ 使得：
        $
        (a + I) pi(f) = 0, (b + I) pi(g) = 0\
        <=> a f in I[x], b g in I[x]\
        => a I_f, b I_g subset I\
        => (a), (b) subset I\
        => a, b in I
        $
        矛盾！
      + $pi(f) = 0 or pi(g) = 0$，不妨设 $pi(f) = 0$，此时有：
        $
        pi(f) = 0 => f in I[x] => A = I_f subset I => I = A 
        $
        这与 $I$ 非平凡矛盾
    - 若 $f g$ 是本原多项式，若 $f, g$ 不都是本原多项式，不妨设 $f$ 不是本原多项式，取 $pi: A[x] -> (A quo I_f)[x]$，有：
      $
      pi(f) = 0 => pi(f g) = 0 => f g in I_f[x] => A = I_(f g) subset I_f
      $
      这将导出 $I_f = A$，矛盾
  = 4
    记幂零根为 $Re_p$，Jacobson 根为 $Re_m$
    - 一方面，交换环中的极大理想都是素理想，$Re_m supset Re_p$
    - 另一方面，任取 $f in Re_m$ 往证 $f in Re_p$\
      注意到 $f := sum_(i=0)^n a_i x^i in Re_m => 1 - f(x) g(x) in U(A[x]), forall g in A[x]$，只需取 $g(x) = x$，将有：
      $
      1 - x f(x) in U(A[x])
      $
      由之前习题结论，这给出 $a_i, i = 0, 1, 2, 3, ... ,n$ 在 $A$ 中幂零，因此 $f in Re_p$，证毕
  = 6
    类似的，只需任取 $f in Re_m$ 往证 $f in Re_p$，换言之，只需证明：
    $
    1 - f g in U(A), forall g in A => f "幂零"
    $
    如若不然，$(f) subset.not Re_p$，取 $(f)$ 中的非零幂等元 $e = g f$，将有：
    $
    g f = g^2 f^2 => g f(1 - g f) = 0 => g f = 0 => e = 0
    $
    （注意到 $1 - g f$ 是单位）\
    矛盾！
  = 7
    任取 $A$ 中素理想 $P$，$A' := A quo P$ 是整环，同时满足 $forall x in A', exists n in NN, x^n = x$，但注意到：
    $
    x^n = x => x(x^(n-1) -1) = 0 => x = 0 or x^(n-1) = 1 => x = 0 or x in U(A')
    $
    这说明 $A'$ 是域，进而 $P$ 是极大理想
  = 8
    在包含关系上，幂零根当然就是所有素理想构成集合的最小元
  = 9
    - 设 $alpha = r(alpha)$，注意到 $r(alpha)$ 是所有包含 $alpha$ 的素理想的交，因此 $alpha = r(alpha)$ 当然也是素理想的交
    - 设 $alpha = sect.big_(i in I) P_i$，则 $r(alpha) = r(sect.big_(i in I) P_i) subset sect.big_(i in I)r(P_i) = sect.big_(i in I)P_i = alpha$，同时显有 $alpha subset r(alpha)$，因此 $alpha = r(alpha)$，证毕
  = 14
    - 首先证明 $Sigma$ 中有极大元。对于 $Sigma$ 的某个全序子集 $S$，$union.big S$ 是同样满足要求的理想，因此成为 $S$ 在 $Sigma$ 中的上界。由 Zorn 引理，$Sigma$ 中有极大元
    - 任取 $Sigma$ 中的极大元 $P$，往证它是素理想\
      注意到若 $I_1, I_2 in Sigma$，则 $I_1 + I_2 in Sigma$
      - 设 $x y in P$，验证 $x in P or y in P$\
        注意到 $x y$ 是零因子，因此 $exists f: f x y = 0$，表明 $x, y$ 都是零因子
      - 此时 $P + (x), P + (y) in Sigma$，由 $P$ 的极大性有 $x, y in P$，证毕
  = 15
    == i)
      - 显然 $forall P in Spec(A), E subset P <=> alpha subset P$，当然有 $V(E) = V(alpha)$
      - 此外，显有 $r(alpha) supset alpha => V(r(alpha)) subset V(alpha)$，往证 $V(alpha) subset  V(r(alpha))$\
        事实上，我们有：
        $
        forall P in Spec(A), alpha subset P => r(alpha) subset r(P) = P
        $
        这就是说 $V(alpha) subset V(r(alpha))$，证毕
    == ii)
      - 显然所有素理想都包含 $0$，因此 $V(0) = Spec(A)$
      - 任何素理想都不含 $1$，否则成为 $A$，但 $A$ 不是素理想
    == iii)
      $
      forall P in Spec(A):\
       P in V(union.big_(i in I) E_i) 
       &<=> union.big_(i in I) E_i subset P\
       &<=> forall i in I, E_i subset P\
       &<=> forall i in I, P in V(E_i)\
      $
    == iv)
      $
      forall P in Spec(A):\
        P in V(a sect b) 
        &<=> a sect b subset P\
        &<=> a subset P or b subset P\
        &<=> P in V(a) or P in V(b)\
        &<=> P in V(a) union V(b)
      $
      此外，注意到 $a b subset P <=> a subset P or b subset P$，因此同理可证 $V(a b) = V(a) union V(b)$
  = 17
    注意到任何开集均形如：
    $
    S = Spec(A) - V(E) = Spec(A) - V(union.big_(x in E) {x})\
    = Spec(A) - sect.big_(x in E) V(x)\
    = union.big_(x in E) (Spec(A) - V(x))\
    = union.big_(x in E) X_x
    $
    == i)
      $
      X_f sect X_g &= (Spec(A) - V(f)) sect (Spec(A) - V(g))\
      &= Spec(A) - (V(f) union V(g))\
      &= Spec(A) - V((f) sect (g))\
      &= Spec(A) - V((f g))\
      &= X_(f g)
      $
    == ii)
      $
      X_f = emptyset &<=> V(f) = Spec(A)\
      &<=> forall P in Spec(A), f in P \
      &<=> f "幂零"
      $
    == iii)
      $
      X_f = X &<=> V(f) = emptyset\
      &<=> forall P in Spec(A), f in.not P\
      &<=> f in U(A)
      $
      （注意到若 $f$ 不是单位，则 $(f)$ 扩充成的极大理想作为素理想包含 $f$，因此存在素理想包含 $f$）
    == iv)
      $
      X_f = X_g &<=> V(f) = V(g)\
      &<=> V(r(f)) = V(r(g))\
      $
      （运用 $V(alpha) = V(r(alpha))$
    == v), vi)
      直接证明 vi)\
      - 先证明一个引理：$V(a) subset V(b) <=> r(b) subset r(a)$\
        - 一方面，$r(b) subset r(a) => V(r(a)) = V(a) subset V(r(b)) = V(b) $
        - 另一方面：
          $
          V(a) subset V(b) => sect.big V(a) = r(a) supset sect.big V(b) = r(b) 
          $
      由于所有 $X_f$ 构成拓扑基，因此不妨设开覆盖是拓扑基构成的，也即：
      $
      &X_f subset union.big_(i in I) X_(g_i)\
      <=>& V(f) supset sect.big_(i in I) V(g_i)\
      <=>& V(f) supset V(sum_(i in I) (g_i))\
      <=>& f in r(sum_(i in I) (g_i)) "（由引理）"\
      <=>& exists k in NN^+, f^k in sum_(i in I) (g_i)
      $
      注意到最后一式中 $f^k$ 一定可以被 $g_i$ 中的有限个元素表示，因此倒推可得 $D(f)$ 有有限子覆盖
    == vii)
      - 一方面，伪紧集的有限并当然伪紧，因此 $X_f$ 的有限并伪紧
      - 另一方面，假设 $S$ 是伪紧开集，注意到 $X_f$ 构成一组拓扑基，可设：
        $
        S = union.big_(i in I) X_(f_i)
        $
        这也意味着上式右侧构成一组开覆盖，它将有有限子覆盖 $I' subset I$ 使得：
        $
        S subset union.big_(i in I') X_(f_i) subset X_(sum_(i in I) f_i) = S
        $
        因此上式中的不等号都取等，进而 $S$ 是有限个 $X_f$ 的并
  = 18
    == i)
      - 注意到若 ${x}$ 闭，则存在某个理想 $I$，$p_x$ 是唯一包含它的素理想\
        而 $I$ 扩充成的极大理想一定是包含 $I$ 的素理想，因此 $p_x$ 就是这个极大理想，也即 $x$ 是极大理想
      - 若 $p_x$ 是极大理想，则 $V(p_x) = {x}$ 是闭集
    == ii)
      显然 $V(p_x)$ 是闭集，只需证明最小性。\
      假设 ${x} subset V(a)$，往证 $V(p_x) subset V(a)$
      - 事实上：
        $
        {x} subset V(a) &=> x in V(a)\
        &=> a subset p_x\
        &=> V(a) supset V(p_x)
        $
        证毕
    == iii)
      $
      y in overline({x}) &<=> y in V(p_x)\
      &<=> p_y supset p_x\
      $
    == iv)
      注意到 $x in overline({y})$ 和 $y in overline({x})$ 不同时成立（否则 $x = y$）\
      不妨设 $x in.not overline({y})$，则 $overline({y})$ 是不含 $x$ 的 $y$ 闭邻域，取其补恰为不含 $y$ 的 $x$ 开邻域，证毕



