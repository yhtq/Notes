#import "../../../template.typ": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#set par(first-line-indent: 0pt)
#let factorial(n: int) = range(1, n + 1).product(default: 1)
= 4.
  #let xs = range(5).map(i => calc.pi * i / 8)
  #let ys = xs.map(x => calc.sin(x))

  选取插值点为：

  #xs.map(str).join(",")

  函数值为：

  #ys.map(str).join(", ")

  #let laugrange(f, x) = {
    let res = 0.0
    for xi in xs{
      let l = 1
      for xj in xs{
        if xj != xi{
          l *= (x - xj) / (xi - xj)
        }
      }
      res += l * f(xi)
    }
    res
  }
  误差界为：
  $
    abs(R(x)) = abs((f^(5) (xi))/5! product_(i = 1)^5 (x - x_i)) = abs((cos xi)/5! product_(i = 1)^5 (x - x_i)) <= 1/5! product_(i = 1)^5 abs(x - x_i)
  $
  #let laugrange_err(x) = 1 / factorial(n: 5) * xs.map(xi => calc.abs(x - xi)).product()
  #let test_point = range(10).map(i => i * 3 / 20)
  选取测试点为：

  #test_point.map(str).join(", ")\
  计算误差界分别为：

  #test_point.map(x => laugrange_err(x)).map(str).join(", ")

  实际误差为：

  #test_point.map(x => calc.abs(laugrange(calc.sin, x) - calc.sin(x))).map(str).join(", ")

  可见误差界比较准确。要使最大误差小于 $10^(-10)$，注意到：
  $
    abs(R(x)) <= 1/(n+1)! product_(i = 0)^(n) abs(x - x_i) <= 1/(n+1)! (pi/2)^(n+1)\
  $
  最大误差为：\

  #range(10, 20).map(i => 1/factorial(n: i) * calc.pow(calc.pi / 2, i)).enumerate(
  ).map(xs => 
    {
      let (i, x) = xs
      (i + 10, x)
    }
  )
  可见选取 $n = 16$ 足以
= 5.
  不能。考虑以下四点：
  $
    (-2, 1), (-1, 0), (1, 0), (2, 2)
  $
  注意到分段二次多项式的导数是分段线性函数。因此容易验证假设满足条件的分段插值多项式存在，则其导数为线性的。\
  结合数据点特征，可设 $f'(x) = a x$，再结合 $f(x)$ 的连续性， $f(x)$ 就是二次函数。然而容易验证不存在二次函数通过以上四点。

  一般的，若给定三点数据，则存在二次函数通过三点，此时取此二次函数便满足条件。
= 6.
  == (1)
    使用归纳法，$m = 0$ 时显然，一般的：
    $
      f[x_0, ..., x_m] &= (f[x_1, ..., x_m] - f[x_0, ..., x_(m-1)]) / (x_m - x_0)\
      &= (sum_(i = 1)^m (f(x_i) / (product_(j = 1, j != i)^m (x_i - x_j)) - sum_(i = 0)^(m-1) (f(x_i) / (product_(j = 0, j != i)^(m - 1) (x_i - x_j)))))/(x_m - x_0)\
      &= (f(x_m)/(product_(j = 1, j != i)^m (x_m - x_j)) - f(x_0)/(product_(j = 0, j != i)^(m-1) (x_0 - x_j)) + sum_(i = 1)^(m-1) (( (x_i - x_0) f(x_i) - (x_i - x_m) f(x_i)) / (product_(j = 0, j != i)^m (x_i - x_j))))/(x_m - x_0)\
      &= f(x_m)/(product_(j = 0, j != i)^m (x_m - x_j)) + f(x_0)/(product_(j = 0, j != i)^m (x_0 - x_j)) + sum_(i = 1)^(m-1) (f(x_i)) / (product_(j = 0, j != i)^m (x_i - x_j))\
      &= sum_(i = 0)^(m) (f(x_i)) / (product_(j = 0, j != i)^m (x_i - x_j))\
    $
  == (2)
    由 (1) 显然
  == (3)
    由 (2) 有：
    $
      f[x_0, ..., x_k, x_m] &= f[x_k, x_0, ..., x_(k-1), x_m] \
      &= (f[x_0, ..., x_(k-1), x_m] - f[x_k, x_0, ..., x_(k-1)])/(x_m - x_k)\
      &= (f[x_0, ..., x_(k-1), x_m] - f[x_0, ..., x_(k-1), x_k])/(x_m - x_k)
    $
  == (4)
    由余项的一致性，立刻得到：
    $
      (f^(n) (xi))/n! product_(i) (x_0 - x_i) = f[x_0, ..., x_n] product_i (x - x_i)  
    $
    显然插值点互不相同，因此结论显然
= 9.
  // 设三次多项式为：
  // $
  //   sum_(i = 0)^3 a_i x^i
  // $
  // 则方程组为：
  // $
  //   sum_(i = 0)^3 a_i x_k^i = f(x_k), k = 0, 1, 2\
  //   sum_(i = 1)^3 i a_i x_1^(i-1) = f'(x_1)\
  // $
  // 也即：
  // $
  //   mat(1, x_0, x_0^2, x_0^3; 1, x_1, x_1^2, x_1^3; 1, x_2, x_2^2, x_2^3;0, 1, 2 x_1, 3 x_1^2) vec(a_0, a_1, a_2, a_3) = vec(f(x_0), f(x_1), f(x_2), f'(x_1))
  // $
  我们希望取得 $h_i (x)$ 使得：
  $
    h_i (x_j) = delta_(i j) f(x_j)\
    h'_i (x_1) = delta_(i 1) f(x_1)
  $
  先取三点的 Lagrange 基：
  $
    l_i (x) = (product_(j = 0, j != i)^2 (x - x_j)) / (product_(j = 0, j != i)^2 (x_i - x_j))
  $
  计算：
  $
    l'_i (x_1) =  (2 x_1 - sum_(j = 0, j != i)^2 x_i)/(product_(j = 0, j != i)^2 (x_i - x_j))
  $
  再取：
  $
    r(x) = product_(j = 0)^2 (x - x_j)\
    r'(x_1) = (x_1 - x_2) (x_1 - x_3)
  $
  不妨设：
  $
    h_i (x) = f(x_i) l_i (x) + lambda_i r(x)
  $
  如此应有：
  $
    f(x_1) (2 x_1 - x_2 - x_3)/((x_1 - x_2)(x_1 - x_3)) + lambda_i (x_1 - x_2) (x_1 - x_3) = f'(x_1)\
    f(x_i) (2 x_1 - sum_(j = 0, j != i)^2 x_i)/(product_(j = 0, j != i)^2 (x_i - x_j)) + lambda_i (x_1 - x_2) (x_1 - x_3) = 0, i != 1
  $
  解出：
  $
    lambda_1 = (f'(x_1) - f(x_1) (2 x_1 - x_2 - x_3)/((x_1 - x_2)(x_1 - x_3)))/((x_1 - x_2) (x_1 - x_3))\
    lambda_i = -f(x_i) (2 x_1 - sum_(j = 0, j != i)^2 x_i)/(product_(j = 0, j != i)^2 (x_i - x_j)) / ((x_1 - x_2) (x_1 - x_3)), i != 1
  $
  于是就有：
  $
    P(x) = sum_(i=0)^2 f(x_i) l_i (x) + lambda_i r(x)
  $
  同时：
  $
    R(x) = f(x) - sum_(i=0)^2 (f(x_i) l_i (x) + lambda_i r(x)) = R(x) - (sum_(i=0)^2 lambda_i) r(x) = ((f^3 (xi))/3! - sum_(i=0)^2 lambda_i) r(x)  
  $
= 11.
  #let aa = $alpha$
  #let taa = $tilde(aa)$
  #let bb = $beta$
  #let tbb = $tilde(bb)$
  #let xd = $(x - x_i) (x - x_(i + 1))$
  #let xd0 = $x_(i + 1) - x_i$
  #let xdn = $x_i - x_(i + 1)$

  首先由导数条件，不妨设：
  $
    aa' = 3 a_1 xd, aa'' = 3 a_1 (2 x - x_i - x_(i + 1))
  $
  因此根据 $x = x_i$ 处泰勒公式，有：
  $
    aa = 1 + (3 a_1 (x_i - x_(i + 1)))/2 (x - x_i)^2 + a_1 (x - x_i)^3
  $
  带入 $aa(x_(i + 1)) = 0$ 有：
  $
    0 = 1 + (3 a_1 (x_i - x_(i + 1)))/2 (x_(i + 1) - x_i)^2 + a_1 (x_(i + 1) - x_i)^3\
    = a_1 (x_(i + 1) - x_i)^3 - 3/2 a_1 (x_(i + 1) - x_i)^3 + 1\
    a_1 (x_(i + 1) - x_i)^3 = 2\
    a_1 = 2/((x_(i + 1) - x_i)^3)
  $
  同时 $x = x_(i + 1)$ 处泰勒公式给出：
  $
    aa = (3 a_1 (x_(i + 1) - x_i))/2 (x - x_(i + 1))^2 + a_1 (x - x_(i + 1))^3 = 3 ((x - x_(i + 1))/xd0)^2 + 2 ((x - x_(i + 1))/xd0)^3\
    = ((x - x_(i + 1))/xdn)^2 (3 + 2 (x - x_(i + 1))/xd0) = ((x - x_(i + 1))/xdn)^2 (1 + 2 (x - x_(i))/xd0)
  $
  $taa$ 的表达式可以对称的得到。

  再考虑 $beta$，由零点条件不妨设：
  $
    beta = c (x - x_i) (x - x_(i + 1))^2\
    beta' = c((x - x_(i + 1))^2 + 2 (x - x_i) (x - x_(i + 1)))\
  $ 
  代入 $beta' (x_i) = 1$ 有：
  $
    1 = c (xdn)^2\
    c = 1/(xdn)^2
  $
  对称的可以得到 $tbb$ 的表达式。
= 16. 
  #let biT(i) = $b_#i^T$
  #let bi(i) = $b_#i$
  不难验证系数矩阵事实上形如：
  $
    H = (inner(b_i, b_j))_(i j)
  $
  换言之：
  $
    H = autoVecNF(biT, n) autoRVecNF(bi, n)
  $
  （这里 $b_i^T$ 是向量的对偶，考虑到 $P_k$ 是有限维向量空间）

  由 $autoRVecNF(bi, n)$ 满秩不难得到 $H$ 满秩，因此解存在唯一

  计算得对于 $k = 5, 6, 7$ 条件数分别为 $1.5 times 10^7, 4.8 times 10^8, 1.5 times 10^10$
