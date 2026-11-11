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

noncomputable abbrev cleanType_Matrix_4518cbfc13ff70fc0769 («p0» : Nat) («p1» : Nat) («p2» : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable abbrev cleanType_Vector_cce915f2d60cfd4f85a3 («p0» : Nat) («p1» : Type) : Type :=
  Fin p0 → p1

noncomputable abbrev cleanType_Vertex_456780e707fa756f8a5f («p0» : Nat) : Type :=
  Fin p0

noncomputable abbrev cleanType_Graph_77c3210322e2c575cc5f («p0» : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable abbrev cleanType_List_b7361ff4f5869f86d7f2 («p0» : Type) : Type :=
  List (p0)

noncomputable abbrev cleanType_Set_182ba6b3273812add6f5 («p0» : Type) : Type :=
  Set (p0)

noncomputable abbrev cleanType_Function_bb05fd158cbe096d7b2f («p0» : Type) («p1» : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanDefine_equal_5fac732a65dd209a83f4 {«T» : Type} («x» : «T») («y» : «T») : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_unequal_37c577a540f8692ae5c3 {«T» : Type} («x» : «T») («y» : «T») : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x≠y

noncomputable def cleanDefine_conjunction_963f354411ee41f3dcd0  («x» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) («y» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∧ y

noncomputable def cleanDefine_disjunction_f5515da12fb20ae4acc8  («x» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) («y» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∨ y

noncomputable def cleanDefine_implication_9ee60e270a27b91f2307  («x» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) («y» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : («x»)), «y»)

noncomputable def cleanDefine_logical_equivalence_4c82a30225aa83f436b2  («x» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) («y» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ↔ y

noncomputable def cleanDefine_negation_9ec0af386428c726e6c3  («x» : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ¬x

noncomputable def cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x+y

noncomputable def cleanNotation_natural_difference_6609b71b367dd02ce17a  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x-y

noncomputable def cleanNotation_natural_product_a1e6180cd89df58f1622  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x*y

noncomputable def cleanNotation_natural_quotient_694be9eb9e9cd0674757  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x/y

noncomputable def cleanNotation_natural_power_1fd21d385ab090f72284  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  x^y

noncomputable def cleanDefine_natural_less_d52c2ea999690096a5ff  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x < y

noncomputable def cleanDefine_natural_greater_3d8d6817332e6eb602d9  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x > y

noncomputable def cleanDefine_natural_at_most_06515545afa0b9611d61  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≤ y

noncomputable def cleanDefine_natural_at_least_775c5d813822940a9178  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≥ y

noncomputable def cleanNotation_real_sum_713c2cdea73d301a76c4  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x+y

noncomputable def cleanNotation_real_difference_285267f55ec36308c915  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x-y

noncomputable def cleanNotation_real_product_b72eaff9286ea0417a4b  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x*y

noncomputable def cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x/y

noncomputable def cleanNotation_real_power_9499d8cf3f4010c81d2a  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x^y

noncomputable def cleanNotation_real_negative_94dbb7ead5371edbb1fe  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  -x

noncomputable def cleanDefine_real_less_b1358919b40501b8c83a  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x < y

noncomputable def cleanDefine_real_greater_b4d6b21f3416478ef02f  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x > y

noncomputable def cleanDefine_real_at_most_436a151a896b113553d7  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≤ y

noncomputable def cleanDefine_real_at_least_3b335915a25086862525  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≥ y

noncomputable def cleanNotation_complex_sum_be56a0dd109c232b3c8b  («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x+y

noncomputable def cleanNotation_complex_difference_9494621fedb3b37dc87a  («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x-y

noncomputable def cleanNotation_complex_product_76eff2f5d2a989bd0941  («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x*y

noncomputable def cleanNotation_complex_quotient_3b04d79e2cfd5b4d6706  («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x/y

noncomputable def cleanNotation_complex_power_0f8c2c3c756709a7cd57  («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  x^y

noncomputable def cleanNotation_complex_negative_a49334a08cf6022f59b6  («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  -x

noncomputable def cleanNotation_real_matrix_sum_839ae25a4d9a76476c1b {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x+y

noncomputable def cleanNotation_real_matrix_difference_08d7768bc0daae9db072 {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x-y

noncomputable def cleanNotation_real_matrix_product_4c62640b6fc73439c32b {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («p») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («p») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x*y

noncomputable def cleanNotation_real_matrix_application_50d297e0049f97ad9e85 {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («m») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  Matrix.mulVec x y

noncomputable def cleanNotation_real_scale_matrix_dee4533f77e5dbf0b762 {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x • y

noncomputable def cleanNotation_real_scale_vector_fdd277f0a8a88496ce0e {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x • y

noncomputable def cleanNotation_complex_matrix_sum_9e93bdb148efbea7541e {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x+y

noncomputable def cleanNotation_complex_matrix_difference_6dc3d80ad21ec6a84b06 {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x-y

noncomputable def cleanNotation_complex_matrix_product_22b143895482c8d56a11 {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («p») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («p») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x*y

noncomputable def cleanNotation_complex_matrix_application_3142d359b435ac1d9893 {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («m») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Matrix.mulVec x y

noncomputable def cleanNotation_complex_scale_matrix_7209f3d7140abd0bdb4b {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x • y

noncomputable def cleanNotation_complex_scale_vector_479d4254614637bbce32 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x • y

noncomputable def cleanDefine_natural_divides_4d6eaa87f34076546b83  («x» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∣ y

noncomputable def cleanDefine_set_member_e64b7ad19acfc0b8910d {«T» : Type} («x» : «T») («A» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∈ A

noncomputable def cleanDefine_list_member_b882ad41d912d6fc7a56 {«T» : Type} («x» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∈ A

noncomputable def cleanDefine_set_subset_05919499ab956b009bbe {«T» : Type} («A» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («B» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  A ⊆ B

noncomputable def cleanNotation_set_intersection_b049bcd777db8c8dca54 {«T» : Type} («A» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («B» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»)) :=
  A ∩ B

noncomputable def cleanNotation_set_union_8ded6f8d80349ff9fd80 {«T» : Type} («A» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («B» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»)) :=
  A ∪ B

noncomputable def cleanNotation_real_matrix_power_1f885251434bb95aa94b {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x^y

noncomputable def cleanNotation_real_vector_sum_c82d48cb5cb40ee116ca {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x+y

noncomputable def cleanNotation_real_vector_difference_fa3abe6d0d3984ccb81b {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  x-y

noncomputable def cleanNotation_complex_matrix_power_e192f7e7127c0722b4b4 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x^y

noncomputable def cleanNotation_complex_vector_sum_597fd175be1c65441219 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x+y

noncomputable def cleanNotation_complex_vector_difference_06fb8a11b79c0e4c1ce1 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  x-y

noncomputable def cleanNotation_pointwise_real_sum_d1526a0a0a62a5b93cbc  («x» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) («y» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  x+y

noncomputable def cleanNotation_pointwise_real_product_09ee7e3b795f01cef7db  («x» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) («y» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  x*y

noncomputable def cleanNotation_real_matrix_negative_ad56705bece2f7bcef1d {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  -x

noncomputable def cleanNotation_complex_matrix_negative_a1268997fb0b7e320e1f {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  -x

noncomputable abbrev cleanType_Topology_9cd8010cbc491576d39e («X» : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanNotation_set_of_8cabccf85aa2fb91712d {«X» : Type} («condition» : («X») → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»)) :=
  setOf condition

noncomputable def cleanDefine_open_in_8cd98278fdc255a021ab {«X» : Type} («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @IsOpen X t S

noncomputable def cleanDefine_inverse_image_31011f72ff8e2a9ce261 {«X» : Type} {«Y» : Type} («f» : («X») → («Y»)) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («Y»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»)) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : «X») => (_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d ((«f» clean_bound_0)) («S»)))))

noncomputable def cleanDefine_image_878fa9ab87138e755ce8 {«X» : Type} {«Y» : Type} («f» : («X») → («Y»)) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («Y»)) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : «Y») => (@Exists («X») (fun (clean_bound_1 : «X») => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d (clean_bound_1) («S»))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((«f» clean_bound_1)) (clean_bound_0)))))))))

noncomputable def cleanDefine_compose_maps_845d87c3fbf105362035 {«X» : Type} {«Y» : Type} {«Z» : Type} («g» : («Y») → («Z»)) («f» : («X») → («Y»)) : («X») → («Z») :=
  (fun (clean_bound_0 : «X») => («g» («f» clean_bound_0)))

noncomputable def cleanDefine_continuous_between_80ea5c38df54a0974c20 {«X» : Type} {«Y» : Type} («f» : («X») → («Y»)) («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («u» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («Y»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Set_182ba6b3273812add6f5 («Y»))), (_root_.cleanDefine_implication_9ee60e270a27b91f2307 ((_root_.cleanDefine_open_in_8cd98278fdc255a021ab (clean_bound_0) («u»))) ((_root_.cleanDefine_open_in_8cd98278fdc255a021ab ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 («f») (clean_bound_0))) («t»)))))

noncomputable def cleanDefine_selected_elements_9755d64246c0fb9fcd0a {«X» : Type} («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («condition» : («X») → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»)) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : «X») => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d (clean_bound_0) («S»))) ((«condition» clean_bound_0))))))

noncomputable def cleanDefine_intersection_family_ddeb64a0babf7d131f46 {«I» : Type} {«X» : Type} («sets» : («I») → ((_root_.cleanType_Set_182ba6b3273812add6f5 («X»)))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»)) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : «X») => (∀ (clean_bound_1 : «I»), (_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d (clean_bound_0) ((«sets» clean_bound_1)))))))

noncomputable abbrev cleanType_TopologicalSpace_d66be29262ccb5d89e3b  : Type 1 :=
  TopCat.{0}

noncomputable def cleanDefine_same_space_cd844fce5465d4756706  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  X = Y

noncomputable abbrev cleanType_Point_076f4ea9c8be8cf2cd06 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (TopCat.carrier X)

noncomputable abbrev cleanType_ContinuousMap_ef636b11c58f83e4d302 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier Y.carrier X.str Y.str)

noncomputable def cleanNotation_topological_space_fb2b4927c8d566e3ec85  («X» : Type) («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
  @TopCat.of.{0} X t

noncomputable def cleanNotation_space_topology_805999d18491a81215e0  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Topology_9cd8010cbc491576d39e ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»)))) :=
  TopCat.str X

noncomputable def cleanNotation_underlying_continuous_map_63a121f948b6a71cd00a  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) : ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) → ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («Y»))) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f

noncomputable def cleanNotation_continuous_value_902d70441ecbf2336c95  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) («x» : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («Y»)) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x

noncomputable def cleanNotation_identity_continuous_map_94a3f3121c349a769a9c  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («X»)) :=
  @ContinuousMap.id X.carrier X.str

noncomputable def cleanNotation_compose_continuous_maps_2460db16810fc2d63335  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Z» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («g» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («Y») («Z»))) («f» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Z»)) :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

structure cleanStructure_TopologicalDiagram_e1297170c1399993b233  : Type 1 where
  «source» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «target» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «arrow» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («source») («target»))

noncomputable def cleanConstructor_topological_diagram_297edef78c1b2d507018 («source» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («target» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («arrow» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («source») («target»))) : _root_.cleanStructure_TopologicalDiagram_e1297170c1399993b233 :=
  @_root_.cleanStructure_TopologicalDiagram_e1297170c1399993b233.mk «source» «target» «arrow»

noncomputable def cleanDefine_identity_diagram_8528ccc97e770c617ff9  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : _root_.cleanStructure_TopologicalDiagram_e1297170c1399993b233 :=
  (@_root_.cleanConstructor_topological_diagram_297edef78c1b2d507018 («X») («X») ((@_root_.cleanNotation_identity_continuous_map_94a3f3121c349a769a9c («X»))))

/--
An open subset of a fixed topological space, with its certificate.
-/
structure cleanStructure_OpenSubset_83201d2cf512d5d9624f («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «carrier» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))
  «openness» : ((_root_.cleanDefine_open_in_8cd98278fdc255a021ab («carrier») ((@_root_.cleanNotation_space_topology_805999d18491a81215e0 («X»)))))

noncomputable def cleanConstructor_open_subset_d91fb0ebab0f32264df9 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («carrier» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («openness» : ((_root_.cleanDefine_open_in_8cd98278fdc255a021ab («carrier») ((@_root_.cleanNotation_space_topology_805999d18491a81215e0 («X»)))))) : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X») :=
  @_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.mk «X» «carrier» «openness»

noncomputable def cleanDefine_covers_space_84f6e848e9a519beb270  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («U» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) («V» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))), (_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d (clean_bound_0) ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («U»))))) ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d (clean_bound_0) ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («V»)))))))

/--
An ordered pair of open subsets whose union contains every point.
-/
structure cleanStructure_OpenCover_d07f35d46c1790699f0c («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «left» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)
  «right» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)
  «covering» : ((@_root_.cleanDefine_covers_space_84f6e848e9a519beb270 («X») («left») («right»)))

noncomputable def cleanConstructor_open_cover_d74bf6012e41d5e96635 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («left» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) («right» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) («covering» : ((@_root_.cleanDefine_covers_space_84f6e848e9a519beb270 («X») («left») («right»)))) : _root_.cleanStructure_OpenCover_d07f35d46c1790699f0c («X») :=
  @_root_.cleanStructure_OpenCover_d07f35d46c1790699f0c.mk «X» «left» «right» «covering»

noncomputable def cleanNotation_intersection_openness_c866184ec04758ac26a9  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («U» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) («V» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) : ((_root_.cleanDefine_open_in_8cd98278fdc255a021ab ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («U»))) ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («V»))))) ((@_root_.cleanNotation_space_topology_805999d18491a81215e0 («X»))))) :=
  @IsOpen.inter X.carrier X.str U.carrier V.carrier U.openness V.openness

noncomputable def cleanDefine_open_overlap_40625f8a48c1d7df23fb  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («U» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) («V» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)) : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X») :=
  (@_root_.cleanConstructor_open_subset_d91fb0ebab0f32264df9 («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («U»))) ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («V»))))) ((@_root_.cleanNotation_intersection_openness_c866184ec04758ac26a9 («X») («U») («V»))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: covers
reference: openness certificate
relationship: original
-/
def «open_subset_is_open» : Prop :=
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («U» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)),
  (_root_.cleanDefine_open_in_8cd98278fdc255a021ab ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («U»))) ((@_root_.cleanNotation_space_topology_805999d18491a81215e0 («X»))))

/--
source: covers
reference: open overlap definition
relationship: original
-/
def «overlap_has_intersection_carrier» : Prop :=
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («U» «V» : _root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f («X»)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («U»))) ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («V»))))) ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («U»))) ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») («V»))))))

/--
source: covers
reference: coverage certificate
relationship: original
-/
def «cover_contains_every_point» : Prop :=
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («C» : _root_.cleanStructure_OpenCover_d07f35d46c1790699f0c («X»)),
  ∀ («x» : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))),
  (_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («x») ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») ((@_root_.cleanStructure_OpenCover_d07f35d46c1790699f0c.«left» («X») («C»))))))) ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («x») ((@_root_.cleanStructure_OpenSubset_83201d2cf512d5d9624f.«carrier» («X») ((@_root_.cleanStructure_OpenCover_d07f35d46c1790699f0c.«right» («X») («C»))))))))

end CleanStatements

namespace OpenCoverOracle
noncomputable def subset (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (carrier : cleanType_Set_182ba6b3273812add6f5 (cleanType_Point_076f4ea9c8be8cf2cd06 X))
 (openness : cleanDefine_open_in_8cd98278fdc255a021ab carrier (cleanNotation_space_topology_805999d18491a81215e0 X)) : cleanStructure_OpenSubset_83201d2cf512d5d9624f X := @cleanStructure_OpenSubset_83201d2cf512d5d9624f.mk X carrier openness
noncomputable def cover (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (left right : cleanStructure_OpenSubset_83201d2cf512d5d9624f X)
 (covering : cleanDefine_covers_space_84f6e848e9a519beb270 X left right) : cleanStructure_OpenCover_d07f35d46c1790699f0c X := @cleanStructure_OpenCover_d07f35d46c1790699f0c.mk X left right covering
noncomputable def covers (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanStructure_OpenSubset_83201d2cf512d5d9624f X) : cleanType_Proposition_ae4a13d2f060407bce35 :=
 ∀ (x : cleanType_Point_076f4ea9c8be8cf2cd06 X), cleanDefine_disjunction_f5515da12fb20ae4acc8 (cleanDefine_set_member_e64b7ad19acfc0b8910d x U.carrier) (cleanDefine_set_member_e64b7ad19acfc0b8910d x V.carrier)
noncomputable def intersectionOpen (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanStructure_OpenSubset_83201d2cf512d5d9624f X) :
 cleanDefine_open_in_8cd98278fdc255a021ab (cleanNotation_set_intersection_b049bcd777db8c8dca54 U.carrier V.carrier) (cleanNotation_space_topology_805999d18491a81215e0 X) :=
 @IsOpen.inter X.carrier X.str U.carrier V.carrier U.openness V.openness
noncomputable def overlap (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanStructure_OpenSubset_83201d2cf512d5d9624f X) : cleanStructure_OpenSubset_83201d2cf512d5d9624f X :=
 cleanConstructor_open_subset_d91fb0ebab0f32264df9 X (cleanNotation_set_intersection_b049bcd777db8c8dca54 U.carrier V.carrier) (cleanNotation_intersection_openness_c866184ec04758ac26a9 X U V)
def openStatement : Prop := ∀ (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U : cleanStructure_OpenSubset_83201d2cf512d5d9624f X), cleanDefine_open_in_8cd98278fdc255a021ab U.carrier (cleanNotation_space_topology_805999d18491a81215e0 X)
def overlapStatement : Prop := ∀ (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanStructure_OpenSubset_83201d2cf512d5d9624f X),
 cleanDefine_equal_5fac732a65dd209a83f4 (cleanNotation_set_intersection_b049bcd777db8c8dca54 U.carrier V.carrier) (cleanNotation_set_intersection_b049bcd777db8c8dca54 U.carrier V.carrier)
def coverStatement : Prop := ∀ (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (C : cleanStructure_OpenCover_d07f35d46c1790699f0c X) (x : cleanType_Point_076f4ea9c8be8cf2cd06 X),
 cleanDefine_disjunction_f5515da12fb20ae4acc8 (cleanDefine_set_member_e64b7ad19acfc0b8910d x C.left.carrier) (cleanDefine_set_member_e64b7ad19acfc0b8910d x C.right.carrier)
end OpenCoverOracle

theorem openSubsetCertificate : CleanStatements.open_subset_is_open := by
 intro X U
 exact U.openness

theorem overlapCarrier : CleanStatements.overlap_has_intersection_carrier := by
 intro X U V
 rfl

theorem coverCertificate : CleanStatements.cover_contains_every_point := by
 intro X C x
 exact C.covering x

-- Independent mathematical interpretation of the Clean-authored condition.
theorem coversIffUnion (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanStructure_OpenSubset_83201d2cf512d5d9624f X) :
 cleanDefine_covers_space_84f6e848e9a519beb270 X U V ↔ U.carrier ∪ V.carrier = Set.univ := by
 change (∀ x, x ∈ U.carrier ∨ x ∈ V.carrier) ↔ _
 constructor
 · intro h
   apply Set.eq_univ_of_forall
   exact h
 · intro h x
   have hx : x ∈ U.carrier ∪ V.carrier := by rw [h]; trivial
   exact hx

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
same_basic_target cleanConstructor_open_subset_d91fb0ebab0f32264df9 OpenCoverOracle.subset
same_basic_target cleanConstructor_open_cover_d74bf6012e41d5e96635 OpenCoverOracle.cover
same_basic_target cleanDefine_covers_space_84f6e848e9a519beb270 OpenCoverOracle.covers
same_basic_target cleanNotation_intersection_openness_c866184ec04758ac26a9 OpenCoverOracle.intersectionOpen
same_basic_target cleanDefine_open_overlap_40625f8a48c1d7df23fb OpenCoverOracle.overlap
same_basic_target CleanStatements.open_subset_is_open OpenCoverOracle.openStatement
same_basic_target CleanStatements.overlap_has_intersection_carrier OpenCoverOracle.overlapStatement
same_basic_target CleanStatements.cover_contains_every_point OpenCoverOracle.coverStatement

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
