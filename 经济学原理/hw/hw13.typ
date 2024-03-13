#import "../../template.typ": *
#show: note.with(
  title: "作业13",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false,
  withTitle: true
)
= C
  垄断竞争市场中企业的决策对其他企业几乎没有影响，寡头垄断市场有显著影响
=
  ==
    +
      均衡时有：
        $
        L = 100 w = - 50 w +450\
        w = 3, L = 300\
        $
    +
      设每个劳动力的补助为 $x$ 将有：
        $
        L' = 100 w = 450 - 50(w - x)\
        w = 4
        $
      解得：
        $
        L' = 400\
        x = 3
        $
      总补助量为 $3 times 400 = 1200$
    +
      此时 $L_1 = 100 * 4 = 400, L_2 = 450 - 50 * 4 = 250$，有 $150$ 人失业
  ==
    + 
      合谋时，即是最大化：
        $
        (80 - 0.4(Q_1 + Q_2)) (Q_1 + Q_2) - 4 Q_1 - 0.4 Q_2^2
        $
      分别求两个偏导有：
        $
        80 - 0.4 Q_2 - 0.8 Q_1 - 4 = 0\
        80 - 0.4 Q_1 - 0.8 Q_2 - 0.8 Q_2 = 0\
        $
      也即：
        $
        Q_1 = 90\
        Q_2  = 5
        $
      此时价格为：
        $
        80 - 0.4*95 = 42
       $
      
      总利润为：
        $
        42 * 95 - 4 * 90 - 0.4 * 5^2 =  3620
        $
    +
      假设波音公司宣布其产量为 $a_n$，则空客公司需要最大化：
        $
        (80 - 0.4 (Q + a_n))Q - 0.4 Q^2
        $
      求导得：
        $
        80 - 0.4 a_n - 0.8 Q - 0.8 Q = 0\
        1.6 Q = 80 - 0.4 a_n\
        Q = 50 - 0.25 a_n
        $
      波音公司在此条件下，最优化：
        $
        (80 - 0.4(Q + Q'))Q' - 4 Q' 
        $
      求导得：
        $
        80 - 0.4 Q - 0.8 Q' - 4 = 0\
        Q' = 95 - 0.5 Q = 70 + 1/8 a_n
        $
      此为下一轮波音公司的产量 $a_(n+1)$，因此有：
        $
        a_(n+1) = 70 + 1/8 a_n\
        a_(n+1) - 80 = 1/8 (a_n - 80)
        $
      从递归式可以看出无论 $a_1$ 取何值，均有：
        $
        a_n - 80 -> 0 => a_n -> 80
        $
      因此波音公司的均衡产量为 $80$，空客公司为 $30$，价格为 $80 - 0.4(80 + 30) = 36$\
      波音公司的利润为：
      $
      36 * 80 - 4 * 80 = 2560
      $
      空客公司的利润为：
      $
      30 * 30 - 0.4 * 30^2 = 720
      $