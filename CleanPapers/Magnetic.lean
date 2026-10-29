-- generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md
import CleanPapers.Definitions
import Mathlib.Algebra.BigOperators.Ring.List
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

noncomputable section
open scoped BigOperators
namespace CleanPapers

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

end CleanPapers

-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
