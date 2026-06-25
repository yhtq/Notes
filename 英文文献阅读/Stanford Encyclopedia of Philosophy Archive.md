Russell's Paradox
First published Fri Dec 8, 1995; substantive revision Thu Jun 26, 2014

Russell's paradox is the most famous of the logical or set-theoretical paradoxes. Also known as the Russell-Zermelo paradox, the paradox arises within naïve set theory by considering the set of all sets that are not members of themselves. Such a set appears to be a member of itself if and only if it is not a member of itself. Hence the paradox.

Some sets, such as the set of all teacups, are not members of themselves. Other sets, such as the set of all non-teacups, are members of themselves. Call the set of all sets that are not members of themselves “R.” If R is a member of itself, then by definition it must not be a member of itself. Similarly, if R is not a member of itself, then by definition it must be a member of itself.

Although also noticed by Ernst Zermelo, the contradiction was not thought to be important until it was discovered independently by Bertrand Russell in the spring of 1901. Since then, the paradox has prompted a great deal of work in logic, set theory and the philosophy and foundations of mathematics.

    1. The Paradox
    2. History of the Paradox
    3. Early Responses to the Paradox
    4. Russell's Paradox in Contemporary Logic
    Bibliography
    Academic Tools
    Other Internet Resources
    Related Entries

1. The Paradox

Central to any theory of sets is a statement of the conditions under which sets are formed. In addition to simply listing the members of a set, it was initially assumed that any well-defined condition (or precisely specified property) could be used to determine a set. For example, if T is the property of being a teacup, then the set, S, of all teacups might be defined as S = {x: T(x)}, the set of all individuals, x, such that x has the property of being T. Even a contradictory property might be used to determine a set. For example, the property of being both T and not-T would determine the empty set, the set having no members.

More precisely, naïve set theory assumes the so-called naïve or unrestricted Comprehension Axiom, the axiom that for any formula φ(x) containing x as a free variable, there will exist the set {x: φ(x)} whose members are exactly those objects that satisfy φ(x). Thus, if the formula φ(x) stands for “x is prime”, then {x: φ(x)} will be the set of prime numbers. If φ(x) stands for “~(x = x)”, then {x: φ(x)} will be the empty set.

But from the assumption of this axiom, Russell's contradiction follows. For example, if we let φ(x) stand for x ∈ x and let R = {x: ~φ(x)}, then R is the set whose members are exactly those objects that are not members of themselves.

Is R a member of itself? If it is, then it must satisfy the condition of not being a member of itself and so it is not. If it is not, then it must not satisfy the condition of not being a member of itself, and so it must be a member of itself. Since by classical logic one case or the other must hold – either R is a member of itself or it is not – it follows that the theory implies a contradiction.

As Russell tells us, it was after he applied the same kind of reasoning found in Cantor's diagonal argument to a “supposed class of all imaginable objects” that he was led to the contradiction:

    The comprehensive class we are considering, which is to embrace everything, must embrace itself as one of its members. In other words, if there is such a thing as “everything,” then, “everything” is something, and is a member of the class “everything.” But normally a class is not a member of itself. Mankind, for example, is not a man. Form now the assemblage of all classes which are not members of themselves. This is a class: is it a member of itself or not? If it is, it is one of those classes that are not members of themselves, i.e., it is not a member of itself. If it is not, it is not one of those classes that are not members of themselves, i.e. it is a member of itself. Thus of the two hypotheses – that it is, and that it is not, a member of itself – each implies its contradictory. This is a contradiction. (1919, 136) 

Standard responses to the paradox attempt to limit in some way the conditions under which sets are formed. The goal is usually both to eliminate R (and similar contradictory sets) and, at the same time, to retain all other sets needed for mathematics. This is often done by replacing the unrestricted Comprehension Axiom with the more restrictive Separation Axiom, namely the axiom that given any (consistent) set S and any formula φ(x) with x free, there will be a set {x ∈ S: φ(x)} whose members are exactly those members of S that satisfy φ(x). If we now let φ(x) stand for the formula x ∉ x, it turns out that the corresponding set, {x ∈ S: x ∉ x} will not be contradictory since it consists only of those members found within S that are not members of themselves. Hence the set fails to include itself.

A variety of related paradoxes is discussed in the second chapter of the Introduction to Whitehead and Russell (1910, 2nd edn 60-65), as well as in the entry on paradoxes and contemporary logic in this encyclopedia.
2. History of the Paradox

Russell appears to have discovered his paradox in the late spring of 1901, while working on his Principles of Mathematics (1903). Exactly when the discovery took place is not clear. Russell initially states that he came across the paradox “in June 1901” (1944, 13). Later he reports that the discovery took place “in the spring of 1901” (1959, 75). Still later he reports that he came across the paradox, not in June, but in May of that year (1969, 221). Cesare Burali-Forti, an assistant to Giuseppe Peano, had discovered a similar antinomy in 1897 when he noticed that since the set of ordinals is well-ordered, it too must have an ordinal. However, this ordinal must be both an element of the set of all ordinals and yet greater than every such element.

Unlike Burali-Forti's paradox, Russell's paradox does not involve either ordinals or cardinals, relying instead only on the primitive notions of set and set inclusion. Zermelo noticed a similar contradiction sometime between 1897 and 1902, possibly anticipating Russell by some years (Ebbinghaus and Peckhaus 2007, 43–48; Tappenden 2013, 336), although Kanamori concludes that the discovery could easily have been as late as 1902 (Kanamori 2009, 411). In any case, the paradox was thought to be of minor importance until it was realized how detrimental it was to Gottlob Frege's theory of the foundations of mathematics.

Russell wrote to Frege with news of his paradox on June 16, 1902. (For the relevant correspondence, see Russell (1902) and Frege (1902) in van Heijenoort (1967).) The paradox was of significance to Frege's logical work since, in effect, it showed that the axioms Frege was using to formalize his logic were inconsistent. Specifically, Frege's Axiom V requires that an expression such as φ(x) be considered both a function of the argument x and a function of the argument φ. (More precisely, Frege's Law states that the course-of-values of a concept f is identical to the course-of-values of a concept g if and only if f and g agree on the value of every argument, i.e., if and only if for every object x, f(x) = g(x). See section 2.4.1 of the entry on Gottlob Frege in this encyclopedia for more discussion.) In effect, it was this ambiguity that allowed Russell to construct R in such a way that it could both be and not be a member of itself.

Russell's letter arrived just as the second volume of Frege's Grundgesetze der Arithmetik (The Basic Laws of Arithmetic, 1893, 1903) was in press. Immediately appreciating the difficulty the paradox posed, Frege added to the Grundgesetze a hastily composed appendix discussing Russell's discovery. In the appendix Frege observes that the consequences of Russell's paradox are not immediately clear. For example, “Is it always permissible to speak of the extension of a concept, of a class? And if not, how do we recognize the exceptional cases? Can we always infer from the extension of one concept's coinciding with that of a second, that every object which falls under the first concept also falls under the second? These are the questions,” Frege notes, “raised by Mr Russell's communication” (1903, 127). Because of these worries, Frege eventually felt forced to abandon many of his views about logic and mathematics.

Even so, as Russell points out, Frege met the news of the paradox with remarkable fortitude:

    As I think about acts of integrity and grace, I realise that there is nothing in my knowledge to compare with Frege's dedication to truth. His entire life's work was on the verge of completion, much of his work had been ignored to the benefit of men infinitely less capable, his second volume was about to be published, and upon finding that his fundamental assumption was in error, he responded with intellectual pleasure clearly submerging any feelings of personal disappointment. It was almost superhuman and a telling indication of that of which men are capable if their dedication is to creative work and knowledge instead of cruder efforts to dominate and be known. (Quoted in van Heijenoort (1967), 127) 

Of course, Russell too was concerned about the consequences of the contradiction. Upon learning that Frege agreed with him about the significance of the result, he immediately began writing an appendix for his own soon-to-be-released Principles of Mathematics. Entitled “Appendix B: The Doctrine of Types,” the appendix represents Russell's first attempt at providing a principled method for avoiding what soon was to become known as “Russell's paradox.”
3. Early Responses to the Paradox

The significance of Russell's paradox can be seen once it is realized that, using classical logic, all sentences follow from a contradiction. For example, assuming both P and ~P, any arbitrary proposition, Q, can be proved as follows: from P we obtain P ∨ Q by the rule of Addition; then from P ∨ Q and ~P we obtain Q by the rule of Disjunctive Syllogism. Because set theory underlies all branches of mathematics, many people began to worry that the inconsistency of set theory would mean that no mathematical proof could be completely trustworthy. Only by eliminating Russell's paradox could mathematics as a whole regain its consistency.

Russell's paradox ultimately stems from the idea that any condition or property may be used to determine a set. For example, the property of being evenly divisible by only itself and the number one distinguishes the set of prime numbers from the set of whole numbers. A conjunction of properties such as being a vertebrate, being warm-blooded, having live births, hair or fur, an external ear, lungs and a diaphragm, etc., distinguishes the set of mammals from other living organisms. The property of being both square and not square (or any other conjunction of contradictory properties) determines the empty set, and so on.

One early skeptic concerning an unrestricted Comprehension (or Abstraction) axiom was the originator of modern set theory, Georg Cantor. Even prior to Russell's discovery, Cantor had rejected unrestricted Comprehension in favour of what was, in effect, a distinction between sets and classes, recognizing that some properties (such as the property of being an ordinal) produced collections that were simply too large to be sets, and that any assumption to the contrary would lead to inconsistency. (Details can be found in Moore (1982), Hallett (1984) and Menzel (1984).)

Russell's own response to the paradox came with his aptly named theory of types. Believing that self-application lay at the heart of the paradox, Russell's basic idea was that we can avoid commitment to R (the set of all sets that are not members of themselves) by arranging all sentences (or, more precisely, all propositional functions, functions which give propositions as their values) into a hierarchy. It is then possible to refer to all objects for which a given condition (or predicate) holds only if they are all at the same level or of the same “type.”

This solution to Russell's paradox is motivated in large part by adoption of the so-called vicious circle principle. The principle in effect states that no propositional function can be defined prior to specifying the function's scope of application. In other words, before a function can be defined, one must first specify exactly those objects to which the function will apply (the function's domain). For example, before defining the predicate “is a prime number,” one first needs to define the collection of objects that might possibly satisfy this predicate, namely the set, N, of natural numbers.

As Whitehead and Russell explain,

    An analysis of the paradoxes to be avoided shows that they all result from a kind of vicious circle. The vicious circles in question arise from supposing that a collection of objects may contain members which can only be defined by means of the collection as a whole. Thus, for example, the collection of propositions will be supposed to contain a proposition stating that “all propositions are either true or false.” It would seem, however, that such a statement could not be legitimate unless “all propositions” referred to some already definite collection, which it cannot do if new propositions are created by statements about “all propositions.” We shall, therefore, have to say that statements about “all propositions” are meaningless. … The principle which enables us to avoid illegitimate totalities may be stated as follows: “Whatever involves all of a collection must not be one of the collection”; or, conversely: “If, provided a certain collection had a total, it would have members only definable in terms of that total, then the said collection has no total.” We shall call this the “vicious-circle principle,” because it enables us to avoid the vicious circles involved in the assumption of illegitimate totalities. (1910, 2nd edn 37)

If Whitehead and Russell are right, it follows that no function's scope of application will ever be able to include any object presupposed by the function itself. As a result, propositional functions (along with their corresponding propositions) will end up being arranged in a hierarchy of the kind Russell proposes.

Although Russell first introduced his theory of types in his 1903 Principles of Mathematics, he recognized immediately that more work needed to be done since his initial account seemed to resolve some but not all of the paradoxes. Among the alternatives he considered was a so-called substitutional theory (Galaugher 2013). This in turn led to type theory's more mature expression five years later in Russell's 1908 article, “Mathematical Logic as Based on the Theory of Types,” and in the monumental work he co-authored with Alfred North Whitehead, Principia Mathematica (1910, 1912, 1913). Russell's type theory thus appears in two versions: the “simple theory” of 1903 and the “ramified theory” of 1908. Both versions have been criticized for being too ad hoc to eliminate the paradox successfully.

In response to Russell's paradox, David Hilbert also expanded his program of building a consistent, axiomatic foundation for mathematics so that it included an axiomatic foundation for logic and set theory (Peckhaus 2004). The formalists, on the other hand, developed the idea of allowing the use of only finite, well-defined and constructible objects, together with rules of inference deemed to be absolutely certain. Finally, Luitzen Brouwer developed intuitionism, whose basic idea was that one cannot assert the existence of a mathematical object unless one can define a procedure for constructing it.

Together, all of these responses helped focus attention on the connections between logic, language and mathematics. They also helped logicians develop an explicit awareness of the nature of formal systems and of the kinds of metalogical and metamathematical results that have proved to be central to research in the foundations of logic and mathematics over the past one hundred years.
4. Russell's Paradox in Contemporary Logic

Russell's paradox is sometimes seen as a negative development – as bringing down Frege's Grundgesetze and as one of the original conceptual sins leading to our expulsion from Cantor's paradise. W.V. Quine describes the paradox as an “antinomy” that “packs a surprise that can be accommodated by nothing less than a repudiation of our conceptual heritage” (1966, 11). Quine is referring to the Naïve Comprehension principle mentioned earlier. In symbols, the principle states that

    (NC) ∃A ∀x (x ∈ A ≡ φ), 

where A is not free in the formula φ.This says, “There is a set A such that for any object x, x is an element of A if and only if the condition expressed by φ holds.” Russell's paradox arises by taking φ to be the formula: x ∉ x.

Despite Quine's comment, it is possible to see Russell's paradox in a more positive light. For one thing, although the matter remains controversial, later research has revealed that the paradox does not necessarily short circuit Frege's derivation of arithmetic from logic alone. Frege's version of NC (his Axiom V) can simply be abandoned. (For details, see the entry on Frege's Theorem.) For another, Church gives an elegant formulation of the simple theory of types that has proven fruitful even in areas removed from the foundations of mathematics. (For details, see the entry on Type Theory.) Finally, the development of axiomatic (as opposed to naïve) set theories which exhibit various ingenious and mathematically and philosophically significant ways of dealing with Russell's paradox paved the way for stunning results in the metamathematics of set theory. These results have included Gödel's and Cohen's theorems on the independence of the axiom of choice and Cantor's continuum hypothesis. So let us see, roughly, how some of these methods – specifically, the so-called “untyped” methods – deal with Russell's paradox.

Zermelo replaces NC with the following axiom schema of Separation (or Aussonderungsaxiom):

    (ZA) ∀A ∃B ∀x (x ∈ B ≡ (x ∈ A ∧ φ)). 

Again, to avoid circularity, B cannot be free in φ. This demands that in order to gain entry into B, x must be a member of an existing set A. As one might imagine, this requires a host of additional set-existence axioms, none of which would be required if NC had held up.

How does ZA avoid Russell's paradox? One might think at first that it doesn't. After all, if we let A be V – the whole universe of sets – and φ be x ∉ x, a contradiction again appears to arise. But in this case, all the contradiction shows is that V is not a set. All the contradiction shows is that “V” is an empty name (i.e., that it has no reference, that V does not exist), since the ontology of Zermelo's system consists solely of sets.

This same point can be made in yet another way, involving a relativized form of Russell's argument. Let B be any set. By ZA, the set RB = {x ∈ B: x ∉ x} exists, but it cannot be an element of B. For if it is an element of B, then we can ask whether or not it is an element of RB; and it is if and only if it is not. Thus something, namely RB, is “missing” from each set B. So again, V is not a set, since nothing can be missing from V. But notice the following subtlety: unlike the previous argument involving the direct application of Aussonderungs to V, the present argument hints at the idea that, while V is not a set, “V” is not an empty name. The next strategy for dealing with Russell's paradox capitalizes on this hint.

John von Neumann's (1925) untyped method for dealing with paradoxes, and with Russell's paradox in particular, is simple and ingenious. Von Neumann introduces a distinction between membership and non-membership and, on this basis, draws a distinction between sets and classes. An object is a member (simpliciter) if it is a member of some class; and it is a non-member if it is not a member of any class. (Actually, von Neumann develops a theory of functions, taken as primitive, rather than classes, wherein corresponding to the member/non-member distinction one has a distinction between an object that can be an argument of some function and one that cannot. In its modern form, due to Bernays and Gödel, it is a single-sorted theory of classes.)

Sets are then defined as members, and non-members are labeled “proper classes.” So for example, the Russell class, R, cannot be a member of any class, and hence it must be a proper class. If R is assumed to be an element of a class A, then it follows from one of von Neumann's axioms that R is not equivalent to V. But R is equivalent to V, and hence not an element of A. Thus, von Neumann's method is closely related to the result stated above about the set RB, for arbitrary B. Von Neumann's method, while admired by the likes of Gödel and Bernays, has been undervalued in recent years.

Quine (1937) and (1967) similarly provide another untyped method (in letter if not in spirit) of blocking Russell's paradox, and one that is rife with interesting anomalies. Quine's basic idea is to introduce a stratified comprehension axiom. In effect, the axiom blocks circularity by introducing a hierarchy (or stratification) that is similar to type theory in some ways, and dissimilar in others. (Details can be found in the entry on Quine's New Foundations.)

In contrast to Zermelo's, von Neumann's and Quine's strategies, which are in a sense purely set theoretic, there have also been attempts to avoid Russell's paradox by altering the underlying logic. There have been many such attempts and we shall not review them all, but one stands out as being, at the moment, both radical and somewhat popular (although not with set theorists per se): this is the paraconsistent approach, which limits the overall effect of an isolated contradiction on an entire theory. Classical logic mandates that any contradiction trivializes a theory by making every sentence of the theory provable. This is because, in classical logic, the following is a theorem:

    (Ex Falso Quadlibet) A ⊃ (~A ⊃ B). 

Now, virtually the only way to avoid EFQ is to give up disjunctive syllogism, that is, given the usual definitions of the connectives, modus ponens! So altering basic sentential logic in this way is radical indeed – but possible. Unfortunately, even giving up EFQ is not enough to retain a semblance of NC. One also has to give up the following additional theorem of basic sentential logic:

    (Contraction) (A ⊃ (A ⊃ B)) ⊃ (A ⊃ B). 

It can then be argued that NC leads directly, not merely to an isolated contradiction, but to triviality. (For the argument that this is so, see the entry on Curry's paradox, section 2.2. Note too that it is not enough merely to retain the name “modus ponens”; it is the rule itself that becomes modified within non-traditional logics.) Thus it seems that the woes of NC are not confined to Russell's paradox but also include a negation-free paradox due to Curry.

Another suggestion might be to conclude that the paradox depends upon an instance of the principle of Excluded Middle, that either R is a member of R or it is not. This is a principle that is rejected by some non-classical approaches to logic, including intuitionism. However it is possible to formulate the paradox without appealing to Excluded Middle by relying instead upon the Law of Non-contradiction. We do so as follows: Given the definition of R it follows that R ∈ R ≡ ~(R ∈ R). So R ∈ R ⊃ ~(R ∈ R). But we also know that R ∈ R ⊃ R ∈ R. So R ∈ R ⊃ (R ∈ R ∧ ~(R ∈ R)). But by the Law of Non-contradiction we know that ~(R ∈ R ∧ ~(R ∈ R)). So by modus tollens we conclude that ~(R ∈ R). At the same time we also know that since R ∈ R ≡ ~(R ∈ R), it follows that ~(R ∈ R) ⊃ R ∈ R, and thus that R ∈ R. So we can deduce both R ∈ R and its negation using only intutionistically acceptable methods.

It seems, therefore, that proponents of non-classical logics cannot claim to have preserved NC in any significant sense, other than preserving the purely syntactical form of the principle, and neither intuitionism nor paraconsistency plus the abandonment of Contraction will offer an advantage over the untyped solutions of Zermelo, von Neumann, or Quine. (Further discussion can be found in Meyer, Routley and Dunn (1979), Irvine (1992), Priest (2006, ch. 18), Weber (2010), Weber (2012), and in the entries on Curry's paradox (sec. 2.2) and paraconsistent logic (sec. 2.3).)

It is also worth noting that Russell's paradox was not the only paradox that troubled Russell and, hence, not the only motivation for the type restrictions one finds in Principia Mathematica. In his earlier work, The Principles of Mathematics, Russell devotes a chapter to “the Contradiction” (Russell's paradox), presenting it in several forms and dismissing several non-starter responses. He then signals that he will “shortly” discuss the doctrine of types. This doesn't happen for several hundred pages, until we reach the very end of the book, in Appendix B! There Russell presents an incipient, simple theory of types, not the theory of types we find in Principia Mathematica. Why was the later theory needed? The reason is that in Appendix B Russell also presents another paradox which he thinks cannot be resolved by means of the simple theory of types. This new paradox concerns propositions, not classes, and it, together with the semantic paradoxes, led Russell to formulate his ramified version of the theory of types.

The new, propositional version of the paradox has not figured prominently in the subsequent development of logic and set theory, but it sorely puzzled Russell. For one thing, it seems to contradict Cantor's theorem. Russell writes: “We cannot admit that there are more ranges [classes of propositions] than propositions” (1903, 527). The reason is that there seem to be easy, one to one correlations between classes of propositions and propositions. For example, the class m of propositions can be correlated with the proposition that every proposition in m is true. This, together with a fine-grained principle of individuation for propositions (asserting, for one thing, that if the classes m and n of propositions differ, then any proposition about m will differ from any proposition about n) leads to contradiction.

There has been relatively little discussion of this paradox, although it played a key role in the development of Church's logic of sense and denotation. While we have several set theories to choose from, we do not have anything like a well-developed theory of Russellian propositions, although such propositions are central to the views of Millians and direct-reference theorists. One would think that such a theory would be required for the foundations of semantics, if not for the foundations of mathematics. Thus, while one of Russell's paradoxes has led to the fruitful development of the foundations of mathematics, his “other” paradox has yet to lead to anything remotely similar in the foundations of semantics. To be sure, Church (1974a) and Anderson (1989) have attempted to develop a Russellian intensional logic based on the ramified theory of types, but an argument can be made that the ramified theory is too restrictive to serve as a foundation for the semantics of natural language. There have also been some recent attempts to obtain the beginnings of a Russellian intensional logic based on untyped set theories (Cantini 2004; Deutsch 2014). It is rather ironic that although fine-grained Russellian propositions are favored in the philosophy of language, the formal development of intensional logic is dominated by Montague grammar, with its course-grained theory of propositions.

It is also worth noting that a number of seemingly purely set-theoretical principles are actually (applied) instances of theorems of pure logic (i.e., of first-order quantification theory with identity)! There is a (partial) list of these in Kalish, Montague, and Mar (2000). Russell's paradox is an instance of T269 in this list:

    (T269) ~∃y ∀x (Fxy ≡ ~Fxx). 

Reading the dyadic predicate letter “F” as “is a member of”, this says that it is not the case that there is a y such that for any x, x is a member of y if and only if x is not a member of x. Does this mean that Russell's paradox reduces to T269?

Certainly the proof of T269 distills the essence of Russell's argument, its pattern of reasoning. But that pattern also underwrites an endless list of seemingly frivolous “paradoxes” such as the famous paradox of the Barber who shaves all and only those barbers who do not shave themselves or, similarly, the paradox of the benevolent but efficient God who helps all and only those who do not help themselves.

How do these “pseudo paradoxes,” as they are sometimes called, differ, if at all, from Russell's paradox? The pattern of reasoning is the same and the conclusion – that there is no such Barber, no such efficient God, no such set of non-self-membered sets – is the same: such things simply don't exist. (However, as von Neumann showed, it is not necessary to go quite this far. Von Neumann's method instructs us not that such things as R do not exist, but just that we cannot say much about them, inasmuch as R and the like cannot fall into the extension of any predicate that qualifies as a class.)

The standard answer to this question is that the difference lies in the subject matter. Quine asks, “why does it [Russell's paradox] count as an antinomy and the barber paradox not?”; and he answers, “The reason is that there has been in our habits of thought an overwhelming presumption of there being such a class but no presumption of there being such a barber” (1966, 14). Even so, psychological talk of “habits of thought” is not particularly illuminating. More to the point, Russell's paradox sensibly gives rise to the question of what sets there are; but it is nonsense to wonder, on such grounds as T269, what barbers or Gods there are!

This verdict, however, is not quite fair to fans of the Barber or of T269 generally. They will insist that the question raised by T269 is not what barbers or Gods there are, but rather what non-paradoxical objects there are. This question is virtually the same as that raised by Russell's paradox itself. Thus, from this perspective, the relation between the Barber and Russell's paradox is much closer than many (following Quine) have been willing to allow (Salmon 2013).

We note that there is a first-order logical formula that bears the same relation to the principle about the RB's that T269 bears to Russell's paradox. It is the following:

    (T273) ∀z ∀y (∀x [Fxy ≡ (Fxz ∧ ~Fxx)] ⊃ ~Fyz). 

(We have taken the liberty of extending the numbering used in Kalish, Montague and Mar (2000) to T273.) But not all set-theoretic paradoxes are similarly related to first-order logical theorems. The Burali-Forti paradox is an example, since the notion of a well-ordering is not elementary; that is, it is not first-order definable.

Russell's paradox has never been passé, but recently there has been an explosion of interest in it by scholars involved in research in mathematical logic and in philosophical and historical studies of modern logic. A glance at the contents of the 2004 volume One Hundred Years of Russell's Paradox shows prominent mathematical and philosophical logicians and historians of logic pouring over the paradox, proposing new ways back into Cantor's paradise, or other ways of resolving the issue. Their investigations include radically new ways out of the dilemma posed by the paradox, new studies of the theories of types (simple and ramified, and extensions thereof), new interpretations of Russell's paradox and constructive theories, of Russell's paradox of propositions and of his own attempt at an untyped theory (the substitution theory), and so forth.

All of this reminds us that fruitful work can arise from the most unlikely of observations. As Dana Scott has put it, “It is to be understood from the start that Russell's paradox is not to be regarded as a disaster. It and the related paradoxes show that the naïve notion of all-inclusive collections is untenable. That is an interesting result, no doubt about it” (1974, 207).
Bibliography

    Anderson, C. Anthony, 1989. “Russellian Intensional Logic,” in Joseph Almog, John Perry and Howard Wettstein (eds), Themes from Kaplan, Oxford: Oxford University Press, 67–103.
    Barwise, Jon, 1975. Admissible Sets and Structures, Berlin: Springer-Verlag.
    ––– and John Etchemendy, 1987. The Liar: An Essay on Truth and Circularity, Oxford: Oxford University Press.
    ––– and Lawrence Moss, 1996. Vicious Circles, Stanford: CSLI Publications.
    Bealer, George, 1982. Quality and Concept, New York: Oxford University Press.
    Beaney, Michael, 2003. “Russell and Frege,” in Nicholas Griffin (ed.), The Cambridge Companion to Bertrand Russell, Cambridge: Cambridge University Press, 128–170.
    Cantini, Andrea, 2004. “On a Russellian Paradox about Propositions and Truth,” in Godehard Link (ed.) (2004) One Hundred Years of Russell's Paradox, Berlin and New York: Walter de Gruyter, 259–284.
    –––, 2009. “Paradoxes, Self-Reference and Truth in the 20th Century,” in Dov M. Gabbay and John Woods (eds) (2009) Handbook of the History of Logic: Volume 5 – Logic From Russell to Church, Amsterdam: Elsevier/North Holland, 875–1013.
    Church, Alonzo, 1974a. “Russellian Simple Type Theory,” Proceedings and Addresses of the American Philosophical Association, 47: 21–33.
    –––, 1974b. “Set Theory with a Universal Set,” Proceedings of the Tarski Symposium, 297–308; repr. in International Logic Review, 15: 11–23.
    –––, 1978. “A Comparison of Russell's Resolution of the Semantical Antinomies with that of Tarski,” Journal of Symbolic Logic, 41: 747–760; repr. in A.D. Irvine, Bertrand Russell: Critical Assessments, vol. 2, New York and London: Routledge, 1999, 96–112.
    Coffa, Alberto, 1979. “The Humble Origins of Russell's Paradox,” Russell, 33–34: 31–7.
    Copi, Irving, 1971. The Theory of Logical Types, London: Routledge and Kegan Paul.
    Demopoulos, William, and Peter Clark, 2005. “The Logicism of Frege, Dedekind and Russell,” in Stewart Shapiro (ed.), The Oxford Handbook of Philosophy of Mathematics and Logic, Oxford: Oxford University Press, 129–165.
    Deutsch, Harry, 2014. “Resolution of Some Paradoxes of Propositions,” Analysis, 74: 26-34.
    Ebbinghaus, Heinz-Dieter, and Volker Peckhaus, 2007. Ernst Zermelo: An Approach to His Life and Work, Berlin: Springer-Verlag.
    Forster, T.E., 1995. Set Theory with a Universal Set, 2nd edn, Oxford: Clarendon Press.
    Frege, Gottlob, 1902. “Letter to Russell,” in Jean van Heijenoort (ed.), From Frege to Gödel, Cambridge, Mass.: Harvard University Press, 1967, 126–128.
    –––, 1903. “The Russell Paradox,” in Gottlob Frege, The Basic Laws of Arithmetic, Berkeley: University of California Press, 1964, 127–143; abridged and repr. in A.D. Irvine, Bertrand Russell: Critical Assessments, vol. 2, New York and London: Routledge, 1999, 1–3.
    Gabbay, Dov M., and John Woods (eds.), 2009. Handbook of the History of Logic: Volume 5 – Logic From Russell to Church, Amsterdam: Elsevier/North Holland.
    Galaugher, J.B., 2013. “Substitution's Unsolved ‘Insolubilia’,” Russell, 33: 5–30.
    Garciadiego, A., 1992. Bertrand Russell and the Origins of the Set-theoretic “Paradoxes”, Boston: Birkhäuser.
    Grattan-Guinness, I., 1978. “How Bertrand Russell Discovered His Paradox,” Historia Mathematica, 5: 127–37.
    –––, 2000. The Search for Mathematical Roots: 1870–1940, Princeton and Oxford: Princeton University Press.
    Griffin, Nicholas (ed.), 2003. The Cambridge Companion to Bertrand Russell, Cambridge: Cambridge University Press.
    –––, 2004. “The Prehistory of Russell's Paradox,” in Godehard Link (ed.), One Hundred Years of Russell's Paradox, Berlin and New York: Walter de Gruyter, 349–371.
    ––– Bernard Linsky and Kenneth Blackwell (eds.), 2011. Principia Mathematica at 100, Hamilton, ON: Bertrand Russell Research Centre; also published as Special Issue, Volume 31, Number 1 of Russell.
    Hallett, Michael, 1984. Cantorian Set Theory and Limitation of Size, Oxford: Clarendon.
    Halmos, Paul R., 1960. Naive Set Theory, Princeton: D. van Nostrand.
    Irvine, A.D., 1992. “Gaps, Gluts and Paradox,” Canadian Journal of Philosophy (Supplementary Volume), 18: 273–299.
    ––– (ed.), 2009. Philosophy of Mathematics, Amsterdam: Elsevier/North Holland.
    Kanamori, Akihiro, 2004. “Zermelo and Set Theory,” The Bulletin of Symbolic Logic, 10: 487–553.
    –––, 2009. “Set Theory from Cantor to Cohen,” in A.D. Irvine (ed.), Philosophy of Mathematics, Amsterdam: Elsevier/North Holland, 395–459.
    Kalish, Donald, Richard Montague and Gary Mar, 2000. Logic: Techniques of Formal Reasoning, 2nd edn, New York: Oxford University Press.
    Klement, Kevin, 2005. “The Origins of the Propositional Functions Version of Russell's Paradox,” Russell, 24: 101–132.
    Landini, Gregory, 2006. “The Ins and Outs of Frege's Way Out,” Philosophia Mathematica, 14: 1–25.
    Levy, A., 1979. Basic Set Theory, Berlin: Springer-Verlag; New York: Heidelberg.
    Link, Godehard (ed.), 2004. One Hundred Years of Russell's Paradox, Berlin and New York: Walter de Gruyter.
    Linsky, Bernard, 1990. “Was the Axiom of Reducibility a Principle of Logic?” Russell, 10: 125–140; repr. in A.D. Irvine (ed.) (1999) Bertrand Russell: Critical Assessments, 4 vols, London: Routledge, vol. 2, 150–264.
    –––, 2002. “The Resolution of Russell's Paradox in Principia Mathematica,” Philosophical Perspectives, 16: 395–417.
    Mares, Edwin, 2007. “The Fact Semantics for Ramified Type Theory and the Axiom of Reducibility,” Notre Dame Journal of Formal Logic, 48: 237–251.
    Menzel, Christopher, 1984. “Cantor and the Burali-Forti Paradox,” Monist, 67: 92–107.
    Meyer, Robert K., Richard Routley and Michael Dunn, 1979. “Curry's Paradox,” Analysis, 39: 124–128.
    Moore, Gregory H., 1982. Zermelo's Axiom of Choice, New York: Springer.
    –––, 1988. “The Roots of Russell's Paradox,” Russell, 8: 46–56.
    Murawski, Roman, 2011. “On Chwistek's Philosophy of Mathematics,” in Nicholas Griffin, Bernard Linsky and Kenneth Blackwell (eds) (2011) Principia Mathematica at 100, in Russell (Special Issue), 31(1): 121–130.
    Peckhaus, Volker, 2004. “Paradoxes in Göttingen,” in Godehard Link (ed.), One Hundred Years of Russell's Paradox, Berlin and New York: Walter de Gruyter, 501–515.
    Priest, Graham, 2006. In Contradiction, 2nd edn, New York: Oxford University Press.
    Quine, W.V.O., 1937. “New Foundations for Mathematical Logic,” American Mathematical Monthly, 44: 70–80; repr. in W.V.O. Quine, From a Logical Point of View, London: Harper & Row, 1953.
    –––, 1966. The Ways of Paradox and Other Essays, New York: Random House.
    –––, 1967. Set Theory and Its Logic, Harvard: Belknap Press.
    Russell, Bertrand, 1902. “Letter to Frege,” in Jean van Heijenoort (ed.), From Frege to Gödel, Cambridge, Mass.: Harvard University Press, 1967, 124–125.
    –––, 1903. “Appendix B: The Doctrine of Types,” in Bertrand Russell, The Principles of Mathematics, Cambridge: Cambridge University Press, 1903, 523–528.
    –––, 1908. “Mathematical Logic as Based on the Theory of Types,” American Journal of Mathematics, 30: 222–262; repr. in Bertrand Russell, Logic and Knowledge, London: Allen and Unwin, 1956, 59–102; and repr. in Jean van Heijenoort (ed.), From Frege to Gödel, Cambridge, Mass.: Harvard University Press, 1967, 152–182.
    –––, 1919. Introduction to Mathematical Philosophy, London: George Allen and Unwin Ltd, and New York: The Macmillan Co.
    –––, 1944. “My Mental Development,” in Paul Arthur Schilpp (ed.), The Philosophy of Bertrand Russell, 3rd edn, New York: Tudor, 1951, 3–20.
    –––, 1959. My Philosophical Development, London: George Allen and Unwin, and New York: Simon & Schuster.
    –––, 1967, 1968, 1969. The Autobiography of Bertrand Russell, 3 vols, London: George Allen and Unwin; Boston: Little Brown and Company (Volumes 1 and 2), New York: Simon and Schuster (Vol. 3).
    Salmon, N., 2013. “A Note on Kripke's Paradox about Time and Thought,” Journal of Philosophy, 110: 213-220.
    Scott, Dana, 1974. “Axiomatizing Set Theory,” in T.J. Jech (ed.), Proceedings of Symposia in Pure Mathematics (Volume 13, part 2), American Mathematical Society, 207-214.
    Shapiro, Stewart (ed.), 2005. The Oxford Handbook of Philosophy of Mathematics and Logic, Oxford: Oxford University Press.
    Simmons, Keith, 2000. “Sets, Classes and Extensions: A Singularity Approach to Russell's Paradox,” Philosophical Studies, 100: 109–149.
    –––, 2005. “A Berry and a Russell without Self-Reference,” Philosophical Studies, 126: 253–261.
    Sorensen, Roy A., 2002. “Philosophical Implications of Logical Paradoxes,” in Dale Jacquette (ed.), A Companion to Philosophical Logic, New York: Oxford University Press, 131–142.
    –––, 2003. “Russell's Set,” in A Brief History of the Paradox, New York: Oxford University Press, 316–332.
    Stevens, Graham, 2004. “From Russell's Paradox to the Theory of Judgement: Wittgenstein and Russell on the Unity of the Proposition,” Theoria, 70: 28–61.
    –––, 2005. The Russellian Origins of Analytical Philosophy, London and New York: Routlege.
    Tappenden, Jamie, 2013. “The Mathematical and Logical Background to Analytic Philosophy,” in Michael Beaney (ed.) The Oxford Handbook of the History of Analytic Philosophy, Oxford: Oxford University Press, 318–354.
    Urquhart, Alasdair, 1988. “Russell's Zig-Zag Path to the Ramified Theory of Types,” Russell, 8: 82–91.
    –––, 2003. “The Theory of Types,” in Nicholas Griffin (ed.), The Cambridge Companion to Bertrand Russell, Cambridge: Cambridge University Press, 286–309.
    van Heijenoort, Jean (ed.), 1967. From Frege to Gödel: A Source Book in Mathematical Logic, 1879-1931, Cambridge and London: Harvard University Press.
    von Neumann, John, 1925. “An Axiomatization of Set Theory,“ in Jean van Heijenoort (ed.), From Frege to Gödel, Cambridge and London: Harvard University Press, 1967, 393–413.
    Wahl, Russell, 2011. “The Axiom of Reducibility,” in Nicholas Griffin, Bernard Linsky and Kenneth Blackwell (eds) (2011) Principia Mathematica at 100, in Russell (Special Issue), 31(1): 45–62.
    Weber, Z., 2010. “Transfinite Numbers in Paraconsistent Set Theory,” Review of Symbolic Logic, 3: 71–92.
    –––, 2012. “Transfinite Cardinals in Paraconsistent Set Theory,” Review of Symbolic Logic, 5: 269–293.
    Whitehead, Alfred North, and Bertrand Russell, 1910, 1912, 1913. Principia Mathematica, 3 vols, Cambridge: Cambridge University Press; second edn, 1925 (Vol. 1), 1927 (Vols 2, 3); abridged as Principia Mathematica to *56, Cambridge: Cambridge University Press, 1962.

Academic Tools

    sep man icon 	How to cite this entry.
    sep man icon 	Preview the PDF version of this entry at the Friends of the SEP Society.
    inpho icon 	Look up this entry topic at the Indiana Philosophy Ontology Project (InPhO).
    phil papers icon 	Enhanced bibliography for this entry at PhilPapers, with links to its database.

Other Internet Resources

    Bertrand Russell Archives
    Bertrand Russell Research Centre
    Bertrand Russell Society
    Principia Mathematica: Volume 1 (University of Michigan Historical Math Collection)
    Principia Mathematica: Volume 2 (University of Michigan Historical Math Collection)
    Principia Mathematica: Volume 3 (University of Michigan Historical Math Collection)
    Russell: The Journal of Bertrand Russell Studies
    Russell's Antinomy (Wolfram MathWorld)
    Russell's Paradox

Related Entries

Cantor, Georg | Frege, Gottlob | Frege, Gottlob: theorem and foundations for arithmetic | logic: paraconsistent | mathematics: inconsistent | Peano, Giuseppe | Principia Mathematica | Quine, Willard van Orman: New Foundations | Russell, Bertrand | self-reference | type theory | Whitehead, Alfred North
Acknowledgments

Thanks are due to Ken Blackwell, Fred Kroon, Paolo Mancosu, Chris Menzel, Jim Robinson, Fred Spiessens, Richard Zach and several anonymous referees for their helpful comments on earlier versions of this material.
