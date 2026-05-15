#import "../template.typ": *
#show: note.with(
  title: [研究论文阅读报告],
  author: "郭子荀 2100012990",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false
)
#set text(font: "Times New Roman", size: 12pt)
= Research Paper: Grattan-Guinness, I. (1978). How Bertrand Russell discovered his paradox. Historia Mathematica, 5(2). 
== Structural Analysis
=== Introduction
  Introduction part is quite short for this paper. It claims that, *Bertrand Russell's paradox* or the class of all classes not belonging to themselves, is _best-known results_#footnote[This claim need no support materials since it's basically a common sense for anyone educated] in the history of mathematics(research territory). _But_ the *historical circumstances of its discovery* are not well-known, which will be re-constructed across the paper.
=== Methods
  There is no specific method part in this paper, but the author uses a lot of *historical materials*, including correspondences and publications of mathematicians at that time, to reconstruct the discovery of Russell's paradox. It's a common research pattern for mathematical history research.
=== Results
  This paper shows a clear logic timeline of Russell's paradox:
  #table(columns: 3, [Claim], [Evidence], [Reasoning],
    [ Cantor publish his theorem about cardinality with two proofs. Later, he realized a contradiction, and it gradually circulated in the mathematical community], [Earlier research of the author], [],
    [Russell (in help of many other mathematicians, including Whitehead, Crossley, and Bunn) paid efforts on this contradiction, and finally proposed in the form that is well-known today.], [Available correspondences between Russell and his contemporaries, especially with Hardy with is showed in this paper], [The content of correspondences detailed shows Russell's form of paradox with his doubt about it, in contrast with his confident opinions in other publications.]
  )
=== Discussion
  There is no discussion about this research, but a discussion about the successor of this topic, _how Russell deal with this paradox_. As the author shows and comments, Russell tried to solve the problem by several methods, including type theory, but all of them failed. Actually, none of mathematicians realized the core problem is $italic("Cls")$ is too big to be a class until Zemelo's axiomazation of set theory, which is a more strict version of set theory than the one at that time. 
= Mind Map
  #let block1 = block.with(stroke: 1pt + black, inset: 5pt)
    #import "@preview/commute:0.3.0": *
#align(center)[#commutative-diagram(
node((0, 0), block1[Cantor publish his theorem with two proofs,\ and realized a contradiction which gradully circulated ], 1),
node((0, 1), block1[Whitehead's research on this topic], 2),
node((1, 1), block1[Russell's research on this topic, showed in correspondences], 3),
node((2, 0), block1[Russell's attempts to resolve the paradox], 4),
node((2, 1), block1[The final resolution was proposed by Zermelo], 5),
arr(1, 3, []),
arr(2, 3, [], label-pos: right),
arr(1, 3, $$),
arr(3, 4, $$),
arr(4, 5, $$),
)]
= Knowledge, Insight and Research
  This research paper is quite informative and supported by authentic historical materials. It shows the logic structure of the discovery of Russell's paradox. *However*, there seems to lack a clear exploration and explanation of other important literatures which shows other Russell's opinion on this topic, since it's mentioned but glossed over. But I think it is actually quite important to form a complete understanding of the discovery of Russell's paradox.
= Language Accumulation
  #table(
    columns: 3,
    [Sentence], [Function], [Analysis],
    [_This paper contains a possible re-construction ..._ ], [declare research topic], [use _possible_ to indicate the uncertainty of the research, and _re-construction_ to indicate the method of research],
    [_My purpose now is to present some documentary evidence to support it_], [declare research method to support claim], [use _documentary evidence_ to indicate the type of evidence],

  )

