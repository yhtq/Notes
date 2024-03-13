#import "../../template.typ": *
#show: note.with(
  title: "抽象代数/代数学基础",
  author: "YHTQ",
  date: none,
  logo: none,
)
#let chapterTwo = [
= 环
    == 概念
        #definition[环][
        设 $R$ 为非空集合，$dot, +$ 为 $R$ 上的二元运算，若 $R$ 满足：
        - $R$ 关于 $dot$ 构成幺半群，单位元往往记为 $1$
        - $R$ 关于 $+$ 构成交换群，单位元往往记为 $0$
        - $dot$ 对 $+$ 有左/右分配律，即：
        $
        forall a, b, c in R, space a (b + c) &= (a b) + (a c) = a b + a c \
        (b + c) a &= (b a) + (c a) = b a + c a
        $
        （习惯上乘法优先级高于加法）\
        则称 $R$ 为环\
        若乘法也交换，则称 $R$ 为交换环或可交换环\
        若非零元都可逆，则称其为除环（division ring）或者体（skew field）\
        一般而言，额外规定 $0 != 1$，换言之环至少有两个元素
        ]

        注：这里定义环的乘法有单位元，许多资料中不要求环有单位元，此时有单位元的环称为幺环
        #definition[域][
            交换的可除环称为域
        ]

        #example[][
        - $ZZ$ 在通常的加法和乘法下构成环。当 $k > 1$ 时，$k ZZ$ 无乘法单位元，但其它要求都满足
        - $ZZ[1/n] := {a / N^r, a in ZZ, r in ZZ_(>=0)}$
        - 设 $R$ 是环。则：
            - $R[x]$ 也即 $R$ 上的多项式构成环
            - $"Mat"_(n times m) (R)$ 也即 $R$ 上的 $n times m$ 矩阵构成环
        - 四元数：$H = {a + b i + c j + d k, a, b, c, d in RR}$，其乘法规定为：
            $
            i^2 = j^2 = k^2 = -1\
            i j = - j i = k, j k = - k j = i, k i = - i k = j
            $
            类似复数，定义其共轭为：
            $
            overline(a + b i + c j + d k) = a - b i - c j - d k
            $
            注：共轭不是同构，我们有：$overline(z w) = overline(w) overline(z)$

            定义其模为 $norm(z) := z overline(z) = a^2 + b^2 +c^2 +d^2$，进而 $Inv(z) = overline(z)/norm(z)$

            注：四元数中，可以只要求 $a, b, c, d in QQ$，$i^2 = A, j^2 = B, k^2 = i j i j = -i^2 j^2 = -A B$，这是一种在数论上很有用的四元数代数。对某些 $A, B$，这个代数相当于一个矩阵代数，但大部分情况不是
        - 群环（group ring）：设 $G$ 是交换群，定义：
            $
                R[G] = {sum_(g in G) a_g g, a_g in R, "仅有有限个" a_g != 0}\
            $
            乘法规定为类似多项式的乘法\
            例：
                - $G = ZZ_n$，则 $R[G] = {a_0 +a_1 sigma + a_2 sigma^2 +... +a_(n-1)sigma^(n-1)}$
                - $G = ZZ$，则 $R[G] = R[RR]$
        ]

        #proposition[][
        - 除零环外，$0$ 是不可逆的
        - $forall a in R, space 0 a = a 0 = 0$
        - $forall a in R, space (-1) a = a (-1) = -a$
        - $forall a in R, space (-a) (-b) = a b$
        - $forall a in R, space a (-b) = (-a) b = - (a b)$
        - $forall a in R, space (-a) b = a (-b) = - (a b)$
        ]
        #definition[环之间的映射][
            设 $R, S$ 都是环，$f: R -> S$ ：
            + 为环同态，若：
                - 保持加法：$forall a, b in R, space f(a + b) = f(a) + f(b)$
                - 保持乘法：$forall a, b in R, space f(a b) = f(a) f(b)$
                - 保持单位元：$f(1) = 1$
                此时规定 $ker(f) = Inv(f)(0)$，类似有 $f$ 是单射 $<=> ker(f) = {0}$
            + 为环同构，若 $f$ 是双射
        ]
        #example[][
            + $Z -> Z_n$ 上有自然的模 $n$ 同态
            + 若 $R$ 是交换环（注意交换性），则存在 $R$ 上多项式环 $R[x]$ 到 $R$ 的代入同态 $f$\
                注：若没有交换性，则 $(a x)(a x) ?= a^2 x^2$
        ]
        #definition[][
            设 $R$ 是环：
            - 称 $x$ 是零除子/零因子（zero-divider），若存在 $y != 0$ 使得 $x y = 0$ 或 $y x = 0$
            - 称 $x$ 为可逆元/单位，若存在 $y$ 使得 $x y = y x = 1$
            - 单位一定不是零因子
            - 将所有 $R$ 上的乘法可逆元构成的集合记为 $R^times$，它关于乘法构成群
        ]
        #proposition[][
            若 $a$ 不是零除子，则：
            $
            a b = a c => a(b - c) = 0 => b = c
            $
        ]
        #definition[整环][
            无零除子的交换环称为整环（integral domain）
        ]
        由上面命题知，整环中的乘法满足消去律
        #example[][
            - 在 $ZZ_n$ 中，可逆元是那些与 $n$ 互素的元素，零除子是那些与 $n$ 不互素的元素（除 $0$ 之外）
            - 设 $R$ 是整环，则 $R[x]$ 也是整环
        ]
        #lemma[][
            设 $R$ 是有限整环，则 $R$ 是域
        ]
        #proof[
            只需证明每个非零元都有乘法逆\
            设 $a in R, a != 0$。显然 $f := [x | x -> a x]$ 是加法群同态。\
            更进一步，$f$ 是单射，因为 $ker(f) = {0}$，而 $R$ 是有限集，故 $f$ 是双射。\
            因此，取 $b = Inv(f)(1)$ 立得 $a b = 1$
        ]
        #theorem[][
            有限的可除环均可交换（从而为域）
        ]
        其证明颇为复杂
        #definition[分式域/fraction field][
            模仿整数构造有理数的方法，可以从整环中构造分式域：
            $
            "Frac"(R) = {(a, b) in R times (R - {0})}
            $
            称 $(a, b) = (c, d)$ 当且仅当 $a d = b c$，类似有理数定义乘法和加法
        ]
        显然 $QQ$ 是 $ZZ$ 的分式域，分式多项式是整多项式的分式域
    == 理想
        环中的理想类似群中正规子群，是为了构造商结构必须的
        #definition[左理想（left ideal）][
            设 $R$ 是环，$I$ 是 $R$ 的子集，若：
            - $I$ 关于加法构成子群（对加法封闭）
            - $forall a in R, space forall b in I, space a b in I$
            则称 $I$ 是 $R$ 的左理想
        ]
        交换第二条中的乘顺序，得到右理想的定义
        #definition[双边理想/理想（ideal/two-sided ideal）][
            若 $I$ 同时是左理想和右理想，则称 $I$ 是双边理想或者理想
        ]
        注意：一个理想几乎总不是子环，首先它几乎不可能包含单位元，否则将有 $I = R$
        #example[][
            设 $R$ 是交换环，${a_j | j in J} subset R$，称：
            $
            {sum_(j in J) r_j a_j | r_j in R, "仅有有限个" r_j != 0}
            $
            为 ${a_j | j in J}$ 生成的理想。显然它也是包含 ${a_j | j in J}$ 的最小理想，一般记作 $(a_j | j in J)$\
            考虑 $ZZ$，则 ${2, 4, 6, 8}$ 的生成理想就是全体偶数。一般的，整数集合生成的理想就是它们的最大公约数生成的理想
        ]
        #definition[理想之间的运算][
            设 $I, J$ 是环 $R$ 的双边理想，则：
            - $I + J = {a + b | a in I, b in J}$
            - $I J = {a_i b_j "的有限和" | a_i in I, b_j in J}$
        ]
        这可以理解为某些元素生成的理想之和就是这些生成元的和生成的理想，乘法类似
        #proposition[][
            注意到 $I J subset I, I J subset J$，从而：
            $
            I J subset I sect J
            $
        ]
    == 商环
        #definition[商环][
            设 $R$ 是环，$I$ 是 $R$ 的（双边）理想，定义：
            $
            quotient(R, I) = {a + I | a in R}
            $
            其中 $a + I = b + I <=> a - b in I$，定义：
            $
            (a + I) + (b + I) = (a + b) + I\
            (a + I) (b + I) = (a b) + I
            $
            则 $quotient(R, I)$ 关于上述加法和乘法构成环，称为 $R$ 模 $I$ 的商环
        ]
        注：两条规定的合理性分别来自于双边理想的三条性质

        类似可以有自然同态 $R -> quotient(R, I)$\
        #theorem[同构定理][
            设 $R, S$ 是环，$phi: R -> S$ 是环同态，则：
            - $ker (phi)$ 是双边理想
            - $phi$ 诱导了环同构 $quotient(R, ker(phi)) -> phi(R)$ 
        ]
        #theorem[对应定理][
            设 $I$ 是 双边理想，则：
            $
            {J | J "是左/右/双边理想", I subset J} <-> {J | J "是"quotient(R, I)  "的双边理想"}
            $
            之间存在保持各种结构的一一对应
        ]
        #example[][
            $
            funcDef(phi, R[G], R, sum a_j x_i, sum a_j)
            $
            是自然的同态，且有：
            $
            ker(phi) = (g - 1 | g in G)
            $
        ]
        #example[][
            $quotient(QQ[x, y, z], (x - y^2, y - z^3)) tilde.eq QQ[z]$ 
        ]
        #proof[
            我们发现：
            $
            x y = (x - y^2 + y^2)y = y^3 + *(x-y^2)\ = (y - z^3 + z^3)^3 + *(x -y^2) = z^9 + *(x - y^2) + *(y - z^3)
            $
            其他项类似可得
        ]
        上面例子说明，某种意义上我们确实可以认为在商环中，$x = y^2, y = z^3$，换言之商环就是把一些元素等同起来，从而简化了环的结构。
        #example[][
            容易验证：
            $
            RR[x] &-> CC\

            $
        ]
    == 中国剩余定理
        #theorem[中国剩余定理][
            设 $m_i$ 两两互素，则：
            $
            funcDef(phi, ZZ, quotient(ZZ, m_1 ZZ) times ... times quotient(ZZ, m_n ZZ), a, (a mod m_1, ..., a mod m_n))
            $
            是满同态，且：
            $
            ker (phi) = quotient(ZZ, m_1 ZZ) times ... times quotient(ZZ, m_n ZZ)
            $
        ]
        为了推广这个结论，我们一定程度上需要推广互素的概念：
        #definition[][
            称交换环的两个理想 $I, J$ 互素，如果：
            $
                I + J = R
            $
        ]
        这个定义的思路来自于数论中的裴蜀定理\
        #theorem[推广的中国剩余定理][
            设 $I_i$ 是交换环 $R$ 的理想
            + 
                $
                funcDef(phi, ZZ, I_1 times ... times I_n, a, (a mod m_1, ..., a mod m_n))
                $
                是同态，且 $ker(phi) = I_1 sect I_2 sect ... sect I_n$
            + 若 $I_i$ 两两互素，则:
                + $phi$ 是满射
                + $I_1 sect I_2 sect ... sect I_n = I_1 I_2 ... I_n$
        ]
        #proof[
            - 先证 $n=2$ 的情形，剩下的采用归纳法\
                 （1）结论是显然的，只证 （2）   

                 + 注意到：
                     $
                        R = I_1 + I_2 => 1 = a + b, a in I_1, b in I_2
                    $
                    从而对 $forall c in I_1 sect I_2$，将有：
                    $
                        c = c a_1 + c a_2
                    $
                    而由理想的定义，$c a_1 in I_1, c a_2 in I_2$，进而由理想乘积的定义立得 $c in I J$\
                    另一侧由前面的命题是显然的，因此 $I_1 I_2 = I_1 sect I_2$
                + 继续使用上面的 $a, b$，注意到：
                    $
                    phi(a) = (a_1 + I_1, a_1 + I_2) = (0, 1 - a_2 + I_2) = (0, 1 + I_2) \
                    phi(b) = ... = (1 + I_1, 0)
                    $
                    因此 $(x + I_1, y + I_2) = phi(x a + y b) in im(phi)$，这就表明 $phi$ 是满射
            - 再使用归纳法，关键是证明：
                $
                    I_1 "与" I_2 I_3 ... I_k "互素"
                $
                设：
                $
                1 = a_i + b_i, b_i in I_i, a_i in I_1
                $
                则：
                $
                1 = product_i (a_i + b_i) = sum_i * a_i  +  product_i b_i 
                $
                由理想定义，$sum_i * a_i in I_1$，而 $product_i b_i in I_2 I_3 ... I_n$，这就给出了证明
        ]   
    == 极大理想、素理想
        #definition[极大理想][
            设 $R$ 是环，$m$ 是 $R$ 的双边理想，若 $m != R$ 且没有包含 $m$ 的双边理想，则称 $m$ 是极大理想
        ]
        #example[][
            - 在 $ZZ$ 中，$quotient(ZZ, p ZZ)$ 就是极大理想
            - 在 $RR[x]$ 中，$(p, g(x))$ ，其中 $g(x)$ 是不可约多项式，也是极大理想
            - 设 $G$ 是有限群，$CC[G] supset I_G = (g-1, g in G)$ 是极大理想，且 $quotient(R, I_G) = CC$
        ]
        #theorem[][
            任何非平凡的理想 $I$ 都包含在某个极大理想中
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
        #lemma[][
            交换环 $R$ 是域当且仅当 $R$ 中只有平凡理想
        ]
        #proof[
            若 $R$ 是域，则 $R$ 中只有平凡理想显然。\
            反之，若 $R$ 中只有平凡理想，取 $a in R, a != 0$，则 $(a)$ 是非平凡理想，从而 $(a) = R$，因此存在 $b$ 使得 $a b = 1$
        ]
        注：该引理仅对交换环成立。事实上，若取 $R$ 为全体 $n times n$ 矩阵，则没有非平凡理想，但它也不是域。
        #proposition[][
            设 $R$ 是交换环，则 $I$ 是极大理想当且仅当 $quotient(R, I)$ 是域
        ]
        #proof[
            由第四同构定理，$I$ 是极大理想当且仅当 $quotient(R, I)$ 仅有平凡理想，进而由引理知结论成立。
        ]
        #definition[素理想][
            设 $R$ 是环，$P$ 是非平凡理想，称 $P$ 是素理想，若：
                $
                    a b in P => a in P or b in P
                $
        ]
        #proposition[][
            设 $R$ 是环，$P$ 是非平凡理想，则 $P$ 是素理想当且仅当 $quotient(R, P)$ 是整环
        ]
        #proof[
            取 $pi$ 是自然同态：
            - $arrow.l.double:$ 设 $a, b in R, a b in P$，则：
                $
                pi(a b) = 0 => pi(a) pi(b) = 0 => a in P or b in P
                $
            - $arrow.r.double:$ 设 $a, b in R, pi(a) pi(b) = 0$，则：
                $
                pi(a) pi(b) = 0 => pi(a b) = 0 => a b in P => a in P or b in P => pi(a) = 0 or pi(b) = 0
                $
        ]
        #corollary[][
            交换环中的极大理想都是素理想。
        ]
        注：反之不然，$ZZ[x]$ 中 $(p)$ 是素理想，但不是极大理想
        #proposition[][
            设 $R$ 是交换环：
            + 设 $I_i$ 是一些理想，$P$ 是素理想。若：
                $
                    P subset sect_(i in I) I_i
                $
                则存在 $i$ 使得 $I_i subset P$
            + 若：
                $
                    P = sect_(i in I) I_i
                $
                则 $P = I_i$
            + 设 $P_i$ 是一些素理想，$I$ 是理想且：
                $
                I subset union_(i in I) P_i
                $
                则：
                $
                exists i: I subset P_i
                $
        ]
        #proof[
            若对每个 $i$，存在 $x_i$ 使得 $x_i in.not P$，则：
            $
            product_i x_i in sect_(i in I) I_i
            $
            又由素理想定义：
            $
            product_i x_i in.not P
            $
            这表明：
            $
            P subset.not sect_(i in I) I_i
            $

            对于结论二，天生有：
            $
                P = sect_(i in I) I_i subset I_i 
            $
            因此结论成立

            对于结论三，用归纳法证明反向结论：若 $I$ 不在 $n$ 个素理想之中，则 $I$ 不在这些素理想的并之中。
            - $n = 1$ 时显然
            - 假设 $n - 1$ 时成立，则对 $x_i in I$：
                - 若存在某个 $x$ 不在所有 $P_i$ 中，由归纳假设结论显然成立。
                - 否则，设 $forall x : x in.not union_(k=1)^(n-1) P_k => x in P_n$\
                    根据条件，可取 $x_i in.not P_i$，由假设知：
                    $
                    x_1, x_2, ..., x_(n-1) in P_n\
                    x_n in.not P_n
                    $
                    从而考虑：
                    $
                    product_i x_i
                    $
        ]
        #lemma[][
            设 $f$ 是环同态，$J$ 是素理想，则 $Inv(f)(J)$ 也是素理想
        ]
        #proof[
            取 $pi: f(R) -> quotient(f(R), J)$，则对 $pi compose f$ 使用第一同构定理：
            $
            quotient(R, Inv(f)(J)) <= quotient(f(R), J)
            $
            上式右端是整环，从而左端也是整环，进而 $Inv(f)(J)$ 是素理想
        ]
    == 整环
        这节中所有都讨论的是整环，也即没有零因子的交换环。
        #definition[整除][
            称 $a | b$，如果：
            - 存在 $q$ 使得 $b = a q$
            - $b in (a)$
            （以上两者等价）
        ]
        #definition[素元][
            称一个元素 $p$ 是素元，如果：
            - $(p)$ 是素理想
            - $p | a b <=> p | a or p | b$
            （以上两者等价）
        ]
        #definition[相伴][
            两个元素 $a, b$ 被称为相伴的，如果：
            -  $a = b u$ 且 $u$ 是单位（是可逆元）
            -  $a = b u and b = a v$
            （以上两者等价）
        ]
        相伴的引入是因为我们无法避免 $p = (-1)(-p)$ 之类我们不想要的非平凡分解，这种情况的产生依赖于 $-1$ 是可逆元，我们希望排除这些情况
        #definition[不可约元][
            称一个元素 $p$ 不可约，如果：
            $
            p = a b <=> a "为单位或" b "为单位"
            $ 
        ]
        #proposition[][
            $p$ 是素元 $=>$ $p$ 是不可约元
        ]
        #proof[
            假设 $p$ 是可约的素元，也即存在不是单位元的 $u, v$，$p = u v$\
            由 $(p)$ 是素理想，不妨设 $u in (p)$，也即 $u = k p$\
            这意味着：
            $
            p = u v = k p v => k v = 1
            $ 
            进而 $v$ 是单位，证毕。
        ]
        === 主理想整环
            #definition[主理想整环 Principle Ideal Domain, PID][
                称一个整环是主理想整环，如果它的每个理想都是主理想（由一个元素生成）
            ]
            #proposition[][
                在 PID 中非平凡素理想等价于极大理想
            ]
            #proposition[][
                在 PID 中素元等价于不可约元
            ]
            #example[][
                $ZZ[x]$ 不是主理想整环，因为 $(2, x)$ 不是主理想
            ]
        === 欧几里得整环
            #definition[欧几里得整环（ED）][
                一个整环 $R$ 称为欧几里得整环，如果存在范数 $N: R -> ZZ_(>=0)$，满足：
                    + $N(0) = 0$
                    + $forall a, b: exists q, r: a = b q + r, N(r) < N(b)$
            ]
            注：欧几里得整环就是可以做辗转相除法的整环，其中 $q, r$ 未必唯一，但不影响辗转相除
            #example[][
                + 域是欧几里得整环（显然每两个元素都能整除）
                + 整数环，多项式环是欧几里得整环
                + 高斯整数环：$ZZ[i] subset CC$ 是欧几里得整环，其中范数就是复数的范数：
                    给定 $a, b in ZZ[i]$，选取 $q$ 使得 $|Re(q) -a/b|<= 1/2, |Im(q) -a/b|<= 1/2$，此时有：
                        $
                        |a - b q| = |b| |a/b - q| <= 1/2 |b| < |b|
                        $
                    显然这样的 $q$ 的选取并不唯一，但我们并不关心
                + $ZZ[omega_3]$，其中 $omega_3$ 是三次单位根，也是欧几里得整环
            ]
            #proposition[][
                欧几里得整环一定是主理想整环
            ]
            #proof[
                和整数的情形很类似。\
                设 $I$ 是欧几里得整环 $R$ 的理想，取 $a in I, a != 0$ 使得 $N(a)$ 最小。\
                断言 $I = (a)$：\
                事实上，若 $b in I$，则：
                $
                b = a q + r
                $
                而 $r = b -a q in I, N(r) < N(a)$。由 $a$ 的范数最小性，$r = 0$，从而 $b in (a)$
            ]
            欧几里得整环是历史较早的判断整环是否是主理想整环的方法，但泛用性比较有限。例如，$ZZ[c], c in CC$ 是主理想整环的例子很多，但在通常的范数下是欧几里得整环的例子屈指可数。
        === 唯一分解整环
            #definition[唯一分解整环（UFD）][
                称一个整环 $R$ 是唯一分解整环，如果：
                    + $forall r in R$，$r$ 不是 $0$，单位，则$r$ 可以写成若干个不可约元 $p_1, p_2, ..., p_m$ 的乘积
                    + 这种分解在不考虑顺序和相伴的情况下是唯一的，也即若 $r = p_1 p_2 ... p_n = q_1 q_2 ... q_m$，则 $n = m$，且将存在置换 $sigma$ 使得 $sigma(p_1, p_2, ..., p_n)$ 与 $(q_1, q_2, ...,q_n)$ 每个元素都相伴
            ]
            #example[][
                - $ZZ[sqrt(-5)]$ 不是唯一分解整环，因为 $6 = 2 times 3 = (1 + sqrt(-5)) (1 - sqrt(-5))$，其中 $1 plus.minus sqrt(5)$ 是不可约元，但不是素元
            ]
            #proposition[][
                唯一分解整环中，不可约元等价于素元
            ]
            #proof[
                只需证明不可约元是素元：\
                假设 $p$ 不可约，且 $p | a b <=> p r = a b$\
                将 $a, b$ 写成不可约元的乘积：
                $
                a = q_1 q_2 ... q_n, b = q_(n+1) q_(n+2) ... q_(n+m\
                $
                又由分解的唯一性，其中必有一个元素 $q_i$ 与 $p$ 相伴。
                
                设 $p = r q_i$。不妨设 $b = k q_i$，则 $b = k Inv(r) p => p | b$，证毕。
            ]
            #definition[最大公约数（gcd）][
                设 $a, b$ 是整环 $R$ 中的元素，称 $d$ 是 $a, b$ 的最大公约数，如果：
                - $d | a, d | b$
                - $forall c: c | a, c | b => c | d$
                也等价于取出 $a, b$ 不可约分解中所有共同（相伴）部分
            ]
            #proposition[][
                最大公因数在相伴的意义下是唯一的
            ]
            类似也可以定义最大公倍数（lcm）
            #theorem[][
                主理想整环都是唯一分解整环
            ]
            #proof[
                假设 $r$ 不是 $0$，单位，先证明存在性：
                    
                    假设 $r$ 不能分解成有限个不可约元的乘积
                    + 显然 $r$ 不是不可约元，因此 $r = a_1 b_1$，$a_1, b_1$ 都不是 $0$，单位元
                    + 如果 $a_1, b_1$ 都可有限分解，则 $r$ 也可有限分解，矛盾。因此不妨设 $b_1$ 不能有限分解，从而 $b_1$ 可以继续写成 $b_1 = a_2 b_2$
                    + 以此类推，我们得到一个无穷序列 $r = a_1 b_1 = a_1 a_2 b_2 = ...$
                    + 这说明我们得到了一个无穷升链：
                        $
                        (r) subset (b_1) subset (b_2) subset ...
                        $
                        考虑：
                        $
                        S = union (b_i)
                        $
                        它确实是理想。而我们在一个主理想整环中，因此可设：
                        $
                        S = (b)
                        $
                        有定义，存在 $i$ 使得 $b in (b_i)$，由此 $(b) = (b_i)$，且对所有 $n > i$，均有：
                        $
                        (b_n) = (b_i)
                        $
                    + 然而在上面的分解中，若 $(b_i) = (b_(i+1))$，则有：
                        $
                        b_i = a_(i+1) b_(i+1)\
                        b_(i+1) = k b_i
                        $
                        从而：
                        $
                        b_(i+1) = k a_(i+1) b_(i+1) => k a_(i+1) = 1
                        $
                        这将给出 $a_(i+1)$ 是单位，矛盾！
            ]
        === 多项式环
            #lemma[][
                域上的多项式环是欧几里得整环，主理想整环，唯一分解整环。
            ]
            #theorem[][
                若 $R$ 是唯一分解整环，当且仅当 $R[x]$ 也是唯一分解整环（进而 $n$ 元多项式环也是唯一分解整环）
            ]
            #proof[
                若 $R[x]$ 是唯一分解整环，在 $R[x]$ 中取得 $r in R$ 非零、单位，它可被写作 $R[x]$ 中若干不可约元的乘积，从而：
                    $
                    r = p_1(x) p_2(x) ... p_m (x)
                    $
                观察两侧多项式的次数，注意到在整环中满足 $deg(f g) = deg(f) + deg(g)$，由此右边每一项次数均为 $0$，这表明右边也都是常多项式，也即：
                    $
                    p_i (x) = r_i\
                    r = r_1 r_2 ... r_m
                    $
                而 $r_i$ 在 $R[x]$ 中不可约，在它的子环中当然不可约，同时由子环关系也易得唯一性。

                若 $R$ 是唯一分解整环，先证明一个引理：
                #lemma[高斯引理][
                    设 $p(x) in R[x]$ 是非零多项式，$F$ 是 $R$ 的分式域。
                    - 若 $p(x)$ 可以写作 $F[x]$ 中若干多项式的乘积，则可以写作 $R[x]$ 中若干多项式的乘积。
                    - 若其在 $F[x]$ 中可约，则在 $R[x]$ 中也可约。
                ]
                #proof[
                    设 $p(x) = A(x) B(x)$,$A(x), B(x) in F[x]$ 且次数大于等于 $1$。往证可以将右侧调整为 $R[x]$ 中元素的乘积（也就是通分）。

                    取 $d_1, d_2 in R-{0}$ 使得：
                        $
                        d_1 A(x) = a(x) in R[x], d_2 B(x) = b(x) in R[x]
                        $
                    记 $d = d_1 d_2$，将有：
                        $
                        d p(x) = a(x) b(x)
                        $
                    我们目标是消去 $d$ 中不可约元素：
                    - 若 $d$ 可逆，则有 $p(x) = Inv(d) a(x) b(x)$，结论成立。
                    - 若不然，则考虑它的唯一分解：
                        $
                        d = product_i p_i^(alpha_i)
                        $
                        考虑商环 $quotient(R, (p_i))$，由于 $p_i$ 是素元，故商环是整环。考虑 $R[x] -> quotient(R, (p_i))[x]$ 的自然同态 $pi$，有：
                        $
                        0 = pi(d p(x)) = pi(a(x)) pi(b(x))
                        $
                        由于这是整环，因此 $pi(a(x)) = 0$ 或 $pi(b(x)) = 0$。\
                        不失一般性，设 $pi(a(x)) = 0$，这意味着 $a(x)$ 中所有系数都有因子 $p_i$，因此可设：
                        $
                        a(x) = p_i a_1(x)
                        $
                        因此：
                        $
                        (d / p_i) p(x) = a_1(x) b(x)
                        $
                        注意到 $d$ 的唯一分解减少了，反复进行即可彻底消去 $d$，最终可得：
                        $
                        p(x) = a_n (x) b_n (x)
                        $
                        其中 $a_n (x), b_n (x) in R[x]$

                ]
                注：这个引理是经典的若多项式在有理数域上可约，则在整数域上也可约的推广。

                回到定理的证明，设 $a(x) in R[x] - {0}$，设它不是单位。取 $d$ 为 $a(x)$ 所有系数的最大公因子，则 $a(x) = d a_1(x)$，$a_1(x)$ 所有系数最大公因子是 $1$。要找 $a(x)$ 的分解只需找到 $a_1(x)$ 的分解即可。\

                我们知道以域为系数的多项式环是唯一分解整环，因此在 $F[x]$ 中，可将 $a_1(x)$ 写作若干不可约元的乘积：
                    $
                    a_1(x) = P_1(x) P_2(x) ... P_n (x)
                    $
                连续利用高斯引理，可得：
                    $
                    a_1(x) = p_1(x) p_2(x) ... p_n (x)
                    $
                    其中 $p_i (x) in R[x]$。\
                另一方面，每个 $p_i (x)$ 在 $F[x]$ 中不可约，且它的系数的最大公因子也是 $1$（否则它的最大公因子将成为 $a_1(x)$ 的最大公因子），因此 $p_i (x)$ 在 $R[x]$ 中也不可约。\
                这就证明了分解的存在性。

                再证明其唯一性，设：
                    $
                    a_1(x) = p_1(x) p_2(x) ... p_n (x) = q_1(x) q_2(x) ... q_m (x)
                    $
                + 考虑其中非常多项式的项：
                    把它们都看作 $F[x]$ 中多项式，这也给出了两种不可约分解（由高斯引理在 $R[x]$ 中不可约的元素在 $F[x]$ 中也不可约），进而它们在 $F[x]$ 中在不考虑顺序和相伴的意义下唯一。不妨设它们顺序相同，进而：
                        $
                        p_i (x) = k_i q_i (x), k_i in F
                        $
                    通分一下即得：
                        $
                        a p_i (x) = b q_i (x), a, b in R
                        $
                    - 由于 $p_i (x), q_i (x)$ 在 $R[x]$ 中不可约，因此系数的最大公因子是 $1$。从而左右两端系数的最大公因子分别为 $a, b$，这表明 $a ~ b$ 或者 $a = u b$。
                    - 进而：
                        $
                        a p_i (x) = b q_i (x) => u b p_i (x) = b q_i (x) => q_i (x) = u p_i (x)
                        $
                + 消去这些元素，两侧都剩下一些 $R$ 中的不可约元。由 $R$ 中的分解唯一性，这些 $R$ 中的不可约元当然在不考虑顺序和相伴的意义下唯一。

                这就证明了唯一性。

            ]
            注：类似的性质对于欧几里得整环，主理想整环都不对，例如 $ZZ[x]$ 不是主理想整环，但却是唯一分解整环。

            由上面的定理，如何判断多项式是否可约便成为重要的话题。由于高斯引理，我们不妨只考虑域系数的多项式。\
            #lemma[][
                设 $f(x)$ 是 $F[x]$ 中二次或三次多项式，则 $f(x)$ 可约当且仅当它可约。
            ]
            #proof[
                由于有根当且仅当可以分解出一次多项式，而二次或三次多项式若可约一定有一次因式，故结论显然。
            ]
            #lemma[][
                设整系数多项式 $f(x) = sum_(i = 0)^n a_i x^i$ 有有理根 $p/q$，其中 $p, q$ 互素，则 $p | a_0, q | a_n$
            ]
            #theorem[爱森斯坦判别法 Eisenstein's criterion][
                设 $R$ 是整环，$f(x) = sum_(i = 0)^n a_i x^i$ 是 $R[x]$ 中的多项式，$a_n != 0$。设存在素理想 $p$ 使得：
                + $a_n in.not p$
                + $a_i in p, i != n$
                + $a_o in.not p^2$
                则多项式不可约。
            ]
            #proof[
                不妨设 $a_n = 1$\
                若 $f(x) = p(x) q(x)$，在整环 $(quotient(R, p))[x]$ 中考虑，由高斯引理我们进而可以在分式域中考虑。取 $pi$ 是 $R[x]$ 到 $quotient(R, p)$ 分式域上多项式的自然同态，发现：
                    $
                    pi(f(x)) = x^n
                    $
                进而 $pi(p(x)) = x^i, pi(q(x)) = x^(n-i)$
                另一方面，$p(x), q(x)$ 应当都是首一（或相伴于首一多项式），因此 $pi(p(x)), pi(q(x))$ 应当不降低次数，故 $i, n-i !=0$。\
                这表明 $p(x), q(x)$ 的常数项 $p_0, q_0 in p$，进而 $p_0 q_0 = a_0 in p^2$，矛盾！
            ]
            #example[][
                $EE_p (x) = (x^p - 1)/(x-1) = x^(p-1) + x^(p-2) + ... + 1$ 是不可约多项式。\
                将 $x$ 替换成 $x - 1$，得到：
                $
                (x-1)^(p-1) + (x-1)^(p-2) + ... + 1
                $
                展开可以验证，它满足爱森斯坦判别法的条件，因此它不可约。\

                这个多项式被称为分圆多项式。
            ]
            #theorem[][
                设 $F$ 是域，$p(x)$ 是 $F[x]$ 中不可约元当且仅当 $quotient(F[x], (p[x]))$ 是域
            ]
            #proof[
                注意到域上的多项式环是主理想整环，其中素理想等价于极大理想，故结论显然成立。
            ]
            #example[][
                在域 $ZZ_3$ 中，注意到：
                $
                p(x) = x^2 + x - 1
                $
                没有根，因此它不可约，进而 $quotient(ZZ_3[x], (p[x]))$ 是域。
            ]
            #lemma[][
                域上多项式的根的数量不超过多项式的次数
            ]
            #corollary[][
                域上有限乘法群是循环群
            ]
            #proof[
                设 $G$ 是域 $F$ 上的有限乘法群。设 $exp(G) = n$，则 $G$ 中存在 $x$ 使得 $ord(x) = n$，进而对群中所有元素，均有：
                $
                x^n = 1
                $
                另一方面，这个多项式至多有 $n$ 个根，因此 $|G| <= n$，这表明 $|G| = n = ord(x)$，进而 $G$ 是循环群。
            ]
            
        === 二次整数环（Quadratic integer ring）
            #definition[二次整数环][
                设 $D$ 是无平方因子的整数，称 $D$ 的二次整数环为：
                $
                OO = cases(
                    ZZ[sqrt(D)] = {x + y sqrt(D) space x, y in ZZ} space "若" D = 2，3 mod 4,
                    ZZ[(1 + sqrt(D))/2] = {(x + y sqrt(D))/2 space x, y in ZZ} space "若" D = 1 mod 4
                )
                $
                并在其上定义自然的共轭，范数 $a overline(a)$（保证其在整数环中）。
            ]
            注：
                - 这里的范数未必是正的，但满足 $N(a b) = N(a) N(b)$
                - 这里的 $N(a)$ 可以理解为 $ZZ[D]$ 实际上是 $ZZ$ 上的二维线性空间，它的 $N$ 就是线性映射：$[x | x -> a x]$ 的行列式
            #lemma[][
                二次整数环中所有的单位元就是范数为 $plus.minus 1$ 的元素
            ]
            #example[Perl 方程][
                设 $D <0, D = 2，3 mod 4$，从而 Perl 方程：
                $
                (x - sqrt(D) y)(x + sqrt(D) y) = plus.minus 1
                $ 
                的解都满足 $N(x + sqrt(D)), N(x - sqrt(D)) = plus.minus 1$，从而它们都是单位\
                换言之， Perl 方程可以仅在 $OO[D]$ 中所有可逆元构成的群上讨论
            ]
            #theorem[][
                对所有二次整数环，是主理想整环当且仅当它是唯一分解整环
            ]
            #proposition[][
                - 对所有 $D < 0$，有且仅有 $9$ 个 $D$ 使得 $OO[D]$ 是唯一分解整环，包括典型的高斯整数环 $OO(-1)$
                - 对 $D > 0$，猜想有无穷多个 $D$ 使得 $OO[D]$ 是唯一分解整环。计算机验证下大约一半的 $D$ 满足这个条件，因此也有更进一步的猜想。
            ]
            #theorem[费尔马定理][
                素数 $p$ 可以写成两个整数的平方和，也即：
                $
                exists a, b: p = a^2 + b^2
                $
                当且仅当 $p = 2$ 或者 $p = 1 mod 4$
            ]
            这是费尔马年代非常不平凡的定理，但用现在的理论来看可以给出很直观的证明，本节后半部分即是该定理的证明。
            #lemma[][
                高斯整数环中，范数为素数的元素都不可约
            ]
            #lemma[][
                高斯整数环中，所有不可约元的范数都是素数或者素数的平方
            ]
            #proof[
                设 $pi$ 是不可约元，我们需要用到：
                $
                ZZ sect (pi)
                $
                是 $ZZ$ 的素理想。事实上，容易建立 $ZZ$ 到 $ZZ[i]$ 之间的同态。之前我们证明了素理想的原像还是素理想，而当 $(pi)$ 拉回 $ZZ$ 时，它的原像当然就是 $ZZ sect (pi)$

                因此，设 $ZZ sect (pi) = (p)$，显然有：
                $
                p = pi a => p^2 = N(p) = N(pi) N(a)
                $
                这自然给出 $N(pi) = p, p^2$
            ]
            #lemma[][
                高斯整数环中，所有不可约元可以分类为：
                - $1 + i$，其范数为 $2$
                - $N(pi) = p^2$，素数 $p$ 满足 $p = 3 mod 4$
                - $x + y i$ 与 $x - y i$，若 $x^2 + y^2 = p$ 为素数，且 $p = 1 mod 4$
            ]
            #proof[
                对任意不可约元 $pi$：
                + 若 $N(pi) = 2$，显然有 $pi = 1 plus.minus i$，它们是相伴的不可约元
                + 对任意素数 $p in ZZ[i]$，注意到要么 $p$ 不可约，要么 $p = a b$，$N(a) = N(b) = p$，这给出 $a, b$ 不可约
                    - 若 $p | N(pi), p = 3 mod 4$。注意到：
                        $
                        a^2 + b^2 = 0, 1, 2 mod 4
                        $
                        这表明不存在 $N(a) = p$ 的元素，因此 $N(pi) = p^2$。另一方面，这也表明 $N(pi) = p^2$ 的元素一定都不可约
                    - 若 $p | N(pi), p = 3 mod 4$，断言此时 $p$ 可约。注意到：
                        + 模 $p$ 的乘法群是循环群，取其生成元 $x$，则 $ord(x) = p - 1$
                        + 考虑 $x^((p-1)/2)$，它的阶为 $2$，显然 $x^((p-1)/2) = minus 1$
                        + 进而，取 $a = x^((p-1)/4)$，我们有：
                            $
                            p | a^2+1 = (a+i)(a-i)
                            $
                        + 若 $p$ 不可约，这将给出：
                            $
                            p | a + i or p | a - i
                            $
                            由整除的定义，这是荒谬的
                        这就证明了 $p$ 一定可约，设 $p = a b$，注意到 $a overline(a) = a b => b = overline(a)$，且 $N(a) = p$，这表明 $a， overline(a)$ 是一对不可约元
            ]

]
#chapterTwo