#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#show: note.with(
  title: "作业3_1",
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
      nums1.insert(0, 6)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  - $v models calA and calB := v models calA$ 且 $v models calB$
  - $v models calA or calB := v models calA$ 或 $v models calB$ 
  - $v models exists x_i calA(x_i) := $ 存在一个与 $v$ $i-$ 等值的赋值 $v'$，使得 $v' models calA(x_i)$ 
= #empty
  $
    &"match" calA(t) with\
    &| A_m^n (a_1, ..., a_n) => v models calA(t) &&<=> overline(A_m^n)(v(a_1), ..., v(a_n)) = T\
    &space &&<=> overline(A_m^n)(v'(a_1 (x_i \/ t)), ..., v'(a_n (x_i \/ t))) = T "（递归条件）"\
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
= #empty
  解释为：
  $
    forall x, y: ZZ, (x - y < 0 -> x < y)
  $
  为真。定义另一个解释 $I'$，其中 $overline(f_1^2)(a, b) = a * b$，其它与 $I$ 相同，则公式解释为：
  $
    forall x, y: ZZ, (x * y < 0 -> x < y)
  $
  为假。

  第二个公式解释为：
  $
    forall x_1: ZZ, x_1 - x_2 < x_3
  $
  断言所有赋值都不可能使其为真。事实上，任取赋值 $v$，若：
  $
    v models forall x_1: ZZ, x_1 - x_2 < x_3
  $
  由任意量词的可满足性定义，取 $v'(x_1) = v(x_2) + v(x_3) + 1$ 是一个 $i-$ 等值的赋值，不难验证：
  $
    v' notModels x_1 - x_2 < x_3
  $
  进而：
  $
    v notModels forall x_1: ZZ, x_1 - x_2 < x_3
  $

  下一个公式解释为：
  $
    forall x_1: ZZ, 0 - x_1 < 0
  $
  显然为假，由任意量词的可满足性定义，可以取赋值 $v'$ 使得 $v'(x_1) = 0$，容易验证为假
= #empty
  取论域为 $ZZ$，$overline(A_1^1) (x) := x > 0, overline(f_1^1) (x) = -x$，则公式解释为：
  $
    forall x: ZZ(x > 0 -> -x > 0)
  $
  显然为假
= #empty
  在算术解释中，公式解释为：
  $
    forall x_1: NN, x_1 x_2 = x_3
  $
  取赋值 $v(x_2) = 0, v(x_3) = 0$，则前式为真\
  取赋值 $v(x_2) = 0, v(x_3) = 1$，则前式为假