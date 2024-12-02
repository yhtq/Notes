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
= 2.
  Euler 方法给出：
  $
    y_(n + 1) = y_n + h 100 y_n = (1 + 100 h) y_n = ... = (1 + 100 h)^n y_0
  $
  如果有误差 $epsilon$，解变为：
  $
    (1 + 100 h)^n (y_0 + epsilon) = (1 + 100 h)^n y_0 + (1 + 100 h)^n epsilon
  $
  假设区间总长为 $l = n h$，则有：
  $
    (1 + 100 h)^n epsilon = ((1 + (100 l) / n)^(n / 100l))^(100 l) epsilon -> e^(100 l) epsilon
  $
  可见当区间比较长时，误差会被严重放大
= 4.
  将试验方程代入得：
  $
    y_(n + 2) - (1 + alpha) y_(n + 1) + alpha y_n = (lambda h)/12 ((5 + alpha) y_(n + 2) + 8 (1- alpha) y_(n + 1) - (1 + 5 alpha) y_n)\
    ((5 + alpha) lambda h - 12, 8 lambda h (1 - alpha) + 12 (1 + alpha), -lambda h (1 + 5 alpha) - 12 alpha) vec(y_(n + 2), y_(n + 1), y_n) = 0\
    ((5 + alpha) lambda h - 12, 8 lambda h (1 - alpha) + 12 (1 + alpha)) y_(n + 2) = (- 8 lambda h (1 - alpha) - 12 (1 + alpha), lambda h (1 + 5 alpha) + 12 alpha)vec(y_(n + 1), y_n)\
    ((5 + alpha) lambda h - 12, 8 lambda h (1 - alpha) + 12 (1 + alpha)) vec(y_(n + 2), y_(n + 1)) = mat(- 8 lambda h (1 - alpha) - 12 (1 + alpha), lambda h (1 + 5 alpha) + 12 alpha; ((5 + alpha) lambda h - 12, 8 lambda h (1 - alpha) + 12 (1 + alpha)), 0)vec(y_(n + 1), y_n)
  $
  $y_n -> 0$ 当且仅当：
  $
    (mat(- 8 lambda h (1 - alpha) - 12 (1 + alpha), lambda h (1 + 5 alpha) + 12 alpha; ((5 + alpha) lambda h - 12, 8 lambda h (1 - alpha) + 12 (1 + alpha)), 0))/(((5 + alpha) lambda h - 12, 8 lambda h (1 - alpha) + 12 (1 + alpha))) 
  $ 
  的最大特征值小于1
= 6.
  局部误差为：
  $
    y(x_(n + 1)) - y(x_n) - 1/6 h (4 f(x_n, y(x_n)) + 2 f(x_(n + 1), y(x_(n + 1))) + h f(x_n, y(x_n)))\
    = h(f_n - 1/6 (4 f_n + 2 f(x_(n + 1), y(x_(n + 1))) + h f_n )) + 1/2 h^2 (f_(x_n) + f_n f_(y_n)) + O(h^3)\
    = h(f_n - 1/6 (4 f_n + 2 (f_n + h (f_(x_n) + f_n f_(y_n)) + O(h^2)) + h f_n )) + 1/2 h^2 (f_(x_n) + f_n f_(y_n)) + O(h^3)\
    = h(- 1/6 ( 2 h (f_(x_n) + f_n f_(y_n)) + O(h^2)) + h f_n ) + 1/2 h^2 (f_(x_n) + f_n f_(y_n)) + O(h^3)\
    = 1/6 (f_(x_n) + f_n f_(y_n) - f_n) h^2 + O(h^3)
  $
  因此具有一阶精度
= 9.
  == (1)
    系数矩阵为：
    $
      mat(-10, 9;10, -11)
    $
    特征多项式为：
    $
      Det(lambda + 10, -9;  - 10, lambda + 11) = lambda^2 + 21 lambda + 110 - 90 = lambda^2 + 21 lambda + 20 = (lambda + 1) (lambda + 20) 
    $
    因此刚性比为 $20$。由于四阶显式 Rough-Kutta 方法的绝对稳定域为：
    $
      abs(1 + (lambda h) + 1/2 (lambda h)^2 + 1/6 (lambda h)^3 + 1/24 (lambda h)^4) < 1
    $
    计算得 $h < 0.14$ 时才能稳定
  == (2)
    系数矩阵为：
    $
      mat(998, 1998; -999, -1999)
    $
    特征多项式为：
    $
      Det(lambda - 998, -1998; 999, lambda + 1999) = lambda^2 + #(1999 - 998) lambda + #(- 1999 * 998 + 999 * 1998) = (lambda + 1)(lambda + 1000)
    $
    因此刚性比为 $1000$，计算得 $h < 0.0028$ 才能稳定
