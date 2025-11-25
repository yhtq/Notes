#import "../../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
=
  ==
    // #align(center)[#commutative-diagram(
    // node((0, 1), $A$, 1),
    // node((0, 2), $B$, 2),
    // node((0, 3), $C$, 3),
    // node((0, 4), $0$, 4),
    // node((1, 0), $0$, 5),
    // node((1, 1), $A'$, 6),
    // node((1, 2), $B'$, 7),
    // node((1, 3), $C'$, 8),
    // arr(1, 2, $$),
    // arr(2, 3, $$),
    // arr(3, 4, $$),
    // arr(5, 6, $$),
    // arr(6, 7, $$),
    // arr(7, 8, $$),
    // arr(1, 6, $$),
    // arr(2, 7, $$),
    // arr(3, 8, $$),
    // )]
    #lemma[][

    #align(center)[#commutative-diagram(
    node((0, 0), $ker (A -> C)$, 1),
    node((0, 1), $A$, 2),
    node((1, 0), $ker (B -> C)$, 3),
    node((1, 1), $B$, 4),
    node((1, 2), $C$, 5),
    arr(1, 2, $$),
    arr(1, 3, $$),
    arr(2, 4, $$, inj_str),
    arr(3, 4, $$),
    arr(4, 5, $$),
    )]
    的左侧是一个拉回图表。这是因为 $ker (A -> C) = A times_C 0 = A times_C (B times_C 0) = A times_C ker (B -> C)$，在上图中，就是说 $ker g$ 是 $ker (B -> C), ker (B -> B')$ 关于 $B$ 的拉回。
    ]
    #align(center)[#commutative-diagram(
    node((0, 1), $A$, 1),
    node((0, 2), $B$, 2),
    node((0, 3), $C$, 3),
    node((0, 4), $0$, 4),
    node((1, 0), $0$, 5),
    node((1, 1), $A'$, 6),
    node((1, 2), $B'$, 7),
    node((2, 2), $im (A' -> B') = ker(B' -> C')$, 11),
    node((1, 3), $C'$, 8),
    node((-1, 3), $ker (C -> C')$, 9),
    node((2, 1), $coker (A -> A')$, 10),
    node((-1, 2), $ker (B -> C')$, 12),
    arr(1, 2, $$),
    arr(2, 3, $$),
    arr(3, 4, $$),
    arr(5, 6, $$),
    arr(6, 7, $$),
    arr(7, 8, $$),
    arr(1, 6, $$),
    arr(2, 7, $$),
    arr(3, 8, $$),
    arr(9, 3, $$),
    arr(6, 10, $$),
    arr(11, 7, $$),
    arr(6, 11, $$, bij_str),
    arr(12, 2, $$),
    arr(12, 11, $exists$, dashed_str, curve: 20deg),
    arr(12, 9, $phi$),
    arr(1, 12, $$)
    )]
    其中 $ker (B -> C') -> ker (B' -> C')$ 来自于 $ker (B -> C') -> B' -> C' = 0$

    由引理，$ker (B -> C')$ 恰好是 $ker (C -> C'), B$ 的拉回，因此：
    - $phi$ 是满的
    - $ker phi = ker (B -> C) = A$
    
    因此，$ker (C -> C') = im phi = coim phi$，而：
    $
      A -> ker (B -> C') -> coker (A -> A') = 0
    $
    根据 $coim$ 定义立刻得到 $ker (C -> C') -> coker (A -> A')$
  == 
    首先，证明：
    $
      ker (A -> A') ->^f ker (B -> B') ->^g ker (C -> C')
    $
    正合：
      #align(center)[#commutative-diagram(
      node((0, 0), $ker (A -> A')$, 1),
      node((0, 1), $ker (B -> B')$, 2),
      node((0, 2), $ker (C -> C')$, 3),
      node((1, 0), $A$, 4),
      node((1, 1), $B$, 5),
      node((1, 2), $C$, 6),
      node((2, 0), $im (A -> B) = ker (B -> C)$, 7),
      node((-1, 1), $ker g = ker (ker (B -> B') -> C)$, 8),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(4, 5, $$),
      arr(5, 6, $$),
      arr(1, 4, $$),
      arr(2, 5, $$),
      arr(3, 6, $$),
      arr(4, 7, $$),
      arr(7, 5, $$),
      arr(8, 2, $$),
      arr(8, 7, $$)
      
      )]
    只需证明：
    #align(center)[#commutative-diagram(
    node((0, 0), $im f$, 1),
    node((0, 1), $ker (B -> B')$, 2),
    node((1, 0), $im (A -> B)$, 3),
    node((1, 1), $B$, 4),
    arr(1, 2, $$),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $$),)]
    也是拉回即可。而：
    $
      im f = ker (ker (B -> B') -> coker f)\
      im (A -> B) = ker (B -> C)
    $
    根据 $(ker (B -> B') -> B -> C) compose f = 0$，自然得到 $coker f -> C$，可以验证它是单的//TODO
    ，继而 $ker (ker (B -> B') -> coker f) = ker (ker (B -> B') -> C)$，根据上面的引理得到 $im f$ 也是拉回，继而 $im f = ker (A -> C)$

    其次，连接处需要验证：
    $
      im (ker (B -> B') -> ker (C -> C')) = ker (ker (C -> C') -> coker (A -> A'))
    $
    计算 $(ker (C -> C') -> coker (A -> A')) compose (ker (B -> B') -> ker (C -> C')) = 0$ 是容易的，而设 $phi(b) in ker (C -> C')$，连接映射将 $phi(b)$ 映为
    $(Inv(A' -> B')) (B -> B') b + A$
    若其为零，就有：
    $
      (B -> B') b in im (A -> B')
    $
    也即可设：
    $
      (B -> B') b = (A -> B') a\
      (B -> B') (b - (A -> B) a) = 0\
      b - (A -> B) a in ker (B -> B')
    $
    并且显然 $(ker (B -> B') -> ker (C -> C')) (b - (A -> B) a) = phi(b)$，这就表明 $ker (ker (C -> C') -> coker (A -> A')) subset im (ker (B -> B') -> ker (C -> C'))$
  == 
    注意到：
    $
      A'_n -> A'_n quo (im d'_(n + 1)) -> ker d'_(n - 1) -> ker d_(n - 1) = A'_n -> ker d_(n - 1)\
      A'_n -> A'_n quo (im d'_(n + 1)) -> A_n quo (im d_(n + 1)) -> ker d_(n - 1) = A'_n -> A_n -> A_n quo (im d_(n + 1)) -> ker d_(n - 1) 
      \ = A'_n -> ker d_(n - 1) 
    $
    因此图表交换。两行正合上一小题已经证明。
  == 
    在上一小题中，事实上：
    $
      ker d = ker ((A_n quo (im d_(n + 1))) -> ker d_(n - 1)) = (ker d_n) quo (im d_(n + 1)) = H_n (A)\
      coker d = coker ((A_n quo (im d_(n + 1))) -> ker d_(n - 1)) = (ker d_(n - 1)) quo (im d_n) = H_(n - 1) (A)
    $
    类似的对 $A', A''$ 也成立，因此使用蛇引理立刻得到短正合列诱导的长正合列。
    // #align(center)[#commutative-diagram(
    // node((0, 0), $ker (B -> C')$, 1),
    // node((0, 1), $ker (B' -> C')$, 2),
    // node((1, 0), $ker (C -> C')$, 3),
    // node((1, 1), $coker (A -> A')$, 4),
    // arr(1, 2, $$),
    // arr(1, 3, $$),
    // arr(2, 4, $$),
    // arr(3, 4, $$),)]

    // #align(center)[#commutative-diagram(
    // node((0, 0), $ker (ker (B -> C') -> coker (A -> A'))$, 1),
    // node((0, 1), $ker (B -> C')$, 2),
    // node((1, 0), $ker delta$, 3),
    // node((1, 1), $ker (C -> C')$, 4),
    // arr(1, 2, $$, inj_str),
    // arr(1, 3, $$, surj_str),
    // arr(2, 4, $$),
    // arr(3, 4, $$, inj_str),)]

    // 以及：
    // #align(center)[#commutative-diagram(
    // node((0, 0), $ker (ker (B -> C') -> coker (A -> A'))$, 1),
    // node((0, 1), $ker (B -> C')$, 2),
    // node((1, 0), $im (A -> A')$, 3),
    // node((1, 1), $ker (B' -> C')$, 4),
    // arr(1, 2, $$),
    // arr(1, 3, $$),
    // arr(2, 4, $$),
    // arr(3, 4, $$),)]

    // #align(center)[#commutative-diagram(
    // node((0, 0), $S'$, 1),
    // node((0, 1), $ker (ker (B -> B') -> ker (C -> C'))$, 2),
    // node((1, 0), $ker (B -> B')$, 3),
    // node((1, 1), $ker (C -> C')$, 4),
    // node((2, 1), $coker (A -> A')$, 5),
    // arr(1, 2, $$),
    // arr(1, 3, $$),
    // arr(2, 4, $$),
    // arr(3, 4, $$),
    // arr(4, 5, $$)
    
    // )]
