-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

noncomputable section
open scoped BigOperators
namespace MagneticStatements
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


def magneticDegree {n : ℕ} (A : Mat n) : Fin n → ℝ :=
  fun i => ∑ j, (A i j + A j i)
def magneticLaplacian {n : ℕ} (A : Mat n) (q : ℝ) : CMat n :=
  complexify (Matrix.diagonal (magneticDegree A)) - magneticMatrix A q
def directedSingleEdge : Mat 2 := !![0, 1; 0, 0]

-- Proposition declarations are statements, not assumed or unfinished proofs.
def forward_transform : Prop := ∀ (n : ℕ) (A : Mat n) (m : ℕ) (q : ℝ),
  magneticMatrix A q ^ m = walkFourierSum A m q
def adjacency_hermitian : Prop := ∀ (n : ℕ) (A : Mat n) (q : ℝ),
  (magneticMatrix A q).IsHermitian
def laplacian_hermitian : Prop := ∀ (n : ℕ) (A : Mat n) (q : ℝ),
  (magneticLaplacian A q).IsHermitian
def zero_potential : Prop := ∀ (n : ℕ) (A : Mat n),
  magneticMatrix A 0 = complexify (A + A.transpose)
def mixed_walk : Prop := ∀ (n : ℕ) (A : Mat n),
  walkProfile A 2 1 = A * A.transpose + A.transpose * A
def inverse_endpoint_counterexample : Prop :=
  complexify (walkProfile directedSingleEdge 1 1) ≠
    (1 / 2 : ℂ) • magneticMatrix directedSingleEdge 0
end MagneticStatements
