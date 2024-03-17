#import "../../template.typ": *
#show: note.with(
  title: "抽象代数/代数学基础",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined: false
)
#let chapterThree = [
  = 模
    == 基本概念
      类比线性空间是域作用于交换群，模是环作用于交换群
    == 主理想整环上有限生成模的分类定理
      本节中，所有的 $R$ 都是 PID
      #lemma[][
        设 $p, q in R$ 是不相伴的素元，$r, s in NN$，则：
        - 若 $M tilde.eq R$，则 $quotient(M, p^r M) tilde.eq quotient(R, (p^r))$
        - 若 $M tilde.eq quotient(R, p^s R)$，则：
          $
          p^r M = cases(
            quotient(p^r R, p^s R) space& r <= s,
            {0} & r > s
          )
          $
        - 若 $M tilde.eq quotient(R, q^s R)$，则：
          $
          p^r M = M
          $
      ]
      #proof[
        + 
        + 
        + 注意到在 PID 中，$(p^r, q^s) = (1)$。设 $a p^r + b q^s = 1$，则 $m = a m p^r + b m q^s in (p^r + (q^s)) M = p^r M$
      ]
  = 域
    == 基本概念
      域的定义前面已经给出了。对于域的考察，我们从最简单的域开始，即特征为素数的素域，再从它们出发构造新的域。
      #definition[特征][
        对域 $F$，若存在正整数 $n$ 使得:
        $
        n dot 1 = 0
        $
        则称满足要求的最小整数 $n$ 为域 $F$ 的特征，记作 $"char"(F)$，否则称 $F$ 的特征为 $0$。
      ]
      #corollary[][
        设 $"char"(F) = n$，则 $forall x in F$，有 $n dot x = 0$
      ]
      #theorem[][
        域的特征一定是素数
      ]
      #proof[
        $(n m) dot 1 = 0 <=> (n dot 1)(m dot 1) = 0 <=> n dot 1 = 0 or m dot 1 = 0$，表明域的特征一定不可分解，进而一定是素数。
      ]
      #corollary[][
        所有特征为 $p$ 的域都包含 $ZZ_p$，特征为 $0$ 的域都包含 $QQ$
      ]
      #lemma[][
        域间的同态一定是单射
      ]
      #proof[
        显然域同态一定是环同态，进而 $ker(phi)$ 是 $F$ 的理想，由于 $F$ 是域，$ker(phi)$ 只能是 $F$ 或者 $\{0\}$，而 $phi$ 不可能是 $0$ 映射，因此 $ker(phi) = \{0\}$，即 $phi$ 是单射。
      ]
      #remark[][
        这个引理给出若我们有一个域同态 $F -> K$，则 $F$ 可以看作 $K$ 的子域，进而我们可以将 $K$ 看作 $F$ 的扩张域，这就引出了域扩张的概念。
      ]
    == 域扩张
      从概念上扩张关系基本就是子域关系，只是我们在研究域时往往从小至大，因此有了反向的扩张关系，
      #definition[域扩张][
        设 $F$ 是 $K$ 的子域，则称 $K$ 是 $F$ 的一个域扩张，并称 $F$ 是一个基域。若 $F subset E subset K$ 都是域，则称 $E$ 是中间域。

        此时，$K$ 是一个 $F$ 向量空间，进而称域扩张 $quotient(K, F)$ 的次数：
        $
        [K : F] := dim_F K
        $
      ]
      #theorem[][
        若 $F subset E subset K$，则：
        $
        [K : F] = [K : E] [E : F]
        $
      ]
      #proof[
        设 $m = [K : E], n = [E : F] $\
        找 $alpha_1, alpha_2, ..., alpha_m$ 是 $K$ 在 $E$ 上的一组基，$beta_1, beta_2, ..., beta_n$ 是 $E$ 在 $F$ 上的一组基，\
        则对任意 $k in K$，存在 $lambda_i in E$，使得：
        $
        k = sum_(i = 1)^m lambda_i beta_i
        $
        而对 $lambda_i in E$，存在 $mu_(i j) in K$，使得：
        $
        lambda_i = sum_(j = 1)^n = mu_(i j) alpha_j
        $
        进而：
        $
        k = sum_(i = 1)^m sum_(j = 1)^n mu_(i j) alpha_j beta_i
        $
        表明 $alpha_i, beta_j$ 构成一组生成元，只需证明它们线性无关，事实上：
        $
        0 = sum_(i = 1)^m sum_(j = 1)^n mu_(i j) alpha_j beta_i => sum_(i = 1)^m (sum_(j = 1)^n mu_(i j) alpha_j) beta_i = 0 \
        => sum_(j = 1)^n mu_(i j) alpha_j = 0, space forall i \
        => mu_(i j) = 0, space forall i, j
        $
      ]
      #example[][
        设 $F$ 是域，则 $F[x]$ 是主理想整环。取其一个不可约元 $p(x)$，则 $quotient(F[x], (p(x)))$ 是域，它当然 $F$ 的一个域扩张，且 $[quotient(F[x], (p(x))) : F] = deg(p(x))$\
        更重要的是以下引理：
        #lemma[][
          令 $theta = x + (p) in quotient(F[x], (p(x)))$
          则它将成为方程
          $
          p(z) = 0, z in quotient(F[x], (p(x)))
          $
          的根
        ]
        #proof[
          设 $p(x) = sum_i a^i x^i$，则：
          $
          p(theta) = sum_i a^i (x + (p))^i = sum_i a^i x^i + (p) = p(x) + (p) = 0
          $
        ]
        表明我们好像真的是添加了一个根。
      ]
      #remark[][
        $quotient(RR, (x^2 + 1))$ 按照上面的介绍成为了 $RR$ 的一个扩张域，它就是 $CC$。但事实上 $CC$ 中有多项式 $x^2 + 1$ 的两个而不是一个根
      ]
      #definition[][
        设 $F subset K$ 都是域，$a_i in K$，则记：
        $
        F(a_1, a_2, ..., a_n) 
        $
        为包含 $F, a_i$ 的 $K$ 中的最小子域，称为 $F$ 和 $a_i$ 的生成域。\
        由有限个元素生成的域称为有限生成\
        特别的，单个元素生成的域成为单扩张
      ]
      #example[][
        - $QQ(sqrt(2), sqrt(3)) = QQ(sqrt(2) + sqrt(3))$
      ]
      #theorem[][
        设 $K = F(alpha)$，则以下两者有且只有一个成立：
        - $1, alpha, alpha^2, ..., alpha^n, ...$ 在 $F$ 上全部线性无关，进而 $F(alpha) tilde.eq "Frac"(F[x])$，此时称 $alpha$ 在 $F$ 上超越
        - $1, alpha, alpha^2, ..., alpha^n, ...$ 在 $F$ 上线性相关，进而使得 $f(alpha) = 0$ 的 $F$ 上多项式构成一个理想，进而是主理想。取其唯一生成元 $m(x)$，则称 $m(x)$ 为 $alpha$ 在 $F$ 上的极小多项式，它一定不可约，记作 $m_alpha(x)$，并有：
          $
          F(alpha) tilde.eq quotient(F[x], (m_alpha (x)))
          $
          此时称 $alpha$ 在 $F$ 上代数（algebraic）
      ]
      #proof[
        - 对于情况一，构造环同态：
          $
          funcDef(phi, F[x], K, f(x), f(alpha))
          $
          由题设，$phi$ 是单射，进而它可以延拓到 $phi': Frac(F[x]) -> K$，构成域上的同态，当然是单射，因此：
          $
          Frac(F[x]) tilde.eq im(phi') = K
          $
        - 对于情况二，只需证明 $m_alpha (x)$ 确实不可约。事实上：
          $
          funcDef(phi, F[x], K, f(x), f(alpha))
          $
          给出环上的满同态，进而：
          $
          quotient(F[x], ker(phi)) tilde.eq im(phi) = K
          $
          而 $K$ 是域，同时 $ker(phi) = (m_alpha (x))$，表明 $m_alpha (x)$ 确实不可约。 
      ]
    #definition[][
      设 $K = F(alpha_1, alpha_2, ..., alpha_i, ...)$，若每一个元素都是代数的，则称 $quotient(K, F)$ 是代数的，否则称为超越的
    ]
    #proposition[][
        以下两者等价：
        - $[K : F]$ 有限
        - $quotient(K, F)$ 是有限生成且代数的
    ]
    #proof[
      - $1 => 2$ 是容易的，同时我们有：
        $
        deg(m_alpha (x)) = [F(alpha), F] | [K, F]
        $
      - 另一侧略显复杂：
        #lemma[][
          设 $F subset E subset K$，$alpha in K$，$alpha$ 在 $E, F$ 上的极小多项式分别为 $m_E (x), m_F (x)$，则：
          $
          m_(F) (x) = 0 in E => m_(E) (x) | m_(F) (x) in E[x]
          $
        ]
        #corollary[][
          $[E(alpha) : E] <= [F(alpha): F]$
        ]
        #definition[][
          设 $F subset E_i subset K$，则记：
          $
          E_1 E_2 ... E_n
          $
          为包含 $E_i$ 的最小的域，称为 $E_i$ 的复合
        ]
        #lemma[][
          设 $[E_i, F]$ 有限，则：
          $
          [E_1 E_2 : F] <= [E_1 : F] [E_2 : F]
          $
        ]
        #proof[
          设 $E_1 = F(alpha_1, alpha_2, ..., alpha_n)$，则由上面的引理：
          $
          [E_2(alpha_1) : E_2] <= [F(alpha_1) : F]\
          [E_2(alpha_1, alpha_2) : E_2(alpha_1)] <= [F(alpha_1, alpha_2) : F(alpha_1)]\
          $
          由于域扩张的次数可乘，左右侧全部乘起来得到：
          $
          [E_2(alpha_1, alpha_2, ..., alpha_n) : E_2] <= [F(alpha_1, alpha_2, ..., alpha_n) : F]\
          <=> [E_1 E_2 : E_2] <= [E_1 : F] \
          => [E_1 E_2 : F] = [E_1 E_2 : E_2] [E_2 : F] <= [E_1 : F] [E_2 : F]
          $
        ]
        由这些引理，设 $K = F(alpha_1, alpha_2, ..., alpha_n)$，则：
        $
        [K : F] = [F(alpha_1) F(alpha_2) ... F(alpha_n) : F]<= product [F(alpha_i) : F]
        $
        证毕
    ]
    #corollary[代数闭包][
      设 $alpha, beta in K$ 在 $F$ 中代数，则：
      $
      alpha plus.minus beta, alpha beta, alpha / beta
      $
      都在 $F(alpha, beta)$ 之中，由上面的定理这是有限扩张，进而这些元素都在 $F$ 中代数，从而 $K$ 中所有在 $F$ 中代数的元素构成 $K$ 的一个子域，称为 $K$ 在 $F$ 上的代数闭包
    ]
    #theorem[][
      若 $quotient(K, E)$ 与 $quotient(E, F)$ 都是代数的，则 $quotient(K, F)$ 也是代数的
    ]
  == 分裂域
    #definition[分裂域][
      给定域 $F$ 以及其上的多项式 $f in F[x]$（这里并不要求不可约）。一个域扩张 $quotient(K, F)$ 称为 $f(x)$ 的分裂域，如果：
      - $f(x)$ 在 $K[x]$ 中可以写成一次多项式的乘积，或者说恰有 $deg f$ 个根 $alpha_i$
      - $K = F[alpha_1, alpha_2, ..., alpha_(deg f)]$
     ]
     #remark[][
        设 $F <= E <= K, f(x) in F[x]$，$f(x)$ 在 $F$ 上的分裂域是 $K$，则它在 $E$ 上的分裂域当然也是 $K$。
     ]<cor1>
     #theorem[][
      域扩张一定是有限扩张。更进一步，$f(x) in F[x]$，分裂域为 $K$，则：
      $
      [K : F] <= n!
      $
     ]
     #proof[
      对 $f(x)$ 的次数归纳，假设 $deg(f) < n$ 的情形都已成立。\
      设 $f(x) = p(x)k(x)$，其中 $p(x)$ 不可约。令：
      $
      E = quotient(F[x], (p(x)))
      $
      在 $E$ 中，$p(x) in E[x]$ 当然有根，因此 $f(x)$ 也有根，设：
      $
      f(x) = (x - theta)g(x)
      $
      由归纳法，存在分裂域：
      $
      quotient(K, E)
      $
      满足：
      $
      [K : E] <= (n-1)!
      $
      从而当然 $quotient(K, F)$ 是 $f(x)$ 的分裂域，且：
      $
      [K : F] <= n!
      $
     ]
     #example[分圆域][
      域 $QQ$ 上，多项式 $x^n - 1$ 的分裂域称为 $n$ 次分圆域。
     ]
     #lemma[][
      设 $eta$ 是域同构，$p(x)$ 是不可约多项式，则 $eta(p(x))$ 当然也是不可约多项式，进一步：
      $
      quotient(F[x], (q(x))) tilde.eq quotient(eta(F[x]), (eta(p(x))))
      $
     ]
     #example[][
      - $a + b sqrt(2) -> a - b sqrt(2)$ 是 $Q[sqrt(2)]$ 的自同构
      $Q((sqrt(5+sqrt(2)))) tilde.eq quotient(QQ(sqrt(2)), (x^2 - 5 -sqrt(2))) tilde.eq quotient(QQ(sqrt(2)), (x^2 - 5 +sqrt(2))) tilde.eq Q((sqrt(5-sqrt(2))))$
     ]
     #lemma[][
      设 $eta$ 是域同构，$f(x) in F[x], f'(x) = eta(f(x))$。设 $E, E'$ 分别是 $f(x), f'(x)$ 在各自域上的分裂域，那么存在（不一定唯一）同构 $sigma$ 使得两个分裂域同构
     ]
     #proof[
      我们的思路是给出一个标准的分裂域构造，再证明它们的一致性。\
      我们证明加强的命题：
      #lemma[][
        设 $eta:F -> F'$ 是同构，$E, E'$ 是 $E, F'$ 的一个扩域使得 $E$ 是 $f(x) in F[x] $，某些根生成，$f'(x) = eta(f(x)) in F'[x]$ 在其中分裂，则存在同态 $sigma'$ 将 $E$ 嵌入 $E'$
      ]
      #proof[
      ]
     ]
     #theorem[][
      设 $F <= E, E' <= K$, $E, E'$ 都是 $f(x) in F[x]$ 在 $F$ 上的分裂域，则：
      $
      E = E'
      $
     ]
     #corollary[][
      设 $F <= E <= K$，$sigma$ 是 $K$ 上的自同构，$E$ 是某个分裂域，且 $sigma|_F = id$，则：
      $
      sigma(E) = E
      $
     ]<lemma1>
  == 正规扩张
    #definition[正规扩张][
      一个代数域扩张 $quotient(K, F)$ 称为正规扩张，如果：
      - 对 $F[x]$ 上所有不可约多项式 $p(x)$，只要它在 $K$ 中有一个根，便有所有（等于次数）的根
    ]
    这个条件看似很强，但事实上并不然，下面的定理便说明了这点
    #theorem[][
      一个有限域扩张 $quotient(K, F)$ 是正规扩张当且仅当它是某个多项式 $f(x)$ 的分裂域
    ]
    #proof[
      - 设 $K = F(alpha_i)$ 是正规扩张，显然它就是 $f(x) = product_i m_(alpha_i) (x)$ 的分裂域
      - 另一侧是不平凡的。设 $K$ 是 $f(x)$ 的分裂域，$p(x)$ 是某个不可约多项式，它在 $K$ 中有根 $alpha$。设 $L$ 是 $p(x)$ 在 $K$ 中的分裂域，往证：
      $
      L = K
      $
      - 首先，$K <= L$ 是显然的。
      - 取 $beta in L$ 是另一个 $p(x)$ 在 $L$ 中的根（若 $p$ 是一次多项式，结论是显然的），我们发现 $L$ 将同时成为 $F(alpha), F(beta)$ 的分裂域，因此：
      $
      F(alpha) tilde.eq F(beta)
      $ 
      并且诱导出 $L$ 上非平凡自同构 $eta$, $eta(F(alpha)) = eta(F(beta)). eta|_F = id$。但由 @lemma1，这意味着：
      $
      eta(K) = K
      $
      而 $alpha in K => beta in K$，进而 $K$ 拥有 $p(x)$ 在 $L$ 中所有的根，从而结论成立
    ]
    #corollary[][
      设 $quotient(K, F)$ 是有限正规扩张，$F <= E <= K$，则 $quotient(K, E)$ 也是正规扩张（$quotient(F, E)$ 未必）
    ]
    #proof[
      回忆 @cor1，结论是容易的
    ]
    #definition[正规闭包][
      称 $quotient(L, K)$ 是 $quotient(K, F)$ 的正规闭包，如果：
      - $quotient(L, F)$ 是正规扩张
      - 若 $quotient(L', F)$ 也是正规扩张，$L' subset L$，则 $L = L'$
    ]
    #lemma[][
      有限域扩张 $quotient(K, F)$ 的正规闭包在同构意义下存在且唯一（具体的同构可能多种）
    ]
    #proof[
      - 存在性：设 $F = F(alpha_i)$，则取 $product_i m_(alpha_i) (x)$ 的一个分裂域 $L$，容易验证 $quotient(L, K)$ 就是正规闭包
      - 唯一性：设 $quotient(L', K)$ 是正规闭包，仍取上面的 $f(x)$，并取 $L$ 就是它的分裂域。显然 $f(x)$ 在 $L'$ 中分裂。由之前的定理，存在 $L -> L'$ 的嵌入。由定义的第二条，不应有比 $L'$ 更小的正规扩张，因此$L' tilde.eq L$
    ]
  == 可分扩张
    #definition[完全域][
      称一个特征 $p$ 的有限域 $F$ 为完全域，如果映射：
      $
      funcDef(sigma, F, F, x, x^p)
      $
      是同构。换言之，所有元素都可以开 $p$ 次根号
    ]
    #definition[形式导数][
      称域上多项式 $f(x)$ 的形式导数为 $f'(x)$，如同利用导数法则计算其导数一样。形式导数满足导数计算的所有性质。
    ]
    #proposition[重根判别法][
      域上多项式 $f(x)$ （在其分裂域中）有重根当且仅当 $f(x), f'(x)$ 不互素 
    ]<重根判别法>
    #proof[
      利用域上多项式环是主理想整环，$(f(x), f'(x)) = (d(x)) => d(x) | f(x), d(x) | f'(x)$
    ]
    #lemma[][
      完全域的代数扩张还是完全域
    ]
    #proof[
      设 $char F = p$。对任意 $alpha in K$，将有：
      $
      alpha^(1/p) in E = F(alpha)
      $
      从而回到了有限扩张情形。\
      我们有：
      $
      [E : sigma(E)][sigma[E] : sigma[F]] = [E : F][F : sigma(F)]
      $
      而显然 $[sigma[E] : sigma[F]]  = [E : F]$，因此：
      $
      [E : sigma(E)] = [F : sigma(F)]
      $
    ]
    #corollary[][
      $quotient(K, F)$ 是有限扩张，$K$ 完全 $=> K$ 完全。但在代数扩张下这个事实不成立。
    ]
    #definition[][
      若 $f(x) in F[x]$ 是不可约多项式，在其分裂域中：
      - 若 $f(x)$ 有重根，则称 $f$ 是不可分的
      - 若 $f(x)$ 无重根，则称 $f$ 是可分的
    ]
    #proposition[][
      不可约多项式 $f$ 不可分当且仅当 $f'(x) = 0$
    ]
    #proof[
      结合 $f$ 不可约和之前的重根判别法 @重根判别法，结论是容易的
    ]
    #corollary[][
      - 在特征 $0$ 的域中，所有不可约多项式都是可分的
      - 在特征 $p$ 的域中，所有不可分多项式都形如 $g(x^p)$，且完全域中没有不可分多项式
    ]
    #proof[
      (1) 是显然的，对于 (2)，令：
      $
      D(sum_i a_i x^i) = sum_i i a_i x^(i-1) = 0 => i a_i = 0 => i = 0 or a_i = 0
      $
      因此对于所有不是 $p$ 的倍数，则 $i != 0$，进而 $a_i = 0$

      同时，设 $F$ 是完全域，可设：
      $
      sum_i a_i x^(p i) = sum_i b_i^p x^(p i) 
      $
      注意到在特征 $p$ 的域中，一定有：
      $
      sum_i b_i^p x^(p i) = (sum_i b_i x^i)^p 
      $
      这与多项式不可约矛盾！
    ]
    #corollary[][
      在特征 $p$ 的域中，所有不可约多项式都形如：
      $
      g(x^(p^e))
      $
      其中 $g(x)$ 已经是可分不可约多项式。同时在 $g$ 的分裂域中，$f$ 恰有 $deg(g)$ 个不同的根。
    ]<零点个数>
    #proof[
      将上面的推论进一步进行，若已经可分就停止，若不可分就继续进行，最终由于次数有限一定可以得到类似的形式。

      对于后者，注意到：
      $
      g(x) = product_(i=1)^n (x - alpha_i)\
      f(x) == product_(i=1)^n (x^(p^e) - alpha_i) = product_(i=1)^n (x - alpha_i^(1/(p^e)))^(p^e)
      $
      从而结论成立
    ]
    #definition[][
      在代数扩张 $quotient(K, F)$ 中：
      - 若 $alpha in K$ 在 $F$ 中最小多项式可分/不可分，则称 $alpha$ 可分/不可分
      - 若所有元素都可分，则称域扩张可分，否则成为不可分
    ]
    #proposition[][
      给定域扩张 $quotient(K, E), quotient(E, F)$，若 $alpha$ 在 $quotient(K, F)$ 中可分，则在 $quotient(K, E)$ 可分
    ]
    #proof[
      由于两个域扩张中最小多项式有整除关系，结论是容易的
    ]
    #theorem[][
      - 设 $alpha$ 在 $F$ 可分，则 $F(alpha)$ 是可分扩张
      - 设代数扩张 $quotient(K, E), quotient(E, F)$ 可分，则扩张 $quotient(K, F)$ 也可分
    ]<可分扩张定理>
    #proof[
      这个定理是很不平凡的，先论述一点想法。我们可以找到一个域扩张的正规闭包 $M$，考虑所有同态 $phi: K -> M$ 且 $phi_F = id$ 构成的集合 $Hom_F (K, M)$，这个集合有着重要的功能。
      #lemma[][
        设 $K = F(alpha)$, $alpha$ 的最小多项式为 $m(x) = g(x^(p^e))$，其中 $g(x)$ 是可分不可约多项式，则：
        $
        |Hom_F (K, M)| = deg g(x) <= [F(alpha) : F]
        $
        取等当且仅当 $alpha$ 可分
      ]
      #proof[
        显然这样的同态由 $alpha$ 的像唯一确定。同时，由于 $phi(m(x)) = m(x)$，因此 $phi(alpha)$ 一定也是 $m(x)$ 的根。@零点个数 给出了这样零点的个数恰为 $deg g(x)$。同时，我们有：
        $
        [F(alpha) : F] = deg(m(x)) >= deg(g(x))
        $
        从而取等当且仅当 $m(x) = g(x)$，也即 $m(x)$ 可分，等价于 $alpha$ 可分
      ]
      #corollary[][
        设有限域扩张 $quotient(K, F)$ 与其正规闭包 $quotient(M, F)$，则有：
        $
        |Hom_F (K, M)| <= [K : F]
        $
        且取等当且仅当（两者等价）：
        + $K = F(alpha_1, alpha_2, ..., alpha_n)$ 且每个元素都可分
        + $quotient(K, F)$ 可分
      ]<lemma-1>
      #proof[
        注意到：
        $
        |Hom_F (F(alpha_1), M)| <= [F(alpha_1) : F]\
        |Hom_(F(alpha_1)) (F (alpha_1, alpha_2), M)| <= [F(alpha_1, alpha_2) : F(alpha_1)]
        $
        不难验证两边都满足乘性，因此：
        $
        |Hom_F (F (alpha_1, alpha_2), M)| <= [F(alpha_1, alpha_2) : F]
        $
        以此类推即得等价条件 1。对于 2，注意到任何不可分元素都一定会破坏等于号，因此结论也是对的。
      ]
      至此，我们证明了 @可分扩张定理 的第一部分。

      再考虑第二部分，如果扩张是有限扩张结论已经容易了，而我们对于可分扩张的要求是每个元素都可分，每个元素所带有的信息量是有限的。更严格的说，设 $alpha in K$，取它在 $E$ 中的最小多项式 $m_E (x)$。\
      $m_E (x)$ 的系数显然只有有限个，考虑这些系数构成的 $F$ 的有限扩张：
      $
        E' = F(a_1, a_2, ..., a_n)\
        K' = F(a_1, a_2, ..., a_n, alpha)
      $
      可以证明 $F -> E', E' -> K'$ 都是可分扩张，特别的，$alpha$ 可分 
    ]
    #theorem[有限域的分类][
      - 设 $F$ 是特征 $p$ 的域，则：
        $
          |F| = p^([F : ZZ_p])
        $
      - 给定有限域的元素个数 $n$，则在同构意义下存在唯一的域满足 $|F| = n$，一个典范是 $x^(p^n) - x in ZZ_p [x]$ 的分裂域
    ]
    #proof[
      1 是显然的。设 $|F| = p^n$，则乘法群 $F^times$ 的阶数为 $p^n - 1$，从而：
      $
      a^(p^n-1) = 1 <=> x^(p^n) - x = 0 space forall a in F
      $
      同时 $0$ 也是 $x^(p^n) - x = 0$ 的根，因此 $F$ 中所有元素恰为多项式 $x^(p^n) - x = 0$ 的根，因此 $F$ 就是它的分裂域。\
      反之，由于 $D(x^(p^n) - x) != 0$，故在它的分裂域它没有重根，进而它的分裂域至少有 $p^n$ 个元素。\

    ]
    #theorem[Primitive element theorem, 本原元定理][
      - 一个有限可分扩张一定可以由唯一元素生成
      - 设 $alpha, beta$ 代数且可分，则一定存在 $eta$ 使得 $F(alpha, beta) = F(beta)$
    ]<PET>
    #proof[
      只证明 2，从而 1 是显然的
      考虑 $eta = alpha + c beta$。事实上，可以感觉到对于绝大多数 $c$ 都成立，只需要躲开那些运气极差的部分。
      - 对于有限域，显然有限域都是完全域
        #lemma[][
          设 $|F| = p^n$，则 $F$ 中存在 $p^m$ 阶子域当且仅当 $m | n$，且这样的子域是一个分裂域，进而唯一
        ]
        #proof[
          由于扩域构成线性空间，必要性是显然。反之，注意到：
          $
          x^(p^n) - x = (x^(p^m) - x)(x^(p^n-1)-1)/(x^(p^m-1)-1)
          := f(x) g(x)
          $
          从而 $f(x)$ 的分裂域 $F_(p^m)$ 当然可以进一步分裂为 $f(x)g(x)$ 的分裂域 $F$，从而结论成立。
        ]
      - 假设 $F$ 是无穷域：
        设 $f, g$ 是 $alpha, beta$ 的极小多项式，并取 $E$ 为 $f g$ 的分裂域，域中 $f, g$ 的不同的根分别为：
        $
        alpha_1 = alpha, alpha_2, ..., alpha_n\
        beta_1 = beta, beta_2, ..., beta_m
        $
        我们希望对所有的 $i, k$ 和不等于 $1$ 的 $j$，都有：
        $
        alpha_i + c beta_1 eq.not alpha_k + c beta_j
        $
        这只排除了有限多个 $c$，我们还有无穷多个 $c$，可用，我们只需证明这些 $c$ 都是好的，也即：
        $
        F(alpha + c beta := eta) = F(alpha, beta)
        $
        只需要让 $alpha, beta$ 落在 $F(eta)$ 中，考虑：
        $
        f_1(x) = f(eta - c x)\
        $
        由前面的条件我们可以知道，在 $E$ 中 $f_1, g$ 有唯一的公共根 $beta_1$（否则 $alpha_1 + c beta_1 = alpha_k + c beta_j$）

        同时，由可分性知 $g(x)$ 在 $E$ 中不会有重根，进而：
        $
        (f_1, g) = (x - beta_1)
        $
        然而最大公因式在域扩张下保持不变，因此 $x - beta_1$ 也是它们在 $F(eta)$ 中的最大公因式，进而 $beta_1 in F(eta)$，因此也显有 $alpha_1 in F(eta)$，证毕！
    ]
    #remark[][
      对于不可分扩张，未必能保证缩减到一个。事实上，考虑：
      $
      F = F_p (x, y)\
      K = F_p (x^(1/p), y^(1/p))
      $
      则 $[K : F] = p^2$，而 $K$ 中任何元素的最小多项式的次数一定不超过 $p$，进而不可能由一个元素生成。 
    ]
    @lemma-1 是很重要的，在之后的伽罗华理论中同样起着重要作用
  == 伽罗华理论
    #definition[伽罗华扩张][
      称一个域扩张是伽罗华扩张，如果扩张是可分正规的
    ]
    #definition[伽罗华群][
      给定伽罗华扩张 $quotient(K, F)$，称所有 $K$ 的满足 $phi|_(F) = id$ 的自同构 $phi$ 构成的群为伽罗华群，记作 $Gal(quotient(K, F))$
    ]
    #proposition[][
      $|Gal(quotient(K, F))| = [K : F]$ 
    ]
    #proof[
      这是 @lemma-1 的自然结果
    ]
    #example[双二次扩张][
      $QQ -> QQ(sqrt(2), sqrt(3))$，其伽罗华群有四个元素：
      $
      sqrt(2) -> plus.minus sqrt(2)\
      sqrt(3) -> plus.minus sqrt(3)
      $
      这个群当然就是四元群 $ZZ_2 times ZZ_2$\
      同时，三个非平凡元素分别成为 $QQ(sqrt(2)), QQ(sqrt(3)), QQ(sqrt(6))$ 的稳定子，这三个域都是域扩张的中间子域。 
    ]
    从上面的例子可以猜到，伽罗华群的子群可能是某个子域的稳定子，以下的定理说明了这个很不平凡的事实。
    #theorem[主定理/伽罗华定理][
      设 $quotient(K, F)$ 是有限伽罗华扩张，$G$ 是其伽罗华群。则：
      + 在以下集合之间存在一一对应：
        $
        {E | K <= E <= F} &<-> {H | H <= G}\
        E &-> Gal(quotient(K, E)) = {phi in Isom(K) | phi|_E = id}
        $
        往往将 $H <= G$ 的像记作 $K^(H)$
      + 上面的一一对应中，群越小，域越大，也即：
        $
        H_1 <= H_2 <=> K^(H_1) >= K^(H_2)
        $
      + $|H| = [K : K^H], [G:H]=[K^H:F]$
      + 设 $E = K^H$，则任取 $g in G$，有：
        $
        g(E) = K^(conjugateRight(g, H))
        $
      + $H norS G$ 当且仅当 $quotient(K^H, F)$ 是正规扩张，同时我们有：
        $
        quotient(G, H) tilde.eq Gal(quotient(K^H, F))
        $
      + 设 $E_1, E_2$ 分别对应 $H_1, H_2$，则：
        $
        E_1 E_2 <-> H_1 sect H_2\
        E_1 sect E_2 <-> generatedBy(H_1\, H_2)
        $
    ]
    #proof[
      先给出第一条的证明，这是相对最困难最不平凡的一条。\
      由伽罗华扩张的要求，我们可以假设 $K$ 是某个可分多项式 $f(x) in F[x]$ 的分裂域。\
      - 给定 $H <= G$，先找出被 $H$ 不变的子域 $E$，再证明 $Gal(quotient(K, E)) = H$\
        -  首先，当然有 $H <= Gal(quotient(K, E))$，我们只需要证明不会多出来一些元素。我们的想法是通过计数解决，也即我们希望证明：
          $
          |H| >= |Gal(quotient(K, E))| = [K : E]
          $<equ_c>
          这也是主定理最难的部分，这个事实有两个证明：
          + 利用 @PET，可以假设 $E -> K$ 是单扩张，假设 $alpha$ 是生成元\
            考虑多项式：
            $
            f(x) = product_(sigma in H) (x - sigma(alpha))
            $
            由于它的所有系数都被 $H$ 中所有元素固定，当然有 $f(x) in E[x]$。因此，它是 $alpha$ 在 $E$ 上的零化多项式从而有：
            $
            m_alpha (x) | f(x) 
            $
            而 $deg(m_alpha (x)) = [K : E], deg(f(x)) = |H|$，上式即表明@equ_c 成立
          + #lemma[Artin][
                设 $H = {sigma_i}$，令 $a_i$ 是 $K$ 中 $n+1$ 个元素，则它们在 $E$ 中线性相关。
              ]
            #proof[
              考虑矩阵：
              $
              (sigma_i (a_j))_(n times (n+1))
              $
              显然，它的列向量当然在 $K$ 上线性相关。我们希望证明它的列向量在 $E$ 上也线性相关，进而观察第一行立得原结论。\
              记其列向量为 $alpha_i$，不妨假设：
              $
              exists r: alpha_1, alpha_2, ..., alpha_r 在 K "中线性相关"，但\
              alpha_1, alpha_2, ..., alpha_(r+1)  在 K "中线性无关"
              $
              设：
              $
              alpha_(r+1) = (alpha_1, alpha_2, ..., alpha_r)vec(k_1, k_2, dots.v ,k_r)
              $
              则：
              $
              sigma(alpha_(r+1)) = (sigma(alpha_1), sigma(alpha_2), ..., sigma(alpha_r))vec(sigma(k_1), sigma(k_2), dots.v, sigma(k_r))
              $
              然而，我们注意到 $sigma$ 作用于 $alpha_i$ 无非是一个（相同的）列交换，因此不妨设：
              $
              sigma(alpha_i) = A alpha_i, forall i = 1, 2, ..., n
              $
              这里的 $A$ 是一个初等矩阵，当然是可逆的。从而上式变为：
              $
              A alpha_(r+1) = (A alpha_1, A alpha_2, ..., A alpha_r)vec(sigma(k_1), sigma(k_2), dots.v, sigma(k_r))\
              => A alpha_(r+1) = A(alpha_1, alpha_2, ..., alpha_r)vec(sigma(k_1), sigma(k_2), dots.v, sigma(k_r))\
              => alpha_(r+1) = (alpha_1, alpha_2, ..., alpha_r)vec(sigma(k_1), sigma(k_2), dots.v, sigma(k_r))
              $
              但由于 $alpha_(r+1)$ 被表出的方式应该是唯一的，这表明：
              $
              sigma(k_i) = k_i, forall i = 1, 2, ..., r
              $
              这样的操作对所有 $sigma in H$ 都成立，因此所有的系数被 $H$ 中所有元素保持不动，进而：
              $
              k_i in E, forall i = 1, 2, ..., r
              $
              这就证明线性相关性在 $E$ 中也成立，原结论得证
            ]
            有了这个引理，结论是显然的


      - 反之，给定中间域 $E$，找到固定 $E$ 不动的伽罗华群 $H <= G$，我们希望证明被 $H$ 固定的子域 $E' = E$
        - 首先，当然有 $E <= E'$
        - 其次，我们还是来计算一下扩张次数，利用上面的结果，注意到：
          $
          [K : E] = |H| = [K : E']
          $
          这当然就表明 $E = E'$
    ]
    #proof[
      + 前面已经证明
      + 
        若 $H_1 <= H_2$，当然有 $K^(H_1) >= K^(H_2)$\
        若 $E_1 <= E_2$，当然有 $Gal(K, E_2) <= Gal(K, E_1)$
      + 注意到 $K -> F$ 可分正规蕴含着 $H -> F$ 可分正规，因此 $H = Gal(quotient(K, K^H))$ 当然有上述结论
      + 
        $
        x in K^(conjugateRight(g, H)) <=> conjugateRight(g, H)x = x \
        <=> H Inv(g) x = Inv(g) x <=>Inv(g) x in K^H <=> x in g(K^H)
        $
      + 回忆 @lemma1，我们要做的事情很类似。事实上，@lemma1 告诉我们正规扩张一定对应正规子群，反过来只需证明正规子群对应正规扩张。\
        为此，取 $f(x) in F[x]$，它在 $K^H$ 中有零点，只需证明它分裂。先证明一个引理：
        #lemma[][
          若 $quotient(K, F)$ 是伽罗华扩张，且 $F[x]$ 中不可约多项式 $f(x)$ 在 $K$ 中分裂。设其一个根为 $alpha$，则它的所有根恰为 $Gal(quotient(K, F)) alpha$
        ]<lemma-polynomial>
        #proof[
          首先，显然 $Gal(quotient(K, F)) alpha$ 当然是多项式的根，因为以伽罗华群中的元素作用于 $f(x)$ 不改变所有系数\
          令 $g(x) = product_(sigma in Gal(quotient(K, F))) (x - sigma(a))$，注意到 $Gal(quotient(K, F))$ 中所有元素保持 $g(x)$ 不变，因此它是 $F$ 系数多项式。同时显有 $f, g$ 作为 $K[x]$ 中多项式不互素，进而作为 $F[x]$ 中多项式也不互素。而 $f(x)$ 是不可约多项式，给出 $f(x) | g(x)$，这就证明了另一方面。 
        ]
        回到原结论，引理告诉我们 $f(x)$ （在 $K$）中的所有零点恰为 $Gal(quotient(K, F))alpha$，但另一方面：
        $
        sigma(alpha) in K^(conjugateRight(sigma, H)) = K^H
        $
        这就证明了 $K^H$ 已经包含 $f(x)$ 的所有根。\
        最后，再次由 @lemma1，任何 $Gal(quotient(K, F))$ 都会保持 $K^H$ 稳定，因此有自然的同态：
        $
        eta: Gal(quotient(K, F)) -> Gal(quotient(K^H, F))
        $
        - $ker eta = {sigma in Isom(K) | sigma|_(K^H) = id} = Gal(quotient(K, K^H)) = H$
        - 计数发现它也是满射，因此同构定理即得原结论
      + 注意到 $phi|_(E_1 E_2) = id <=> phi|_(E_1) = id and phi|_(E_2) = id$，因此第一条成立。\
        对于第二条，我们从另一方向考虑。$K^(generatedBy(H_1\, H_2))$ 就是表示被所有 $H_1, H_2$ 中的元素都固定的元素构成的子域，当然就是 $E_1 sect E_2$
    ]
    #remark[][
      @lemma-polynomial 是十分重要的，有了这个引理，我们往往也把伽罗华群中的元素称作共轭。
    ]
    #proposition[][
      设 $quotient(K, F)$ 是伽罗华扩张，$quotient(E, F)$ 是任意域扩张，则：
      - $quotient(K E, E)$ 是伽罗华扩张
      - $Gal(quotient(K E, E)) tilde.eq Gal(quotient(K, K sect E))$
    ] 
    #proof[
      由题设，设 $K$ 是 $F$ 上某个可分多项式 $f(x)$ 的分裂域。\
      将 $f(x)$ 看作 $E$ 中多项式，当然它是可分的，取它的分裂域为 $K'$\
      注意到：
      + $E <= K'$
      + $f(x) in F[x]$ 在 $K'$ 中分裂，从而 $K <= K'$
      这就说明 $K E <= K'$\
      其次，当然有 $f(x) in E[x]$ 在 $K E$ 中分裂，因此：
      $
      K' = K E
      $
      这就证明了第一条。\

      给出同态映射 
      $
      Phi: Gal(quotient(K E, E)) -> Gal(quotient(K, K sect E))\
      sigma -> sigma|_K
      $
      - 单射性质容易验证
      - 满射性质比较困难，我们需要利用伽罗华理论迂回。设 $H = im Phi <= Gal(quotient(K, K sect E))$，取 $K^H <= K$，只需验证 $K^H <= E$\
        任取 $sigma in Gal(quotient(K E, E))$，由于 $sigma|_K$ 保持 $K^H$ 不动，当然有 $sigma$ 保持 $K^H$ 不动\
        但另一方面，被 $Gal(quotient(K E, E))$ 中所有元素保持不动的子域当然只能含于 $E$，进而 $K^H <= E => K^H <= K sect E => K^H = K sect E$
        
        
    ]
    #example[][
      这个命题中，某一个扩张是伽罗华扩张的条件是必要的。假设在命题中，把条件改成 $quotient(K E, F)$ 是伽罗华的，且
        $
        K sect E = F
        $
        那么我们将有：
        $
        Gal(quotient(K E, E)) = H_1, Gal(quotient(K E, K)) = H_2\
        Gal(quotient(K E, F)) = generatedBy(H_1\, H_2)\
        Gal(quotient(K E, K E)) = {1} =  H_1 sect H_2
        $
      此时为了得到好的结论，我们当然希望 $H_1, H_2$ 至少一个是正规子群（换言之，其中一部分是伽罗华扩张），进而立刻有：
      $
      quotient(generatedBy(H_1\, H_2), H_1) tilde.eq H_2
      $
    ]
    #theorem[][
      设 $quotient(K_1, F), quotient(K_2, F)$ 都是伽罗华扩张，则：
      - $K_1 sect K_2$ 是伽罗华的
      - $K_1 K_2 $ 是伽罗华的
      - 
        $
        Gal(quotient(K_1 K_2, F)) tilde.eq {(g_1, g_2) in  Gal(quotient(K_1, F)) times Gal(quotient(K_2, F))| g_1|_(K_1 sect K_2) = g_2|_(K_1 sect K_2)}
        $
      - 若还有 $K_1 sect K_2 = F$，则：
        $
        Gal(quotient(K_1 K_2, F)) tilde.eq Gal(quotient(K_1, F)) times Gal(quotient(K_2, F))
        $
    ]
    #proof[
      - 只需按照定义验证正规即可
      - 注意到 $K_1, K_2$ 是 $f_1 (x), f_2 (x)$ 分裂域，则 $K_1 K_2$ 就是 $f_1 (x) f_2 (x)$ 的分裂域
    ]
    #example[][
      在伽罗华扩张 $QQ -> QQ(root(3, 2), omega)$ 中，伽罗华群恰为 $S_3$（$QQ$ 上不可约多项式 $x^2 - 2$ 的三个根的全置换）\
      其中 $(23)$ 固定了 $QQ(root(3, 2))$，不是正规扩张。$(123)$ 固定了 $omega$（$omega = (root(3, 2)omega)/root(3, 2) = (root(3, 2)omega^2)/(root(3, 2)omega)$），这是正规扩张（二次扩张均正规），同时对应的群也是正规子群（指数为 $2$ 的指数均正规）
    ]
    对于一般的可分域扩张 $quotient(K, F)$，我们往往可以取它的正规闭包 $quotient(L, F)$，此时它成为一个伽罗华扩张。假设 $K -> L$ 对应子群 $H$，则 $quotient(K, F)$ 的性质某种意义上就是陪集空间 $G:H$ 上的性质。
    #example[][
      考虑 $QQ[root(4, 2)]$，它的正规闭包是 $QQ[root(4, 2), i]$。它的伽罗华群是 $D_4$（四个顶点分别为 $plus.minus root(4, 2), plus.minus root(4, 2)i$\
      事实上，其中的 $r = root(4, 2) -> root(4, 2)i, s = i -> -i$\
      我们想要寻找子群 ${1, s r}$ 固定的子域，注意到：
      $
      s r(root(4, 2) + s r(root(4, 2))) = root(4, 2) + s r(root(4, 2))
      $
      因此 $root(4, 2) + s r(root(4, 2))$ 可能是我们要找的域中的一个元素，它就是 $(1-i)root(4, 2)$。它在 $QQ$ 中最小多项式为 $4$ 次（显然是 $8$ 的因子，但不会是 $1, 2, 8$），因此它就是一个生成元
    ]
    #theorem[有限域扩张的伽罗华群][
      设 $F_(q) -> F_(q^m)$ 是伽罗华扩张，则它的伽罗华群就是：
      $
      a -> a^q
      $
      其中 $q$ 是富比尼元素，这一定是个循环群。
    ]
    #definition[阿贝尔扩张][
      称一个伽罗华扩张是阿贝尔扩张，如果它的伽罗华群是阿贝尔群
    ]
    #definition[分圆扩张][
      - 熟知 $n$ 次单位根构成循环群，它的生成元被称为本原单位根，记作 $zeta_n^a$。显然这样的生成元恰有 $phi(n)$ 个。
      定义：
      $
      Phi_n (x) = product_a (x - zeta_n^a) in CC[x]
      $
      这样的多项式被称为分圆多项式，此时有：
      $
      x^n - 1 = product_i (x - omega_n^i) = product_(d | n)Phi_n (x)
      $
      事实上，由此可以归纳证明 $Phi_n (x) in ZZ[x]$ \
      下面的定理表明 $Phi_n (x)$ 不可约，进而成为 $zeta_n^a$ 的最小多项式。形如 $QQ[zeta_n^a]$ 的扩张被称为分圆扩张，它的伽罗华群恰为：
      $
      (ZZ_n)^times
      $
    ]
    #theorem[][
      $Phi_n (x)$ 在 $ZZ[x], QQ[x]$ 都不可约，进而成为 $zeta_n^a$ 的极小多项式 
    ]
    #proof[
      由高斯引理，只需要证明在 $ZZ[x]$ 不可约即可。
      - 取 $zeta$ （在 $Phi_n$ 的分裂域中）是一个 $n$ 次单位根\ 只需要证明它就是极小多项式 $m(x)$，显有 $m(x) | Phi_n (x)$。\
      我们的目标是证明 $m(x)$ 包含 $Phi_n (x)$ 的所有根。而注意到 $Phi_n (x)$ 的所有根都形如：
      $
      zeta^a, a = p_1^(alpha_1)p_2^(alpha_2)...,p_n^(alpha_n)
      $
      为了证明这些元素都是 $m(x)$ 的根，事实上每次只需添加一个素因子。由于所有的 $n$ 次单位根都是对称的，这样的添加当然可以一直进行下去，因此我们只需要下面的引理：
      #lemma[][
        设 $p$ 是一个不是 $n$ 的因子的素数，则 $zeta^p$ 也是 $f(x)$ 的根
      ]
      #proof[
        如若不然，令 $g(x)$ 是 $zeta^p$ 的极小多项式。显然 $f(x)$ 应该与 $g(x)$ 互素。\
        此时分圆多项式 $Phi_n (x)$ 将拥有两个互素的因子 $f(x)$ 和 $g(x)$ 。\
        但是，我们有：
        $
        g(zeta^p) = 0 => g(x^p) "以 " zeta  "为一个根" => m(x) | g(x^p)
        $
        令 $g(x^p) = f(x)k(x), k(x) in ZZ[x]$\
        取自然同态： $phi: ZZ -> ZZ_p$，我们有：
        $
        phi(g(x^p)) = phi(f(x)) phi(k(x))
        $
        然而我们注意到，任何多项式 $mod p $ 都有：
        $
        phi(g(x^p)) = phi((g(x)))^p
        $
        从而：
        $
        phi((g(x))^p) = phi(f(x)k(x))
        $
        这表明，在 $ZZ_p [x]$ 中，$f(x)$ 与 $g(x)$ 有公共因子。\
        但又我们有：
        $
        phi(f(x)g(x)) | phi(Phi_n (x))
        $
        由于 $phi(f(x)), phi(g(x))$ 有公共因子，$phi(Phi_n (x))$ 将在它的分裂域中有重根，因而由定义，$x^n - 1 in ZZ_p [x]$ 将在分裂域上有重根。\
        但由重根判别法，这是荒谬的。
      ]
      分圆扩张是一个非常具体而强大的扩张，可以引出很多有趣的结果。  
      #corollary[][
        任意有限交换群都是某个伽罗华扩张的伽罗华群。
      ]
      #proof[
        由于有限交换群有结构定理，令：
        $
        G = quotient(ZZ, n_1) times quotient(ZZ, n_2) times ... times quotient(ZZ, n_k)
        $
        由狄利克雷定理，存在 $p_i$ 使得：
        $
        n_i = 1 mod p_i
        $
        则这样造出的 $(ZZ_(p_1 p_2 ... p_n))^times$ 恰好对应一个分圆扩张（的伽罗华群），而 $G$ 成为这个伽罗华群的一个正规子群，从而当然也是某个伽罗华扩张的伽罗华群。
      ]
      #example[][
        找到一个次数为 $3$ 的 $QQ$ 上的循环扩张（伽罗华群为循环群）\
        注意到分圆扩张 $QQ(zeta_7)$ 的伽罗华群恰好是 $ZZ_6$，因此取它的一个二阶循环子群，这个循环子群所固定的子域 $F$ 即满足：
        $
        [QQ(zeta_7) : F] = 3\
        [F : QQ] = 2\
        $
        且：
        $
        Gal(quotient(F, QQ)) tilde.eq quotient(ZZ_6, ZZ_2) = ZZ_3
        $
      ]
      #theorem[Kronecker - Weber][
        $QQ$ 上任意有限阿贝尔扩张都是某个分圆扩张的子扩张
      ]
      这个定理是非常强大的，后续延伸出诸多工作讨论能否把类似的工作延伸到 $QQ$ 以外的域上。

    ]
  == 多项式的伽罗华群
    进入主题之前，我们需要准备一些工具
    #definition[群特征][
      给定一个交换群 $G$ 并设 $L$ 是域，$H$ 的一个值在 $L$ 中的特征是指 $H$ 到 $L^times$ 的一个群同态
    ]
    #theorem[Artin][
      假设 $kai_i$ 是群 $G$ 在 $L$ 上的不同特征，则它们作为$H -> L^times$ 的函数是线性无关的
    ]<Artin-linear-independent>
    #proof[
      假设它们线性相关，那么我们不妨假设 $kai_1, ..., kai_(r-1)$ 是极大无关组，并有：
      $
      kai_r (h) = sum_i a_i kai_i (h) ,forall h in H
      $<linear_relation>
      既然它们是不同的特征，可设：
      $
      kai_1 (h_0) != kai_r (h_0)
      $
      由于任意性，我们知道：
      $
      kai_r (h h_0) = sum_i a_i kai_i (h h_0)
      $
      但特征是群同态，因此：
      $
      kai_r (h) kai_r (h_0) = sum_i a_i kai_i (h) kai_i (h_0)
      $
      注意到域上的乘法群不含 $0$，因此 $kai_r (h_0) !=0$，上式将给出一个不同于@linear_relation 的线性表出，矛盾！
    ]
    #definition[循环扩张][
      称一个伽罗华扩张是循环的，如果它的伽罗华群是循环群
    ]
    #theorem[Kummer][
      - 假设 $char(F)$ 不是 $n$ 的因子，且 $F$ 包含所有 $n$ 次单位根，则任取 $a in F$，$K = F(root(n, a))$ 是循环扩张，且扩张次数是 $n$ 的因子
      - 假设 $char(F)$ 不是 $n$ 的因子，且 $F$ 包含所有 $n$ 次单位根，则所有 $F$ 上的循环扩张都由添加某个 $root(n, a)$ 得到
    ]<Kummer-theorem>
    #proof[
      + 注意到：
        $
        x^n - a = product_i (x - root(n, a) xi_n^i)
        $
        同时由条件，$x^n - 1$ 无重根，因此这些单位根两两不等，同时上式是可分多项式，在 $K$ 中完全分裂，进而 $K$ 是分裂域，扩张是正规扩张。这一并给出扩张是伽罗华扩张\
        为了决定群的的结构，考虑任何 $F-$ 自同构，显然这样的自同构由 $root(n, a)$ 的像唯一确定，且一定把 $root(n, a)$ 送到 $root(n, a) xi_n^i$ 中某一个。\
        给出映射：
        $
        funcDef(lambda, Gal(quotient(K, F)), {xi_n^i}, sigma, sigma(root(n, a))/root(n, a))
        $
        - 上面已经说明 $F-$ 自同构 $sigma$ 由 $lambda(sigma)$ 唯一确定，从而它是单射
        - 计算验证 $lambda$ 是群同态：
          $
          sigma compose tau(root(n, a)) = sigma(xi_n^(lambda(tau))root(n, a)) = tau(xi_n^(lambda(tau))) tau(root(n, a)) = xi_n^(lambda(tau))tau(root(n, a))\
          = xi_n^(lambda(tau) + lambda(sigma)) root(n, a)
          $
          足以说明同态
        因此由同构定理，结论成立。对于扩张次数，由于有一个 $n$ 次零化多项式，结论显然。
      + 证明的核心当然是找到一个 $a$\
        假设伽罗华群为 $generatedBy(sigma)$，对于任意 $alpha$，令:
        $
        b = sum_i^n xi_n^(i-1) sigma^(i-1)(alpha)
        $
        - 首先证明存在一个 $alpha$ 使得上式非零。事实上，@Artin-linear-independent 告诉我们 $L^times -> L^times$ 的群特征：
          $
          1, sigma, sigma^2, ..., sigma^(n-1)
          $
          线性无关，从而结论当然是正确的
        - 这个构造看起来有点匪夷所思，实际上我们的想法是我们预想的 $root(n, a)$ 应该满足：
          $
          sigma(root(n, a)) = xi_n^i root(n, a)
          $
          上式即是从迭代的角度构造出了这样一个等式:
          $
          sigma(b) = xi_n^(-1) b
          $
        取 $a = b^n$，注意到：
          $
          sigma^i (b) = xi_n^(-i) b
          $
        表明伽罗华群 $Gal(quotient(K, F))$ 中没有任何子群保持 $b$ 不动，进而没有任何中间域，也即：
          $
          K = F(b) = F(root(n, a))
          $
    ]
    #definition[可根式求解][
      设 $F -> F$ 是代数扩张，则称 $K$ 可被根式表示，如果存在域的链：
      $
      F = K_0 subset K_1 subset K_2 ..., subset K_s = K
      $
      满足每一个扩张都是添加某个 $root(n_i, a_i)$ 得到的单扩张
    ]
    这个定义不假定扩张是伽罗华的，但我们总可以取伽罗华闭包
    #proposition[][
      取 $quotient(K, F)$ 的伽罗华闭包 $L$，则域扩张 $L$ 也满足上面的链条件
    ]
    #proof[
      取伽罗华闭包对应伽罗华群 $H$，注意到伽罗华闭包可由：
      $
      L = product_(sigma in H) sigma(K)
      $
      得到。\
      其次，对于任意 $sigma$，注意到：
      $
      F -> sigma(K_1)
      $
      当然是由添加某个根式得到的单扩张，那么：
      $
      K_1 -> K_1 sigma(K_1)
      $
      也是由添加某个根式得到的单扩张，依次类推即得结论
    ]
    #definition[][
      称一个不可约多项式的伽罗华群为由它生成的分裂域作为域扩张产生的伽罗华群
    ]
    #theorem[][
      一个不可约多项式的某个根可被根式求解当且仅当它的伽罗华群可解
    ]
    #proof[
      在证明中，不妨设可根式求解的域链最终产生伽罗华扩张
      - 必要性：
        设 $K_(i+1) = K_i (root(n_i, a_i))$，为了方便我们将所有需要的 $n$ 次单位根添加进去，令：
          $
          K_(i)^' = K_i (xi_(n_i))
          $
          最终方程当然在 $L'$ 可解。\
          注意到每个 $K_i^' -> K_(i+1)^'$ 都是伽罗华的，自然我们有：
          $
          G_(i+1) norS G_i
          $
          同时由 @Kummer-theorem ，每个商群都是循环群，进而 $F -> L'$ 的伽罗华群可解。 $L -> F$ 作为子伽罗华扩张，它的伽罗华群成为 $G$ 的正规子群，当然也可解。
        - 充分性：
          令 $F'$ 是 $F$ 添加进所有可能需要的单位根 $xi_|G|$，考虑新的扩张：
          $
          F' -> K F'
          $
          它的伽罗华群是（同构于）原伽罗华群的子群，当然也可解。\
          同时，它的可解群链利用伽罗华理论将转变为一系列循环扩张。由 @Kummer-theorem 理论，这当且仅当每一个对应的群扩张都是由开 $n$ 次根号的单扩张生成，进而结论正确。
    ]
    之后，我们讨论如何真正的考虑多项式的可解性。注意到不可约多项式的伽罗华群当然在所有根上有作用，且
    - 作用是单的，不会保持某个根不变
    - 作用是传递的，否则一个轨道上所有根可以构成一原多项式的因子，矛盾
    #lemma[][
      设 $F$ 特征零，某个域扩张形如 $F(x_1, x_2, ..., x_n) := M$，$x_i$ 互不相同。取所有关于 $x_i$ 的对称多项式 $s_i$，令：
      $
      L = F(s_1, s_2, ..., s_n)
      $
      显然 $L <= M$，更进一步，$M$ 是 $L$ 上无重根多项式的分裂域，进而是伽罗华扩张。\
      它的伽罗华群将是 $S_n$ 的一个子群，事实上，它的伽罗华群就是 $S_n$
    ]
    #proof[
      
    ]
    我们知道 $S_n$ 当然有一个正规子群 $A_n$，这个正规子群对应到哪个域扩张呢？事实上，令：
    $
    D := product_(1 <=i < j <= n) (x_i - x_j)
    $
    不难发现 $S_n$ 中保持它不变的的元素恰好就是 $A_n$ 中的所有元素。
    #lemma[][
      在特征 $0$ 的域上，取不可约多项式的分裂扩张 $F -> K$，同样定义判别式 $D$，则：
      $
      D in F <=> Gal(quotient(K, F)) <= A_n
      $
    ]
    #proof[
      $G sect A_n = A_n <=> F(D) = F$
    ]
    #example[三次方程的求根公式][
      给定三次方程（假设多项式已经不可约）：
      $
      x^3 + p x + q = 0
      $
      由线性代数的方法，可以求出它的判别式的平方：
      $
      D^2 = - 4 p^3 - 27 q^2
      $
      由引理：
      - $D^2$ 为平方数时，$G$ 是 $A_3$ 的子群，只能是 $A_3 = ZZ_3$
      - 否则，$G subset.not A_3$，又因为它是传递的，因此它只能是 $S_3$\
      我们当然可以添加进 $D = sqrt(D^2)$，此时 $G$ 就是 $ZZ_3$，从而扩张成为循环扩张，@Kummer-theorem 表明一定可以添加某个值的三次根号实现，我们找到这个值即可。
      取 $omega$ 是三次单位根，设 $alpha, beta, gamma$ 是方程的三个根，类似 Kummer 理论的证明中，定义：
      $
      theta_1 = alpha + omega sigma(alpha) + omega^2 sigma^2(alpha)\
      = alpha + omega beta + omega^2 gamma\
      theta_2 = alpha + omega^2 beta + omega gamma\
      theta_3 = alpha + beta + gamma = 0
      $
      我们当然知道 $theta_1^3, theta_2^3$ 都是域中现有的数，进而只要添加进 $root(3, theta_1), root(3, theta_2)$，上面三式都成为线性方程，解之即可。


    ]
  == 无穷伽罗华理论
    我们尝试利用一些技巧将伽罗华理论扩充至无穷情形
    #definition[逆向极限/投射极限 (Inverse Limit)][
      - 设存在一列集合之间的满射：
        $
        A_1 <-^(f_1) A_2 <-^(f_2) A_3 ... 
        $
        则定义逆向极限/投射极限（有时也直接称为极限）为：
        $
        inverseLimit(n) A_n = {(a_1, a_2, ...) in product_n A_n | f_n(a_(n+1)) = a_n}
        $
      - 在上面的定义中，将集合改为群/环/域/...，满射改为满同态，则可类似定义逆向极限
    ]
    #example[p- 进数域][
      设 $p$ 为一个素数，令 $A_n := quotient(ZZ, p^n ZZ)$，显然 $A_(n)$ 与 $A_(n+1)$ 之间存在自然的满同态 $f_n$\
      令 $ZZ_p = inverseLimit(n) A_n$\
      这当然是交换环，并且可以验证只要 $x_0 != 0, p$ ，每个 $x_i$ 都将与 $p$ 互素，进而它就是可逆元。\
      其中的元素可以更显式的写作：
      $
      x = a_0 + a_1 p + a_2 p^2 + ...... space a_i in {0, 1, ..., p-1}
      $
    ]
    #lemma[][
      设有环上的逆向极限 $R = inverseLimit(n) R_n$，我们将有：
      $
      R^times = inverseLimit(n) R_n^times
      $
    ]
    #proof[
      注意到 $f_n (R^times_(n+1)) subset R_n^times$。\
      对于 $a = (a_i) in R^times$，取 $b = (b_i = Inv(a_i))$。只需要验证 $f_n (b_(n+1)) = b_n$。事实上：
      $
      1 = f_n (1) = f_n (a_(n+1) b_(n+1)) = f_n (a_(n+1)) f_n (b_(n+1)) = a_n f_n (b_(n+1))
      $
      由逆元的唯一性，这表明 $f_n (b_(n+1)) = b_n$，因此 $b in R$ 且 $a b = 1$，进而 $a, b in R^times$
    ]
    #example[][
      令 $R = inverseLimit(n) quotient(CC[x], (x^n))$，它其实就是 $CC$ 上的形式幂级数环，每一项都是有限多项式，集合起来就是一个无穷多项式，也就是一个泰勒展开式。\
    ]
    #definition[推广的逆向极限][
      称一个偏序集 $I$ 是滤子的，如果 $forall i, j in I, exists k, k > i and k > j$\
      假设我们有一列集合/群/环/... $A_i, i in I$，并且对 $j > i, exists phi_(j i) : A_j -> A_i$ 是同态，使得：
      $
      phi_(k j) compose phi_(j i) = phi_(k i)
      $
      则称之为一个反向系统。此时我们定义逆向极限：
      $
      inverseLimit(i in I) = {(a_i) | a_i in A_i, forall j > i, phi_(j i)(a_j) = a_i}
      $
    ]
    #proposition[][
      设 $lambda_i: B -> A_i$ 是同态并且满足:
      $
      forall j > i, phi_(j i) compose lambda_j = lambda_i
      $
      则将存在同态将 $B$ 映入 $inverseLimit(i in I) A_i$
    ]
    #example[][
      取整除关系作为 $ZZ$ 上的滤过的偏序关系，并取其中自然的同态，定义： 
      $
      ZZ^(\^) = inverseLimit(n) quotient(ZZ, n ZZ)
      $
    ]
    #lemma[][
      $ZZ^(\^) tilde.eq product_(p "is prime") ZZ_p$
    ]
    #proof[
      定义:
      $
      phi_1 : ZZ^(\^) -> product_(p "is prime") ZZ_p\
      (a_n) -> (a_(p^r))_r
      $
      $
      phi_2: product_(p "is prime") ZZ_p -> ZZ^(\^)\
      phi_2 = pi_1 : ZZ_n -> ZZ_n^(\^) compose pi_2: product_(p "is prime") ZZ_p -> ZZ_n
      $
    ]
    #definition[反向极限的拓扑][
      对于反向极限 $inverseLimit(i) A_i = A$，定义其拓扑是乘积拓扑的限制
    ]
    #theorem[][
      如果每个 $A_i$ 都是 Hausdorff 空间，则 $A$ 也是 Hausdorff 空间
    ]
    #definition[拓扑群][
      称一个群 $G$ 是拓扑群，如果它是一个拓扑空间且群运算是连续的
    ]
    #proposition[][
      - 设 $U subset R$ 是开集，则 $forall g, h in G, g U h in G$ 也是开集
      - 设 $H <= G$ 是开子群，则它同时也是闭的
      - 若 $G$ 是紧群，则开子集 $H$ 是有限指标的
    ]
    #definition[Profinite group][
      称一个拓扑群 $G$ 是 profinite 的，如果它是有限群的滤过反向极限
    ]
    #lemma[][
      设 $G$ 是 profinite 群，则:
      $
      G tilde.eq inverseLimit(H norS G "open") quotient(G, H)
      $
    ]
    #proof[
      $G -> inverseLimit(H norS G "open") quotient(G, H)$  是自然的\
      反之，设：
      $
      G = inverseLimit(i in I) G_i
      $
      考虑 $pi_i: G -> G_i$，则 $ker pi_i norS G$，可以构造反过来的映射：
      $
      inverseLimit(H norS G "open") quotient(G, H) -> quotient(G, ker pi_i) -> G_i
      $
    ]
    对于任何一个无穷伽罗华扩张，无疑它是其所有有限伽罗华自扩张的并，重点是如何定义伽罗华群
    #definition[][
      在无穷维（代数）伽罗华扩张中，定义：
      $
      Gal(quotient(K, F)) := inverseLimit(quotient(E, F) "有限伽罗华") Gal(quotient(E, F))
      $
    ]
    #example[][
      $QQ(xi_(p^infinity)) = QQ(xi_(p^n), n in NN)$，则它的伽罗华群是所有素数幂阶循环群的反向极限，当然就是 $ZZ^times$
    ]
    #lemma[][
      $Gal(quotient(K, F)) = {"autoiso" sigma: K -> K | sigma_F = id}$
    ]
    #proof[
      对任何有限子伽罗华扩张 $quotient(E, F)$，它们伽罗华群的反向极限一方面是原扩张的伽罗华群，另一方面当然也对应所有保持 $F$ 不变的 $K$ 上自同构，因此结论成立
    ]
    #theorem[主定理][
      伽罗华群的某些子群与子扩张存在一一对应，具体而言：
      $
      "闭子群" <-> "子扩张"\
      "开子群" <-> "有限子扩张"\
      "正规子群" <-> "子伽罗华扩张"\
      $
    ]
  == 代数闭包与超越扩张
    #definition[代数封闭][
      称域 $F$ 是代数封闭的，如果它的每个多项式都有根（进而每个多项式分裂）。这也等价于其上没有非平凡的代数扩张
    ]
    #definition[代数闭包][
      称域 $F$ 的代数闭包是一个代数扩张 $F -> algClosure(F)$，使得 $F^"alg"$ 代数封闭
    ]
    类似的可以定义可分闭域，可分闭包等等
    #theorem[][
      - 任何域都有代数闭包，且在同构的意义下唯一
      - 域的代数闭包就是其上所有多项式的分裂域
    ]
    #proof[
      只证明 2，1 涉及一些纯粹集合论的问题，这里跳过\
      设 $F$ 上所有多项式的分裂域（也是所有有限代数扩张的复合）为 $F'$，假设 $F'$ 还有非平凡不可约多项式:
      $
      sum_i a_i x^i
      $
      则扩张 $F(a_0, a_1, a_2, ..., a_n, alpha)$ 成为 $F$ 上有限代数扩张，由定义它应该包含于 $F'$，这就表明 $F'$ 代数封闭
    ]
    #definition[超越扩张][
      设 ${x_1, x_2, ..., x_n, ...}$ 在 $F$ 上代数无关（也即不存在 $F$ 上的（多元）多项式使得 $f(x_1, x_2, ..., x_n, ...) = 0$）\
        则 $F(x_1, x_2, ..., x_n, ...)$ 称为超越扩张。特别的，有：
          $
          F(x_1, x_2, ..., x_n, ...) tilde.eq (F[x_1, x_2, ..., x_n, ...])/(F[x_1, x_2, ..., x_n, ...])
          $
        其中的无穷元多项式均指任意有限元多项式
    ]
    #definition[超越基][
      超越扩张中，极大的代数无关组称为超越基，显然这等价于它们可以唯一线性表出任何元素
    ]
    #theorem[][
      对于任意超越扩张，超越基是存在的，且任意超越基具有相同的基数
    ]
    #remark[][
      超越基并不意味着超越生成元，例如 ${x}, {x^2}$ 都是一组超越基，但显然有：
      $
      F(x) != F(x^2)
      $
    ]
    #definition[纯超越扩张][
      超越扩张 $quotient(K, F)$ 称为纯超越扩张，如果存在一组线性无关的元素 $S$，使得 $K = F(S)$
    ]
    接下来我们要叙述所谓的希尔伯特零点定理，为此我们需要一些交换代数
    #definition[幂零根（radical）][
      设 $I$ 是交换环中的理想，则称它的幂零根为：
      $
      sqrt(I) = union_(i=1)^(+infinity) {f in R | f^i in I}
      $
      它也是环中的理想\
      若 $I = sqrt(I)$ 则称 $I$ 为 radical
    ]
    显然若 $I$ 是多项式环的理想，则 $I$ 中所有多项式的零点当然恰为 $sqrt(I)$ 中所有多项式的零点
    #theorem[希尔伯特零点定理][
      - 假设 $K$ 是代数闭域，则多项式环 $K[x_1, x_2, ..., x_n]$ 的极大理想均形如 $(x_1 - a_1, ..., x_n - a_n), a_i in K$
      - 假设 $K$ 是代数闭域，则任意理想 $I$ 均满足：
        $
        I(Z(I)) = sqrt(I)
        $
    ]
    #proof[
      我们的思路是所谓的 Nother 正规化，它类似于代数的域扩张。这节中我们所说的环都是交换环。
      #definition[][
        设 $A$ 是 $B$ 的子环，称 $B$ 中元素 $x$ 是在 $A$ 上整的，如果：
        存在首一多项式：
        $
        x^n + a_(n-1)x^(n-1) +...+a_0
        $
        使得 $x$ 是它的根
      ]
      #remark[][
        - 我们要求多项式必须首一，在域上这无关紧要但在环上有必要额外要求
        - 我们没有极小多项式的概念，但是许多概念仍然能进行推广
      ]
      #proposition[][
        下列说法等价：
        - $x$ 在 $A$ 上整
        - $A[x]$ （这里的 $x$ 是指这个元素 $x$ 而非自由的不定元）是有限生成 $A$ 模
        - $exists C <= B, A[x] <= B$ 且 $C$ 在 $A$ 上有限生成
      ]
      #proof[
        - 2 -> 3: 显然
        - 1 -> 2: \
          注意到：
          $
          x^n  = -(a_(n-1)x^(n-1) +...+a_0)
          $
          进而 $A[x]$ 就是由 $1, x, x^2, ..., x^(n-1)$ 生成的 $A$ 模
        - 3 -> 1 是略微有点复杂的：\
          设 $C$ 被 $e_1, e_2, ..., e_n$ 有限生成，我们希望仿照线性空间中，特征多项式还是零化多项式的思路构造\
          假设：
          $
          x(e_1, e_2, ..., e_n) = (e_1, e_2, ..., e_n) A
          $
          注意此时的 $A$ 未必是唯一的，但总之是存在的\
          注意到上式实际上就是：
          $
          (e_1, e_2, ..., e_n) (x I - A) = 0
          $
          由线性代数的知识，取 $x I - A$ 的伴随矩阵 $B^*$，有：
          $
          0 = (e_1, e_2, ..., e_n) (x I - A) B^* = |x I - A| (e_1, e_2, ..., e_n) 
          $
          由于 $e_1, e_2, ..., e_n$ 是一组生成元，因此应该存在列向量 $X$，使得：
          $
          1 = (e_1, e_2, ..., e_n)X
          $
          这就有：
          $
          |x I - A| = |x I - A| (e_1, e_2, ..., e_n) X = 0
          $
          这就是我们要的首一多项式
      ]
      #corollary[][
        - 设 $x_1, x_2, ..., x_n$ 是 $A$ 上的整元，则 $A[x_1, x_2, ..., x_n]$ 是有限生成整模
        - $A$ 上所有整元构成的集合是一个包含 $A$ 的子环，称其为 $A$ 的整闭包。若 $A$ 包含了所有整元，则称其在 $B$ 中整闭。\ 若 $B$ 中所有元素都在 $A$ 上整，则称 $B$ 在 $A$ 上整。
        - 设 $A subset B subset C$，且 $B$ 在 $A$ 上整，$C$ 在 $B$ 上整，则 $C$ 在 $A$ 上整
        - $A$ 在 $B$ 中的整闭包是整闭的
      ]
      #proof[
        - 类似一元的情形是显然的
        - 注意到 $A[x, y]$ 是有限生成 $A-$模，而 $x plus.minus y, x y$ 都在其中，由之前的命题知这些元素都是整元，进而整元构成的集合对加减乘封闭
        - 完全仿照域的对应命题证明即可
        - 假设 $A$ 的整闭包 $C$ 还有整元 $x$，则由上面的命题知 $x$ 也在 $A$ 上整，进而 $x in C$
      ]
      所谓的 Nother 正则化可以想成思考一个整环上的 $k-$ 代数到底有多少的“超越次数”
      #theorem[Nother 正规化][
        设 $k$ 是域，$R$ 是有限生成$k-$代数，也即 $R = quotient(k[x_1, x_2, ..., x_n], I)$，$I$ 是其中某个理想。\
        此时，存在 $k <= n$ 以及一个嵌入单同态：
        $
        phi: k[y] = k[x_1, x_2, ..., x_r] -> R
        $
        使得 $R$ 在 $k[y]$ 上整
      ]
      #proof[
        对 $n$ 做归纳，假设 $n - 1$ 时情形已经证明\
        在 $I$ 中找到非零元素 $f$\
        假想 $f = x_(n)^i + ...$，那我们就可以直接代换。但是现实不允许我们这么做，非常技巧性的我们可以做以换元。\
        令 $z_i = x_i - x_(1)^(r_(i-1)), i=2, 3...$，$r_i$ 的值我们稍后确定\
        考虑同构 $psi: =k[x_1, x_2, ..., x_n] -> k[x, z_1, z_2, ..., z_n]$，$psi(f)$ 就是换元后的结果，记 $I' = psi(I)$\
        不妨设 $r_n$ 充分大，$psi(f)$ 的最高次项应当会是 $x_1^N$（系数不妨设为 1） \
        接下来，我们在 $quotient(k[x_1, z_1, z_2, ..., z_n], I')$ 中抹掉 $x_1$，自然产生一个嵌入映射 
        $
        phi' : quotient(k[z_1, z_2, ..., z_n], I') -> quotient(k[x, z_1, z_2, ..., z_n], I'')
        $
        另一方面，可以验证这个嵌入是有限生成的整扩张，而由归纳假设，后者在 $k[y]$ 上是整的，进而 $R$ 在 $k[y]$ 上也是整的
      ]
      #lemma[][
        设 $R$ 是域，$S$ 是其上的子环且 $R$ 在 $S$ 上整，则 $S$ 是域
      ]
      #proof[
        任取 $x in S$，由于 $Inv(x) in R$，故可设：
        $
        0 = f(Inv(x)) = x^(-n) + a_(n-1) x^(-n+1) + ... + a_0\
        x^(-1) = - a_(n-1) - a_(n-2) x - ... - a_0 x^(n-1)
        $
        故结论成立
      ]
      最终我们可以回到希尔伯特零点定理的证明。\
      假设 $M$ 是 $k[x_1, x_2, ..., x_n]$ 上的极大理想，则 $quotient(k[x_1, x_2, ..., x_n], M)$ 将是域。\
      由 Nother 正规化，可以找到 $k[y]$ 使得 $quotient(k[x_1, x_2, ..., x_n], M)$ 在其上整。然而由引理，$k[y]$ 是域，从而 $k[y] = k$，扩张：
      $
      k -> quotient(k[x_1, x_2, ..., x_n], M)
      $
      是有限扩张，这就给出了结果。\
      对于第二个结论，注意到：
      $
      f in sqrt(I) => f^n in I => f^n(Z(I)) = 0 => f(Z(I)) = 0 => f in I(Z(I))
      $
      另一个方向的证明需要一些代数几何上的技术。假设 $I = (f_1, f_2, ..., f_n)$，$g$ 满足：
        $
        forall a in k^n, f_1 (a) = f_2 (a) = ... = f_n (a) = 0 => g(a) = 0
        $
      考虑理想：
        $
        J = k[x_1, x_2, ..., x_(n+1)] = I J + (1 - g x_(n+1))
        $
      将有 $J$ 的零点集是空集。代数几何上，这将给出 $J = (1)$，这是因为：
      - 假设 $Z(J) != (1)$，那么 $J$ 一定可以扩充成为一个极大理想 $M$。由零点定理的第一条：
        $
        M = (x_1 - a_1, x_2 - a_2, ..., x_(n+1) - a_(n+1))
        $
        考虑自然的嵌入 $phi: quotient(k[x_1, x_2, ..., x_n], J) -> quotient(k[x_1, x_2, ..., x_n], M) = k$（这是因为 $M$ 是比 $J$ 大的理想）\
        而在左侧 $f_i = 0, 1 - g x_(n+1) = 0$，在右侧这意味着 $f(a) = 1 - g(a) a_(n+1) = 0 => 1 = 0$，矛盾！
      因此 $J = (1)$，故：
        $
        1 = sum_i h_i f_i + h (1 - g x_(n+1)) =^("代入" x_(n+1) = Inv(g)) sum_i h_i f_i (x_1, x_2, ..., x_n, Inv(g))
        $
      整理立得 $g^l in (f_1, f_2, ..., f_n)$
    ]
    #theorem[希尔伯特零点定理的最终版本][
      - 存在一一对应：
      $
      {k^n "的代数子集"} &<-> {k[x_1, x_2, ..., x_n] "的根理想"}\
      Z &-> I(Z)\
      Z(I) &<- I
      $
      - $I_1 subset I_2 <=> Z(I_1) supset Z(I_2)$
      - $Z(I_1 + I_2) = Z(I_1) sect Z(I_2)$
      - $Z(I_1 sect I_2) = Z(I_1) union Z(I_2)$
    ]
]
#chapterThree