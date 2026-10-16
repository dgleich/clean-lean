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
  (0 < (Real.exp x))

/--
source: mathlib
reference: Real.exp_ne_zero
relationship: specialized
-/
def exponential_nonzero : Prop :=
  ∀ (x : ℝ),
  ((Real.exp x) ≠ 0)

/--
source: mathlib
reference: Real.exp_add
relationship: specialized
-/
def exponential_sum : Prop :=
  ∀ (x y : ℝ),
  ((Real.exp (x + y)) = ((Real.exp x) * (Real.exp y)))

/--
source: mathlib
reference: Real.exp_sub
relationship: specialized
-/
def exponential_difference : Prop :=
  ∀ (x y : ℝ),
  ((Real.exp (x - y)) = ((Real.exp x) / (Real.exp y)))

/--
source: mathlib
reference: Real.log_exp
relationship: specialized
-/
def logarithm_exponential : Prop :=
  ∀ (x : ℝ),
  ((Real.log (Real.exp x)) = x)

/--
source: mathlib
reference: Real.exp_log
relationship: specialized
-/
def exponential_logarithm : Prop :=
  ∀ (x : ℝ),
  ∀ (positive : (0 < x)),
  ((Real.exp (Real.log x)) = x)

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def logarithm_product : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonzero_x : (x ≠ 0)),
  ∀ (nonzero_y : (y ≠ 0)),
  ((Real.log (x * y)) = ((Real.log x) + (Real.log y)))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def logarithm_quotient : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonzero_x : (x ≠ 0)),
  ∀ (nonzero_y : (y ≠ 0)),
  ((Real.log (x / y)) = ((Real.log x) - (Real.log y)))

/--
source: mathlib
reference: Real.sqrt_nonneg
relationship: specialized
-/
def square_root_nonnegative : Prop :=
  ∀ (x : ℝ),
  (0 ≤ (Real.sqrt x))

/--
source: mathlib
reference: Real.sq_sqrt
relationship: specialized
-/
def square_of_square_root : Prop :=
  ∀ (x : ℝ),
  ∀ (nonnegative : (0 ≤ x)),
  (((Real.sqrt x) ^ 2) = x)

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: specialized
-/
def square_root_of_square : Prop :=
  ∀ (x : ℝ),
  ((Real.sqrt (x ^ 2)) = (abs x))

/--
source: mathlib
reference: Real.sqrt_mul
relationship: specialized
-/
def square_root_product : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonnegative : (0 ≤ x)),
  ((Real.sqrt (x * y)) = ((Real.sqrt x) * (Real.sqrt y)))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: specialized
-/
def trigonometric_identity : Prop :=
  ∀ (x : ℝ),
  ((((Real.sin x) ^ 2) + ((Real.cos x) ^ 2)) = 1)

/--
source: mathlib
reference: Real.sin_add
relationship: specialized
-/
def sine_addition : Prop :=
  ∀ (x y : ℝ),
  ((Real.sin (x + y)) = (((Real.sin x) * (Real.cos y)) + ((Real.cos x) * (Real.sin y))))

/--
source: mathlib
reference: Real.cos_add
relationship: specialized
-/
def cosine_addition : Prop :=
  ∀ (x y : ℝ),
  ((Real.cos (x + y)) = (((Real.cos x) * (Real.cos y)) - ((Real.sin x) * (Real.sin y))))

/--
source: mathlib
reference: Real.sin_neg
relationship: specialized
-/
def sine_odd : Prop :=
  ∀ (x : ℝ),
  ((Real.sin (-x)) = (-(Real.sin x)))

/--
source: mathlib
reference: Real.cos_neg
relationship: specialized
-/
def cosine_even : Prop :=
  ∀ (x : ℝ),
  ((Real.cos (-x)) = (Real.cos x))

/--
source: mathlib
reference: Continuous.comp
relationship: specialized
-/
def continuous_composition : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (Continuous f)),
  ∀ (hg : (Continuous g)),
  (Continuous ((f) ∘ (g)))

/--
source: mathlib
reference: Continuous.add
relationship: specialized
-/
def continuous_sum : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (Continuous f)),
  ∀ (hg : (Continuous g)),
  (Continuous (f + g))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def continuous_product : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (Continuous f)),
  ∀ (hg : (Continuous g)),
  (Continuous (f * g))

end CleanStatements
