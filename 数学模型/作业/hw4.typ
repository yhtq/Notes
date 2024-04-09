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
#let absSigmaI(i) = $abs(x_sigma(#i))$
#let fL = $f^L$
（应交事件为4月15日）
= 4.1
  == 
    ===
      对 $x(t)$ 做傅里叶变换，得到：
      $
      sum_(n=-infinity)^(infinity) 1/(2 pi) integral_(-pi)^(pi) x(t) e^(-i n t) dif t space e^(i n t)\
      = sum_(n=-infinity)^(infinity) 1/(2 pi) integral_(-pi)^(pi) sin(sqrt(2) t) e^(-i n t) dif t space e^(i n t)\
      = sum_(n=-infinity)^(infinity) 1/(2 pi) integral_(-pi)^(pi) (e^(i sqrt(2) t) - e^(-i sqrt(2) t))/2 e^(-i n t) dif t space e^(i n t)\
      = sum_(n=-infinity)^(infinity) 1/(2 pi) (integral_(-pi)^(pi) e^(i (sqrt(2) - n) t) dif t - integral_(-pi)^(pi) e^(-i (sqrt(2) + n) t) dif t)/2 e^(i n t)\
      = sum_(n=-infinity)^(infinity) 1/(4 pi) (1/(sqrt(2) - n) (e^(i (sqrt(2) - n) pi) - e^(-i (sqrt(2) - n) pi))
        - 1/(sqrt(2) + n) (e^(i (sqrt(2) + n) pi) - e^(-i (sqrt(2) + n) pi))
      )  e^(i n t)\
      $
    ===
      对 $x(t)$ 做傅里叶变换，得：
      $
      c_n = 1/(2 l) integral_(-l)^(l) x(t) e^(-i n pi t/l) dif t\
      =  integral_(-1/2)^(1/2) x(t) e^(-2 i n pi t) dif t\
      =  integral_(-1/2)^(1/2) x(t) e^(-2 i n pi t) dif t\
      = integral_(-1/2)^(0) -t e^(-2 i n pi t) dif t + integral_(0)^(1/2) t e^(-2 i n pi t) dif t\
       = (1/4 n^(-2) (pi i n + ((-pi i n + 1) e^(pi i n) - 1) e^(pi i n) - e^(pi i n) + 1) e^(-pi i n) / pi^2)
      $
  ==
    在附件中有编程计算的结果