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
  $
    
  $
