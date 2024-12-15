#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业14",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= #empty
  给定前条件，则符号执行的符号解释运行本质上就是关系抽象中关系的转换函数，而两者对于分支语句的处理也仅有形式上的不同（关系抽象将关系变为 $(a or not a) -> b$，而符号执行直接拆分成 $a -> b$ 和 $not a -> b$）。两者的精确性当然也是相同的。（事实上如果不考虑循环，两者都是绝对精确的）
= #empty
  如果认为死循环可以使任意后条件满足，答案是肯定的，考虑：
  ```cpp
  assume(pre_cond);
  while(q) {...}
  ensures(post_cond)
  ```
  若要让符号执行的结果出现失误，只能存在具体执行使得 `pre_cond` 为真但执行结束后 `post_cond` 为假的情况。事实上，这意味着该具体执行中循环只执行了有限次，则取此次数为 $l$，只要将循环展开大于 $l$ 层，符号执行理论上就可以分析出后条件不可满足。