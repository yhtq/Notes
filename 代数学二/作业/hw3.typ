#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为3月19日）
#let dirSum = $plus.circle$
#set heading(numbering: none)
= 14
  $
  forall x_i in M_i, mu_i (x_i) = mu(x_i) = mu(x_i - mu_(i j)(x_i) + mu_(i j)(x_i)) = mu(mu_(i j)(x_i)) = mu_j (mu_(i j)(x_i))
  $
  表明 $mu_i = mu_j mu_(i j)$
= 15
  == (1)
    注意到任意 $M$ 中元素均形如：
    $
    sum_(j in J) mu_j (x_j)
    $
    由于是直和，这里的 $J$ 是有限集。同时由正向系统的性质，不妨设 $k in I$ 是 $J$ 的上界，如此有：
    $
    sum_(j in J) mu_j (x_j) = sum_(j in J) mu_k (mu_(j k) (x_j)) = mu_k (sum_(j in J) mu_(j k) (x_j))
    $ 
    那么该元素就被写成了 $mu_k (x_k)$ 的形式，证毕
  == (2)
    由 $mu_i (x_i) = 0$ 知：
    $
    x_i in D => x_i in sum_((i, j) in L) A (x_i - mu_(i j) (x_i))
    $
    这里 $L subset I dirSum I$ 是指所有出现的 $D$ 的生成元对应的二重指标，并且总有：
    $
    j >= i , forall (i, j) in L
    $
    设 $L = L_1 dirSum L_2$，这里 $L$ 也是有限集，进而 $L_2 subset I$ 也是。找到 $k$ 是 $L_2$ 的上界，自然也是 $L_1$ 的上界。\
    严格起见，定义：
    $
    funcDef(nu_k, (dirSum((i, j) in L) M_i dirSum M_j), M_k, dirSum((i, j) in L) (x_(i j), y_(i j)) , sum_((i, j) in L) mu_(i k)(x_(i j)) + mu_(j k)(y_(i j)))
    $
    容易验证：
    - 它是模同态
    - $nu_k|_(M_i) = mu_(i k)$
    如此，有
    $
    mu_(i k)(x_i) = nu_k (x_i) in sum_((i, j) in L) A (nu_(k)(x_i) - nu_(k)(mu_(i j) (x_i)))\
    = sum_((i, j) in L) A (mu_(i k)(x_i) - mu_(j k)(mu_(i j) (x_i))) = {0}
    $ 
    表明 $mu_(i k)(x_i) = 0$，证毕
= 16
    == (1)
      先证明正向极限满足该性质
      + 先给出 $alpha$ 的存在性，考虑如下的交换图表：
        #align(center)[#commutative-diagram(
        node((0, 0), $M_i$, "1"),
        node((0, 1), $N$, "2"),
        node((1, 0), $dirSum M_i$, "3"),
        node((1, 1), $M = M quo D$, "4"),
        arr("1", "2", $alpha_i$),
        arr("1", "3", $l_i$),
        arr("4", "2", $exists_2 alpha$),
        arr("3", "4", $mu$),
        arr("3", "2", $exists_1 beta$, label-pos: right),
        arr("1", "4", $mu_i$, label-pos: left),
        ) 
        ]
        其中 $l, mu$ 是自然的嵌入与商映射
        + $beta$ 来源于 $alpha_i$ 提升至 $dirSum M_i$，也即：
          $
          funcDef(beta, dirSum M_i, N, (x_i), sum_i alpha_i (x_i))
          $
        + $alpha$ 来源于 $beta$ 在商模上的诱导，为此，需要证明：
          $
          beta|_D = 0
          $
          只需验证：
          $
          beta(x_i - mu_(i j)(x_i)) = alpha_i (x_i) - alpha_j (mu_(i j)(x_i)) = 0
          $
        这就给出了 $alpha$ 存在，同时：
        $
        alpha mu_i = alpha (mu l_i) = (alpha mu) l_i =beta l_i = alpha_i
        $
        证毕
      + 再证明唯一性，如果有两个 $alpha, alpha'$ 满足该性质，则：
        $
        alpha_i = alpha mu_i = alpha' mu_i => (alpha - alpha') mu_i = 0, forall i in I
        $
        前面证明了 $M$ 中元素均形如 $mu_i (x_i)$，因此上式说明了 $(alpha - alpha')(m) = 0, forall m in M => alpha = alpha'$，证毕
    == (2)
      设模 $M'$ 满足该性质，我们来证明它与正向极限同构\
      条件是交换图表：
      #align(center)[
      #commutative-diagram(
      node((0, 0), $M_i$, "1"),
      node((0, 1), $N$, "2"),
      node((1, 0), $M'$, "3"),
      arr("1", "2", $alpha_i$),
      arr("3", "2", $exists ! alpha$),
      arr("1", "3", $nu_i$),)
      ]
      在这里取 $N = M, alpha_i = mu_i$，可以得到：
        #align(center)[
        #commutative-diagram(
        node((0, 0), $M_i$, "1"),
        node((0, 1), $M$, "2"),
        node((1, 0), $M'$, "3"),
        arr("1", "2", $mu_i$),
        arr("3", "2", $exists ! alpha$),
        arr("1", "3", $nu_i$),)
        ]
      反过来，在 $M$ 满足的性质中，取 $N = M', alpha_i = nu_i$ 可得：
      #align(center)[
        #commutative-diagram(
        node((0, 0), $M_i$, "1"),
        node((0, 1), $M'$, "2"),
        node((1, 0), $M$, "3"),
        arr("1", "2", $nu_i$),
        arr("3", "2", $exists ! beta$),
        arr("1", "3", $mu_i$),)
        ]
      计算：
      $
      nu_i = beta mu_i\
      mu_i = alpha nu_i = alpha beta mu_i, forall i in I\
      $
      同时，再次利用 $dirSum_(i in I) im(mu_i) = M$，上式即给出 $alpha beta = id$\
      类似的，我们希望证明 $beta alpha = id$，显然可以同理得到 $nu_i = beta alpha nu_i$，只需要证明：
      $
      dirSum_(i in I) im(nu_i) = M'
      $
      为此，在 $M'$ 的性质中取 $N = M' quo dirSum_i im(nu_i)$，当然就有：
      #align(center)[
        #commutative-diagram(
        node((0, 0), $M_i$, "1"),
        node((0, 1), $M' quo dirSum_i im(nu_i)$, "2"),
        node((1, 1), $M' quo dirSum_i im(nu_i)$, "4"),
        node((1, 0), $M'$, "3"),
        arr("1", "2", $overline(nu_i) = 0$),
        arr("3", "2", $exists ! f$),
        arr("1", "3", $nu_i$),
        arr("3", "4", $pi$),
        arr("4", "2", $g$),
        )
        ]
      这里 $pi$ 是自然同态\
      然而注意到商模上任何一个自同态 $g$ 反过来都可以生成符合上图的 $f$，因此商模只能有一个自同态，进而 $dirSum_i im(nu_i) = M'$，证毕
      // 事实上由唯一性，当然有 $beta' = beta|_(dirSum_i im(nu_i))$\
      // 有：
      // $
      // nu_i = beta' mu_i = beta' alpha nu_i \
      // $
= 17
  验证 $sum M_i$ 满足上面的泛性质，也即：
  #align(center)[
      #commutative-diagram(
      node((0, 0), $M_i$, "1"),
      node((0, 1), $N$, "2"),
      node((1, 0), $sum M_i$, "3"),
      arr("1", "2", $alpha_i$),
      arr("3", "2", $exists ! alpha$),
      arr("1", "3", $nu_i$),)
      ]
  这里的 $nu_i$ 取自然的嵌入，同时对 $j >= i$，用 $mu_(i j)$ 记嵌入，这些同态当然满足相容性条件
  - 先证明存在性，定义：
    $
    funcDef(alpha, sum M_i, N, sum_(i in L) m_i, sum_(i in L) alpha_i (m_i))
    $
    这里的 $alpha$ 是有限集\
    -  先证明它是良定义的，为此，设：
      $
      sum_(i in L) m_i = sum_(i in L') m'_i
      $
      由于这里的 $L, L'$ 都有限，可以找到它们的一个公共上界 $k$，继而：
      $
      sum_(i in L) alpha_i (m_i) = sum_(i in L) alpha_(k)(mu_(i k) (m_i)) = alpha_k (sum_(i in L) mu_(i k) (m_i))\
      sum_(i in L') alpha_i (m_i) = alpha_k (sum_(i in L') mu_(i k) (m'_i))
      $
      类似之前的操作，取 $mu_k : dirSum_((i, j) in L times L') M_i + M_j -> M_k$，上两式写成：
      $
      sum_(i in L) alpha_i (m_i) = alpha_k (sum_(i in L) mu_(k) (m_i)) = (alpha_k compose mu_k)(sum_(i in L) m_i)\
      sum_(i in L') alpha_i (m_i) = alpha_k (sum_(i in L') mu_(k) (m'_i)) = (alpha_k compose mu_k)(sum_(i in L') m'_i)
      $
      从而两式相等，定义是一致的
    - 它是模同态是容易验证的
    - 由定义，$alpha_i (nu_i (m_i)) = alpha_i (m_i)$ 是理所应当的
  - 再证明唯一性，同样注意到：
    $
    dirSum_i (im nu_i) = sum M_i
    $      
    因此 $alpha_i = alpha nu_i = alpha' nu_i => (alpha - alpha') nu_i = 0, forall i in I => alpha = alpha'$
  - 最后证明 $union.big M_i = sum M_i$，事实上只要利用正向极限的性质，对于任意 $m in  sum M_i$，都存在某个 $i,  x_i$ 使得：
    $
    nu_i (x_i) = m => m in union.big M_i
    $
    这就表明 $sum M_i subset union.big M_i$，另一侧是显然的
= 18
  #let phi = $phi.alt$
  #align(center)[#commutative-diagram(
  node((0, 0), $M_i$, "1"),
  node((0, 1), $N_i$, "2"),
  node((1, 0), $M$, "3"),
  node((1, 1), $N$, "4"),
  arr("1", "2", $phi_i$),
  arr("1", "3", $mu_i$),
  arr("2", "4", $nu_i$),
  arr("3", "4", $exists !phi$),
  arr("1", "4", $nu_i phi_i$)
  
  )]
  这里的唯一存在性利用上面证明的泛性质，只需验证 $nu_i phi_i$ 的相容性，也即：
  $
  nu_j phi_j mu_(i j) = nu_j nu_(i j) phi_i = nu_i phi_i 
  $
  证毕
= 19
  条件给出了
  #align(center)[#commutative-diagram(
  node((0, 0), $M_i$, "1"),
  node((0, 1), $N_i$, "2"),
  node((0, 2), $P_i$, "3"),
  node((1, 0), $M$, "4"),
  node((1, 1), $N$, "5"),
  node((1, 2), $P$, "6"),
  arr("1", "2", $f_i$),
  arr("2", "3", $g_i$),
  arr("1", "4", $x_i$),
  arr("2", "5", $y_i$),
  arr("3", "6", $z_i$),
  arr("4", "5", $f$),
  arr("5", "6", $g$),
  
  )]
  且上方是正合列，也即：
  $
  im f_i = ker g_i
  $
  利用之前证明的性质，有：
  $
  M = union.big_i im(x_i)\
  N = union.big_i im(y_i)\
  P = union.big_i im(z_i)
  $
  \
  #lemmaLinear[][
    $
    ker g = union_i y_i (ker g_i)
    $
  ]
  #proof[
    $
    ker g &= union.big_i ker g inter y_i (N_i)\
          &= union.big_i {y_i (n_i) | n_i in N_i and g(y_i (n_i)) = 0}\
          &= union.big_i y_i  ({n_i | n_i in N_i and z_i (g (n_i)) = 0})\
          &= union.big_i y_i  (ker z_i g_i)
    $
    任取 $n_i in ker z_i g_i$
    -  $n_i in ker g_i => y_i (n_i) in y_i (ker g_i)$
    - 或者 $g_i (n_i) := p_i in ker z_i$，而前面证明了：
      $
      z_i (p_i) = 0 => exists j >= i, z_(i j) (p_i) = 0\
      0 = z_(i j) (g_i (n_i)) = g_j (y_(i j) (n_i))
      $
      因此：
      $
      y_(i j) (n_i) in ker g_j\
      y_i (n_i) = y_j (y_(i j) (n_i)) in y_j (ker g_j)
      $
      给出了 $y_i (n_i) in y_j (ker g_j)$
    综上两者，有：
    $
    union.big_i y_i  (ker z_i g_i) subset union.big_i y_i  (ker g_i)\
    $
    而另一侧由 $ker g_i subset ker z_i g_i$ 是显然的，进而原式成立
  ]
  进而有：
  $
  im f &= f(M) \
  &= f(union.big_i im(x_i)) \
  &= f(union.big_i x_i (M_i)) \
  &= union.big_i f(x_i (M_i)) \
  &=  union.big_i y_i (f_i (M_i)) \
  &= union.big_i y_i (im f_i) \
  &= union.big_i y_i (ker g_i)\
  &= ker g
  $
  证毕
= 21
  // 注意到正向极限被定义为一个商模，要使它保留环结构，需要证明：
  // - $plus.circle_(i) A_i $ 是环，这当然成立
  // - ${x_i - mu_(i j)| forall j >= i}$ 的生成模：
  //   $
  //   I := plus.circle_((i, j) in I times I, j >= i) ZZ (x_i - mu_(i j) (x_i))
  //   $
  //   也是理想，加法子群已经保证，对于乘法，只要验证任取 $a_k in A_k$：
  //   $
  //   a_k (plus.circle_((i, j) in I times I, j >= i) ZZ (x_i - mu_(i j) (x_i)))\
  //   = plus.circle_((i, j) in I times I, j >= i) ZZ (a_k (x_i - mu_(i j) (x_i)))\
  //   = ZZ a_k x_k - plus.circle_(i in I, i <= k) a_k ZZ  mu_(i k)(x_i)\
  //   $
  //   注意到上式是直和，因此后项本质只有有限项，故可以将前项分配到后项，取 $s$ 是所有项的一个上界，有
  //   $
  //   subset plus.circle_(i in I, i <= k) ZZ  (a_k x_k - a_k mu_(i k)(x_i))\
  //   subset I + plus.circle_(i in I, i <= k) ZZ  (mu_(s k)(a_k x_k) - mu_(i k)(a_k x_i))\
  //   subset I + plus.circle_(i in I, i <= k) ZZ  (a_k mu_(s k)(x_k)) subset I
  //   $
  为了证明正向极限有环结构，需要定义乘法。注意到 $M$ 中元素均形如 $mu_i (x_i)$，而对任何两个元素总可以找到更大的指标 $i$ 包括两者，因此将乘法定义为：
  $
  mu_i (x) dot mu_i (y) = mu_i (x dot y)
  $
  - 验证其良定义性，注意到：
    $
    mu_i (x) dot mu_i (y) := mu_i (x dot y)\
    $
    设 $x', y' in A_i$ 使得：
    $
    mu_i (x) = mu_j (x')\
    mu_i (y) = mu_j (y')\
    mu_j (x') dot mu_j (y') := mu_j (x' dot y')\
    $
    找到 $k$ 是两者的某个公共上界，有：
    $
    mu_(i)(x dot y) = mu_k (mu_(i k)(x dot y)) = mu_k (mu_(i k)(x) dot mu_(i k)(y))\
    mu_(j) (x' dot y') = mu_k (mu_(j k)(x' dot y')) = mu_k (mu_(j k)(x') dot mu_(j k)(y'))\
    $
    为了使上式成立，注意到：
    $
    0 = mu_i (x) - mu_j (x') = mu_k (mu_(i k)(x) - mu_(j k) (x'))
    $
    由正向极限的性质，这意味着当 $k$ 充分大时有：
    $
    mu_(i k)(x) - mu_(j k) (x') = 0
    $
    另一个等式也是类似的，因此乘法是良定义的
  - 其余乘法的性质是容易验证的
  进一步，我们还要验证 $mu_i$ 是环同态，由定义这是自明的

  对于第二个性质，注意到 $A = 0$ 意味着：
  $
  mu_1(1) = 0
  $
  从而对于充分大的 $k$，有：
  $
  1 = mu_(1 k)(1) = 0
  $
  换言之 $A_k = 0$
= 22
  #let DLimit = math.limits(math.attach(math.lim, b: math.arrow.long), inline: true)
  $
  &mu_i (x_i) in Re(DLimit_i A_i)\
  &<=> exists n in NN, (mu_i (x_i))^n = 0 = mu_i (x_i^n)\
  &<=> exists n in NN, j >= i, mu_(i j) (x_i^n) = 0\
  &<=> exists j >= i, mu_(i j) (x_i) in Re(A_j) = Re_j\
  &<=> exists j >= i, mu_(i) (x_i) = mu_j (mu_(i j) (x_i) ) in DLimit_i Re_i\
  &<=> mu_(i) (x_i) in DLimit_i Re_i\
  $
  证毕

  对于第二个性质，注意到若 $A_i$ 都是整环，则幂零根恰为 $(0)$，进而 $ DLimit_i A_i $ 的幂零根也是 $(0)$，从而是整环
        
