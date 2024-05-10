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
    ]
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
          对 $n$ 做归纳，利用蛇形引理可以验证结论成立
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
