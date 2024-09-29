#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业12",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1.
  将三个抽象域分别记作：
  #let termPP = ``` term{x > 0} ```
  #let termP = ``` term{x >= 0} ```
  #let termN = ``` term{x < 0} ```
  #let term = ``` term ```
  - 自然数：#termP
  - 负数：#termN
  - 未知：#term
  则加法计算规则包括：
  - $termP + termP: termP$
  - $termN + termN: termN$
  - $termP + termN: term$
  - $termN + termP: term$
  - $\_ + term: term$
  - $term + \_: term$
  乘法规则包括：
  - $termP * termP: termP$
  - $termN * termN: termP$
  - $termP * termN: term$
  - $termN * termP: term$
  - $\_ * term: term$
  - $term * \_: term$
  考虑 $3 * (-3) = -9$，在该抽象域下只能得到：
  $
  (3: termP) * (-3: termN) = -9: term
  $
  然而事实上在更精确的抽象域下可以得到：
  $
  (3: termPP) * (-3: termN) = -9: termN
  $