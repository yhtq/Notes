#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
p220 3 4 5 6\* 7 8 10 9\*
= 3
  一次式拟合是二次式拟合的子情况，当然残差平方和不会更小
= 4
  #let data_x = (18, 20, 22, 24, 26, 28, 30)
  #let data_y = (26.86, 28.35, 28.75, 28.87, 29.75, 30.00, 30.36)
  #let beta1(data_x, data_y) = calcCov(data_x, data_y) / calcBiasSquareSum(data_x)
  #let beta0(data_x, data_y) = calcMean(data_y) - beta1(data_x, data_y) * calcMean(data_x)
  计算得到，最小二乘估计为：
  $
    // beta_1 = #(beta1(data_x, data_y))\
    beta_1 = #calc.round(beta1(data_x, data_y), digits: 3)\
    beta_0 = #calc.round(beta0(data_x, data_y), digits: 3)
  $
  #canvas(
    {
      plot.plot(
        size: (15, 10),
        x-min: 15,
        x-max: 30,
        // x-tick-step: 0.5,
        {
          plot.add(
            data_x.zip(data_y),
            mark: "o",
            style: (
              stroke: none,
              )
            )
          plot.add(
            domain: (10, 30),
            (x => beta0(data_x, data_y) + beta1(data_x, data_y) * x),
          )
        },
      )
    }
  )
= 5
  相当于：
  $
    Y = mat(1, 0;2, -1;1, 2) vec(a, b) := X beta
  $
  最小二乘估计就是正规化方程：
  $
    X^T X beta = X^T Y
  $
  的解，计算：
  $
    X^T X = mat(6, 0;0, 5)\
    Inv(X^T X) = mat(1/6, 0;0, 1/5)\
    beta = Inv(X^T X) X^T Y = mat(1/6, 0;0, 1/5) mat(1, 2,1 ;0, -1, 2) Y = mat(1/6, 1/3, 1/6; 0, -1/5, 2/5) Y
  $
= 6
  相当于：
  $
    Y = (1, X, 3 X^2 - 2) beta + epsilon
  $
  最小二乘估计就是正规化方程：
  $
    (1, X, 3 X^2 - 2)^T (1, X, 3 X^2 - 2) beta = (1, X, 3 X^2 - 2)^T Y
  $
  的解：
  $
    beta = Inv(vec(1^T, X^T, 3 X^T^2 - 2) (1, X, 3 X^2 - 2))vec(1^T, X^T, 3 X^T^2 - 2) Y
  $
= 7
  #let data_x = (2, 4, 6, 8, 10)
  #let data_y = (64, 138, 205, 285, 360)
  #let beta1_c = beta1(data_x, data_y)
  #let beta0_c = beta0(data_x, data_y)
  计算得到，最小二乘估计为：
  $
    beta_1 = #calc.round(beta1_c, digits: 3)\
    beta_0 = #calc.round(beta0_c, digits: 3)
  $
  计算：
  #let Urss = {
    data_x.map(
      x => calc.pow(beta0_c + beta1_c * x - calcMean(data_y), 2)
    ).sum()
  }
  #let Qrss = {
    data_x.zip(data_y).map(
      x => {
        let (x, y) = x
        calc.pow(y - (beta0_c + beta1_c * x), 2)
      }
    ).sum()
  }
  $
    norm(hY - Ybar 1) = #Urss\
    norm(hY - Y) = #Qrss\
    F = (norm(hY - Ybar 1))/(norm(hY - Y) / (5 - 2)) = #calc.round(Urss / (Qrss / 3), digits: 3)\
  $
  假设成立时，$F tilde F_(1, 3)$，查表得应该拒绝原假设。
= 8
  新的相关系数为：
  $
    r = (sum_(i = 1)^400 X_1 (i) Y_1 (i) + sum_(i = 1)^600 X_2 (i) Y_2 (y) - 1000 Xbar Ybar) / (sqrt(sum_(i = 1)^400 X_1^2 (i) + sum_(i = 1)^600 X_2^2 (i) - 1000 Xbar^2) sqrt(sum_(i = 1)^400 Y_1^2 (i) + sum_(i = 1)^600 Y_2^2 (i) - 1000 Ybar^2))
  $
  其中：
  #let innerXY1 = 0.6 * (600 - 1) * 2 * 3 + 600 * 5 * 12
  #let innerXY2 = 0.7 * (400 - 1) * 3 * 4 + 400 * 7 * 10
  #let Xbarc = 0.6 * 5 + 0.4 * 7
  #let Ybarc = 0.6 * 12 + 0.4 * 10
  #let XX1 = (600 - 1) * calc.pow(2, 2) + 600 * calc.pow(5, 2)
  #let XX2 = (400 - 1) * calc.pow(3, 2) + 400 * calc.pow(7, 2)
  #let YY1 = (600 - 1) * calc.pow(3, 2) + 600 * calc.pow(12, 2) 
  #let YY2 = (400 - 1) * calc.pow(4, 2) + 400 * calc.pow(10, 2)
  $
    sum_(i = 1)^400 X_1 (i) Y_1 (i) = r_1 (600 - 1) S_x S_y + 600 Xbar_1 Ybar_1 = innerXY1\
    sum_(i = 1)^600 X_2 (i) Y_2 (i) = innerXY2\
    Xbar = 0.6 Xbar_1 + 0.4 Xbar_2 = Xbarc\
    Ybar = 0.6 Ybar_1 + 0.4 Ybar_2 = Ybarc\
    sum_(i = 1)^400 X_1^2 (i) = XX1\
    sum_(i = 1)^600 X_2^2 (i) = XX2\
    sum_(i = 1)^400 Y_1^2 (i) = YY1\
    sum_(i = 1)^600 Y_2^2 (i) = YY2\
  $
  最后得到：
  $
    r = #((innerXY1 + innerXY2 - 1000 * Xbarc * Ybarc) / (calc.sqrt(XX1 + XX2 - 1000 * calc.pow(Xbarc, 2)) * calc.sqrt(YY1 + YY2 - 1000 * calc.pow(Ybarc, 2))))\
  $
  确实比原来的相关系数更小。
= 9
  我们有：
  $
    1 + e^(a + b x) = L / y\
    a + b x = ln (L / y - 1)
  $
  #let data_x = range(60, 70)
  #let data_y_o = (18, 63, 294, 424, 834, 854, 904, 1054, 1054, 1054)
  #let data_y = data_y_o.map(y => calc.ln(1060 / y - 1))
  计算最小二乘估计为：
  $
    b = #calc.round(beta1(data_x, data_y), digits: 3)\
    a = #calc.round(beta0(data_x, data_y), digits: 3)
  $
  #let a_c = beta0(data_x, data_y)
  #let b_c = beta1(data_x, data_y)
  #canvas(
    {
      plot.plot(
        size: (15, 10),
        x-min: 60,
        x-max: 70,
        // x-tick-step: 0.5,
        {
          plot.add(
            data_x.zip(data_y_o),
            mark: "o",
            style: (
              stroke: none,
              )
            )
          plot.add(
            domain: (60, 70),
            (x => 1060 / (calc.exp(a_c + b_c * x) + 1)),
          )
        }
      )
    }
  )
= 10
  密度函数为：
  $
    NormalDisN(x, X beta, sigma^2 I, n) = (2 pi)^(-n/2) 1/sigma^n e^(-1/2 tMul(x - X beta)/sigma^2)
  $
  做最大似然估计，计算：
  $
    ln L = - n ln sigma -1/2 norm2(Y - X beta)/sigma^2 - n/2 ln (2 pi)
  $
  要使其最大化：
  - 对于 $beta$，就是要使 $norm2(Y - X beta)$ 最小，这就是最小二乘估计，就是正规化方程 $X^T X beta = X^T Y$ 的解
  - 对于 $sigma$，求导得：
    $
      partialDer(L, sigma) = - n/sigma + 1/sigma^3 norm2(Y - X beta) = 0\
      sigma^2 = 1/n norm2(Y - X beta)
    $