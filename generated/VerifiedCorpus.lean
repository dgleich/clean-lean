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
reference: List.sorted_insertionSort
relationship: specialized
-/
def insertion_sort_sorted : Prop :=
  ∀ (xs : List (ℕ)),
  (List.Sorted (· ≤ ·) ((List.insertionSort (· ≤ ·)) xs))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: specialized
-/
def insertion_sort_permutation : Prop :=
  ∀ (xs : List (ℕ)),
  (List.Perm ((List.insertionSort (· ≤ ·)) xs) xs)

/--
source: mathlib
reference: List.length_insertionSort
relationship: specialized
-/
def insertion_sort_length : Prop :=
  ∀ (xs : List (ℕ)),
  ((List.length ((List.insertionSort (· ≤ ·)) xs)) = (List.length xs))

/--
source: mathlib
reference: List.mem_insertionSort
relationship: specialized
-/
def insertion_sort_membership : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ((a ∈ ((List.insertionSort (· ≤ ·)) xs)) ↔ (a ∈ xs))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: specialized
-/
def sorted_input_unchanged : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (ordered : (List.Sorted (· ≤ ·) xs)),
  (((List.insertionSort (· ≤ ·)) xs) = xs)

/--
source: mathlib
reference: List.orderedInsert_length
relationship: specialized
-/
def ordered_insert_length : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ((List.length (List.orderedInsert (· ≤ ·) a xs)) = ((List.length xs) + 1))

/--
source: mathlib
reference: List.mem_orderedInsert
relationship: specialized
-/
def ordered_insert_membership : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a b : ℕ),
  ((b ∈ (List.orderedInsert (· ≤ ·) a xs)) ↔ ((b = a) ∨ (b ∈ xs)))

/--
source: mathlib
reference: List.perm_orderedInsert
relationship: specialized
-/
def ordered_insert_permutation : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  (List.Perm (List.orderedInsert (· ≤ ·) a xs) (a :: xs))

/--
source: mathlib
reference: List.Sorted.orderedInsert
relationship: specialized
-/
def ordered_insert_preserves_sortedness : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ∀ (ordered : (List.Sorted (· ≤ ·) xs)),
  (List.Sorted (· ≤ ·) (List.orderedInsert (· ≤ ·) a xs))

/--
source: mathlib
reference: List.sorted_mergeSort'
relationship: specialized
-/
def merge_sort_sorted : Prop :=
  ∀ (xs : List (ℕ)),
  (List.Sorted (· ≤ ·) ((fun l : List ℕ => l.mergeSort (· ≤ ·)) xs))

/--
source: mathlib
reference: List.mergeSort_eq_self
relationship: specialized
-/
def merge_sort_sorted_input : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (ordered : (List.Sorted (· ≤ ·) xs)),
  (((fun l : List ℕ => l.mergeSort (· ≤ ·)) xs) = xs)

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: specialized
-/
def sorting_algorithms_agree : Prop :=
  ∀ (xs : List (ℕ)),
  (((fun l : List ℕ => l.mergeSort (· ≤ ·)) xs) = ((List.insertionSort (· ≤ ·)) xs))

/--
source: mathlib
reference: List.Sorted.merge
relationship: specialized
-/
def merge_preserves_sortedness : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ (hx : (List.Sorted (· ≤ ·) xs)),
  ∀ (hy : (List.Sorted (· ≤ ·) ys)),
  (List.Sorted (· ≤ ·) (List.merge xs ys (· ≤ ·)))

/--
source: mathlib
reference: List.sublist_insertionSort
relationship: specialized
-/
def insertion_sort_subsequence : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ (ordered : (List.Sorted (· ≤ ·) ys)),
  ∀ (subsequence : (List.Sublist ys xs)),
  (List.Sublist ys ((List.insertionSort (· ≤ ·)) xs))

/--
source: mathlib
reference: List.sublist_orderedInsert
relationship: specialized
-/
def ordered_insert_contains_input : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  (List.Sublist xs (List.orderedInsert (· ≤ ·) a xs))

/--
source: mathlib
reference: Nat.coprime_add_mul_right_right
relationship: specialized
-/
def euclidean_coprime_reduction : Prop :=
  ∀ (a b k : ℕ),
  ((Nat.Coprime a (b + (k * a))) ↔ (Nat.Coprime a b))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def euclidean_coprime_subtraction : Prop :=
  ∀ (a b : ℕ),
  ∀ (ordered : (a ≤ b)),
  ((Nat.Coprime (b - a) a) ↔ (Nat.Coprime b a))

/--
source: mathlib
reference: Nat.Coprime.lcm_eq_mul
relationship: specialized
-/
def coprime_lcm_product : Prop :=
  ∀ (a b : ℕ),
  ∀ (cop : (Nat.Coprime a b)),
  ((Nat.lcm a b) = (a * b))

/--
source: mathlib
reference: Nat.eq_one_of_dvd_coprimes
relationship: specialized
-/
def common_divisor_of_coprimes : Prop :=
  ∀ (a b k : ℕ),
  ∀ (cop : (Nat.Coprime a b)),
  ∀ (divides_a : (k ∣ a)),
  ∀ (divides_b : (k ∣ b)),
  (k = 1)

/--
source: mathlib
reference: Nat.Coprime.dvd_mul_right
relationship: specialized
-/
def coprime_product_divisibility : Prop :=
  ∀ (a b k : ℕ),
  ∀ (cop : (Nat.Coprime k b)),
  ((k ∣ (a * b)) ↔ (k ∣ a))

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

/--
source: mathlib
reference: SimpleGraph.adj_symm
relationship: specialized
-/
def adjacency_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : ((G).Adj u v)),
  ((G).Adj v u)

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: specialized
-/
def adjacency_commutes : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).Adj u v) ↔ ((G).Adj v u))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def no_self_edges : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬((G).Adj u u))

/--
source: mathlib
reference: SimpleGraph.ne_of_adj
relationship: specialized
-/
def adjacent_vertices_distinct : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : ((G).Adj u v)),
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
  ((((G ⊔ H)).Adj u v) ↔ (((G).Adj u v) ∨ ((H).Adj u v)))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def intersection_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((((G ⊓ H)).Adj u v) ↔ (((G).Adj u v) ∧ ((H).Adj u v)))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def complement_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((((G)ᶜ)).Adj u v) ↔ ((u ≠ v) ∧ (¬((G).Adj u v))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def support_monotonicity : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (inclusion : (G ≤ H)),
  (((G).support) ⊆ ((H).support))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def neighbors_in_support : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (((G).neighborSet u) ⊆ ((G).support))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def neighbor_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((v ∈ ((G).neighborSet u)) ↔ ((G).Adj u v))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def not_own_neighbor : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬(u ∈ ((G).neighborSet u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def common_neighbors_intersection : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) = (((G).neighborSet u) ∩ ((G).neighborSet v)))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def common_neighbors_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ((w ∈ ((G).commonNeighbors u v)) ↔ (((G).Adj u w) ∧ ((G).Adj v w)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def common_neighbors_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) = ((G).commonNeighbors v u))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def common_neighbors_left : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) ⊆ ((G).neighborSet u))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def common_neighbors_right : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) ⊆ ((G).neighborSet v))

/--
source: mathlib
reference: SimpleGraph.Reachable.refl
relationship: specialized
-/
def reachability_reflexive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  ((G).Reachable u u)

/--
source: mathlib
reference: SimpleGraph.Reachable.symm
relationship: specialized
-/
def reachability_symmetric : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (path : ((G).Reachable u v)),
  ((G).Reachable v u)

/--
source: mathlib
reference: SimpleGraph.Reachable.trans
relationship: specialized
-/
def reachability_transitive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ∀ (first : ((G).Reachable u v)),
  ∀ (second : ((G).Reachable v w)),
  ((G).Reachable u w)

/--
source: mathlib
reference: SimpleGraph.Adj.reachable
relationship: specialized
-/
def edge_implies_reachability : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : ((G).Adj u v)),
  ((G).Reachable u v)

/--
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def determinant_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (A * B)) = ((Matrix.det A) * (Matrix.det B)))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def determinant_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (Matrix.transpose A)) = (Matrix.det A))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def determinant_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (A * B)) = (Matrix.det (B * A)))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def determinant_left_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det (A * (B * C))) = (Matrix.det (B * (A * C))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def determinant_right_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.det ((A * B) * C)) = (Matrix.det ((A * C) * B)))

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def determinant_power : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ∀ (k : ℕ),
  ((Matrix.det (A ^ k)) = ((Matrix.det A) ^ k))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def trace_sum : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (A + B)) = ((Matrix.trace A) + (Matrix.trace B)))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def trace_difference : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (A - B)) = ((Matrix.trace A) - (Matrix.trace B)))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def trace_negative : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (-A)) = (-(Matrix.trace A)))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def trace_transpose : Prop :=
  ∀ (n : ℕ),
  ∀ (A : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (Matrix.transpose A)) = (Matrix.trace A))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def trace_product_swap : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace (A * B)) = (Matrix.trace (B * A)))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def trace_cycle : Prop :=
  ∀ (n : ℕ),
  ∀ (A B C : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.trace ((A * B) * C)) = (Matrix.trace ((C * A) * B)))

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
  ((Matrix.transpose (Matrix.transpose A)) = A)

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def transpose_product : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℂ),
  ((Matrix.transpose (A * B)) = ((Matrix.transpose B) * (Matrix.transpose A)))

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
  exact cop.lcm_eq_mul

theorem common_divisor_of_coprimes : CleanStatements.common_divisor_of_coprimes := by
  intro a b k cop divides_a divides_b
  exact Nat.eq_one_of_dvd_coprimes cop divides_a divides_b

theorem coprime_product_divisibility : CleanStatements.coprime_product_divisibility := by
  intro a b k cop
  exact cop.dvd_mul_right

end CleanValidation
