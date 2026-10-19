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

noncomputable def cleanNotation_7915ccfe7848eb4fc048  (x0 : ℝ) : ℝ :=
  Real.exp x0

noncomputable def cleanNotation_3a02e02cafc4602764f4  (x0 : ℝ) : ℝ :=
  Real.log x0

noncomputable def cleanNotation_bab2de5a3de5967c5bae  (x0 : ℝ) : ℝ :=
  Real.sqrt x0

noncomputable def cleanNotation_8679b27b6c150044959d  (x0 : ℝ) : ℝ :=
  Real.sin x0

noncomputable def cleanNotation_1efb67bf51334208e223  (x0 : ℝ) : ℝ :=
  Real.cos x0

noncomputable def cleanNotation_17502ff021fd42a8ce97  (x0 : ℝ) : ℝ :=
  abs x0

noncomputable def cleanNotation_723e95f1cf7739171880  (x0 : (ℝ) → (ℝ)) : Prop :=
  Continuous x0

noncomputable def cleanNotation_271d108540216294c77e  (x0 : (ℝ) → (ℝ)) : Prop :=
  Differentiable ℝ x0

noncomputable def cleanNotation_7439357a91f0e39bc193  (x0 : (ℝ) → (ℝ)) (x1 : (ℝ) → (ℝ)) : (ℝ) → (ℝ) :=
  (x0) ∘ (x1)

noncomputable def cleanDefine_7aae69f1485be0941444  (x : ℝ) : ℝ :=
  (x ^ 2)

noncomputable def cleanDefine_cfbca9823d9cf5d249c0  (x : ℝ) (y : ℝ) : ℝ :=
  (cleanDefine_7aae69f1485be0941444 ((x - y)))

noncomputable def cleanDefine_ce4b7f714db66ceb296a  (x : ℝ) : ℝ :=
  ((cleanDefine_7aae69f1485be0941444 ((cleanNotation_8679b27b6c150044959d (x)))) + (cleanDefine_7aae69f1485be0941444 ((cleanNotation_1efb67bf51334208e223 (x)))))

noncomputable def cleanNotation_7326e962c725ce45b521 {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  Matrix.det x0

noncomputable def cleanNotation_77213551dad9a763052a {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  Matrix.trace x0

noncomputable def cleanNotation_ec7d2405c8c143132e84 {m : ℕ} {n : ℕ} (x0 : Matrix (Fin m) (Fin n) ℂ) : Matrix (Fin n) (Fin m) ℂ :=
  Matrix.transpose x0

noncomputable def cleanNotation_60f5a255d86c84175527 {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  (x0)⁻¹

noncomputable def cleanDefine_dec87a8766301eb4176d {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (B : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  ((A * B) - (B * A))

noncomputable def cleanDefine_59c5fc3d3e7ab2ab3d9b {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  (A * A)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

end CleanStatements


open Lean Elab Command
-- Strip only metadata and binder display names. Retain binderInfo, universes,
-- constants, implicit/instance/proof applications, and every other constructor.
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
private def sameTarget (a b : Name) : CommandElabM Bool := do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a | throwError "Missing definition {a}"
  let some (.defnInfo y) := env.find? b | throwError "Missing definition {b}"
  return x.levelParams == y.levelParams &&
    Expr.equal (canonical x.type) (canonical y.type) &&
    Expr.equal (canonical x.value) (canonical y.value)
elab "assert_same_target " a:ident b:ident : command => do
  unless ← sameTarget a.getId b.getId do
    throwError "Canonical target mismatch: {a} versus {b}"
elab "assert_different_target " a:ident b:ident : command => do
  if ← sameTarget a.getId b.getId then
    throwError "Comparator failed to distinguish {a} from {b}"
-- Guard against accidentally weakening the comparator to Expr.eqv/isDefEq.
def explicit_binder (x : Nat) := x
def implicit_binder {x : Nat} := x
def reduced_identity (x : Nat) := (fun y => y) x
assert_different_target explicit_binder implicit_binder
assert_different_target explicit_binder reduced_identity

noncomputable def expected_square (a : ℝ) : ℝ := a ^ (2 : ℕ)
assert_same_target cleanDefine_7aae69f1485be0941444 expected_square
noncomputable def expected_commutator {k : ℕ} (X Y : Matrix (Fin k) (Fin k) ℂ) : Matrix (Fin k) (Fin k) ℂ := X * Y - Y * X
assert_same_target cleanDefine_dec87a8766301eb4176d expected_commutator
noncomputable def expected_matrix_square {k : ℕ} (X : Matrix (Fin k) (Fin k) ℂ) : Matrix (Fin k) (Fin k) ℂ := X * X
assert_same_target cleanDefine_59c5fc3d3e7ab2ab3d9b expected_matrix_square
