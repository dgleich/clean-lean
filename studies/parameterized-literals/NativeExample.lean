-- generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
-- Native design example only: not generated Clean output or a canonical oracle.
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic

namespace ParameterizedLiteralDesign
noncomputable def vectorZero (n : Nat) : Fin n → Complex := fun _ => 0
noncomputable def matrixZero (m n : Nat) : Matrix (Fin m) (Fin n) Complex := fun _ _ => 0

theorem vectorEntry (n : Nat) (i : Fin n) : vectorZero n i = 0 := rfl
theorem matrixEntry (m n : Nat) (i : Fin m) (j : Fin n) : matrixZero m n i j = 0 := rfl
end ParameterizedLiteralDesign

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
