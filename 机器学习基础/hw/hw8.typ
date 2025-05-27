#import "../../template.typ": *
#import "../main.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: false
)
= (1)
  + 计算 $X^T X$ 的非零特征值 $lambda_i$ 和对应特征向量 $v_i$，不妨设 $lambda_i$ 从大到小排列
  + 记 $u_i = 1/sqrt(lambda_i) X v_i$，则：
    $
      X = sum_(i = 1)^r X v_i v_i^T = sum_(i = 1)^r sqrt(lambda_i) u_i v_i^T
    $
  + 则其前 $k$ 主成分为：
    $
      X_k = sum_(i = 1)^k sqrt(lambda_i) u_i v_i^T
    $