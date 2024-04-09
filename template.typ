// 参考 https://github.com/Fr4nk1in-USTC/typst-notebook

//#import "typst-sympy-calculator.typ": *

#import "@preview/lemmify:0.1.4": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram
#let (
  theorem, lemma, corollary,
  remark, proposition, example, definition,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "en")
#let (answer) = default-theorems("thm-group-a", lang: "en")
$1 + 1$
#let TODO = [#text("TODO", fill: red)]
#let der(y, x) = $(d #y) / (d #x)$
#let partialDer(y, x) = $(diff #y) / (diff #x)$
#let elasticity(P, Q) = $((diff #Q)/(diff #P))/(#Q / #P)$
#let autoVec3(a, delim: "(" ) = $vec(#a _1, #a _2, #a _3, delim: delim)$
#let autoVecN(a, n, delim: "(" ) = $vec(#a _1, #a _2,  dots.v, #a _#n, delim: delim)$
#let autoMat3(delim: "(", ..var) = {
  let varList = var.pos()
  let row(n) = varList.map(v => $#v _#n$)
  let data = (row(1), row(2), row(3))
  math.mat(delim: delim, ..data)
}
#let where = "where"
#let with = "with"
#let inner(x, y) = $<#x, #y>$
#let Gal = math.op("Gal")
#let HomoCoor = math.vec.with(delim: "[")
#let autoHomoCoor3 = autoVec3.with(delim: "[")
#let Det(arr) = mat(delim: "|", ..arr)
#let Hom = math.op("Hom")
#let Proj = math.op("Proj")
#let Spec = math.op("Spec")
#let Tor = math.op("Tor")
#let Ann = math.op("Ann")
#let Ass = math.op("Ass")
#let Sylow(p) = $"Sylow"-#p$
#let Isom = math.op("Isom")
#let directLimit = $limits(lim)_(arrow.long)$
#let GL = math.op("GL")
#let char = math.op("char")
#let Frac = math.op("Frac")
#let Inv(a) = $#a^(-1)$
#let conjugateLeft(g, a) = $#g^(-1) #a #g$
#let conjugateRight(g, a) = $#g #a #g^(-1)$
#let quotient(G, H) = $#G\\#H$
#let lift = math.arrow.t
#let quo = math.class("relation", $\/$)
#let ord = math.op("ord")
#let sgn = math.op("sgn")
#let lcm = math.op("lcm")
#let Arg = math.op("Arg")
#let End = math.op("End")
#let ReT = math.op("Re")
#let ImT = math.op("Im")
#let argmax = math.op("argmax")
#let argmin = math.op("argmin")
#let incrementSign(x, i, k) = {
  let i1 = int(i)
  if i1 = 0 {
    $#x_#k$
  }
  else {
      $#x_#(i + k)$
  }
}
#let emptyArrow(s, e) = arr(str(s), str(e), $$)
#let coker = math.op("coker")
#let coim = math.op("coim")
#let Ad1(x, G) = $"Ad"_#G (#x)$
#let Ad = math.op("Ad")
#let Aut = math.op("Aut")
#let algClosure(F) = $#F^"alg"$
#let inverseLimit(n) = $lim_(arrow.l.long_#n)$
#let AModule(A) = [$#A -$模]
#let GEquiv(G) = {
  $#G -$ 
  "等变"
}
#let Mod = math.op("Mod")
#let tensorProduct = math.times.circle
#let directSum = math.plus.circle
#let generatedBy(body) = $angle.l #body angle.r$
#let normalSub(H, G) = $#H lt.tri.eq #G$
#let norS = math.class("relation", math.lt.tri.eq)
#let semiProd = math.class("relation", math.times.r)
#let diam = math.op("diam")
//#let quot = math.class("relation", $\/$)
#let Stab = math.op("Stab")
#let Orb = math.op("Orb")
#let existsST(var, condition) = $exists #var space s.t. space #condition$
#let forallSa(var, condition) = $forall #var space , space #condition$
#let funcDef(f, A, B, x, fx) = $#f: space #A &-> #B \ #x &|-> #fx$
#let seqLimit(n) = $lim_(#n -> +infinity)$
#let seqLimitn = $seqLimit(n)$
#let inj_str = "inj"
#let surj_str = "surj"
#let bij_str = "bij"
#let fourierTrans(f) = $hat(#f)$
#let def_str = "def"
#let nat_str = "nat"
// Theorem and definition environments.
#let base_env(type: "Theorem", numbered: true, fg: black, bg: white,
          name, body) = locate(
    location => {
      let lvl = counter(heading).at(location)
      let top = if lvl.len() > 0 { lvl.first() } else { 0 }
      let i = counter(type + str(top)).at(location).first()
      // show: block.with(spacing: 11.5pt)
      // stack(
      //   dir: ttb,
      //   rect(fill: fg, radius: (top-right: 5pt), stroke: fg)[
      //     #strong(
      //       text(white)[
      //         #type
      //         #if numbered {
      //           counter(type).step()
      //           [ #top.#(i+1).]
      //         }
      //         #if name != none [ (#name) ]
      //       ]
      //     )
      //   ],
      //   rect(width: 100%,
      //     fill: bg,
      //     radius: ( right: 5pt ),
      //     stroke: (
      //       left: fg,
      //       right: bg + 0pt,
      //       top: bg + 0pt,
      //       bottom: bg + 0pt,
      //     )
      //   )[
      //     #emph(body)
      //   ]
      // )
      parbreak()
      strong($#type
      #if numbered {
        counter(type + str(top)).step()
        if top > 0{
          [ #top.#(i+1).]
        }
        else{
          [ #(i+1).]
        }
        
      }
      $)
      $#if name != [] [ 
        (#name)
      ]$
      set enum(numbering: "1)")
      " " 
      body
      // if name != none {
      //   label(name)
      // }
      parbreak()
    }
  )
#let noneNameChecker(name) = {
  if name == [] {
    none
  }
  else {
    name
}
}
#let theo = theorem
#let lem = lemma
#let cor = corollary
#let prop = proposition
#let def = definition
#let ex = example
#let rem = remark
#let pr = proof
#let _convert(f, name, body) = f(name: noneNameChecker(name))[
  #body
  #parbreak()
  ]
#let theorem(name, body) = _convert(theo, name, body)
#let lemma(name, body) = _convert(lem, name, body)
#let corollary(name, body) = _convert(cor, name, body)
#let proposition(name, body) = _convert(prop, name, body)
#let definition(name, body) = _convert(def, name, body)
#let example(name, body) = _convert(ex, name, body)
#let remark(name, body) = _convert(rem, name, body)
#let proof(body) = [#pr[
  #set text(size: 10pt)
  #body
]
  #linebreak()
]
#let lemma1 = lem.with(
  numbering: none
)
//#let theorem = base_env.with(
//  type: "Theorem",
//  fg: blue,
//  bg: rgb("#e8e8f8"),
//)
//
//#let proposition = base_env.with(
//  type: "Proposition",
//  fg: blue,
//  bg: rgb("#e8e8f8"),
//)
//
//#let example = base_env.with(
//  type: "Example",
//  fg: orange,
//  bg: rgb("#f8e8e8"),
//)
//#let definition = base_env.with(
//  type: "Definition",
//  fg: orange,
//  bg: rgb("#f8e8e8"),
//)
//
//#let lemma = base_env.with(
//  type: "Lemma",
//  fg: purple,
//  bg: rgb("#efe6ff"),
//)
//
//#let corollary = base_env.with(
//  type: "Corollary",
//  fg: green,
//  bg: rgb("#e8f8e8"),
//)
//#let equationNumber = locate(
//  location => {
//    let lvl = counter(heading).at(location)
//    let i = counter("equation_number").at(location).first()
//    let top = if lvl.len() > 0 { lvl.first() } else { 0 }
//        counter("equation_number").step()
//        align(end)[(#top.#(i+1))]
//  }
//)
// Proof environment
//#let proof(body) = block(spacing: 11.5pt, {
//  set enum(numbering: "Step 1.1.")
//  emph[Proof.]
//  [ ] + body
//  linebreak()
//  h(1fr)
//  box(scale(160%, origin: bottom + right, sym.square.stroked))
//})
//#let answer(body) = block(spacing: 11.5pt, {
//  set enum(numbering: "Step 1.1.")
//  body
//  linebreak()
//  h(1fr)
//  box(scale(160%, origin: bottom + right, sym.square.stroked))
//})
#let my-ans-style(
  thm-type, name, number, body
) = block(spacing: 11.5pt, {
  set enum(numbering: "Step 1.1.")
  body
  linebreak()
  h(1fr)
  box(scale(160%, origin: bottom + right, sym.square.stroked))
})
#let my-styling = (
  thm-styling: my-ans-style
)
#let (answer, rules:ans-rules) = new-theorems("thm-ans", ("answer": "Answer"), ..my-styling)

#let note(title: "Note title", author: "Name", logo: none, date: none,
          preface: none, code_with_line_number: true, withOutlined: true, withTitle: true, body) = {
  // Set the document's basic properties.
  set document(author: (author, ), title: title)
  set page(
    numbering: "1",
    number-align: end,
    // Running header.
    header-ascent: 14pt,
    header: locate(loc => {
      let i = counter(page).at(loc).first()
      if i == 1 { return }
      set text(size: 8pt)
      if calc.odd(i) { align(end, title) } else { align(start, title) }
    }),
  )
  set text(font: "Noto Serif CJK SC", lang: "zh")
  show emph: it => {
    text(it, weight: "bold")
  }
  show: thm-rules
  show: ans-rules
  show math.equation: set text(font: ("Noto Serif CJK SC", "New Computer Modern Math"))
  set math.equation(numbering: "(1)")
  // set ref(supplement: it => {
  // let eq = math.equation
  // let el = it
  // if el.func() == heading {
  //   "章节"
  // } else if el.func() == eq {
  //   "式"
  // } else {
  //   ""
  // }
  //}
  // )
  // Set paragraph spacing.
  show par: set block(above: 1.2em, below: 1.2em)

  if withTitle{
    // Title page.
    // The page can contain a logo if you pass one with `logo: "logo.png"`.
    v(0.6fr)
    if logo != none {
      align(right, image(logo, width: 26%))
    }
    v(9.6fr)
      text(1.1em, date)
      v(1.2em, weak: true)
      text(2em, weight: 700, title)

      // Author information.
      pad(
        top: 0.7em,
        right: 20%,
        align(start, author)
      )
    v(2.4fr)
    pagebreak()
    if withOutlined {
    if preface != none {
        [
          = Preface
        ]

        preface
        pagebreak()

        // Table of contents
        [
          = Contents
        ]

        outline(title: none, depth: 3, indent: true)
      } else {
        outline(depth: 3, indent: true)
      }

      pagebreak()
    }
  }


  // Main body
  set par(justify: true, first-line-indent: 22pt)

  set heading(numbering: "1.")

  // Code
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )

  // Code block with line numbers
  show raw.where(block: true): it => {
    if not code_with_line_number { return it }
    let lines = it.text.split("\n")
    let length = lines.len()
    let i = 0
    let left_str = while i < length {
      i = i + 1
      str(i) + "\n"
    }
    grid(
      columns: (auto, 1fr),
      align(
        right,
        block(
          inset: (
            top: 10pt,
            bottom: 10pt,
            left: 0pt,
            right: 5pt
          ),
          left_str
        )
      ),
      align(left, it),
    )
  }

  body
}
