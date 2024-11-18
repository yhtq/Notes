#import "../../../template.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let rough(x) = {
  if x == 0{
    3
  }
  else{
    1 / (x * x)
  }
  }
#let laugrange(f, x, xs) = {
    let res = 0.0
    for xi in xs{
      let l = 1
      for xj in xs{
        if xj != xi{
          l *= (x - xj) / (xi - xj)
        }
      }
      res += l * f(xi)
    }
    res
  }
#let divided_difference(f, xs) = {
  let n = xs.len()
  if n == 1 {
    f(xs.at(0))
  }
  else{
    (divided_difference(f, xs.slice(0, -1)) - divided_difference(f, xs.slice(1))) / (xs.first() - xs.last())
  }
}
#let Newton(f, x, xs) = {
  let n = xs.len()
  let res = f(xs.at(0))
  for i in range(2, n + 1){
    let term = divided_difference(f, xs.slice(0, i))
    for j in range(i - 1){
      term *= (x - xs.at(j))
    }
    res += term
  }
  res
}
#let f_t = (x => x * x + 1)

#let piecewise_linear_base(x0, x1, x2, x) = {
  if x0 <= x and x <= x1 and x0 != x1 {
    (x - x0) / (x1 - x0)
  }
  else if x1 <= x and x <= x2 and x1 != x2 {
    (x2 - x) / (x2 - x1)
  }
  else{
    0
  }
}
#let piecewise_linear(f, x, xs) = {
  let n = xs.len()
  let res = 0
  res += piecewise_linear_base(xs.at(0), xs.at(0), xs.at(1), x) * f(xs.at(0))
  for i in range(0, n - 1){
    res += piecewise_linear_base(xs.at(i - 1), xs.at(i), xs.at(i + 1), x) * f(xs.at(i))
  }
  res += piecewise_linear_base(xs.at(n - 2), xs.at(n - 1), xs.at(n - 1), x) * f(xs.at(n - 1))
  res
}
#let piecewise_hermit_bases(x0, x1, x) = {
  if x0 <= x and x < x1{
    (
      (1 + 2 * (x - x0) / (x1 - x0)) * calc.pow((x - x1)/(x0 - x1), 2),
      (1 + 2 * (x - x1) / (x0 - x1)) * calc.pow((x - x0)/(x1 - x0), 2),
      (x - x0) * calc.pow((x - x1)/(x0 - x1), 2),
      (x - x1) * calc.pow((x - x0)/(x1 - x0), 2)
    )
  }
  else{
    (0, 0, 0, 0)
  }
}
#let piecewise_hermit(f, f_d, xs, x) = {
  xs.windows(2).map(
    x_p => {
      let (x0, x1) = x_p
      let (a0, a1, b0, b1) = piecewise_hermit_bases(x0, x1, x)
      a0 * f(x0) + a1 * f(x1) + b0 * f_d(x0) + b1 * f_d(x1)
    }
  ).sum()
}
#let fd(x) = {2 * x}
#let rough_d(x) = {
  if x == 0{
    0
  }
  else{
    -2 / (1 + x * x)
  }
  }
#let xs = range(11).map(x => x - 5)
#let xsl = range(21).map(x => 5 * calc.cos((2 * x + 1) * calc.pi / 42))
本次代码作业直接使用 Typst 完成，源代码就在 `上机作业.typ` 文件之中，代码力求简洁，在性能上还有很大的优化空间。结果如下：（其中 Newton 插值的图像几乎完全和 Lagrange 插值重合，因此难以看到）
#canvas(
  {
    plot.plot(
      size: (13, 10),
      // x-tick-step: 0.5,
      y-tick-step: 1,
      y-min:-2, 
      y-max: 10,
      {
        plot.add(
          domain:(-5, 5),
          (rough),
          samples: 100,
          label: [Rough 函数],
          )
        plot.add(
          domain: (-5, 5),
          (x => Newton(rough, x, xs)),
          samples: 1000,
          label: [Newton 插值],
        )
        plot.add(
          domain:(-5, 5),
          (x => laugrange(rough, x, xs)),
          samples: 1000,
          label: [Lagrange 插值],
          )
        plot.add(
          domain:(-5, 5),
          (x => piecewise_linear(rough, x, xs)),
          samples: 50,
          label: [分段线性插值],
          )
        plot.add(
          domain:(-5, 5),
          (x => piecewise_hermit(rough, rough_d, xs, x)),
          samples: 2000,
          label: [分段 Hermite 插值],
          )
      },
    )
  }
)

可见对于 Rough 函数，任何多项式逼近和分段多项式逼近在 $0$ 附近都不能成功（理论上这是显然的）。同时，Lagrange 插值和 Newton 插值在大部分区间上的表现都相当糟糕，而分段线性和分段 Hermite 插值在稍微远离 $0$ 的区间上表现都相当好。