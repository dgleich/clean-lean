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
import Mathlib.Topology.Path
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.AlgebraicTopology.SingularHomology.Basic
import Mathlib.Algebra.Category.ModuleCat.Abelian
import Mathlib.Algebra.Category.ModuleCat.Colimits
import Mathlib.Algebra.Homology.HomologicalComplexAbelian
import Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex

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

noncomputable def cleanDefine_implication_9c70b95b865a68fb6e58  (x : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (y : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x → y

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

noncomputable def cleanDefine_continuous_between_97c36c9607d00442c387 {X : Type} {Y : Type} (f : (X) → (Y)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Set_6e300741358eee425e81 (Y))), (_root_.cleanDefine_implication_9c70b95b865a68fb6e58 ((_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 (clean_bound_0) (u))) ((_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 (f) (clean_bound_0))) (t)))))

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

/--
A topology, two points, and a path between them, on a fixed carrier.
-/
structure cleanStructure_BasedPath_70f574d7589934963ee1 («X» : Type) : Type where
  «topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))
  «start» : «X»
  «finish» : «X»
  «path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))

noncomputable def cleanConstructor_based_path_2b5edffd368145e026ec («X» : Type) («topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))) («start» : «X») («finish» : «X») («path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 («X») :=
  @_root_.cleanStructure_BasedPath_70f574d7589934963ee1.mk «X» «topology» «start» «finish» «path»

noncomputable def cleanDefine_reversed_bundle_89d7b5d246c5c673d41c  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X) :=
  (@_root_.cleanConstructor_based_path_2b5edffd368145e026ec (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P))))))

structure cleanStructure_Endpoints_7a6ba0b879274641120c  : Type where
  «lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)

noncomputable def cleanConstructor_endpoints_3622a2317e61075ae5a0 («lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  @_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.mk «lower» «upper»

noncomputable def cleanDefine_ordered_endpoints_8c764d0c2fff2efbc5b8  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_real_less_23e496cb1d1d1ff9fdb3 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))))

noncomputable def cleanDefine_shifted_endpoints_56dbb0aee032fece61c6  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (s : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  (@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (s))) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (s))))

noncomputable abbrev cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_9ca9e49e1312ca23ac23   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_false_value_30a63b75654d87153a83   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable abbrev cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)

noncomputable def cleanNotation_underlying_real_map_0b69f7fea7146ae09669  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) : ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f

structure cleanStructure_EndpointSelection_417d89980a2c354c2182  : Type where
  «lower» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)
  «upper» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)

noncomputable def cleanConstructor_endpoint_selection_f2c54850f699491deae8 («lower» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) («upper» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  @_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.mk «lower» «upper»

noncomputable def cleanDefine_no_endpoints_3aad239e18f86ce44c68   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_false_value_30a63b75654d87153a83)) ((_root_.cleanNotation_false_value_30a63b75654d87153a83)))

noncomputable def cleanDefine_lower_endpoint_c404a3843e685ffaf059   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ((_root_.cleanNotation_false_value_30a63b75654d87153a83)))

noncomputable def cleanDefine_upper_endpoint_06a0ff0e6593640bb148   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_false_value_30a63b75654d87153a83)) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))

noncomputable def cleanDefine_both_endpoints_5b72385d3bc820377d4f   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))

noncomputable def cleanDefine_closed_interval_6ff374769e42838e17c5  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (clean_bound_0))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))))))))

noncomputable def cleanDefine_selected_endpoints_0c6530af3fba0a8ca281  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))))))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))))))))))

noncomputable def cleanDefine_expanded_interval_f798e8fd37d9631212b9  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (r))) (clean_bound_0))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (r)))))))))

noncomputable def cleanDefine_expanded_endpoints_69c934e5376bdc2f2867  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_disjunction_2a3db8ccf67a84818535 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (r))) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I))) (r))))))) ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» (E))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (r))) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 (clean_bound_0) ((_root_.cleanNotation_real_sum_8dd895080a4442dce6f9 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))) (r)))))))))))

structure cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc  : Type 1 where
  «space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 («space»))
  «interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c
  «selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182

noncomputable def cleanConstructor_interlevel_problem_53885bc5547eca082a8b («space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 («space»))) («interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc :=
  @_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.mk «space» «map» «interval» «selection»

structure cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))

noncomputable def cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 («X») :=
  @_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.mk «X» «ambient» «relative»

noncomputable def cleanDefine_nested_pair_081cfd12251352debe01  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))))

noncomputable def cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_expanded_interval_f798e8fd37d9631212b9 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (r))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_expanded_endpoints_69c934e5376bdc2f2867 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))) (r))))))

noncomputable def cleanDefine_shifted_pair_839ea777ea6079fe1438  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (t : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 ((_root_.cleanDefine_shifted_endpoints_56dbb0aee032fece61c6 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (t))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 ((_root_.cleanDefine_shifted_endpoints_56dbb0aee032fece61c6 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (t))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))))))))

noncomputable def cleanDefine_pair_included_in_0f8f1153fc26493cf3ad  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (R : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (R))))) ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (R))))))

noncomputable def cleanDefine_real_map_value_829bba0c597453819c48  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 (X) (f))) (x))

noncomputable def cleanDefine_bounded_perturbation_0dede816ed35ab14c798  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Point_f8a65e23875fb9a2c125 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))), (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_negative_b76c1fb39b30169ebf0c (r))) ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h) (clean_bound_0))) ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) (clean_bound_0))))))) ((_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((_root_.cleanNotation_real_difference_bf838970af972a894b2c ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h) (clean_bound_0))) ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) (clean_bound_0))))) (r)))))

noncomputable def cleanDefine_perturbed_pair_e76c2b7c221b8b14082e  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h))) ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))))))))

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

noncomputable def cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (h : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q)))))) : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X) :=
  (@_root_.cleanConstructor_topological_pair_f1f6ec54a2edb8f96e06 (X) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) (h))

noncomputable def cleanDefine_has_pair_data_28914c997308e957942c  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X)) (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))))))

noncomputable def cleanDefine_certify_pair_inclusion_56f49733534c168f2042  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (s : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S)))))) (t : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T)))))) (a : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T)))))) (b : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T)))))) : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X) :=
  (@_root_.cleanConstructor_pair_inclusion_b3b5f87a6a3fe9059428 (X) ((@_root_.cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 (X) (S) (s))) ((@_root_.cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 (X) (T) (t))) (a) (b))

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

noncomputable def cleanDefine_subspace_included_in_5a725c58655604c75660 {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) (W : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : V), (_root_.cleanDefine_implication_9c70b95b865a68fb6e58 ((@_root_.cleanDefine_belongs_to_subspace_1343338f28b5d525ee95 (K) (V) (f) (L) (clean_bound_0) (U))) ((@_root_.cleanDefine_belongs_to_subspace_1343338f28b5d525ee95 (K) (V) (f) (L) (clean_bound_0) (W)))))

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

noncomputable abbrev cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) : Type 1 :=
  (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)

noncomputable abbrev cleanType_ChainMap_063e7b1ac16f4d93b32c (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) : Type :=
  (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)

noncomputable def cleanNotation_chain_cokernel_97744b145fecc96e5aa0 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field)) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel f)

noncomputable def cleanNotation_chain_cokernel_projection_519249c918f9191af5f7 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (D) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) (f)))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.π f)

noncomputable def cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (g : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (D) (E))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (E)) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.comp f g)

noncomputable def cleanNotation_zero_chain_map_f93211fe6742dd559667 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D)) :=
  (letI : Field K := field; 0)

noncomputable def cleanNotation_chain_homology_d4826777f85ddf6093cd {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).obj C)

noncomputable def cleanNotation_induced_chain_homology_map_eb54927a741aa03132aa {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) (C) (n))) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) (D) (n)))) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).map f)

noncomputable def cleanDefine_same_chain_complex_41d938448421691bbfe2 {K : Type} {field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))} (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  C = D

noncomputable def cleanNotation_singular_chains_0ea3a0216812a68de8de {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field)) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).obj X)

noncomputable def cleanNotation_induced_chain_map_abc08358a6e20e5bc49c {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) (X))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) (Y)))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).map (TopCat.ofHom f))

noncomputable def cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q)))))))) :=
  (@_root_.cleanNotation_induced_chain_map_abc08358a6e20e5bc49c (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))))) ((@_root_.cleanNotation_subspace_inclusion_adcaf46bdb354b21c097 (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«nesting» (X) (Q))))))

noncomputable def cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X)) : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field)) :=
  (@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))))))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_relative_homology_8c8536140623f5a9ca6d {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) ((@_root_.cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb (K) (field) (H) (X) (Q))) ((@_root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9.«degree» (K) (field) (H))))

structure cleanStructure_ChainSquare_102f4e0edd5ead336a2c («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («C» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) : Type where
  «source» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («D»))
  «target» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («E») («F»))
  «left» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («E»))
  «right» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («D») («F»))
  «commutes» : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («D») («F») («right») («source»))) ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («E») («F») («target») («left»)))))

noncomputable def cleanConstructor_chain_square_09fb9b727d8254bdefef («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («C» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («source» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («D»))) («target» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («E») («F»))) («left» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («E»))) («right» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («D») («F»))) («commutes» : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («D») («F») («right») («source»))) ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («E») («F») («target») («left»)))))) : _root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c («K») («field») («C») («D») («E») («F») :=
  @_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.mk «K» «field» «C» «D» «E» «F» «source» «target» «left» «right» «commutes»

noncomputable def cleanNotation_chain_cokernel_map_ab0ddb0f117d819e24bb {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (F : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) (g : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (E) (F))) (p : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (E))) (q : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (D) (F))) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) (C) (D) (F) (q) (f))) ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) (C) (E) (F) (g) (p)))))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) (f))) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) (g)))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.map f g p q h)

noncomputable def cleanDefine_square_quotient_map_f3e6e0710322c5f7c133 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (F : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (S : _root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c (K) (field) (C) (D) (E) (F)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«source» (K) (field) (C) (D) (E) (F) (S))))) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«target» (K) (field) (C) (D) (E) (F) (S)))))) :=
  (@_root_.cleanNotation_chain_cokernel_map_ab0ddb0f117d819e24bb (K) (field) (C) (D) (E) (F) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«source» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«target» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«left» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«right» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«commutes» (K) (field) (C) (D) (E) (F) (S))))

noncomputable def cleanDefine_square_homology_map_a23cf9efc6803498b8c1 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (F : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (S : _root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c (K) (field) (C) (D) (E) (F)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«source» (K) (field) (C) (D) (E) (F) (S))))) (n))) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«target» (K) (field) (C) (D) (E) (F) (S))))) (n)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_eb54927a741aa03132aa (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«source» (K) (field) (C) (D) (E) (F) (S))))) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«target» (K) (field) (C) (D) (E) (F) (S))))) ((@_root_.cleanDefine_square_quotient_map_f3e6e0710322c5f7c133 (K) (field) (C) (D) (E) (F) (S))) (n))

noncomputable def cleanDefine_ambient_chain_map_07bb33b54dc2987cb74f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))))) :=
  (@_root_.cleanNotation_induced_chain_map_abc08358a6e20e5bc49c (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))) ((@_root_.cleanDefine_ambient_continuous_map_6f12f759e7ef2a177a6e (X) (Q))))

noncomputable def cleanDefine_relative_subset_chain_map_5c9afba6c7f454903ca6 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))))) :=
  (@_root_.cleanNotation_induced_chain_map_abc08358a6e20e5bc49c (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))) ((@_root_.cleanDefine_relative_continuous_map_bd861f61cac595a9f575 (X) (Q))))

noncomputable def cleanDefine_square_represents_pair_inclusion_64d568cf4b0b56ccc11b {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) (S : _root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_conjunction_41680d3b84ab96b0cab9 ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«source» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) (S))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«target» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) (S))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«left» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) (S))) ((@_root_.cleanDefine_relative_subset_chain_map_5c9afba6c7f454903ca6 (K) (field) (H) (X) (Q))))))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_ChainSquare_102f4e0edd5ead336a2c.«right» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) (S))) ((@_root_.cleanDefine_ambient_chain_map_07bb33b54dc2987cb74f (K) (field) (H) (X) (Q))))))

noncomputable def cleanDefine_relative_chain_projection_bc201fa1162b73e678e0 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))))))) ((@_root_.cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb (K) (field) (H) (X) (Q)))) :=
  (@_root_.cleanNotation_chain_cokernel_projection_519249c918f9191af5f7 (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) (Q))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) (Q))))))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_pair_chain_commutes_6b615b14e55c58c4a905 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanDefine_ambient_chain_map_07bb33b54dc2987cb74f (K) (field) (H) (X) (Q))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))) ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_subset_chain_map_5c9afba6c7f454903ca6 (K) (field) (H) (X) (Q))))))

noncomputable def cleanDefine_relative_chain_map_feba7c582421cfc27cf9 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) (h : ((@_root_.cleanDefine_pair_chain_commutes_6b615b14e55c58c4a905 (K) (field) (H) (X) (Q)))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))) :=
  (@_root_.cleanNotation_chain_cokernel_map_ab0ddb0f117d819e24bb (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«relative» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))))))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanDefine_pair_chain_inclusion_2bf512407b4b22b7a5ec (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_subset_chain_map_5c9afba6c7f454903ca6 (K) (field) (H) (X) (Q))) ((@_root_.cleanDefine_ambient_chain_map_07bb33b54dc2987cb74f (K) (field) (H) (X) (Q))) (h))

noncomputable def cleanDefine_relative_homology_map_ba573a68c3f5e3877a20 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) (h : ((@_root_.cleanDefine_pair_chain_commutes_6b615b14e55c58c4a905 (K) (field) (H) (X) (Q)))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_eb54927a741aa03132aa (K) (field) ((@_root_.cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_chains_6544c66c8bdd9d2e8cdb (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_chain_map_feba7c582421cfc27cf9 (K) (field) (H) (X) (Q) (h))) ((@_root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9.«degree» (K) (field) (H))))

noncomputable def cleanDefine_relative_homology_image_108fb35f76a7e136b6fb {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 (X)) (h : ((@_root_.cleanDefine_pair_chain_commutes_6b615b14e55c58c4a905 (K) (field) (H) (X) (Q)))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q)))))) :=
  (@_root_.cleanNotation_module_map_range_7b55a8a231e2462f9d90 (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_ee25aff32607b8147010.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_map_ba573a68c3f5e3877a20 (K) (field) (H) (X) (Q) (h))))

noncomputable def cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (spaces : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)) :=
  (letI : Field K := field; sInf spaces)

noncomputable def cleanDefine_intersection_of_module_family_e81cd54fe6924716cee9 {K : Type} {I : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (spaces : (I) → ((_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)) :=
  (@_root_.cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47 (K) (field) (M) ((_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) => (@Exists (I) (fun (clean_bound_1 : I) => (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) ((spaces clean_bound_1))))))))))

structure cleanStructure_PerturbationCertificate_e627b867b00dd852a336 («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : Type where
  «map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))))
  «bounded» : ((@_root_.cleanDefine_bounded_perturbation_0dede816ed35ab14c798 («P») («map») («r»)))
  «nesting» : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbed_pair_e76c2b7c221b8b14082e («P») («map»)))))
  «ambient» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_interval_f798e8fd37d9631212b9 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) («r»)))))))
  «relative» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_endpoints_69c934e5376bdc2f2867 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»))) («r»)))))))

noncomputable def cleanConstructor_perturbation_certificate_37a11405319f661ea148 («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))))) («bounded» : ((@_root_.cleanDefine_bounded_perturbation_0dede816ed35ab14c798 («P») («map») («r»)))) («nesting» : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbed_pair_e76c2b7c221b8b14082e («P») («map»)))))) («ambient» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_closed_interval_6ff374769e42838e17c5 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_interval_f798e8fd37d9631212b9 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) («r»)))))))) («relative» : ((_root_.cleanDefine_set_subset_a67e41d93cfd162885cf ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_selected_endpoints_0c6530af3fba0a8ca281 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»))))))) ((_root_.cleanDefine_inverse_image_22bc73bac0cb61752f41 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_endpoints_69c934e5376bdc2f2867 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»))) («r»)))))))) : _root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336 («P») («r») :=
  @_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.mk «P» «r» «map» «bounded» «nesting» «ambient» «relative»

noncomputable def cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r)))))) : _root_.cleanStructure_TopologicalPair_7b6a5ea05fe76ae01aa8 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanDefine_certify_pair_data_e8201efcc78ac5e01fa1 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))) (nesting))

noncomputable def cleanDefine_perturbation_pair_inclusion_2e67a5c4904b8bf678bc  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r)))))) (D : _root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336 (P) (r)) : _root_.cleanStructure_PairInclusion_ee25aff32607b8147010 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanDefine_certify_pair_inclusion_56f49733534c168f2042 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbed_pair_e76c2b7c221b8b14082e (P) ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«map» (P) (r) (D))))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))) ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«nesting» (P) (r) (D))) (nesting) ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«ambient» (P) (r) (D))) ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«relative» (P) (r) (D))))

structure cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («nesting» : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d («P») («r»)))))) : Type where
  «data» : _root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336 («P») («r»)
  «commutes» : ((@_root_.cleanDefine_pair_chain_commutes_6b615b14e55c58c4a905 («K») («field») («H») ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbation_pair_inclusion_2e67a5c4904b8bf678bc («P») («r») («nesting») («data»)))))

noncomputable def cleanConstructor_certified_perturbation_5024bf6c85dcbbc4190e («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («nesting» : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d («P») («r»)))))) («data» : _root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336 («P») («r»)) («commutes» : ((@_root_.cleanDefine_pair_chain_commutes_6b615b14e55c58c4a905 («K») («field») («H») ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbation_pair_inclusion_2e67a5c4904b8bf678bc («P») («r») («nesting») («data»)))))) : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 («K») («field») («H») («P») («r») («nesting») :=
  @_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.mk «K» «field» «H» «P» «r» «nesting» «data» «commutes»

noncomputable def cleanDefine_perturbation_homology_image_dab92c65ffcc3396d959 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r)))))) (C : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) (nesting)) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab (P) (r) (nesting)))))) :=
  (@_root_.cleanDefine_relative_homology_image_108fb35f76a7e136b6fb (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_pair_inclusion_2e67a5c4904b8bf678bc (P) (r) (nesting) ((@_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.«data» (K) (field) (H) (P) (r) (nesting) (C))))) ((@_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.«commutes» (K) (field) (H) (P) (r) (nesting) (C))))

noncomputable def cleanDefine_relative_well_group_f975d6f365bea2a93d2d {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r)))))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab (P) (r) (nesting)))))) :=
  (@_root_.cleanDefine_intersection_of_module_family_e81cd54fe6924716cee9 (K) (_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) (nesting)) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab (P) (r) (nesting))))) ((fun (clean_bound_0 : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) (nesting)) => (@_root_.cleanDefine_perturbation_homology_image_dab92c65ffcc3396d959 (K) (field) (H) (P) (r) (nesting) (clean_bound_0)))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: Submodule.mem_sInf
relationship: adapted
-/
def module_family_intersection_membership : Prop :=
  ∀ (K I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))),
  ∀ (spaces : (I) → ((_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanDefine_belongs_to_module_subspace_91c638861de4a497c6ac (K) (field) (M) (x) ((@_root_.cleanDefine_intersection_of_module_family_e81cd54fe6924716cee9 (K) (I) (field) (M) (spaces))))) ((∀ (clean_bound_0 : I), (@_root_.cleanDefine_belongs_to_module_subspace_91c638861de4a497c6ac (K) (field) (M) (x) ((spaces clean_bound_0))))))

/--
source: interlevel
reference: well-group perturbation family
relationship: adapted
scope: certificate completeness
-/
def bounded_perturbations_have_certificates : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : (_root_.cleanDefine_real_at_most_51ad2818948d6e758423 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))),
  ∀ («radius» : (_root_.cleanDefine_real_at_least_6add8f72594b91ec8f2f (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ («bounded» : (@_root_.cleanDefine_bounded_perturbation_0dede816ed35ab14c798 (P) (h) (r))),
  (@Exists (_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) («nesting»)) (fun (clean_bound_0 : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) («nesting»)) => (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.«data» (K) (field) (H) (P) (r) («nesting») (clean_bound_0))))) (h))))

/--
source: topology
reference: perturbation certificate evidence
relationship: original
-/
def certified_perturbations_are_bounded : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))),
  ∀ (C : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) («nesting»)),
  (@_root_.cleanDefine_bounded_perturbation_0dede816ed35ab14c798 (P) ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.«data» (K) (field) (H) (P) (r) («nesting») (C))))) (r))

/--
source: topology
reference: proof irrelevance for inclusion certificates
relationship: original
-/
def perturbation_image_ignores_certificate_choice : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))),
  ∀ (C D : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) («nesting»)),
  ∀ («same» : (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.«data» (K) (field) (H) (P) (r) («nesting») (C))))) ((@_root_.cleanStructure_PerturbationCertificate_e627b867b00dd852a336.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227.«data» (K) (field) (H) (P) (r) («nesting») (D))))))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanDefine_perturbation_homology_image_dab92c65ffcc3396d959 (K) (field) (H) (P) (r) («nesting») (C))) ((@_root_.cleanDefine_perturbation_homology_image_dab92c65ffcc3396d959 (K) (field) (H) (P) (r) («nesting») (D))))

/--
source: interlevel
reference: definition of relative well group
relationship: adapted
-/
def relative_well_group_membership : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_081cfd12251352debe01 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_2dec3ae65a0c9ba0325d (P) (r))))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab (P) (r) («nesting»))))))),
  (_root_.cleanDefine_logical_equivalence_96508ad7b1ed7af02bcb ((@_root_.cleanDefine_belongs_to_module_subspace_91c638861de4a497c6ac (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab (P) (r) («nesting»))))) (x) ((@_root_.cleanDefine_relative_well_group_f975d6f365bea2a93d2d (K) (field) (H) (P) (r) («nesting»))))) ((∀ (clean_bound_0 : _root_.cleanStructure_CertifiedPerturbation_de9d548e62b72879b227 (K) (field) (H) (P) (r) («nesting»)), (@_root_.cleanDefine_belongs_to_module_subspace_91c638861de4a497c6ac (K) (field) ((@_root_.cleanDefine_relative_homology_8c8536140623f5a9ca6d (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_a0ccda5ff92664e2a1ab (P) (r) («nesting»))))) (x) ((@_root_.cleanDefine_perturbation_homology_image_dab92c65ffcc3396d959 (K) (field) (H) (P) (r) («nesting») (clean_bound_0)))))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
