#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
#let ltC = math.lt.tilde
= 
  ==

    #let vsc = $V_S^c$
    #let xvsc = $x in V_S^c$
    $
    E(P(xvsc | S)) &= E (sum_(j=1)^m P(xvsc | x in Q_j) P(x in Q_j)) \
    &= 1/m E( sum_(j=1)^m P(xvsc | x in Q_j))\
    &= 1/m sum_(j=1)^m E(P(xvsc | x in Q_j))\
    &= 1/m sum_(j=1)^m E(P(xvsc | x in Q_j) | product_(i) x_i in.not Q_j) P(product_(i) x_i in.not Q_j) \
    &+ E(P(xvsc | x in Q_j) | (product_(i) x_i in.not Q_j)^c) (1 - P(product_(i) x_i in.not Q_j))\
    &= 1/m sum_(j=1)^m 1 dot P(product_(i) x_i in.not Q_j) + 0 dot (1 - P(product_(i) x_i in.not Q_j))\
    &= 1/m sum_(j=1)^m  product_(i) P(x_i in.not Q_j)\
    &= (1 - h^d)^n \
    $
    本题中 $E_(S, x) P(xvsc)$ 的写法似乎有些奇怪，$P(xvsc)$ 从字面上来说是一定值，不需要求期望。如果假设含义是：
    $
    E_(S) (P(xvsc | S))
    $
    也就是对于某组取定的 $S$，$P(xvsc | S)$ 是一关于 $S$ 的函数，对其求期望，那么也应该与 $x$ 无关（第一层求概率已经消去了随机变量 $x$），不应该写作 $E_(S, x)$，况且不难验证：
    $
    E_(S) (P(xvsc | S)) = P(xvsc)
    $
    似乎并不需要表述地这么复杂。
  == 

    令：
    $
    f(t) = n t (1 - t)^n, t in (0, 1)\
    f'(t) = n (1 - t)^n - n^2 t (1 - t)^(n-1) = n (1-t)^(n-1) (1 - (n + 1) t)\ 
    $
    因此函数在 $t = 1/(n + 1)$ 处取最大值，因此有：
    $
    n t (1 - t)^n <= n / (n + 1) (1 - 1/(n + 1))^n = n / (n + 1) (n / (n + 1))^n = (n / (n + 1))^(n + 1) <= 1
    $
    因此：
    $
    h + (1 - h^d)^n <= h + 1/(n h^d) 
    $
    另一方面，注意到：
    $
    h + 1/(n h^d) = sum_(i = 1)^d 1/d h + 1/(n h^d) >= root(d+1, (h/d)^d dot 1/(n h^d)) = 1/(root(d+1, d) root(d+1, n))
    $
    且在 $1/d h = 1/(n h^d)$ 处取得，因此：
    $
    min h + 1/(n h^d) = 1/(root(d+1, d) root(d+1, n))\
    min h + (1 - h^d)^n <= 1/(root(d+1, d) root(d+1, n)) ltC 1/(root(d+1, n))
    $
  == 

    #let xv = $bold(x)$
    #let yv = $bold(y)$
    #let xs = $x_"sample"$
    $
    E norm(x - T(x)) 
    &= E (norm(x - T(x))| xvsc) P(xvsc) \ &+ E (norm(x - T(x)) | x in V_S) P(x in V_S)\
    &<=  E (sqrt(d)| xvsc) P(xvsc) + E (h sqrt(d) | x in V_S) P(x in V_S)\
    &=  sqrt(d) P(xvsc) + h sqrt(d) P(x in V_S)\
    &<=  sqrt(d) P(xvsc) + h sqrt(d)\
    &<=  sqrt(d) integral_(xs in [0, 1]^d) P(xvsc | (x_1, ..., x_n) = xs) rho(xs)  dif xs + h sqrt(d)\
    &=  sqrt(d) E_S (xvsc | S) (P(xvsc)) + h sqrt(d)\
    &=  sqrt(d) (1 - h^d)^n + h sqrt(d)\
    &=  sqrt(d) ((1 - h^d)^n + h)\
    &ltC  sqrt(d) (1/(n^(1/(d+1))))\
    &ltC  sqrt(d)/(n^(1\/(d+1)))\
    $
  == 

    #let f1 = $hat(f_S)$ 
    #let fo = $f^*$
    $
    E norm(f1 - fo) &= E (integral_(x in [0, 1]^d) (f1(x) - fo(x))^2  dif x)\
    &= E (integral_(x in [0, 1]^d) (fo(T(x)) - fo(x))^2  dif x)\
    &<= E (integral_(x in [0, 1]^d) L norm(x - T(x))  dif x)\
    &<= L integral_(x in [0, 1]^d) E (norm(x - T(x))  dif x)\
    &<= L sqrt(d)/(n^(1\/(d+1)))\
    $

