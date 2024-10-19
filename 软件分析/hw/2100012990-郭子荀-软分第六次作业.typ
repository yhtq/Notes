#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= #empty
  ```c
  x -= 1;
  y += 1;
  while(y < z){
    x *= -100;
    y += 1;
  }
  ```
  datalog 规则为：
  ```datalog
  out(x, entry, negative)
  out(y, entry, zero)
  out(z, entry, positive)
  out(x, exit, ?)
  out(y, exit, ?)
  out(z, exit, ?)
  edge(entry, 1),
  edge(1, 2),
  edge(2, 3),
  edge(3, 4),
  edge(4, 5),
  edge(5, 3),
  edge(3, exit)
  out(x, 1, positive) :- in(x, 1, positive)
  out(x, 1, zero) :- in(x, 1, positive)
  out(x, 1, negative) :- in(x, 1, negative)
  out(x, 1, negative) :- in(x, 1, zero)
  out(y, 1, s) :- in(y, 1, s)
  out(z, 1, s) :- in(z, 1, s)

  out(v, 3, s) :- in(v, 3, s)

  out(y, 2, positive) :- in(y, 2, positive)
  out(y, 2, positive) :- in(y, 2, zero)
  out(y, 2, negative) :- in(y, 2, negative)
  out(y, 2, zero) :- in(y, 2, negative)
  out(x, 2, s) :- in(x, 2, s)
  out(z, 2, s) :- in(z, 2, s)

  out(x, 4, positive) :- in(x, 4, negative)
  out(x, 4, negative) :- in(x, 4, positive)
  out(x, 4, zero) :- in(x, 4, zero)
  out(y, 4, s) :- in(y, 4, s)
  out(z, 4, s) :- in(z, 4, s)

  out(y, 5, positive) :- in(y, 5, positive)
  out(y, 5, positive) :- in(y, 5, zero)
  out(y, 5, negative) :- in(y, 5, negative)
  out(y, 5, zero) :- in(y, 5, negative)
  out(x, 5, s) :- in(x, 5, s)
  out(z, 5, s) :- in(z, 5, s)

  in(var, v, v1) :- edge(v1, v), out(var, v1, s)
  ```
  这样的分析变得更精确了，例如在该例中，关于 $x$ 最终可以得到：
  ```datalog
  out(x, exit, positive)
  out(x, exit, negative)
  ```
  也就是要么正要么负，但在通常的数据流分析中只能得到 $x$ 为槑
