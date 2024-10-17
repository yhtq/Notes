#import "../../../template.typ": *
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 2
  注意到 $norm(x + y) = norm(x) + norm(y)$ 等价于柯西不等式：
  $
  inner(x, y) <= norm(x)  norm(y)
  $
  取等，显然当且仅当 $x, y$ 线性相关且 $inner(x, y) = x^T y >= 0$
= 3
  $
  norm(A)_F^2 = sum_(i j) a_(i j)^2 = sum_j (sum_i a_(i j)^2) = sum_j norm(a_i)^2_2
  $
= 4
  #let bc = autoRVecNF(i => $beta_#i$, $n$)
  #let abc = autoRVecNF(i => $A beta_#i$, $n$)
  #let nf(A) = $norm(#A)_f$
  #let nf2(A) = $norm(#A)_f^2$
  #let n2(A) = $norm(#A)_2$
  #let n22(A) = $norm(#A)_2^2$

  设 $B = bc$，则：
  $
  nf2(A B) = nf2(abc) = sum_j n2(A beta_j) <= sum_j n22(A) n22(beta_j) = n22(A) sum_j n22(beta_j) \
  = n22(A) nf2(B) 
  $
  开方即得 $nf(A B) <= n2(A) nf(B)$\
  另一方面，有：
  $
  nf(A B) = nf((A B)^T) = nf(B^T A^T) <= n2(B^T) nf(A^T) = n2(B) nf(A)
  $
  就是第二个不等式
= 8
  #let suma = sumf()
  #let summ = sumf(lower: $m$)
  考虑形式幂级数：
  $
  suma A^n
  $
  断言它收敛，事实上使用柯西准则：
  $
  norm(summ A^n) <= summ norm(A^n) <= summ norm(A)^n -> 0 
  $
  因此一定收敛。设其和为 $B$，则：
  $
  B (I - A) = (suma A^n)(I - A) = I
  $
  表明 $B$ 就是 $I-A$ 的逆，并且：
  $
  norm(B) = norm(suma A^n) <= suma norm(A^n)  <= suma norm(A)^n = 1/(1 - norm(A))
  $
  证毕
= 11
  == 1. #empty
    $
    A = mat(375, 374;752, 750)\
    mat(1, 0;-2, 1) A = mat(375, 374;2, 2)\
    mat(1, 0;-1, 1/2) A = mat(375, 374;1, 1)\
    mat(375, -187;-1, 1/2) A = mat(1, 0;1, 1)\
    mat(375, -187;-376, 187.5) A = mat(1, 0;0, 1)\
    $
    $kappa_infinity A = norm(A) norm(Inv(A)) = 1502 * 188.5 = #(1502 * 188.5) $
  == 2. 
    #let b1 = -376 + 187.5 * 375 / 187
    #let b1s = repr(-376 + 187.5 * 375 / 187)
    等式变为：
    $
    x = Inv(A) b
    $
    取 $b = vec(1, 375/187)$，则：
    $
    x = vec(0, b1s)
    $
    做微扰：
    $
    Inv(A) (b + vec(epsilon_1, epsilon_2)) = vec(375 epsilon_1 - 187 epsilon_2, b1 - 376 epsilon_1 + 187.5 epsilon_2)
    $
    $epsilon_1, epsilon_2$ 很小时，$b$ 变化量很小，但：
    $
    norm(delta x)/norm(x) >= abs(375 epsilon_1 - 187 epsilon_2)/b1s = abs(#repr(375 / b1) epsilon_1 - #repr(187 / b1) epsilon_2) >= 1
    $
  == 3. #empty
    #let c1 = 374 * 752 / 375 - 750
    #let c1s = repr(c1)
    取 $x = vec(374/375, -1)$，则：
    $
    A x = vec(0, c1s)\
    A (x + vec(epsilon_1, epsilon_2)) = vec( 375 epsilon_1 + 374 epsilon_2, c1s 
    +  752 epsilon_1 + 750 epsilon_2)
    $
    $epsilon_1, epsilon_2$ 很小时，$x$ 变化量很小，但：
    $
    norm(delta b)/norm(b) >= abs(375 epsilon_1 + 374 epsilon_2)/(c1s) = abs(#repr(375 / c1) epsilon_1 + #repr(374 / c1) epsilon_2) 
    $