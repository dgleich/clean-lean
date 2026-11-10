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
import Mathlib.Topology.Basic
import Mathlib.Topology.Path
import Mathlib.Logic.Equiv.Defs

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

noncomputable abbrev cleanType_Element_4fb2f1b669ed36f80886 (X : Type) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : Type :=
  {x : X // x ∈ S}

noncomputable abbrev cleanType_Path_2e5bf3c806cfad5a1ae9 (X : Type) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_element_value_91379654a1b03d81fbbb {A : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) : A :=
  x.val

noncomputable def cleanNotation_element_membership_66040748fccf5fcb155f {A : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) : ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb (A) (S) (x))) (S))) :=
  x.property

noncomputable def cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 {A : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (x : A) (h : ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (x) (S)))) : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S)) :=
  Subtype.mk x h

noncomputable def cleanNotation_equality_congruence_174db20655aa25697786 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (y)))) : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((f x)) ((f y)))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_4da391a0ed75b016f3b7 {X : Type} (x : X) : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (x))) :=
  Eq.refl x

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable abbrev cleanType_Equivalence_58fcab11d3757c8990fc (A : Type) (B : Type) : Type :=
  A ≃ B

noncomputable def cleanNotation_equivalence_9d83c0e36a92e415da0d  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (B : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (f : (A) → (B)) (g : (B) → (A)) (left : (clean_pi_bound_0 : A) → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((g (f clean_pi_bound_0))) (clean_pi_bound_0))))) (right : (clean_pi_bound_1 : B) → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((f (g clean_pi_bound_1))) (clean_pi_bound_1))))) : (_root_.cleanType_Equivalence_58fcab11d3757c8990fc (A) (B)) :=
  Equiv.mk f g left right

noncomputable def cleanNotation_equivalence_forward_1b2127e81d5ae7f2a4b5 {A : Type} {B : Type} (e : (_root_.cleanType_Equivalence_58fcab11d3757c8990fc (A) (B))) (x : A) : B :=
  e x

noncomputable def cleanNotation_equivalence_backward_2f37c329609a576f0e7e {A : Type} {B : Type} (e : (_root_.cleanType_Equivalence_58fcab11d3757c8990fc (A) (B))) (y : B) : A :=
  e.symm y

noncomputable def cleanDefine_identity_equivalence_753621307cf069f536e7  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) : (_root_.cleanType_Equivalence_58fcab11d3757c8990fc (A) (A)) :=
  (@_root_.cleanNotation_equivalence_9d83c0e36a92e415da0d (A) (A) ((fun (clean_bound_0 : A) => clean_bound_0)) ((fun (clean_bound_1 : A) => clean_bound_1)) ((fun (clean_bound_2 : A) => (@_root_.cleanNotation_equality_reflexivity_4da391a0ed75b016f3b7 (A) (clean_bound_2)))) ((fun (clean_bound_3 : A) => (@_root_.cleanNotation_equality_reflexivity_4da391a0ed75b016f3b7 (A) (clean_bound_3)))))

structure cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce («A» : Type) («S» : (_root_.cleanType_Set_6e300741358eee425e81 («A»))) («T» : (_root_.cleanType_Set_6e300741358eee425e81 («A»))) («U» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («S»))))) : Type where
  «survives» : (clean_pi_bound_2 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («T»))) → (((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb («A») («T») (clean_pi_bound_2))) («S»))))
  «active» : (clean_pi_bound_3 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («T»))) → (((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 («A») («S») ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb («A») («T») (clean_pi_bound_3))) ((«survives» clean_pi_bound_3)))) («U»))))
  «original» : (clean_pi_bound_4 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («S»))) («U»))) → (((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb («A») («S») ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («S»))) («U») (clean_pi_bound_4))))) («T»))))

noncomputable def cleanConstructor_subtype_restriction_support_8cd4ad90c30fca09722c («A» : Type) («S» : (_root_.cleanType_Set_6e300741358eee425e81 («A»))) («T» : (_root_.cleanType_Set_6e300741358eee425e81 («A»))) («U» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («S»))))) («survives» : (clean_pi_bound_2 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («T»))) → (((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb («A») («T») (clean_pi_bound_2))) («S»))))) («active» : (clean_pi_bound_3 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («T»))) → (((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 («A») («S») ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb («A») («T») (clean_pi_bound_3))) ((«survives» clean_pi_bound_3)))) («U»))))) («original» : (clean_pi_bound_4 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («S»))) («U»))) → (((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb («A») («S») ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («A») («S»))) («U») (clean_pi_bound_4))))) («T»))))) : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce («A») («S») («T») («U») :=
  @_root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce.mk «A» «S» «T» «U» «survives» «active» «original»

noncomputable def cleanDefine_restrict_element_8fad943bb4db8a6378f2  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))))) (support : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce (A) (S) (T) (U)) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U)) :=
  (@_root_.cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U) ((@_root_.cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 (A) (S) ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb (A) (T) (x))) (((@_root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce.«survives» (A) (S) (T) (U) (support)) x)))) (((@_root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce.«active» (A) (S) (T) (U) (support)) x)))

noncomputable def cleanDefine_restore_element_2c67dc3f4b084d011e29  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))))) (support : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce (A) (S) (T) (U)) (y : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))) : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T)) :=
  (@_root_.cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 (A) (T) ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb (A) (S) ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U) (y))))) (((@_root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce.«original» (A) (S) (T) (U) (support)) y)))

noncomputable def cleanDefine_subtype_restriction_equivalence_9bd9190b4d8feda764d4  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (A))) (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))))) (support : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce (A) (S) (T) (U)) (left : (clean_pi_bound_5 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_restore_element_2c67dc3f4b084d011e29 (A) (S) (T) (U) (support) ((@_root_.cleanDefine_restrict_element_8fad943bb4db8a6378f2 (A) (S) (T) (U) (support) (clean_pi_bound_5))))) (clean_pi_bound_5))))) (right : (clean_pi_bound_6 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))) → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_restrict_element_8fad943bb4db8a6378f2 (A) (S) (T) (U) (support) ((@_root_.cleanDefine_restore_element_2c67dc3f4b084d011e29 (A) (S) (T) (U) (support) (clean_pi_bound_6))))) (clean_pi_bound_6))))) : (_root_.cleanType_Equivalence_58fcab11d3757c8990fc ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U)))) :=
  (@_root_.cleanNotation_equivalence_9d83c0e36a92e415da0d ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))) ((fun (clean_bound_0 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) => (@_root_.cleanDefine_restrict_element_8fad943bb4db8a6378f2 (A) (S) (T) (U) (support) (clean_bound_0)))) ((fun (clean_bound_1 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))) => (@_root_.cleanDefine_restore_element_2c67dc3f4b084d011e29 (A) (S) (T) (U) (support) (clean_bound_1)))) (left) (right))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: subtype
reference: original element round trip
relationship: original
-/
def restore_a_restricted_element : Prop :=
  ∀ (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (S T : (_root_.cleanType_Set_6e300741358eee425e81 (A))),
  ∀ (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))))),
  ∀ (support : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce (A) (S) (T) (U)),
  ∀ (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_restore_element_2c67dc3f4b084d011e29 (A) (S) (T) (U) (support) ((@_root_.cleanDefine_restrict_element_8fad943bb4db8a6378f2 (A) (S) (T) (U) (support) (x))))) (x))

/--
source: subtype
reference: selected element round trip
relationship: original
-/
def restrict_a_restored_element : Prop :=
  ∀ (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (S T : (_root_.cleanType_Set_6e300741358eee425e81 (A))),
  ∀ (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))))),
  ∀ (support : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce (A) (S) (T) (U)),
  ∀ (y : (_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_restrict_element_8fad943bb4db8a6378f2 (A) (S) (T) (U) (support) ((@_root_.cleanDefine_restore_element_2c67dc3f4b084d011e29 (A) (S) (T) (U) (support) (y))))) (y))

/--
source: subtype
reference: value preserving equivalence
relationship: original
-/
def supported_sets_correspond : Prop :=
  ∀ (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (S T : (_root_.cleanType_Set_6e300741358eee425e81 (A))),
  ∀ (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))))),
  ∀ (support : _root_.cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce (A) (S) (T) (U)),
  (@Exists ((_root_.cleanType_Equivalence_58fcab11d3757c8990fc ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))))) (fun (clean_bound_0 : (_root_.cleanType_Equivalence_58fcab11d3757c8990fc ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U))))) => (∀ (clean_bound_1 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (T))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb (A) (S) ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (A) (S))) (U) ((_root_.cleanNotation_equivalence_forward_1b2127e81d5ae7f2a4b5 (clean_bound_0) (clean_bound_1))))))) ((@_root_.cleanNotation_element_value_91379654a1b03d81fbbb (A) (T) (clean_bound_1)))))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
