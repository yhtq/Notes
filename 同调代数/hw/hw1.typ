#import "../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#import "../main.typ": *
= 9.8
  == 1
    不是。任取 $A, B : Set$ 以及 $f : A -> B$ $Set$ 的一个子范畴如下：
    #align(center)[#commutative-diagram(
    node((0, 0), $A$, 1),
    node((0, 1), $B$, 2),
    arr(1, 2, $f$),
    )]
    （以及 $A, B$ 上的 $id$ 态射）则不难验证 $f$ 是满态射（所有 $->A$ 的态射只有 $id : A -> A$，但 $f$ 是任意的，当然未必是满射。
  == 2
    不一定是。任取 $GL(V)$ 中一个外自同构 $phi$ 以及 $rho : G -> GL(V)$：
    #align(center)[#commutative-diagram(
    node((0, 0), $G$, 1),
    node((0, 1), $GL(V)$, 2),
    node((1, 0), $GL(V)$, 3),
    arr(1, 2, $rho$),
    arr(3, 2, $phi$, bij_str),
    arr(1, 3, $phi rho$),)]
    显然 $phi, Inv(phi)$ 在 $C$ 中构成一对 $rho -> phi rho$ 同构，但它不能表示为某个矩阵的共轭（否则将成为内自同构）
= 9.10
  == $Set$
    积是集合的笛卡尔积，泛性质为：
    #align(center)[#commutative-diagram(
    node((0, 0), $X times Y$, 1),
    node((0, 1), $X$, 2),
    node((1, 0), $Y$, 3),
    node((1, 1), $Z$, 4),
    arr(1, 2, $$),
    arr(1, 3, $$),
    arr(4, 2, $$),
    arr(4, 3, $$),
    arr(4, 1, $exists !f$, "dashed")
    )]
    显然，$f$ 定义为 $z |-> ((Z -> X) x, (Z -> Y) y)$，并不难验证它是唯一的

    余积为集合的不交并，泛性质为：
    #align(center)[#commutative-diagram(
    node((0, 0), $X + Y$, 1),
    node((0, 1), $X$, 2),
    node((1, 0), $Y$, 3),
    node((1, 1), $Z$, 4),
    arr(2, 1, $$),
    arr(3, 1, $$),
    arr(2, 4, $$),
    arr(3, 4, $$),
    arr(1, 4, $exists !f$, "dashed")
    )]
    显然，$f$ 定义为：
    $
      f(x : X) = (X -> Z) x\
      f(y : Y) = (Y -> Z) y 
    $
    并不难验证它是唯一的
  == $Top$
    积使用如下构造，对于 $X, Y$，$X times Y$ 在集合上为笛卡尔积，开集为所有 $U times V$，其中 $U, V$ 是 $X, Y$ 中的开集。$X times Y -> X, Y$ 的映射为笛卡尔积的投影映射，容易验证它是连续的。$f$ 的定义与上面一致，连续性是因为对于任何 $U, V$ 是开集，都有：
    $
      Inv(f)(U times V) = Inv(Z -> X)(U) inter Inv(Z -> Y)(V) 
    $
    这是两个开集的交，当然也是开集。唯一性与上面一致

    余积由如下构造，对于 $X, Y$，$X + Y$ 在集合上为不交并，开集为所有 $U, V$ 的并，其中 $U, V$ 是 $X, Y$ 中的开集。$X, Y -> X + Y$ 的映射为不交并的自然嵌入映射，容易验证它是连续的。$f$ 的定义与上面一致，连续性是因为对于任何 $W subset Z$ 是开集，都有：
    $
      Inv(f)(W) = Inv(X -> Z)(W) union Inv(Y -> Z)(W)
    $
    这是两个开集的并，当然也是开集。唯一性与上面一致
  == $kVect(k)$
    积和余积均为直和空间 $X directSum Y$，使用自然的投影和嵌入映射。对于积，$f$ 定义为：
    $
      f(z : Z) = (Z -> X) z + (Z -> Y) z
    $
    唯一性是因为，对于符合条件的 $f$ 设：
    $
      f(z) = a(z) + b(z), a(z) in X, b(z) in Y\
    $
    则一定有：
    $
      a(z) = (Z -> X) z, b(z) = (Z -> Y) z
    $
    因此 $f$ 是唯一的

    对于余积，$f$ 定义为：
    $
      f(x : X + z : Z) = (X -> Z) x + (Y -> Z) z
    $
    唯一性是因为，对于符合条件的 $f$，一定有：
    $
      f(x) = (X -> Z) x, f(y) = (Y -> Z) y\
    $
    结合线性性，$f$ 是唯一的
  == $Ring$
    环的积使用如下构造，对于 $R, S$，$R times S$ 在集合上为笛卡尔积，环加法和乘法逐点定义。$R times S -> R, S$ 的映射为笛卡尔积的投影映射，容易验证它是环同态。$f$ 的定义。唯一性与集合范畴一致，且容易验证这样的 $f$ 是环同态。

    环的余积定义为：
    #let Seq = $bold("Seq")(R, S)$
    $
      directSum_(s in Seq) (tensorProduct s) quo ~
    $
    其中：
    - $Seq$ 是所有 $R, S$ 构成的有限序列（包括空），使得 $S, R$ 不连续出现
    - $tensorProduct$ 是阿贝尔群的张量积，$directSum$ 是阿贝尔群的直和
    - $~$ 是最小的满足：
      $
        forall s in Seq, S s in Seq:
          tensorProduct_(i : s) x_i ~ (1 : S) tensorProduct_(i : s) x_i\
        forall s in Seq, R s in Seq:
          tensorProduct_(i : s) x_i ~ (1 : R) tensorProduct_(i : s) x_i\
        forall s in Seq, s S in Seq:
          tensorProduct_(i : s S S) x_i ~ tensorProduct_(i : s S) x_i (1 : S)\
        forall s in Seq, s R in Seq:
          tensorProduct_(i : s R R) x_i ~ tensorProduct_(i : s R) x_i (1 : R)\
        forall s_1, s_2 in Seq, s_1 R s_2("or" s_1 S s_2) in Seq:\
          (tensorProduct_(i : s_1) x_i tensorProduct 1) tensorProduct (tensorProduct_(i : s_2) y_i) ~ (tensorProduct_(i : "heads" s_1) x_i) tensorProduct (x_("last "s_1) y_("head "s_2)) tensorProduct (tensorProduct_(i : "tails" s_2) y_i)
      $
      的等价关系。
    定义乘法为：
      $
        (tensorProduct_(i : s) x_i)(tensorProduct_(i : t) y_i) = tensorProduct_(i : s t) z_i "if" "last" s != "head" t\
        (tensorProduct_(i : s) x_i)(tensorProduct_(i : t) y_i) = tensorProduct_(i : "heads" s) z_i tensorProduct z_("last" s) z_("head" t) tensorProduct (tensorProduct_(i : "tails" t) z_i) "if" "last" s = "head" t\
        
      $
    （加法为阿贝尔群的加法）可以验证它构成环，$R, S$ 的嵌入映射就是嵌入到 $R, S : Seq$ 直和项的映射（可以验证是环同态）。在泛性质中，$f$ 的定义为：
    $
      f(directSum_(s in Seq) (tensorProduct_(i : s) x_i)) = sum_(s in Seq) (product_(i : s) (s[i] -> Z) x_i) 
    $
    唯一性是因为满足条件的 $f$ 一定有：
    $
      f(directSum_(s in Seq) (tensorProduct_(i : s) x_i)) = sum_(s in Seq) f(tensorProduct_(i : s) x_i) = sum_(s in Seq) product_(i : s) f(x_i) \
      = sum_(s in Seq) product_(i : s) (s[i] -> Z) x_i
    $
    因此只能是上面定义的 $f$，这就表明 $f$ 是唯一的。
      
    