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
    ]<convergence-speed>
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
= 函数的插值与逼近
  假设函数 $f(x)$ 在 $x_0$ 处各阶导数都存在，我们就可以使用泰勒展开：
  $
    f(x) = sum_i 1/(i !) f^(i) (x_0) (x - x_0)^i 
  $
  逼近函数。同时，只要函数连续，就一定可以用多项式在闭区间上一致逼近某个函数。具体找到这个多项式的方法大致分成两类：
  - 插值逼近
  - 最佳逼近
  == 多项式插值
    假设我们知道函数 $f(x)$ 在若干个点 $x_i$ 上的值，找到一个经过这些点的多项式的问题称为插值问题。称满足这样的条件的多项式为*插值多项式*。
    #theorem[存在唯一性][
      给定 $n + 1$ 个不同的插值节点，则存在唯一的次数不超过 $n$ 的多项式是插值多项式。
    ]
    #proof[
      设任意一个不超过 $n$ 次的多项式为：
      $
        sum_(i = 0)^n a_i x^i
      $
      它是插值多项式当且仅当系数是线性方程组：
      $
        sum_(i = 0)^n a_i x_k^i = y_k, forall k = 1, 2, ..., n + 1
      $
      注意到这是线性方程组，系数矩阵是范德孟德矩阵，是非奇异的，因此解存在唯一。
    ]
    理论上，可以直接通过解线性方程组的方法求出所有系数，但是代价很高，我们往往不会这么做。
    === 拉格朗日插值
      显然，如果只有两个点，我们可以直接找到连接两点的线段。一般的，我们希望找到 $l_i (x)$ 作为基函数使得：
      $
        l_i (x_j) = delta_(i j)
      $
      从而不难验证：
      $
        L_n (x) := sum_i f(x_i) l_i (x)
      $
      就是我们要找的插值多项式。事实上，可以取：
      $
        l_i (x) = (product_(j != i) (x - x_i) )/(product_(j != i)  (x_i - x_j))
      $
      接下来，需要计算插值后的误差。定义插值余项：
      $
        R(x) = f(x) - L_n (x)
      $
      #theorem[][
        假设函数 $f(x) in C^(n + 1)[a, b]$，则对任意 $x in [a, b]$，存在 $xi$ 使得：
        $
          R_n (x) = (f^(n + 1) (xi))/((n + 1)!) product_(i) (x - x_i) 
        $
      ]
      #proof[
        设：
        $
          R(x) = k(x) product_(i) (x - x_i) 
        $
        （既然 $R(x_i) = 0$）
        不妨设 $x != x_i, forall i$
        记：
        $
          W_(n + 1) (t) = product_(i) (t - x_i)\
          E(t) = R_n (t) - k(x) W_(n + 1) (t)
        $
        容易验证 $E(t)$ 有 $n + 2$ 个零点：
        $
          x, x_1, ..., x_(n + 1)
        $
        利用罗尔定理，将存在 $xi$ 使得：
        $
          E^(n + 1)(xi) = 0
        $
        解得：
        $
          k(x) = (f^(n + 1) (x))/((n + 1)!)
        $
      ]
      #remark[][
        尽管可以证明拉格朗日插值多项式可以一致逼近连续函数，但拉格朗日插值的余项事实上难以估计。同时如果采用等距的插值，算法的稳定性将会十分糟糕。
      ]
    === 牛顿多项式
      #definition[差商][
        对于函数 $f(x)$，定义差商为：
        $
          f[x] = f(x)\
          f[x, x_0] = (f(x) - f(x_0))/(x - x_0)\
          f[x, x_0, ..., x_k] = (f[x, x_1, ..., x_(k-1)] - f[x_0, x_1, ..., x_(k-1)])/(x - x_k)
        $
      ]
      #theorem[][
        - 
        $
          f[x_0, x_1, ..., x_n] = sum_(i = 0)^n (f(x_i))/(product_(j != i) (x_i - x_j))  
        $
        - 差商与节点的顺序无关
        - 设 $f(x)$ 的 $m$ 阶导数存在，则：
        $
          exists xi, f[x_0, ..., x_m] = (f^(m) (xi))/(m!)
        $
      ]
      #definition[牛顿多项式][
        对于函数 $f(x)$，定义牛顿多项式为：
        $
          N_n (x) =\ &f[x_0] + f[x_0, x_1] (x - x_0) + ... + f[x_0, x_1, ..., x_n] (x - x_0) (x - x_1) ... (x - x_(n-1))
        $
        其余项为：
        $
          R(x) = f(x) - N_n(x) = f[x, x_0, ..., x_n] (x - x_0) (x - x_1) ... (x - x_n)
        $
      ]
      #remark[][
        事实上，由插值多项式的唯一性，牛顿多项式应该和拉格朗日多项式是相同的，只是选择了不同的基函数因此看起来不太一样。此外，如果多加入一个点，拉格朗日插值需全部重新计算，而牛顿插值只需要添加一个项即可。
      ]
    === 分段低次多项式插值
      当插值节点很多时，之前构造的插值多项式次数会很高，逼近效果很多时候反而变差，这被称为 Runge 现象。一个解决此问题的简单想法是，将区间分成若干段，每段选取一个多项式进行逼近。
      ==== 分段线性插值
        #definition[分段线性插值][
          对于函数 $f(x)$，定义分段线性插值为插值点：
          $
            (x_i, f(x_i))
          $
          之间的连线。这是连续的分段线性函数，并且满足插值条件。
        ]
        实际构造分段线性函数的方法是，令：
        $
          l_(n, i) (x_j) = cases(
            (x - x_(i - 1))/(x_i - x_(i - 1)) "if" x_(i - 1) <= x <= x_i,
            (x_(i + 1) - x)/(x_(i + 1) - x_i) "if" x_i <= x <= x_(i + 1),
            0 "otherwise"
          )
        $
        这些函数就是我们的基函数，最后的逼近无非是：
        $
          phi_h (x) = sum_i f(x_i) l_(n, i) (x)
        $
        #theorem[][
          若 $f(x) in C^2[a, b]$，则：
          $
            abs(f(x) - phi_h (x)) <= (m h^2)/8
          $
          其中 $m = max_(a <= x <= b) abs(f''(x))$  且 $h = max_i (x_(i + 1) - x_i)$
        ]
        #proof[
          假设 $x in [x_(i - 1), x_i]$，将有：
          $
            phi_h (x) &= f(x_(i - 1)) (x - x_(i - 1))/(x_i - x_(i - 1)) + f(x_i) (x_i - x)/(x_i - x_(i - 1))\
          $
          它其实是两点的拉格朗日多项式，熟知结论误差估计，简单计算即可。
        ]
        上面的定理表明，分段线性插值有很好的逼近效果，但不幸的是它不是光滑函数。
      ==== 分段二次插值
        类似上面的思路，在每个小区间上做 Hermit 插值使得插值多项式光滑即可。
  == 最佳平方逼近
    自然的，我们要考虑怎样的逼近是最好的逼近。假如我们使用 2-范数，容易证明确实存在一个不超过 $n$ 次多项式 $p^*$，使得:
    $
      norm(f - p^*) = min_(p in P_n) norm(f - p)
    $
    显然，2-范数构成函数空间的内积，而多项式空间是有限维线性空间，因此使用正交投影即可。假设任取一组基向量，可以解以下的线性方程组：
    $
      integral_(a)^(b) (f (x) - sum_i C_i b_i (x)) b_j (x) dif x = 0\
      sum_i C_i integral_(a)^(b) b_i (x) b_j (x) dif x  = integral_(a)^(b) f(x) b_j (x) dif x\
    $
    当然，如果能取得一组正交基，方程组就变得非常简单。
    #definition[正交多项式][
      设 $rho(x)$ 是权函数，满足对于任意函数 $g(x)$，如果：
      $
        integral_(a)^(b) rho(x) g(x) dif x = 0
      $
      则 $g(x) eq 0$

      若定义函数空间的内积为：
      $
        inner(f, g) := integral_(a)^(b) rho(x) f(x) g(x) dif x
      $
      则上面的线性方程组给出系数矩阵：
      $
        (inner(b_i, b_j))_(i, j)
      $
      这是实对称的，因此可以对角化（事实上，就是对任意一组基 $b_i$ 做正交化）
    ]
= 数值微分与数值积分
  == 数值微分
    给定闭区间 $[a, b]$ 上函数 $f(x)$ 在某些点 $x_i$ 处的函数值，我们希望估计 $f(x)$ 的各阶导数在节点上的值，这被称为数值微分问题。
    === Taylor 展开
      假设 $x_i$ 是等分的，利用泰勒展开立刻有：
      $
        f(x_(i + 1)) = f(x_i) + f'(x_i) h + ...\
        f(x_(i - 1)) = f(x_i) - f'(x_i) h + ...
      $
      前式可以得到：
      $
        f'(x_i) = (f(x_(i + 1)) - f(x_i))/h - 1/2 h f''(xi)
      $
      称为前向差商公式。后式可以得到：
      $
        f'(x_i) = (f(x_i) - f(x_(i - 1)))/h + 1/2 h f''(xi)
      $
      称为后向差商公式。两式相减就有：
       $
         f'(x_i) = (f(x_(i + 1)) - f(x_(i - 1)))/(2 h) - 1/6 h^2 f'''(xi)
       $
       称为中心差商公式。类似的，对于二阶导数可以得到：
       $
         f''(x_i) = (f(x_(i + 1)) - 2 f(x_i) + f(x_(i - 1)))/(h^2) - 1/12 h^2 f''''(xi)
       $
       称为二阶的中心差商公式。余项上可以看出，$h$ 越小误差越低，但实际上 $h$ 过小时数值稳定性会变差。在许多实际问题中，这样的方法已经足够。
      === 插值型求导公式
        已知一些节点上的值，我们当然可以先做一次插值逼近，再用插值多项式的导数替代原函数的导数。这种方法称为插值型求导公式。事实上可以验证，两点拉格朗日插值得到的就是向后和向前差商公式，三点的拉格朗日插值在中心节点得到的就是中心差商公式（前一个和后一个节点可以得到更高精度的差商公式）。同时，插值型公式也不一定需要等距节点，也可以采用其他的插值方法，因此比泰勒公式给出的差商形式更加灵活。
    == 数值积分
      === 中点公式
        做非常简单的积分估计：
        $
          integral_(a)^(b) f(x) dif x approx (b - a) f((a + b)/2)
        $
        误差为：
        $
          integral_(a)^(b) f(x) - f((a + b)/2) dif x 
        $
        若设：
        $
          u(t) =  integral_((a + b)/2 - t)^((a + b)/2 + t) f(x) - f((a + b)/2) dif x
        $
        则：
        $
          u((b - a)/2) = u(0) + (b - a)/2 u'(0) + 1/8 (b - a)^2 u''(0) + 1/(48) (b - a)^3 u'''(xi)
        $ 
        也即：
        $
          integral_(a)^(b) f(x) - f((a + b)/2) dif x = 1/(48) (b - a)^3 (f''((a + b)/2 + xi) + f''((a + b)/2 - xi))
        $
        再利用中值定理，它就是：
        // 泰勒公式给出：
        // $
        //   integral_((a + b)/2)^(b) f(x) dif x = (b - a)/2 f((a + b)/2) +  (b - a)^2/8 f'((a + b)/2) + 1/192 (b - a)^3 f''(xi)
        // $
        $
          = 1/24 (b - a)^3 f''(xi)
        $
      === 梯形公式
        用线性插值逼近积分，有：
        $
          integral_(a)^(b) f(x) dif x approx integral_(a)^(b) P(x) dif x = (b - a)/2 (f(a) + f(b))
        $
        其中 $P(x)$ 是经过 $(a, f(a)), (b, f(b))$ 的直线，其误差为：
        $
          - 1/12 (b - a)^3 f''(xi)
        $
      === Simpson 公式/抛物型公式
        用二次插值逼近积分，有：
        $
          integral_(a)^(b) f(x) dif x approx integral_(a)^(b) P(x) dif x = (b - a)/6 (f(a) + 4 f((a + b)/2) + f(b))
        $
        其中 $P(x)$ 是经过 $(a, f(a)), ((a + b)/2, f((a + b)/2)), (b, f(b))$ 的二次曲线，其误差为：
        $
          - 1/2880 (b - a)^5 f^(4)(xi)
        $
    #definition[代数精度][
      若一个数值积分公式对于任意不高于 $n$ 次的多项式都精确成立，但村子啊 $n + 1$ 次多项式使得估计不精确，则称其具有 $n$ 阶代数精度。
    ]
    容易证明，中点公式/梯形公式具有一阶代数精度，Simpson 公式具有三阶代数精度。
      === Newton-Cotes
        一般的，假设有 $h-$等距节点，我们可以构造拉格朗日插值，再用多项式的积分逼近原函数的积分。这种方法称为 Newton-Cotes 方法。也就是：
        $
          integral_(a)^(b) f(x) dif x approx integral_(a)^(b) P(x) dif x\
          = integral_(a)^(b) sum_k (product_(j != k) (x-x_j)/(x_k - x_j) f(x_k)) dif x\
          =^(x = h t + a) integral_(a)^(b) sum_k (product_(j != k) (t-j)/(k - j) f(x_k)) dif x\
          =^(x = h t + a) h sum_k integral_(0)^(n)  (product_(j != k) (t-j)/(k - j) f(x_k)) dif t\
        $
        尽管公式十分复杂，但可以预先计算好所有系数（称为 N-C 求积系数），需要的时候直接查表。它至少具有 $n$ 阶代数精度。

    显然，这些公式通常只在区间较小时精确。一般计算积分时，往往先将函数分成若干小区间，再在每个小区间上使用上述公式，这就是复合积分公式。
    === 积分加速与 Romberg 求解方法
      假设某种积分公式的误差形如：
      $
        I - Q(h) = C_1 h^p + C_2 h^(p + 1) + ...
      $
      如果减半区间，就有：
      $
        I - Q(h/2) = C_1 (h/2)^p + C_2 (h/2)^(p + 1) + ...
      $
      配凑一下就有：
      $
        (1 - 2^p) I - (1 - 2^p ) Q(h/2) = C'_2 h^(p + 1) + ...
      $
      这个方法可以一直进行，从低精度的公式简单的得到高精度的公式，这称为 Richardson 外推法。它的应用非常广泛。如果对复合梯形公式：
      $
        integral_(a)^(b) f(x) dif x = T_1 (h)
      $
      运用，就得到一系列更高精度的公式（当然，这里事实上假设了余项中 $f''(xi)$ 都相差不大），这称为 Romberg 求积方法。
    === 高斯求积公式
      我们考虑带权的定积分估计公式：
      $
        integral_(a)^(b) f(x) rho(x) dif x approx sum_i c_i f(x_i)
      $
      我们的目标是固定节点的个数 $n$，找到最佳的节点选择方式，使得代数精度最高。事实上，也就是：
      $
        integral_(a)^(b) rho(x) x^k = sum_i c_i x_i^k
      $
      对于尽可能多的 $k$ 都成立。大致而言，我们有 $2 n$ 个未知数，应该期望恰有 $2 n$ 个方程，获得 $2 n - 1$ 阶代数精度。
= 常微分方程的数值解法
  给定一个确定初值的常微分方程：
  $
    cases(
      der(y, x) = f(x, y),
      y(a) = y_0,
    )
  $<standard-form>
  其中 $x in [a, b]$
  #theorem[][
    若@standard-form 中，$f(x, y)$ 是连续的，且对于 $y$ 满足 Lipschitz 条件，则解存在唯一，且解连续可导。
  ]
  数值上解方程的方法的基本思路是将区间 $[a, b]$ 分成小区间，再在小区间上做近似处理。
  #definition[常微分方程数值稳定性][
  给定一个数值方法，对于任意步长 $h$，求解：
  $
    y' = lambda y, Re(lambda) < 0
  $ 
  （该方程称为试验方程)
  得到节点上的函数值 $y_n$，若 $n -> +infinity$ 时 $y_n -> 0$，则称该方法在步长 $h$ 上绝对稳定，否则称其不稳定。 

  假设 $mu = lambda h$ 在区域 $Omega$ 上时绝对稳定，则称 $Omega$ 是该方法的绝对稳定域。

  ]
  == Euler 方法 
    回忆前向差商公式：
    $
      y'(x_i) = (y(x_(i + 1)) - y(x_i))/h - 1/2 h y''(xi)
    $
    反解出：
    $
      y(x_(i + 1)) approx y(x_i) + h y'(x_i) + 1/2 h^2 y''(xi) = y(x_i) + h f(x_i, y(x_i)) + 1/2 h^2 y''(xi)
    $
    这就是向前的 Euler 格式，通常称为显式格式。类似的由向后差商公式：
    $
      y'(x_i) = (y(x_i) - y(x_(i - 1)))/h + 1/2 h y''(xi)
    $
    可以得到向后的 Euler 格式：
    $
      y(x_(i)) = y(x_(i-1)) + h f(x_i, y(x_i)) - 1/2 h^2 y''(xi)\
      y(x_(i  + 1)) = y(x_(i)) + h f(x_(i + 1), y(x_(i + 1))) - 1/2 h^2 y''(xi)\
    $
    通常称为隐式格式。注意到如果使用隐式格式，我们会需要解出一个方程才能得到 $y_(i + 1)$。

    在向前 Euler 格式中，试验方程的解为：
    $
      y_(n + 1) = y_n + lambda h y_n = (1 + lambda h) y_n
    $
    因此绝对稳定域就是 $abs(1 + mu) < 1$

    可以想象，假设初值 $y_0$ 有一定误差得到 $y_0 + e_0$，则真实的计算方程为：
    $
      (y_n + e_n) = (1 + lambda h) (y_(n - 1) + e_(n - 1))\
      e_n = (1 + lambda h) e_(n - 1)
    $
    因此在绝对稳定域中，误差最终会收敛到零，否则误差会爆炸。

    而向后 Euler 格式的试验方程解为：
    $
      y_(n + 1) = y_n + h lambda y_(n + 1)\
      y_(n + 1) = (1 - lambda h)^(-1) y_n
    $
    因此稳定域为 $abs(1 - lambda h) > 1$，可见比向前 Euler 格式更加稳定。

    同时，如果采用中心差商公式，可以计算得到该格式对应的 Euler 格式总是不稳定的，因此不会采用这种公式。
  == 单步法的精度
    #definition[][
      - 称形如 $y_(n + 1) = y_n + phi(x_n, x_(n + 1), y_n, y_(n + 1), h)$ 的数值解法为单步法
      - 称 $tau_(n + 1) = y(x_(n + 1)) - y(x_n) - phi(x_n, x_(n + 1), y(x_n), y(x_(n + 1)), h)$ 为单步法的局部截断误差
      - 若 $tau_(n + 1) = O(h^(p + 1))$ 则称该单步法有 $p$ 阶精度
    ]
    对于向前 Euler 格式，有：
    $
      tau_(n + 1) = y(x_(n + 1)) - y(x_n) - h f(x_n, y(x_n))\ = (y(x_n) + h y'(x_n) + h^2/2 y''(x_n) + O(h^2)) - y(x_n) - h f(x_n, y(x_n))\
      = h^2/2 y''(x_n) + O(h^2)
    $
    因此它具有一阶精度，主项为 $(y''(x_n))/2$

    类似的，向后 Euler 格式有：
    $
      tau_(n + 1) = - h^2/2 y''(x_(n + 1)) + O(h^3)
    $

    注意到一般我们有：
    $
      y(x + h) = y(x) + integral_(x)^(x + h) f(s, y(s)) dif s 
    $
    利用矩形公式，有：
    $
      y(x_n + h) = y(x_n) + h f(x_n, y(x_n)) + R_n
    $
    其中：
    $
      R_n 
      &<= abs(integral_(x_n)^(x_n + s) f(s, y(s)) - f(x_n, y(x_n)) dif s )\
      &<= integral_(x_n)^(x_n + s) abs(f(s, y(s)) - f(x_n, y(x_n)) dif s )\
      &<= integral_(x_n)^(x_n + s) abs(f(s, y(s)) - f(x_n, y(s)) + f(x_n, y(s)) - f(x_n, y(x_n)) dif s )\
      &<= integral_(x_n)^(x_n + s) k abs(s - x_n) + L abs(y(s) - y(x_n)) dif s\
      &<= integral_(x_n)^(x_n + s) k abs(s - x_n) + L M_y' abs(s - x_n) dif s\
      &<= h^2/2 (k + L M_y')
    $
    因此：
    $
      y_(n + 1) - y(x_(n + 1)) = y_n + h f(x_n, y_n) - y(x_n + h) \
      = y_n  + h f(x_n, y_n) - (y(x_n) + h f(x_n, y(x_n)) + R_n)\
      = (y_n - y(x_n)) + h(f(x_n, y_n) - f(x_n, y(x_n))) - R_n\
    $
    再做推导即得：
    #theorem[][
      设 $f$ 关于 $x, y$ 满足 Lipschitz 条件，则向前 Euler 格式的解一致收敛于真实解，并且整体截断误差满足：
      $
        e_n = O(h)
      $
    ]
  == Runge-Kutta 方法
    在上面的单步法通用格式中，Euler 方法只利用了一阶导数的信息。而我们希望让 $phi$ 更加复杂，使得 $y(x + h)$ 与 $h phi$ 有更高阶的相同项。例如，我们可以取两个点 $(x, y), (x + a_2 h, y + b_2 h f(x, y))$：
    并设：
    $
      phi(x, y, f, h) = c_1 f + c_2 f(x + a_2 h, y + b_2 h f)
    $
    泰勒展开得到：
    $
      phi(x, y, f, h) = c_1 f + c_2 (f + a_2 h f_x + b_2 h f_y f) + O(h^2)\
    $
    比对：
    $
      y(x + h) = y(x) + h y'(x) + h^2/2 y''(x) + O(h^3)\
      = y(x) + h f + h^2/2 (f_x + f_y y) + O(h^3)
    $
    得到方程：
    $
      cases(
        c_1 + c_2 = 1,
        c_2 a_2 = 1/2,
        c_2 b_2 = 1/2
      )
    $
    不难验证方程有无穷多解。任取一组解都可以获得一个数值格式。例如若取 $c_1 = c_2 = 1/2, a_2 = b_2 = 1$，就得到：
    $
      y_(n + 1) = y_n + h/2 f(x_n, y_n) + h/2 f(x_n + h, y_n + h f(x_n, y_n))
    $
    这样得到的数值格式被称为二阶的 Runge-Kutta 方法（或者改进的 Euler 方法）。类似的，可以构造更高阶的 Runge-Kutta 方法。
    #definition[显式 Runge-Kutta][
      设 $m$ 是正整数，代表 Runge-Kutta 采用的点的个数，则 $m$ 级显式 Runge-Kutta 方法的格式为：
      $
        y_(n + 1) = y_n + h sum_(i = 1)^m c_i k_i
      $
      其中：
      $
        k_1 = f(x_n, y_n)\
        k_2 = f(x_n + a_2 h, h b_(2 1) k_1)\
        ... \
        k_m = f(x_n + a_m h, h sum_(i = 1)^(m - 1) b_(m i) k_i)
      $
      事实上，往往有：
      $
        sum_i c_i = 1\
        a_i = sum_j b_(i j)
      $
    ]
    常用的公式还有四阶古典显式 Runge-Kutta 方法：
      $
        y_(n + 1) = y_n + h/6 (k_1 + 2 k_2 + 2 k_3 + k_4)\
        k_1 = f(x_n, y_n)\
        k_2 = f(x_n + h/2, y_n + h/2 k_1)\
        k_3 = f(x_n + h/2, y_n + h/2 k_2)\
        k_4 = f(x_n + h, y_n + h k_3)
      $
    可以证明，四阶 Runge-Kutta 方法的阶数为 $4$，而五阶方法的最高阶数也是 $4$，因此 $4$ 阶 Runge-Kutta 方法比较常用。（只需要记住改进的 Euler 方法和四阶古典 Runge-Kutta 方法即可）

    接下来，考虑三级三阶显式 Runge-Kutta 方法的稳定性：
    $
      y_(n + 1) = y_n + h/6 (k_1 + 4 k_2 + k_3)\
      k_1 = f(x_n, y_n)\
      k_2 = f(x_n + h/2, y_n + h/2 k_1)\
      k_3 = f(x_n + h, y_n - h k_1 + 2 h k_2)
    $
    在方程 $y' = lambda y$ 上考虑，计算得：
    $
      y_(n + 1) = (1 + lambda h + 1/2 (lambda h)^2 + 1/6 (lambda h)^3) y_n
    $
  == 线性多步法的预估校正格式
    微分方程也可以化成积分形式：
    $
      y(x) = y(x_0) + integral_(x_0)^(x) f(s, y(s)) dif s
    $
    从而可以得到积分近似：
    $
      y_(n + 1) = y_(n - p) + sum_(j = 0)^q alpha_j f(x_(n - j), y_(n - j))
    $
    其中 $alpha_j = 1/h integral_(x_(n - p))^(x_(n + 1)) l_j (t) dif t$，$l_j$ 在 $x_0, ..., x_n$ 点上的第 $j$ 个拉格朗日插值基函数。
     
    我们记 $r = max(p, q)$ ，则称该方法为 $r + 1$ 步 $q + 1$ 阶显式方法，则可以得到许多积分格式，例如 $p = 1, q = 2$ 有：
    $
      y_(n + 1) = y_(n - 1) + h/3 (7 f_(n) - f_(n - 1) + 6 f_(n - 2))
    $

    类似的，可以产生 $r+1$ 步 $q+1$ 阶隐式的积分格式：
    $
      y_(n + 1) = y_(n - p) + sum_(j = 0)^q alpha_j f(x_(n + 1 - j), y_(n + 1 - j))
    $
    常用的格式包括：
    - $p = 2, q = 2$ 的三步三阶隐式格式：
      $
        y_(n + 1) = y_(n - 2) + h/4 (3 f_(n + 1) + 9 f_(n -1))
      $
    - $p = 0$ 的 Adam 格式，包括：
      - $q = 1$ 的二步显式 Adam 格式：
        $
          y_(n + 1) = y_n + h/2 (3 f_(n) - f_(n - 1))
        $
      - 二步隐式 Adam 格式：
        $
          y_(n + 1) = y_n + h/2 (f_(n + 1) + f_n)
        $（也称为梯形法）
    通常而言，隐式法稳定性强，但需要解方程组，计算量较大。
  #definition[预估-校正格式][
    预估-校正的思路是先用某种格式预估 $y_(n + 1)$，再用另一种格式校正（用预估的值替代等式右侧的目标值）。例如，可以先用欧拉方法预估，得到：
    $
      y_(n + 1)^* = y_n + h f(x_n, y_n)
    $
    再用二步隐式 Adam 格式（梯形公式）校正：
    $
      y_(n + 1) = y_n + h/2 (f(x_(n + 1), y_(n + 1)^*) + f_n)
    $
    称为改进的 Euler 公式。常用的还有：
    - 改进的四点 Adam 公式：先用四点显式 Adam 格式预估，再用四点隐式 Adam 格式校正。
  ]
  预估-校正格式通常综合了显式法和隐式法的优点，稳定性较高，也不需要解方程组。
  == 方程组及高阶方程
    由于常微分方程的格式特点，高阶方程可以很简单的化为一阶方程组，因此它们的解法是几乎相同的。而解方程组的方法和解方程的方法也是一致的，只需把前面的计算过程中的标量替换为向量即可。然而，实际上可能会遇到所谓的刚性方程组：
    $
      vec(y', z') = mat(-1000, -900;0, -1) vec(y, z)
    $
    如果要使用显式 Euler 方法，需要很小的步长才能保证稳定性，这是因为矩阵两个特征值相差很大。因此我们希望使用很稳定的方法。
    #definition[刚性方程组][
      称方程组：
      $
        y' = A y + phi(t)
      $
      是刚性的，如果 $A$ 的特征值均满足 $Re(lambda_i) < 0$，且：
      $
        S = (max abs(Re(lambda_i)))/(min abs(Re(lambda_i))) 
      $
      （称为刚性比）远大于 $1$。
    ]
    #definition[][
      若绝对稳定域包含整个左半平面，则称数值方法是 A-稳定的。
    ]
    #theorem[][
      - 任何显式线性多步法不可能是 A-稳定的。
      - A-稳定的隐式线性多步法至多是二阶的。
      - 具有最小误差常数的隐式 A-稳定的线性多步法是梯形法
    ]
  == 分子动力学的数值方法
    #definition[经典体系的 Hamiltonian][
      经典体系的 Hamiltonian 为：
      $
        H = H(r, p) = K(p) + U(r) = sum_i (p_i^2)/(m_i) + U(r)
      $
      结合经典的牛顿定律：
      $
        F_i = m_i derN(r_i, t, 2)
      $
      以及：
      $
        F_i = - nabla U(r) 
      $

      或者也可以解动量-速度方程：
      $
        der(r_i, t) = partialDer(H(r, p), p)\
        der(p_i, t) = - partialDer(H(r, p), r_i)
      $
    ]
    通常来说，方程本身并不复杂，但数量非常巨大，因此可能需要特殊的微分格式。
    #definition[Verlet 算法][
      Verlet 算法是一种特殊的分子动力学算法，它的基本思路是：
      $
        r_(n + 1) = r_n + v_n Delta t + 1/2 (F_n / m) Delta t^2\
        r_(n - 1) = r_n - v_n Delta t + 1/2 (F_n / m) Delta t^2\
      $
      导出：
      $
        v_n = (r_(n + 1) - r_(n - 1))/(2 Delta t)
      $
    ]
    #definition[蛙跳格式][
      蛙跳格式的想法是，用两侧的速度来替代中心的速度：
      $
        v_n = 1/2 (v_(n + 1) + v_(n - 1))\
        r_(n + 1) = r_n + v_(n + 1/2) Delta t
      $
      进而有速度 Verlet 方法：
      $
        r_(n + 1) = r_(n - 1) + v_n Delta t + 1/2 (F_n / m) Delta t^2\
        v_(n + 1) = v_n + 1/2 (F_n + F_(n + 1))/m Delta t
      $
    ]
= 数值最优化方法
  == 无约束最优化方法的基本结构
    #let xs = $x^*$
    给定一个函数 $f(x)$，我们希望找到 $x^*$ 使得 $f(x^*)$ 最小。这就是无约束最优化问题。通常而言，重点是找到一阶导数为零的点。一般的，一阶导数为零的点未必是极值点，我们称不是极值点的点为鞍点。本章中，用 $g(x) = nabla f(x)$ 记一阶导数，用 $G(x) = nabla^2 f(x)$ 记二阶导数（Hessian 矩阵）。

    #theorem[][
      - $xs$ 为极小点的必要条件是 $g(xs) = 0$
      - $xs$ 为极小点的必要条件是沿每个方向的方向导数为零
      - $xs$ 为极小点的必要条件是 $G(xs)$ 半正定
      - 若 $g(xs) = 0, G(xs)$ 正定，则 $xs$ 为严格极小点
    ]

    通常数值优化方法都是迭代算法，基本的步骤如下：
    + 选择初始点 $x_0$
    + 确定下降方向 $d_n$ 和步长 $alpha_n$
    + 更新 $x_(n + 1) = x_n + alpha_n d_n$
    + 重复直到满足终止条件（一般为梯度较小/上一步步长很小/函数值变化很小）
    基本上，这样的方法可以分成两类：
    - 线搜索方法：先确定方向，再确定步长
    - 信赖域方法：先设定一个信赖域，再在信赖域内寻找合适的方向和步长
    通常而言，有些问题中任意选取初值迭代都能收敛，称为全局收敛。否则，只要初值选择较好时才能收敛，称为局部收敛。我们也用 @convergence-speed 中的概念来描述算法的收敛速度。

    有时，我们也会考虑所谓的*二次终止性*，也就是检查一个算法是否能在有限步找到正定二次函数的极小点。
    #example[线搜索准则][
      假设采用线搜索方法，也就是假设已经确定了步长，应该如何找到最优的步长？一般的，有以下几种方法：
      - 精确线搜索准则：直接找 $alpha$ 使得 $f(x_k + alpha d_k)$ 取得最小值。不难发现，此时一定有：
        $
          g(x_(k + 1))^T d_k = 0
        $
        然而，这种方法往往计算量很大，并在大多数时候并无必要如此精确。
      - 非精确线搜索：找 $alpha$ 只要满足 $f(x_k + alpha + d_k) < f(x_k)$ 即可，然而这样可能取出很小的步长，收敛较慢。
    ]
  == 线搜索
    最简单的线搜索当然是精确线搜索，也就是确定方向后，求：
    $
      min_alpha f(x_k + alpha alpha_k)
    $
    其中 $alpha_k$ 是事先确定的方向。再选择 $alpha alpha_k$ 为步长即可。它的缺点是计算量过大，很多时候没有必要。大多数时候，我们都会选择非精确线搜素策略，常见的准则包括：
    - Armijo 准则：
      $
        f(x_k + alpha alpha_k) <= f(x_k) + rho g_k^T alpha_k alpha
      $
      其中 $rho$ 是较小的正数
    - wolfa 准则：
      $
        f(x_k + alpha alpha_k) <= f(x_k) + rho g_k^T alpha_k alpha\
        g(x_k + alpha alpha_k)^T alpha_k >= sigma g_k^T alpha_k 
      $
    - 强 wolfa 准则：
      $
        f(x_k + alpha alpha_k) <= f(x_k) + rho g_k^T alpha_k alpha\
        abs(g(x_k + alpha alpha_k)^T alpha_k) <= - sigma g_k^T alpha_k\
      $
    实践上，我们往往还会为 $alpha$ 设置下界，防止下降过慢。
    #theorem[满足线搜索准则的步长的存在性][
      假设 $f(x_k + alpha alpha_k)$ 在 $alpha > 0$ 时有下界且 $g_k^T alpha_k < 0$，则存在 $alpha$ 满足 wolfa 准则。
    ]
    #theorem[线搜索的收敛性][
      假设 $f(x)$ 有下界 $g(x)$ 一致连续，每个 $d_k$ 与 $g_k$ 间夹角 $theta_k$ 一致有界 $0 <= theta_k <= pi/2$，且对某一 $mu > 0$，$0 <= theta_k <= pi/2 - mu$，则满足 wolfa 准则的迭代方法的梯度收敛于零。
    ]
    以上定理在理论上保证了线搜索准则的可行性，下面给出一些计算方法：
    - 黄金分割法：通常用于单峰函数。思路是选取初始区间 $[a, b]$，将 $[a, b]$ 按 0.618 比例缩小，使得线搜索的目标点在缩小后的区间中，直到区间长度足够小。具体做法是：
      + 首先选取 $a^l, a^r$ 使得 $a^r - a = b - a^l = tau(b - a)$
      + 若 $phi(a^l) <= phi(a^r)$，则选取 $[a, a^r]$ 作为下一次迭代的区间
      + 否则，选取 $[a^l, b]$
      这里 $tau$ 取多少其实无关紧要，但如果选取黄金分割，则如果选择 $[a, a^r]$，则上一次的 $a^l$ 恰好是下一次的 $a^l$，可以节约一些计算量。
    - 多项式插值：初步选取一些步长，如果这些步长不满足，在这些步长上构造一个插值多项式，再取该插值多项式的稳定点。检查该稳定点是否满足线搜索准则，如果不满足则再选取该点作为节点进行插值。通常是对 $0, 0', alpha_0, alpha_1, ...$ 进行多项式插值。
  == 负梯度方法与 Newton 型方法
    === 最速下降方法
      显然在 $x_k$ 的局部，下降最快的方向就是负梯度方向，因此我们往往就取负梯度方向下降。如果再取精确线搜索方法，算法就是最速下降方法。

      我们考虑优化正定二次函数时的收敛速度。假设函数为：
      $
        y = 1/2 x^T G x + b^T x
      $
      #theorem[][
        $
        (x^T x)^2
        /((x^T G x)(x^T Inv(G) x)) >= (4 lambda_min lambda^max)/(lambda_min + lambda^max)^2
        $
      ]
      注意到函数的极小点为：
      $
        - Inv(G) b
      $
      假设当前点是 $x_k$，负梯度方向为：
      $
        d_k = - G x_k + b
      $
      做精确线搜索：
      $
        min_alpha f(x_k - alpha g_k)
      $
      可以计算得：
      $
        alpha  = (g_k^T g_k)/(g_k^T G g_k)
      $
      因此迭代公式为：
      $
        x_(k + 1) = x_k - (g_k^T g_k)/(g_k^T G g_k) g_k
      $
      如果选取度量为 $norm(x) = x^T G x$，不难计算得：
      $
        1/2 norm(x_k - x^*)^2 = f(x_k) - f(x^*)
      $
      #theorem[收敛速度][
        $
          norm(x_(k + 1) - x^*)/norm(x_k - x^*) <= (lambda_max - lambda_min)/(lambda_max + lambda_min)\
          = ("cond"(G) - 1)/("cond"(G) + 1)
        $
      ]
      最速下降法每次计算的计算量和存储量都较小，收敛性也很强，对于绝大多数的初值都能至少收敛到局部极小点，适用范围很广。
    === Newton 方法
      之前的最速下降法只用到了一阶梯度，而 Newton 法希望同时用到一阶和二阶梯度。使用泰勒展开，有：
      $
        f(x_k + d) = f(x_k) + g_k^T d + 1/2 d^T G_k d + O(norm(d)^2)
      $
      如果我们就用：
      $
        q_k (d) = f(x_k) + g_k^T d + 1/2 d^T G_k d
      $
      这个二次型近似代替 $f(x_k + d)$，则下一步我们只需要求解 $q_k (d)$ 的极小值。若 $G_k$ 是正定的，则应该有：
        $
          G_k d_k = - g_k\
          d_k = - Inv(G_k) g_k
        $
        此时 $G_k d_k = - g_k$ 称为 Newton 方程，$d_k$ 称为 Newton 方法的方向。可以证明，只要 $G_k$ 是正定的，则 $g_k^T d_k = - g_k^T Inv(G_k) g_k < 0$，因此 $d_k$ 是下降方向。
      确定了方向后，如果我们就取 $alpha = 1$，就得到全步长的 Newton 方法。

      上面的方法中，$G_k$ 的正定性是很重要的条件。如果 $G_k$ 不是正定的，我们也可以按照上面的方法进行计算，然而收敛状况可能受初值的影响。甚至如果遇到 $G_k$ 奇异的情况，这种方法也只能直接失败。通常来说，初值比较接近目标点时，就能以很快的速度收敛；而当初始点较差时，收敛状况可能会很差。
      #theorem[Newton 法的收敛性][
        设 $f(x) in C^2$，其 Hessian 阵 $G(x)$ 满足 Lipschitz 条件：
        $
          norm(G(x) - G(y)) <= L norm(x - y)
        $
        若 $x_0$ 充分接近 $f(x)$ 的局部极小点 $x^*$ 且 $G(x^*)$ 正定，则 Newton 法可以以二次收敛速度收敛。
      ]
      
      Newton 法的特点是，如果能够收敛，就能以很快的速度收敛。同时，它还具有二次终止性（对于正定二次函数，可以在有限步终止）。然而，许多条件都可能导致它并不收敛，同时每步都要计算 Hessian 矩阵，再解线性方程组往往也是很大的计算量。
      #algorithm[阻尼 Newton 方法][
        为了改进 Newton 方法的收敛性，一种思路是不采用 $alpha_k = 1$，而是通过线搜索得到一个合适的步长，这就是阻尼 Newton 方法。同时，还可以处理一些特殊情况：
        - $G$ 奇异，往往下降方法直接取 $- g_k$
        - $g_k^T G_k g_k < 0$，导致 $d_k$ 不是下降方向，此时可以取 $- d_k$ 作为下降方向
      ]
      #algorithm[Levenberg-Morquard(LM)][
        为了解决 $G_k$ 不正定的问题，一种思路是加入一个参数 $v_k$，使得 $G_k + v_k I$ 正定。这就是 LM 方法。当 $v_k$ 变大时，该算法会从 Newton 方法逐渐趋近于负梯度方法。实践上，$v_k$ 是超参数，预先往往难以确定 $v_k$ 的选择是否足够让 $G_k + v_k I$ 正定，如果发现不正定，常用的方法是取两倍的 $v_k$。
      ]
    === 拟 Newton 方法
      计算 Hessian 矩阵往往还是计算量过大，因此我们希望找到一种方法，能够不用计算 Hessian 矩阵，但仍然能够保证收敛性。一种思路是用近似的 Hessian 矩阵代替真实的 Hessian 矩阵，这就是拟 Newton 方法。
      #algorithm[差商近似的 Newton 方法][
        取：
        $
          B_(i j) = 1/r_j (g(x_(k + 1)) - g(x_k))_i\
          B' = (B + B^T)/2
        $
        作为 Hessian 矩阵的近似，这就是差商近似的 Newton 方法。然而实践表明这种方法效果较差。
      ]
      为了改进差商逼近，我们尝试更加一般的，用 $x_k, x_(k + 1), g_k, g_(k + 1)$ 来逼近 Hessian 矩阵。往往将近似矩阵记为 $B_(k + 1)$，更进一步，可以找到 $H_(k + 1)$ 来近似 Hessian 矩阵的逆。这种方法需要保证 $B_(k + 1), H_(k + 1)$ 正定，还能保持较快的收敛速度。
      #definition[拟 Newton 条件][
        对梯度 $g(x)$ 做泰勒展开：
        $
          g(x) = g(x_(k + 1)) + G(x_(k + 1))(x - x_(k + 1)) + O(norm(x - x_(k + 1))^2)
        $
        一种直观的近似是：
        $
          G(x_(k + 1)) (x_k - x_(k + 1)) = g(x_k) - g(x_(k + 1))
        $
        因此，我们希望 $B_(k + 1)$ 也满足方程：
        $
          B_(k + 1) (x_k - x_(k + 1)) = g(x_k) - g(x_(k + 1))
        $<quasi-newton1>
        该方程称为拟 Newton 条件或者拟 Newton 方程。对应的，有：
        $
          H_(k + 1) (g(x_k) - g(x_(k + 1))) = x_k - x_(k + 1)
        $<quasi-newton2>
        通常记：
        $
          S_k = x_k - x_(k + 1)\
          y_k = g(x_k) - g(x_(k + 1))
        $
      ]
      #algorithm[拟 Newton 方法][
        + 选择初始值 $x_0$，对称正定矩阵 $H_0$
        + $d_k = - H_k g_k$
        + 沿 $d_k$ 进行线搜索，求得 $alpha_k$，令：
          $
            x_(k + 1) = x_k + alpha_k d_k
          $
        + 更新 $H_k$，使得 $H_(k + 1)$ 满足@quasi-newton2
        + 重复直到满足终止条件
      ]
        对于修正 $H_k$ 的方法，有着非常多的技巧，这里介绍三种：
        - Symmetric Rank One(SR1) 方法，取：
          $
            H_(k + 1) = H_k + beta u u^T
          $
          代入@quasi-newton2 ，可以解得：
          $
            u = gamma (S_k - H_k y_k)\
            (beta gamma)^2 = 1/((S_k - H_k y_k)^T y_k)
          $
          最终得到公式：
          $
            H_(k + 1) = H_k + ((S_k - H_k y_k)(S_k - H_k y_k)^T)/((S_k - H_k y_k)^T y_k)
          $
        - Sherman-Morrison-Woodburry 公式：
          #lemma[][
            设 $A$ 可逆，则 $A + u v^T$ 可逆当且仅当：
            $
              1 + v^T Inv(A) u != 0
            $
            且可逆时，有：
            $
              Inv((A + u v^T)) = Inv(A) - (Inv(A) u v^T Inv(A))/(1 + v^T Inv(A) u)
            $
          ]<SMW-lemma>
          由此引理，就可以基于 $H_k$ 计算出 $B_(k + 1)$
        - DFP 公式，也就是用对称秩 2 的矩阵做修正：
          $
            H_(k +1) = H_k + beta u u^T + gamma v v^T
          $
          显然代入@quasi-newton2，的解不唯一，我们不妨就取 $u = S_k$，最后计算得到公式：
          $
            H_(k + 1) = H_k + (S_k S_k^T)/(S_k^T y_k) - (H_k y_k y_k^T H_k)/(y_k^T H_k y_k)
          $
        - BFGS 公式，是最常用的方法，考虑：
          $
            B_(k + 1) = B_k + beta u u^T + gamma v v^T
          $
          代入@quasi-newton1，并用类似的思路，可以解得：
          $
            B_(k + 1) = B_k + (y_k y_k^T)/(y_k^T S_k) - (B_k S_k S_k^T B_k)/(S_k^T B_k S_k)
          $
          再由 @SMW-lemma 可以得到 $H_(k + 1)$
    === BB 方法 
      还有一种简单但意外有效的算法是，在梯度下降：
      $
        x_(k + 1) = x_k - alpha_k g_k
      $
      的基础上，如果我们就取：
      $
        B_k = Inv(alpha_k) I\
        H_k = alpha_k I
      $
      则也可以代入@quasi-newton1 与 @quasi-newton2，此时没有精确解，只能使用最小二乘，分别解得：
      $
        alpha_k = (S_(k - 1)^T S_(k - 1))/(S_(k - 1)^T y_(k - 1))\
        alpha_k = (S_(k - 1)^T y_(k - 1))/(y_(k - 1)^T y_(k - 1))
      $
      用它们做下降步长，效果很好。
          
      
