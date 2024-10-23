#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "机器学习数学导引",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
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
  == 分类问题
    回归问题中，目标函数的值域是连续的实数域。而在分类问题中，值域只是离散的点。理论上讲，我们的损失函数尽可能多的准确拟合目标，但在实际上我们往往使用代替的损失函数，使得该损失函数降低时，确实意味着拟合更准确。

    分类问题可以从概率和几何两个角度进行考虑，分别可以产生两类不同的损失函数：
    - 从概率角度，我们认为我们不是拟合函数，而是拟合一个值域上的概率分布。
      #definition[softmax][
        对于一个 $d$ 维的输入 $x$，我们希望输出一个 $k$ 维的概率分布 $p$，其中 $p_i = P(y = i | x)$，这被称为 softmax 函数：
        $
        p_i (x) = "softmax"(x)_i = (e^(x_i))/(sum_j e^(x^T beta_j))
        $
      ]
      由此，我们的优化目标变为：
      $
      min_theta 1/n sum_(i=1)^n d(S(f_theta (x_i)), e_(y_i))
      $<classfication-target>
      其中 $d$ 用于度量两个概率分布的距离。
      #example[KL divergence][
        通常我们使用 KL 散度来度量两个概率分布的距离：
        $
        D(p, q) = sum_i p_i log(p_i/q_i) = -sum_i p_j log q_j - (-sum_i p_i log p_i)
        $
        或者连续情形：
        $
        D(p, q) = integral_()^()   p(x) log(p(x)/q(x)) dif x
        $

        如果使用它作为 $d$，优化问题@classfication-target 恰好可以变形为：
        $
        max_theta 1/n sum_(i = 1)^n log F_(y_i) (x_i \; theta)
        $
        这事实上就是一种极大似然估计。
      ]
      #remark[Label Smoothing][
        有些分类问题中，类别的差异本身就很小。此时，我们可以对 label 进行平滑，替代原有的 one hot 分布，也即将：
        $
        (0, ..., 1,..., 0) -> (epsilon, ..., 1 - (n - 1) epsilon, epsilon)
        $
        之后再对@classfication-target 进行优化，可以让模型的输出更加平滑。
      ]
    - 从几何角度，就是希望找到超平面将两种数据分离开。假设我们使用超平面：
      $
      H = {x | beta^T x + beta_0 = 0}
      $
      并且假设 $norm(beta) = 1$。直觉上来说，我们希望点离超平面尽量远，因此可以设计优化问题：
      $
      max  (min_i abs(beta^T x_i + beta_0)) \
      s.t. space y_i(beta^T x_i + beta_0) >= 0
      $
      这个形式并不方便求解。我们利用常见的技巧，将其化为等价的优化问题：
      $
      max t with beta in S^(d-1), beta_0 in RR, t in RR, t >= 0\
      s.t. y_i (beta^T x_i + beta_0) >= t 
      $
      进一步的：
      $
      max t with beta in S^(d-1), beta_0 in RR, t in RR, t >= 0\
      s.t. y_i (beta^T/t x_i + beta_0/t) >= 1
      $
      令 $beta = beta/t, beta_0 = beta_0/t$，得到：
      $
      min norm(beta) with beta in RR^n, beta_0 in RR\
      s.t. y_i (beta^T x_i + beta_0) >= 1
      $
      事实上，这就是在所有能够充分拟合数据的参数选择中，选取最简单的模型。这个思想可以推广到非线性中：
      #algorithm[][
        设 $cal(F)$ 是函数空间，$Omega: cal(F) -> RR^+$ 是复杂度，我们往往使用下面的模型：
        $
        min Omega(f) s.t. f(x_i) y_i >= 1
        $
        这里的 $f(x) y$ 往往称为 confidence 或者 margin。
      ]
      这里我们使用的是硬约束，可以设计软约束的版本，称作 Soft-SVM:
      $
      min (norm(beta)^2 + 1/n sum_i xi_i) \
      s.t. y_i (beta^T x_i + beta_0) >= 1 - xi_i, \
      xi_i >= 0
      $
      以及相应的一般化版本：
      $
      min Omega(f) + 1/n sum_i xi_i\
      s.t. f(x_i) y_i >= 1 - xi_i, xi_i >= 0
      $
      化简一下，事实上就是：
      $
      min_f Omega(f) + 1/n sum_i max(0, 1 - y_i f(x_i))
      $
      某种意义上，上式后者就是一个损失函数，而前者是一个正则化项。\
      令：
      $
      l(z) = max(0, 1 - z)
      $
      往往将其称为 Hinge loss，它相当于在预测比较 confidence 时损失为零，否则施加线性的惩罚。不难看出，它是常见的 $0-1$ loss 的一个上界。

      推广而言，我们可以调整损失函数获得其他算法。注意在分类问题中，决定结果的往往只是那些接近边缘的点。
  == 无监督学习
    无监督学习往往包括以下问题：
    - density estimation：估计数据的分布，往往由于维数灾难难以在高维空间中进行
    - dimension reduction：将高维数据映射到低维空间，同时尽可能保留结构
    - clustering：将数据分成若干类，类似于无监督的分类问题
    #let hrho = $hat(rho)$
    #algorithm[Histogram][
      估计密度的一种简单方法是直方图法。将数据空间划分为若干个小区间，然后统计每个区间的数据点数目，用每个区间的数据点数目除以总数据点数目，就得到了密度的估计。这个方法比较通用，但不能很好的利用光滑性。
    ]
    #algorithm[Kernel density estimation，KDE][
      一种更加光滑的方法是核密度估计。设 $K$ 是一个核函数，定义：
      $
      hrho(x) = 1/n sum_i K_h (x - x_i)
      $
      其中 $K$ 是一个光滑函数，且满足：
      $
      K_h -> delta ("Kronecker")
      $
      并且：
      - $K(x) >= 0$
      - $integral_()^() K(x) dif x = 1$
      - $K(x) = K(-x)$
      常见的一维 $K(x)$ 包括：
      - $K(x) = bold(1) (x)$，类似于 Histogram
      - $K(x) = max (0, 1 - abs(x))$
      - $K(x) = 1/sqrt(2 pi) e^(- x^2 / 2) $
      高维的核函数往往只是通过将一维的核函数乘积得到。这种核函数称为各向同性的。
    ]
    #example[][
      步长 $h$ 的选择往往是只能手工进行的。以高斯核为例，有：
      $
      K_h (x) = 1/h^d sum_i K((x - x_i)/ h)
      $
      若 $h$ 取得很小，则模型会失去泛化能力。我们进行一些误差分析，假设 $x_i$ 独立同分布：
      $
      E(hrho(x) - rho(x)) &= 1/n sum_i E(K_h (x - x_i)) - rho(x)\
      &= E(K_h (x - X))  - rho(x)\
      &= 1/h^d E(K((x - X)/h))  - rho(x)\
      &= 1/h^d E(K((x - X)/h))  - rho(x)\
      &= 1/h^d integral_()^() k(z) rho(x - z h) dif z  - rho(x)\
      &= 1/h^d integral_()^() k(z) (rho(x - z h) - rho(x)) dif z \
      $
      对 $rho$ 做泰勒展开，注意到 $k$ 的对称性，其一阶项直接消掉，因此有上式 $<= C_1 h^2$ 且
      $
      C_1 <= norm(nabla^2 rho) integral_()^() k(z) norm(z)^2 dif z 
      $
      同时：
      $
      E(hrho(x) - rho(x))^2 = E(hrho(x) - E hrho(x) + E hrho(x) - rho(x))^2 \
      = (E (hrho(x) - rho(x)))^2 + E (hrho(x) - E hrho(x))^2\
      "Var" (hrho(x)) <= 1/n E(K_h^2 (x - x_i))\
      = 1/n integral_()^() 1/(h^(2 d)) K^2 ((x - x')/h) rho(x') dif x'\
      <= 1/n 1/h^d integral_()^() K^2 (z) rho(x - z h) dif z\ 
      $
    ]
    #algorithm[PCA][
      主成分分析是常见的降维方法。假设我们的数据 $x_i$ 大约在一个 $k$ 维子空间中，也即存在 $k$ 个正交基 $v_i$，使得 $x_i approx sum_j beta_(i j) v_j$。也即化成下面的优化问题：
      $
      min_(V, z_i, c) 1/n sum_i norm(x_i - V z_i - c)^2\
      $
      其中 $V$ 是一个正交矩阵，同时可不妨设 $sum z_i = 0$，先固定 $V$，求导计算可得：
      $
      c = 1/n sum_i x_i\
      V^T (x_i - V z_i - c) = 0 = V^T x_i - z_i -V^T c\
      z_i = V^T (x_i - c)
      $
      问题再化为：
      $
      min 1/n sum_i norm(x_i - V V^T (x_i - c) - c)^2
      $
      做中心化后：
      $
      min 1/n sum_i norm(x_i - V V^T x_i)^2 = min 1/n norm(X = X W W^T) \
      = 1/n tr (X^T X) - tr (X^T X W W^T)\
      = 1/n tr (X^T X) - tr (W^T X^T X W)
      $
      而令 $tr (W^T X^T X W)$ 最大的 $W$ 就是 $X^T X$ 的前 $k$ 大的特征值对应的特征向量。
    ]
    PCA 可以推广到一般的形式，也即对于矩阵 $X$，希望找到矩阵 $Y, E$ 使得 $X = Y + E$，其中  $Y$ 是低秩矩阵，而 $E$ 是较小的矩阵。这里的小可以有多种解释，例如：
    #algorithm[Robust PCA][
      如果认为上面的“小”指的是稀疏，这种算法被称为 Robust PCA。例如在监控视频中，背景几乎是不变的，因此我们希望将整个视频分解成低秩的背景和稀疏的前景。我们可以写出优化问题：
      $
        min norm(E)_0 + rank(Y)\
        s.t. X = Y + E
      $
      然而这显然是不好解决的优化问题。为了解决，我们希望用一个凸问题代替。首先 $norm(E)_0$ 可以松弛到 $norm(E)_1$，其次 $rank(Y)$ 就是非零奇异值的个数，可以松弛到奇异值向量的 $L_1$ 范数（通常称为核范数，它确实是范数），因此问题变成：
      $
        min norm(E)_1 + norm(Y)_("ker")\
        s.t. X = Y + E
      $
      这是个凸问题，我们总可以高效求解。
    ]
    从另一个角度，PCA 可以认为是一个 $f: RR^m -> RR^n$ 的映射，其中 $m > n$，我们希望有另一个映射 $g: RR^n -> RR^m$，使得：
    $
      min 1/n sum_i norm(x_i - g(f(x_i)))^2
    $
    往往称 $f$ 为 encoder，$g$ 为 decoder。如果假设 $f, g$ 都是线性，得到的解就是 PCA。而如果选择非线性的函数，就可以得到 PCA 的另一种推广。

    接下来我们介绍另一种线性降维的方法，称为 Random Projection。假设有一组数据 $x_1, ..., x_n$ ，希望通过投影函数 $f$ 投影到低维空间，并且使得：
    $
    norm(f(x_i) - f(x_j)) approx norm(x_i - x_j)
    $<random-projection>
    有趣的是，它的解法是取：
    $
      f (x_i) = 1/sqrt(K) W x_i
    $
    其中 $W in RR^(K times d)$ 是随机矩阵，其中每个元素都独立同分布到 $N(0, 1)$
    #lemma[Johnson-linkoslvous][
      设 $x_i in RR^d$ 是一组向量，对于任意 $delta > 0$，则以 $1 - delta$ 的概率：
      $
        max_i abs(norm(1/sqrt(K) W x_i)^2 / norm(x_i)^2 - 1) <= epsilon
      $
      只要 $K >= C (ln (n / delta))/(epsilon^2)$
    ]
    #proof[
      不妨设 $norm(x_i) = 1$，有：
      $
        norm(1/sqrt(K) W x_i)^2 = 1/K sum_k (W_k^T x_i)^2
      $
      注意到 $W_k^T x_i tilde N(0, 1)$，记其为 $xi_k$，将有：
      $
        norm(1/sqrt(K) W x_i)^2 = 1/K sum_k xi_k^2
      $
      不难发现：
      $
        E(1/K sum_k xi_k^2) = 1
      $
      又有概率集中不等式：
      $
        P(abs(1/K sum_k xi_k^2 - 1) > epsilon) <= C_1 e^(-C_2 K epsilon^2)
      $
      这就对每一个变量的误差做出了估计。最后：
      $
        P(max_i abs(norm(1/sqrt(K) W x_i)^2 - 1) > epsilon) <= sum_i P(abs(norm(1/sqrt(K) W x_i)^2 - 1) > epsilon) <= n C_1 e^(-C_2 K epsilon^2) 
      $
      为了使：
      $
        n C_1 e^(-C_2 K epsilon^2) < delta
      $
      只需要 $K >= C (ln (n / delta))/(epsilon^2)$
    ]
    #remark[][
      - 上面的 $K$ 与 $d$ 无关，甚至 $d$ 为无穷时结果仍然成立。当然这并不奇怪，因为 $n$ 个点张成空间仅有 $n$ 维。
      - 上面的证明中其实并没有用到高斯分布的特性，只要概率集中不等式成立（条件很弱）上面的性质都成立。实际计算时，可能会取：
      $
        W_(i j) tilde cases(
          a space p_1,
          0 space p_2,
          b space p_1
        )
      $
      使得期望和方差满足要求，最后得到的 $W$ 几乎是个稀疏矩阵，运算量较小。
    ]
    回到@random-projection，只需在上面的引理中取约 $n^2$ 个向量 $x_i - x_j$ 即可，结论保证了 $n$ 个向量可以随机投影到约 $ln n$ 维空间，距离就可以几乎不变。

    与 PCA 相比，Random Projection 必须在 $d$ 很高的时候才能有优势，也不能实现降低到很低的维度。同时，PCA 的分析建立于数据真的分布在一个较低维的空间上，而 Random Projection 并不假设这个信息。然而，Random Projection 的分析基于欧式距离，而在很多问题中欧氏距离并不是重要的度量。
    
  
= 现代机器学习（深度学习）
= 理论基础
