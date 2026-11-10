import Lean
import Mathlib.Tactic.Linarith
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
import Mathlib.Topology.Basic
import Mathlib.Topology.Category.TopCat.Basic
import Mathlib.Topology.Path
import Mathlib.Topology.Instances.Real.Lemmas

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
-/

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
-/

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanNumeral_Natural_47460cb427d00c0cfbad (digits : Nat) : _root_.cleanType_Natural_469c53b6dafb7a218246 :=
  (fun n : Nat => n) digits

noncomputable abbrev cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanNumeral_Real_1f10813a9ce4dc61fe3e (digits : Nat) : _root_.cleanType_Real_107b6641a486642ad8e1 :=
  (fun n : Nat => (n : Real)) digits

noncomputable abbrev cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanNumeral_Complex_311fd057b7f2e2b599a3 (digits : Nat) : _root_.cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  (fun n : Nat => (n : Complex)) digits

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

noncomputable def cleanDefine_equal_59dc0f11ba9b345348cf {T : Type} (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_unequal_d9953e236b6d48fdc435 {T : Type} (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x≠y

noncomputable def cleanDefine_conjunction_41680d3b84ab96b0cab9  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∧ y

noncomputable def cleanDefine_disjunction_2a3db8ccf67a84818535  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∨ y

noncomputable def cleanDefine_implication_3b80760984def210df07  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (x)), y)

noncomputable def cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ↔ y

noncomputable def cleanDefine_negation_7efde94db326666449aa  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ¬x

noncomputable def cleanNotation_natural_sum_884ddbcff666dc390f99  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x+y

noncomputable def cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x-y

noncomputable def cleanNotation_natural_product_0c2b2fc759f8d93a79af  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x*y

noncomputable def cleanNotation_natural_quotient_63215131d48d82141673  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x/y

noncomputable def cleanNotation_natural_power_f37e8edc75e11de4f79f  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x^y

noncomputable def cleanDefine_natural_less_b8fc7193a9665e88d3b6  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x < y

noncomputable def cleanDefine_natural_greater_23882d0ad7414f5fa712  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x > y

noncomputable def cleanDefine_natural_at_most_0a7e9519b4591123e4b5  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≤ y

noncomputable def cleanDefine_natural_at_least_1f7788490aef44ad03e2  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≥ y

noncomputable def cleanNotation_real_sum_8dd895080a4442dce6f9  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x+y

noncomputable def cleanNotation_real_difference_bf838970af972a894b2c  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x-y

noncomputable def cleanNotation_real_product_4734d65dbf4a4907df19  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x*y

noncomputable def cleanNotation_real_quotient_7f1e597c9bc99f29eb9f  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x/y

noncomputable def cleanNotation_real_power_c22d5a3a02ef7c3e8476  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x^y

noncomputable def cleanNotation_real_negative_b76c1fb39b30169ebf0c  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  -x

noncomputable def cleanDefine_real_less_23e496cb1d1d1ff9fdb3  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x < y

noncomputable def cleanDefine_real_greater_aabc7b9eba1731c41674  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x > y

noncomputable def cleanDefine_real_at_most_51ad2818948d6e758423  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≤ y

noncomputable def cleanDefine_real_at_least_6add8f72594b91ec8f2f  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≥ y

noncomputable def cleanNotation_complex_sum_bd573e52561d38e6ff7c  (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x+y

noncomputable def cleanNotation_complex_difference_6626fd74d7228c0d7311  (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x-y

noncomputable def cleanNotation_complex_product_3b0736bee3e3b1076e08  (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x*y

noncomputable def cleanNotation_complex_quotient_57d9bf2f03c053c44cd6  (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x/y

noncomputable def cleanNotation_complex_power_906a3151c2a5ce5d65e4  (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x^y

noncomputable def cleanNotation_complex_negative_51dd3ea89467eda5e232  (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  -x

noncomputable def cleanNotation_real_matrix_sum_e19630141187aa6f07e1 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x+y

noncomputable def cleanNotation_real_matrix_difference_463c21a754e4e79263e8 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x-y

noncomputable def cleanNotation_real_matrix_product_0044aa3ec11cf3f33b19 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {p : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (p) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (p) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x*y

noncomputable def cleanNotation_real_matrix_application_218fadfbc5d4d0ebbebb {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (m) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  Matrix.mulVec x y

noncomputable def cleanNotation_real_scale_matrix_662b6da028dde47e4f6f {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x • y

noncomputable def cleanNotation_real_scale_vector_07a768dc3d63ec01282d {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x • y

noncomputable def cleanNotation_complex_matrix_sum_b9380385a8a68783970a {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x+y

noncomputable def cleanNotation_complex_matrix_difference_531d9a82ff8c5cf3cfa1 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x-y

noncomputable def cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {p : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (p) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (p) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x*y

noncomputable def cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (m) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Matrix.mulVec x y

noncomputable def cleanNotation_complex_scale_matrix_701c33198a768dfdfbaf {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x • y

noncomputable def cleanNotation_complex_scale_vector_7380ed66e1843ba52457 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x • y

noncomputable def cleanDefine_natural_divides_2611187ff6f65c3a68d5  (x : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∣ y

noncomputable def cleanDefine_set_member_d7f862196f8cd9ab892e {T : Type} (x : T) (A : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∈ A

noncomputable def cleanDefine_list_member_a533590d6d1f9d128c19 {T : Type} (x : T) (A : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∈ A

noncomputable def cleanDefine_set_subset_a67e41d93cfd162885cf {T : Type} (A : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (B : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  A ⊆ B

noncomputable def cleanNotation_set_intersection_855b89f2e32edc747a4a {T : Type} (A : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (B : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : (_root_.cleanType_Set_6e300741358eee425e81 (T)) :=
  A ∩ B

noncomputable def cleanNotation_set_union_415f0bd1477a58bfb237 {T : Type} (A : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (B : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : (_root_.cleanType_Set_6e300741358eee425e81 (T)) :=
  A ∪ B

noncomputable def cleanNotation_real_matrix_power_e180d01a615955b9f912 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x^y

noncomputable def cleanNotation_real_vector_sum_a91c1a514cadae8ccaac {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x+y

noncomputable def cleanNotation_real_vector_difference_17e0cfb0601997065abe {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x-y

noncomputable def cleanNotation_complex_matrix_power_ed861b14d9d2bce71a27 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x^y

noncomputable def cleanNotation_complex_vector_sum_8df2cd2278f18dff6264 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x+y

noncomputable def cleanNotation_complex_vector_difference_ff1264527886b3e9c788 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x-y

noncomputable def cleanNotation_pointwise_real_sum_658be1682631e14b5a8a  (x : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) (y : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  x+y

noncomputable def cleanNotation_pointwise_real_product_56b5da1e82e37c8b945c  (x : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) (y : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  x*y

noncomputable def cleanNotation_real_matrix_negative_43d4aeae39c9128af6ff {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  -x

noncomputable def cleanNotation_complex_matrix_negative_b1e417c57fa2fdf4e73e {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  -x

noncomputable abbrev cleanType_Topology_2eca621ea710e87cf174 (X : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanNotation_set_of_2c71fd475f49a65bd03e {X : Type} (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  setOf condition

noncomputable def cleanDefine_open_in_2f000176928f8b3f5fc4 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @IsOpen X t S

noncomputable def cleanDefine_inverse_image_22bc73bac0cb61752f41 {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (Y))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => (_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((f clean_bound_0)) (S)))))

noncomputable def cleanDefine_image_2da051e82d83c8057192 {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : (_root_.cleanType_Set_6e300741358eee425e81 (Y)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : Y) => (@Exists (X) (fun (clean_bound_1 : X) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (clean_bound_1) (S))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((f clean_bound_1)) (clean_bound_0)))))))))

noncomputable def cleanDefine_compose_maps_b7e7219a131a4bb5245c {X : Type} {Y : Type} {Z : Type} (g : (Y) → (Z)) (f : (X) → (Y)) : (X) → (Z) :=
  (fun (clean_bound_0 : X) => (g (f clean_bound_0)))

noncomputable def cleanDefine_continuous_between_8dd83630931b94d3a3c6 {X : Type} {Y : Type} (f : (X) → (Y)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Set_6e300741358eee425e81 (Y))), (_root_.cleanDefine_implication_3b80760984def210df07 ((_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 (clean_bound_0) (u))) ((_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 (f) (clean_bound_0))) (t)))))

noncomputable def cleanDefine_selected_elements_405f5b391e3996990e41 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (clean_bound_0) (S))) ((condition clean_bound_0))))))

noncomputable def cleanDefine_intersection_family_892b3d89c4dc28f0effe {I : Type} {X : Type} (sets : (I) → ((_root_.cleanType_Set_6e300741358eee425e81 (X)))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => (∀ (clean_bound_1 : I), (_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (clean_bound_0) ((sets clean_bound_1)))))))

noncomputable abbrev cleanType_TopologicalSpace_d66be29262ccb5d89e3b  : Type 1 :=
  TopCat.{0}

noncomputable def cleanDefine_same_space_d9b673494ac12b717c28  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  X = Y

noncomputable abbrev cleanType_Point_f8a65e23875fb9a2c125 (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (TopCat.carrier X)

noncomputable abbrev cleanType_ContinuousMap_05cf8501fbb474169b7a (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier Y.carrier X.str Y.str)

noncomputable def cleanNotation_topological_space_dc14231c2f4f1a05c1eb  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
  @TopCat.of.{0} X t

noncomputable def cleanNotation_space_topology_d65bd6911832f73ca5e3  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Topology_2eca621ea710e87cf174 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X)))) :=
  TopCat.str X

noncomputable def cleanNotation_underlying_continuous_map_4c98c5280d9a83caf5c3  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) → ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (Y))) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f

noncomputable def cleanNotation_continuous_value_e3b2704dc348962834fc  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (Y)) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x

noncomputable def cleanNotation_identity_continuous_map_3328841a46298311ee43  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (X)) :=
  @ContinuousMap.id X.carrier X.str

noncomputable def cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Z : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (Y) (Z))) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Z)) :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

structure cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1  : Type 1 where
  «source» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «target» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «arrow» : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a («source») («target»))

noncomputable def cleanConstructor_topological_diagram_ccce48ab8336c31ce6a9 («source» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («target» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («arrow» : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a («source») («target»))) : _root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1 :=
  @_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.mk «source» «target» «arrow»

noncomputable def cleanDefine_identity_diagram_4eaea8dd61f4669fc3a0  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : _root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1 :=
  (@_root_.cleanConstructor_topological_diagram_ccce48ab8336c31ce6a9 (X) (X) ((@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 (X))))

noncomputable abbrev cleanType_Element_4fb2f1b669ed36f80886 (X : Type) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : Type :=
  {x : X // x ∈ S}

noncomputable abbrev cleanType_Path_2e5bf3c806cfad5a1ae9 (X : Type) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_underlying_point_5fc735e8b58c86463a25 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (S))) : X :=
  x.val

noncomputable def cleanNotation_constant_path_e6a080b4f4baea9e3c6a {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (x)) :=
  @Path.refl X t x

noncomputable def cleanNotation_reverse_path_bccacbe82db41fbe7c6d {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (y) (x)) :=
  @Path.symm X t x y p

noncomputable def cleanNotation_join_paths_413579dc3782617ff91d {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (z : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) (q : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (y) (z))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (z)) :=
  @Path.trans X t x y z p q

noncomputable def cleanDefine_reverse_twice_19c7d7336839bf577a5b {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y)) :=
  (@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) (t) (y) (x) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) (t) (x) (y) (p))))

/--
A topology, two points, and a path between them, on a fixed carrier.
-/
structure cleanStructure_BasedPath_70f574d7589934963ee1 («X» : Type) : Type where
  «topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))
  «start» : «X»
  «finish» : «X»
  «path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))

noncomputable def cleanConstructor_based_path_2b5edffd368145e026ec («X» : Type) («topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))) («start» : «X») («finish» : «X») («path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 («X») :=
  @_root_.cleanStructure_BasedPath_70f574d7589934963ee1.mk «X» «topology» «start» «finish» «path»

noncomputable def cleanDefine_reversed_bundle_89d7b5d246c5c673d41c  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X) :=
  (@_root_.cleanConstructor_based_path_2b5edffd368145e026ec (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P))))))

structure cleanStructure_Endpoints_7a6ba0b879274641120c  : Type where
  «lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)

noncomputable def cleanConstructor_endpoints_3622a2317e61075ae5a0 («lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  @_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.mk «lower» «upper»

noncomputable def cleanDefine_ordered_endpoints_8c764d0c2fff2efbc5b8  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_real_less_23e496cb1d1d1ff9fdb3 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))))

noncomputable def cleanDefine_shifted_endpoints_56dbb0aee032fece61c6  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (s : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  (@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (s))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (s))))

noncomputable abbrev cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_9ca9e49e1312ca23ac23   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_false_value_30a63b75654d87153a83   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable abbrev cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)

noncomputable def cleanNotation_underlying_real_map_0b69f7fea7146ae09669  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) : ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f

structure cleanStructure_EndpointSelection_417d89980a2c354c2182  : Type where
  «lower» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)
  «upper» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)

noncomputable def cleanConstructor_endpoint_selection_f2c54850f699491deae8 («lower» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) («upper» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  @_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.mk «lower» «upper»

noncomputable def cleanDefine_no_endpoints_3aad239e18f86ce44c68   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_false_value_30a63b75654d87153a83)) ((_root_.cleanNotation_false_value_30a63b75654d87153a83)))

noncomputable def cleanDefine_lower_endpoint_c404a3843e685ffaf059   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ((_root_.cleanNotation_false_value_30a63b75654d87153a83)))

noncomputable def cleanDefine_upper_endpoint_06a0ff0e6593640bb148   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_false_value_30a63b75654d87153a83)) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))

noncomputable def cleanDefine_both_endpoints_5b72385d3bc820377d4f   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))

noncomputable def cleanDefine_closed_interval_6ff374769e42838e17c5  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (clean_bound_0))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))))))))

noncomputable def cleanDefine_selected_endpoints_0c6530af3fba0a8ca281  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))))))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))))))))))

noncomputable def cleanDefine_expanded_interval_f798e8fd37d9631212b9  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (r))) (clean_bound_0))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (r)))))))))

noncomputable def cleanDefine_expanded_endpoints_69c934e5376bdc2f2867  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (r))) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (r))))))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (r))) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (r)))))))))))

structure cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc  : Type 1 where
  «space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 («space»))
  «interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c
  «selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182

noncomputable def cleanConstructor_interlevel_problem_53885bc5547eca082a8b («space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 («space»))) («interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc :=
  @_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.mk «space» «map» «interval» «selection»

structure cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))

noncomputable def cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 («X») :=
  @_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.mk «X» «ambient» «relative»

noncomputable def cleanDefine_nested_pair_081cfd12251352debe01  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))))

noncomputable def cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_expanded_interval_f798e8fd37d9631212b9 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (r))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_expanded_endpoints_69c934e5376bdc2f2867 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))) (r))))))

noncomputable def cleanDefine_shifted_pair_839ea777ea6079fe1438  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (t : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 ((_root_.cleanDefine_shifted_endpoints_56dbb0aee032fece61c6 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (t))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 ((_root_.cleanDefine_shifted_endpoints_56dbb0aee032fece61c6 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (t))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))))))))

noncomputable def cleanDefine_pair_included_in_0f8f1153fc26493cf3ad  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (R : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (R))))) ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (R))))))

noncomputable def cleanDefine_real_map_value_829bba0c597453819c48  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 (X) (f))) (x))

noncomputable def cleanDefine_bounded_perturbation_0dede816ed35ab14c798  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Point_f8a65e23875fb9a2c125 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))), (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c (r))) ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h) (clean_bound_0))) ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) (clean_bound_0))))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h) (clean_bound_0))) ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) (clean_bound_0))))) (r)))))

noncomputable def cleanDefine_perturbed_pair_e76c2b7c221b8b14082e  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h))) ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))))))))

structure cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36 («X» : Type) : Type where
  «source» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))
  «target» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))
  «containment» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf («source») («target»)))

noncomputable def cleanConstructor_certified_inclusion_e027ea2c65afaeddb1cb («X» : Type) («source» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))) («target» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))) («containment» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf («source») («target»)))) : _root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36 («X») :=
  @_root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36.mk «X» «source» «target» «containment»

noncomputable def cleanNotation_subset_inclusion_map_750ef592c28205426398  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (h : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf (S) (T)))) : ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (S))) → ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (T))) :=
  Set.inclusion h

noncomputable def cleanDefine_certified_inclusion_map_83dd8ffeca22d2520f64  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (Q : _root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36 (X)) : ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) ((@_root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36.«source» (X) (Q))))) → ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) ((@_root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36.«target» (X) (Q))))) :=
  (@_root_.cleanNotation_subset_inclusion_map_750ef592c28205426398 (X) ((@_root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36.«source» (X) (Q))) ((@_root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36.«target» (X) (Q))) ((@_root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36.«containment» (X) (Q))))

noncomputable def cleanDefine_subset_certificate_b56685a8cde869a4bc37 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (h : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf (S) (T)))) : _root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36 (X) :=
  (@_root_.cleanConstructor_certified_inclusion_e027ea2c65afaeddb1cb (X) (S) (T) (h))

structure cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «nesting» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf («relative») («ambient»)))

noncomputable def cleanConstructor_topological_pair_f1f6ec54a2edb8f96e06 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («nesting» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf («relative») («ambient»)))) : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 («X») :=
  @_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.mk «X» «ambient» «relative» «nesting»

structure cleanStructure_PairInclusion_ee25aff32607b8147010 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «source» : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 («X»)
  «target» : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 («X»)
  «ambient» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» («X») («target»)))))
  «relative» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» («X») («target»)))))

noncomputable def cleanConstructor_pair_inclusion_b3b5f87a6a3fe9059428 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («source» : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 («X»)) («target» : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 («X»)) («ambient» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» («X») («target»)))))) («relative» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» («X») («target»)))))) : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 («X») :=
  @_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.mk «X» «source» «target» «ambient» «relative»

noncomputable def cleanDefine_ambient_inclusion_224409fce796a1087755  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : _root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) :=
  (@_root_.cleanDefine_subset_certificate_b56685a8cde869a4bc37 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«ambient» (X) (Q))))

noncomputable def cleanDefine_relative_inclusion_8ae54bb9a8f2f01f8e89  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : _root_.cleanStructure_SubsetInclusion_4e40f5a9ea7a4c0a1e36 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) :=
  (@_root_.cleanDefine_subset_certificate_b56685a8cde869a4bc37 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«relative» (X) (Q))))

noncomputable def cleanNotation_subspace_c5a9f0dd775aa465e7fc  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
  (letI : TopologicalSpace X.carrier := X.str; TopCat.of S)

noncomputable def cleanNotation_subspace_inclusion_adcaf46bdb354b21c097  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (T : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (h : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf (S) (T)))) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (S))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (T)))) :=
  (letI : TopologicalSpace X.carrier := X.str; ContinuousMap.inclusion h)

noncomputable def cleanDefine_ambient_continuous_map_6f12f759e7ef2a177a6e  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«ambient» (X) (Q))))

noncomputable def cleanDefine_relative_continuous_map_bd861f61cac595a9f575  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«relative» (X) (Q))))

noncomputable def cleanDefine_ambient_composite_532809f1b67eea4d954f  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))) ((@_root_.cleanDefine_ambient_continuous_map_6f12f759e7ef2a177a6e (X) (Q))) ((@_root_.cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«nesting» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))

noncomputable def cleanDefine_relative_composite_354483b04dc13bf11fb1  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))) ((@_root_.cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«nesting» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))) ((@_root_.cleanDefine_relative_continuous_map_bd861f61cac595a9f575 (X) (Q))))

noncomputable def cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (h : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q)))))) : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X) :=
  (@_root_.cleanConstructor_topological_pair_f1f6ec54a2edb8f96e06 (X) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) (h))

noncomputable def cleanDefine_has_pair_data_28914c997308e957942c  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X)) (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))))))

noncomputable def cleanDefine_certify_pair_inclusion_56f49733534c168f2042  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (s : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S)))))) (t : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T)))))) (a : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T)))))) (b : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T)))))) : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X) :=
  (@_root_.cleanConstructor_pair_inclusion_b3b5f87a6a3fe9059428 (X) ((@_root_.cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 (X) (S) (s))) ((@_root_.cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 (X) (T) (t))) (a) (b))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
```latex
Write $P=(X,f,(a,b),E)$ for the ambient space, continuous map, endpoints,
and endpoint selection. The selection has four values: none, lower, upper, both.
In the following notation, regard $E$ as its selected subset of $\{a,b\}$.
The expanded pair $X_r(P)$ has components $f^{-1}[a-r,b+r]$ and
$f^{-1}(\bigcup_{e\in E}[e-r,e+r])$.
The shifted pair $T_t(P)$ has components $f^{-1}[a+t,b+t]$ and $f^{-1}(E+t)$.
For a perturbation $h$, $A(P,h)$ has components $h^{-1}[a,b]$ and $h^{-1}(E)$.
Pair inclusion means inclusion of both components. These results establish
set inclusions and certified pair inclusions; they do not assert the well-group characterization.
A certified pair $Q$ represents pair data $S$ when their ambient subsets agree
and their relative subsets agree. A certified inclusion stores the nesting
and both component-inclusion proofs.
```
-/

/--
source: topology
reference: two Boolean endpoint flags
relationship: original
-/
def endpoint_choices_are_exhaustive : Prop :=
  ∀ (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182),
  (_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (E) ((_root_.cleanDefine_no_endpoints_3aad239e18f86ce44c68)))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (E) ((_root_.cleanDefine_lower_endpoint_c404a3843e685ffaf059)))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (E) ((_root_.cleanDefine_upper_endpoint_06a0ff0e6593640bb148)))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (E) ((_root_.cleanDefine_both_endpoints_5b72385d3bc820377d4f)))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: endpoint inclusion
-/
def selected_endpoints_lie_in_the_interval : Prop :=
  ∀ (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c),
  ∀ (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))))),
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 (I) (E))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 (I))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: pair inclusion
-/
def expanded_pair_is_nested : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: pair inclusion
-/
def shifted_pair_is_nested : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (t : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_shifted_pair_839ea777ea6079fe1438 (P) (t))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: all bounded shifts
-/
def shifted_pair_lies_in_expanded_pair : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r t : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («shift» : (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c (r))) (t))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (t) (r))))),
  (@_root_.cleanDefine_pair_included_in_0f8f1153fc26493cf3ad ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_shifted_pair_839ea777ea6079fe1438 (P) (t))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))

/--
source: interlevel
reference: definition of perturbation pairs
relationship: adapted
scope: pair inclusion
-/
def perturbed_pair_is_nested : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbed_pair_e76c2b7c221b8b14082e (P) (h))))

/--
source: interlevel
reference: definition of relative well groups
relationship: adapted
scope: pair inclusion
-/
def bounded_perturbation_lies_in_expanded_pair : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («bounded_perturbation_u28_P_u2c__h_u2c__r_u29_» : (@_root_.cleanDefine_bounded_perturbation_0dede816ed35ab14c798 (P) (h) (r))),
  (@_root_.cleanDefine_pair_included_in_0f8f1153fc26493cf3ad ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbed_pair_e76c2b7c221b8b14082e (P) (h))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))

/--
source: topology
reference: certified expanded pair
relationship: original
-/
def expanded_pair_has_a_certificate : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  let T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r));
  (@Exists (_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) (fun (clean_bound_0 : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) => (@_root_.cleanDefine_has_pair_data_28914c997308e957942c ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0) (T))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: certified inclusion
-/
def bounded_shift_has_a_certified_inclusion : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r t : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («shift» : (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c (r))) (t))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (t) (r))))),
  let S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_shifted_pair_839ea777ea6079fe1438 (P) (t));
  let T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r));
  (@Exists (_root_.cleanStructure_PairInclusion_ee25aff32607b8147010 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) (fun (clean_bound_0 : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanDefine_has_pair_data_28914c997308e957942c ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (S))) ((@_root_.cleanDefine_has_pair_data_28914c997308e957942c ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (T))))))

/--
source: interlevel
reference: definition of relative well groups
relationship: adapted
scope: certified inclusion
-/
def bounded_perturbation_has_a_certified_inclusion : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («bounded_perturbation_u28_P_u2c__h_u2c__r_u29_» : (@_root_.cleanDefine_bounded_perturbation_0dede816ed35ab14c798 (P) (h) (r))),
  let S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_perturbed_pair_e76c2b7c221b8b14082e (P) (h));
  let T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r));
  (@Exists (_root_.cleanStructure_PairInclusion_ee25aff32607b8147010 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) (fun (clean_bound_0 : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanDefine_has_pair_data_28914c997308e957942c ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (S))) ((@_root_.cleanDefine_has_pair_data_28914c997308e957942c ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (T))))))

/--
source: topology
reference: certified pair constructor
relationship: original
-/
def certification_preserves_pair_data : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)),
  ∀ («nesting» : (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))))),
  (@_root_.cleanDefine_has_pair_data_28914c997308e957942c (X) ((@_root_.cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 (X) (S) («nesting»))) (S))

/--
source: topology
reference: certified inclusion constructor
relationship: original
-/
def certification_preserves_inclusion_data : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (S T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)),
  ∀ («source» : (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))))),
  ∀ («target» : (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T))))),
  ∀ («ambient» : (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T))))),
  ∀ («relative» : (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T))))),
  let Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X) := (@_root_.cleanDefine_certify_pair_inclusion_56f49733534c168f2042 (X) (S) (T) («source») («target») («ambient») («relative»));
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanDefine_has_pair_data_28914c997308e957942c (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))) (S))) ((@_root_.cleanDefine_has_pair_data_28914c997308e957942c (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))) (T))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `InterlevelOracle.Ends then return `cleanStructure_Endpoints_7a6ba0b879274641120c
  if n == `InterlevelOracle.Selection then return `cleanStructure_EndpointSelection_417d89980a2c354c2182
  if n == `InterlevelOracle.Problem then return `cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc
  if n == `InterlevelOracle.Pair then return `cleanStructure_SpacePairData_8be8da5fc95a34b54ce7
  if n == `InterlevelOracle.boolType then return `cleanType_Boolean_b98a4c98fcdb0f46359e
  if n == `InterlevelOracle.realMapType then return `cleanType_ContinuousRealMap_c65fa65fdfc171714c32
  if n == `InterlevelOracle.realType then return `cleanType_Real_107b6641a486642ad8e1
  if n == `InterlevelOracle.setType then return `cleanType_Set_6e300741358eee425e81
  if n == `InterlevelOracle.conditionType then return `cleanType_Proposition_ae4a13d2f060407bce35
  if n == `InterlevelOracle.spaceType then return `cleanType_TopologicalSpace_d66be29262ccb5d89e3b
  if n == `InterlevelOracle.pointType then return `cleanType_Point_f8a65e23875fb9a2c125
  if n == `InterlevelOracle.yes then return `cleanNotation_true_value_9ca9e49e1312ca23ac23
  if n == `InterlevelOracle.no then return `cleanNotation_false_value_30a63b75654d87153a83
  if n == `InterlevelOracle.ends then return `cleanConstructor_endpoints_3622a2317e61075ae5a0
  if n == `InterlevelOracle.shift then return `cleanDefine_shifted_endpoints_56dbb0aee032fece61c6
  if n == `InterlevelOracle.selection then return `cleanConstructor_endpoint_selection_f2c54850f699491deae8
  if n == `InterlevelOracle.neither then return `cleanDefine_no_endpoints_3aad239e18f86ce44c68
  if n == `InterlevelOracle.lowerOnly then return `cleanDefine_lower_endpoint_c404a3843e685ffaf059
  if n == `InterlevelOracle.upperOnly then return `cleanDefine_upper_endpoint_06a0ff0e6593640bb148
  if n == `InterlevelOracle.both then return `cleanDefine_both_endpoints_5b72385d3bc820377d4f
  if n == `InterlevelOracle.setOf then return `cleanNotation_set_of_2c71fd475f49a65bd03e
  if n == `InterlevelOracle.preimage then return `cleanDefine_inverse_image_22bc73bac0cb61752f41
  if n == `InterlevelOracle.underlying then return `cleanNotation_underlying_real_map_0b69f7fea7146ae09669
  if n == `InterlevelOracle.closed then return `cleanDefine_closed_interval_6ff374769e42838e17c5
  if n == `InterlevelOracle.selected then return `cleanDefine_selected_endpoints_0c6530af3fba0a8ca281
  if n == `InterlevelOracle.expanded then return `cleanDefine_expanded_interval_f798e8fd37d9631212b9
  if n == `InterlevelOracle.boundary then return `cleanDefine_expanded_endpoints_69c934e5376bdc2f2867
  if n == `InterlevelOracle.problem then return `cleanConstructor_interlevel_problem_53885bc5547eca082a8b
  if n == `InterlevelOracle.pair then return `cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4
  if n == `InterlevelOracle.nested then return `cleanDefine_nested_pair_081cfd12251352debe01
  if n == `InterlevelOracle.expandedPair then return `cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d
  if n == `InterlevelOracle.shiftedPair then return `cleanDefine_shifted_pair_839ea777ea6079fe1438
  if n == `InterlevelOracle.included then return `cleanDefine_pair_included_in_0f8f1153fc26493cf3ad
  if n == `InterlevelOracle.evaluate then return `cleanNotation_evaluate_map_fc8e4f20170606ffe807
  if n == `InterlevelOracle.value then return `cleanDefine_real_map_value_829bba0c597453819c48
  if n == `InterlevelOracle.bounded then return `cleanDefine_bounded_perturbation_0dede816ed35ab14c798
  if n == `InterlevelOracle.perturbed then return `cleanDefine_perturbed_pair_e76c2b7c221b8b14082e
  if n == `InterlevelOracle.certify then return `cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1
  if n == `InterlevelOracle.represents then return `cleanDefine_has_pair_data_28914c997308e957942c
  if n == `InterlevelOracle.certifyInclusion then return `cleanDefine_certify_pair_inclusion_56f49733534c168f2042
  if n == `InterlevelOracle.equal then return `cleanDefine_equal_59dc0f11ba9b345348cf
  if n == `InterlevelOracle.conjoin then return `cleanDefine_conjunction_41680d3b84ab96b0cab9
  if n == `InterlevelOracle.disjoin then return `cleanDefine_disjunction_2a3db8ccf67a84818535
  if n == `InterlevelOracle.member then return `cleanDefine_set_member_d7f862196f8cd9ab892e
  if n == `InterlevelOracle.subset then return `cleanDefine_set_subset_a67e41d93cfd162885cf
  if n == `InterlevelOracle.add then return `cleanNotation_real_sum_8dd895080a4442dce6f9
  if n == `InterlevelOracle.subtract then return `cleanNotation_real_difference_bf838970af972a894b2c
  if n == `InterlevelOracle.negative then return `cleanNotation_real_negative_b76c1fb39b30169ebf0c
  if n == `InterlevelOracle.atMost then return `cleanDefine_real_at_most_51ad2818948d6e758423
  if n == `InterlevelOracle.atLeast then return `cleanDefine_real_at_least_6add8f72594b91ec8f2f
  if n == `InterlevelOracle.numeral then return `cleanNumeral_Real_1f10813a9ce4dc61fe3e
  match n with
  | .str p s => return .str (canonicalName p) s
  | .num p i => return .num (canonicalName p) i
  | .anonymous => return .anonymous
private def canonical : Expr → Expr
  | .const n u => .const (canonicalName n) u
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj (canonicalName n) i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some x := env.find? a.getId | throwError "Missing actual target"
  let some y := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do
    throwError "Canonical type differs: {a} vs {b}"
  match x,y with
  | .defnInfo x,.defnInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical body differs: {a} vs {b}"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
        canonicalName x.induct == canonicalName y.induct do
      throwError "Constructor shape differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
        x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do
      throwError "Structure shape differs"
  | _,_ => throwError "Unexpected declaration kinds"

namespace InterlevelOracle
noncomputable abbrev realType : Type := ℝ
noncomputable abbrev setType (X : Type) : Type := Set X
noncomputable abbrev conditionType : Sort 1 := Prop
noncomputable abbrev spaceType : Type 1 := TopCat.{0}
noncomputable abbrev pointType (X : spaceType) : Type := TopCat.carrier X
noncomputable abbrev boolType : Type := Bool
noncomputable def equal {T : Type} (x y : T) : conditionType := x=y
noncomputable def conjoin (x y : conditionType) : conditionType := x ∧ y
noncomputable def disjoin (x y : conditionType) : conditionType := x ∨ y
noncomputable def member {T : Type} (x : T) (A : setType T) : conditionType := x ∈ A
noncomputable def subset {T : Type} (A B : setType T) : conditionType := A ⊆ B
noncomputable def add (x y : realType) : realType := x+y
noncomputable def subtract (x y : realType) : realType := x-y
noncomputable def negative (x : realType) : realType := -x
noncomputable def atMost (x y : realType) : conditionType := x ≤ y
noncomputable def atLeast (x y : realType) : conditionType := x ≥ y
noncomputable def numeral (digits : Nat) : realType := (fun n : Nat => (n : Real)) digits
local infix:50 " =ᵢ " => equal
local infixr:35 " ∧ᵢ " => conjoin
local infixr:30 " ∨ᵢ " => disjoin
local infix:50 " ∈ᵢ " => member
local infix:50 " ⊆ᵢ " => subset
local infixl:65 " +ᵢ " => add
local infixl:65 " -ᵢ " => subtract
local prefix:75 "-ᵢ" => negative
local infix:50 " ≤ᵢ " => atMost
local infix:50 " ≥ᵢ " => atLeast
noncomputable def yes : boolType := true
noncomputable def no : boolType := false
structure Ends : Type where
  lower : realType
  upper : realType
noncomputable def ends (lower upper : realType) : Ends := @Ends.mk lower upper
noncomputable def shift (I : Ends) (s : realType) : Ends := @ends (I.lower+ᵢs) (I.upper+ᵢs)
structure Selection : Type where
  lower : boolType
  upper : boolType
noncomputable def selection (lower upper : boolType) : Selection := @Selection.mk lower upper
noncomputable def neither : Selection := @selection no no
noncomputable def lowerOnly : Selection := @selection yes no
noncomputable def upperOnly : Selection := @selection no yes
noncomputable def both : Selection := @selection yes yes
noncomputable def setOf {X : Type} (condition : X → conditionType) : setType X := _root_.setOf condition
noncomputable def preimage {X Y : Type} (f : X → Y) (S : setType Y) : setType X := setOf (fun x : X => f x ∈ᵢ S)
noncomputable def realMapType (X : spaceType) : Type :=
  @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace
noncomputable def underlying (X : spaceType)
  (f : realMapType X) : pointType X → realType :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f
noncomputable def closed (I : Ends) : setType realType := setOf (fun x : realType => I.lower ≤ᵢ x ∧ᵢ x ≤ᵢ I.upper)
noncomputable def selected (I : Ends) (E : Selection) : setType realType :=
  setOf (fun x : realType => (E.lower=ᵢyes ∧ᵢ x=ᵢI.lower) ∨ᵢ (E.upper=ᵢyes ∧ᵢ x=ᵢI.upper))
noncomputable def expanded (I : Ends) (r : realType) : setType realType := setOf (fun x : realType => I.lower-ᵢr ≤ᵢ x ∧ᵢ x ≤ᵢ I.upper+ᵢr)
noncomputable def boundary (I : Ends) (E : Selection) (r : realType) : setType realType :=
  setOf (fun x : realType => ((E.lower=ᵢyes ∧ᵢ I.lower-ᵢr ≤ᵢ x) ∧ᵢ x ≤ᵢ I.lower+ᵢr) ∨ᵢ
                     ((E.upper=ᵢyes ∧ᵢ I.upper-ᵢr ≤ᵢ x) ∧ᵢ x ≤ᵢ I.upper+ᵢr))
structure Problem : Type 1 where
  space : spaceType
  map : realMapType space
  interval : Ends
  selection : Selection
noncomputable def problem (space : spaceType)
  (map : realMapType space)
  (interval : Ends) (selection : Selection) : Problem := @Problem.mk space map interval selection
structure Pair (X : spaceType) : Type where
  ambient : setType (pointType X)
  relative : setType (pointType X)
noncomputable def pair (X : spaceType) (ambient relative : setType (pointType X)) : Pair X := @Pair.mk X ambient relative
noncomputable def nested (X : spaceType) (Q : Pair X) : conditionType := Q.relative ⊆ᵢ Q.ambient
noncomputable def expandedPair (P : Problem) (r : realType) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space P.map) (expanded P.interval r))
               (preimage (@underlying P.space P.map) (boundary P.interval P.selection r))
noncomputable def shiftedPair (P : Problem) (t : realType) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space P.map) (closed (shift P.interval t)))
               (preimage (@underlying P.space P.map) (selected (shift P.interval t) P.selection))
noncomputable def included (X : spaceType) (Q R : Pair X) : conditionType :=
  Q.ambient ⊆ᵢ R.ambient ∧ᵢ Q.relative ⊆ᵢ R.relative

noncomputable def evaluate {X Y : Type} (f : X → Y) (x : X) : Y := f x
noncomputable def value (X : spaceType)
  (f : realMapType X) (x : pointType X) : realType :=
  evaluate (@underlying X f) x
noncomputable def bounded (P : Problem)
  (h : realMapType P.space) (r : realType) : conditionType :=
  ∀ x : pointType P.space, -ᵢr ≤ᵢ @value P.space h x -ᵢ @value P.space P.map x ∧ᵢ
    @value P.space h x -ᵢ @value P.space P.map x ≤ᵢ r
noncomputable def perturbed (P : Problem)
  (h : realMapType P.space) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space h) (closed P.interval))
               (preimage (@underlying P.space h) (selected P.interval P.selection))

def choicesStatement : Prop := ∀ E : Selection, ((E=ᵢneither ∨ᵢ E=ᵢlowerOnly) ∨ᵢ E=ᵢupperOnly) ∨ᵢ E=ᵢboth
def endpointsStatement : Prop := ∀ (I : Ends) (E : Selection), I.lower ≤ᵢ I.upper → selected I E ⊆ᵢ closed I
def expandedStatement : Prop := ∀ (P : Problem) (r : realType), P.interval.lower ≤ᵢ P.interval.upper → r ≥ᵢ numeral (nat_lit 0) →
  @nested P.space (@expandedPair P r)
def shiftedStatement : Prop := ∀ (P : Problem) (t : realType), P.interval.lower ≤ᵢ P.interval.upper →
  @nested P.space (@shiftedPair P t)
def inclusionStatement : Prop := ∀ (P : Problem) (r t : realType), r ≥ᵢ numeral (nat_lit 0) → (-ᵢr ≤ᵢ t ∧ᵢ t ≤ᵢ r) →
  @included P.space (@shiftedPair P t) (@expandedPair P r)
def perturbedStatement : Prop := ∀ (P : Problem)
  (h : realMapType P.space),
  P.interval.lower ≤ᵢ P.interval.upper → @nested P.space (@perturbed P h)
def boundedStatement : Prop := ∀ (P : Problem)
  (h : realMapType P.space) (r : realType),
  r ≥ᵢ numeral (nat_lit 0) → @bounded P h r → @included P.space (@perturbed P h) (@expandedPair P r)
noncomputable def certify (X : spaceType) (Q : Pair X) (h : Q.relative ⊆ᵢ Q.ambient) : cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 X :=
  @cleanConstructor_topological_pair_f1f6ec54a2edb8f96e06 X Q.ambient Q.relative h
noncomputable def certifyInclusion (X : spaceType) (S T : Pair X)
  (s : S.relative ⊆ᵢ S.ambient) (t : T.relative ⊆ᵢ T.ambient)
  (a : S.ambient ⊆ᵢ T.ambient) (b : S.relative ⊆ᵢ T.relative) : cleanStructure_PairInclusion_ee25aff32607b8147010 X :=
  @cleanConstructor_pair_inclusion_b3b5f87a6a3fe9059428 X (@certify X S s) (@certify X T t) a b
noncomputable def represents (X : spaceType) (Q : cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 X) (S : Pair X) : conditionType :=
  Q.ambient=ᵢS.ambient ∧ᵢ Q.relative=ᵢS.relative
def certifiedExpandedStatement : Prop := ∀ (P : Problem) (r : realType),
  P.interval.lower ≤ᵢ P.interval.upper → r ≥ᵢ numeral (nat_lit 0) →
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 P.space, @represents P.space Q T
def certifiedShiftStatement : Prop := ∀ (P : Problem) (r t : realType),
  P.interval.lower ≤ᵢ P.interval.upper → r ≥ᵢ numeral (nat_lit 0) → (-ᵢr ≤ᵢ t ∧ᵢ t ≤ᵢ r) →
  let S : Pair P.space := @shiftedPair P t;
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : cleanStructure_PairInclusion_ee25aff32607b8147010 P.space,
    @represents P.space Q.source S ∧ᵢ @represents P.space Q.target T
def certifiedPerturbationStatement : Prop := ∀ (P : Problem)
  (h : realMapType P.space) (r : realType),
  P.interval.lower ≤ᵢ P.interval.upper → r ≥ᵢ numeral (nat_lit 0) → @bounded P h r →
  let S : Pair P.space := @perturbed P h;
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : cleanStructure_PairInclusion_ee25aff32607b8147010 P.space,
    @represents P.space Q.source S ∧ᵢ @represents P.space Q.target T

def certifyStatement : Prop := ∀ (X : spaceType) (S : Pair X) (h : S.relative ⊆ᵢ S.ambient),
  @represents X (@certify X S h) S
def certifyInclusionStatement : Prop := ∀ (X : spaceType) (S T : Pair X)
  (s : S.relative ⊆ᵢ S.ambient) (t : T.relative ⊆ᵢ T.ambient)
  (a : S.ambient ⊆ᵢ T.ambient) (b : S.relative ⊆ᵢ T.relative),
  let Q : cleanStructure_PairInclusion_ee25aff32607b8147010 X := @certifyInclusion X S T s t a b;
  @represents X Q.source S ∧ᵢ @represents X Q.target T
end InterlevelOracle
same_target cleanStructure_Endpoints_7a6ba0b879274641120c InterlevelOracle.Ends
same_target cleanStructure_EndpointSelection_417d89980a2c354c2182 InterlevelOracle.Selection
same_target cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc InterlevelOracle.Problem
same_target cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 InterlevelOracle.Pair
same_target cleanType_Boolean_b98a4c98fcdb0f46359e InterlevelOracle.boolType
same_target cleanType_ContinuousRealMap_c65fa65fdfc171714c32 InterlevelOracle.realMapType
same_target cleanType_Real_107b6641a486642ad8e1 InterlevelOracle.realType
same_target cleanType_Set_6e300741358eee425e81 InterlevelOracle.setType
same_target cleanType_Proposition_ae4a13d2f060407bce35 InterlevelOracle.conditionType
same_target cleanType_TopologicalSpace_d66be29262ccb5d89e3b InterlevelOracle.spaceType
same_target cleanType_Point_f8a65e23875fb9a2c125 InterlevelOracle.pointType
same_target cleanNotation_true_value_9ca9e49e1312ca23ac23 InterlevelOracle.yes
same_target cleanNotation_false_value_30a63b75654d87153a83 InterlevelOracle.no
same_target cleanConstructor_endpoints_3622a2317e61075ae5a0 InterlevelOracle.ends
same_target cleanDefine_shifted_endpoints_56dbb0aee032fece61c6 InterlevelOracle.shift
same_target cleanConstructor_endpoint_selection_f2c54850f699491deae8 InterlevelOracle.selection
same_target cleanDefine_no_endpoints_3aad239e18f86ce44c68 InterlevelOracle.neither
same_target cleanDefine_lower_endpoint_c404a3843e685ffaf059 InterlevelOracle.lowerOnly
same_target cleanDefine_upper_endpoint_06a0ff0e6593640bb148 InterlevelOracle.upperOnly
same_target cleanDefine_both_endpoints_5b72385d3bc820377d4f InterlevelOracle.both
same_target cleanNotation_set_of_2c71fd475f49a65bd03e InterlevelOracle.setOf
same_target cleanDefine_inverse_image_22bc73bac0cb61752f41 InterlevelOracle.preimage
same_target cleanNotation_underlying_real_map_0b69f7fea7146ae09669 InterlevelOracle.underlying
same_target cleanDefine_closed_interval_6ff374769e42838e17c5 InterlevelOracle.closed
same_target cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 InterlevelOracle.selected
same_target cleanDefine_expanded_interval_f798e8fd37d9631212b9 InterlevelOracle.expanded
same_target cleanDefine_expanded_endpoints_69c934e5376bdc2f2867 InterlevelOracle.boundary
same_target cleanConstructor_interlevel_problem_53885bc5547eca082a8b InterlevelOracle.problem
same_target cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 InterlevelOracle.pair
same_target cleanDefine_nested_pair_081cfd12251352debe01 InterlevelOracle.nested
same_target cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d InterlevelOracle.expandedPair
same_target cleanDefine_shifted_pair_839ea777ea6079fe1438 InterlevelOracle.shiftedPair
same_target cleanDefine_pair_included_in_0f8f1153fc26493cf3ad InterlevelOracle.included
same_target cleanNotation_evaluate_map_fc8e4f20170606ffe807 InterlevelOracle.evaluate
same_target cleanDefine_real_map_value_829bba0c597453819c48 InterlevelOracle.value
same_target cleanDefine_bounded_perturbation_0dede816ed35ab14c798 InterlevelOracle.bounded
same_target cleanDefine_perturbed_pair_e76c2b7c221b8b14082e InterlevelOracle.perturbed
same_target cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 InterlevelOracle.certify
same_target cleanDefine_has_pair_data_28914c997308e957942c InterlevelOracle.represents
same_target cleanDefine_certify_pair_inclusion_56f49733534c168f2042 InterlevelOracle.certifyInclusion
same_target cleanDefine_equal_59dc0f11ba9b345348cf InterlevelOracle.equal
same_target cleanDefine_conjunction_41680d3b84ab96b0cab9 InterlevelOracle.conjoin
same_target cleanDefine_disjunction_2a3db8ccf67a84818535 InterlevelOracle.disjoin
same_target cleanDefine_set_member_d7f862196f8cd9ab892e InterlevelOracle.member
same_target cleanDefine_set_subset_a67e41d93cfd162885cf InterlevelOracle.subset
same_target cleanNotation_real_sum_8dd895080a4442dce6f9 InterlevelOracle.add
same_target cleanNotation_real_difference_bf838970af972a894b2c InterlevelOracle.subtract
same_target cleanNotation_real_negative_b76c1fb39b30169ebf0c InterlevelOracle.negative
same_target cleanDefine_real_at_most_51ad2818948d6e758423 InterlevelOracle.atMost
same_target cleanDefine_real_at_least_6add8f72594b91ec8f2f InterlevelOracle.atLeast
same_target cleanNumeral_Real_1f10813a9ce4dc61fe3e InterlevelOracle.numeral
same_target cleanStructure_Endpoints_7a6ba0b879274641120c.mk InterlevelOracle.Ends.mk
same_target cleanStructure_Endpoints_7a6ba0b879274641120c.lower InterlevelOracle.Ends.lower
same_target cleanStructure_Endpoints_7a6ba0b879274641120c.upper InterlevelOracle.Ends.upper
same_target cleanStructure_EndpointSelection_417d89980a2c354c2182.mk InterlevelOracle.Selection.mk
same_target cleanStructure_EndpointSelection_417d89980a2c354c2182.lower InterlevelOracle.Selection.lower
same_target cleanStructure_EndpointSelection_417d89980a2c354c2182.upper InterlevelOracle.Selection.upper
same_target cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.mk InterlevelOracle.Problem.mk
same_target cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.space InterlevelOracle.Problem.space
same_target cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.map InterlevelOracle.Problem.map
same_target cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.interval InterlevelOracle.Problem.interval
same_target cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.selection InterlevelOracle.Problem.selection
same_target cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.mk InterlevelOracle.Pair.mk
same_target cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.ambient InterlevelOracle.Pair.ambient
same_target cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.relative InterlevelOracle.Pair.relative
same_target CleanStatements.endpoint_choices_are_exhaustive InterlevelOracle.choicesStatement
same_target CleanStatements.selected_endpoints_lie_in_the_interval InterlevelOracle.endpointsStatement
same_target CleanStatements.expanded_pair_is_nested InterlevelOracle.expandedStatement
same_target CleanStatements.shifted_pair_is_nested InterlevelOracle.shiftedStatement
same_target CleanStatements.shifted_pair_lies_in_expanded_pair InterlevelOracle.inclusionStatement
same_target CleanStatements.perturbed_pair_is_nested InterlevelOracle.perturbedStatement
same_target CleanStatements.bounded_perturbation_lies_in_expanded_pair InterlevelOracle.boundedStatement
same_target CleanStatements.expanded_pair_has_a_certificate InterlevelOracle.certifiedExpandedStatement
same_target CleanStatements.bounded_shift_has_a_certified_inclusion InterlevelOracle.certifiedShiftStatement
same_target CleanStatements.bounded_perturbation_has_a_certified_inclusion InterlevelOracle.certifiedPerturbationStatement
same_target CleanStatements.certification_preserves_pair_data InterlevelOracle.certifyStatement
same_target CleanStatements.certification_preserves_inclusion_data InterlevelOracle.certifyInclusionStatement

namespace InterlevelProofs
theorem endpoint_choices_are_exhaustive : CleanStatements.endpoint_choices_are_exhaustive := by
  intro E
  change ((E=cleanDefine_no_endpoints_3aad239e18f86ce44c68 ∨ E=cleanDefine_lower_endpoint_c404a3843e685ffaf059) ∨ E=cleanDefine_upper_endpoint_06a0ff0e6593640bb148) ∨ E=cleanDefine_both_endpoints_5b72385d3bc820377d4f
  rcases E with ⟨l,u⟩
  cases l <;> cases u <;>
    first | exact Or.inl (Or.inl (Or.inl rfl)) | exact Or.inl (Or.inl (Or.inr rfl)) |
            exact Or.inl (Or.inr rfl) | exact Or.inr rfl

theorem selected_endpoints_lie_in_the_interval : CleanStatements.selected_endpoints_lie_in_the_interval := by
  intro I E h x hx
  change (E.lower=true ∧ x=I.lower) ∨ (E.upper=true ∧ x=I.upper) at hx
  change I.lower ≤ x ∧ x ≤ I.upper
  rcases hx with ⟨_,rfl⟩ | ⟨_,rfl⟩
  · exact ⟨le_refl _,h⟩
  · exact ⟨h,le_refl _⟩

theorem expanded_pair_is_nested : CleanStatements.expanded_pair_is_nested := by
  intro P r ho _hr x hx
  change P.interval.lower ≤ P.interval.upper at ho
  change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
    ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r) at hx
  change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
  rcases hx with ⟨⟨_,hl⟩,hu⟩ | ⟨⟨_,hl⟩,hu⟩
  · exact ⟨hl, by linarith⟩
  · exact ⟨by linarith, hu⟩

theorem shifted_pair_is_nested : CleanStatements.shifted_pair_is_nested := by
  intro P t ho x hx
  change P.interval.lower ≤ P.interval.upper at ho
  change (P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
    (P.selection.upper=true ∧ P.map x=P.interval.upper+t) at hx
  change P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t
  rcases hx with ⟨_,he⟩ | ⟨_,he⟩
  · constructor <;> linarith
  · constructor <;> linarith

theorem shifted_pair_lies_in_expanded_pair : CleanStatements.shifted_pair_lies_in_expanded_pair := by
  intro P r t _hr ht
  change -r ≤ t ∧ t ≤ r at ht
  constructor
  · intro x hx
    change P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t at hx
    change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
    constructor <;> linarith [hx.1,hx.2,ht.1,ht.2]
  · intro x hx
    change (P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
      (P.selection.upper=true ∧ P.map x=P.interval.upper+t) at hx
    change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
      ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r)
    rcases hx with ⟨he,hx⟩ | ⟨he,hx⟩
    · left
      exact ⟨⟨he,by linarith [ht.1]⟩,by linarith [ht.2]⟩
    · right
      exact ⟨⟨he,by linarith [ht.1]⟩,by linarith [ht.2]⟩
theorem perturbed_pair_is_nested : CleanStatements.perturbed_pair_is_nested := by
  intro P h ho x hx
  change P.interval.lower ≤ P.interval.upper at ho
  change (P.selection.lower=true ∧ h x=P.interval.lower) ∨
    (P.selection.upper=true ∧ h x=P.interval.upper) at hx
  change P.interval.lower ≤ h x ∧ h x ≤ P.interval.upper
  rcases hx with ⟨_,he⟩ | ⟨_,he⟩
  · constructor <;> linarith
  · constructor <;> linarith

theorem bounded_perturbation_lies_in_expanded_pair : CleanStatements.bounded_perturbation_lies_in_expanded_pair := by
  intro P h r _hr hb
  change ∀ x : P.space.carrier, -r ≤ h x-P.map x ∧ h x-P.map x ≤ r at hb
  constructor
  · intro x hx
    change P.interval.lower ≤ h x ∧ h x ≤ P.interval.upper at hx
    change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
    constructor <;> linarith [(hb x).1,(hb x).2,hx.1,hx.2]
  · intro x hx
    change (P.selection.lower=true ∧ h x=P.interval.lower) ∨
      (P.selection.upper=true ∧ h x=P.interval.upper) at hx
    change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
      ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r)
    rcases hx with ⟨he,hx⟩ | ⟨he,hx⟩
    · left
      exact ⟨⟨he,by linarith [(hb x).1,(hb x).2]⟩,by linarith [(hb x).1,(hb x).2]⟩
    · right
      exact ⟨⟨he,by linarith [(hb x).1,(hb x).2]⟩,by linarith [(hb x).1,(hb x).2]⟩
theorem expanded_pair_has_a_certificate : CleanStatements.expanded_pair_has_a_certificate := by
  intro P r ho hr
  let T := cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d P r
  refine ⟨⟨T.ambient,T.relative,?_⟩,rfl,rfl⟩
  exact expanded_pair_is_nested P r ho hr

theorem bounded_shift_has_a_certified_inclusion : CleanStatements.bounded_shift_has_a_certified_inclusion := by
  intro P r t ho hr ht
  let S := cleanDefine_shifted_pair_839ea777ea6079fe1438 P t
  let T := cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d P r
  have hs := shifted_pair_is_nested P t ho
  have ht' := expanded_pair_is_nested P r ho hr
  have hi := shifted_pair_lies_in_expanded_pair P r t hr ht
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht'⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

theorem bounded_perturbation_has_a_certified_inclusion : CleanStatements.bounded_perturbation_has_a_certified_inclusion := by
  intro P h r ho hr hb
  let S := cleanDefine_perturbed_pair_e76c2b7c221b8b14082e P h
  let T := cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d P r
  have hs := perturbed_pair_is_nested P h ho
  have ht := expanded_pair_is_nested P r ho hr
  have hi := bounded_perturbation_lies_in_expanded_pair P h r hr hb
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

theorem certification_preserves_pair_data : CleanStatements.certification_preserves_pair_data := by
  intro X S h
  exact ⟨rfl,rfl⟩
theorem certification_preserves_inclusion_data : CleanStatements.certification_preserves_inclusion_data := by
  intro X S T s t a b
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩
end InterlevelProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
