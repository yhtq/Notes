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
=
注意到 $G[A]$ 的对应语言形如 $a^n c b^n$，其中 $n >= 0$，而 SDT 计算结果形如：
$
1 2 0 2 0 2 0 ...
$
也即：
$
  1 (2 0)^\*
$
