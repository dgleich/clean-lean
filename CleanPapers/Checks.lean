import CleanPapers.Definitions
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

noncomputable section
open scoped BigOperators
open CleanPapers

-- These checks distinguish ordered words from an invalid commutative binomial expansion.
example {n : ℕ} (A : Mat n) : walkProfile A 0 0 = 1 := by
  simp [walkProfile, words, wordProduct]
example {n : ℕ} (A : Mat n) : walkProfile A 0 1 = 0 := by
  simp [walkProfile, words]
example {n : ℕ} (A : Mat n) : walkProfile A 2 1 = A * A.transpose + A.transpose * A := by
  simp [walkProfile, words, wordProduct]
example {n : ℕ} (A : Mat n) : walkProfile A 2 3 = 0 := by
  simp [walkProfile, words]

-- The explicitly constructed adjoint satisfies its defining identity.
example {n m : ℕ} (B : Measurements n m) (X : Mat n) (y : Fin m → ℝ) :
    frobenius (measurementAdjoint B y) X = ∑ k, y k * measurement B X k := by
  simp only [CleanPapers.frobenius, measurementAdjoint, measurement, Matrix.sum_apply,
    Matrix.smul_apply, smul_eq_mul, Finset.sum_mul, Finset.mul_sum, mul_assoc]
  calc
    _ = ∑ i, ∑ k, ∑ j, y k * (B k i j * X i j) := by
      apply Finset.sum_congr rfl
      intro i _
      exact Finset.sum_comm
    _ = _ := Finset.sum_comm

-- A single edge has volume 2 and cut conductance 1.
example : totalVolume (⊤ : SimpleGraph (Fin 2)) = 2 := by
  norm_num [totalVolume, volume, degree, adjacency, Fin.sum_univ_two]
example : cutConductance (⊤ : SimpleGraph (Fin 2)) {0} = 1 := by
  norm_num [cutConductance, cut, volume, degree, adjacency, Fin.sum_univ_two,
    show ({0} : Finset (Fin 2))ᶜ = {1} by decide]

-- Empty optimization domains have the documented fallback.
example : conductance (⊥ : SimpleGraph (Fin 0)) (1/2) = 0 := by
  simp [conductance, admissibleCut, volume, degree, adjacency]

-- The readable interpolation has exactly the paper's coefficients.
example (μ φ ψ : ℝ) (hμ : 0 < μ) (hhalf : μ ≤ 1/2) :
    let t := μ^2 / (μ^2 + 1/2 - μ)
    t * φ + (1-t) * ψ = (μ^2 * φ + (1/2 - μ) * ψ) / (μ^2 + 1/2 - μ) := by
  dsimp
  have hden : μ^2 + (1/2 : ℝ) - μ ≠ 0 := by
    have hsq : 0 < μ^2 := sq_pos_of_pos hμ
    nlinarith
  generalize hd : μ^2 + (1/2 : ℝ) - μ = d at *
  field_simp
  rw [← hd]
  ring
