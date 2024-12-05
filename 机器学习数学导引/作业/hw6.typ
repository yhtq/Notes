#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: true
)
= #empty
  == #empty
    注意到：
    $
      t(x) = 
      cases(
        1 + x quad -1 < x <= 0,
        1 - x quad 0 < x < 1,
        0 quad "otherwise"
      )
    $
    因此：
    $
      t(x) = (sigma(1 - x) - sigma(-x)) + (sigma(1 + x) - sigma(x)) - 1
    $
    进而 $P_M f$ 可以被两层 RELU 网络表示
  == #empty
    考虑：
    $
      abs(f(x) - P_M f(x)) = abs(f(x) - sum_k f(x_k) t((x - x_k) / h))\
    $
    假设 $x in [x_(k - 1), x_k]$，则上式等于：
    $
      abs(f(x) -  f(x_(k - 1)) t((x - x_(k - 1)) / h) - f(x_k) t((x - x_k) / h))\
      = abs(f(x) -  f(x_(k - 1)) ((x_k - x) / h) - f(x_k) ((x - x_(k - 1)) / h))\
      = abs(((x_k - x) / h) (f(x) - f(x_(k - 1))) + ((x - x_(k - 1)) / h) (f(x) - f(x_k)))\
      <= abs(((x_k - x) / h) (f(x) - f(x_(k - 1)))) + abs(((x - x_(k - 1)) / h) (f(x) - f(x_k)))\
      <= abs( (f(x) - f(x_(k - 1)))) + abs((f(x) - f(x_k)))\
    $
    因此，对于任何 $epsilon > 0$，由连续函数的一致连续性，取 $delta$ 使得 $abs(x - y) < delta => abs(f(x) - f(x)) < epsilon$，令 $M$ 充分大使得 $h < delta$，立刻有：
    $
      abs(f(x) - P_M f(x)) < 2 epsilon
    $
  == #empty
    对于 $f(x) = x^2$，做类似估计有：
    $
      abs(f(x) - P_M f(x)) <= abs(((x_k - x) / h) (x^2 - x_(k - 1)^2) + ((x - x_(k - 1)) / h) (x^2 - x_k^2))\
      = 1/h (x - x_(k - 1)) (x_k - x) h\
      <= h^2/4
    $
    因此只需：
    $
      1/(4 M^2) < epsilon\
      M > 1/(2 sqrt(epsilon)) 
    $
= #empty
  == #empty
    #let fs = $f^*$
    上一题已经证明：
    $
      abs(P_(2^l) fs (x) - fs(x)) < (1/2^l)^2/4 = 1/4 2^(-2l)
    $
  == #empty
    用归纳法，假设：
    $
      x in [m/(2^l), (m + 1)/(2^l)]\
    $
    简略起见，设 $m = 4k$（其他情形类似），则：
    $
      x in [k/(2^(l - 2)), (k + 1)/(2^(l - 2))]\
    $
    归纳假设给出：
    $
      P_(2^(l-2)) fs(x) - P_(2^(l - 1)) fs(x) = (g_(l-1) (x))/(2^(2(l-1)))
    $
    同时：
    $
      P_(2^(l-2)) fs(x) - P_(2^(l - 1)) fs(x) \
      = (k/(2^(l - 2)))^2 ((k + 1) - 2^(l - 2) x) + ((k + 1)/(2^(l - 2)))^2 (2^(l - 2) x - k) - (k/(2^(l - 2)))^2 ((2k + 1) - 2^(l - 1) x) - ((2k + 1)/(2^(l - 1)))^2 (2^(l - 1) x - 2 k)\
    $
    换言之：
    $
      g_(l - 1) (x) =(2 k)^2 ((k + 1) - 2^(l - 2) x) + (2 k + 2)^2 (2^(l-2) x - k) - (2 k)^2 ((2k + 1) - 2^(l-1)  x) - (2k + 1)^2 (2^(l-1) x - 2 k)\
      = (2 k)^2 (2^(l-2)x - k) + (2^(l-2) x - k) ((2 k + 2)^2 - 2 (2 k + 1)^2)\
      = 2 (2^(l-2)x - k)\
      <= 2 (2^(l-2) (4 k + 1)/(2^l) - k) = 1/2
    $
    因此：
    $
      g_l (x) = max(0, 1 - abs(2 g_(l - 1) (x) - 1))\
      = max(0, 2 g_(l - 1) (x))\
      = 2 (2^(l-1)x - 2 k)
    $
    由类似的推导，它就是：
    $
      P_(2^(l-1)) fs(x) - P_(2^(l)) fs(x)
    $
  == #empty
    显然 $g(x) = t(2 x - 1)$ 是两层 RELU 网络，因此 $g_l (x)$ 可以表示为 $2 l$ 层 RELU 网络
= #empty
  == #empty
    #let hR = $hat(cal(R))$
    #let hRd = $hR_"drop"$
    #let mask = $dot.circle$
    $
      hRd = E (1/(2n) sum_(i = 1)^n ( (beta mask xi)^T x_i - y_i^2))\
      = 1/(2n) sum_(i = 1)^n E ( (beta mask xi)^T x_i - y_i)^2\
      = 1/(2n) sum_(i = 1)^n E ( (beta mask xi)^T x_i - beta^T x + p beta^T x - y_i)^2\
      = 1/(2n) sum_(i = 1)^n E ( (beta mask xi)^T x_i - beta^T x)^2 + (p beta^T x - y_i)^2\
      = hR(hat(beta)) + 1/(2n) sum_(i = 1)^n D ( (beta mask xi)^T x_i)^2 \
      = hR(hat(beta)) + 1/(2n) sum_(i = 1)^n D (sum_d xi_d beta_d x_(i, d))^2 \
      = hR(hat(beta)) + 1/(2n) sum_(i = 1)^n sum_d D(xi_d beta_d x_(i, d))^2 \
      = hR(hat(beta)) + 1/(2n) sum_(i = 1)^n sum_k (1-p)/p (p beta_k)^2 (x_(i, k))^2 \
      = hR(hat(beta)) + 1/(2) sum_k (1-p)/p (p beta_k)^2 1/n sum_(i = 1)^n  (x_(i, k))^2 \
      = hR(hat(beta)) + (1 - p)/(2 p) sum_k omega_k tilde(beta)_j^2 \
      // = 1/(2n) sum_(i = 1)^n E ( (beta mask xi)^T x_i - p beta^T x)^2 + (p beta^T x - y_i)^2\
      // = 1/(2n) sum_(i = 1)^n D ( (beta mask xi)^T x_i) + (p beta^T x - y_i)^2\
      // = 1/(2n) sum_(i = 1)^n D ( sum_k xi_k beta_k x_(i, k) ) + (p beta^T x - y_i)^2\
      // = 1/(2n) sum_(i = 1)^n  sum_k D (xi_k) (beta_k x_(i, k))^2 + (p beta^T x - y_i)^2\
      // = 1/(2n) sum_(i = 1)^n  sum_k p (1-p) (beta_k x_(i, k))^2 + (p beta^T x - y_i)^2\
      // = 1/(2n) sum_(i = 1)^n  sum_k p (1-p) (beta_k x_(i, k))^2 + (p beta^T x - beta^T x + beta^T x - y_i)^2\
      // = 1/(2n) sum_(i = 1)^n  sum_k p (1-p) (beta_k x_(i, k))^2 + (p-1)^2 (beta^T x)^2 + 2 (p - 1) beta^T x (beta^T x - y_i) + (beta^T x - y_i)^2\
      // = hR(beta) + 1/(2n) sum_(i = 1)^n  sum_k p (1-p) (beta_k x_(i, k))^2 + (p-1)^2 (beta^T x)^2 + 2 (p - 1) beta^T x (beta^T x - y_i)\

    $
    // 对于某个 $x$，假设 $x in [u, u']$，其中 $u$ 是 $M = 2^(l - 1)$ 时划分点。
    // - 假设 $x in [u, v], v = (u + u') / 2$ 是 $M = 2^l$ 时划分点，有：
    //   $
    //     P_(2^(l - 1)) fs(x) - P_(2^l) fs(x) = u^2 t((x - u) / h) + u'^2 t((x - u') / h) - u^2 t((x - u) / (2 h)) - v^2 t((x - v) / (2 h))\
    //     = u^2 ((u' - x) / h) + u'^2 ((x - u) / h) - u^2 ((v - x) / (2 h)) - v^2 ((x - u) / (2 h))\
    //   $
    //   归纳假设给出：
    //   $
    //     P_(2^(l - 2)) fs(x) - P_(2^(l - 1)) fs(x) = u^2 ((u' - x) / h) + u'^2 ((x - u) / h) - u^2 ((v - x) / (2 h)) - v^2 ((x - u) / (2 h))\
    //   $
= #empty
  代码为：
  #raw(read("../code6/src/code6/main.py"), lang: "python", block: true)
  输出为：
  #raw(read("../code6/train_output"), lang: "text", block: true)