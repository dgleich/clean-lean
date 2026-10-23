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

noncomputable def cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_exp_7915ccfe7848eb4fc048  (x0 : ℝ) : ℝ :=
  Real.exp x0

noncomputable def cleanNotation_log_3a02e02cafc4602764f4  (x0 : ℝ) : ℝ :=
  Real.log x0

noncomputable def cleanNotation_sqrt_bab2de5a3de5967c5bae  (x0 : ℝ) : ℝ :=
  Real.sqrt x0

noncomputable def cleanNotation_sin_8679b27b6c150044959d  (x0 : ℝ) : ℝ :=
  Real.sin x0

noncomputable def cleanNotation_cos_1efb67bf51334208e223  (x0 : ℝ) : ℝ :=
  Real.cos x0

noncomputable def cleanNotation_abs_17502ff021fd42a8ce97  (x0 : ℝ) : ℝ :=
  abs x0

noncomputable def cleanNotation_continuous_723e95f1cf7739171880  (x0 : (ℝ) → (ℝ)) : Prop :=
  Continuous x0

noncomputable def cleanNotation_differentiable_271d108540216294c77e  (x0 : (ℝ) → (ℝ)) : Prop :=
  Differentiable ℝ x0

noncomputable def cleanNotation_compose_7439357a91f0e39bc193  (x0 : (ℝ) → (ℝ)) (x1 : (ℝ) → (ℝ)) : (ℝ) → (ℝ) :=
  (x0) ∘ (x1)

noncomputable def cleanDefine_square_7aae69f1485be0941444  (x : ℝ) : ℝ :=
  (x ^ 2)

noncomputable def cleanDefine_squared_distance_efa301df5f4a584cafc8  (x : ℝ) (y : ℝ) : ℝ :=
  (cleanDefine_square_7aae69f1485be0941444 ((x - y)))

noncomputable def cleanDefine_trigonometric_energy_f9ca3c80db556f3b8d31  (x : ℝ) : ℝ :=
  ((cleanDefine_square_7aae69f1485be0941444 ((cleanNotation_sin_8679b27b6c150044959d (x)))) + (cleanDefine_square_7aae69f1485be0941444 ((cleanNotation_cos_1efb67bf51334208e223 (x)))))


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
  (0 < (cleanNotation_exp_7915ccfe7848eb4fc048 (x)))

/--
source: mathlib
reference: Real.exp_ne_zero
relationship: specialized
-/
def exponential_nonzero : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_exp_7915ccfe7848eb4fc048 (x)) ≠ 0)

/--
source: mathlib
reference: Real.exp_add
relationship: specialized
-/
def exponential_sum : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_exp_7915ccfe7848eb4fc048 ((x + y))) = ((cleanNotation_exp_7915ccfe7848eb4fc048 (x)) * (cleanNotation_exp_7915ccfe7848eb4fc048 (y))))

/--
source: mathlib
reference: Real.exp_sub
relationship: specialized
-/
def exponential_difference : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_exp_7915ccfe7848eb4fc048 ((x - y))) = ((cleanNotation_exp_7915ccfe7848eb4fc048 (x)) / (cleanNotation_exp_7915ccfe7848eb4fc048 (y))))

/--
source: mathlib
reference: Real.log_exp
relationship: specialized
-/
def logarithm_exponential : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_log_3a02e02cafc4602764f4 ((cleanNotation_exp_7915ccfe7848eb4fc048 (x)))) = x)

/--
source: mathlib
reference: Real.exp_log
relationship: specialized
-/
def exponential_logarithm : Prop :=
  ∀ (x : ℝ),
  ∀ (positive : (0 < x)),
  ((cleanNotation_exp_7915ccfe7848eb4fc048 ((cleanNotation_log_3a02e02cafc4602764f4 (x)))) = x)

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def logarithm_product : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonzero_x : (x ≠ 0)),
  ∀ (nonzero_y : (y ≠ 0)),
  ((cleanNotation_log_3a02e02cafc4602764f4 ((x * y))) = ((cleanNotation_log_3a02e02cafc4602764f4 (x)) + (cleanNotation_log_3a02e02cafc4602764f4 (y))))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def logarithm_quotient : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonzero_x : (x ≠ 0)),
  ∀ (nonzero_y : (y ≠ 0)),
  ((cleanNotation_log_3a02e02cafc4602764f4 ((x / y))) = ((cleanNotation_log_3a02e02cafc4602764f4 (x)) - (cleanNotation_log_3a02e02cafc4602764f4 (y))))

/--
source: mathlib
reference: Real.sqrt_nonneg
relationship: specialized
-/
def square_root_nonnegative : Prop :=
  ∀ (x : ℝ),
  (0 ≤ (cleanNotation_sqrt_bab2de5a3de5967c5bae (x)))

/--
source: mathlib
reference: Real.sq_sqrt
relationship: specialized
-/
def square_of_square_root : Prop :=
  ∀ (x : ℝ),
  ∀ (nonnegative : (0 ≤ x)),
  (((cleanNotation_sqrt_bab2de5a3de5967c5bae (x)) ^ 2) = x)

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: specialized
-/
def square_root_of_square : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_sqrt_bab2de5a3de5967c5bae ((x ^ 2))) = (cleanNotation_abs_17502ff021fd42a8ce97 (x)))

/--
source: mathlib
reference: Real.sqrt_mul
relationship: specialized
-/
def square_root_product : Prop :=
  ∀ (x y : ℝ),
  ∀ (nonnegative : (0 ≤ x)),
  ((cleanNotation_sqrt_bab2de5a3de5967c5bae ((x * y))) = ((cleanNotation_sqrt_bab2de5a3de5967c5bae (x)) * (cleanNotation_sqrt_bab2de5a3de5967c5bae (y))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: specialized
-/
def trigonometric_identity : Prop :=
  ∀ (x : ℝ),
  ((((cleanNotation_sin_8679b27b6c150044959d (x)) ^ 2) + ((cleanNotation_cos_1efb67bf51334208e223 (x)) ^ 2)) = 1)

/--
source: mathlib
reference: Real.sin_add
relationship: specialized
-/
def sine_addition : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_sin_8679b27b6c150044959d ((x + y))) = (((cleanNotation_sin_8679b27b6c150044959d (x)) * (cleanNotation_cos_1efb67bf51334208e223 (y))) + ((cleanNotation_cos_1efb67bf51334208e223 (x)) * (cleanNotation_sin_8679b27b6c150044959d (y)))))

/--
source: mathlib
reference: Real.cos_add
relationship: specialized
-/
def cosine_addition : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_cos_1efb67bf51334208e223 ((x + y))) = (((cleanNotation_cos_1efb67bf51334208e223 (x)) * (cleanNotation_cos_1efb67bf51334208e223 (y))) - ((cleanNotation_sin_8679b27b6c150044959d (x)) * (cleanNotation_sin_8679b27b6c150044959d (y)))))

/--
source: mathlib
reference: Real.sin_neg
relationship: specialized
-/
def sine_odd : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_sin_8679b27b6c150044959d ((-x))) = (-(cleanNotation_sin_8679b27b6c150044959d (x))))

/--
source: mathlib
reference: Real.cos_neg
relationship: specialized
-/
def cosine_even : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_cos_1efb67bf51334208e223 ((-x))) = (cleanNotation_cos_1efb67bf51334208e223 (x)))

/--
source: mathlib
reference: Continuous.comp
relationship: specialized
-/
def continuous_composition : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (cleanNotation_continuous_723e95f1cf7739171880 (f))),
  ∀ (hg : (cleanNotation_continuous_723e95f1cf7739171880 (g))),
  (cleanNotation_continuous_723e95f1cf7739171880 ((cleanNotation_compose_7439357a91f0e39bc193 (f) (g))))

/--
source: mathlib
reference: Continuous.add
relationship: specialized
-/
def continuous_sum : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (cleanNotation_continuous_723e95f1cf7739171880 (f))),
  ∀ (hg : (cleanNotation_continuous_723e95f1cf7739171880 (g))),
  (cleanNotation_continuous_723e95f1cf7739171880 ((f + g)))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def continuous_product : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ (hf : (cleanNotation_continuous_723e95f1cf7739171880 (f))),
  ∀ (hg : (cleanNotation_continuous_723e95f1cf7739171880 (g))),
  (cleanNotation_continuous_723e95f1cf7739171880 ((f * g)))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def authored_square_root : Prop :=
  ∀ (x : ℝ),
  ((cleanNotation_sqrt_bab2de5a3de5967c5bae ((cleanDefine_square_7aae69f1485be0941444 (x)))) = (cleanNotation_abs_17502ff021fd42a8ce97 (x)))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: adapted
-/
def authored_trigonometric_energy : Prop :=
  ∀ (x : ℝ),
  ((cleanDefine_trigonometric_energy_f9ca3c80db556f3b8d31 (x)) = 1)

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def distance_square_root : Prop :=
  ∀ (x y : ℝ),
  ((cleanNotation_sqrt_bab2de5a3de5967c5bae ((cleanDefine_squared_distance_efa301df5f4a584cafc8 (x) (y)))) = (cleanNotation_abs_17502ff021fd42a8ce97 ((x - y))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
