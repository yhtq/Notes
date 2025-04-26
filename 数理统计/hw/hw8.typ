#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
P140 12 13 15 16\*
= 12
  == (1)
    这是单参数检验，由熟知结论 UMP 检验法为：
    $
      1_(S^2 > C)
    $
    其中：
    $
      P_(X tilde chi^2(n - 1)) (X > C / sigma^2) = alpha
    $
  == (2)
    这是单参数检验，由熟知结论 UMP 检验法为：
    $
      1_(S^2 < C)
    $
    其中：
    $
      P_(X tilde chi^2(n - 1)) (X < C / sigma^2) = alpha
    $
  == (3)
    假设该问题有 UMP 检验法 $phi$，依定义它也是前两问问题中的 UMP 检验法，然而注意到 UMP 检验法具有唯一性，而前两问给出的 UMP 检验法显然不是相同的，因此是荒谬的。
= 13
  这是单参数的检验问题
  $
    H_0 : mu = 15 
  $
  #let data = (14.7, 15.1, 14.8, 15.0, 15.2, 14.6)
  检验法为 $1_(abs(Z) < C)$，其中：
  $
    Z = (Xbar - 15)/(sqrt(1/6 dot 0.05))\
    P_(Z tilde N(0, 1) (abs(Z) < C) = 1 - alpha
  $
  查表得：
  $
    C = 1.96
  $
  计算得：
  $
    Z = #((calcMean(data) - 15)/calc.sqrt(0.05 / 6))\
  $
  因此不拒绝原假设
= 15
  这是单参数的检验问题，检验法为：
  $
    1_(Z < C)
  $
  其中：
  $
    Z = (Xbar - 10)/sqrt(1/4 dot 1)\
    P_(Z tilde N(0, 1)) (Z < C) = alpha = 0.1
  $
  查表得 $C = -1.3$

  $mu = 9$ 时，第二类错误概率为：
  $
    P_(Z tilde N(-1, 1)) (Z >= -1.3) = P_(Z tilde N(0, 1)) (Z >= -0.3)
  $
  因此功效为：
  $
    P_(Z tilde N(0, 1)) (Z < -0.3) = 0.38
  $

  $mu = 11$ 时，第一类错误概率为：
  $
    P_(Z tilde N(1, 1)) (Z < -1.3) = P_(Z tilde N(0, 1)) (Z < -2.3) = 0.01
  $
  
P141 17 18 20 24\*
= 17
  #let data = (
    99.3, 98.7, 100.5, 101.2, 98.3, 99.7, 99.5, 102.1, 100.5
  )
  这是未知方差的正态分布检验问题，假设为：
  $
    H_0 : mu = 100 <-> H_1 : mu != 100
  $
  熟知零假设成立时：
  $
    (Xbar - 100) / (sqrt(S^2 / n)) tilde t(n - 1)
  $
  计算得：
  $
    n = #(data.len())\
    Xbar = #calcMean(data)\
    S^2 = #calcSampleVariance(data)\
    (Xbar - 100) / (sqrt(S^2 / n)) = #((calcMean(data) - 100)/calc.sqrt(calc.pow(calcSampleVariance(data), 2)/data.len()))\
  $
  而检验法为 $1_(T > C or T < -C)$，其中 $C$ 满足：
  $
    P_(T tilde t(n - 1)) (T in [-C, C]) = 1 - alpha = 0.95
  $
  查表得 $C = 2.306$，因此不拒绝原假设。
= 18
  这是未知方差的正态分布检验问题，假设为：
  $
    H_0 : mu = 72 <-> H_1 : mu != 72
  $
  熟知零假设成立时：
  $
    (Xbar - 72) / (sqrt(S^2 / n)) tilde t(n - 1)
  $
  #let data = (
    54, 67, 68, 78, 70, 66, 67, 70, 65, 69
  )
  计算得：
  $
    n = #(data.len())\
    Xbar = #calcMean(data)\
    S^2 = #calcSampleVariance(data)\
    (Xbar - 72) / (sqrt(S^2 / n)) = #((calcMean(data) - 72)/calc.sqrt(calc.pow(calcSampleVariance(data), 2)/data.len()))\
  $
  而检验法为 $1_(T > C or T < -C)$，其中 $C$ 满足：
  $
    P_(T tilde t(n - 1)) (T in [-C, C]) = 1 - alpha = 0.95
  $
  查表得 $C = 2.262$，因此不拒绝原假设。
= 20
  这是未知方差的正态分布检验问题，假设为：
  $
    H_0 : mu >= 19 <-> H_1 : mu < 19 
  $
  熟知 $mu = 19$ 时：
  $
    (Xbar - 19) / (sqrt(S^2 / n)) tilde t(n - 1)
  $
  #let data = (
    22, 14, 17, 13, 21, 16, 15, 16, 19, 18
  )
  计算得：
  $
    n = #(data.len())\
    Xbar = #calcMean(data)\
    S^2 = #calcSampleVariance(data)\
    (Xbar - 19) / (sqrt(S^2 / n)) = #((calcMean(data) - 19)/calc.sqrt(calc.pow(calcSampleVariance(data), 2)/data.len()))\
  $
  而检验法为 $1_(T < C)$，其中 $C$ 满足：
  $
    P_(T tilde t(n - 1)) (T < C) = alpha = 0.05
  $
  查表得 $C = -3.25$，因此不拒绝零假设，没有充分理由认为新方法比旧方法好。
= 24
  #let data = (
    1.2, 2.4, 1.3, 1.3, 0, 1, 1.8, 0.8, 4.6, 1.4
  )
  计算甲对乙增加的睡眠时间之差为 $X_i$，这是未知方差的正态分布检验问题，假设为：
  $
    H_0 : mu = 0 <-> H_1 : mu != 0
  $
  熟知零假设成立时：
  $
    (Xbar - 0) / (sqrt(S^2 / n)) tilde t(n - 1)
  $
  计算得：
  $
    n = #(data.len())\
    Xbar = #calcMean(data)\
    S^2 = #calcSampleVariance(data)\
    (Xbar - 0) / (sqrt(S^2 / n)) = #((calcMean(data) - 0)/calc.sqrt(calc.pow(calcSampleVariance(data), 2)/data.len()))\
  $
  检验法为 $1_(T > C or T < -C)$，其中 $C$ 满足：
  $
    P_(T tilde t(n - 1)) (T in [-C, C]) = 1 - alpha = 0.95
  $
  查表得 $C = 2.262$，因此拒绝原假设，认为有显著差异。