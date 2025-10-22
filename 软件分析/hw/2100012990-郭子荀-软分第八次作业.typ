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
= 1
  #image("./屏幕截图 2024-11-02 130524.png")
  为了画图方便，这里做了一些简化：
  - 为了看起来更清晰将 `x` 与 `ret` 的符号分开画了，事实上的可达性是合并的，也即两个状态可达当且仅当 `x` 与 `ret` 都可达。
  - 用加粗黑线表示传递所有状态，即：
    $
      + -> +\
      - -> -\
      0 -> 0\
    $
  - 用加粗红线表示状态全连接，即：
    $
      + -> +\
      + -> -\
      + -> 0\
      - -> +\
      - -> -\
      - -> 0\
      0 -> +\
      0 -> -\
      0 -> 0\
    $
  对于第二个问题，注意到事实上在该程序中，调用的上下文完全由调用位置决定，与第几次调用无关，因此只要取 $k = 1$，就不会产生任何不可能的路径，进而分析是准确的。
= 2
  #let gen = "gen"
  #let kill = "kill"
  我们有：
  $
    f_2 compose f_1 (x) &= (gen_2 union (gen_1 - kill_2)) union (x - (kill_1 union kill_2))\
    f_1 sup f_2 (x) 
    &= (gen_1 union (x - kill_1)) inter (gen_2 union (x - kill_2))\
    &= (gen_1 inter gen_2) union (x - ((kill_1 - gen_2^C) union (kill_2 - gen_1^C)))
  $
  因此仍可用二元组表示函数，并且有：
  $
    (gen_2, kill_2) compose (gen_1, kill_1) &= (gen_2 union (gen_1 - kill_2), kill_1 union kill_2)\
    (gen_1, kill_1) sup (gen_2, kill_2) &= (gen_1 inter gen_2, (kill_1 - gen_2^C) union (kill_2 - gen_1^C))
  $
  