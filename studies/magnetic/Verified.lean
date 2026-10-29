-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Algebra.BigOperators.Ring.List
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
-- generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md

noncomputable section
open scoped BigOperators
namespace MagneticReference
abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
abbrev CMat (n : ℕ) := Matrix (Fin n) (Fin n) ℂ

/-- Ordered words; true chooses A, false chooses its transpose. -/
def wordProduct {n : ℕ} (A : Mat n) (word : List Bool) : Mat n :=
  (word.map fun forward => if forward then A else A.transpose).prod

/-- All words of exactly the requested length, each occurring once. -/
def words : ℕ → List (List Bool)
  | 0 => [[]]
  | m + 1 => (words m).map (true :: ·) ++ (words m).map (false :: ·)

/-- Exactly k forward factors; empty product is I and out-of-range sums are zero. -/
def walkProfile {n : ℕ} (A : Mat n) (m k : ℕ) : Mat n :=
  (((words m).filter fun w => w.count true = k).map (wordProduct A)).sum

def complexify {n : ℕ} (A : Mat n) : CMat n := fun i j => (A i j : ℂ)
def phase (q : ℝ) : ℂ := Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ))
def magneticMatrix {n : ℕ} (A : Mat n) (q : ℝ) : CMat n :=
  phase q • complexify A + phase (-q) • complexify A.transpose

def walkFourierSum {n : ℕ} (A : Mat n) (m : ℕ) (q : ℝ) : CMat n :=
  phase (-(q * m)) • ∑ k ∈ Finset.range (m + 1),
    phase (2 * q * k) • complexify (walkProfile A m k)



private def complexifyHom (n : ℕ) : Mat n →+* CMat n :=
  Complex.ofRealHom.mapMatrix

@[simp] theorem complexify_one {n : ℕ} : complexify (1 : Mat n) = 1 :=
  (complexifyHom n).map_one
@[simp] theorem complexify_mul {n : ℕ} (A B : Mat n) :
    complexify (A * B) = complexify A * complexify B :=
  (complexifyHom n).map_mul A B
@[simp] theorem complexify_add {n : ℕ} (A B : Mat n) :
    complexify (A + B) = complexify A + complexify B :=
  (complexifyHom n).map_add A B
@[simp] theorem complexify_zero {n : ℕ} : complexify (0 : Mat n) = 0 :=
  (complexifyHom n).map_zero

@[simp] theorem phase_zero : phase 0 = 1 := by simp [phase]
theorem phase_add (x y : ℝ) : phase (x + y) = phase x * phase y := by
  simp only [phase, Complex.ofReal_add, mul_add, Complex.exp_add]

/-- Ordered product of magnetic edge factors, with no commutativity assumption. -/
def magneticWord {n : ℕ} (A : Mat n) (q : ℝ) (w : List Bool) : CMat n :=
  (w.map fun b => if b then phase q • complexify A
    else phase (-q) • complexify A.transpose).prod

@[simp] theorem wordProduct_cons {n : ℕ} (A : Mat n) (b : Bool) (w : List Bool) :
    wordProduct A (b :: w) = (if b then A else A.transpose) * wordProduct A w := by
  simp [wordProduct]

theorem magneticWord_weight {n : ℕ} (A : Mat n) (q : ℝ) (w : List Bool) :
    magneticWord A q w =
      phase (q * (2 * (w.count true : ℝ) - w.length)) • complexify (wordProduct A w) := by
  induction w with
  | nil => simp [magneticWord, wordProduct]
  | cons b w ih =>
    cases b <;>
      simp only [magneticWord, List.map_cons, List.prod_cons, Bool.false_eq_true,
        if_false, if_true] at *
    · rw [ih, smul_mul_smul_comm, ← phase_add, wordProduct_cons, complexify_mul]
      congr 2
      simp
      ring
    · rw [ih, smul_mul_smul_comm, ← phase_add, wordProduct_cons, complexify_mul]
      congr 2
      simp
      ring

theorem magnetic_power_words {n : ℕ} (A : Mat n) (q : ℝ) (m : ℕ) :
    magneticMatrix A q ^ m = ((words m).map (magneticWord A q)).sum := by
  induction m with
  | zero => simp [words, magneticWord]
  | succ m ih =>
    rw [pow_succ', ih]
    simp [words, magneticWord, magneticMatrix, List.map_map, Function.comp_def,
      add_mul, ← List.sum_map_mul_left]

theorem words_length (m : ℕ) (w : List Bool) (hw : w ∈ words m) : w.length = m := by
  induction m generalizing w with
  | zero => simpa [words] using hw
  | succ m ih =>
    simp only [words, List.mem_append, List.mem_map] at hw
    rcases hw with ⟨v, hv, rfl⟩ | ⟨v, hv, rfl⟩ <;> simp [ih v hv]


/-- Regroup a finite list by forward count. Multiplicities are preserved. -/
private theorem sum_by_forward_count {n : ℕ} (l : List (List Bool)) (m : ℕ)
    (f : List Bool → CMat n) (h : ∀ w ∈ l, w.count true ≤ m) :
    (l.map f).sum = ∑ k ∈ Finset.range (m + 1),
      ((l.filter fun w => w.count true = k).map f).sum := by
  induction l with
  | nil => simp
  | cons w l ih =>
    have hw : w.count true ≤ m := h w (by simp)
    have ht : ∀ v ∈ l, v.count true ≤ m := fun v hv => h v (by simp [hv])
    have single : (∑ k ∈ Finset.range (m + 1),
        if w.count true = k then f w else 0) = f w := by
      rw [Finset.sum_eq_single (w.count true)]
      · simp
      · intro k _ hk
        simp [Ne.symm hk]
      · intro hn
        exact False.elim (hn (Finset.mem_range.mpr (Nat.lt_succ_of_le hw)))
    simp only [List.map_cons, List.sum_cons, List.filter_cons]
    rw [ih ht, ← single]
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro k _
    by_cases hk : w.count true = k <;> simp [hk]

/-- The paper's forward Fourier identity, for all real weighted matrices and lengths. -/
theorem magnetic_power_fourier {n : ℕ} (A : Mat n) (m : ℕ) (q : ℝ) :
    magneticMatrix A q ^ m = walkFourierSum A m q := by
  rw [magnetic_power_words]
  rw [sum_by_forward_count (words m) m (magneticWord A q)
    (fun w hw => (List.count_le_length).trans_eq (words_length m w hw))]
  unfold walkFourierSum
  rw [Finset.smul_sum]
  apply Finset.sum_congr rfl
  intro k hk
  have terms :
      (((words m).filter fun w => w.count true = k).map (magneticWord A q)).sum =
      (((words m).filter fun w => w.count true = k).map
        (fun w => phase (q * (2 * k - m)) • complexify (wordProduct A w))).sum := by
    congr 1
    apply List.map_congr_left
    intro w hw
    simp only [List.mem_filter, decide_eq_true_eq] at hw
    rw [magneticWord_weight, words_length m w hw.1, hw.2]
  rw [terms]
  have pull (l : List (List Bool)) (c : ℂ) :
      (l.map (fun w => c • complexify (wordProduct A w))).sum =
      c • complexify ((l.map (wordProduct A)).sum) := by
    induction l with
    | nil => simp
    | cons w l ih => simp [ih, smul_add]
  rw [pull]
  change phase (q * (2 * k - m)) • complexify (walkProfile A m k) = _
  rw [smul_smul, ← phase_add]
  congr 2
  ring


@[simp] theorem phase_star (q : ℝ) : star (phase q) = phase (-q) := by
  change (starRingEnd ℂ) (Complex.exp _) = Complex.exp _
  rw [← Complex.exp_conj]
  congr 1
  simp [map_mul, map_ofNat, Complex.conj_ofReal, Complex.conj_I]

@[simp] theorem complexify_conjTranspose {n : ℕ} (A : Mat n) :
    (complexify A).conjTranspose = complexify A.transpose := by
  ext i j
  simp [complexify, Matrix.conjTranspose_apply]

theorem magneticMatrix_hermitian {n : ℕ} (A : Mat n) (q : ℝ) :
    (magneticMatrix A q).IsHermitian := by
  unfold Matrix.IsHermitian magneticMatrix
  simp [Matrix.conjTranspose_add, Matrix.conjTranspose_smul, add_comm]

/-- Total in- plus out-weight; self loops contribute twice. -/
def magneticDegree {n : ℕ} (A : Mat n) : Fin n → ℝ :=
  fun i => ∑ j, (A i j + A j i)

/-- Unnormalized magnetic Laplacian D - M, with D independent of q. -/
def magneticLaplacian {n : ℕ} (A : Mat n) (q : ℝ) : CMat n :=
  complexify (Matrix.diagonal (magneticDegree A)) - magneticMatrix A q

theorem magneticLaplacian_hermitian {n : ℕ} (A : Mat n) (q : ℝ) :
    (magneticLaplacian A q).IsHermitian := by
  apply Matrix.IsHermitian.sub _ (magneticMatrix_hermitian A q)
  unfold Matrix.IsHermitian
  simp

@[simp] theorem magneticMatrix_zero {n : ℕ} (A : Mat n) :
    magneticMatrix A 0 = complexify (A + A.transpose) := by
  simp [magneticMatrix]

theorem walkProfile_two_one {n : ℕ} (A : Mat n) :
    walkProfile A 2 1 = A * A.transpose + A.transpose * A := by
  simp [walkProfile, words, wordProduct]



/-- A directed single edge, used to check the inverse formula's odd-length endpoint. -/
def directedSingleEdge : Mat 2 := !![0, 1; 0, 0]

/-- At m = 1 the displayed inverse formula (v1, equation 24) has an empty sum.
It would reconstruct A as half of A + Aᵀ. This concrete counterexample excludes
that unrestricted odd-length claim from our formalized results. -/
theorem inverse_v1_length_one_fails :
    complexify (walkProfile directedSingleEdge 1 1) ≠
      (1 / 2 : ℂ) • magneticMatrix directedSingleEdge 0 ^ 1 := by
  intro h
  have entry := congrArg (fun M : CMat 2 => M 0 1) h
  norm_num [walkProfile, words, wordProduct, directedSingleEdge,
    magneticMatrix_zero, complexify, Matrix.transpose_apply] at entry
  change (1 : ℂ) = 1 / 2 * (1 + 0) at entry
  norm_num at entry

end MagneticReference

-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md

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

noncomputable def cleanDefine_magnetic_phase_a916b64fe81e8c939d24  (q : ℝ) : ℂ :=
  (cleanNotation_complex_exponential_88b7620f1ee63bf4a99d (((cleanNotation_imaginary_unit_dd12d90e3449de458b3a) * (cleanNotation_complex_scalar_6201cf55b76113d50a6e (((2 * (cleanNotation_pi_3318d6df42e441010576)) * q))))))

noncomputable def cleanNotation_complex_matrix_8ce504730fda017d8908 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  Complex.ofRealHom.mapMatrix A

noncomputable def cleanNotation_real_transpose_110eeb37f2a3ed58943f {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  A.transpose

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

noncomputable def cleanNotation_Hermitian_1667495db879ea20ebaa {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  M.IsHermitian

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
  (cleanNotation_Hermitian_1667495db879ea20ebaa ((cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 (A) (q))))

/--
source: magneticformalization
reference: unnormalized D minus M convention
relationship: direct
-/
def magnetic_Laplacian_is_Hermitian : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (q : ℝ),
  (cleanNotation_Hermitian_1667495db879ea20ebaa ((cleanDefine_magnetic_Laplacian_c378e4a8cb113327c8a9 (A) (q))))

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
namespace CleanMagneticProofs
open MagneticReference

-- This bridges the Clean-authored exponential to the independently written Lean definition.
theorem phase_agrees (q : ℝ) : cleanDefine_magnetic_phase_a916b64fe81e8c939d24 q = phase q := by
  change Complex.exp (Complex.I * ((2 * Real.pi * q : ℝ) : ℂ)) =
    Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ))
  congr 1
  push_cast
  ring

theorem words_agree (m : ℕ) : (cleanDefine_direction_words_3510d7b104cf2b0c049c m).Perm (words m) := by
  change (List.replicate m [true, false]).sections.Perm (words m)
  induction m with
  | zero => simp [words, List.sections]
  | succ m ih =>
    simp only [List.replicate_succ, List.sections, List.map_cons, List.map_nil, words]
    apply (ih.flatMap_right (fun s => [true :: s, false :: s])).trans
    simpa only [← List.map_eq_flatMap] using
      (List.flatMap_append_perm (words m) (fun s => [true :: s])
        (fun s => [false :: s])).symm

theorem product_agrees {n : ℕ} (A : Mat n) (w : List Bool) :
    cleanDefine_word_product_1a376b4e684969322fac A w = wordProduct A w := rfl

theorem profile_agrees {n : ℕ} (A : Mat n) (m k : ℕ) :
    cleanDefine_walk_profile_46777589a8677b4798d1 A m k = walkProfile A m k := by
  have filters (l : List (List Bool)) :
      cleanNotation_filter_35fa41184b3a88d16472 (fun w => w.count true = k) l =
        l.filter (fun w => w.count true = k) := by
    unfold cleanNotation_filter_35fa41184b3a88d16472
    apply List.filter_congr
    intro w hw
    apply Bool.eq_iff_iff.mpr
    simp only [decide_eq_true_eq]
  change ((cleanNotation_filter_35fa41184b3a88d16472 (fun w => w.count true = k) (cleanDefine_direction_words_3510d7b104cf2b0c049c m)).map (wordProduct A)).sum = _
  rw [filters]
  exact (((words_agree m).filter (fun w => w.count true = k)).map (wordProduct A)).sum_eq

theorem fourier_agrees {n : ℕ} (A : Mat n) (m : ℕ) (q : ℝ) :
    cleanDefine_walk_Fourier_sum_cb5cf8d3bdceb3ae6707 A m q = walkFourierSum A m q := by
  change cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (-(q * m)) • (∑ k ∈ Finset.range (m + 1),
    cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (2 * q * k) • complexify (cleanDefine_walk_profile_46777589a8677b4798d1 A m k)) = _
  simp_rw [phase_agrees, profile_agrees]
  rfl

theorem adjacency_agrees {n : ℕ} (A : Mat n) (q : ℝ) :
    cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 A q = magneticMatrix A q := by
  change cleanDefine_magnetic_phase_a916b64fe81e8c939d24 q • complexify A +
    cleanDefine_magnetic_phase_a916b64fe81e8c939d24 (-q) • complexify A.transpose = _
  rw [phase_agrees, phase_agrees]
  rfl

theorem laplacian_agrees {n : ℕ} (A : Mat n) (q : ℝ) :
    cleanDefine_magnetic_Laplacian_c378e4a8cb113327c8a9 A q = magneticLaplacian A q := by
  change complexify (Matrix.diagonal (magneticDegree A)) - cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 A q = _
  rw [adjacency_agrees]
  rfl

theorem forward_transform : CleanStatements.magnetic_powers_encode_walk_profiles := by
  intro n A m q
  change cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 A q ^ m = cleanDefine_walk_Fourier_sum_cb5cf8d3bdceb3ae6707 A m q
  rw [adjacency_agrees, fourier_agrees]
  exact magnetic_power_fourier A m q

theorem adjacency_hermitian : CleanStatements.magnetic_adjacency_is_Hermitian := by
  intro n A q
  change (cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 A q).IsHermitian
  rw [adjacency_agrees]
  exact magneticMatrix_hermitian A q

theorem laplacian_hermitian : CleanStatements.magnetic_Laplacian_is_Hermitian := by
  intro n A q
  change (cleanDefine_magnetic_Laplacian_c378e4a8cb113327c8a9 A q).IsHermitian
  rw [laplacian_agrees]
  exact magneticLaplacian_hermitian A q

theorem zero_potential : CleanStatements.zero_potential_symmetrizes_adjacency := by
  intro n A
  change cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 A 0 = complexify (A + A.transpose)
  rw [adjacency_agrees]
  exact magneticMatrix_zero A

theorem mixed_walk : CleanStatements.two_step_mixed_walk_profile := by
  intro n A
  change cleanDefine_walk_profile_46777589a8677b4798d1 A 2 1 = A * A.transpose + A.transpose * A
  rw [profile_agrees]
  exact walkProfile_two_one A
theorem inverse_endpoint_counterexample :
    CleanStatements.odd_length_inverse_endpoint_counterexample := by
  change complexify (cleanDefine_walk_profile_46777589a8677b4798d1 directedSingleEdge 1 1) ≠
    (((1 / 2 : ℝ) : ℂ)) • cleanDefine_magnetic_adjacency_0d1d57e2d9820070fae8 directedSingleEdge 0
  rw [adjacency_agrees, profile_agrees]
  simpa using inverse_v1_length_one_fails
end CleanMagneticProofs

#print axioms CleanMagneticProofs.forward_transform
