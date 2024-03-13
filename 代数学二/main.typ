#import "../template.typ": proof, note, corollary, lemma, theorem,  proposition, definition, example, remark, der, partialDer, AModule
#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "代数学二",
  author: "YHTQ",
  date: none,
  logo: none,
)
#let Mod(x) = {
  $#x -$ 
  "模"
  }
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

= 环与模
  == 模
    #definition[范畴|category][
      范畴被形式的定义为以下资料：
      - 对象集合 $H$
      - 对于每一对对象 $A, B in H$，一个集合 $Hom(A, B)$，称为从 $A$ 到 $B$ 的态射集
      - 对于每一对对象 $A, B, C in H$，一个映射 $Hom(A, B) * Hom(B, C) -> Hom(A, C)$，称为复合映射
      - 对于每一个对象 $A in H$，一个元素 $1_A in Hom(A, A)$，称为恒等态射
    ]
    #definition[模|Module][
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
      - $A$ 是环，$A$ 作用于自己当然也构成 $Mod(A)$
    ]
    #definition[模同态][
      两个 $Mod(A)$ 之间的群同态 $f: M -> N$ 称为模同态，如果：
      - $f(x + y) = f(x) + f(y)$
      - $f(a x) = a f(x)$
      有时也称其为 $A-$线性映射\
      此时，记：
      - $ker f = {m in M | f(m) = 0}$，它是 $M$ 的子（$A$）模
      - $im f = {f(m) | m in M}$，它是 $N$ 的子（$A$）模
      - $coker f = N quo im f$
      - $coim f = M quo ker f$
      有熟知的同构定理 $coim f tilde.eq im f$

      所有$Mod(A)$之间的同态构成态射集 $Hom_A (M, N)$。注意到 $Hom_A (M, N)$ 本身就是一个 $Mod(A)$，运算是自然的运算：
        $
        &[a: A -> \
            [f: Hom_A (M, N) ->\ 
              [x: M -> a f(x) :N]:Hom_A (M, N)\
            ]:(Hom_A (M, N) -> Hom_A (M, N)) = End_A (Hom_A (M, N))\
          ]:(A -> End_A (Hom_A (M, N))) \
        $
    ]
    #example[][
      设 $M$ 是$Mod(A)$，则 $Hom_A (A, M) tilde.eq M$，它由双向的映射：
      - $[f: (A -> M) -> f(1)] $
      - $[m: M -> [a: A -> a m]] $
      给出
    ]
    #definition[子模|submodule 商模|quotient module][
      设 $M$ 是 $Mod(A)$，$N$ 是 $M$ 的子集，如果：
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
      将 $A$ 视作$Mod(A)$，则 $A$ 的子模称为 $A$ 的理想，这等同于在 $A$ 乘法下稳定的加法子群，与环中理想的概念是一致的。\
      自然的，此时的商模就是商环
    ]
  == 子模/理想上的操作
    #definition[][
        + 设 $M$是$Mod(A)$，$M_i in I$ 是若干子模，定义：
          - $M_j subset sum_(i in I) M_i = {sum_(i in I) m_i | m_i in M_i, m_i "中至多有限个非零"} subset M$
          - $sect.big_(i in I) M_i subset M_j$
          都是子$Mod(A)$
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
          都是子$Mod(A)$
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
      设 $M$ 是$Mod(A)$ ，则 $"ann"(M)$ 是子模，将有：
      $
      M " 是 " Mod(A quo "ann"(M))
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
    #definition[自由模|free module][
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
      设 $M, I$ 满足  $I M = M$，则 $exists x in A, x = 1 mod I and x M = 0$
    ]
    #proof[
      在上面的于引理中取 $id: M -> I M$ 即可
    ]
    #corollary[Nakayama, another form][
      $M$ 有限生成，$I subset $ Jacob radical\
      若 $I M = M$, 则 $M = 0$
    ]
    #proof[
      根据引理，可获得 $x$ 满足 $x = 1 mod I and x M = 0$\
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
      设 $A$ 是局部环，唯一素理想是 $m$，则：
      $
      M quo m M 是 A quo m "上的有限维向量空间"
      $
      同时，设 $x_i in M$ 在 $M quo m M$ 中的像生成构成线性空间的基，则它们也是 $M$ 的生成元
    ]
    #proof[

      设 $x_i$ 是这样一组基，取 $N = sum_i A x_i subset M$，取满同态 $phi: N -> M -> (M quo m) M$，往证：
      $
      N + m M = M
      $
      TODO
      由上面的引理可知 $N = M$
    ]
  == 同调代数简介
    #definition[复形][
      设有一列 $AModule(A)$:
      $
      ... -> M_(i-1) ->^(f_i) M_i ->^(f_(i+1)) M_(i+1) ...
      $
      - 称之为一个 复形|(cochain) complex，如果 $f_(i+1) compose f_i = 0 <=> im f_i subset ker f_(i+1)$
      - 称之为在 $i$ 处 正合|exact，如果 $im f_i = ker f_(i+1)$
      对一般的复形，定义：
      $
      H_i (M) = (ker f_(i+1)) quo (im f_i)
      $
      为（上）同调群，显然该处正合当且仅当 $H_i = {0}$
    ]
    #example[][
      - $0 -> M' ->^f M$ 正合当且仅当 $f$ 单射
      - $M ->^g -> M' -> 0$  正合当且仅当 $g$ 满射
      - $0 -> M' ->^f -> M ->^g -> M'' -> 0$  正合当且仅当 $f$ 单射，$g$ 满射
      - 长正合列可以分裂，例如设 $... -> M_(i-1) ->^(f_i) M_i ->^(f_(i+1)) M_(i+1) ...$ 于该处正合，则令 $N_i = ker f_(i+1) = im f_i$，有：
        $
        0 -> N_i -> M_i -> im f_(i+1) = N_(i+1) -> 0
        $
        正合
    ]
    #theorem[正合判别法][
      在 $AModule(A)$ 范畴中：
      - $M' ->^mu M ->^nu M'' -> 0$ 正合当且仅当任取 $AModule(A) space N$，序列：
        $
        0 -> Hom_A (M', N) ->^(nu') Hom_A (M, N) ->^(mu') Hom_A (M'', N) -> 0
        $ 
        正合\
        换言之，如果将 $N -> Hom_A (M, N)$ 看作函子，则这个函子是左正合的\
        对偶的，函子 $M -> Hom_A (M, N)$ 是反变左正合的
    ]
    #proof[
        只证明一个方向，另一侧是类似的\
        设 $forall N in "Mod"_A, 0 -> Hom_A (M'', N) ->^nu' Hom_A (M, N) ->^mu' Hom_A (M', N) $，往证：
        $
        M' ->^mu M ->^mu M' -> 0
        $
        正合，只需验证：
        - $nu$ 是满射 $<=> M'' \/ im nu = 0$\
          取 $N = M' \/ im nu$，注意到：
          $
          Hom_A (M'', N) ->^nu' Hom_A (M, N)
          $
          其中诱导的 $nu'$ 是单射（条件），取自然同态 $pi: M' -> M' \/ im nu = N$,发现：
          $
          
          $
        - $im nu = ker v$
          - 先证明 $im mu_ subset ker v$，事实上，注意到：
            $
            mu' compose nu' = 0 => * compose mu' compose nu' = 0, forall * in M' -> (M'' -> N) 
            $
            取 $f = id_M''$ 即得 $nu compose mu = 0$
          - 再证明 $ker nu subset im mu$，取 $N = M \/ im nu$ 和自然的同态 $pi: M -> N$
    ]
    
    #definition[（共变/反变函子|covarient/contravarient functor）][$F: "Mod"_A -> "Mod"_B$ 称为共变/反变函子，包括以下资料和性质：
      - $forall M in "Mod"_A, exists F M in "Mod"_B$
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
      0 -> M' -> M  -> M' -> 0
      $，均有：
      $
      0 -> F M' -> F M -> F M'' \
      0 -> G M'' -> G M -> G M' 
      $
      正合\
      反之，若：
      $
      F M' -> F M -> F M'' -> 0\
      G M'' -> G M -> G M' -> 0
      $
      正合，则称为右正合函子\
      若函子同时左正合，右正合，则称之为正合函子，它保持所有正合列
    ]

    #example[][
      $Hom(M, *) : "Mod"_A -> "Mod"_A$ 是共变的加性函子，另一侧 $Hom(*, N)$ 是反变函子，它们都是左正合的
    ]
    #definition[导出函子][
      对于任意的左正合（加性）函子 $F$，一族函子 $"Mod"_A -> "Mod"_B$：
      $
      {R^i F : "Mod"_A -> "Mod"_B}
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
      
      给定右正合函子，其左导出函子 ${L_i F : "Mod"_A -> "Mod"_B}$ 也可以对偶地定义
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
      - 若 $Hom(*, N)$ 正合，则称 $N$ 是 嵌入|injective 模

    ]
  问题：何时 $Hom(*, N), Hom(M, *)$ 正合？

  既然上述两个函子都左正合，只要它们都右正合即可，事实上就是对于任何满射 $phi: X -> Y$，诱导的 $phi': Hom_A (M, X) -> Hom_A (M, Y)$ 也是满射，或者说对于所有 $phi: X- > Y$ 是满射和同态 $psi: M -> Y$，均存在 $psi' : M -> X$ 使得 $phi compose psi' = psi$

  #proposition[][
    $0 -> &X ->^f &&Y -> && Z -> 0$ 正合，且 $X$ 是嵌入模，
    + 它分裂，也即：
    $
    Y tilde.eq X plus.circle Z
    $
    + $Y$ 嵌入 $<=> Z$ 嵌入 
  ]
  #proof[
    + 根据之前的性质
    + 由于 $Y tilde.eq X plus.circle Z$ 故 $Hom(*, X) plus.circle Hom(*, Z) tilde.eq Hom(*, Y)$，再加上 $Hom(*, X)$ 是正合函子，因此当且仅当 $Hom(*, Z)$ 正合
  ]

  #proposition[][
    - 自由 $A-$模是投射模
    - 投射模都是自由模的直和
  ]
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
    $M$ 是嵌入模当且仅当任取 $A$ 的理想 $A$ 以及模同态 $I ->^phi M$，存在 $psi: A -> M$ 使得：
    $
    psi|_I = phi
    $

  ]
  #proof[

    - 若 $M$ 嵌入，则这就是之前讨论中的一种特殊情况
    - 反之，若延拓总是存在,令 $X = phi(I)$，利用 Zoun 引理找出所有嵌入：
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
    - 设 $I = (a)$ 且 $m$ 嵌入，则有：
      $
      psi(a) = phi(a)\
      psi(a) = psi(a dot 1) = 
      $
    - 考虑 $"Mod"_ZZ$ 作为阿贝尔群的范畴，则直和函子将成为嵌入模
    - 设 $A$ 是环，$I$ 是嵌入 $ZZ$  模，则：
      $
      Hom_ZZ (A, I)
      $
      是嵌入 $A-$模\
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
    - 首先，找到嵌入同态 $M -> I^0$  使得 $I^0$ 嵌入。只需取：
      $
      I' = Hom_ZZ (A, times.circle/ZZ)
      I^0 = product_(Hom_A (M, I')) I'\
      phi(m) =product_(f in Hom_A (M, I')) f(m)
      $
    - 反复进行如上步骤，找到正合列：
      $
      0 -> M -> I^0 -> I^1 -> ...
      $
      使得 $I^i$ 都是嵌入模
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

    
  