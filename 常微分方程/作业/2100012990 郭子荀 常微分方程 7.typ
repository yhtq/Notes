#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 5.13 p190
  == 2.(1)
    先解齐次线性微分方程组：
    $
    vec(y, z)' = mat(0, 1;1, 0) vec(y, z)
    $
    设：
    $
    A := mat(0, 1;1, 0)
    $
    特征值为 $1, -1$，对应特征向量为：
    $
    xi_1 = vec(1, 1)\
    xi_(-1) = vec(1, -1)
    $
    一个基础解矩阵为：
    $
    (e^x vec(1, 1), e^(-x) vec(1, -1))
    $
    做常数变易，设：
    $
    vec(y, z) = (e^x vec(1, 1), e^(-x) vec(1, -1)) U\
    vec(y, z)' = (e^x vec(1, 1), e^(-x) vec(1, -1)) U' + (e^x vec(1, 1), e^(-x) vec(1, -1))' U\
    = mat(0, 1;1, 0) vec(y, z) + vec(2, 1)e^x\
    (e^x vec(1, 1), e^(-x) vec(1, -1)) U' = vec(2, 1)e^x\
    mat(e^x, e^(-x);e^x, -e^(-x)) U' = vec(2, 1) e^x\
    mat(e^(-x), e^(-x);e^(x), -e^(x))mat(e^x, e^(-x);e^x, -e^(-x)) U' = mat(e^(-x), e^(-x);e^(x), -e^(x)) vec(2 e^x, e^x) \
    mat(2, 0;0, 2) U' = vec(3, e^(2 x))\
    U' = vec(3/2, 1/2 e^(2 x))\
    U = vec(3/2 x, 1/4 e^(2 x) )\
    vec(y, z) = mat(e^x, e^(-x);e^x, -e^(-x)) vec(3/2 x, 1/4 e^(2 x) ) = vec(3/2 x e^x + 1/4 e^x, 3/2 x e^x - 1/4 e^x)\
    $
    这就求得一个特解，原方程的通解就是：
    $
    vec(3/2 x e^x + 1/4 e^x, 3/2 x e^x - 1/4 e^x) + (e^x vec(1, 1), e^(-x) vec(1, -1)) vec(C_1, C_2)
    $
  == 3.(1)
    先解齐次线性微分方程组：
    $
    vec(y, z)' = mat(0, 1;-1, 0) vec(y, z)
    $
    设 $A = mat(0, 1;-1, 0)$ 特征值为 $i, -i$，对应特征向量为：
    $
    xi_i = vec(1, i)\
    xi_(-i) = vec(1, -i)
    $
    一个基础解矩阵为：
    $
    (e^(i x) vec(1, i), e^(-i x) vec(1, -i)) = mat(
      cos x + i sin x, cos x -i sin x;
      i cos x - sin x, -i cos x - sin x
    )
    $
    找到两个基解：
    $
    mat(cos x, sin x; -sin x, cos x)
    $
    设非齐次方程的解：
    $
    vec(y, z) = mat(cos x, sin x; -sin x, cos x) U\
    $
    则有：
    $
    mat(cos x, sin x; -sin x, cos x) U' = vec(tan^2 x - 1, tan x)\
    mat(cos x, sin x; -sin x, cos x) mat(cos x, -sin x; sin x, cos x) U' = mat(cos x, sin x; -sin x, cos x) vec(tan^2 x - 1, tan x)\
    U' = vec((sin^2 x)/(cos x) - cos x + (sin^2 x)/(cos x), - (sin^3 x)/(cos^2 x) + sin x + sin x)\
    U = vec(arctanh(sin x) - 2 sin x,-3 cos x - 1/(cos x))\
    vec(y, z) = mat(cos x, sin x; -sin x, cos x) vec(arctanh(sin x) - 2 sin x + C_1,-3 cos x - 1/(cos x) + C_2)
    $
  == 4
    先用常数变易，设 $y = e^(A x) U$，有：
    $
    y' = A y + f(x) = A e^(A x) U + e^(A x) U' \
    f(x) = e^(A x) U'\
    U = integral e^(-A x) f(x) dif x\
    y = e^(A x) (integral_0^x e^(-A t) f(t) dif t + C)\
    $
     $y$ 以 $omega$ 为周期当且仅当：
    $
    e^(A omega) e^(A x) (integral_0^x e^(-A t) f(t) dif t + integral_x^(x + omega) e^(-A t) f(t) dif t + C) = e^(A x) (integral_0^x e^(-A t) f(t) dif t + C)\
    e^(A omega)  (integral_0^x e^(-A t) f(t) dif t + integral_x^(x + omega) e^(-A t) f(t) dif t + C) =  integral_0^x e^(-A t) f(t) dif t + C\
    (e^(A omega) - I) C = (I - e^(A omega)) integral_0^x e^(-A t) f(t) dif t - e^(A omega) integral_x^(x + omega) e^(-A t) f(t) dif t 
    $
    因此若设 $e^(A omega) - I$ 可逆，上式即可解出符合要求的 $C$，这等价于 $e^(A omega)$ 没有特征值 $1, A$ 没有特征值 $0$

    反之有 $A$ 有特征值零，也即不满秩，设 $A xi = 0$，考虑方程：
    $
    y' = A y + xi
    $ 
    不难验证 $t xi$ 是一个特解，通解为：
    $
    t xi + e^(A x) C
    $
    不难验证该方程没有以 $omega$ 为周期的解，证毕
= 5.15 p210
  == 1
    === (1)
      对应特征多项式：
      $
      lambda^2 + lambda - 2 = 0\
      (lambda + 2)(lambda - 1) = 0\
      $
      因此通解就是 $linearCombinationC(e^x, e^(-2 x))$
    === (3)
      对应特征多项式：
      $
      lambda^4 - 5 lambda^2 + 4 = 0\
      (lambda^2 - 4)(lambda^2 - 1) = 0\
      $
      四个解分别是 $2, -2, 1, -1$，因此通解是：
      $
      linearCombinationC(e^(2 x), e^(-2 x), e^x, e^(-x))
      $
    === (5)
      先解齐次方程，对应特征多项式：
      $
      lambda^2 - 4 lambda + 8 = 0\
      lambda = 2 plus.minus 2 i
      $
      两个解为 $e^(2x)(cos 2 x + i sin 2 x), e^(2 x)(cos 2 x - i sin 2 x)$，找到两个实解：
      $
      e^(2 x) cos 2 x, e^(2 x) sin 2 x
      $
      再试求特解。先求：
      $
      y'' - 2 y' + 8 y = e^(2 x)
      $
      的特解，猜测其形如 $k e^(2 x)$，代入得：
      $
      4 k - 4 k  + 8 k = 1\
      k = 1/8
      $
      因此一个特解为 $1/8 e^(2 x)$\
      再求 $y'' - 2 y' + 8 y = sin 2 x$，猜测其特解为 $s cos 2 x + t sin 2 x$，代入得：
      $
      - 4 s cos 2 x - 4 t sin 2 x - 2(2 t cos 2 x - 2 s sin 2 x) + 8(s cos 2 x + t sin 2 x) = sin 2 x\
      cases(
        8 s - 4 t - 4 s = 0,
        8 t + 4 s - 4 t = 1
      )
      $
      得 $s = t = 1/8$，特解为 $1/8 (cos 2 x + sin 2 x)$\
      综上，原方程通解为：
      $
      1/8 (cos 2 x + sin 2 x + e^(2 x)) + linearCombinationC(e^(2 x) cos 2 x, e^(2 x) sin 2 x)
      $
  == 3
    #let lc = linearCombination(name: $c$)
    #let g_s = ($e^(lambda_1 x)$, $e^(lambda_2 x)$)
    先做常数变易，设解 $y = #(linearCombination(..g_s))$，求一阶导：
    $
    y' = #(linearCombination(name : $C'$, ..g_s)) + linearCombinationC(lambda_1 e^(lambda_1 x), lambda_2 e^(lambda_2 x))
    $
    令 $#(linearCombination(name : $C'$, ..g_s)) = 0$，再求导：
    $
    y'' = #(linearCombination(name : $C'$, $lambda_1 e^(lambda_1 x)$, $lambda_2 e^(lambda_2 x)$)) + linearCombinationC(lambda_1^2 e^(lambda_1 x), lambda_2^2 e^(lambda_2 x)) 
    $
    代入原方程：
    $
    #(linearCombination(name : $C'$, $lambda_1 e^(lambda_1 x)$, $lambda_2 e^(lambda_2 x)$)) + linearCombinationC(lambda_1^2 e^(lambda_1 x), lambda_2^2 e^(lambda_2 x))\
     + a(linearCombinationC(lambda_1 e^(lambda_1 x), lambda_2 e^(lambda_2 x))) + b(#(linearCombination(..g_s)))  = f(x)\
     #(linearCombination(name : $C'$, $lambda_1 e^(lambda_1 x)$, $lambda_2 e^(lambda_2 x)$)) = f(x)
    $
    解出 $C_1, C_2$:
    $
    C'_2 (lambda_2 - lambda_1) e^(lambda_2 x) = f(x)\
    C'_2 = 1/ (lambda_2 - lambda_1) f(x) e^(-lambda_2 x)\
    C'_1 = 1/ (lambda_1 - lambda_2) f(x) e^(-lambda_1 x)\
    C_2 = integral_0^x 1/ (lambda_2 - lambda_1) f(t) e^(-lambda_2 t) dif t\
    C_1 = integral_0^x 1/ (lambda_1 - lambda_2) f(t) e^(-lambda_1 t) dif t 
    $
    最终得：
    $
    y = 1/(lambda_2 - lambda_1) (e^(lambda_2 x) integral_0^x  f(t) e^(-lambda_2 t) dif t - e^(lambda_1 x) integral_0^x  f(t) e^(-lambda_1 t) dif t)
    $
    可设通解为：
    $
    y = 1/(lambda_2 - lambda_1) (e^(lambda_2 x) (integral_0^x  f(t) e^(-lambda_2 t) dif t + C_1) - e^(lambda_1 x) (integral_0^x  f(t) e^(-lambda_1 t) dif t + C_2))\
    = e^(lambda_1 x)/(lambda_2 - lambda_1 x) (e^((lambda_2 - lambda_1 )x) (integral_0^x  f(t) e^(-lambda_2 t) dif t + C_1) -  (integral_0^x  f(t) e^(-lambda_1 t) dif t + C_2))
    $
    注意到要使上式有界，考虑 $x -> -infinity$ 必有 $(e^((lambda_2 - lambda_1 )x) (integral_0^x  f(t) e^(-lambda_2 t) dif t + C_1) - (integral_0^x  f(t) e^(-lambda_1 t) dif t + C_2)) -> 0$，而由 $f$ 有界知无穷积分：
    $
    integral_(-infinity)^(x) f(t) e^(-lambda_1 t) dif t  
    $
    存在，因此 $(integral_0^x  f(t) e^(-lambda_1 t) dif t + C_2)$ 趋于常数，$e^((lambda_2 - lambda_1 )x) (integral_0^x  f(t) e^(-lambda_2 t) dif t + C_1)$ 也趋于常数，可得 $integral_0^x  f(t) e^(-lambda_2 t) dif t + C_1$ 趋于零，进而：
    $
    integral_0^x  f(t) e^(-lambda_2 t) dif t + C_2 = integral_(-infinity)^(x)  f(t) e^(-lambda_2 t) dif t\
    $
    利用洛必达法则可得：
    $
    e^((lambda_2 - lambda_1 )x) integral_(-infinity)^(x)  f(t) e^(-lambda_2 t) dif t = (integral_(-infinity)^(x)  f(t) e^(-lambda_2 t) dif t)/(e^((lambda_1 - lambda_2) x) ) -> 0
    $
    从而 $integral_0^x  f(t) e^(-lambda_2 t) dif t + C_1 -> 0$，有：
    $
    integral_0^x  f(t) e^(-lambda_1 t) dif t + C_1 = integral_(-infinity)^(x) f(t) e^(-lambda_1 t) dif t
    $
    综上解只能是：
    $
    1/(lambda_2 - lambda_1) (e^(lambda_2 x) integral_(-infinity)^x  f(t) e^(-lambda_2 t) dif t  - e^(lambda_1 x) integral_(-infinity)^x  f(t) e^(-lambda_1 t) dif t )
    $
    而：
    $
    abs(e^(lambda_2 x) integral_(-infinity)^x  f(t) e^(-lambda_2 t) dif t) 
    &<= e^(lambda_2 x) integral_(x)^(-infinity) abs(f(x)) e^(-lambda_2 t) dif t\
    &<= M  e^(lambda_2 x) integral_(x)^(-infinity)  e^(-lambda_2 t) dif t\
    &= M e^(lambda_2 x) e^(-lambda_2 x)\
    &= M
    $
    类似也可证明另一部分也有界，进而有界

    对于第一个命题，设此特解为 $y_0$，通解为 $y_0 + C_1 e^(lambda_1 x) + C_2 e^(lambda_2 x)$，由 $lambda_1, lambda_2 < 0$ 知结论当然正确

    对于第二个命题，可以验证若 $f(x)$ 是周期函数则：
    $
    e^(lambda x) integral_(-infinity)^x  f(t) e^(-lambda t) dif t, forall lambda < 0
    $
    都是周期函数，因此 $y_0$ 当然是周期函数
= p238
  == 1
    === (1)
      $1, -1$ 是常点，$0$ 是正则奇点，既然方程等价于：
      $
      x^2 y'' + x(1-x) y' + x^2 y = 0
      $
      且 $1-x$ 非负
    === (2)
      $1, -1$ 是正则奇点，$0$ 是非正则奇点，既然方程等价于：
      $
      2(1-x^2)y'' + 2/x^3 y' + 2/x^2 y = 0
      $
      $x^3$ 导致三重极点的出现
    === (3)
      $1, -1$ 是正则奇点，$0$ 非正则，原因同上
  == 2
    #let sumn(s) = $sum_(n=#s)^(+infinity)$
    == (1)
      方程等价于：
      $
      2 x^2 y'' + x y' + x^2 y = 0
      $
      容易验证 $0$ 是正规奇点，指标方程形如：
      $
      rho (rho - 1) + rho = 0\
      rho^2 = 0
      $
      因此选取 $rho = 0$ 即可，也即可设：
      $
      y = sumn(0) a_n x^n
      $
      代入方程：
      $
      2 x sumn(2) n (n-1) a_n x^(n-2) + sumn(1) n a_n x^(n-1) + x sumn(0) a_n x^n = 0\
      2 sumn(2) n (n-1) a_n x^(n-1) + sumn(1) n a_n x^(n-1) + sumn(0) a_n x^(n+1) = 0\
      a_1 x^0 + 2 sumn(1) (n+1) n a_(n+1) x^(n) + sumn(1) (n+1) a_(n+1) x^(n) + sumn(1) a_(n-1) x^n = 0\
      a_1 x^0 + sumn(1) ((2 n + 1) (n+1)  a_(n+1) + a_(n-1)) x^n = 0
      $
      得到方程：
      $
      a_1 = 0\
      (2 n + 1) (n+1)  a_(n+1) + a_(n-1) = 0
      $
      可得 $n$ 为奇数时 $a_n = 0$，为偶数时有：
      $
      a_n = - 1/2 1/(n ( n - 1/2)) a_(n-2) = ... = (-1/2)^(n/2) 1/(n!! (n -1/2)!!) a_0
      $

      先取 $a_0 = 1$，在二阶常系数微分方程中，设 $y_2$ 是另一个线性无关的解，及：
      $
      W = Det(y_1, y_2;y'_1, y'_2)
      $
      熟知：
      $
      W' = -a(x) W = -1/(2 x) W
      $
      解得：
      $
      W = C x^(-1/2)
      $
      无妨设 $W = x^(-1/2)$，有：
      $
      y_1 y'_2 - y_2 y'_1 = x^(-1/2)
      $
      设 $y_2 = u y_1$ 有：
      $
      u' y_1^2 = x^(-1/2)\
      u = integral y_1^(-2)(x) x^(-1/2) dif x\
      y_2 = y_1(x) integral y_1^(-2)(x) x^(-1/2) dif x
      $
    == (2)
      方程等价于：
      $
      x^2 y'' + x y' - x y= 0
      $
      同样可以验证是正规奇点，指标方程为：
      $
      rho(rho - 1) + rho = 0
      $
      同样取 $rho = 0$ 也即设：
      $
      y = sumn(0) a_n x^n
      $
      代入得：
      $
      x sumn(2) n (n-1) a_n x^(n-2) + sumn(1) n a_n x^(n-1) - sumn(0) a_n x^n = 0\
      sumn(2) n (n-1) a_n x^(n-1) + sumn(1) n a_n x^(n-1) - sumn(0) a_n x^(n) = 0\
      sumn(1) (n+1) n a_(n+1) x^n + sumn(0) (n+1) a_(n+1) x^(n) - sumn(0) a_n x^(n) = 0\
      $
      得到方程：
      $
      a_1 = a_0\
      (n+1) n a_(n+1) + (n+1) a_(n+1) = a_n\
      a_n = (n+1)^2 a_(n+1)\
      a_n = (1/(n!))^2 a_0
      $
      因此可设：
      $
      y_1 = sumn(0) (1/(n!))^2 x^n
      $
      类似之前的过程设：
      $
      W = Det(y_1, y_2;y'_1, y'_2)
      $
      有：
      $
      W' = - 1/x W\
      W = 1/x \
      y_1 y'_2 - y_2 y'_1 = 1/x\
      $
      设 $y_2 = u y_1$，有：
      $
      u' y_1^2 = 1/x\
      u = integral_()^() 1/(x y_1^2 (x)) dif x\
      y_2 = y_1(x) integral_()^() 1/(x y_1^2 (x)) dif x 
      $

      