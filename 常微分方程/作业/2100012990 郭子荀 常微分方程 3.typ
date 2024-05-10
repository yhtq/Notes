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
应交时间为 4月3日
#set heading(numbering: none)
= 3.18
  == p85
    === 1
      #let phi = math.phi.alt
      设 $Phi(x) = integral_a^t chi(s) phi(s) dif s$，则有：
      $
      Phi' = chi phi <= chi psi + chi Phi
      $
      令 $h(x) = e^(integral_(a)^(x) chi(s) dif s), Phi = u h$，则：
      $
      u' h + u h' &<= chi psi + chi u h\
      u' h &<= chi psi quad (u h' = chi u h)\
      u'  &<= (chi psi)/h \
      u(x) - u(a) &<= integral_(a)^(x) (chi(t) psi(t))/h(t) dif t \
      $
      其中 $Phi(a) = 0 => u(a) = 0$，因此：
      $
      u(x)  &<= integral_(a)^(x) (chi(t) psi(t))/h(t) dif t \
      Phi(x) = u(x) h(x) &<= h(x) integral_(a)^(x) (chi(t) psi(t))/h(t) dif t \
      &= e^(integral_(a)^(x) chi(t) dif t) integral_(a)^(x) chi(t) psi(t)e^(-integral_(a)^(t) chi(t) dif t) dif t\
      &= integral_(a)^(x) chi(t) psi(t)e^(integral_(a)^(x) chi(t) dif t -integral_(a)^(t) chi(t) dif t) dif t\
      &= integral_(a)^(x) chi(t) psi(t)e^(integral_(t)^(x) chi(t) dif t ) dif t\
      $
      因此：
      $
      phi(t) - psi(t) <= Phi(t) <= integral_(a)^(t) chi(s) psi(s)e^(integral_(s)^(t) chi(s) dif s ) dif s
      $
      证毕
    === 2
      由题设：
      $
      abs(phi_1 (t) - phi_2 (t)) &= abs(phi_1 (tau) - phi_2 (tau) + integral_(tau)^(t) f(s, phi_1 (s)) -f(s, phi_2 (s)) dif s + E_1 (t) - E_2 (t))\
      &<= abs(phi_1 (tau) - phi_2 (tau)) + abs(integral_(tau)^(t) f(s, phi_1 (s)) -f(s, phi_2 (s)) dif s) + abs(E_1 (t) - E_2 (t))\
      &<= delta + integral_(tau)^(t) abs(f(s, phi_1 (s)) -f(s, phi_2 (s))) dif s + E(t)\
      &<= delta + integral_(tau)^(t)  k(s) abs(phi_1 (t) - phi_2 (t)) dif s + E(t)\
      $
      取 $phi(t) = abs(phi_1 (t) - phi_2 (t)), psi(t) = delta + E(t), chi(t) = k(t)$，由习题 1 结论可得（注意到条件显然蕴含了 $k(t) >= 0$，而习题 1 的证明过程并不需要 $k(t) != 0$）：
      $
      abs(phi_1 (t) - phi_2 (t)) &<= E(t) + integral_(tau)^(t) k(s)(E(s) + delta) e^(integral_(s)^(t) k(u) dif u)  dif s\
      &= E(t) + integral_(tau)^(t) k(s)delta e^(integral_(s)^(t) k(u) dif u)  dif s + integral_(tau)^(t) k(s)E(s) e^(integral_(s)^(t) k(u) dif u)  dif s\
      &= E(t) - delta integral_(tau)^(t) dif  e^(integral_(s)^(t) k(u) dif u) + integral_(tau)^(t) k(s)E(s) e^(integral_(s)^(t) k(u) dif u)  dif s\
      &= E(t) + delta e^(integral_(tau)^(t) k(u) dif u) + integral_(tau)^(t) k(s)E(s) e^(integral_(s)^(t) k(u) dif u)  dif s\
      $
      证毕
  == p103
    === 1
      容易验证 Tonelli 序列等度连续（恒有 $y'_n (x) <= max_DD abs(f)$），一致有界（$abs(y_n (x) - y_0) <= integral_(x_0)^(x_0+h)  max_DD abs(f) dif s$），从而它有收敛子列，无妨设 $y_n (x)$ 一致收敛于 $y(x)$\
      注意到 $f$ 是紧集上连续函数，进而一致连续，从而序列 $f(x, y_n (x))$ 一致收敛于 $f(x, y(x))$，因此我们有：
      $
      y(x) - y_0 - integral_(x_0)^(x) f(s, y(s)) dif s = lim_(n->infinity) (y_n (x) - y_0 - integral_(x_0)^(x) f(s, y_n (s)) dif s) 
      $
      只需验证对于每个 $x$ 上式右侧极限为零，进而 $y(x)$ 就是原方程的解。\
      $x = x_0$ 时显然成立，否则由于可将 $n$ 取充分大，不妨设 $x > x_0 + 1/n = x_1$，计算：
        $
        abs(y_n (x) - y_0 - integral_(x_0)^(x) f(s, y_n (s)) dif s) &= abs(integral_(x_0)^(x - d_n) f(s, y_n (s)) dif s - integral_(x_0)^(x) f(s, y_n (s)) dif s)\
        &= abs(integral_(x - d_n)^(x) f(s, y_n (s)) dif s)\
        &<= integral_(x - d_n)^(x) abs(f(s, y_n (s))) dif s\
        &<= h/n max_(DD) f\
        $
        显然 $n -> +infinity$ 时上式 $-> 0$ ，因此结论自然成立

      假设 $f$ Lipschitz 连续，已经证明了原方程的解唯一。上面的证明事实上表示所有一致收敛的子列的极限都是原方程的解，换言之 Tonelli 所有一致收敛子列有公共的极限，进而当然一致收敛。
    === 2
      考虑欧拉折线 $phi_n (x)$ 的值：
      + 第一个区间 $[0, 1/n]$ 上由于 $y(0) = 0, f(0, 0) = 0$，因此 $phi_n (x) = 0$
      + 第二个区间上，有：
        $
        phi_n (1/n) = 0\
        f(1/n, 0) = 1/n cos (n pi)
        $
        因此：
        $
        forall t in [0, 1/n]:\ phi(1/n + t) = cases(
          t/n quad n = 0 mod 2,
          -t/n quad n = 1 mod 2
        )
        $
      + 由对称性，我们可以只证明 $n$ 为偶数情形，证明过程中同时给出 $phi_n (x) !=0 , x >= 1/n$ ，因此奇数情形是完全对称的
        - 这里 $phi_n (1/n) = 0, alpha(1/n) > 0$，结论已经错误不知是否写错了
        - 注意到 $phi_n (2/n) = 1/n^2$，而：
          $
          alpha(2/n) -1/n^2 &= integral_0^(2/n) e^(-1/s^2) dif s - 1/n^2
          // &= integral_(n/2)^(infinity) t^2 e^(-t^2) dif t\
          // &= - 1/2 integral_(n/2)^(infinity) t dif e^(-t^2)\
          // &= n/4 e^(-n^2/4) + 1/2 integral_(n/2)^(infinity) e^(-t^2) dif t \
          // &<=  n/4 e^(-n^2/4) + 1/n integral_(n/2)^(infinity) t e^(-t^2) dif t \
          // &<=  n/4 e^(-n^2/4) - 1/(2n )integral_(n/2)^(infinity)  dif e^(-t^2) \
          // &<=  n/4 e^(-n^2/4) + 1/(2 n) e^(-n^2/4) \
          $
          设 $f(t) = integral_0^(2/t) e^(-1/s^2) dif s - 1/t^2$:
          //至少当 $n$ 足够大时上式 $< 1/n^2$
          $
          f'(t) = -(2 e^(-t^2/4) )/t^2+ 2/t^3 = 2/t^3(1 - t e^(-t^2/4)) > 0, forall t > 1
          $
          同时，不难验证 $f(t) -> 0, t -> +infinity$，进而恒有 $f(t) < 0$
        - 若 $y_k > alpha(x_k)$，则下一段中 $phi_n (x)$ 的斜率将为 $x_k = k/n$，但：
          $
          alpha'(x) = e^(-1/x^2) <= e^(-1/(x_k + 1/n)^2)
          $
          设 $g(t) = t -e^(-1/(t+ 1/n)^2)$，则：
          - 
            $
            g(1/n) = 1/n - e^(-1/(1/n+ 1/n)^2) = 1/n - e^(-n^2/4) = e^(-n^2/4)/n (e^(n^2/4) - n) > 0
            $
          - $
            g' = 1 - 2/(t + 1/n)^3  e^(-1/(t+ 1/n)^2) = e^(-1/(t+ 1/n)^2)/(t + 1/n)^3 (e^(1/(t+ 1/n)^2)(t + 1/n)^3 - 2) > 0
            $
          从而 $g(t) > 0, forall t in [1/n, 1]$，表明 $phi_n (x)$ 的斜率将大于 $alpha(x)$，进而在其上方
        - 对 $k$ 归纳可得结论成立
= 3.20
  == p96
    === 1
      $
      y_0 (x) &= y_0\
      y_1 (x) &= y_0 + integral_(x_0)^(x) f(s, y_0 (s)) dif s = y_0 + integral_(x_0)^(x) s - y_0^2 dif s\
      &= y_0 + 1/2 (x^2 - x_0^2) - (x - x_0) y_0^2\
      y_2 (x) &= y_0 + integral_(x_0)^(x) f(s, y_1 (s)) dif s = y_0 + integral_(x_0)^(x) s - y_1^2 dif s\
      &= y_0 + integral_(x_0)^(x) s - (y_0 + 1/2 (s^2 - x_0^2) - (s - x_0) y_0^2)^2 dif s\
      &= y_0  -1/60 (x - x_0) (3 x^4 + 3 x_0 x^3 - 15 x^3 y_0^2 - 7 x^2 x_0^2 + 5 x_0 x^2 y_0^2 + 20 x^2 y_0^4 + 20 y_0 x^2 - 7 x x_0^3 + 35 x x_0^2 y_0^2 -\ &40 x x_0 y_0^4 + 20 x x_0 y_0 - 60 x y_0^3 - 30 x + 8 x_0^4 - 25 x_0^3 y_0^2 + 20 x_0^2 y_0^4 - 40 y_0 x_0^2 + 60 x_0 y_0^3 - 30 x_0 + 60 y_0^2)\
      $
    === 2
      $
      y_0 (x) &= 0\
      y_1 (x) &= integral_(0)^(x) s + y_0 (x) + 1 dif s\
      &=  integral_(0)^(x) s + 1 dif s\
      &= 1/2 x^2 + x\
      y_2 (x) &= integral_(0)^(x) s + 1/2 s^2 + s +1 dif s\
      &= 1/6 x^3 + x^2 + x
      $
      设：
      $
      r_n (x) = y_n (x) - sum_(i=1)^(n+1) 1/(i!) x^(i)
      $
      则：
      $
      r_(n+1) (x) = integral_(0)^(s) sum_(i=1)^(n+1) 1/(i!) s^(i) + r_n (s) + s + 1 dif s  -sum_(i=1)^(n+2) 1/(i!) x^(i)\
      = integral_(0)^(x) r_n (s) + s  dif s \
      r_(n+1) (x) + x+1 - e^(x) = integral_(0)^(x) r_n (s) + s +1 - e^(s)  dif s 
      $
      再令 $t_n (x) = r_(n+1) (x) + x+1 - e^(x)$，将有：
      $
      t_n (x) = integral_(0)^(x) t_(n-1) (s) dif s
      $
      $t_n (x)$ 的一致收敛性由定理是显然的，因此上式给出 $t_n (x) -> A e^x $，因此：
      $
      r_n (x) -> A' e^x - x - 1 \
      y_n (x) -> A'' e^x - x - 2
      $
      代入 $y(0) = 0$ 知 $y_n (x) -> 2 e^x - x - 2$，这就是原方程的解
    === 3
      限制 $abs(x - x_0) <= h$ ，按照同样的方式可以递归定义：
      $
      y_0 (x) = y_0\
      y_n (x) = y_0 + integral_(x_0)^(x) f(s, y_(n-1) (s)) dif s
      $
      计算：
      $
      abs(y_n (x) - y_(n-1) (x)) = abs(integral_(x_0)^(x) f(s, y_(n-1) (s)) - f(s, y_(n-2) (s))dif s)\
      <= integral_(x_0)^(x) abs(f(s, y_(n-1) (s)) - f(s, y_(n-2) (s))) dif s\
      <=  integral_(x_0)^(x) k(s) abs(y_(n-1) (s) - y_(n-2) (s)) dif s\
      <= integral_(x_0)^(x) k(s) dif s  integral_(x_0)^(x) abs(y_(n-1) (s) - y_(n-2) (s)) dif s
      $
      最后一步利用了柯西不等式\
      之后用完全一样的技术可以证明 $y_n (x)$ 一致收敛于原方程的解
    == 4
      需要证明：
      $
      T(h) = y_0 + integral_(x_0)^(x) f(s, h(s)) dif s
      $
      在 $L^infinity$ 空间中是压缩映射，为此计算：
      $
      norm(T(h) - T(g)) = norm(integral_(x_0)^(x) f(s, h(s)) - f(s, g(s)) dif s)\
      <= integral_(x_0)^(x) norm(f(t, h(t)) - f(t, g(t))) dif s\
      <= L norm(h(t) - g(t)) abs(x - x_0)\
      $
      为了使其为压缩映射，需要进一步缩小 $x$ 区间使得 $abs(x - x_0) L < 1$，此时当然成立压缩映射
    == 5
      构造和原定理类似，注意到：
        $
        y_n (x) - y_(n-1) (x) = integral_(x)^(0) f(s, y_(n-1) (s)) - f(s, y_(n-2) (s)) dif s 
        $
        由题设，将有 $y_n (x) - y_(n-1) (x)$ 与 $y_(n-1) (x) - y_(n-2) (x)$ 同号，而条件说明了:
        $
        y_1 (x) = integral_(0)^(x) f(s, 0) dif s >= 0 = y_0 (x)
        $
        因此对于每个 $x$，序列 $y_n (x)$ 是单调递增的，同时有上界，进而有极限。设 $y(x)$ 为其极限，由 Dini 定理，只需要验证 $y(x)$ 连续即可给出一致收敛性\
        事实上，显有：
        $
        abs(y(x_1) - y(x_2)) = lim_(n->infinity) abs(y_n (x_1) - y_n (x_2)) <= lim_(n->infinity) integral_(x_1)^(x_2) abs(f(s, y_(n-1) (s))) dif s\
        <= abs(x_2 - x_1) M
        $
        当然有极限函数连续，因此序列一致收敛
  == p110
    === 2
      首先容易验证它满足局部 Lipschitz 条件，因此至少在每点附近都有解，而解总可以延拓到有界闭区域的边界。\
      取定 $x_0, y_0$ 及过该点的解 $y(x)$，假设它不能延拓到无穷区间，则一定有垂直渐近线 $x = x_1$\
      在渐近线左侧，有：
      $
      y' = x^3 - y^3 <= x_1^3 - y^3
      $
      取 $I = [x_1 - delta, x_1]$，显然 $y(x)$ 在区间内的极值点满足：
      $
      y' = 0 => y = x => y in I
      $<maximum>
      注意到由延拓定理，一定有 $y(x)$ 在 $x_1$ 附近无界，无妨设其无上界，则：
      $
      h(t) = max_(x in [x_1 -delta, t]) y(x)
      $
      关于 $t$ 单调递增趋于无穷，不妨设当 $t > t_1$ 时 $h(t) > x_1, h(t) > y(x_1 - delta)$，此时@maximum 给出最大值只能在区间边界处取得，进一步只能在右端点取得，因此：
      $
      h(t) = y(t) > x_1, forall t > t_1
      $
      然而观察原式可得：
      $
      y' = x^3 - y^3 <= x_1^3 - y^3 <= 0, forall x > t_1
      $
      换言之，$y(x)$ 将在 $(t_1, x_1)$ 单调递减，与其无上界矛盾！\
      证毕
    === 4
      记 $y(x) = phi.alt(x, xi)$，则它是原方程的解且 $y(0) = xi$\
      由于 $f$ 是开区域 $0 < x < a, - infinity < y < =infinity$ 上的连续函数，微分方程的解可以延拓到该开区域内任何有界闭区域的边界。
      - 若 $lim_(x -> overline(x)-0) y(x)$ 存在且有限，自然定义 $y(overline(x)) = lim_(x -> overline(x)-0) y(x)$仍然连续。为了证明新的 $y$ 还是原方程的解，只需验证他在 $overline(x)$ 处的左导数即可。\
        然而注意到：
        $
        y'(x) = f(x, y(x))， forall x in [0, overline(a))\
        => lim_(x -> overline(x)-0) y'(x) = f(overline(x), lim_(x -> overline(x)-0) y(x)) = f(overline(x), y(overline(x)))
        $
        上式左侧是导数的左极限，它恰为 $overline(x)$ 处的左导数，因此延拓的 $y$ 确实还是原方程的解
      - 另一方面，解可以延拓到 $overline(x)$ 当然蕴含着 $lim_(x -> overline(x)-0) y(x)$ 存在且有限，因此下设 $y(x)$ 在 $(0, overline(x))$ 上无界。无妨设其无上界，只需证明：
        $
        lim_(x -> overline(x)-0) y(x) = +infinity
        $
        （另一种情况是类似的）\
        如若不然，设 $l = liminf_(x -> overline(x)-0) y(x) < +infinity$，再取 $l_1 > l_2 > l$，递归定义：
        - 在 $(0, overline(x))$ 上任取 $u_0$ 使得 $y(u_0) = l_1$（由下极限定义和介值定理保证）
        - 取 $v_1 = inf {x in [u_1, overline(x)) | y(x) = l_2}$\
          这里下极限定义和介值定理保证右边集合非空，而该集合作为连续函数在闭集上的逆像仍是（相对于 $[u_1, overline(x))$ 的）闭集，进而有 $y(v_1) = l_2$ 并且显有 $v_1 > u_1$
        - 再取 $u_2 = inf {x in [v_1, overline(x)) | y(x) = l_1}$
        - ...
        - 以此类推，取得
          $
          u_i, v_i space s.t. space y(u_i) = l_1, y(v_i) = l_2
          $
        - 更进一步，有 $u_i, v_i -> overline(x)$，这是因为由定义知任取 $u_i, v_i$ 单调上升有上界，并且两数列互相控制，因此有相同的极限 $xi$，同时 $lim_(x -> xi) y(x)$ 不存在，因此只能有 $xi = overline(x)$
        $
        f(theta_i, y(theta_i)) = y'(theta_i) = (y(v_i) - y(u_i))/(v_i - u_i) = (l_2 - l_1)/(v_i - u_i),theta_i in [v_i, u_i]
        $
        同时由定义过程可以看出：
        $
        forall x in [v_i, u_i], y(x) in [l_1, l_2] => y(theta_i) in [l_1, l_2]
        $
        - 等式左侧 $f(theta_i, y(theta_i)) in f([0, a] times [l_1, l_2])$，由连续性右侧是有界集合，因此左侧有公共上界\
        - 等式右侧由 $u_i - v_i -> 0$ 显然无界
        矛盾！
      -  综上，原结论成立
    === 5
      如若不然，假设 $y(x)$ 只在 $[0, a)$ 上都是原方程的解，由上题结论不妨设：
      $
      lim_(x -> a-0) y(x) = +infinity
      $
      不妨取 $b$ 使得 $forall x in [b, a), y(x) > 0$，我们有：
      $
      abs(y') = abs(f(x, y)) <= psi(abs(y))\
      abs(y')/(psi(abs(y))) <= 1\
      integral_(b)^(s) abs(y')/(psi(y)) dif x <= s- b\
      integral_(b)^(s) y'/(psi(y)) dif x <= integral_(0)^(s) abs(y')/(psi(abs(y))) dif x <= s - b\
      integral_(y(0))^(y(s)) 1/(psi(t)) dif t <= s - b\
      $ 
      然而当 $s -> a-0$ 时，上式左侧有界而右侧无界，矛盾！
= 3.25
  == p120
    === 1
      #lemmaLinear[][
        设 $g_1, g_2$ 在区间 $I$ 上均满足 $g'_i (x) = f(x, g_i (x))$，则 $max(g_1, g_2), min(g_1, g_2)$ 也满足
      ]
      #proof[
        只证 $max$，$min$ 类似\
        设 $h = max(g_1, g_2)$，验证上面的等式只需逐点验证即可：
        - 任取 $x in I$，讨论：
          - 若 $g_1(x) > g_2(x)$，则有 $g_1, g_2$ 连续性知存在 $x$ 的开邻域 $B$ 使得：
            $
            h|_B = g_1
            $
            此时由于 $g_1$ 在该点是微分方程的解，$h$ 当然也是
          - 若 $g_1(x) < g_2(x)$，同理
          - 若 $g_1(x) = g_2(x)$，注意到：
            $
            g'_1(x) = f(x, g_1(x)) = f(x, g_2(x)) = g'_2(x) := d
            $
            因此：
            $
            abs((h(x + Delta x) - h(x))/(Delta x) - d) &<= abs((h(x + Delta x) - g_1 (x + Delta x))/(Delta x)) + abs((g_1 (x + Delta x) - g_1 (x))/(Delta x) - g'_1 (x))\
            &<= abs((g_2(x + Delta x) - g_1 (x + Delta x))/(Delta x)) + abs((g_1 (x + Delta x) - g_1 (x))/(Delta x) - g'_1 (x))\
            &<= abs(((g_2(x + Delta x) - g_1 (x + Delta x)) - (g_2 (x) - g_1 (x)))/(Delta x)) + abs((g_1 (x + Delta x) - g_1 (x))/(Delta x) - g'_1 (x))\
            &<= abs(g'_2 (xi) - g'_1 (xi)) + abs((g_1 (x + Delta x) - g_1 (x))/(Delta x) - g'_1 (x))\
            &"（对" g_2(x) - g_1(x) 在 x, x + Delta x "上利用微分中值定理）"
            $
            其中 $xi$ 在 $x, x + Delta x$ 之间。注意到由微分方程，$g_1, g_2$ 当然连续可导，进而当 $Delta x -> 0$ 时上式 $-> 0$，这就保证了：
            $
            h'(x) = d = f(x, h(x))
            $
            也即 $h$ 在该点满足微分方程
        得证   
      ]
      考虑微分方程：
      $
      cases(
        y' = f(x, y) ,
        y(x_1) = y_1
      )
      $
      它在 $x_1$ 的某个邻域内有解 $h$，又可不妨设 $h$ 在 $I$ 内某个极大的区间 $I_1$（也即所有可延拓闭区间的并）上是原方程的解，并设：
      $
      h_1 = max(min(h, Z), W), x in I_1
      $
      将满足 $h'_1 (x) = f(x, h_1 (x))$，同时也不难验证 $h_1(x_1) = y_1$，因此是过该点的微分方程的解\
      另一方面，显然有：
      $
      max(min(h, Z), W) >= W\
      max(min(h, Z), W) <= max(Z, W) = Z
      $
      因此 $h_1$ 是区间上有界的微分方程的解
      从而：
      - 若 $x_0 in I_1$，由上面的条件和引理知 $h_1$ 就是要找的解
      - 否则，设 $I_1$ 闭包中距 $x_0$ 最近的点为 $x_2$，注意到 $h_1$ 在 $I_1$ 上有界，因此由延拓定理要么意味着存在 $x'$ 使得 $abs(h_1(x') - y_0) = b$，要么 $h_1$ 一定可以至少延拓到 $x_2 := x'$，然而已经假设 $h$ 不能再延拓，因此该点附近一定取 $Z$ 或 $W$ ，无论如何一定有：
        $
        exists x', h_1(x') = Z(x') 或 W(x')
        $
        无论何者，都意味着 $h_1$ 可以与 $Z$ 或 $W$ 的其中之一拼接起来，这就是所要找的解。
    === 2
      存在唯一性是容易的。对于存在区间，只证明第一个方程\
        显然它的解单调递减，若解的存在区间不是 $(a, b)$ ，则必然在某点 $x_0 in (a, b)$ 处的左/右极限为 $+\/minus infinity$，不妨设为左极限为负无穷\
        这意味着存在 $delta, (x_0 - delta, delta)$ 上时有：
        $
        exists M_1, M_2,  der(y, x) = -A(x) abs(y) - B(x) = A(x) y - B(x) > M_1 y + M_2
        $
        但稍加计算可得 $der(y, x) = M_1 y + M_2$ 的解不可能在有界区间内趋于无穷，进而该方程的解由比较定理被控制在有界区间，矛盾！

      
