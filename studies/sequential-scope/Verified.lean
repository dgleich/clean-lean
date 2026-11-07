import Lean
import Mathlib.Data.Real.Basic

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Scalar_26f57455726c067fc151  : Type :=
  Real

noncomputable def cleanType_T_a366675a2ad24e54d8fb  : Type :=
  Real

noncomputable def cleanNotation_absolute_value_9bd1e5ed50fc2018c3ed  (x : Real) : Real :=
  abs x

noncomputable def cleanNotation_scalar_zero_a5a92d18dd3d39d16f9a   : Real :=
  (0 : Real)



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: equality reflexivity
relationship: original
-/
def arbitrary_equality : Prop :=
  ∀ (T : Type),
  ∀ (x : T),
  (x = x)

/--
source: local
reference: Mathlib abs_nonneg
relationship: specialized
-/
def absolute_value_nonnegative : Prop :=
  ∀ (x : Real),
  ((cleanNotation_absolute_value_9bd1e5ed50fc2018c3ed (x)) ≥ (cleanNotation_scalar_zero_a5a92d18dd3d39d16f9a))

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

noncomputable def expected_absolute (x : Real) : Real := abs x
same_basic_target cleanNotation_absolute_value_9bd1e5ed50fc2018c3ed expected_absolute
noncomputable def expected_zero : Real := 0
same_basic_target cleanNotation_scalar_zero_a5a92d18dd3d39d16f9a expected_zero

def expected_arbitrary_equality : Prop := ∀ (T : Type) (x : T), x = x
same_basic_target CleanStatements.arbitrary_equality expected_arbitrary_equality

def expected_absolute_nonnegative : Prop := ∀ (x : Real), cleanNotation_absolute_value_9bd1e5ed50fc2018c3ed x ≥ cleanNotation_scalar_zero_a5a92d18dd3d39d16f9a
same_basic_target CleanStatements.absolute_value_nonnegative expected_absolute_nonnegative

theorem arbitrary_equality_checked : CleanStatements.arbitrary_equality := by
 intro T x
 rfl

theorem absolute_nonnegative_checked : CleanStatements.absolute_value_nonnegative := by
 intro x
 change abs x ≥ 0
 exact abs_nonneg x

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
