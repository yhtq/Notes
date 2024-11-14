#import "../../template.typ": proof, note, corollary, lemma, theorem, definition, example, remark
#import "../../template.typ": *
#show: note.with(
  title: "作业11",
  author: "YHTQ",
  date: datetime.today().display(),
  logo: none,
  withOutlined : false,
  withTitle : false,
  withHeadingNumbering: false
)
= 1
  #let code = read("./SSA.cpp")
  #let ssa = read("./SSA.opt.ll")
  代码为：

  #raw(code, block: true, lang: "cpp")

  SSA形式为：

  #raw(ssa, block: true, lang: "llvm")

  可以看到，尽管 llvm 对第 7 行的 `a` （也即 `%8`）采用了新变量，但由于循环执行多次，`%8` 也只能被赋值多次。
= 2
  Result

  Annotated program after forward analysis
  ```c
  var i : int, j : int;
  begin
    /* (L2 C5) top */
    i = 0; /* (L3 C8) [|i>=0; -i>=0|] */
    j = 0; /* (L4 C8)
              [|i>=0; -i+11>=0; -i+j>=0; i+j>=0; j>=0|] */
    while i <= 10 do
      /* (L5 C18)
        [|i>=0; -i+10>=0; -i+j>=0; i+j>=0; j>=0|] */
      i = i + 1; /* (L6 C14)
                    [|i-1>=0; -i+11>=0; -i+j+1>=0; i+j-1>=0; j>=0|] */
      j = j + 2; /* (L7 C14)
                    [|i-1>=0; -i+11>=0; -i+j-1>=0; i+j-3>=0; j-2>=0|] */
    done; /* (L8 C7)
            [|i-11>=0; -i+11>=0; -i+j>=0; i+j-22>=0; j-11>=0|] */
  end
  ```
  Source
  ```c
  var i:int, j:int;
  begin
    i = 0;
    j = 0;
    while (i<=10) do
      i = i + 1;
      j = j + 2;
    done;
  end
  ```
  - 普通的区间分析经过加宽（无法变窄）只能分析得到 $j in [0,+infinity]$
  - 八边形分析得到了 $j >= 11$
  - 但理想情况下，应该可以得到 $j = 22$，既然事实上有 $x - 2 y = 0$