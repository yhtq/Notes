#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: true
)
= #empty
  #let cth = $\; theta$
  $
    nabla L(theta) = -1/n sum_i nabla log p(x_i cth)\
    = - 1/n sum_i nabla (- V(x_i cth) - log integral e^(-V(x cth)) dif x )\
    = 1/n sum_i (nabla V(x_i cth) + nabla log integral e^(-V(x cth)) dif x )\
    = 1/n sum_i (nabla V(x_i cth) + (nabla integral e^(-V(x cth)) dif x) / (integral e^(-V(x cth)) dif x))\
    = 1/n sum_i (nabla V(x_i cth) + (integral nabla e^(-V(x cth)) dif x) / (integral e^(-V(x cth)) dif x))\
    = 1/n sum_i (nabla V(x_i cth) - (integral nabla V(x cth) dot e^(-V(x cth)) dif x) / (integral e^(-V(x cth)) dif x))\
    = 1/n sum_i nabla V(x_i cth) - (integral nabla V(x cth) dot e^(-V(x cth)) dif x) / (integral e^(-V(x cth)) dif x)\
    = 1/n sum_i nabla V(x_i cth) - (integral nabla V(x cth) dot e^(-V(x cth))/ (integral e^(-V(x cth)) dif x) dif x )\
    = E_(x tilde hat(P)_n) nabla V(x_i cth) - E_(x tilde P_theta) V(x cth)\
  $
= #empty
  #let KL(p, q) = $"KL" (#p || #q)$
  #let GB(V) = $e^(- #V (x))/(E e^(-#V))$
  == #empty
    #lemmaLinear[][
      假设 $X, Y$ 独立，有：
      $
        log E e^X - log E e^Y <= E (X - Y)
      $
    ]
    #proof[
      由 $log$ 的凸性，有：
      $
        log E e^(X - Y) <= E log e^(X - Y) = E (X - Y)
      $
      而：
      $
        log E e^(X - Y) = log E e^X/e^Y = log E e^X - log E e^Y 
      $
      得证
    ]
    $
      KL(Q_1, Q_2) = integral  GB(V_1) (log GB(V_1) - log GB(V_2)) dif x\
      = integral  GB(V_1) (log GB(V_1) - log GB(V_2)) dif x\
      = integral  GB(V_1) (V_2(x) - V_1 (x) + log E e^(-V_2) - log E e^(-V_1)) dif x\
      = abs(integral  GB(V_1) (V_2(x) - V_1 (x) + log E e^(-V_2) - log E e^(-V_1)) dif x)\
      <= abs(integral  GB(V_1) (V_2(x) - V_1 (x)) dif x) + abs(integral  GB(V_1) (log E e^(-V_2) - log E e^(-V_1)) dif x)\
      <= integral  GB(V_1) abs(V_2(x) - V_1 (x)) dif x + integral  GB(V_1) abs(log E e^(-V_2) - log E e^(-V_1)) dif x\
      <= integral  GB(V_1) abs(V_2(x) - V_1 (x)) dif x + integral  GB(V_1) abs(E(V_1 - V_2)) dif x\
      <= 2 norm(V_1 - V_2) integral  GB(V_1) dif x\
      = 2 norm(V_1 - V_2)
    $
  == #empty
    显然有：
    $
      p(x) = e^(-log (1/(p(x))))\
    $
    因此若设 $Q^*$ 的概率密度为 $p$，则取 $V(x) = log 1/p(x)$ ，其对应的玻尔兹曼分布就是 $Q^*$\
    由 $cal(V)$ 的紧致性，取一列 $V_m -> V$，并记对应的玻尔兹曼分布为 $Q_m$，则有：
    $
      KL(Q^*, Q_m) <= 2 norm(V - V_m) -> 0
    $
  == #empty
    不难验证 $Q_*$ 是 ${Q^epsilon_* | epsilon > 0}$ 的极限点，而后者是一族密度函数严格正的分布，根据 KL 散度的凸性不难验证 $Q_*$ 可以被 $cal(V)$ 逼近。
= #empty
  记 $y(t, x_0)$ 是题上微分方程以 $x_0$ 为初值，$t$ 时的值。有：
  $
    partialDer(y(t, x_0), t) = f(y(t, x_0), t)\
    (diff^2 y(t, x_0))/ (diff t diff x_0) = f_x (y(t, x_0), t) partialDer(y(t, x_0), x_0)\
  $
  令 $u = partialDer(y(t, x_0), x_0)$，有：
  $
    partialDer(u, t) = f_x (y(t, x_0), t) u\
    u = C e^(integral_0^t f_x (y(s, x_0), s) dif s)
  $
  结合初值有：
  $
    u = e^(integral_0^t f_x (y(s, x_0), s) dif s)
  $
  由换元公式有：
  $
    p_t (x_t) = (p_0 (x_0)) / abs(det ((diff x_t) / (diff x_0)))\
    log p_t (x_t) = log p_0 x_0 - log abs(det (e^(integral_0^t f_x (x_s, s) dif s)))\
    = log p_0 (x_0) - tr (integral_0^t f_x (x_s, s) dif s)\
    = log p_0 (x_0) - tr (integral_0^t nabla_x  f (x_s, s) dif s)\
  $