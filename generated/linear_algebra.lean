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

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def determinant_power : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (k : ℕ),
  ((Matrix.det (A ^ k)) = ((Matrix.det A) ^ k))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def trace_sum : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (A + B)) = ((Matrix.trace A) + (Matrix.trace B)))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def trace_difference : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (A - B)) = ((Matrix.trace A) - (Matrix.trace B)))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def trace_negative : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (-A)) = (-(Matrix.trace A)))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def trace_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (Matrix.transpose A)) = (Matrix.trace A))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def trace_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (A * B)) = (Matrix.trace (B * A)))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def trace_cycle : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace ((A * B) * C)) = (Matrix.trace ((C * A) * B)))

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: specialized
-/
def matrix_vector_associativity : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  ((A *ᵥ (B *ᵥ x)) = ((A * B) *ᵥ x))

/--
source: mathlib
reference: Matrix.mulVec_add
relationship: specialized
-/
def matrix_vector_addition : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x y : Fin n → ℂ),
  ((A *ᵥ (x + y)) = ((A *ᵥ x) + (A *ᵥ y)))

/--
source: mathlib
reference: Matrix.add_mulVec
relationship: specialized
-/
def matrix_addition_action : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  (((A + B) *ᵥ x) = ((A *ᵥ x) + (B *ᵥ x)))

/--
source: mathlib
reference: Matrix.mulVec_sub
relationship: specialized
-/
def matrix_vector_subtraction : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x y : Fin n → ℂ),
  ((A *ᵥ (x - y)) = ((A *ᵥ x) - (A *ᵥ y)))

/--
source: mathlib
reference: Matrix.sub_mulVec
relationship: specialized
-/
def matrix_subtraction_action : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  (((A - B) *ᵥ x) = ((A *ᵥ x) - (B *ᵥ x)))

/--
source: mathlib
reference: Matrix.mulVec_smul
relationship: specialized
-/
def matrix_scalar_action : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  ∀ (c : ℂ),
  ((A *ᵥ (c • x)) = (c • (A *ᵥ x)))

/--
source: mathlib
reference: Matrix.transpose_transpose
relationship: specialized
-/
def transpose_involution : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.transpose (Matrix.transpose A)) = A)

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def transpose_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.transpose (A * B)) = ((Matrix.transpose B) * (Matrix.transpose A)))

end CleanStatements
