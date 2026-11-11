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
import Mathlib.Algebra.Category.ModuleCat.Abelian
import Mathlib.Algebra.Category.ModuleCat.Colimits
import Mathlib.Algebra.Homology.HomologicalComplexAbelian
import Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex

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

noncomputable abbrev cleanType_FieldStructure_6c5b3bc7a67ff898144f («K» : Type) : Type :=
  Field K

noncomputable abbrev cleanType_AdditiveGroup_1556409a530614ea0933 («V» : Type) : Type :=
  AddCommGroup V

noncomputable abbrev cleanType_ModuleStructure_a454a0d138c91455b552 («K» : Type) («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («V» : Type) («a» : (_root_.cleanType_AdditiveGroup_1556409a530614ea0933 («V»))) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid

structure cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K» : Type) («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («V» : Type) : Type where
  «addition» : (_root_.cleanType_AdditiveGroup_1556409a530614ea0933 («V»))
  «action» : (_root_.cleanType_ModuleStructure_a454a0d138c91455b552 («K») («f») («V») («addition»))

noncomputable def cleanConstructor_linear_space_455c6502dabcaa361a4c («K» : Type) («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («V» : Type) («addition» : (_root_.cleanType_AdditiveGroup_1556409a530614ea0933 («V»))) («action» : (_root_.cleanType_ModuleStructure_a454a0d138c91455b552 («K») («f») («V») («addition»))) : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V») :=
  @_root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3.mk «K» «f» «V» «addition» «action»

noncomputable abbrev cleanType_Subspace_de9f5f97abff1220ced1 («K» : Type) («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («V» : Type) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V»)) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action

noncomputable def cleanNotation_subspace_carrier_852cee879d6fd417de92 {«K» : Type} {«V» : Type} («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V»)) («U» : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 («V»)) :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U

noncomputable def cleanDefine_belongs_to_subspace_87cbfb6be245657c79ec {«K» : Type} {«V» : Type} («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V»)) («x» : «V») («U» : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («x») ((@_root_.cleanNotation_subspace_carrier_852cee879d6fd417de92 («K») («V») («f») («L») («U»))))

noncomputable def cleanDefine_subspace_included_in_5db35c497bfe5b8c7a2f {«K» : Type} {«V» : Type} («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V»)) («U» : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»))) («W» : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : «V»), (_root_.cleanDefine_implication_9ee60e270a27b91f2307 ((@_root_.cleanDefine_belongs_to_subspace_87cbfb6be245657c79ec («K») («V») («f») («L») (clean_bound_0) («U»))) ((@_root_.cleanDefine_belongs_to_subspace_87cbfb6be245657c79ec («K») («V») («f») («L») (clean_bound_0) («W»)))))

noncomputable def cleanNotation_subspace_infimum_aad75e0f1149093c07a8 {«K» : Type} {«V» : Type} («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V»)) («spaces» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»))))) : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»)) :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) spaces

noncomputable def cleanDefine_intersection_of_subspaces_3a8e085ac9d23c354bab {«K» : Type} {«V» : Type} {«I» : Type} («f» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («f») («V»)) («A» : (_root_.cleanType_Set_182ba6b3273812add6f5 («I»))) («spaces» : («I») → ((_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»)))) : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»)) :=
  (@_root_.cleanNotation_subspace_infimum_aad75e0f1149093c07a8 («K») («V») («f») («L») ((_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Subspace_de9f5f97abff1220ced1 («K») («f») («V») («L»))) => (@Exists («I») (fun (clean_bound_1 : «I») => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d (clean_bound_1) («A»))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 (clean_bound_0) ((«spaces» clean_bound_1))))))))))))

noncomputable abbrev cleanType_CoefficientModule_cb06282c8e98b088950e («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) : Type 1 :=
  (@ModuleCat.{0,0} K field.toRing)

noncomputable abbrev cleanType_ModuleElement_8de1da3233066bdec3ce («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : Type :=
  (@ModuleCat.carrier K field.toRing M)

noncomputable def cleanNotation_coefficient_module_1e5d64f05b3a2ed1bd1d  («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («V» : Type) («L» : _root_.cleanStructure_LinearSpace_145d2e6b958d77aca9b3 («K») («field») («V»)) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  @ModuleCat.of K field.toRing V L.addition L.action

noncomputable abbrev cleanType_ModuleMap_cf75ef13ca99ba60b566 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : Type :=
  (@ModuleCat.Hom K field.toRing M N)

noncomputable abbrev cleanType_ModuleSubspace_b5c41d22ad632b2592f6 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : Type :=
  (@Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)

noncomputable def cleanNotation_module_map_value_708bb3c249e5e9e655eb {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) («x» : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («M»))) : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («N»)) :=
  (@ModuleCat.Hom.hom K field.toRing M N f) x

noncomputable def cleanNotation_module_map_range_fb14abc0eef46c0da96d {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) : (_root_.cleanType_ModuleSubspace_b5c41d22ad632b2592f6 («K») («field») («N»)) :=
  LinearMap.range (@ModuleCat.Hom.hom K field.toRing M N f)

noncomputable def cleanNotation_module_subspace_carrier_5966a70e2bb7bb7e2b14 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («U» : (_root_.cleanType_ModuleSubspace_b5c41d22ad632b2592f6 («K») («field») («M»))) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («M»)))) :=
  U.carrier

noncomputable def cleanDefine_belongs_to_module_subspace_08d4e7398c239036491b {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («x» : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («M»))) («U» : (_root_.cleanType_ModuleSubspace_b5c41d22ad632b2592f6 («K») («field») («M»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_member_e64b7ad19acfc0b8910d («x») ((@_root_.cleanNotation_module_subspace_carrier_5966a70e2bb7bb7e2b14 («K») («field») («M») («U»))))

noncomputable def cleanDefine_same_module_8e91cf6e9e2f13232742 {«K» : Type} {«field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))} («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  M = N

noncomputable abbrev cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) : Type 1 :=
  (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)

noncomputable abbrev cleanType_ChainMap_80ddfbec860449786302 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : Type :=
  (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)

noncomputable def cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»)) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel f)

noncomputable def cleanNotation_chain_cokernel_projection_409c758f935dcb8b23fd {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»)))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.π f)

noncomputable def cleanNotation_compose_chain_maps_cef6124157281682085f {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («g» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») («E»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («E»)) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.comp f g)

noncomputable def cleanNotation_zero_chain_map_accfad693693a946c3e6 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»)) :=
  (letI : Field K := field; 0)

noncomputable def cleanNotation_chain_homology_741de881939148c4d167 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).obj C)

noncomputable def cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («C») («n»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («n»)))) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).map f)

noncomputable def cleanDefine_same_chain_complex_f5feb7e2b6337ce50f75 {«K» : Type} {«field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))} («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  C = D

structure cleanStructure_GradedModule_76cc13b50fb929593cfb («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) : Type 1 where
  «component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)))

noncomputable def cleanConstructor_graded_module_66419f2272b65d4d8843 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)))) : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field») :=
  @_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.mk «K» «field» «component»

noncomputable def cleanDefine_component_module_cbc7c7dbd7330b329add {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  ((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) «p»)

structure cleanStructure_GradedMap_fa003d7326d860423bd3 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («N» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) : Type where
  «component» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_pi_bound_0)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («N»)) clean_pi_bound_0))))

noncomputable def cleanConstructor_graded_map_2b412279c2662521f367 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («N» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («component» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_pi_bound_0)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («N»)) clean_pi_bound_0))))) : _root_.cleanStructure_GradedMap_fa003d7326d860423bd3 («K») («field») («M») («N») :=
  @_root_.cleanStructure_GradedMap_fa003d7326d860423bd3.mk «K» «field» «M» «N» «component»

noncomputable def cleanNotation_module_identity_3cffa414133766d157c3 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («M»)) :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M

noncomputable def cleanNotation_module_composition_622cd851b0bc174c8369 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («P» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («N») («P»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («P»)) :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g

noncomputable def cleanDefine_graded_identity_14ecf57c9f9ff78f1900 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) : _root_.cleanStructure_GradedMap_fa003d7326d860423bd3 («K») («field») («M») («M») :=
  (@_root_.cleanConstructor_graded_map_2b412279c2662521f367 («K») («field») («M») («M») ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_identity_3cffa414133766d157c3 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_bound_0))))))

noncomputable def cleanDefine_graded_composition_e88df3d17a39ed63586f {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («N» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («P» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («f» : _root_.cleanStructure_GradedMap_fa003d7326d860423bd3 («K») («field») («M») («N»)) («g» : _root_.cleanStructure_GradedMap_fa003d7326d860423bd3 («K») («field») («N») («P»)) : _root_.cleanStructure_GradedMap_fa003d7326d860423bd3 («K») («field») («M») («P») :=
  (@_root_.cleanConstructor_graded_map_2b412279c2662521f367 («K») («field») («M») («P») ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («N»)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («P»)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_fa003d7326d860423bd3.«component» («K») («field») («M») («N») («f»)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_fa003d7326d860423bd3.«component» («K») («field») («N») («P») («g»)) clean_bound_0))))))

noncomputable def cleanNotation_identity_chain_map_7712ffbb97d12faffd0e {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («C»)) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.id C)

noncomputable def cleanDefine_graded_chain_homology_c645cddac66e4ea3e547  («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field») :=
  (@_root_.cleanConstructor_graded_module_66419f2272b65d4d8843 («K») («field») ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («C») (clean_bound_0)))))

noncomputable def cleanDefine_graded_chain_homology_map_34c867e216a203fecb05  («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) : _root_.cleanStructure_GradedMap_fa003d7326d860423bd3 («K») («field») ((@_root_.cleanDefine_graded_chain_homology_c645cddac66e4ea3e547 («K») («field») («C»))) ((@_root_.cleanDefine_graded_chain_homology_c645cddac66e4ea3e547 («K») («field») («D»))) :=
  (@_root_.cleanConstructor_graded_map_2b412279c2662521f367 («K») («field») ((@_root_.cleanDefine_graded_chain_homology_c645cddac66e4ea3e547 («K») («field») («C»))) ((@_root_.cleanDefine_graded_chain_homology_c645cddac66e4ea3e547 («K») («field») («D»))) ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») («C») («D») («f») (clean_bound_0)))))

noncomputable def cleanDefine_zero_chain_quotient_a00189717519ea1f14bf {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»)) :=
  (@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») ((@_root_.cleanNotation_zero_chain_map_accfad693693a946c3e6 («K») («field») («C») («D»))))

noncomputable def cleanDefine_zero_quotient_projection_56136da15b0ed1341a7f {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»)))) :=
  (@_root_.cleanNotation_chain_cokernel_projection_409c758f935dcb8b23fd («K») («field») («C») («D») ((@_root_.cleanNotation_zero_chain_map_accfad693693a946c3e6 («K») («field») («C») («D»))))

noncomputable def cleanNotation_zero_quotient_reduction_710bb82257389ba90ade {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («D»)) :=
  (letI : Field K := field; (CategoryTheory.Limits.cokernelZeroIsoTarget (X := C) (Y := D)).hom)

noncomputable def cleanDefine_zero_quotient_homology_forward_66db0133eebe06257127 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («p»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («p»)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («D») ((@_root_.cleanNotation_zero_quotient_reduction_710bb82257389ba90ade («K») («field») («C») («D»))) («p»))

noncomputable def cleanDefine_zero_quotient_homology_backward_2e4083f9d09a2c2f1112 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («p»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («p»)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») («D») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) ((@_root_.cleanDefine_zero_quotient_projection_56136da15b0ed1341a7f («K») («field») («C») («D»))) («p»))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: zero_quotient
reference: cokernelZeroIsoTarget.inv_hom_id
relationship: specialized
-/
def «zero_quotient_reduction_after_projection» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («C» «D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))),
  let «Q» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»)) := (@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»));
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («D») («Q») («D») ((@_root_.cleanNotation_zero_quotient_reduction_710bb82257389ba90ade («K») («field») («C») («D»))) ((@_root_.cleanDefine_zero_quotient_projection_56136da15b0ed1341a7f («K») («field») («C») («D»))))) ((@_root_.cleanNotation_identity_chain_map_7712ffbb97d12faffd0e («K») («field») («D»))))

/--
source: zero_quotient
reference: cokernelZeroIsoTarget.hom_inv_id
relationship: specialized
-/
def «zero_quotient_projection_after_reduction» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («C» «D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))),
  let «Q» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»)) := (@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»));
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («Q») («D») («Q») ((@_root_.cleanDefine_zero_quotient_projection_56136da15b0ed1341a7f («K») («field») («C») («D»))) ((@_root_.cleanNotation_zero_quotient_reduction_710bb82257389ba90ade («K») («field») («C») («D»))))) ((@_root_.cleanNotation_identity_chain_map_7712ffbb97d12faffd0e («K») («field») («Q»))))

/--
source: zero_quotient
reference: functor preserves inverse maps
relationship: adapted
-/
def «zero_quotient_homology_forward_after_backward» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («C» «D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))),
  ∀ («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  let «M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) := (@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («p»));
  let «N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) := (@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («p»));
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») («M») («N») («M») ((@_root_.cleanDefine_zero_quotient_homology_backward_2e4083f9d09a2c2f1112 («K») («field») («C») («D») («p»))) ((@_root_.cleanDefine_zero_quotient_homology_forward_66db0133eebe06257127 («K») («field») («C») («D») («p»))))) ((@_root_.cleanNotation_module_identity_3cffa414133766d157c3 («K») («field») («M»))))

/--
source: zero_quotient
reference: functor preserves inverse maps
relationship: adapted
-/
def «zero_quotient_homology_backward_after_forward» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («C» «D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))),
  ∀ («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)),
  let «M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) := (@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («p»));
  let «N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) := (@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («p»));
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») («N») («M») («N») ((@_root_.cleanDefine_zero_quotient_homology_forward_66db0133eebe06257127 («K») («field») («C») («D») («p»))) ((@_root_.cleanDefine_zero_quotient_homology_backward_2e4083f9d09a2c2f1112 («K») («field») («C») («D») («p»))))) ((@_root_.cleanNotation_module_identity_3cffa414133766d157c3 («K») («field») («N»))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
