#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "软件分析",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
)
= 前言
  == 基本概念
    给定软件系统，回答关于系统行为有关问题的技术称为软件分析技术。能否彻底避免软件中出现特定类型（例如内存泄漏）的缺陷？逻辑上而言这是不可能的，既然编程语言中总有无法证明的表达式 $T$，则以下程序：
    ```c
    a = malloc(10);
    if (T) free(a);
    return
    ```
    显然程序有内存泄漏当且仅当 $T$ 不是永真式。仿照停机问题，也可以构造：
    ```c
    void Evil() {
      int a = malloc();
      if (LeakFree(Evil)) return;
      else free(a); return;
    }
    ```
    称存在算法判定的问题为可判定问题，否则称为不可判定问题。
    #theorem[Rice][
      假设将任意程序看成输入到输出的函数，则关于这个函数的任何非平凡属性都不可判定。其中平凡属性指对所有程序都成立或都不成立的属性（命题）。
    ]
    #proof[
      给定非平凡性质 $P$，不妨假设空集（无输出，包括不停机的程序）不满足 $P, "ok_prog"$ 满足性质 $P$，并假设检测该性质的算法为 $"P_holds"$，如下程序：
      ```c
      Bool Halt(program q){
        void evil(Input n){
          Output v = ok_prog(n);
          q();
          return v;
        }
        return P_holds(evil);
      }
      ```
      是一个判定停机问题的程序，这是荒谬的。
    ]
    #remark[][
      - Rice's theorem 中将程序抽象成函数，涉及程序结构的问题并不在讨论范围内，例如说程序中使用变量是否超过 50 个，这不是程序对应函数的性质。
      - 上述的讨论均针对抽象的u图灵机或者无限的自动机，然而真实计算机内存是有限的，事实上现实计算机只是有限状态机，其停机性是可判定的。这个技术称为模型检查，在硬件领域被广泛应用，但在软件领域因为状态数过多无法应用。
    ]
    现实中的软件分析往往采用工程式的思想，虽然不能给出完全正确的算法，但可以设计一些“近似”算法，允许它检查出一些程序，不能检查出另外的程序。
    - 只判定“是”或者“不知道”的近似称为下近似/must analysis，例如问题是程序是否有某种 Bug，则测试是一种 must analysis
    - 只判定“否”或者“不知道”的近似称为上近似/may analysis
    对于非判定问题，同样也可以有下近似或者上近似，例如返回目标集合的超集或者子集。

    另外，我们还有一些逻辑用语：
    - 正确性：Soundness，指逻辑系统的推导规则是正确的，即如果前提为真，则结论也为真，类似于 Must 分析
    - 完备性：Completeness，指逻辑系统的推导规则是完备的，即如果结论为真，则可以被推导出来，类似于 May 分析
    #remark[][
      程序分析早期源于编译器优化，在优化领域 Soundness 往往指编译器的改写是正确的（也叫 Safety），此时具体而言可能是 Must 分析和 May 分析的其中一个。
    ]
    本门课程涉及的技术本质来说可以分为抽象和搜索。
  == 抽象
    给定表达式语言：
    #let pterm = ``` term {x > 0}```
    #let nterm = ``` term {x < 0}```
    #let zterm = ``` term {x = 0}```
    #let term = ``` term```
    ```haskell
    term := term + term 
          | term * term 
          | term - term 
          | integer
          | variable
    ```
    若 $a, b, c >= 0$，希望得到 $a + b * c >= 0$，一般而言我们会设置：
    - 抽象域：将所有输出分成几类，例如 #pterm, #nterm, #zterm, #term
    - 计算规则，例如：
      - #pterm $+$ #pterm = #pterm
      - #pterm $*$ #pterm = #pterm
      - ......
    运用规则对抽象域进行运算即可。

    更广泛的，抽象技术被广泛用于程序分析的过程分析。

  == 搜索
    判断以下程序是否发生内存泄漏：
    ```c
    if (a == b && c == d && a != b) x = malloc();
    return;
    ```
    为了判断程序是否内存泄漏，理论上我们就是要搜索输入空间，判断是否存在输入使得程序发生内存泄漏。当然实践上通常引入各种剪枝和推断等方法。具体而言，表达式 ```c a == b && c == d && a != b``` 只是三个布尔变量的和，我们可以先枚举所有布尔值，再去判断是否存在输入恰好满足对应的布尔值。

    一般而言，抽象给出的是所有执行情况的不精确分析，搜索考虑一部分执行的精确分析。两者往往结合使用，例如抽象出程序的执行情况，再搜索其中的一部分情况。
  == 程序语言基础知识
    - 语法（syntax)：程序的静态书写方式
    - 语义（semantic）：程序的动态执行行为
    #definition[文法][
      文法是一个四元组 $(N, T, P, S)$，其中 $N$ 是非终结符集合，$T$ 是终结符集合，$P$ 是产生式集合，$S in N$ 是开始符号。

      例如，取 $N = {S, A}, T = {a, b}, P = {S -> a A b, a A -> a a A b, A -> epsilon}$，则通过变化：
      $
      S &=> a A b\
      &=> a a A b b\
      &=> a a a A b b b\
      &=> a a a b b b
      $
      可以得到一个终结符号串。所有这样的终结符号串的集合称为文法 $G$ 生成的语言。

      文法可以分成以下几类：
      - 正则文法：只有一种产生式形式 $A -> a B$ 或者 $A -> a$ 或者 $S -> epsilon$
      - 上下文无关文法：产生式左边只有单个非终结符，例如 $A -> a B$
      - 上下文有关文法：允许书写 $alpha A beta -> alpha gamma beta$，但不允许上下文 $alpha, beta$ 改变
      - 任意文法，等价于图灵机
    ]
    #remark[][
      习惯上，现代程序语言使用正则语言将字符串解析成 token，再将 token 作为终结符采用上下文无关文法描述整个语言。对于更复杂的文法，目前还没有高效的解析算法，也并不常用。
    ]
    对于语义，我们往往采取以下几种：
    - 操作语义：将程序元素解释为计算步骤
    - 指称语义：解释为数学中严格定义的符号
    - 公理语义：严格写出前条件，后条件，使用霍尔逻辑推导
    某种意义上，程序分析就是输入程序语法，返回程序语义的问题。通常程序分析涉及的层面是：
    - 抽象语法树：表示程序的抽象语法结构
    - 三地址码：将复杂程序简化到每个语句只有一个运算，控制语句全部简化成 goto 的中间代码
    - 控制流图
    #pagebreak()

= 基于抽象解释的程序分析
  == 数据流分析
  == 过程间分析
  == 指针分析
    
  #pagebreak()
= 基于约束求解的程序分析
  == SAT
  == SMT
  == 符号执行
  #pagebreak()
= 软件分析应用
  == 程序合成
  == 缺陷分析
  == 缺陷修复