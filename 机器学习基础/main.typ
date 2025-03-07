#import "../template.typ": *
#show: note.with(
  title: "机器学习基础",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let ge(h) = $R(#h)$
#let ee(h) = $hat(R)(#h)$
#let er(h) = $hat(e)_r (#h)$
#let acc(h) = $hat(a) (#h)$
= 前言  
  - 教材：周志华《机器学习》
  - 期末考试：6.10 下午，闭卷笔试
  - 作业包括纸面作业和上机作业，都在教学网进行
  - 作业/考勤 40% + 期中 20% + 期末 40%
  - 教学大纲：
    + 机器学习概论
    + 计算学习理论
    + 机器学习基本模型和算法
    + 深度学习初步
= 基本概念
  == 监督学习
    所谓监督学习，就是基于一组数据 $T = {(x_i, y_i)}$ 来学习输入空间 $X$ 到输出空间 $Y$ 的映射。通常认为样本是独立同分布的。$y_i = c(x_i)$ 有时（$c$）也称为目标概念。所有概念记为 $C$，而所有可能的概念一般记为假设空间 $H$，往往与 $C$ 不同。学习算法基于 $T$ 得到一个假设 $h_T in H$
    #definition[损失函数][
      用 $L(h(x), y)$ 度量以 $h(x)$ 作为预测的预测好坏，常见的包括：
      - 0-1 损失
        $
          L(h(x), y) = delta_(h(x), y)
        $ 
      - 平方损失
        $
          L(h(x), y) = (h(x) - y)^2
        $
    ]
    #definition[泛化误差][
      给定损失函数，则：
      $
        ge(h) = E_(x tilde D) L(h(x), c(x))
      $
      表明平均意义下预测的好坏，称其为泛化误差
    ]
    注意通常来说，$x$ 的分布 $D$ 和真实概念 $c$ 都是未知的，因此泛化误差通常是无法实际计算的。
    #definition[经验误差/测试误差][
      - 给定数据集 $T$，则：
        $
          ee(H) = E_T L(h(x), y_i) = 1/N sum_i L(h(x_i), y_i)
        $
        称为经验误差。经验误差小未必保证泛化误差小，可能产生*过拟合*现象。

        更进一步，不同的机器学习理论可能给出对：
        $
          P(abs(approxVar(R)(h_T) - R(h_T)) < epsilon) 
        $
        的估计
      - 类似的，在测试集上计算的误差称为测试误差。通常来说，测试集的产生与训练过程无关，可以认为它们独立，同时有：
        $
          E (approxVar(R)_"test" (h_T)) = R(h_T) 
        $

    ]
    #definition[误差率/准确率][
      用：
      $
        er(h_T) = E_T delta_(h(x), y_i)
      $
      表示算法在 $T$ 上的误差率。用：
      $
        acc(h_T) = 1 - er(h_T)
      $
      表示算法在 $T$ 上的准确率。
    ]
    经验误差小并不能保证泛化误差组功效。
    
    实际二分类问题中，往往会将结果分为真/T 以及假/F，因此产生四类情况：
    - TP：真正例
    - FP：假正例
    - TN：真负例
    - FN：假负例
    通常：
    - $"TP"/("TF" + "TP")$ 称为准确率/查准率
    - $"TP"/("TP" + "FN")$ 称为召回率/查全率

    实际训练模型中，通常来说有两种策略：
    - 经验风险最小化：最小化经验误差
    - 结构风险最小化/正则化策略：
      $
        argmin_h approxVar(R) (h) + lambda J(h)
      $
      其中 $J(h)$ 为正则化项，$lambda$ 为正则化参数。实践上，这两者的选择方法是十分复杂的。
    
    实践上由于超参数的存在，数据往往还要分出一部分用以验证，具体来说：
    - 选取不同的超参数，在训练集上训练
    - 在验证集上验证，选取最优的超参数
    - 在测试集上测试，得到最终的对模型的评价
    #algorithm[数据集的划分][
      - 留出法/简单交叉验证法：通过随机采样，将数据划分为训练集和测试集。有时可以采用分层采样的方式，保证数据的分布。
      - $k$ 值交叉验证法：将数据划分为 $k$ 个大小相等的子集，每次取一个子集作为测试集，其余的作为训练集，重复 $k$ 次，得到 $k$ 个模型，取平均值。
      - 留一法：$k = N$ 的特殊情况，每次只取一个样本作为测试集，其余的作为训练集。
      - 自助法：通过有放回的采样，得到一定大小的训练集，剩余的作为测试集。这样采样可以保证验证集，训练集的大小相同，但得到的分布往往和原分布有所不同。
    ]

    #definition[][
      - 定义：
        $
          overline(h) (x) = E_T h_T (x)\
          "Bias" (x) = E_T (h_T (x) - c(x)) \
          "Var" (x) = E_T (h_T (x) - overline(h) (x))^2
        $
    ]
    #lemma[][
      $
        E_Y (h_T (x) - c(x))^2 = "Bias" (x)^2 + "Var" (x)
      $
    ]
    然而，实际上偏差小（表示对数据敏感）和方差小（对数据不敏感）往往是矛盾的。
= 支持向量机
  以二分类任务为例，使用最简单的线性模型，就是找一个超平面将数据分开：
  - 若假设存在这样一个超平面，如何找到？
  - 若不假设，如何找到一个最优的超平面？
  == 线性可分支持向量机
    给定一个线性可分的数据集 $T = {(x_i, y_i)}$，其中 $y_i in {1, -1}$，则存在一个超平面 $w^T x + b = 0$，使得对所有的 $i$ 有 $y_i (w^T x_i + b) > 0$。

    若模型正确分类，则一定有：
    $
      y_i (w^T x_i + b) > 0, forall i
    $
    为了找到最好的超平面：
    - 由齐次性，不妨假设：
      $
        abs(w x_i + b) >- 1
      $
    - 特别的，对于 $y_i (w x_i + b) = 1$ 的样本点而言，它们就是距离超平面最近的点，而一对这样的点的距离恰好为 $1/norm(w)$
    - 我们把 $2/norm(w)$ 称为*间隔*，目标即是找到间隔最大的超平面
    因此，我们得到了优化问题：
    $
      max_(w, b) 1/(norm(w)) suchThat y_i (w^T x_i + b) > 0, forall i 
    $
    其中 $1/(norm(w))$ 为间隔，表示超平面到最近的点的距离。它可以转化为：
    $
      min_(w, b) 1/2 norm(w)^2 suchThat y_i (w^T x_i + b) > 0, forall i
    $
    这是凸二次优化问题，只要有解（原问题线性可分），则解唯一。称它的解为最大间隔分离超平面。某种意义上，就是利用下面的神经元：
    $
      f(x) = sgn(w^T x + b)
    $
    为了求解这个问题，构造拉格朗日函数：
    $
      L = 1/2 norm(w)^2 - sum_(i = 1)^N alpha_i - sum_(i = 1)^N alpha_i y_i (w^T x_i + b)
    $
    可得：
    $
      W = sum_i alpha_i y_i x_i\
      sum_i alpha_i y_i = 0
    $
    显然 $W != 0$，因此 $alpha_i$ 不能全为零。可以证明：
    $
      L = sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j x_i^T x_j
    $
    因此原问题等价于：
    $
      min_alpha sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j x_i^T x_j \
      suchThat sum_i alpha_i y_i = 0, alpha_i >= 0
    $
    这个问题被称为原问题的对偶问题。

    由 KKT 条件，若 $alpha_i != 0$，则：
    $
      y_j (w^T x_j + b) = 1\
      b = y_j - w^T x_j = y_j - sum_(i = 1)^N alpha_i y_i x_i^T x_j
    $
    由上面的推导，往往也将支持向量机写作：
    $
      sgn(sum_i alpha_i y_i x_i^T x + b)
    $
    事实上，还可以得到：
    $
      norm(w)^2 = sum_(i, j) alpha_i alpha_j y_i y_j x_i^T x_j\
      = sum_j alpha_j y_j (y_j - b)\
      = sum_j alpha_j
    $
    因此，事实上我们希望不为零的 $alpha_i$ 尽可能少，这些向量就被称为支持向量。可以证明，假设在训练集 $D$ 上采用留一法，定义留一误差为：
    $
      ee(f) = 1/N sumfBr(I(f_(D^(-i)) != y_i), upper: N)
    $
    则有：
    $
      ee(f) <= 1/N N_("SV")(f)
    $
    其中 $N_("SV")(f)$ 是支持向量的个数。（该估计仅做了解）
  == 非线性可分支持向量机
    在大多数时候，要求线性可分有些严苛。此时，不仅要最小间隔尽可能大，还要希望分类错误的点尽可能少。因此，我们为每个点引入松弛量 $xi_i$，约束条件变为：
    $
      y_i (w x_i + b) + xi_i >= 1
    $
    我们将 $xi_i != 0$ 的点称为特异点，对于非特异点，情形与线性可分情形是相同的。为了区分其间，我们将此时的间隔称作软间隔，可分情形称作硬间隔。我们希望间隔尽可能小，并且特异点也要尽可能少，因此我们得到了优化问题：
    $
      min_(w, b) 1/2 norm(w)^2 + C sum_i 1_(xi_i !=0) \ 
      suchThat y_i (w x_i + b) >= 1 - xi_i, xi_i >= 0
    $
    实践上，往往采用以下的松弛版本：
    $
      min_(w, b) 1/2 norm(w)^2 + C sum_i xi_i\
      suchThat y_i (w x_i + b) >= 1 - xi_i, xi_i >= 0
    $<sv-2>
    有时也可采用 $C sum_i xi_i^p$ 作为松弛项。

    在上面的问题中，显然取 $xi_i = max(0, 1 - y_i (inner(w, x_i) + b))$ 即可。因此引入合页损失函数：
    $
      h(z) = max(0, 1 - z)
    $ 
    问题等价为
    $
      min_(w, b) 1/2 norm(w)^2 + C sum_i h(y_i (inner(w, x_i) + b))
    $
    或者：
    $
      min_(w, b) 1/2 sum_i max(0, 1 - y_i (inner(w, x_i) + b)) + 1/C norm(w)^2
    $
    事实上，这就是采取合页损失的结构风险最小化策略。事实上，之前的松弛就是用合页损失替代了 $0-1$ 损失。当然也可以采用二次损失替代合页损失。

    回到@sv-2，假如使用拉格朗日乘子法，可以得到拉格朗日函数：
    $
      L = 1/2 norm(w)^2 + C sum_i xi_i - sum_i alpha_i (y_i (inner(w, x_i) + b) - 1 + xi_i) - sum_i beta_i xi_i
    $
    求导得到：
    $
      w = sum_i alpha_i y_i x_i\
      sum_i alpha_i y_i = 0\
      alpha_i = C - beta_i
    $
    化简得到：
    $
      L = sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j inner(x_i, x_j)
    $
    因此得到对偶问题：
    $
      max_alpha sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j inner(x_i, x_j)\
      suchThat sum_i alpha_i y_i = 0, 0 <= alpha_i <= C
    $<sv-3>
    可以看到，形式上只是增加了约束 $alpha_i <= C$，同时许多结论仍然成立：
    - 仍然可以将 $alpha_j > 0$ 的点称为支持向量
    - $w = sum_i alpha_i y_i x_i$
    - $b = y_i - sum_j alpha_j y_j inner(x_j, x_i)$
    - 在所有的支持向量中，$0 < alpha_i < C$ 的点落在分类边界上，$alpha_i = C$ 的点是特异点。
    注意偏置 $b$ 往往不唯一，需要后续实验确认
  == SMO 算法
    Platt 提出的*序列最小最优化算法（SMO）*可以高效地解决@sv-3 这种二次规划问题。其基本思想是：
    - 将多个拉格朗日乘子的问题化减到仅有两个乘子的问题。往往，我们选择第一各变量是违反 KKT 条件最严重的，第二个变量是使得目标函数增加最快的。
    - 仅有两个乘子的二次规划问题有解析解
    首先考虑仅有两个乘子的问题求解：
    #algorithm[][
      假设当前只更新拉格朗日乘子 $alpha_1, alpha_2$，约束：
      $
        sum_i alpha_i y_i = 0
      $
      给出：
      $
        alpha_1 y_1 + alpha_2 y_2 = - sum_(i != 1, 2) alpha_i y_i\
        alpha_1 + alpha_2 y_1 y_2 = - y_1 sum_(i != 1, 2) alpha_i y_i
      $
      令 $s = y_1 y_2, gamma = - y_1 sum_(i != 1, 2) alpha_i y_i$，则原问题转化为
      $
        max_(alpha_1, alpha_2) W(alpha_1, alpha_2)\
        suchThat 0 <= alpha_1, alpha_2 <= C, alpha_1 + s alpha_2 = gamma
      $
      事实上，使用 $alpha_1 = gamma - s alpha_2$ 代换后，这就是关于 $alpha_2$ 的一元二次函数，可以直接求最大值。

      注意每次更新 $alpha_1, alpha_2$ 后，都需要更新 $b$. 若 $alpha_1, alpha_2$ 中至少一个非零，则应该采用 $b = y_j - inner(sum_i alpha_i y_i x_i, x_j)$ 更新
    ]
== 核方法 
  许多问题是完全不能依靠线性函数划分的。一个很自然的想法是构造映射 $phi$，使得 $phi(X)$ 线性可分。得到最优化问题：
  $
    min_(w, b, xi) 1/2 norm(w)^2 + C sum_i xi_i\
    suchThat y_i (inner(w, phi(x_i)) + b) >= 1 - xi_i, xi_i >= 0
  $
  或者对偶问题：
  $
    max_alpha sum_i alpha_i - 1/2 sum_(i, j) alpha_i alpha_j y_i y_j inner(phi(x_i), phi(x_j))\
    suchThat sum_i alpha_i y_i = 0, 0 <= alpha_i <= C
  $
  实际应用上，$phi$ 是难以构造的。经典的处理方式是引入*核函数*：观察上面的对偶问题，事实上我们不关系 $phi$ 的具体值，只关心：
  $
    K(x_1, x_2) = inner(phi(x_1), phi(x_2))
  $
  在数据集上的值，因此合理选择核函数即可，最终的分类函数形如：
  $
    f(x) = sgn(sum_i alpha_i y_i K(x_i, x) + b)\
    b = y_j - sum_i alpha_i y_i K(x_i, x_j)
  $
  往往我们会选择正定对称的核函数，常用的包括：
  - 线性核函数：$K(x, z) = inner(x, z)$
  - 多项式核函数：$K(x, z) = (inner(x, z) + 1)^p$
  - 高斯核函数：$K(x, z) = exp(-d(x, z)^2 / (2 sigma^2))$
    
