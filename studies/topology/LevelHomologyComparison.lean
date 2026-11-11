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

noncomputable abbrev cleanType_Element_5a8138c45099dbbb1934 («X» : Type) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) : Type :=
  {x : X // x ∈ S}

noncomputable abbrev cleanType_Path_7cf97c6666d059adbe5c («X» : Type) («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («x» : «X») («y» : «X») : Type :=
  @Path X t x y

noncomputable def cleanNotation_underlying_point_386ce8266b75dccabc5c {«X» : Type} («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («x» : (_root_.cleanType_Element_5a8138c45099dbbb1934 («X») («S»))) : «X» :=
  x.val

noncomputable def cleanNotation_constant_path_cf3aced3b02446837654 {«X» : Type} («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («x» : «X») : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («x») («x»)) :=
  @Path.refl X t x

noncomputable def cleanNotation_reverse_path_f9637326ba504df1d059 {«X» : Type} («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («x» : «X») («y» : «X») («p» : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («x») («y»))) : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («y») («x»)) :=
  @Path.symm X t x y p

noncomputable def cleanNotation_join_paths_dce6427801091cba66da {«X» : Type} («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («x» : «X») («y» : «X») («z» : «X») («p» : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («x») («y»))) («q» : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («y») («z»))) : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («x») («z»)) :=
  @Path.trans X t x y z p q

noncomputable def cleanDefine_reverse_twice_a389d222a77c44489ae7 {«X» : Type} («t» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («x» : «X») («y» : «X») («p» : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («x») («y»))) : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («t») («x») («y»)) :=
  (@_root_.cleanNotation_reverse_path_f9637326ba504df1d059 («X») («t») («y») («x») ((@_root_.cleanNotation_reverse_path_f9637326ba504df1d059 («X») («t») («x») («y») («p»))))

/--
A topology, two points, and a path between them, on a fixed carrier.
-/
structure cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5 («X» : Type) : Type where
  «topology» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))
  «start» : «X»
  «finish» : «X»
  «path» : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («topology») («start») («finish»))

noncomputable def cleanConstructor_based_path_e8783d00a7bc6c70a5dc («X» : Type) («topology» : (_root_.cleanType_Topology_9cd8010cbc491576d39e («X»))) («start» : «X») («finish» : «X») («path» : (_root_.cleanType_Path_7cf97c6666d059adbe5c («X») («topology») («start») («finish»))) : _root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5 («X») :=
  @_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.mk «X» «topology» «start» «finish» «path»

noncomputable def cleanDefine_reversed_bundle_9f51c61f99f64652d45a  («X» : Type) («P» : _root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5 («X»)) : _root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5 («X») :=
  (@_root_.cleanConstructor_based_path_e8783d00a7bc6c70a5dc («X») ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«topology» («X») («P»))) ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«finish» («X») («P»))) ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«start» («X») («P»))) ((@_root_.cleanNotation_reverse_path_f9637326ba504df1d059 («X») ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«topology» («X») («P»))) ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«start» («X») («P»))) ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«finish» («X») («P»))) ((@_root_.cleanStructure_BasedPath_2eee1a6bfedb0c49ecf5.«path» («X») («P»))))))

structure cleanStructure_Endpoints_7a6ba0b879274641120c  : Type where
  «lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)

noncomputable def cleanConstructor_endpoints_3622a2317e61075ae5a0 («lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  @_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.mk «lower» «upper»

noncomputable def cleanDefine_ordered_endpoints_6dfe5f53eb4c4271f477  («I» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_real_less_b1358919b40501b8c83a ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»))))

noncomputable def cleanDefine_shifted_endpoints_b289f1dd1b5b2eb1b6c3  («I» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («s» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  (@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))) («s»))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»))) («s»))))

noncomputable abbrev cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_9ca9e49e1312ca23ac23   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_false_value_30a63b75654d87153a83   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_evaluate_map_4199afee6a00b76f6da5 {«X» : Type} {«Y» : Type} («f» : («X») → («Y»)) («x» : «X») : «Y» :=
  f x

noncomputable abbrev cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)

noncomputable def cleanNotation_underlying_real_map_e84010b34b660d5061f5  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))) : ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
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

noncomputable def cleanDefine_closed_interval_1a71d695dd1276061a67  («I» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))) (clean_bound_0))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»)))))))))

noncomputable def cleanDefine_selected_endpoints_8dcb5c74e5ca1571a506  («I» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («E» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» («E»))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))))))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» («E»))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 (clean_bound_0) ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»)))))))))))

noncomputable def cleanDefine_expanded_interval_f54a1e1ee489a897f1a2  («I» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))) («r»))) (clean_bound_0))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 (clean_bound_0) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»))) («r»)))))))))

noncomputable def cleanDefine_expanded_endpoints_b64db0823726d2564ae7  («I» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («E» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (_root_.cleanDefine_disjunction_f5515da12fb20ae4acc8 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» («E»))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))) («r»))) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 (clean_bound_0) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» («I»))) («r»))))))) ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» («E»))) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»))) («r»))) (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 (clean_bound_0) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» («I»))) («r»)))))))))))

structure cleanStructure_InterlevelProblem_f19133edaa90929c385d  : Type 1 where
  «space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «map» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («space»))
  «interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c
  «selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182

noncomputable def cleanConstructor_interlevel_problem_f4b313c06bfab59d40f9 («space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («map» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («space»))) («interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : _root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d :=
  @_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.mk «space» «map» «interval» «selection»

structure cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))
  «relative» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))

noncomputable def cleanConstructor_space_pair_data_14cdccdfcef446b47fc9 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («relative» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X») :=
  @_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.mk «X» «ambient» «relative»

noncomputable def cleanDefine_nested_pair_6e61a3f389d1c3430150  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («Q»))))

noncomputable def cleanDefine_expanded_pair_c28332f13676cadd2286  («P» : _root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) :=
  (@_root_.cleanConstructor_space_pair_data_14cdccdfcef446b47fc9 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«map» («P»))))) ((_root_.cleanDefine_expanded_interval_f54a1e1ee489a897f1a2 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«interval» («P»))) («r»))))) ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«map» («P»))))) ((_root_.cleanDefine_expanded_endpoints_b64db0823726d2564ae7 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«selection» («P»))) («r»))))))

noncomputable def cleanDefine_shifted_pair_d838cc1f479ba2a83eb5  («P» : _root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d) («t» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) :=
  (@_root_.cleanConstructor_space_pair_data_14cdccdfcef446b47fc9 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«map» («P»))))) ((_root_.cleanDefine_closed_interval_1a71d695dd1276061a67 ((_root_.cleanDefine_shifted_endpoints_b289f1dd1b5b2eb1b6c3 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«interval» («P»))) («t»))))))) ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«map» («P»))))) ((_root_.cleanDefine_selected_endpoints_8dcb5c74e5ca1571a506 ((_root_.cleanDefine_shifted_endpoints_b289f1dd1b5b2eb1b6c3 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«interval» («P»))) («t»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«selection» («P»))))))))

noncomputable def cleanDefine_pair_included_in_c15b036e1e2646ef39da  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) («R» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («R»))))) ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («R»))))))

noncomputable def cleanDefine_real_map_value_3f7a012dd154511185b4  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))) («x» : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_evaluate_map_4199afee6a00b76f6da5 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 («X») («f»))) («x»))

noncomputable def cleanDefine_bounded_perturbation_26bde02acb34ce9c0706  («P» : _root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d) («h» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))))) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))))), (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_real_negative_94dbb7ead5371edbb1fe («r»))) ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) («h») (clean_bound_0))) ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«map» («P»))) (clean_bound_0))))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) («h») (clean_bound_0))) ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«map» («P»))) (clean_bound_0))))) («r»)))))

noncomputable def cleanDefine_perturbed_pair_5a4edb8733f57f485252  («P» : _root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d) («h» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))))) : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) :=
  (@_root_.cleanConstructor_space_pair_data_14cdccdfcef446b47fc9 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) («h»))) ((_root_.cleanDefine_closed_interval_1a71d695dd1276061a67 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«interval» («P»))))))) ((_root_.cleanDefine_inverse_image_31011f72ff8e2a9ce261 ((@_root_.cleanNotation_underlying_real_map_e84010b34b660d5061f5 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«space» («P»))) («h»))) ((_root_.cleanDefine_selected_endpoints_8dcb5c74e5ca1571a506 ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d.«selection» («P»))))))))

noncomputable def cleanDefine_level_problem_c8e2fcf7016c72fda9cf  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))) («a» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_InterlevelProblem_f19133edaa90929c385d :=
  (@_root_.cleanConstructor_interlevel_problem_f4b313c06bfab59d40f9 («X») («f») ((@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 («a») («a»))) ((_root_.cleanDefine_no_endpoints_3aad239e18f86ce44c68)))

noncomputable def cleanDefine_level_fiber_97f29919b06d02c78417  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))) («a» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»)))) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) => (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 («X») («f») (clean_bound_0))) («a»)))))

noncomputable def cleanDefine_level_band_554683d78d3d0d75da99  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))) («a» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»)))) :=
  (_root_.cleanNotation_set_of_8cabccf85aa2fb91712d ((fun (clean_bound_0 : (_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) => (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((_root_.cleanNotation_real_difference_285267f55ec36308c915 («a») («r»))) ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 («X») («f») (clean_bound_0))))) ((_root_.cleanDefine_real_at_most_436a151a896b113553d7 ((@_root_.cleanDefine_real_map_value_3f7a012dd154511185b4 («X») («f») (clean_bound_0))) ((_root_.cleanNotation_real_sum_713c2cdea73d301a76c4 («a») («r»)))))))))

structure cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9 («X» : Type) : Type where
  «source» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))
  «target» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))
  «containment» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («source») («target»)))

noncomputable def cleanConstructor_certified_inclusion_e7f9cf6e90c9d6ad3496 («X» : Type) («source» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («target» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («containment» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («source») («target»)))) : _root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9 («X») :=
  @_root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9.mk «X» «source» «target» «containment»

noncomputable def cleanNotation_subset_inclusion_map_5098e95bd42b25cc5474  («X» : Type) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («T» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («h» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («S») («T»)))) : ((_root_.cleanType_Element_5a8138c45099dbbb1934 («X») («S»))) → ((_root_.cleanType_Element_5a8138c45099dbbb1934 («X») («T»))) :=
  Set.inclusion h

noncomputable def cleanDefine_certified_inclusion_map_6f8335528777305ea305  («X» : Type) («Q» : _root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9 («X»)) : ((_root_.cleanType_Element_5a8138c45099dbbb1934 («X») ((@_root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9.«source» («X») («Q»))))) → ((_root_.cleanType_Element_5a8138c45099dbbb1934 («X») ((@_root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9.«target» («X») («Q»))))) :=
  (@_root_.cleanNotation_subset_inclusion_map_5098e95bd42b25cc5474 («X») ((@_root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9.«source» («X») («Q»))) ((@_root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9.«target» («X») («Q»))) ((@_root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9.«containment» («X») («Q»))))

noncomputable def cleanDefine_subset_certificate_84c5d058ca7e3f5ed9e8 {«X» : Type} («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («T» : (_root_.cleanType_Set_182ba6b3273812add6f5 («X»))) («h» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («S») («T»)))) : _root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9 («X») :=
  (@_root_.cleanConstructor_certified_inclusion_e7f9cf6e90c9d6ad3496 («X») («S») («T») («h»))

structure cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))
  «relative» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))
  «nesting» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («relative») («ambient»)))

noncomputable def cleanConstructor_topological_pair_893f9157fc0c0d34f192 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («relative» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («nesting» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («relative») («ambient»)))) : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X») :=
  @_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.mk «X» «ambient» «relative» «nesting»

structure cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «source» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)
  «target» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)
  «ambient» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («target»)))))
  «relative» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («target»)))))

noncomputable def cleanConstructor_pair_inclusion_68a4229334f6df116ed3 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («source» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) («target» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) («ambient» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («target»)))))) («relative» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («source»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («target»)))))) : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X») :=
  @_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.mk «X» «source» «target» «ambient» «relative»

noncomputable def cleanDefine_ambient_inclusion_e637ff02635a4c29d717  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X»)) : _root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) :=
  (@_root_.cleanDefine_subset_certificate_84c5d058ca7e3f5ed9e8 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))) ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«ambient» («X») («Q»))))

noncomputable def cleanDefine_relative_inclusion_a2ddc981e30446a4dfd4  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X»)) : _root_.cleanStructure_SubsetInclusion_e8d6235fb697d1222ac9 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) :=
  (@_root_.cleanDefine_subset_certificate_84c5d058ca7e3f5ed9e8 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))) ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«relative» («X») («Q»))))

noncomputable def cleanNotation_subspace_be05096fbe15a380fc30  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
  (letI : TopologicalSpace X.carrier := X.str; TopCat.of S)

noncomputable def cleanNotation_subspace_inclusion_12068e22f67bedee3fdf  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («T» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («h» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («S») («T»)))) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») («S»))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») («T»)))) :=
  (letI : TopologicalSpace X.carrier := X.str; ContinuousMap.inclusion h)

noncomputable def cleanDefine_ambient_continuous_map_764ea1f04ff7127fd2f8  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X»)) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»)))))))) :=
  (@_root_.cleanNotation_subspace_inclusion_12068e22f67bedee3fdf («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))) ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«ambient» («X») («Q»))))

noncomputable def cleanDefine_relative_continuous_map_a95c95a4b8800086679a  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X»)) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»)))))))) :=
  (@_root_.cleanNotation_subspace_inclusion_12068e22f67bedee3fdf («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))) ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«relative» («X») («Q»))))

noncomputable def cleanDefine_ambient_composite_609197fae1689ad89eaf  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X»)) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»)))))))) :=
  (@_root_.cleanNotation_compose_continuous_maps_2460db16810fc2d63335 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))))) ((@_root_.cleanDefine_ambient_continuous_map_764ea1f04ff7127fd2f8 («X») («Q»))) ((@_root_.cleanNotation_subspace_inclusion_12068e22f67bedee3fdf («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«nesting» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))))

noncomputable def cleanDefine_relative_composite_7bcbb23395ca5c1c196c  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X»)) : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»)))))))) :=
  (@_root_.cleanNotation_compose_continuous_maps_2460db16810fc2d63335 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«source» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))))) ((@_root_.cleanNotation_subspace_inclusion_12068e22f67bedee3fdf («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«nesting» («X») ((@_root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7.«target» («X») («Q»))))))) ((@_root_.cleanDefine_relative_continuous_map_a95c95a4b8800086679a («X») («Q»))))

noncomputable def cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) («h» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («Q»)))))) : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X») :=
  (@_root_.cleanConstructor_topological_pair_893f9157fc0c0d34f192 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («Q»))) («h»))

noncomputable def cleanDefine_has_pair_data_a0cbff52a666811bf868  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) («S» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («S»))))))

noncomputable def cleanDefine_certify_pair_inclusion_b9374fd764f7ab8a6a00  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («S» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) («T» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) («s» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («S»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»)))))) («t» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («T»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («T»)))))) («a» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («T»)))))) («b» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («S»))) ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («T»)))))) : _root_.cleanStructure_PairInclusion_408d1a2490a0a0cf59a7 («X») :=
  (@_root_.cleanConstructor_pair_inclusion_68a4229334f6df116ed3 («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») («s»))) ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («T») («t»))) («a») («b»))

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

structure cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) : Type 1 where
  «coefficients» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))
  «degree» : (_root_.cleanType_Natural_469c53b6dafb7a218246)

noncomputable def cleanConstructor_homology_theory_bf9de1fd477addbf2300 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («coefficients» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («degree» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field») :=
  @_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.mk «K» «field» «coefficients» «degree»

noncomputable def cleanNotation_homology_module_6ea9614881a1367f702e {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X)

noncomputable def cleanNotation_homology_linear_map_19884f753a5e3dc18a4f {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («g» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («Y»)))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g))

noncomputable def cleanDefine_induced_homology_value_d1f9ba4ec0ef29aa3803 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («g» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) («x» : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))))) : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («Y»)))) :=
  (@_root_.cleanNotation_module_map_value_708bb3c249e5e9e655eb («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («Y»))) ((@_root_.cleanNotation_homology_linear_map_19884f753a5e3dc18a4f («K») («field») («H») («X») («Y») («g»))) («x»))

noncomputable def cleanDefine_induced_homology_map_ed14eaedb6c9faa17dff {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («g» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) : ((_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))))) → ((_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («Y»))))) :=
  (fun (clean_bound_0 : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))))) => (@_root_.cleanDefine_induced_homology_value_d1f9ba4ec0ef29aa3803 («K») («field») («H») («X») («Y») («g») (clean_bound_0)))

noncomputable def cleanDefine_homology_image_6fc504b46ee61b641120 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («g» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) : (_root_.cleanType_ModuleSubspace_b5c41d22ad632b2592f6 («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («Y»)))) :=
  (@_root_.cleanNotation_module_map_range_fb14abc0eef46c0da96d («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («Y»))) ((@_root_.cleanNotation_homology_linear_map_19884f753a5e3dc18a4f («K») («field») («H») («X») («Y») («g»))))

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

noncomputable def cleanNotation_singular_chains_c043508af1a51c8e811d {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»)) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).obj X)

noncomputable def cleanNotation_induced_chain_map_1d268a994c7f8daa75d7 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Y» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («f» : (_root_.cleanType_ContinuousMap_ef636b11c58f83e4d302 («X») («Y»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») («X»))) ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») («Y»)))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).map (TopCat.ofHom f))

noncomputable def cleanDefine_pair_chain_inclusion_63912f1fc1d645fc2868 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))))) ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»)))))))) :=
  (@_root_.cleanNotation_induced_chain_map_1d268a994c7f8daa75d7 («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))) ((@_root_.cleanNotation_subspace_inclusion_12068e22f67bedee3fdf («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))) ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«nesting» («X») («Q»))))))

noncomputable def cleanDefine_relative_chains_8587df5b27fca634da4f {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»)) :=
  (@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))))) ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanDefine_pair_chain_inclusion_63912f1fc1d645fc2868 («K») («field») («H») («X») («Q»))))

noncomputable def cleanDefine_relative_homology_5600c68d1281adeea3a0 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  (@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_relative_chains_8587df5b27fca634da4f («K») («field») («H») («X») («Q»))) ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»))))

noncomputable def cleanDefine_empty_space_c8a864e6b9f674e19699  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  IsEmpty X.carrier

noncomputable def cleanDefine_zero_chain_complex_2c5e9a3da51af9242713 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (letI : Field K := field; CategoryTheory.Limits.IsZero C)

noncomputable def cleanDefine_empty_relative_part_05a7405bfec34dd4337b  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_empty_space_c8a864e6b9f674e19699 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))))

noncomputable def cleanDefine_empty_relative_data_4045ded04bfbfbf933e5  («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_empty_space_c8a864e6b9f674e19699 ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«relative» («X») («Q»))))))

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

noncomputable def cleanNotation_singular_homology_comparison_51a4da3273f04c50bfcd {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») («X»))) ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»)))) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.id (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X))

noncomputable def cleanNotation_singular_homology_comparison_inverse_33b80967d39f100654f4 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») («X»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») («X»))) ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»)))))) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.id (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X))

structure cleanStructure_ChainSquare_b657c07e7f6932dde596 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) : Type where
  «source» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))
  «target» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («E») («F»))
  «left» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («E»))
  «right» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») («F»))
  «commutes» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («C») («D») («F») («right») («source»))) ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («C») («E») («F») («target») («left»)))))

noncomputable def cleanConstructor_chain_square_513fd0d921289669d95f («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («source» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («target» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («E») («F»))) («left» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («E»))) («right» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») («F»))) («commutes» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («C») («D») («F») («right») («source»))) ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («C») («E») («F») («target») («left»)))))) : _root_.cleanStructure_ChainSquare_b657c07e7f6932dde596 («K») («field») («C») («D») («E») («F») :=
  @_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.mk «K» «field» «C» «D» «E» «F» «source» «target» «left» «right» «commutes»

noncomputable def cleanNotation_chain_cokernel_map_5c85b6946e2072291af6 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («g» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («E») («F»))) («p» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («E»))) («q» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») («F»))) («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («C») («D») («F») («q») («f»))) ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») («C») («E») («F») («g») («p»)))))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («E») («F») («g»)))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.map f g p q h)

noncomputable def cleanDefine_square_quotient_map_c2c617a3c82a8087cb54 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («S» : _root_.cleanStructure_ChainSquare_b657c07e7f6932dde596 («K») («field») («C») («D») («E») («F»)) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«source» («K») («field») («C») («D») («E») («F») («S»))))) ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («E») («F») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«target» («K») («field») («C») («D») («E») («F») («S»)))))) :=
  (@_root_.cleanNotation_chain_cokernel_map_5c85b6946e2072291af6 («K») («field») («C») («D») («E») («F») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«source» («K») («field») («C») («D») («E») («F») («S»))) ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«target» («K») («field») («C») («D») («E») («F») («S»))) ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«left» («K») («field») («C») («D») («E») («F») («S»))) ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«right» («K») («field») («C») («D») («E») («F») («S»))) ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«commutes» («K») («field») («C») («D») («E») («F») («S»))))

noncomputable def cleanDefine_square_homology_map_4c4c9a581e05a5d99375 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («S» : _root_.cleanStructure_ChainSquare_b657c07e7f6932dde596 («K») («field») («C») («D») («E») («F»)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«source» («K») («field») («C») («D») («E») («F») («S»))))) («n»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («E») («F») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«target» («K») («field») («C») («D») («E») («F») («S»))))) («n»)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«source» («K») («field») («C») («D») («E») («F») («S»))))) ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («E») («F») ((@_root_.cleanStructure_ChainSquare_b657c07e7f6932dde596.«target» («K») («field») («C») («D») («E») («F») («S»))))) ((@_root_.cleanDefine_square_quotient_map_c2c617a3c82a8087cb54 («K») («field») («C») («D») («E») («F») («S»))) («n»))

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

noncomputable def cleanDefine_zero_quotient_map_dbac1825da60d29705c7 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («v» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») («F»))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («E») («F»)))) :=
  (@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («F») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («E») («F»))) ((@_root_.cleanDefine_zero_quotient_projection_56136da15b0ed1341a7f («K») («field») («E») («F»))) ((@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («D») («F») («v») ((@_root_.cleanNotation_zero_quotient_reduction_710bb82257389ba90ade («K») («field») («C») («D»))))))

noncomputable def cleanDefine_zero_quotient_homology_map_878b3cf9fc0561e9cf48 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («v» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («D») («F»))) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («p»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («E») («F»))) («p»)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («E») («F»))) ((@_root_.cleanDefine_zero_quotient_map_dbac1825da60d29705c7 («K») («field») («C») («D») («E») («F») («v»))) («p»))

noncomputable def cleanNotation_equality_congruence_92c32a6c27b09d106bb2 {«X» : Type} {«Y» : Type} («f» : («X») → («Y»)) («x» : «X») («y» : «X») («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («x») («y»)))) : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((«f» «x»)) ((«f» «y»)))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_4612249bc195d677e048 {«X» : Type} («x» : «X») : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («x») («x»))) :=
  Eq.refl x

noncomputable def cleanNotation_equality_symmetry_6be3544bc0038c4817cd {«T» : Type} («x» : «T») («y» : «T») («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («x») («y»)))) : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («y») («x»))) :=
  Eq.symm h

noncomputable def cleanNotation_equality_transitivity_1b078188b4cab85aa4b6 {«T» : Type} («x» : «T») («y» : «T») («z» : «T») («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («x») («y»)))) («k» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («y») («z»)))) : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («x») («z»))) :=
  Eq.trans h k

noncomputable def cleanNotation_chain_cokernel_transport_be3fb710d161aad04614 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («g» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («f») («g»)))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («g»)))) :=
  (letI : Field K := field; (CategoryTheory.Limits.cokernelIsoOfEq h).hom)

noncomputable def cleanDefine_chain_cokernel_reverse_transport_4c75b72af22c973543be {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («g» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («f») («g»)))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («g»))) ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»)))) :=
  (@_root_.cleanNotation_chain_cokernel_transport_be3fb710d161aad04614 («K») («field») («C») («D») («g») («f») ((@_root_.cleanNotation_equality_symmetry_6be3544bc0038c4817cd ((_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («f») («g») («h»))))

noncomputable def cleanDefine_vanishing_quotient_reduction_8e9e295c50ffa4d19931 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («f») ((@_root_.cleanNotation_zero_chain_map_accfad693693a946c3e6 («K») («field») («C») («D»)))))) : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) («D»)) :=
  (@_root_.cleanNotation_compose_chain_maps_cef6124157281682085f («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) ((@_root_.cleanDefine_zero_chain_quotient_a00189717519ea1f14bf («K») («field») («C») («D»))) («D») ((@_root_.cleanNotation_zero_quotient_reduction_710bb82257389ba90ade («K») («field») («C») («D»))) ((@_root_.cleanNotation_chain_cokernel_transport_be3fb710d161aad04614 («K») («field») («C») («D») («f») ((@_root_.cleanNotation_zero_chain_map_accfad693693a946c3e6 («K») («field») («C») («D»))) («h»))))

noncomputable def cleanDefine_vanishing_quotient_homology_forward_a45e40d030da62ea7ee5 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 («f») ((@_root_.cleanNotation_zero_chain_map_accfad693693a946c3e6 («K») («field») («C») («D»)))))) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) («p»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («p»)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) («D») ((@_root_.cleanDefine_vanishing_quotient_reduction_8e9e295c50ffa4d19931 («K») («field») («C») («D») («f») («h»))) («p»))

noncomputable def cleanDefine_vanishing_quotient_homology_backward_47a8522182398407d0c1 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («C» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_319c7d057f5f821f7932 («K») («field»))) («f» : (_root_.cleanType_ChainMap_80ddfbec860449786302 («K») («field») («C») («D»))) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») («D») («p»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) («p»)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_3952f2d3986b4912e6ec («K») («field») («D») ((@_root_.cleanNotation_chain_cokernel_80980b0f4c1fe4722fbd («K») («field») («C») («D») («f»))) ((@_root_.cleanNotation_chain_cokernel_projection_409c758f935dcb8b23fd («K») («field») («C») («D») («f»))) («p»))

noncomputable def cleanDefine_relative_to_ordinary_homology_04af82723280e1a7d135 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) («h» : ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanDefine_pair_chain_inclusion_63912f1fc1d645fc2868 («K») («field») («H») («X») («Q»))) ((@_root_.cleanNotation_zero_chain_map_accfad693693a946c3e6 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))))) ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»)))))))))))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») («Q»))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»)))))))) :=
  (@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») («Q»))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanDefine_vanishing_quotient_homology_forward_a45e40d030da62ea7ee5 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))))) ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanDefine_pair_chain_inclusion_63912f1fc1d645fc2868 («K») («field») («H») («X») («Q»))) («h») ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»))))) ((@_root_.cleanNotation_singular_homology_comparison_51a4da3273f04c50bfcd («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))))

noncomputable def cleanDefine_ordinary_to_relative_homology_23f23e542089274477a7 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («Q» : _root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0 («X»)) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») («Q»)))) :=
  (@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanNotation_chain_homology_741de881939148c4d167 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»))))) ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») («Q»))) ((@_root_.cleanNotation_singular_homology_comparison_inverse_33b80967d39f100654f4 («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanDefine_vanishing_quotient_homology_backward_47a8522182398407d0c1 («K») («field») ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«relative» («X») («Q»))))))) ((@_root_.cleanNotation_singular_chains_c043508af1a51c8e811d («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_TopologicalPair_2cafe8fd0f1463cd71d0.«ambient» («X») («Q»))))))) ((@_root_.cleanDefine_pair_chain_inclusion_63912f1fc1d645fc2868 («K») («field») («H») («X») («Q»))) ((@_root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2.«degree» («K») («field») («H»))))))

noncomputable def cleanDefine_inverse_module_maps_f811e0fa8eeacf4e14d6 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («N») («M»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») («M») («N») («M») («f») («g»))) ((@_root_.cleanNotation_module_identity_3cffa414133766d157c3 («K») («field») («M»))))) ((_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») («N») («M») («N») («g») («f»))) ((@_root_.cleanNotation_module_identity_3cffa414133766d157c3 («K») («field») («N»))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: level_comparison
reference: assembled level specialization
relationship: original
-/
def «expanded_level_pair_admits_ordinary_comparison» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)),
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))),
  ∀ («a» «r» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  let «S» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X») := (@_root_.cleanDefine_expanded_pair_c28332f13676cadd2286 ((@_root_.cleanDefine_level_problem_c8e2fcf7016c72fda9cf («X») («f») («a»))) («r»));
  (@Exists (((@_root_.cleanDefine_nested_pair_6e61a3f389d1c3430150 («X») («S»)))) (fun (clean_bound_0 : ((@_root_.cleanDefine_nested_pair_6e61a3f389d1c3430150 («X») («S»)))) => (@Exists ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))))) (fun (clean_bound_1 : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))))) => (@_root_.cleanDefine_inverse_module_maps_f811e0fa8eeacf4e14d6 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))) (clean_bound_1) ((@_root_.cleanDefine_ordinary_to_relative_homology_23f23e542089274477a7 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))))))))

/--
source: level_comparison
reference: assembled level specialization
relationship: original
-/
def «perturbed_level_pair_admits_ordinary_comparison» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)),
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («f» «g» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))),
  ∀ («a» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  let «S» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X») := (@_root_.cleanDefine_perturbed_pair_5a4edb8733f57f485252 ((@_root_.cleanDefine_level_problem_c8e2fcf7016c72fda9cf («X») («f») («a»))) («g»));
  (@Exists (((@_root_.cleanDefine_nested_pair_6e61a3f389d1c3430150 («X») («S»)))) (fun (clean_bound_0 : ((@_root_.cleanDefine_nested_pair_6e61a3f389d1c3430150 («X») («S»)))) => (@Exists ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))))) (fun (clean_bound_1 : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))))) => (@_root_.cleanDefine_inverse_module_maps_f811e0fa8eeacf4e14d6 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))) (clean_bound_1) ((@_root_.cleanDefine_ordinary_to_relative_homology_23f23e542089274477a7 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))))))))

/--
source: level_comparison
reference: assembled level specialization
relationship: original
-/
def «shifted_level_pair_admits_ordinary_comparison» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)),
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («f» : (_root_.cleanType_ContinuousRealMap_74b566358ab2015f7fa9 («X»))),
  ∀ («a» «t» : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  let «S» : _root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e («X») := (@_root_.cleanDefine_shifted_pair_d838cc1f479ba2a83eb5 ((@_root_.cleanDefine_level_problem_c8e2fcf7016c72fda9cf («X») («f») («a»))) («t»));
  (@Exists (((@_root_.cleanDefine_nested_pair_6e61a3f389d1c3430150 («X») («S»)))) (fun (clean_bound_0 : ((@_root_.cleanDefine_nested_pair_6e61a3f389d1c3430150 («X») («S»)))) => (@Exists ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))))) (fun (clean_bound_1 : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))))) => (@_root_.cleanDefine_inverse_module_maps_f811e0fa8eeacf4e14d6 («K») («field») ((@_root_.cleanDefine_relative_homology_5600c68d1281adeea3a0 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))) ((@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») ((@_root_.cleanStructure_SpacePairData_44226b7ea10ec0718d0e.«ambient» («X») («S»))))))) (clean_bound_1) ((@_root_.cleanDefine_ordinary_to_relative_homology_23f23e542089274477a7 («K») («field») («H») («X») ((@_root_.cleanDefine_certify_pair_data_b1b4cf4ef68fb6dc7be1 («X») («S») (clean_bound_0))))))))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
