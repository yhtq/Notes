#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition, der, partialDer
#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "常微分方程",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 前言
  - 教师：李伟固
  - 作业：王子康 2301110026\@stu.pku.edu.cn，单周周三前交
  含有单个未知函数的方程称为常微分方程，往往形如：
  $
  f(x, y， y', y'', ..., y^((n))) = 0
  $
  其中 $n$ 为方程的阶数，它的位置类似于代数方程中的次数。当然阶数更高的方程更加复杂。

  若 $f(x, y， y', y'', ..., y^((n))) = 0$ 中的 $f$ 是除去 $x$ 的多元线性函数（每个变量的次数都是1），则称为线性微分方程，否则称为非线性微分方程。线性微分方程的形式为：
  $
  sum_(i=0)^n a_i (x) y^((i)) = 0
  $
  这类方程有比较完善的理论。

  + 通解与特解

    形式上，定义若 $y=h(x)$ 代入 $f(x, y， y', y'', ..., y^((n))) = 0$ 是恒等式，则称 $y=h(x)$ 是方程的解。许多时候研究解的存在性与唯一性已经足够困难了。

    称微分方程的通解为含有 $n$ 个独立常数的解，对常数任意取值都可以获得一个解。相对的，称没有未定常数的解为特解，它就是某个固定的函数。一般而言，$n$ 阶的微分方程大约有 $n$ 阶的通解，通解包含了大多数的解，但很多时候并不是所有的解。

    #example[][
      微分方程 $y' = y^(1/3)$ 的一个通解为：
      $
      cases((2/3 x + C)^(3/2) quad 2/3x + C >0,
      0 quad 2/3x + C <= 0)
      $
      但 $y = 0$ 显然是一个解，并不能被通解包含。
    ]

  + 初值问题（柯西问题）

    往往给定一个初值条件便可在通解中减少一个自由变元。当给定足够的初值时以及合理的条件时，微分方程便有唯一解。以后我们会研究在何种条件下它确实有解/有唯一解。
  + 定性问题

    自然的，解微分方程是非常复杂的，简单易用的初等解法非常有限，且往往只能解一些特殊的方程。大部分微分方程相关的研究都是在避免解出具体的解的情况下进行的，例如直接通过方程本身分析它是否有周期解，有界解等等，或者通过方程大致描述解对应曲线的形状。
  类似 $f(x) + f'(x-1) = 0$ 的微分方程有时称为时滞微分方程，它与常微分方程的研究方法大不相同。
= 常微分方程初等解法
  尽管可以证明，绝大多数常微分方程没有初等解，更不可能被初等方法解出，但这些解法仍然十分重要。
  == 恰当形式与积分因子
    #definition[对称形式][
      若 $y$ 是关于 $x$ 的函数，则一阶常微分方程均可化简为：
      $
      der(y, x) = f(x, y)
      $

      形式上与 $f(x, y) dif x - dif y = 0$相当。严格来说这不是微分方程，但是它使用颇为方便，而且可以写成对称的形式：
      $
      p(x, y) dif x + q(x, y) dif y = 0
      $<proper>
      从而统一研究了 $x, y$ 作为自变量的形式，因此也将@proper 称为微分方程的对称形式。
    ]
    #definition[恰当形式][
      若存在一个可微函数 $u(x, y)$ 使得：
      $
      dif u = p(x, y) dif x + q(x, y) dif y\
      <=> cases(
      partialDer(u, x) = p(x, y),
      partialDer(u, y) = q(x, y)
      )
      $
      则称@proper 为恰当形式。
    ]
    #theorem[][
      设：
      $
      d u(x, y) = p(x, y) dif x + q(x, y) dif y
      $
      则 $u(x, y) = C$ 产生的可微隐函数为@proper 的通解
    ]
    #proof[
      只证明 $x$ 作为自变量的情形。设：
      $
      u(x, y(x)) = c
      $
      求导立得：
      $
      partialDer(u, x) + partialDer(u, y) der(y, x) = 0\
      p(x, y) + q(x, y) der(y, x) = 0
      $
      这就表明 $y(x)$ 是原方程的解
    ]
    这启示我们，形式上我们确实可以将 $der(y, x)$ 视作分式进行处理
    #theorem[][
      设 $p, q$ 在区域 $D$ 上 $C^1$ 且
      $
      p(x, y) dif x + q(x, y) dif y
      $
      恰当，则：
      $
      partialDer(p, y) = partialDer(q, x)
      $
      若 $D$ 是单连通区域，则反之也成立
    ]
    #proof[
      - 设 $dif u = p(x, y) dif x + q(x, y) dif y$，则：
        $
        partialDer(p, y) = partialDer(partialDer(u, x), y) = partialDer(partialDer(u, y), x) = partialDer(q, x)
        $
        （注意到 $u$ 是 $C^2$ 的，因此可以交换偏导数的次序）
      - 反之若上式成立且 $D$ 单连通，这就是格林公式的直接推论，取（与道路无关的）曲线积分：
        $
        u(x, y) = integral_(x_0, y_0)^(x, y) p(x, y) dif x + q(x, y) dif y
        $
        容易验证 $u$ 满足要求
    ]
    #example[][
      $
      (3x^2 + 6 x y^2) dif x + (6 x^2 y + 4 y^3) dif y = 0
      $
      可以验证这是恰当形式，下面我们具体求出 $u$
      - 由于 $partialDer(u, x) = 3x^2 + 6 x y^2$，可得：
        $
        u = integral (3x^2 + 6 x y^2) dif x = x^3 + 3 x^2 y^2 + C(y)
        $
      - 进一步
        $
        partialDer(u, y) = 6 x^2 y + C'(y) = 6 x^2 y + 4 y^3 => C'(y) = 4 y^3 => C(y) =  y^4 + C_1
        $
      - 因此 $u = x^3 + 3 x^2 y^2 + y^4 + C_1$，这就是通解
    ]
    #example[][
      $
      (x^2 + 2 x y - y^2) dif x + (x^2 - 2 x y - y^2) dif y = 0\
      dif (1/3 x^3 - 1/3 y^3) + 2x y dif x + x^2 dif y - (y^2 dif x + 2 x y dif y) = 0\
      dif (1/3 x^3 - 1/3 y^3) + dif (x^2 y) - dif (y^2 x) = 0\
      dif (1/3 x^3 - 1/3 y^3 + x^2 y - y^2 x) = 0
      $
    ]
    一旦微分方程的形式恰当，解出微分方程是十分容易的。然而事实上，一个微分方程可能对应众多的对称形式。设 $f(x, y) !=0$，则：
    $
    p(x, y) dif x + q(x, y) dif y = 0 <=> p(x, y) f(x, y) dif x + q(x, y) f(x, y) dif y = 0
    $
    选取不同的 $f(x, y)$ 可能改变对称形式的恰当性
    #definition[][
      设非零可微函数 $f(x, y)$ 满足：
      $
      p(x, y) f(x, y) dif x + q(x, y) f(x, y) dif y = 0
      $
      则称 $f(x, y)$ 为@proper 的积分因子
    ]
    #example[][
      $
      y dif x - x dif y = 0
      $
      并不是恰当形式，但：
      $
      mu = 1/x^2, 1/y^2, ...
      $
      都是其积分因子\
      事实上：
      $
      dif(y/x) = 1/x dif y - y/x^2 dif x = 1/x^2 (y dif x - x dif y) = 0
      $
    ]
    我们当然希望对一般的对称形式找到合适的积分因子，具体而言，是要求：
    $
    partialDer(p f, y) = partialDer(q f, x) <=>\
    f (partialDer(p, y) - partialDer(q, x)) = q partialDer(f, x) - p partialDer(f, y)
    $<int_factor>
    这是一个一阶线性偏微分方程，不幸的是该类偏微分方程的通用解法只能归结于求解反推过程的常微分方程，因此一般的积分因子是没有通用的解法的。所幸，在一些特殊情形下，我们是可以求得积分因子的。我们直接对 $f$ 施加额外条件：
    - $f$ 与 $y$ 无关，原方程变为：
      $
      f partialDer(p, y) = f partialDer(q, x) + q partialDer(f, x) 
      $<ori_res>
      这是常微分方程：
      $
      partialDer(f, x) =f (partialDer(p, y) - partialDer(q, x)) / q
      $
      观察可得 $(partialDer(p, y) - partialDer(q, x)) / q$ 应与 $y$ 无关。同时此时我们只需解 $f$，$y$ 可以视作定值，因此上述方程可以化简为：
      $
      (dif f) / f = (partialDer(p, y) - partialDer(q, x)) / q dif x\
      ln |f| = integral (partialDer(p, y) - partialDer(q, x)) / q dif x + C
      $<res>
      由于 $f$ 是非零的，因此 $f$ 的符号是确定的，这就解出了 $f$\
      不难发现只要 $(partialDer(p, y) - partialDer(q, x)) / q$ 与 $y$ 无关，@res 便可给出一个与 $y$ 无关的 $f$ 满足@ori_res，进而代入@int_factor 应当也成立。这表明 $(partialDer(p, y) - partialDer(q, x)) / q$ 与 $y$ 无关是可以找到此形式的积分因子的充要条件。
    #theorem[一阶线性微分方程][
      一阶线性微分方程：
      $
      y' = p(x) y + q(x)
      $
      的对称形式为：
      $
      (p(x) y + q(x)) dif x - dif y = 0
      $
      计算:
      $
      (partialDer(p(x) y + q(x), y) - partialDer(1, x)) / (-1) = - p(x)
      $
      积分因子 $f$ 满足：
      $
      ln |f| = integral - p(x) dif x + C\
      |f| = e^C e^(-integral p(x) dif x) = A e^(-integral p(x) dif x)
      $
      因此取 $f = e^(-integral p(x) dif x)$  即可，进而原方程可解
    ]
    不幸的是，这样能够找到的积分因子仍然非常有限。实践上寻找积分因子更多只能靠直接观察形式
    #example[][
      寻找一个曲线使得从定点 $(c, 0)$ 射出的光线经曲线反射后与 $x$ 轴平行：
      - 通过几何方法可以列出方程 $y/x = (2y)/(1-y'^2)$
      - 不妨设 $y' > 0, y> 0$，解得：
        $
        y' = - x /y + sqrt(1 + (x/y)^2)\
        y dif y = (sqrt(x^2 + y^2)-x)dif x\
        x dif x + y dif y = sqrt(x^2 + y^2) dif x\
        (x dif x + y dif y)/sqrt(x^2 + y^2) = dif x\
        dif(sqrt(x^2 + y^2)) = dif x\
        sqrt(x^2 + y^2) = x + C
        $
      - 平方可得方程为：
        $
        y^2 = 2 x C + C^2 = 2C(x+1/2C)
        $
    ]
    #theorem[][
      假设 $p, q, f, g in C^1$，$f, g$ 都是对称形式：
      $
      0 = p(x, y) dif x + q(x, y) dif y := w
      $ 
      的积分因子，且 $f/g$ 不是常数，则 $f/g = C$ 是原方程的通解，其中 $C$ 为常数
    ]
    #proof[
      设：
      $
      f w = d u_1\
      g w = d u_2
      $
      不妨设 $partialDer(u_2, y) !=0$，则由隐函数定义， $u_2 = C$ 可以解出 $y = y(x)$，此时有：
      $
      0 = der(u_1(x, y(x)) w(x, y(x)), x)\
      = w(x, y)der(u_1(x, y(x)), x) + u_1(x, y)der(w(x, y(x)), x)\
      = w(x, y) 
      $
    ]
    理论上讲，所有常微分方程的初等解法都可以化为恰当方程。但是实践上我们更多采用具体的方法求解。
  == 分离变量法
    #theorem[分离变量法][
      设微分方程形如：
      $
      der(y, x) = f(x)g(y)
      $
      - 若 $g(y) = 0$，则 $f(x) = C$ 就是原方程的解
      - 否则，化为：
        $
        1/g(y) der(y, x) = f(x)
        $
        设 $G(y) = integral 1/(g(y)) dif y$，则:
        $
        G'(y) = 1/g(y) der(y, x) = f(x) => G(y) = integral f(x) dif x + C
        $
    ]
    #example[][
      求解 $der(y, x) = y^2 cos x$:
      - 首先 $y = 0$ 是它的一个解
      - 其次，假设 $y$ 不恒为零，则：
        $
        1/(y^2) dif y = cos x dif x\
        -1/y = sin x + C\
        y = -1/(sin x + C)
        $
    ]
    #remark[][
      这种形式下我们已经默认了 $y$ 是因变量而 $x$ 是自变量，因此不能让 $x$ 恒等于 $cos x$ 的零点。如果不考虑函数关系只考虑解曲线，则这也是一个特殊的解
    ]
    #example[][
      $der(y, x) = y^(1/3)$:
      - $y = 0$ 当然是解
      - 否则，我们先证明若 $y(x_0) = 0$，则当 $x < x_0$ 时 $y = 0$：
        - 否则，假设 $x_1 < x_0, f(x_1) !=0$，不妨设其大于零。取：
          $
          x_2 = inf(Inv(y)(0) sect [x_1, x_0])
          $
          注意到上式右侧是闭集，因此 $y(x_2) = 0 => der(y, x) |_(x = x_2)= 0$\
          此外，$der(y, x)$ 在 $[x_1, x_2]$ 之间恒正，这意味着 $y(x)$ 在 $[x_1, x_2]$ 之间单调递增，矛盾！
        - 之后，我们分离变量
          $
          1/y^(1/3) dif y = dif x\
          3/2 y^(2/3) = x + C\
          y = plus.minus (2/3 x + C)^(3/2)
          $
        - 综上，原方程的通解为：
          $
          y = cases((2/3 x + C)^(3/2) quad 2/3x + C >0,
          0 quad 2/3x + C <= 0)
          $
    ]
    #example[][
      下面是几种常见形式
      +  $der(y, x) = f(x)y$
        - $y = 0$ 当然是解
        - 否则：
          $
          1/y dif y = f(x) dif x\
          ln |y| = integral f(x) dif x + C\
          y = A e^(integral f(x) dif x)
          $
          事实上，可以证明若 $y(x_0) = 0$，则 $y = 0$，因此可以去掉绝对值 
      + $der(y, x) = g(y/x)$\
        令 $y = x u$，方程化为：
        $
        der(y, x) = u + x der(u, x) = g(u)\
        1/(g(u) - u) dif u = 1/x dif x\
        integral 1/(g(u) - u) dif u = ln |x| + C\
        $
      + $der(y, x) = (a_1 x + b_1 y + c_1)/(a_2 x + b_2 y + c_2)$\
        - 若 $c_1 = c_2 = 0$，上下同时除以 $x$ 即化为上一种情形
        - 否则，试图做线性替换：
          设 $A = mat(a_1, b_1;a_2, b_2), alpha = vec(c_1,c_2)$
          $
          vec(x, y) = B vec(x', y') + beta
          $
          我们希望：
          $
          A vec(x, y) + alpha = A(B vec(x', y') + beta) + alpha = A B vec(x', y')
          $
          也就是：
          $
          A beta + alpha = 0
          $
          该线性方程有解时，一定可以通过线性替换化为上一种情形\
          - 否则 $"rank"(A) = 1$，不妨设 $(a_2, b_2) = k (a_1, b_1)$，令：
            $
            u = a_1 x + b_1 y
            $
            原方程化为：
            $
            der(u, x) = a_1 + b_1 der(y, x) = a_1 + b_1 (u + c_1)/(k u + c_2)
            $
            这时右侧已无 $x$，直接分离变量积分即可
      + $y f(x y) dif x + x g(x y) dif y = 0$\
        令 $x y = u$，方程化为：
        $
        u/x f(u) dif x + g(u)(dif u - u/x dif x) = 0\
        $
        这也是分离变量的形式
    ]
    #example[最速降线][
      求 $a -> b$ 的一条曲线，使得小球从 $a$ 无摩擦的滑下的时间最短\
      严格来说这个问题需要用到变分法，不过抛开高级理论，利用光线折射定律的相关想法也可以不严格的求解。\
      可以证明，光线从 $a$ 点到 $b$ 点经过若干种介质时，入射角的正弦与介质中传播的速度是定值。我们依次来对曲线建立微分方程：
      - 在曲线上任意一点 $(x, y)$ 的速度表示为：
        $
        v = sqrt(2 g y)
        $
        （能量守恒）
      - “入射角”也即与垂直方向夹角满足 $sin alpha = sqrt(1+y'^2)$
      因此可以建立方程：
        $
        sqrt(2 g y)/ sqrt(1+y'^2) = C\
        2 g y = C^2 (1+y'^2)\
        1 + y'^2 = 2/C^2 g y\
        y' = sqrt(2/C^2 g y - 1)\
        1/sqrt(2/C^2 g y - 1) dif y = dif x\
        integral 1/sqrt(2/C^2 g y - 1) dif y = x + C\
        $
    ]
  == 一阶线性微分方程
    #theorem[常数变易法][
      对于一阶线性微分方程：
      $
      der(y, x) + p(x) y = q(x)
      $
      一般假设 $p, q$ 都连续且 $p(x)$ 不恒为零
      我们可以先解出齐次方程：
      $
      der(y, x) + p(x) y = 0
      $
      它的解为：
      $
      y = C e^(-integral p(x) dif x) := C v(x)
      $
      做变量替换：
      $
      y = u(x) v(x)
      $
      代入发现：
      $
      q(x) - p(x) u(x) v(x) = der(u(x) v(x), x) = v(x) der(u(x), x) + u(x) der(v(x), x)
      $
      但是注意到：
      $
      der(v(x), x) + p(x) v(x) = 0
      $
      上式化简为：
      $
      q(x) = v(x) der(u(x), x)\
      $
      待解的函数是 $u(x)$，这是可分离变量的
    ]
    #example[贝努利方程][
       形如：
       $
       der(y, x) = p(x) y + q(x) y^n
       $
       的方程称为贝努利方程。除去 $y = 0$ 的解外，可以做变量替换：
       $
       t = y^(1-n)\
       dif t = -(1-n) y^(-n) dif y\
       dif y = -1/(1-n) y^(n) dif t\
       $
       上式化简为：
        $
        y^(-n)der(y, x) = p(x) y^(-n+1) + q(x)\
        -1/(1-n) der(t, x) = p(x) t  + q(x)\ 
        $
         这就化为了一阶线性微分方程
    ]
    #example[][
      对于形如：
      $
      der(y, x) = p(x)y^2+q(x)y+r(x)
      $
      的微分方程，一般没有初等解法。但是假设我们猜出了一个解 $y = f(x)$，可以做变量替换：
      $
      y = u + f(x)\
      dif y = dif u + f'(x) dif x\
      $
      代入原方程后，仍然是该方程的形式。然而注意到 $u = 0$ 一定是一个解，最后一定会消掉零次项。代入发现：
      $
      dif u + f'(x) dif x = (p(x)(u+f(x))^2+q(x)(u+f(x))+r(x))dif x\
      dif u = (p(x)(u^2 + 2u f(x)) + q(x) u ) dif x\
      der(u, x) = p(x)u^2 + (2 p(x) f(x) + q(x))u
      $
      这是贝努利方程，进而可解
    ]
    #theorem[][
      设 $a, b in RR, a != 0$，方程：
      $
      der(y, x) = a y^2 + b x^m
      $
      当且仅当 $m = 0, - 2, - (4k)/(2k plus.minus 1)$ 时可积分求解
    ]
    #proof[
      无妨假设 $a = 1$\
      - $m = 0$ 时显然可解
      - $m = -2$ 时，做变量替换：
        $
        z = x y\
        dif z = x dif y + y dif x\
        dif y = 1/x dif z - y/x dif x\
        $
        代入得：
        $
        1/x dif z - y/x dif x = (y^2 + b x^(-2)) dif x\
        x dif z - x y dif x = ((x y)^2 + b) dif x\
        x dif z -z dif x = (z^2 + b) dif x
        $
        这是可分离变量的
      - $m = -(4k)/(2k plus.minus 1)$ 

      必要性由刘维尔给出，颇为复杂
    ]
    特别的，$der(y, x) = x^2 + y^2$ 是不可积分求解的，这也说明了求解微分方程是非常之困难的。
  == 一阶隐方程
    #definition[][
      形如：
      $
      F(x, y, y') = 0
      $
      的方程称为一阶隐方程
    ]
    一般而言它的求解当然是非常困难的，但是对于特定的几类，我们可以尝试求解：
    #theorem[][
      对于以下几类隐方程我们给出一些思路：
      - 可以化为：
        $
        y = f(x, y')
        $<ori>
        的方程。\
        此时两边对 $x$ 求导得：
        $
        y' = partialDer(f(x, y'), x) = f'_1(x, y') + f'_2(x, y')y''
        $
        这是关于 $y', x$ 的显式微分方程。\
        若能解出 $y' = p(x)$，代入@ori 就是原方程的解\
        若只能解出 $x = q(y')$，代入@ori 就是原方程以 $y'$ 为参数的参数表达\
        否则，若只能解出 $g(x, y') = 0$，方程的解只能表达为：
        $
        cases(
          y = f(x, y'),
          g(x, y') = 0 
        )
        $
      - 可以化为：
        $
        x = f(y, y')
        $
        两边对 $y$ 求导得：
        $
        1/y' = partialDer(f(y, y'), y) = f'_1(y, y') + f'_2(y, y')der(y', y) = f'_1(y, y') + f'_2(y, y') y''/y'
        $
        做类似讨论即可
      - 可以化为 $f(x, y') = 0$，只需要考虑它的参数形式：
        $
        x = u(t)\
        y' = v(t)
        $
        则：
        $
        dif y = v(t) dif x = v(t) u'(t) dif t
        $
        两边积分即得 $y$
      - 可以化为 $f(y, y') = 0$ 的形式。类似的，如果能找到参数方程：
        $
        y = u(t)\
        y' = v(t)
        $
        则：
        $
        dif y = u'(t) dif t\
        dif y = v(t) dif x\
        v(t) dif x = u'(t) dif t\
        dif x = (u'(t))/v(t) dif t
        $
        积分即可\
        注意需要补充 $v(t) = 0$ 的解
    ]
    #example[][
      $y'^3+2x y' - y = 0$
      两边直接对 $y$ 求导得：
      $
      3y'^2 y''  + 2y'+ 2x y'' - y' = 0\
      (3y'^2 + 2x)y'' = -y'\
      (3P^2 + 2x)P' = -P\
      der(P, x) =- P/(3P^2+2x)\
      2P der(P, x) = -(2P^2)/(3P^2+2x)\
      der(P^2, x) = -(2P^2)/(3P^2+2x)\
      $
      这是方程右侧对于 $P^2$ 是齐一次的，是我们可解的方程\
      $
      der(x, P^2) = -3/2 - x/P^2
      $
      令 $u = x/P^2, dif u = (P^2 dif x - x dif P^2)/P^4$
      $
      der(u, P^2) = 1/P^2 der(x, P^2) - u/P^2 = -1/P^2(3/2+u) -u/P^2\
      (dif u)/(3/2 + 2u) = - 1/P^2 dif P^2\
      ln |3/2 + 2u| = - ln 1/P^2 + C\
      3/2 + 2u = C P^2\
      $
    ]
    #example[Clairaut][
      $y = x y' + f(y')$\
      求导得:
      $
      y' = y' + x y'' + f'(y') y''\
      x y'' + f'(y') y'' = 0\
      $
      讨论：
      - $y'' = 0$，此时原方程是一族直线 $y = x c + f(c)$
      - $x = - f'(y')$，此时代回得 $y = - y' f'(y') + f(y')$，这是以 $y'$ 为参数的特解
      当 $f'' != 0$ 时，直线族恰好是特解的切线族，这是因为此时 $f'$ 有反函数，在特解中可以解出：
      $
      y' = u(x)\
      y = x u(x) + f(u(x))
      $
      此时，直线：
      $
      y = x u(x_0) + f(u(x_0))
      $
      恰好就是特解于 $(x_0, y_0)$ 点的切线（显然直线过 $(x_0, y_0)$ 且斜率 $u(x)$ 当然就是该点处的导数）

      事实上，我们并没有说明这些就是原方程的所有解。后续我们会证明在 $f'' != 0$ 的情况下，确实这些囊括了原方程解的所有情况（但可以构造出其他的解，例如将切线-特解-切线拼接起来也是一个解）
    ]
    == 应用举例
      至此，我们已经给出了所有一阶微分方程的初等解法。尽管方法有限，但是它们已经能够解出了许多重要的方程
      #example[两个物种的生态方程][
        一战期间，生态学家发现随着人类捕鱼量下降，两类鱼中以其他鱼为食的鱼的比例上升，而以植物为食的鱼的比例下降。他们提出了一个模型：\
        设以鱼为食的鱼的数量为 $x = x(t)$, 以植物为食的鱼的数量为 $y = y(t)$，令 $r_x, r_y$ 是两者的增长率。显然 $r_x$ 应该随 $y$ 递增，而当 $y$ 较小时应该有 $r_x < 0$，进而设：
        $
        r_x = sigma y - lambda
        $
        类似的原因，设：
        $
        r_y = mu - delta x
        $
        （上面的常数应该都是正数）\
        这给出了微分方程组：
        $
        x'/x = sigma y - lambda\
        y'/y = mu - delta x
        $
        两式相比：
        $
        y'/x' x/y = (mu - delta x)/(sigma y - lambda)
        $
        注意到 $y'/x' = der(y, x)$，这就消掉了 $t$
        $
        y' (sigma y - lambda)/y = (mu - delta x)/x\
        sigma y - lambda ln y = mu ln x - delta x + C\
        sigma y + delta x - lambda ln y - mu ln x = C\
        $
        虽然我们难以继续计算，但我们可以做定性研究，可以发现它的解都是周期解。\
        同时，我们还可以求出平均值：
        $
        (dif x)/x = (-lambda + sigma y) dif t\
        integral_T (dif x)/x = integral_T  (-lambda + sigma y) dif t\
        integral_T (dif ln(x)) = integral_T  (-lambda + sigma y) dif t\
        0 = integral_T  (-lambda + sigma y) dif t\
        0 = -lambda T + sigma integral_T y dif t\
        (lambda)/sigma =  1/T integral_T y dif t
        $
        这就是 $y$ 在一个周期内的平均值\
        当捕捞量减少时，两个物种的增长率都增加，相当于 $mu$ 增大而 $lambda$ 减少，可以看到 $x$ 的平均值会增加，而 $y$ 的平均值会减少
      ]
      #example[$n$ 体问题][
        $n$ 体问题是指万有引力下 $n$ 个大质量质点相互作用的问题。设有 $n$ 个质点 $p_i$，分别有：
        - 坐标 $P_i = (x_i, y_i, z_i)$
        - 质量 $m_i$
        - 牛顿第二定律和万有引力定律：
          $
          m_i (dif^2 P_i)/(dif t^2) = sum_(j != i) G m_i m_j (P_j - P_i)/norm(P_j - P_i)^3
          $
        不妨设 $G = 1$，化简为：
        $
        m_i (dif^2 P_i)/(dif t^2) = sum_(j != i) G m_i m_j (P_j - P_i)/(sqrt((x_i - x_j)^2 + (y_i - y_j)^2 + (z_i - z_j)^2)^3)
        $
        记 $U = sum_(i != j)( m_i m_j )/norm(P_i -P_j)$，化简为：
        $
        m_i (dif^2 P_i)/(dif t^2)  = partialDer(U, P_i)
        $
        记 $q_i = der(P_i, t)$（速度），则：
        $
        m_i der(q_i, t) =  partialDer(U, P_i)
        $
        令 $p = autoVecN(p, n), q = autoVecN(q, n)$，则：
        $
        dif /(dif t) vec(p, q) = vec(q, m partialDer(U, p))
        $
        可以发现：
        $
        sum_i m_i der(q_i, t) = sum_i partialDer(U, q_i) = sum_i (sum_(j != i) m_i m_j (P_i - P_j)/norm(P_i - P_j)^3) = 0
        $
        这就是在说质心不动，也就是动量守恒，进而：
        $
        sum_i m_i q_i = C_1\
        integral sum_i m_i q_i dif t = C_1 t + C_2\
        sum_i m_i p_i =  C_1 t + C_2
        $
        质心以匀速直线运动

        类似的，可以验证角动量守恒，能量守恒\
        然而可以证明，除了这些以外不再有与之独立的代数的首次积分，因此代数的首次积分就是这些

        接下来我们解二体问题，由之前提到的守恒量可设质心恒定在原点，运动都在平面上，可以化简到：
        $
        cases(
          (dif^2 x)/(dif t^2) = -m x/(x^2 + y^2)^(3/2),
          (dif^2 y)/(dif t^2) = -m y/(x^2 + y^2)^(3/2)
        )
        $
        其中，1 对应 $ m = (m_2^3)/(m_1 + m_2)^2 $
        2 对应 $ m = (m_1^3)/(m_1 + m_2)^2 $
        角动量守恒给出：
        $
        x der(y, t) - y der(x, t) = c_1\
        $
        能量守恒给出：
        $
        (der(x, t))^2 + (der(y, t))^2 - (2m)/(sqrt(x^2 + y^2)) = c_2
        $
        做极坐标换元：
        $
        x = r cos theta\
        y = r sin theta
        $
        代入角动量守恒化简得：
        $
        c_1 = r^2 der(theta, t)\
        c_1 (t_2 - t_1) = integral_(t_1)^(t_2) r^2 dif theta\
        $
        上式右侧是扫过的扇形面积，这实际上就是开普勒第二定律\
        代入能量守恒化简得：
        $
        (der(r, t))^2 = c_1 + 2 m Inv(r) - c_1^2 r^(-2) \
        der(r, t) = sqrt(c_2 + m^2/c_1^2 - (c_1/r - m/c_1)^2)\
        der(theta, t) = c_1/r^2\
        der(r, theta) = r^2/c_1 sqrt(c_2 + m^2/c_1^2 - sqrt(c_1/r - m/c_1)^2)
        $
        这是可分离变量的，最终可以化简得到：
        $
        r = p/(1 + e cos (theta - theta_0))
        $
        其中 $e = c_1/m sqrt(c_2 + m^2/c_1^2), p = c_1^2/m$\
        这一定是一条圆锥曲线，这就是开普勒第一定律\
        再次带回：
        $
        (p/(1 + e cos (theta - theta_0)))^2 dif theta = c_1 dif t\
        c_1 T = integral_(0)^(2pi) p^2/(1 + e cos (theta - theta_0))^2 dif theta\
        = (2p^2 pi)/sqrt((1 - e^2)^3)
        $
        计算可得：
        $
        T^2/(p^3 /(1-e^2)^3) = (4 pi^2)/m
        $
        当 $m_1$ 很大时，$m$ 几乎就是 $m_2$，这也就是太阳系中的开普勒第三定律

        二体问题还有著名的反问题，假设任何星球围绕太阳的有界轨道都是椭圆，且万有引力形如：
        $
        f = m_1 m_2 f(norm(p_1 - p_2))(p_1 - p_2)
        $
        那么数学上可以证明万有引力只能是正比于距离或者反比于距离的平方，前者会导致太阳位于轨道中心，后者太阳将位于焦点
      ]
  == 二阶自洽微分方程
    #theorem[二阶自洽微分方程的解法][
      称形如 
        $
        (dif^2 x)/(dif t^2) + f(x) = 0
        $
        为二阶自洽方程，引进 $F(x)$ 使得 $F'(x) = f(x)$，令 $y = f'(x), H(x, y) = y^2/2 + F(x)$，有：
        $
        der(H, t) = y der(y, t) + F'(x) der(x, t) = y (dif^2 x)/(dif t^2) + f(x) der(x, t) = 0 
        $
        换言之，参数方程 $(x(t), y(t))$ 表示的函数就是 $H$ 的等高线，可以解得：
        $
        y = plus.minus sqrt(2(C - F(x)))\
        (dif x)/(dif t) = plus.minus sqrt(2(C - F(x)))\
        plus.minus 1/(sqrt(2(C - F(x)))) dif x = dif t
        $
        两边直接积分及得原方程的解
    ]
    #example[弹簧][
      弹簧方程 $(dif^2 x)/(dif t^2) + a x = 0, a > 0$ 就是上面的形式，因此可以解得：
      $
      t + C' = plus.minus integral 1/sqrt(2(C - 1/2 a x^2)) dif x
      $
      计算化简得到 
      $
      x = C_1 cos a t + C_2 sin a t\
      y = - a C_1 sin a t + a C_2 cos a t
      $
      容易发现所有解都以 $(2 pi)/a$ 为周期，且 $(0, 0)$ 为所有轨道的中心。由于所有轨道都是相同周期的，因此也称为等时中心。线性系统中一定是等时的
    ]
    #example[单摆方程][
      单摆方程 $(dif^2 x)/(dif t^2) + a sin x = 0, a > 0$ 也是上面的形式，因此可以解得：
      $
      dif t  =  1/sqrt(2(C - a cos x)) dif x
      $
      这是椭圆积分，我们无法写出它的初等形式\
      转而考虑：
      $
      H(x, y) = y^2/2 - a cos x + a
      $
      的等高线。注意到 $H$ 关于 $x$ 以 $2 pi$ 为周期，可以把它想象成定义在圆柱面上的函数。容易发现这里 $(0, 0)$ 也是中心，但不是等时中心，事实上，在等高线：
      $
      y^2 - a cos x = C
      $
      上，有：
      $
      1/4 T = integral_0^(pi/2) der(t, x) dif x = integral_0^(pi/2)  1/sqrt(2(C - a cos x)) dif x
      $
      显然不可能与 $C$ 无关
    ]
    #theorem[][
      设二阶自洽微分方程满足 $f(x)$ 连续且 $x f(x) > 0$，引进 $F(x)$ 并不妨设 $F(0) = 0$，则对：
      $
      H(x, y) = y^2/2 + F(x)
      $
      + $H(0, 0)$ 是 $H$ 的最小值点
      + 在 $(0, 0)$ 附近，$H(x, y) = C$ 给出一个闭合曲线
      + $H = h$ 交 $x$ 轴于 $x_1(h), x_2(h)$ 两点，$x_1 < x_2$
      + 原点是等时中心当且仅当 $(x_2(h) - x_1(h))/sqrt(h)$ 是与 $h$ 无关的常数
    ]
    #proof[
      + 由题设将有 $F(x) >= 0$ 因此显然
      + 直接解出 $y$ 即可
      + 由 $F(x)$ 的单调性及 $F(0) = 0$ 显然
      + 这个证明并不用到高级的知识，但极具技巧性\
        令 $s = F(x)$，则 $f(x) dif x = dif s$，有：
        $
        1/2 T_h = integral_(x_1)^(x_2) der(t, x) dif x = integral_(x_1)^(x_2)  1/sqrt(2(h - F(x))) dif x\
        = integral_0^(h)  1/sqrt(2(h - s)) 1/(f_+(x)) dif s - integral_0^(h)  1/sqrt(2(h - s)) 1/(f_-(x)) dif s\
        1/2 integral_0^H T_h/sqrt(H-h) dif h = integral_0^H ( integral_0^(h) 1/sqrt(2(H - h)(h - s)) 1/(f_+(x)) dif s)dif h - integral_0^H ( integral_0^(h) 1/sqrt(2(H - h) (h - s)) 1/(f_-(x)) dif s)dif h\
        = integral_0^H ( integral_s^H 1/sqrt(2(H - h)(h - s)) 1/(f_+(x)) - 1/sqrt(2(H - h) (h - s)) 1/(f_-(x)) dif h)dif s\
        = pi/(sqrt(2)) (integral_0^H 1/(f_+(x)) - 1/(f_-(x)) )dif s\
        = pi/(sqrt(2)) (integral_0^H 1/(f_+(x)) - 1/(f_-(x)) )dif F(x)\
        = pi/(sqrt(2)) (integral_0^H f(x)/(f_+(x)) - f(x)/(f_-(x)) )dif x\
        = pi/(sqrt(2)) (x_2(H) - x_1(H))\
        $
        - 假设周期与 $H$ 无关，则有：
        $
        T_0 sqrt(H) = pi/sqrt(2) (x_2(H) - x_1(H))\
        T_0 = pi/sqrt(2) (x_2(H) - x_1(H))/sqrt(H)
        $
        表明上式右侧与 $H$ 无关，这也给出了周期的计算公式
    ]
    #corollary[][
      若原点是等时中心且 $f(x)$ 是奇函数，则 $f(x)$ 一定线性
    ]
