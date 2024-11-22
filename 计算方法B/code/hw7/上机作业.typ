#import "../../../template.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let midpoint(f, a, b, n) = {
  let h = (b - a) / n
  let res = 0.0
  for i in range(n){
    res += f(a + (i + 0.5) * h)
  }
  res *= h
  res
}
#let trapezoidal(f, a, b, n) = {
  let h = (b - a) / n
  let res = 0
  for i in range(n){
    res += f(a + i * h) + f(a + (i + 1) * h)
  }
  res *= h / 2
  res
}
#let simpson(f, a, b, n) = {
  let h = (b - a) / n
  let res = 0
  for i in range(0, n){
    res += f(a + i * h) + 4 * f(a + (i + 0.5) * h) + f(a + (i + 1) * h)
  }
  res *= h / 6
  res
}
= 4
复合求积公式的结果：
#let toln1(x) = {
  let (x1, x2) = x
  if x2 == 0.0 {
     (calc.log(x1), calc.log(1e-15))
  }
  else{
    ((calc.log(x1)), (calc.log(x2)))
  }
}
#let fx = (x => 4 / (1 + x * x)) 
#let ns = range(10, 3000, step: 100)
#let hs = ns.map(i => 1 / i)
#let midpoint_errors = hs.zip(ns.map(
  n => calc.abs(midpoint(fx, 0.0, 1.0, n) - calc.pi)
  ))
#let trapezoidal_errors = hs.zip(ns.map(
  n => calc.abs(trapezoidal(fx, 0.0, 1.0, n) - calc.pi)
  ))
#let simpson_errors = hs.zip(ns.map(
  n => calc.abs(simpson(fx, 0.0, 1.0, n) - calc.pi)
  ))
#canvas(
  {
    plot.plot(
      size: (13, 10),
      x-label: [$"log"(h)$],
      y-label: [$"log"("error")$],
      // x-tick-step: 0.5,
      // y-tick-step: 1,
      {
        plot.add(
          midpoint_errors.map(toln1),
          label: [Midpoint],
        )
        plot.add(
          trapezoidal_errors.map(toln1),
          label: [Trapezoidal],
        )
        plot.add(
          simpson_errors.map(toln1),
          label: [Simpson],
        )
      }
    )
  }
)
可见在计算范围内，中点公式与梯形公式的误差仍在下降，而辛普森公式的误差在 $h = 10^(-2)$ 左右达到了机器精度附近，无法再下降了。

#let autoSimp(f, a, b, ans, eps) = {
  let mid = (a + b) / 2
  let l = simpson(f, a, mid, 1)
  let r = simpson(f, mid, b, 1)
  if calc.abs(l + r - ans) < eps {
    (l + r, 2) 
  }
  else{
    let (lr, l_times) = autoSimp(f, a, mid, l, eps)
    let (rr, r_times) = autoSimp(f, mid, b, r, eps)
    (lr + rr, l_times + r_times + 2)
  }
}
#let (ans, times) = autoSimp(fx, 0.0, 1.0, calc.pi, 1e-14)

利用自适应 Simpson 方法，经过 #times 次子区间 Simpson 公式的计算达到了 1e-14 的精度。

= 10
  利用自适应 Simpson 方法计算：
  == (1)
    $
      integral_(D)^() e^(- x y) dif x dif y = integral_0^1 (integral_0^1 e^(- x y) dif x) dif y
    $
    #let fxy(x, y) = calc.exp(- x * y)
    #let fy(y) = (autoSimp(x => fxy(x, y), 0.0, 1.0, 1.0, 1e-14)).at(0)
    #let (ans1, times1) = autoSimp(fy, 0.0, 1.0, 1.0, 1e-14)
    结果为 #ans1
  == (2)
    $
      integral_(D)^() e^(- x y) dif x dif y = integral_(-1)^1 (integral_(-sqrt(1 - y^2))^(sqrt(1 - y^2)) e^(- x y) dif x) dif y
    $
    #let fy2(y) = (autoSimp(x => fxy(x, y), -calc.sqrt(1 - y * y), calc.sqrt(1 - y * y), 1.0, 1e-10)).at(0)
    #let (ans2, times2) = autoSimp(fy2, -1.0, 1.0, 1.0, 1e-10)
    结果为 #ans2


