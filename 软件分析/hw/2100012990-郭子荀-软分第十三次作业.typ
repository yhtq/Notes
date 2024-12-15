#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业13",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
本次选用 SMT Solver 为 CVC。目前支持的理论包括：
    + Theory of arrays
    + Theory of bit-vectors
    + Theory of floating-point numbers
    + Theory of integer arithmetic
    + Theory of real arithmetic
    + Theory of mixed-integer arithmetic
    + Theory of strings
    + Bags
    + Datatypes
    + Finite Fields
    + Separation Logic
    + Sequences
    + Sets and Relations
    + Strings
    + Transcendentals
使用的代码如下：
```lisp
(set-logic ALL)
(set-option :produce-models true)
(declare-datatypes ((list 0)) 
(((cons (hd Int) (tl list)) (nil))))
(declare-fun len (list) Int)
(assert (= (len nil) 0))
(assert (forall ((head Int) (tail list)) (= (len (cons head tail)) (+ 1 (len tail)))))
(check-sat)
(get-model)
```
求解器返回 unknown。尽管该问题看起来非常简单，但可能是因为涉及递归定义的数据类型和全称量词，导致求解器无法解决。 