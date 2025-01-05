#import "../../../template.typ": *
#show: note.with(
  title: "作业12",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 5.
  注意到 KTT 条件包含：
  $
    nabla f(x) - lambda^T nabla C(x) = 0\
    lambda^T nabla C(x) = nabla f(x)
  $
  题目给出 $nabla C(x)$ 满秩，当然以上线性方程的解唯一。
= 10.
  $
    L(x, lambda) = (x_1 - 1)^2 + (x_2 - 2)^2 - lambda ((x_1 - 1)^2 - 5 x_2)
  $
  求 KKT 条件：
  $
    cases(
      2 (1 - lambda) (x_1 - 1) = 0,
      2 (x_2 - 2) + 5 lambda = 0,
      (x_1 - 1)^2 - 5 x_2 = 0 
    )
  $
  - 若 $x_1 = 1$，则解得 $x_2 = 0, lambda = 4/5$，注意到：
    $
      nabla ((x_1 - 1)^2 - 5 x_2) (1, 0) = (0, -5)
    $
    因此线性化可行方向为 $(plus.minus 1, 0)$，它们都与梯度正交。进一步计算：
    $
      W^* = mat(2 - 2 lambda, 0;0, 2) = mat(2/5, 0;0, 2)
    $
    是正定矩阵，因此由二阶充分性条件这是一个局部极小点。
  - 若 $lambda = 1$，发现无解

  $
    L(x, lambda) = (x_1 + x_2)^2 + 2 x_1 + x_2^2 - lambda_1 (4 - x_1 - 3x_2) - lambda_2 (3 - 2 x_1 -x_2) - lambda_3 x_1 - lambda_4 x_2
  $
  $
  cases(
    2 (x_1 + x_2) + 2 + lambda_1 + 2 lambda_2 - lambda_3 = 0,
    2 (x_1 + x_2) + 2 x_2 + 3 lambda_1 + lambda_2 - lambda_4 = 0,
    lambda_1 (4 - x_1 - 3 x_2) = 0,
    lambda_2 (3 - 2 x_1 - x_2) = 0,
    lambda_3 x_1 = 0,
    lambda_4 x_2 = 0
  )
  $
  - 首先观察到若 $lambda = 0$，则 $x_1 = -2, x_1 = 1,$ 但不满足约束条件
  - 先设 $x_1 != 0, x_2 !=0$，有 $lambda_3 = lambda_4 = 0$
    - 假设 $lambda_1 = 0, lambda_2 != 0$，有：
      $
        cases(
          2 (x_1 + x_2) + 2 + 2 lambda_2 = 0,
          2 (x_1 + x_2) + 2 x_2 + lambda_2 = 0,
          3 - 2 x_1 - x_2 = 0
        )
      $
      计算得：
      $
        2 + 2 lambda_2 = lambda_2 + 2 x_2\
        lambda_2 = 2 x_2 - 2\
        2(x_1 + x_2) + 2 x_2 + 2 x_2 - 2 = 0\
        2 x_1 + 6x_2 - 2 = 0\
        x_1 + 3 x_2 - 1 = 0\
        2 x_1 + x_2 - 3 = 0\
        x_1 = 8/5, x_2 = -1/5
      $
      不满足约束！
    - 假设 $lambda_1 != 0, lambda_2 = 0$，有：
      $
        cases(
          2 (x_1 + x_2) + 2 + lambda_1 = 0,
          2 (x_1 + x_2) + 2 x_2 + 3 lambda_1 = 0,
          4 - x_1 - 3 x_2 = 0
        )
      $
      计算：
      $
        2 lambda_1 + 2 x_2 - 2 = 0\
        lambda_1 = 1 - x_2\
        2(x_1 + x_2) + 2 + 1 - x_2 = 0\
        2 x_1 + x_2 + 3 = 0\
        x_1 + 3x_2 - 4 = 0\
        x_1 = - 13/5, x_2 = 11/5
      $
      不满足约束！
    - 假设 $lambda_1 != 0, lambda_2 != 0$，有：
      $
        cases(
          2 (x_1 + x_2) + 2 + lambda_1 + 2 lambda_2 = 0,
          2 (x_1 + x_2) + 2 x_2 + 3 lambda_1 + lambda_2 = 0,
          4 - x_1 - 3 x_2 = 0,
          3 - 2 x_1 - x_2 = 0
        )
      $
      直接解得 $x_1 = x_2 = 1$，但它不是局部极小点，不难验证 $(-1, -1)$ 是可行的下降方向
  - $x_1 = 0$，此时不难解得 $x_2 = 0$ 时取极小，也是最小点
  - $x_2 = 0$ 时情形类似
= 11.
  $
    L(x) = x_1^2 + 4 x_2^2 + 16 x_3^2 - lambda c(x)
  $
  KKT 条件：
  $
    cases(
      2 x_1 - lambda partialDer(c(x), x_1) = 0,
      8 x_2 - lambda partialDer(c(x), x_2) = 0,
      32 x_3 - lambda partialDer(c(x), x_3) = 0,
      c(x) = 0
    )
  $
  == (1)
    条件变成：
    $
    cases(
      2 x_1 - lambda 1 = 0,
      8 x_2  = 0,
      32 x_3 = 0,
      x_1 - 1 = 0
    )
    $
    显然解为 $x_1 = 1, x_2 = x_3 = 0$，不难验证是最小值点
  == (2)
    条件变成：
    $
    cases(
      2 x_1 - lambda x_2 = 0,
      8 x_2 - lambda x_1 = 0,
      32 x_3 = 0,
      x_1 x_2 - 1 = 0
    )
    $
    计算：
    $
      16 x_1 x_2 = lambda^2 x_1 x_2\
      lambda^2 = 16\
      lambda = plus.minus 4
    $
    - 若 $lambda = 4$，则 $x_1 = 2 x_2$，得 $2 x_2^2 = 1, x_2 = plus.minus sqrt(2)/2, x_1 = plus.minus sqrt(2)$
    - 若 $lambda = -4$，则 $x_1 = -2 x_2$，得 $-2 x_2^2 = 1$ 无解！
    由于一对 KKT 点的函数值相等，而不难验证原问题最小值存在，因此两个点都是最小值点
  == (3)
    条件变成：
    $
    cases(
      2 x_1 - lambda x_2 x_3 = 0,
      8 x_2 - lambda x_1 x_3 = 0,
      32 x_3 - lambda x_1 x_2 = 0,
      x_1 x_2 x_3 - 1 = 0
    )
    $
    计算：
    $
      512 x_1 x_2 x_3 = lambda^3 (x_1 x_2 x_3)^2\
      lambda^3 = 512\
      lambda = 8\
      2/(x_2 x_3) = 8 x_2 x_3\
      x_1^2 = 4, x_2^2 x_3^2 = 1/4\
      8x_2 - 16 x_3 = 0\
      x_2 = 2 x_3\
      x_2^2 = 4 x_3^2 \
      x_3^2 = 1/4\
    $
    类似的找到若干函数值相等的最小值点