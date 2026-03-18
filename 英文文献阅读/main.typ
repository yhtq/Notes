#import "../template.typ": *
#show: note.with(
  title: [Problem-Driven Literature Selection & Reading Roadmap],
  author: "郭子荀 2100012990",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false
)
= Research Question
  The famous Russell's paradox greatly influenced mathematician' view of the foundation of mathematics. How Russell firstly proposed this paradox?
= The Literature Pool
  == Search Rabbit: With keyword "Russell's Paradox"
    - Anellis, I. H. (2008). The First Russell Paradox. Birkhäuser Boston eBooks. 
    - Moore, G. (1988). The roots of Russell's paradox. Russell: The Journal of Bertrand Russell Archives. 
    - Link, G. (2004). The Prehistory of Russell’s Paradox. undefined. 
    - *Coffa, J. A. (1979). The humble origins of Russell’s paradox. undefined, 33-34. *
  == References of above literature
    - Crossley, J. (1973). A note on Cantor's theorem and Russell's paradox. Australasian Journal of Philosophy, 51(1). 
    - Moore, G. (1988). The roots of Russell's paradox. Russell: The Journal of Bertrand Russell Archives. 
    - *Grattan-Guinness, I. (1978). How Bertrand Russell discovered his paradox. Historia Mathematica, 5(2). *
= Selection & Rationale
  == Review Article: Coffa, J. A. (1979). The humble origins of Russell’s paradox. undefined, 33-34. 
    Reason:
    - Relatively easy to understand
    - Frequently being cited: #figure(caption: "Citation network")[#image("/assets/image-1.png", height: 200pt)]
  == Research Paper: Grattan-Guinness, I. (1978). How Bertrand Russell discovered his paradox. Historia Mathematica, 5(2).
    Reason:
    - From related influential journal
    - Frequently being cited: #figure(caption: "Citation network")[#image("/assets/image.png", height: 200pt)]
= Reading Roadmap
  #import "@preview/commute:0.3.0": *
#align(center)[#commutative-diagram(
node((0, 0), [Review Paper], 1),
node((0, 1), [Research Paper], 2),
node((1, 0), [Other background information\ (When necessary)], 3),
arr(1, 2, [After basic\ understanding]),
arr(3, 2, $$, bij_str),
arr(1, 3, $$, bij_str),)]
    