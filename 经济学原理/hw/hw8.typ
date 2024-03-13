#import "../../template.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withTitle: true
)
= C 
  #answer[
    边际成本即为新增加的成本，也就是一天的食宿和泡温泉
  ]
= A 或 B
  #answer[
    只要边际成本大于平均成本，平均成本就会上升
  ]
= 
  (1)#answer[
    当 $k = 100$ 时，有 $q = 20l, l = 1/20 q$，成本函数为：
    $
    c = r k + w l = 100 + 1/5 q
    $
    平均成本函数为：
    $
    c_("average") = c/q = 100/q + 1/5
    $
  ]
  (2)#answer[
    边际成本函数为：
    $
    c_(M) = der(c, q) = 1/5
    $
    分别带入 $25, 50, 100$，可以求得短期平均成本和短期边际成本：
    #table(
      columns: 4,
      [], [$25$],[$50$],[$100$],
      [SAC], [$4.2$], [$2.2$], [$1.2$],
      [SMC], [$0.2$], [$0.2$], [$0.2$]
    )
  ]
  (3)#align(center,image("image/image4.png", width: 200pt))
  (4) 它们在某种意义上的无穷远点相交。
  #answer[
    注意到：
    $
    der("SMC", q) = der(c/q, q) = (q der(c, q) - c)/q^2 = (q "SAC" - c)/q^2
     = ("SAC" - "SMC")/q
    $
    换言之，SAC 曲线与 SMC 曲线的交点一定满足 $der("SMC", q) = 0$，而由于平均成本函数往往呈现先降低再升高的趋势，因此导数为零的点往往是最小值点。
  ]