#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= p247
  == 1
      不妨假设 $f$ 在 $(x_1, x_2)$ 上恒正，有：
      $
      f'(x_1) >= 0, f'(x_2) <= 0
      $
      假设 $g(x)$ 在 $(x_1, x_2)$ 上无零点，不妨设其恒正。令：
      $
      W(x) = Det(f, g;f', g') = f g' - f' g\
      W'(x) = Det(f, g;f'', g'') = Det(f, g;-p(x)f' - q(x) f, -p(x) g' - r(x) g)\
      =Det(f, g;-p(x)f', -p(x) g' - (r(x) - p(x)) g)\
      = - p(x) W(x) - f g (r(x) - p(x))
      $
      注意到一定有：
      $
      f g(r(x) - p(x)) > 0
      $
      由一阶方程的比较定理，有：
      $
      B e^(-p(x)) < W(x) < A e^(-p(x))
      $
      其中 $A e^(-p(x))$ 是：
      $
      cases(
        W'(x) = -p(x) W(x),
        W(x_1) = - g(x_1) f'(x_1)
      )
      $
      的解，而 $B e^(-p(x))$ 是：
      $
      cases(
        W'(x) = -p(x) W(x),
        W(x_1) = - g(x_2) f'(x_2)
      )
      $
      的解，然而不难发现 $- g(x_1) f'(x_1) <= 0, - g(x_2) f'(x_2) => 0$ 导致 $A <= 0, B >= 0$，这是荒谬的！
  == 2
    考虑 $y'' + m y = 0$ 的解 $sin (sqrt(m) x)$ 由比较定理： $k/(sqrt(m)) pi$ 之间一定有 $phi$ 的解，因此 $phi$ 无限振动\
    对于任何两个相邻零点 $x_1, x_2$:
    - 可以找到 $y'' + m y = 0$ 的解 $sin (sqrt(m) x - x_1)$，加强的比较定理给出 $x_2 in (x_1, x_2 + pi/sqrt(m))$
    - 可以找到 $y'' + M y = 0$ 的解 $sin (sqrt(M) x - x_1)$，加强的比较定理给出 $pi/sqrt(M) in (x_1, x_2)$
    证毕
  == 3
    注意到：
    $
    (z/y)' = (z' y - z y') / y^2\
    (z' y - z y')' = z'' y - z y'' = z q(x) y - z Q(x) y = (q(x) - Q(x)) z y < 0\
    z' y - z y'|_(x = x_0) = 0
    $
    进而 $z' y - z y' < 0$，原式单调减少
  == 7
    由线性方程组结论，设 $u$ 是满足 $y(0) = a$ 的解，$v$ 是满足 $y(0) = 0$ 的非零解，则所有 $y(0) = a$ 的解恰为：
    $
    u+ C v, forall C in RR
    $
    进而满足给定初值的解就是要：
    $
    u(1) + C v(1) = b
    $
    只要 $v(1) != 0$ 方程就恰有唯一解，而若 $v(1) = 0$，由比较定理 $y'' = 0$ 的解 $y = 1$ 一定在 $[0, 1]$ 上有零点，这是荒谬的！（类似的，该方程的解至多一个零点）

    对于第二个结论，不妨设 $a > 0$，已经说明解至多一个零点，无妨设 $phi(x)$ 在 $(0, 1)$ 上恒正，因此 $phi''$ 也恒正，导函数单调增加。然而由 $(0, 1)$ 间恒正可得 $y'(1) < 0$（不能等于零，否则整个解为零），进而函数严格单调减少。
= p258
  == 1
      - 设 $lambda = - m^2$，则 $y'' + lambda y = 0$ 的通解为：
        $
        linearCombinationC(e^(m x), e^(-m x))
        $
        代入初值：
        $
        cases(
          C_1 + C_2 = 0,
          C_1 e^m + C_2 e^(-m) = 1
        )
        $
        只要 $m != 0$ 方程一定有解。若初值为 $(0, 0)$ 则无解
      - 设 $lambda = m^2$，则 $y'' + lambda y = 0$ 的通解为：
        $
        linearCombinationC(cos m x, sin m x)
        $
        代入初值：
        $
        cases(
          C_1 = 0,
          C_1 cos m + C_2 sin m = 1
        )
        $
        只要 $m != k pi$ 方程一定有解。若初值为 $(0, 0)$ 则除非 $m = k pi$ 方程无解
  == 2
    这是欧拉方程，令 $x = e^t$。计算：
    $
    der(y, x) = der(y, t)der(t, x) = der(y, t) e^(-t)\
    der(der(y, x), x) = der(der(y, x), t)der(t, x) = der( der(y, t) e^(-t), t) e^(-t)   \
    = ((dif^2 y)/(dif t^2) e^(-t) - der(y, t) e^(-t))e^(-t)\
    x^2 der(der(y, x), x) = (dif^2 y)/(dif t^2) - der(y, t)
    $
    代回方程得：
    $
    cases(
      (y'' - y') - lambda y' + lambda y = 0,
      y(0) = 0,
      y(ln 2) = 0

    )
    
    $
    方程化为：
    $
    y'' -(lambda + 1)y' + lambda y = 0
    $
    - $lambda != 1$ 时特征根分别为 $1, lambda$，通解为：
      $
      linearCombinationC(e^x, e^(lambda x))
      $
      代入初值：
      $
      cases(
        C_1 + C_2 = 0,
        2 C_1 + 2^lambda C_2 = 0
      )
      $
      有非零解当且仅当 $lambda = 1$ ，这是不可能的
    - $lambda = 1$ 时通解为：
      $
      linearCombinationC(x e^x, e^x)
      $
      代入初值：
      $
      cases(
        C_2 = 0,
        2 ln 2 C_1 + 2 C_2 = 0
      )
      $
      仍然无非零解
  == 4
    用常数变易法，假设 $u_1, u_2$ 是对应齐次方程的两个基解，设：
    $
    y = linearCombinationC(u_1, u_2)\
    y' = linearCombinationC(u'_1, u'_2) + C'_1 u_1 + C'_2 u_2\
    $
    设 $C'_1 u_1 + C'_2 u_2 = 0$，继续求导：
    $
    y'' = linearCombinationC(u''_1, u''_2) + C'_1 u'_1 + C'_2 u'_2\
    linearCombinationC(u''_1, u''_2) + C'_1 u'_1 + C'_2 u'_2 + (lambda r(x) +q(x))  linearCombinationC(u_1, u_2) = f(x)\
    C'_1 u'_1 + C'_2 u'_2 = f(x)
    $
    得到方程组：
    $
    cases(
      C'_1 u_1 + C'_2 u_2 = 0,
      C'_1 u'_1 + C'_2 u'_2 = f(x)
    )
    $
    解得：
    $
    C'_2 (u_1 u'_2 - u'_1 u_2) = f(x) u_1\
    C'_2 = (f(x) u_1) / (u_1 u'_2 - u'_1 u_2)\
    C'_1 = (f(x) u_2) / (u'_1 u_2 - u_1 u'_2)\
    C_2 = integral_(0)^(x)   (f u_1) / (u_1 u'_2 - u'_1 u_2) + A_2\
    C_1 = integral_(0)^(x)   (f u_2) / (u'_1 u_2 - u_1 u'_2) + A_1
    $
    代入边值：
    $
    cases(
      (C_1 (0) u_1 (0) + C_2 (0) u_2 (0)) cos alpha - (C_1 (0) u'_1 (0) + C_2 (0) u'_2 (0)) sin alpha = 0,
      (C_1 (1) u_1 (1) + C_2 (1) u_2 (1)) cos alpha - (C_1 (1) u'_1 (1) + C_2 (1) u'_2 (1)) sin alpha = 0
    )
    $
    观察发现，这是关于 $A_1, A_2$ 的非齐次线性方程组，系数矩阵为：
    $
    mat(u_1 (0) cos alpha - u'_1 (0) sin alpha, u_2 (0) cos alpha - u'_2 (0) sin alpha; u_1 (1) cos alpha - u'_1 (1) sin alpha, u_2 (1) cos alpha - u'_2 (1) sin alpha)
    $
    - 若其满秩，不难发现方程组有唯一解
    - 否则，两行线性相关，不难得到齐次微分方程的特征函数，进而 $lambda$ 一定是特征值。此时不妨设 $u_1$ 是特征函数，方程化简为：
      $
      cases(
       C_2 (0) u_2 (0) cos alpha - C_2 (0) u'_2 (0) sin alpha = 0,
        C_2 (1) u_2 (1) cos alpha - C_2 (1) u'_2 (1) sin alpha = 0
    )
      $
      断言  $u_2 (0) cos alpha - u'_2 (0) sin alpha != 0,u_2 (1) cos alpha - u'_2 (1) sin alpha != 0$ ，否则 $u_1, u_2$ 在 $0$ 或 $1$ 处线性相关，导致整个解线性相关，与无关假设矛盾！因此上式有解当且仅当 $C_2 (0) = C_2 (1)$

      另一方面，令 $u_1 u'_2 - u'_1 u_2 = W(x)$，则有：
      $
      W'(x) = u_1 u''_2 - u''_1 u_2 = (lambda r(x) + q(x)) (u_1 u_2 - u_1 u_2) = 0
      $
      表明 $W(x)$ 是常数，当然非零（否则 $u_1, u_2$ 相关），因此：
      $
      C_2 (0) = C_2 (1) <=> integral_(0)^(1)   (f u_1) / (u_1 u'_2 - u'_1 u_2) = 0 <=> integral_(0)^(1)   f u_1 = 0
      $
      证毕
= 
  == 
    $
    partialDer(z, x) - y / (x + 2y) partialDer(z, y) = 0\
    (dif x)/(x + 2 y) + (dif y)/y = 0\
    y' = - y/(x + 2 y)\
    u = y /x \
    y = x u\
    y' = u + x u' = - u/(1 + 2 u)\
    x u' + (2 u + 2 u^2)/(1 + 2 u) = 0\
    1/x x' + (1 + 2 u)/(2 u + 2 u^2) = 0\
    1/x dif x + (1 + 2 u)/(2 u + 2 u^2) dif u = 0\
    dif ln x + dif 1/2 ln (2 u + 2 u^2) = 0\
    ln x + 1/2 ln (2 y/x + 2 y^2/x^2) = C\
    $
  ==
    $
    (dif x)/ (x - z) = (dif y)/ (y - z) = (dif z) / (2 z)\
    (dif x)/ (x - z) = (dif z) / (2 z)\
    2 z dif x - (x - z) dif z = 0\
    2 dif x - (x / z - 1) dif z = 0\
    u = x / z, x = z u, dif x = u dif z + z dif u\
    2 (u dif z + z dif u) - (u - 1) dif z = 0\
    (u + 1) dif z + 2 z dif u = 0\
    1/z dif z + 2/(u + 1) dif u = 0\
    ln z + 2 ln (u + 1) = C\
    (x/z+1)^2 z = C\
    (x - z) partialDer(u, x) = 2 (x/z + 1)(x - z)\
    partialDer(u, z) = (x/z+1)^2 +  z (-x/z^2) 2(x/z + 1)\
    2 z partialDer(u, z) = 2(x+z)(x/z + 1)  -4 x (x/z + 1) = 
    $
    $
    (dif y)/ (y - z) = (dif z) / (2 z)\
    (y/z + 1)^2 z = C
    $
  == 
    $
    (dif x)/(x y) = (dif y)/(x - 2 z) = (dif z)/(y z) 
    $
    $
    (dif x)/(x) = (dif z)/(z)\
    x/z = C_1 
    $
    $
    y' = (x - 2 z)/(x y)\
    z' = z / x\
    y y' + 2 z' = 1\
    1/2 y^2 + 2 z - x = C\
    $
    $
    z = 1/2 x -1/4 y^2\
    x y partialDer(z, x) = 1/2 x y\
    (x - 2 z) partialDer(z, y) = (x - 2 z) (-1/2 y) 
    $
    $
    (dif x_i)/(x_i) = (dif y)/(k y)\
    ln x_i - 1/k ln (k y) = 0\
     y = C x_i^k
    $
