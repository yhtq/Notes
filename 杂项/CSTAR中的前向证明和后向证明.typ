#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "../template.typ": *
#show: note.with( 
  withOutlined: false,
  withChapterNewPage: false,
  withHeadingNumbering: false,
  withTitle: false
)
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(),  // freeze theorem counter for animation
  config-info(
    title: [CStar 中的前向证明和后向证明],
    author: [郭子荀 2100012990\@stu.pku.edu.cn],
    date: datetime.today(),
    institution: [],

  ),
)
#set text(size: 22pt)
// #set heading(numbering: "1.")
#show "CStar": "C*"
#title-slide()

= 理论基础

== 手动证明后端
  - CStar 的证明后端由 HOL-Light 提供，它是一个基于 HOL (Higher Order Logic，高阶逻辑) 的交互式定理证明器。
  
  - 这里我们将简单介绍使用高阶逻辑进行手动证明的基本概念和方式，详细的可以参照#link("https://hol-light.github.io/tutorial.pdf")[HOL-Light 官方教程] 
== 项（Term）
  项是高阶逻辑中的基本对象，它表示一个数学表达式，逻辑命题等等对象，下面是一些常见的 term 的例子：
  ```c
  // 在 CStar 中，我们用抽象 C 类型 `term` 来表示一个逻辑上的项
  term int_two = `2i:int`;  // i 后缀表示整数字面值
  term num_two = `2:num`;  // num 类型表示自然数
  term int_two2 = mk_int(2);
  term int_plus = `(+):int->int->int`;
  term bool_true = `T:bool`;
  term complex_proposition = `!(x:int) (y:int) (z:int) (n:num). n > 2 ==> (x EXP n + y EXP n != z EXP n)`;
  ```
  #pause
  得到一个项有两种标准的方法，一是通过反引号括起来的字符串，它将被交给后端按照一定的语法进行解析；二是通过一些构造、操作项的函数来生成。
== 类型（Type）
  每个项都有一个类型，类型描述了一个项大致是哪种类型的逻辑对象。下面是一些常用的类型：
  ```c
  // 在 CStar 中，我们用抽象 C 类型 `type` 来表示一个逻辑上的类型
  type int_type = type_of(`2i:int`); // int: 无界整数
  type num_type = type_of(`2:num`); // num: 自然数
  type bool_type = type_of(`T:bool`); // bool: 布尔类型
  type prop_type = type_of(complex_proposition); // prop: 命题类型
  ```
  #pause
  常见的运算（例如加减乘除）只能对相同类型的项进行，因此在进行一些需要同时利用自然数和整数的证明时，需要注意它们之间的类型转换。
  ```c
  term should_fail = `2i + 3`; // 类型错误，无法通过 HOL-Light 的类型检查
  ```
  默认的，CStar 程序层的整型 C 变量会被对应到逻辑层的整数类型 int
== 定理（Theorem）
  定理表示一个逻辑系统中可以被证明的命题。#footnote[考虑具体实现，更准确的说法是已经被证明的命题]。在标准的形式逻辑系统中，我们用：
  $
    A_1, A_2, ..., A_n tack B
  $
  表示在假设 $A_1, A_2, ..., A_n$ 下，可以证明命题 $B$。在 CStar 中，一个定理包括
  - 一个项构成的集合，表示它的所有假设
  - 一个项，表示它的结论
  ```c
  // 在 CStar 中，我们用抽象 C 类型 `thm` 来表示一个类型
  term simple_concl = `forall p. p <=> p`;
  thm simple_thm = taut_rule(simple_concl); // |- forall p. p <=> p
  ```
== 得到定理的方式
  原则上，得到一个定理的方式有且仅有以下两种：
  - 公理（Axiom）：逻辑系统中不需要证明的基本命题，可以直接作为定理使用
  - 导出规则（Derivation Rule）：通过一些逻辑规则，从已有的定理中导出新的定理
  #pause
  当然， HOL-Light 和 CStar 都提供了大量的内置定理和证明自动化，帮助我们更方便的进行证明。
  ```c
  // 通过名字，在全局定理库中查找一个定理
  thm imp_conj = get_theorem_by_name("IMP_CONJ"); // |- p /\ q ==> r <=> p ==> q ==> r;
  thm proved_by_tauto = tauto_rule(concl(imp_conj)); // 对于同样的结论，通过命题逻辑的可判定性得到定理
  thm proved_by_int_arith_rule = int_arith_rule(`a:int + 2i + 2i = a + 4i`); // 试图通过整数算术的证明器得到定理
  ```
== 分离逻辑命题（hprop）
  在 CStar 中，我们额外引入了分离逻辑来处理内存相关的逻辑推理。
  ```c
  term hemp = `emp : hprop`; 
  term pure_fact = `fact(0i <= n && n <= 100i) : hprop`; // 普通逻辑命题被称为 pure fact，通过 fact 函数提升为分离逻辑命题 
  term emp_entail = `emp |-- emp`; // 用 `|--` 表示分离逻辑中的蕴含关系，注意这不是一个定理
  thm hent_refl = get_theorem_by_name("hentail_refl"); // |- !hp. hp |-- hp
  thm emp_entail_thm = spec_rule(hemp, hent_refl); // |- emp |-- emp
  ```
  它并不是 HOL 中的基本对象，操作它们的方式也和一般的项和定理并无不同。

= 证明交互
  == 证明块
  在一个典型的 CStar 函数中：
  ```c
  int doubled(int n)
  [[cst::require(`fact(0i <= n && n <= 100i)`)]]
  [[cst::ensure(`fact(__return == mydouble(n))`)]]
  {
    int a = n + 1;
    int b = n - 1;
    int r = a + b;
    [[cst::proof]] {
      term st = cst_get_symbolic_state();
      thm st_entail = ...;
      cst_set_symbolic_state(st_entail);
    }
    return r;
  }
  ```
  == 证明块
  被交给手工证明层的部分包括：
  - `cst::require(...)` 函数前条件，括号中是一个 `term` 类型的 C 表达式
  - `cst::ensure(...)` 函数后条件，括号中是一个 `term` 类型的 C 表达式 #pause
  - `[[cst::proof]]` 证明层语句，括号中一般一个代码块，或者 `thm some_thm = ...;` 形式的语句
  #pause
  而这些部分中间的推理由符号执行器进行，不需要人工的参与。当符号执行器无法完成推理时，一个 VC 就会产生，需要人工介入为符号执行器提供更多的信息。

  #pause
  在证明块中，`cst_get_symbolic_state()` 函数会返回当前符号执行器的符号状态（作为一个分离逻辑命题），`cst_set_symbolic_state(some_thm)` 会将符号状态更新为 `some_thm` 的结果，前提是 `some_thm` 是一个分离逻辑定理，其前提与当且符号状态在允许相差交换结合性的意义下相等。

= 前向证明
  == 基本思想
    - 前向证明（forward proof）是最基本的证明方式，通过管理已知的定理和假设，应用已有的规则和定理，逐步推导出目标定理。
    - 前向证明基本上是由操作组成的，需要显式写出的项较少，但难度可能较大，适合思路非常清晰的简单证明。
  // == 常用操作和工具
  //   - `get_theorem_by_name(name)`: 通过名字从全局定理库中获取一个定理 #pause
  //   - `get_conversion_by_name(name)`, `apply_conversion`, `conv_rule`,...: 利用 Conversion （项到项的等价变形过程）进行证明 #pause
  //   - rewrite: 使用一个或者若干等式进行重写，包含大量的变体，可以参考函数的文档 #pause
  //   - `arith_rule` / `int_arith_rule`: 使用内置的算术证明器进行整数或者自然数算术证明一个 term #pause
  //   - `taut_rule`: 使用命题逻辑的可判定性证明一个 term #pause
  //   - `match_mp_rule`：逻辑系统中的肯定前件（modus ponens）规则，通过已经证明的定理 `A` 和 `A ==> B` 推导出 `B`。#pause 这里的 match 是说允许传入 `forall x. A ==> B` 形式的定理，将会试图匹配前件 `A` 中的变量。
  // == 常用操作和工具
  //     ```c
  //     thm th1 = taut_rule(`forall p q. p && q ==> p`); 
  //     thm th2 = arith_rule(`1 == 1 && 2 == 2`);
  //     thm th3 = match_mp_rule(th1, th2); // |- 1 == 1
  //     ```
  //     #pause
  //   - `disch/undisch_rule`：逻辑系统的分离规则，将 `p |- q` 和 `|- p ==> q` 互相转换 #pause
  //   - `spec_rule` / `gen_rule` 及变体：全称量词的标准规则，将 `Q |- forall x. P(x)` 和 `Q |- P(t)` 互相转换#footnote[对 `Q` 中存在的自由变量可能有一定要求，具体的可以考虑文档] #pause
  //   - `metis_solver`, `meson_solver`, ...： 基于不同算法的一阶逻辑证明搜索器，可以尝试用来自动证明一些定理 
  //   // #footnote[当自由变量存在于 `p` `q` 中时，将会出现一些细节问题，]
  == 示例：double
    #v(1pt)
  == 自定义逻辑函数
    尽管 C\* 提供了大量易于使用的证明工具，很多时候我们仍然希望构造自定义的逻辑函数，以便处理特定的任务。
    #pause
    ```c
    #define And(a, b) mk_binop(parse_term("&&"), a, b)
    ...
    // `size` is the length in bits 
    [[cst::gl]] term is_bounded_signed_integer(term t, int size) {
      term upper = mk_binop(parse_term("pow"), mk_int(2), mk_nat(size - 1));
      term lower_bound = TLE(TSub(mk_int(0), upper), t);
      term upper_bound = TLE(t, TSub(upper, mk_int(1)));
      return TAnd(lower_bound, upper_bound);
    }
    ```
  == 示例：safe add
    ```c
    #define INT_SIZE 4  // in bytes
    int safe_add(int a, int b)
    [[cst::require(Fact(
      is_bounded_signed_integer(`(a:int) + (b:int)`, INT_SIZE * 8)
      // i.e. -2^31 <= a + b <= 2^31 - 1
    ))]]
    ...
    ```

  == 符号执行器的自动证明能力
  在 CStar 中，并非所有事实都需要手动证明。符号执行器在执行程序时，也会试图利用 SMT 求解器和一些预先配置的 strategies 来自动证明一些事实。反过来，这些自动证明的事实也可以被手动证明利用。
  ```c
  void plus_minus(int a, int b)
  [[cst::require(`emp`)]]
  [[cst::ensure(`fact(a + b - b == a)`)]]
  {
    // 符号执行器可以自动证明这里的后条件
    return;
  }
  ```
= 后向证明
  == 基本思想
    - 后向证明（backward proof）是另一种常见的证明方式，通过将目标定理分解为更小的子目标，逐步简化问题，直到达到已知的定理或假设。
    - 后向证明通常需要显式写出更多的项，但思路相对清晰，适合复杂的证明任务。
  == Goal Node
    后向证明的基本对象是 goal node，大体上，它包括以下信息：
    - 已有的假设（assumptions）
    - 目标结论（goal conclusion）
    - 子目标节点，表示为了证明当前节点需要证明的子目标
    #pause
    ```c
    // GN 这个抽象类型表示一个 goal node
    // 使用目标 term 初始化一个 goal node，term 既可以是分离逻辑命题（hprop），也可以是普通逻辑命题（prop）
    GN root = GOAL_INIT(vc);
    // 通过定理重写来化简当前 goal node
    GN g = REWRITE_TAC(root, mydouble_def);
    // 使用整数算术证明器来化简当前 goal node
    ARITH_TAC(g);
    // 当某个 node 以及所有子节点都被证明时，可以调用 GOAL_SOLVE 来得到最终的定理
    thm solved_vc = GOAL_SOLVE(root);
    ```
  == Tactic
    将一个 goal node 转化为一个或者多个子节点的过程称为 tactic。所有可用的 tactic 都在头文件中给出了定义和详细说明，可以参考 CStar 的头文件。

    #pause
    作为 Bonus 内容，goal node 是纯粹的 C 语言对象，tactic 也都是由 C 程序实现的，用户可以通过编写 C 代码来实现自定义的 tactic，从而扩展 CStar 的证明能力。

    #pause 当然，许多时候组合一些 tactic 就可以实现十分实用的新 tactic 了：
    ```c
    GN UNDISCH_TAUT_TAC(GN g) {
        g = UNDISCH_ALL_TAC(g);
        g = RULE_TAC(g, taut_rule);
        return g;
    }

    ```
  == Tactic 的内部实现
    ```c
    GNS CONJ_TAC(GN gn) {
      ASSUME_OK();
      ENSURE_COND(!goal_node_is_solved(gn), "goal already solved");

      term_list asmps = goal_node_get_asmps(gn);
      term conclu = goal_node_get_concl(gn);
      dest_conj_results dcr = dest_conj(conclu);
      ENSURE_OK("the conclusion is not a conjunction");

      term conj1 = dcr.tm1;
      term conj2 = dcr.tm2;
      goal_node_set_subgoals(gn, 2, (goal[]){{asmps, conj1}, {asmps, conj2}});
      goal_node_set_validator(gn, CONJ_TAC_VALID, validator_env_new(0));

      return goal_node_get_subgoals(gn);

    err:
      err_puts("\nat: CONJ_TAC(\n");
      err_puts(goal_node_to_string(gn));
      err_puts(")");
    def:
      return NULL;
}
    ```