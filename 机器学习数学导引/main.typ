#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "机器学习数学导引",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
)

= 前言
  - 教师：吴磊（leiwu\@math.pku.edu.cn）
  - 成绩：作业 40% + 大作业 60%（两到三人组）
  - 作业晚交一天扣 20%
  课程目的：提供有一定数学基础，综合的流行 ML 模型的介绍
  == 机器学习的目标
    抽象而言，一个 Learning Problem（有监督）就是给出一组数据 ${(x_i, y_i)}$，试图找到一个拟合函数使得 $y_i approx f(x_i)$
    。常见情形中，往往：
    - $y_i in RR$ ，此时称为回归问题（Regression）
    - $y_i$ 取离散值，此时称为分类问题（Classification）
    尽管往往我们可以认为 $x_i$ 在某个 $d$ 维的欧式空间，但此时 $d$ 可能相当大，例如对于一个 $244 times 244 times 3$ 的图片，$d = #(244 * 244 * 3)$。区分传统机器学习和现代机器学习的一个重要特征就是维度，传统的机器学习往往处理的是低维数据，而现代机器学习则处理高维数据。

    通常而言，$f(x)$ 被分成两部分：
    - 一个带有参数的表达式 $f(x; theta)$，这被称为*模型*，通常来自于人们的先验假设和设计
    - 一个确定参数的过程，这被称为*学习*，通常通过最小化一个损失函数来实现
    现代的机器学习通常是数据驱动的，也即模型的设计较为简单和通用，大部分信息来源于从数据拟合的参数；相对而言，传统的计算数学和传统机器学习往往是依赖于精心设计的模型。
  == 误差分解
    通常我们会将估计误差分为：
    $
    norm(f_(hat(theta)) - f^*) <= norm(f_(hat(theta)) - f_(hat(theta^*)) )+ norm(f_(hat(theta^*)) - f^*) 
    $
    其中：
    - $f^*$ 是真实函数
    - $f_(hat(theta))$ 是我们的估计函数
    - $f_(hat(theta^*))$ 是最优估计函数
    - $norm(f_(hat(theta)) - f_(hat(theta^*)) )$ 通常称为 estimation error，来自于我们只有有限的数据，没有找到最优参数
    - $norm(f_(hat(theta^*)) - f^*)$ 通常称为 approximation error，来自于我们的模型假设能表达的所有函数与真实函数的差距
    通常而言，增大模型规模可以一定程度降低 approximation error，但可能会增大 estimation error
  == 泛化与维度灾难
    通过训练集得到的近似函数在训练集之外往往一定程度上有效，这被称为泛化。泛化的成立根本上依赖于问题本身具有的某些良好性质，例如连续性，可微性等等。然而随着提供的训练数据在高维空间中迅速变得稀疏，这些简单直观的性质提供的泛化能力往往会在维度升高时迅速衰减，这被称为维度灾难（curse of dimensionality）。
= 传统机器学习  
  == 线性回归
    #let hR = $hat(cal(R))$
    使用线性函数：
    $
    f_i (x) = beta^T x + beta_0
    $
    拟合目标函数，通常称 $beta$ 为权重，$beta_0$ 为偏置(bias)。也可简写成：
    $
    f_i (x) = (beta^T, beta_0) vec(x, 1)
    $
    定义均方误差：
    $
    hR_n (beta) = 1/n sum_(j=1)^n 1/2 (beta^T x_j - y_j)^2 = 1/(2 n) norm(vec(x_1^T, dots.v, x_n^T) beta - y)
    $
    #algorithm[OLS 普通最小二乘][
      求解：
      $
      0 = nabla hR_n (beta)
      $
      得到：
      $
      1/n sum_(j=1)^n (beta^T x_j - y_j) x_j &= 0\
      sum_(j=1)^n (beta^T x_j) x_j &= sum_(j=1)^n y_j x_j\
      sum_(j=1)^n  x_j (beta^T x_j) &= sum_(j=1)^n y_j x_j\
      sum_(j=1)^n x_j x_j^T beta &= (x_1, ..., x_n) y\
      (sum_(j=1)^n x_j x_j^T) beta &= (x_1, ..., x_n) y\
      (x_1, ..., x_n) vec(x_1^T, dots.v, x_n^T)  beta &= (x_1, ..., x_n) y\
      $
      记 $X = vec(x_1^T, dots.v, x_n^T)$，上式化为：
      $
      X^T X beta = X^T y
      $
      假设 $X$ 满秩，则上式有唯一解：
      $
      hat(beta) = (X^T X)^(-1) X^T y
      $
      否则，需要找到一个最优解。例如许多时候我们希望找到一个最小范数的解，这被称为 Ridge Regression，也就是求解以下问题：
      $
      min_(beta in RR^d) norm(beta) \
      s.t. X beta = y
      $
      其中 $n < d, X in RR^(n times d) "满秩", y in RR^n$，此时可以解得解析解：
      $
      hb = X^T (X X^T)^(-1) by
      $
      #proof[
        由条件，方程显然有解。设 $bbeta = X^T bu + bv$，代入方程有：
        $
        X (X^T bu + bv) &= by\
        bu &= (X X^T)^(-1) (by - X bv)\
        norm(bbeta)^2 &= (bu^T X + bv^T)(X^T bu + bv)\
        &= bu^T X X^T bu + bu^T X bv + bv^T X^T bu + bv^T bv\
        &= (by^T - bv^T X^T)(X X^T)^(-1)(by - X bv) + (by^T - bv^T X^T) (X X^T)^(-1) X bv + bv^T X^T (X X^T)^(-1) (by - X bv) + bv^T bv\
        &= bv^T (I -  X^T (X X^T)^(-1) X) bv + by^T (X X^T)^(-1) by
        $
        #lemmaLinear[][
          $I -  X^T (X X^T)^(-1) X$ 是半正定矩阵
        ]
        #proof[
          令 $P = X^T (X X^T)^(-1) X$，注意到：
          - $P^2 = P$
          - $P = P^T$
          因此：
          $
          (I - P)^2 = I - 2P + P^2 = I - P\
          x^T (I - P) x = x^T (I - P)^2 x = x^T (I -P)^T (I - P) x = norm((I- P) x) >= 0
          $
        ]
        由引理，显然上式取得最小值当且仅当 $bv = 0$，此时 $bbeta = x^T (X X^T)^(-1) by$
      ]
    ]
    #example[][
      通常情况下数据是有噪声的，这时需要采用正则化方法，例如：
      - Ridge Regression：$min_(beta) sum_(i=1)^n (y_i - beta^T x_i)^2 + lambda norm(beta)_2^2$
      - Lasso Regression：$min_(beta) sum_(i=1)^n (y_i - beta^T x_i)^2 + lambda norm(beta)_1^2$，往往用于参数非常稀疏时
    ]
  #pagebreak()
= 现代机器学习（深度学习）
  #pagebreak()
= 理论基础
  #pagebreak()