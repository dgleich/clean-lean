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
import CleanPapers.Definitions

noncomputable def cleanType_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanType_ee28aab45ec345bdec5d (n : Nat) (m : Nat) : Type :=
  CleanPapers.Measurements n m

noncomputable def cleanNotation_64c29fce00bf2e068583 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (m : ℕ) (k : ℕ) : Matrix (Fin n) (Fin n) ℝ :=
  CleanPapers.walkProfile A m k

noncomputable def cleanNotation_7e71ff9ce8e5fb9a3ecc {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  CleanPapers.magneticMatrix A q

noncomputable def cleanNotation_fe049b47ad3bd900dad8 {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) (m : ℕ) : Matrix (Fin n) (Fin n) ℂ :=
  M ^ m

noncomputable def cleanNotation_95c17a1962f2591077ef {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (m : ℕ) (q : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  CleanPapers.walkFourierSum A m q

noncomputable def cleanNotation_62464f562221e73033dc {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  G.Connected

noncomputable def cleanNotation_832d57ecf03758266826 {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) : Prop :=
  ∃ S, CleanPapers.admissibleCut G μ S

noncomputable def cleanNotation_b14cb25b6df298f1eaff {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) : ℝ :=
  CleanPapers.conductance G μ

noncomputable def cleanNotation_bb3d42e457aba48f4082 {n : ℕ} (G : SimpleGraph (Fin n)) : ℝ :=
  CleanPapers.conductance G 0

noncomputable def cleanNotation_141734dfa77b823d61c7 {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) : ℝ :=
  CleanPapers.spectralMinimum G μ

noncomputable def cleanNotation_64d8ee79f9785328e87e {n : ℕ} (C : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  C.IsSymm

noncomputable def cleanNotation_d53512bf4073b121644a {n : ℕ} {m : ℕ} (B : CleanPapers.Measurements n m) : Prop :=
  CleanPapers.measurementsSymmetric B

noncomputable def cleanNotation_13e0c02e296fcc8bb789 {n : ℕ} {m : ℕ} (B : CleanPapers.Measurements n m) (b : Fin m → ℝ) (α : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  CleanPapers.feasible B b α X

noncomputable def cleanNotation_f9615cff2c2349a72b76 {n : ℕ} {m : ℕ} (C : Matrix (Fin n) (Fin n) ℝ) (B : CleanPapers.Measurements n m) (b : Fin m → ℝ) (α : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  CleanPapers.minimizes C B b α X

noncomputable def cleanNotation_6c3d3df751586b8dd7e6 {n : ℕ} (C : Matrix (Fin n) (Fin n) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  CleanPapers.frobenius C X

noncomputable def cleanNotation_c8ce030c21b0ee9d6ab8 {n : ℕ} {m : ℕ} (C : Matrix (Fin n) (Fin n) ℝ) (B : CleanPapers.Measurements n m) (b : Fin m → ℝ) (y : Fin m → ℝ) (α : ℝ) : ℝ :=
  CleanPapers.dualBound C B b y α

noncomputable def cleanType_cbde7af2cf83b890004b (n : Nat) : Type :=
  Finset (Fin n)

noncomputable def cleanNotation_5e3fda7454a1d47cb4bb {n : ℕ} (G : SimpleGraph (Fin n)) (v : Fin n) : ℝ :=
  CleanPapers.degree G v

noncomputable def cleanNotation_48d0160964e13629208b {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : ℝ :=
  CleanPapers.volume G S

noncomputable def cleanNotation_f92878923c7cb8b54af8 {n : ℕ} (G : SimpleGraph (Fin n)) : ℝ :=
  CleanPapers.totalVolume G

noncomputable def cleanNotation_8630c6d2f7ad31522df7 {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : ℝ :=
  CleanPapers.cut G S

noncomputable def cleanNotation_57c4f84df479a4696e87 {n : ℕ} (G : SimpleGraph (Fin n)) (S : Finset (Fin n)) : ℝ :=
  CleanPapers.cutConductance G S

noncomputable def cleanNotation_c34153928f35abe64067 {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) (S : Finset (Fin n)) : Prop :=
  CleanPapers.admissibleCut G μ S

noncomputable def cleanNotation_142ff6f75eaf704d61c8 {n : ℕ} (G : SimpleGraph (Fin n)) : Matrix (Fin n) (Fin n) ℝ :=
  CleanPapers.laplacian G

noncomputable def cleanNotation_71b71b3cf1cbde6ddaa3 {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ) (x : Fin n → ℝ) : ℝ :=
  CleanPapers.quadratic M x

noncomputable def cleanNotation_f8fdfddcc2a008a8a97d {n : ℕ} (G : SimpleGraph (Fin n)) (μ : ℝ) (x : Fin n → ℝ) : Prop :=
  CleanPapers.spectralFeasible G μ x

noncomputable def cleanNotation_9fa08f2478738c1dfc54 {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  M.PosSemidef

noncomputable def cleanNotation_75a61c73333cfc928fce {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  M.trace

noncomputable def cleanNotation_bd1c058dfcbd5a664464 {n : ℕ} {m : ℕ} (B : CleanPapers.Measurements n m) (X : Matrix (Fin n) (Fin n) ℝ) : Fin m → ℝ :=
  CleanPapers.measurement B X

noncomputable def cleanNotation_d220b562b0cd59d9ccbe {n : ℕ} {m : ℕ} (B : CleanPapers.Measurements n m) (y : Fin m → ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  CleanPapers.measurementAdjoint B y

noncomputable def cleanNotation_232239c936eb834a3d94 {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  CleanPapers.smallestEigenvalue M


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: magnetic2025
reference: Supplement S.II, Theorem 1
relationship: adapted
scope: forward transform
-/
def magnetic_powers_encode_walk_profiles : Prop :=
  ∀ (n : ℕ),
  ∀ (positive : (n > 0)),
  ∀ (A : Matrix (Fin n) (Fin n) ℝ),
  ∀ (m : ℕ),
  ∀ (q : ℝ),
  let M : Matrix (Fin n) (Fin n) ℂ := (cleanNotation_7e71ff9ce8e5fb9a3ecc (A) (q));
  ((cleanNotation_fe049b47ad3bd900dad8 (M) (m)) = (cleanNotation_95c17a1962f2591077ef (A) (m) (q)))

/--
source: cheeger2026
reference: Theorem 3.1
relationship: adapted
scope: connected simple graphs and positive mu
-/
def size_specific_Cheeger_inequality : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (μ : ℝ),
  ∀ (connectivity : (cleanNotation_62464f562221e73033dc (G))),
  ∀ (nontrivial : (n ≥ 2)),
  ∀ (range : ((0 < μ) ∧ (μ ≤ (1 / 2)))),
  ∀ (admissibility : (cleanNotation_832d57ecf03758266826 (G) (μ))),
  let φ : ℝ := (cleanNotation_b14cb25b6df298f1eaff (G) (μ));
  let ψ : ℝ := (cleanNotation_bb3d42e457aba48f4082 (G));
  let spectral : ℝ := (cleanNotation_141734dfa77b823d61c7 (G) (μ));
  let t : ℝ := ((μ ^ 2) / (((μ ^ 2) + (1 / 2)) - μ));
  ((((((t * φ) + ((1 - t) * ψ)) ^ 2) / 4) ≤ spectral) ∧ (spectral ≤ (2 * φ)))

/--
source: sdplr2026
reference: Corollary 2, equation (3)
relationship: adapted
scope: symmetric coefficient representation of the measurement map
-/
def trace_bound_gives_a_suboptimality_certificate : Prop :=
  ∀ (n m : ℕ),
  ∀ (dimensions : ((n > 0) ∧ (m > 0))),
  ∀ (C X Z : Matrix (Fin n) (Fin n) ℝ),
  ∀ (B : CleanPapers.Measurements n m),
  ∀ (b y : Fin m → ℝ),
  ∀ (α : ℝ),
  ∀ (cost : (cleanNotation_64d8ee79f9785328e87e (C))),
  ∀ (measurements : (cleanNotation_d53512bf4073b121644a (B))),
  ∀ (bound : (α ≥ 0)),
  ∀ (candidate : (cleanNotation_13e0c02e296fcc8bb789 (B) (b) (α) (X))),
  ∀ (optimizer : (cleanNotation_f9615cff2c2349a72b76 (C) (B) (b) (α) (Z))),
  let d : ℝ := (cleanNotation_c8ce030c21b0ee9d6ab8 (C) (B) (b) (y) (α));
  (((cleanNotation_6c3d3df751586b8dd7e6 (C) (X)) - (cleanNotation_6c3d3df751586b8dd7e6 (C) (Z))) ≤ ((cleanNotation_6c3d3df751586b8dd7e6 (C) (X)) - d))

end CleanStatements
