#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业8",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
= P36
== 14
  设 $a^n = 0, b^m = 0$ ，只需验证：
  - $r a$ 幂零，$forall r in R$：
    $
    (r a)^n = r^n a^n = 0
    $
  - $a + b$ 幂零：
    $
    (a+b)^(n+m+1) = sum_(i=0)^(n+m+1) vec(n+m+1, i) a^i b^(n+m+1-i) = 0
    $
== 15
  只证右分配律。注意到：
  $
  x in (I + J)K <=> x = sum_i (a_i + b_i)k_i <=> x = sum_i a_i k_i + sum_i b_i k_i <=> x in I K + J K
  $
== 16
  考虑商环 $quotient(R, I)$，取自然同态 $pi: R -> quotient(R, I)$，并设 $I'$ 是 $quotient(R, I)$ 的幂零根，则有：
  $
  "rad"I = Inv(pi)(I')
  $
  由于同态 $R -> quotient(R, I) -> quotient((quotient(R, I)), I')$ 的核恰为 $"rad"I$，故 $"rad"I$ 是理想
== 18
  #set enum(numbering: "(1.") 
  + $a = a^n => phi(a) = phi(a^n) = (phi(a))^n$ 成立
  + 考虑映射：
    $
    funcDef(phi, ZZ_12, ZZ_3, a mod 12, a mod 3) 
    $
    容易验证它是将单位元映成单位元的满同态，但 $2$ 是 $ZZ_12$ 中的零因子（$2 dot 6 = 6 dot 2 = 0$），它的像 $2$ 不是零因子，故结论不成立。
  + 首先同态把交换环映成交换环成立：
    $
    phi(b) phi(a) = phi(b a) = phi(a b) = phi(a) phi(b)
    $
    但考虑 $ZZ -> ZZ_12$ 的自然同态，显然是满的，但前者是整环，后者有零因子
  + （2）中已经给出反例
  + $phi(a Inv(a)) = phi(a) phi(Inv(a)) = 1$，成立
  + 考虑自然同态 $ZZ -> ZZ_3$，后者是域而前者可逆元只有 $plus.minus 1$，故不成立
== 21
  若 $r_i in I sect R_i$，显有 $sum_i r_i in I$\
  而对 $I$ 中任何一个元素 $x$，设：
  $
    1 = sum_i r_i space, r_i in R_i
  $
  自然有：
  $
    x = sum_i x r_i
  $
  而 $x r_i in I, R_i => x r_i in I sect R_i$，这就完成了证明。
= 补充题
== 
  对于前者，由于 $1_6 -> 1_3$，故加法群已经给出所有元素的像，容易验证它是环同态。\
  对于后者，同样考虑加法群，将有：
  $
  phi(0) = phi(1_3 + 1_3 + 1_3) = 3_6
  $
  矛盾！因此没有群同态。\
  一般的，断言 $Z_m -> Z_n$ 存在同态当且仅当 $n | m$
  - 先证明必要性，设 $d = gcd(m, n)$，$u m + v n = d$，则有：
  $
  phi(d) = phi(u m + v n) = phi(v n) = n phi(v) = 0
  $
  而 $d <= m$，从而这当且仅当 $d = m$，也即 $n | m$ 时成立。
  - 再证明充分性，设 $n | m$，则有 $m = n k$，考虑映射：
    $
    funcDef(phi, ZZ_m, ZZ_n, a mod m, a mod n)
    $
    由于 $a_1 = a_2 mod m => a_1 = a_2 mod n$，因此它是良定义的。容易验证这是环同态。
== 
  容易发现两者都对加减乘封闭。另一方面：
  $
  (a + b d)(a- b d) = a^2 -b^2 d^2 in R \
  => (a + b d)(1/(a^2 -b^2 d^2 )(a- b d)) = 1
  $
  表明对逆元也封闭（注意到不存在有理数 $a, b$ 使得 $a^2 = 2 b^2$ 或 $a^2 = 3 b^2$）

  假设 $phi$ 是之间的环同态，显然：
  $
  phi(n) = n phi(1) = n\
  phi(sqrt(2))phi(sqrt(2)) = phi(2) = 2
  $
  但 $QQ[sqrt(3)]$ 中没有平方为 $2$ 的元素，矛盾！
== 
  由题意知 $ker(phi)$ 是平凡理想，且 $ker(phi) != R$ 否则 $R'$ 将成为零环，因此 $ker(phi) = {0}$，$phi$ 是单同态
== 
  域当然是单环，只证充分性：
  设 $a in R$ 不可逆，考虑：
  $
  (a) = a R
  $
  将成为非平凡理想，矛盾！
== 
  任取 $y in phi(I sect J), x in I sect J and phi(x) = y$，显有：
  $
  x in I => y = phi(x) in phi(I)\
  x in J => y = phi(x) in phi(J)\
  $
  进而 $phi(I sect J) subset phi(I) sect phi(J)$。
  考虑 $ZZ -> ZZ_6$ 的自然同态，取 $I = 7ZZ, J = 5ZZ$，将有：
  $
  I sect J = {0} => phi(I sect J) = {0}\
  phi(I) = phi(J) = ZZ_6 => phi(I) sect phi(J) = ZZ_6
  $
== 
  $Z(R)$ 是子环：显然$0, 1 in Z(R)$，且：
  $
  a, b in Z(R) => r a = a r, r b = b r => r(a + b) = (a + b)r => a + b in Z(R)\
  a in Z(R) => r a = a r => r(-a) = (-a) r => -a in Z(R)\
  a, b in Z(R) => r a = a r, r b = b r => r(a b) = (a b)r => a b in Z(R) 
  $
  一个子环成为理想当且仅当它是原来的环，因此除非环是交换环否则它不是理想
== 
  $
  phi(f + g) = (f+g)(sqrt(2)) = f(sqrt(2)) + g(sqrt(2)) = phi(f) + phi(g)\
  phi(f g) = (f g)(sqrt(2)) = f(sqrt(2)) g(sqrt(2)) = phi(f) phi(g)\
  phi(1) = 1(sqrt(2)) = 1
  $
  从而这是同态。

  断言：$ker(phi) = (x^2 -2)$。
  事实上，$QQ[x]$ 上所有满足 $f(sqrt(2)) = 0$ 的多项式集合恰为 $(x^2 -2)$，因此设 $g in ZZ[x], g(sqrt(2)) = 0$，则有：
  $
  g = f_q (x^2 - 2) and f_q in QQ [x]\
  $
  设 $f_q$ 中所有系数的公分母为 $q$，则有：
  $
  q g = q f_q (x^2 - 2) and q f_q in ZZ[x]
  $
== 
  设 $I_M$ 是 $M_n(R)$ 的某个理想。记 $I_(i, j)$ 表示 $I_M$ 中所有矩阵的 $i j$ 元出现元素之并，容易验证它们都是 $R$ 的理想。\
  注意到，通过左右乘也可以任意调换行列，因此任何两个 $I(i, j)$ 都相等，记为 $I$。而\
  $
  (0, 0, ..., 0, epsilon_i, 0...,0)(a_(i j))(0, 0, ..., 0, epsilon_j^T, 0...,0) 
  $
  也就是给矩阵左乘只有 $i i$ 元为 $1$，其他都为零的矩阵，再右乘只有 $j j$ 元为 $1$，其他都为零的矩阵，将得到只有 $i, j$ 元为 $a_(i j)$，其他元素都为零的矩阵，由理想定义这个矩阵将在 $I_M$ 中。\
  故 $I epsilon_i epsilon_j^T subset I_M$，对任意 $i, j$ 都成立。\
  进一步，由加法封闭性，显然 $I_M = M_n (I)$
== 
  注意到 $1/(a^2 + b^2) (a - b i)$ 是 $a + b i$ 在 $CC$ 中的逆元，它在 $ZZ[i]$ 中当且仅当 $a^2 +b 2 = 1$，也即可逆元仅有 $1, -1, i, -i$\
  
  为了证明 $ZZ[i]$ 是主理想环，只需证明它是 Euclid 环即可。事实上，令 $N(a + b i) = a^2 + b^2$，对任意 $a, b in ZZ[i]$，取 $k = x + y i$ 满足：
  $
  |x - a/b| <1/2\
  |y - a/b| <1/2
  $
  则有：
  $
  N(a - b(x+y i))\
  = N(a/b - (x + y i))N(b)\
  <= 1/4 N(b)
  $
  从而满足 Euclid 环的定义，进而是主理想整环。
== 
  假设 $(f) = (2, x)$，则：
  $
  2 = f g, x = f h , space g, h in ZZ[x]
  $
  显然 $f != 1$，上式表明 $f = 2$，进而 $x = 2 h$，这是荒谬的，因此 $(2, x)$ 不是主理想。
== 
  由直和的运算定义，$I_i$ 显然是理想。而当 $n > 1$ 时，$1 in.not I_i$，因此不是子环。
==
  （1）：
    $
      (a, b)^2 = (a^2, b^2) = (a, b) => a^2 = a, b^2 = b
    $
    从而 $a, b$ 取值当然为 $0, 1, -1$

    同理，分别考虑 $ZZ_4$ 和 $ZZ_6$ 中幂等元。
    在 $ZZ_4$ 中：
    $
    0^2 = 0\
    1^2 = 1\
    2^2 = 0\
    3^2 = 1
    $
    在 $ZZ_6$ 中：
    $
    0^2 = 0\
    1^2 = 1\
    2^2 = 4\
    3^2 = 3\
    4^2 = 4\
    5^2 = 1
    $
    因此所有的幂等元就是 ${0,1} plus.circle {0, 1, 3, 4}$
  （2）
    $
    (1-e)^2 = 1 - 2 e + e^2 = 1 - e
    $
    若 $e = 0, 1$，结论显然成立，下设 $e != 0, 1$
    对任意 $x in R$，有：
    $
    x = x e + x (1-e)
    $
    同时：
    $
    x e = y (1 - e) => x e^2 = y(1-e)e = 0 => x e = y (1 - e) = 0
    $
    这就验证了确实是直和
  
= P89
  == 1
    显然 $I J subset I sect J$。\
    任取 $x in I sect J$，由互素知：
    $
    exists i in I, j in J: i + j = 1\
    => x i + x j = x
    $
    而 $x i in I J, x j in I J$，故 $x in I J$，证毕。
  == 3
    由题意，取：
    $
    i in I, k in K : i + k = 1
    $
    从而对任意 $j in J$：
    $
    j = i j + k j in I J + K J subset K + K J subset K
    $
    表明结论成立
  == 4
    由 1 中结论，$I sect J = I J$，而当然有 $I sect J subset K$，证毕
= 补充题
  == 
    - 第二同构定理，定义：
      $
      funcDef(phi, H, quotient(R, I), h , h + I)
      $
      容易验证它是同态，且：
      $
      ker(phi) = H sect I\
      im(phi) = {h + I | h in H} = H + I
      $
      从而由 $ker, im$ 的结论及第一同构定理知所有结论成立
    - 第三同构定理，定义：
      $
      funcDef(phi, quotient(R, I), quotient(R, J), r + I, r + J)
      $
      验证：
        - 良定义性由 $I subset J$ 给出
        - 同态显然，同时是满同态
        - $ker(phi) = {r + I| r in J} = quotient(J, I)$，从而结论成立
    - 对应定理：
      + 正面就是第三同构定理，而反面直接验证定义：
        $
        x, y in Inv(phi)(L) => phi(x), phi(y) in L => phi(x) + phi(y) in L => phi(x + y) in L \
        => x + y in Inv(phi)(L)\
        x in R, y in Inv(phi)(L) => phi(x) in R', phi(y) in L => phi(x) phi(y) in L => phi(x y) in L \
        => x y in Inv(phi)(L)
        $
      + $phi(Inv(phi)(L)) = L$ 由映射的性质是显然的，而 $Inv(phi)phi(J) = J$ 由加法交换群的对应定理直接成立
      + 上面命题已经给出证明
  == 
      $
      (x+y)^p = x^p + y^p\
      (x y)^p = x^p y^p
      $
      从而 $x -> x^p$ 是环同态
  == 
    - 取自然同态 $pi$，则：
      $
      0 = pi (sum_i a_i 10^i) = sum_i pi(a_i) pi(10)^i = sum_i a_i 
      $
    - 类似有：
      $
      0 = pi (sum_i a_i 10^i) = sum_i pi(a_i) pi(10)^i = sum_i a_i (-1)^i
      $
  == 
    验证：
    - $phi(f +  g) = (f+g)(x^2, x^3) = f(x^2 + x^3) + g(x^2+x^3) = phi(f) + phi(g)$
    - $phi(f g) = (f g)(x^2, x^3) = f(x^2 + x^3) g(x^2 + x^3) = phi(f) phi(g)$
    - $phi(1) = 1$
    显然 $phi(y^2 - x^3) = 0$，故 $(y^2 - x^3) subset ker(phi)$
    
    另一方面，取自然同态 $pi: F[x, y] -> quotient(F[x, y], (y^2 - x^3))$ 设 $f = sum_i (a_i (y^2) + y b_i (y^2))x^i$，则有：
    $
    &f in ker(phi) \
    <=>&f(x^2, x^3) = 0 \
    <=>&sum_i (a_i (x^6) + x^3 b_i (x^6))x^(2i) = 0\
    <=>&sum_i a_i (x^6) x^(2i) + x^3 sum_i b_i (x^6)x^(2i)= 0\
    $
    注意到前项中 $x$ 指数均为偶数，后者中均为奇数，因此：
    $
    0 = sum_i a_i (x^6) x^(2i) = sum_i b_i (x^6)x^(2i)
    $
    这表明：
    $
    pi(sum_i a_i (y^2 - x^3 + x^3) x^(i)) \
    = sum_i a_i (pi(y^2 - x^3 + x^3)) (pi(x))^(i)\
    = sum_i a_i (pi(x^3)) (pi(x))^(i)\
    = pi(sum_i a_i (x^3) x^(i))\
    $
    另一方面，$sigma = [f | f(x) -> f(x^2)]$ 是 $F[x]$ 上的单自同态，前式已给出 $sigma(sum_i a_i (x^3) x^(i)) = 0 $，进而 $sum_i a_i (x^3) x^(i) = 0$，故：
    $
    sum_i a_i (y^2) x^(i) in ker(pi) = (y^2 - x^3)
    $
    同理 $sum_i b_i (y^2) x^(i) in ker(pi)$，因此 $f in (y^2 - x^3)$，证毕。

    对于 $im(phi)$，注意到：
    $
    phi(x^i y^j) = x^(2i +3j) in im(phi), i, j >=0
    $
    容易验证这给出 $forall i > 1, x^i in im(phi)$\
    同时，显然 $1 in im(phi)$，而 $x in.not im(phi)$ 也是显然的，故结论成立。
  == 
    一方面，显然有 $phi(a_i) in phi(J)$\
    另一方面，若 $phi(a_i) in J'$，则有 $a_i in Inv((J'))$，从而：
    $
    J subset Inv((J')) => phi(J) subset phi(Inv((J'))) = J'
    $
    有定义知 $phi(J)$ 由 $phi(a_i)$ 生成。
  ==
    由对应定理：
    $
    quotient(B, phi(ker psi)) tilde.eq quotient(Inv(phi)(B), Inv(phi)(phi(ker psi)))) = quotient(A, ker phi + ker psi)
    $
    另一侧同理
  == 
    由对应定理：
    $
    quotient(pi(R), pi((a))) tilde.eq quotient(R, Inv(pi)(pi((a)))) 
    $
    另一方面：
    $
    Inv(pi)(pi((a))) = (a) + (b) = (a, b)
    $
    故结论成立
  == 
    考虑代入同态 $phi :=  [f in ZZ[x] | f -> f(i) in ZZ[i]]$，显然它是满同态，且若设 $f(x) = sum_k a_k x^(2k) + sum_k b_k x^(2k+1)$，则
    $
      &f(i) = 0\
      <=>& sum_k a_k i^(2k) + sum_k b_k i^(2k+1) = 0\
      <=>& sum_k a_k (-1)^k + sum_k b_k (-1)^k i = 0\
      <=>& sum_k a_k (-1)^k = sum_k b_k (-1)^k = 0
    $
    取自然同态 $pi: ZZ[x] -> quotient(ZZ[x], (x^2 + 1))$，则：
    $
    &pi(sum_k a_k x^(2k))\
    = &sum_k a_k pi((x^2 + 1 - 1)^k)\
    = &sum_k a_k pi((- 1)^k)\
    = &pi(sum_k a_k (- 1)^k)\
    = &0\
    $
    因此 $ker(phi) subset (x^2 + 1)$，而 $(x^2 + 1) subset ker(phi)$ 是显然的，故 $ker(phi) = (x^2 + 1)$，从而由第一同构定理知结论成立。
  == 
    首先，代入同态 $sigma := [f in RR[x]| f(x) -> f(x+1)]$ 给出 $RR[x]$ 上的一个自同构，因此由对应定理：
    $
    quotient(RR[x], (x^2 -2x +2)) tilde.eq quotient(RR[x], sigma(x^2 -2x +2)) = quotient(RR[x], (x^2 + 1))
    $
    另一方面，取代入同态 $phi: [f in RR[x] | f(x) -> f(i)]$，由于 $RR[x]$ 是主理想整环，$ker(phi)$ 中次数最低的非零多项式显然是 $x^2 + 1$，因此 $ker(phi) = (x^2 + 1)$，由第一同构定理知结论成立。
  == 
    令 $pi: ZZ -> quotient(ZZ, a^2 + b^2)$ 是自然同态。\
    按照如下规则构造 $phi: quotient(ZZ[i], a + b i) -> quotient(ZZ, a^2 + b^2)$：\
    任取 $x + y i + (a + b i) in quotient(ZZ[i], a + b i)$，由 $a, b$ 互素知存在 $u, v$ 使得：
    $
    y = u a + v b\
    $
    从而选取 $x + y i + (a + b i)$ 中代表元:
    $
    x + y i - (v + u i)(a + b i) = x - a v + b u in x + y i + (a + b i)
    $
    令 $phi(x + y i + (a + b i)) = pi(x - a v + b u)$\
    为了验证定义合理，需要以下事实：
    - 每个 $quotient(ZZ[i], a + b i)$ 等价类中有且只有一个元素恰在 $quotient(ZZ, a^2 + b^2)$ 中
    
      先说明唯一性，设 $x_1, x_2 in ZZ, x_1 + (a + b i) = x_2 + (a + b i)$，将有：
      $
      x_1 - x_2 = (u + v i)(a + b i) => a v + b u = 0, a u - b v = x_1 - x_2
      $
      但 $a v + b u = 0 <=> vec(u, v) = k vec(-a, b)$，进而：
      $
      x_1 - x_2 = a u - b v = k (a^2 + b^2) => pi(x_1) = pi(x_2)
      $
      这说明了唯一性，而存在性由上面的构造已经给出，这也说明了 $phi$ 是良定义的。
    - $phi$ 是同态，注意到若 $x_1 , x_2 in ZZ$，则当然有：
      $
      (x_1 + (a + b i)) + (x_2 + (a + b i)) = (x_1 + x_2) + (a + b i)\
      (x_1 + (a + b i)) (x_2 + (a + b i)) = x_1 x_2 + (a + b i)
      $
      且 $x_1 + x_2, x_1 x_2 in ZZ$，这表明：
      $
      phi((x_1 + (a + b i)) + (x_2 + (a + b i))) = pi(x_1 + x_2) = pi(x_1) + pi(x_2) \
      = phi(x_1 + (a + b i)) + phi(x_2 + (a + b i))\
      phi((x_1 + (a + b i)) (x_2 + (a + b i))) = pi(x_1 x_2) = pi(x_1) pi(x_2) \
      = phi(x_1 + (a + b i)) phi(x_2 + (a + b i))\
      $
      从而确实是同态
      //$
      //u_1 a + v_1 b = y_1\
      //u_2 a + v_2 b = y_2
      //$
      //则：
      //$
      //(u_1 + u_2) a + (v_1 + v_2) b = y_1 + y_2\
      //(x_1 u_2 + x_2 u_1) a + (x_1 v_2 + x_2 v_1) b = x_1 y_2 + x_2 y_1
      //$
      //这表明：
      //$
      //phi(x_1 + x_2 + y_1 i +y_2 i + (a + b i)) = pi(x_1 + x_2 + (u_1 + u_2)b - (v_1 + v_2)a)\
      //= pi(x_1 - v_1 a + u_1 b) + pi(x_2 - v_2 a + u_2 b) \ = phi(x_1 + y_1 i + (a + b i)) + phi(x_2 + y_2 i + (a + b i))
      //$
      //说明保持加法
      //$
      //phi((x_1 + y_1 i + (a + b i))(x_2 + y_2 i + (a + b i))) \
      //= phi((x_1 x_2 - y_1 y_2) + (x_1 y_2 + x_2 y_1)i + (a + b i))\
      //= pi((x_1 x_2 - y_1 y_2) + (x_1 u_2 + x_2 u_1)b - (x_1 v_2 + x_2 v_1)a)\
      //= pi((x_1 x_2 - (u_1 a + v_1 b)(u_2 a + v_2 b)) + (x_1 u_2 + x_2 u_1)b - (x_1 v_2 + x_2 v_1)a)\
      //= pi((x_1 x_2 - (u_1 u_2 a^2 + v_1 v_2 b^2 + (u_1 v_2 + u_2 v_1)a b)) + (x_1 u_2 + x_2 u_1)b - (x_1 v_2 + x_2 v_1)a)\
      //= pi((x_1 x_2 + (u_1 u_2 + v_1 v_2)(a^2 + b^2) - (u_1 u_2 a^2 + v_1 v_2 b^2 + (u_1 v_2 + u_2 v_1)a b)) + (x_1 u_2 + x_2 u_1)b - (x_1 v_2 + x_2 v_1)a)\
      //= pi((x_1 x_2  + (v_1 v_2 a^2 + u_1 u_2 b^2 - (u_1 v_2 + u_2 v_1)a b)) + (x_1 u_2 + x_2 u_1)b - (x_1 v_2 + x_2 v_1)a)\
      //= pi((x_1 x_2  + (v_1 a - u_1 b)(v_2 a - u_2 b)) + (x_1 u_2 + x_2 u_1)b - (x_1 v_2 + x_2 v_1)a)\
      //= pi(x_1 - (v_1 a - u_1 b)) pi(x_2 - (v_2 a - u_2 b)) \
      //= phi(x_1 + y_1 i + (a + b i)) phi(x_2 + y_2 i + (a + b i))
      //$
      //说明保持乘法
    - $phi$ 是满射：显然 $phi(n + (a + b i)) = pi(n), forall n in ZZ$，故当然是满射
    - $phi$ 是单射，由于每个陪集中有且只有一个元素属于 $ZZ$，故：
    $
    phi(X) = 0
    $ 当且仅当 $k(a^2 + b^2) = k(a+ b i)(a - b i) in X <=> X = 0 + (a + b i)$
    
    综上，结论成立
  ==
    先逆用中国剩余定理，将方程组拆解为：
    $
    cases(
      5x = 3 mod 8,
      x = 1 mod 3,
      x = 1 mod 5,
      3x = 1 mod 4,
      3x = 3 mod 5
    )
    $
    化简为：
    $
    cases(
      5x = 3 mod 8,
      x = 1 mod 3,
      x = 1 mod 5,
      x = 3 mod 4,
    )
    <=>
    cases(
      x = 7 mod 8,
      x = 1 mod 3,
      x = 1 mod 5,
    )
    $
    而 $3 dot 5 dot 8 = 120$，$31$ 是一个特解，因此所有解为：
    $
    x = 31 mod 120
    $
 == 
    显然，$x^2 = 1$ 表明 $x$ 与 $600$ 互素。\
    另一方面，由中国剩余定理，$x^2 = 1 mod 600$ 等价于：
    $
    cases(
      x^2 = 1 mod 8,
      x^2 = 1 mod 3,
      x^2 = 1 mod 25,
    )
    $
    枚举得：
    $
    cases(
      x = 1\, 3\, 5\, 7 mod 8,
      x = 1\, 2 mod 3,
      x = 1\, 24 mod 25,
    )
    $
    从而所有可能答案为：\
    #let temp1(x, y, z) = calc.rem(x*225 + y *400 + z * (24 * 24), 600)
    #let print_enum = {
      let totalprod = 1
      let process = ()
      for x in (1, 3, 5, 7) {
        for y in (1, 2) {
          for z in (1, 24) {
            [$(#x, #y, #z) : #temp1(x, y, z) mod 600 $\ ]
            totalprod = calc.rem(totalprod * temp1(x, y, z), 600)
            process = process + (temp1(x, y, z),)
          }
        }
      }
      [最终的乘积为：
      $
      &#(process.map(str).join(sym.times))\ = &#totalprod mod 600
      $ ]
    }
    #print_enum
