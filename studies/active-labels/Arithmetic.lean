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
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.CategoryTheory.EqToHom

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

structure cleanStructure_GradedModule_4e52f71cb062f2010cae («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) : Type 1 where
  «component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))

noncomputable def cleanConstructor_graded_module_f18663848933026544e1 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))) : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field») :=
  @_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.mk «K» «field» «component»

noncomputable def cleanDefine_component_module_62544f8701c4206d87f6 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (p : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  ((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (M)) p)

structure cleanStructure_GradedMap_159685b2cca12f6de0d5 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («M» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) («N» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) : Type where
  «component» : (clean_pi_bound_7 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («M»)) clean_pi_bound_7)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («N»)) clean_pi_bound_7))))

noncomputable def cleanConstructor_graded_map_9a1d6510c736d7d95a0f («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («M» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) («N» : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae («K») («field»)) («component» : (clean_pi_bound_7 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («M»)) clean_pi_bound_7)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» («K») («field») («N»)) clean_pi_bound_7))))) : _root_.cleanStructure_GradedMap_159685b2cca12f6de0d5 («K») («field») («M») («N») :=
  @_root_.cleanStructure_GradedMap_159685b2cca12f6de0d5.mk «K» «field» «M» «N» «component»

noncomputable def cleanNotation_module_identity_db2143c0391459c1a649 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (M)) :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M

noncomputable def cleanNotation_module_composition_540bbd166f48e5aeba29 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (P : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) (g : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (N) (P))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (P)) :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g

noncomputable def cleanDefine_graded_identity_ffdb0bd017d9839c18b6 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) : _root_.cleanStructure_GradedMap_159685b2cca12f6de0d5 (K) (field) (M) (M) :=
  (@_root_.cleanConstructor_graded_map_9a1d6510c736d7d95a0f (K) (field) (M) (M) ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_identity_db2143c0391459c1a649 (K) (field) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (M)) clean_bound_0))))))

noncomputable def cleanDefine_graded_composition_4957dbd08895b550611e {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (N : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (P : _root_.cleanStructure_GradedModule_4e52f71cb062f2010cae (K) (field)) (f : _root_.cleanStructure_GradedMap_159685b2cca12f6de0d5 (K) (field) (M) (N)) (g : _root_.cleanStructure_GradedMap_159685b2cca12f6de0d5 (K) (field) (N) (P)) : _root_.cleanStructure_GradedMap_159685b2cca12f6de0d5 (K) (field) (M) (P) :=
  (@_root_.cleanConstructor_graded_map_9a1d6510c736d7d95a0f (K) (field) (M) (P) ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (M)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (N)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_4e52f71cb062f2010cae.«component» (K) (field) (P)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_159685b2cca12f6de0d5.«component» (K) (field) (M) (N) (f)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_159685b2cca12f6de0d5.«component» (K) (field) (N) (P) (g)) clean_bound_0))))))

structure cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V» : Type) («E» : Type) : Type where
  «source» : («E») → («V»)
  «target» : («E») → («V»)

noncomputable def cleanConstructor_diagram_shape_dc77cc33f7da32166efd («V» : Type) («E» : Type) («source» : («E») → («V»)) («target» : («E») → («V»)) : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E») :=
  @_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.mk «V» «E» «source» «target»

noncomputable def cleanDefine_shape_e42799d4f722454e21fb {V : Type} {E : Type} (source : (E) → (V)) (target : (E) → (V)) : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E) :=
  (@_root_.cleanConstructor_diagram_shape_dc77cc33f7da32166efd (V) (E) (source) (target))

structure cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («V» : Type) («E» : Type) («Q» : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) : Type 1 where
  «object» : («V») → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))
  «arrow» : (clean_pi_bound_8 : «E») → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») ((«object» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_8))) ((«object» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_8)))))

noncomputable def cleanConstructor_module_diagram_608e8f78a95afa7a8cbf («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («V» : Type) («E» : Type) («Q» : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («object» : («V») → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»)))) («arrow» : (clean_pi_bound_8 : «E») → ((_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 («K») («field») ((«object» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_8))) ((«object» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_8)))))) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 («K») («field») («V») («E») («Q») :=
  @_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.mk «K» «field» «V» «E» «Q» «object» «arrow»

noncomputable def cleanDefine_constant_module_diagram_79a8b6190335e3cf899b  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (E : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (V) (E) (Q) :=
  (@_root_.cleanConstructor_module_diagram_608e8f78a95afa7a8cbf (K) (field) (V) (E) (Q) ((fun (clean_bound_0 : V) => M)) ((fun (clean_bound_1 : E) => (@_root_.cleanNotation_module_identity_db2143c0391459c1a649 (K) (field) (M)))))

noncomputable def cleanDefine_constant_diagram_33e49fb03ba8136e7cd4 {K : Type} {V : Type} {E : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (V) (E) (Q) :=
  (@_root_.cleanDefine_constant_module_diagram_79a8b6190335e3cf899b (K) (field) (V) (E) (Q) (M))

noncomputable abbrev cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_9ca9e49e1312ca23ac23   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_false_value_30a63b75654d87153a83   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_select_value_8c16df42e9e7cba05d1f {T : Type} (b : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) (x : T) (y : T) : T :=
  if b then x else y

noncomputable def cleanNotation_left_vertex_8f64bd02065ab4ff3d27  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (e : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  e.castSucc

noncomputable def cleanNotation_right_vertex_512aa6049ae94fba97e2  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (e : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  e.succ

noncomputable def cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  v.val

noncomputable def cleanDefine_vertex_at_most_ce50dc9de832f83e617b {n : (_root_.cleanType_Natural_469c53b6dafb7a218246)} (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b (n) (u))) ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b (n) (v))))

noncomputable def cleanDefine_zigzag_shape_10fc3c74691b179d3e85  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) :=
  (_root_.cleanDefine_shape_e42799d4f722454e21fb ((fun (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) => (_root_.cleanNotation_select_value_8c16df42e9e7cba05d1f ((d clean_bound_0)) ((@_root_.cleanNotation_left_vertex_8f64bd02065ab4ff3d27 (n) (clean_bound_0))) ((@_root_.cleanNotation_right_vertex_512aa6049ae94fba97e2 (n) (clean_bound_0)))))) ((fun (clean_bound_1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) => (_root_.cleanNotation_select_value_8c16df42e9e7cba05d1f ((d clean_bound_1)) ((@_root_.cleanNotation_right_vertex_512aa6049ae94fba97e2 (n) (clean_bound_1))) ((@_root_.cleanNotation_left_vertex_8f64bd02065ab4ff3d27 (n) (clean_bound_1)))))))

noncomputable def cleanDefine_constant_zigzag_22e942684302b0a22068  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) :=
  (@_root_.cleanDefine_constant_diagram_33e49fb03ba8136e7cd4 (K) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (field) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (M))

noncomputable abbrev cleanType_ModuleBasis_7524a1057a877c7c5c10 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (I : Type) : Type :=
  @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule

noncomputable def cleanNotation_module_basis_vector_84f953c139a3d8bfc843 {K : Type} {I : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (b : (_root_.cleanType_ModuleBasis_7524a1057a877c7c5c10 (K) (field) (M) (I))) (i : I) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M)) :=
  (letI : Field K := field; b i)

noncomputable def cleanNotation_module_zero_131bde21da964dfec744 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M)) :=
  @Zero.zero M.carrier M.isAddCommGroup.toZero

noncomputable def cleanNotation_selected_value_435b2b78382c9a6099ad {I : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (I))) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) (S))) : I :=
  x.val

noncomputable def cleanDefine_ordered_interval_endpoints_3afa3cf4955e52c92b45  (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (lower : (I) → ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))) (upper : (I) → ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : I), (@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((lower clean_bound_0)) ((upper clean_bound_0))))

structure cleanStructure_IntervalLabels_35662c656c342ceedc0b («I» : Type) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «lower» : («I») → ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))
  «upper» : («I») → ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))
  «ordered» : ((@_root_.cleanDefine_ordered_interval_endpoints_3afa3cf4955e52c92b45 («I») («n») («lower») («upper»)))

noncomputable def cleanConstructor_interval_labels_46759148255508651561 («I» : Type) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («lower» : («I») → ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))) («upper» : («I») → ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))) («ordered» : ((@_root_.cleanDefine_ordered_interval_endpoints_3afa3cf4955e52c92b45 («I») («n») («lower») («upper»)))) : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b («I») («n») :=
  @_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.mk «I» «n» «lower» «upper» «ordered»

noncomputable def cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53  (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) : (_root_.cleanType_Set_6e300741358eee425e81 (I)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : I) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«lower» (I) (n) (L)) clean_bound_0)) (v))) ((@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«upper» (I) (n) (L)) clean_bound_0))))))))

noncomputable def cleanDefine_zigzag_source_9a6091367cd8af6a0525  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (e : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) e)

noncomputable def cleanDefine_zigzag_target_d0149f363d662b157266  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (e : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) e)

noncomputable def cleanDefine_interval_vectors_realize_bases_2ab78b931971302bd1c0  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (Z : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) (vectors : (clean_pi_bound_9 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((I) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_pi_bound_9)))))) (basis : (clean_pi_bound_10 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((_root_.cleanType_ModuleBasis_7524a1057a877c7c5c10 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_pi_bound_10)) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 (I) (n) (L) (clean_pi_bound_10)))))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))), (∀ (clean_bound_1 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 (I) (n) (L) (clean_bound_0))))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_basis_vector_84f953c139a3d8bfc843 (K) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 (I) (n) (L) (clean_bound_0))))) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_bound_0)) ((basis clean_bound_0)) (clean_bound_1))) ((_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors clean_bound_0)) ((@_root_.cleanNotation_selected_value_435b2b78382c9a6099ad (I) ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 (I) (n) (L) (clean_bound_0))) (clean_bound_1))))))))

noncomputable def cleanDefine_interval_vectors_vanish_1201f412c4149a4fa3c7  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (Z : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) (vectors : (clean_pi_bound_11 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((I) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_pi_bound_11)))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))), (∀ (clean_bound_1 : I), (_root_.cleanDefine_implication_3b80760984def210df07 ((_root_.cleanDefine_negation_7efde94db326666449aa ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (clean_bound_1) ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 (I) (n) (L) (clean_bound_0))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors clean_bound_0)) (clean_bound_1))) ((@_root_.cleanNotation_module_zero_131bde21da964dfec744 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_bound_0)))))))))

noncomputable def cleanDefine_interval_vectors_compatible_1b7f8ad449062d660eb4  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (Z : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) (vectors : (clean_pi_bound_12 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((I) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_pi_bound_12)))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))), (∀ (clean_bound_1 : I), (_root_.cleanDefine_implication_3b80760984def210df07 ((_root_.cleanDefine_set_member_d7f862196f8cd9ab892e (clean_bound_1) ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 (I) (n) (L) ((@_root_.cleanDefine_zigzag_source_9a6091367cd8af6a0525 (n) (d) (clean_bound_0))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_module_map_value_d59145d0b679c3ce3011 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) (@_root_.cleanDefine_zigzag_source_9a6091367cd8af6a0525 (n) (d) (clean_bound_0)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) (@_root_.cleanDefine_zigzag_target_d0149f363d662b157266 (n) (d) (clean_bound_0)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«arrow» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) clean_bound_0)) ((_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors (@_root_.cleanDefine_zigzag_source_9a6091367cd8af6a0525 (n) (d) (clean_bound_0)))) (clean_bound_1))))) ((_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors (@_root_.cleanDefine_zigzag_target_d0149f363d662b157266 (n) (d) (clean_bound_0)))) (clean_bound_1))))))))

structure cleanStructure_IntervalBasis_2fa80b8f69d6c434ea4f («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («d» : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) («Z» : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 («K») («field») ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 («n») («d»)))) («I» : Type) («L» : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b («I») («n»)) : Type where
  «vectors» : (clean_pi_bound_13 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((«I») → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af («K») («field») (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» («K») («field») ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 («n») («d»))) («Z»)) clean_pi_bound_13)))))
  «basis» : (clean_pi_bound_14 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((_root_.cleanType_ModuleBasis_7524a1057a877c7c5c10 («K») («field») (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» («K») («field») ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 («n») («d»))) («Z»)) clean_pi_bound_14)) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («I») ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 («I») («n») («L») (clean_pi_bound_14)))))))
  «realizes» : ((@_root_.cleanDefine_interval_vectors_realize_bases_2ab78b931971302bd1c0 («K») («field») («n») («d») («Z») («I») («L») («vectors») («basis»)))
  «vanishes» : ((@_root_.cleanDefine_interval_vectors_vanish_1201f412c4149a4fa3c7 («K») («field») («n») («d») («Z») («I») («L») («vectors»)))
  «compatible» : ((@_root_.cleanDefine_interval_vectors_compatible_1b7f8ad449062d660eb4 («K») («field») («n») («d») («Z») («I») («L») («vectors»)))

noncomputable def cleanConstructor_interval_basis_c4b706fc306b9026aa06 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («d» : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) («Z» : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 («K») («field») ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 («n») («d»)))) («I» : Type) («L» : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b («I») («n»)) («vectors» : (clean_pi_bound_13 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((«I») → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af («K») («field») (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» («K») («field») ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 («n») («d»))) («Z»)) clean_pi_bound_13)))))) («basis» : (clean_pi_bound_14 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) → ((_root_.cleanType_ModuleBasis_7524a1057a877c7c5c10 («K») («field») (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» («K») («field») ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 («n»))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 («n») («d»))) («Z»)) clean_pi_bound_14)) ((_root_.cleanType_Element_4fb2f1b669ed36f80886 («I») ((@_root_.cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 («I») («n») («L») (clean_pi_bound_14)))))))) («realizes» : ((@_root_.cleanDefine_interval_vectors_realize_bases_2ab78b931971302bd1c0 («K») («field») («n») («d») («Z») («I») («L») («vectors») («basis»)))) («vanishes» : ((@_root_.cleanDefine_interval_vectors_vanish_1201f412c4149a4fa3c7 («K») («field») («n») («d») («Z») («I») («L») («vectors»)))) («compatible» : ((@_root_.cleanDefine_interval_vectors_compatible_1b7f8ad449062d660eb4 («K») («field») («n») («d») («Z») («I») («L») («vectors»)))) : _root_.cleanStructure_IntervalBasis_2fa80b8f69d6c434ea4f («K») («field») («n») («d») («Z») («I») («L») :=
  @_root_.cleanStructure_IntervalBasis_2fa80b8f69d6c434ea4f.mk «K» «field» «n» «d» «Z» «I» «L» «vectors» «basis» «realizes» «vanishes» «compatible»

noncomputable def cleanDefine_interval_basis_vector_941474742fabbaadb31d {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (Z : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) (B : _root_.cleanStructure_IntervalBasis_2fa80b8f69d6c434ea4f (K) (field) (n) (d) (Z) (I) (L)) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) (i : I) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) (Z)) v))) :=
  (_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 (((@_root_.cleanStructure_IntervalBasis_2fa80b8f69d6c434ea4f.«vectors» (K) (field) (n) (d) (Z) (I) (L) (B)) v)) (i))

noncomputable def cleanNotation_equality_symmetry_3deae82ec4ecf3b0d30a {T : Type} (x : T) (y : T) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (y)))) : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (y) (x))) :=
  Eq.symm h

noncomputable def cleanNotation_equality_transitivity_5184b0586a93d7938524 {T : Type} (x : T) (y : T) (z : T) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (y)))) (k : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (y) (z)))) : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (z))) :=
  Eq.trans h k

structure cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 («V» : Type) («E» : Type) («W» : Type) («F» : Type) («Q» : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («R» : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («W») («F»)) : Type where
  «vertices» : («V») → («W»)
  «edges» : («E») → («F»)
  «sources» : (clean_pi_bound_15 : «E») → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((«vertices» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_15))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («W») («F») («R»)) («edges» clean_pi_bound_15))))))
  «targets» : (clean_pi_bound_16 : «E») → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((«vertices» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_16))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («W») («F») («R»)) («edges» clean_pi_bound_16))))))

noncomputable def cleanConstructor_shape_map_2472e91326009a6291c1 («V» : Type) («E» : Type) («W» : Type) («F» : Type) («Q» : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («R» : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c («W») («F»)) («vertices» : («V») → («W»)) («edges» : («E») → («F»)) («sources» : (clean_pi_bound_15 : «E») → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((«vertices» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_15))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («W») («F») («R»)) («edges» clean_pi_bound_15))))))) («targets» : (clean_pi_bound_16 : «E») → (((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((«vertices» ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_16))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («W») («F») («R»)) («edges» clean_pi_bound_16))))))) : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 («V») («E») («W») («F») («Q») («R») :=
  @_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.mk «V» «E» «W» «F» «Q» «R» «vertices» «edges» «sources» «targets»

noncomputable def cleanDefine_identity_shape_map_434f5522b34b59405af2  (V : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (E : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (V) (E) (Q) (Q) :=
  (@_root_.cleanConstructor_shape_map_2472e91326009a6291c1 (V) (E) (V) (E) (Q) (Q) ((fun (clean_bound_0 : V) => clean_bound_0)) ((fun (clean_bound_1 : E) => clean_bound_1)) ((fun (clean_bound_2 : E) => (@_root_.cleanNotation_equality_reflexivity_4da391a0ed75b016f3b7 (V) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2))))) ((fun (clean_bound_3 : E) => (@_root_.cleanNotation_equality_reflexivity_4da391a0ed75b016f3b7 (V) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3))))))

noncomputable def cleanDefine_composite_shape_map_e4931c1245d73d0bd24c  (V : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (E : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (W : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (F : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (U : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (J : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (S : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)) (f : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (W) (F) (Q) (R)) (g : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (W) (F) (U) (J) (R) (S)) : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (U) (J) (Q) (S) :=
  (@_root_.cleanConstructor_shape_map_2472e91326009a6291c1 (V) (E) (U) (J) (Q) (S) ((fun (clean_bound_0 : V) => ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_0)))) ((fun (clean_bound_1 : E) => ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) ((fun (clean_bound_2 : E) => (@_root_.cleanNotation_equality_transitivity_5184b0586a93d7938524 (U) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2)))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (U) (J) (S)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) ((@_root_.cleanNotation_equality_congruence_174db20655aa25697786 (W) (U) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«sources» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«sources» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))))) ((fun (clean_bound_3 : E) => (@_root_.cleanNotation_equality_transitivity_5184b0586a93d7938524 (U) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3)))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (U) (J) (S)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) ((@_root_.cleanNotation_equality_congruence_174db20655aa25697786 (W) (U) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (W) (F) (U) (J) (R) (S) (g))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«targets» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«targets» (W) (F) (U) (J) (R) (S) (g)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))))))

noncomputable def cleanDefine_shape_identity_c29ef79dea2a4994e7b2 {V : Type} {E : Type} (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (V) (E) (Q) (Q) :=
  (@_root_.cleanDefine_identity_shape_map_434f5522b34b59405af2 (V) (E) (Q))

noncomputable def cleanDefine_compose_shapes_b13826fdb8ed7c0c364d {V : Type} {E : Type} {W : Type} {F : Type} {U : Type} {J : Type} (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (S : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)) (f : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (W) (F) (Q) (R)) (g : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (W) (F) (U) (J) (R) (S)) : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (U) (J) (Q) (S) :=
  (@_root_.cleanDefine_composite_shape_map_e4931c1245d73d0bd24c (V) (E) (W) (F) (U) (J) (Q) (R) (S) (f) (g))

noncomputable def cleanNotation_module_family_transport_a468873d1626e7059f08 {K : Type} {T : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (T) → ((_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)))) (x : T) (y : T) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (y)))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((M x)) ((M y))) :=
  @CategoryTheory.eqToHom (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct (M x) (M y) (congrArg M h)

noncomputable def cleanDefine_diagram_pullback_2057c383626a350b8f92  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (E : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (W : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (F : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (W) (F) (Q) (R)) (M : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (W) (F) (R)) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (V) (E) (Q) :=
  (@_root_.cleanConstructor_module_diagram_608e8f78a95afa7a8cbf (K) (field) (V) (E) (Q) ((fun (clean_bound_0 : V) => ((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_0)))) ((fun (clean_bound_1 : E) => (@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1)))) ((@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) ((@_root_.cleanNotation_module_family_transport_a468873d1626e7059f08 (K) (W) (field) ((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«sources» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«arrow» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))))) ((@_root_.cleanNotation_module_family_transport_a468873d1626e7059f08 (K) (W) (field) ((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1))) ((@_root_.cleanNotation_equality_symmetry_3deae82ec4ecf3b0d30a (W) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«targets» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))))))))))

noncomputable def cleanDefine_pull_back_diagram_fc933dd06c915e1843e6 {K : Type} {V : Type} {E : Type} {W : Type} {F : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (W) (F) (Q) (R)) (M : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (W) (F) (R)) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (V) (E) (Q) :=
  (@_root_.cleanDefine_diagram_pullback_2057c383626a350b8f92 (K) (field) (V) (E) (W) (F) (Q) (R) (f) (M))

noncomputable def cleanDefine_pull_back_arrow_99e8aa72be3b7b9b69b8 {K : Type} {V : Type} {E : Type} {W : Type} {F : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (Q : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : _root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 (V) (E) (W) (F) (Q) (R)) (M : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) (W) (F) (R)) (e : E) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e))))) :=
  (@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e)))) ((@_root_.cleanNotation_module_composition_540bbd166f48e5aeba29 (K) (field) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))) ((@_root_.cleanNotation_module_family_transport_a468873d1626e7059f08 (K) (W) (field) ((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«sources» (V) (E) (W) (F) (Q) (R) (f)) e)))) (((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«arrow» (K) (field) (W) (F) (R) (M)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))))) ((@_root_.cleanNotation_module_family_transport_a468873d1626e7059f08 (K) (W) (field) ((@_root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81.«object» (K) (field) (W) (F) (R) (M))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e))) ((@_root_.cleanNotation_equality_symmetry_3deae82ec4ecf3b0d30a (W) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))) (((@_root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5.«targets» (V) (E) (W) (F) (Q) (R) (f)) e)))))))

noncomputable def cleanNotation_offset_vertex_a9a77e46ff8aec8df231  (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m)))) :=
  Fin.natAdd a v

noncomputable def cleanNotation_widen_vertex_bebebc7e8408efb3d05a  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (m) (n)))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n)) :=
  Fin.castLE h v

noncomputable def cleanNotation_transport_vertex_b2b3660865bf501efafb  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (n) (m)))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m)) :=
  Fin.cast h v

noncomputable def cleanNotation_natural_sum_association_0181957d0c5dd9de41b1  (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (b : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (c : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (b))) (c))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (b) (c))))))) :=
  Nat.add_assoc a b c

noncomputable def cleanNotation_advance_bound_44ec419b1255ab944db9  (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (b : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (c : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (a) (b)))) : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (c))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (b) (c))))) :=
  Nat.add_le_add_right h c

noncomputable def cleanDefine_subpath_edge_aa1fb7a8949bc3480a21  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (e : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n)) :=
  (@_root_.cleanNotation_widen_vertex_bebebc7e8408efb3d05a (n) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (h) ((@_root_.cleanNotation_offset_vertex_a9a77e46ff8aec8df231 (a) (m) (e))))

noncomputable def cleanDefine_subpath_vertex_e406c0e2bda20c5fe110  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  (@_root_.cleanNotation_widen_vertex_bebebc7e8408efb3d05a ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((@_root_.cleanNotation_advance_bound_44ec419b1255ab944db9 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) (h))) ((@_root_.cleanNotation_transport_vertex_b2b3660865bf501efafb ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((@_root_.cleanNotation_equality_symmetry_3deae82ec4ecf3b0d30a ((_root_.cleanType_Natural_469c53b6dafb7a218246)) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((@_root_.cleanNotation_natural_sum_association_0181957d0c5dd9de41b1 (a) (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((@_root_.cleanNotation_offset_vertex_a9a77e46ff8aec8df231 (a) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))))))

noncomputable def cleanDefine_subpath_directions_c38839054421d34a933d  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) :=
  (fun (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) => (d (@_root_.cleanDefine_subpath_edge_aa1fb7a8949bc3480a21 (n) (a) (m) (h) (clean_bound_0))))

noncomputable def cleanDefine_subpath_sources_preserved_c5258792bb66e80eebfb  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_subpath_vertex_e406c0e2bda20c5fe110 (n) (a) (m) (h) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (m) ((@_root_.cleanDefine_subpath_directions_c38839054421d34a933d (n) (a) (m) (h) (d)))))) clean_bound_0)))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) (@_root_.cleanDefine_subpath_edge_aa1fb7a8949bc3480a21 (n) (a) (m) (h) (clean_bound_0))))))

noncomputable def cleanDefine_subpath_targets_preserved_8ed2ba54229343ab1141  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_subpath_vertex_e406c0e2bda20c5fe110 (n) (a) (m) (h) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (m) ((@_root_.cleanDefine_subpath_directions_c38839054421d34a933d (n) (a) (m) (h) (d)))))) clean_bound_0)))) (((@_root_.cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) (@_root_.cleanDefine_subpath_edge_aa1fb7a8949bc3480a21 (n) (a) (m) (h) (clean_bound_0))))))

noncomputable def cleanDefine_subpath_shape_map_5cfd52c7bcc9069f2a6e  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (hs : ((@_root_.cleanDefine_subpath_sources_preserved_c5258792bb66e80eebfb (n) (a) (m) (h) (d)))) (ht : ((@_root_.cleanDefine_subpath_targets_preserved_8ed2ba54229343ab1141 (n) (a) (m) (h) (d)))) : _root_.cleanStructure_DiagramShapeMap_ce819fccb115c3ede2d5 ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (m) ((@_root_.cleanDefine_subpath_directions_c38839054421d34a933d (n) (a) (m) (h) (d))))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) :=
  (@_root_.cleanConstructor_shape_map_2472e91326009a6291c1 ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (m) ((@_root_.cleanDefine_subpath_directions_c38839054421d34a933d (n) (a) (m) (h) (d))))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) ((fun (clean_bound_0 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) => (@_root_.cleanDefine_subpath_vertex_e406c0e2bda20c5fe110 (n) (a) (m) (h) (clean_bound_0)))) ((fun (clean_bound_1 : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) => (@_root_.cleanDefine_subpath_edge_aa1fb7a8949bc3480a21 (n) (a) (m) (h) (clean_bound_1)))) (hs) (ht))

noncomputable def cleanDefine_restricted_zigzag_23c95815d95750c7c4fd {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))) (n)))) (d : ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) → ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e))) (hs : ((@_root_.cleanDefine_subpath_sources_preserved_c5258792bb66e80eebfb (n) (a) (m) (h) (d)))) (ht : ((@_root_.cleanDefine_subpath_targets_preserved_8ed2ba54229343ab1141 (n) (a) (m) (h) (d)))) (Z : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d)))) : _root_.cleanStructure_ModuleDiagram_e3bb7c558fc754d6af81 (K) (field) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (m) ((@_root_.cleanDefine_subpath_directions_c38839054421d34a933d (n) (a) (m) (h) (d))))) :=
  (@_root_.cleanDefine_pull_back_diagram_fc933dd06c915e1843e6 (K) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (m))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (field) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (m) ((@_root_.cleanDefine_subpath_directions_c38839054421d34a933d (n) (a) (m) (h) (d))))) ((@_root_.cleanDefine_zigzag_shape_10fc3c74691b179d3e85 (n) (d))) ((@_root_.cleanDefine_subpath_shape_map_5cfd52c7bcc9069f2a6e (n) (a) (m) (h) (d) (hs) (ht))) (Z))

noncomputable def cleanNotation_natural_minimum_cde53e7621fcd34d67f8  (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (b : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  min a b

noncomputable def cleanNotation_minimum_left_bound_696fb2ae01511fa1d035  (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (b : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_minimum_cde53e7621fcd34d67f8 (a) (b))) (a))) :=
  Nat.min_le_left a b

noncomputable def cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (k : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (k) (n)))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  Fin.mk k (Nat.lt_succ_of_le h)

noncomputable def cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) :=
  (@_root_.cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7 (m) ((_root_.cleanNotation_natural_minimum_cde53e7621fcd34d67f8 (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))) (a))))) ((@_root_.cleanNotation_minimum_left_bound_696fb2ae01511fa1d035 (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))) (a))))))

noncomputable def cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0  (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) : (_root_.cleanType_Set_6e300741358eee425e81 (I)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : I) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«lower» (I) (n) (L)) clean_bound_0)))) ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (a) (m))))) ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (a) ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«upper» (I) (n) (L)) clean_bound_0))))))))))

noncomputable def cleanNotation_vertex_order_numbers_2234df6a1c772269348b  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 (n))) (h : ((@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b (n) (u) (v)))) : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b (n) (u))) ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b (n) (v))))) :=
  h

noncomputable def cleanNotation_subtraction_preserves_order_206936f41ba2f776349d  (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (u : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (v : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (u) (v)))) : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 (u) (a))) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 (v) (a))))) :=
  Nat.sub_le_sub_right h a

noncomputable def cleanNotation_minimum_preserves_order_9656be62122a0b45132e  (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (u : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (v : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (u) (v)))) : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 ((_root_.cleanNotation_natural_minimum_cde53e7621fcd34d67f8 (m) (u))) ((_root_.cleanNotation_natural_minimum_cde53e7621fcd34d67f8 (m) (v))))) :=
  min_le_min_left m h

noncomputable def cleanNotation_bounded_vertices_ordered_1e60d036b0d7671d12e3  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (k : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (l : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (hk : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (k) (n)))) (hl : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (l) (n)))) (h : ((_root_.cleanDefine_natural_at_most_0a7e9519b4591123e4b5 (k) (l)))) : ((@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((@_root_.cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7 (n) (k) (hk))) ((@_root_.cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7 (n) (l) (hl))))) :=
  h

noncomputable def cleanDefine_clipped_vertices_ordered_d931b14887e83a957d27  (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (u : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) (v : (_root_.cleanType_Vertex_460956e39f5b9ffca091 ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) (h : ((@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (u) (v)))) : ((@_root_.cleanDefine_vertex_at_most_ce50dc9de832f83e617b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (m) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((@_root_.cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734 (n) (a) (m) (u))) ((@_root_.cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734 (n) (a) (m) (v))))) :=
  (@_root_.cleanNotation_bounded_vertices_ordered_1e60d036b0d7671d12e3 (m) ((_root_.cleanNotation_natural_minimum_cde53e7621fcd34d67f8 (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (u))) (a))))) ((_root_.cleanNotation_natural_minimum_cde53e7621fcd34d67f8 (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))) (a))))) ((@_root_.cleanNotation_minimum_left_bound_696fb2ae01511fa1d035 (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (u))) (a))))) ((@_root_.cleanNotation_minimum_left_bound_696fb2ae01511fa1d035 (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))) (a))))) ((@_root_.cleanNotation_minimum_preserves_order_9656be62122a0b45132e (m) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (u))) (a))) ((_root_.cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2 ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))) (a))) ((@_root_.cleanNotation_subtraction_preserves_order_206936f41ba2f776349d (a) ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (u))) ((@_root_.cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (v))) ((@_root_.cleanNotation_vertex_order_numbers_2234df6a1c772269348b ((_root_.cleanNotation_natural_sum_884ddbcff666dc390f99 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) (u) (v) (h))))))))

noncomputable def cleanDefine_restricted_interval_labels_f8d969d03eb3434b6f57  (I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (a : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (m : (_root_.cleanType_Natural_469c53b6dafb7a218246)) (L : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b (I) (n)) : _root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))))) (m) :=
  (@_root_.cleanConstructor_interval_labels_46759148255508651561 ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))))) (m) ((fun (clean_bound_0 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))))) => (@_root_.cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734 (n) (a) (m) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«lower» (I) (n) (L)) (@_root_.cleanNotation_selected_value_435b2b78382c9a6099ad (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))) (clean_bound_0))))))) ((fun (clean_bound_1 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))))) => (@_root_.cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734 (n) (a) (m) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«upper» (I) (n) (L)) (@_root_.cleanNotation_selected_value_435b2b78382c9a6099ad (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))) (clean_bound_1))))))) ((fun (clean_bound_2 : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))))) => (@_root_.cleanDefine_clipped_vertices_ordered_d931b14887e83a957d27 (n) (a) (m) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«lower» (I) (n) (L)) (@_root_.cleanNotation_selected_value_435b2b78382c9a6099ad (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))) (clean_bound_2)))) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«upper» (I) (n) (L)) (@_root_.cleanNotation_selected_value_435b2b78382c9a6099ad (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))) (clean_bound_2)))) (((@_root_.cleanStructure_IntervalLabels_35662c656c342ceedc0b.«ordered» (I) (n) (L)) (@_root_.cleanNotation_selected_value_435b2b78382c9a6099ad (I) ((@_root_.cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 (I) (n) (a) (m) (L))) (clean_bound_2))))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

end CleanStatements

namespace Arithmetic
noncomputable def old (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : cleanStructure_IntervalLabels_35662c656c342ceedc0b I n) (v : Fin (m+1)) : Set I :=
 cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 I n L (cleanDefine_subpath_vertex_e406c0e2bda20c5fe110 n a m h v)
noncomputable def new (I : Type) (n a m : ℕ) (L : cleanStructure_IntervalLabels_35662c656c342ceedc0b I n) (v : Fin (m+1)) : Set {i : I // i ∈ cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L} :=
 cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53 {i : I // i ∈ cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L} m (cleanDefine_restricted_interval_labels_f8d969d03eb3434b6f57 I n a m L) v
def existsStatement : Prop := ∀ (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : cleanStructure_IntervalLabels_35662c656c342ceedc0b I n) (v : Fin (m+1)),
 ∃ e : {i : I // i ∈ Arithmetic.old I n a m h L v} ≃ {j : {i : I // i ∈ cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L} // j ∈ Arithmetic.new I n a m L v},
 ∀ x : {i : I // i ∈ Arithmetic.old I n a m h L v},
 cleanNotation_element_value_91379654a1b03d81fbbb (cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L) (cleanNotation_element_value_91379654a1b03d81fbbb (Arithmetic.new I n a m L v) (cleanNotation_equivalence_forward_1b2127e81d5ae7f2a4b5 e x)) = cleanNotation_element_value_91379654a1b03d81fbbb (Arithmetic.old I n a m h L v) x
-- generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
-- The vertex bound is derived, not assumed. change checks each natural goal definitionally.
private theorem support_exists (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : cleanStructure_IntervalLabels_35662c656c342ceedc0b I n) (v : Fin (m+1)) :
 Nonempty (cleanStructure_SubtypeRestrictionSupport_abc8985f61c99531a9ce I (cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L) (Arithmetic.old I n a m h L v) (Arithmetic.new I n a m L v)) := by
 let survives : ∀ x : {i : I // i ∈ Arithmetic.old I n a m h L v}, cleanNotation_element_value_91379654a1b03d81fbbb (Arithmetic.old I n a m h L v) x ∈ cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L := by
   intro x
   have hx := x.property
   simp only [Arithmetic.old, Arithmetic.new, cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0, cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53, cleanNotation_set_of_2c71fd475f49a65bd03e, cleanDefine_restricted_interval_labels_f8d969d03eb3434b6f57, cleanConstructor_interval_labels_46759148255508651561, cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734, cleanNotation_natural_minimum_cde53e7621fcd34d67f8, cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7, cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b, cleanDefine_subpath_vertex_e406c0e2bda20c5fe110, cleanNotation_offset_vertex_a9a77e46ff8aec8df231, cleanNotation_widen_vertex_bebebc7e8408efb3d05a, cleanNotation_transport_vertex_b2b3660865bf501efafb, cleanNotation_selected_value_435b2b78382c9a6099ad, cleanNotation_element_value_91379654a1b03d81fbbb, cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1, cleanDefine_set_member_d7f862196f8cd9ab892e, cleanDefine_conjunction_41680d3b84ab96b0cab9, cleanNotation_natural_sum_884ddbcff666dc390f99, cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2, cleanDefine_natural_at_most_0a7e9519b4591123e4b5, cleanDefine_vertex_at_most_ce50dc9de832f83e617b, cleanNumeral_Natural_47460cb427d00c0cfbad, Set.mem_setOf_eq, Fin.le_iff_val_le_val] at *
   try simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
   change (L.lower x.val).val ≤ a + v.val ∧ a + v.val ≤ (L.upper x.val).val at hx
   change (L.lower x.val).val ≤ a + m ∧ a ≤ (L.upper x.val).val
   have hv : v.val ≤ m := Nat.le_of_lt_succ v.isLt
   omega
 let active : ∀ x : {i : I // i ∈ Arithmetic.old I n a m h L v},
     cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1 (cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L) (cleanNotation_element_value_91379654a1b03d81fbbb (Arithmetic.old I n a m h L v) x) (survives x) ∈ Arithmetic.new I n a m L v := by
   intro x
   have hx := x.property
   simp only [Arithmetic.old, Arithmetic.new, cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0, cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53, cleanNotation_set_of_2c71fd475f49a65bd03e, cleanDefine_restricted_interval_labels_f8d969d03eb3434b6f57, cleanConstructor_interval_labels_46759148255508651561, cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734, cleanNotation_natural_minimum_cde53e7621fcd34d67f8, cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7, cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b, cleanDefine_subpath_vertex_e406c0e2bda20c5fe110, cleanNotation_offset_vertex_a9a77e46ff8aec8df231, cleanNotation_widen_vertex_bebebc7e8408efb3d05a, cleanNotation_transport_vertex_b2b3660865bf501efafb, cleanNotation_selected_value_435b2b78382c9a6099ad, cleanNotation_element_value_91379654a1b03d81fbbb, cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1, cleanDefine_set_member_d7f862196f8cd9ab892e, cleanDefine_conjunction_41680d3b84ab96b0cab9, cleanNotation_natural_sum_884ddbcff666dc390f99, cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2, cleanDefine_natural_at_most_0a7e9519b4591123e4b5, cleanDefine_vertex_at_most_ce50dc9de832f83e617b, cleanNumeral_Natural_47460cb427d00c0cfbad, Set.mem_setOf_eq, Fin.le_iff_val_le_val] at *
   try simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
   change (L.lower x.val).val ≤ a + v.val ∧ a + v.val ≤ (L.upper x.val).val at hx
   change min m ((L.lower x.val).val - a) ≤ v.val ∧ v.val ≤ min m ((L.upper x.val).val - a)
   have hv : v.val ≤ m := Nat.le_of_lt_succ v.isLt
   omega
 let original : ∀ y : {j : {i : I // i ∈ cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L} // j ∈ Arithmetic.new I n a m L v},
     cleanNotation_element_value_91379654a1b03d81fbbb (cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L) (cleanNotation_element_value_91379654a1b03d81fbbb (Arithmetic.new I n a m L v) y) ∈ Arithmetic.old I n a m h L v := by
   intro y
   have hs := y.val.property
   have hy := y.property
   simp only [Arithmetic.old, Arithmetic.new, cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0, cleanDefine_interval_labels_at_4ec045b6f9d8095b2b53, cleanNotation_set_of_2c71fd475f49a65bd03e, cleanDefine_restricted_interval_labels_f8d969d03eb3434b6f57, cleanConstructor_interval_labels_46759148255508651561, cleanDefine_clipped_vertex_cd2b6a58bb5ecbbd5734, cleanNotation_natural_minimum_cde53e7621fcd34d67f8, cleanNotation_bounded_vertex_4cdd26cb1ed4473065a7, cleanNotation_vertex_number_8cd6f3b53e1bf7b0746b, cleanDefine_subpath_vertex_e406c0e2bda20c5fe110, cleanNotation_offset_vertex_a9a77e46ff8aec8df231, cleanNotation_widen_vertex_bebebc7e8408efb3d05a, cleanNotation_transport_vertex_b2b3660865bf501efafb, cleanNotation_selected_value_435b2b78382c9a6099ad, cleanNotation_element_value_91379654a1b03d81fbbb, cleanNotation_element_from_membership_2d38dbaa1fecbee6cdb1, cleanDefine_set_member_d7f862196f8cd9ab892e, cleanDefine_conjunction_41680d3b84ab96b0cab9, cleanNotation_natural_sum_884ddbcff666dc390f99, cleanNotation_natural_difference_c3d4d46094b9cc0fc4c2, cleanDefine_natural_at_most_0a7e9519b4591123e4b5, cleanDefine_vertex_at_most_ce50dc9de832f83e617b, cleanNumeral_Natural_47460cb427d00c0cfbad, Set.mem_setOf_eq, Fin.le_iff_val_le_val] at *
   try simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
   change (L.lower y.val.val).val ≤ a + m ∧ a ≤ (L.upper y.val.val).val at hs
   change min m ((L.lower y.val.val).val - a) ≤ v.val ∧ v.val ≤ min m ((L.upper y.val.val).val - a) at hy
   change (L.lower y.val.val).val ≤ a + v.val ∧ a + v.val ≤ (L.upper y.val.val).val
   have hv : v.val ≤ m := Nat.le_of_lt_succ v.isLt
   omega
 exact ⟨⟨survives,active,original⟩⟩


theorem active_labels_exist : existsStatement := by
 intro I n a m h L v
 obtain ⟨support⟩ := support_exists I n a m h L v
 refine ⟨cleanDefine_subtype_restriction_equivalence_9bd9190b4d8feda764d4 I (cleanDefine_surviving_interval_labels_58a74af1fdd310cbf3b0 I n a m L) (Arithmetic.old I n a m h L v) (Arithmetic.new I n a m L v) support ?_ ?_, ?_⟩
 · intro x
   apply Subtype.ext
   rfl
 · intro y
   apply Subtype.ext
   apply Subtype.ext
   rfl
 · intro x
   rfl
end Arithmetic

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
