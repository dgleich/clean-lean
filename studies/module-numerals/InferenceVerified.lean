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

noncomputable def cleanDefine_inferred_one_22235ca93737902bc71c   : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))

noncomputable def cleanDefine_inferred_counting_one_7185bd57a69ec1fc9db1   : (_root_.cleanType_Counting_6ad264a0777258751e84) :=
  (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: add_comm
relationship: specialized
-/
def inferred_real_addition : Prop :=
  ∀ (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))) ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (x))))

/--
source: mathlib
reference: add_comm
relationship: specialized
-/
def inferred_nested_addition : Prop :=
  ∀ (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))) (x))) ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))))))

/--
source: mathlib
reference: add_comm
relationship: specialized
-/
def inferred_counting_addition : Prop :=
  ∀ (n : (_root_.cleanType_Counting_6ad264a0777258751e84)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e (n) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))))) ((_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) (n))))

/--
source: local
reference: contextual assumption
relationship: original
-/
def inferred_named_assumption : Prop :=
  ∀ («nonnegative_u28_1_u29_» : (_root_.cleanDefine_nonnegative_183fe03587b568691478 ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))),
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

noncomputable def inference_actual_0 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))
noncomputable def inference_expected_0 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target inference_actual_0 inference_expected_0

noncomputable def inference_actual_1 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (x))
noncomputable def inference_expected_1 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) x
same_basic_target inference_actual_1 inference_expected_1

noncomputable def inference_actual_2 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))) (x))
noncomputable def inference_expected_2 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))) x
same_basic_target inference_actual_2 inference_expected_2

noncomputable def inference_actual_3 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))))
noncomputable def inference_expected_3 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2)))
same_basic_target inference_actual_3 inference_expected_3

noncomputable def inference_actual_4  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))
noncomputable def inference_expected_4  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))
same_basic_target inference_actual_4 inference_expected_4

noncomputable def inference_actual_5  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 2))))
noncomputable def inference_expected_5  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 2))
same_basic_target inference_actual_5 inference_expected_5

noncomputable def inference_actual_6 (n : _root_.cleanType_Counting_6ad264a0777258751e84) : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e (n) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))))
noncomputable def inference_expected_6 (n : _root_.cleanType_Counting_6ad264a0777258751e84) : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e n (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))
same_basic_target inference_actual_6 inference_expected_6

noncomputable def inference_actual_7  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_negative_17e47657ee4a9141ccb7 ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))
noncomputable def inference_expected_7  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_negative_17e47657ee4a9141ccb7 (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target inference_actual_7 inference_expected_7

noncomputable def inference_actual_8 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))
noncomputable def inference_expected_8 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target inference_actual_8 inference_expected_8

noncomputable def expected_cleanDefine_inferred_one_22235ca93737902bc71c : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)
same_basic_target cleanDefine_inferred_one_22235ca93737902bc71c expected_cleanDefine_inferred_one_22235ca93737902bc71c

noncomputable def expected_cleanDefine_inferred_counting_one_7185bd57a69ec1fc9db1 : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)
same_basic_target cleanDefine_inferred_counting_one_7185bd57a69ec1fc9db1 expected_cleanDefine_inferred_counting_one_7185bd57a69ec1fc9db1

def expected_inferred_real_addition : Prop := ∀ (x : _root_.cleanType_Real_8457e8182afcbbac5a10), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) x)
same_basic_target CleanStatements.inferred_real_addition expected_inferred_real_addition

def expected_inferred_nested_addition : Prop := ∀ (x : _root_.cleanType_Real_8457e8182afcbbac5a10), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))) x) (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 2))))
same_basic_target CleanStatements.inferred_nested_addition expected_inferred_nested_addition

def expected_inferred_counting_addition : Prop := ∀ (n : _root_.cleanType_Counting_6ad264a0777258751e84), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Counting_6ad264a0777258751e84 (_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e n (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) (_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) n)
same_basic_target CleanStatements.inferred_counting_addition expected_inferred_counting_addition

def expected_inferred_assumption : Prop := _root_.cleanDefine_nonnegative_183fe03587b568691478 (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) → _root_.cleanDefine_nonnegative_183fe03587b568691478 (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target CleanStatements.inferred_named_assumption expected_inferred_assumption

theorem inferred_real_proof : CleanStatements.inferred_real_addition := by intro x; exact add_comm _ _
theorem inferred_nested_proof : CleanStatements.inferred_nested_addition := by intro x; exact add_comm _ _
theorem inferred_counting_proof : CleanStatements.inferred_counting_addition := by intro n; exact add_comm _ _
theorem inferred_assumption_proof : CleanStatements.inferred_named_assumption := by intro h; exact h

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
