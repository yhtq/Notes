#import "../../template.typ": *
#import "../main.typ": *
#import "@preview/tdtr:0.5.4" : *
#import "@preview/finite:0.5.1": automaton, layout
#show: note.with(
  title: "作业9",
  author: "YHTQ",
  date: none,
  logo: none,
  withOutlined : false,
  withTitle :false,
  withHeadingNumbering: none
)
#let dotb = math.dot.o
#set text(font: "Noto Sans Mono CJK SC", size: 12pt)
#show math.equation: it => {
  set text(font: "Noto Sans Math")
  math.serif(it)
}
#let EOF = "EOF"
#let move = "移进"
#let reduce = "规约"
#let accept = "接受"
=
  ==
    #automaton(
      (
        q0:     (q1: $S$, q2: $epsilon$, q3: $epsilon$),
        q3:   (q4: $a$),
        q2:  (q5: $a$),
        q4:  (q6: $S$, q2: $epsilon$, q3: $epsilon$),
        q6:  (q7: $b$),
        q5:  (q8: $b$),
      // q1:     (q2: "0", q3: "1"),
      // q2:    (q0: "0", q1: "1"),
      // q3:   (q2: "0", q3: "1"),
      // q4:   (q3: "0", q4: "1"),
      ),
      labels: (
        q0: $S' -> dotb S "EOF"$,
        q1: $S' -> S dotb "EOF"$,
        q2: $S -> dotb a S b$,
        q3: $S -> dotb a b$,
        q4: $S -> a dotb S b$,
        q5: $S -> a dotb b$,
        q6: $S -> a S dotb b$,
        q7: $S -> a S b dotb$,
        q8: $S -> a b dotb$
      ),
      style:(
        state: (radius: 1.5)
      ),
      initial: "q0",
      final: (),
      layout:layout.snake.with(columns:3)
    )
    $FOLLOW(S) = {b, EOF}$
    #table(columns: 4,
      [],[$a$],[$b$],[$EOF$],
      [$epsilon$],[#move],[],[],
      [$S$],[],[],[#accept],
      [$beta a$],[#move],[#move],[],
      [$beta a S$],[],[#move],[],
      [$beta a b$],[#reduce [2]],[#reduce [2]],[#reduce [2]],
      [$beta a S b$],[#reduce [1]],[#reduce [1]],[#reduce [1]],
    )
    是 LR(0)
  ==
    #automaton(
      (
        q0:     (q01: $S$, q1: $epsilon$, q2: $epsilon$, q3: $epsilon$),
        q3: (q31: $a$),
        q1: (q11: $S$, q1: $epsilon$, q2: $epsilon$, q3: $epsilon$),
        q11: (q12: $S$, q1: $epsilon$, q2: $epsilon$, q3: $epsilon$),
        q12: (q13: $+$),
        q2: (q21: $S$, q1: $epsilon$, q2: $epsilon$, q3: $epsilon$),
        q21: (q22: $S$, q1: $epsilon$, q2: $epsilon$, q3: $epsilon$),
        q22: (q23: $*$),
      ),
      labels: (
        q0: $S' -> dotb S "EOF"$,
        q01: $S' -> S dotb "EOF"$,
        q1: $S -> dotb S S +$,
        q2: $S -> dotb S S *$,
        q11: $S -> S dotb S +$,
        q12: $S -> S S dotb +$,
        q13: $S -> S S + dotb$,
        q21: $S -> S dotb S *$,
        q22: $S -> S S dotb *$,
        q23: $S -> S S * dotb$,
        q3: $S -> dotb a$,
        q31: $S -> a dotb$,
      ),
      style:(
        state: (radius: 1.5)
      ),
      initial: "q0",
      final: (),
      layout:layout.snake.with(columns:4)
    )
    $FOLLOW(S) = {a, +, *, EOF}$
    #table(columns: 5,
      [],[$a$],[$+$],[$*$],[$EOF$],
      [$epsilon$],[#move],[],[],[],
      [$beta S$],[#move],[],[],[#accept],
      [$beta S S$],[],[#move],[#move],[],
      [$beta S S +$],[#reduce [1]],[#reduce [1]],[#reduce [1]],[#reduce [1]],
      [$beta S S *$],[#reduce [2]],[#reduce [2]],[#reduce [2]],[#reduce [2]],
      [$beta a$],[#reduce [3]],[#reduce [3]],[#reduce [3]],[#reduce [3]],
    )
    是 LR(0)
=
#let assign = "assign"
#let idt = "id"
#let num = "num"
#automaton(
  (
    s0:   (s01: $S$, s1: $idt$, s2: $V$),
    s2:   (s21: $assign$),
    s21:  (s22: $E$, e4: $V$, e5: $num$, v4: $idt$)
  ),
  labels: (
    s0: $S' -> dotb S \ S -> dotb idt\ S -> dotb V assign E\ ; EOF\ V -> dotb idt; assign$,
    s01: $S' -> S; EOF$,
    s1: $S -> idt dotb; EOF\ V -> idt dotb; assign$,
    s2: $S -> V dotb assign E\ ; EOF$,
    s21: $S -> V assign dotb E\ E -> dotb V\ E -> dotb num\ V -> dotb id\ ; EOF$,
    s22: $S -> V assign E dotb\ ; EOF$,
    e4: $E -> V dotb; EOF$,
    e5: $E -> num dotb; EOF$,
    v4: $V -> idt dotb; EOF$,
  ),
  style:(
    state: (radius: 2.1)
  ),
  initial: "q0",
  final: (),
  layout:layout.snake.with(columns:3)
)
#table(columns: 5,
  [],[$id$],[$assign$],[$num$],[$EOF$],
  [$epsilon$],[#move],[#move],[#move],[],
  [$beta S$],[],[],[],[#accept],
  [$beta id$],[],[#reduce [3]],[],[#reduce [1]],
  [$beta V$],[],[#move],[],[],
  [$beta V assign$],[#move],[],[#move],[],
  [$beta V assign E$],[],[],[],[#reduce [2]],
  [$beta num$],[],[],[],[#reduce [5]],
)
是 LR(1)
  =
  #automaton(
    (
      s0:   (s01: $S$, v4: $idt$, s2: $L$, s3: $R$, e5: $*$),
      s2:   (s21: $assign$),
      s21:  (s22: $R$, e4: $L$, e5: $*$, v4: $idt$),
      e5: (v4: $idt$, e5: $*$)
    ),
    labels: (
      s0: $S' -> dotb S \ S -> dotb L assign R\ S -> dotb R\ R -> dotb L ; EOF\ L -> dotb * R\ L -> dotb id; assign \/ EOF$,
      s01: $S' -> S; EOF$,
      s2: $S -> L dotb assign R\ R -> L dotb ; EOF$,
      s3: $S -> R dotb; EOF$,
      s21: $S -> L assign dotb R\ R -> dotb L\ L -> dotb * R\ L -> dotb id ; EOF$,
      s22: $S -> L assign R dotb\ ; EOF$,
      e4: $R -> L dotb; EOF$,
      e5: $L -> * dotb R;\ R -> dotb L\ L -> *R\ L -> dotb id; EOF\/*\/idt\/assign$,
      v4: $L -> idt dotb\ ; EOF\/*\/idt\/assign$
    ),
    style:(
      state: (radius: 2.5)
    ),
    initial: "q0",
    final: (),
    layout:layout.snake.with(columns:3)
  )
  #table(columns: 5,
    [],[$id$],[$assign$],[$*$],[$EOF$],
    [$epsilon$],[#move],[],[#move],[],
    [$beta S$],[],[],[],[#accept],
    [$beta id$],[#reduce [4]],[#reduce [4]],[#reduce [4]],[#reduce [1]],
    [$beta L$],[],[#move],[],[#reduce [5]],
    [$beta R$],[#reduce [2]],[#reduce [2]],[#reduce [2]],[#reduce [2]],
    [$beta L assign$],[#move],[],[#move],[],
    [$beta L assign R$],[],[],[],[#reduce [1]],
    [$beta *$],[#move],[],[#move],[],
    [$beta * R$],[#reduce [3]],[#reduce [3]],[#reduce [3]],[#reduce [3]],
  )
