#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
= 赋值环|Valuation ring
  == 全序阿贝尔群
    #definition[][
      称一个阿贝尔群全序，如果其上有全序且满足：
      $
      r <= r' => a r <= a r'
      $
      两个全序阿贝尔群之间的同态是保持序关系的群同态
    ]
    #example[][
      - $RR^+$ 在乘法和通常的序下当然是全序的
      - $RR$ 在加法和通常的序下当然是全序的。事实上通过取指数/对数，它与上面的群同构
    ]
    #definition[][
      设 $P$ 是全序阿贝尔群，$Q subset P$ 是子群，称 $Q$ 是凸的，如果以下等价条件成立对所有 $delta, delta', gamma in P$ 成立：
      - $delta <= gamma <= 1 and delta in Q => gamma in Q$
      - $delta, gamma <= 1, delta gamma in Q => delta, gamma in Q$
      - $delta <= gamma <= delta', delta, delta' in Q => gamma in Q$
    ]
    #proof[
      - 1 $=>$ 2 注意到 $delta gamma <= delta, gamma <= 1$，由 1 结论成立
      - 2 $=>$ 1 注意到 $gamma <=1, delta <= gamma => delta Inv(gamma) <= 1$，由 2 结论成立
      - 3 $=>$ 1 显然
      - 1 $=>$ 3 将有：
        $
        delta Inv(delta') <= gamma Inv(delta') <= 1 => gamma Inv(delta') in Q => gamma in Q
        $
    ]
    #definition[][
      设 $P$ 是全序阿贝尔群，定义 $ht(P)$ 为 $P$ 的除 ${1}$ 外的凸子集的个数，显然 $ht(P) >= 0$ 可能为 $infinity$
    ]
    #example[][
      - $ht(RR^+) = ht(RR) = 1$
      - 任取 $H subset P$，存在一个最小的包含 $H$ 中的凸子集：
        $
        {gamma in P| exists x, y in H, x <= gamma <= y}
        $
    ]
    #proposition[][
      - 设 $H_1, H_2$ 是两个凸子群，则必有 $H_1 subset H_2$ 或 $H_2 subset H_1$
      - 设 $phi: P -> Q$ 是全序阿贝尔群之间的同态，则 $ker phi$ 是凸子集
      - 设 $H$ 是凸子群，则商群 $P quo H$ 上也有全序结构，定义为 #TODO，并有 $ht(P) = ht(P quo H) + ht(H)$
      - $ht(P) = 0 <=> P = {1}$
    ]
    #proof[
      - 否则，设 $x in H_1 - H_2, y in H_2 - H_1$，不妨设 $x, y < 1$（否则取逆）以及 $x < y < 1$\
        然而第二式已经给出 $x, 1 in H_1$ 进而 $y in H_1$，矛盾！
    ]
    #proposition[][
      设 $P != [1]$ 是全序阿贝尔群，以下条件等价：
      - $ht(P) = 1$
      - $P$ 可以嵌入 $RR^+$（或 $RR$ 加法群）
      - $P$ 是阿基米德的，也即 $forall x < 1, y < 1 in P$ 均存在 $m$ 使得 $x^m < y$
    ]
    #proof[
      本门课程不会用到这些事实，不作证明
    ]
  == 赋值、赋值谱
    #definition[][
      设 $A$ 是环，$P$ 是全序阿贝尔群，称一个赋值是映射：
      $
      abs(dot): A -> P union {0}
      $
      并且满足：
      - $abs(a + b) <= max(abs(a), abs(b))$
      - $abs(a b) = abs(a) abs(b)$
      - $abs(0) = 0, abs(1) = 1$
      若 $A$ 是拓扑环（加法和乘法都连续且兼容），则称赋值是连续赋值，如果任意 $x in P$，都有：
      $
      {abs(a) < x} "是开集"
      $
    ]
    #definition[][
      称两个赋值等价，如果存在交换图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $P$, 2),
      node((1, 0), $P'$, 3),
      arr(1, 2, $$),
      arr(3, 2, $$, bij_str),
      arr(1, 3, $$),)]
    ]
    #proposition[][
      设 $k$ 是域，则其上的赋值等价于一个群同态 $k^times -> P$ 结合 $v(0) = infinity$
    ]
    #example[平凡赋值][
      对于任意环 $A$ 和其中素理想 $p$ ，给出一个平凡赋值：
        $
        abs(a) = cases(
          0 quad a in p,
          1 quad a in.not p
        )
        $
    ]
    #definition[赋值谱|valuation spectrum][
      设 $A$ 是环，定义其赋值谱 $Spv(A)$ 为所有赋值的等价类的集合。进一步，可以定义其上的闭集族为：
      $
      Spv(A)(f/s) := {v i Spv(A) | abs(f)_v <= abs(s)_v != 0}
      $
      构成拓扑空间
    ]
    #proposition[][
      任给环同态 $phi: A -> B$，诱导映射 $abs(dot): Spv(B) -> abs(dot) compose phi: Spv(A)$，它是连续映射
    ]
    #remark[][
      平凡赋值给出 $Spec(A) -> Spv(A)$ 的映射，而 $ker$ 给出 $Spv(A) -> Spec(A)$ 的映射，满足：
      #align(center)[#commutative-diagram(
      node((0, 0), $Spec(A)$, 1),
      node((0, 1), $Spv(A)$, 2),
      node((1, 0), $Spec(A)$, 3),
      arr(1, 2, $$, inj_str),
      arr(2, 3, $$),
      arr(1, 3, $$),)]
    ]
    #example[p-adic][
      - $QQ$ 上的赋值一定是某个素数 $p$ 产生的平坦赋值，称为 $p-$进赋值，换言之：
        $
        Spv(QQ) = Spec(ZZ)
        $
      - $QQ$ 上的赋值可以限制到 $ZZ$ 上，更进一步：
        $
        Spv(ZZ) = Spv(QQ) union {abs(dot)_(0, p), p "is prime"}
        $
        其中后者是 $F_p$ 上的平凡赋值
    ]
  == 赋值环
    #definition[dominate][
      设 $A subset B$ 是局部环，极大理想分别为 $m, n$，若 $n sect A = m$ 则称 $B$ 支配 $A$
    ]
    #definition[valuation ring][
      设 $A$ 是整环，$k$ 是分式域，称 $A$ 是 $k$ 的赋值环，如果以下等价条件成立：
      + $forall x in k, x in B or Inv(x) in B$
      + 存在全序阿贝尔群 $(Gamma, +)$ 和满同态 $nu: k^* -> Gamma$，并且满足：
        $
        nu(x + y) >= min(nu(x), nu(y))\
        nu(x y) = nu(x) + nu(y)
        $
        并且 $B = {x in k | nu(x) >= 0}$
        此时，称 $v$ 是 $B$ 的一个（加性）赋值
      + $A$ 的主理想在包含关系下构成全序集
      + $A$ 的所有理想在包含关系下构成全序集
      + $A$ 是局部环并且每个有限生成理想是主理想
      + $A$ 是局部环且不存在 $k$ 中的局部环支配 $B$
      + 存在代数闭域 $L$ 以及同态 $theta: A -> L$（一般不是单射），并且 $A, theta$ 是极大的，也就是若 $A subset A' subset k, theta': A' -> L$ 是 $theta$ 的延拓，则 $A = A'$
    ]<valuation-ring-cond>
    #proof[
      - 1 $=>$ 2 取 $Gamma = k^* quo B^*$，$nu$ 是自然映射，只需给出序结构。对于 $gamma, gamma' in Gamma$，有：
        $
        gamma <= gamma' <=> gamma - gamma' in im(B - {0} -> Gamma)
        $
        #TODO
      - 2 $=>$ 1 显然
      - 1 $=>$ 3\
        断言 $A$ 的主理想与 $(B - {0}) quo B^*$ 有一一对应\
        #TODO
        2 的结论就给出其上的全序关系
      - 4 $=>$ 3 显然
      - 3 $=>$ 4 任取两个理想 $I_1, I_2$ ，设 $I_1 subset.not I_2$ ，往证 $I_2 subset I_1$\
        任取 $a in I - J, b in J$，$a in.not J => (a) subset.not (b) subset J$，而由主理想的全序性必有 $(b) subset (a) subset I => b in I$，证毕
      - 4 $=>$ 5 由理想的全序性，两个极大理想必然可比，当然只能有唯一一个极大理想。同时，设 $I = (x_1, x_2, ..., x_n)$ ，此时 $(x_1)$ 与 $(x_2, x_3, ..., x_n)$ 相互包含，因此可以去掉一个生成元，以此类推可以只剩下一个生成元，进而是主理想
      - 5 $=>$ 1 设 $a, b in k != 0$, 往证 $a / b in A or b / a in A$\
        设 $I = (a, b)$ 由条件它是主理想，因此 $I quo m I$ 是一维的线性空间，进而：
        $
        exists u, v in A, (u + m I) a + (v + m I) b = m I => u a + v b in m I
        $
        其中 $u, v$ 不全在 $m I$ 之中，继而可设：
        $
        exists x, y in m, u a + v b = x a + y b=> (u - x) a = (y - v) b
        $
        无妨设 $u in.not m$ ，然而局部环表明 $u$ 是单位。同时 $x in m$，因此 $u - x$ 不在 $m$ 中，也是单位，进而 $a = k b, k in A$ ，证毕
      - 1 $=>$ 6 假设 $A'$ 是局部环，且 $A subset.neq A'$，往证 $A'$ 不支配 $A$，也就是存在 $A$ 中极大理想中的元素，在 $A'$ 中是单位（进而 $m_A subset.not m_(A') sect A$） \
        取 $x in A' - A$，由条件 $Inv(x) in A subset A'$ ，因此 $x$ 在 $A'$ 中一定是单位\
        此时，$Inv(x)$ 当然不是 $A$ 中的单位，但在 $A'$ 中是单位，证毕。
      - 6 $=>$ 7 设 $K = A quo m$ 是留域，取 $L$ 是 $K$ 的代数闭包，$theta: A -> A quo m -> L$\
        假设存在延拓 $A subset A' subset k, theta': A' -> L, theta'|_A = theta$\
        显然，$ker theta = m$，设 $m' = ker(theta')$，则 $A'$ 可以嵌入 $A'_m'$ （注意到 $A'$ 是域的子环，当然是整环），此时只需证明 $A = A'_(m')$ 因此不妨设 $A'$ 是局部环，$m'$ 是极大理想\
        显然，此时 $m = ker theta = ker theta' sect A = m' sect A$，利用条件 6 知结论成立
      - 7 $=>$ 1 这步较为困难，需要建立若干个引理，之后会证明
    ]
    #example[][
      - 满足 $dim = 1$ 的赋值环只有两种：离散赋值环（赋值在 $ZZ$ 上的赋值，一定是 Noether 的）和非离散的
      - 设 $v: k(x, y) -> ZZ^2$ 并使用 $ZZ^2$ 上字典序，也即 $v(x) = (1, 0), v(y) = (0, 1)$\
        此时 ${x | v(x) >= 0}$ 是赋值环
      - 设 $k[x] subset k[x^(1/2)] subset ... subset k[x^(1/n)] subset ..$\
        $
        O_n = k[x^(1/2^n)]_(p_n) where p_n = (x^(1/2^n))
        $
        可以验证：
        $
        O_n subset O_(n+1), p_(n+1) sect O_n = p_n
        $
        设 $O = union_n O_n$ ，此时 $O$ 是非 Noether 的赋值环，赋值群是
        $
        {z/(2^n) | z in NN, n in NN}
        $
        的子群
    ]
    #proposition[][
      设 $B$ 是赋值环，$k$ 是分式域，则：
      - $B$ 是局部环
      - 设 $B'$ 是环使得 $B subset B' subset k$，则 $B'$ 也是赋值环
      - $B$ （在 $k$ 中）整闭
      - 设 $p$ 是 $B$ 的素理想，则 $B quo p, B_p$ 在各自的分式域都是赋值环
    ]<valuation-ring-prop>
    #proof[
      - 之前已经证明，但是我们换一种方法再次证明。设 $m$ 是 $B$ 中所有非单位元，显然只需证明 $m$ 是理想。\
        - 假设 $a in B, x in m$，若 $a x in.not m$，则 $Inv((a x)) in B => Inv(x) = a Inv((a x)) in B$ 矛盾！
        - 假设 $x, y != 0 in m$ ，由定义 $x Inv(y) in B$ 或 $y Inv(x) in B$ ，不妨设前者成立，则：
          $
          x + y = y (1 + Inv(y) x) 
          $
          显然若 $x + y$ 可逆，则 $y$ 也可逆，矛盾！
      - 设 $x in k$，显然：
        $
        x in B => x in B'\
        Inv(x) in B => Inv(x) in B'\
        $
        至少有一个成立，因此 $B'$ 当然也是赋值环
      - 设 $x in k$ 在 $B$ 上整，设 $f(x) = 0$，也即：
        $
        x^(n) + a_1 x^(n-1) + ... + a_n = 0\
        x + a_1 + ... + a_n x^(-(n-1)) = 0\
        x = -a_1 - ... - a_n x^(-(n-1))\
        $
        注意到若 $x in.not B$ 必有 $Inv(x) in B$，然而上式右侧全部是 $B$ 中元素，进而 $x$ 也是，矛盾！
      - 简单验证即可 #TODO
    ]
    #theorem[赋值环的构造][
      设 $k$ 是任意一个域，$Omega$ 是代数闭域，令：
      $
      Sigma = {(A, f) | A subset k "是子环", f in Hom(A, Omega)}
      $
      定义偏序关系：
      $
      (A, f) <= (A', f') <=> "存在交换图表："
      $
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $A'$, 2),
      node((1, 0), $Omega$, 3),
      arr(1, 2, $$, inj_str),
      arr(2, 3, $f'$),
      arr(1, 3, $f$),)]
      则 $Sigma$ 非空且有极大元 $(A, f)$，且其极大元是赋值环，$ker f$ 是唯一的极大理想
    ]<extension-of-valuation>
    #proof[
      首先，$Sigma$ 非空（可以取 $(0, 0)$），且满足 Zoun 引理条件，进而存在极大元\
      设 $B$ 是一个极大元
      #lemmaLinear[][
         $B$ 是局部环，且 $m = ker(f)$ 是极大理想
      ]
      #proof[
        设 $m =  ker(f)$，可以局部化得到 $B_m$，同时注意到：
        $
        f(B - m) subset U(Omega)
        $
        当然 $f$ 可以延拓到 $B_m$ 上，而由极大性得 $B_m = B$，证毕
      ]
      #lemmaLinear[][
        任取 $x in k - {0}, B[x] subset k, m[x] := m B[x]$ ，则以下两者至少有一个成立：
        - $m[x] subset.not B[x]$
        - $m[Inv(x)] subset.not B[Inv(x)]$
      ]
      #proof[
        如若不然，则两者同时成立，则由 $1 in B[x], B[Inv(x)]$ 得：
        $
        1 = sum_(i=0)^n u_i x^i, u_i in m\
        1 = sum_(i=0)^m v_i x^(-i), v_i in m
        $
        不妨设 $m, n$ 各自最小且 $m >= n$，此时二式给出：
        $
        (1 - v_n) x^n = v_1 x^(n-1) +... + v_(n-1) x + v_n
        $
        注意到 $1-v_n$ 是单位，上式可以化成首一的多项式，进而和一式做带余除法将降低次数，与 $m, n$ 的极小性矛盾！
      ]
      回到定理的证明，往证 $x in B or Inv(x) in B$，由上面的引理不妨设 $m[x] != B[x] := B'$，则存在 $B'$ 的极大理想 $m'$ 使得 $m[x] subset m'$\
      另一方面，我们证明 $f: B -> Omega$ 可以延拓到 $B' = B[x]$ 上即可\
      首先，显然有 $m' sect B = m$（既然 $m subset m' sect B$ 而 $m$ 是极大理想），这表明 $B quo m$ 可以嵌入 $B' quo m'$，且 $B' quo m'$ 在 $B quo m$ 上代数
    ]
    #theorem[][
      设 $A subset k$  其中 $A$ 是整环，$k$ 是域，则 $A$ 的整闭包恰为 $k$ 中包含 $A$ 的所有赋值环的交 
    ]
    #proof[
      - 一方面，设 $B$ 是赋值环且 $A subset B subset k$，注意到 $B$ 是整闭的，因此 $A$ 的整闭包当然只能含于 $B$
      - 另一方面，我们要证明若 $x$ 含于所有这样的赋值环，则含于 $A$ 的整闭包\
        反之，设 $x$ 在 $A$ 上不是整元，只需构造一个赋值环 $B supset A$ 使得 $x$ 不在 $B$ 中\
        令 $A' = A[Inv(x)]$ 它不是有限生成 $A-$模，也不包含 $x$，设 $Inv(x) in A'$ （注意到它不是单位）包含于极大理想 $m'$，考虑：
        $
        f: A -> A' -> A quo m' -> overline(A quo m')
        $
        最后一项是指代数闭包。\
        在 @extension-of-valuation 中，注意到 $(A, f)$ 是符合定义的二元组，因此存在一个比它更大的元素 $(B, g)$ 使得 $A subset B subset k$ 且有交换图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $A'$, 2),
        node((0, 2), $A quo m'$, 4),
        node((0, 3), $overline(A quo m')$, 5),
        node((1, 0), $B$, 3),
        arr(1, 2, $$, inj_str),
        arr(2, 3, $$, inj_str),
        arr(3, 5, $g$),
        arr(2, 4, $$),
        arr(4, 5, $$),
        )]
        断言 $x in.not B$，否则又注意到 $(A' -> overline(A quo m')) (Inv(x)) = 0$，若 $x in B$
        则 $Inv(x) in ker g$ 是可逆元导致 $g$ 平凡，这是荒谬的 
    ]
  == 离散赋值环|Discrete valuation ring
    #definition[Discrete valuation ring, DVR][
      设 $k$ 是域，$k$ 上的离散赋值是指映射:
      $
      v: k^* -> ZZ, 
      $
      满足：
      + $v$ 是满射
      + $v(x y) = v(x) + v(y)$
      + $v(x + y) >= min{v(x), v(y)}$
      （有时也将 $v$ 视作 $k -> ZZ union {infinity}$）\
      此时：
      - 称 $k$ 是*离散赋值域*|discrete valuation field, dvf
      - 若 $v(pi) = 1$，则称 $pi$ 是一个一致化子|uniformizer
      - 记 $O_v = {x in k | v(x) >= 0}$ （特别的令 $0 in O_v$），则 $O_v$ 是赋值环且 $ht(O_v) = 1$
      - 记 $m_v = {x in k | v(x) >= 1}$ 它是 $O_v$ 的理想，稍后证明它是极大的
      一般的，若一个整环是上面方法所产生的赋值环，则称之为*离散赋值环*
    ]
    #example[][
      - 设 $k = QQ, p$ 是素数，对任意非零 $x in k$ ，可设 $x = p^a y$ 且 $y$ 的分子分母都与 $p$ 互素，此时定义 $v_p (x) = a$，这给出 $QQ$ 上的一个离散赋值，它的赋值环 $O_v_p = {r/s | (s, p) = 1} = ZZ_((p))$
      - 令 $K = k(x), f in k[x]$ 是不可约多项式，类似的可以做唯一因子分解将 $K$ 中任意一个元素写作 $x = f^a y$ 以及赋值 $v_f$
    ]
    #proposition[][
      设 $A$ 是离散赋值环，以分式域 $k$ 上的离散赋值 $v$ 产生，则 $A$ 是整闭的局部环且：
      - 其中的单位就是赋值为零的那些元素
      - 极大理想就是 $m_v = {x in k|v(x) >= 1}$
      - $v(x) = v(y)$  当且仅当 $x, y$ 只差一个可逆元，也即 $(x) = (y)$
      - 任取 $A$ 中理想 $I$，选出其中赋值最小的元素 $x$ ，则 $I = (x) = {y in A|v(y) >= v(x)}$
      - 设 $pi$ 是一致化子，则 $v(pi^k) = k$，由上一个命题所有理想 $I$ 都是由某个 $pi^k$ 生成的主理想，表明 $A$ 中所有非零理想构成链：
        $
        m_v = (pi) =  {x in k|v(x) >= 1} >= m_v^2 = (pi^2) >= ...
        $
        $m_v$ 是唯一的非零素理想，特别的，$A$ 是 $dim A = 1$ 的 Noether 环
    ]
    #proof[
      由 @valuation-ring-prop 可知 $A$ 是局部环且整闭
      - 注意到 $v(x) = 0 => v(Inv(x)) = 0 => Inv(x) in A$ 表明 $A$ 中赋值为零的元素都是单位。同时不难验证赋值为正的元素不是单位
      - 由赋值的定义不难验证它是理想，上一条给出它当然就是极大理想
      - 注意到 $v(x) = v(y) => v(Inv(x) y) = 0 => Inv(x) y in U(A)$，因此 $x, y$ 只差可逆元
      - 设 $v(y) >= v(x)$ 则 $v(y Inv(x)) >= 0 => y Inv(x) in A => y in (x)$\
        如此，赋值不小于 $x$ 的元素都在 $I$ 中，而由假设 $I$ 中没有赋值小于 $x$  的元素，因此 $I = (x) = {y in A|v(y) >= v(x)}$
      - 显然
    ]
    #theorem[][
      设 $A$ 是 Noether 的局部整环，且 $dim A = 1$，$m$ 为极大理想，$k$ 为留域，则以下条件等价：
      + $A$ 是离散赋值环
      + $A$ 整闭
      + $m$ 是主理想
      + $dim_k m quo m^2 = 1$
      + $A$ 中每个非零理想都是 $m$ 的幂
      + $exists x in A$ 使得每个非零理想都形如 $(x^k), k >= 0$
    ]
    #proof[
      #lemmaLinear[][
        设 $I$ 是非平凡理想，则存在 $n > 0, m^n subset I$
      ]
      #proof[
        注意到 $sqrt(I)$ 是包含 $I$ 的所有素理想的交，由 $dim A = 1$ 知它就是 $m$，再由 Noether 知 $m$ 有限生成，考虑生成元不难发现结论成立
      ]
      #lemmaLinear[][
        $m^k != m^(k+1)$
      ]
      #proof[
        如若不然由 @noether-local-classification 可得环是 Artin 环，这与 $dim A = 1$ 矛盾
      ]
      - 1 $=>$ 2 显然
      - 2 $=>$ 3 任取 $0 != a in m$，由引理，设 $n$ 满足：
        $
        m^n subset (a), m^(n-1) subset.not (a)
        $
        取 $b in m^(n-1) - (a)$，令 $x = a /b in k$，往证：
        - $x$ 不是 $A$ 中单位，否则 $(a) = (b)$ 与取法矛盾
        - $Inv(x) m subset.not m$  ，否则利用 Hamiton-Cayley 可以证明 $Inv(x)$ 是整元
      - 3 $=>$ 4 显然主理想的生成元就是向量空间 $m quo m^2$ 的生成元，同时 $m quo m^2 != 0$ 否则由 Nakayama 知 $m = 0$，导致 $dim A = 0$
      - 4 $=>$ 5 继续利用引理，设 $I$ 是非平凡理想，且 $m^n subset I, m^(n-1) subset.not I$，，注意到 $A quo m^n$ 是 Artin 局部环，由 @artin-local-prop 结合条件立得结论正确
      - 5 $=>$ 6 取 $x in m - m^2$，由结论 $(x) = m^r$ 再根据假设只能有 $r = 1 => (x) = m$ ，由于所有理想都是 $m$ 的幂次当然结论成立
      - 6 $=>$ 1 有条件，当然有 $m = (x)$，且 $(x^k) != (x^(k+1))$\
        对任意 $A$ 中非零元素 $a$，定义 $v(a) = r$ 若 $(a) = (x^r)$
        - 由条件，这个 $r$ 是唯一的
        - 将赋值延拓到分式环上，可以验证它是一个离散赋值
    ]
    #theorem[][
      设 $A$ 是 Noether 的整环，且 $dim A = 1$，则以下条件等价：
      + $A$ 整闭
      + $A$ 在所有素理想/极大理想处的局部化都整闭
      + $A$ 在所有素理想/极大理想处的局部化都是离散赋值环
    ]<dedekind-the>
    #proof[
      注意到整闭是局部性质，由上面的定理不难推出该定理
    ]
  == 戴德金整环|Dedekind domains
    这部分在数论课程中更加重要，本门课程不会要求太高
    #definition[戴德金整环|Dedekind domains][
      满足 @dedekind-the 条件的环成为戴德金整环
    ]
    #proposition[][
      戴德金整环中，所有理想都可以唯一分解为素理想的乘积
    ]
    #proof[
      这个结论是唯一分解性质的进一步推广，我们不证明这个结论
    ]
    #proposition[][
      - 主理想整环都是戴德金整环，既然主理想整环都诺特，且主理想整环作为唯一分解整环满足非零素理想都极大进而 $dim = 1$，同时它的局部化也是主理想环，故满足 @dedekind-the 条件
      - 设 $k quo Q$ 是有限代数扩张，$A$ 是 $ZZ$ 在 $k$ 中的整闭包，也就是 $k$ 中的代数整数，则 $A$ 是戴德金整环
        #proof[
          - $A$ 当然整闭
          - $A$ 是诺特的，证明略
          - 下证 $dim A = 1$，也即所有非零素理想都极大。这是因为任取 $p in Spec(A)$，一定有 $p sect ZZ$ 是素理想
            - 若 $p sect ZZ = 0$，然而 $0 subset p$ 同样有 $0 sect ZZ = 0$，由整扩张性质 @integral-prime-containing 立得 $p = 0$  矛盾！
            - 否则，$p sect ZZ$ 是极大理想，由 @integral-prime-containing 知 $p$ 也是极大理想
        ]
    ]
  == 分式理想
    #definition[分式理想/可逆理想][
      设 $A$ 是整环，$K$ 是分式域：
      - 称 $K$ 的子 $A-$模 $M$ 是分式理想，如果：
        $
        exists x != 0 in A, x M subset A
        $
        若 $M$ 是分式理想，定义：
        $
        (A:M) = {x in K | x M subset A}
        $
      - 称 $K$ 的子 $A-$模 $M$ 是可逆理想，如果存在 $K$ 的子 $A-$模 $N$ 使得 $M N = A$\
      - 所有的可逆理想构成群（单位元是 $A$）

    ]
    #example[][
      - $A$ 的理想当然是分式理想，取 $x = 1$ 即可。
      - 若 $M$ 是有限生成的 $K$ 子 $A-$模，取 $x$ 为生成元分母的乘积，它也是分式理想。
      - 任取 $u in K^*$ ，则 $(u)$ 是分式理想，也是可逆理想，它的逆就是 $(1/u)$
    ]
    #proposition[][
      设 $A$ 是诺特环，则所有分式理想都是有限生成的
    ]<noether-fractional-ideal-finite>
    #proof[
      设 $M$ 是分式理想，$x M$ 是 $A$ 的理想，进而有限生成，当然 $M$ 也是有限生成的 $AModule(A)$
    ]
    #proposition[][
      - 可逆理想都是分式理想
      - $M$ 是可逆理想时，它的逆就是 $(A:M)$
      - 可逆理想都是有限生成理想
    ]
    #proof[
      - 设 $N$ 是一个逆，任取 $n in N$ 当然有 $n M subset A$
      - 由上条的证明过程知 $N subset (A:M)$，同时 $(A:M) = (A:M) M N subset A N subset N$
      - 由 $M N = A$ 可得：
        $
        1 = sum_i m_i n_i
        $
        上式右侧是有限和。任取 $z in M$ 都有：
        $
        z = z sum_i m_i n_i = sum_i (z n_i) m_i in sum_i A m_i
        $
        表明 $m_i$ 就是一组生成元
    ]
    #theorem[可逆性是局部性质][
      以下条件等价：
      - $M$ 是可逆理想
      - $M$ 有限生成，且对任意素理想 $p$，$M_p$ 是可逆理想
      - $M$ 有限生成，且对任意极大理想 $m$，$M_m$ 是可逆理想

    ]
    #proof[
      - 1 $=>$ 2 之前证明了 $A = M (A:M)$，我们希望做局部化。注意到 $M$ 是有限生成的，因此局部化可以和 $Ann$ 交换，自然可以和 $(A:M)$ 交换，故结论成立
      - 2 $=>$ 3 显然
      - 3 $=>$ 1 设 $I = M (A:M)$ 由条件它不含于任何的极大理想中（否则可以做局部化），因此就是 $A$
    ]
    #theorem[][
      设 $A$ 是局部环，则 $A$ 是离散赋值环当且仅当每个非零分式理想都可逆
    ]
    #proof[
      - 设 $A$ 是离散赋值环，设 $m = (pi)$ 是极大理想，若 $M$ 是分式理想，则存在 $y$ 使得：
        $
        y = (pi^s)\
        y M = (pi^r)\
        M = (pi^(r-s))
        $
        这当然是可逆的
      - 首先，可逆理想都有限生成，因此 $A$ 当然是诺特环。往证所有理想都是极大理想的幂次。\
        令 $Sigma$ 为 $A$ 中所有不是 $m$ 幂次的理想，若其非空，由诺特条件找到一个极大元 $I$\
        由条件，将有：
        $
        Inv(m) I subset.not Inv(m) m = A
        $
        同时，$Inv(m) I != m$ 否则 $I = m^2$，类似的它也不是 $m$ 的幂次\
        然而 $I subset Inv(m) I$，由极大性 $I = Inv(m) I$ 除非 $I = 0$ 否则这是荒谬的
    ]
    #corollary[][
      设 $A$ 是整环，则 $A$ 是戴德金整环当且仅当所有的非零分式理想都可逆
    ]
    #proof[
      利用局部化，显然（注意到左推右需要利用诺特性和 @noether-fractional-ideal-finite，右推左需要利用分式理想都有限生成表明环是诺特的）
    ]
= Kahler-differentials
  这部分是补充内容，讨论代数的导数和切空间等内容
  #definition[derivation][
    设 $A$ 是环，$B$ 是 $A-$代数，$M$ 是 $B-$模，一个 $M$ 中 $B$ 的 $A-$导数（A-derivation of B into M）是一个 $A-$线性映射 $dif: B -> M$ 满足莱布尼茨法则：
    $
    dif(x y) = x dif(y) + y dif(x), forall x, y in B
    $
    显然这里的 $B$ 的定位类似于 $A$ 上的函数，$M$ 类似于切空间\
    定义所有这样的导数构成集合：
    $
    Der_A (B, M)
    $
  ]
  #proposition[][
    - $dif(1) = dif(1 dot 1) = dif(1) + dif(1) => dif(1) = 0, dif(a) = a dif(1) = 0$，这就是在说常值函数的导数为零
  ]
  #definition[][
    设 $B$ 是 $A-$代数，则存在 $B-$模 $Omega'_(B quo A)$，和相应的 $A-$导数 $dif$ 并且满足泛性质：对任意 $B-$模 $M$ 和 $A-$导数 $dif': B -> M$，有交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $B$, 1),
    node((0, 1), $M$, 2),
    node((1, 0), $Omega'_(B quo A)$, 3),
    arr(1, 2, $dif'$),
    arr(3, 2, $exists ! phi$),
    arr(1, 3, $dif$),)]
    这个泛性质等价于同构：
    $
    Der_A (B, M) tilde.eq Hom_B (Omega'_(B quo A), M)
    $
    称 $Omega'_(B quo A)$ 为 the module of relative differential forms of B over A\
  ]
  #proof[
    和张量积类似，唯一性由范畴的始对象给出，存在性也用类似张量积的构造方法，用自由模商掉我们需要的关系即可\
    具体来说，令 $F$ 是由符号 ${dif b | b in B}$ 生成的自由 $B-$模，令：
    $
    N = generatedBy({dif a | a in A} union {dif (b_1 + b_2) - dif b_1 - dif b_2 | b_1, b_2 in B} union {dif (b_1 b_2) - b_1 dif b_2 - b_2 dif b_1 | b_1, b_2 in B})\
    Omega_(B quo A) = F quo N
    $
    并且 $dif$ 就是自然的同态，很容易验证它满足莱布尼茨法则

    为了证明泛性质，给出交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $B$, 1),
    node((0, 1), $M$, 2),
    node((1, 0), $F$, 3),
    node((2, 0), $Omega_(B quo A)$, 4),
    arr(1, 2, $dif'$),
    arr(3, 2, $exists phi$),
    arr(1, 3, $dif$),
    arr(3, 4, $$),
    arr(4, 2, $exists phi'$)
    )]
    其中：
    - $phi$ 来自于自由模的泛性质
    - 不难验证 $N subset ker phi$，因此 $phi'$ 产生于商模的泛性质
  ]
  #example[][
    设 $B = A[t_1, ..., t_n]$ 是多项式环，则 $Omega'_(B quo A)$ 就是自由模 $directSum_i B dif t_i$, 其中：
    $
    dif F = sum_i partialDer(F, t_i) dif t_i
    $
    这是因为任取 $dif'$ 不难计算一定有：
    $
    dif' F = sum_i partialDer(F, t_i) dif' t_i
    $
    因此 $dif t_i -> dif' t_i$ 给出典范的同态，这就证明了泛性质
  ]
  #example[][
    若 $B = A quo I$ 或 $B = Inv(S) A$ 则 $Omega'_(B quo A) = 0$\
    只需说明任何导数都为零即可：
    - 若 $B = A quo I$，任取 $x in B$，则 $x = a + I$，有 $dif (a + I) = a dif(1 + I) = 0$
    - 若 $B = Inv(S) A$ ，任取 $s/t in B$，有 $t dif (s/t) = dif (s) = 0$ 而 $t$ 是 $B$ 中可逆元，当然就有 $dif(s /t) = 0$
  ]
  #definition[][
    设 $B ->^f C$ 是 $A-$代数同态以及两个导数：
    $
    C ->^(dif_C) Omega'_(C quo A)\
    B ->^(dif_B) Omega'_(B quo A)
    $
    可以定义映射：
    $
    Omega_(B quo A) &-> Omega_(C quo A)\
    dif b &-> dif f(b)\
    Omega_(B quo A) tensorProduct C &-> Omega_(C quo A)\
    dif b tensorProduct c &-> c dif f(b)
    $
  ]
  #proposition[][
    设 $B$ 是 $A-$代数
    - 换基性质：任取环同态 $A -> A'， B' = A' tensorProduct_A B$，则有：
      $
      Omega_(B' quo A') tilde.eq Omega_(B quo A) tensorProduct_A B'
      $
    - 任取 $B ->^f C$ 是 $A-$代数同态，有正合列：
      $
      Omega_(B quo A) tensorProduct_B C -> Omega_(C quo A) -> Omega_(C quo B) -> 0
      $
    - 任取 $B$ 的乘性子集 $S$，有：
      $
      Inv(S) Omega_(B quo A) = Omega_(B quo A) tensorProduct_B Inv(S) B tilde.eq Omega_(Inv(S) B quo A)
      $
    - 设 $C = B quo I$ 有正合列：
      $
      I quo I^2 -> Omega_(B quo A) tensorProduct_B C -> Omega_(C quo A) -> 0
      $
  ]
  #example[][
    设 $B = A[T_1, ..., T_n], C = B quo (F)$，由上面的命题有正合列：
    $
    (F) quo (F^2) -> Omega_(B quo A) tensorProduct_B C -> Omega_(C quo A) -> 0
    $
  ]
= 完备化
  == 拓扑阿贝尔群
    #definition[拓扑阿贝尔群][
      设 $G$ 是阿贝尔群，$G$ 上的拓扑是说 $G$ 是拓扑空间，且群运算是连续的
    ]
    #lemma[][
      $G$ 是拓扑阿贝尔群，则 $G$ 是 Hausdorff 空间当且仅当 ${0}$ 是闭集
    ]
    #proof[
      - 若 $G$ 是 Hausdorff 空间，则 ${0}$ 当然是闭集
      - 注意到：
        #align(center)[#commutative-diagram(
        node((0, 0), $G$, 1),
        node((0, 1), $G times G$, 2),
        node((1, 0), ${0}$, 3),
        node((1, 1), $G$, 4),
        arr(1, 2, $"diag"$),
        arr(1, 3, $$),
        arr(2, 4, $\"-\"$),
        arr(3, 4, $$),)]
    ]
    #lemma[][
      设 $H$ 为所有 $0$ 的邻域的交，则：
      - $H$ 是子群
      - $H = overline({0})$
      - $G quo H$ 是 Hausdorff 空间
      - $G$ 是 Hausdorff 空间当且仅当 $H = {0}$
    ]
    #proof[
      - 设 $x, y in H$ ，任取 $0$ 的开邻域 $O$，注意到 $T_x: G -> G$ 连续，则 $Inv(T_x)(O)$ 是开集。同时 $x in O => 0 in Inv(T_x)(O) => y in Inv(T_x)(O) => x + y in O$
      - #TODO
      - 不难发现 ${0} subset G quo H$ 当然是闭集，因此结论成立
      - 就是上面的引理
    ]
  == 分次环
    #definition[分次环|graded ring][
      设 $A$ 是环，$A = directSum A_n$，称 $A$ 是分次环，若 $A_i A_j subset A_(i+j)$

      此时，称 $A_i$ 为 $i$ 次齐次部分。设 $I$ 是 $A$ 的理想，则称 $I$ 是齐次的，若 $I = directSum (I sect A_i)$，也即它被齐次元素生成
    ]
    #lemma[][
      设 $I$ 是齐次理想，则 $I$  是素理想当且仅当任取齐次元素 $x, y, x y in I$ 均有 $x in I or y in I$
    ]
  == 拓扑完备化
    #definition[拓扑完备化][
      设 $G$ 是拓扑阿贝尔群，且 $0$ 处有可数邻域基，则可以定义完备化 $hat(G)$ 为所有柯西序列的等价类，其中：
      - ${x_n}$  是柯西序列当且仅当任取 $0$ 的开邻域 $U$ 均有对于充分大的 $n, m$ 有 $x_n - x_m in U$
      - 两个柯西序列 $x_n, y_n$ 等价当且仅当 $x_n - y_n -> 0$，也即任取 $0$ 的开邻域 $U$ 均有对于充分大的 $n$ 有 $x_n - y_n in U$
      在其上定义：
      - ${x_n} + {y_n} = {x_n + y_n}$
      - 
        $
        funcDef(phi, G, hat(G), a, {a})
        $
        一般来说 $phi$ 不是单射。事实上，$ker phi$ 就是 $0$ 的所有开邻域的交，因此 $phi$ 是单射当且仅当 $G$ 是 Hausdorff 空间
      - 函子性：设 $f: G -> H$ 是连续同态，则柯西序列的像还是柯西序列，从而 $f$ 可以诱导 $hat(f)$ ，也即完备化具有函子性
    ]
    #example[][
      假设 $G_n$ 是 $0$ 的开邻域，且满足：
      $
      G = G_0 >= G_1 >= ... >= G_n >= ...
      $
      并且， $U$ 是 $0$ 的邻域当且仅当存在 $G_n subset U$，此时断言：
      - $G_n$ 既开由闭
        - 先证明开集，设 $g in G_n$ 则 $g + G_n subset G_n$ 是 $g$ 的一个 $G_n$ 中的开邻域，继而 $G_n$ 一定是开集
        - 再证明闭集，既然 $G - G_n = union_(h in.not G_n) （h + G_n）$ 是开集，因此 $G_n$ 是闭集
      此时，完备化可以有纯代数的定义：
      $
      hat(G) tilde.eq inverseLimit G quo G_n
      $
      同构如下给出：
      - 任取 $(xi_n) in inverseLimit G quo G_n$，给出对应的柯西序列为：
        $
        x_n in G\
        x_n = xi_n mod G_n\
        $
        此时将有 $x_(n+1) - x_n in G_n$，不难验证它是柯西序列
      - 任取柯西序列 $(x_n)$，既然只要 $m, m'$ 充分大即有：
        $
        overline(x_m) = overline(x_m') in G quo G_n
        $
        因此对充分大的 $m$ 定义 $xi_m = overline(x_m) in G quo n$ 
    ]<alg-top-completion>
    #lemma[][
      若:
      $
      0 -> {A_n} -> {B_n} -> {C_n} -> 0 
      $
      是逆向系统的正合列，则：
      $
      0 -> inverseLimit A_n -> inverseLimit B_n -> inverseLimit C_n 
      $
      正合（逆向极限是左正合的）

      进一步，若 $A_n$ 是满射系统（也即每个 $A_(n+1) -> A_n$ 是满射），则：
      $
      0 -> inverseLimit A_n -> inverseLimit B_n -> inverseLimit C_n -> 0
      $
      正合
    ]
    #proof[
      设 $A = product A_n$，定义：
      $
      funcDef(d_A, A, A, (a_n), (a_n - overline(a_(n+1))))
      $
      则 $ker d_A = inverseLimit A_n$\
      将有交换图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $0$, 1),
      node((0, 1), $A$, 2),
      node((0, 2), $B$, 3),
      node((0, 3), $C$, 4),
      node((1, 0), $0$, 5),
      node((1, 1), $A$, 6),
      node((1, 2), $B$, 7),
      node((1, 3), $C$, 8),
      node((0, 4), $0$, 9), 
      node((1, 4), $0$, 10),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(5, 6, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(2, 6, $d_A$),
      arr(3, 7, $d_B$),
      arr(4, 8, $d_C$),
      arr(4, 9, $$),
      arr(8, 10, $$),
      
      )]
      蛇形引理给出正合列：
      $
      0 -> ker d_A -> ker d_B -> ker d_C -> coker d_A -> coker d_B -> coker d_C -> 0
      $
      进一步，若 ${A_n}$ 是满系统，只需证明 $d_A$ 满继而 $coker d_A = 0$. 事实上，任给 $(a_n) in A$，只需找到 $(x_n)$ 使得 $x_n - overline(x_(n+1)) = a_n$，递归定义即可
    ]
    #corollary[][
      设 $G$ 满足 @alg-top-completion 的条件，且有正合列：
      $
      0 -> G' -> G -> G'' -> 0
      $
      其中 $G', G''$ 分别用 ${G_n sect G'}$ 和 ${(G -> G'') (G_n)}$ 定义拓扑，将有：
      $
      0 -> hat(G') -> hat(G) -> hat(G'') -> 0
      $
      正合。
    ]<exact-completion>
    #proof[
      注意到有正合列：
      $
      0 -> {G quo G' sect G_n} -> {G quo G_n} -> {G quo ((G -> G'') (G_n))} -> 0
      $
      取逆向极限利用之前的结论立得结论成立
    ]
    #corollary[][
      取正合列:
      $
      0 -> G_n -> G -> G quo G_n -> 0
      $
      注意到 $G quo G_n$ 有离散拓扑（所有子集都是开集），完备化就是本身，即可得正合列：
      $
      0 -> hat(G_n) -> hat(G) -> G quo G_n -> 0
      $
      因此：
      $
      hat(G) quo hat(G_n) tilde.eq G quo G_n
      $
      特别的，$hat(hat(G)) = hat(G)$（取逆向极限即可）
    ]<completion-of-completion>
    #proof[
      利用之前的结论即可
    ]
    #definition[完备][
      设 $phi: G -> hat(G)$ 是同构，则称 $G$ 是完备空间。
    ]
    #proposition[][
      - 既然 $ker phi = {0}$ 故完备空间一定 Hausdorff
      - 在 @completion-of-completion 的条件中，$hat(G)$ 当然一定是完备空间
    ]
  == $I-$adic 拓扑
    #example[环/模的完备化][
      - 设 $A$ 是环，$I$ 是理想，取 $G = A, G_n = I^n$，由 $G_n$ 定义的拓扑称为 $I$-adic 拓扑，如此可以产生完备化：
        $
        hat(A) = inverseLimit A quo I^n, phi: A -> hat(A), ker phi = sect I_n
        $ 
      - 设 $M$ 是 $AModule(A)$，取 $G = M, G_n = I^n M$ 类似可以定义 $M$ 上的 $I$-adic 拓扑，以及 $hat(M)$ 称为连续 $AModule(A)$（$A$ 在其上的作用是连续的）
      - 特别的：
        - 取 $A = k[x], I = (x)$，则 $hat(A) = k[[x]]$ 就是形式幂级数环
        - 取 $A = ZZ, I = (p)$，则 $hat(A) = ZZ_p$ 就是 $p$-进整数环
    ]
    #definition[][
      设 $M$ 是$AModule(A)$，$I$ 是理想，称一个 $M$ 的 $A$ filtration 是一个子模的无穷序列：
      $
      M = M_0 >= M_(1) >= ... 
      $
      - 称之为 $I-$filtration ，如果 $I M_n subset M_(n+1)$
      - 称之为稳定 $I-$filtration ，如果满足上条的条件且对于充分大的 $n$ 有 $I M_n = M_(n+1)$
    ]
    #example[][
      $(I^n M)$ 当然是稳定 $I-$filtration
    ]
    #lemma[稳定 $I-$filtration给出相同的拓扑][
      若 $(M_n), (M'_n)$ 都是稳定 $I-$filtration，则它们有有界差距（bounded diffrence）也即：
      $
      forall n > 0, exists n_0, M_(n+n_0) subset M'_n, M'_(n+n_0) subset M_n
      $
      因此，$(M_n), (M'_n)$ 定义相同的 $I-$adic 拓扑
    ]
    #proof[
      不妨设 $M' = I^n M$，此时当然有：
      - $I M_n subset M_(n+1) => M'_n subset M_n$
      #TODO
    ]
    设 $A^* = directSum_(n = 0)^infinity I^n$ 是分次环，则 $M^* = directSum_(n = 0)^infinity M^n$ 将是分次 $A^*$ 模。若 $A$ 是诺特的，可设 $I = (x_1, x_2, ..., x_n)$，此时 $A^* = A[x_1, x_2, ..., x_n]$ 当然也是诺特的
    #lemma[][
      设 $A$ 诺特，$I$ 是理想，$M$ 是有限生成模以及 $I-$filtration $(M_n)$，则以下条件等价：
      + $M^*$ 是有限生成模
      + $(M_n)$ 是稳定 $I-$filtration
    ]
    #proof[
      - 1 $=>$ 2 设：
        $
        Q_n = directSum_(i = 0)^n M_i subset M^*
        $ 
        （未必是 $A^*$模），令 $M_n^*$ 是由其生成的模。由于 $M$ 有限生成，显然 $M_n^*$ 也是有限生成的。

        显然 $M_n^*$ 构成升链，且 $union M_n^* = M^*$，可以验证：
        $
        M^* "有限生成" <=> M^* = M^*_(n), n "充分大"
        $
        而后者 #TODO 等价于 $M_(n + r) = I^r M_n, n, r$ 都充分大，证毕
    ]
    #proposition[Artin-Rees Lemma][
      设 $A$ 诺特，$I$ 是理想，$M$ 是有限生成模以及 稳定 $I-$filtration $(M_n)$，$N$ 是 $M$ 的子模，则 $M' sect M_n$ 是稳定 $I-$filtration\
      特别的，若 $M_n = I^n M$，则存在充分大的 $k$ 使得：
      $
      I^n M sect N = I^(n-k) (I^k M sect N)
      $

      换言之，$I-$adic 拓扑的限制还是 $I-$adic 拓扑
    ]<Artin-Rees>
    #proof[
      - 首先，$I(M' sect M_n) subset I M' sect I M_n subset M' sect M_(n+1)$，表明这是 $I-$filtration
      - 其次，上面的引理给出 $M^*$ 有限生成，而 $directSum (M' sect M_n)$ 当然是它的子模。诺特环上有限生成模是诺特的，其子模仍然有限生成，因此 $directSum (M' sect M_n)$ 是子模，进而再次利用引理即可得到结论
    ]
    #corollary[][
      设 $A$ 诺特，$I$ 是理想，则：
      $
      0 -> hat(M') -> hat(M) -> hat(M'') -> 0
      $
      也正合
    ]
    #proof[
      @Artin-Rees 结合 @exact-completion 立得
    ]
    #proposition[][
      设 $M$ 是有限生成 $A-$模，则 $M tensorProduct_A hat(A) -> hat(M)$ 是满射。进一步若 $A$ 是诺特的，则它是同构。
    ]
    #proof[
      - $I-$adic 完备化和有限直和是交换的（既然它们都是逆向极限）
      - $F$ 是有限自由模时，$hat(F) = (hat(A))^n$ 继而 $F tensorProduct hat(A) = hat(F)$
      由 $M$ 有限生成，有正合列：
      $
      0 -> N -> F -> M -> 0
      $
      其中 $F$ 是有限自由模，由张量积右正合：
      $
      N tensorProduct hat(A) -> F tensorProduct hat(A) -> M tensorProduct hat(A) -> 0
      $
      有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $N tensorProduct hat(A)$, 1),
      node((0, 1), $F tensorProduct hat(A)$, 2),
      node((0, 2), $M tensorProduct hat(A)$, 3),
      node((0, 3), $0$, 4),
      node((1, 0), $hat(N)$, 5),
      node((1, 1), $hat(F)$, 6),
      node((1, 2), $hat(M)$, 7),
      node((1, 3), $0$, 8),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(5, 6, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(1, 5, $$),
      arr(2, 6, $$, bij_str),
      arr(3, 7, $$),
      arr(4, 8, $$),)]
      其中上下（下是因为满射系统的逆向极限是正合函子）都正合，继而 $M tensorProduct hat(A) -> hat(M)$ 是满射。若 $A$ 是诺特的，$N$ 作为有限生成模的子模也是有限生成模，$N tensorProduct hat(A) -> hat(N)$  也满射，同时 $hat(N) -> hat(F)$ 由完备化的正合性（上面的推论）将成为单射，运用蛇形引理即得 $ker (M tensorProduct hat(A) -> hat(M)) = 0 $，证毕
    ]
    #let hA = $hat(A)$
    #let hI = $hat(I)$
    #corollary[][
      设 $A$ 诺特，$I$ 是任意理想，则：
      - 完备化是正合函子
      - $hat(A)$ 是平坦 $A$-模
      - $hat(I) = I tensorProduct hat(A) = I hat(A)$
      - $hat(I^n) = (hat(I))^n$
      - $hat(A) quo hat(I) tilde.eq A quo I$（之前已经证明，这条不需要诺特）
      - $I^n quo I^(n+1) tilde.eq hat(I^n) quo hat(I^(n+1))$
      - $hat(I)$ 落在 $hat(A)$ 的 Jacobson 根中

    ]
    #proof[
      只证明最后一条，任取 $x in hat(I), y in hat(A)$，有：
      $
      Inv((1- y x))  = 1 + y x + ... 
      $
      由完备性，上式右侧是有意义的，表明 $1 -y  x$ 是单位，证毕
    ]
    #proposition[][
      设 $A$ 是诺特局部环，$m$ 是极大理想，则 $hat(A)$ 仍是局部环，极大理想是 $hat(m)$
    ]
    #proof[
      首先 $hat(A) quo hat(m) tilde.eq A quo m$ 保证 $hat(m)$ 是极大理想\
      其次，前面已经证明 $hat(m)$ 落在 Jacobson 根中，因此 $hat(m)$ 是唯一极大理想
    ]
    #theorem[Krull][
      设 $A$ 诺特， $M$ 有限生成，则：
      $
      ker (M -> hat(M)) = sect I^n M = {x in M | exists y in I, (1 + y) x = 0}
      $
      特别的，若 $A$ 是整环且 $I != (1)$，则 $sect I^n M = {0}$
    ]<Krull>
    #proof[
      设 $E = ker(M -> hat(M))$，它也是 $0$ 的所有开邻域的交。
      - 一方面，$E$ 的限制拓扑是平凡的
      - 另一方面，$E$ 的限制拓扑还是 $I-$adic 拓扑
      #TODO
      上面两条给出 $I E = E$，由 Nakayama 引理的一个版本可得存在 $alpha in I$ 使得 $(1 - alpha) E = 0$

      另一方面，设 $(1 - alpha) x = 0$，则 $x = alpha x = ... alpha^n x = ...$，当然 $x in sect I^n M$
    ]
    #corollary[][
      在前面的条件中，若 $I$ 落在 Jacobson 根中，必有 $sect I^n M = 0$，继而 $M$ 上的 $I-$adic 拓扑是 Hausdorff 的。

      特别的，若 $A$ 是诺特的局部环，则其上所有有限生成模的 $I-$adic 拓扑都是 Hausdorff 的，包括 $A$ 本身
    ]
    #theorem[][
      设 $A$ 的诺特环，则 $hat(A)$ 还是诺特的。特别的，诺特环上有限个变元的形式幂级数环（作为多项式环的完备化）还是诺特的
    ]
    #proof[
      它的证明需要一些铺垫
      #let Gn(n) = $M_(#n) quo M_(#n +1)$
      #definition[][
        定义：
        $
        G(A) = directSum_(n = 0)^infinity I^n quo I^(n+1)
        $
        它是分次环

        若 $M$ 有 $I-$filtration，可以类似定义：
        $
        G(M) = directSum_(n = 0)^infinity Gn(n)
        $
        它是分次 $G(A)$ 模
      ]
      #proposition[][
        设 $A$ 诺特，则：
        - $G(A)$ 是诺特的
        - $G_I (A) tilde.eq G_(hI) (hA)$
        - 设 $M$ 是有限生成的，且其上的 $I-$filtration 是稳定的，则 $G(M)$ 有限生成
      ]
      #proof[
        - 显然 $I$ 有限生成，不妨设 $I = (x_1, x_2, ..., x_n)$，显然：
          $
          G(A) = A quo I [overline(x_1), ..., overline(x_n) ]
          $
          它当然是诺特的
        - 前面已经证明
        - $n$ 充分大时，有 $Gn(n) tilde.eq M_n quo I M_n = A quo I tensorProduct M$，因此 $G(M)$ 本质上仅有前面有限项生成（后面的只是 $I$ 在其上的作用）#TODO，当然是有限生成的 
      ]
      #proposition[][
        设 $M$ 是有限生成，且其上的 $I-$filtration 是稳定的，假设 $A$ 完备且 $M$ 是 Hausdoff 的，也即 $sect M_n = 0$，则：
        - 若 $G(M)$ 有限生成，则 $M$ 有限生成
        - 若 $G(M)$ 诺特，则 $M$ 诺特
      ]
      #proof[
        #lemma[][
          设 $phi: A -> B$ 是 filtered 群间的同态，诱导 $hat(phi): hat(A) -> hat(B), G(phi) : G(A)  -> G(B)$，则：
          - $G(phi)$ 是单射给出 $hat(phi)$ 是单射
          - $G(phi)$ 是满射给出 $hat(phi)$ 是满射
        ]
        #proof[
          有交换图：
          #align(center)[#commutative-diagram(
          node((0, -1), $0$, -1),
          node((1, -1), $0$, -2), 
          node((0, 0), $A quo A_(n+1)$, 1),
          node((0, 1), $A quo A_(n+1)$, 2),
          node((0, 2), $A quo A_n$, 3),
          node((0, 3), $0$, 4),
          node((1, 0), $B_n quo B_(n+1)$, 5),
          node((1, 1), $B quo B_(n+1)$, 6),
          node((1, 2), $B quo B_(n)$, 7),
          node((1, 3), $0$, 8),
          arr(-1, 1, $$),
          arr(-2, 5, $$),
          arr(-1, -2, $$),
          arr(1, 2, $$),
          arr(2, 3, $$),
          arr(3, 4, $$),
          arr(5, 6, $$),
          arr(6, 7, $$),
          arr(7, 8, $$),
          arr(1, 5, $$),
          arr(2, 6, $$),
          arr(3, 7, $$),
          arr(4, 8, $$),)]
          对 $n$ 做归纳，利用蛇形引理可以验证 $alpha_n$ 是单射/满射，对 $alpha_n$ 取逆向极限结合两者都是满射系统知结论成立
        ]
        取 $G(M)$ 的齐次生成元 $xi_i = overline(x_i), x_i in M_(n_i)$，希望证明 $x_i$ 就是 $M$ 的生成元

        取：
        $
        F = directSum_i F^i where F^i = A, F^i_k = I^(k + n_i)
        $
        定义 $phi: F -> M, phi(1_i) = xi_i$，则 $G(phi)$ 是满射，由引理 $hat(phi)$ 是满射，有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $F$, 1),
        node((0, 1), $M$, 2),
        node((1, 0), $hat(F)$, 3),
        node((1, 1), $hat(M)$, 4),
        arr(1, 2, $$),
        arr(1, 3, $$),
        arr(2, 4, $$),
        arr(3, 4, $$),)]
        注意到 $A$ 完备，$M$ Hausdoff，则 $M -> hat(M)$ 是单射。同时由于 $F$ 是有限自由模，可以验证：
        $
        F tilde.eq inverseLimit F quo I^n F tilde.eq hat(F)
        $
        （将 $F$ 拆成 $A$ 的直和结合 $A$ 的完备性）\
        再结合 $hat(phi)$ 的满射性，追图即得 $phi$ 也是满射。

        对于第二个结论，证明 $M$ 的任意子模 $M'$ 是有限生成即可。令：
        $
        M'_n = M' sect M_n
        $
        可以验证 $M'_n quo M'_(n+1)$ 可以嵌入 $M_n quo M_(n+1)$，而后者是诺特模，前者也是，利用第一个结论即可
      ]
      有了上面的命题，原结论是容易的。事实上，$G(A) tilde.eq G(hat(A))$ 根据上面的命题是诺特的，而 $hat(A)$ 是完备的 Hausdoff 空间，因此由上面的命题 $hat(A)$ 是诺特的。
    ]
= 维数理论 | Dimension theory
  == 维数
    #definition[height, dimension][
      设 $A != 0$ 是环
      - 设 $p$ 是素理想，定义 $ht(p)$ 为最大的 $n$ 可以构成一个素理想升链 $p_0 = p < p_1 < ... <p_n$，它也就是 $dim A_p$
      - 设 $I$ 是理想，定义 $ht(I) = inf(ht(V(I)))$
      - 定义 $dim A = sup_(p in Spec(A)) ht(p)$
      - 设 $M$ 是 $AModule(A)$，定义 $dim M := dim A quo Ann(M)$
    ]
    #proposition[][
      $dim A quo I + ht(I) <= dim A$
    ]
    #proof[
      由定义显然
    ]
    #theorem[][
      设 $A$ 是诺特环，$M$ 是有限生成模，则以下条件等价：
      - $M$ 是有限长度的
      - $A quo Ann(M)$ 是 Artin 环
      - $dim M = 0$
    ]
    #proof[
      在@chain-cond 已经证明了
    ]
  == 整值多项式
    接下来的主要目标是，设 $(A, m)$ 是诺特的局部环，我们将找到一个多项式 $x_m^A (n)$ 使得：
    - $dim A = deg x_m^A (n)$
    - $n$ 充分大时，有 $x_m^A (n)$ 就是 $A quo m^n$ 的长度
    这部分内容也可参考 Serre, local Algebra
    #lemma[][
      设:
      - $Q_k (x) = C_x^k = (x (x-1) ... (x - k + 1))/(k!)$
      - $Delta f(n) = f(n + 1) - f(n)$
      则可以证明 $Delta Q_(k+1) = Q_k$，且设 $f$ 是有理系数多项式，则以下条件等价：
      + $f(x) = sum_i a_i Q_(i) (x)$
      + $f(ZZ) subset ZZ$
      + $f(n) subset ZZ, n in ZZ$ 充分大
      + $Delta f (ZZ) subset ZZ andC exists n_0, f(n_0) in ZZ$
      成立时，称 $f$ 是取整值的多项式|integer-valued polynomial，并称 $e_i (f) := a_i$ 是展开系数，并有容易的等式：
      $
      Delta f = sum_i a_i Q_(i-1) => e_(i-1) (Delta f) = e_i (f)
      $
    ]
    #proof[
      - $2 => 1$ 由于 $Q_i$ 次数逐渐上升，自然构成 $QQ-$线性空间的基，因此先可设：
        $
        f = sum_i e_i Q_i
        $
        再不断差分可以证明 $e_i$ 都是整数
      - $4 => 2$ 显然
      - $3 => 1$ 利用归纳法，差分和 4 即可 
    ]
    #definition[][
      设 $f: NN -> ZZ$ ，称 $f$ 是类多项式|polynomial like 的，如果存在多项式 $p(x)$ 使得 $n$ 充分大时有：
      $
      f(n) = p(n)
      $
    ]
    #lemma[][
      以下条件等价：
      - $f$ 是类多项式
      - $Delta f$ 是类多项式
      - 存在 $l > 0$ 使得 $Delta^l f(n) = 0, forall n$ 充分大 
    ]
  == 庞卡莱序列
    #definition[庞卡莱序列][
      设 $A = directSum_i A_i$ 是诺特的分次环，每个 $A_n$ 都诺特。$M$ 是分次的有限生成 $A-$模，$lambda$ 是有限 $A_n-$模 $-> ZZ$ 的加性函数，定义 $M$ 的庞卡莱序列为：
      $
      P(M, t) = sum_(n >= 0) (-1)^n  lambda (M_n) t^n
      $
    ]
    #theorem[][
      $P(M, t)$ 是有理函数，且：
      $
      P(M, t) = (f(t))/(product_(i = 1)^s (1 - t^(k_i))), f(t) in ZZ[x]
      $
      定义 $d(M)$ 为这个函数 $P(M, t)$ 在 $t = 1$ 处极点的阶数\
      其中 $s$ 是 $A$ 作为 $A_0$ 代数的齐次生成元的个数，$k_s$  在证明中给出
    ]
    #proof[
      对 $s$ 进行归纳
      - $s = 0$ 时结论显然成立（既然形式幂级数 $P(M, t)$ 仅有有限项）
      - 一般的，考虑：
        $
        M_n ->^(x_s) M_(n + k_s)
        $
        当然 $k = deg x_s$，产生正合列：
        $
        0 -> K_n -> M_n -> M_(n + k) -> L_(n+k) -> 0
        $
        其中 $K_n, L_n$ 分别是 $ker, coker$\
        令 $K = directSum K_n, L = directSum L_n$，则 $K, L$ 被 $x_s$ 零化，进而成为 $A_0 [x_1, ..., x_s]$ 上的模。由归纳假设 $P(K, t), P(L, t)$ 都是定理形式的有理函数。\
        对正合列取庞卡莱序列，有：
        $
        
        sum_n lambda(K_n) t^(n + k_s) - sum_n lambda(M_n) t^n + sum_n lambda(M_(n + k_s)) t^n - sum_n lambda(L_(n + k_s)) t^(n + k_s) = 0
        
        $
        化简即得结论。
    ]
    #corollary[希尔伯特多项式][
      若证明过程中 $k_1 = k_2 = ... = k_s = 1$，则 $P(M, t) = (f(t))/(1-t)^s$，进而 $n -> lambda(M_n)$ 是 $d(M) - 1$ 次的类多项式。这个多项式称为 $M$ 的希尔伯特多项式
    ]
    #proof[
      第一条是直接推论。对于第二条注意到根据定义 $lambda(M_n)$ 就是 $P(M, t) = f(t)/(1-t)^s$ 的 $n$ 次项系数。无妨设 $f(t), 1 - t$ 互素，否则约去令 $s$ 更小即可。作展开：
      $
      f(t)/(1-t)^s = f(t) (1 + t + ...)^s := (sum_(k=0)^N a_k t^k)(1 + t + ...)^s
      $
      可以计算得当 $ n> N$ 时，将有：
      $
      
      lambda(M_n) = sum_(k = 0)^N a_k C_(s + n - k + 1)^(s - i)
      
      $
      确实是关于 $n$ 的多项式，且次数是 $d - 1$，证毕
    ]
    #proposition[][
      设 $x in A_k$ 不是 $M$ 的零因子（$m in M, x m = 0 => m = 0$），则：
      $
      d(M quo x M) = d(M) - 1
      $
    ]
    #proof[
      根据 $M_n ->^x M_(n+k)$ 构造正合列：
      $
      0 -> K_n -> M_n ->^x M_(n+k) -> L_(n+k) -> 0
      $
      将有：
      $
      P(M quo x M, t) = P(M, t) -t^k P(M, t) + r(t)
      $
      显然极点的阶刚好降低一，证毕
    ]
    #example[][
      设 $A_0$ 是 Artin 环，$A = A_0 [x_1, ..., x_s]$，则恰有 $d(A) = s$\
      这是因为：
      - $A_n$ 是自由 $A_0$模，生成元集为所有 $n$ 次单项式，作为自由模的维数是 $C_(n + s -1)^(s - 1)$
      - 可以计算得：
        $
        P(A, t) = lambda(A_0) + lambda(A_1) t + ... = 1/(1 -t)^s
        $
    ] 
    #proposition[][
      假设 $(A, m)$ 是诺特的局部环，$q$ 是理想且 $sqrt(q) = m$（往往就取 $q = m$）, $M$ 是有限生成 $A-$模，$M_n$ 是稳定 $q-$filtration，则：
      - $M quo M_n$ 有限长度
      - $n -> "length"(M quo M_n)$ 是不超过 $s$ 次类多项式，其中 $s$ 是 $q$ 最少的生成元个数
      - 上面多项式的次数和首项系数与 $q$ 无关，只与 $M$ 有关
      该多项式称为特征多项式
    ]
    #proof[
      - 令 $G(A) = directSum_n q^n quo q^(n+1)$，则由极大理想幂零 $G_n$ 是 Artinian Noetherian 局部环，$G(M)$ 是有限生成 $G(A)$ 模，且每一项都是 Artinian Noethenian 模，因此 $M_n$ 有限长度，$M quo M_n$ 也有限长度。
      - 由上题结论，$n -> l(M_(n - 1) quo M_n)$ 是类多项式函数，次数不超过 $s - 1$，求和得 $n -> l(M quo M_n)$ 也是类多项式，次数不超过 $s$，表明结论正确
      - 之前证明了两个稳定 $q-$filtration 互相控制，因此 $n$ 充分大时对应多项式也相互控制，进而首项应该都是一样的
    ]
  #corollary[][
    $deg kai_q (n) = deg kai_m (n)$ 且首项相等
  ]
  #proof[
    注意到：
    $
    m subset q subset m^r\
    m^n subset q^n subset m^(r n)
    $
    由长度的定义可得：
    $
    kai_m (n) <= kai_q (n) <= kai_m (r n)
    $
    令 $n -> infinity$ 可得结论
  ]
  #definition[][
    设 $A$  是诺特的局部环，则令：
    $
    d(A) = deg kai_q (n) = deg kai_m (n) = deg( n -> "length"(A quo m^n)) = d(G_m (A))\
    where G_m (A) = directSum (m^i quo m^(i+1))
    $

  ]
  == 诺特局部环的维度
    #definition[][
      设 $A$  是诺特的局部环，令 $delta(A)$  为 $A$  中 $m-$ primary 理想的最小生成元数量。
    ]
    本节的目标是：
    $
    delta(A) = d(A) = dim (A)
    $
    为此，我们证明：
    $
    delta(A) >= d(A) >= dim (A) >= delta(A)
    $
    #proposition[][
       设 $M$  是有限生成 $A-$ 模，$x$ 不是零因子，则：
       $
       deg kai_q^(M quo x M) <= deg kai_q (M) - 1
       $
    ]
    #proof[
      令 $N := x M$，作为 $AModule(A)$  同构于 $M$\
      再令 $M' = M quo x M$\
      由 @Artin-Rees 可知 $N_n = N sect q^n M$  是稳定 $q-$filtration\
      由正合列：
      $
      0 -> N quo N_n -> M quo q^n M -> M' quo q^n M' -> 0
      $
      由长度的加性，$n$ 充分大时有：
      $
      l(N quo N_m) - kai_q^M (n) + kai_q^M' (n) = 0
      $
      既然 $N$  与 $M$  同构且 $q-$filtration 兼容，$l(N quo N_m), kai_q^M (n)$  有相同的次数和首项，因此 $kai_q^M' (n)$  必然比其至少低一次
    ]
    #proposition[][
      $d(A) >= dim(A)$
    ]
    #proof[
      做归纳：
      - 若 $d(A) = 0$，则 $n$ 充分大时 $A quo m^n$ 的长度的常值，继而：
        $
        l(m^n quo m^(n+1)) = 0
        $
        注意到它是 $A quo m$ 上的向量空间，因此 $m^n = m^(n+1)$,这是标准的 Artin 条件，故 $A$ 是 Artin 的，$dim A = 0$
      - 一般的，任取素理想升链：
        $
        p_0  < ... < p_l
        $
        取 $x in p_1 - p_0, A' = A quo p_0$ 是整环，继而由之前的命题：
        $
        d(A' quo x) <= d(A') - 1
        $
        注意到 $A quo m^n$ 到 $A' quo m'^n$ 存在满射，因此：
        $
        l(A quo m^n) >= l(A' quo m'^n)\
        d(A) >= d(A') >= d(A' quo x) + 1
        $
        由归纳假设，有：
        $
        d(A' quo x)>= dim (A' quo x)
        $
        然而由最开始的素理想升链可得 $dim(A' quo x')$ 不小于 $dim A - 1$，结合上式即得结论
    ]
    #corollary[][
      - $dim(A)$ 有限
      - 对于一般的诺特环 $A$，每个素理想的降链都有限长
    ]
    #proposition[][
      设 $A$ 是诺特的局部环，$dim A = d$，则存在 $m-$primary 理想恰有 $d$ 个生成元。换言之，$delta(A) <= d$
    ]
    #proof[
      归纳构造 $x_i$ 使得每个包含 $(x_1, x_2, ..., x_i)$ 的素理想的 height 都至少为 $i$\
      假设 $x_1, ..., x_(i-1)$ 已经构造，令 $p_j$ 是包含 $(x_1, ..., x_(i-1))$ 的极小素理想且高度恰为 $i -1$，也就是 $Ass(A quo (x_1, ..., x_(i-1)))$ 中极小元（仅有有限个）\
      既然 $i - 1< d = dim A$ 而 $m$ 的高度就是 $d$，因此 $p_j$ 不是 $m$，取 $x_i in m - union p_j$\
      设 $q$ 是任意包含 $(x_1, ..., x_i)$ 的素理想，则 $q$ 包含某个包含 $(x_1, ..., x_(i-1))$ 的极小素理想 $p$
      - 若 $p = p_j$，则 $x_i in q - p$ 表明 $p subset.neq q$，表明 $q$ 的高度至少是 $p$ 的高度加一，结论成立
      - 否则，由于刚才取得了所有高度为 $i - 1$ 的极小素理想，$p$ 的高度至少为 $i$，继而 $q$ 也至少有高度 $i$
    ]
    #theorem[Dimension][
      对于诺特的局部环 $A$，以下三个整数相等：
      - 最大素理想升链的长度
      - 特征多项式 $l(A quo m^n)$ 的次数
      - $m-$primary 理想的最少生成元个数
    ]
    #proof[
      $delta(A) >= d(A)$ 是上节的主要结论，其余便是本节的结论。
    ]
    #example[][
      之前证明了多项式环的幂级数是 $1 / (1-t)^n$ ，因此它的维度也是 $n$
    ]
    #corollary[][
      设 $A$ 是诺特的局部环，$k$ 是留域，则 $dim A <= dim_k m quo m^2$
    ] 
    #proof[
      取 ${x_i} subset m$ 使得它们的像构成 $m quo m^2$ 的一组基，此时 $x_i$ 必然生成 $m$（利用 Nakayama 引理的推论 @basis-is-generator-Nakayama），因此有：
      $
      dim A = delta(A) <= dim_k m quo m^2
      $
    ]
    #corollary[][
      设 $A$ 是不一定局部的诺特环，$x_1, ..., x_r in A$，则每个包含 $x_1, ..., x_r$ 的极小素理想的高度都不大于 $r$
    ]
    #proof[
      设 $p$ 是包含这些元素的极小素理想，在 $A_p$ 中当然有：
      $
      sqrt((x_1, ..., x_r)) = p A_p
      $
      表明：
      $
      r >= delta(A_p) = dim A_p = "height"(p)
      $
    ]
    #theorem[Krull's principal ideal theorem][
      设 $A$ 诺特，$x$ 不是单位或零因子，$p$ 是包含 $x$ 的极小素理想，则 $p$ 的高度就是 $1$
    ]
    #proof[
      由上面的引理，$p$ 的高度只能为零或一
      - $"height" (p) = 0$，书上的 primary decomposition 章节证明了这样的素理想（也就是环上的极小素理想）其中每个元素都是零因子，与 $x in p$ 是矛盾的
      因此只能为 $1$
    ]
    #corollary[][
      $dim A = dim hat(A)$
    ]
    #proof[
      注意到：
      $
      A quo m^n tilde.eq hat(A) quo hat(m)^n
      $
      当然特征多项式是一致的
    ]
    #definition[][
      设 $A$ 是诺特局部环，$d = dim A$， 若 $sqrt((x_1, ..., x_d)) = m$，则称 $x_1, ..., x_d$ 是一个参数系统|system of parameters
    ]
    #proposition[][
      设 $q = (x_1, ... x_d)$ 是参数系统，$f(t_1, ..., t_d)$ 是 $s$ 次齐次多项式，且系数落在 $q^(s + 1)$ 中，则这些系数也落在 $m$ 中
    ]
    #proof[
      考察：
      $
      funcDef(phi, A quo q [t_1, ..., t_d], G_q (A),t_i, x_i)
      $
      容易验证它是满射\
      假设 $f$ 有系数不在 $m$ 中，由前面的习题有 $phi(f)$ 不是零因子，将有：
      $
      d(A) = d(G_m (A)) <= d( (A quo q [t_1, ..., t_d]) quo (phi(f))) <= d (A quo q [t_1, ..., t_d]) - 1 = d - 1
      $
      矛盾！

    ]
    #corollary[][
      设 $k = A quo m subset A, x_1, ..., x_d$ 是参数系统，则 $x_1, ..., x_d$ 代数独立
    ]
    #proof[
      假设有这样的多项式 $f$，取出其中最低非零次 $s$ 齐次部分 $f_s$，断言：
      $
      f_s (x_1, ..., x_d) = 0 in q^s quo q^(s+1), q = (x_2, ..., x_d)\
      $
      由上面的引理，$f_s$ 的系数全在 $m$ 中，与假设矛盾！ 
      
    ]
    #definition[Regular Local Ring][
      设 $A$ 是诺特的局部环，$dim A = d, m$ 是极大理想，$k = A quo m $，若以下等价条件成立：
      - $G_m (A) tilde.eq k[t_1, ..., t_d]$
      - $dim_k m quo m^2 = d$
      - $m$ 可被 $d$ 个元素生成
    ]
    #proof[
      - 1 $=>$ 2 容易验证
      - 2 $=>$ 3 @basis-is-generator-Nakayama
      - 3 $=>$ 1 前面定义了典范的满射 $k[x_1, ..., x_n] -> G_m (A)$，由上一个命题的代数独立性这里 $ker$ 为零，继而是同构
    ]
    #lemma[][
      设 $A$ 是环，$I$ 是理想且 $sect I^n = 0$，假设 $G_I (A)$ 是整环，则 $A$ 是整环
    ]
    #proof[
      任取 $x, y != 0$，取最大的 $r, s$  使得：
      $
      x in I^r\
      y in I^s
      $
      则 $x y$ 在 $G_I (A)$ 中的像非零，当然就有 $x y != 0$
    ]
    #corollary[][
      - Regular Local Ring 是整的
      - Regular Local Ring 是整闭的
    ]
    #proof[
      - $k[t_1, .., t_d]$ 当然是整环，由 @Krull 知必有 $sect m^n = 0$，因此由上面的引理知结论成立。
      - $dim = 1$ 时，由于离散赋值环等价于切空间 $m quo m^2$ 恰为一维，故结论成立。一般的证明略。
    ]
    #proposition[][
      $A$ regular $<=> hat(A)$ regular
    ]
    #proof[
      注意到 $G_m (A) = G_(hat(m)) (hat(A))$，结论显然
    ]
    #corollary[][
      设 $A$ 是 regular local ring ,$k = A quo m subset A$ ，则 $hat(A)$ 同构于 $k[[t_1, ..., t_d]]$
    ]
= 同调代数
  == 回顾
    #definition[Abel 范畴][
      称范畴 $AA$ 是 Abel 范畴，如果 $Hom_AA (A, B) in Ob(AA)$ 且其上有 Abel 群结构，并满足分配律：
      $
      h(g + g') f = h g f + h g' f\
      forall h in Hom_AA (B, \*), f in Hom_AA (\*, A)
      $
    ]
    #definition[加性函子][
      称 Abel 范畴 $AA, BB$ 间的函子 $F: AA -> BB$ 是加性函子，如果对于任意 $A, B in AA$，$F$ 保持 $Hom$ 的加法结构（是加法群同态）
    ]
    本学期由于时间原因，不能详细讲解 Abel 范畴，但所幸有下面的定理：
    #theorem[Frey-Miichell embedding][
      设 $CC$ 是 Abel 范畴，则存在全忠实的正合函子将 $CC$ 嵌入某个环上的模范畴
    ]
    #definition[chain complex][
      设：
      $
      X = ... -> X_(k + 1) ->^(d_(k+1)) X_k ->^(d_k) X_(k-1) -> ...
      $
      并记：
      - $Z_k (X) = ker d_k$
      - $B_k (X)= im d_(k+1)$
      若成立 $0 subset B_k subset Z_k subset X_k$，则称之为一个链复形，并记：
      $
      H_n (X) = Z_n quo B_n
      $
      称为第 $n$ 个同调模。可以证明，$H_n$ 具备函子性
    ]
    #definition[cochain complex][
      设：
      $
      X = ... -> X^(k - 1) ->^(d^(k-1)) X^(k) ->^(d^(k)) X^(k+1) -> ...
      $
      并记：
      - $Z^k (X) = ker d^(k)$
      - $B^k (X)= im d^(k-1)$
      若成立 $0 subset B^k subset Z^k subset X^k$，则称之为一个链复形，并记：
      $
      H^n (x) = Z^n quo B^n
      $
      称为第 $n$ 个同调模。可以证明，$H^n$ 具备函子性
    ]
    #definition[][
      chain/cochain 之间可以定义同态，要求同态与 $d_n$（也被称为差分）可交换。进一步，构成 Abel 范畴，记作 $CC$
    ]
    #remark[Singular Complex functor][
      可以定义从拓扑空间的范畴 $"Top"$ 到 $Mod_ZZ$  上链复形的函子：
      $
      "ZSing"_n (X) = ZZ[Hom (abs(Delta^n), X)]
      $
      其中：
      - $abs(Delta^0) = $ 单点
      - $abs(Delta^1) = 0, 1$ 线段
      - $abs(Delta^2) = $ 三角形
      - ...
      下降的态射是对边界求和 
    ]
    #definition[分裂][
      设有链复形：
      $
      .. ->^d X^(k-1) ->^d X^k ->^d X^(k+1) ->^d ...
      $
      且存在态射 $s: X^(n) -> X^(n-1)$ 使得：
      $
      d = d s d
      $
      则称复形分裂。
    ]
    #definition[同伦|homotopic][
      - $f, g : X -> Y$ 是两个链复形之间的同态。称 $f, g$ 同伦，记作 $f tilde g$，如果存在 $s^n: X^n -> Y^(n-1)$ 使得以下交换图表成立：
        #align(center)[#commutative-diagram(
        node((0, 0), $X^n$, 1),
        node((0, 1), $X^(n+1)$, 2),
        node((1, -1), $Y^(n-1)$, 3),
        node((1, 0), $Y^n$, 4),
        arr(1, 2, $$),
        arr(1, 3, $s^n$),
        arr(2, 4, $s^(n+1)$),
        arr(3, 4, $$),
        arr(1, 4, $f^n - g^n$)
        )]
        等价的，就是：
        $
        f - g = d_Y s + s d_X
        $
      - 称 $X ->^f Y$ 是同伦等价的，如果存在 $h: Y -> X$ 使得 $h compose f tilde id, f compose h tilde id$，此时也称 $X$ 与 $Y$ 同伦等价或 $X tilde Y$
    ]
    #lemma[][
      - 设 $f tilde g$，则 $H^k (f) = H^k (g)$
      - 设 $X tilde Y$，则 $H^k (X) = H^k (Y)$
      - 加性函子保持同伦性
      - 链复形分裂当且仅当 $id$ 与零同伦
    ]<homotopic-equivalence>
    #proof[
      - 等价于 $H^k (f - g) = 0$，注意到：
        $
        f tilde g <=> f - g tilde 0
        $
        因此不妨就设 $g = 0, f tilde 0$，往证 $H^k (f)= 0$\
        由定义，有：
        $
        f^n = s^(n+1) d_X^n + d_Y^(n-1) s^n
        $
        注意到:
        $
        f^n (ker d_X^n) = d_Y^(n-1)(s^n (ker d_X^n)) subset im d_Y^(n-1)\
        $
        由定义：
        $
        H^n (f) : ker (d_X^n) quo im(d_X^(n-1)) -> ker (d_Y^n) quo im(d_Y^(n-1))
        $
        由上面的计算，这意味着 $H^n (f) = 0$，证毕
      - 同理
      - 同伦无非是等式，当然被加性函子保持
      - 定义验证即可
    ]

    #definition[][
      设 $F$  是两个 Abel 范畴间的函子，它自然诱导了 Abel 范畴上复形的函子。
      - 若 $F$  将短正合列映到短正合列，则称 $F$  是正合函子。这也等价于保持 $ker, im, coker, coim$  或者等价于保持有限极限/余极限。当然由保持 $ker, im$ 可以推出它保持同调群。
    ]
    #proposition[][
      - $Hom(X, *)$ 是左正合函子。它正合时称 $X$  为投射对象，等价于将任何满同态|eqimorphism $Y -> Z$ 作用得到满同态 $Hom(X, Y) -> Hom(X, Z)$
      - $Hom(*, Y)$ 是反变左正合函子。它正合时称 $Y$  为内射对象，等价于将任何单同态|monomorphism $Y -> Z$ 作用得到满同态 $Hom(Z, Y) -> Hom(Y, Y)$
    ]
    #example[][
      - $QQ quo ZZ$ 是 Abel 群范畴中的内射对象
      - 设 $R$ 是环，则$Hom_("abel")(R, Q quo ZZ)$  是内射 $R-$ 模
      - $M$ 是平坦模当且仅当 $Hom_("abel") (M, QQ quo ZZ)$  是内射 $R-$ 模（利用伴随关系）
    ]
    #proposition[短正合列诱导长正合列][
      设有复形间正合列：
      $
      0 -> X -> Y -> Z -> 0
      $
      则有长正合列：
      $
      ... &-> H^(n-1) (X) -> H^(n-1) (Y) -> H^(n-1) (Z) \
          &-> H^n (X) -> H^n (Y) -> H^n (Z)\
          &->^delta H^(n+1) (X) -> H^(n+1) (Y) -> H^(n+1) (Z) -> ...
      $
      进一步，这个长正合列是典范的（具有函子性），也即若两个复形正合列之间有同态，则它们诱导的长正合列之间也有诱导的同态。
    ]<short-exact-sequence-induced-long-exact-sequence>
    #proof[
      我们希望利用蛇形引理。对：
      $
      0 -> &X^n -> &&Y^n -> &&Z^n -> 0\
      0 -> &X^(n+1) -> &&Y^(n+1) -> &&Z^(n+1) -> 0
      $
      之间利用蛇形引理，得到正合列：
      $
      0 -> ker d_X^n -> ker d_Y^n -> ker d_Z^n -> coker d_X^n -> coker d_Y^n -> coker d_Z^n  -> 0
      $
      进而得到两个正合列正合列：
      $
      coker d_X^(n-1) -> coker d_Y^(n-1) -> coker d_Z^(n-1) -> 0\
      0 -> ker d_X^(n + 1) -> ker d_Y^(n + 1) -> ker d_Z^(n + 1) 
      $
      事实上，注意到：
      $
      im d_X^(n-1) subset ker d_X^(n)
      $
      因此 $d_X^(n)$ 自然诱导 $coker d_X^(n-1) = X^(n) quo im d_X^(n-1) -> im d_X^n subset ker d^(n+1)_X$ 的同态，且容易验证这些同态与蛇形引理诱导出的正合列交换，也即有交换图：
      #align(center)[#commutative-diagram(
      node((0, 1), $coker d_X^(n-1) $, 2),
      node((0, 2), $coker d_Y^(n-1)$, 3),
      node((0, 3), $coker d_Z^(n-1)$, 4),
      node((0, 4), $0$, 5),
      node((1, 0), $0$, 6),
      node((1, 1), $ker d_X^(n + 1)$, 7),
      node((1, 2), $ker d_Y^(n + 1)$, 8),
      node((1, 3), $ker d_Z^(n + 1)$, 9),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(4, 5, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(8, 9, $$),
      arr(2, 7, $$),
      arr(3, 8, $$),
      arr(4, 9, $$),
      )]

      再次利用蛇形引理，并注意到：
      $
      ker (coker d_X^(n-1) -> ker d_X^(n + 1)) \
      = ker (d_X^n: coker d_X^(n-1) -> ker d_X^(n + 1)) = (ker d_X^n) quo im d_X^(n-1) = H^n (X)\
      coker (coker d_X^(n-1) -> ker d_X^(n + 1)) \
      = coker (d_X^n: coker d_X^(n-1) -> ker d_X^(n + 1)) = (ker d_X^(n+1)) quo im d_X^n = H^(n+1) (X)

      $
      
      得到的结果便是:
      $
      H^n (X) -> H^n (Y) -> H^n (Z) -> H^(n+1) (X) -> H^(n+1) (Y) -> H^(n+1) (Z)
      $
      对所有 $n$ 都成立，连接起来就是所求的长正合列，证毕
    ]
  == Mapping Cones and Cylinders（补充）
    #definition[][
      设 $f: X -> Y$ 是链复形之间的态射，定义新的复形：
      $
      ... -> X_(n-1) directSum Y_n ->^(d_n) X_(n-2) directSum Y_(n-1) -> ...
      $
      其中 $d_n$ 定义为：
      $
      vec(x_(n-1), y_n) -> mat(-d^X_(n - 1), 0;-f, d^Y_n) vec(x_(n-1), y_n)
      $
      称为 $f$ 的映射锥（mapping cone）$cone(f)$
      对偶的，定义 cochain 上上的复形：
      $
      ... -> X^(n+1) directSum Y^n ->^(d^(n)) X^(n+1) directSum Y^(n) -> ...
      $
    ]
  == 解消
    #example[][
      之前定义过投射对象/内射对象。在 $ZZ$ 和除环中，投射对象就是自由模，一般而言未必。在所有有限交换群构成的范畴中，没有投射对象。
    ]
    #lemma[][
      - 投射对象是自由模的直和项。投射对象的直和仍然投射
      - 内射对象的直积仍然是内射对象
    ]
    #lemma[][
      在主理想整环 $R$ 上，$A$ 是内射模当且仅当可除，也即对于任意 $r !=0 in R, r A = A$ 
    ]<injective-divisible>
    #definition[Resulution][
      设 $A in CC$  是一个对象
      - 一个 $A$  的内射解消是指复形：
        $
        I^* := 0 -> I^0 -> I^1 -> I^2 -> ...
        $
        其中 $I^i$ 都是内射对象，且：
        $
        0 -> X -> I^0 -> I^1 -> I^2 -> ...
        $
        是正合列，等价于 $H^0 (I^*) = X, H^i (I^*) = X, forall i > 0$\
      - 一个 $A$  的投射解消是指复形：
        $
        P^* := ... -> P^(-2) -> P^(-1) -> P^0 -> 0
        $
        其中 $P^i$ 都是投射对象，且：
        $
        ... -> P^(-2) -> P^(-1) -> P^0 -> A -> 0
        $
        是正合列，等价于 $H^0 (P^*) = A, H^i (P^*) = 0, forall i < 0$


      - 若 $CC$  中每个对象可以嵌入一个内射对象，则称 $CC$  有足够多的内射对象
      - 若 $CC$  中每个对象都存在投射对象映满到它，则称 $CC$  有足够多的投射对象
    ]
    #lemma[][
      - 假设 $CC$ 有足够多的内射对象，则任意对象 $X in CC$  都有一个内射解消
      - 假设 $CC$ 有足够多的投射对象，则任意对象 $X in CC$  都有一个投射解消
    ]
    #lemma[][
      - $Mod_R$ 有足够多的内射对象
      - $Mod_R$ 有足够多的投射对象
    ]
    #proof[
      - 利用 $Hom (R, QQ quo ZZ)$ 的内射性
      - 在任意模上构造自由模即可
    ]
    #proposition[][
      设 $CC$ 是 Abel 范畴，假设有正合列：
      $
      0 -> A -> A^0 -> A^1 -> ...
      $
      复形：
      $
      0 -> B -> I^0 -> I^1 -> ...
      $
      映射：
      $
      f: A -> B
      $
      则存在交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $0$, 1),
      node((0, 1), $A$, 2),
      node((0, 2), $A^0$, 3),
      node((0, 3), $A^1$, 4),
      node((1, 0), $0$, 5),
      node((1, 1), $B$, 6),
      node((1, 2), $I^0$, 7),
      node((1, 3), $I^1$, 8),
      node((0, 4), $...$, 9),
      node((1, 4), $...$, 10),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(5, 6, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(1, 5, $$),
      arr(2, 6, $f$),
      arr(3, 7, $f^0$),
      arr(4, 8, $f^1$),
      arr(4, 9, $$),
      arr(8, 10, $$),
      )]
      且所有这样的延拓都是同伦的
    ]<morphism-extension>
    #proof[
      首先注意到 $A -> A^0$ 是单射，由内射对象的性质 $f^0$ 是存在的。\
      归纳构造，假设 $f^i: A^i -> I^i, i = 0, 1, ..., n - 1$ 已经构造好，注意到由正合性，有单态射：
      $
      coker(A^(n-2) -> A^(n-1)) -> A^n
      $
      其次，注意到：
      $
      A^(n-2) -> A^(n-1) -> I^(n-1) -> I^n\
      = A^(n-2) -> I^(n-2) -> I^(n-1) -> I^n = 0
      $
      因此有自然的态射：
      $
      coker(A^(n-2) -> A^(n-1)) -> I^n
      $
      由内射性质立得 $A^n -> I^n$ 态射，存在性证毕

      假设还有另一种延拓 $g$，记 $I^(-1) = 0$，首先要构造下图中的 $h_0$ ：
      #align(center)[#commutative-diagram(
      node((0, 0), $$, 1),
      node((0, 1), $A^0$, 2),
      node((0, 2), $A^1$, 3),
      node((1, 0), $I^(-1)$, 4),
      node((1, 1), $I^0$, 5),
      node((1, 2), $I^1$, 6),
      arr(2, 4, $0$),
      arr(3, 5, $h_0$),
      arr(2, 3, $$),
      arr(4, 5, $$),
      arr(5, 6, $$),
      arr(2, 5, $$),
      arr(3, 6, $$),)]
      注意到 $(f^0 - g^0) compose (A -> A^0) = A -> B -> I^0 - A -> B -> I^0 = 0$，因此可将 $f^0 - g^0$ 延拓到 $A^0 quo A -> I^0$，又由正合性，$A^0 quo A$ 嵌入 $A^1$，内射性产生我们需要的 $h_0$，之后的构造是类似的。
    ]
    #corollary[][
      任意两个内射解消是同伦等价的
    ]<injection-resolution-eqvi>
    #proof[
      假设有两个内射解消 $I, J$ 则有正合列间同态 $f: I -> J$ 和 $g: J -> I$ 都是 $id_A$ 的延拓。注意到 $g compose f$ 成为 $I -> I$ 的同态且是 $id_A$ 的延拓，而 $id$ 是 $I -> I$ 延拓 $id_A$ 的自然同态，唯一性给出 $g compose f tilde id$，另一个方向类似，因此有 $I tilde J$
    ]
  == 余调 $delta-$函子，导出函子
    #definition[$delta-$函子][
      一个  homological $delta-$ functor 是一族函子 $T_i, i in NN$ 以及连接同态 $delta_i: T_i (C) -> T_(i-1) (A)$，使得：
      - 对于任何短正合列 $0 -> A -> B -> C -> 0$ 有长正合列：
        $
        ... -> T_i A -> T_i B -> T_i C ->^(delta_i) T_(i-1) A -> T_(i-1) B -> T_(i-1) C -> ...
        $
      - 这个长正合列是典范的，也即短正合列间的同态诱导对应长正合列的同态
      一个  Cohomological $delta-$ functor 是一族函子 $T_i, i in NN$ 以及连接同态 $delta^i: T^i (C) -> T^(i+1) (A)$，使得：
      - 对于任何短正合列 $0 -> A -> B -> C -> 0$ 有长正合列：
        $
        ... -> T^i A -> T^i B -> T^i C ->^(delta^i) T^(i+1) A -> T^(i+1) B -> T^(i+1) C -> ...
        $
      - 这个长正合列是典范的，也即短正合列间的同态诱导对应长正合列的同态
    ]
    我们的目标是对于一般的函子/加性函子/左正合/右正合函子，能否构造出以其为开始的余调 $delta-$函子，这些函子就是前面提到过的导出函子。
    #lemma[][
      设有两个关于 $A, B$ 的内射解消：
      $
      0 -> A -> I^0 -> I^1 -> I^2 -> ...\
      0 -> B -> J^0 -> J^1 -> J^2 -> ...
      $
      只要存在 $A -> B$ 的同态，便可以延拓成正合列的同态。若该同态是同构，则两个正合列同伦等价。
    ]
    #definition[（右）导出函子][
      设 $CC$ 有足够多的内射对象， $F$ 是左正合函子， $X in CC$，找到一个 $X$  的内射解消，也就是正合列：
      $
      0 -> X -> I^0 -> I^1 -> I^2 -> ...
      $
      定义：
      $
      R^n F(X) = H^n (F(I^*))\
      $
      给出一个与内射解消的选取无关的函子，称为 $F$ 的右导出函子。
    ]
    #proof[
      - 由 @injection-resolution-eqvi 和 @homotopic-equivalence 知，这个定义是良定义的。
      - 我们还要验证 $R^n F$ 确实具有函子性。对于任意 $A ->^f B$，有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $I_A$, 2),
        node((1, 0), $B$, 3),
        node((1, 1), $I_B$, 4),
        arr(1, 2, $$),
        arr(1, 3, $f$),
        arr(2, 4, $f^*$),
        arr(3, 4, $$),)]
        其中 $f^*$ 来自于 @morphism-extension
    ]
    #lemma[Horse shoe][
      设 $0 -> A -> B -> C -> 0$ 是短正合列，并有内射解消：
      $
      A -> I\
      C -> J
      $
      则存在正合序列：
      $
      0 -> B -> I directSum J
      $
      使得下图交换：
      #align(center)[#commutative-diagram(
      node((0, 0), $0$, 1),
      node((0, 1), $A$, 2),
      node((0, 2), $B$, 3),
      node((0, 3), $C$, 4),
      node((1, 0), $0$, 5),
      node((1, 1), $I$, 6),
      node((1, 2), $I directSum J$, 7),
      node((1, 3), $J$, 8),
      node((0, 4), $0$, 9),
      node((1, 4), $0$, 10),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(5, 6, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(2, 6, $$),
      arr(3, 7, $$),
      arr(4, 8, $$),
      arr(4, 9, $$),
      arr(8, 10, $$),
      
      )]
      注意这里不是简单的直和，对象确实是直和但态射不是自然的态射
    ]<Horse-shoe>
    #proposition[][
      - $R^0 F tilde.eq F$
      - 设 $A$ 是内射模，则 $R^i F A = 0, forall i > 0$
      - 任取短正合列：
        $
        0 -> A -> B -> C -> 0
        $
        由 @Horse-shoe 知存在复形的正合列：
        $
        0 -> I_A -> I_B -> I_C -> 0
        $
        这里 $I_A, I_C$ 是内射解消，$I_B = I_A directSum I_C$\
        既然 $F$ 具有加性，以下也是正合列：
        $
        0 -> F I_A -> F I_B -> F I_C -> 0
        $
        立刻诱导出长正合列：
        $
        ... -> H^i (F I_A) -> H^i (F I_B) -> H^i (F I_C) -> H^(i+1) (F I_A) -> ...
        $
        也就是：
        $
        ... -> R^i F A -> R^i F B -> R^i F C -> R^(i+1) F A -> ...
        $
    ]
    #proof[
      - 任取内射解消 $0 -> A -> I$，由于 $F$ 左正合知 $0 -> F A -> F I$ 也正合，进而：
        $
        R^0 F = H^0 (F I) = F A
        $
      - 注意到此时：
        $
        0 ->  A -> A -> 0
        $
        成为内射解消，进而：
        $
        R^i F = H^i (F (0 -> A -> 0 -> ...)) = 0
        $
        且这个长正合列是典范的
    ]
    上面的命题表明，${R^i F}$ 确实是前面定义的余调 $delta-$函子。
  == acyclic objects
    #let Facyclic = [$F-$acyclic]
    #definition[#Facyclic][
      - 设 $F$ 是左正合函子，若 $J$ 满足 $R^i F J = 0, forall i >= 1$，则称 $J$ 是 #Facyclic 的
      - 一个 #Facyclic 解消是指正合列：
        $
        0 -> A -> J^0 -> J^1 -> J^2 -> ...
        $
        其中 $J^i$ 是 #Facyclic 的
    ]
    #theorem[可用 #Facyclic 解消计算导出函子][
      假设 $CC$ 有足够多内射对象，$F$ 左正合，则：
      $
      R^i F A = H^i (F (J))
      $
      $J$ 是任意一个 #Facyclic 解消
    ]
    #proof[
      令 $Z^i (J) = ker (J^i -> J^(i+1))$，有正合列：
      $
      0 -> A -> J^0 -> Z^1 -> 0 
      $
      对于 $i >= 2$，有正合列：
      $
      R^(i-1) F J^0 -> R^(i-1) F Z^1 -> R^i F A -> R^i F J^0 \
      0 -> R^(i-1) F Z^1 -> R^i F A -> 0
      $
      表明  $R^(i-1) F Z^1 = R^i F A$\
      接下来，有正合列：
      $
      0 -> Z^1  -> J^1 -> Z^2 -> 0
      $
      类似可以证明：
      $
      forall i >= 3, R^(i-2) F Z^2 = R^(i-1) F Z^1 = R^i F A
      $
      不断进行，可以证明：
      $
      R^i F A = R^1 F (Z^(i-1) (J))
      $
      而我们有正合列：
      $
      0 -> F Z^(i-1) -> F (J^(i-1)) -> F (Z^i) -> R^1 F Z^(i-1) -> 0
      $
      因此：
      $
      R^1 F Z^(i-1) = (F (Z^i))/(im (F (J^(i-1)) -> F (Z^i)))
      $
      另一方面，有：
      $
      H^i (F (J)) &= (ker F J^i -> F J^(i+1))/(im F J^(i-1) -> F J^i)\
      &= (F Z^i) / (im F J^(i-1) -> F J^i)
      $
      注意到有正合列：
      $
      0 -> J^(i-1) -> J^i -> J^i quo Z^i  -> 0
      $
      $F$ 作用之，得正合列：
      $
      0 -> F J^(i-1) -> F J^i -> F (J^i quo Z^i) 
      $
      给出 $F J^(i-1) -> F J^i$ 是嵌入，当然有 #TODO
    ]
    #remark[Dimension shifting][
      设有正合列：
      $
      0 -> A -> B -> C -> 0
      $
      且 $B$ 是 #Facyclic 的，则有:
      $
      R^i F C = R^(i+1) F A, forall i >= 1
      $
    ]
    假设我们构造了一族余调 $delta-$函子，且 $T^0 = F$，何时这个函子是右导出函子呢？
    #definition[泛余调 $delta-$函子][
      称一个余调 $delta-$ 函子 $T$ 是泛的，如果对于任何其他的余调 $delta-$函子 $T'$ 和自然变换 $T^0 ->^f T'^0$，有唯一的自然变换族 $f^i : T^i -> T'^i$ 使得对于任何正合列 
      $
      0 -> A -> B -> C -> 0
      $
      有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $T^i A$, 1),
      node((0, 1), $T^i B$, 2),
      node((0, 2), $T^i C$, 3),
      node((0, 3), $T^(i+1) A$, 4),
      node((1, 0), $T'^i A$, 5),
      node((1, 1), $T'^i B$, 6),
      node((1, 2), $T'^i C$, 7),
      node((1, 3), $T'^(i+1) A$, 8),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(5, 6, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(1, 5, $f^i A $),
      arr(2, 6, $f^i B$),
      arr(3, 7, $f^i C$),
      arr(4, 8, $f^(i+1 A)$),)]
    ]
    #definition[effaceable][
      称函子 $F$ 是 effaceable 的，如果对于任意 $A in CC$，存在一个单同态 $u: A -> M$ 使得 $F u = 0$\
      对偶的，称 $F$ 是 co-effaceable 的，如果对于任意 $A in CC$，存在一个满同态 $v: A -> M$ 使得 $F v = 0$
    ]
    #lemma[][
      设 $CC$ 有足够多内射对象，$F$ 左正合，则$R^i F$ 是 effaceable 的
    ]
    #proof[
      将 $A$ 嵌入内射对象 $I$，用 $R^i F$ 作用产生：
      $
      R^i F A -> R^i F I = 0
      $
      当然就意味着 $F (A -> I) = 0$
    ]
    #lemma[][
      设 $T$ 是余调 $delta-$函子，$T^0 = F$，若 $T^i, i >= 1$ 是 effaceable 的，则 $T$ 是泛余调 $delta-$函子
    ]
    #proof[
      设 $T^i$ 是另一族余调 $delta-$函子以及 $T^0 ->^(f^0) T'^0$，归纳构造 $f^n$，假设已经有对于任何短正合列：
      $
      0 &-> A &&->^() B &&->^() C &&-> 0
      $
      有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $T^i C$, 1),
      node((0, 1), $T^(i+1) A$, 2),
      node((1, 0), $T'^i C$, 3),
      node((1, 1), $T'^(i+1) A$, 4),
      arr(1, 2, $delta^i$),
      arr(1, 3, $f_A^i$),
      arr(2, 4, $f_C^i$),
      arr(3, 4, $$),)]
      其中 $i = 0, 1, ..., n-1$\
      想法是利用条件进行降维，对于 $n$ ，选取 $u: A -> M$ 是单态射且 $T^n u = 0$，有短正合列：
      $
      0 &-> A &&->^() M  &&->^() A quo M &&-> 0
      $
      用 $T$ 进行作用，得到：
      #align(center)[#commutative-diagram(
      node((0, 0), $T^(n-1) M$, 1),
      node((0, 1), $T^(n-1) M quo A$, 2),
      node((0, 2), $T^n A$, 3),
      node((1, 0), $T'^(n-1) M$, 4),
      node((1, 1), $T'^(n-1) M quo A$, 5),
      node((1, 2), $T'^n A$, 6),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(4, 5, $$),
      arr(5, 6, $$),
      arr(1, 4, $$),
      arr(2, 5, $$),
      arr(3, 6, $exists f_(A, u)^n$),)]
      其中可以证明 $T^(n-1) M quo A -> T^n A$ 是满射，$f$ 追图可得，需要验证它与 $u$ 无关，再找 $A ->^v N$，有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $M$, 2),
      node((1, 0), $N$, 3),
      node((1, 1), $coker ((u, -v): A -> M directSum N)$, 4),
      arr(1, 2, $u$),
      arr(1, 3, $v$),
      arr(2, 4, $$),
      arr(3, 4, $$),
      arr(1, 4, $omega$)
      )]
      显然 $T^n omega = 0$，往证 $f_u = f_omega$（对称的，有 $f_omega = f_v$），首先有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $M$, 2),
      node((0, 2), $M quo A$, 3),
      node((1, 0), $A$, 4),
      node((1, 1), $L$, 5),
      node((1, 2), $L quo A$, 6),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(4, 5, $$),
      arr(5, 6, $$),
      arr(1, 4, $$),
      arr(2, 5, $$),
      arr(3, 6, $$),)]
      由于上下都是短正合列，用 $T$ 作用于其上，再追图即可

      再证明 $f_A^n$ 是具有函子性的，也即给定 $u: A -> B$，考虑交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $M$, 2),
      node((0, 2), $M quo A$, 3),
      node((1, 0), $B$, 4),
      node((1, 1), $N$, 5),
      node((1, 2), $N quo B$, 6),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(4, 5, $$),
      arr(5, 6, $$),
      arr(1, 4, $$),
      arr(2, 5, $$),
      arr(3, 6, $$),)]
      其中 $N$ 是用类似上面的在直和中取余核构造得到的，之后的证明是类似的

      最后，证明 $f^n$ 与 $delta$ 有交换性，任取短正合列：
      $
      0 &-> A &&->^() B &&->^() C &&-> 0
      $
      选取 $v: B -> M$ 使得 $T^n v = 0$，有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $B$, 2),
      node((0, 2), $C$, 3),
      node((1, 0), $A$, 4),
      node((1, 1), $M$, 5),
      node((1, 2), $M quo A$, 6),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(4, 5, $$),
      arr(5, 6, $$),
      arr(1, 4, $$),
      arr(2, 5, $$),
      arr(3, 6, $$),)]
      以 $T$ 作用于其上，之后的证明也是类似的
    ]
    #theorem[][
      - $R^i F$ 是泛余调 $delta-$函子
      - 任何泛余调 $delta-$函子都同构于 $R^i F$
    ]
    #proof[
      第一个结论是前两个引理的推论，第二个结论来自于泛余调 $delta-$函子的唯一性（这是容易证明的）
    ]
  == Tor 与 Ext
    设 $R$ 是交换环，$A, B in Mod_R$\
    #definition[][
      $
      Tor_i (M, N) = L_i (- tensorProduct N) (M)\
      = H^(-i) ( ... -> M tensorProduct P^(-2) -> M tensorProduct P^(-1) -> M tensorProduct P^0 -> 0)\
      = H_i (... -> M tensorProduct P_(2) -> M tensorProduct P_(1) -> M tensorProduct P_0 -> 0)
      $

    ]
    #definition[][
      $
      Ext^i (M, N) = (R^i Hom (*, N)) (M)\
      $
      这里 $Hom (*, N)$  是反变函子
    ]
    显然，$Hom, tensorProduct$ 都是二元函子，为了证明上述导出函子也是二元函子（也就是与先选取谁无关），需要用到下面的平衡性：
    #definition[][
      设 $T: C_1 times ... times C_(n)$，其中 $C_n$ 可能是 $C$ 或者 $C_("op")$\
      若它左正合，且满足：
      - 若 $T^i$ 是共变的，则只要该分量取任意内射对象，则函子正合
      - 若 $T^i$ 是反变的，则只要该分量取任意投射对象，则函子正合
      则称 $T$ 是右平衡的，类似的可以对右正合函子定义左平衡
    ]
    #lemma[][
      $
      Hom(M_1, M_2), Hom(M_1 tensorProduct M_2, M_3)
      $
      都是右平衡的\
      $tensorProduct$  是左平衡的
    ]
    #theorem[][
      对于右平衡，左正合函子 $T$，有：
      $
      R^i T(A_1, ..., A_(i-1), *, A_(i+1), ..., A^n) (A_i)
      $
      与 $i$ 取值无关
    ]
    #proof[
      需要用到谱序列，不证明
    ]
    #example[][
      设 $C$ 是 Abel 群构成的范畴，考虑：
      $
      Tor_i (Z quo p, B)
      $
      注意到有投射解消：
      $
      0 -> ZZ ->^p ZZ -> ZZ quo p -> 0
      $
      进而：
      $
      Tor_i (Z quo p, B) = H_i (0 -> B ->^p B -> 0)
      $
      可得：
      $
       Tor_i (Z quo p, B) = cases(
        B quo p B quad i = 0,
        {b in B | p b = 0} quad i = 1,
        0 quad i > 1
      )
      $
    ]
    #proposition[][
      设 $A, B$ 是交换群，则：
      - $Tor_1 (A, B)$ 是 torsion group
      - $Tor_i (A, B) = 0, i > 1$
      - 既然 $QQ quo ZZ = union Z quo n ZZ$，有 $Tor_1 (QQ quo ZZ, B) = B_("tor")$ 
      - 无挠群都平坦
    ]
    #proposition[][
      对于张量积函子，平坦模是 acyclic ，既然：
      $
      L_i F(N) = 0 <=> Tor_i (M, N) = 0, forall i > 0 
      $
      进而计算 $Tor$ 可以使用平坦解消
    ]
    #lemma[][
      - $M$ 是内射对象当且仅当 $Ext^1 (*, M) = 0$
      - $M$ 是投射对象当且仅当 $Ext^1 (M, *) = 0$
    ]
    #proof[
      任取短正合列用 $Ext$ 作用即可
    ]
    #example[][
      - 设 $A, B$ 是 Abel 范畴中的对象，则 $Ext^n (A, B) = 0, forall n >= 2$
      - 对于 $ZZ quo p$ 有投射解消：
        $
        0 -> ZZ ->^p ZZ -> ZZ quo p -> 0
        $
        由定义有：
        $
        Ext^n (ZZ quo p, B) = H^n (0 -> Hom(ZZ, B) -> Hom(ZZ quo p, B))
        $
      - $Ext(ZZ, A) = 0$
      - 为了计算 $Ext(A, ZZ)$ 对 $ZZ$ 有内射解消：
        $
        0 -> ZZ -> QQ -> QQ quo ZZ -> 0 
        $
        因此：
        $
        Ext^n (A, ZZ) = H^n (0  -> Hom(A, QQ) -> Hom(A, QQ quo ZZ) -> 0)
        $
        假设 $A$ 是挠群，则 $Hom(A, ZZ) = 0 = Hom (A, QQ)$，则此时:
        $
        Ext^0 = 0\
        Ext^1 (A, ZZ) = Hom (A, QQ quo ZZ) 
        $
    ]
    #proof[
      将 $B$ 嵌入内射对象 $I$，有正合列：
      $
      0 -> B -> I -> I quo B -> 0 
      $
      然而由@injective-divisible 可得 $I quo B$ 也是内射的，进而结论成立
    ]
    #definition[][
      称 $B$ 是 $A$ 的扩张，如果有短正合列：
      $
      0 -> A -> X -> B -> 0
      $
      称两个扩张等价，如果有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $0$, 1),
      node((0, 1), $A$, 2),
      node((0, 2), $X$, 3),
      node((0, 3), $B$, 4),
      node((0, 4), $0$, 5),
      node((1, 0), $0$, 6),
      node((1, 1), $A$, 7),
      node((1, 2), $Y$, 8),
      node((1, 3), $B$, 9),
      node((1, 4), $0$, 10),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(4, 5, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(8, 9, $$),
      arr(9, 10, $$),
      arr(2, 7, $$, bij_str),
      arr(3, 8, $$),
      arr(4, 9, $$, bij_str),
      )]
      由 5-lemma，此时一定有 $X tilde.eq Y$\
      称 $eta$ 是分裂的，如果 $eta$ 等价于：
      $
      0 &-> A &&->^() A directSum B &&->^() B &&-> 0
      $
    ]
    #lemma[][
      对于正合列:
      $
      eta: 0 -> A -> X -> B -> 0
      $
      可得长正合列：
      $
      0 &-> Hom (B, A) &&->^() Hom (B, X) &&->^() Hom (B, B) &&->^delta Ext^1 (B, A) -> ...
      $
      注意到 $id_B in Hom (B, B)$ 可以诱导 $delta_eta (id_A)$\
      这就构造了所有扩张 $eta$ 到 $Ext^1 (B, A)$ 的映射。可以证明这是双射\
      特别的，若 $Ext^1 (B, A) = 0$，则任意扩张都是分裂的
    ]
  ==  三角范畴与导出范畴
    设 $AA$ 是 Abel 范畴，令 $C(AA)$ 是复形构成的范畴，$K(AA)$ 是复形范畴商掉同伦关系。 对于任何加性函子 $F: AA -> AA$，它当然保持同伦也因此可以延拓到 $K(AA)$ 上。不幸的是，$K(AA)$ 不是 Abel 范畴，不能自由的取 $ker, coker$，但它可以产生一个三角范畴。
    #definition[三角范畴][
      设 $K$ 是加性范畴，称 $K$ 是三角范畴，如果它具有自同构 $T = [1] : K -> K$9有时称为 translation functor）以及一族三角形 $A -> B -> C -> A [1]$（也称为正合三角形），要求满足：
      + 每个态射 $f: A -> B$ 可被延拓成正合三角形 $A -> B -> C -> A[1]$\
        特别的，$A ->^id A -> 0 -> A[1]$ 是正合三角形，同时同构于正合三角形的三角形也正合
      + 设 $A -> B -> C -> A [1]$ 是正合三角形，则旋转：
          $
          B -> C -> A[1] ->^(-(A -> B)[1]) B[1]\
          C[-1] ->^(-(C -> A[1])[-1]) -> A -> B -> C
          $
          是正合三角形
      + 
        设有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $B$, 2),
        node((0, 2), $C$, 3),
        node((0, 3), $A[1]$, 4),
        node((1, 0), $A'$, 5),
        node((1, 1), $B'$, 6),
        node((1, 2), $C'$, 7),
        node((1, 3), $A'[1]$, 8),
        arr(1, 2, $$),
        arr(2, 3, $$),
        arr(3, 4, $$),
        arr(5, 6, $$),
        arr(6, 7, $$),
        arr(7, 8, $$),
        arr(1, 5, $f$),
        arr(2, 6, $$),
        arr(4, 8, $f[1]$),)]
        其中上下行都是正合三角形，则存在 $C -> C'$ 的态射使得图表交换。
      + 对于交换的三角形：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $B$, 2),
        node((1, 0), $C$, 3),
        arr(1, 2, $$),
        arr(3, 2, $$),
        arr(1, 3, $$),)]
        沿着三边分别向外延拓出正合三角形，则延拓的第三项“共线”，也即可延拓出正合三角形。

    ]
    #definition[拟同构][
      称 $E -> F$ 是拟同构，如果 $forall n, H^n (E) tilde.eq H^n (F)$
    ]
    #definition[局部化][
      设 $C$ 是范畴，$S$ 是 $C$ 中一些态射的集合。称 $C$ 关于 $S$ 的局部化是范畴 $Inv(S) C$ 以及函子 $Inv(S): C -> Inv(S) C$，满足：
      - $forall s in S, Inv(S) s$ 是同构
      - 有泛性质：若 $F s$ 对于所有 $s in S$ 都是同构，则有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $CC$, 1),
        node((0, 1), $DD$, 2),
        node((1, 0), $Inv(S) CC$, 3),
        arr(1, 2, $F$),
        arr(3, 2, $exists !$),
        arr(1, 3, $Inv(S)$),)]
    ]
    #remark[][
      之前构造 $Inv(S) R$ 时，可以将 $R$ 视作范畴，其中 $Ob$ 只有一个元素，$Hom(*, *) = R$，这样局部化的概念就是一致的
    ]
    #theorem[][
      范畴的局部化总是存在的
    ]
    #definition[][
      称 $S$ 是乘性系统，如果：
      - $S$ 包含所有 $id$
      - $S$ 在复合下封闭
      - 对于任何交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $X$, 1),
        node((0, 1), $Y$, 2),
        node((1, 0), $Z$, 3),
        arr(1, 2, $$),
        arr(3, 2, $t in S$),
        )]      
        存在交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $W$, 1),
        node((0, 1), $Z$, 2),
        node((1, 0), $X$, 3),
        node((1, 1), $Y$, 4),
        arr(1, 2, $$),
        arr(1, 3, $$),
        arr(2, 4, $$),
        arr(3, 4, $$),)]
        类似于 $Inv(t) g = g Inv(s)$
      - 有消去律：\
        设 $f, g : X -> Y$，以下条件等价：
        -  $exists s in S, s f = s g$
        - $exists s in S, f t = g t$
    ]
    #theorem[Gabriel-Zisman][
      设 $S$ 是乘性系统，则 $Inv(S) CC$ 可以被显式构造：
      - $Ob(Inv(S) CC) = Ob (CC)$
      - $Hom (X, Y) = {f Inv(t) : X <-^t X' -> Y} quo tilde$
      其中 $ X <-^t_1 X'_1 -> Y$ 与 $ X <-^t_2 X'_2 -> Y$ 等价当今仅当存在 $ X <-^t_3 X'_3 -> Y$ 以及 $X_3 -> X_1, X_3 -> X_2$，并构成交换图
      则这确实是范畴，且就是 $Inv(S) CC$，对应函子是：
      $
      funcDef(q, CC, Inv(CC), (X ->^f Y), (X ->^id X ->^f Y))
      $
    ]
    #definition[][
      对于任意 Abel 范畴 $AA$，则 $K(AA)$ 是三角范畴，取 $S$ 为其中所有拟同构，则可以验证它是乘性系统，做商得到的范畴称为导出范畴。它包含了所有同调群的信息。
    ]
    #lemma[][
      设 $F: A -> B$ 是加性函子，则自然的拓展到 $K(A) ->^F K(B)$
      - 若 $F$ 是正合函子，则 $F$ 保持同调群同构，当然就可以延拓到 $D(A) -> D(B)$
      - 若 $F$ 不是正合函子，一般不能直接进行延拓
    ]
    #definition[][
      设 $q: K(A) -> D(A)$ 称 $F$ 的（全）右导出函子是指 $R F: D^* (AA) -> D^* (B)$ 以及自然变换 $xi: q F -> R F q$，并满足泛性质：对于任意 $G: D(A) -> D(B), eta: q F -> G q$，都有自然变换 $epsilon$ 使得 $epsilon xi = eta$（换言之，这是某种最小的延拓）。

      既然由泛性质给出，故只要存在右导出就是唯一的

    ]
    #theorem[][
      若 $AA$ 有足够多的内射对象，则 $R F$ 存在，且满足若 $I$ 是内射对象的有界复形，则：
      $
      R F(I) tilde.eq q F(I) => H^n (R F(A)) tilde.eq R^n F(A)
      $
    ]
    #definition[Kan extension][
      设 $F: AA -> BB, G: CC -> DD$，一个 $F$ 沿着 $G$ 的左 Kan-extension 是指：
      - 函子 $K: DD -> BB$
      - 自然变换 $alpha: F -> K G$
      并且是这样的二元组组成范畴的始对象。

      对偶的，可以定义右 Kan-extension 
    ]
    #example[][
      余极限、极限可以实现成左、右 Kan 延拓。考虑：
      #align(center)[#commutative-diagram(
      node((0, 0), $CC$, 1),
      node((0, 1), $0$, 2),
      node((1, 0), $DD$, 3),
      arr(1, 2, $$),
      arr(1, 3, $F$),)]
    ]
    则 $F$ 沿着 $0$ 的左 Kan 延拓是 $(K: 0 -> DD, alpha: F -> K 0)$ 并满足泛性质。事实上，$K$ 只有一个像，记作 $"colim" F$，而自然变换就是交换图：
    
     #commutative-diagram(
    node((0, 0), $F A$, 1),
    node((0, 1), $F B$, 2),
    node((1, 0), $"colim" F$, 3),
    arr(1, 2, $$),
    arr(3, 2, $$),
    arr(1, 3, $$),)
    始对象对应的就是余极限的泛性质
    
