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

noncomputable def cleanNotation_insertionSort_6aaed7bf698e562b4aa5  (x0 : List (ℕ)) : List (ℕ) :=
  (List.insertionSort (· ≤ ·)) x0

noncomputable def cleanNotation_mergeSort_51561cc64977417a701c  (x0 : List (ℕ)) : List (ℕ) :=
  (fun l : List ℕ => l.mergeSort (· ≤ ·)) x0

noncomputable def cleanNotation_sorted_bb5cb4068b5c2ce6d1ed  (x0 : List (ℕ)) : Prop :=
  List.Sorted (· ≤ ·) x0

noncomputable def cleanNotation_permutation_e74b2d2973b6778742ca {T : Type} (x0 : List (T)) (x1 : List (T)) : Prop :=
  List.Perm x0 x1

noncomputable def cleanNotation_length_6016b9cfd65d60648fc3 {T : Type} (x0 : List (T)) : ℕ :=
  List.length x0

noncomputable def cleanNotation_insert_fc17db7c59c6361dc276  (x0 : ℕ) (x1 : List (ℕ)) : List (ℕ) :=
  List.orderedInsert (· ≤ ·) x0 x1

noncomputable def cleanNotation_cons_8df3385d877a7d8324ae  (x0 : ℕ) (x1 : List (ℕ)) : List (ℕ) :=
  x0 :: x1

noncomputable def cleanNotation_sublist_ef3e1617947e64ecf0be {T : Type} (x0 : List (T)) (x1 : List (T)) : Prop :=
  List.Sublist x0 x1

noncomputable def cleanNotation_count_5c84f457aa0661a1ecbb  (x0 : ℕ) (x1 : List (ℕ)) : ℕ :=
  List.count x0 x1

noncomputable def cleanNotation_merge_afbf80a28ac74f1f01c4  (x0 : List (ℕ)) (x1 : List (ℕ)) : List (ℕ) :=
  List.merge x0 x1 (· ≤ ·)

noncomputable def cleanNotation_gcd_c5d38a8d9fdadc4bcfb1  (x0 : ℕ) (x1 : ℕ) : ℕ :=
  Nat.gcd x0 x1

noncomputable def cleanNotation_lcm_6a337f2a1fee7d9b19ad  (x0 : ℕ) (x1 : ℕ) : ℕ :=
  Nat.lcm x0 x1

noncomputable def cleanDefine_coprime_90926a1fc5d9967320f9  (x0 : ℕ) (x1 : ℕ) : Prop :=
  ((cleanNotation_gcd_c5d38a8d9fdadc4bcfb1 (x0) (x1)) = 1)

noncomputable def cleanDefine_sorting_certificate_1c271b4f1c624120844f  (xs : List (ℕ)) (ys : List (ℕ)) : Prop :=
  ((cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (ys)) ∧ (cleanNotation_permutation_e74b2d2973b6778742ca (ys) (xs)))

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

noncomputable def cleanNotation_adjacent_7c95186c3948254b956e {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) (x2 : Fin n) : Prop :=
  (x0).Adj x1 x2

noncomputable def cleanNotation_complement_954dec16190ec6a37dd0 {n : ℕ} (x0 : SimpleGraph (Fin n)) : SimpleGraph (Fin n) :=
  (x0)ᶜ

noncomputable def cleanNotation_union_0624f3ebbf6554a04047 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : SimpleGraph (Fin n)) : SimpleGraph (Fin n) :=
  x0 ⊔ x1

noncomputable def cleanNotation_intersection_5a5227c120f070958445 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : SimpleGraph (Fin n)) : SimpleGraph (Fin n) :=
  x0 ⊓ x1

noncomputable def cleanNotation_neighbors_587d371eac8330440de6 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) : Set (Fin n) :=
  (x0).neighborSet x1

noncomputable def cleanNotation_support_c53e656ac6b9efb817db {n : ℕ} (x0 : SimpleGraph (Fin n)) : Set (Fin n) :=
  (x0).support

noncomputable def cleanNotation_subgraph_32b2b617f7e2adc8d649 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : SimpleGraph (Fin n)) : Prop :=
  x0 ≤ x1

noncomputable def cleanNotation_reachable_947639a9d52df05827e1 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) (x2 : Fin n) : Prop :=
  (x0).Reachable x1 x2

noncomputable def cleanNotation_connected_39ef10558c6b507db5c6 {n : ℕ} (x0 : SimpleGraph (Fin n)) : Prop :=
  (x0).Connected

noncomputable def cleanDefine_commonNeighbors_679582fb71c83da5a33f {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) (x2 : Fin n) : Set (Fin n) :=
  ((cleanNotation_neighbors_587d371eac8330440de6 (x0) (x1)) ∩ (cleanNotation_neighbors_587d371eac8330440de6 (x0) (x2)))

noncomputable def cleanDefine_nonadjacent_950fcfd8028c2fac7d74 {n : ℕ} (G : SimpleGraph (Fin n)) (u : Fin n) (v : Fin n) : Prop :=
  (¬(cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v)))

noncomputable def cleanNotation_det_7326e962c725ce45b521 {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  Matrix.det x0

noncomputable def cleanNotation_trace_77213551dad9a763052a {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : ℂ :=
  Matrix.trace x0

noncomputable def cleanNotation_transpose_ec7d2405c8c143132e84 {m : ℕ} {n : ℕ} (x0 : Matrix (Fin m) (Fin n) ℂ) : Matrix (Fin n) (Fin m) ℂ :=
  Matrix.transpose x0

noncomputable def cleanNotation_inverse_60f5a255d86c84175527 {n : ℕ} (x0 : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  (x0)⁻¹

noncomputable def cleanDefine_commutator_dec87a8766301eb4176d {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (B : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  ((A * B) - (B * A))

noncomputable def cleanDefine_matrix_square_59c5fc3d3e7ab2ab3d9b {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  (A * A)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: List.sorted_insertionSort
relationship: specialized
-/
def insertion_sort_sorted : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs))))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: specialized
-/
def insertion_sort_permutation : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanNotation_permutation_e74b2d2973b6778742ca ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs))) (xs))

/--
source: mathlib
reference: List.length_insertionSort
relationship: specialized
-/
def insertion_sort_length : Prop :=
  ∀ (xs : List (ℕ)),
  ((cleanNotation_length_6016b9cfd65d60648fc3 ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs)))) = (cleanNotation_length_6016b9cfd65d60648fc3 (xs)))

/--
source: mathlib
reference: List.mem_insertionSort
relationship: specialized
-/
def insertion_sort_membership : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ((a ∈ (cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs))) ↔ (a ∈ xs))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: specialized
-/
def sorted_input_unchanged : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ («ordered» : (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (xs))),
  ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs)) = xs)

/--
source: mathlib
reference: List.orderedInsert_length
relationship: specialized
-/
def ordered_insert_length : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ((cleanNotation_length_6016b9cfd65d60648fc3 ((cleanNotation_insert_fc17db7c59c6361dc276 (a) (xs)))) = ((cleanNotation_length_6016b9cfd65d60648fc3 (xs)) + 1))

/--
source: mathlib
reference: List.mem_orderedInsert
relationship: specialized
-/
def ordered_insert_membership : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a b : ℕ),
  ((b ∈ (cleanNotation_insert_fc17db7c59c6361dc276 (a) (xs))) ↔ ((b = a) ∨ (b ∈ xs)))

/--
source: mathlib
reference: List.perm_orderedInsert
relationship: specialized
-/
def ordered_insert_permutation : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  (cleanNotation_permutation_e74b2d2973b6778742ca ((cleanNotation_insert_fc17db7c59c6361dc276 (a) (xs))) ((cleanNotation_cons_8df3385d877a7d8324ae (a) (xs))))

/--
source: mathlib
reference: List.Sorted.orderedInsert
relationship: specialized
-/
def ordered_insert_preserves_sortedness : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ∀ («ordered» : (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (xs))),
  (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed ((cleanNotation_insert_fc17db7c59c6361dc276 (a) (xs))))

/--
source: mathlib
reference: List.sorted_mergeSort'
relationship: specialized
-/
def merge_sort_sorted : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed ((cleanNotation_mergeSort_51561cc64977417a701c (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_self
relationship: specialized
-/
def merge_sort_sorted_input : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ («ordered» : (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (xs))),
  ((cleanNotation_mergeSort_51561cc64977417a701c (xs)) = xs)

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: specialized
-/
def sorting_algorithms_agree : Prop :=
  ∀ (xs : List (ℕ)),
  ((cleanNotation_mergeSort_51561cc64977417a701c (xs)) = (cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs)))

/--
source: mathlib
reference: List.Sorted.merge
relationship: specialized
-/
def merge_preserves_sortedness : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ («hx» : (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (xs))),
  ∀ («hy» : (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (ys))),
  (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed ((cleanNotation_merge_afbf80a28ac74f1f01c4 (xs) (ys))))

/--
source: mathlib
reference: List.sublist_insertionSort
relationship: specialized
-/
def insertion_sort_subsequence : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ («ordered» : (cleanNotation_sorted_bb5cb4068b5c2ce6d1ed (ys))),
  ∀ («subsequence» : (cleanNotation_sublist_ef3e1617947e64ecf0be (ys) (xs))),
  (cleanNotation_sublist_ef3e1617947e64ecf0be (ys) ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs))))

/--
source: mathlib
reference: List.sublist_orderedInsert
relationship: specialized
-/
def ordered_insert_contains_input : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  (cleanNotation_sublist_ef3e1617947e64ecf0be (xs) ((cleanNotation_insert_fc17db7c59c6361dc276 (a) (xs))))

/--
source: mathlib
reference: Nat.coprime_add_mul_right_right
relationship: specialized
-/
def euclidean_coprime_reduction : Prop :=
  ∀ (a b k : ℕ),
  ((cleanDefine_coprime_90926a1fc5d9967320f9 (a) ((b + (k * a)))) ↔ (cleanDefine_coprime_90926a1fc5d9967320f9 (a) (b)))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def euclidean_coprime_subtraction : Prop :=
  ∀ (a b : ℕ),
  ∀ («ordered» : (a ≤ b)),
  ((cleanDefine_coprime_90926a1fc5d9967320f9 ((b - a)) (a)) ↔ (cleanDefine_coprime_90926a1fc5d9967320f9 (b) (a)))

/--
source: mathlib
reference: Nat.Coprime.lcm_eq_mul
relationship: specialized
-/
def coprime_lcm_product : Prop :=
  ∀ (a b : ℕ),
  ∀ («cop» : (cleanDefine_coprime_90926a1fc5d9967320f9 (a) (b))),
  ((cleanNotation_lcm_6a337f2a1fee7d9b19ad (a) (b)) = (a * b))

/--
source: mathlib
reference: Nat.eq_one_of_dvd_coprimes
relationship: specialized
-/
def common_divisor_of_coprimes : Prop :=
  ∀ (a b k : ℕ),
  ∀ («cop» : (cleanDefine_coprime_90926a1fc5d9967320f9 (a) (b))),
  ∀ («divides_a» : (k ∣ a)),
  ∀ («divides_b» : (k ∣ b)),
  (k = 1)

/--
source: mathlib
reference: Nat.Coprime.dvd_mul_right
relationship: specialized
-/
def coprime_product_divisibility : Prop :=
  ∀ (a b k : ℕ),
  ∀ («cop» : (cleanDefine_coprime_90926a1fc5d9967320f9 (k) (b))),
  ((k ∣ (a * b)) ↔ (k ∣ a))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: adapted
-/
def insertion_sort_certificate : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanDefine_sorting_certificate_1c271b4f1c624120844f (xs) ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: adapted
-/
def merge_sort_certificate : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanDefine_sorting_certificate_1c271b4f1c624120844f (xs) ((cleanNotation_mergeSort_51561cc64977417a701c (xs))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: adapted
-/
def certified_sort_unchanged : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ («certificate» : (cleanDefine_sorting_certificate_1c271b4f1c624120844f (xs) (ys))),
  ((cleanNotation_insertionSort_6aaed7bf698e562b4aa5 (ys)) = ys)

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
  ∀ («positive» : (0 < x)),
  ((cleanNotation_exp_7915ccfe7848eb4fc048 ((cleanNotation_log_3a02e02cafc4602764f4 (x)))) = x)

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def logarithm_product : Prop :=
  ∀ (x y : ℝ),
  ∀ («nonzero_x» : (x ≠ 0)),
  ∀ («nonzero_y» : (y ≠ 0)),
  ((cleanNotation_log_3a02e02cafc4602764f4 ((x * y))) = ((cleanNotation_log_3a02e02cafc4602764f4 (x)) + (cleanNotation_log_3a02e02cafc4602764f4 (y))))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def logarithm_quotient : Prop :=
  ∀ (x y : ℝ),
  ∀ («nonzero_x» : (x ≠ 0)),
  ∀ («nonzero_y» : (y ≠ 0)),
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
  ∀ («nonnegative» : (0 ≤ x)),
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
  ∀ («nonnegative» : (0 ≤ x)),
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
  ∀ («hf» : (cleanNotation_continuous_723e95f1cf7739171880 (f))),
  ∀ («hg» : (cleanNotation_continuous_723e95f1cf7739171880 (g))),
  (cleanNotation_continuous_723e95f1cf7739171880 ((cleanNotation_compose_7439357a91f0e39bc193 (f) (g))))

/--
source: mathlib
reference: Continuous.add
relationship: specialized
-/
def continuous_sum : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ («hf» : (cleanNotation_continuous_723e95f1cf7739171880 (f))),
  ∀ («hg» : (cleanNotation_continuous_723e95f1cf7739171880 (g))),
  (cleanNotation_continuous_723e95f1cf7739171880 ((f + g)))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def continuous_product : Prop :=
  ∀ (f g : (ℝ) → (ℝ)),
  ∀ («hf» : (cleanNotation_continuous_723e95f1cf7739171880 (f))),
  ∀ («hg» : (cleanNotation_continuous_723e95f1cf7739171880 (g))),
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

/--
source: mathlib
reference: SimpleGraph.adj_symm
relationship: specialized
-/
def adjacency_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ («edge» : (cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v))),
  (cleanNotation_adjacent_7c95186c3948254b956e (G) (v) (u))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: specialized
-/
def adjacency_commutes : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v)) ↔ (cleanNotation_adjacent_7c95186c3948254b956e (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def no_self_edges : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬(cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (u)))

/--
source: mathlib
reference: SimpleGraph.ne_of_adj
relationship: specialized
-/
def adjacent_vertices_distinct : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ («edge» : (cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v))),
  (u ≠ v)

/--
source: mathlib
reference: SimpleGraph.sup_adj
relationship: specialized
-/
def union_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_adjacent_7c95186c3948254b956e ((cleanNotation_union_0624f3ebbf6554a04047 (G) (H))) (u) (v)) ↔ ((cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v)) ∨ (cleanNotation_adjacent_7c95186c3948254b956e (H) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def intersection_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_adjacent_7c95186c3948254b956e ((cleanNotation_intersection_5a5227c120f070958445 (G) (H))) (u) (v)) ↔ ((cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v)) ∧ (cleanNotation_adjacent_7c95186c3948254b956e (H) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def complement_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_adjacent_7c95186c3948254b956e ((cleanNotation_complement_954dec16190ec6a37dd0 (G))) (u) (v)) ↔ ((u ≠ v) ∧ (¬(cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v)))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def support_monotonicity : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ («inclusion» : (cleanNotation_subgraph_32b2b617f7e2adc8d649 (G) (H))),
  ((cleanNotation_support_c53e656ac6b9efb817db (G)) ⊆ (cleanNotation_support_c53e656ac6b9efb817db (H)))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def neighbors_in_support : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  ((cleanNotation_neighbors_587d371eac8330440de6 (G) (u)) ⊆ (cleanNotation_support_c53e656ac6b9efb817db (G)))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def neighbor_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((v ∈ (cleanNotation_neighbors_587d371eac8330440de6 (G) (u))) ↔ (cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v)))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def not_own_neighbor : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬(u ∈ (cleanNotation_neighbors_587d371eac8330440de6 (G) (u))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def common_neighbors_intersection : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_commonNeighbors_679582fb71c83da5a33f (G) (u) (v)) = ((cleanNotation_neighbors_587d371eac8330440de6 (G) (u)) ∩ (cleanNotation_neighbors_587d371eac8330440de6 (G) (v))))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def common_neighbors_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ((w ∈ (cleanDefine_commonNeighbors_679582fb71c83da5a33f (G) (u) (v))) ↔ ((cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (w)) ∧ (cleanNotation_adjacent_7c95186c3948254b956e (G) (v) (w))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def common_neighbors_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_commonNeighbors_679582fb71c83da5a33f (G) (u) (v)) = (cleanDefine_commonNeighbors_679582fb71c83da5a33f (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def common_neighbors_left : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_commonNeighbors_679582fb71c83da5a33f (G) (u) (v)) ⊆ (cleanNotation_neighbors_587d371eac8330440de6 (G) (u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def common_neighbors_right : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_commonNeighbors_679582fb71c83da5a33f (G) (u) (v)) ⊆ (cleanNotation_neighbors_587d371eac8330440de6 (G) (v)))

/--
source: mathlib
reference: SimpleGraph.Reachable.refl
relationship: specialized
-/
def reachability_reflexive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (cleanNotation_reachable_947639a9d52df05827e1 (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.Reachable.symm
relationship: specialized
-/
def reachability_symmetric : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ («path» : (cleanNotation_reachable_947639a9d52df05827e1 (G) (u) (v))),
  (cleanNotation_reachable_947639a9d52df05827e1 (G) (v) (u))

/--
source: mathlib
reference: SimpleGraph.Reachable.trans
relationship: specialized
-/
def reachability_transitive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ∀ («first» : (cleanNotation_reachable_947639a9d52df05827e1 (G) (u) (v))),
  ∀ («second» : (cleanNotation_reachable_947639a9d52df05827e1 (G) (v) (w))),
  (cleanNotation_reachable_947639a9d52df05827e1 (G) (u) (w))

/--
source: mathlib
reference: SimpleGraph.Adj.reachable
relationship: specialized
-/
def edge_implies_reachability : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ («edge» : (cleanNotation_adjacent_7c95186c3948254b956e (G) (u) (v))),
  (cleanNotation_reachable_947639a9d52df05827e1 (G) (u) (v))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: adapted
-/
def nonadjacency_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_nonadjacent_950fcfd8028c2fac7d74 (G) (u) (v)) ↔ (cleanDefine_nonadjacent_950fcfd8028c2fac7d74 (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: adapted
-/
def nonadjacency_reflexive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (cleanDefine_nonadjacent_950fcfd8028c2fac7d74 (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: adapted
-/
def complement_from_nonadjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_adjacent_7c95186c3948254b956e ((cleanNotation_complement_954dec16190ec6a37dd0 (G))) (u) (v)) ↔ ((u ≠ v) ∧ (cleanDefine_nonadjacent_950fcfd8028c2fac7d74 (G) (u) (v))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def determinant_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A * B))) = ((cleanNotation_det_7326e962c725ce45b521 (A)) * (cleanNotation_det_7326e962c725ce45b521 (B))))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def determinant_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((cleanNotation_transpose_ec7d2405c8c143132e84 (A)))) = (cleanNotation_det_7326e962c725ce45b521 (A)))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def determinant_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A * B))) = (cleanNotation_det_7326e962c725ce45b521 ((B * A))))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def determinant_left_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A * (B * C)))) = (cleanNotation_det_7326e962c725ce45b521 ((B * (A * C)))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def determinant_right_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 (((A * B) * C))) = (cleanNotation_det_7326e962c725ce45b521 (((A * C) * B))))

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def determinant_power : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (k : ℕ),
  ((cleanNotation_det_7326e962c725ce45b521 ((A ^ k))) = ((cleanNotation_det_7326e962c725ce45b521 (A)) ^ k))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def trace_sum : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((A + B))) = ((cleanNotation_trace_77213551dad9a763052a (A)) + (cleanNotation_trace_77213551dad9a763052a (B))))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def trace_difference : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((A - B))) = ((cleanNotation_trace_77213551dad9a763052a (A)) - (cleanNotation_trace_77213551dad9a763052a (B))))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def trace_negative : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((-A))) = (-(cleanNotation_trace_77213551dad9a763052a (A))))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def trace_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((cleanNotation_transpose_ec7d2405c8c143132e84 (A)))) = (cleanNotation_trace_77213551dad9a763052a (A)))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def trace_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((A * B))) = (cleanNotation_trace_77213551dad9a763052a ((B * A))))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def trace_cycle : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a (((A * B) * C))) = (cleanNotation_trace_77213551dad9a763052a (((C * A) * B))))

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: specialized
-/
def matrix_vector_associativity : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  ((A *ᵥ (B *ᵥ x)) = ((A * B) *ᵥ x))

/--
source: mathlib
reference: Matrix.mulVec_add
relationship: specialized
-/
def matrix_vector_addition : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x y : Fin n → ℂ),
  ((A *ᵥ (x + y)) = ((A *ᵥ x) + (A *ᵥ y)))

/--
source: mathlib
reference: Matrix.add_mulVec
relationship: specialized
-/
def matrix_addition_action : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  (((A + B) *ᵥ x) = ((A *ᵥ x) + (B *ᵥ x)))

/--
source: mathlib
reference: Matrix.mulVec_sub
relationship: specialized
-/
def matrix_vector_subtraction : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x y : Fin n → ℂ),
  ((A *ᵥ (x - y)) = ((A *ᵥ x) - (A *ᵥ y)))

/--
source: mathlib
reference: Matrix.sub_mulVec
relationship: specialized
-/
def matrix_subtraction_action : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  (((A - B) *ᵥ x) = ((A *ᵥ x) - (B *ᵥ x)))

/--
source: mathlib
reference: Matrix.mulVec_smul
relationship: specialized
-/
def matrix_scalar_action : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (x : Fin n → ℂ),
  ∀ (c : ℂ),
  ((A *ᵥ (c • x)) = (c • (A *ᵥ x)))

/--
source: mathlib
reference: Matrix.transpose_transpose
relationship: specialized
-/
def transpose_involution : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_transpose_ec7d2405c8c143132e84 ((cleanNotation_transpose_ec7d2405c8c143132e84 (A)))) = A)

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def transpose_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_transpose_ec7d2405c8c143132e84 ((A * B))) = ((cleanNotation_transpose_ec7d2405c8c143132e84 (B)) * (cleanNotation_transpose_ec7d2405c8c143132e84 (A))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_commutator : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((cleanDefine_commutator_dec87a8766301eb4176d (A) (B)))) = 0)

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_matrix_square : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_trace_77213551dad9a763052a ((cleanDefine_matrix_square_59c5fc3d3e7ab2ab3d9b (A)))) = (cleanNotation_trace_77213551dad9a763052a ((A * A))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: adapted
-/
def determinant_matrix_square : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((cleanNotation_det_7326e962c725ce45b521 ((cleanDefine_matrix_square_59c5fc3d3e7ab2ab3d9b (A)))) = ((cleanNotation_det_7326e962c725ce45b521 (A)) * (cleanNotation_det_7326e962c725ce45b521 (A))))

end CleanStatements

namespace CleanValidation
theorem determinant_product : CleanStatements.determinant_product := by
  intro n A B
  exact Matrix.det_mul A B

theorem determinant_transpose : CleanStatements.determinant_transpose := by
  intro n A
  exact Matrix.det_transpose A

theorem determinant_product_swap : CleanStatements.determinant_product_swap := by
  intro n A B
  exact Matrix.det_mul_comm A B

theorem determinant_left_swap : CleanStatements.determinant_left_swap := by
  intro n A B C
  exact Matrix.det_mul_left_comm A B C

theorem determinant_right_swap : CleanStatements.determinant_right_swap := by
  intro n A B C
  exact Matrix.det_mul_right_comm A B C

theorem determinant_power : CleanStatements.determinant_power := by
  intro n A k
  exact Matrix.det_pow A k

theorem trace_sum : CleanStatements.trace_sum := by
  intro n A B
  exact Matrix.trace_add A B

theorem trace_difference : CleanStatements.trace_difference := by
  intro n A B
  exact Matrix.trace_sub A B

theorem trace_negative : CleanStatements.trace_negative := by
  intro n A
  exact Matrix.trace_neg A

theorem trace_transpose : CleanStatements.trace_transpose := by
  intro n A
  exact Matrix.trace_transpose A

theorem trace_product_swap : CleanStatements.trace_product_swap := by
  intro n A B
  exact Matrix.trace_mul_comm A B

theorem trace_cycle : CleanStatements.trace_cycle := by
  intro n A B C
  exact Matrix.trace_mul_cycle A B C

theorem matrix_vector_associativity : CleanStatements.matrix_vector_associativity := by
  intro n A B x
  exact Matrix.mulVec_mulVec x A B

theorem matrix_vector_addition : CleanStatements.matrix_vector_addition := by
  intro n A x y
  exact Matrix.mulVec_add A x y

theorem matrix_addition_action : CleanStatements.matrix_addition_action := by
  intro n A B x
  exact Matrix.add_mulVec A B x

theorem matrix_vector_subtraction : CleanStatements.matrix_vector_subtraction := by
  intro n A x y
  exact Matrix.mulVec_sub A x y

theorem matrix_subtraction_action : CleanStatements.matrix_subtraction_action := by
  intro n A B x
  exact Matrix.sub_mulVec A B x

theorem matrix_scalar_action : CleanStatements.matrix_scalar_action := by
  intro n A x c
  exact Matrix.mulVec_smul A c x

theorem transpose_involution : CleanStatements.transpose_involution := by
  intro n A
  exact Matrix.transpose_transpose A

theorem transpose_product : CleanStatements.transpose_product := by
  intro n A B
  exact Matrix.transpose_mul A B

theorem adjacency_symmetry : CleanStatements.adjacency_symmetry := by
  intro n G u v edge
  exact G.adj_symm edge

theorem adjacency_commutes : CleanStatements.adjacency_commutes := by
  intro n G u v
  exact G.adj_comm u v

theorem no_self_edges : CleanStatements.no_self_edges := by
  intro n G u
  exact G.irrefl

theorem adjacent_vertices_distinct : CleanStatements.adjacent_vertices_distinct := by
  intro n G u v edge
  exact G.ne_of_adj edge

theorem union_adjacency : CleanStatements.union_adjacency := by
  intro n G H u v
  exact SimpleGraph.sup_adj G H u v

theorem intersection_adjacency : CleanStatements.intersection_adjacency := by
  intro n G H u v
  exact SimpleGraph.inf_adj G H u v

theorem complement_adjacency : CleanStatements.complement_adjacency := by
  intro n G u v
  exact SimpleGraph.compl_adj G u v

theorem support_monotonicity : CleanStatements.support_monotonicity := by
  intro n G H inclusion
  exact SimpleGraph.support_mono inclusion

theorem neighbors_in_support : CleanStatements.neighbors_in_support := by
  intro n G u
  exact G.neighborSet_subset_support u

theorem neighbor_membership : CleanStatements.neighbor_membership := by
  intro n G u v
  exact G.mem_neighborSet u v

theorem not_own_neighbor : CleanStatements.not_own_neighbor := by
  intro n G u
  exact G.notMem_neighborSet_self

theorem common_neighbors_intersection : CleanStatements.common_neighbors_intersection := by
  intro n G u v
  exact G.commonNeighbors_eq u v

theorem common_neighbors_membership : CleanStatements.common_neighbors_membership := by
  intro n G u v w
  exact G.mem_commonNeighbors

theorem common_neighbors_symmetry : CleanStatements.common_neighbors_symmetry := by
  intro n G u v
  exact G.commonNeighbors_symm u v

theorem common_neighbors_left : CleanStatements.common_neighbors_left := by
  intro n G u v
  exact G.commonNeighbors_subset_neighborSet_left u v

theorem common_neighbors_right : CleanStatements.common_neighbors_right := by
  intro n G u v
  exact G.commonNeighbors_subset_neighborSet_right u v

theorem reachability_reflexive : CleanStatements.reachability_reflexive := by
  intro n G u
  exact SimpleGraph.Reachable.refl u

theorem reachability_symmetric : CleanStatements.reachability_symmetric := by
  intro n G u v path
  exact path.symm

theorem reachability_transitive : CleanStatements.reachability_transitive := by
  intro n G u v w first second
  exact first.trans second

theorem edge_implies_reachability : CleanStatements.edge_implies_reachability := by
  intro n G u v edge
  exact edge.reachable

theorem exponential_positive : CleanStatements.exponential_positive := by
  intro x
  exact Real.exp_pos x

theorem exponential_nonzero : CleanStatements.exponential_nonzero := by
  intro x
  exact Real.exp_ne_zero x

theorem exponential_sum : CleanStatements.exponential_sum := by
  intro x y
  exact Real.exp_add x y

theorem exponential_difference : CleanStatements.exponential_difference := by
  intro x y
  exact Real.exp_sub x y

theorem logarithm_exponential : CleanStatements.logarithm_exponential := by
  intro x
  exact Real.log_exp x

theorem exponential_logarithm : CleanStatements.exponential_logarithm := by
  intro x positive
  exact Real.exp_log positive

theorem logarithm_product : CleanStatements.logarithm_product := by
  intro x y nonzero_x nonzero_y
  exact Real.log_mul nonzero_x nonzero_y

theorem logarithm_quotient : CleanStatements.logarithm_quotient := by
  intro x y nonzero_x nonzero_y
  exact Real.log_div nonzero_x nonzero_y

theorem square_root_nonnegative : CleanStatements.square_root_nonnegative := by
  intro x
  exact Real.sqrt_nonneg x

theorem square_of_square_root : CleanStatements.square_of_square_root := by
  intro x nonnegative
  exact Real.sq_sqrt nonnegative

theorem square_root_of_square : CleanStatements.square_root_of_square := by
  intro x
  exact Real.sqrt_sq_eq_abs x

theorem square_root_product : CleanStatements.square_root_product := by
  intro x y nonnegative
  exact Real.sqrt_mul nonnegative y

theorem trigonometric_identity : CleanStatements.trigonometric_identity := by
  intro x
  exact Real.sin_sq_add_cos_sq x

theorem sine_addition : CleanStatements.sine_addition := by
  intro x y
  exact Real.sin_add x y

theorem cosine_addition : CleanStatements.cosine_addition := by
  intro x y
  exact Real.cos_add x y

theorem sine_odd : CleanStatements.sine_odd := by
  intro x
  exact Real.sin_neg x

theorem cosine_even : CleanStatements.cosine_even := by
  intro x
  exact Real.cos_neg x

theorem continuous_composition : CleanStatements.continuous_composition := by
  intro f g hf hg
  exact hf.comp hg

theorem continuous_sum : CleanStatements.continuous_sum := by
  intro f g hf hg
  exact hf.add hg

theorem continuous_product : CleanStatements.continuous_product := by
  intro f g hf hg
  exact hf.mul hg

theorem insertion_sort_sorted : CleanStatements.insertion_sort_sorted := by
  intro xs
  exact List.sorted_insertionSort (· ≤ ·) xs

theorem insertion_sort_permutation : CleanStatements.insertion_sort_permutation := by
  intro xs
  exact List.perm_insertionSort (· ≤ ·) xs

theorem insertion_sort_length : CleanStatements.insertion_sort_length := by
  intro xs
  exact List.length_insertionSort (· ≤ ·) xs

theorem insertion_sort_membership : CleanStatements.insertion_sort_membership := by
  intro xs a
  exact List.mem_insertionSort (r := (· ≤ ·))

theorem sorted_input_unchanged : CleanStatements.sorted_input_unchanged := by
  intro xs ordered
  exact ordered.insertionSort_eq

theorem ordered_insert_length : CleanStatements.ordered_insert_length := by
  intro xs a
  exact List.orderedInsert_length (· ≤ ·) xs a

theorem ordered_insert_membership : CleanStatements.ordered_insert_membership := by
  intro xs a b
  exact List.mem_orderedInsert (· ≤ ·)

theorem ordered_insert_permutation : CleanStatements.ordered_insert_permutation := by
  intro xs a
  exact List.perm_orderedInsert (· ≤ ·) a xs

theorem ordered_insert_preserves_sortedness : CleanStatements.ordered_insert_preserves_sortedness := by
  intro xs a ordered
  exact ordered.orderedInsert a xs

theorem merge_sort_sorted : CleanStatements.merge_sort_sorted := by
  intro xs
  exact List.sorted_mergeSort' (· ≤ ·) xs

theorem merge_sort_sorted_input : CleanStatements.merge_sort_sorted_input := by
  intro xs ordered
  exact List.mergeSort_eq_self (r := (· ≤ ·)) ordered

theorem sorting_algorithms_agree : CleanStatements.sorting_algorithms_agree := by
  intro xs
  exact List.mergeSort_eq_insertionSort (r := (· ≤ ·)) xs

theorem merge_preserves_sortedness : CleanStatements.merge_preserves_sortedness := by
  intro xs ys hx hy
  exact hx.merge hy

theorem insertion_sort_subsequence : CleanStatements.insertion_sort_subsequence := by
  intro xs ys ordered subsequence
  exact List.sublist_insertionSort ordered subsequence

theorem ordered_insert_contains_input : CleanStatements.ordered_insert_contains_input := by
  intro xs a
  exact List.sublist_orderedInsert (r := (· ≤ ·)) a xs

theorem euclidean_coprime_reduction : CleanStatements.euclidean_coprime_reduction := by
  intro a b k
  exact Nat.coprime_add_mul_right_right a b k

theorem euclidean_coprime_subtraction : CleanStatements.euclidean_coprime_subtraction := by
  intro a b ordered
  exact Nat.coprime_sub_self_left ordered

theorem coprime_lcm_product : CleanStatements.coprime_lcm_product := by
  intro a b cop
  exact Nat.Coprime.lcm_eq_mul cop

theorem common_divisor_of_coprimes : CleanStatements.common_divisor_of_coprimes := by
  intro a b k cop divides_a divides_b
  exact Nat.eq_one_of_dvd_coprimes cop divides_a divides_b

theorem coprime_product_divisibility : CleanStatements.coprime_product_divisibility := by
  intro a b k cop
  exact Nat.Coprime.dvd_mul_right cop

theorem trace_commutator : CleanStatements.trace_commutator := by
  intro n A B
  exact by change Matrix.trace (A*B-B*A) = 0; rw [Matrix.trace_sub, Matrix.trace_mul_comm A B, sub_self]

theorem trace_matrix_square : CleanStatements.trace_matrix_square := by
  intro n A
  exact rfl

theorem determinant_matrix_square : CleanStatements.determinant_matrix_square := by
  intro n A
  exact Matrix.det_mul A A

theorem authored_square_root : CleanStatements.authored_square_root := by
  intro x
  exact Real.sqrt_sq_eq_abs x

theorem authored_trigonometric_energy : CleanStatements.authored_trigonometric_energy := by
  intro x
  exact Real.sin_sq_add_cos_sq x

theorem distance_square_root : CleanStatements.distance_square_root := by
  intro x y
  exact Real.sqrt_sq_eq_abs (x-y)

theorem nonadjacency_symmetry : CleanStatements.nonadjacency_symmetry := by
  intro n G u v
  exact not_congr (G.adj_comm u v)

theorem nonadjacency_reflexive : CleanStatements.nonadjacency_reflexive := by
  intro n G u
  exact G.irrefl

theorem complement_from_nonadjacency : CleanStatements.complement_from_nonadjacency := by
  intro n G u v
  exact SimpleGraph.compl_adj G u v

theorem insertion_sort_certificate : CleanStatements.insertion_sort_certificate := by
  intro xs
  exact And.intro (List.sorted_insertionSort (· ≤ ·) xs) (List.perm_insertionSort (· ≤ ·) xs)

theorem merge_sort_certificate : CleanStatements.merge_sort_certificate := by
  intro xs
  exact by change List.Sorted (· ≤ ·) (xs.mergeSort (· ≤ ·)) ∧ List.Perm (xs.mergeSort (· ≤ ·)) xs; rw [List.mergeSort_eq_insertionSort]; exact And.intro (List.sorted_insertionSort (· ≤ ·) xs) (List.perm_insertionSort (· ≤ ·) xs)

theorem certified_sort_unchanged : CleanStatements.certified_sort_unchanged := by
  intro xs ys certificate
  exact certificate.1.insertionSort_eq

end CleanValidation

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
