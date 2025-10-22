#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业12",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= ex 1.5
  == 1
    #let CC = $cone(C)$
    注意到：
    $
    d^CC_n vec(c_(n-1), c_n) = vec(-d_(n-1) (c_(n-1)), d_n (c_n) - c_(n-1))
    $
    由于它确实是复形，验证正合只需任取 $vec(c_(n-1), c_n) in ker d^CC_n$，验证它在 $im d^CC_(n+1)$ 中即可。事实上：
    $
    vec(-d_(n-1) (c_(n-1)), d_n (c_n) - c_(n-1)) = 0 <=> c_(n-1) in ker d_(n-1) inter im d_n, c_(n-1) = d_n (c_(n))\
    d^CC_(n+1) vec(-c_(n), 0) = vec(d_(n) (c_(n)),  c_(n)) = vec(c_(n-1), c_(n) )
    $
    上两式表明：
    $
    forall vec(c_(n-1), c_n) in ker d^CC_n, vec(c_(n-1), c_(n) ) = d^CC_(n+1) vec(-c_(n), 0) in im d^CC_(n+1)
    $
    足以给出正合性，同时表明题设的 $s$ 满足：
    $
    d s|_(ker d) = id \
    d s|_(ker d) d = d \
    d s|_(im d) d = d \
    d s d = d \
    $
    表明确实是分裂映射
  == 2
    零调的定义是存在 $s$ 满足 
    $
    f = d_D s + s d_C
    $<def-null>
    而题设映射是复形间态射等价于：
    $
    (-s, f) mat(-d_C, 0;-id, d_C) vec(c', c) = d_D (-s, f) vec(c', c)\
    (s d_C - f, f d_C) vec(c', c) = d_D (-s, f) vec(c', c)\
    
    $
    表明：
    $
    cases(
      s d_C - f = -d_D s,\
      f d_C = d_D f
    )
    $
    其中 $f d_C = d_D f$ 来源与复形同态的定义，当然有上式与@def-null 等价
    
  == 3
    $f tilde g$ 的定义是存在 $s$ 使得：
    $
    f - g = d_D s + s d_C
    $<def-hom>
    而题设映射是复形间同态等价于：
    $
    (f, s, g)mat(d_C, id, 0;0, -d_C, 0;0, -id, d_C) = d_D (f, s, g)
    $
    也即：
    $
    cases(
      f d_C = d_D f,
      g d_C = d_D g,
      f - s d_C - g = d_D s
    )
    $
    其中前两者是复形同态的定义，当然与@def-hom 等价
= ex 2.1
  == 2
    只证明同调 $delta-$函子情形，余调是类似的\
    任给 $delta-$函子 $S$ 和自然变换 $f_0 :S_0 -> T_0$，既然 $T_n = 0$，当然 $f_n : S_n -> T_n$ 在 $n >= 1$ 时取并且只能取零映射，这就给出了泛性质
= ex 2.2
  == 1
    - 首先，假设 $P$ 是 $C$ 中投射对象。显然它的每一项都是投射对象，由前面的命题只需证明存在 $s: P -> P$ 使得 $(-s, id): cone(P) -> P$ 是复形间的同态。
      不难发现有交换图：
      #align(center)[#commutative-diagram(
      node((0, 0), $...$, 1),
      node((0, 1), $P_(n-1) directSum P_n$, 2),
      node((0, 2), $P_(n-2) directSum P_(n-1)$, 3),
      node((1, 0), $...$, 4),
      node((1, 1), $P_(n-1)$, 5),
      node((1, 2), $P_(n-2)$, 6),
      arr(1, 2, $$),
      arr(2, 3, $mat(-d_C, 0;-id, d_C)$),
      arr(4, 5, $$),
      arr(5, 6, $-d_(n-1)$),
      arr(1, 4, $$),
      arr(2, 5, $id directSum 0$),
      arr(3, 6, $id directSum 0$),)]
      换言之，$cone(P) -> P$ 间存在满同态，由投射对象的性质，将有交换图：
      $
      #align(center)[#commutative-diagram(
      node((0, 0), $cone(P)$, 1),
      node((0, 1), $P$, 2),
      node((1, 0), $P$, 3),
      arr(1, 2, $id directSum 0$),
      arr(3, 2, $id$),
      arr(3, 1, $exists s'$),)]
      $
      设 $s' = vec(s'_(1),  s'_(2))$，交换图给出：
      $
       s'_(1) = id: P_(n-1) -> P_(n-1)\
      $
      是复形间同态给出：
      $
      mat(-d, 0;-id, d) vec(s'_(1), s'_2) = vec(s'_(1), s'_2)( -d) \
      -id + d s'_2 = -s'_2 d\
      d s'_2 + s'_2 d = id
      $
      由熟知的定理，这给出 $P$ 确实是分裂的正合列
    - 反之，假设 $P$ 是分裂的投射对象构成的正合列，任给 $X ->^f Y$ 是满射和 $P ->^g Y$，至少存在逐项的同态 $h: P_n -> X_n$ 使得：
      $
      f h = g
      $
      注意到：
      $
      id = d s + s d\
      $
      令 $h' = d h s + h s d$，将有：
      $
      f h' = f d h s + f h s d = d f h s + f h s d = d g s + g s d = g(d s + s d) = g\
      d h' = d h s d = h' d
      $
      表明 $h'$ 就是要找的复形间同态
  == 2
    设有复形 $X_i$，并且 $X_i$ 分别成为投射对象 $P_i$ 的满射像。设 $pi: P_i -> X_i$ 是满射
    断言有交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $X_i$, 1),
    node((0, 1), $X_(i-1)$, 2),
    node((1, 0), $P_i directSum P_(i+1)$, 3),
    node((1, 1), $P_(i-1) directSum P_i$, 4),
    arr(1, 2, $d$),
    arr(3, 1, $(pi, d pi)$),
    arr(4, 2, $(pi, d pi)$),
    arr(3, 4, $mat(0, 0;1, 0)$),)]
    不难验证下面一行是投射模构成的链复形，且：
    $
    d(pi, d pi) = mat(-, 0;1, 0)(pi, d pi)
    $
    因此交换图表成立，这是链复形之间的满态射。此外，取：
    $
    s = mat(0, 1;0, 0): P_(i-1) directSum P_i -> P_i directSum P_(i+1) 
    $
    不难验证将有：
    $
    d s d = d
    $
    因此下面一行构成分裂的正合列，上面结论表明它是投射对象，证毕
= ex 2.3
  == 1
    #let xl = $overline(x)$
    #let yl = $overline(y)$
    #let ul = $overline(u)$
    #let vl = $overline(v)$
    #let dl = $overline(d)$
    #let pl = $overline(p)$
    由 Baer 法则，只需验证任给 $R = ZZ quo m ZZ$ 的理想 $J$ 以及 $f: J -> R$ 都可以延拓到 $R -> R$\
    事实上，注意到 $R$ 是主理想环，可设 $J = (xl)$ 以及 $f(xl) = yl$（此时 $f$ 被唯一确定）\
    由于 $f$ 是加法循环群之间的同态，将有：
    $
    yl^(ord(xl)) = 0 => ord(yl) | ord(xl) 
    $
    根据循环群的结论，$RR$ 中阶为 $ord(xl)$ 子群 $(xl)$ 恰有一个，而 $(yl)$ 只能是其子群，进而可设：
    $
    yl = ul xl
    $
    因此：
    $
    f' := [t: R -> ul t]
    $
    就是 $f$ 的一个延拓，证毕

    对于第二个结论，假设 $d|m, p | m, m /d$，则 $ ZZ quo d ZZ$ 是 $R$ 的一个理想，也是加法子群，进而可设为唯一的 $d$ 阶子群 $(xl)$，同时设 $m/d$ 阶子群为 $(yl)$，$p$ 阶子群为 $(pl)$，则有：
    $
    (pl) subset (xl), (yl)
    $
    考虑群同态（也是模同态）：
    $
    funcDef(f, (yl), (xl), yl, pl)
    $
    假设它是 $f': R -> (xl)$ 的一个限制，并设：
    $
    f'(1) = ul xl
    $
    则 $f'(yl) = ul xl yl = pl$\
    然而注意到：
    $
    d = ord(xl) = m/(gcd(x, m))\
    m/d = ord(yl) = m/(gcd(y, m))\
    gcd(x, m) gcd(y, m) = m \
    m/(gcd(x, m)) = gcd(y, m) | y => m | y gcd(x, m) = gcd(x y, m) => gcd(x y, m) = m
    $
    意味着 $xl yl = 0 => pl = 0$，矛盾！
  == 2
    设 $a in A, e_A (a) = 0$，由定义，这将意味着：
    $
    forall f in Hom(A, QQ quo ZZ), f(a) = 0
    $
    然而考虑映射：
    $
    funcDef(h, (a), QQ quo ZZ, a, 1/2)
    $
    只要 $a != 0$ 上式就是群同态\
    由内射对象的性质，有交换图：
    #align(center)[#commutative-diagram(
    node((0, 0), $(a)$, 1),
    node((0, 1), $A$, 2),
    node((1, 0), $QQ quo ZZ$, 3),
    arr(1, 2, $id$, inj_str),
    arr(2, 3, $exists h'$),
    arr(1, 3, $h$),)]
    显然 $h' in Hom(A, QQ quo ZZ), h'(a) !=0$，这表明 $e_A (a) = 0$ 除非 $a = 0$，也即 $e_A$ 是单射
  == 3
    $A = 0$ 时显有 $Hom(A, QQ quo ZZ) = 0$，反之由于上面给出了 $A -> Hom(QQ quo ZZ)$ 的单射，当然后者为零意味着前者为零