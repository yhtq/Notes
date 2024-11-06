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
      norm(f(x + delta x) - f(x)) / norm(f(x)) <= c(x) norm(delta x)/norm(x) 
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
= 直接法解线性方程组
    == 三角形方程组和 LU 分解
      若 $L$ 是下三角矩阵，且对角线上没有零，则称 $L y = b$ 是三角方程组。不难发现，这样的方程组可以在 $n^2$ 时间解出。自然的，如果方程组 $A x = y$ 可以分解成：
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
    #corollary[][
      假设 $norm(I) = 1, norm(A) < 1$，则 $I - A$ 可逆，且有：
      $
      norm(Inv((I - A))) <= 1/(1 - norm(A))
      $
    ]<norm-inv>
    #proof[
      #let suma = sumf()
      #let summ = sumf(lower: $m$)
      考虑形式幂级数：
      $
      suma A^n
      $
      断言它收敛，事实上使用柯西准则：
      $
      norm(summ A^n) <= summ norm(A^n) <= summ norm(A)^n -> 0 
      $
      因此一定收敛。设其和为 $B$，则：
      $
      B (I - A) = (suma A^n)(I - A) = I
      $
      表明 $B$ 就是 $I-A$ 的逆，并且：
      $
      norm(B) = norm(suma A^n) <= suma norm(A^n)  <= suma norm(A)^n = 1/(1 - norm(A))
      $
      证毕
    ]
  == 线性方程组的敏度分析
    本节中，我们希望计算解线性方程组的条件数。假设我们使用的范数满足 $norm(I) = 1$，对线性方程组问题：
    $
    A x = b
    $
    其中 $A$ 非奇异，假设微扰后变为：
    $
    (A + delta A)(x + delta x) = b + delta b\
    A x + A delta x + delta A x + delta A delta x = b + delta b\
     A delta x + delta A x + delta A delta x= delta b\
     (A +delta A)delta x = delta b - delta A x\
     delta x = Inv((A + delta A)) (delta b - delta A x) = Inv((I + Inv(A) delta A)) Inv(A) (delta b - delta A x)\
     norm(delta x) <= norm(Inv((I + Inv(A) delta A))) norm(Inv(A)) (norm(delta b) + norm(delta A) norm(x))\
     norm(delta x)/norm(x) <= norm(Inv((I + Inv(A) delta A))) norm(Inv(A)) (norm(delta b)/norm(x) + norm(delta A) )\
     norm(delta x)/norm(x) <= norm(Inv((I + Inv(A) delta A))) norm(Inv(A)) (norm(delta b)/norm(x) + norm(delta A) )  <= (norm(A) norm(Inv(A)) ) / (1 - norm(Inv(A)) norm(delta A)) (norm(delta b)/(norm(A) norm(x)) + norm(delta A)/norm(A) )\
     <= (norm(A) norm(Inv(A)) ) / (1 - norm(Inv(A)) norm(delta A)) (norm(delta b)/(norm(A x)) + norm(delta A)/norm(A) )
     <= (norm(A) norm(Inv(A)) ) / (1 - norm(Inv(A)) norm(delta A)) (norm(delta b)/(norm(b)) + norm(delta A)/norm(A) )
    $
    其中运用了：
    $
    norm(Inv((I + Inv(A) delta A))) <= 1/(1 - norm(Inv(A) delta A)) <= 1/(1 - norm(Inv(A)) norm(delta A))
    $
    因此我们得到定理：
    #theorem[][
      假设 $A x =b$ 经微扰变为 $(A + delta A)(x + delta x) = b + delta b$，则有：
      $
      (delta x) / x <= (norm(A) norm(Inv(A)) ) / (1 - norm(Inv(A)) norm(delta A)) (norm(delta b)/norm(b) + norm(delta A)/norm(A) )
      $
      若令 $kappa(A) = norm(A) norm(Inv(A))$，则上式表明 $(delta x)/x$ 与 $kappa(A)$ 大约为线性，因此 $kappa(A)$ 称为线性方程组问题的条件数。
    ]
    此外，我们有：
    #theorem[][
      在求逆问题中，有：
      $
      (norm((A + delta A)^(-1) - A^(-1))) / norm(A^(-1)) &<= norm(I - A (A + delta A)^(-1)) = norm(I - Inv((I + delta A Inv(A))))\
      &= norm(((I + delta A Inv(A)) - I)Inv((I + delta A Inv(A))))\
      &<= norm(delta A) norm(Inv(A)) norm(Inv((I + delta A Inv(A))))\
      &<= (norm(delta A) norm(Inv(A)))/(1 - norm(delta A) norm(Inv(A)))\
      &= (norm(A) norm(Inv(A)))/(1 - norm(delta A) norm(Inv(A))) norm(delta A)/norm(A)\
      $
      可见 $kappa(A)$ 也是求逆问题的条件数。
    ]
    #theorem[][
      若使用谱范数，则有：
      $
      min {norm(delta A) | A +delta A "奇异"} = 1/norm(Inv(A))
      $
    ]
    #proof[
      由于谱范数是算子范数，取单位向量 $x$ 使得：
      $
      norm(Inv(A) x) = norm(Inv(A))
      $
      取：
      $
      y = (Inv(A) x)/norm(Inv(A) x)\
      $
      则：
      $
      A y = x/norm(Inv(A)) = (x y^T y)/(norm(Inv(A))) = (x y^T)/norm(Inv(A)) y
      $
      也即：
      $
      (A - (x y^T)/norm(Inv(A))) y = 0
      $
      同时：
      $
      norm((x y^T)/norm(Inv(A))) = 1/norm(Inv(A)) sqrt(norm(x y^T y x^T)) = 1/norm(Inv(A)) sqrt(norm(x x^T)) = 1/norm(Inv(A))
      $
      表明 $A - (x y^T)/norm(x)$ 是奇异的，而 $(x y^T)/norm(x)$ 就是我们要找的微扰。

      对于更小的微扰，@norm-inv 保证矩阵一定可逆。
    ]
= 线性最小二乘问题
  === 正规化法
    #definition[最小二乘][
      给定 $A in RR^(m times n), b in RR^m$，线性最小二乘问题是求解：
      $
      min norm(A x - b)^2
      $
      其中 $x in RR^n$ 为未知向量。
    ]
    显然
    - 若 $m = n$ 且 $A$ 非奇异时，$x = Inv(A) b$ 即可
    - 若 $m < n$，称作嵌进方程组，解有无穷多组，我们往往希望解出：
      $
      min norm(x)^2 s.t. A x = b
      $
      也即范数最小的解。对于这种问题，我们往往通过拉格朗日乘子法解决。
    - 若 $m > n$，称方程组超定 (overdetermined)，我们希望解出：
      $
      min norm(A x - b)^2
      $
      也即最小化误差的平方和。这种问题的解法是线性最小二乘问题。当我们采用2-范数时，这是凸问题，存在唯一的最优解，求导可得解就是以下线性方程组的解：
      $
      A^T A x = A^T b
      $
      这被称为最小二乘问题的正则化方程，线性代数的知识保证了它总是有解的。假设 $A$ 列满秩，则 $A^T A$ 对称正定，使用平方根法即可，否则用一般的解线性方程组方法即可。

    然而，注意到 $A^T A$ 的条件数是 $A$ 的条件数的平方，因此使用一般的线性方程组解法会导致误差放大，因此我们希望采用其他方法求解。之前高斯变换我们使用的是初等变换矩阵，而这里我们要处理 2- 范数，使用正交矩阵便可保证结果不变。
  === 初等正交变换
    先介绍初等正交矩阵：
    #definition[][
      对于任意向量 $v$，令：
      $
      H = I - 2/ (v^T v)  v v^T 
      $
      这样的矩阵称为 Householder 矩阵，对应向量称为 Householder 向量 。它是对称的正交/对合矩阵，且 $v$ 是特征向量，对应特征值为 $-1$。事实上，它就是关于超平面 $v^T$ 的反射。
    ]
    #lemma[][
      设 $x != 0$，则存在单位向量 $v$，使得：
      $
      H_v x = alpha e_1
      $
      其中 $abs(alpha) = norm(x)$
    ]
    #proof[
      注意到：
      $
      H_v x = (I - 2 v v^T)x = x - 2 v v^T x = x - 2 (v^T x) v = alpha e_1
      $
      可得 $v$ 与 $x - alpha e_1$ 线性相关，进一步若取：
      $
      v = (x - alpha e_1)/norm(x - alpha e_1)
      $
      则恰好之前的等式成立。
    ]
    实际计算时，我们希望 $alpha > 0$，因此上面选取减号，然而当 $x_1 > 0$ 时，这会造成数值不稳定的问题。不过，我们可以进行等价变形：
    $
    (x - alpha e_1)_1 = x_1 - norm(x)\
    = x_1 - sqrt(sum_i x_i^2) = - (sum_(i = 2)^n x_i^2) / (x_1^2 + sqrt(sum_i x_i^2))\
    $
    同时，我们未必要算出单位化的向量 $v$，既然：
    $
    H = I - 2/ (v^T v)  v v^T 
    $
    令 $beta = 2/ (v^T v)$，算出 $beta$ 和 $v$ 即可。
    我们给出 Householder 变换的算法：
    ```rust
    fn Householder(x: Vec<R> n) -> (R, Vec<R> n)
    {
      let eta = max(x);
      x = x / eta;
      let sigma = sum(x[2..n] ^ 2);
      let mut v = x;
      v[1] = 1;
      if (sigma == 0) return;
      let alpha = sqrt(x[1] ^ 2 + sigma); // norm(x)
      let v[1] = 
          if (x[1] <= 0) x[1] - alpha; // 直接运算
          else  -sigma / (x[1] + alpha);  // 通过等价变形间接运算，保证数值稳定
      beta = 2 / (sigma + v[1] ^ 2);  // 2 / norm(v)^2
      (beta, v)
    }
    ```
    如果只是想将向量的某一个分量变为零，可以利用 Givens 变换
    #definition[][
      设
      $
      G(i, k, theta) = I + s (e_i e_k^T - e_k e_i^T) + (c - 1) (e_i e_i^T + e_k e_k^T)\
      where c = cos theta, s = sin theta
      $
      也就是 $i, k$ 行/列是旋转矩阵：
      $
      mat(cos theta, sin theta; -sin theta, cos theta)
      $
      其他位置是单位矩阵。易知：
      $
      G(i, k ,theta) x = &"match" i "with"\ | &i => c x_i + s x_k \ | &k => -s x_i + c x_k \ | &\_ => x_i
      $
      因此为使 $(G(i, k ,theta) x)_k = 0$，只需取：
      $
      c = x_i / sqrt(x_i^2 + x_k^2), s = x_k / sqrt(x_i^2 + x_k^2)
      $
      便有：
      $
      G(i, k ,theta) x = &"match" i "with"\ | &i => sqrt(x_i^2 + x_k^2) \ | &k => 0 \ | &\_ => x_i
      $
    ]
    为了数值稳定性，实际计算时，我们不用保证 $s, c$ 平方和为 1
  === QR 分解，正交变换法
    #theorem[QR][
      设 $A in RR^(m times n)$，则存在一个列正交阵 $Q$ 和对角元非负的上三角矩阵 $R$ 使得：
      $
      A = Q vec(R, 0)
      $
      且若 $m = n$，$A$ 非奇异，则上述分解唯一。
    ]
    #proof[
      对 $A$ 的列空间做 Gram-Schmidt 正交化即可。
    ]
    回到最小二乘问题，设
    $
    A = (Q_1, Q_2) vec(R, 0) = Q_1 R\
    Q^T b = vec(Q_1^T b, Q_2^T b)
    $
    原问题变为：
    $
    min norm(Q^T Q vec(R, 0) x - Q^T b)^2 = min norm(vec(R, 0) x - vec(Q_1^T b, Q_2^T b))^2\
    = min norm(R x - Q_1^T b)^2 + norm(Q_2^T b)^2
    $
    而 $R$ 是满秩的方阵，直接求解：
    $
    R x = Q_1^T b\
    x = Inv(R) Q_1^T b
    $
    即可。求解 QR 分解的方法可以采用之前的 Householder 变换，也可以采用 Givens 变换。往往在非零元素较多时使用 Givens 变换。使用 Householder 变换进行 QR 分解的复杂度约为 $2 n^2 (m - n/3)$，比正规化方法运算量大很多，但数值稳定性也好很多。
= 解线性方程组的迭代法
  第一章已经介绍了解线性方程组的直接法，然而对于常见的大规模矩阵，它的元素往往比较稀疏，而 LU 分解会破坏许多零元素，不能保持稀疏性。本章介绍解线性方程组的迭代法，也就是构造一个向量序列使得它趋近于问题的解。对于迭代法，往往要解决以下几个问题：
  - 如何构造迭代序列
  - 是否收敛，在什么条件下收敛
  - 若收敛，收敛速度如何
  == 单步线性定长迭代法
    #algorithm[Jacobi 迭代法][
      Jacobi 迭代法是最简单的迭代法，它的思路是将 $A x = b$ 分解成对角线元素和非对角线元素两部分：
      $
      A = D - L - U\
      D x = (L + U) x + b
      $
      其中 $D$ 是 $A$ 的对角线元素，$L, U$ 分别是 $A$ 的下三角和上三角元素（取负）。假设 $A$ 的对角线上没有零，就可以构造迭代公式：
      $
      x_(k + 1) = B x_k + g\
      where 
      B = D^(-1) (L + U) \
      g = D^(-1) b
      $
    ]
    #algorithm[Gauss - Seidel 迭代法][
      注意到 Jacobi 迭代法中，每个 $x_i$ 分量更新都是独立的。而事实上，我们可以利用已经更新的 $x_i$ 取代前一次的 $x_i$，可以写成：
      $
      x_k = Inv(D) L x_k + Inv(D) U x_(k - 1) + Inv(D) b
      $
      也可以变形成：
      $
      (D - L) x_k = U x_(k - 1) + b\
      x_k = Inv((D - L)) U x_(k - 1) + Inv((D - L)) b
      $
      下三角的非零部分就是已经更新的部分，而上三角的非零部分就是未更新的部分。这就是 Gauss - Seidel 迭代法。
    ]
    所谓的单步线性定长迭代，就是迭代公式形如：
    $
    x_k = M x_(k - 1) + g
    $
    显然若序列收敛，则极限就是方程组：
    $
    (M - I) x + g = 0
    $
    的解。若该方程与 $A x = b$ 一致，则迭代法正确收敛。假设该方程的解为 $x$，则误差为：
    $
    y_k = x_k - x = M x_(k-1) + g - x = M y_(k-1)
    $
    因此显然方程收敛当且仅当 $M^k -> 0$，也即 $M$ 的谱半径小于 $1$。
    === 收敛条件
      上面介绍的两种迭代法 Jacobi 和 Gauss - Seidel 有着不同的迭代矩阵，它们的收敛范围也互不包含。然而谱半径并不好计算，我们可以找到一些充分条件。
      #theorem[][
        若迭代矩阵满足 $norm(M) = q < 1$，则有：
        $
        norm(x_k - x) <= (q^k)/(1-q) norm(x_1 - x_0)
        $
      ]
      #proof[
        $
        norm(x_k - x) <= q^k norm(x_0 - x)\
        norm(x_0 - x) <= norm(x_1 - x_0) + norm(x_1 - x) <= norm(x_1 - x_0) + q norm(x_0 - x)\
        norm(x_1 - x_0) >= (1 - q) norm(x_0 - x) >= (1-q)/q^k norm(x_k - x)
        $
      ]
      这个定理可以用来得到所需要的迭代次数，但往往偏高。
      #theorem[][
        若迭代矩阵满足 $norm(M) = q < 1$，则有：
        $
        norm(x_k - x) <= q/(1 - q) norm(x_k - x_(k-1))
        $
      ]
      #proof[
        就是上面定理的特例。
      ]
      这个界往往更加准确，往往可以用来在迭代过程中及时估计误差。当然若 $q$ 很接近于 $1$，则误差还可能较大。注意上面两个定理中我们并不假定用何种范数，因此实践上往往使用便于计算的列范数 $norm(M)_1$ 和行范数 $norm(M)_infinity$。

      当系数矩阵 $A$ 正定时，它的收敛性可能更易判定：
      #theorem[][
        设 $A x = b$ 中，$A$ 对称且对角元 $> 0$，则 Jacobi 迭代收敛当且仅当 $A, 2 D - A$ 都正定。
      ]
      #proof[
        注意到：
        $
          M = Inv(D) (L + U) = Inv(D) (D - A) = I - Inv(D) A
        $
        由条件，$D$ 可以开平方根，上式等于：
        $
          D^(-1/2) (I - D^(-1/2) A D^(-1/2)) D^(1/2)
        $
        显然 $I - D^(-1/2) A D^(-1/2)$ 对称，且与 $M$ 相似，有相同的特征值和谱半径，因此 $M$ 特征值均为实数。类似的，$I - M$ 与 $D^(-1/2) A D^(-1/2)$ 相似，$I + M$ 与 $(2 I - D^(-1/2) A D^(-1/2))$\
        不难验证由 $M$ 特征值均为实数， $rho(M) < 1$ 当且仅当 $I - M, I + M$ 的特征值均为正实数，略作化简即是定理条件。
      ]
      #theorem[][
        设 $A x = b$ 中，$A$ 对称正定，则 Gauss - Seidel 迭代收敛。
      ]
    === 正定矩阵的判别
      #definition[对角占优][
        设矩阵 $A$ 满足：
        $
        abs(a_(i i)) >= sum_(j != i) abs(a_(i j)), forall i
        $
        且对至少一个 $i$ 严格不等号成立，则称之为弱严格对角占优。若对所有 $i$ 严格不等号成立，则称之为严格对角占优。
      ]
      #definition[不可约][
        如果存在 $n$ 阶正定矩阵 $P$ 使得：
        $
          P A P^T = mat(A_(1 1), 0;A_(2 1), A_(2 2))
        $
        则称 $A$ 可约或者可分，否则称之为不可约。假设 $A$ 可约，则方程：
        $
          A x = b
        $
        可以立刻化简为：
        $
          P A P^T P x = P b
        $
        进而可以将 $n$ 阶方程组降为两个低维的方程组。
      ]
      #proposition[][
        矩阵可约的充要条件是存在 ${1, 2, ..., n}$ 的一个划分 $W, T$ 使得：
        $
          a_(i j) = 0, forall i in W, j in T
        $
      ]
      若一个矩阵弱严格对角占优且不可约，则称之为*不可约对角占优*。
      #theorem[][
        若 $A$ 严格对角占优或不可约对角占优的，则 $A$ 非奇异。
      ]
      #proof[
        我们只证明前一种情形。如若不然，则存在非零向量 $x$ 使得：
        $
          A x = 0
        $
        不妨设 $norm(x)_infinity = 1 = abs(x_i)$，则有：
        $
          abs(a_(i i)) = abs(a_(i i) x_i) = abs(sum_(j != i) a_(i j) x_j) <= sum_(j != i) abs(a_(i j)) < abs(a_(i i))
        $
        矛盾！
      ]
      #corollary[][
        若 $A$ 是严格对角占优或不可约对角占优的对称矩阵，且 $A$ 对角线元素均为正数，则 $A$ 正定。
      ]
      #theorem[][
        若 $A$ 是严格对角占优或不可约对角占优，则 Jacobi 迭代法和 Gauss - Seidel 迭代法都收敛。
      ]
      #proof[
        我们只证 Jacobi 迭代，首先由条件对角元均非零，因此 $D$ 可逆。考虑：
        $
          M = Inv(D) (L + U)
        $
        假设它有特征值 $lambda >= 1$，不难验证 $lambda D - L - U$ 也是严格对角占优/不可约对角占优的，因此非奇异。但另一方面：
        $
          0 = abs(lambda I - Inv(D) (L + U)) = abs(Inv(D)) abs(lambda D - L - U) 
        $
        而前面已经说明 $Inv(D), lambda D - L - U$ 都非奇异，矛盾！
      ]
    === 收敛速度
      #definition[][
          令：
          $
           R_k (M) := (-ln norm(M^k))/k
          $
          为迭代矩阵为 $M$ 时 $k$ 次迭代的平均收敛速度。特别的，记：
          $
            R_infinity (M) := lim_(k -> +infinity) R_k (M)
          $
          称为渐进收敛速度。
      ]
      #proposition[][
        假设 $M$ 对称，则不难验证：
        $
          norm(M^k) = rho(M)^k
        $
        进而 $R_k (M) = -ln rho(M)$\
        但一般而言，$R_k (M)$ 是依赖于 $k$ 的
      ]
      #proposition[][
        对于任何矩阵 $M$ 都有：
        $
          R_infinity (M) = - ln rho(M)
        $
      ]
      #proof[
        注意到谱半径小于任何范数，因此：
        $
          rho(M)^k = rho(M^k) <= norm(M^k) => rho(M) <= norm(M^k)^(1/k)
        $
        另一方面，不难验证对于任意 $epsilon > 0$ 有：
        $
          rho(1/(rho(M) + epsilon) M) < 1
        $
        进而对于充分大的 $k$:
        $
          norm((1/(rho(M) + epsilon) M)^k) <= 1\
          norm(M^k) <= (rho(M) + epsilon)^k\
          rho(M) <= norm(M^k)^(1/k) <= rho(M) + epsilon
        $
        由 $epsilon$ 的任意性，得证。
      ]
  == 超松弛迭代法 SOR
    考虑 Gauss - Seidel 迭代法：
    $
      x_(k + 1) = Inv(D) L x_(k + 1) + Inv(D) U x_k + Inv(D) b
    $
    令 $Delta x = x_(k + 1) - x_k$ 称为修正项。如果给修正项加一系数 $omega$ （称为松弛因子），也即：
    $
      x_(k + 1) = x_k + omega Delta x
    $
    迭代公式变为：
    $
      x_(k + 1) = (1 - omega) x_k + omega (Inv(D) L x_(k + 1) + Inv(D) U x_k + Inv(D) b)
    $
    若 $omega > 1$ 则称为超松弛迭代，否则 $omega < 1$ 时称为低松弛迭代。上面的迭代公式等价于：
    $
      x_(k + 1) = L_omega x_k + omega(D - omega L)^(-1) b\
      where L_omega = Inv((D - omega L)) ((1 - omega) D + omega U)
    $
    #theorem[][
      SOR 迭代法收敛的充要条件是 $rho(L_omega) < 1$
    ]
    #theorem[][
      SOR 迭代法收敛的必要条件是 $0 < omega < 2$
    ]
    #proof[
      不难发现若迭代法收敛，则：
      $
        abs(det(L_omega)) < 1\
        abs(det((1 - omega) D + omega U)) < abs(det(D - omega L))\
        abs(det((1 - omega) I + omega U Inv(D))) < abs(det(I - omega L Inv(D)))\
        abs(1 - omega)^n < abs(1)^n\
      $
      化简立得结果
    ]
    #theorem[][
      若 $A$ 严格对角占优或不可约对角占优的，则当 $omega in (0, 1]$ 时迭代法收敛
    ]
    #theorem[][
      若 $A$ 是实对称正定的，则当 $omega in (0, 2)$ 时迭代法都收敛。
    ]
    #proof[
      设：
      $
        Inv((D - omega L))((1 - omega) D + omega L) x = lambda x\
        (1 - omega) D x + omega U x = lambda (D - omega L) x\
        (1 - omega) x^* D x + omega x^* U x = lambda x^* D x - lambda omega x^* L x\
      $
      令 $x^* D x = delta, x^* L x = beta$，将有：
      $
        (1 - omega) delta + omega overline(beta) = lambda delta - lambda omega beta\
        (1 - omega) delta + omega overline(beta) = lambda (delta - omega beta)\
      $
      同时我们有：
      $
        x^* (D - L - U) x > 0\
        x^T D x > x^T L x + overline(x^T L x)\
        delta > beta + overline(beta)
      $<cond1>
      假设 $delta = omega beta$，意味着 $beta$ 是正实数，且有有：
      $
        omega beta > 2 beta
      $
      与 $omega < 2$ 矛盾。因此有：
      $
        lambda &= ((1 - omega) delta + omega overline(beta))/(delta - omega beta) \
        norm(lambda)^2 &= norm((1 - omega) delta + omega overline(beta))^2/norm(delta - omega beta)^2\
        &=(((1 - omega) delta + omega overline(beta))((1 - omega) delta + omega beta))/((delta - omega beta)(delta - omega overline(beta)))\
        &=((1 - omega)^2 delta^2 + omega(1-omega)delta (beta + overline(beta)) + omega^2 norm(beta)^2)/(delta^2 - omega delta (beta + overline(beta)) + omega^2 norm(beta)^2)\
        &=((1 - omega)^2 delta^2 + omega delta (beta + overline(beta)) - omega^2 delta (beta + overline(beta)) + omega^2 norm(beta)^2)/(delta^2 - omega delta (beta + overline(beta)) + omega^2 norm(beta)^2)\
        $
        往证上式 $<1$，也即：
        $
          (1 - omega)^2 delta^2 + omega delta (beta + overline(beta)) - omega^2 delta (beta + overline(beta)) + omega^2 norm(beta)^2 < delta^2 - omega delta (beta + overline(beta)) + omega^2 norm(beta)^2\
          -2 omega delta^2 + omega^2 delta^2 + 2 omega delta (beta + overline(beta)) - omega^2 delta (beta + overline(beta)) < 0 \
          delta^2 omega (omega - 2) + omega delta (beta + overline(beta))(2 - omega) < 0 \
          delta omega (2 - omega) (-delta +  (beta + overline(beta))) < 0 \
        $
        注意到正定矩阵对角元均正，因此 $delta > 0$，结合@cond1 立得结论成立。
        // &= norm(((1 - omega) delta + omega overline(beta))(delta - omega overline(beta)))/((delta - omega beta)(delta - omega overline(beta)))\
        // &= norm((1 - omega)delta^2 - omega (1-omega) delta overline(beta) + omega delta overline(beta) - omega^2 overline(beta)^2)/((delta - omega beta)(delta - omega overline(beta)))\
        // &= norm((1 - omega)delta^2 + omega^2 delta overline(beta) - omega^2 overline(beta)^2)/((delta - omega beta)(delta - omega overline(beta)))\
      
      // 假设 $lambda > -1$，则 $omega + lambda omega > 0$，有：
      // $
      //   (omega + lambda omega) x^T D x  > 2 (omega + lambda omega) x^T L x = -2 (1 - omega - lambda) x^T D x\
      //   (2 - omega - 2 lambda + lambda omega) x^T D x > 0\
      //   (lambda - 1)(omega - 2) x^T D x > 0\
      //   (lambda - 1) x^T D x < 0
      // $
      // 上面的不等式已经表明 $x^T D x != 0$，而若 $x^T D x < 0$，将有 $x^T L x < 0, lambda > 1, 1 - omega - lambda < 0, omega(1 + lambda) > 0$
    ]
= 特征值问题  
  #definition[特征值和特征向量][
    设 $A in CC^(n times n)$，若存在 $lambda in CC, x in CC^n, x != 0$ 使得：
    $
    A x = lambda x
    $
    则称 $lambda$ 为 $A$ 的特征值，$x$ 为对应的特征向量。

    我们记 $lambda(A)$ 为 $A$ 特征值的集合，称为 $A$ 的谱集。称特征值在特征多项式中的重数为代数重数 $n_i$，几何重数称为 $m_i$
  ]
  矩阵特征值当然可以通过特征多项式计算，然而高次多项式求根是很困难的问题，因此求特征值往往会通过迭代法进行。
  #proposition[][
    设 $A = P B Inv(P)$，其中 $P$ 是非奇异矩阵，则 $A, B$ 有相同的特征值，特征向量由 $P$ 变换可得。
  ]
  #theorem[Jordan 分解][
    设 $A$ 有 $r$ 个互不相同的特征值 $lambda_1, lambda_2, ..., lambda_r$，其代数重数分别为 $n_1, n_2, ..., n_r$，则存在非奇异矩阵 $P$ 使得：
    $
    P^(-1) A P = diag(J(lambda_1), J(lambda_2), ..., J(lambda_r))
    $
    其中 $J(lambda_i) in CC^(n_i times n_i)$ 由 Jordan 块构成。
  ]
  #theorem[Schur 分解][
    设 $A in CC^(n times n)$，则存在酉矩阵 $Q$ 使得：
    $
    Q^T A Q = T
    $
    其中 $T$ 是上三角矩阵。
  ]
  实践上，Jordan 分析并非不可行，但往往数值相当不稳定，而 Schur 分解更加稳定。
  == 幂法
    如果我们只想要计算模最大的特征值，那么幂法是相当简单实用的方法。
    #algorithm[幂法][
      任取初值 $x_0$ 使得 $norm(x_0) = 1$，令：
      $
        x_(k + 1) = (A x_k) / norm(A x_k)\
        lambda_(k +1) = inner(x_(k + 1), A x_(k + 1))
      $
      不断迭代即可。显然事实上有：
      $
        x_k = (A^k x_0) / norm(A^k x_0)\
      $
    ]
    #theorem[][
      假设 $A$ 存在唯一模最大的特征值，其代数重数等于几何重数，且初始向量 $x_0$ 在 $lambda_1$ 的特征子空间的投影不为零，则在幂法中，$x_k$ 确实收敛于 $A$ 的模最大特征值对应的特征向量，而 $lambda_k$ 收敛于该特征值。
    ]<power_method>
    #proof[
      不妨设：
      $
        A = P diag(J(lambda_1), J(lambda_2), ..., J(lambda_r)) Inv(P)
      $
      其中 $abs(lambda_1) > abs(lambda_i), i != 1$则：
      $
        A^k x_0 = P diag(J(lambda_1)^k, J(lambda_2)^k, ..., J(lambda_r)^k) Inv(P) x_0
      $
      #lemma[][
        设 $J(lambda)$ 是 Jordan 块，$abs(lambda') > abs(lambda)$，则：
        $
          (J(lambda) / lambda')^k -> 0
        $
      ]
      由引理，有：
      $
        A^k x_0 = lambda_1^k P diag(I, (J(lambda_2) / lambda_1)^k, ..., (J(lambda_r)/ lambda_1)^k) Inv(P) x_0 \
        (A^k x_0)/norm(A^k x_0) = (P diag(I, (J(lambda_2) / lambda_1)^k, ..., (J(lambda_r)/ lambda_1)^k) Inv(P) x_0) / norm(P diag(I, (J(lambda_2) / lambda_1)^k, ..., (J(lambda_r)/ lambda_1)^k) Inv(P) x_0)\
        -> (P diag(I, 0, ..., 0) Inv(P) x_0)/norm(P diag(I, 0, ..., 0) Inv(P) x_0)
      $
      不难验证：
      $
        A (P diag(I, 0, ..., 0) Inv(P) x_0) &= P diag(J(lambda_1), 0, 0, ..., 0) Inv(P) x_0 \
        &= lambda_1 P diag(I, 0, 0, ..., 0) Inv(P) x_0
      $
      表明 $x_k$ 确实收敛于一个 $lambda_1$ 的特征向量，而 $lambda_k$ 收敛于 $lambda_1$ 是容易验证的。
    ]
    #remark[][
      - 容易看出幂法是指数收敛的，取决于 $abs(lambda_2 / lambda_1)$
      - 幂法的运算简单，收敛也很快，但在 $abs(lambda_2 / lambda_1)$ 比较接近 $1$ 时收敛较慢，且一旦 @power_method 中条件不成立，则幂法无法收敛。例如实矩阵可能有两个共轭的特征值，它们的模相等，此时幂法可能不收敛。
    ]
    #algorithm[带位移策略的幂法][
      我们可以转而用幂法计算 $A' := A - sigma I$ 的特征值，此时需要保证：
      - $lambda_1 - sigma$  是 $A - sigma I$ 的最大特征值
      - $max_(i != 1) abs((lambda_i - sigma) / (lambda_1 - sigma))$ 尽可能小
      这种加速很直观，但一般来说 $sigma$ 很难选取到合适的值。
    ]
    #algorithm[带位移策略的反幂法][
      如果将幂法用于 $Inv(A)$，就可以求出 $A$ 的模最小特征值：
      - 选取初值 $x_0, sigma$
      - $x_(k + 1) = ((A - sigma I)^(-1) x_k)/norm((A - sigma I)^(-1) x_k)$
      它可以收敛到与 $sigma$ 最近的特征值。如果能取得与某个 $lambda$ 比较近的 $sigma$，则算法收敛将很快。实践上，我们不会求逆，而是对矩阵：
      $
      A - sigma I
      $
      作 LU 分解，然后再解线性方程组。
    ]
    #algorithm[Rayleigh 商迭代][
      在上面的方法中，我们希望 $sigma$ 离 $lambda$ 越近越好。事实上，我们可以动态地调整 $sigma$
      - 选取初值 $x_0$ 使得 $norm(x_0) = 1$
      - 在每步中，取：
        $
          sigma_k = inner(x_k, A x_k)
        $
        令：
        $
          x_(k + 1) = ((A - sigma_k I)^(-1) x_k)/norm((A - sigma_k I)^(-1) x_k)
        $   
    ]
    #theorem[][
      若 Rayleigh 商迭代收敛到某个单特征值，则其收敛速度至少是二次的。若矩阵 $A$ 是对称的，则收敛速度可以达到局部的三次收敛。
    ]
    Rayleigh 商迭代有极快的收敛速度，然而每次要解不同的线性方程组，每步计算量更大。
  == QR 迭代
    #algorithm[QR 迭代][
      - 取初值 $A_1 = A$
      - 对矩阵 $A_k$ 做 $Q R$ 分解，有：
        $
          A_(k) = Q_k R_k
        $
      - 令：
        $
          A_(k + 1) = R_k Q_k
        $
    ]
    #remark[][
      事实上有：
      $
        A_(k + 1) &= R_k Q_k \
        &= (Q_k^T Q_k) R_k Q_k\
        &= Q_k^T A_k Q_k\
        &= ...\
        &= Q_k^T Q_(k-1)^T ... Q_1^T A Q_1 ... Q_(k-1) Q_k
      $
    ]
    #let Qt = $tilde(Q)$
    #let Rt = $tilde(R)$
    接下来，我们记:
    $
      Qt_k = Q_1 ... Q_k\
      Rt_k = R_k ... R_1
    $
    将有：
    $
      A_(k + 1) &= Qt_k^T A Qt_k\ 
      Qt_k Rt_k &= Qt_(k - 1) Q_k R_k Rt_(k-1) = Qt_(k - 1) A_k Rt_(k-1)\
                &= Qt_(k -1)  Qt_(k-1)^T A Qt_(k-1) Rt_(k-1)\
                &= A Qt_(k-1) Rt_(k-1)\
                &= ...\
                &= A^k
    $
    这表明 $Qt_k Rt_k e_1 = A^k e_1$，换言之按照幂法当 $k$ 充分大时，$Qt_k Rt_k$ 的第一列将收敛到 $A$ 的模最大特征值对应的特征向量。类似的，有：
    $
      A Qt_k &= Qt_k A_(k +1) = Qt_k Q_(k + 1) R_(k + 1) = Qt_(k + 1) R_(k + 1)\
      Qt_(k + 1) &= A Qt_k Inv(R_(k + 1)) = Inv(((A Qt_k Inv(R_(k + 1)))^T))\
      &= Inv((A^T)) Qt_(k) R^T_(k + 1)\
      Qt_(k + 1) e_n &= Inv((A^T)) Qt_(k) R^T_(k + 1) e_n = c_n Inv((A^T)) Qt_(k) e_n\
      &= ... \
      &= c (A^T)^(-k) e_n
    $
    也就是说最后一列和反幂法的现象是一致的。
    #theorem[][
      设 $A$ 具有 $n$ 个互不相等的特征值：
      $
        abs(lambda_1) > abs(lambda_2) > ... > abs(lambda_n)
      $
      设 $n$ 阶方阵 $Y$ 的第 $i$ 行是 $lambda_i$ 对应的特征向量。若 $Y$ 有 LU 分解，则 QR 方法产生的 $A_m$ 对角线以下元素收敛到零，并有第 $i$ 个对角元收敛于 $lambda_i$
    ]
    #proof[
      令 $X = Inv(Y), Lambda = diag(lambda_i)$，则：
      $
        A = X Lambda Y\
        A^m = X Lambda^m Y = X Lambda^m L U = X (Lambda^m L Lambda^(-m)) Lambda^m U
      $
      由条件，可以验证：
      $
        Lambda^m L Lambda^(-m) -> I
      $
      再令 $X = Q R$，不妨设 $R$ 对角元均正，则：
      $
        X (Lambda^m L Lambda^(-m)) Lambda^m U = Q  (R Lambda^m L Lambda^(-m) Inv(R)) R Lambda^m U 
      $
      当 $m$ 足够大时 $R Lambda^m L Lambda^(-m) Inv(R)$ 也非奇异，对其做 QR 分解得：
      $
        (R Lambda^m L Lambda^(-m) Inv(R)) = Q_m R_m
      $
      且：
      $
        Q_m -> I\
        R_m -> I
      $
      最终有：
      $
        A^m = (Q Q_m)(R_m R Lambda^m U)
      $
      这是 $A^m$ 的一个 QR 分解，而由 QR 分解的唯一性：
      $
        Q Q_m D_1 = Qt_m\
        D_1 R_m R Lambda^m U = Rt_m
      $
      其中 $D_1$ 是由 $1, -1$ 组成的对角阵。注意到 $A_m = Qt_m^T A Qt_m$，代入得：
      $
        A_m = D_1 Q_m^T Q^T A Q Q_m D_1 = D_1 Q_m^T Q^T Q R Lambda Inv(R) Q^T Q Q_m D_1\
        = D_1 Q_m^T R Lambda Inv(R) Q_m D_1
      $
      而 $Q_m -> I$，验证发现上式确实趋近于上三角矩阵，且对角元依次就是 $lambda_i$
    ]
    #algorithm[带位移的 QR 方法][
      QR 方法也可以进行位移，也就是：
      - $A_k - sigma_k I = Q_k R_k$
      - $A_(k + 1) = R_k Q_k + sigma_k I$
      其中有：
      $
        A_(k + 1) = Q_k^T Q_k R_k Q_k + sigma_k I = Q_k^T (A_k - sigma_k I) Q_k + sigma_k I = Q_k^T A_k Q_k
      $
      如何选择 $sigma_k$ 是一个需要考虑的问题。可以设想，若 $sigma_k$ 比较接近最小特征值，则收敛可以明显加速。因此实践中往往取 $sigma_k = A_(k (n n))$
    ]
    一旦矩阵有复特征值，我们就不能希望 QR 迭代收敛于上三角矩阵。此时我们需要借助：
    #theorem[实 Schur 分解][
      设 $A in RR^(n times n)$，则存在正交矩阵 $Q$ 使得：
      $
        Q^T A Q = diag(R_1, R_2, ..., R_n)
      $
      其中 $R_i$ 要么是单个特征值，要么是由共轭特征值产生的 $2 times 2$ 块。
    ]
    QR 分解和矩阵乘法的复杂度达到 $O(n^3)$，而若迭代进行 $n$ 次，复杂度达到 $O(n^4)$，这是通常不能接受的。
    #definition[上 Hessenberg 矩阵][
      称矩阵 $H$ 为上 Hessenberg 矩阵，如果 $H_(i j) = 0, i > j + 1$，也就是次对角线以下都为零
    ]
    #theorem[][
      设 $A in RR^(n times n)$，则存在正交矩阵 $Q$ 使得：
      $
        Q^T A Q = H
      $
      其中 $H$ 是上 Hessenberg 矩阵。
    ]
    #algorithm[][
      求解上 Hessenberg 分解的方法是：
      - 先对 $A$ 的第一列做 Householder 变换，将第一列次对角线以下变为零，设变换矩阵为 $Q$
      - 令 $A_1 = Q A Q^T$，容易验证 $A_1$ 第一列次对角线以下元素为零
      - 再对 $A_1$ 的第一列做 Householder 变换，重复进行以上步骤即可
    ]
    计算量为约为 $14/3 n^3$
    #theorem[][
      - 设 $A$ 是非奇异的上 Hessenberg 矩阵，且 QR 分解后 $A = Q R$，则 $R Q$ 也是上 Hessenberg 矩阵。
      - 若 $A$ 是主对角线和次对角线上没有零的上 Hessenberg 矩阵，它是不可约的
      - 若 $A$ 是不可约的上 Hessenberg 矩阵，则 $R Q$ 也是不可约的上 Hessenberg 矩阵
    ]
    对上 Hessenberg 矩阵进行 QR 分解时，可以考虑利用 $n-1$ 个 Givens 变换，一次迭代计算量仅有 $O(n^2)$