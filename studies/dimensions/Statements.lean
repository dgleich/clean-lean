import Lean
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

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

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

noncomputable def cleanDefine_vector_identity_43e96256903dbab7d84c  (n : ℕ) (x : Fin n → ℝ) : Fin n → ℝ :=
  x

structure cleanStructure_SizedVector_e3bb6d8f3a27db756907  : Type where
  «size» : ℕ
  «vector» : Fin «size» → ℝ

noncomputable def cleanConstructor_sized_vector_236d49ac38f05d98affb («size» : ℕ) («vector» : Fin «size» → ℝ) : cleanStructure_SizedVector_e3bb6d8f3a27db756907 :=
  @cleanStructure_SizedVector_e3bb6d8f3a27db756907.mk «size» «vector»


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def determinant_with_named_dimension : Prop :=
  ∀ (n : ℕ),
  let m : ℕ := n;
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (B : Matrix (Fin m) (Fin m) ℂ),
  ((@cleanNotation_det_7326e962c725ce45b521 (m) ((A * B))) = ((@cleanNotation_det_7326e962c725ce45b521 (n) (A)) * (@cleanNotation_det_7326e962c725ce45b521 (m) (B))))

/--
source: mathlib
reference: Matrix.transpose_transpose
relationship: specialized
-/
def transpose_with_named_dimension : Prop :=
  ∀ (n : ℕ),
  let m : ℕ := n;
  ∀ (A : Matrix (Fin m) (Fin n) ℂ),
  ((@cleanNotation_transpose_ec7d2405c8c143132e84 (n) (m) ((@cleanNotation_transpose_ec7d2405c8c143132e84 (m) (n) (A)))) = A)

/--
source: dimensions
reference: vector identity
relationship: original
-/
def explicit_dimension_literal : Prop :=
  ∀ (x : Fin 3 → ℝ),
  ((@cleanDefine_vector_identity_43e96256903dbab7d84c (3) (x)) = x)

/--
source: dimensions
reference: vector identity on stored dimension
relationship: original
-/
def dimension_from_record_field : Prop :=
  ∀ (S : cleanStructure_SizedVector_e3bb6d8f3a27db756907),
  ((@cleanDefine_vector_identity_43e96256903dbab7d84c ((@cleanStructure_SizedVector_e3bb6d8f3a27db756907.«size» (S))) ((@cleanStructure_SizedVector_e3bb6d8f3a27db756907.«vector» (S)))) = (@cleanStructure_SizedVector_e3bb6d8f3a27db756907.«vector» (S)))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
