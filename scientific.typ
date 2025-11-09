#import "@preview/zero:0.5.0": num

#let scientificShow(n) = {
  let n_abs = calc.abs(n)
  if n_abs >= 1 and n_abs <= 10 {
    num(n)
  }
  else {
    let temp_n_abs = n_abs
    let fixed = 0
    while not (temp_n_abs >= 1 and temp_n_abs < 10) {
      if temp_n_abs < 1 {
        temp_n_abs = temp_n_abs * 10
        fixed = fixed - 1
      }
      else {
        temp_n_abs = temp_n_abs / 10
        fixed = fixed + 1
      }
    }
    num(n, fixed: fixed)
  }
}
