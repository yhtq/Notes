#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
// #set page(paper: "iso-b4")
= 
  #set text(size: 10pt)
  #let asi(i) = $alpha_#i^*$
  #let innerx(i, j) = $inner(x_#i, x_#j)$
  $
    alpha_2 &= (s (innerx(1, 1) - innerx(1, 2)) + y_2 sum_(j = 3)^N asi(j) y_j (innerx(1, j) - innerx(2, j)) - s + 1)/eta\
    &= (s gamma (innerx(1, 1) - innerx(1, 2)) + y_2 (sum_(j = 1)^N asi(j) y_j (innerx(1, j) - innerx(2, j)) - asi(1) y_1 (innerx(1, 1) - innerx(2, 1)) - asi(2) y_2 (innerx(1, 2) - innerx(2, 2))) - s + 1)/eta\
    &= ((s gamma - s asi(1)) (innerx(1, 1) - innerx(1, 2)) + y_2 sum_(j = 1)^N asi(j) y_j (innerx(1, j) - innerx(2, j)) + asi(2) (innerx(1, 2) - innerx(2, 2)) - s + 1)/eta\
    &= ((s gamma - s asi(1)) (innerx(1, 1) - innerx(1, 2)) + asi(2) (innerx(1, 2) - innerx(2, 2)) + y_2 sum_(j = 1)^N asi(j) y_j (innerx(1, j) - innerx(2, j)) - s + 1)/eta\
    &= (asi(2) (innerx(1, 1) - innerx(1, 2)) + asi(2) (innerx(1, 2) - innerx(2, 2)) + y_2 (f(x_1) - f(x_2)) - y_1 y_2 + y_2^2)/eta\
    &= (asi(2) eta + y_2 ((y_2 - f(x_2)) - (y_1 - f(x_1))))/eta\
    &= asi(2) + (y_2 ((y_2 - f(x_2)) - (y_1 - f(x_1))))/eta\
  $
= 
  // #set text(size: 12pt)
  最优化问题变为：
  $
    min_(w, b, xi) 1/2 norm(w)^2 + C sum_i p_i xi_i\
    suchThat y_i (inner(w, x_i) + b) >= 1 - xi_i\
            xi_i >= 0 
  $
  写出拉格朗日函数：
  $
    L = 1/2 norm(w)^2 + C sum_i p_i xi_i - sum_i alpha_i (y_i (inner(w, x_i) + b) - 1 + xi_i) - sum_i beta_i xi_i
  $
  求导得到：
  - $partialDer(L, w) = 0$:
    $
      w = sum_i alpha_i y_i x_i
    $
  - $partialDer(L, b) = 0$:
    $
      sum_i alpha_i y_i = 0
    $
  - $partialDer(L, xi_i) = 0$:
    $
      alpha_i = p_i C - beta_i
    $
  因此目标函数化简为：
  $
    L = 1/2 inner(sum_i alpha_i y_i x_i, sum_i alpha_i y_i x_i) + sum_i (C p_i - beta_i) xi_i - inner(sum_i alpha_i y_i x_i, sum_i alpha_i y_i x_i) + sum_i alpha_i - sum_i xi_i alpha_i\
    = sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j inner(x_i, x_j)  
  $
  得到对偶问题：
  $
    max_alpha sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j inner(x_i, x_j)\
    suchThat sum_i alpha_i y_i = 0\
       0 <= alpha_i, beta_i\
      alpha_i + beta_i = p_i C
  $
= 
  #let xor = $mid("xor")$
  设异或函数为 #xor，假设其线性可分，也即设有 $w, b$ 使得：
  $
    x xor y <=> w vec(x, y) + b > 0
  $
  遍历 $x, y$ 列出：
  $
    w_1 + b > 0\
    w_2 + b > 0\
    b < 0\
    w_1 + w_2 + b < 0
  $
  然而 1,2,3 式表明 $w_1, w_2 > 0$，结合 $w_2 + b > 0$ 可得 $w_1 + w_2 + b > 0$，表明上述方程组无解。