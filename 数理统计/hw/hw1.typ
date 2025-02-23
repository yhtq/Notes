#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1
  $
    L &= product_i p(1 - p)^(x_i - 1)\
    ln L &= sum_i ln p + (x_i - 1) ln (1 - p)\
         &= n ln p + ln (1 - p) sum_i (x_i - 1)\
  $
  令其最大，令：
  $
    0 = der(ln L, p) = n / p - (sum_i (x_i - 1))/(1 - p)\
    n (1 - p) = p sum_i (x_i - 1)\
    (n + sum_i x_i - n) p = n\
    p = n / (sum_i x_i)
  $
= 2
  $
    L &= product_i 1/(2 sigma) e^(- 1/sigma abs(x_i))\
    ln L &= sum_i (- 1/sigma abs(x_i) - ln (2 sigma))\
         &= - 1/sigma sum_i abs(x_i) - n ln (2 sigma)\
    0 = der(ln L, sigma) &= 1/sigma^2 sum_i abs(x_i) - n / (sigma)\
    sigma &= (sum_i abs(x_i)) / n
  $
= 4
  $
    L = product_i (1/2 1/(sqrt(2 pi)))
  $
#repr([$-11$].body.children.at(0))