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
  - 执行率：每个处理器单位时间能完成的工作量
  - 加速比：当处理器个数增多时，完成任务所需时间的减少比例
  - 理想加速比：处理器个数增加比例（假设处理器是同构的）
  - 并行效率：加速比与处理器个数的比值
  == 常用数据量度量
    对于较大的数据规模，常用以下度量单位：
    - K: $10^3$
    - M: $10^6$
    - G: $10^9$
    - T: $10^12$
    - P: $10^15$
    - E: $10^18$
    - Z: $10^21$
    - Y: $10^24$
    天河二号采用 CPU-MIC 异构计算，也就是大量 CPU 以及 Xeon Phi 作为加速器，达到了 54.9 PFLOPS 的总性能
  == 福林分类
    从指令流和数据流的角度，可以将并行计算分为：
    - SIMD（Single Instruction Multiple Data）：一条指令流作用于多个数据
    - MIMD（Multiple Instruction Multiple Data）：多条指令流作用于多个数据
    - SISD（Single Instruction Single Data）：一条指令流作用于一个数据
    - MISD（Multiple Instruction Single Data）：多条指令流作用于一个数据
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
      G(n) = (2 (((n x)/3)^(1/2))^3) / (2 (((x)/3)^(1/2))^3) = n^(3/2)
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
        网络通信时间由时延 $alpha$，带宽 $1/beta$，消息长度 $L$ 决定（也就是忽略网络的拓扑结构），通常有：
        $
        T = alpha + L * beta
        $
      ]
      #definition[BSP 模型][
        BSP (Bulk Synchronous Parallel) 模型是一种并行计算模型，其中有 $p$ 个处理器。计算过程分为多个超步，每个超步之内处理器单独计算，超步结束时处理器之间进行通信，同步所有状态。

        如果采用 BSP 结构，程序运行时间大约为：
        $
          sum_(s = 1)^S w_s + g sum_(s = 1)^S h_s + l S
        $
        其中：
        - $S$ 是总超步数量
        - $g$ 是每单位消息的通信时间（带宽的倒数）
        - $l$ 是每次栅栏同步的时间
        - $w_s$ 是第 $s$ 超步的最大计算时间
        - $h_s$ 是第 $s$ 超步的最大消息量
      ]
      有些时候，BSP 架构的程序也可以实现本地计算与全局通信重叠，运行时间可以进一步减少。同时，这样的估算忽略了通信的延迟，传输 $m$ 各长度为 $1$ 的消息的开销等于传输一个长度为 $m$ 的消息的开销，这是不现实的。因此有更精细的模型，例如 LogP 模型。
    == 并行编程模型
      - 并行计算的八字原则：*“负载均衡，通信极小”*
      - 并行计算的基本形式：主从并行，流水线并行，工作池并行，功能分解，区域分解，递归分治等
      主要的并行编程模型包括：
      - 自动并行
      - 共享内存并行：OpenMP 等，以线程为单位
      - 消息传递：MPI 等
      - 数据并行：CUDA/OpenCL 等
      - 多种混合
= MPI（Message Passing Interface）
  MPI 是一种消息传递接口，是一种标准。它独立于编程语言，已经在多个语言上有高效、可靠的标准，已经成为事实上的工业标准。MPI 最早发布于 1994 年，主要实现版本包括：
  - MPICH
  - OpenMPI
  - Intel MPI
  - MS-MPI 

  MPI 的主要模型是机器由若干可以互相通讯的进程组成。进程拥有私有的存储空间，没有任何共享存储。消息传递通过显式的发送和接收消息来实现。程序往往是 SPMD （single program multiple data）的，用相同的程序操作不同的数据。
  == 进程定位
    在 MPI 中，每个进程处在一个通信域（communicator）中，每个通信域有一个唯一的标识符，可以通过这个标识符来定位进程。通信域中每个进程有一个标识符，称为 rank

    - ```c int MPI_Comm_size(MPI_Comm comm, int *size)``` 返回通信域中的进程数
    - ```c int MPI_Comm_rank(MPI_Comm comm, int *rank)``` 返回当前进程在通信域中的标识符

    注意同一个进程可能属于不同的通信器，因此可能具有不同的 rank
  == 通信
    === 点对点通信
      MPI 中最基本的通信手段是点对点通讯，使用以下一对函数：
      - ```c int MPI_Send(void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm)``` 发送消息
      - ```c int MPI_Recv(void *buf, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Status *status)``` 接收消息
      通常，一对的发送和接收应当使用相同的长度。如果发送的长度超出接收，MPI 可能会报错。

      接收函数中 `status` 函数用于保存函数返回的通信状态，包括消息的来源，长度，tag，报错信息等

      对于一对的发送接收，有如下便捷的函数：
      ```c 
      int MPI_Sendrecv(void *sendbuf, int sendcount, MPI_Datatype sendtype, int dest, int sendtag, void *recvbuf, int recvcount, MPI_Datatype recvtype, int source, int recvtag, MPI_Comm comm, MPI_Status *status)```
      ```c
      int MPI_Sendrecv_replace(void *buf, int count, MPI_Datatype datatype, int dest, int sendtag, int source, int recvtag, MPI_Comm comm, MPI_Status *status)
      ```

      注意 MPI_Send 的阻塞行为是不确定的。在 MPI 中有如下三种发送模式：
      - 同步模式：发送方直接启动发送，将数据写入缓冲区，接收端启动接收后，发送方才会返回
      - 就绪模式：仅当对方接收操作启动且就绪时，才发送数据，否则报错。不需要缓冲区和握手。
      - 缓冲模式：发送方直接启动发送，将数据写入缓冲区，然后直接返回。
      标准的 MPI_Send 可能是同步的或者缓冲的，往往取决于消息的长短。
    === 非阻塞通信
      很多时候，我们希望通信是非阻塞的，也就是说发送和接收消息不会阻塞程序的执行。MPI 提供了如下函数：
      - ```c int MPI_Isend(void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm, MPI_Request *request)``` 
      - ```c int MPI_Irecv(void *buf, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm comm, MPI_Request *request)``` 
      其中 `request` 用来标明这个通信请求。可以使用 `MPI_Wait` 函数等待通信完成，或者使用 `MPI_Test` 来检查通信是否完成，以及 `MPI_Cancel` 来取消通信。

      有通信请求进行中时，不应当对发送和接收的缓冲区进行修改，否则可能会导致未定义行为。

      对于一批非阻塞通信，有 `MPI_(Test|wait)(all|any|some)` 等函数，用于等待一组通信请求完成。
    === 集合通信
      MPI 中有许多集合通信函数，用于使某个通信器内所有进程进行通信。常见的集合通信函数有：
      - ```c int MPI_Barrer(MPI_Comm comm)``` 所有进程在这个函数处等待，直到所有进程都到达这个函数
      - ```c int MPI_Bcast(void *buf, int count, MPI_Datatype datatype, int root, MPI_Comm comm)``` 从根进程向所有进程广播消息
      - ```c int MPI_Reduce(void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm)``` 将所有进程的数据进行归约
      - ```c int MPI_Scatter(void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf, int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm)``` 将根进程的数据分发给所有进程，每个进程收到数据的不同片段。注意其中 `sendcount` 是指给每个进程发送的数据量
      - ```c int MPI_Gather(void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf, int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm)``` 将所有进程的数据收集到根进程，注意其中 `recvcount` 是指从每个进程收到的数据量
      - ```c int MPI_Allreduce(void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)``` 将所有进程的数据进行归约，然后广播给所有进程
      - ```c int MPI_Scan(void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)``` 计算数据的前缀和，将每个前缀和分给不同进程
      - ```c int MPI_Allgather(void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf, int recvcount, MPI_Datatype recvtype, MPI_Comm comm)``` 将所有进程的数据收集到所有进程
      - ```c int MPI_Reduce_scatter(void *sendbuf, void *recvbuf, const int *recvcounts, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)``` 将所有进程的数据进行归约，然后分发给所有进程，每个进程拿到结果的不同部分
      - ```c int MPI_Alltoall(void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf, int recvcount, MPI_Datatype recvtype, MPI_Comm comm)``` 将所有进程的数据分发给所有进程，每个进程拿到不同进程的数据。类似于将所有进程的数据做转置。
    === 通信器
      通信器是 MPI 通信的基本单位。默认的通信器是 `MPI_COMM_WORLD` 包含所有进程。可以通过以下函数创建新的通信器：
      - ```c int MPI_Comm_split(MPI_Comm comm, int color, int key, MPI_Comm *newcomm)``` 将通信器分裂为多个子通信器，其中 `color` 是子通信器的标识符，`key` 是子通信器内部的进程标识符

      此外，MPI 中每个通信器都对应一个进程组。进程组不能直接用来通信，但可以用来创建新的通信器。进程组的可用操作包括：
      - ```c int MPI_Comm_group(MPI_Comm comm, MPI_Group *group)``` 获取通信器的进程组
      - ```c MPI_Group_rank(MPI_Group group, int *rank)``` 获取进程在进程组中的标识符
      - ```c MPI_Group_size(MPI_Group group, int *size)``` 获取进程组的大小
      - ```c MPI_Group_incl(MPI_Group group, int n, int *ranks, MPI_Group *newgroup)``` 从进程组中选择一部分进程创建新的进程组
      - ```c MPI_Group_excl(MPI_Group group, int n, int *ranks, MPI_Group *newgroup)``` 从进程组中排除一部分进程创建新的进程组
      - ```c MPI_Group_union(MPI_Group group1, MPI_Group group2, MPI_Group *newgroup)``` 将两个进程组合并为一个新的进程组
      - ```c MPI_Group_intersection(MPI_Group group1, MPI_Group group2, MPI_Group *newgroup)``` 将两个进程组的交集创建为一个新的进程组
      注意在以上操作中，如果当前进程在新进程组中，`newgroup` 将会是一个新的进程组，否则将会是 `MPI_GROUP_EMPTY`
      - ```c MPI_Group_free(MPI_Group *group)``` 释放进程组

      基于进程组可以创建新的通信器：
      - ```c MPI_Comm_create(MPI_Comm comm, MPI_Group group, MPI_Comm *newcomm)``` 从进程组创建新的通信器， Comm 中每个进程都应该调用这个函数，不在进程组中的进程将得到 `MPI_COMM_NULL`
    MPI-1 还有其他特性，包括自定义数据类型和自定义虚拟拓扑等。
  == MPI-2/3 新特性
    以下是 MPI-2 的新特性：
    - 动态进程：动态改变进程数量
    - 单边通信，也称远程内存访问（RMA）
    - 增强的集合通信：允许跨通信器的集合通信
    - 外部接口：允许用户在上层封装 MPI
    - 并行 I/O：允许并行读写文件
    以下是 MPI-3 的新特性：
    - 非阻塞集合通信
    - 新的单边通信
    - 邻居集合通信
    - 内部接口
  == 程序的并行性
    #definition[][
      对于两个程序（进程）$P_1, P_2$，记 $I(P), O(P)$ 分别为 $P$ 程序需要读取/写入的数据集合
    ]
    #theorem[Bernstein][
      两个程序 $P_1, P_2$ 可以并行执行，记作 $P_1 || P_2$，如果 $O(P_1) inter I(P_2) = emptyset$ 且 $O(P_2) inter I(P_1) = emptyset$ 且 $O(P_1) inter O(P_2) = emptyset$
    ]
    #definition[][
      不满足 Bernstein 条件的程序会产生竞争条件（一般泛指并行程序得到的结果不确定）和数据依赖，也就是两个进程同时访问了相同数据，且至少有一个进程写入了数据。这样的并行程序如果直接执行，其结果将不能确定。具体而言，数据依赖常常分为：
      - 流依赖：read after write，RAW
      - 反依赖：write after read，WAR
      - 输出依赖：write after write，WAW
    ]
    本质上，只有流依赖是不可消除的。
    #definition[][
      当且仅当所有不可消除（有些数据依赖是可消除的，例如多个数求和即使产生输出依赖也不影响结果）的程序依赖得以满足后，并行程序满足串行一致性。
    ]
= OpenMP
  仅仅依靠消息传递进行并行编程是不足的。OpenMP 是基于线程的共享存储的并行编程模型，它既是一套 API 也是一套规范。线程模型通常指具有私有变量以及共享变量的指令流。线程可以看作进程的一部分，继承了进程的指令、内存空间等资源，相互独立并发执行。
  == 基本指令
    OpenMP 基于 PRAGMA 指导语句进行，常用的包括：
    -  ```#pragma omp parallel [clause*]``` 开启并行区。并行区是 OpenMP 并行操作的单元，主线程只有在并行区内部才并行执行，并行区结束时所有线程同步结束，只保留主线程。可以使用多种从句调整配置，其中常见的从句包括：
      - if 从句，指定是否开启并行区。若条件不满足，则主线程串行执行
      - num_threads 从句，指定线程数，优先于环境变量和 `omp_set_num_threads` 函数
      - private 从句，指定私有变量列表。注意并行区内部，for 循环内的变量都会被认为是私有变量，而并行区外部的变量默认是共享的。每个 private 变量应当手动重新初始化，包括主线程的私有变量（会被认为与并行区外的同名变量不同）
      - shared 从句，指定共享变量列表
      - default 从句，指定默认共享/私有变量，可选 shared 默认共享变量或者 none 每个变量都要指定。安全其间可以设为 none
      - firstprivate 从句，其中的变量是私有变量，但会自动初始化为主线性中的值
      - reduction 从句，指定归约变量，是指私有变量，但最终将以某个操作符进行归约
      注意理论上 OpenMP 允许并行区内开启新的并行区，但有些实现可能不支持。
    - ```#pragma omp for [clause*]``` 开启 for 循环并行化，需要在并行区内进行。可用从句包括：
      - shared
      - private
      - reduction
      - firstprivate
      - lastprivate：类似 private，但并行区退出时设置为最后一次循环对应线程中的值
      - schedule：用来控制调度方式，决定如何将 for 循环分成连续的块。包括：
        - static：静态分块，每个线程分到的块大小相等
        - dynamic：动态分块，分块大小固定
        - guided：动态分块，但块大小逐渐减小
        - auto：由编译器自动选择
        一般来说，chunk 越大，调度开销就更小，同时也更不灵活
      - ordered：声明循环体中有需要保序执行的部分，也就是严格按照循环顺序执行。对应部分需要用 `#pragma omp ordered` 包裹。如果有 ordered 部分，使用默认的 $n / t$ 分块，将导致所有线程等待前面的线程执行完成后才执行，几乎没有并行效果。
      - collapse(n)：将 for 并行构造应用于多重循环的第 1 到 n 层
      - nowait
    - ```#pragma omp parallel for [clause*]``` 开启并行区并行化 for 循环，允许使用的从句包括 parallel 的从句以及 for 的从句（除了nowait）
    - ```#pragma omp sections``` 开启工作共享。必须在并行区内部，其内允许使用 `section` 指令，每个 section 之间是并行的，没有顺序保证，只保证都恰好执行一次。但 section 内部是串行的。支持的从句包括 private, firstprivate, lastprivate, reduction, nowait
    - ```#pragma omp single``` 保证只有一个线程执行这段代码，其他线程等待执行完成后同步。一般用于非线程安全的任务。支持的从句包括 private, firstprivate, nowait
    此外，还有许多常用指令，包括：
    - ```c int opm_get_thread_num()``` 获取当前线程编号
    - ```c int opm_get_num_threads()``` 获取当前线程总数
    - ```c int opm_set_num_threads()``` 设置之后并行区的线程数，优先于环境变量中设置的线程数
    - ```c int opm_get_max_threads()``` 获取曾使用过的最大线程数
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
    - ```#pragma omp single``` 对并行区内的一段代码，保证只有一个线程执行，有同步
    - ```#pragma omp master``` 与 single 类似，不同的是要求主线程执行，且无同步
    - ```#pragma omp critical``` 表明这段代码所有线程都要执行，但同时只有一个线程执行
    - ```#pragma omp atomic``` 表明这段代码是原子的，效果类似于 critical，但是更高效，只能在极少数操作中进行
  == orphaning
    程序中并行区调用的函数未必在并行区之中。对于这种情况，并行区之外的代码称为 orphaning，这种情况下我们可以同样使用上面的指导语句等等，编译时会自动生成两份代码，一份是串行的，一份是并行的，不在并行区内的并行指导语句不起作用。
  == 嵌套并行区
    OpenMP 默认开启嵌套并行区，也可以手动关闭。关闭后，嵌套并行区仍会开启，但只会分裂一个线性运行。
  == 松弛一致性
    OpenMP 采用松弛一致性。数据在缓存中未必随时更新，一些同步操作（例如并行区入口，barrier 操作）会自动调用更新，也可以使用 flush 手动更新。例如假设有共享变量 `x`，希望在一个线程更新后，另一个线程能够捕捉到更新，就需要在更新后手动调用 flush。
  == 线程亲和性
    在 NUMA （非均匀访存模型，处理器不同核访问内存的开销不同）架构中，我们需要决定线程如何分配到处理器上。既可以集中分布，也可以分散分布。可以手动进行线程绑定来固定映射策略。一般来说，我们也可以利用 numactl 工具来进行线程绑定。
  == 任务并行
     OpenMP 3.0 引入了任务并行，可以用于动态创建任务，自动分配给不同线程执行。任务并行的基本指令包括：
     - ```c #pragma omp task``` 创建一个任务，支持的从句包括：
      - if
      - final
      - untied
      - default
      - mergeable
      - private
      - firstprivate
      - shared
      注意并行区中的共享变量在 task 中也默认为共享，私有变量默认为 firstprivate，其他变量默认为私有
    - ```c #pragma omp taskwait``` 等待任务完成
  == 持久变量
    对于全局变量和静态变量，可以使用 threadprivate 将其变成线程私有的全局/静态变量，注意这将对所有并行区生效。同时，还可以通过以下指令传递持久变量：
    - copyin 从句，在并行区构造时将主线程的持久变量复制到所有线程
    - copyprivate 从句，在 single 处将某一线程的持久变量复制到其他线程
= GPU/CUDA
  GPU 是不同于 CPU 的计算单元。它更注重通量而非延迟，cache 小，控制逻辑简单，但具有大量高能效的 ALU 支持大量的线程，适于进行图形计算和某些科学计算问题。

  Nvidia 推出的 GPU 分为不同架构，天河一号 A 使用 GF100 架构的 Tesla M2050 GPU，数院机器使用 GP102 架构的 Titan Xp GPU

  多个 GPU 之间可以通过 PCIE 总线相连，但 Nvidia 的 NVLINK 技术可以实现多 GPU 的直接互联，获得更好的通信能力。

  == CUDA 简介
    CUDA 是 NVIDIA 公司推出的进行通用 GPU 计算的并行计算平台和并行编程接口。
    CUDA 的使用方式主要有：
    - 使用现有的计算库，性能经过专业人员调优
    - 使用 OpenACC，理念接近于 OpenMP，通过编译制导语句快速实现多核/GPU 并行执行
    - 使用 CUDA 编程语言，直接调用 GPU 的 API

    注意使用 CUDA 是异构并行计算。实际计算时，往往先把数据从 CPU 拷贝到 GPU 上，再在 GPU 上进行计算，最后将结果传回给 CPU

    NVIDIA GPU 的架构大致可以分为：
    - 一个 GPU 包含多个 Streaming Multiprocessor（SM），SM 之间共享 L2 cache，每个 SM 包含多个 Streaming Processor（SP），SP 之间共享 L1 cache 和控制逻辑
    - SP 包括单精度核心，双精度核心，特殊函数核心等
    - GPU 与 CPU 的数据传输主要通过 PCIE，速度大约在 30 GB/s
    - GPU 与 GPU 之间的数据传输可以通过 NVLink，速度大约在 300 GB/s
    从软件的角度来说：
    - 每个 SM 中的核都是 SIMT （Single Instruction Multiple Thread）的。每 32 个线程一组构成线程簇 warp，同一个 warp 中是相同程序，不同数据进行并发的
    通常来讲，CUDA 代码分为两部分：
    - host 代码，也就是由 CPU 执行的代码
    - kernel 代码，也就是由 GPU 执行的代码。具体执行时，需要指定一个线程网格，每个线程网格包含多个线程块，每个线程块包含多个线程。换言之，每个线程的索引是三维的。每个线程块又称为一个执行实例，被某一个 SM 单独完成（一个 SM 可能完成（同时）多个执行实例）。在线程块中，每个线程可以通过 1, 2 或 3 维的方式索引，也可以通过共享内存、原子操作、栅栏同步等方式同步。在线程块中，线程以 warp 为单位进行调度，每个 warp 中的线程是同步的。此外，不同线程块间代码不能进行同步。

    CUDA 函数分成三种：
    - `__global__` 代表该函数在 GPU 上执行，可以被 CPU 调用
    - `__device__` 代表该函数在 GPU 上执行，只能被 GPU 调用
    - `__host__` 代表该函数在 CPU 上执行
    具体来说，关键的 GPU 与 CPU 的交互是由 `__global__` 函数完成的，调用方式例如：
    ```cpp
    __global__ void kernel(float *a, float *b, float *c){
      int i = blockIdx.x * blockDim.x + threadIdx.x;
      c[i] = a[i] + b[i];
    }
    int main(){
      float *a, *b, *c;
      float *d_a, *d_b, *d_c;
      int size = N * sizeof(float);
      dim3 grid_dim(ceil(N/256), 1, 1);
      dim3 block_dim(256, 1, 1);
      cudaMalloc(&d_a, size);
      cudaMalloc(&d_b, size);
      cudaMalloc(&d_c, size);
      cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
      cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
      kernel<<<grid_dim, block_dim>>>(d_a, d_b, d_c);
      cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);
    }
    ```
    其中，`kernel<<<grid_dim, block_dim>>>(...);` 是关键的调用语句，意为在 GPU 上执行 kernel 函数，其中 `grid_dim` 代表线程网格维度，`block_dim` 代表线程块维度。而在 GPU 函数内部，可以利用 `blockIdx`, `blockDim`, `threadIdx`, `threadDim` 等内部结构体来获取该线程的位置，从而正确的进行 SIMT 计算。
  == 内存模型
    在软件视角看，kernel 代码中的变量默认全部为线程私有变量。然而在硬件上，每个 SM 内所有活跃线程共用寄存器资源，如果线程占用的局部变量过多，则会触发寄存器满溢，部分私有变量存储在缓存和内存中，导致性能下降。因此一个线程应当尽量少的使用寄存器，以提高性能。

    此外，kernel 代码中可以用 `__shared__` 修饰符来声明共享内存，共享内存是每个线程块内部共享的内存，硬件上称为擦版内存，往往也并不充足，要谨慎使用。访问共享内存是没有缓存的，但是访问速度很快。共享内存的访问有称为 bank 的特殊机制，也就是一块共享内存会被分为 32 各大小相同，地址连续的内存模组。访问共享内存时，对不同 bank 的访问可以并行进行，但对一个 bank 的访问会被强制分解为多个步骤，导致访问速度下降。因此，访问共享内存时，应当尽量避免 bank 冲突。例如，假如共享内存中有矩阵，每个线程依次访问矩阵某一列各个行的元素，如果矩阵的列数是 32 的倍数，那么每个线程访问的元素恰好在相同的 bank 上，会导致 bank 冲突。解决方法之一是将矩阵的列数加一，使得每个线程访问的元素在不同的 bank 上。这种方法称为 *偏置*，常用方法还有 *调整访存跨步*, *补零* 等。

    GPU 也允许使用全局变量，只需在 kernel 函数外声明 `__device__` 修饰符即可。全局变量在整个 GPU 上都是共享的，但是访问速度较慢（可能被缓存）。

    多个线程对对齐的全局内存相邻位置的访问可能触发合并访问机制，也就是一次读取一个 cache line 的数据，分给不同线程。
  == 线程簇分歧 
    一个 warp 的指令流总是一致的，因此如果其中存在两种指令流的线程，这些线程之间将被迫串行执行。这种现象称为线程簇分歧。为了避免线程簇分歧，我们应当尽量保证线程簇内的线程执行相同的指令流。
  == 线程簇混洗
    线程簇混洗允许一个线程直接读取同一个 warp 中其他线程寄存器中的值，速度比共享内存更快，非常适合进行规约，广播等操作。
  == 原子操作
    为了保证多个线程对同一个全局变量的访问的线程安全，可以使用原子性操作。同时，一个 warp 内对同一个变量的原子操作可以先在 warp 内部计算增量，再以 warp 为单位统一进行，这在较新的 NVCC 中已经可以自动进行。
  == 占用率
    每个 SM 中活跃线程簇数与最大线程簇数的比值成为占用率，一般越接近 $1$ 越好。实际占用率往往取决于各种硬件资源消耗和具体硬件的计算能力，例如：
    - 每个 SM 寄存器的容量
    - 每个 SM 共享内存的容量
    - 每个 SM 允许的最大线程块数
    - 每个 SM 允许的最大线程数
    - 每个线程块允许的最大线程数
  == 其他特性
    - CUDA 9.0 以上支持协同分组，支持更为灵活的线程组合方式，从而可以在不同粒度上进行线程间合作。
    - 向量化访存：CUDA 也支持向量化访存，使用向量化数据类型可以帮助编译器实现访存优化。

    