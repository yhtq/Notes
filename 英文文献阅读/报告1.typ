#import "../template.typ": *
#show: note.with(
  title: [文献综述文章阅读报告],
  author: "郭子荀 2100012990",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false
)
#set text(font: "Times New Roman", size: 12pt)
= Review Article: Coffa, J. A. (1979). The humble origins of Russell’s paradox. undefined, 33-34. 
== Structural Analysis
=== Introduction
In this article, the author gives a detailed view of the discovery of Russell's paradox, i.e., the class of all classes not belonging to themselves#footnote[
  Using modern mathematical terminology, we can say that Russell's paradox means that there not exists a set which contains all sets.
]. It is claimed that, with more relative information gradually revealed, this article purposes to complement and correct the outdated understanding of the discovery of Russell's paradox. Traditionally, it is believed that Russell applied the idea in Cantor's theorem. However, literatures tend to support the view that Russell discovered his paradox just during his effort to deny Cantor's theorem.
=== Conclusion
Although the main idea of Russell's paradox appeared in several places, it is still not clear when Russell realized his construction not only refuted Cantor's theorem but also refuted common-accepted assumptions in set theory. Future discovery and research on Russell's archive may lead to a more specific conclusion. 
== Body
  The body part is organized logically. The first three paragraphs lists materials that contains Russell's criticism of Cantor's theorem. The following two paragraphs are about the argument of Cantor's second proof. The last two paragraphs conclude the final phase where Russell realize the second argument actually refutes his first argument, hence Cantor's idea could be irrefutable, supported by several Russell's short notes.
= Mind Map
  #let block1 = block.with(stroke: 1pt + black, inset: 5pt)
    #import "@preview/commute:0.3.0": *
#align(center)[#commutative-diagram(
node((0, 0), block1[Attempt to refute Cantor's theorem], 1),
node((0, 1), block1[first proof: \ greatest cardinal should exists], 2),
node((1, 1), block1[second proof: \ Cantor presupposes not all subclasses of a set \ belong to it], 3),
node((2, 0), block1[final result: Russell's paradox], 4),
arr(1, 2, []),
arr(3, 2, block1[Russell realized it also\ contradicts previous \ argument], label-pos: right),
arr(1, 3, $$),
arr(2, 4, $$),
)]
= Knowledge
  - Purpose: Understand the discovery of Russell's paradox
  - Core Concepts:
    - Russell's paradox: the class of all classes not belonging to themselves
    - Cantor's theorem: the cardinality of the power set of a set is strictly greater than the cardinality of the set itself ($abs(2^S) > abs(S)$)
    - Russell's first argument: the greatest cardinal should exist, which is a contradiction to Cantor's theorem
    - Russell's second argument: Cantor's proof procedure is impossible, since it leads to a contradiction like $D in f(D) and D in.not f(D)$. Later, Russell and other mathematicians realized this contradiction is not produced by Cantor's proof procedure, but by the internal inconsistency of set logic at that time.
#show emph: it => {
  text(style: "italic", it.body)
}
= Language Accumulation
  #table(
    columns: 3,
    [Sentence], [Function], [Analysis],
    [_One of the earliest remarks to that effect occurs in ..._ ], [pointing out history], [using words like _One of_ and _occurs_ to indicate the time of the event],
    [_The picture that emerges almost immediately from Russell's observation is the following_ ], [summarizing the main idea], [_picture_ means the main idea, _emerges_ means the main idea is revealed],
    [_For reasons which are never made clear_ ], [explaining restrictions of current knowledge], [using words like _For reasons_ and _never made clear_ to indicate the lack of information],
    [_The answers to these questions lie, if anywhere, in some other corner of the Russel Archives_ ], [explaining restrictions of current knowledge], [using _if anywhere_ to show respect to the difficulty of the problem, and _some other corner_ to indicate the possibility of future discovery],
  )
= Paper Pool
  - Blackwell, K [unpublished] The text of Russell's 'Principles  of mathematics': The original text of Russell's ideas and notes, which is the most direct evidence to understand the discovery of Russell's paradox.
  - Cantor, G 1874 Uber eine Eigenschaft des Inbegriffes aller  reellen algebraischen Zahlen J. rei. ang. Math. 77, 258262; Original text which contains Cantor's proof of his theorem, as historical background of Russell's paradox
= Inspiration 
  Most circulated documents talk about Russell's paradox without mentioning Cantor's theorem about cardinality. Actually, Cantor's theorem is just an easy fact in any set theory course, and it indeed directly leads to Russell's paradox. It's doubtful that, why Cantor's theorem is easy to understand and more powerful(as logical proposition) than Russell's paradox, but it is far less mentioned and people tend to credit to Russell. 
  
  This paper answers this question. Although Cantor's theorem is indeed purposed earlier, Cantor himself never realized its destructive power to the foundation of mathematics, and Russell's finally realized this point. Therefore, Russell's paradox is more influential and more frequently mentioned than Cantor's theorem.
