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
      nums1.insert(0, 5)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  == #empty
    #let isFunc = $"is_func"$
    #let derivable = $"derivable"$
    #let continuous = $"continuous"$
    $not1 forall x (isFunc(x) -> derivable(x))$
  == #empty
    $exists x (isFunc(x) and continuous(x) and not1 derivable(x))$
= #empty
  关关雎鸠，在河之洲。窈窕淑女，君子好逑。
  #let jj(x) = $"是雎鸠"(x)$
  #let gg(x) = $"正在关关和鸣"(x)$
  #let hz(x) = $"在河之洲"(x)$
  #let yt(x) = $"是窈窕淑女"(x)$
  #let jz(x) = $"是君子"(x)$
  #let hq(x, y) = $"好逑"(x, y)$
  $
  exists x(jj(x) and gg(x) and hz(x))\
  and forall x(yt(x) -> (forall y(jz(y) -> hq(x, y))))\
  $
= #empty
  #let isCar = $"is_car"$
  #let hasFourWheels = $"has_four_wheels"$
  #let isHuman = $"is_human"$
  #let isLazy = $"is_lazy"$
  #let isSilly = $"is_silly"$
  == #empty
    $
    not1 forall x(isCar(x) -> hasFourWheels(x))\
    $
    $
    exists x(isCar(x) and not1 hasFourWheels(x))\
    $
  == #empty
    $
    not1 forall x(isHuman(x) -> not1 (isLazy(x) or isSilly(x)))\
    $
    $
    exists x(isHuman(x) and (isLazy(x) or isSilly(x)))\
    $
= #empty
  == #empty
    这是项，不是公式
  == #empty
    $A_1^3$ 是三元谓词符，此表达式中只有两个项作用在它上面，因此不是公式
= #empty
  #let t1 = $f_1^2 (x_1, x_3)$
  == #empty
     $x_1$ 自由出现一次，#t1 对 $x_2$ 自由，该公式中没有与 $x_1, x_3$ 相关的任意量词
  == #empty
    $x_1$ 约束出现两次，#t1 对 $x_2$ 不自由，因为 $x_2$ 出现在了 $forall x_1$ 的辖域之中。 

= #empty
  （条件保证了 $calA(x_i) -> calA(x_j)$ 的替换不会产生歧义，证明过程中并不会直接用到条件）

  如若不然，假设 $calA(x_j)$ 中含有 $forall x_i (calB'(x_j))$ 其中 $x_j$ 在 $calB'(x_j)$ 中自由出现，按照替换的规则将有：
  - 若其中含有由 $x_i$ 替换得到的 $x_j$，导致 $calA(x_i)$ 中含有 $forall x_i (calB'(x_i))$，但显然这样的 $x_i$ 不是自由出现的，因此不可能进行替换
  - 否则，其中 $x_j$ 都直接来自于 $calA(x_i)$，然而 $calA(x_i)$ 中 $x_j$ 都约束出现，换言之一定处在 $calA(x_i)$ 子公式：
  - $forall x_j (calC (forall x_i (calB(x_j))))$
  之中，而替换不改变 $x_j$，因此在 $calA(x_j)$ 中上两式形如：
  - $forall x_j (calC' (forall x_i (calB'(x_j))))$
  导致 $calB'(x_j)$ 中的 $x_j$ 一定都约束出现，与假设矛盾