#import "../../template.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withTitle: true
)
= ABC
= 
  - 短期内：
    #let K = $overline(K)$
    $
    Q = sqrt(#K L) => L = Q^2 / #K\
    C(Q) = r Q^2 / #K + w #K
    $
  - 长期中，固定产量 $Q$，，在条件：
    $
    Q^2 = K L
    $
    下，最优化：
    $
    r L + w K
    $
    易得：
    $
    r L + w K  >= 2sqrt(r w)sqrt(K L) = 2 sqrt(r w)Q\
    r L = w K = sqrt(r w)Q "时取得" 
    $
    因此长期生产函数为：
    $
    C = 2 sqrt(r w)Q
    $
=
  厂商总利润为：
  $
  P Q - C(Q) = P Q - Q C(Q) = P Q - (6000 + 20 Q) = (P - 20)Q - 6000\
  = 50(P - 20)(100 - P) - 6000 <= 50((P - 20 + 100 - P)/2)^2 - 6000\
  = 50*1600 - 6000 = 80000 - 6000 = 74000
  $
  取等处为 $P -20 = 100 - P$，也即 $P = 40, Q = 3000$
=
  注意到恒有：
    $
    "SAC" >= "LAC"
    $
  从而图示意味着三个短期成本函数都已经是可以（在产量恰为短期平均成本函数最低点）达到最优的资本配置。\
  从而短期边际成本只能短暂低于长期边际成本，不能长期低于，否则便会出现长期成本函数上的点没有最优取值。