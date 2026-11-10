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

noncomputable def cleanDefine_coprime_34ae954d5e1846c7a656  (x0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_gcd_8064531ce5c51b479273 (x0) (x1))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))

noncomputable def cleanDefine_sorting_certificate_0577a39a7ad1419dc8dd  (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) (ys : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (ys))) ((_root_.cleanNotation_permutation_d6a3d3468da8ff104d3e (ys) (xs))))

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

noncomputable def cleanDefine_square_4a3fe7e1c9b16c9b737d  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 (x) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))

noncomputable def cleanDefine_squared_distance_a7c48ac9494bf715e141  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) (y : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_square_4a3fe7e1c9b16c9b737d ((_root_.cleanNotation_real_difference_bf838970af972a894b2c (x) (y))))

noncomputable def cleanDefine_trigonometric_energy_c3aeef0079ded8f264c5  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanDefine_square_4a3fe7e1c9b16c9b737d ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x))))) ((_root_.cleanDefine_square_4a3fe7e1c9b16c9b737d ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x))))))

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

noncomputable def cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (x1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (x2 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n)))) :=
  (_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (x0) (x1))) ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (x0) (x2))))

noncomputable def cleanDefine_nonadjacent_4c0e2458d8fa8674d260 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))) (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_negation_7efde94db326666449aa ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))))

noncomputable def cleanNotation_det_b17060e1429bb5f6c879 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Matrix.det x0

noncomputable def cleanNotation_trace_a6d69ffafa465de87ae3 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Matrix.trace x0

noncomputable def cleanNotation_transpose_6101efc622459caca1e2 {m : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (m) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (m) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Matrix.transpose x0

noncomputable def cleanNotation_inverse_572658027caad3cf5daf {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (x0 : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (x0)⁻¹

noncomputable def cleanDefine_commutator_f814066e75ede5cbc326 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (@_root_.cleanNotation_complex_matrix_difference_531d9a82ff8c5cf3cfa1 (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (B) (A))))

noncomputable def cleanDefine_matrix_square_a0a685664c5277654020 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (A))


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
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_length_644d39a96951b5cd16f6 ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))) ((_root_.cleanNotation_length_644d39a96951b5cd16f6 (xs))))

/--
source: mathlib
reference: List.mem_insertionSort
relationship: specialized
-/
def insertion_sort_membership : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (a) ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))) ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (a) (xs))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: specialized
-/
def sorted_input_unchanged : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_231e15abf8d40ee24d9d (xs))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))) (xs))

/--
source: mathlib
reference: List.orderedInsert_length
relationship: specialized
-/
def ordered_insert_length : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_length_644d39a96951b5cd16f6 ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_length_644d39a96951b5cd16f6 (xs))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))

/--
source: mathlib
reference: List.mem_orderedInsert
relationship: specialized
-/
def ordered_insert_membership : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (b) ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))))) ((_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (b) (a))) ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (b) (xs))))))

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
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs))) (xs))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: specialized
-/
def sorting_algorithms_agree : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs))) ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))

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
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (a) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (b) ((_root_.cleanNotation_natural_product_0c2b2fc759f8d93a79af (k) (a))))))) ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (a) (b))))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def euclidean_coprime_subtraction : Prop :=
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («ordered» : (_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (a) (b))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 (b) (a))) (a))) ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (b) (a))))

/--
source: mathlib
reference: Nat.Coprime.lcm_eq_mul
relationship: specialized
-/
def coprime_lcm_product : Prop :=
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (a) (b))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_lcm_43ed3ca5ce04f6eb5082 (a) (b))) ((_root_.cleanNotation_natural_product_0c2b2fc759f8d93a79af (a) (b))))

/--
source: mathlib
reference: Nat.eq_one_of_dvd_coprimes
relationship: specialized
-/
def common_divisor_of_coprimes : Prop :=
  ∀ (a b k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (a) (b))),
  ∀ («divides_a» : (_root_.cleanDefine_natural_divides_2611187ff6f65c3a68d5 (k) (a))),
  ∀ («divides_b» : (_root_.cleanDefine_natural_divides_2611187ff6f65c3a68d5 (k) (b))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (k) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))

/--
source: mathlib
reference: Nat.Coprime.dvd_mul_right
relationship: specialized
-/
def coprime_product_divisibility : Prop :=
  ∀ (a b k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (k) (b))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_natural_divides_2611187ff6f65c3a68d5 (k) ((_root_.cleanNotation_natural_product_0c2b2fc759f8d93a79af (a) (b))))) ((_root_.cleanDefine_natural_divides_2611187ff6f65c3a68d5 (k) (a))))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: adapted
-/
def insertion_sort_certificate : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_sorting_certificate_0577a39a7ad1419dc8dd (xs) ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: adapted
-/
def merge_sort_certificate : Prop :=
  ∀ (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_sorting_certificate_0577a39a7ad1419dc8dd (xs) ((_root_.cleanNotation_mergeSort_422f8e9f9ab641bbef74 (xs))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: adapted
-/
def certified_sort_unchanged : Prop :=
  ∀ (xs ys : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («certificate» : (_root_.cleanDefine_sorting_certificate_0577a39a7ad1419dc8dd (xs) (ys))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (ys))) (ys))

/--
source: mathlib
reference: Real.exp_pos
relationship: specialized
-/
def exponential_positive : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_real_less_23e496cb1d1d1ff9fdb3 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x))))

/--
source: mathlib
reference: Real.exp_ne_zero
relationship: specialized
-/
def exponential_nonzero : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_unequal_d9953e236b6d48fdc435 ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))

/--
source: mathlib
reference: Real.exp_add
relationship: specialized
-/
def exponential_sum : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (x) (y))))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x))) ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (y))))))

/--
source: mathlib
reference: Real.exp_sub
relationship: specialized
-/
def exponential_difference : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c (x) (y))))) ((_root_.cleanNotation_real_quotient_7f1e597c9bc99f29eb9f ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x))) ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (y))))))

/--
source: mathlib
reference: Real.log_exp
relationship: specialized
-/
def logarithm_exponential : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_log_bc42cf59a322aa762d4c ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 (x))))) (x))

/--
source: mathlib
reference: Real.exp_log
relationship: specialized
-/
def exponential_logarithm : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («positive» : (_root_.cleanDefine_real_less_23e496cb1d1d1ff9fdb3 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (x))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_exp_e539dbd0808c5feebb48 ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (x))))) (x))

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def logarithm_product : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonzero_x» : (_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (x) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («nonzero_y» : (_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (y) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_log_bc42cf59a322aa762d4c ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (x) (y))))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (x))) ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (y))))))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def logarithm_quotient : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonzero_x» : (_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (x) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («nonzero_y» : (_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (y) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_log_bc42cf59a322aa762d4c ((_root_.cleanNotation_real_quotient_7f1e597c9bc99f29eb9f (x) (y))))) ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (x))) ((_root_.cleanNotation_log_bc42cf59a322aa762d4c (y))))))

/--
source: mathlib
reference: Real.sqrt_nonneg
relationship: specialized
-/
def square_root_nonnegative : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (x))))

/--
source: mathlib
reference: Real.sq_sqrt
relationship: specialized
-/
def square_of_square_root : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonnegative» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (x))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (x))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))) (x))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: specialized
-/
def square_root_of_square : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 (x) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((_root_.cleanNotation_abs_f5af20d198e156710853 (x))))

/--
source: mathlib
reference: Real.sqrt_mul
relationship: specialized
-/
def square_root_product : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonnegative» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (x))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (x) (y))))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (x))) ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f (y))))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: specialized
-/
def trigonometric_identity : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))) ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))))

/--
source: mathlib
reference: Real.sin_add
relationship: specialized
-/
def sine_addition : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (x) (y))))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x))) ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (y))))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x))) ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (y))))))))

/--
source: mathlib
reference: Real.cos_add
relationship: specialized
-/
def cosine_addition : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (x) (y))))) ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x))) ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (y))))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x))) ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (y))))))))

/--
source: mathlib
reference: Real.sin_neg
relationship: specialized
-/
def sine_odd : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c (x))))) ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c ((_root_.cleanNotation_sin_da1f4692a07c6feb0bc4 (x))))))

/--
source: mathlib
reference: Real.cos_neg
relationship: specialized
-/
def cosine_even : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c (x))))) ((_root_.cleanNotation_cos_77f567f8e5485861fbc0 (x))))

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
  (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 ((_root_.cleanNotation_pointwise_real_sum_658be1682631e14b5a8a (f) (g))))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def continuous_product : Prop :=
  ∀ (f g : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (f))),
  ∀ («hg» : (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 (g))),
  (_root_.cleanNotation_continuous_3e14e89527bb6a62bd30 ((_root_.cleanNotation_pointwise_real_product_56b5da1e82e37c8b945c (f) (g))))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def authored_square_root : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanDefine_square_4a3fe7e1c9b16c9b737d (x))))) ((_root_.cleanNotation_abs_f5af20d198e156710853 (x))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: adapted
-/
def authored_trigonometric_energy : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_trigonometric_energy_c3aeef0079ded8f264c5 (x))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def distance_square_root : Prop :=
  ∀ (x y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanDefine_squared_distance_a7c48ac9494bf715e141 (x) (y))))) ((_root_.cleanNotation_abs_f5af20d198e156710853 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c (x) (y))))))

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
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))) ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (v) (u))))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def no_self_edges : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_negation_7efde94db326666449aa ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (u))))

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
  (_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (u) (v))

/--
source: mathlib
reference: SimpleGraph.sup_adj
relationship: specialized
-/
def union_adjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G H : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_union_acbfc234fe4f905e5a99 (n) (G) (H))) (u) (v))) ((_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))) ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (H) (u) (v))))))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def intersection_adjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G H : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_intersection_baf68ef5876ec2eba6e8 (n) (G) (H))) (u) (v))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))) ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (H) (u) (v))))))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def complement_adjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_complement_24d2562fbaf4a9029656 (n) (G))) (u) (v))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (u) (v))) ((_root_.cleanDefine_negation_7efde94db326666449aa ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))))))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def support_monotonicity : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G H : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ («inclusion» : (@_root_.cleanNotation_subgraph_d154c34b0527cfa5d29b (n) (G) (H))),
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanNotation_support_9ed009a891fa7f7c4921 (n) (G))) ((@_root_.cleanNotation_support_9ed009a891fa7f7c4921 (n) (H))))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def neighbors_in_support : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))) ((@_root_.cleanNotation_support_9ed009a891fa7f7c4921 (n) (G))))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def neighbor_membership : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (v) ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))))) ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def not_own_neighbor : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_negation_7efde94db326666449aa ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (u) ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def common_neighbors_intersection : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 (n) (G) (u) (v))) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))) ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (v))))))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def common_neighbors_membership : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v w : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (w) ((@_root_.cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 (n) (G) (u) (v))))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (u) (w))) ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) (G) (v) (w))))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def common_neighbors_symmetry : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 (n) (G) (u) (v))) ((@_root_.cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 (n) (G) (v) (u))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def common_neighbors_left : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 (n) (G) (u) (v))) ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (u))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def common_neighbors_right : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanDefine_commonNeighbors_9512a69ab2c7d9d18f28 (n) (G) (u) (v))) ((@_root_.cleanNotation_neighbors_9e6108ee5a27908a65ed (n) (G) (v))))

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
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanDefine_nonadjacent_4c0e2458d8fa8674d260 (n) (G) (u) (v))) ((@_root_.cleanDefine_nonadjacent_4c0e2458d8fa8674d260 (n) (G) (v) (u))))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: adapted
-/
def nonadjacency_reflexive : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (@_root_.cleanDefine_nonadjacent_4c0e2458d8fa8674d260 (n) (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: adapted
-/
def complement_from_nonadjacency : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (G : (_root_.cleanType_Graph_7bde0ce024ce143f369b (n))),
  ∀ (u v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanNotation_adjacent_7f8bc3e1774e1d75bf2c (n) ((@_root_.cleanNotation_complement_24d2562fbaf4a9029656 (n) (G))) (u) (v))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_unequal_d9953e236b6d48fdc435 (u) (v))) ((@_root_.cleanDefine_nonadjacent_4c0e2458d8fa8674d260 (n) (G) (u) (v))))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def determinant_product : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))))) ((_root_.cleanNotation_complex_product_3b0736bee3e3b1076e08 ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A))) ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (B))))))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def determinant_transpose : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A))))) ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A))))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def determinant_product_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))))) ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (B) (A))))))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def determinant_left_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B C : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (B) (C))))))) ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (B) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (C))))))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def determinant_right_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B C : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))) (C))))) ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (C))) (B))))))

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def determinant_power : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (k : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanNotation_complex_matrix_power_ed861b14d9d2bce71a27 (n) (A) (k))))) ((_root_.cleanNotation_complex_power_906a3151c2a5ce5d65e4 ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A))) (k))))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def trace_sum : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_sum_b9380385a8a68783970a (n) (n) (A) (B))))) ((_root_.cleanNotation_complex_sum_bd573e52561d38e6ff7c ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A))) ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (B))))))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def trace_difference : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_difference_531d9a82ff8c5cf3cfa1 (n) (n) (A) (B))))) ((_root_.cleanNotation_complex_difference_6626fd74d7228c0d7311 ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A))) ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (B))))))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def trace_negative : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_negative_b1e417c57fa2fdf4e73e (n) (n) (A))))) ((_root_.cleanNotation_complex_negative_51dd3ea89467eda5e232 ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A))))))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def trace_transpose : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A))))) ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) (A))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def trace_product_swap : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))))) ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (B) (A))))))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def trace_cycle : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B C : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))) (C))))) ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (C) (A))) (B))))))

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: specialized
-/
def matrix_vector_associativity : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (B) (x))))) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))) (x))))

/--
source: mathlib
reference: Matrix.mulVec_add
relationship: specialized
-/
def matrix_vector_addition : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) ((@_root_.cleanNotation_complex_vector_sum_8df2cd2278f18dff6264 (n) (x) (y))))) ((@_root_.cleanNotation_complex_vector_sum_8df2cd2278f18dff6264 (n) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (x))) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (y))))))

/--
source: mathlib
reference: Matrix.add_mulVec
relationship: specialized
-/
def matrix_addition_action : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) ((@_root_.cleanNotation_complex_matrix_sum_b9380385a8a68783970a (n) (n) (A) (B))) (x))) ((@_root_.cleanNotation_complex_vector_sum_8df2cd2278f18dff6264 (n) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (x))) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (B) (x))))))

/--
source: mathlib
reference: Matrix.mulVec_sub
relationship: specialized
-/
def matrix_vector_subtraction : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x y : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) ((@_root_.cleanNotation_complex_vector_difference_ff1264527886b3e9c788 (n) (x) (y))))) ((@_root_.cleanNotation_complex_vector_difference_ff1264527886b3e9c788 (n) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (x))) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (y))))))

/--
source: mathlib
reference: Matrix.sub_mulVec
relationship: specialized
-/
def matrix_subtraction_action : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ (x : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) ((@_root_.cleanNotation_complex_matrix_difference_531d9a82ff8c5cf3cfa1 (n) (n) (A) (B))) (x))) ((@_root_.cleanNotation_complex_vector_difference_ff1264527886b3e9c788 (n) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (x))) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (B) (x))))))

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
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) ((@_root_.cleanNotation_complex_scale_vector_7380ed66e1843ba52457 (n) (c) (x))))) ((@_root_.cleanNotation_complex_scale_vector_7380ed66e1843ba52457 (n) (c) ((@_root_.cleanNotation_complex_matrix_application_9324e8bf3c06694258b3 (n) (n) (A) (x))))))

/--
source: mathlib
reference: Matrix.transpose_transpose
relationship: specialized
-/
def transpose_involution : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A))))) (A))

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def transpose_product : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (B))))) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (B))) ((@_root_.cleanNotation_transpose_6101efc622459caca1e2 (n) (n) (A))))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_commutator : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A B : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanDefine_commutator_f814066e75ede5cbc326 (n) (A) (B))))) ((_root_.cleanNumeral_Complex_311fd057b7f2e2b599a3 (nat_lit 0))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def trace_matrix_square : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanDefine_matrix_square_a0a685664c5277654020 (n) (A))))) ((@_root_.cleanNotation_trace_a6d69ffafa465de87ae3 (n) ((@_root_.cleanNotation_complex_matrix_product_c60df06ba7cf89c2617b (n) (n) (n) (A) (A))))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: adapted
-/
def determinant_matrix_square : Prop :=
  ∀ (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) ((@_root_.cleanDefine_matrix_square_a0a685664c5277654020 (n) (A))))) ((_root_.cleanNotation_complex_product_3b0736bee3e3b1076e08 ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A))) ((@_root_.cleanNotation_det_b17060e1429bb5f6c879 (n) (A))))))

end CleanStatements

namespace CleanValidation
theorem determinant_product : CleanStatements.determinant_product := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul A B

theorem determinant_transpose : CleanStatements.determinant_transpose := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_transpose A

theorem determinant_product_swap : CleanStatements.determinant_product_swap := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul_comm A B

theorem determinant_left_swap : CleanStatements.determinant_left_swap := by
  intro n A B C
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul_left_comm A B C

theorem determinant_right_swap : CleanStatements.determinant_right_swap := by
  intro n A B C
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul_right_comm A B C

theorem determinant_power : CleanStatements.determinant_power := by
  intro n A k
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_pow A k

theorem trace_sum : CleanStatements.trace_sum := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_add A B

theorem trace_difference : CleanStatements.trace_difference := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_sub A B

theorem trace_negative : CleanStatements.trace_negative := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_neg A

theorem trace_transpose : CleanStatements.trace_transpose := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_transpose A

theorem trace_product_swap : CleanStatements.trace_product_swap := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_mul_comm A B

theorem trace_cycle : CleanStatements.trace_cycle := by
  intro n A B C
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_mul_cycle A B C

theorem matrix_vector_associativity : CleanStatements.matrix_vector_associativity := by
  intro n A B x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_mulVec x A B

theorem matrix_vector_addition : CleanStatements.matrix_vector_addition := by
  intro n A x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_add A x y

theorem matrix_addition_action : CleanStatements.matrix_addition_action := by
  intro n A B x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.add_mulVec A B x

theorem matrix_vector_subtraction : CleanStatements.matrix_vector_subtraction := by
  intro n A x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_sub A x y

theorem matrix_subtraction_action : CleanStatements.matrix_subtraction_action := by
  intro n A B x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.sub_mulVec A B x

theorem matrix_scalar_action : CleanStatements.matrix_scalar_action := by
  intro n A x c
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_smul A c x

theorem transpose_involution : CleanStatements.transpose_involution := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.transpose_transpose A

theorem transpose_product : CleanStatements.transpose_product := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.transpose_mul A B

theorem adjacency_symmetry : CleanStatements.adjacency_symmetry := by
  intro n G u v edge
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.adj_symm edge

theorem adjacency_commutes : CleanStatements.adjacency_commutes := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.adj_comm u v

theorem no_self_edges : CleanStatements.no_self_edges := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.irrefl

theorem adjacent_vertices_distinct : CleanStatements.adjacent_vertices_distinct := by
  intro n G u v edge
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.ne_of_adj edge

theorem union_adjacency : CleanStatements.union_adjacency := by
  intro n G H u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.sup_adj G H u v

theorem intersection_adjacency : CleanStatements.intersection_adjacency := by
  intro n G H u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.inf_adj G H u v

theorem complement_adjacency : CleanStatements.complement_adjacency := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.compl_adj G u v

theorem support_monotonicity : CleanStatements.support_monotonicity := by
  intro n G H inclusion
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.support_mono inclusion

theorem neighbors_in_support : CleanStatements.neighbors_in_support := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.neighborSet_subset_support u

theorem neighbor_membership : CleanStatements.neighbor_membership := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.mem_neighborSet u v

theorem not_own_neighbor : CleanStatements.not_own_neighbor := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.notMem_neighborSet_self

theorem common_neighbors_intersection : CleanStatements.common_neighbors_intersection := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_eq u v

theorem common_neighbors_membership : CleanStatements.common_neighbors_membership := by
  intro n G u v w
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.mem_commonNeighbors

theorem common_neighbors_symmetry : CleanStatements.common_neighbors_symmetry := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_symm u v

theorem common_neighbors_left : CleanStatements.common_neighbors_left := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_subset_neighborSet_left u v

theorem common_neighbors_right : CleanStatements.common_neighbors_right := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_subset_neighborSet_right u v

theorem reachability_reflexive : CleanStatements.reachability_reflexive := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.Reachable.refl u

theorem reachability_symmetric : CleanStatements.reachability_symmetric := by
  intro n G u v path
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact path.symm

theorem reachability_transitive : CleanStatements.reachability_transitive := by
  intro n G u v w first second
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact first.trans second

theorem edge_implies_reachability : CleanStatements.edge_implies_reachability := by
  intro n G u v edge
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact edge.reachable

theorem exponential_positive : CleanStatements.exponential_positive := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_pos x

theorem exponential_nonzero : CleanStatements.exponential_nonzero := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_ne_zero x

theorem exponential_sum : CleanStatements.exponential_sum := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_add x y

theorem exponential_difference : CleanStatements.exponential_difference := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_sub x y

theorem logarithm_exponential : CleanStatements.logarithm_exponential := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.log_exp x

theorem exponential_logarithm : CleanStatements.exponential_logarithm := by
  intro x positive
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_log positive

theorem logarithm_product : CleanStatements.logarithm_product := by
  intro x y nonzero_x nonzero_y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.log_mul nonzero_x nonzero_y

theorem logarithm_quotient : CleanStatements.logarithm_quotient := by
  intro x y nonzero_x nonzero_y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.log_div nonzero_x nonzero_y

theorem square_root_nonnegative : CleanStatements.square_root_nonnegative := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_nonneg x

theorem square_of_square_root : CleanStatements.square_of_square_root := by
  intro x nonnegative
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sq_sqrt nonnegative

theorem square_root_of_square : CleanStatements.square_root_of_square := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_sq_eq_abs x

theorem square_root_product : CleanStatements.square_root_product := by
  intro x y nonnegative
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_mul nonnegative y

theorem trigonometric_identity : CleanStatements.trigonometric_identity := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_sq_add_cos_sq x

theorem sine_addition : CleanStatements.sine_addition := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_add x y

theorem cosine_addition : CleanStatements.cosine_addition := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.cos_add x y

theorem sine_odd : CleanStatements.sine_odd := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_neg x

theorem cosine_even : CleanStatements.cosine_even := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.cos_neg x

theorem continuous_composition : CleanStatements.continuous_composition := by
  intro f g hf hg
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hf.comp hg

theorem continuous_sum : CleanStatements.continuous_sum := by
  intro f g hf hg
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hf.add hg

theorem continuous_product : CleanStatements.continuous_product := by
  intro f g hf hg
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hf.mul hg

theorem insertion_sort_sorted : CleanStatements.insertion_sort_sorted := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sorted_insertionSort (· ≤ ·) xs

theorem insertion_sort_permutation : CleanStatements.insertion_sort_permutation := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.perm_insertionSort (· ≤ ·) xs

theorem insertion_sort_length : CleanStatements.insertion_sort_length := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.length_insertionSort (· ≤ ·) xs

theorem insertion_sort_membership : CleanStatements.insertion_sort_membership := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mem_insertionSort (r := (· ≤ ·))

theorem sorted_input_unchanged : CleanStatements.sorted_input_unchanged := by
  intro xs ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact ordered.insertionSort_eq

theorem ordered_insert_length : CleanStatements.ordered_insert_length := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.orderedInsert_length (· ≤ ·) xs a

theorem ordered_insert_membership : CleanStatements.ordered_insert_membership := by
  intro xs a b
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mem_orderedInsert (· ≤ ·)

theorem ordered_insert_permutation : CleanStatements.ordered_insert_permutation := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.perm_orderedInsert (· ≤ ·) a xs

theorem ordered_insert_preserves_sortedness : CleanStatements.ordered_insert_preserves_sortedness := by
  intro xs a ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact ordered.orderedInsert a xs

theorem merge_sort_sorted : CleanStatements.merge_sort_sorted := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sorted_mergeSort' (· ≤ ·) xs

theorem merge_sort_sorted_input : CleanStatements.merge_sort_sorted_input := by
  intro xs ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mergeSort_eq_self (r := (· ≤ ·)) ordered

theorem sorting_algorithms_agree : CleanStatements.sorting_algorithms_agree := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mergeSort_eq_insertionSort (r := (· ≤ ·)) xs

theorem merge_preserves_sortedness : CleanStatements.merge_preserves_sortedness := by
  intro xs ys hx hy
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hx.merge hy

theorem insertion_sort_subsequence : CleanStatements.insertion_sort_subsequence := by
  intro xs ys ordered subsequence
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sublist_insertionSort ordered subsequence

theorem ordered_insert_contains_input : CleanStatements.ordered_insert_contains_input := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sublist_orderedInsert (r := (· ≤ ·)) a xs

theorem euclidean_coprime_reduction : CleanStatements.euclidean_coprime_reduction := by
  intro a b k
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.coprime_add_mul_right_right a b k

theorem euclidean_coprime_subtraction : CleanStatements.euclidean_coprime_subtraction := by
  intro a b ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.coprime_sub_self_left ordered

theorem coprime_lcm_product : CleanStatements.coprime_lcm_product := by
  intro a b cop
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.Coprime.lcm_eq_mul cop

theorem common_divisor_of_coprimes : CleanStatements.common_divisor_of_coprimes := by
  intro a b k cop divides_a divides_b
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.eq_one_of_dvd_coprimes cop divides_a divides_b

theorem coprime_product_divisibility : CleanStatements.coprime_product_divisibility := by
  intro a b k cop
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.Coprime.dvd_mul_right cop

theorem trace_commutator : CleanStatements.trace_commutator := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact by change Matrix.trace (A*B-B*A) = 0; rw [Matrix.trace_sub, Matrix.trace_mul_comm A B, sub_self]

theorem trace_matrix_square : CleanStatements.trace_matrix_square := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact rfl

theorem determinant_matrix_square : CleanStatements.determinant_matrix_square := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul A A

theorem authored_square_root : CleanStatements.authored_square_root := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_sq_eq_abs x

theorem authored_trigonometric_energy : CleanStatements.authored_trigonometric_energy := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_sq_add_cos_sq x

theorem distance_square_root : CleanStatements.distance_square_root := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_sq_eq_abs (x-y)

theorem nonadjacency_symmetry : CleanStatements.nonadjacency_symmetry := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact not_congr (G.adj_comm u v)

theorem nonadjacency_reflexive : CleanStatements.nonadjacency_reflexive := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.irrefl

theorem complement_from_nonadjacency : CleanStatements.complement_from_nonadjacency := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.compl_adj G u v

theorem insertion_sort_certificate : CleanStatements.insertion_sort_certificate := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact And.intro (List.sorted_insertionSort (· ≤ ·) xs) (List.perm_insertionSort (· ≤ ·) xs)

theorem merge_sort_certificate : CleanStatements.merge_sort_certificate := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact by change List.Sorted (· ≤ ·) (xs.mergeSort (· ≤ ·)) ∧ List.Perm (xs.mergeSort (· ≤ ·)) xs; rw [List.mergeSort_eq_insertionSort]; exact And.intro (List.sorted_insertionSort (· ≤ ·) xs) (List.perm_insertionSort (· ≤ ·) xs)

theorem certified_sort_unchanged : CleanStatements.certified_sort_unchanged := by
  intro xs ys certificate
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact certificate.1.insertionSort_eq

end CleanValidation

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
