#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "数理逻辑",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let not1 = math.tilde
#let True = $T$
#let False = $F$
#let infer = $->$
#let equiv = $<->$
#let calA = $cal(A)$
#let calB = $cal(B)$
#let calC = $cal(C)$
#let calP = $cal(P)$
#let calL = $cal(L)$
#let Interpret = $cal(I)$
#let subst(AA, PP, pp) = $AA_( PP \/ pp )$
#let deduction(body) = {
  set enum(numbering: "(1)")
  set align(left)
  body
}
#let indent(num) = h((2em * num))
#let pattern-match(body) = {
  set list(marker: ([|]))
  align(center, body)
}
#let align_left(body) = {
  set align(left)
  body
}
#let fA = $ "fromAxiom"$
#let fS = $"fromFormulaSet"$
#let deduction-theorem(a, b) = $ "deduction theorem" #a space #b$
#let transitivity(a, b) = $ "transitivity" #a space #b$
#let MP(a, b) = $ "MP" #a space #b$
#let MPb(a, b) = $ "MP" (#a) (#b)$
#let GEN = $ "GEN"$
#let deduction-theorem-b(a, b) = $ "deduction theorem" (#a) (#b)$
#let transitivity-b(a, b) = $ "transitivity" (#a) (#b)$
#let L1 = $"L1"$
#let L2 = $"L2"$
#let L3 = $"L3"$
#let K1 = $"K1"$
#let K2 = $"K2"$
#let K3 = $"K3"$
#let K4 = $"K4"$
#let K5 = $"K5"$
#let R1 = $"R1"$
#let R2 = $"R2"$
#let R3 = $"R3"$
#let R4 = $"R4"$
#let tauto = $"重言式"$
#let idL = $"引理" calA -> calA$
#let language = $cal(L)$
= 前言
  - 主要参考书：Introduction to Mathematical Logic
  - 成绩：平时 30%，期末 70%
  - 作业每周周一前交到教学网，不能迟交
  - Office Time: 周一中午后上课前，智华楼 311
  == 主要内容
    命题逻辑 $->$ 一阶逻辑（模型论，证明论） $->$ 数学基础（元数学），不完全性定理，计算机科学基础（选讲，不讲证明，不考察）
= 命题逻辑
  == 语法与语义
    命题逻辑是一种符号语言（或称形式语言），以此作为基本的推理形式。
    #definition[][
      称 $p$ 为命题，若 $p$ 有明确的真假值。命题逻辑是二值逻辑，即命题只有真和假两种取值，分别记为 #True, #False
    ]
    #definition[连接符][
      命题逻辑采用以下几种符号：
      - 非：$not1 p$
      - 与：$p and q$
      - 或：$p or q$
      - 蕴含：$p infer q$
      - 等价：$p equiv q$


    ]
    #example[说谎者悖论][
      "这个句子是假的"不是命题，称之为悖论（paradox），它是一种导致自相矛盾的陈述。这个悖论运用了“自指”，也即在命题中谈论自身。但并非所有悖论都运用自指。

      说谎者悖论即使在三值逻辑（真，假，不真不假）中也是悖论
    ]
    #definition[命题形式][
      给定一系列变元，称：
      - 一个变元为命题形式
      - 若 $calA, calB$ 是命题形式，则 $not1 calA, calA and calB, calA or calB, calA infer calB, calA equiv calB$ 也是命题形式
    ]<proposition-form>
    #remark[][
      注意括号并非命题逻辑中的必需元素，它只是为了将一个命题形式用字母和符号表达时，避免歧义引进的
    ]
    #definition[][
      对一个命题形式：
      - 如果任取变元的所有赋值，该命题形式均为真，则称该命题形式为重言式/永真式
      - 如果任取变元的所有赋值，该命题形式均为假，则称该命题形式为矛盾式
      - 否则称该命题形式为可满足式
      判断一个命题形式是否可可满足式是一个 NP 问题，该问题称为 SAT 问题
    ]
    #definition[][
      - 若 $calA -> calB$ 是重言式，则称 $calA$ 蕴含 $calB$，记作 $calA => calB$
      - 若 $calA <-> calB$ 是重言式，则称 $calA$ 重言等价于 $calB$，记作 $calA <=> calB$ 。显然重言等价当且仅当 $calA, calB$ 有相同的真值表
    ]
  == 操作与替换
    #proposition[][
      设 $calA, calB$ 都是命题形式，若 $calA$ 是重言式且 $calA => calB$，则 $calB$ 是重言式
    ]
    #proof[
      用反证法，如若不然，则将存在一个赋值使得 $calB$ 为假，而 $calA$ 为真，这与 $calA -> calB$ 是重言式矛盾
    ]
    #remark[][
      这里的“反证法”是一种逻辑演算之外的证明方法。因为之前定义的赋值存在于元语言中，因此反证法也是在元语言中反证。
    ]
    #definition[][
      设 $calA$ 是包含变元 $p_1, p_2, ..., p_n$ 的命题形式，$calP_i, 1<=i<=n$ 是任意的命题形式，则称将 $p_i$ 替换为 $calP_i$ 的操作称为替换，记作 $subst(calA, p_i, calP_i)$
    ]
    #definition[受限命题形式][
      在 @proposition-form 中，若只用 $not1, and, or$ 作为连接符，则称其为受限命题形式
    ]
    #theorem[][
      设 $calA$ 是受限命题形式，定义 $A^*$ 如下：
      - $A^* (p) = not1 p$
      - $A^* (calA and calB) = A^*(calA) or A^*(calB)$
      - $A^* (calA or calB) = A^*(calA) and A^*(calB)$
      - $A^* (not1 calA) = not1 A^*(calA)$
      则 $A^*(calA) <=> not1 calA$
    ]
    #proof[
      使用结构归纳法，逐个验证即可
    ]
    #theorem[常用命题逻辑定理][
      以下都是重言式：
      - $not1 (A and not1 A)$
      - $A or not1 A$
      - $A <-> not1 not1 A$
      - $A <-> A or A <-> A and A$
      - $(A and B) -> C <-> A -> (B -> C)$
      - $A -> B <-> not1 B -> A$
      - $and_(i=1)^n (not1 A_i) <-> not1 or_(i=1)^n A_i$
      - $or_(i=1)^n (not1 A_i) <-> not1 and_(i=1)^n A_i$
      - $A and B and C <-> A and (B and C)$
      - $A or B or C <-> A or (B or C)$
      - $A and (B or C) <-> (A and B) or (A and C)$
      - $A or (B and C) <-> (A or B) and (A or C)$
    ]
  == 范式
    问题：给定真值表，可否构造一个命题形式满足此真值表？本节内容假设研究一个包含变元 $p_1, p_2, ..., p_n$ 的命题形式 $calA$，并且已知 $calA$ 的真值表，$v_(p_i)$ 是其真值
    #definition[基本合取式/短语/子句][
      设 ${(q, v)} subset {p_i}$ 是一些变元及其真值取值，则定义
      $c((q, v) union Q) = $
      - $q and c(Q)$ 若 $v = T$
      - $not1 q and c(Q)$ 若 $v = F$
    ]
    #definition[文字][
      一个变元或其否定称为一个文字
    ]
    #definition[][
      称：
      - $and or Q$ 为合取范式
      - $or and Q$ 为析取范式
      其中 $Q$ 是文字
    ]
    #theorem[][
      对于任意的真值表，都存在受限命题形式 $calA$ 使得其真值表与给定真值表相同
    ]
    #proof[
      #let value = "value"
      设真值函数 $v: {T, F}^n -> {T, F}$，定义：
      $
      c_value := (not1 v(value)) "xor" c({(p_i, value[i]) | i <= n}) "for value in" {T, F}^n
      $
      则 $or_value c_value$ 就是我们要找的受限命题形式
    ]
    #remark[][
      上面找到的受限命题形式称为真值函数的范式
    ]
    #definition[][
      设 $S$ 是连接符（原则上，每个真值函数都可定义连接符）的集合，且对于任何真值函数 $v$，都存在受限命题形式 $calA$ 使得其真值表与给定真值表相同，则称 $S$ 是完备的
    ]
    #corollary[][
      ${not1, and}, {not1, or}, {not1, ->}$ 都是完备的。在基本的连接符之中，除这三对之外，其他任何一对连接符均不完备。
    ]
    #proof[
      上面的范式给出了只含 $not1, and, or$ 的命题形式，采用如下翻译方法：
      - $t(p) = p$
      - $t(not1 calA) = not1 t(calA)$
      - $t(calA and calB) = not1 (not1 t(calA) or not1 t(calB))$
      - $t(calA or calB) = t(calA) or t(calB)$
      不难验证 $t$ 将任意命题形式变为只含 $not1, or$ 的命题形式，且不改变真值函数。其他的是类似的。
    ]
    #theorem[][
      定义：
      $
      calA | calB := not1 (calA and calB)\
      calA arrow.b calB := not1 (calA or calB)
      $
      则可以验证 ${|}, {arrow.b}$ 都是完备集
    ]
  == 推理形式
    #definition[推理形式][
      推理形式是指命题形式的有限序列，其中最后一个命题为结论，其他命题为前提。
      - 称一个推理形式为有效的，若当前提真值均为真时，结论也一定为真
      - 反之，称之为无效的
    ]
    #example[典型的有效推理形式][
      - $calA, (calA -> calB); calB$
      - $not1 calB, (calA -> calB); not1 calA$
      - $calA -> calB, calB -> calC; calA -> calC$
      - $not1 A, A or B; B$
      - $A -> not1 A; not1 A$
      - $A -> (B and not1 B); not1 A$
      - $A, B; A and B$
      - $A, B; A or B$
      - $A and B; A$
      - $A and B; B$
    ]
    #definition[模型][
      对于任何命题形式 $calA$，若 $calA$ 的真值表中 $v(calA) = T$，则称 $v$ 是 $calA$ 的一个模型，记作 $v models calA$

      若任意真值指派都是 $calA$ 的模型，则称 $calA$ 是有效的，记作 $models calA$
    ]
    #definition[蕴含][
      称 $calA$ 蕴含 $calB$，记作 $calA models calB$，若任何 $calA$ 的模型都是 $calB$ 的模型
    ]
  == 形式系统
    === 语法
      #definition[形式（演绎）系统][
        形式系统指使用符号和规则来推导命题的系统，其中包含以下几个要素：
        - 形式语言：用来表达命题的符号
          + 一个字符表
          + 由字符表中的字符组成的有限字符串的一个子集，其中的字符串称为 well-formed formula
        - 公理：一组 well-formed formula
        - 有限个推理规则集
      ]
      #example[][
        命题逻辑是形式系统，其中：
        - 字符集是原子公式集（至多可数）以及 $~, ->, (, )$（括号作为技术性符号，未必需要）
        - 公式集是所有的命题形式
        - 公理由一组公理模式（schema）来刻画，对于任何公式 $calA_1, calA_2, calA_3$ 都有：
          + $calA_1 -> (calA_2 -> calA_1)$
          + $(calA_1 -> (calA_2 -> calA_3)) -> ((calA_1 -> calA_2) -> (calA_1 -> calA_3))$
          + $(not1 calA_1 -> not1 calA_2) -> (calA_2 -> calA_1)$
        - 推理规则包括：
          + $calA, (calA -> calB) => calA$ #align(end, [分离规则（MP）])
        当然命题逻辑定义为形式系统的方式并不唯一
      ]
      #remark[][
        $calA$ 等并非 $calL_0$ 中语言，而是元语言中符号。在计算机系统中，会使用 quasi-quote 来将元语言中的符号转化为 $calL_0$ 中的符号，例如 $`calA`$ ，该课程中省略该过程。
      ]
      公理系统是一种证明论（proof theory），证明论中当然还有其他与公理系统等价的系统。Euclid 的几何学是一个公理系统，但是在 19 世纪被发现是不完备的。
      #definition[证明][
        #calL 中的一个证明是指一个公式序列 $calA_i, i = 1, 2, ..., n$，其中要么 $calA_i$ 是公理，要么可以从之前的公式通过推理规则推导出来。$calA_n$ 称为一个定理，亦称 $calA_n$ 可证。
      ]
      #definition[演绎][
        令 $Gamma$ 是 $L$ 中的公式集，若有一个公式序列 $calA_i, i = 1, 2, ..., n$，其中要么 $calA_i in L$，要么 $calA_i$ 是公理，要么可以从之前的公式通过推理规则推导出来。$calA_n$ 称为从 $Gamma$ 可演绎的，记作 $Gamma tack calA_n$。特别的，若 $calA$ 是定理，则有 $emptyset tack calA$ 也记作 $tack calA$
      ]
      #theorem[演绎定理][
        若 $Gamma union {calA} tack calB$，则 $Gamma tack calA -> calB$
      ]
      #proof[
        使用结构归纳法，对 $Gamma union {calA} tack calB$ 的一个演绎 $L$ 做归纳：\
        #pattern-match[
          match L with
          - #align_left[#fA =>（此时 $calB$ 是公理），考虑：]
            #deduction[
              + $calB := fA$
              + $calB -> (calA -> calB) := fA$
              + $calA -> calB := #MPb(1, 2)$
            ]
          - #align_left[#fS => ]
            + #align_left[若 $B in Gamma$，则 $Gamma tack calA -> calB$ 显然]
            + #align_left[若 $B = A$，只需使用 $tack calA -> calA$ 即可]
          - #align_left[#MP("a", "b") => （此时 $b = a -> calB$）]
            由归纳法，有 $Gamma tack calA -> a, Gamma tack calA -> (a -> calB)$，只需证明：
            $
            {calA -> a, calA -> (a -> calB)} tack calA -> calB
            $
            来自于：
            #deduction[
              + $calA -> a := fS$
              + $calA -> (a -> calB) := fS$
              + $(calA -> (a -> calB)) -> ((calA -> a) -> (calA -> calB)) := fA$
              + #indent(1) $(calA -> a) -> (calA -> calB) := #MPb(3, 2)$
              + #indent(2) $calA -> calB := #MPb(4, 1)$
            ]
        ]

      ]
      #theorem[演绎定理2][
        若 $Gamma tack calA -> calB$，则 $Gamma union {calA} tack calB$
      ]
      #example[假言三段论 HS/传递性][
        证明：
        $
        calA -> calB, calB -> calC tack calA -> calC
        $
      ]
      #proof[
        容易证明 $calA, calA -> calB, calB -> calC tack calC$，应用演绎定理即可
      ]
      #definition[][
        设 $Gamma$ 是公式集：
        - 若存在 $calA$ 使得 $Gamma tack calA, Gamma tack not1 calA$，则称 $Gamma$ 是不一致的，否则是一致的
        - 若公式 $calA$ 满足 $Gamma tack.not calA, Gamma tack.not not1 calA$，则称 $calA$ 与 $Gamma$ 独立
        - 若 $calA, not1 calA in Gamma$ 则 $Gamma tack$ 任何公式，则称形式系统平凡
        - 若 $Gamma' subset Gamma, Gamma' tack calA$，则 $Gamma tack calA$ ，则称形式系统单调
      ]
      #proposition[][
        公式集不一致当且仅当对于任意公式 $calA$，都有 $Gamma tack calA$
      ]
      #definition[极大一致][
        - 称公式集 $Gamma$ 是极大一致（MC）的，如果它是极大的一致集。
        - 称 $Gamma' subset Gamma$ 是极大一致子集，如果 $Gamma'$ 是 $Gamma$ 中极大的一致子集
      ]
      #theorem[][
        若 $Gamma$ 是极大一致的，则对于任意 $calA$ 均有 $Gamma tack calA$ 或 $Gamma tack not1 calA$
      ]
      #example[极大一致推理][
        记 $Gamma tack_"MCS" calA$ ，如果对于任何极大一致子集 $Gamma'$，都有 $Gamma' tack calA$，该推理既不平凡也不单调
      ]
    === 语义
      这里，我们重新形式地引入之前的真值指派思想。它描述了命题逻辑的语义。
      #definition[赋值][
        称一个从 $L$ 的公式到 ${T, F}$ 的函数 $v$ 为一个赋值，如果：
        $
        v(not1 calA) = not1 v(calA)\
        v(calA -> calB) = T "if and only if" v(calA) = F "or" v(calB) = T
        $
      ]
      #definition[模型][
        令 $v$ 是 $L$ 的一个赋值，若 $v(calA) = T$，则称 $v$ 是 $calA$ 的一个模型，或 $v$ 使 $calA$ 成真，亦称 $v$ 满足 $calA$，记作 $v models calA$
      ]
      #definition[重言式][
        若 $v models calA$ 对任意赋值 $v$ 都成立，则称 $calA$ 是重言式，记作 $models calA$
      ]

  == 完全性定理
    前面的形式系统使用的是证明论的思想，使用 $tack$，是指纯粹语法的推断。而之前的章节从真值指派看待命题逻辑，使用的是模型论的思想，使用 $models$，指通过语义进行的分析。完全性定理即是说，这两种思想是等价的。
    #theorem[命题逻辑的可靠性（soundness）][
      若 $ tack calA$，则 $ models calA$
    ]<proposition-soundness>
    #proof[
      设 $ tack calA$ 的推理序列为 $L$
      #pattern-match[
          match L with
          - #align_left[#fA => 逐一验证公理都是重言式即可]
          - #align_left[#MP("a", "b") => 此时 $b = a -> calB$]
            由归纳法，$a, b$ 都是重言式，不难验证 $b space a : calB$ 当然也是重言式
        ]
    ]
    #theorem[命题逻辑的一致性][
      $L$ 是一致的
    ]
    #proof[
      假设 $L$ 不一致，则存在 $L$ 的公式 $calA$ 使得 $calA, not1 calA$ 都是定理，由 @proposition-soundness 可知 $models calA, models not1 calA$，这与赋值的定义矛盾。
    ]
    #definition[扩充][
      - $L$ 的一个扩充是指修改或扩大 $L$ 的公理组，使得 $L$ 中的每一个公理仍然是公式得到的形式系统。
      - 称 $L$ 的一个扩充是一致的，若不存在 $L$ 的公式 $calA$ 使得 $calA, not1 calA$ 都是这个扩充的定理。显然扩充是一致的当且仅当不是所有的公式都是定理。
    ]
    #proposition[][
      设 $L^*$ 是一个扩充，$calA$ 不是 $L^*$ 中定理，则 $L^*$ 中增加 $not1 calA$ 得到的形式系统 $L^(**)$ 也是一致的。
    ]<consistency-extension>
    #definition[][
      称 $L$ 的一个扩充是完全的，如果每个公式 $calA$ ，都满足 $calA, not1 calA$ 其中至少有一个是定理。显然一致的完全扩充是一个极大的一致扩充。
    ]
    #theorem[][
      令 $L^*$ 是一致扩充，则存在 $L^*$ 的一致完全扩充。
    ]
    #proof[
      枚举所有公式 $calA_1, ..., calA_n, ...$，记：
      - $A_0$  是 $L^*$ 的公理
      - 将 $L^*$ 的公理扩充至 $A_i$ 后：
        - 若 $calA_i$ 或 $not1 calA_i$ 是定理，则 $A_(i + 1) = A_i$
        - 否则，$A_(i + 1) = A_i union {not1 calA_i}$
      由 @consistency-extension，每个 $A_i$ 产生的扩充都是一致的。取 $union.big A_i$ 作为新的公理集，则这个扩充是：
      - 一致的，既然每个定理都只能用到有限个公理，因此若 $calA, not1 calA$ 都是定理，它们只能用到有限个公理，因此存在某个 $A_i$ 使得 $A_i tack calA, not1 calA$，矛盾
      - 完全的，显然每个公式都满足 $calA, not1 calA$ 其中至少有一个是定理
    ]
    #proposition[][
      若 $L^*$ 是 $L$ 的一个一致扩充，则存在一个赋值使得 $L^*$ 的每个定理取值均为 $T$
    ]<consistency-extension-value>
    #proof[
      设 $L'$ 是 $L^*$ 的一致完全扩充，定义赋值如下：
      $
      v(calA) = T "if and only if" tack_(L^') calA
      $
      $L'$ 的一致完全性保证了定义是合理的。

      为了证明它是赋值，只需证明：
      $
      v(calA -> calB) = T "if and only if" v(calA) = F "or" v(calB) = T
      $
      简单按定义验证即可。这个赋值就满足题目要求。
    ]
    #theorem[命题逻辑的完全性（completeness）][
      若 $Gamma models calA$，则 $Gamma tack calA$
    ]
    #proof[
      设 $calA$ 是重言式，若其不是定理，则由 @consistency-extension 将 $not1 calA$ 作为公理进行扩充得到一致系统，由 @consistency-extension-value 存在赋值 $v$ 使得 $L^*$ 中每个定理取值均为 $T$，特别的 $v(not1 calA) = T$，然而由重言式定义 $v(calA) = T$，矛盾。
    ]
    #theorem[可判定性定理][
      $L$ 中的公式是否是定理是可判定的
    ]
    #proof[
      由完备性定理，只需枚举所有赋值即可。
    ]
  == 直觉主义逻辑
    #definition[直觉主义逻辑][
      直觉主义逻辑由如下资料定义：
      - 字符集：公式集及 ${top(真), bot(假), and, or, ->}$
      - 公理模式：
        #enum(numbering:
          (nums => "(I" + str(nums) + ")")

        )[$calA -> (calB -> calA)$][
          $(calA -> (calB -> calC)) -> ((calA -> calB) -> (calA -> calC))$
        ][
          $(calA and calB) -> calA$
        ][
          $(calA and calB) -> calB$
        ][
          $calA -> (calB -> (calA and calB))$
        ][
          $calA -> (calA or calB)$
        ][
          $calB -> (calA or calB)$
        ][
          $(calA -> calC) -> ((calB -> calC) -> ((calA or calB) -> calC))$
        ][
          $(calA -> calC) -> ((calB -> calC) -> ((calB or calA) -> calC))$
        ][
          $bot -> calA$
        ]
      - 推理规则：MP
    ]
    主流数学仍是基于经典逻辑的，但是其中有些分支也应用了直觉主义逻辑。
= 一阶逻辑：模型论
  == 谓词和量词
    一阶逻辑就是在命题逻辑中将基本命题细分为：
    - 谓词结构，形如 $A(x)$，表示对于任何变元（主词），谓词 $A$，产生基本命题 $A(x)$
    - 任意结构，形如 $forall x, A(x)$，表示对于任何 $x$，$A(x)$ 都成立
    - 存在结构，形如 $exists x, A(x)$，表示存在一个 $x$ 使得 $A(x)$ 成立
    #definition[][
      被量词限定的变元称为自由变元，否则称为约束变元。含有自由变元的项往往无法确定真值。
    ]
  == 一阶语言
    本节给出一阶语言（记为 #language）的形式定义
    #definition[一阶语言的字符表][
      一阶语言的字符表包括：
      - 至多可数的变元集合 $x_1, x_2, ...$
      - 至多可数的常元集合 $a_1, a_2, ...$
      - 逻辑符号 $not1, infer$
      - 量词 $forall$
      - 谓词符 $A_m^n$，表示第 $m$ 个谓词符，有 $n$ 个参数
      - 函项符号 $f_m^n$，表示第 $m$ 个函项符号，有 $n$ 个参数
    ]
    #remark[][
      零元的谓词符/函项符事实上是常元/常命题，方便期间我们仍然保留额外定义的常元，但不额外定义常命题。
    ]
    #definition[][
      称 $language^+$ 为 $language$ 的一个扩展，如果它拓展了 $language$ 的变元集合/常元集合/谓词符/函项符
    ]
    #definition[公式与项][
      一阶语言中良好的表达式分为公式与项，满足文法规则：
      ```
      term ::= x_i
              | a_i
              | f_m^n (term_1, ..., term_n)
      formula ::= A_m^n (term_1, ..., term_n)
                 | not formula
                 | formula -> formula
                 | forall x_i, formula
      ```
      特别的：
      - 只由常元和函项符构成的项称为闭项，否则称为开项。显然将一些闭项加入常元集可以得到拓展，称为闭项拓展。只用常元的拓展称为常元拓展。
      - 不含量词，变元的公式称为命题公式，也就是命题逻辑语言 $language_0$ 中的公式
    ]
    #lemma[][
      #language 中的公式集和项集都是至多可数的
    ]
    #definition[][
      在公式 $forall x (calA)$ 中，称 $calA$ 是 $x$ 的辖域。$calA$ 中所有 $x$ 的出现以及 $forall x$ 中 $x$ 的出现称为约束的出现；变元在辖域之外的出现称为自由出现。
    ]
    #example[][
      $forall x_1(A(x_1, x_2) -> forall x_2 (B(x_2)))$ 中，$x_1$ 约束出现两次，$x_2$ 约束出现一次，自由出现一次
    ]
    #definition[替换][
      设 $s, t$ 是项，将 $s$ 中所有（自由出现的） $x_i$ 替换为 $t$ 的操作记作 $s(x_i \/ t)$
    ]
    #remark[][
      我们不对约束变元进行替换。尽管如此，替换仍是可能产生歧义的，例如：
      $
      forall x_1 (x_2)
      $
      用 $x_1$ 替换 $x_2$ 会导致自由变元 $x_1$ 和约束变元 $x_1$ 产生混淆，这是非法的。
    ]
    #definition[][
      称 $t$ 在 $calA$ 中对 $x_i$ 是自由的，如果对于任意在 $t$ 中出现的变元 $x$， $calA$ 中所有形如 $forall x(calB)$ 的子公式均满足 $x_i$ 不在 $calB$ 中自由出现。若 $x_i$ 不在 $calA$ 中自由出现，则 $t$ 总对 $x_i$ 自由。

      如此，我们使用 $t$ 替换 $x_i$ 的所有自由出现便不会产生歧义。
    ]
    直觉上来说，约束变元的“名字”应当不影响公式的结构。具体来说，我们定义：
    #definition[换名替换][
      若 $x_j$ 是不在 $calA$ 中自由出现的，对 $x_i$ 自由的变元，则 $forall x_j calA(x_i \/ x_j)$ 只是在 $forall x_i calA$ 中将所有 $x_i$ 换为 $x_j$ 的结果。
    ]
    #definition[相似公式][
      设 $x_i, x_j$ 是不同变元，称 $calA(x_i)$ 和 $calA(x_j)$ 是相似的，如果 $x_j$ 在 $calA(x_i)$ 中对 $x_i$ 自由且 $calA(x_i)$ 中没有 $x_j$ 的自由出现。
    ]
    #proposition[][
      相似是对称的，也即若 $calA(x_i)$ 和 $calA(x_j)$ 相似，则 $calA(x_j)$ 和 $calA(x_i)$ 相似
    ]
    #definition[二阶语言/高阶语言][
      一阶逻辑中的一阶是指量词只能作用于变元，若量词可以作用于项/谓词，则称为二阶逻辑。二阶逻辑与一阶逻辑有根本区别，例如数学归纳法：
      $
        forall P((P(0) and forall n("is_N"(n) -> P(n) -> P(n + 1))) -> forall n("is_N"(n) -> P(n)))
      $
      就是二阶公式
    ]
  == 解释：一阶语言的语义
    在一阶逻辑中，由于变元/函项的存在，我们不可能一次性规定所有情况下的准确语义。抽象而言：
    - 世界中应当有一些对象
    - 对于谓词符，存在一些对象满足这个谓词，而另一些不满足
    - 对于函项符，它将一些对象映射为另一个对象
    这应该能准确的描述一阶逻辑中的非逻辑符号的解释。这被称为 FOL 假设。

      具体而言，我们可以依赖于集合论建立一阶语言的模型：
    #definition[Tarski][
      一个一阶语言 $language$ 的解释 $Interpret$ 包括：
      - 一个非空论域 $D_I$，它是一个非空集合（通常不考虑空论域的问题）
      - 一个个体集 ${overline(a_i)}$，它是可数的，构成对常元的解释
      - 一个函项符集 ${overline(f)_i^n}$，其中：
        $
        overline(f)_i^n: D_I^n -> D_I
        $
        构成对函项符的解释
      - 一个关系集 $overline(A_i)$，其中：
        $
        A_i^n subset D_I^n
        $
        构成对谓词符的解释
      - 对于量词 $forall x(P(x))$，解释为对于所有 $d in D_I$，$P(d)$ 都成立。（更进一步，对于二阶语言的量词，可以解释为论域中子集构成的集合）
    ]
    #remark[][
      Tarski 解释必须基于集合论，因此从根本上无法解决集合论的问题（例如罗素悖论）。只有给定一个解释 $I$，才能对一阶逻辑中的公式讨论真假值，否则是无意义的。

      为了方便，假设 $language$ 中的常元为 $a_1, ..., a_i, ...$，我们就可以记：
      $
        D_I = {a_i}
      $
      （如果常元不足，做常元扩展即可）\
      该记法成立是因为 $D_I$ 是元语言中的集合，其中元素与记法无关，因此不妨就用 #language 中的常元符号。
    ]
    #definition[赋值][
      令 #Interpret 是一个论域为 $D_I$ 的解释，称一个 #language 的项集到 $D_I$ 的映射 $v$ 是一个赋值，如果：
      $
        v(a_i) = overline(a_i)\
        v(f(a_1, ..., a_n)) = overline(f)(v(a_1), ..., v(a_n))\
      $
    ]
    #remark[][
      注意上面的赋值并没有要求对变元的行为。事实上，一个变元也是一个项，因此的确需要确定变元的赋值。同时，由项的构造语法，一组确定的变元赋值便可以唯一确定一个赋值。
    ]
    #definition[$i-$ 等值][
      称两个赋值 $v, w$ 是 $i-$ 等值的，如果对于所有 $x_j != x_i$，$v(x_j) = w(x_j)$，也就是两个赋值在除了 $x_i$ 之外的所有变元上是相同的。
    ]
    #definition[可满足性][
      定义 $calA$ 是 #language 中公式，#Interpret 是一个解释，$tilde(v)$ 是一个变元赋值，称 $calA$ 在 $I$ 中对 $v$ 成立，记作 $Interpret, v models calA[tilde(v)]$ 或者简写为 $Interpret, v models calA， v models calA$，如果：
      - 若 $calA$ 是原子 $A_m^n (a_1, ..., a_n)$，则定义为 $overline(A_m^n)(v(a_1), ..., v(a_n)) = T$
      - 若 $calA$ 是 $not1 calB$，则定义为 $Interpret, v notModels calB$
      - 若 $calA$ 是 $calB -> calC$，则定义为 $Interpret, v models not1 calB$ 或者 $Interpret, v models calC$
      - 若 $calA$ 是 $forall x_i s(calB)$，则定义为对于所有与 $v space $ $i-$等值的赋值 $w$，均有 $Interpret, w models calB$，这等价于对于任意 $d_i in D_I$，均有 $Interpret, v models calB(x_i \/ d_i)$
    ]
    #theorem[][
      设 $v$ 是一个赋值，$v'$ 是另一个赋值，它们 $i-$ 等值，且 $v'(x_i) = v(t)$，则有对于任意项 $s$，都有：
      $
        v(s(x_i \/ t)) = v'(s)
      $
    ]
    #proof[
      归纳证明即可
    ]
    #theorem[][
      设 $calA(x_i)$ 是公式，$t$ 是项，且在 $calA(x_i)$ 中对 $x_i$ 自由。设 $v$ 是一个赋值，$v'$ 是另一个赋值，它们 $i-$ 等值，且 $v'(x_i) = v(t)$，则我们有：
      $
        v models calA(t) <=> v' models calA(x_i)
      $
    ]<substitution-theorem>
    #proof[
      $
        &"match" calA(x_i) with\
        &| A_m^n (a_1, ..., a_n) => v' models calA(x_i) &&<=> overline(A_m^n)(v'(a_1), ..., v'(a_n)) = T\
        &space &&<=> overline(A_m^n)(v(a_1 (x_i \/ t)), ..., v(a_n (x_i \/ t))) = T\
        &space &&<=> v models A_m^n (a_1(x_i \/ t), ..., a_n (x_i \/ t)) \
        &space &&<=> v models calA(t)\
        &| not1 calB(x_i) => "易证"\
        &| calB(x_i) -> calC(x_i) => "易证"\
        &| forall x_i calB(x_i) => "替换只替换自由变元，显然"\
        &| forall x_j calB(x_i) => v' models calA(x_i) &&<=> "forall" d_i in D_I, v' models calB(x_i)(x_j \/ d_i)\

      $
      #lemmaLinear[][
        $t$ 在 $calB(x_i)(x_j \/ d_i)$ 对 $x_i$ 自由，且 $calB(x_i)(x_j \/ d_i)(x_i \/ t) = calB(t)(x_j \/ d_i)$
      ]
      #proof[
        - 假设 $t$ 中有 $x_j$ 自由出现，那么由 $t$ 对 $x_i$ 自由的定义，$x_i$ 将不能在 $calB(x_i)$ 中出现，结论显然。
        - 否则，$t$ 中无 $x_j$ 自由出现，不难验证 $t$ 在 $calB(x_i)(x_j \/ d_i)$ 对 $x_i$ 自由等价于 $t$ 在 $calB(x_i)$ 对 $x_i$ 自由，立刻由条件保证，而替换顺序的交换是容易的。
      ]
      由引理及归纳假设：
      $
        &"forall" d_i in D_I, v models calB(x_i)(x_j \/ d_i)(x_i \/ t) \
        &<=> "forall" d_i in D_I, v models calB(x_i)(x_j \/ d_i)(x_i \/ t) \
        &<=> "forall" d_i in D_I, v models calB(t)(x_j \/ d_i)\
        &<=> v models  forall x_j calB(t)
      $
    ]
  == 真值
    #definition[][
      - 一个公式 $calA$ 在 #Interpret 中为真，如果对于每个赋值 $v$，$v models calA$。我们称 $calA$ 是可满足的，如果存在一个赋值使得 $calA$ 为真。若 $calA$ 是不可满足的，我们称 $calA$ 是假的。
      - 一个解释 #Interpret 称为 #calA 的模型，如果在其中 #calA 为真，记作 $I models calA$。若在其中 #calA 为假，则称 #Interpret 不是 #calA 的模型。
      - 设 $Gamma$ 是一个公式集，称 $I$ 是 $Gamma$ 的模型，如果对于每个 $calA in Gamma$，$I models calA$。
      - 若对于所有模型，都有 $Interpret models calA$，则称 $calA$ 是逻辑有效的，记作 $models calA$；类似的，若在每个模型下均假，则称之为矛盾式，记作 $notModels calA$
    ]
    #remark[][
      显然有些公式在某些解释中既不真也不假，但不可能有公式在某个解释下又真又假，也不可能 $calA, not1 calA$ 都为真/有效。若公式带有自由变元，则该公式很可能在某个解释下既不真也不假。但后面会说明，不含自由变元的公式一定在某个解释下有确定的真值。
    ]
    #proposition[][
      给定解释 #Interpret, 设 $calA, calA -> calB$ 都为真，则 $calB$ 为真
    ]
    #proof[
      任取赋值 $v$，有：
      $
        v models calA, calA -> calB
      $
      而由定义，$v models calA -> calB$ 当且仅当 $v models not1 calA$ 或 $v models calB$，然而 $v$ 不可能同时满足 $calA, not1 calA$，因此 $v models calB$
    ]
    #corollary[][
      若 $calA, calA -> calB$ 都是有效的，则 $calB$ 也是有效的
    ]
    #proposition[][
      设 $calA$ 是公式，则 $I models calA$ 当且仅当 $I models forall x_i calA$，其中 $x_i$ 为任意变元。
    ]
    #proof[
      两者事实上都是“对于任意赋值 $v$ 有 $v models calA$”
    ]
    #corollary[][
      $calA$ 是有效的当且仅当 $forall x_i calA$ 是有效的，其中 $x_i$ 为任意变元。
    ]
    #remark[][
      上面的命题说明，在考虑真值时，我们用 $A(x_i)$ 代替 $forall x_i, A(x_i)$ 是不会产生问题的。这被称为*全称量化公式*
    ]
    #proposition[][
      给定解释 #Interpret，则 $v models exists x_i calA$ 当且仅当至少存在一个 $i-$等值于 $v$ 的赋值 $w$ 使得 $w models calA$
    ]
    #definition[替换实例][
      设 $calA_0$ 是 $language_0$ 中的一个公式，$calA$ 是 $language$ 中的一个公式。用 $calA$ 替换 $calA_0$ 中某一个命题符的所有出现，得到 #language 中的公式 $calA'$，这被称为 $calA_0$ 的一个替换实例。
    ]
    #definition[重言式][
      称 #calA 是 #language 的重言式，如果它是 $language_0$ 中一个重言式的一个替换实例。
    ]
    #proposition[][
      #language 中的重言式在任何解释中均为真
    ]
    #proof[
      假设重言式是由 $calA$ 替换 $calA_0$ 中 $p_0$ 得到的。任给解释 #Interpret 和赋值 $v$，构造 $language_0$ 中赋值 $v'$，使得：
      $
        v'(p_0) = v(calA)\
        v'(p_i) = v(p_i) "if" p != p_0
      $
      容易验证 $v models calA$ 当且仅当 $v' models calA_0$，而后者由重言式定义显然成立。
    ]
    #remark[][
      不是所有有效式都是重言式，例如 $forall x_1, x_1 -> x_1$
    ]
    #definition[][
      若 #calA 中没有自由变元出现，则称之为闭式，否则称为开式。有时，也将不含量词的开式称为纯开式
    ]
    #remark[][
      前面定义闭项是不含变元的项，与闭式略有不同。可以证明有效的纯开式必是重言式。
    ]
    #proposition[][
      令 #Interpret 是一解释，$v, v'$ 是两个赋值，且满足对于 $calA$ 中每个自由变元 $x_i$ 均有 $v(x_i) = v'(x_i)$，则 $v models calA$ 当且仅当 $v' models calA$
    ]
    #proof[
      简单使用结构归纳法即可。
    ]
    #corollary[][
      设 $calA$ 是一个闭式，则任意两个赋值下 $calA$ 的真值相同。特别的，$calA$ 要么为真，要么为假。
    ]
    #definition[蕴含/等价][
      - 设 $calA, calB$ 是公式，称 $calA$ 蕴含 $calB$，记作 $calA models calB$，如果所有 $calA$ 的模型也是 $calB$ 的模型。
      - 若 $calA, calB$ 互相蕴含，则称之为逻辑等价，记作 $calA eq.triple calB$
    ]<logic-equiv>
  == 斯科伦式
    #definition[][
      若公式 $exists x_i calB$ 出现在 $calA$ 中，且属于 $forall x_(i 1) ... x_(i t)$ 的辖域，则可删除 $exists x_i$ ，且以函项 $h_i^r (x_(i 1), ..., x_(i t))$ 替换 $x_i$，其中 $h_i^r (x_(i 1), ..., x_(i t))$ 称为斯科伦函项，替换后的公式称为斯科伦式。
    ]
    斯科伦式和原式未必是等价的。只有以下的弱等价关系：
    #theorem[弱等价性/反证等价性][
      设 $calA$ 是公式，则它是矛盾的当且仅当它的斯科伦式是矛盾的
    ]
= 一阶逻辑：证明论
  == 形式系统
    对于固定的一阶语言 #language，我们用 $K_language$ 代表其上的形式系统，也可简记为 $K$
    #definition[一阶逻辑的形式系统][
      在一阶语言之上，定义以下公理：
      - K1 : $calA -> (calB -> calA)$
      - K2 : $(calA -> (calB -> calC)) -> ((calA -> calB) -> (calA -> calC))$
      - K3 : $(not1 calA -> not1 calB) -> (calA -> calB)$
      - K4 : $forall x_i calA -> calA (x_i \/ t)$ ，其中 $t$ 在 $calA$ 中对 $x_i$ 自由
      - K5: $forall x_i (calA -> calB) -> (calA -> (forall x_i calB))$，其中 $x_i$ 不在 $calA$ 中自由出现
      推理规则包括：
      - R1（分离规则, MP）：若 $calA, calA -> calB$ 则 $calB$
      - R2（概括规则, gen）：若 $calA$，则 $forall x_i calA$
    ]
    #definition[证明][
      一个证明是一个有限长度的公式序列 $calA_1, ..., calA_n$，满足：
      - 对于每个 $calA_i$，要么是公理，要么是之前的公式通过推理规则得到
      此时，称 $tack calA_n$

      类似的，设 $Gamma$ 是公式集，则该公式集下的证明是一个有限长度的公式序列 $calA_1, ..., calA_n$，满足：
      - 对于每个 $calA_i$，要么是公理，要么是 $Gamma$ 中的公式，要么是之前的公式通过推理规则得到
      此时，称 $Gamma tack calA_n$，也称 $calA$ 是 $Gamma$ 的一个后承
    ]
    #proposition[][
      若 $calA$ 是重言式，则 $calA$ 是定理
    ]
    #proof[
      注意到 $calA$ 是重言式当且仅当它是命题逻辑中重言式的替换，而由命题逻辑的完全性它是命题逻辑中的定理。由于一阶逻辑的公理和推理规则都是命题逻辑的推广，因此 $calA$ 也是一阶逻辑的定理。
    ]
    #proposition[][
      K4, K5 是逻辑有效的
    ]
    #proof[
      考虑任意的模型和任意的赋值即可，利用 @substitution-theorem 即可
    ]
    #theorem[可靠性 / Soundness][
      #language 中的任何公式都是逻辑有效的，也即：
      $
        tack calA => models calA
      $
    ]<first-order-soundness>
    #corollary[一致性][
      K 是一致的，也即不存在公式 $calA$ 使得 $tack calA$ 且 $tack not1 calA$
    ]
    #remark[][
      演绎定理在一阶逻辑中不再有效。考虑：
      $
        calA tack forall x_i calA
      $
      这就是概括规则本身，然而：
      $
        tack calA -> forall x_i calA
      $
      是不正确的，事实上，它不是有效的。
    ]
    #definition[][
      设 $Gamma$ 是公式集，$calA in Gamma$，考虑一个基于 $Gamma$ 的证明序列 $calA_i$，称 $calA_i$ 依据于 $calA$，如果：
      - $calA_i = calA$ 且它来源于 $calA in Gamma$，或者
      - $calA_i$ 来源于演绎规则，而演绎规则中涉及了依据于 $calA$ 的公式

    ]
    #proposition[][
      若 $Gamma, calA tack calB$，且 $calB$ 不依据于 $calA$，则 $Gamma tack calB$
    ]
    #proof[
      显然
    ]
    #theorem[演绎定理][
      设 $Gamma union {calA} tack calB$，且演绎对涉及 $calA$ 中自由出现的变元没有使用概括规则，则 $Gamma tack calA -> calB$
    ]
    #proof[
      对演绎序列做归纳：
      - 若只有一个公式 $calB$，结论容易验证
      - 否则，考虑 $calB$ 的来源：
        - 来源于公理集或 $Gamma union {calA}$，显然
        - 来源于 MP，同命题逻辑中演绎定理的证明
        - 由演绎中前面的公式用概括规则而得。此时可设：
          $
            calB = forall x_i calC
          $
          由假设条件，我们可以知道 $x_i$ 不在 $calA$ 中自由出现。归纳假设给出：
          $
            Gamma tack calA -> calC
          $
          概括规则给出：
          $
            Gamma tack forall x_i (calA -> calC)
          $
          K5 和 MP 规则给出：
          $
            Gamma tack calA -> (forall x_i calC)
          $
          证毕
    ]
    #corollary[][
      设 $calA$ 是闭式，且 $Gamma union {calA} tack calB$，则 $Gamma tack calA -> calB$
    ]
    #corollary[][
      对任意 #language 中的公式 $calA, calB, calC$ 有：
      $
        calA -> calB, calB -> calC tack calA -> calC
      $
    ]
    #proof[
      同命题逻辑
    ]
    #theorem[演绎定理的逆][
      若 $Gamma tack calA -> calB$，则 $Gamma union {calA} tack calB$
    ]
    #proof[
      同命题逻辑
    ]
    #example[][
      $tack forall x_1 forall x_2 calA -> forall x_2 forall x_1 calA$

      先证明 $forall x_1 forall x_2 calA tack forall x_2 forall x_1 calA$
      #deduction[
        + $forall x_1 forall x_2 calA := fS$
        + $forall x_2 calA := MPb(1, K4)$
        + $calA := MPb(2, K4)$
        + $forall x_1 calA := GEN(3)$
        + $forall x_2 forall x_1 calA := GEN(4)$
      ]
      注意到演绎符合演绎定理的条件，因此原命题成立
    ]
    #example[][
      设 $x_i$ 不在 $calA$ 中自由出现，则有 $tack (calA -> forall x_i calB) -> forall x_i (calA -> calB)$

      先证明 $calA -> forall x_i calB tack forall x_i (calA -> calB)$
      #deduction[
        + $calA -> forall x_i calB := fS$
        + $forall x_i calB -> calB := K4$
        + $calA -> calB := transitivity(1, 2)$
        + $forall x_i (calA -> calB) := GEN (x_i) (3)$
      ]
      注意到由条件，$x_i$ 不在 $calA$ 中自由出现，因此利用演绎定理命题成立。

      这就是 K5 的反向，而其中并未用到 K5
    ]
    #proposition[][
      - $tack forall x_i (calA -> calB) -> (forall x_i calA -> forall x_i calB)$
      - $tack forall x_i (calA -> calB) -> (exists x_i calA -> exists x_i calB)$
    ]
    #definition[导出规则][
      以下介绍一些导出规则，它们由演绎定理和之前的方法可以容易地推出（特别的，它们不会对在公式中自由出现的变元利用 GEN）：
      - R3（特例规则）: 若 $t$ 在 $calA$ 中对 $x_i$ 自由，则 $forall x_i calA -> calA(x_i \/ t)$
      - R4（存在规则）：若 $t$ 在 $calA$ 中对 $x_i$ 自由，则：
        $
          calA(x_i \/ t) tack exists x_i calA
        $
      - 否定消去 $not1 not1 calA tack calA$
      - 否定引入 $calA tack not1 not1 calA$
      - 合取消去 $calA and calB tack calA, calB$
      - 合取消去 $not1 (calA and calB) tack not1 calA or not1 calB$
      - 合取引入 $calA, calB tack calA and calB$
      - 析取消去 $calA or calB, not1 calA tack calB$
      - 析取消去 $calA or calB, not1 calB tack calA$
      - 析取消去 $not1 (calA or calB) tack not1 calA and not1 calB$
      - 析取消去 $calA -> calC, calB -> calC, calA or calB tack calC$
      - 析取引入 $calA tack calA or calB, calB tack calA or calB$
      - ...
      由这些引入规则和消去规则定义的证明论称为 Gentzen 型证明论，它与之前的证明论等价。
    ]

    #example[][
      $tack forall x_i calA -> exists x_i calA$
    ]
    #proof[
      #deduction[
        + $forall x_i calA := fS$
        + $calA := R3$
        + $exists x_i calA := R4$
        + $forall x_i calA tack exists x_i calA$
        + $tack forall x_i calA -> exists x_i calA$
      ]
    ]
  == 等价
    #definition[可证等价][
      若 $calA, calB$ 是公式，称 $calA$ 和 $calB$ 是可证等价的，如果 $tack calA <-> calB$
    ]
    #proposition[][
      可证等价是自反的、对称的、传递的
    ]
    #proposition[][
      若 $calA, calB$ 可证等价，则它们逻辑等价（@logic-equiv）
    ]
    #proof[
      就是 @first-order-soundness
    ]
    #remark[][
      逻辑等价也可以证明论地定义为：
      $
        calA tack calB "iff" calB tack calA
      $
      使用之后我们会证明的一阶逻辑完备性，它和之前模型论的完备性是等价的。然而注意到，它与
      $
        tack calA <-> calB
      $
      并不相同，既然一阶逻辑的演绎定理需要一些额外的条件。
    ]
    #proposition[变元换名][
      假设 $x_j$ 不在 $calA$ 中（自由或约束）出现，则：
      $
        tack forall x_i calA <-> forall x_j calA(x_i \/ x_j)
      $
    ]
    #definition[全称闭式][
      设 $calA$ 中所有自由变元为 $x_1, x_2, ..., x_n$，则称：
      $
        forall x_1 forall x_2 ... forall x_n calA
      $
      为 $calA$ 的全称闭式，将其记作 $calA'$。容易证明，逻辑闭式与 $calA$ 逻辑等价，但并不一定可证等价。
    ]
    #theorem[替换定理][
      设 $calA, calB$ 是公式，设 $calB_0$ 是用 $calB$ 替换 $calA_0$ 中的一次或多次替换 $calA$ 的出现的公式，则：
      $
        tack (calA <-> calB)' -> (calA_0 <-> calB_0)
      $
    ]
    #proof[
      往证：
      $
        (calA <-> calB)' tack calA_0 <-> calB_0
      $
      对 $calA_0$ 做结构归纳：
      - $calA_0 = calA$ 显然
      - $calA_0$ 不含 $calA$ 作为子公式：显然
      - $calA_0 = calA_1 -> calA_2$，归纳假设给出：
        $
          (calA <-> calB)' tack calA_1 <-> calB_1\
          (calA <-> calB)' tack calA_2 <-> calB_2
        $
        HS 容易给出 $(calA <-> calB)' tack calB_1 -> calB_2$
      - $calA_0 = not1 calA_1$，归纳假设给出：
        $
          (calA <-> calB)' tack calA_1 <-> calB_1
        $
        重言式 $(calA_1 <-> calB_1) <-> (not1 calB_1 <-> not1 calA_1)$ 给出：
        $
          (calA <-> calB)' tack not1 calB_1 <-> not1 calA_1 = (calB_0 <-> calA_0)
        $
      - $calA_0 = forall x_i calA_1$，归纳假设给出：
        $
          (calA <-> calB)' tack  calA_1 <-> calB_1
        $
        同时注意到：
        $
          calA_1 <-> calB_1 tack forall x_i (calA_1 <-> calB_1) tack forall x_i calA_1 <-> forall x_i calB_1
        $
        这里对 $x_i$ 使用了 GEN 规则，但是既然 $(calA <-> calB)'$ 是全称闭式，因此不会破坏演绎定理的条件。
    ]
    #corollary[][
      - 若 $tack calA <-> calB$，则 $tack calA_0 <-> calB_0$
      - 若 $tack calA <-> calB$，且 $tack calA_0$，则 $tack calB_0$
    ]
  == 前束范式和子句范式
    #proposition[][
      - $tack not1 (forall x_i) calA <-> (exists x_i) not1 calA$
      - $tack not1 (exists x_i) calA <-> (forall x_i) not1 calA$
      此外，若 $x_i$ 不在 $calA$ 中自由出现，则：
      - $tack forall x_i (calA -> calB) <-> (calA -> forall x_i calB)$
      - $tack exists x_i (calA -> calB) <-> (calA -> exists x_i calB)$
      - $tack (exists x_i calB -> calA) <-> (not1 forall x_i not1 calB -> calA) <-> (not1 calA -> forall x_i not1 calB) <-> forall x_i (calB -> calA)$
      - $tack (forall x_i calB -> calA) <-> (not1 calA -> exists x_i not1 calB) <-> exists x_i (calB -> calA)$
    ]<prop-quantifier>
    #definition[前束范式][
      称形如：
      $
        Q_1 x_1 ... Q_n x_n calA
      $
      的公式为前束范式，其中 $Q_i$ 是量词，$x_i$ 是变元，$calA$ 是无量词公式。如果所有的存在量词都在全称量词的左边，则称之为斯科伦前束范式。此外，$calA$ 往往被化成命题逻辑的合取范式或析取范式。
    ]
    #theorem[][
      任意公式 $calA$ 都存在前束范式 $calB$ 与其可证等价
    ]
    #proof[
      由换名规则，不妨设 $calA$ 中自由变元和约束变元不存在重名。考虑 $calA$ 为：
      - 原子公式：显然
      - $not1 calC$: 归纳假设给出 $calC$ 的前束范式 $Q_1 x_1 ... Q_n x_n calC'$，而：
        $
          not1 Q_1 x_1 ... Q_n x_n calC' <-> Q_1^* x_1 ... Q_n^* x_n not1 calC'
        $
        其中 $Q_i^*$ 是 $Q_i$ 的对偶，成立性来自于 @prop-quantifier
      - $calB -> calC$:
        归纳假设给出：
        $
          tack calB <-> Q_1 x_1 ... Q_n x_n calB'\
          tack calC <-> P_1 y_1 ... P_n y_n calC'
        $
        无妨设 $x_i != x_j, x_1 != y_j$，则由替换定理的推论，有：
        $
          tack (Q_1 x_1 ... Q_n x_n calB' -> P_1 y_1 ... P_n y_n calC') <-> calA
        $
    ]
    #definition[$Pi, Sigma$][
      称前束范式为 $Pi_n$ 范式，如果它以全称量词开始，且量词交替 $n - 1$ 次。称前束范式为 $Sigma_n$ 范式，如果它以存在量词开始，且量词交替 $n - 1$ 次。该概念在涉及一阶逻辑的计算中很有用。
    ]
    #theorem[弱等价性定理][
      设 $K^s$ 是把 $K$ 的每个公理换成斯科林式而得，则：
      - 若 $calB$ 是 $K$ 的公式且 $tack_(K^s) calB$，则 $tack_K calB$
      - $K$ 是一致的当且仅当 $K^s$ 是一致的
    ]
    #definition[子句式][
      - 称原子或原子的否定为一个文字
      - 称文字的析取为一个子句
      - 称一个公式为子句范式，如果它是子句的合取（也就是文字构成的合取范式）
    ]
    #theorem[][
      任意公式都有子句范式与其弱等价
    ]
    #proof[
      + 首先求出该公式的前束合取范式
      + 再通过斯科伦化，去掉所有存在量词
      + 最后，直接去掉所有全称量词
      不难验证这就是我们需要的子句范式
    ]
