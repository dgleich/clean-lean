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

noncomputable def cleanNotation_6aaed7bf698e562b4aa5  (x0 : List (ℕ)) : List (ℕ) :=
  (List.insertionSort (· ≤ ·)) x0

noncomputable def cleanNotation_51561cc64977417a701c  (x0 : List (ℕ)) : List (ℕ) :=
  (fun l : List ℕ => l.mergeSort (· ≤ ·)) x0

noncomputable def cleanNotation_bb5cb4068b5c2ce6d1ed  (x0 : List (ℕ)) : Prop :=
  List.Sorted (· ≤ ·) x0

noncomputable def cleanNotation_e74b2d2973b6778742ca {T : Type} (x0 : List (T)) (x1 : List (T)) : Prop :=
  List.Perm x0 x1

noncomputable def cleanNotation_6016b9cfd65d60648fc3 {T : Type} (x0 : List (T)) : ℕ :=
  List.length x0

noncomputable def cleanNotation_fc17db7c59c6361dc276  (x0 : ℕ) (x1 : List (ℕ)) : List (ℕ) :=
  List.orderedInsert (· ≤ ·) x0 x1

noncomputable def cleanNotation_8df3385d877a7d8324ae  (x0 : ℕ) (x1 : List (ℕ)) : List (ℕ) :=
  x0 :: x1

noncomputable def cleanNotation_ef3e1617947e64ecf0be {T : Type} (x0 : List (T)) (x1 : List (T)) : Prop :=
  List.Sublist x0 x1

noncomputable def cleanNotation_5c84f457aa0661a1ecbb  (x0 : ℕ) (x1 : List (ℕ)) : ℕ :=
  List.count x0 x1

noncomputable def cleanNotation_afbf80a28ac74f1f01c4  (x0 : List (ℕ)) (x1 : List (ℕ)) : List (ℕ) :=
  List.merge x0 x1 (· ≤ ·)

noncomputable def cleanNotation_c5d38a8d9fdadc4bcfb1  (x0 : ℕ) (x1 : ℕ) : ℕ :=
  Nat.gcd x0 x1

noncomputable def cleanNotation_6a337f2a1fee7d9b19ad  (x0 : ℕ) (x1 : ℕ) : ℕ :=
  Nat.lcm x0 x1

noncomputable def cleanDefine_d8366f033b725ff2b457  (x0 : ℕ) (x1 : ℕ) : Prop :=
  ((cleanNotation_c5d38a8d9fdadc4bcfb1 (x0) (x1)) = 1)

noncomputable def cleanDefine_1e861681a31bda4226df  (xs : List (ℕ)) (ys : List (ℕ)) : Prop :=
  ((cleanNotation_bb5cb4068b5c2ce6d1ed (ys)) ∧ (cleanNotation_e74b2d2973b6778742ca (ys) (xs)))


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
  (cleanNotation_bb5cb4068b5c2ce6d1ed ((cleanNotation_6aaed7bf698e562b4aa5 (xs))))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: specialized
-/
def insertion_sort_permutation : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanNotation_e74b2d2973b6778742ca ((cleanNotation_6aaed7bf698e562b4aa5 (xs))) (xs))

/--
source: mathlib
reference: List.length_insertionSort
relationship: specialized
-/
def insertion_sort_length : Prop :=
  ∀ (xs : List (ℕ)),
  ((cleanNotation_6016b9cfd65d60648fc3 ((cleanNotation_6aaed7bf698e562b4aa5 (xs)))) = (cleanNotation_6016b9cfd65d60648fc3 (xs)))

/--
source: mathlib
reference: List.mem_insertionSort
relationship: specialized
-/
def insertion_sort_membership : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ((a ∈ (cleanNotation_6aaed7bf698e562b4aa5 (xs))) ↔ (a ∈ xs))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: specialized
-/
def sorted_input_unchanged : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (ordered : (cleanNotation_bb5cb4068b5c2ce6d1ed (xs))),
  ((cleanNotation_6aaed7bf698e562b4aa5 (xs)) = xs)

/--
source: mathlib
reference: List.orderedInsert_length
relationship: specialized
-/
def ordered_insert_length : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ((cleanNotation_6016b9cfd65d60648fc3 ((cleanNotation_fc17db7c59c6361dc276 (a) (xs)))) = ((cleanNotation_6016b9cfd65d60648fc3 (xs)) + 1))

/--
source: mathlib
reference: List.mem_orderedInsert
relationship: specialized
-/
def ordered_insert_membership : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a b : ℕ),
  ((b ∈ (cleanNotation_fc17db7c59c6361dc276 (a) (xs))) ↔ ((b = a) ∨ (b ∈ xs)))

/--
source: mathlib
reference: List.perm_orderedInsert
relationship: specialized
-/
def ordered_insert_permutation : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  (cleanNotation_e74b2d2973b6778742ca ((cleanNotation_fc17db7c59c6361dc276 (a) (xs))) ((cleanNotation_8df3385d877a7d8324ae (a) (xs))))

/--
source: mathlib
reference: List.Sorted.orderedInsert
relationship: specialized
-/
def ordered_insert_preserves_sortedness : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  ∀ (ordered : (cleanNotation_bb5cb4068b5c2ce6d1ed (xs))),
  (cleanNotation_bb5cb4068b5c2ce6d1ed ((cleanNotation_fc17db7c59c6361dc276 (a) (xs))))

/--
source: mathlib
reference: List.sorted_mergeSort'
relationship: specialized
-/
def merge_sort_sorted : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanNotation_bb5cb4068b5c2ce6d1ed ((cleanNotation_51561cc64977417a701c (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_self
relationship: specialized
-/
def merge_sort_sorted_input : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (ordered : (cleanNotation_bb5cb4068b5c2ce6d1ed (xs))),
  ((cleanNotation_51561cc64977417a701c (xs)) = xs)

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: specialized
-/
def sorting_algorithms_agree : Prop :=
  ∀ (xs : List (ℕ)),
  ((cleanNotation_51561cc64977417a701c (xs)) = (cleanNotation_6aaed7bf698e562b4aa5 (xs)))

/--
source: mathlib
reference: List.Sorted.merge
relationship: specialized
-/
def merge_preserves_sortedness : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ (hx : (cleanNotation_bb5cb4068b5c2ce6d1ed (xs))),
  ∀ (hy : (cleanNotation_bb5cb4068b5c2ce6d1ed (ys))),
  (cleanNotation_bb5cb4068b5c2ce6d1ed ((cleanNotation_afbf80a28ac74f1f01c4 (xs) (ys))))

/--
source: mathlib
reference: List.sublist_insertionSort
relationship: specialized
-/
def insertion_sort_subsequence : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ (ordered : (cleanNotation_bb5cb4068b5c2ce6d1ed (ys))),
  ∀ (subsequence : (cleanNotation_ef3e1617947e64ecf0be (ys) (xs))),
  (cleanNotation_ef3e1617947e64ecf0be (ys) ((cleanNotation_6aaed7bf698e562b4aa5 (xs))))

/--
source: mathlib
reference: List.sublist_orderedInsert
relationship: specialized
-/
def ordered_insert_contains_input : Prop :=
  ∀ (xs : List (ℕ)),
  ∀ (a : ℕ),
  (cleanNotation_ef3e1617947e64ecf0be (xs) ((cleanNotation_fc17db7c59c6361dc276 (a) (xs))))

/--
source: mathlib
reference: Nat.coprime_add_mul_right_right
relationship: specialized
-/
def euclidean_coprime_reduction : Prop :=
  ∀ (a b k : ℕ),
  ((cleanDefine_d8366f033b725ff2b457 (a) ((b + (k * a)))) ↔ (cleanDefine_d8366f033b725ff2b457 (a) (b)))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def euclidean_coprime_subtraction : Prop :=
  ∀ (a b : ℕ),
  ∀ (ordered : (a ≤ b)),
  ((cleanDefine_d8366f033b725ff2b457 ((b - a)) (a)) ↔ (cleanDefine_d8366f033b725ff2b457 (b) (a)))

/--
source: mathlib
reference: Nat.Coprime.lcm_eq_mul
relationship: specialized
-/
def coprime_lcm_product : Prop :=
  ∀ (a b : ℕ),
  ∀ (cop : (cleanDefine_d8366f033b725ff2b457 (a) (b))),
  ((cleanNotation_6a337f2a1fee7d9b19ad (a) (b)) = (a * b))

/--
source: mathlib
reference: Nat.eq_one_of_dvd_coprimes
relationship: specialized
-/
def common_divisor_of_coprimes : Prop :=
  ∀ (a b k : ℕ),
  ∀ (cop : (cleanDefine_d8366f033b725ff2b457 (a) (b))),
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
  ∀ (cop : (cleanDefine_d8366f033b725ff2b457 (k) (b))),
  ((k ∣ (a * b)) ↔ (k ∣ a))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: adapted
-/
def insertion_sort_certificate : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanDefine_1e861681a31bda4226df (xs) ((cleanNotation_6aaed7bf698e562b4aa5 (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: adapted
-/
def merge_sort_certificate : Prop :=
  ∀ (xs : List (ℕ)),
  (cleanDefine_1e861681a31bda4226df (xs) ((cleanNotation_51561cc64977417a701c (xs))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: adapted
-/
def certified_sort_unchanged : Prop :=
  ∀ (xs ys : List (ℕ)),
  ∀ (certificate : (cleanDefine_1e861681a31bda4226df (xs) (ys))),
  ((cleanNotation_6aaed7bf698e562b4aa5 (ys)) = ys)

end CleanStatements
