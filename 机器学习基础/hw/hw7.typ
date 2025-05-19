#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业7",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 3.5
  == 5
    $
      P(exists h in H, L_(D_m, f) (h) > epsilon and L_(S, f) (h) = 0) &<= sum_(h in H) P( L_(D_m, f) (h) > epsilon and L_(S, f) (h) = 0)\
      &= sum_(L_(D_m, f) (h) > epsilon) P(L_(S, f) (h) = 0)\
      &= sum_(L_(D_m, f) (h) > epsilon) P(product_(x in S) h(x) = f(x))\
      &= sum_(L_(D_m, f) (h) > epsilon) product_(i = 1)^m P_(x tilde D_i) (h(x) = f(x))\
      &<= sum_(L_(D_m, f) (h) > epsilon) (1/m sum_(i = 1)^m P_(x tilde D_i) (h(x) = f(x)))^m\
      &= sum_(L_(D_m, f) (h) > epsilon) (L_(D_m, f) (h))^m\
      &<= sum_(L_(D_m, f) (h) > epsilon) (1 - epsilon)^m\
      &<= abs(H) (1 - epsilon)^m\
      &<= abs(H) e^(-epsilon m)\
    $
  == 6
    依定义，对于可实现性假设成立的 $D, f$，不可知 PAC 可学习性的结论等价于 PAC 可学习性；对于不成立的 $D, f$，PAC 可学习性不作要求，因此当然在采用同一算法时，不可知 PAC 可学习性强于 PAC 可学习性。
= 2
  == PAC 可学习性
      称一个假设类 $H$ 是 PAC 可学习的，如果存在一个函数 $m_H : (0, 1) -> (0, 1) -> NN$ 以及一个学习算法满足：
      #align(center)[
        对于任何 $delta, epsilon in (0, 1)$，任何 $X$ 上的分布 $D$ 以及标签函数 $f : X -> {0, 1}$，只要 $H, D, f$ 满足可实现性假设，则选择任何样本数量 $m >= m_H (epsilon, delta)$ 独立同分布训练集，算法会给出一个假设 $h$ 使得 $P_S (L_(D, f) (h) <= epsilon) >= 1- delta$
      ]
  == 不可知 PAC 可学习性
      称一个假设类 $H$ 是不可知 PAC 可学习的，如果存在一个函数 $m_H : (0, 1) -> (0, 1) -> NN$ 以及一个学习算法满足：
      #align(center)[
        对于任何 $delta, epsilon in (0, 1)$，任何 $X times Y$ 上的分布 $D$，选择任何样本数量 $m >= m_H (epsilon, delta)$ 独立同分布训练集，算法会给出一个假设 $h$ 使得 $P_S (L_D (h) <= min_(h' in H) L_D (h') + epsilon) >= 1- delta$
      ]
  == 一致收敛性质
      称一个假设类 $H$ 是有一致收敛性质的，如果存在一个函数 $m_H : (0, 1) -> (0, 1) -> NN$ 满足：
      #align(center)[
        对于任何 $delta, epsilon in (0, 1)$，任何 $Z$ 上的分布 $D$，对于样本数量 $m >= m_H (epsilon, delta)$ 独立同分布训练集，它至少 $1 - delta$ 的概率是 $epsilon-$ representative 的
      ]
      这里的一致性是指，$m_H (epsilon, delta)$ 不依赖于分布 $D$ 和假设 $h$，事实上，对于任何固定分布 $D$ 和假设 $h$，我们有：
      $
        E L_S (h) = L_D (h)
      $
      故而只要使用大数律，当 $m$ 充分大时较大概率有 $abs(L_S (h) - L_D (h)) < epsilon$，但这个 $m$ 的大小条件依赖于 $D, h$
  == 估计误差
    $
       epsilon_("est") = L_D (h_S) - min_(h in H) L_D (h)
    $
= 3
  注意到：
  $
    E_S L_D (A(S)) \
    = P(L_D (A(S)) < min_h L_D (h) + epsilon) E_S (L_D (A(S)) | L_D (A(S)) < min_h L_D (h) + epsilon) \
    + P(L_D (A(S)) >= min_h L_D (h) + epsilon) E_S (L_D (A(S)) | L_D (A(S)) >= min_h L_D (h) + epsilon)\
    >= P(L_D (A(S)) < min_h L_D (h) + epsilon) min_h L_D (h) + P(L_D (A(S)) >= min_h L_D (h) + epsilon) ( min_h L_D (h) + epsilon)
  $
  因此取 $epsilon = epsilon delta$，记 $p =  P(L_D (A(S)) >= min_h L_D (h) + epsilon)$ 就有：
  $
    min_h L_D (h) + epsilon delta >= E_S L_D (A(S)) >= (1 - p) min_h L_D (h) + p (min_h L_D (h) + epsilon) => p <= delta
  $
  证毕。
   
