#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为3月27日）
#let dirSum = $plus.circle$
= 
  取 $phi: M -> Inv(S) M$
  - 显然若 $exists s in S$ 使得 $s M = 0$，则 $0 = phi(s M) = phi(s) phi(M)$\
    但 $phi(s)$ 是可逆元，因此 $phi(M) = 0 <=> Inv(S) M = 0$
  - 反之若 $phi(M) = 0 <=> Inv(S) M = 0$，设 $x_i$ 是有限个生成元，则应有：
    $
    phi(x_i) = 0 => exists s_i, s_i x_i = 0
    $
    从而容易验证：
    $
    (product_(i) s_i) x_k = 0, forall k\
    => (product_(i) s_i) M = 0
    $
    这就找到了 $s := (product_(i) s_i) in S$ 符合条件
=
  - 首先验证 $S$ 是乘性子群，$1 in S$ 显然，而：
    $
    (1 + a)(1 + b) = 1 + (a + b + a b) in S
    $
  - 为了验证 $Inv(S) alpha subset Re_j$，只需任取 $a/(1 + b) in Inv(S) alpha, a, b in alpha$，验证：
    $
    forall a', b' in alpha, 1 + a/(1 + b) a'/(1 + b') = (1 + b + b' + b b' + a a')/(1 + b + b' + b b') in U(Inv(S) A)
    $
    既然 $1 + b + b' + b b' + a a' in S$ ，这是显然的

    对于第二个命题，设 $M$ 有限生成，$alpha M = M$，取 $S = 1 + alpha $，则：
    $
    Inv(S) M = Inv(S) (alpha M) = (Inv(S) alpha)(Inv(S) M)
    $
    同时，该题证明了 $Inv(S) alpha subset Re_j (Inv(S) M)$，Nakayama 将给出 $Inv(S) M = 0$，由习题一，这意味着：
    $
    exists a in alpha, (1 + a) M = 0
    $
    这当然就是结论
= 
  由局部化的泛性质，有：
  #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $B$, 2),
      node((1, 0), $Inv(S) A$, 3),
      arr(1, 2, $"with" &f(S) subset U(B) \ &f$),
      arr(3, 2, $exists ! f'$),
      arr(1, 3, $pi_1$),)]
  #align(center)[#commutative-diagram(
      node((0, 0), $Inv(S) A$, 1),
      node((0, 1), $C$, 2),
      node((1, 0), $Inv(U) (Inv(S) A)$, 3),
      arr(1, 2, $"with" &g(U) subset U(C) \ &g$),
      arr(3, 2, $exists ! g'$),
      arr(1, 3, $pi_2$),)]
  我们希望证明：
  #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $B$, 2),
      node((1, 0), $Inv(S) A$, 3),
      node((2, 0), $Inv(U) (Inv(S) A)$, 4),
      arr(1, 2, $"with" &h(S T) subset U(B) \ &h$),
      arr(3, 2, $exists_1 ! h'$),
      arr(1, 3, $pi_1$, label-pos: right),
      arr(3, 4, $pi_2$, label-pos: right),
      arr(4, 2, $exists_2 ! h''$, label-pos: right),
      
      
      )]
  进而 $Inv(U) (Inv(S) A)$ 与 $Inv((S T))A$ 具有相同的泛性质，进而同构\
   - 首先需要说明 $(pi_2 compose pi_1)(S T) subset U(Inv(U) (Inv(S) A))$，事实上：
    $
    (pi_2 compose pi_1)(S T) = pi_2 (pi_1 (S)) * pi_2 (pi_1 (T)) \
    subset pi_2 (U (Inv(S) A)) * pi_2 (U)\
    subset U(Inv(U) (Inv(S) A)) * U (Inv(U) (Inv(S) A))\
    = U(Inv(U) (Inv(S) A))
    $
  - 其次
    - 注意到 $S subset S T$，通过第一个图表可以将 $h$ 提升至 $h'$
    - 注意到：
      $
      h'(U) = h'(pi_1 (T)) = h(T) subset h(S T) subset U(B)
      $
      因此可以利用交换图表再次提升至 $h''$
    这保证了 $h''$ 的存在性
  - 最后验证该位置的 $h''$ 是唯一的，事实上，假设有两个 $phi'', psi''$ 都可以在 $h''$ 的位置上使得（不含 $h'$ 的）交换图表成立，则令：
    $
    phi' = phi'' compose pi_2, psi' = psi'' compose pi_2
    $
    此时 $phi', psi'$ 都可以在 $h'$ 的位置使交换图表成立，由第一个图表的唯一性知（刚才已经验证了使用条件成立）：
    $
    phi' = psi'
    $
    再由第二个图表的唯一性即可得到：
    $
    phi'' = psi''
    $
    证毕
=
  容易验证 $T$ 是 $B$ 的乘性子集，定义：
  $
  funcDef(phi, Inv(S) B, Inv(T) B, b/s, b/f(s))
  $
  - 首先验证良定义性，若 $b/s = b'/s'$，则：
    $
    exists s_0 in S, f(s_0)(b f(s') - b' f(s)) => exists t := f(s_0) in T, t(b f(s') - b' f(s)) = 0\
    = > b/ f(s) = b'/ f(s') 
    $
  - 同态性是容易验证的
  - 由 $f(S) = T$，容易看出它是满射
  - 若 $b/f(s) = 0$，则：
    $
    exists f(s_1) in T, f(s_1) b = 0\
    => exists s_1 in S, s_1 b = f(s_1) b = 0\
    => b/s = 0
    $
    因此它是单射
  证毕
= 
  假设 $A$ 有幂零元 $a$，任取素理想 $p$ 及 $phi_p : A -> A_p$，将有 $phi_p (a)$ 幂零，继而 $phi_p (a) = 0$\
  换言之，将有 $(a)_p = 0, forall p in Spec(A)$，这导出 $(a) = 0 => a = 0$，证毕

  第二个结论未必成立，考虑 $A = Z_6$，它显然不是整环，其中恰有两个素理想 $p_2 = (2), p_3 = (3)$，而 $A_(p_2), A_(p_3)$ 是域，例如取 $pi: A -> A_(p_2)$，我们发现：
  $
  pi(2 dot 3) = pi(2) dot pi(3) = 0
  $
  然而 $pi(3)$ 是可逆元，进而 $pi(2) = 0 => pi(p_2) = 0$\
  然而 $pi(p_2)$ 应当是唯一的极大理想，这表明 $A_(p_2)$ 是域。另一个是类似的
= 
  利用 Zoun 引理，在集合的包含关系下，设 $I$ 是 $Sigma$ 的全序子集，断言：
  $
  union I in Sigma
  $
  进而成为该全序子集的上界
  - 首先，由于 $1 in i, 0 in.not i, forall i in I$，因此 $1 in union I, 0 in.not union I$
  - 其次，任取 $a, b in union I$，则存在 $i, j in I$ 使得 $a in i, b in j$，不妨设 $i subset j$，则 $a, b in j$，进而 $a b in j subset union I$，因此 $union I$ 对乘法封闭
  证毕

  对于第二个事实，先证明：
  #lemmaLinear[][
    $S$ 是极大元当且仅当 $Inv(S) A$ 的幂零根是唯一的素理想
  ]
  #proof[
    //等价于说明 $forall a in A - S, exists s in S, n >= 0, s a^n = 0$\
    取 $pi: A -> Inv(S) A$,
    注意到任取 $a in A$
    $
      union_(n >=0) a^n S
    $
    是最小的包含 $S, a$ 的乘性子集
    - 若 $S$ 极大，必有 $a in S$ 或 $exists n in NN, s in S, s a^n = 0 => pi(a^n) = 0$，这表明 $pi(A - S)$ 中元素都是幂零元。然而 $Inv(S) A$ 中不可逆的元素均形如 $pi(a)/s, a in A - S, s in S$，这也是幂零元，进而其中不可逆元素都幂零，自然所有的理想都含于幂零根，因此幂零根是唯一的素理想
    - 反之，设 $a in A - S$，$pi(a)$ 当然可以生成一个极大理想（同时也是素理想），由题设这就是幂零根，进而 $pi(a)$ 是幂零元，也即 $0 in union_(n >=0) a^n S$\
      由 $a$ 的任意性知 $S$ 中不能添加任何元素，从而极大

  ]
  - 设 $S$ 是一个极大元，引理的证明过程给出 $A - S = Inv(pi)(Re)$ 是素理想，极小性由 $Spec(Inv(S) A)$ 与 $A$ 中与 $S$ 不交的素理想（等价的，含于 $A-S$ 的素理想）一一对应给出
  - 假设 $p$ 是极小的素理想，由上述一一对应 $A_p = Inv((A - p)) A$ 只有一个素理想，当然就是幂零根，由引理知 $A - p$ 是极大元
= 
  == 
    - 假设 $A - S = union.big_(i in I) p_i$，其中 $p_i$ 是素理想，则设 $x in A - S$，将存在 $p_i$ 使得 $x in p_i$，进而：
      $
      forall y in A, x y in p_i subset A - S
      $
      表明 $S$ 是饱和的
    - 反之若 $S$ 饱和
      - 假设 $0 in S$，则容易看出 $forall a in A, 0 a in S => a in S$，此时 $S$ 是整个环，结论正确
      - 假设 $1 in.not S$，则容易看出 $forall s in S, 1 S in S => 1 in S$ 表明 $S$ 是空集，结论正确。
      - 否则，我们证明任取 $x in A - S$，存在 $p_x subset A - S$ 是包含 $x$ 的素理想，为此，取 $pi: A -> Inv(S) A$，断言 $pi(x)$ 不可逆，否则：
        $
        exists s in S, (x - 1)s = 0 => s x = s in S => x in s
        $
        矛盾\
        因此，可以在 $Inv(S) A$ 中取得包含 $pi(x)$ 的极大理想，不妨设为 $p (Inv(S) A)$，则 $p subset A - S$ 且 $x in p$，这就证明了断言\
        从而 $A - S = union.big(x in A - S) p_x$，证毕
      // 设：
      //   $
      //   Sigma = {i "is ideal"| x in i, i subset A - S}
      //   $
      //   - $Sigma$ 非空，因为 $x in.not S => (x) subset A - S$
      //   - 任取全序子集 $I$，显然 $union I$ 仍是理想并且含于 $A - S$，因此成为 $Sigma$ 中的上界
      //   由 Zoun 引理将存在一个极大元 $p$，我们证明它是素理想。\
      //   首先由于 $1 in S$ 知 $p$ 不是整个环\
        // 反设 $a, b in.not p$，验证 $a b in.not p$，不妨设 $a b in.not S$\
        // 由极大性，有：
        // $
        // p + (a) inter S != emptyset => exists h in A, x in p, h a + x in S\
        // p + (b) inter S != emptyset => exists g in A, y in p, g b + y in S
        // $
  ==
    取 $D = {p in Spec(A)|p subset A - S}$
    - 一方面，$union D subset A - S => S subset A - union D$，而由之前的结论 $A - union D$ 是一个饱和的乘性子集
    - 另一方面，假设 $S' supset S$ 是饱和的乘性子集，则：
      $
      A - S' = union {p in Spec(A)|p subset A - S'} \
      &{p in Spec(A)|p subset A - S'} subset D  \
      &=> A - S' = union {p in Spec(A)|p subset A - S'} subset union D \
      &=> A - union D subset S'
      $
      表明了 $A - union D$ 的极小性

    设 $p$ 是素理想，则：
    $
    p inter 1 + alpha != emptyset\
    <=> exists x in p, y in alpha, x = 1 + y\
    <=> exists x in p, y in alpha, 1 = x + y\
    <=> p + alpha = A\
    $
    因此 $D$ 恰好是所有与 $alpha$ 不互素的素理想
=
  == i) $=>$ ii)
    同构当然将单位映回单位
  == ii) $=>$ iii)
    由定义：
    $
    t / 1 in U(Inv(S) A) => exists s in S, s(t - 1) = 0 &=> s t = s in S\
    $
    取 $x = S$ 即可
  == iii) $=>$ iv)
    取 $S$ 的饱和化为 $overline(S)$，有：
    $
    &forall t in T, exists x in A, x t in S subset overline(S) \
    &=> forall t in T, exists x in A, x in overline(S) and t in S\
    &=> T subset overline(S)
    $
  == iv) $=>$ v)
    若 $p subset A - S$，则 $p subset A - overline(S) = A - overline(T) => p subset A - T$
  == v) $=>$ ii)
    设 $phi: A -> Inv(S) A$，任取 $t in T$，注意到任取 $Inv(S) A$ 的素理想 $p$，有：
    $
    phi(t) in p => t in Inv(phi)(p) => Inv(phi)(p) inter S != emptyset 
    $
    这是荒谬的，因此 $phi(t)$ 不在任何素理想之中，进而可逆
  == ii) $=>$ i)
    令 $pi: A -> Inv(S) A, pi': A -> Inv(T) A$
    条件给出：
    $
    phi(T) subset U(Inv(S) A)
    $
    由 $Inv(T) A$ 的泛性质，存在唯一 $phi': Inv(T) A -> Inv(S) A$ 使得：
    $
    phi' pi' = pi
    $
    再由定义知：
    $
    phi.alt  pi = pi'
    $
    进而： 
    $
    phi.alt phi' pi'= pi'\
    (phi' + id - phi.alt phi') pi' = pi
    $
    由唯一性知 $id = phi.alt phi'$，另一侧类似，故 $phi.alt, phi'$ 互为逆映射，证毕
=
  习题 6 的引理表明，设 $p$ 是极小的素理想，则 $A-p$ 将满足：
  $
  forall a in p,exists n in NN, s in A-p, a^n s = 0
  $
  表明 $p$ 中所有元素都是零因子，从而 $p subset D$
  == i)
    任取乘性子集 $S$ 使得 $phi: A -> Inv(S) A$ 是单射，从而：
    $
    forall s in S, a in A, s a != 0
    $
    表明 $S$ 中所有元素都不是零因子，从而 $S subset S_0$
  == ii)
    取 $phi: A -> Inv(S_0) A$，不难发现 $phi(S_0)$ 都是单位而 $phi(A - S_0)$ 都是零因子，从而 $Inv(S) A$ 中只有单位或零因子
  == iii)
    利用上一个习题的 v)，取 $S = {1}, T = S_0$，显然没有任何素理想包含 $1$，也没有任何素理想包含 $S_0$（既然其中都是单位），因此由上一题结论立得 $A tilde.eq Inv(S_0) A$
    



