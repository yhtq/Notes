#import "@preview/touying:0.7.4": *
#import "../../template.typ": *
#import themes.university: *
#let hasType(tm, ty) = $#tm \: #ty$
// #show: note.with(
//   withChapterNewPage: false,
//   withOutlined: false,
//   withTitle: false,
//   withHeadingNumbering: false,
// )
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-info(
    title: [编译原理课程项目],
    subtitle: [],
    author: [郭子荀],
    date: datetime.today(),
    institution: [],
  ),
)
#set text(size: 25pt, font: ("Noto Serif CJK SC", "New Computer Modern"))
#show: thm-rules
#show: ans-rules
#show: thm-rules1
#show: alg-rules
#show: alg-rules1

= 编译原理课程项目
== 主题/动机
  - 语言设计上：lamabda calculus + non strict evaluation + optimization(transformation based / strictness analysis / ...)
  - 实现上：algebraic effect and effect handler + parser combinator
== Effectful programming
  - 经典问题：Library or Language
  - 方案：Haskell + Hefty
  体验下来的优点：
  + 语法语义分离，结构清晰，表达能力强大。复杂控制流可以比较优雅的处理（例如语法-语义分析的高层次流融合）。Log 之类的全局副作用使用 handler 处理也很自然
  + 比 mtl(monad transformer library) 更加灵活好理解，开发实际程序时心智负担小一点 ，似乎性能也有可能甚至更好
  缺点：
  + 生态不成熟，兼容基于 mtl 的库比较困难
  + 使用复杂一万倍的理论和类型写 C with goto
== 实现架构
  - 前端：基于 Effect 完全重新实现的 parser combinator（为了省事基本都是纯回溯），语法和语义分析独立实现 $+$ 流融合。 Persistent data structure 保证快速回溯
  - 中端：标准的类型推断（AI 写的）+ 一些简单的优化过程（还没写，预计可能考虑 inline/common subexpression, rewriting）
  - 后端：解释器（还是 AI 写的）
== 杂项
  - Diagnostic: 基于 higher-order effect 的栈追踪+树形异常。基本不影响程序实现，额外代码（连带 Printer）只有一百多行
  #columns(4)[
    #set text(size: 5pt)
    `Parser nested let
           uncaught exception: AssertionFailed
             |
           1 | let rec x == 1 in let y = 2 in add x y\n
             |
           When parsing expression at Position {line = 1, column = 1}:
             All the following 5 alternatives failed :
                 |
               1 | let rec x == 1 in let y = 2 in add x y\n
                 |
               When parsing lambda at Position {line = 1, column = 1}:
                   |
                 1 | let rec x == 1 in let y = 2 in add x y\n
                   |
                 When parsing keyword at Position {line = 1, column = 1}:
                     |
                   1 | let rec x == 1 in let y = 2 in add x y\n
                     |
                   satisfy at Position {line = 1, column = 1}:
                       |
                     1 | let rec x == 1 in let y = 2 in add x y\n
                       |
                     Unexpected token: Just (KW(let), (1:1, 1:3))
                 |
               1 | let rec x == 1 in let y = 2 in add x y\n
                 |
               When parsing literal at Position {line = 1, column = 1}:
                   |
                 1 | let rec x == 1 in let y = 2 in add x y\n
                   |
                 satisfy_ at Position {line = 1, column = 1}:
                     |
                   1 | let rec x == 1 in let y = 2 in add x y\n
                     |
                   Unexpected token: Just (KW(let), (1:1, 1:3))
                 |
               1 | let rec x == 1 in let y = 2 in add x y\n
                 |
               When parsing var term at Position {line = 1, column = 1}:
                   |
                 1 | let rec x == 1 in let y = 2 in add x y\n
                   |
                 satisfy_ at Position {line = 1, column = 1}:
                     |
                   1 | let rec x == 1 in let y = 2 in add x y\n
                     |
                   Unexpected token: Just (KW(let), (1:1, 1:3))
                 |
               1 | let rec x == 1 in let y = 2 in add x y\n
                 |
               When parsing keyword at Position {line = 1, column = 1}:
                   |
                 1 | let rec x == 1 in let y = 2 in add x y\n
                   |
                 satisfy at Position {line = 1, column = 1}:
                     |
                   1 | let rec x == 1 in let y = 2 in add x y\n
                     |
                   Unexpected token: Just (KW(let), (1:1, 1:3))
                 |
               1 | let rec x == 1 in let y = 2 in add x y\n
                 |
               When parsing let expression at Position {line = 1, column = 1}:
                   |
                 1 | let rec x == 1 in let y = 2 in add x y\n
                   |
                 When parsing bind at Position {line = 1, column = 1}:
                     |
                   1 | let rec x == 1 in let y = 2 in add x y\n
                     |
                   When parsing expression at Position {line = 1, column = 1}:
                     All the following 5 alternatives failed :
                         |
                       1 | let rec x == 1 in let y = 2 in add x y\n
                         |
                       When parsing lambda at Position {line = 1, column = 1}:
                           |
                         1 | let rec x == 1 in let y = 2 in add x y\n
                           |
                         When parsing keyword at Position {line = 1, column = 1}:
                             |
                           1 | let rec x == 1 in let y = 2 in add x y\n
                             |
                           satisfy at Position {line = 1, column = 1}:
                               |
                             1 | let rec x == 1 in let y = 2 in add x y\n
                               |
                             Unexpected token: Just (KW(=), (1:12, 1:12))
                         |
                       1 | let rec x == 1 in let y = 2 in add x y\n
                         |
                       When parsing literal at Position {line = 1, column = 1}:
                           |
                         1 | let rec x == 1 in let y = 2 in add x y\n
                           |
                         satisfy_ at Position {line = 1, column = 1}:
                             |
                           1 | let rec x == 1 in let y = 2 in add x y\n
                             |
                           Unexpected token: Just (KW(=), (1:12, 1:12))
                         |
                       1 | let rec x == 1 in let y = 2 in add x y\n
                         |
                       When parsing var term at Position {line = 1, column = 1}:
                           |
                         1 | let rec x == 1 in let y = 2 in add x y\n
                           |
                         satisfy_ at Position {line = 1, column = 1}:
                             |
                           1 | let rec x == 1 in let y = 2 in add x y\n
                             |
                           Unexpected token: Just (KW(=), (1:12, 1:12))
                         |
                       1 | let rec x == 1 in let y = 2 in add x y\n
                         |
                       When parsing keyword at Position {line = 1, column = 1}:
                           |
                         1 | let rec x == 1 in let y = 2 in add x y\n
                           |
                         satisfy at Position {line = 1, column = 1}:
                             |
                           1 | let rec x == 1 in let y = 2 in add x y\n
                             |
                           Unexpected token: Just (KW(=), (1:12, 1:12))
                         |
                       1 | let rec x == 1 in let y = 2 in add x y\n
                         |
                       When parsing let expression at Position {line = 1, column = 1}:
                           |
                         1 | let rec x == 1 in let y = 2 in add x y\n
                           |
                         When parsing keyword at Position {line = 1, column = 1}:
                             |
                           1 | let rec x == 1 in let y = 2 in add x y\n
                             |
                           satisfy at Position {line = 1, column = 1}:
                               |
                             1 | let rec x == 1 in let y = 2 in add x y\n
                               |
                             Unexpected token: Just (KW(=), (1:12, 1:12))`
  ]
== 杂项
  - 测试：几十个测试点，包括一些 property-based test(QuickCheck)
  - 工作量：3000 - 4000 行（不含空行和注释）
  - AI 适应性：虽然肯定不熟悉 Haskell + Hefty，但是有测试约束下开发比较标准的部分还是表现不错
