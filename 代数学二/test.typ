#import "../template.typ": proof, note, corollary, lemma, theorem,  proposition, definition, example, remark, der, partialDer, AModule, Mod, incrementSign, inj_str, surj_str, bij_str, def_str, nat_str, tensorProduct, directSum
#import "../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "代数学二",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 
  ==
    #definition[][
      11111
    ]
    #definition[][
      22222
    ]
    #proposition[][
      #align(center)[#commutative-diagram(
      node((0, 0), $$, 1),
      node((0, 1), $$, 2),
      node((1, 0), $$, 3),
      arr(1, 2, $$),
      arr(3, 2, $$),
      arr(1, 3, $$),)]
    ]
    #proposition[][
      #align(center)[#commutative-diagram(
      node((0, 0), $$, 1),
      node((0, 1), $$, 2),
      node((0, 2), $$, 3),
      node((0, 3), $$, 4),
      node((1, 0), $$, 5),
      node((1, 1), $$, 6),
      node((1, 2), $$, 7),
      node((1, 3), $$, 8),
      arr(1, 2, $$),
      arr(2, 3, $$),
      arr(3, 4, $$),
      arr(5, 6, $$),
      arr(6, 7, $$),
      arr(7, 8, $$),
      arr(1, 5, $$),
      arr(2, 6, $$),
      arr(3, 7, $$),
      arr(4, 8, $$),)]
    ]
    #proposition[][]
    #align(center)[#commutative-diagram(
    node((0, 0), $$, 1),
    node((0, 1), $$, 2),
    node((0, 2), $$, 3),
    node((0, 3), $$, 4),
    node((1, 0), $tensorProduct tensorProduct$, 5),
    node((1, 1), $$, 6),
    node((1, 2), $$, 7),
    node((1, 3), $$, 8),
    arr(1, 2, $$),
    arr(2, 3, $$),
    arr(3, 4, $$),
    arr(5, 6, $$),
    arr(6, 7, $$),
    arr(7, 8, $$),
    arr(1, 5, $$),
    arr(2, 6, $$),
    arr(3, 7, $$),
    arr(4, 8, $$),)]