#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#let Gal = $G a l$
#set heading(numbering: none)
（应交时间为3月29日）
= p55
  == 8
    题设表明对于任意 $z in RR^infinity$，有：
    $
    (a z + b)/(c z + d) = (overline(a) z + overline(b))/(overline(c) z + overline(d)) = ((a + overline(a))z + (b + overline(b)))/((c + overline(c))z + (d + overline(d)))
    $
    令：
    $
    T'(z) = ((a + overline(a))z + (b + overline(b)))/((c + overline(c))z + (d + overline(d)))
    $
    上式表明在 $RR^infinity$ 上均有 $T = T'$，而分式线性变换只需三点便可确定，进而 $T= T'$
    
    注意这里莫比乌斯变换由三点唯一确定是熟知的，而考虑包括退化情况同样也可被三点确定。事实上，若设 $T$ 是退化的，也即：
    $
    T = c
    $ 
    应当有：
    $
    (a' z_i + b')/(c' z_i + d') = c, i = 1, 2, 3
    $
    假设上式左侧不退化，$z_i$ 将成为同一个一次方程的三个不同零点——这是荒谬的
  == 15
    取：
    $
    f(z) = (z-1)/(1+z)
    $
    它将开圆盘映成左半平面\
    因此：
    $
    e^(f(z))
    $
    将开圆盘映成 ${z:0 < abs(z) < 1}$
    $
    1/(z^2 - 1) = k\
    z^2 = 1 + 1/k
    $
  = 25
    #lemmaLinear[][
      非平凡莫比乌斯变换 $S, T$ 交换当且仅当有相同的不动点
    ]
    #proof[
      讨论 $S$ 的不动点数量
      - 设它有两个不动点，且 $S' = Inv(h) S h$ 的不动点恰为 $0, infinity$，则令 $T' = Inv(h) T h$
        此时，可设：
        $
        S' = k z,
        T' = (a z + b)/(c z + d)
        $
        - 若两者可交换，由 $S' T' = T' S'$ 得：
          $
          (a k z + b)/(c k z + d) = (a k z + b k)/(c z + d)\
          (a k z + b)(c z + d) = (a k z + b k)(c k z + d)
          $
          观察二次项系数，可得：
          $
          a k c = a c k^2
          $
          由于 $k != 0, 1$，上式给出 $a c = 0$\
          观察常数项系数，有：
          $
          b d = b k d => b d =0
          $
          观察一次项系数，有：
          $
          a k d + b c = a k d + b c k^2 => b c= 0
          $
          注意到 $a b$ 不同时为零，因此 $c = 0$，继而 $d != 0, b = 0$，故：
          $
          T' = a/d z
          $
          这表明 $T'$ 的不动点也为 $0, infinity$\
        反之，若 $T'$ 的不动点也为 $0, infinity$，则可设 $T' = g z$ ，它们当然可交换
      - 若 $S$ 有一个不动点，且 $S' = Inv(h) S h$ 的不动点恰为 $infinity$，则令 $T' = Inv(h) T h$
        此时，可设：
        $
        S' = z + k\
        T' = (a z + b)/(c z + d)
        $
        - 若两者可交换，由 $S' T' = T' S'$ 得：
          $
          (a z + b + a k)/(c z + d + c k) = (a z + b )/(c z + d) + k = ((a + k c) z + b + k d )/(c z + d)
          $
          将有：
          $
          a c = a c + k c^2 => k c^2 = 0 => c = 0\
          d(b + a k) =d (b + k d) => k d^2 = a k d => d = a\
          $
          因此 $T' = z + b / d$，不动点恰为 $infinity$\
        - 反之，若 $T'$ 的不动点也为 $infinity$，则可设 $T' = z + k'$ ，它们当然可交换
      证毕
    ]
    前面的习题说明了两个莫比乌斯变换交换当且仅当有相同的不动点，从而对于任何一个交换子群，其中的元素应该有相同的不动点。
    通过适当的共轭（这是群自同构，不改变交换性），我们可以假设共同的不动点是：
    - $0, infinity$，这表明整个子群中的元素都形如 $a z$，该群同构于 $ZZ^*$
    - $infinity$，表明整个子群中的元素都是 $z + b$，同构于 $ZZ^+$
    换言之，所有的交换子群恰为以上两群的所有子群对应的所有共轭类