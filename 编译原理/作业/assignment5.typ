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
  - (3) 是一个循环入口，(19), (7) 是其出口
  - (8) 是一个循环入口，(3) 是其出
=
  从栈底往上，依次为：
  - `main` 函数栈帧
    - `main` 函数的返回地址（若有）
    - `x` 变量
    - `a` 变量
  - 第一次 `p2` 函数调用栈帧
    - `main` 函数中 `p2` 调用的返回地址
    - `u` $= 1$
    - `h`
  - 第二次 `p2` 函数调用栈帧
    - `p2` 函数中 `p2` 调用的返回地址
    - `u` $= 0$
    - `h`
  - `p3` 函数调用栈帧
    - `p2` 函数中 `p3` 调用的返回地址
    - `i` $= 5$
    - `h`
  - `p1` 函数调用栈帧
    - `p3` 函数中 `p1` 调用的返回地址
    - `k` $= 5$
    - `g`
= 
  ==
    #CodeBlock[
      #CodeLines1(
        [$t_1 = b + c$],
        [$t_2 = a \/ t_1$],
        [$t_3 = e + f$],
        [$t_4 = d * t_3$],
        [$x = t_2 - t_4$],
      )
    ]
  ==
    #CodeBlock[
      #CodeLines1(
        [$LD(R_1, b)$],
        [$LD(R_2, c)$],
        [$sep(ADD, R_3, R_1, R_2)$],
        [$sep(ST(t_1, R_3))$],
        [$sep(LD(R_4, a))$],
        [$sep(DIV, R_5, R_4, R_3)$],
        [$sep(ST(t_2, R_5))$],
        [$sep(LD(R_6, e))$],
        [$sep(LD(R_7, f))$],
        [$sep(ADD, R_8, R_6, R_7)$],
        [$sep(ST(t_3, R_8))$],
        [$sep(LD(R_9, d))$],
        [$sep(MUL, R_10, R_9, R_8)$],
        [$sep(ST(t_4, R_10))$],
        [$sep(SUB, R_11, R_5, R_10)$],
        [$ST(x, R_11)$],
        
      )
    ]
  
  == 
    #[
      #set page(width: auto)

      #table(columns: 15
      )[][$R_1$][$R_2$][$R_3$][$a$][$b$][$c$][$d$][$e$][$f$][$t_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $LD(R_1, b)$][$b$][][][$a$][$b, R_1$][$c$][$d$][$e$][$f$][$t_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $LD(R_2, c)$
      ][$b$][$c$][][$a$][$b, R_1$][$c, R_2$][$d$][$e$][$f$][$t_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $sep(ADD, R_1, R_1, R_2)$
      ][$b + c$][$c$][][$a$][$b$][$c, R_2$][$d$][$e$][$f$][$t_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $ST(t_1, R_1)$
      ][$b + c, t_1$][$c$][][$a$][$b$][$c, R_2$][$d$][$e$][$f$][$t_1, R_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $LD(R_2, a)$
      ][$b+ c, t_1$][$a$][][$a, R_2$][$b$][$c$][$d$][$e$][$f$][$t_1, R_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $sep(DIV, R_3, R_2, R_1)$
      ][$b+ c, t_1$][$a$][$a \/ (b + c)$][$a, R_2$][$b$][$c$][$d$][$e$][$f$][$t_1, R_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $ST(t_2, R_3)$
      ][$b+ c, t_1$][$a$][$a \/ (b + c)$][$a, R_2$][$b$][$c$][$d$][$e$][$f$][$t_1, R_1$][$t_2, R_3$][$t_3$][$t_4$][$x$
      ][
        $LD(R_1, e)$
      ][$e$][$a$][$a \/ (b + c)$][$a, R_2$][$b$][$c$][$d$][$e, R_1$][$f$][$t_1$][$t_2, R_3$][$t_3$][$t_4$][$x$
      ][
        $LD(R_2, f)$
      ][$e$][$f$][$a \/ (b + c)$][$a$][$b$][$c$][$d$][$e, R_1$][$f, R_2$][$t_1$][$t_2$][$t_3$][$t_4$][$x$
      ][
        $sep(ADD, R_1, R_1, R_2)$
      ][$e + f$][$f$][$a \/ (b + c)$][$a$][$b$][$c$][$d$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4$][$x$
      ][
        $ST(t_3, R_1)$
      ][$e + f$][$f$][$a \/ (b + c)$][$a$][$b$][$c$][$d$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4$][$x$
      ][
        $LD(R_2, d)$
      ][$e + f$][$d$][$a \/ (b + c)$][$a$][$b$][$c$][$d, R_2$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4$][$x$
      ][
        $sep(MUL, R_2, R_2, R_1)$
      ][$e + f$][$d * (e + f)$][$a \/ (b + c)$][$a$][$b$][$c$][$d, R_2$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4, R_2$][$x$
      ][
        $ST(t_4, R_2)$
      ][$e + f$][$d * (e + f)$][$a \/ (b + c)$][$a$][$b$][$c$][$d, R_2$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4, R_2$][$x$
      ][
        $sep(SUB, R_3, R_3, R_2)$
      ][$e + f$][$d * (e + f)$][$a \/ (b + c) - d * (e + f)$][$a$][$b$][$c$][$d, R_2$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4, R_2$][$x, R_3$
      ][
        $ST(x, R_3)$
      ][$e + f$][$d * (e + f)$][$a \/ (b + c) - d * (e + f)$][$a$][$b$][$c$][$d, R_2$][$e$][$f, R_2$][$t_1$][$t_2, R_3$][$t_3, R_1$][$t_4, R_2$][$x, R_3$
      ]
    ]
    
  ==
    #CodeBlock[
      #CodeLines1(
        [$LD(R_1, b)$],
        [$LD(R_2, c)$],
        [$sep(ADD, R_1, R_1, R_2)$],
        [$sep(ST(t_1, R_1))$],
        [$sep(LD(R_2, a))$],
        [$sep(DIV, R_1, R_2, R_1)$],
        [$sep(ST(t_2, R_1))$],
        [$sep(LD(R_1, e))$],
        [$sep(LD(R_2, f))$],
        [$sep(ADD, R_1, R_1, R_2)$],
        [$sep(ST(t_3, R_1))$],
        [$sep(LD(R_2, d))$],
        [$sep(MUL, R_2, R_2, R_1)$],
        [$sep(ST(t_4, R_2))$],
        [$sep(LD(R_1, t_2))$],
        [$sep(SUB, R_1, R_1, R_2)$],
        [$ST(x, R_1)$],
        
      )
    ]
  