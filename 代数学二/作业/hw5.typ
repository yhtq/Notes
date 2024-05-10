#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, AModule, lemmaLinear[], tensorProduct, directSum
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
（应交时间为4月2日）
=
  也就是证明任意双线性映射 $f: (ZZ_m times ZZ_n) -> C$，均有 $f = 0$\
  事实上：
  $
  0 = f(m, 1) = m f(1, 1)\
  0 = f(1, n) = n f(1, 1) 
  $
  设 $u m + v n = 1$，则：
  $
  0 = u m f(1, 1) + v n f(1, 1) = f(1, 1)\
  0 = i j f(1, 1) = f(i, j)
  $
  证毕
=
  考虑正合列：
  $
  0 -> alpha -> A -> A quo alpha -> 0
  $
  由张量积的右正合性，下面的序列也正合：
  $
  alpha tensorProduct M -> A tensorProduct M -> A quo alpha tensorProduct M -> 0
  $
  这给出：
  $
  A quo alpha tensorProduct M tilde.eq (A tensorProduct M) quo (alpha tensorProduct M) tilde.eq M quo alpha M
  $
= 
  设 $m$ 是唯一极大理想，$k = A quo m$ 是留域，则：
  $
  k tensorProduct M tilde.eq (A quo m) tensorProduct M tilde.eq M quo (m M)
  $
  同时：
  $
  0 = (M tensorProduct N)_m = M_m tensorProduct N_m
  $
  注意到 $k$ 是域，$M_m, N_m$ 是其上的线性空间，也即某个集合上的自由模，除非其中一个为零否则很容易构造出非零的双线性映射。因此上式即表明 $M_m = 0$ 或 $N_m = 0$\
  注意到 $M, N$ 是有限生成模，$m$ 是唯一极大理想，由 Nakayama 引理当然有 $M = 0$ 或 $N = 0$\
=
  只需验证保持单射，断言以下的交换图表
  #align(center)[#commutative-diagram(
  node((0, 0), $A$, 1),
  node((0, 1), $A times  M_i$, 2),
  node((0, 2), $A tensorProduct  M_i$, 3),
  node((1, 0), $B$, 4),
  node((1, 1), $ B times M_i$, 5),
  node((1, 2), $ B tensorProduct M_i$, 6),
  node((0, 2 + 1), $A tensorProduct M = plus.circle_(i in I) (A tensorProduct M_i) $, 7),
  node((1, 2 + 1), $B tensorProduct M = plus.circle_(i in I) (B tensorProduct M_i)$, 8),
  node((2, 2), $A times M =  plus.circle_(i in I) (A times M_i) $, 9),
  node((3, 2), $B times M = plus.circle_(i in I) (B times M_i)$, 10),
  arr(2, 1, $$),
  arr(2, 3, $$),
  arr(5, 4, $$),
  arr(5, 6, $$),
  arr(1, 4, $f$, inj_str),
  arr(2, 5, $f times id_i$, inj_str),
  arr(3, 6, $f tensorProduct id_i$),
  arr(3, 7, $$, inj_str),
  arr(6, 8, $$, inj_str),
  arr(7, 8, $f''$),
  arr(2, 9, $$),
  arr(5, 10, $$),
  arr(9, 10, $f times id$, inj_str),
  arr(9, 1, $$),
  arr(10, 4, $$),
  arr(9, 7, $$),
  arr(10, 8, $$),
  
  )]
  这里 $f'_i = (* tensorProduct M_i) f$，$f''$ 既可以由直和给出，也可以由 $(* tensorProduct M)(f)$ 给出，由唯一性可以看出它们是一致的\
  此时，每个 $M_i$ 平坦等价于 $f tensorProduct id$ 是单射，而 $M$ 平坦等价于 $f''$ 是单射
  - 若每个 $M_i$ 都平坦，注意到直和是正合函子，$f''$ 作为 $f tensorProduct id$ 的直和提升当然是单射
  - 若 $M$ 平坦，观察交换图表可得每个 $f tensorProduct id_i$ 都是单射
=
  注意到：
  $
  A[x] = plus.circle_(i in NN^+) A x^i 
  $
  其中 $A x_i$ 作为模同构于 $A$，当然平坦，进而由上题结论知 $A[x]$ 平坦
= 
  利用泛性质，取:
  $
  funcDef(phi, A[x] times M, M[x], (directSum_i a_i x_i, m), directSum_i (a_i m) x_i)
  $
  
  任取双线性函数 $f': A[x] times M -> C$，定义：
  $
  funcDef(f', M[x], C, directSum_i m_i x_i, directSum_i f(1 dot x_i, m_i) )
  $
  容易验证 $f' compose phi = f$，且这样的 $f'$ 是唯一的
= 
  断言：
  $
  (A quo p)[x] tilde.eq (A[x]) quo (p[x])
  $
  事实上，容易给出满射 $pi: A[x] -> (A quo p)[x]$ 作为系数同态的提升，且：
  $
  ker pi = p[x]
  $
  因此结论显然\
  故，当然有 $p$ 是素理想时，上式左右都是整环，继而 $p[x]$ 是素理想\
  极大理想的性质未必成立，例如取 $A = ZZ, p = (3)$，在上面的同构中显然 $(A quo p)[x]$ 不是域，进而 $p[x]$ 不是极大理想
= 
  ==
    任取 $f: B -> C$ 是单射，往证：
    $
    f tensorProduct id_(M tensorProduct N)
    $
    也是单射。事实上：
    $
    f tensorProduct id_(M tensorProduct N) = f tensorProduct (id_M tensorProduct id_N) = (f tensorProduct id_M) tensorProduct id_N
    $
    而：
    $
    f 单 => f tensorProduct id_M 单 => (f tensorProduct id_M) tensorProduct id_N 单
    $
    证毕
  ==
    任取 $f: R -> R'$ 是单射，则 $f tensorProduct_A id_B$ 也是单射，进而：
    $
    (f tensorProduct_A id_B) tensorProduct_B id_N = f tensorProduct_A (id_B tensorProduct_B id_N) 
    $
    也是单射，然而注意到 $B tensorProduct N tilde.eq N$，上式表明 $f tensorProduct_A id_N$ 是单射，证毕
=
  设正合列：
  $
  0 -> M' ->^f M ->^g M'' -> 0
  $，有：
  $
  M quo ker g = M quo im f tilde.eq M''
  $
  而 $im f, M''$ 都是有限生成模。利用选择公理（？）选定一个符合条件的集合上的映射：
  $
  funcDef(phi, M quo ker g, M, m + ker g, m)
  $
  进一步定义集合上映射：
  $
  funcDef(phi, (M quo ker g) times ker g, M, (x, y), phi(x) + y)
  $
  显然它是满射\
  由于 $(M quo ker g) times ker g$ 是有限生成模，因此 $M$ 作为有限生成模的满射像显然也是有限生成的
  // #align(center)[#commutative-diagram(
  // node((0, 0), $X$, 1),
  // node((0, 1), $M quo ker g times N$, 2),
  // node((1, 0), $C$, 3),
  // node((1, 1), $M$, 4),
  // arr(1, 2, $$),
  // arr(1, 3, $$),
  // arr(2, 4, $phi$, surj_str),
  // arr(3, 2, $$, surj_str)
  // )]
  // 其中 $X$ 是有限集而 $C$ 是其上的自由模，图上给出了 $phi compose (C -> M quo ker g times N)$ 是满射，进而 $M$ 是有限生成模
=
  注意到以下序列正合：
  $
  M ->^mu N -> N quo im mu -> 0 \
  M tensorProduct (A quo alpha) ->^(mu') N tensorProduct (A quo alpha) -> (N quo im mu) tensorProduct (A quo alpha) -> 0 \
  $
  然而题设表明以下序列正合（利用习题 2）：
  $
  M quo alpha M ->^(mu'') N quo alpha N -> 0\
  M tensorProduct (A quo alpha) ->^(mu') N tensorProduct (A quo alpha) -> 0\
  $
  换言之，有：
  $
  (N quo im mu) tensorProduct (A quo alpha) = 0 => (N quo im mu) quo alpha (N quo im mu) = 0\
   => N quo im mu = alpha (N quo im mu)
  $
  注意到 $N$ 有限生成，$N quo im mu$ 当然也是，且 $alpha$ 含于 Jacobson 根，因此由 Nakayama 知 $N quo im mu = 0$，证毕
=
  == 
    任取 $A$ 的极大理想 $m$，注意到以下的交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $X$, 1),
    node((0, 1), $A^m$, 2),
    node((0, 2), $A^m quo (m A^m)$, 3),
    node((1, 0), $Y$, 4),
    node((1, 1), $A^n$, 5),
    node((1, 2), $A^n quo (m A^n)$, 6),
    arr(1, 2, $$),
    arr(2, 3, $$),
    arr(4, 5, $$),
    arr(5, 6, $$),
    arr(2, 5, $$, bij_str),
    arr(3, 6, $$, bij_str),)]
    同时，$A^m quo (m A^m), A^n quo (m A^n)$ 是 $A quo m$ 上的线性空间。因此，只需验证 $X, Y$ 也是它们的基即可保证 $abs(X) = abs(Y)$\
    事实上，任意 $A quo m-$模均形如 $C quo m C$，其中 $C$ 是 $AModule(A)$（$G$ 当然也是 $AModule(A)$，直接取 $C$ 是 $G$ 对应 $AModule(A)$ 即可），证明其中一个即可，只需验证泛性质：
    #align(center)[#commutative-diagram(
    node((0, 0), $X$, 1),
    node((0, 1), $A^m$, 2),
    node((0, 2), $A^m quo m A^m$, 3),
    node((1, 1), $C$, 4),
    node((1, 2), $C quo m C$, 5),
    arr(1, 5, $forall f$),
    arr(1, 2, $$),
    arr(2, 3, $$),
    arr(4, 5, $$),
    arr(2, 4, $exists !f_2$, label-pos:right),
    arr(1, 4, $exists !f_1$),
    arr(3, 5, $exists !f_3$)
    )]
    依次给出：
    - 注意到在我们的取法中，$C = C quo m C$，因此 $f_1$ 就是 $f$，当然取法也是唯一的\
    - $f_2$ 利用 $A^m$ 的泛性质作用于 $f_1$ 唯一给出
    - $f_3$ 就是函子 $* quo m * = m tensorProduct *$ 作用于 $f_2$ 的像，自然也被唯一给出，同时这是右正合函子，保持满射性
    - 至于最终的唯一性，若存在 $g, h$ 使得：
      $
      f = g compose (X -> A^m -> A^m quo m A^m) = h compose (X -> A^m -> A^m quo m A^m)
      $
      由 $A^m$ 作为自由模的唯一性，应当有 $A^m -> C quo m C$ 的映射唯一，进而：
      $
      g compose (A^m -> A^m quo m A^m) = h compose (A^m -> A^m quo m A^m) 
      $
      然而注意到 $A^m -> A^m quo m A^m$ 是满射，因此 $g = h$，证毕
    证毕
  == 
    在交换图表：
    #align(center)[#commutative-diagram(
    node((0, 0), $X$, 1),
    node((0, 1), $A^m$, 2),
    node((0, 2), $A^m quo (m A^m)$, 3),
    node((1, 0), $Y$, 4),
    node((1, 1), $A^n$, 5),
    node((1, 2), $A^n quo (m A^n)$, 6),
    arr(1, 2, $$),
    arr(2, 3, $$),
    arr(4, 5, $$),
    arr(5, 6, $$),
    arr(2, 5, $$, surj_str),
    arr(3, 6, $$, surj_str),)]
    中，第一个满射是条件，第二个满射由函子 $* quo m * = m tensorProduct *$ 保持，因此类似可得 $m >= n$
  == 
    上述函子不保持单射，例如取 $A = product_(i in NN) ZZ$
    $
    funcDef(phi_1, A, A, (a_k)_(k in NN), (a_(2k))_(k in NN))\
    funcDef(phi_2, A, A, (a_k)_(k in NN), (a_(2k + 1))_(k in NN))
    $
    它们都是单同态，且 $A = phi_1(A) directSum phi_2(A)$\
    此时取 $X = {x, y}, Y = {z}$，
    $
    funcDef(phi, A^m, A^n, s x + t y, (phi_1(s) + phi_2(y)) z)
    $
    容易验证它是单射，但不符合结论
=
  不妨设 $A^n = M quo ker phi.alt := M'$，$X$ 是其一个基。\
  由于 $pi: M -> M'$ 是满射，它将存在右逆 $sigma$ 使得：
  $
  pi compose sigma = id
  $
  此处 $sigma$ 是集合间映射，因此 $sigma compose (X -> M')$ 是从基出发的集合映射，由自由模的性质，存在唯一模同态 $sigma': M' -> M$ 使得：
  $
  sigma compose (X -> M') = sigma' compose (X -> M')
  $
  注意到：
  $
  id compose (X -> M') = pi compose sigma compose (X -> M') = pi compose  sigma' compose (X -> M') 
  $
  而 $pi compose sigma', id$ 都是模自同态，自由模的唯一性将给出 $pi compose  sigma' = id$\
  #lemmaLinear[][
    设 $g: M' -> M, f : M -> M'$，则有：
    $
    f compose g = id => M tilde.eq ker f directSum im g
    $
  ]
  #proof[
    任取 $a in M$，将有：
    $
    a = a - g(f(a)) + g(f(a)) = (a - g(f(a))) + g(f(a))
    $
    显然有 $(a - g(f(a))) in ker f, g(f(a)) in im g$\
    为了证明直和，只需验证分解是唯一的。事实上：
    $
    forall x in ker f, y in M', x + g(y) = 0 =>  y = 0 => x = 0
    $
    证毕
  ]
  定义模同态：
  $
  funcDef(phi, ker phi.alt directSum M', M, x + y, sigma'(y) + x)
  $
  利用引理它是同构\
  $ker phi.alt directSum M'$ 当然是有限生成模，因此 $M$ 也是，证毕
=
  构造双线性映射：
  $
  funcDef(p, B times N, B, (b, n), b n)
  $
  它当然也是 $AModule(A)$意义的双线性映射，因此可以唯一提升到 $N_B = B tensorProduct N$ 上，仍记作 $p$，并满足：
  $
  p(b tensorProduct n) = b n
  $
  从而 $1 tensorProduct y = 0 => p(1 tensorProduct y) = 0 => y = 0$，因此 $g$ 是单射\
  注意到 $p compose g = id$，$p$ 当然是满射，利用引理即得同构
  

