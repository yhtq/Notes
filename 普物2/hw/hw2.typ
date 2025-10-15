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
= 3
  == 3.1
    稳定时，有：
    $
      M = integral_("内筒表面") R eta ((R + delta) omega) dif S\
      = 2 pi R^2 L eta (R + delta) omega
    $
    整理即得结论
  == 3.4
    我们有：
    $
      Phi(r) = integral_("半径为" r "的圆柱表面") - kappa T'(r) dif S = - 2 pi kappa r L T'(r)
    $
    由于系统稳定，$Phi(r)$ 对于不同的 $r$ 应该是定值 $Q$，因此：
    $
      - 2 pi kappa r L T'(r) = Q\
      T(r) = - Q/(2 pi kappa L) ln r + C
    $
    而 $T(R_1) = T_1, T(R_2) = T_2$，因此：
    $
      T_1 - T_2 = Q/(2 pi kappa L) ln(R_2/R_1)
    $
    整理即得所求
  == 3.9
    对于某个气体分子，$Delta t$ 时间内，其扫过的体积为：
    $
      2 pi (d / 2)^2 v Delta t
    $
    所有气体分子扫过的体积为：
    $
      n integral_(0)^(+infinity) 2 pi (d / 2)^2 v Delta t rho(v) dif v
    $
    其中 $rho(v)$ 是速率分布函数。显然，它就是：
    $
      2 pi (d / 2)^2 n vbar Delta t
    $
    对于一个底面积为 $Delta S$ 的电子通路，其体积为：
    $
      Delta S l
    $
    为了达到要求，其中气体分子在单个电子单程时间内扫过的体积不超过总体积的 $10 %$，因此：
    $
      Delta S l >= 10 times 2 pi (d / 2)^2 n vbar l / c\
    $
    其中：
    $
      n = (p V)/(k T) = (p Delta S l)/(k T)
    $
    #let Tv = 300
    因此也就是：
    $
      k T >= 10 times 2 pi (d / 2)^2 p vbar l / c\
      p <= (k T)/(10 times 2 pi (d / 2)^2 vbar l / c)\
      approx #((kv * Tv) / (20 * calc.pi * calc.pow(1.5e-10, 2) * calcAverageSpeedmu(Tv, 29 / 1000) * 2.0e-1 / (3.0e8)) / 1000) "kPa" 
    $
  == 3.11
    由熟知结论有：
    #let lambdaa = (1.89e-5) /  (1/3 * (101e3 * 4e-3) / (Rv * 300) * calcAverageSpeedmu(300, 4e-3))
    $
      1/3 rho vbar overline(lambda) = eta\
      1/3 (p mu)/(R T) vbar overline(lambda) = eta\
      overline(lambda) approx #num(lambdaa, fixed: -7) "m"
    $
    又熟知：
    $
      overline(lambda) = 1 / (sqrt(2) n pi d^2)\
      d = 1 / sqrt(overline(lambda) * sqrt(2) (p)/(k T))\
      = #num((1 / calc.sqrt(lambdaa * calc.sqrt(2) * (101e3) / (kv * Tv))), fixed: -10) m\
    $
  == 3.16
    由状态方程可得 $p' = p, V' = 2 V, T' = 2 T$
    - $
        overline(lambda) = (k T)/(sqrt(2) pi d^2 p)
      $
      变为 $2$ 倍
    - 
      $
        eta = 1/3 rho vbar overline(lambda) = 1/3 (p mu)/(R T) sqrt((8 R T)/(pi mu)) (k T)/(sqrt(2) pi d^2 p)\
      $
      变为 $sqrt(2)$ 倍
    - $
        overline(kappa) = 1/3 rho vbar overline(lambda) c_V\
      $
      由于 $c_V$ 不变，因此变为 $sqrt(2)$ 倍
    - $
        D = 1/3 vbar overline(lambda)
      $
      变为 $2 sqrt(2)$ 倍
  == 3.18
    有：
    $
      overline(x^2) = (k T)/(3 pi a eta) t\
      k = (3 pi a eta overline(x^2)) / t\
      = #num(3 * calc.pi * 0.4e-6 * 2.78e-3 * 3.3e-12 / 10, fixed: -21) "J/K"
    $
= 4
  == 4.1
    === (1)
      $p$ 与 $V$ 成线性关系，做功：
      $
        integral_(V_1)^(V_2) p S dif V = integral_(V_1)^(V_2) k V S dif V = 1/2 k S (V_2^2 - V_1^2)
      $
    === (2)
      $
        p = k T = k (p V)/(n R)\
        V = (n R)/(k)
      $
      是常数，不做功
    === (3)
      $
        V = k T = k (p V)/(n R)\
        p = (n R)/(k)
      $
      是常数，做功为 $(n R)/k (V_2 - V_1)$
  == 4.2
    === (1)
      使用定体热容，有：
      $
        Q = n C_V Delta T = n (3/2 R) (T_2 - T_1) = m/m_n (3/2 R) (T_2 - T_1) = #(0.02 / 4 * 3 / 2 * Rv * 10) "J"\
        W = 0\
        Delta U = Q
      $
    === (2)
      使用定压热容，有：
      $
        Q = n C_p Delta T = n (5/2 R) (T_2 - T_1) = m/m_n (5/2 R) (T_2 - T_1) = #(0.02 / 4 * 5 / 2 * Rv * 10) "J"\
        W = - p Delta V = - n R Delta T = - m/m_n R (T_2 - T_1) = #(-0.02 / 4 * Rv * 10) "J"\
        Delta U = Q + W = #(0.02 / 4 * 5 / 2 * Rv * 10 - 0.02 / 4 * Rv * 10) "J"
      $
    === (3)
      绝热过程中，有：
      $
        W = C_V (T_2 - T_1) m/m_n = #(0.02 / 4 * 3 / 2 * Rv * (27 - 17)) "J"\
        Q = 0\
        Delta U = W
      $
  == 4.4
    绝热过程中，有：
    $
      p V^(gamma) = C where gamma = 5/3
    $
    因此：
    $
      p_1 V_1^(5/3) = p_2 V_2^(5/3)\
    $
    等温过程中，有：
    $
      p V = C
    $
    因此：
    $
      p_3 V_3 = p_2 V_2\
    $
    结合 $p_3 = 2 p_1, V_3 = 2 V_1$ 得：
    $
      p_2 V_2 = 4 p_1 V_1\
      p_2 V_2^(5/3) = p_1 V_1^(5/3)\
      V_2^(2/3) = 1/4 V_1^(2/3)\
      V_2 = 1/8 V_1\
      p_2 = 32 p_1
    $
    气体吸收的热量即为等温膨胀中吸收的热量，它等于：
    $
      Q = - W = integral_(V_2)^(V_3) p dif V = n R T ln (V_3 / V_2) = n R T ln 16
    $
    假设两过程相反，则：
    $
      p_2 V_2 = p_1 V_1\
      p_3 V_3^(5/3) = p_2 V_2^(5/3)\
      p_2 V_2^(5/3) = 2^(8/3) p_1 V_1^(5/3)\
      V_2^(2/3) = 2^(8/3) V_1^(2/3)\
      V_2 = 16 V_1\
      p_2 = 1/16 p_1\
    $
    此时吸收的热量也为 $n R T ln 16$
  == 4.5
    有：
    $
      H = U + p V = (c T - a p T) + p (V_0 + a T + b p)
    $
    定压过程中，有：
    $
      partialDer(U, T) = c - a p\
    $
    定体过程中，有：
    $
      p = 1/b (V - V_0 - a T)\
      U = c T - a/b (V - V_0 - a T) T \
      partialDer(U, T) = c + a^2/b T - a/b(V - V_0 - a T)
    $
  == 4.15
    #let p1v = 1e5
    #let p2v = 5e4
    #let V1v = 2.3 * 1e-3
    #let V2v = 4.1 * 1e-3
    #let nv = (calc.ln(p1v) - calc.ln(p2v)) / (calc.ln(V2v) - calc.ln(V1v))
    #let t1v = 26 + 273.15
    #let nmolv = (p1v * V1v) / (Rv * t1v)
    #let dUv = nmolv * 5 / 2 * Rv * ((p2v * V2v - p1v * V1v) / (nv * Rv))
    #let Wv = (p1v * V1v) / (nv - 1) * (calc.pow((V2v / V1v), (nv - 1)) - 1)
    由题意，有：
    $
      n = (p_1 V_1)/(R T) = #nmolv\
      p_1 V_1^n = p_2 V_2^n\
      ln p_1 + n ln V_1 = ln p_2 + n ln V_2\
      n = (ln p_1 - ln p_2) / (ln V_2 - ln V_1)\
      = nv\
      T_2 - T_1 = (p_2 V_2 - p_1 V_1)/(n R)\
      Delta U = n C_V (T_2 - T_1) = n (5/2 R) (T_2 - T_1) = #dUv "J"\
      W = integral_(V_1)^(V_2) p dif V = integral_(V_1)^(V_2) p_1 (V^n)/(V_1^n) dif V = (p_1 V_1)/(n - 1) ((V_2/V_1)^(n - 1) - 1) = #Wv "J"\
      Q = Delta U - W = #(dUv - Wv) "J"
    $
  == 4.16
    #let p0v = 2e5
    #let V0v = 3e-3
    #let T0v = 300
    #let nmolv = (p0v * V0v) / (Rv * T0v)
    #let Cvv = 5 / 2 * Rv
    #let Cpv = 7 / 2 * Rv
    #let T1v = 500
    #let p1v = p0v
    #let V1v = (nmolv * Rv * T1v) / p1v
    #let W1v = (V1v - V0v) * p1v
    #let Q1v = nmolv * Cpv * (T1v - T0v)
    #let T2v = 250
    #let V2v = V1v
    #let p2v = (nmolv * Rv * T2v) / V2v
    #let W2v = 0
    #let Q2v = nmolv * Cvv * (T2v - T1v)
    #let T3v = 150
    #let p3v = p2v
    #let V3v = (nmolv * Rv * T3v) / p3v
    #let W3v = p2v * (V3v - V2v)
    #let Q3v = nmolv * Cpv * (T3v - T2v)
    #let T4v = 300
    #let V4v = V3v
    #let p4v = (nmolv * Rv * T4v) / V4v
    #let W4v = 0
    #let Q4v = nmolv * Cvv * (T4v - T3v)
    经计算，气体的状态参量为：
    $
      n = #nmolv\
      (p_0, V_0, T_0) = (#p0v "Pa", #V0v m^3, #T0v "K")\
      (p_1, V_1, T_1) = (#p1v "Pa", #V1v m^3, #T1v "K")\
      (p_2, V_2, T_2) = (#p2v "Pa", #V2v m^3, #T2v "K")\
      (p_3, V_3, T_3) = (#p3v "Pa", #V3v m^3, #T3v "K")\
      (p_4, V_4, T_4) = (#p4v "Pa", #V4v m^3, #T4v "K")\
    $
    各过程的功为：
    $
      W_(01) = #W1v "J"\
      W_(12) = #W2v "J"\
      W_(23) = #W3v "J"\
      W_(34) = 0 "J"
    $
    吸收热量为：
    $
      Q_(01) = #Q1v "J"\\

      Q_(12) = #Q2v "J"\
      Q_(23) = #Q3v "J"\
      Q_(34) = #Q4v "J"\
    $
    因此净功为 $200$ J，效率为 $#(200 / (Q1v + Q4v))$
  == 4.17
    由于理想卡诺热机的效率：
    $
      eta = 1 - T_2 / T_1
    $
    因此：
    $
      T_1 = T_2 / (1 - eta) = #(280 / 0.6) "K"\
    $
    - 若低温热源不变，效率提升至 $0.5$ 则高温热源温度应为 $2 T_2 = #(2 * 280) "K"$
    - 若高温热源不变，效率提升至 $0.5$ 则低温热源温度应为 $T_2 = 0.5 T_1 = #(0.5 * (280 / 0.6)) "K"$
  == 4.20
    - 等压过程 $C A$ 中，有：
      $
        W_(C A) = - p_A (V_C - V_A)\
        Q_(C A) = n C_p (T_A - T_C)\
      $
    - 等容过程 $A B$ 中，有：
      $
        W_(A B) = 0\
        Q_(A B) = n C_V (T_B - T_A)\
      $
    - 绝热过程 $B C$ 中，有：
      $
        W_(B C) = integral_(V_B)^(V_C) p dif V = integral_(V_B)^(V_C) p_B V_A^gamma / V^gamma dif V\
        = p_B V_A^gamma / (1 - gamma) (V_C^(1 - gamma) - V_B^(1 - gamma))\
        Q_(B C) = 0\
      $
    因此效率为：
    $
      eta = (W_(C A) + W_(A B) + W_(B C)) / Q_(A B) = (W_(C A) + W_(B C)) / Q_(A B)\
      = ( - p_A (V_C - V_A) + 1/(1 - gamma) p_B V_A^gamma (V_C^(1 - gamma) - V_B^(1 - gamma))) / (n C_V (T_B - T_A))\
      = ( - p_A (V_C - V_A) + 1/(1 - gamma) p_B V_A^gamma (V_C^(1 - gamma) - V_B^(1 - gamma))) / (n j/2 R (T_B - T_A))\
      = ( - p_A (V_C - V_A) + 1/(1 - gamma) p_B V_A^gamma (V_C^(1 - gamma) - V_B^(1 - gamma))) / (1/(gamma - 1) (p_B V_A - p_A V_A))\
      = ( p_B V_A^gamma (V_B^(1 - gamma) - V_C^(1 - gamma)) - (gamma - 1) p_A (V_C - V_A)) /  (p_B V_A - p_A V_A)\
    $
    又因为：
    $
      p_C V_C^gamma = p_A V_C^gamma = p_B V_B^gamma = p_B V_A^gamma\
    $
    上式等于：
    $
      = ( p_A V_C^gamma (V_A^(1 - gamma) - V_C^(1 - gamma)) - (gamma - 1) p_A (V_C - V_A)) /  (p_B V_A - p_A V_A)\
      = ( p_A V_C^gamma (1 - (V_A / V_C)^(gamma - 1)) - (gamma - 1) p_A (V_C V_A^(gamma - 1) - V_A^gamma)) /  (p_A V_C^gamma - p_A V_A^gamma)\
      = ( V_C^gamma (1 - (V_A / V_C)^(gamma - 1)) - (gamma - 1) (V_C V_A^(gamma - 1) - V_A^gamma)) /  (V_C^gamma - V_A^gamma)\
      = ( V_C^gamma  - V_A^(gamma - 1) V_C - (gamma - 1) (V_C V_A^(gamma - 1) - V_A^gamma)) /  (V_C^gamma - V_A^gamma)\
      = 1 - gamma (V_C V_A^(gamma - 1) - V_A^gamma) /  (V_C^gamma - V_A^gamma)\
      = 1 - gamma (V_C / V_A - 1) /  ((V_C / V_A)^gamma - 1)\
    $
    
    // $
    //   (1/(gamma - 1) (p_A V_C - p_B V_A) - p_A (V_C - V_A)) / (n C_V (T_B - T_A))\
    //   = (1/(gamma - 1) (p_A V_C - p_B V_A) - p_A (V_C - V_A)) / ( j/2 (p_B V_A - p_A V_A))
    // $
    // 代入 $(j + 2) / j = gamma$ 得：
    // $
    //   1 + 2/j = gamma, j = 2/(gamma - 1)
    // $
    // 上式等于：
    // $
    //   (1/(gamma - 1) (p_A V_C - p_B V_A) - p_A (V_C - V_A)) / ( 1/(gamma - 1) (p_B V_A - p_A V_A))\
    //   = ((p_A V_C - p_B V_A) - (gamma - 1) p_A (V_C - V_A)) / (p_B V_A - p_A V_A)\
      
    // $
  == 4.22
    $W$ 为正代表外界对气体做功，$Q$ 为正代表气体从外界吸热
    - 等温压缩过程 $1$ 到 $2$ 中有：
      $
        W_(1 2) = - n R T_1 ln (V_2 / V_1) = n R T_1 ln (V_1 / V_2)\
        Q_(1 2) = - W_(1 2) = - n R T_1 ln (V_1 / V_2) < 0
      $
    - 等体降温过程 $2$ 到 $3$ 中有：
      $
        W_(2 3) = 0\
        Q_(2 3) = n C_V (T_2 - T_1) < 0
      $
    - 等温膨胀过程 $3$ 到 $4$ 中有：
      $
        W_(3 4) = - n R T_2 ln (V_4 / V_3) \
        Q_(3 4) = - W_(3 4) = n R T_2 ln (V_4 / V_3) > 0
      $
    - 等体升温过程 $4$ 到 $1$ 中有：
      $
        W_(4 1) = 0\
        Q_(4 1) = n C_V (T_4 - T_1) > 0
      $
      因此致冷效率为：
      $
        (Q_(3 4) + Q_(4 1)) / (W_(1 2) + W_(3 4))\
        = (n R T_2 ln (V_4 / V_3) + n C_V (T_4 - T_1)) / (n R T_1 ln (V_1 / V_2) - n R T_2 ln (V_4 / V_3))\
        = (n R T_2 ln (V_1 / V_2) + n C_V (T_2 - T_1)) / (n R T_1 ln (V_1 / V_2) - n R T_2 ln (V_1 / V_2))\
      $
    == 4.25
      $Q$ 为正代表气体从外界吸热，$W$ 为正代表气体对外界做功
      - 绝热压缩过程 $A B$ 中有：
        $
          Q_(A B) = 0\
        $
      - 等体加热过程 $B C$ 中有：
        $
          W_(B C) = 0\
          Q_(B C) = n C_V (T_C - T_B) > 0
        $
      - 绝热膨胀过程 $C D$ 中有：
        $
          Q_(C D) = 0\
        $
      - 等体放热过程 $D A$ 中有：
        $
          W_(D A) = 0\
          Q_(D A) = n C_V (T_A - T_D) < 0
        $
      因此效率为：
      $
        (Q_(B C) + Q_(D A)) / Q_(B C) = (T_C - T_B + T_A - T_D) / (T_C - T_B)
      $
