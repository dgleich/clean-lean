import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Combinatorics.SimpleGraph.Basic
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.List.Sort
import Mathlib.Data.Nat.GCD.Basic


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: stewart2001
reference: Theorem 1.10, page 9
relationship: adapted
scope: eigenvector part
-/
def similarity_transforms_eigenvector : Prop :=
  ∀ (n : ℕ),
  ∀ (A S : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  ∀ (μ : ℂ),
  ∀ (invertibility : ((Matrix.det S) ≠ 0)),
  ∀ (nonzero : (x ≠ 0)),
  ∀ (eigenpair : ((A *ᵥ x) = (μ • x))),
  let y : Fin n → ℂ := (((S)⁻¹) *ᵥ x);
  ((y ≠ 0) ∧ ((((((S)⁻¹) * A) * S) *ᵥ y) = (μ • y)))

end CleanStatements
