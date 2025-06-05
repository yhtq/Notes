#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业6",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
= 
  $
    sum_(l = 1)^N sum_(k = 1)^N alpha_t (l) a_(l k) b_k (O_(t + 1)) beta_(t + 1) (k)\
    = sum_(l = 1)^N alpha_t (l) sum_(k = 1)^N a_(l k) b_k (O_(t + 1)) beta_(t + 1) (k)\
    = sum_(l = 1)^N alpha_t (l) beta_(t) (l)\
    = sum_(l = 1)^N P(O_1, O_2, ..., O_t | X_t = l) P(O_(t + 1), O_(t + 2), ..., O_T | X_t = l) \
    = sum_(l = 1)^N P(O_1, O_2, ..., O_t, O_(t + 1), O_(t + 2), ..., O_T | X_t = l)\
    ("在给定" X_t "的情况下，序列前半部分和后半独立")\
    = P(O)
  $
= 
  $
    delta_t (s) = max_(s' in S) max_(X_1, X_2, ..., X_(t - 2)) P(X_1, X_2, ..., X_(t - 1) = s', X_t = s, O_1, O_2, ..., O_t)\
      = max_(s' in S) max_(X_1, X_2, ..., X_(t - 2)) P(X_t = s, O_t | X_1, X_2, ..., X_(t - 1) = s', O_1, O_2, ..., O_(t - 1)) P(X_1, X_2, ..., X_(t - 1) = s', O_1, O_2, ..., O_(t - 1))\
      = max_(s' in S) P(X_t = s, O_t | X_(t - 1) = s') delta_(t - 1) (s')\
      = max_(s' in S) P(X_t = s| X_(t - 1) = s') P(O_t | X_t = s) delta_(t - 1) (s')
  $
= 
  $
    delta_(1) (s) = P(X_1 = s, O_1) =  P(X_1 = s) P(O_1 | X_1 = s)\
    delta_1 = vec(0.6 * 0.3, 0.2 * 0.2, 0.2 * 0.4) = vec(0.18, 0.04, 0.08)\
    delta_2 (q_1) = 0.5 * max {0.6 * 0.18, 0.3 * 0.04, 0.3 * 0.08} = 0.054\
    delta_2 (q_2) = 0.2 * max{0.2 * 0.18, 0.5 * 0.04, 0.08 * 0.3} = 0.0072\
    delta_2 (q_3) = 0.3 * max{0.2 * 0.18, 0.2 * 0.04, 0.4 * 0.08} = 0.0108\
    delta_3 (q_1) = 0.2 * max{0.6 * 0.054, 0.3 * 0.0072, 0.3 * 0.0108} = 0.00648\
    delta_3 (q_2) = 0.6 * max{0.2 * 0.054, 0.5 * 0.0108, 0.3 * 0.0108} = 0.0054 * 0.6\
    delta_3 (q_3) = 0.3 * max{0.2 * 0.054. 0.2 * 0.0072, 0.4 * 0.0108} = 0.3 * 0.0108
  $
  可见 $delta_3 (q_1)$ 最大，概率为 $0.00648$，路径为 $q_1, q_1, q_1$