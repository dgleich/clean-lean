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

end CleanStatements
