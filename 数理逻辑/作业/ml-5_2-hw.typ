#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#show: note.with(
  title: "作业5_1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#set heading(numbering: 
  (..nums) => 
    {
      let nums1 = nums.pos()
      nums1.insert(0, 12)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  首先证明：
  $
    forall y (forall z (z < y -> calA(z)) -> calA(y)) tack calA(0)
  $
  #deduction()[
    + $not1 (z < x) :=$ 基本结论
    + $not1 (z < x) -> (z < x -> calA(z)) := tauto$
    + $z < x -> calA(z) := $ MP
    + $forall z (z < x -> calA(z)) := GEN$
    + $calA(x) := $ MP
  ]
  再证明：
  $
    forall y (forall z (z < y -> calA(z)) -> calA(y)) tack calA(x)
  $
  #let basic = "基本结论"
  令 $calB(x') := forall z, z <= x' -> calA(z)$，有：
  #deduction[
    + $calB(0) -> (forall x_1 (calB(x_1) -> calB(s(x_1)))) -> calB(x) := $ N7
    + $calA(0) :=$ 前已证
    + $z <= 0 -> z = 0 := basic$
    + $z = 0 -> calA(0) := $ E8
    + $calB(0) := $ transitivity
    + $(forall z (z < s(x_1) -> calA(z))) -> calA(s(x_1)) := forall$ elim
    + $(forall z (z < s(x_1) -> calA(z))) <-> calB(x_1) := basic, $ 可证等价替换性
    + $calB(x_1) -> calA(s(x_1)) := $ 可证等价替换性
    + $calB(s(x_1)) <-> (forall z (z <= x_1 or z = s(x_1)) -> calA(z)) := $ 可证等价替换性
    + $forall z (z <= x_1 or z = s(x_1)) -> calA(z) <-> forall z (z <= x_1 -> calA(z)) and (z = s(x_1) -> calA(z)) := tauto, $替换
    + $forall z (z <= x_1 -> calA(z)) and (z = s(x_1) -> calA(z)) <-> forall z (z <= x_1 -> calA(z)) and forall z(z = s(x_1) -> calA(z)) := forall and$
    + $calB(s(x_1)) <-> calB(x_1) and forall z(z = s(x_1) -> calA(z)) := $ transitivity
    + $forall z(z = s(x_1) -> calA(z)) <-> forall z(z = s(x_1) -> calA(s(x_1))) := $ 可证等价替换性
    + $forall z(z = s(x_1) -> calA(s(x_1))) <-> (exists z (z = s(x_1))) -> calA(s(x_1))$
    + $(exists z (z = s(x_1))) := exists$ intro $s(x_1)$
    + $forall z(z = s(x_1) -> calA(s(x_1))) <-> calA(s(x_1)) := $ 可证等价替换性
    + $calB(s(x_1)) <-> calB(x_1) and calA(s(x_1))$
    + $(calB(x_1) -> calA(s(x_1))) -> (calB(x_1) -> (calB(x_1) and calA(s(x_1)))) := tauto$
    + $calB(x_1) -> (calB(x_1) and calA(s(x_1))) := MPb(8, 18)$
    + $calB(x_1) -> calB(s(x_1)) := $ 可证等价替换性
    + $forall x_1 (calB(x_1) -> calB(s(x_1))) := GEN$
    + $calB(x) := $ MP 5, 21, 1
    + $x <= x -> calA(x) := forall$ elim x
    + $x <= x :=  basic$
    + $calA(x) := $ MP
    // + $(forall x_1 (calB(x_1) -> calB(s(x_1)))) -> calB(x) := $ MP
    // + $(forall z' (z' < s(x_1) -> calA(s(x_1))) -> calA(s(x_1))) := forall$ elim
    // + $x_1 = x -> not1 s(x_1) < x := basic$ 
    // + $not1 s(x_1) < x -> calB(x_1) := fA$
    // + $s(x_1) = x -> calB(s(x_1)) := $ transitivity
    // + $s(x_1) > x -> not1 s(x_1) < x := basic$
    // + $s(x_1) > x -> calB(s(x_1)) := $ transitivity
    // + $s(x_1) < x -> x_1 < x := basic$
    // + $x_1 < x -> calB(x_1) -> calA(x_1) := tauto$
    // + $s(x_1) < x -> calB(x_1) -> calA(x_1) := $ transitivity
    // + $s(x_1) < x -> calB(x_1) -> (s(x_1) < x -> calA(s(x_1)))$
    // + $0 < y + 1 := $ 基本结论
    // + $0 < x := $ E8, MP
    // + $$
  ]
  由于左侧都是闭式，演绎定理立刻给出原结论
= #empty
  目前还没有发现 ZF 中存在矛盾，因此 ZF 中没有目前已知的矛盾。ZFC 公理系统提供了足够强的构造能力，绝大多数数学系统（例如算术系统）都可以构造于 ZFC 系统中。换言之，只要 ZFC 系统是一致的/有模型，则这些具体的数学系统也是一致的/有模型的，这就将不同数学分支所研究的数学系统的一致性问题全部转化到了 ZFC 系统的一致性问题上。
  
