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
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.Algebra.Exact
import Mathlib.LinearAlgebra.Prod

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

noncomputable abbrev cleanType_FieldStructure_473fae039b953a4e35cf (K : Type) : Type :=
  Field K

noncomputable abbrev cleanType_AdditiveGroup_666602168ae423a21d05 (V : Type) : Type :=
  AddCommGroup V

noncomputable abbrev cleanType_ModuleStructure_0b8e617c710f84874c5e (K : Type) (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : Type) (a : (_root_.cleanType_AdditiveGroup_666602168ae423a21d05 (V))) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid

structure cleanStructure_LinearSpace_f45f02f1386f986b860e («K» : Type) («f» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («V» : Type) : Type where
  «addition» : (_root_.cleanType_AdditiveGroup_666602168ae423a21d05 («V»))
  «action» : (_root_.cleanType_ModuleStructure_0b8e617c710f84874c5e («K») («f») («V») («addition»))

noncomputable def cleanConstructor_linear_space_c6906729504c965f4274 («K» : Type) («f» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («V» : Type) («addition» : (_root_.cleanType_AdditiveGroup_666602168ae423a21d05 («V»))) («action» : (_root_.cleanType_ModuleStructure_0b8e617c710f84874c5e («K») («f») («V») («addition»))) : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e («K») («f») («V») :=
  @_root_.cleanStructure_LinearSpace_f45f02f1386f986b860e.mk «K» «f» «V» «addition» «action»

noncomputable abbrev cleanType_Subspace_dc5ab31620781ca45e7b (K : Type) (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : Type) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action

noncomputable def cleanNotation_subspace_carrier_a36fe035268c9f2bf46c {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Set_6e300741358eee425e81 (V)) :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U

noncomputable def cleanDefine_belongs_to_subspace_1343338f28b5d525ee95 {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (x : V) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (x) ((@_root_.cleanNotation_subspace_carrier_a36fe035268c9f2bf46c (K) (V) (f) (L) (U))))

noncomputable def cleanDefine_subspace_included_in_82638d668c6c122b2509 {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) (W : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : V), (_root_.cleanDefine_implication_3b80760984def210df07 ((@_root_.cleanDefine_belongs_to_subspace_1343338f28b5d525ee95 (K) (V) (f) (L) (clean_bound_0) (U))) ((@_root_.cleanDefine_belongs_to_subspace_1343338f28b5d525ee95 (K) (V) (f) (L) (clean_bound_0) (W)))))

noncomputable def cleanNotation_subspace_infimum_9664207c517e43bafadf {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (spaces : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))))) : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)) :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) spaces

noncomputable def cleanDefine_intersection_of_subspaces_b8a6bebf6e350e62c1d5 {K : Type} {V : Type} {I : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (A : (_root_.cleanType_Set_6e300741358eee425e81 (I))) (spaces : (I) → ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)))) : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)) :=
  (@_root_.cleanNotation_subspace_infimum_9664207c517e43bafadf (K) (V) (f) (L) ((_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) => (@Exists (I) (fun (clean_bound_1 : I) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (clean_bound_1) (A))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) ((spaces clean_bound_1))))))))))))

noncomputable abbrev cleanType_CoefficientModule_79514ce65e42b4219878 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) : Type 1 :=
  (@ModuleCat.{0,0} K field.toRing)

noncomputable abbrev cleanType_ModuleElement_0c3dbc92ed35f00927af (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : Type :=
  (@ModuleCat.carrier K field.toRing M)

noncomputable def cleanNotation_coefficient_module_573cf10e404b9587b3bb  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (field) (V)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  @ModuleCat.of K field.toRing V L.addition L.action

noncomputable abbrev cleanType_ModuleMap_9bf239ee5af2145b9b57 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : Type :=
  (@ModuleCat.Hom K field.toRing M N)

noncomputable abbrev cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : Type :=
  (@Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)

noncomputable def cleanNotation_module_map_value_d59145d0b679c3ce3011 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (N)) :=
  (@ModuleCat.Hom.hom K field.toRing M N f) x

noncomputable def cleanNotation_module_map_range_7b55a8a231e2462f9d90 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (N)) :=
  LinearMap.range (@ModuleCat.Hom.hom K field.toRing M N f)

noncomputable def cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M)))) :=
  U.carrier

noncomputable def cleanDefine_belongs_to_module_subspace_91c638861de4a497c6ac {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))) (U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (x) ((@_root_.cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f (K) (field) (M) (U))))

noncomputable def cleanDefine_same_module_e02a08d57e6a128abb90 {K : Type} {field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))} (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  M = N

noncomputable def cleanNotation_module_map_kernel_1d27603bcecb7f5392b0 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)) :=
  LinearMap.ker (@ModuleCat.Hom.hom K field.toRing M N f)

noncomputable def cleanNotation_module_zero_element_6d1fb508cb7963c44614 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M)) :=
  (0 : M.carrier)

noncomputable def cleanDefine_exact_pair_2147c6c3f19c03b14c8f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (P : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (N) (P))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_map_range_7b55a8a231e2462f9d90 (K) (field) (M) (N) (f))) ((@_root_.cleanNotation_module_map_kernel_1d27603bcecb7f5392b0 (K) (field) (N) (P) (g))))

noncomputable def cleanDefine_exact_b7fa96484fe39f8c9b3d {K : Type} {field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))} {M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} {N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} {P : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (N) (P))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@_root_.cleanDefine_exact_pair_2147c6c3f19c03b14c8f (K) (field) (M) (N) (P) (f) (g))

structure cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) : Type 1 where
  «object» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))
  «arrow» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») ((«object» (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (clean_pi_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) ((«object» clean_pi_bound_0))))

noncomputable def cleanConstructor_module_sequence_d5013329b3d9b38d9f4e («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («object» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))) («arrow» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») ((«object» (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (clean_pi_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) ((«object» clean_pi_bound_0))))) : _root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71 («K») («field») :=
  @_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.mk «K» «field» «object» «arrow»

noncomputable def cleanDefine_exact_pair_at_7aa740bb698f9959a08e {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (S : _root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71 (K) (field)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@_root_.cleanDefine_exact_pair_2147c6c3f19c03b14c8f (K) (field) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«object» (K) (field) (S)) (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«object» (K) (field) (S)) (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«object» (K) (field) (S)) n)) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«arrow» (K) (field) (S)) (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«arrow» (K) (field) (S)) n)))

noncomputable def cleanDefine_exact_sequence_interior_e96d5e1de470d9c05974 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (S : _root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71 (K) (field)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)), (@_root_.cleanDefine_exact_pair_at_7aa740bb698f9959a08e (K) (field) (S) (clean_bound_0)))

noncomputable def cleanNotation_module_zero_map_77b77786d34ab8aa0534 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N)) :=
  (letI : Field K := field; ModuleCat.ofHom (0 : M.carrier →ₗ[K] N.carrier))

noncomputable def cleanDefine_onto_2272460b6a00937af032 {K : Type} {field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))} {M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} {N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (N))), (@Exists ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))) (fun (clean_bound_1 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))) => (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_map_value_d59145d0b679c3ce3011 (K) (field) (M) (N) (f) (clean_bound_1))) (clean_bound_0)))))

noncomputable def cleanDefine_exact_sequence_ending_in_zero_df52af1d66969622d038 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (S : _root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71 (K) (field)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanDefine_exact_sequence_interior_e96d5e1de470d9c05974 (K) (field) (S))) ((@_root_.cleanDefine_onto_2272460b6a00937af032 (K) (field) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«object» (K) (field) (S)) (_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«object» (K) (field) (S)) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)))) (((@_root_.cleanStructure_ModuleSequence_23f5156e3d7cd1b21f71.«arrow» (K) (field) (S)) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)))))))

structure cleanStructure_GradedModule_4e52f71cb062f2010cae («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) : Type 1 where
  «component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))

noncomputable def cleanConstructor_graded_module_f18663848933026544e1 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))) : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field») :=
  @_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.mk «K» «field» «component»

noncomputable def cleanDefine_component_module_62544f8701c4206d87f6 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (p : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  ((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (M)) p)

structure cleanStructure_GradedMap_cef77a5beb9385857123 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («M» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) («N» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) : Type where
  «component» : (clean_pi_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («M»)) clean_pi_bound_1)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («N»)) clean_pi_bound_1))))

noncomputable def cleanConstructor_graded_map_2dd61dc3853227ee1295 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («M» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) («N» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) («component» : (clean_pi_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («M»)) clean_pi_bound_1)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («N»)) clean_pi_bound_1))))) : _root_.cleanStructure_GradedMap_cef77a5beb9385857123 («K») («field») («M») («N») :=
  @_root_.cleanStructure_GradedMap_cef77a5beb9385857123.mk «K» «field» «M» «N» «component»

noncomputable def cleanNotation_module_identity_db2143c0391459c1a649 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (M)) :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M

noncomputable def cleanNotation_module_composition_540bbd166f48e5aeba29 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (P : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (N) (P))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (P)) :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g

noncomputable def cleanDefine_graded_identity_f0a140a8a2156b23d4cc {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) : _root_.cleanStructure_GradedMap_cef77a5beb9385857123 (K) (field) (M) (M) :=
  (@_root_.cleanConstructor_graded_map_2dd61dc3853227ee1295 (K) (field) (M) (M) ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_identity_db2143c0391459c1a649 (K) (field) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (M)) clean_bound_0))))))

noncomputable def cleanDefine_graded_composition_6a5c5dcfd639c948aaf7 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (N : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (P : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (f : _root_.cleanStructure_GradedMap_cef77a5beb9385857123 (K) (field) (M) (N)) (g : _root_.cleanStructure_GradedMap_cef77a5beb9385857123 (K) (field) (N) (P)) : _root_.cleanStructure_GradedMap_cef77a5beb9385857123 (K) (field) (M) (P) :=
  (@_root_.cleanConstructor_graded_map_2dd61dc3853227ee1295 (K) (field) (M) (P) ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (M)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (N)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (P)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_cef77a5beb9385857123.«component» (K) (field) (M) (N) (f)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_cef77a5beb9385857123.«component» (K) (field) (N) (P) (g)) clean_bound_0))))))

noncomputable def cleanNotation_module_product_2b8332ad177f6804ae52 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (letI : Field K := field; ModuleCat.of K (M.carrier × N.carrier))

noncomputable def cleanNotation_left_inclusion_1c1de41245abb50ac7ae {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N)))) :=
  (letI : Field K := field; ModuleCat.ofHom (LinearMap.inl K M.carrier N.carrier))

noncomputable def cleanNotation_right_projection_f807ba35ded39db28e3c {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N))) (N)) :=
  (letI : Field K := field; ModuleCat.ofHom (LinearMap.snd K M.carrier N.carrier))

noncomputable def cleanNotation_pair_module_maps_03ec468cb25325a7fe1c {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) (M))) (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) (N))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N)))) :=
  (letI : Field K := field; ModuleCat.ofHom (f.hom.prod g.hom))

noncomputable def cleanNotation_merge_module_maps_55f201a50aea52cac405 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (P : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (h : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (P))) (k : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (N) (P))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N))) (P)) :=
  (letI : Field K := field; ModuleCat.ofHom (h.hom.coprod k.hom))

noncomputable def cleanNotation_negative_module_map_021d40d10b0a413f0594 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N)) :=
  (letI : Field K := field; ModuleCat.ofHom (-f.hom))

noncomputable def cleanDefine_signed_pair_f1a4fb6858ee12ea1aed {K : Type} {field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))} {L : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} {M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} {N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))} (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) (M))) (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) (N))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N)))) :=
  (@_root_.cleanNotation_pair_module_maps_03ec468cb25325a7fe1c (K) (field) (L) (M) (N) (f) ((@_root_.cleanNotation_negative_module_map_021d40d10b0a413f0594 (K) (field) (L) (N) (g))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: products
reference: LinearMap.inl and LinearMap.snd
relationship: adapted
-/
def binary_module_sequence_is_exact : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (M N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))),
  (@_root_.cleanDefine_exact_b7fa96484fe39f8c9b3d (K) (field) (M) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N))) (N) ((@_root_.cleanNotation_left_inclusion_1c1de41245abb50ac7ae (K) (field) (M) (N))) ((@_root_.cleanNotation_right_projection_f807ba35ded39db28e3c (K) (field) (M) (N))))

/--
source: products
reference: LinearMap.snd
relationship: adapted
-/
def right_projection_is_onto : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (M N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))),
  (@_root_.cleanDefine_onto_2272460b6a00937af032 (K) (field) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N))) (N) ((@_root_.cleanNotation_right_projection_f807ba35ded39db28e3c (K) (field) (M) (N))))

/--
source: products
reference: signed pair cancellation
relationship: original
-/
def signed_square_composes_to_zero : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (L M N P : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))),
  ∀ (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) (M))),
  ∀ (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (L) (N))),
  ∀ (h : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (P))),
  ∀ (k : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (N) (P))),
  ∀ («commutes» : (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (L) (M) (P) (f) (h))) ((@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (L) (N) (P) (g) (k))))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (L) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) (M) (N))) (P) ((@_root_.cleanDefine_signed_pair_f1a4fb6858ee12ea1aed (K) (field) (L) (M) (N) (f) (g))) ((@_root_.cleanNotation_merge_module_maps_55f201a50aea52cac405 (K) (field) (M) (N) (P) (h) (k))))) ((@_root_.cleanNotation_module_zero_map_77b77786d34ab8aa0534 (K) (field) (L) (P))))

end CleanStatements

namespace ModuleProductOracle
noncomputable def product {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field) : cleanType_CoefficientModule_79514ce65e42b4219878 K field :=
 letI : Field K := field
 ModuleCat.of K (M.carrier × N.carrier)
noncomputable def inclusion {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field) :
 cleanType_ModuleMap_9bf239ee5af2145b9b57 K field M (cleanNotation_module_product_2b8332ad177f6804ae52 field M N) :=
 letI : Field K := field
 ModuleCat.ofHom (LinearMap.inl K M.carrier N.carrier)
noncomputable def projection {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field) :
 cleanType_ModuleMap_9bf239ee5af2145b9b57 K field (cleanNotation_module_product_2b8332ad177f6804ae52 field M N) N :=
 letI : Field K := field
 ModuleCat.ofHom (LinearMap.snd K M.carrier N.carrier)
def exactStatement : Prop := ∀ (K : cleanType_Type_c1fed1af64ab6f12e0ed) (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field),
 cleanDefine_exact_b7fa96484fe39f8c9b3d (cleanNotation_left_inclusion_1c1de41245abb50ac7ae field M N) (cleanNotation_right_projection_f807ba35ded39db28e3c field M N)
def ontoStatement : Prop := ∀ (K : cleanType_Type_c1fed1af64ab6f12e0ed) (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field),
 cleanDefine_onto_2272460b6a00937af032 (cleanNotation_right_projection_f807ba35ded39db28e3c field M N)
noncomputable def paired {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (L M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field)
 (f : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L M) (g : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L N) : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L (cleanNotation_module_product_2b8332ad177f6804ae52 field M N) :=
 letI : Field K := field
 ModuleCat.ofHom (f.hom.prod g.hom)
noncomputable def merged {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N P : cleanType_CoefficientModule_79514ce65e42b4219878 K field)
 (h : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field M P) (k : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field N P) : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field (cleanNotation_module_product_2b8332ad177f6804ae52 field M N) P :=
 letI : Field K := field
 ModuleCat.ofHom (h.hom.coprod k.hom)
noncomputable def negative {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field)
 (f : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field M N) : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field M N :=
 letI : Field K := field
 ModuleCat.ofHom (-f.hom)
noncomputable def signed {K : Type} {field : cleanType_FieldStructure_473fae039b953a4e35cf K} {L M N : cleanType_CoefficientModule_79514ce65e42b4219878 K field}
 (f : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L M) (g : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L N) : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L (cleanNotation_module_product_2b8332ad177f6804ae52 field M N) :=
 cleanNotation_pair_module_maps_03ec468cb25325a7fe1c field L M N f (cleanNotation_negative_module_map_021d40d10b0a413f0594 field L N g)
def cancellation : Prop := ∀ (K : cleanType_Type_c1fed1af64ab6f12e0ed) (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (L M N P : cleanType_CoefficientModule_79514ce65e42b4219878 K field)
 (f : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L M) (g : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field L N) (h : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field M P) (k : cleanType_ModuleMap_9bf239ee5af2145b9b57 K field N P),
 cleanDefine_equal_59dc0f11ba9b345348cf (cleanNotation_module_composition_540bbd166f48e5aeba29 field L M P f h) (cleanNotation_module_composition_540bbd166f48e5aeba29 field L N P g k) →
 cleanDefine_equal_59dc0f11ba9b345348cf (cleanNotation_module_composition_540bbd166f48e5aeba29 field L (cleanNotation_module_product_2b8332ad177f6804ae52 field M N) P (cleanDefine_signed_pair_f1a4fb6858ee12ea1aed f g) (cleanNotation_merge_module_maps_55f201a50aea52cac405 field M N P h k)) (cleanNotation_module_zero_map_77b77786d34ab8aa0534 field L P)
end ModuleProductOracle

theorem productSequenceChecked : CleanStatements.binary_module_sequence_is_exact := by
 intro K field M N
 letI : Field K := field
 change LinearMap.range (LinearMap.inl K M.carrier N.carrier) =
   LinearMap.ker (LinearMap.snd K M.carrier N.carrier)
 ext x
 rcases x with ⟨x,y⟩
 simp [eq_comm]

theorem projectionOntoChecked : CleanStatements.right_projection_is_onto := by
 intro K field M N y
 exact ⟨(0,y), rfl⟩

theorem signedSquareChecked : CleanStatements.signed_square_composes_to_zero := by
 intro K field L M N P f g h k commutes
 letI : Field K := field
 have hc : h.hom.comp f.hom = k.hom.comp g.hom :=
  congrArg ModuleCat.Hom.hom commutes
 change ModuleCat.ofHom ((h.hom.coprod k.hom).comp (f.hom.prod (-g.hom))) =
  ModuleCat.ofHom (0 : L.carrier →ₗ[K] P.carrier)
 congr 1
 ext x
 have hx := congrArg (fun t : L.carrier →ₗ[K] P.carrier => t x) hc
 change h.hom (f.hom x) + k.hom (-(g.hom x)) = 0
 change h.hom (f.hom x) = k.hom (g.hom x) at hx
 simp [hx]

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
same_basic_target cleanNotation_module_product_2b8332ad177f6804ae52 ModuleProductOracle.product
same_basic_target cleanNotation_left_inclusion_1c1de41245abb50ac7ae ModuleProductOracle.inclusion
same_basic_target cleanNotation_right_projection_f807ba35ded39db28e3c ModuleProductOracle.projection
same_basic_target cleanNotation_pair_module_maps_03ec468cb25325a7fe1c ModuleProductOracle.paired
same_basic_target cleanNotation_merge_module_maps_55f201a50aea52cac405 ModuleProductOracle.merged
same_basic_target cleanNotation_negative_module_map_021d40d10b0a413f0594 ModuleProductOracle.negative
same_basic_target cleanDefine_signed_pair_f1a4fb6858ee12ea1aed ModuleProductOracle.signed
same_basic_target CleanStatements.binary_module_sequence_is_exact ModuleProductOracle.exactStatement
same_basic_target CleanStatements.right_projection_is_onto ModuleProductOracle.ontoStatement
same_basic_target CleanStatements.signed_square_composes_to_zero ModuleProductOracle.cancellation

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
