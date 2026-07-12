#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "../template.typ": *
#import "@preview/prooflists:0.1.0": *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-common(),
  config-info(
    title: [Extracting Functional Properties from Verified Imperative Programs],
    author: [ ],
    date: datetime.today(),
    institution: [Peking University],
  ),
)

#set text(size: 22pt)
#set page(margin: (top: 1.8em, bottom: 1.2em, x: 2em))
#let purify = math.op("purify")

// Title slide
#title-slide()


= Motivation

== Proving Functional Properties

- Verifying imperative programs often requires proving properties of their _functional model_:
  - List concatenation associativity: $forall l_1, l_2, l_3. "app"("app"(l_1, l_2), l_3) = "app"(l_1, "app"(l_2, l_3))$
  - Sum over append: $"sum"("app"(l_1, l_2)) = "sum"(l_1) + "sum"(l_2)$
  - ... and many more

#pause

- These properties usually beyond the reach of SMT-based automation.

== Lemma Functions:

Tools like VeriFast, Dafny, Verus provide _lemma functions_:

```c
lemma void app_assoc(list l1, list l2, list l3)
  requires true;
  ensures app(app(l1, l2), l3) == app(l1, app(l2, l3));
{
  switch (l1) {
    case nil:
    case cons(h, t): app_assoc(t, l2, l3);
  }
}
```

#pause

But lemma functions are _segregated_ from executable code:
- Must be effect-free (no heap mutation, no allocation)
- Often use separate data types and constructs
- Verifier must implement dedicated support

= The Key Observation

== No Special Proof Language Needed

#pause

Our observation: proving functional-model properties does _not_ require a separate effect-free language.

#pause

#align(center)[
  *Any verified total-correctness imperative program can serve as a proof*
]

== Our Implementation of Proof
```c
void exec_app_assoc(struct node* p1, struct node* p2, struct node* p3)
    //@ requires sll(p1, ?l1) &*& sll(p2, ?l2) &*& sll(p3, ?l3);
    /*@ ensures sll(p1, l1) &*& sll(p2, l2) &*& sll(p3, l3) &*&
                app(app(l1, l2), l3) == app(l1, app(l2, l3)); @*/
{
  if (p1 == 0) {
    //@ open sll(p1, l1);
    //@ close sll(p1, nil);
  } else {
    //@ open sll(p1, l1);
    struct node* q = p1->next;
    exec_app_assoc(q, p2, p3);
    //@ close sll(p1, l1);
  }
}
```


= Purification

#let sem(P) = $lr(bracket.stroked.l #P bracket.stroked.r)$

== From Heap Assertions to Pure Propositions

How to turn a heap-dependent assertion into a pure logical proposition?

#pause

#block[
  *Purification:*
    $
      purify(P) := sep(exists h.,  sem(P),  h)
    $
  #text(size: 16pt)[(read: "there exists a heap satisfying $P$")]
]

== Purification Laws

#pause

$
  purify("pure"(phi)) <=> phi #h(5pt) ("Purify-Pure") \
  purify("emp") <=> top #h(5pt) ("Purify-Emp") \
  purify(P * Q) => purify(P) and purify(Q) #h(5pt) ("Purify-Star") \
  purify(P or Q) <=> purify(P) or purify(Q) #h(5pt) ("Purify-Or") \
  purify(sep(forall x, P(x))) => forall x.\, purify(P(x)) #h(5pt) ("Purify-Forall") \
  purify(sep(exists x., P(x))) <=> exists x.\, purify(P(x)) #h(5pt) ("Purify-Exists")
$

#pause

Plus the entailment rule: $P ⊢ Q => (purify(P) => purify(Q)))$

#let triple(P, s, Q) = $sep([#P], #s, [#Q])$

= The Extraction Rule

== Main Result

  *Extraction Rule:*
  #align(center, prooflist[
    / Extraction: $purify(P) => purify(Q)$
      $triple(P, s, Q)$
  ])


#pause

A verified imperative program is a proof of a _pure_ implication. The program $s$ completely disappears.

#pause

$s$ may allocate, mutate, free
_any_ side effects are irrelevant to the extracted proposition.

== Soundness (Trivial!)

#pause

*Proof.* Assume $triple(P, s, Q)$ and $purify(P)$.
+ By definition of purify, pick $h_0$ with $sem(P) h_0$
+ By validity of the triple, there exists $h_1$ with $⟨s, h_0⟩ ⇓ h_1$ and $sem(Q) h_1$
+ This $h_1$ witnesses $exists h. sem(Q) h = purify(Q)$

#pause

The program acts as a _Skolem witness_: $exists f.\, forall h_1.\, sem(P) h_1 => sem(Q) (f\;h_1)$

= Syntactic Extraction

== A Proof-Theoretic Account


At the same time of semantic soundness, as the proof-theoretic reading of extraction: each program-logic inference rule reflects into a _fixed sequence_ of meta-logic reasoning.

This view commits to a specific set of program-logic rules, hence harder to generalize. As payoff, it may give a more structural proofs.

#pause

For a minimal heap-manipulating language:
$
    s ::= "malloc"(e) | "free"(e) | "store"(e_t, e) \
    | "copy"(e_s, e_t) | "bop"(e_t, e_1, e_2) \

     | "skip"  s |  "if" e "then" s "else" s  | "while" e "inv" P "dec" e_d "do" s
$

#pause

We prove: for every derivable $triple(P, s, Q)$, a proof of $purify(P) => purify(Q)$ is constructible in a _structure-preserving_ way.

== Induction on Derivations


Key lemma (Framed Extraction): for every derivation of $triple(P, s, Q)$, we construct a proof of
  $
    purify(P * R) => purify(Q * R) quad "for arbitrary " R
  $

#pause

- _SL-Skip_: reflexivity of implication
- _SL-Seq_: transitivity of implication
- _SL-Frame_: associativity of $*$ + induction hypothesis
- _SL-Conseq_: #text(fill: green.darken(20%))[Purify-Entails]
- _SL-If_: case split via #text(fill: green.darken(20%))[Purify-Or]
- _SL-While_: well-founded induction on variant
- Primitive ops: #text(fill: green.darken(20%))[Purify-Heap-Modify], #text(fill: green.darken(20%))[Purify-Heap-Alloc]

= Representability

== From Extracted Implication to the Goal


Extraction gives us:
  $
    &purify("sll"(p_1, l_1) * "sll"(p_2, l_2) * "sll"(p_3, l_3)) \
    &=> purify("sll"(p_1, l_1) * "sll"(p_2, l_2) * "sll"(p_3, l_3) * "app"("app"(l_1, l_2), l_3) = "app"(l_1, "app"(l_2, l_3)))\
    &("by Purify-Star and Purify-Pure" )\
    &=> purify("sll"(p_1, l_1) * "sll"(p_2, l_2) * "sll"(p_3, l_3)) and "app"("app"(l_1, l_2), l_3) = "app"(l_1, "app"(l_2, l_3)))\
    &=> "app"("app"(l_1, l_2), l_3) = "app"(l_1, "app"(l_2, l_3))
  $

#pause

But we want just the equation.

The antecedent remains to be discharged.

== Representability Condition


#block[
  *Representability:* A type $T$ is _representable_ by predicate $P(r, v)$ if for all $v : T$ and $Q$:
  $
    purify(Q) => sep(exists r., purify(Q * P(r, v)))
  $
  In another word: any heap can be extended with a fresh representation of $v$
]

#pause

For linked lists (inductive predicate #text(fill: blue.darken(20%))[sll]):
- Base: $purify("emp") => exists p.\, purify("sll"(p, "nil"))$ (take $p = 0$)
- Step: build one node + recursive call -> representability by induction

#pause

Then discharge the antecedent:
  $
    purify("emp") => sep(exists p_1., purify("sll"(p_1, l_1))) =>  sep(exists p_1, p_2., purify("sll"(p_1, l_1) * "sll"(p_2, l_2))) => dots.h.c
  $

= Examples

== List Append Associativity (Recursive)


```c
struct node *exec_app_assoc2(struct node *p1, struct node *p2, struct node *p3)
  //@ requires sll(p1, ?l1) &*& sll(p2, ?l2) &*& sll(p3, ?l3);
  /*@ ensures sll(result, app(l1, l2)) &*& sll(p3, l3) &*&
              app(l1, (app(l2, l3))) == app(app(l1, l2), l3); @*/
{
  if (p1 == 0) { return p2; }
  else {
    //@ open sll(p1, _);
    struct node* q = p1->next;
    p1->next = exec_app_assoc2(q, p2, p3);
    //@ close sll(p1, _);
    return p1;
  }
}
```


_Induction = recursion. Base case = nil branch. Inductive step = recursive call._

== Sum over Append (Iterative)

```c
while (current->next != 0)
  /*@ invariant
    ... &*& lseg(p1, current, ?l1_l) &*& sll(next, ?l1_r) &*&
    append(l1_l, cons(value, l1_r)) == l1 &*&
    acc + value + sum(app(l1_r, l2)) == sum(app(l1, l2)) &*&
    acc + value + sum(l1_r) == sum(l1); @*/
{
  acc += current->value;
  current = current->next;
}
```
