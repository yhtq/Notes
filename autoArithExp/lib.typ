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

#let autoPara(x) = {
  if getBodyArr(x).len() != 1 {
    return [$(#x)$]
  }
  else {
    return x
  }
}

#let autoParaIfAddOrSub(x) = {
  if checkAddOrSub(x) {
    return autoPara(x)
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
  return [$-#autoParaIfAddOrSub(x)$]
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
  return [$#x + #autoParaIfAddOrSub(y)$]
}

#let autoSub(x, y) = {
  if checkZero(x) {
    return [$-#autoPara(y)$]
  }
  if checkZero(y) {
    return x
  }
  if checkNeg(y) {
    return [$#x - #(getNegPart(y))$]
  }
  return [$#x - #autoPara(y)$]
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
  return [$#autoParaIfAddOrSub(x) #autoParaIfAddOrSub(y)$]
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
  return [$#autoPara(x) ^ #y$]
}

#let autoSqrt(x) = {
  if checkZero(x) {
    return zeroContent
  }
  if checkOne(x) {
    return oneContent
  }
  return $sqrt(#x)$
}