#let getBodyArr(x) = {
  if type(x) != content {
    return (x, )
  }
  if x.has("body") {
    getBodyArr(x.body)
  } else if x.has("children") {
    x.children
  } else {
    (x, )
  }
}


#let zeroContent = getBodyArr($0$).at(0)
#let oneContent = getBodyArr($1$).at(0)
#let addContent = getBodyArr($+1$).at(0)
#let subContent = getBodyArr($-1$).at(0)


#let checkOne(x) = getBodyArr(x).at(0) == oneContent
#let checkZero(x) = getBodyArr(x).at(0) == zeroContent
#let checkNeg(x) = (getBodyArr(x).len() == 2 and getBodyArr(x).at(0) == subContent)
#let checkNegOne(x) = checkNeg(x) and checkOne(getBodyArr(x).at(1))
#let checkAttachT(x) = getBodyArr(x).len() == 1 and type(getBodyArr(x).at(0)) == content and getBodyArr(x).at(0).has("t")
#let getAttachT(x) = getBodyArr(x).at(0).at("t")
#let getNegPart(x) = getBodyArr(x).at(1)
#let checkAddOrSub(x) = getBodyArr(x).contains(addContent) or getBodyArr(x).contains(subContent)

#let removeAttachT(x) = {
  if not checkAttachT(x) {
    return x
  }
  let args = getBodyArr(x).at(0).fields()
  let _ = args.remove("t")
  let base1 = args.at("base")
  let _ = args.remove("base")
  let args = args
  math.attach(base1, ..args)
}
#let autoBrace(x) = {
  if getBodyArr(x).len() != 1 {
    return [$(#x)$]
  }
  else {
    return x
  }
}

#let autoBraceOrAttachT(x) = {
  if getBodyArr(x).len() != 1 or checkAttachT(x) {
    return [$(#x)$]
  }
  else {
    return x
  }
}

#let autoBraceIfAddOrSub(x) = {
  if checkAddOrSub(x) {
    return autoBrace(x)
  }
  else {
    return x
  }
}

#let autoNeg(x) = {
  if checkZero(x) {
    return zeroContent
  }
  if checkNeg(x) {
    return getNegPart(x)
  }
  return [$-#autoBraceIfAddOrSub(x)$]
}

#let autoAdd(x, y) = {
  if checkZero(x) {
    return y
  }
  if checkZero(y) {
    return x
  }
  if checkNeg(y) {
    return [$#x - #(getNegPart(y))$]
  }
  return [$#x + #autoBraceIfAddOrSub(y)$]
}

#let autoSub(x, y) = {
  if checkZero(x) {
    return [$-#autoBrace(y)$]
  }
  if checkZero(y) {
    return x
  }
  if checkNeg(y) {
    return [$#x - #(getNegPart(y))$]
  }
  return [$#x - #autoBraceIfAddOrSub(y)$]
}

#let autoMul(x, y) = {
  if checkZero(x) or checkZero(y) {
    return zeroContent
  }
  if checkOne(x) {
    return y
  }
  if checkOne(y) {
    return x
  }
  return [$#autoBraceIfAddOrSub(x) #autoBraceIfAddOrSub(y)$]
}

#let autoFraction(x, y) = {
  if checkZero(x) {
    return zeroContent
  }
  if checkOne(y) {
    return x
  }
  return [$#x / #y$]
}

#let autoPow(x, y) = {
  if checkZero(x) {
    return zeroContent
  }
  if checkZero(y) {
    return oneContent
  }
  if checkOne(x) {
    return oneContent
  }
  if checkOne(y) {
    return x
  }
  if checkAttachT(x) {
    for invs in ($-1$, $T$) {
      if y == invs and getAttachT(x) == invs.body {
        return removeAttachT(x)
      }
    }
  }
  return [$#autoBraceOrAttachT(x) ^ #y$]
}

#let autoSqrt(x) = {
  if checkZero(x) {
    return zeroContent
  }
  if checkOne(x) {
    return oneContent
  }
  return $sqrt(autoBraceIfAddOrSub(#x))$
}

#let autoDet(x) = {
  if checkZero(x) {
    return zeroContent
  }
  if checkOne(x) {
    return oneContent
  }
  return $det(autoBraceIfAddOrSub(#x))$
}

#let autoFactorial(x) = {
  if checkZero(x) {
    return oneContent
  }
  if checkOne(x) {
    return oneContent
  }
  return $autoBrace(#x)!$
}

// #repr($n - (n - 1)$)
#let evalSub(x, y) = {

}