#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "../template.typ": *
#show: note.with( 
  withOutlined: false,
  withChapterNewPage: false,
  withHeadingNumbering: false,
  withTitle: false
)
#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(),  // freeze theorem counter for animation
  config-info(
    title: [Flow-Sensitive Facts],
    subtitle: [unified style and least implicit information],
    // author: [郭子荀 2100012990\@stu.pku.edu.cn],
    date: datetime.today(),
    // institution: [北京大学数学科学学院],

  ),
)
#set text(size: 22pt)
#title-slide()
== (Imperative) Program as proof
  Using mutable (stack) variables and loops:
  ```c
  Nat add_zero(const Nat x) 
  [[require True]]
  [[ensure x + 0 == x]]
  {
    Nat x1 = x as x1_def;
    // x1_def : x1 == x
    // initialize loop invariant
    thm loop_inv = ...;// x1 + 0 == x1 -> x + 0 = x
    while (x1 > 0) {
      // in the loop body, if a theorem from outside the loop is used,
      // it should be an invariant of the loop
      // so, the "value" of this theorem at the beginning and the end of the loop should be the same 
      Nat x2 = prev(x1) as x2_def;
      // x2_def : x2 == prev(x1)
      ...
      loop_inv = ...; // x2 + 0 == x2 -> x + 0 = x
      drop(...);
      ... // to maintain the consistency, assignment of a variable is banned if a theorem about it is still alive
      x1 = x2 as x1_def;
      loop_inv = ...; // x1 + 0 == x1 -> x + 0 = x
    }
    ......
  }
  ```
== (Imperative) Program as proof
  Using immutable (stack) variables and loops:
  ```c
  void add_zero(const Nat x) 
  [[require True]]
  [[ensure x + 0 == x]]
  {
    [Nat* xp, Cap xp_c] = malloc();
    xp_c = write(x1, xp_c, x);
    // x1_p : data_at(xp, x)

    [thm xp_v, Cap xp_c_inv] = decompose(xp_c);
    // xp_v : *xp == x
    // xp_c : int_data_at(xp) 

    // initialize loop invariant
    // Not sure `*xp` is a possible option here, but t least we can avoid using an existential quantifier
    // perhaps `*` can just be an uninterrupted function and only some interface functions provides property about it.
    // also, it should "borrow" the capacity of the pointer, so that capacity can not be consumed during the lifetime of such a theorem.
    thm loop_inv = ...;// *xp + 0 == *xp -> x + 0 = x
    while (x1 > 0) {
      Nat xp_pre = read(xp, xp_c);
      // xp_pre_def : xp_pre == *xp;
      loop_inv = rewrite(loop_inv, xp_pre_def);
      // loop_inv : xp_pre + 0 == xp_pre -> x + 0 = x
      // after this, `loop_inv` will not borrow `xp_c_inv`
      Cap xp_c1 = write(xp, xp_c_inv, prev(xp_pre));
      // xp_c1 : data_at(xp, prev(xp_pre))
      [thm xp_v, xp_c_inv] = decompose(xp_c1);
      // xp_v : *xp == prev(xp_pre)
      // xp_c_inv : int_data_at(xp), one of the loop invariant is recovered
      loop_inv = ...;
      // prev(xp_pre) + 0 == prev(xp_pre) -> x + 0 = x
      loop_inv = rewrite(loop_inv, xp_v);
      // loop_inv : *xp + 0 == *xp -> x + 0 =
    }
    ...
  ```
== (Imperative) Program as proof
  Using immutable (stack) variables and recursive functions:
  ```c
  Nat add_zero(Nat x) 
  [[require True]]
  [[ensure x + 0 == x]]
  {
    void add_zero_rec(Nat x1) 
    [[require x1 + 0 == x1 -> x + 0 == x]]
    [[ensure x + 0 == x]]
    {
      if (x1 == 0) {
        ...
      }
      else {
        add_zero_rec(prev(x1)) as add_zero_rec_result;
        ...
      }
    }
  }
  ```
  It is just like the tail recursion form of the first version. The assignment in the first version is the same as "go to the next stack" in this version(where naturally all things of previous stack are invisible except the post condition of the function call, that is why we must manually drop them in the first version).
== Simply Merging branches keeps expressiveness
  - When coming across an `If` structure, simply merging the common results and ignore others is a common choice.
  - With some manual operation and tricks, it seems that merging branches can keep the expressiveness of the program in the context of explicit program reasoning.

  For example, if we want to get a `cond -> result` in a `if` structure, we can just write:
  ```c
  thm result;
  if (cond: `cond`) {
    result = ...(`result_we_want`);
    result = imp_true(cond, result);
    // result : `cond` -> `result_we_want`
  }
  else {
    // Notice we have !`cond' -> (`cond` -> `result_we_want`)
    result = false_imp(cond, `result_we_want`);
    // result : `cond` -> `result_we_want`
  }
  // the result of both branch are exactly `cond` -> `result_we_want`, so merging them and get result: `cond` -> `result_we_want` is safe  
  ```

  Here are some concrete examples:

  ```c
  void square_mod_four(Nat x)
  [[require True]]
  [[ensure (x * x) % 4 == 0 \/ (x * x) % 4 == 1]]
  {
    thm result;
    if (thm cond: x % 2 == 0) {
      result = ...;
      // result : (x * x) % 4 == 0
      result = or_intro_left(result, ...);
      // result : (x * x) % 4 == 0 \/ (x * x) % 4 == 1
    }
    else {
      result = ...;
      // result : (x * x) % 4 == 1
      result = or_intro_right(result, ...);
      // result : (x * x) % 4 == 0 \/ (x * x) % 4 == 1
    }
    // result: (x * x) % 4 == 0 \/ (x * x) % 4 == 1
  }
  ```
  ```c
  Bool contains_al_least_two(Nat x, const natList* l_p, const Cap l_c)
  [[require l_c : listrep(l_p, ?l)]]
  [[ensure __result == (count x l > 1)]]
  {
    Bool already_met = false;
    natList l_left = nil;
    thm loop_inv = ...;
    // loop_inv : l == append l_left (*l_p) /\ (count x l_left == 0 \/ already_met) 
    while (cond: l_p != NULL)) {
      [Nat l_cur, natList* l_p_next, const Cap l_c_next, thm destruct_cons] = destruct_list(l_p, l_c) with l_p;
      // destruct_cons : *l_p == cons(l_cur, *l_p_next)
      thm result;
      // our target is to prove `result: count x l_left == 0 \/ already_met`
      if (met: l_cur == x) {
        thm already_met_must_be_true;
        if (second_met: already_met) {
          thm result = ...;
          return true with result;
          already_met_must_be_true = unreachable(`already_met == True`);  // ?
        }
        else {
          already_met = true;
          already_met_must_be_true = ...;
          // already_met_must_be_true : already_met == True
        }
        // already_met_must_be_true : already_met == True
        result = or_intro_right(...);
        // result : (count x l_left_next == 0 \/ already_met)
      }
      else {
        // met : !(l_cur == x)
        if (has_met : already_met == True) {
          result = or_intro_right(...);
          // result : (count x l_left_next == 0 \/ already_met)
        }
        else {
          // has_met : !(already_met == True);
          result = ...;
          // result : count x l_left_next == 0
          result = or_intro_left(result, ...);
          // result : (count x l_left_next == 0 \/ already_met)
        }
      }
      drop(l_c);
      l_p = l_p_next;
      l_c = l_c_next;
    }
  }
  ```
== Simply Merging branches keeps expressiveness
  - Perhaps choosing to merge branches and left the common results only can still provide enough expressiveness and freedom for the program reasoning.

  - At the same time, such an option provides an alternative formulation: a (flow-sensitive) theorem keeps validation if and only if every (inbound) neighborhood node in the control flow graph gives the same result. 