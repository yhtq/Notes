#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业5",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
= 10.19
= P58
    20. 
    #answer[
        任取 $x in G$，若 $exists g in G - C_G (z)$，则：
        $
        [x | x -> g x Inv(g)]
        $
        将是不同于平凡自同构的自同构，进而它是唯一的非平凡自同构。\
        这将意味着共轭作用 $Ad_y: [x | x -> y x Inv(y)]$只能为恒等映射或 $[x | x -> g x Inv(g)]$，进而以下两者有且只有一个成立：
        - $Ad_y = I => y in Z(G)$
        - $Ad_y = [x | x -> g x Inv(g)] => forall x: y x Inv(y) = g x Inv(g) => Inv(g)y in Z(G)$
        这表明：
        $
        G = Z(G) union Inv(g) Z(G)
        $
        进而 $exists y in Z(G): x = Inv(g) y =>g x Inv(g) = y Inv(g) = Inv(g) y = x$，矛盾！
    ]
    21.
        #answer[
        显然非交换群至少有两个自同构，恒等映射和某个共轭作用。\
        从而可设 $G$ 是交换群。\
        - 若 $G$ 中所有元素阶均为二，显然至少有两个二阶元素 $x, y$，从而 $generatedBy(x\, y) tilde.eq ZZ_2 times ZZ_2$，后者有非平凡自同构。又结合 $generatedBy(x\, y)$ 是正规子群，考虑商结构容易得到 $G$ 的非平凡自同构。
        - 若 $G$ 中存在阶大于 $2$ 的元素 $x$，记 $ord(x) = m$。显然 $generatedBy(x) tilde.eq ZZ_m$，后者显然有非平凡自同构，类似可证明原结论。
        ]
= P64
    1. 
        #answer[
            考虑 $G$ 在 $G : H$ 上的作用：
            $
            g -> [x H | x H ->(g x) H]
            $
            显然它自然诱导出 $G -> S_n$ 的同态 $phi$，从而由第一同构定理：
            $
            quotient(G, ker phi) tilde.eq im(phi) <= S_n
            $
            另一方面，不难发现：
            $
            ker(phi) <= H(phi(g) = I => phi(g)H = H => g H = H)\
            normalSub(ker(phi), G)
            $
            另一方面，有：
            $
            |G : ker(phi)| = |quotient(G, ker phi)| = |im(phi)| | n!
            $
            从而要么 $ker(phi) = {1} => |G| | n!$，要么 $ker(phi)$ 是非平凡正规子群。
        ]
    7.
        #answer[
            设 $h in H, k in K$，注意到：
            $
            Inv(k) (h k Inv(h)) in Inv(k) K = K\
            (Inv(k) h k) Inv(h) in H Inv(h) = H
            $
            这表明：
            $
            Inv(k) h k Inv(h) in H sect K = {1} => h k Inv(h) = k => h k = k h
            $
        ]
= 补充题
    1. 
    #proof[
        #set enum(numbering: "(1)")
        + 显然 $M_1 subset M_2 => quotient(M_1, N) subset quotient(M_2, N)$\
            另一方面，设 $quotient(M_1, N) subset quotient(M_2, N)$，则对 $m_1 N in quotient(M_1, N) subset quotient(M_2, N) => m_1 N = m_2 N$\
            进而 $m_1 Inv(m_2) in N <= M_2 => m_1 in M_2$，证毕。
        + 断言 $M_2 = union_(m_i) m_i M_1$ 是左陪集分解当且仅当 $quotient(M_2, N) = union_(m_i) (m_i N) quotient(M_1, N)$也是陪集分解，这是因为：
            $
            (m_i N) quotient(M_1, N) = (m_j N) quotient(M_1, N) \
            <=> m_i Inv(m_j) N in quotient(M_1, N) <=> m_i Inv(m_j) in M_1 <=> m_i M_1 = m_j M_1
            $
            这表明其中一个是无交并当且仅当另一个也是。\
            这足以说明两者同时为陪集分解。事实上，假设 $M_2 = union_(m_i) m_i M_1$ 是左陪集分解，那么
            $union_(m_i) (m_i N) quotient(M_1, N) subset quotient(M_2, N)$ （运用结论 1）且是无交并，这就给出 $|overline(M_2) : overline(M_1)| >= |M_2 : M_1|$\
            反之同理，因此 $|overline(M_2) : overline(M_1)| = |M_2 : M_1|$，且上面给出的两者同时为陪集分解。
        + 注意到（由性质 1）：
            - $M_1, M_2 <= generatedBy(M_1\,M_2) => overline(M_1), overline(M_2) <= overline(generatedBy(M_1\,M_2))$
            - $overline(M_1), overline(M_2) <= generatedBy(overline(M_1)\, overline(M_2)) => M_1, M_2 <= Inv(pi)(generatedBy(overline(M_1)\, overline(M_2)))$ 
            结合生成子集的定义，便有：
            $
            generatedBy(overline(M_1)\, overline(M_2)) <= overline(generatedBy(M_1\,M_2))\
            generatedBy(M_1\,M_2) <= Inv(pi)(generatedBy(overline(M_1)\, overline(M_2))) => overline(generatedBy(M_1\,M_2)) <= generatedBy(overline(M_1)\, overline(M_2)) 
            $
            这就证明了原命题。
        + 类似上一命题可以证明
        + 对 $g in G$，断言：
            $
            g M Inv(g) = M <=> (g H) (quotient(M, H)) (Inv(g) H) = quotient( (g M Inv(g)), H) = quotient(M, H)
            $
            注意到性质 1 蕴含了 $M_1 = M_2 <=> quotient(M_1, H) = quotient(M_2, H)$，因此以上结论是显然的。\
            此性质足以说明 $normalSub(M, G) <=> normalSub(overline(M), overline(G))$，后半句性质就是第三同构定理。 
    ]
    2. 
        #answer[
            设 $normalSub(M, G), |M| = n$。\
            注意到我们有：
            $
            |M N| | |M| |N| = n^2\
            M N <= G => |M N| | |G| = m n
            $
            以上两式结合 $gcd(m, n) = 1$，立得：
            $
            |M N| = n => M N = N => M subset N => M = N
            $
            证毕
        ]
    3. 
        #answer[
            对 $forall g in G$，注意到：
            $
            sigma(g N Inv(g)) = sigma(g) sigma(N) Inv(sigma(g)) = sigma(g) Inv(sigma(g)) sigma(N) = sigma(N)
            $
            这表明 $g N Inv(g) subset N ker(sigma) = N$\
            由 $g$ 的任意性知 $Inv(g) N g subset N$，也即 $N subset g N Inv(g)$，进而 $g N Inv(g) = N$，这就证明了原命题。
        ]
    4. 由 $G$ 是单群知 $ker(phi) = {1}\/G$，进而有第一同构定理：
    $
    G tilde.eq H
    $
    或
    $
    quotient(G, G) tilde.eq {1} tilde.eq H
    $
    5. 与 P64 1 重复
    6. 
        #answer[
            设 $G$ 是 $p-$群，$P = {G"的所有子群"}$。
            //#lemma[][
            //    $p | |P| - 1$
            //]
            //#proof[
            //    考虑 $G$ 在 $P$ 上的左平移作用：
            //    $
            //    g -> [H <= G | H -> g H]
            //    $
            //    注意到：
            //    $
            //    Stab_G (H) = {g | g H = H} = H
            //    $
            //    进而在所有轨道对应的 $G:Stab_G (H)$ 中，有且仅有 $G$ 一个使得：
            //    $
            //    |G:Stab_G (H)| = 1
            //    $
            //    其他项均有： 
            //    $
            //    p | |G:Stab_G (H)|
            //    $
            //    从而由：
            //    $
            //    |P| = sum_H |G : Stab_G (H)|
            //    $
            //    立得原结论
            //]
            考虑 $G$ 在 $P$ 上的共轭作用：
            $
            g -> [H <= G | H -> g H Inv(g)]
            $
            注意到：
            $
            G = Stab_G (H) <=> forall g in G: g H Inv(g) = H <=> H "是正规子群"
            $
            同样在：
            $
            |P| = sum_(H in I) |G : Stab_G (H)|
            $
            中，设正规子群的个数为 $m$，将有：
            $
            |P| = m + sum_(H in I "不是正规子群") |G : Stab_G (H)|
            $
            从而将有：
            $
            p | |P| - m
            $
            这就给出了原命题
        ]
    7.
        #answer[
            由 $G$ 在自身的左平移作用，自然导出 $G -> S_(2n)$ 的群同态 $phi$
            - 注意到：
            $
            phi(g) = I <=> forall x in G: g x = x <=> g = 1
            $
                表明 $phi$ 是单同态
            - 记 $"sgn" : S_(2n) -> {-1, 1}$ 表示置换的奇偶性，将有：
            $
            pi := "sgn" compose  phi: G -> {-1, 1}
            $
            显然 $normalSub(ker("sgn" compose  phi), G)$。\
            + 若 $im(phi)$ 中有奇置换 $phi(x)$：
                断言：
                $
                f := [g in Inv(pi)(1) | g -> x g]\
                g := [g in Inv(pi)(-1) | g -> Inv(x) g]\
                $
                是 $Inv(pi)(1) <-> Inv(pi)(-1)$ 的一一映射。\
                - 容易发现 $f compose g = I, g compose f = I$，从而结论是成立的。

                这就说明 $|Inv(pi)(-1)| = |Inv(pi)(1)| = (2n)/2 = n$，从而本题结论成立
            + 我们证明 $im(phi)$ 中必有奇置换。事实上，取 $x$ 为 $G$ 中的二阶元，显然它是若干不相交对换的乘积，又注意到：
                $
                phi(x) = [g in G | g -> x g] 
                $
                在 $G$ 中没有不动点，因此 $phi(x)$ 将由 $n$ 个不相交对换构成，从而是奇置换。
        ]
    8.
        (1). #answer[
            - 注意到若 $x, y, x y in I$，则 $alpha(x y) = Inv((x y)) = Inv(x) Inv(y) => x y = y x$
            - 对任意 $x in I$，对 $y_i in I$，考虑共计 $|I|$ 个 $x y_i$：\
                由于 $|G| - |I| < 1/4 |G|, |I| - (|G| - |I|) > 1/2 |G|$，进而可以断言 $x$ 至少与 $1/2 |G| + 1$ 个元素可交换
            - 上式意味着 $|C_G (x)| >= 1/2 |G| + 1$，由拉格朗日定理，这给出 $C_G (x) = |G|$
            - 这就证明了 $I subset Z(G) => |Z(G)| > 3/4 |G| => Z(G) = G$
        (2). #answer[
            仿照上式证明，我们有 $|C_G (x)| >= 1/2 |G|$
            - 若 $exists x : |C_G (x)| = 1/2 |G|$
                此时 $C_G (x)$ 是指数为 2 的子群，自然成为正规子群。\
                只需证明 $C_G (x)$ 交换，在上面的证明中取等当且仅当恰有 $1/2 |G|$ 个元素在 $x I sect I$ 中，且这些元素都与 $x$ 可交换，进而 $C_G (x) = x I sect I$。

                另一方面，$C_G (x)$ 是子群，自然对乘法封闭。这意味着：
                $
                forall y_1, y_2 in C_G(x) subset I: y_1 y_2 in C_G (x) subset I
                $
                进而 $y_1, y_2, y_1 y_2 in I$，足以说明 $y_1, y_2$ 可交换
            - 反之，若对所有 $x in I$ 均有 $|C_G (x)| >= 1/2 |G| + 1$，按照上式证明将有 $G$ 交换，此时 $I$ 将成为 $G$ 的子群，与拉格朗日定理矛盾！
        ]
        ]
= 10.23
= P27
    44.
        #answer[
            - 对任意 $(a, b) in Z(A) times Z(B)$，显有 $(a, b)$ 与 $A times B$ 中任意元素可交换，因此 $Z(A) times Z(B) subset Z(A times B)$
            - 对任意 $(a, b) in Z(A times B)$，取 $pi$ 是投影同态，显然有 $pi((a, b)) in Z(pi(A times B))$，继而可得 $Z(A times B) subset Z(A) times Z(B)$ 
        ]
    45. 与之前作业重复了
= P57 
    9. 
        #answer[
            在 $Z_3 times Z_9 times Z_9 times Z_(3 times 9 times 9)$ 中：

            + 注意到 $ord((a, b, c, d)) = 9 <=> "lcm"(ord(a), ord(b), ord(c), ord(d)) = 9$，分别考虑 $(ord(a), ord(b), ord(c), ord(d)) = *$ 的元素个数：
                - 显然 $"lcm"(ord(a), ord(b), ord(c), ord(d)) | 9$ 的元素共有 $3 dot 9 dot 9 dot 9$ 个，而 $"lcm"(ord(a), ord(b), ord(c), ord(d)) | 6$ 的元素共有 $3^4$ 个，因此九阶元素恰有：
                $
                3 dot 9^3 - 3^4
                $
                注意到每个 $9$ 阶循环群中共有 $6$ 个 $9$ 阶元素，每两个 $9$ 阶循环群中不会有相同的 $9$ 阶元素，因此 $9$ 阶循环群共有：
                $
                (3 dot 9^3 - 3^4) / 6 = 351
                $
                个
            + 注意到 $9$ 阶非循环群只有 $ZZ_3 times ZZ_3$，因此我们只需找到两个不相关（相乘不为 $1$）的三阶元素即可确定一个 $9$ 阶非循环群
                - $3$ 阶元素共有：
                    $
                        3^4 - 1 = 80
                    $
                - 选出两个的选法为：
                    $
                        C_80^2 = 40 dot 79
                    $
                - 选到相关的三阶元素的个数为：（$x, x^2$ 构成一个相关选法）
                    $
                        80/2=40
                    $
                - 在 $ZZ_3 times ZZ_3$ 中，除 $1$ 外所有元素都是 $3$ 阶元素，每两个不相关元素都可唯一确定一个子群，因此每个子群可由：
                    $
                    C_8^2 - 4 = 24
                    $
                种选法确定
                - 综上，总非循环子群个数为：
                    $
                    (40 dot 79 - 40)/24 = 130
                    $

        ]
    22.
        #answer[
            在 $ZZ_2 times ZZ_2$ 中，除 $e$ 外的三个二阶元素地位是完全相同的，任意调换其中元素仍为 $ZZ_2 times ZZ_2$。因此 $Aut(ZZ_2 times ZZ_2)$ 就是三个二阶元素的全置换，自然有 $Aut(ZZ_2 times ZZ_2) tilde.eq S_3$
        ]
= 补充题
    1.
        #answer[
            - 设 $x$ 是 $G_1 times G_2$ 的生成元，易知 $pi_A (x), pi_B (x)$ 分别是 $G_1, G_2$ 的生成元，这就表明两者都是循环群。\
            - 注意到：
                $
                |G_1| |G_2| = ord(x) = ord((a, b)) = "lcm"(ord(a), ord(b)) = "lcm"(|G_1|, |G_2|)
                $
                这表明 $|G_1|, |G_2|$ 互素

        ]
    2.
        #answer[
            不妨设 $G_1$ 是无限循环群。任取 $x = (a, b) in G_1 times G_2, a, b != e$，注意到：
                $
                    (a, b^2) in.not generatedBy(x)
                $ 
            否则 $a^k = a, k!=1$ 或 $b^2 = b, b = 1$，无论哪个都将导致矛盾\
            上式足以说明这样的 $x$ 不能为生成元，而显然生成元（若有）的分量不能为 $e$，因此 $G_1 times G_2$ 不是循环群
        ]
    3.
        #answer[
            注意到 $G_1 times G_2$ 中任意元素可被写作 $g_1 g_2$，其中 $g_1 in G_1 times {1}, g_2 in {1} times G_2$。\
            - (1):
                $
                    g_1 g_2 N_1 times N_2 Inv(g_2) Inv(g_1)\
                    = pi_A (g_1 g_2 N_1 times N_2 Inv(g_2) Inv(g_1)) times pi_B (g_1 g_2 N_1 times N_2 Inv(g_2) Inv(g_1))\
                    = (g_1 N_1 Inv(g_1)) times (g_2 N_2 Inv(g_2))\
                    = N_1 times N_2\
                $
            - (2):构造映射 $phi$：
                $
                    G_1 times G_2 -> quotient(G_1, N_1) times quotient(G_2, N_2)\
                    x  -> (pi_1 compose pi_A (x), pi_2 compose pi_B (x))) : 
                $
                其中 $pi_1, pi_2$ 分别是 $G_1 -> quotient(G_1, N_1)$, $G_2 -> quotient(G_2, N_2)$ 的自然同态。\
                不难验证 $ker(phi) = N_1 times N_2$，因此由第一同构定理结论成立
        ]
    4.
        #answer[
            + 注意到 $K sect L subset K sect (H L) = {e}$，从而由熟知定理知 $K L tilde.eq K times L$
            +  $normalSub(K L, H K L)$

                注意到 $K, L$ 元素之间可换，从而：
                $
                h k l K L Inv(l) Inv(k) Inv(h) = h k K L Inv(k) Inv(h) = h K L Inv(h) = K L
                $
            + 又结合 $H sect (K L) = {e}$，我们有：
                $
                H (K L) tilde.eq H times (K L) tilde.eq H times (K times L) tilde.eq  H times K times L
                $
        ]
    5.
        #answer[
            显有 $H sect L = {e}$，由熟知定理知：
            $
            G tilde.eq H times K
            $
            且 $H times K$ 的每一个子群都形如 $H_1 times K_1$\
            对任意 $G$ 的子群 $L$，将 $L$ 映射到 $H times K$ 之后设其形式为 $H_1 times K_1$，显然有：
            $
            H_1 = H sect L, K_1 = K sect L\
            L = H_1 K_1 = (H sect L) (K sect L)
            $
        ]
    6.
        #answer[
            任取 $a in H, b in K, a, b != e$\
            由题设知 $generatedBy((a, b))$ 形如 $H_1 times K_1$，并且易得 $H_1 = generatedBy(a), K_1 = generatedBy(b)$，进而 $generatedBy((a, b)) = generatedBy(a) times generatedBy(b)$\
            这就意味着：
            $
                exists k != 1: (a, b)^k = (a^k, b^k) = (a, e)
            $
            这表明 $ord(a) | k-1, ord(b) | k$\
            由 $gcd(k-1, k) = 1$，这就给出了全部结论。
        ]
    7.
        只需证明：
        $
            ZZ_2 times (ZZ_n times.r ZZ_2) tilde.eq (ZZ_2 times ZZ_n) times.r ZZ_2 tilde.eq ZZ_(2n) times.r ZZ_2
        $
        其中两个半直积均由 $phi_(-1) (x) = Inv(x)$ 给出\
        后一个同构由 $n$ 是奇数容易得到，只需证明前者。\
        事实上，两者的元素均形如 $(a, b, c)$，前者的乘法法则为：
        $
        (a_1, b_1, c_1)(a_2, b_2, c_2) = (a_1 a_2, b_1 phi_(c_1) (b_2), c_1 c_2)
        $
        后者则为：
        $
        (a_1, b_1, c_1)(a_2, b_2, c_2) = ((a_1, b_1)phi_(c_1) (a_2, b_2), c_1 c_2) = (a_1 phi_(c_1) (a_2), b_1 phi_(c_1) (b_2), c_1 c_2)
        $
        由于 $ZZ_2$ 中所有元素均有 $Inv(x) = x$，因此 $phi_(-1) (a_2) = a_2$，这就验证了两者确实同构。