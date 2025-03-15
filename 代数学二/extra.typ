#import "../template.typ": *
#show: note.with(
  title: "交换代数",
  author: "YHTQ",
  date: none,
  logo: none,
  withChapterNewPage: true
)
= Associated Prime
  #definition[][
    设 $M$ 是 #AModule($A$)，若以下等价条件成立：
    - $M$ 中存在元素使得 $Ann(x) = A quo p$
    - $A quo p$ 嵌入 $M$
    则称 $p$ 是 $M$ 的 associated prime。
  ]
  #example[][
    令 $A = k[x, y], M = (k[x, y])/(y(x, y)) = (k[x, y])/((x y, y^2))$，则有：
    $
      Ann(y e) = (x, y)\
      Ann(x e) = (y) 
    $
    因此 $(y), (x, y)$ 就是两个 associated prime。
  ]
  #lemma[][
    设 $p$ 是 ${Ann(x) | x in M}$ 中的极大元，则 $p$ 是素理想
  ]
  #proof[
    假设 $p$ 是极大的元素且 $p = Ann(x)$，假设 $a in.not p and a b in p$，则：
    $
      a b x = 0\
      a x != 0\
      b in Ann(a x)\
    $
    注意到 $Ann(a x) >= Ann(x)$，而由假设 $Ann(a x) <= Ann(x)$，因此 $Ann(a x) = Ann(x)$，即 $b in Ann(x)$，证毕。
  ]
  #theorem[][
    - 只要 $M$ 非空，$M$ 的 associated prime 就非空
    - 若 $A$ 是诺特的，则 ${b in R | exists a in M, b m = 0} = union.big_(p in Ass(p)) p$
  ]
  #proof[
    - 由上面的引理显然
    - 一方面，$union.big_(p in Ass(p)) p subset {b in R | exists a in M, b m = 0}$ 是显然的。另一方面，对于任何左侧的元素，它都是模中某个元素的 $Ann$，将该 $Ann$ 扩展到极大（诺特保证它还是 $Ann$）就是一个 associated prime 
  ]
  #lemma[][
    设 $A$ 是诺特环，$A$ 是乘性子集，则：
    $
      Ass_A (Inv(S) M) = Ass_(Inv(S) A) (Inv(S) M) = Ass_A (M) union Spec(Inv(S) A)
    $
  ]
  #theorem[][
    - $Ass(M) subset "Supp"(M)$
    - 设 $A$ 诺特，则 $"Supp"(M)$ 的极小元都是 associated prime
  ]
  #proof[
    - 直接局部化即可
    - 前面证明了 $p in Ass(M) <=> p A_p in Ass(M_p)$，因此无妨设 $A$ 是局部环，极大理想是 $p$，然而条件给出 $p$ 是 $"Supp"(M)$ 极小元，因此 $"Supp"(M) = {p}$. 此外，由于 $Ass(p)$ 非空且含于 $"Supp"(M) = {p}$，因此 $Ass(p)$ 只能恰为 ${p}$
  ]
= Regular sequence
  #definition[][
     设 $(x *) : M -> M$ 是单射，则称 $x$ 是 $M-$ regular 的。若序列 $(x_1, x_2, ..., x_n)$ 满足对于任意 $i$:
     $
       x_i 是 M quo autoRVecN(x, i-1) "regular 的"
     $ 
     则称该序列是弱 $M-$ regular 序列。

     若还有 $M quo autoRVecN(x, n) != 0$，则称它是$M-$ regular 序列。
  ]
  #example[][
    - $A = k[x_1, x_2, ..., x_n]$，序列为 $autoRVecN(x, n)$，则 $M := A$ 是 regular 序列，$M := A / (x_1 - 1, x_2 - 1)$ 是弱 regular
    - $A = k[x, y], M = R quo (y)$，则 $(x, y)$ 不是 regular
    - $A = k[x, y], M = (x, y)$，则 $(x, y)$ 不是 regular
  ]
  #lemma[][
    设 $s in R$ 是弱 $M-$ regular 序列，$g : R -> S$，$N$ 是 $AModule(S)$ 且在 $R$ 上平坦，则 $g(s) subset S$ 是弱 $M tensorProduct N -$ regular 序列
  ]
  #proof[
      由于平坦模的张量积保持单射，同时可以证明：
      $
        (M tensorProduct N)/(x_1 (M tensorProduct N)) = N /(x_1 M tensorProduct N)
      $
      依次进行即可。
  ]
  #corollary[][
    - 局部化保持弱 regular 序列
    - 若 $"xs"$ 是弱 $M -$ regular 序列 $p in "Supp"(M), "xs" subset p, M$ 是有限 $R$ 模，则 xs 是 $M_p -$ regular 序列
    - 设 $R$ 是局部环，xs 是 $M -$ regular 序列，则 xs 是 $hat(M_m) -$ regular 序列
  ]
  #proof[
    - 显然
    - 利用 Nakayama 引理即可
  ]
  #theorem[][
    设 $R$ 是局部环，$M$ 有限，则 $M-$ Regular 在换序下保持。
  ]
  #proof[
    只需证明 $x_1, x_2$ 和 $x_2, x_1$ 有等价的正规性即可：借用蛇引理进行计算。
  ]
  #lemma[][
    设有正合列 $0 -> M_1 -> M_2 -> M_3 -> 0$，则：
    - xs $M_1, M_3-$(week) regular 则 xs $M_2-$(week) regular
    - xs $M_2, M_3-$week regular 则 xs $M_1-$(regular)
  ]
  #lemma[][
    假设 $autoRVecN(x, n)$ 是 $M-$ regular 序列，则 $autoRVecNF(#(n => $x_#n^(p_#n)$), n)$ 也是
  ]
= Depth
  在上一节中，注意到假设 $x_1 in (x_1)$，当然不可能有 $(x_1, x_2)$ 是非零模的 regular sequence. 我们总是希望这样的序列尽可能长
  #definition[][
    称一个 $M-$ regular 序列 $autoRVecN(x, n)$ 是极大的，如果不能再添加任何一个元素（属于某个理想 $I$）使得它仍然是 $M-$ regular 序列 
  ]
  #theorem[][
    设 $R$ 诺特，$M$ 有限，$T$ 是理想且 $I M != M$，设 $n : ZZ > 0$，则下列说法等价：
    - 存在一个长度为 $n$ 的 $M-$ regular 序列
    - $Ext_R^i (N, M) = 0, forall i < n$ 且 $N$ 是有限生成模，满足 $"Supp"(N) = V(I)$
    - $Ext^i_R (R quo I, M) = 0 forall i < n$
    - 存在有限生成模 $N$ 使得 $"Supp"(N) = V(I)$
  ]
  #definition[][
    所有 $I$ 中极大的 $M-$ regular 序列长度相同，将其称为 $M$ 的深度
  ]
  