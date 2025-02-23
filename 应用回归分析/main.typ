#import "../template.typ": *
#show: note.with(
  title: "应用回归分析",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
#let cov = "Cov"
#let var = "Var"
= 前言  
  - Instructor: Ruibin Xi
  - Office: 智华楼470
  - TA: 唐语阳（tangyuyang\@stu.pku.edu.cn）
  - Email: ruibinxi\@math.pku.edu.cn
  - Office hour: 周二 14:00-15:00 智华楼470
  - Text book: Seber, G. A. F. and Lee, A. J. (2003). Linear Regression Analysis (2nd ed.). Wiley.
  - 作业：两周一次
  - 作业 15% + 期中 35% + 期末 50%
  - 考试以理论推导为主，作业会有一些上机
  #definition[线性模型][
    若有两个随机变量（向量）$X, Y$，一个线性模型是指：
    $
      Y = beta^T X + epsilon
    $
    其中：
    - $X$ 常常被称为 predictor, independent variable, covarient, ...
    - $Y$ 常常被称为 response variable, dependent variable, ...
    - $epsilon$ 是误差项。通常来说，假设其服从 $N(0, sigma^2)$（也可以做其他假设）。有些时候，会遇到误差项根据 $X$ 的不同而有不同的方差，可能需要做额外处理。
  ]
  线性回归分析是非常普遍的情形。事实上，假设 $f_i$ 是一组函数，则形如：
  $
    Y = sum_i beta_i f_i (X) + epsilon
  $
  的模型本质上也是线性回归问题。

  对于线性回归问题，核心问题是：
  - 如何估计 $beta$
  - 如何进行假设检验，例如 $beta < 0$ 的检验
  - 如何进行预测。注意预测和估计 $beta$ 并非相同的问题，它们的目标并不相同，最优的方法也并不完全相同。例如有些时候参数的数量远超样本的数量，这时候找到一个估计的 $beta$ 非常容易，但是预测的效果可能并不好。
  == 预备知识
    #definition[随机矩阵][
      设 $Z = (z_(i j))_(m times n)$，其中 $z_(i j)$ 是随机变量，则称 $Z$ 为随机矩阵。定义期望：
      $
        E(Z) = (E(z_(i j)))_(m times n)
      $
    ]
    #lemma[][
      - $E(A Z B + C) = A E(Z) B + C$，其中 $A, B, C$ 为常数矩阵。
      - $E(X + Y) = E(X) + E(Y)$
    ]
    #definition[协方差][
      设 $X, Y$ 为两个随机变量，则定义协方差矩阵：
      $
        cov(X, Y) = (cov(x_i, y_j))_(m times n) = E((X - E(X)) (Y - E(Y))^T)
      $
      进一步，定义：
      $
        var(X) = cov(X, X) = (cov(x_i, x_j))_(m times m) \
        = E((X - E(X)) (X - E(X))^T) = E(X X^T) - E(X) E(X)^T
      $
      显然，$var(X)$ 是一个对称矩阵。
    ]
    #lemma[][
      设 $A, B$ 为常数矩阵，则：
      $
      cov(A X, B Y) = A cov(X, Y) B^T\
      cov(X + Y, Z) = cov(X, Z) + cov(Y, Z)\
      cov(X, Y + Z) = cov(X, Y) + cov(X, Z)
      $
      从而 $cov$ 是一个双线性函数。特别的，有：
      $
        var(A X) = A var(X) A^T
      $
    ]
    #theorem[][
      $var(X) >= 0$，等于 $0$ 当且仅当 $X$ 中各变量线性相关
    ]
    #proof[
      $
      c^T var(X) c = c^T cov(X, X) c = cov(c^T X, c^T X) = var(c^T X) >= 0
      $  
      显然等于零当且仅当 $c^T X$ 几乎处处为零。
    ]
    #theorem[][
      设 $A$ 是对称常矩阵，则：
      $
        E(x^T A x) = tr(A var(X)) + E(x)^T A E(x)
      $
      进一步，若 $var(X) = sigma^2 I$（例如 $X$ 是独立同分布的正态随机变量），则上式等于：
      $
        sigma^2 tr(A) + E(x)^T A E(x)
      $
    ]
    #proof[
      $
        E(x^T A x) = E(tr(x^T A x)) = E(tr(A x x^T)) = tr(A E(x x^T)) \
        = tr(A(var(X) + E(X) E(X)^T)) = tr(A var(X)) + E(x)^T A E(x)
      $
    ]
    #example[][
      求：
      $
        E((x_1 - x_2)^2 + (x_2 - x_3)^2 -... - (x_(n - 1) - x_n)^2)
        
      $
      设:
      $
        T = mat(1, -1, 0, ..., 0;0, 1, -1, ..., 0; dots.v, dots.v, dots.v, ..., dots.v;0, ..., 0, 1, -1)
      $
      则：
      $
        E((x_1 - x_2)^2 + (x_2 - x_3)^2 -... - (x_(n - 1) - x_n)^2) \
        = E(x^T T^T T x) = tr(T^T T var(x)) + E(x)^T T^T T E(x)
      $
    ]
    #example[][
      设 $cov(x_i, x_i) = 1, cov(x_i, x_j) = rho$，可以计算得：
      $
        E(sum_(i = 1)^n (x_i - overline(x))^2) = sigma^2 (1 - rho) (n - 1)
      $
    ]
    #definition[矩母函数][
      设 $X$ 为随机变量，则称：
      $
        M_X (t) = E(e^(t^T X))
      $
      为 $X$ 的矩母函数（未必存在）。
    ]
    #definition[特征函数][
      设 $X$ 为随机变量，则称：
      $
        phi_X (t) = E(e^(i t^T X))
      $
      为 $X$ 的特征函数（一定存在）。
    ]
    #theorem[][
      - 若 $phi_Y = phi_X$，则 $X$ 和 $Y$ 的分布相同。
      - 若 $X, Y$ 独立，则 $phi_(X, Y)(t) = phi_x (t_1) phi_y (t_2)$
    ]
  
