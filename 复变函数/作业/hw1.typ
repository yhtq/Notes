#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
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
（应交时间为3月8日）
#set heading(numbering: none)
= p4 Ex. 3
  从几何意义上看：
  $
  | z - a | - | z + a | = 2 c
  $
  就是到复平面上 $a, -a$ 两点的距离之差等于 $2c$ 的点的轨迹。这个轨迹是双曲线的一支
= p6 Ex. 7
  不妨设 $z != 0$，否则结论显然\
  设 $z = r(cos theta + i sin theta), r > 0, theta in [-pi, pi)$，由题设，有：
  $
  cos (n theta) >= 0, forall n in NN
  $
  这表明：
  $
  theta in [-pi/2, pi/2)
  =>& 2 theta in [-pi, pi) and cos (2 theta) >= 0\
  =>& 2 theta in [-pi/2, pi/2)\
  =>& theta in [-pi/4, pi/4)\
  =>& 4 theta in [-pi, pi) and cos (4 theta) >= 0\
  =>& 4 theta in [-pi/2, pi/2)\
  =>& theta in [-pi/8, pi/8)\
  =>& ...\
  =>& 2^n theta in [-pi, pi) and cos (2^n theta) >= 0\
  =>& 2^n theta in [-pi/2, pi/2)\
  =>& theta in [-pi/2^n, pi/2^n)
  $
  显然，这表明 $theta = 0$，进而 $z = r$ 是正实数
= p17 Ex. 5
  取定 $a, epsilon$，记所有满足：
  $
  exists z_0 = a, z_1, z_2, ..., z_n = y "满足":\
  | z_(k+1) - z_k | < epsilon, k = 0, 1, 2, ..., n-1
  $
  的 $y$ 构成的集合为 $S$，断言：
  + $S$ 是（$F$ 中的）开集。事实上，任取 $y in S$，我们有：
    - $forall y' in B(y, epsilon) sect F$
      - $y in S => exists z_0 = x, z_1, ..., z_n = y, | z_(k+1) - z_k | < epsilon, k = 0, 1, 2, ..., n-1$
        - $|y' - y| < epsilon => exists z'_0 = x, z'_1 = z_1, ..., z'_n = y, z'_(n+1) = y':$
          $
          | z'_(k+1) - z'_k | < epsilon, k = 0, 1, 2, ..., n
          $\
          $=> y' in S$
    表明 $B(y, epsilon) sect F subset S$
  + $S$ 是（$F$ 中的）闭集。为此，任取 $y_n in S, y_n -> y in F$，只需证明 $y in S$\
    - $y_n -> y => exists i, |y_i - y| < epsilon$
      - $y_i in S => exists z_0 = x, z_1, ..., z_n = y_i:$
        $
        | z_(k+1) - z_k | < epsilon, k = 0, 1, 2, ..., n-1
        $
        - $|y - y_i| < epsilon => exists z'_0 = x, z'_1 = z_1, ..., z'_n = y_i, z'_(n+1) = y:$
          $
          | z'_(k+1) - z'_k | < epsilon, k = 0, 1, 2, ..., n
          $\
          $=> y in S$
  由 $F$ 连通及 $x in S$ 知 $F = S$，证毕。

  闭集的条件是不必要的，其上的证明并未用到 $F$ 是闭集的条件。\

  取 $S = {x + y i | y = 1/x or y = - 1/x, x > 0}$，它是不连通的闭集，但依旧满足结论（对于任何 $x, y in S$，它们在同一分支上时结论显然，在不同分支上时，不妨设 $x$ 在上半分支。对于任意小的 $epsilon$，可以将 $x -> (3/(epsilon), 1/3 epsilon) -> (3/(epsilon), - 1/3 epsilon) -> y$ 的链连接起来） 
= p20 Ex. 6
  + $R^n$ 上的所有非闭集的集合作为度量子空间都是不完备的
  + 任取 $RR -> RR$ 的连续单调函数（从而是单射） $f$：
    $
    d(x, y) = |f(x) - f(y)|
    $
    可以产生一个 $RR$ 上的度量。
    - 假如 $f(RR)$ 不是闭集，那么可以取得 $x_n, f(x_n) -> eta in.not f(RR)$，我们有：
      - $x_n$ 不收敛，否则 $x_n -> x => |f(x_n) - f(x)| -> 0 => f(x) = eta$ 矛盾
      - 当 $n, m$ 充分大时 $|f(x_n) - f(x_m)| < epsilon$，是柯西列
      因此该度量空间并不完备，可以取得很多这样的函数如 $e^x$
  + 在 $RR$ 上定义：
    $
    d(x, y) = cases(
      |arctan(x) - arctan(y)|\, x\, y in QQ or x\, y in.not QQ,
      pi "else"
    )
    $
    为了验证它是度量，只需验证三角不等式：
    - 若 $x, y, z$ 均处于情形 1，则显然
    - 否则，为了验证 $d(x, y) + d(y, z) >= d(x, z)$，考虑：
      - $d(x, z)$ 是情形 1，此时注意到情形 2 的距离严格大于情形 1 的距离，不等式一定成立
      - $d(x, z)$ 是情形 2，此时式子左侧一定有一项是情形 2（否则 $x, y, z$ 有相同的有理性），再结合度量的非负性结论正确
    同时，注意到 $arctan$ 在 $RR$ 上一致连续，因此通常度量下柯西的有理数列也是此度量下的柯西列。\
    此时，任取极限为无理数的有理序列，不难验证其为柯西列但不可能收敛
= p20 Ex. 8
  取 $R_n = {x_n, x_(n+1), ...}$，注意到：
  - $x_n$ 是柯西列蕴含 $diam(R_n) -> 0$
  - $x_n$ 有收敛子列蕴含所有的 $R_n$ 有公共聚点 $x$
  足以说明 $x_n -> x$ :
    - 事实上，任取 $epsilon > 0$，取得 $N$ 使得 $diam(R_N) < epsilon$
      - 再由 $x$ 是 $R_N$ 聚点，取 $x' in R_N$ 使得 $d(x', x) < epsilon$

        此时便有 $forall x_i in R_N, d(x_i, x) <= d(x_i, x') + d(x', x) <= 2 epsilon$，证毕




