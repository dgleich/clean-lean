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
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def determinant_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (A * B)) = ((Matrix.det A) * (Matrix.det B)))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def determinant_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (Matrix.transpose A)) = (Matrix.det A))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def determinant_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (A * B)) = (Matrix.det (B * A)))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def determinant_left_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (A * (B * C))) = (Matrix.det (B * (A * C))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def determinant_right_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det ((A * B) * C)) = (Matrix.det ((A * C) * B)))

end CleanStatements
