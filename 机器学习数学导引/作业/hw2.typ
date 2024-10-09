#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
#set page(paper: "a3")
#let ltC = math.lt.tilde
#let empty = ""
= #empty

  #let yi(i) = $bx_(#i)^T sb + epsilon$
  == #empty
    $
    hb &= (X^T X)^(-1) X^T by\
    &= (X^T X)^(-1) X^T autoVecNF(yi, n)\
    &= (X^T X)^(-1) X^T (#autoVecNF(i => $bx_(#i)^T sb$, $n$) + #autoVecNF(i => $epsilon$, $n$))\
    &= (X^T X)^(-1) X^T (#autoVecNF(i => $bx_(#i)^T$, $n$) sb + #autoVecNF(i => $epsilon$, $n$))\
    &= (X^T X)^(-1) X^T (X sb + #autoVecNF(i => $epsilon$, $n$))\
    &= sb + (X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$)\
    $
    因此：
    $
    E(hb) = E(sb) + E((X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$)) = sb + E((X^T X)^(-1) X^T) E#autoVecNF(i => $epsilon$, $n$) = sb
    $
  == #empty
    #lemmaLinear[][
      设 $X$ 是矩阵随机变量，则 $E(tr(X)) = tr(E(X))$
    ]
    #proof[
      $
      E(tr(X)) = E(sum_i X_(i i)) = sum_i E(X_(i i))  = tr(E(X))
      $
    ]
    $
    E(norm(hb - sb)^2) &= E(norm((X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$))^2)\
    &= 1/n E(((X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$))^T ((X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$)))\
    &= 1/n E(#autoRVecNF(i => $epsilon$, $n$) X (X^T X)^(-1) (X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$))\
    &= 1/n E(tr(#autoRVecNF(i => $epsilon$, $n$) X (X^T X)^(-1) (X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$)))\
    &= 1/n E(tr( X (X^T X)^(-1) (X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$) #autoRVecNF(i => $epsilon$, $n$) ))\
    &= 1/n tr(E( X (X^T X)^(-1) (X^T X)^(-1) X^T #autoVecNF(i => $epsilon$, $n$) #autoRVecNF(i => $epsilon$, $n$) ))\
    &= 1/n tr(E( X (X^T X)^(-1) (X^T X)^(-1) X^T) E( #autoVecNF(i => $epsilon$, $n$) #autoRVecNF(i => $epsilon$, $n$) ))\
    &= sigma^2 tr(E( X (X^T X)^(-1) (X^T X)^(-1) X^T))\
    &= sigma^2 E(tr( X (X^T X)^(-1) (X^T X)^(-1) X^T))\
    &= sigma^2 E(tr(  (X^T X)^(-1) X^T X (X^T X)^(-1)))\
    &= sigma^2 E(tr (X^T X)^(-1))\
    &= sigma^2 tr(E (X^T X)^(-1))\
    $
  == #empty
    注意到 $X^T$ 是 $d times n$ 矩阵，其每一列服从 $N(0, I_d)$，因此有：
    $
    X^T (X^T)^T = X^T X tilde W_d (I, n)
    $
    进而：
    $
    (X^T X)^(-1) tilde W^(-1)_d (I, n)
    $
    由 $n > d$ 有：
    $
    E((X^T X)^(-1)) = 1/(n - d - 1) I\
    tr(E((X^T X)^(-1))) = d/(n - d - 1)
    $
= #empty
  由条件，方程显然有解。设 $bbeta = X^T bu + bv$，代入方程有：
  $
  &X (X^T bu + bv) = by\
  bu &= (X X^T)^(-1) (by - X bv)\
  norm(bbeta)^2 &= (bu^T X + bv^T)(X^T bu + bv)\
  &= bu^T X X^T bu + bu^T X bv + bv^T X^T bu + bv^T bv\
  &= (by^T - bv^T X^T)(X X^T)^(-1)(by - X bv) + (by^T - bv^T X^T) (X X^T)^(-1) X bv + bv^T X^T (X X^T)^(-1) (by - X bv) + bv^T bv\
  &= bv^T (I -  X^T (X X^T)^(-1) X) bv + by^T (X X^T)^(-1) by
  $
  #lemmaLinear[][
    $I -  X^T (X X^T)^(-1) X$ 是半正定矩阵
  ]
  #proof[
    令 $P = X^T (X X^T)^(-1) X$，注意到：
    - $P^2 = P$
    - $P = P^T$
    因此：
    $
    (I - P)^2 = I - 2P + P^2 = I - P\
    x^T (I - P) x = x^T (I - P)^2 x = x^T (I -P)^T (I - P) x = norm((I- P) x) >= 0
    $
  ]
  由引理，显然上式取得最小值当且仅当 $bv = 0$，此时 $bbeta = x^T (X X^T)^(-1) by$
=
  ==
    #let bb1 = $bbeta_1$
    #let bb2 = $bbeta_2$
    注意到函数：
     $
     funcDef(f, RR^d, RR, bbeta, norm(by - X bbeta)^2_2 + lambda norm(bbeta)_1^2)
     $
     是两个凸函数的和。假设 $bb1, bb2$ 是两个最小值点，应当有：
     $
     f((bb1 + bb2)/2) >= (f(bb1) + f(bb2))/2
     $
     结合凸性，这意味着：
     $
     f((bb1 + bb2)/2) = (f(bb1) + f(bb2))/2
     $
     而：
     $
     norm(by - X ((bb1 + bb2)/2))^2_2 <= (norm(by - X bb1)^2_2 + norm(by - X bb2)^2_2)/2\
      norm((bb1 + bb2)/2)_1 <= (norm(bb1)_1 + norm(bb2)_1)/2
     $
     由等式，两者分别取等号。对前式化简：
     $
     norm(by - X ((bb1 + bb2)/2))^2_2 &= (norm(by - X bb1)^2_2 + norm(by - X bb2)^2_2)/2\
     1/4 (bb1^T + bb2^T) X^T X (bb1 + bb2) - 1/2 (y^T (bb1 + bb2)X + X^T (bb1^T + bb2^T) y) + y^T y&= (norm(by - X bb1)^2_2 + norm(by - X bb2)^2_2)/2\
     (bb1^T - bb2^T) X^T X (bb1 - bb2)  &= 0\
     (X(bb1 - bb2))^T X(bb1 - bb2) &= 0\
      X(bb1 - bb2) &= 0\
     $
     表明 $norm(by - X bb1)^2_2 = norm(by - X bb2)^2_2$，自然将有 $norm(bb1)_1 = norm(bb2)_1 $
    ==
      #let p1(y) = $norm(by -X #y)^2_2$
      #let p2(y) = $norm(#y)_1$
      设 $bb1, bb2$ 分别是 $S_1(lambda), S_2(phi(lambda))$ 的解，分别证明它们是对方的解。
      #lemmaLinear[][ $p1(bb1) = p1(bb2), p2(bb1) = p2(bb2)$]
      #proof[
        由 $S_2(phi(lambda))$ 的条件不难发现：
        $
        p2(bb2) <= p2(bb1)
        $
        由 $bb2$ 是其最小值及 $p2(bb1) <= p2(bb1)$ 得：
        $
        p1(bb2) <= p1(bb1) \
        lambda p1(bb2) <= lambda p1(bb1) \
        $
        两不等式相加，得：
        $
        p1(bb2) + lambda p2(bb2) <= p1(bb1) + lambda p2(bb1)
        $
        然而由于 $bb1$ 是 $S_1 (lambda)$ 的最小值，应当有：
        $
        p1(bb2) + lambda p2(bb2) >= p1(bb1) + lambda p2(bb1)
        $
        因此以上不等式全部取等，命题得证。
      ]
      由引理，结论显然。
= #empty
  不难验证函数 $f(t) = 1/2(x - t)^2 + lambda^2/2 norm(t)_0$是仅有两段的分段可导函数，并且 $t -> infinity$ 时 $f(t) -> +infinity$，一定有最小值。可以得到 $f$ 的极小值点仅可能是 $0, x$，因此 $f$ 的最小值为：
  $
  cases(
    f(t) = lambda^2/2 "if" f(t) <= f(0),
    f(0) = 1/2 x^2 "if" f(t) > f(0)
  )
  $
  化简即得所求
= #empty
  #lemmaLinear[][
    $k(x, y) = f(x) f(y)$ 一定是半正定函数
  ]
  #proof[
    #let fi(i) = $f(x_#i)$
    不难发现：
    $
    (f(x_i) f(x_j))_(i j) =  #autoVecNF(fi, $n$) #autoRVecNF(fi, $n$)
    $
    这当然是半正定矩阵
  ]
  == #empty
    #let sum1 = $sum_(i j)$
    $
    cos(x - y) = cos x cos y + sin x sin y
    $
    由引理 $cos x cos y, sin x sin y$ 都半正定，因此 $cos(x - y)$ 也是半正定的
  == #empty
    同上
  == #empty
    注意到对应矩阵是柯西矩阵，其行列式为：
    $
    det (1/(x_i + x_j)) = (product_(i > 1, j < i) (x_i - x_j)^2 )/(product_(i j) (x_i + x_j) ) >= 0
    $
    同时，其主子式也有以上形式，不难看出：
    - 若 $i != j => x_i != x_j$，则所有顺序主子式均正，矩阵正定
    - 否则，注意到 ${x | i != j => x_i != x_j}$ 在 $RR^n$ 中稠密，而半正定矩阵的极限仍然半正定，逼近即可。
  == #empty
    $
    e^(-norm(x - y)_1) = product_k e^(-abs(x_(k)))  e^(-abs(y_(k))) = (product_k e^(-abs(x_(k)))) (product_k e^(-abs(y_(k))))
    $
    由引理是半正定的
  == #empty
    注意到 $k(x, y)$ 对应矩阵就是 $k_1 (x, y), k_2 (x, y)$ 对应矩阵的 Hadamard 积，因此由 Schur product theorem 确实是半正定的。
= #empty
  == #empty
    #let px = $phi(x\;omega)$
    #let pxj = $phi(x\;omega_j)$
    #let pxk = $phi(x\;omega_k)$
    #let py = $phi(y\;omega)$
    #let pyj = $phi(y\;omega_j)$
    #let pyk = $phi(y\;omega_k)$
    $
    E_W sqrt(E (k(x, y) - k_m (x, y))^2) &= E sqrt(E_(x, y) (E_omega (px py) - 1/m sum_j pxj pyj)^2)\
    &<= sqrt(E_(x, y, W) (E_omega (px py) - 1/m sum_j pxj pyj)^2)\
    &= sqrt(E_(x, y) ((E_omega (px py))^2 + E_W (1/m sum_j pxj pyj)^2 - 2 (E_omega (px py))^2))\
    &= sqrt(E_(x, y) ((E_omega (px py))^2 + (sum_(j) E_W (pxj pyj)^2 + sum_(j k) (E_W (pxj pyj))(E_W (pxk pyk)) )/m^2 - 2 (E_omega (px py))^2))\
    &= sqrt(E_(x, y) ( m E_omega (px py)^2 + (m^2-m)/2 (E_omega (px py))^2 )/m^2 -  (E_omega (px py))^2)\
    &= sqrt(E_(x, y) ( m E_omega (px py)^2 - (m^2+m)/2 (E_omega (px py))^2 )/m^2 )\
    &<= sqrt(E_(x, y) ( E_omega (px py)^2 )/m )\
    &= sqrt(Q / m)
    $
  == #empty
    从上一问可以得到：
    $
    E epsilon_m (W) <= C^2/sqrt(m)
    $
    注意到 $epsilon_m (W)$ 事实上是 2- 范数，因此可以使用三角不等式：
    $
    D_i epsilon_m (W) 
    &= epsilon_m (W_1) - epsilon_m (W_2) \
    &<= epsilon_m (W_1 - W_2)\
    &= sqrt(E_(x, y) (1/m (phi(x\;omega_1)phi(y\;omega_1) - phi(x\;omega_2)phi(y\;omega_2)))^2)\
    &<= sqrt(E_(x, y) (2 C^2/m)^2)\
    &= 2 C^2/m\
    
    $
    由 McDiarmid's inequality，有：
    $
    P(abs(epsilon_m (W) - E epsilon_m (W)) >= t) <= 2 e^(-t^2/(2 sigma^2))
    $
    其中 $sigma^2 = 1/4 sum_(i = 1)^m 4/m^2 C^4 = C^4/m$，因此：
    $
    P(abs(epsilon_m (W) - E epsilon_m (W)) >= t) <= 2 e^(-(m t^2)/(2 C^4))\
    P(epsilon_m (W) >= C^2/sqrt(m) + t) <= P(abs(epsilon_m (W) - E epsilon_m (W)) >= t) <= 2 e^(-(m t^2)/(2 C^4))\
    $
    令 $2 e^(-(m t^2)/(2 C^4)) = delta$，解得：
    $
    - (m t^2)/(2 C^4) = ln (delta/2)\
    t = sqrt(2 C^4 ln (2/delta))/sqrt(m)
    $
    整理即得：
    $
    P(epsilon_m (W) >= C^2/sqrt(m) (1 + 2 ln (2/delta))) <= delta
    $
    证毕
