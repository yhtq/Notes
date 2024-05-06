#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
应交时间为 5月6日
#set heading(numbering: none)
= 162
  == 3
    记初值 $x(0), x'(0)$ 下的解为：
    $
    phi(t, x(0), x'(0))
    $
    代入微分方程有：
    $
    (partial^2 phi)/(partial t^2) + C partialDer(phi, t) + g(phi) = p(t)
    $
    上式关于 $x(0), x'(0)$ 求偏导，将得到相同形式的方程：
    $
    u'' + C u' + g'(phi) u = 0
    $
    其中 $u_1 = partialDer(phi, x(0))$ 或 $u_2 = partialDer(phi, x'(0))$\
    此外，显然将有 $u'_1 = partialDer(phi', x(0))$ 或 $u'_2 = partialDer(phi', x'(0))$\
    以上两式意味着：
    $
    Phi'_t &= partialDer((phi(t), phi'(t)), (x(0), x'(0)))\
    &= mat(u_1, u_2;u'_1, u'_2)\
    det Phi'_t& = u_1 u'_2 - u_2 u'_1 \
    (det Phi'_t)' &= u'_1 u'_2 + u_1 u''_2 - u'_1 u'_2 - u_2 u''_1 = u_1 u''_2 - u_2 u''_1\
    &= - u_1 (C u'_2 + g'(phi) u_2) + u_2 (C u'_1 + g'(phi) u_1) \
    &= - C (u_1 u'_2 - u_2 u'_1) = - C det Phi'_t\
    $
    上式表明：
    $
    det Phi'_t = A e^(-C t)
    $
    其中 $A$ 与 $t$ 无关，代入 $t = 0$ 立得 $A = 1$，因此：
    $
    det Phi'_t = e^(-C t)
    $
    将 $t = 2 pi$ 代入立得结论
  == 4
    == 1
      设解为 $phi(x, mu)$，将有：
      $
      partialDer(partialDer(phi, mu), x) = phi^2 + 2 phi partialDer(phi, mu)\
      partialDer(phi, mu) (0, mu) = 1
      $
      此外，$phi(x, 0)$ 是方程：
      $
      cases(
        y' = 2 x,
        y(0) = -1
      )
      $
      的解，因此：
      $
      phi(x, 0) = x^2 - 1
      $
      综上，所求 $partialDer(y, mu)|_(mu = 1)$ 是微分方程：
      $
      cases(
        u' = (x^2 - 1)^2 + 2 (x^2 - 1) u,
        u(0) = 1
      )
      $
      的解，求解得：
      $
      u = e^(2/3 x(x^2-3)) (1 + integral_(0)^(x) e^(2/3 t(t^2-3)) (t^2 - 1)^2 dif t )
      $
    == 2
      设 $u = partialDer(y, mu)$ 将有：
      $
      u'' = 2/y^2 u
      $
      将 $mu = 1$ 代入原方程，变成：
      $
      cases(
        y'' = 2/x - 2/y,
        y(1) = 1,y'(1) = 1
      )
      $
      观察发现 $y = x$ 是方程的一个解。同时，可以将原方程转化成二维的一阶微分方程，进而证明该初值下解是唯一的。\
      因此只需解：
      $
      cases(
        u'' = 2/x^2 u,
        u(1) = 0,
        u'(1) = 1
      )
      $
      解得 $u = (x^3-1)/(3 x)$
= 172
  == 1
    设 $y(x)$ 满足题中等式，有：
    $
    y = Phi(x)(Inv(Phi)(x_0) y_0+ integral_(x_0)^(x) Inv(Phi)(s) f(s, y(s)) dif s)\
    y' = Phi'(x) (Inv(Phi)(x_0) y_0+ integral_(x_0)^(x) Inv(Phi)(s) f(s, y(s)) dif s) + Phi(x) Inv(Phi)(x) f(x, y(x))\
    = Phi'(x) (Inv(Phi)(x_0) y_0+ integral_(x_0)^(x) Inv(Phi)(s) f(s, y(s)) dif s) +  f(x, y(x))\
    = Phi'(x) Inv(Phi)(x) y + f(x, y(x))\
    = A(x) Phi(x) Inv(Phi)(x) y + f(x, y(x))\
    = A(x) y + f(x, y(x))
    $
    因此积分方程的解也是微分方程的解，另一方面设 $y$ 是微分方程的解，则有：
    $
    (Inv(Phi)(x) y)' = Inv(Phi)'(x) y + Inv(Phi)(x) y' = Inv(Phi)'(x) y + Inv(Phi)(x) (A(x) y + f(x, y))\
    = Inv(Phi)'(x) y + Inv(Phi)(x) (Phi'(x) Inv(Phi)(x) y + f(x, y))\
    = Inv(Phi)(x) + f(x, y)
    $
    两边积分即可
  == 3
    注意到齐次线性微分方程的解应当两两不交，因此当然不能同时为解
  == 4
    先解 $x$ 将有：
    $
    x' = 2/t x + 1
    $
    这是一阶线性微分方程，其解为：
    $
    x = C_1 t^2 - t
    $
    因此：
    $
    y' = 1/t (C_1 t^2 - t) + y\
    y' = C_1 t + y - 1
    $
    其解为：
    $
    y = C_2 e^t + C_1 (-1-t) e^(-t) + e^(-t)
    $

