#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "几何学",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 前言
- 考核：作业10%，期中30%，期末60%
- 课程主页：www.math.pku.edu.cn/teachers/wangjj/2023fall/index.html
- 邮箱：wjiajun\@pku.edu.cn
- 答疑：周一5-6，周四5-6，理科一号楼14100
- 几何：研究空间结构和性质的学科
  - 空间：集合
  - 结构：集合的性质
= 欧氏几何
== 度量空间与欧氏几何
#definition[][
  （度量空间）若 $X$ 是集合，$d:X times X -> R$，满足：
  + 非负性：$d(X,Y)>=0$
  + 非退化性：$d(X,Y)=0 <=> X=Y$
  + 对称性：$d(X,Y)=d(Y,X)$
  + 三角不等式：$d(X,Y)<=d(X,Z)+d(Z,Y)$
  则称 $(X, d)$ 为一个度量空间, $d$ 为 $X$ 上的一个度量

]
注：
  - 这些性质（除了非负性和三角不等式）都是互相独立的
  - 显然一个集合上不只有一个度量
  - 几何性质往往不依赖于集合本身的性质或者说具体的模型
例：用坐标表示 $n$ 维欧氏空间的点，记作$EE^n = {(x_1,x_2,...,x_n)|x_i in RR,i=1,2,3...,n}$，便可规定度量：$d(X,Y)=sqrt((x_1-y_1)^2+(x_2-y_2)^2+...+(x_n-y_n)^2)$，称为欧氏空间上的典范度量

合理的几何性质应该和具体的坐标系选取没有关系，因此自然产生了等距变换的规定

#definition[等距变换][
  若 $X$ 和 $Y$ 是度量空间，$f:X->Y$是双射并且满足：\
  $d_Y (f(X),f(Y))=d_X (X,Y)$\
  则称 $f$ 是一个等距变换，并称度量空间 $X, Y$ 等距同构。

  显然等距同构是等价关系，从而同构保证了不同模型间性质的等价性。\
]

#definition[欧氏几何][
  所有与 $n$ 维典范欧氏空间等距同构的度量空间均称为 $n$ 维欧氏几何（本课程中多使用欧式几何）
]

在二/三维欧式平面典范模型中，可以很容易的定义并证明欧几里得几何的诸多概念的公理、定理，再次说明了同构的概念\ 
- 线段：$overline(P Q)$\
- 有向线段：$arrow(P Q)$\
#example[][
  $EE^2$ 中圆盘
  $
  B_r={(x, y) in EE^2 | x^2+y^2<=r^2}
  $ 
  可以证明：
  + $B_r$ （在典范度量下）是一个度量空间
  + 若 $r eq.not s$，则 $B_r$ 与 $B_s$ 不等距同构
]
== 向量代数
通过欧式几何的典范模型，可以将欧氏几何代数化。\
#definition[向量][$EE^3$ 或 $EE^n$ 中有向线段称为向量或矢量，记作 $arrow(P Q)$, 其中 $P$ 称为起点，$Q$ 称为终点。
- 若 $arrow(P Q)$ 与 $arrow(C D)$ 可通过平移重合，则看作相等的向量（向量是有向线段在平移下的等价类）]
#definition[向量空间][空间中向量的全体称为向量空间]

#definition[反向量、零向量][......]

#definition[平行][......]

#definition[向量加法][三角形法则......]

#proposition[][向量加法满足：
+ 交换律
+ 结合律
+ 零向量是加法零元：$bold(a) + 0 = bold(a)$
+ 负向量是加法逆元：$bold(a) + (-bold(a)) = 0$]

换言之，向量关于加法构成交换群，从而可以定义减法

向量有唯一的方向与长度，故可以定义数乘

#definition[][
  给定 a 是向量，$lambda$ 是实数，则 $lambda a$ 是向量，称为 $a$ 的数乘，满足：
  -  若 $lambda >= 0$，则 $lambda a$ 与 $a$ 同向；若 $lambda leq 0$，则 $lambda a$ 与 $a$ 反向
  -  $|lambda a| = |lambda| |a|$
  显然这样定义的 $lambda a$ 是存在且唯一的
]

#proposition[][数乘满足：
  + $1 dot a = a$, $-1 dot a = -a$
  + （结合律）$(lambda mu) a = lambda (mu a) $
  + （分配律）$lambda (a + b) = lambda a + lambda b$
]

#definition[向量共线/面][
  设 $a_i ,space i=1,2,3...,n$ 是向量。若将它们取同一起点后，它们全部落在一条直线/平面上，则称这些向量共线/共面 
]

#definition[线性相关][
  设 $a_i ,space i=1,2,3...,n$ 是向量。若存在不全为零的实数 $lambda_i ,space i=1,2,3...,n$ 使得：
  $
  sum_(i=1)^n lambda_i a_i = 0
  $
  则称这些向量线性相关。反之则称其线性无关。
]

== 仿射标架
#theorem[][
  向量 $a, b$ 共线当且仅当存在不全为零的实数 $lambda, mu$，使得 $lambda a + mu b = 0$。\
]

#theorem[][
  向量 $a_1, a_2, a_3$ 共面当且仅当存在不全为零的实数 $lambda_i$，使得 $sum_(i=1)^3 lambda_i a_i = 0$。\
]

#corollary[][
  $EE^2$ 中任意向量可被两不共线向量线性表出；
  $EE^3$ 中任意向量可被三不共面向量线性表出\

]

#definition[（空间）仿射标架][
  $EE^3$ 中一个仿射标架指 $(O,e_1,e_2,e_3)$，其中 $O in EE^3$ 是原点，$e_1,e_2,e_3$ 是三个不共面（线性无关）的向量，称为基向量
]

#proposition[][
  取定一个仿射标架，对任意 $EE^3$ 中向量 $a$，存在唯一的 $lambda_i$ 使得：
  $
  a = sum_(i=1)^3 lambda_i e_i
  $

  此时 $vec(lambda_1,lambda_2,lambda_3)$称为 $a$ 在该仿射标架下的（仿射）坐标
]

#corollary[][
  设 $a, b$ 坐标分别为 $autoVec3(a), autoVec3(b)$，则 $a, b$ 共线当且仅当 #v(10pt)
  - $lambda_a autoVec3(a) + lambda_b autoVec3(b) = 0 space (lambda_a,   lambda_b "不全为零")$ #v(10pt)
  - $mat(delim: "|", 
  a_1 , a_2 ;
  b_1 , b_2 ;
  ) 
  = mat(delim: "|", 
  a_2 , a_3 ;
  b_2 , b_3 ;
  ) = 
  mat(delim: "|", 
  a_3 , a_1 ;
  b_3 , b_1 ;
  ) = 0$ #v(10pt)
  - $mat(
    a_1, b_1;
    a_2, b_2;
    a_3, b_3;
  ) $的秩为 $1$
]

#corollary[][
  空间中三点 $A, B, C$ 三点共线当且仅当 
  - $arrow(A C), arrow(B C)$ 共线
  - 对空间中任意一点 $O$，$existsST(t, arrow(O C) = t arrow(O A) + (1-t) arrow(O B))$ \
  注：当 $O$ 不在这条直线上时，上述分解是唯一的
]

#definition[简单比][
  设 $A, B, C$ 为共线三点，定义简单比：
  $
  (A, B; C) = arrow(A C)/ arrow(C B)
  $
]<简单比>

#proposition[][
  - $(A, B; C) = 1/(B, A; C)$
  - $(A, B; C) + (A, C; B) = -1$
  
]
== 向量乘积
  （历史上来讲，事实上比四元数还要晚）\
  设 $a, b in EE^3$ \
  定义：内积/外积/垂直......\
  正交分解：$a = (a dot b) / (|b|^2) b + a_b$，其中 $a_b dot b = 0$，此分解成立且唯一
 
  内积的性质：
  - 交换性
  - $a dot a = a^2$
  - 结合性：$(lambda a) dot b = lambda (a dot b)$
  - 线性性：$(lambda a + mu b) dot c = lambda a dot c + mu a dot c$
  只证最后一个，不妨假设 $lambda = mu = 1$\
  此时有 
  $
  a = (a dot c) / (|c|^2) c + a_c\
  b = (b dot c) / (|b|^2) c + b_c
  $
  代入上式结合点积等于投影立得

  单位正交基：......

  外积/向量积/叉乘：......

  性质：
  + 反交换律
  + 数乘结合律
  + 分配律

  在 $n$ 维空间中，也可定义 $n-1$ 元算子，但是不构成代数，因此不便于使用。由于八元数也可除，在 $7$ 维空间也可定义外积，但乘法不结合。因此类似外积的运算仅在 3 维空间中使用，在更一般的情况下，使用外积的代数结构称为外代数
 
  #proposition[拉格朗日公式][
    $
    a times (b times c) = (a dot c) b - (a dot b) c \
    (a times b) times c = (a dot c) b - (b dot c) a
    $
    换言之，向量积不结合
  ]
  #proof[
    （假定所有向量线性无关）\
    注意到 $a times (b times c),b,c$ 均与 $b times c$ 正交，因此待定系数：
    $
    a times (b times c) = lambda b + mu c
    $
    两边与 $a$ 点乘：
    $
    0 = lambda a dot b + mu a dot c
    $
    
  ]
  
  #proposition[Jacobi恒等式][
    $
    a times (b times c) + b times (c times a) + c times (a times b) = 0
    $
  ]
  在几何上，它表示三角形 $A B C$ 的三条高线交于一点

  #definition[混合积/体积][
    $
    (a, b, c) = (a times b) dot c
    $
    在单位正交基下，它就是 $autoMat3(delim: "|",a , b, c)$
  ]

  #proposition[][
    混合积有如下性质：
    - 反对称性: $(a, b, c) = -(b, a, c)$
    - 轮换对称性：$(a, b, c) = (c, a, b) = (b, c, a)$
    - 线性性: $(lambda a + mu b, c, d) = lambda (a, c, d) + mu (b, c, d)$
  ]

  #proposition[][
    混合积在几何上等于平行六面体的有向体积
  ]

  #proposition[][
    $(a times b) dot (c times d) = mat(delim: "|", a times b, b times c ; c times d, d times a ; ) = (a times c) dot  (b times d) - (a times d) dot (b times c)$
  ]

  #corollary[][
    $|a times b|^2 = |a|^2 |b|^2 - (a dot b)^2$
  ]
== 应用：球面几何
  考虑三维空间中球面（称为二维球面 $S_2$）。设球面上两点 $P, Q$ 不是对径点，则它们确定了唯一一个大圆，这个大圆弧称为（球面几何的）直线或者测地线。在下面的讨论中，不妨假设球面是单位球面。

  #proposition[][
    任何两个不同的直线交于两点，任何三个不同直线组成球面三角形（事实上是两个三角形，但它们是全等的）。显然三角形的边长等于对应球心角的角度。
  ]

  #definition[角度][
    两直线的角度定义为测地线相交处切线的夹角。
  ]

  #theorem[面积][
    球面三角形 $A B C$ 的面积为：
    $
    A + B + C - pi
    $
    其中 $A, B, C$ 指三个顶角的角度。\
  ]

  #proof[
    取 $A, B, C$ 对径点为 $A', B', C'$\
    $l_(A C), l_(A B)$ 分球面为四部分。\
    包含 $B C$ 与 $B' C$ 的两部分面积为：
    $
    A / (2 pi) dot 2 dot 4 pi = 4 A
    $
    $l_(A B), l_(B C)$ 分球面为四部分，包含 $A C$ 与 $A' C'$ 的两部分面积为：$4 B$\
    $l_(A C), l_(B C)$ 分球面为四部分，包含 $A B$ 与 $A' B'$ 的两部分面积为：$4 C$\
    这六个部分覆盖三角形 $A B C$ 与 $A' B' C'$ 各三次。覆盖其余部分各一次。由此：
    $
    4 A + 4 B + 4 C = 4 pi + 4 S
    $
    注：这里假定了球面上面积也是有限可加，等距不变的
  ]
  #corollary[][
    - 球面三角形的内角和大于 $pi$
    - 球面上不存在相似三角形，从而三个角唯一确定了三角形
  ]

  #theorem[球面几何三角公式][
    设 $A B C$ 是球面三角形，角 $A, B, C$ 所对边长度为 $a, b, c$，则有:
    - 正弦定理：
      $
      sin(a) / sin(A) = sin(b) / sin(B) = sin(c) / sin(C) 
      $
    - （第一）余弦定理：（长度决定角度）
      $
      cos(c) = cos(a)cos(b) + sin(a)sin(b)cos(C)
      $
      注：对足够小的 $a, b, c$，这给出了平面的余弦定理
    - 第二余弦定理：（角度决定长度）
      $
      cos(C) = -cos(A) cos(B) + sin(A) sin(B) cos(c)
      $
  ]<球面几何正余弦>

  #proof[
    记 $arrow(O A), arrow(O B), arrow(O C) = alpha, beta, gamma$，则 $a, b, c$ 分别是三组向量的夹角。另一方面，$A, B, C$ 分别是三组大圆面的平面夹角。换言之：
    $
      A = generatedBy(alpha times beta\, gamma times alpha)\
      B = generatedBy(beta times gamma\, alpha times beta)\
      C = generatedBy(gamma times alpha\, beta times gamma)
    $
    由拉格朗日公式：
    $
      (alpha times beta) times (alpha times gamma) = ((alpha times beta) dot gamma) alpha - ((alpha times beta) dot alpha) gamma = ((alpha times beta) dot gamma) alpha = [alpha, beta, gamma] alpha
    $
    又由$|alpha times beta| = 1 dot 1 dot sin(c) ......$，这表明：
    $
      sin(c)sin(b)sin(A) = [alpha, beta, gamma]
    $
    轮换即得正弦定理。\
    又：
    $
    (alpha times beta) dot (alpha times gamma) = (alpha dot alpha) (beta dot gamma) - (alpha dot beta) (alpha dot gamma) 
    \ => sin(c)sin(b)cos(A) = cos(a) - cos(b)cos(c) 
    $
    这就是余弦定理。\
    为了证明第二余弦定理，取三角形 $A' B' C'$ 为三角形 $A B C$ 的极三角形。也即，取：
    $
    alpha' = (beta times gamma) / (|beta times gamma|)\
    beta' = (gamma times alpha) / (|gamma times alpha|)\
    gamma' = (alpha times beta) / (|alpha times beta|)
    $断言：
    $
    a' = pi - A, b' = pi - B, c' = pi - C
    $
    事实上，在前式中取 $cos$ 立得。\
    另一方面：
    $
    alpha' times beta' = ([gamma, alpha, beta] gamma) / (sin(a) sin(b))\
    alpha' times gamma' = - ([gamma, alpha, beta] beta) / (sin(a) sin(c)) 
    $
    从而
    $
    cos(A') = generatedBy(alpha' times beta'\, gamma' times alpha')  = - gamma dot beta => A' = pi - a("注意到" alpha, beta "均为单位向量")
    $
    在极三角形 $A' B' C'$ 中，代入余弦定理即得原三角形的第二余弦定理。
  ]
= 平面二次曲线的分类
    #definition[二次曲线][
      二次曲线是笛卡尔坐标系上满足二次方程：
      $
      Tau: a x^2 + b x y + c y^2 + d x + e y + f = 0
      $
      的点的集合。
    ]

    对于一般的方程，为了研究图形，可以考虑通过移动和旋转坐标轴的方式使得方程简化。

  == 仿射坐标系
    称 $(O, e_1, e_2)$ 为一个仿射标架，其中 $O$ 是原点，$e_1, e_2$ 是两个不共线的向量。\
    在此标架下，任意向量可被唯一表为：
    $
    (e_1, e_2) vec(x, y)
    $
    另取一仿射标架 $(O', e'_1, e'_2)$，并设：
    $
    (e'_1, e'_2) = (e_1, e_2)A 
    $
    则有：
    $
    V =(e_1, e_2)vec(x, y) = (e'_1, e'_2)vec(x', y') = (e_1, e_2)A vec(x', y')\
    => vec(x, y) = A vec(x', y')
    $
    这称为向量的坐标变换。\
    对于平面上的点，完整的坐标变换公式为：
    $
    (e_1, e_2)vec(x, y) = O P = O O' + O' P 
    \ = O O' + (e'_1, e'_2)vec(x', y') 
    \ = O O' + (e_1, e_2)A vec(x', y')
    \ => vec(x, y) = A vec(x', y') + "cor"(O O') 
    $
    也可将其统一为：
    $
    vec(x, y, 1) = mat(A, beta;0, 1) vec(x', y', 1)
    $
    其中 $beta = "cor"(O O')$。\
    显然它可以分解为两部分：移轴（保持 $e_1, e_2$ 不变）和旋转（保持原点不变）。就方程而言，移轴可以消去一次项，而转轴可以消去交叉项。\
  == 单位正交坐标系
    在单位正交系中我们也可以进行坐标系变换，但我们希望保持正交性。\
    令 $(O, e_1, e_2)$ 是右手单位正交坐标系。我们希望它经过变换后得到 $(O', e'_1, e'_2)$ 仍是单位正交坐标系。\
    #proposition[][
      设 $(e'_1, e'_2) = A$，则 $(O', e'_1, e'_2)$ 仍是右手单位正交坐标系当且仅当 $A$ 是正交矩阵且行列式为 $1$。
    ]
    #proof[
      在三维空间中，取右手单位正交框架 $(O, e_1, e_2, e_3)$。\
      我们希望 $(O, e'_1, e'_2, e_3)$ 也是右手单位正交框架，也即：
      $
      vec(e'_1^T, e'_2^T, e_3^T)(e'_1, e'_2, e_3) = I\
      [e'_1, e'_2, e_3] = |e'_1, e'_2, e_3| = 1 \
      $
      前式等价于：
      $
      vec(e_1^T, e_2^T, e_3^T)mat(A^T, 0;0, 1)mat(A, 0;0, 1)(e_1, e_2, e_3) = I
      \ <=> A^T A = I
      $
      后式等价于：
      $
      1 = mat(delim: "|", A, 0;0,1)|e_1, e_2, e_3| = |A|
      $
      这就证明了命题
    ]

    #corollary[][
      二维正交矩阵均可以表示为：
      $
      mat(cos theta, -sin theta ;sin theta , cos theta )
      $
      进而，平面上两右手单位正交系间的坐标变换可以表示为：
      $
      vec(x, y) = mat(cos theta, -sin theta ;sin theta , cos theta )vec(x', y') + vec(x_0, y_0)
      $
      其中，$vec(x_0, y_0)$ 是 $O'$ 在原坐标系下的坐标，$theta$ 表示由原坐标轴逆时针旋转到新坐标轴经过的角度。
    ]
  == 标准二次曲线
    + 椭圆：$x^2/a^2 + y^2/b^2 = 1$
    + 双曲线：$x^2/a^2 - y^2/b^2 = 1$
    + 抛物线：$y^2 = 2 p x$
    + $(a_1 x + b_1 y + c_1)(a_2 x + b_2 y + c_2) = 0$ 双直线
    + $(x - p)^2 + (y - q)^2 = 0$ 单点
    + $(x - p)^2 + (y - q)^2 = -1$ 无解
    显然这些曲线在正交变换下不改变。\
    问题：如何确定标准型？
    - 考虑移轴、转轴
    - 考虑不同变换群下的不变量
  == 正交变换不变量
    二次方程可以记作一个矩阵，从而二次曲线可以写作：
    $
    x^T A x = 0 ; A = mat(A_1, alpha; alpha^T, c)
    $
    一般的正交变换可以用矩阵：
    $
    Q := mat(B, beta;0, 1)
    $
    替代，其中 $B$ 为正交矩阵；\
    这相当于在一般的合同变换中，在 $1, 2$ 行/列 与 $3$ 行列之间只允许高行列加减低行列，反之不可。\
    在此变换下 $A$ 变为 
    $
    Q^T A Q = mat(B^T A_1 , B^T alpha; beta^T A_1 + alpha^T , beta^T alpha + c)Q
    \ = mat(B^T A_1 B, B^T A_1 beta + B^T alpha;beta^T A_1 B + alpha^T B, beta^T A_1 beta + alpha^T beta + c)
    $
    不难发现：
    - $|A| = |Q^T A Q| := I_3$
    - $|A_1| = |Q^T A_1 Q| := I_2$
    - $tr(A_1) = tr(B^T A_1 B) := I_1$
    是三个移轴、转轴变换下的不变量\
    注：$tr(A)$ 未必是不变量，因为 $tr(A) = tr(Q^T A Q)$，但 $Q$ 未必正交。
    有了不变量，我们就可以做如下分类：
    + $I_2 > 0$ 椭圆型：
      $
      mat(lambda_1, 0, 0;0, lambda_2, 0;0, 0, e)
      $
      - $I_1 I_3 < 0$ 椭圆
      - $I_1 I_3 > 0$ 空集
      - $I_1 I_3 = 0$ 
        - $I_1 = 0$，显然不可能
        - $I_3 = 0$，单点
    + $I_2 < 0$ 双曲型：
      $
      mat(lambda_1, 0, 0;0, - lambda_2, 0;0, 0, e)
      $
      - $I_3 != 0$ 双曲线
      - $I_3 = 0$ （相交的）双直线
    + $I_2 = 0$ 抛物线型：
      $
      mat(lambda_1, 0, 0;0, 0, d;0, d, e)
      $
      - $I_3 != 0$ 抛物线
      - $I_3 = 0$：
        此时 $A$ 有以下形态：
        + $I_1 = lambda_1 != 0$
          $
          mat(lambda_1, 0, 0;0, 0, 0;0, 0, e)
          $
          - $lambda_1 e > 0$ 空集（或称之为平行虚直线）
          - $lambda_1 e < 0$ 两条平行直线
        + $I_1 = lambda_1 = 0$
          $
          mat(0, 0, 0;0, 0, d;0, d, e)
          $
          退化为任意一次曲线
    对于剩余情形，引入半不变量：
    $A$ 的二阶主子式的和记作 $k_1$

    #proposition[][
      若 $I_2 = I_3 = 0$，则 $k_1$ 在转轴、移轴下不变。
    ]
  == 圆锥曲线的几何性质
    圆锥曲线在古典几何中有着很重要的位置，早在古希腊便有很多研究。\
    在几何上，圆锥曲线可以统一定义为：
    - 用任意平面截取圆锥，得到的曲线称为圆锥曲线
    - 在平面上，到定点的距离与到定直线的距离之比为定值的点的轨迹称为圆锥曲线，定点、定直线、比例分别为焦点、准线、离心率
    显然，这些性质应该不依赖于直角坐标系的选取。事实上，它们都是度量特征（在正交变换下不变）\
    与之相对的，曲线分类、中心、对称轴、开口方向等性质在任意仿射变换下不变。\
    研究几何性质往往从直线与圆锥曲线的相交情况出发：\
    设圆锥曲线方程为 $X^T A X = 0; A = mat(A_1, alpha; alpha^T, c)$。
    另设直线方程为：$X_0 + lambda beta; beta = vec(u, v, 0)$\
    代入：
    $
    (X_0 + lambda beta)^T A (X_0 + lambda beta) \
    = X_0^T A X_0 + 2 lambda X_0^T A beta + lambda^2 beta^T A beta = 0
    $
    记：
    - $beta^T A beta = beta^T A_1 beta$ 为 $phi(u, v)$
    - $X_0^T A beta = (x, y, 1) mat(A_1, alpha; alpha^T, c) vec(u, v, 0) = ((x, y) A_1 + alpha^T, (x, y)alpha + c)vec(u, v, 0) = ((x, y) A_1 + alpha^T)vec(u, v) \ := u F_1(x, y) + v F_2(x, y)
    $
    - 容易验证 $F_1(x, y) = (delta F(x, y))/(delta x), F_2(x, y) = (delta F(x, y))/(delta y)$
    === 中心
    下面的讨论中，假设 $A_1 != 0$，从而保证有无穷多组 $beta$ 使得上述方程是二次方程\
    在上面的方程中，假设 $X_0$ 恰好是中心，则由韦达定理，任意联立方程的一次项均为零，即有：
    $
    forall beta in R^2, u F_1(x, y) + v F_2(x, y) <=> F_1(x, y) = F_2(x, y) = 0 <=> (x, y, 1) vec(A_1 ,alpha^T) = 0
    $
    容易验证这是充要的。
    - 椭圆型、双曲线型一定有唯一中心：$A_1$ 此时可逆故解显然存在且唯一。（对于一些退化情况，可能是广义的中心）
    - 抛物线型中：
      - 抛物线无中心
      - 一次曲线的退化情况不能如此讨论
      - 其余情况均有一条直线作为中心的集合
    === 渐进方向
      #definition[渐进方向][
        若 $phi(u, v) = 0$，则称 $vec(u, v)$ 是一个渐进方向。
      ]
      这可以理解为直线与圆锥曲线将在无穷远处相交。（在方程两边除以 $t$，我们发现 $1/t = 0$ 将成为一个伪解）\
      显然渐进方向取决于 $A_1$ 的正惯性指数。\
      - 若 $A_1$ 正定或负定，也即椭圆型，则 $phi(u, v) > 0$，不存在渐进方向
      - 若 $|A_1| = 0$，也即抛物线型，此时恰有一个渐进方向也即零特征值的特征向量 
      - 若 $A_1$ 特征值一正一负，此时 $(u, v)$ 是渐进方向当且仅当：
        $
        lambda_1 u^2 + lambda_2 v^2 = 0
        $
        显然它可以唯一分解为两个渐进方向
      #proposition[][
        如此定义的渐近线和分析意义的渐近线是等价的。
      ]
      #proposition[][
        - 椭圆型曲线无渐近线
        - 双曲线型恰由两个渐进方向
        - 抛物线型恰有一个渐进方向
        - 过双曲线中心的渐近线与双曲线不相交  
        - 抛物线型曲线的任意渐近线都与抛物线相交
      ]
      #proposition[][
        中心在曲线上意味着有56
      ]
      对于抛物线，我们需要判断渐进方向的哪一侧是抛物线的开口方向。
      #lemma[][
        $X$ 在抛物线的内部当且仅当：
        $
        (X^T A X) I_1 < 0
        $
      ]
      #proposition[][
        $(u, v)$ 是开口方向当且仅当：
        $
        I_1 (u D + v E) > 0
        $
      ]
    == 共轭直径
      对于圆而言，一簇平行直线与圆的交点的中点在一条直线上。对椭圆同样也有类似性质。一般的：
      #theorem[][
        设 $A$ 是二次曲线，且 $(u, v)$ 不是渐进方向，则所有平行于 $(u, v)$ 的直线与 $A$ 的交点的中点在一条直线上，该直线的方向称为 $(u, v)$ 的共轭方向。
      ]
      #proof[
        设 $beta = vec(u, v, 0)$\
        在前述的联立方程中，可得：
        $
        (X_1 + X_2) / 2 &= X_0 + (t_1 + t_2)/2 beta
        \ &=  X_0 - (X_0^T A beta) / (beta^T A_1 beta) beta
        \ &=  X_0 - (beta^T A X_0) / (beta^T A beta) beta
        $
        注意到：
        $
        (beta^T A) (X_1 + X_2) / 2 = beta^T A X_0 - (beta^T A X_0) / (beta^T A beta) beta^T A beta = 0
        $
        这意味着中点在直线：
        $
        (beta^T A) X = 0
        $
        上，除非：
        $
        A beta = 0
        $
        此时 $beta$ 是渐进方向。\
        显然这是一条过中心（如果有）的直线。\
      ]
      #proposition[][
        - 二次曲线的共轭方向（只要不涉及渐进方向）互相共轭，称之为一对共轭直径。\
          $gamma$ 是 $beta$ 的共轭方向 $<=> gamma^T A alpha = 0 <=> alpha^T A gamma = 0 <=>$ $beta$ 是 $gamma$ 的共轭方向
        - 对于非抛物线型曲线，不会出现非渐进方向的共轭方向是渐进方向，但抛物线型有可能。
          注意到：
          $
          beta^T A_1 alpha = alpha^T A_1 alpha = 0 "且" alpha, beta "线性无关" => A_1 alpha = 0 => |A_1| = 0
          $
      ]
    == 切线
      #definition[][
        若直线与二次曲线只有一个交点且不是渐进方向上，则称直线与二次曲线相切。
      ]
      此定义相当于对切线做以微扰便可得到正常相交的直线。\
      #proposition[][
        对任意二次曲线上的点 $X_0$，只要它不是中心，便可得到唯一的切线。\
        只需解：
        $
        beta^T A X_0 = u F_1(x_0, y_0) + v F_2(x_0, y_0) = 0
        $
        对应的 $beta$ 即可
      ]
      #proposition[][
        对任意方向，只要它不是渐进方向，便可按以下方法得到这个方向上的切线（可能没有或一、两个）。\
        设给定方向 $beta = vec(u, v, 0)$，只需解
        $
        X_0^T A X_0 = 0\
        beta^T A X_0 = 0\
        $
        即可。\
        更进一步，若曲线有中心 $O$，则二式表明 $X_0 - O$ 就是 $beta$ 的共轭方向。因此解的数量等价于过中心沿此方向与曲线相交的点的数量。
      ]
  == 圆锥曲线的度量特征
    === 对称轴
      容易发现，若一个方向的直线恰与其垂直，则直线即为圆锥曲线对称轴。这等价于 $A_1$ 的特征向量所对应的方向。\
      #proposition[][
        - 对于圆，每个方向都是一个对称轴
        - 对于椭圆、双曲线，恰有两个特征向量，对应两个对称轴，也称其为主方向
        - 对于抛物线，渐进方向也即 0 特征值对应的特征向量是唯一的对称轴
      ]
      有了对称轴后，容易得到椭圆、双曲线的中心以及抛物线的顶点。\
      #example[][
        $
        Q = mat(8, 4, -3;4, 2, -4;-3, -4, 1);
        $
        计算得：
        $
        I_1 = 10\
        I_2 = 0\
        I_3 = -50
        $
        从而它是抛物线。
        $A_1$ 的特征向量分别为：
        $
        0 -> vec(1, -2)\
        10 -> vec(2, 1)\
        $
        从而对称轴方程应为：
        $
        (2, 1)mat(8, 4, -3;4, 2, -4;) vec(x, y, 1) = 0\
        <=> 20 x + 10 y - 10 = 0
        <=> 2 x + y - 1 = 0
        $
        进而联立解得顶点即可。
        $
        beta := vec(2, 1, -2)\
        beta_0 := vec(2, 1, 0)\
        beta = beta_0^T A\
        beta_0 A X = 0\
        X^T A X = 0 
        $
      ]
= 空间解析几何
  == 平面方程
    空间中一个平面的方程为一个线性方程：
    $
    A x + B y + C = 0
    $
    它可以由以下事实给出：
    #lemma[][
      空间中四点 $autoVec3(x), autoVec3(a), autoVec3(b), autoVec3(b)$ 共面当且仅当：
      $
      autoMat3(delim: "|", x, b, c) = autoMat3(delim: "|", a, b, c)
      $
    ]
  == 直线方程
    === 标准方程
      空间中直线可以写作：
      $
      X = X_0 + t vec(u, v, w) \
      <=> (x-x_0)/u = (y-y_0)/v = (z-z_0)/w
      $
      这称为直线的标准方程
    === 相交方程
      空间中两个不平行平面唯一给定一个交线，从而直线可表示为：
      $
      cases(
        pi_1 X = D_1,
        pi_2 X = D_2
      )
      $
      显然交线的方向向量即为 $pi_1 times pi_2$，再任取一个交点即可得到直线的标准方程。
  == 相交关系
    两平面间的相交情况显然就是线性方程组：
    $
    vec(pi_1^T, pi_2^T) X = vec(D_1, D_2)
    $
    的解集。\
    两直线间的相交可以转换为线性方程组：
    $
    X_1 +t_1 V_1 = X_2 + t_2 V_2\
    <=> (V_1, V_2) X = X_2 - X_1
    $
    记 $"rank"(V_1, V_2) = r_1, "rank"(V_1, V_2, X_2 - X_1) = r_2$
    - 两直线异面 $<=> r_2 = 3$
    - 两直线相交 $<=> r_2 = r_1 = 2$
    - 两直线平行 $<=> r_2 = 1, r_3 = 2$
    - 两直线重合 $<=> r_2 = r_1 = 1$
    直线与平面间的相交关系可以转换为线性方程组：
    $
    vec(pi_1^T, pi_2^T, pi_3^T) X = autoVec3(D)
    $
    或者：
    $
    cases(
      pi^T X = D,
      X = X_0 + t V
    )
    <=> pi^T (X_0 + t V) = D\
    <=> pi^T V t = D - pi^T X_0
    $
  == 度量关系
    === 平行平面距离
      设两平行平面：
      $
      pi^T X = D_1\
      pi^T X = D_2
      $
      则它们的距离为：
      $
      (|pi^T (X_1 - X_2)|) / (|pi|) = (|D_1 - D_2|) / (|pi|) 
      $
    === 点到平面距离
      设平面：
      $
      pi^T X = D
      $
      则点 $X_0$ 到平面的距离为：
      $
      (|pi^T (X_0 - X)|) / (|pi|) = (|D - pi^T X_0|) / (|pi|)
      $
    === 点到直线距离
      设直线：
      $
      X = X_0 + t V
      $
      对 $X-X_0$ 关于 $v$ 做正交分解：
      $
      X - X_0 = k v + v'
      $
      其中 $|v'|$ 就是我们想要的，我们有：
      $
      (X_1 - X_0) times V = v' times V\
      |(X_1 - X_0) times V| = |v' times V| = |v'| |V|\

      $
      则点 $X_1$ 到直线的距离为：
      $
      (|(X_1 - X_0) times V|) / (|V|)
      $
    === 直线间距离
      平行直线间距离就是任意一点与另一直线的距离。\
      异面直线的距离
= 二次曲面
  对于曲面，可以分成几种简单的类型
  == 旋转面
    #definition[旋转面][
      旋转面是由一条曲线绕一条轴旋转一周得到的曲面。\
      称其中的曲线为母线，轴为准线。
    ]
    #proposition[][
      曲线：$f(y, z) = 0, x = 0$ 绕 $z$ 轴旋转一周得到的曲面方程为：
      $
      f(sqrt(x^2 + y^2), z) = 0
      $
    ]
    #proposition[][
      设 $X_0 + t v$ 为轴，则 $M$ 在旋转面上当且仅当：
      $
      exists M_0 "在曲线上": (|(M_0 - X_0) times v|)/ (|v|) = (|(M - X_0) times v|)/ (|v|)
      $
    ]
  == 柱面
    #definition[][
      柱面是由一条曲线沿一个方向平移得到的曲面。\
    ]
    #proposition[][
      设 $tau$ 为准线，$v$ 为（母线）方向，则 $X$ 在锥面上当且仅当：
      $
      exists X_0 in tau: (X - X_0) times v = 0
      $
    ]
  == 锥面
    #definition[][
      一组过同一点 $M$ 的直线构成锥面\
      称：
      - $M$ 为顶点
      - 一组直线中任意一条称为直母线
      - 锥面上不过顶点但与所有母线相交的曲线为准线
    ]
    #proposition[][
      设 $M$ 为顶点，$tau$ 为准线，则 $X$ 在锥面上当且仅当：
      $
      exists X_0 in tau: (X_0 - M) times (X - M) = 0
      $
    ]
  == 直纹面
    #definition[][
      空间中曲面 $Sigma$ 称为直纹面，若对任意 $P in Sigma$，均存在过 $P$ 的直线 $l$ 使得 $l subset Sigma$
    ]
    #proposition[][
      锥面、柱面都是直纹面
    ]
    二次曲线中，大部分面是否是直纹面都是直观的（显然有界曲面不会是直纹面），但双曲抛物面有有趣的结论：
    #theorem[][
      双曲抛物面是直纹面
    ]
    #proof[
      注意到：
      $
      2 z = x^2/a^2 - y^2/b^2 = (x/a + y/b)(x/a - y/b)
      $
      因此对曲面上点 $P$，存在某个 $c$ 使得：
      $
      cases(
        x/a + y/b = c,
        x/a - y/b = (2z) / c
      )
      $
      或者：
      $
      cases(
        x/a + y/b = (2z) /c,
        x/a - y/b = c
      )
      $
      对应的点都在曲面上，且它是一条过 $P$ 的直线。\
    ]
    在上面的证明中，我们得到了两族不同的直母线。
    #theorem[][
      单叶双曲面（马鞍面）是直纹面
    ]
    #proof[
      $
      x^2/a^2 + y^2/b^2 - z^2/c^2 = 1\
      <=> (x/a + z/c)(x/a -z/c) = (1 - y/b)(1 + y/b)
      $
      从而对某个 $c$：
      $
      cases(
        x/a + z/c = (1 + y/b)c,
        x/a - z/c = (1 - y/b)/c
      )
      $
      或：
      $
      cases(
        x/a + z/c = (1 - y/b)c,
        x/a - z/c = (1 + y/b)/c
      )
      $
      之后是类似的。
    ]
  == 二次曲面的分类
    一般的二次曲面可以写作：
    $
    (x, y, z, 1) mat(A_1, alpha; alpha^T, c) vec(x, y, z, 1) = 0
    $
    用类似讨论二次曲线的方法，可以得到二次曲面的标准方程以及不变量

    一般的三维空间正交变换矩阵可以写作：
    $
    Q = mat(Q, beta; 0, 1)
    $
    从而：
    $
    Q^T A Q = mat(Q, 0; beta^T, 1) mat(A_1, alpha; alpha^T, c)mat(Q, beta; 0, 1) = mat(Q^T A_1 Q, *; *, *)
    $
    由对称矩阵的性质，断言 $A_1$ 一定可以对角化。\
    可以写出以下不变量：
    - $I_1 = tr(A_1)$
    - $I_2 = K_2(A_1)$ 是 $A_1$ 的二阶主子式之和
    - $I_3 = |A_1|$
    - $I_4 = |A|$
    同样也可以从同时行列变化的角度，在 4 行/列与 1、2、3 行/列之间只允许高行列加减低行列，反之不可。\
    因此分类可以直接从标准型：
    $
    mat(lambda_1, 0, 0, a;0, lambda_2, 0, b;0, 0, lambda_3, c;a, b, c, d)
    $
    开始。\
    + $I_3 != 0$，此时标准型为：
      $
        mat(lambda_1, 0, 0, 0;0, lambda_2, 0, 0;0, 0, lambda_3, 0;0, 0, 0, d)
      $
      由于我们得到了三个特征值，因此可以不妨设 $I_3 > 0$
      + $I_1, I_2 > 0$，也即 $lambda_i > 0$
        - $I_4 < 0$ 椭球面：$x^2/a^2 + y^2/b^2 +z^2/c^2 = 1$ 
        - $I_4 > 0$ 空集
        - $I_4 = 0$ 单点
      + 其他情况均有其中两个特征值同号，不妨设 $lambda_1, lambda_2 > 0, lambda_3 < 0$
        - $I_4 < 0$：单叶双曲面：$x^2/a^2 + y^2/b^2 -z^2/c^2 = 1$
        - $I_4 > 0$：双叶双曲面：$x^2/a^2 + y^2/b^2 -z^2/c^2 = -1$
        - $I_4 = 0$：椭圆锥面：$x^2/a^2 + y^2/b^2 -z^2/c^2 = 0$
    + $I_3 =0, I_2 != 0$，此时标准型为：
      $
        mat(lambda_1, 0, 0, 0;0, lambda_2, 0, 0;0, 0, 0, c;0, 0, c, d)
      $
      有：
      $
      I_4 = -lambda_1 lambda_2 c^2
      $
      + $I_4 != 0 <=> c != 0$，此时可消去 $d$
        - $I_2 = lambda_1 lambda_2 > 0$：椭圆抛物面：$x^2/a^2 + y^2/b^2 = z$
        - $I_2 = lambda_1 lambda_2 < 0$：双曲抛物面：$x^2/a^2 - y^2/b^2 = z$
      + $I_4 = 0 <=> c = 0$
        - $d != 0$
          - $I_2 = lambda_1 lambda_2 > 0$：椭圆柱面（或空集）：$x^2/a^2 + y^2/b^2 = d$
          - $I_2 = lambda_1 lambda_2 < 0$：双曲柱面：$x^2/a^2 - y^2/b^2 = d$
        - $d = 0$
          - $I_2 = lambda_1 lambda_2 > 0$：退化为一条直线：$x^2/a^2 + y^2/b^2 = 0$
          - $I_2 = lambda_1 lambda_2 < 0$：两个相交平面：$x^2/a^2 - y^2/b^2 = 0$
    + $I_3 =0, I_2 = 0, I_1 != 0$，此时标准型为：
      $
        mat(lambda_1, 0, 0, 0;0, 0, 0, b;0, 0, 0, c;0, b, c, d)
      $
      + $b = c = 0$：
        - $lambda_1 d > 0$：空集
        - $lambda_1 d < 0$：单点
        - $lambda_1 d = 0$：一个平面（两个重合平面）
      + $b, c$ 有且只有一个为零，不妨设 $b!= 0, c = 0$，$d$ 也可消去
        - 抛物柱面：$x^2/a^2 = y$
    + $I_3 =0, I_2 = 0, I_1 = 0$，此时标准型为：
      $
        mat(0, 0, 0, a;0, 0, 0, b;0, 0, 0, c;a, b, c, d)
      $
      已经退化为一次曲面
    至此，我们圆满完成了二次曲面的分类
= 变换
  == 保距变换
    #definition[保距变换][
      称几何空间上的变换 $sigma$ 是保距变换，如果：
      + $sigma$ 可逆
      + $forall x, y in EE$，有：
        $
        d(x, y) = d(sigma(x), sigma(y))
        $
    ]
    #proposition[][
      保距变换的逆映射和复合仍是保距变换，进而几何空间上的保距变换构成一个群。
    ]
    $EE^3$ 中保距变换的全体记作 $"Isom"(EE^3)$。\
    #example[][
      以下是典型的保距变换：
      + 平移
      + 旋转
      + 关于点、线的反射
      + 滑反射：反射后再平移
      + 旋进：绕一点旋转一定角度后再平移，例如地球上某点相对太阳
    ]
    #lemma[][

      + 保距变换保持平行四边形
      + 保距变换保持线段夹角不变
      + 保距变换保持向量，也即点上的保距变换可以诱导出良定义的向量上的保距变换
      + 保距变换保持向量内积不变
      + 保距变换保持向量外积不变
      + 保距变换对向量的作用是线性的
    ]
    #proof[
      1 由保距性是显然的。\
      对于 2，显然 $A B C$ 与 $sigma(A) sigma(B) sigma(C)$ 全等，因此结论易得。\
      3 中，只需定义自然诱导的向量保距变换是良定义的，为此只需要证明相等且平行的线段的像依然相等且平行，这由 1 显然。\
      对于 4、5，由 1，2 结合内积定义显然（注意保持夹角意味着保持垂直）\
      对于 6，考虑设 $e_1, e_2, e_3$ 是一组单位正交基，它们的像分别为 $v_1, v_2, v_3$。

      由前面的命题，$v_1, v_2, v_3$ 也是单位正交基，因此设：
      $
      v := sum_i lambda_i e_i\
      sigma(v) = sum_i lambda'_i v_i
      $
      由保持内积知 $lambda_i = v dot e_i = v dot v_i = lambda'_i$，这意味着：
      $
      sigma(v) = sigma(sum_i lambda_i e_i) = sum_i lambda_i sigma(e_i)
      $
      这就证明了 $sigma$ 在向量上的线性性。
    ]
    #proposition[][
      $EE^3$ 中不共面四点唯一决定一个保距变换
    ]
    #proof[
      设 $P_1, P_2, P_3, P_4$ 的像分别为 $Q_1, Q_2, Q_3, Q_4$。\
      显然 $overline(P_1 P_2), overline(P_1 P_3), overline(P_1 P_4)$ / $overline(Q_1 Q_2), overline(Q_1 Q_3), overline(Q_1 Q_4)$ 是两组基。\
      设 $v = sum_i lambda_i overline(P_1 P_i)$，由线性性，立得：
      $
      sigma(overline(v P_1)) = sum_i lambda_i overline(Q_1 Q_i)
      $
      这就表明任何点的像已经确定，证毕。
    ]
    #proposition[][
      $EE^3$ 中任何保距映射可以由四个关于平面的反射复合而成
    ]
    #proof[
      在上面的命题中，取 $A, B, C, D$ 四点。先取 $A$ 与 $sigma(A)$ 的中垂面，构造 $pi_1$ 是关于该平面的反射，显有 $pi_1(A) = sigma(A)$

      再取 $B, pi_2(sigma(B)$) 的中垂面。注意到由保距变换，$|A B| = |A pi_2(sigma(B)|$，因此点 $A$ 在这个中垂面上。依次取得 $pi_2$，$pi_3$，$pi_4$，则有：
      $
        sigma = pi_4 pi_3 pi_2 pi_1
      $
    ]
    #proposition[][
      空间中保距变换若有不动点，则它是关于某条直线的对称
    ]
    #proposition[][
      一般的保距变换是关于某直线对称和平移的复合
    ]
    #proposition[][
      以下保距变换的性质是与坐标无关的
      - 旋转角度
      - 平移距离
    ]
    #proposition[][
      平面上的保定向（行列式大于零）的保距变换只有平移和旋转

      平面中的保距变换是平移，旋转，反射，滑反射其一。
    ]
    #proof[
      - 若保距变换保定向，则它没有实特征值，因此它是旋转或平移
      - 若保距变换有不动点，则它等价于向量的正交变换，而二维的正交变换只有反射和旋转
      - 若无不动点，则它等价于保持原点不动的保距变换与平移的复合，从而要么是平移，要么是滑反射（注：平移和旋转的复合有不动点）
    ]
  == 仿射变换
    #definition[仿射变换][
      若几何空间上的可逆变换 $sigma$ 保持直线不变，则称 $sigma$ 是仿射变换。
    ]
    #proposition[][
      由保距变换在向量上的作用的线性知，保距变换是仿射变换。
    ]
    #example[][
      典型的仿射变换有：
      - 保距变换
      - 正压缩：$lambda_1 l + lambda_2 l' -> lambda_1 l + k lambda_2 l'$
      - 错切：$lambda_1 l + lambda_2 alpha_2 -> lambda_1 l + (lambda_2 + k lambda_1) alpha_2$
      - 斜压缩：$lambda_1 l + lambda_2 u -> lambda_1 l + k lambda_2 u$
    ]
    #example[][
      向量的线性变换可以自然诱导出仿射变换，因此以下矩阵也是仿射变换：
      - $mat(0, 1;-1, 0)$，这是一个旋转+反射
      - $mat(1, 1;1, 2)$，这是两个错切
      - $mat(1, -1;1, 0)$，这是一个错切
    ]
    #proposition[][
      二阶线性变换群恰为：
      $
        generatedBy(S\, R| S^4 = R^6 = 1\, S^2 = R^3)
      $
      其中 $S = mat(1, 1;0, 1), R = mat(1, 0;1, 1)$
    ]
    #proposition[][
      以 $l$ 为轴的斜压缩是以 $l$ 为轴的错切和正压缩的复合
    ]
    #lemma[][
      + 仿射变换保持直线相交、平行
      + 仿射变换保持平行四边形、平行六面体
      + 仿射变换保持平面
      + 仿射变换保持向量，也即点上的仿射变换可以诱导出良定义的向量上的仿射变换
    ]
    #proof[
      1： 由保持直线知，两个直线的交点的像应该同时在两个直线的像上，因此保持直线的相交、平行。\
      2：由保持平行容易得到
      3：注意到平面由两条相交直线决定，只需证明任何在平面上，过初始两直线交点的直线都在新平面上即可\
      4 由前面命题是显然的。
    ]
    #theorem[][
      仿射变换保持分比 $<=>$ 仿射变换在向量上的作用是线性的
    ]
    #proof[
      这个证明是很不平凡的，我们的目标是证明：仿射变换诱导的向量变换是可逆的线性变换。\
      良定义性前面已知，可逆性是容易证明的，关键是证明保持线性运算。\
      其中，保持加法由保持平行四边形是平凡的，下面证明保持数乘
      + 由保持加法性，$sigma(n v) = n sigma(v), n in NN$
      + 进一步，将有：$sigma(-n v) + sigma(n v) = 0 => sigma(-n v) = -n sigma(v)$
      + 断言 $sigma(q/p v) = q/p sigma(v)$，事实上：
        $
          p sigma(q/p v) = sigma(p q/p v) = sigma(q v) = q sigma(v) => sigma(q/p v) = q/p sigma(v)
        $
      + 这提示我们可以采用柯西方程，只需要额外的单调性或者连续性的条件即可
        - 无论何者，证明的要点都是证明若 $sigma(lambda alpha) = u sigma(alpha)$，则对任意向量 $beta$，均有：
          $
          sigma(lambda beta) = u sigma(beta)
          $
          - 若 $alpha, beta$ 不共线，利用平行线分线段成比例易证
          - 若共线，只需再作一个与其不共线的向量作为桥梁
        - 有了上面的结论，证明单调性只需：

          取 $sqrt(lambda) alpha -> u' sigma(alpha)$，即有 $lambda alpha = sqrt(lambda) sqrt(lambda) alpha -> u'^2 alpha => u >= 0$ 
        - 利用保序性很容易证明单调性，只要对每个趋于零的向量列找到一个略大一点且像趋于零的向量列控制即可
      + 对一般的 $x in R$，我们可以找两列有理数：
        $
        q_1, q_2, ..., q_n,... -> x and < x\
        p_1, p_2, ..., p_n,... -> x and > x
        $
        从而利用单调性条件：
        $
        |sigma(q_i v)| = |q_i| |sigma(v)| < |sigma(x v)|\
        |sigma(p_i v)| = |p_i| |sigma(v)| > |sigma(x v)|
        $
        或者连续性条件：
        $
        |sigma(q_i v)| -> |sigma(x v)|
        $
        都可以得到结论

      ]
      #corollary[][
        变换 $sigma$ 保持分比当且仅当它是仿射变换
      ]
      #proposition[][
        $"Aff"(EE^n) -> "GL"(V(EE^n))$，也即仿射变换群到向量的线性变换群存在自然的满同态
      ]
      #theorem[仿射变换的坐标表示][
        设 $sigma: EE^3 -> EE^3$ 是仿射变换，$(O, e_1, e_2, e_3)$ 是一个仿射标架，则对任意点 $P: O + overline(O P)$，将有：
        $
        sigma(P) = sigma(O) + sigma(overline(O P))
        $
        从而若设 $overline(O P) = (e_1, e_2, e_3)X$，将有：
        $
        sigma(P) = sigma(O) + (sigma(e_1), sigma(e_2), sigma(e_3))X\
        = O + (e_1, e_2, e_3)beta + (e_1, e_2, e_3)C X
        $
        换言之，$sigma(P)$ 的坐标 $X'$ 为：
        $
        X' = C X + beta
        $
        其中 $(e_1, e_2, e_3)C = (sigma(e_1), sigma(e_2), sigma(e_3))$
      ]
      #corollary[][
        任何平面上保持某个线向不变的仿射变换或者有不动点，或者有不变的直线
      ]
      #proof[
        - $X$ 是不动点当且仅当：
          $
          (I - C)X = beta
          $
        - $X_0 + t v$ 是不动直线当且仅当：
          $
          C X_0 + beta - X = t v <=>
          (I - C)X_0 = beta - t v\
          and (I - C)v = 0
          $
        设方程（1）无解，则 $"rank"(I - C) <= 1$，从而 $(I - C)v = 0$ 有解。
        - 若 $"rank"(I - C) >= 1$，则由 $1$ 知 $beta in.not im(I-C)$，进而 $beta plus.circle im(I-C) = FF^2$
        - 若 $"rank"(I - C) = 0$，则 $C = I$，进而是平移，显然有不变直线
      ]
    设 $"Aff"(EE^n)$ 是仿射变换群：
    - 保距变换 $"Isan"(EE^n)$ 是其子群
    - 平移变换群 $"Trans"(EE^n)$ 是其交换的正规子群
    - 一般而言，轴不同的旋转不可交换，因此保距变换群不交换。同时它也不是正规子群。

    设空间所有图形构成集合 $X$，空间上的变换自然产生其上的一个群作用，某个稳定子群称为保持某图形不变的变换群
    #example[][
      求保持：
      $
      (sqrt(x^2 + y^2) - a)^2 + z^2 = r > 0
      $
      的仿射变换。

      由于这是一个圆台，保持它的仿射变换应当当然保持圆台的对称轴不变。这因为任取两对同一平面上的对径点，它们的交点是各自的中点，而仿射变换保持共面，相交关系和中点不变，因此它们的像也是同一平面上的对径点，进而变换保持该平面的圆心不变。\
      
    ]
  == 克莱因纲领
    克莱因纲领是黎曼几何之前的古典几何的一种经典归纳。几何空间上的可逆变换构成一个群，不同的几何就是研究在某个子群下不变的性质。
    
    换言之，这个在这个子群下，所有处于同一轨道的图形都认为是相同的图形。注意到处于同一轨道的图形可以通过变换相互到达，因此这个子群是图形的等价关系的等价类。\
    同时，若 $H <= G$，则 $G$ 的轨道只会比 $H$ 更小。进而若两个图形在 $G$ 中等价，则在 $H$ 中也等价，同时若函数在 $G$ 中所有变换下不变，则当然在 $H$ 的所有变换下不变，
    
    例如取 $G = "Aff"(EE^3), H = Isom(EE^3)$，就是说保距变换下等价的图形当然仿射等价，或者保距变换的不变量当然是仿射变换的不变量。\

    #example[欧氏几何/度量几何][
      欧氏几何就是研究保距变换下不变的性质，包括：
      - 距离
      - 角度
      - 面积
      - 其他仿射几何中的几何性质
      笛卡尔坐标系是经典的欧氏几何模型，某个几何中不变的性质当然应该在不同的模型中都不变，因此可以利用坐标系来研究几何性质。
    ]
    #example[球面几何][
      在保距变换群中，取得一个保持单位球面不变的子群，在这个子群下不变的性质称为球面几何。
    ]
    #example[仿射几何][
      仿射几何就是研究仿射变换下不变的性质，包括：
      - 平行
      - 相交
      - 简单比
      - 交比
    ]
    #example[射影几何][
      后半学期会学习射影几何，它研究射影变换下不变的几何。
    ]
= 射影几何
  == 中心投影
    #definition[中心投影][
      设 $pi_1, pi_2$ 是两个平面，$O$ 是平面外一点。任取 $pi_1$ 上一点 $X$，$O X$ 两点唯一决定一条直线 $L_X$，它交平面 $Pi_2$ 于点 $Y$。显然这大致构造了一个映射 $phi： pi_1 -> pi_2$ \
      不幸的是，仅有若干条平行于 $pi_2$ 的直线 $L_X$ 无法确定 $Y$，因此我们必须暂时去掉这些点。
    ]
    #proposition[][
      - 中心投影保持直线
      - 中心投影不保持直线的相交、平行
    ]
    #proposition[][
      选取圆锥的顶点做中心投影，圆锥上所有二次曲线都可以由不同平面的中心投影得到，进而中心投影保持二次曲线
    ]
  == 射影平面
    #definition[扩大的欧氏平面/线向完备化模型][
      在中心投影中，在 $pi_2$ 上人为补充所有经过点 $O$，平行于 $pi_2$ 的直线作为无穷远点，这些无穷远点和通常点合在一起构成了一个扩大的平面，称为扩大的欧氏平面，这样的平面统称射影平面，这个构造称为线向完备化模型。
    ]
    在射影平面之间，中心投影可以给出完备的几何变换。这种变换保持点在线上，线过点等性质。注意这种变换不需要保持平行，这可以为我们证明某些只与点在线上，线过点的定理提供极大的便利。
    #proposition[射影平面的基本性质][
      + 任何两点确定一条直线
      + 任何两条直线确定一个点
      + 中心投影是两射影平面间的一一映射，并将直线映为直线
    ]
    #definition[射影平面的线把模型][
      设 $O$ 是空间上任意一点，$pi$ 是不过 $O$ 的某个投影平面，其上的点与过 $O$ 点的所有直线有一一对应关系，称为射影平面的线把模型。（事实上，这与平面的选取无关，选取不同平面相当于做了一个投影变换）
    ]
    #definition[射影平面的齐次坐标][
      线把模型中，显然每个直线可以记作一个三维向量 $vec(a, b, c)$。实际上，它的所有取值相当于：
      $
      quotient(RR^3 - {0}, (alpha ~ RR alpha))
      $
      往往将其中元素记作 $HomoCoor(x, y, z) = RR vec(x, y, z)$，这被称为射影平面的齐次坐标。
    ]
    #remark[][
      可以看出我们也可以只取单位向量，这就与以 $O$ 为球心的单位球面上的点构成对应（一对对径点恰对应一条直线）。在这个模型下，点就是球面上一对对劲点，平面就是过球心的平面或者一个大圆面。
    ]
    #remark[][
      射影空间是性质很好的空间，例如在代数几何中，射影空间可以完全被内蕴地给出代数定义，但常见的仿射几何则不行。
    ]
  == 射影坐标系
    #remark[][
      这节及以后讨论的所有齐次坐标都要求非零
    ]
    在线把模型中，每条过 $O$ 的直线唯一确定一个齐次坐标，同时也唯一确定一个射影平面上的点，因此射影平面上的点与齐次三维向量产生一一对应，这被称为射影平面的齐次坐标。

    #proposition[][
      - 

        $HomoCoor(x, y ,z),  autoHomoCoor3(a), autoHomoCoor3(b)$ 共线
        \

        $<=> HomoCoor(x, y ,z) = lambda autoHomoCoor3(a) + mu autoHomoCoor3(b), lambda, mu != 0$\

        $<=> mat(delim:"|", 
          x, a_1, b_1;y, a_2, b_2;z, a_3, b_3) = 0$\

        $<=> v^T HomoCoor(x, y ,z) = 0$，其中 $v$ 由行列式展开给出
          
    ]
    #remark[][
      从线把模型的角度，一条直线对应一个平面，而过原点的平面坐标恰如上式。
    ]

    #proposition[][
      在扩大的仿射平面模型中，可以将仿射平面的坐标嵌入射影平面坐标：
      $
      vec(x, y) <-> HomoCoor(x, y, 1)
      $
      同时，无穷远直线恰为：
      $
      [0, 0, 1]X = 0
      $
    ]

    #proposition[射影标架][
      对于射影平面上任意一般位置四点 $A, B, C, D$，存在唯一射影标架使得四点坐标分别为：
      $
      HomoCoor(1, 0 ,0), HomoCoor(0, 1 ,0), HomoCoor(0, 0 ,1), HomoCoor(1, 1 ,1)
      $
      称此标架为由四点构成的射影标架
    ]
    #proof[
      仍然考虑线把模型，设 $A, B, C, D$ 分别由空间向量 $v_1, v_2, v_3, v_4$ 确定，有：
      $
      v_4 =  lambda_1 v_1 + lambda_2 v_2 + lambda_3 v_3
      $
      由一般位置知这些参数非零
      则对射影平面上任意一点 $P$，对应向量 $v$，将有：
      $
      v = (1/lambda_1 v_1, 1/lambda_2 v_2, 1/lambda_3 v_3)X
      $
      从而对应一个射影标架：
      $
      P = [1/lambda_1 v_1, 1/lambda_2 v_2, 1/lambda_3 v_3] X
      $
      容易看出在这个标架下，满足 $A, B, C, D$ 四点坐标恰为：
      $
      HomoCoor(1, 0 ,0), HomoCoor(0, 1 ,0), HomoCoor(0, 0 ,1), HomoCoor(1, 1 ,1)
      $
      因此满足要求，\
      对于唯一性，设有一空间仿射标架为：  
      $
      v = (alpha_1, alpha_2, alpha_3 )X
      $
      由于：
      $
      (v_1, v_2, v_3) = (alpha_1, alpha_2, alpha_3 ) mat(k_1, 0, 0;0, k_2, 0;0, 0, k_3)
      $
      由于 $v_1, v_2, v_3$ 线性无关，因此矩阵可逆，故可设（显然 $k_i !=0$）：
      $
      alpha_i = 1/k_i v_i
      $
      同时：
      $
      v_4 = k (alpha_1, alpha_2, alpha_3)vec(1, 1, 1)\
      = (k/k_1 v_1, k/k_2 v_2, k/k_3 v_3)vec(1, 1, 1)
      $
      而 $v_4$ 被 $v_1, v_2, v_3$ 表出方式是唯一的，这意味着：
      $
      (k/k_1 v_1, k/k_2 v_2, k/k_3 v_3) = mu (1/lambda_1 v_1, 1/lambda_2 v_2, 1/lambda_3 v_3) \
      [alpha_1, alpha_2, alpha_3] = [1/lambda_1 v_1, 1/lambda_2 v_2, 1/lambda_3 v_3]
      $
      这就证明了唯一性
    ]
  == 射影映射
    #definition[射影映射][
      在两个射影平面上，将直线映为直线的映射的可逆映射称为射影映射，同一个平面上的射影映射称为射影变换。
    ]
    #example[][
      - 仿射映射是射影映射，它比射影映射的定义恰好多了保持直线平行
      - 中心投影是射影映射
    ]
    #theorem[][
      射影映射的逆映射还是射影映射
    ]
    #proof[
      设 $P$ 设射影映射，$A', B', C'$ 是直线 $l'$ 上不同三点，且 $P(A, B, C) = (A', B', C')$\
      若 $A, B, C$ 三点不共线，则至少一个不是无穷远点，不妨设为 $A$。\
      记直线 $A C$ 为 $Sigma_1$，直线 $B C$ 为 $Sigma_2$，显然有：
      $
      P(Sigma_1) subset l'\
      P(Sigma_2) subset l'
      $
      再任取 $D in Sigma_1, E in Sigma_2$，则有：
      $
      P(D E) subset l'
      $
      这将意味着过两不重合直线 $Sigma_1, Sigma_2$ 上任意两点确定的直线的像都在 $l'$ 上，这是荒谬的。

    ]
    #corollary[][
      射影映射 $P$ 不会将两条不同直线映到同一直线上，进而射影映射诱导出射影平面上直线之间的一一映射。
    ]
    #corollary[][
      空间中保持一点不动并将平面映成平面的可逆映射诱导出平面间的一一对应关系
    ]
    #remark[][
      - 设 $sigma$ 是平面 $Sigma$ 上仿射变换，$Sigma'$ 是扩大的欧氏平面，则令：
        $
        P(X) = cases(
          sigma(X) space X in Sigma,
          X space X in Sigma' - Sigma        
        )
        $
        也就是补充将无穷远点映为无穷远点，这将成为 $Sigma'$ 上的射影映射，并将无穷远直线映为无穷远直线。

      - 反之，设 $P$ 是 $Sigma'$ 上将无穷远直线映为无穷远直线的射影映射，则 $P|_Sigma$ 将成为在欧氏平面上保持直线的映射，进而它是仿射映射。

      - 进一步，设 $Sigma'$ 是扩大的欧氏平面，则对任意一条直线 $l$，存在射影变换 $P$，它把无穷远直线映为 $l$。只需要取中心投影将无穷远直线变为有限直线，再取仿射映射变为指定直线即可。这表明在射影映射下，无穷远直线与通常直线实际上没有什么区别。

      - 事实上，任意射影平面去掉一条直线就变成了仿射平面，在这个仿射平面中不相交的直线称为仿射平面中的平行直线。显然这个平行关系与具体去掉哪个直线有关，因此需要在上下文无歧义时使用。
    ]

    若将仿射变换群 $Hom(pi)$ 视作射影变换群 $Proj(pi)$ 的子群，则有：
    $
    Proj(pi) = union.big_(i) sigma_i Hom(pi)
    $
    其中 $sigma_i$ 是将某条通常直线映为无穷远直线的射影变换。
    #proposition[][
    取 $sigma$ 是线把模型中射影平面上的点与过 $O$ 点的直线的一一对应，$phi$ 是 $EE^3$ 中仿射变换，将有：
    $
    phi' = Inv(sigma) dot phi dot sigma
    $
    给出射影平面上一个射影变换。\
    ] <proj1>
    #proof[
      首先 $sigma, phi$ 都是双射，故 $phi'$ 也是双射。\
      而：

      $phi'$ 是射影变换 $<=> phi'$ 保持射影平面上直线\
      $<=> phi dot sigma$ 将射影平面上直线映成空间中平面\
      $<=>$ $phi$ 将空间中平面映成平面

      最后一句由仿射映射的性质是显然的。
    ]
    #proposition[][
      命题的反面也成立，也即任意给定射影平面上射影变换 $P$，存在保持 $O$ 点不动的映射 $phi$ 使得 $P = Inv(sigma) dot phi dot sigma$ 且 $phi$ 为仿射映射
    ] <proj2>
    #proof[
      #lemma[][
        空间中将零向量映成零向量，并保持向量共面关系的可逆向量变换一定是线性变换
      ]
      #proof[
        首先，从之前射影变换的逆变换还是射影变换可以看出，这样的变换的逆变换还保持向量共面关系不动。
        只需证明这样的变换保持向量共线，进而由仿射变换的熟知结论知它是线性变换。\
        记满足要求的向量映射为 $f$，用反证法，假设 $a, b$ 共线但 $f(a), f(b)$ 不共线，取 $f(c) = f(a) times f(b)$，则 $f(a), f(b), f(c) "不共面" <=> a, b, c "不共面"$，但由 $a, b$ 共线，这是荒谬的。


        另证：对任意向量 $alpha$，找 $beta, gamma$ 使得 $alpha, beta, gamma$ 线性无关，从而：
        $
        dim(generatedBy(alpha\, beta)) = dim(generatedBy(alpha\, gamma)) = 2
        $
        设 $V_1 = generatedBy(alpha\, beta), V_2 = generatedBy(alpha\, gamma)$，将有（注意到 $f$ 可逆）：
        $
        V_1 sect V_2 = generatedBy(alpha)\
        f(V_1 sect V_2) = f(V_1) sect f(V_2)
        $
        （$f(V_1), f(V_2)$ 仍是线性空间，这是因为 $V_1$ 是所有与 $alpha\, beta$ 共面的向量，经过映射仍然共面。同时考虑逆映射，所有与 $f(alpha), f(beta)$ 共面的向量的原像也与 $alpha\, beta$ 共面）
        - $V_1 != V_2 => f(V_1) != f(V_2)$，故 $dim(f(V_1) sect f(V_2)) < 2$
        - $f(alpha) in f(V_1) sect f(V_2), f(alpha) != 0 => dim(f(V_1) sect f(V_2)) >= 1$
        这表明 $dim(f(V_1) sect f(V_2)) = 1$，进而 $f(V_1 sect V_2) = f(V_1) sect f(V_2) = f(generatedBy(alpha))$\
        这就证明了 $f$ 保持向量共线。\

        （另证中的方法容易推广至一般空间，但本质是相同的）
      ]
      考虑以 $O$ 为原点的所有向量，引理表明将过 $O$ 点平面映射成过 $O$ 点平面的空间变换一定是保持 $O$ 点不动的仿射变换。但我们之前使用的 $sigma$ 表示直线间的映射，这里我们必须明确给出一个点变换（或者向量变换），下面的命题将详细给出定义：
      #proposition[][
        给定 $EE^3$ 上保持共面关系的所有过 $O$ 直线间的一一对应 $phi$，则存在可逆的向量变换 $f$，使得：
        $
        phi(l_(A O)) = l_(f(A) O) <=> f(l) = phi(l)
        $
        同时，这给出 $f$ 保持向量共面关系。

        构造是容易的，只需考虑上半球面挖去底面的右半部分构成的集合 $S$，它与过 $O$ 点所有直线恰交于一点。记 $S_l$ 为 $S$ 与直线 $l$ 的交点，定义向量变换 $f$：
        $
        f(lambda overline(O S_l)) ：= lambda overline(O S_(phi(l)))
        $
        由于空间中所有向量都可以唯一写作 $lambda overline(O S_l)$，因此 $f$ 是良定义的。并且容易验证，$Inv(phi)$ 诱导出的向量映射恰为 $Inv(f)$（注意之前我们已经论述，空间中保持平面关系的直线变换的逆仍然保持平面关系）\
        同时保持共面关系是显然的，因为：
        $
        lambda_1 overline(O S_l_1), lambda_2 overline(O S_l_2), lambda_3 overline(O S_l_3) "共面"\
        <=> l_1, l_2, l_3 "共面" \
        <=> phi(l_1), phi(l_2), phi(l_3) "共面"\
        <=> lambda_1 overline(O S_(phi(l_1))), lambda_2 overline(O S_(phi(l_2))), lambda_3 overline(O S_(phi(l_3))) "共面"\
        <=> f(lambda_1 overline(O S_l_1)), f(lambda_2 overline(O S_l_2)), f(lambda_3 overline(O S_l_3)) "共面"
        $
      ]
      这与我们最终要证明的命题已经很接近了，取 $sigma$ 是射影平面上点与过 $O$ 点直线一一对应，由于 $P$ 是射影变换，因此：
      $
      sigma dot P dot Inv(sigma)
      $ 
      保持直线共面关系，进而由上述命题诱导出向量变换 $f$ 且保持向量共面关系。由引理，$f$ 就是保持 $O$ 点不动的仿射变换。\
      另一方面，由命题：
      $
      (Inv(sigma) dot f dot sigma)(l) = Inv(sigma) dot f(sigma(l)) = Inv(sigma) dot (sigma dot P dot Inv(sigma))(sigma(l)) = P(l)
      $
      最终证明了原结论。
    ]
    上面两个命题结合，我们得到了最重要的定理：
    #theorem[][
      设 $sigma$ 是线把模型中射影平面上点与过 $O$ 点直线一一对应，则保持 $O$ 点不动的仿射变换群 $Hom(O)$ 与射影平面上射影变换群 $Proj(pi)$ 有满同态 $pi.alt$，并且满足：
      $
      f(sigma(X)) = sigma(pi.alt(f)(X))
      $

      同时，$ker(pi.alt)$ 恰为所有以 $O$ 为中心的伸缩映射，进而由第一同构定理：
      $
      quotient(GL_3, RR I) tilde.eq quotient(Hom(O), ker(pi.alt)) tilde.eq Proj(pi)
      $
    ]
    #proof[
      根据 @proj1，只需取 $pi.alt(f) = Inv(sigma) dot f dot sigma$ \
      由于 $(Inv(sigma) dot f dot sigma) dot (Inv(sigma) dot g dot sigma) = Inv(sigma) dot (f dot g) dot sigma$，因此这确实是群同态，而条件：
      $
      f(sigma(X)) = sigma(pi.alt(f)(X))
      $
      是显然成立的。\
      同时 @proj2 表明这是满射，因此是满同态。\
      显然，$ker(pi.alt)$ 满足空间中所有向量都是特征向量，这表明它就是所有以 $O$ 为中心的伸缩映射，矩阵表示恰为 $RR I$

    ]
    #corollary[射影变换的矩阵表示][
      在上面的定理中，$sigma(X)$ 实际上就是 $X$ 的坐标表示 $autoHomoCoor3(x)$，因此射影映射 $P$ 可以被表示为：
      $
      P(autoHomoCoor3(x)) = A autoHomoCoor3(x) 
      $
      其中 $A$ 是 $Inv(pi.alt)(P)$ 中某个元素的矩阵表示，进而在相差倍数的意义下唯一。
    ]
    #theorem[][
      - 射影映射由四个处于一般位置的点唯一确定。
      - 射影变换一定可以写作若干中心投影的复合
    ]
    #proof[
      设四点 $A, B, C, D$ 的像为 $A', B', C', D'$。
      #lemma[][
        空间内不同射影平面间的平移，旋转可以用中心投影实现
      ]
      #proof[
        两者的操作类似，由于变换前后的图形对称，取其对称面。先投影一次投影到对称面，再投影一次到新平面，容易验证结果与平移/旋转是相同的。
      ]
      #lemma[][
        可以通过中心投影使得 $A, B, C, D, A', B', C', D'$ 都是通常点
      ]
      #proof[
        只需要考虑无穷远直线及它的像。容易找到两条直线，$A, B, C, D;A', B', C', D'$ 分别不在其上，可以通过中心投影保证这两条直线恰为无穷远直线，此时这些点当然不是无穷远点。
      ]
      由引理，可设这些点都是处于一般位置的通常点。我们依次确定四点的像：
      - 首先，容易做中心投影将 $A$ 映成 $A'$
      - 其次，任找一条过 $A'$ 且不过其他点的直线，绕这个直线对平面任做旋转，再任做中心投影都保持 $A'$ 不动，容易将 $B$ 的像调整到 $B'$
      - 类似的，可以绕 $A' B'$ 旋转，将 $C$ 的像调整到 $C'$
      - 至此，存在射影变换保持 $A B C$ 三点，并将 $D$ 映成 $D'$
      运用代数方法，设：
      $
      overline(O D) = lambda_1 overline(O A) + lambda_2 overline(O B) + lambda_3 overline(O C)\
      overline(O D') = mu_1 overline(O A) + mu_2 overline(O B) + mu_3 overline(O C)
      $
      注意到由于四点处于一般位置，这些系数都非零\
      则考虑空间仿射变换：
      $
      overline(O A) -> mu_1/lambda_1 overline(O A)\
      overline(O B) -> mu_2/lambda_2 overline(O B)\
      overline(O C) -> mu_3/lambda_3 overline(O C)
      $
      它诱导的射影变换将保持 $A B C$ 三点，并将 $D$ 映成 $D'$，这就证明了第一个结论。\
      注意到这个仿射变换相当于将平面 $A B C$ 中心投影到平面 $A' B' C'$，其中：
      $
      overline(O A') = lambda_1/mu_1 overline(O A)\
      overline(O B') = lambda_2/mu_2 overline(O B)\
      overline(O C') = lambda_3/mu_3 overline(O C)
      $
      此时将有：
      $
      overline(O D) = mu_1 overline(O A') + mu_2 overline(O B') + mu_3 overline(O C')\
      $
      进而 $D$ 在该平面上投影相对 $A', B', C'$ 将恰为 $D'$，将该平面通过平移，旋转（由中心投影实现）变成原平面，这就证明了第二个结论。

      对于唯一性，注意到：
      $
      A autoMat3(x, y,z, w) = autoMat3(a, b,c,d)mat(k_1, 0, 0, 0;0, k_2, 0, 0; 0, 0, k_3,0;0, 0, 0, k_4)
      $
      设 $w = lambda_1 x + lambda_2 y + lambda_3 z$，（由于四点处于一般位置 $lambda_i != 0$）则对两侧同时列变换得：
      $
      A mat(a_1, b_1, c_1, 0;a_2, b_2, c_2, 0;a_3, b_3, c_3, 0) = autoMat3(a, b,c,d)mat(k_1, 0, 0, -k_1 lambda_1;0, k_2, 0, -k_2 lambda_2; 0, 0, k_3,-k_3 lambda_3;0, 0, 0, k_4)
      $
      当且仅当 $k_4 d = k_1 lambda_1 a + k_2 lambda_2 b + k_3 lambda_3 c$ 时有解。由于 $a, b, c$ 是一组基，因此这样的 $k_i$ 在差一系数的意义下唯一，进而射影变换唯一。
    ]
    #remark[][
      所有的仿射变换都（延拓意义下）是射影变换，从而在射影意义上可以由中心投影实现
    ]
    #remark[][
      - 在欧氏几何中，有等腰三角形，一般三角形；平行四边形，菱形，正方形，凸四边形等等概念，它们在等距变换下保持不变
      - 在仿射几何中，所有的三角形共属一类，四边形还可区分（所有平行四边形共属一类，凸四边形概念依然存在）
      - 在射影几何中，所有的四边形共属一类。
    ]
    #remark[][
      我们所有对射影映射（变换），包括之前对仿射映射的讨论 *都基于由实数实现的线性空间*。有些性质是无法推广的，例如在复数域存在非平凡同构，这导致保持向量共线的映射未必成为线性映射，进而保持直线的映射未必有矩阵表示，射影映射也会有同样的问题，有关定义的具体含义可能会发生变化。
    ] 

  == 对偶原理
    设 $Sigma$ 是射影平面，$Sigma^*$ 是所有 $Sigma$ 上的直线构成的集合，称为 $Sigma$ 的对偶平面。*对偶原理实际上是说射影空间与其对偶空间（在线性关系上）是同构的*。\
    利用线把模型，定义如下映射 $phi: Sigma -> Sigma^*$，它将射影点 $X$（对应过中心直线 $l$）映为射影直线 $l$（对应过 $X$ 的平面，这个平面恰与 $l$ 垂直）。\
    容易验证这样定义的映射 $phi$ 是一一的，且满足：
    $
    X, Y, Z "三点共线" <=> phi(X), phi(Y), phi(Z) "三线共点"
    $
    换言之，$Sigma^*$ 也可以看作射影平面，它的几何性质与 $Sigma$ 是相同的。这也意味着，射影平面上任何关于点、线的命题都有对偶的线、点的命题，且它们同时为真/假，这就是对偶原理。
    #example[迪沙格定理][
      - 两三角形对应顶点的连线共点 $=>$ 两三角形对应边的交点共线
      - 两三角形对应边的交点共线 $=>$ 两三角形对应顶点的连线共点
      这两个事实是互相对偶的，它们同时为真。
    ]
    #remark[][
      对偶原理只能作用于纯线性的命题，不能直接应用于二次相关的命题。
    ]
  == 分比
    分比是射影变换重要的不变量，同时也是本质的不变量。\
    回顾 @简单比 简单比，它是仿射变换的不变量，但是在射影几何下不是。考察平面投影，设 $A, B, C$ 投影为 $A', B', C'$ 可以发现：
    $
      ((A, B, C))/((A', B', C'))
    $
    是与 $C$ 点无关的。因此再取一点 $D$ 便有：
    $
    ((A, B, C))/((A', B', C')) = ((A, B, D))/((A', B', D'))\
    <=> ((A, B, C))/((A, B, D)) = ((A', B', C'))/((A', B', D'))
    $
    表明后者是一个射影不变量，称其为分比

    #definition[仿射平面上的分比][
      - 设 $A, B, C, D$ 四点共线，且不允许任意三点相同，则记：
        $
        (A, B;C, D) = ((A, B, C))/((A, B, D)) = (arrow(A C)/arrow(C B))/(arrow(A D)/arrow(D B))
        $
        为四点的分比
      - 设 $l_1, l_2, l_3, l_4$ 共点于 $O$，且不允许任意两点相同，任取一条之间 $l$ 截四线于 $A, B, C, D$，由上面的论述这与所选 $l$ 无关，因此记：
        $
        (l_1, l_2; l_3, l_4) = (A, B;C, D)
        $
        为四线的分比
      - 设 $v_1, v_2, v_3, v_4$ 是向量，且：
        $
        v_3 = s_1 v_1 + t_1 v_2\
        v_4 = s_2 v_1 + t_2 v_2\
        $
        则定义它们的分比为：
        $
        (v_1, v_2;v_3, v_4) := (t_1 / s_1)\/(t_2 / s_2)
        $
        它与上面两个定义是相容的
    ]
    #proposition[欧式平面上直线分比的角度度量][
      取逆时针为正，设 $l_1, l_2, l_3, l_4$ 之间的夹角依次为 $theta_(i j)$，则有：
      $
      (l_1, l_2; l_3, l_4) = ((sin theta_(1 3))/(sin theta_(3 2)))/((sin theta_(1 4))/(sin theta_(4 2)))
      $ 
    ]
    #proof[
      由于选取直线不影响分比，因此选取直线 $l$ 使得 $|O A| = |O B|$。 使用正弦定理计算面积易得：
      $
      (A, B, C) = (sin theta_(1 3))/(sin theta_(3 2))\
      (A, B, D) = (sin theta_(1 4))/(sin theta_(4 2))
      $
      从而结论成立
    ]
    #theorem[][
      分比有以下运算性质：
      - $1/((A_1, A_2;A_3, A_4)) = (A_2, A_1;A_3, A_4) = (A_1, A_2;A_4, A_3)$
      - $1- (A_1, A_2;A_3, A_4) = (A_1, A_3;A_2, A_4)$
      - $(A_1, A_2;A_3, A_4) = (A_3, A_4;A_1, A_2)$
    ]
    #definition[扩大的欧式平面上的分比][
      对共线四点 $A, B, C, D$
      - 若它们都是通常点，按照仿射平面情形定义分比
      - 若只有 $D$ 是无穷远点，定义：
        $
        (A, B;C, D) = (A, B, C)
        $
      - 若它们都是无穷远点，则取四个点对应无穷远方向的共点直线，定义四点交比是四个直线的交比

      对于共点四线 $l_1, l_2, l_3, l_4$：
      - 若它们都是通常直线，则按仿射平面情形定义
      - 若 $l_4$ 是无穷远直线，此时另外三条直线平行，定义分比是任取一条直线截三条平行直线所得交点的简单比（显然与所选直线无关）
    ]
    #definition[线把模型中的分比][
      设 $A, B, C, D$ 是共线四点，定义：
      $
      (A, B;C, D) = (O A, O B; O C, O D)
      $
      右侧是扩大的射影平面上四线的交比，且与 $O$ 点的选取无关

      对于共点四线，定义分比为任取一条直线截四线所得点的分比
    ]
    #definition[调和点列/线束][
      设 $A, B, C, D$ 是共线四点，若：
      $
      (A, B;C, D) = - 1
      $
      则称四点成为调和点列，同时称 $D$ 是 $C$ 关于 $A, B$ 的调和共轭点。类似定义调和线束。
    ]
    #theorem[][
      交比是射影不变量。也即设 $A, B, C, D$ 在射影映射 $phi$ 下的像为 $A', B', C', D'$，则：
      $
      (A, B;C, D) = (A', B';C', D')
      $
    ]
    #proof[
      证明的方法非常多，例如从代数出发事实是容易的。这里从几何出发，先证明中心投影保持交比不变，再有射影映射是中心投影的复合知结论成立。

      事实上，注意到线把模型中，射影平面上的射影变换就是空间中的仿射变换，它当然保持共点四线的交比，进而不改变仿射平面上四点的交比。
    ]
  
    #remark[][
      *以上所有定义都是相容的*，本质可以归结于向量的分比。同时，点的分比与线的分比的统一性也是符合对偶原理的。分比的概念其实相当古老，早在古希腊时期人们就知道了分比是中心投影的不变量，可以用来解决很多问题。
    ]
  

  == 射影平面上的二次曲线
    容易看出，射影平面上的二次曲线方程可以写作：
    $
    [x, y, z]A HomoCoor(x, y, z) = 0 := X^T A X = 0
    $
    #remark[][
      射影平面中并不是所有的方程都确定一条曲线，容易看出良定义性当且仅当方程齐次。
    ]
    在坐标变换：
    $
      HomoCoor(x, y, z) = T HomoCoor(x', y', z')
    $
    下，方程变为：
    $
    [x', y', z']T^T A T HomoCoor(x', y', z')
    $
    由于 $T$ 可以任取可逆矩阵，因此射影平面上二次曲线的等价类就是合同变换下的等价类（允许差一个非零常数，注意这也意味着正负号不做区分）。

    而代数上可以证明，矩阵的合同等价类唯一由正惯性指数和负惯性指数确定，因此枚举所有正负惯性指数 $(p, q)$：
    - $(3, 0) ~ (0,3): x^2 + y^2 + z^2 = 0$：这是空集（注意射影坐标中三点不同时为零）
    - $(1,2) ~ (2, 1): x^2 + y^2 - z^2 = 0$：蕴含了所有仿射几何中的通常二次曲线，包括椭圆，双曲线，抛物线。常常也使用另一种标准型 $x z - y^2 = 0$
    - $(0, 2) ~ (2, 0): x^2 + y^2 = 0$：空集
    - $(1, 1): x^2 - y^2 = 0$：这是一对相交直线
    - $(1, 0) ~ (0,1): x^2 = 0$：这是二重直线

    #remark[][
      - 这表明实数域下，所有（非退化的）圆锥曲线都是射影等价的，这个事实是可以用几何方法另证：

        设 $Sigma$ 是空间中一个圆锥曲线，显然它是圆锥与某个平面的交线。取中心投影容易将其变为椭圆。而所有的椭圆都仿射等价，当然也是射影等价的。

      - 在复数域下，所有满秩矩阵都合同于单位矩阵，因此分类结果可以简化为三种。
    ]
    二次曲线究竟由多少个点确定是我们所关心的问题，有许多方法可以得到相同的结论。
    
    #proposition[二次曲线是有理曲线][
      非退化二次曲线是可以参数化的。更精确地说，对于任何非退化二次曲线 $Tau$，存在某个坐标使得 $Tau$ 恰为：
      $
      {x z - y^2 = 0} <=> {HomoCoor(u^2, u v, v^2) | (u, v) in RR^2}      
      $
      并且在差一个非零常数的意义下参数是唯一的。\

      在通常的仿射几何中，往往也可以找到一个有理分式对二次曲线进行参数化。
    ]

    #theorem[][
      + 两个非退化二次曲线至多有四个交点。若在复数域上且考虑重数，则恰有四个交点
      + 若一个至少包含一个点的二次曲线的两个方程分别为 $F_1 = 0, F_2 = 0$，则 $F_1 = c F_2$
      + 平面上处于一般位置的五个点唯一确定一条二次曲线
      + 设 $A_1, A_2$ 是两个非退化二次曲线，有四个交点（考虑重数），则所有过这四个交点的二次曲线即为：
        $
        X^T (lambda A_1 + mu A_2) X = 0
        $
    ]
    #proof[
      带有重数的命题比较复杂，这里均不证明，只证明四个交点不同的情况。
      - （1）从参数化方程可以看出，两个二次曲线联立将得到四次（齐次）方程，显然最多有四组解。
      - （2）由（1）易得
      - （3）唯一性由（1）是易得的，存在性考虑关于 $A$ 的矩阵方程：
        $
        V_i^T A V_i = 0
        $
        这是含有 $6$ 个变量，$5$ 个方程的线性方程组，它当然有解。
      - （4）设四个交点不同，仿照上面构造线性方程组，过四个点的二次曲线解空间维度为 $2$，恰好就是 $generatedBy(A_1\, A_2)$
    ]

    #corollary[][
      平面上不在同一直线上的五点唯一确定一个圆锥曲线
    ]

    从更加线性代数的角度也可以给出证明，同时将退化情形容纳进去
    #lemma[][
      设 $X_1, X_2, X_3, X_4$ 是处于一般位置四点，则：
      $
      "rank" (mat(x_1^2, y_1^2, z_1^2, x_1 y_1, y_1 z_1, x_1 z_1;
      x_2^2, y_2^2, z_2^2, x_2 y_2, y_2 z_2, x_2 z_2;
      x_3^2, y_3^2, z_3^2, x_3 y_3, y_3 z_3, x_3 z_3;
      x_4^2, y_4^2, z_4^2, x_4 y_4, y_4 z_4, x_4 z_4;)) = 4
      $
    ]
    #proof[
      可以验证这个矩阵的秩在对四点做同一个可逆线性变换的情况下不变，进而不妨假设四点是最简单情形 $vec(1, 0 ,0), vec(0, 1 ,0),vec(0, 0 ,1),vec(1, 1 ,1)$，结论显然成立
    ]
    这立刻表明所有过一般位置四点的二次曲线构成二维线性空间，自然上面的结论都成立\
    从几何角度证明需要用到如下的定理
    #theorem[Steiner][
      设 $A_1, A_2, A_3, A_4$ 是射影平面上圆锥曲线上任意四个不同点，任取 $P$ 在圆锥曲线上，则：
      $
      (P A_1,P A_2; P A_3, P A_4)
      $
      恰为一个定值（规定若 $P = A_i$，则 $P A_i$ 是该点处的切线），且符合交比等于此定值的所有点恰为圆锥曲线上所有点。
    ]
    #proof[
      用设射影变换，将圆锥曲线变为正圆。在正圆的情形用角度表示交比，由圆周角相等，结论是非常容易的。另一方面需要利用同一法证明。\
    ]
    #remark[][
      假设使用之前代数方法的结论，可以给出一个代数的证明：\
      设 $B A_i^T = B times A_i$，且：
      $
      B A_3 = lambda_1 B A_1 + lambda_2 B A_2\
      B A_4 = mu_1 B A_1 + mu_2 B A_2
      $
      则：
      $
      vec(B A_3^T, B A_4^T) = mat(lambda_1, lambda_2; mu_1, mu_2) vec(B A_1^T, B A_2^T)\
      vec(B A_3^T, B A_4^T)(A_1, A_2, A_3, A_4)  = mat(lambda_1, lambda_2; mu_1, mu_2) vec(B A_1^T, B A_2^T)(A_1, A_2, A_3, A_4) \
      mat([B, A_3, A_1], [B, A_3, A_2],0, [B, A_3, A_4];[B, A_4, A_1], [B, A_4, A_2], [B, A_4, A_3], 0)  = mat(lambda_1, lambda_2; mu_1, mu_2) mat(0, [B, A_1, A_2], [B, A_1, A_3], [B, A_1, A_4];[B, A_2, A_1], 0, [B, A_2, A_3], [B, A_2, A_4]) \
      mat([B, A_3, A_1], [B, A_3, A_2];[B, A_4, A_1], [B, A_4, A_2])  = mat(lambda_1, lambda_2; mu_1, mu_2) mat(0, [B, A_1, A_2];[B, A_2, A_1], 0) \
      mat(lambda_1, lambda_2; mu_1, mu_2) ~mat([B, A_3, A_1], [B, A_3, A_2];[B, A_4, A_1], [B, A_4, A_2]) mat(0, 1; -1, 0) = mat([B, A_2, A_3], [B, A_3, A_1];[B, A_2, A_4], [B, A_4, A_1])
      $
      因此分比恰为：
      $
      [B, A_1, A_3][B, A_2, A_4] \/ [B, A_1, A_4][B, A_2, A_3]
      $
      然而注意到 
      $
      [B, A_1, A_3][B, A_2, A_4] = B^T (A_1 times A_3) (A_2 times A_4)^T B \
      ~ B^T ((A_1 times A_3) (A_2 times A_4)^T + (A_2 times A_4) (A_1 times A_3)^T) B
      $
      是过 $A_1, A_2, A_3, A_4$ 的二次曲线，分母同样处理，进而由之前结论：
      $
      [X, A_1, A_3][X, A_2, A_4] \/ [X, A_1, A_4][X, A_2, A_3] = k
      $
      对于不同的 $k$ 将唯一确定一个过 $A_1, A_2, A_3, A_4$ 的二次曲线，这就证明了结论。
    ]

    #theorem[Pascal][
      圆锥曲线上任意内接六边形的三组对边交点共线
    ]
    #proof[
      记 $A B C D E F$ 是一个内接六边形，三组对边分别为：
      $
      A B, D E := P\
      B C, E F := Q\
      C D, F A := R|
      $
    ]

    #proposition[][
      设 $P$ 是圆锥曲线 $Sigma$ 的内部点，则存在射影变换 $phi$，使得：
      - $phi(Sigma)$ 是圆
      - $phi(P)$ 是 $phi(sigma)$ 的圆心 
    ]
    #proof[
      考虑扩大的仿射平面，不妨设：
      $
      P = HomoCoor(0, 0, 1)
      $
      此时圆锥曲线方程为：
      $
      (x^T, z)mat(A, beta;beta^T, D)vec(x, z) = 0 
      $
      我们的目标是找保持原点的射影变换 $H$，也就是形如：
      $
      mat(C, 0;alpha^T, e) 
      $<equ171>
      的矩阵，将二次曲线变为标准的圆 $x^2 + y^2 - z^2 = 0$。\
      不妨设圆锥曲线方程在仿射平面表示椭圆，也即存在可逆矩阵 $C$：
      $
      C^T A C = I
      $
      此时，@equ171 的形式恰好与仿射平面上非齐次坐标下的仿射变换统一，而通过这样的变换容易将任何一个椭圆变成标准的圆，这就证明了结论。
    ]
    #definition[调和共轭][
      对于不在圆锥曲线上的一点 $P$，过 $P$ 做直线 $l$ 交圆锥曲线于点 $A, B$，则直线上满足：
      $
      (P, Q;A, B) = -1
      $
      的点 $Q$ 称为点 $P$ 的调和共轭点，此时 $P$ 也是 $Q$ 的调和共轭点
    ]

    #proposition[][
      不在圆锥曲线上的一点 $P$ 的所有调和共轭点恰构成一条直线，称为 $P$ 的极线。若 $P$ 在圆锥曲线外部，则这条线恰好是两个切点的连线。特殊的，称圆锥曲线上一点的极线为它的切线。
    ]

    #proof[
      设圆锥曲线方程为 $X^T A X = 0$，$P$ 点坐标为 $X_0$，$Q$ 点坐标为 $X_1$，$l$ 方程为 $lambda X_0 + mu X_1$。\
      联立：
      $
      (lambda X_0 + mu X_1)^T A (lambda X_0 + mu X_1) = 0 <=> lambda^2 X_0^T A X_0 + 2 lambda mu X_0^T A X_1 + mu^2 X_1^T A X_1 = 0 
      $<equ1>
      先假设直线与圆锥曲线不相切，此时上述方程的两组解 $lambda_1, mu_1; lambda_2, mu_2$ 满足 $lambda_i != 0$\
      因此注意到（利用韦达定理）：
      $
      (P, Q;A, B) = (mu_1 / lambda_1) / (mu_2 / lambda_2) = -1 <=> mu_1 / lambda_1 + mu_2 / lambda_2 = 0 <=> (2 X_0^T A X_1)/ (X_1^T A X_1) = 0\
       <=> X_0^T A X_1 = 0
      $
      对于给定的 $X_0$，所有满足 $X_0^T A X_1 = 0$ 的 $X_1$ 当然构成一条直线，这就证明了命题成立，同时也给出了极线的具体坐标公式。

      对于相切的情形，只需注意到在 @equ1 中，$Q$ 是切点当且仅当 $Q$ 在圆锥曲线上，且：
      $
      X_0^T A X_1 = 0
      $
      这和刚刚的极线是同一条直线。同时若固定 $X_1$，则直线：
      $
      X_1^T A X = 0
      $
      恰好就是过 $Q$ 的切线
    ]

    #proposition[][
      圆锥曲线的焦点的极线就是准线
    ]

    #definition[配极映射][
      给定圆锥曲线 $sigma$，构造一一映射将点映为点的极线，它给出了射影平面与对偶平面的一个同构。
    ]
= Mobius 变换
  == 反演
    #definition[反演][
      在 $EE^2$ 中，称以 $O$ 为圆心，$r$ 为半径的圆 $C$ 关于圆 $C$ 的反演为：\
      $phi: EE^2 - {0} -> EE^2 - {0}$
      它将 $P$ 映到射线 $O P$ 上一点 $P'$，且满足：
      $
      |O P||O P'| = r^2
      $
    ]
    #proposition[][
      - 反演变换满足：$phi^2 = I$
      - 反演变换将不经过 $O$ 的圆映成圆，将经过 $O$ 的圆映成直线，将不经过 $O$ 点的直线映成圆
      - 反演变换将与 $C$ 正交的圆，经过 $O$ 的直线保持不变（注：正交指两圆心与交点的连线垂直）
    ]
    #proof[
      + 是显然的\
      + 设另一圆的方程为：
        $
        (X^T, 1) mat(I, beta;beta^T, d) vec(X, 1) = 0
        $
        反演变换即为：$X -> c/(X^T X) X$，从而圆的像的方程为：
        $
        (c/(X^T X) X^T, 1) mat(I, beta;beta^T, d) vec(c/(X^T X) X, 1) = 0\
        (c X^T, X^T X) mat(I, beta;beta^T, d) vec(c X, X^T X) = 0\
        d (X^T X)^2 + 2 c beta^T (X^T X)X + c^2 X^T X = 0\
        d X^T X + 2 c beta^T X + c^2 = 0\
        $
        从而 $d = 0$ 时它就是直线，否则是圆：
        $
        X^T X + (2 c)/d beta^T X + c^2/d = 0\
        $
        同时，它就是原来的圆当且仅当：
        $
        c = d
        $
      + 保持过 $O$ 直线不变是显然的，保持正交的圆参照上面的计算即可。

      
      //(X - O)^T (X-O) = r^2 <=> X^T X - 2 O^T X + O^T O - r^2 = 0$，设其上一对对称点为 $X_1, X_2$，则有：
      //  $
      //  X_2 - O = r^2/((X_1 - O)^T (X_1 - O)) X_1 - O
      //  $
      //  在反演变换下，圆 $C$ 变为：
      //  $
      //  (O^T O - r^2)X^T X - 2 c O^T X + c^2 = 0
      //  $

    ]
    #remark[][
      反演可被看作球极投影，也即找一个球与一个平面，将球上某点在平面上的投影和该点关于球极在平面上的中心投影相关联，这就是平面上的反演变换
    ]
    #definition[扩充平面][
      在 $EE^2$ 上增加一个无穷远点 $infinity$，在反演中补充将原点映为 $infinity$，此时反演是 $overline(EE^2)$ 上的一一对应。
    ]
    #theorem[保角][
      反演变换保持角度（这里指原来的直线夹角等于映射后圆的夹角），但方向相反
    ]
    #proof[
      从几何的角度来说，我们可以构造圆的夹角（某个交点处两个圆各自切线的夹角），然后证明圆的夹角不变即可）。\
      选取交于点 $P$ 的两个圆，满足两条切线 $l_1, l_2$ 的夹角之间包含原来的角。\
      经过反演变换，$l_1, l_2$ 变为过 $O$ 点的圆，且一个交点为 $sigma(P)$。\
      可以证明，$phi(l_1), phi(l_2)$ （作为圆）在 $O$ 处切线与 $l_1, l_2$ 平行但反向，进而圆 $phi(l_1), phi(l_2)$ 的夹角与原来两个圆的夹角相等
    ]
  == 用复数表示反演变换
    人们发现，表示反演最好的方式是看作复平面（加上无穷远点）上的变换。加上一个无穷远点得到的平面称为黎曼面，记作 $overline(CC)$。\
    #remark[][
      复平面上任意一个圆的方程可以写作：
      $
      (z, 1)mat(I, -overline(z_0);z_0, d) vec(overline(z), 1) = 0\
      <=>z overline(z) - z z_0 - overline(z) overline(z_0) + d = 0\
      <=> (z - z_0) (overline(z - z_0)) = -d + z_0 overline(z_0)
      $
      其中圆心为 $z_0$，半径的平方为 $-d + z_0 overline(z_0)$\
      换言之，设 $z_1$ 的反演像为 $z_2$ 当且仅当：
      $
      (z_1 - z_0)(overline(z_2 - z_0)) = -d + z_0 overline(z_0)
      $
      整理回去，这就是：
      $
      (z_1, 1)mat(I, -overline(z_0);z_0, d) vec(overline(z_2), 1) = 0\
      $
      换言之，只需要在圆的方程中，将 $z$ 换为 $z_1$，将 $overline(z)$ 换为 $overline(z_2)$ 即可\
    ]<关于圆的反演>
    #proposition[][
      假设反演中心为 $z_0$，半径为 $r$，则有变换公式：
      $
      phi(z) = z_0 + r^2/(overline(z) - overline(z_0))
      $
      若关于以原点为中心的单位圆做反演，则得到更简单的公式：
      $
      phi(z) = 1/overline(z)
      $
    ]
    #definition[关于圆的对称点][
      设 $z_1$ 关于圆 $C$ 的反演像为 $z_2$，则称 $z_1, z_2$ 关于圆 $C$ 对称
    ]
    #proposition[][
      反演保持两点关于圆的对称性
    ]
    #proof[
      不妨设反演是关于圆心在原点的单位圆上的反演\
      设圆 $C$ 的方程为：
      $
      f(z, overline(z)) = 0
      $
      则它的反演像为：
      $
      f(Inv(phi)(z), Inv(phi)(overline(z))) = 0\
      <=> f(1/overline(z), 1/z) = 0
      $
      我们只需要验证 $z_1, z_2$ 的像 $phi(z_1), phi(z_2)$ 在新的圆上保持对称即可，也即：
      $
      0 = f(1/overline(phi(z_1)), 1/phi(z_2)) = f(z_1, overline(z_2)) = 0
      $
      （这是因为@关于圆的反演 中的论断）\
      从而结论成立
    ]
    在黎曼面上，我们往往认为一条直线包含无穷远点是一个无穷大圆，因此将圆和直线做以统一的看待，同时将关于直线的反射称为关于无穷大圆的反演。
    #theorem[][
      关于直线的反射可以表示为 $sigma_1 dot sigma_2 dot sigma_1$，其中 $sigma_1, sigma_2$ 是关于普通圆的共轭。
    ]
    == 莫比乌斯变换
    #definition[莫比乌斯变换][
      $overline(CC)$ 上偶数个关于圆的反演称为莫比乌斯变换，奇数个称为反莫比乌斯变换。记所有莫比乌斯变换/反莫比乌斯变换构成的集合为 $M_2^+, M_2^-$，并令 $M = M_2^+ union M_2^-$。$M_2, M_2^+$ 构成群，且 $|M_2 : M_2^+| = 2$，进而成为正规子群。
    ]
    #proposition[][
      平面上常见的变换，包括平移、旋转、位似可以唯一扩充为复平面上的莫比乌斯变换
    ]
    #theorem[][
      扩充复平面上的莫比乌斯变换可以表示为分式线性变换：
      $
      sigma(z) = (a z + b)/(c z + d)\
      (a d - b c) != 0, a, b, c, d in CC
      $
      反莫比乌斯变换可以表示为共轭分式线性变换，也即：
      $
      sigma(z) = (a overline(z) + b)/(c overline(z) + d)\
      (a d - b c) != 0, a, b, c, d in CC
      $
      且这些表示方式都是唯一的。
    ]
    #proof[
      + 容易验证分式线性变换的复合还是分式线性变换，只需证明两个反演的复合是分式线性变换即可。
      + 只需证明分式线性变换与反演的复合是共轭分式线性变换即可
      + 对于唯一性，容易验证两个系数不同的分式线性变换一定表示不同的变换
    ]
    #proposition[分式线性变换的代数表示][
      设所有分式线性变换构成的群为 $H$，则有：
      $
      H tilde.eq quotient("SL"(2, CC), {I, -I}) := "PSL"(2, CC)
      $
    ]
    #theorem[][
      扩充复平面上的分式线性变换可以表示为正伸缩变换和反定向保距变换的复合，或者是反演变换和保定向保距变换的复合。
    ]
    #theorem[][
      任何三点确定一个（反）莫比乌斯变换
    ]
    #proof[
      只需证明给定任何三点 $z_1, z_2, z_3$，存在唯一（反）莫比乌斯变换将三点变为：
      $
      0, 1, infinity
      $
      这是简单的。\
      - 假如三点不共线，关于过三点的圆做反演使得三点共线
      - 关于 $z_3$ 为圆心，取适当半径使得 $z_1, z_2$ 的像的距离为 $1$（由连续性这是可行的）
      - 再加上平移和旋转便可让三点的像满足要求
      注意最后我们反演的次数可能为奇数或偶数，这是无关紧要的，只需要再做一次共轭（关于实轴的反演）即可。
    ]
    #theorem[][
      （共轭）分式线性变换与（反）莫比乌斯变换之间存在一一对应，同时它们都被不同三点的像唯一确定
    ]
    #proof[
      对于任意分式线性变换，考虑 $0, 1, infinity$ 三点的像确定的（反）莫比乌斯变换，这个莫比乌斯变换的分式线性表示当然就是原来的分式线性变换。由于表示的唯一性，这也是唯一的满足要求的莫比乌斯变换，因此一一对应性成立。\
      同时，三点的像唯一确定一个分式线性变换的容易验证的，进而也唯一确定一个莫比乌斯变换。
    ]
    #proposition[][
      分式线性变换 $f(z) = (a z + b)/(c z + d)$ 是正伸缩与保定向保距变换的复合，或者反演与反定向保距变换的复合\
      共轭分式线性变换是反定向保距，或者正伸缩与直线反射，或者反演与保定向保距变换的复合
    ]
    #proof[
      只证明前者，后者是类似的
      - 若 $c = 0$，则：
        $
        f(z) = (a/d) z + (b/d)
        $
        令 $a/d = r e^(i theta)$ ，这当然是正伸缩与保定向保距变换的复合
      - 若 $c != 0$，不妨设 $a d - b c = 1$，取 $z_0 = phi(infinity) = a/c$，我们想先处理无穷点，从而取圆心为 $a/c$，半径为 $r$ 的反演 $phi_1$，计算得：
        $
        phi compose f(z) = - (overline(c))/c overline(z) + (overline(a) - overline(d))/c
        $
        这当然是一个反定向的保距变换
    ]
    #corollary[][
      任何莫比乌斯变换可以写成至多四个反演变换的复合。
    ]
    #example[保持两点不动的莫比乌斯变换][
      - 设莫比乌斯变换保持两点 $a, b$ 不动，则：
        $
        (sigma(z) - a)/(sigma(z) - b) = r e^(i theta)(z - a)/(z - b)
        $
        且 $r, theta$ 与 $z$ 无关。
      - 进一步，设 $sigma(z_1) = infinity, sigma(infinity) = z_2$，将有：
        $
        r e^(i theta)(z_1 - a)/(z_1 - b) = 1\
        (z_2 - a)/(z_2 - b) = r e^(i theta)\
        $
        从而 $z_1, z_2$ 同时成为二次方程：
        $
        (x-a)/(x-b) + (x-b)(x-a) = r e^(i theta) + 1/r e^(-i theta)
        $
        的两个根
    ]
    #definition[复交比][
      定义复平面上互异四点的交比为：
      $
      (A, B;C, D) = ((A - C)/(A - D)) / ((B - C)/(B - D))
      $
      它在莫比乌斯变换下保持不变，在反莫比乌斯变换下变为它的共轭
    ]
    #theorem[][
      复平面上四点共圆（包括无穷大圆）当且仅当四点交比为实数
    ]
    #proof[
      注意到反莫比乌斯变换与复交比的性质，若四点共圆，则关于此圆做反演可得四点交比等于自己的共轭。\
      若四点不共圆，取适当的莫比乌斯变换将 $z_1, z_2, z_3$ 变为 $0, 1, infinity$，同时 $z_4$ 此时不是实数（否则它们共无穷大圆），计算验证四点交比不是实数即可
    ]
  == 双曲几何
    === 圆盘模型
      #definition[庞卡莱的双曲几何模型][
        令 $D = {z in CC | |z| < 1}$。无穷远点定义为 ${z | |z| = 1}$\
        变换群 $H$ 为所有保持 $D$ 稳定（集合不动）的莫比乌斯变换，这被称为双曲几何变化群。\
        定义直线为所有与无穷远圆 $D$ 正交的圆或直线 $Tau$，关于 $Tau$ 的反演将保持 $D$ 不变，两个反演的复合被称为双曲变换。\
        定义双曲反射是关于（上面定义的）直线的反演变化，它保持 $D$ 不变。\
        （注意到莫比乌斯变换保持角度，因此保持正交，故将双曲直线映为双曲直线）
      ]
      #proposition[][
        $H$  中任何一个变换可表示为两个双曲反射的复合
      ]
      #proof[
        取 $Z_0, Z_1$ 使得 $phi(Z_0) = 0, phi(Z_1) = 1$\
        再设 $Z_0^*$ 为 $Z_0$ 关于 $D$ 的对称点。由于莫比乌斯变换保持圆的对称点不动，因此有：
        $
        phi(Z_0^*) = infinity
        $
        - 若 $Z_0 = 0$, 则 $phi$ 保持 $0, infinity$ 不动，这表明 $phi$ 就是平凡的旋转，也就是两个过 $O$ 点直线反演的复合
        - 若 $Z_0 != 0$，则 $Z_0^* != infinity$\
          此时，先作以 $Z_0^*$ 为圆心与 $D$ 正交的圆，将关于这个圆的反演记为 $phi_1$，则有：
          $
          phi_1 (D) = D\
          phi_1 (Z_0^*) = infinity\
          phi_1 (Z_0) = 0 "（这是因为保持对称点不动）"
          $ 
          此时当然有 $phi_1(Z_1) != infinity$，故取 $phi_1 (Z_1), phi(Z_1)$ 的中垂线。注意到 $phi_1 (Z_1)$ 仍在圆上，这个中垂线当然过点 $0$\
          记关于这条中垂线的反射为 $phi_2$，我们发现：
          $
          phi_2 compose phi_1 (Z_0, Z_1, Z_0^*) = (0, 1, infinity) = phi(Z_0, Z_1, Z_0^*)
          $
          由于莫比乌斯变换的像由不同三点唯一确定，因此我们有：
          $
          phi_2 compose phi_1 = phi
          $
          证毕
      ]
      #proposition[][
        任取 $z_1 in D, z_2 in S_infinity$，存在双曲变换使得：
        $
        phi(z_0) = 0\
        phi(z_1) = 1
        $
      ]
      这个命题说明双曲平面上任何一点都没有特殊之处。\
      #proposition[几何公理][
        - 过任何两点存在唯一双曲直线
        - 过 $l$ 外一点 $C$，存在无穷多条与 $l$ 不交的双曲直线
      ]
      #proof[
        + 不妨设 $a = 0$，结论是容易的（注意到反演将过原点 $0$ 的圆映成直线，将与 $D$ 正交的圆保持不动，因此过 $0$ 的圆不可能与 $D$ 垂直）
        + 同样不妨设 $c = 0$，此时 $l$ 是一个与 $D$ 正交的圆，当然容易取出无穷多条过 $0$ 的直线与 $l$ 不交
      ]
      #proposition[][
        任给圆周 $D$ 上三点组 $z_1, z_2, z_2$, $w_1, w_2, w_3$，存在至多三个双曲反射它们的复合 $phi$ 满足：
        $
        phi(z_1, z_2, z_3) = (w_1, w_2, w_3)
        $
      ]
      #proof[
        显然这样的莫比乌斯变换是存在且唯一的，记为 $phi$，同时 $phi$ 一定会保持圆周不变
        - 若 $z_1, z_2, z_3$ 与 $w_1, w_2, w_3$ 旋转方向相同，则由交比知保持圆周的内部，进而保持圆内集合稳定。因此 $phi in H$，进而是至多两个双曲反射的复合。
        - 若 $z_1, z_2, z_3$ 与 $w_1, w_2, w_3$ 旋转方向相反，再取双曲反射将 $w_1, w_3$ 互换即可
      ]
      #theorem[][
        任何圆盘 $D$ 上的莫比乌斯变换可表示为：
        $
        phi(Z) = e^(i theta)(z-a)/(overline(a)z - 1), |a| < 1
        $
        反莫比乌斯变换可表示为：
        $
        phi(Z) = e^(i theta)(overline(z)-a)/(overline(a)overline(z) - 1), |a| < 1
        $
      ]
      #definition[庞加莱圆盘上的双曲距离][
        在庞加莱圆盘上，对任意点 $z_1, z_2$，按照如下方法定义距离：\
        过 $z_1, z_2$ 作唯一的双曲直线 $l$ 交圆周 $D$ 于 $eta_1, eta_2$，使得 $eta_1, z_1, z_2, eta_2$ 逆时针排列。则定义：
        $
        d(z_1, z_2) = -ln ((z_2, z_2;eta_1, eta_2))
        $
        （注意到由于四点共线，复交比是实数）
        为 $z_1, z_2$ 间的双曲距离，同样也是：
        $
        ln (|z_1 - eta_2| |z_2 - eta_1|)/(|z_1 - eta_1| |z_2 - eta_2|)
        $<distance>
      ]
      #lemma[][
        $p(0, z) = ln (1 + |z|)/(1 - |z|)$
      ]<distance-to-zero>
      这个性质表明定义的距离与无穷远圆是相容的
      #proposition[][
        双曲距离满足：
        - 正定性： $d(z_1, z_2) >=0, d(z_1, z_2) = 0 <=> z_1 = z_2$
        - 对称性： $d(z_1, z_2) = d(z_2, z_1)$
        - 在双曲反射，双曲变换下保持不变
        - 若 $z_1, z_2, z_3$ 三点共线，且 $z_2$ 在 $z_1, z_3$ 之间，则：
          $
          p(z_1, z_2) + p(z_2, z_3) = p(z_1, z_3)
          $
        同时满足三角不等式，但证明略微复杂，我们留到后面
      ]
      #proof[
        + 由定义，不难看出 $|z_1 - eta_2| >= |z_2 - eta_2|, |z_2 - eta_1| >= |z_1 - eta_1|$，因此在@distance 中自然有 $p(z_1, z_2) >=0$，同时等于零当且仅当 $z_1 = z_2$
        + 显然
        + 由于双曲反射，双曲变换保持圆周 $D$，保持复交比（保持复交比进而保持复交比的正负，从而顺序也得以保持），结论显然
        + 取双曲变换，不妨设 $z_2 = 0$，进行计算可得
      ]
      #proposition[][
        $p(z, w) = ln (|overline(z) w - 1| + |z - w|)/(|overline(z) w - 1| - |z-w|)$
      ]
      #proof[
        取双曲反射：
        $
        sigma(x) = z/(overline(z)) (overline(x) - overline(z))/(z overline(x) - 1)
        $
        它将 $z$ 变成零，利用 @distance-to-zero 计算即可
      ]
      #proposition[][
        - $cosh^2 (1/2 p(z, w)) = (|1 - z overline(w)|^2)/((1 - |z|^2)(1-|w|^2))$

        - $sinh^2 (1/2 p(z, w)) = (|w - z |^2)/((1 - |z|^2)(1-|w|^2))$

        - $tanh^2 (1/2 p(z, w)) = (|w - z |^2)/(|1 - z overline(w)|^2)$
      ]
      #proposition[][
        设点 $x$ 到原点 $o$ 的欧式距离为 $r$，则双曲距离满足：
        $
        p(0, x) = ln (1 + r)/(1-r) > r
        $
        同时，注意到当 $r -> 0$ 时上式与 $r$ 是同阶无穷小，意味着假如最开始的圆盘取的充分大，或者说考虑的尺度非常小，则双曲几何近似于欧式几何
      ]
      #corollary[][
        双曲圆也是欧式圆
      ]
      #proposition[三角不等式][
        双曲距离满足三角不等式：
        $
        p(z_1, z_2) + p(z_2, z_3) >= p(z_1, z_3)
        $
        取等当且仅当 $z_2$ 位于线段 $z_1 z_3$ 上
      ]
      #proof[
        #lemma[双曲直角三角形中，斜边大于直角边][
          设 $A in l$, 过 $B$ 作垂直于 $l$ 的双曲直线 $l'$ 交 $l$ 于 $M$（注意到我们可以把 $A$ 映到原点，从而证明这样的直线是存在的）\
          则有：
          $
          p(A, M) <= p(A, B)
          $
          取等当且仅当 $B in l$
        ]
        #proof[
          不妨设 $A$ 是原点，$l$ 是实轴，则取 $B$ 关于 $l$ 的对称点 $B'$，过 $B, B'$ 的双曲直线 $l'$ 一定与 $l$ 垂直\
          注意到欧式圆也是双曲圆，从图形上容易看出结论成立
        ]
        回到命题的证明，只需过 $z_2$ 作直线 $l$ 垂直 $z_1, z_3$，结合引理和之前证明的可加性容易得到结论成立。
      ]
      #proposition[双曲正/余弦定理][
        记 $A B C$ 为一个双曲三角形，对应边分别为 $a, b, c$，三个角分别为 $A, B, C$\
        我们有：
        - 双曲正弦定理：$(sinh a)/(sin A) = (sinh b)/(sin B) = (sinh c)/(sin C)$
        - 双曲余弦定理：$cosh c = cosh a cosh b - sinh a sinh b cos C$
        - 对偶余弦定理：$- cos C = cos A cos B - cosh c sin A sin B $
        这表明双曲几何中，同样只有全等没有相似
      ]
      #proof[
        先证明双曲余弦定理，不妨设 $C = 0$，则：
        $
        a = ln (1+r)/(1-r)\
        b = ln (1+s)/(1-s)\
        c = ln (1+delta)/(1-delta), delta = (|s - r|)/(|r s - 1|)
        $
        同时：
        $
        r = tanh (a/2)\
        s = tanh (b/2)\
        delta = tanh (c/2)
        $
        注意此时的 $cos C$ 就是欧式几何中的 $cos C$ 因此可以利用欧式几何中的余弦定理，计算即得。\
        对于正弦定理，我们只需利用余弦定理计算平方之后化简即可。\
        由正弦定理，设：
        $
        sin A = R sinh A ...
        $
        带入计算即得对偶余弦定理
      ]
      #remark[][
        回忆 @球面几何正余弦 中球面几何的正余弦公式，它们几乎是一致的，只是将边的正余弦换成了双曲正余弦
      ]
      #proposition[][
        半径为 $r$ 的双曲圆的周长为 $2 pi sinh(r)$
      ]
    === 上半平面模型
      在圆盘模型中，如果取 $i$ 为圆心，半径为 $sqrt(2)$ 的圆做反演变换。这个反演把圆盘 $D$ 映为下半平面。再取关于实轴的反演，便将下半平面映为上半平面。这样，我们就得到了上半平面模型。\
      或者说，在莫比乌斯变换：
      $
      phi(z) = (-i z + 1)/(z - i)
      $
      下，单位圆盘被映成上半平面。\
      #definition[上半平面模型][
        将上述的莫比乌斯变换下 $D$ 的像成为上半平面模型，其上的距离自然的定义为拉回圆盘模型上的双曲距离。\
        双曲直线共有两类，包括与实轴垂直的上半直线与圆心在实轴上的上半圆
        同时，假设圆盘模型的双曲变换群为 $H$，当然有上半平面模型中，保持上半平面不变的所有莫比乌斯变换恰为：
        $
        phi compose H compose Inv(phi)
        $
      ]
      显然，上半平面模型与圆盘模型等距同构。但在某些应用中比庞卡莱模型更加方便一些。\
      #proposition[][
        设 $x = a + b i, y = a + c i, c > b$，则：
        $
        p(x, y) = ln (c/b)
        $
      ]
      #proof[
        通过平移和放缩，不妨设 $x = im, y = lambda i, lambda = c/b$，进而：
        $
        Inv(phi)(x) = 0\
        Inv(phi)(y) = (1-lambda)/(i+lambda i)
        $
        在庞卡莱圆盘模型中，计算距离即得结论。
      ]
      #proposition[][
        - @distance 中距离计算公式同样成立
        - 
          $
          p(z, w) = ln (|z - overline(w)| + |z - w|)/(|z - overline(w)| - |z - w|)
          $
      ]
      #definition[双曲面积][
        （若积分存在）定义上半平面模型中某个区域 $A$ 的面积为：
        $
        integral_A 1/y^2 d x d y
        $
      ]
      #definition[双曲多边形][
        由 $n$ 段双曲线段组成的闭曲线称为双曲多边形，两个双曲线段的交点称为顶点，在无穷远点的顶点称为理想点。\
      ]
      #theorem[Gauss - Binet][
        设双曲三角形 $A B C$ 的三个角分别为 $A, B, C$，则三角形的面积为：
        $
        pi - A - B - C
        $
      ]
      #proof[
        - 假设至少有一个理想点，不妨设两边为垂直实轴的直线，计算积分即可
        - 若不然，将 $A B C$ 延伸至有理想点的三角形 $A B D$，则有：
          $
          S(A C D) = pi - A - angle A C D\
          S(C B D) = pi - angle C B D - angle D C B = B - angle D C B\
          $
          两式相减即可
      ]
      #theorem[海伦公式][
        设双曲三角形 $A B C$ 三边为 $a, b, c$，令：
        $
        alpha = cosh(a), beta = cosh(b), gamma = cosh(c)\
        Delta = sqrt(1 - alpha^2 - beta^2 - gamma^2 + 2 alpha beta gamma )
        $
        则：
        $
        cos(S) = (alpha + beta + gamma + alpha beta + beta gamma + alpha gamma + alpha^2 + beta^2 + gamma^2 -alpha beta gamma )/((1+alpha)(1+beta)(1+gamma))\
        tan(S/2) = Delta/(1 + alpha + beta + gamma)\
        sin(S/2) = Delta/(4 cosh(a/2)cosh(b/2)cosh(c/2))
        $
      ]
      #proof[
        证明可见：\
        https://www.maths.gla.ac.uk/wws/cabripages/hyperbolic/hareaproof.html
      ]
      #remark[][
        双曲几何中未必三点一定确定一条直线或一个圆，例如 $-2 + i, i, 2 + i$ 不在任何双曲直线或圆上
      ]
      #proposition[][
        上半平面模型中，所有双曲变换可表示为：
        $
        phi(z) = (a z + b)/(c z + d), a d - b c = 1, a, b, c, d in RR\
        phi(z) = (a overline(z) + b)/(c overline(z) + d), a d - b c = 1, a, b, c, d in RR
        $
        进一步，有：
        $
        Isom(UU) tilde.eq "PSL"(2, RR) times ZZ_2
        $
      ]
      #definition[][
        取 $T != I in "PSL"(2, RR)$，$"Tr"(T) = |a + d|$：
        - 若 $"Tr"(T) < 2$，$T$ 被称为椭圆的，它共轭于 $z -> e^(i theta) z$，恰有一个不动点
        - 若 $"Tr"(T) = 2$，$T$ 被称为抛物的，它共轭于 $z -> z + 1$，没有不动点
        - 若 $"Tr"(T) > 2$，$T$ 被称为双曲的，它共轭于 $z -> lambda^2 z, lambda > 1$，有两个不动点
      ]
      #proof[
        考虑 $"PSL"(2, RR)$ 中元素的相似分类即可
      ]
      #definition[][
        任取 $T in "PSL"(2, RR)$ 为双曲的，设其不动点为 $z_1, z_2$，则称 $T$ 的轴为过 $z_1, z_2$ 的双曲直线，显然这条直线被 $T$ 保持不变
      ]
      #definition[][
        为 $"PSL"(2, RR)$ 上附上 $RR^4$ 上的通常度量（距离定义为所有 $|T-S|$ 取正负中较小的）和拓扑，则乘积和取逆都是连续的，意味着构成一个拓扑群。
      ]
    === 射影洛伦兹模型
      #definition[射影洛伦兹模型][
        在线性空间 $RR times RR^2$ 上定义内积：
        $
        vec(x_1, y_1) dot vec(x_2, y_2) = x_1 x_2 - y_1^T y_2 
        $
        等价于在 $RR^3$ 上定义内积：
        $
        alpha dot beta = alpha^T mat(1, 0, 0;0, -1, 0;0, 0, -1)beta
        $
        其中 $x$ 称为时间分量，$y$ 称为空间分量。这个内积不具有正定性。\
        满足 $alpha dot alpha = 0$ 的向量称为光锥，$alpha dot alpha > 0$ 称为类时向量，$alpha dot alpha < 0$ 称为类空向量\

        在这个内积下，定义：
        $
        F = {x in RR^3 | norm(x)^2 = 1, x_1 > 0}
        $
        对 $x, y in F$，定义： 
        $
        d(x, y) = arccos (x dot y)
        $
        它的合法性由下面的引理给出
      ]
      #lemma[][
        设 $x, y$ 是正类时向量，则：
        $
        (x dot y)^2 >= norm(x)^2 norm(y)^2
        $
      ]
      #proof[
        设 $V = generatedBy(x\, y)$ ，洛伦兹内积在其上是实对称的非正定/负定的双线性函数。注意到：
        $
        ((x, y) X) dot ((x, y) Y) = X^T vec(x^T, y^T) mat(1, 0, 0;0, -1, 0;0, 0, -1) (x, y) Y \
        = X^T mat(x dot x, x dot y; x dot y, y dot y) Y
        $
        由于非正定非负定，故系数矩阵行列式小于 $0$，这就是原结论
      ]
      #theorem[][
        $
        funcDef(phi, F, D, (x_1, x_1, x_2), (x_1 + i x_2)/(1 + x_0))
        $
        是双曲平面的等距映射
      ]
      这个事实并不平凡，证明在此略过
      #definition[][
        在洛伦兹空间中，定义叉乘为仿照欧式空间的叉乘（同样将后两项的符号取反）
      ]
      #proposition[][
        洛伦兹叉乘有类似一般叉乘的代数性质
      ]
      #theorem[][
        洛伦兹空间上的一个保距变换一定是线性变换，同时满足：
        $
        S mat(1, 0, 0;0, -1, 0;0, 0, -1) S^T = mat(1, 0, 0;0, -1, 0;0, 0, -1),\
        |S| = 1
        $
      ]
      #lemma[][
        设 $A B C$ 是双曲三角形，边长为 $a b c$ ，则：
        $
        cosh(c) = A dot B\
        sinh(c) = -i norm(A times B)\
        cos(C) = - (C times A) dot (C times B)/(norm(C times A) norm(C times B))
        $
      ]
      有了这些公式，我们将可以利用类似球面几何的向量计算的方法计算三角公式的正确性。

      一般的，我们定义：
      #definition[双曲几何][
        一个度量空间称为 $2$ 维双曲几何，如果它与圆盘模型/上半平面模型等距同构
      ]
= 拓扑空间
  == 概念
    拓扑空间可以想成 $RR^n$ 上良好的开/闭结构的一种推广
    #definition[拓扑][
      $S$ 被称为一个拓扑空间，如果：
      - 存在集合族 $Tau$，其中元素称为开集
      - $emptyset in Tau$
      - 任意多个开集的并仍是开集
      - 有限多个开集的交仍是开集
      此时，称 $Tau$ 为 $S$ 上的一个拓扑。也称开集的补集为闭集。
    ]
    #proposition[][
      闭集满足：
      - 任意多个闭集的交仍是闭集
      - 有限多个闭集的并仍是闭集
    ]
    #example[][
      任何度量空间都可以仿照欧式情形定义拓扑，称为欧式拓扑。特别的，离散度量给出的拓扑中，每个点都是开集，称为离散拓扑。
    ]
    #definition[邻域][
      称一个点的 $X$ 的任意包含一个包含 $X$ 的开集的开集为邻域
    ]
    #definition[聚点/极限点][
      称 $A$ 是集合 $E$ 的的极限点，如果对于 $A$ 的任意邻域 $X$，均有 $X sect E$ 非空
    ]
    #remark[][
      类似可以定义序列的极限点，但是在一般拓扑空间中序列可能有多个极限点，同时集合的极限点也未必是其中某个序列的极限点，因此不是很常用
    ]
    #theorem[][
      - $X$ 是闭集当且仅当它包含所有聚点。
      - 聚点的聚点还是原集合的聚点
      由此，称 $X$ 并上所有极限点称为 $X$ 的闭包，它是最小的包含 $A$ 的闭集
    ]
    #definition[连续映射][
      - 称 $f: A -> B$ 是连续映射，如果对任意开集 $S subset B$ 均有 $Inv(f)(S)$ 是开集
      - 称 $f: A -> B$ 在 $x_0$ 处连续，如果 $f$ 在 $x_0$ 的某个邻域连续
    ]
    #proposition[][
      - 函数在 $X$ 上连续当且仅当在 $X$ 中每个点连续
      - 连续映射的复合还是连续的
    ]
    #proof[
      + 一方面是显然的，另一方面，假设 $f$ 在每个点上连续，从而对每个点 $x$，存在 $S_x$ 使得 $f|_(S_x) : S_x -> B$ 连续。任取开集 $Y subset B$，将有：
        $
        A = union.big_(x in A) S_x\
        Inv(f)(Y) = union.big_(x in A) S_x sect Inv(f)(Y) = union.big_(x in A) Inv(f|_(S_x))(Y)
        $
        由题设及开集的并仍是开集知原命题成立
    ]
    #theorem[][
      下列说法等价
      - 映射连续
      - 映射满足闭集的原像是闭集
      - 对于任意 $Beta$ 是 $Y$ 的拓扑基，也即任何 $Y$ 中开集都可写作 $Beta$ 中某些元素的并，映射满足拓扑基中开集的元素是开集
      - $forall X subset A$，有 $f(overline(A)) subset overline(f(A))$
      - $forall Y subset B$，有 $Inv(f)(overline(A)) subset overline(Inv(f)(A))$
    ]
    #lemma[][
      设 $A_i$ 是有限个闭集，且 $X = union.big A_i$。若 $f$ 在每个 $A_i$ 上都连续，则 $f$ 在 $X$ 上连续
    ]
    #remark[][
      这个引理改为有限/无穷多个开集仍然成立，但是无穷个闭集是不行的
    ]
    #example[乘积拓扑][
      设 $S, T$ 为拓扑空间，则 $S times T$ 上的拓扑定义为由 $S$ 中开集与 $T$ 中开集相乘作为拓扑基生成的拓扑。可递归定义有限多情形。对于无穷情形，我们一般要求其中至多有限个不是全集。
    ]
    事实上，我们规定的乘积拓扑就是满足两个投影函数均连续的最小拓扑，因此自然满足下面的定理：
    #theorem[][
      $f: Z -> X times Y$ 连续当且仅当 $p_x compose f, p_y compose f$ 都连续
    ]
    #example[][
      设 $X = RR union {0^+}$，其中开集为 $RR$ 中开集或者 $(-a, 0) union (0, b) union {0^+}$。在这个拓扑空间中，$0, 0^+$ 的任何邻域都是相交的，因此这不可能是一个度量空间。这种拓扑空间是不可分的，略显病态。
    ]
  == 分离与可数
    #definition[分离性][
      设 $X$ 为拓扑空间：
      - 称 $X$ 为 $T_1$ 空间，若对任何 $x != y$，存在 $x, y$ 的邻域使得其中不包含另外一个（一个等价的说法是单点集是闭集）
      - 称 $X$ 为 $T_2$ 或者 Hausdoff，如果对任何 $x != y$，存在 $x, y$ 的邻域使得两者不相交
      - 称 $X$ 为 $T_3$ （正则，Regular）的，如果它是 $T_1$ 的且点与不相交的闭集有不相交的开邻域。一个等价说法是 $T_1$ 且对 $forall x$ 及它的开邻域 $W_1$，都存在开邻域 $U$ 使得：
        $
        X in U subset overline(U) subset W
        $
      - 称 $X$ 为 $T_4$ （正规, Normal）的，如果它是 $T_1$ 的且不相交的闭集之间有不相交的开邻域, 一个等价说法是 $T_1$ 且对 $forall "闭集" A$ 及它的开邻域 $W_1$，都存在开邻域 $U$ 使得：
        $
        A subset U subset overline(U) subset W
        $
      以上四者依次增强
    ]
    #proposition[][
      - 在 $T_1$ 空间中，若 $X$ 是 $A$ 的聚点，则 $X$ 的任意邻域都与 $A$ 交于无穷多个点
      - 在 Hausdoff 空间中，一个序列至多有一个极限点
      - $X times Y$ 是 Hausdoff 空间当且仅当 $X, Y$ 都是 Hausdoff 的
      - 度量空间是 $T_1, T_2, T_3, T_4$ 的
    ]
    #definition[可数性][
      - 称 $X$ 为第一可数或者 $C_1$，若 $forall x in X$ 有可数多个邻域基，也即存在可数多个邻域
      - 若 $A subset X$ 满足 $overline(A) = X$，则称 $A$ 在 $X$ 中稠密。若 $X$ 有可数多稠密的基，则称 $X$ 是可分的
      - 称 $X$ 为第二可数或者 $C_2$ 若 $X$ 有可数多的拓扑基
      以上三者依次增强
    ]
    #theorem[Lindeluf][
       $C_2 + T_3 => T_4$
    ]
    #proof[
      取 $X$ 的可数多拓扑基 $BB = {B_1, B_2, ..., B_n, }$，对与任意不相交闭集 $A_1, A_2$\
      令 $BB_i$ 为闭包与 $A_i$ 不交的所有 $B$ 的集合，再令：
      $
      U_n = B_2^n - union.big overline(B_2^i)\
      V_n = B_1^n - union.big overline(B_1^i)
      $
      取 $U = union U_i, V = union V_i$，则 $U sect V = emptyset$\
      任取 $x in A_1$，由 $T_3$ 知 $X$ 与 $A_2$ 有不相交的开邻域 $W_x, W_x'$，满足存在开集 $B$, $x in B subset W_x$\
      而 $overline(B) sect A_2 = emptyset => B = "某个" B_n$\
      $A_1 sect union B_2^i = emptyset => x in U_n subset U => A_1 subset U, A_2 subset V$
    ]
    #proposition[][
      可分的度量空间是第二可数的
    ]
    #lemma[][
      对 $T_4$ 空间中，若 $A sect B = emptyset$，则存在连续函数 $f$ 使得：
      $
      f(A) = 0, f(B) = 1
      $
      反之，若这个条件恒成立，则空间一定是 $T_4$ 的
    ]

    #proof[
      这个构造是很难的，思路类似于戴德金分划\
      令 $QQ_0 = QQ sect [0, 1] = {r_1 = 1, r_2 = 0, r_3, r_4, ...}$\
      对 $r_i$ 构造开集 $U_i$，满足：
      - $r_n < r_m => overline(U_n) subset U_m$
      - $A subset U_n subset B^c$
      定义函数 $f(x) = sup{0, r_n in QQ_0 | x in.not U_n} = inf{1, r_n in QQ_0 | x in U_n}$，只要证明它是连续函数即可
    ]
    #theorem[Tiltzet][
      设 $X$ 是 $T_4$ 空间，$A$ 是其中的闭集，$f: A -> R$ 是连续函数，则 $f$ 可被连续的延拓到 $X$ 上\
      同时，若此结果成立，容易验证空间一定是 $T_4$ 的
    ]
    #proof[
      我们的思路是找一串一致收敛的函数\
      不妨设 $f(A) subset [-1, 1]$（否则取 $arctan f := g$ 再做处理即可）。\
      令 $A_1 = Inv(f)([-1, -1/3]), B_1 = Inv(f)([1/3, 1])$\
      显然 $A_1, B_1$ 是 $X$ 中不相交的闭集，由之前的引理，将存在连续函数 $phi$ 使得：
      $
      phi_1(A_1) = - 1/3, phi_1(B_1) = 1/3
      $
      令 $f_1 = f - phi$，不难发现 $f_1(A) subset [-2/3, 2/3]$\
      反复进行这个步骤，不难得到一串函数 $phi_i subset [- (2^(n-1))/3^n, (2^(n-1))/3^n]$，利用维尔斯特拉斯判别法将其求和即可
    ]
    #definition[可度量化][
      称一个拓扑空间可度量化，如果存在一个度量，它诱导的拓扑空间与原空间同构
    ]
    #lemma[Vrysohn][
      $C_2 + T_4 =>$可度量
    ]
  == 紧致与列紧
    #definition[紧致][
      - 称一个拓扑空间是紧致的，如果其上任何开覆盖都有有限开覆盖。
      - 称一个拓扑空间是列紧的，如果其上任何无穷序列都有收敛子列。
    ]
    #theorem[][
      紧致空间的无穷子集必有聚点\
      注：这并不意味着紧致一定列紧，它们之间是互不包含的关系
    ]
    #lemma[Lebesgue][
      设 $X$ 是紧致度量空间，$e$ 是开覆盖，则存在 $delta > 0$，使得 $X$ 的任意直径小于 $delta$ 的子集都包含在 $e$ 的某一个开集之内，$delta$ 被称为 $e$ 的 Lebesgue 数
    ]<Lebesgue-lemma>
    #theorem[][
      - 紧致集的连续像仍然紧致
      - 紧致集的闭子集仍然紧致
      - 列紧空间上的实值函数有界且可取得最大最小值
      - 度量空间中紧致等价于列紧
      - $X times Y$ 紧致当且仅当 $X, Y$ 都紧致
    ]
    #proof[
      - 不妨假设 $f: X -> Y$ 是满连续映射，$X$ 是紧致集。\
      设 $BB$ 是 $Y$ 的一个开覆盖，则：
      $
      "map"_Inv(f)  BB = {Inv(f)(B) | B in BB}
      $
      当然是一个 $X$ 的开覆盖，它将有有限开覆盖:
      $
      AA' subset "map"_Inv(f)  BB
      $
      此时 $Y = f(X) subset union.big "map"_f AA' := BB' subset BB$
      - 设 $U$ 是 紧致空间 $X$ 的闭子集，设 $BB$ 是其一个开覆盖，则 $BB union {X - U}$ 当然也是 $X$ 的开覆盖，它将有有限开覆盖 $BB'$。\
        $BB'$ 当然也覆盖 $U$，且要么是 $BB$ 中有限个覆盖，要么是这样有限个覆盖加上 $X - U$。前者结论已成立，后者去掉 $X - U$ 不会影响它是 $X$ 的覆盖，进而结论也成立
      - 同 $RR$ 上情景的证明
      - 一方面，在度量空间中可以构造一个邻域开球，这个开球不包含之前任意有限多的点; 另一方面，由 @Lebesgue-lemma, 我们想到构造一些点，这些点的 $delta$ 邻域足以覆盖整个 $X$，进而在引理中取这些点对应的开集即可。事实上这些点是可以取得的，否则我们将可以得到一个无穷序列，其中每两个元素的距离都大于 $delta$，但这和列紧的定义无疑是矛盾的
      - 一方面，由 $X times Y -> X, Y$ 的投影映射是连续的，当然有紧致集的连续像紧致。另一方面，我们有引理: \
        假设 $A subset X$ 紧致，$y in Y$, $W$ 是 $X times Y$ 中紧致集 $A times {y}$ 的开邻域，则存在 $A$ 的开邻域 $U$ 与 $y$ 的开邻域 $V$ 使得 $W subset U times V$
    ]
    #remark[][
      在欧式拓扑中，紧致当且仅当是有界闭集，但在一般拓扑空间中未必。例如假设 $X$ 多于两个元素，赋予平凡拓扑仅有 $X, emptyset$ 为空集，此时单点集当然紧致但不闭。同时，一个集合紧致，它的闭包也未必紧致。
    ]
    #theorem[Tychonoff][
      设 $X_alpha, alpha in omega$ 是任意多的非空的紧致空间，则所有这些集合构成的乘积拓扑是紧致的
    ]
    #proof[
      它的证明是较为复杂的，我们不证明。事实上，它与选择公理是等价的。
    ]
    #theorem[][
      Hausdoff 空间的紧子集都是闭集
    ]
    #proof[
      设 $A$ 是紧子集，$y in X - A, forall x in A$ ，存在不交的开邻域 $y in U_x, x in V_x$\
      取遍所有 $x$, $V_x$ 将构成一个开覆盖，它有有限开覆盖，记这些开覆盖的对应的 $U$ 的交为 $BB_y$，它是与 $A$ 不交的开集\
      不难发现 $X - A = union.big_(y in - A) BB_y$ 是开集，因此结论成立
    ]
    #theorem[][
      紧致空间到 Hausdoff 的可逆连续映射一定是同胚
    ]
    #proposition[][
      $X$ Hausdoff, $A, B$ 紧致且不相交，则它们有不相交的开邻域
    ]
  == 连通性
    #definition[连通][
      称 $X$ 是连通的，如果它不能写成不交的非空开子集之并
    ]
    #theorem[][
      设 $X$ 可被若干连通子集 $A_i$ 覆盖，且 $sect.big A_i$ 非空，则 $X$ 连通
    ]<连通判别法>
    #proof[
      反证法，假设 $X = U_1 union U_2$，其中 $U_1, U_2$ 是开集。\
      由于 $sect.big A_i$ 非空，不妨设 $sect.big A_i subset U_1$，则 $U_2$ 与 $sect.big A_i$ 不交，
    ]
    #theorem[][
      $X$ 是连通的当且仅当其中既闭又开的集合只有空间和全集
    ]
    #definition[道路/道路连通][
      - 称 $[0, 1] -> X$ 的连续映射为一条道路，$f(0)$ 为起点，$f(1)$ 为终点。显然首尾相接的道路可以连接起来，称其为 $f, g$ 的衔接 $f . g$（先走 $g$ 再走 $f$）
      - 称 $X$ 道路连通，若对任何两点 $x, y in X$，存在 $x -> y$ 的道路
    ]
    #proposition[][
      道路连通的空间连通
    ]
    #proof[
      由 @连通判别法，任取 $x_0 in X$，对所有 $y$ 构造 $U_y$ 为 $x -> y$ 的道路 $f$ 对应的 $f([0, 1])$\
      显然 $U_y$ 满足定理条件，因此结论成立。
    ]
    #theorem[][
      欧式空间的连通开集是道路连通的
    ]
    #proof[
      设 $U$ 是欧式空间的连通开集，$U'$ 是其中道路连通的子集。显然它不是空集，我们希望证明它既是开集也是闭集，因此是全集。
      - 首先证明 $U'$ 是开集。事实上，取 $x$ 是其中一个点，取一个小开球 $B$ 使得 $B subset U$。断言 $U' union B$ 也是道路连通的，这是因为 $B$ 之中，$U'$ 之中的两点都是互相道路连通的，而对于各自两点，总可找到各自到 $x$ 道路，将它们连接起来即可。
      - 再证明它是闭集。设 $y in U$ 是 $U'$ 的聚点，同样取 $y$ 的小开球 $B$ 使得 $B subset Y$，显然其中存在 $U'$ 中的点 $z_0$，将 $y -> z_0$ 道路与 $z_0 -> x$ 道路复合即得 $y -> x$ 道路，因此 $y in U'$，结论成立。
      这就表明 $U'$ 既开又闭，因此是全集。
    ]
    #example[][
      设 $X = {(0, y) | -1 <= y<= 1}, U = {(x, sin 1/x) | 0 < x <= 1}$，则 $X union U$ 是连通集但不道路连通 
    ]
  == 粘合空间
    #definition[][
      设 $X$ 是拓扑空间，$P$ 是其不交划分。构造拓扑空间：
      $
      Y = P
      $
      显然存在满映射 $pi: X -> Y$\
      取使得 $f$ 连续的最大拓扑，也即 $O subset Y$ 是开集当且仅当 $Inv(pi)(O) = union.big O$ 是开集。\
      或者将 $Y$ 视作某个等价关系下的等价类，结果是相同的。\
      这个拓扑称为粘合拓扑或者商拓扑，空间称为商空间
    ]
    #theorem[][
      设 $Y$ 是商空间，$pi : X -> Y$ 是自然映射，$f: Y -> Z$ 是到拓扑空间 $Z$ 的映射，则：
      $
      f "连续" <=> f compose pi "连续"
      $
    ]
    事实上，这也唯一刻画的商拓扑的性质，作为推论，商映射的复合仍是商映射
    #theorem[][
      划分的加细可以诱导出商空间上的商空间，而这个空间在同构意义下与划分的顺序无关。事实上，这就是第三同构定理
    ]
    #definition[][
      设 $f$ 连续
      - 若 $f$ 保持开集，则称其为开映射
      - 若 $f$ 保持闭集，则称其为闭映射
      容易验证开/闭映射的复合仍然是开/闭映射，它们都是商映射，但反之未必
    ]
    #theorem[][
      紧致空间到 Hausdoff 的连续满射必为商映射
    ]
    期末考试：1月12日 8:30 - 10:30，理教 206
    答疑：1月 2, 4, 9, 11 智华楼473



