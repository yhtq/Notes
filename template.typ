// 参考 https://github.com/Fr4nk1in-USTC/typst-notebook

//#import "typst-sympy-calculator.typ": *

#import "@preview/lemmify:0.1.6": *
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#let __print_commute = true
#let old-commutative-diagram = commutative-diagram
#let en-font = "New Computer Modern"
#let commutative-diagram(print: __print_commute, ..args) = {
  if print {
    old-commutative-diagram(..args)
  }
  else {
    align(center)[
      #text(style: "italic", font: "New Computer Modern")[
        _Commutative diagram_
      ]
    ]
  }
}
#let TODO = [#text("TODO", fill: red, font: en-font)]
#let _der(y, x, times, sign) = {
  if times == [$1$] {
    [$(#sign #y) / (#sign #x)$]
  }
  else {
    [$(dif^#times #y) / (dif #x^#times)$]
  }
}
#let der(y, x) = _der(y, x, $1$, $dif$)
#let derN(y, x, times) = _der(y, x, times, $dif$)
#let partialDer(y, x) = _der(y, x, $1$, $diff$)
#let partialDerN(y, x, times) = _der(y, x, times, $diff$)
#let elasticity(P, Q) = $((diff #Q)/(diff #P))/(#Q / #P)$
#let autoVec3(a, delim: "(" ) = $vec(#a _1, #a _2, #a _3, delim: delim)$
#let autoVecN(a, n, delim: "(" ) = $vec(#a _1, #a _2,  dots.v, #a _#n, delim: delim)$
#let autoVecNF(f, n, delim: "(" ) = $vec(#(f(1)), #(f(2)),  dots.v, #(f(n)), delim: delim)$
#let autoRVecNF(f, n ) = $(#(f(1)), #(f(2)),  dots, #(f(n)))$
#let autoMat3(delim: "(", ..var) = {
  let varList = var.pos()
  let row(n) = varList.map(v => $#v _#n$)
  let data = (row(1), row(2), row(3))
  math.mat(delim: delim, ..data)
}
#let where = "where"
#let with = "with"
#let andC = $" 且 "$
#let orC = $" 或 "$
#let hb = $hat(bold(beta))$
#let sb = $bold(beta)^star$
#let bbeta = $bold(beta)$
#let balpha = $bold(alpha)$
#let bgamma = $bold(gamma)$
#let by = $bold(y)$
#let bx = $bold(x)$
#let bu = $bold(u)$
#let bv = $bold(v)$

#let inner(x, y) = $〈#x, #y〉$
#let HomoCoor = math.vec.with(delim: "[")
#let autoHomoCoor3 = autoVec3.with(delim: "[")
#let Det = math.mat.with(delim: "|")

#let Gal = math.op("Gal")
#let Hom = math.op("Hom")
#let Ext = math.op("Ext")
#let Ob = math.op("Ob")
#let cone = math.op("cone")
#let Proj = math.op("Proj")
#let Spec = math.op("Spec")
#let Spv = math.op("Spv")
#let Tor = math.op("Tor")
#let ht = math.op("height")
#let Ann = math.op("Ann")
#let Ass = math.op("Ass")
#let Sylow(p) = $"Sylow"-#p$
#let Isom = math.op("Isom")

#let GL = math.op("GL")
#let char = math.op("char")
#let Frac = math.op("Frac")
#let Inv(a) = $#a^(-1)$
#let conjugateLeft(g, a) = $#g^(-1) #a #g$
#let conjugateRight(g, a) = $#g #a #g^(-1)$
#let quotient(G, H) = $#G\\#H$
#let empty = ""
#let lift = math.arrow.t
#let quo = math.class("relation", $slash$)
#let ord = math.op("ord")
#let ei(x) = $e^(i #x)$
#let eiB(x) = $e^(#x i)$ // i Behind
#let sgn = math.op("sgn")
#let arctanh = math.op("arctanh")
#let Res(f, i) = $op("Res") (#f \; #i)$
#let lcm = math.op("lcm")
#let Der = math.op("Der")
#let Arg = math.op("Arg")
#let End = math.op("End")
#let ReT = math.op("Re")
#let ImT = math.op("Im")
#let ignoreOne(x) = {
  if x == [1] {
    []
  } else {
    [#x] 
  }
}
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
#let linearCombination(name: $C$, start: 1, ..args) = {
    let fun(list) = list.enumerate().map(
      l => {
        let (i, x) = l
        $#name _(#(i + start)) #x $
        })
        .join(" + ")
      // 不能这么写
    // let fun_error(list) =  list.enumerate().map(
    //   (i, x) => {
    //     $C_(#(i + 1)) #x $
    //     })
    //     .join(" + ")
          
      
    fun(args.pos())
}
#let linearCombinationC = linearCombination.with(name: $C$)
#let linearCombinationA = linearCombination.with(name: $A$)
#let linearCombinationa = linearCombination.with(name: $a$)
#let linearCombinationb = linearCombination.with(name: $b$)
#let linearCombinationlambda = linearCombination.with(name: $lambda$)
#let linearCombinationmu = linearCombination.with(name: $mu$)

#let defaultSum = (
  Var: $n$,
  Lower: $0$,
  Upper: $+infinity$

)
#let defaultProd = (
  Var: $n$,
  Lower: $1$,
  Upper: $+infinity$

)
#let defaultDirectSum = (
  Var: $n$,
  Lower: $0$,
  Upper: $+infinity$

)
#let directSum = math.plus.circle
#let sumf(var: defaultSum.Var, lower: defaultSum.Lower, upper: defaultSum.Upper) = $sum_(#var = #lower)^(#upper)$
#let prodf(var: defaultProd.Var, lower: defaultProd.Lower, upper: defaultProd.Upper) = $product_(#var = #lower)^(#upper)$
#let directSumf(var: defaultDirectSum.Var, lower: defaultDirectSum.Lower, upper: defaultDirectSum.Upper) = $directSum_(#var = #lower)^(#upper)$


#let emptyArrow(s, e) = arr(str(s), str(e), $$)
#let coker = math.op("coker")
#let coim = math.op("coim")
#let Ad1(x, G) = $"Ad"_#G (#x)$
#let Ad = math.op("Ad")
#let Aut = math.op("Aut")
#let algClosure(F) = $#F^"alg"$
#let inverseLimit = $limits(lim)_(arrow.l.long)$
#let directLimit = $limits(lim)_(arrow.long)$
#let AModule(A) = [$#A -$模]
#let closedBall(a, r) = $overline(B(#a, #r))$
#let GEquiv(G) = {
  $#G -$ 
  "等变"
}
#let Mod = math.op("Mod")
#let tensorProduct = math.times.circle
#let generatedBy(body) = $angle.l #body angle.r$
#let normalSub(H, G) = $#H lt.tri.eq #G$
#let norS = math.class("relation", math.lt.tri.eq)
#let semiProd = math.class("relation", math.times.r)
#let diam = math.op("diam")
//#let quot = math.class("relation", $\/$)
#let Stab = math.op("Stab")
#let Orb = math.op("Orb")
#let arrowCir = $limits(arrow)^(circle)$
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
#let (
  theorem: theo, lemma: lem, corollary: cor,
  remark: rem, proposition: prop, example:ex , definition:def,
  proof: pr, rules: thm-rules
) = default-theorems("thm-group", lang: "en")
#let (
  theorem: theo1, lemma: lem1, corollary: cor1,
  remark: rem1, proposition: prop1, example:ex1 , definition:def1,
  proof: pr1, rules: thm-rules1
) = default-theorems("thm-group-linear", lang: "en", thm-numbering: thm-numbering-linear)
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
  thm-styling: my-ans-style,
  thm-numbering: thm-numbering-linear
)
#let (answer, rules:ans-rules) = new-theorems("thm-ans", ("answer": "Answer"), ..my-styling)

#let _convert(f, name, body) = f(name: noneNameChecker(name))[
  #body
  #parbreak()
  ]
#let (alg, rules: alg-rules) = new-theorems("thm-group", ("alg": text[Algorithm]))
#let (alg1, rules: alg-rules1) = new-theorems("thm-group-linear", ("alg1": text[Algorithm]), thm-numbering: thm-numbering-linear)
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
#let algorithm(name, body) = _convert(alg, name, body)


#let theoremLinear(name, body) = _convert(theo1, name, body)
#let lemmaLinear(name, body) = _convert(lem1, name, body)
#let corollaryLinear(name, body) = _convert(cor1, name, body)
#let propositionLinear(name, body) = _convert(prop1, name, body)
#let exampleLinear(name, body) = _convert(ex1, name, body)
#let remarkLinear(name, body) = _convert(rem1, name, body)
#let definitionLinear(name, body) = _convert(def1, name, body)
#let proofLinear(body) = [#pr1[
  #set text(size: 10pt)
  #body
]
  #linebreak()
]
#let algorithmLinear(name, body) = _convert(alg1, name, body)

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
#let note(title: "Note title", author: "Name", logo: none, date: none,
          preface: none, code_with_line_number: true, withOutlined: true, withTitle: true, withHeadingNumbering: true, 
          withChapterNewPage: false,
          body) = {
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
  show: thm-rules
  show: ans-rules
  show: thm-rules1
  show: alg-rules
  show: alg-rules1
  show emph: it => {
    text(it, weight: "bold")
  }
  show math.equation: set text(font: ("Noto Serif CJK SC", "New Computer Modern Math"))
  set math.equation(numbering: "(1)")
  set math.equation(numbering: num =>
      "(" + (counter(heading).get() + (num,)).map(str).join(".") + ")") if withHeadingNumbering == true
  let headingfunc = (it => it)
  if withHeadingNumbering == false {
  }
  else {
    headingfunc = (it => {
        counter(math.equation).update(0)
        it
    })
  }
  show heading: headingfunc
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
  let headingfunc1 = it => it
  if withChapterNewPage == true{
    headingfunc1 = it => {
            pagebreak()
            it
      }
  }
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
      if withChapterNewPage == false{
        pagebreak() // 补上目录的换页
      }
    }
  }
  show heading.where(level: 1) : headingfunc1


  // Main body
  set par(justify: true, first-line-indent: 22pt)

  set heading(numbering: "1.")
  set heading(numbering: none) if withHeadingNumbering == false
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
    set text(font: ("Noto Serif CJK SC", "New Computer Modern Math"))
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
#let prop = sym.prop