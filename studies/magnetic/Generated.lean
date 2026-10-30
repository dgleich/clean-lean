-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

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

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_forward_0788bcbcf6947fc792d8   : Bool :=
  true

noncomputable def cleanNotation_backward_71e5eb68c7c3bab34621   : Bool :=
  false

noncomputable def cleanNotation_pair_15b67cb5922a4f50a003 {T : Type} (x : T) (y : T) : List (T) :=
  [x,y]

noncomputable def cleanNotation_repeat_5d2a815b42f0a394de9c {T : Type} (m : ℕ) (x : T) : List (T) :=
  List.replicate m x

noncomputable def cleanNotation_choices_82b7351357b42ac043a7 {T : Type} (xs : List (List (T))) : List (List (T)) :=
  xs.sections

noncomputable def cleanNotation_map_5d12d795d56ba7da86f5 {T : Type} {U : Type} (f : (T) → (U)) (xs : List (T)) : List (U) :=
  xs.map f

noncomputable def cleanNotation_filter_35fa41184b3a88d16472 {T : Type} (p : (T) → (Prop)) (xs : List (T)) : List (T) :=
  by classical exact xs.filter (fun x => decide (p x))

noncomputable def cleanNotation_choose_e2e205d694c074a81133 {T : Type} (b : Bool) (x : T) (y : T) : T :=
  if b then x else y

noncomputable def cleanNotation_count_58b76c666a9f94fdd55a  (b : Bool) (w : List (Bool)) : ℕ :=
  w.count b

noncomputable def cleanNotation_real_index_c182be2e79fff5553306  (k : ℕ) : ℝ :=
  (k : ℝ)

noncomputable def cleanNotation_sum_matrices_63af84fc6c041afce7bc {n : ℕ} (xs : List (Matrix (Fin n) (Fin n) ℝ)) : Matrix (Fin n) (Fin n) ℝ :=
  xs.sum

noncomputable def cleanNotation_ordered_product_850ea9b0a756a4abc0d2 {n : ℕ} (xs : List (Matrix (Fin n) (Fin n) ℝ)) : Matrix (Fin n) (Fin n) ℝ :=
  xs.prod

noncomputable def cleanNotation_sum_before_769a3c05d6498272ed95 {n : ℕ} (m : ℕ) (f : (ℕ) → (Matrix (Fin n) (Fin n) ℂ)) : Matrix (Fin n) (Fin n) ℂ :=
  ∑ k ∈ Finset.range m, f k

noncomputable def cleanNotation_sum_vertices_19d97077445340f1536d {n : ℕ} (f : (Fin n) → (ℝ)) : ℝ :=
  ∑ i, f i

noncomputable def cleanNotation_entry_42bc533c4b61ce6d9dc9 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (i : Fin n) (j : Fin n) : ℝ :=
  A i j

noncomputable def cleanNotation_diagonal_924e1f360361bb7f3f3d {n : ℕ} (f : (Fin n) → (ℝ)) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal f

noncomputable def cleanNotation_pi_3318d6df42e441010576   : ℝ :=
  Real.pi

noncomputable def cleanNotation_imaginary_unit_dd12d90e3449de458b3a   : ℂ :=
  Complex.I

noncomputable def cleanNotation_complex_scalar_6201cf55b76113d50a6e  (x : ℝ) : ℂ :=
  (x : ℂ)

noncomputable def cleanNotation_complex_exponential_88b7620f1ee63bf4a99d  (z : ℂ) : ℂ :=
  Complex.exp z

noncomputable def cleanNotation_complex_matrix_8ce504730fda017d8908 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  Complex.ofRealHom.mapMatrix A

noncomputable def cleanNotation_real_transpose_110eeb37f2a3ed58943f {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  A.transpose

noncomputable def cleanDefine_Hermitian_1667495db879ea20ebaa {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  M.IsHermitian

noncomputable def cleanDefine_magnetic_phase_a916b64fe81e8c939d24  (q : ℝ) : ℂ :=
  (cleanNotation_complex_exponential_88b7620f1ee63bf4a99d (((cleanNotation_imaginary_unit_dd12d90e3449de458b3a) * (cleanNotation_complex_scalar_6201cf55b76113d50a6e (((2 * (cleanNotation_pi_3318d6df42e441010576)) * q))))))

noncomputable def cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  (((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (q)) • (cleanNotation_complex_matrix_8ce504730fda017d8908 (A))) + ((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 ((-q))) • (cleanNotation_complex_matrix_8ce504730fda017d8908 ((cleanNotation_real_transpose_110eeb37f2a3ed58943f (A))))))

noncomputable def cleanDefine_magnetic_degree_matrix_e464c37eda7577ece31b {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  (cleanNotation_complex_matrix_8ce504730fda017d8908 ((cleanNotation_diagonal_924e1f360361bb7f3f3d ((fun (clean_bound_0 : Fin n) => (cleanNotation_sum_vertices_19d97077445340f1536d ((fun (clean_bound_1 : Fin n) => ((cleanNotation_entry_42bc533c4b61ce6d9dc9 (A) (clean_bound_0) (clean_bound_1)) + (cleanNotation_entry_42bc533c4b61ce6d9dc9 (A) (clean_bound_1) (clean_bound_0)))))))))))

noncomputable def cleanDefine_magnetic_Laplacian_c378e4a8cb113327c8a9 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  ((cleanDefine_magnetic_degree_matrix_e464c37eda7577ece31b (A)) - (cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 (A) (q)))

noncomputable def cleanDefine_direction_words_3510d7b104cf2b0c049c  (m : ℕ) : List (List (Bool)) :=
  (cleanNotation_choices_82b7351357b42ac043a7 ((cleanNotation_repeat_5d2a815b42f0a394de9c (m) ((cleanNotation_pair_15b67cb5922a4f50a003 ((cleanNotation_forward_0788bcbcf6947fc792d8)) ((cleanNotation_backward_71e5eb68c7c3bab34621)))))))

noncomputable def cleanDefine_word_product_1a376b4e684969322fac {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (w : List (Bool)) : Matrix (Fin n) (Fin n) ℝ :=
  (cleanNotation_ordered_product_850ea9b0a756a4abc0d2 ((cleanNotation_map_5d12d795d56ba7da86f5 ((fun (clean_bound_0 : Bool) => (cleanNotation_choose_e2e205d694c074a81133 (clean_bound_0) (A) ((cleanNotation_real_transpose_110eeb37f2a3ed58943f (A)))))) (w))))

noncomputable def cleanDefine_walk_profile_46777589a8677b4798d1 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (m : ℕ) (k : ℕ) : Matrix (Fin n) (Fin n) ℝ :=
  (cleanNotation_sum_matrices_63af84fc6c041afce7bc ((cleanNotation_map_5d12d795d56ba7da86f5 ((fun (clean_bound_0 : List (Bool)) => (cleanDefine_word_product_1a376b4e684969322fac (A) (clean_bound_0)))) ((cleanNotation_filter_35fa41184b3a88d16472 ((fun (clean_bound_1 : List (Bool)) => ((cleanNotation_count_58b76c666a9f94fdd55a ((cleanNotation_forward_0788bcbcf6947fc792d8)) (clean_bound_1)) = k))) ((cleanDefine_direction_words_3510d7b104cf2b0c049c (m))))))))

noncomputable def cleanDefine_walk_Fourier_sum_cb5cf8d3bdceb3ae6707 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (m : ℕ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  ((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 ((-(q * (cleanNotation_real_index_c182be2e79fff5553306 (m)))))) • (cleanNotation_sum_before_769a3c05d6498272ed95 ((m + 1)) ((fun (clean_bound_0 : ℕ) => ((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (((2 * q) * (cleanNotation_real_index_c182be2e79fff5553306 (clean_bound_0))))) • (cleanNotation_complex_matrix_8ce504730fda017d8908 ((cleanDefine_walk_profile_46777589a8677b4798d1 (A) (m) (clean_bound_0)))))))))

noncomputable def cleanNotation_directed_single_edge_8a959dc38adad95c005b   : Matrix (Fin 2) (Fin 2) ℝ :=
  !![0, 1; 0, 0]


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
  (((cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 (A) (q)) ^ m) = ((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 ((-(q * (cleanNotation_real_index_c182be2e79fff5553306 (m)))))) • (cleanNotation_sum_before_769a3c05d6498272ed95 ((m + 1)) ((fun (clean_bound_0 : ℕ) => ((cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (((2 * q) * (cleanNotation_real_index_c182be2e79fff5553306 (clean_bound_0))))) • (cleanNotation_complex_matrix_8ce504730fda017d8908 ((cleanDefine_walk_profile_46777589a8677b4798d1 (A) (m) (clean_bound_0))))))))))

/--
source: magnetic2025
reference: magnetic graph matrix definition
relationship: adapted
-/
def magnetic_adjacency_is_Hermitian : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (q : ℝ),
  (cleanDefine_Hermitian_1667495db879ea20ebaa ((cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 (A) (q))))

/--
source: magneticformalization
reference: unnormalized D minus M convention
relationship: direct
-/
def magnetic_Laplacian_is_Hermitian : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (q : ℝ),
  (cleanDefine_Hermitian_1667495db879ea20ebaa ((cleanDefine_magnetic_Laplacian_c378e4a8cb113327c8a9 (A) (q))))

/--
source: magnetic2025
reference: discussion following equation (1)
relationship: adapted
scope: first power
-/
def zero_potential_symmetrizes_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ((cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 (A) (0)) = (cleanNotation_complex_matrix_8ce504730fda017d8908 ((A + (cleanNotation_real_transpose_110eeb37f2a3ed58943f (A))))))

/--
source: magnetic2025
reference: walk profile examples preceding equation (1)
relationship: adapted
-/
def two_step_mixed_walk_profile : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ((cleanDefine_walk_profile_46777589a8677b4798d1 (A) (2) (1)) = ((A * (cleanNotation_real_transpose_110eeb37f2a3ed58943f (A))) + ((cleanNotation_real_transpose_110eeb37f2a3ed58943f (A)) * A)))

/--
source: magneticformalization
reference: inverse_v1_length_one_fails
relationship: direct
scope: v1 equation (24) at m = 1
-/
def odd_length_inverse_endpoint_counterexample : Prop :=
  ((cleanNotation_complex_matrix_8ce504730fda017d8908 ((cleanDefine_walk_profile_46777589a8677b4798d1 ((cleanNotation_directed_single_edge_8a959dc38adad95c005b)) (1) (1)))) ≠ ((cleanNotation_complex_scalar_6201cf55b76113d50a6e ((1 / 2))) • (cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 ((cleanNotation_directed_single_edge_8a959dc38adad95c005b)) (0))))

end CleanStatements
