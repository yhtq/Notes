#import "../../template.typ": *
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
  #let KEYWORD(x) = [\<KEYWORD, "#x"\>]
  #let IntKeyword = KEYWORD("int")
  #let CharKeyword = KEYWORD("char")
  #let ReturnKeyword = KEYWORD("return")
  #let LPAREN = "<LPAREN>"
  #let RPAREN = "<RPAREN>"
  #let LBARCKET = "<LBARCKET>"
  #let RBARCKET = "<RBARCKET>"
  #let SEMICOLON = "<SEMICOLON>"
  #let ID(x) = [\<ID, "#x"\>]
  #let NUM(x) = [\<NUM, "#x"\>]
  #let OpLE = "<LE>"
  #let OpSTAR = "<STAR>"

  #IntKeyword #ID("func") #LPAREN #CharKeyword #OpSTAR #ID("data") #RPAREN #LBARCKET\
    #KEYWORD("if") #LPAREN #OpSTAR #ID("data") #OpLE #NUM(42) #RPAREN #KEYWORD("return") #NUM(1) #SEMICOLON #RBARCKET\
    #KEYWORD("return") #NUM(0) #SEMICOLON\
    #RBARCKET
= 
  == 
    `/* (/ | * | a | b)* */`
  == 
    `a+ b+ c+ d+`，其中 `x+ = x x*`
  == 
    #automaton(
  (
    q00:       (q10: "a", q01: "b"),
    q10:       (q00: "a", q11: "b"),
    q01:       (q11: "a", q00: "b"),
    q11:       (q01: "a", q10: "b"),
  ),
  initial: "q00",
  final: ("q00",),
)
  == 
    #automaton(
  (
    q0:       (q0: "b", q1: "a"),
    q1:       (fail: "bb", q2: "ab", q1: "aa, ba"),
    q2:      (fail: "b", q1: "a"),
  ),
  initial: "q0",
  final: ("q0", "q1", "q2"),
)
== 
      #automaton(
  (
    q0:     (q0: "0", q1: "1"),
    q1:     (q2: "0", q3: "1"),
    q2:    (q0: "0", q1: "1"),
    q3:   (q2: "0", q3: "1"),
    q4:   (q3: "0", q4: "1"),
  ),
  initial: "q0",
  final: ("q3"),
)
=
  == 
    $
      &D_a ((a b | a c c)^*) = D_a (a b | a c c) (a b | a c c)^* = (D_a (a b) | D_a (a c c)) (a b | a c c)^* \
      &quad = (b | c c) (a b | a c c)^*\
      &D_b ((a b | a c c)^*) = epsilon\
      &D_c ((a b | a c c)^*) = epsilon\
    $
    $
      &D_a ((b | c c) (a b | a c c)^*) = epsilon\
      &D_b ((b | c c) (a b | a c c)^*) = (a b | a c c)^*\
      &D_c ((b | c c) (a b | a c c)^*) = c (a b | a c c)^*\
    $
    $
      &D_c (c (a b | a c c)^*) = (a b | a c c)^*\
      &D_a (c (a b | a c c)^*) = epsilon\
      &D_b (c (a b | a c c)^*) = epsilon\
    $
          #automaton(
    (
      q0:     (q1: "a"),
      q1:     (q0: "b, cc")
    ),
    initial: "q0",
    final: ("q0"),
  )
  ==
    $
      D_b (b (a b | b a | a a b)^* b) = (a b | b a | a a b)^* b\
    $
    $
      D_a ((a b | b a | a a b)^* b) = (b | a b) (a b | b a | a a b)^* b | b\
      D_b ((a b | b a | a a b)^* b) = a (a b | b a | a a b)^* b | b
    $
    $
      D_a ((b | a b) (a b | b a | a a b)^* b | b) = b (a b | b a | a a b)^* b\
      D_b ((b | a b) (a b | b a | a a b)^* b | b) = (a b | b a | a a b)^* b | epsilon
    $
    $
      D_a (a (a b | b a | a a b)^* b | b) = (a b | b a | a a b)^* b\
      D_b (a (a b | b a | a a b)^* b | b) = epsilon 
    $
    #automaton(
    (
      q0:     (q1: "b"),
      q1:     (q2: "a", q3: "b"),
      q1e:     (q2: "a", q3: "b"),
      q2:     (q0: "a", q1e: "b"),
      q3:     (q1: "a", qe: "b"),
    ),
    initial: "q0",
    final: ("qe", "q1e"),
    )