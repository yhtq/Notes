#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 2.1.4
  显然：
  $
    f = inner(*, y)
  $
  - 一方面，$f y = inner(y, y) = norm2(y)$
  - 另一方面，$f x = inner(x, y) <= norm(x) norm(y)$
  因此 $norm(f) = norm(y)$
= 2.1.7
  == (1)
    由于 $T$ 有界线性，因此 $T$ 连续，继而：
    $
      N(T) = Inv(f) (0)
    $
    是闭集。验证线性算术可知 $N(T)$ 也是线性空间，因此结论成立。
  == (2)
    不能。考虑 $X = C^1, Y = L^2, T = $ 求导算子，则 $N(T) = im (i: RR -> C^1)$ 是闭线性子空间，但求导算子当然不是有界的。
  == (3)
    只需假设 $N(f)$ 是闭子空间，证明 $f$ 在 $0$ 处连续。任取 $x_n -> 0$，假设 $f(x_n) arrow.not 0$，不妨设 $f(x_n) > epsilon > 0$ 我们有：
    $
      f(x_n/f(x_n) - x_m/f(x_m)) = 0 => x_n/f(x_n) - x_m/f(x_m) in N(f), forall n
    $ 
    由于 $N(f)$ 是闭的，上式中令 $n -> +infinity$ ，由假设有 $x_n/f(x_n) -> 0$，因此：
    $
      x_m/f(x_m) in N(f), forall m
    $
    然而 $f(x_m/f(x_m)) = 1$，矛盾！
= 2.1.8
  #let Hlam(lam) = $H_f^#lam$
  == (1)
    设 $z in Hlam(0)$，有：
    $
      norm(x - z) gt.eq norm(f(x) - f(z)) = norm(f(x))
    $
    此外，假设取得一列 $y_n$ 使得 $norm(y_n)/norm(f(y_n)) -> 1$，有：
    $
      norm(x - (x - f(x) y_n/f(y_n))) = norm(f(x))/norm(f(y_n)) norm(y_n) -> norm(f(x)) 
    $
    以及 $(x - f(x) y_n/f(y_n)) in Hlam(0)$，证毕
  == (2)
    任取 $x in Hlam(lambda)$，有：
    $
      f(x) = lambda
    $
    第一问给出：
    $
      norm(lambda) = inf_(z in Hlam(0)) norm(x - z) = dist(x, Hlam(0))
    $
  == (3)
    $RR^2 -> RR$ 的模为 $1$ 的线性泛函（由表示定理）就是相当于对某个方向做投影得到的长度，(1) 就是给出了 $x$ 对该方向的正交分解，（2）是说对于一族投影相等的向量，它们到法向量的距离也相等。
= 2.2.1
  由 Risez 表示定理，立刻可设：
  $
    N(f_k) = orthogonalCom(span(y_k))
  $
  因此（有限维空间都是闭的）：
  $
    orthogonalCom(N(f_k)) = span(y_k)
  $
  同时：
  $
    M = inter.big N(f_k) = inter.big orthogonalCom(span(y_k)) = orthogonalCom(span(autoRListN(y, n))) 
  $
  因此对于任何 $x_0$，可设：
  $
    x_0 = y_0 + y'_0
  $
  其中 $y_0 in M = orthogonalCom(span(autoRListN(y, n))), z_0 in span(autoRListN(y, n))$
  ，这当然就是结论
= 2.2.2
  == (1)
    #let us = $u^*$
    #let vs = $v^*$
    注意到：
    $
      1/2 norm2(us - vs) - 1/2 norm2(us) = 1/2 norm2(vs) - 2 Re inner(us, vs) 
    $
    由 Risez 表示定理，有：
    $
      l = inner(*, vs)
    $
    由于 $l$ 是实值的，当然：
    $
      l = Re l = Re inner(*, vs)
    $
    比照条件即得结
  == (2)
    $
      inf_(v in C) f(v) = 1/2 inf_(v in c) norm2(us - v) - 1/2 norm2(us)
    $
    由熟知的引理以及 $C$ 是闭凸子集，$exists! v in C suchThat norm2(us - v) = inf_(v in c) norm2(us - v)$，证毕
= 2.2.5
  #let PM = $P_M$
  #let PM1 = $P_(M')$
  #let PL = $P_L$
  #let PL1 = $P_(L')$
  #let PLc = $P_(orthogonalCom(L))$
  #let PMc = $P_(orthogonalCom(M))$
  == (1)
    $
      PL PM = 0 <=> forall x, PL PM x = 0 <=> forall x in M, y in orthogonalCom(M), PL PM (x + y) = 0\
      <=> forall x in M, y in orthogonalCom(M), PL x = 0 <=> forall x in M, PL x = 0\ <=> forall x in M, x in orthogonalCom(L) <=> L orthogonal M
    $
  == (2)
    $
      PL + PM = 1 <=>^(PM = 1 - PMc) PMc = PL <=> L = orthogonalCom(M)
    $
  == (3)
==
  #let LMc = $P_((orthogonalCom(L inter M)))$
    设 $H' = H quo L inter M, pi: H -> H', L' = pi(L), M' = pi(L)$，（$H'$ 上内积为代表元在 $orthogonalCom(L inter M)$ 的投影的内积）则容易验证 $PM, PL$ 可以提升到 $H'$ 上且结果恰为 $PM', PL'$，因此显然有：
    $
      P_(L inter M) = PM PL => PM1 PL1 = 0
    $
    另一方面，有：
    $
      PM PL = PL PM => PM1 PL1 = 0
    $
    这是因为有 $PM1 PL1 = PL1 PM1$，导致 $im PM1 PL1 = im PL1 PM1 subset L' inter M' = 0$

    最后，往证 $PM1 PL1 => PM PL = PL PM = P_(L inter M)$：假设 $PM1 PL1 = 0 $，则由前面的习题同时有 $PL1 PM1 = 0$，因此：
    $
      im PL PM = L inter M = im PM PL
    $
    故：
    $
      P_(L inter M) PL PM = PL PM
    $
    然而不难证明 $P_(L inter M) PL = P_(L inter M) = P_(L inter M) PM$，因此：
    $
      P_(L inter M) = PM PL
    $
    同理：
    $
      P_(L inter M) = PL PM
    $
    证毕
    // 显然 $(PM PL)|_(L inter M) = id = P_(L inter M) |_(L inter M)$，而设 $x in orthogonalCom(L inter M)$，有：
    // $
    //   PM PL x in L inter M 
    // $
    
    // $
    //   PM PL = PL PM <=> PM1 PL1 = PL1 PM1 
    // $
    // 其中右推左是因为 $(PM1 PL1 - PL1 PM1) = 0 => im (PL PM - PM PL) subset L inter M$
    
    
    // 设 $i : M -> H, i' : orthogonalCom(M) -> H$ 是典范的嵌入，则显有：
    // $
    //   U = V <=> U i = V i and U i' = V i' 
    // $
    // 其中 $U, V$ 是任意两个线性函数。因此：
    // $
    //   PL PM = PM PL 
    //   &<=> PL PM i = PM PL i and PL PM i' = PM PL i'\
    //   &<=> PL i = PM PL i and 0 = PM PL i'\
    //   &<=> (im PL i subset L inter M and PL i = PM PL i) and 0 = PM PL i'\
    //   &<=> (P_(L inter M) PL i = PL i  and PL i = PM PL i) and 0 = PM PL i'\
    //   &<=> (P_(L inter M) PL i = PL i  and P_(L inter M) PL  i = PM PL i) and 0 = PM PL i'\
    //   &<=>^(P_(L inter M) PL = P_(L inter M)) P_(L inter M) PL i = PL i  and P_(L inter M) i = PM PL i and 0 = PM PL i'\
    //   &<=> P_(L inter M) PL i = PL i  and P_(L inter M) i = PM PL i and P_(L inter M) i' = PM PL i'\
    //   &<=> P_(L inter M) PL i = PL i  and P_(L inter M) = PM PL\
    //   &<=> P_(L inter M) i = PL i  and P_(L inter M) = PM PL\
    //   &=> P_(L inter M) = PM PL
    // $
    // 反之，假设 $P_(L inter M) = PM PL$，令 $H' = H quo (L inter M)$ 以及 $PM', PL'$ 为对应的映射，有：
    // $
    //   PM' PL' = 0 <=> PL' PM' = 0
    // $
    // // $
    // //   PM PL i = P_(L inter M) i and PM PL i' = 0
    // // $
    // // #lemmaLinear[][
    // //   设 $U$ 是闭子空间，$T$ 是线性函数，则：
    // //   $
    // //     P_U T = T 
    // //   $
    // // ]
    // // 首先有：
    // // $
    // //   PM PL PM - PM PL = PM (PL PM - PL)
    // // $
= 1
  我们先计算：
  $
    inner(e_u, e_v) = lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) ei((u - v) x) dif x
  $
  - $u = v$ 时：
    $
      lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) ei((u - v) x) dif x = lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) 1 dif x = 1
    $ 
  - 否则：
    $
      lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) ei((u - v) x) dif x = 0 ("黎曼-勒贝格引理")
    $
  == (1)
    共轭对称和线性是显然的，只需验证非负性。假设 $inner(f, f) = 0$，则有：
    $
      0 = lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) norm2(f(x)) dif x 
    $
    设 $f(x) = sum_k u_i eiB(lambda_i x)$，则：
    $
      0 = lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) norm2(f(x)) dif x =^("运用之前结果") sum_k u_k^2 lim_(T -> +infinity) 1/(2 T) integral_(-T)^(T) norm2(ei(lambda_i)) dif x => sum_k u_k^2 = 0
    $
    立刻表明 $f = 0$
  == (2)
    就是前面的计算结果
  == (3)
    由于 $e_lambda$ 是一组（Hemel）基，$Y$ 中当然不可能存在非零向量与其正交
  == (4)
    注意到 $Y = span(e_lambda)$ 在 $complete(Y)$ 中稠密，因此由之前验证的性质可知 $e_lambda$ 是 $complete(Y)$ 的 Hilbert 基，同时熟知所有 Hilbert 基等势，因此 $complete(Y)$ 不可分。
= 2
  设 $f in L^2 (RR)$，往证 $f$ 与所有函数正交导致 $f = 0$. 由稠密性，不妨设 $f$ 连续，注意到：
  $
    integral_(-infinity)^(+infinity) f(x) x^n e^(-x^2/2) e^(2 pi i xi x) dif x = sum_(n = 0)^(+infinity) ((2 pi i xi x)^n)/n! integral_(-infinity)^(+infinity) f(x) x^n e^(-x^2/2) dif x = 0
  $
  因此 $hat(f)(xi) = 0$，由傅里叶变换的唯一性以及 $f$ 连续性可知 $f = 0$

  注意到：
  $
    derN(e^(-x^2), x, (n + 1)) =  derN(-2 x e^(-x^2), x, n) = -2 derN(x e^(-x^2), x, n) = -2 (x derN(e^(-x^2), x, n) + n derN(e^(-x^2), x, n-1))
  $
  #lemmaLinear[][
    $e^(x^2/2) H_n$ 是 $n$ 次多项式
  ]
  #proof[
    $n = 1, 2$ 时直接验证即可，否则注意到：
    $
      H_(n + 1) = C_(n + 1) e^(x^2/2) derN(e^(-x^2), x, (n + 1)) = -2 C_(n + 1) e^(x^2/2) derN(x e^(-x^2), x, n) \
      = -2 C_(n + 1) e^(x^2/2) (x derN(e^(-x^2), x, n) + n derN(e^(-x^2), x, n-1))
      = -2 C_(n + 1) (x 1/C_n H_n + n 1/C_(n - 1) H_(n - 1)) 
    $
    递归式足以给出结论
  ]
  #lemmaLinear[][
    $H_n$ 标准正交
  ]
  #proof[
    计算验证即可：
    - 用归纳法，设 $n < m$ 则：
      $
        e^(-x^2)\
        -2x e^(-x^2)\
        -2 (e^(-x^2) - 2x^2 e^(-x^2))
      $
      $
        integral_()^() H_m H_n dif x = C integral_()^() e^(-x^2) derN(e^(-x^2), x, n) derN(e^(-x^2), x, m) dif x 
      $
      注意到 $e^(-x^2)$ 关于 $y$ 轴对称，因此 $n$ 阶导数要么关于 $y$ 轴对称要么关于零点中心对称。当 $n, m$ 奇偶不同时，上式是关于原点对称的积分，当然为零。而当 $n, m$ 奇偶性相同时，归纳证明：
      $
        integral_()^() e^(x^2) derN(e^(-x^2), x, n) derN(e^(-x^2), x, m) dif x 
        &= integral_()^() e^(x^2) derN(e^(-x^2), x, n) dif derN(e^(-x^2), x, m - 1)\
        &= - integral_()^() derN(e^(-x^2), x, m - 1)  dif e^(x^2) derN(e^(-x^2), x, n)\
        &= - integral_()^() derN(e^(-x^2), x, m - 1) (2x e^(-x^2) derN(e^(-x^2), x, n) + e^(-x^2) derN(e^(-x^2), x, n + 1) ) dif x\
        &= - integral_()^() derN(e^(-x^2), x, m - 1) (2x e^(-x^2) derN(e^(-x^2), x, n) - 2e^(-x^2) (x derN(e^(-x^2), x, n) + n derN(e^(-x^2), x, n-1)) ) dif x\
        &= 2 n integral_()^() e^(x^2) derN(e^(-x^2), x, n - 1) derN(e^(-x^2), x, m - 1) dif 
      $
      归纳法可得上式为零。
    - 之前的推理事实上给出
      $
        norm2(H_n/C_n) = 2 n norm2(H_(n - 2)/C_(n - 2))
      $
      结合 $C_n$ 形式可得：
      $
        norm2(H_n) = norm2(H_(n - 2))
      $
      以及可以计算：
      $
        norm2(H_0) = integral_()^() 1/(sqrt( pi)) e^(-x^2) dif x = 1\
        norm2(H_1) = integral_()^() 1/(2 sqrt(pi)) 4 x^2 e^(-x^2/2) dif x = 1
      $

  ]
  当 $n = 1$ 时显然有 $H_1 = f_1$，而之前引理保证了：
  $
    f_n in span(autoRListN(H, n)) and f_n in.not span(autoRListN(H, n - 1)) => H_n in span(autoRListN(H, n - 1), f_n)
  $
  这足以保证 $H_n$ 就是 Gram-Schmidt 过程的结果