#import "template.typ": *
#import "@local/common-note-template:0.1.0": *
#import "@preview/curryst:0.3.0": rule, proof-tree
#show: doc => conf(
  cauthor: "郭子荀",
  studentid: "2100012990",
  blindid: "2100012990",
  cthesisname: "数学模型课程论文",
  cheader: "数学模型课程论文",
  ctitle: "类型、范畴与程序语言模型",
  school: "数学科学学院",
  cfirstmajor: "某个一级学科",
  cmajor: "某个专业",
  emajor: "Some Major",
  direction: "某个研究方向",
  csupervisor: "李四 教授",
  esupervisor: "Prof. Si Li",
  date: "二零二四年五月",
  cabstract: "上个世纪以来，计算机技术快速发展，如何设计更优秀的程序语言的讨论也随之产生，其中一个方向便是使用类型、范畴这些近现代数学中产生的抽象语言构建更具表达力的形式语言。一方面，这为程序分析的理论和实践建立了易于研究又富有表达力的模型；另一方面，尽管这些高阶语言没有在大部分主流的编程语言中得到显式的应用，但其中的许多概念也极大地影响了这些程序语言的设计和改进。同时，许多主流易用的数学形式化系统，包括 Coq, Lean 等，也是基于这样一种抽象语言设计的。本文将以尽量简单清晰的脉络梳理需要涉及的基本概念，进一步简要介绍它如何成为真实的计算机语言以及数学语言的一种抽象模型。由于时间仓促以及作者水平有限，难免有所疏漏，还请批评指正。
  ",
  ckeywords: ("范畴论", "类型论", "程序语言", "形式化数学", "理论计算机"),
  eabstract: "This document introduces the features of the pkuthss-typst template.",
  ekeywords: ("Typst", "Template"),
  acknowledgements: [感谢 Typst 开发者的辛勤付出。 #lorem(300)],
  linespacing: 1em,
  outlinedepth: 3,
  blind: false,
  listofimage: false,
  listoftable: false,
  listofcode: false,
  alwaysstartodd: false,
  doc,
)
#show: thm-rules
#show: ans-rules
#show: thm-rules1
#let stlc = [Simply Typed Lambda Calculus]
#let martin-lof = [Martin-Löf Type Theory]
#let Bool = `Bool`
#let Void = `Void`
#let boring = `()`
#let lam(x, y) = $lambda #x . space #y$
= 前言 <intro>

  == 介绍
    无论是一段程序还是一个数学证明，正确性当然是最低的要求。人工检查往往充满了不可靠性，既然计算机有着强大的计算能力，是否能让计算机来帮助我们验证程序的正确性呢？对于一段纯粹使用形式逻辑符号进行推理的“证明”，设计一个程序验证其正确性或许是可以做到的，然而要求数学家使用形式逻辑符号去书写证明无疑有些荒唐，因此人们需要一种更具有表达力，能够保证正确，还能保证可计算性的语言。
    
    而对于计算机程序，情况还要更为糟糕一些。早已证明在 lambda 演算，或者等价的，图灵机模型中，不可能设计一个程序验证所有程序是否停机 @halting ，遑论其正确性。这意味着我们必须做出一定的取舍，保证一部分的正确性（至少是停机性）而将另一部分交给程序员。
    
    有趣的是，*类型（Type）* 的概念成为了上述两个问题的一种统一的答案。在证明的形式化验证上，Curry-Howard 对应指出，一个命题可以看作是一个类型，而一个证明可以看作是一个程序，如此设计一个形式化验证系统就是在设计一个类型系统。而在程序分析领域，类型是一种几乎被所有主流编程语言采纳的一种进行前文所述的取舍的方式：设计一个仔细定义的类型系统，保证确定一个程序是否符合类型系统的要求（称为*类型检查*）是可计算的，同时认为不符合类型系统的程序均是不合法的。

    事实上，类型最早是 Russell 为了解决著名的 Russell 悖论而提出的一种规范数学语言的设想@principia。尽管数学界最终普遍采用了公理集合论体系，但类型这种工具却最终在二十世纪以来的逻辑学、数学以及程序语言领域成为了重要的工具和语言。Church 提出的 #stlc 和 Martin-Löf 提出的 #martin-lof（也叫直觉类型论） 都是这一思想的经典实现，并且在程序语言和形式化数学中有着很大的影响。本文的第一个目标便是介绍其中的基本概念和构造方法，从而为类似 #stlc 这样简单的基本语言提供类型模型。（在 @intro-stlc 中有对 #stlc 的语言模型的简单介绍）

    然而，在这些简单的形式语言中，我们讨论的函数仅限于如同数学上的函数一样，不依赖也不改变程序的*上下文（context）*或者说运行时状态。这种函数在程序语言中被称为*纯函数（pure function）*，而熟悉任何一种常见编程语言的读者都知道这在实际编程中几乎是不可能的，哪怕是最简单 C++ 程序：
    ```cpp
      std::cout << "Hello, world!" << std::endl;
    ```其中使用了标准库的 IO 操作，无疑对程序上下文造成了影响。在现实世界的计算机程序中，依赖并改变上下文几乎是不可避免的，否则我们完全没必要运行这个程序（在诸如 Lean 的证明系统中，我们确实没必要运行程序，但在通用编程语言中这是荒唐的），因此看起来这种简单的语言并不足以描述复杂的现实世界程序，所幸，计算机科学家 Eugenio Moggi 最早将*单子（Monad）*应用于函数式编程@moggi1989computational，提供了一种非常优美的解决方案。介绍这个巧妙的解决方法便是本文的第二个目标。
    
    单子的概念来自于*范畴论（Category theory）*，其起初的动机产生于于现代代数和代数拓扑等学科，看似是完全的纯数学，但人们发现它和类型论有着巧妙的联系，在理论计算机和程序语言领域得到了有趣的应用。选择本题作为《数学模型》课程论文的动机也是表现即使范畴论这种高度抽象的数学分支，也能为实际的计算机程序提供一种简洁优美的模型，进而启发程序语言的设计，这是十分令人惊喜的。

    本文意图基于尽量简单直观的范畴语言，介绍常用的类型论概念和操作，建立一个简单但足够实用，接近于 Haskell #footnote[一种典型的函数式编程语言，可以参考官网介绍：https://www.haskell.org/] 所采用的的类型系统。其中本质内容都是前人的工作，但具体的叙述、表达和证明经过了以力求统一简洁为目标的设计。
  == 预备知识
    === 范畴 <category>
      本文所使用范畴论部分的概念和记号基本来自于 @代数学引论
      #definition[范畴][
        一个范畴 $C$ 是以下数据：
        - 一组对象构成的集合 $Ob$
        - 对于每一对对象 $A, B in Ob$，一个集合 $Hom (A, B)$，称为 $A$ 到 $B$ 的态射集
        并且满足：
        - 对于每一个对象 $A in Ob$，存在一个态射 $id_A in Hom (A, A)$，称为 $A$ 的恒等态射
        - 对于每一对对象 $A, B, C in Ob$，存在一个映射 $Hom (A, B) times Hom (B, C) -> Hom (A, C)$，称为态射的复合
        两个态射的复合记作 $f compose g$ 或者 $f g$，并且满足：
        - 结合律：对于任意 $f in Hom (A, B), g in Hom (B, C), h in Hom (C, D)$，有 $(f g) h = f (g h)$
        - 单位元：对于任意 $f in Hom (A, B)$，有 $f id_A = f = id_B f$
      ]
      为了描述态射之间的复合关系，常常使用交换图表，例如：
      #align(center)[#commutative-diagram(
      node((0, 0), $A$, 1),
      node((0, 1), $B$, 2),
      node((1, 0), $C$, 3),
      node((1, 1), $D$, 4),
      arr(1, 2, $f$),
      arr(1, 3, $g$),
      arr(2, 4, $h$),
      arr(3, 4, $k$),)]
      代表任何两点间殊途同归，也即：
      $
      h f = k g
      $
      从概念上可以看出，范畴是代数结构的一种统一描述，其中态射是代数结构之间同态的一种推广，而以下概念是单射、满射、同构的推广：
      #definition[单射、满射、同构][
        设 $f: A -> B$ 是范畴 $C$ 中的态射
        - 如果对于任意 $g, h: X -> A$，有 $f g = f h => g = h$，则称 $f$ 是单射
        - 如果对于任意 $g, h: B -> X$，有 $g f = h f => g = h$，则称 $f$ 是满射
        - 如果存在$g: B -> A$ 使得 $f g = id_B, g f = id_A$，则称 $f$ 是同构
      ]
      #definition[函子][
        设 $A, B$ 是两个范畴，称 $F: A -> B$ 是（共变）函子，如果：
        - $F$ 给出对象集上的映射 $F: Ob(A) -> Ob(B)$
        - 对于所有 $a in Ob(A), b in Ob(B)$，$F$ 给出态射集上的映射 $F: Hom_A (a, b) -> Hom_B (F a, F b)$，并且满足：
          - $F id = F id$
          - $F (f compose g) = (F f) compose (F g)$
        如果 $F$ 给出 $F: Hom_A (a, b) -> Hom_B (F b, F a)$ 上的类似映射，则称 $F$ 为反变函子
      ]
      通俗来讲，函子就是范畴之间的同态或者态射。
      #definition[][
        - 称函子 $F$ 是忠实的，如果对于任意的 $X, Y$ 均有映射：
          $
          Hom (X, Y) -> Hom (F X, F Y)
          $ 是单射
        - 称函子 $F$ 是全的，如果上面的映射总是满射
      ]
      #definition[自然变换][
        设 $F, G: A -> B$ 是两个函子，称 $F, G$ 之间的自然变换 $eta$ 是一族态射:
        $
        theta_X in Hom_C (F X, G X), X in Ob(A)
        $
        使得交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $F X$, 1),
        node((0, 1), $G X$, 2),
        node((1, 0), $F Y$, 3),
        node((1, 1), $G Y$, 4),
        arr(1, 2, $theta_X$),
        arr(1, 3, $F f$),
        arr(2, 4, $G f$),
        arr(3, 4, $theta_Y$),)]
        对于任意 $f in Hom(X, Y)$ 都成立。
      ]
      自然变换是函子之间的态射，在代数中常常使用的自然或者典范往往就是指这种自然变换。
    === 类型与程序语言
      与严格的数学不同，计算机科学中许多概念都没有一个公认的，确切的定义，这里只是对用到的其他概念做以简单介绍和辨明，部分参考了 @tapl。
      #definition[变量与元变量][
        本文所称变量是程序语言中的一个标识符，可能是自由的或者约束的。而元变量是指叙述概念或者定理时的占位符，不在真实的编程语言中出现。例如我们讨论一个经典的 lambda 函数：
        $
        id_A = lam(x\: A, x)
        $
        其中 $x$ 是程序语言内部的自由变量，而 $A$ （如果上下文没有指定）是元变量或者说占位符，在实际的程序语言中应当被替换成某个具体的类型。
      ]
      在具有多态的类型系统，也就是一个表达式可以有多种类型的情况下，编译器在推断类型时使用的类型变量通常也称为元变量，但本文不涉及多态系统，并且假设所有表达式具有明确的（尽管书写时可能为了方便而省略）类型。
      #definition[可变与不可变变量][
        对于一个程序语言中的变量，如果其值可以在程序运行时被修改，则称其为*可变变量*，否则称为*不可变变量*。
      ]
      大部分主流编程语言，包括 C++, Java, Python, Rust 等，都是允许可变变量的，而 Haskell 并不允许。同时，像是 #stlc 这样的简单形式语言往往不允许可变变量，从而避免了对于程序状态等复杂问题的探讨。
      #definition[静态与动态][
        在程序语言中，往往将编译时或者说不需要实际运行程序就能确定的性质称为*静态（static）*，而需要运行时才能确定的性质称为*动态（dynamic）*。特别的，如果所有变量或者表达式的类型都是静态的，那么这种类型系统称为*静态类型系统*，反之称为*动态类型系统*。
      ]
      典型的，C++, Haskell 等语言的类型系统是静态的，而 Python, JavaScript 等语言的类型系统是动态的。静态类型系统往往允许更充分的静态分析达到更好的性能和安全性，而动态类型系统则更加灵活，但也更容易出错。显然在理论上动态类型系统远比静态类型系统更加复杂，因此本文所说类型系统都是静态类型系统。
      #definition[类型检查与类型推导][
        在一个静态类型系统中，编译器或者解释器往往需要检查一个表达式是否符合某种类型，这个过程称为*类型检查*。而如果编译器或者解释器能够自动推导出一个表达式的类型，那么这个过程称为*类型推导*。
      ]
      当然类型推导要比类型检查复杂很多。本文假定*所有的项和表达式具有显式的类型*，不考虑类型推导的问题。
      #definition[依赖类型][
        在类型系统中，如果类型的定义依赖于某个值，那么这种类型称为*依赖类型（Dependent type）*
      ]
      既然之前提到了类型的初衷是对值分类，依赖类型看似有些不合直觉。由于依赖类型带来的复杂性，很少有通用的编程语言采取依赖类型系统。然而，基于依赖类型的 #martin-lof 是许多定理证明系统的基础。本文的篇幅不足以仔细介绍依赖类型与 #martin-lof ，可以参考 @martin1982constructive  @categorical-logic

      需要注明的是，通常来说一个编程语言是由若干条*类型规则、语法规则、求值规则*等等组成的，而本文难以仔细介绍或者列出这些规则，只会在需要的时候简要介绍。
= 基本的概念和构造
  == 范畴中的类型
    #definition[类型范畴 1][
      给定一个范畴 $C$ 并且满足以下性质：
      + 有：
        $
        forall A, B in Ob(C), Hom(A, B) in Ob(C)
        $
        同时，$Hom(A, *): C -> C$ 按照如下定义：
        - 对于任意 $A: Ob(C)$，定义：
          $
          funcDef(Hom(*, B), Ob(C), Ob(C), A, Hom(A, B))
          $
        - 对于任意 $f in Hom(A_1, A_2)$，定义：
          $
          funcDef(Hom(*, B), Hom(A_1, A_2), Hom(Hom(A_2, B), Hom(A_1, B)), f, [g : Hom(A_2, B) |-> g compose f])
          $
        成为反变函子，而类似的 $Hom(* , B)$ 成为共变函子。
      + 范畴中有始对象 #Void 和终对象 #boring，也即对于所有的 $Y in Ob(C)$，均有 $Hom(Void, Y)$ 与 $Hom(Y, boring)$ 恰有一个元素。可以证明若范畴中存在始对象和终对象，则在同构的意义下唯一 @代数学引论

      此时，也记 $A -> B := Hom(A, B)$，并称
      - 每个 $C$ 中的对象是一个类型
      - 每个 $C$ 中的态射是类型之间的函数
    ]<type-category>
    这个概念将成为本文最基本的模型。注意这里的类型暂时是非依赖类型。同时，这里并没有断言 $Ob(C)$ 中的一个类型 $A$ 是否是一个集合。一方面，可以认为 $A$ 是一个集合，其中的元素就是该类型的值，态射是值之间的（纯）函数；另一方面，如果有必要，可以认为类型只是一个单点，语言中所有的*项（term）*都由态射组成（典型的，Untyped Lambda Calculus 就可以认为构成对象只有单点，$Hom$ 集是所有 $lambda$ 表达式的语言）。

    使得这个对应合理的最基本事实是，在（函数式）程序语言中最基本的类型推理法则包括：
    -
      $
      #proof-tree(
      rule(
        $Gamma tack f x : B$,
        $Gamma tack x: A$,
        $Gamma tack f: A -> B$,
      )
      )
      $<t-app>
      上面的式子意为：如果上下文 $Gamma$ 中有 $x$ 具有类型 $A$，$f$ 具有类型 $A -> B$，那么 $f x$ 具有类型 $B$
    - 
      $
      #proof-tree(
      rule(
        $Gamma tack g compose f : A -> C$,
        $Gamma tack g: B -> C$,
        $Gamma tack f: A -> B$,
      )
      )
      $<t-abs>
      上面的式子意为：如果上下文 $Gamma$ 中有 $f$ 具有类型 $A -> B$，$g$ 具有类型 $B -> C$，那么 $g compose f$ 具有类型 $A -> C$
    这两者与@category 中我们对范畴的要求不谋而合。
    #remark[][
      这里我们还添加了两个额外要求：
      + 对于类型 $A, B$，$A -> B$ 的所有函数也是一个类型。这在函数式编程语言中非常普遍，然而，并非所有编程语言都符合这个要求，例如在 C 中就不能直接这样构造类型。不过在满足这个要求的前提下讨论问题会带来很多方便，同时这也不是过强的要求（在 C 中实现这样的类型并不困难）。
      + 存在始对象和终对象，它们分别对应没有元素的类型和仅有一个元素的类型。既然假设 $A$ 没有元素，那么 $A -> B$ 的映射当然唯一；假设 $A$ 仅有一个元素，那么 $B -> A$ 的映射当然也唯一。这些类型可以成为后续操作的基础。
    ]

  == #stlc <intro-stlc>
    前一节中，我们仅给出了一个非常抽象的类型模型。前言中多次提到的 #stlc 恰好成为符合这个类型模型最典型的实现。仔细讨论 #stlc 的设计或许是有益的，然而这里由于篇幅和文章重点所限难以实现，只能列出一些基本属性，具体的可以参考 @tapl ：
    - 利用类似 $lam(x, y)$ 的语法，我们可以定义最基本的对象，包括自然数：
      $
      0&: lam(s, (lam(z, z)))\
      1&: lam(s, (lam(z, s z)))\
      ... 
      $ 
      布尔：
      $
      "true"&: lam(t, (lam(f, t)))\
      "false"&: lam(t, (lam(f, f)))
      $
      以及其上的基本运算。这种语言被称为 Untyped Lambda Calculus。
    - 在 Untyped Lambda Calculus 上，赋以直观的类型，包括 $NN, Bool$ 以及经典的类型规则 @t-abs 以及 @t-app，我们就得到了基础的 #stlc。
    可以证明，Untyped Lambda Calculus 是图灵完备的，具有与任何其他图灵完备语言相同的计算能力。
  == 规范化性
    #lemma[][
      #stlc 具有*规范化性*，也即，所有具有良好类型的程序都停机。
    ]<normalization>
    #proof[
      可以参考 @tapl
    ]
    @type-category 给出了非常广泛的定义，可以根据需要选取各种各样的语言。根据 $Ob$ 和 $Hom$ 的丰富程度，我们要在许多因素之间做出取舍：
    - 我们甚至可以取 $C = "Ab"$ 是所有 Abel 群构成的范畴（注意到 Abel 群之间的同态有自然的的 Abel 群结构），然而这样的范畴中 $Ob$ 过于丰富了，不可能作为一个编程语言的基础。
    - 在 Untyped Lambda Calculus 中，$C$ 中只有一个对象（当然不需要进行类型检查），但 $Hom$ 是丰富的，足以达到图灵完备的计算能力。
    - 在 #stlc  中，$Ob$ 和 $Hom$ 都相对简单，这让我们可以进行类型检查。同时，所有合法的程序也都是停机的。
    - 对于通用的程序语言，前言中的介绍表明，我们往往希望计算能力足够强大的同时，类型系统不要过于复杂，以至于无法进行类型检查，这是大多数编程语言的实际选择。
    - 特殊用途的语言，例如定理证明系统，可能希望使用一个规范化的语言，也就是其中所有合法的程序都停机。特别的，用于表达类型的语言往往被希望是规范化的，保证类型检查和推导容易完成。当然，实践上往往也允许舍弃规范化性换取具有更强表达能力的类型系统，例如 Rust 就具有图灵完备的类型系统 @rust-com

    
  == 和类型与积类型
    前面提到，我们希望类型系统既具备强大的表达能力，又不要过于复杂。一个最典型的解决方法是，选取有限个基本类型和若干类型构造规则，只允许按照这些规则进行构造。本节将介绍和类型、积类型两种典型的类型构造方式，它们与范畴论中常用的积和余积是相同的。
    
    #definition[积/余积][
      设 $A, B in Ob(C)$，
      + 若对象 $D$ 满足：
        - 存在态射 $pi_A: D -> A, pi_B: D -> B$ 
        - 以下交换图表：
          #align(center)[#commutative-diagram(
          node((0, 0), $M$, 1),
          node((0, 1), $B$, 2),
          node((1, 0), $A$, 3),
          node((1, 1), $D$, 4),
          arr(1, 2, $f$),
          arr(1, 3, $g$),
          arr(4, 2, $pi_A$),
          arr(4, 3, $pi_B$),
          arr(1, 4, $exists !f times g$)
          )]
          对于任何 $M, f, g$ 都成立，则称 $D$ 是 $A, B$ 的积，记 $D = A times B$
      + 若对象 $D$ 满足：
        - 存在态射：$i_A : A -> D, i_B: B -> D$
        - 以下交换图表：
          #align(center)[#commutative-diagram(
          node((0, 0), $M$, 1),
          node((0, 1), $B$, 2),
          node((1, 0), $A$, 3),
          node((1, 1), $D$, 4),
          arr(2, 1, $f$),
          arr(3, 1, $g$),
          arr(2, 4, $pi_A$),
          arr(3, 4, $pi_B$),
          arr(4, 1, $exists !f times g$, label-pos: right)
          )]
          对于任何 $M, f, g$ 都成立，则称 $D$ 是 $A, B$ 的余积，记 $D = A + B$
      以上两个交换图表被称为积/余积的泛性质，可以证明 @代数学引论 满足泛性质的积/余积是唯一的。
    ]<product-coproduct> 
    #let fst = `first`
    #let sec = `second`
    #let inl = `inl`
    #let inr = `inr`

    #definition[积类型/和类型][
      在类型范畴 $C$ 中，对于任意两个类型 $A, B$：
      - 若 $A, B$ 的积存在，则称之为积类型 $(A, B)$ 或者 $A times B$，此时分别将 $pi_A, pi_B$ 记作  $fst, sec$
      - 若 $A, B$ 的余积存在，则称之为和类型 $A | B$ 或者 $A + B$，此时分别将 $pi_A, pi_b$ 记作 $inl, inr$
    ]
    简单来说，积类型就是两个类型的元素组成的二元组，而和类型就是两个类型的元素进行二选一。同时，上面的泛性质可以翻译成下面更加通俗的语言：
    - 在积类型中，任取符合上面定义的 $f: M -> B, g: M -> A$，可以按照下面的方式构造唯一的函数：
      $
      funcDef(h, M, A times B, m, (f m, g m))
      $
      且与 $fst, sec$ 交换\
      反之，如果我们要构造 $M -> (A, B)$ 的函数，唯一的方式便是分别构造 $M -> A$ 和 $M -> B$ 的函数，也就是指定每个分量。
    - 在和类型中，任取符合上面定义的 $f: B -> M, g: A -> M$，可以按照下面的方式构造唯一的函数：
      $
      h (inl a) &= g a\
      h (inr b) &= f b
      $
      且与 $inl, inr$ 交换\
      （这种语法也被称为*模式匹配（pattern match）*，已经在许多编程语言中得到实现）\
      反之，若要构造 $A + B -> M$ 的函数，唯一的方式便是指定 $A -> M$ 和 $B -> M$ 的函数，也就是指定每个分支。
    #definition[有限积/余积][
      定义三元积：
      $
      A times B times C := A times (B times C) 
      $
      三元余积：
      $
      A + B + C := A + (B + C)
      $
      类似的，可以递归定义任何有限积/余积，并且与结合顺序无关（证明略）。
    ]
    在 @type-category 中，我们给出了所讨论语言的基本要求。当然，这样的语言未必具有和类型或者积类型。要想实现这两种构造，简单来说需要添加类型规则以及相应的语法规则，求值规则。这些规则的设计和实现是编程语言设计中的重要问题，这里不再详细讨论，只假定之后讨论的语言具有这些语法和规则（典型的，具有积/和拓展的 #stlc 以及 Haskell 语言）。有趣的是，关于积类型有如下的结论：
    #theorem[][
      设 $C$ 是如 @type-category 定义的类型范畴，则存在类型范畴 $C'$，使得其中对象是 $C$ 中对象或者 $C$ 中对象经过若干次积、 $Hom$ 构造得到，其中态射被 $C$ 中态射确定，且它对 $Hom$、积运算封闭。这样的范畴称为 $C$ 产生的*自由笛卡尔闭范畴*。
    ]<free-CCC>
    #proof[
      我们可以非常显式的写出目标范畴 $C'$ 的定义。其对象集 $O$ 是由以下类型构造规则递归定义的集合：
      - $t in Ob(C) => t in O$
      - $A, B in O => A times B in O$
      //- $A, B in O => A + B in O$
      - $A, B in O => Hom(A, B) in O$
      同时，类似的给出态射集的递归定义：
      - $t_1, t_2 in Ob(c) => Hom_C' (t_1, t_2) := Hom_C (t_1, t_2)$
      - 
        $
        A, B in O => Hom(A times B, M) &:= Hom(A, Hom(B, M)) in O\ 
          Hom(N, A times B) &:= Hom(N, A) times Hom(N, B) in O
        $
      我们说明，以上规则是合法的且足以定义 $C'$：
      - 首先，需要验证两条规则是一致的，也即：
        $
        Hom(A, Hom(B, C times D))  = Hom(A times B, C times D) = Hom (A times B, C) times Hom (A times B, D) 
        $
        上式右端等于：
        $
        Hom(A, Hom(B, C)) times Hom(A, Hom(B, D))
        $
        左端等于：
        $
        Hom(A, Hom(B, C) times Hom (B, D))
        $
        两者确实是相等的
      - 其次，验证上面两条 $Hom$ 规则是可终止的。为此，设 $A$ 是某个定义好的对象，注意到它是前面几条规则的有限次构造，可设其中使用了 $l(A)$ 次乘法规则，显然 $l(A) = 0 => l in Ob(C)$\
        我们用归纳法，假设所有 $l <= n$ 的对象以及 $l < n$ 的对象之间的态射已被定义，考虑规则：
        $
        Hom(A times B, M) = Hom(A, Hom(B, M))
        $
        上式右侧的 $l$ 较左侧减一，因此已被定义
        $
         Hom(N, A times B) = Hom(N, A) times Hom(N, B)
        $
        已经假设 $l(Hom(N, A times B)) = n$，则不难发现 $l(Hom(N, A) times Hom(N, B)) = n$ 且是对象，因此已被定义，从而 $Hom(N, A) times Hom(N, B)$ 一定也已经定义
      - 我们还要说明若 $max(l(M), l(N)) = n$，则 $Hom(M, N)$ 也已经确定。先考虑 $M$：
        - 假设 $M = U times V$，则已经定义
        - 否则，注意到 $M$ 的构造事实上是树形结构，可以找到深度最低的一个使用乘规则定义的节点，考虑其上层：
          - 若为 $Hom(U times V, W)$ 则按定义有自然同构：
            $
            Hom(U times V, W) tilde.eq Hom(U, Hom(V, W))
            $这使得 $M$ 同构于 $M'$ ，其中 $l(M') < l(M)$
          - 若为 $Hom(W, U times V)$，则有自然同构：
            $
            Hom(W, U) times Hom(W, V) tilde.eq Hom(W, U times V)
            $
            导致 $times$ 的深度进一步降低
          不断进行上面的步骤，要么最终 $M = U times V$ 从而定义已经完成，要么 $l(M)$ 可以降低
        当然 $N$ 也可以做类似操作，因此要么由归纳假设要么由之前的规则 $Hom(M, N)$ 一定已经定义
      - 最后，$Hom$ 之间的复合映射也可以类似的显式给出，这里不再赘述

      // - 
      //   $
      //   A, B in O => Hom(A + B, M) = Hom(A, M) times Hom(B, M)\ Hom(N, A + B) = Hom(N, A) + Hom(N, B)
      //   $
    ]<consturct-CCC>
    #corollary[][
      若 $C$ 对应的语言具有规范化性，则其自由笛卡尔闭范畴 $C'$ 也具有规范化性。
    ]<free-CCC-normal>
    #proof[
      注意到 $C'$ 中的态射都是 $C$ 中态射进行有限次组合得到的，结论是显然的。
    ]

    @free-CCC 表明，之前提到的积类型具有由证明过程给出的典范构造。换言之，它并不会实际提升语言的表达能力，其中的关键是证明过程中出现的：
    $
    Hom(A times B, M) tilde.eq Hom(A, Hom(B, M))
    $
    这被称为 *Curry化*，它的存在允许在函数式语言中使用 $Hom(A, Hom(B, M))$ 表示二元函数而不是数学中更常用的 $Hom(A times B, M)$

    与积类型的情形不同，和类型只有典范同构：
    $
    Hom(A + B, N) tilde.eq Hom(A, N) times Hom(B, N)
    $
    但 $Hom(M, A + B)$ 无法简单的确定，这也表明和类型的添加确实可能提升语言的表达能力，例如下面的 Haskell 函数：
    ```haskell
    func : Bool -> A + B
    func True = inl a
    func False = inr b
    ```
    在 #stlc 中就是不可能的，既然其中不允许将两种不同的类型组成同一个表达式。

    #definition[类型系统 2][
      后文所称的类型系统是指范畴 $C$ ，满足要求：
      - 满足 @type-category 条件
      - 对有限积和有限余积封闭
    ]<type-category2>
    #let Fin = `Fin`
    #let Maybe = `Maybe`
    #let Just = `Just`
    #let Nothing = `Nothing`
    #example[][
      有了积类型以及和类型，我们可以构造出许多常用的类型和类型构造子：
      - 记 $Fin_n = n dot () = () + () + ... + ()$ 是 $n$ 元有限类型。
      - 记 `Maybe A := A + ()`，此时通常称 $Just := inl, Nothing := inr$，换言之 `Maybe A` 的对象是以下两种情况之一：
        - $Just a$
        - `Nothing`
        它的作用在于处理一些有可能出错的函数。注意到之前我们假设态射 $A -> B$ 应该恰好对于 $A$ 的对象得到 $B$ 的对象，然而实践上并不容易保证。例如，假设我们要处理函数 $ln x: ? -> RR$，将会面临以下窘境：
        - 认为 $ln x: RR -> RR$，这是断然不行的，既然对于 $<=0$ 的实数 $ln$ 都无法定义
        - 认为 $ln x: RR^+ -> RR$，看似可行，然而稍加分析就会发现按照类似的逻辑我们需要认为：
          $
          ln(x-a) :RR^(>= a) -> RR
          $
          导致我们被迫使用依赖类型，这是十分麻烦的。
        因此，一个有些逃避但有效的方法是认为 $ln x : RR -> Maybe RR$，将定义域不全带来的麻烦推迟到 $ln$ 函数的类型之外解决。我们不能希望类型解决一切问题，但 `Maybe` 的使用明确的告诉了我们这里有类型不能解决的问题，这是十分有益的。
    ]
    
  == 积/和的函子性<functor>
    @type-category2 保证我们在 $C$ 中可以做任意有限和以及有限积。在上节的讨论中我们发现，积/和不仅作用于对象，在态射上同样也有作用，这就是下面要给出的函子性：
    #theorem[][
      设 $C$ 是满足 @type-category2 的类型范畴，则 $forall A in Ob(C)$，以下：
      $
      (*, A) &:= B |-> (B, A)\
      (A, *) &:= B |-> (A, B)\
      * + A &:= B |-> A + B\
      A + * &:= B |-> B + A
      $
      都是 $C -> C$ 的函子。
    ]<functor-product>
    #proof[
      就是 @product-coproduct 的简单推论
    ]
    函子的概念看似只是抽象废话，但它确实能在许多场景发挥作用，例如假设我们有函数：
    ```haskell
    f:: A -> B
    f a = ...
    ```
    它的功能是做某种计算。之后由于上游发生变化或者其他考虑，我们希望它能处理 `Maybe A` 的参数，也即输入 `Nothing` 时输出 `Nothing`，按照通常的 Haskell 模式匹配语法需要写成：
    ```haskell
    f' :: Maybe A -> Maybe B
    f (Just a) = Just (f a)
    f Nothing = Nothing
    ```
    然而，假如对函子的概念十分熟练，不难验证上面的 `f'` 恰好就是 `Maybe f`（注意到 @functor-product 表明 `Maybe` 确实是函子），这可以为我们带来方便。

    更有趣的是，用函子处理不仅能带来书写上的便利，还可以为编译器提供高层的优化可能。例如假设我们有函数 `f, g` ，它们有时独立使用，有时复合使用。在 C++ 语言中类似：
    ```CPP
    B f(A a) {...}
    C g(B b) {...}
    D h(A a) {return g(f(a));}
    ```
    现在要全部改成 #Maybe 版本（C++ 中不使用 #Maybe 而是 `std::optional`，逻辑是类似的，为了统一我们仍写成 #Maybe）：
    ```CPP
    Maybe<B> f1(Maybe<A> a) {if (a.isNothing()) return Nothing; return f(a.value());}
    Maybe<C> g1(Maybe<B> b) {if (b.isNothing()) return Nothing; return g(b.value());}
    Maybe<D> h1(Maybe<A> a) {return g1(f1(a));}
    ```
    看起来十分自然，然而仔细分析就会发现这里多做了一次无用的检查，既然 `f1` 对于有效值应该返回有效值。解决这一问题的方法是：
    - 寄希望于编译器进行分析，然而这在 `f, g` 非常复杂时是极为困难的，编译器很难确定其中的值是否会变成 `Nothing`
    - 手动实现 `h1`，调用原始的 `f, g` ，这意味着 `f, g` 两个函数要必须要同时向外提供带检查和不带检查两个版本，实际工作中也会有些麻烦。当然在 C++ 中确实可以通过精巧的模板和重载解决这个问题，但重载本身又会引入新的工程问题。
    在函数式语言中，我们会写成：
    ```haskell
    f1 = Maybe f
    g1 = Maybe g
    h = f1 . g1
    ```
    （Haskell 中使用 `fmap` 语法而非直接将单子作用于函数，但是实质是一样的，为了理解方便暂且如此书写）\
    看似在 `f1 compose g1` 仍会出现两次检查，然而将表达式拆开，它恰好是 `(Maybe f) compose (Maybe g)`，由函子的定义，它一定等于 `Maybe (f compose g)`，后者只做一次检查。一般而言，使用这样的函子律进行表达式替换总是能提升程序的性能，而正确性由函子的定义保证，与 `f, g` 的实现有多么复杂无关，编译器进行这个优化远比 C++ 情形容易得多，因此已经在函数式编程领域得到应用@ghc-rewrite

    事实上，这样的优化能够进行，归根到底是范畴论的抽象为编程语言提供了兼具易用性和简单性（编译器能够简单地确定一些性质进行优化）的模型，下一章单子部分也会进一步展示这一点。
= 副作用与单子
    关于本章内容的深入讨论，可以参考 @moggi1989abstract
  == 副作用<side-effect>
    前面的讨论中，我们总是认为程序中的函数就是如同数学上的函数一样是一个固定的一一对应。然而在大多数（过程式）语言中，函数更像是一个不完全封闭的代码块，以下的 C++ 代码：
    ```CPP
    int a = 0;
    void fun(int input)
    {
      a++;
      return input + a;
    }
    ```
    描述的事情是非常常见的。这里的 `++` 就是一个带有副作用的函数，它的执行让外部环境（`a` 的值）发生了改变。这种行为用纯函数式的语法并非不能模拟，考虑：
    ```haskell
    EnvWithLocalVarA T = (T, Int)
    aplus :: EnvWithLocalVarA T -> EnvWithLocalVarA T
    aplus (t, cur_a) = (t, cur_a + 1)
    fun :: EnvWithLocalVarA Int -> Int
    fun input = (fst (aplus input)) + (sec (aplus input))
    ```
    这个想法，简单来说，就是将带有环境的值认为是从值构造出的新类型。这个想法在之前 #Maybe 之中也有体现。然而，上面的语法不免过于复杂，是否存在简化空间呢？以 #Maybe 为例，考虑定义这样一个函数：
    $
    f(x) = 1/(x - 1/y)
    $
    并希望不合法的值都返回 #Nothing，我们把它拆成两个函数的复合：
    ```haskell
    f1 :: Double -> Double -> Maybe Double
    f1 x y = if y == 0 then Nothing else x - 1 / y
    f2 :: Double -> Maybe Double
    f2 x = if x == 0 then Nothing else 1 / x
    ```
    大致来说，`f = f2 . f1`，然而观察类型，我们没有说明如何把 `Maybe Double` 的值输入 `f2` 中，有两种想法：
    - 方法一：手动书写：
      ```haskell
      f :: Double -> Double -> Maybe Double
      f x y = case f1 x y of
        Nothing -> Nothing
        Just a -> f2 a
      ```
    - 方法二：@functor 中提到，`Maybe` 是一个函子，而 `Maybe f` 恰好接收 `Maybe Double` 类型的参数，因此可以：
      ```hs
      f' :: Double -> Double -> Maybe (Maybe Double)
      f' = (Maybe f2) . f1
      helpf :: Maybe (Maybe Double) -> Maybe Double
      helpf Nothing = Nothing
      helpf (Just Nothing) = Nothing
      helpf (Just (Just a)) = Just a
      ```<way-2>
    尽管都十分麻烦，但仔细思考就会发现，方案二中的 `helpf` 函数似乎是有一般性的，它将嵌套的 `Maybe` 函子降低一层。这也符合我们的设想，既然我们希望 `T a` 代表 "带有副作用的 `a` 类型"，那么 `T T a` 似乎是 "带有副作用的带有副作用的 `a` 类型"，似乎本来就应该典范的同态到 `T a` 。@category 中提到，所谓的典范同态在范畴论中就是函子间的自然变换，此处似乎就是 `T T` 与 `T` 之间存在一个自然变换。
  == 单子 
    #let returnF = `return`
    #let join = `join`
    #let small(body) = text(size: 9pt)[#body]
    #definition[单子][
      类型范畴 $C$ 上的一个单子是指：
      - 一个自函子 $F: C -> C$
      - 一个自然变换 $returnF : id -> C$
      - 一个自然变换 $join: F^2 -> F$
      满足：
      - #returnF 是单位元，也即对于 $forall a in Ob(C)$ 有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $F^2 a$, 1),
        node((0, 1), $F a$, 2),
        node((1, 0), $F a$, 3),
        node((0, -1), $F a$, 4),
        arr(2, 1, $small(returnF : F a -> F^2 a)$, label-pos: right),
        arr(4, 1, $small(F (returnF: a -> F a))$),
        arr(4, 3, $id$),
        arr(2, 3, $id$),
        arr(1, 3, $join$),
        
        )]
      - 结合律，也即对于 $forall a in Ob(C)$ 有交换图：
        #align(center)[#commutative-diagram(
        node((0, 0), $F F F a$, 1),
        node((0, 1), $F F a$, 2),
        node((1, 0), $F F a$, 3),
        node((1, 1), $F a$, 4),
        arr(1, 2, $small(F (join : F F a -> F a))$),
        arr(1, 3, $small((join : F F (F a)-> F (F a)) )$, label-pos: right),
        arr(2, 4, $join$),
        arr(3, 4, $join$),)]
    ]<Monad-def-join>
    这里，#returnF 是将无副作用的值包装起来，#join 则是如上节所述，将函子作用后的二次副作用简化。结合律则是说，对于三次甚至以上副作用，可以按照任何顺序利用 #join 进行简化。这也是符合直觉的，毕竟正如上节所述，带有两层副作用的值和带有多层副作用的值都应该典范的同态于带有一层副作用的值。
    #remark[][
      需要注意的是，如果要在编程语言中实现“自然变换”，我们要实现一种多态函数，例如：
      ```hs
      joinMaybe :: Maybe(Maybe a) -> Maybe a
      joinMaybe Nothing = Nothing
      joinMaybe (Just Nothing) = Nothing
      joinMaybe (Just (Just x)) = Just x
      ```
      也就是希望这个定义对所有类型 `a` 起作用。多态的实现也是类型系统中非常重要的课题，@tapl @categorical-logic @moggi1989abstract 中都有相关讨论。这里我们暂且略过这部分讨论，假设我们已经实现了符合直觉的多态系统。
    ]<maybe-join>
    #theorem[][
      #Maybe 是单子，其中：
      - #returnF 定为：
        ```hs
        returnF :: a -> Maybe a
        returnF x = Just x
        ```
      - #join 如 @maybe-join 中定义
    ]
    #proof[
      仔细验证 @Monad-def-join 中所有性质：
      #let Justx = `Just x`
      - #returnF 是自然变换：
        #align(center)[#commutative-diagram(
        node((0, 0), $a: A$, 1),
        node((0, 1), $b: B$, 2),
        node((1, 0), $Just a: Maybe A$, 3),
        node((1, 1), $Just b: Maybe B$, 4),
        arr(1, 2, $f$),
        arr(1, 3, $returnF$),
        arr(2, 4, $returnF$),
        arr(3, 4, $Maybe f$),)]
      - #join 是自然变换：
        #align(center)[#commutative-diagram(
        node((0, 0), $Just^2 a: Maybe^2 A$, 1),
        node((0, 1), $Just^2 b: Maybe^2 B$, 2),
        node((1, 0), $Just a: Maybe A$, 3),
        node((1, 1), $Just b: Maybe B$, 4),
        arr(1, 2, $F^2 f$),
        arr(1, 3, $join$),
        arr(2, 4, $join$),
        arr(3, 4, $F f$),)]
      - 先讨论单位元，既然 $Maybe$ 无非 `Nothing, Just x` 两种，分别代入定义：
        #align(center)[#commutative-diagram(
          node((0, 0), $Just Nothing$, 1),
          node((0, 1), $Nothing$, 2),
          node((1, 0), $Nothing$, 3),
          node((0, -1), $Nothing$, 4),
          arr(2, 1, $small(returnF : F a -> F^2 a)$, label-pos: right),
          arr(4, 1, $small(F (returnF: a -> F a))$),
          arr(4, 3, $id$),
          arr(2, 3, $id$),
          arr(1, 3, $join$),
          
        )]
        #align(center)[#commutative-diagram(
          node((0, 0), $Just (Justx)$, 1),
          node((0, 1), $Justx$, 2),
          node((1, 0), $Justx$, 3),
          node((0, -1), $Justx$, 4),
          arr(2, 1, $small(returnF : F a -> F^2 a)$, label-pos: right),
          arr(4, 1, $small(F (returnF: a -> F a))$),
          arr(4, 3, $id$),
          arr(2, 3, $id$),
          arr(1, 3, $join$),
          
        )]
      - 再讨论结合性，需要考虑 $Maybe^3$ 的四种情形： 
        $
        Nothing, Just (Nothing), Just( Just (Nothing)), Just (Just (Justx))
        $
        分别画出图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $Nothing$, 1),
        node((0, 1), $Nothing$, 2),
        node((1, 0), $Nothing$, 3),
        node((1, 1), $Nothing$, 4),
        arr(1, 2, $small(F (join : F F a -> F a))$),
        arr(1, 3, $small((join : F F (F a)-> F (F a)) )$, label-pos: right),
        arr(2, 4, $join$),
        arr(3, 4, $join$),)]
        #align(center)[#commutative-diagram(
        node((0, 0), $Just (Nothing)$, 1),
        node((0, 1), $Just (Nothing)$, 2),
        node((1, 0), $Nothing$, 3),
        node((1, 1), $Nothing$, 4),
        arr(1, 2, $small(F (join : F F a -> F a))$),
        arr(1, 3, $small((join : F F (F a)-> F (F a)) )$, label-pos: right),
        arr(2, 4, $join$),
        arr(3, 4, $join$),)]
        #align(center)[#commutative-diagram(
        node((0, 0), $Just( Just (Nothing))$, 1),
        node((0, 1), $Just (Nothing)$, 2),
        node((1, 0), $Just (Nothing)$, 3),
        node((1, 1), $Nothing$, 4),
        arr(1, 2, $small(F (join : F F a -> F a))$),
        arr(1, 3, $small((join : F F (F a)-> F (F a)) )$, label-pos: right),
        arr(2, 4, $join$),
        arr(3, 4, $join$),)]
        #align(center)[#commutative-diagram(
        node((0, 0), $Just( Just (Justx))$, 1),
        node((0, 1), $Just (Justx)$, 2),
        node((1, 0), $Just (Justx)$, 3),
        node((1, 1), $Justx$, 4),
        arr(1, 2, $small(F (join : F F a -> F a))$),
        arr(1, 3, $small((join : F F (F a)-> F (F a)) )$, label-pos: right),
        arr(2, 4, $join$),
        arr(3, 4, $join$),)]
      尽管有些繁琐，不过这些过程应当能更加充分地体现单子定义中两条规则的含义。
    ]
  == bind 与 do-notation
    #let bind = `bind`
    有了单子的定义，我们可以定义一个新的操作，它将一个带有副作用的函数应用到一个带有副作用的值上，这个操作被称为 `bind`，它的定义如下：
    #let xc = `x`
    #let idc = `id`
    #let Fc = `F`
    #let fc = `f`
    #let gc = `g`
    #let ac = `a`
    #definition[bind][
      对于单子 $F$，定义 `bind` 操作：
      ```hs
      bind :: (a -> F b) -> F a -> F b
      bind f x = join ((F f) x)
      ```
      等价的：
      $
      bind fc = join compose (Fc fc)
      $
      这里 `F f : F a -> F F b, (F f) x : F F b`\
      一般的，记：
      ```hs
      x >>= f = bind f x
      ```
    ]<bind-def>
    仔细观察就会发现这就是 @side-effect 结尾的方法一的推广。
    #lemma[][
      #bind 函数满足：
      - 右单位：
        ```hs
        x >>= return = x
        ```
        等价的：
        $
        bind returnF = idc
        $
      - 左单位：
        ```hs
        return a >>= f = f a
        return f >>= (\x -> (\y -> return (x y))) = \y -> return (f y)
        ```
        等价的：
        $
        (bind fc) compose returnF = fc
        $
      - 结合律：
        ```hs
        (x >>= f) >>= g = x >>= (\a -> f a >>= g)
        ```
        等价的：
        $
        bind ((bind gc) compose fc) = (bind gc) compose (bind fc)
        $
    ]<bind-property>
    #proof[
      -   
        $
        bind returnF  = join compose (Fc returnF ) = idc  
        $
        这来自 $returnF$ 的单位元性
      - 
        $
        (bind fc) compose returnF = join compose (Fc fc) compose returnF 
        $
        由 #returnF 是自然变换：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $B$, 2),
        node((1, 0), $F A$, 3),
        node((1, 1), $F B$, 4),
        arr(1, 2, $f$),
        arr(1, 3, $returnF $),
        arr(2, 4, $returnF$),
        arr(3, 4, $F f$),)]
        上式化简到：
        $
        join compose returnF compose fc
        $
        由单位元性，上式就是 $fc$
      - 
        $
        bind [ac |-> bind gc (fc ac)]
        &= join compose (Fc [ac |-> bind gc (fc ac)])\
        &= join compose (Fc ((join compose Fc gc) compose fc))\
        &= join compose (Fc (join compose Fc gc) compose (Fc fc))\
        &= join compose Fc join compose Fc^2 gc compose (Fc fc) "（函子性）"\
        &= join compose  join compose Fc^2 gc compose (Fc fc)\
        $
        这里 #join 是自然变换给出：
        #align(center)[#commutative-diagram(
        node((0, 0), $F A$, 1),
        node((0, 1), $F B$, 2),
        node((1, 0), $F^2 A$, 3),
        node((1, 1), $F^2 B$, 4),
        arr(1, 2, $F g$),
        arr(3, 1, $join$),
        arr(4, 2, $join$),
        arr(3, 4, $F^2 g$),)]
        上式等于：
        $
         &join compose Fc gc compose join compose (Fc fc)\
         &= (join compose Fc gc) compose (join compose Fc fc)\
         &= (bind gc) compose (bind fc)
        $
        证毕
    ]
    #let idc = `id`
    #theorem[][
      假设函子 $F$ 具有：
      - 多态函数 `return: a -> F a`，满足: 
        - $(returnF fc)(returnF ac) = returnF (fc ac)$，也即 $returnF$ 是自然变换
      - 如 @bind-def 中定义的多态函数 #bind 函数，并且满足 @bind-property 中的性质
      - 兼容性：$bind (returnF compose fc) = Fc fc $
      ，则 $F$ 是一个单子，并有：
      $
      join  = bind (idc : Fc ac -> Fc ac)
      $
    ]
    #proof[
      依次证明：
      - #join 是自然变换：
        #align(center)[#commutative-diagram(
        node((0, 0), $F^2 A$, 1),
        node((0, 1), $F^2 B$, 2),
        node((1, 0), $F A$, 3),
        node((1, 1), $F B$, 4),
        arr(1, 2, $F^2 f$),
        arr(1, 3, $bind idc$),
        arr(2, 4, $bind idc$),
        arr(3, 4, $F f$),)]
        也即：
        $
        Fc fc compose (bind idc) = (bind idc) compose Fc^2 fc
        $
        由兼容性：
        $
        Fc fc compose (bind idc) &= (bind (returnF compose fc)) compose (bind idc) \
        &= bind (bind (returnF compose fc) compose idc)\
        &= bind (bind (returnF compose fc))
        $
        $
        (bind idc) compose Fc^2 fc &= (bind idc) compose  bind (returnF compose Fc fc)\
        &= bind ((bind idc )compose (returnF compose Fc fc))\
        &= bind ((bind idc )compose (returnF compose bind (returnF compose fc)))\
        &= bind (((bind idc )compose returnF) compose bind (returnF compose fc))\
        &= bind (idc compose bind (returnF compose fc))\
        &= bind (bind (returnF compose fc))\
        $
      - 单位性1 ：$join compose returnF = idc$
        $
        join compose returnF = (bind idc) compose returnF = idc
        $
      - 单位性2：$join compose (F returnF) = idc$
        $
        join compose (F returnF)
         &= (bind idc) compose (bind (returnF compose returnF))\
         &= bind (bind idc compose (returnF compose returnF) )\
         &= bind ((bind idc compose returnF) compose returnF )\
         &= bind ((idc) compose returnF )\
         &= bind (returnF )\
         &= idc\
        $
      - 结合性：$join compose Fc join = join compose join$
        $
        join compose Fc join &= (bind idc) compose bind (returnF compose (bind idc))\
        &= bind ((bind idc) compose (returnF compose (bind idc)))\
        &= bind ((bind idc compose returnF) compose (bind idc))\
        &= bind (idc compose (bind idc))\
        &= bind idc compose bind idc\
        &= join compose join\
        $
        证毕
    ]
    #remark[][
      这种直白的定义方式可以抽象成所谓的*Kleisli 三元对*，这里不再介绍，可以参考 @moggi1989abstract
    ]
    有了这些方便的函数，我们可以定义一种新的*语法糖*，它将一系列的 `bind` 函数调用简化为一种更加直观的形式，这就是 `do` 语法：
    #definition[do-notation][
      对于单子 $F$，定义 `do` 语法：
      ```hs
      do {ac <- x; fc; gc; ...} = x >>= (\ac -> fc >>= (\_ -> gc >>= (\_ -> ...)))
      ```
    ]
    这种语法可以大幅度简化 #bind 的书写，例如：
    ```hs
    f :: Int -> Maybe Int
    g :: Int -> Maybe Int
    h :: Int -> Maybe Int
    fgh :: Int -> Maybe Int
    fgh x = do
      a <- f x
      b <- g a
      c <- h b
      return c
    ```
  == State 与 IO
    #let State = `State`
    最后，我们终于可以用单子的概念解决前言中提出的问题。首先是 #State 单子，它的定义如下：
    #definition[State][
      对于一个类型 $S$，定义 $State S a$ 为一个带有状态的函数，它的输入是一个状态 $S$，输出是一个值 $a$ 以及一个新的状态 $S$。它的定义如下：
      ```hs
      State s a = State {runState :: s -> (a, s)}
      ```
      对于给定的状态类型 $s$，它是一个单子，其中：
      - #returnF 定为：
        ```hs
        returnF :: a -> State s a
        returnF x = State (\s -> (x, s))
        ```
      - #join 定为：
        ```hs
        join :: State s (State s a) -> State s a
        join (State f) = State (\s -> let (State g, s') = f s in g s')
        ```
      证明略。可以定义以下符合字面意思的函数：
      ```hs
      get :: State s s
      put :: s -> State s ()
      evalState :: State s a -> s -> a
      ```
      具体定义及细节可以参考 @haskell-intro
    ]
    #example[][
      以下 C++ 代码：
      ```cpp
      int fun(int x)
      {
        int a = x + 1;
        int b = x + 2;
        a++;
        b++;
        return a * b;
      }
      ```
      可以使用 `State (int, int)` 翻译为：
      ```hs
      geta = fst.get
      getb = snd.get
      puta newa = do
        (_, b) <- get
        put (newa, b)
      putb newb = do
        (a, _) <- get
        put (a, newb)
      fun :: int -> int
      fun x = runState (do
        put (x + 1, x + 2)
        puta (geta + 1)
        putb (getb + 1)
        return (geta * getb)
      ) (0, 0)
      ```
    ]
    这看似颇为繁琐，但令人惊喜的是，我们在本章实质上只添加了语法糖，没有改变语言本身的性质。例如，注意到上面的代码完全可以看作是只具有积类型拓展的 #stlc 中的程序，由 @normalization 结合 @free-CCC-normal 可以知道上面的程序一定是停机的，与其等价的 C++ 程序也确实停机。尽管这是非常显然的事实，但如果我们选取更加复杂的具有规范化性的语言（例如包含某种结构化递归），我们或许能得到相当范围内的 C++ 程序是停机的。
    
    这种转化，化归思想在程序语言相关的研究之中非常常见，而范畴论的观点提供了单子这样一种强大的转化工具。

    在前言中，我们提到 IO 是带有副作用的操作，这是无法逃避的事实，而单子提供了这样一种工具：它尽可能的将带有副作用的操作统一成纯函数，仅在最后交予上层实际执行。例如，在以下程序中 ：
    ```hs
    main :: IO ()
    main = do
      putStrLn "Hello, world!"
      input <- getLine
      putStrLn input
    ```
    `IO` 是语言预先提供的单子，上面的程序看似是依次执行三个函数（效果也确实如此），实则是将两个打印函数使用之前定义的 #bind, #returnF 等函数将三个函数组合在一起，分别具有类型：
    ```hs
    putStrLn :: String -> IO ()
    getLine :: IO String
    ```
    范畴强大的表达能力让我们能够实现将复杂的副作用尽可能压缩、统一、组合，得到非常优美的结果，这也是这种模型的成功之处。
= 结语与展望
  本篇文章从基础的类型范畴，逐渐引入基础的类型构造方式，再到最后单子的精彩应用，体现了范畴论观点与程序语言的紧密联系，并以规范化性为例展示了以范畴作为模型在实际研究之中的有效之处。当然，这种模型的威力不止于此，例如在 @functor 中所提到的特殊优化方法，同样可以进一步应用于单子律，同样的，从根本上得益于类型与范畴提供的简单清晰的抽象模型。
  
  然而，本文所设计的模型只是非常简单而初步的模型，与实际有效应用的模型仍然相去甚远。同时，对于在形式化数学领域非常基础的依赖类型与 #martin-lof，虽然大体思想类似，但很多具体的视角需要修改（例如不再能认为类型是范畴中的对象，典型的处理是看作某个态射上的纤维）。更加深入，复杂的类型系统需要更加复杂的范畴论工具，这些都是作者未来需要学习的方向。

#pagebreak()
#bibliography("ref.bib",
  style: "ieee"
)
