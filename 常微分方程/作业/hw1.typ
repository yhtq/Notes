#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#set heading(numbering: none)
= P6 
  == 1 (2)
    代入得：
    $
    y' + y/x = (x cos x - sin x)/x^2 + (sin x)/x^2 = (cos x)/x\
    $
    从而确实是原微分方程的解
  == 3
    $
    y = c_1 e^x + c_2 x e^x\
    y' = c_1 e^x + c_2 e^x + c_2 x e^x = c_1 e^x + c_2 (x + 1) e^x\
    y'' = c_1 e^x + c_2 (x+2) e^x
    $
    消去 $c_1, c_2$:
    $
    y' - y = c_2 e^x \
    y'' - y' = c_2 e^x\
    => y' - y = y'' - y'
    $
    这就是所求微分方程
  == 4
    $
    &0 = c_1 x + (y - c_2)^2\
    =>& 0 = dif (c_1 x + (y - c_2)^2) = c_1 dif x + 2 (y - c_2) dif y\
    =>& 0 = c_1 + 2 (y - c_2) der(y, x)\
    =>& 0 = der((c_1 + 2 (y - c_2) der(y, x)), x)\
    =>& 0 = 2 (der(y, x))^2 + 2(y - c_2) (dif^2 y)/(dif x^2)\
    =>& 0 = (der(y, x))^2 + (y - c_2) (dif^2 y)/(dif x^2)
    $
    整理得：
    $
    y - c_2 = - y'^2/y''\
    c_1 = -2(y - c_2) y' = 2 y'^3/y''\
    $
    代入原式：
    $
    0 = 2 y'^3/y'' x + y'^4/y''^2\
    <=> 0 = 2 y'' x + y'
    $
    这就是所求微分方程
  == 5
    平面上一切圆的方程形如：
    $
    (x - c_1)^2 + (y-c_2)^2 = c_3
    $
    求微分及求导得：
    $
    0 = dif ((x - c_1)^2 + (y-c_2)^2) = 2(x - c_1) dif x + 2(y - c_2) dif y\
    => 0 = (x - c_1) + (y - c_2) y'\
    => 0 = der(((x - c_1) + (y - c_2) y'), x)\
    => 0 = 1 + y'^2 + (y - c_2) y''\
    => 0 = 1/y'' + y'^2/y'' + (y - c_2) "(显然" y'' != 0 ")"\
    => 0 = der((1/y'' + y'^2/y'' + (y - c_2)), x)\
    => 0 = -1/y''^2 y''' + (2 y' y''^2 - y'^2 y''')/y''^2 + y'\
    => 0 = - y''' + 2 y' y''^2 - y'^2 y''' + y' y''^2\
    => y''' = 3 y' y''^2 - y'^2 y'''
    $
= P10
  == 2.(2)
    注意到 ：
    $
    y' = k <=> x^2 + y^2 = k
    $
    这是平面上的圆周。换言之，线素场在某点处的斜率为到原点距离的平方。由此原方程的解应该单调递增，且距离原点越远增长越快
  == 4.
    拐点应满足：
    $
    y'' = 0\
    <=> (y')' = 0\
    <=> (y - x^2)' = 0\
    <=> y' = 2x\
    <=> y - x^2 = 2x
    $
    这就是拐点满足的方程
  = P18
    #let properEquationCheck(p, q) = $partialDer(#p, y) - partialDer(#q, x)$
    == 1.
      $
      partialDer(4 x^2 y - y, y) - partialDer(3 x + y, x) = 4x^2 - 1 - 3= 4x^2 - 4 != 0
      $
      不是恰当方程
    == 3.
      $
      properEquationCheck((a x - b y), (b x - c y)) = - b - b = - 2 b
      $
      当且仅当 $b = 0$ 时是恰当方程，此时方程形如：
      $
      a x dif x - c y dif y = 0\
      <=> dif (a x^2 - c y^2) = 0
      $
      通解为 $a x^2 - c y^2 = C$
    == 5.
      $
      properEquationCheck((3 x^2 (1 + ln y)), (- 2 y + x^3 / y)) = 3x^2/y - 3 x^2 /y = 0
      $
      是恰当方程\
      设其解为 $phi$，注意到：
      $
      partialDer(phi, x) = 3 x^2 (1 + ln y) =>& phi = x^3 (1 + ln y) + C(y)\
      =>& partialDer(phi, y) = x^3/y + C'(y) = - 2 y + x^3 / y\
      =>& C'(y) = - 2 y\
      =>& C(y) = - y^2 + C_1\
      =>& phi = x^3 (1 + ln y) - y^2 + C_1
      $
    == 7.
      $
      properEquationCheck((2x(1 + sqrt(x^2 - y))), (-sqrt(x^2 - y))) = -x/sqrt(x^2 - y) + x/sqrt(x^2 - y) = 0
      $
      是恰当方程\
      尝试进行配凑：
      $
      (2x(1 + sqrt(x^2 - y))) dif x + (-sqrt(x^2 - y)) dif y = 0\
      dif x^2 + 2x sqrt(x^2 - y) dif x  +(-sqrt(x^2 - y)) dif y = 0\
      dif x^2 + 2/3 dif (x^2 - y)^(3/2) = 0\
      dif (x^2 + 2/3 (x^2 - y)^(3/2)) = 0\
      x^2 + 2/3 (x^2 - y)^(3/2) = C
      $
    == 9.
      $
      properEquationCheck(y/x, (y^3 + ln x)) = 1/x - 1/x = 0
      $
      是恰当方程，尝试进行配凑：
      $
      y/x dif x + (y^3 + ln x)dif y = 0\
      y dif ln x + ln x dif y + 1/4 dif y^4 = 0\
      dif (y ln x) + 1/4 dif (y^4) = 0\
      y ln x + 1/4 y^4 = C
      $
  = P42 1.
    == (1)
      容易验证这不是恰当方程，猜测积分因子形如 $f(x)$，应满足：
      $
      properEquationCheck(y^2 f(x), y f(x)) = 0\
      <=> 2y f(x) = y f'(x)\
      $
      只需取 $f(x) = e^(2 x)$，原方程变为：
      $
      e^(2x)(x^2 + x) dif x + e^(2x) y^2 dif x + e^(2x) y dif y = 0\
      e^(2x)(x^2 + x) dif x + 1/2 y^2 dif e^(2x) + 1/2 e^(2x) dif y^2 = 0\
      dif (integral e^(2x)(x^2 + x) dif x + 1/2 y^2 e^(2x)) = 0\
      integral e^(2x)(x^2 + x) dif x + 1/2 y^2 e^(2x) = C \
      e^(2x) (1/2 x^2 - 1/2 x + 1/4) + 1/2 y^2 e^(2x) = C
      $
    == (3)
      $
      y/sqrt(1 + y^2) dif y = x dif y + y dif x\
      dif (sqrt(1 + y^2)) = dif(x y)\
      sqrt(1 + y^2) = x y + C
      $
    == (5)
      - $y = 0$ 是原方程的一个解
      - 当 $y != 0$ 时
        $
        (y dif x - x dif y)/(x^2) = 2x  tan y/x dif x\
        2x tan y/x dif x + dif y/x = 0\
        2x dif x + 1/(tan y/x) dif y/x = 0\
        dif x^2 + dif (integral 1/(tan y/x) dif y/x) = 0
        $
        其中：
        $
        integral 1/(tan u) dif u = integral (cos u)/(sin u) dif u = ln |sin u| + C
        $
        上式化为：
        $
        x^2 + ln |sin y/x| = C
        $
        显然该曲线上 $y$ 应该保持定号，因此:
        $
        x^2 + ln (sin y/x) = C\
        x^2 + ln (- sin y/x) = C\
        $
        都是可能的通解
    == (7)
      猜测积分因子形如 $f(x)$，试算：
      $
      0 = properEquationCheck(f(x)(x^2-y^2+y), x f(x) (2y-1)) = (1-2y)f(x) - (2y - 1)(x f(x))'
      $
      只需取 $(x f(x))' = -f(x), x f'(x) + 2 f(x) = 0$ 的一个解 $f(x) = 1/x^2$ 即可，原方程变为：
      $
      (1 - (y^2 - y)/x^2) dif x + (2y - 1)/x dif y = 0\
      dif x + (x(2y - 1) dif y - (y^2 - y) dif x)/x^2 = 0\
      dif x + dif ((y^2 - y)/x) = 0\
      x^2 + y^2 - y = C x\
      $
  = P27 
    == 1.
      === (4)
        令 $t = y + 2 x - 1/2$，有：
        $
        t' = y' + 2 = sqrt(2 t) + 2\
        $
        显然 $sqrt(2t) + 2 > 0$，因此：
        $
        (dif t) / (sqrt(2 t) + 2) = dif x\
        integral (dif t) / (sqrt(2 t) + 2) = x + C\ 
        $
        为求 $integral (dif t) / (sqrt(2 t) + 2)$，令 $u = sqrt(2 t)$，有：
        $
        dif u = sqrt(2)/(2 sqrt(t)) dif t\
        integral (dif t) / (sqrt(2 t) + 2) = integral (sqrt(2t) dif u)/(sqrt(2t) + 2) = integral (u dif u)/(u + 2) \
        = integral 1 - 2/(u + 2) dif u \
        = u - 2 ln |u + 2| + C\
        = u - 2 ln (u + 2) + C\
        = sqrt(2 t) - 2 ln (sqrt(2 t) + 2) + C\
        $
        综上，原方程的通解为：
        $
        sqrt(4x + 2y - 1) - 2 ln(sqrt(4x + 2y - 1) + 2) = x + C
        $
        代入点 $(0, 1)$，得：
        $
        1 - 2 ln 3 = C\
        sqrt(4x + 2y - 1) - 2 ln(sqrt(4x + 2y - 1) + 2) = x + 1 - 2 ln 3
        $
      === (7)
        $
        3y^2 dif y + (16 x - 2x y^3) dif x = 0\
        dif y^3 - y^3 2x dif x + 16 x dif x = 0\
        e^(-x^2) dif y^3 + y^3 dif(e^(-x^2)) + 16x e^(-x^2) dif x = 0\
        dif (y^3 e^(-x^2)) + 8 e^(-x^2) dif (x^2) = 0\
        y^3 e^(-x^2) - 8 e^(-x^2)  = C\
        y^3 - 8 = C e^(x^2)
        $
        显然 $x -> infinity$ 时有界当且仅当 $C = 0$，此时 $y^3 = 8$，即 $y = 2$
    == 3.
      设 $f(x)$ 在 $a$ 的邻域 $U$ 上连续，方程的解 $y(x)$ 定义在集合 $X$ 上\
      容易注意到 $y = a$ 一定是原方程的一个解。对于任何 $x_0$ 该解都满足要求。\
      因此，待证结论等价于：
      - $forall x_0 in RR$，不存在非平凡的解使得 $y(x_0) = a$
      任取 $y(x)$ 是一个解，断言：
      - $Inv(y)(a)$ 是连通的\
        任取 $x_1, x_2$ 满足 $y(x_1) = y(x_2) = a$，取 $y$ 在 $[x_1, x_2]$ 处的最大值点 $x$，显然有：
        $
        y'(x) = 0 <=> f(y(x)) = 0 <=> y(x) = a
        $
        最小值点同理，因此 $y(x)$ 在 $[x_1, x_2]$ 上恒为 $a$
      - $Inv(y)(a)$ 是闭集\
        由 $y$ 的连续性这是显然的
      - $Inv(y)(a)$ 一定是闭区间
      - $y$ 是单调的

        设 $y(x_1) = y(x_2) = y_0$，$y_0 = a$ 时区间 $[x_1, x_2]$ 上 $y$ 是常函数，下面不妨设 $y_0 != a$\
        - 断言 $exists.not x_3 in (x_1, x_2)$ 使得 $y(x_3) = y_0$，否则由微分中值定理在 $[x_1, x_3], [x_3, x_2]$ 之间将分别存在一个导函数的零点 $x_(1 3), x_(2 3)$，这意味着：
          $
          y(x_(1 3)) = a, y(x_(2 3)) = a => forall x in [x_(1 3), x_(2 3)], y(x) = a => y(x_3) = a
          $
          矛盾！
        - 由微分方程，显有 $y'(x_1) = y'(x_2) = f(y_0) != 0$，不妨设它们都是正数。然而，这意味着：
          $
          exists x_3, x_4 in (x_1, x_2), y(x_4) < y_0 < y(x_3)
          $
          为了取得 $x_4$，只需要考虑 $x_1$ 的右半邻域，不可能其中所有点都小于等于 $y_0$，否则 $x_1$ 处的右导数非正，这是矛盾的。$x_3$ 可以类似取得

          由此，由介值定理，$x_3, x_4$ 之间将存在某点的值为 $y_0$，与之前的结论矛盾！\
      - 事实上，上面的证明也说明了假若 $y$ 在区间 $I$ 上至多一点为 $a$，则它在 $I$ 上将严格单调\
      // 我们可取一列 $U$ 的子区间 $I_n$ 使得：
      // - $I_n subset I_(n+1)$
      // - $a in.not I_n$
      // - $I_n -> (a, +infinity) inter U$ 或 $(-infinity, a) inter U$\
      //   具体来说，对于任意 $y in (a, +infinity) inter U \/ (-infinity, a) inter U$，存在 $n$ 使得 $y in I_n$\
      //   （上半区间和下半区间的情况是类似的，这里合并讨论即可）
      令 $I$ 是上半区间 $I^+ = (a, +infinity) inter U$ 或下半区间 $I^- = (-infinity, a) inter U$，
      在 $I$ 中任取一点 $y_0$，令：
      $
      F_I (y) = integral_(y_0)^y 1/f(t) dif t, forall y in I
      $
      可以保证 $F(y)$ 是良定义的（右侧的积分一定是通常积分），且 $F'(y) = 1/f(y)$\
      注意到 $F'(y)$ 在定义域上不变号且非负，因此 $F(y)$ 作为连续的严格递增函数有可导的反函数 $F^(-1)(x)$\
      设 $I_x$ 是某个区间满足 $a in.not y(I_x)$，前面说明了 $y$ 在 $I_x$ 上应当严格单调，同时 $1/f(y)$ 也保持定号且非零。取 $I$ 是 $y(I_x)$ 对应的 $y$ 值区间（$a$ 之上或之下），在 $I_x$ 上由微分方程将有：
      $
      1/f(y) dif y = dif x\
      x = integral 1/f(y) dif y + C\
      x = F_I (y) + C\
      y = F^(-1)_I (x - C)
      $<equation>
      此外，题中条件：
      $
      |integral_(a)^(a plus.minus epsilon) 1/f(y) dif y| = + infinity, forall epsilon > 0
      $
      恰好等价于：（注意到 $1/f(y)$ 是定号的，因此反常积分要么存在要么为无穷，类似的变上限积分 $F(y)$的极限也存在或为无穷）
      $
      对 I = I^+ 和 I^-，有 | lim_(y -> a plus.minus) F_I (y) | = + infinity
      $
      - 假设该条件成立，往证不可能 $exists x_0, y(x_0) = a$，否则又考虑到解非平凡，可设 $y(x_1) != a$\
        由于：
        $
        Inv(y)(a inter [x_0, x_1]) != [x_0, x_1], emptyset "且是闭集"
        $
        因此不是开集，进而它的补集 $[x_0, x_1] - Inv(y)(a)$ 不是闭集。\
        换言之，将存在 $x_i -> eta in X$ 使得：
        $
        y(x_i) != a\
        y(eta) = a
        $
        不妨设 $x_i$ 都在 $eta$ 的同侧，进而由于之前证明了 $f$ 一定单调，因此 $y(x_i)$ 一定都在 $a$ 的同侧，设 $y(x_i) in I = I^+ 或 I^-$，它们应当满足@equation:
        $
        x_i = F_I (y(x_i)) + C
        $
        但令 $i -> +infinity$，上式将导出矛盾 $eta = infinity + C$
      - 若该条件不成立，不妨设 $F = F_(I^+)$ 满足：
        $
        lim_(y -> a minus) F (y) = A in RR
        $
        任取 $x_0 in RR$，我们试图构造非平凡的解使得 $y(x_0) = a,$ 令：
        $
        g(x) = cases(
          a quad x <= x_0,
          F_I^(-1)(x - C) quad x > x_0
        )
        $
        其中 $C = x_0 - A$\
        只需验证它满足微分方程。对于 $x != x_0$ 处微分方程的成立性是显然的，只需计算 $x_0$ 处的导数为 $y' = f(y(x_0)) = 0$ （事实上只需计算右导数）即可\
        熟知若 $f(x)$ 于 $x_0$ 处导函数的右极限存在，则右导数存在且等于导函数的右极限。对于 $g(x)$，由于当 $x > x_0$ 时函数满足：
        $
        g' = f(g)
        $
        当 $x -> x_0$ 时，当然有 $g'(x) -> f(g(x_0)) = 0$，由上面叙述的定理知的确有：
        $
        g'(x_0) = 0
        $
        这就验证了 $g$ 是满足要求的原微分方程的解
    == 4.
      先设 $x > 0$，做变量替换：
      $
      x = t^(alpha s) \
      y = t^(beta s) v
      $
      有：
      $
      dif x = alpha s t^(alpha s - 1) dif t\
      dif y = beta s t^(beta s - 1) v dif t + t^(beta s) dif v 
      $
      原方程化为：
      $
      P(t^(alpha s), t^(beta s) v) (alpha s t^(alpha s - 1) dif t) + Q(t^(alpha s), t^(beta s) v)  (beta s t^(beta s - 1) v dif t + t^(beta s) dif v ) = 0\
      t^(d_0 s + alpha s - 1)P(1, v) alpha s dif t + t^(d_1 s + beta s - 1) Q(1, v) beta s v dif t + t^(d_1 s +beta s) Q(1, v) dif v = 0\
      t^(d_0 s + alpha s - 1 - d_1 s - beta s) P(1, v) alpha s dif t + t^(- 1) Q(1, v) beta s v dif t +  Q(1, v) dif v = 0\
      t^(- 1) P(1, v) alpha s dif t + t^(- 1) Q(1, v) beta s v dif t +  Q(1, v) dif v = 0 "(利用" d_0 + alpha = d_1 + beta ")"\
      t^(- 1)  dif t + t^(- 1)  dif t +  Q(1, v)/(P(1, v) alpha s + Q(1, v) beta s v) dif v = 0 \
      $
      这是可分离变量的形式，可以用初等积分法求解，进而 $x, y$ 也可解出。\
      $x < 0$ 的情形是完全同理的


