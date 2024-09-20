#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "并行与分布式计算基础",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
)
= 前言
  + 教师：杨超 chao_yang\@pku.edu.cn 智华楼 333
  + 给分：作业 50% + 期末（闭卷考试） 50%
  + 主要内容：MPI（分布式体系）, OpenMP（共享内存体系）, CUDA（GPU众核）
  - 计算能力的度量:
    通常使用 FLOPS（floating point operations per second，每秒浮点运算次数）来度量计算能力
  - 并行计算的原因：
    性能 = 主频 #math.times 核数 \
    功耗 = 性能 #math.times $"电压"^2$\
    电压 = 主频
    提升主频导致功耗爆炸，只能提升核数
  - 异构设计的原因：达成高性能和多功能的平衡
  并行计算往往需要设计专门的算法，例如 FFT 对于通常的串行机器是很好的算法，但在分布式计算中不够理想

  == 课程内容
  - 硬件架构
  - 并行算法
  - 并行编程
  == 并行计算的关注点
  - 到解时间 Time to Solution
  - 伸缩性 Scalability
  - 效率/功耗 Efficiency
  - 并发度/数据局部性 Concurrency/Data Locality
  - 容错性 Resiliency
  - 可编程性 Programmability
  - 加速比：当处理器个数增多时，完成任务所需时间的减少比例
  - 理想加速比：处理器个数增加比例（假设处理器是同构的）
  - 并行效率：加速比与处理器个数的比值
  == 并行计算的三大定律
    #proposition[阿姆达尔][
      记 $alpha in [0, 1]$ 是某任务无法并行计算的部分，假设其工作量固定，则该问题的加速比满足 $S(n) < 1/ alpha$
    ]
    #proof[
      假设串行执行时间为 $1$，则不难验证 $n$ 核并行执行时间不小于 $alpha + (1-alpha)/n > alpha$，故 $S(n) = 1/(alpha + (1-alpha)/n) < 1/alpha$
    ]
    #remark[][
      这个定律表明并行计算对于速度的提升是有上限的，因此早期人们对并行加速十分悲观。1985 年 Karp 打赌没人在十年内为三个实际应用做到 200 倍的并行加速。两年之内确实没有人做到，而两年几人就实现了 400-600 倍加速。
    ]
    #proposition[古斯塔法森][
      记 $alpha in [0, 1]$ 是某任务无法并行计算的部分，保持处理时间恒定，令工作量随着处理器个数增加，此时加速比 $S'(n)$ 不存在上界
    ]
    #proof[
      假设单处理器单位时间工作量为 $W$，则 $n$ 个处理器时工作量为：
      $
      W' = alpha W + (1 - alpha) n W
      $
      加速比为：
      $
      W' / W = alpha + (1 - alpha) n
      $
    ]
    #proposition[孙-倪][
      记 $alpha in [0, 1]$ 是某任务无法并行计算的部分，假设该任务可并行部分随着处理器个数 $n$ 按照因子 $G(n)$ 缩放，则加速比 $S''(n) = (alpha + (1 - alpha) G(n))/(alpha + (1 - alpha)G(n)/ n)$，这里 $G(n)$ 往往用于描述内存受限的因素。
    ]
    #example[][
      设矩阵乘法的计算复杂度是 $2 N^3$，存储复杂度为 $3 N^2$，假设内存规模为 $x$，对应的最大数据规模为 $(x/3)^(1/2)$，因此：
      $
      G(n) = 3 (((n x)/3)^(1/2))^3 / (3 (((x)/3)^(1/2))^3) = n^(3/2)
      $
      （也就是假设内存和处理器都扩大 $n$ 倍，能够达成的数据规模对应的运行时间比）
    ]
    #definition[计算密度][
      计算密度是指单位时间内的计算量与数据量的比值。通常情况下，有：
      $
      "flip"/"second" = min{"peak_flops", "带宽" * "计算密度"}
      $
    ]
    #definition[单层 AMAT 模型][
      假设只有一级缓存，其中 $T_s$ 是缓存访问时间，$T_m$ 是主存访问时间，$r$ 是缓存失效率，则：
      $
      "AMAT(Average Memory Access Time)" = T_s + r T_m
      $
    ]
    #definition[多层 AMAT 模型][
      假设有 $n$ 级缓存，其中 $T_s$ 是最后一级缓存访问时间，$T_m$ 是主存访问时间，$r_i$ 是第 $i$ 级缓存整体失效率（也即改层即之前的缓存全部失效的概率），则：
      $
      "AMAT(Average Memory Access Time)" = T_s + r_1 T_1 + r_2 T_2 + ... + r_n T_n
      $
    ]
    == 共享内存模型
      #definition[PRAM 模型][
        并行随机访问机（Parallel Random Access Machine）是一种抽象的计算模型，其中有 $p$ 个处理器，且：
        - 所有处理器共享一个连续的内存空间
        - 每个处理器执行互相独立的命令
        - 处理器执行任何一种访存操作的时间是常数
      ]
      显然共享内存会产生访存冲突，往往会产生如下策略：
      - EREW（Exclusive Read Exclusive Write）：进行读写时，只有一个处理器能够访问
      - CREW（Concurrent Read Exclusive Write）：多个处理器可以同时读，但只有一个处理器能够写
      - ERCW（Exclusive Read Concurrent Write）：只有一个处理器能够读，但多个处理器可以写
      - CRCW（Concurrent Read Concurrent Write）：多个处理器可以同时读写
      其中并发写往往会产生冲突，因此又有如下策略：
      - Common：多个处理器写入相同的值，不需要处理
      - Arbitrary：多个处理器随机写入，只有一个写入成功
      - Priority：多个处理器写入，按照优先级决定
      - Reduction：多个处理器写入，结果是所有写入的值的某种函数
    == 分布式计算模型
      将计算节点（compute node）通过网络连接起来，每个节点有自己的内存和处理器，节点之间通过消息传递进行通信，往往需要经过某种路由设备。节点之间往往构成一个拓扑结构。
      - 跳（hop）：拓扑网络上一点到另一点的最短路径
      - 网络直径（diameter）：拓扑网络上最长的跳数
      - 二分宽度（bisection width）：将网络分成两半的最小切割数
      #definition[$alpha-beta$ 通信模型][
        网络通信时间由时延 $alpha$，带宽 $1/beta$，消息长度 $L$ 决定，通常有：
        $
        T = alpha + L * beta
        $
      ]
      #definition[BSP 模型][
        BSP (Bulk Synchronous Parallel) 模型是一种并行计算模型，其中有 $p$ 个处理器。计算过程分为多个超步，每个超步之内处理器单独计算，超步结束时处理器之间进行通信，同步所有状态。
      ]

