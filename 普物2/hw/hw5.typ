#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业3, 4",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= p202
  == 5
    假设绝热线与等温线交于两点 $A, B$，则 $A -> B$ 的绝热过程中一定经历了温度升高和降低的过程，而其中降低的过程中，气体不吸收热量，相当于气体的内能全部转化为了功，这在绝热过程中是与热力学第二定律相违背的。
  == 10
    $
      integral_()^() 1/T dif Q = integral_(T_0 + 20)^(T_0) C_1/T dif T + (10 * 335) / T_0 + integral_(T_0)^(T_0 - 10) C_2/T dif T\
      =  - C_1 ln((T_0 + 20)/T_0) - (10 * 335) / T_0 - C_2 ln((T_0)/(T_0 - 10))\
      = - #(10 * 4.2 * calc.ln((273.15 + 20) / (273.15)) + (10 * 335) / 273.15 + 10 * 1.7 * calc.ln(273.15 / (273.15 - 10))) "J / K"
    $
  == 11
    #let T0v = 273.15
    #let av = 3.634
    #let bv = 1.195e-3
    #let cv = 0.135e-6
    #let c1v = 4.2
    #let mv = 36
    $
      integral_()^() 1/T dif Q = m (integral_(T_0 + 20)^(T_0 + 100) C_1/T dif T + 2260 / (T_0 + 100) + integral_(T_0 + 100)^(T_0 + 250) 1/T dif (C_2(T) T))\
      = m (integral_(T_0 + 20)^(T_0 + 100) C_1/T dif T + 2260 / (T_0 + 100) + R integral_(T_0 + 100)^(T_0 + 250) (a + 2b T + 3 c T^3)/T dif T)\
      = m (integral_(T_0 + 20)^(T_0 + 100) C_1/T dif T + 2260 / (T_0 + 100) + R integral_(T_0 + 100)^(T_0 + 250) a/T + 2 b + 3 c T dif T)\
      = m (C_1 ln ((T_0 + 100)/(T_0 + 20))+ 2260 / (T_0 + 100) + R (a ln ((T_0 + 250)/(T_0 + 100)) + 2 b * (150) + 3 c/2 ((T_0 + 250)^2 - (T_0 + 100)^2)))\
      = #(mv *(
4.2 * calc.ln((273.15 + 100) / (273.15 + 20)) + 2260 / (273.15 + 100) + 8.314 * (av * calc.ln((273.15 + 250) / (273.15 + 100)) + 2 * bv * (150) + 3 * cv / 2 * (calc.pow(273.15 + 250, 2) - calc.pow(273.15 + 100, 2))
      ))) "J / K"
    $
  == 13
    系统熵变为：
    $
      (dif Q)/T_1 - (dif Q)/T_2 = (dif Q) (1/T_1 - 1/T_2)\
      = #(4.18 * (1/300 - 1/400)) "J / K"
    $
  == 16
    $
      integral_()^() 1/T dif Q = integral_(1)^(2) C_p /T dif T + integral_(2)^(3) C_v / T dif T\
      = C_p ln (T_2 / T_1) + C_v ln(T_3 / T_2)\
      = C_v ln (T_2 / T_1) + n R ln (T_2 / T_1) + C_v ln (T_3 / T_2)\
      = C_v ln (T_3 / T_1) + n R ln (T_2 / T_1)
    $
    理想气体熵公式给出结果：
    $
      dif S = C_v ln (T_3 / T_1) + n R ln (V_2 / V_1)
    $
    由于 $1 -> 2$ 是等压膨胀，两式当然是相等的
  == 19
    #let Tv = 1/2 * 2100 * calc.pow(80/3.6, 2)
    #let T_1v = (273.15 + 60)
    #let T_0v = 273.15
    刹车时，动能全部转化为热能，而动能为：
    $
      Q = 1/2 m v^2 = #Tv "J"
    $
    因此：
    $
      S = C ln (T_1 / T_0) = (Q / (T_1 - T_0)) ln (T_1 / T_0) = #(Tv / (T_1v - T_0v) * calc.ln(T_1v / T_0v)) "J / K"
    $
    散步的空气中后，总熵变为：
    $
      S = Q (1/T_0 - 1/T_1) = #(Tv * (1/T_0v - 1/T_1v)) "J / K"
    $
