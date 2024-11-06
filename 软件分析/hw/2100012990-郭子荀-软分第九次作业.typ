#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#import "../main.typ": sup
使用强更新时不满足分配性。考虑如下的程序：
```c
int a = 1;
int b = 2;
int c = 3;
int d = 4;
int* pa = &a;
int* pb = &b;
int** paa = &pa;
if (...){
  paa = &pb;
}
else{
  paa = &pa;
  pb = &a;
}
*paa = &a;
```
如果根据条件分支各自更新再合并，则最后 `pb` 只能指向 `a`，然而若先将两个条件分支的状态合并再更新，只能得到 `pb` 指向 `b` 或 `a`

如果使用弱更新，考虑：
#let ba = $bold(a)$
#let bb = $bold(b)$
- `a = &b`: 
  $
  f (V_1 union V_2) = (V_1 union V_2)[ba -> {b}]\
  f(V_1) union f(V_2) = V_1[ba -> {b}] union V_2[ba -> {b}] = (V_1 union V_2)[ba -> {b}]
  $
- `a = b`:
  $
  f (V_1 union V_2) = (V_1 union V_2)[ba -> bb] = (V_1[ba -> bb] union V_2[ba -> bb]) = f(V_1) union f(V_2)
  $
- `a = *b`
  $
    f(V_1 union V_2) = (V_1 union V_2)[ba -> union.big_(v in (V_1 union V_2) bb) v] = (V_1 union V_2)[ba -> union.big_(v in V_1 bb) v union union.big_(v in V_2 bb) v]\
    = V_1 [ba -> union.big_(v in V_1 bb) v] union V_2 [ba -> union.big_(v in V_2 bb) v] = f(V_1) union f(V_2)
  $
- `*a = b`
  $
    f(V_1 union V_2) &= (V_1 union V_2)[v -> (V_1 union V_2)v union (V_1 union V_2) bb "for" v in (V_1 union V_2) ba]\
    &= V_1 union V_2 union emptyset[v -> (V_1 union V_2) bb "for" v in (V_1 union V_2) ba]\
    &= V_1 union V_2 union emptyset[v -> V_1 bb "for" v in (V_1 union V_2) ba] union emptyset[v -> V_2 bb "for" v in V_2 ba]\
    &= V_1 union V_2 union emptyset[v -> V_1 bb "for" v in V_2 ba] union emptyset[v -> V_1 bb "for" v in V_1 ba] \
    &space union emptyset[v -> V_2 bb "for" v in V_1 ba] union emptyset[v -> V_2 bb "for" v in V_1 bb]\
    &= V_1[v -> V_1 v union V_1 bb "for" v in V_1 ba] union V_2[v -> V_1 v union V_2 bb "for" v in V_2 ba] \
    &space union emptyset[v -> V_2 bb "for" v in V_1 ba] union emptyset[v -> V_1 bb "for" v in V_2 bb] supset f(V_1) union f(V_2)
  $
显然最后一个不等式通常无法取等