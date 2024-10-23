#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "并行与分布式计算 第一次报告",
  author: "郭子荀 2100012990",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
)
= 计算任务与实现方式
  本次实现的计算任务是完成矩阵乘向量计算：
  $
    A x = b
  $
  其中 
  $
    A = vec(A_1, dots.v, A_m)\
    x = vec(x_1, dots.v, x_m)\
  $
  且 $A_i, x_i$ 不同的进程上完成初始化。
  
  大致的实现思路是采用最简单的按行分割，每个进程存储若干 $m' times (m n)$ 的矩阵 ```c A_local``` 和 $m' times 1$ 的向量 ```c x_local```，每个进程将自己的 ```c x_local``` 通过 ```c Allgather``` 操作使得每个进程拥有一份完整的 ```c x```，之后各自使用自己拥有的矩阵乘 ```c x``` 即可。

  另外，任务要求我们在规模较小时使用串行程序验证结果。我们规定 $m n < 1000$ 时，最终 rank 为零的进程将收集所有矩阵，串行计算结果，再将结果广播到每个进程。每个进程将自己的 ```c x_local``` 与广播的结果进行比对，如果不一致则输出错误信息。
= 编译/运行方式
  == 编译选项
    本次实验基于 cmake 进行编译，同时提供了两种编译选项，包括：
    - ```-DCOMMUNICATION_AFTER_PARTIALLY_COMPUTE=1```
    - ```-DCOMPUTE_AFTER_COMMUNICATION=1```
    具体含义在实现细节部分会介绍。cmake 采取 Release 模式编译时，会关闭边界检查和运行时日志输出，同时开启若干用于优化的编译选项，以提高运行效率。
  == 运行选项
    程序接受两个运行时命令行参数 $-m [m], -n [n]$ （不依赖顺序），分别代表问题规模中的 $m, n$
  == 完整脚本
    完整的 slurm 脚本如下：
    ```bash
    #!/bin/bash
    #SBATCH --job-name=2100012990
    #SBATCH --output=output
    #SBATCH -p cpu
    #SBATCH --ntasks-per-node=16
    #SBATCH --cpus-per-task=1
    #SBATCH -N 1
    module add gcc/12.2.0
    module add cmake/3.20.2

    echo "Test ComputeBeforeCommunication"
    cmake -DCOMMUNICATION_AFTER_PARTIALLY_COMPUTE=1 -DCMAKE_BUILD_TYPE=Release .
    make
    mpirun -np 16 hw1 -m 16 -n 500
    echo "Test ComputeAfterCommunication"
    cmake -DCOMPUTE_AFTER_COMMUNICATION=1 -UCOMMUNICATION_AFTER_PARTIALLY_COMPUTE -DCMAKE_BUILD_TYPE=Release . 
    make
    mpirun -np 16 hw1 -m 16 -n 500
    echo "Size 16 * 500, process 1"
    mpirun -np 1 hw1 -m 16 -n 500
    echo "Size 16 * 500, process 2"
    mpirun -np 2 hw1 -m 16 -n 500
    echo "Size 16 * 500, process 4"
    mpirun -np 4 hw1 -m 16 -n 500
    echo "Size 16 * 500, process 8"
    mpirun -np 8 hw1 -m 16 -n 500
    echo "Size 16 * 500, process 16"
    mpirun -np 16 hw1 -m 16 -n 500

    echo "Size 1 * 1000, process 1"
    mpirun -np 1 hw1 -m 1 -n 1000
    echo "Size 2 * 707, process 2"
    mpirun -np 2 hw1 -m 2 -n 707
    echo "Size 4 * 500, process 4"
    mpirun -np 4 hw1 -m 4 -n 500
    echo "Size 8 * 354, process 8"
    mpirun -np 8 hw1 -m 8 -n 354
    echo "Size 16 * 250, process 16"
    mpirun -np 16 hw1 -m 16 -n 250
    ```
= 实现细节
  == C++ 封装
    为了内存管理方便，我们使用了基于 ```cpp unique_ptr``` 的矩阵/向量封装，避免了手动管理内存的同时不会影响运行效率。（所有的取值函数都会被 inline 展开到原始的内存访问）。同时，通过封装还可以轻易实现由宏控制的可选边界检查，方便进行调试。
  #let size = "size"
  == $m$ 的分配
    任务要求中提示将 $m$ 分配到进程，但是并没有给出 $m$ 的取值限制，为了保证各种取值的正确性，我们做了如下处理：
    - 首先，将 $m n$ padding 至 $size$ 的倍数，并记其为 ```c nrows```，同时令 ```c ncols = nrows``` 表示列数
    - 其次，令：
      ```c
      nrows_local = nrows / size
      ```
      表示每个进程的行数
    - 最后，每个进程初始化 nrows_local 行 ncols 列的矩阵 ```c A_local``` 和 nrows_local 行 1 列的向量 ```c x_local```，还需要额外将 ```c A_local``` 的 $m * n$ 列之后手动置零防止影响结果。
    如此即可保证程序对于任意的 $m$ 取值均正确。
  == 是否在通讯之前计算
    从之前的初始化过程可以看出，每个进程在通信之前事实上可以完成一部分运算，即先将自己拥有的 $x$ 部分做运算的部分结果放在 $"res"$ 中，通讯完成后只需计算来自其他进程的部分即可。由于不确定这样实现的效率如何，实现时利用基于宏和 c++ constexpr 特性的条件编译，修改编译选项即可无运行开销的切换两种实现。两种实现的测试如下：
    ```bash
    Test ComputeBeforeCommunication
    -- {fmt} version: 11.0.2
    -- Build type: Release
    COMMUNICATION_AFTER_PARTIALLY_COMPUTE
    -- Configuring done
    -- Generating done
    CMake Warning:
      Manually-specified variables were not used by the project:

        COMMUNICATION_AFTER_PARTIALLY_COMPUTE


    -- Build files have been written to: /mnt/lustrefs/home/fpdc2024_2100012990/code/hw1
    Consolidate compiler generated dependencies of target fmt
    [ 60%] Built target fmt
    Consolidate compiler generated dependencies of target hw1
    [ 80%] Building CXX object CMakeFiles/hw1.dir/main.cpp.o
    [100%] Linking CXX executable hw1
    [100%] Built target hw1
    rank=0, start_row=0, nrows_local=500
    args: m = 16, n = 500, size = 16
    matrix size after padding: 8000 x 8000
    Implementation mode: CommunicationAfterPariallyCompute
    rank=2, start_row=1000, nrows_local=500
    rank=3, start_row=1500, nrows_local=500
    rank=7, start_row=3500, nrows_local=500
    rank=8, start_row=4000, nrows_local=500
    rank=9, start_row=4500, nrows_local=500
    rank=10, start_row=5000, nrows_local=500
    rank=14, start_row=7000, nrows_local=500
    rank=15, start_row=7500, nrows_local=500
    rank=4, start_row=2000, nrows_local=500
    rank=6, start_row=3000, nrows_local=500
    rank=11, start_row=5500, nrows_local=500
    rank=12, start_row=6000, nrows_local=500
    rank=5, start_row=2500, nrows_local=500
    rank=13, start_row=6500, nrows_local=500
    rank=1, start_row=500, nrows_local=500
    Finish 100 compuation, per time cost: 10801 us
    Test ComputeAfterCommunication
    -- {fmt} version: 11.0.2
    -- Build type: Release
    COMPUTE_AFTER_COMMUNICATION
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /mnt/lustrefs/home/fpdc2024_2100012990/code/hw1
    Consolidate compiler generated dependencies of target fmt
    [ 60%] Built target fmt
    Consolidate compiler generated dependencies of target hw1
    [ 80%] Building CXX object CMakeFiles/hw1.dir/main.cpp.o
    [100%] Linking CXX executable hw1
    [100%] Built target hw1
    rank=0, start_row=0, nrows_local=500
    args: m = 16, n = 500, size = 16
    matrix size after padding: 8000 x 8000
    Implementation mode: ComputeAfterCommunication
    rank=2, start_row=1000, nrows_local=500
    rank=3, start_row=1500, nrows_local=500
    rank=4, start_row=2000, nrows_local=500
    rank=6, start_row=3000, nrows_local=500
    rank=7, start_row=3500, nrows_local=500
    rank=10, start_row=5000, nrows_local=500
    rank=11, start_row=5500, nrows_local=500
    rank=13, start_row=6500, nrows_local=500
    rank=1, start_row=500, nrows_local=500
    rank=14, start_row=7000, nrows_local=500
    rank=5, start_row=2500, nrows_local=500
    rank=8, start_row=4000, nrows_local=500
    rank=9, start_row=4500, nrows_local=500
    rank=12, start_row=6000, nrows_local=500
    rank=15, start_row=7500, nrows_local=500
    Finish 100 compuation, per time cost: 5560 us
    ```
    可见使用简单的先通讯再整体计算的效率远高于上述调整。但直观上，上面的先部分计算再通讯的选项应该能一定程度上将计算和通讯交叉进行，可能导致效率降低的因素包括：
    - 这里实现的粒度过粗，只是在计算完成后进行 ```c Allgather``` 操作，一旦某个进程没有完成之前的运算，进而集合通讯无法完成，可能会导致所有进程阻塞。如果细粒度到收到每个进程的数据后都立即计算，而不是等待收到所有数据，可能效率会更高。
    - 最终进行矩阵乘向量的循环操作中，为了防止运算重复进行需要排除已经进行过的运算，使得控制流更为复杂，而乘加运算本身很简单，可能会导致计算量减少带来的效率提升并不明显。
= 结果
  我们进行了两组测试，包括固定工作量，不同进程数和工作量与进程数成正比的测试，并分别考察两种情况的加速比。
  == 固定工作量
    本组测试结果如下：
    ```bash
    Size 16 * 500, process 1
    rank=0, start_row=0, nrows_local=8000
    args: m = 16, n = 500, size = 1
    matrix size after padding: 8000 x 8000
    Implementation mode: ComputeAfterCommunication
    Finish 100 compuation, per time cost: 42025 us
    Size 16 * 500, process 2
    rank=0, start_row=0, nrows_local=4000
    args: m = 16, n = 500, size = 2
    matrix size after padding: 8000 x 8000
    Implementation mode: ComputeAfterCommunication
    rank=1, start_row=4000, nrows_local=4000
    Finish 100 compuation, per time cost: 22311 us
    Size 16 * 500, process 4
    rank=2, start_row=4000, nrows_local=2000
    rank=1, start_row=2000, nrows_local=2000
    rank=3, start_row=6000, nrows_local=2000
    rank=0, start_row=0, nrows_local=2000
    args: m = 16, n = 500, size = 4
    matrix size after padding: 8000 x 8000
    Implementation mode: ComputeAfterCommunication
    Finish 100 compuation, per time cost: 11876 us
    Size 16 * 500, process 8
    rank=2, start_row=2000, nrows_local=1000
    rank=4, start_row=4000, nrows_local=1000
    rank=0, start_row=0, nrows_local=1000
    args: m = 16, n = 500, size = 8
    matrix size after padding: 8000 x 8000
    Implementation mode: ComputeAfterCommunication
    rank=1, start_row=1000, nrows_local=1000
    rank=5, start_row=5000, nrows_local=1000
    rank=7, start_row=7000, nrows_local=1000
    rank=3, start_row=3000, nrows_local=1000
    rank=6, start_row=6000, nrows_local=1000
    Finish 100 compuation, per time cost: 6888 us
    Size 16 * 500, process 16
    rank=0, start_row=0, nrows_local=500
    args: m = 16, n = 500, size = 16
    matrix size after padding: 8000 x 8000
    Implementation mode: ComputeAfterCommunication
    rank=8, start_row=4000, nrows_local=500
    rank=1, start_row=500, nrows_local=500
    rank=2, start_row=1000, nrows_local=500
    rank=3, start_row=1500, nrows_local=500
    rank=6, start_row=3000, nrows_local=500
    rank=7, start_row=3500, nrows_local=500
    rank=14, start_row=7000, nrows_local=500
    rank=15, start_row=7500, nrows_local=500
    rank=4, start_row=2000, nrows_local=500
    rank=9, start_row=4500, nrows_local=500
    rank=10, start_row=5000, nrows_local=500
    rank=12, start_row=6000, nrows_local=500
    rank=5, start_row=2500, nrows_local=500
    rank=13, start_row=6500, nrows_local=500
    rank=11, start_row=5500, nrows_local=500
    Finish 100 compuation, per time cost: 5596 us
    ```
    不难看出，进程数较少时增加进程数的收益明显，加速比接近线性。而当进程数由 $8$ 增加至 $16$ 时，加速效果已经不太明显。这非常符合 Amdahl 定律的预期，受制于其中 ```c Allgather``` 操作无法完全并行化，在当前数据规模下进程数达到 $8$ 时加速效果已经接近上限了。
  == 工作量与进程数成正比
    本组测试结果如下（注意矩阵运算的总工作量为 $O((m n)^2)$，因此为了总工作量与进程数成正比， $n$ 并不是随着进程数线性增加的）
    ```bash
    Size 1 * 1000, process 1
    rank=0, start_row=0, nrows_local=1000
    args: m = 1, n = 1000, size = 1
    matrix size after padding: 1000 x 1000
    Implementation mode: ComputeAfterCommunication
    Finish 100 compuation, per time cost: 917 us
    rank 0 check passed
    Size 2 * 707, process 2
    rank=0, start_row=0, nrows_local=707
    args: m = 2, n = 707, size = 2
    matrix size after padding: 1414 x 1414
    Implementation mode: ComputeAfterCommunication
    rank=1, start_row=707, nrows_local=707
    Finish 100 compuation, per time cost: 879 us
    Size 4 * 500, process 4
    rank=1, start_row=500, nrows_local=500
    rank=0, start_row=0, nrows_local=500
    args: m = 4, n = 500, size = 4
    rank=2, start_row=1000, nrows_local=500
    rank=3, start_row=1500, nrows_local=500
    matrix size after padding: 2000 x 2000
    Implementation mode: ComputeAfterCommunication
    Finish 100 compuation, per time cost: 1033 us
    Size 8 * 354, process 8
    rank=0, start_row=0, nrows_local=354
    args: m = 8, n = 354, size = 8
    matrix size after padding: 2832 x 2832
    Implementation mode: ComputeAfterCommunication
    rank=3, start_row=1062, nrows_local=354
    rank=4, start_row=1416, nrows_local=354
    rank=6, start_row=2124, nrows_local=354
    rank=1, start_row=354, nrows_local=354
    rank=5, start_row=1770, nrows_local=354
    rank=2, start_row=708, nrows_local=354
    rank=7, start_row=2478, nrows_local=354
    Finish 100 compuation, per time cost: 1046 us
    Size 16 * 250, process 16
    rank=0, start_row=0, nrows_local=250
    args: m = 16, n = 250, size = 16
    matrix size after padding: 4000 x 4000
    Implementation mode: ComputeAfterCommunication
    rank=8, start_row=2000, nrows_local=250
    rank=10, start_row=2500, nrows_local=250
    rank=11, start_row=2750, nrows_local=250
    rank=2, start_row=500, nrows_local=250
    rank=3, start_row=750, nrows_local=250
    rank=5, start_row=1250, nrows_local=250
    rank=6, start_row=1500, nrows_local=250
    rank=9, start_row=2250, nrows_local=250
    rank=12, start_row=3000, nrows_local=250
    rank=14, start_row=3500, nrows_local=250
    rank=1, start_row=250, nrows_local=250
    rank=4, start_row=1000, nrows_local=250
    rank=7, start_row=1750, nrows_local=250
    rank=13, start_row=3250, nrows_local=250
    rank=15, start_row=3750, nrows_local=250
    Finish 100 compuation, per time cost: 1291 us
    ```
    可以看出当规模增加，进程数增加时，尽管加速比并未达到线性，但也非常接近线性，这符合 Gustafson 定律的预期。