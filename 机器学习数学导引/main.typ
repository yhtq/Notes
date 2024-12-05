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
    #lemma[Johnson-Lindenstrauss][
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
  
    无监督学习中，还有一种常见的问题是聚类。假设有若干数据 ${x_i}$，以及 $S = {1, ..., n}$，我们希望找到一个划分 $C = {C_1, ..., C_k}$，使得：
    - 同一个 $C_i$ 中的点尽可能相近
    - 不同的 $C_i$ 中的点尽可能远离
    第二种思路是它的推广，也即考虑每个数据落在某个集合的概率，产生概率向量：
    $
      (gamma_(x_j) (i)): RR^k
    $
    #algorithm[K-means][
      K-means 是最经典的聚类算法之一。对于每个划分 $C_k$，我们不去寻找集合本身，反而寻找它的中心 $alpha_k$. 具体而言，算法的计算方法为：
      - 随机选取 $k$ 个中心，每个点按照距离分配到最近的中心
      - 重新计算每个子集的中心，作为新的中心
      - 重复直到收敛
      如果定义：
      $
        I(C) = 1/2 sum_k 1/abs(C_k) sum_(i, j in C_k) norm(x_i - x_j)^2\
        = sum_k sum_(i in C_k) norm(x_i - alpha_k)^2
      $
      以及：
      $
        I(C, beta) = sum_i norm(x_i - beta_k)^2
      $
      显然有 $min_beta I(C, beta) = I(C)$，因此我们考虑一般的形式 $min_beta I(C, beta)$，而它恰好是 coordinate descent 的形式。
    ]
    #proposition[][
      K-means 算法下：
      - $I(C^(t + 1)) <= I(C^t)$
      - 不能保证收敛到全局最优解，很可能收敛到局部最优解。
    ]
    #proof[
      - 
        $
          I(C^(t + 1)) <= I(C^(t + 1), beta^(t + 1)) <= I(C^t, beta^(t + 1)) <= I(C^t)
        $
    ]
    当然，这是在假设 K-means 采用欧式距离，而实际使用上，使用其他距离也是可行的。
    #definition[Gaussian mixture model, GMM][
      在聚类问题中，属于某个聚类的概率分布 $rho$ 应当是多峰的。设 $phi(x\; mu_k, Sigma_k)$ 是服从参数 $mu_k, Sigma_k$ 的高斯分布，定义：
      $
        rho(x) = sum_k pi_k phi(x\; mu_k, Sigma_k) where
        sum_k pi_k = 1, pi_k >= 0
      $
      它是一个概率密度，而且有多个峰出现。
    ]  
    为了对 GMM 进行分析，假设引入隐变量 $z$，使得：
    $
      p(x, z = k) = pi_k phi_k (x)
    $
    代表 $x$ 属于第 $k$ 类的概率。从而：
    $
      p(x) = sum_k p(x, z = k) = sum_k pi_k phi_k (x)
    $
    进而，可以取：
    $
      gamma_k (x) = p(z = k | x) = p(x, z = k) / p(x) = (pi_k phi_k (x)) / (sum_j pi_j phi_j (x))
    $
    用来代表上面概率模型中的 $gamma$。

    进一步，如果样本给定，我们可以使用最大似然估计来估计参数。也即：
    $
      max_(mu, Sigma) 1/n sum_i ln (sum_k pi_k phi_k (x_i\; mu_k, Sigma_k))
    $
    当 $K = 1$ 时，上面的问题有容易的解析解，就是取样本的期望和方差即可。然而 $K > 1$ 时，对数内的求和带来了复杂性。具体而言：
    $
      0 = partialDer(L, mu_k) = 1/n sum_i (pi_k phi_k (x)) / (sum_j pi_j phi_j (x)) (- Inv(Sigma_k) (x - mu_k))\
      sum_i gamma_(x_i) (k) mu_k = sum_i gamma_(x_i) (k) x_i\
      mu_k = (sum_i gamma_(x_i) (k) x_i) / (sum_i gamma_(x_i) (k))
    $
    类似的，可以得到：
    $
      Sigma_k = (sum_i gamma_(x_i) (k) (x_i - mu_k) (x_i - mu_k)^T) / (sum_i gamma_(x_i) (k))
    $
    #algorithm[Expectation-Maximization, EM][
      假设我们有参数未知的分布 $rho(x | theta)$，$n$ 个样本 $X_i$ 满足：
      $
        X_i tilde rho(x | theta)
      $
      则我们有极大似然估计：
      $
        L(theta) = sum_i ln rho(x_i | theta)
      $
      之前介绍的高斯混合模型事实上是隐变量模型，也即真正的分布应该是某个高维分布的边缘分布，也即：
      $
        rho(x | theta) = sum_i rho(x, z = i | theta)
      $
      同时，联合分布 $rho(x, z | theta)$ 应该是简单的。类似于在 K-means 算法中的做法，我们可以：
      - 选择参数的初值 $theta_0$
      - 计算后验分布 $rho(z | x_i , theta^t)$
      - 按照上面的后验分布抽样 $z_i^j$
      - 在样本：
        $
          (x_i, z_i^j) \
          i = 1, ..., n; j = 1, ..., m
        $
        下，解联合分布的极大似然问题：
        $
          sum_i 1/m sum_j ln rho(x_i, z_i^j | theta)
        $
      事实上，注意到 $m$ 是我们任取的，而不妨设我们可以取得充分大，从而极大似然问题变成：
      $
        sum_i E_(z | x_i, theta_t) ln rho(x_i, z | theta) := Q(theta | theta_t)
      $
      因此，事实上只需解：
      $
        theta_(t+1) = argmax Q(theta | theta_t)
      $

      从优化的角度，可以重新解释这个算法。不妨假设只有一个样本，我们有：
      $
        rho(z | x, theta) = rho(z, x | theta) / rho(x | theta)
      $
      目标是优化极大似然函数：
      $
        L(theta) = ln rho(x | theta) = ln (rho(x, z | theta))/ rho(z | x, theta)\
        = ln (rho(x, z | theta))/ rho(z | x, theta_t) + ln (rho(z | x, theta_t))/(rho(z | x, theta))\
      $
      取期望得：
      $
        L(theta) =  E_(z | x, theta_t) L(theta) \
        = E_(z | x, theta_t) ln (rho(x, z | theta))/ rho(z | x, theta_t) + E_(z | x, theta_t) ln (rho(z | x, theta_t))/(rho(z | x, theta))
      $
      注意到：
      - $E_(z | x, theta_t) ln (rho(x, z | theta))/ rho(z | x, theta_t)$ 与之前定义的 $Q(theta | theta_t)$ 只差一个与 $theta$ 无关的常数，因此之前的 $argmax$ 等价于对它取 $argmax$
      - $E_(z | x, theta_t) ln (rho(z | x, theta_t))/(rho(z | x, theta)) = "KL" (rho_(z | x, theta_t) | rho_(z | x, theta)) := H(theta, theta_t) >= 0$
      因此我们有：
      - $L(theta) >= Q(theta | theta_t)$
      - $L(theta_t) = Q(theta_t | theta_t)$
      - $L(theta_(t + 1)) >= Q(theta_(t + 1) | theta_t) >= Q(theta_(t) | theta_t) = L(theta_t)$
      - 事实上可以证明：
        $
          nabla L(theta)|_(theta = theta_t) = nabla Q(theta | theta_t)|_(theta = theta_t)
        $
        这也意味着它至少比最泛用的梯度上升法：
        $
          theta_(t + 1) = theta_t + eta nabla L(theta)|_(theta = theta_t)
        $<gradient-ascent>
        更好，因为如果
        $
          theta_(t + 1) = argmax Q(theta | theta_t)
        $
        也用梯度上升法求解并且只做一步，恰好就是@gradient-ascent
    ]
    上面介绍了大量的传统机器学习方法。它们具有很强的可解释性，但往往难以解决复杂问题，例如 PCA 要求问题线性，许多方法在高维会出现维数灾难。同时，设计每个模型的方法的泛化性也不够强。深度学习方法则往往是它的反面，往往优化问题的解法更加泛用，不可解释，但往往能够解决复杂问题。

= 现代机器学习（深度学习）
  现代深度学习往往希望将问题转化为基本形式：
  $
    min_theta L(theta)
  $
  更进一步，我们希望 $theta$ 是无约束的。传统最优化方法往往花费巨大精力研究如果在某种约束下找到最优解，因此不够通用。

  对于一般的问题，我们往往不能保证找到全局最优解，我们能得到的收敛性条件往往是：
  $
    norm(nabla L(theta)) -> 0
  $
  但它实际意义十分有限。而在凸问题中，或许可以得到：
  $
    f(x_i) -> f(x^*)
  $
  在现实情境下已经是十分好的结果了。
  == 梯度下降法
    #algorithm[][
      梯度下降法有标准形式：
      $
        x_(t + 1) = x_t - eta_t nabla f(x_t)
      $
      其中 $eta_t$ 被称为步长/学习率。
    ]
    学习率如何选择是一个重要的问题，机器学习领域常见的方法是：
    - 固定学习率，例如 $eta_t = eta$
    - 逐渐减小学习率，例如 $eta_t = eta / t$，例如假如目标函数不够光滑，固定的学习率可能会导致震荡。
    在传统数值方法领域，还有一种方法称作线搜索，也就是取：
    $
      eta_t = argmin f(x_t - eta nabla f(x_t))
    $
    也就是尽可能沿梯度下降方向移动。然而，在机器学习领域它略显太过激进，同时在实际情境中梯度或许并不准确。

    在实际分析中，一个常见的技巧是：
    $
      (X_(t + 1) - X_t)/eta = - nabla f(X_t)
    $
    事实上，它是微分方程：
    $
      der(x, t) = - nabla f(x)
    $
    的离散化，同时有：
    $
      der(f(x_t), t) = inner(nabla f(x_t), der(x, t)) = - norm(nabla f(x_t))^2
    $
    #theorem[][
      $
        min_(t in [0, T]) norm(nabla f(x_t))^2 <= f(x_0) - f(x^*) 
      $
    ]
    #proof[
      $
        min_(t in [0, T]) norm(nabla f(x_t))^2 <= 1/T integral_(0)^(T) norm(nabla f(x_t))^2 dif t <= 1/T (f(x_0) - f(x_t) ) <= 1/T (f(x_0) - f(x^*))
      $
    ]
    #theorem[][
      假设 $f$ 的一阶梯度 Lipschitz 连续，也即：
      $
        norm(nabla f(x) - nabla f(y)) <= L norm(x - y)
      $
      则有：
      $
        f(y) <= f(x) + inner(nabla f(x), y - x) + L/2 norm(y - x)^2
      $
      进一步：
      $
        f(x_(t + 1)) <= f(x_t) - eta_t norm(nabla f(x_t))^2 + eta_t L/2 norm(nabla f(x_t))^2\
        = f(x_t) - eta_t (1 - L/2 eta_t) norm(nabla f(x_t))^2
      $
      为使其收敛，我们假设 $eta_t < 1/L$，上式有：
      $
        f(x_t) - f(x_(t + 1)) >= eta_t/2 norm(nabla f(x_t))^2
      $
      求和有：
      $
        f(x_(0)) - f(x_(T + 1)) >= sum_(t = 0)^(T) eta_t/2 norm(nabla f(x_t))^2 
      $
      假若 $eta_T$ 取常数，则同样用：
      $
        min_t norm(nabla f(x_t))^2 <= O(1/T)
      $
    ]
    #theorem[][
      假设 $f$ 是凸函数，且学习率是常数，则：
    ]
    #proof[
      $
        f(x_(t + 1)) - f(x^*) <= f(x_t) - f(x^*) - eta_t/2 norm(nabla f(x_t))^2\
      $
      而由凸性条件：
      $
        f(x^*) >= f(x_t) + inner(nabla f(x_t), x^* - x_t)
      $
      两式结合：
      $
        f(x_(t + 1)) - f(x^*) <= inner(nabla f(x_t), x^* - x_(t )) - eta_t/2 norm(nabla f(x_t))^2\
        = -1/(2 eta_t) (eta_t^2 norm(nabla f(x_t))^2 - 2 eta_t inner(nabla f(x_t), x^* - x_t) + norm(x^* - x_t)^2) + 1/(2 eta_t) norm(x^* - x_t)^2\
        = -1/(2 eta_t) norm(eta_t nabla f(x_t) - (x^* - x_t))^2 + 1/(2 eta_t) norm(x^* - x_t)^2\
        = -1/(2 eta_t) norm(x_(t + 1) - x^*)^2 + 1/(2 eta_t) norm(x^* - x_t)^2\
      $
      求和得：
      $
        1/T sum_t f(x_t) - f(x^*) <= 1/(2 eta) norm(x_0 - x^*)^2
      $
      进一步有：
      $
        f(1/T sum_t x_t) - f(x^*) <= 1/(2 eta) norm(x_0 - x^*)^2
      $
    ]
    #definition[KL-condition][
      如果：
      $
        norm(nabla f(x))^2 >= 2 mu (f(x) - f(x^*))^alpha
      $
      对于某个 $mu, alpha$ 成立，则称问题满足 KL condition。
    ]
    #theorem[][
      一旦函数满足 KL condition，则有：
      $
        der(f(x_t) - f(x^*), t) <= -mu (f(x_t) - f(x^*))^alpha
      $
      容易解得误差将会指数收敛。
    ]
    #definition[强凸函数][
      设 $f in C^1(RR^n)$，则称 $f$ 是强凸的，如果存在 $mu > 0$ 使得：
      $
        f(y) >= f(x) + inner(nabla f(x), y - x) + mu/2 norm(y - x)^2
      $
      如果 $f$ 二阶可微，上面的条件等价于 $lambda_min (nabla^2 f(x)) >= mu$
    ]
    #proposition[][
      强凸函数都满足 KL-condition
    ]
    #proof[
      $
        f(y) >= min_z (f(x) + inner(nabla f(z), z - x) + mu/2 norm(x - z)^2)\
      $
      计算可得：
      $
        norm(nabla f(x))^2 >= 2 mu (f(x) - f(y))
      $
    ]
    #remark[][
      在过参数化的最小二乘问题中，损失函数并不是强凸的，但却满足 PL-condition (KL-condition 中 $alpha = 1$) 的情形。
      事实上，满足 KL-condition 的函数都未必是凸的，然而可以证明这样的函数每一个极小值都是最小值，不会产生局部最优问题。
    ]

    
    上面我们证明了理论上满足 KL-condition 的函数应该以很快的速度收敛。然而事实上我们总是只能取有限的学习率，而且往往很小。这种情况下，
    实践上的收敛速度仍然比较缓慢。

  == 深度学习
    现代深度学习起源于对人类神经元的模拟，然而现代深度学习经过了长足的发展。
    === 激活函数
      经典的激活函数选择包括：
      - sigmoid: $1/(1 + e^(-x))$，现代已经很少使用
      - RELU：$max(0, x)$，曾经较为常用，但由于 $0$ 点处不可导，已经逐渐被其他变种取代
      - Leaky RELU: $max(a x, x)$，其中 $a$ 是较小值
      - Softplus: $ln(1 + e^x)$，是 RELU 的平滑版本
      - GELU: $x Phi(x)$，其中 $Phi(x)$ 是 $N(0, 1)$ 的累积分布函数
      - SiLU: $x sigma_("sigmoid") (beta x)$
    #theorem[Universal approximation theorem][
      设 $Omega$ 是 $RR^d$ 上的紧集，假设 $sigma$ 是类 sigmodial 函数，也就是：
      $
        sigma(t) -> 1, t -> +infinity\
        sigma(t) -> 0, t -> -infinity
      $
      则对任意 $f in C(Omega)$，$f$ 可以被以 $sigma$ 为激活函数的两层神经网络：
      $
        f_m (x, theta) = sum_(i = 1)^(m) a_i sigma(inner(w_i, x) + b_i)
      $
      一致逼近
    ]
    当然，事实上这个定理只是 Weiersstrass 定理的推广，并且与其类似的在实践中并没有什么用处。
  === 卷积神经网络
    深度学习的发展受到计算机视觉研究的推动，卷积神经网络是其中的代表，它受到了对人类视觉神经元研究的启发。

    卷积的想法是，我们将数据的某个局部看作相互联系的整体，该局部应该以某种方式共享参数。这样在实现上，也可以极大地减少需要存储的参数数量。实践上，我们用某个待学习的卷积核对数据的某个局部进行卷积，从而得到新的数据。

    同时，卷积的形式具有很好的平移不变性，这也在很多时候体现了数据的特征。

    卷积网络中还有一个技巧称为 pooling 或者 downsampling，它的目的是减少数据的维度，同时保留数据的主要特征。它相当于对于每个 Channel 的分块做一个集中操作，常见的包括 max pooling （取最大值）和 average pooling（取平均值）。

    经典的卷积神经网络包括 AlexNet，采用了 ReLU 激活函数和 GPU 加速，在 ImageNet 上取得了巨大的成功。VGGNet 采用了更深的网络结构，ResNet 采用了残差连接，将上一层信号的一部分直接传递到下一层，要学习的目标变成了信号的变化量。理论上，这个 trick 并不改变网络的表达能力，但极大地加速了训练过程，使得更深的网络变得可能。
  === 递归神经网络
    对于序列化的数据，例如文本，我们往往希望能够保留数据的顺序信息。递归神经网络是一种很好的选择。抽象来说，给定输入 $x_i$ 输出 $y_i$，希望训练一个模型 $H_t$ 使得：
    $
      y_t = H_t (x_1, x_2, ..., x_t)
    $
    大致思路是：
    - 设定一个额外的隐藏状态 $h_t$，使得 $h_t = f(x_t, h_(t - 1))$，这个 $f$ 是 $t-$无关的。
    - $y_t = H (x_t, h_(t - 1))$
    但这会导致对早期信号的记忆很差。一个重要的改进是 LSTM(Long Short Term Memory)，它认为之前的 $h$ 是短期记忆，同时引入了一个额外的长期记忆单元，使得网络能够更好地处理长期依赖问题。同时，引入了 Gate 机制，让网络决定是否更新长期记忆。
  == 神经网络的训练 
    抽象来说，神经网络的训练是一个优化问题：
    $
      min_theta 1/n sum_i l(f(x_i, theta), y_i) + lambda norm(theta)
    $
    然而，$f$ 往往具有以下特点：
    - 非常复杂，连梯度都并不容易计算
    - 非凸
    - 维度很高
    因此训练神经网络时，往往会使用 GPU 进行并行化计算。然而，深度学习中，宽度往往是完美并行的，然而深度却产生了数据依赖，无法简单的并行化。这是制约网络变深的一个重要原因。

    同时，我们往往会遇到其他重要问题，包括：
    - 不同层的梯度规模差距很大，导致作为优化问题看待时，条件数很大。经验上，靠近输出层的梯度很大，靠近输入层的梯度很小，很容易造成梯度爆炸或者梯度消失。这也是为什么 sigmoid 等饱和的激活函数不受欢迎，因为它们会导致梯度消失。
    === 学习率选择
      为了解决梯度消失问题，另一种思路是，为梯度一直较小的模型设计一个较大的学习率，而为梯度较大的模型设计一个较小的学习率。这就是 Adagrad 的思路，它的更新规则是考虑该参数的累计梯度 $G_t = sum_t g_t^2$，并且在下一步中采用学习率：
      $
        eta/(sqrt(G_t) + epsilon)
      $
      其中 $epsilon$ 是防止除零的常数。

      然而，经验上学习率一直降低并不是一个好的策略。因此已经被彻底抛弃了。

      另一种思路是 rProp，它的更新规则是直接抛弃梯度的大小信息，直接根据梯度的符号来更新参数。然而，当 batch 比较小并采用随机梯度下降时，这种方法往往完全无法使用。

      它的一个改进是 RMSProp，它的更新规则是：
      $
        v_(t + 1) = beta v_t + (1 - beta) g_t^2\
        theta_(t + 1) = theta_t - eta g_t/(sqrt(v_(t + 1) + epsilon))
      $

      最常用的算法是 Adam，它是以上几种方法的改进。具体而言，它的更新规则是：
      - 计算梯度的一阶 momentum 和 二阶 momentum：
        $
          m_(t + 1) = beta_1 m_t + (1 - beta_1) g_t\
          v_(t + 1) = beta_2 v_t + (1 - beta_2) g_t^2
        $
      - 做 bias correction：
        $
          m_(t + 1) = m_(t + 1)/(1 - beta_1^t)\
          v_(t + 1) = v_(t + 1)/(1 - beta_2^t)
        $
        这是为了解决 $0-$初始化产生的问题。
      - 更新参数：
        $
          theta_(t + 1) = theta_t - eta m_(t + 1)/(sqrt(v_(t + 1) + epsilon))
        $
      它已经成为了训练较大规模神经网络的标准方法。
    === Normaliztion
      另一个重要的问题是梯度消失。一种解决方法是 Batch Normalization，它的思路是对每个 batch 的数据进行归一化，使得每个维度的数据均值为 $0$，方差为 $1$。尽管原因未知，实践表明这样可以极大地增强泛化能力。

      另一种常见方法是 drop out，也就是随机选择一些神经元不参与训练。通过一些计算可以证明，这样的效果相当于添加一个正则化项。
= 理论基础
