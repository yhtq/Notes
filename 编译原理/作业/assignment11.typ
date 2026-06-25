#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
#let dotb = math.dot.o
#set text(font: "Noto Sans Mono CJK SC", size: 12pt)
#show math.equation: it => {
  set text(font: "Noto Sans Math")
  math.serif(it)
}
#let EOF = "EOF"
#let move = "移进"
#let reduce = "规约"
#let accept = "接受"
#let CodeLines1 = CodeLines.with(
  withCountNumber: true
)
=
#CodeBlock[
  #CodeLines1(
    start: 100,
    [$t_1 = b * c$],
    [$t_2 = a + t_1$],
    [$t_3 = x + y$],
    [$"if" t_2 > t_3 "goto" 105$],
    [$"goto" \_$],
    [$"if" m == n "goto" 107$],
    [$"goto" \_$],
    [$"if" x <= y "goto" 109$],
    [$"goto" ?$],
    [$"if" a < b$ "goto" 111],
    [$"goto" 115$],
    [$a = a + 10$],
    [$b = c * m$],
    [$"goto" 109$],
    [$a = b + c$],
    [$"goto" 100$]
  )
]
下划线处即为 nextlist
=
  #let nextinstr = "nextinstr"
  #let backpatch = "backpatch"
  #table(columns: 2,
    [$S -> "do"$], [$S_1."begin"$ = nextinstr],
    [$S_1$], [$backpatch(S."nextlist", nextinstr)$],
    [while $B$], [$backpatch(B."truelist", S_1."begin"); S."nextlist" = B."falselist"$]
  )
