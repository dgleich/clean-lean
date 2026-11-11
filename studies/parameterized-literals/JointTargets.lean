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

noncomputable def cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  fun _ => (0 : Complex)

noncomputable def cleanNotation_complex_matrix_zero_dfd79b21223faff778db  («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  fun _ _ => (0 : Complex)

noncomputable def cleanNotation_real_vector_zero_9d24f55d9796fb0f8645  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  fun _ => (0 : Real)

noncomputable def cleanNotation_real_matrix_zero_f70710a3eff59f14747a  («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  fun _ _ => (0 : Real)

noncomputable def cleanNotation_det_9c9bd1c7c3f8362a9bee {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Matrix.det x0

noncomputable def cleanNotation_trace_6c72476cb04d5c61c4b6 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Matrix.trace x0

noncomputable def cleanNotation_transpose_37bc9c24cdb02b3afcbe {«m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («m») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Matrix.transpose x0

noncomputable def cleanNotation_inverse_cbbc11f960abbc8e919b {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (x0)⁻¹

noncomputable def cleanDefine_commutator_7a2644a6d2b446ea132a {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (@_root_.cleanNotation_complex_matrix_difference_6dc3d80ad21ec6a84b06 («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))) ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («B») («A»))))

noncomputable def cleanDefine_matrix_square_f1a7bece54a54888d26a {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  (@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («A»))

structure cleanStructure_ScalarCell_3bee75006b4648f59ffc  : Type where
  «entry» : (_root_.cleanType_Real_107b6641a486642ad8e1)

noncomputable def cleanConstructor_scalar_cell_e355c8cb262ce61f1e59 («entry» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_ScalarCell_3bee75006b4648f59ffc :=
  @_root_.cleanStructure_ScalarCell_3bee75006b4648f59ffc.mk «entry»

structure cleanStructure_VectorCell_ea235d5395205122748e («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «entry» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))

noncomputable def cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («entry» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_VectorCell_ea235d5395205122748e («n») :=
  @_root_.cleanStructure_VectorCell_ea235d5395205122748e.mk «n» «entry»

noncomputable def cleanNotation_successor_04500991a57d12c49471  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  Nat.succ n

structure cleanStructure_Dimension_6f5cbfe61b71a5fbfc06  : Type where
  «size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)

noncomputable def cleanConstructor_dimension_a9662d2191fb8355b027 («size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : _root_.cleanStructure_Dimension_6f5cbfe61b71a5fbfc06 :=
  @_root_.cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.mk «size»

structure cleanStructure_Payload_fb006548d81e980b3c12  : Type where
  «size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («size») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))

noncomputable def cleanConstructor_payload_4124ee55cf8744cb6e84 («size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («size») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_Payload_fb006548d81e980b3c12 :=
  @_root_.cleanStructure_Payload_fb006548d81e980b3c12.mk «size» «data»

structure cleanStructure_Box_58b02faf2b956c07982f  : Type where
  «value» : _root_.cleanStructure_Payload_fb006548d81e980b3c12

noncomputable def cleanConstructor_box_ca8a053baa1c8f98950c («value» : _root_.cleanStructure_Payload_fb006548d81e980b3c12) : _root_.cleanStructure_Box_58b02faf2b956c07982f :=
  @_root_.cleanStructure_Box_58b02faf2b956c07982f.mk «value»

noncomputable def cleanDefine_padded_5eac6b8fb8e53a3bb653  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  «x»

structure cleanStructure_PaddedPayload_1e13bbd8b6938ad5d95f  : Type where
  «size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («size») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))

noncomputable def cleanConstructor_padded_payload_e03e89c812d6bcc4b71f («size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («size») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_PaddedPayload_1e13bbd8b6938ad5d95f :=
  @_root_.cleanStructure_PaddedPayload_1e13bbd8b6938ad5d95f.mk «size» «data»

structure cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))

noncomputable def cleanConstructor_padded_cell_5ccc731b1064afbc4e96 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n») :=
  @_root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf.mk «n» «data»

structure cleanStructure_WrappedCell_70eb704e70f429e6291f («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «cell» : _root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n»)

noncomputable def cleanConstructor_wrapped_cell_0df31d1b7c86256d5752 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («cell» : _root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n»)) : _root_.cleanStructure_WrappedCell_70eb704e70f429e6291f («n») :=
  @_root_.cleanStructure_WrappedCell_70eb704e70f429e6291f.mk «n» «cell»


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

end CleanStatements

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

noncomputable def actualJoint0 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 (x) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedJoint0 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := @cleanDefine_unequal_37c577a540f8692ae5c3 (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) x (cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualJoint0 expectedJoint0

theorem meaningJoint0 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : actualJoint0 m n x A r ↔ (x ≠ (fun _ => (0 : Complex))) := by rfl


noncomputable def actualJoint1 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) (x))
noncomputable def expectedJoint1 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := @cleanDefine_unequal_37c577a540f8692ae5c3 (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n) x
same_basic_target actualJoint1 expectedJoint1

theorem meaningJoint1 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : actualJoint1 m n x A r ↔ ((fun _ => (0 : Complex)) ≠ x) := by rfl


noncomputable def actualJoint2 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := (_root_.cleanDefine_equal_5fac732a65dd209a83f4 (A) ((@_root_.cleanNotation_real_matrix_zero_f70710a3eff59f14747a (m) (n))))
noncomputable def expectedJoint2 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := @cleanDefine_equal_5fac732a65dd209a83f4 (cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) A (cleanNotation_real_matrix_zero_f70710a3eff59f14747a m n)
same_basic_target actualJoint2 expectedJoint2

theorem meaningJoint2 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : actualJoint2 m n x A r ↔ (A = (fun _ _ => (0 : Real))) := by rfl


noncomputable def actualJoint3 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_real_matrix_zero_f70710a3eff59f14747a (m) (n))) (A))
noncomputable def expectedJoint3 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Proposition_ae4a13d2f060407bce35 := @cleanDefine_equal_5fac732a65dd209a83f4 (cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (cleanNotation_real_matrix_zero_f70710a3eff59f14747a m n) A
same_basic_target actualJoint3 expectedJoint3

theorem meaningJoint3 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : actualJoint3 m n x A r ↔ ((fun _ _ => (0 : Real)) = A) := by rfl


noncomputable def actualJoint4 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Real_107b6641a486642ad8e1 := (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 (r) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))
noncomputable def expectedJoint4 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanType_Real_107b6641a486642ad8e1 := cleanNotation_real_sum_713c2cdea73d301a76c4 r (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))
same_basic_target actualJoint4 expectedJoint4

theorem meaningJoint4 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : actualJoint4 m n x A r = r := by
  simp [actualJoint4, cleanNotation_real_sum_713c2cdea73d301a76c4, cleanNumeral_Real_1f10813a9ce4dc61fe3e]


noncomputable def actualDefault0 : cleanType_Natural_469c53b6dafb7a218246 := (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))
noncomputable def expectedDefault0 : cleanType_Natural_469c53b6dafb7a218246 := cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)
same_basic_target actualDefault0 expectedDefault0


noncomputable def actualDefault1 : cleanType_Proposition_ae4a13d2f060407bce35 := (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))
noncomputable def expectedDefault1 : cleanType_Proposition_ae4a13d2f060407bce35 := @cleanDefine_equal_5fac732a65dd209a83f4 cleanType_Natural_469c53b6dafb7a218246 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))
same_basic_target actualDefault1 expectedDefault1

theorem meaningDefault0 : actualDefault0 = (0 : Nat) := by rfl

theorem meaningDefault1 : actualDefault1 := by rfl


noncomputable def actualConstructor0 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanStructure_ScalarCell_3bee75006b4648f59ffc := (@_root_.cleanConstructor_scalar_cell_e355c8cb262ce61f1e59 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))
noncomputable def expectedConstructor0 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanStructure_ScalarCell_3bee75006b4648f59ffc := @cleanConstructor_scalar_cell_e355c8cb262ce61f1e59 (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))
same_basic_target actualConstructor0 expectedConstructor0
theorem meaningConstructor0 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) :
  (actualConstructor0 m n x A r).entry = (0 : Real) := by simp [actualConstructor0, cleanConstructor_scalar_cell_e355c8cb262ce61f1e59, cleanNumeral_Real_1f10813a9ce4dc61fe3e]


noncomputable def actualConstructor1 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanStructure_VectorCell_ea235d5395205122748e n := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedConstructor1 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) : cleanStructure_VectorCell_ea235d5395205122748e n := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 n (cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualConstructor1 expectedConstructor1
theorem meaningConstructor1 (m n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) (A : cleanType_Matrix_4518cbfc13ff70fc0769 m n cleanType_Real_107b6641a486642ad8e1) (r : cleanType_Real_107b6641a486642ad8e1) :
  (actualConstructor1 m n x A r).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualLiteralDimension0 : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))
noncomputable def expectedLiteralDimension0 : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
same_basic_target actualLiteralDimension0 expectedLiteralDimension0
theorem meaningLiteralDimension0 :
  actualLiteralDimension0.entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualLiteralDimension1 : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))
noncomputable def expectedLiteralDimension1 : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
same_basic_target actualLiteralDimension1 expectedLiteralDimension1
theorem meaningLiteralDimension1 :
  actualLiteralDimension1.entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualComputedDimension0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_successor_04500991a57d12c49471 n) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNotation_successor_04500991a57d12c49471 (n))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_successor_04500991a57d12c49471 (n))))))
noncomputable def expectedComputedDimension0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_successor_04500991a57d12c49471 n) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNotation_successor_04500991a57d12c49471 n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_successor_04500991a57d12c49471 n))
same_basic_target actualComputedDimension0 expectedComputedDimension0
theorem meaningComputedDimension0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) :
  (actualComputedDimension0 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualComputedDimension1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (@cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.size D) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.«size» (D))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.«size» (D))))))
noncomputable def expectedComputedDimension1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (@cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.size D) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.size D) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanStructure_Dimension_6f5cbfe61b71a5fbfc06.size D))
same_basic_target actualComputedDimension1 expectedComputedDimension1
theorem meaningComputedDimension1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) :
  (actualComputedDimension1 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualComputedDimension2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n n) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (n))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (n))))))
noncomputable def expectedComputedDimension2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n n) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n n))
same_basic_target actualComputedDimension2 expectedComputedDimension2
theorem meaningComputedDimension2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) :
  (actualComputedDimension2 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDeferredDimension0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNotation_successor_04500991a57d12c49471 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_successor_04500991a57d12c49471 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))))
noncomputable def expectedDeferredDimension0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))
same_basic_target actualDeferredDimension0 expectedDeferredDimension0
theorem meaningDeferredDimension0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) :
  (actualDeferredDimension0 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDeferredDimension1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_successor_04500991a57d12c49471 (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNotation_successor_04500991a57d12c49471 ((_root_.cleanNotation_successor_04500991a57d12c49471 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_successor_04500991a57d12c49471 ((_root_.cleanNotation_successor_04500991a57d12c49471 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))))))
noncomputable def expectedDeferredDimension1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_successor_04500991a57d12c49471 (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNotation_successor_04500991a57d12c49471 (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_successor_04500991a57d12c49471 (cleanNotation_successor_04500991a57d12c49471 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))))
same_basic_target actualDeferredDimension1 expectedDeferredDimension1
theorem meaningDeferredDimension1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) :
  (actualDeferredDimension1 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDeferredDimension2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))))
noncomputable def expectedDeferredDimension2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))
same_basic_target actualDeferredDimension2 expectedDeferredDimension2
theorem meaningDeferredDimension2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) :
  (actualDeferredDimension2 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualProjection0 : cleanType_Natural_469c53b6dafb7a218246 := (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
noncomputable def expectedProjection0 : cleanType_Natural_469c53b6dafb7a218246 := cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)
same_basic_target actualProjection0 expectedProjection0
theorem meaningProjection0 : actualProjection0 = (2 : Nat) := by rfl


noncomputable def actualProjection1 : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))
noncomputable def expectedProjection1 : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
same_basic_target actualProjection1 expectedProjection1
theorem meaningProjection1 : actualProjection1.entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualProjection2 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))
noncomputable def expectedProjection2 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualProjection2 expectedProjection2
theorem meaningProjection2 : actualProjection2 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFieldValue0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))
noncomputable def expectedFieldValue0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualFieldValue0 expectedFieldValue0
theorem meaningFieldValue0 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : actualFieldValue0 n D = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFieldValue1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))
noncomputable def expectedFieldValue1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n
same_basic_target actualFieldValue1 expectedFieldValue1
theorem meaningFieldValue1 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : actualFieldValue1 n D = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFieldValue2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))
noncomputable def expectedFieldValue2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
same_basic_target actualFieldValue2 expectedFieldValue2
theorem meaningFieldValue2 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : (actualFieldValue2 n D).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFieldValue3 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))
noncomputable def expectedFieldValue3 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualFieldValue3 expectedFieldValue3
theorem meaningFieldValue3 (n : cleanType_Natural_469c53b6dafb7a218246) (D : cleanStructure_Dimension_6f5cbfe61b71a5fbfc06) : actualFieldValue3 n D = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFormalIndex0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_padded_5eac6b8fb8e53a3bb653 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))))
noncomputable def expectedFormalIndex0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanDefine_padded_5eac6b8fb8e53a3bb653 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))
same_basic_target actualFormalIndex0 expectedFormalIndex0
theorem meaningFormalIndex0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualFormalIndex0 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFormalIndex1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_padded_5eac6b8fb8e53a3bb653 (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))))
noncomputable def expectedFormalIndex1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanDefine_padded_5eac6b8fb8e53a3bb653 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))
same_basic_target actualFormalIndex1 expectedFormalIndex1
theorem meaningFormalIndex1 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualFormalIndex1 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFormalIndex2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))
noncomputable def expectedFormalIndex2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))
same_basic_target actualFormalIndex2 expectedFormalIndex2
theorem meaningFormalIndex2 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualFormalIndex2 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualParameterProjection0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))
noncomputable def expectedParameterProjection0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))
same_basic_target actualParameterProjection0 expectedParameterProjection0
theorem meaningParameterProjection0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualParameterProjection0 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualParameterProjection1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))
noncomputable def expectedParameterProjection1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (n) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))
same_basic_target actualParameterProjection1 expectedParameterProjection1
theorem meaningParameterProjection1 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualParameterProjection1 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualParameterProjection2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))
noncomputable def expectedParameterProjection2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))
same_basic_target actualParameterProjection2 expectedParameterProjection2
theorem meaningParameterProjection2 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualParameterProjection2 n = (fun _ => (0 : Complex)) := by rfl

-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
