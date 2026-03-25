#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业1",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
= 
  #let KEYWORD(x) = [\<KEYWORD, \ "#x"\>]
  #let IntKeyword = KEYWORD("int")
  #let CharKeyword = KEYWORD("char")
  #let ReturnKeyword = KEYWORD("return")
  #let LPAREN = "<LPAREN>"
  #let RPAREN = "<RPAREN>"
  #let LBARCKET = "<LBARCKET>"
  #let RBARCKET = "<RBARCKET>"
  #let SEMICOLON = "<SEMICOLON>"
  #let ID(x) = [\<ID, \ "#x"\>]
  #let NUM(x) = [\<NUM, \ "#x"\>]
  #let OpLE = "<LE>"
  #let OpSTAR = "<STAR>"
  #tidy-tree-graph(  draw-node: (
    (stroke: none),
  ),)[
  - *Function*
    - *Rty*
      - #IntKeyword
    - #ID("func")
    - #LPAREN
    - *Args*
      - *Ty*
        - *PointerTy*
          - #CharKeyword
          - #OpSTAR
    - *Body*
  ]

  #tidy-tree-graph(compact: true,   draw-node: (
    (stroke: none),
  ),)[
  - *Body*
    - *Stmt*
      - *IfStmt*
        - #KEYWORD("if")
        - #LPAREN
        - *Cond*
          - *BinaryExpr*
            - #OpSTAR
            - #ID("data")
            - #OpLE
            - #NUM(42)
        - #RPAREN
        - *Then*
          - *ReturnStmt*
            - #KEYWORD("return")
            - #NUM(1)
            - #SEMICOLON
    - *Stmt*
      - *ReturnStmt*
        - #KEYWORD("return")
        - #NUM(0)
        - #SEMICOLON
  ]
= 
  ==
    $
      S 
        &=> S S *\
        &=> S S * S *\
        &=> "a" S * S *\
        &=> "a" S S + * S *\
        &=> "a" "a" S + * S *\
        &=> "a" "a" "a" + * S *\
        &=> "a" "a" "a" + * "a" *\
    $
  ==
    $
      S 
        &=> S S *\
        &=> S "a" *\
        &=> S S * "a" *\
        &=> S S S + * "a" *\
        &=> S S "a" + * "a" *\
        &=> S "a" "a" + * "a" *\
        &=> "a" "a" "a" + * "a" *\
    $
  ==
    #tidy-tree-graph(  draw-node: (
    (stroke: none),
  ),)[
      - S
        - S
          - S
            - "a"
          - S
            - S
              - "a"
            - S
              - "a"
            - \+
          - \*
        - S
          - "a"
        - \*
  ]
  == 
    不是二义性的。考虑其镜像的文法：
    $
      S' ::= + S' S' | * S' S' | a
    $
    不难发现：
    $
      FIRST(+ S' S') = {+}\
      FIRST(* S' S') = {*}\
      FIRST(a) = {a}
    $
    它们两两不交，且没有空串，因此它是 LL(1) 文法，自然无二义性。 
=
  ==
    $
      S ::= a A\
      A ::= a A b | epsilon
    $
  ==
    $
      S ::= epsilon | a S a | b S b
    $
  ==
    $
      S ::= a b S | b a S | a a S b b S | b b S a a S | S S | epsilon
    $
  ==
    $
      S_0 ::= a b S_0 | b a S_0 | a a S_0 b b S_0 | b b S_0 a a S_0 | S_0 S_0 | epsilon\
      S ::= (a+) S_0 (a*) | (a*) S_0 (a+) | (b+) S_0 (b*) | (b*) S_0 (b+) | b S a | a S b | S S_0 | S_0 S
    $
= 
  ==
    $
      FIRST(Q) = FIRST(b b c) union FIRST(b c) = {b}\
      FIRST(R) = FIRST(a b a) union FIRST(c a b a) union FIRST(R b c) = {a, c} (epsilon in.not R)\
      FIRST(L) = FIRST(R a) union FIRST(Q b a) = FIRST(R) union FIRST(Q) = {a, b, c} (epsilon in.not R, Q)\
      FIRST(S') = FIRST(L \$) = FIRST(L) = {a, b, c} (epsilon in.not L)\
    $
    $
      \$ in FOLLOW(L) \
      a in FOLLOW(R), b in FOLLOW(Q)\
      b in FOLLOW(R)
    $
    得到：
    $
      FOLLOW(S') = {epsilon}\
      FOLLOW(L) = {\$}\
      FOLLOW(R) = {a, b}\
      FOLLOW(Q) = {b}
    $
  == 
    并不是 LL(1) 的，$R$ 的生成规则产生左递归问题。修改方式是将 $R$ 的规则改为：
    $
      R ::= a b a R' | c a b a R'\
      R' ::= b c R' | epsilon
    $
    之后：
    $
      FIRST(R') = {b, epsilon}\
      FOLLOW(R') = FOLLOW(R) = {a}
    $
    这就是 LL(1) 的了。