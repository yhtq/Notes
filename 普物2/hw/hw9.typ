#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "../../scientific.typ": *
#show: note.with(
  title: "相对论作业",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
#let cV = 3e8  // 光速
#let LorentzTransform(x, t, v) = (x - v * t / calc.sqrt(1 - (v * v) / (cV * cV)), t - (v * x) / (cV * cV) / calc.sqrt(1 - (v * v) / (cV * cV)))
#let InverseLorentzTransform(x, t, v) = ( (x + v * t) / calc.sqrt(1 - (v * v) / (cV * cV)), (t + (v * x) / (cV * cV)) / calc.sqrt(1 - (v * v) / (cV * cV)) )
= 1
  == (1)
    代入洛伦兹变换有：
    $
      t' = (t - (v x) / (c^2)) / sqrt(1 - (v^2) / (c^2)) \
      = #scientificShow(LorentzTransform(50, 2e-7, -.6 * cV).at(1)) s
    $
  == (2)
    代入洛伦兹变换有：
    $
      t'_2 = #scientificShow(LorentzTransform(10, 3e-7, -.6 * cV).at(1))\
    $
    在 $S'$ 中两者同时发生
= 4
  根据洛伦兹变换：
  $
    x'_2 - x'_1 = ( (x_2 - v t) - (x_1 - v t) ) / sqrt(1 - (v^2) / (c^2)) = (x_2 - x_1) / sqrt(1 - (v^2) / (c^2)) \
    sqrt(1 - (v^2) / (c^2)) = 1/2\
    v / c = sqrt(3) / 2 \
    t'_2 - t'_1 = ( (t - (v x_2) / (c^2)) - (t - (v x_1) / (c^2)) ) / sqrt(1 - (v^2) / (c^2)) \
    = - 2 v/c^2 (x_2 - x_1)\
    = - sqrt(3) (x_2 - x_1) / c\
    = - #scientificShow(calc.sqrt(3) * (1e3) / cV) s \
  $
= 7
  == (1)
    在飞船参考系中，有：
    $
      x'_1 = 0
    $
    代入洛伦兹逆变换：
    $
      t = (t') / sqrt(1 - (v^2) / (c^2)) \
      = #scientificShow(30 / calc.sqrt(1 - 0.64)) "min"
    $
    因此时间是 12:05
  == (2)
    使用洛伦兹逆变换：
    $
      x_1 = (v t') / sqrt(1 - (v^2) / (c^2)) \
      = #scientificShow(0.8 * cV * 30 * 60 / calc.sqrt(1 - 0.64)) "m" \
    $
  == (3)
    之前计算得此时飞船坐标为 $x_1$，信号传播速度就是光速，因此：
    $
      Delta t = x_1 / c = #scientificShow(0.8 * 30 * 60 / calc.sqrt(1 - 0.64) / 60) "min"
    $
    也就是地球时间 12:45
  == (4)
    从飞船坐标系上看，地球收到信号时的坐标和时间分别为：
    $
      x'_2 = -(v t_2) / sqrt(1 - (v^2) / (c^2)) \
      = - #scientificShow(0.8 * cV * 45 * 60 / calc.sqrt(1 - 0.64)) "m" \
      t'_2 = t_2 / sqrt(1 - (v^2) / (c^2)) \
      = #scientificShow(45 / calc.sqrt(1 - 0.64)) "min" \
    $
    也就是 13:15 时地球收到信号。此后回答信号从地球发出，由于光速始终为 $c$，因此在飞船参考系中，信号传播时间为：
    $
      Delta t'_2 = abs(x'_2) / c = #scientificShow(0.8 * 45 * 60 / calc.sqrt(1 - 0.64) / 60) "min" \
    $
    因此 14:15 时，飞船收到信号。
  = 8
    #let lambdaFV = 9e-12 / 656e-9
    #let kv = (calc.sqrt(lambdaFV * lambdaFV + 4) + lambdaFV) / 2
    可以计算出波长差为：
    $
      (sqrt((1 + beta) / (1 - beta)) - sqrt((1 - beta) / (1 + beta))) lambda_0 = Delta lambda\
      (Delta lambda)/lambda_0 = k - 1/k where k = sqrt((1 + beta) / (1 - beta)) \
      k^2 - (Delta lambda) / lambda_0  k - 1 = 0 \
      k = ( (Delta lambda) / lambda_0 + sqrt( ((Delta lambda) / lambda_0)^2 + 4 ) ) / 2 \ 
      = #scientificShow(kv)\
      (1 + beta) / (1 - beta) = k^2 \
      (1 + k^2) beta = k^2 - 1 \
      beta = (k^2 - 1) / (k^2 + 1) \
      v = beta c = d / 2 omega = pi d / T\
      T = (pi d) / v = #scientificShow( 1 / (cV * (kv * kv - 1) / (kv * kv + 1) / calc.pi / 1.4e9) / 86400 ) "天" 
      
    $
  = 9
    根据书上的计算结果，有：
    $
      norm2(v) = (norm2(v') (1 - beta^2) + v_0^2 + 2 u'_x v_0 + beta^2 u'_x^2) / (1 + v_0 / c^2 u'_x)^2\
      = (norm2(v') (c^2 - v_0^2) + c^2 v_0^2 + 2 c^2 u'_x v_0 + v_0^2 u'_x^2) / (c^2 + v_0 u'_x)^2\
      = (norm2(v') (c^2 - v_0^2) + (c^2 + v_0 u'_x)^2 + c^2 v_0^2 - c_4) / (c^2 + v_0 u'_x)^2\
      = 1 -  ((c^2 - norm2(v')) (c^2 - v_0^2)) / (c^2 + v_0 u'_x)^2\
    $
    注意到 $c^2 + v_0 u'_x > 0$，因此上式关于 $u'_x$ 单调增加。而 $u'_x$ 的最小值，最大值分别为 $- norm(v'), norm(v') where norm(v') = 0.82 c $，代入结果分别为：
    $
      (1 - ((1 - 0.85^2) (1 - 0.9^2))/(1 + 0.85 * 0.9)^2) c = #scientificShow(1 - ((1 - 0.85 * 0.85) * (1 - 0.9 * 0.9)) / (1 + 0.85 * 0.9) / (1 + 0.85 * 0.9)) c\
    $
    $
      (1 - ((1 - 0.85^2) (1 - 0.9^2))/(1 - 0.85 * 0.9)^2) c = #scientificShow(1 - ((1 - 0.85 * 0.85) * (1 - 0.9 * 0.9)) / (1 - 0.85 * 0.9) / (1 - 0.85 * 0.9)) c\
    $
    // 实验室参考系中，有动量守恒：
    // $
    //   M v_0 = m_1 v_1 + m_2 v_2 \
    // $
    // 质量关系：
    // $
    //   m_1 + m_2 = M\
    // $
    // 随 $K^0$ 介子运动的参考系中，有：
    // $
    //   v'_1 = - v'_2 = 0.85 c
    // $
    // 做速度变换，就有：
    // $
    //   v_1 = (v'_1 + v_0) / (1 + (v'_1 v_0) / c^2) \
    //   v_2 = (- v'_2 + v_0) / (1 - (v'_2 v_0) / c^2) \
    // $
  == 12
    == (1)
      #let kv = 0.64 / 0.51
      #let vv = (calc.sqrt(1 - calc.pow(kv, -2)) * cV)
      有：
      $
        E_1 = e V + E_0 = 0.64 "MeV"\
        (m)/m_0 = E_1 / E_0 = 0.64 / 0.51\
        m = (E_1 / E_0) m_0 = m_0 / sqrt(1 - (v^2) / (c^2)) \
        1 - v^2 / c^2 = (E_1 / E_0)^(-2) \
        v  = c sqrt(1 - (E_1 / E_0)^(-2)) = #scientificShow(vv) "m / s" \
        t = s / v = #scientificShow(8.4 / vv) "s" \
      $
    == (2)
      根据洛伦兹变换的结果：
      $
        s' = s / sqrt(1 - (v^2) / (c^2)) = #scientificShow(8.4 / calc.sqrt(1 - (vv * vv) / (cV * cV))) "m" \
      $
  == 14
    == (1)
      #let Vv = (9.1e-31 * cV / 1.602e-19) * (1.004 - 1)
      有：
      $
        (m) / m_0 = (e V + E_0) / E_0\
        m / m_0 = 1 + (e V) / (m_0 c^2) \
        V = (m_0 c^2)/e (m / m_0 - 1) = #scientificShow( (9.1e-31 * cV / 1.602e-19) * (1.004 - 1) ) "KJ" \
      $
    == (2)
      $
      v = c sqrt(1 - (m_0 / m)^2) = #scientificShow( cV * calc.sqrt(1 - 1 / (1.004 * 1.004)) ) "m / s"
      $ \
  == 17
    设静止原子位置为坐标原点，对光子有：
    $
      x = c t\
      h nu = m c^2 => m = (h nu) / c^2 \
    $
    因此 $t$ 时刻，质心坐标为：
    $
      ((h nu) / c^2 c t) / (m_0 + (h nu) / c^2) = (h nu t) / (m_0 c^2 + h nu) \
    $
    质心速度为：
    $
      V = (h nu) / (m_0 c^2 + h nu) \
    $