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
#let getNegPart(x) = getBodyArr(x).at(1)
#let checkAddOrSub(x) = getBodyArr(x).contains(addContent) or getBodyArr(x).contains(subContent)

#let autoBrace(x) = {
  if getBodyArr(x).len() != 1 {
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
  return [$#autoBrace(x) ^ #y$]
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
// #repr($n - (n - 1)$)
#let evalSub(x, y) = {

}