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

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
