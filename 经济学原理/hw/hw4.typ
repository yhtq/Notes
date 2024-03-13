#import "../../template.typ": *
#show: note.with(
  title: "作业3",
  author: "YHTQ  ",
  date: none,
  logo: none,
  withOutlined: false
)
#set heading(numbering: none)
= 一、
1. D
    $
    E_p = elasticity(P, Q) = elasticity(P, 10 / P) 
    \ = -(10 / P^2) / (10 / P^2) = - 1
    $
2. B
    
    偏好与收入无关
3. A
    #align(center,image("image/image1.png", width: 200pt))
= 二、
1.(1)
    #align(center,image("image/image2.png", width: 200pt))
  (2)
    #align(center,image("image/image3.png", width: 200pt))
2.
(1) 不完备，个子小、跑得慢与个子大、跑得快之间无法比较\
(2) 完备，记 $A, B$ 的三项指标分别为 $(x_1, y_1, z_1), (x_2, y_2, z_2)$，则：
$
x_1 - x_2, y_1 - y_2, z_1 - z_2
$ 
由抽屉原理至少有两个同号，因此可以在这两个指标上比较大小。但它是不传递的。考虑：
$
A_1 = (10, 10, 0), A_2 = (10, 9, 21), A_3 = (9, 11, 20)
$
即有 $A_1 >= A_2 >= A_3$，但 $A_1 >= A_3$ 不成立

= 三、
    - 完备性是显然的
    - 传递性：设 $(x_1, y_1) >= (x_2, y_2) >= (x_3, y_3)$
        - 若 $x_1 > x_2$
            - 此时必有 $x_2 >= x_3$ ，则 $x_1 > x_2 >= x_3 => (x_1, y_1) >= (x_3, y_3)$
        - 若 $x_1 = x_2$，从而 $y_1 >= y_2$
            - 若 $x_2 > x_3$，则 $x_1 = x_2 > x_3 => (x_1, y_1) >= (x_3, y_3)$
            - 若 $x_2 = x_3$，从而 $y_2 >= y_3$，则 $y_1 >= y_2 >= y_3 => (x_1, y_1) >= (x_3, y_3)$
    - 严格凸性：设 $(x_1, y_1) >= (x_2, y_2)$
        - 若 $x_1 = x_2$，则退化为第二分量比较，也即 $R$ 上的通常序关系，满足严格凸性
        - 若 $x_1 != x_2$，则退化为第一分量比较，同样相当于 $R$ 上的通常序关系满足，严格凸性

