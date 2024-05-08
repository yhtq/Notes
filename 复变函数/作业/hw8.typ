#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, seqLimit, seqLimitn
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#set heading(numbering: none)
（应交时间为5月9日）
= p111
  == 7
    若存在 $s$ 使得：
    $
    lim_(z -> a) abs(z-a)^s abs(f(z)) = 0
    $
    进而:
    $
    lim_(z -> a) abs(z-a)^([s] + 1) abs(f(z)) = lim_(z -> a) abs(z-a)^([s] - s + 1) abs(z-a)^s abs(f(z)) = 0
    $
    表明 $a$ 是 $(z-a)^([s]) f(z)$ 的可去奇点，进而是 $f$ 的极点或可去奇点\

    因此，考虑 $f$ 的 Laurent 展开式：
    $
    f(z) = sum_(n = -infinity)^(infinity) a_n (z-a)^n
    $
    其负项仅有有限性（可能没有），可设：
    $
    f(z) = sum_(n = -N)^(infinity) a_n (z-a)^n
    $
    其中 $a_(-N) != 0$，如此显然有：
    $
    forall s < -N, lim_(z -> a) abs(z-a)^s abs(f(z)) = 0\
    forall s > -N, lim_(z -> a) abs(z-a)^s abs(f(z)) = infinity
    $
    同时，若存在 $s$ 使得：
    $
    lim_(z -> a) abs(z-a)^s abs(f(z)) = infinity
    $
    - 此时 $a$ 不可能是 $f$ 零点的聚点，否则也是 $(z-a)^s f(z)$ 零点的聚点，与极限条件显然矛盾
    - 因此不妨取一个 $a$ 邻域其中无 $f$ 的零点，不难发现 $a$ 成为 $1/(f(z))$ 的可去奇点或极点，由上面的结论将存在 $m in ZZ$ 使得：
      $
      forall s < -m, lim_(z -> a) abs(z-a)^s abs(1/(f(z))) = 0\
      forall s > -m, lim_(z -> a) abs(z-a)^s abs(1/(f(z))) = infinity
      $ 
      表明可取得 $s$ 使得 $lim_(z -> a) abs(z-a)^(1/s) abs(1/(f(z))) = infinity, lim_(z -> a) abs(z-a)^s abs(f(z)) = 0$，回到之前情形
  == 9
    7 已经证明若两条件有一个成立，则 $a$ 不是本性奇点。

    反之，若两条件都不成立，显然 $a$ 不是极点或可去零点（否则存在 $m in ZZ$ 使得 $lim_(z -> a) abs(z-a)^m abs(f(z)) = 0$），因此是极点
  == 13
    === (a)
      若 $infinity$ 是可去零点，则有 $lim_(z -> 0) f(1/z)$ 存在（有限），也即 $lim_(z -> infinity) f(z)$ 存在，这使得整函数有界，当然只能是常数
    == (b)
      设 $f$ 在 $CC$ 上有幂级数展开：
      $
      f(z) = sum_(n = 0)^(infinity) a_n z^n
      $
      则：
      $
      f(1/z) = sum_(n = 0)^(infinity) a_n z^(-n)
      $
      由 $0$ 是 $f(1/z)$ 极点，上式仅有有限项，进而 $f$ 是多项式，次数也是容易验证的
    == (c)
      无妨设有理函数 $P / Q$ 在 $G$ 上无奇点（否则扩大 $G$ 将 $Q$ 的有限个零点排除即可），前面已经说明若 $infinity$ 是可去奇点，则 $lim_(z -> infinity) f(z)$ 存在，表明 $P, Q$ 具有相同的次数。

      反之，若 $P, Q$ 具有相同次数，则 $lim_(z -> infinity) f(z)$ 存在，继而 $lim_(z -> 0) f(1/z)$ 存在，这使得 $infinity$ 是可去奇点
    == (d)
      极点成立当且仅当存在（最小的） $m in ZZ^+$ 使得：
      $
      lim_(z -> 0) z^m f(1/z)   "存在"
      $
      当且仅当：
      $
      lim_(z -> infinity)  f(z)/z^m "存在"
      $
      而 $f(z)/z^m$ 还是有理函数，利用之前结论可得 $P, z^m Q$ 具有相同次数，即 $P$ 的次数比 $Q$ 多 $m$
  == 15
    无妨设 $omega = 0$，如若不然将有存在 $epsilon, delta$ 使得：
    $
    abs(f(B(0, delta) - {0})) > epsilon
    $
    不妨在 $B(0, delta) - {0}$ 上考虑 $1/(f(z))$，注意到 $1/f$ 在其上没有极点，而 $a_n$ 都是它的可去奇点。设：
    $
    g(z) = cases(
      0\, z = a_n,
      1/(f(z))\, z != a_n
    )
    $
    则 $g$ 是 $B(0, delta) - {0}$ 上的解析函数，$0$ 成为 $g$ 的孤立奇点，同时也是零点的聚点
    - 若 $0$ 是极点或可去奇点，则它是 $B(0, delta)$ 上亚纯函数，由非零亚纯函数零点无聚点知 $g$ 恒为零，这是荒谬的！
    - 因此 $0$ 是本性奇点，由 Casorati-Weierstrass 定理知 $g(B(0, delta) - {0})$ 在 $CC$ 中稠密，然而假设给出：
      $
      abs(f(B(0, delta) - {0})) > epsilon => abs(1/(f(B(0, delta) - {0}))) < 1/epsilon\
      => abs(g(B(0, delta) - {0})) < 1/epsilon
      $
      这是荒谬的！
    证毕
= p121
  == (a)
    $
    z^2/(z^4 + z^2 + 1) = (z^2(z^2 - 1))/(z^6 - 1)
    $
    因此分别设：
    $
    a_1 = e^(i (pi)/3)\
    a_2 = e^(i (2 pi)/3)\
    a_3 = e^(i (4 pi)/3)\
    a_4 = e^(i (5 pi)/3)
    $
    这是上面被积函数的四个（一重）极点，其中 $a_1, a_2$ 位于上半平面。\
    考虑路径 $-R -> R arrowCir -R$ （圆弧经过上半逆时针）并设 $R$ 足够大使得 $a_1, a_2$ 在区域内部，将有：
    $
    integral_(-R -> R)^()  z^2/(z^4 + z^2 + 1) dif z + integral_(R arrowCir -R)^()  z^2/(z^4 + z^2 + 1) dif z = 2 pi i (Res(f, a_1) + Res(f, a_2)) 
    $
    #let ei3(x) = $ei((ignoreOne(#x) pi)/3)$
    分别计算：
    - 
      $
      Res(f, a_1) &= lim_(z -> a_1) (z - a_1)z^2/(z^4 + z^2 + 1)\
                  &= lim_(z -> a_1) (z - a_1)z^2/((z - a_1)(z - a_2)(z - a_3)(z - a_4))\
                  &= a_1^2/((a_1 - a_2)(a_1 - a_3)(a_1 - a_4))\
                  &= ei3(2)/ ((ei3(1) - ei3(2))(ei3(1) - ei3(4))(ei3(1) - ei3(5)))\
                  &= 1/ ((ei3(5) - 1)(ei3(5) - ei3(2))(ei3(5) - ei3(3)))\
                  &= 1/ ((ei3(4) + 1)(ei3(5) - ei3(2)))\
                  &= 1/ (-1 -1 + ei3(5) - ei3(2))\
                  &= 1/ (-2 + 1 - sqrt(3) i)\
                  &= 1/ (-1 - sqrt(3)i)\
                  &= 1/2 (1 - sqrt(3)i)
      $
    - 
      $
      Res(f, a_2) &= a_2^2/((a_2 - a_1)(a_2 - a_3)(a_2 - a_4))\
                  &= overline(a_1^2/((-a_1 + a_2)(-a_1 + a_4)(-a_1 + a_3)))\
                  &= -1/2 (1 + sqrt(3)i)
      $
    - 
      #let eiBt(x) = $eiB(ignoreOne(#x) theta)$
      $
      integral_(R arrowCir -R)^()  z^2/(z^4 + z^2 + 1) dif z &= integral_(R arrowCir -R)^()  (R^2 eiBt(1))/(R^4 eiBt(4 ) + R^2 eiBt(2 ) + 1) dif R eiBt(1)\
      &= i  integral_(0)^(pi)  (R^3 eiBt(1))/(R^4 eiBt(4 ) + R^2 eiBt(2 ) + 1) dif theta\
      &= i  1/R integral_(0)^(pi)  ( eiBt(1))/( eiBt(4 ) + 1/R^2 eiBt(2 ) + 1/R^4) dif theta\
      $<inte>
      其中：
      $
      abs(( eiBt(1))/( eiBt(4 ) + 1/R^2 eiBt(2 ) + 1/R^4)) = 1/abs(eiBt(4 ) + 1/R^2 eiBt(2 ) + 1/R^4) <= 1/(1 - 1/R^2 abs(eiBt(2 ) + 1/R^2)) <= 2 (R "充分大时")
      $
      因此@inte 部分极限为零
    综上：
    $
    lim_(R -> +infinity) integral_(-R)^(R)  z^2/(z^4 + z^2 + 1) dif z = 2 pi i(- sqrt(3) i) = 2 sqrt(3) pi
    $
    从而：
    $
    integral_0^R z^2/(z^4 + z^2 + 1) dif z = sqrt(3) pi
    $
  == (c)
    令 $z = eiBt(1)$，则 $cos theta = (z + 1/z)/2, cos 2 theta = (z^2 + 1/z^2)/2$，有：
    $
    (cos 2 theta)/(1 - 2 a cos theta + a^2) = (z^2 + 1/z^2)/(2 - 2 a (z + 1/z) + 2 a^2) = (z^4 + 1)/(-2 a z^3 + (2 + 2 a^2)z^2  - 2 a z)\
    = -1/(2 z) (z^4 + 1)/(a z^2 - (1 + a^2) z + a)\
    = -1/(2) (z^4 + 1)/(z (z - a)(a z - 1))\
    $
    同时：
    $
    integral_(0)^(pi) (cos 2 theta)/(1 - 2 a cos theta + a^2) dif theta\
    = integral_(0)^(-pi) (cos 2 theta)/(1 - 2 a cos theta + a^2) dif (-theta)\
    = integral_(-pi)^(0) (cos 2 theta)/(1 - 2 a cos theta + a^2) dif theta\
    $
    因此：
    $
    integral_(0)^(pi) (cos 2 theta)/(1 - 2 a cos theta + a^2) dif theta = 1/2 integral_(-pi)^(pi) (cos 2 theta)/(1 - 2 a cos theta + a^2) dif theta\
    = 1/2 integral_(diff B(0, 1))  -1/(2) (z^4 + 1)/(z (z - a)(a z - 1)) dif theta\
    = -1/4 integral_(diff B(0, 1))  (z^4 + 1)/(z^2 (z - a)(a z - 1)) eiBt(1) dif theta\
    = 1/4 i integral_(diff B(0, 1))  (z^4 + 1)/(z^2 (z - a)(a z - 1))  dif eiBt(1)\
    = 1/4 i integral_(diff B(0, 1))  (z^4 + 1)/(z^2 (z - a)(a z - 1))  dif z\
    = 1/4 i dot 2 pi i( Res(f, 0) +  Res(f, a))\
    $
    分别计算：
    - 
      $
      Res(f, 0) = Res(1/z^2 (z^4 + 1)/((z - a)(a z - 1))) = ((z^4 + 1)/((z - a)(a z - 1)))'|_(z = 0)\
      = (- (-1 - a^2))/a^2 = ( a^2 + 1)/a^2
      $
    -
      $
      Res(f, a) = (z^4 + 1)/(z^2 (a z - 1))|_(z = a) = (a^4 + 1)/(a^2 (a^2 - 1))
      $
    因此：
    $
    &1/4 i dot 2 pi i( Res(f, 0) +  Res(f, a)) \
    &= - 1/2 pi ((a^2 + 1)/a^2 + (a^4 + 1)/(a^2 (a^2 - 1)))\
    &= - 1/2 pi ( (2 a^4 )/(a^2 (a^2 - 1)))\
    &= - 1/2 pi  (2 a^2 )/ (a^2 - 1)\
    &= ( a^2 )/ (1 - a^2) pi \
    $