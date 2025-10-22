#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业7",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
= 1.
  #answer[
    + 对 $d$ 做素因数分解，得：
      $
        d = p_1^(alpha_1)p_2^(alpha_2)...p_k^(alpha_k)
      $

    + 容易看出 $p_i^(alpha_i) | n$，因此取每个素因数对应的 $Sylow(p)$ 子群，在其中找出阶为 $p_i^(alpha_i)$ 的子群。这些子群的积（由于它们交为平凡群）的阶就为 $d$。不妨设 $p_i$ 是所有 $n$ 的素因子，$d$ 中不含的设其指数为零。

    + 另一方面，设群 $G = P_1 times P_2 times ... times P_k$。显然 $p_i^(alpha_i) | |P_i|$，因此只需证明每个有限交换 $p$ 群都满足拉格朗日定理的逆定理即可。

    + 由有限交换群的分类，$P_i$ 形如：
      $
      ZZ_(p_i^(lambda_1)) times ZZ_(p_i^(lambda_2)) times ... times ZZ_(p_i^(lambda_k))
      $
      其中 $lambda_1 + lambda_2 +... +lambda_k = n$。从左往右选取若干子群，直至 $lambda_s$ 使得：
        $
        lambda_1 + lambda_2 + ... + lambda_s <= alpha_i\
        lambda_1 + lambda_2 + ... + lambda_s + lambda_(s+1) > alpha_i\
        $
      - 若上面前式取等，则 $ZZ_(p_i^(lambda_1)) times ZZ_(p_i^(lambda_2)) times ... times ZZ_(p_i^(lambda_s))$ 即符合要求。
      - 若不然，设 $t = alpha_i - lambda_1 + lambda_2 + ... + lambda_s < lambda_(s+1)$，因此在 $ZZ_(p_i^(lambda_(s+1)))$ 中容易找到子群 $H$ 使得 $|H| = p_i^t$，因此：
        $
        ZZ_(p_i^(lambda_1)) times ZZ_(p_i^(lambda_2)) times ... times ZZ_(p_i^(lambda_s)) times H
        $
        即满足要求。
  ]
= 2.
  #answer[
    设：
    $
    G = ZZ_(p^(lambda_1)) times ZZ_(p^(lambda_2)) times ... times ZZ_(p^(lambda_s))
    $
    并设：
    $
    a = (a_1, a_2, ..., a_s)
    $
    只需证明在每个循环群中：
    $
    x^n = a_i
    $
    都有解即可。
    - 注意到：
      $
      x^n = y^n => (x Inv(y))^n = e => p | n or x = y => x = y
      $
      因此对每个循环群中的 $p^(lambda_i)$ 个元素，这些元素的 $n$ 次方互不相同，因而必可取遍所有元素。
    - 因此在每个循环群中均存在 $x_i$ 使得 $x_i^n = a_i$，由此：
      $
      (x_1, x_2, ..., x_s)^n = (a_1, a_2, ..., a_s) = a
      $
    这就证明了结论。
  ]
= 3.
  #answer[
    - $360 = 2^3 dot 3^2 dot 5$
    - $3$ 的所有分拆有：
        $
        (3)\
        (2, 1)\
        (1, 1, 1)
        $
        $2$ 的所有分拆为：
        $
        (2)\
        (1, 1)
        $
    - 初等因子共有六个，分别是：
      $
      {2^3, 3^2, 5}\
      {2^2, 2, 3^2, 5}\
      {2, 2, 2, 3^2, 5}\
      {2^3, 3, 3, 5}\
      {2^2, 2, 3, 3, 5}\
      {2, 2, 2, 3, 3, 5}\
      $
    - 不变因子分别为：
      $
      {2^3 dot 3^2 dot 5}\
      {2, 2^2 dot 3^2 dot 5}\
      {2, 2, 2 dot 3^2 dot 5}\
      {3, 2^3 dot 3 dot 5}\
      {3 dot 2, 2^2 dot 3 dot 5}\
      {2, 2 dot 3, 2 dot 3 dot 5}\
      $
    - 所有可能结构为：
      $
      ZZ_(2^3) times ZZ_(3^2) times ZZ_(5)\
      ZZ_(2^2) times ZZ_2 times ZZ_(3^2) times ZZ_(5)\
      ZZ_2 times ZZ_2 times ZZ_2 times ZZ_(3^2) times ZZ_(5)\
      ZZ_(2^3) times ZZ_3 times ZZ_3 times ZZ_5\
      ZZ_(2^2) times ZZ_2 times ZZ_3 times ZZ_3 times ZZ_5\
      ZZ_2 times ZZ_2 times ZZ_2 times ZZ_3 times ZZ_3 times ZZ_5\
      $
  ]
= 4.
  #answer[
    - $16 = 2^4$
    - $4$ 的所有分拆有：
      $
      (4)\
      (3, 1)\
      (2, 2)\
      (2, 1, 1)\
      (1, 1, 1, 1)
      $
    - 所有可能交换群结构为：
      $
      ZZ_(2^4)\
      ZZ_(2^3) times ZZ_2\
      ZZ_(2^2) times ZZ_(2^2)\
      ZZ_(2^2) times ZZ_2 times ZZ_2\
      ZZ_2 times ZZ_2 times ZZ_2 times ZZ_2\
      $
    - 其中
      - $ZZ_(2^4)$ 恰有两个二阶元
      - $ZZ_(2^3) times ZZ_2$ 恰有三个二阶元
      - $ZZ_(2^2) times ZZ_(2^2)$ 恰有三个二阶元
      - $ZZ_(2^2) times ZZ_2 times ZZ_2$ 恰有七个二阶元
      - $ZZ_2 times ZZ_2 times ZZ_2 times ZZ_2$ 恰有十五个二阶元
  ]
= 5.
  #answer[
    （1） \
      - 对 175 阶群利用 Sylow 定理：
        $
        5 | n_5-1, n_5 | 7 => n_5 = 1\
        7 | n_7-1, n_7 | 25 => n_7 = 1
        $
      - 注意到两个 Sylow 子群不交且都正规，因此：
          $
          G = P_5 times P_7
          $
        注意到 $P_7 = ZZ_7$，$|P_5| = 25 = 5^2$，而 $p^2$ 阶群一定交换，因此 $P_7, P_5$ 都交换，进而 $G$ 交换。
      - 它的所有可能结构为：
        $
        ZZ_25 times ZZ_7\
        ZZ_5 times ZZ_5 times ZZ_7\
        $
    （2）\
      - 同样利用 Sylow 定理：
        $
        13 | n_13 - 1, n_13 | 11^2 => n_13 = 1\
        11 | n_11 - 1, n_11 | 13^2 => n_11 = 1
        $
      - 其余类似可以证明 $G$ 交换，它的所有可能结构为：
        $
        ZZ_(11^2) times ZZ_(13^2)\
        ZZ_(11^2) times ZZ_13 times ZZ_13\
        ZZ_11 times ZZ_11 times ZZ_(13^2)\
        ZZ_11 times ZZ_11 times ZZ_13 times ZZ_13\
        $
  ]
= 6.
  #answer[
    注意到 $A times B$ 的不变因子即 $A, B$ 不变因子的并，$A times C$ 类似，因此题设给出 $B, C$ 具有相同的不变因子，即 $B, C$ 同构。
  ]
= 7.
  #answer[
    取 $a, b$ 分别是两个循环群的生成元，显然：
    $
    a' = phi(a, 1), b' = phi(1, b)
    $
    唯一决定一个同构映射 $phi$。
    - 由于 $phi$ 是同构，因此有：
      $
      ord(a') = p\
      ord(b') = p\
      generatedBy(a') inter generatedBy(b') = {e}
      $

    - 注意到若 $generatedBy(a') inter generatedBy(b') != {e}$，则它们将有公共非平凡元素 $x$，由 $p$ 是素数，$x$ 一定同时是两者的生成元，即有 $generatedBy(a') = generatedBy(b')$

    - 这意味着，只要在 $Z_p times Z_p$ 中任找两个不在同一循环群中的非平凡元素作为两元素的像，都可以唯一确定一个同构映射。
    
    - 同时，这表明 $|Aut(ZZ_p times ZZ_p)| = (p^2 - 1)(p^2 - p) = p(p - 1)^2(p + 1)$
  ]
= 8.
  #answer[
    不妨设 $m <= n$

    设 $x = (a, b)$，显有：
      $
      ord(x) = lcm(ord(a), ord(b))
      $
      设 $ord(x) = p^r, ord(a) = p^(r_1), ord(b) = p^(r_2)$，则有：
        $
        max(r_1, r_2) = r
        $
      另一方面，$ZZ_(p^m)$ 中阶为 $p^r$ 的元素恰有 $p^(r-1)(p-1)$ 或 $1 (r=0)$ 个，故只需考虑 $r_1, r_2$ 的可能取值即可：
      - 当 $r <= m$ 时，在一个群中取定 $p^r$ 阶元素，另一个元素的取法恰好取遍唯一的 $p^r$ 阶子群的取法共有:
        $
          p^(r-1)(p-1)p^r + p^(r-1)(p-1)p^r - (p^(r-1)(p-1))^2 =  p^(r-1)(p-1)(2p^r - p^r + p^(r-1)) \
          = p^(r-1)(p-1)(p^r + p^(r-1))
        $
      - 当 $m < r <= n$ 时，可能取值共有 
        $
          p^(r-1)(p-1)p^m
        $
      上面两数显然将每个子群重复计算了 $p^(r-1)(p-1)$ 次，因此最后答案为：
        - $p^r + p^(r-1)$ 或
        - $p^m$

    //对于非循环子群，我们首先证明：
    //  #lemma[][
    //    $G$ 的所有子群都是不超过两个循环群的直积
    //  ]
    //  #proof[
    //    设 $H <= G$。若 $H$ 是循环群，结论显然成立，下设 $H$ 不是循环群。\
    //    //记 $pi_1, pi_2$ 分别为两个投影映射，断言：
    //    //- 存在 $a, b$ 使得 $a, b$ 分别为 $Inv(pi_1)(H),Inv(pi_2)(H)$ 中最高阶元素，且 $(a, b) in H$
////
    //    //  事实上，取 $a, b$ 分别为两者中的最高阶元素，设：
    //    //   $
    //    //   pi_1(x) = pi_1(a, b') = a\
    //    //   pi_2(y) = pi_2(a', b) = b
    //    //   $
    //    //   不妨设 $ord(a) <= ord(b)$，进而 $ord(a') < ord(b)$（若等于则结论已成立）\
    //    //   我们有：
    //    //   $
    //    //   y^ord(a') = (e, b^(ord(a'))) in H\
    //    //   x y^ord(a') = (a, b' b^(ord(a'))) in H
    //    //   $
    //    //   由于 $ord(b') | ord(b) => b' = generatedBy(b)$，可设 $b' = b^k$，并不妨设 $k = p^(r_1)$，从而上式变为：
    //    //   $
    //    //   (a, b^(k + ord(a'))) in H
    //    //   $
    //    设 $x = (a, b)$ 是 $H$ 中最高阶元素，阶为 $p^r$，并不妨设 $ord(a) = p^r$。显有 $H$ 中所有元素的阶都是 $p^r$ 的因子。\
    //    若结论不成立，则将存在非平凡元素：
    //      $
    //      x_1 = (a_1, b_1)\
    //      x_2 = (a_2, b_2)
    //      $
    //      使得$H' <= H, H' = generatedBy(x)generatedBy(x_1)generatedBy(x_2) tilde.eq generatedBy(x) times generatedBy(x_1) times generatedBy(x_2)$
    //      - 注意到 $ord(x_i) | p^r$，故有：
    //        $
    //        ord(a_i) | p^r
    //        $
    //        进而：
    //        $
    //        a_i in generatedBy(a)
    //        $
    //        从而不妨设 $a_1 = a^(k_1), a_2 = a^(k_2)$，我们有：
    //        $
    //        (a_1, b_1)Inv(((a, b)^(k_1))) = (1, b_1 b^(k_1)) in generatedBy(x) generatedBy(x_1)\
    //        (a_2, b_2)Inv(((a, b)^(k_2))) = (1, b_2 b^(k_2)) in generatedBy(x) generatedBy(x_2)
    //        $
    //      - 由假设，应有：
    //        $
    //        generatedBy((e, b_1 b^(k_1))) inter generatedBy((e, b_2 b^(k_2))) subset generatedBy(x) generatedBy(x_1) inter generatedBy(x) generatedBy(x_2) = generatedBy(x)
    //        $
    //        然而在 $generatedBy(x)$ 中，第一分量为单位元的元素只有 $(e, e)$，进而：
    //        $
    //        generatedBy((e, b_1 b^(k_1))) inter generatedBy((e, b_2 b^(k_2))) = {(e, e)}\
    //        => generatedBy(b_1 b^(k_1)) inter generatedBy(b_2 b^(k_2)) = {e}
    //        $
    //      - 除非 $b_1 b^(k_1) = b_2 b^(k_2) = e $，否则这是不可能的，而若前式成立，将有：
    //        $
    //        (a_1, b_1)Inv(((a, b)^(k_1))) = e => (a_1, b_1) in generatedBy(x)\
    //        (a_2, b_2)Inv(((a, b)^(k_2))) = e => (a_2, b_2) in generatedBy(x)
    //        $
    //        这也与假设不符！
    //  ]
    //由引理，我们只需考虑 $G$ 的形如 $ZZ_(p^(r_1)) times ZZ_(p^(r_2))$ 型子群即可。
//
    //另一方面，对任意 $H <= G$，注意到在两个投影映射 $pi_1, pi_2$ 下，有：
    //  $
    //    pi_1(H) <= pi_1(G) = ZZ_(p^m)\
    //    pi_2(H) <= pi_2(G) = ZZ_(p^n)
    //  $
    //这表明：
    //  - $H$ 中必然存在形如
  ] //    
= 9.
  #answer[
    + 若有限生成交换群是有限群，显然它的生成元都是有限阶元素。
    + 设生成元都是有限阶元素，显有：
      $
      generatedBy(a_1\, a_2\, ...\,a_n ) = {a_1^k_1 a_2^k_2 ... a_n^k_n | k_i in ZZ_+, k_i < max(ord(a_i))}
      $
      这当然是有限群
  ]
= 10.
  #answer[
      $75 = 3 dot 25$，利用 Sylow 定理：
      $
      3 | n_3 - 1, n_3 | 25 => n_3 = 1, 25\
      5 | n_5 - 1 , n_5 | 3 => n_5 = 1
      $
      - 若 $n_3 = 1$，仿照之前习题可知 $G$ 交换，此时唯二的可能为 $ZZ_25 times ZZ_3$ 或 $ZZ_5 times ZZ_5 times ZZ_3$
      - 若 $n_3 = 25$，我们有 $normalSub(P_5, G)$，进而：
        $
        G tilde.eq P_5 times.r ZZ_3
        $
        换言之，存在 $ZZ_3 -> Aut(P_5)$ 的非平凡同态（否则群将交换），而 $Aut(ZZ_25) tilde.eq ZZ_(20)$ 其中没有三阶子群，因此 $P_5 = ZZ_5 times ZZ_5$。
      - 考虑 $Aut(ZZ_5 times ZZ_5)$ 中的三阶元素 $phi$，事实上这等同于找一个 $ZZ_5$ 上的线性变换 $A$ 满足:
        $
        A^3 = I <=> (A - I)(A^2 + A + I) = 0
        $
        由于二阶矩阵的最小多项式至多二次，而 $A^2 + A + I$ 已经不可约，故 $A$ 的最小多项式一定为 $A^2 + A + I$，且这样的矩阵都相似于有理标准型：
        $
        mat(0, -1;1, -1)
        $
        从而 $Aut(ZZ_5 times ZZ_5)$ 中的三阶元素都共轭于同一个元素，它们将给出相同的 $(ZZ_5 times ZZ_5) times.r ZZ_3$ 结构
  ]
= P58
== 17.
  #answer[
    取自然同态：$pi: G -> quotient(G, G')$，由于 $N inter ker(pi) = {e}$，因此：
    $
    pi|_N : N -> pi(N)
    $
    将成为同构映射，进而 $N$ 交换。更进一步，对 $forall x in G, n in N$，有：
    $
    pi(x n Inv(x)) = pi(n)
    $
    由 $pi$ 是同构即得 $x n Inv(x) = n$，也即 $n in Z(G)$，证毕。
  ]
== 19.
  #answer[
    考虑群同态：
    $
    funcDef(phi, G, quotient(G, H) times quotient(G, K), g, (g H, g K))
    $
    显有：
    $
    ker(phi) = H inter K
    $
    因此：
    $
    quotient(G, H inter K) tilde.eq im(phi) <= quotient(G, H) times quotient(G, K)
    $
    另一方面，显然 $quotient(G, H) times quotient(G, K)$ 可解，因此 $im(phi)$ 也可解，故 $G$ 可解。
  ]
= P65
== 14.
  #answer[
    //+ 注意到有限 $p$ 群可解，故 $G' != G$，因此 $G'$ 的阶至多为 $p^2$。这就给出 $G'$ 交换。
//
    + 注意到 $p$ 群的中心非平凡，因此 $|quotient(G, Z(G))|=p, p^2$，前者代表 $quotient(G, Z(G))$ 循环，这将导致 $G$ 交换，后者可以导出 $quotient(G, Z(G))$ 交换。

    + 这意味着自然同态：
      $
      pi: G -> quotient(G, Z(G))
      $
      是群到交换群的同态，故 $G' <= Z(G)$
    
    + 然而 $|Z(G)| = p$，而 $G'$ 也不是平凡群（否则 $G$ 交换），故 $G' = Z(G)$
  ]
== 15.
  #answer[
    考虑 $G$ 在 $N$ 上的共轭作用，这将自然诱导出 $G -> Aut(N)$ 的同态。\
    但 $|Aut(N)| = p - 1$，它与 $p$ 互素，进而作用只能是平凡作用，故 $N <= Z(G)$
  ]
== 17.
  #answer[
    由 $G' tilde.eq S_4$ 得 $G'' tilde.eq A_4, G''' tilde.eq V_4, G'''' tilde.eq {e}$。并有显然 $G != S_4$
    + 取自然同态 $pi : G -> quotient(G, G''')$，将有：
      $
      quotient(G', G''') = pi(G') = (pi(G))' = (quotient(G, G'''))'
      $
      故上式同构于 $quotient(S_4, V_4)$。
    + 注意到 $6$ 阶群只有两种，交换的 $ZZ_2 times ZZ_3$ 与不交换的 $S_3$。$quotient(S_4, V_4)$ 交换将给出 $G' <= V_4$，这是荒谬的，因此 $quotient(S_4, V_4) tilde.eq S_3$。
    + 记 $quotient(G, G''') = G_1$，有：
      $
      G_1 ' tilde.eq S_3, G_1 '' tilde.eq A_3 tilde.eq ZZ_3, G_1 ''' = {e}
      $
    + 考虑 $G_1$ 在 $G_1 ''$ 上的共轭作用，这将给出 $phi: G_1 -> Aut(ZZ_3)$ 的同态，而 $Aut(ZZ_3) tilde.eq ZZ_2$ 交换，进而：
      $
      ker(phi) >= G_1 ' = S_3
      $ 
      换言之，将有 $phi(S_3) = I$，然而：
        $
        (12)(123)Inv((12)) = (213) != (123)
        $
      因此这是荒谬的
  ]
== 18.
  #answer[
    设 $a_i$ 互不相同，注意到：
    $
    (a_1 a_2 a_3)(a_3 a_4 a_5)Inv((a_1 a_2 a_3))Inv((a_3 a_4 a_5)) = (a_1 a_4 a_5)Inv((a_3 a_4 a_5)) = (a_4 a_3 a_1)
    $
    由 $a_i$ 的任意性知结论成立。又因为 $A_n$ 可被三轮换生成，故 $A_n ' = A_n$
  ]
= 1.
  #answer[
    + 注意到 $quotient(G, G')$ 交换，故显有 $normalSub(quotient(H, G'), quotient(G, G'))$
    + 由商群的对应定理，这就说明 $normalSub(H, G)$
  ]
= 2.
  #answer[
    显然对于任意换位子 $[x, y]$，$[alpha(x), alpha(y)]$ 也是换位子，反之亦然，进而群的同构产生换位子上的一一对应，不改变换位子的集合，因此结论显然成立。
  ]
= 3.
  #answer[
    - 注意到在换位子：$[x, y]$ 中，一定有偶数个 $s$，也即结果中一定不含 $s$，故 $D'_n subset generatedBy(r)$。
    - 同时：
      $
      r s Inv(r) s = r^2
      $ 
      因此 $generatedBy(r^2) <= D'_n$
    - 若 $n$ 为奇数，这就表明 $D'_n = generatedBy(r)$
    - 若 $n$ 为偶数，断言 $D'_n = generatedBy(r^2)$。事实上： 
      $
      quotient(D_n, generatedBy(r^2))
      $
      是四阶群，必然交换，故 $D'_n <= generatedBy(r^2)$，这就证明了 $D'_n = generatedBy(r^2)$
  ]
= 4.
  #answer[
    前面习题证明自同构不改变换位子，共轭作用作为自同构同样成立。取 $alpha$ 是任意共轭作用，则有：
    $
    alpha|_G' : G' -> G'
    $
    是 $G'$ 的自同构，自然有：
    $
    alpha(G'') = alpha|_G'((G')') = (G')' = G''
    $
    以此类推易知结论成立
  ]
= 5.
  #answer[
    对 $|H|$ 的阶做归纳法，当 $|H| = 1$ 时，由于 $K$ 可解，结论显然成立。\
    由 $H$ 可解，有 $H' < H, normalSub(H', H)$，进而：
    $
    normalSub(H' times.r K, H times.r K)
    $
    由归纳法，$H' times.r K$ 可解。另一方面，$quotient(H times.r K, H' times.r K) tilde.eq quotient(H, H')$ 也可解，进而 $H times.r K$，证毕。
  ]
= 6.
  #answer[
    （1） 由 $quotient(G, N)$ 的正规子群与包含 $N$ 的正规子群间的一一对应，结论显然成立。

    （2）使用归纳法对群的阶进行归纳，$|G| = 1$ 时显然成立。
      + 若 $G$ 是单群，则 ${e}$ 就是极大正规子群
      + 若 $G$ 不是单群，则存在非平凡正规子群 $N$。由归纳法，取 $quotient(G, N)$ 的极大正规子群 $quotient(N_1, N)$，由对应法则 $N_1$ 一定就是极大正规子群。

      （3）若存在符合要求的子群列，$G$ 可解是显然的。反之，若 $G$ 可解，只需将 $quotient(G, G')$ 分解成题目要求的子群列即可。

        事实上，由上面的证明过程，我们可以取得一个包含 $G'$ 的极大正规子群 $N$。
        - 注意到 $quotient(G, N)$ 是交换单群，进而是素数阶循环群。
        - 进一步，再在 $N$ 中取得一个包含 $G'$ 的极大正规子群 $N_1$，类似可得 $quotient(N, N_1)$ 是交换单群，进而是素数阶循环群。
        - 以此类推，容易找到一列 $N$ 使得：
          $
          G' = N_k triangle.l N_(k_1) triangle.l ... triangle.l N_1 triangle.l N triangle.l G 
          $
          满足任意前后两项的商群都是素数阶循环群，这就是所求的子群列。
  ]
= P35
== 4
  #answer[
    加法构成交换群，乘法构成幺半群是显然的，只需验证分配律：
    $
    phi dot (f + g)(x) = phi((f + g )(x)) = phi(f(x) + g(x)) = phi(f(x)) + phi(g(x)) \
    = (phi dot f)(x) + (phi dot g)(x)
    $
    右分配同理可得。
  ]
== 6.
  #answer[
    设 $n$ 阶循环群为 $ZZ_n$，显然 $1$ 的像唯一确定一个自同态。\

    定义：
    $
    funcDef(phi, ZZ_n, End(ZZ_n), a, [x | x -> a x])
    $
    容易验证 $phi$ 是一一对应。断言它是环之间（将 $ZZ_n$ 看作环）同构：
    - 保持单位元：显然
    - 保持加法：
      $
      phi(a + b) = [x | x -> (a + b) x] = [x | x -> a x + b x]\
      = [x | x -> a x] + [x | x -> b x]
      = phi(a) + phi(b)
      $
    - 保持乘法：
      $
      phi(a b) = [x | x -> (a b) x] = [x | x -> a (b x)]\
      = [x | x -> a x] dot [x | x -> b x]\
      = phi(a) dot phi(b)
      $
    因此 $End(ZZ_n)$ 就是环 $ZZ_n$
  ]
== 7.
  #answer[
    注意到 $ZZ_n times ZZ_n$ 上的自同态就是线性空间 $ZZ_n times ZZ_n$ 上的线性变换，因此： 
    $
    End(ZZ_n times ZZ_n) tilde.eq M_(2 times 2) (ZZ_n)
    $
    //定义：
    //$
    //funcDef(phi, ZZ_n times ZZ_n, End(ZZ_n times ZZ_n), (a, b), [(x, y) | (x, y) -> (a x, b y)])
    //$
    //断言它是环同构：
    //- 保持单位元：显然
    //- 保持加法：
    //  $
    //  phi((a, b) + (c, d)) = [(x, y) | (x, y) -> ((a + c) x, (b + d) y)]\
    //  = [(x, y) | (x, y) -> (a x, b y)] + [(x, y) | (x, y) -> (c x, d y)]\
    //  = phi((a, b)) + phi((c, d))
    //  $
    //- 保持乘法：
    //  $
    //  phi((a, b) (c, d)) = [(x, y) | (x, y) -> ((a c) x, (b d) y)]\
    //  = [(x, y) | (x, y) -> (a x, b y)] dot [(x, y) | (x, y) -> (c x, d y)]\
    //  = phi((a, b)) dot phi((c, d))
    //  $
    //- 是单射：
    //  $
    //  ker(phi) = {(a, b) | (a x, b y) = (x, y), forall (x, y) in ZZ_n times ZZ_n} = {(1, 1)}
    //  $
    //- 是满射：
    //  $
    //  
    //  $
  ]
== 13.
  #answer[
    注意到：
    $
    (1 - a)(1 + a + a^2 + ... + a^(n-1)) = 1 - a^n = 1
    $
    这表明 $1 - a$ 与 $1 + a + a^2 + ... + a^(n-1)$ 互为逆元。 
  ]
= P45
== 9.
  #answer[
    $HH_0$ 是加法群的子群显然，只需验证：
    - 乘法封闭：
      $
      (a + b I + c J + d K)(x + y I + z J + w K) \
      = (a x - b y - c z - d w) + (a y + b x + c w - d z) I \ + (a z - b w + c x + d y) J + (a w + b z - c y + d x) K
      $
      显然这些系数都是有理数
    - 有乘法逆元：
      $
      (a + b I + c J + d K)(a - b I - c J - d K) = a^2 + b^2 + c^2 + d^2 \ 
      => (a + b I + c J + d K)(1/(a^2 + b^2 + c^2 + d^2) (a - b I - c J - d K)) = 1
      $
      它的逆的各系数是有理数，因此 $HH_0$ 是乘法群的子群
  ]
== $R = {a + b I + c J + d K | a, b, c, d in ZZ}$ 是子环并确定乘法群
  #answer[
    前面的验证也表明 $R$ 对乘法封闭且有幺元，但其元素未必有乘法逆。
    
    事实上，可以看出有乘法逆当且仅当 $a^2 + b^2 + c^2 + d^2 = 1$，因此可逆元仅有 $plus.minus 1, plus.minus I, plus.minus J, plus.minus K$ 
  ]
== 10.
  #answer[
    设 $x = a + b I + c J + d K$ 在中心之中，则有：
    - $x I = I x$，表明：
      $
      - b - c K + d J = -b + c K - d J => c = d = 0
      $ 
    - $x K = K x$，表明：
      $
      a K + c I = a K - c I => c = 0
      $
    从而 $x = a$。同时，显然 $a$ 在中心之中，因此 $Z(HH_0) = ZZ$
  ]
= 在 $H$ 中 $x^2 + 1 = 0$ 有无穷多解
  #answer[
    $
    (a + b  I + c J + d K)^2 = \
    (a^2 - b^2 - c^2 - d^2) + (2 a b) I + (2 a c) J + (2 a d) K
    $ 
    可见只需取 $a = 0$，任何满足：
    $
    b^2 + c^2 + d^2 = 1
    $
    的四元数 $x$ 均满足 $x^2 = -1$。这是一个球面，当然有无穷多元素
  ]
= 1.
  #answer[
    $200 = 2^3 * 5^2$，显然其中所有含有素因子 $2, 5$ 的数都是幂零元，包括：
    $
    2 * 5 = 10\
    2^2 * 5 = 20\
    2^3 * 5 = 40\
    2 * 5^2 = 50\
    2^2 * 5^2 = 100\
    2^3 * 5^2 = 200
    $
  ]
= 2.
  #answer[
    验证：
    - 加法结合：
      $
      (X + Y) + Z = ((X union Y) union Z) \/ ((X inter Y) inter Y) \ = (X union (Y union Z)) \/ ((X inter Y) inter Z) = X + (Y + Z)
      $
    - 加法交换：显然
    - 加法单位元：显然 $X + emptyset = X$
    - 加法逆元：显然 $X + (A \/ X) = emptyset = e$
    - 乘法结合：显然
    - 乘法幺元：显然 $A$ 就是幺元
    - 分配律：（由于交换，只验证左结合即可）
      $
      X (Y + Z) \
      = X inter ((Y union Z) \/ (Y inter Z))\
       = (X inter (Y union Z)) \/ (X inter (Y inter Z)) \
       = ((X inter Y) union (X inter Z)) \/ ((X inter Y) union (X inter Z)) \
       = X Y + X Z
      $
    - $X^2 = X inter X = X$，表明他是布尔环 
  ]
= 3.
  #answer[
    考虑 $M_2(RR)$ 的由下面若干元素生成的子环：
    $
    {mat(plus.minus 1, 0;0 ,plus.minus 1)}
    $
    这是交换环，因为生成元间皆交换，并且满足 $x^2 = 1$ 恰为四个生成元

    对于第二个结论，类似的考虑无穷维线性空间上的线性变换即可。\
    例如，在 $Hom(RR[x], RR[x])$ 上，考虑如下的元素：
    $
    f_i (x^j) = cases(x^j " if " j!=i, -x^j " if " j=i)\ forall i in ZZ_+
    $
    这无穷个元素均满足 $x^2 = 1$，且它们之间皆交换，因此生成的子环就是满足要求的交换环。
  ]
= 4.
  #answer[
    $
    a + 1 = (a + 1)^3 = a^3 + 3a^2 + 3a + 1 => a^3 + 3a^2 + 2a = 0 => 3a^2 + 3a = 0\
    0 = 3(a+1)^2 + 3(a+1) = 3a^2 + 6 a + 3 + 3a + 3 = 6a + 6 
    $
    取 $a = 1$，得：
    $
    6 + 6 = 0  => 12 = 0
    $
    取 $a = 2$，得：
    $
    12 + 6 = 0 => 6 = 0
    $
    从而 $6a = 0$

    同时：
    $
    a - b = (a - b)^3 = (a - b)(a^2 -a b  -b a +b^2)\
    = a^3 - a^2 b - a b a + a b^2 - b a^2 + b a b + b^2 a - b^3\
    => - a^2 b - a b a + a b^2 - b a^2 + b a b + b^2 a  = 0
    $
    $
    a + b = (a + b)^3 = (a + b)(a^2 + a b + b a + b^2)\
    = a^3 + a^2 b + a b a + a b^2 + b a^2 + b a b + b^2 a + b^3\
    => a^2 b + a b a + a b^2 + b a^2 + b a b + b^2 a = 0
    $
    两式相加减，得：
    $
    2(a b^2 + b a b + b^2 a) = 0\
    2(a^2 b + a b a + b a^2) = 0
    $
    这表明：
    $
    0 = 2 a(a^2 b + a b a + b a^2) - 2  (a^2 b + a b a + b a^2)a = 2 a b - 2 b a = 0  => 2 a b = 2 b a
    $
    另一方面：
    $
    0 = 3(a+b)^2 + 3(a + b) = 3 a^2 + 3 a b + 3 b a + 3 b^2 + 3 a + 3 b \
    = 3 a b + 3 b a = 3(a b + b a) 
    $
    注意到 $6 a = 3 a + 3 a = 0 => 3a = -3a$，因此有：
    $
    3 a b = 3 b a
    $
    两式结合便得 $a b = b a$
    
  ]
= 5.
  #answer[
    #lemma[][
      若环 $R$ 的加法群循环，则 $R tilde.eq ZZ_(|R|)$
    ]
    #proof[
      设 $|R| = n$，记其加法群为 $ZZ_n$，定义：
      $
      funcDef(phi, R, ZZ_n, x = n dot 1, n)
      $
      验证：
      - 保持幺元：显然
      - 保持加法：
        $
        phi(n dot 1 + m dot 1) = (n + m) dot 1 = phi(n dot 1) + phi(m dot 1)
        $
      - 保持乘法：
        $
        phi((n dot 1) (m dot 1)) = phi((n m) dot 1) = n m = phi(n dot 1) phi(m dot 1)
        $
      这就表明结论成立。
    ]
    设环 $R$ 的元素少于八个，考虑以下几种情况：
    - $|R| = 1, 2, 3, 5, 7$，它们都是素数，从而加法群将成为循环群。由引理这些环交换，
    - $|R| = 4 = 2 dot 2$。若加法群是 $ZZ_4$，则类似的环交换。除 $ZZ_4$ 外的 $4$ 阶群只有一种 $ZZ_2 times ZZ_2$
      此时在加法群中四个元素是对称的，不妨设 $(1, 1)$ 是乘法单位元，从而：
      $
      (0, 1)(1, 0) = (0, 1)((1, 1) - (0, 1)) = (0, 1) - (0, 1)^2 \
      = ((1, 1) - (0, 1))(0, 1) = (1, 0)(0, 1)
      $
      足以表明 $R$ 交换
    - $|R| = 6 = 2 dot 3$，这时除循环群外的交换群只有 $ZZ_2 times ZZ_3$
      由对称性，不妨设 $(1, x)$ 是单位元，从而：
      $
      (0, 1)(0, -1) = ((0, 0) + (0, 1))((0, 0) - (0, 1)) = - (0, 1)^2\
      (0, -1)(0, 1) = ((0, 0) - (0, 1))((0, 0) + (0, 1)) = - (0, 1)^2 = (0, 1)(0, -1)\
      (1, x - 1) dot (1, x + 1) = (1, x)^2 - (0, -1)(0, 1) + (0, 1)(0, -1) - (0, 1)^2\
      = (1, x)^2 - (0, 1)^2 = (1, x + 1) dot (1, x - 1)
      $
      上面两个式子足以验证所有第一分量相等的两数乘法可交换（注意到第一分量为 $1$ 的元素只有 $(1, x), (1, x-1), (1, x+1)$\
      再验证：
      $
      (0, a)(1, b) = ((1, x) - (1, x - a))(1, b) = (1,x)(1, b) - (1, x-a)(1, b) \
      = (1, b) - (1, x-a)(1, b) = (1, b) - (1, b)(1, x-a)\
      = (1, b)(0, a)
      $
      表明 $R$ 是交换环。

      对于八元非交换环，考虑 $R = M_(2 times 2)(ZZ_2)$ 中的上三角矩阵构成的子环：
      $
      {mat(a, b;0, c) | a, b, c in ZZ_2}
      $
      注意到：
      $
      mat(1, 1;0, 1)mat(1, 0;0, 0) = mat(1, 0;0, 0)\
      mat(1, 0;0, 0)mat(1, 1;0, 1) = mat(1, 1;0, 0)
      $
      从而它确实不是交换环。
  ]
= 6.
  #answer[
    我们的目标是证明 $omega^2 != a + b omega, a, b in ZZ$，进而它不是子环。只需证明不存在 $f(x) in ZZ[x]$ 使得 $f(omega) = 0$ 即可。\
    事实上，设 $g(x) = x^3 - 2 = (x - omega)(x^2 + omega x + omega^2)$，则显有 $g(omega) = 0$。若二次多项式 $f(x) in ZZ[x]$ 满足 $f(omega) = 0$，则有 $f'(omega) = gcd(f,g)(omega) = 0$：
    - $f'(omega) = f(x)$，这表明 $f(x)$ 是 $g(x)$ 的因式。从而（在 $RR[x]$ 中） $omega$ 是 $g(x)$ 的重根，但 $omega^2 + omega^2 + omega^2 = 3 omega^2 !=0$，与事实不符。
    - $deg(f') < deg (f)$，从而 $deg(f') <= 1$。注意到 $f'(x) in ZZ[x]$，这意味着 $omega in ZZ$，而这是荒谬的。
  ] 
= 7.
  #answer[
    - 加法群的子群关系是显然的
    - 对于乘法：
      $
      (a_1 + b_1 sqrt(2))(a_2 + b_2 sqrt(2)) = (a_1 a_2 + 2 b_1 b_2) + (a_1 b_2 + a_2 b_1) sqrt(2) in ZZ[sqrt(2)]
      $
      因此对乘法也封闭。
    - $1 in ZZ[sqrt(2)]$ 显然。

    令 $overline(a + b sqrt(2)) = a - b sqrt(2)$，注意到：
    $
    (a + b sqrt(2))(overline(a + b sqrt(2))) = a^2 - 2 b^2
    $
    故只要 $a^2 = 2 b^2$，该元素即可逆，而这样的元素当然有无穷多个。
  ]
= 8.
  #answer[
    $
    &a u + b v = 1\
    =>& a^2 u + b (a v) = a\ 
    =>& a^2 (u^2) + b (a u v) = a u\ 
    =>& a^2 (u^2) + b (a u v) = 1 - b v\ 
    =>& a^2 (u^2) + b (a u v + v) = 1 \ 
    $
    这表明 $a^2 x + b y = 1$ 有解。同理可得 $a x + b^2 y = 1$ 有解，反复进行立得 $a^m x + b^n y = 1$ 有解。
    0
  ]

