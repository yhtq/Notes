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
      nums1.insert(0, 7)
      numbering("1.1.(a)", ..nums1)
    }
)
=
  == #empty
    有效，注意到：
    $
      exists x_1 forall x_2 A_1^2 (x_1, x_2) = not1 (forall x_1 not1 (forall x_2 A_1^2 (x_1, x_2)))\
      forall x_2 exists x_1 A_1^2 (x_1, x_2) = forall x_2 not1 (forall x_1 not1 A_1^2 (x_1, x_2))
    $
    在任意解释下，两式（及前后件）都是闭式，因此其真假值与赋值无关。
    - 若 $not1 (forall x_1 not1 (forall x_2 A_1^2 (x_1, x_2)))$ 为假则原式为真
    - 反之，若其为真，也即 $forall x_1 not1 (forall x_2 A_1^2 (x_1, x_2))$ 为假，表明有一赋值 $v_0$ 使得：
      $
        v_0(forall x_2 A_1^2 (x_1, x_2)) = T
      $<eq1>
      此时往证 $forall x_2 not1 (forall x_1 not1 A_1^2 (x_1, x_2))$ 为真，由全称量化只需证明 $not1 (forall x_1 not1 A_1^2 (x_1, x_2))$ 为真，也即 $forall x_1 not1 A_1^2 (x_1, x_2)$ 为假。为此，任取赋值 $v$，构造与 $v space 1-$等值的赋值 $v'$ 满足：
      $
        v'(x_1) = v_0 (x_1)
      $
      由于公式中只出现 $x_1, x_2$ 两个变元，不妨设 $v'$ 与 $v_0 space 2-$ 等值，进而由@eq1 知：
      $
        v'(A_1^2 (x_1, x_2)) = T\
        v'(not1 A_1^2 (x_1, x_2)) = F\
      $
      由 $v$ 的任意性知 $forall x_1 not1 A_1^2 (x_1, x_2)$ 为假，证毕。
  == #empty
    无效。考虑解释 $D_I = ZZ, A_1^2 (x_1, x_2) := x_1 < x_2$，则：
    $
      forall x_1, exists x_2, x_1 < x_2
    $
    为真，但：
    $
      exists x_2, forall x_1, x_1 < x_2
    $
    为假，故原式无效。
= #empty
  $x_1 -> x_1$ 是开式，但不难验证它是重言式，因此逻辑有效。
= #empty
  在任意解释中，任取赋值 $v$
  - 若 $v(calA(t)) = F$，当然有（该赋值下）原式为真
  - 否则 $v(calA(t)) = T$，往证 $v(exists x_i calA(x_i)) = T$，由存在量词的性质，只需找到与 $v space i-$ 等值的赋值 $v'$ 使得 $v'(calA(x_i)) = T$ 即可。事实上，取:
  $
    v'(x_i) &= v(t)\
    v'(x_j) &= v(x_j) (j != i)
  $
  则有替换定理及条件，不难得到：
  $
    v(calA(t)) = T <=> v'(calA(x_i)) = T
  $
  由条件，立刻有 $v'(calA(x_i)) = T$，因此这就是我们要找的 $v'$，得证。
= #empty
  依次消去存在量词:
  + 首先将 $exists x_2$ 消去，由于其只处在 $forall x_1$ 的辖域中，因此 $x_2$ 将被替换为 $h_1^1 (x_1)$，公式变为：
    $
      forall x_1 forall x_3 exists x_4 ((not1 A_1^2 (x_1, h_1^1 (x_1)) or A_2^1 (x_1)) -> A_2^2 (x_3, x_4))
    $
  + 其次将 $exists x_4$ 消去，它处在 $forall x_1, forall x_3$ 的辖域中，需要换为 $h_2^2 (x_1, x_3)$，公式变为：
    $
      forall x_1 forall x_3 ((not1 A_1^2 (x_1, h_1^1 (x_1)) or A_2^1 (x_1)) -> A_2^2 (x_3, h_2^2 (x_1, x_3)))
    $
  这就是斯科伦式。