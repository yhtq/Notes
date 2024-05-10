#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark, proposition,der, partialDer, Spec
#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "作业4",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
#let ex(n) = $e^(#ignoreOne(n) x)$
= p189
  == 1
    === (1)
      先计算特征值：
      $
      0 = Det(2 - lambda, 1; 3, 4 - lambda) = (2 - lambda)(4 - lambda) - 3 = lambda^2 -6 lambda + 5
      $
      解得特征值 $1, 5$，分别对应特征向量：
      -
        $
        mat(1, 1;3, 3) xi_1 = 0, xi_2 = vec(1, -1)
        $
      - 
        $
        mat(-3, 1;3, -1) xi_5 = 0, xi_5 = vec(1, 3)
        $
      因此一个基础解矩阵为：
        $
        (ex(1) vec(1, -1), ex(5) vec(1, 3))
        $
    === (3)
      $
      0 = Det(2 - lambda, -1, 1;1, 2 - lambda, -1;1, -1, 2 - lambda)\
      = Det(2 - lambda, -1, 1;1, 2 - lambda, -1;0, lambda - 3, 3 -lambda)\
      = Det(2 - lambda, 0, 1;1, 1 - lambda, -1;0, 0, 3 -lambda)\
      = (3-lambda)(1-lambda)(2-lambda)
      $
      特征值分别为 $1, 2, 3$，分别对应特征向量：
      - 
        $
        mat(1, -1, 1;1, 1, -1;1, -1, 1) xi_1 = 0, xi_1 = vec(0, 1, 1)
        $
      - 
        $
        mat(0, -1, 1;1, 0, -1;1, -1, 0) xi_2 = 0, xi_2 = vec(1, 1, 1)
        $
      -
        $
        mat(-1, -1, 1;1, -1, -1;1, -1, -1) xi_(3) = 0, xi_(3) = vec(1, 0, 1)
        $
      因此一个基础解矩阵为：
        $
        (ex(1) vec(0, 1, 1), ex(2) vec(1, 1, 1), ex(3) vec(1, 0, 1))
        $
    === (5) 
      $
      0 &= Det(4 - lambda, -1, -1;1, 2 - lambda , -1; 1, -1, 2 - lambda)\
        &= Det(4 - lambda, -1, -1;0, 3 - lambda , lambda - 3; 1, -1, 2 - lambda)\
        &= Det(4 - lambda, -2, -1;0, 0 , lambda - 3; 1, 1 - lambda, 2 - lambda)\
        &= -(lambda - 3)((4 - lambda)(1- lambda) + 2)\
        &= -(lambda - 3)(lambda^2 - 5 lambda + 6)\
        &= -(lambda - 3)(lambda - 2)(lambda - 3)
      $
      特征值为 $2, 3$，计算特征向量：
      - 
        $
        mat(2, -1, -1;1, 0 , -1; 1, -1, 0) xi_2 = 0, xi_2 = vec(1, 1, 1)
        $
      - 
        $
        mat(1, -1, -1;1, -1 , -1; 1, -1, -1) xi_3 = 0, xi_3 = vec(1, 0, 1), vec(1, 1, 0)
        $
      从而原矩阵可对角化，一个基础解矩阵为：
      $
      mat(ex(2) vec(1, 1, 1), ex(3) vec(1, 0, 1), ex(3) vec(1, 1, 0))
      $
    === (7)
      $
      0 &= Det(
            3 - lambda, -2, -1;
            3, -4 - lambda, -3;
            2, -4, - lambda
              )\
        &= Det(
            3 - lambda, -2, -1;
            1, - lambda, -3 + lambda;
            2, -4, - lambda
              )\
        &= Det(
            3 - lambda, -2, -1;
            1, - lambda, -3 + lambda;
            0, 2 lambda - 4, - 3 lambda + 6
              )\
        &= (lambda - 2) Det(
            3 - lambda, -2, -1;
            1, - lambda, -3 + lambda;
            0, 2, - 3 
              )\
        &= (lambda - 2) Det(
            3 - lambda, 0, -4;
            1, - lambda, -3 + lambda;
            0, 2, - 3 
              )\
        &= (lambda - 2)(-2 ((3 - lambda)(lambda - 3) + 4) - 3(-lambda)(3- lambda))\
        &= (lambda - 2)(2 (lambda^2 - 6 lambda  + 9 - 4) - 3lambda(lambda - 3))\
        &= (lambda - 2)(-lambda^2 - 3 lambda + 10)\
        &= -(lambda - 2)(lambda^2 + 3 lambda - 10)\
        &= -(lambda - 2)(lambda + 5)(lambda - 2)\
      $
      特征值为 $-5, 2$，分别对应特征向量：
      -
        $
          mat(
            8, -2, -1;
            3, 1, -3;
            2, -4, 5
              ) xi_(-5) = 0, xi_(-5) = vec(1, 3, 2)
        $
      -
        $
        mat(
            1, -2, -1;
            3, -6, -3;
            2, -4, - 2
              ) xi_2 = 0, xi_2 = vec(1, 0, 1), vec(0, 1, -2)
        $
      因此矩阵可对角化，一个基础解矩阵为：
      $
      (ex(-5) vec(1, 3, 2), ex(2) vec(1, 0, 1), ex(2) vec(0, 1, -2))
      $


