#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
p221 12 15 16 14\*
= 12
  == (1)
    显然：
    $
      y = P_x y + (I - P_x) y
    $
    且：
    $
      P_x^2 = P_x\
      inner(P_x y, (I - P_x) y) = inner((I - P_x) P_x y, y) = 0\
      P_x y = X Inv(tMul(X)) X^T y in im X
    $
    表明就是正交投影
  == (2)
    不难验证：
    $
      h_(i i) = quadFormSym(e_i, P_X) = norm2(P_X e_i)
    $
    - 投影矩阵显然是正定的，因此 $h_(i i) >= 0$
    - 熟知 $P_X$ 的算子范数 $norm(P_X) <= 1$，因此：
      $
        norm(P_X e_i) <= 1 norm(e_1) = 1
      $
      证毕
  == (3)
    我们有：
    $
      0 <= quadFormSym(e_i - 1/n 1_n, P_X) = h_(i i) - 2/n e_i^T P_X 1_n + 1/n^2 quadFormSym(1_n, P_X) 
    $
    而由条件有：
    $
      P_X 1_n = 1_n
    $
    因此：
    $
      0 <= h_(i i) - 2/n + 1/n => h_(i i) >= 1/n
    $
    证毕
= 15
  使用拉格朗日乘子法：
  $
    L = norm2(Y - X beta) + lambda^T (H beta - r)
  $
  #let tbeta = $tilde(beta)$
  就有：
  $
    partialDer(L, beta) = -2 (Y - X beta)^T X + lambda^T H = 0\
    H beta = r\
    2 tMul(X) beta= 2 X^T Y - H^T lambda\
    beta = Inv(tMul(X)) (X^T Y - 1/2 H^T lambda\)\
    H beta= r = H Inv(tMul(X)) X^T Y - 1/2 H Inv(tMul(X)) H^T lambda = H tbeta - 1/2 H Inv(tMul(X)) H^T lambda\
    -1/2 lambda = Inv(H Inv(tMul(X)) H^T) (r - H tbeta) \
    beta = tbeta + Inv(tMul(X)) H^T (-1/2 lambda) = tbeta - Inv(tMul(X)) H^T Inv(H Inv(tMul(X)) H^T) (r - H tbeta)\
  $
= 16
  计算得：
  $
    beta_0 = -23.45
    beta_1 = 0.12\
    beta_2 = 0.37\
    RSS = 10.203\
    1/(n - p) RSS = RSS / (10 - 3) = 1.46
  $
= 14
  将 $X = I. r = 0$ 代入 15 题结果得到：
  $
    htheta = tilde(theta) - A^T Inv(A A^T) A tilde(theta) = (I - A^T Inv(A A^T) A) Y
  $