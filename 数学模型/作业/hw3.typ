#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#let absSigmaI(i) = $abs(x_sigma(#i))$
#let fL = $f^L$
（应交事件为4月1日）
= 
  $
  h_max = max_(x in RR^n)(sum_((i, j) in E) |x_i - x_j|)/(max_(c in RR) sum_(i in V) d_i |x_i - c|)
  $
=
  设 $f, g: P_2 (V) -> [0, +infinity]$，且对任意 $(A, B) in P_2 (V) - {(emptyset, emptyset)}$ 有 $g(A, B) > 0$，则我们有：
      $
      max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = max_(x in RR^n - {0}) (f^L (x))/(g^L (x))
      $
  #proof[
    - 首先要证明右侧的最大值存在。事实上前面证明了 $f^L, g^L$ 是一次齐次的连续函数，因此可以在任何一个有界闭集上取得最大值，例如 ${x | norm(x) = 1}$，其上的最大值也是它在整个定义域上的最大值
    - 其次，显然有：
      $
      max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B)) = max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f^L (1_(A, B)))/(g^L (1_(A, B))) <= max_(x in RR^n - {0}) (f^L (x))/(g^L (x))
      $
      因此只要证明另一侧不等式
    - 任取 $x !=0 $:
      $
      (f^L (x))/(g^L (x)) = (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i)))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) 
      $
      注意到我们总可以取得 $(C, D) in P_2 (V)$ 使得：
      $
      (f(C, D))/(g(C, D)) = max_(0<= i <= n-1) (f(V^+_(sigma(i)), V^-_(sigma(i)))) /(g(V^+_(sigma(i)), V^-_(sigma(i))))
      $
      有：
      $
      &(f^L (x))/(g^L (x)) - (f(C, D))/(g(C, D))  \
        &=
        (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i))) - (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) (f(C, D))/(g(C, D))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i)))) \
        &<= (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) f(V^+_(sigma(i)), V^-_(sigma(i))) - (sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i))) (f(V^+_(sigma(i)), V^-_(sigma(i))))/(g(V^+_(sigma(i)), V^-_(sigma(i)))))) /(sum_(i=0)^(n-1) (absSigmaI(i+1) - absSigmaI(i)) g(V^+_(sigma(i)), V^-_(sigma(i))))\
        &= 0
      $
      因此 
      $
      max_(x in RR^n - {0}) (f^L (x))/(g^L (x)) <= (f(C, D))/(g(C, D)) <= max_((A, B) in P_2 (V) - {(emptyset, emptyset)}) (f(A, B))/(g(A, B))
      $
      证毕
  ]
=
  $
  h_max = max_(x in RR^n)(sum_((i, j) in E) |x_i - x_j|)/(max_(c in RR) sum_(i in V) d_i |x_i - c|)
  $
  #proof[]
= 
  注意到有积分形式：
  $
    f^L (x) = integral_0^(norm(x)_infinity) f(V_t^+ (x), V_t^- (x)) dif t
  $
  容易看出当且仅当 $f(V_t^+ (x), V_t^- (x))$ 关于 $t$ 递增时它是凸函数。它当然不总是凸函数，至少可以取 $g = -f$ 不可能与 $f$ 同时关于 $t$ 递增。

  再例如取：
  $
  V = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}\
  x_i = i, i=1,2, 3...,10\
  f(A, B) = (min_(i in A) i)(10-min_(i in A) i)
  $
  则容易看出 $f(V_t^+ (x), V_t^- (x))$ 关于 $t in [0,1]$ 先增后减，当然对应的 $f^L (x)$ 不是凸函数或者凹函数
