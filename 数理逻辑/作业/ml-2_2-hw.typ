#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#show: note.with(
  title: "作业2_1",
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
      nums1.insert(0, 4)
      numbering("1.1.(a)", ..nums1)
    }
)
= #empty
  （本题中 $=$ 均指真值相等）\
  由于替换原理，只需证明公理模式中变量均为元变量时情景即可。
  - $L1 : p_1 -> (p_2 -> p_1)$\
    显然 $p_1 = True$ 时 $p_2 -> p_2 = True$，因此是重言式
  - $L2 : (p_1 -> (p_2 -> p_3)) -> ((p_1 -> p_2) -> (p_1 -> p_3))$\
    $p_1 = False$ 时公式化简为 $True -> (True -> True)$，$p_1 = True$ 时化简为 $(p_2 -> p_3) -> (p_2 -> p_3)$，都是重言式
  - $L3 : (not1 p_1 -> not1 p_2) -> (p_2 -> p_1) $\
    注意到：
    $
    (not1 p_1 -> not1 p_2) -> (p_2 -> p_1) &= (not1 not1 p_1 or not1 p_2) -> (not1 p_2 or p_1) \
    &= (p_1 or not1 p_2) -> (not1 p_2 or p_1) 
    $
    而熟知 $p_1 or not1 p_2 = not1 p_2 or p_1$，因此上式是重言式
= #empty
  == #empty
    #let tL = $tack_L$
    #let tL1 = $tack_(L^+)$
    - 一方面，若 $calA$ 是 $L$ 中定理，则 $tL calB <=> {A} tack_L calB <=> tL1 calB$
    - 另一方面，假设 $calA$ 不是 $L$ 中定理，而它显然是 $L^+$ 中定理，因此定理集不同。
  == #empty
    由于 $L^+$ 只是比 $L$ 增加了公理，定理集扩大是显然的。\
    在 $L$ 中有：
    $
    (not1 p_1 -> p_2) -> (p_1 -> not1 p_2) = (not1 not1 p_1 or p_2) -> (not1 p_1 or not1 p_2) = (p_1 or p_2) -> (not1 p_1 or not1 p_2)
    $
    容易验证它不是永假式，因此 $not1 calA$ 不是重言式，由完全性定理它不是 $L$ 中定理，因此 $L$ 中加入 $not1 not1 calA$ 是一致扩张。熟知 $calA tack not1 not1 calA, not1 not1 calA tack calA$，因此这个扩张等价于 $L^+$，自然 $L^+$ 是一致的。
= #empty  
  显然若 $calB$ 是矛盾，则 $calB models$ 任意公式，由完全性 $calB tL$ 所有公式，这将导致 $tL1$ 所有公式，意味着 $L^+$ 不是一致的。
= #empty
  由于 $J$ 是一致完全扩充，因此 $calA, not1 calA$ 恰有一个是其中定理：
  - 如果 $calA$ 是定理，则加上 $calA$ 的扩张还是本身，当然是一致的
  - 如果 $calA$ 不是定理，则 $not1 calA$ 是定理，将导致扩充后 $calA, not1 calA$ 同时是定理，导致不一致性
= #empty
  #let line = math.hyph.nobreak
  #let lines(n) = $line$ * n
  #let ax(x) = $#x line q #x p line$
  #let implyPre(x, y, z) = $#x  q #y p #z $
  #let imply(x, y, z) = $#x line q #y p #z line$
  取 $x = #lines(1)$，则 $ax(line)$ 是公理模式产生的公理\
  取 $x = #lines(2), y = line, z = line$，则上面说明 $implyPre(#lines(2), line, line)$ 是定理，由推理规则 $imply(#lines(2), line, line)$ 是定理\
  #lemma[][
    系统中定理一定形如 $x q y p z$，其中 $x, y, z$ 都只由 $line$ 构成
  ]<f-lemma>
  #proof[
    - 由公理模式生成的定理显然符合该形式
    - 由推理规则生成的定理显然也符合该形式
    因此所有定理都符合该形式
  ]
  公式是否具有上述形式是容易判定的，不符合该形式的公式一定不是定理，因此下面只讨论符合该形式的公式。\
  #definition[][
    - 定义所有符合 @f-lemma 的公式集为 $cal(F)$，定理集为 $cal(T)$
    - 若 $x$ 是只由 #line 组成的公式，定义 $n(x)$ 为其中 #line 的数量，显然若 $x, y$ 都是这样的公式则 $x = y <=> n(x) = n(y)$
    - 定义：
      $
      funcDef(v, cal(F), NN^3, x q y p z, (n(x), n(y), n(z)))
      $
      @f-lemma 保证了定义合理，同时显然有 $v(x) = v(y) <=> x = y$
  ]
  #lemma()[][
    设 $calA in cal(F)$，则 $calA in cal(T) <=> v(calA) in v(cal(T))$
  ]<completeness>
  #proof[
    前面已经说明 $v$ 是单射，做简单的集合逻辑运算即可。
  ]
  #proposition[][
    - $calA$ 是公理模式生成的公理当且仅当 $exists n, v(calA) = (n+1, n, 1)$
    - 设 $calA$ 是定理且 $n(calA) = (r, s, t)$，则由推理规则生成的定理 $calB$ 满足 $(r+1, s, t+1)$
    - $v(cal(T)) + (1, 0, 1) subset v(cal(T))$
  ]
  #proof[
    - 若 $calA$ 是公理模式生成的公理，则取 $n = n(x)$ 即可。反之，取 $x = n$ 个 #line 即可
    - 显然
    - 任取 $v(calA) in v(cal(T)) <=> calA in cal(T)$，则 $calA$ 利用推理规则生成的定理 $calB in cal(T)$ 恰好满足 $v(calB) = v(calA) + (1, 0, 1)$，因此 $v(calA) + (1, 0, 1) in v(cal(T))$，得证
  ]
  #theorem[][
    定义:
    $
    funcDef(p, NN^3, NN^3, (a\, b\, c), (a+1\, b\, c+1))\
    funcDef(f, P(NN^3), P(NN^3), S, S union p(S))\
    $
    并设 $S_0 = {(n+1, n, 1) | n in NN}$，则有：
    $
    v(cal(T)) = union_(n in NN) f^n (S_0)
    $
    更进一步，它等于 $union_(n in NN) f^n ({(m + 1, m , 1) | m in NN}) = {(m + n + 1, m, n + 1) | m, n in NN}$
  ]<semantics>
  #proof[
    由形式系统的定义及上面的命题，$v(cal(T))$ 就是 $S_0$ 在 $f$ 作用下的闭包，当然具有上面的形式。之后的计算是容易的。
  ]
  @semantics 结合 @completeness 即可得到定理的判定方法。在 @semantics 给出的语义下，它是完全的，但并不完全是加法，因为从 @semantics 可以看出 $0 + 0$ 并不能在此语言中被表达。换言之，若以自然数加法为语义则它具有 soundness ，但不具有 completeness 。