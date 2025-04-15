#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
学习率是沿负梯度方向下降的幅度。显然学习率小时，梯度下降比较谨慎，容易收敛但容易陷入局部最优。学习率较大时，梯度下降比较激进，容易跳出局部最优，但也更可能发散。