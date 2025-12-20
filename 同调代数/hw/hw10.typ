#import "../../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "作业10",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
我们有自然的交换图：
#align(center)[#commutative-diagram(
node((0, 0), $0$, 1),
node((0, 1), $F^(p - 1)$, 2),
node((0, 2), $F^p$, 3),
node((0, 3), $F^p quo F^(p - 1)$, 4),
node((0, 4), $0$, 5),
node((1, 0), $0$, 6),
node((1, 1), $F^(p - 1) quo F^(p - 2)$, 7),
node((1, 2), $F^p quo F^(p - 2)$, 8),
node((1, 3), $F^p quo F^(p - 1)$, 9),
node((1, 4), $0$, 10),
arr(1, 2, $$),
arr(2, 3, $$),
arr(3, 4, $$),
arr(4, 5, $$),
arr(6, 7, $$),
arr(7, 8, $$),
arr(8, 9, $$),
arr(9, 10, $$),
arr(2, 7, $$),
arr(3, 8, $$),
arr(4, 9, $$),
)]
根据连接同态的自然性，就有：
#align(center)[#commutative-diagram(
// node((0, 0), $H_(p + q - 1) (F^p quo F^(p - 1))$, 1),
node((0, 1), $H_(p + q) (F^(p - 1))$, 2),
node((0, 2), $H_(p + q) (F^p)$, 3),
node((0, 3), $H_(p + q) (F^p quo F^(p - 1))$, 4),
node((0, 4), $H_(p + q - 1) (F^(p - 1))$, 5),
// node((1, 0), $H_(p + q - 1) (F^p quo F^(p - 1))$, 6),
node((1, 1), $H_(p + q) (F^(p - 1) quo F^(p - 2))$, 7),
node((1, 2), $H_(p + q) (F^p quo F^(p - 2))$, 8),
node((1, 3), $H_(p + q) (F^p quo F^(p - 1))$, 9),
node((1, 4), $H_(p + q - 1) (F^(p - 1) quo F^(p - 2))$, 10),
arr(2, 3, $$),
arr(3, 4, $$),
arr(4, 5, $$),
arr(7, 8, $$),
arr(8, 9, $$),
arr(9, 10, $$),
arr(2, 7, $$),
arr(3, 8, $$),
arr(4, 9, $id$, bij_str),
arr(5, 10, $$)
)]
立得结论。