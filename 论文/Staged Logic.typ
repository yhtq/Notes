#import "../template.typ": *

#show: note.with(
  withChapterNewPage: false,
  withOutlined: false,
  withTitle: false,
  withHeadingNumbering: false,
)

= Challenges of Higher-Order Functions
  More and more imperative languages tends to support higher-order functions, but the verifier support is still limited.
  - Pure higher-order functions only: Dafny, WhyML
  - Refinement type systems
  - Type system assumptions
  - Interactive
  Here is an example:
  ```ocaml
  let rec foldr f a l =
    match l with
    | [] -> a
    | h :: t -> f h (foldr f a t)
  ``` 
  #let inv = $italic("inv")$
  #let ys = $italic("ys")$
  #let isList = $italic("isList")$
  #let req = $bold("req")$
  #let ens = $bold("ens")$
  in which, `f` may have mutation, exceptions, global variables, etc. Iris adopts such a specfication:
  $
    {P x * inv ys a'} f(x, a') {r, inv (x : ys)  r} 
  $
  the weakness is:
  - the input list can not be immutable
  - $f$ can not throw an exception
  *Staged logic* is a solution to imperative higher-order functions. In the following program:
  ```ml
  let hello f x y = 
    x := !x + 1;
    let r = f y in 
    let r2 = !x + r in 
    y := r2;
    r2
  ```
  #let res = $italic("res")$
  #let hello = $italic("hello")$
  staged logic gives:
  $
    hello (f, x, y, res) = \
      exists a req x arrowb a;\
      ens x arrowb a + 1;\
      exists r, f(y, r);\
      exists b, req x arrowb b * y;\
      ens [res] x arrowb b * r
  $
  in which `f(y, r)` should be instantiated with the function given in the function call. 
= Algebraic Effects
  The algebraic effect seems like:
  ```ml
  let comp () =
    print_string "0 "
    print_string (perform E);
    print_string "5 " 

    let main = 
      try
        comp ()
      with effect E k = 
        print_string "1 ";
        continue k "2"
        continue k "4"
        print_string "6 "
  ```
  Here, algebraic effect is an advanced version of monadic exceptions, which use a *continuation* to refer to the rest part of original program, which can be called zero or more times and with or without a return value. Basically, algebraic effect can be implemented with hogher-order functions, so it can be specified with staged logic: