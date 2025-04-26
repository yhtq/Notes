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
    注意到：
    $
      phi_(C_1, C_2) = 1_(X > C_2 or X < C_1)
    $
    只要满足：
    $
      P_(X tilde chi^2(n - 1)) (C_2/sigma^2 <= X <= C_1/sigma^2) >= 1 - alpha 
    $
    则都是水平为 $alpha$ 的检验法。
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