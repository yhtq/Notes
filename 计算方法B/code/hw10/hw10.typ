#import "../../../template.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
（前几道题上次作业写过了）
= 15.
  计算：
  $
    tr(B_k + (y_k y_k^T)/(y_k^T s_k) - (B_k s_k s_k^T B_k)/(s^T_k B_k s_k)) = tr(B_k) + tr((y_k y_k^T)/(y_k^T s_k)) - tr((B_k s_k s_k^T B_k)/(s^T_k B_k s_k))\
    = tr(B_k) + tr((y_k^T y_k)/(y_k^T s_k)) - tr((s_k^T B_k B_k s_k)/(s^T_k B_k s_k))\
    = tr(B_k) + norm(y_k^T y_k)^2/(y_k^T s_k) - norm(s_k^T B_k B_k s_k)^2/(s^T_k B_k s_k)\
  $