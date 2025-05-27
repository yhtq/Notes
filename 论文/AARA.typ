#import "../template.typ": *

#show: note.with(
  withChapterNewPage: false,
  withOutlined: false,
  withTitle: false,
  withHeadingNumbering: false,
)

= AARA
  We use `tick(q)` to denote $q$ unit of resources(memory, time, etc.). For example:
  ```rust
  enum List {
    Nil,
    Cons(i32, Box<List>),
  }
  ```
  is the normal list. If we add a resource annotiation
  ```rust
  fn sum (xs: List) -> (Q, i32) {
    match xs {
      List::Nil => (tick(3), 0),
      List::Cons(x, xs) => {
        let (q1, sum_xs) = sum(xs);
        (tick(12) + q1, x + sum_xs)
      },
    }
  }
  ```
  the a linear solver can solve the resource consumption of the function.