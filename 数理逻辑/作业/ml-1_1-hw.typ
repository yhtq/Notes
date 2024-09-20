#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": not1, True, False, infer
#import "../main.typ": *
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
= 1
  == 1.1
    === (a)
      令：
      $
      A = "需求不变"\
      B = "价格上升"\
      C = "营业额下降"
      $
      则命题变为：
      $
      (A and B) -> C
      $
    === (b)
      令：
      $
      A = x "是有理数"\
      B = y "是整数"\
      C = z "不是实数"
      $
      则命题变成：
      $
      A -> (B -> C)
      $
  == 1.2
    #let or1 = $or'$ 
    用 $or1$ 表示通常的与运算，则：
    
    #table(
      columns: 6,
      align: horizon,
      table.header(
        $A$, $B$, $A or B$, $A and B$, $(A or B) or (A and B)$, $A or1 B$
      ),
      T, T, F, T, T, T,
      T, F, T, F, T, T,
      F, T, T, F, T, T,
      F, F, F, F, F, F
    )
    
    表明 $(A or B) or (A and B) = A or1 B$
  == 1.3
    === (a)
        #table(
          columns: 13,
          $(p$, infer, $(q$, infer, $r))$, infer, $((p$, infer, $q)$, infer, $(p$, infer, $r))$, 
          T, T, T, T, T, T, T, T, T, T, T, T, T,
          T, F, T, F, F, T, T, T, T, F, T, F, F, 
          T, T, F, T, T, T, T, F, T, T, T, T, T,
          F, T, T, T, T, T, F, T, T, T, F, T, T,
          T, F, F, T, F, T, T, F, F, T, T, F, F,
          F, T, T, F, F, T, F, T, T, T, F, T, F,
          F, T, F, T, T, T, F, T, F, T, F, T, T,
          F, T, F, T, F, T, F, T, F, T, F, T, F

        )
    === (b)
      #table(
          columns: 5,
          align: center,
          p, q, r, $(not1 p -> q or r)$, $(not1 q -> (not1 r -> p))$,
          T, T, T, T, T,
          T, T, F, T, T,
          T, F, T, T, T,
          F, T, T, T, T,
          T, F, F, T, T,
          F, T, F, T, T,
          F, F, T, T, T,
          F, F, F, F, F
        )
        易知它们有相同的真值函数
  == 1.4
    === (a)
      是重言式：
      #table(
        columns: 4,
        q, r, $q or r$, $not1 r -> q$,
        T, T, T, T,
        T, F, T, T,
        F, T, T, T,
        F, F, F, F
      )
    === (b)
      不是重言式，当 $p = F, r = T$ 时，前件为真，后件为假
  == 1.5
    === (a)
      #table(
        columns: 4,
        q, r, $q or r$, $not1 r -> q$,
        T, T, T, T,
        T, F, T, T,
        F, T, T, T,
        F, F, F, F
      )
      可见它们有相同的真值函数，故等价
    === (b)
      #table(
        columns: 5,
        p, q, r, $(p or q) and r$, $(p and r) or (q and r)$,
        T, T, T, T, T,
        T, T, F, F, F,
        T, F, T, T, T,
        F, T, T, T, T,
        T, F, F, F, F,
        F, T, F, F, F,
        F, F, T, F, F,
        F, F, F, F, F
      )
      可见它们有相同的真值函数，故等价
  == 1.6
    === (a)
      取 $p = #T, q = #T$，则 $not1 p -> q$ 为真，$p -> not1 q$ 为假，从而原式为假
    === (b)
      取 $calA = (p <-> p), calB = (p <-> p)$ 即可，既然它们都是重言式，值恒为真，因此由上面的推理知原式恒为假，是矛盾式
  == 1.7
    === (a)
      设 $X = {A "是集合" | A in.not A}$，则：
      - 若 $X in X$，则应该有 $X in.not X$，矛盾
      - 若 $X in.not X$，则应该有 $X in X$，矛盾
    === (b)
      我们设 $A_i$ 是第 $i$ 天这个时候说出的命题，则其定义“我明天这个时候说的这句话是假的”可以写作：
      $
      A_i := not1 A_(i+1), i in NN
      $
      若我们承认这一系列定义合法，则若 $A_0$ 为真，则 $A_1$ 为假，$A_2$ 为真...... 并不构成矛盾。然而也可以认为对于任何一个 $i$，其定义的形式都是无法终止的递归定义，因此不能被合法地定义为命题。


