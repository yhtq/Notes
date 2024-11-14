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
      nums1.insert(0, 9)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  == #empty
    使用换名规则，立得：
    $
      tack forall x_1 forall x_2 A_1^2 (x_1, x_2) <-> forall x_4 forall x_5 A_1^1 (x_4, x_5)\
      tack  forall x_4 forall x_5 A_1^2 (x_4, x_5) <-> forall x_2 forall x_3 A_1^2 (x_2, x_3)\
    $
    （其中换名变元不在公式中出现是显然的）接下来传递性给出：
    $
      tack forall x_1 forall x_2 A_1^2 (x_1, x_2) <-> forall x_2 forall x_3 A_1^2 (x_2, x_3)
    $
    当然就有：
    $
      forall x_1 forall x_2 A_1^2 (x_1, x_2) tack forall x_2 forall x_3 A_1^2 (x_2, x_3)
    $
  == #empty
    #deduction[
      + $forall x_2 A_1^2 (x_1, x_2) -> A_1^2 (x_1, x_1) := K4$（显然 $x_1$ 对 $x_2$ 自由）
      + $forall x_1 (forall x_2 A_1^2 (x_1, x_2) -> A_1^2 (x_1, x_1)) := GEN$
      + $(forall x_1 (forall x_2 A_1^2 (x_1, x_2) -> A_1^2 (x_1, x_1))) -> (forall x_1 forall x_2 A_1^2 (x_1, x_2) -> forall x_1 A_1^2 (x_1, x_1)):= forall x_1 (calA -> calB) -> (forall x_1 calA -> forall x_1 calB)$
      + $forall x_1 forall x_2 A_1^2 (x_1, x_2) -> forall x_1 A_1^2 (x_1, x_1) := MPb(2, 3)$
      + $forall x_1 A_1^2 (x_1, x_1) := MPb(fS, 4)$
    ]
= #empty
  #deduction[
    + $forall x_i not1 calA(x_i) <-> forall x_j not1 calA(x_j) := $ 换名定理
    + $(forall x_i not1 calA(x_i) <-> forall x_j not1 calA(x_j)) -> (not1 forall x_i not1 calA(x_i) <-> not1 forall x_j not1 calA(x_j)) := tauto$
    + $not1 forall x_i not1 calA(x_i) <-> not1 forall x_j not1 calA(x_j) := MPb(1, 2)$
  ]
  最后一式依定义等于：
  $
    exists x_i calA(x_i) <-> exists x_j calA(x_j)
  $
= #empty
  == #empty
    $
      forall x_1 (A_1^2 (x_1, x_2) -> forall x_2 A_1^2 (x_1, x_2))\
      forall x_1 (A_1^2 (x_1, x_2) -> forall x_3 A_1^2 (x_1, x_3))\
      forall x_1 forall x_3 (A_1^2 (x_1, x_2) ->  A_1^2 (x_1, x_3))\
       A_1^2 (x_1, x_2) ->  A_1^2 (x_1, x_3)\
    $
  == #empty
    $
      forall x_1 (A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> (exists x_2 A_1^1 (x_2) -> exists x_3 A_1^2(x_2, x_3))\
      exists x_1 ((A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> (exists x_2 A_1^1 (x_2) -> exists x_3 A_1^2(x_2, x_3)))\
      exists x_1 ((A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> (exists x_4 A_1^1 (x_4) -> exists x_3 A_1^2(x_2, x_3)))\
      exists x_1 ((A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> exists x_3 (exists x_4 A_1^1 (x_4) ->  A_1^2(x_2, x_3)))\
      exists x_1 ((A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> exists x_3 forall x_4( A_1^1 (x_4) ->  A_1^2(x_2, x_3)))\
      exists x_1 exists x_3 ((A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> forall x_4( A_1^1 (x_4) ->  A_1^2(x_2, x_3)))\
      exists x_1 exists x_3 forall x_4 ((A_1^1 (x_1) -> A_1^2 (x_1, x_2)) -> ( A_1^1 (x_4) ->  A_1^2(x_2, x_3)))\
       forall x_4 ((A_1^1 (c_1) -> A_1^2 (c_1, x_2)) -> ( A_1^1 (x_4) ->  A_1^2(x_2, c_3)))\
       ((A_1^1 (c_1) -> A_1^2 (c_1, x_2)) -> ( A_1^1 (x_4) ->  A_1^2(x_2, c_3)))\
    $
    其中 $c_1, c_3$ 分别是 $x_1, x_3$ 斯科伦化产生的常元
= #empty
  （本题中用 $<=>$ 代表可证等价）
  一方面：
  $
    exists x_1 calA(x_1) -> exists x_2 calB(x_2) <=> exists x_2 (exists x_1 calA(x_1) -> calB (x_2)) <=> exists x_2 forall x_1 (calA(x_1) -> calB (x_2))
  $
  这是 $Sigma_2$ 范式。另一方面：
  $
    exists x_1 calA(x_1) -> exists x_2 calB(x_2) &<=> not1 exists x_2 calB(x_2) -> not1 exists x_1 calA(x_1) \
    &<=> forall x_2 not1 calB(x_2) -> forall x_1 not1 calA(x_1)\
    &<=> forall x_1 (forall x_2 not1 calB(x_2) ->  not1 calA(x_1))\
    &<=> forall x_1 exists x_2 (not1 calB(x_2) ->  not1 calA(x_1))\
  $
  这是 $Pi_2$ 范式
= #empty
  考虑如下模型：
  - 论域为平面上的点
  - $T(x, y, z)$ 表示三点 $x, y, z$ 构成三角形
  - $C(u, v, w, x, y, z)$ 表示三角形 $u v w$ 与三角形 $x y z$ 全等
  - $S(u, v, x, y)$ 表示线段 $u v$ 与线段 $x y$ 相等
  - $A(u, v, w, x, y, z)$ 表示角 $u v w$ 等于角 $x y z$
  前提为：
  - $forall u v w, (T(u, v, w) -> T(u, w, v))$
  - $forall u v, S(u, v, u, v)$ （边自反性）
  - $forall u v, S(u, v, v, u)$ （边对称性）
  - $forall u v w x y z,T(u, v, w) -> T(x, y, z) -> S(u, v, x, y) -> S(u, w, x, z) -> S(v, w, y, z) -> C(u, v, w, x, y, z)$ (SSS 全等)
  - $forall u v w x y z, T(u, v, w) -> T(x, y, z) -> C(u, v, w, x, y, z) -> A(u, v, w, x, y, z)$ （全等三角形的对应角相等）
  结论为：
  $
    forall a forall b forall c (T(a, b, c) -> S(a, b, a, c) -> C(a, b, c, a, c, b)) 
  $
  该公式证明如下：
  - 利用 GEN 和演绎定理，只需证明：
    $
      Gamma union {T(a, b, c), S(a, b, a, c)} tack C(a, b, c, a, c, b)
    $
    其中 $Gamma$ 是上面所述前提
  - 进行演算：
    #deduction[
      + $T(a, b, c) -> T(a, c, b) -> S(a, b, a, c) -> S(a, c, a, b) -> S(b, c, c, b) -> C(a, b, c, a, c, b) := fS, K4$
      + $T(a, b, c) := fS$
      + $T(a, c, b) := MPb(2, fS \,K4,)$
      + $S(a, b, a, c) -> S(a, c, a, b) -> S(b, c, c, b) -> C(a, b, c, a, c, b) := MPb(3, MPb(2, 1))$
      + $S(a, c, a, b) -> S(b, c, c, b) -> C(a, b, c, a, c, b) := MPb(fS, 4)$
      + $S(a, b, a, c) -> S(a, c, a, b) := fS, K4$
      + $S(a, c, a, b) := MPb(fS, 5)$
      + $S(b, c, c, b) -> C(a, b, c, a, c, b) := MPb(7, 5)$
      + $C(a, b, c, a, c, b) := MPb(fS\, K4, 8)$
      + $T(a, b, c) -> T(a, c, b) -> C(a, b, c, a, c, b) -> A(a, b, c, a, c, b) := fS, K4$
      + $C(a, b, c, a, c, b) -> A(a, b, c, a, c, b) := MPb(3, MPb(2, 10))$
      + $A(a, b, c, a, c, b) := MPb(9, 11)$
    ]
    由于其中没有用到 GEN，因此演绎定理是正确的。