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
#let output = read("output.txt")
本次作业主要是利用 Householder 变换实现 QR 分解，并且利用 QR 分解求解线性方程组，并与上次作业的结果进行比较。下面是程序的输出结果：\
#box[
#output
]

可以看到 QR 分解具有较高的数值精度，然而效率较低。不过这里的效率差距明显高于理论值，这里很可能是因为本次编写 QR 分解的程序时，为了实现方便在生成 Householder 矩阵时造成了额外的内存分配和复制。可见代码的简洁和运行效率往往不能兼得。
\