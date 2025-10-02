#import "../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#import "../main.typ": *
= 9.15
  == 1
    对于所有的 $X, X'$，我们记典范的 $i_1 : X -> X directSum X', i_2 : X' -> X directSum X'$，自然就产生：
    $
      F i_1 : F X -> F (X directSum X')\
      F i_2 : F X' -> F (X directSum X')\
      F i_1 directSum F i_2 : F X directSum F X' -> F (X directSum X')
    $
    注意到，$i_1$（同理 $i_2$）是自然的，这是因为：
    #align(center)[#commutative-diagram(
    node((0, 0), $X$, 1),
    node((0, 1), $X directSum X'$, 2),
    node((1, 0), $Y$, 3),
    node((1, 1), $Y directSum X'$, 4),
    arr(1, 2, $i_1$),
    arr(1, 3, $f$),
    arr(2, 4, $f directSum id$),
    arr(3, 4, $i_1$),)]
    根据直和的定义是显然的。依据函子与自然变换的复合，$F i_1 directSum F i_2$ 对 $X, X'$ 将都是自然的。这就表明我们给出的是一个自然变换。另一方面，考虑：
    $
      id directSum 0 : X directSum X' -> X\
      0 directSum id : X directSum X' -> X'\
      F (id directSum 0) : F (X directSum X') -> F X\
      F (0 directSum id) : F (X directSum X') -> F X'\
      i_1 compose F (id directSum 0) + i_2 compose F (0 directSum id) : F (X directSum X') -> F X directSum F X'
    $
    断言它就是上面构造的映射的逆，这是因为：
    $
      (F i_1 directSum F i_2) compose (i_1 compose F (id directSum 0) + i_2 compose F (0 directSum id))\
      = (F i_1 directSum F i_2) compose i_1 compose F (id directSum 0) + (F i_1 directSum F i_2) compose i_2 compose F (0 directSum id)\
      = F i_1 compose F (id directSum 0) + F i_2 compose F (0 directSum id)\
      = F (i_1 compose (id directSum 0) + i_2 compose (0 directSum id))\
      = F (i_1 directSum 0 + 0 directSum i_2)\
      = F id = id
    $
    另一方面：
    $
      (i_1 compose F (id directSum 0) + i_2 compose F (0 directSum id)) compose (F i_1 directSum F i_2)\
      = i_1 compose F (id directSum 0) compose (F i_1 directSum F i_2) + i_2 compose F (0 directSum id) compose (F i_1 directSum F i_2)\
      = i_1 compose ((F (id directSum 0) compose F i_1) directSum (F (id directSum 0) compose F i_2)) + i_2 compose ((F (0 directSum id) compose F i_1) directSum (F (0 directSum id) compose F i_2))\
      = i_1 compose (id directSum 0) + i_2 compose (0 directSum id)\
      = id
    $
    证毕