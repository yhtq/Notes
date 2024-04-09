#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, proposition, remark, der, partialDer
#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "复变函数",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 前言
  - 教师：李智强
  - 成绩：作业 30% 期中 30% 期末 40% 额外激励 10% - 20%
  - 周五交一次作业，每周一次
  - https://www.math.pku.edu.cn/teachers/lizq/teaching/2024Spring/complex%20variables/course_site.html
  - 参考书：
    - *复变函数简明教程，谭小江、伍胜健编著，北京大学出版社。*
    - *Functions of One Complex Variable，John B. Conway，Springer* (GTM)
    - Complex Analysis，Lars V. Ahlfors，McGraw-Hill
    - Complex Analysis，Elias M. Stein & Rami Shakarchi，Princeton University Press
    - Real and Complex Analysis，Walter Rudin，McGraw-Hill
  复分析某种意义上是分析学中性质最好的情况下的一些理论
= 复数，复平面拓扑的基本知识
  #definition[复数][
    称 $CC$ 在集合上为 $RR times RR$，定义运算：
    - $(a, b) + (c, d) = (a + b, c + d)$
    - $(a, b) times (c, d) = (a c - b d, a d + b c)$
    并令 $(Re(a, b), Im(a, b)) = (a, b)$
  ]
  #proposition[][
    $(CC, +, times)$ 构成一个域，同时域 $RR$ 可以自然的嵌入 $CC$
  ]
  通常的，$(a, b)$ 可以记作 $a + b i$，其中 $i = (0, 1)$ 被称为虚数根(imaginary unit)。复数的早期起源当然是关于 $sqrt(-1)$ 的可行性的探讨研究。
  #definition[复共轭|complex conjugate][
    对于 $z = a + b i$，定义其复共轭为 $overline(z) = a - b i$，不难验证它是域自同构
  ]
  #example[][
    设 $f(z) = p(z)/q(z)$ 是有理函数，称 $g(z) = overline(f(z))$ 为反有理函数（anti-rational），它也是复动力系统的研究对象之一
  ]
  #definition[模|absolute value/norm][
    对于 $z = a + b i$，定义其模为 $norm(z) = sqrt(a^2 + b^2) = z overline(z)$
  
  ]
  #definition[幅角|argument][
    对于 $z = a + b i != 0$，定义：
    - 其幅角为 $Arg(z) = {theta in RR | z = norm(z)(cos theta + i sin theta)}$
    - 其幅角主值 $arg(z)$ 为 $Arg(z)$ 在 $[0, 2 pi)$ 上唯一的元素
  ]
  #theorem[三角不等式][
    由于复平面的模就是欧式平面的模，自然成立三角不等式：
    $
    |norm(a) -)\
    $
  ]
  #theorem[][
    - $Arg(z_1 z_2) = Arg(z_1) + Arg(z_2)$
    - $Arg(z_1/z_2) = Arg(z_1) - Arg(z_2)$
  ]
  #remark[复平面的曲线方程][
    一个复方程对应一个复平面上的曲线，最简单的包括：
    - 直线方程：
      $
      A overline(z) + overline(A) z + b = 0, A in CC, b in RR
      $
    - 圆方程：
      $
      |z - a| = r, a in CC, r in RR\
      <=> -z overline(z) + A overline(z) + overline(A) z + b = 0, A in CC, b in RR
      $
    这也表明在复的意义下，直线是圆的某种退化形式
  ]
  #definition[复空间的度量/拓扑][
    定义复平面的度量就是欧式度量，具体而言：
    $
    d(z_1, z_2) = norm(z_1 - z_2)
    $
    容易验证 $d$ 满足度量公理，从而 $(CC, d)$ 是一个度量空间，由此生成的拓扑成为复平面的拓扑，由此度量/拓扑自然也可生成极限
  ]
  #remark[][
    我们也使用通常度量空间的记号，例如：
    - $B(z_0, r) := {z in ZZ | d(z_0, z) < r}$
    - $overline(B)(z_0, r) := {z in ZZ | d(z_0, z) <= r} = overline(B(z_0, r))$
    - $B_o(z_0, r) = B(z_0, r) - {z_0}$
  ]
  #theorem[][
    $S$ 连通当且仅当其中既开又闭的集合只有空集和全集
  ]
  #proposition[][
    在复平面上，对于开集 $S$ 以下事实等价：
    - $S$ 连通
    - $S$ 路径连通
    - $S$ 中任取两点 $x, y$ 存在分段线性路径将其连接
    一般拓扑空间中三者往往都不等价
  ]
  #proof[
    - $1 => 3$: 任取 $z in S$，取 $Omega= {x in S | x "与 " z "有分段线性的道路"}$，往证 $Omega$ 既开又闭
      - $Omega$ 开：任取 $x in Omega$，由于 $S$ 开，存在 $r > 0$ 使得 $B(x, r) subset S$。在开球中当然可以找到分段线性道路，从而 $B(x, r) subset Omega$
      - $Omega$ 闭：往证 $S - Omega$ 是开集。显然任取 $y in S - Omega$ 当且仅当 $y$ 到 $x$ 没有分段线性路径。显然存在 $y$ 的开球 $subset S$，其中任何点到 $x$ 都没有分段线性路径，从而 $S - Omega$ 是开集
    - $3 =>2, 2 => 1$ 都是显然的 
  ]
  #definition[Cauthy 序列][
    若序列 ${x_i}$ 满足：
    $
    forall epsilon > 0, exists n in NN,\
     m, l in NN > n => d(x_m, x_l) < epsilon
    $
  ]
  #definition[完备空间|Complete Space][
    若度量空间 $(X, d)$ 中任意 Cauthy 序列都收敛，则称其为完备空间
  ]
  #theorem[Cantor][
    度量空间是完备的当且仅当闭集套确定唯一公共点，也就是说：\
    对于任何非空下降闭集序列 ${F_i}$ 满足 $d(F_i) ->0$，那么恰有 $| sect.big_i F_i | = 1$
  ]<Cantor>
  #proof[
    - 假设空间完备，对于某个闭集套 $F_i$ 选出 $x_i in F_i$，由于 $d(F_i) ->0$，当 $i$ 充分大时有 $d(F_i) < epsilon$，进而对 $j > i, x_j in F_i => d(F_j, F_i) < epsilon$，给出 ${x_i}$ 是 Cauthy 序列。从而收敛到 $x$，由于 $F_i$ 都是闭集，故 $x in sect.big_i F_i$\
      此外，由直径趋于零显然 $sect.big_i F_i$ 不会有第二个点，否则直径都大于两点间距离
    - 假设闭集套成立，任取 Cauthy 序列 ${x_i}$，取 $F_i = overline({x_j | j > i})$，显然 $d(F_i) ->0$（注意到集合在半径为 $r$ 的开球中，它的闭包也在），从而 $sect.big_i F_i$ 是唯一的点 $x$\
      $x$ 是所有如上定义的闭包的交点，它一定是序列的极限。（注意到 $F_i$ 的直径趋近于零，因此对于充分大的 $n$，$F_n$ 中每个点到 $x$ 的距离都小于 $epsilon$）
  ]
  #theorem[][
    欧式空间是完备的。特别的，复平面是完备的
  ]
  #theorem[][
    完备空间的子集完备当且仅当它是闭集
  ]
  #proof[
    设 $Y$ 是完备空间 $X$ 的子集
    - 若子集完备，对于任何 $Y$ 的极限点 $x$，存在 $x_i in Y -> x in X$。显然 $x_i$ 作为收敛列是柯西列，由 $Y$ 完备知 $x in Y$
    - 若 $Y$ 是闭集，其中的柯西列在 $X$ 中也是柯西列，因此收敛于 $x in X$，但 $Y$ 是闭集，其中序列不会有 $Y$ 之外的极限点，从而 $x in Y$\
      另证：使用 @Cantor，注意到 $Y$ 之中的闭集在 $X$ 中当然也是闭集
  ]
  #definition[稠密|dense][
    称 $Y subset X$ 稠密，如果 $overline(Y) = X$
  ]
  #definition[紧性|compact][
    若 $X$ 的任何开覆盖都有有限子覆盖，则称 $X$ 是紧的
  ]
  #theorem[][
    - 紧致集一定是闭集
    - 紧致集的闭子集仍然紧致
  ]
  #lemma[Lebesgue][
    设 $X$ 是列紧的度量空间，$E$ 是开覆盖，则存在 $epsilon > 0$ 使得 $X$ 中每个点的 $epsilon$ 邻域球都在 $E$ 的某一个子集中
  ]<Lebesgue_Lemma>
  #proof[
    如若不然，取 $epsilon_n = 1/n$ 下降，可得 $exists x_i, B(x_i, 1/i)$ 不在任何覆盖中。由列紧性，这些 $x$ 有聚点 $x_0$。该聚点当然在某个覆盖中，因此该点的某个开邻域球 $B(x, epsilon)$ 处于某个覆盖中，当 $epsilon > 1/i$ 时，这与 $B(x_i, 1/i)$ 不在任何覆盖中矛盾
  ]
  #theorem[][
    设 $X$ 是度量空间，以下命题等价：
    - $X$ 是紧致的
    - $X$ 的任何无穷子集都有聚点
    - $X$ 列紧，也即无穷序列都有收敛子列
    - $X$ 是完备的并且完全有界（任何 $epsilon > 0$ 都存在有限个点，使得每个点的 $epsilon$ 闭包覆盖整个空间）
    ]
    #proof[
      - $1 => 2$: 反证法，若无穷子集没有聚点，那么每个点都有一个 $epsilon$ 邻域球不包含其他点，从而构成无穷开覆盖，由紧致性有有限子覆盖，矛盾
      - $2 => 3$: 假设序列中只有有限多个点，那么显然有收敛子列，否则有无穷多个点，由 $2$ 知有聚点。该聚点就是一个子列的极限
      - $3 => 4$: 
        - 先证明完备性：利用柯西序列有收敛子列，结论是显然的
        - 再证明完全有界。如若不然，存在 $epsilon > 0$，任意有限个点的 $epsilon$ 邻域都不能覆盖全空间，如此：
          - 任取 $x_0 in X$
          - 显然 $B(x_0, epsilon)$ 不能覆盖 $X$，取 $x_1 in X - B(x_0, epsilon)$
          - 显然 $B(x_0, epsilon) union B(x_1, epsilon)$ 不能覆盖 $X$，取 $x_2 in X - (B(x_0, epsilon) union B(x_1, epsilon))$
          - ...
          这就定义了一个序列 $x_i$ 使得：
          $
          forall i in NN, forall j < i, x_i in.not B(x_j, epsilon)
          $
          然而由于 $X$ 列紧，我们可以不妨假设 $x_n$ 收敛，上面的事实同样成立，显然产生了矛盾
      - $4 => 3$:\
        任取序列 $x_n$，由完全有界性，可取有限多个半径为 $1$ 的球覆盖整个 $X$。有限多个球覆盖了 $x_n$ 中无穷多个点，进而可以选出一个覆盖了无穷多个点。选出其再递归进行（选取更小的半径 $1, 1/2, 1/3, ...$ 。\
        为了构造收敛子列，先在第一个球中选出 $y_1$，再在更小的第二个球中选出位于 $y_1$ 之后的 $y_2$ 等等。这样构造出的序列显然是柯西序列，进而收敛
      - $3 => 1$\
        利用 @Lebesgue_Lemma，任取开覆盖 $E$，将存在 $epsilon > 0$ 使得 $X$ 中每个点的 $epsilon$ 邻域球都在 $E$ 的某一个子集中。注意到 3 蕴含了 4， 蕴含了完全有界，对于这个 $epsilon$，存在有限个点的 $epsilon$ 邻域球覆盖了整个空间，从而这有限个点对应的有限个覆盖恰好可以覆盖整个空间
    ]
    #theorem[Heine-Borel][
      欧式空间中紧致当且仅当有界闭集
    ]
    #proof[
      之前证明了度量空间中紧致当且仅当列紧，而 $RR^n$ 中的列紧与 $RR$ 的列紧是等价的（只需依次取每一维的收敛子列），由一维情形容易验证结论成立
    ]
    #definition[$CC$ 上的曲线][
      设：
      $
      funcDef(gamma, [0,1], CC, t, (x(t), y(t)))
      $
      - 若 $gamma$ 连续，则称之为连续|continuous/$C^0$曲线
      - 若 $x(t), y(t)$ 都连续可导且 $x'(t)^2 + y'(t)^2 != 0$，则称之为光滑|smooth/$C^1$曲线
      - 若曲线在有限个段上都是光滑的，则称之为分段光滑曲线
      - 若
        $
        integral_0^1 sqrt(x'(t)^2 + y'(t)^2) dif t 
        $
        存在且有限，则称之为可求长|rectifiable 曲线
    ]
    #definition[区域][
      称 $D subset CC$ 为区域，如果 $D$ 是开集且连通（注意到 $RR^n$ 上的开集，连通等价于路径连通，因此也可等价定义为路径连通的开集）
    ]
    #theorem[][
      设 $E$ 是一族 $X$ 的连通子集，且两两相交不空，则 $union.big E$ 也连通
    ]
    #definition[连通分支|connection component][
      称集合 $S$ 的连通分支是一个极大的连通子集，也就是连通且不被更大的连通子集包含
    ]
    #definition[约当曲线|Jordan curve][
      称简单闭曲线为约当曲线，也就是首尾闭合，不经过其他点两次的曲线
    ]
    #theorem[Jordan Curve Theorem][
      对于任意 $CC$ 上的约当曲线 $gamma$，$CC - gamma$ 恰有两个连通分支
    ]
    #proof[
      它的证明出乎意料的非常困难。Jordan 最初给出了证明，但是并不被认可。具体证明详见见 GTM Conway 2\
      Bonus: 找到 Jordan 最初给出的证明其中公认并不正确的一步
    ]
    #definition[单连通][
      称区域 $D$ 是单连通的，对于任何 Jordan 曲线 $gamma subset D$，存在 $D_0 subset D$ 使得 $D_0$ 的边界恰为 $gamma$
    ]
    往往复平面会比实数有更好的代数结构和分析结构，然而复平面的拓扑却远比实数复杂。

    #definition[函数极限][
      设复函数 $f: S -> C$，若：
      $
      exists A in CC, forall epsilon > 0, exists delta >0:\
      z in B(x_0, delta) sect S => f(z) in B(A, epsilon)
      $
      则称 $f(z)$ 在 $z_0$ 处有极限 $A$|f attach to $A$ at $x_0$，记作 $lim_(z->z_0) f(z) = A$\
      注意这里并不要求 $S$ 有任何开闭等性质
    ]
    如无特殊说明，我们说的极限存在都是指有限极限
    #theorem[][
      函数极限存在当且仅当实部和虚部的极限分别对应存在
    ]
    #definition[连续函数|Continuous Function][
      称复函数 $f: S -> CC$ 于 $z_0 in S$ 连续，如果：
      - 若 $z_0$ 是 $S$ 的极限点，则 $lim_(z->z_0) f(z) = f(z_0)$
      - 若不是极限点，直接称 $f(z)$ 于该点连续
      称 $f$ 于 $S$ 连续，如果 $f$ 在 $S$ 的每一点都连续，记 $f in C(S, CC)$ 或 $f in C^0(S, CC)$
    ]
    #proposition[][
      设 $f: X -> CC$ 于 $S$ 连续，那么：
      - 开集的原像是开集
      - 闭集的原像是闭集
      - 连通集的像是连通集
      - 紧集的像是紧集
      - 连续函数与连续函数的复合仍然连续
      - 连续函数于紧集上有界且可以取得（模的）最大最小值
      - 连续函数在紧集上一致连续
    ]
    #definition[扩充复平面|Extended Complex Sphere/黎曼球面|Riemann Sphere][
      定义扩充复平面为 $CC = {infinity} union RR$，其中 $infinity$ 被称为无穷远点，并且定义：
      - $a plus.minus infinity = infinity, forall a in CC$
      - $a times infinity = infinity, forall a in CC - {0}$
      - $a / 0 = infinity, forall a in CC - {0}$
      其余的运算无意义

      它恰好相当于将球面以北极为中心投影，北极点本身对应无穷远点，以此定义它的拓扑。

      其上还可以定义距离，有一些常用的距离包括：
      - Chordul metric: 利用两点在黎曼球上三维空间的连线长度
      - Spherical metric: 利用两点在黎曼球上三维空间的大圆弧长度

    ]
= 基础分析
  == 解析函数
    本节中 $G$ 一般指开集
    #definition[可导|differentiable][
      -
        设 $G$ 是开集，$f: G -> CC$，称 $f$ 在 $z_0$ 可导，如果：
        $
        lim_(h -> 0) (f(z_0+h)-f(z_0))/h
        $
        存在且不是无穷，并称其为 $f$ 在 $z_0$ 处的导数，记作 $f'(z_0)$
      - 进一步，如 $f$ 在开集 $G$ 内每一点都可导，则称 $f$ 在 $G$ 内可导 / 解析|analytic / 复可导 / 全纯|holomorphic
      这里的多种叫法其含义都略有差异，但在这里（集合为开集的情况下）它们都是等价的
    ]
    我们也使用 $o$ 记号，函数可导也可记作：
    $
    f(x) = f(z_0) + f'(z_0) (z - z_0) + o(z - z_0), z - z_0 -> 0
    $
    #theorem[][
      若 $f: G -> CC$ 于 $x_0$ 可导，则于 $x_0$ 连续
    ]
    #proof[
      $
      lim_(z -> z_0) norm(f(z) - f(z_0)) = lim_(z -> z_0) norm((f(z) - f(z_0))/(z - z_0)) norm(z-z_0)
      $
      由极限的乘法法则，前者极限存在，后者趋于零，因此极限为零
    ]
    #proposition[导数的运算法则][
      - $(f + g)' = f' + g'$
      - $(f g)' = f' g + f g'$
      - 若 $g != 0$，则 $(f/g)' = (f' g - f g')/g^2$
      - 若 $h$ 于 $f(a)$ 可导，$f$ 于 $a$ 可导，那么 $(h compose f)'(a) = h'(f(a)) f'(a)$
    ]
    #definition[解析 | analytic][
      设 $A subset CC$ 是一般集合，称 $f$ 在其上解析，如果存在开集 $G supset A$ 使得 $f$ 在 $G$ 上解析
    ]
    #definition[单叶解析函数 | univalent function][
      设 $G$ 是开集，$f$ 在 $G$ 上解析且是单射，则称 $f$ 是单叶（解析）函数\
      有时也称之为共形映射 | conformal mapping，但 conformal 有时也也指所有解析的函数，因此可能会产生歧义
    ]
    univalent 可以给出许多几何上有趣的结论
    #proposition[][
      单叶解析函数具有保角性
    ]
    #proof[
      这不是本节的重点，后面有机会会再提到
    ]
    #definition[双全纯函数/全纯同胚 | biholomorphic][
      若 $f: G -> CC$ 是双射且 $f, Inv(f)$ 都是全纯的，则称 $f$ 是双全纯函数，也称全纯同胚，有时也称为共形等价或者共形同胚
    ]
    #theorem[][
      设 $f: G -> CC$ 是单叶解析的，则：
      - $f'(z) != 0, forall z in G$
      - $f(G)$ 也是开集
      - $Inv(f): f(G) -> G$ 也是解析的
      - $(Inv(f))' (f(z)) = 1/(f'(z))$
    ]
     #proof[

     ]
    #theorem[Cauthy-Riemann equation][
      设复函数 $f (x+y i)= u(x, y) + i v(x, y)$ 在开集内一点可导，则柯西黎曼公式：
      $
      partialDer(u, x) = partialDer(v, y)\
      partialDer(u, y) = -partialDer(v, x)
      $
      成立。反之若 $u, v$ 是开集上的连续可微（$C^1$）函数且上式成立，则 $f$ 于该点可导
    ]<C-R>
    #proof[
      - 若函数可导，考虑导数的极限在 $vec(1, 0), vec(0, 1)$ 两个方向上的子极限，立得：
        $
        f'(z_0) = partialDer(u, x) (x_0, y_0) + i partialDer(v, x) (x_0, y_0)\
        f'(z_0) = partialDer(v, y) (x_0, y_0) - i partialDer(u, y) (x_0, y_0)
        $
        对比实部虚部分别相等即可
      - 若 $u, v$ 是 $C^1$ 的且满足柯西黎曼方程，由可微性：
        $
        u(x_0 + Delta x, y_0 + Delta y) = u(x_0, y_0) + partialDer(u, x) (x_0, y_0) Delta x + partialDer(u, y) (x_0, y_0) Delta y + o(sqrt(Delta x ^2 + Delta y ^2))\
        v(x_0 + Delta x, y_0 + Delta y) = v(x_0, y_0) + partialDer(v, x) (x_0, y_0) Delta x + partialDer(v, y) (x_0, y_0) Delta y + o(sqrt(Delta x ^2 + Delta y ^2))
        $
        代入 $f((x + Delta x) + (y + Delta y)i) - f(x + y i)$，得：
        $
        f((x + Delta x) + (y + Delta y)i) - f(x + y i) \
        = (partialDer(u, x) (x_0, y_0) Delta x + partialDer(u, y) (x_0, y_0) Delta y + o(sqrt(Delta x ^2 + Delta y ^2))) \
          + i (partialDer(v, x) (x_0, y_0) Delta x + partialDer(v, y) (x_0, y_0) Delta y + o(sqrt(Delta x ^2 + Delta y ^2)))\
        = (partialDer(v, y) (x_0, y_0) Delta x + partialDer(u, y) (x_0, y_0) Delta y + o(sqrt(Delta x ^2 + Delta y ^2))) \
          + i (- partialDer(u, y) (x_0, y_0) Delta x + partialDer(v, y) (x_0, y_0) Delta y + o(sqrt(Delta x ^2 + Delta y ^2)))\
        = partialDer(v, y)(x_0, y_0) (Delta x + i Delta y) - i partialDer(u, y)(x_0, y_0) (Delta x + i Delta y) + o(sqrt(Delta x ^2 + Delta y ^2))\
        = (partialDer(v, y)(x_0, y_0) - i partialDer(u, y)(x_0, y_0))(Delta x + i Delta y) + o(Delta x + i Delta y)
        $
        最后一式即表示 $f$ 在 $x_0 + y_0 i$ 处可导
    ]
    #theorem[][
      设函数 $f$ 在连通区域 $G$ 上解析，且 $f' = 0$，则它是常函数
    ]
    #proof[
      利用 
    ]
    #theorem[][
      设 $f = u + i v$ 可微，$u, v in C^2$，则有：
      $
      (diff^2 u)/(diff x^2) = (diff^2 v)/(diff x diff y)\
      (diff^2 u)/(diff y^2) = -(diff^2 v)/(diff x diff y)\
      $
      进而拉普拉斯算子 $(diff^2 u)/(diff x^2) + (diff^2 u)/(diff y^2) = 0$，满足前式的 $C^2$ 函数称为 调和|harmonic 函数\
      类似的 $v$ 也是调和函数
    ]
    #definition[][
      设有两个调和函数 $u, v$ ，称 $v$ 是 $u$ 的 共轭调和函数|harmonic conjugate ，如果 $f = u + i v$ 解析\
    ]
    #theorem[][
      在单连通区域上，每个调和函数都有共轭调和函数
    ]
    #proof[
      注意到复平面的连通区域一定分段路径连通，取定 $P = (x_0, y_0)$，对于任意一点 $z$，找到分段线性的道路 $gamma_1, gamma_2 : P -> z$\
      取 $v(z) = integral_(gamma_1) partialDer(u, x) dif y - partialDer(u, y) dif x$，为了验证良定义性，需要计算 $gamma_1, gamma_2$ 给出相同的函数值\
      注意到：
      $
      integral_(gamma_1 + gamma_2) partialDer(u, x) dif y - partialDer(u, y) dif x\
      = integral_D ((diff^2 u)/(diff x^2) + (diff^2 u)/(diff y^2)) dif x dif y = 0
      $
      （利用格林公式，这需要区域的单连通性）\
      因此定义是良好的\
      只需验证:
      $
      partialDer(v, y) = partialDer(u, x)\
      partialDer(v, x) = -partialDer(u, y)
      $
      事实上，不难发现：
      $
      v(x, y + Delta y) - v(x, y) = integral_(0)^(Delta y) partialDer(u, x) dif y\
      partialDer(v, y) (x, y) = lim_(Delta y -> 0)1/(Delta y) integral_(0)^(Delta y) partialDer(u, x) dif y = partialDer(u, x)(x, y)
      $
      另一个同理可得
    ]
    #remark[][
      - 注意 $u, v$ 的地位不均等，若 $u + i v$ 可微则 $v + i u$ 往往并不可微，但 $v - i u = -i (u + i v)$ 是可微的
      - 若 $v_1, v_2$ 都是 $u$ 的共轭调和函数，则 $v_1 - v_2$ 在各个连通分支上是一个常数，这是因为由柯西黎曼公式 $v_1, v_2$ 的两个偏导都相等，由 $C^2$ 性知它们只差一个常数
      - $u(x, y) = ln (x^2 + y^2)$ 在 $CC - 0$ 上调和，但没有共轭调和函数
    ]
    #definition[][
      对于复可微函数 $f$，记：
      $
      partialDer(f, overline(z)) = 1/2 (partialDer(f, x) + partialDer(f, y))\
      $
      显然 $f$ 可微当且仅当 $partialDer(f, overline(z)) = 0$
    ]
    #theorem[][
      设 $Omega$ 单连通，其上的 $C^2$ 解析函数 $f != 0$，则存在解析函数 $g(z)$ 使得 $e^(g(z)) = f(z)$
    ]
    #proof[
      令 $u_1(z) = ln norm(f(z))$ 
      - 它是调和函数，因为\
        $
        ln norm(f(z)) = ln (x(z)^2 + y(z)^2)\
        u'_1(a, b) = 1/(x(z)^2 + y(z)^2) (2 x(z) x'(z) + 2 y(z) y'(z))\
        u''_1(a, b) = lambda ((x'^T x' + x x'' + y'^T y' + y y'')(x^2 + y^2) -2(x x' + y y')^T (x x' + y y'))\
        $
        计算得（这里 $x', y'$ 是行向量，$x'', y''$ 是矩阵）：
        $
        tr(u'') = lambda((x^2 + y^2)tr(x'^T x' + x x'' + y'^T y' + y y'') - 2 tr((x x' + y y')^T (x x' + y y'))) \
        = lambda ((x^2 + y^2)tr(x'^T x' + y'^T y') - 2 (x x' + y y') (x x' + y y')^T)\
        = lambda ((x^2 + y^2)(x' x'^T + y' y'^T) - 2 (x x' + y y') (x x' + y y')^T)\
        = lambda (-x^2 norm(x')^2 - y^2 norm(y')^2+ x^2 norm(y')^2 + y^2 norm(x')^2 - 4 x y x' y'^T)\
        = 0
        $
        过程中分别利用了：
        $
        tr(x'') = tr(y'') = 0\
        norm(x') = norm(y')\
        x' y'^T = 0\
        $
        这些性质都来源于 @C-R 

      进而由之前的结论，存在 $v_1 (z)$ 使得 $h(z) := u_1(z) + i v_1(z)$ 是调和函数\
      我们发现：
      $
      norm(f(z)/e^h(z)) = norm(f(z)/e^(u_1(z))) = 1
      $
      而上式右侧是解析函数，利用如下引理：
      #lemma[][
        设 $f$ 于连通区域 $G$ 上解析，且 $norm(f(z)) = 1$，则 $f(z)$ 是常数
      ]
      #proof[
        设 $f = u + v i$，则有：
        $
        1 = u^2 + v^2\
        0 = u u' + v v'\
        0 = u u'' + u'^T u' + v v'' + v'^T v'\
        0 = tr(u u'' + u'^T u' + v v'' + v'^T v') = norm(u')^2 + norm(v')^2 = 0
        $
        因此 $f' = 0$，结合 $G$ 的连通性得到结论
      ]
    ]
    #corollary[][
      在上面类似的条件下，存在解析函数 $g(z)$ 使得 $(g(z))^n = f(z)$
    ]
    #proof[
      在上题给出的 $g(z)$ 中，令 $h = e^(g(z)/n)$ 即可
    ]
    #theorem[][
      设 $f$ 在区域 $Omega$ 上解析，称 $f$ 的 Jacobian 矩阵把它看成 $R^2 -> R^2$ 的函数的 Jacobian $J$，有：
      $
      det(J) = norm(f'(z))^2
      $
    ]<JandD>
    #proof[
      几何上说，解析映射对于小的长度元是线性的，伸缩率就是 $norm(f'(z))$，对于面积元的伸缩率当然就是 $ norm(f'(z))^2$\
      利用@C-R, 计算得：
      $
      det(J) = partialDer(u, x) partialDer(v, y) - partialDer(u, y) partialDer(v, x) = (partialDer(u, x) partialDer(u, x)) + (partialDer(u, y) partialDer(u, y)) = norm(f'(z))^2
      $
    ]
    #lemma[][
      设 $C^1$ 函数 $f : R^2 -> R^2$ 的 Jacobian 矩阵为 $J$，则它对应 $CC$ 上的解析函数当且仅当：
      $
      J = a I + b mat(0, 1;-1, 0)
      $
      进一步：
      $
      (a I + b mat(0, 1;-1, 0))(a I - b mat(0, 1;-1, 0)) = (a^2 - b^2)I
      $
      表明 $a^2 != b^2 <=> J "可逆"$，并且 $J$ 可逆时它的逆也具有类似的的形式
    ]
    #proof[
      这就是@C-R
    ]
    #theorem[反函数定理][
      设 $f$ 在区域 $Omega$ 上解析，且导数连续，并有 $f'(z_0) != 0$，那么将存在 $z_0$ 的邻域 $D$，使得：
      - $f(D)$ 是开集
      - $f$ 在 $D$ 上是双全纯的
      - $(Inv(f))' (f(z)) = 1/(f'(z))$
    ]
    #proof[
      利用实函数的反函数定理，可以得到反函数 $Inv(f)$，且满足：
      $
      J_(Inv(f)) = Inv((J_f))
      $
      从而可以通过引理验证 $Inv(f)$ 也是解析的，进而也可以得到计算结果
    ]
    #theorem[中值定理][
      设 $f$ 是开的凸集 $Omega$ 上的解析函数，$z_1, z_2 in Omega$，则存在 $z_3 in Omega$ 使得：
      $
      norm((f(z_1) - f(z_2))/(z_1 - z_2)) <= norm(f'(z_3))
      $
    ]
    #proof[
      本题中将复数视作列向量处理\
      由于 $Omega$ 是凸的，设 $z = (1-t)z_1 + t z_2$，则 $norm(f((1-t)z_1 + t z_2)) := g(t)$ 将是 $[0, 1] -> RR$ 的连续可微函数\
      事实上，设 $J$ 给出 $f$ 的 F-导数，则由链式法则：
      $
      g'(t) = ((f((1-t)z_1 + t z_2))^T)/(norm(f((1-t)z_1 + t z_2))) J((1-t)z_1 + t z_2) (z_2 - z_1) 
      $
      #lemma[][
        设 $A$ 是满足@C-R 的偏导矩阵，则： 
        $
        norm(alpha^T A beta) <= sqrt(det(A)) norm(alpha) norm(beta)
        $
      ]
      #proof[
        由柯西不等式，显然有：
        $
        norm(alpha^T A beta) <= norm(alpha) norm(A beta)
        $
        注意到：
        $
        norm(A beta) = sqrt(beta^T A^T A beta)
        $
        而:
        $
        A^T A = (a I + b mat(0, 1;-1, 0))(a I- b mat(0, 1;-1, 0)) = (a^2 + b^2)I = det(A) I
        $
        给出：
        $
        norm(alpha) norm(A beta) = norm(alpha) norm(beta) sqrt(det(A))
        $
        证毕
      ]
      由引理：
      $
      norm(g'(t)) <= norm(((f((1-t)z_1 + t z_2))^T)/(norm(f((1-t)z_1 + t z_2)))) norm(z_2 - z_1) sqrt(det(J((1-t)z_1 + t z_2))) \
      <= norm(z_2 - z_1) sqrt(det(J((1-t)z_1 + t z_2)))
      $
      结合实函数的中值定理与@JandD 结论成立
    ]
  == 复函数序列，幂级数
    在分析学和复分析早期，使用幂级数是一种非常重要的研究方法
    #definition[][
      设 $a_n in CC$，称幂级数 $sum_(n = 1)^(+infinity) a_n$ 
      - 收敛，如果 $S_k = sum_(n = 1)^(k) a_n$ 收敛
      - 绝对收敛，如果 $norm(S_k)$ 收敛 
    ]
    #proposition[][
      $a_n$ 绝对收敛 $=>$ 收敛
    ]
    #proof[
      利用柯西收敛法则即可
    ]
    #definition[][
      - 称函数项级数 $sum_(i=1)^(+infinity) f_i (z)$ 一致收敛于 $f(z)$，如果 $sup{norm(f(z) - sum_(i=1)^(n) f_i (z))} -> 0$
      - 若幂级数 $sum_(i=1)^(+infinity) a_n (z - z_0)^i$ 则定义收敛半径：
        $
        R = 1/(limsup_(n -> +infinity) norm(a_n)^(1/n))  in [0, +infinity]
        $
    ]
    #theorem[][
      设 $R$ 是幂级数 $sum_(i=1)^(+infinity) a_n (z - a)^i$ 的收敛半径，则：
      + 若 $norm(z - a) < R$ 则级数绝对收敛
      + 若 $norm(z - a) > R$ 则级数发散
      + 设 $r < R$，则幂级数在 $overline(B(a, r))$ 一致收敛
      同时，$R$ 也是唯一一个满足前两个性质（所有性质）的数
    ]
    #proof[
      不妨设 $a = 0$，取定 $0 < r < R$ 及 $r_0 = (r + R)/2$，由收敛半径定义，存在 $N in NN^+$ 使得：
      $
      forall n > N, norm(a_n)^(1/n) < 1/r_0
      $
      - 我们直接先证明 3, 进而 1 也是显然的\
        在 $overline(B(a, r))$ 内，我们将有：
          $
          norm(a_n z^n) < (norm(z_n)/r_0)^n <= (r/r_0)^n
          $
        注意到 $r/r_0 < 1$，因此幂级数被几何级数一致控制，由 Weierstrass 判别法知一致收敛
      - 对于 2，可设 $norm(z) > r > R, r_0 = (r + R)/2$，可以取得一列 $n_k$ 使得：
        $
        norm(a_(n_k))^(1/n) > 1/r_0
        $
        由于 $r_0 > R, 1/r_0 < R$\
        我们发现：
        $
        norm(a_(n_k) z^(n_k)) > (norm(z) / r_0)^(n_k) > (r / r_0)^(n_k)
        $
        但上式右侧趋于无穷，显然级数发散
    ]
    #proposition[][
      给定幂级数 $sum a_n (z - a)^n$，若 $lim_(n -> infinity) norm(a_n/a_(n+1))$ 存在，则它就是 $R$
    ]
    #definition[][
      设两级数 $sum a_n, sum_ b_n$ ，定义它们的乘积为：
      $
      sum_(n = 0)^(+infinity) (sum_(k = 0)^(n) a_k b_(n-k)) 
      $
    ]
    #proposition[][
      若两级数 $sum a_n, sum b_n$ 至少有一个绝对收敛，则它们的乘积也收敛，并且恰有：
      $
      sum_(n = 0)^(+infinity) (sum_(k = 0)^(n) a_k b_(n-k))  = sum_(n = 0)^(+infinity) a_n sum_(n = 0)^(+infinity) b_n
      $
      若两个都绝对收敛，则乘积也绝对收敛
    ]
    #proof[
      不妨设 $a_n$ 绝对收敛
      先考虑有限和，设 $a_n, b_n$ 的前 $n$ 项和分别为 $A_n, B_n$，有：
      $
      sum_(n = 0)^(N) (sum_(k = 0)^(n) a_k b_(n-k)) = sum_(k = 0)^N (sum_(n=k)^N a_k b_(n - k)) = sum_(k = 0)^N a_k B_(N-k) \
      = sum_(k=0)^N a_k B_N + sum_(k = 0)^N a_k (B_(N-k) - B_N)\
      = A_N B_N + sum_(k = 0)^N a_k (B_(N-k) - B_N)
      $
      注意到上式第二项 $B_(N-k) - B_N -> 0, N -> +infinity$，结合 $a_n$ 绝对收敛知该项收敛于零
    ]
    #remark[][
      两项都不绝对收敛时，结论当然不成立。例如取 
      $
      a_n = (-1)^n 1/(n^(1/4))\
      B_n = (-1)^n 1/(n^(1/4))\
      B_(N-k)  = (-1)^(N - k) 1/(N - k)^(1/4) \
      a_k B_(N-k) = (-1)^N 1/((N - k) k )^(1/4) 
      $
      其中:
      $
      1/((N - k) k )^(1/4) >= 1/((N/2)^(1/2))\
      sum_(k = 1)^(N-1) a_k B_(N - k) >= (N-1)/((N/2)^(1/2))
      $
      上式右侧趋于无穷，观察证明过程可得结论不成立
    ]
    #corollary[][
      设两个幂级数的收敛半径 $>= r$，则幂级数的和/积就是对应系数和/积的幂级数在 $B(a, r)$ 上都成立，且和/积的收敛半径至少为 $r$
    ]


    #theorem[一致收敛与极限][
      设 $f_n: G -> CC$ 为一列函数，若 $f_n$ 于 $z_0$ 的某个开邻域（或者去心邻域）一致收敛于 $f$，则:
      $
      lim_(n -> +infinity) lim_(z -> z_0) f_n (z) = lim_(z -> z_0) lim_(n -> +infinity) f_n (z) 
      $
    ]
    #proof[
      与实函数情景相同
    ]
    #lemma[函数序列的导数][
      设 $f_n$ 一致收敛于 $f$, $f'_n$ 一致收敛于 $g$，则 $f' = g$
    ]
    #proof[
      考虑 $z$ 处的导数，任取 $epsilon > 0$：
      $
      (f(z + Delta) - f(z))/Delta = (f_n (z + Delta) - f_n (z))/Delta + (f(z + Delta) - f_n (z + Delta))/Delta\
      (f(z + Delta) - f(z))/Delta -g(z) = ((f_n (z + Delta) - f_n (z))/Delta - g(z)) + (f(z + Delta) - f_n (z + Delta))/Delta\
      $
      取极限得：
      $
      lim_(Delta -> 0) lim_(n->+infinity)  ((f_n (z + Delta) - f_n (z))/Delta - g(z)) \
      = lim_(Delta -> 0) lim_(n->+infinity)  ((f_n (z + Delta) - f_n (z))/Delta - g(z)) +lim_(Delta -> 0) lim_(n->+infinity)  ((f(z + Delta) - f_n (z + Delta))/Delta)
      $
      只需验证上式为零，而上式右侧第二项恰为零，对于第一项只要极限可交换便也为零，为此，我们希望它一致收敛，利用柯西法则计算：
      $
      norm((f_n (z + Delta) - f_n (z))/Delta - g(z) - ((f_m (z + Delta) - f_m (z))/Delta - g(z))) \
      = norm((f_n (z + Delta) - f_n (z) - f_m (z + Delta) + f_m (z)))/norm(Delta)\
      $
      由中值定理，存在 $xi$ 使得：
      $
      norm((f_n (z + Delta) - f_n (z) - f_m (z + Delta) + f_m (z)))/norm(Delta) <= norm(f'_n (xi) - f'_m (xi)) <= sup norm(f'_n - f'_m)
      $
      由一致收敛性，上式右侧当 $n, m$ 足够大时趋于零，从而完成了验证
    ]
    #theorem[][
      设 $f_n$ 每项均可导，$f'_n$ 一致收敛于 $g$，且 $f_n$ 于一点处收敛，则 $f_n$ 一致收敛于 $f$，且 $f' = g$
    ]


    #proposition[][
      设 $f(z) = sum a_n (z - a)^n$，后面的幂级数收敛半径为 $R$，则:
      $
      f'(z) = sum n a_n (z - a)^(n-1), forall z in B(a, R)
      $
      且上式右侧收敛半径也为 $R$
    ]
    #proof[
      首先，$limsup_(n -> +infinity) norm(n a_n)^(1/n) = limsup_(n -> +infinity) norm(a_n)^(1/n)$ 给出它们具有相同的收敛半径\
      其次，计算收敛半径幂级数和形式导数将在 $B(a, R)$ 上内闭一致收敛，由前面的命题知结论成立
    ]
    #corollary[][
      - 幂级数函数无穷阶可导
      - $a_n = 1/(n!) f^(n) (a)$
    ]
    #definition[指数函数][
      定义 $e^z = sum_(i=0)^(+infinity) z^n/(n!)$\ 
        当 $z in RR$ 时我们已经熟知，因此在复数上用相同的形式我们扩充定义
    ]
    #corollary[][
      设 $x in RR$，则：
      $
      e^(i x) = cos x + i sin x
      $
    ]
    #proof[
      用幂级数的加法验证即可
    ]
  == 多值函数
    #definition[多值函数|multi valued function][
      称一个映射 $F: s -> P(CC)$ 为多值函数 / 对应|correspondence\
      若存在解析函数 $f(x): s -> CC$ 使得：
      $
      f(x) in F(x), forall x in s
      $
      则称 $f(x)$ 是 $F(x)$ 的解析分支
    ]
    #let Log = "Log"
    #definition[对数函数][
      定义：
      $
      Log x = {z in CC: e^z = x},forall x in CC - {z | z <= 0}
      $
      为多值函数，显然有：
      $
      Log x = {x_0 + 2 k i pi | k in ZZ}, forall x_0 in Log x
      $
    ]
    #remark[][
      多值函数某种意义上可以理解为无穷维复平面 $CC^infinity$ 到 $CC$ 的函数
    ]
  == 分式线性变换
    #definition[分式线性变换/莫比乌斯变换 | linear fractional transformation/Mobius Transformation][\
      称 $f: CC -> CC$ 为分式线性变换，如果存在 $a, b, c, d in CC$ 使得：
      $
      f(z) = (a z + b)/(c z + d)
      $
      当 $a d - b c != 0$ 时，称之为莫比乌斯变换
    ]
    #proposition[][
      - 分式线性变换的逆映射还是分式线性变换
      - 分式线性变换的复合还是分式线性变换
      - 分式线性变换由三点的像唯一确定
    ]
= 积分
  == 有界变差
    #definition[][
      称一个实函数 $f: [a, b] -> RR$ 是有界变差函数，如果对于任意划分 $P : x_0 = a < x_1 < x_2 <...< x_n = b$，均有：
      $
      v(f;P) := sum_(i=1)^(n) abs(f(x_i) - f(x_(i-1))) < M
      $
      其中 $M$ 是与 $P$ 无关的常数，此时记：
      $
      v(f) = sup_P v(f;P)
      $
      称一个曲线是可求长的，如果函数是有界变差函数
    ]
    #proposition[][
      分段光滑曲线是有界变差的，且：
      $
      v(f) = integral_a^b abs(f'(x)) dif x
      $
    ]
    #definition[积分][
      设 $f$ 是连续实值函数，$gamma$ 是有界变差曲线，则存在唯一的复数 $I$ 使得对于任意 $epsilon > 0$，存在 $delta > 0$ 及分划 $P$ 满足 $norm(P) < delta$，且：
      $
      norm(I - sum_i f(tau_i)(gamma(t_k) - gamma(t_(k-1)))) < epsilon
      $
      此时，记 $I = integral_(gamma)^() f dif z$
    ]
    #proposition[][
      设 $f$ 是连续实值函数，$gamma$ 是分段光滑曲线，则：
      $
      integral_(gamma)^() f dif z = integral_a^b f(gamma(t)) gamma'(t) dif t
      $
    ]
    #definition[积分][
      设 $f$ 是复连续函数，$gamma$ 是可求长曲线，则称：
      $
      integral_(gamma)^() f(gamma(t)) dif gamma(t)
      $
      为函数在曲线上的积分，也记作 $integral_(gamma)^() f(z) dif z$ 或 $integral_(gamma) f$
    ]
    #definition[][
      设 $abs(gamma)(t) = sup{sum_(k=1)^n abs(gamma(t_k) - gamma(t_(k-1))), t_i "is partition of "[a, t]}$，则它是单调函数，继而有界变差，记：
      $
      integral_(gamma)^() f abs(dif z) = integral_a^b f(gamma(t)) dif abs(gamma)(t)
      $
    ]
    #proposition[][
      $
      norm(integral_(gamma)^() f ) <= integral_(gamma)^() norm(f) abs(dif z) <= V(gamma) sup_{z in gamma} norm(f(z))
      $
    ]

  #theorem[Cauthy 1][
    设 $G$ 是有界区域，其边界是有限多条光滑曲线。$f$ 在区域内解析，在区域的闭包上连续，则有：
    $
    integral_(diff G) f(z) dif z = 0
    $
  ]
  #proof[
    - 首先，先放松一点条件，假设 $G$ 是三角形区域，而 $f$ 在区域的闭包上解析。\
      设三角形为 $A B C$，取三边的中点 $A', B', C'$，注意到积分恰可以分到四个三角形上，也即：
      $
      integral_(diff G) f(z) dif z = sum_(i=1)^4 integral_(triangle.t_i) f(z) dif z
      $
      以三角形 $A C' B'$ 为例，注意到 $f$ 解析，有：
      $
      integral_(diff A C' B) f(z) dif z = integral_(diff A C' B) f(z_0) + (z-z_0) f'(z_0) + o(z- z_0)  dif z\
      = integral_(diff A C' B) o(z- z_0)  dif z
      $
      这里的 $z_0$ 可以任取\
      假设积分非零，不妨设为 $M > 0$，则四个三角形中总有一个积分的绝对值大于等于 $M/4$，记为 $triangle.t_1$\
      接下来，再次四分并取其中一个积分大于等于 $M/16$，记为 $triangle.t_2$，如此下去，我们得到一个序列 $triangle.t_i$，使得：
      $
      abs(integral_(diff triangle.t_i) f(z) dif z) >= abs(M/4^i)\
      integral_(diff triangle.t_i) abs(f(z)) >= M/4^i
      $
      另一方面，注意到:
      $
      integral_(diff triangle.t_i) abs(f(z)) <= integral_(diff triangle.t_i) abs(o(z- z_0))  dif z <= c(triangle.t_i) d(triangle.t_i) a_i
      $
      其中 $c$ 是周长，$d$ 是直径，$a_i -> 0$，有：
      $
      c(triangle.t_i) d(triangle.t_i) a_i = b_i 1/(4^i), b_i -> 0
      $
      两式结合即得 $M <= b_i => M <= 0$，矛盾！
    - 下一步，对于一般的多边形，它可以进行三角剖分（证明略显复杂和初等，这里不证），对每个三角形应用之前的结论便可得证
    - 对于一般的区域 $G$，我们希望对于任意 $epsilon > 0$，取得多边形区域 $D$，它的闭包含于 $G$，而：
      $
      abs(integral_(diff G)^() f(z) dif z - integral_(diff D) f(z) dif z) < epsilon
      $
      假若能取得，由引理立得结论成立。\
      该命题作为 bonus question\
      首先处理单个光滑曲线 $S$：
      $
      forall t in [0, 1]
      cases(
        x = u(t),
        y = v(t)
      )\
      $
      目标相当于构造相同起点的终点的分段线性曲线使得 $f$ 在两者上积分的差足够小。取分段线性曲线一致收敛于原曲线是容易的，但一致收敛不能保证曲线积分收敛（这就是楼梯悖论），因此需要更精细的估计。\
      先给出如下引理：
      #lemma1[
        设 $T_n subset G$：
        $
        forall t in [0, 1]
        cases(
        x = x_n (t),
        y = y_n (t)
      )
        $
        是一族分段线性曲线，且有：
        $
        x_n arrows.rr u, y_n arrows.rr v\
        x'_(n-) arrows.rr u', y'_(n-) arrows.rr v'
        $
        （分量左导数一致收敛于原曲线分量的导数）\
        则有：
        $
        lim_(n -> infinity) integral_(T_n) f(z) dif z = integral_(S) f(z) dif z
        $
      ]
      #proof[
        // 注意到 $u'(t)^2 + v'(t)^2 != 0$，从而将有正下界\
        // 同时由一致收敛性，$x'_(n-)^2 + y'_(n-)^2$ 与 $u'(t)^2 + v'(t)^2$ 将有共同的一致正下界，不妨设为 $m'$\ 
        由 $sqrt(x)$ 在 $[0, +infinity)$ 上的一致连续性（有限区间由连续函数一致连续给出，之后的无穷区间由导数有界给出）可以得到：
        $
        sqrt(x'_(n-)^2 + y'_(n-)^2) arrows.rr sqrt(u'^2 + v'^2)
        $
        同时由 $f$ 在有界闭集上的连续性，它也一致连续，进而：
        $
        f(x_n (t) + i y_n (t)) arrows.rr f(u(t) + i v(t))
        $
        注意到 $f(u(t) + i v(t)), sqrt(u'^2 + v'^2)$ 都是有界闭集上的连续函数，继而有界。\
        由此 $f(x_n (t) + i y_n (t)), sqrt(x'_(n-)^2 + y'_(n-)^2)$ 也有公共上界，由两个一致有界，一致收敛的函数列相乘的性质可得：
        $
        f(x_n (t) + i y_n (t)) sqrt(x'_(n-)^2 + y'_(n-)^2) arrows.rr f(u(t) + i v(t)) sqrt(u'^2 + v'^2)
        $
        进而利用一致收敛性保持积分的性质：
        $
        lim_(n -> infinity) integral_(0)^1 f(x_n (t) + i y_n (t))  sqrt(x'_(n-)^2 + y'_(n-)^2) dif t = integral_(0)^1 f(u(t) + i v (t)) sqrt(u'^2 + v'^2) dif t
        $
        而：
        $
        integral_(0)^1 f(u(t) + i v (t)) sqrt(u'^2 + v'^2) dif t = integral_(S) f(z) dif z\
        integral_(0)^1 f(x_n (t) + i y_n (t))  sqrt(x'_(n-)^2 + y'_(n-)^2) dif t = integral_(T_n) f(z) dif z
        $
        前项成立是定义，后项成立是仅差有限个点的积分有相等的值，得证
      ]

  ]
  #theorem[Cauthy 2][
    设 $G$ 是有界区域，其边界是有限多条光滑曲线。$f$ 在区域内解析，在区域的闭包上连续，则对任意 $z in G$，$omega$ 是任意一个将 $z$ 包括在内的简单闭曲线，有：
    $
    f(z) = 1/(2 pi i) integral_(diff omega) f(w)/(w - z) dif w
    $
  ]
  #proof[
    由之前的 Cauthy 定理，只需要考虑 $omega$ 是某个任意小的球形开邻域，则：
    $
    1/(2 pi i) integral_(diff omega) f(w)/(w - z) dif w = 1/(2 pi i) integral_(diff omega) f(z)/(w - z) + f'(z) + o(1) dif z\
    = f(z) + 1/(2 pi i) integral_(diff omega) o(1) dif w\
    $
    注意到 $delta$ 可以任意小，因此上式右侧可以任意小，进而得证
  ]
  #theorem[Cauthy 3][
    设 $G$ 是有界区域，其边界是有限多条光滑曲线。$f$ 在区域的闭包上解析，则 $f$ 可在 $G$ 上可以表示为级数，且该级数的收敛半径至少为 $G$ 的最大半径\
    特别的，$f$ 无穷阶可导
  ]
  #proof[
    不妨设将 $f$ 延拓到更大的区域上，我们有：
    $
    f(z) = 1/(2 pi i)integral_(diff G)^() f(w)/(w - z) dif w\
    = 1/(2 pi i)integral_(diff G)^() - 1/w f(w)(sum_(k=0)^infinity (z/w)^k ) dif w\ 
    = z^k sum_(k=0)^infinity 1/(2 pi i)integral_(diff G)^() - 1/w f(w) 1/w^k dif w\
    $
    不难看出上式右侧恰为幂级数，得证
  ]
= 整函数与解析函数的基本定理
  == 基本定理
    #definition[整函数][
      称一个 $CC -> CC$ 的解析函数是整函数。等价的，它的幂级数表示的收敛半径为正无穷
    ]
    #theorem[Liouville][
      设 $f$ 是整函数，且有界，则 $f$ 是常数
    ]
    #proof[
      假设 $sup norm(f) = M < +infinity$，由柯西估计，有：
      $
      norm(f'(z)) <= M / r, forall r in CC
      $
    ]
    #corollary[代数基本定理][
      设 $p(z)$ 是非常数多项式，则 $p(z)$ 有根
    ]
    #proof[
      如若不然，此时可设 $norm(p(z)) > c > 0$，
      这是因为可以验证 $lim_(z -> infinity) norm(p(z)) = +infinity$，而在任何有限闭区域上，函数有最小值 $m > 0$\
      则：
      $
      1/(p(z))
      $
      是整函数，并且有界 $1/c$，由 Liouville 定理知它是常数，矛盾
    ]
    #theorem[][
      设 $f: Omega -> CC$ 是解析函数，以下事实等价：
      - $f= 0$
      - $exists z in Omega, forall n in NN, f^((n))(z) = 0$
      - $Inv(f)(0)$ 有极限点
    ]
    #proof[
      略
    ]
    #theorem[开映射原理][
      非常数的解析函数是开映射，也即将开集映成开集
    ]
    #proof[
      这个定理的证明比较复杂，留在下节
    ]
    #theorem[最大模原理][
      设 $f: Omega -> f$ 是开区域上的解析函数，并且存在 $a$ 使得：
      $
      norm(f(z)) <= norm(f(a)), forall z in Omega
      $
      则 $a$ 是常数
    ]
    #proof[
      如若不然，注意到 $f(B(a, r))$ 是开集，显然矛盾！
    ]
  == 缠绕数，柯西积分定理
    #definition[Index/winding number of a closed curve][
      设 $gamma: [0, 1] -> CC$ 是一个可求长闭曲线，任取 $a in.not gamma$，则称：
      $
      1/(2 pi i) integral_(gamma)^() 1/(z-a) dif z
      $
      为曲线的缠绕数 $b(gamma, a)$
    ]
    对于可求长曲线，这个数字描述了曲线绕着 $a$ 的次数，如果是正数，那么曲线绕着 $a$ 逆时针旋转，否则顺时针旋转。颇为神奇的是，我们有：
    #proposition[][
      缠绕数为一个整数
    ]
    #proof[
      不失一般性，设曲线是光滑的（否则可以取得远离 $a$ 的曲线使得积分逼近）\
      定义：
      $
      g(t) := integral_(0)^(t) (gamma'(s))/(gamma(s) - a) dif s
      $
      则：
      $
      g'(t) = (gamma'(t))/(gamma(t) - a)\
      (e^(-g)(gamma - a))' = e^(-g) gamma' - e^(-g) g'(gamma - a) = 0
      $
      从而 $e^(-g)(gamma - a) = e^(-g(0))(gamma(0) - a) = gamma(0) - a = e^(-g(1))(gamma(1) - a)$
      注意到 $gamma(0) = gamma(1) != a$，故 $g(1) = 2 k pi i, k in ZZ$\
      这就给出了：
      $
      1/(2 pi i) integral_(gamma)^() 1/(z-a) dif z = 1/(2 pi i) g(1) = k in ZZ
      $
    ]
    #example[][
      - 由柯西积分定理，简单闭曲线对于内部点的缠绕数当然就是 $1$
    ]
    #proposition[][
      - $n(gamma, a) = -n(-gamma, a)$
      - $n(gamma + sigma, a) = n(gamma, a) + n(sigma, a)$
      - 在 $gamma$ 产生的每个连通分支上，缠绕数是常数
      - 在 $gamma$ 唯一一个非有界连通分支上，缠绕数为 $0$
    ]
    #proof[
      - 积分的定义
      - 同样利用定义
      - 注意到积分是连续函数，而值域是离散的，因此只能在每个连通分支上是常数
      - 首先说明非有界连通分支唯一。由于 $gamma$ 是紧集上的连续函数，当然有界 $M$ 。无界连通分支当然有 $M$ 之外的点，因此只能是唯一一个。\
        其次，$a$ 充分大时积分当然趋于零，而在该连通分支上享有相同的值，因此只能是零
    ]
    #lemma[][
      设 $gamma$ 是可求长曲线，$phi: gamma -> CC$ 连续，$m in NN$，则：
      $
      F_m (z) = 1/(2 pi i) integral_(gamma)^() phi(w)/(w - z)^m dif w, forall z in CC -gamma
      $
      是解析函数，且：
      $
      F'_m (z) = m F_(m+1) (z)
      $
    ]<lemma-der>
    #proof[
      - 由积分的性质知道它是连续函数，固定 $z, a in CC - gamma$，计算:
        $
        1/(w-z)^m - 1/(w - a)^m = (1/(w-z) - 1/(w-a))(sum_(k=0)^(m-1) 1/(w-z)^k 1/(w-a)^(m-1-k))\
        = (z-a) sum_(k=0)^(m-1) 1/(w-z)^(k+1) 1/(w-a)^(m-k)
        $
      - 则：
        $
        (F_m (z) - F_m (a))/(z-a) = 1/(2 pi i) integral_(gamma)^() phi(w)  sum_(k=0)^(m-1) 1/(w-z)^(k+1) 1/(w-a)^(m-k) dif w\
        $
        令 $z -> a$，上式右侧当然趋于（这里一致性可以保证）：
        $
        1/(2 pi i) integral_(gamma)^() phi(w)  sum_(k=0)^(m-1) 1/(w-a)^(m+1) dif w\
        = m F_(m+1) (a)
        $
    ]
    #theorem[Cauthy Integral formula 1][
      设 $G subset CC$ 是开集，$f: G -> CC$ 解析，$gamma subset G$ 可求长并且：
      $
      n(gamma, w) = 0, forall w in CC - G
      $
      则对于任意 $a in G - gamma$，有：
      $
      n(gamma, a) f(a) = 1/(2 pi i) integral_(gamma)^() f(w)/(w - a) dif w
      $
    ]
    #proof[
      定义：
      $
      funcDef(phi, G times G, CC, (z, w) , cases(
        (f(w) - f(z))/(w - z) "if" w != z,
        f'(z) "if" w = z
      ))
      $
      断言 $phi$ 是连续函数，且任给 $z$，$phi(z)$ 是解析函数\
      再定义：
      $
      funcDef(g, CC, CC, z, cases(
          integral_(gamma)^() phi(z, w) dif w "if" z in G,
          integral_(gamma)^() f(w)/(w - z) dif w "if" n(gamma, z) = 0 
      ))
      $
      为了证明它是良定义的，取 $z in G$ 使得 $n(gamma, w) = 0$，此时：
      $
      integral_(gamma)^() (f(w) - f(z))/(w - z) dif w  = integral_(gamma)^() f(w)/(w-z) dif w - 2 pi i f(z) n(gamma, w) = integral_(gamma)^() f(w)/(w-z) dif w
      $
      可以验证 $g$ 是解析的，然而有界并在 $z$ 充分大时趋于零，因此就是 $0$\
      换言之：
      $
      0 = integral_(gamma)^() (f(w) - f(z))/(w - z) dif w  = integral_(gamma)^() f(w)/(w-z) dif w - 2 pi i f(z) n(gamma, w)
      $
    ]
    #theorem[Cauthy Integral formula 2][
      设 $G subset CC$ 是开集，$f: G -> CC$ 解析，$gamma_i subset G$ 可求长并且：
      $
      sum_i n(gamma_i, w) = 0, forall w in CC - G
      $
      则对于任意 $a in G - union_i gamma$，有：
      $
      sum_k n(gamma_k, w) f(a) = sum_k 1/(2 pi i) integral_(gamma_k)^() f(w)/(w - a) dif w
      $
    ]
    #theorem[Cauthy theorem 1][
      设 $G, f, gamma_i$ 条件同上，则：
      $
      sum_k integral_(gamma)^() f dif z = 0
      $
    ]
    #proof[
      任取 $a$，对 $f(z) (z-a)$ 利用积分公式 2 即可
    ]
    #theorem[][
      设 $G, f, gamma_i$ 条件同上，则对于任意 $a in G - union_i gamma$，有：
      $
      sum_k n(gamma_k, w) f^(k)(a) = k! sum_k 1/(2 pi i) integral_(gamma_k)^() f(w)/(w - a)^(k+1) dif w
      $
    ]
    #proof[
      由 @lemma-der，上式右侧就是 $F_(k+1) (a)$，归纳即可
    ]
    #definition[zero][
      设 $G$ 是开集，$f: G -> CC$ 解析，将 $f$ 在 $G$ 内的零点带重数排成 $x_1, x_2, ..., x_n$，称为零点集。
    ]
    #proposition[][
      设 $x_i$ 是所有零点，若闭的可求长曲线 $gamma$ 满足：
      $
      forall z in CC - G, n(gamma, z) = 0\
      forall i, x_i in.not gamma
      $
      则有积分公式：
      $
      1/(2 pi i) integral_(gamma)^() (f'(w))/f(w) dif w = sum_k n(gamma, x_k) 
      $
    ]
    #proof[
      可设：
      $
      f(z) = (product_i (z - x_i)) g(z)
      $
      则 $g(z)$ 解析且非零。将有：
      $
      1/(2 pi i) integral_(gamma)^() (f'(w))/f(w) dif w\
      = 1/(2 pi i) integral_(gamma)^() sum_k 1/(z - x_k) + (g'(z))/g(z) dif w
      $
      利用柯西定理即得
    ]
    #corollary[][
      设 $x_i$ 是 $f(x) = lambda$ 在 $G$ 上的带重数零点，则：
      $
      1/(2 pi i) integral_(gamma)^() (f'(w))/(f(omega) - lambda)dif w = sum_k n(gamma, x_k) 
      $
    ]
    #proof[
      对 $f(x) - lambda$ 利用上面的命题即可
    ]
    #theorem[][
      设 $f: B(a, R) -> CC$ 解析，$alpha = f(a)，$若 $f(x) - f(a)$ 有 $m >= 1$ 重零点，则存在 $alpha$ 的开邻域 $B_alpha$ 和 $a$ 的开邻域 $B_a$，使得：
      $
      forall beta in B, f(z) - beta 在 B_a "上恰有" m "个简单零点（重数为 1 的零点）"
      $
    ]
    #proof[
      先取 $epsilon_1 in B(z, 1/2 R)$，满足：
      $
      forall z in B(a, 2 epsilon_1) - {a}, f(z) != alpha and f'(z) != 0
      $
      这样的 $epsilon$ 存在是因为注意到 $Inv(f)(0)$ 在 $G$ 内是离散的，$Inv(f')(0)$ 也是，从而 $a$ 不是两者的聚点，当然有去心邻域与两者不交

      定义：
      $
      gamma(t) = a + epsilon e^(2 pi i t), t in [0, 1]\
      sigma(t) = f(gamma(t)) 
      $
      注意到 $alpha in.not sigma$，故存在 $alpha$ 的开邻域 $B_alpha$ 与 $gamma$ 不交，这个邻域当然属于 $sigma$ 分割出的同一个连通分支，进而缠绕数是常数。事实上，有：
      $
      forall beta in B_a,  m = n(sigma, alpha) = n(sigma, beta)
      $
      取 $G = B(a, 2 epsilon)$，应用之前的定理得：
      $
      n(sigma, beta) = sum_(k=1)^p n(gamma, z_k) = m
      $
      $z_k$ 是 $f(z) - beta$ 在 $G$ 中的所有零点，注意到这里 $n(gamma, z_k)$ 只能为 $0, 1$（既然 $epsilon$ 的取法保证了导数非零，进而没有重根。\
      同时，观察曲线的取法可得 $gamma subset B(a, epsilon)$，因此所有 $z_k in B(a, 2 epsilon) - B(a, epsilon)$ 对应的缠绕数都是零，由上面的等式看出 $B(a, epsilon)$ 上恰有 $m$ 个一重零点，证毕
    ]
    终于可以回到开映射定理的证明：
    #corollary[开映射原理][]
    #proof[
      任取 $a, alpha = f(a)$，由上面的定理，存在 $B_a, B_alpha$ 使得：
      $
      B_alpha subset f(B_a)
      $
      因此 $f$ 将内点映成内点，进而是开映射
    ]
    上面的定理还给出了如下有用的推论
    #corollary[][
      设 $f$ 是 $omega -> omega'$ 的满的单叶解析函数，则 $f' != 0$，且 $f$ 有解析的逆映射，满足：
      $
      (Inv(f))'(f(z)) = 1/(f'(z))
      $
    ]
    #proof[
      - 先证明导数非零，假设 $f'(a) = 0$，则 $f(z) - f(a)$ 有二重零点，由上面的定理知道存在 $beta$，$f - beta$ 至少有两个零点，矛盾！
      - 既然是双射，当然有逆映射。注意到 $f$ 是开映射，因此逆映射当然也连续。
    ]
  == 其他常用定理
    #theorem[Weierstrass][
    设 $f$ 是非常值的整函数，则有：
    $
    overline(f(CC)) = CC
    $
    ]
    #proof[
    如若不然，存在 $z in CC$ 使得 $norm(f(x) - z) > epsilon$，此时：
      $
      1/(f(x) - z), forall x in CC
      $
      成为有界的整函数，继而是常数，矛盾！
    ]
    #theorem[Little Picard][
      设整函数 $f$ 不是多项式，则称之为 transcendental entire function|超越整函数。对于超越整函数，它的像集至多比 $CC$ 少一个点
    ]
    #proof[
      有时间的话稍后进行证明
    ]
    #theorem[Mean Value theorem|平均值定理][
      \
      设 $f: Omega -> CC$，$forall z in Omega, r > 0 with overline(B(z, r)) subset Omega$，有：
      $
      f(z) = 1/(2 pi) integral_(0)^(2 pi) f(z + r e^(i theta)) dif theta\
      norm(f(z)) <= 1/(2 pi) integral_(0)^(2 pi) norm(f(z + r e^(i theta))) dif theta
      $
      换言之，$f(z)$ 就是周围值的平均值\
      更进一步，还有：
      $
      norm(f(z)) <= 1/(pi r^2) integral_(B(z, r))^() norm(f(z)) dif z
      $
      （实平面上的二重积分）
      
    ]
    #proof[
      就是柯西积分的特殊情况
    ]
  == 与几何与分析有关的定理
    #lemma[Schwarz][
      设 $f: B(0, 1) -> B(0, 1)$ 解析，且 $f(0) = 0$，则：
      - $forall z in B(0, 1), norm(f(z)) <= norm(z), norm(f'(0)) <=1$
      - 以下事实等价：
        - 存在 $z_0 != 0$，使得 $norm(f(z_0)) = norm(z_0)$
        - $f'(0) = 1$
        - 存在 $theta$ 使得 $f(z) = z e^(i theta)$
    ]
    #proof[
      - 对它做级数展开得到：
        $
        f(z)/z = sum a_i z^i
        $
        若它是常数已经证毕，否则根据最大模原理，$forall 0 < r < 1$ 它的模在 $B(0, r)$ 上不能取最大值，在 $overline(B(0, r))$ 上的最大值只能在边界处取得，继而：
        $
        norm(f(z)/z) <= norm(f(z_r)/r) <= 1/r , forall z in B(0, r)
        $
        令 $r -> 1$ 即得第一条。特别的，$f'(0) = a_0$ 满足 $norm(f'(0)) <= 1$
      - 直接利用最大模原理即可
    ]
    #lemma[][
      设 $g$ 是 $B(0, 1)$ 上的双全纯映射，则:
      $
      g(z) = e^(i theta) (z - z_0)/(1 - overline(z_0) z)
      $
      其中 $z_0$ 是 $B(0, 1)$ 上的一个点
    ]
    #proof[
      设 $l_(z_0) (z) = e^(i theta) (z - z_0)/(1 - overline(z_0) z_)$，可以检查 $l_(z_0) compose l_(-z_0) = 0$，进而双全纯\
      令 $l = l_(g(0)), l(g(0)) = 0$\
      令 $f = l(g(z))$，则：
      $
      f(0) = 0
      $
      利用之前的 Schwarz，将有：
      $
      norm(f'(0)) <= 1\
      norm(f^(-1)(0)) <= 1
      $
      从而取等，进而 $f$ 是旋转，倒回即可

    ]
    #lemma[Schwarz（更强的版本）][
      设 $f: B(0, 1) -> B(0, 1)$ 解析，则：
      $
      norm(f(z_1) - f(z_2))/norm(1-overline(f(z_1)) f(z_2)) <= norm(z_1 - z_2)/(norm(1 - overline(z_1) z_2))
      $
      取等当且仅当双全纯
    ]
    #corollary[][
      令 $z_1 -> z_2 -> z$，得：
      $
      norm(f'(z))/(1 - norm(f(z))^2) <= 1/(1 - norm(z)^2)
      $
    ]
    #definition[庞加莱圆盘][
      在圆盘 $B(0, 1)$ 上定义长度微元：
      $
      dif s = (norm(dif z))/(1 - norm(z)^2)
      $
    ]


    