#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= #empty
  #let abs = "AbsPosition"
  #let gl = "global"
  #let lo = "local"
  #let loV = "localVar"
  #let glV = "globalVar"
  #let Var = "Var"
  #let st(s, a) = $#s space #a$
  假设程序中函数为 $f_1 (a_1^1, a_2^1, ..., a^1_m_1), f_2 (a^2_1, a^2_2, ..., a^2_m_2), ..., f_n (a^n_1, a^n_2, ..., a^n_m_n)$，其中 $m_i$ 代表参数个数。某个函数 $f_i$ 的第 $j$ 行记作 $f_i j$，并设函数 $f_i$ 有 $l_i$ 行。再设全局初始化语句共有 $i$ 句，记：
  $
    abs := P({f_i j | 1 <= i <= n, 1 <= j <= l_i} union {1, 2, ..., i})
  $
  表明所有语句位置的集合。

  再设全局变量为 $glV := {gl_i}$，函数 $f_i$ 的所有局部变量为 $loV_i := {lo_k}$，最终函数 $f_i$ 的抽象域为：
  $
    (loV_i -> abs) times (glV -> abs)
  $
  总体的抽象域为：
  $
   S := times.big_i (loV_i -> abs) times (glV -> abs)
  $
  无妨设所有变量名均不重复，则对于 $S$ 中的具体抽象状态 $s$，用 $st(s, a)$ 表示变量 $a$ 当前的抽象状态。\
  初始状态下，所有变量的抽象状态都是 $emptyset$，合并操作定义为逐个元素对应集合取并，容易验证这确实是有界半格。具体的变换函数定义如下：
  - 若赋值语句：
    ```c
    a = E;
    ```
    或者初始化语句：
    ```c
    T a = E;
    ```
    出现在函数 $f_i$ 的第 $k$ 行，则状态更新为：
    $
      st(s', a) &:= {f_j k}\
      st(s', x) &:= st(s, x)  
    $
    若出现在全局初始化语句中的第 $k$ 行，则状态更新为：
    $
      st(s', a) &:= {k}\
      st(s', x) &:= st(s, x)
    $
  - 若函数调用表达式：
    ```c
    f_j (b_1, ..., b_m_j)
    ```
    （可能作为语句中的表达式）出现在 $f_i$ 的第 $k$ 行，则创建调用节点连接到 $f_j$ 中，并将状态更新为：
      $
        st(s', a^j_i) &:= st(s, b_i)\
        st(s', g) &:= st(s, g), forall g in glV\
        st(s', l) &:= emptyset, forall l in loV_j
      $
      （此时 $s'$ 已经是关于 $f_j$ 函数的状态，记录 $f_j$ 中所有变量的可达定值）
  - 函数返回语句不需要特殊处理，保持原有状态即可。

  对于下面的例子，方便起见整理为：
  ```c
  int g;
  void main(){
    int a = 10;
    g = a + 1;
    h(a);
    h(a);
  }
  void h(int a){
    x(a);
    g++;
    x(a);
  }
  void x(int a){
    output(a);
  }
  ```
  其函数调用图为：
  #align(center)[#commutative-diagram(
  node((0, 0), [main], 1),
  node((1, -1), [h], 2),
  node((1, 1), [h], 3),
  node((2, -1), [x], 4),
  node((2, 0), [x], 5),
  node((2, -2), [x], 6),
  node((2, 1), [x], 7),
  arr(1, 2, [$a:$ main 1\ $g:$ main 2], label-pos: right),
  arr(1, 3, [$a:$ main 1\ $g:$ main 2]),
  arr(2, 4, [$a:$ main 1\ $g:$ main 2, h 2]),
  arr(3, 5, [$a:$ main 1\ $g:$ main 2], label-pos: right),
  arr(2, 6, [$a:$ main 1\ $g:$ main 2], label-pos: right),
  arr(3, 7, [$a:$ main 1\ $g:$ main 2, h 2]),

  )]
  （最后一层 output 的状态与 x 是相同的）

  不难发现，x 的调用位置即可决定其状态，但 output 在同一个位置有多种上下文，事实上恰有两种上下文，因此 $k$ 至少为 $2$ 才能分析出两种不同的上下文。
  