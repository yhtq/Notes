#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec, AModule, lemmaLinear[], tensorProduct, directSum, directLimit
#import "../../template.typ": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
)
（应交时间为4月16日）
#let Supp = math.op("Supp")
#set heading(numbering: none)
= p78
  == 1
    === i
      注意到有递增子模链：
      $
      ker mu <= ker mu^2 <= ... <= ker mu^n <= ...
      $
      由条件知最终将稳定，可设 $ker mu^n = ker mu^(n+1)$，因此：
      $
      mu^(n+1) (m) = 0 <=> mu (mu^n (m)) = 0 <=> mu^n (m) = 0
      $
      然而 $mu$ 是满射，$mu^n$ 也是，进而上式表明 $ker mu = 0$，证毕
    === ii
      注意到有递降子模链：
      $
      M >= im mu >= im mu^2 >= ... >= im mu^n >= ...
      $
      由条件知最终稳定，可设 $im mu^n = im mu^(n+1) := M'$\
      然而注意到：
      $
      im mu^n = mu(im mu^(n-1)) \
      im mu^n = im mu^(n+1) = mu(im mu^(n))\
      mu(im mu^(n-1)) = mu(im mu^(n)) => im mu^(n-1) = im mu^n
      $
      （最后利用了 $mu$ 是单射）\
      这表明 $n$ 可以一直降低，最终说明 $im mu = M$，证毕
  == 2
    对 $M$ 的任意子模 $M'$，设：
    $
    Sigma = {M'' subset M' | M'' "是有限生成子模"}
    $
    条件表明它将有极大元。设极大元为 $M''$，然而往有限生成模中扩充任何元素都还是有限生成的，因此 $M''$ 只能为 $M'$，表明 $M$ 的所有子模都有限生成
  == 3
    由熟知的同构：
    $
    M quo N_1 times M quo N_2  tilde.eq M quo N_1 sect N_2 
    $
    及有限直积保持 Noether/Artin 知结论成立
  == 4
    此时必有 $M$ 有限生成，进而可设 $M = sum_i A x_i$，有：
    $
    Ann(M) = sect_i Ann(x_i)\
    A quo Ann(M) tilde.eq product_i A quo Ann(x_i) tilde.eq product_i A x_i
    $  
    而 $A x_i$ 作为 Noether 模的子模有限生成，进而 $A quo Ann(x_i)$ 作为有限 $A-$代数是 Noether 的，作为环也是，由上题结论知结果成立

    若 $M$ 是 Artin 的，结果当然未必，例如设 $p$ 是素数，则 $ZZ[1/p] quo ZZ$ 作为 $ZZ$ 模 Artin，并且没有非零零化子，但 $ZZ$ 不是 Artin 的
  == 5
    注意到子空间 $Y$ 中开集均形如 $A sect Y$，其中 $A$ 是 $Y$ 中开集，当然将满足升链条件。

    为了证明拟紧，任取一族开覆盖 $union E = X$，考虑：
    $
    Sigma = {union E' | E' "是" E "的有限子集"}
    $
    $sigma$ 将是开集族，由升链条件，$Sigma$ 有极大元 $E'$，容易验证 $union E' = X$，否则可以再添加一个点的覆盖到 $E'$ 使得覆盖的空间更大，与极大性矛盾
  == 6
    == i) $=>$ iii)
      已经证明每个子空间都 Noether，而 Noether 空间都拟紧，因此结论成立
    == iii) $=>$ ii)
      显然
    == ii) $=>$ i)
      任取开集的升链：
      $
      A_1 <= A_2 <= ... <= A_n <= ...
      $
      则 ${A_i}$ 构成开子空间 $union_i A_i$ 的开覆盖，将有有限开覆盖。由于这族开集是全序的，相当于只需一个 $A_n$ 即可覆盖，蕴含 $A_m = A_n, forall m >= n$，证毕
  == 7
    设 $Sigma$ 为所有不能写成有限个不可约分支的并的闭子空间，注意到这是一族闭集，假设它非空，由降链条件存在极小元 $Y$。\
    显然 $Y$ 不是空集，任选 $x in Y$ 以及包含它的不可约分支 $Gamma subset Y$，则 $Y - Gamma$ 可写成有限个不可约分支的并，继而再加上 $Gamma$ 便将 $Y$ 写成了有限个不可约分支的并，矛盾！\
    因此原集合是空集

    进一步，设 $X = union_i X_i$，任取其中一个不可约分支 $C$，将有：
    $
    C = union_i (C sect X_i)
    $
    然而 $C$ 不能写成其中有限个非空闭集的并，继而：
    $
    exists i, C = C sect X_i
    $
    再由极大性，$C = X_i$，证毕
  == 8
    显然 $Spec(A)$ 中闭集都是 $V(alpha), alpha$ 是环中理想。理想的升链条件将导出闭集的降链条件，因此 $Spec(A)$ 是 Noether 的

    反面不成立，例如令 $A = QQ[x_1, x_2, ..., x_n, ...] quo (x_1^2, x_2^2, ..., x_n^2, ...)$，注意到它当然不是 Noether 环，同时 $Spec(A)$ 同胚于 $Spec(A quo Re)$\
    但另一方面，$A$ 中所有不是单位的元素都幂零，因此 $A quo Re tilde.eq QQ$ 是域，素谱是单点集，当然是 Noether 空间
  == 9
    前面已经证明了极小素理想与不可约分支的一一对应，因此结论成立
  == 10
    熟知 Noether 模有限生成，此时有：
    $
    Supp(M) = V(Ann(M))
    $
    因此确实是闭集，只需验证其中降链条件。事实上，若存在其中无穷下降的闭集链：
    $
    V(Ann(M)) := V(I_0) > V(I_1) > ... > V(I_n) > ...
    $
    当然有 $Ann(M) := I_0 < I_1 < ... < I_n$\
    此时，将有上升的子模链：
    $
    0 = I_0 M <= I_1 M <= ... <= I_n M <= ...
    $
    注意到：
    $
    Supp(M quo I_n M) = V(I_n + Ann(M)) = V(I_n) 
    $
    因此 
    $
    I_n = I_(n+1) => Supp(M quo I_n M) = Supp(M quo I_(n+1) M) => V(I_n) = V(I_(n+1))
    $
    从而子模升链中每项严格上升，与 Noether 模条件矛盾！
    