#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
应交时间为 4月17日
#set heading(numbering: none)
= 4.1
  == p133 1
    利用 p27 习题3，对于任意 $x_0 in RR$, 该方程过 $(x_0,0 )$ 的解存在且唯一当且仅当题中瑕积分发散。反之，瑕积分收敛时，过该点存在除 $y = 0$ 之外的解，当然意味着 $y = 0$ 是奇解
  == 2
    不妨设 $f$ 可微\
    根据奇解存在的必要条件，有 $y = sin x$ 满足：
    $
    cases(
      y = x y' + f(y'),
      0 = x + der(f(y'), y')
    )
    $
    在二式中解出 $x$ 代回一式得：
    $
    y + der(f(y'), y') y' = f(y')\
    sin x + der(f(cos x), cos x) cos x = f (cos x) 
    $
    设 $f(cos x) = u cos x, der(f(cos x), cos x) = u + cos x der(u, cos x)$，有：
    $
    sin x + u cos x + cos^2 x der(u, cos x)  = u cos x\
    sin x + cos^2 x der(u, cos x)  = 0\
    dif u =  (sin^2 x)/(cos^2 x) dif x = tan^2 x dif x\
    u = integral tan^2 x dif x =  integral 1/(cos^2 x) -1 dif x = integral 1/(cos^2 x) dif x - x = tan x - x + C\
    f(cos x) = sin x - x cos x + C cos x\
    dif f(cos x) = (cos x - cos x + x sin x - C sin x) dif x = (x sin x - C sin x) dif x
    $
    此外，原方程中二式还表明：
    $
    der(f(cos x), cos x) = -x\
    dif f(cos x) = -x dif cos x = x sin x dif x \
    $
    从而原方程组有解 $y = sin x$ 当且仅当 $f(cos x) = integral x sin x dif x = sin x - x cos x $ \
    为了验证它是否是充分条件，计算：
    $
    (partial^2(y - x y' -f(y')))/(partial (y')^2)\
    = - f''(y') = - der(x , cos x) = -1/(sin x)
    $
    显然只要定义域合理（分母不为零）便有上式非零，而 $(partial F)/(partial y) = 1 != 0$，由充分条件知 $sin x != 0$，便有奇解成立

    例如，可取 $f(y') = sqrt(1-y'^2) - y' arccos y', y' in [-1, 1]$，当然 $y = sin x$ 只能是其在区间 $[0, pi]$ 上的解（当然，不难看出 $y = sin x$ 不可能是原方程在无穷区间上的解），在上面的计算中发现至少在 $(0, pi)$ 上奇解成立\
    更进一步，在 $0$ 处奇解也是成立的。事实上，原方程化为：
    $
    y = x y' + sqrt(1-y'^2) - y' arccos y'\
    $
    不难看出过点 $(0, 0)$，可以构造出不同于 $y = sin x$ 的解：
    $
    y = x - arccos 1 = x 
    $
    但在 $pi$ 处无法实现，因此对于给定的函数 $f, y = sin x$ 至少是 $[0, pi)$ 区间上的奇解
 = 4.3  
  == p139 1
    $
    y'^4 - y'^3 - y^2 y' + y^2 = 0\
    (1-y') y^2 = y'^3(1-y')
    $
    除去 $y' = 1$，化简得：
    $
    y^2 = y'^3\
    y' = (y)^(2/3)\
    $
    再除去 $y = 0$，得：
    $
    y^(-2/3) y' = 1\
    3 y^(1/3) = x + C\
    y = ((x + C)/3)^3
    $
    这就是所求通积分 $v(x, y, C) = y - ((x + C)/3)^3$

    为了计算包络，计算：
    $
    partialDer(v, c) = -((x+c)/3)^2 = 0
    $
    化简得 $y = 0$，不难验证 $y = 0$ 是包络（如果不考虑 $y' = 1$ 对应的一族解，如果考虑的话不存在包络）
  == 2
    === 1
      由定义，就是求曲线族的包络，联立：
      $
      cases(
        y = c x^2 - c^2,
        0 = x^2 - 2 c
      )
      $
      得 $c = x^2/2$ 代入 $1$ 式，得：
      $
      y = 2 c^2 - c^2 = c^2 = x^4/4
      $
      曲线 $y = x^4/4$ 交 $y = c x^2 - c^2$ 于 $plus.minus sqrt(2 c)$，并且可以验证都是相切的，因此确实是包络
    === 3
      联立：
      $
      cases(
        y = c(x-c)^2,
        0 = (x-c)^2 + 2c (c-x)
      )
      $
      计算得 $x - c = 0 或 3 c, y = 0 或 4 c^3$\
      容易验证两个解都满足非退化条件，都是包络
  == 3
    满足条件的直线为：
    $
    x/c + c y/a = 1\
    x/c - c y/a = 1\
    $
    所求曲线是上述直线族的包络。联立：
    $
    cases(
      x/c + c epsilon y/(2 a^2) = 1,
      -x^2/c + epsilon y/(2 a^2) = 0
    )
    $
    得 $c = (2 a^2 x^2)/(epsilon y)$，代入：
    $
    (epsilon y)/(2 a^2 x) + x^2 = 1\
    y = 1/epsilon 2 a^2 x (1- x^2)
    $
    其中 $epsilon = plus.minus 1$，因此：
    $
    y = plus.minus 2 a^2 x (1- x^2)
    $
    满足要求，当然两条曲线的任意拼接以及与直线的拼接也都符合要求，但应当去掉导数为 $0$ 的点
= 4.8
  == p151 3
      任取点列使得
      $
      y_n -> y_0, y_n > y_0\
      $
      注意到有积分方程：
      $
      phi(x, x_0, y_n) = y_n + integral_(x_0)^(x) f(s, phi(s, x_0, y_n)) dif s
      $
      因此这族关于 $x$ 的函数等度连续一致有界\
      只需证明它的所有一致收敛子列都收敛于 $phi(x, x_0, y_0)$ 不妨就设本身一致收敛，两边取极限将有：
      $
      lim_(n -> infinity) phi(x, x_0, y_n) = y_0 + integral_(x_0)^(x) f(s, lim_(n -> infinity) phi(x, x_0, y_n)) dif s
      $
      （还要利用 $f$ 一致连续/有界）\
      表明 $lim_(n -> infinity) phi(x, x_0, y_n)$ 是一个过 $(x_0, y_0)$ 的解，继而：
      $
      lim_(n -> infinity) phi(x, x_0, y_n) <= phi(x, x_0, y_0)
      $
      另一方面，断言 $epsilon$ 充分小时，有 $phi(x, x_0, y_0 + epsilon) >= phi(x, x_0, y_0)$，从而上式只能取等\
      事实上，设 $phi, psi$ 分别是微分方程过 $(x_0, y_0), (x_0, y_0 + epsilon)$ 的最大解，显然至少在 $x_0$ 的附近 $psi > phi$，断言 $psi >= phi$，否则设在某一段出现 $psi < phi$ 立刻与 $psi$ 是最大解矛盾！