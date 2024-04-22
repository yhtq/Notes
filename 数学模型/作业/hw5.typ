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
（应交事件为4月29日）
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