#import "../../../template.typ": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 3.  
  == (1)
    就是 Simpson 公式：
    $
      integral_(0)^(2 h) f(x) dif x approx (2 h)/6 (f(0) + 4 f(h) + f(2 h)) = h/3 f(0) + (4 h)/3 f(h) + h / 3 f(2 h)
    $
    代数精度为 3
  == (2)
    $
      integral_(-h)^(h) 1 dif x = A + B => 2 h = A + B\ 
      integral_(-h)^(h) x dif x = - h A + B x_1 => 0 = -h A + B x_1\ 
      integral_(-h)^(h) x^2 dif x = h^2 A + B x_1^2 => 2/3 h^3 = h^2 A + B x_1^2\ 
    $
    求解之：
    $
      B x_1^2 = h A x_1\
      h^2 A + h A x_1 = 2/3 h^3\
      A + (2 h - A) x_1 = 0\
      x_1 = A / (A - 2 h)\
      h^2 A + h A^2 / (A - 2 h) = 2/3 h^3\
      h A + A^2 / (A - 2 h) = 2/3 h^2\
      (h + 1) A^2 - 8/3 h^2 A + 4/3 h^3 = 0\
      (h + 1)^2 A^2 - 8/3 (h + 1) h^2 A + 4/3 (h + 1) h^3 = 0\
      ((h + 1) A - 4/3 h^2)^2 = 16/9 h^4 - 4/3(h + 1) h^3\
      ((h + 1) A - 4/3 h^2)^2 = 4/3 (h^4 - h^3) \
    $
    可见若 $h < 1$，上述方程无解，从而只能保证至多一阶的代数精度，取梯形公式即可。否则：
    $
      A = plus.minus (sqrt(4/3 (h^4 - h^3)) + 4/3 h^3) / (h + 1)\
    $
    任取正负号都可以获得至少 2 阶代数精度的公式。往证它不可能有 3 阶代数精度。若有，则：
    $
      - h^3 A + B x_1^3 = 0\
      h^3 A = h A x_1^2\
      h^2 = x_1^2\
      h^2 A + h^2 B = 2/3 h^3\
      A + B = 2/3 h = 2 h\
    $
    这是荒谬的
  == (3)
    $
      2 = A_0 + 4/3 + A_2\
      2 = 4/3 x_1 + 2 A_2\
      8/3 =  4/3 x_1^2 + 4 A_2
    $
    求解之：
    $
      A_0 + A_2 = 2/3\
      3 A_2 + 2x_1 = 3\
      3 A_2 + x_1^2 = 2\
      x_1^2 - 2 x_1 + 1 = 0\
      x_1 = 1\
      A_2 = 1/3\
      A_0 = 1/3\
    $
    这就是 Simpson 公式，代数精度为 3
= 5.
  首先有：
  $
    integral_(c)^(d) f(x, y) dif y = (d - c)/6 (f(x, c) + 4 f(x, (c + d)/2) + f(x, d)) - (d - c)^5 / 2880 f''''(x, xi_x) 
  $
  进而：
  $
    integral_(a)^(b) integral_(c)^(d) f(x, y) dif y dif x = (d - c)/6 (integral_(a)^(b) f(x, c) + 4 f(x, (c + d)/2) + f(x, d) dif x) - (d - c)^5 / 2880 integral_(a)^(b) f''''(x, xi_x) dif x\
    = ((d-c)(b - a))/36 (f(a, c) + 4 f((a + b)/2, c) + f(b, c) + 4 f(a, (c + d)/2) \ + 16 f((a + b)/2, (c + d)/2) + 4 f(b, (c + d)/2) + f(a, d) + 4 f((a + b)/2, d) + f(b, d)) \
    - (d - c)/6 (b - a)^5 / 2880 (f'''' (xi, c) + 4 f'''' (xi, (c + d)/2) + f'''' (xi, d)) - (d - c)^5 / 2880 integral_(a)^(b) f''''(x, xi_x) dif x
  $
= 7.
  // -
  //   $
  //     M(h) = h sum_(i = 0)^(n - 1) f(a + i h/2)\
  //   $
  - 
    $
      T(h) = h/2 sum_(i = 0)^(n - 1) (f(a + i h) + f(a + (i + 1) h))\
      h/2 (sum_(i = 0)^(n - 1) f(a + i h) + sum_(i = 1)^(n) f(a + i h))\
      = h/2 (f(a) + f(b) + 2 sum_(i = 1)^(n - 1) f(a + i h))\
    $
  - 
    $
      3 T(h) = h/2 sum_(i = 0)^(n - 1) (f(x_i) + 4 f(x_(i + 1/2)) + f(x_(i + 1)))\
      = h/2 (sum_(i = 0)^(n - 1) f(x_i) + f(x_(i + 1)) + 4 sum_(i = 0)^(n - 1) f(x_(i + 1/2)))\
      = h/2 sum_(i = 0)^(n - 1) f(x_i) + f(x_(i + 1)) + 2 h sum_(i = 0)^(n - 1) f(x_(i + 1/2))\
      = T(h) + 2 M(h)
    $
  - 
    $
      M(h) = h sum_(i = 0)^(n - 1) f(a + (i + 1/2) h)\
    $
    $
      2 T(h/2) = h/2 (f(a) + 2 sum_(i = 0)^(2 n - 1) f(a + i h/2) + f(b))\
      = h/2 (f(a) + 2 sum_(k = 0)^(n - 1) f(a + ((2 k)/2) h) + f(b)) + h sum_(k = 0)^(n - 1) f(a + ((2 k + 1)/2)h )\
      = h/2 (f(a) + 2 sum_(k = 0)^(n - 1) f(a +  k h) + f(b)) + h sum_(k = 0)^(n - 1) f(a + (k + 1/2) h)\
      = T(h) + M(h)\
    $
  - 
    $
      M(h) = 2 T(h/2) - T(h)\
      S(h) = 1/3 (T(h) + 2 M(h)) = 1/3 (4 T(h/2) - T(h))
    $
= 8.
  #let into = $integral_(a)^(b) f(x) dif x$
  #let inti = $integral_(x_i)^(x_(i + 1)) f(x) dif x$
  #let sumi = sumf.with(upper: $n - 1$, var: $i$)()
  - 
    $
      abs(into - M(h)) 
      &<= sumi abs(inti - h f(x_(i + 1/2)))\
      &= sumi abs(h^3/24 f''(xi_i))\
      &<= sumi abs(h^3/24 M_2)\
      &= n h^3/24 M_2\
      &= (b - a) h^2/24 M_2
    $
  -
    $
      abs(into - T(h))
      &<= sumi abs(inti - h/2 (f(x_i) + f(x_(i + 1))))\ 
      &= sumi abs(h^3/12 f''(xi_i))\
      &<= sumi abs(h^3/12 M_2)\
      &= n h^3/12 M_2\
      &= (b - a) h^2/12 M_2
    $
  -
    $
      abs(into - S(h))
      &<= abs(into - h/6 (f(x_i) + 4 f(x_(i + 1/2)) + f(x_(i + 1))))\
      &= sumi abs(h^5/2880 f''''(xi_i))\
      &<= sumi abs(h^5/2880 M_4)\
      &= n h^5/2880 M_4\
      &= (b - a) h^4/2880 M_4
    $
