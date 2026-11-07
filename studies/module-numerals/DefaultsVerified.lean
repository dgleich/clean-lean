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
source: local
reference: default addition
relationship: original
-/
def default_addition : Prop :=
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 2))))) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 3))))

/--
source: mathlib
reference: add_comm
relationship: specialized
-/
def constrained_addition : Prop :=
  ∀ (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))) ((_root_.cleanNotation_real_sum_ada0b77059e458fdb12f ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (x))))

/--
source: local
reference: annotated identity
relationship: original
-/
def explicit_annotation_constrains_inference : Prop :=
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))

/--
source: local
reference: generic identity
relationship: original
-/
def default_named_assumption : Prop :=
  ∀ («equal_u28_1_u2c__1_u29_» : (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))))

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

noncomputable def default_actual_0  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))
noncomputable def default_expected_0  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)
same_basic_target default_actual_0 default_expected_0

noncomputable def default_actual_1  : _root_.cleanType_Counting_6ad264a0777258751e84 := (_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))) ((_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 2))))
noncomputable def default_expected_1  : _root_.cleanType_Counting_6ad264a0777258751e84 := _root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 2))
same_basic_target default_actual_1 default_expected_1

noncomputable def default_actual_2 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (x) ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))
noncomputable def default_expected_2 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target default_actual_2 default_expected_2

noncomputable def default_actual_3  : _root_.cleanType_Real_8457e8182afcbbac5a10 := (_root_.cleanNotation_negative_17e47657ee4a9141ccb7 ((_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))))
noncomputable def default_expected_3  : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_negative_17e47657ee4a9141ccb7 (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target default_actual_3 default_expected_3

def expected_default_addition : Prop := @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Counting_6ad264a0777258751e84 (_root_.cleanNotation_counting_sum_a4e2281fb22204b09a1e (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 2))) (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 3))
same_basic_target CleanStatements.default_addition expected_default_addition

def expected_constrained_addition : Prop := ∀ (x : _root_.cleanType_Real_8457e8182afcbbac5a10), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f x (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))) (_root_.cleanNotation_real_sum_ada0b77059e458fdb12f (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) x)
same_basic_target CleanStatements.constrained_addition expected_constrained_addition

def expected_explicit_annotation_constrains_inference : Prop := @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1)) (_root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 1))
same_basic_target CleanStatements.explicit_annotation_constrains_inference expected_explicit_annotation_constrains_inference

def expected_default_named_assumption : Prop := @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Counting_6ad264a0777258751e84 (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) → @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Counting_6ad264a0777258751e84 (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1)) (_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 1))
same_basic_target CleanStatements.default_named_assumption expected_default_named_assumption

theorem default_addition_proof : CleanStatements.default_addition := by rfl
theorem default_constraint_proof : CleanStatements.constrained_addition := by intro x; exact add_comm _ _
theorem explicit_constraint_proof : CleanStatements.explicit_annotation_constrains_inference := by rfl
theorem default_assumption_proof : CleanStatements.default_named_assumption := by intro h; exact h

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
