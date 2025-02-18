#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "并行与分布式计算 第三次报告",
  author: "郭子荀 2100012990",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
)
= 计算任务与实现方式
  本次实现的计算任务是使用 CUDA 完成基于 HouseHolder 变换的 QR 分解。该问题相对复杂，多个步骤的数据依赖较强，访存量也较大。
= 基本思路
  本次实现了比较简单的 CUDA 计算程序。具体来说，每轮计算依次完成以下步骤：
  - 计算第 $k$ 列的 HouseHolder 变换对应的向量 $v$
  - 计算 $v^T A$
  - 更新 $A := A - 2 v (v^T A)$
  - 计算 $Q v$
  - 更新 $Q := Q + 2 (Q v) v^T$
  其中每一步都在 Host 上调用 global 函数进行计算。这样划分是因为上面每步之内是完全并行的，但步骤之间存在数据依赖。
= 实现细节
    == 矩阵类
        仿照之前的思路，本次实验依旧采用 C++ 风格的模板类来实现矩阵。由于本次实验同时涉及 CPU 数据和 GPU 数据，因此现在一个矩阵类会同时对应一个 CPU 地址和 GPU 地址。在需要的时候可以手动进行内存同步。
    == C++ 风格的计算函数封装
        本次实现中许多任务需要从 CPU 调用进行 GPU计算，例如标量乘向量函数，我们用了如下实现：
        ```cpp
        template <int M>
        __global__ void scalar_mul_vec_global(
            const DataPtrDevice A,
            const DataPtrDevice a,
            const Dim<M> m,
            const size_t m_start
        ) {
            size_t i = blockIdx.x * blockDim.x + threadIdx.x + m_start;
            if (i < m.out() && i >= m_start) {
                A[i] *= *a;
            }
        }

        template <int M>
        __host__ void scalar_mul_vec(
            Vector<M>& A,
            const DataPtrDevice a,
            const size_t m_start
        ) {
            dim3 block(BLOCK_SIZE);
            dim3 grid((A.nrows() + BLOCK_SIZE - 1 - m_start) / BLOCK_SIZE);
            scalar_mul_vec_global<M><<<grid, block>>>(A.get_device(), a, A.rows_dim(), m_start);
        }
        ```
        包装后的 `scalar_mul_vec` 函数会自动调用 GPU 函数进行计算，同时包裹了具体的 block size 等调用细节，可以减少很多 bug。当然，这也一定程度上增加了代码量，不过其中大部分可以通过 copilot 生成。
= 测试结果
    ```
    m = 64
    Time: 4.5696276 ms
    check correctness
    m = 128
    Time: 8.9252068 ms
    check correctness
    m = 256
    Time: 27.588698 ms
    m = 512
    Time: 95.1992274 ms
    m = 1024
    Time: 520.1982646 ms
    m = 2048
    Time: 4989.0094142 ms
    m = 4096
    Time: 45726.919013 ms
    ```
    可见：
    - 本次实现未对规模较小的矩阵做特殊处理，因此在小规模下性能较差
    - 规模较大时，计算耗时与规模基本等比例增长，说明并行化程度还是比较好的
    - 总体性能并不理想。猜测主要原因是访存效率过低，基本上一次访存对应一次计算，访存瓶颈严重。后续可以通过调整实现细节，换用分块的 HouseHolder 变换等方法来提高性能。