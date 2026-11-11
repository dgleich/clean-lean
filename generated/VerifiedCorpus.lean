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

noncomputable def cleanNotation_insertionSort_0cd2f240badcf8cdfa87  («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  (List.insertionSort (· ≤ ·)) x0

noncomputable def cleanNotation_mergeSort_8fbbfb2ab4f5a7727336  («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  (fun l : List ℕ => l.mergeSort (· ≤ ·)) x0

noncomputable def cleanNotation_sorted_c8ebb0e1fd0d46933286  («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Sorted (· ≤ ·) x0

noncomputable def cleanNotation_permutation_3c75a7d421e0ca540310 {«T» : Type} («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («x1» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Perm x0 x1

noncomputable def cleanNotation_length_65435f587497fdfdb759 {«T» : Type} («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  List.length x0

noncomputable def cleanNotation_insert_04885748a3273e218a0c  («x0» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x1» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  List.orderedInsert (· ≤ ·) x0 x1

noncomputable def cleanNotation_cons_0611fc5c178fb817e54d  («x0» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x1» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  x0 :: x1

noncomputable def cleanNotation_sublist_0f90acae550eb9607428 {«T» : Type} («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («x1» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Sublist x0 x1

noncomputable def cleanNotation_count_a9e7250f971196cf69d8  («x0» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x1» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  List.count x0 x1

noncomputable def cleanNotation_merge_bc8b3c71b09437590bfd  («x0» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) («x1» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  List.merge x0 x1 (· ≤ ·)

noncomputable def cleanNotation_gcd_bc1e26bf5b4da92b3c6f  («x0» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x1» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  Nat.gcd x0 x1

noncomputable def cleanNotation_lcm_fea66987cbb80d4deb38  («x0» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x1» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  Nat.lcm x0 x1

noncomputable def cleanDefine_coprime_0a48a2fbd43c30d14948  («x0» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x1» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_gcd_bc1e26bf5b4da92b3c6f («x0») («x1»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))

noncomputable def cleanDefine_sorting_certificate_61e75a375b2d81b6b259  («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) («ys» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («ys»))) ((_root_.cleanNotation_permutation_3c75a7d421e0ca540310 («ys») («xs»))))

noncomputable def cleanNotation_exp_03583210ceeee28a427a  («x0» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.exp x0

noncomputable def cleanNotation_log_f1ba058d365d56eb0fb9  («x0» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.log x0

noncomputable def cleanNotation_sqrt_4669b969cc53105aa1d0  («x0» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.sqrt x0

noncomputable def cleanNotation_sin_4fcf183e5a154ab0c849  («x0» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.sin x0

noncomputable def cleanNotation_cos_57fc20d07da2e3712d02  («x0» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.cos x0

noncomputable def cleanNotation_abs_c8dbf9dcdd1aa0b57353  («x0» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  abs x0

noncomputable def cleanNotation_continuous_fd6afab30bd72d1008d7  («x0» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  Continuous x0

noncomputable def cleanNotation_differentiable_45f01ff4f4fb3fa2bd24  («x0» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  Differentiable ℝ x0

noncomputable def cleanNotation_compose_ca7c2d7970ef12810c71  («x0» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) («x1» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  (x0) ∘ (x1)

noncomputable def cleanDefine_square_461f8b873352ff43eb6c  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a («x») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))

noncomputable def cleanDefine_squared_distance_a5c2913665f8a933711f  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («y» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_square_461f8b873352ff43eb6c ((_root_.cleanNotation_real_difference_285267f55ec36308c915 («x») («y»))))

noncomputable def cleanDefine_trigonometric_energy_28da853f2c8b1cc3d273  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanDefine_square_461f8b873352ff43eb6c ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («x»))))) ((_root_.cleanDefine_square_461f8b873352ff43eb6c ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («x»))))))

noncomputable def cleanNotation_adjacent_5f91e051f0b7d3f5346c {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) («x2» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x0).Adj x1 x2

noncomputable def cleanNotation_complement_d5de7424c8c438088d5c {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»)) :=
  (x0)ᶜ

noncomputable def cleanNotation_union_900493c8bc3152e22cb0 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»)) :=
  x0 ⊔ x1

noncomputable def cleanNotation_intersection_1928544997b10e39293a {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»)) :=
  x0 ⊓ x1

noncomputable def cleanNotation_neighbors_7a55045a92b5456587f8 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Vertex_456780e707fa756f8a5f («n»)))) :=
  (x0).neighborSet x1

noncomputable def cleanNotation_support_3a35944ea6e7427e5f1b {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Vertex_456780e707fa756f8a5f («n»)))) :=
  (x0).support

noncomputable def cleanNotation_subgraph_67a00cd22d5d819ab994 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x0 ≤ x1

noncomputable def cleanNotation_reachable_28e7f5f90a6b0f076ae8 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) («x2» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x0).Reachable x1 x2

noncomputable def cleanNotation_connected_e78e1e8d073eeea2cd30 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x0).Connected

noncomputable def cleanDefine_commonNeighbors_52da06f30c8f3ae9229e {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x0» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («x1» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) («x2» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Vertex_456780e707fa756f8a5f («n»)))) :=
  (_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («x0») («x1»))) ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («x0») («x2»))))

noncomputable def cleanDefine_nonadjacent_c907b99b2fe1b47ebd4d {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))) («u» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) («v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_negation_9ec0af386428c726e6c3 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))))

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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: List.sorted_insertionSort
relationship: specialized
-/
def «insertion_sort_sorted» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: specialized
-/
def «insertion_sort_permutation» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanNotation_permutation_3c75a7d421e0ca540310 ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))) («xs»))

/--
source: mathlib
reference: List.length_insertionSort
relationship: specialized
-/
def «insertion_sort_length» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_length_65435f587497fdfdb759 ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))))) ((_root_.cleanNotation_length_65435f587497fdfdb759 («xs»))))

/--
source: mathlib
reference: List.mem_insertionSort
relationship: specialized
-/
def «insertion_sort_membership» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («a» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_list_member_b882ad41d912d6fc7a56 («a») ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))))) ((_root_.cleanDefine_list_member_b882ad41d912d6fc7a56 («a») («xs»))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: specialized
-/
def «sorted_input_unchanged» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («xs»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))) («xs»))

/--
source: mathlib
reference: List.orderedInsert_length
relationship: specialized
-/
def «ordered_insert_length» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («a» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_length_65435f587497fdfdb759 ((_root_.cleanNotation_insert_04885748a3273e218a0c («a») («xs»))))) ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNotation_length_65435f587497fdfdb759 («xs»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))

/--
source: mathlib
reference: List.mem_orderedInsert
relationship: specialized
-/
def «ordered_insert_membership» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («a» «b» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_list_member_b882ad41d912d6fc7a56 («b») ((_root_.cleanNotation_insert_04885748a3273e218a0c («a») («xs»))))) ((_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («b») («a»))) ((_root_.cleanDefine_list_member_b882ad41d912d6fc7a56 («b») («xs»))))))

/--
source: mathlib
reference: List.perm_orderedInsert
relationship: specialized
-/
def «ordered_insert_permutation» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («a» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanNotation_permutation_3c75a7d421e0ca540310 ((_root_.cleanNotation_insert_04885748a3273e218a0c («a») («xs»))) ((_root_.cleanNotation_cons_0611fc5c178fb817e54d («a») («xs»))))

/--
source: mathlib
reference: List.Sorted.orderedInsert
relationship: specialized
-/
def «ordered_insert_preserves_sortedness» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («a» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («ordered» : (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («xs»))),
  (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 ((_root_.cleanNotation_insert_04885748a3273e218a0c («a») («xs»))))

/--
source: mathlib
reference: List.sorted_mergeSort'
relationship: specialized
-/
def «merge_sort_sorted» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 ((_root_.cleanNotation_mergeSort_8fbbfb2ab4f5a7727336 («xs»))))

/--
source: mathlib
reference: List.mergeSort_eq_self
relationship: specialized
-/
def «merge_sort_sorted_input» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («xs»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_mergeSort_8fbbfb2ab4f5a7727336 («xs»))) («xs»))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: specialized
-/
def «sorting_algorithms_agree» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_mergeSort_8fbbfb2ab4f5a7727336 («xs»))) ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))))

/--
source: mathlib
reference: List.Sorted.merge
relationship: specialized
-/
def «merge_preserves_sortedness» : Prop :=
  ∀ («xs» «ys» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («hx» : (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («xs»))),
  ∀ («hy» : (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («ys»))),
  (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 ((_root_.cleanNotation_merge_bc8b3c71b09437590bfd («xs») («ys»))))

/--
source: mathlib
reference: List.sublist_insertionSort
relationship: specialized
-/
def «insertion_sort_subsequence» : Prop :=
  ∀ («xs» «ys» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («ordered» : (_root_.cleanNotation_sorted_c8ebb0e1fd0d46933286 («ys»))),
  ∀ («subsequence» : (_root_.cleanNotation_sublist_0f90acae550eb9607428 («ys») («xs»))),
  (_root_.cleanNotation_sublist_0f90acae550eb9607428 («ys») ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))))

/--
source: mathlib
reference: List.sublist_orderedInsert
relationship: specialized
-/
def «ordered_insert_contains_input» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («a» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanNotation_sublist_0f90acae550eb9607428 («xs») ((_root_.cleanNotation_insert_04885748a3273e218a0c («a») («xs»))))

/--
source: mathlib
reference: Nat.coprime_add_mul_right_right
relationship: specialized
-/
def «euclidean_coprime_reduction» : Prop :=
  ∀ («a» «b» «k» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 («a») ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («b») ((_root_.cleanNotation_natural_product_a1e6180cd89df58f1622 («k») («a»))))))) ((_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 («a») («b»))))

/--
source: mathlib
reference: Nat.coprime_sub_self_left
relationship: specialized
-/
def «euclidean_coprime_subtraction» : Prop :=
  ∀ («a» «b» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («ordered» : (_root_.cleanDefine_natural_at_most_06515545afa0b9611d61 («a») («b»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 ((_root_.cleanNotation_natural_difference_6609b71b367dd02ce17a («b») («a»))) («a»))) ((_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 («b») («a»))))

/--
source: mathlib
reference: Nat.Coprime.lcm_eq_mul
relationship: specialized
-/
def «coprime_lcm_product» : Prop :=
  ∀ («a» «b» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 («a») («b»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_lcm_fea66987cbb80d4deb38 («a») («b»))) ((_root_.cleanNotation_natural_product_a1e6180cd89df58f1622 («a») («b»))))

/--
source: mathlib
reference: Nat.eq_one_of_dvd_coprimes
relationship: specialized
-/
def «common_divisor_of_coprimes» : Prop :=
  ∀ («a» «b» «k» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 («a») («b»))),
  ∀ («divides_a» : (_root_.cleanDefine_natural_divides_4d6eaa87f34076546b83 («k») («a»))),
  ∀ («divides_b» : (_root_.cleanDefine_natural_divides_4d6eaa87f34076546b83 («k») («b»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 («k») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))

/--
source: mathlib
reference: Nat.Coprime.dvd_mul_right
relationship: specialized
-/
def «coprime_product_divisibility» : Prop :=
  ∀ («a» «b» «k» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («cop» : (_root_.cleanDefine_coprime_0a48a2fbd43c30d14948 («k») («b»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_natural_divides_4d6eaa87f34076546b83 («k») ((_root_.cleanNotation_natural_product_a1e6180cd89df58f1622 («a») («b»))))) ((_root_.cleanDefine_natural_divides_4d6eaa87f34076546b83 («k») («a»))))

/--
source: mathlib
reference: List.perm_insertionSort
relationship: adapted
-/
def «insertion_sort_certificate» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_sorting_certificate_61e75a375b2d81b6b259 («xs») ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («xs»))))

/--
source: mathlib
reference: List.mergeSort_eq_insertionSort
relationship: adapted
-/
def «merge_sort_certificate» : Prop :=
  ∀ («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  (_root_.cleanDefine_sorting_certificate_61e75a375b2d81b6b259 («xs») ((_root_.cleanNotation_mergeSort_8fbbfb2ab4f5a7727336 («xs»))))

/--
source: mathlib
reference: List.Sorted.insertionSort_eq
relationship: adapted
-/
def «certified_sort_unchanged» : Prop :=
  ∀ («xs» «ys» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))),
  ∀ («certificate» : (_root_.cleanDefine_sorting_certificate_61e75a375b2d81b6b259 («xs») («ys»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_insertionSort_0cd2f240badcf8cdfa87 («ys»))) («ys»))

/--
source: mathlib
reference: Real.exp_pos
relationship: specialized
-/
def «exponential_positive» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_real_less_b1358919b40501b8c83a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) ((_root_.cleanNotation_exp_03583210ceeee28a427a («x»))))

/--
source: mathlib
reference: Real.exp_ne_zero
relationship: specialized
-/
def «exponential_nonzero» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 ((_root_.cleanNotation_exp_03583210ceeee28a427a («x»))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))

/--
source: mathlib
reference: Real.exp_add
relationship: specialized
-/
def «exponential_sum» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_exp_03583210ceeee28a427a ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 («x») («y»))))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_exp_03583210ceeee28a427a («x»))) ((_root_.cleanNotation_exp_03583210ceeee28a427a («y»))))))

/--
source: mathlib
reference: Real.exp_sub
relationship: specialized
-/
def «exponential_difference» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_exp_03583210ceeee28a427a ((_root_.cleanNotation_real_difference_285267f55ec36308c915 («x») («y»))))) ((_root_.cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a ((_root_.cleanNotation_exp_03583210ceeee28a427a («x»))) ((_root_.cleanNotation_exp_03583210ceeee28a427a («y»))))))

/--
source: mathlib
reference: Real.log_exp
relationship: specialized
-/
def «logarithm_exponential» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 ((_root_.cleanNotation_exp_03583210ceeee28a427a («x»))))) («x»))

/--
source: mathlib
reference: Real.exp_log
relationship: specialized
-/
def «exponential_logarithm» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («positive» : (_root_.cleanDefine_real_less_b1358919b40501b8c83a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) («x»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_exp_03583210ceeee28a427a ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 («x»))))) («x»))

/--
source: mathlib
reference: Real.log_mul
relationship: specialized
-/
def «logarithm_product» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonzero_x» : (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («x») ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («nonzero_y» : (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («y») ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b («x») («y»))))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 («x»))) ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 («y»))))))

/--
source: mathlib
reference: Real.log_div
relationship: specialized
-/
def «logarithm_quotient» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonzero_x» : (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («x») ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  ∀ («nonzero_y» : (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («y») ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 ((_root_.cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a («x») («y»))))) ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 («x»))) ((_root_.cleanNotation_log_f1ba058d365d56eb0fb9 («y»))))))

/--
source: mathlib
reference: Real.sqrt_nonneg
relationship: specialized
-/
def «square_root_nonnegative» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 («x»))))

/--
source: mathlib
reference: Real.sq_sqrt
relationship: specialized
-/
def «square_of_square_root» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonnegative» : (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) («x»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 («x»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))) («x»))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: specialized
-/
def «square_root_of_square» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a («x») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 («x»))))

/--
source: mathlib
reference: Real.sqrt_mul
relationship: specialized
-/
def «square_root_product» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nonnegative» : (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) («x»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b («x») («y»))))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 («x»))) ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 («y»))))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: specialized
-/
def «trigonometric_identity» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («x»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))) ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («x»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))))

/--
source: mathlib
reference: Real.sin_add
relationship: specialized
-/
def «sine_addition» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 («x») («y»))))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («x»))) ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («y»))))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («x»))) ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («y»))))))))

/--
source: mathlib
reference: Real.cos_add
relationship: specialized
-/
def «cosine_addition» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 («x») («y»))))) ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («x»))) ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («y»))))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («x»))) ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («y»))))))))

/--
source: mathlib
reference: Real.sin_neg
relationship: specialized
-/
def «sine_odd» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 ((_root_.cleanNotation_real_negative_94dbb7ead5371edbb1fe («x»))))) ((_root_.cleanNotation_real_negative_94dbb7ead5371edbb1fe ((_root_.cleanNotation_sin_4fcf183e5a154ab0c849 («x»))))))

/--
source: mathlib
reference: Real.cos_neg
relationship: specialized
-/
def «cosine_even» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 ((_root_.cleanNotation_real_negative_94dbb7ead5371edbb1fe («x»))))) ((_root_.cleanNotation_cos_57fc20d07da2e3712d02 («x»))))

/--
source: mathlib
reference: Continuous.comp
relationship: specialized
-/
def «continuous_composition» : Prop :=
  ∀ («f» «g» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 («f»))),
  ∀ («hg» : (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 («g»))),
  (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 ((_root_.cleanNotation_compose_ca7c2d7970ef12810c71 («f») («g»))))

/--
source: mathlib
reference: Continuous.add
relationship: specialized
-/
def «continuous_sum» : Prop :=
  ∀ («f» «g» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 («f»))),
  ∀ («hg» : (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 («g»))),
  (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 ((_root_.cleanNotation_pointwise_real_sum_d1526a0a0a62a5b93cbc («f») («g»))))

/--
source: mathlib
reference: Continuous.mul
relationship: specialized
-/
def «continuous_product» : Prop :=
  ∀ («f» «g» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ («hf» : (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 («f»))),
  ∀ («hg» : (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 («g»))),
  (_root_.cleanNotation_continuous_fd6afab30bd72d1008d7 ((_root_.cleanNotation_pointwise_real_product_09ee7e3b795f01cef7db («f») («g»))))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def «authored_square_root» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 ((_root_.cleanDefine_square_461f8b873352ff43eb6c («x»))))) ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 («x»))))

/--
source: mathlib
reference: Real.sin_sq_add_cos_sq
relationship: adapted
-/
def «authored_trigonometric_energy» : Prop :=
  ∀ («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanDefine_trigonometric_energy_28da853f2c8b1cc3d273 («x»))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))))

/--
source: mathlib
reference: Real.sqrt_sq_eq_abs
relationship: adapted
-/
def «distance_square_root» : Prop :=
  ∀ («x» «y» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 ((_root_.cleanDefine_squared_distance_a5c2913665f8a933711f («x») («y»))))) ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 («x») («y»))))))

/--
source: mathlib
reference: SimpleGraph.adj_symm
relationship: specialized
-/
def «adjacency_symmetry» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  ∀ («edge» : (@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))),
  (@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («v») («u»))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: specialized
-/
def «adjacency_commutes» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))) ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («v») («u»))))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def «no_self_edges» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_negation_9ec0af386428c726e6c3 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («u»))))

/--
source: mathlib
reference: SimpleGraph.ne_of_adj
relationship: specialized
-/
def «adjacent_vertices_distinct» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  ∀ («edge» : (@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))),
  (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («u») («v»))

/--
source: mathlib
reference: SimpleGraph.sup_adj
relationship: specialized
-/
def «union_adjacency» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» «H» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») ((@_root_.cleanNotation_union_900493c8bc3152e22cb0 («n») («G») («H»))) («u») («v»))) ((_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))) ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («H») («u») («v»))))))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def «intersection_adjacency» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» «H» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») ((@_root_.cleanNotation_intersection_1928544997b10e39293a («n») («G») («H»))) («u») («v»))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))) ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («H») («u») («v»))))))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def «complement_adjacency» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») ((@_root_.cleanNotation_complement_d5de7424c8c438088d5c («n») («G»))) («u») («v»))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («u») («v»))) ((_root_.cleanDefine_negation_9ec0af386428c726e6c3 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))))))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def «support_monotonicity» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» «H» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («inclusion» : (@_root_.cleanNotation_subgraph_67a00cd22d5d819ab994 («n») («G») («H»))),
  (_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanNotation_support_3a35944ea6e7427e5f1b («n») («G»))) ((@_root_.cleanNotation_support_3a35944ea6e7427e5f1b («n») («H»))))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def «neighbors_in_support» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («u»))) ((@_root_.cleanNotation_support_3a35944ea6e7427e5f1b («n») («G»))))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def «neighbor_membership» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («v») ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («u»))))) ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def «not_own_neighbor» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_negation_9ec0af386428c726e6c3 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («u») ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («u»))))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def «common_neighbors_intersection» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanDefine_commonNeighbors_52da06f30c8f3ae9229e («n») («G») («u») («v»))) ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («u»))) ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («v»))))))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def «common_neighbors_membership» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» «w» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («w») ((@_root_.cleanDefine_commonNeighbors_52da06f30c8f3ae9229e («n») («G») («u») («v»))))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («w»))) ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («v») («w»))))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def «common_neighbors_symmetry» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanDefine_commonNeighbors_52da06f30c8f3ae9229e («n») («G») («u») («v»))) ((@_root_.cleanDefine_commonNeighbors_52da06f30c8f3ae9229e («n») («G») («v») («u»))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def «common_neighbors_left» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanDefine_commonNeighbors_52da06f30c8f3ae9229e («n») («G») («u») («v»))) ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («u»))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def «common_neighbors_right» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanDefine_commonNeighbors_52da06f30c8f3ae9229e («n») («G») («u») («v»))) ((@_root_.cleanNotation_neighbors_7a55045a92b5456587f8 («n») («G») («v»))))

/--
source: mathlib
reference: SimpleGraph.Reachable.refl
relationship: specialized
-/
def «reachability_reflexive» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («u») («u»))

/--
source: mathlib
reference: SimpleGraph.Reachable.symm
relationship: specialized
-/
def «reachability_symmetric» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  ∀ («path» : (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («u») («v»))),
  (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («v») («u»))

/--
source: mathlib
reference: SimpleGraph.Reachable.trans
relationship: specialized
-/
def «reachability_transitive» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» «w» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  ∀ («first» : (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («u») («v»))),
  ∀ («second» : (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («v») («w»))),
  (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («u») («w»))

/--
source: mathlib
reference: SimpleGraph.Adj.reachable
relationship: specialized
-/
def «edge_implies_reachability» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  ∀ («edge» : (@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») («G») («u») («v»))),
  (@_root_.cleanNotation_reachable_28e7f5f90a6b0f076ae8 («n») («G») («u») («v»))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: adapted
-/
def «nonadjacency_symmetry» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((@_root_.cleanDefine_nonadjacent_c907b99b2fe1b47ebd4d («n») («G») («u») («v»))) ((@_root_.cleanDefine_nonadjacent_c907b99b2fe1b47ebd4d («n») («G») («v») («u»))))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: adapted
-/
def «nonadjacency_reflexive» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (@_root_.cleanDefine_nonadjacent_c907b99b2fe1b47ebd4d («n») («G») («u») («u»))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: adapted
-/
def «complement_from_nonadjacency» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («G» : (_root_.cleanType_Graph_77c3210322e2c575cc5f («n»))),
  ∀ («u» «v» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))),
  (_root_.cleanDefine_logical_equivalence_4c82a30225aa83f436b2 ((@_root_.cleanNotation_adjacent_5f91e051f0b7d3f5346c («n») ((@_root_.cleanNotation_complement_d5de7424c8c438088d5c («n») («G»))) («u») («v»))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_unequal_37c577a540f8692ae5c3 («u») («v»))) ((@_root_.cleanDefine_nonadjacent_c907b99b2fe1b47ebd4d («n») («G») («u») («v»))))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: specialized
-/
def «determinant_product» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))))) ((_root_.cleanNotation_complex_product_76eff2f5d2a989bd0941 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») («A»))) ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») («B»))))))

/--
source: mathlib
reference: Matrix.det_transpose
relationship: specialized
-/
def «determinant_transpose» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») («A»))))) ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») («A»))))

/--
source: mathlib
reference: Matrix.det_mul_comm
relationship: specialized
-/
def «determinant_product_swap» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))))) ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («B») («A»))))))

/--
source: mathlib
reference: Matrix.det_mul_left_comm
relationship: specialized
-/
def «determinant_left_swap» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» «C» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («B») («C»))))))) ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («B») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («C»))))))))

/--
source: mathlib
reference: Matrix.det_mul_right_comm
relationship: specialized
-/
def «determinant_right_swap» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» «C» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))) («C»))))) ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («C»))) («B»))))))

/--
source: mathlib
reference: Matrix.det_pow
relationship: specialized
-/
def «determinant_power» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («k» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanNotation_complex_matrix_power_e192f7e7127c0722b4b4 («n») («A») («k»))))) ((_root_.cleanNotation_complex_power_0f8c2c3c756709a7cd57 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») («A»))) («k»))))

/--
source: mathlib
reference: Matrix.trace_add
relationship: specialized
-/
def «trace_sum» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_sum_9e93bdb148efbea7541e («n») («n») («A») («B»))))) ((_root_.cleanNotation_complex_sum_be56a0dd109c232b3c8b ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») («A»))) ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») («B»))))))

/--
source: mathlib
reference: Matrix.trace_sub
relationship: specialized
-/
def «trace_difference» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_difference_6dc3d80ad21ec6a84b06 («n») («n») («A») («B»))))) ((_root_.cleanNotation_complex_difference_9494621fedb3b37dc87a ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») («A»))) ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») («B»))))))

/--
source: mathlib
reference: Matrix.trace_neg
relationship: specialized
-/
def «trace_negative» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_negative_a1268997fb0b7e320e1f («n») («n») («A»))))) ((_root_.cleanNotation_complex_negative_a49334a08cf6022f59b6 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») («A»))))))

/--
source: mathlib
reference: Matrix.trace_transpose
relationship: specialized
-/
def «trace_transpose» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») («A»))))) ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») («A»))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: specialized
-/
def «trace_product_swap» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))))) ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («B») («A»))))))

/--
source: mathlib
reference: Matrix.trace_mul_cycle
relationship: specialized
-/
def «trace_cycle» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» «C» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))) («C»))))) ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («C») («A»))) («B»))))))

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: specialized
-/
def «matrix_vector_associativity» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («B») («x»))))) ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))) («x»))))

/--
source: mathlib
reference: Matrix.mulVec_add
relationship: specialized
-/
def «matrix_vector_addition» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («x» «y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») ((@_root_.cleanNotation_complex_vector_sum_597fd175be1c65441219 («n») («x») («y»))))) ((@_root_.cleanNotation_complex_vector_sum_597fd175be1c65441219 («n») ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («x»))) ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («y»))))))

/--
source: mathlib
reference: Matrix.add_mulVec
relationship: specialized
-/
def «matrix_addition_action» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») ((@_root_.cleanNotation_complex_matrix_sum_9e93bdb148efbea7541e («n») («n») («A») («B»))) («x»))) ((@_root_.cleanNotation_complex_vector_sum_597fd175be1c65441219 («n») ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («x»))) ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («B») («x»))))))

/--
source: mathlib
reference: Matrix.mulVec_sub
relationship: specialized
-/
def «matrix_vector_subtraction» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («x» «y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») ((@_root_.cleanNotation_complex_vector_difference_06fb8a11b79c0e4c1ce1 («n») («x») («y»))))) ((@_root_.cleanNotation_complex_vector_difference_06fb8a11b79c0e4c1ce1 («n») ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («x»))) ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («y»))))))

/--
source: mathlib
reference: Matrix.sub_mulVec
relationship: specialized
-/
def «matrix_subtraction_action» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») ((@_root_.cleanNotation_complex_matrix_difference_6dc3d80ad21ec6a84b06 («n») («n») («A») («B»))) («x»))) ((@_root_.cleanNotation_complex_vector_difference_06fb8a11b79c0e4c1ce1 («n») ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («x»))) ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («B») («x»))))))

/--
source: mathlib
reference: Matrix.mulVec_smul
relationship: specialized
-/
def «matrix_scalar_action» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  ∀ («c» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») ((@_root_.cleanNotation_complex_scale_vector_479d4254614637bbce32 («n») («c») («x»))))) ((@_root_.cleanNotation_complex_scale_vector_479d4254614637bbce32 («n») («c») ((@_root_.cleanNotation_complex_matrix_application_3142d359b435ac1d9893 («n») («n») («A») («x»))))))

/--
source: mathlib
reference: Matrix.transpose_transpose
relationship: specialized
-/
def «transpose_involution» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») («A»))))) («A»))

/--
source: mathlib
reference: Matrix.transpose_mul
relationship: specialized
-/
def «transpose_product» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («B»))))) ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») («B»))) ((@_root_.cleanNotation_transpose_37bc9c24cdb02b3afcbe («n») («n») («A»))))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def «trace_commutator» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» «B» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanDefine_commutator_7a2644a6d2b446ea132a («n») («A») («B»))))) ((_root_.cleanNumeral_Complex_311fd057b7f2e2b599a3 (nat_lit 0))))

/--
source: mathlib
reference: Matrix.trace_mul_comm
relationship: adapted
-/
def «trace_matrix_square» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanDefine_matrix_square_f1a7bece54a54888d26a («n») («A»))))) ((@_root_.cleanNotation_trace_6c72476cb04d5c61c4b6 («n») ((@_root_.cleanNotation_complex_matrix_product_22b143895482c8d56a11 («n») («n») («n») («A») («A»))))))

/--
source: mathlib
reference: Matrix.det_mul
relationship: adapted
-/
def «determinant_matrix_square» : Prop :=
  ∀ («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  ∀ («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») ((@_root_.cleanDefine_matrix_square_f1a7bece54a54888d26a («n») («A»))))) ((_root_.cleanNotation_complex_product_76eff2f5d2a989bd0941 ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») («A»))) ((@_root_.cleanNotation_det_9c9bd1c7c3f8362a9bee («n») («A»))))))

end CleanStatements

namespace CleanValidation
theorem determinant_product : CleanStatements.determinant_product := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul A B

theorem determinant_transpose : CleanStatements.determinant_transpose := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_transpose A

theorem determinant_product_swap : CleanStatements.determinant_product_swap := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul_comm A B

theorem determinant_left_swap : CleanStatements.determinant_left_swap := by
  intro n A B C
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul_left_comm A B C

theorem determinant_right_swap : CleanStatements.determinant_right_swap := by
  intro n A B C
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul_right_comm A B C

theorem determinant_power : CleanStatements.determinant_power := by
  intro n A k
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_pow A k

theorem trace_sum : CleanStatements.trace_sum := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_add A B

theorem trace_difference : CleanStatements.trace_difference := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_sub A B

theorem trace_negative : CleanStatements.trace_negative := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_neg A

theorem trace_transpose : CleanStatements.trace_transpose := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_transpose A

theorem trace_product_swap : CleanStatements.trace_product_swap := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_mul_comm A B

theorem trace_cycle : CleanStatements.trace_cycle := by
  intro n A B C
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.trace_mul_cycle A B C

theorem matrix_vector_associativity : CleanStatements.matrix_vector_associativity := by
  intro n A B x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_mulVec x A B

theorem matrix_vector_addition : CleanStatements.matrix_vector_addition := by
  intro n A x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_add A x y

theorem matrix_addition_action : CleanStatements.matrix_addition_action := by
  intro n A B x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.add_mulVec A B x

theorem matrix_vector_subtraction : CleanStatements.matrix_vector_subtraction := by
  intro n A x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_sub A x y

theorem matrix_subtraction_action : CleanStatements.matrix_subtraction_action := by
  intro n A B x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.sub_mulVec A B x

theorem matrix_scalar_action : CleanStatements.matrix_scalar_action := by
  intro n A x c
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.mulVec_smul A c x

theorem transpose_involution : CleanStatements.transpose_involution := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.transpose_transpose A

theorem transpose_product : CleanStatements.transpose_product := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.transpose_mul A B

theorem adjacency_symmetry : CleanStatements.adjacency_symmetry := by
  intro n G u v edge
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.adj_symm edge

theorem adjacency_commutes : CleanStatements.adjacency_commutes := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.adj_comm u v

theorem no_self_edges : CleanStatements.no_self_edges := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.irrefl

theorem adjacent_vertices_distinct : CleanStatements.adjacent_vertices_distinct := by
  intro n G u v edge
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.ne_of_adj edge

theorem union_adjacency : CleanStatements.union_adjacency := by
  intro n G H u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.sup_adj G H u v

theorem intersection_adjacency : CleanStatements.intersection_adjacency := by
  intro n G H u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.inf_adj G H u v

theorem complement_adjacency : CleanStatements.complement_adjacency := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.compl_adj G u v

theorem support_monotonicity : CleanStatements.support_monotonicity := by
  intro n G H inclusion
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.support_mono inclusion

theorem neighbors_in_support : CleanStatements.neighbors_in_support := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.neighborSet_subset_support u

theorem neighbor_membership : CleanStatements.neighbor_membership := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.mem_neighborSet u v

theorem not_own_neighbor : CleanStatements.not_own_neighbor := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.notMem_neighborSet_self

theorem common_neighbors_intersection : CleanStatements.common_neighbors_intersection := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_eq u v

theorem common_neighbors_membership : CleanStatements.common_neighbors_membership := by
  intro n G u v w
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.mem_commonNeighbors

theorem common_neighbors_symmetry : CleanStatements.common_neighbors_symmetry := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_symm u v

theorem common_neighbors_left : CleanStatements.common_neighbors_left := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_subset_neighborSet_left u v

theorem common_neighbors_right : CleanStatements.common_neighbors_right := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.commonNeighbors_subset_neighborSet_right u v

theorem reachability_reflexive : CleanStatements.reachability_reflexive := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.Reachable.refl u

theorem reachability_symmetric : CleanStatements.reachability_symmetric := by
  intro n G u v path
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact path.symm

theorem reachability_transitive : CleanStatements.reachability_transitive := by
  intro n G u v w first second
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact first.trans second

theorem edge_implies_reachability : CleanStatements.edge_implies_reachability := by
  intro n G u v edge
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact edge.reachable

theorem exponential_positive : CleanStatements.exponential_positive := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_pos x

theorem exponential_nonzero : CleanStatements.exponential_nonzero := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_ne_zero x

theorem exponential_sum : CleanStatements.exponential_sum := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_add x y

theorem exponential_difference : CleanStatements.exponential_difference := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_sub x y

theorem logarithm_exponential : CleanStatements.logarithm_exponential := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.log_exp x

theorem exponential_logarithm : CleanStatements.exponential_logarithm := by
  intro x positive
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.exp_log positive

theorem logarithm_product : CleanStatements.logarithm_product := by
  intro x y nonzero_x nonzero_y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.log_mul nonzero_x nonzero_y

theorem logarithm_quotient : CleanStatements.logarithm_quotient := by
  intro x y nonzero_x nonzero_y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.log_div nonzero_x nonzero_y

theorem square_root_nonnegative : CleanStatements.square_root_nonnegative := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_nonneg x

theorem square_of_square_root : CleanStatements.square_of_square_root := by
  intro x nonnegative
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sq_sqrt nonnegative

theorem square_root_of_square : CleanStatements.square_root_of_square := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_sq_eq_abs x

theorem square_root_product : CleanStatements.square_root_product := by
  intro x y nonnegative
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_mul nonnegative y

theorem trigonometric_identity : CleanStatements.trigonometric_identity := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_sq_add_cos_sq x

theorem sine_addition : CleanStatements.sine_addition := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_add x y

theorem cosine_addition : CleanStatements.cosine_addition := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.cos_add x y

theorem sine_odd : CleanStatements.sine_odd := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_neg x

theorem cosine_even : CleanStatements.cosine_even := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.cos_neg x

theorem continuous_composition : CleanStatements.continuous_composition := by
  intro f g hf hg
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hf.comp hg

theorem continuous_sum : CleanStatements.continuous_sum := by
  intro f g hf hg
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hf.add hg

theorem continuous_product : CleanStatements.continuous_product := by
  intro f g hf hg
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hf.mul hg

theorem insertion_sort_sorted : CleanStatements.insertion_sort_sorted := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sorted_insertionSort (· ≤ ·) xs

theorem insertion_sort_permutation : CleanStatements.insertion_sort_permutation := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.perm_insertionSort (· ≤ ·) xs

theorem insertion_sort_length : CleanStatements.insertion_sort_length := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.length_insertionSort (· ≤ ·) xs

theorem insertion_sort_membership : CleanStatements.insertion_sort_membership := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mem_insertionSort (r := (· ≤ ·))

theorem sorted_input_unchanged : CleanStatements.sorted_input_unchanged := by
  intro xs ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact ordered.insertionSort_eq

theorem ordered_insert_length : CleanStatements.ordered_insert_length := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.orderedInsert_length (· ≤ ·) xs a

theorem ordered_insert_membership : CleanStatements.ordered_insert_membership := by
  intro xs a b
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mem_orderedInsert (· ≤ ·)

theorem ordered_insert_permutation : CleanStatements.ordered_insert_permutation := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.perm_orderedInsert (· ≤ ·) a xs

theorem ordered_insert_preserves_sortedness : CleanStatements.ordered_insert_preserves_sortedness := by
  intro xs a ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact ordered.orderedInsert a xs

theorem merge_sort_sorted : CleanStatements.merge_sort_sorted := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sorted_mergeSort' (· ≤ ·) xs

theorem merge_sort_sorted_input : CleanStatements.merge_sort_sorted_input := by
  intro xs ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mergeSort_eq_self (r := (· ≤ ·)) ordered

theorem sorting_algorithms_agree : CleanStatements.sorting_algorithms_agree := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.mergeSort_eq_insertionSort (r := (· ≤ ·)) xs

theorem merge_preserves_sortedness : CleanStatements.merge_preserves_sortedness := by
  intro xs ys hx hy
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact hx.merge hy

theorem insertion_sort_subsequence : CleanStatements.insertion_sort_subsequence := by
  intro xs ys ordered subsequence
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sublist_insertionSort ordered subsequence

theorem ordered_insert_contains_input : CleanStatements.ordered_insert_contains_input := by
  intro xs a
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact List.sublist_orderedInsert (r := (· ≤ ·)) a xs

theorem euclidean_coprime_reduction : CleanStatements.euclidean_coprime_reduction := by
  intro a b k
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.coprime_add_mul_right_right a b k

theorem euclidean_coprime_subtraction : CleanStatements.euclidean_coprime_subtraction := by
  intro a b ordered
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.coprime_sub_self_left ordered

theorem coprime_lcm_product : CleanStatements.coprime_lcm_product := by
  intro a b cop
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.Coprime.lcm_eq_mul cop

theorem common_divisor_of_coprimes : CleanStatements.common_divisor_of_coprimes := by
  intro a b k cop divides_a divides_b
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.eq_one_of_dvd_coprimes cop divides_a divides_b

theorem coprime_product_divisibility : CleanStatements.coprime_product_divisibility := by
  intro a b k cop
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Nat.Coprime.dvd_mul_right cop

theorem trace_commutator : CleanStatements.trace_commutator := by
  intro n A B
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact by change Matrix.trace (A*B-B*A) = 0; rw [Matrix.trace_sub, Matrix.trace_mul_comm A B, sub_self]

theorem trace_matrix_square : CleanStatements.trace_matrix_square := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact rfl

theorem determinant_matrix_square : CleanStatements.determinant_matrix_square := by
  intro n A
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Matrix.det_mul A A

theorem authored_square_root : CleanStatements.authored_square_root := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_sq_eq_abs x

theorem authored_trigonometric_energy : CleanStatements.authored_trigonometric_energy := by
  intro x
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sin_sq_add_cos_sq x

theorem distance_square_root : CleanStatements.distance_square_root := by
  intro x y
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact Real.sqrt_sq_eq_abs (x-y)

theorem nonadjacency_symmetry : CleanStatements.nonadjacency_symmetry := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact not_congr (G.adj_comm u v)

theorem nonadjacency_reflexive : CleanStatements.nonadjacency_reflexive := by
  intro n G u
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact G.irrefl

theorem complement_from_nonadjacency : CleanStatements.complement_from_nonadjacency := by
  intro n G u v
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact SimpleGraph.compl_adj G u v

theorem insertion_sort_certificate : CleanStatements.insertion_sort_certificate := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact And.intro (List.sorted_insertionSort (· ≤ ·) xs) (List.perm_insertionSort (· ≤ ·) xs)

theorem merge_sort_certificate : CleanStatements.merge_sort_certificate := by
  intro xs
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact by change List.Sorted (· ≤ ·) (xs.mergeSort (· ≤ ·)) ∧ List.Perm (xs.mergeSort (· ≤ ·)) xs; rw [List.mergeSort_eq_insertionSort]; exact And.intro (List.sorted_insertionSort (· ≤ ·) xs) (List.perm_insertionSort (· ≤ ·) xs)

theorem certified_sort_unchanged : CleanStatements.certified_sort_unchanged := by
  intro xs ys certificate
  try simp only [cleanNumeral_Natural_47460cb427d00c0cfbad, cleanNumeral_Real_1f10813a9ce4dc61fe3e, cleanNumeral_Complex_311fd057b7f2e2b599a3, Nat.cast_zero, Nat.cast_one] at *
  exact certificate.1.insertionSort_eq

end CleanValidation

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
