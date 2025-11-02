#import "../../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
= 第六次作业
  #proposition[][
    设 $AdjoinPair(F, G)$ 是双伴随对，且 $eta_(F G), eta_(G F)$ 都是同构，则 $F, G$ 是范畴等价。
  ]
  #proof[
    根据定义，就是有自然同构 $eta_(F G) : 1 eqv F G, eta_(G F) : 1 eqv G F$，取逆即是范畴间的等价。
  ]
      #lemma[][
        Abel 范畴中，既单又满的态射是同构
      ]
      #proof[
        设 $f$ 既是单射又是满射，则一定存在：
        #align(center)[#commutative-diagram(
        node((0, 0), $A$, 1),
        node((0, 1), $B$, 2),
        node((0, -1), $H$, 3),
        node((0, 2), $K$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coker f$, 6),
        arr(1, 2, $f$),
        arr(3, 1, $alpha$),
        arr(2, 4, $beta$),
        arr(5, 1, $$),
        arr(2, 6, $$),
        )]
        使得 $ker beta = A, coker alpha = B$，显然 $f alpha = 0, beta f = 0$，立刻有：
        #align(center)[#commutative-diagram(
        node((0, 0), $A = ker beta$, 1),
        node((0, 1), $B = coker alpha$, 2),
        node((0, -1), $H$, 3),
        node((0, 2), $K$, 4),
        node((1, -1), $ker f$, 5),
        node((1, 2), $coker f$, 6),
        node((1, 0), $coim f$, 7),
        node((1, 1), $im f$, 8),
          arr(1, 2, $f$),
          arr(3, 1, $alpha$),
          arr(2, 4, $beta$),
          arr(5, 1, $$),
          arr(2, 6, $$),
          arr(1, 7, $$),
          arr(8, 2, $$),
          arr(7, 8, $$),
          arr(3, 5, $exists$, dashed_str),
          arr(6, 4, $exists$, dashed_str),
        )]
        进而：
        $
          beta compose (im f -> B) = im f -> B -> coker f -> K = 0
        $
        同理 $(A -> coim f) compose alpha = 0$，就有：
        #align(center)[#commutative-diagram(
        node((0, 0), $A = ker beta$, 1),
        node((0, 1), $B = coker alpha$, 2),
        node((0, -1), $H$, 3),
        node((0, 2), $K$, 4),
        node((1, -1), $ker f$, 5),
        node((1, 2), $coker f$, 6),
        node((1, 0), $coim f$, 7),
        node((1, 1), $im f$, 8),
          arr(1, 2, $f$),
          arr(3, 1, $alpha$),
          arr(2, 4, $beta$),
          arr(5, 1, $$),
          arr(2, 6, $$),
          arr(1, 7, $$),
          arr(8, 2, $$),
          arr(7, 8, $$),
          arr(3, 5, $exists$, dashed_str),
          arr(6, 4, $exists$, dashed_str),
          arr(8, 1, $$, dashed_str),
          arr(2, 7, $$, dashed_str),
        )]
        其中：
        $
          im f -> A -> coim f -> im f  -> B\
          = im f -> A -> B\
          = im f -> B
        $
        因为 $im f -> B$ 是单的，就有：
        $
          im f -> A -> coim f = id
        $
        因此上面的图表确实全部交换，进而 $B -> coim f -> im f -> A$ 就是 $f$ 的一个逆。
      ]
      #proposition()[][
        Abel 范畴中，$coim -> im$ 的态射是同构
      ]
      #proof[
        在之前的构造中有：
        #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$)
        )] 
        继而：：
                #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        node((2, 2), $coker rho$, 9),
        node((2, 1), $im rho$, 10),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$),
        arr(7, 9, $$),
        arr(10, 7, $$),
        arr(2, 10, $exists$, curve: 30deg, dashed_str),
        )] 
        其中 $X -> im rho$ 来自于 $(im f -> coker rho) compose rho = 0$，由于 $im rho -> im f -> X'$ 是单的，设它是一个核映射，也即：
        #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $H$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        node((2, 2), $coker rho$, 9),
        node((2, 1), $im rho = ker k$, 10),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$),
        arr(7, 9, $$),
        arr(10, 7, $$),
        arr(2, 10, $$, curve: 30deg),
        arr(3, 4, $k$)
        )] 
        注意到 $k compose f$ = $k compose (X -> ker k -> X') = 0$，立刻就有：
        #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $H$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        node((2, 2), $coker rho$, 9),
        node((2, 1), $im rho = ker k$, 10),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(8, 4, $exists! phi$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$),
        arr(7, 9, $$),
        arr(10, 7, $$),
        arr(2, 10, $$, curve: 30deg),
        arr(3, 4, $k$)
        )] 
        进而：
        $
          k compose (im f -> X') = im f -> X' -> coker f -> H = 0
        $
        根据 $ker k$ 的性质，就有：
        #align(center)[#commutative-diagram(
        node((0, 0), $$, 1),
        node((0, 1), $X$, 2),
        node((0, 2), $X'$, 3),
        node((0, 3), $H$, 4),
        node((1, 0), $ker f$, 5),
        node((1, 1), $coim f$, 6),
        node((1, 2), $im f$, 7),
        node((1, 3), $coker f$, 8),
        node((2, 2), $coker rho$, 9),
        node((2, 1), $im rho = ker k$, 10),
        arr(2, 3, $f$),
        arr(2, 7, $exists! rho$, dashed_str),
        arr(8, 4, $exists! phi$, dashed_str),
        arr(2, 6, $$),
        arr(7, 3, $$),
        arr(5, 2, $$),
        arr(3, 8, $$),
        arr(7, 9, $$),
        arr(10, 7, $$),
        arr(2, 10, $$, curve: 30deg),
        arr(3, 4, $k$),
        arr(7, 10, $exists !psi$, curve: 15deg, dashed_str)
        )]
        同时由 $psi$ 的定义得：
        $
          (im f -> X) compose (ker k -> im f) compose psi \
          = im f -> X 
        $ 
        注意到 $im f -> X$ 是单的，上式就是说：
        $
          (ker k -> im f) compose psi = id
        $
        也就是 $ker k -> im f$ 是同构。而：
        $
          im rho -> im f -> coker rho = 0
        $
        因此：
        $
          im f -> coker rho = 0
        $
        而它是满的，因此 $coker rho = 0$，不难证明此时必有 $rho$ 是满射。

        回顾构造过程，这表明 $coim f -> im f$ 是满射。类似的，可以证明它是单射。根据引理，它是一个同构，证毕。
      ]