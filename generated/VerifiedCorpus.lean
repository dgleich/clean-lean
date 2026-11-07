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

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable abbrev cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable abbrev cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable abbrev cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable abbrev cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable abbrev cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable abbrev cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable abbrev cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable abbrev cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_insertionSort_054943e1f7dcf8820dd0  (x0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  (List.insertionSort (· ≤ ·)) x0

noncomputable def cleanNotation_mergeSort_422f8e9f9ab641bbef74  (x0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  (fun l : List ℕ => l.mergeSort (· ≤ ·)) x0

noncomputable def cleanNotation_sorted_231e15abf8d40ee24d9d  (x0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Sorted (· ≤ ·) x0

noncomputable def cleanNotation_permutation_d6a3d3468da8ff104d3e {T : Type} (x0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) (x1 : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Perm x0 x1

noncomputable def cleanNotation_length_644d39a96951b5cd16f6 {T : Type} (x0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  List.length x0

noncomputable def cleanNotation_insert_601c7aa53134eb475439  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  List.orderedInsert (· ≤ ·) x0 x1

noncomputable def cleanNotation_cons_304f762b948b1f994c88  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  x0 :: x1

noncomputable def cleanNotation_sublist_0a6f73bc7e5e626ac0f6 {T : Type} (x0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) (x1 : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Sublist x0 x1

noncomputable def cleanNotation_count_15a4aec99ae16ff04ded  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  List.count x0 x1

noncomputable def cleanNotation_merge_d1d44239279524c0913a  (x0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) (x1 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  List.merge x0 x1 (· ≤ ·)

noncomputable def cleanNotation_gcd_8064531ce5c51b479273  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  Nat.gcd x0 x1

noncomputable def cleanNotation_lcm_43ed3ca5ce04f6eb5082  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  Nat.lcm x0 x1

noncomputable def cleanDefine_coprime_d877d09f9f558c86b6d8  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((_root_.cleanNotation_gcd_8064531ce5c51b479273 (x0) (x1)) = 1)

noncomputable def cleanDefine_sorting_certificate_f57342a2163eaf7cc370  (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) (ys : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (ys)) ∧ (_root_.cleanNotation_permutation_d6a3d3468da8ff104d3e (ys) (xs)))

noncomputable def cleanNotation_exp_e539dbd0808c5feebb48  (x0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.exp x0

noncomputable def cleanNotation_log_bc42cf59a322aa762d4c  (x0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.log x0

noncomputable def cleanNotation_sqrt_6e06b1a141fb4ca62c3f  (x0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.sqrt x0

noncomputable def cleanNotation_sin_da1f4692a07c6feb0bc4  (x0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.sin x0

noncomputable def cleanNotation_cos_77f567f8e5485861fbc0  (x0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.cos x0

noncomputable def cleanNotation_abs_f5af20d198e156710853  (x0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  abs x0

noncomputable def cleanNotation_continuous_3e14e89527bb6a62bd30  (x0 : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  Continuous x0

noncomputable def cleanNotation_differentiable_0d64dd53cffdd7513212  (x0 : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  Differentiable ℝ x0

noncomputable def cleanNotation_compose_88258263b8482b7d7cb2  (x0 : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) (x1 : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  (x0) ∘ (x1)

noncomputable def cleanDefine_square_cca80e4cc99b8abf50a6  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (x ^ 2)

noncomputable def cleanDefine_squared_distance_650464b878a321e5e766  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_square_cca80e4cc99b8abf50a6 ((x - y)))

noncomputable def cleanDefine_trigonometric_energy_3a6c639017bb6c6ee63c  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  ((_root_.cleanDefine_square_cca80e4cc99b8abf50a6 ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x)))) + (_root_.cleanDefine_square_cca80e4cc99b8abf50a6 ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x)))))

noncomputable def cleanNotation_adjacent_7f8bc3e1774e1d75bf2c {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (x2 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x0).Adj x1 x2

noncomputable def cleanNotation_complement_24d2562fbaf4a9029656 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n)) :=
  (x0)ᶜ

noncomputable def cleanNotation_union_acbfc234fe4f905e5a99 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n)) :=
  x0 ⊔ x1

noncomputable def cleanNotation_intersection_baf68ef5876ec2eba6e8 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n)) :=
  x0 ⊓ x1

noncomputable def cleanNotation_neighbors_9e6108ee5a27908a65ed {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n)))) :=
  (x0).neighborSet x1

noncomputable def cleanNotation_support_9ed009a891fa7f7c4921 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n)))) :=
  (x0).support

noncomputable def cleanNotation_subgraph_d154c34b0527cfa5d29b {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x0 ≤ x1

noncomputable def cleanNotation_reachable_0d1f44d49dc1f591ed92 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (x2 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x0).Reachable x1 x2

noncomputable def cleanNotation_connected_9f3ee7c98bb1150a8f5e {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x0).Connected

noncomputable def cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (x2 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n)))) :=
  ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (x0) (x1)) ∩ (@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (x0) (x2)))

noncomputable def cleanDefine_nonadjacent_03c8ed722b986df5a9e4 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (¬(@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v)))

noncomputable def cleanNotation_det_b17060e1429bb5f6c879 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Matrix.det x0

noncomputable def cleanNotation_trace_a6d69ffafa465de87ae3 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Matrix.trace x0

noncomputable def cleanNotation_transpose_6101efc622459caca1e2 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (m) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Matrix.transpose x0

noncomputable def cleanNotation_inverse_572658027caad3cf5daf {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (x0)⁻¹

noncomputable def cleanDefine_commutator_dba06c66bfa02f3c51a3 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  ((A * B) - (B * A))

noncomputable def cleanDefine_matrix_square_68faae419a8c19d8723f {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
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
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: specialized
-/
def insertion_sort_permutation : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanNotation_permutation_d6a3d3468da8ff104d3e ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))) (xs))

/--
source: mathlib
reference: List.length_insertionSort
relationship: specialized
-/
def insertion_sort_length : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ((_root_.cleanNotation_length_644d39a96951b5cd16f6 ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs)))) = (_root_.cleanNotation_length_644d39a96951b5cd16f6 (xs)))

/--
source: mathlib
reference: List.mem_insertionSort
relationship: specialized
-/
def insertion_sort_membership : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ((a ∈ (_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))) ↔ (a ∈ xs))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: specialized
-/
def sorted_input_unchanged : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (xs))),
  ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs)) = xs)

/--
source: mathlib
reference: List.orderedInsert_length
relationship: specialized
-/
def ordered_insert_length : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ((_root_.cleanNotation_length_644d39a96951b5cd16f6 ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs)))) = ((_root_.cleanNotation_length_644d39a96951b5cd16f6 (xs)) + 1))

/--
source: mathlib
reference: List.mem_orderedInsert
relationship: specialized
-/
def ordered_insert_membership : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ((b ∈ (_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))) ↔ ((b = a) ∨ (b ∈ xs)))

/--
source: mathlib
reference: List.perm_orderedInsert
relationship: specialized
-/
def ordered_insert_permutation : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanNotation_permutation_d6a3d3468da8ff104d3e ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))) ((_root_.cleanNotation_cons_304f762b948b1f994c88 (a) (xs))))

/--
source: mathlib
reference: List.Sorted.orderedInsert
relationship: specialized
-/
def ordered_insert_preserves_sortedness : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («ordered» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (xs))),
  (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))))

/--
source: mathlib
reference: List.sorted_mergeSort'
relationship: specialized
-/
def merge_sort_sorted : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_self
relationship: specialized
-/
def merge_sort_sorted_input : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (xs))),
  ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs)) = xs)

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: specialized
-/
def sorting_algorithms_agree : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs)) = (_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs)))

/--
source: mathlib
reference: List.Sorted.merge
relationship: specialized
-/
def merge_preserves_sortedness : Prop :=
  ∀ (xs ys : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («hx» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (xs))),
  ∀ («hy» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (ys))),
  (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d ((_root_.cleanNotation_merge_d1d44239279524c0913a (xs) (ys))))

/--
source: mathlib
reference: List.sublist_insertionSort
relationship: specialized
-/
def insertion_sort_subsequence : Prop :=
  ∀ (xs ys : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (ys))),
  ∀ («subsequence» : (_root_.cleanNotation_sublist_0a6f73bc7e5e626ac0f6 (ys) (xs))),
  (_root_.cleanNotation_sublist_0a6f73bc7e5e626ac0f6 (ys) ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))

/--
source: mathlib
reference: List.sublist_orderedInsert
relationship: specialized
-/
def ordered_insert_contains_input : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanNotation_sublist_0a6f73bc7e5e626ac0f6 (xs) ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))))

/--
source: mathlib
reference: Nat.coprime_add_mul_right_right
relationship: specialized
-/
def euclidean_coprime_reduction : Prop :=
  ∀ (a b k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ((_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 (a) ((b + (k * a)))) ↔ (_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 (a) (b)))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def euclidean_coprime_subtraction : Prop :=
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («ordered» : (a ≤ b)),
  ((_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 ((b - a)) (a)) ↔ (_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 (b) (a)))

/--
source: mathlib
reference: Nat.Coprime.lcm_eq_mul
relationship: specialized
-/
def coprime_lcm_product : Prop :=
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 (a) (b))),
  ((_root_.cleanNotation_lcm_43ed3ca5ce04f6eb5082 (a) (b)) = (a * b))

/--
source: mathlib
reference: Nat.eq_one_of_dvd_coprimes
relationship: specialized
-/
def common_divisor_of_coprimes : Prop :=
  ∀ (a b k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 (a) (b))),
  ∀ («divides_a» : (k ∣ a)),
  ∀ («divides_b» : (k ∣ b)),
  (k = 1)

/--
source: mathlib
reference: Nat.Coprime.dvd_mul_right
relationship: specialized
-/
def coprime_product_divisibility : Prop :=
  ∀ (a b k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_d877d09f9f558c86b6d8 (k) (b))),
  ((k ∣ (a * b)) ↔ (k ∣ a))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: adapted
-/
def insertion_sort_certificate : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_sorting_certificate_f57342a2163eaf7cc370 (xs) ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: adapted
-/
def merge_sort_certificate : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_sorting_certificate_f57342a2163eaf7cc370 (xs) ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: adapted
-/
def certified_sort_unchanged : Prop :=
  ∀ (xs ys : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («certificate» : (_root_.cleanDefine_sorting_certificate_f57342a2163eaf7cc370 (xs) (ys))),
  ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (ys)) = ys)

/--
source: mathlib
reference: Real.exp_pos
relationship: specialized
-/
def exponential_positive : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (0 < (_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x)))

/--
source: mathlib
reference: Real.exp_ne_zero
relationship: specialized
-/
def exponential_nonzero : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x)) ≠ 0)

/--
source: mathlib
reference: Real.exp_add
relationship: specialized
-/
def exponential_sum : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 ((x + y))) = ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x)) * (_root_.cleanNotation_exp_e539dbd0808c5feebb48 (y))))

/--
source: mathlib
reference: Real.exp_sub
relationship: specialized
-/
def exponential_difference : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 ((x - y))) = ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x)) / (_root_.cleanNotation_exp_e539dbd0808c5feebb48 (y))))

/--
source: mathlib
reference: Real.log_exp
relationship: specialized
-/
def logarithm_exponential : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_log_bc42cf59a322aa762d4c ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x)))) = x)

/--
source: mathlib
reference: Real.exp_log
relationship: specialized
-/
def exponential_logarithm : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («positive» : (0 < x)),
  ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (x)))) = x)

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def logarithm_product : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonzero_x» : (x ≠ 0)),
  ∀ («nonzero_y» : (y ≠ 0)),
  ((_root_.cleanNotation_log_bc42cf59a322aa762d4c ((x * y))) = ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (x)) + (_root_.cleanNotation_log_bc42cf59a322aa762d4c (y))))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def logarithm_quotient : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonzero_x» : (x ≠ 0)),
  ∀ («nonzero_y» : (y ≠ 0)),
  ((_root_.cleanNotation_log_bc42cf59a322aa762d4c ((x / y))) = ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (x)) - (_root_.cleanNotation_log_bc42cf59a322aa762d4c (y))))

/--
source: mathlib
reference: Real.sqrt_nonneg
relationship: specialized
-/
def square_root_nonnegative : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (0 ≤ (_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (x)))

/--
source: mathlib
reference: Real.sq_sqrt
relationship: specialized
-/
def square_of_square_root : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonnegative» : (0 ≤ x)),
  (((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (x)) ^ 2) = x)

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: specialized
-/
def square_root_of_square : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((x ^ 2))) = (_root_.cleanNotation_abs_f5af20d198e156710853 (x)))

/--
source: mathlib
reference: Real.sqrt_mul
relationship: specialized
-/
def square_root_product : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonnegative» : (0 ≤ x)),
  ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((x * y))) = ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (x)) * (_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (y))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: specialized
-/
def trigonometric_identity : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x)) ^ 2) + ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x)) ^ 2)) = 1)

/--
source: mathlib
reference: Real.sin_add
relationship: specialized
-/
def sine_addition : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 ((x + y))) = (((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x)) * (_root_.cleanNotation_cos_77f567f8e5485861fbc0 (y))) + ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x)) * (_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (y)))))

/--
source: mathlib
reference: Real.cos_add
relationship: specialized
-/
def cosine_addition : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 ((x + y))) = (((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x)) * (_root_.cleanNotation_cos_77f567f8e5485861fbc0 (y))) - ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x)) * (_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (y)))))

/--
source: mathlib
reference: Real.sin_neg
relationship: specialized
-/
def sine_odd : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 ((-x))) = (-(_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x))))

/--
source: mathlib
reference: Real.cos_neg
relationship: specialized
-/
def cosine_even : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 ((-x))) = (_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x)))

/--
source: mathlib
reference: Continuous.comp
relationship: specialized
-/
def continuous_composition : Prop :=
  ∀ (f g : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (f))),
  ∀ («hg» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (g))),
  (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 ((_root_.cleanNotation_compose_88258263b8482b7d7cb2 (f) (g))))

/--
source: mathlib
reference: Continuous.add
relationship: specialized
-/
def continuous_sum : Prop :=
  ∀ (f g : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (f))),
  ∀ («hg» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (g))),
  (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 ((f + g)))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def continuous_product : Prop :=
  ∀ (f g : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (f))),
  ∀ («hg» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (g))),
  (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 ((f * g)))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def authored_square_root : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanDefine_square_cca80e4cc99b8abf50a6 (x)))) = (_root_.cleanNotation_abs_f5af20d198e156710853 (x)))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: adapted
-/
def authored_trigonometric_energy : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanDefine_trigonometric_energy_3a6c639017bb6c6ee63c (x)) = 1)

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def distance_square_root : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanDefine_squared_distance_650464b878a321e5e766 (x) (y)))) = (_root_.cleanNotation_abs_f5af20d198e156710853 ((x - y))))

/--
source: mathlib
reference: SimpleGraph.adj_symm
relationship: specialized
-/
def adjacency_symmetry : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ∀ («edge» : (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))),
  (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (v) (u))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: specialized
-/
def adjacency_commutes : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v)) ↔ (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def no_self_edges : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (¬(@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (u)))

/--
source: mathlib
reference: SimpleGraph.ne_of_adj
relationship: specialized
-/
def adjacent_vertices_distinct : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ∀ («edge» : (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))),
  (u ≠ v)

/--
source: mathlib
reference: SimpleGraph.sup_adj
relationship: specialized
-/
def union_adjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G H : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_union_acbfc234fe4f905e5a99 (n) (G) (H))) (u) (v)) ↔ ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v)) ∨ (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (H) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def intersection_adjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G H : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_intersection_baf68ef5876ec2eba6e8 (n) (G) (H))) (u) (v)) ↔ ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v)) ∧ (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (H) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def complement_adjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_complement_24d2562fbaf4a9029656 (n) (G))) (u) (v)) ↔ ((u ≠ v) ∧ (¬(@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v)))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def support_monotonicity : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G H : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ («inclusion» : (@_root_.cleanNotation_subgraph_d154c34b0527cfa5d29b (n) (G) (H))),
  ((@_root_.cleanNotation_support_9ed009a891fa7f7c4921 (n) (G)) ⊆ (@_root_.cleanNotation_support_9ed009a891fa7f7c4921 (n) (H)))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def neighbors_in_support : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u)) ⊆ (@_root_.cleanNotation_support_9ed009a891fa7f7c4921 (n) (G)))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def neighbor_membership : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((v ∈ (@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))) ↔ (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v)))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def not_own_neighbor : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (¬(u ∈ (@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def common_neighbors_intersection : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 (n) (G) (u) (v)) = ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u)) ∩ (@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (v))))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def common_neighbors_membership : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v w : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((w ∈ (@_root_.cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 (n) (G) (u) (v))) ↔ ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (w)) ∧ (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (v) (w))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def common_neighbors_symmetry : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 (n) (G) (u) (v)) = (@_root_.cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 (n) (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def common_neighbors_left : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 (n) (G) (u) (v)) ⊆ (@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def common_neighbors_right : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanDefine_commonNeighbors_f3bb190c0d77e6d051d5 (n) (G) (u) (v)) ⊆ (@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (v)))

/--
source: mathlib
reference: SimpleGraph.Reachable.refl
relationship: specialized
-/
def reachability_reflexive : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.Reachable.symm
relationship: specialized
-/
def reachability_symmetric : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ∀ («path» : (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (u) (v))),
  (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (v) (u))

/--
source: mathlib
reference: SimpleGraph.Reachable.trans
relationship: specialized
-/
def reachability_transitive : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v w : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ∀ («first» : (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (u) (v))),
  ∀ («second» : (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (v) (w))),
  (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (u) (w))

/--
source: mathlib
reference: SimpleGraph.Adj.reachable
relationship: specialized
-/
def edge_implies_reachability : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ∀ («edge» : (@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))),
  (@_root_.cleanNotation_reachable_0d1f44d49dc1f591ed92 (n) (G) (u) (v))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: adapted
-/
def nonadjacency_symmetry : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanDefine_nonadjacent_03c8ed722b986df5a9e4 (n) (G) (u) (v)) ↔ (@_root_.cleanDefine_nonadjacent_03c8ed722b986df5a9e4 (n) (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: adapted
-/
def nonadjacency_reflexive : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (@_root_.cleanDefine_nonadjacent_03c8ed722b986df5a9e4 (n) (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: adapted
-/
def complement_from_nonadjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_complement_24d2562fbaf4a9029656 (n) (G))) (u) (v)) ↔ ((u ≠ v) ∧ (@_root_.cleanDefine_nonadjacent_03c8ed722b986df5a9e4 (n) (G) (u) (v))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def determinant_product : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((A * B))) = ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A)) * (@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (B))))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def determinant_transpose : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A)))) = (@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A)))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def determinant_product_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((A * B))) = (@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((B * A))))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def determinant_left_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B C : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((A * (B * C)))) = (@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((B * (A * C)))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def determinant_right_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B C : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (((A * B) * C))) = (@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (((A * C) * B))))

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def determinant_power : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((A ^ k))) = ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A)) ^ k))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def trace_sum : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((A + B))) = ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A)) + (@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (B))))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def trace_difference : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((A - B))) = ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A)) - (@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (B))))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def trace_negative : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((-A))) = (-(@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A))))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def trace_transpose : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A)))) = (@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A)))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def trace_product_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((A * B))) = (@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((B * A))))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def trace_cycle : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B C : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (((A * B) * C))) = (@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (((C * A) * B))))

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: specialized
-/
def matrix_vector_associativity : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((A *ᵥ (B *ᵥ x)) = ((A * B) *ᵥ x))

/--
source: mathlib
reference: Matrix.mulVec_add
relationship: specialized
-/
def matrix_vector_addition : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((A *ᵥ (x + y)) = ((A *ᵥ x) + (A *ᵥ y)))

/--
source: mathlib
reference: Matrix.add_mulVec
relationship: specialized
-/
def matrix_addition_action : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (((A + B) *ᵥ x) = ((A *ᵥ x) + (B *ᵥ x)))

/--
source: mathlib
reference: Matrix.mulVec_sub
relationship: specialized
-/
def matrix_vector_subtraction : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((A *ᵥ (x - y)) = ((A *ᵥ x) - (A *ᵥ y)))

/--
source: mathlib
reference: Matrix.sub_mulVec
relationship: specialized
-/
def matrix_subtraction_action : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (((A - B) *ᵥ x) = ((A *ᵥ x) - (B *ᵥ x)))

/--
source: mathlib
reference: Matrix.mulVec_smul
relationship: specialized
-/
def matrix_scalar_action : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (c : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)),
  ((A *ᵥ (c • x)) = (c • (A *ᵥ x)))

/--
source: mathlib
reference: Matrix.transpose_transpose
relationship: specialized
-/
def transpose_involution : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A)))) = A)

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def transpose_product : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) ((A * B))) = ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (B)) * (@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_commutator : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanDefine_commutator_dba06c66bfa02f3c51a3 (n) (A) (B)))) = 0)

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_matrix_square : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanDefine_matrix_square_68faae419a8c19d8723f (n) (A)))) = (@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((A * A))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: adapted
-/
def determinant_matrix_square : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanDefine_matrix_square_68faae419a8c19d8723f (n) (A)))) = ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A)) * (@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A))))

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
