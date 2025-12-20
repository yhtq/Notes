#import "../../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
设 $x$ 是齐 $n$ 次元，则：
$
  &partial partial (x tensorProduct y)\
  &= partial (partial x tensorProduct y + (-1)^n x tensorProduct partial y)\
  &= (partial partial x) tensorProduct y + (-1)^(n - 1) partial x tensorProduct partial y +  (-1)^n partial (x tensorProduct partial y)\
  &= (-1)^(n - 1) partial x tensorProduct partial y + (-1)^n partial (x tensorProduct partial y)\
  &= (-1)^(n - 1) partial x tensorProduct partial y + (-1)^n (partial x tensorProduct partial y + (-1)^n x tensorProduct partial partial y)\
  &= (-1)^(n - 1) partial x tensorProduct partial y + (-1)^n partial x tensorProduct partial y\
  &= 0
$