#import "../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../template.typ": *
#show: note.with(
  title: "并行与分布式计算基础",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
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
      这个定律表明并行计算对于速度的提升是有上限的，因此早期人们对并行加速十分悲观。1985 年 Karp 打赌没人在十年内为三个实际应用做到 200 倍的并行加速。两年之内确实没有人做到，而两年之后几人就实现了 400-600 倍加速。
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
= MPI（Message Passing Interface）
  MPI 是一种消息传递接口，是一种标准。
  == 进程定位
    在 MPI 中，每个进程处在一个通信域（communicator）中，每个通信域有一个唯一的标识符，可以通过这个标识符来定位进程。通信域中每个进程有一个标识符，称为 rank
  == 阻塞/非阻塞通信
  == 点对点通信
  == 集合通信
  == 程序的并行性
    #definition[][
      对于两个程序（进程）$P_1, P_2$，记 $I(P), O(P)$ 分别为 $P$ 程序需要读取/写入的数据集合
    ]
    #theorem[Bernstein][
      两个程序 $P_1, P_2$ 可以并行执行，记作 $P_1 || P_2$，如果 $O(P_1) sect I(P_2) = emptyset$ 且 $O(P_2) sect I(P_1) = emptyset$ 且 $O(P_1) sect O(P_2) = emptyset$
    ]
    #definition[][
      不满足 Bernstein 条件的程序会产生竞争条件和数据依赖，也就是两个进程同时访问了相同数据，且至少有一个进程写入了数据。这样的并行程序如果直接执行，其结果将不能确定。具体而言，数据依赖常常分为：
      - 流依赖：read after write，RAW
      - 反依赖：write after read，WAR
      - 输出依赖：write after write，WAW
    ]
    本质上，只有流依赖是不可消除的。
    #definition[][
      当且仅当所有不可消除（有些数据依赖是可消除的，例如多个数求和即使产生输出依赖也不影响结果）的程序依赖得以满足后，并行程序满足串行一致性。
    ]
= OpenMP
  仅仅依靠消息传递进行并行编程是不足的。OpenMP 是基于线程的共享存储的并行编程模型。OpenMP 基于 PRAGMA 指导语句进行，常用的包括：
  -  ```#pragma omp parallel [clause*]``` 开启并行区，其中常见的从句包括：
    - if 从句，指定是否开启并行区
    - num_threads 从句，指定线程数
    - private 从句，指定私有变量列表（并行区内部，for 循环内的变量都会被认为是私有变量）
    - shared 从句，指定共享变量列表
    - default 从句，指定默认共享/私有变量，安全期间可以设为 none，强制指定所有变量
    - firstprivate 从句，其中的变量是私有变量，但会自动初始化为主线性中的值
    - reduction 从句，指定归约变量，是指私有变量，但最终将以某个操作符进行归约
  - ```#pragma omp for [clause*]``` 开启 for 循环并行化，需要在并行区内进行
  - ```#pragma omp parallel for [clause*]``` 开启并行区并行化 for 循环
  == for 循环限制
    为了 OpenMP 可以实现，for 循环的格式有严格限制，包括：
    - 开始语句：必须是 ```c i = 0``` 这种变量 $=$ 初值
    - 终止语句：必须是变量与边界值的大小关系
    - 计数语句：必须是等步的加或减
    - 不能使用 break, goto, return 等跳转
    - 循环变量必须是整数，初值、边界和增量在循环中固定 
  == for 循环中的数据依赖
    在 for 循环中很容易写出数据依赖，例如：
    ```c
    for (int i = 1; i < n; i++){
      x = b[i] + c[i];
      a[i] = a[i+1] + 1 + x;
    }
    ```
    这样的 for 循环不能直接并行化。其中的 `x, a[i]` 都会产生数据依赖问题，一般可以如下解决：
    -  对于 `x` ，我们应该将其设成线程的私有变量
    - 对于 `a[i+1]`，我们可以复制一份 `a`，然后再循环中访问复制的 `a`
    对于并行区内的代码，还有一些特殊构造保证线程安全，包括：
    - ```#pragma omp barrier``` 用于同步线程
    - ```#pragma omp critical``` 表明这段代码所有线程都要执行，但同时只有一个线程执行
    - ```#pragma omp atomic``` 表明这段代码是原子的，效果类似于 critical，但是更高效，只能在极少数操作中进行
  == orphaning
    程序中并行区调用的函数未必在并行区之中。对于这种情况，并行区之外的代码称为 orphaning，这种情况下我们可以同样使用上面的指导语句等等，编译时会自动生成两份代码，一份是串行的，一份是并行的。
  == 嵌套并行区
    OpenMP 默认开启嵌套并行区，也可以手动关闭。关闭后，嵌套并行区仍会开启，但只会分裂一个线性运行。
  == 松弛一致性
    OpenMP 采用松弛一致性。数据在缓存中未必随时更新，一些同步操作（例如并行区入口，barrier 操作）会自动调用更新，也可以使用 flush 手动更新。例如假设有共享变量 `x`，希望在一个线程更新后，另一个线程能够捕捉到更新，就需要在更新后手动调用 flush。
  == 线程亲和性
    在 NUMA 架构中，我们需要决定线程如何分配到处理器上。既可以集中分布，也可以分散分布。可以手动进行线程绑定来固定映射策略。一般来说，我们也可以利用 numactl 工具来进行线程绑定。
= GPU/CUDA
  CUDA 的使用方式主要有：
  - 使用现有的计算库，性能经过专业人员调优
  - 使用 OpenACC，理念接近于 OpenMP，通过编译制导语句快速实现多核/GPU 并行执行
  - 使用 CUDA 编程语言，直接调用 GPU 的 API
  NVIDIA GPU 的架构大致可以分为：
  - 一个 GPU 包含多个 Streaming Multiprocessor（SM），SM 之间共享 L2 cache，每个 SM 包含多个 Streaming Processor（SP），SP 之间共享 L1 cache
  - SP 包括单精度核心，双精度核心，特殊函数核心等
  - GPU 与 CPU 的数据传输主要通过 PCIE，速度大约在 30 GB/s
  - GPU 与 GPU 之间的数据传输可以通过 NVLink，速度大约在 300 GB/s
  从软件的角度来说：
  - 每个 SM 中的核都是 SMT （Single Instruction Multiple Thread）的。每 32 个线程一组构成线程簇 warp，同一个 warp 中是相同程序，不同数据进行并发的
  通常来讲，CUDA 代码分为两部分：
  - host 代码，也就是由 CPU 执行的代码
  - kernel 代码，也就是由 GPU 执行的代码。具体执行时，需要指定一个线程网格，每个线程网格包含多个线程块，每个线程块包含多个线程。换言之，每个线程的索引是三维的。