#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业12",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
= 12.14
  == P125
    ===
      设 $f(x) = x^(p^e) - alpha$ 的分裂域为 $K$，在 $K$ 上显然有：
      $
      f(x) = (x - beta)^(p^e)
      $
      设 $beta$ 在 $F$ 上最小多项式为 $h(x)$，显有 $h(x) = (x- beta)^n$，且 $h(x)$ 不可约，这将意味着 $f(x) in (h(x))$ ，从分解式看出 $h(x) = (x-beta)^(p^i)$\
      然而，这将意味着 $beta^(p^i) in F$, $alpha = beta^(p^e) = (beta^(p^(e-1)))^p = ((beta^(p^(i)))^(p^(e-1-i)))^p in F^p$，矛盾！
    ===
      +
        假设 $f(x)$ 可分，将有 $f(x) = g(x^p) => p | deg(f(x))$，矛盾
      +
        任取 $alpha in K$，它的最小多项式的次数是扩张次数的因子，因此也与 $p$ 互素。由 1 知 $alpha$ 可分，进而这是可分扩张
    ===
      - 假设 $quotient(K, F)$ 可分，则：
        - $forall alpha in K$ 在 $E$ 上的最小多项式是在 $F$ 上最小多项式的因子，当然也无重根，因此 $quotient(K, E)$ 可分
        - $forall beta in E$ 在 $F$ 上的最小多项式也是将其看作 $K$ 中元素时在 $F$ 上的最小多项式，当然无重根，进而 $quotient(E, F)$ 可分
      - 假设 $quotient(K, E), quotient(E, F)$ 均可分\
        任取 $alpha in K$
        - 若 $alpha in E$，显然 $alpha$ 在 $F$ 可分
        - 反之，取 $alpha$ 在 $E$ 上最小多项式 $h(x)$，不妨设 $K = E(alpha)$, $E$ 恰好是 $F$ 扩充所有 $h(x)$ 的系数，进而扩张都是有限扩张，而有限扩张的情形由书上命题的断言是显然的。
    ===
      + $sqrt(2) + sqrt(3)$ 就是一个本原元，只需注意到这个扩张次数只能为2或4，但 $sqrt(6)$ 也在扩张之中，因此只能是 4\
      + 类似上面可以证明 $sqrt(3) + i $ 就是一个本原元。
    ===
      + 
        $K$  中元素均形如 $h = f(x, y)/g(x, y)$, 从而：
        $
        h^p = (f^p (x, y))/(g^p (x, y)) = (f(x^p, y^p))/(g(x^p, y^p)) 
        $ 
        因此结论成立
      + 
        容易看出 $quotient(K, F)$  中所有元素的最小多项式不超过 $p$ 次（$forall x in K, x^p in F$），但扩张次数为 $p^2$，因此不能成为单扩张
      +
        任取 $k in F$，$F(x+u y)$ 即是满足要求的中间域
        
  == 补充题
    === 
      显然有：
      $
      f(x)^p = (sum_i a_i x^i)^p = sum_i a_i^p x^(p i) = sum_i a_i x^(p i) = f(x^p)
      $
      进而：
      $
      sum_(i=0)^n vec(n, i) x^(p i) = (1 +x^p)^n = ((1 + x)^p)^n = (1 + x)^(n p) = sum_(i=0)^(n p) vec(n p, i) x^i
      $
      比照系数可得 $vec(p n, p r) = vec(n, r)$
    ===
      - 注意到有限域恰为 $x^(p^r) - x$ 的分裂域，且所有元素都是它的根。从而多项式：
      $
      x^(p^r) -x +1
      $
      将在这个域上没有根，进而不分裂。因此代数封闭域一定无限
      - 另一方面，设 $F$ 是特征 $p$ 的代数封闭域域。对任意 $alpha in F$ ，显然 $x^p - alpha$ 在 $F$ 上至少有一个根 $beta$，进而：
      $
      F^p = F
      $
      故它是完全域
    ===
      容易看出它在 $QQ(sqrt(2))$ 上可做不可约分解：
      $

      x^4 + 1 = (x^2 + sqrt(2) x + 1) (x^2 - sqrt(2) x + 1)
      $ 
      （后两者不可约是因为它们在 $RR$ 上没有根）
      而这两者都不在 $QQ$ 上，因此在 $QQ$ 上不可约。\
      若 $k=2$ 结论是显然的。\
      否则:
      - 若 $p = 1 mod 4$ 由于 $ZZ_p^times$ 是乘法群，因此存在 $a$ 使得：
        $
        a^(p-1) = 1, a^((p-1)/2) = -1
        $
        从而：
        $
        x^4 + 1 = (x^2 + a^((p-1)/2))(x^2 - a^((p-1)/2))
        $
        进而原多项式可约
      - 若 $p = 3 mod 4$，将有：
        $
        (2^((p+1)/4))^2 = 2^((p+1)/2) = 2^((p-1)/2) dot 2 = plus.minus 2
        $
        从而 $sqrt(plus.minus 2)$ 至少有一个在 $ZZ_p$ 上，因此分解：
        $
        x^4 + 1 = (x^2 + sqrt(2)x + 1)(x^2 - sqrt(2)x + 1)\
        x^4 + 1 = (x^2 + sqrt(-2)x - 1)(x^2 - sqrt(-2)x - 1)
        $
        至少有一个在 $ZZ_p$ 上，进而原多项式可约
    ===
      由于 $quotient(F(alpha), F)$ 是有限代数扩张，有有限的次数。令 $K ' = F(a_0, a_1, ..., a_n)$ ，显然 $K' subset K$\
      事实上，$g(x)$ 在 $K$ 上不可约表明 $g(x)$ 在 $K'$ 上当然也不可约，进而成为 $alpha$ 在 $K'$ 上的不可约零化多项式，也即一个最小多项式，因此有：
      $
      [K': F] = deg(g(x)) = [K : F]
      $
      这就表明 $K' = K$
    ===
      - 假设 $quotient(F(S), F)$ 是可分扩张，显然 $S$ 中所有元素均可分
      - 假设 $S$ 中所有元素均可分。任取 $alpha in F(S)$，显然可以选取 $S$ 中有限多个元素 $x_1, x_2, ..., x_n$ 使得：
        $
        alpha in F(x_1, x_2, ..., x_n)
        $
        利用有限扩张版本的熟知定理即可得 $alpha$ 可分。
= 12.18
  == P129
    === 
      之前已经证明了 $[K : QQ] = 2^n = |Gal(quotient(K, QQ))|$\
      归纳证明 $Gal(quotient(K, QQ)) = (Z_2)^n$\
      事实上，假设结论对 $n-1$ 成立，则考虑：
      $
      K_n = K_(n-1)(sqrt(p_n))
      $
      $K_n$ 恰好是 $K_(n-1)$ 上不可约多项式 $f(x) = x^2 - p_n$ 的分裂域，如此任取 $sigma in Gal(quotient(K_(n-1), QQ))$，注意到 $sigma(f(x)) = f(x)$，因此将存在延拓 $sigma', sigma''$ 满足：
      $
      sigma', sigma'' |_(K_(n-1)) = sigma\
      sigma' (sqrt(p_n)) = sqrt(p_n), sigma' (sqrt(p_n)) = -sqrt(p_n)
      $
      显然不同 $sigma$ 取值延拓出的 $sigma', sigma''$ 互不相同，这就得到 $2^n$ 个 $QQ-$自同构，恰好是 $Gal(quotient(K_(n), QQ))$ 中所有元素。\
      其次，不难发现这些延拓由 $K_(n-1)$ 的限制和 $sqrt(p_n)$ 的像唯一确定，不难验证 $Gal(quotient(K_(n), QQ)) tilde.eq Gal(quotient(K_(n-1), QQ)) times ZZ_2$，进而结论成立
    ===
      容易发现两题中整数根只能为 $plus.minus 1$，但都不是根，因此两多项式都不可约
      +
        判别式 $D = -4 dot (-3)^3 - 27 = 27 dot 3 = 81 in QQ^2$，因此 $Gal(quotient(K, QQ))$ 中元素作用于 ${alpha_1, alpha_2, alpha_3}$ 均为偶置换，进而 $Gal(quotient(K, QQ)) = A_3 = ZZ_3$，它没有非平凡子群
      +
        判别式 $D = -4 dot (-1)^3 - 27 = -23 in.not QQ^2$，表明 $Gal(quotient(K, QQ)) != A_3$，进而恰为 $S_3$，非平凡子群包括三个非正规的 2 阶子群和正规的 3 阶子群 $A_3$。\
        设三根分别为 $alpha_1, alpha_2, alpha_3$，对换 $(alpha_1, alpha_2)$ 对应不动域为：
        $
        QQ(alpha_3)
        $
        $A_3$ 对应不动域为：
        $
        QQ(sqrt(D)) = QQ(sqrt(-23))
        $
    ===
      注意到四个根恰为 $root(4, 2), root(4, 2)i, -root(4, 2)i, -root(4, 2)$\
      因此 $x^4 - 2$ 在 $QQ(i)$ 上没有根。\
      假设 $f(x)$ 有因子 $(x - z_1)(x-z_2)$，则 $(z_1 z_2)^2 = plus.minus sqrt(2) in QQ(i)$，这是荒谬的，因此 $f(x)$ 就是不可约多项式\
      因此分裂域恰为 $QQ(i, root(4, 2))$，扩张次数为 $4$\
      故 $|Gal(quotient(K, F))| = 4$，而其中的元素由 $root(4, 2)$ 的像唯一确定，容易验证：
      $
      root(4, 2) -> root(4, 2)i
      $
      的阶为 $4$，因此这就是 $ZZ_4$
    ===
      取 $theta = e^((2 pi i)/(p^n))$，容易发现 $x^(p^n) - 1$ 的所有根都形如 $theta^i, i = 0,1,2,..,.,p^(n-1)$\
      因此分裂域恰为 $QQ(theta)$\
      同时，$QQ(theta)$ 上所有 $Q-$自同构当然由 $theta$ 的像唯一确定，而任取自同构 $sigma$，$sigma(theta)$ 当然包含在 $theta^i$ 之中，且应该生成所有的 $theta^i$ 。这意味着 $sigma$ 与 $ZZ_(p^n)$ 的一个自同构一一对应，显然恰有 $p^n - p^(n-1)$ 个，这同时成为伽罗华群的阶数和扩张次数。\
      进一步，容易验证 $Gal(quotient(K, QQ)) = Z_(p^n)^times$，它是循环群
    ===
      由柯西方程，只需验证 $RR$ 上满足：
      $
      f(x) + f(y) = f(x + y)\
      f(x y) = f(x) f(y)\
      $
      的函数 $f(x)$ 一定单调，从而只能为恒同函数。\
      事实上，由：
      $
      f((sqrt(x))^2) = (f(sqrt(x)))^2 >=0
      $
      知 $forall x >= 0. f(x) >= 0$，进而函数单调上升，原命题成立。
  == 补充题
    === 
      显然后者当且仅当 $quotient(E, F)$ 即是可分扩张也是正规扩张，进而是伽罗华扩张
    ===
      $QQ -> QQ(sqrt(2)) -> QQ(root(4, 2))$，两个二次扩张均正规，但合成不是正规扩张
    ===
      伽罗华群的子群当然确定一个不动域，因此是满射。\
      当它是一一映射时，将立刻有 $"Inv" = Inv(Gal)$，进而 $"Inv"(Gal(quotient(K, F))) = F$，进而是伽罗华扩张
    ===
      容易发现 $E$ 是多项式：
      $
      (x^2 - 2)(x^2 - 3)(x^2 - 5)
      $
      的分裂域，从而是可分正规扩张即伽罗华扩张。\
      之前习题已经给出它的伽罗华群恰为 $(ZZ_2)^3$
    ===
      显然若 $i in E$，则 $[Q(i) : Q] | [E : Q]$，矛盾
    ===
      取 $a = (sqrt(2) + sqrt(2)i)/2$ 满足 $a^2 = i$，不难发现它的所有根恰为：
      $
      root(8, 2) a^k, k=0,1,2,...,7
      $
      因此 $E = QQ(a, root(8, 2)) = QQ(i, root(8, 2))$\
      由埃森斯坦判别法，$x^8 - 2$ 在 $QQ$ 上不可约。同时，容易验证 $i in.not QQ(root(8, 2))$，进而这是 16 次扩张\
      注意到 $QQ(i)$ 对应的子群是 8 阶子群，$QQ(root(8, 2))$ 对应 $2$ 阶子群，且两个子群的交只有平凡元，因此：
      $
      G = H_1 times.r ZZ_2
      $
      - 先考虑 $H_1$，由扩张次数可以看出 $x^8 - 2$ 也是 $QQ(i)$ 上不可约多项式，因此 $|H_1| = 8$，恰好将 $root(8, 2)$ 映到 $root(8, 2) a^k$\
      同时，取 $sigma in H_1: sigma(root(8, 2)) = root(8, 2) a$，应当有：
        $
        sigma(a) = (sigma(root(8, 2)^4) + sigma(root(8, 2)^4)i)/2 = - a = a^5
        $
        进而记 $sigma^k(root(8, 2)) = root(8, 2)a^(b_n)$，有：
        $
        b_n = 5 b_(n-1) + 1
        $
        从而列出 $b_n$:
        $
        0, 1, 6, -1, 4, -3, 2, 3, 0
        $
        表明 $sigma$ 确实是生成元
      - 其次，取 $sigma in H_1: sigma(root(8, 2)) = root(8, 2) a,  phi in H_2: phi(i) = -i$，将有：
        $
        sigma compose phi(root(8, 2)) = sigma(root(8, 2)) = root(8, 2) a\
        phi compose sigma(root(8, 2)) = phi(root(8, 2) a) = root(8, 2) phi(a) = root(8, 2) a^7 = sigma^3(root(8, 2))
        $
        因此两群中元素不交换，半直积由：
        $
        phi compose sigma compose phi = sigma^3
        $
        给出
    ===
      +
        记 $p(x) = f(x)/(x-1)$，则：
        $
        p(x+1) = f(x+1)/x = sum_(i=0)^6 vec(7, i+1)x^i
        $
        由埃森斯坦判别法这是不可约多项式。它的所有根当然是 $xi_7^k = e^((2 k pi i)/7)$\
        注意到 $E$ 可被任何一个根生成，特别的 $E = QQ(xi_7)$，所有 $QQ-$自同构将由 $xi_7$ 的像决定，容易验证恰为 $ZZ_7^times = ZZ_6$
      +
        $6$ 的每个因子恰对应一个子群，分别为：
        $
        {e}, ZZ_2, ZZ_3, ZZ_6
        $
        由伽罗华定理这就恰对应四个子域。显然 ${e}, ZZ_6$ 分别对应 $QQ, E$\
        $ZZ_2$ 的一个生成元为：
        $
        xi -> xi^6
        $
        它保持 $xi + Inv(xi) in E - Q$ 不动，因此 $QQ(xi + Inv(xi)) subset "Inv"(ZZ_2)$。考虑扩张次数 $3$ 是素数，只能取等。\
        $ZZ_3$ 的一个生成元为：
        $
        xi -> xi^2
        $
        它保持 $xi + xi^2 + xi^4$ 不动，考虑扩张次数它就是 $QQ(xi + xi^2 + xi^4)$
      +
        $29$ 是素数从而上面的证明同样成立，因此伽罗华群恰为 $ZZ_28$，它的子群恰为：
        $
        {e}, ZZ_2, ZZ_4, ZZ_7, ZZ_14, ZZ_28
        $
        除了平凡情况，生成元分别为：
        $
        xi -> xi\
        xi -> xi^28\
        xi -> xi^12\
        xi -> xi^7\
        xi -> xi^9
        $
        同样可以写出子域
    ===
      + 
        同态性，单、满射都容易验证
      +
        $
        (sum_i a_i t^i)/(sum_i b_i t^i) = sigma((sum_i a_i t^i)/(sum_i b_i t^i)) = (sum_i a_i (1/t)^i)/(sum_i b_i (1/t)^i) = \
        = (sum_i a_i t^i + sum_i a_i t^(-i))/(sum_i b_i t^i + sum_i b_i t^(-i)) := (f(t) + f(1/t))/(g(t) + g(1/t))
        $
        由对称多项式理论，将有：
        $
        f(t) + f(1/t) = k(t + 1/t, t dot 1/t) = k'(t+1/t)\
        g(t) + g(1/t) = h'(t + 1/t)
        $
        综上，$L = F(t + 1/t)$\
        接下来计算 $t$ 的最小多项式，注意到：
        $
        x^2 -(t + 1/t)x + 1
        $
        将成为 $t$ 的零化多项式，它是二次的，当然不可约，因此 $[F(t) : F(t + 1/t)] = 2$
      +
        上面已经给出
      +
        前面的证明都是类似的，生成元为 $t(1-t)$，$t$ 在其上最小多项式为：
        $
        x^2 -x + t(1-t)
        $
      +
        计算得：
        $
        sigma(tau(t)) = 1/(1-t)
        $
        令 $x = t, y = 1/(1-t), z = (t - 1)/t$，类似的被 $sigma compose tau$ 保持不动的有理分式均形如 $h(x, y, z)$，同时我们有：
        $
        x y z = 1\
        x y + y z + x z = t/(1-t) - 1/t + (t - 1) = (t^3 - 3t + 1)/(t(1-t))\
        x + y + z = 1/t + t/(1-t) + (t - 1)/t = (t^3 - 3t + 1)/(t(1-t)) = x y + y z + x z
        $
        因此被 $sigma compose tau$ 恰为 $E' = F(x + y + z)$，容易计算 $[E : E'] = 3$\
        同时 $sigma$ 并不保持其上所有元素，因此所有求 $L := Inv(G)$ 比其更小。此外，(2) 表明 $2 | [E : L]$，因此后者至少为 $6$\
        容易验证 $h$ 被 $sigma, tau$ 均保持，且最小多项式次数为 6（之前习题已经证明），因此恰好是一个生成元。
    === 
      我们不妨将 $x^9 - t$ 视作 $(ZZ_37 (t))[x]$ 上元素，进而由高斯引理，只需证明它在 $(ZZ_37 [t])[x]$ 不可约\
      令 $x^9 - t = h(x, t)k(x, t)$，观察次数和 $t$ 首项系数，有：
      $
      h(x, t) = h'(x) - h''(x)t\
      k(x, t) = k'(x)
      $
      且 $k'(x) h''(x) = 1 => k'(x) ~ h''(x) ~ 1$，从而它不可约。\
      对于可分性，求导发现：
      $
      (x^9 - t)' = 9 x^8 != 0\
      $
      进而结论成立\
      对于第二个结论，计算可得 $ZZ_37$ 上 $x^9 - 1$ 恰有 9 个不同的根 $1 = xi_0, xi_1, xi_2, ..., xi_8$，它们对乘法封闭，进而构成 $ZZ_37$ 的一个子群，当然是循环子群\
      其次，任取 $alpha$ 是 $x^9 - t$ 的一个根，显然：
      $
      alpha xi_i
      $
      恰为它的所有根，进而扩张的次数就是 $9$\
      显然每个 $ZZ_37-$自同构应该保持 $xi_i$ 并把 $alpha$ 映到 $alpha xi_k$。任给 $alpha$ 的像，可以唯一确定一个这样的映射（注意任何一个根都是生成元）。\
      因此记：
      $
      sigma_i : alpha -> alpha xi_i
      $
      将有：
      $
      sigma_i compose sigma_j (alpha) = alpha xi_i xi_j = alpha xi_(i+j)
      $
      因此伽罗华群恰为 $ZZ_9$
      

