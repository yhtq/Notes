#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#show: note.with(
  title: "作业3_3",
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
      nums1.insert(0, 8)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  == #empty
    #deduction[
      + $A_1^1 (x_1) -> A_1^1 (x_1) := tauto$
      + $forall x_1 A_1^1 (x_1) -> A_1^1 (x_1) := GEN$
    ]
  == #empty
    先证明：
    $
      forall x_i calA tack exists x_i (calA -> calB) -> calB
    $
    #deduction[
      + $calA := K4 (fS)$
      + $calA -> not1 calB -> not1 (calA -> calB) := tauto$ 
      + $not1 calB -> not1 (calA -> calB) := MPb(3, 4)$
      + $forall x_i (not1 calB -> not1 (calA -> calB)) := GEN$
      + $not1 calB -> forall x_i not1 (calA -> calB) := K5$
      + $(not1 calB -> forall x_i not1 (calA -> calB)) -> (not1 (forall x_i not1 (calA -> calB)) -> calB) := tauto$
      + $not1 (forall x_i not1 (calA -> calB)) -> calB := MPb(5, 6)$
    ]
    由于 $forall x_i calA$ 中没有 $x_i$ 的自由出现，可以利用演绎定理得到原结论
  == #empty
    先证明：
    $
      exists x_i calA -> calB tack forall x_i (calA -> calB)
    $
    #deduction[
      + $not1 forall x_i (not1 calA) -> calB := fS$
      + $(not1 forall x_i (not1 calA) -> calB) -> (not1 calB -> forall x_i (not1 calA)) := tauto$
      + $not1 calB -> forall x_i (not1 calA)$
      + $forall x_i (not1 calA) -> not1 calA := K4$
      + $not1 calB -> not1 calA := transitivity(3, 4)$
      + $calA -> calB := tauto, (5)$
      + $forall x_i (calA -> calB) := GEN$
    ]
    而其中仅对 $x_i$ 用了 GEN, 并未在 $exists x_i calA -> calB$ 中自由出现，因此可以利用演绎定理证明原结论
= #empty
  == #empty 
    有误，证明过程使用了 GEN $x_2$，这在 $exists x_2 A_1^2 (x_1, x_2)$ 中有自由出现，不符合演绎定理的条件
  == #empty
    取论域为 $NN, A_1^2 (x_1, x_2) := x_1 < x_2$，取赋值 $v(x_1 = 0)$，则：
    $
      exists x_2 A_1^2(0, x_2)
    $
    为真，但：
    $
      exists x_2 A_1^2(x_2, x_2)
    $
    为假。
= #empty
    #let Ks = $K^\#$
    #let Ks1 = $K^(\#1)$
    #let Ks2 = $K^(\#2)$
    + 一方面，需要证明 $Ks$ 的公理模式是 $K$ 中的元定理。
      - $Ks1$ 由 GEN 显然
      - $Ks2$ 只需证明：
        $
          tack_K forall y_1 (calA -> calB) -> (forall y_1 calA -> forall y_1 calB)
        $
        #deduction[
          + $(calA -> calB) -> (calA -> calB) := tauto$
          + $forall y_1 (calA -> calB) -> (calA -> calB) := K4$
          + $forall y_1 calA -> calA := K4$
          + $(calA -> calB) -> calA -> calB := tauto$
          + $(forall y_1 (calA -> calB) -> (calA -> calB)) -> (forall y_1 calA -> calA) -> ((calA -> calB) -> calA -> calB) -> (forall y_1 (calA -> calB) -> forall y_1 calA -> calB) := tauto$
          + $forall y_1 (calA -> calB) -> forall y_1 calA -> calB := MPb(4, MPb(3, 5))$
          + $forall y_1 (forall y_1 (calA -> calB) -> forall y_1 calA -> calB) := GEN$
          + $forall y_1 (calA -> calB) -> forall y_1 (forall y_1 calA -> calB) := K5$
          + $forall y_1 (forall y_1 calA -> calB) -> forall y_1 calA -> forall y_1 calB := K5$
          + $forall y_1 (calA -> calB) -> (forall y_1 calA -> forall y_1 calB) := transitivity(8, 9)$
        ]
        足以表明 #Ks 的定理集含于 $K$ 的定理集
    + 另一方面，需要证明：
      $
        若 space tack_Ks calA, 则 space  tack_Ks forall x_i calA
      $
      对 $tack_Ks calA$ 的证明序列做归纳：
      - 假设 $calA := fA$，则由 $Ks1$ 显然得到 $forall x_i calA := fA$
      - 假设 $calA := MPb(calB, calB -> calA)$，这表明 $tack_Ks calB, calB -> calA$，归纳假设给出：
        $
          tack_Ks forall x_i calB, forall x_i (calB -> calA)
        $ 
        只需证明 $forall x_i calB, forall x_i (calB -> calA) tack_Ks forall x_i calA$
        #deduction[
          + $forall x_i (calB -> calA) := fS$
          + $forall x_i calB := fS$
          + $forall x_i calB -> forall x_i calA := MPb(1, Ks2)$
          + $forall x_i calA := MPb(2, 3)$
        ]
      足以表明 $K$ 的定理集含于 #Ks 的定理集
