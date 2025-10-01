#import "@preview/touying:0.5.3": *
#import "../template.typ": *
#import themes.simple: *

// #show: note.with(
//   withChapterNewPage: false,
//   withOutlined: false,
//   withTitle: false,
//   withHeadingNumbering: false,
// )
#show: simple-theme.with(aspect-ratio: "16-9")
#set text(size: 26pt)
= Explicit Refinement Types

== Introduction

- _Type checking in common refinement type systems relies on automation, which heavily restricts the expressiveness(such as using of quantifiers)._
- _In our work, we build a refinement type system, which replaces the use of automated solvers with explicit proofs._(using 'term as proof' paradigm)

== Example
#image("image.png")
- $forall n : NN$ means intersection type, which behaves like quantifiers in ML-style polymorphism (with no runtime entity) rather than $Pi$-type in dependently typed languages.
- $hat(lambda) norm(n : NN)$ intros a *ghost variable* $n$， which can only occur in ghost codes(types, proofs...).
- In let-binding $"let" {l, p} = v$, $l$ is the list value of vector(`Vec` is defined as refinement of type `List`) and $p$ is a proof of $#raw("List.len") l = n$
Here are the full codes with proof codes:
#image("image-1.png")
== Types and Propositions
#image("image-2.png", width: 60%)
== (Part of) Proof rules
#image("image-3.png", width: 70%)
== Erasure to STLC (with monadic error)
#image("image-4.png", width: 70%)
== Erasure to STLC (with monadic error)
- It is guaranteed that, no well-typed term can signal an error. Notice that `absurd p` will erase to `error`, and such program:
    #align(center)[
        $hat(lambda) norm(u : bot) "absurd" p$
    ]
    erases to $lambda u : 1. "error"$ rather than error. (That is why all ghost variable erases to unit rather than being directly removed)
== Relation to dependent type theory
    The authors claim that, $lambda_"ert"$ is a refinement type system rather than a traditional dependent type theory in the following sense:
- All the propositions are classical to be consistent with SMT solvers.
- Intersection types are introduced to archive non-computable quantifiers. The following program:
    $
    "len" : ∀ n : NN, "Vec" n space NN -> NN := lambda n -> lambda \_ -> n
    $
    is invalid. (If we use $Pi-$ type, it is of course valid, but it will cost extra resources in computation.)
- _Types are refinement of STLC types,"fancy types" can always be erased, leaving behind a simply-typed skeleton._ (In comparison, erasure in dependent type language like Coq and squash types)
- _It has no judgemental equality – there is no reduction in types._
