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
p222 17 18 20 23\*\
p 223 21
p 263 1 2 4\*

= p222
  == 17
    熟知：
    $
      hbeta = Inv(tMul(X)) X^T Y\
      var(hbeta) = Inv(tMul(X)) X^T var(Y) X Inv(tMul(X))\
      = sigma^2 Inv(tMul(X))\
      = sigma^2 Inv(mat(n, sum_i x_i; sum_i x_i, sum_i x_i^2))\
      = sigma^2/(n sum_i x_i^2 - (sum_i x_i)^2) mat(sum_i x_i^2, -sum_i x_i; -sum_i x_i, n)\
      = sigma^2/(n (sum_i (x_i - xbar)^2)) mat(sum_i x_i^2, -sum_i x_i; -sum_i x_i, n)\
    $
    因此结论成立。

    熟知 $RSS/sigma^2 tilde chi^2(n - 2)$, 当 $beta_0 = 0$ 时应有：
    $
      hbeta_0 tilde N(0, (sigma^2 sum_i x_i^2 )/(n sum_i (x_i - xbar)^2))\
      1/sigma sqrt(n sum_i (x_i - xbar)^2)/sqrt(sum_i x_i^2) hbeta_0 tilde N(0, 1)\
    $
    考虑：
    $
      T = (1/sigma sqrt(n sum_i (x_i - xbar)^2)/sqrt(sum_i x_i^2) hbeta_0) / (sqrt((RSS / sigma^2) / (n - 2) ))\
      = (sqrt(n sum_i (x_i - xbar)^2)/sqrt(sum_i x_i^2) hbeta_0) / (sqrt(RSS / (n - 2) ))
    $
    它形如 $N(0, 1) / sqrt((chi^2 (k)) / k)$，同时，熟知 $hbeta, RSS$ 独立，因此 $T tilde t(n - 2)$
  == 18
    #let beta1(data_x, data_y) = calcCov(data_x, data_y) / calcBiasSquareSum(data_x)
    #let beta0(data_x, data_y) = calcMean(data_y) - beta1(data_x, data_y) * calcMean(data_x)
    #let data_x = (2, 4, 6, 8, 10)
    #let data_y = (64, 138, 205, 285, 360)
    #let beta1_c = beta1(data_x, data_y)
    #let beta0_c = beta0(data_x, data_y)
    #let calcRSS = data_y.zip(data_x).map(yx => 
      {
        let (y, x) = yx
        calc.pow(y - (beta0_c + beta1_c * x), 2)
      }).sum()
    
    #let Tv = (calc.sqrt((5 * calcBiasSquareSum(data_x))/calc.sqrt(calcSquareSum(data_x))) * beta0_c) / calc.sqrt(calcRSS / 3)
    计算得：
    $
      T = #Tv
    $
    检查 $t$ 分布表显然应该拒绝假设
  == 20
    #let data_x = range(0, 13).map(i => i / 2 + 37)
    #let data_y = (3.4, 3, 3, 3.27, 2.1, 1.83, 1.53, 1.7, 1.8, 1.9, 2.35, 2.54, 2.9)
    #canvas(
    {
      plot.plot(
        size: (15, 10),
        // x-tick-step: 0.5,
        {
          plot.add(
            data_x.zip(data_y),
            mark: "o",
            style: (
              stroke: none,
              )
            )
        },
        )
      }
    )
    观察可得，$y$ 接近于 $x$ 的二次函数。
  == 21
    #let data_x = (180, 104, 134, 141, 204, 150, 121, 151, 147, 145, 141, 144, 190, 190, 161, 165, 154, 116, 123, 151, 110, 108, 158, 107, 180, 127, 115, 191, 190, 153, 155, 177, 177, 143)
    #let data_y = (200, 100, 135, 125, 235, 170, 125, 135, 155, 165, 135, 160, 190, 210, 145, 195, 150, 100, 110, 180, 130, 110, 130, 115, 240, 145, 120, 205, 220, 145, 160, 185, 205, 160)
    #canvas(
    {
      plot.plot(
        size: (15, 10),
        // x-tick-step: 0.5,
        {
          plot.add(
            data_x.zip(data_y),
            mark: "o",
            style: (
              stroke: none,
              )
            )
        },
        )
      }
    )
    猜测 $y, x$ 之间有线性关系，计算得：
    #let beta1(data_x, data_y) = calcCov(data_x, data_y) / calcBiasSquareSum(data_x)
    #let beta0(data_x, data_y) = calcMean(data_y) - beta1(data_x, data_y) * calcMean(data_x)
    #let beta1_c = beta1(data_x, data_y)
    #let beta0_c = beta0(data_x, data_y)
    #let calcRSS = data_y.zip(data_x).map(yx => 
      {
        let (y, x) = yx
        calc.pow(y - (beta0_c + beta1_c * x), 2)
      }).sum()
    
    #let Tv = (calc.sqrt((5 * calcBiasSquareSum(data_x))/calc.sqrt(calcSquareSum(data_x))) * beta0_c) / calc.sqrt(calcRSS / 3)
    $
      hbeta_0 = #beta0_c\
      hbeta_1 = #beta1_c\
      RSS / (n - 2) = #(calcRSS / (data_x.len() - 2))\
      T = #Tv
    $

    查表得应该拒绝假设，认为有线性关系。对于 $x_0 = 145$，有：
    #let hy_0c = beta0_c + beta1_c * 145
    #let d_c = 1 + 1/data_x.len() + calc.pow(145 - calcMean(data_x), 2)/calcBiasSquareSum(data_x)
    $
      hy_0 = #hy_0c\
      d = #d_c\
    $
    并取 $lambda$ 使得：
    $
      P_(x tilde t(32)) (abs(x) > lambda) = 0.05\
      lambda = 2.0369
    $
    最终的置信区间为：
    #let delta_y0 = 2.0369 * calc.sqrt(d_c * (calcRSS / (data_x.len() - 2)))
    $
      [#(hy_0c - delta_y0), #(hy_0c + delta_y0)]
    $
    对于控制问题，取 $lambda$ 使得：
    $
      P_(x tilde t(32)) (x > lambda) = 0.05\
      lambda = 1.6939
    $
    只要：
    #let hy_0u = (240 - 1.6939 * calc.sqrt(d_c * (calcRSS / (data_x.len() - 2))))
    $
      hy_0 + lambda sqrt(d (RSS / (n - 2))) < 240\
      hy_0 < #hy_0u\
      x_0 < #((hy_0u - beta0_c) / beta1_c)
    $
    即可在 $95%$ 置信度下满足要求。
= p263
  == 1
    #let data = (
      (4.1, 4.8, 4.1, 4.9, 5.7),
      (6.1, 5.7, 5.4, 7.2, 6.4),
      (4.5, 4.8, 4.8, 5.1, 5.6)
    )
    #let one_wat_anova(data) = {
      let s = data.len()
      let r = data.at(0).len()
      let ybar_total = calcMean(data.sum())
      let ybar_each = data.map(calcMean)
      let S_e = data.map(calcBiasSquareSum).sum()
      let S_A = r * ybar_each.map(
        ybar_i => calc.pow(ybar_i - ybar_total, 2)
      ).sum()
      let S_T = S_e + S_A
      let F = (
        (S_A / (s - 1))
        / 
        (S_e / (s * (r - 1)))
      )
      (S_T, S_e, S_A, F)
    }
    #let (S_T, S_e, S_A, F) = one_wat_anova(data)
    计算得：
    $
      F = #F
    $
    而 $F tilde F(2, 12)$，查表得应该拒绝原假设，认为有显著差异。
  == 2
    使用相关软件包计算得，$x, y, x y$ 的 $p-$ 值分别为 $0.002, 10^(-6), 0.14$，因此在 $alpha = 0.05$ 下，认为交互作用没有显著影响，两个因素都有显著影响。

