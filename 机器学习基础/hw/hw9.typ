#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= 1
  + 从定义上，不可知 PAC 可学习性要求样本下界 $m$ 只依赖 $epsilon, delta$ 不依赖 $h$，而非一致可学习性允许 $m$ 依赖 $h$
  + 可以证明，（采用 $0 - 1$ 损失）$H$ 是非一致可学习的当且仅当可以写成不可知 PAC 可学习的至多可数并，并且存在不是不可知 PAC 可学习，但是一致可学习的 $H$ 
= 2
  根据定义，选取 $C$ 使得：
  $
    abs(H C) = tau_H (m)\
  $
  往证：
  $
    abs(H_1 C) abs(H_2 C) >= abs(H C)
  $
  事实上，可以构造函数：
  $
    funcDef(i, H C, H_1 C times H_2 C, (h_1 dot h_2)|_C, (h_1|_C, h_2|_C))
  $
  同时，它显然是单射，因此上面的结论成立。之后就有：
  $
    abs(H C) <= abs(H_1 C) abs(H_2 C) <= tau_H_1 (m) tau_H_2 (m) 
  $
= 3
  按定义，对于任何 $C$ 满足：
  $
    abs(C) = VCdim(H_1) + VCdim(H_2) + 2
  $
  则有 $(H_1 union H_2)_C != 2^C$。将 $C$ 分割为两部分使得：
  $
    abs(C_1) = VCdim(H_1) + 1, abs(C_2) = VCdim(H_2) + 1
  $
  依定义，存在 $f_1 in 2^C_1, f_2 in 2^C_2$，它们不是 $H_1, H_2$ 的限制，进而考虑：
  $
    f_1 union f_2 := c arrowb ite(c in C_1, f_1(c), f_2(c))
  $
  不难验证，它不可能是 $H_1 union H_2$ 中某个函数的限制（否则再限制到 $C_1$ 或 $C_2$ 上就会得到 $f_1$ 或 $f_2$，与假设矛盾）因此结论成立。