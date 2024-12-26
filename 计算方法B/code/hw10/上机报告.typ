#import "../../../template.typ": *
#show: note.with(
  title: "作业10",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
本次上机作业由于涉及求导，计算比较负责，选择编写 Mathematica 程序进行计算，代码及结果在`上机结果.pdf`中，可以看出在 Waston 函数上，大部分方法表现都十分糟糕，只有最速下降法能保证结果以比较慢的速度收敛；而在 Discrete boundary value problem 上，所有方法都能收敛，牛顿法和拟牛顿法表现出了最好的收敛速度，最速下降法相较而言收敛速度较慢。