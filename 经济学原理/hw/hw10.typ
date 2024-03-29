#import "../../template.typ": *
#show: note.with(
  title: "作业8",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withTitle: true
)
= 
  == 
    令 $Q_1 = Q_2$，得：
    $
    1000 - 5 P = 4 P - 80 => P = 120, Q = 400
    $
    总支出为：
    $
    P Q = 48000
    $
    生产者剩余为：
    $
    integral_(Q = 0)^400 (120 - P_1 (Q)) d Q = integral_(P = 20)^120 4 (120 - P) d P = 20000
    $
    消费者剩余为：
    $
    integral_(Q = 0)^400 (P_2 (Q) - 120) d Q = integral_(P = 120)^200 5(P - 120) d P = 16000
    $
  ==
    新的成交价格为：
      $
      300 = 1000 - 5P' => P' = 140
      $
    此时生产者剩余与消费者剩余的和为：
    $
    integral_(Q = 0)^300 (140 - P_1 (Q)) d Q + integral_(Q = 0)^300 (P_2 (Q) - 140) d Q = integral_(Q = 0)^300 (P_2 (Q) - P_1 (Q)) d Q = integral_(Q = 0)^300 (200 - 1/5 Q - (20 + 1/4 Q)) d Q = 33750
    $
    损失为：
    $
    36000 - 33750 = 2250
    $
  ==
    新的均衡价格满足：
    $
      1270 - 5 P = 4 P - 80 => P = 150, Q = 520
    $
    生产者剩余为：
    $
    integral_(Q = 0)^520 (150 - P_1 (Q)) d Q = integral_(P = 20)^150 4 (150 - P) d P = 33800
    $
    消费者剩余为：
    $
    integral_(Q = 0)^520 (P_2' (Q) - 150) d Q = integral_(P = 150)^254 5(P - 150) d P = 27040
    $
  == 
    最高价格 $P_m = 120$，市场成交数量 $Q = 400$
    生产者剩余变为：
    $
      integral_(Q = 0)^400 (120 - P_1 (Q)) d Q = 20000
    $
    消费者剩余变为：
    $
      integral_(Q = 0)^400 (P_2' (Q) - 120) d Q = integral_(P = 174)^254 5(P - 120) d P = 37600
    $
    无谓损失为：
    $
    33800 + 27040 - 20000 - 37600 = 3240
    $
=
  ==
    当市场价格为 $P$ 时。为了满足边际成本等于边际收益，每个生产者的生产量 $q$ 将满足
    $
    P = q + 10 => q = P - 10
    $
    市场供给为：
    $
    q = cases(
      100P - 1000 space P >= 10,
      0 space P < 10 
    )
    $
  ==
    均衡价格满足：
    $
    100 P - 1000 = 1100 - 50 P => 150 P = 2100 => P = 14
    $
    成交量为 $Q = 400$\
    生产者剩余为：
    $
      integral_(Q = 0)^400 (14 - P_1 (Q)) d Q = integral_(P = 10)^14 100 (14 - P) d P = 800
    $
  == 
    设新的均衡价格为 $P$，则应有：
      $
      100 (P - 3) - 1000 = 1100 - 50 P => P = 16
      $
    均衡数量为 $Q = 300$\
  ==
    总计税收为 $300 * 3 = 900$，其中生产者承担 $(14-13)/3 = 1/3$，消费者承担 $2/3$
  ==
    新的生产者剩余为：
    $
     integral_(Q = 0)^300 (13 - P_1 (Q)) d Q = integral_(P = 10)^13 100 (13 - P) d P = 450
    $
    总计损失为 $800 - 450 = 350$