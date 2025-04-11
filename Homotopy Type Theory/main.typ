#import "../template.typ": *
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/curryst:0.5.0": rule, prooftree
#show: note.with(
  title: "HOTT",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
// #set text(font: "Noto Serif CJK SC", lang: "zh")
// #show emph: it => {
//     text(it, weight: "bold")
//   }
// #set par(justify: true, first-line-indent: (
//       amount: 22pt,
//       all: false
//     ))
// #set par(spacing: 1.2em)
// #show math.equation: set text(font: ("Noto Serif CJK SC", "New Computer Modern Math"))
// #show math.equation: it => {
//     show block: set align(center)
//     it
//     }
#let Term = "Term"
#let Type = "Type"
#let hasType(tm, ty) = $#tm \: #ty$
#let formula(x) = $#x$
#let evalTo = math.arrow.squiggly
= Martin-Löf Type Theory
  == 形式系统
    作为例子，我们定义最简单的自然数的形式系统：
    $
      prooftree(
        rule(
          NN\: "type"
        )
      )
      prooftree(
        rule(
          "zero"\: NN
        )
      )
      prooftree(
        rule(
          "succ" k\: NN,
          k\: NN
        )
      )
    $
    常用的形式系统是 Lambda Calculus，它包括：
    - 自由变元 $x_i$
    - 生成规则：
      $
        prooftree(
        rule(
          x_i \: Term
        )
      )
      $
      $
        prooftree(
        rule(
          hasType(lambda x_i. t, Term),
          hasType(t, Term),
        )
      )
      $
    - $beta-$reduction:
      $
        (lambda x_i. t) v evalTo t[x_i := v]
      $
    以及 Simple Typed Lambda Calculus，它包括：
    - 自由变元 $x_i$
    - 原子类型 $A_i$
    - 类型规则：
      $
        prooftree(
          rule(
            hasType(A_i, Type)
          )
        )
        prooftree(
          rule(
            hasType(A -> B, Type),
            hasType(A, Type),
            hasType(B, Type),
          )
        )
        prooftree(
          rule(
            hasType(lambda x. b, A -> B),
            hasType(x : A tack b, B),
            hasType(B, Type),
          )
        )
        prooftree(
          rule(
            hasType(f, A -> B),
            hasType(x, A),
            hasType(f B, B),
          )
        )
      $
  == 宇宙
    由于类似罗素悖论的存在，我们不能希望一个类型的类型是 $Type$，只能将类型分成不同的层级：
    $
      u_0 : u_1 : u_2 : ... : u_n : ... 
    $
    以及以下规则：
    $
      prooftree(
        rule(
          hasType(NN, u_0)
        )
      )\
      prooftree(
        rule(
          hasType(A -> B, u_n),
          hasType(A, u_n),
          hasType(B, u_n),
        )
      )\
      prooftree(
        rule(
          hasType(A, u_m),
          hasType(A, u_n),
          formula(n < m),
        )
      )\
    $
    #definition[Type family][
      设 $A :u_(n + 1)$，注意到 $u_n : u_(n + 1)$，由上面的规则可以得到：
      $
        A -> u_n : u_(n + 1)
      $
      这样的 type 被称为 type family
    ]
    ```haskell
    Variable := Text
    AbstractVariable := Text -- Most of time, `AbstractVariable` is exactly one logical term. But in loop, it' s actually `any possible value` in this loop 
    BoolOp := LT | GT | LE | GE | EQ
    NumOp := Add | Sub 
    NumExp := NumOp NumExp NumExp
      | Var Variable
      | RawInt Int

    BoolExp := BoolOp NumExp NumExp
      | Not BoolExp
      | Imply BoolExp BoolExp
      | RawBool Bool

    Program := Skip
      | Assign Variable NumExp
      | If BoolExp Program Program
      | While BoolExp BoolExp Program -- the first BoolExp is the condition, the second is the loop invariant
      | Seq Program Program
    
    Context = {
      values : Set AbstractVariable,
      variableValues : Map Variable AbstractVariable,
      propositions : Set BoolExp
    }
    ```
  