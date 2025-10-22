#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "代数学二习题课",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 前言
  - 习题课助教：潘翔宇
  - 邮箱：XiangyuPan\@stu.pku.edu.cn，两周习题课交一次作业
= 素谱，极大谱
  本门课前半学期着眼于交换代数，最初的目的是为了将代数几何严格化。
    #definition[环的（素）谱(prime spectrum)][
      设 $A$ 是一个环，$P$ 是 $A$ 的一个素理想（注意素理想一定是真理想）\
      称环的素谱为 $A$ 的素理想的集合，记作 $Spec(A)$
    ]
    #definition[零点集][
      设 $E$ 是 $A$ 的子集，称：
      $
      V(E) = {P in Spec(A) | E subset P}
      $
      为 $E$ 的零点集
    ]
    #remark[][
      这看似与零点毫无关系，但后续课程中会学到 $A$ 中的元素可以看作 $A$ 的素谱上的函数，而 $E$ 的零点集可以看作这些函数的零点集
    ]
    环的素谱是某种意义上多项式零点集的推广，其上具有良好的拓扑性质，我们的目标是模仿零点集给出谱上的拓扑。
    #proposition[][
      - $V(E) = V(I)$， 其中 $I$ 是 $E$ 的生成理想。这表明我们只需要考虑理想的零点集
      - $V(0) = Spec(A)$
      - $V(A) = V(1) = emptyset$
      - $inter.big_i V(I_i) = V(sum_i I_i)$
      - $V(I) union V(J) = V(I inter J) = V(I J)$
    ]
    #proof[
      - 注意到对任何素理想 $P, I subset P <=> E subset P$，结论显然
      - $0$ 当然包含与任何素理想
      - 任何素理想当然都不应该包含 $1$
      - 一方面
        $
        I_j subset sum_i I_i => V(sum_i I_i) subset V(I_j)
        $
        另一方面，假设素理想 $P$ 满足 $P in inter.big_i V(I_i)$，这就导出 $P supset I_i, forall i$，表明 $P supset sum_i I_i$
      - 首先 $I, J supset I inter J, I J$，因此 $V(I), V(J) subset I inter J, I J$。\
        - 往证 $V(I J) subset V(I) union V(J)$\
          注意到 $P$ 是素理想，因此 $P supset I J => P supset I or P supset J => P in V(I) union V(J)$
        - 类似的，把 $I inter J$ 替换 $I J$ 结论都是正确的
    ]
    注意到上面的命题实际上说明了：
    - $Spec(A), emptyset$ 是某个集合的零点集
    - 两个零点集的并，任意零点集的交仍是零点集
    这恰好就是拓扑的闭集公理，由此我们就定义谱上的拓扑。
    #theorem[][
      $Spec(A)$ 上的由所有形如 $V(I)$ 的集合作为闭集生成一个拓扑
    ]
    #example[][
      - 
        容易计算得
        $
        Spec(ZZ) = {(p) | p "is prime"}\
        V(n ZZ) = {(p) | p "is prime" and (p) supset (n)} = {(p) | p "is prime" and p | n}
        $
        不难发现，闭集恰为所有不含 $(0)$ 的有限集和全集。此时 ${(0)}$ 的闭包是全集，表明整数环的谱不是 $T_1$ 的。一般来说，只有很少的环满足 $T_1$ 或者 $T_2$
      - 域的谱都是平凡的，因为只有平凡的素理想
      - 考虑 $CC[x]$，这是 PID ，所有素理想都是素元的生成理想，而多项式是素元当切仅当它是一次多项式。因此 $Spec(CC[x]) = {(x - a) | a in CC} union {0}$，进而 $CC$ 中每个元素都对应着 $Spec(CC[x])$ 中的一个元素。\
        同时，$CC[x]$ 的零点集当然就是任意若干个 $CC$ 中元素，再次体现了零点集概念的合理性。\
        而：
        $
        V(f) = V(product_(i=1)^n x - a_i) = union.big_(i=1)^n {(x - a_i)} = {(x - a_i) | i = 1, 2, ..., n}
        $
        它的拓扑恰与余有限拓扑只相差一个零理想对应的单点集。这个事实对任何代数闭域都是成立的。
      - 考虑 $RR[x]$，它的素谱比代数闭的情形多出二次不可约多项式，因此：
        $
        Spec(RR[x]) = {(0)} union {(x - a) | a in RR} union {(x-z)(x-overline(z)) | z in CC, im(c) > 0}
        $
        拓扑是类似的。粗略来说，可以认为 $Spec(RR[x]) tilde.eq Spec(CC[x]) quo Gal(CC quo RR)$ 至少在拓扑上是成立的
    ]
    #definition[基本开集 (prime open set)][
      对任意 $f in A$，称形如：
      $
      D_f = Spec(A) - V(f) = {P in Spec(A) | f in.not P}
      $
      的集合为基本开集/主开集
    ]
    #proposition[][
      - $D(f) inter D(g) = D(f g)$
      - $D(f) = emptyset <=> f in sqrt(0)$
      - $D(f) = Spec(A) <=> f in U(A)$
      - $D(f) = D(g) <=> sqrt(f) = sqrt(g)$
    ]
    #proof[
      - $p in D(f) inter D(g) <=> f in.not p and g in.not p <=> f g in.not p$
      - 由幂零根的概念和性质可知
      - \
        - 一方面 $f in U(A) => V(f) = emptyset$
        - 另一方面，一个不可逆的元素应该包含于某个极大理想，而极大理想一定是素理想，因此成立
        - 首先我们证明：
          $
          inter.big_(P in V(I)) = sqrt(I)
          $
          这是因为由对应定义，$V(I)$ 中的元素与 $Spec(A quo I)$ 中元素可以产生一一对应 $phi$。同时，注意到：
          $
          Spec(A quo I) = inter.big_(p in V(I)) p quo I
          $
          用 $phi$ 作用于两侧立得结论
    ]
    #corollary[][
      所有基本开集构成一个拓扑基
    ]
    #proof[
      这是非常自然的，因为开集均形如：
      $
      Spec(A) - V(E) = Spec(A) -  (inter.big_(f in E) V(f)) = union.big_(f in E) D(f) 
      $
    ]
    #definition[拟紧(quasi-compact)][
      设 $X$ 是一个拓扑空间，称 $X$ 是拟紧的，如果 $X$ 的任意开覆盖都有有限子覆盖\
      （在拓扑学中这就是紧，布尔巴基学派习惯将其称为伪紧）
    ]
    #theorem[][
      每个 $D(f)$ 都是拟紧的，特别的 $Spec(A) = D(0)$ 拟紧
    ]
    #proof[
      由于所有 $D(f)$ 构成拓扑基，因此不妨设开覆盖是拓扑基构成的，也即：
      $
      &D(f) subset union.big_(i in I) D(g_i)\
      <=>& V(f) supset inter.big_(i in I) V(g_i)\
      <=>& V(f) supset V(sum_(i in I) (g_i))\
      <=>& f in sqrt(sum_(i in I) (g_i))\
      <=>& f^k in sum_(i in I) (g_i)
      $
      注意到最后一式中 $f^k$ 一定可以被 $g_i$ 中的有限个元素表示，因此倒推可得 $D(f)$ 有有限子覆盖
    ]
    #theorem[][
      任意开集拟紧当且仅当是有限个基本开集的并
    ]
    #proof[
      - 有限个拟紧集的并当然拟紧。
      - 若开集 $S$ 拟紧，由于基本开集是拓扑基：
        $
        S = union.big_(f in I) D(f)
        $
        而由 $S$ 拟紧，应当有上式右侧有限个即可覆盖 $S$，当然它们的并就是 $S$
    ]
    类似素谱，我们可以定义极大谱。它的大部分性质与素谱类似，但在根的处理上更加复杂
    #example[][
      设 $X$ 是紧的 Hausdorff 空间，$C(X)$ 是其上的连续实函数环。对 $forall x in X$
      $
        P_x = {f in C(X) | f(x) = 0}
      $
      $P_x$ 将是 $C(X)$ 的一个极大理想，因为它恰好是代入映射：
      $
      funcDef(phi, C(X), RR, f, f(x))
      $
      的 ker
    ]
    #theorem[][
      该拓扑是一个 $T_0$ 可分离空间，单点集 ${x}$ 是闭集当且仅当 $x$ 代表的素理想是极大理想
    ]
    #definition[][
      称一个拓扑空间是不可约的，如果它非空且
      - 不能写成两个真闭集的并
      - 任意两个非空开集的交非空
      - 每个非空开集都是稠密的
      （以上三者等价）
    ]
    #theorem[][
      - 若 $Y$ 不可约，则它的闭包也不可约
      - 每个不可约集包含一个最小的不可约子集，这个子集是闭的
      - $Spec(A)$ 的最小不可约子集形如 $V(p), p$ 是 $A$ 中的极小素理想
    ]
    #proof[
      - 任取 $overline(Y)$ 中非空开集 $U, V$，事实上就是 $X$ 中开集与 $overline(Y)$ 的交非空，而它们与 $Y$ 的交一定也非空，进而结论成立。
    ]
    #theorem[][
      $Spec(A)$ 是不可约的当且仅当 $A$ 的幂零根是素理想
    ]<irreducible-lemma0>
    #proof[
      - 设 $I$ 作为幂零根是素理想，设 $U, V$ 是两个非空开集。由于我们证明主开集是拓扑基，我们只需证明主开集都有交即可\
        注意到：
        $
        D_f = emptyset <=> f in sqrt(0) <=> f in I
        $
        因此对非空主开集 $D_f, D_g$，有 $f, g$ 不幂零，进而 $f g$ 也不幂零，因此 $D_f inter D_g = D_(f g)$ 非空
      - 另一侧的证明是类似的：
        $
        f, g in.not I => D_f, D_g != emptyset => D_f inter D_g != emptyset => D_(f g) != emptyset => f g in.not I
        $
    ]
    #theorem[][
      $V(I)$ 不可约当且仅当 $sqrt(I)$ 是素理想
    ]
    #definition[][
      设 $phi: A -> B$ 是环同态，它将诱导一个映射：
      $
      funcDef(phi^*, Spec(B), Spec(A), P, phi^(-1)(P))
      $
      （注意到素理想的原像是素理想）
      并且满足：
      - 主开集的原像是主开集，进而连续
      - $Inv(phi^*) (V(I)) = V(I B)$, $I$ 是 $A$ 的理想
      - $overline(phi^*(V(J))) = V(Inv(phi)(J))$
    ]
= Directed Limit | 正向极限
  所谓 Directed Limit 是 coLimit 的一种特殊情况
  #definition[Directed Set|正向集][
    设 $I$ 是一个指标集，称 $I$ 是有向的，如果 $I$ 上有偏序且 $forall i, j in I, exists k in I : i <= k and j <= k$
  ]
  #definition[Directed System][
    设 $A$ 是环，$A-$ 模上的 Directed System |正向系统是指一个指标集 $I$ 以及：
    - $phi: I -> A-"模"$
    - $forall i, j, i <= j, exists$ 同态 $mu_(i j): M_i -> M_j$
    - $mu_(i i)$ 是恒等变换
    - $mu_(i j) compose mu_(k i) = mu_(k j)$
  ]
  #let DLimit(t) = $lim_(arrow(#t))$
  #definition[Directed Limit|正向极限][
    给定 $I$ 是正向系统，称：
    $
    lim_(arrow(i in I)) M_i = plus.circle.big_(i in I) M_i quo generatedBy({x_i - mu_(i j) (x_i)| x_i subset M_i, i <= j})
    $
    为正向极限，并且给出典范的同态：
    $
    mu_i: M_i -> plus.circle.big_(i in I) M_i -> lim_(arrow(i in I)) M_i
    $
    显有 $mu_i = mu_j compose mu_(i j) forall j, i<= j$
  ]
    #example[][
    - 拓扑空间中某点的开邻域构成一个正向集（以反包含作为偏序），正向系统\
      设 $C(U)$ 是邻域 $U$ 上的连续函数，则称
      $
      lim_(arrow(U in N(x))) C(U)
      $
      为 $x$ 点处连续函数的芽

  ]
  #proposition[][
    - $forall x in DLimit(i in I) M_i, exists i in I, x_i in M_i: mu_i (x_i) = x$
    - $mu_i(x) = 0 <=> exists j >= i, mu_(i j)(x) = 0$
  ]
  #proof[
    - 将 $x$ 提升到直和上，设之为 $(x_i)_(i in I)$ \
      直和要求仅有有限个不为零处，不妨从小到大设为 $i_1, i_2, ..., i_k$\
      由于只有有限个元素，可以找到一个 $i$ 使得 $i_1, i_2, ..., i_k <= i$，进而:
      $
      x = sum_(j = 1)^k mu_(i_j)(x_(i_j)) = sum_(j = 1)^k mu_(i)(mu_(i_j i)(x_(i_j))) = mu_i (sum_(j = 1)^k mu_(i_j i)(x_(i_j)))
      $
      这就是原结论
    - 
      - $arrow.l.double$ 显然
      - $=>$ 由定义知 $x in generatedBy({x_i - mu_(i j) (x_i)| x_i subset M_i, i <= j})$\
        注意到生成子模也是直和，其中仅有有限个指标参与运算。不妨设指标集为 $J$，每个指标 $j$ 在生成元中对应元素为 $i(j)$，所有这些元素将有下界 $m$，进而：
        $
        x_i = sum_(j in J) (x_(i(j)) - mu_(i(j) j)(x_(i(j))))\
        mu_(i k)(x_i) = sum_(j in J) mu_(j k)(x_(i(j))) -mu_(j k) compose mu_(i(j) j)(x_(i(j))) = 0
        $
        最后一步是由相容性保证的，这就证明了原来的结论
  ]
  #theorem[][
    正向极限由泛性质唯一刻画，准确的说，设 $N$ 是 $A-$ 模，并且存在 $M_i -> N$ 的同态 $alpha_i$ 满足 $alpha_i = alpha_j compose mu_(i j)$，则存在唯一的同态：
    $
    alpha: DLimit(i in I)M_i -> N
    $
    满足 $alpha_i = alpha compose mu_i$

    同时，若存在 $A-$ 模满足这样的泛性质，则它与正向极限同构
  ]
  #example[][
    设 $M_i$ 是一族子模，定义 $i <= j <=> M_i subset M_j$\
    假设 $forall i , j in I, exists k : M_i + M_j subset M_k$\
    此时便有：
    $
    DLimit(i in I) M_i tilde.eq union.big_(i in I) M_i
    $
    只需要验证 $union.big_(i in I) M_i$ 也满足之前所述的泛性质即可
  ]
  #definition[正向系统的同态][
    设 $(M_i, mu_i), (N_i, nu_i)$ 是两个以 $I$ 为指标集的正向系统，称两个正向系统的同态是：
    - 一族同态 $phi_i: M_i -> N_i$
    - 相容性条件 $nu_(i j) compose phi_i = phi_i compose nu_(i j)$
    同时，在两个正向极限间将存在唯一的同态 $phi: M_i -> N_i$ 使得：
    $
    nu_i compose phi_i = phi compose mu_i
    $
    证明利用 $M_i$ 正向极限的泛性质即可
  ]
  #theorem[][
    设 $(M_i, mu_i), (N_i, nu_i), (P_i, alpha_i)$ 是三个正向系统，配合正向系统的同态：
    $
    phi_i : M_i -> N_i\
    psi_i : N_i -> P_i
    $
    且对于每个 $i, M_i -> N_i -> P_i$ 正合，则对应的正向极限的链也正合
  ]
= 仿射代数簇
  #definition[零点集][
    设 $k$ 是代数闭域，$S subset k[x_1, x_2, ..., x_n]$，称 $S$ 的零点集为：
    $
    Z(S) = {p in k^n|f(k) = 0, forall f in S}
    $
  ]
  #proposition[][
    - $S subset S' => Z(S') subset Z(S)$
    - $Z(S) = Z(I(S)) = Z(sqrt(I))$
    - $Z(0) = k^n, Z(k[x_1, x_2, ..., x_n]) = emptyset$
    - $Z(I) union Z(J) = Z(I inter J) = Z(I J)$
    - $sect_(n in N)Z(I_n) = Z(sum_(n in N)Z(I_n))$
    进而 $Z$ 也给出一个拓扑，若取 $k = CC$，则这个拓扑将是欧式拓扑的子拓扑
  ]
  #definition[理想|Ideal][
    设 $Y subset k^n$，称 $Y$ 的理想为：
    $
    I(Y) = {f in k[x_1, x_2, ..., x_n]|f(p) = 0, forall p in Y}
    $
    它确实是 $k[x_1, x_2, ..., x_n]$ 的理想
  ]
  #theorem[希尔伯特零点定理 1][
    $
    I(Z(J)) = sqrt(J)
    $
  ]<Hilbert-Nullstellensatz1>
  #proof[
    它的证明非常复杂，留在后面
  ]
  #proposition[][
    - $Y subset Y' => I(Y') subset I(Y)$
    - $I(Y union Z) = I(Y) inter I(Z)$
    - $Z(I(Y)) = overline(Y)$
  ]
  #proof[
    - 显然
    - 显然
    - 显然有 $Y subset Z(I(Y))$，设 $W = Z(J) supset Y$ 是闭集，则：
      $
      Y subset Z(J) => J subset I(Z(J)) subset I(Y) => Z(J) supset Z(I(Y))
      $
  ]
  #theorem[希尔伯特零点定理 2][
    $Z, I$ 在 $k[x_1, x_2, ..., x_n]$ 的根理想与 $k^n$ 的零点集之间给出了反序的一一对应，且：
    - 素理想恰与不可约的闭集一一对应
    - 极大理想恰与 $A^n$ 中的点一一对应，换言之极大理想均形如 $(x_1 - a_1, x_2 - a_2, ..., x_n - a_n)$ 这有时也被称作弱零点定理\
      可以验证这个子映射给出了多项式环极大谱与 $A^n$ 的拓扑空间同胚
  ]
  #proof[
    设 $J$ 是根理想，则由@Hilbert-Nullstellensatz1：
    $
    I(Z(J)) = sqrt(J) = J
    $
    设 $Y$ 是闭集：
    $
    Z(I(Y)) = overline(Y) = Y
    $
    - 类似@irreducible-lemma0，假设 $Y$ 是两个闭集 $Z(A) inter Y, Z(B) inter Y$ 的并，也即：
      $
      Y subset Z(A) union Z(B) = Z(A inter B)\
      I(Y) supset I(Z(A inter B)) = sqrt(A inter B) = sqrt(A) inter sqrt(B) 
      $
      - 假设 $I(Y)$ 是素理想，则 $sqrt(A) inter sqrt(B) subset p$ 给出 $sqrt(A) subset p$ 或 $sqrt(B) subset p$，倒退即得两个闭集有一个为空，进而不可约
      - 假设不可约，任取 $x, y in.not I(Y)$，若 $(x y) subset I(Y)$ 则：
        $
        sqrt(x) inter sqrt(y) = sqrt(x y) subset sqrt(I(Y)) => Z(x) union Z(y) = Z(sqrt(x) inter sqrt(y)) supset Z(sqrt(I(Y))) = Y
        $
        只需证明 $Z(x) inter Y, Z(y) inter Y$ 非空，事实上：
        $
        x in.not I(Y) <=> Z(I(Y)) = Y subset.not Z(x) 
        $
        同理有 $Y subset.not Z(y)$，因此当然有 $Z(x) inter Y, Z(y) inter Y$ 非空
    - 由反序性，极大理想当然与单点集一一对应
  ]
  #corollary[][
    - $k^n$ 是不可约的，因为它对应的理想 $(0)$ 在整环中是素理想
    - 设 $f in k[x, y]$ 不可约，则 $(f)$ 是素理想，说明 $Z(f)$ 不可约
  ]
  #definition[仿射代数簇|affine algebraic variety][
    设 $k$ 是代数闭域，称 $Y subset k^n$ 是仿射代数簇，如果 $Y = Z(I)$，其中 $I$ 是 $k[x_1, x_2, ..., x_n]$ 的素理想
  ]
  #definition[诺特空间|Noetherian Space][
    称拓扑空间是诺特空间，如果：
    - 闭集的降链最终稳定
    - 开集的升链最终稳定
  ]
  #proposition[][
    - 诺特环的素谱/极大谱都是诺特空间
    - 反之未必，存在不诺特的环使得素理想只有 $(0)$ 和唯一的极大理想，它的素谱，极大谱都是诺特空间
  ]