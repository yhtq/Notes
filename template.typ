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
  if checkOne(times) {
    [$(#sign #autoBraceIfAddOrSub(y)) / (#sign #x)$]
  }
  else {
    [$(#sign^#times #autoBraceIfAddOrSub(y)) / (#sign #x^#times)$]
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
#let autoRVecNF(f, n ) = $(autoRListNF(#f, #n))$
#let autoRListN(a, n) = $#a _1, #a _2,  dots, #a _#n$
#let autoRVecN(a, n) = $(autoRListN(#a, #n))$
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
#let hbeta = $hat(beta)$
#let hX = $hat(X)$
#let hY = $hat(Y)$
#let by = $bold(y)$
#let bx = $bold(x)$
#let bu = $bold(u)$
#let bv = $bold(v)$
#let xbar = $overline(x)$
#let Xbar = $overline(X)$
#let Ybar = $overline(Y)$
#let ybar = $overline(y)$
#let zbar = $overline(z)$
#let Zbar = $overline(Z)$
#let duelSpace(X) = $#X^*$
#let cov = math.op("Cov")
#let var = math.op("Var")
#let cor = math.op("Cor")

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
#let convexHull = math.op("co")
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
#let closure(X) = $overline(#X)$
#let lcm = math.op("lcm")
#let Der = math.op("Der")
#let Arg = math.op("Arg")
#let End = math.op("End")
#let ReT = math.op("Re")
#let ImT = math.op("Im")
#let eqv = sym.tilde.equiv
#let Inter = math.inter.big
#let Union = math.union.big
#let arrowb = $arrow.bar$
#let ite(cond, r1, r2) = $"if" autoBraceIfAddOrSub(#cond) "then" autoBraceIfAddOrSub(#r1) "else" autoBraceIfAddOrSub(#r2) $

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
// generalized inverse
#let gInv(x) = autoPow(x, $-$)
// Moore-Penrose inverse
#let MPInv(x) = autoPow(x, $+$)
#let NormalDis(x, mu, sigma) = autoMul(
  autoFraction(
    oneContent, autoMul(
      autoSqrt($2 pi$), sigma
    )
  ),
  eNX2dY(autoSub(x, mu), autoMul(2, autoPow(sigma, 2)))
)
// $checkAttachT(sigma)$
// #(type(repr(getBodyArr(math.sigma).at(0))) == str)
// $eNX2dY(x, 2 )$
// #repr(getBodyArr($e$).at(0))
// $NormalDis(x, mu, sigma)$
// #getBodyArr($e^(-1/2 (x - mu)^2/sigma^2)$)
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

#let PoissonDis(k, lambda) = autoFraction(
  autoMul(autoPow(lambda, k),
  autoPow($e$, autoNeg(lambda))),
  autoFactorial(k)
)

#let quadForm(x, A, y) = autoMul(
  autoPow(x, $T$),
  autoMul(A,
  y)
)
#let quadFormSym(x, A) = quadForm(x, A, x)
#let tMul(A) = autoMul(autoPow(A, $T$), A)
#let mulT(A) = autoMul(A, autoPow(A, $T$))

#let orthogonal = math.op($tack.t$)
#let orthogonalCom(x) = autoPow(x, orthogonal)

#let defaultSum = (
  Var: $n$,
  Lower: $0$,
  Upper: $+infinity$,
  Op: $sum$
)
#let defaultProd = (
  Var: $n$,
  Lower: $1$,
  Upper: $+infinity$,
  Op: $product$
)
#let directSum = math.plus.circle
#let defaultDirectSum = (
  Var: $n$,
  Lower: $0$,
  Upper: $+infinity$,
  Op: $directSum$
)
#let sumf(var: defaultSum.Var, lower: defaultSum.Lower, upper: defaultSum.Upper) = $sum_(#var = #lower)^(#upper)$
#let prodf(var: defaultProd.Var, lower: defaultProd.Lower, upper: defaultProd.Upper) = $product_(#var = #lower)^(#upper)$
#let directSumf(var: defaultDirectSum.Var, lower: defaultDirectSum.Lower, upper: defaultDirectSum.Upper) = $directSum_(#var = #lower)^(#upper)$

#let bigOpBr(config, body) = $#(config.Op)_(#config.Var = #config.Lower)^(#config.Upper) #autoBraceIfAddOrSub(body)$ 

#let sumfBr(config: defaultSum, body) = bigOpBr((Op: $sum$) + config, body)
#let prodfBr(config: defaultProd, body) = bigOpBr((Op: $product$) + config, body)
#let directSumfBr(config: defaultDirectSum, body) = bigOpBr((Op: $directSum$) + config, body)
// #let prodfBr(config, body) = $product_(#config.var = #config.lower)^(#config.upper) #autoBraceIfAddOrSub(Body)$
// #let directSumfBr(var: defaultDirectSum.Var, lower: defaultDirectSum.Lower, upper: defaultDirectSum.Upper, body) = $directSum_(#var = #lower)^(#upper) #autoBraceIfAddOrSub(Body)$

#let all_configs = {
  let res = ()
  let vars = ($i$, $j$, $k$)
  let lowers = ($0$, $1$, $2$)
  let uppers = ($n$, $m$, $N$, $M$, $+infinity$)
  for var in vars {
    for lower in lowers {
      for upper in uppers {
        res.push((Var: var, Lower: lower, Upper: upper))
      }
    }
  }
  res
}

#let config1iN = (
  Var: $i$,
  Lower: $1$,
  Upper: $n$,
)
#let config1iinf = (
  Var: $i$,
  Lower: $1$,
  Upper: $+infinity$,
)
#let config0iN = (
  Var: $i$,
  Lower: $0$,
  Upper: $n$,
)
#let config0iinf = (
  Var: $i$,
  Lower: $0$,
  Upper: $+infinity$,
)

#let _gen_big_expressions(configs, fBr, body_transformer) = {
  configs.map(config => {
    body => {
      fBr(config: config, body_transformer(body))
    }
  })
}

#let (
  sumi0n, sumi0m, sumi0N, sumi0M, sumi0inf,
  sumi1n, sumi1m, sumi1N, sumi1M, sumi1inf,
  sumi2n, sumi2m, sumi2N, sumi2M, sumi2inf,
  sumj0n, sumj0m, sumj0N, sumj0M, sumj0inf,
  sumj1n, sumj1m, sumj1N, sumj1M, sumj1inf,
  sumj2n, sumj2m, sumj2N, sumj2M, sumj2inf,
  sumk0n, sumk0m, sumk0N, sumk0M, sumk0inf,
  sumk1n, sumk1m, sumk1N, sumk1M, sumk1inf,
  sumk2n, sumk2m, sumk2N, sumk2M, sumk2inf,
) = _gen_big_expressions(
  all_configs,
  sumfBr,
  (n => n)
)

#let (
  prodi0n, prodi0m, prodi0N, prodi0M, prodi0inf,
  prodi1n, prodi1m, prodi1N, prodi1M, prodi1inf,
  prodi2n, prodi2m, prodi2N, prodi2M, prodi2inf,
  prodj0n, prodj0m, prodj0N, prodj0M, prodj0inf,
  prodj1n, prodj1m, prodj1N, prodj1M, prodj1inf,
  prodj2n, prodj2m, prodj2N, prodj2M, prodj2inf,
  prodk0n, prodk0m, prodk0N, prodk0M, prodk0inf,
  prodk1n, prodk1m, prodk1N, prodk1M, prodk1inf,
  prodk2n, prodk2m, prodk2N, prodk2M, prodk2inf,
) = _gen_big_expressions(
  all_configs,
  prodfBr,
  (n => n)
)

#let (
  sumi0n2, sumi0m2, sumi0N2, sumi0M2, sumi0inf2,
  sumi1n2, sumi1m2, sumi1N2, sumi1M2, sumi1inf2,
  sumi2n2, sumi2m2, sumi2N2, sumi2M2, sumi2inf2,
  sumj0n2, sumj0m2, sumj0N2, sumj0M2, sumj0inf2,
  sumj1n2, sumj1m2, sumj1N2, sumj1M2, sumj1inf2,
  sumj2n2, sumj2m2, sumj2N2, sumj2M2, sumj2inf2,
  sumk0n2, sumk0m2, sumk0N2, sumk0M2, sumk0inf2,
  sumk1n2, sumk1m2, sumk1N2, sumk1M2, sumk1inf2,
  sumk2n2, sumk2m2, sumk2N2, sumk2M2, sumk2inf2,
) = _gen_big_expressions(
  all_configs,
  sumfBr,
  (body => autoPow(body, 2))
)

#let (
  sumi0nnr, sumi0mnr, sumi0Nnr, sumi0Mnr, sumi0infnr,
  sumi1nnr, sumi1mnr, sumi1Nnr, sumi1Mnr, sumi1infnr,
  sumi2nnr, sumi2mnr, sumi2Nnr, sumi2Mnr, sumi2infnr,
  sumj0nnr, sumj0mnr, sumj0Nnr, sumj0Mnr, sumj0infnr,
  sumj1nnr, sumj1mnr, sumj1Nnr, sumj1Mnr, sumj1infnr,
  sumj2nnr, sumj2mnr, sumj2Nnr, sumj2Mnr, sumj2infnr,
  sumk0nnr, sumk0mnr, sumk0Nnr, sumk0Mnr, sumk0infnr,
  sumk1nnr, sumk1mnr, sumk1Nnr, sumk1Mnr, sumk1infnr,
  sumk2nnr, sumk2mnr, sumk2Nnr, sumk2Mnr, sumk2infnr,
) = _gen_big_expressions(
  all_configs,
  sumfBr,
  (body => norm(body))
)

#let (
  sumi0nnr2, sumi0mnr2, sumi0Nnr2, sumi0Mnr2, sumi0infnr2,
  sumi1nnr2, sumi1mnr2, sumi1Nnr2, sumi1Mnr2, sumi1infnr2,
  sumi2nnr2, sumi2mnr2, sumi2Nnr2, sumi2Mnr2, sumi2infnr2,
  sumj0nnr2, sumj0mnr2, sumj0Nnr2, sumj0Mnr2, sumj0infnr2,
  sumj1nnr2, sumj1mnr2, sumj1Nnr2, sumj1Mnr2, sumj1infnr2,
  sumj2nnr2, sumj2mnr2, sumj2Nnr2, sumj2Mnr2, sumj2infnr2,
  sumk0nnr2, sumk0mnr2, sumk0Nnr2, sumk0Mnr2, sumk0infnr2,
  sumk1nnr2, sumk1mnr2, sumk1Nnr2, sumk1Mnr2, sumk1infnr2,
  sumk2nnr2, sumk2mnr2, sumk2Nnr2, sumk2Mnr2, sumk2infnr2,
) = _gen_big_expressions(
  all_configs,
  sumfBr,
  (body => norm2(body))
)

#let sumBrN1(body) = sumfBr(body, config: config1iN)
#let prodBrN1(body) = prodfBr(body, config: config1iN)
#let sumBrN0(body) = sumfBr(body, config: config0iN)
#let prodBrN0(body) = prodfBr(body, config: config0iN)
#let sumBrN1inf(body) = sumfBr(body, config: config1iinf)
#let prodBrN1inf(body) = prodfBr(body, config: config1iinf)
#let sumBrN0inf(body) = sumfBr(body, config: config0iinf)
#let prodBrN0inf(body) = prodfBr(body, config: config0iinf)

#let limn(body) = $lim_(n -> +infinity) autoBraceIfAddOrSub(#body)$
#let liminfn(body) = $liminf_(n -> +infinity) autoBraceIfAddOrSub(#body)$
#let limsupn(body) = $limsup_(n -> +infinity) autoBraceIfAddOrSub(#body)$

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
#let norm2(x) = $norm(#x)^2$
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
    breakable: true,
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
  theorem: theo, lemma: lem, corollary: cor_,
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
#let corollary(footer: "",name, body) = _convert(cor_, footer, name, body)
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
  // show block: set align(top + left)
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

#let calcSquareSum(xs) = xs.map(x => x * x).sum()
#let calcMean(xs) = xs.sum() / xs.len()
// S^2 = 1/(n-1) * sum((x - x_bar)^2)
#let calcSampleVariance(xs) = {
  let mean = calcMean(xs)
  let n = xs.len()
  let sum = xs.map(x => (x - mean) * (x - mean)).sum()
  sum / (n - 1)
}