#import "../template.typ": proof, note, corollary, lemma, theorem,  proposition, definition, example, remark, der, partialDer, AModule, Mod, incrementSign, inj_str, surj_str, bij_str, def_str, nat_str, tensorProduct
#import "../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "代数学二",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 前言
  == 课程介绍
    - 学习内容：前半学期交换代数，后半学期同调代数
    - 教师：阳恩林 https://www.math.pku.edu.cn/teachers/yangenlin/ce.htm
    - 参考书：
      - Atiyah, Macdonald, Introduction to Commutative Algebra
      - Matsumura, Commutative Algebra
      - 李文威, 代数学基础
      - 本门课程提供的同调代数的讲义
      - GTM52 代数几何
      - T.Wedhorn, adic spaces
    - 考核：作业 20%, 期中 30%, 期末 50%（也可能期中期末各占40%），期中会更难+调分
    约定除非特别指明，环指交换幺环，同态是保持其幺元的。零环也视为环\
    通常环/模记为大写字母，$k$ 表示某个域
  // == 内容介绍
  //   #example[][
  //     方程 $x^2 + y^2 = 1$ 的有理根也是单位圆上的有理点，也是多项式 $h(x, y) = x^2 + y^2 - 1$ 的零点集。\
  //     设 $f, g in R[x, y]$ 满足 $f - g in (f)$，那么将有：
  //     $
  //     f|_C = g|_C
  //     $
  //     换言之，$C$ 上的代数函数环恰为 $R[x, y] quo (f)$\
  //   ]
  == 中英名词对照
    - annihilates：零化
    - annihilator：零化子
    - idempotent：幂等元
    - nilpotent：幂零元
    - nilradical：幂零根
    - saturated：饱和的

= 环与模
  == 模
    #definition[范畴|category][
      范畴被形式的定义为以下资料：
      - 对象集合 $H$
      - 对于每一对对象 $A, B in H$，一个集合 $Hom(A, B)$，称为从 $A$ 到 $B$ 的态射集
      - 对于每一对对象 $A, B, C in H$，一个映射 $Hom(A, B) * Hom(B, C) -> Hom(A, C)$，称为复合映射
      - 对于每一个对象 $A in H$，一个元素 $1_A in Hom(A, A)$，称为恒等态射
    ]
    #definition[模|AModuleule][
      设 $A$ 是环，一个 $A-$模是指：
      - 加法交换群 $M$
      - $A-$作用 $A times M -> M$，记作 $(a, m) = a dot m$
      - 运算的兼容性，也即：
        - $a(x + y) = a x + a y$
        - $(a + b) x = a x + b x$
        - $a(b x) = (a b)x$
      或者说存在 $M -> End_A (M)$ 的环同态
    ]
    #example[][
      - $A$ 是一个域，那么 $A-$模就是向量空间
      - $A = ZZ$，$A-$模就是交换群本身（作用当然就是熟知的 $n dot x$）
      - 设 $A = k[x]$，则 $A-$模包括：
        - $A$ 在 $k$ 上的作用，也就是 $k$ 的向量空间
        - $x$ 在上述线性空间的作用，也即一个线性变换/k-矩阵
      - 设 $G$ 是有限群，$A = k[G]$ 是群代数（也是线性空间），其中元素形如 $sum_(g in G) a_g g$\
        $G$ 中每个元素给出 $A$ 上的一个可逆线性变换，这就给出 $G -> GL(k)$ 的一个一一映射
      - $A$ 是环，$A$ 作用于自己当然也构成 $AModule(A)$
    ]
    #definition[模同态][
      两个 $AModule(A)$ 之间的群同态 $f: M -> N$ 称为模同态，如果：
      - $f(x + y) = f(x) + f(y)$
      - $f(a x) = a f(x)$
      有时也称其为 $A-$线性映射\
      此时，记：
      - $ker f = {m in M | f(m) = 0}$，它是 $M$ 的子（$A$）模
      - $im f = {f(m) | m in M}$，它是 $N$ 的子（$A$）模
      - $coker f = N quo im f$
      - $coim f = M quo ker f$
      有熟知的同构定理 $coim f tilde.eq im f$

      所有$AModule(A)$之间的同态构成态射集 $Hom_A (M, N)$。注意到 $Hom_A (M, N)$ 本身就是一个 $AModule(A)$，运算是自然的运算：
        $
        &[a: A -> \
            [f: Hom_A (M, N) ->\ 
              [x: M -> a f(x) :N]:Hom_A (M, N)\
            ]:(Hom_A (M, N) -> Hom_A (M, N)) = End_A (Hom_A (M, N))\
          ]:(A -> End_A (Hom_A (M, N))) \
        $
    ]
    #example[][
      设 $M$ 是$AModule(A)$，则 $Hom_A (A, M) tilde.eq M$，它由双向的映射：
      - $[f: (A -> M) -> f(1)] $
      - $[m: M -> [a: A -> a m]] $
      给出
    ]
    #definition[子模|subAModuleule 商模|quotient AModuleule][
      设 $M$ 是 $AModule(A)$，$N$ 是 $M$ 的子集，如果：
      - $N$（在相同运算下）也是 $A-$模，或者
      - $N$ 在 $A$ 作用下稳定，也即 $A M subset M$
      那么称 $N$ 是 $M$ 的子模\
      此时，可以定义商模 $M quo N$ 为交换群的一个商群，它同时也是 $A-$模，定义为：
      $
      [a: A, m + N: M quo N -> a (m + N) = a m + N: M quo N]
      $
    ]
    #theorem[对应定理][
      $M$ 的包含 $N$ 的子模与 $M quo N$ 的子模之间存在一一对应关系，并且保持各种性质
    ]
    #definition[理想|ideal][
      将 $A$ 视作$AModule(A)$，则 $A$ 的子模称为 $A$ 的理想，这等同于在 $A$ 乘法下稳定的加法子群，与环中理想的概念是一致的。\
      自然的，此时的商模就是商环
    ]
  == 子模/理想上的操作
    #definition[][
        + 设 $M$是$AModule(A)$，$M_i in I$ 是若干子模，定义：
          - $M_j subset sum_(i in I) M_i = {sum_(i in I) m_i | m_i in M_i, m_i "中至多有限个非零"} subset M$
          - $sect.big_(i in I) M_i subset M_j$
          都是子$AModule(A)$
        + 设 $I$ 是 $A$ 的理想，定义：
          $
          I M = phi: (A -> (M -> M)) |_I
          $
          它是 $M$ 的子模\
          当 $I, J$ 都是理想时，以上定义给出 $I J$ 也是理想，它含于 $I sect J$。以此乘法给出 $I^m$ 的定义
        + 任取 $m in M$，定义：
          $
          (m) = A m = {a m | a in A}
          $
          为由 $m$ 生成的子模
        + 若 $M = sum_(i=1)^n A m_i$ 对某个 $n$ 和某些 $m_i$ 成立，则称 $M$ 是有限生成（finitely generated）的
        + 设 $M_i$ 是若干子模，定义：
          - 直和 $circle_(i in I) M_i = {(m_i) | m_i in M_i, m_i "中至多有限个非零"} subset M$
          - 直积 $product_(i in I) M_i = {(m_i) | m_i in M_i} subset M$
          都是子$AModule(A)$
        + 设 $N P$ 是子模，定义：
          $
          (N : P) = {a in A | a P subset N}
          $
          它是 $A$ 的理想。特殊的，称：
          $
          (0) : P = {a in A | a P = 0} = "ann"(P)
          $
          为 $P$ 的零化子\
          一般的，我们有：
          $
          N : P = "ann"((N + P)/P)
          $
          （注意到 $a P subset N <=> a (N + P)/P = 0$）
    
    ]
    #theorem[][
      $(M_1 + M_2)/(M_1) tilde.eq (M_1)/(M_1 sect M_2)$
    ]
    #theorem[][
      $M$ 是有限生成的当且仅当存在 $A^n -> M$ 的满同态
    ]
    #proof[
      - 若 $M$ 是有限生成的，那么定义：
        $
        funcDef(phi, A^n, M, (a_i), sum_(i=1)^n a_i m_i)\
        $
      - 若存在满同态 $phi$，取 $m_i = phi(0, 0, 0, ..., 1, 0,... >,0)$ 即可
    ]
    #theorem[][
      设 $M$ 是$AModule(A)$ ，则 $"ann"(M)$ 是子模，将有：
      $
      M " 是 " AModule(A quo "ann"(M))
      $
    ]
  == 素理想和极大理想
    #definition[素理想][
    设 $R$ 是环，$P$ 是理想且 $P != R$，称 $P$ 是素理想，若：
        $
            a b in P => a in P or b in P
        $
    ]
    #proposition[][
        设 $R$ 是环，$P$ 是非平凡理想，则 $P$ 是素理想当且仅当 $quotient(R, P)$ 是整环
    ]
    #definition[极大理想][
        设 $R$ 是环，$m$ 是 $R$ 的双边理想，若 $m != R$ 且没有包含 $m$ 的理想，则称 $m$ 是极大理想
    ]
    #proposition[][
        设 $R$ 是交换环，则 $I$ 是极大理想当且仅当 $quotient(R, I)$ 是域
    ]
    #theorem[][
      任何理想 $I != A$ 都包含在某个极大理想中
    ]
    #proof[
      这个证明需要用到 Zoun 引理。

      取 $S$ 是所有 $R$ 中包含 $I$ 的非平凡理想，对于包含关系，我们有 $S$ 是偏序集。在这个集合上我们试图套用 Zoun 引理，只需验证所有链都有上界即可。
      
      设 $I_x space x in S$ 是链，显然：
      $
      union_(x in S) I_x
      $  
      是这个链的一个上界，它是理想也是显然的，只需证明它不是 $R$。\
      事实上，注意到：
      $
      1 in.not I_x 
      $
      进而 $1 in.not union_(x in S) I_x$

      这就完成了证明
    ]
    #remark[][
      如果不使用 Zoun 引理，可能需要假设 $A$ 是 Noethenian 环
    ]
    #definition[局部环|local ring][
      称 $A$ 是局部环，如果其中有且只有一个极大理想 $m$，此时称 $A quo m$ 为剩余域
    ]
    #theorem[][
      - 若所有不可逆元素包含于某个理想，则这个理想一定是唯一的极大理想，进而环是局部环
      - 若 $m$ 是极大理想，且 $1+m$ 中所有理想均可逆，则 $A$ 是局部环  
    ]
    #proof[
      - 显然
      - 任取 $x in A - m$，由于：
        $
        m + (x) = (1)
        $
        因此可设 $a + b x = 1 => b x = 1 -a in 1 + m$ 可逆，进而 $x$ 也可逆，由 1 知结论成立
    ]
    #example[][
      $
      ZZ_((p)) = {r/s | (p, s) = 1}
      $
      中，所有的不可逆元包含于 $p ZZ_((p))$，同时这是极大理想，因此环是局部环
    ]
    #example[理想的几何来源][
      设 $k$ 是域，$Y subset k^n$，令：
      $
      I(Y) = {f in k[x_1, x_2 ,..., x_n] | f(Y) = 0}
      $
      容易验证它是理想

      反之，给定 $I$ 是理想，令：
      $
      Z(I) = {p in k^n| forall f in I, f(p) = 0}
      $

      不幸的是，他们一般不是互逆的，但几乎是互逆的，这在代数几何中非常基本
    ]
  == 幂零根与 Jacob radical
    #definition[幂零根|nilradical][
      设 $A$ 是环，称 $A$ 的 幂零根|nilradical 为：
      $
      N = sect.big Spec(A)
      $
    ]
    #definition[Jacob radical][
      设 $A$ 是环，称 $A$ 的 Jacob radical 为：
      $
      R = sect.big "max"(A)
      $
    ]
    #theorem[][
      - $N = {a in A | exists n in NN, a^n = 0}$
      - $R = {x in A | 1 - x y in U(A)}$
    ]<radicalForm>
    #proof[
      - 记所有幂零元的集合为 $N$，容易验证它是理想。比较困难的是证明它是所有素理想的交（暂记为 $N'$）
        - 首先容易验证 $N$ 应该包含在所有素理想之中，进而 $N subset N'$
        - 再证明另一方面，只需证明：
          #lemma[][任取 $x in A$ 不是幂零元，它不含于某个素理想]
          #proof[
            令 
            $
            Sigma = {p in Spec(A) | forall n > 0, f^n in.not p}
            $
            断言：
            - $Sigma$ 非空，因为 $(0) in Sigma$
            - $Sigma$ 满足 Zoun 引理的条件
            - 进而 $Sigma$ 有一个极大元 $p$，它是素理想\
              假设 $x, y in.not p$，往证 $x y in.not p$\
              由极大性，$p + (x), p + (y) in.not Sigma$，也即：
              $
              exists n in NN:\
              f^n in p + (x), f^n in p + (y)\
              => f^(2n) in p + (x y)\
              => p + (x y) in.not Sigma\
              => p + (x y) != p\
              => x y in.not p
              $
            证毕
          ]
      - 记 $R' = {x in A | 1 - x y in U(A)}$，分别验证：
        - $x in m, forall m in max(A) => 1 - x y in U(A)$\
          如若不然，则存在 $y$ 使得 $1 - x y$ 不是单位，可设 $1 - x y$ 包含于极大理想 $m$\
          此时 $m$ 同时包含 $1 - x y, x$ 进而包含 $1$，矛盾！
        - 反过来，设 $forall y in A, 1- x y in U(A)$\
          若结果不成立，则存在 $m in max(A), x in.not m$，进而：
          $
          m + (x) = (1) => 1 = a + x y => a = 1 - x y
          $
          这表明 $a in m$ 是单位，不能包含在极大理想中，矛盾！
    ]
    #definition[乘性子集 | multiplicative][
      称 $S subset A$ 是乘性子集，如果：
      - $1 in S$
      - $x, y in S => x y in S$
    ]
    #theorem[][
      设 $S$ 是乘性子集且不含零(那么 $S$ 中的元素都不是幂零元)，则存在素理想 $p$ 使得 $p sect S = emptyset$
    ]
    #proof[
      构造：
      $
      Sigma = {I "is ideal"| I sect S = emptyset }
      $
      类似上面的证明，可以利用 Zoun 引理证明 $Sigma$ 有极大元 $p$，且它是素理想
    ]
    #definition[][
      设 $I subset A$ 是理想，记：
      $
      r(I) 或 sqrt(I) := {x in A | exists n in NN^+, x^n in I} = Inv(pi)(N(A quo I)) 
      $
      容易验证它也是：
      $
      sect.big V(I) = sect.big {p in Spec(A) | I subset p}
      $
      特别的，$sqrt(0) = N$
    ]
    #proposition[][
      - $I subset sqrt(I)$
      - $sqrt(I) = sqrt(sqrt(I))$
      - $sqrt(I J) = sqrt(I) sect sqrt(J)$
      - $sqrt(I) = (1) <=> I = 1$
      - $p in Spec(A) => sqrt(p) = p$
    ]
    #remark[][
      对应的也应该考虑 $sect.big_(I subset m in max(A)) m$，这同样对应商环中的 Jacob radical，也即：
      $
      forall y in A: (1 - x y) + I = (1)\
      a - a x + b = 1\
      a x = a + b - 1
      $
      它往往比 $sqrt(I)$ 更大（做交运算的集合更少），有时取等
    ]
    #example[][
      设 $D(x) = {y | x y = 0}$，则容易验证 $sqrt(D) = D$。更进一步，整个环的零因子：
      $
      union_x D(x)
      $
      应当满足：
      $
      sqrt(union_x D(x)) = union_x sqrt(D(x)) = union_x D(x)
      $
    ]
  == 素谱上的拓扑
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
      - $sect.big_i V(I_i) = V(sum_i I_i)$
      - $V(I) union V(J) = V(I sect J) = V(I J)$
    ]
    #proof[
      - 注意到对任何素理想 $P, I subset P <=> E subset P$，结论显然
      - $0$ 当然包含与任何素理想
      - 任何素理想当然都不应该包含 $1$
      - 一方面
        $
        I_j subset sum_i I_i => V(sum_i I_i) subset V(I_j)
        $
        另一方面，假设素理想 $P$ 满足 $P in sect.big_i V(I_i)$，这就导出 $P supset I_i, forall i$，表明 $P supset sum_i I_i$
      - 首先 $I, J supset I sect J, I J$，因此 $V(I), V(J) subset I sect J, I J$。\
        - 往证 $V(I J) subset V(I) union V(J)$\
          注意到 $P$ 是素理想，因此 $P supset I J => P supset I or P supset J => P in V(I) union V(J)$
        - 类似的，把 $I sect J$ 替换 $I J$ 结论都是正确的
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
        V(f) = V(product_(i=1)^n x - a_i) =  {(x - a_i) | i = 1, 2, ..., n}
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
      - $D(f) sect D(g) = D(f g)$
      - $D(f) = emptyset <=> f in sqrt(0)$
      - $D(f) = Spec(A) <=> f in U(A)$
      - $D(f) = D(g) <=> sqrt(f) = sqrt(g)$
    ]
    #proof[
      - $p in D(f) sect D(g) <=> f in.not p and g in.not p <=> f g in.not p$
      - 由幂零根的概念和性质可知
      - \
        - 一方面 $f in U(A) => V(f) = emptyset$
        - 另一方面，一个不可逆的元素应该包含于某个极大理想，而极大理想一定是素理想，因此成立
        - 首先我们证明：
          $
          sect.big_(P in V(I)) = sqrt(I)
          $
          这是因为由对应定义，$V(I)$ 中的元素与 $Spec(A quo I)$ 中元素可以产生一一对应 $phi$。同时，注意到：
          $
          Spec(A quo I) = sect.big_(p in V(I)) p quo I
          $
          用 $phi$ 作用于两侧立得结论
    ]
    #corollary[][
      所有基本开集构成一个拓扑基
    ]
    #proof[
      这是非常自然的，因为开集均形如：
      $
      Spec(A) - V(E) = Spec(A) -  (sect.big_(f in E) V(f)) = union.big_(f in E) D(f) 
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
      <=>& V(f) supset sect.big_(i in I) V(g_i)\
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
    #theorem[Hochster][
      设 $X$ 是拓扑空间，则以下条件等价：
      - $exists A$，$X$ 与 $Spec(A)$ 同胚
      - $X$ 伪紧，且有一个均伪紧的开集基，并在有限交下稳定
      - 每个不可约闭集有唯一的 generic 点（闭包就是全空间）
    ]
    #proof[
      我们不证明这个定理，只是说明谱空间与拓扑学有密不可分的关系
    ]
    类似素谱，我们可以定义极大谱。它的大部分性质与素谱类似，但在根的处理上更加复杂。
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
      此时若 $p = phi(q)$，则称 $q$ 在 $p$ 之上
    ]
  == 素理想的一些性质
    #definition[coprime][
      设 $I, J$ 是理想，称它们是互素理想，如果：
      $
      I + J = (1)
      $
    ]
    #proposition[][
      设 $I + J = (1)$，则 $I sect J = I J$
    ]
    #proof[
      - 由定义，$I J subset I sect J$
      - 其次：
        $
        I sect J = (I + J)(I sect J) = I (I sect J) + (I sect J) J subset I J + I J = I J 
        $
    ]
    #theorem[中国剩余定理][
      设 $I_i$ 是有限个理想，定义映射：
      $
      funcDef(phi, A, product_i A quo I_i, a, (a + I_i))
      $
      则：
      - 若 $I_i$ 两两互素，则此时有 $I_1 I_2 ... I_n = I_1 sect I_2 ... sect I_n$
      - $ker phi = I_1 sect I_2 ... sect I_n$
      - $phi$ 是满射当且仅当 $I_i$ 两两互素，此时有：
        $
        A quo (I_1 sect I_2 ... sect I_n) tilde.eq product_i A quo I_i
        $
    ]
    #proof[
      TODO
    ]
    #lemma[Prime avoidance lemma][
      + 设 $P_i$ 是若干素理想，$I$ 是理想且 $I subset union_i P_i$，则 $exists i,I subset P_i$\
        反之，若 $I$ 不在任何一个 $P_i$ 中，则它不在 $union_i P_i$ 中
      + 设 $I_i$ 是理想，$P$ 是素理想，若 $sect_i I_i subset P$，则 $exists i, I_i subset P$\
        进一步，若 $sect_i I_i = P$，则 $exists i, I_i = P$
      + 设 $P_i$ 是若干理想，其中至多两个不是素理想，$I$ 是理想且 $I subset union_i P_i$，则 $exists i,I subset P_i$\
    ]
    #proof[
      + 我们证明它的反面，目标是构造 $x$ 不落在 $union_i P_i$ 中\
        - 若 $n = 1$ 结论平凡
        - 若 $n = k$ 成立，则由归纳结论：
          $
          forall k in I, I subset.not union.big_(i in I - {k})
          $
          对于每个 $k$，选取 $x_k in I - union.big_(i in I - {k}) P_i$
          - 假设对于某个 $k$，$x_k in.not P_k$，则 $x_k$ 即为我们要找的在 $I -  union_i P_i$ 中的元素
          - 否则，令：
            $
            x = sum_k (product_(j != k) x_j)
            $
            对于每个 $k$，上式右侧恰有一个元素不落在 $P_k$ 中，从而 $x in.not P_k$，因此 $x$ 就是我们要找的元素
      + 用反证法，如若不然，则 $exists x_i in I_i, x_i in.not P$，考察：
        $
        x = product_i x_i
        $
        显然 $x in sect_i I_i subset P$，但每个 $x_i in.not P$，与素理想的定义矛盾！
      + 由上面的结论，$I sect (union_(P_i "is prime") P_i) subset union_(P_i "is prime") P_i => exists k, P_k "is prime", I sect (union_(P_i "is prime") P_i) subset P_k$\
        可以不妨假设只有一个素理想并且：
        - 没有其他理想：显然
        - 恰有一个其他理想 $Q$，也即：
          $
          I subset P union Q
          $
          假设 $I$ 不在其中任何一个，取 $x_P in I - P subset Q, x_Q in I - Q subset P$，显有：
          $
          x = x_P + x_Q
          $
          不在 $P, Q$ 中任何一个，但在 $I$ 中，矛盾！
        - 恰有两个其他理想 $Q_1, Q_2$，由之前的证明可知：
          $
          I subset P or I subset Q_1 union Q_2
          $  
          若前者成立则结论正确，若后者成立仿照前一种情况再次操作即可
    ]
    #corollary[][
      设 ${p_i} subset Spec(A)$，假设 ${p_i}$ 被有限个主开集 $union.big_n D(x_n)$ 所覆盖，则存在某一个主开集 $D(x)$ 覆盖住 ${p_i}$
    ]
  == 自由模
    #definition[自由模|free AModuleule][
      称一个自由 $A-$模是同构于：
      $
      plus.circle_(i in I) A
      $
      的模，指标集有限时也记为 $A^n$
    ]
    #theorem[][
      $M$ 是有限生成 $A-$模当且仅当 $M$ 同构于有限自由模的商模
    ]
    #proof[
      - 设 $M = sum_(i) A x_i$，构造：
        $
        funcDef(phi, A^n, M, (a_i), sum_(i) a_i x_i)
        $
        显然是满同态，因此 
        $
        A^n quo ker phi tilde.eq M
        $
      - 设 $M$ 同构于自由模的某个商模，则取 $phi:A^n -> M$ 是同态，容易验证：
        $
        M = sum_i A (phi(epsilon_i))
        $
        其中 $epsilon_i$ 为第 $i$ 位为 $1$ 其余为零的坐标
    ]

    #lemma[Nakayama][
      设 $M$ 是有限生成$AModule(A)$, $I$ 是 $A$ 的理想，$phi: M -> M$ 是同态满足 $phi(M) subset I M$，那么存在首一多项式 $f in I[x]$ 使得：
      $
      f(phi) = 0
      $

      特别的，取 $I = A$，则 $End_A (M)$ 中每一个元素都被某个多项式零化
    ]
    #proof[
      设 $M = sum_i A x_i$，注意到 $phi(x_i) in I M$，因此存在 $alpha_i in I^n$ 使得：
      $
      phi(x_i) = alpha_i^T X
      $
      其中 $X = vec(x_1, x_2, dots.v, x_n)$\
      验证：
      $
      sum_j (delta_(i j) phi - a_(i j))(x_j) = 0
      $
      也即：
      $
      phi(X) = vec(alpha_1^T, alpha_2^T, dots.v, alpha_n^T) X := B X\
      $
      这里 $B$ 是矩阵，当然可以被多项式零化。具体而言，有：
      $
      (phi I - B)X = 0\
      (phi I - B)^*(phi I - B) X = det(phi I - B) X = 0
      $
      注意到 $det(phi x - B) := f(x) in I[x]$ 首一 ，上式即是说：
      $
      (f(phi)) X = 0 => f(phi) = 0
      $ 
      得证
      
    ]
    #corollary[][
      设 $M, I$ 满足  $I M = M$，则 $exists x in A, x = 1 AModule I and x M = 0$
    ]
    #proof[
      在上面的于引理中取 $id: M -> I M$ 即可
    ]
    #corollary[Nakayama, another form][
      $M$ 有限生成，$I subset $ Jacob radical\
      若 $I M = M$, 则 $M = 0$
    ]
    #proof[
      根据引理，可获得 $x$ 满足 $x = 1 AModule I and x M = 0$\
      注意到 $x in 1 +$ Jacob radical 给出它是一个单位（@radicalForm），继而 $M = 0$
    ]
    #corollary[][
      $M$ 有限生成，$I subset $ Jacob radical, $N$ 是 $M$ 子模\
      若 $M = N + I M$ 则 $N = M$
    ]
    #proof[
      考虑 $M quo N$ 中，验证：
      $
      I dot (M quo N) = I dot (N + I M quo N) = M quo N
      $
      因此可以利用上面的引理
    ]
    #proposition[][
      设 $A$ 是局部环，唯一素理想是 $m$，$M$ 是有限生成 $AModule(A)$ 则：
      $
      M quo m M 是 A quo m "上的有限维向量空间"
      $
      同时，设 $x_i in M$ 在 $M quo m M$ 中的像生成构成线性空间的基，则它们也是 $M$ 的生成元
    ]
    #proof[

      设 $x_i$ 是这样一组基，取 $N = sum_i A x_i subset M$，取满同态 $phi: N -> M -> (M quo m) M$
      显然 $N quo m M = M quo m M$，因此有
      $
      N + m M = M
      $
      由上面的引理可知 $N = M$
    ]
  == 同调代数简介
    #definition[复形][
      设有一列 $AModule(A)$:
      $
      ... -> M_(i-1) ->^(f_i) M_i ->^(f_(i+1)) M_(i+1) ...\
      $
      
      - 称之为一个 复形|(cochain) complex，如果 $f_(i+1) compose f_i = 0 <=> im f_i subset ker f_(i+1)$
      - 称之为在 $i$ 处 正合|exact，如果 $im f_i = ker f_(i+1)$
      对一般的复形，定义：
      $
      H_i (M) = ker f_(i+1) quo im f_i
      $
      为（上）同调群，显然该处正合当且仅当 $H_i = {0}$
    ]
    #example[][
      - $0 -> M' ->^f M$ 正合当且仅当 $f$ 单射
      - $M ->^g -> M' -> 0$  正合当且仅当 $g$ 满射
      - $0 -> M' ->^f  M ->^g -> M'' -> 0$  正合当且仅当 $f$ 单射，$g$ 满射
      - 长正合列可以分裂，例如设 $... -> M_(i-1) ->^(f_i) M_i ->^(f_(i+1)) M_(i+1) ...$ 于该处正合，则令 $N_i = ker f_(i+1) = im f_i$，有：
        $
        0 -> N_i -> M_i -> im f_(i+1) = N_(i+1) -> 0
        $
        正合
    ]
    #theorem[正合判别法][
      在 $AModule(A)$ 范畴中：
      - $0 -> M' ->^mu M ->^nu M''$ 正合当且仅当任取 $AModule(A) space N$，序列：
        $
        0 -> Hom_A (M'', N) ->^(nu') Hom_A (M, N) ->^(mu') Hom_A (M', N) 
        $ 
        正合\
        换言之，如果将 $N -> Hom_A (M, N)$ 看作函子，则这个函子是左正合的\
        对偶的，函子 $M -> Hom_A (M, N)$ 是反变左正合的
    ]<exact-test>
    #proof[
        只证明一个方向，另一侧是类似的\
        设 $forall N in "AModule"_A, 0 -> Hom_A (M'', N) ->^nu' Hom_A (M, N) ->^mu' Hom_A (M', N) $ 正合，往证：
        $
        M' ->^mu M ->^nu M' -> 0
        $
        正合，只需验证：
        - $nu$ 是满射 $<=> M'' \/ im nu = 0$\
          取 $N = M'' \/ im nu$，注意到：
          $
          Hom_A (M'', N) ->^nu' Hom_A (M, N)
          $
          其中诱导的 $nu'$ 是单射（条件），取自然同态 $pi: M'' -> M'' \/ im nu in Hom_A (M'', N)$,发现：
          $
          nu'(pi) = pi compose nu = 0 => pi = 0 => M'' \/ im nu = 0
          $
          证毕
        - $im mu = ker nu$
          - 先证明 $im mu subset ker v$，事实上，注意到：
            $
            mu' compose nu' = 0 => (mu' compose nu')(*) = 0 => * compose nu compose mu = 0, forall * in M'' -> N
            $
            取 $* = id_M''$ 即得 $nu compose mu = 0$
          - 再证明 $ker nu subset im mu$，取 $N = M \/ im mu$ 和自然的同态 $pi: M -> N$，有：
            $
            pi compose mu = mu'(pi) =0 => pi in ker mu' = im nu' => pi = nu'(f) = f compose nu\
            ker(nu) subset ker(f compose nu) = ker(pi) = im nu
            $
            证毕
    ]
    
    #definition[（共变/反变函子|covarient/contravarient functor）][$F: "AModule"_A -> "AModule"_B$ 称为共变/反变函子，包括以下资料和性质：
      - $forall M in "AModule"_A, exists F M in "AModule"_B$
      - 共变函子是指： $forall phi in Hom_A (M, N), exists F(phi) in Hom_A (F M,F N)$，使得：
        $
        F(g compose h) = F(g) compose F(h)\
        F(id) = id
        $
        更进一步，如果 $F: Hom_A (M, N) -> Hom_B (F M, F N)$ 均是（模同态作为模的加法群）群同态，则称 $F$ 为加性函子
      - 反变函子是指 $forall phi in Hom_A (M, N), exists F(phi) in Hom_A (F N,F M)$ 满足：
        $
        F(g compose h) = F(h) compose F(g) \
        F(id) = id
        $
    ]
    #definition[正合函子][
      设 $F$ 是加性共变函子，$G$ 是加性反变函子，称 $F | G$ 是左正合函子，如果任给正合列：
      $
      0 -> M' -> M  -> M' 
      $，均有：
      $
      0 -> F M' -> F M -> F M'' \
      0 -> G M'' -> G M -> G M' 
      $
      正合\
      反之，若如果任给正合列：
      $
      M' -> M  -> M' -> 0
      $，均有：：
      $
      F M' -> F M -> F M'' -> 0\
      G M'' -> G M -> G M' -> 0
      $
      正合，则称为右正合函子\
      若函子同时左正合，右正合，则称之为正合函子，它保持所有正合列
    ]

    #example[][
      $Hom(M, *) : "AModule"_A -> "AModule"_A$ 是共变的加性函子，另一侧 $Hom(*, N)$ 是反变函子，它们都是左正合的
    ]
    #definition[导出函子][
      对于任意的左正合（加性）函子 $F$，一族函子 $"AModule"_A -> "AModule"_B$：
      $
      {R^i F : "AModule"_A -> "AModule"_B}
      $
      称为（右）导出函子，如果：
      - $R^0 F = F$
      - 任取短正合列：
        $
        0 -> X -> Y -> Z -> 0
        $
        有长正合列：
        $
        0 -> F X -> F Y -> F Z -> R^1 F X -> R^1 F Y -> R^1 F Z ->\ ... ->  R^n F X -> R^n F Y -> R^n F Z -> ... 
        $
      - 具有函子性，也若有交换图：
        $
        0 -> &X -> &&Y -> && Z -> 0\
        &arrow.b &&arrow.b &&arrow.b \
        0 -> &X -> &&Y -> && Z -> 0\
        $
        则上下两正合列对应的长正合列也交换
      
      给定右正合函子，其左导出函子 ${L_i F : "AModule"_A -> "AModule"_B}$ 也可以对偶地定义
    ]
    #example[][
      命题：若 $F$ 正合，则导出函子就是 $R^0 F = 0, R^i F = 0$ （这当然也是 $F$ 右正合的充要条件）因此一般的导出函子可以看作与正合函子的距离
    ]
    #definition[][
      $
      "Ext"^i (*, N) := R^i Hom(*, N)\
      "Ext"^i (M, *) := R^i Hom(M, *)
      $ 称为拓展组 (extension group)，显然需要验证从两种方法定义的 $"Ext"^i (M, N)$ 是相同的，这称之为 Balance property
      - 若 $Hom(M, *)$ 正合，则称 $M$ 是 投射|projective 模
      - 若 $Hom(*, N)$ 正合，则称 $N$ 是 入射|injective 模

    ]
  问题：何时 $Hom(*, N), Hom(M, *)$ 正合？

  既然上述两个函子都左正合，只要它们都右正合即可
  #proposition[][
    - $N$ 是入射模当且仅当任取单同态 $phi: X -> Y$，都有 $phi': Hom(Y, N) -> Hom(X, N)$ 是满射
    - $N$ 是投射模当且仅当任取满同态  $phi: X -> Y$，都有 $phi': Hom(N, X) -> Hom(N, Y)$ 是满射
  ]
  #proof[
    只证明第一条，第二条类似\
    - 假如它是入射模，则它应该保持正合列：
      $
      0 &-> X &&->^(phi) Y &&->^() Y quo im phi &&-> 0\
      0 &-> Hom(Y quo im phi, N) &&->^() Hom(Y, N) &&->^(phi') Hom(X, N) &&-> 0
      $
      蕴含 $phi'$ 是满射
    - 反之，任取正合列：
      $
      0 &-> X &&->^(phi_1) Y &&->^(phi_2) Z &&-> 0
      $
      往证：
      $
      0 &-> Hom(Z, N) &&->^(phi'_2) Hom(Y, N) &&->^(phi'_1) Hom(X, N) &&-> 0
      $
      的正合性，前面已经证明了左正合，这里只需要 $phi'_1$ 是满射就足够了，而这就是条件
  ]

  #proposition[提升性质][
    - $N$ 是入射模当且仅当任取单同态 $phi: X -> Y$ 和同态 $psi: X -> N$，存在 $psi': Y -> N$ 使得以下交换图表成立：
      #align(center)[#commutative-diagram(
      node((0, 0), $X$, "1"),
      node((0, 1), $Y$, "2"),
      node((1, 0), $N$, "3"),
      arr("1", "2", $phi$,inj_str),
      arr("2", "3", $exists psi'$),
      arr("1", "3", $psi$),
    )]
    - $M$ 是投射模当且仅当以下交换图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $X$, "1"),
      node((0, 1), $Y$, "2"),
      node((1, 0), $M$, "3"),
      arr("2", "1", $phi $, surj_str),
      arr("3", "2", $exists psi' $),
      arr("3", "1", $psi $),)]
  ]
  #proof[
    $
    phi' 满 <=> forall x: X -> N, exists y: Y -> N, x = y compose phi 
    $
    这就是之前的命题\
    $
    Y = ZZ, X = ZZ_p
    $
  ]
  
  事实上就是对于任何满射 $phi: X -> Y$，诱导的 $phi': Hom_A (M, X) -> Hom_A (M, Y)$ 也是满射，或者说对于所有 $phi: X- > Y$ 是满射和同态 $psi: M -> Y$，均存在 $psi' : M -> X$ 使得 $phi compose psi' = psi$

  #proposition[][
    设 $0 -> &X ->^f &&Y ->^g && Z -> 0$ 正合，
    + 若 $X$ 入射或 $Z$ 投射，则该正合列分裂，也即：
      $
      Y tilde.eq X plus.circle Z
      $
    + 若 $X$ 入射，则 $Y$ 入射 $<=> Z$ 入射; 若 $Z$ 投射，则 $Y$ 投射 $<=> X$ 投射 
  ]
  #proof[
    只证明入射一侧
    + 根据之前的性质，题上的正合列给出 $f$ 单射，因此有下面的交换图表：
      #align(center)[#commutative-diagram(
      node((0, 0), $X$, "1"),
      node((0, 1), $Y$, "2"),
      node((1, 0), $X$, "3"),
      arr("1", "2", $f$,inj_str),
      arr("2", "3", $exists f'$),
      arr("1", "3", $id$),
    )]
      进一步，有：
      $
      f' compose f = id => (id - f compose f')f = 0
      $
      表明 $im f = ker g subset ker (id - f compose f')$。 
      如下交换图表给出：
      #align(center)[#commutative-diagram(
      node((0, 0), $Y$, "1"),
      node((0, 1), $Z$, "2"),
      node((1, 0), $Y quo ker h$, "3"),
      node((1, 1), $g(Y) quo g (ker h)$, "4"),
      arr("1", "2", $g$),
      arr("1", "3", $$),
      arr("2", "4", $$),
      arr("3", "4", $$, bij_str),
      node((1, -1), $im g$),
      arr("3", $im g$, $$, bij_str),
      arr($im g$, "1", $$)
      )]
      存在 $r: Z -> Y$ 使得:
      $
      id - f compose f' = r compose g\
      g(id - f compose f') = g - (g compose f) compose f' = g = g (r g) = (g r) g
      $

      由于 $g$ 是满射，故有右逆，上式给出 $g r= id$\
      此外还有：
      $
      f f' + r g = id\
      $
      以下性质：
      $
      g f = 0\
      f f' + r g = id\
      f' f = id\
      g r = id
      $
      表明直积分解成立
    + 由于 $Y tilde.eq X plus.circle Z$ 故 $Hom(*, X) plus.circle Hom(*, Z) tilde.eq Hom(*, Y)$，再加上 $Hom(*, X)$ 是正合函子，因此当且仅当 $Hom(*, Z)$ 正合
  ]

  #proposition[][
    - 自由 $A-$模是投射模
    - 投射模都是自由模的直和
  ]<projective-module>
  #proof[
    - 设文字集为 $I$，有：
      $
      
      Hom(A^I, N) = product_I Hom_A (A, N) = product_I N
      $
    - 注意到可以找到满射：
      $
      f: plus.circle_(m in M) A &-> M\
      (a_m) &-> sum a_m m
      $
      这是满射，因此：
      $
      plus.circle_(m in M)A tilde.eq M plus.circle ker f
      $

  ]
  #theorem[Baer][
    $M$ 是入射模当且仅当任取 $A$ 的理想 $A$ 以及模同态 $I ->^phi M$，存在 $psi: A -> M$ 使得：
    $
    psi|_I = phi
    $

  ]
  #proof[

    - 若 $M$ 入射，则这就是之前讨论中的一种特殊情况
    - 反之，若延拓总是存在,令 $X = phi(I)$，利用 Zoun 引理找出所有入射：
      $
      Sigma = {X' subset Y | X subset X' subset Y "是子模，使得" X -> M "可延拓到" X' -> M}
      $
      验证条件后它将有极大元 $X'$，为了证明 $X' = Y$，如若不然，选出 $b in Y - X'$，希望作出延拓：
      $
      phi': X' + (b) -> M
      $
      为此，设 $I = {a in A | a b in X'} = (X' : b)$ 是理想，定义 $pi: (a : I) ->(phi(a b) : M)$，由条件将存在同态：
      $
      f: A -> M
      $
      则取 $phi'(x' + a b) = phi(x') + f(a b)$ 即可
  ]
  证明：
  #example[][
    - 设 $I = (a)$ 且 $m$ 入射，则有：
      $
      psi(a) = phi(a)\
      psi(a) = psi(a dot 1) = 
      $
    - 考虑 $"AModule"_ZZ$ 作为阿贝尔群的范畴，则直和函子将成为入射模
    - 设 $A$ 是环，$I$ 是入射 $ZZ$  模，则：
      $
      Hom_ZZ (A, I)
      $
      是入射 $A-$模\
      这是因为注意到：
      $
      Hom_A (M, Hom_ZZ (A, I)) tilde.eq Hom_ZZ (M, I)
      $
      同构如此给出：
      $
      f: (M -> I) -> (m -> [a -> f(a m)]): M ->Hom_ZZ (A, I)\
      g: (M -> Hom_ZZ (A, I)) -> (m -> (g(m))1) : 
      $

  ]

  #theorem[][导出函子存在且在同构的意义下唯一]

  #proof[
    考虑左正合函子的导出，如此定义 $R^i F$:
    - 首先，找到入射同态 $M -> I^0$  使得 $I^0$ 入射。只需取：
      $
      I' = Hom_ZZ (A, times.circle/ZZ)
      I^0 = product_(Hom_A (M, I')) I'\
      phi(m) =product_(f in Hom_A (M, I')) f(m)
      $
    - 反复进行如上步骤，找到正合列：
      $
      0 -> M -> I^0 -> I^1 -> ...
      $
      使得 $I^i$ 都是入射模
    - 定义：
      $
      R^i F(M) = H^i (0 -> F I^0 -> F I^1-> ... )
      $
      （第 $i$ 个位置的同调群）
      由 $F$ 左正合：
      $
      0 -> F M -> F I^0 -> F I^1
      $
      正合，可得 $H^0 (0 -> F I^0 -> F I^1-> ... ) = F M$，表明 $R^0 F = F$\
      之后的证明要把短正合列延长至长正合列，具体细节在下半学期补充]
  
  #lemma[Snake Lemma|蛇形引理][
    设 $A$ 是环，图：
    #align(center)[#commutative-diagram(
    node((0, 0), $0$, "1"),
    node((1, 0), $Y'$, "3"),
    node((1, 1), $X'$, "4"),
    node((2, 0), $Y$, "5"),
    node((2, 1), $X$, "6"),
    node((3, 0), $Y''$, "7"),
    node((3, 1), $X''$, "8"),
    node((4, 1), $0$, "9"),
    arr("1", "3", $$),
    arr("4", "3", $alpha$),
    arr("3", "5", $mu$),
    arr("4", "6", $f$),
    arr("6", "5", $beta$),
    arr("5", "7", $nu$),
    arr("6", "8", $g$),
    arr("8", "7", $gamma$),
    arr("8", "9", $$),
    
    )
    
    ]
    是两个正合列，按照如下方式定义 $delta: ker gamma -> coker alpha$，任取 $x' in X''$
    - 由 $g$ 是满射，存在 $x$ 使得 $g(x) = x''$
    - 令 $y = beta(x)$，则：
      $
      nu(y) = nu(beta(x)) = gamma(g(x)) = gamma(x'') = 0
      $
      因此 $y in ker nu$
    - 由 $ker nu = im mu$，可取 $y' in Y'$ 使得 $mu(y') = y$，定义：
      $
      delta(x'') = overline(y')
      $
    为了保证这是良定义的，第三步 $y'$ 对应的等价类当然是唯一的，我们需要验证第一步 $x$ 的取法不影响结果。事实上:
    - 设 $g(x_1) = g(x_2) = x'' => x_1 - x_2 in ker g = im f$，因此存在 $x'$ 使得 $f(x') = x_1 -x_2$
    - 从而：
      $
      y_1 - y_2 = beta(x_1 - x_2) = beta(f(x')) = mu(alpha(x'))\
      mu(y'_1 - y'_2) = y_1 - y_2 = mu(alpha(x'))\
      $
      而 $mu$ 是单射，因此：
      $
      y'_1 - y'_2 = alpha(x) in im(alpha)
      $
      它们当然在 $coker(alpha)$ 中对应相同的等价类
    
    我们将有结论：
    - #align(center)[#commutative-diagram(
      node((1, 0), $ker alpha$, "3"),
      node((1, 1), $coker alpha$, "4"),
      node((2, 0), $ker beta$, "5"),
      node((2, 1), $coker beta$, "6"),
      node((3, 0), $ker gamma$, "7"),
      node((3, 1), $coker gamma$, "8"),
      arr("3", "5", $f$),
      arr("4", "6", $mu$),
      arr("5", "7", $g$),
      arr("6", "8", $nu$),
      arr("7", "4", $delta$)
      )
      
      ]
      给出正合列
    - 若 $$
  ]
  #proof[
    - 除了 $delta$ 处之外的结论都是显然的，只证明 $delta$ 处。有：
      $
      delta(x'') = 0 <=> exists x' in X', x - x' in ker(alpha) \
      <=> x'' in im(ker beta -> ker gamma)
      $
      $
      overline(y') in ker(coker(alpha) -> coker(beta)) <=> exists x_0 in X, beta(x_0) = mu(y')\
      => exists x_0 in X, gamma(g(x_0)) = mu(beta(x_0)) = nu(mu(y') = 0)\
      => exists x_0 in X, x'' = g(x_0) in ker gamma
      $
  ]
  有时通过蛇引理得到的正合列是自然的/典范的/函子的，因为若两组符合蛇引理条件的正合列之间有态射，则蛇引理给出的两个正合列之间也有相应的态射

  #theorem[同调代数基本定理][
    设 $A$ 是环，$0 -> X^* ->^f Y^* ->^g Z^* -> 0 $ 是模的复形的正合列
        #align(center)[#commutative-diagram(
    node((0, 0), $0$, "1"),
    node((0, 1), $0$, "2"),
    node((1, 0), $X^(n)$, "3"),
    node((1, 1), $X^(n-1)$, "4"),
    node((2, 0), $Y^n$, "5"),
    node((2, 1), $Y^(n-1)$, "6"),
    node((3, 0), $Z^n$, "7"),
    node((3, 1), $Z^(n-1)$, "8"),
    node((4, 1), $0$, "9"),
    node((4, 0), $0$, "10"),
    arr("1", "3", $$),
    arr("2", "4", $$),
    arr("4", "3", $alpha^n$),
    arr("3", "5", $mu$),
    arr("4", "6", $f$),
    arr("6", "5", $beta^n$),
    arr("5", "7", $nu$),
    arr("6", "8", $g$),
    arr("8", "7", $gamma^n$),
    arr("8", "9", $$),
    arr("7", "10", $$),
    
    )
    ]
    蛇引理给出正合列：
    #align(center)[#commutative-diagram(
      node((1, 0), $ker alpha^n$, "3"),
      node((1, 1), $coker alpha^n$, "4"),
      node((2, 0), $ker beta^n$, "5"),
      node((2, 1), $coker beta^n$, "6"),
      node((3, 0), $ker gamma^n$, "7"),
      node((3, 1), $coker gamma^n$, "8"),
      arr("3", "5", $$),
      arr("4", "6", $$),
      arr("5", "7", $$),
      arr("6", "8", $$),
      arr("7", "4", $delta$)
      )
      
    ]
    #TODO

    最终给出上同调群的长正合列：
    #align(center)[#commutative-diagram(
      node((0, 0), $dots.v$, "2"),
      node((1, 0), $H^(n-1)(X)$, "3"),
      node((1, 1), $H^n (X)$, "4"),
      node((2, 0), $H^(n-1) (Y)$, "5"),
      node((2, 1), $H^n (Y)$, "6"),
      node((3, 0), $H^(n-1) (Z)$, "7"),
      node((3, 1), $H^n (Z)$, "8"),
      node((4, 1), $dots.v$, "9"),
      arr("3", "5", $$),
      arr("4", "6", $$),
      arr("5", "7", $$),
      arr("6", "8", $$),
      arr("7", "4", $delta^n$),
      arr("2", "3", $$),
      emptyArrow(2, 3),
      emptyArrow(8, 9),      )
      
    ]
  ]
  #corollary[][
    - 若 $X^*, Y^*, Z^*$ 之中有两个已经正合，则第三个也正合
    - （9-Lemma）设三列短正合列有：
      $
      0 -> X^* -> Y^* -> Z^* -> 0
      $
      - 若三者中间项构成的行正合，则上下行有相同的正合性
      - 若上下两行正合，并且中间行是复形，则三行都是正合的
  ]

  #lemma[5-lemma][
    设有交换图上下行都正合：
    #align(center)[#commutative-diagram(
    node((0, 0), $X_0$, 0),
    node((0, 1), $X_1$, 1),
    node((0, 2), $X_2$, 2),
    node((0, 3), $X_3$, 3),
    node((0, 4), $X_4$, 4),
    node((1, 0), $Y_0$, 5),
    node((1, 1), $Y_1$, 6),
    node((1, 2), $Y_2$, 7),
    node((1, 3), $Y_3$, 8),
    node((1, 4), $Y_4$, 9),
    arr(0, 0 + 1, $u_0$),
    arr(1, 1 + 1, $u_1$),
    arr(2, 2 + 1, $u_2$),
    arr(3, 3 + 1, $u_3$),
    arr(0 + 5, 0 + 6, $v_0$),
    arr(1 + 5, 1 + 6, $v_1$),
    arr(2 + 5, 2 + 6, $v_2$),
    arr(3 + 5, 3 + 6, $v_3$),
    arr(0, 0 + 5, $f_0$),
    arr(1, 1 + 5, $f_1$),
    arr(2, 2 + 5, $f_2$),
    arr(3, 3 + 5, $f_3$),
    arr(4, 4 + 5, $f_4$),)]
    - 若 $f_0$ 满，$f_1 f_3$ 是单射，则 $f_2$ 单射
    - 若 $f_4$ 单，$f_1 f_3$ 是满射，则 $f_2$ 满射
    - 特别的，若 $f_0$ 满，$f_4$ 单，$f_1 f_3$ 是双射，则 $f_2$ 是双射
  ]
  #proof[
    - 
      $
      forall x_2 in X_2, f_2 (x_2) = 0 &=> f_3 (u_2 (x_2)) = v_2 (f_2 (x_2)) = 0\
      &=> u_2 (x_2) = 0\
      &=> exists x_1 in X_1,x_2 = u_1 (x_1)\
      & quad=> f_2 (u_1 (x_1)) = nu_1 (f_1 (x_1)) = 0\
      & quad=> f_1 (x_1) in ker v_1 = im v_0\
      & quad=> exists y_0 in Y_0, nu_0 (y_0) = f_1 (x_1)\
      & quad quad => exists x_0 in X_0, f_0 (x_0) = y_0\
      & quad quad quad =>nu_0 (f_0 (x_0)) = f_1 (x_1) = f_1 (u_0 (x_0))\
      & quad quad quad =>x_1 = u_0 (x_0)\
      & quad  => x_1 in im u_0 = ker u_1\
      & quad  => u_1(x_1) = 0\
      &  => x_2 = 0\
      $
    - 
      $
      y_2 in Y_2 &=> exists x_3 in X_3, v_2 (y_2) = f_3 (x_3)\
      &quad => v_3 (f_3 (x_3)) = v_3 (v_2 (y_2)) = 0 = f_4 (u_3 (x_3))\ 
      &quad => u_3 (x_3) = 0\ 
      &quad => exists x_2 in X_2, u_2(x_2) = x_3\ 
      &quad quad =>v_2 (y_2) = f_3 (x_3) = f_3 (u_2 (x_2))=v_2 (f_2 (x_2))\ 
      &quad quad =>y_2 - f_2 (x_2) in ker v_2 = im v_1\ 
      &quad quad quad =>exists x_1 in X_1 y_2 - f_2 (x_2) = v_1 (f_1 (x_1))=f_2 (u_1 (x_1))\ 
      &quad quad quad =>exists x_1 in X_1 y_2 = f_2 (x_2 + u_1 (x_1))\ 
      & => y_2 = im f_2\ 
      
      $
  ]

  #remark[Diagram Chasing][
    Diagram chasing（追图）是常见的证明正合列的方法，也即在交换图上追踪对象。以上两个引理的证明即体现了这个思想
  ]
= 局部化
  == 环的局部化
  设 $X = Spec(A), x in X$ 往往看作点，此时 $A$ 可以看作 $X$ 上的全局同态函数。当然，我们也应该考虑在 $x$ 邻域处的同态函数，这就是局部化（localization）的思想
  #definition[乘法封闭|multiclosed][
    称 $S subset A$ 乘法封闭，如果 $1 in S$ 且 $S$ 关于乘法封闭
  ]
  #example[][
    - 设 $p$ 是素理想，则 $A - p$ 是乘法封闭的
    - 设 $f in A$，则 $union_(n in NN) {f^n}$ 是乘法封闭的
  ]
  #let InvSA = $Inv(S) A$
  #definition[][
    设 $S subset A$ 乘法封闭，则存在环 $Inv(S) A$ 以及同态 $phi: A -> Inv(S) A$ 满足以下的泛性质：
    - $phi(S) in U(InvSA)$
    - 若 $g : A -> B$ 满足 $g(S) subset U(B)$，则存在唯一的同态 $g' : InvSA -> B$ 使得：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $B$, 2),
      node((1, 0), $InvSA$, 3),
      arr(1, 2, $g$),
      arr(3, 2, $exists ! g'$),
      arr(1, 3, $phi$),)]
    称该环为 $A$ 关于 $S$ 的局部化/分式环
  ]
  #proof[
    - 先给出 $InvSA$ 的构造，先定义集合：
      $
      InvSA = S times A quo ~ := {a/s}\
      (a_1, s_1) ~ (a_2, s_2) <=> exists s in S, s(a_1 s_2 - a_2 s_1) = 0
      $
      这里乘以 $s$ 是因为环中未必有消去律，可以验证它确实是等价关系
    - 再给出环运算，完全仿照分式的运算定义：
      $
      (a_1/s_1) + (a_2/s_2) = (a_1 s_2 + a_2 s_1) / (s_1 s_2)\
      (a_1/s_1) * (a_2/s_2) = (a_1 a_2) / (s_1 s_2)
      $
      并且 $1/1$ 是其中单位。可以验证它这些运算良定义并且满足环的公理
    - 定义:
      $
      funcDef(phi, A, InvSA, a, a/1)
      $
      显然：
      $
      forall s in S, phi(s) * 1/s = 1
      $
      因此满足要求
    - 最后验证泛性质，定义：
      $
      funcDef(g', InvSA, B, a/s, g(a) / g(s))
      $
      注意到 $g(s)$ 是可逆元，定义是有意义的。\
      可以验证它是良定义的同态，并且确实满足交换图表。\
      同时定义当然是唯一的，因为：
      $
      g'(a/1) = g'(phi(a)) = g(a)\
      g'(a/s) = g'(a/1) * g'(1/s) = g(a) * g(s)^{-1} = g(a) / g(s)
      $
      因此同态已经被唯一确定
  ]
  #remark[][
    - 注意 $phi$ 未必是单射，因此 $phi(a) = a/1 = 0 <=> exists s in S, s a = 0$\
      显然在一般的环中不能保证 $phi$ 是单射，但是在整环中，$phi$ 是单射
    - 若 $s in S$ 幂零，则 $phi(s)^n = 0$ 可逆，意味着 $InvSA = 0$
  ]
  #definition[][
    - 设 $p$ 是素理想，则称 $A_p = Inv((A - p)) A$，并有 $A_p$ 是局部环，唯一的极大理想便是 $p A_p$
    - $A_f = Inv({f_n}) A = A[1/f] = A[x] quo (x f - 1)$ 也是分式环
    - $ZZ_((p)) = {m/n | (p, n) = 1}$ 是素理想生成的局部化
  ]
  #proof[
    只要证明 $A_p quo p A_p$ 是域，任取其中元素：
      $
      a/s + p A_p = (a + p)/s
      $
      - $a in p => (a + p)/s = 0$
      - $a in.not p => a/s$ 可逆
      因此结论成立
  ] 
  == 模的局部化
  #definition[模的局部化][
    设 $S subset A$ 乘法封闭，则有函子：
    $
    Inv(S) : Mod_A -> Mod_(InvSA)
    $
    及交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $M$, 1),
    node((0, 1), $Inv(S) A$, 2),
    node((1, 0), $N$, 3),
    node((1, 1), $Inv(S) N$, 4),
    arr(1, 2, $$),
    arr(1, 3, $f$),
    arr(2, 4, $exists f'$),
    arr(3, 4, $$),)]
  ]
  #theorem[][
    $Inv(S)$ 是正合函子
     
  ]
  #proof[
    给定正合列：
      $
      M' ->^f M ->^g M''
      $
      验证：
      $
      Inv(S) M' ->^f' Inv(S) M ->^g' Inv(S) M''
      $
      也正合
      - $Inv(S) g compose Inv(S) f = Inv(S)(g compose f) = 0$，至少是复形
      - 只需证明 $im Inv(S) f supset ker Inv(S) g$，为此
    
  ]
  #corollary[][
    - $Inv(S)(N quo M) tilde.eq (Inv(S) N) quo (Inv(S) M)$
    - $Inv(S) (N sect P) = Inv(S) N sect Inv(S) P$
    - $Inv(S) (N + P) = Inv(S) N + Inv(S) P$
  ]
  #proof[
    - 注意到：
      $
      0 -> M -> N -> N quo M -> 0
      $
      正合，由上面的命题知：
      $
      0 -> Inv(S) M -> Inv(S) N -> Inv(S) (N quo M) -> 0
      $
      正合，因此结论成立

    - 利用正合列:
      $
      0 -> N sect P -> M -> M quo N times M quo P 
      $
      得到：
      $
      0 -> Inv(S) (N sect P) -> Inv(S) M -> Inv(S) (M quo N times M quo P) -> 0
      $
      正合，在最后一项将 $Inv(S)$ 换入即可
    
    - 利用正合列:
      $
      0 -> N plus.circle  P -> M -> M quo (N + P) -> 0
      $
      得到：
      $
      0 -> Inv(S) (N plus.circle P) -> Inv(S) M -> Inv(S) (M quo (N + P)) -> 0
      $
      利用事实 $N+P = im(N plus.circle P -> M )$ 再次换入即可
  ]
  #theorem[][
    设 $M$ 是一个有限表示，也即存在正合列：
    $
    A^p -> A^q -> M -> 0
    $
    则：
    $
    Inv(S) Hom_A (M, N) tilde.eq Hom_(InvSA) (Inv(S) M, Inv(S) N)
    $
  ]
  #proof[
    由条件依次得到正合列：
    $
    0 -> Hom_A (M, N) -> Hom_A (A^q, N) -> Hom_A (A^p, N) -> 0\
    0 -> Inv(S) Hom_A (M, N) -> Inv(S) Hom_A (A^q, N) -> Inv(S) Hom_A (A^p, N) -> 0
    $
    但是可以验证：
    $
    Inv(S) Hom_A (A^p, N) tilde.eq plus.circle Inv(S) N tilde.eq  Hom_(InvSA) (Inv(S) A^p, Inv(S) N)
    $
    得到：
    #align(center)[#commutative-diagram(
    node((0, 0), $0$, 1),
    node((0, 1), $Hom_A (M, N)$, 2),
    node((0, 2), $Hom_A (A^p, N)$, 3),
    node((0, 3), $Hom_A (A^q, N)$, 4),
    node((1, 0), $0$, 5),
    node((1, 1), $Hom_(Inv(S) A)(Inv(S) M, Inv(S), N)$, 6),
    node((1, 2), $Hom_(Inv(S) A)(Inv(S) A^p, Inv(S), N)$, 7),
    node((1, 3), $Hom_(Inv(S) A)(Inv(S) A^q, Inv(S), N)$, 8),
    arr(1, 2, $$),
    arr(2, 3, $$),
    arr(3, 4, $$),
    arr(5, 6, $$),
    arr(6, 7, $$),
    arr(7, 8, $$),
    arr(2, 6, $$),
    arr(3, 7, $$, bij_str),
    arr(4, 8, $$, bij_str),)]
    利用 5-Lemma 即可
  ]
  #proposition[][
    $M -> product_(m in "Max" (A)) M_m$ 是单射 
  ]
  #proof[
    换言之，需要证明：
    $
    forall x in M, (forall m in "Max"(A), x = 0 in M_m -> x = 0)
    $
    如若不然，取 $I = "Ann"(x) != (1)$，取包含 $I$ 的极大理想 $m$，有：
    $
    x/1 = 0 => exists t in A - M, t x = 0 => exists t in A -M, t in I
    $
    这与 $I subset m$ 矛盾！
  ]
  #corollary[][
    以下事实等价：
    - $M = 0$
    - $M_p = 0, forall p in Spec(A)$
    - $M_m = 0, forall m in "Max"(A)$
  ]
  #corollary[][
    对于 $AModule(A)$同态 $phi$，它是单/满/双射当且仅当在所有素理想/极大理想的局部环中是单/满/双射
  ]
  #remark[][
    像这样性质 $P$ 成立当且仅当它在所有素理想/极大理想的局部化中成立的性质被称作局部性质（local property）
  ]
  == 分式环的素理想
    #proposition[][
      - $I(InvSA) = (1) <=> S sect I != emptyset$
      - $Spec (InvSA) = {p InvSA | p in Spec(A) and p sect S = emptyset}$
      - $Inv(S) sqrt(I) := sqrt(Inv(S) I)$
    ]
    #proof[
      +
        - 设 $I(InvSA) = (1)$，则存在 $1 = i /s$，表明：
          $
          exists s' in S, s'(a - s) = 0 => s' a = s' s
          $
          则 $s' a = s' s in I sect S$
        - 
      + 注意到存在自然同态 $f: A -> Inv(S) A$，从而诱导同态：
        $
        f': Spec(Inv(S) A) -> Spec(A)
        $
        同时，断言 $f'(q) = Inv(f)(q) sect S = emptyset$，否则 $q$ 中将存在单位，这当然是不可能的\
        另一方面，设 $p in Spec(A)$ 并且 $p sect S = emptyset$，我们断言 $Inv(S) p$ 是素理想，也即：
          $
          Inv(S) A quo Inv(S) p = Inv(S) (A quo p) 
          $
          是整环，但是注意到 $A quo p$ 已经是整环，它的局部化当然也是整环
      
    ]
    #corollary[][
      $
      Spec(A_p) = {q A_p | q in Spec(A) and q sect A - p = emptyset}\
      = {q A_p | q in Spec(A) and q subset p}
      $
    ]
    #proposition[][
      设 $S subset A$ 是乘法子集，$M$ 是有限生成 $AModule(A)$，则：
      - $Inv(S) "Ann"_A (M) = "Ann"_(InvSA) (Inv(S) M)$
      - $Inv(S) (N : P) = Inv(S) N : Inv(S) P$
    ]
    #proof[
      设 $M = sum A x_i$，注意到：
      $
      Inv(S) "Ann"(M) = Inv(S) sect.big "Ann"(x_i)\
      = sect.big Inv(S) "Ann"(x_i)\
      = sect.big "Ann"_(Inv(S) A) (x_i / 1)\
      = "Ann"_(Inv(S) A) (Inv(S) M) 
      $
      因此结论一成立

      对于下一个结论，注意到：
      $
      N :P = "Ann" ((N + P) quo N)
      $
      以及有限生成模的商模仍然是有限生成，因此结论自然成立
    ]
= 张量积
  == 构造与性质
    #definition[双线性|bilinear][
      设 $M, N$ 是 $AModule(A)$，称 $f: M times N -> P$ 双线性，如果：
      $
      f(x, *), f(*, y)
      $
      都是线性的
    ]
    张量积的目的是希望将双线性映射转换成某种线性映射
    #definition[][
      设 $M, N$ 是 $AModule(A)$，定义张量积为 $(T, g)$，其中 $T$ 为 $AModule(A)$而 $g$ 是双线性映射 $M times N -> T$，并且满足泛性质：
      $
      forall (D, f):Mod_A times (M times N -> D)
      $
      有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $M times N$, 1),
      node((0, 1), $D$, 2),
      node((1, 0), $T$, 3),
      arr(1, 2, $f$),
      arr(3, 2, $exists !f'$),
      arr(1, 3, $g$),)]
      此时记 $T = M times.circle_A N$，
    ]
    #proposition[][
      上面定义的张量积存在且在同构的意义下唯一
    ]
    #proof[
      - 唯一性由它是范畴的始对象给出
      - 存在性由如下构造给出
        - 令 $C$ 是 $M times N$ 中元素生成的自由 $AModule(A)$
          $
          C = {sum a_i (x_i, y_i)}
          $
          令 $C$ 是
        
    ]
    #proposition[][
      张量积函子 $- times.circle N, M times。circle -$ 是右正合的，但未必左正合
    ]
    #proof[

    ]
    #corollary[][
      设有限个 $x_i in M, y_i in N$ 使得 $sum x_i tensorProduct y_i = 0 in M tensorProduct N$，则存在有限生成子模 $M_0 subset N$ 和有限生成子模 $N_0 subset N$ 使得 $sum x_i tensorProduct y_i = 0 in M_0 tensorProduct N_0$
    ]<zero-tensor-product-fg>
    #proof[
      由张量积的构造：
      $
      sum x_i tensorProduct y_i = 0 => sum (x_i, y_i) in D
      $
      而 $sum (x_i, y_i) in D$ 是 $D$ 中元素的有限和，设：
      - $M_0$ 由 $x_i$ 生成，且第一个坐标落在有限和之中
      - $N_0$ 由 $y_i$ 生成，且第二个坐标落在有限和之中
      从而当然有：
      $
      sum x_i tensorProduct y_i = 0 in M_0 tensorProduct N_0
      $
    
    ]
    这样的定义完全可以推广到多重线性函数，给出多重的张量积，将其记作 $tensorProduct_i M_i$。然而还有一种自然的构造方式 $(((M_1 tensorProduct M_2) tensorProduct M_2) ...) tensorProduct M_r$，下一个命题给出了它们的一致性
    

    #proposition[][
      + $M tensorProduct N tilde.eq N tensorProduct M$
      + $(M tensorProduct N) tensorProduct P tilde.eq M tensorProduct(N tensorProduct P) tilde.eq M tensorProduct N tensorProduct P$
      + $(M plus.circle N) tensorProduct P tilde.eq (M tensorProduct P) plus.circle (N tensorProduct P) $
      + $A tensorProduct M tilde.eq M$，映射如下给出：
        $
        funcDef(phi, A tensorProduct M, M, a tensorProduct m, a m)
        $
      + 设 $N$ 是 $A, B-$ 模，则：
        $
        (M tensorProduct_A N) tensorProduct_B P tilde.eq M tensorProduct_A (N tensorProduct_B P)
        $
    ]
    #proof[
      + #TODO
      + #TODO
      + #TODO
      + 验证 $Hom(A tensorProduct M, P) tilde.eq Hom(M, P)$
      + #TODO
    ]
  == 标量的限制与扩张 restriction/extension of scalar
    #definition[限制][
      设 $f: A -> B$ 是环同态，$N$ 是 $AModule(B)$，则可以自然导出 $N$ 的 $AModule(A)$ 性，由：
      $
      A times N -> B times N -> M
      $
      这个模被称为标量限制
    ]
    #definition[扩张][
      设 $f: A -> B$ 是环同态，给出函子：
      $
      funcDef(f, Mod_A, Mod_B, M,  B tensorProduct_A M := M_B)
      $
      称为扩张
    ]
    #proposition[][
      设 $M$ 是有限生成 $AModule(A)$，则扩张 $M_B$ 也是有限生成 $AModule(A)$，但限制未必
    ]
    #proposition[][
      设 $Inv(S) A$ 是分式环，有：
      $
      Inv(S) A tensorProduct_A M tilde.eq Inv(S) M
      $
      映射由：
      $
      f: (a/s, m) -> (a m)/s
      $
      给出
    ]
    #proof[
      + 首先给出直接的证明，先证明 $Inv(S) A tensorProduct_A M$ 总可以写成 $1/s tensorProduct m$ 的形式\
        事实上，由定义张量积均形如：
        $
        sum_i a/s_i tensorProduct m_i 
        $
        通分化为：
        $
        sum_i 1/s tensorProduct (a_i t_i m_i)
        $
        这就是我们要的形式，进而表明 $f$ 是满射\
        再证明 $f$ 是单射，注意到：
        $
        f(1/s tensorProduct m) = 0\
        => exists t in S, t m = 0\
        => t/s tensorProduct m = t/(s t) tensorProduct m = 1/(s t) tensorProduct t m = 0
        $
        得证
    ]
    #theorem[][
      函子 $Inv(S)$ 保持张量积，换言之：
      $
      Inv(S) M tensorProduct_(Inv(S) A) Inv(S) N tilde.eq Inv(S) (M tensorProduct_A N)
      $
      映射由：
      $
      m/s tensorProduct n/t -> (m tensorProduct n)/(s t)
      $
      给出
    ]
    #proof[
      $
      Inv(S) M tensorProduct_(Inv(S) A) Inv(S) N t\
      tilde.eq (Inv(S) A tensorProduct M) tensorProduct_(Inv(S) A) (Inv(S) A tensorProduct N)\
      tilde.eq Inv(S) tensorProduct_A (M tensorProduct N)\
      tilde.eq Inv(S) (M tensorProduct N)
      $
      我们证明了它们之间存在同构，容易验证该同构只能是上述形式
    ]
  == $Hom, tensorProduct$ 的伴随性
    #definition[][
      设 $T: Mod_A -> Mod_B, U = Hom_A (N, -)$ ，称 $(T, N)$ 是伴随对，如果：
      $
      Hom_B (T M, P) tilde.eq Hom_A (M, U P), forall M, P
      $
    ]
    #theorem[][
      设 $M, N, P$ 是 $AModule(A)$，则有自然同构：
      $
      Hom(M tensorProduct N, P) &tilde.eq Hom(M, Hom(N, P))\
      (f: M tensorProduct N -> P) &->[ m -> [n -> f(m tensorProduct n)]]\
      ([(m, n) -> phi(m)(n)]arrow.t) &<- phi 
      $
    ]
    #corollary[][
      $- tensorProduct N$ 是右正合函子
    ]
    #proof[
      设:
      $
      E := M' -> M -> M'' -> 0
      $
      是正合列，往证：
      $
      E tensorProduct N = M' tensorProduct N -> M tensorProduct N -> M'' tensorProduct N -> 0
      $
      正合，由 @exact-test 只需证明：
      $
      Hom(E tensorProduct N, P)
      $
      对于任意 $P$ 正合，而上式等价于
      $
      Hom(E, Hom(N, P))
      $
      再由 @exact-test，这显然成立
    ]
    #remark[][
      - 右正合意味着张量积函子可以产生左导出函子，记 $"Tor"_i^A (M, N) := L_i (- tensorProduct_A N) (M)$\
        $"Tor"_i^A (M, N) := H_i (... -> P_1 tensorProduct N -> P_0 tensorProduct N )$
      - 然而，张量积本身往往不是左正合的，例如 $f: x -> 2 x$ 是单射，但：
        $
        ZZ tensorProduct ZZ_2 ->^f' ZZ tensorProduct ZZ_2  
        $
        不是单射（事实上，是零映射）
    ]
  == 平坦模
    #definition[平坦模|flat][
      以下性质等价
      + 张量积函子 $- tensorProduct N$ 是正合的
      + 任意正合列 $E$，张量积 $E tensorProduct N$ 也是正合的
      + 设 $M' ->^f M$ 是单射，则 $M' tensorProduct N ->^f M tensorProduct N$ 也是单射
      + 对于任意 $M, M'$ 有限生成，$M' ->^f M$ 单导出 $M' tensorProduct N ->^f M tensorProduct N$ 也是单射
      + 任意有限生成理想 $I subset A$，序列 $0 -> I tensorProduct M -> M$ 正合（也即 $I M tilde.eq I tensorProduct M$
      此时，称 $N$ 是平坦模
    ]
    #proof[ 
      只证明 $4 => 3$，假设 $M' ->^f M$ 是单射，往证 $M' tensorProduct N ->^f' M tensorProduct N$ 单
      
      设 $u = sum x_i tensorProduct y_i in ker (f') => 0 = sum f(x'_i) tensorProduct y_i$，由 @zero-tensor-product-fg 知存在有限生成子模 $M_0$ 使得 $0 = sum f(x'_i) tensorProduct y_i in M_0 tensorProduct N$，由于 $f$ 在有限生成模上的提升是单射，$x'_i = 0$，因此 $u = 0$
    ]
    #proposition[平坦性是局部性质][
      以下命题等价：
      - $M$ 是平坦模
      - 对于任意素理想 $p$，$M_p$ 是平坦模
      - 对于任意极大理想 $m$，$M_m$ 是平坦模
    ]
    #proof[
      + $1 => 2$：注意到局部化函子 $(-)_p$ 也是正合函子，则复合也是正合函子，而它们的复合恰为：
       $
       (- tensorProduct_A M)_p = (-)_p tensorProduct_(A_p) M_p
       $
       证毕
      + $2 => 3$ 显然
      + $3 => 1$：\
        设 $N ->^f P$ 是单射，往证 $N tensorProduct M ->^f P tensorProduct M$ 也是单射\
        之前已经证明单射是局部性质，只需要验证 $(N tensorProduct M)_m -> (P tensorProduct M)_m$ 是单射即可，但：
        $
        (N tensorProduct M)_m -> (P tensorProduct M)_m\
        <=> (N_m tensorProduct M_m) -> (P_m tensorProduct M_m)\
        $
        由条件，结论显然成立
    ]
    #proposition[][
      平坦模的扩张仍是平坦模
    ]
    #proof[
      设 $N -> P$ 是单射，往证 $N tensorProduct M_B -> P tensorProduct M_B$ 是单射
    ]
    #proposition[][
      投射模都是平坦模
    ]
    #proof[
      前面 @projective-module 给出投射模是自由模的直和，而自由模是平坦的，它的直和也是平坦的
    ]
    #definition[忠实平坦|faithful flat][
      以下等价的事实成立：
      + 复形 $E$ 正合当且仅当 $E tensorProduct M$ 正合
      + $M$ 是平坦模且任意非零 $AModule(A) space N$，有 $M tensorProduct N != 0$ 
      则称 $M$ 是忠实平坦模
    ]
    #proof[
      
    ]
    #proposition[][
      自由模是忠实平坦的
    ]
    #lemma[][
      任取投射模构成的正合列：
      $
      ... -> P_2 -> P_1 -> P_0 -> N -> 0
      $
      则：
      $
      "Tor"_i^A (M, N) = H_i (... -> P_2 tensorProduct M -> P_1 tensorProduct M  -> 0)
      $
    ]
    #proof[
      #TODO
    ]
    #theorem[][
      以下事实等价：
      + $M$ 平坦
      + $forall N in Mod_A, "Tor"_1^A (M, N) = 0$
      + 任意有限生成理想 $I subset A$，序列 $0 -> I tensorProduct M -> M$ 正合（也即 $I M tilde.eq I tensorProduct M$
      + 任意有限生成理想 $I subset A$，$"Tor"_1^A (M, A quo I) = 0$
      + 任何有限生成 $AModule(A)$，有 $"Tor"_1^A (M, N) = 0$
      + 若 $a_i in A, x_i in M$，且：
        $
        sum_(i=1)^r a_i x_i = 0
        $
        则：
        $
        exists s >= 1, b_(i_j) in A, y_j in M, 1 <= j <= s, s.t.\
        x_i = sum_j b_(i_j) y_j\
        sum_i a_i b_(i_j) = 0, forall j
        $
    ]
    #proof[
      - $1 => 2, 2 => 3$ 显然\
      - $3 <= 4$，注意到：
        $
        0 -> I -> A -> A quo I -> 0
        $
        正合，无论如何都有长正合列：
        $
        "Tor"_1^N (A, M) -> "Tor"_1^N (A quo I, M) -> I tensorProduct M -> M -> A quo I tensorProduct M tilde.eq M quo I M -> 0
        $
        但是 $"Tor"_1^N (A, M) = 0$\
        #TODO
      - $3 => 1$，之前证明了 $M$ 平坦当且仅当任意有限生成模 $N, N'$ 均有：
        $
        0 -> N' -> N 正 合 => N' tensorProduct M -> N tensorProduct M -> 0 单
        $
        不妨设 $N' subset N$，继而：
        $
        N = N' + A x_1 + A x_2 + ... + A x_n
        $
        我们只要递归的证明 $N' tensorProduct M -> (N' + A x_i) tensorProduct M$ 单射即可\
        不妨设 $N = N' + A x_i$，则有正合列：
        $
        0 -> N' -> N -> N quo N' = A quo I -> 0 where I = {a in A | a x_1 in N'}
        $
        将有长正合列：
        $
        "Tor"_1^A (A quo I, M) -> N' tensorProduct M -> N tensorProduct M -> A quo I tensorProduct M -> 0
        $
        由 4 结论成立
      - $1 => 6$：\
        设 $sum_i a_i x_i = 0$，考虑：
        $
        phi: A^r &-> A\
        (b_i) &-> sum_i b_i a_i
        $
        $M$  是平坦模表明：
        $
        0 -> (ker phi) tensorProduct M -> M^r ->^f M where f(t_i) = sum_i a_i t_i
        $
        正合\
        注意到：
        $
        X in ker f = im (g tensorProduct 1)
        $
        从而当然有：
        $
        X = sum_j beta_j tensorProduct y_j
        $
        计算可得这就是结论
      - $6 -> 3$\
        假设 $sum_i a_i x_i = 0$，往证 $sum_i a_i tensorProduct x_i = 0$，继而对应位置是单射，结论成立\
        由条件，可设：
        $
        x_i = sum_j b_(i j) y_j\
        sum a_i b_(i_j) = 0
        $
        从而：
        $
        sum_i a_i tensorProduct x_i = sum_i a_i tensorProduct (sum_j b_(i_j) y_j) = sum_j (sum_i a_i b_(i_j)) tensorProduct y_j = 0
        $

    ]
    #remark[][
      注意到理想都是有限生成理想的正向极限，而可以证明：
      $
      (lim_(->) M_i) tensorProduct N tilde.eq lim_(->) (M_i tensorProduct N) 
      $
      因此上面的有限生成理想条件可以去掉
    ]
    #definition[平坦同态][
      设 $phi: A -> B$ 是环同态，若 $B$ 成为平坦 $A-$模，则称 $phi$ 是平坦同态
    ]
    #proposition[][
      - *平坦同态具有传递性*，也即平坦 $AModule(B)$ 成为平坦 $AModule(A)$
      - *平坦在换基下保持不变*，也即若 $phi: A -> B$ 是任意环同态，$M$ 是平坦 $AModule(A)$，则 $M tensorProduct_A B$ 是平坦 $AModule(B)$
      - *局部化是平坦模*，也即设 $S$ 是乘性子集，则 $A -> Inv(S) A$ 是平坦同态。事实上，有：
        $
        Inv(S) A tensorProduct E tilde.eq Inv(S) E
        $
    ]
    #proof[
      - 设 $E$ 是 $AModule(A)$正合列，则有：
        $
        E tensorProduct N = (E tensorProduct_A B) tensorProduct_B N
        $
        然而注意到 $E tensorProduct_A B$ 仍正合，$N$ 是平坦 $AModule(B)$，因此上式当然正合
      - 类似的，检查：
        $
        E tensorProduct_B (M tensorProduct_A B) = (E tensorProduct_B B) tensorProduct_A M = E tensorProduct_A M
        $
        当然正合
    ]
    #proposition[][
      设 $phi: A -> B$ 是平坦同态，则：
      $
      "Tor"_i^A (M, N) tensorProduct B tilde.eq "Tor"_i^B (M tensorProduct_A B, N tensorProduct_A B)
      $
      特别的：
      $
      ("Tor"_i^A (M, N) tensorProduct B)_p = "Tor"_i^A (M, N) tensorProduct B tensorProduct A_p = "Tor"_i^A (M_p, N_p)
      $
    ]
    #proof[
      选取投射模正合列：
      $
      ... -> P_1 -> P_0 -> M -> 0
      $
      有：
      $
      ... -> P_1  tensorProduct B-> P_0 tensorProduct B-> M tensorProduct B -> 0
      $
      注意到 $P_i tensorProduct B$ 是自由 $AModule(B)$ 的直和项，因此还是投射模\
      #TODO\
      计算：
      $
      "Tor"_i^B (M tensorProduct_A B, N tensorProduct_A B) = H_i (P tensorProduct B tensorProduct (N tensorProduct B))\
      = H_i (P tensorProduct N tensorProduct B)\
      = H_i (P tensorProduct N) tensorProduct B\
      = "Tor"_i^A (M, N) tensorProduct B
      $
    ]
    #theorem[][
      设 $A$ 是局部环，$k = A quo m$ 是留域，$M in Mod_A$。若 $m$ 幂零或 $M$ 是有限生成 $AModule(A)$，则：
      $
      M "是自由模" <=> M "是平坦模" <=> M "是投射模"
      $
      一般的，局部环上的投射模都是自由模
    ]
    #proof[
      只需证明若 $M$ 是平坦模，则它是自由模，也即需要找到一组基。\
      注意到：
      $
      M quo m M = M tensorProduct k
      $
      是有限维 $k-$线性空间，当然可以找到一组自由基。由 Nakayama，可以设 $x_i in M$ 使得 $overline(M_i) in M tensorProduct k$ 是一组基\
      只需证明在 $M$ 上的线性无关性即可，用归纳法：
      - $n = 1$ 时，$a x_1 = 0$ 及 $M$ 平坦给出：
        $
        x_1 = sum b_i y_i, a b_i = 0
        $
        显然不可能所有 $b_i in m$，不妨假设 $b_1 in.not m$\
        然而由于 $A$ 是局部环，这给出 $b_1$ 是单位，从而 $b_1 a = 0 => a = 0$
      - $n > 1$ 时方法是类似的，设 $sum_i a_i x_i = 0$，由平坦性知：
        $
        x_i = sum_j b_(i_j) y_j, sum a_i b_(i_j) = 0
        $
        由于 $x_1 in.not m M$，因此不妨假设 $b_(1_1) in.not m$，从而是单位。然而 $sum a_i b_(i_1) = 0 => a_1 = - sum_(i > 1) Inv(b_(1_1)) b_(i_1) a_i$，代回得：
        $
        0 = sum_i a_i x_i = sum_(i > 1) a_i x_i + c_i x_1
        $
        由归纳假设立得 $a_i = 0$
    ]
    #example[][
      $A = ZZ_((p)), M = QQ$ 它不是自由模但是是平坦模
    ]
    #proof[
      - 断言它不是投射模，否则 $QQ$ 是自由模的直和，进而存在 $f: QQ -> L$ 是满射，其中 $L$ 是自由模。然而考虑：
        $
        n f(1/n) - f(1) = 0
        $
        给出 $f(1) = 0$，从而只能是零环，矛盾！
      - 证明它是平坦模，
    ]
  == 代数
    #definition[代数][
      给定环同态 $A ->^f B$ ，可将 $B$ 看作 $AModule(A)$，这个模就称为环上的代数。$A-$代数的同态自然定义为环之间的同态，保证交换图表：
      $
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $C$, 2),
      node((1, 0), $B$, 3),
      arr(1, 2, $$),
      arr(3, 2, $$),
      arr(1, 3, $$),)]
      $
    ]
    #example[][
      - 每个环都是 $ZZ$ 代数
      - 设 $k$ 是域，$phi: k -> B$ 是环同态。熟知 $phi$ 一定是单射，进而 $k$ 一定是 $k-$代数的子环
    ]
    #definition[][
      - 称 $B$ 是有限 $A-$代数，如果它作为 $AModule(A)$ 是有限生成的
      - 称 $B$ 是有限生成的，如果存在有限集 ${x_i}$，存在满射：
        $
        A[x_1, x_2, ..., x_n] -> B
        $
    ]
    #example[][
      - 多项式环当然是有限生成代数，但不是有限代数
    ]
    #definition[张量积][
      设 $B, C$ 是 $A-$代数，则 $B tensorProduct C$ 也有自然的代数结构，称为代数的张量积
    ]
  