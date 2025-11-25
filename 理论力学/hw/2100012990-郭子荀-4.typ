#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/cetz:0.3.1": *
#import "@preview/cetz-plot:0.1.0": *
#import "@preview/zero:0.5.0": num
#show: note.with(
  title: "作业4",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withHeadingNumbering: false,
  withTitle: false
)
#let bq = $bold(q)$
#let bp = $bold(p)$
#let bP = $bold(P)$
#let bQ = $bold(Q)$
= 胡 P403
  == 2
    这是第二类母函数：
    $
      F_2 = bP bq
    $
    则有：
    $
      bp = partialDer(F, bq) = bP\
      bQ = partialDer(F, bP) = bq\
      H_1 = H
    $
  == 4
    对于 $bp, bQ, t$ 型的，我们希望：
    $
      vt(F) = bp vt(bq) - bP vt(bQ) - (H - H_1)\
      = vt(bp bq) - vt(bp) bq - bP vt(bQ) - (H - H_1)\
      vt(F - bp bq) = - vt(bp) bq - bP vt(bQ) - (H - H_1)
    $
    显然就应该令 $F_3 = F - bp bq$，继而：
    $
      vt(F_3) = - vt(bp) bq - bP vt(bQ) - (H - H_1)
    $
    应当取：
    $
      - bq = partialDer(F, bp)\
      - bP = partialDer(F, bQ)\
      H_1 = H + partialDer(F, t)
    $
    对于 $bp, bP, t$ 型的，我们希望：
    $
      vt(F) = bp vt(bq) - bP vt(bQ) - (H - H_1)\
      = vt(bp bq) - bq vt(bp) - vt(bP bQ) + bQ vt(bP) - (H - H_1)\
      vt(F - bp bq + bP bQ) = - bq vt(bp) + bQ vt(bP) - (H - H_1)
    $
    显然就应该令 $F_4 = F - bp bq + bP bQ$，继而：
    $
      vt(F_4) = - bq vt(bp) + bQ vt(bP) - (H - H_1)
    $
    应当取：
    $
      - bq = partialDer(F, bp)\
      bQ = partialDer(F, bP)\
      H_1 = H + partialDer(F, t)
    $
  == 5
    == (1)
      我们假设哈密顿母函数形如 $F_2 = W_1 (r) + alpha theta + T(t)$，代入哈密顿-雅可比方程：
      $
        partialDer(F_2, t) + H (r, partialDer(F_2, vec(r, theta)), t) = 0\
        partialDer(T, t) + 1/(2 m) ((partialDer(W_1, r))^2 + (alpha / r)^2) + V(r) = 0
      $
      由于第一项仅与时间有关，后面项仅与位置有关，可设：
      $
        der(T, t) = - E\
        1/(2 m) ((der(W_1, r))^2 + (alpha / r)^2) + V(r) = E\
        (der(W_1, r))^2 + (alpha / r)^2 = 2m (E - V(r))\
        der(W_1, r) = sqrt(2m (E - V(r)) - (alpha / r)^2)\
      $
      这就确定了 $W_1$。如此，就有：
      $
        F_2 (bq, bP, t) = W_1 (r) + alpha theta - E t
      $
    == (2)
      不妨设 $bP = E$，因此：
      $
        bQ = partialDer(F_2, bP) = partialDer(W_1, E) - t\
        bp = partialDer(F_2, bq) = (der(W_1, r), alpha)
      $
      哈密顿-雅可比方程的含义给出：
      $
        b_1 = bQ = partialDer(W_1, E) - t\
        t + b_1 = partialDer(W_1, E) = integral partial / (partial E) sqrt(2m (E - V(r)) - (alpha / r)^2) dif r\
        = integral m / sqrt(2m (E - V(r)) - (alpha / r)^2) dif r
      $
      同时，熟知：
      $
        vt(r) = partialDer(H, p_r)\
        vt(theta) = partialDer(H, p_theta) 
      $
      因此：
      $
        der(theta, r) = (partialDer(H, p_theta)) / (partialDer(H, p_r)) = 1/r^2 p_theta / p_r = 1/r^2 alpha / der(W_1, r) = 1/r^2 alpha 1/sqrt(2m (E - V(r)) - (alpha / r)^2) \
        theta - b_2 = integral 1/r^2 alpha 1/sqrt(2m (E - V(r)) - (alpha / r)^2) dif r\
        = - integral 1/sqrt(2 m (E - V(r))/alpha^2 - u^2) dif u
      $
= 戈 P512
  == 5
    $
      vt(Q) = 1/(1 + (alpha^2 q^2/p^2)) alpha (p vt(q) - vt(p) q)/p^2\
      = alpha (p vt(q) - vt(p) q)/(p^2 + alpha^2 q^2)\
      P vt(Q) = 1/2 alpha^2 q^2 (1 + p^2 / (alpha^2 q^2)) (p vt(q) - vt(p) q)/(p^2 + alpha^2 q^2) = 1/2 (p vt(q) - vt(p) q)\
      p vt(q) - P vt(Q) = 1/2 (p vt(q) + vt(p) q) = vt(1/2 p q)
    $
    显然，这就表明变换是正则变换
  == 6
    === (a)
      设 $u = sqrt(q) cos p, v = sqrt(q) sin p$
      计算可得：
      $
        // vt(Q) = 1/(1 + sqrt(q) cos p) (1/2 (cos p)/sqrt(q) vt(q) - sqrt(q) sin p vt(p))\
        // vt(P) = 2 (1/2 (cos p)/sqrt(q) vt(q) - sqrt(q) sin p vt(p)) sqrt(q) sin p + (1 + sqrt(q) cos p) (1/2 1/sqrt(q) vt(q) sin p + sqrt(q) cos p vt(p))
        vt(Q) = 1/(1 + u) vt(u)\
        u^2 + v^2 = q\
      $
      因此：
      $
        P vt(Q) = 2 (1 + u) v 1/(1 + u) vt(u) = 2 v vt(u) = 2 sqrt(q) sin p (1/2 (cos p)/sqrt(q) vt(q) - sqrt(q) sin p vt(p))\
        = sin p cos p vt(q) - 2 q sin^2 p vt(p)\
        P vt(Q) - p vt(q) = sin p cos p vt(q) - 2 q sin^2 p vt(p) - p vt(q)\
        = (sin p cos p - p) vt(q) - 2 q sin^2 p vt(p)
      $
      注意到：
      $
        partial/(partial p) (sin p cos p - p) = cos^2 p - sin^2 p - 1 = - 2 sin^2 p\
        partial/(partial q) (- 2 q sin^2 p) = - 2 sin^2 p
      $
      因此根据格林公式，存在 $F$ 使得：
      $
        dif F (q, p) = (sin p cos p - p) dif q - 2 q sin^2 p dif p
      $
      这表明，$P, Q$ 是正则变量。
    === (b)
      给定函数 $F_3$ 给出：
      $
        partialDer(- F_3, Q) = 2 e^Q (e^Q - 1) tan p = P\
        partialDer(- F_3, p) = ((e^Q - 1)/(cos p))^2 = q\
        e^Q = 1 + sqrt(q) cos p\
        Q = ln (1 + sqrt(q) cos p)
      $
      代回可得它就是题中给出的变换。
  // 反解得到：
  // $
  //   alpha q = p tan Q\
  //   q = (p tan Q) / alpha
  // $
  // 因此它可能具有的母函数形如 $F_4 (p, Q)$，根据变换方程：
  // $
  //   q = partialDer(-F_4, p)\
  //   P = partialDer(-F_4, Q)
  // $
  // 比照得到：
  // $
  //   dif (-F_4) = 1/alpha p tan Q dif p + (alpha)/2 q^i (1 + p^i/(alpha^2 q^2)) dif Q
  // $
  // 根据格林公式，这样的 $F_4$ 存在当且仅当：
  // $
  //   partial / (partial Q) 1/alpha p tan Q = partial / (partial p) (alpha)/2 q^i (1 + p^i/(alpha^2 q^2))
  // $
  // 上式左侧等于：
  // $
  //   1/alpha p / (cos^2 Q)
  // $
  // 右侧等于：
  // $
  //   1/2 alpha (i q^(i - 1) partialDer(q, p) + q^i/(alpha^4 q^4) (alpha^2 i p^(i - 1) q^2 - 2 p^i alpha^2 q partialDer(q, p)))
  // $
  // 只需找到 $F_2$ 使得：
  // $
  //   dif F_2 (q, P) = (1/2 alpha q^i) (1 + p^i/(alpha^2 q^2)) dif q + arctan ((alpha q) / p) dif P
  // $
  // 根据格林公式，这样的 $F_2$ 存在当且仅当：
  // $
  //   partial / (partial P) (1/2 alpha q^i) (1 + p^i/(alpha^2 q^2)) = partial / (partial q) arctan ((alpha q) / p)
  // $
  // 上式左侧等于：
  // $
  //   1/2 alpha (i q^(i - 1) partialDer(q, P) + q^i/(alpha^4 q^4) (alpha^2 i p^(i - 1) q^2 partialDer(p, P) - 2 p^i alpha^2 q partialDer(q, P))) 
  // $
  == 8
    变换形如：
    $
      vec(bQ, bP^T) = mat(A_(1 1), A_(1 2); A_(2 1), A_(2 2)) vec(bq, bp^T)
    $
    其中：
    $
      A_(1 1) = mat(1, 0;0, 0)\
      A_(1 2) = mat(0, 0;0, 1)\
      A_(2 1) = mat(0, 0;-2, -1)\
      A_(2 2) = mat(1, -2;0, 0)
    $
    因此：
    $
      vt(bQ) = A_(1 1) vt(bq) + A_(1 2) vt(bp)^T\
      bP vt(bQ) = (bq^T A_(2 1)^T + bp A_(2 2)^T) (A_(1 1) vt(bq) + A_(1 2) vt(bp)^T)\
      = bq^T A_(2 1)^T A_(1 1) vt(bq) + bq^T A_(2 1)^T A_(1 2) vt(bp)^T + bp A_(2 2)^T A_(1 1) vt(bq) + bp A_(2 2)^T A_(1 2) vt(bp)^T\
      = vt(bp) A_(2 1) bq + bp A_(2 2)^T vt(bq)\
      bP vt(bQ) - bp vt(bq) = vt(bp) A_(2 1) bq + bp (A_(2 2)^T - I) vt(bq)\
      = vt(bp) A_(2 1) bq + bp A_(2 1) vt(bq) = vt((bp A_(2 1) bq))
    $
    故，它是正则变换，$F = bp A_(2 1) bq$ 就是它的一个生成函数。
  == 11
    可以计算：
    $
      vt(bQ) = mat(q_2, q_1;1, 1) vt(bq)\
      bP vt(bQ) = ((p_1 - p_2)/(q_2 - q_1) + 1, (q_2 p_2 - q_1 p_1)/(q_2 - q_1) - (q_2 + q_1)) mat(q_2, q_1;1, 1) vt(bq)\
      = (p_1 - q_1, p_2 - q_2) vt(bq)\
      bP vt(bQ) - bp vt(bq) = - bq^T vt(bq) = vt(- bq^T bq)
    $
    因此是正则变换
  == 15
    可以计算：
    $
      vt(Q) = alpha (vt(p) x - p vt(x))/x^2\
      P vt(Q) = alpha beta (vt(p) x - p vt(x))\
      P vt(Q) - p vt(x) = - (1 + alpha beta) p vt(x) + alpha beta vt(p) x 
    $
    为使上式是全微分，必须：
    $
      partial/(partial p) (- (1 + alpha beta) p) = partial/(partial x) (alpha beta x) \
      - (1 + alpha beta) = alpha beta\
      alpha beta = - 1/2
    $
    此时：
    $
      P vt(Q) - p vt(x) = vt(- 1/2 p x)
    $
    对于线性谐振子，有：
    $
      H' = H = 1/2 (p^2/m + m omega^2 x^2)\
      = 1/2 ( (x^2 Q^2)/(m alpha^2) + (m omega^2 P)/beta)\
      = 1/2 ( (P Q^2)/(m alpha^2 beta) + (m omega^2 P)/beta)
    $
    取 $beta = m, alpha = - 1/2 1/m$，则：
    $
      H' = 1/2 ( 4 P Q^2 + omega^2 P)
    $
    正则方程给出：
    $
      vt(Q) = partialDer(H', P) = 2 Q^2 + 1/2 omega^2\
      1/(4 Q^2 + omega^2) dif Q = 1/2 dif t\
      1/(1 + (2 Q / omega)^2) dif Q = 1/2 omega^2 dif t\
      1/(1 + (2 Q / omega)^2) dif (2 Q / omega) = omega dif t\
      omega t + C = arctan (2 Q / omega)\
      Q = 1/2 omega tan (omega t + C)\
      vt(P) = - partialDer(H', Q) = - 4 P Q\
      1/P dif P = - 4 Q dif t = - 2 omega tan (omega t + C) dif t\
      ln P = 2 ln cos (omega t + C') + C''\
      P = A cos^2 (omega t + C')
    $
    反解出：
    $
      x = A/m cos (omega t + C')
    $