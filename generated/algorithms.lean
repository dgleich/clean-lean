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

noncomputable def cleanDefine_implication_9c70b95b865a68fb6e58  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x → y

noncomputable def cleanDefine_equivalence_cad7bc5ebe96d36e4136  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
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
  (_root_.cleanDefine_equivalence_cad7bc5ebe96d36e4136 ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (a) ((_root_.cleanNotation_insertionSort_054943e1f7dcf8820dd0 (xs))))) ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (a) (xs))))

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
  (_root_.cleanDefine_equivalence_cad7bc5ebe96d36e4136 ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (b) ((_root_.cleanNotation_insert_601c7aa53134eb475439 (a) (xs))))) ((_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (b) (a))) ((_root_.cleanDefine_list_member_a533590d6d1f9d128c19 (b) (xs))))))

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
  (_root_.cleanDefine_equivalence_cad7bc5ebe96d36e4136 ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (a) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (b) ((_root_.cleanNotation_natural_product_0c2b2fc759f8d93a79af (k) (a))))))) ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (a) (b))))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def euclidean_coprime_subtraction : Prop :=
  ∀ (a b : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («ordered» : (_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (a) (b))),
  (_root_.cleanDefine_equivalence_cad7bc5ebe96d36e4136 ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 (b) (a))) (a))) ((_root_.cleanDefine_coprime_34ae954d5e1846c7a656 (b) (a))))

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
  (_root_.cleanDefine_equivalence_cad7bc5ebe96d36e4136 ((_root_.cleanDefine_natural_divides_2611187ff6f65c3a68d5 (k) ((_root_.cleanNotation_natural_product_0c2b2fc759f8d93a79af (a) (b))))) ((_root_.cleanDefine_natural_divides_2611187ff6f65c3a68d5 (k) (a))))

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

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
