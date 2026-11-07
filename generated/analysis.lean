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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

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

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
