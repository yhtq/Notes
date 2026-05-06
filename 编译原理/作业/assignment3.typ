#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
#set text(font: "Noto Sans Mono CJK SC", size: 12pt)
#set math.equation(numbering: none)
#show math.equation: it => {
  set text(font: "Noto Sans Math")
  math.mono(it)
}
#let side = "side"
#let left = "left"
#let right = "right"
#let val = "val"
#let count = "length"
#let empty = "empty"
#let truel = "true"
#let falsel = "false"
= 
#table(
  columns: 2,
  rows: 10em,
  align: center + horizon,
  [$S := L$], [$ L.side = left\ S.val = L.val $],
  [$S := L_1.L_2$], [$ L_1.side = left, L_2.side = right, \ S.val = L.val $],
  [$L := L_1 B $], [$ L_1.side = L.side\ L.val = ite(L.side == left\ , 2 * L_1.val + B.val\ , 2^(-L_1.count - 1) * B.val)\ L.count = L_1.count + 1 $],
  [$L := B$], [$ L.val = ite(L.side == left, B.val, 1/2 * B.val)\ L.count = 1 $],
  [$B := 0$], [$ B.val = 0 $],
  [$B := 1$], [$ B.val = 1 $]
)
= 
#table(
  columns: 2,
  rows: 20em,
  align: center + horizon,
  [$S := epsilon$], [$ S.left = falsel, S.right = falsel, S.val = 0, S.empty = falsel $],
  [$S := T S_1$], [$ 
    "if" T.empty "then"
      S.* = S_1.*\
    "else if" S_1.empty "then" 
      S.* = T.*\
    "else" {\
      S.left = T.left\ S.right = S_1.right\ S.val = T.val + S_1.val - ite(T.right and S_1.left, 1, 0)\ S.empty = falsel\
    }\
    $],
    [$T := epsilon$], [$ T.left = falsel, T.right = falsel, T.val = 0, T.empty = truel $],
    [$T := a T_1 b$], [$ 
      T.empty = falsel, T.left = truel, T.right = falsel\
      T.val = ite(T_1.left, T_1.val, T_1.val + 1)
    $],
    [$T := b T_1 c$], [$ 
      T.empty = falsel, T.left = falsel, T.right = falsel\
      T.val = T_1.val
    $],
    [$T := c T_1 a$], [$ 
      T.empty = falsel, T.left = falsel, T.right = truel\
      T.val = ite(T_1.right, T_1.val, T_1.val + 1)
    $],
)
=
  文法转换为：
  $
    S &-> 1 S'\
    B &-> 0 | 1\
    S' &-> epsilon | B S'
  $
  属性文法可以定为：
  #table(
    columns: 2,
    rows: 5em,
    align: center + horizon,
    [$S -> 1 S'$], [$ S.val = 2^(S'.count) + S'.val $],
    [$S' -> B S'_1$], [$ S'.val = B.val * 2^(S'_1.count), S'.count = S'_1.count + 1 $],
    [$S' -> epsilon$], [$ S'.val = 0, S'.count = 0 $],
    [$B -> 0$], [$ B.val = 0 $],
    [$B -> 1$], [$ B.val = 1 $]
  )