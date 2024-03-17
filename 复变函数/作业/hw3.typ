#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, seqLimit, seqLimitn
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业2",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
#set heading(numbering: none)
（应交时间为3月22日）
= p33
  == 6
    === (a)
      $
      R = seqLimitn norm(a^n/a^(n+1)) = norm(1/a)
      $
    === (b)
      $
      R = seqLimitn norm(a^(n^2)/a^((n+1)^2)) = seqLimitn norm(1/a^(2 n + 1)) 
      $
      - 当 $norm(a) < 1$ 时上式给出 $+infinity$
      - 当 $norm(a) = 1$ 时上式给出 $1$
      - 当 $norm(a) > 1$ 时上式给出 $0$
    === (c)
      似乎和 (a) 没有区别也是 $norm(1/k)$
    === (d)
      $
      1/R = limsup_(n -> +infinity) norm(a_n)^(1/n) = seqLimitn norm(1)^(1/(n!)) = 1 => R = 1
      $
  == 7
    首先计算：
    $
    1/R = limsup_(n -> +infinity) norm(a_n)^(1/n) = seqLimitn norm((-1)^n/n)^(1/(n(n+1))) \
    = seqLimitn 1/n^(1/(n(n+1)))
    $
    另一方面：
    $
    seqLimitn n^(1/(n(n+1))) = seqLimitn e^(1/(n(n+1)) ln n) = e^0 = 1
    $
    因此 $R = 1$

    其次：
    - $z = 1$ 时序列为：
      $
      sum_(n=1)^infinity (-1)^n/n 
      $
      由莱布尼茨判别法知收敛
    - $z = -1$ 时，注意到 $n(n+1)$ 总是偶数，因此 $z^(n(n+1)) = 1$，结果与上面相同
    - $z = i$ 时，考虑：
      $
      n(n+1) = cases(
        0 mod 4 quad n = 0 mod 4,
        2 mod 4 quad n = 1 mod 4,
        2 mod 4 quad n = 2 mod 4,
        0 mod 4 quad n = 3 mod 4
      )\
      i^(n(n+1)) = cases(
        1 quad n = 0 mod 4,
        -1 quad n = 1 mod 4,
        -1 quad n = 2 mod 4,
        1 quad n = 3 mod 4
      )\
      (-1)^n i^(n(n+1)) = cases(
        1 quad n = 0 mod 4,
        1 quad n = 1 mod 4,
        -1 quad n = 2 mod 4,
        -1 quad n = 3 mod 4
      )
      $
      原序列为：
      $
      sum_(n = 1)^(infinity) (-1)^n i^(n(n+1)) 1/n
      $
      注意到这是实数序列，由狄利克雷判别法可知级数收敛
= p44 13
  取 $g(z) = log z$（对数函数的主分支），则：
  $
  (f(z))^n = e^(log z)\
  (f(z)/(e^(1/n log z)))^n = 1
  $
  注意到 $z^n = 1$ 只有 $n$ 个离散的解 $xi_k = e^(k/n 2 pi i)$，而 $f(z)/(e^(1/n log z))$ 是连通开集上的解析函数，其值域离散蕴含着各点处导数均为零，进而是常函数\
  故一定有：
  $
  f(z) = e^(1/n log z + 2 pi i k/n), forall k = 0, 1, 2, ..., n - 1
  $
  这就是满足条件的所有函数