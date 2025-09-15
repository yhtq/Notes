#import "../template.typ": *
#show: note.with(
  title: "理论计算机基础",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withChapterNewPage: true
)
= 前言
  == 历史
    图灵机概念的提出往往被认为是理论计算机科学的开端。Martin Davis 在 《Engines of Logics》一书中认为，它来源于 17 世纪莱布尼茨提出的，是否所有的数学都可以归结于某种演算（Calculus）。
  == 主要内容
  + 可计算性：通常来说，人们研究的计算模型包括：
    - 图灵机：机器模型
    - 递归函数：数学模型
    - Lambda 演算：程序模型
  + 形式语言
  + 复杂性
= 可计算性
  == S 语言
    #let ifGoto(x, y) = $"IF" #x != 0 "GOTO" #y$
    #let Goto(x) = $"GOTO" #x$
    #definition[S 语言][
      S 语言是一个非常简单的编程语言，它包括：
      - 输入变量：初始有固定值
      - 中间变量
      - 输出变量
      - 标号：$A_1, A_2, ...$
      - 语句：
        $
          V &<- V + 1\
          V &<- V - 1\
          "IF" V &!= 0 "GOTO" A_i\
        $
    ]
    在 S 语言中，我们可以定义许多方便的宏指令，例如：
    $
      "GOTO" A_i := 
        &Z <- Z + 1\
        &"IF" Z != 0 "GOTO" A_i
    $
    注意 S 语言的程序可能出现死循环，此时我们认为，它的语义是一个部分函数。例如下面的程序：
    $
      A:&ifGoto(x, B)\
        &Goto(A)\
      B:&x <- x - 1\
        &y <- y + 1\
        &ifGoto(x, A)\
    $
    程序的实际执行被认为在某个机器状态中。事实上，只需要考虑：
    $
      (i, Sigma)
    $
    其中 $i$ 是将要执行的行号，$Sigma$ 是所有变量的当前值。这个二元组被称为*快相*，它决定了之后程序的计算过程和结果。我们记：
    $
      (i, Sigma) -> (j, Sigma')
    $
    意味着从快相 $(i, Sigma)$ 出发，执行一条语句后，变为快相 $(j, Sigma')$。也就是后者是前者的*后继*。
    #definition[可计算][
      如果 $f(X)$ 是一个部分函数，且存在一个 S 语言程序 $P$，对于任何 $X$ 都有 $P$ 以 $X$ 作为输入时，最终输出 $f(X)$（不停机相当于无定义），则称 $f$ 是可计算的。
    ]