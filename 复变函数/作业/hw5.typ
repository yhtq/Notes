#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, seqLimit, seqLimitn
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#let Gal = $G a l$
#set heading(numbering: none)
（应交时间为4月3日）
= p67 
  == 7
    取 $t_(n) = 1/(pi n + pi/2)$，取分划：
    $
    P_n : 0 = x_(n 0) < x_(n 1) = t(n) < x_(n 2) = t(n - 1) < ... < x_(n n) = t(1) < x_(n n + 1) = 1
    $
    则：
    $
    sum_(k=0)^n norm(gamma(x_(n (k+1))) - gamma(x_(n k))) = sqrt((sum_(k=0)^n (x_(n (k+1)) - x_(n k)))^2 + sum_(k=0)^n norm(gamma(t_k) - gamma(t_(k+1))) ) \
    = sqrt((t(1) - 0)^2 + sum_(k=1)^n norm(t_k sin (k pi + pi/2) - t_(k+1) sin ((k+1)pi + pi/2)) )\ 
    = sqrt((t(1) - 0)^2 + sum_(k=1)^n t_(k+1) + t_k )\ 
    = sqrt((t(1) - 0)^2 + 2 sum_(k=1)^n 1/(pi n + pi/2) + t_n )\ 
    $
    容易看出 $n->+infinity$ 时上式并无上界
  == 19
    证明中利用了开集内两点的连线还在开集内，换言之必须是一个凸的开集，这利用了开圆盘的假设
  == 23
    首先，我们取包含 $gamma$ 的开集 $G' subset G$ 使得 $exists m, forall x in G', norm(x - a) > m > 0$\
    - 若 $a$ 不是 $G$ 的边界点，则 $G' = G$ 即可
    - 反之，在 $a$ 附近找到开球使得 $overline(U(a, delta)) sect gamma = emptyset$，取 $G - overline(U(a, delta))$ 包含 $gamma$ 的连通分支即可
    取 $F = 1/(z-a)， forall z in G'$，则由 $norm(z - a) > m$ 知它是解析函数，且 $F' = - 1/(z-a)^2$，由熟知定理知当然有：
    $
    integral_(gamma)^() F' = 0 
    $
= p74 4
  == (a)
    令 $s_N = sum_(n = 1)^N a_n$，无妨设 $s_N -> 0$，则：
    $
    sum a_n r^n = sum (s_(n) - s_(n-1)) r^n = sum s_n r^n - sum s_(n-1) r^n = sum s_n r^n - sum s_(n) r^(n+1)\
    = (1-r) sum s_n r^n
    $
    对于 $epsilon > 0$，由 $s_N -> 0$ ，无妨设 $abs(s_n) < epsilon$（既然前面有限项求和当 $r$ 接近于 $1$ 时当然趋近于 $0$），则：
    $
    abs((1-r) sum s_n r^n) <= (1-r) sum abs(s_n) r^n < epsilon (1-r) sum r^n = epsilon (1-r)/(1-r) = epsilon
    $
    表明 $lim_(r -> 1^-) sum a_n r^n = 0$，证毕
  == (b)
    考虑 $f(x) = sum_(n = 1) (-1)^(n-1)1/n x^n$，则：
    $
    f'(x) = sum_(n = 1) (-1)^(n-1) x^(n-1) = sum_(n = 0) (-1)^n x^n = 1/(1+x)\
    f(x) = ln(1+x) + C
    $
    令 $X -> 1^-$ 由上面结论知 $sum_(n = 1) (-1)^(n-1)1/n = ln 2$

    