#let NormalDis(x, mu, sigma) = autoMul(
  autoFraction(
    oneContent, autoMul(
      autoSqrt($2 pi$), sigma
    )
  ),
  autoPow(
    $e$,
    autoNeg(
      autoFraction(
        autoPow(autoSub(x, mu), 2),
        autoMul(2, autoPow(sigma, 2))
      )
    )
  )
)

$
  NormalDis(x, 0, 1)\
  NormalDis(0, 0, 1)\
  NormalDis(0, mu, sigma)\
$