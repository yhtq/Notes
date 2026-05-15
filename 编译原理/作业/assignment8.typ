#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
= 第一题
==
```ocaml
let map f l k =
  case l of
    [] => []
  | h :: t => f h (fn h1 =>
      map f t (fn t1 => k (h1 :: t1)))
in
  map (fn x => x + 1) [1; 2; 3] id
```
==
```ocaml
let eval exp k =
  case exp of
  | Num n => k n
  | Add e1 e2 =>
      eval e1 (fn v1 =>
        eval e2 (fn v2 =>
          k (v1 + v2)))
  | Mul e1 e2 =>
      eval e1 (fn v1 =>
        eval e2 (fn v2 =>
          k (v1 * v2)))
  | Sub e1 e2 =>
      eval e1 (fn v1 =>
        eval e2 (fn v2 =>
          k (v1 - v2)))
  | Div e1 e2 =》
      eval e2 (fn v2 =>
        if v2 = 0 then None
        else eval e1 (fn v1 =>
          k (v1 / v2))))
      )
```
==
```ocaml
try exp1 catch (fn ex => exp2)
:=
call/cc (fn k =>
  let raise = fn ex => k ex in
  exp1) (fn ex => exp2)
```
