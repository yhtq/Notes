#import "../../template.typ": *
#let chapterGroup = [
    = 前言
  
  - 抽象代数或名近世代数，一般以 Galois 理论为开端，在此之前的古典代数学着重于研究代数方程。而现代代数学逐渐转向研究各种代数结构。
  
  - 本课程将学习三个基本代数结构：群、环、域，所谓代数结构主要研究的是代数结构的运算性质
  
  - 所谓代数结构，即为给定一个抽象的非空集合以及一些满足一定规则（称为公理）的运算

  - 代数上一些写序号的习惯：下指标表示随指标递增，上指标表示随指标递减
  
  == 集合
  
  ......
  
  == 运算/映射
  
  - #box[往往将集合上的二元映射（也即 $R times R -> R $）称为集合上的运算 \
  
  （注：线性空间中数乘一般不能称为此种意义下的运算）\ 
  
  ......\
  
  通常习惯于用乘法代替二元运算，也即记作 $a dot b 或 a b$\
  
  交换律：$forall a, b in A , a b = b a$。若运算没有交换性但两个元素可交换，则称两元素可交换\
  
  结合律：$forall a, b, c in A , (a b) c= a (b c)$，此时前式可记为 $a b c$
  
  ]
  
  - #box[定理：若集合 $A$ 上的运算有结合律，则有广义结合律，即任意有限个元素的任意组合结果都相等\
  
  归纳证明即可]
  
  - #box[单位元：$exists e in A , forall a in A , e a = a e = a$\
  
  若单位元存在，则必然唯一]
  
  - #box[逆元：$exists b, a b = b a = e$\
  
  设运算满足结合律，则逆元必然唯一：
  
  设 $a$ 有两个逆元 $b, c$，则：
  
  $
  
  b (a c) = (b a) c = e c = c\
  
  b (a c) = b e = b\ => b = c
  
  $
  
  一般而言，若逆元唯一，则记其为 $Inv(a)$\
  
  若 $a$ 可逆，则 $Inv(a)$ 显然也可逆\
  
  若 $a$ 有左逆或右逆且有结合律，则其左逆或右逆即为$Inv(a)$
  
  若 $a, b$均可逆且有结合律，则 $Inv(a b) = Inv(b) Inv(a)$\
  
  ]
  
  - #box[设有结合律，可以自然的定义 $a$ 的方幂 $a^n$，其中 $n in NN$\
  
  若有单位元，则自然定义 $a^0 = e$\
  
  若 $a$ 可逆，则自然定义 $a^(-n) = Inv(a^n)$\
  
  对任意有定义的方幂，运算性质：
  
  $
  
  a^n a^m = a^(n+m)\
  
  (a^n)^m = a^(n m)
  
  $
  
  均成立
  
  ]
  
  - 有时也将运算记为加法，此时逆元记为 $-a$，方幂记为数乘
  
  == 等价关系和偏序关系
  
  #definition[等价关系][
  
    $A times A$ 的任一子集称为 $A$ 上的二元关系。称二元关系 $R$ 为等价关系，如果：
  
    - 自反性：$forall a in A , a R a$
  
    - 对称性：$forall a, b in A , a R b => b R a$
  
    - 传递性：$forall a, b, c in A , a R b and b R c => a R c$\
  
    此时若 $a R b$ ，也称 $a$ 和 $b$ 等价，记作 $a tilde b$
  
  ]


  
  #definition[等价类][
  
    设 $R$ 为 $A$ 上的等价关系，对任意 $a in A$，称 $a$ 的等价类为 $a$ 在 $R$ 下的等价类，记作 $overline(a)$，定义为：
  
    $overline(a) = {b in A | a R b}$\
  
    也即 $a$ 在 $R$ 下的等价类为 $a$ 的所有等价元素的集合\
  
    所有等价类构成的集合记为 $A \/ R$
  
  ]


  
  #theorem[][
  
    设 $R$ 是 $A$ 上的等价关系，则有：
  
    + $b in overline(a) => overline(b) = overline(a)$
  
    + $overline(a)$ 与 $overline(b)$ 或者相等，或者不相交
  
    + $A = union_x overline(x)$ 
  
    换言之，$A$ 可以划分为若干个不相交的等价类
  
  ]


  
  #example[][
  
    设 $f: A -> B$， 则可诱导出 $A$ 上的等价关系 $R$，定义为：
  
    $a R b <=> f(a) = f(b)$\
  
    进一步，$f$ 可以诱导出 $A \/ R$ 到 $B$ 的一个单射 $overline(f): overline(f)(overline(a)) = f(a)$\
  
    再取 
  
    $
  
      pi : A &-> A \/R \
  
      a &-> overline(a) \
  
    $ 
  
    为$A -> A\/R$ 的自然映射或者典范映射（显然这是一个满射），则 $f = overline(f) pi$\
  
    也即任何映射都可以分解为一个满射和一个单射的复合
  
  ]


  
  设 $A$ 上定义了乘法运算，能否在商集上自然诱导出运算？
  
  显然需要满足条件：
  
  $
  
   x tilde x' and y tilde y' => x y tilde x' y' 
  
  $


  
  #definition[偏序集][
  
    称二元关系 $R$ 为偏序关系，如果：
  
    - 自反性：$forall a in A , a R a$
  
    - 反对称性：$forall a, b in A , a R b and b R a => a = b$
  
    - 传递性：$forall a, b, c in A , a R b and b R c => a R c$\
  
    将 $a R b$ 记作 $a <= b$ 或 $b >= a$\
  
    若 $a <= b$ 或 $b <= a$，则称 $a$ 和 $b$ 可比\
  
    若所有元素均可比，则称 $R$ 为全序关系\
  
    若 $a <= b => a = b$，则称 $b$ 为极大元\
  
    若 $forall a in B subset A :space a <= b$，则称 $b$ 为上界 
  
  ] 


  
  #theorem[佐恩引理][
  
    设 $A$ 为非空偏序集，若 $A$ 中任何全序子集都有上界，则 $A$ 中必有极大元（没有其他元素比它更大）
  
  ]


  
  佐恩引理等价于选择公理
  
= 基本代数结构
  == 群
    #definition[半群/幺半群][
      设 $A$ 为非空集合，$dot$ 为 $A$ 上的二元运算，若 $dot$ 满足结合律，则称 $A$ 为半群\
      若 $dot$ 还有单位元 $e$，则称 $A$ 为幺半群\
    ]

    #definition[群][
      设 $A$ 为非空集合，$dot$ 为 $A$ 上的二元运算，若 $dot$ 满足结合律，且 $dot$ 有单位元 $e$，且 $dot$ 中每个元素都可逆，则称 $A$ 为群\
      若 $dot$ 满足交换律，则称 $A$ 为交换群或阿贝尔群（交换群的运算更多写成加法）\
    ]

    #example[][
      - 幺半群中所有可逆元构成群
      - 整数关于加法构成交换群，称为整数加法群
      - $RR, QQ, CC$ 关于加法构成交换群
      - $RR \/ {0}, QQ \/ {0}, CC \/ {0}$ 关于乘法构成交换群
      - 数域 $K$ 上所有 $n$ 阶矩阵关于矩阵乘法构成幺半群，所有可逆矩阵构成群，一般记为 $"GL"_n (K)$ （一般线性群）
      - 将所有行列式为 $1$ 的矩阵记为 $"SL"_n (K)$，显然它也是一个群
      - 设 $M$ 为一个集合，$T_M$ 表示 $M$ 上的所有变换，构成幺半群。$S_M$ 表示 $T_M$ 中所有可逆变换，构成群，称为 $M$ 上的全变换群
      - 特别的，若 $M$ 有限，则可不妨设 $M = {1, 2, 3, ..., n} := \[n\]$，此时称$S_M$ 中的一个元素为一个 $n$ 元置换。事实上，这就是 $n$ 个元素的一个排列。此时，记 $S_n := S_(\[n\)$ 为 $n$ 元对称群
      ]

    #proposition[][
      - 群中有消去律，即：
      $
      forall a, b, c in G, space a b = a c or b a = c a => b = c
      $
      - 穿脱法则成立，即：
      $
      Inv((a_1 a_2 .. a_n)) = Inv(a_n) Inv(a_(n-1)) .. Inv(a_1)
      $
      注：未必有 $(a b)^n = a^n b^n$，除非 $a, b$ 可交换
    ]

    #definition[直积/direct product][
      设 $G_1, G_2$ 为群，定义 $G_1 times G_2$ 上的运算：
      $
      (a_1, a_2) (b_1, b_2) = (a_1 b_1, a_2 b_2)
      $
      则 $G_1 times G_2$ 构成群，称为 $G_1$ 和 $G_2$ 的直积
    ]

    #example[二面体群][
      记 $D_(2n)$ 为一个正 $n$ 边形的对称群（自身到自身的双射），称为二面体群。它可以被表示为：
      $
      D_(2n) = {#box[
        $e, r, r^2, ..., r^(n-1)$ \
        $s = s_1, r s = s_2, r^2 s = s_3, ...$]}
      $
      并有 $s^2 = e, r^n = 1, s r s = r^(-1)$
    ]

    #definition[生成元/set of generators][
      $S$ 为 $G$ 一子集，若 $G$ 中任何元素都可写成 $S$ 中元素（或其逆）的乘积，则称 $S$ 为 $G$ 的生成元
    ]

    更进一步，有时我们用生成关系来表示群。也即：
    $
    G = angle.l s_1, s_2, ..., s_n | R_1, R_2, ..., R_m angle.r
    $
    表示可被元素 $s_i$ 和规则 $R_i$ 推导出的群，例如：

    #example[][
      $
      D_(2n) = angle.l r, s | r^n = 1, s^2 = 1, s r s = r^(-1) angle.r \
      Z_6 = angle.l r(2), s(3) | r^3 = s^2 = 1, r s = s r angle.r \
      $
    ]

    #example[轮换/cycle][
      $(a_1 a_2 a_3 ... a_k)$ 表示 $S_n$ 中一元素，把 $a_i$ 映到 $a_(i+1)$，把 $a_k$ 映到 $a_1$，把其它元素映到自身。称 $(a_1 a_2 a_3 ... a_k)$ 为一个 $k$ 轮换，$k$ 称为轮换的长度。若 $k = 2$，则称为对换
    ]

    #proposition[][
      - 不交的轮换是可交换的
      - $S_n$ 中任意元素都可写成不交的轮换的乘积
      - $(i j), (i space i+1), {(1 space 2),(1 space 2 space 3 .. n)}$ 都是 $S_n$ 的生成元
    ]
    
    #definition[子群/subset][
      设 $G$ 为群，$H$ 为 $G$ 的非空子集，若 $H$ 关于 $G$ 的运算构成群，则称 $H$ 为 $G$ 的子群
    ]
    
    #definition[生成子群][
      设 $G$ 为群，$S$ 为 $G$ 的子集，$H$ 为 $G$ 中所有可由 $S$ 中元素（或其逆）构成的元素的集合，则 $H$ 为 $G$ 的生成子群（subgroup of G generated by A），记作 $angle.l S angle.r$。显然它也是包含 $S$ 的最小子群
    ]

    #definition[阶/order][
      设 $G$ 为群，$a in G$，若存在最小的正整数 $n$ 使得 $a^n = e$，则称 $a$ 的阶为 $n$，记作 $|a| = n$。若不存在这样的 $n$，则称 $a$ 的阶为无穷
    ]
= 群论
  == 群、商群、同态
    #definition[左陪集/left coset][
      设 $G$ 为群，$H$ 为 $G$ 的子群，$a in G$，称 $a H$ 为 $a$ 在 $H$ 下的左陪集，定义为：
      $
      a H = {a h | h in H}
      $
    ]
    类似可以定义右陪集 $H a$。在阿贝尔群中左右陪集没有区别。

    #proposition[][
      两个左陪集要么不交，要么相等
    ]

    #definition[商群][
      记 $
      G\/H = {g H | g in G}\
      H\\G = {H g | g in G}
      $
    ]

    #lemma[][
      $G = union G \/H = union_(g H in G\/H) g H$
    ]

    #theorem[Lagrange's theorem][
      设 $G$ 为有限群，$H$ 为 $G$ 的子群
      - $|G| = |G\/H| |H|$
      - 特别的，$|H|$ 整除 $|G|$
      - 若 $G$ 是有限群，则 $"ord"(x) | |G|$。进而，$x^(|G|) = e$
    ]

    #example[Euler's theorem][
      设 $n > 1$，$a, n$ 互素，则 $a^(phi(n)) = 1 (mod n)$\
      其中 $phi(n)$ 表示小于 $n$ 且与 $n$ 互素的数的个数
    ]

    #corollary[][
      若 $|G| = p$ 为一素数，则 $G$ 是循环群，进而是交换群
    ]

    #definition[共轭/conjugate][
      设 $G$ 为群，$a, b in G$，若存在 $c in G$ 使得 $b = c a c^(-1)$，则称 $a$ 和 $b$ （通过 $c$）共轭（conjugate of a by g）
    ]

    #lemma[][
      若 $H <= G$，则 $g H Inv(g) <= G$  
    ]

    #definition[正规子群/normal subgroup][
      设 $H <= G$，若（容易证明三者等价）: 
      - $forallSa(g in G, H = g H Inv(g))$ 
      - $H$ 的任意共轭是 $H$ 自身
      - $H$ 的左右陪集相等
      则称 $H$ 为 $G$ 的正规子群（normal subgroup of G），记作 $H norS G$
    ]
    d引理：设 $psi$ 是同态，则 $ker(psi)$ 是正规子群 

    #theorem[第一同构定理][ $G\/ker(psi)$ 同构于 $im(psi)$
    证明：构造
    $
    G\/ker(psi) &-> im(psi)\
    g ker(psi) &-> g
    $]
    验证其良定义，同态，同构即可

    注：它是满射是显然的。任何群上的同态是单射当且仅当
    $
    psi(g) = e <=> g = e
    $

    #theorem[第二同构定理][ $A <= G, B lt.tri.eq G$, 则 $A B <= G, B lt.tri.eq A B, A sect B lt.tri.eq A$，并且：
    $
    A B \/ B tilde.rev.equiv A \/ A sect B
    $]
    证明：$A B <= G, B lt.tri.eq A B$ 证明容易\
    定义 
    $
    phi: A &-> A B\/B \
        a &-> a B
    $
    验证 $phi$ 是满射，$ker(phi) = A sect B$，由第一同构定理立得结论，同时有$ker(phi) = A sect B lt.tri.eq A$

    #theorem[第三同构定理][$H lt.tri.eq K lt.tri.eq G$，则:
    $
    (K\/H) lt.tri.eq (G\/H)
    $
    并且
    $
    (G\/H)\/(K\/H) tilde.rev.equiv G\/K
    $]
    证明：用类似的思路，定义：
    $
    phi: (G\/H) &-> G\/K \
        g H &-> g H K = g K "(使用集合运算可以避免良定义的验证)"
    $
    验证 $phi$ 是满射，$ker(phi) = K\/H$，由第一同构定理立得结论，同时有$ker(phi) = K\/H lt.tri.eq (G\/H)$

    #theorem[Lattice 同构定理][ $N lt.tri.eq G$，则：
    $
    {H | N <= H <= G } &<-> {A\/N | A\/N <= G \/ N}\
    A &<-> A\/N
    $
    保持包含关系，相交关系，商群关系]

    注：一般来说，若有同态 $phi:G -> B$, $H lt.tri.eq G$, 我们希望定义映射
    $
    psi: G\/H &-> B \
        g H &-> phi(g)
    $
    但此映射并不始终良定义的。事实上，它是良定义当且仅当 $N subset ker(phi)$\
    当此条件成立时，则称 $phi$ factor through(穿过) $N$

    例：任意一个从$Z$到复数乘法群的同态$phi$，由同态性它由 $phi(1) = 1$ 唯一确定\
    而对 $Z$ 的一个子群 $Z\/n Z$，它到复数乘法群的同态 $psi$ 需满足$n Z subset ker(psi) <=> psi(n) $ 是 $n$ 次单位根

    群论的终极目标：分类所有（满足给定条件的）有限群。由以上的同构定理和商群概念可以看出正规子群往往给出了原群的一种分类，从而应该抛掉正规子群使问题简化。

    定义：没有非平凡正规子群的非平凡群称为单群

    例：$Z_p$ 没有任何非平凡子群（事实上它是所有无非平凡子群的同构类）\
    （交错群）$A_n (n >= 5)$ \
    无穷单群也是存在的，从略
    Holder's program:
    + 分类所有有限单群（已完成）\
      所有奇数阶单群均同构于 $Z_p$ （236页的大型证明）\
      单群分类定理（一千页的大型证明）：所有有限单群同构于18种群族之一或者26个零散单群之一
    + 找到所有“合成群”的方法
  == 合成群列 <series>
    定义：（合成序列）若 ${e} = N_0 lt.tri.eq N_1 lt.tri.eq N_2 lt.tri.eq ... lt.tri.eq N_k = G$，并且 $N_(i+1) \/ N_(i)$ 是单的，则称它是一个合成序列，$N_k\/N_(k-1)$ 称为合成因子或 Jordan-Holder 因子

    例：${e} lt.tri.eq angle.l r^2 angle.r lt.tri.eq angle.l r angle.r lt.tri.eq angle.l D_8 angle.r$\
    ${e} lt.tri.eq angle.l s angle.r lt.tri.eq angle.l s r^2 angle.r lt.tri.eq angle.l D_8 angle.r$

    下面的证明需要如下引理：

    #lemma[][
      $A B <= G => A B = B A$ <commutable>
    ]


    #proof[
      $
      A B = Inv((A B)) = Inv(B) Inv(A) = B A
      $
    ]

    #lemma[][
      $B norS C => A sect B norS A sect C$ <sect>
    ]

    #proof[
      $
      forall a in A sect C:\
      a (A sect B) Inv(a) = (a A Inv(a)) sect (a B Inv(a)) = A sect B 
      $<subgroup>
    ]

    #lemma[][
      $A norS A B <=> A in N_G (B)$ 
    ]

    #proof[
      $
      forall a in A:\
      a (A B) Inv(a) = (a A Inv(a)) (a B Inv(a)) = A B
      $
    ]

    #lemma[][
      $A(B sect C) <= G => A sect (B C) = (A sect B) (A sect C)$
    ]

    #proof[
      容易注意到：
      $
      A sect B subset A sect (B C) \
      A sect C subset A sect (B C) \
      $
      从而：
      $
      (A sect B) (A sect C) subset A sect (B C)
      $ 
      对另一侧，

    ]

    #theorem[Jordan-Holder][ 设 $G$ 是非平凡有限群
    + G 有合成群列
    + G 的合成因子是唯一的。也就是说，G 的任意两个合成序列长度相等，且对应的合成因子在不计顺序但记数量的视角下同构]
    #proof[
      (1)：
      若 $G$ 是单群，结论显然\
      若 $G$ 不是单群，则其存在一个非平凡正规子群 $H$，对 $N$ 和 $G\/N$ 归纳可得。\
      事实上，$N$ 和 $G\/N$ 的合成序列相连就是 $G$ 的合成序列。详细来说：
      $
      {e} = N_0 lt.tri.eq N_1 lt.tri.eq N_2 lt.tri.eq ... lt.tri.eq N_k = N = pi^(-1)({e}) lt.tri.eq pi^(-1)(B_2) lt.tri.eq ... lt.tri.eq pi^(-1)(B_n) = G
      $
      Lattice 同构定理保证了上述是一个合成序列（$pi^(-1)(B_(i+1)) \/ pi^(-1)(B_(i)) tilde.rev.equiv B_(i+1)\/B_i$）

      (2):为了证明结论，可以先在集合的退化情形做以类比。

      #lemma[][对有限集合 $S$ 上两个滤链，将有：
      $
      quotient(A_(i - 1) union (A_i sect B_j),(A_(i-1) union (A_i sect B_(j+1)))) = quotient(B_(j - 1) union (A_i sect B_j),(B_(j-1) union (A_(i-1) sect B_(j))))
      $ ]
      #proof[
        画图可以看出，如果找到中间的桥梁 $quotient(A_i sect B_j, (A_i) sect B_(i-1) union (A_(i-1) sect B_j))$，分别证明其与两者都同构，则结论成立。
      ]
      #lemma[][对有限群 $G$ 上两个滤链，将有：
      $
      quotient(A_(i - 1) union (A_i sect B_j),(A_(i-1) union (A_i sect B_(j+1)))) = quotient(B_(j - 1) union (A_i sect B_j),(B_(j-1) union (A_(i-1) sect B_(j))))
      $]
      #proof[
        类似上面的发现，往证：
        $
        quotient(A_i sect B_(j - 1), (A_i sect B_(j-1) (A_(i-1) sect B_j))) tilde.rev.equiv quotient(A_(i - 1) (A_i sect B_j),(A_(i-1) (A_i sect B_(j - 1))))
        $
        ，另一侧同理。
      ]
      - 首先证明，$A_(i-1)(A_i sect B_(j-1)) norS A_(i-1(A_i sect B_j))$\
        断言 $A_i sect B_(j-1) norS A_i sect B_j$，从而子群关系成立。\
        再验证它确实是正规子群：
        $
        forall a b in A_(i-1)(A_i sect B_(j)):\
         &a b A_(i-1)(A_i sect B_(j-1)) Inv(b) Inv(a) 
        \ =& a b A_(i-1) Inv(b) b A_i sect B_(j-1) Inv(b) Inv(a)  
        \ =& a (b A_(i-1) Inv(b)) (b A_i sect B_(j-1) Inv(b)) Inv(a)  
        \ =& a A_(i-1)(A_i sect B_(j-1)) Inv(a)
        \ =& A_(i-1)(A_i sect B_(j-1)) Inv(a)
        \ =& A_(i-1)(A_i sect B_(j-1)) Inv(a)
        \ =& (A_i sect B_(j-1)) A_(i-1) Inv(a)
        \ ("这是因为" A_(i-1)(A_i sect B_(j-1)) &<= A_i =>A_(i-1)(A_i sect B_(j-1)) = (A_i sect B_(j-1))A_(i-1)  )
        \ =& A_i sect B_(j-1)
         
        $
      - 我们将要利用第一同构定理，定义：
        $
        funcDef(phi, A_i sect B_j, quotient(A_(i-1)(A_i sect B_j), A_(i-1)(A_i sect B_(j-1))), x ,  x A C)\
        $
        良定义及同态性显然。\
        最后，我们要验证 $ker(phi) = (A_(i-1) sect B_j)(A_i sect B_(j-1))$。显有：
        $
        ker(phi) = (A_i sect B_j) sect (A_(i-1) (A_i sect B_(j-1)))\
        $
        
    ]
    定义：（可解群）若在 $G$ 的一个合成序列中 $N_(i+1) \/ N_(i)$ 是交换的，则称 $G$ 是可解的\
    可换的单群仅有 $Z_p$，从而显然群 $G$ 可解当且仅当其 Jordan-Holder 因子交换

    历史上，阿贝尔和伽罗瓦独立证明了代数方程有根式解当且仅当对应的群是可解的

     例：取 $G L(n)$ 中可逆的上三角矩阵 $B$，它是可解的：
    - 取 $N$ 是严格上三角矩阵（对角线是 $1$），则 $N lt.tri.eq B$
    - 取 $N_1 = {mat(1,0,*;
                      0, 1, 0;
                      0, 0, 1)}$
      则$N_1 lt.tri.eq N$
    - ...
    - 可以验证这是一个合成群列，而相邻商是同构于实数乘法群的次幂的
  == 交错群
    我们的目标是给出一个合成群列：
    $
    {e} <= A_n <= S_n, n >= 5 
    $
    #definition[][
      $forall sigma in S_n, sigma(Delta) = product_(1<=i<j<=n)(X_(sigma(i)) - X_(sigma(j))) = plus.minus Delta$
    ]

    #definition[][
      $sgn(sigma) := sigma(Delta) / Delta$
    ]

    #lemma[][
      $sgn(sigma tau) = sgn(sigma) sgn(tau)$，换言之，它是 $S_n -> {plus.minus 1}$ 的同态
    ]

    #proof[
      $
      sgn(sigma tau) &= (product_(1<=i<j<=n)(X_(sigma tau(i)) - X_(sigma tau(j)))) / (product_(1<=i<j<=n)(X_i - X_j)))\

      sgn(sigma) sgn(tau) &= (product_(1<=i<j<=n)(X_(sigma(i)) - X_(sigma(j)))) / (product_(1<=i<j<=n)(X_i - X_j)) dot (product_(1<=i<j<=n)(X_(tau(i)) - X_(tau(j)))) / (product_(1<=i<j<=n)(X_i - X_j))\
      &= (product_(1<=i<j<=n)(X_(sigma(tau(i))) - X_(sigma(tau(j))))) / (product_(1<=i<j<=n)(X_tau(i) - X_tau(j))) dot (product_(1<=i<j<=n)(X_(tau(i)) - X_(tau(j)))) / (product_(1<=i<j<=n)(X_i - X_j))\
      &"(换元中造成的前后颠倒会在分母上下同时消掉)"\
      &= sgn(sigma tau)
      $
    ]
    
    #proposition[][
      - $sgn((i j)) = -1$
      - 若 $sigma$ 可以写成 $k$ 个对换的积，则 $sgn(sigma) = (-1)^k$
      - $sgn(sigma) = 1 <=> sigma "是偶数个对换的乘积" <=> sigma "是偶置换"$
    ]

    #definition[][
      称 $A_n = ker("sgn")$ 也即所有偶置换构成的群为交错群。显然它是 $S_n$ 的正规子群。
    ]

    #proposition[][
      $|A_n| = n! / 2$
    ]

    #proposition[][
      - $A_3 tilde.eq Z_3$
      - $Z_2 times Z_2 norS A_4$
    ]
    #lemma[共轭][
      $tau(a_1 a_2 ... a_n)Inv(tau) = (tau(a_1) tau(a_2) ... tau(a_n))$
    ]

    #theorem[][
      $A_n, n>=5$ 是单群 
    ]

    #proof[
      考虑三轮换 $(i j k)$\
      + $A_n$ 是由三轮换生成的
        $
        (a b)(c d) = (a c b)(a c d)\
        (a b)(a c) = (a c b)\
        $
      + 若 $N norS A_n$ 且 $N$ 包含一个三轮换$(i j k)$，则它包含所有三轮换（从而 $N = A_n）$\
        显然，只需证明所有三轮换在 $A_n$ 中共轭即可。\
        设若 $sigma (i j k) Inv(sigma)$
        - 若 $sigma in A_n$，则已证毕
        - 若 $sigma in.not A_n$，则考虑：
        $
        sigma(i j)(i j k)(i j)Inv(sigma) = sigma(j i k)Inv(sigma) \
        => (sigma(i j))^2 "就是我们所求的共轭轮换"
        $
      + 证明 $N$ 中有三轮换：固定 $sigma in N$
        - 若 $sigma$ 是三轮换，则已证毕
        - 若 $sigma$ 写成不相交轮换乘积时，最长串长度 $>= 4$\
          从而：
          $
          sigma = tau (a_1 a_2 ... a_t)
          $
          $
          (a_1 a_2 a_3) sigma Inv((a_1 a_2 a_3)) = tau (a_2 a_3 a-1 a_4 ... a_5) := sigma' in N
          $
          结合上两式我们有：
          $
          Inv((a_1 ... a_5))(a_1 a_2 a_3 ... a_t) = (a_1 a_3 a_5) in N
          $
      + 讨论余下情况，$sigma$ 由一些二轮换和三轮换生成
        #set enum(numbering: "Step 4.1.")
        - 简单起见，分别进行二次方和三次方，可以化为均由二轮换生成和均由三轮换生成的情况
        - 设 $sigma$ 均由二轮换生成，显然至少有两个二轮换。注意到 $A_4$ 不是单群，从而必须引入除两个二轮换外的其他元素\
          $
          sigma = tau(a_1 a_2)(a_3 a_4)\
          (a_1 a_2 a_3) sigma Inv((a_1 a_2 a_3)) = (a_1 a_3)(a_2 a_4) := sigma' in N
          $
        在此利用 $N >=5$ （这是我们第一次利用此条件），取 $a_5$ 异于前四个元素，有：
        $
        (a_1 a_2 a_5)sigma'Inv((a_1 a_2 a_5)) = (a_1 a_2 a_3 a_4 a_5) in N
        $
        技术上，我们通过用三轮换取共轭的方式延长了轮换长度，这就回到了 Step 3 的情况。
        - 设 $sigma$ 均由三轮换生成     
    ]

  == 交换群

    #definition[有限生成群][
      称群是有限生成的，如果它可以写成一些有限个元素及它们的逆的任意顺序的乘积
    ]

    #theorem[有限生成群分解定理][
      设 $G$ 是有限生成的阿贝尔群，则 $G$ 可以唯一的被表示为：
      $
      G tilde.eq (Z)^r times Z_(n_1) times Z_(n_2) times ... times Z_(n_k), "with" r>=0, 2<=n_1 | n_2 | n_3 | ... | n_k 
      $
      通常将 $r$ 称为 $G$ 的秩，将 $n_1, n_2, ..., n_k$ 称为 $G$ 的不变因子。$(Z)^r$ 称为自由部分，$Z_(n_1) times Z_(n_2) times ... times Z_(n_k)$ 称为挠部分
    ]

    #proof[
      阿贝尔群 = $ZZ-"module"$\
      将在后面利用有限生成模的结构定理证明
    ]

    #lemma[][
      $gcd(m, n) = 1 => Z_(m n) tilde.eq Z_m times Z_n$
    ]

    #proof[
      定义：
      $
      funcDef(phi, Z_(m n), Z_m times Z_n, a mod m n, (a mod n ,b mod m))
      $
      验证它是同态，且 $ker(phi) = {0}$，并由元素个数知它也是同构，证毕
    ]

    由上述引理，立得有限生成阿贝尔群分解的另一种形式：

    #theorem[有限生成群分解定理2][
      设 $G$ 是有限生成的阿贝尔群，则 $G$ 可以唯一的被表示为：
      $
      G tilde.eq (Z)^r times (Z_(p_1^alpha_11) times Z_(p_2^alpha_12) ... Z_(p_n^alpha_1n))  times ... 
      $
    ]

  == 群作用
    群作用的最简单案例是 $S_n$ 在 $(1,2,3, ...,n)$ 上的作用

    #definition[群（左）作用][
      设 $G$ 为一个群，$X$ 是一个集合。称：
      $
      funcDef(phi, G times X, X, (g, x), g x)
      $ 
      为一个群作用，如果：（$phi(g, x)$ 常记作 $g x$）
      + $forall x in X, space e x = x$
      + $g (h x) = (g h) x$
      也称 $G$ 作用在 $X$ 上
    ]
    右作用非常类似，要求结合律在右侧即可。注意到左右作用本质上是完全不同的，因为它们的定义中的 $g$ 和 $h$ 的顺序是不同的。

    #proposition[][
      + 群作用也可视作 $G ->(X -> X)$
      + $[x -> g x]$ 一定是 $X$ 上的双射。显然它的逆恰为 $[x | x -> Inv(g) x]$
    ]

    #proposition[][
      若有右作用 $phi: G -> (X -> X)$，则容易诱导出自然的左作用：
      $
      phi' = [g -> phi(Inv(g))]
      $
      大多数时候人们不愿考虑右作用
    ]

    #proposition[][
      群作用 $phi: G -> (X -> X)$ 给出 $G -> S_X$ 的群同态。其中 $S_X$ 是 $X$ 上所有双射构成的对称群。这由 $phi(g h)(x) = phi(g)(phi(h))(x) = (phi(g) dot phi(h))(x)$ 显然给出。\
      该命题的反之也成立，也即若 $phi$ 给出如上的一个同态，则它也是一个群作用。\
    ]

    #definition[][
      + 如果 $phi$ 是平凡同态（全部映成单位元），则称对应的群作用也是平凡的。
      + 如果 $phi$ 是单同态，则称群作用是忠实（faithful）的。
        注：“忠实”的含义可以理解为忠实的反映了对方的信息，也即 $S_X$ 中两个不一样的的元素在 $G$ 中来看也是不一样的。
    ]


    #example[][
      群 $G$ 在自身上显然有很多作用
      + 左平移：$[g -> [x -> g x]]$
      + 右平移：$[g -> [x -> x Inv(g)]]$ （为了保证它是左作用特地选取 $Inv(g)$）\
        验证：\
        $g(k (x)) = k(x)Inv(g) = x Inv(k) Inv(g) = x Inv((g k)) = (g k)(x)$\
        如果没有选取逆，计算可验证它没有左结合性，此时它是右作用。这里也可体现出左右作用的区别。
      + 共轭作用：$[g -> [x -> g x Inv(g)]]$\
        它有更好的性质：事实上，$[x -> g x Inv(g)]$ 一定是 $G$ 上的同构。一般将共轭作用对应的映射 $G -> S_G$ 记为 $Ad(g)$
    ]

    #theorem[Caylay][
      每个群都同构于某个置换群的子群。特别的，若 $|G| = n$，则 $G$ 同构于 $S_n$ 的一个子群 
    ]
    
    这个定理很平凡，更多的是出于历史和哲学上的考虑：历史上人们最早将群定义为置换群的子群，而不是现在的抽象定义，定理表明这两者是等价的。这个定理也可以看作是群论的一个基本定理，它告诉我们，群论的研究可以归结为置换群的研究。或者说，我们可以通过作用由具体的置换研究具体的群的性质。

    #definition[自同构（automorphism）][
      称 $phi: G -> G$ 是 $G$ 的一个自同构，如果它是一个同构。所有的自同构构成群 $Aut(G)$。它显然是集合 $G$ 上置换群的一个子群 
    ]

    #example[][
      $G$ 在自身上的共轭作用给出 $G$ 到 $Aut(G)$ 的同态。
    ]

    对上述例子略微推广，便可引出下节中半直积的概念。

    #example[][
      $G$ 到 $G$ 的所有子群构成的集合上也有自然的作用，取共轭即可。
    ]

       #definition[][
      - 若群 $G$ 作用在 $X$ 上，则称 $X$ 是 $G-$集合
      - $Stab_G(x) := {g in G | g x = x}$，称为 $x$ 处的"稳定子"（Stabilizer）群
      - $Orb_g(x) := G x = {g x | g in G}$
    ]

    #proposition[][
      - $Stab_G (x) <= G$
      - $Orb(x)$ 与 $Orb(y)$ 要么不交，要么相等。进而 $X$ 可以分解为 $Orb(x)$ 的不交并，即 $X = tack.b.double_("orbite" OO) OO$
      - 若 $y in Orb_G(x)$，也即 $y = g x$，我们有：
        $Stab_G (x) = Inv(g) Stab_G (y) g$
    ]

    #proof[
      前两个容易验证。验证第三个：
      $
      h y = y <=> h g x = g x <=> g^(-1) h g x = x
      $

      从而：
      $
      h in Stab_G (y) <=> g^(-1) h g in Stab_G (x)
      $
    ]

    #example[][
      $H <= G$，$H$ 在 $G$ 上左乘自然产生一个群作用：\
      $Orb(g) = H g$（这里变成了右陪集）\
      $Stab(x) = {e}$
    ]

    我们的目标是给出轨道的一些描述。

    #definition[$G-$等变映射][
      设 $G$ 作用在 $X, Y$ 上，$f: X -> Y$。称 $f$ 是 $G-$等变的，如果：
      $
      forall g in G, forall x in X, f(g x) = g f(x)
      $
    ]

    #definition[传递][
      称 $G$ 是传递的，如果 $forall x, y in X, exists g: y = g x$
    ]

    #proposition[][
      若 $G$ 是传递的，则令 $H = Stab_G (x)$，那么：
      $
      funcDef(phi, G \/ H, X, g H, g x)
      $
      是一个 $G-$ 等变的双射
    ]
    #proof[
      + 良好定义：
        $
        g_1 x =g_2 h x = g_2 x
        $
      + 满射 由传递性易知
      + 单射 $g_1 x = g_2 x => Inv(g_2) g_1 x = x => Inv(g_2) g_1 in H$
      + $GEquiv(G)$ ：
      $
        phi(g' (g H)) = g' g x =g' phi(g H) 
      $
    ]
    一般而言，$quotient(G, Stab_G (x)) tilde.eq Orb_G (x)$，因此轨道分解也可写成商集分解。

    #definition[中心化子/ 正规化子][
      - $C_G (g) = {h in G | h g = g h} <= G$。它就是共轭作用下的稳定子。
      - 若 $S <= G$，记 $C_G (S) = sect_(s in S) = {g in G | forall s in S:conjugateRight(g,a) = s}$
      - 记 $Z_G = C_G (g) = ker(A d)$ 为群的中心
      - 若 $H <= G$，记 $N_G (H) = {g in G | conjugateRight(g,H) = H}$ 为 $H$ 的正规化子。显然它包含 $C_G (H)$。它可以看作 $G$ 以共轭作用作用于所有子群之上的稳定子群
    ]


    #definition[共轭（conjugate）关系][
      称 $a, b in G$ 共轭，如果 $exists g: a = conjugateRight(g, a)$
      等价于它们在 $G$ 共轭作用中处于同一轨道
    ]

    #example[][
      - $G$ 是交换群，则与 $a$ 共轭的元素只有它本身。
      - $"GL"_n (CC)$ 中的共轭类就是按约当标准型分类
      - $S_n$ 中的共轭类就是按轮换类型分类
    ]

    #theorem[类方程][
      设 $G$ 是有限群，以共轭作用作用于自身
      - 取 $g_i$ 是各个轨道的代表元，有：
        $
        |G| = sum_(i=1)^k |Orb(g_i)| = sum_(i=1)^k |G : C_G (g_i)|
        $
      - 取 $g_i not in Z(G)$，显然 $G : C_G (g_i)$ 不是单点集，从而：
        $
        |G| = |Z_G(G)| + sum_(i=1)^k |G : C_G (g_i)|
        $
    ]
    
    #example[$S_5$ 的分类计数][
        - 单位元 $1$，中心化子为 $S_5$
        - 二轮换 $a b$，中心化子为 $S_3 times S_2$
        - 三轮换 $a b c$，中心化子为 $S_2 times ZZ_3$
        - 两个二轮换，中心化子为 $ZZ_2^2 times.r ZZ_2$
        - 四轮换，中心化子为 $ZZ_4$
        - 一个二轮换一个三轮换，中心化子为 $ZZ_2 times ZZ_3$
        - 五轮换，中心化子为 $ZZ_5$
    ]

    #theorem[][
        设 $p$ 为素数，称 $G$ 为 $p$ 群，如果 $|G| = p^n$。对于非平凡的 $p$ 群，一定有 $Z(G)$ 非平凡
    ]

    #proof[
        $|G| = |Z(G)| + sum_(i=1)^k |G : C_G (g_i)|$\
        等式左端是 $p$ 的幂，右边求和的每一项都是 $p$ 的幂，从而 $|Z(G)|$ 也是 $p$ 的幂，因此它非平凡。
    ]

    #definition[自同构群][
        显然所有的共轭作用都是自同构。注意到 $ker("Ad") = Z(G)$，定义 $"Inn"(G) = im("Ad")$ 为 $G$ 的内自同构群。\
        断言 $"Inn"(G) norS Aut(G)$，它对应的商群称为外自同构群，记为 $"Out"(G)$
    ]
    #proof[
        我们需要证明 $forall sigma in G, forall Ad_g in "Inn"(G): conjugateRight(sigma, "Ad"_g) in "Inn"(G)$\
        事实上，显然 $conjugateRight(sigma, "Ad"_g)$ 是自同构。断言 $conjugateRight(sigma, "Ad"_g) = "Ad"_(sigma(g))$\，足以说明自同构群是正规子群。\
        验证：
        $
        sigma(Ad1(Inv(sigma)(h), g)) = sigma(g Inv(sigma)(h)Inv(g)) = sigma(g) sigma(Inv(sigma)(h))sigma(Inv(g)) = sigma(g) h Inv(sigma)(g)\
        = Ad1(h, sigma(g))
        $
    ]

    #example[][
        - 考虑 $G = "GL"_n(QQ)$，考虑其上的共轭作用 $Ad$。
            $ker("Ad")$ 是与其他矩阵都交换的矩阵，显然为数量矩阵。\
            $"Inn"(G) = quotient(G, ker("Ad"))$\
            它的外同构群本质只有一个元素 $psi = [A | A -> Inv((A)^T)]$。它显然不是共轭作用，因为共轭作用不改变特征值，而它把特征值变成了逆。\
            事实上，有：
            $
            "PGL"_n(QQ) := "Inn"(G) times.r {1, psi}
            $
            均为自同构。
            其中 $psi times g = (Inv(g))^T$\
            另一方面，本质来说 $"GL_n"(QQ) tilde.eq "SL"_n(QQ) times Q^times$，其中 $"SL"_n(Q)$ 是特征值为 $1$ 的矩阵。事实上：
            $
            Aut("SL"_n(Q)) = "PGL"_n(QQ) times.r {1, psi}
            $
        - 在所有 $S_n, n>= 4$ 中，除 $n = 6$ 外所有同构都是内自同构。
    ]

    
  == 群的直积，半直积
    以下定理给出我们如何将群分解成子群的直积

    #theorem[][
      设 $H\ norS K, G$，满足：$H sect K = {e}$，则有：
      $
      H K tilde.eq H times K
      $
    ]

    #proof[
      由前面的引理，$H K <= G$\
      定义：
      $
      funcDef(phi, H times K, H K, (h, k), h k)
      $
      验证：
      + $phi$ 是同态
        $
        phi((h_1, k_1) (h_2, k_2)) = phi((h_1 h_2, k_1 k_2)) = h_1 h_2 k_1 k_2 space ? = space h_1 k_1 h_2 k_2 = phi((h_1, k_1)) phi((h_2, k_2))
        $
        只要证明 $h, k$ 交换即可。事实上：
        $
        & h_2 k_1 = k_1 h_2\
        & <=> h_2 k_1 h_2^(-1) = k_1\
        & <=> h_2 k_1 h_2^(-1) k_1^(-1) = e
        $
        注意到：
        $
        h_2 k_1 Inv(h_2) in K, Inv(k_1) in K => h_2 k_1 h_2^(-1) k_1^(-1) in K\
        h_2 k_1 Inv(h_2) in H, Inv(k_1) in H => h_2 k_1 h_2^(-1) k_1^(-1) in H
        $
        从而由 $H sect K ={e}$ 立得原结论
      + $phi$ 是满射：显然
      + $ker(phi) = {e}$
        $
        &phi((h, k)) = e \
        <=>& h k = e\
        <=>& h = k^(-1)\
        =>& h, k  in H sect K\
        =>& h = k = e
        $
    ]

    我们将要给出半直积的概念，通过一个正规子群，另一个子群，以及正规子群在子群上的共轭作用重建群。

    #definition[半直积][
      设 $N, H$ 是群，且 $phi: H -> Aut(N)$ 是一个同态（$phi$ 也是 $H$ 在 $N$ 上的作用）。对 $h in H$，定义 $phi_h = phi(h)$\
      定义半直积（semi-direct product）$N times.r H := N times.r_phi H$ 为在 $N times H$ 上定义乘法运算：
      $
        (n_1, h_1)(n_2, h_2) = (n_1 phi_(h_1)(n_2), h_1 h_2)
      $
      它确实是群，验证结合律：
      $
      ((n_1, h_1)(n_2, h_2))(n_3, h_3)
      &= (n_1 phi_(h_1)(n_2), h_1 h_2)(n_3, h_3)\
      &= (n_1 phi_(h_1)(n_2) phi_(h_1 h_2)(n_3), h_1 h_2 h_3)\
      $
      $
      (n_1, h_1) ((n_2, h_2))(n_3, h_3))
      &= (n_1, h_1)(n_2 phi_(h_2)(n_3), h_2 h_3)\
      &= (n_1 phi_(h_1)(n_2 phi_(h_2)(n_3)), h_1 h_2 h_3)\
      &= (n_1 phi_(h_1)(n_2) phi_(h_1) (phi_(h_2)(n_3)), h_1 h_2 h_3)\
      &= (n_1 phi_(h_1)(n_2) phi_(h_1 h_2)(n_3) , h_1 h_2 h_3)\
      $
    ]

    #proposition[][
      $N, H$ 是 $N times.r H$ 的正规子群
    ]

    半直积的本质是我们希望在 $N times H$ 上复刻 $N H$。显然我们需要考虑如何看待 $h n Inv(h)$。本质来讲，我们的目标就是：
    $
    h n Inv(h) = phi_h (n)
    $
    这里也可以看出半直积和共轭作用是一脉相承的。很自然的我们有：

    #proposition[][
      设 $G$ 是群，$N norS G, H <= G$ 且 $H sect G = {e}$。从而：
      + $N H = H N <= G$
      + $N H tilde.eq N times.r H$
    ]

    #example[][
      $ZZ_n^times := {a mod n | gcd(a, n) = 1}$ （乘法运算）作用在 $Z_n$ 上。
      + $Z_n times.r {plus.minus 1} tilde.eq D_(2n)$\
        $(a, 1) -> r^a$\
        $(0, -1) -> s $
      + $Z_q^times$ （$q$ 为素数）为循环群，阶为 $q - 1$。\
        取其一个子群 $Z_P^times$ 便得 $Z_q times.r Z_p$。\
        例如：$Z_7^times times.r Z_3$，取 $phi_2(1) = 2, phi_4(1) = 4$ 均可得到的半直积。他们看起来不同，但可以找到他们的同构：
        $
        funcDef(Phi, Z_7^times times.r_(phi_2) Z_3, Z_7^times times.r_(phi_4) Z_3, (a, b), (a, 2b))
        $
        这是因为：
        $
        Phi((a, b)(c,d)) = Phi(a + 2^b c, b+d)=(a+2^b c, 2 b + 2 d) \ =
        (a + 4 ^(2 b) c , 2 b + 2 d) = ... = Phi((a, b))Phi((c, d))
        $

    ]
  == Sylow 定理及其应用
    某种意义上，这是在用完全抽象的方法研究有限群，类似于整数的素分解。本节中所有群都是有限群。

    目标：给定素数 $p$，称群 $G$ 是 $p$ 群，如果 $|G| = p^n$。我们希望：
    + 研究 $p$ 群的结构。
    + 对阶形如 $p^alpha m$ 的群 $G$，其中 $gcd(p, m) = 1$。对 $H <= G$，若 $|H| = p^alpha$ ，则称之为 Sylow-p 子群。记 $G$ 中所有 Sylow-p 子群为 $"Sylow"_p (G)$，我们希望把群分解到 Sylow-p 子群上。

    #theorem[Sylow 第一定理][
      任意群 $G$，Sylow-p 子群是存在的。
    ]
    #proof[
      这个定理的证明有很多种，且难度都很大。这里给出一种想法更加结构化的方法。\
      抽象的想法是用可能的方法降低 $|G|$，再用各种方法将子群的 Sylow-p 子群与原群的 Sylow-p 子群联系起来。\
      我们对 $|G|$ 进行归纳：
      + $|G| = 1$，结论是显然的
      + 假设小于 $|G|$ 的情况已经证明：
        - 若 $p | |Z(G)|$，且 $Z(G)$ 是有限交换群。由有限交换群的分类定理，可以将 $Z(G)$ 分解为：
          $
          Z_(p^(t_1)) times Z_(p^(t_2)) times ... times Z_(p^(t_n)) times R
          $
          考虑 $G' := quotient(G, Z(G))$，注意到：
          $
          |G'| = (|G|) / (|Z(G)|)
          $
          对它进行归纳假设，它有 Sylow-p 子群 $H'$，取其原像 $H$，断言： 
          $
          H times Z_(p^(t_1)) times Z_(p^(t_2)) times ... times Z_(p^(t_n))
          $ 
          就是我们想要的 Sylow-p 子群。
          - 令 $K = Z_(p^(t_1)) times Z_(p^(t_2)) times ... times Z_(p^(t_n))$，由定义知 $K subset Z(G)$ 与 $H$ 中的元素全部可交换，从而 $H times K tilde.eq H K <= G$。\
          - $|H K| = |H| |K| = p^alpha m'$，证毕

        - 如若不然，考虑类方程：
          $
            |G| = |Z_G(G)| + sum_(i=1)^k |G : Stab_G(g_i)|
          $
          假设表明后者的求和式中一定有某个 $|G : Stab_G(g_i)|$ 不含 $p$，从而： 
          $
          |Stab_G(g_i)| = p^alpha m' < |G|
          $
          由归纳假设它有 Sylow-p 子群，而它的 Sylow-p 子群一定也是 $G$ 的 Sylow-p 子群
    ] 

    #theorem[Sylow 第二定理][
      若 $P$ 是 Sylow-p 子群，$Q <= G$ 是 $p$ 群，则 $exists g in G$，使得：
      $
       Q <= g P Inv(g)
      $
      这个结论等价于以下事实成立：
      - 所有 Sylow-p 子群都共轭。
      - 所有 $p-$ 子群一定包含于某个 Sylow-p 子群中。
      ]

      #proof[
          这个定理的证明有一些通用的方法：\
          在此我们忽略一些简单情况。\
          令 $Q$ 以左乘作用于 $quotient(G, P)$，并设：
          $
          |Q| = p^(r)
          $
          则：
          $
          m = |quotient(G, P)| = sum_("orbit" OO) OO
          $
          但我们注意到该作用下的都是 $Q$ 的某个陪集，这些陪集的元素个数要么是 $p$ 的幂，要么是 $1$\
          从而我们可以得到一定有一个元素的轨道：
          $
          OO = {g P}
          $ 
          满足：
          $
          forall q in Q:\
          q g P = g P => Inv(g) q g P = P => Inv(g) q g in P => q in g P Inv(g)
          $
          换言之，这给出了 $Q subset g P Inv(g)$，这就证明了结论。
      ]
    #corollary[][
      - 若某个 Sylow-p 子群正规，则它是唯一的 Sylow-p 子群
      - 若 Sylow-p 子群唯一，则它一定正规
    ]
    #corollary[][
      设 $P$ 是 Sylow-p 子群，则有：
      $
      N_G (P) = N_G (N_G (P)) 
      $
      且 $N_G (P)$ 包含唯一的 Sylow-p 子群
    ]
    #proof[
      显然 $P norS N_G (P) <= G$，这给出 $P$ 也是 $N_G (P)$ 的 Sylow-p 子群。

      对于第一个结论，只需证：
      $
      N_G (P) supset N_G (N_G (P)) 
      $
      任取 $x in N_G (N_G (P))$，将有：
      $
      x N_G (P) Inv(x) = N_G (P)
      $
      而：
      $
      x P Inv(x) norS x N_G (P Inv(x) = N_G (P))
      $
      由 Sylow-p 子群唯一性，知 $x P Inv(x) = P$，进而 $x in N_G (p)$，证毕。
    ]

    #theorem[Sylow 第三定理][
      记 $|"Sylow"_p (G)| = n_p$
      - $p | n_p - 1$
      - $n_p | m$
    ]
    #proof[
      考虑 $G$ 以共轭作用于 $"Sylow"(G)$。由第二定理知作用是传递的，我们有：
      $
      n_p = (|G|) / (|Stab_G (P)|)
      $
      由上面的推论，$Stab_G (P) = N_G (P)$ 包含唯一的 Sylow-p 子群，这就说明结论 2 成立。\
      对于结论 1，考虑将 Sylow-p 子群 $P$ 作用 于$"Sylow"(G)$，有：
      $
      n_p = sum((|P|) / (|Stab_P (Q)|))
      $
      我们发现:
      - 若 $Stab_P (Q) != P$，则对应项一定是 $p$ 的倍数；
      - 若 $Stab_P (Q) = P$，则 $P <= N_G (Q)$。由引理，这将给出 $P = Q$，显然右端有且仅有一项成立；
      以上事实给出 $n_p = k p + 1$，证毕。
    ]

    == Sylow 定理的应用
    Sylow 定理十分重要，例如判断单群。

    #example[][
      $132$ 阶群不可能是单群。
    ]
    #proof[
      假设 $|G| = 132 = 3 dot 4 dot 11$，且是单群。\
      显然 $n_3, n_4, n_11 > 1$，否则对应群将成为正规子群。
      - $n_4$ ：
        $
        2 | n_4 - 1\
        n_4 | 33\
        $
        给出 $n_4 = 33$（不可能） 或 $n_4 = 11$ 或 $n_4 = 3$\
        注意到每个 $4$ 阶群至少给出两个 $2$ 阶元，从而总计至少给出 $6$ 个二阶元\
        
      - $n_3$ :
        $
        3 | n_3 - 1\
        n_3 | 44\
        $
        给出 $n_3 = 4$。\
        这意味着我们有 $4$ 个 $3-$ 子群，它们将给出 $2 dot 4 = 8$ 个三阶元。\
      - $n_11$：
        $
        11 | n_11 - 1\
        n_11 | 12\
        $
        给出 $n_11 = 12$。\
        类似的，可以给出 $12$ 个 $11-$ 子群，它们将给出 $10 dot 12 = 120$ 个 $11-$ 阶元。\
      总计给出了 $134$ 个非平凡元，矛盾！
    ]

    #example[][
      设 $|G| = p q$，则 $G$ 只能为以下两种：
      - $Z_p times Z_q$
      - $p | q - 1$，则 $Z_p <= Aut(Z_q)$，此时可以构造两者之间的半直积（而且是唯一的）
      - 
    ]

    #example[][
      设 $N norS G$，$P$ 是 Sylow-p 子群。取 $G -> quotient(G, N)$ 的自然同态 $pi$，则：
      - $pi(P)$
      - $P sect N$
      都是 Sylow-p 子群
    ]
    #proof[
      注意到：
      $
      |P| = |P sect N| |pi(P)|
      $
    ]

    #example[][
      设 $|G| = 105$ 包含正规的 Sylow-3 子群，则它是循环群
    ]
    #proof[
      105 = 3 dot 5 dot 7\
      类似可得：
      $
      n_5 = 1, 21\
      n_7 = 1, 15\
      $
      考虑 $G$ 共轭作用于 $P_3$，显然 $G$ 将给出其上的自同构。\
      另一方面，$P_3$ 的自同构只有两个，这意味着存在 $G -> ZZ_2$ 的同态。而 |G| 是奇数，进而这些作用都是平凡。\
      换言之，$G$ 中所有元素都与 $P_3$ 中元素交换，因此：
      $
      P_3 subset Z (G)
      $
      回到 Sylow 第三定理的证明，我们有：
      $
      n_5 = (|G|) / (C_G (g))
      $
      我们将有：
      $
      P_3 <= Z (G) <= C_G (g) => 3 | C_G (g)
      $
      另一方面，$5 | C_G (g)$，因此 $n_5$ 无法取 $21$\
      同理可得 $n_7$ 无法取 $15$\
    ]
  == 交换子群
    #definition[交换子][
      对 $x, y in G$，定义它们的交换化子：
      $
      [x, y] = Inv(x) Inv(y) x y
      $
    ]
    #proposition[][
      - $[x, y] = e <=> x, y$ 可交换
      - $g [x, y] Inv(g) = [g x Inv(g), g y Inv(g)]$
    ]
    #definition[导出子群][
      称：
      $
      G^"der" = G' := generatedBy([x,y]\, x\, y in G)
      $
      为 $G$ 的导出子群（derived subgroup）
    ]
    注意：导出子群是交换化子生成的群，但其中元素未必都是交换化子
    #proposition[][
      - $G' norS G$，由交换化子的共轭性质可得
      - $quotient(G, G')$ 是交换群
    ]
    #lemma[][
      若 $A$ 是交换群，$phi: G -> A$ 是同态，则有：
      $
      G' subset ker(phi)
      $
      进而，$phi$ 可分解成：
      $
      G ->^pi quotient(G, G') ->^(overline(phi)) A
      $
      或者说：
      $
      Hom(G, A) tilde Hom(quotient(G, G'), A)
      $
    ]
    #corollary[][
      $quotient(G, G')$ 是所有商群中最大的可交换的商群
    ]
    #example[][
      取 $G = D_(2 n)$，则：
      - $[r, s] = r^(-2) in G'$
      - $generatedBy(r^2) subset G'$
      - 考虑同态：
        $
        funcDef(psi, G, {1,-1}, r\,s, 1\,-1,)
        $
        从而 $G' subset ker psi = generatedBy(r)$
      - 若 $n$ 是奇数，则 $generatedBy(r^2) = generatedBy(r)$，进而 $G' = generatedBy(r)$
      - 若 $n$ 是偶数，考虑同态：
        $
        funcDef(psi, G, {1,-1} times {1, -1}, r\,s, (-1, 1)\,(1, -1),)
        $
        类似可以证明 $G' subset ker psi = generatedBy(r^2)$
      - 由此，容易给出 $D_(2n)$ 到任意交换群的同态
    ]
    #definition[导出序列][
      对于任意群 $G$，定义：
      $
      G^0 = G, G^1 = [G, G], ..., G^(n+1) = [G^n, G^n]
      $
      为 $G$ 的导出序列（derived series）
    ]
    可解群定义于@series \
    导出序列的动机来源于可解群。为了验证一个群是否可解，我们当然希望让商群尽可能大，剩下的群尽可能小，很自然的我们应该考虑 $[G, G]$，以此类推即可。
    #theorem[][
      群 $G$ 可解当且仅当 $G^n = {e}$ 对某个 $n$ 成立
    ]
    #proof[
      <=: 注意到每次取交换化子得到之前群的正规子群，因此直接取导出序列即可\
      =>: 设 ${1} lt.tri.eq H_1 lt.tri.eq ... lt.tri.eq H_k = G$是满足可解群要求的序列。
        - 显然 $[H_i, H_i] subset H_(i+1)$，从而：
        - $G^1 = [G, G] = [H_k, H_k] subset H_(k-1)$
        - $G^2 = [G^1, G^1] subset [H_(k-1), H_(k-1)] subset H_(k-2)$
        - ...
        依此类推，我们有 $G^n subset H_(k-n)$，从而 $G^n = {e}$，证毕
    ]
    #definition[特征子群][
      称 $H <= G$ 是特征子群，如果 $forall phi in Aut(G): phi(H) = H$
    ]
    特征子群是 $G$ 的骨架，任何自同构都无法改变它。\
    #proposition[][
      - 若 $G$ 只有一个某阶的子群，显然它是特征子群。\
      - 特征子群显然是正规子群（在共轭作用/内自同构下保持不变）
    ]
    
    #lemma[][
      $G^i$ 是 $G$ 的特征子群
    ]
    #proof[
      - 
        $
        G_1 = [G, G] = generatedBy([x,y]\, x\, y in G)\
        phi(G_1) = generatedBy([phi(x),phi(y)]\, x\, y in G) = [G, G] = G_1
        $
      - 类似归纳证明： $phi(G^i) = phi([G^(i-1), G^(i-1)]) = [phi(G^(i-1)), phi(G^(i-1))] = [G^(i-1), G^(i-1)] = G^i$
    ]
    #proposition[][
      - 若 $H <= G$，显然 $H^i <= G^i$，从而 $G$ 可解 $=> H$ 可解
      - 若 $G -> K$ 存在商同态，则 $pi(G^(i)) = K^i$，从而 $G$ 可解 $=> K$ 可解
      - 若 $N norS G$，且 $N, quotient(G, N)$ 都可解，则 $G$ 可解
    ]
  == 幂零群
    #definition[幂零群][
      对群 $G$，定义：
      $
      G^0 = G, G^1 = [G, G], G^2 = [G, G^1], ..., G^(n+1) = [G, G^n]
      $
      显然它比导出序列的每项略大，称为 lower central series。\
      类似可以证明它的每项也是 $G$ 的特征子群。\
      称 $G$ 是幂零的，如果 $G^n = {e}$ 对某个 $n$ 成立
    ]
    #example[][
      之前在@series 构造的上三角矩阵群是经典的可解但不幂零的群。\
    ]
    #proposition[][
      幂零群一定是可解群
    ]
    #definition[upper central series][
      对于群 $G$，考虑 $quotient(G, ZZ(G)) := overline(G)$，它产生了新的中心 $ZZ(quotient(G, ZZ(G)))$，称它在 $G$ 中的原像为 $G$ 的第二中心，记为 $ZZ_2(G)$,它是正规的。\
      以此类推，定义 $ZZ_n (G)$ 为 $ZZ(quotient(G, ZZ_(n-1)(G)))$ 在 $G$ 中的原像。\
      这个序列称为 upper central series
    ]
    #theorem[][
      - 群 $G$ 幂零当且仅当 upper central series 终止于 $G$。更准确地说，$G^c = {1} <=> ZZ_c (G) = G$。
      - 上式成立时，我们有：
      $
      G^(c-1-i) <= ZZ_i (G)
      $
    ]
    注：这说明两个序列类似于对偶的关系。很容易产生 $ZZ_i (G) <= G^(c- i - 1)$的想法，但它是错误。
    #proof[
      对 $c$ 做归纳，考虑 $overline(G) = quotient(G, ZZ (G))$\
      为了证明结论，我们需要：
      + $G^c = {1} <=> overline(G)^(c-1) = {1}$\
        注意到：
        $
        G^(c) = [G, G^(c-1)] = {1} <=> G^(c-1) subset ZZ(G)
        $
      + $ZZ_(c-1)(overline(G)) = overline(G) <=> ZZ_(c)(G) = G$\
        归纳证明：
        $
        Inv(pi)(ZZ_i (overline(G))) = ZZ_(i+1)(G)
        $
      以上两个事实便可给出第一个结论

      对于结论二，注意到：
      $
      G^(c-i-1) <= Inv(pi)(overline(G^(c-i-1))) = Inv(pi)(ZZ_i(overline(G))) = ZZ_(i+1)(G)
      $
      #theorem[][
        设 $P$ 是 $p-$ 群
        - $P$ 是幂零的。事实上，它的子群还是 $p-$ 群，且中心一直非平凡，因此结论显然
        - 若 $H norS P, H != {1}$，则 $H sect Z(P) != {1}$\
        - 若 $H lt.nequiv P$，则 $ H lt.nequiv N_P (H)$
      ]
      #proof[
        结论二：用 $P$ 于 $H$ 上的共轭作用的类方程，单点轨道就是 $H sect Z(P)$，非单点轨道的元素个数都是 $p$ 的倍数

        结论三：
          用归纳法
          + 若 $Z_(P) subset.not H$，结论是显然的。
          + 若不然，考虑 $quotient(H, Z_(P))$，归纳结论应用于商群便可得到结论
      ]
      #theorem[幂零群结构定理][
        设 $|G| = p_1^(alpha_1) p_2^(alpha_2) ... p_n^(alpha_n)$，则以下事实等价：
        + $G$ 是幂零群
        + 若 $H lt.nequiv G$，则 $H lt.nequiv N_G (H)$
        + 它的 Sylow 子群全部正规。
        + $G$ 是各个 Sylow 子群的直积
      ]
      #proof[
        - $3 => 4$ 是容易的\
        - $4 => 1$ 注意到所有 $p-$ 群都幂零\
        - $2 => 3$ 回忆对 Sylow-p 子群 $P$，将有：
          $
            N_G (P) = N_G (N_G (P)) 
          $
          结合 2 立得 $N_G (P) = G$ 从而 $P$ 正规
        - $1 => 2$ 类似之前 p-群幂零的证明，注意到幂零群的中心非平凡，仿照其证明即可
      ]
      #theorem[Shur - Zasnhous][
        设 $G$ 是有限群，$N norS G$。若：
        $
        gcd(|N|, |quotient(G, N)|) = 1
        $
        则将有：
        $
        G = N times.r quotient(G, N)
        $
      ]
    ]
    == 总结
      群论部分我们依次研究了：
      + 循环群，极其简单
      + 交换群，有有限交换群分类定理
      + 上升序列和下降序列可以给出群中结构简单的部分
      + 对于单群，以上分解都是无效的，它们是群中相对较为复杂而核心的部分
]