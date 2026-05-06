#import "../template.typ": *
#import "@preview/commute:0.3.0": *
#show: note.with( 
  withOutlined: false,
  withChapterNewPage: false,
  withTitle: false
)
#let Cat = math.bold("Cat") 
主要参考了#link("https://homepages.inf.ed.ac.uk/gdp/publications/alg_ops_gen_effects.pdf")[这里]
= Enriched monoidal categories, strong monads, and cotensors
  设 $V$ 是一个么半范畴（定义了张量积的范畴），满足：
  - $V$ 是对称闭的（张量积具有对称性，且：
    $
      Hom_V (a tensorProduct b, c) eqv Hom_V (a, Hom(b, c))
    $
    ）
  - 具有所有小极限和小余极限
  #definition()[Enriched monoidal category][
    称 $C$ 是一个 $V$-增广范畴（enriched category），如果：
    - 对 $C$ 的任何对象 $x, y$，$Hom(x, y)$ 是 $V$ 中的对象
    - $C$ 态射的复合对应 $V$ 中的态射：
      $
        Hom_C (y, z) tensorProduct Hom_C (x, y) -> Hom_C (x, z)
      $
    - 单位态射 $j_x: 1 -> Hom (x, x)$
    典型的，所有范畴都是 $SetCat$-增广范畴
  ]
  记所有 $V-$ 增广范畴组成的范畴为 $V-Cat$，它上面有自然的对称么半结构，定义为：
  - $C tensorProduct D$ 的对象集就是 $"Obj"(C) times "Obj"(V)$
  - $Hom_(C tensorProduct D) ((x_1, y_1), (x_2, y_2)) = Hom_C (x_1, x_2) tensorProduct Hom_D (y_1, y_2)$
  类似的，自然变换，（对称闭）张量积也可以推广到 $V$ 增广意义下。一个增广意义下的（对称闭）张量积同时也是普通意义下的（对称闭）张量积。

  #definition()[么半范畴上的代数][
    设 $C$ 是一个么半范畴，称 $(A, mu, eta)$ 是其上的一个数，其中：
    - $A$ 是 $C$ 中的一个对象
    - $mu: A tensorProduct A -> A$
    - $eta: 1 -> A$
    并且满足一些单位律和结合律。称 $phi$ 是两个代数 $A, A'$ 之间的同态，有交换图：
    #align(center)[#commutative-diagram(
    node((0, 0), $1$, 1),
    node((0, 1), $A$, 2),
    node((1, 0), $A'$, 3),
    arr(1, 2, $$),
    arr(3, 2, $$),
    arr(1, 3, $$),)]
    #align(center)[#commutative-diagram(
    node((0, 0), $A tensorProduct A$, 1),
    node((0, 1), $A' tensorProduct A'$, 2),
    node((1, 0), $A$, 3),
    node((1, 1), $A'$, 4),
    arr(1, 2, $phi tensorProduct phi$),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $phi$),)]
  ]

  #definition[Monad/单子][
    $C$ 的自函子范畴上的代数称为 $C$ 上的单子（monad）。即一个单子是一个三元组 $(T, mu, eta)$，其中：
    - $T: C -> C$ 
    - $mu: T compose T -> T$
    - $eta: id -> T$
    并且满足单位律和结合律。

    称一个单子是强单子，如果还有自然变换：
    $
      x tensorProduct (T y) -> T (x tensorProduct y)
    $
    以及一些融贯性条件。这个自然变换也可以推广到 $V$ 增广意义下。
  ]

  #definition()[T-模/代数][
    称 $(M, a)$ 是一个单子 $T$ 的模/代数，如果：
    - $M$ 是 $C$ 中的一个对象
    - $a: T M -> M$
    并且满足交换图:
    #align(center)[#commutative-diagram(
    node((0, 0), $T^2 M$, 1),
    node((0, 1), $T M$, 2),
    node((1, 0), $T M$, 3),
    node((1, 1), $M$, 4),
    arr(1, 2, $T a$),
    arr(1, 3, $mu_M$),
    arr(2, 4, $a$),
    arr(3, 4, $a$),)]
    #align(center)[#commutative-diagram(
    node((0, 0), $M$, 1),
    node((0, 1), $T M$, 2),
    node((1, 0), $M$, 3),
    arr(1, 2, $eta_M$),
    arr(2, 3, $a$),
    arr(1, 3, $id$),)]
    称所有 $T$ 模构成的范畴为 $C^T$
  ]
  #example[][
    $T: a -> [a]$ 是一个强单子，如果 $(a, f)$ 是其上的单位，就是说：
    - $f: [a] -> a$
    - $f([x]) = x$
    - $f("map" f space l) = f("join" l)$
    比如取 $a = "Int", f = "sum"$ 就是一个 $T$-模。
  ]
  #definition()[自由 $T-$ 模][
    设 $M in C$，可以在 $T M$ 上定义自由的 $T-$ 模结构，其中：
    $
      a : T^2 M -> T M = mu_M
    $
    这样的构造满足函子性，称为 $"Free"^T: C -> C^T$，它是忘却函子 $"Forget": C^T -> C$ 的左伴随，且有：
    $
      "Forget" compose "Free"^T = T
    $
  ]

  #definition()[Kleisli category][
    设 $T$ 是 $C$ 上的单子，称 $C_T$ 的包含 $"Free"^T$ 的像的全子范畴为 $T$ 的 Kleisli 范畴，记作 $C_T$
  ]

  #definition()[Kleisli exponent][
    设 $C$ 是一个 $V$ 增广范畴，$T$ 是 $C$ 上的强单子，称 $C_T$ 上的 Kleisli 指数（exponent），如果对于任意 $x$,函子：
    $
      "Free"^T ( - tensorProduct x) : C -> C_T
    $
    有右伴随。
  ]
  #lemma[][
    设 $C$ 是 Cartesian closed 的（也即 $tensorProduct = times$，有有限积且闭），则其上所有强单子都有 Kleisli 指数。
  ]
  #proof[
    熟知
    $
      Hom("Free"^T ( y tensorProduct x), z) eqv Hom(y tensorProduct x, "Forget" (z)) eqv Hom(y, Hom(x, "Forget"(z)))
    $
    这就立刻给出了要求的右伴随。
  ]

  Moggi 利用强单子和 Kleisli exponent 给出了 $lambda_c$  算术的模型。

  #definition()[Cotensor / Power][
    设 $V, C$ 是范畴，$v in V, c in C$，记 $v^c$ 是 $v$ 的 $c$ 次方，如果：
    $
      Hom_C (x, v^c) eqv Hom_V (c, Hom_C (x, v))
    $   
    有时也称为 $v$ 关于 $c$ 的余张量（cotensor）。
  ]
  这里的“余”是因为张量（tensor）有典型的性质：
  $
    Hom_C (v tensorProduct c, x) eqv Hom_V (c, Hom_C (v, x))
  $
  （常见情形是 $tensorProduct = times$，上面的式子就是常说的 Curry 化）

  #example()[][
    设 $C = SetCat$（集合构成的范畴），则：
    $
      v^c = product_(i in c) v
    $
    这是因为：
    $
      Hom_C (x, v^c) = Hom_C (x, product_(i in c) v) = product_(i in c) Hom_C (x, v) = Hom_V (c, Hom_C (x, v))
    $
  ]
  接下来，我们总认为 $C$ 是对称么半的 $V-$ 范畴，具有所有的 cotensor，$T$ 是 $C$ 上的强单子，并具有 Kleisli 指数。
  #definition()[Parametrised Lifting][
    $
      Hom(y tensorProduct x, T z) ->^T Hom(T(y tensorProduct x), T^2 z) -> Hom(y tensorProduct T x, T z)
    $
  这个自然变换称为参数化提升（parametrised lifting）。也就是说，设：
  ```haskell f:: (Y, X) -> M Z```，可以定义：
  ```haskell 
  f^# :: (Y, M X) -> M Z 
  f^# (y, mx) = do
    x <- mx
    f (y, x)
  
  ```
  ]
  参数提升的过程也可以推广到 $V$ 增广意义下。注意到：
  $
    Hom(v, Hom ((T x)^v, T x)) eqv Hom((T x)^v, (T x)^v)
  $
  因此在右侧取得 $id$，立刻得到 $v -> Hom ((T x)^v, T x)$，继而得到 $v ->  Hom (y tensorProduct (T x)^v, y tensorProduct T x)$，继而得到 $Hom(y tensorProduct (T x)^v, (y tensorProduct T x)^v)$
  
  // 回忆 cotensor 的定义，对于任何 $x$，总有：
  // $
  //   Hom (x, x^c) eqv Hom(c, Hom(x, x))
  // $
  // 如果在右侧取得 $id: c -> 1 -> Hom(x, x)$，立刻就可取得左侧的一个态射：
  // $
  //   i_x: x -> x^c
  // $
  // 相当于，在 $x^c$ 的每一个的分量上都复制一遍 $x$，利用这个映射，我们可以得到：
  // $
  //   y -> y^v\
  //   y tensorProduct (T x)^v -> y^v tensorProduct (T x)^v = (y tensorProduct T x)^v
  // $
  因此，就有：
  $
    Hom(y tensorProduct T x, T z) -> Hom((y tensorProduct T x)^v, (T z)^v) -> Hom(y tensorProduct (T x)^v, (T z)^v)
  $
= Algebraic operations
  #definition()[][
    设 $T$ 是 $V-$ 强单子，则称一个代数操作（algebraic operation）是一系列态射：
    $
      alpha_x : (T x)^v -> (T x)^w
    $
    满足融贯性条件：
    #align(center)[#commutative-diagram(
    node((0, 0), $Hom(y tensorProduct x, T z)$, 1),
    node((0, 1), $Hom(y tensorProduct (T x)^v, (T z)^v)$, 2),
    node((1, 0), $Hom(y tensorProduct (T x)^w, (T z)^w)$, 3),
    node((1, 1), $Hom(y tensorProduct (T x)^v, (T z)^w)$, 4),
    arr(1, 2, $$),
    arr(1, 3, $$),
    arr(2, 4, $$),
    arr(3, 4, $$),)]
  ]
  #example()[][
    一个典型情况是，$V = SetCat$，以 $v = {1, 2}, w = {1}$ 为例，$alpha_x$ 满足：
    $
      alpha_x : (T X, T X) -> T X
    $
    融贯性条件大体是说，假如给定：
    ```haskell
      k :: (Y, X) -> T Z
    ```
    （也就是 continuation），如果将上面的 $alpha_x$ 记作 `op`，则我们有两种自然的构造函数：
    ```haskell
      f :: (Y, (T X, T X)) -> T Z
    ```
    的方式，一种是：
    ```haskell
      f (y, (tx1, tx2)) = do
        x1 <- tx1
        x2 <- tx2
        k (y, x1) `op` k (y, x2)
    ```
    另一种是：
    ```haskell
      f (y, (tx1, tx2)) = do
        x <- tx1 `op` tx2
        k (y, x)
    ```
    它们未必是等价的，而融贯性条件就是要求两种方式等价。从上面的说明也可以看出，假如 $v = w = {1}$，则融贯性条件是天然成立的，这种简单情形对应一般说的 first-order algebraic effect（`op` 自己不会依赖于其他计算），而更复杂的情形则称为 higher-order algebraic effect。

    如果取 $T x = x + E$，其中 $E$ 是某个异常类型，则我们可以定义 `catch` 操作：
    ```haskell
      catch :: (X + E, X + E) -> X + E
      catch (Right e, b) = Right e
      catch (Left x, b) = b 
    ```
    不幸的是，它并不满足之前的融贯性条件。直观来看，上面的第一种方式只在 `tx1, tx2` 两者都成功时可以成功，但第二种如果 `tx1` 失败，`tx2` 成功也会成功。
  ]
= The Modularity Problem with Higher-Order Operations
  我们使用 algebraic effect 的一个重要目的就是分离 effect 和 handler，从而实现更好的模块化。然而，对于 higher-order algebraic effect `op` 以及另一个 effect handler `h`，我们可能写出下面的程序：
  ```haskell
    handle h (do
      x <- op v
      m
    )
  ```
  其中 $v$ 的类型符合 `op` 的要求。很多时候，$v$ 的内部还存在其他类型的 algebraic effect，然而应用 `h` 这个 handler 时，并不会处理 $v$ 内部的 effect。例如下面的例子中：
  ```haskell
  prog :: IO ()
  prog = runEff . runLog . runSpan $ do
      span "example program" do
          log "foo"

          span "greeting" do
              log "hello"
              log "world"

          log "bar"

  >>> prog
  [Start span 'example program']
  [LOG] foo
  [Start span 'greeting']
  [LOG] hello
  [LOG] world
  [End span 'greeting']
  [LOG] bar
  [End span 'example program']
  ```
  我们希望 `span` 的参数中存在其他 effect （这里就是 `log`） 是十分自然的。这就要求在使用 higher-order algebraic effect 时，必须先使用对应的 handler 处理掉 higher-order 的 effect（通常而言，就是转化为 first-order 的 effect），再处理其他的 effect。

  然而之前提到过，first-order operation 是满足融贯性条件的，它们的组合应该也满足，而许多实用中的 higher-order operation 并不满足融贯性条件，从而这样的转化是无法完成的。

