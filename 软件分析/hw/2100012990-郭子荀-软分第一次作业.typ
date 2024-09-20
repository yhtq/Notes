#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业12",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1.
  是一种下近似
  - 对于可能抛出异常的程序，其必在某一个输入抛出异常，这个输入一定会被遍历到。然而异常未必在前一百句抛出，因此该算法无法确定所有可能抛出异常的程序。
  - 另一方面，若某个程序被该算法检查到抛出异常，则该程序当然会抛出异常。
  因此该算法只能回答“是”或“不知道”，是下近似。