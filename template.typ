// 参考 https://github.com/Fr4nk1in-USTC/typst-notebook

//#import "typst-sympy-calculator.typ": *

#import "@preview/lemmify:0.1.7": *
// #import "@preview/commute:0.2.0": node, arr, commutative-diagram
#import "@preview/showybox:2.0.3": showybox
#import "autoArithExp/lib.typ": *

#let __print_commute = true
// #let old-commutative-diagram = commutative-diagram
// #let commutative-diagram(print: __print_commute, ..args) = {
//   if print {
//     old-commutative-diagram(..args)
//   }
//   else {
//     align(center)[
//       #text(style: "italic", font: "New Computer Modern")[
//         _Commutative diagram_
//       ]
//     ]
//   }
// }

#let en-font = "New Computer Modern"
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
#let partialDer(y, x) = _der(y, x, $1$, $partial$)
#let partialDerN(y, x, times) = _der(y, x, times, $partial$)
#let elasticity(P, Q) = $((partial #Q)/(partial #P))/(#Q / #P)$
#let autoVec3(a, delim: "(" ) = $vec(#a _1, #a _2, #a _3, delim: delim)$
#let autoVecN(a, n, delim: "(" ) = $vec(#a _1, #a _2,  dots.v, #a _#n, delim: delim)$
#let autoVecNF(f, n, delim: "(" ) = $vec(#(f(1)), #(f(2)),  dots.v, #(f(n)), delim: delim)$
#let autoRListNF(f, n) = $#(f(1)), #(f(2)),  dots, #(f(n))$
#let autoRVecNF(f, n ) = $(autoRListNF(f, n))$
#let autoRListN(a, n) = $#a _1, #a _2,  dots, #a _#n$
#let autoRVecN(a, n) = $(autoRListN(a, n))$
#let autoMat3(delim: "(", ..var) = {
  let varList = var.pos()
  let row(n) = varList.map(v => $#v _#n$)
  let data = (row(1), row(2), row(3))
  math.mat(delim: delim, ..data)
}
#let autoMat(delim: "(", n, pre: 3, interval: 2, post: 3, f) = {
  let rows_pre = ();
  for i in range(1, pre + 1) {
    let row = ();
    row = row + range(1, pre + 1).map(j => f(i, j))
    row.push($dots$)
    row = row + range(post - 1, -1, step: -1).map(j => f(i, autoSub(n, j)))
    rows_pre.push(row)
  }
  let row_dots = ()
  for i in range(0, interval) {
    let row = range(1, pre + 1).map(i => $dots.v$)  + ($dots.down$,) + range(post - 1, -1, step: -1).map(i => $dots.v$)
    row_dots.push(row)
  }
  
  let rows_post = ()
  for i in range(post - 1, -1, step: -1) {
    let row = ();
    row = row + range(1, pre + 1).map(j => f(autoSub(n, i), j))
    row.push($dots$)
    row = row + range(post - 1, -1, step: -1).map(j => f(autoSub(n, i), autoSub(n, j)))
    rows_post.push(row)
  }
  math.mat(delim: delim, ..rows_pre, ..row_dots, ..rows_post)
}
// #let autoMat(delim: "(", f) = 
#let where = "where"
#let with = "with"
#let suchThat = $ space "s.t." space $
#let andC = $" 且 "$
#let orC = $" 或 "$
#let hb = $hat(bold(beta))$
#let sb = $bold(beta)^star$
#let bbeta = $bold(beta)$
#let balpha = $bold(alpha)$
#let bgamma = $bold(gamma)$
#let htheta = $hat(theta)$
#let by = $bold(y)$
#let bx = $bold(x)$
#let bu = $bold(u)$
#let bv = $bold(v)$
#let xbar = $overline(x)$
#let Xbar = $overline(X)$
#let cov = "Cov"
#let var = "Var"

#let inner(x, y) = $〈#x, #y〉$
#let span(..x) = $<#(x.pos().join($, $))>$
#let HomoCoor = math.vec.with(delim: "[")
#let autoHomoCoor3 = autoVec3.with(delim: "[")
#let Det = math.mat.with(delim: "|")

#let notModels = sym.tack.r.double.not
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
#let diag = math.op("diag")
#let rank = math.op("rank")
#let dist = math.op("dist")
#let approxVar(R) = $tilde(R)$

#let GL = math.op("GL")
#let char = math.op("char")
#let Frac = math.op("Frac")
// #let Inv(a) = $#a^(-1)$
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

// e^(x^2)
#let eX2(x) = autoPow($e$, autoPow(x, 2))
// e^(-x^2)
#let eNX2(x) = autoPow($e$, autoNeg(autoPow(x, 2)))
// e^(x i)
#let eXi(x) = autoPow($e$, autoMul(x, $i$))
// e^(x / y)
#let eXdY(x, y) = autoPow($e$, autoFraction(x, y))
// e^(- x/y)
#let eNXdY(x, y) = autoPow($e$, autoNeg(autoFraction(x, y)))
// e^(- x^2/y)
#let eNX2dY(x, y) = eNXdY(autoPow(x, 2), y)
#let Inv(x) = autoPow(x, -1)
#let NormalDis(x, mu, sigma) = autoMul(
  autoFraction(
    oneContent, autoMul(
      autoSqrt($2 pi$), sigma
    )
  ),
  eNX2dY(autoSub(x, mu), autoMul(2, autoPow(sigma, 2)))
)
#let NormalDisN(x, mu, sigma, n) = autoMul(
  autoPow($2 pi$, autoNeg(autoFraction(n, 2))),
  autoMul(autoPow(autoDet(sigma), $- 1/2$),
    autoPow($e$,
      autoNeg(
        // $1/2 autoSub(x, mu)^T autoPow(sigma, -1) autoSub(x, mu)$
        autoMul($1/2$, 
          autoMul(
            autoPow(autoSub(x, mu), $T$),
            autoMul(
              autoPow(sigma, -1),
              autoSub(x, mu)
            )
          )
        )
      )
    )
  )
)
#let ExpDis(x, lambda) = autoMul(lambda, autoPow($e$, autoNeg(autoMul(lambda, x)))) 
// #let WeibullDis(x, m, eta) = autoMul(

// )

#let quadForm(x, A, y) = autoMul(
  autoPow(x, $T$),
  autoMul(autoBrace(A),
  autoBraceIfAddOrSub(y))
)
#let quadFormSym(x, A) = quadForm(x, A, x)
#let tMul(A) = autoMul(autoPow(A, $T$), A)
#let mulT(A) = autoMul(A, autoPow(A, $T$))

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
#let sumfBr(var: defaultSum.Var, lower: defaultSum.Lower, upper: defaultSum.Upper, body) = $sum_(#var = #lower)^(#upper) #autoBraceIfAddOrSub(body)$
#let prodfBr(var: defaultProd.Var, lower: defaultProd.Lower, upper: defaultProd.Upper, body) = $product_(#var = #lower)^(#upper) #autoBraceIfAddOrSub(Body)$
#let directSumfBr(var: defaultDirectSum.Var, lower: defaultDirectSum.Lower, upper: defaultDirectSum.Upper, body) = $directSum_(#var = #lower)^(#upper) #autoBraceIfAddOrSub(Body)$


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
#let base_env(type: "Theorem", numbered: true, fg: black, bg: white, name, body) = locate(
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


#let frame-map = (
  Proposition: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),
  Theorem: (
    title-color: green.darken(40%),
    body-color: green.lighten(80%),
    footer-color: green.lighten(60%),
    border-color: green.darken(60%),
  ),
  Lemma: (
    title-color: orange.darken(40%),
    body-color: orange.lighten(80%),
    footer-color: orange.lighten(60%),
    border-color: orange.darken(60%),
  ),
  Corollary: (
    title-color: red.darken(40%),
    body-color: red.lighten(80%),
    footer-color: red.lighten(60%),
    border-color: red.darken(60%),
  ),
  Definition: (
    title-color: purple.darken(40%),
    body-color: purple.lighten(80%),
    footer-color: purple.lighten(60%),
    border-color: purple.darken(60%),
  ),
  Example: (
    border-color: red.darken(40%),
    title-color: red.darken(30%),
    body-color: red.lighten(90%),
    radius: 0pt,
    thickness: 2pt,
    body-inset: 1em,
  ),
  Remark: (
    border-color: green.darken(40%),
    title-color: green.darken(30%),
    body-color: green.lighten(90%),
    radius: 0pt,
    thickness: 2pt,
    body-inset: 1em,
  ),
  Algorithm: (
    border-color: blue.darken(40%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
    radius: 0pt,
    thickness: 2pt,
    body-inset: 1em,
  ),
)

#let theorem-like-style(thm-type, name, number, body) = {
  showybox(
    body,
    title: [#strong(thm-type) #number #if name != none [ (#name) ]],
    frame: frame-map.at(thm-type),
    footer: ""
  )
}

#let proof-style(thm-type, name, number, body) = {
  showybox(
    breakable: true,
    title: "Proof",
    frame: (
    border-color: red.darken(30%),
    title-color: red.darken(30%),
    body-color: red.lighten(90%),
    radius: 0pt,
    thickness: 2pt,
    body-inset: 1em,
    dash: "densely-dash-dotted"
  ),
  )[
    #body
    #linebreak()
    #h(1fr)
    #box(scale(100%, origin: bottom + right, sym.square.stroked))
  ]
}

#let (
  theorem: theo, lemma: lem, corollary: cor,
  remark: rem, proposition: prop, example:ex , definition:def,
  proof: pr, rules: thm-rules
) = default-theorems("thm-group", lang: "en", thm-styling: theorem-like-style, proof-styling: proof-style)
#let (
  theorem: theo1, lemma: lem1, corollary: cor1,
  remark: rem1, proposition: prop1, example:ex1 , definition:def1,
  proof: pr1, rules: thm-rules1
) = default-theorems("thm-group-linear", lang: "en", thm-numbering: thm-numbering-linear, thm-styling: theorem-like-style, proof-styling: proof-style)
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

#let _convert(f, footer,name, body) = f(name: noneNameChecker(name))[
  #body
  #parbreak()
  ]
#let (alg, rules: alg-rules) = new-theorems("thm-group", ("alg": "Algorithm"), thm-styling: theorem-like-style)
#let (alg1, rules: alg-rules1) = new-theorems("thm-group-linear", ("alg1": "Algorithm"), thm-numbering: thm-numbering-linear, thm-styling: theorem-like-style)
#let theorem(footer: "",name, body) = _convert(theo, footer, name, body)
#let lemma(footer: "",name, body) = _convert(lem, footer,name, body)
#let corollary(footer: "",name, body) = _convert(cor, footer, name, body)
#let proposition(footer: "",name, body) = _convert(prop, footer, name, body)
#let definition(footer: "",name, body) = _convert(def, footer, name, body)
#let example(footer: "",name, body) = _convert(ex, footer, name, body)
#let remark(footer: "",name, body) = _convert(rem, footer, name, body)
#let proof(body) = [#pr[
  #set text(size: 10pt)
  #body
]
  #linebreak()
]
#let algorithm(footer: "",name, body) = _convert(alg, footer,name, body)


#let theoremLinear(footer: "",name, body) = _convert(theo1, footer,name, body)
#let lemmaLinear(footer: "",name, body) = _convert(lem1, footer,name, body)
#let corollaryLinear(footer: "",name, body) = _convert(cor1, footer,name, body)
#let propositionLinear(footer: "",name, body) = _convert(prop1, footer: "",name, body)
#let exampleLinear(footer: "",name, body) = _convert(ex1, footer,name, body)
#let remarkLinear(footer: "",name, body) = _convert(rem1, footer,name, body)
#let definitionLinear(footer: "",name, body) = _convert(def1, footer,name, body)
#let proofLinear(body) = [#pr1[
  #set text(size: 10pt)
  #body
]
  #linebreak()
]
#let algorithmLinear(footer: "",name, body) = _convert(alg1, footer: "",name, body)


#let note(title: "Note title", author: "Name", logo: none, date: none,
          preface: none, code_with_line_number: true, withOutlined: true, withTitle: true, withHeadingNumbering: true, 
          withChapterNewPage: false,
          body) = {
  // Set the document's basic properties.
  set document(author: (author, ), title: title)
  show list: set align(top + left)
  show list: set block(breakable: true)
  show block: set align(top + left)
  set block(breakable: true)
  show enum: set block(breakable: true)
  set page(
    numbering: "1",
    number-align: end,
    // Running header.
    header-ascent: 14pt,
    header: [ 
      #context [
        #let i = here().position().at("page")
        #{
          if i == 1 { return }
          set text(size: 8pt)
          if calc.odd(i) { align(end, title) } else { align(start, title) }
        }
      ]
      ]
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
  show math.equation: it => {
    show block: set align(center)
    it
    }
  show math.equation.where(block: true): set align(center)
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
  set par(spacing: 1.2em)
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

        outline(title: none, depth: 3, indent: auto)
      } else {
        outline(depth: 3, indent: auto)
      }
      if withChapterNewPage == false{
        pagebreak() // 补上目录的换页
      }
    }
  }
  show heading.where(level: 1) : headingfunc1


  // Main body
  set par(justify: true, first-line-indent: (
      amount: 22pt,
      all: false
    ))

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
  show raw: it => {
    // set text(font: ("Serif Italic", "Noto Serif CJK SC"))
    it
  }
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
#let prop = sym.prop