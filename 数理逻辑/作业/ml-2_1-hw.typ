#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#show: note.with(
  title: "作业2_1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let empty = ""
#set heading(numbering: 
  (..nums) => 
    {
      let nums1 = nums.pos()
      nums1.insert(0, 3)
      numbering("1.1.(a)", ..nums1)
    }
)
#let p1 = $p_1$
#let p2 = $p_2$
#let p3 = $p_3$
= 
  == #empty

    #deduction[
      + $(not1 p1 -> not1 p2) -> (p2 -> p1) := L3$  
      + $(1) -> ((p1 -> p2) -> (1)) := L1$
      + $(p1 -> p2) -> ((not1 p1 -> not1 p2) -> (p2 -> p1)) := MPb(1, 2)$
    ]
  == #empty
    #let f1 = $p1 -> (p2 -> p3)$
    #let f2 = $p1 -> p2$
    #let f3 = $p1 -> p3$
    #deduction[
      + $(f1) -> ((f2) -> (f3)) := L2$
      + $((f1) -> ((f2) -> (f3))) -> (((f1) -> (f2)) -> ((f1) -> (f3))) := L2$
      + $((f1) -> (f2)) -> ((f1) -> (f3)) := MPb(1, 2)$
    ]
  == #empty
    #let f1 = $(p1 -> p2)$
    #let f2 = $(p1 -> p1)$
    #lemmaLinear[][
      ${calA} tack (calA -> calB) -> calB$
    ]<l1>
    #proof[
      #deduction[
        + $calA := fS$
        + $((calA -> calB) -> (calA -> calB)) -> (((calA -> calB) -> calA) -> ((calA -> calB) -> calB)) := L2$
        + $(calA -> calB) -> (calA -> calB) := idL$
        + $((calA -> calB) -> calA) -> ((calA -> calB) -> calB) := MPb(3, 2)$
        + $(calA -> calB) -> calA := MPb(1, L1)$
        + $(calA -> calB) -> calB := MPb(5, 4)$
      ]
    ]
    #lemmaLinear[][
      ${calA -> calB, calB -> calC} tack calA -> calC$
    ]<l2>
    #proof[
      #deduction[
        + $calA -> calB := fS$
        + $calB -> calC := fS$
        + $((calA -> calB) -> (calA -> calC)) -> (calA -> calC) := $ @l1
        + $(calA -> (calB -> calC)) -> ((calA -> calB) -> (calA -> calC)) := L2$
        + $calA -> (calB -> calC) := MPb(2, L1)$
        + $(calA -> calB) -> (calA -> calC) := MPb(5, 4)$
        + $calA -> calC := MPb(6, 3)$
      ]
    ]
    #deduction[
      + $(p1 -> f1) -> (f2 -> f1) := L2$
      + $p1 -> p1 := idL$
      + $(f2 -> f1) -> f1 :=$ @l1
      + $(p1 -> f1) -> f1 := $ @l2 $(1) (3)$
    ]
=
  == <p1>
    #deduction[
      + $not1 calA := fS$
      + $not1 calB -> not1 calA := MPb(1, L1)$
      + $calA -> calB := MPb(2, L3)$
    ]
  ==
    #lemmaLinear[][
      ${calB, calA -> (calB -> calC)} tack calA -> calC$
    ]<l11>
    #proof[
      #deduction[
        + $(calA -> calB) -> (calA -> calC) := MPb(fS, L2)$
        + $calA -> calB := MPb(fS, L1)$
        + $calA -> calC := MPb(2, 1)$
        
      ]
    ]
    #deduction[
      + $calA := fS$
      + $(not1 not1 not1 calA -> not1 calA) -> (calA -> not1 not1 calA) := L3$
      + $(not1  calA -> (calA -> calB)) := "课上引理" not1 calA -> (calA -> calB)$
      + $(not1  calA -> calA) -> (not1  calA ->  calB) := MPb(3, L2)$
      + $not1  calA ->  calB := MPb(MPb(1, L1), 4)$
      // + $not1 not1 not1 calA -> (not1 not1 calA -> calA) -> (calB -> not1 calA) $
      + $not1 not1 not1 calA -> (not1 not1 calA -> not1 calA) := "课上引理" not1 calB -> (calB -> calA)$
      + $(not1 not1 calA -> not1 calA) -> (calA -> not1 calA) := L2$
      + $not1 not1 not1 calA -> (calA -> not1 calA) := #transitivity-b(7, 6) "（前已证）"$
      + $not1 not1 not1 calA -> not1 calA := $ @l11
      + $not1 not1 A := MPb(1, MPb(9, 2))$
    ]
  == #empty
    #deduction[
      + $calA -> (calB -> calC) := MPb(fS, L3)$
      + $(calA -> calB) -> (calA -> calC) := MPb(1, L2)$
      + $calA -> calC := MPb(fS, 2)$
    ]
= 
  == #empty

    用演绎定理：
    $
    tack (calB -> calA) -> (not1 calA -> not1 calB) <=> calB -> calA tack not1 calA -> not1 calB
    $
    #deduction[
      + $calB -> calA := fS$
      + $not1 not1 calB -> not1 not1 calA := "课上习题" (calA -> calB) tack (not1 not1 calA -> not1 not1 calB) $
      + $not1 calA -> not1 calB := MPb(2, L3)$
    ]
  
  == #empty

    用演绎定理：
    $
    tack ((calA -> calB) -> calA) -> calA <=> (calA -> calB) -> calA tack calA
    $
    #deduction[
      + $(calA -> calB) -> calA := fS$
      + $not1 calA -> (calA -> calB) := "课上引理" not1 calB -> (calB -> calA)$
      + $not1 calA -> calA := #transitivity-b(1, 2)$
      + $calA := "课上引理" not1 calA -> calA tack calA$
    ]
=
  == #empty

    #lemmaLinear[][
      $not1 calA -> not1 calB tack not1 (calB -> calA)$
    ]
    定义：
    $
    calA and calB = not1 (calA -> not1 calB)
    $
    用演绎定理：
    $
    tack calA -> (calB ->  (calA and calB)) = tack calA -> (calB -> not1 (calA -> not1 calB))\
    <=> calA, calB tack not1 (calA -> not1 calB)
    $
    注意到（简单使用 MP 即可）：
    $
    calA, calB, (calA -> not1 calB) tack calB, not1 calB
    $
    因此有（利用引理 $calA, not1 calA tack calB$）：
    $
    calA, calB, (calA -> not1 calB) tack calB, not1 calB tack not1 (calA -> not1 calB)\
    <=> calA, calB tack (calA -> not1 calB) -> not1 (calA -> not1 calB)
    $
    再利用 $calA -> not1 calA tack not1 calA$ 立得结论
=
  == #empty
    #let tL = $tack_L$
    #let tL1 = $tack_L'$ 
    用演绎定理：
    $
    tL (not1 calA -> not1 calB) -> ((not1 calA -> calB) -> calA)\
    <=> not1 calA -> not1 calB tL (not1 calA -> calB) -> calA\
    <=> not1 calA -> not1 calB, not1 calA -> calB tL calA\
    $
    注意到 $not1 calB, calB tL calA => tL not1 calB -> calB -> calA$，有：
    #deduction[
      + $not1 calB -> calB -> calA$
      + $not1 calA -> not1 calB$
      + $not1 calA -> calB$
      + $not1 calA -> calB -> calA := #transitivity-b(1, 2)$
      + $(not1 calA -> calB) -> (not1 calA -> calA) := MPb(4, L2)$
      + $not1 calA -> calA := MPb(3, 5)$
      + $calA := "引理" not1 calA -> calA tL calA $
    ]
    证毕
  == #empty
    检查演绎定理的证明事实上并未用到 $L3$，因此在 $L'$ 中演绎定理同样成立。
    $
    tL1 ((not1 calA -> not1 calB) -> (calB -> calA)) <=> not1 calA -> not1 calB, calB tL1 calA \
    $
    有：
    #deduction[
      + $not1 calA -> not1 calB$
      + $calB$
      + $(not1 calA -> calB) -> calA := MPb(1, L3')$
      + $not1 calA -> calB := MPb(2, L1) $
      + $calA := MPb(4, 3)$
    ]
    证毕
  == #empty
    设 $calA$ 是 $L$ 中定理，也即存在演绎序列 $calA_1, calA_2, dots, calA_n$ 使得 $calA_n = calA$。由于 $L3$ 公理在 $L'$ 中是定理，因此该序列也是 $L'$ 中有效的演绎序列，即 $calA$ 也是 $L'$ 中的定理。因此 $L$ 中的定理在 $L'$ 中也是定理。反之类似。
  == #empty
    #definitionLinear[极大一致子集][
      设 $Gamma$ 是公式集，$Gamma'$ 是其子集。若 $Gamma'$ 是一致的（对于任何公式 $calA$ 不可能同时演绎得到 $calA, not1 calA$）且在 $Gamma$ 中是极大的（$Gamma$ 中不存在更大的一致集），则称之为极大一致子集。
    ]
    + 极大一致推理不是平凡的，对于某个定理 $calA$，设 $Gamma = {calA, not1 calA}$，不难发现它的极大一致子集是 ${calA}$。假设极大一致推理是平凡的，则 $Gamma$ 应当推出任意公式，意味着 $calA$ 可以推出任意公式。由 $calA$ 是 $L$ 中定理的假设，这将导致 $L$ 中所有公式都是定理，这与 $L$ 的一致性矛盾。
    + 极大一致推理不是单调的。假设 $calA, not1 calA$ 都不是定理，则 ${calA}, {not1 calA}$ 都是一致集（否则若 ${calA}$ 不一致，则由平凡性 $calA tack not1 calA$，由引理这将导致 $not1 calA$ 成为定理，另一面类似），考虑 $Gamma = {calA, not1 calA}$ ，若它的极大一致推理得到 $calB$ ，则将满足：
      $
      calA tack calB, not1 calA tack calB => tack {calA -> calB, not1 calA -> calB}
      $
      之前已经证明 $not1 calA -> calB tack not1 calB -> not1 not1 calA tack not1 calB -> calA $ 因此得到 $not1 calB -> calB$ 也即 $calB$ 将成为定理。

      然而，它的子集 ${calA}$ 的极大一致子集就是本身，因此极大一致推理得到的结果与一般推理相同，至少包括 $L$ 的所有定理以及 $calA$。

      因此，$Gamma$ 的子集 ${calA}$ 的极大一致推理结果比 $Gamma$ 严格更大，不满足单调性。
    #remarkLinear[][
      $L$ 中的原子命题 $p$ 一定满足 $p, not1 p$ 都不是定理，否则：
      - 若 $p$ 是定理，由于其原子性，相同的演绎过程应当应用于任何公式，这将导致所有公式都是定理，与 $L$ 的一致性矛盾。
      - 若 $not1 p$ 是定理，类似的所有公式的否定都是定理，然而 $not1 not1 calA -> calA$ 导致所有公式都是定理，同样与 $L$ 的一致性矛盾。
      因此上面说到的 $calA, not1 calA$ 都不是定理是可能取得的。
    ]