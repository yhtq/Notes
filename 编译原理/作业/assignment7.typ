#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
#show math.equation: it => {
  set text(font: "Noto Sans Math")
  math.serif(it)
}
#let CodeLines1 = CodeLines.with(
  withCountNumber: true
)
#let tv = math.italic([tv])
#let t1 = ([t1])
#let t2 = ([t2])
#let t3 = ([t3])
#let t4 = ([t4])
#let t5 = ([t5])
#let IN = "IN"
#let OUT = "OUT"
#let def = "def"
#let use = "use"
=
  #CodeBlock(CodeLines1(
    [$r = 0$],
    [$t1 = 0$],
    [$tv = 8 * n$],
    [$L: t2 = A[t1]$],
    [$t4 = B[t1]$],
    [$t5 = t2 * t4$],
    [$r = r + t5$],
    [$t1 = t1 + 8$],
    [$"if" t1 < tv goto L$],
  ))
=
  == 
    - BB5
      $
        def = R_1\
        use =  R_7\
        OUT = {}\
        IN = {R_1, R_7}
      $
    - BB3
      $
        def = R_5, R_6, R_7\
        use = R_3\
        OUT = {R_1, R_7}\
        IN = {R_3, R_1}
      $
    - BB4
      $
        def = R_7, R_8, R_2\
        use = R_2, R_4\
        OUT = {R_1, R_7}\
        IN = {R_2, R_4, R_1}
      $
    - BB2 
      $
        def = R_3, R_4\
        use = R_1\
        OUT = {R_2, R_3, R_4, R_1}\
        IN = {R_1, R_2}
      $
    - BB1
      $
        def = R_1, R_2\
        use = emptyset\
        OUT = {R_1, R_2}\
        IN = {}
      $
    - BB5
      $
        def = R_1\
        use = R_1, R_7\
        OUT = {R_1, R_2}\
        IN = {R_1, R_2, R_7}
      $
    - BB3
      $
        def = R_5, R_6, R_7\
        use = R_3\
        OUT = {R_1, R_2, R_7}\
        IN = {R_3, R_2, R_1}
      $
    - BB4
      $
        def = R_7, R_8, R_2\
        use = R_2, R_4\
        OUT = {R_1, R_2, R_7}\
        IN = {R_2, R_4, R_1}
      $
    ......
  ==
    同时处于 $IN, OUT$ 集合中的寄存器都冲突
  ==
    $R_1, R_2$ 溢出即可
