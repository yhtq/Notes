#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "../../scientific.typ": *
#show: note.with(
  title: "第五章作业",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 1
  根据马吕斯定律，设初始光强为 $I$，要得到 $lambda I$ 的光强，就要转动角度满足：
  $
    lambda I = I cos^2(theta) \\
    theta = arccos (sqrt(lambda))
  $
= 3
  #figure(
    image(
      "./屏幕截图 2025-12-08 161059.png"
    )
  )
  若是振动方向垂直入射面的线偏振光，则只有 o 光。若在入射面内，则只有 e 光。
= 5
  光线在第一个方解石界面处直射，但分成两束，o 光振动垂直入射面，e 光振动在入射面内。在第二个方解石处，由于光轴方向改变，o 光和 e 光的地位对换，因此：
  $
    sin(alpha) / (v_o) = sin(theta_1) / (v_e)\
    sin(alpha) / (v_e) = sin(theta_2) / (v_o) \
  $
  其间夹角为：
  $
    theta_1 - theta_2 = arcsin(sin(alpha) v_e / v_o) - arcsin(sin(alpha) v_o / v_e)
  $
= 7
  == 1
    垂直主平面振动的 $o$ 光光强为 $I sin pi/6$，平行主平面振动的 $e$ 光光强为 $I cos pi/6$，光强比为 $(1/2) / (sqrt(3) / 2) = 1 / sqrt(3)$
  == 2
    最小厚度 $d$ 满足：
    $
      (2 pi) / lambda (n_o - n_e) d = pi\
      d = lambda / (2 (n_o - n_e)) \
      = #scientificShow(
        589e-9 / (2 * 0.172)
      ) "m"
    $
  == 3
    根据对称性，，振动面恰好转动 $60$ 度 
= 10
  == (1)
    如果波长为 $lambda$ 的经过第二个偏振片后消失，则其振动方向垂直第二个偏振片方向，相当于晶片是它的 $1/2$ 波片，就有：
  == (2)
    如果波长为 $lambda$ 的经过第二个偏振片后消失，则其振动方向垂直第二个偏振片方向，相当于晶片是它的全波片，就有：
    #let kcv = (0.025e-3 * 0.172)
    $
      (2 pi) / lambda (n_o - n_e) d = (2 k) pi \
      lambda = 2/(2 k) (n_o - n_e) d \
    $
    可以验证，给定范围内 $k$ 分别取 $7, 8, 9, 10$，对应波长为：
    $
      #scientificShow(2 / (2 * 7) * kcv)\
      #scientificShow(2 / (2 * 8) * kcv)\
      #scientificShow(2 / (2 * 9) * kcv)\
      #scientificShow(2 / (2 * 10) * kcv)
    $
= 11
  == (1)
    $P_0$ 处相当于两束相位差为零，振动方向垂直的线偏振光叠加，得到的光仍然是线偏振光，振动方向在两个偏振方向中间，光强为 $2 I$（设每束光强为 $I$）。

    类似的，对于 $P_i$处，相当于相位差为 $pi/4 i$，振动方向垂直的线偏振光叠加。
  == (2)
    如果再加偏振片，则两光线的振动方向都被限制在偏振片方向上，变成标准的双缝干涉情形。
= 12
  显然就是，旋转角度为 $k pi + pi/2$ 时不能穿过第二个偏振片，也即：
  $
    d phi = k pi + pi/2 \
    d = (k + 1/2) pi / phi \
    = (k + 1/2) #scientificShow(180 / 21.7) "mm"
  $
  代入不同的 $k$ 值就得到不同的 $d$ 值。