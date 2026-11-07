import Lean
import Mathlib.Data.Real.Basic

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Real_8457e8182afcbbac5a10  : Type :=
  Real

noncomputable def cleanNumeral_Real_de7b7f340e0e395f8201 (digits : Nat) : _root_.cleanType_Real_8457e8182afcbbac5a10 :=
  (fun n : Nat => (n : Real)) digits

noncomputable abbrev cleanType_Counting_6ad264a0777258751e84  : Type :=
  Nat

noncomputable def cleanNumeral_Counting_1d6c17104a2bceaded1f (digits : Nat) : _root_.cleanType_Counting_6ad264a0777258751e84 :=
  (fun n : Nat => n) digits

noncomputable abbrev cleanType_Twin_1698c6b21bee6435070a  : Type :=
  Real

noncomputable def cleanNumeral_Twin_1b9c14f78d03b828afdb (digits : Nat) : _root_.cleanType_Twin_1698c6b21bee6435070a :=
  (fun n : Nat => (n : Real)) digits

noncomputable abbrev cleanType_Function_c7021aafda499fb8cdb1 (T : Type) (U : Type) : Type :=
  (T) → (U)

noncomputable def cleanDefine_equal_59dc0f11ba9b345348cf {T : Type} (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_nonnegative_183fe03587b568691478  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  0 ≤ x

noncomputable def cleanNotation_real_sum_ada0b77059e458fdb12f  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (y : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  x+y

noncomputable def cleanNotation_counting_sum_a4e2281fb22204b09a1e  (x : (_root_.cleanType_Counting_6ad264a0777258751e84)) (y : (_root_.cleanType_Counting_6ad264a0777258751e84)) : (_root_.cleanType_Counting_6ad264a0777258751e84) :=
  x+y

noncomputable def cleanNotation_negative_17e47657ee4a9141ccb7  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  -x

noncomputable def cleanDefine_one_44c1f28c2d33870cfa66   : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: add_comm
relationship: specialized
-/
def addition_with_one : Prop :=
  ∀ (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))) ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (x))))

/--
source: local
reference: identity
relationship: original
-/
def named_numeral_assumption : Prop :=
  ∀ («nonnegative_u28__u28_1_u3a__Real_u29__u29_» : (_root_.cleanDefine_nonnegative_183fe03587b568691478 ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))),
  (_root_.cleanDefine_nonnegative_183fe03587b568691478 ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))

end CleanStatements

open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_basic_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"

noncomputable def numeral_actual_0  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 0))
noncomputable def numeral_expected_0  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 0)
same_basic_target numeral_actual_0 numeral_expected_0

noncomputable def numeral_actual_1  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
noncomputable def numeral_expected_1  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)
same_basic_target numeral_actual_1 numeral_expected_1

noncomputable def numeral_actual_2  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 123))
noncomputable def numeral_expected_2  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 123)
same_basic_target numeral_actual_2 numeral_expected_2

noncomputable def numeral_actual_3  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 100000000000000000000000000000000000000))
noncomputable def numeral_expected_3  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 100000000000000000000000000000000000000)
same_basic_target numeral_actual_3 numeral_expected_3

noncomputable def numeral_actual_4  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 0))
noncomputable def numeral_expected_4  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 0)
same_basic_target numeral_actual_4 numeral_expected_4

noncomputable def numeral_actual_5  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))
noncomputable def numeral_expected_5  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)
same_basic_target numeral_actual_5 numeral_expected_5

noncomputable def numeral_actual_6  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 123))
noncomputable def numeral_expected_6  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 123)
same_basic_target numeral_actual_6 numeral_expected_6

noncomputable def numeral_actual_7  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 100000000000000000000000000000000000000))
noncomputable def numeral_expected_7  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 100000000000000000000000000000000000000)
same_basic_target numeral_actual_7 numeral_expected_7

noncomputable def numeral_actual_8  : _root_.cleanType_Twin_1698c6b21bee6435070a := (_root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 0))
noncomputable def numeral_expected_8  : _root_.cleanType_Twin_1698c6b21bee6435070a := _root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 0)
same_basic_target numeral_actual_8 numeral_expected_8

noncomputable def numeral_actual_9  : _root_.cleanType_Twin_1698c6b21bee6435070a := (_root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 1))
noncomputable def numeral_expected_9  : _root_.cleanType_Twin_1698c6b21bee6435070a := _root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 1)
same_basic_target numeral_actual_9 numeral_expected_9

noncomputable def numeral_actual_10  : _root_.cleanType_Twin_1698c6b21bee6435070a := (_root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 123))
noncomputable def numeral_expected_10  : _root_.cleanType_Twin_1698c6b21bee6435070a := _root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 123)
same_basic_target numeral_actual_10 numeral_expected_10

noncomputable def numeral_actual_11  : _root_.cleanType_Twin_1698c6b21bee6435070a := (_root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 100000000000000000000000000000000000000))
noncomputable def numeral_expected_11  : _root_.cleanType_Twin_1698c6b21bee6435070a := _root_.cleanNumeral_Twin_1b9c14f78d03b828afdb (nat_lit 100000000000000000000000000000000000000)
same_basic_target numeral_actual_11 numeral_expected_11

noncomputable def numeral_actual_12  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
noncomputable def numeral_expected_12  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)
same_basic_target numeral_actual_12 numeral_expected_12

noncomputable def numeral_actual_13  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))
noncomputable def numeral_expected_13  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))
same_basic_target numeral_actual_13 numeral_expected_13

noncomputable def numeral_actual_14  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_negative_17e47657ee4a9141ccb7 ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))
noncomputable def numeral_expected_14  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_negative_17e47657ee4a9141ccb7 (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target numeral_actual_14 numeral_expected_14

noncomputable def numeral_actual_15 (cleanType_Real_8457e8182afcbbac5a10: _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
noncomputable def numeral_expected_15 (cleanType_Real_8457e8182afcbbac5a10: _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)
same_basic_target numeral_actual_15 numeral_expected_15

noncomputable def numeral_actual_16 (cleanNumeral_Real_de7b7f340e0e395f8201: _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
noncomputable def numeral_expected_16 (cleanNumeral_Real_de7b7f340e0e395f8201: _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)
same_basic_target numeral_actual_16 numeral_expected_16

noncomputable def expected_one : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)
same_basic_target cleanDefine_one_44c1f28c2d33870cfa66 expected_one

def expected_commute : Prop := ∀ (x : _root_.cleanType_Real_8457e8182afcbbac5a10), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) x)
same_basic_target CleanStatements.addition_with_one expected_commute

theorem commute_proof : CleanStatements.addition_with_one := by intro x; exact add_comm x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
theorem assumption_proof : CleanStatements.named_numeral_assumption := by intro h; exact h

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
