#import "../template.typ": *
#import "@preview/curryst:0.5.0": rule, prooftree
// #show: note.with(
//   title: "李代数",
//   author: "YHTQ",
//   date: datetime.today().display(),
//   logo: none,
//   withChapterNewPage: true,
//   withOutlined: false
// )
#let linearCtx = $Gamma$
#let logicCtx = $italic(L)$
#let linearTerm = $bold("LinearTerm")$
#let logicTerm = $bold("LogicTerm")$
#let proofPrim = $italic("ProofPrim")$
#let typ = $bold("Type")$
#let term = $bold("Term")$
#let metaTerm = $bold("MetaTerm")$
#let xv = $arrow(x)$
#let tv = $arrow(t)$
#let lv = $arrow(l)$

- #linearCtx: Context of linear variables
- #logicCtx: Context of logical variables(terms)
- #typ: types in language($italic("Cap")$ ...)
- #proofPrim : _Meta_ functions with behavior (#typ\* , #logicTerm\*) -> (#typ\* | Error) 
$
  metaTerm &:= forall p: proofPrim, p(linearTerm^star, logicTerm^star) \
  linearTerm &:= ... | <<metaTerm>>
$
#let resultt = $italic("result_t")$
#let resultts = $italic("result_ts")$
=== Typing rule:
$
  prooftree(
    rule(
      Gamma\, xv : tv \; logicCtx tack <<p(xv, lv)>> : tensorProduct_i resultts[i],
      p : proofPrim,
      p(tv, lv) = resultts,
      resultts : typ\*,
      forall i. Gamma\, xv : tv \; logicCtx tack resultts[i] typ,

    )
  )
$