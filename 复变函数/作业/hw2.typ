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
（应交时间为3月15日）
= p24 Ex. 6
  设集合 $S$ 完全有界，也即任取 $epsilon > 0$存在有限个 $x_i$，满足：
  $
  S subset union.big_i B(x_i, 1/2 epsilon)
  $
  两侧取闭包，立得：
  $
  overline(S) subset union.big_i overline(B(x_i, 1/2 epsilon)) subset union.big_i B(x_i, epsilon)
  $
  由 $epsilon$ 的任意性命题得证
= p28
  == Ex. 4
    设 $f， g$ Lipschitz 连续，也即满足：
    $
    d(f(x), f(y)) <= M_1 d(x, y), forall x, y \
    d(g(x), g(y)) <= M_2 d(x, y), forall x, y \
    $
    则任取 $x, y$，将有：
    $
    d(g(f(x)), g(f(y))) <= M_2 d(f(x), f(y)) <= M_1 M_2 d(x, y)
    $
    表明 $g(f(x))$ Lipschitz 连续

    设 $f, g$ 一致连续，对任意 $epsilon >0, exists delta_2 > 0$ 使得：
    $
    d(g(x), g(y)) <= epsilon, forall x, y, d(x, y) < delta_2\
    $
    再对 $delta_2$ 利用 $f$ 的一致连续性，存在 $delta_1 > 0$ 使得：
    $
    d(f(x), f(y)) <= delta_2, forall x, y, d(x, y) < delta_1\
    $
    两式结合便有：
    $
    d(g(f(x)), g(f(y))) <= epsilon, forall x, y, d(x, y) < delta_1
    $
    得证 $g(f(x))$ 一致连续
  == Ex. 8
    任取 $epsilon > 0$，对每个 $x in X$，由连续性可以找到一个开邻域 $U_x$ 使得：
    $
    diam(f(U_x)) <= epsilon
    $
    $E := {U_x}_(x in X)$ 构成 $X$ 的开覆盖，由 Lebesgue's Covering Lemma（注意到度量空间中紧致等价于列紧），存在 $delta > 0$ 使得：
    $
    forall x in X, exists e in E: B(x, delta) in e 
    $
    由 $E$ 的构造，这表明：
    $
    forall x in X, exists e in E: diam(B(x, delta)) < epsilon 
    $
    显然将有：
    $
    d(f(x), f(y)) <= epsilon, forall x, y, d(x, y) < delta
    $
    得证
= p29 Ex. 1
  任取 $epsilon > 0$，由一致收敛性，存在 $ n in NN$ 使得：
  $
  d(f(x), f_n (x)) < 1/3 epsilon, forall x in X
  $
  注意到 $f_n (x)$ 一致连续，因此存在 $delta > 0$ 使得：
  $
  d(f_n (x), f_n (y)) < 1/3 epsilon, forall x, y, d(x, y) < delta
  $
  从而：
  $
  forall x, y, d(x, y) < delta:\
    d(f(x), f(y)) <= d(f(x), f_n (x)) + d(f_n (x), f_n (y)) + d(f_n (y), f(y)) \
    < 1/3 epsilon + 1/3 epsilon + 1/3 epsilon = epsilon
  $
  得证 $f$ 一致连续

  对于第二个结论，记 $sup{f(x) - g(x) | x in X} := norm(f - g)$\
  $forall n in NN^+$, 注意到 $f_n (x)$ Lipschitz 连续，因此：
  $
  d(f_n (x), f_n (y)) < M_n d(x, y), forall x, y
  $
  从而：
  $
  forall x, y:\
    d(f(x), f(y)) <= d(f(x), f_n (x)) + d(f_n (x), f_n (y)) + d(f_n (y), f(y)) \
    < M_n d(x, y) + 2 norm(f_n - f)
  $
  注意到上式左侧与 $n$ 无关，因此有：
  $
  d(f(x), f(y)) <= limsup_(n -> +infinity ) (M_n d(x, y) + 2 norm(f_n - f)) = (limsup_(n -> +infinity ) M_n) d(x, y)  
  $
  由条件 $0< limsup_(n -> +infinity ) M_n < +infinity$ 知结论成立

  考虑 $f_n (x) = sqrt(x + 1/n), x in [0, 1], f(x) = sqrt(x)$，有：
  $
  norm(f(x) - f_n (x)) = norm(sqrt(x+ 1/n) - sqrt(x)) = 1/n 1/norm(sqrt(x+ 1/n) + sqrt(x)) <= 1/n sqrt(n) = 1/sqrt(n) -> 0
  $
  因此 $f_n (x)$ 一致收敛于 $f(x)$\
  此外，计算得：
  $
  f'_n (x) = 1/(2 sqrt(x + 1/n)) <= 1/2 sqrt(n)
  $
  因此每个 $f_n (x)$ 都是 Lipschitz 连续的，但 :
  $
  f'(x) = 1/(2 sqrt(x)) -> + infinity (x -> 0)
  $
  因此不是 Lipschitz 连续的
= p44 Ex. 14
  首先断言 $forall z in G, f'(z) = 0$，事实上，在：
  $
  f'(z) = lim_(h -> 0) (f(a+h) - f(a))/h
  $
  中：
  - 取 $h = Delta in RR$，显然上式右侧总是实数，继而 $"Im"(f'(z)) = 0$
  - 取 $h = Delta i, Delta in RR$，显然上式右侧实部总为零，继而 $"Re"(f'(z)) = 0$
  表明 $f'(z) = 0$\
  利用书上命题2.10 可得 $f$ 是常函数