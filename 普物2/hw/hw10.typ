#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "../../scientific.typ": *
#show: note.with(
  title: "作业",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 第二章
  == 3
    设此时温度为 $T_0$ 则：
    $
      E_0 = sigma T^4_0\
      T_0 = (E_0/sigma)^(1/4)\
    $
    则：
    $
      lambda_m = b / T_0 = b (sigma / E_0)^(1/4)
    $
  == 4
    由于
    $
      lambda_m = b / T
    $
    因此 $T$ 是原来的 $3/2$，$E_0$ 是原来的 $(3/2)^4$
  == 7
    有：
    $
      lambda_0 = c / nu_0\
      h nu_0 = A
    $
    对于给定 $lambda$，遏止电压满足：
    $
      e U_0 = T = h (c / lambda) - A = h (c / lambda - c / lambda_0)\
      U_0 = h/e (c / lambda - c / lambda_0) 
    $
  == 10
    $
      T = h nu - A = h (c / lambda) - A\
      U_0 = T / e = h/e (c / lambda) - A/e\
      lambda_0 = c / (nu_0) = (h c) / (A)
    $
  == 13
    根据能量守恒，电子获得能量为：
    $
      (h c)/lambda_0 - (h c)/lambda_1
    $
    其中：
    $
      lambda_1 = lambda_0 + (h)/(m_0 c) (1 - cos theta)
    $
    代入不同的 $theta$ 可求出电子获得的最大能量和最小能量。
= 第三章  
  == 2
    根据德布罗意关系 $E = h nu$ 和 $p = h / lambda$，它们的动量相同。同时，有：
    $
      E = 1/(2 m)p^2 = 1/(2 m) (h / lambda)^2
    $
  == 7
    根据方势阱模型，有：
    $
      E_1 = (pi^2 h^2) / (2 m a^2)
    $
  == 12
    代入书上方程，有：
    $
      h^2 / (m) sqrt(15 / (16 a^2)) a^2 + U(x) sqrt(15 / (16 a^2)) (a^2 - x^2) = E sqrt(15 / (16 a^2)) (a^2 - x^2)
    $
    整理可得：
    $
      U(x) = E - h^2/ a^2 / (a^2 - x^2)
    $
  == 14
    深方方势阱模型中，概率密度是周期的。因此 $a$ 是有限深方方势阱，$b$ 是无限深方方势阱，$c$ 是谐振子势。
  == 16
    $
      der(phi, x) = - alpha^2 sqrt(alpha / sqrt(pi)) x e^(-1/2 alpha^2 x^2)\
      derN(phi, x, 2) = (- alpha^2 sqrt(alpha / sqrt(pi)) + alpha^4 x^2 sqrt(alpha / sqrt(pi))) e^(-1/2 alpha^2 x^2)
    $
    代入一维薛定谔方程：
    $
      - h^2 / (2 m) (- alpha^2 sqrt(alpha / sqrt(pi)) + alpha^4 x^2 sqrt(alpha / sqrt(pi))) e^(-1/2 alpha^2 x^2) + U(x) sqrt(alpha / sqrt(pi)) e^(-1/2 alpha^2 x^2) = E sqrt(alpha / sqrt(pi)) e^(-1/2 alpha^2 x^2)\
      E = U (x)-h^2/(2 m) (alpha^4 x^2 - alpha^2)\
      U(x) = E + h^2/(2 m) (alpha^4 x^2 - alpha^2)
    $
    因此势能期望为：
    $
      integral_()^() U(x) phi(x) dif x = integral_()^() ( E + h^2/(2 m) (alpha^4 x^2 - alpha^2))  sqrt(alpha / sqrt(pi)) e^(-1/2 alpha^2 x^2)  dif x
    $