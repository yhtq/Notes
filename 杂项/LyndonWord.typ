#import "../template.typ": *
#show: note.with(
  title: "李代数",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
=
  #definition[][
    设 $K$ 是一个域，$A$ 是有限集合，$L(A)$ 是生成的自由李代数。可记 $M(A)$ 为所有可能的单项式，称为 Magma，例如：
    $
      [[x, y], [x, [y, z]]]
    $
  ]
  一个好的 Magma 的子集应该可以构成 $L(A)$ 的一个基。
  #definition[Hull Set][
    称 $H subset M(A)$ 是一个 Hull set，如果：
    - $H$ 上有全序
    - $A subset H$
    - 对于任何表达式树 $h = (h', h'') in H \\ A$，都有 $h'' in H$ 以及 $h < h''$
    - 对于任何表达式树 $h = (h', h'') in M(A) \\ A$，有：
      $
        h in H <=> h', h'' in H and h' < h'' and (h' in A or (h' = (x, y) and y >= h'))
      $
  ]
  #theorem[][
    Hull set 存在
  ]
  #proof[
    在 $M(A)$ 上定义全序关系，使得对于 $t = (t', t'')$ 都有 $t < t''$. 
  ]
  #theorem[][
    Hull set 是一个基
  ]
  #definition[][
    若 $A$ 上有序，称一个 word $w$ 是 Lyndon word，如果 $w = u v => (u != 1, v != 1 => w < v)$ 
  ]
  #theorem[][
    设 $w$ 是 Lyndon word, $w = u v$ 满足上面的条件且 $v$ 是最长的，则 $w$ 对应唯一一个 Hull tree $h(w)$. $h({"Lyndon word"})$ 是一个 Hull set.
  ]
