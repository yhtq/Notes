#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, seqLimit, seqLimitn
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#set heading(numbering: none)
（应交时间为4月19日）
= p87
  == 5
    设：
    $
    F(z) = integral_(gamma)^() 1/(w-z) dif w
    $
    显然 $F(z) = n(gamma, z)$，由缠绕数的概念易知 $F'(z) = 0$\
    另一方面，有：
    $
    0 = F^((n))(z) = integral_(gamma)^() n!/(w-z)^(n+1) dif w
    $
    故结论成立
  == 8
    注意到：
    $
    0 = integral_(gamma)^() f_i (z) dif z
    $
    其中 $gamma$ 是任意绕 $a$ 的简单闭曲线，在上式中令 $i -> +infinity$ 并利用一致收敛性保证积分与极限交换顺序可得：
    $
    0 = integral_(gamma)^() f(z) dif z
    $
    这对所有区域内的简单闭曲线都成立，且 $f$ 的连续性是熟知的，由 Morera 定理可知 $f$ 是解析的
  == 9
    由 Morera 只需证明对于任意包裹 $[-1, 1]$ 的简单闭曲线都有：
    $
    integral_(gamma)^() f(z) dif z = 0
    $
    即可\
    事实上，任取这样一条曲线，都可以连续地变换到其他包含 $[-1, 1]$ 的曲线，且这样的变换根据柯西积分定理不改变积分值，因此可以让 $gamma$ 充分靠近 $[-1,1]$\
    任取 $epsilon > 0$，由于 $f$ 的连续性应当在紧集：
    $
    D := [-2, 2] times [-1, 1]
    $
    上一致连续并有上界 $M$，进而存在 $delta > 0$ 使得 $forall x, y in D, norm(x - y) <= 2delta => norm(f(x) - f(y)) < epsilon$\
    由 Morera 只需证明对于区域 $D$ 内任意三角形 $Delta$ 均有：
    $
    integral_(Delta)^() f(z) dif z = 0
    $
    即可
    - 若 $Delta$ 在 $[-1, 1]$ 的外部且与之不交，则结论显然
    - 否则，三角形可以连续收缩到一个与 $[-1, 1]$ 相交或包含它的梯形 $S$，使得 $S$ 的上底和下底与 $RR$ 平行且：
      $
      S subset [-1 - delta, 1 + delta] times [-delta', delta']
      $
      其中 $0 < delta' < delta$ 是任取的\
      更进一步，将梯形分为内部最大的正方形和两个三角形，分别计算在这些图形边界上的积分即可
      - 先考虑三角形，显然这个三角形是某个内角为原三角形某个内角 $theta$ 的直角三角形，且 $y$ 方向的直角边长度小于 $2 delta'$，进而周长小于 $k delta'$，其中 $k$ 与 $delta, delta'$ 都无关，是只与 $theta$ 有关的常数，因此两个三角形上的积分有估计式：
        $
        norm(integral_(Delta'_1 + Delta'_2) f(z) dif z) <= k' M delta'
        $
      - 再考虑矩形，设其上底为 $[a, b] times {c_1}$，下底为 $[a, b] times {c_2}$，矩形上的积分就是：
        $
        integral_(a)^(b) f(t + c_1 i) dif t + integral_(c_1)^(c_2) f(b + s i) dif s + integral_(b)^(a) f(t + c_2 i) dif t + integral_(c_2)^(c_1) f(a + s i) dif s
        $
        其中：
        $
        norm(integral_(c_1)^(c_2) f(b + s i) dif s + integral_(c_2)^(c_1) f(a + s i) dif s) &<= 2 abs(c_2 - c_1) M <= 2 delta' M\
        norm(integral_(a)^(b) f(t + c_1 i) dif t + integral_(b)^(a) f(t + c_2 i) dif t)
        &= norm(integral_(a)^(b) f(t + c_1 i) - f(t + c_2 i) dif t)\
        &<= integral_(a)^(b) norm(f(t + c_1 i) - f(t + c_2 i)) dif t\
        &<= integral_(a)^(b) epsilon dif t\
        &= epsilon (b - a)\
        &<= 4 epsilon
        $
      注意到上面所有式子中可以让 $delta', epsilon$ 任意小而不影响其它常数，因此原三角形上的积分就是零，得证
= p99
  == 1
    设 $C subset G$ 是包含 $gamma$ 的闭区域，可设 $f, f'$ 在其上有上界 $M$\
    任给一个 $[0 ,1]$ 的分划 $0 = x_0 < x_1 < ... < x_n = 1$，则：
    $
    &sum_(i=0)^(n-1) norm(f(gamma(x_(i+1))) - f(gamma(x_i))) \
    &= sum_(i=0)^(n-1) norm(integral_(x_i)^(x_(i+1)) f(gamma(t)) dif t)\
    &<= sum_(i=0)^(n-1) integral_(x_i)^(x_(i+1)) norm(f(gamma(t))) dif t\
    &<= sum_(i=0)^(n-1) M integral_(x_i)^(x_(i+1)) 1 dif t\
    &= M v(gamma)
    $
    表明 $f compose gamma$ 的有界变差有上界，当然意味着可求长
  == 4
    假设 $f'(a) = 0$，不妨通过平移令 $f(a) = 0$，此时 $a$ 是 $f$ 的二重零点，由本节引理知存在某个 $xi$ 使得 $a$ 周围将存在 $2$ 个不同点使得 $f(z) = xi$，这与 $f$ 是单射矛盾！