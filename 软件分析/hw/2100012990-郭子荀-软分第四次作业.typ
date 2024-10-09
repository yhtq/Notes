#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let Node = $"NodeValue"$
= 分析方向
  反向，向控制流图的前驱进行
= 抽象域  
  - 抽象值集合为程序中表达式集合的全体
  - $gamma(S)$ 表示从当前位置开始，繁忙表达式恰为 $S$ 的所有实际（有限）执行序列
  - 初始值：表达式全集（exit 节点的初始值为空集）
= 转换函数
  $
  f_v (S) = (S - "exp_with_value_change"_v) union "exp_calculated"_v
  $
  其中：
  - $"exp_with_value_change"_v$ 指所有与该语句中值被改变的变量相关的表达式
  - $"exp_calculated"_v$ 指所有在该语句中被计算（读取）的表达式
= 合并操作
  所有后继节点的值取交，也即 $Node(v) := f_v (sect.big_(v' in "succ"(v)) Node(v'))$（方便起见，暂时认为零个集合的交是空集）
= 正确性
  #lemmaLinear[][给定从某个节点 $v$ 开始的终止执行，则算法稳定后 $Node(v)$ 中的所有表达式都是该执行的繁忙表达式，即该表达式在其中变量被赋值前一定在执行中被读取。]
  #proof[
    设 $e in Node(v)$，由于算法的稳定，将有：
    $
    Node(v) = (sect.big_(v' in "succ"(v)) Node(v') - "exp_with_value_change"_v) union "exp_calculated"_v
    $
    讨论：
    - 若 $e in "exp_calculated"_v$，则 $e$ 在节点 $v$ 被读取，当然是繁忙表达式。
    - 否则，若 $e in sect.big_(v' in "succ"(v)) Node(v') - "exp_with_value_change"_v$，此时 $v$ 一定不是 exit 节点，假设该具体执行中下一个节点为 $v'$，由前式显然有：
      $
      e in Node(v') - "exp_with_value_change"_v
      $
      递归证明 $e$ 是 $v'$ 节点开始的繁忙表达式，则上式同时表明 $e$ 的值没有在节点 $v$ 被修改，当然有 $e$ 是 $v$ 节点开始的繁忙表达式。
    由于该执行序列在有限步终止（执行到 exit 节点），上面的递归证明可以终止。
  ]