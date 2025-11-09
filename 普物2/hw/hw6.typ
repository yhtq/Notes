#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "../../scientific.typ": *
#show: note.with(
  title: "作业3, 4",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
= 光学第一章
  == 1
    有：
    $
      lambda f = c
    $
    真空中，$f = 4.5 times 10^14$ Hz 时，一定有：
    $
      lambda = c / f = #scientificShow(3e8 / 4.5e14) m
    $
    若折射率为 $1.5$，则传播速率为：
    $
      v = c / 1.5 = #scientificShow(3e8 / 1.5) "m/s"
    $
  == 3
    波形个数为：
    $
      #scientificShow(0.11e-3 / 5500e-10)
    $
    折射率变化后为：
    $
      #scientificShow(0.11e-3 / 5500e-10 * 1.46)
    $
  == 5
    根据方程可得，平面：
    $
      sqrt(3)/2 x + 1/2 z = C
    $
    是一个等相位面，因此传播方向就是法向量：
    $
      vec(sqrt(3)/2, 0, 1/2)
    $
    对于给定点，振动方程为：
    $
      U = A cos(omega t - 2pi (3 + 9/2))\
      = A cos(omega t - pi)
    $
    因此恰好落后相位 $pi$，原点振幅为 $A$  时，其振幅恰为 $- A$ 
  == 10
    对于反射情形，不难验证平行光束的传播路径经过对称、平移后是重合的，因此当然当然光程相同。

    对于折射情形，设入射角为 $theta_1$，折射角为 $theta_2$，光束折射点间距离为 $d$，则折射前路径差为：
    $
      s_1 = d sin theta_1
    $
    折射后路径差为：
    $
      s_2 = d sin theta_2
    $
    显然：
    $
      s_1/s_2 = (sin theta_1) / (sin theta_2) = v_1 / v_2
    $
    因此光程相同
= 第三章
  == 1
    真空中相邻条纹的间距为：
    $
      D/d lambda = #scientificShow(
        100e-2 / 1e-3 * 6328e-10
      ) "m"
    $
    水中为：
    $
      n D /d lambda = #scientificShow(
        1.33 * 100e-2 / 1e-3 * 6328e-10
      ) "m"
    $
  == 2
    相当于说相邻条纹间距为 $0.344$ cm，因此：
    $
      Delta = D/d lambda\
      lambda = d / D Delta = #scientificShow(
        0.342e-6 / 2 * 0.344e-3
      )
    $
  == 3
    设瓶后到屏幕的距离为 $D_2$，考虑双缝上侧根据几何关系有：
    $
      s_1 = D_1 / (cos theta_1)\
      s_2 = D_2 / (cos theta_2)\
      D_1 tan theta_1 + D_2 tan theta_2 = x - d/2
    $
    其中 $s_1, s_2$ 分别是在瓶中，从瓶到屏幕的距离。由于 $x, d$ 较小，因此 $theta_1, theta_2$ 也较小，近似认为：
    $
      tan theta_i approx sin theta_i\
      1/(cos theta_i) = sqrt(1 + tan^2 theta_i) approx 1 + 1/2 theta_i^2 approx 1 + 1/2 sin^2 theta_i
    $
    则有：
    $
      D_1 n sin theta_2 + D_2 sin theta_2 = x - d/2\
      sin theta_2 = (x - d/2) / (D_1 n + D_2)\
      sin theta_1 = n sin theta_2 = n (x - d/2) / (D_1 n + D_2)
    $
    总光程为：
    $
      n s_1 + s_2 = n D_1 (1 + 1/2 (n (x - d/2) / (D_1 n + D_2))^2) + D_2 (1 + 1/2 ((x - d/2) / (D_1 n + D_2))^2)\
    $
    类似的，下方光程为：
    $
      n' s_1 + s_2 = n' D_1 (1 + 1/2 (n' (x + d/2) / (D_1 n' + D_2))^2) + D_2 (1 + 1/2 ((x + d/2) / (D_1 n' + D_2))^2)\
    $
    光程差为:
    $
      Delta = n^3 (D_1 d x)/(D_1 n + D_2)^2 + (D_2 d x)/(D_1 n + D_2)^2\ 
    $
  == 5
    相邻暗纹间距正比于波长，因此：
    $
      lambda' = Delta / Delta' lambda = #scientificShow(0.22 / 0.25 * 5893e-10) "m"
    $
  == 6
    根据等厚干涉公式，有：
    $
      l = lambda / (2 alpha)\
      alpha = lambda / (2 l)\
      d = s tan alpha approx s alpha = s lambda / (2 l)
      = #scientificShow(12.5e-2 * 5460e-10 / (2 * 1.5e-6)) "m"
    $
  == 8
    工件表面中轴有一高度均匀的凹槽或凸槽，使得干涉条纹发生移动。根据等厚干涉的公式：
    $
      b = lambda / (2 alpha)
    $
    假设中部下凹，图表明向左平移 $a$，也即相较原平面的厚度减少 $a tan alpha approx a alpha$  时，实际厚度（补上凹槽深度 $d$ ）恰与之前高度相同。换言之：
    $
      d = a alpha = a lambda / (2 b)
    $
    假设中部上凸，结果是对称的，同样有：
    $
      d = a alpha = a lambda / (2 b)
    $
  == 10
    根据公式有：
    $
      R = (r'^2 - r^2)/ (10 lambda) = #scientificShow((calc.pow(1.7e-6 / 2, 2) - calc.pow(0.7e-6 / 2, 2)) / (10 * 589e-9) * 1e6) "mm"
    $
    折射率改变后，亮纹半径满足：
    $
      r^2 = 1/n R (k + 1/2) lambda 
    $
    换言之，半径缩小为原来的 $1/sqrt(n)$，直径也等比例缩小，因此新直径为：
    $
      #scientificShow(0.7 / calc.sqrt(1.33)) "mm"\
      #scientificShow(1.7 / calc.sqrt(1.33)) "mm"
    $
  == 12
    光程差为：
    $
      Delta = 2 n h + lambda / 2 = ((2 n h) / lambda + 1/2) lambda
    $
    熟知，当：
    $
      {(2 n h) / lambda + 1/2} in [0, 1/4] union [3/4, 1)\
      <=> {(2 n h) / lambda} in [1/4, 3/4]
    $
    时，光线被增强。反之，当上式不成立时，光线被削弱。
  == 14
    光程改变总计为：
    $
      2 n L - 2 L
    $
    发生 $210$ 次周期性变化意味着光程应为 $210$ 个波长，也即：
    $
      2 (n - 1) L = 210 lambda\
      n = 1 + 210 lambda / (2 L) = #scientificShow(
        1 + 210 * 579e-9 / (2 * 2e-2)
      )
    $
  == 15
    看到亮环说明是等倾干涉，也即反射镜之间（等价于）平行。移动后，$10$ 个条纹消失，意味着光程增加 $10$ 个波长，反射镜距离增加 $5$ 个波长，因此：
    $
      d = 5 lambda = #scientificShow(5 * 5893e-10) "m"
    $
    设开始时中心亮点的级数为 $k_0$，则有：
    $
      2 h = k_0 lambda
    $
    视场内光线相应入射角从 $pi/2$ 减小至 $gamma_0$ 的过程中：
    $
      2 h cos gamma = (k_0 cos gamma) lambda
    $
    经过 $k_0 lambda, (k_0 - 1) lambda, ..., (k_0 - 10) lambda$，这就是说：
    $
      k_0 (cos gamma_0) in (k_0 - 11, k_0 - 10]\
      k_0 (1 - cos gamma_0) in [10, 11)\
      k_0 in [10 / (1 - cos gamma_0), 11 / (1 - cos gamma_0))
    $
    移动后，中心亮点级数变为 $k_0 - 10$，同样的，光程经过：
    $
      (k_0 - 10) lambda, (k_0 - 11) lambda, ..., (k_0 - 15) lambda
    $
    也就是说：
    $
      (k_0 - 10) (cos gamma_0) in (k_0 - 16, k_0 - 15]\
      (k_0 - 10) (1 - cos gamma_0) in [5, 6)\
      k_0 in [5 / (1 - cos gamma_0) + 10, 6 / (1 - cos gamma_0) + 10)
    $
    可以得到：
    $
      11 / (1 - cos gamma_0) > 5 / (1 - cos gamma_0) + 10\
      6/(1 - cos gamma_0) > 10\
      1/(1 - cos gamma_0) > 5/3\
      10/(1 - cos gamma_0) < 6/(1 - cos gamma_0) + 10\
      1/(1 - cos gamma_0) < 5/2
    $
    分别代回，可以得到：
    $
      k_0 in (50/3, 55/2)\
      k_0 in (25/3 + 10, 15 + 10)
    $
    $k_0$ 可能取 $19, 20, 21, 22, 23, 24$ 级其中之一。事实上这是线性规划问题，上面这些值确实都是可行解。显然反射镜移动后，最外圈亮环的级数为 $k_0 - 15$