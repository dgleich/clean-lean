/- These prove translation fidelity to explicit propositions, NOT their truth. -/
open scoped BigOperators
open CleanPapers

example : CleanStatements.magnetic_powers_encode_walk_profiles =
    (∀ (n : ℕ), n > 0 → ∀ (A : Mat n) (m : ℕ) (q : ℝ),
      (phase q • complexify A + phase (-q) • complexify A.transpose)^m =
      phase (-(q * m)) • ∑ k ∈ Finset.range (m + 1),
        phase (2 * q * k) • complexify (walkProfile A m k)) := rfl

example : CleanStatements.size_specific_Cheeger_inequality =
    (∀ (n : ℕ) (G : SimpleGraph (Fin n)) (μ : ℝ),
      G.Connected → n ≥ 2 → (0 < μ ∧ μ ≤ 1/2) →
      (∃ S, admissibleCut G μ S) →
      let t := μ^2 / (μ^2 + 1/2 - μ)
      (t * conductance G μ + (1-t) * conductance G 0)^2 / 4 ≤ spectralMinimum G μ ∧
        spectralMinimum G μ ≤ 2 * conductance G μ) := rfl

example : CleanStatements.trace_bound_gives_a_suboptimality_certificate =
    (∀ (n m : ℕ), (n > 0 ∧ m > 0) →
      ∀ (C X Z : Mat n) (B : Measurements n m) (b y : Fin m → ℝ) (α : ℝ),
      C.IsSymm → (∀ k, (B k).IsSymm) → α ≥ 0 →
      (X.PosSemidef ∧ X.trace ≤ α ∧ measurement B X = b) →
      ((Z.PosSemidef ∧ Z.trace ≤ α ∧ measurement B Z = b) ∧
        ∀ W, (W.PosSemidef ∧ W.trace ≤ α ∧ measurement B W = b) →
          frobenius C Z ≤ frobenius C W) →
      frobenius C X - frobenius C Z ≤ frobenius C X -
        ((∑ k, y k * b k) + α * min
          (smallestEigenvalue (C - ∑ k, y k • B k)) 0)) := rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
