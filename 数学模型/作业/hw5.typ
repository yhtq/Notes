#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#set heading(numbering: none)
= 4.1
  == 1
    设 $N = 2^k$, 目标是计算：
    $
    sum_(s=-N)^N sum_(t = - N)^N X_(s t) e^(-(2 pi i(s u + t v))/(2 N)), forall u, v = -N, ..., N
    $
    令 $omega = e^(-(2 pi i)/(2 N))$，上式变为：
    $
    sum_(s=-N)^N sum_(t = - N)^N X_(s t) omega^(s u) omega^(t v)\
    // = sum_(s=0)^N sum_(t = 0)^N X_(s t) omega^(s u) omega^(t v) + sum_(s=0)^N sum_(t = -N)^0 X_(s t) omega^(s u) omega^(t v) + sum_(s=-N)^0 sum_(t = 0)^N X_(s t) omega^(s u) omega^(t v) + sum_(s=-N)^0 sum_(t = -N)^0 X_(s t) omega^(s u) omega^(t v)\
    // = sum_(s=0)^N sum_(t = 0)^N X_(s t) omega^(s u) omega^(t v) + sum_(s=0)^N sum_(t = 0)^N X_(s (t - N)) omega^(s u) omega^((t - N) v) + sum_(s=0)^N sum_(t = 0)^N X_((s - N) t) omega^(s - N) u) omega^(t v) + sum_(s=0)^N sum_(t = 0)^N X_((s - N) (t - N)) omega^((s - N) u) omega^((t - N) v)\ 
    // = sum_(s=0)^N sum_(t = 0)^N X_(s t) omega^(s u) omega^(t v) + sum_(s=0)^N sum_(t = 0)^N X_(s (t - N)) omega^(s u) omega^((t - N) v) + sum_(s=0)^N sum_(t = 0)^N X_((s - N) t) omega^(s u) omega^(t v) + sum_(s=0)^N sum_(t = 0)^N X_((s - N) (t - N)) omega^(s u) omega^(t v)\
    = sum_(s = -N/2)^(N/2) sum_(t = -N/2)^(N/2) X_(2s 2t) omega^(2 s u) omega^(2 t v) + sum_(s = -N/2)^(N/2) sum_(t = -N/2)^(N/2 - 1) X_(2s 2t-1) omega^(2 s u) omega^((2 t - 1) v) \
    + sum_(s = -N/2)^(N/2 - 1) sum_(t = -N/2)^(N/2) X_(2s-1 2t) omega^((2 s - 1) u) omega^(2 t v) + sum_(s = -N/2)^(N/2 - 1) sum_(t = -N/2)^(N/2 - 1) X_(2s-1 2t-1) omega^((2 s - 1) u) omega^((2 t - 1) v)\
    = sum_(s = -N/2)^(N/2) sum_(t = -N/2)^(N/2) X_(2s 2t) omega^(2 s u) omega^(2 t v) 
    + omega^(-v) sum_(s = -N/2)^(N/2) sum_(t = -N/2)^(N/2 - 1) X_(2s 2t-1) omega^(2 s u) omega^(2 t) \
    + omega^(-s) sum_(s = -N/2)^(N/2 - 1) sum_(t = -N/2)^(N/2) X_(2s-1 2t) omega^(2 s u) omega^(2 t v) 
    + omega^(-v) omega^(-s) sum_(s = -N/2)^(N/2 - 1) sum_(t = -N/2)^(N/2 - 1) X_(2s-1 2t-1) omega^(2 s u) omega^(2 t v)\
    $
    此外，当然有 $omega^(v - N) = - omega^v, omega^(u - N) = -omega^N$，因此只需对 $u, v in [0, N]^2 sect ZZ^2$ 计算上面四个子二维傅里叶变换，然后将结果合并即可。\
    方便起见，设加法和乘法的时间代价均为 $1$，$N = 2^k$ 对应二维傅里叶展开的计算次数约为：
    $
    a_(2^k) = 4 a_(2^(k-1)) + 7 dot 4 dot 2^(2 k) 
    $
    令 $b_k = 2^(-k) a_(2^k)$，将有：
    $
    2^k b_k = 2^(k+1) b_(k-1) + 7 dot 4 dot 2^(2 k)\
    b_k = 2 b_(k-1) + 28 2^k\
    2^(-k) b_k = 2^(-(k-1)) b_(k-1) + 28\
    2^(-k) b_k = 28 k + A\
    b_k = 28 k 2^k + A 2^k\
    a_(2^k) = 28 k 2^(2 k) + A 2^(2 k)\
    $
    总之，时间复杂度为 $O(N^2 log N)$
= 4.22
  == 1
    
    #let xi2 = $x_i$
    #let xi1 = $x_(i-1)$
    #let uxi2 = $u(xi2)$
    #let uxi1 = $u(xi1)$
    #let di = $x_(i) - x_(i-1)$
    #let din = $x_(i-1) - x_i$
    任取 $x$ 使得 $x_(i-1) <= x <= x_i$，将有：
    $
    &quad abs(u(x) - u_I (x)) = abs(u(x) - (x - x_i)/(x_(i-1) - x_i) u(x_(i-1)) - (x - x_(i-1))/(x_i - x_(i-1)) u(x_i))\
    &= abs(((x - x_(i-1))/(x_i - x_(i-1)) + (x - x_i)/(x_(i-1) - x_i))u(x) - (x - x_i)/(x_(i-1) - x_i) u(x_(i-1)) - (x - x_(i-1))/(x_i - x_(i-1)) u(x_i))\
    &= abs((x - x_i)/(x_(i-1) - x_i)(u(x) - u(x_(i-1))) + (x - x_(i-1))/(x_i - x_(i-1))(u(x) - u(x_i)))\
    &= abs((x - x_i)/(x_(i-1) - x_i)(u(x_(i-1)) - u(x)) + (x - x_(i-1))/(x_i - x_(i-1))(u(x_i) - u(x)))\
    &= abs((x - x_i)/(x_(i-1) - x_i)((x_(i-1) - x) u'(x) + 1/2 (x_(i-1) - x) u''(xi_1)) \
    &quad + (x - x_(i-1))/(x_i - x_(i-1))((x_i - x)u'(x) + 1/2 (x_i - x)^2 u''(xi_2)))\
    &= 1/2 abs(((x-x_i)(x-x_(i-1)))/(x_(i-1) - x_i)) abs((x - x_(i-1)) u''(xi_1) - (x_i - x) u''(xi_2))\
    &<= 1/2 abs(((x-x_i)(x-x_(i-1)))/(x_(i-1) - x_i)) abs(x - x_(i-1) + x_i - x) norm(u'')_infinity\
    &<= 1/2 abs(((x_i - x)(x-x_(i-1))))  norm(u'')_infinity\
    &<= 1/8 h^2 norm(u'')_infinity
    //= abs(((x-x_i)(x-x_(i-1)))/(x_(i-1) - x_i)) abs(u'(xi_1) - u'(xi_2))\
    //=  abs(((x-x_i)(x-x_(i-1)))/(x_(i-1) - x_i)) abs(xi_1 - xi_2) abs(u''(xi_3))\
    //=  abs(((x_i - x)(x-x_(i-1)))/(x_(i-1) - x_i)) abs(xi_1 - xi_2) abs(u''(xi_3))\
    //<= 1/4 h^2 abs((xi_1 - xi_2)/(x_(i-1) - x_i)) norm(u'')_infinity
    $
    $
    u'_I (x) &= uxi1/din + uxi2/di\
    abs(u'_I (x) - u'(x)) &= abs(uxi1/din + uxi2/di - u'(x))\
    &= abs(((xi1 - x)u'(x) + 1/2 (xi1 - x)^2 u''(xi_1))/din + ((xi2 - x)u'(x) + 1/2 (xi2 - x)^2 u''(xi_2))/di - u'(x))\
    &= 1/2 1/abs(di) abs((xi2 - x)^2 u''(xi_2) - (xi1 - x)^2 u''(xi_1))\
    &<= 1/2 1/abs(di) abs((xi2 - x)^2 + (xi1 - x)^2) norm(u'')_infinity\
    $
    其中 $(xi2 - x)^2 + (xi1 - x)^2$ 是正的，最大值在边界处取得，为 $(di)^2$，上式不超过：
    $
    1/2 abs(di) <= 1/2 h norm(u'')_infinity
    $
    （不确定何处会引入 $sqrt(b-a)$，看起来也不是很合理，在每个点处的近似似乎应该和区间大小没有什么关系）
= 5.6
  == 1
    #answer[
      对于中点公式 $Q f = (b - a) f((a + b) / 2)$ 和梯形公式 $Q f = (b - a) (f(a) + f(b)) / 2$，不难验证它们在线性函数上的估计都是准确的，而设：
      $
      f = (x - 1/2)^2
      g = x(1-x)
      $
      均考虑 $[0, 1]$ 上的积分，则中点公式显然在 $f$ 上不准确，梯形公式在 $g$ 上不准确，因此两者恰有一阶代数精度

      对于辛普森公式：
      $
      Q f = (b - a) (f(a) + 4 f((a + b) / 2) + f(b)) / 6
      $
      同样不妨简化为 $[0, 1]$ 上积分，公式变为：
      $
      Q f = 1/6 (f(0) + 4 f(1/2) + f(1))
      $
      容易验证它对线性函数估计是准确的，而取 $f = x(1-x)$ 有：
      $
      integral_(0)^(1) x(1-x) dif x = 1/6 = 1/6 (0 + 4 * 1/4 + 0) 
      $
      任做线性组合可得辛普森公式对于任何不超过二次的多项式都是准确的。\
      再取 $f = x^3$，有：
      $
      integral_(0)^(1) x^3 dif x = 1/4 = 1/6 (0 + 4 * 1/8 + 1)
      $
      类似的对于任何不超过三次的多项式都是准确的。\
      再取 $f = x^4$，有：
      $
      integral_(0)^(1) x^4 dif x = 1/5 != 1/6 (0 + 4 * 1/16 + 1)
      $
      从而恰好有三阶代数精度
    ]
  == 2
    #answer[
      #lemmaLinear[][
        + 每个 $p_n (x)$ 都是首项为 $k_n$ 的 $n$  次多项式
        + 每个 $p_n (x)$ 都与 $p_i (x), i < n$ 正交
      ]
      #proofLinear[
        归纳证明，以上性质当然对 $n = 0, 1$ 正确，假设它们对 $0, 1, 2, ..., n$ 都正确，对 $n + 1$ 时情形分别证明三者：
        + 由递推式 $p_(n+1) (x) = (a_n x - b_n) p_n (x) - c_n p_(n-1) (x)$ 及归纳假设，当然 $p_(n+1) (x)$ 是首项为 $k_n$ 的 $n$ 次多项式
        + 计算：
          -
            $
            inner(p_(n+1), p_n) &= inner((a_n x - b_n) p_n , p_n)\
            &= a_n inner(x p_n, p_n) - b_n inner(p_n, p_n)\
            &= a_n inner(x p_n, p_n) - a_n inner(x p_n, p_n)/inner(p_n, p_n)  inner(p_n, p_n)\
            &= 0
            $
          - 
            $
            inner(p_(n+1), p_(n-1)) 
            &= a_n inner(x p_n, p_(n-1))  - c_n inner(p_(n-1), p_(n-1))\
            &= a_n inner(x p_n, p_(n-1)) - a_n/a_(n-1) inner(p_n ,p_n)\
            &= a_n/a_(n-1) (inner(p_n, a_(n-1) x p_(n-1)) - inner(p_n ,p_n))\
            &= a_n/a_(n-1) inner(p_n, a_(n-1) x p_(n-1) - p_n)\
            &= a_n/a_(n-1) inner(p_n, b_n p_(n-1) + c_n p_(n-2))\
            &= 0
            $
        证毕
      ]
      由引理，$p_0, p_1, ..., p_n$ 一定构成 $generatedBy(1\, x\, ... \, x^n)$ 的一组基，进而 $p_(n+1)$ 与其中元素都正交，当然是正交多项式，证毕
    ]
    