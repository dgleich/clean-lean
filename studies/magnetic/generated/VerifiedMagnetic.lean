-- generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md
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
import MagneticStudy

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

noncomputable def cleanNotation_pi_3318d6df42e441010576   : ℝ :=
  Real.pi

noncomputable def cleanNotation_imaginary_unit_dd12d90e3449de458b3a   : ℂ :=
  Complex.I

noncomputable def cleanNotation_complex_scalar_6201cf55b76113d50a6e  (x : ℝ) : ℂ :=
  (x : ℂ)

noncomputable def cleanNotation_complex_exponential_88b7620f1ee63bf4a99d  (z : ℂ) : ℂ :=
  Complex.exp z

noncomputable def cleanDefine_magnetic_phase_a916b64fe81e8c939d24  (q : ℝ) : ℂ :=
  (cleanNotation_complex_exponential_88b7620f1ee63bf4a99d (((cleanNotation_imaginary_unit_dd12d90e3449de458b3a) * (cleanNotation_complex_scalar_6201cf55b76113d50a6e (((2 * (cleanNotation_pi_3318d6df42e441010576)) * q))))))

noncomputable def cleanNotation_complex_matrix_f998d5992df6270b422f {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  CleanPapers.complexify A

noncomputable def cleanNotation_real_transpose_110eeb37f2a3ed58943f {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  A.transpose

noncomputable def cleanDefine_magnetic_adjacency_199544aa0f55794da682 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  (((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (q)) • (cleanNotation_complex_matrix_f998d5992df6270b422f (A))) + ((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 ((-q))) • (cleanNotation_complex_matrix_f998d5992df6270b422f ((cleanNotation_real_transpose_110eeb37f2a3ed58943f (A))))))

noncomputable def cleanDefine_magnetic_degree_matrix_894fb0afbaf0dfd80094 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  CleanPapers.complexify (Matrix.diagonal (CleanPapers.magneticDegree A))

noncomputable def cleanDefine_magnetic_Laplacian_db4675cbdf70f35c509e {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  ((cleanDefine_magnetic_degree_matrix_894fb0afbaf0dfd80094 (A)) - (cleanDefine_magnetic_adjacency_199544aa0f55794da682 (A) (q)))

noncomputable def cleanDefine_walk_profile_64c29fce00bf2e068583 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (m : ℕ) (k : ℕ) : Matrix (Fin n) (Fin n) ℝ :=
  CleanPapers.walkProfile A m k

noncomputable def cleanDefine_walk_Fourier_sum_95c17a1962f2591077ef {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (m : ℕ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  CleanPapers.walkFourierSum A m q

noncomputable def cleanNotation_Hermitian_1667495db879ea20ebaa {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  M.IsHermitian

noncomputable def cleanNotation_directed_single_edge_080e732112035a7cd6e9   : Matrix (Fin 2) (Fin 2) ℝ :=
  CleanPapers.directedSingleEdge


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: magnetic2025
reference: equation (1), Supplement S.II equation (17), Theorem 1
relationship: adapted
scope: forward transform only
-/
def magnetic_powers_encode_walk_profiles : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (m : ℕ),
  ∀ (q : ℝ),
  (((cleanDefine_magnetic_adjacency_199544aa0f55794da682 (A) (q)) ^ m) = (cleanDefine_walk_Fourier_sum_95c17a1962f2591077ef (A) (m) (q)))

/--
source: magnetic2025
reference: magnetic graph matrix definition
relationship: adapted
-/
def magnetic_adjacency_is_Hermitian : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (q : ℝ),
  (cleanNotation_Hermitian_1667495db879ea20ebaa ((cleanDefine_magnetic_adjacency_199544aa0f55794da682 (A) (q))))

/--
source: magneticformalization
reference: unnormalized D minus M convention
relationship: direct
-/
def magnetic_Laplacian_is_Hermitian : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (q : ℝ),
  (cleanNotation_Hermitian_1667495db879ea20ebaa ((cleanDefine_magnetic_Laplacian_db4675cbdf70f35c509e (A) (q))))

/--
source: magnetic2025
reference: discussion following equation (1)
relationship: adapted
scope: first power
-/
def zero_potential_symmetrizes_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ((cleanDefine_magnetic_adjacency_199544aa0f55794da682 (A) (0)) = (cleanNotation_complex_matrix_f998d5992df6270b422f ((A + (cleanNotation_real_transpose_110eeb37f2a3ed58943f (A))))))

/--
source: magnetic2025
reference: walk profile examples preceding equation (1)
relationship: adapted
-/
def two_step_mixed_walk_profile : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ((cleanDefine_walk_profile_64c29fce00bf2e068583 (A) (2) (1)) = ((A * (cleanNotation_real_transpose_110eeb37f2a3ed58943f (A))) + ((cleanNotation_real_transpose_110eeb37f2a3ed58943f (A)) * A)))

/--
source: magneticformalization
reference: inverse_v1_length_one_fails
relationship: direct
scope: v1 equation (24) at m = 1
-/
def odd_length_inverse_endpoint_counterexample : Prop :=
  ((cleanNotation_complex_matrix_f998d5992df6270b422f ((cleanDefine_walk_profile_64c29fce00bf2e068583 ((cleanNotation_directed_single_edge_080e732112035a7cd6e9)) (1) (1)))) ≠ ((cleanNotation_complex_scalar_6201cf55b76113d50a6e ((1 / 2))) • (cleanDefine_magnetic_adjacency_199544aa0f55794da682 ((cleanNotation_directed_single_edge_080e732112035a7cd6e9)) (0))))

end CleanStatements

namespace CleanMagneticProofs
open CleanPapers

-- This bridges the Clean-authored exponential to the independently written Lean definition.
theorem phase_agrees (q : ℝ) : cleanDefine_magnetic_phase_a916b64fe81e8c939d24 q = phase q := by
  change Complex.exp (Complex.I * ((2 * Real.pi * q : ℝ) : ℂ)) =
    Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ))
  congr 1
  push_cast
  ring

theorem adjacency_agrees {n : ℕ} (A : Mat n) (q : ℝ) :
    cleanDefine_magnetic_adjacency_199544aa0f55794da682 A q = magneticMatrix A q := by
  change cleanDefine_magnetic_phase_a916b64fe81e8c939d24 q • complexify A +
    cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (-q) • complexify A.transpose = _
  rw [phase_agrees, phase_agrees]
  rfl

theorem laplacian_agrees {n : ℕ} (A : Mat n) (q : ℝ) :
    cleanDefine_magnetic_Laplacian_db4675cbdf70f35c509e A q = magneticLaplacian A q := by
  change complexify (Matrix.diagonal (magneticDegree A)) - cleanDefine_magnetic_adjacency_199544aa0f55794da682 A q = _
  rw [adjacency_agrees]
  rfl

theorem forward_transform : CleanStatements.magnetic_powers_encode_walk_profiles := by
  intro n A m q
  change cleanDefine_magnetic_adjacency_199544aa0f55794da682 A q ^ m = walkFourierSum A m q
  rw [adjacency_agrees]
  exact magnetic_power_fourier A m q

theorem adjacency_hermitian : CleanStatements.magnetic_adjacency_is_Hermitian := by
  intro n A q
  change (cleanDefine_magnetic_adjacency_199544aa0f55794da682 A q).IsHermitian
  rw [adjacency_agrees]
  exact magneticMatrix_hermitian A q

theorem laplacian_hermitian : CleanStatements.magnetic_Laplacian_is_Hermitian := by
  intro n A q
  change (cleanDefine_magnetic_Laplacian_db4675cbdf70f35c509e A q).IsHermitian
  rw [laplacian_agrees]
  exact magneticLaplacian_hermitian A q

theorem zero_potential : CleanStatements.zero_potential_symmetrizes_adjacency := by
  intro n A
  change cleanDefine_magnetic_adjacency_199544aa0f55794da682 A 0 = complexify (A + A.transpose)
  rw [adjacency_agrees]
  exact magneticMatrix_zero A

theorem mixed_walk : CleanStatements.two_step_mixed_walk_profile := by
  intro n A
  exact walkProfile_two_one A
theorem inverse_endpoint_counterexample :
    CleanStatements.odd_length_inverse_endpoint_counterexample := by
  change complexify (walkProfile directedSingleEdge 1 1) ≠
    (((1 / 2 : ℝ) : ℂ)) • cleanDefine_magnetic_adjacency_199544aa0f55794da682 directedSingleEdge 0
  rw [adjacency_agrees]
  simpa using inverse_v1_length_one_fails
end CleanMagneticProofs

#print axioms CleanMagneticProofs.forward_transform

-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
