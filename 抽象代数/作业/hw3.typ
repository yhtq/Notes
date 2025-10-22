#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业3",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
#set heading(outlined: false)
= 9.25
（上周没有注意到我们周四要交周一的作业，这里补上）
== P24
6. 
    设 $a, b$ 是两个不同的二阶元素，从而 $Inv(a) = a, Inv(b) = b$，显有：
    $
    (a b a)^2 = a b a a b a = e
    $
    - 若 $a b a$ 不为 $a, b$ 中一个，则已证毕
    - 若 $a b a = a => a b = e => a = b$ 矛盾
    - 若 $a b a = b => (a b)^2 = e$，此时 $a b$ 为另一个不同于 $a, b$（显然）的二阶元素
7. 
    $
    &(a b)^2 = a^2 b^2\ 
    <=>& a(a b)b=a(b a)b\
    <=>& a b = b a
    $
    从而结论显然。

    若 $exp(G) = 2$，则恒有 $(a b)^2 = a^2 b^2 = e$，从而有 $G$ 交换

11.  
    若 $tilde$ 是等价关系：
    $a, b in S => a tilde e, b tilde e => a tilde e, e tilde b => a tilde b => a Inv(b)$\
    由熟知结论显有 $S$ 是子群；
    若 $S$ 是子群：
    - 自反性：$e in S => a Inv(a) in S => a tilde a$
    - 传递性：$a tilde b, b tilde c => a Inv(b) in S, b Inv(c) in S => a Inv(c) in S => a tilde c$
    - 对称性：$a tilde b => a Inv(b) in S => Inv((a Inv(b))) in S=> b Inv(a) in S => b tilde a$
    从而确实是等价关系

14.
    记 $e = (1), a = (12)(34), b = (13)(24). c = (14)(23)$，则：
    $
    a^2 = b^2 = c^2 = e\
    a b = (12)(34)(13)(24) = (23)(14) = c\
    b a = (13)(24)(12)(34) = (14)(23) = c\
    a c = (12)(34)(14)(23) = (13)(24) = b\
    c a = (14)(23)(12)(34) = (13)(24) = b\
    b c = (13)(24)(14)(23) = (12)(34) = a\
    c b = (14)(23)(13)(24) = (12)(34) = a\
    $
    以上事实足以给出题设集合是 $S_4$ 的子群。

    容易发现四次单位根群是循环群，但本群不是，从而不同构。
15. 
    注意到：
    $
    B^n = I \
    A^2 = I\
    B A = mat(0, e^((2 pi) / n);e^((-2 pi) / n), 0)\
    A (B A) = mat(0, 1;1, 0) mat(0, e^((2 pi) / n);e^((-2 pi) / n), 0) = mat(e^((-2 pi) / n), 0;0,e^((2 pi) / n)) = B^(n-1) => B A = A B^(n-1)\ 
    $
    以上事实足以给出所有 $A, B$ 及它们的逆所生成的元素恰为题设集合。\
    事实上，$D_(2n)$也是由满足以下关系的两个元素 $r, s$：
    $
    r^n = s^2 = e\
    r s = s r^(n-1)\
    $
    所生成（$r, s$ 分别对应旋转 $(2 pi)/n$ 度和对称）。从而构造映射 $phi$ 使得：
    $
    phi(A) = s\
    phi(B^i) = r^i\
    phi(A B^i) = s r^i \
    $
    容易验证它是同构

== P25
18. 
    设 $ord(a b) = m, ord(b a) = n$，注意到：
    $
    e = (a b)^m = a (b a)^(m-1)b => Inv(a) Inv(b) = (b a)^(m-1) => b a = (b a)^(m-1) => (b a)^m = e => m | n\
    $
    另一侧同理，因此 $m = n$。
19. 
    $
    a = mat(0, -1;1, 0)\
    a^2 = mat(-1, 0;0, -1) = -I => ord(a) = 4
    $
    $
    b = mat(0, 1;-1, -1)\
    b^2 = mat(-1, -1;1, 0)\
    b^3 = mat(1, 0;0, 1) = I => ord(b) = 3
    $
    $
    a b = mat(1, 1;0, 1) = (I + J_2)\
    (a b)^n = (I + J_2)^n = I + n J_2 => ord(a b) = oo
    $
20.
    设 $G$ 中所有有限阶元素构成集合 $H$：
    - $a in H => ord(a) = ord(Inv(a))< inf => Inv(a) in H$
    - $a, b in H => (a b)^(ord(a) ord(b)) = a^(ord(a) ord(b)) b^(ord(a) ord(b)) = e => ord(a b) < inf => a b in H$
    从而 $H$ 是子群。\
21. 
    如若不然，设无限群 $G$ 只有有限个子群 $H_1, H_2, ..., H_n$。显然 $G$ 中不应有无限阶元素，否则它对应的循环群已有无穷个子群。考虑其中所有循环子群（这些子群都是有限群）之间的偏序关系：
    $
    H_i <= H_j <=> H_i subset H_j  \
    $
    显然此偏序关系存在唯一最小元 ${e}$。\
    取该偏序关系下所有极大元构成集合 $A$ （由于 $G$ 不是循环群，故 $G in.not A$），显有：
    $
    H_i in A <=> (H_i "是循环群") and (H_i < H_j => H_j "不是循环群")
    $ 
    我们断言对任意 $a in G$，均存在 $S in A$ 使得 $generatedBy(a) subset S$。这是因为$generatedBy(a)$ 是循环群，它在一些有限长的链上，从而取某条链上的极大元即可。\
    事实上，上述事实蕴含了 $union A = G$ ，但有限个有限集合的并一定是有限集合，这就与 $G$ 无限矛盾了。\
== P27
43. 
    设 $H$ 是 $A_4$ 的六阶子群。

    显然 $H$ 中元素的阶只能为 $1, 2, 3, 6$。由前习题结论其中必有 $2$ 阶元素，而 $A_4$ 中 $2$ 阶元素只有 $3$ 个；另一方面，$A_4$ 中无 $6$ 阶元素，因此 $H$ 中也必有三阶元素。\
    显然三阶元素与它们的逆成对出现。因此 $2, 3$ 阶元素的数量必为 $(1, 4)$ 或 $(3, 2)$。\
    - $2, 3$ 阶元素的数量为 $(1, 4)$，此时不妨设$(i_1i_2i_3), (i_1i_2i_4) in H$（显然四个元素中选出三个的两种选法恰由两个数重复，每种选法的所有排列只对应两个互逆的轮换，应当都在 $H$ 中），而：
        $
        (i_1i_2i_3)(i_1i_2i_4) = (i_4i_1i_3) in H\
        $
    这是另一个 $3$ 阶元素，矛盾。
    - $2, 3$ 阶元素的数量为 $(3, 2)$，此时所有二阶元素均在 $H$ 中。不妨设 $(123) in H$，而：
        $
            (123)(12)(34) = (341) in H\
        $
        这是另一个 $3$ 阶元素，矛盾。
    综上，$A_4$ 中不存在 $6$ 阶子群。
== P57
1. 
    由裴蜀定理知存在 $u, v$ 使得：
    $
    u r+v s = 1
    $
    并且 $gcd(u, s) = 1, gcd(v, r) = 1$

    从而取 $a = g ^ (u r), b = g^ (v b)$，显有：
    $
    a b = g ^ (u r + v s) = g
    $
    且：
    $
    ord(a) = ord(g^(u r)) = (r s) / gcd(r s, u r) = r / gcd(s, u) = s\
    ord(b) = r "（同理可得）"
    $

3. 
    设 $G = generatedBy(n_1/m_1\, n_2/m_2\, ... \, n_k/m_k)$。事实上，不妨设 $m_1 = m_2 = ... = m_k = m$ （取公分母即可），从而 $G = generatedBy(n_1/m\, n_2/m\, ... \, n_k/m)$，进而其中元素都形如 $n/m$。\
    定义：
    $
    funcDef(phi, G, ZZ_m, n/m, n)
    $
    容易验证它是单同态，从而 $G tilde.eq im(phi) <= ZZ_m$，而 $ZZ_m$ 的子群都是循环群，从而 $G$ 也是循环群。

6.
    必要性是显然的，只证明充分性。\
    定义：
    $
    funcDef(phi, G, ZZ^+, a, min_(k in ZZ^+, k>=0) {G^k = generatedBy(a)})
    $

    
    - 显然若 $a$ 是有限阶元素，则有 $G^(phi(a)) = generatedBy(a)$ 知所有元素都是有限阶元素，从而 $exp(G)$ 有限。先证明这种情况：

        #lemma[][$exp(G) | phi(a) dot ord(a), space forall a in G$
        ]
        #proof[
            由题意，对任意 $g in G$，有：
            $
            g^phi(a) in generatedBy(a)
            $
            从而：
            $
            e = (g^phi(a))^exp(generatedBy(a)) = (g^phi(a))^ord(a) = g^(phi(a) dot ord(a))
            $
            这就说明了原命题。
        ]
        #lemma[][
            若 $gcd(ord(a), phi(a)) = 1$，且 $G^i subset G^phi(a) = generatedBy(a)$。则 $G^(gcd(i, phi(a))) = generatedBy(a)$。进一步的，有 $phi(a) | i$
        ]
        #proof[
            设 $d = gcd(i, phi(a))$，利用裴蜀定理，设 $u i + v phi(a) = d$。对 $forall g in G$，将有 $g^i = a^s, g^(phi(a)) = a^ t$。从而：
            $
            g^d = g^(u i + v phi(a)) = (g^i)^u (g^(phi(a)))^v = a^(s u + t v) in generatedBy(a)
            $
            这说明 $G^d subset generatedBy(a)$。
            
            另一方面，由于：
            $
            gcd(d, ord(a)) = gcd(gcd(phi(a), i), ord(a)) = 1
            $ 
            从而：
            $
            generatedBy(a) = generatedBy(a^d) subset G^d$
            ，可得 $G^d = generatedBy(a)$。

            又由定义知 $phi(a) <= d$，从而 $d = phi(a) => phi(a) | i$
        ]
        #corollary[][
            若 $gcd(ord(a), phi(a)) = 1$，则 $exp(G) = phi(a) ord(a)$
        ]
        #proof[
            在引理 2 中取 $i = exp(G)$，可得 $phi(a) | exp(G)$，进而 $ord(a) phi(a) | exp(G)$。又由引理 1 知 $exp(G) = phi(a) ord(a)$
        ]
        #corollary[][
            若 $gcd(ord(a), phi(a)) = 1$，且 $ord(b) | ord(a)$，则$generatedBy(x) <= generatedBy(a) <=> x in generatedBy(a)$
        ]
        #proof[
            由：
            $
            phi(a)ord(a) = exp(G) | phi(x) ord(x) | phi(x) ord(a)
            $ 知 $phi(a) | phi(x)$，进而：
            $
            generatedBy(x) = G^phi(x) <= G^phi(a) = generatedBy(a)
            $
        ]

        取 $G$ 中阶最大元素 $a$，并取 $g^(phi(a)) = a$，则：
        $
        ord(g) >= ord(g^(phi(a))) >= ord(g)
        $
        因此 $ord(g) = ord(g^(phi(a)))$，进而 $gcd(ord(g) = ord(a), phi(a)) = 1$。\
        由于 $g$ 也是最大阶元素，同样可得 $gcd(ord(g) , phi(g)) = 1$。\
        从而 $a, g$ 都满足引理 1,2,3 条件，易得 $generatedBy(a) = generatedBy(g)$。

        我们的目标的是证明 $phi(a) = 1$。\
        如若不然，设素数 $p$ 满足 $p | phi(a)$，显然 $p divides.not ord(a)$。
        #let p = $p$

        记 $R = union_(k=1)^(p-1) G^ (k phi(a) ord(a)/#p)$

        由于 $exp(G) > phi(a) ord(a)/#p$，故 $R != {e}$。显然其中任意非平凡元素均有 $ord(x) = p$

        #proposition[][$forall x in R, ord(a x) = p ord(a)$]
        #proof[
            + $R inter generatedBy(a) = {e}$

                这是因为设 $g in R inter generatedBy(a)$，将有：
                $
                ord(g) divides #p, ord(g) divides ord(a) \
                => ord(g) divides gcd(#p, ord(a)) = 1 => ord(g) = 1 => g = e
                $
            + $forall y in G, ord(y) = p => y in R$

                事实上：
                $
                phi(a)ord(a) | phi(y)ord(y) = p phi(y) => phi(a)/p ord(a) | phi(y)
                $
                因此 $phi(y) = k phi(a)/p ord(a) (1<= k < p)=> y in R$
            + $R$ 中任意两元素可交换。    

                事实上，设 $x, y in R$，设 $phi(x) = k_1 phi(a)/p ord(a)，phi(y) = k_2 phi(a)/p ord(a)$。
                
                取 $g in G^(phi(a)/p ord(a)), g != e$，有：
                $
                    ord(g) = p => g^(k_1) != e, g^(k_2) != e
                $
                由于 $g^(k_1) in generatedBy(x), g^(k_2) in generatedBy(y)$，设：
                $
                    g^(k_1) = x^i, g^(k_2) = y^j
                $
                由于 $x^i, y^j$ 都是生成元，而它们可交换，因此 $generatedBy(x),  generatedBy(y)$ 都可交换，进而 $x, y$ 可交换。
            + $R$ 是群
                $
                    a, b in R => (a b)^p = a^p b^p = e "（交换性）"=> ord(a b) | p => a b in R\
                    ord(Inv(a)) = ord(a) = p => Inv(a) in R
                $
            + $forall c in R, d in generatedBy(a)$，有：
                $
                    c d Inv(c) in generatedBy(a)\
                    d c Inv(d) in R
                $
                这是因为 
                $
                ord(c d Inv(c)) = ord(d) | ord(a)\ 
                ord(d c Inv(d)) = ord(c) = p 
                $
                由引理 2 和前述结论知 $c d Inv(c) in generatedBy(a), d c Inv(d) in R$
            + $forall c in R, d in generatedBy(a) : c d = d c$

                注意到：（运用乘法封闭性和正规性）
                $
                c d Inv(c) Inv(d) = (c d Inv(c)) Inv(d) in generatedBy(a)\
                c d Inv(c) Inv(d) = c (d Inv(c) Inv(d)) in R 
                $
                从而：
                $
                    c d Inv(c) Inv(d) in inter generatedBy(a) R => c d Inv(c) Inv(d) = e => c d = d c
                $
            + $forall x in R, ord(a x) = p ord(a)$

                由于 $a x$ 可交换，$gcd(ord(a), ord(x)) = 1$，根据熟知定理：
                $
                ord(a x) = p ord(a)
                $
        ]

        显然前述命题与 $ord(a)$ 的最大性矛盾，从而 $phi(a) = 1$，也即 $G = generatedBy(a)$ 是循环群，证毕。
        

                

    - 若 $G$ 中所有元素都是无穷阶

        任取 $G$ 中元素 $a$，并取 $g^phi(a) = a$。\ 
        断言 $phi(g) = 1$，否则再取 $x^phi(g) = g$，则有 $x^(phi(g) phi(a)) = a$。另一方面，由 $x^phi(a) in generatedBy(a)$ 知 $x^phi(a) = a^k = x^(k phi(g) phi(a))$，这与 $x$ 是无限阶元素矛盾，这就说明断言是正确的，也即 $phi(g) = 1$，进而由定义 $G= generatedBy(g)$ 是循环群。

11.
    只需证明所有对换 $(i j)$ 均可由题设两置换生成。记 $sigma = (123...n)$

    //定义：
    //$
    //funcDef(pi_k, A_k, S_n, a + generatedBy(k), (a, a+k, a+2k ...))
    //$
//
    //由于 $(a, a+k, a+2k, ...) = (a+k, a+2k, a+3k, ...)$，故定义是良好的
    //
    //#lemma[][
    //    $sigma^k = product_(H in A_k) pi(H)$
    //]
    //#proof[
    //    首先，由于 $A_k$ 中的子群两两不交，故 ${pi_k (H) | H in A_k}$ 也两两不交，进而可交换，因此$product_(H in A_k) pi_k (H)$ 是合理的。 \
    //    注意到（其中加法是在 $Z_n$ 意义下）：
    //    $
    //    sigma^k (a) = sigma^(k-1) (sigma(a)) = sigma^(k-1) (a+1) = ... = a+k
    //    $
    //    从而 $sigma^k |_(H in A)$ 都是一个轮换，它恰好就是 $pi_k (H)$，因此容易得到 $sigma^k = product_(H in A_k) pi_k (H)$
    //    
    //]
    注意到（其中加法是在 $Z_n$ 意义下）：
        $
        sigma^k (a) = sigma^(k-1) (sigma(a)) = sigma^(k-1) (a+1) = ... = a+k
        $
    从而考虑 $sigma^(i_1) (1) = i, sigma^(i-1)(2) = i+1$，将有：
    $
    sigma^(i-1) (12) Inv((sigma^(i-1))) = (i space i+1)
    $
    进一步 $(i+1 space i+2)(i space i+1)Inv((i space i+2)) = (i space i+2)$，以此类推便可得任意 $(i space j)$ 均可由题设两置换生成，进而 $S_n$ 由题设两置换生成。
    //#lemma[][若 $m$ 有限，则 $ord(a) = ord(b) <=> phi(a) = phi(b)$
    //]
    //#proof[
    //    $arrow.l.double$：显然可得\
    //    $arrow.r.double$：记 $i = phi(a), j= phi(b)$，此时由 $|G^i| = |G^j|$，往证 $G^i = G^j$。
//
    //    
//
    //]
//
    //#lemma[][
    //    任取 $a, b, c in Inv(phi)(k)$，则有 $a (b Inv(c)) in Inv(phi)(k)$
    //]
    //#proof[
    //    
    //]
12. 
    记题设两种偶置换生成的群为 $A, B$，显有 $A, B <= A_n$。为了证明 $A, B$ 可生成 $A_n$，只需证明 $forall i, j, k, s, (i j)(k s) in A, B$。若 $n = 3$，结论是显然的，下设 $n >= 4$
    - 先证明 $A$：

        若假设 $i, j, k, s$ 两两不等，则：
        $
        (12n)^2 = (1n 2)
        (1 j 2)(1 2 i)Inv((1 j 2)) = (j 1 i) = (1 i j) in A\
        (1 s 2)(1 2 k)Inv((1 s 2)) = (s 1 k) = (1 k s) in A\
        (1 k s)(1 i j)Inv((1 k s)) = (k i j) in A
        $ 
        这意味着所有三轮换都在 $A$ 中。因此若 $i, j, k, s$ 有相等数，则 $(i j)(k s)$ 是一个三轮换（或者恒等变换），在 $A$ 中。若它们两两不等在，则：
        $
            (i k j)(i k s) = (i j)(k s) in A
        $
        从而 $A$ 可以生成 $A_n$。
    - 再证明 $B$。注意到：
    $
    (i space i+1 space i+2)(i-1 space i space i+1)Inv((i space i+1 space i+2)) = (i-1 space i+1 space i+2) in B\
    (i-1 space i space i+1)(i-1 space i+1 space i+2)Inv((i-1 space i space i+1)) = (i space i-1 space i+2) \ = (i-1 space i+2 space i)  in B\
    (i-1 space i+2 space i)^2 = (i-1 space i space i+2) in B\
    (i-2 space i-1 space i)^2 = (i-2 space i space i-1) in B\
    (i-2 space i space i-1)(i-1 space i space i+2)Inv((i-2 space i space i-1)) = (i-2 space i-1 space i+2) in B\
    $
    反复进行最后两步，可得 $(12i+2) in B$，从而 $A_n = A <= B <= A_n$，证毕。
== 补充题
    1.
        不妨设二阶群为 ${1, -1}$，$phi$ 为 $S_n -> {1, -1}$ 的一个同态\
        由 $11$ 题过程以及二阶群的交换性可以看出，所有对换应当均与 $(12)$ 有相同的像。
        - $phi((12)) = 1$，此时所有对换的像均为 $1$，从而为平凡同态 $phi(x) = 1$
        - $phi((12)) = -1$，此时所有对换的像均为 $-1$，从而易得 $ker(phi) = A_n$
        显然这就是唯二可能的同态。
    2. 
        将 $sigma$ 分解为互不相交的轮换 $sigma_1 sigma_2 ... sigma_n$，显有：
        $
        e = sigma^p = (sigma_1 sigma_2 ... sigma_n)^p = sigma_1^p sigma_2^p ... sigma_n^p
        $
        显然由于 $sigma_i^p$ 之间互不相交，从而设 $x$ 恰在 $sigma_i$ 中，则有 $sigma^p (x) = sigma_i^p (x)$。易得 $e = sigma_1^p sigma_2^p ... sigma_n^p$ 当且仅当 $forallSa(i, sigma_i^p = e)$，这就表明 $ord(sigma_i) | p => ord(sigma_i) = p$，进而它们都是长度为 $p$ 的轮换。\
= 9.28
1. 
    显然 $ord(g^m) = n$，因此 $generatedBy(g) = generatedBy(g^m) <= H$
2. 
    用归纳法，假设 $m-1$ 时结论成立

    取自然同态：
    $
    funcDef(pi, U(p^m), U(p^(m-1)), a, overline(a))
    $
    由归纳假设，$U(p^(m-1))$ 是循环群，设 $U(p^(m-1)) = generatedBy(overline(a))$，则显有 $p^(m-2)(p-1) | ord(a)$。

    若 $ord(a) = p^(m-1)(p-1)$，则结论已成立。下设 $ord(a) = p^(m-2)(p-1)$。

    另一方面，易得 $|ker(pi)| = p$，从而 $ker(pi)$ 是循环群，设 $ker(pi) = generatedBy(b)$。

    若 $m = 2$，则 $gcd(p^(m-2)(p-1), p) = 1$，从而显有 $ord(a b) = p^(m-1)(p-1)$，下设 $m >= 3$。

    #proposition[][
        $generatedBy(b) times generatedBy(a) tilde.eq U(P^m)$ 
    ]
    #proof[
        + 
            定义：
            $
            funcDef(phi, generatedBy(b) times generatedBy(a), U(P^m), (x\, y), x y)
            $
            由于 $U(P^m)$ 交换，容易验证它是同态。
        + $generatedBy(a) inter generatedBy(b) = {e}$

            由 $pi$ 是满射知 $pi|_(generatedBy(a))$ 是同构，因此：
            $
            {e} = ker(pi|_(generatedBy(a))) = ker(pi) inter generatedBy(a) = generatedBy(a) inter generatedBy(b)
            $
        + $ker(phi) = {e}$，从而 $phi$ 是单射。
            $
            a b = e => a = Inv(b) => a, b in generatedBy(a) inter generatedBy(b) => a = b = e => (a, b) = e
            $
        + $|generatedBy(b) times generatedBy(a)| = |U(P^m)|$，从而结合单射知同构成立
    ]

    由上述事实，立得：
    $
    forall g in U(p^m), exists x in generatedBy(a), y in generatedBy(b), g = x y => g^p = x^p y^p = x^p in generatedBy(a)
    $

    从而：
    $
    (p^m - 1)^p = p^m - 1 in generatedBy(a)\
    (p^(m-2) - 1)^p = - C_p^2 p^(2m-4) + p^(m-1) - 1 = p^(m-1) - 1 in generatedBy(a) \
    "(注意到" p dot p^(2m-4) | C_p^2 p^(2m-4) "且" 2m - 3 >= m ")"
    $

    但 $pi(p^m - 1) = pi(p^(m-1) - 1) = p^(m-1)-1$，这与 $pi$ 是同构矛盾！\
    从而命题 2 之前的假设必有某些不成立，而不论哪个都说明 $U(p^m)$ 是循环群。
3. 
    若 $m | n$，注意到 $G$ 的 $m$ 阶子群存在且唯一，记唯一的 $m$ 阶子群为 $A$，断言 ${x | x^m = e} = A$。

    事实上，$x^m = e => ord(x) | m => generatedBy(x)$ 与 $A$ 的某个子群同阶，这意味着 $generatedBy(x) subset A$，从而 $x in A$。\
    而 $A subset {x | x^m = e}$ 是显然的，这就证明了断言，从而解的数量恰为 $m$

    一般而言，记 $d = gcd(m, n)$，则 $x^d = e$ 的解数为 $d$。由裴蜀定理：
    $
    x^m = e => e = x^(u m + v n) = x^d 
    $
    从而 $x^d = e <=> x^m = e$，进而解的数量为 $d$。
4.
    不妨设 $G = ZZ_m$ 或 $ZZ$，定义：
    $
    funcDef(phi, G, "Hom"(G), a, [x | x -> a x])
    $
    我们断言：
    - $phi$ 是单射

        事实上，若 $phi(a) = phi(b)$，则 $forall x in G, a x = b x$，从而 $a = b$。
    - $phi$ 是满射

        事实上，对于任意 $f in "Hom"(G)$，取 $f(1)$，则 $f(x) = f(1) x$，从而 $f = phi(f(1))$

    - $phi(a) dot phi(b) = phi(a b)$

        对于任意 $x in G$，有：
        $
        (phi(a) dot phi(b)) (x) = a (b x) = a b x = phi(a b) (x)
        $
    
    - $(phi(a) + phi(b))(x) = phi(a + b) (x)$
            
        事实上：
        $
        (phi(a) + phi(b))(x) = a x + b x = (a + b)x = phi(a + b) (x^2)
        $
    
    以上事实说明 $phi$ 是一个环同构，从而 $G$ 上的自同态环与 $ZZ$ 或 $ZZ_(|G|)$ 同构
    
5. 
    取 $r$ 为逆时针旋转 $pi / 2$，$s$ 为沿 $x$ 轴翻转，显然 $r^4 = e, s^2 = e$，且 $s r = r^3 s$，并有：\
    $
    D_4 = generatedBy(r\, s)
    $
    设 $phi$ 是 $D_4$ 上自同构，$D_4$ 中二阶元素分别为：
    $
    s, r s, r^2 s, r^3 s
    $
    （注意到 $(r^k s)^2 = r^k (s r^k s) = r^k (s r s)^k = r^(4 k) = e$）
    $D_4$ 中四阶元素分别为:
    $
    r, r^3
    $
    记：
    $
    r' = [r -> r^3, s -> s]\
    s' = [r -> r, s -> r s]
    $
    便有：
    $
    ord(r') = 2, ord(s') = 4\
    generatedBy(r') inter generatedBy(s') = {e}\
    r' (s')^k = [r -> r^3, s -> r^(3 k) s] \
    s' r' = [r -> r^3, s -> r s] = r' s^3\  
    $
    从而 $Aut(D_4) tilde.eq D_4$ 

6. 
    显然 $ZZ_4$ 与 $ZZ_6$ 的自同构群都是 $ZZ_2$，但它们不同构。

= 10.9
24.
    二阶群中结论平凡，不妨设 $G$ 不是二阶群，从而 $H_1, H_2$ 非平凡。
    设 $H_1, H_2$ 是 $G$ 是两个不同的指数为 $2$ 的子群。\
    有：
    $
    |G : H_1 inter H_2| <= |G:H_1| |G:H_2| = 4
    $
    且 $2 | |G: H_1 inter H_2|$。
    这说明 $|G: H_1 inter H_2| = 2 "或 " 4$ 
    - $|G: H_1 inter H_2| = 2$，又 $H_1 != H_2$，从而 $H_1 inter H_2$ 是异于 $H_1, H_2$ 的二阶子群。
    - $|G: H_1 inter H_2| = 4$

        这将意味着 $H_1 H_2 = G$。从而 $H_1, H_2$ 不可能相互包含。  
        显然 $H_1 union H_2 != G$，否则任取两个非平凡元 $h_1 in H_1, h_2 in H_2$，将有：
        $
        h_1 h_2 in H_1 => h_2 in H_1 => H_2 subset H_1 => H_1 = H_2
        $
        或：
        $
        h_1 h_2 in H_2 => h_1 in H_2 => H_1 subset H_2 => H_1 = H_2
        $
        
        取 $h_1 in H_1 - H_2, h_2 in H_2 - H_1, h_3 in G - H_1 - H_2$\
        我们有（容易验证它们不在同一个陪集）：
        $
        G = (H_1 inter H_2) union h_1 (H_1 inter H_2) union h_2 (H_1 inter H_2) union h_3 (H_1 inter H_2)\
        = (H_1 inter H_2) union (H_1 inter H_2) h_1 union (H_1 inter H_2) h_2 union (H_1 inter H_2) h_3
        $
        
        #proposition[][
            $(H_1 inter H_2) union h_3 (H_1 inter H_2) <= G$ 且其指数为 $2$ 
        ]
        #proof[
            + $h_3 (H_1 inter H_2) = G - H_1 union H_2 = (H_1 inter H_2) h_3$

                注意到:
                $
                (H_1 inter H_2) union (H_1 inter H_2) h_1 union (H_1 inter H_2) h_2 subset H_1 union H_2\
                h_3 (H_1 inter H_2) in.not H_1, H_2 => h_3 (H_1 inter H_2) subset G - H_1 union H_2
                $
                结合上面的陪集分解，结论显然成立（另一侧同理）

            + $e in (H_1 inter H_2) union h_3 (H_1 inter H_2)$ 显然成立
            + $Inv(((H_1 inter H_2) union h_3 (H_1 inter H_2))) = (H_1 inter H_2) union h_3 (H_1 inter H_2)$

                若 $h in (H_1 inter H_2)$，显有 $Inv(h) in (H_1 inter H_2)$\
                若 $h_3 x in h_3 (H_1 inter H_2)$，则： 
                $
                Inv((h_3 x)) = Inv(h_3) Inv(x) in G - H_1 - H_2 => Inv((h_3 x)) in h_3 (H_1 inter H_2)
                $\
            + $h_3^2 in H_1 inter H_2$

                考虑关于 $H_1$ 的陪集分解，将有：
                $
                G = H_1 union h_3 H_1
                $
                若 $h_3^2 in.not H_1 => h_3^2 in h_3 H_1 => h_3 in H_1$，矛盾！

                类似可得 $h_3 in H_2$，从而结论成立。
            + $((H_1 inter H_2) union h_3 (H_1 inter H_2))^2 = (H_1 inter H_2) union h_3 (H_1 inter H_2)$

                设 $x, y, z in H_1 inter H_2$，注意到：
                - $x y in H_1 inter H_2$
                - $x (h_3 y) in.not H_1$，否则 $h_3 in H_1$，同理 $x h_3 y not in H_2$。
                - $x (h_3 y) in G - H_1 - H_2 => x h_3 y in h_3 (H_1 inter H_2)$
                - 同理，$(h_3 x) y in h_3 (H_1 inter H_2)$
                - $(h_3 x)(h_3 y) in H_1 inter H_2$，只需证 $h_3 x h_3 in H_1 inter H_2$，这是因为：
                $
                x h_3 in (H_1 inter H_2) h_3 = h_3 (H_1 inter H_2) => exists z, x h_3 = h_3 z 
                $
                从而：
                $
                h_3 x h_3 = h_3^2 x in H_1 inter H_2
                $
            以上事实足以说明子群关系。\
            由 $|(H_1 inter H_2) union h_3 (H_1 inter H_2)| = 2 |(H_1 inter H_2) union h_3 (H_1 inter H_2)|$ 易得其指数为 $2$
        ]
    上述命题给出异于 $H_1, H_2$ 的二阶子群，证毕。
    
30.

    #corollary[][
        $g(H inter K) = (g H) inter (g K)$
    ]
    #proof[
        + $g(H inter K) subset (g H) inter (g K)$：显然
        + $(g H) inter (g K) subset g(H inter K)$：
        $
        x in (g H) inter (g K) => exists h in H, k in K, x = g h = g k \ => Inv(g) x = h = k in H inter K => x in g(H inter K)
        $
    ]
    由引理，结论是显然的。

31.
    由 30 题结论，每个 $H inter K$ 的陪集都是 $H$ 的陪集与 $K$ 的陪集的交集，从而 $|G : H inter K|$ 不可能超过 $|G : H||G : K|$，证毕。

36.
    注意到必有 $gcd(ord(g), m) = gcd(ord(h), m) = 1$，从而 $g, h$ 分别是 $generatedBy(g), generatedBy(h)$ 的生成元。\
    从而 $g^m = h^m => generatedBy(g^m) = generatedBy(h^m) => generatedBy(g) = generatedBy(h)$。\
    设 $g = h^k$，则有：
    $
    g^m = h^(k m) = h^m => h^(m (k-1)) = e => ord(h) | m(k-1) => ord(h) | (k-1)
    $
    这说明 $g = h^k = h$\
    对于第二个结论，之前已经证明了唯一性，而存在性是由于 $x^m$ 是 $generatedBy(x)$ 的生成元，从而：
    $
    exists k: (x^m)^k = x => (x^k)^m = x
    $

38.

    $
    H a = K b => H = K b Inv(a) := K c\
    e in H => e in K c => Inv(c) in K => c in K => K c = K => H = K
    $
= 补充题
1.

    - $1 compose f(x) = f(x)$
    - $(a b) compose f(x) = f(a b x) = a compose (b compose f(x))$
    从而这确实给出一个群作用。

2. 
    - $1 compose z = z/1 = z$
    - $(A B) compose z = A compose (B compose z)$
    记 $phi(vec(a, b)) = a / b$，注意到：
    $
    phi(A vec(z, k)) = A compose (z / k) = A compose phi(A vec(z, k))\
    (A B) compose z = phi((A B) vec(z, 1)) = phi(A (B vec(z, 1))) = A compose (phi(B vec(z, 1))) = A compose (B compose z) 
    $
    这足以说明 $phi$ 是一个群作用。\
    断言它只有一个轨道，事实上：
    $
    forall z_1 = x_1 + y_1 i, z_2 = x_2 + y_2 i in HH\
    z_1 = x_1 + y_1 Inv(y_2)(z_2 - x_2) 
    $
    略加整理即可找到对应的分式线性变换
3.
    显有：
    $
    R^* = R^+ union (-1) R^+
    $
    容易验证它恰好是陪集分解，从而指数为 $2$
4.
    容易验证：
    $
    x H = {z | |z| = |x|}
    $
    是复平面上过 $z$ 点的圆
5. 
    定义：
    $
    funcDef(phi, H times K, (G -> G), (h, k), [g | g -> h g Inv(k)])
    $
    验证 $phi$ 给出 $H times K$ 在 $G$ 上的一个群作用：
    - $phi(e)(g) = g$
    - 验证结合律：
        $
        phi((h_1, k_1)(h_2, k_2)) = [g | g -> h_1 h_2 g Inv(k_2) Inv(k_1)]\
        phi(h_1, k_1) compose phi(h_2, k_2) = [g | g -> h_1 g Inv(k_1)] compose [g | g -> h_2 g Inv(k_2)] \ = [g | g -> h_1 h_2 g Inv(k_2) Inv(k_1)]
        $
        从而 $phi(h_1, k_1)(phi(h_2, k_2)(g)) = (phi(h_1, k_1) compose phi(h_2, k_2))(g) = phi((h_1, k_1)(h_2, k_2))(g)$
    足以说明这是一个群作用，从而 $G$ 可以写作轨道的无交并，而轨道恰好是双陪集。\
    只需注意到 $g K Inv(g) <= G$，从而：
    $
    |H g K| = |H g K Inv(g)| = |H (g K Inv(g))| \ = (|H| |g K Inv(g)|) / (|H inter g K Inv(g)|) = (|H| |K|) / (|H inter g K Inv(g)|) = |K| |H : H inter g K Inv(g)|
    $
    另一侧同理
6.
    考虑 $G$ 对 $K$ 的左陪集分解，设其代表元集为 $I$：
    $
    G = union_(g in I) g K
    $
    显然同一陪集的元素在 $sigma$ 下的像相同，不同的陪集的元素在 $sigma$ 下的像不同，从而恰有：
    $
    Inv(sigma)(sigma(H)) = union_(g in H) g K = H K
    $
    由群同态的性质：
    $
    H <= G => sigma(H) <= sigma(G) \
    H' <= sigma(G) => Inv(sigma)(H') <= G
    $
    可得 $H K <= G$
