import Lean
import Mathlib.Data.Real.Basic

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanDefine_real_identity_1732623b403e49357d04  (x : ℝ) : ℝ :=
  x

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: lexical type binding
relationship: original
-/
def local_carrier_identity : Prop :=
  ∀ (Real : Type),
  ∀ (x : Real),
  (x = x)

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

def expected_local : Prop := ∀ (Real : Type) (x : Real), x = x
same_basic_target CleanStatements.local_carrier_identity expected_local
def actual_quantified : Prop := (∀ (clean_bound_0 : Type), (∀ (clean_bound_1 : clean_bound_0), (clean_bound_1 = clean_bound_1)))
def expected_quantified : Prop := ∀ (A : Type) (x : A), x = x
same_basic_target actual_quantified expected_quantified
def actual_alias : Prop := ∀ (Real : Type) (x : ℝ), x = x
def expected_alias : Prop := ∀ (Real : Type) (x : ℝ), x = x
same_basic_target actual_alias expected_alias
def actual_reified (Real : Type) : Type := ℝ
def expected_reified (Real : Type) : Type := ℝ
same_basic_target actual_reified expected_reified
theorem local_checked : CleanStatements.local_carrier_identity := by intro A x; rfl
theorem quantified_checked : actual_quantified := by intro A x; rfl
theorem alias_checked : actual_alias := by intro A x; rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
