import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt

/-! Explicit mathematical dependencies for the three adapted paper statements.
No paper theorem is assumed here. Source locators are in library/papers.clean.
Definitions use finite labelled vertices and real matrices. -/
noncomputable section
open scoped BigOperators
namespace CleanPapers
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

/-- Adjacency is explicitly converted to a real 0/1 matrix. -/
def adjacency {n : ℕ} (G : SimpleGraph (Fin n)) : Mat n := by
  classical
  exact fun i j => if G.Adj i j then 1 else 0

def degree {n : ℕ} (G : SimpleGraph (Fin n)) (i : Fin n) : ℝ :=
  ∑ j, adjacency G i j

def volume {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : ℝ :=
  ∑ i ∈ S, degree G i

def totalVolume {n : ℕ} (G : SimpleGraph (Fin n)) : ℝ := volume G Finset.univ

/-- Count each crossing edge once, from S to its complement. -/
def cut {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : ℝ :=
  ∑ i ∈ S, ∑ j ∈ Sᶜ, adjacency G i j

def admissibleCut {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ)
    (S : Finset (Fin n)) : Prop :=
  0 < volume G S ∧ 0 < volume G Sᶜ ∧
  μ * totalVolume G ≤ volume G S ∧ volume G S ≤ (1 - μ) * totalVolume G

def cutConductance {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : ℝ :=
  cut G S / min (volume G S) (volume G Sᶜ)

/-- Infimum over admissible cuts. Empty domains explicitly return zero.
For a nonempty finite domain this is its minimum. -/
def conductance {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) : ℝ := by
  classical
  exact if ∃ S, admissibleCut G μ S then
    sInf {r | ∃ S, admissibleCut G μ S ∧ r = cutConductance G S} else 0

def laplacian {n : ℕ} (G : SimpleGraph (Fin n)) : Mat n :=
  Matrix.diagonal (degree G) - adjacency G

def quadratic {n : ℕ} (M : Mat n) (x : Fin n → ℝ) : ℝ :=
  ∑ i, ∑ j, x i * M i j * x j

def spectralFeasible {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ)
    (x : Fin n → ℝ) : Prop :=
  (∑ i, x i * degree G i) = 0 ∧ (∑ i, degree G i * (x i)^2) = 1 ∧
  ∀ i, Real.sqrt (μ / ((1 - μ) * totalVolume G)) ≤ |x i| ∧
    |x i| ≤ Real.sqrt ((1 - μ) / (μ * totalVolume G))

/-- The constrained optimization value from equation (5), for μ > 0.
An empty domain explicitly returns zero; the theorem's domain is nonempty.
Using sInf does not itself assert existence of an optimizer. -/
def spectralMinimum {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) : ℝ := by
  classical
  exact if ∃ x, spectralFeasible G μ x then
    sInf {r | ∃ x, spectralFeasible G μ x ∧ r = quadratic (laplacian G) x} else 0

def frobenius {n : ℕ} (C X : Mat n) : ℝ := ∑ i, ∑ j, C i j * X i j

/-- A linear measurement map is represented by its symmetric coefficient matrices. -/
abbrev Measurements (n m : ℕ) := Fin m → Mat n

def measurementsSymmetric {n m : ℕ} (B : Measurements n m) : Prop :=
  ∀ k, (B k).IsSymm

def measurement {n m : ℕ} (B : Measurements n m) (X : Mat n) : Fin m → ℝ :=
  fun k => frobenius (B k) X

/-- Adjoint for the Frobenius and Euclidean products, with no arbitrary choice. -/
def measurementAdjoint {n m : ℕ} (B : Measurements n m) (y : Fin m → ℝ) : Mat n :=
  ∑ k, y k • B k

def feasible {n m : ℕ} (B : Measurements n m) (b : Fin m → ℝ)
    (α : ℝ) (X : Mat n) : Prop :=
  X.PosSemidef ∧ X.trace ≤ α ∧ measurement B X = b

def minimizes {n m : ℕ} (C : Mat n) (B : Measurements n m)
    (b : Fin m → ℝ) (α : ℝ) (X : Mat n) : Prop :=
  feasible B b α X ∧ ∀ Z, feasible B b α Z → frobenius C X ≤ frobenius C Z

/-- Real eigenvalues, defined by their nonzero eigenvectors. -/
def realEigenvalues {n : ℕ} (M : Mat n) : Set ℝ :=
  {r | ∃ v : Fin n → ℝ, v ≠ 0 ∧ M.mulVec v = r • v}

/-- On positive-dimensional symmetric matrices the real spectrum is finite and
nonempty, so its infimum is its smallest member. Outside that domain we return
zero if the real spectrum is empty. No spectral theorem is assumed as an axiom. -/
def smallestEigenvalue {n : ℕ} (M : Mat n) : ℝ := by
  classical
  exact if (realEigenvalues M).Nonempty then sInf (realEigenvalues M) else 0

def dualBound {n m : ℕ} (C : Mat n) (B : Measurements n m)
    (b y : Fin m → ℝ) (α : ℝ) : ℝ :=
  (∑ k, y k * b k) + α * min (smallestEigenvalue (C - measurementAdjoint B y)) 0
end CleanPapers

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
