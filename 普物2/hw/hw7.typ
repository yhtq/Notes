#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "../../scientific.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 4
  == 1
    #let Rv = 1.5
    #let bv = 6
    #let lambdaV = 0.63e-6
    #let cv = calc.sqrt((Rv * bv)/(Rv + bv) * lambdaV) * 1e3
    根据半波带的半径公式，有：
    $
      rho_k = sqrt((R b)/(R + b) k lambda)\
      = #scientificShow(cv) sqrt(k) "mm"\
    $
    因此，前两个亮斑($k = 1, 3$)对应的半径分别为：
    $
      #scientificShow(cv * calc.sqrt(1)) "mm", #scientificShow(cv * calc.sqrt(3)) "mm"\
    $
    前两个暗斑($k = 2, 4$)对应的半径分别为：$
      #scientificShow(cv * calc.sqrt(2)) "mm", #scientificShow(cv * calc.sqrt(4)) "mm"\                
    $
  == 3
    其振幅实际为：
    $
      sumi1inf(A_i) - A_2 - A_4 - A_6 - A_8 - A_10\
      = A_0 + 5 A_1 = 11 A_0
    $
    因此光强为自由传播的 $121$ 倍。
  == 5
    主焦距为：
    $
      f = rho_1^2 / lambda = #scientificShow(calc.pow(5e-3, 2) / (1.06e-6)) "m"
    $
  == 8
    有：
    $
      2 f lambda/b = D\
      b = (2 f lambda)/D = #scientificShow(5460e-10 * 2 * 0.4 / 1.5e-3) "m"
    $
  == 11
    恰能分辨时：
    $
      delta y = L delta theta = 1.22 L lambda / D\
      L = (delta y D)/(1.22 lambda) = #scientificShow(1.5 * 3e-3 / 1.22 / 550e-9) "m"\
    $
  == 15
    恰能分辨时（$lambda$ 取 $550$ nm?）：
    $
      delta y = L delta theta = 1.22 L lambda / D_0\
      D_0 = (1.22 L lambda)/delta y = #scientificShow(1.22 * 1.8e11 * 550e-9 / 20e3) "m"\
    $
  == 17
    === (1)
      缝的个数为主极大间次极大个数加 $2$，因此 $N$ 分别为 $5,4, 2, 6$
    === (2)
      (a) 第 $4$ 级第一个缺级，因此 $d / b =4$\
      (b) 第 $2, 4, ...$ 级缺级，因此 $d / b = 2$\
      (c) 第 $4$ 级缺级，因此 $d / b = 4$\
      (d) 第 $4$ 级缺级，因此 $d / b = 4$
    === (3)
      可以观察到 $d_c > d_d > d_a > d_b / 2$，根据上面的 $d / b$ 可以得到：
      $
        b_b > b_a > b_d > b_c\
      $
  == 21
    #let dv = 1 / 200 * 1e-3
    #let lambdav = 5890e-10
    #let dlambdaV = 6e-10
    光栅常数为：
    $
      d = 1 / 200 times 10^(-3) "m"  = scientificShow(dv) "m"
    $
    总刻线数：
    $
      N = 50 times 200 = 10000\
    $
    对于一级光谱，有：
    $
      d sin theta = lambda\
      sin theta = lambda / d\
      theta = arcsin (lambda / d)\
    $
    角间距为：
    $
      dif theta = (dif lambda) / (d cos theta) = #scientificShow(dlambdaV / (dv * calc.cos(calc.asin(lambdaV / dv).rad())))
    $
    半角宽度为：
    $
      arcsin (lambda / (N d)) = #scientificShow(calc.asin(lambdav / (5e-2)).rad())\
      arcsin ((lambda + dif lambda) / (N d)) = #scientificShow(calc.asin((lambdav + dlambdaV) / (5e-2)).rad())\
    $
    能分辨的最小波长差为：
    $
      #scientificShow(lambdav / 10000) < #scientificShow(dlambdaV)\
    $
    因此不能分辨
  == 27
  == 28
    