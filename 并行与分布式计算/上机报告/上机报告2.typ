#import "../../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "并行与分布式计算 第二次报告",
  author: "郭子荀 2100012990",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
)
= 计算任务与实现方式
  本次实现的计算任务是使用 OpenMP 完成矩阵乘法计算：
  $
    A B = C
  $
  问题本身非常简单，可以很容易设计没有任何数据依赖的并发方式。但是高性能地完成并不容易，需要考虑到非常多的细节问题。
= 基本思路
  现代计算机中，CPU 的运算速度远远大于内存访问速度，因此高效算法必须考虑缓存优化，最大可能减少内存访问。对于矩阵乘法问题，最经典的访问优化思路就是：
  - 先对原始矩阵进行分块，记块宽度为 `BLOCK_LEN`（本次设为 256）。这是因为如果矩阵过大，但 CPU 的缓存大小有限，在循环过程中不可避免地出现大量的缓存未命中，导致性能急剧下降。
  - 对于每个子矩阵 $A_(s t)$，使用以下的运算顺序：固定矩阵 $A_(s t)$ 的 $i j$ 元，用它乘矩阵 $B_(t r)$ 的第 $i$ 行，结果加到 $C_(s r)$ 的第 $i$ 行上。遍历所有 $i j$ 后得到结果。这是因为考虑到矩阵是行优先存储的，而缓存也是按行读取的，这样可以充分利用每次缓存读取的数据。
  - 进一步考虑并行化，尽管分配线程的方式有很多，但是应当尽量避免：
    + 多个线程写入同一个位置，否则必须采用原子操作进行乘法累加，导致性能下降。
    + 多个线程写入同一个缓存行，尽管没有真正的数据依赖，但如果多个线程写入同一个缓存行的不同位置，为了保证缓存一致性，缓存行仍然会失效。这种问题称为伪共享（False Sharing）。
    因此，我们采用将线程分配到子矩阵的行上的思路，可以避免以上两个问题。不难发现，这样的分配下矩阵乘法是完美并行的，可以期望获得几乎线性的加速比，而实验也证明了这一点。
  最终核心循环为：
  ```cpp
  #pragma omp parallel private (tid, thread_num) 
  {
      thread_num = omp_get_num_threads();
      tid = omp_get_thread_num();
      for (size_t i_start = 0; i_start < m; i_start += BLOCK_LEN) {
          for (size_t k_vec_start = 0; k_vec_start < s / AlignedBuffer<T>::count(); k_vec_start += BLOCK_LEN_VEC) {
              for (size_t j_start = 0; j_start < n; j_start += BLOCK_LEN) {
                  // 对于每个子矩阵，将行分给不同线程处理
                  for (size_t i = i_start + tid; i < i_start + BLOCK_LEN && i < m; i += thread_num) {
                      // fmt::println("Thread: {}, start line {}\n", tid, i);
                      for (size_t j = j_start; j < j_start + BLOCK_LEN && j < n; j++) {
                          for (size_t vec_start = k_vec_start; vec_start < k_vec_start + BLOCK_LEN_VEC && vec_start < (s / AlignedBuffer<T>::count()); vec_start += CACHE_LINE_SIZE / VEC_LENGTH) {
                              vec_mul_scalar_add_cache_line(&c.get_vec(i, vec_start), &b.get_vec(j, vec_start), a(i, j));
                          }
                      }
                  }
              }
          }
      }
  }
  ```
= 向量化运算
  为了进一步提高性能，我们可以考虑使用 SIMD 指令集进行向量化运算。在本次实验中，我们使用了 AVX2 指令集，可以同时处理 256 位的数据。在矩阵乘法中，我们可以将 4 个 `double` 类型的数据打包成一个 256 位的数据，然后使用 AVX2 指令集进行乘法累加。这样可以大大提高计算效率。事实上，AVX 指令集还额外提供了 FMA 指令，恰好可以实现乘向量后加到另一个向量上的操作，这样，我们核心循环就可以仅用两条向量化指令：
  - 广播操作：将一个 `double` 类型的数据广播到 256 位的数据中。
  - FMA 操作：将两个 256 位的数据相乘后加到第三个 256 位的数据上。
  实际实现代码如下：
  ```cpp
  template<> 
  void vec_mul_scalar_add<double> (AlignedBuffer<double>& a, const AlignedBuffer<double>& c, double b) {
      __m256d* a_data = reinterpret_cast<__m256d*>(a.get());
      const __m256d* c_data = reinterpret_cast<const __m256d*>(c.get());
      __m256d b_vec = _mm256_set1_pd(b);
      // __m256d b_mul_c = _mm256_mul_pd(b_vec, *c_data);
      // *a_data = _mm256_add_pd(*a_data, b_mul_c);
      // 可以直接使用 FMA
      *a_data = _mm256_fmadd_pd(b_vec, *c_data, *a_data);
  }
  ```
  (其中 `AlignedBuffer` 之后会介绍) 
= 重要的实现细节
  == 模板化函数
    为了提高代码的复用性，我们将矩阵定义和矩阵乘法的核心代码模板化，可以处理任意（基本）类型的数据。由于部分操作需要精细的类型信息，我们充分利用了 C++ 的一些特性，例如：
    - 使用偏特化为不同类型实现不同的向量操作：
      ```cpp
      template <typename T>
      void vec_mul_scalar_add(AlignedBuffer<T>& a, const AlignedBuffer<T>& c, T b) {
          T* a_data = a.get();
          const T* c_data = c.get();
          __builtin_assume_aligned(a_data, BYTE_ALIGNMENT);
          __builtin_assume_aligned(c_data, BYTE_ALIGNMENT);
          __assume(a_data != c_data);
          for (size_t i = 0; i < a.count(); ++i) {
              a_data[i] += b * c_data[i];
          }
      }

      template <>
      void vec_mul_scalar_add<int>(AlignedBuffer<int>& a, const AlignedBuffer<int>& c, int b) {
          ...
      }

      template<> 
      void vec_mul_scalar_add<double> (AlignedBuffer<double>& a, const AlignedBuffer<double>& c, double b) {
          ...
      }
      ```
      这样，我们保证对 `double`, `int` 等基本类型的运算使用高效的向量运算，对于一般的类型也能进行正确的运算，提高了代码的复用性。
    - `constexpr` 和模板值制导的函数实现：
      ```cpp
      for (size_t i = 0; i < nrows(); ++i) {
          for (size_t j = 0; j < ncols(); ++j) {
              if constexpr (std::is_integral_v<T>){
                  if (operator()(i, j) != other(i, j)) {
                      return false;
                  }
              }
              else {
                  if (std::abs(operator()(i, j) - other(i, j)) > 1e-6) {
                      return false;
                  }
              }
          }
      }
      ```
      这里利用了 `std::is_integral_v<T>` 获知类型是否为整数类型，从而选择不同的比较方式。这样的代码既简略，又没有任何运行时开销地实现了矩阵相等的比较。
  == 内存对齐
    向量化指令要求内存必须对齐，例如 256 位的向量运算就要求数据对齐到 32 位。一般 C++ 的内存分配并没有对齐保证，为了安全性，我们实现了一个 `AlignedBuffer` 类，可以保证内存对齐。实现代码如下：
    ```cpp
    template <typename T>
    struct AlignedBuffer {
        private:
            alignas(BYTE_ALIGNMENT) std::byte buf [BYTE_ALIGNMENT];
        public:
            AlignedBuffer() {
                static_assert(BYTE_ALIGNMENT % sizeof(T) == 0, "AlignedBuffer size should be multiple of T");
            }
            T* get() {
                return reinterpret_cast<T*>(buf);
            }
            const T* get() const {
                return reinterpret_cast<const T*>(buf);
            }
            constexpr static int count() {
                return BYTE_ALIGNMENT / sizeof(T);
            }
            void set_zero() {
                for (size_t i = 0; i < BYTE_ALIGNMENT; ++i) {
                    buf[i] = buf[i] & (static_cast<std::byte>(0)); // 这样简单的循环应当可以自动向量化
                }
            }
    };
    ```
    这里 `std::byte` 是 C++ 17 引入的类型，专门表示一字节内存。`alignas` 关键字可以保证分配内存时对齐。这样，我们只要在真正分配矩阵内存时，转而分配 `AlignedBuffer` 类型的内存，就可以保证内存对齐。
  == 矩阵维度类
    我们借鉴 Eigen，实现了用类表示矩阵的维度。具体来说，使用下面的模板类：
    ```cpp
    template <int M>
    class Dim {
        public:
            Dim (size_t m) {}  // 为了与动态大小的情形一致
            size_t out() const {return M;}
    };

    // 使用偏特化特殊处理动态大小的矩阵，类似 Eigen
    template <>
    class Dim<Dynamic> {
        private:
            size_t size;
        public:
            Dim (size_t m) : size(m) {}
            size_t out() const {return size;}
    };
    ```
    一方面，我们可以同时处理静态大小和动态大小的矩阵，另一方面，我们用模板参数表示矩阵的维度，可以很大程度上避免写出维度不匹配的代码。例如，我们的矩阵乘法函数签名为：
    ```cpp
    template <int M, int N, int S, typename T>
    Matrix<T, M, S> mul (const Matrix<T, M, N>& a, const Matrix<T, N, S>& b)
    ```
    参数矩阵和返回矩阵的维度非常一目了然。
  == 用辅助信息帮助自动向量化
    GCC 编译器可以自动利用向量化指令完成某些运算，但需要非常多的额外信息，包括内存对齐，非别名等等。编译时开启 `-fopt-info-vec-all` 可以帮助我们知道向量化失败的原因。本次实现的初版矩阵乘法为：
    ```cpp
    template <int M, int N, int S, typename T>
    Matrix<T, M, S> mul_parallel (const Matrix<T, M, N>& a, const Matrix<T, N, S>& b) {
    if constexpr (debug){
        if (a.ncols() != b.nrows()) {
            fmt::print("Error: Matrix size not match!\n");
            return Matrix<T, M, S>(Dim<M>(0), Dim<S>(0));
        }
    }
    Matrix<T, M, S> c ((Dim<M>(a.nrows())), (Dim<S>(b.ncols())), 3);
    c.zero();
    size_t m = a.nrows();
    size_t n = a.ncols();
    size_t n_padding = a.ncols_padding();
    size_t s = b.ncols();
    size_t s_padding = b.ncols_padding();
    T* c_data = c.get();
    const T* a_data = a.get();
    const T* b_data = b.get();
    // 以下 assume 可以帮助进行自动向量化
    __builtin_assume_aligned(c_data, BYTE_ALIGNMENT);
    __builtin_assume_aligned(a_data, BYTE_ALIGNMENT);
    __builtin_assume_aligned(b_data, BYTE_ALIGNMENT);
    // 虽然使用了 unique_ptr，但是如果不手动取指针看起来 gcc 无法实现自动向量化
    // 而手动取出指针后，需要手动 assume 不会有别名问题出现
    __assume(a_data != b_data);
    __assume(a_data != c_data);
    __assume(b_data != c_data);

    constexpr size_t LINE_SIZE = ::LINE_SIZE<T>;
    #pragma omp parallel for
    for (size_t i = 0; i < m; i++){
        if constexpr (debug)
        {
            fmt::print("Thread: {}, start line {}\n", omp_get_thread_num(), i);
        }
        for (size_t j = 0; j < n; j++){
            for (size_t line_start = 0; line_start < s; line_start += LINE_SIZE) {
                for (size_t k = line_start; k < line_start + LINE_SIZE; k++) {  // 注意 s 不是 LINE_SIZE 的倍数时，这里会稍微做一些额外的运算，但是是安全的，因为我们初始化矩阵时将列数补齐到了 LINE_SIZE 的倍数
                    c_data[i * s_padding + k] += a_data[i * n_padding + j] * b_data[j * s_padding + k];
                }
        }
    }
    ```
    实验表明使用 GCC 14 进行编译时已经能很好地向量化，但服务器上使用的 GCC 12 并未支持这样的自动向量化，因此我们最终还是选择了手写向量化指令。当然，对于非常简单的循环，GCC 12 还是可以实现向量化的，例如：
    ```cpp
    void set_zero() {
        for (size_t i = 0; i < BYTE_ALIGNMENT; ++i) {
            buf[i] = buf[i] & (static_cast<std::byte>(0)); // 这样简单的循环应当可以自动向量化
        }
    }
    ```
    查看汇编代码，大致对应（由于编译器已经充分内联并且优化，因此不能完全对应）：
    ```asm
      403668:	4c 8b 94 24 e0 01 00 00 	mov    0x1e0(%rsp),%r10
      403670:	48 0f af d7          	imul   %rdi,%rdx
      403674:	c4 41 39 ef c0       	vpxor  %xmm8,%xmm8,%xmm8
      403679:	4d 01 ea             	add    %r13,%r10
      40367c:	49 ff c5             	inc    %r13
      40367f:	49 01 d2             	add    %rdx,%r10
      403682:	49 c1 e2 05          	shl    $0x5,%r10
      403686:	4c 03 94 24 d8 01 00 00 	add    0x1d8(%rsp),%r10
      40368e:	c4 41 7a 7f 02       	vmovdqu %xmm8,(%r10)
      403693:	c4 41 7a 7f 42 10    	vmovdqu %xmm8,0x10(%r10)
      403699:	4c 8b 84 24 d0 01 00 00 	mov    0x1d0(%rsp),%r8
      4036a1:	4c 89 c2             	mov    %r8,%rdx
      4036a4:	48 c1 ea 02          	shr    $0x2,%rdx
      4036a8:	49 39 d5             	cmp    %rdx,%r13
      4036ab:	72 bb                	jb     403668 <main+0xb18>
    ```
    可以看出不仅使用了向量化操作，还进行了循环展开，提高了代码的性能。 
  == 其他重要优化
    === 内存 gap
      如果内存分配时非常整齐，那么 $A, B, C$ 三个矩阵的内存地址可能也十分对齐，增大了缓存冲突的概率。因此我们在分配矩阵时，增加了一些随机的内存 gap，使得三个矩阵的内存地址不太可能对齐，减少了缓存冲突的概率。具体来说，矩阵初始化函数被实现为：
      ```cpp
      Matrix (Dim<M> m, Dim<N> n, size_t gap_count = 0) 
      : m(m), n(n), n_padded(align_to(n.out(), ::LINE_SIZE<T>)), gap_count(gap_count){
          size_t len = m.out() * n_padded.out();
          size_t count = AlignedBuffer<T>::count();
          size_t aligned_buf_len = (len + count - 1) / count;
          data = std::make_unique<AlignedBuffer<T>[]>(aligned_buf_len + gap_count);
          static_assert(sizeof(AlignedBuffer<T>) == BYTE_ALIGNMENT, "AlignedBuffer size should be equal to BYTE_ALIGNMENT");
        }
      ```
      此外，运用面向对象的特性将各种访问数据接口封装，并且考虑 gap 造成的偏移，例如：
      ```cpp
      auto get_vec_ptr() const {
            return data.get() + gap_count;
      }
      auto get_vec_ptr() {
          return data.get() + gap_count;
      }
      ```
      可以很大程度上避免忘记 gap 造成的 Bug
    === 循环展开
      不难发现核心循环的最内层循环次数并不多，因此循环展开可能获得很大的收益。这里最开始担心编译器无法充分优化，手动写了一层展开：
      ```cpp
      // 由于一个 cache_line 事实上只有两个向量，我们手动展开
      template<typename T>
      void vec_mul_scalar_add_cache_line (AlignedBuffer<T>* a, const AlignedBuffer<T>* c, T b) {
          if constexpr (CACHE_LINE_SIZE / VEC_LENGTH == 2) {
              vec_mul_scalar_add(a[0], c[0], b);
              vec_mul_scalar_add(a[1], c[1], b);
          } else {
              for (size_t i = 0; i < CACHE_LINE_SIZE / VEC_LENGTH; ++i) {
                  vec_mul_scalar_add(a[i], c[i], b);
              }
          }
      }
      ``` 
      这里同时考虑到了一个 CACHE_LINE 恰好是两个 VEC，因此以 CACHE_LINE 为单位进行运算也是很便于理解的的。

      当然，事实表明在下面介绍的 `-fprofile*` 的帮助下，编译器已经可以充分展开循环了。最终最内层循环的汇编码大致为：
      ```asm
        40395e:	c5 f9 57 c0          	vxorpd %xmm0,%xmm0,%xmm0
        403962:	4d 29 d5             	sub    %r10,%r13
        403965:	49 83 ed 20          	sub    $0x20,%r13
        403969:	49 c1 ed 05          	shr    $0x5,%r13
        40396d:	49 ff c5             	inc    %r13
        403970:	41 83 e5 03          	and    $0x3,%r13d
        403974:	0f 84 8f 00 00 00    	je     403a09 <main+0xeb9>
        40397a:	49 83 fd 01          	cmp    $0x1,%r13
        40397e:	74 54                	je     4039d4 <main+0xe84>
        403980:	49 83 fd 02          	cmp    $0x2,%r13
        403984:	74 27                	je     4039ad <main+0xe5d>
        403986:	c5 7b 10 3c 46       	vmovsd (%rsi,%rax,2),%xmm15
        40398b:	c5 fb 10 2e          	vmovsd (%rsi),%xmm5
        40398f:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
        403993:	49 8d 4a 20          	lea    0x20(%r10),%rcx
        403997:	c4 a1 01 16 24 06    	vmovhpd (%rsi,%r8,1),%xmm15,%xmm4
        40399d:	c5 d1 16 0c 06       	vmovhpd (%rsi,%rax,1),%xmm5,%xmm1
        4039a2:	c4 e3 75 18 d4 01    	vinsertf128 $0x1,%xmm4,%ymm1,%ymm2
        4039a8:	c4 c2 ed b8 02       	vfmadd231pd (%r10),%ymm2,%ymm0
        4039ad:	c5 fb 10 1c 42       	vmovsd (%rdx,%rax,2),%xmm3
        4039b2:	c5 fb 10 3a          	vmovsd (%rdx),%xmm7
        4039b6:	48 83 c1 20          	add    $0x20,%rcx
        4039ba:	c4 a1 61 16 34 02    	vmovhpd (%rdx,%r8,1),%xmm3,%xmm6
        4039c0:	c5 41 16 04 02       	vmovhpd (%rdx,%rax,1),%xmm7,%xmm8
        4039c5:	4c 01 ca             	add    %r9,%rdx
        4039c8:	c4 63 3d 18 ce 01    	vinsertf128 $0x1,%xmm6,%ymm8,%ymm9
        4039ce:	c4 e2 b5 b8 41 e0    	vfmadd231pd -0x20(%rcx),%ymm9,%ymm0
        4039d4:	c5 7b 10 14 42       	vmovsd (%rdx,%rax,2),%xmm10
        4039d9:	c5 7b 10 22          	vmovsd (%rdx),%xmm12
        4039dd:	48 83 c1 20          	add    $0x20,%rcx
        4039e1:	c4 21 29 16 1c 02    	vmovhpd (%rdx,%r8,1),%xmm10,%xmm11
        4039e7:	c5 19 16 2c 02       	vmovhpd (%rdx,%rax,1),%xmm12,%xmm13
        4039ec:	4c 01 ca             	add    %r9,%rdx
        4039ef:	c4 43 15 18 f3 01    	vinsertf128 $0x1,%xmm11,%ymm13,%ymm14
        4039f5:	c4 e2 8d b8 41 e0    	vfmadd231pd -0x20(%rcx),%ymm14,%ymm0
        4039fb:	48 39 8c 24 a0 00 00 00 	cmp    %rcx,0xa0(%rsp)
        403a03:	0f 84 ae 00 00 00    	je     403ab7 <main+0xf67>
        403a09:	4c 8b bc 24 90 00 00 00 	mov    0x90(%rsp),%r15
        403a11:	c5 7b 10 3c 42       	vmovsd (%rdx,%rax,2),%xmm15
        403a16:	c5 fb 10 2a          	vmovsd (%rdx),%xmm5
        403a1a:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
        403a1e:	c4 a1 01 16 24 02    	vmovhpd (%rdx,%r8,1),%xmm15,%xmm4
        403a24:	c5 d1 16 0c 02       	vmovhpd (%rdx,%rax,1),%xmm5,%xmm1
        403a29:	4c 01 ca             	add    %r9,%rdx
        403a2c:	c5 fb 10 32          	vmovsd (%rdx),%xmm6
        403a30:	c4 e3 75 18 dc 01    	vinsertf128 $0x1,%xmm4,%ymm1,%ymm3
        403a36:	c4 e2 fd 98 59 80    	vfmadd132pd -0x80(%rcx),%ymm0,%ymm3
        403a3c:	c5 fb 10 04 42       	vmovsd (%rdx,%rax,2),%xmm0
        403a41:	c5 c9 16 3c 02       	vmovhpd (%rdx,%rax,1),%xmm6,%xmm7
        403a46:	c4 a1 79 16 14 02    	vmovhpd (%rdx,%r8,1),%xmm0,%xmm2
        403a4c:	4c 01 ca             	add    %r9,%rdx
        403a4f:	c5 7b 10 0c 42       	vmovsd (%rdx,%rax,2),%xmm9
        403a54:	c5 7b 10 1a          	vmovsd (%rdx),%xmm11
        403a58:	c4 63 45 18 c2 01    	vinsertf128 $0x1,%xmm2,%ymm7,%ymm8
        403a5e:	c4 62 e5 98 41 a0    	vfmadd132pd -0x60(%rcx),%ymm3,%ymm8
        403a64:	c4 21 31 16 14 02    	vmovhpd (%rdx,%r8,1),%xmm9,%xmm10
        403a6a:	c5 21 16 24 02       	vmovhpd (%rdx,%rax,1),%xmm11,%xmm12
        403a6f:	4c 01 ca             	add    %r9,%rdx
        403a72:	c5 7b 10 34 42       	vmovsd (%rdx,%rax,2),%xmm14
        403a77:	c5 fb 10 22          	vmovsd (%rdx),%xmm4
        403a7b:	c4 43 1d 18 ea 01    	vinsertf128 $0x1,%xmm10,%ymm12,%ymm13
        403a81:	c4 62 bd 98 69 c0    	vfmadd132pd -0x40(%rcx),%ymm8,%ymm13
        403a87:	c4 21 09 16 3c 02    	vmovhpd (%rdx,%r8,1),%xmm14,%xmm15
        403a8d:	c5 d9 16 2c 02       	vmovhpd (%rdx,%rax,1),%xmm4,%xmm5
        403a92:	4c 01 ca             	add    %r9,%rdx
        403a95:	c4 c3 55 18 c7 01    	vinsertf128 $0x1,%xmm15,%ymm5,%ymm0
        403a9b:	c4 e2 95 98 41 e0    	vfmadd132pd -0x20(%rcx),%ymm13,%ymm0
        403aa1:	48 39 8c 24 a0 00 00 00 	cmp    %rcx,0xa0(%rsp)
        403aa9:	0f 85 62 ff ff ff    	jne    403a11 <main+0xec1>
        403aaf:	4c 89 bc 24 90 00 00 00 	mov    %r15,0x90(%rsp)
        403ab7:	c4 e3 7d 19 c1 01    	vextractf128 $0x1,%ymm0,%xmm1
        403abd:	48 83 7c 24 28 00    	cmpq   $0x0,0x28(%rsp)
        403ac3:	c5 f1 58 d8          	vaddpd %xmm0,%xmm1,%xmm3
        403ac7:	c5 e1 15 d3          	vunpckhpd %xmm3,%xmm3,%xmm2
        403acb:	c5 69 58 f3          	vaddpd %xmm3,%xmm2,%xmm14
        403acf:	0f 84 ef 00 00 00    	je     403bc4 <main+0x1074>
      ```
    可以看到编译器事实上已经将最内层循环彻底展开了。
  === `f-profile*`
    一般而言，编译器无法确定哪些函数是热点函数，从而决定展开循环是否有收益。但是，我们可以使用 `-fprofile-generate` 和 `-fprofile-use` 两个选项，让编译器在第一次运行时记录函数调用次数，第二次运行时根据记录的信息进行优化。这样，编译器就可以知道哪些函数是热点函数，从而进行更好的优化。事实上，上面的循环展开是使用 `f-profile*` 后编译器才选择进行的，如果不开启该选项，编译器不会选择展开此循环。这表明，使用这两个选项后，编译器对于热点代码可以做到十分积极的优化，从而使得代码性能得到了很大的提升。
  == 实验脚本及结果
    本次使用了构建脚本：
    ```bash
    #!/bin/bash
    #SBATCH --job-name=2100012990
    #SBATCH --output=build_output
    #SBATCH -p cpu
    #SBATCH --ntasks-per-node=16
    #SBATCH --cpus-per-task=1
    #SBATCH -N 1
    module add gcc/12.2.0
    module add cmake/3.20.2
    cd build
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    make
    ./hw2 -m 256 -n 256 -p 256
    make clean
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make
    ```
    来实现之前提到的 `-fprofile*` 的优化。当 CMake 配置为 `Debug` 时开启 `-fprofile-generate`，编译之后运行一次生成运行记录。配置为 `Release` 时开启 `-fprofile-use`。实验运行脚本为：
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
    cd build
    runPerf(){
        perf stat -B -e cache-references,cache-misses,cycles,instructions,
        branches,branch-misses,page-faults ./hw2 -m $1 -n $1 -p $1
    }
    for i in 1 2 4 8 16
    do
        echo "Running with $i threads and m = n = p = 1024"
        export OMP_NUM_THREADS=$i
        runPerf 1024
    done
    echo "Running with 16 threads and m = n = p = 2048"
    export OMP_NUM_THREADS=16
    runPerf 2048
    ```
    使用了 perf 展示一些性能相关的数据。实验结果如下：
    ```
    Running with 1 threads and m = n = p = 1024
    Time: 568.0512724304572ms


    Performance counter stats for './hw2 -m 1024 -n 1024 -p 1024':

        22,824,687,443      cache-references                                            
            7,184,120      cache-misses              #    0.031 % of all cache refs    
      165,309,177,132      cycles                                                      
      398,530,141,809      instructions              #    2.41  insn per cycle         
        8,569,429,792      branches                                                    
            5,604,194      branch-misses             #    0.07% of all branches        
                11,386      page-faults                                                 

          59.339434065 seconds time elapsed

    Running with 2 threads and m = n = p = 1024
    Time: 287.55539271980524ms


    Performance counter stats for './hw2 -m 1024 -n 1024 -p 1024':

        22,569,159,189      cache-references                                            
            17,451,541      cache-misses              #    0.077 % of all cache refs    
      165,733,764,357      cycles                                                      
      398,862,535,367      instructions              #    2.41  insn per cycle         
        8,664,776,970      branches                                                    
            5,852,447      branch-misses             #    0.07% of all branches        
                13,131      page-faults                                                 

          31.204805681 seconds time elapsed

    Running with 4 threads and m = n = p = 1024
    Time: 156.87119034002535ms


    Performance counter stats for './hw2 -m 1024 -n 1024 -p 1024':

        22,711,627,952      cache-references                                            
            19,089,186      cache-misses              #    0.084 % of all cache refs    
      165,735,267,869      cycles                                                      
      399,599,781,227      instructions              #    2.41  insn per cycle         
        8,873,536,521      branches                                                    
            6,107,215      branch-misses             #    0.07% of all branches        
                12,299      page-faults                                                 

          18.209439059 seconds time elapsed

    Running with 8 threads and m = n = p = 1024
    Time: 88.7338591599837ms


    Performance counter stats for './hw2 -m 1024 -n 1024 -p 1024':

        22,641,168,752      cache-references                                            
            11,334,358      cache-misses              #    0.050 % of all cache refs    
      168,946,582,658      cycles                                                      
      401,362,889,139      instructions              #    2.38  insn per cycle         
        9,363,616,390      branches                                                    
            6,867,516      branch-misses             #    0.07% of all branches        
                42,750      page-faults                                                 

          11.351345751 seconds time elapsed

    Running with 16 threads and m = n = p = 1024
    Time: 51.37464354978874ms


    Performance counter stats for './hw2 -m 1024 -n 1024 -p 1024':

        22,633,909,753      cache-references                                            
            11,066,202      cache-misses              #    0.049 % of all cache refs    
      175,442,463,623      cycles                                                      
      404,443,419,366      instructions              #    2.31  insn per cycle         
        10,247,846,679      branches                                                    
            7,240,100      branch-misses             #    0.07% of all branches        
                26,024      page-faults                                                 

          7.620458383 seconds time elapsed

    Running with 16 threads and m = n = p = 2048
    Time: 418.1614815595094ms


    Performance counter stats for './hw2 -m 2048 -n 2048 -p 2048':

      180,948,585,686      cache-references                                            
        2,796,388,519      cache-misses              #    1.545 % of all cache refs    
    1,487,541,213,346      cycles                                                      
    3,191,957,632,560      instructions              #    2.15  insn per cycle         
        70,064,433,476      branches                                                    
            37,779,890      branch-misses             #    0.05% of all branches        
                89,072      page-faults                                                 

          76.293830835 seconds time elapsed
    ```
    可以看到：
    - 线程数为 $1, 2, 4, 8$ 时，运行时间几乎线性下降，这和我们之前的分析是一致的。
    - 线程数为 $16$ 时，并没有获得线性加速。推测是因为服务器使用的是 12 个逻辑核的 E5-2650 v4，对于矩阵乘法这样运算非常密集的任务，超线程带来的性能提升当然比不上物理线程。
    - $m = n = p = 2048$ 时，矩阵乘法花费约 400ms，性能已经比较好。但是可以看到，与 1024 的实验相比，缓存失效率暴增，说明还有很大的优化空间。
    - 每个实验中，分支预测失败率都非常低，这或许是编译器充分循环展开带来的收益。
    - 每个实验中，平均一个 CPU 周期都完成了两条以上的指令，可见现代 CPU 为了尽可能提高性能，也做出了相当大的努力。
