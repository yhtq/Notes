#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为3月12日）
#set heading(numbering: none)
= 19
  由于 $D(f)$ 构成拓扑基，显然所有非空开集相交当且仅当任两个拓扑基相交，因此只需考虑 $D(f)$ 的相交性，注意到：
  $
  D(f), D(g) != emptyset <=> f, g in.not N \
  D(f) inter D(g) != emptyset <=> D(f g) != emptyset \
  (D(f), D(g) != emptyset -> D(f) inter D(g) != emptyset) <=> (f, g in.not N -> f g in.not N) \
  $
  前式前者是说 $Spec(A)$ 不可约，后者是说幂零根是素理想，得证
= 20
  == i)
    任取 $overline(Y)$ 非空开集，记为：
    $
    A inter overline(Y),
    $
    其中 $A$ 是 $X$ 中开集\
    断言 $A inter Y$ 非空，否则有 $Y subset X - A => overline(Y) subset X - A => A inter overline(Y) = emptyset$\
    这表明 $A inter Y$ 在 $Y$ 中稠密，当然在 $overline(Y)$ 中稠密，进而 $A inter overline(Y)$ 也在 $overline(Y)$ 中稠密，得证
  == ii)
    取 $Y$ 是一个不可约子空间，试图利用 Zoun 引理，设：
    $
    Sigma = {Y' | Y subset Y', Y' "irreducible" }
    $
    并以包含作为偏序关系。设 $Sigma'$ 是 $Sigma$ 的全序子集，断言：
    $
    union.big Sigma' in Sigma
    $<claim>
    进而成为全序子集的上界，由 Zoun 引理即得极大元。\
    为了验证@claim，只需证明 $union.big Sigma'$ 不可约\
    -
      任取 $union.big Sigma'$ 中两个非空开集，记作：
      $
      A inter union.big Sigma', B inter union.big Sigma' != emptyset
      $
      其中 $A, B$ 是 $X$ 中开集\
      由上两式非空，可知：
      $
      exists Y_1, Y_2 in Sigma': A inter Y_1 != emptyset, B inter Y_2 != emptyset
      $
      但由于 $Sigma'$ 中有全序，必有 $Y_1 subset Y_2$ 或 $Y_2 subset Y_1$，不妨设前者成立，于是：
      $
      A inter Y_1 subset A inter Y_2 != emptyset
      $
      从而由 $Y_2$ 的不可约性：
      $
      A inter Y_2, B inter Y_2 != emptyset => (A inter Y_2) inter (B inter Y_2) != emptyset
      $
      因此：
      $
      (A inter Y_2) inter (B inter Y_2) subset (A inter union.big Sigma') inter (B inter union.big Sigma') != emptyset
      $
      得证
  == iii)
    设 $Y$ 是按上式给出的极大不可约子空间，由 $i)$ 知 $overline(Y)$ 也不可约，进而由极大性当然有 $Y = overline(Y)$ 也即 $Y$ 是闭集\
    此外，显然单点集是不可约的，因此每个点都包含在一个极大不可约子空间中\

    注意到 Hausdorff 空间中不同两点产生不交的开邻域，显然其中的不可约子空间只能是单点集
  ==  iv)
    首先，不难验证通过对应原理 $V(I)$ 与 $Spec(A quo I)$ 同胚，从而 $V(I)$ 不可约当且仅当 $sqrt(I)$ 是素理想\
    因此 $V(I) = V(sqrt(I))$ 是某个素理想的零点集，而这个素理想当然应该是极小的素理想
= 21
  #let phi = math.phi.alt
  == i)
    $
    p_y in phi^(*-1) (X_x) &<=> phi^(*)(p_y) in X_x\
    &<=> x in phi^*(p_y)\
    &<=> x in phi^(-1)(p_y)\
    &<=> phi(x) in p_y\
    &<=> p_y in Y_(phi(x))\
    $
    证毕
  == ii)
    $
    p_y in phi^(*-1) (V(alpha)) &<=> phi^(*)(p_y) in V(alpha)\
    &<=> alpha subset phi^*(p_y)\
    &<=> alpha subset phi^(-1)(p_y)\
    &<=> phi(alpha) subset p_y\
    &<=> p_y in V(phi(alpha))\
    &<=> p_y in V(phi(alpha) B)\
    $
  == iii)
    分别验证
    - $phi^*(V(b)) subset V(Inv(phi)(b))$\
      在上一问过程中可以发现
      $
      phi^(* -1)(V(Inv(phi)(b))) = V(phi(Inv(phi)(b))) supset V(b)\
      $
      表明：
      $
      phi^*(V(b)) subset phi^*(phi^(* -1)(V(Inv(phi)(b)))) subset V(Inv(phi)(b))
      $
    - $V(Inv(phi)(b))$ 是闭集：显然
    以上两者给出 $overline(phi^*(V(b))) subset V(Inv(phi)(b))$
    - 设 $phi^*(V(b)) subset V(x)$，验证 $V(Inv(phi)(b)) subset V(x)$，这将给出 $overline(phi^*(V(b))) supset V(Inv(phi)(b))$\
      事实上：
      $
      phi^*(V(b)) subset V(x) &=> forall p_y in Spec(B)(p_y supset b -> phi^*(p_y) supset x)\
      &=> forall p_y in Spec(B)(p_y supset b -> phi^(-1)(p_y) supset x)\
      $
      $
      phi^*(V(b)) subset V(x) &=> V(b) subset phi^(* -1)(V(x)) = V(phi(x))\
      &=> forall p_y in Spec(Y)(p_y supset b -> p_y supset phi(x))\
      $
      另一方面：
      $
      &V(Inv(phi)(b)) subset V(x) \
      &<=> forall p_x in Spec(X)(p_x supset Inv(phi)(b) -> p_x supset x)\
      &<=> forall p_x in Spec(X)((p_x supset Inv(phi)(b) and ker phi subset p_x) -> p_x supset x)\
      &arrow.l.double forall p_x in Spec(X)((p_x supset Inv(phi)(b) and phi(p_x) in Spec(B)) -> p_x supset x)\
      &arrow.l.double forall p_x in Spec(X)((p_x supset Inv(phi)(b) and phi(p_x) in Spec(B) and phi(p_x) supset b) -> p_x supset x)\
      &arrow.l.double forall p_x in Spec(X)((p_x supset Inv(phi)(b) and phi(p_x) in Spec(B) and phi(p_x) supset b) -> Inv(phi)(phi(p_x)) supset x )\
      &(ker phi subset p_x =>  p_x = Inv(phi)(phi(p_x)))\
      &arrow.l.double forall p_x in Spec(X)((phi(p_x) in Spec(B) and phi(p_x) supset b) -> Inv(phi)(phi(p_x)) supset x )\
      $
      这就是上面的条件，得证
  == iv)
    当 $phi$ 是满射时，类似上面的过程给出：
    $
    phi^(* -1)(V(Inv(phi)(b))) = V(phi(Inv(phi)(b))) = V(b)\
    phi^*(V(b)) = phi^*(phi^(* -1)(V(Inv(phi)(b)))) = V(Inv(phi)(b))
    $
    说明闭集的像仍是闭集\
    $V(ker phi)$ 自然同胚于 $X quo (ker phi)$，同时熟知满射 $phi$ 可诱导出一一映射 $phi' : X quo A -> B$，从而前面的事实足以说明 $phi'^*$ 是同胚
  == v)
    注意到：
    $
    overline(phi^*(Y)) = X <=>& overline(phi^*(V(Re_Y))) = X\
    <=>& V(Inv(phi)(Re_Y)) = X\
    <=>& Inv(phi)(Re_Y) = Re_X\
    <=>& {x in X| exists n in NN^+, x^n in ker phi} = {x in X| exists n in NN^+, x^n = 0}\
    <=>& ker phi = Re_X
    $
  == vi)
    $
    (psi compose phi)^(-1) = phi^(-1) compose psi^(-1)\
    $
    因此结论显然
  == vii)
    由题设，$Spec(A)$ 中仅有两个元素 $(0), p$，分别设：
    $
    pi_1 : B -> A quo p\
    pi_2 : B -> K
    $
    是投影映射\
    注意到 $p$ 是极大理想，因此 $A quo q$ 也是域\
    考虑 $B$ 的真理想 $I$ 显然有：
    $
    x, y != 0 => (x, y) in U(B) => (x, y) not in I\
    $
    这就意味着 $I$ 中所有元素必然有一个分量是零。同时显然必须是同一个分量，否则它们的和将不在 $I$ 中\
    因此 $I$ 只能是 $A quo p times {0}$ 或 ${0} times K$，显然这两个都是素理想\
    不难发现：
    $
    Inv(phi)({0} times K) = p\
    Inv(phi)(A quo p times {0}) = (0)
    $
    从而 $phi^*$ 是一一映射\
    然而注意到 $(0)$ 在 $Spec(A)$ 不是闭点（因为 $(0) subset p$），而 $Spec(B)$ 中两点都是极大理想/闭点，因此不同胚
= 22
  取 $phi_i: A -> A_i$ 是投影同态：
  - $phi_i^*: Spec(A_i) -> Spec(A)$ 给出一组嵌入，记 $phi_i^*(Spec(A_i)) := X_i$
  - 由于 $phi_i$ 是满射，上题结论给出 $X_i$ 都是闭集，且：
    $
    X_i tilde.eq Spec(A quo (ker phi_i)) tilde.eq Spec(A_i)
    $
  - $X_i$ 互相不交，事实上：
    $
    p in X_i => p = Inv(phi)(p_i), p_i in Spec(A_i)
    $
    因此：
    $
    p in X_i inter X_j => exists p_i in Spec(A_i), p_j in Spec(A_j), p = Inv(phi)(p_i) = Inv(phi)(p_j)
    $
    然而注意到 $i != j => A_i subset Inv(phi)(p_j), A_j subset Inv(phi)(p_i)$，这将给出：
    $
    A_i subset Inv(phi)(p_i)
    $
    显然是矛盾的
  - $union.big_i X_i = Spec(A)$\
    注意到 $A$ 的理想应当形如 $product_i I_i$，其中 $I_i$ 是 $A_i$ 的理想\
    （这是因为总可以先乘以 $(1, 0, 0, .., 0)$\
    设 $p$ 是素理想，取嵌入同态 $psi_i: A_i -> A$，则 $Inv(psi_i) (p) = p inter A_i := I_i$ 也是素理想或 $A_i$\
    往证其中只有至多一个分量上不是整个环，只需证明二维情形，高维情形用 $(1, 1, 0, 0..., 0)$ 覆盖即可\
    设 $p = a times b$ 是素理想，假设 $a, b$ 都是素理想（不是整个环），则可取：
    $
    x in.not a\
    y in.not b
    $
    此时：
    $
    (x, 0) dot (0, y) = (0, 0) in p
    $
    但上式左侧两项都不在 $p$ 内，矛盾！

    综上，$Spec(A)$ 中任何一个元素 $p$ 应当在至多一个分量上不是整个环，设为 $i$，当然就有 $p in X_i$，证毕
  - 注意到全空间是有限个闭集的不交并，取补集知它们也都是开集
  == i) $=>$ ii)
    由 $Spec(A)$ 不连通知存在两个不交开集 $X, Y$ 使得它们的并是全空间\
    显然它们也是闭集，可设其为 $V(x), V(y), x, y$ 是两个理想\
    - $emptyset = V(x) inter V(y) = V(x + y) => x + y = A$
    - $Spec(A) = V(x) union V(y) = V(x inter y) => x inter y = sqrt(0)$
    进而 $1 = a + b = a^2 + 2 a b + b^2, a in x, b in y$ 进而：
    $
    1 - 2 a b = a^2 + b^2\
    a = a^2 + a b\
    (a - a^2)^n = 0\
    a^n (1-a)^n = 0
    $
    由中国剩余定理：
    $
    R tilde.eq R quo ((a^n) (1-a)^n = 0) tilde.eq (R quo (a^n)) times (R quo (1-a)^n)
    $
  == ii) $=>$ iii)
    显然 $(1, 0)$ 即满足要求
  == iii) $=>$ ii)
    设 $e$ 是一个非平凡的幂等元，则 $1 - e$ 也是，同时 $e(1-e) = 0$ 给出：
    $
    R tilde.eq (R quo (e)) times (R quo (1 - e))
    $
  == ii) $=>$ i)
    上题的结论
= 26
  = i)
    设 $V = inter.big {Inv(f)(0) | f in m}$，它当然是闭集。假设它是空集，那么它的补集：
    $
    union.big {X - Inv(f)(0) | f in m} = X
    $
    上式左侧是若干开集的并，这意味着左侧是 $X$ 的一个开覆盖\
    由于 $X$ 是紧的，存在 $m$ 的有限子集 $m'$ 使得：
    $
    union.big {X - Inv(f)(0) | f in m'} = X
    $
    如此令 $g = sum_(f in m') f^2$，它将在整个 $X$ 上无零点，进而成为可逆元，但这与 $f^2 in m => g in m$ 矛盾
  == ii)
     对于 $x != y$，注意到紧的 Hausdoff 空间是 $T_4$ 的，可以使用 Urysohn's Lemma 找到 $f, g in C(X)$ 使得：
     $
     f(x) = g(y) = 0\
     f(y) = g(x) = 1
     $
     表明 $m_x != m_y$
  == iii)
    $
    m in mu(U_f) &<=> exists x in U_f, m = mu(x)\
    &<=> exists x in U_f, m = m_x = {g | g(x) = 0}\
    &<=> exists x in X, f(x) != 0 and m = {g | g(x) = 0}\
    &<=> f in.not m\
    $
    最后一式的 $arrow.l.double$ 是因为若 $f in.not m$ ，由 i) 可设 $m$ 形如 ${g | g(x_0) = 0}$，从而：
    $
    f(x_0) != 0 and m = {g | g(x_0) = 0}
    $

  