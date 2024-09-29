#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "数理逻辑",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
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
#let deduction-theorem-b(a, b) = $ "deduction theorem" (#a) (#b)$
#let transitivity-b(a, b) = $ "transitivity" (#a) (#b)$
#let L1 = $"L1"$
#let L2 = $"L2"$
#let L3 = $"L3"$
#let idL = $"引理" calA -> calA$
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
    #pagebreak()
= 形式系统
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
    - 字符集是原子公式集以及 $~, ->, (, )$（括号作为技术性符号，未必需要）
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