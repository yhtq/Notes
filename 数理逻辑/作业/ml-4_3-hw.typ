#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#show: note.with(
  title: "作业4_3",
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
      nums1.insert(0, 10)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  - 若 $language$ 中每个公式都是定理，当然任意取得一个公式 $calA$，有 $calA, not1 calA$ 都是定理，也即不一致
  - 假设不一致，不妨设 $calB, not1 calB$ 是定理,
    注意到有重言式：
    $
      calB -> not1 calB -> calA
    $
    简单利用 MP 可得任意公式 $calA$ 是定理
= #empty
  任取闭式 $calA$，假设 $calA$ 不是定理，则由条件将 $calA$ 作为补充公理的扩张不是一致的。由上一道习题，这意味着：
  $
    tack_(S union calA) not1 calA
  $
  也即：
  $
    calA tack_S not1 calA
  $
  利用演绎定理（注意到 $calA$ 是闭式），有：
  $
    tack_S calA -> not1 calA
  $
  而我们有重言式：
  $
    (calA -> not1 calA) -> not1 calA
  $
  利用 MP 立得：
  $
    tack_S not1 calA
  $
  表明 $not1 calA$ 是定理。另一方面的证明是类似的。
= #empty
  设 $c$ 是一个常元，$A_i$ 是谓词符，则：
  $
    calA_i := A_i (a, a, ..., a)
  $ 
  是一个公式（其中 $a$ 的数量根据 $A_i$ 的元数而定）。断言对于每个 $i$, $calA_i, not1 calA_i$ 都不是定理。事实上，总可以取得模型使得：
  $
    A_i (x_1, x_2, ..., x_n) = T, forall x_1, x_2, ..., x_n
  $
  以及：
  $
    A_i (x_1, x_2, ..., x_n) = F, forall x_1, x_2, ..., x_n
  $
  这就表明 $calA_i, not1 calA_i$ 都不是公式（否则与可靠性矛盾）。进而对于每个 $i$，选择 $calA_i$ 或者 $not1 calA_i$ 作为公理得到的扩充都是一致的，而不同的选择得到的扩充当然也是不同的。由于谓词符有无穷多个，这样的选择也有无穷多个，进而一致扩充也有无穷多个。
= #empty
  若 $Gamma tack calA$，则由可靠性有：
  $
    Gamma models calA
  $
  当然就意味着 $M models calA$。反之是不对的，例如就取 $Gamma$ 为空，任意模型 $M$ 都是 $Gamma$ 的模型，此时 $M models calA$ 显然不能保证 $tack calA$
= #empty
  假设扩充的公理集为 $Gamma$，且扩充之后的一阶系统不一致，也即存在 $calA$ 使得：
  $
    Gamma tack_S calA, Gamma tack_S not1 calA
  $
  此时 $Gamma$ 是不一致的公式集，显然它不应该有模型，但 $M$ 显然是它的模型，矛盾！

  $hat(S)$ 未必是完全的。例如取一个一阶语言的解释，其中没有常元只有变元，自然的其中没有闭原子。再取 $S$ 是一阶语言本身，则 $hat(S)$ 还是该一阶语言本身，然而公式：
  $
    forall x_1 A_1^1(x_1)
  $
  与它的反面显然都不是定理
= #empty
  == #empty
    // #lemmaLinear[][
    //   $Gamma tack_(K) calA$ 当且仅当 $Gamma tack_(K_2) calA$ 且 $Gamma tack_(K_1) calA$
    // ]
    // #proof[
    //   $
    //     Gamma tack_(K) calA &<=> "任意解释" M, M models Gamma => M models calA \
    //     &<=> "任意解释" M, M models Gamma => (M models K_1 => M models calA) and (not(M models K_1) => M models calA) \
    //     &<=> "任意解释" M, (M models Gamma => M models K_1 => M models calA) and (M models Gamma => M models K_2 => M models calA) \
    //     &<=>  ("任意解释" M, M models Gamma => M models K_1 => M models calA) and ("任意解释" M, M models Gamma => M models K_2 => M models calA) \
    //     &<=>  (Gamma tack_(K_1) calA) and (Gamma tack_(K_2) calA) \
    //   $
    //   （这里的 $<=>, and, =>, not$ 都是在元语言中推理使用的逻辑符号）
    // ]
    取 $Gamma_1$ 是 $K_1$ 的定理集，$Gamma_2$ 是 $K_2$ 的定理集，不难验证 $Gamma_1 union Gamma_2$ 没有模型，因此它们不一致。进而可设：
    $
      Gamma_1 union Gamma_2 tack_K calA\
      Gamma_1 union Gamma_2 tack_K not1 calA
    $
    由证明序列的有限性，可取 $Gamma_1, Gamma_2$ 的有限子集 $Gamma'_1, Gamma'_2$ 使得：
    $
      Gamma'_1 union Gamma'_2 tack_K calA\
      Gamma'_1 union Gamma'_2 tack_K not1 calA
    $
    任取 $Gamma'_1$ 的模型 $M$，由于：
    $
      Gamma'_1 tack_(K_2) calA\
      Gamma'_1 tack_(K_2) not1 calA\
    $
    因此 $M$ 不是 $K_2$ 的模型，由条件它是 $K_1$ 的模型。这就证明了 $Gamma'_1$ 的模型都是 $K_1$ 的模型，由完备性 $Gamma'_1$ 是 $K_1$ 的有限公理化

    类似的，$Gamma'_2$ 是 $K_2$ 的有限公理化。


