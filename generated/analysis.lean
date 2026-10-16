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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: Real.exp_pos
relationship: specialized
-/
def exponential_positive : Prop :=
  ∀ (x : ℝ),
  (0 < (cleanNotation_7915ccfe7848eb4fc048 (x)))

/--
source: mathlib
reference: Real.exp_ne_zero
relationship: specialized
-/
def exponential_nonzero : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_7915ccfe7848eb4fc048 (x)) ≠ 0)

/--
source: mathlib
reference: Real.exp_add
relationship: specialized
-/
def exponential_sum : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_7915ccfe7848eb4fc048 ((x + y))) = ((cleanNotation_7915ccfe7848eb4fc048 (x)) * (cleanNotation_7915ccfe7848eb4fc048 (y))))

/--
source: mathlib
reference: Real.exp_sub
relationship: specialized
-/
def exponential_difference : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_7915ccfe7848eb4fc048 ((x - y))) = ((cleanNotation_7915ccfe7848eb4fc048 (x)) / (cleanNotation_7915ccfe7848eb4fc048 (y))))

/--
source: mathlib
reference: Real.log_exp
relationship: specialized
-/
def logarithm_exponential : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_3a02e02cafc4602764f4 ((cleanNotation_7915ccfe7848eb4fc048 (x)))) = x)

/--
source: mathlib
reference: Real.exp_log
relationship: specialized
-/
def exponential_logarithm : Prop :=
  ∀ (x : ℝ),
  ∀ (positive : (0 < x)),
  ((cleanNotation_7915ccfe7848eb4fc048 ((cleanNotation_3a02e02cafc4602764f4 (x)))) = x)

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def logarithm_product : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonzero_x : (x ≠ 0)),
  ∀ (nonzero_y : (y ≠ 0)),
  ((cleanNotation_3a02e02cafc4602764f4 ((x * y))) = ((cleanNotation_3a02e02cafc4602764f4 (x)) + (cleanNotation_3a02e02cafc4602764f4 (y))))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def logarithm_quotient : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonzero_x : (x ≠ 0)),
  ∀ (nonzero_y : (y ≠ 0)),
  ((cleanNotation_3a02e02cafc4602764f4 ((x / y))) = ((cleanNotation_3a02e02cafc4602764f4 (x)) - (cleanNotation_3a02e02cafc4602764f4 (y))))

/--
source: mathlib
reference: Real.sqrt_nonneg
relationship: specialized
-/
def square_root_nonnegative : Prop :=
  ∀ (x : ℝ),
  (0 ≤ (cleanNotation_bab2de5a3de5967c5bae (x)))

/--
source: mathlib
reference: Real.sq_sqrt
relationship: specialized
-/
def square_of_square_root : Prop :=
  ∀ (x : ℝ),
  ∀ (nonnegative : (0 ≤ x)),
  (((cleanNotation_bab2de5a3de5967c5bae (x)) ^ 2) = x)

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: specialized
-/
def square_root_of_square : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_bab2de5a3de5967c5bae ((x ^ 2))) = (cleanNotation_17502ff021fd42a8ce97 (x)))

/--
source: mathlib
reference: Real.sqrt_mul
relationship: specialized
-/
def square_root_product : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonnegative : (0 ≤ x)),
  ((cleanNotation_bab2de5a3de5967c5bae ((x * y))) = ((cleanNotation_bab2de5a3de5967c5bae (x)) * (cleanNotation_bab2de5a3de5967c5bae (y))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: specialized
-/
def trigonometric_identity : Prop :=
  ∀ (x : ℝ),
  ((((cleanNotation_8679b27b6c150044959d (x)) ^ 2) + ((cleanNotation_1efb67bf51334208e223 (x)) ^ 2)) = 1)

/--
source: mathlib
reference: Real.sin_add
relationship: specialized
-/
def sine_addition : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_8679b27b6c150044959d ((x + y))) = (((cleanNotation_8679b27b6c150044959d (x)) * (cleanNotation_1efb67bf51334208e223 (y))) + ((cleanNotation_1efb67bf51334208e223 (x)) * (cleanNotation_8679b27b6c150044959d (y)))))

/--
source: mathlib
reference: Real.cos_add
relationship: specialized
-/
def cosine_addition : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_1efb67bf51334208e223 ((x + y))) = (((cleanNotation_1efb67bf51334208e223 (x)) * (cleanNotation_1efb67bf51334208e223 (y))) - ((cleanNotation_8679b27b6c150044959d (x)) * (cleanNotation_8679b27b6c150044959d (y)))))

/--
source: mathlib
reference: Real.sin_neg
relationship: specialized
-/
def sine_odd : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_8679b27b6c150044959d ((-x))) = (-(cleanNotation_8679b27b6c150044959d (x))))

/--
source: mathlib
reference: Real.cos_neg
relationship: specialized
-/
def cosine_even : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_1efb67bf51334208e223 ((-x))) = (cleanNotation_1efb67bf51334208e223 (x)))

/--
source: mathlib
reference: Continuous.comp
relationship: specialized
-/
def continuous_composition : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (cleanNotation_723e95f1cf7739171880 (f))),
  ∀ (hg : (cleanNotation_723e95f1cf7739171880 (g))),
  (cleanNotation_723e95f1cf7739171880 ((cleanNotation_7439357a91f0e39bc193 (f) (g))))

/--
source: mathlib
reference: Continuous.add
relationship: specialized
-/
def continuous_sum : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (cleanNotation_723e95f1cf7739171880 (f))),
  ∀ (hg : (cleanNotation_723e95f1cf7739171880 (g))),
  (cleanNotation_723e95f1cf7739171880 ((f + g)))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def continuous_product : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (cleanNotation_723e95f1cf7739171880 (f))),
  ∀ (hg : (cleanNotation_723e95f1cf7739171880 (g))),
  (cleanNotation_723e95f1cf7739171880 ((f * g)))

end CleanStatements
