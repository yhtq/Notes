#import "../../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
#align(center)[#commutative-diagram(
  node((0, 0), $A$, 1),
  node((0, 1), $B$, 2),
  node((0, 2), $C$, 3),
  node((0, 3), $D$, 4),
  arr(1, 2, $F$, curve: 20deg),
  arr(1, 2, $natTransb alpha$, curve: 20deg, label-pos: right),
  arr(1, 2, $H$, curve: -20deg, label-pos: right),
  arr(2, 3, $G$, curve: 20deg),
  arr(2, 3, $natTransb beta$, label-pos: right, curve: 20deg),
  arr(2, 3, $I$, curve: -20deg, label-pos: right),
  arr(3, 4, $J$, curve: 20deg),
  arr(3, 4, $natTransb gamma$, label-pos: right, curve: 20deg),
  arr(3, 4, $K$, curve: -20deg, label-pos: right),
  
)]
注意到自然变换的垂直合成满足：
$
  (beta compose alpha) X = (beta (H X)) compose (G (alpha X)) 
$
对于任何 $X : A$ 我们有：
$
  (gamma compose (beta compose alpha)) X : J G F X -> K I H X \
  (gamma compose (beta compose alpha)) X
  = (gamma (I H X)) compose (J ((beta compose alpha) X)) \
  = (gamma (I H X)) compose (J (beta (H X))) compose (J (G (alpha X))) \
$
$
  ((gamma compose beta) compose alpha) X
  = ( (gamma compose beta) (H X) ) compose (J G (alpha X)) \
  = (gamma (I H X)) compose (J (beta (H X))) compose (J (G (alpha X))) \
$
因此两者相等，结合性得证。