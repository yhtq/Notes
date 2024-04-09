#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, seqLimit, seqLimitn
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#set heading(numbering: none)
（应交时间为4月12日）
= p80
  == 1
    对于任意 $r > R$，$norm(f(x)) <= M R, forall norm(x) = r$ 给出柯西估计：
    $
    norm(f^(n) (0)) <= n! (M r^n)/r^n = n! M
    $
    而 $f^(n) (0)$ 在有界闭区域上当然有界，因此是有界的整函数，继而是常数，得证
  == 3
    设 $f$ 满足要求，令 $g(z) = e^(-z) f(z)$，则 $g(z)$ 是整函数且 $g(RR) = {1}$\
    上式可以给出 $g$ 在 $0$ 处的任意阶导数为零，因此只能是 $1$，进而 $f = e^z$
  == 4
    设 $f(z, a) = e^(z + a)/(e^z e^a)$，则:
    $
    forall a in RR, z in RR, f(z, a) = 1
    $
    - 先设 $a in RR, g_a (z) := f(z, a)$，则 $g_a (RR) = {1}$，类似上面习题给出 $g_a = 1$
    - 对称的，$forall z in RR$ 均有 $f(z, a) = 1$
    - 对所有的 $a$，将有 $g_a (RR) = {1}$，同理可得 $g_a = 1$，这就完成了论证
  == 5
    假设 $overline(f) g$ 解析且 $g$ 不恒为零，此时注意到 $g$ 的零点集 $Z_g$ 是 $G$ 中离散的闭集，断言 $G - Z_g$ 仍是连通开集
    - 首先，注意到 $Z_g$ 在 $G$ 中没有聚点，因此当然 $G - Z_g$ 中每个点是 $G$ 的内点，也是 $G - Z_g$ 的内点
    - 其次，考虑到欧式空间中的开集连通等价于道路连通。而任取 $G$ 中一条道路，$Z_g$ 在其上的点至多有限个（否则在该道路上存在聚点，矛盾）,而开集中有限个离散点当然可以绕开，因此 $G - Z_g$ 也是道路连通的
    因此，$(overline(f) g)/g = overline(f)$ 是区域 $G - Z_g$ 上解析函数，继而：
    $
    "Re"(f) = (f + overline(f))/2
    $
    也是解析函数，然而它的值域只在 $RR$ 上，由之前的习题得它只能是常数。类似也可得 $"Im"(f)$ 也是常数，进而 $f$ 在 $G - Z_g$ 上是常数\
    同时，注意到 $G - Z_g$ 在 $G$ 中稠密，因此 $f$ 是常数
= p83
  == 1
    === a
      注意到 $integral_(gamma)^() = - integral_(-gamma)^()$，由定义知结论成立
    === b
      注意到 $integral_(gamma + sigma)^() = integral_(gamma)^() + integral_sigma$，由定义知结论成立