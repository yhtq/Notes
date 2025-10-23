#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业1, 2",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false
)
= 1
  == 4
    === (1)
      注意到：
      $
        x/x_0 = T/T_o => x = T/T_0 x_0\
        t = ln (k x) = ln((k x_0)/T_0 T)
      $
      其中 $*_0$ 是水的三相点下气体的状态。代入：
      $
        t_0 = ln (k x_0) = T_0
      $
      可得：
      $
        t = ln (k x_0) + ln (T / T_0) = ln T - ln T_0 + T_0
      $
    === (2)
      水的凝固点 $T = T_0 - 0.01$，计算得：
      $
        t = ln (273.15) - ln(273.16) + 273.16 approx #(calc.ln(273.15) - calc.ln(273.16) + 273.16)
      $
      水的沸点 $T = T_0 + 99.9$，计算得：
      $
        t = ln (373.15) - ln(273.16) + 273.16 approx #(calc.ln(373.15) - calc.ln(273.16) + 273.16)
      $
  == 7
    待测物质的温度为 $p / p_"tr" T_0 approx #(1.4668 * 273.16)$
  == 11
    考察统一高度初水银面压强相等，初始时：
    $
      p_0 = p
    $
    其中 $p$ 是左侧气体压强。操作后：
    $
      p_0 = rho g (h - h') + p'
    $
    其中 $p'$ 是右侧气体压强。以及气体状态方程可得：
    $
      p a = p' (a + h')
    $
    因此：
    $
      rho g h' = rho g h + a/(a + h') p_0 - p_0 = rho g h - h'/(a + h') p_0\
      rho g h'^2 + rho g a h' = rho g a h  + rho g h h' - p_0 h'\
      rho g h'^2 + (rho g a - rho g h + p_0) h' - rho g a h = 0\
      h' = (-(rho g a - rho g h + p_0) plus.minus sqrt((rho g a - rho g h + p_0)^2 + 4 rho^2 g^2 a h)) / (2 rho g)
    $
    其中 $plus.minus$ 只能取 $+$，否则 $h' < 0$，与水银减少的情形不符。
  == 15
    气球受到的浮力为：
    $
      rho g V
    $
    大气的压强约为：
    $
      p = n/v R T = n/m m/v R T = 1/M_m rho R T
    $
    而气球与大气压强平衡：
    $
      p V = n_1 R T = 1/M_m rho R T V\
      rho V = n_1 M_m
    $
    这是一定值，说明浮力与高度无关
  == 17
    设瓶内有 $n$ mol 氧气，$v_0 = 32 L, p_0 = 130 "atm"$  相当于将氧气分成两份 $n_1, n_2$，前者体积为 $v_0$，压强为 $p_1 = 10 "atm"$，后者体积为 $v_2$（待求），压强为 $p_2 = 1 "atm"$。则：
    $
      p_2 v_2 = n_2 R T\
      p_1 v_0 = n_1 R T\
      n_1 + n_2 = n\
      p_0 v_0 = n R T\
      p_0 v_0 = p_1 v_0 + p_2 v_2 => v_2 = (p_0 - p_1)/p_2 v_0 = #(120 * 32) L
    $
    因此总共可以使用 $9$ 天（不足第 $10$ 天使用） 
  == 21
    === (1)
      深度为 $h$ 时，气体的总压强为：
      $
        p = p_0 + rho g h
      $
      对于理想气体的混合而言，氧气的体积比就是其物质的量比，也是其分压比。因此氧气分压为 $0.2 "MPa"$ 时，有：
      $
        rho g h + p_0 = 0.2/0.21 "MPa"\
        h = (0.2/0.21 - p_0)/(rho g) approx #( ((0.2/0.21 - 0.1) * 1e6)/(1025 * 9.8)) m
      $
    === (2)
      此时总压强为：
      $
        p = rho g h + p_0 = #((1025 * 200 * 9.8)/1e6 + 0.1) "MPa"
      $
      氧气分压为：
      $
        0.03 p = #((0.03 * ((1025 * 200 * 9.8)/1e6 + 0.1))) "MPa"
      $
  == 25 
    #let p1v = 1e-5 * 1360 * 9.8
    #let Vv = 11.2 / 1000
    #let p2v = 1e-2 * 1360 * 9.8
    #let T1v = 273.15 + 25
    #let T2v = 273.15 + 300
    设原来自由的气体分子有 $n_1 "mol"$，附在器壁上的有 $n_2 "mol"$，则有：
    $
      p_1 V = n_1 R T_1
    $
    加热后：
    $
      p_2 V = (n_1 + n_2) R T_2\
      n_2 = (p_2 V)/(R T_2) - n_1 = (p_2 V)/(R T_2) - (p_1 V)/(R T_1) = #((p2v * Vv)/(Rv * T2v) - (p1v * Vv)/(Rv * T1v)) "mol"
    $
    （假设室温为 $25 degree C$?）
  == 27
    #let e0 = 1/2 * 0.05 * (200 * 200)
    分子定向运动总动能为：
    $
      E = 1/2 m v_0^2 = #e0 J
    $
    转换前，有：
    $
      epsilon_1 = 3/2 k T_1
    $
    转换后，有：
    $
      epsilon_2 = 3/2 k T_2
    $
    以及：
    #let epd = 1000 / (0.05 * 6.02 / 4)
    $
      E = (epsilon_2 - epsilon_1) N = (epsilon_2 - epsilon_1) m / m_n N_A\
      epsilon_2 - epsilon_1 = E / (m / m_n N_A) = #epd * 10^(-23) J\
      T_2 - T_1 = 2/3 1/k (epsilon_2 - epsilon_1) = #(2 / 3 *  1 / (1.38) * epd) K\
      Delta p = 1/V n R (T_2 - T_1) = #((0.05 / 4) * Rv * (2 / 3 *  1 / (1.38) * epd) / 0.01) "Pa"
    $
  == 30 
    #let av = 1.369
    #let bv = 0.0315
    #let nv = 0.8 / 32
    $
      (p + a / (V^2 / n^2)) (V - b n) = n R T\
      p = (n R T)/(V - b n) - (V^2 / n^2)/a = #((nv * Rv * (27 + 273.15))/(20 - bv * nv) - av / calc.pow(20/ nv, 2) * 101) "kPa"
    $
    若使用理想气体方程：
    $
      p = (n R T)/V = #((nv * Rv * (27 + 273.15))/20) "kPa"
    $
  == 31
    范德瓦尔斯方程为：
    $
      (p_v + a / (V^2)) (V - b) = R T
    $
    理想气体方程为：
    $
      p_1 V = R T
    $
    就有：
    $
      p_v = (R T)/(V - b) - a / (V^2) \
      p_v - p_1 = (R T)/(V - b) - (R T)/V - a / (V^2) = (R T b)/(V (V - b)) - a / (V^2) >= (R T b)/V^2 - a / V^2
    $
    因此 $T >= a / (R b)$ 时，一定有 $p_v >= p_1$
= 2
  #let vbar = $overline(v)$
  == 1
    === 1
    //   #canvas(
    // {
    //   plot.plot(
    //     size: (13, 10),
    //     // x-tick-step: 0.5,
    //     y-tick-step: 1,
    //     y-min:0, 
    //     y-max: 3,
    //     {
    //       plot.add(
    //         domain:(0, 5),
    //         (x => if x > 3 {0} else {1 / 3}),
    //         samples: 100,
    //         )
    //     },
    //     )
    //   }
    // )
    === 2
      $v_0 C = 1 => C = 1/v_0$
    === 3
      $
        overline(v) = integral_0^v_0 v dot 1/v_0 dif v = 1/2 v_0 
      $
  == 2
    $
      vbar = integral_(v_1)^(v_2) v f(v) dif v
    $
  == 3
    $
      overline(1/v) = integral_0^infinity 1/v f(v) dif v = integral_0^infinity 1/v 4 pi v^2 (2 pi (k T)/m )^(- 3/2) exp(-v^2/((2 k T) / m)) dif v\
      = 2 pi (2 pi (k T)/m )^(- 3/2) integral_0^infinity exp(- v^2/((2 k T) / m)) dif v^2\
      = 2 pi (2 pi (k T)/m )^(- 3/2) (2 k T)/m\
      = 2 (2 pi (k T)/m) ^(- 1/2)
    $
  == 5
    最概然速率：
    $
      der(4 pi v^2 (2 pi (k T)/m )^(- 3/2) exp(-v^2/((2 k T) / m)), v) = 0\
      der(v^2 exp(-v^2/((2 k T) / m)), v) = 0\
      2 v exp(-v^2/((2 k T) / m)) - v^2 exp(-v^2/((2 k T) / m)) (2 v / ((2 k T) / m)) = 0\
      2 - v^2 m / (k T) = 0 => v = sqrt((2 k T) / m)
    $
    平均速率：
    $
      vbar = integral_0^infinity v 4 pi v^2 (2 pi (k T)/m )^(- 3/2) exp(-v^2/((2 k T) / m)) dif v\
      = 4 pi (2 pi (k T)/m )^(- 3/2) integral_0^infinity v^3 exp(-v^2/((2 k T) / m)) dif v\
      = 2 pi (2 pi (k T)/m )^(- 3/2) integral_0^infinity v^2 exp(-v^2/((2 k T) / m)) dif v^2\
      = 2 pi (2 pi (k T)/m )^(- 3/2) integral_0^infinity v exp(-v/((2 k T) / m)) dif v\
      = (2 pi)^(-1/2) 4 ((k T)/m )^(1/2) integral_0^infinity v/((2 k T)/m) exp(-v/((2 k T) / m)) dif v/((2 k T)/m)\
      = (2 pi)^(-1/2) 4 ((k T)/m )^(1/2) integral_0^infinity v exp(-v) dif v\
      = (2 pi)^(-1/2) 4 ((k T)/m )^(1/2)\
      = sqrt((8 k T) / (pi m))

    $
    方均根速率：
    $
      overline(v^2) = integral_0^infinity v^2 4 pi v^2 (2 pi (k T)/m )^(- 3/2) exp(-v^2/((2 k T) / m)) dif v\
      = 4 pi (2 pi (k T)/m )^(- 1) integral_0^infinity v^4 (2 pi (k T)/m )^(- 1/2) exp(-v^2/((2 k T) / m)) dif v\
      = 2 pi (2 pi (k T)/m )^(- 1) integral_(-infinity)^infinity v^4 (2 pi (k T)/m )^(- 1/2) exp(-v^2/((2 k T) / m)) dif v\
      = 3 (k T) / m\
      sqrt(overline(v^2)) = sqrt(3 (k T) / m)
    $
  == 9
    #let Tv = 300
    #let mv = 32 / 6.02 * 1e-23
    最概然速率为：
    $
      sqrt((2 k T)/m) = #(calc.sqrt((2 * kv * Tv) / mv)) "m/s"
    $
    平均速率为：
    $
      sqrt((8 k T)/(pi m)) = #(calc.sqrt((8 * kv * Tv) / (3.14 * mv))) "m/s"
    $
    方均根速率为：
    $
      sqrt(3 (k T)/m) = #(calc.sqrt((3 * kv * Tv) / mv)) "m/s"
    $
  == 13
    取一小段时间 $t$，该时间段内，通过小孔的分子个数为：
    $
      omega t / mu N_A
    $
    这些分子的总计冲量为：
    $
      2 omega t / mu N_A m overline(v_x^+)
    $
    这里 $overline(v_x^+)$ 是 $x$ 正方向粒子的平均速度，事实上，也就是粒子在 $x$ 方向上的平均速率。由麦克斯韦分布律，我们知道：
    $
      v_x tilde N(0, (k T)/m) => overline(v_x^+) = integral_(0)^(infinity) v 1/sqrt(2 pi sigma^2) e^(-1/(2 sigma^2) v^2) dif v\
      = 1/2 sqrt(1/(2 pi sigma^2)) integral_0^infinity e^(-1/(2 sigma^2) v^2) dif v^2\ 
      = 1/2 sqrt(1/(2 pi sigma^2)) integral_0^infinity e^(-1/(2 sigma^2) v) dif v\ 
      = 1/2 sqrt((2 sigma^2)/(pi)) integral_0^infinity e^(-1/(2 sigma^2) v) dif 1/(2 sigma^2) v\ 
      = sqrt((sigma^2)/(2 pi))\ 
    $
    因此单位时间内，小孔受到的冲量为：
    $
      2 omega t / mu N_A m sqrt((k T)/(2 pi m)) = omega sqrt((k T N_A^2 m)/(2 pi))/(mu) t\ 
      = omega sqrt((2 R T N_A m)/(pi))/(mu) t\
      = omega sqrt((2 R T mu)/(pi))/(mu) t\
      = omega sqrt((2 R T)/(pi))/sqrt(mu) t\
    $
    因此压强为：
    $
      p = omega sqrt((R T)/(2 pi))/(sqrt(mu) S)
    $
    如果气压较高或者容器壁较厚，在开孔处分子之间的相互作用将会十分剧烈，导致结果有所偏离。
  == 15
    有：
    $
      p_1 = p_0 e^(- (m g h)/(k T)) = p_0 e^(- (m_n g h)/(R T))\
      (R T)/(m_n g) ln p_1/p_0 = - h\
      h = (R T)/(m_n g) ln p_0/p_1 = #(Rv * (5 + 273.15)/(28.97e-3 * 9.8) * calc.ln(10/7.8)) m 
    $
  == 19
    熟知平动动能为：
    $
      3/2 k T = #num(3/2 * kv * (273.15 + 27), fixed: -23) "J"
    $
    氧分子看作刚性双原子分子，则转动自由度为 $2$，转动动能为：
    $
      2 / 2 k T = #num(1 * kv * (273.15 + 27), fixed: -23) "J"
    $
  == 23
    相同质量混合气体的比定体热容两者的平均，也就是：
    $
      1/2 (1/2(3/18 + 5/2 * 1/16))
    $
  == 25
    $
      ln (Omega' / Omega) = sum_i (N'_i ln N'_i - N_i ln N_i) + sum_i (N'_i - N_i) ln g_i\
      approx sum_i (ln N_i + 1)(N_i' - N_i) + sum_i 10^(-5) N_i ln g_i\
      = sum_i 10^(-5) (ln N_i + 1) N_i + sum_i 10^(-5) N_i ln g_i\
    $

