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

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
