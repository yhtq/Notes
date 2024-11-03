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
本次作业主要是利用幂法解多项式的模最大根，结果如下：
#block[
#output
]

其中迭代终止条件设置为 $abs(lambda_k - lambda_(k - 1)) < 10^(-8) abs(lambda_k)$，可以看到幂法以非常快的速度收敛，效果很好。