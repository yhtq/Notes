#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业10",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= p154
  == 4
    由条件知 ${f_n}$ 是正规族，因此有收敛子列。只需证明任意收敛子列都收敛于 $f$ 即可。注意到题中所述性质对子列也成立，不妨就设 $f_n -> f'$，性质表明 $A = {z in G | f' = f}$ 有聚点，且 $f, f'$ 都是解析函数，进而 $f' = f$，证毕！
  == 7
    往证 $g compose FF$ 局部有界。任取 $z in G$，由 $FF$ 正规知局部有界，进而存在 $r, M$ 使得：
    $
    norm(f(B(z, r))) subset [0, M], forall f in FF
    $
    上式表明 $f(B(z, r))$ 是有界集，由条件 $g$ 将在其上有界 $M'$，也即：
    $
    norm((g compose f) (B(z, r))) subset [0, M'], forall f in FF
    $
    这就表明 $g compose FF$ 局部有界，证毕！
= p163
  == 1
    用反证法，假设 $w in.not diff Q$，则 $w in Q$ 是内点。无妨设 $w in overline(B(w, delta)) subset Omega$，并设 $f(z_n) in B(w, delta)$\
    由上述假设知：
    $
    z_n in Inv(f)(overline(B(w, delta)))
    $
    上式右端是含于 $Omega$ 的闭集，这将导致 $z_n$ 的极限必须含于 $Inv(f)(overline(B(w, delta))) subset Omega$，与条件矛盾！
  == 4
    考虑：
    $
    f(z) = (1 + z)/(1 - z)
    $
    它把 $B(0, 1)$ 映成右半平面，把上半圆盘映成第一象限。
    - $e^(pi/2 i) z$ 给出右半圆盘到上半圆盘的解析同胚
    - $f(z)$ 给出上半圆盘到第一象限的解析同胚
    - $z^2$ 给出第一象限到右半平面的解析同胚（不难验证是单射）
    - $Inv(f) (z)$ 给出右半圆盘到圆盘的解析同胚
    四者复合即得所求
  == 9
    - 先用：
      $
      h_1 (z) = (1-z)/(z + 1)
      $
      把 $G$ 映成右半平面除去 $1$
    - 可以在右半平面中取对数 $ln$，将右半平面映成 ${z | Re z > 0, Im z subset [0, 2 pi i)}$，将右半平面除去 $1$ 映成 ${z | Re z > 0, Im z subset [0, 2 pi i)} - {e}$
    - 在上面的区域取 $e^(-z)$，将上面的区域映成 $B(0, 1) - {0, e^(-e)}$
    - 以上步骤都是单射，最后，令：
      $
      f(z) = integral_0^z w(w - e^(-e)) dif w = z^3/3 - 1/2 e^(-e) z^2
      $
      不难发现 $f'(z)$ 在 $B(0, 1) - {0, e^(-e)}$ 非零，同时：
      $
      f(z) = f(z_0) <=> z^3/3 - 1/2 e^(-e) z^2 = z_0^3/3 - 1/2 e^(-e) z_0^2\
      <=> (z - z_0)(z^2 + z z_0 + z_0^2 - 1/2 e^(-e)(z + z_0)) = 0\
      <=> (z - z_0)(z^2 + (z_0 -1/2 e^(-e))z  + z_0^2 - 1/2 e^(-e) z_0) = 0\
      $
      对 $z_0 = 0, e^(-e)$ 均可验证上式在 $B(0, 1) - {0, e^(-e)}$ 中还有一根，进而：
      $
      f(B(0, 1) - {0, e^(-e)}) = f(B(0, 1))
      $
      而 $f(B(0, 1))$ 是单连通区域，利用 Riemann 映射定理，得证！