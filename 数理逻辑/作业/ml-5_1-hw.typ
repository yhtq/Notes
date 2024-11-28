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
      nums1.insert(0, 11)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  任取模型 $M$，在其上都构造规范模型（论域为 $M$ 中论域的等价类，其他解释是典范的）
  #lemmaLinear[][
    公式 $calA$ 在 $M$ 上为真当且仅当它在 $M$ 对应的规范模型 $M_1$ 上为真
  ]
  #proof[
    #let ti = $t_1, t_2, ..., t_n$
    #let oti = $overline(t_1), overline(t_2), ..., overline(t_n)$
    由条件 $calA$ 在该规范模型 $M_1$ 中为真，往证 $calA$ 在 $M$ 中为真。对 $calA$ 做结构归纳法：
    - $calA = not1 calB, calB -> calC$ 显然
    - $calA = forall x calB$，由定义及归纳条件有：
      $
        M models forall x calB <=> forall d in D_M, M models calB (x\/d) <=> forall d in D_M, M_1 models calB (x\/d) <=> M_1 models forall x calB
      $
    - $calA = A_i^n (t_1, t_2, ..., t_n)$\
      由规范模型对谓词和项的解释的良定义性，显然
  ]
  由引理，结论显然
= #empty
  == #empty
    #deduction[
      + $x = x := fA$
      + $x = x -> calA(x) -> (x = x and calA(x)) := "and intro"$
      + $calA(x) -> (x = x and calA(x)) := MPb(1, 2)$
      + $(x = x and calA(x)) -> exists y (x = y and calA(y)) := "exists intro"$（注意到 $y$ 不在 $calA(x)$ 中出现）
      + $calA(x) -> exists y (x = y and calA(y)) := #transitivity-b(3, 4)$
      
    ]
    表明 $tack calA(x) -> exists y (x = y and calA(y))$，另一方面，先证明：
    $
      exists y (x = y and calA(y)) tack calA(x)
    $
    #deduction[
      + $x = y and calA(y) := "exists elim"$ （注意到 $y$ 不在 $calA(x)$ 中出现）
      + $x = y := "and elim left"(1)$
      + $y = x := MPb(2, "symm")$
      + $calA(y) := "and elim right"(1)$
      + $calA(x) := MPb(3, fA)$ (E8' 只说明了谓词符情形，但一般公式情形容易归纳得到)
    ]
    而证明过程中没有用到 GEN，因此演绎定理给出：
    $
      tack exists y (x = y and calA(y)) -> calA(x)
    $
    综合以上，以及
    $
      tack (calA(x) -> exists y (x = y and calA(y))) -> (exists y (x = y and calA(y)) -> calA(x)) -> (calA(x) <-> exists y (x = y and calA(y)))
    $
    使用 MP 即得结论
  == #empty
    #deduction[
      + $x = x := fA$
      + $exists y, x = y := "exists intro"$（注意到 $y$ 不在 $x = x$ 中出现）
      + $forall x, exists y, x = y := GEN$
    ]
= #empty
  定义一阶语言包括：
  - 变元 $x_1, x_2, ...$
  - 常元 $0, 1$
  - 函项符 $+, *, -("一元函项"), dot^(-1)$
  - 谓词符 $=$
  - 逻辑符 $forall, not1, ->$
  （这里为了直观起见，$+, *$ 都使用中缀形式）

  公理包括一阶逻辑公理，等词公理以及：
  - $x_1 + (x_2 + x_3) = (x_1 + x_2) + x_3$
  - $x_1 + x_2 = x_2 + x_1$
  - $x_1 + 0 = x_1$
  - $x_1 + (-x_1) = 0$
  - $x_1 * (x_2 * x_3) = (x_1 * x_2) *x_3$
  - $x_1 * x_2 = x_2 * x_1$
  - $x_1 * 1 = x_1$
  - $x_1 * (x_1)^(-1) = 1$
  - $x_1 * (x_2 + x_3) = (x_1 * x_2) + (x_1 * x_3)$
= #empty
  == #empty
    + 若 $x$ 是点，则它不是线
    + 若 $x$ 在 $y$ 上，则 $x$ 是点，$y$ 是线
    + 若 $x$ 是线，则其上存在不相等的两点
    + 若 $x, y$ 是不相等的两点，则存在唯一的线经过它们
    + 存在不共线三点
  == #empty
    先证明：
    $
      S(u) and S(v) and u != v, L(x, u) and L(x, v) and L(y, u) and L(y, v) tack x = y
    $
    #deduction[
      + $S(u) and S(v) := fS$
      + $L(x, u) and L(x, v) and L(y, u) and L(y, v) := fS$
      + $P(x) := "and-elim" MPb("and-elim"(2), fA)$
      + $P(y) := "and-elim" MPb("and-elim"(2), fA)$
      + $P(x) -> P(y) -> (x != y) -> (P(x) and P(y) and x != y) := tauto$
      + $(x != y) -> (P(x) and P(y) and x != y) := MPb(4, MPb(3,5))$
      + $P(x) and P(y) and x != y -> (exists_1 z)(S(z) and L(x, z) and L(y, z)) := fA$
      + $(exists_1 z)(S(z) and L(x, z) and L(y, z)) -> (forall x_1 forall x_2 (S(x_1) and L(x, x_1) and L(y, x_1) -> (S(x_2) and L(x, x_2) and L(y, x_2)) -> x_1 = x_2)) := "def"$
      + $(forall x_1 forall x_2 (S(x_1) and L(x, x_1) and L(y, x_1) -> (S(x_2) and L(x, x_2) and L(y, x_2)) -> x_1 = x_2)) -> S(u) and L(x, u) and L(y, u) -> (S(v) and L(x, v) and L(y, v)) -> u = v := "forall-elim"$
      + $x != y -> S(u) and L(x, u) and L(y, u) -> (S(v) and L(x, v) and L(y, v)) -> u = v := transitivity(..., ...)$
      + $S(u) and L(x, u) and L(y, u) := "and-intro" ("and-elim"(1), "and-elim"(2))$
      + $S(v) and L(x, v) and L(y, v) := "and-intro" ("and-elim"(1), "and-elim"(2))$
      + $calA -> ((calB -> (calA -> calC)) -> (calB -> calC)) := tauto$
      + $x != y -> (S(v) and L(x, v) and L(y, v)) -> u = v := MPb(9, MPb(11, 13))$
      + $x != y -> u = v := MPb(10, MPb(12, 13))$
      + $not1 (u = v) -> u = y -> (x = y) := tauto$
      + $u != v -> u = y -> (x = y) := "def"$
      + $u = y -> (x = y) := MPb(fA, 17)$
      + $x != y -> x = y := #transitivity-b(15, 18)$
      + $(not1 (x = y) -> x = y) -> (x = y) := tauto$
      + $(x != y -> x = y) -> (x = y) := "def"$
      + $x = y := MPb(19, 21)$
    ]
    几何语言为两个不相等的线的任意两个焦点相等
  == #empty
    === #empty
      不难发现 $u != v$ 可证等价于 $u = v -> (u != v)$，因此往证：
      $
        tack R(u, v) -> u = v -> u != v
      $
      用演绎定理，往证：
      $
        R(u, v), u = v tack u != v
      $
      事实上，显有：
      $
        R(u, v) tack not1 exists w (L(w, u) and L(w, v))
      $
      以及：
      $
        S(u) tack (exists y) (exists z) (y != z and L(y, x) and L(z, x)) tack exists y L(y, x) ("使用" exists, and "消去即可")
      $
      从而：
      $
        R(u, v), u = v tack exists y L(y, u) tack exists y L(y, v) and L(y, v)
      $
      总之有：
      $
        R(u, v), u = v tack (exists y L(y, u) tack exists y L(y, v) and L(y, v)) and (not1 exists w (L(w, u) and L(w, v)))
      $
      利用重言式 $calA and (not1 calA) -> calB$ 即得原式
    ===
      设论域为：
      - 点为 $ZZ_2$ 中的点
      - 线为 $ZZ_2$ 中的二元线性方程 $A x + B y + C = 0$ 的零点集（$A, B$ 不全为零）
      显然论域是有限集

      设点 $(x_0, y_0)$ 不在直线 $A x + B y + C = 0$ 上，则有 $A x_0 + B y_0 + C != 0$，考虑直线：
      $
        A x + B y  - (A x_0 + B y_0) 
      $
      则它是不同于且平行于直线 $A x + B y + C = 0$ 的直线，并且过 $(x_0, y_0)$。同时，考虑线性方程组：
      $
        A' x_0 + B' y_0 + C' = 0\
        A' B - A B' = 0
      $
      系数矩阵为：
      $
        mat(x_0, y_0, 1; B, -A, 0)
      $
      由于 $A, B$ 不全为零，解空间维度为一，说明满足条件的直线唯一
  ==
    取经典的平面射影几何，其中任何不相等的两条线都交于一点，因此没有平行线