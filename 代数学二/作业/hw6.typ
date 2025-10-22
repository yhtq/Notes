#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为4月9日）
#set heading(numbering: none)
= p33-35
  == 20
    首先注意到有自然的：
    $
    directLimit (M_i times N) tilde.eq (directLimit M_i) times N
    $
    因此由概念，有交换图表：
    $
    #align(center)[#commutative-diagram(
    node((0, 0), $M_i times N$, 1),
    node((0, 1), $M_i tensorProduct N$, 2),
    node((1, 0), $M times N$, 3),
    node((1, 1), $M tensorProduct N$, 4),
    node((0, 2), $directLimit (M_i tensorProduct N)$, 5),
    arr(1, 2, $$),
    arr(1, 3, $mu_i times 1$),
    arr(2, 4, $mu_i tensorProduct 1$),
    arr(3, 4, $$),
    arr(2, 5, $nu_i$),
    arr(5, 4, $exists! psi$)
    )]
    $
    这里：
    - $f_i$ 来自于可以验证 $M_i times N -> M times N -> M tensorProduct N$ 是双线性，进而由 $M_i tensorProduct N$ 产生
    - $psi$ 来自于正向极限，只需验证兼容性：
      $
      (mu_i tensorProduct 1) (mu_(i j) tensorProduct 1) = (mu_i mu_(i j)) tensorProduct 1 = mu_j tensorProduct 1  
      $
      利用了张量积的函子性
    - 直接验证 $psi$ 是同构：
      - 任取 $M tensorProduct N$ 中元素，其必形如：
        $
        mu_i (m_i) tensorProduct n = (mu_i tensorProduct 1)(m_i tensorProduct n) = psi(nu_i (m_i tensorProduct n))
        $
        因此 $psi$ 是满射
      - 假设 $psi(x) = 0$，$x$ 必形如 $nu_i (m_i tensorProduct n)$，进而：
        $
        0 = psi(nu_i (m_i tensorProduct n)) = (mu_i tensorProduct 1)(m_i tensorProduct n) = mu_i (m_i) tensorProduct n
        $
        这意味着任意从 $M times N$ 出发的双线性函数于 $mu_i (m_i) times n$ 的像为零，然而可以将 $M_i times N -> directLimit (M_i tensorProduct N)$ 作为双线性映射提升到 $M times N$，因此它于 $mu_i (m_i) times n$ 的像（恰好是 $mu_i (m_i) tensorProduct n$）为零
      证毕
  == 23
    这里 $B_J -> B_J'$ 的典范同态当然满足兼容性，而之前的习题证明了环作为模的正向极限自然地继承环结构，因此结论成立
  == 25
    任取 $M in Mod_A$，考虑 $Tor_1 (*, M)$ 产生的正合列：
    $
    Tor_2(N'', M) -> Tor_1(N', M) -> Tor_1(N, M) -> Tor_1(N'', M) \
    -> N' tensorProduct M -> N tensorProduct M -> N'' tensorProduct M -> 0
    $ 
    由 $N''$ 平坦，上述序列是：
    $
    0 -> Tor_1(N', M) -> Tor_1(N, M) -> 0 -> N' tensorProduct M -> N tensorProduct M -> N'' tensorProduct M -> 0
    $
    产生正合列：
    $
    0 -> Tor_1(N', M) -> Tor_1(N, M) -> 0
    $
    显然，中间两项一项为零蕴含另一项为零，因此结论正确
  == 27
    == i) $=>$ ii)
      任取主理想 $(x)$，有正合列：
      $
      0 -> (x) -> A -> A quo (x) -> 0
      $
      由于 $(x)$ 平坦，得正合列：
      $
      0 -> (x) tensorProduct (x) -> (x) -> (A quo (x))  tensorProduct (x) -> 0
      $
      注意到 $M tensorProduct I tilde.eq M quo(I M)$，上式化为：
      $
      0 -> (x) quo (x^2) -> (x) -> (A quo (x)) quo ((x) A quo (x)) -> 0
      $
      然而 $(x) A quo (x) = 0$，上式化为：
      $
      0 -> (x) quo (x^2) -> (x) -> A quo (x)  -> 0
      $
      给出 $(x) = (x^2)$，证毕
    == ii) $=>$ iii)
      先证明主理想是直和项。事实上，由 $(x^2) = (x)$ 立得：
      $
      exists k, x = x^2 k => x (1 - k x) = 0 => (k x) (1 - k x) = 0
      $
      如此，$k x in (x)$ 是幂等元。此外，有：
      $
      (x) = (k x^2) subset (k x) subset (x)
      $
      因此 $(x) = (k x)$，而幂等元生成的主理想当然是直和项。

      进一步，不妨设有限生成理想 $I$ 由若干幂等元 $e_i$ 生成，注意到：
      $
      (e, f) = (e + f - e f)
      $
      因此这样的理想也是主理想，证毕
    == iii) $=>$ i)
      任取有限生成理想 $I$，设 $A = I directSum I'$。注意到正合列：
      $
      0 -> I -> A -> A quo I -> 0\
      0 -> I -> I directSum I' = A -> I' -> 0
      $
      表明 $A quo I$ 作为模同构于 $I'$，而 $I'$ 作为 $A$ 的直和项是平坦的，继而恒有：
      $
      Tor_1 (A quo I, M) = 0, forall M in Mod_A
      $
      这就意味着所有模都平坦
  == 28
    - 布尔环中所有元素都幂等，当然是绝对平坦的
    - 若 $forall x, exists n space s.t. x^n = x$，则：
      $
      (x) supset (x^2) supset ... supset (x^n) = (x)
      $
      因此主理想当然都幂等
    - 环的满同态像同构于商环，而上面的 ii) 被商环所保持，因此成立
    - 任取 $alpha in m$，其中 $m$ 是极大理想，注意到：
      $
      (alpha) (alpha) = (alpha), (alpha) subset max(A)
      $
      由 Nakayama 知 $(alpha) = 0 => alpha = 0$
    - 前面已经叙述任取 $x in A$，存在 $k$ 使得：
      $
      k x^2 = x => x (1 - k x) = 0 
      $
      自然要么 $1 - k x = 0$ 进而 $x$ 可逆，要么 $1 - k x$ 成为 $x$ 的零因子
= p43
  == 10
    === i)
      任取 $M in Mod_(Inv(S) A)$，它可以看作 $A$ 的模，进而也可写作 $Inv(S) M$，进而任取 $Mod_(Inv(S) A)$ 中正合列写作:
      $
      Inv(S) E
      $
      进而：
      $
      (Inv(S) E) tensorProduct (Inv(S) M) = Inv(S) (E tensorProduct_A M)
      $
      由于 $* tensorProduct_A M$ 是正合函子，$Inv(S)$ 也是，进而上面的张量积是正合的，故 $Inv(S) M$ 确实是平坦模
    === ii)
      - 设 $A$ 绝对平坦，则 $A_m$ 也绝对平坦，且是局部环，进而 $A_m$ 是域
      - 设 $A_m$ 总是域，注意到平坦性是局部性质，任取 $M in Mod_A$ 只需证明 $M_m$ 在 $Mod_(A_m)$ 上平坦。\
        然而 $A_m$ 是域，其上的模就是线性空间，总存在基，进而是自由模，从而平坦。
  == 11
    首先，注意到素理想/极大理想都包含 $Re$，进而与 $A quo Re$ 中理想有保序的一一对应。同时：
    $
    Spec(A) tilde.eq Spec(A quo Re)
    $
    因此在本题中不妨直接设 $Re = 0$
    === i) $=>$ ii)
      任取 $p$ 是素理想，考虑 $A quo p$ 它是绝对平坦的整环。\
      而由前面的习题，其中元素要么可逆，要么有零因子。这表明除了 $0$ 之外的元素均可逆，进而是域。
    === ii) $=>$ iii)
      前面的习题证明了单点集闭当且仅当对应素理想极大，当然正确
    === i) $=>$ iv)
      任取两点 $p_1, p_2$，注意到 $p_1, p_2$ 互不包含，取：
      $
      x in p_1 - p_2
      $
      根据前面的习题，存在幂等元 $e$ 使得 $(e) = (x)$，此时：
      $
      e(1-e) = 0 => forall p in Spec(A), e in p, 1 - e in p "两者恰有一个成立"
      $
      因此：
      - $p_1 in V(e), p_2 in.not V(e) => p_2 in V(1-e)$\
      - $V(e) union V(1-e) = emptyset$
      各自取补便给出不相交的开邻域，证毕
    === iv) $=>$ iii), iii) $=>$ ii)
      显然
    === ii) $=>$ i)
      任取极大理想 $m$，注意到条件给出 $m$ 不含任何素理想，进而 $A_m$ 没有除 $m A_m$ 外的素理想，这意味着 $m A_m$ 中元素全部幂零，然而 $(Re)_m = (Inv(A - m))Re = 0$ 可得 $m A_m$ 中无非零幂零元，进而 $A_m$ 是域，由之前习题知结论成立
    接下来，证明：
    - 紧性：之前的习题已经证明
    - 整体不连通：设 $S subset Spec(A)$ 不是单点集，往证其不连通。设其中有两元素 $p_1, p_2$，并取 $x in p_1 - p_2$，仿照之前习题的构造给出：
      $
      A tilde.eq A quo (e) times A quo (1-e)
      $
      之前的习题证明了 $Spec(A)$ 成为两个开子空间的不交并，而 $S$ 分别落在两个开子空间中（$p_1 in X_1, p_2 in X_2$），故不连通
  == 12
    首先验证 $T(M)$ 是子模。\
    - 加法封闭：设 $x, y in T(M)$，从而存在 $u, v != 0$ 使得：
      $
      u x = 0 = v y => u v(x + y) = 0
      $
      由于 $A$ 是整环 $u v !=0$，上式即表明 $x + y in T(M)$
    - 乘法封闭：设 $x in T(M), a in A$，从而存在 $u != 0$ 使得：
      $
      u x = 0 => u (a x) = 0
      $
      上式即表明 $a x in T(M)$
    === i)
      设 $M quo T(M) $ 中存在元素 $x + T(M) M$ 使得：
      $
      exists a in A, a(x + T(M) ) = (a x) + T(M)  = 0
      $
      从而 $a x in T(M)  => exists b in A, b a x = 0 => x in T(M) => x + T(M) = 0$
      证毕
    === ii)
      任取 $m in T(M)$，则存在 $a != 0 in A$ 使得：
      $
      a m = 0 => 0 = f(a m) = a f(m) => f(m) in T(M)
      $
      证毕
    === iii)
      - 注意到 $T(*)$ 函子作用于函数只是原本函数的限制，当然保持单射性
      - 只需验证 $T(M') ->^f' T(M) ->^g' T(M'')$ 处正合性，其中 $f$ 是单射。
        - 由原本的正合性，$g compose f = 0$ 成立，当然它们的限制也成立 $g' compose f' = 0$
        - 只需证明 $ker g' subset im f'$，任取 $x in ker g' = T(M) inter ker g = T(M) inter im f$，因此可设：
          $
          x = f(m'), a f(m') = f(a m') = 0, a != 0
          $
          由于 $f$ 是单射，上式表明 $a m' = 0 => m' in T(M') => x in im f'$，证毕
    === iv)
      记 $S = A - {0}, P(S)$ 为 $S$ 的幂集。在 $P(S)$ 上按照包含关系定义偏序，则它是一个正向指标集。\
      定义：
      $
      M_I = A (1/(product I)), forall I in P(S)
      $
      容易看出 $I <= J <=> I subset J => M_J = A (1/(product J)) supset A (product J - I) (1/(product J)) = A (1/(product I)) = M_I$\
      因此可取 $mu_(i j)$ 是通常的嵌入同态，当然满足兼容性。\
      如此给出了一个模的正向系统。事实上之前习题证明了：
      $
      directLimit M_i tilde.eq union_i M_i = K
      $
      因此只要证明：
      $
      T(M) &= ker (M -> K tensorProduct_A M) \
            &= ker (M -> (directLimit M_i) tensorProduct_A M) \
            &= ker (M -> directLimit (M_i tensorProduct_A M))
      $
      正向极限的核中的元素应当满足：
      $
      mu_K (1_K tensorProduct m) = 0 <=> exists I in P(S), forall J >= I, mu_(I J) (1_I tensorProduct m) = 0
      $
      然而我们定义的 $mu$ 都是嵌入，进而 $1_I tensorProduct m = 0$，当且仅当：
      $
      1/(product I) tensorProduct_A (product I) m = 0 
      $
      - 一方面，假设上式成立，构造双线性映射：
        $
        funcDef(f, M_I times M, K, (a/(product I), m') , a m')
        $
        上式表明：
        $
        0 = f(1/(product I), (product I) m) = (product I) m
        $
        这就意味着 $m in T(M)$，证毕
      - 另一方面，假设 $m in T(M)$，选出一个非零的零化子 $a$，则 $(product {a}) m = 0$，当然有上式成立
      证毕
  == 14
    将 $M quo alpha M$ 视作 $A quo alpha$ 环，由局部化和商的交换性，将有 $M quo alpha M$ 在 $A quo alpha$ 的所有极大理想处都是零，导出 $M quo alpha M = 0$，证毕
  == 15
    设 $x_i$ 是一组生成元，$e_i$ 是一组基，定义：
    $
    funcDef(phi, F, F, e_i, x_i)
    $
    它是满射。为了证明它是单射，考察正合列：
    $
    0 -> ker phi -> F ->^(phi) F -> 0
    $
    注意到 $F$ 是自由模，当然投射，正合列中间三项中后两项投射，其余一项也投射，因此 $ker phi$ 投射，给出泛性质：
    $
    #align(center)[#commutative-diagram(
        node((0, 0), $F$, "1"),
        node((0, 1), $F$, "2"),
        node((1, 0), $ker phi$, "3"),
        arr("2", "1", $phi$, surj_str),
        arr("3", "2", $exists psi' $),
        arr("3", "1", $psi $),)]
    $ 
    这里 $psi$ 取自然的嵌入，当然有：
    $
    0 = phi compose psi' = psi
    $
    然而 $psi$ 是嵌入，给出 $ker phi = 0$，证毕

    若有元素少于 $n$ 个的生成元集，将某个元素重写若干遍后可得 $n$ 元生成元集，进而是基，其中元素均线性无关，这是荒谬的
  == 16
    === i) $=>$ ii)
      根据书上命题，此时 $Spec(A)$ 中每个素理想成为 $Spec(B)$ 中某个素理想的逆像，当然 $phi^*$ 是满的
    === ii) $=>$ iii)
      此时 $m$ 成为某个素理想的逆像，当然不可能有 $phi(m) = B$
    === iii) $=>$ iv)
      任取 $x != 0 in M$，只需证明 $(A x)_B != 0$，不妨就设 $M = A x$ \
      注意到 $alpha := Ann(x) != A$，且 $M tilde.eq A quo alpha$，此时：
      $
      M_B tilde.eq (A quo alpha) tensorProduct_A B tilde.eq B quo (alpha B) = B quo (phi(alpha))
      $
      将 $alpha$ 扩成极大理想 $m$，注意到 $phi(alpha) subset phi(m) != B$，因此上式非零，证毕
    === iv) $=>$ v)
      考虑正合列：
      $
      0 -> ker phi -> M ->^phi  M tensorProduct_A B
      $
      既然 $B$ 是平坦代数，将有正合列：
      $
      0 -> ker phi tensorProduct_A B -> M tensorProduct_A B ->  (M tensorProduct_A B) tensorProduct_A B
      $
      由之前的习题，后项是单射，进而 $ker phi tensorProduct_A B = 0 => ker phi = 0$（运用条件）
    === v) $=>$ i)
      取 $M = A quo alpha$，有单射：
      $
      A quo alpha -> A quo alpha tensorProduct_A B tilde.eq B quo (alpha B) = B quo (phi(alpha))
      $
      这就意味着 $Inv(phi)(phi(alpha)) = alpha$，否则 $Inv(phi)(phi(alpha)) - alpha$ 将落入上面映射的 $ker$
  == 17
    任取 $Mod_A$ 正合列 $E$，只需证明 $E tensorProduct_A B$ 正合\
    事实上，当然有 $E tensorProduct_A C$ 正合，同时：
    $
    E tensorProduct_A C = E tensorProduct_A (B tensorProduct_B C) tilde.eq (E tensorProduct_A B) tensorProduct_B C
    $
    由于 $C$ 在 $B$ 上忠实平坦，故 $(E tensorProduct_A B) tensorProduct_B C$ 正合当且仅当 $E tensorProduct_A B$ 正合，证毕
  == 19
    #let Supp = math.op("Supp")
    === i)
      熟知 $M = 0$ 当且仅当在所有素理想处的局部化为零，即 $Supp(M) = emptyset$
    === ii)
      也就是证明
      $
      alpha subset.not p <=> (A quo alpha)_p = 0
      $
      事实上：
      $
      (A quo alpha)_p = (A_p) quo (alpha_p) 
      $
      显然：
      - $alpha subset.not p => alpha_p = A_p => (A quo alpha)_p = 0$
      - $(A quo alpha)_p = 0 => alpha_p = A_p => exists x in A - p, a in alpha, x (a - 1) = 0 in p => x in p or a - 1 in p => a - 1 in p => a in.not p => alpha subset.not p$
      得证
    === iii)
      注意到局部化是正合函子，将有正合列：
      $
      0 -> M'_p -> M_p -> M''_p -> 0
      $
      当然有 $M_p = 0 <=> M'_p = 0 and M''_p = 0$，取否即得原命题
    === iv)
      局部化与直和交换，因此：
      $
      0 = (sum M_i)_p = sum (M_i)_p <=> forall i, (M_i)_p = 0 
      $
      取否即可
    === v)
      $
      Supp(M) = Supp(sum_i A x_i) = union_i Supp(A x_i) \
      = union_i Supp(A quo Ann(x_i)) = union_i V(Ann(x_i)) \
      = V(sum_i Ann(x_i)) = V(Ann(sum_i x_i)) = V(Ann(M))
      $
    === vi)
      $
      0 = (M tensorProduct N)_p = M_p tensorProduct N_p <=> M_p = 0 or N_p = 0
      $
      利用 $A_p$ 是局部环
    === vii)
      $
      (M quo alpha M)_p = 0 <=> M_p = alpha_p M_p
      $
      利用局部环和 Nakayama 引理，上式等价于 $alpha_p = A_p <=> (A quo alpha)_p = 0$ 或 $M_p = 0$，进而：
      $
      Supp(M quo alpha M) = Supp(M) inter Supp(A quo alpha) \
      = V(alpha) inter V(Ann(M)) = V(alpha + Ann(M)) 
      $
    === viii)
      先设 $M = A x$
      $
      Supp(B tensorProduct M) = Supp(B tensorProduct (A quo Ann(x))) \
      = Supp(B quo Ann(x) B) = V(Ann(x) + Ann(B)) = V(Ann(M)) inter V(ker f)\
      = Supp(M) inter V(ker f)
      $
      表明这些素理想一定包含 $ker f$ 进而上式就是 $f^(* -1)(Supp(M))$
= p78
  == 1
    === i
      注意到有递增子模链：
      $
      ker mu <= ker mu^2 <= ... <= ker mu^n <= ...
      $
      由条件知最终将稳定，可设 $ker mu^n = ker mu^(n+1)$，因此：
      $
      mu^(n+1) (m) = 0 <=> mu (mu^n (m)) = 0 <=> mu^n (m) = 0
      $
      然而 $mu$ 是满射，$mu^n$ 也是，进而上式表明 $ker mu = 0$，证毕
    === ii
      注意到有递降子模链：
      $
      M >= im mu >= im mu^2 >= ... >= im mu^n >= ...
      $
      由条件知最终稳定，可设 $im mu^n = im mu^(n+1) := M'$\
      然而注意到：
      $
      im mu^n = mu(im mu^(n-1)) \
      im mu^n = im mu^(n+1) = mu(im mu^(n))\
      mu(im mu^(n-1)) = mu(im mu^(n)) => im mu^(n-1) = im mu^n
      $
      （最后利用了 $mu$ 是单射）\
      这表明 $n$ 可以一直降低，最终说明 $im mu = M$，证毕
  == 2
    对 $M$ 的任意子模 $M'$，设：
    $
    Sigma = {M'' subset M' | M'' "是有限生成子模"}
    $
    条件表明它将有极大元。设极大元为 $M''$，然而往有限生成模中扩充任何元素都还是有限生成的，因此 $M''$ 只能为 $M'$，表明 $M$ 的所有子模都有限生成
  == 3
    由熟知的同构：
    $
    M quo N_1 times M quo N_2  tilde.eq M quo N_1 inter N_2 
    $
    及有限直积保持 Noether/Artin 知结论成立
  == 4
    此时必有 $M$ 有限生成，进而可设 $M = sum_i A x_i$，有：
    $
    Ann(M) = sect_i Ann(x_i)\
    A quo Ann(M) tilde.eq product_i A quo Ann(x_i) tilde.eq product_i A x_i
    $  
    而 $A x_i$ 作为 Noether 模的子模有限生成，进而 $A quo Ann(x_i)$ 作为有限 $A-$代数是 Noether 的，作为环也是，由上题结论知结果成立

    若 $M$ 是 Artin 的，结果当然未必，例如设 $p$ 是素数，则 $ZZ[1/p] quo ZZ$ 作为 $ZZ$ 模 Artin，并且没有非零零化子，但 $ZZ$ 不是 Artin 的
  == 5
    注意到子空间 $Y$ 中开集均形如 $A inter Y$，其中 $A$ 是 $Y$ 中开集，当然将满足升链条件。

    为了证明拟紧，任取一族开覆盖 $union E = X$，考虑：
    $
    Sigma = {union E' | E' "是" E "的有限子集"}
    $
    $sigma$ 将是开集族，由升链条件，$Sigma$ 有极大元 $E'$，容易验证 $union E' = X$，否则可以再添加一个点的覆盖到 $E'$ 使得覆盖的空间更大，与极大性矛盾
  == 6
    == i) $=>$ iii)
      已经证明每个子空间都 Noether，而 Noether 空间都拟紧，因此结论成立
    == iii) $=>$ ii)
      显然
    == ii) $=>$ i)
      任取开集的升链：
      $
      A_1 <= A_2 <= ... <= A_n <= ...
      $
      则 ${A_i}$ 构成开子空间 $union_i A_i$ 的开覆盖，将有有限开覆盖。由于这族开集是全序的，相当于只需一个 $A_n$ 即可覆盖，蕴含 $A_m = A_n, forall m >= n$，证毕
  == 7
    设 $Sigma$ 为所有不能写成有限个不可约分支的并的闭子空间，注意到这是一族闭集，假设它非空，由降链条件存在极小元 $Y$。\
    显然 $Y$ 不是空集，任选 $x in Y$ 以及包含它的不可约分支 $Gamma subset Y$，则 $Y - Gamma$ 可写成有限个不可约分支的并，继而再加上 $Gamma$ 便将 $Y$ 写成了有限个不可约分支的并，矛盾！\
    因此原集合是空集

    进一步，设 $X = union_i X_i$，任取其中一个不可约分支 $C$，将有：
    $
    C = union_i (C inter X_i)
    $
    然而 $C$ 不能写成其中有限个非空闭集的并，继而：
    $
    exists i, C = C inter X_i
    $
    再由极大性，$C = X_i$，证毕
  == 8
    显然 $Spec(A)$ 中闭集都是 $V(alpha), alpha$ 是环中理想。理想的升链条件将导出闭集的降链条件，因此 $Spec(A)$ 是 Noether 的

    反面不成立，例如令 $A = QQ[x_1, x_2, ..., x_n, ...] quo (x_1^2, x_2^2, ..., x_n^2, ...)$，注意到它当然不是 Noether 环，同时 $Spec(A)$ 同胚于 $Spec(A quo Re)$\
    但另一方面，$A$ 中所有不是单位的元素都幂零，因此 $A quo Re tilde.eq QQ$ 是域，素谱是单点集，当然是 Noether 空间
  == 9
    前面已经证明了极小素理想与不可约分支的一一对应，因此结论成立
  == 10
    熟知 Noether 模有限生成，此时有：
    $
    Supp(M) = V(Ann(M))
    $
    因此确实是闭集，只需验证其中降链条件。事实上，若存在其中无穷下降的闭集链：
    $
    V(Ann(M)) := V(I_0) > V(I_1) > ... > V(I_n) > ...
    $
    当然有 $Ann(M) := I_0 < I_1 < ... < I_n$\
    此时，将有上升的子模链：
    $
    0 = I_0 M <= I_1 M <= ... <= I_n M <= ...
    $
    注意到：
    $
    Supp(M quo I_n M) = V(I_n + Ann(M)) = V(I_n) 
    $
    因此 
    $
    I_n = I_(n+1) => Supp(M quo I_n M) = Supp(M quo I_(n+1) M) => V(I_n) = V(I_(n+1))
    $
    从而子模升链中每项严格上升，与 Noether 模条件矛盾！
    