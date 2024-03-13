#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业4",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
#set heading(outlined: false)
（10月9日作业上次已交，这是12日作业）
= P25
23.
#answer[
    设 $H$ 是 $G$ 中指数为二的子群，从而：
    $
    G = H union x H = H union H x\
    $
    对 $forall g = x h in x H = G- H$，有：
    $
    g H Inv(g) = x h H Inv((x h)) = x h H Inv(h) Inv(x) = x H Inv(h) Inv(x) = x H Inv(x)
    $
    而由前式知，$x H = H x => x H Inv(x) = H => g H Inv(g) = H$\
    这表明 $G- H subset N_G (H)$，进而 $G = N_G (H)$，$H$ 是正规子群。
]
25.
#answer[
    $D_20 = generatedBy(r\, s | r^20 = e\, r s = s r^19)$。设 $H$ 是非平凡正规子群，断言：
    + $normalSub(generatedBy(r), D_20)$，这由 $s r s = Inv(r)$ 给出
    + $H = generatedBy(r^k) <= generatedBy(r) => normalSub(H, G)$，类似的这是因为 $s r^k s = Inv((r^k))$
    + 若 $s in H$，则有：
        - $r s Inv(r) = s Inv((r^2)) = r^(18) in H$
        - $generatedBy(r^18) = generatedBy(r^2) subset H$
        - $H supset generatedBy(r^2\, s)$
        - $H = generatedBy(r^2\, s)$ 

            这是因为注意到：
            $
            D_20 = generatedBy(r^2\, s) union r generatedBy(r^2\, s)
            $
            其中 $r^k, r^k$ 都含于等号右侧是显然的，而：
            $
            s r^k = Inv((r^k))s in generatedBy(r^2\, s) union r generatedBy(r^2\, s)
            $
            这给出 $H$ 的指数为 $2$，从而它是正规子群，并且不存在满足上述要求的更大的非平凡正规子群。
    + 若 $r^k s in H$：

        事实上，由于 $[r -> r, s -> r^k s]$ 是群同构，因此此种情况和上一种情况本质是相同的，从而 $H = generatedBy(r^2\, r^k s)$
    综上，$D_20$ 的非平凡正规子群分别为：
    $
    H "with" H <= generatedBy(r)\
    generatedBy(r^2\, r^k s), forall k in ZZ
    $


]
26.
    #answer[
    #set enum(numbering: "(1)")
    + \
        - $a, b in C_G (S) =>forall x in S: x a = a x, x b = b x \ => forall x in S: (a Inv(b))x=a x  Inv(b) = x a Inv(b) =>  a Inv(b) in C_G (S)$
        - $a, b in N_G (s) => a S Inv(a) = b S Inv(s) = S => a Inv(b) S b Inv(a) = a S Inv(a) = S =>  a Inv(b) in N_G (S)$
    + 设 $n in N_G (S), c in C_G (S)$，则：
    $
        forall a in S\
        Inv(n) a n in S => (Inv(n) a n) c = c (Inv(n) a n) => a (n c Inv(n)) = (n c Inv(n)) a
    $
        从而 $n c Inv(n) in C_G (S)$。\
        这说明 $n C_G (S) Inv(n) subset C_G (S)$，类似有 $Inv(n) C_G (S) n subset C_G (S) => C_G (S) subset n C_G (S) Inv(n)$，从而 $n C_G (S) Inv(n) = C_G (S)$
    ]
27.
    #answer[
    #set enum(numbering: "(1)")
    + 
        $
        H K Inv(H) &= union_(h_1, h_2 in H) h_1 K h_2
        \ &= union_(h_1, h_2 in H) h_1 K Inv(h_1) h_1 h_2
        \ &= union_(h_1, h_2 in H) K h_1 h_2
        \ &= K H
        $
        这表明：
        $
        H K = K H H = K H\
        (H K)^2 = H K K H = H K H = K H = H K\
        $
        进而 $H K <= G$
    + 
        $
        forall g in G: g H K Inv(g) = g H Inv(g) g K Inv(g) = H K
        $
        这就给出了 $normalSub(H K, G)$
    ]
29.
    #answer[
        注意到：
        $
        (a N)^(ord(a)) = N => ord(a N) | ord(a) | |N|
        $
        但 $ord(a N) | |quotient(G, N)|$\
        这就说明了 $ord(a N) = 1 => a in N$
    ]
32.
    #answer[
        设：
        $
        G = union_i x_i H = union_i H x_i
        $
        断言 $sect_i x_i H Inv(x_i)$ 是正规子群。事实上，设 $G$ 中任意元素为 $h x$，则：
        $
        h x (sect_i x_i H Inv(x_i)) Inv(x) Inv(h)
        \ = sect_i h x x_i H Inv(x_i) Inv(x) Inv(h)
        $
        断言若 $x_i, x_j$ 在不同陪集中，则 $g x_i, g x_j$ 也在不同陪集中。因此记 $x'_i = h x x_i$，则它们也是新的一组代表元，因此：
        $
        sect_i h x x_i H Inv(x_i) Inv(x) Inv(h) = sect_i x'_i H Inv(x'_i) = sect_i x_i H Inv(x_i)
        $
        这就给出了 $normalSub(sect_i x_i H Inv(x_i), G)$。另一方面，由 31 题结论，它的指数有限。\
       
    ]
39. 
    #answer[
        + $A(B sect C) subset A B sect A C = A B sect C$ 是显然的
        + 任取 $a b = c in A B sect C$，从而 $b = Inv(a) c in C$，因此 $a b in A(B sect C)$
    ]
40.
    #answer[
        
        $
        A = A (A sect C) = A(B sect C) = B sect A C = B sect B C = B
        $
    ]
42.
    #answer[
        设 $normalSub({1, x}, G)$，断言对于任意 $g in G$，有：
        $
        g x Inv(g) = x
        $
        否则由 $g x Inv(g) in {1, x}$ 知 $g x Inv(g) = 1 => x = 1$，矛盾\
        上式已经给出了 $x in C_G (G)$
    ]
45.
    #answer[
        二面体群显然可以由两个二阶元素 $s, r s$ 生成，因此只证充分性：\
        设两个二阶元素分别为 $x, y$，再记 $r = x y, ord(r) = n$。
        + $r y = x$
        + $generatedBy(r\, y) = generatedBy(x\, y)$
        + $y r y = y (x y) y = y x = Inv((x y)) = Inv(r)$
        上述事实表明了 $generatedBy(x\, y) tilde.eq D_(2n)$
    ]
= P57
15.
    #answer[
        设 $x in Z(S_n)$，则对任意 $i, j in Z_n, i!=j$，有：
        $
            x (i, j)(i) = x(j)\
            = (i, j)x(i) = (i, j)(x(i))
        $
        由于 $x(i) != x(j)$，故 $x(i) = i$ 或 $j$。而由 $n > 2$，取异于 $i, j$ 的 $k$，则有 $x(i) = i$ 或 $k$。\
        这表明 $x(i) = i$，进而由 $i$ 的任意性知 $x = 1$
    ]
16.
    #answer[
    设 $H$ 是 $G$ 的非平凡正规子群，通过取共轭容易知道若 $H$ 含有某个型的元素，则将含有该型的所由元素。\
    断言 $H$ 含有一个 $3$ 阶元素。\
    取 $x = (i_1 i_2 .. i_t)gamma in H$，其中 $(i_1 i_2 .. i_t)$ 是最长的轮换，则：
    + 若 $t >= 4$
        - 
            $
            (i_1 i_2 i_3) (i_1 i_2 .. i_t)gamma (i_1 i_3 i_2) = (i_2 i_3 i_1 ... i_t) gamma in H
            $
        - 
            $
            (i_2 i_3 i_1 i_4 ... i_t) gamma Inv(((i_1 i_2 .. i_t)gamma)) = (i_2 i_3 i_1 i_4 ... i_t) Inv((i_1 i_2 .. i_t)) = (i_1 i_2 i_4) in H
            $
    + 若 $t = 3$
        -
            $
            (i_2 i_3)(i_1 i_2 i_3) gamma (i_2 i_3) = (i_1 i_3 i_2) gamma in H 
            $
        -
            $
            (i_1 i_2 i_3) gamma Inv(((i_1 i_3 i_2) gamma)) = (i_1 i_2 i_3) Inv((i_1 i_3 i_2)) = (i_1 i_3 i_2)
            $
    - 若 $t = 2$ 
        - 若只有一个二轮换，则易知 $H = S_n$
        - 若至少有两个二轮换，设 $x = (i_1 i_2)(i_3 i_4)sigma$，（再取 $i_5$ 不同于之前的元素）则：
        $
        (i_2 i_3) x (i_3 i_2) = (i_1 i_3)(i_2 i_4)sigma in H\
        (1_2 i_5) x (i_5 i_2) = (i_1 i_5)(i_3 i_4)sigma in H\
        (i_1 i_3)(i_2 i_4)sigma Inv(((i_1 i_5)(i_3 i_4)sigma)) = (i_1 i_3)(i_2 i_4)(i_3 i_4)(i_1 i_5) = (i_1 i_5 i_3 i_2 i_4) in H
        $
        这就回到了之前的情况。
    由此以及 $A_n$ 可由三轮换生成知，知 $A_n <= H$，但 $A_n$ 的指数已经为 $2$，从而 $H$ 要么是 $A_n$ 要么是 $S_n$。\
    ]
= 补充题
1. 
    #answer[
    #set enum(numbering: "(1)")
    + 由子集的交还是子集，这是显然的。
    + 由陪集分解：
        $
        S_n = A_n union x A_n\
        G = (G sect A_n) union (x G sect A_n)
        $
        显然后者也是陪集分解，分别表示 $G$ 中偶置换与奇置换，由陪集性质知它们数量相等。
    ]
2. 
    #answer[
        #set enum(numbering: "(1)")
        + 注意到满足：
            $
            Inv(x) (123...n) x = (123...n)
            $
            的 $x$ 由 $x(1)$ 唯一决定。事实上，任取 $y in ZZ_n$，则：
            $
            x(i) = y + (i - 1)
            $
            是唯一一个在 $C_G ((123...n))$ 之中且满足 $x(1) = y$ 的置换。\
            从而 $|C_G ((123...n))| = n$
        + 容易得到 $C_G (sigma) = 1^(l_1) 2^(l_2) ... n^(l_n) l_1 ! l_2 ! .. l_n !$，进而考虑共轭作用，与其共轭的元素即其所在轨道的阶数，恰为 $(|G|) / (C_G (sigma)) = n! / (1^(l_1) 2^(l_2) ... n^(l_n) l_1 ! l_2 ! .. l_n !)$
    ]
3.
    #answer[
        断言：$Stab_G (m) = Stab_H (m) sect H$\
        对于任意 $m_1, m_2 in M$，存在 $g in G$ 使得：
        $
        Stab_G (m_1) = g Stab_H (m_2) Inv(g)
        $
        从而：
        $
        Stab_H (m_1) = Stab_G (m_1) sect H \ = g Stab_H (m_2) Inv(g) sect H = g Stab_H (m_2) Inv(g) sect g H Inv(g) \ = g (Stab_H (m_2) sect H) Inv(g) = g Stab_H (m_2) Inv(g) 
        $
        这就表明在 $H$ 作用下 $M$ 所有元素对应的稳定化子的阶相等，从而所有轨道的长度相等。
    ]
4.
    #answer[
        注意到若 $x$ 是不动点，则 $|"orb"(x)| = 1$。反之若不然，则 $|"orb"(x)| = |G : Stab_G(x)|$ 将是 $p$ 的倍数。\
        在轨道分解：
        $
        |G| = sum_("orbit" O) |O|
        $
        的右侧中，除 $1$ 外的项都是 $p$ 的倍数，而项 $1$ 恰有 $M_0$  个。\
        从而模 $p$ 立得原结论。
    ]