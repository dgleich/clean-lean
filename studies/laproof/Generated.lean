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

noncomputable def cleanNotation_forward_94c6b5d5b541da8e9cb5   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_backward_28a8b5535c542d09170e   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_pair_0a8ba661224038ed4ecb {«T» : Type} («x» : «T») («y» : «T») : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  [x,y]

noncomputable def cleanNotation_repeat_f6644c95007d13fc4957 {«T» : Type} («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («x» : «T») : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  List.replicate m x

noncomputable def cleanNotation_choices_de9e985f61b7d03b4376 {«T» : Type} («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  xs.sections

noncomputable def cleanNotation_map_a63f530197a7b967e3d2 {«T» : Type} {«U» : Type} («f» : («T») → («U»)) («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («U»)) :=
  xs.map f

noncomputable def cleanNotation_filter_5f42cd9f8077977b98cf {«T» : Type} («p» : («T») → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  by classical exact xs.filter (fun x => decide (p x))

noncomputable def cleanNotation_choose_2909d7430001e85589d8 {«T» : Type} («b» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) («x» : «T») («y» : «T») : «T» :=
  if b then x else y

noncomputable def cleanNotation_count_4ca5cd0bc19cdd22c656  («b» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) («w» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  w.count b

noncomputable def cleanNotation_real_index_a39eb5faf62e8f339775  («k» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (k : ℝ)

noncomputable def cleanNotation_sum_matrices_78d41d3c03679876290b {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  xs.sum

noncomputable def cleanNotation_ordered_product_0b41e404f360dfb3abcd {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («xs» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  xs.prod

noncomputable def cleanNotation_sum_before_cc2e1bb4aaa6e44466ee {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («f» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  ∑ k ∈ Finset.range m, f k

noncomputable def cleanNotation_sum_vertices_78a740a52933f325773b {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («f» : ((_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  ∑ i, f i

noncomputable def cleanNotation_entry_503fef73aa1693078623 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («i» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) («j» : (_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  A i j

noncomputable def cleanNotation_diagonal_cdb343423f893c208d7c {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («f» : ((_root_.cleanType_Vertex_456780e707fa756f8a5f («n»))) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  Matrix.diagonal f

noncomputable def cleanNotation_pi_8c606dbc64fcc10745ac   : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  Real.pi

noncomputable def cleanNotation_imaginary_unit_05e55a37796708ddfa4a   : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Complex.I

noncomputable def cleanNotation_complex_scalar_09b455c59011e90246fd  («x» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  (x : ℂ)

noncomputable def cleanNotation_complex_exponential_5c3581fd8eb7176e7a23  («z» : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)) : (_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d) :=
  Complex.exp z

noncomputable def cleanNotation_complex_matrix_ddae0599d92be9b303c9 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d))) :=
  Complex.ofRealHom.mapMatrix A

noncomputable def cleanNotation_real_transpose_3c819735bd832ccb8180 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («A» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  A.transpose

noncomputable def cleanDefine_Hermitian_d3b88a5611f50ecbbbe8 {«n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)} («M» : (_root_.cleanType_Matrix_4518cbfc13ff70fc0769 («n») («n») ((_root_.cleanType_Complex_2d7f06a08f8ab1e3f46d)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  M.IsHermitian

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

noncomputable def cleanNotation_zip_with_b261e8a9f6d3555403b3 {«T» : Type} {«U» : Type} {«V» : Type} («f» : («T») → ((«U») → («V»))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («U»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («V»)) :=
  List.zipWith f x y

noncomputable def cleanNotation_fold_left_fbcf562c7ce929a5fa73 {«T» : Type} {«U» : Type} («f» : («U») → ((«T») → («U»))) («z» : «U») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : «U» :=
  List.foldl f z x

noncomputable def cleanNotation_fold_right_6b4cba4fcebe718c9f5f {«T» : Type} {«U» : Type} («f» : («T») → ((«U») → («U»))) («z» : «U») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : «U» :=
  List.foldr f z x

noncomputable def cleanNotation_list_transpose_e240403d7be5e3142a49 {«T» : Type} («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  List.transpose A

noncomputable def cleanDefine_accumulated_rounding_c3080a4d4288fa925928  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_difference_285267f55ec36308c915 ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) («u»))) («n»))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))))

noncomputable def cleanDefine_accumulated_underflow_0118c493aae6368ff1c3  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_real_index_a39eb5faf62e8f339775 («n»))) («eta»))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((_root_.cleanDefine_accumulated_rounding_c3080a4d4288fa925928 («u») («m»))))))

noncomputable def cleanDefine_unit_roundoff_3e9bdda856ce46d5e331  («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) («p»))))

noncomputable def cleanDefine_underflow_bound_ff4c1af9e7715aa4dfb3  («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («e» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 4))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) («e»))) ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) («p»))))))

noncomputable def cleanDefine_dot_aebfc088f0574c573951 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : «T» :=
  (_root_.cleanNotation_fold_left_fbcf562c7ce929a5fa73 («add») («z») ((_root_.cleanNotation_zip_with_b261e8a9f6d3555403b3 («mul») («x») («y»))))

noncomputable def cleanDefine_vector_sum_00d2381767894fe0c36c {«T» : Type} («add» : («T») → ((«T») → («T»))) («z» : «T») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : «T» :=
  (_root_.cleanNotation_fold_right_6b4cba4fcebe718c9f5f («add») («z») («x»))

noncomputable def cleanDefine_vector_add_5738ba9973ce3492d9a7 {«T» : Type} («add» : («T») → ((«T») → («T»))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanNotation_zip_with_b261e8a9f6d3555403b3 («add») («x») («y»))

noncomputable def cleanDefine_vector_scale_8bc437f57e2ba3ba3d79 {«T» : Type} («mul» : («T») → ((«T») → («T»))) («a» : «T») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((«mul» «a»)) («x»))

noncomputable def cleanDefine_vector_axpby_7edcfc35a8440b03cfc3 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («a» : «T») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («b» : «T») («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanDefine_vector_add_5738ba9973ce3492d9a7 («add») ((_root_.cleanDefine_vector_scale_8bc437f57e2ba3ba3d79 («mul») («a») («x»))) ((_root_.cleanDefine_vector_scale_8bc437f57e2ba3ba3d79 («mul») («b») («y»))))

noncomputable def cleanDefine_matrix_vector_ddc1f0ea872af3e4278d {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) => (_root_.cleanDefine_dot_aebfc088f0574c573951 («add») («mul») («z») (clean_bound_0) («x»)))) («A»))

noncomputable def cleanDefine_scaled_matrix_vector_318af5442e1393aa9254 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («a» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanDefine_vector_scale_8bc437f57e2ba3ba3d79 («mul») («a») ((_root_.cleanDefine_matrix_vector_ddc1f0ea872af3e4278d («add») («mul») («z») («A») («x»))))

noncomputable def cleanDefine_general_matrix_vector_8abce1fa39d8f1be2f54 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («a» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («b» : «T») («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanDefine_vector_add_5738ba9973ce3492d9a7 («add») ((_root_.cleanDefine_scaled_matrix_vector_318af5442e1393aa9254 («add») («mul») («z») («a») («A») («x»))) ((_root_.cleanDefine_vector_scale_8bc437f57e2ba3ba3d79 («mul») («b») («y»))))

noncomputable def cleanDefine_matrix_scale_c4d07aab7a69e02349b5 {«T» : Type} («mul» : («T») → ((«T») → («T»))) («a» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) => (_root_.cleanDefine_vector_scale_8bc437f57e2ba3ba3d79 («mul») («a») (clean_bound_0)))) («A»))

noncomputable def cleanDefine_matrix_add_99c2ed1f4a90b8ff5788 {«T» : Type} («add» : («T») → ((«T») → («T»))) («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («B» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  (_root_.cleanNotation_zip_with_b261e8a9f6d3555403b3 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) => (fun (clean_bound_1 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) => (_root_.cleanDefine_vector_add_5738ba9973ce3492d9a7 («add») (clean_bound_0) (clean_bound_1))))) («A») («B»))

noncomputable def cleanDefine_matrix_product_b18cf1e5728391d329ad {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («B» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) => (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_1 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) => (_root_.cleanDefine_dot_aebfc088f0574c573951 («add») («mul») («z») (clean_bound_0) (clean_bound_1)))) ((_root_.cleanNotation_list_transpose_e240403d7be5e3142a49 («B»)))))) («A»))

noncomputable def cleanDefine_scaled_matrix_product_0484bc6b54cf1b1588e0 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («a» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («B» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  (_root_.cleanDefine_matrix_scale_c4d07aab7a69e02349b5 («mul») («a») ((_root_.cleanDefine_matrix_product_b18cf1e5728391d329ad («add») («mul») («z») («A») («B»))))

noncomputable def cleanDefine_matrix_axpby_baf55ce24b9b2fbe3736 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («a» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («b» : «T») («B» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  (_root_.cleanDefine_matrix_add_99c2ed1f4a90b8ff5788 («add») ((_root_.cleanDefine_matrix_scale_c4d07aab7a69e02349b5 («mul») («a») («A»))) ((_root_.cleanDefine_matrix_scale_c4d07aab7a69e02349b5 («mul») («b») («B»))))

noncomputable def cleanDefine_general_matrix_product_efc083d9be6c1b50bba6 {«T» : Type} («add» : («T») → ((«T») → («T»))) («mul» : («T») → ((«T») → («T»))) («z» : «T») («a» : «T») («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («X» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) («b» : «T») («Y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)))) :=
  (_root_.cleanDefine_matrix_axpby_baf55ce24b9b2fbe3736 («add») («mul») («a») ((_root_.cleanDefine_matrix_product_b18cf1e5728391d329ad («add») («mul») («z») («A») («X»))) («b») («Y»))

noncomputable def cleanDefine_fused_dot_55628d56e493416fa4b8 {«T» : Type} («fma» : («T») → ((«T») → ((«T») → («T»)))) («z» : «T») («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : «T» :=
  (_root_.cleanNotation_fold_left_fbcf562c7ce929a5fa73 ((fun (clean_bound_0 : «T») => (fun (clean_bound_1 : («T») → («T»)) => (clean_bound_1 clean_bound_0)))) («z») ((_root_.cleanNotation_zip_with_b261e8a9f6d3555403b3 ((fun (clean_bound_2 : «T») => (fun (clean_bound_3 : «T») => (fun (clean_bound_4 : «T») => (((«fma» clean_bound_2) clean_bound_3) clean_bound_4))))) («x») («y»))))

noncomputable def cleanDefine_exact_sum_1c110a6bcb39021c54fc  («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_vector_sum_00d2381767894fe0c36c ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 (clean_bound_0) (clean_bound_1))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) («x»))

noncomputable def cleanDefine_exact_dot_3e36d7a3e3b1f07ad850  («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_dot_aebfc088f0574c573951 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 (clean_bound_0) (clean_bound_1))))) ((fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_product_b72eaff9286ea0417a4b (clean_bound_2) (clean_bound_3))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) («x») («y»))

noncomputable def cleanDefine_absolute_product_sum_ef953305f8d14ece44ae  («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_exact_sum_1c110a6bcb39021c54fc ((_root_.cleanNotation_zip_with_b261e8a9f6d3555403b3 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b (clean_bound_0) (clean_bound_1))))))) («x») («y»))))

noncomputable def cleanDefine_vector_norm_one_3329a3b15f250a7826b9  («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanDefine_exact_sum_1c110a6bcb39021c54fc ((_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_0)))) («x»))))

noncomputable def cleanDefine_vector_norm_two_06da55bf27b16200ea9b  («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 ((_root_.cleanDefine_exact_dot_3e36d7a3e3b1f07ad850 («x») («x»))))

noncomputable def cleanDefine_floating_equivalence_0e582b3a9dbc696a19f7 {«T» : Type} («finite» : («T») → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) («value» : («T») → ((_root_.cleanType_Real_107b6641a486642ad8e1))) («x» : «T») («y» : «T») : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((«finite» «x»)) ((«finite» «y»)))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((«value» «x»)) ((«value» «y»)))))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_negation_9ec0af386428c726e6c3 ((«finite» «x»)))) ((_root_.cleanDefine_negation_9ec0af386428c726e6c3 ((«finite» «y»)))))))

noncomputable def cleanDefine_single_operation_error_984a1ef607104566feb6  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («exact» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («rounded» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («rounded») ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b («exact») ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (clean_bound_0))))) (clean_bound_1))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_0))) («u»))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_1))) («eta»))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b (clean_bound_0) (clean_bound_1))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))))))))

noncomputable def cleanDefine_forward_error_cb2695b8469478442a16  («exact» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («rounded» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 («exact») («rounded»))))

noncomputable def cleanNotation_list_length_5ccf8d62d4aa9c1491eb {«T» : Type} («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  List.length x

noncomputable def cleanDefine_all_entries_019136f9b600e27d2405 {«T» : Type} («p» : («T») → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Forall p x

noncomputable def cleanDefine_corresponding_entries_6505fb25492d3a093ab1 {«T» : Type} {«U» : Type} («p» : («T») → ((«U») → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35)))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («U»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  List.Forall₂ p x y

noncomputable def cleanDefine_relative_perturbation_be2916b6822c5f45fbf0  («bound» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_corresponding_entries_6505fb25492d3a093ab1 ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 (clean_bound_1) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b (clean_bound_0) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) (clean_bound_2))))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_2))) («bound»))))))))) («x») («y»))

noncomputable def cleanDefine_dot_accuracy_3fcce0e0bc76d4e9edb5  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («y»))))) ((@Exists ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (@Exists ((_root_.cleanType_Real_107b6641a486642ad8e1)) (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («r») ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanDefine_exact_dot_3e36d7a3e3b1f07ad850 (clean_bound_0) («y»))) (clean_bound_1))))) ((_root_.cleanDefine_relative_perturbation_be2916b6822c5f45fbf0 ((_root_.cleanDefine_accumulated_rounding_c3080a4d4288fa925928 («u») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))))) («x») (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_1))) ((_root_.cleanDefine_accumulated_underflow_0118c493aae6368ff1c3 («u») («eta») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))))))))))))))

noncomputable def cleanDefine_sum_accuracy_cd344b91d7abb4a13459  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@Exists ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («r») ((_root_.cleanDefine_exact_sum_1c110a6bcb39021c54fc (clean_bound_0))))) ((_root_.cleanDefine_relative_perturbation_be2916b6822c5f45fbf0 ((_root_.cleanDefine_accumulated_rounding_c3080a4d4288fa925928 («u») ((_root_.cleanNotation_natural_difference_6609b71b367dd02ce17a ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) («x») (clean_bound_0))))))

noncomputable def cleanDefine_exact_matrix_vector_62c620dddb6311085e8e  («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanDefine_matrix_vector_ddc1f0ea872af3e4278d ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 (clean_bound_0) (clean_bound_1))))) ((fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_product_b72eaff9286ea0417a4b (clean_bound_2) (clean_bound_3))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))) («A») («x»))

noncomputable def cleanDefine_entrywise_matrix_perturbation_3a13ef77ba5d4a77bb70  («bound» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) («E» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_corresponding_entries_6505fb25492d3a093ab1 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (fun (clean_bound_1 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_corresponding_entries_6505fb25492d3a093ab1 ((fun (clean_bound_2 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_3))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b («bound») ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_2))))))))) (clean_bound_0) (clean_bound_1))))) («A») («E»))

noncomputable def cleanDefine_matrix_vector_accuracy_ba6c4c06394780977d6b  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («r» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb (clean_bound_0))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»)))))) («A»))) ((@Exists ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) (fun (clean_bound_1 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) => (@Exists ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_2 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb (clean_bound_2))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («A»))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («r») ((_root_.cleanDefine_vector_add_5738ba9973ce3492d9a7 ((fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_4 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 (clean_bound_3) (clean_bound_4))))) ((_root_.cleanDefine_exact_matrix_vector_62c620dddb6311085e8e ((_root_.cleanDefine_matrix_add_99c2ed1f4a90b8ff5788 ((fun (clean_bound_5 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (fun (clean_bound_6 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 (clean_bound_5) (clean_bound_6))))) («A») (clean_bound_1))) («x»))) (clean_bound_2))))))) ((_root_.cleanDefine_entrywise_matrix_perturbation_3a13ef77ba5d4a77bb70 ((_root_.cleanDefine_accumulated_rounding_c3080a4d4288fa925928 («u») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))))) («A») (clean_bound_1))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_7 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_7))) ((_root_.cleanDefine_accumulated_underflow_0118c493aae6368ff1c3 («u») («eta») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»)))))))) (clean_bound_2))))))))))

noncomputable def cleanDefine_safe_entry_bound_1b89adeb201bcb015858  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («e» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_sqrt_4669b969cc53105aa1d0 ((_root_.cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((_root_.cleanNotation_real_quotient_041fa3fe3b0d5c81fa8a ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) («e»))) («eta»))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) («u»))))) ((_root_.cleanDefine_accumulated_underflow_0118c493aae6368ff1c3 («u») («eta») («n») ((_root_.cleanNotation_natural_difference_6609b71b367dd02ce17a («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanNotation_real_index_a39eb5faf62e8f339775 («n»))) ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 1))) («u»))) («n»))))))))))

noncomputable def cleanDefine_safe_matrix_vector_input_2cdde56159b9b57bb243  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («e» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («A» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))))) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanDefine_accumulated_underflow_0118c493aae6368ff1c3 («u») («eta») ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))))) ((_root_.cleanNotation_real_power_9499d8cf3f4010c81d2a ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 2))) («e»))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_0 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb (clean_bound_0))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»)))))) («A»))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_1 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_1))) ((_root_.cleanDefine_safe_entry_bound_1b89adeb201bcb015858 («u») («eta») («e») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»)))))))) («x»))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_2 : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_3 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 (clean_bound_3))) ((_root_.cleanDefine_safe_entry_bound_1b89adeb201bcb015858 («u») («eta») («e») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»)))))))) (clean_bound_2)))) («A»))))

noncomputable def cleanDefine_dot_forward_accuracy_c3f1bdad57a19680a8e0  («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («y» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Real_107b6641a486642ad8e1)))) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_abs_c8dbf9dcdd1aa0b57353 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 («r») ((_root_.cleanDefine_exact_dot_3e36d7a3e3b1f07ad850 («x») («y»))))))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((_root_.cleanNotation_real_product_b72eaff9286ea0417a4b ((_root_.cleanDefine_absolute_product_sum_ef953305f8d14ece44ae («x») («y»))) ((_root_.cleanDefine_accumulated_rounding_c3080a4d4288fa925928 («u») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))))))) ((_root_.cleanDefine_accumulated_underflow_0118c493aae6368ff1c3 («u») («eta») ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb («x»))))))))

noncomputable def cleanNotation_initial_indices_d786a8d9dcb075559d19  («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  List.range n

noncomputable def cleanNotation_list_entry_6550a74ff7fa683bbbf5 {«T» : Type} («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («i» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («fallback» : «T») : «T» :=
  List.getD x i fallback

structure cleanStructure_CSR_185831cfc42c12daecca («T» : Type) : Type where
  «rows» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «columns» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «values» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))
  «indices» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))
  «pointers» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))

noncomputable def cleanConstructor_csr_storage_e33c2934dec2758b1e4f («T» : Type) («rows» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («columns» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («values» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («indices» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) («pointers» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246)))) : _root_.cleanStructure_CSR_185831cfc42c12daecca («T») :=
  @_root_.cleanStructure_CSR_185831cfc42c12daecca.mk «T» «rows» «columns» «values» «indices» «pointers»

noncomputable def cleanDefine_row_start_ff3a7007a34d32a36f1c {«T» : Type} («C» : _root_.cleanStructure_CSR_185831cfc42c12daecca («T»)) («i» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Natural_469c53b6dafb7a218246) :=
  (_root_.cleanNotation_list_entry_6550a74ff7fa683bbbf5 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«pointers» («T») («C»))) («i») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))

noncomputable def cleanDefine_row_positions_dba00aa4446cc5a7d398 {«T» : Type} («C» : _root_.cleanStructure_CSR_185831cfc42c12daecca («T»)) («i» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 ((_root_.cleanType_Natural_469c53b6dafb7a218246))) :=
  (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») («i»))) (clean_bound_0)))) ((_root_.cleanNotation_initial_indices_d786a8d9dcb075559d19 ((_root_.cleanNotation_natural_difference_6609b71b367dd02ce17a ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («i») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») («i»))))))))

noncomputable def cleanDefine_valid_csr_0e838765f6e4b887b791 {«T» : Type} («C» : _root_.cleanStructure_CSR_185831cfc42c12daecca («T»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«pointers» («T») («C»))))) ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«rows» («T») («C»))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«indices» («T») («C»))))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«values» («T») («C»))))))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«rows» («T») («C»))))) ((_root_.cleanNotation_list_length_5ccf8d62d4aa9c1491eb ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«values» («T») («C»))))))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_natural_at_most_06515545afa0b9611d61 ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») (clean_bound_0))) ((_root_.cleanDefine_row_start_ff3a7007a34d32a36f1c («C») ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))))))) ((_root_.cleanNotation_initial_indices_d786a8d9dcb075559d19 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«rows» («T») («C»))))))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_natural_less_d52c2ea999690096a5ff (clean_bound_1) ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«columns» («T») («C»)))))) ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«indices» («T») («C»))))))) ((_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_2 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_3 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_all_entries_019136f9b600e27d2405 ((fun (clean_bound_4 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_implication_9ee60e270a27b91f2307 ((_root_.cleanDefine_natural_less_d52c2ea999690096a5ff (clean_bound_3) (clean_bound_4))) ((_root_.cleanDefine_natural_less_d52c2ea999690096a5ff ((_root_.cleanNotation_list_entry_6550a74ff7fa683bbbf5 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«indices» («T») («C»))) (clean_bound_3) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) ((_root_.cleanNotation_list_entry_6550a74ff7fa683bbbf5 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«indices» («T») («C»))) (clean_bound_4) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)))))))))) ((_root_.cleanDefine_row_positions_dba00aa4446cc5a7d398 («C») (clean_bound_2)))))) ((_root_.cleanDefine_row_positions_dba00aa4446cc5a7d398 («C») (clean_bound_2)))))) ((_root_.cleanNotation_initial_indices_d786a8d9dcb075559d19 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«rows» («T») («C»))))))))

noncomputable def cleanDefine_csr_row_740facf7a5b5853f335a {«T» : Type} («fma» : («T») → ((«T») → ((«T») → («T»)))) («z» : «T») («C» : _root_.cleanStructure_CSR_185831cfc42c12daecca («T»)) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) («i» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : «T» :=
  (_root_.cleanNotation_fold_left_fbcf562c7ce929a5fa73 ((fun (clean_bound_0 : «T») => (fun (clean_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (((«fma» (_root_.cleanNotation_list_entry_6550a74ff7fa683bbbf5 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«values» («T») («C»))) (clean_bound_1) («z»))) (_root_.cleanNotation_list_entry_6550a74ff7fa683bbbf5 («x») ((_root_.cleanNotation_list_entry_6550a74ff7fa683bbbf5 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«indices» («T») («C»))) (clean_bound_1) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) («z»))) clean_bound_0)))) («z») ((_root_.cleanDefine_row_positions_dba00aa4446cc5a7d398 («C») («i»))))

noncomputable def cleanDefine_csr_product_498046b006405e3f900f {«T» : Type} («fma» : («T») → ((«T») → ((«T») → («T»)))) («z» : «T») («C» : _root_.cleanStructure_CSR_185831cfc42c12daecca («T»)) («x» : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»))) : (_root_.cleanType_List_b7361ff4f5869f86d7f2 («T»)) :=
  (_root_.cleanNotation_map_a63f530197a7b967e3d2 ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (_root_.cleanDefine_csr_row_740facf7a5b5853f335a («fma») («z») («C») («x») (clean_bound_0)))) ((_root_.cleanNotation_initial_indices_d786a8d9dcb075559d19 ((@_root_.cleanStructure_CSR_185831cfc42c12daecca.«rows» («T») («C»))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
LAProof in Clean: an executable companion in progress.
Source: Kellison, Appel, Tekriwal and Bindel, LAProof (2023).
This document is an original adaptation. See README.md for source locations,
interpretation decisions, and a section-by-section completion checklist.
-/

/-!
Arithmetic models.
The imported definitions make traversal order and empty accumulators explicit.
Arithmetic callbacks describe algorithms; they do not establish IEEE behavior.
-/

/-!
Numerical accuracy.
Named conditions describe perturbations, residuals, and entry bounds.
Defining a conclusion does not prove that floating arithmetic satisfies it.
-/

/-!
Sparse storage and computation.
The CSR model separates storage validity from the pure row computation.
A C correctness proof additionally requires a memory and execution model.
-/

/-!
Checked supporting results.
We restate the two zero-case statements in Foundations.clean. Verified.lean proves them
and five agreement lemmas. These are not the four numbered paper theorems.
-/

/--
source: laproof
reference: equation 4
relationship: adapted
-/
def «no_accumulated_rounding_at_zero» : Prop :=
  ∀ («u» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanDefine_accumulated_rounding_c3080a4d4288fa925928 («u») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))

/--
source: laproof
reference: equation 5
relationship: adapted
-/
def «no_accumulated_underflow_at_zero» : Prop :=
  ∀ («u» «eta» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («m» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((_root_.cleanDefine_accumulated_underflow_0118c493aae6368ff1c3 («u») («eta») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))) («m»))) ((_root_.cleanNumeral_Real_1f10813a9ce4dc61fe3e (nat_lit 0))))

/-!
Remaining paper results.
Paper.clean.proposed records the numbered theorem targets and the FMA target.
Its missing IEEE754 dependency is intentional and is not imported here.
IEEE semantics, numerical proofs, dense/sparse equivalence, and C correctness
remain completion obligations. This entry point checks only the implemented slice.
-/

end CleanStatements

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
