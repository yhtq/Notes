#import "../template.typ": *
#import "章节/群论.typ": *
#import "章节/环.typ": *
#import "章节/模、域.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "抽象代数/代数学基础",
  author: "YHTQ",
  date: none,
  logo: none,
)
// #let theorem(narration, pr`:oof) = :q#box[
//   *定理*：narration\
//   *证明*：proof
// ]
#chapterGroup
#chapterTwo
#chapterThree

