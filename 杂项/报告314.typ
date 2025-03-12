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
    title: [数学的形式化与自动化],
    author: [郭子荀 2100012990\@stu.pku.edu.cn],
    date: datetime.today(),
    institution: [北京大学数学科学学院],

  ),
)
#set text(size: 22pt)
// #set heading(numbering: "1.")

#title-slide()
= 前言
  == 从数学到形式化数学
    大家都知道，数学的历史非常悠久。然而系统性的思考何为数学证明的历史并不悠久。人们常说欧几里得的几何公理体系奠定了数学思维的基础，但欧几里得的许多表述和推理以现在的眼光看是存在漏洞的。欧几里得公理可以表述为：
    + 从一点向另一点可以引一条直线
    + 任意线段可以延申成直线
    + 给定一点和一线段，可以将之作为点和半径画出一个圆
    + 所有直角都相等
    + 通过一个不在直线上的点，有且仅有一条不与该直线相交的直线。
  == 从数学到形式化数学
    仔细思考便会发现，上面的公理至少存在两个严重的漏洞：
    - 公理中完全不存在关于“左右”“上下”“内外”的等方位的描述，然而欧式几何的证明往往依赖于具体方位。
    - 欧氏几何大量利用了从圆内一点做直线应当一定与圆相交于两点这个事实，然而没有任何公理可以保证这一点。
    现代数学当然不容许严重的逻辑漏洞发生。一方面，我们要更加“谨慎”地进行数学推理。而另一方面，我们也可以为数学推理赋予唯一的、严格的形式语义，从而一劳永逸地解决准确性问题。
  == 数学自动化
    设计一种机械化的方式来判断一个数学命题是否正确当然是所有人梦寐以求的。当然，这样一种方法当然依赖于前面说过的对数学命题的形式化表达。然而还没等电子计算机的发明和成熟，哥德尔便在希尔伯特系统的基础上证明了著名的：
    #theoremLinear[Godel 不完全性定理][
      设 $cal(N)$ 是能编码初等算术的一阶形式系统，若 $cal(N)$ 是 $omega-$一致的，则存在一个公式 $cal(u)$ 使得 $cal(u)$ 和它的否定都不是 $cal(N)$ 中的定理
    ]
    换言之，存在一个命题使得我们无法证明真假，更不用说用自动化的方法判断一个命题的真假了。然而这并不意味着数学自动化的破产，毕竟我们总可以设计更好的方法来解决尽可能多的数学问题。
= 形式系统
  == 逻辑系统
    20 世纪初，希尔伯特大力推崇将数学形式化，包括：
    - 用形式语言定义数学对象和命题
    - 选定形式的公理和推理规则
    - 将数学证明转换成只由公理和推理规则构成的推导
    例如说“不存在两个互素的自然数 $m, n$ 使得 $m^2 = 2 n^2$” 就可以形式的写作一阶逻辑的公式：
    $
      not (exists m, n: gcd(m, n) = 1 and m^2 = 2 n^2)
    $
  == 演绎证明
    对于上面的公式，我们可以写出以下的形式证明：
    #let deduction(body) = {
      set enum(numbering: "(1)")
      set align(left)
      body
    }
    #let pp = $exists m, n: gcd(m, n) = 1 and m^2 = 2 n^2$
    #let pp1 = $gcd(m, n) = 1 and m^2 = 2 n^2$
    #deduction[
      往证：
      $
        tack  pp -> "false"
      $
      利用 $->$ 引入规则只需证明：
      $
        pp tack "false"
      $
      利用 $exists$ 引入规则只需证：
      $
        pp1 tack "false"
      $
      + $forall a: a | a * b$
      + $2 | 2 n^2 := forall$ 消去
      + $m^2 = 2 n^2 := and$ 消去
      + $2 | m^2 := $ 等词替换
      + $forall a, b: "is prime a" -> a | b^2 -> a | b$
      + $ "is prime 2" -> 2 | m^2 -> 2 | m$
      + is prime 2
      + $2 | m := $ MP
      + $forall a, b: a | b -> a^2 | b^2$
      + $2 | m -> 4 | m^2$
      + $4 | m^2 := $ MP
      + $4 | 2 n^2 :=$ 等词替换
      + $forall a, b, c: a b | a c -> b | c$
      + $2 * 2 | 2 n^2 -> 2 | n^2$
      + $2 | n^2$
      + $2 | n$
      + $forall a, b, c: a | b -> a | c -> a | gcd(b, c)$
      + $2 | gcd(m, n)$
      + $gcd(m, n) = 1$
      + $2 | 1$
      + false
    ]
    可以看出这实在有些繁琐到让人失去耐心，并且我们仍然需要自然语言作为*元语言*，让人并没有非常放心。
  == 演绎证明
  == 形式化证明器
    所幸计算机的出现可以帮助我们更好的完成上面的过程。可以通过设计一个计算机语言来精确地描述形式化证明的过程，这样可以让人安心很多。市面上的形式化证明器非常多，这里只是简单介绍几个：
  == HOL-Light
    HOL(Higher-Order Logic) 是指高阶逻辑，也就是其中的量词不仅能作用于项，还能作用于谓词（可以表述类似数学归纳法的命题），HOL-Light 是高阶逻辑证明器的一个简单的基于 OCaml 的实现。
    ```ml
    let NSQRT_2 = prove
      (‘!p q. p * p = 2 * q * q ==> q = 0‘,
      suffices_to_prove
      ‘!p. (!m. m < p ==> (!q. m * m = 2 * q * q ==> q = 0))
      ==> (!q. p * p = 2 * q * q ==> q = 0)‘
      (MATCH_ACCEPT_TAC num_WF) THEN
      fix [‘p:num‘] THEN
      assume("A") ‘!m. m < p ==> !q. m * m = 2 * q * q ==> q = 0‘ THEN
      fix [‘q:num‘] THEN
      assume("B") ‘p * p = 2 * q * q‘ THEN
      so have ‘EVEN(p * p) <=> EVEN(2 * q * q)‘ (trivial) THEN
      so have ‘EVEN(p)‘ (using [ARITH; EVEN_MULT] trivial) THEN
      so consider (‘m:num‘,"C",‘p = 2 * m‘) (using [EVEN_EXISTS] trivial) THEN
      cases ("D",‘q < p \/ p <= q‘) (arithmetic) THENL
      [so have ‘q * q = 2 * m * m ==> m = 0‘ (by ["A"] trivial) THEN
      so we’re finished (by ["B"; "C"] algebra);
      so have ‘p * p <= q * q‘ (using [LE_MULT2] trivial) THEN
      so have ‘q * q = 0‘ (by ["B"] arithmetic) THEN
      so we’re finished (algebra)]);;
    ```
    P.S. 这里展示的是 tactic mode，因此证明是纯反向的。事实上证明器内核是类似之前那样，基于项匹配和推理规则的正向推理。
  == Isabelle 
    Isabelle 是另一款非常成熟的证明器。它从设计上是“generic” 的，允许自定义不同的逻辑系统，但最常用的还是 Isabelle/HOL。Isabelle 的证明语言更接近 Standard ML。
    ```ml
    section ‹Square roots of primes are irrational›

    theory Sqrt
    imports Complex_Main "HOL-Computational_Algebra.Primes"
    begin

    text ‹The square root of any prime number (including 2) is irrational.›

    theorem sqrt_prime_irrational:
      assumes "prime (p::nat)"
      shows "sqrt p ∉ ℚ"
    proof
      from ‹prime p› have p: "1 < p" by (simp add: prime_nat_iff)
      assume "sqrt p ∈ ℚ"
      then obtain m n :: nat where
          n: "n ≠ 0" and sqrt_rat: "¦sqrt p¦ = m / n"
        and "coprime m n" by (rule Rats_abs_nat_div_natE)
      have eq: "m⇧2 = p * n⇧2"
      proof -
        from n and sqrt_rat have "m = ¦sqrt p¦ * n" by simp
        then have "m⇧2 = (sqrt p)⇧2 * n⇧2"
          by (auto simp add: power2_eq_square)
        also have "(sqrt p)⇧2 = p" by simp
        also have "… * n⇧2 = p * n⇧2" by simp
        finally show ?thesis using of_nat_eq_iff by blast
      qed
      have "p dvd m ∧ p dvd n"
      proof
        from eq have "p dvd m⇧2" ..
        with ‹prime p› show "p dvd m" by (rule prime_dvd_power_nat)
        then obtain k where "m = p * k" ..
        with eq have "p * n⇧2 = p⇧2 * k⇧2" by (auto simp add: power2_eq_square ac_simps)
        with p have "n⇧2 = p * k⇧2" by (simp add: power2_eq_square)
        then have "p dvd n⇧2" ..
        with ‹prime p› show "p dvd n" by (rule prime_dvd_power_nat)
      qed
      then have "p dvd gcd m n" by simp
      with ‹coprime m n› have "p = 1" by simp
      with p show False by simp
    qed
    ```
    这里同样是 tactic mode，但同时也保持了较好的可读性。
  == 依赖类型
    随着计算机的出现和计算机科学的发展，人们逐渐意识到编程语言的*类型系统*与传统的逻辑形式系统有着非常深刻的联系。
    - 类型可以粗略理解为一些“项”构成的集合，而类型系统则是对这些集合的一些规则。例如说，假如 $A, B$ 是类型，我们可以构造积类型 $A times B$，其中的项形如所有 $(a, b)$ 
    - 如果把命题解释成一个类型，那么类型中的项就自然对应着这个命题的证明。更进一步，逻辑连接词的行为也是对应的。例如我们要证明 $A and B$，就相当于分别给出 $A, B$ 的证明，再组合起来。换言之，$A and B$ 的证明应该形如 $(a, b)$，其中 $a$ 是 $A$ 的证明，$b$ 是 $B$ 的证明。这恰好与之前的积类型完全对应。
    - 不同的类型系统有着不同的类型规则（也就是允许怎样构造新的类型）。形式化证明领域常见的是依赖类型，其中的类型规则允许类型依赖于项。例如从项 $a, b : NN$ 就可以构造类型 $a = b$ 
  == Coq
    Coq 是一个相当经典的依赖类型证明语言，尽管它更多的用于程序形式化验证而非数学证明。
  // == 依赖类型
  //   基于依赖类型的语言往往使用起来更接近于编写函数式程序。或者说，之前的证明器更像是“写一段程序，输出结果是最终的目标”，而依赖类型语言的证明则是：“写一个函数，类型是证明的目标”
    ```ml
    (** The theorem is about reals. *)
    Require Import Coq.Reals.Reals.

    (** An irrational number x is a real for which there do not exist
        integers a, b for which a/b = x. (IZR converts integers to reals,
        which is the space where we do the division.) *)
    Definition irrat x :=
      ~exists (a:Z), exists (b:Z), (b > 0)%Z /\ (IZR a / IZR b)%R = x.

    (** The heart of the proof will reason about how many "rightmost
        zeros" are in the binary representation of various numbers.

        Luckily the representation of integers is already based on binary.
        The full range of integers, [Z], is based on a type called
        [positive] which includes positive integers, a negated copy of
        those, and 0.  We will develop some parallel lemmas on both the
        foundational type [positive] and the derived type [Z].
    *)
    Fixpoint RightmostZeros (x:positive) : nat :=
      match x with
        (** The number 1 has zero rightmost zeros. *)
        | 1%positive => 0
        (** Bits ending in 0 (an even number) have one more than the butlast bits. *)
        | (bits~0)%positive => S (RightmostZeros bits)
        (** Bits ending in 1 have no rightmost zeros. *)
        | (x'~1)%positive => 0
      end.

    (** Doubling a [positive] number gives you one additional rightmost zero. *)
    Lemma rmz_mult_2 : forall x, RightmostZeros (2*x) = S (RightmostZeros x).
    Proof.
    auto.
    Qed.

    (** [NPeano] defines the [even] function on [nat]s. *)
    Require Coq.Numbers.Natural.Peano.NPeano.

    (** A square [positive] number has an [even] number of rightmost zeros. *)
    Lemma rmz_sqr : forall x, NPeano.even (RightmostZeros (x*x)) = true.
    Proof.
    induction x.
    (* x~1 * x~1 *)
      auto.
    (* x~0 * x~0 *)
      simpl.
      rewrite Pos.mul_comm.
      auto.
    (* 1 * 1 *)
    auto.
    Qed.

    (** Now we must lift the rightmost-zero theory from [nat]s to integers [Z]. *)
    Fixpoint RightmostZerosZ (x:Z) : nat :=
      match x with
        | Z0 => 0
        | Zpos x => RightmostZeros x
        | Zneg x => RightmostZeros x
      end.

    (** Now on integers (other than 0) we also have that doubling it gives
        you one more rightmost zero. *)
    Lemma rmzZ_mult_2 : forall (x:Z),
      (x <> 0)%Z -> RightmostZerosZ (2*x) = S (RightmostZerosZ x).
    Proof.
    destruct x;  (intuition || apply rmz_mult_2).
    Qed.

    (** The statement that squares have an even number of rightmost zeros is now lifted to [Z]. *)
    Lemma rmzZ_sqr : forall x, NPeano.even (RightmostZerosZ (x*x)) = true.
    Proof.
    destruct x; (auto || apply rmz_sqr).
    Qed.

    (** Incrementing a number inverts its [even] status (making it *not* even). *)
    Lemma even_odd: forall x, NPeano.even x = negb (NPeano.even (S x)).
    Proof.
    induction x.
      auto.
    unfold NPeano.even at 2.
    fold NPeano.even.
    rewrite IHx.
    Require Coq.Bool.Bool.
    rewrite Bool.negb_involutive.
    auto.
    Qed.

    (** Squaring is an inverse of square root, for nonnegative reals. *)
    Lemma sqrt_mul_sqrt_eq_n :
      forall x, (0 <= x)%R -> (sqrt x * sqrt x)%R = x%R.
    Proof.
    intros.
    apply sqrt_def; auto.
    Qed.

    (** Define autoproving hints for all the lemmas need to lift Z facts into R facts. *)

    Hint Resolve IZN INR_IZR_INZ plus_IZR_NEG_POS plus_IZR mult_IZR pow_IZR succ_IZR
        opp_IZR minus_IZR Z_R_minus lt_0_IZR lt_IZR eq_IZR_R0 eq_IZR not_0_IZR le_0_IZR
        le_IZR le_IZR_R1 IZR_ge IZR_le IZR_lt one_IZR_lt1 : z_lift_r.

    (** The square root of two is irrational. *)
    Theorem rad2_irrat : irrat (sqrt 2%R)%R.
    Proof.
    simpl.
    unfold irrat.
    (* The goal is now:
        ~exists a b : X, b > 0 /\ IZR a / IZR b = sqrt 2) *)

    (* Prove the negation by contradiction; i.e. assume the thing is
        positively true. call that assumption H *)
    intro H.

    (* H asserts the existence of numbers a and b governed by some assertions;
        name the numbers and assertions. *)
    destruct H as [a [b [H_b_gt_0 H_a_over_b_eq_rad2]]].

    (* Given the hypothesis, I claim that a squared equals 2 b squared,
        in the [Z] domain. Getting there is just some algebra. *)
    assert (H_main : (a * a = 2 * b * b)%Z).

      (* Proof of H_main. *)

      (* In H_a_over_b_eq_rad2, we'd like to move the IZR b to the rhs. *)
      assert (H_a_eq_rad2_mult_b : (IZR a = sqrt 2 * IZR b)%R).
      (* Proof of H_a_eq_rad2_mult_b. *)

      (* Lift our fact that b > 0 to reals *)
      assert (IZR b > 0)%R.
        replace 0%R with (IZR 0) by solve [auto].
        auto with rorders z_lift_r zarith.

      (* Now we do some equational substitutions. *)
      rewrite <- H_a_over_b_eq_rad2.
      field.
      Hint Resolve Rgt_not_eq : real.
      auto with real.

      (* Back to proving H_main: a * a = 2 * b * b. *)
      assert (H0 : (IZR a * IZR a = (sqrt 2 * IZR b) * (sqrt 2 * IZR b))%R).
      congruence.

      replace (sqrt 2 * IZR b * (sqrt 2 * IZR b))%R
        with ((sqrt 2 * sqrt 2) * IZR b * IZR b)%R in H0
        (* This substitution is shown by assoc/comm normalizing, tactic "ring" *)
        by ring.
      rewrite sqrt_mul_sqrt_eq_n in H0 by (auto with real).
      replace 2%R with (IZR 2) in H0 by auto.
      repeat (rewrite <- mult_IZR in H0).
      apply eq_IZR; trivial.

    clear H_a_over_b_eq_rad2.

    (** (Now we've reduced it to a problem in Z. And now comes the
        interesting part of the proof.) The next three assertions will
        given us some equations on the number of zeros in a*a and b*b
        that can't all be satisfied. *)
    assert (H_a_rmzZ_even : NPeano.even (RightmostZerosZ (a*a)) = true).
      apply rmzZ_sqr.
    assert (H_b_rmzZ_even : NPeano.even (RightmostZerosZ (b*b)) = true).
      apply rmzZ_sqr.
    assert (H_a_rmzZ_eq_S_b_rmzZ : (RightmostZerosZ (a*a)) = S (RightmostZerosZ (b*b))).
      rewrite <- rmzZ_mult_2.
      rewrite H_main.
      rewrite Z.mul_assoc.
      trivial.
      (* Using rmzZ_mult_2 gave us an obligation that b*b <> 0 *)
      assert (b * b > 0)%Z by (auto with zarith).
      auto with zarith.

    (* Now we have those three equations and we can derive a contradiction. *)
    rewrite H_a_rmzZ_eq_S_b_rmzZ in H_a_rmzZ_even.
    rewrite even_odd in H_b_rmzZ_even.
    rewrite H_a_rmzZ_even in H_b_rmzZ_even.
    simpl in H_b_rmzZ_even.
    (* We have derived a bogus equation, false = true. Coq knows what to do from
        here. *)
    discriminate.
    Qed.

    Print rad2_irrat.
    ```
    （这个证明中很多内容是从底层写起的，因此会有点长）
  == Coq
  == Lean
    Lean 是另一门非常年轻的依赖类型编程/证明语言，它的设计更加现代化。Lean 的特点包括编程
    、证明和元编程的完全统一（之前的证明语言大多要求用户在元语言中编写可执行程序），以及一个目前最为庞大的数学定理库 mathlib，其中甚至包含了一些较为前沿的数学知识的形式化。
    ```lean
    theorem sqrt_2_irrational : ∀ (n m : ℕ), m.Coprime n -> ¬ m^2 = 2 * n^2 := by
      intro n m
      intro h1 h2
      have : 2 ∣ m ^ 2 := by
        rw [h2]
        apply dvd_mul_right
      have : 2 ∣ m := by
        apply Nat.Prime.dvd_of_dvd_pow (by decide) this
      have : 2 ^ 2 ∣ m ^ 2 := by
        exact pow_dvd_pow_of_dvd this 2
      rw [show 2 ^ 2 = 4 by omega] at this
      have : 4 ∣ 2 * n ^ 2 := by
        rw [h2] at this
        exact this
      have : 2 ∣ n ^ 2 := by
        apply Nat.dvd_of_mul_dvd_mul_left (k := 2) (by omega)
        exact this
      have : 2 ∣ n := by
        apply Nat.Prime.dvd_of_dvd_pow (by decide) this
      have : 2 ∣ m.gcd n := by
        apply Nat.dvd_gcd <;> assumption
      have : 2 ∣ 1 := by
        rw [h1] at this
        exact this
      norm_num at this
    ```
    为了展示自动证明器的语言特色，下面是一版手写的非 tactic mode 证明：
    ```lean
    theorem sqrt_2_irrational' : ∀ (n m : ℕ), m.Coprime n -> ¬ m^2 = 2 * n^2 := 
    fun n m h1 h2 =>
      let dvdm :=
        Nat.Prime.dvd_of_dvd_pow (of_decide_eq_true (by exact rfl)) <| h2 ▸ (dvd_mul_right 2 (n ^ 2))
      let dvdn :=
        Nat.Prime.dvd_of_dvd_pow (of_decide_eq_true (by exact rfl)) <|
          Nat.dvd_of_mul_dvd_mul_left (of_decide_eq_true (by exact rfl)) <| h2 ▸ pow_dvd_pow_of_dvd dvdm 2
      let dvd1 :=
        Nat.dvd_one.mp (h1 ▸ Nat.dvd_gcd dvdm dvdn)
      of_decide_eq_false (by exact rfl) dvd1
    ```
= 自动化证明
  == 理论
    前面提到过，人们总可以尝试设计更好的方法解决尽可能多的数学问题。通常人们把逻辑系统加上部分元素产生的一类问题构成的系统称作"理论"（theory）。许多实践中也非常有用的理论已经是可判定的，包括：
    - 命题逻辑（SAT 问题）：不含量词的公式
    - 带有等词、未知函数的命题逻辑
    - Presburger 算数：不含（关于变元的）乘除法的整数算数
    - 不含乘除法的实数算数
    - ......
    还有许多问题已经被证明是不可判定的，但人们也设计了许多方法来尝试启发式地解决这些问题。现代的各种 SMT（Satisfiability Modulo Theories）求解器大多集成了大量的特定理论求解器和启发式算法，已经可以解决许多问题。

    同时，上面出现的许多证明语言的 tactic 也直接基于这些求解方法。
  == 然而并不好用
    不幸的是，上面提到的东西在数学证明的应用上并不很多：
    - 数学问题大多横跨大量不可判定的理论，因此很难解决非平凡的问题
    - 至少要将数学问题写成某种形式语言才能利用自动求解器，而人们关心的数学问题的可判定部分往往规模很小，手工验证的成本也不大
    目前这些自动化求解方法还很大程度上只能努力抵消形式化方法造成的麻烦，而不能真正解决数学问题。

    同时，程序验证问题往往规模大而难度低，因此这些方法在程序验证领域有着更广泛的应用。
  == 听说人工智能很厉害
    近几年大语言模型的发展带来了新的希望。Deepseek R1 已经可以在相当一部分数学问题（直到本科数学难度）上有比较好的表现。然而，问题也是很明显的：语言模型只能生成自然语言的证明，而且很可能极具误导性。对于足够长的问题，检查语言模型的证明的难度可能会超过直接证明问题。

    一个很自然的思路是，让语言模型直接生成形式化代码。然而直接让大模型生成形式化代码往往效果极为糟糕，一方面形式化语言的数据量要远小于流行的编程语言，另一方面现有语言模型往往倾向于多说总比少说好，但这在形式化语言中往往是致命的。
  == Copra：上下文学习
    #image("image-1.png")
  == Copra：上下文学习
    #image("image-3.png")
  == 微调
    #image("image-2.png")
  == 但还是很鸡肋
    - 从上面的 benchmark 可以看出，形式语言的生成效果仍然不算好。同时，生成正确的代码往往也非常简单，没有什么自动化的价值。
    
    - 总之，关于数学自动化的探索仍然任重而道远，或许有一天自动化方法完全融入甚至完全取代了人类的数学证明工作，又或许这只是一个美好的梦想。

= Thanks for listening!
  