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
import Mathlib.Topology.Category.TopCat.Basic

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
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

noncomputable def cleanNotation_topological_space_766912e8258a429394cc  (X : Type) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
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

noncomputable abbrev cleanType_LargeTypes_6e77ce5547484df6865c  : Type 2 :=
  Type 1

noncomputable abbrev cleanType_AlternativeTypes_3e1c7e5202eb5dccf4f7  : Type 2 :=
  Type 1

noncomputable def cleanDefine_topology_carrier_9a68fb8a4eaf687edd65   : (_root_.cleanType_LargeTypes_6e77ce5547484df6865c) :=
  (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)

noncomputable def cleanDefine_retain_in_6d72c1e1d3208fff7d7e  (A : Type 1) (x : A) : A :=
  x

noncomputable def cleanDefine_retain_inferred_5787951d13d834b9ec15 {A : Type 1} (x : A) : A :=
  (@_root_.cleanDefine_retain_in_6d72c1e1d3208fff7d7e (A) (x))

noncomputable def cleanDefine_equal_large_a55b893a2f6758313499 {A : Type 1} (x : A) (y : A) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x = y

structure cleanStructure_Package_7cd95b2a5e8f21d506b0 («A» : Type 1) : Type 1 where
  «point» : «A»

noncomputable def cleanConstructor_package_70a6191e4bd0e1fb4412 («A» : Type 1) («point» : «A») : _root_.cleanStructure_Package_7cd95b2a5e8f21d506b0 («A») :=
  @_root_.cleanStructure_Package_7cd95b2a5e8f21d506b0.mk «A» «point»

noncomputable abbrev cleanType_Sequences_f57a5df8b9a5b093bec8 (A : Type 1) : Type 1 :=
  List A

noncomputable def cleanDefine_unpack_7322d475f61e7d218487  (A : Type 1) (P : _root_.cleanStructure_Package_7cd95b2a5e8f21d506b0 (A)) : A :=
  (@_root_.cleanStructure_Package_7cd95b2a5e8f21d506b0.«point» (A) (P))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: parameterized record projection
relationship: original
-/
def packaged_topology_entry : Prop :=
  ∀ (P : _root_.cleanStructure_Package_7cd95b2a5e8f21d506b0 ((_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b))),
  (@_root_.cleanDefine_equal_large_a55b893a2f6758313499 ((_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) ((@_root_.cleanDefine_unpack_7322d475f61e7d218487 ((_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (P))) ((@_root_.cleanStructure_Package_7cd95b2a5e8f21d506b0.«point» ((_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (P))))

end CleanStatements

namespace ParameterOracle
noncomputable def pack (A : Type 1) (point : A) : cleanStructure_Package_7cd95b2a5e8f21d506b0 A := @cleanStructure_Package_7cd95b2a5e8f21d506b0.mk A point
noncomputable def unpack (A : Type 1) (P : cleanStructure_Package_7cd95b2a5e8f21d506b0 A) : A := P.point
noncomputable def sequences (A : Type 1) : Type 1 := List A
noncomputable def statement : Prop := ∀ (P : cleanStructure_Package_7cd95b2a5e8f21d506b0 cleanType_TopologicalSpace_d66be29262ccb5d89e3b),
  @cleanDefine_equal_large_a55b893a2f6758313499 cleanType_TopologicalSpace_d66be29262ccb5d89e3b (cleanDefine_unpack_7322d475f61e7d218487 cleanType_TopologicalSpace_d66be29262ccb5d89e3b P) P.point
end ParameterOracle

open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_basic_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"

same_basic_target cleanConstructor_package_70a6191e4bd0e1fb4412 ParameterOracle.pack
same_basic_target cleanDefine_unpack_7322d475f61e7d218487 ParameterOracle.unpack
same_basic_target cleanType_Sequences_f57a5df8b9a5b093bec8 ParameterOracle.sequences
same_basic_target CleanStatements.packaged_topology_entry ParameterOracle.statement
theorem packaged_topology_entry_proved : CleanStatements.packaged_topology_entry := by
  intro P
  rfl

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
