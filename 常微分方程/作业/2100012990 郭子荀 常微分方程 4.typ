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
