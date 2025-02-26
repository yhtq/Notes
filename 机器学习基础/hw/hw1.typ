#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#let te = "test"
= 
  $
    E (approxVar(R)_te (h_T)) &= E (1/N sum_i L(h(x_i), y_i) \
    &= E (1/N sum_i L(h(x_i), c(x_i)) \
    &= 1/N sum_i E(L(h(x_i), c(x_i)) \
    &= 1/N dot N R(h_T)\
    &= R(h_T)
  $
= 
  交叉验证法和自助法都是通过随机抽样的思想，将数据集尽可能好的分为训练集和测试（验证）集。由于采用了随机抽样，因此都可以重复进行多次以达到更好的稳定性。不同点在于：
  - 交叉验证法基于无放回抽样。会导致选择模型时的数据规模小于最终训练的数据规模，但数据分布总是与原数据集相同的。
  - 自助法基于有放回抽样，可以保证训练的数据规模一致，但其数据分布可能与原数据集不同，当方法对数据分布敏感时不适用。