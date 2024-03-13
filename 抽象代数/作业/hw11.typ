#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业11",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
= P119
  == 1（1）
    容易验证它在 $QQ(sqrt(2), sqrt(3))$ 上分裂，同时它的分裂域中显然包含 $sqrt(2), sqrt(3)$，因此这就是它的分裂域
  == 2
    注意到：
    $
    (x^(p^n) - 1) = (x - 1)^(p^n)
    $
    因此它在 $"GF" (p)$ 上已经分裂
  == 4
    取 $f(x)$ 在 $E$ 上的分裂域 $K'$\
    由于 $K'$ 也是 $F$ 的扩域，因此 $K' >= K$\
    反之，由于 $K$ 也是 $E$ 的扩域，因此 $K >= K'$\
    综合即得 $K = K'$
  == 5
    - 充分性：假设 $E$ 关于 $quotient(K, F)$ 稳定，则设 $p(x) in f(x)$ 是 $F[x]$ 上不可约多项式，且在 $E$ 上有根 $alpha$\
      设 $beta$ 是 $p(x)$ 的另外一个根，并设 $K$ 是 $f(x) in F[x]$ 的分裂域。\
      取熟知的 $F-$ 域同构：$sigma: F(alpha) -> F(beta)$ 由于 $f(x)$ 在 $F(alpha), F(beta)$ 上的分裂域都是 $K$，由熟知命题，存在 $K$ 上的自同构 $sigma': K -> K$，使得：
      $
      sigma'|_F(alpha) = sigma => sigma'|_F = id
      $
      由条件，该自同构应该保持 $E$ 稳定，而 $sigma(alpha) = beta$，因此 $beta in E$\
      这就表明 $E$ 具有了 $p(x)$ 的所有根
    - 必要性：显然
  == 10
    - 验证它们在 $"GF"(3)$ 中没有零点，足以说明它们都不可约\
    - 注意到：
      $
      x^2 - x - 1 = x^2 + 2 x + 2 = (x+1)^2 + 1
      $
      因此 $beta - 1$ 一定是 $f(x)$ 的根，从而存在同构 $sigma: "GF"(3)(alpha) -> "GF"(3)(beta-1) = "GF"(3)(beta)$，形如：
      $
      a + b alpha -> a + b(beta - 1)
      $
  == 13
    #lemma[][
      不可约多项式 $f(x)$ 在 $F_(p^n)$ 中有根当且仅当 $f(x) | x^(p^n) - x$
    ]
    #proof[
      充分性是显然的。对于必要性，设 $f(x)$ 在 $F_(p^n)$ 中有根 $alpha$，显然 $x^(p^n) - x$ 成为 $alpha$ 的一个零化多项式，而 $f(x)$ 是不可约多项式，进而是最小多项式，自然有结论成立
    ]
    注意到 $F_(p^n)$ 就是 $x^(p^n) - x$ 的分裂域，进而这是正规扩张，$f(x)$ 有根当且仅当分裂。\
    #lemma[][
      $F_(p^m)$ 成为 $F_(p^n)$ 的子域当且仅当 $m | n$
    ]
    #proof[
      - 充分性：注意到当 $m | n$ 时，有 $x^(p^m) - x | x^(p^n) - x$，进而当然有 $x^(p^m) - x$ 的分裂域 $F_(p^m)$ 成为 $x^(p^n) - x$ 的分裂域 $F_(p^n)$ 的子域
      - 必要性：注意到 $[F_(p^n) : F_p] = n$，因此结论是容易的
    ]
    结合两个引理，结论是容易的。事实上，$f(x)$ 的分裂域一定是一个有限域 $K$，且 $[K : F_p] = m$ （这是因为做一次有限域上任何扩张都是正规的，进而添加一个根即分裂）\
    换言之，$K = F_(p^m)$ ，而我们当然有 $f(x)$ 在 $F_(p^n)$ 中有根当且仅当它的分裂域 $K$ 成为 $F_(p^n)$ 的子域（同样利用有根即分裂），进而由引理知这当且仅当 $m | n$
= 补充题
  == 
    设 $K, L$ 在 $F$ 上的基分别为 $alpha_i$
    - 假设 $phi$ 是 $F-$ 同态，当然有：
      $
      phi(a + b) = phi(a) + phi(b)\
      phi(lambda a) = phi(lambda) phi(a) = lambda phi(a), forall lambda in F
      $
      因此 $phi$ 是线性映射
    - 假设 $phi$ 是线性映射，则：
      $
      phi(lambda dot 1) = lambda phi(1) = lambda dot 1 = lambda, forall lambda in F
      $
      表明 $phi$ 保持 $F$ 不动，是 $F-$ 同态。
  == 
    在分裂域存在性的证明中，我们有：
    $
    [F(alpha) : F] | n
    $
    其中 $alpha$ 是 $f(x) in E[x]$ 的某个根。\
    递归进行即得 $[E:F] | n!$\
    当 $f(x)$ 不可约时，当然有：
    $
    [F(alpha) : F] = n | [E : F]
    $
    从而结论成立
  == 
    + 充分性是显然的，只说明必要性。假设 $[K : F] = 2$，则任取 $alpha in K - F$， $alpha$ 当然在 $F$ 中代数。\
      显然有：
      $
      [F(alpha) : F] | 2 => [F(alpha) : F] = 1 or 2\
      [F(alpha) : F] != 1 => [F(alpha) : F] = 2 = [K : F]
      $
      因此 $K = F(alpha)$
    // + 假设 $p(x) in F[x]$ 是在 $K$ 中有根 $beta = a + b alpha in K - F$ 的不可约多项式， 取 $F-$ 自同构：
    //   $
    //   phi := [a + b alpha | a + b alpha -> a - b alpha] 
    //   $
    //   显然 $phi(x) = x <=> x in F$\
    //   同时，注意到：
    //   $
    //   0 = phi(p(beta)) = p(phi(beta))
    //   $
    //   从而 $phi(beta)$ 是 $p(x)$ 的根，且 $beta in K - F => phi(beta) != beta$，因此 $p(x)$ 在 $K$ 上恰有不同两根 $beta, phi(beta)$，这就证明了正规扩张性 
      + 设 $alpha$ 在 $F$ 上最小多项式为 $m(x), deg m(x) = 2$\
        显然 $m(x)$ 在 $K$ 上有一个根，进而可以分解为两个一次因式，也即有两个根。\
        同时 $m(x)$ 显然不能在更小的域上分裂，因此 $K$ 就是它的分裂域，扩张确实是正规扩张。
  == 
    + 错误\
      $[QQ(root(3, 2), 1^(1/3))]$ 作为 $x^3 - 2$ 的分裂域是正规扩张，但 $[QQ(root(3, 2))]$ 不是
    + 错误\
      注意到：
      $
      QQ(sqrt(2)) : QQ\
      QQ(sqrt(sqrt(2))) : QQ(sqrt(2))
      $
      都是二次扩张，进而都正规，但显然:
      $
      QQ(sqrt(sqrt(2))) : QQ
      $
      不是正规扩张
  ==
    枚举 $f(x) in E[x]$ 的各种分解可能性
    - 不可约
    - 有一次因式，从而有根。但二次扩张是正规扩张，它应该具有所有的根。然而这表明扩张次数至少为 $6$ 矛盾
    - 有二次因式：\
      注意到二次扩张形如 $F(alpha)$，我们可以取得 $E$ 上的 $F$ 自同构 $phi$ 将 $alpha$ 映到其最小多项式的另一个根。\
      假设 $f(x) = p(x)g(x), deg p(x) = 2$ 且 $p(x) in E[x]$ 不可约。不难发现：
      $
      p(x) "不可约" <=> phi(p(x)) "不可约"\
      p(x) | f(x) => phi(p(x)) | phi(f(x)) = f(x)\
      p(x) in.not F[x] => p(x) != phi(p(x)) 
      $
      不妨设 $p(x)$ 首一 ，$phi(p(x))$ 不可能与 $p(x)$ 相伴。如若不然，设 $phi(a_i) = lambda a_i$，考虑首项发现 $phi(a_i) = a_i => phi(p(x)) = p(x)$，矛盾
      表明 $f(x)$ 至少有两个不可约二次因子，进而是三个不可约二次因子的乘积。\
      - 我们还需要证明 $f(x)$ 不会有二重二次因子，否则设 $p(x)^2 | f(x)$，显然有：
        $
        (phi(p(x)))^2 | f(x)
        $
        但 $phi(p(x))$ 与 $p(x)$ 应当互素，进而：
        $
        (p(x) phi(p(x)))^2 | f(x)
        $
        但是考察次数，这是荒谬的
      - 因此，$f(x)$ 有三个不同的不可约二次因式 ${p_1, p_2, p_3}$。同时注意到 $phi$ 是单射，因此群 ${id, phi}$ 在其上的作用给出 ${id, phi}$ 同构于 $S_3$ 的某个二阶子群。但这样的子群总是对换，进而 $exists i, phi(p_i) = p_i$，矛盾
    - 可约但无一次，二次不可约因式，此时只能是两个三次不可约因式的乘积。\
  == 
    容易验证 $i in.not QQ(sqrt(3))$，因此 $[QQ(sqrt(3), i) : QQ] = 4$\
    而 $[QQ(root(3, 2)) : QQ] = 3$ 与 $4$ 互素，因此：
    $
    [QQ(sqrt(3), i, root(3, 2)) : QQ] = 12
    $
    通过在 $(x-y)^3 = 2$ 中利用 $y^2 = 3$ 消去 $y$ 可得 $sqrt(3) + root(3, 2)$ 的一个六次零化多项式 $f(x)$。同时容易发现 $[QQ(sqrt(3) + root(3, 2)) : QQ] = [QQ(sqrt(3), root(3, 2)) : QQ] = 6$，因此这是一个最小多项式。\
    同时，不难发现我们任取 $y^2 = 3$ 的根 $alpha$ 和 $z^3 = 2$ 的根 $beta$，均有 $f(beta + alpha) = 0$，因此：
    $
    plus.minus sqrt(3) + root(3, 2) xi^i, i =0, 1, 2
    $
    （其中 $xi = 1/2 + sqrt(3)/2 i$ 是三次单位根）\
    共计六个数都是 $f(x)$ 的根，恰好就是 $f(x)$ 的所有根，且它们都在 $QQ(sqrt(3), i, root(3, 2))$ 上，进而多项式 $f(x)$ 分裂。\
    另一方面，容易发现 $sqrt(3), i, root(3, 2)$ 都可被这六个根生成，因此 $sqrt(3), i, root(3, 2)$ 就是该多项式的分裂域。
  ==
    前面已经证明了 $K = F(alpha)$。设 $alpha$ 的极小多项式为：
    $
    x^2 + a x + b = 0
    $
    由于 $char F != 2$，我们仍然可以用配方法解出根：
    $
    x = -a/2 plus.minus sqrt(a^2 - 4b)/2
    $
    显然 $alpha in F(sqrt(a^2 - 4b))$，考虑扩张次数可得 $F(alpha) = F(sqrt(a^2 - 4b))$
  == 
    + 注意到 $f(x)$ 在 $ZZ_2[x]$ 中没有根，进而不可约，从而在 $ZZ[x]$ 中不可约，也在 $QQ[x]$ 中不可约\
    + 令 $x = t + 1/t$，代入 $f(x) = 0$ 得：
      $
      0 = (t + 1/t)^3 - 3(t + 1/t) + 1 = t^3 + 3t + 3/t + 1/t^3 - 3t - 3/t + 1 \
      = t^3 + 1/t^3 + 1\
      <=> t^6 + t^3 + 1 = 0
      $
      当且仅当 $t^3$ 是 $x^2 + x + 1 = 0$ 的根，也即三次单位根 $e^((2 pi i)/3), e^((4 pi i)/3)$，容易发现 $alpha, beta, gamma$ 均符合要求
    + 注意到：
      $
      alpha^2 = omega^2 + omega^(-2) + 2 in F(alpha) => beta = omega^2 + omega^(-2) in F(alpha)\
      beta^2 = omega^4 + omega^(-4) + 2 in F(alpha) => gamma = omega^4 + omega^(-4) in F(alpha)
      $
      因此 $f(x)$ 在 $F(alpha)$ 中分裂，同时 $alpha$ 当然在 $f(x)$ 的分裂域中，因此 $F(alpha)$ 就是 $f(x)$ 的分裂域
    + 显然 $QQ(alpha)$ 上的自同构都应该保持 $QQ$ 不变，同时作用在 ${alpha, beta, gamma}$ 上给出一个置换 $sigma$。\
      注意到 $1, alpha, alpha^2$ 是域扩张的一组基，因此除了平凡同构外，显然不应有 $sigma(alpha) = alpha$，其余两根同理。\
      换言之，$sigma$ 只能是三轮换。\
      同时，任给三轮换 $sigma$，变换：
      $
      a + b alpha + c alpha^2 -> a + b sigma(alpha) + c sigma(alpha)^2
      $
      （注意到 $1, sigma(alpha), sigma(alpha^2)$ 也是一组基）给出一个 $QQ-$ 自同构\
      且这是唯一一个在 ${alpha, beta, gamma}$ 上的作用为 $sigma$ 的自同构，因此所求自同构群就是由 $(123)$ 生成的子群。\
  ==
    令 $E = QQ[root(p, 2), xi_p]$
    + 显然 $f(x)$ 在 $E$ 上分裂。反之，由于 $f(x)$ 的所有根形如：
      $
      root(p, 2) xi_p^i i=0,1, 2,..., p-1
      $
      故 $root(p, 2), xi_p$ 都在 $f(x)$ 分裂域中，进而 $E$ 就是分裂域

    + \
      - 利用补充题 11 的结论，$root(p, 2)$ 的最小多项式就是 $x^p - 2$ ，因此 $[QQ(root(p, 2)):QQ] = p$
      
      - 其次，熟知 $xi_p$ 的最小多项式为：
        $
        (x^p - 1)/(x-1)
        $ 
        （由埃森斯坦判别法）它是 $p-1$ 次不可约多项式，因此 $[QQ(xi_p):QQ] = p-1$
      
      - 由于 $p$ 与 $p-1$ 互素，故 $[E:QQ] = p(p-1)$
    + \
      同样利用补充题 11 的结论，若它可约，则它应当有根 $alpha$，但 $alpha$ 的最小多项式的次数为 $p$ ，考虑扩张次数这是荒谬的。
  ==
    由熟知结论，存在 $E$ 上的 $F-$ 自同构 $phi$ 使得：
    $
    phi(alpha) = beta
    $
    设 $alpha, beta$ 在 $f(x)$ 的重数分别为 $r_1, r_2$，则有：
    $
    (x - alpha)^(r_1) | f(x) => (phi(x - alpha))^(r_1) | phi(f(x)) = f(x) => (x- beta)^(r_1) | f(x) => r_2 >= r_1
    $
    同理可得 $r_1 >= r_2$，进而 $r_1 = r_2$，结论正确
  ==
    注意到 $x^p - a$ 的所有根恰为：
     $
     x_i := root(p, a) xi_p^i, i = 0, 1, 2, ..., p-1
     $
    设它在域 $F[x]$ 上有不可约因子 $p(x)$，从而 $p(x)$ 在 $CC[x]$ 中一定形如：
      $
      product_j^k (x - x_(i_j))
      $
    观察其常数项，恰为：
    $
    product_j^k root(p, a) xi_p^(i_j) =  a^(k/p) xi^(sum_j^k i_j) in F
    $
    然而我们发现：
    $
    (a^(k/p) xi^(sum_j^k i_j))^p = a 
    $
    表明 $a^(k/p) xi^(sum_j^k i_j)$ 是 $F$ 中一个 $x^p - a$ 的根，与条件矛盾！