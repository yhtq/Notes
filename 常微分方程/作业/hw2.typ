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
应交时间为 3月20日
#set heading(numbering: none)
= P32
  == 1
    === (3)
      $
      (x y + e^x) dif x - x dif y = 0\
      (y + e^x/x) dif x -  dif y = 0\
      y' = y + e^x / x
      $
      这是一阶线性微分方程，先解对应的齐次线性微分方程
      $
      y' = y => y = C e^x
      $
      进而可设 $y = u e^x, u = y e^(-x)$，代入得：
      $
      (u e^x)' = u e^x + e^x / x\
      e^x u' + e^x u = u e^x + e^x / x\
      u'  = 1 / x\
      u = ln|x| + C\
      y = (ln|x| + C) e^x\
      $
    === (5)
      $
      (1 - 2 x y) dif y - y (y-1) dif x= 0
      $
      猜测积分因子应形如 $f(y)$，需要满足：
      $
      -2y f(y) + partialDer(f(y) y (y-1), y) = 0\
      partialDer(f(y) y (y-1), y) = 2y f(y)\
      f'(y) y (y-1) + f(y) (y-1) + f(y) y = 2y f(y)\
      f'(y) y(y-1) = f(y)\
      ln |f(y)| = integral 1/(y(y-1)) dif y = integral (1/(y-1) - 1/y) dif y = ln |(y-1)/y|\
      $
      可取 $f(y) = (y-1)/y$，排除 $y = 0$ 是原方程的解，可得：
      $
      (y-1)/y (1-2x y) dif y - (y-1)^2 dif x = 0\
      ((y-1)/y - 2x (y-1)) dif y - (y-1)^2 dif x = 0\
      (y-1)/y dif y - (2x (y-1) dif y + (y-1)^2 dif x) = 0\
      (y-1)/y dif y - dif (x(y-1)^2) = 0\
      dif (integral 1 - 1/y dif y) - dif (x(y-1)^2) = 0\
      dif (y - ln |y|) - dif (x(y-1)^2) = 0\
      y - ln |y| = x(y-1)^2 + C\
      $
      从解的形式来看除去 $y = 0$ 的解外，其他解中 $y$ 的符号不会改变，因此上式中绝对值恒取正或取负
  == 2
    这是一阶线性微分方程，先解对应的齐次线性微分方程：
    $
    y' = 2/(sin 2x) y\
    1/y dif y = 2/(sin 2x) dif x\
    ln |y| = integral 2/(sin 2x) dif x = integral 1/(sin x cos x) dif x = integral 1/(sin x cos^2 x) dif (sin x)\
    = integral 1/(sin x (1 - sin^2 x)) dif (sin x) \
    = integral 1/(t (1 - t^2)) dif t\
    = integral 1/(2 t^2 (1 - t^2)) dif t^2\
    = 1/2 integral 1/t^2 + 1/(1-t^2) dif t^2\
    = 1/2 ln t^2/(1-t^2)\
    = 1/2 ln tan^2 x\
    = ln |tan x|\
    $
    可设 $y = u tan x$，从而：
    $
    y' sin 2x = 2 u' sin^2 x + 2 u tan x = 2 u tan x + 2cos x\
    u' sin^2 x = cos x\
    u' = (cos x)/(sin^2 x)\
    u = integral (cos x)/(sin^2 x) dif x = integral 1/(sin^2 x) dif (sin x) = -1/(sin x) + C\
    y = u tan x = -1/(cos x) + C tan x = (C sin x - 1)/(cos x)
    $
    显然 $x -> pi/2$ 时 $y$ 有界除非 $C sin x - 1 -> 0$，也即 $C = 1$，而此时：
    $
    (sin x - 1)/(cos x) =^(t = pi/2 - x)_(t -> 0) (cos t - 1)/(sin t) ~ - (1/2 t^2)/t -> 0 
    $
    因此确实有界
  == 3
    这是一阶线性微分方程，先解对应的齐次线性微分方程：
    $
    x y' = - a y\
    1/y dif y = - a/x dif x\
    ln |y| = - a ln |x| + C\
    y = A |x|^(-a)\
    $
    不妨先设 $x > 0$\
    此时设 $y = u x^(-a)$，代入得：
    $
    x (u x^(-a))' + a u x^(-a) = f(x)\
    x (u' x^(-a) - a u x^(-a-1)) + a u x^(-a) = f(x)\
    x u' x^(-a) - a u x^(-a) + a u x^(-a) = f(x)\
    x u' x^(-a) = f(x)\
    u'  = x^(a-1) f(x)\
    u = integral x^(a-1) f(x) dif x+ C\
    y = 1/x^a (integral x^(a-1) f(x) dif x+ C)\
    $
    注意到反常积分 $integral_(0)^1 t^(a-1) dif t$ 绝对收敛，而 $f(x)$ 在 $0$ 附近收敛从而有界，因此反常积分 $integral_0^x t^(a-1) f(t) dif t$ 对于任何 $x$ 都存在，因此可设原方程的解为：
    $
    y = 1/(x^a)(F(x) + C)
    $
    其中 $F(x) = integral_0^x t^(a-1) f(t) dif t$，断言：
    - $lim_(x ->0^+) F(x) = 0$\
      // 使用积分中值定理，注意到 $t^(a-1)$ 在 $(0, x)$ 上保持定号，从而 $forall x > 0, exists eta in (0, x]$ 使得：
      // $
      // F(x) = integral_0^x t^(a-1) f(t) dif t = f(eta_x) integral_0^x t^(a-1) dif t = f(eta_x) x^a / a
      // $
      // 从而令 $x -> 0$ 显然原式 $-> b/a$
      由反常积分存在的柯西条件这是显然的
    - $lim_(x -> 0^+) F(x)/x^a = b/a$\
      又注意到 $F(x)$ 在 $(0, 1)$ 可导，可以使用洛必达法则：
      $
      lim_(x -> 0^+) F(x)/x^a = lim_(x -> 0^+) (x^(a-1) f(x))/(a x^(a-1)) = b/a
      $
    这就说明 $C = 0$ 时，$y$ 在 $x -> 0^+$ 时有界。而对其他的 $C$ 显然无界。$x ->0^-$ 的讨论是类似的，因此原结论成立
  == 4
    这是一阶线性微分方程，先解对应的齐次线性微分方程：
    $
    y' = 2y cos^2 x\
    1/y dif y = 2 cos^2 x dif x\
    ln |y| = 2 integral cos^2 x dif x = integral (1 + cos 2x) dif x = x + 1/2 sin 2x + C\
    y = A e^(x + 1/2 sin 2x)\
    $
    因此可设 $y = u e^(x + 1/2 sin 2x)$，进而有：
    $
    y' = u' e^(x + 1/2 sin 2x) + u e^(x + 1/2 sin 2x) (1 + cos 2x) = 2 u e^(x + 1/2 sin 2x) cos^2 x- sin x\
    u' e^(x + 1/2 sin 2x) = - sin x\
    u' = - e^(-x - 1/2 sin 2x) sin x\
    u = - integral e^(-x - 1/2 sin 2x) sin x dif x \
    = integral_0^x e^(-t - 1/2 sin 2t) sin t dif t + C\
    $<allSolution>
    假设 $y$ 有周期 $T$，断言:
    - $2 pi$ 也是 $y$ 的周期\
      事实上，不难发现：
      $
      y'(x+T) = 2 y(x+T) cos^2 (x + T) - sin (x + T)
      $
      但 $y'(x+T) = y'(x), y(x+T) = y(x)$，因此：
      $
      2 y cos^2 (x+T) - sin (x+T) = 2 y cos^2 x - sin x\
      $
      仅考虑 $x in [0, 2pi]$，假设 $2 pi $ 不是 $y$ 的周期，则 $cos^2 (x+T) != cos^2(x)$ 对于除有限个的 $x$ 外都成立，进而在任意一个前式不成立的开区间中：
      $
      y = (sin (x+T) - sin x)/(cos^2 (x+T) - cos^2 x)
      $
      但该函数以 $2pi$ 为周期，矛盾！
    因此为了让 $y$ 是周期函数，只需让 $g(x) := u e^x = e^x (integral_0^x e^(-t - 1/2 sin 2t) sin t dif t + C)$ 是周期函数即可
    - 为此，我们当然需要 $g(0) = g(2 pi)$，也即：
      $
      C = e^(2pi) (integral_0^(2pi) e^(-t - 1/2 sin 2t) sin t dif t + C)
      $
      这就可反解出唯一符合条件的 $C_0$ 满足：
      $
      C_0 = (integral_0^(2pi) e^(-t - 1/2 sin 2t) sin t dif t)/(1 - e^(2pi))
      $<cCond>
    - 其次。我们验证这个 $C_0$ 对应的解确实周期。为此，设 $g(x)$ 就是该 $C_0$ 对应的解，我们反过来验证将 $y = e^(1/2 sin 2x) g(x)$ 于 $[0, 2pi]$ 间的图像以 $2pi$ 周期做延拓后是原方程的解，进而由于@allSolution 给出了原方程的所有解，我们延拓出的函数只能是 $y = e^(1/2 sin 2x) g(x)$ 本身\
      依次验证：
      - $y(0) = y(2pi)$\
        之前已经保证成立
      - $y'_+(0) = y'_-(2pi)$，进而保证延拓是光滑的\
        注意到 $y$ 在 $[0, 2pi]$ 内是微分方程：
          $
          y' = 2y cos^2 x - sin x
          $
          的解，进而由 $y(0) = y(2pi)$ 及 $sin x, cos^2 x$ 以 $2pi$ 为周期知该性质同样成立
      - 延拓得到的函数在 $x +2 k pi$ 处满足微分方程，也即：
        $
        y'(x +2  k pi) = 2 y(x + 2 k pi) cos^2 (x + 2 k pi) - sin (x + 2 k pi)
        $
        同样由 $sin x, cos x$ 的周期性知显然成立
    - 综上，这个 $C_0$ 对应的解就是原方程唯一一个周期解：
      $
      y = e^(x + 1/2 sin 2x)(integral_0^x e^(-t - 1/2 sin 2t) sin t dif t + C_0)
      $
      其中 $C_0$ 已由@cCond 给出
  == 5
    这是一阶线性微分方程，先解对应的齐次线性微分方程：
    $
    x' + x = 0\
    x = A e^(-x)
    $
    设 $x = u e^(-t)$，进而有：
    $
    u' e^(-t) - u e^(-t) + u e^(-t) = f(t)\
    u' = f(t) e^t\
    u = integral_(-infinity)^t f(s) e^s dif s + C\
    x = e^(-t) (integral_(-infinity)^t f(s) e^s dif s + C)
    $
    （由于 $f$ 有界，反常积分存在）\
    对应任意 $M_1$, $-M_1 <= x <= M_1$ 当且仅当 $forall t in RR$：
    $
    -M_1 e^x <= integral_(-infinity)^t f(s) e^s dif s + C <= M_1 e^x\
    - M_1 e^x - integral_(-infinity)^t f(s) e^s dif s <= C <= M_1 e^x - integral_(-infinity)^t f(s) e^s dif s\
    integral_(-infinity)^t (-f(s) - M_1) e^s dif s <= C <= integral_(-infinity)^t (- f(s) + M_1) e^s dif s\
    $
    注意到上式两端当 $t ->- infinity$ 时均 $-> 0$，因此 $C$ 的唯一可能取值为 $0$

    进一步，只需证明 $C = 0$ 时，$x = e^(-t) integral_(-infinity)^t f(s) e^s dif s $ 确实有界，显然有：
    $
    - e^(-t) integral_(-infinity)^t M e^s dif s <= e^(-t) integral_(-infinity)^t f(s) e^s dif s <= e^(-t) integral_(-infinity)^t M e^s dif s \
    -M <= x <= M
    $
    证毕

    当 $f$ 是周期函数时，显然它是有界函数，因此唯一可能的周期解就是这个有界解。为了证明它是周期解，只需仿照上一题的思路，设 $T$ 是 $f(t)$ 的周期，验证：
    - $x(0) = x(T)$，也即：
      $
      integral_(-infinity)^0 f(s) e^s dif s = e^(-T)integral_(-infinity)^T f(s) e^s dif s\
      arrow.l.double integral_(-infinity)^0 f(s) e^s dif s = e^(-T)integral_(-infinity)^T f(s + T) e^(s +T) dif (s + T)\
      arrow.l.double integral_(-infinity)^0 f(s) e^s dif s = e^(-T)integral_(-infinity)^0 f(s) e^(s +T) dif s
      $
      显然成立
    - 其余步骤，包括 $x'(0) = x'(T)$，延拓之后的函数确实是微分方程的解与上题类似，因此 $x = e^(-t) integral_(-infinity)^t f(s) e^s dif s $ 确实是周期解
  == 6
    不妨设 $x > 0$\
    先解对应齐次方程：
    $
    x y' = (2x^2 + 1)y\
    1/y dif y = (2x^2 + 1)/x dif x\
    ln |y| = integral (2x^2 + 1)/x dif x = integral (2x + 1/x) dif x = x^2 + ln x + C\
    y = A x e^(x^2)
    $
    设 $y = u x e^(x^2)$ 代入原方程：
    $
    x(u' x e^(x^2) + e^(x^2) u + 2x^2 u e^(x^2)) = (2x^2 + 1) u x e^(x^2) + x^2\
    u' x^2 e^(x^2) = x^2\
    u' = e^(-x^2)\
    u = integral_0^x e^(-t^2) dif t + C\
    y= x e^(x^2) (integral_0^x e^(-t^2) dif t + C)
    $
    显然假如 $x -> + infinity$ 时 $y$ 有极限，当然有:
    $
    integral_0^x e^(-t^2) dif t + C -> 0 => C = - integral_0^(+infinity) e^(-t^2) dif t = -sqrt(pi)/2
    $
    只需验证极限：
    $
    lim_(x -> + infinity) x e^(x^2) (integral_0^x e^(-t^2) dif t - integral_0^(+infinity) e^(-t^2) dif t) \
    = - lim_(x -> + infinity) x e^(x^2) integral_x^(+infinity) e^(-t^2) dif t\
    $
    存在，使用洛必达法则：
    $
    lim_(x -> + infinity) x e^(x^2) integral_x^(+infinity) -e^(-t^2) dif t = lim_(x -> + infinity) e^(-x^2)/(1/(x e^(x^2)))'\
    = lim_(x -> + infinity)  e^(-x^2)/((e^(x^2) + 2x^2 e^(x^2))/(x^2 e^(2x^2))) \
    = lim_(x -> + infinity) x^2/(2x^2 + 1) = 1/2 \
    
    $
    得证，该解为：
    $
    y = x e^(x^2) (integral_0^x e^(-t^2) dif t - sqrt(pi)/2)
    $
  == 7
    设 $g(x) = f(x) + f'(x)$，则 $f(x)$ 当然就是微分方程：
    $
    y' + y = g(x)
    $
    的有界解，其中 $| g(x) | <= 1$\
    第五题证明了这样的解是唯一的，且证明过程中已经给出了这样的解满足：
    $
    |f(x)| <= M = 1
    $
    证毕
= P46
  == 1
    === (1)
      对 $x$ 求导并设 $P = y'$ 得：
      $
      24 P^2 P' = 27 P
      $
      此时：
      - $P = 0$  
      - 或 
        $
        24 P P' = 27\
        8 P dif P = 9 dif x\
        4 P^2 = 9 x + C\
        x = 4/9 P^2 + C'
        $
        结合 $y = 8/27 P^3$ 就给出了解的参数方程
      原方程的解为以上两种之一或两种的拼接，也即：
      $
      cases(
        x = 4/9 P^2 + C',
        y = 8/27 P^3
      )(x > C')\
      y = 0 (x <= C')
      $
    === (3)
      $
      y'^2 + x y = y^2 + x y'\
      x(y - y') = y^2-y'^2
      $
      此时：
      - $y = y' => y = A e^x$
      - 或 $x = y + y'$，设 $y = u e^(-x)$，有：
        $
        x = u e^(-x) + u' e^(-x) - u e^(-x)\
        x = u' e^(-x)\
        u' = x e^x\
        u = (x - 1) e^x + C\
        y = x - 1 + C e^(-x)
        $
      方程的解为两者之一或者两者的拼接，连接点 $x_0$ 应满足：
      $
      cases(
        A e^(x_0) = x_0-1 + C e^(-x_0),
        A e^(x_0) = 1 - C e^(-x_0)
      )
      $
      也可能发生多段拼接
    === (5)
      设 $P^2 = y', P >= 0$，原式变为：
      $
      y = 4 P - P^2 x
      $
      对 $x$ 求导：
      $
      P^2 = 4 P' - 2 P P' x - P^2\
      P^2 = 2 P' - P P' x\
      $
      - $P' = 0, P = 0, y = 0$ 符合上式
      - 否则看成关于 $P$ 的函数，则：
        $
        x' P^2 = 2 - P x\
        $
        这是一阶线性微分方程，先解对应的齐次线性微分方程：
        $
        x' P^2 = - P x\
        (dif x)/x = - 1/P dif P\
        ln |x| = -ln |P| + C\
        |x| = A 1/P
        $
        取 $x = u dot 1/P$，则：
        $
        (u' dot 1/P - u dot 1/P^2) P^2 = 2 - u\
        P u' = 2\
        u' = 2/P\
        u = 2 ln P + C\
        x = (2 ln P + C) / P\
        x' = (2 - 2 ln P - C)/P^2
        $
        代回得：
        $
        y &= 4 P - P^2 x \
          &= 4 P - P(2 ln P + C)\
          &= 4 P - 2 P ln P - C P\
        $
      注意到第二个解中，$y' -> 0 => P -> 0^+ => x -> - infinity$，换言之无法与第一个解拼接，因此原方程的解就是以上两种之一
  == 2
    === (1)
      设 $y' / y = e^P$，则：
      $
      2 x e^P - 1 = e^P ln (y^2 e^P)\
      2 x e^P - 1 = 2 e^P ln y + e^P P\
      2 e^P ln y = 2 x e^P - P e^P - 1\
      2 ln y = 2 x - P - e^(-P)
      $
      对 $x$ 求导：
      $
      2 y'/y = 2 - P' + P' e^(-P)\
      2 e^P = 2 - P' + P' e^(-P)\
      (e^(-P) - 1) P' = 2 e^P - 2
      $
      - $P = 0, P' = 0$，有：
        $
        ln y = x -1/2\
        y = e^(x - 1/2)
        $
        是原方程的解
      - 进行分离变量：
        $
        (e^(-P) - 1)/(2 e^P - 2) dif P = dif x\
        x = integral (e^(-P) - 1)/(2 e^P - 2) dif P \
        = - (P + e^(-P))/(2 e^P - 2)\
        y = e^x/(e^(P + e^(-P))) = e^(-(P + e^(-P))/(2 e^P - 2) - P - e^(-P)) = e^((P + e^(-P) - 2 P e^P - 2)/(2e^P - 2))
        $
    === (3)
      $
      4 y = x^2 + 2x y' - y'^2
      $
      设 $y' = P$ 并对 $x$ 求导得：
      $
      4 P = 2x + 2 P + 2x P' - 2 P P'\
      P = x + x P' - P P'\
      P' (x- P) = P - x\
      $ 
      表明:
      - $P' = -1 => P = -x + C$，此时代入得：
        $
        4 y = x^2 + 2x (-x + C) - (-x + C)^2\
        = -2 x^2 + 4 C x - C^2\
        y = -1/2 x^2+C x - C^2/4
        $
      - 或 $P = x$，代入得：
        $
        4 y = 2x^2\
        y = 1/2 x^2
        $
      原方程的解为两者之一或者它们的连接
= p79
  == 2
    设曲线为 $f(x, y) = 0$，点 $(x_0, y_0)$ 处切线为：
    $
    cases(
      x = x_0 - partialDer(f, y_0) t,
      y = y_0 + partialDer(f, x_0) t
    )
    $
    令 $x = 0$ 解得：
    $
    t = x_0/partialDer(f, y_0)\
    (x-x_0)^2 + (y-y_0)^2 = t^2 (partialDer(f, x_0)^2 + partialDer(f, y_0)^2) = x_0^2(partialDer(f, x_0)/partialDer(f, y_0))^2 + x_0^2\
    $
    条件给出：
    $
     x_0^2(partialDer(f, x_0)/partialDer(f, y_0))^2 + x_0^2 = (y_0 + x_0 partialDer(f, x_0)/partialDer(f, y_0))^2
    $
    在上式中将 $x_0, y_0$ 换成 $x, y$，得：
    $
    x^2 = y^2 + 2 y  partialDer(f, x)/partialDer(f, y)\
    (x^2 - y^2) partialDer(f, y) - 2 y partialDer(f, x) = 0\
    $
    同时有：
    $
    partialDer(f, x) dif x + partialDer(f, y) dif y = 0
    $
    两式结合即有：
    $
    2y dif y + (x^2 - y^2) dif x = 0\
    dif y^2 + (x^2 - y^2) dif x = 0
    $
    设 $u = y^2$ 则：
    $
    dif u + (x^2 - u) dif x = 0
    $
    这是一阶线性微分方程，先解：
    $
    dif u - u dif x = 0 => u = C e^x  
    $
    设 $u = v e^x$ 代回：
    $
    v e^x dif x + e^x dif v + (x^2 - v e^x) dif x = 0\
    e^x dif v + x^2 dif x = 0\
    dif v + x^2 e^(-x) dif x = 0\
    v = - integral x^2 e^(-x) dif x + C = (x^2 + 2x + 2)e^(-x) + C\
    u = (x^2 + 2x + 2)+ C e^x\
    y^2 = (x^2 + 2x + 2)+ C e^x\
    $
  == 3
    注意到 $f(x) := e^(- integral_0^x a(s) dif s)$ 是 $y' + a(x) y$ 的解，设：
    $
    phi(x) = u f(x)
    $
    则有：
    $
    u' f(x) + u f'(x) + a(x) f(x) u <= 0\
    u' f(x) <= 0\
    u' <= 0
    $
    进而 $u(x) <= u(0)$，可得：
    $
    y(0) = u(0) f(0) = u(0)\
    y(x) = u(x) f(x) <= u(0) f(x) = y(0) f(x)
    $
    得证
  == 4
    首先由等式可以看出 $y$ 是连续函数，进一步是可微函数（注意连续函数的变上限积分可微），可以两边求导得：
    $
    y' = y + 1
    $<eq>
    可得 $y$ 无穷阶可导。将 $y = y' - 1$ 代回积分，得：
    $
    integral_0^x y(t) dif t = integral_0^x (y'(t) - 1) dif t = y(x) - y(0) - x
    $
    进而：
    $
    y = y - y(0) - x + x + 1\
    y(0) = 1
    $
    回到微分方程@eq，先设 $y != -1$，有：
    $
    ln |y + 1| = x + C\
    |y + 1| = A e^x
    $
    可得绝对值定号，进而所有解为：
    $
    y = A e^x - 1
    $
    代入 $y(0) = 1$ 知：
    $
    y = 2e^x - 1
    $
  == 6
    在原式分别对 $x, y$ 求偏导得：
    $
    f(x y) y = integral_1^y f(t) dif t + y f(x)\
    f (x y) x = integral_1^x f(t) dif t + x f(y)
    $
    在1式中取 $x = 1$ 得：
    $
    f(y) y = integral_1^y f(t) dif t + y f(1)\
    (f(y) - f(1))y = integral_1^y f(t) dif t
    $
    再对 $y$ 求导：
    $
    f'(y) y + (f(y) - f(1)) = f(y)\
    f'(y) y = f(1)\
    f(y) = f(1) ln y + C\
    f(x) = f(1) ln x+ C
    $
    直接代回最初的方程：
    $
    integral_1^(x y) f(1) ln t + C dif t = f(1) (x y ln (x y) - x y + 1) + C(x y - 1)\
    x integral_1^y f(1) ln t + C dif t = f(1) (x y ln y - x y + x) + C(x y - x)\
    y integral_1^x f(1) ln t + C dif t = f(1) (x y ln x - x y + y) + C(x y - y)\
    $
    比照系数可得等式成立当且仅当：
    $
    -f(1) + C = -2 f(1) + 2 C\
    f(1) = C
    $
    因此原方程的解形如：
    $
    f(x) = C(ln x + 1)
    $
    $f(1) = 3 => C = 3 => f(x) = 3(ln x + 1)$
  == 7
    设 $y = u e^(-x)$，代入得：
    $
    u' e^(-x) - u e^(-x) + u e^(-x) - 1/(x+1) integral_0^x u e^(-x) dif x = 0\
    u' = e^x/(x+1) integral_0^x u e^(-x) dif x\
    $
    可得 $u'(0) = 0$\
    #lemma1[
      $u(x) >=1, u'(x) >=0, forall x > 0$
    ]
    #proof[
      设 $b = sup_(y in [0, +infinity]) [0, y] subset Inv(u)([1, +infinity])$，只需证明 $b = +infinity$\
      如若不然，设 $b$ 有限，此时必有 $u(b) = 1$
      + 若 $b = 0$，可设 $exists delta > 0, u([0, delta]) subset [0, 1]$，然而微分方程可以看出 $u'(x) >= 0, forall x in [0, delta]$，这表明 $u(x)$ 单调增加，继而恒有：
      $
      u(x) = 1
      $
      但代入发现不满足原方程，矛盾！
      + 若 $b > 0$，则 $u(b) = 1$，此时由中值定理，存在 $c in [0, b]$ 使得：
      $
      u'(c) = 0
      $
      然而观察原方程发现 $x in [0, b]$ 时恒有 $u >= 1 => u' > 0$ 矛盾！
    ] 
    引理即给出了 $u(x) >= 1$，进而 $f(x) >= e^(-x)$\
    令 $v = u -e^x$，代入原方程：
    $
    v' + e^x = u'  = e^x/(x+1) integral_0^x (v+e^x) e^(-x) dif x = e^x/(x+1) integral_0^x v e^(-x) dif x + x/(x+1) e^x\
    v' = e^x/(x+1) integral_0^x v e^(-x) dif x - 1/(x+1) e^x
    $
    同时注意到 $v(0) = 0, v'(0) < 0$，类似可以证明 $v(x) <= 0, forall x > 0$\
    这就给出了 $u <= e^x => f(x) <= 1$
  == 5
    由之前的讨论，单摆方程的解满足：
    $
    integral (dif y)/sqrt(2(c+a^2 cos y)) = plus.minus (x + c_1) 
    $
    不妨在上式右侧取正值，得到：
    $
    integral (dif y)/sqrt(2(c+a^2 cos y)) = x + c_1 
    $
    若取 $c = a^2$，发现：
    $
    x + c_1 = integral (dif y)/sqrt(2(a^2 + a^2 cos y)) = integral (dif y)/(a sqrt(1 + cos y))\
     = integral (dif y)/(a sqrt(2 cos^2 (y/2))) = integral (dif y)/(a cos(y/2)) = 2/(a) integral (dif (sin y/2))/(1 - sin^2 y/2) = 1/(a) ln (1 + sin y/2)/(1- sin y/2)
    $
    显然 $x -> +infinity$ 时上式右侧同样 $-> + infinity$ 当且仅当 $y -> pi$
      

      
    