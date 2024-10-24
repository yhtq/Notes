#import "../../../template.typ": *
#show: note.with(
  title: "上机报告",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let output = read("output")
本次作业主要是利用各种古典迭代法解线性方程组，对于不同参数、数据和 SOR 方法中不同 omega 选取的测试如下：\
#block[
#output
]

由于不同方法的迭代矩阵各不相同，误差估计比较复杂，因此这里迭代终止条件简单的设置为前后两次计算的差小于其中一个向量。 $L_infinity$ norm 的 $10^(-4)$ 倍。在几组实验中，可以验证矩阵 $A$ 满足不可约对角占优条件，因此 G-S 迭代和 Jacobi 迭代总是收敛的。同时，G-S 迭代都略快于 Jacobi 迭代，而 SOR 方法在选取合适的 $omega$ 后，迭代次数最少，速度最快。然而，不合适的 $omega$ 也会导致 SOR 方法的迭代次数增加，甚至无法收敛。\