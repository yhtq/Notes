#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "计算方法B",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
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
      A = L T T^T L^T = (L T) (L T)^T
      $
      注意到 $L$ 是单位下三角矩阵，不难验证 $L T$ 是对角元均正的下三角矩阵
    ]
    #algorithm[][
      求 Cholesky 因子当然可以通过 LU 分解，但事实上有更快的办法。只需从：
      $
      A = L L^T
      $
      便可得到等式：
      $
      a_(i j) = sum_(p = 1)^j l_(i p) l_(j p)
      $
      这些等式呈三角形，因此可以依次回代动态规划求解。具体而言：
      ```hs
      choleskyij :: Matrix -> Map (Int, Int) Double -> Int -> Int -> Map (Int, Int) Double -- 计算 l_(i j)，假设 i >= j
      choleskyij A L i j = Map.insert L (i, j) lij
                  where lij = if i = j 
                    then sqrt (A i i - sum [(L i p)^2 | p <- [1..j - 1]])
                    else (A i j - sum [(L i p) * (L j p) | p <- [1..j - 1]]) / (L j j)
      cholesky :: Matrix -> Matrix
      cholesky A = foldl (choleskyij A) Map.empty [(i, j) | i <- [1..n], j <- [1..i]]

      ```
      若只考虑乘加运算，运算量约为：
      $
      sum_(i=1)^n sum_(j=1)^i 2j approx 1/3 n^3
      $
      // $
      // sum_(k=1)^n sum_(j = k + 1)^n sum_(r = j)^n 2 = sum_(r = 2)^n sum_(j = 2)^r sum_(k=1)^(j-1) 2 = sum_(r = 2)^n sum_(j = 2)^r 2(j - 1) ~ sum_(r = 2)^n r^2 ~ 1/3 n^3
      // $
      之后，只需解：
      $
      L y = b\
      L^T x = y
      $
      两个三角形方程组即可得到解。

      此外，该分解是稳定的，既然由：
      $
      a_(i i) = sum_(p = 1)^(i - 1) l_(i p)^2
      $
      不难得到：
      $
      abs(l_(i j)) <= sqrt(a_(i i))
      $
    ]
    #algorithm[改进的平方根法][
      平方根法需要进行开方运算。为了避免开方，可以求如下形式的分解：
      $
      A = L D L^T
      $
      其中 $L$ 是单位下三角矩阵，$D$ 是对角元均正的对角矩阵。（该分解称为 $L D L^T$ 分解）这样，方程变为：
      $
      a_(i j) = sum_(k = 1)^(j - 1) l_(i k) d_k l_(j k) + l_(i j) d_j 
      $
      反解出：
      $
      d_j = a_(j j) - sum_(k = 1)^(j - 1) l_(j k)^2 d_k\
      l_(i j) = (a_(i j) - sum_(k = 1)^(j - 1) l_(i k) l_(j k) d_k) / d_j
      $
      同样进行动态规划即可。它的运算量也约为 $1/3 n^3$
    ]
= 线性方程组的敏度分析
  == 向量范数与矩阵范数
    #definition[向量范数][
      称满足：
      - 正定性：$norm(x) >= 0， norm(x) = 0<=> x = 0$
      - 齐次性：$norm(a x) = a norm(x)$
      - 三角不等式：$norm(a + b) <= norm(a) + norm(b)$
      的 $RR-$ 线性空间 $X$ 到 $RR$ 的函数为范数。常用范数包含：
      - $p-$范数：$norm(x) = root(1/p, sum_i abs(x_i)^p)$
      - $infinity-$ 范数：$norm(x) = max_i abs(x_i)$
      - $0-$ "范数"：$"card" {x_i | x_i != 0}$ （并不齐次）
    ]
    #definition[相容性][
      - 称矩阵范数相容，如果 $norm(A B) <= norm(A) norm(B)$
      - 称矩阵范数与向量范数相容，如果 $norm(A x) <= norm(A) norm(x)$
      一般的，我们假定我们使用的范数都是相容的。
    ]
    #theorem[][
      给定 $RR^n$ 上向量范数，则可以定义矩阵范数：
      $
      norm(A) = sup_(x != 0) (norm(A x))/norm(x)
      $
      它是 $RR^(m times n)$ 上的相容矩阵范数，也称为算子范数。它与向量范数相容。
    ]
    #example[矩阵范数][
      常用的矩阵范数包括：
      - $1-$ 范数：$max_(j) sum_i a_(i j)$，也称列范数
      - $infinity-$ 范数：$max_(i) sum_j a_(i j)$，它是向量无穷范数的诱导
      - $2-$ 范数：$norm(A) = A^T A$ 最大特征值的平方根，也称为谱范数，它是向量 $2-$ 范数的诱导
    ]
    #proposition[][
      设 $A in RR^(m times n)$，则有：
      - $norm(A)_2 = max_(norm(bx)_2 = 1, norm(by)_2 = 1) norm(by^T A bx)$
      - $norm(A)_2 = norm(A^T)_2 = sqrt(norm(A A^T)_2)$
      - 设 $U$ 是正交矩阵，则 $norm(U A)_2 = norm(A U) = norm(A)$
    ]
    #definition[谱半径][
      称矩阵的特征值的绝对值最大值为谱半径，记为 $rho(A)$
    ]
    #theorem()[][
      - 对于任意矩阵范数，有 $norm(A) >= rho(A)$
      - 对于任意 $epsilon > 0$，存在矩阵范数使得 $norm(A) <= rho(A) + epsilon$
    ]
    #proof[
      - 设 $lambda$ 是特征值且 $abs(lambda) = rho(A)$，$alpha$ 是对应的特征向量。将有：
        $
        rho(A) norm(alpha e_1^T)= norm(rho(A) alpha e_1^T) = norm(A alpha e_1^T) <= norm(A) norm(alpha e_1^T)
        $
        两边消去即可。
    ]
    #theorem[][
      设 $A in CC^(n times m)$，则：
      $
      lim_(n -> +infinity) A^n = 0 <=> rho(A) < 1
      $
      更进一步，$lim_(n -> +infinity) A^n exists <=> rho(A) <= 1$
    ]
    #proof[
      使用 Jordan 分解即可。
    ]

