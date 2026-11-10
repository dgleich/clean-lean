import Lean
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Combinatorics.SimpleGraph.Basic
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.List.Sort
import Mathlib.Data.Nat.GCD.Basic

noncomputable abbrev cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_9ca9e49e1312ca23ac23   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_false_value_30a63b75654d87153a83   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

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

noncomputable def cleanNotation_forward_94c6b5d5b541da8e9cb5   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_backward_28a8b5535c542d09170e   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_pair_7293566521394090b270 {T : Type} (x : T) (y : T) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  [x,y]

noncomputable def cleanNotation_repeat_43596b98d283674588f1 {T : Type} (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (x : T) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  List.replicate m x

noncomputable def cleanNotation_choices_3869b0389fc5899414fc {T : Type} (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  xs.sections

noncomputable def cleanNotation_map_f557bfab0d7fd76b6333 {T : Type} {U : Type} (f : (T) → (U)) (xs : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (U)) :=
  xs.map f

noncomputable def cleanNotation_filter_8b767c2fe2a7e04a53c8 {T : Type} (p : (T) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) (xs : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  by classical exact xs.filter (fun x => decide (p x))

noncomputable def cleanNotation_choose_83747f80ab6eb76c31a9 {T : Type} (b : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) (x : T) (y : T) : T :=
  if b then x else y

noncomputable def cleanNotation_count_34a0092b00af19877f39  (b : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) (w : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  w.count b

noncomputable def cleanNotation_real_index_a64bd406e9ba037f5d20  (k : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (k : ℝ)

noncomputable def cleanNotation_sum_matrices_d143d09ffe7827b58400 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  xs.sum

noncomputable def cleanNotation_ordered_product_0b42c95bd52e77c022e4 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (xs : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  xs.prod

noncomputable def cleanNotation_sum_before_787190196ba8eac1567b {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (f : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  ∑ k ∈ Finset.range m, f k

noncomputable def cleanNotation_sum_vertices_ac738f0dedb9fdc607a5 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (f : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  ∑ i, f i

noncomputable def cleanNotation_entry_bfa117f79fbe29e1b7c0 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (i : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (j : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  A i j

noncomputable def cleanNotation_diagonal_563583ac7ef77d0b2544 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (f : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  Matrix.diagonal f

noncomputable def cleanNotation_pi_8c606dbc64fcc10745ac   : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.pi

noncomputable def cleanNotation_imaginary_unit_05e55a37796708ddfa4a   : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Complex.I

noncomputable def cleanNotation_complex_scalar_5c8262458d0e73ebcbc3  (x : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  (x : ℂ)

noncomputable def cleanNotation_complex_exponential_851c4918ebf64ef36ac9  (z : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Complex.exp z

noncomputable def cleanNotation_complex_matrix_5d421a79d2c34b6d9cac {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Complex.ofRealHom.mapMatrix A

noncomputable def cleanNotation_real_transpose_a8e459c0d458ab106fe6 {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (A : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  A.transpose

noncomputable def cleanDefine_Hermitian_3a771081642219bf165f {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (M : (_root_.cleanType_Matrix_61d617e3f5143c327dd3 (n) (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  M.IsHermitian

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

noncomputable def cleanNotation_zip_with_fe607c468f20d8544cc0 {T : Type} {U : Type} {V : Type} (f : (T) → ((U) → (V))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (y : (_root_.cleanType_List_530f2b2df99696550311 (U))) : (_root_.cleanType_List_530f2b2df99696550311 (V)) :=
  List.zipWith f x y

noncomputable def cleanNotation_fold_left_fa96b21e11a8f280669c {T : Type} {U : Type} (f : (U) → ((T) → (U))) (z : U) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : U :=
  List.foldl f z x

noncomputable def cleanNotation_fold_right_7f101e288f7afc41ae81 {T : Type} {U : Type} (f : (T) → ((U) → (U))) (z : U) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : U :=
  List.foldr f z x

noncomputable def cleanNotation_list_transpose_a4333e73532855973535 {T : Type} (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  List.transpose A

noncomputable def cleanDefine_accumulated_rounding_7210f2d01b46afb51232  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_difference_bf838970af972a894b2c ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (u))) (n))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))))

noncomputable def cleanDefine_accumulated_underflow_121eb07b6035c21247fe  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_real_index_a64bd406e9ba037f5d20 (n))) (eta))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((_root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232 (u) (m))))))

noncomputable def cleanDefine_unit_roundoff_958ed81f07d5f17a0db1  (p : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_quotient_7f1e597c9bc99f29eb9f ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) (p))))

noncomputable def cleanDefine_underflow_bound_555cc6f7710d0a951736  (p : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (e : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_quotient_7f1e597c9bc99f29eb9f ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 4))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) (e))) ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) (p))))))

noncomputable def cleanDefine_dot_6ea96fa29fd87cf4fe1e {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (y : (_root_.cleanType_List_530f2b2df99696550311 (T))) : T :=
  (_root_.cleanNotation_fold_left_fa96b21e11a8f280669c (add) (z) ((_root_.cleanNotation_zip_with_fe607c468f20d8544cc0 (mul) (x) (y))))

noncomputable def cleanDefine_vector_sum_e703695446dcf69d30c4 {T : Type} (add : (T) → ((T) → (T))) (z : T) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : T :=
  (_root_.cleanNotation_fold_right_7f101e288f7afc41ae81 (add) (z) (x))

noncomputable def cleanDefine_vector_add_6b6be04eb9313ca778d4 {T : Type} (add : (T) → ((T) → (T))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (y : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanNotation_zip_with_fe607c468f20d8544cc0 (add) (x) (y))

noncomputable def cleanDefine_vector_scale_ba6e1616e5a9cc2911d1 {T : Type} (mul : (T) → ((T) → (T))) (a : T) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((mul a)) (x))

noncomputable def cleanDefine_vector_axpby_303893ab38c2320a8767 {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (a : T) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (b : T) (y : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanDefine_vector_add_6b6be04eb9313ca778d4 (add) ((_root_.cleanDefine_vector_scale_ba6e1616e5a9cc2911d1 (mul) (a) (x))) ((_root_.cleanDefine_vector_scale_ba6e1616e5a9cc2911d1 (mul) (b) (y))))

noncomputable def cleanDefine_matrix_vector_7941c1feb696be3f2ffd {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) => (_root_.cleanDefine_dot_6ea96fa29fd87cf4fe1e (add) (mul) (z) (clean_bound_0) (x)))) (A))

noncomputable def cleanDefine_scaled_matrix_vector_a2707f02e38c7d27ceb1 {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (a : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanDefine_vector_scale_ba6e1616e5a9cc2911d1 (mul) (a) ((_root_.cleanDefine_matrix_vector_7941c1feb696be3f2ffd (add) (mul) (z) (A) (x))))

noncomputable def cleanDefine_general_matrix_vector_929664652fc47895604a {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (a : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (b : T) (y : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanDefine_vector_add_6b6be04eb9313ca778d4 (add) ((_root_.cleanDefine_scaled_matrix_vector_a2707f02e38c7d27ceb1 (add) (mul) (z) (a) (A) (x))) ((_root_.cleanDefine_vector_scale_ba6e1616e5a9cc2911d1 (mul) (b) (y))))

noncomputable def cleanDefine_matrix_scale_cb5f8c3bae2efc2de953 {T : Type} (mul : (T) → ((T) → (T))) (a : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) => (_root_.cleanDefine_vector_scale_ba6e1616e5a9cc2911d1 (mul) (a) (clean_bound_0)))) (A))

noncomputable def cleanDefine_matrix_add_da2af3de701e956d8287 {T : Type} (add : (T) → ((T) → (T))) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (B : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  (_root_.cleanNotation_zip_with_fe607c468f20d8544cc0 ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) => (fun (clean_bound_1 : (_root_.cleanType_List_530f2b2df99696550311 (T))) => (_root_.cleanDefine_vector_add_6b6be04eb9313ca778d4 (add) (clean_bound_0) (clean_bound_1))))) (A) (B))

noncomputable def cleanDefine_matrix_product_be4a1c4430fb57206d5b {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (B : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 (T))) => (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_1 : (_root_.cleanType_List_530f2b2df99696550311 (T))) => (_root_.cleanDefine_dot_6ea96fa29fd87cf4fe1e (add) (mul) (z) (clean_bound_0) (clean_bound_1)))) ((_root_.cleanNotation_list_transpose_a4333e73532855973535 (B)))))) (A))

noncomputable def cleanDefine_scaled_matrix_product_5dfd93619cbbfd61d7b6 {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (a : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (B : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  (_root_.cleanDefine_matrix_scale_cb5f8c3bae2efc2de953 (mul) (a) ((_root_.cleanDefine_matrix_product_be4a1c4430fb57206d5b (add) (mul) (z) (A) (B))))

noncomputable def cleanDefine_matrix_axpby_0405eb915a8e8b6bd30e {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (a : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (b : T) (B : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  (_root_.cleanDefine_matrix_add_da2af3de701e956d8287 (add) ((_root_.cleanDefine_matrix_scale_cb5f8c3bae2efc2de953 (mul) (a) (A))) ((_root_.cleanDefine_matrix_scale_cb5f8c3bae2efc2de953 (mul) (b) (B))))

noncomputable def cleanDefine_general_matrix_product_c28e325c9fb9c2a6d3ab {T : Type} (add : (T) → ((T) → (T))) (mul : (T) → ((T) → (T))) (z : T) (a : T) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (X : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) (b : T) (Y : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T))))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 (T)))) :=
  (_root_.cleanDefine_matrix_axpby_0405eb915a8e8b6bd30e (add) (mul) (a) ((_root_.cleanDefine_matrix_product_be4a1c4430fb57206d5b (add) (mul) (z) (A) (X))) (b) (Y))

noncomputable def cleanDefine_fused_dot_82309e223fc8b8a068f7 {T : Type} (fma : (T) → ((T) → ((T) → (T)))) (z : T) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (y : (_root_.cleanType_List_530f2b2df99696550311 (T))) : T :=
  (_root_.cleanNotation_fold_left_fa96b21e11a8f280669c ((fun (clean_bound_0 : T) => (fun (clean_bound_1 : (T) → (T)) => (clean_bound_1 clean_bound_0)))) (z) ((_root_.cleanNotation_zip_with_fe607c468f20d8544cc0 ((fun (clean_bound_2 : T) => (fun (clean_bound_3 : T) => (fun (clean_bound_4 : T) => (((fma clean_bound_2) clean_bound_3) clean_bound_4))))) (x) (y))))

noncomputable def cleanDefine_exact_sum_d52de3d06355aea4dde9  (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_vector_sum_e703695446dcf69d30c4 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (clean_bound_0) (clean_bound_1))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (x))

noncomputable def cleanDefine_exact_dot_0a192d4ba96c68d19d2d  (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_dot_6ea96fa29fd87cf4fe1e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (clean_bound_0) (clean_bound_1))))) ((fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (clean_bound_2) (clean_bound_3))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (x) (y))

noncomputable def cleanDefine_absolute_product_sum_5ecaf6240098c655b732  (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_exact_sum_d52de3d06355aea4dde9 ((_root_.cleanNotation_zip_with_fe607c468f20d8544cc0 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_abs_f5af20d198e156710853 ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (clean_bound_0) (clean_bound_1))))))) (x) (y))))

noncomputable def cleanDefine_vector_norm_one_36f017393fc6e83edecd  (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_exact_sum_d52de3d06355aea4dde9 ((_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_0)))) (x))))

noncomputable def cleanDefine_vector_norm_two_002f09ed08e8d0244be6  (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanDefine_exact_dot_0a192d4ba96c68d19d2d (x) (x))))

noncomputable def cleanDefine_floating_equivalence_4ff6d17abf2e2679e2a7 {T : Type} (finite : (T) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) (value : (T) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((finite x)) ((finite y)))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((value x)) ((value y)))))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_negation_7efde94db326666449aa ((finite x)))) ((_root_.cleanDefine_negation_7efde94db326666449aa ((finite y)))))))

noncomputable def cleanDefine_single_operation_error_be4054a1e6730b36fd61  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (exact : (_root_.cleanType_Real_107b6641a486642ad8e1)) (rounded : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (rounded) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (exact) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (clean_bound_0))))) (clean_bound_1))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_0))) (u))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_1))) (eta))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (clean_bound_0) (clean_bound_1))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))))))))

noncomputable def cleanDefine_forward_error_1365d6fa5390ae74d3f1  (exact : (_root_.cleanType_Real_107b6641a486642ad8e1)) (rounded : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_abs_f5af20d198e156710853 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c (exact) (rounded))))

noncomputable def cleanNotation_list_length_878ac6e4d4bce8c76206 {T : Type} (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  List.length x

noncomputable def cleanDefine_all_entries_60f82dcf1382f3fe0b8e {T : Type} (p : (T) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Forall p x

noncomputable def cleanDefine_corresponding_entries_a491f2af7c60dd0f2a26 {T : Type} {U : Type} (p : (T) → ((U) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35)))) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (y : (_root_.cleanType_List_530f2b2df99696550311 (U))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Forall₂ p x y

noncomputable def cleanDefine_relative_perturbation_31ec27673c71424efa6f  (bound : (_root_.cleanType_Real_107b6641a486642ad8e1)) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_corresponding_entries_a491f2af7c60dd0f2a26 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_1) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (clean_bound_2))))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_2))) (bound))))))))) (x) (y))

noncomputable def cleanDefine_dot_accuracy_172c4d21d79cb6c34814  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (y))))) ((@Exists ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (r) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanDefine_exact_dot_0a192d4ba96c68d19d2d (clean_bound_0) (y))) (clean_bound_1))))) ((_root_.cleanDefine_relative_perturbation_31ec27673c71424efa6f ((_root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232 (u) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))))) (x) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_1))) ((_root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe (u) (eta) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))))))))))))))

noncomputable def cleanDefine_sum_accuracy_7b3627f9af5adc6ef2f7  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@Exists ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (r) ((_root_.cleanDefine_exact_sum_d52de3d06355aea4dde9 (clean_bound_0))))) ((_root_.cleanDefine_relative_perturbation_31ec27673c71424efa6f ((_root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232 (u) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) (x) (clean_bound_0))))))

noncomputable def cleanDefine_exact_matrix_vector_448aebd17b5fa0cdf24d  (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanDefine_matrix_vector_7941c1feb696be3f2ffd ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (clean_bound_0) (clean_bound_1))))) ((fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (clean_bound_2) (clean_bound_3))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (A) (x))

noncomputable def cleanDefine_entrywise_matrix_perturbation_03142c17d38ed4d32801  (bound : (_root_.cleanType_Real_107b6641a486642ad8e1)) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) (E : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_corresponding_entries_a491f2af7c60dd0f2a26 ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (fun (clean_bound_1 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_corresponding_entries_a491f2af7c60dd0f2a26 ((fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_3))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 (bound) ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_2))))))))) (clean_bound_0) (clean_bound_1))))) (A) (E))

noncomputable def cleanDefine_matrix_vector_accuracy_9b488b4e4617e7e42710  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (r : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (clean_bound_0))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x)))))) (A))) ((@Exists ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) (fun (clean_bound_1 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) => (@Exists ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_2 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (clean_bound_2))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (A))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (r) ((_root_.cleanDefine_vector_add_6b6be04eb9313ca778d4 ((fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_4 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (clean_bound_3) (clean_bound_4))))) ((_root_.cleanDefine_exact_matrix_vector_448aebd17b5fa0cdf24d ((_root_.cleanDefine_matrix_add_da2af3de701e956d8287 ((fun (clean_bound_5 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_6 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 (clean_bound_5) (clean_bound_6))))) (A) (clean_bound_1))) (x))) (clean_bound_2))))))) ((_root_.cleanDefine_entrywise_matrix_perturbation_03142c17d38ed4d32801 ((_root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232 (u) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))))) (A) (clean_bound_1))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_7 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_7))) ((_root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe (u) (eta) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x)))))))) (clean_bound_2))))))))))

noncomputable def cleanDefine_safe_entry_bound_aa14b901793547e11dc6  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (e : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_sqrt_6e06b1a141fb4ca62c3f ((_root_.cleanNotation_real_quotient_7f1e597c9bc99f29eb9f ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((_root_.cleanNotation_real_quotient_7f1e597c9bc99f29eb9f ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) (e))) (eta))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (u))))) ((_root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe (u) (eta) (n) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanNotation_real_index_a64bd406e9ba037f5d20 (n))) ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (u))) (n))))))))))

noncomputable def cleanDefine_safe_matrix_vector_input_222c46a65f65c8722712  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (e : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (A : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe (u) (eta) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))))) ((_root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) (e))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_0 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (clean_bound_0))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x)))))) (A))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_1))) ((_root_.cleanDefine_safe_entry_bound_aa14b901793547e11dc6 (u) (eta) (e) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x)))))))) (x))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_2 : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 (clean_bound_3))) ((_root_.cleanDefine_safe_entry_bound_aa14b901793547e11dc6 (u) (eta) (e) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x)))))))) (clean_bound_2)))) (A))))

noncomputable def cleanDefine_dot_forward_accuracy_d131129e699b83f1a844  (u : (_root_.cleanType_Real_107b6641a486642ad8e1)) (eta : (_root_.cleanType_Real_107b6641a486642ad8e1)) (x : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (y : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_abs_f5af20d198e156710853 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c (r) ((_root_.cleanDefine_exact_dot_0a192d4ba96c68d19d2d (x) (y))))))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((_root_.cleanNotation_real_product_4734d65dbf4a4907df19 ((_root_.cleanDefine_absolute_product_sum_5ecaf6240098c655b732 (x) (y))) ((_root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232 (u) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))))))) ((_root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe (u) (eta) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 (x))))))))

noncomputable def cleanNotation_initial_indices_290ee50ece7b99801502  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  List.range n

noncomputable def cleanNotation_list_entry_4cb3e9c95faf033d511a {T : Type} (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (i : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (fallback : T) : T :=
  List.getD x i fallback

structure cleanStructure_CSR_28b0e36df678147b6f80 («T» : Type) : Type where
  «rows» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «columns» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «values» : (_root_.cleanType_List_530f2b2df99696550311 («T»))
  «indices» : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))
  «pointers» : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))

noncomputable def cleanConstructor_csr_storage_d06dad161fb206cd5557 («T» : Type) («rows» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («columns» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («values» : (_root_.cleanType_List_530f2b2df99696550311 («T»))) («indices» : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) («pointers» : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : _root_.cleanStructure_CSR_28b0e36df678147b6f80 («T») :=
  @_root_.cleanStructure_CSR_28b0e36df678147b6f80.mk «T» «rows» «columns» «values» «indices» «pointers»

noncomputable def cleanDefine_row_start_176583928f269d5be65b {T : Type} (C : _root_.cleanStructure_CSR_28b0e36df678147b6f80 (T)) (i : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  (_root_.cleanNotation_list_entry_4cb3e9c95faf033d511a ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«pointers» (T) (C))) (i) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))

noncomputable def cleanDefine_row_positions_adcc37778e935bcf96f1 {T : Type} (C : _root_.cleanStructure_CSR_28b0e36df678147b6f80 (T)) (i : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_List_530f2b2df99696550311 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) (i))) (clean_bound_0)))) ((_root_.cleanNotation_initial_indices_290ee50ece7b99801502 ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (i) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) (i))))))))

noncomputable def cleanDefine_valid_csr_feee44a1d4f187f44442 {T : Type} (C : _root_.cleanStructure_CSR_28b0e36df678147b6f80 (T)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«pointers» (T) (C))))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«rows» (T) (C))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«indices» (T) (C))))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«values» (T) (C))))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«rows» (T) (C))))) ((_root_.cleanNotation_list_length_878ac6e4d4bce8c76206 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«values» (T) (C))))))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) (clean_bound_0))) ((_root_.cleanDefine_row_start_176583928f269d5be65b (C) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (clean_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))))) ((_root_.cleanNotation_initial_indices_290ee50ece7b99801502 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«rows» (T) (C))))))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_natural_less_b8fc7193a9665e88d3b6 (clean_bound_1) ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«columns» (T) (C)))))) ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«indices» (T) (C))))))) ((_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_2 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_3 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_all_entries_60f82dcf1382f3fe0b8e ((fun (clean_bound_4 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_implication_3b80760984def210df07 ((_root_.cleanDefine_natural_less_b8fc7193a9665e88d3b6 (clean_bound_3) (clean_bound_4))) ((_root_.cleanDefine_natural_less_b8fc7193a9665e88d3b6 ((_root_.cleanNotation_list_entry_4cb3e9c95faf033d511a ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«indices» (T) (C))) (clean_bound_3) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) ((_root_.cleanNotation_list_entry_4cb3e9c95faf033d511a ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«indices» (T) (C))) (clean_bound_4) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)))))))))) ((_root_.cleanDefine_row_positions_adcc37778e935bcf96f1 (C) (clean_bound_2)))))) ((_root_.cleanDefine_row_positions_adcc37778e935bcf96f1 (C) (clean_bound_2)))))) ((_root_.cleanNotation_initial_indices_290ee50ece7b99801502 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«rows» (T) (C))))))))

noncomputable def cleanDefine_csr_row_dbbf3150e66ae12c6a92 {T : Type} (fma : (T) → ((T) → ((T) → (T)))) (z : T) (C : _root_.cleanStructure_CSR_28b0e36df678147b6f80 (T)) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) (i : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : T :=
  (_root_.cleanNotation_fold_left_fa96b21e11a8f280669c ((fun (clean_bound_0 : T) => (fun (clean_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (((fma (_root_.cleanNotation_list_entry_4cb3e9c95faf033d511a ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«values» (T) (C))) (clean_bound_1) (z))) (_root_.cleanNotation_list_entry_4cb3e9c95faf033d511a (x) ((_root_.cleanNotation_list_entry_4cb3e9c95faf033d511a ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«indices» (T) (C))) (clean_bound_1) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) (z))) clean_bound_0)))) (z) ((_root_.cleanDefine_row_positions_adcc37778e935bcf96f1 (C) (i))))

noncomputable def cleanDefine_csr_product_b1e9068717472ba9b528 {T : Type} (fma : (T) → ((T) → ((T) → (T)))) (z : T) (C : _root_.cleanStructure_CSR_28b0e36df678147b6f80 (T)) (x : (_root_.cleanType_List_530f2b2df99696550311 (T))) : (_root_.cleanType_List_530f2b2df99696550311 (T)) :=
  (_root_.cleanNotation_map_f557bfab0d7fd76b6333 ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_csr_row_dbbf3150e66ae12c6a92 (fma) (z) (C) (x) (clean_bound_0)))) ((_root_.cleanNotation_initial_indices_290ee50ece7b99801502 ((@_root_.cleanStructure_CSR_28b0e36df678147b6f80.«rows» (T) (C))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: laproof
reference: equation 4
relationship: adapted
-/
def no_accumulated_rounding_at_zero : Prop :=
  ∀ (u : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232 (u) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))

/--
source: laproof
reference: equation 5
relationship: adapted
-/
def no_accumulated_underflow_at_zero : Prop :=
  ∀ (u eta : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe (u) (eta) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))) (m))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))

end CleanStatements

namespace LAProofChecks
 theorem rounding_zero : CleanStatements.no_accumulated_rounding_at_zero := by
  simp [CleanStatements.no_accumulated_rounding_at_zero, _root_.cleanDefine_equal_59dc0f11ba9b345348cf, _root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232, _root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe, _root_.cleanNotation_real_difference_bf838970af972a894b2c, _root_.cleanNotation_real_sum_8dd895080a4442dce6f9, _root_.cleanNotation_real_product_4734d65dbf4a4907df19, _root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476, _root_.cleanNotation_real_index_a64bd406e9ba037f5d20, cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3]
 theorem underflow_zero : CleanStatements.no_accumulated_underflow_at_zero := by
  simp [CleanStatements.no_accumulated_underflow_at_zero, _root_.cleanDefine_equal_59dc0f11ba9b345348cf, _root_.cleanDefine_accumulated_rounding_7210f2d01b46afb51232, _root_.cleanDefine_accumulated_underflow_121eb07b6035c21247fe, _root_.cleanNotation_real_difference_bf838970af972a894b2c, _root_.cleanNotation_real_sum_8dd895080a4442dce6f9, _root_.cleanNotation_real_product_4734d65dbf4a4907df19, _root_.cleanNotation_real_power_c22d5a3a02ef7c3e8476, _root_.cleanNotation_real_index_a64bd406e9ba037f5d20, cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3]

 theorem dot_model (T : Type) (add mul : T → T → T) (z : T) (x y : List T) :
  @_root_.cleanDefine_dot_6ea96fa29fd87cf4fe1e T add mul z x y = List.foldl add z (List.zipWith mul x y) := by rfl
 theorem sum_model (T : Type) (add : T → T → T) (z : T) (x : List T) :
  @_root_.cleanDefine_vector_sum_e703695446dcf69d30c4 T add z x = List.foldr add z x := by rfl
 theorem matrix_model (T : Type) (add mul : T → T → T) (z : T) (A B : List (List T)) :
  @_root_.cleanDefine_matrix_product_be4a1c4430fb57206d5b T add mul z A B =
    A.map (fun row => B.transpose.map (fun col => List.foldl add z (List.zipWith mul row col))) := by rfl
 theorem fused_model (T : Type) (fma : T → T → T → T) (z : T) (x y : List T) :
  @_root_.cleanDefine_fused_dot_82309e223fc8b8a068f7 T fma z x y =
    List.foldl (fun s step => step s) z (List.zipWith (fun a b s => fma a b s) x y) := by rfl
 theorem equivalence_model (T : Type) (finite : T → Prop) (value : T → Real) (x y : T) :
  @_root_.cleanDefine_floating_equivalence_4ff6d17abf2e2679e2a7 T finite value x y ↔
    ((finite x ∧ finite y) ∧ value x = value y) ∨ (¬ finite x ∧ ¬ finite y) := by rfl
end LAProofChecks

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
