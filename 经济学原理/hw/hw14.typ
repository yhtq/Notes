#import "../../template.typ": *
#show: note.with(
  title: "作业14",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withTitle: true
)
= D
  没有产生未被价格衡量的影响
= C
= A
  既竞争也排他
= A
  保险商家若无法分辨投保人健康风险，则会导致健康风险较高者更多投保导致保险崩溃
=
  ==
    由交易的有效性
    $
    1/(p_y) partialDer(U_i, y) = 1/(p_x) partialDer(U_i, x) <=> 1/(p_y) 0.7 (x_1/y_1)^(0.3) = 1/(p_x) 0.3 (y_1/x_1)^(0.7)\
    1/(p_y) partialDer(U_j, y) = 1/(p_x) partialDer(U_j, x) <=> 1/(p_y) 0.5 (x_2/y_2)^(0.5) = 1/(p_x) 0.5 (y_2/x_2)^(0.5)\
    p_x / p_y = y_2 / x_2 = 3 / 7 y_1 / x_1
    $
    同时，假设双方生产 $x, y$ 的时间分别为 $X_i, X_j, Y_i, Y_j$，由市场出清以及生产的有效性：
    $
    X_i + Y_i = 10\
    X_j + Y_j = 10\
    x_1 + x_2 = 2(X_i + X_j)\
    y_1 + y_2 = 3(Y_i + Y_j)\
    2/3 = "MC"_X^i/"MC"_Y^i = p_x/p_y = "MC"_X^j/"MC"_Y^j\
    $
  ==
    (2) 式可得：
    $
    3(x_1 + x_2) + 2(y_1 + y_2) = 6(X_i + X_j + Y_i + Y_j) = 120
    $
    (1) 式可得：
    $
    2/3=  (3y_2) / (3x_2) = 3 / 7 y_1 / x_1 = (3y_1 + 3y_2)/(3x_2 + 7x_1) = (360 - 9 x_1 - 9x_2)/(14x_1+6x_2)
    $
    
