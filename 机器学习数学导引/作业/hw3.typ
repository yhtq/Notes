#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业3",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
)
#let index = $bold(1)$

= #empty
  首先由熟知的不等式：
  $
  max e^(z_j) <= ((sum_j (e^(z_j))^beta) / n)^(1 / beta)
  $
  取对数得：
  $
  max z_j <= log((sum_j e^(beta z_j)) / n) / beta <= log(sum_j e^(beta z_j)) / beta
  $
  另一方面：
  $
  log(sum_j e^(beta z_j)) / beta <= (log (n e^(beta max z_j))) / beta = max z_j + log n / beta
  $
= #empty
  == #empty
    显有若 $x_i$ 分类正确则 $p_i >= 1/C$，否则 $p_i < 1/2$. 假设 $x_i$ 分类错误，则有：
    $
    1/n sum_i -log p_i > 1/n (- log p_i) = 1/n (-log 1/2) = (log 2) / n
    $
    因此若 $cal(R) <= (log 2) / n$ 一定所有都分类正确
  == #empty
    $
    sum_i index (y_i in.not argmax_j f_j (x_i)) <= sum_i -(log p_i)/(log 2) = 1/(log 2) cal(R)
    $
  == #empty 
    #lemma[][
      假设 $x_i > 0$ 严格递减，则有：
      $
      1 - x_0^lambda / (sum_i x_i^lambda) tilde (x_1/x_0)^lambda
      $ 
      这里 $tilde$ 是指 $lambda -> +infinity$ 时的等价无穷小
    ]
    #proof[
      $(1 - x_0^lambda / (sum_i x_i^lambda)) / (x_1/x_0)^lambda  = ((sum_(i > 0) x_i^lambda) / (sum_i x_i^lambda)) / (x_1/x_0)^lambda = (sum_(i > 0) (x_i / x_1)^lambda) x_0^lambda / (sum_i x_i^lambda) -> 1$
    ]
    #lemma[][
      设 $a, b > 0$ 是等价无穷小，则 $log(a), log(b)$ 是等价无穷大 
    ]
    #proof[
      $log(a) / log(b) = log(b dot a / b) / log(b) = 1 - log(a / b) / (log b) -> 1$ 
    ]
    #lemma[][
      假设对于每个 $i, x_(i j) > 0$ 关于 $j$ 严格递减，且 $x_(i 0)/x_(i 1)$ 也严格递减，则：
      $
      (log (1/n sum_i - log (x_(i 0) / (sum_j x_(i j)))))/lambda -> log x_(0 1)  - log x_(0 0)
      $
    ]
    #proof[
      注意到有：
      $
      -log (x_(i 0) / (sum_j x_(i j))) = -log (1 + x_(i 0) / (sum_j x_(i j)) - 1) tilde 1 - x_(i 0) / (sum_j x_(i j)) tilde (x_(i 1) / x_(i 0))^lambda\
      log (1/n sum_i - log (x_(i 0) / (sum_j x_(i j)))) tilde 1/n sum_i (x_(i 1) / x_(i 0))^lambda tilde 1/n (x_(0 1)/x_(0 0))^lambda 
      $
      因此：
      $
      (log (1/n sum_i - log (x_(i 0) / (sum_j x_(i j)))))/lambda tilde log(1/n (x_(0 1)/x_(0 0))^lambda )/lambda = log x_(0 1)  - log x_(0 0)
      $
    ]
    在上面的引理中代入 $e^(f_j (x_i))$ 并重新排序即得结论。
= #empty
  == #empty
    记 $V_x^bot$ 为 ${x_i}$ 的正交补空间，对任意 $beta$ 可做正交分解：
    $
    beta = beta_1 + beta_2, beta_2 in V_x^bot, beta_1 in V_x
    $
    则显然有：
    $
    1/n sum_i l(y_i f(x_i\; beta, beta_0)) + lambda/2 norm(beta)^2 = 1/n sum_i l(y_i f(x_i\; beta_1)) + lambda/2 norm(beta_1)^2 + lambda/2 norm(beta_2)^2
    $
    显然对于最优解 $beta^*$ 应有 $beta_2 = 0$，也即 $beta^*$ 在 $V_x$ 上。代入 $beta^* = X alpha$，优化目标变为：
    $
    1/n sum_i l(y_i (alpha^T X^T x_i + beta_0)) + lambda/2 alpha^T X^T X alpha
    $
    对 $alpha$ 求导，得：
    $
    0 = 1/n sum_i y_i X^T x_i l'(y_i (alpha^T X^T x_i + beta_0)) + lambda X^T X alpha = 1/n sum_i y_i X^T x_i l'(gamma_i^star) + lambda X^T X alpha
    $
    显有 $abs(alpha_i) prop l'(gamma_i^star)$
  == #empty
    === #empty
      $
      l'(gamma_i^star) = - e^(-gamma_i^star)
      $
      显有 $abs(alpha_i) prop e^(-gamma_i^star)$
    === #empty
      当 $gamma_i^* > 1$ 时，不难发现有 $l' (gamma_i^star) = 0$，因此只能有 $alpha_i = 0$
    === #empty
      $alpha_i$ 可以看作数据点 $x_i$ 的权重，当 $l' (gamma_i^star)$ 较大时，对应数据点对于分类结果非常敏感，说明该数据点对于分类结果的贡献较大，因此 $alpha_i$ 也应该较大。
= #empty
  == #empty
    由约束条件，不难得到：
    $
    epsilon_i >= max(0, 1 - y_i f(x_i))
    $
    假设 $t$ 单调递增，则目标取最小值时，显有：
    $
    epsilon_i = max(0, 1 - y_i f(x_i))
    $
    原问题变成：
    $
    min_(f in cal(F)) lambda Omega(f) + 1/n sum_i t(max(0, 1 - y_i f(x_i)))
    $
  == #empty
    为使：
    $
    t(max(0, 1 - y_i f(x_i))) = (max(0, 1 - y_i f(x_i)))^2
    $
    显然取 $t(x) = x^2$ 即可。



