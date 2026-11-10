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
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.AlgebraicTopology.SingularHomology.Basic
import Mathlib.Algebra.Category.ModuleCat.Abelian
import Mathlib.Algebra.Category.ModuleCat.Colimits
import Mathlib.Topology.Path
import Mathlib.Algebra.Exact
import Mathlib.LinearAlgebra.Prod

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

structure cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) : Type 1 where
  «coefficients» : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»))
  «degree» : (_root_.cleanType_Natural_469c53b6dafb7a218246)

noncomputable def cleanConstructor_homology_theory_1d5d27e4480944537ec9 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («coefficients» : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»))) («degree» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field») :=
  @_root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9.mk «K» «field» «coefficients» «degree»

noncomputable def cleanNotation_homology_module_0623b9da21d8ff427c7d {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X)

noncomputable def cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g))

noncomputable def cleanDefine_induced_homology_value_7aaece293e09f77385ba {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) :=
  (@_root_.cleanNotation_module_map_value_d59145d0b679c3ce3011 (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))) ((@_root_.cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 (K) (field) (H) (X) (Y) (g))) (x))

noncomputable def cleanDefine_induced_homology_map_6a00940d673663e6165b {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))))) :=
  (fun (clean_bound_0 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) => (@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (X) (Y) (g) (clean_bound_0)))

noncomputable def cleanDefine_homology_image_e6a3638ecb5732b0e74f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) :=
  (@_root_.cleanNotation_module_map_range_7b55a8a231e2462f9d90 (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))) ((@_root_.cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 (K) (field) (H) (X) (Y) (g))))

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

noncomputable def cleanNotation_intersection_into_left_c66876d700f8a5074827 {T : Type} (U : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (V : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))) (U))) :=
  Set.inter_subset_left

noncomputable def cleanNotation_intersection_into_right_f0c7be6cefd1946d8f6b {T : Type} (U : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (V : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))) (V))) :=
  Set.inter_subset_right

noncomputable def cleanNotation_left_into_union_804a3fdf0bbbd767e43a {T : Type} (U : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (V : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf (U) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))))) :=
  Set.subset_union_left

noncomputable def cleanNotation_right_into_union_99380c3aa713d6372421 {T : Type} (U : (_root_.cleanType_Set_6e300741358eee425e81 (T))) (V : (_root_.cleanType_Set_6e300741358eee425e81 (T))) : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf (V) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))))) :=
  Set.subset_union_right

noncomputable def cleanDefine_subset_homology_ce79765c76890c414fcc {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (S))))

noncomputable def cleanDefine_inclusion_homology_6b419731a22d45f2c7ed {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (T : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (h : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf (S) (T)))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (S))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (T)))) :=
  (@_root_.cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (S))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (T))) ((@_root_.cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 (X) (S) (T) (h))))

noncomputable def cleanDefine_intersection_homology_map_0a9840e4c4f5fbe8012b {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (V : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))))) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (U))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (V)))))) :=
  (@_root_.cleanDefine_signed_pair_f1a4fb6858ee12ea1aed (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (U))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (V))) ((@_root_.cleanDefine_inclusion_homology_6b419731a22d45f2c7ed (K) (field) (H) (X) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))) (U) ((@_root_.cleanNotation_intersection_into_left_c66876d700f8a5074827 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) (U) (V))))) ((@_root_.cleanDefine_inclusion_homology_6b419731a22d45f2c7ed (K) (field) (H) (X) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))) (V) ((@_root_.cleanNotation_intersection_into_right_f0c7be6cefd1946d8f6b ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) (U) (V))))))

noncomputable def cleanDefine_union_homology_map_b723c8af8d5b258b188f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (U : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (V : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (U))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (V))))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V)))))) :=
  (@_root_.cleanNotation_merge_module_maps_55f201a50aea52cac405 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (U))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (V))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))))) ((@_root_.cleanDefine_inclusion_homology_6b419731a22d45f2c7ed (K) (field) (H) (X) (U) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))) ((@_root_.cleanNotation_left_into_union_804a3fdf0bbbd767e43a ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) (U) (V))))) ((@_root_.cleanDefine_inclusion_homology_6b419731a22d45f2c7ed (K) (field) (H) (X) (V) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))) ((@_root_.cleanNotation_right_into_union_99380c3aa713d6372421 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) (U) (V))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: construction
reference: functoriality and signed cancellation
relationship: original
-/
def intersection_then_union_vanishes : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (U V : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))))) ((@_root_.cleanNotation_module_product_2b8332ad177f6804ae52 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (U))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) (V))))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))))) ((@_root_.cleanDefine_intersection_homology_map_0a9840e4c4f5fbe8012b (K) (field) (H) (X) (U) (V))) ((@_root_.cleanDefine_union_homology_map_b723c8af8d5b258b188f (K) (field) (H) (X) (U) (V))))) ((@_root_.cleanNotation_module_zero_map_77b77786d34ab8aa0534 (K) (field) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_intersection_855b89f2e32edc747a4a (U) (V))))) ((@_root_.cleanDefine_subset_homology_ce79765c76890c414fcc (K) (field) (H) (X) ((_root_.cleanNotation_set_union_415f0bd1477a58bfb237 (U) (V))))))))

end CleanStatements

namespace MayerVietorisMapOracle
def interLeft {T : Type} (U V : cleanType_Set_6e300741358eee425e81 T) : (cleanDefine_set_subset_a67e41d93cfd162885cf (cleanNotation_set_intersection_855b89f2e32edc747a4a U V) U) := Set.inter_subset_left
def interRight {T : Type} (U V : cleanType_Set_6e300741358eee425e81 T) : (cleanDefine_set_subset_a67e41d93cfd162885cf (cleanNotation_set_intersection_855b89f2e32edc747a4a U V) V) := Set.inter_subset_right
def unionLeft {T : Type} (U V : cleanType_Set_6e300741358eee425e81 T) : (cleanDefine_set_subset_a67e41d93cfd162885cf U (cleanNotation_set_union_415f0bd1477a58bfb237 U V)) := Set.subset_union_left
def unionRight {T : Type} (U V : cleanType_Set_6e300741358eee425e81 T) : (cleanDefine_set_subset_a67e41d93cfd162885cf V (cleanNotation_set_union_415f0bd1477a58bfb237 U V)) := Set.subset_union_right
noncomputable def subsetHomology {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (S : cleanType_Set_6e300741358eee425e81 (cleanType_Point_f8a65e23875fb9a2c125 X)) : cleanType_CoefficientModule_79514ce65e42b4219878 K field := cleanNotation_homology_module_0623b9da21d8ff427c7d field H (cleanNotation_subspace_c5a9f0dd775aa465e7fc X S)
noncomputable def inclusionHomology {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (S T : cleanType_Set_6e300741358eee425e81 (cleanType_Point_f8a65e23875fb9a2c125 X)) (h : (cleanDefine_set_subset_a67e41d93cfd162885cf S T)) :
 cleanType_ModuleMap_9bf239ee5af2145b9b57 K field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X S) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X T) :=
 cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 field H (cleanNotation_subspace_c5a9f0dd775aa465e7fc X S) (cleanNotation_subspace_c5a9f0dd775aa465e7fc X T) (cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 X S T h)
noncomputable def alpha {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanType_Set_6e300741358eee425e81 (cleanType_Point_f8a65e23875fb9a2c125 X)) :
 cleanType_ModuleMap_9bf239ee5af2145b9b57 K field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_intersection_855b89f2e32edc747a4a U V)) (cleanNotation_module_product_2b8332ad177f6804ae52 field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X U) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X V)) :=
 cleanDefine_signed_pair_f1a4fb6858ee12ea1aed (cleanDefine_inclusion_homology_6b419731a22d45f2c7ed field H X (cleanNotation_set_intersection_855b89f2e32edc747a4a U V) U (cleanNotation_intersection_into_left_c66876d700f8a5074827 U V)) (cleanDefine_inclusion_homology_6b419731a22d45f2c7ed field H X (cleanNotation_set_intersection_855b89f2e32edc747a4a U V) V (cleanNotation_intersection_into_right_f0c7be6cefd1946d8f6b U V))
noncomputable def beta {K : Type} (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanType_Set_6e300741358eee425e81 (cleanType_Point_f8a65e23875fb9a2c125 X)) :
 cleanType_ModuleMap_9bf239ee5af2145b9b57 K field (cleanNotation_module_product_2b8332ad177f6804ae52 field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X U) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X V)) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_union_415f0bd1477a58bfb237 U V)) :=
 cleanNotation_merge_module_maps_55f201a50aea52cac405 field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X U) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X V) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_union_415f0bd1477a58bfb237 U V))
  (cleanDefine_inclusion_homology_6b419731a22d45f2c7ed field H X U (cleanNotation_set_union_415f0bd1477a58bfb237 U V) (cleanNotation_left_into_union_804a3fdf0bbbd767e43a U V)) (cleanDefine_inclusion_homology_6b419731a22d45f2c7ed field H X V (cleanNotation_set_union_415f0bd1477a58bfb237 U V) (cleanNotation_right_into_union_99380c3aa713d6372421 U V))
def vanishes : Prop := ∀ (K : cleanType_Type_c1fed1af64ab6f12e0ed) (field : cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanType_Set_6e300741358eee425e81 (cleanType_Point_f8a65e23875fb9a2c125 X)),
 cleanDefine_equal_59dc0f11ba9b345348cf (cleanNotation_module_composition_540bbd166f48e5aeba29 field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_intersection_855b89f2e32edc747a4a U V)) (cleanNotation_module_product_2b8332ad177f6804ae52 field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X U) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X V))
  (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_union_415f0bd1477a58bfb237 U V)) (cleanDefine_intersection_homology_map_0a9840e4c4f5fbe8012b field H X U V) (cleanDefine_union_homology_map_b723c8af8d5b258b188f field H X U V))
  (cleanNotation_module_zero_map_77b77786d34ab8aa0534 field (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_intersection_855b89f2e32edc747a4a U V)) (cleanDefine_subset_homology_ce79765c76890c414fcc field H X (cleanNotation_set_union_415f0bd1477a58bfb237 U V)))
end MayerVietorisMapOracle
-- generated: gpt-6 2026-11-10 role=assisted; proof fragment included by verifier

open CategoryTheory

theorem intersectionThenUnionChecked : CleanStatements.intersection_then_union_vanishes := by
 intro K field H X U V
 letI : Field K := field
 letI : TopologicalSpace X.carrier := X.str
 let F := (AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients
 let a : TopCat.of (U ∩ V : Set X.carrier) ⟶ TopCat.of U := TopCat.ofHom (ContinuousMap.inclusion Set.inter_subset_left)
 let b : TopCat.of (U ∩ V : Set X.carrier) ⟶ TopCat.of V := TopCat.ofHom (ContinuousMap.inclusion Set.inter_subset_right)
 let c : TopCat.of U ⟶ TopCat.of (U ∪ V : Set X.carrier) := TopCat.ofHom (ContinuousMap.inclusion Set.subset_union_left)
 let d : TopCat.of V ⟶ TopCat.of (U ∪ V : Set X.carrier) := TopCat.ofHom (ContinuousMap.inclusion Set.subset_union_right)
 have square : F.map a ≫ F.map c = F.map b ≫ F.map d := by
  rw [← F.map_comp, ← F.map_comp]
  rfl
 have hc : (F.map c).hom.comp (F.map a).hom = (F.map d).hom.comp (F.map b).hom :=
  congrArg ModuleCat.Hom.hom square
 change ModuleCat.ofHom (((F.map c).hom.coprod (F.map d).hom).comp
   ((F.map a).hom.prod (-(F.map b).hom))) =
  ModuleCat.ofHom (0 : (F.obj (TopCat.of (U ∩ V : Set X.carrier))).carrier →ₗ[K] (F.obj (TopCat.of (U ∪ V : Set X.carrier))).carrier)
 congr 1
 ext x
 have hx := congrArg (fun t : (F.obj (TopCat.of (U ∩ V : Set X.carrier))).carrier →ₗ[K] (F.obj (TopCat.of (U ∪ V : Set X.carrier))).carrier => t x) hc
 change (F.map c).hom ((F.map a).hom x) + (F.map d).hom (-((F.map b).hom x)) = 0
 change (F.map c).hom ((F.map a).hom x) = (F.map d).hom ((F.map b).hom x) at hx
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
same_basic_target cleanNotation_intersection_into_left_c66876d700f8a5074827 MayerVietorisMapOracle.interLeft
same_basic_target cleanNotation_intersection_into_right_f0c7be6cefd1946d8f6b MayerVietorisMapOracle.interRight
same_basic_target cleanNotation_left_into_union_804a3fdf0bbbd767e43a MayerVietorisMapOracle.unionLeft
same_basic_target cleanNotation_right_into_union_99380c3aa713d6372421 MayerVietorisMapOracle.unionRight
same_basic_target cleanDefine_subset_homology_ce79765c76890c414fcc MayerVietorisMapOracle.subsetHomology
same_basic_target cleanDefine_inclusion_homology_6b419731a22d45f2c7ed MayerVietorisMapOracle.inclusionHomology
same_basic_target cleanDefine_intersection_homology_map_0a9840e4c4f5fbe8012b MayerVietorisMapOracle.alpha
same_basic_target cleanDefine_union_homology_map_b723c8af8d5b258b188f MayerVietorisMapOracle.beta
same_basic_target CleanStatements.intersection_then_union_vanishes MayerVietorisMapOracle.vanishes

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
