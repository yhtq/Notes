#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业5",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= #empty
  #let Inv(f, ori, res) = $"Inv"(#f\;#ori\;#res)$
  #let bT = $bold("True")$
  #let bF = $bold("False")$
  #let T = $"True"$
  #let F = $"False"$
  用 $[a, b]$ 表示一个整数区间，布尔值的抽象域为 ${bot, bT, bF, top}$ ，（真实值记为 $#T, #F$），$Inv(f, "ori", "res")$ 表示运算 $f$ 在参数初始状态为 ori ，运算结果为 res 时的反向语义。$\_$ 表示任意抽象值，规则按照从上到下匹配。
  == 逻辑与
    - $Inv(and, (\_, \_), bot) = (bot, bot)$
    - $Inv(and, (\_, \_), bT) = (bT, bT)$
    // - $Inv(and, (bT, x), bT) = (bT, x)$
    // - $Inv(and, (x, bT), bT) = (x, bT)$
    - $Inv(and, (bT, \_), bF) = (bT, bF)$
    - $Inv(and, (\_, bT), bF) = (bF, bT)$
    - $Inv(and, (bot, bot), bF "or" top) = (top, top)$
    - $Inv(and, (bot, x), bF "or" top) = (top, x)$
    - $Inv(and, (x, bot), bF "or" top) = (x, top)$
    - $Inv(and, (x, y), bF "or" top) = (x, y)$
  == 逻辑非
    - $Inv(not, \_, bot) = (bot, bot)$
    - $Inv(not, \_, bT) = (bF)$
    - $Inv(not, \_, bF) = (bT)$
    - $Inv(not, bot, top) = (top)$
    - $Inv(not, x, top) = (x)$
  == 大于
    - $Inv(>, ([\_, \_], [\_, \_]), bot) = ([-infinity, infinity], [-infinity, infinity])$
    - $Inv(>, ([a, b], [c, d]), bT) = ([max(a, c + 1), b], [c, min(b - 1, d)])$
    - $Inv(>, ([a, b], [c, d]), bF) = ([a, min(b, d)], [max(a, c), b])$
    - $Inv(>, ([a, b], [c, d]), top) = ([a, b], [c, d])$
  == 加法
    - $Inv(+, ([\_, \_], [\_, \_]), bot) = ([-infinity, infinity], [-infinity, infinity])$
    - $Inv(+, ([a, b], [c, d]), [e, f]) = ([max(a, e - d), min(b, f - c)], [max(c, e - b), min(d, f - a)])$
  对于表达式：
  $
  (x >= 0) and (x >= 1 + y) and (y >= 1 + x) = #T 
  $
  （假设对于三个表达式从右向左更新）
  - 第一轮结束：$(x, y): ([0, +infinity], [-infinity, +infinity])$
  - 第二轮结束：$(x, y): ([2, +infinity], [1, +infinity])$
  - 第三轮结束：$(x, y): ([4, +infinity], [3, +infinity])$
  - ......
  迭代过程将无法终止。不过，上面的反向语义是单调的，同时若假设表达式是可满足的，则半格的高度将有限。具体而言，布尔值的半格当然是有限的，而对于任意变量 $X$，假设 $x$ 是一个可以使表达式成立的真实值，在算法的运行过程中，要么 $X$ 的下界为 $-infinity$，要么在某一轮被更新为某个值 $X_m$，由单调性，算法过程中下界将不会小于 $X_m$。同时，由算法的安全性，$X$ 的下界也不大于 $x$，因此 $X$ 下界的可能值是有限的，上界同理，从而 $X$ 的区间也是有限半格。
= #empty
  ```c
  x = 1;  // x: [1, 1]
  while (x < 100) 
  {
    // 第一次进入 x: [1, 1]
    // 第二次进入 [2, 2] 与原值 [1, 1] 加宽合并，再与 [1, 1] 取并得到 x: [1, +infinity] 
    // 第三次进入 [2, 100] 与原值 [1, +infinity] 加宽合并，再与 [1, 1] 取并得到 x: [1, +infinity]，若不变窄则算法收敛
    // 若使用变窄算法，第四次进入 [2, 100] 与 [1, 1] 取并得到 x: [1, 100]
    // 若使用变窄算法，第五次进入 [2, 100] 与 [1, 1] 取并得到 x: [1, 100]，算法收敛
    assert(x < 100);
    // 第一次进入 x: [1, 1]
    // 第二次进入将 [1, +infinity] 压缩到 [1, 99]
    // 若使用变窄算法，第三次进入将 [1, +infinity] 压缩到 [1, 99]
    // 若使用变窄算法，第四次进入将 [1, 100] 压缩到 [1, 99]
    x++;  
    // 第一次进入 x: [2, 2]
    // 第二次进入 x: [2, 100]
    // 若使用变窄算法，第三次进入 x: [2, 100]
    // 若使用变窄算法，第四次进入 x: [2, 100]
  }
  skip;
  ```

