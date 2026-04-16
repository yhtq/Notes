#import "../../template.typ": *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "课程项目",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
= 项目背景
  基于 Algebraic effect 的 Parser combinator library，在传统 Parser combinator 的基础上，提供了高度可定制的错误处理，易于实现的流融合机制等功能，并基于此实现具备 Hindley-Milner 类型系统的 $lambda$ 演算解析器。
= 项目设计
  基本设计的 pass 包括：
  - 词法分析
  - 语法分析
  均通过 parser combinator 实现，并利用流融合技术在运行时合并为一个实际 pass
  - 类型推导
  - 一些简单的优化：常量折叠，内联等
  - 解释运行
  - 如果进展顺利，考虑生成 C 代码并进一步编译到机器码
= 实现方案
  预期工作量大约三千到五千行 Haskell 代码，具体设计上大致包括：
  - 共用功能（错误处理等），依据具体功能划分为多个模块
  - 每个 pass 设计为一个模块，包括一个基础的当前 pass 所需要的 effects 和默认 handler，并且对应一个该 pass 的单元测试
  - 最终，将每个 pass 组装起来形成一个完整的项目
= 预期效果
  - 前端部分，暂时不考虑运行性能，以展示架构设计、错误处理为主。如果进展顺利考虑手工利用 look ahead 信息进行优化
  - 中端部分：能够在一些简单程序上进行正确的类型推导和代码优化，可以评估代码优化的实际效果
  - 后端部分：暂时计划只实现基础的解释器。如果进展顺利，考虑依赖 C 运行时的机器代码生成，并且评估其性能表现
= 参考文献
  - #link("https://hackage.haskell.org/package/megaparsec-9.7.0/docs/Text-Megaparsec.html")[Megaparsec] 等成熟的 parser combinator 库的设计和实现
  - #link("https://gitlab.haskell.org/ghc/ghc/blob/master/compiler/GHC/Core.hs")[GHC Core 的设计]
  - GHC Core 上的优化机制设计，例如：
    + Simon L. Peyton Jones, AndréL.M. Santos,
      A transformation-based optimiser for Haskell,
      Science of Computer Programming,
      Volume 32, Issues 1–3,
      1998,
      Pages 3-47,
      ISSN 0167-6423,
      https://doi.org/10.1016/S0167-6423(97)00029-4.
    + Peyton Jones, Simon & Marlow, Simon. (2002). Secrets of the Glasgow Haskell Compiler inliner. J. Funct. Program.. 12. 393-433. 10.1017/S0956796802004331. 