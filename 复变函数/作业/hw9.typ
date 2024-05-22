#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
（应交日期为 5 月 24 日）
= p150
  == 5
    设 $B(z, r) subset G$，则有 $overline(B(z, r/2)) subset G$，由内闭一致收敛可得 $f_n|_(overline(B(z, r/2)))$ 一致收敛于 $f | _(overline(B(z, r/2)))$，由分析学的熟知结论可得 $f_n (z_n) -> f(z)$
  == 6
    任取紧集 $X subset G$，往证 $f_n$ 在 $X$ 上一致收敛即可。如若不然，根据一致收敛的判别法和紧集知存在点列 $z_n -> z_0$ 使得：
    $
    f_n (z_n)
    $
    不收敛于 $f(z_0)$\
    由于 $f$ 是连续函数，可设 $forall epsilon > 0, exists delta > 0$ 使得：
    $
    abs(z - z_0) < delta => abs(f(z) - f(z_0)) < epsilon
    $
    无妨假设 $forall n in NN, abs(z_n - z_0) < delta$，进而有：
    $
    forall n in NN, abs(f(z_n) - f(z_0)) < epsilon
    $<eq3>
    由 $z_0$ 处的点收敛，无妨设：
    $
    forall n, abs(f_n (z_0) - f(z_0)) < epsilon
    $<eq4>
    再由 $f_1$ 的连续性，同样可无妨设 $forall n$ 均有：
    $
    abs(f_1 (z_n) - f_1 (z_0)) < epsilon
    $<eq5>
    如此将有：
    $
    abs(f_n (z_n) - f(z_0)) 
    &<= abs(f_n (z_n) - f (z_n)) + abs(f(z_n) - f(z_0)) \
    &= (f (z_n) - f_n (z_n)) + abs(f(z_n) - f(z_0))\
    &< f (z_n) - f_n (z_n) + epsilon\
    &< f(z_n) - f_1 (z_n) + epsilon\
    &= f(z_n) - f(z_0) + f(z_0) - f_1 (z_0) + f_1 (z_0) - f_1 (z_n) + epsilon\
    $
    分别利用@eq3, @eq4, @eq5 可得上式 $< 4 epsilon$，矛盾！
  == 7
      #lemmaLinear[][
        设 $X$ 是度量空间, $S$ 在其中正规（任何序列都有收敛子列）, $x_n in S$ 的所有收敛子列有公共的极限，则 $x_n$ 收敛
      ]
      #proof[
        设公共极限为 $x$，若 $x_n$ 不收敛于 $x$ 则可找到子列使得 $exists epsilon > 0$：
        $
        d(x_(n_i), x) > epsilon
        $
        然而 $x_(n_i)$ 还有收敛子列，该子列也是 $x_n$ 的子列，由题设可知该子列收敛于 $x$，与上式显然矛盾！
      ]
      首先，由 $forall z > 0, lim f_n (z)$ 存在可有限可得 ${f_n} (z)$ 有界，当然有紧的闭包，再由等度连续可知 ${f_n}$ 正规。根据条件 $lim f_n (z) = f(z), forall z$ 不难验证 $f_n$ 的所有收敛子列的极限只能为 $f$，当然由引理可知 $f_n -> f$
= p217
  == 4
    条件表明：
    $
    f_n|_(D_n sect D_(n-1)) = f_(n-1)|_(D_n sect D_(n-1))
    $
    既然 $D_n sect D_(n-1)$ 是开集，当然就有：
    $
    f'_n|_(D_n sect D_(n-1)) = f'_(n-1)|_(D_n sect D_(n-1))
    $
    表明当然这也是 $f'$ 的解析延拓
= p221  
  == 3
    若某个 $R_(t, u) = infinity$，则可将其延拓至整函数 $f$，从而所有 $f_(t, u)$ 都是 $f$ 的限制，进而所有 $R_(t, u)$ 都是 $infinity$，因此下设 $R_(t, u) < infinity$

    任取 $t_0, u_0$，可以找到 $gamma_(u_0) (t_0)$ 的开邻域 $B$ 使得 $B subset D_(t_0, u_0)$ 且 $f$ 可在 $B$ 上幂级数展开。任取 $(t_1, u_1) in B$，在 $gamma_(u_1) (t_1)$ 处的展开至少在 $B$ 内都收敛，也即：
    $
    R(t_1, u_1) >= R(t_0, u_0) - d(gamma_(u_0) (t_0), gamma_(u_1) (t_1))
    $
    同理可以得到另一个方向，进而：
    $
    abs(R(t_1, u_1) - R(t_0, u_0)) <= d(gamma_(u_0) (t_0), gamma_(u_1) (t_1))
    $
    由 $Gamma$ 的连续性，$u_1, t_1$ 靠近 $u_0, t_0$ 时上式右侧趋于零，左侧也趋于零，证毕