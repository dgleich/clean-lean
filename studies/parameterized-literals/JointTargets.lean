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

structure cleanStructure_PayloadHolder_01eca948063760ce3f49  : Type where
  «marker» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «payload» : _root_.cleanStructure_Payload_fb006548d81e980b3c12

noncomputable def cleanConstructor_payload_holder_6b160ea0a9522140d75e («marker» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («payload» : _root_.cleanStructure_Payload_fb006548d81e980b3c12) : _root_.cleanStructure_PayloadHolder_01eca948063760ce3f49 :=
  @_root_.cleanStructure_PayloadHolder_01eca948063760ce3f49.mk «marker» «payload»

structure cleanStructure_PaddedHolder_84883ed1d0d27e951945 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «marker» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «cell» : _root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n»)

noncomputable def cleanConstructor_padded_holder_b8c10e3905425f570d48 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («marker» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («cell» : _root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n»)) : _root_.cleanStructure_PaddedHolder_84883ed1d0d27e951945 («n») :=
  @_root_.cleanStructure_PaddedHolder_84883ed1d0d27e951945.mk «n» «marker» «cell»

structure cleanStructure_GenericCell_de7494ea478329f84f6e («T» : Type) : Type where
  «data» : «T»

noncomputable def cleanConstructor_generic_cell_ad871f450e8157eba59e («T» : Type) («data» : «T») : _root_.cleanStructure_GenericCell_de7494ea478329f84f6e («T») :=
  @_root_.cleanStructure_GenericCell_de7494ea478329f84f6e.mk «T» «data»

structure cleanStructure_GenericHolder_d88746e001eb134fd0d7  : Type where
  «marker» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «cell» : _root_.cleanStructure_GenericCell_de7494ea478329f84f6e ((_root_.cleanType_Real_107b6641a486642ad8e1))

noncomputable def cleanConstructor_generic_holder_7ffb14ed66b48a9b7d2f («marker» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («cell» : _root_.cleanStructure_GenericCell_de7494ea478329f84f6e ((_root_.cleanType_Real_107b6641a486642ad8e1))) : _root_.cleanStructure_GenericHolder_d88746e001eb134fd0d7 :=
  @_root_.cleanStructure_GenericHolder_d88746e001eb134fd0d7.mk «marker» «cell»

noncomputable def cleanDefine_vector_count_00ecd8c9844201a439bd  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  «n»

noncomputable def cleanNotation_vector_extent_f9607c8ca9391aa99b30  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  n

noncomputable def cleanDefine_shared_vector_count_63422c446eefbcd4ab65 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  «n»

noncomputable def cleanDefine_dependent_copy_6a2a92a4345c764da6d1  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 («n») («x»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 («n») («x»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  «y»

structure cleanStructure_DependentPayload_4da9794bc9d038b27dd2 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «input» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))
  «output» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 («n») («input»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))

noncomputable def cleanConstructor_dependent_payload_8c5da5dfcfa516434dad («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («input» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) («output» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 («n») («input»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_DependentPayload_4da9794bc9d038b27dd2 («n») :=
  @_root_.cleanStructure_DependentPayload_4da9794bc9d038b27dd2.mk «n» «input» «output»

noncomputable def cleanNotation_make_padded_cell_e9e33cd97cb0772b14f0  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf («n») :=
  cleanConstructor_padded_cell_5ccc731b1064afbc4e96 n data

noncomputable def cleanNotation_shifted_66a78a420aa379038b52  («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («m») ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («m») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  fun _ _ => (0 : Complex)

noncomputable def cleanDefine_shifted_size_93b37437cf14da76d128  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  «n»

noncomputable abbrev cleanType_Small_1783dae1e02581b79538  : Type 1 :=
  Type

noncomputable def cleanNotation_carrier_extent_3bb270212568b13b01b0  («T» : Type) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  2

noncomputable def cleanDefine_typed_vector_078c4e2172358acbbe77 {«T» : Type} («x» : «T») («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  «y»

noncomputable def cleanNotation_small_extent_52e2b4bc6b506a129e4b  («T» : Type) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  2

noncomputable def cleanDefine_small_vector_f55f5d4e09f3cb5ba45e {«T» : Type} («x» : «T») («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_small_extent_52e2b4bc6b506a129e4b («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_small_extent_52e2b4bc6b506a129e4b («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  «y»

noncomputable def cleanDefine_explicit_vector_a514ab06aae994dfb20b  («T» : Type) («x» : «T») («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  «y»

noncomputable def cleanDefine_explicit_small_vector_fd18ce9a3d4df15e275c  («T» : Type) («x» : «T») («y» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_small_extent_52e2b4bc6b506a129e4b («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_small_extent_52e2b4bc6b506a129e4b («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  «y»

structure cleanStructure_TypedPayload_8ff15373d5869669aa91 («T» : Type) : Type where
  «data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))

noncomputable def cleanConstructor_typed_payload_861622886b290b49caa6 («T» : Type) («data» : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 («T»))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : _root_.cleanStructure_TypedPayload_8ff15373d5869669aa91 («T») :=
  @_root_.cleanStructure_TypedPayload_8ff15373d5869669aa91.mk «T» «data»

structure cleanStructure_MapHolder_37c7a0e85553b079b256 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «map» : ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) → ((_root_.cleanType_Real_107b6641a486642ad8e1))

noncomputable def cleanConstructor_ordinary_holder_e9558fc0b07b356deb20 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («map» : ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : _root_.cleanStructure_MapHolder_37c7a0e85553b079b256 («n») :=
  @_root_.cleanStructure_MapHolder_37c7a0e85553b079b256.mk «n» «map»

structure cleanStructure_DependentMapHolder_7829492f0231f9bf0401 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : Type where
  «map» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_pi_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))))

noncomputable def cleanConstructor_dependent_holder_9b656f4e6dc113e795f5 («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («map» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_pi_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))))) : _root_.cleanStructure_DependentMapHolder_7829492f0231f9bf0401 («n») :=
  @_root_.cleanStructure_DependentMapHolder_7829492f0231f9bf0401.mk «n» «map»

noncomputable def cleanNotation_consume_dependent_f49a44b2e2418da0be18  («f» : (clean_pi_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_pi_bound_1) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))))) («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  x

noncomputable def cleanNotation_make_map_dabe59151c764f6fd203  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  fun _ => x

noncomputable def cleanNotation_make_dependent_0ab289a5e21e8e8743c5  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (clean_pi_bound_2 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 (clean_pi_bound_2) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) :=
  fun _ _ => (0 : Complex)

noncomputable def cleanNotation_make_shifted_dependent_c7457e9ae9dbd5c757a0  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (clean_pi_bound_3 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_pi_bound_3) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) :=
  fun _ _ => (0 : Complex)

noncomputable def cleanNotation_opaque_count_4efa8df9a3534f27979e {«T» : Type} («item» : «T») : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  0


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


noncomputable def actualKnownConstructor0 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))
noncomputable def expectedKnownConstructor0 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualKnownConstructor0 expectedKnownConstructor0
theorem meaningKnownConstructor0 : actualKnownConstructor0 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualKnownConstructor1 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))
noncomputable def expectedKnownConstructor1 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))
same_basic_target actualKnownConstructor1 expectedKnownConstructor1
theorem meaningKnownConstructor1 : actualKnownConstructor1 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualKnownConstructor2 : cleanType_Real_107b6641a486642ad8e1 := (_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))
noncomputable def expectedKnownConstructor2 : cleanType_Real_107b6641a486642ad8e1 := cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1)
same_basic_target actualKnownConstructor2 expectedKnownConstructor2
theorem meaningKnownConstructor2 : actualKnownConstructor2 = (1 : Real) := by simp [actualKnownConstructor2, cleanNumeral_Real_1f10813a9ce4dc61fe3e]


noncomputable def actualCandidateValue0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (n) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedCandidateValue0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (n) := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_vector_count_00ecd8c9844201a439bd (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))
same_basic_target actualCandidateValue0 expectedCandidateValue0
theorem meaningCandidateValue0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  (actualCandidateValue0 n).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualCandidateValue1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))
noncomputable def expectedCandidateValue1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_vector_count_00ecd8c9844201a439bd (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
same_basic_target actualCandidateValue1 expectedCandidateValue1
theorem meaningCandidateValue1 (n : cleanType_Natural_469c53b6dafb7a218246) :
  (actualCandidateValue1 n).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualCandidateValue2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd ((@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))
noncomputable def expectedCandidateValue2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_vector_count_00ecd8c9844201a439bd (@cleanDefine_vector_count_00ecd8c9844201a439bd (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
same_basic_target actualCandidateValue2 expectedCandidateValue2
theorem meaningCandidateValue2 (n : cleanType_Natural_469c53b6dafb7a218246) :
  (actualCandidateValue2 n).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualOpaqueCandidate : cleanStructure_VectorCell_ea235d5395205122748e (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))))))
noncomputable def expectedOpaqueCandidate : cleanStructure_VectorCell_ea235d5395205122748e (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_vector_count_00ecd8c9844201a439bd (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))))
same_basic_target actualOpaqueCandidate expectedOpaqueCandidate
theorem meaningOpaqueCandidate : actualOpaqueCandidate.entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualImplicitCandidate0 (n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanStructure_VectorCell_ea235d5395205122748e n := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_shared_vector_count_63422c446eefbcd4ab65 (n) (x) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedImplicitCandidate0 (n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanStructure_VectorCell_ea235d5395205122748e n :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_shared_vector_count_63422c446eefbcd4ab65 n x (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualImplicitCandidate0 expectedImplicitCandidate0
theorem meaningImplicitCandidate0 (n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) :
  (actualImplicitCandidate0 n x).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualImplicitCandidate1 (n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanStructure_VectorCell_ea235d5395205122748e n := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd ((@_root_.cleanDefine_shared_vector_count_63422c446eefbcd4ab65 (n) (x) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedImplicitCandidate1 (n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanStructure_VectorCell_ea235d5395205122748e n :=
  @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_vector_count_00ecd8c9844201a439bd (@cleanDefine_shared_vector_count_63422c446eefbcd4ab65 n x (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualImplicitCandidate1 expectedImplicitCandidate1
theorem meaningImplicitCandidate1 (n : cleanType_Natural_469c53b6dafb7a218246) (x : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) :
  (actualImplicitCandidate1 n x).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDynamicFormal0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_dependent_copy_6a2a92a4345c764da6d1 (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))))))
noncomputable def expectedDynamicFormal0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanDefine_dependent_copy_6a2a92a4345c764da6d1 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
same_basic_target actualDynamicFormal0 expectedDynamicFormal0
theorem meaningDynamicFormal0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualDynamicFormal0 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDynamicFormal1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_dependent_copy_6a2a92a4345c764da6d1 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))))))))))
noncomputable def expectedDynamicFormal1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanDefine_dependent_copy_6a2a92a4345c764da6d1 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))))
same_basic_target actualDynamicFormal1 expectedDynamicFormal1
theorem meaningDynamicFormal1 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualDynamicFormal1 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDynamicFormal2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))))
noncomputable def expectedDynamicFormal2 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_vector_extent_f9607c8ca9391aa99b30 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))
same_basic_target actualDynamicFormal2 expectedDynamicFormal2
theorem meaningDynamicFormal2 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualDynamicFormal2 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualOpaqueParameter : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanStructure_PaddedCell_160f6a93d8c1ee02afcf.«data» ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_make_padded_cell_e9e33cd97cb0772b14f0 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))))))
noncomputable def expectedOpaqueParameter : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanStructure_PaddedCell_160f6a93d8c1ee02afcf.data (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_make_padded_cell_e9e33cd97cb0772b14f0 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))
same_basic_target actualOpaqueParameter expectedOpaqueParameter
theorem meaningOpaqueParameter : actualOpaqueParameter = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualComputedLiteral0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Matrix_4518cbfc13ff70fc0769 n (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_shifted_66a78a420aa379038b52 (n))
noncomputable def expectedComputedLiteral0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Matrix_4518cbfc13ff70fc0769 n (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 n (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := @cleanNotation_shifted_66a78a420aa379038b52 n
same_basic_target actualComputedLiteral0 expectedComputedLiteral0
theorem meaningComputedLiteral0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualComputedLiteral0 n = (fun _ _ => (0 : Complex)) := by rfl


noncomputable def actualComputedLiteral1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e n := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((@_root_.cleanDefine_shifted_size_93b37437cf14da76d128 (n) ((@_root_.cleanNotation_shifted_66a78a420aa379038b52 (n))))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedComputedLiteral1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e n := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (@cleanDefine_shifted_size_93b37437cf14da76d128 n (@cleanNotation_shifted_66a78a420aa379038b52 n)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualComputedLiteral1 expectedComputedLiteral1
theorem meaningComputedLiteral1 (n : cleanType_Natural_469c53b6dafb7a218246) :
  (actualComputedLiteral1 n).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualUndemandedCall (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Natural_469c53b6dafb7a218246 := (@_root_.cleanDefine_vector_count_00ecd8c9844201a439bd (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n))))
noncomputable def expectedUndemandedCall (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Natural_469c53b6dafb7a218246 :=
  @cleanDefine_vector_count_00ecd8c9844201a439bd n (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualUndemandedCall expectedUndemandedCall
theorem meaningUndemandedCall (n : cleanType_Natural_469c53b6dafb7a218246) : actualUndemandedCall n = n := by rfl


noncomputable def actualClassifierIndex0_0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Natural_469c53b6dafb7a218246) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_typed_vector_078c4e2172358acbbe77 ((_root_.cleanType_Natural_469c53b6dafb7a218246)) (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))))))
noncomputable def expectedClassifierIndex0_0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Natural_469c53b6dafb7a218246) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanDefine_typed_vector_078c4e2172358acbbe77 cleanType_Natural_469c53b6dafb7a218246 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Natural_469c53b6dafb7a218246))
same_basic_target actualClassifierIndex0_0 expectedClassifierIndex0_0
theorem meaningClassifierIndex0_0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualClassifierIndex0_0 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualClassifierIndex0_1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Natural_469c53b6dafb7a218246) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_typed_vector_078c4e2172358acbbe77 ((_root_.cleanType_Natural_469c53b6dafb7a218246)) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))))))
noncomputable def expectedClassifierIndex0_1 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Natural_469c53b6dafb7a218246) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanDefine_typed_vector_078c4e2172358acbbe77 cleanType_Natural_469c53b6dafb7a218246 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Natural_469c53b6dafb7a218246))
same_basic_target actualClassifierIndex0_1 expectedClassifierIndex0_1
theorem meaningClassifierIndex0_1 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualClassifierIndex0_1 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualClassifierIndex1_0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_small_extent_52e2b4bc6b506a129e4b cleanType_Natural_469c53b6dafb7a218246) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_small_vector_f55f5d4e09f3cb5ba45e ((_root_.cleanType_Natural_469c53b6dafb7a218246)) (n) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_small_extent_52e2b4bc6b506a129e4b ((_root_.cleanType_Natural_469c53b6dafb7a218246)))))))
noncomputable def expectedClassifierIndex1_0 (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_small_extent_52e2b4bc6b506a129e4b cleanType_Natural_469c53b6dafb7a218246) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanDefine_small_vector_f55f5d4e09f3cb5ba45e cleanType_Natural_469c53b6dafb7a218246 (n) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_small_extent_52e2b4bc6b506a129e4b cleanType_Natural_469c53b6dafb7a218246))
same_basic_target actualClassifierIndex1_0 expectedClassifierIndex1_0
theorem meaningClassifierIndex1_0 (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualClassifierIndex1_0 n = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualExplicitCarrier0 : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Real_107b6641a486642ad8e1) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_explicit_vector_a514ab06aae994dfb20b ((_root_.cleanType_Real_107b6641a486642ad8e1)) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))))
noncomputable def expectedExplicitCarrier0 : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Real_107b6641a486642ad8e1) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanDefine_explicit_vector_a514ab06aae994dfb20b cleanType_Real_107b6641a486642ad8e1 (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Real_107b6641a486642ad8e1))
same_basic_target actualExplicitCarrier0 expectedExplicitCarrier0
theorem meaningExplicitCarrier0 : actualExplicitCarrier0 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualExplicitCarrier1 : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_small_extent_52e2b4bc6b506a129e4b cleanType_Real_107b6641a486642ad8e1) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanDefine_explicit_small_vector_fd18ce9a3d4df15e275c ((_root_.cleanType_Real_107b6641a486642ad8e1)) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_small_extent_52e2b4bc6b506a129e4b ((_root_.cleanType_Real_107b6641a486642ad8e1)))))))
noncomputable def expectedExplicitCarrier1 : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_small_extent_52e2b4bc6b506a129e4b cleanType_Real_107b6641a486642ad8e1) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanDefine_explicit_small_vector_fd18ce9a3d4df15e275c cleanType_Real_107b6641a486642ad8e1 (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_small_extent_52e2b4bc6b506a129e4b cleanType_Real_107b6641a486642ad8e1))
same_basic_target actualExplicitCarrier1 expectedExplicitCarrier1
theorem meaningExplicitCarrier1 : actualExplicitCarrier1 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualCarrierProjection : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Real_107b6641a486642ad8e1) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((@_root_.cleanNotation_carrier_extent_3bb270212568b13b01b0 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))
noncomputable def expectedCarrierProjection : cleanType_Vector_cce915f2d60cfd4f85a3 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Real_107b6641a486642ad8e1) cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (@cleanNotation_carrier_extent_3bb270212568b13b01b0 cleanType_Real_107b6641a486642ad8e1)
same_basic_target actualCarrierProjection expectedCarrierProjection
theorem meaningCarrierProjection : actualCarrierProjection = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualLocalCall0 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : cleanType_Function_bb05fd158cbe096d7b2f (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) cleanType_Real_107b6641a486642ad8e1) : cleanType_Real_107b6641a486642ad8e1 := (local_f (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))
noncomputable def expectedLocalCall0 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : cleanType_Function_bb05fd158cbe096d7b2f (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) cleanType_Real_107b6641a486642ad8e1) : cleanType_Real_107b6641a486642ad8e1 := local_f (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualLocalCall0 expectedLocalCall0
theorem meaningLocalCall0 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : cleanType_Function_bb05fd158cbe096d7b2f (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) cleanType_Real_107b6641a486642ad8e1) :
  actualLocalCall0 n local_f = local_f (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n) := by rfl


noncomputable def actualLocalCall1 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : (k : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 k (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (local_f (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
noncomputable def expectedLocalCall1 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : (k : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 k (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := local_f (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualLocalCall1 expectedLocalCall1
theorem meaningLocalCall1 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : (k : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 k (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d) :
  actualLocalCall1 n local_f = local_f (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := by rfl


noncomputable def actualLocalCall2 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : cleanType_Function_bb05fd158cbe096d7b2f (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (local_f (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)) := (@_root_.cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 ((local_f (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 ((local_f (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))))))
noncomputable def expectedLocalCall2 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : cleanType_Function_bb05fd158cbe096d7b2f (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) cleanType_Natural_469c53b6dafb7a218246) : cleanStructure_VectorCell_ea235d5395205122748e (local_f (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)) := @cleanConstructor_vector_cell_151a6d80e8e69e4d0b80 (local_f (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (local_f (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)))
same_basic_target actualLocalCall2 expectedLocalCall2
theorem meaningLocalCall2 (n : cleanType_Natural_469c53b6dafb7a218246) (local_f : cleanType_Function_bb05fd158cbe096d7b2f (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) cleanType_Natural_469c53b6dafb7a218246) :
  (actualLocalCall2 n local_f).entry = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualFieldApply0 (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_MapHolder_37c7a0e85553b079b256 n) : cleanType_Real_107b6641a486642ad8e1 := ((@_root_.cleanStructure_MapHolder_37c7a0e85553b079b256.«map» (n) (q)) (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))
noncomputable def expectedFieldApply0 (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_MapHolder_37c7a0e85553b079b256 n) : cleanType_Real_107b6641a486642ad8e1 := (@cleanStructure_MapHolder_37c7a0e85553b079b256.map n q) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualFieldApply0 expectedFieldApply0
theorem meaningFieldApply0 (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_MapHolder_37c7a0e85553b079b256 n) : actualFieldApply0 n q = (@cleanStructure_MapHolder_37c7a0e85553b079b256.map n q) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n) := by rfl


noncomputable def actualFieldApply1 (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_DependentMapHolder_7829492f0231f9bf0401 n) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := ((@_root_.cleanStructure_DependentMapHolder_7829492f0231f9bf0401.«map» (n) (q)) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
noncomputable def expectedFieldApply1 (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_DependentMapHolder_7829492f0231f9bf0401 n) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@cleanStructure_DependentMapHolder_7829492f0231f9bf0401.map n q) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualFieldApply1 expectedFieldApply1
theorem meaningFieldApply1 (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_DependentMapHolder_7829492f0231f9bf0401 n) : actualFieldApply1 n q = (@cleanStructure_DependentMapHolder_7829492f0231f9bf0401.map n q) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := by rfl


noncomputable def actualDependentArgument (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_DependentMapHolder_7829492f0231f9bf0401 n) : cleanType_Real_107b6641a486642ad8e1 := (@_root_.cleanNotation_consume_dependent_f49a44b2e2418da0be18 ((@_root_.cleanStructure_DependentMapHolder_7829492f0231f9bf0401.«map» (n) (q))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))
noncomputable def expectedDependentArgument (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_DependentMapHolder_7829492f0231f9bf0401 n) : cleanType_Real_107b6641a486642ad8e1 := @cleanNotation_consume_dependent_f49a44b2e2418da0be18 (@cleanStructure_DependentMapHolder_7829492f0231f9bf0401.map n q) (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))
same_basic_target actualDependentArgument expectedDependentArgument
theorem meaningDependentArgument (n : cleanType_Natural_469c53b6dafb7a218246) (q : cleanStructure_DependentMapHolder_7829492f0231f9bf0401 n) : actualDependentArgument n q = (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0)) := by rfl


noncomputable def actualInferredApply (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Real_107b6641a486642ad8e1 := ((@_root_.cleanNotation_make_map_dabe59151c764f6fd203 (n) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0)))) (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))
noncomputable def expectedInferredApply (n : cleanType_Natural_469c53b6dafb7a218246) : cleanType_Real_107b6641a486642ad8e1 := (@cleanNotation_make_map_dabe59151c764f6fd203 n (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualInferredApply expectedInferredApply
theorem meaningInferredApply (n : cleanType_Natural_469c53b6dafb7a218246) : actualInferredApply n = (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0)) := by rfl


noncomputable def actualDependentHead0 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := ((@_root_.cleanNotation_make_dependent_0ab289a5e21e8e8743c5 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0)))) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
noncomputable def expectedDependentHead0 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@cleanNotation_make_dependent_0ab289a5e21e8e8743c5 (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualDependentHead0 expectedDependentHead0
theorem meaningDependentHead0 : actualDependentHead0 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDependentHead1 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := ((@_root_.cleanNotation_make_shifted_dependent_c7457e9ae9dbd5c757a0 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0)))) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
noncomputable def expectedDependentHead1 : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (@cleanNotation_make_shifted_dependent_c7457e9ae9dbd5c757a0 (cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualDependentHead1 expectedDependentHead1
theorem meaningDependentHead1 : actualDependentHead1 = (fun _ => (0 : Complex)) := by rfl


noncomputable def actualDependentProjectionHead (callback : (j : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 j (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := (callback (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)))
noncomputable def expectedDependentProjectionHead (callback : (j : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 j (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d) : cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d := callback (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2))
same_basic_target actualDependentProjectionHead expectedDependentProjectionHead
theorem meaningDependentProjectionHead (callback : (j : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 (cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 j (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))) cleanType_Complex_2d7f06a08f8ab1e3f46d) : actualDependentProjectionHead callback = callback (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 2)) := by rfl


def actualQuantifiedZero (n : cleanType_Natural_469c53b6dafb7a218246) : Prop := (∀ (clean_bound_0 : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 (n) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))), (_root_.cleanDefine_unequal_37c577a540f8692ae5c3 (clean_bound_0) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (n)))))
def expectedQuantifiedZero (n : cleanType_Natural_469c53b6dafb7a218246) : Prop :=
  ∀ z : cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d, @cleanDefine_unequal_37c577a540f8692ae5c3 (cleanType_Vector_cce915f2d60cfd4f85a3 n cleanType_Complex_2d7f06a08f8ab1e3f46d) z (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 n)
same_basic_target actualQuantifiedZero expectedQuantifiedZero
theorem meaningQuantifiedZero (n : cleanType_Natural_469c53b6dafb7a218246) :
  actualQuantifiedZero n ↔ ∀ z : Fin n → Complex, z ≠ (fun _ => 0) := by rfl


def actualBoundDimension : Prop := (∀ (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)), (@Exists ((_root_.cleanType_Vector_cce915f2d60cfd4f85a3 (clean_bound_0) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) (fun (clean_bound_1 : (_root_.cleanType_Vector_cce915f2d60cfd4f85a3 (clean_bound_0) ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) => (_root_.cleanDefine_equal_5fac732a65dd209a83f4 (clean_bound_1) ((@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (clean_bound_0)))))))
def expectedBoundDimension : Prop :=
  ∀ k : cleanType_Natural_469c53b6dafb7a218246, @Exists (cleanType_Vector_cce915f2d60cfd4f85a3 k cleanType_Complex_2d7f06a08f8ab1e3f46d)
    (fun z => @cleanDefine_equal_5fac732a65dd209a83f4 (cleanType_Vector_cce915f2d60cfd4f85a3 k cleanType_Complex_2d7f06a08f8ab1e3f46d) z (@cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 k))
same_basic_target actualBoundDimension expectedBoundDimension
theorem meaningBoundDimension : actualBoundDimension := by
  intro k
  exact ⟨_, rfl⟩


noncomputable def actualDependentLambda : (k : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 k cleanType_Complex_2d7f06a08f8ab1e3f46d := (fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 (clean_bound_0)))
noncomputable def expectedDependentLambda : (k : cleanType_Natural_469c53b6dafb7a218246) → cleanType_Vector_cce915f2d60cfd4f85a3 k cleanType_Complex_2d7f06a08f8ab1e3f46d :=
  fun k => @cleanNotation_complex_vector_zero_638089e4cd5dbb1b07b5 k
same_basic_target actualDependentLambda expectedDependentLambda
theorem meaningDependentLambda (k : cleanType_Natural_469c53b6dafb7a218246) : actualDependentLambda k = (fun _ => (0 : Complex)) := by rfl


def actualScopedCarrier : Prop := (∀ (clean_bound_0 : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)), (∀ (clean_bound_1 : clean_bound_0), (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_opaque_count_4efa8df9a3534f27979e (clean_bound_1))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))))
def expectedScopedCarrier : Prop :=
  ∀ T : cleanType_Type_c1fed1af64ab6f12e0ed, ∀ item : T, @cleanDefine_equal_5fac732a65dd209a83f4 cleanType_Natural_469c53b6dafb7a218246 (@cleanNotation_opaque_count_4efa8df9a3534f27979e T item) (cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))
same_basic_target actualScopedCarrier expectedScopedCarrier
theorem meaningScopedCarrier : actualScopedCarrier := by
  intro T item
  rfl

-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
