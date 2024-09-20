#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
#import "@preview/prooftrees:0.1.0": axi, uni, tree
#show: note.with(
  title: "作业12",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let p = $p$
#let q = $q$
#let r = $r$
#let T = True
#let F = False
#let U = TODO
#let tree(A, B) = $#A\; therefore#B$
= 2
  == 2.1
    === (a)
      $
      p <-> q = (p -> q) and (q -> p) = (not1 p or q) and (not1 q or p)
      $
      这已经是合取范式，其析取范式为：
      $
      (not1 p or q) and (not1 q or p) = 
      (not1 p and not1 q) or (not1 p and p) or (q and not1 q) or (q and p) 
      $
    === (b)
      $
      not1 ((p -> not1 q) -> r) = not1 ((not1 p or not1 q) -> r) = not1 (not1 (not1 p or not1 q) or r) = not1 ((p and q) or r)\
      = ((not1 p) or (not1 q)) and (not1 r)
      $
      这已经是合取范式，其析取范式为：
      $
      ((not1 p) or (not1 q)) and (not1 r) = (not1 p and not1 r) or (not1 q and not1 r)
      $
  == 2.2
    === (a)
      $
      (not1 p and not1 q) -> (not1 r and s) = not1 (not1 p and not1 q) or (not1 r and s) = (p or q) or (not1 r and s) \
      = 
      (p or q) or (not1 not1 (not1 r and s) )= (p or q) or (not1 (r or not1 s))
      $
    === (b)
      注意到：
      $
      calA <-> calB = (calA -> calB) and (calB -> calA) \
      = (not1 calA or calB) and (not1 calB or calA) = (not1 (calA and not1 calB)) and (not1 (calB and not1 calA)) \
      $
      做替换得：
      $
      (p <-> (not1 q)) <-> r = (not1 (p and not1 (not1 q))) and (not1 ((not1 q) and not1 p)) <-> r \
      = (not1 ((not1 (p and not1 (not1 q))) and (not1 ((not1 q) and not1 p)) and not1 r)) \
       and (not1 (r and not1 (not1 (p and not1 (not1 q))) and (not1 ((not1 q) and not1 p))))\
      = (not1 ((not1 (p and q)) and (not1 ((not1 q) and not1 p)) and not1 r)) and (not1 (r and p and q) and (not1 ((not1 q) and not1 p)))
      $
    === (c)
      注意到：
      $
      calA and calB = not1 (not1 calA or not1 calB) = not1 (calA infer not1 calB)\
      calA or calB = (not1 calA) infer calB
      $
      因此：
      $
      (p and q) or (r and s) = (not1 (p infer not1 q)) or (not1 (r infer not1 s))\
      = (not1 (not1 (p infer not1 q))) infer (not1 (r infer not1 s))\
      = (p infer not1 q) infer (not1 (r infer not1 s))
      $
  == 2.3
    #lemmaLinear[][
      设 $calA$ 是由 $p_1, p_2, ..., p_n;q$ 变元和连接符集 $S$ 构成的命题形式，且其真值函数 $f$ 与 $q$ 的真假值无关，则存在 $calB$ 是由 $p_1, p_2, ..., p_n$ 变元和连接符集 $S$ 构成的命题形式，使得 $calA$ 与 $calB$ 等值
    ]
    #proof[
      考虑 $subst(calA, q, p_1)$，不难验证它与 $calA$ 等值且不含变元 $q$
    ]
    上面引理说明了增加变元个数不会增加更多可表达的真值函数，因此下设命题形式只含两个变元
    #lemmaLinear[][
      设 $calA$ 是任意由 $p, q$ 变元与 ${not1, <->}$ 构成的命题形式，则 $calA$ 的真值表中必有偶数个 #T（对称的，偶数个 #F）
    ]
    #proof[
      对 $calA$ 做结构化归纳法：
      - $calA = p, q$ 结论显然
      - $calA = not1 calB$，由归纳假设 $calB$ 的真值表中有偶数个 #F, #T，从而 $calA$ 的真值表中有偶数个 #T, #F
      - $calA = calB <-> calC$，设：
        #let bti = "bool_to_int"
        $
        bti : {T, F} &-> ZZ quo 2ZZ\
        bti(T) &= 1\
        bti(F) &= 0
        $
        并简记 $calA, calB, calC$ 的真值函数为 $calA, calB, calC$ ，则待证命题表达为：
        $
        sum_((i, j) in {T, F}^2) bti(calA(i, j)) = 0
        $
        由归纳假设：
        $
        sum_((i, j) in {T, F}^2) bti(calB(i, j)) = 0\
        sum_((i, j) in {T, F}^2) bti(calC(i, j)) = 0
        $
        同时不难验证：
        $
        forall p in {T, F}^2, bti((calB <-> calC) (p)) = bti(calB(p)) - bti(calC(p)) + 1
        $
        因此：
        $
        & sum_((i, j) in {T, F}^2) bti(calA(i, j)) \
        &= sum_((i, j) in {T, F}^2) bti((calB <-> calC) (p))\
        &= sum_((i, j) in {T, F}^2) bti(calB(p)) - bti(calC(p)) + 1\
        &= sum_((i, j) in {T, F}^2) bti(calB(p)) - sum_((i, j) in {T, F}^2) bti(calC(p)) \
        &= 0 - 0 \
        &= 0  \
        $
        命题得证

    ]
    显然，上面的引理蕴含了不存在这样的 $calA$ 与 $p and q$ 等值，因此 ${not1, <->}$ 不是完备集
  == 2.4
    === (a)
      设：
      - $p = "函数" f "连续"$ 
      - $q = "函数" g "可微"$
      则推理形式为：
      #tree(
          [$not1 p -> not1 q, q$],
          [$q$]
      )
      这是有效的，既然:
      #tree(
          [$not1 p -> not1 q, q$],
          [$q -> p, q$]
      )
      #tree(
          [$q -> p, q$],
          [$p$]
      )
      都是有效形式
    === (b)
      设：
      - $p =$ $U$ 是 $V$ 的子集
      - $q =$ $U$ 是闭的
      - $r = $ $U$ 包含零向量
      - $s = $ $U$ 是 $V$ 的子空间
      则推理形式为：
      #tree(
          [$s -> (p and q and r), p and (q -> r)$],
          [$q -> s$]
      ) 
      这不是有效的，因为可取 $s = F, p, q, r = T$，条件均真但结论为假
= 2.5
  #let calLn = $calA_1,calA_2, ..., calA_n$ 
  #let calLn1 = $calA_1,calA_2, ..., calA_(n-1)$ 
  对于任意一组使得 #calLn 全为真的真值指派，
  由于：
  $
  #tree(calLn, calA )
  $
  是有效的，因此在此指派下 #calA 也为真

  对于任意一组使得 #calLn1 全为真的真值指派：
  - 若 $calA_n$ 为真，则符合上面的条件，自然 $calA$ 也为真，$calA_n -> calA$ 为真
  - 否则，$calA_n$ 为假，$calA_n -> calA$ 自然为真
  这就表明 #tree(calLn1, $calA$) 是有效的
  