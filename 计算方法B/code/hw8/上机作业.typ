#import "../../../template.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let EulerMethodStep(xn, yn, fn, h) = yn + h * fn
#let EulerMethod(x0, y0, f, h, n) = {
    let result = (y0,)
    for i in range(1, n){
      let new_y = EulerMethodStep(x0 + i * h, result.last(), f(x0 + i * h, result.last()), h)
      result.push(new_y)
    }
    return result
}
#let ImprovedEulerMethod(x0, y0, f, h, n) = {
    let result = (y0,)
    for i in range(1, n){
      let y_star = EulerMethodStep(x0 + i * h, result.last(), f(x0 + i * h, result.last()), h)
      let new_y = result.last() + h / 2 * (f(x0 + i * h, result.last()) + f(x0 + (i + 1) * h, y_star))
      result.push(new_y)
    }
    return result
}
#let f1(x, y) = - 1 / (x * x) - y / x - y * y
#let xn(n) = range(n).map(i => 1 + i / n)
#let Euler1(n) =  EulerMethod(1, -1, f1, 1 / n, n)
#let ImprovedEuler1(n) =  ImprovedEulerMethod(1, -1, f1, 1 / n, n)
#let N = 50
// #Euler1(100)
// #ImprovedEuler1(100)
#let n_canvas(n) = figure(canvas(
  {
    plot.plot(
      size: (3, 3),
      // x-label: [$"log"(h)$],
      // y-label: [$"log"("error")$],
      x-tick-step: 0.5,
      y-tick-step: 1,
      name: "n = " + str(n),
      {
        plot.add(
          xn(n).zip(Euler1(n)),
          label: [欧拉方法]
        )
        plot.add(
          xn(n).zip(ImprovedEuler1(n)),
          label: [改进欧拉方法]
        )
      }
    )
  }
  ),
  scope: "parent",
  caption: align(center)[*n = $#n$*],
  numbering: none,
  placement: bottom
  )
#table(
  n_canvas(10), n_canvas(20), n_canvas(50), n_canvas(100), 
  columns: 2,
  gutter: auto
  )
可以看出，当 $n$ 较小时，改进欧拉方法获得明显较好的效果。而当 $n$ 较大时，两种方法的效果基本一致。

#image("屏幕截图 2024-12-02 135659.png")
从图上看出，解区间应当是有界的，且会围绕两点运动。

略微调整参数后，得到：
#image("屏幕截图 2024-12-02 182731.png")
解曲线变成无界曲线