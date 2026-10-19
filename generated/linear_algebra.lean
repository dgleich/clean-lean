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

noncomputable def cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_det_7326e962c725ce45b521 {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  Matrix.det x0

noncomputable def cleanNotation_trace_77213551dad9a763052a {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  Matrix.trace x0

noncomputable def cleanNotation_transpose_ec7d2405c8c143132e84 {m : ℕ} {n : ℕ} (x0 : Matrix (Fin m) (Fin n) ℂ) : Matrix (Fin n) (Fin m) ℂ :=
  Matrix.transpose x0

noncomputable def cleanNotation_inverse_60f5a255d86c84175527 {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  (x0)⁻¹

noncomputable def cleanDefine_commutator_dec87a8766301eb4176d {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (B : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  ((A * B) - (B * A))

noncomputable def cleanDefine_matrix_square_59c5fc3d3e7ab2ab3d9b {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  (A * A)


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
  ((cleanNotation_det_7326e962c725ce45b521 ((A * B))) = ((cleanNotation_det_7326e962c725ce45b521 (A)) * (cleanNotation_det_7326e962c725ce45b521 (B))))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def determinant_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((cleanNotation_transpose_ec7d2405c8c143132e84 (A)))) = (cleanNotation_det_7326e962c725ce45b521 (A)))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def determinant_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A * B))) = (cleanNotation_det_7326e962c725ce45b521 ((B * A))))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def determinant_left_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A * (B * C)))) = (cleanNotation_det_7326e962c725ce45b521 ((B * (A * C)))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def determinant_right_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 (((A * B) * C))) = (cleanNotation_det_7326e962c725ce45b521 (((A * C) * B))))

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def determinant_power : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (k : ℕ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A ^ k))) = ((cleanNotation_det_7326e962c725ce45b521 (A)) ^ k))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def trace_sum : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((A + B))) = ((cleanNotation_trace_77213551dad9a763052a (A)) + (cleanNotation_trace_77213551dad9a763052a (B))))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def trace_difference : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((A - B))) = ((cleanNotation_trace_77213551dad9a763052a (A)) - (cleanNotation_trace_77213551dad9a763052a (B))))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def trace_negative : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((-A))) = (-(cleanNotation_trace_77213551dad9a763052a (A))))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def trace_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((cleanNotation_transpose_ec7d2405c8c143132e84 (A)))) = (cleanNotation_trace_77213551dad9a763052a (A)))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def trace_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((A * B))) = (cleanNotation_trace_77213551dad9a763052a ((B * A))))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def trace_cycle : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a (((A * B) * C))) = (cleanNotation_trace_77213551dad9a763052a (((C * A) * B))))

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
  ((cleanNotation_transpose_ec7d2405c8c143132e84 ((cleanNotation_transpose_ec7d2405c8c143132e84 (A)))) = A)

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def transpose_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_transpose_ec7d2405c8c143132e84 ((A * B))) = ((cleanNotation_transpose_ec7d2405c8c143132e84 (B)) * (cleanNotation_transpose_ec7d2405c8c143132e84 (A))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_commutator : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((cleanDefine_commutator_dec87a8766301eb4176d (A) (B)))) = 0)

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_matrix_square : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((cleanDefine_matrix_square_59c5fc3d3e7ab2ab3d9b (A)))) = (cleanNotation_trace_77213551dad9a763052a ((A * A))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: adapted
-/
def determinant_matrix_square : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((cleanDefine_matrix_square_59c5fc3d3e7ab2ab3d9b (A)))) = ((cleanNotation_det_7326e962c725ce45b521 (A)) * (cleanNotation_det_7326e962c725ce45b521 (A))))

end CleanStatements
