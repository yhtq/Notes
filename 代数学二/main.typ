#import "../template.typ": note
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "代数学二",
  author: "YHTQ",
  date: none,
  logo: none,
  withChapterNewPage: true
)
// 由于 commute 库的问题，暂时只能在 typst 0.12 版本编译
#include "章节/上半学期.typ"
#include "章节/下半学期.typ"