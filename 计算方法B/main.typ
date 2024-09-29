#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "计算方法B",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
)
= 前言
  - 授课教师：张磊
  - 办公室：怀新园 78409
  - email: zhangl\@math.pku.edu.cn
  - 助教 email: 2000010798\@stu.pku.edu.cn
  - 作业 30 + 期中 30 + 期末 40
  一般来说，计算数学研究如何求出数学问题的近似解（数值解），以及算法的设计和分析（收敛性、稳定性、复杂性等等）。当代计算数学的主要研究方向包括数值逼近、数值微积分（数值分析）、数值代数、微分方程数值解等等。
  == 主要任务
    - 算法设计：构造特定问题的数值算法
    - 算法分析：收敛性、稳定性、复杂性、计算精度等等
    - 算法实现：编程实现、软件开发
  == 敏度分析与误差分析 
    用计算机计算的数值总是不精确的。：
    - 敏度分析是指原始数据的微小变化对计算结果的影响。往往能找到 $c(x)$ 使得：
      $
      norm(f(x + delta x) - f(x)) / norm(f(x)) <= c(x) norm(delta x) 
      $
      其中的 $c(x)$ 就称为*条件数*，显然若 $f(x)$ 可微则可取 $c(x) = norm(x f'(x))/norm(f(x))$\
      条件数较大的问题称为病态问题，这是问题本身的性质，与算法无关
    - 误差分析是指计算结果与真实结果的差异。
  == 直接法与迭代法
    算法大致可分为两类：
    - 直接法：算法在有限步终止，可以得到精确结果。其效率大致由运算量决定。
    - 迭代法：算法一直进行，有限步只能得到近似结果。其效率由每步的运算量和收敛速度决定。
    #definition[][
      假设迭代法产生数列 $x_k -> x$ 其中 $x$ 是精确解
      - 若存在 $0 < c < 1$ 满足：
        $
        norm(x_k - x) <= c norm(x_(k - 1) - x)
        $ 
        则称算法线性收敛
      - 若存在 $0 < c < 1$ 满足：
        $
        norm(x_k - x) <= c norm(x_(k - 1) - x)^2
        $ 
        则称算法平方收敛
      - 若存在 $0 < c < infinity$ 使得：  
        $
        lim_(k -> infinity) norm(x_k - x) / norm(x_(k - 1) - x)^p = c
        $
        则称之为 $p$ 次渐进收敛
    ]
= 数值代数
  == 基本知识
    数值代数的基本问题：
    + 线性方程组
    + 线性最小二乘
    + 矩阵特征值
    + 奇异值分析
  == 直接法解线性方程组
    === 三角形方程组和 LU 分解
      若 $L$ 是下三角矩阵，且对角线上没有零，则称 $L y = b$ 是三角方程组。不难发现，这样的方程组可以在 $O(n^2)$ 时间解出。自然的，如果方程组 $A x = y$ 可以分解成：
      $
      A = L U\
      L (U x) = y
      $
      其中 $L$ 是下三角矩阵，$U$ 是上三角矩阵，则可以先解 $U x$ 再解出 $x$，这样的分解称为 LU 分解。

      一般的，我们可以使用高斯消元法来解线性方程组。如果枢纽元就选取每行（剩余）的一个元素，则确实可以找到如上形式的分解，运算量约为 $2/3 n^3$
      #theorem[][
        $L U$ 分解后得到的主对角元 $a_(i i)$ 均不为零的充要条件是 $A$ 的所有小于 $i$ 阶顺序主子式均不为零。
      ]
      #proof[
        简单应用归纳法即可
      ]
      #theorem[][
        假设所有顺序主子式均不为零，则 $L U$ 分解存在且唯一（在对应下三角矩阵的主元均为 1 的意义下）。当然这并非分解存在的必要条件。
      ]<LUcondition>

      若已知矩阵有 LU 分解，也可以使用待定系数法来求得分解，运算量仍约为 $n^3$。
      #let per(p, q) = $I_(#p #q)$
      #let letc = "let"
      然而通常而言，之前选取的每行第一个元素未必非零，而枢纽元过小会影响算法的稳定性，有时必须引入置换。
      #algorithm[全主元高斯消元法][
        记 $per(p, q)$ 为初等置换矩阵，左乘 $A$ 即是将第 $p$ 行与第 $q$ 行交换，右乘 $A$ 即是将第 $p$ 列与第 $q$ 列交换。

        ```hs
        gaussAux :: Int -> [Matrix] -> [Matrix] -> [Matrix] -> Matrix -> ([Matrix], [Matrix], [Matrix], Matrix)
        gaussAux r ls ps qs A = 
        ```
        其中 $r$ 为步数，$"ls"$ 为高斯变换矩阵，$"ps"$ 为行置换矩阵，$"qs"$ 为列置换矩阵，$A$ 为当前矩阵。
        - 此时，我们假设 $A$ 形如：
          $ A =
          mat(A_(1 1, (n-r) times r), A_(1 2, (n-r) times (n-r));0_(r times r), A_(2 2, r times (n-r)))
          $
        - 目标是找到 $A_(2 2)$ 中（绝对值）最大元，并用其做下一次高斯消去，为此：
          $
          &letc (p, q) = argmax_((i, j) in RR^n times RR^n, i >= r + 1) |A_(i j)|\
          &letc "pivot" = A_(p q) 
          $
        - 假设 pivot $= 0$ 则算法结束，否则将 $(p, q)$ 调整至$(r + 1, r + 1)$，也即：
          $
          &letc "ps1" = per(p, r + 1) : "ps"\ 
          &letc "qs1" = per(q, r + 1) : "qs"\
          &letc A' = per(p, r + 1) A per(r + 1, q)
          $
        - 再做列变换：
          $
          &letc l_r = vec(0, dots.v, A'_(r+2, r+1), dots.v, A'_(n r+1)) \/ "pivot"\
          &letc L_r = I - l_r e_(r+1)^T\
          &letc "ls1" = L_r : "ls"\
          $
        - 最后：
          $
          &letc A'' = L_r A'\
          $
          即可保证 $A''$ 的左下 $r + 1$ 部分被消掉，因此最终返回：
          ```hs
          gaussAux (r + 1) ls1 ps1 qs1 A''
          ```
          递归结束后即得结果
      ]
      #theorem[][
        设 $A in RR^(n times n)$，则存在 $P, Q$ 和单位下三角阵 $L$，上三角阵 $U$ 使得 $P A Q = L U$，其中 $L$ 的所有元素的绝对值不超过 $1$
      ]
      #proof[
        从上面的算法不难看出大多数结论，事实上，令：
        ```hs
        let (ls, ps, qs, U) = gaussAux 0 [] [] [] A
            P' = foldr (*) I [l * p, p <- ps, l <- ls]
            Q = foldr (*) I (reverse qs)
            P = foldr (*) I ps
            L = P * inv(P')
        ```
        不难从算法过程看出：
        $
        P' A Q = U\
        P A Q = L U
        $
        且其中 $"ls"$ 中的矩阵都是列变换产生的，其中元素绝对值均不大于 $1$，而 ps 中矩阵都是置换矩阵，以及：
        $
        L = P (L_n P_n ... L_1 P_1)^(-1) = (P_n ... P_1) P_1^(-1) L_1^(-1) ... P_n^(-1) L_n^(-1)
        $ 
        而 $L_i = I - l_i e_i^T, L_i^(-1) = I + l_i e_i^T$，且 $P_i^(-1)$ 也是对换矩阵，因此 $L$ 的元素绝对值不超过 $1$ 是容易证明的

      ]
      #algorithm[列主元三角分解][
        寻找全主元是很昂贵的，实践上往往只在 $r + 1$ 列选择最大元，其他算法是类似的，最终结果可以得到：
        $
        P A = L U
        $
        其中：
        $
        P = P_n ... P_1\
        L = P (L_n P_n ... L_1 P_1)^(-1)\
        $
      ]
  == 平方根法
    #theorem[Cholesky][
      设 $A$ 是对称正定矩阵，则存在对角元均正的下三角矩阵 $L$ 使得 $A = L L^T$。$L$ 被称为 $A$ 的 Cholesky 因子。
    ]
    #proof[
      由于半正定矩阵的所有顺序主子式都正，因此可以运用 @LUcondition ，存在单位下三角阵 $L$ 和上三角阵 $U$ 使得：
      $
      A = L U = U^T L^T = A^T\
      U Inv((L^T)) = Inv(L) U^T := D
      $
      上式左侧上三角，右侧下三角，因此 $D$ 是对角矩阵，并且对角元就是 $U$ 的对角元。

      同时，有：
      $
      A = L U = L D L^T
      $
      因此 $D$ 与 $A$ 合同，导致其对角元都正。令 $D = T T^T$，则有：
      $
      
      $
    ]
