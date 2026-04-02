#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业1",
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
= 
  == 
    #CodeBlock[
      #CodeLines1( 
      [$t_1 = x$],
      [$t_2 = y$],
      [$t_3 = t_1 + t_2$],
      [$tv_0 = 0$],
      [$"if" t_3 >= 0 goto 7$],
      [$goto 10$],
      [$t_4 = t_2 * t_1$],
      [$z = t_1 + t_4$],
      [$goto 11$],
      [$z = t_2$],
      [$"return" z$],
      )  
    ]
  == 
    #CodeBlock[
      #CodeLines1( 
      [$tv_1 = 1$],
      [$t_1 = x$],
      [$t_2 = y$],
      [$t_3 = t_1 - t_2$],
      [$"ifFalse" t_3 > z goto 15$],
      [$x = t_1 - tv_1$],
      [$t_4 = z$],
      [$z = t_4 + tv_1$],
      [$t_5 = x$],
      [$t_6 = z$],
      [$t_7 = t_5 + t_6$],
      [$t_8 = y$],
      [$y = t_8 * t_7$],
      [$goto 5$],
      [$"return" y$],
      )  
    ]
= 
  #let GETVAR = "GET_VAR"
  #let CONST = "CONST"
  #let SETVAR = "SET_VAR"
  #let ADD = "ADD"
  #let SUB = "SUB"
  #let MUL = "MUL"
  #let GOTO = "GOTO"
  #let GOTOIFZERO = "GOTO_IF_ZERO"
  #let code = "code"
  #let next = "next"
  - $E -> E_1 + E_2$
    $
      E.code = E_1.code || E_2.code || `ADD`
    $
  - $E -> -E_1$
    $
      E.code = E_1.code || `CONST(0); SUB`
    $
  - $E -> ID$
    $
      E.code = `GETVAR(ID)`
    $
  - $B -> E_1 == E_2$
    $
      B.code = E_1.code || E_2.code || `SUB` || `GOTOIFZERO({B."true"}); GOTO({B."false"})`
    $
  - $B -> B_1 || B_2$
    $
      B_1."true" = B."true", B_2."true" = B."true"\
      B_1."false" = "genlabel()", B_2."false" = B."false"\
      B.code = B_1.code || `{B_1."false"}` || B_2.code
    $
  - $S -> "if" (B) space S_1 "else" S_2$
    $
      B."true" = "genlabel()", B."false" = "genlabel()"\
      S.code = B.code || `{B."true"}` || S_1.code || `GOTO(S."next")` \
      || `{B."false"}` || S_2.code || `GOTO(S."next")`
    $
  - $S -> "while" (B) space S_1$
    $
      B."true" = "genlabel()", B."false" = S."next", S_1."next" = "genlabel()"\
      S.code = `{S_1."next"}` || B.code || `{B."true"}` || S_1.code \
    $