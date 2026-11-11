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

noncomputable def cleanNotation_module_map_kernel_2f5da86a380241ccbb03 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) : (_root_.cleanType_ModuleSubspace_b5c41d22ad632b2592f6 («K») («field») («M»)) :=
  LinearMap.ker (@ModuleCat.Hom.hom K field.toRing M N f)

noncomputable def cleanNotation_module_zero_element_3a2ecb3d4848991546de {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («M»)) :=
  (0 : M.carrier)

noncomputable def cleanDefine_exact_pair_0c4b71f4defcf6396d6f {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («P» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («N») («P»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_map_range_fb14abc0eef46c0da96d («K») («field») («M») («N») («f»))) ((@_root_.cleanNotation_module_map_kernel_2f5da86a380241ccbb03 («K») («field») («N») («P») («g»))))

noncomputable def cleanDefine_exact_b36288aa2a8dfa579243 {«K» : Type} {«field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))} {«M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} {«N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} {«P» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («N») («P»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@_root_.cleanDefine_exact_pair_0c4b71f4defcf6396d6f («K») («field») («M») («N») («P») («f») («g»))

structure cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) : Type 1 where
  «object» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)))
  «arrow» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((«object» (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_pi_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) ((«object» clean_pi_bound_0))))

noncomputable def cleanConstructor_module_sequence_1bd9d08ea7b7e3aa239a («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («object» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)))) («arrow» : (clean_pi_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((«object» (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 (clean_pi_bound_0) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) ((«object» clean_pi_bound_0))))) : _root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06 («K») («field») :=
  @_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.mk «K» «field» «object» «arrow»

noncomputable def cleanDefine_exact_pair_at_e96ebaa9cea5bccfea52 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («S» : _root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06 («K») («field»)) («n» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (@_root_.cleanDefine_exact_pair_0c4b71f4defcf6396d6f («K») («field») (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«object» («K») («field») («S»)) (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1))))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«object» («K») («field») («S»)) (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«object» («K») («field») («S»)) «n»)) (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«arrow» («K») («field») («S»)) (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 («n») ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«arrow» («K») («field») («S»)) «n»)))

noncomputable def cleanDefine_exact_sequence_interior_5e0511f0b4766da78bd4 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («S» : _root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06 («K») («field»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)), (@_root_.cleanDefine_exact_pair_at_e96ebaa9cea5bccfea52 («K») («field») («S») (clean_bound_0)))

noncomputable def cleanNotation_module_zero_map_79f61b4235399bfd978b {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»)) :=
  (letI : Field K := field; ModuleCat.ofHom (0 : M.carrier →ₗ[K] N.carrier))

noncomputable def cleanDefine_onto_46e079e8d4a6961f3fe3 {«K» : Type} {«field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))} {«M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} {«N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («N»))), (@Exists ((_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («M»))) (fun (clean_bound_1 : (_root_.cleanType_ModuleElement_8de1da3233066bdec3ce («K») («field») («M»))) => (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_map_value_708bb3c249e5e9e655eb («K») («field») («M») («N») («f») (clean_bound_1))) (clean_bound_0)))))

noncomputable def cleanDefine_exact_sequence_ending_in_zero_e1f306e645a6e90bcd42 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («S» : _root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06 («K») («field»)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (_root_.cleanDefine_conjunction_963f354411ee41f3dcd0 ((@_root_.cleanDefine_exact_sequence_interior_5e0511f0b4766da78bd4 («K») («field») («S»))) ((@_root_.cleanDefine_onto_46e079e8d4a6961f3fe3 («K») («field») (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«object» («K») («field») («S»)) (_root_.cleanNotation_natural_sum_ea5ce9ac6c2481b8c1d7 ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0))) ((_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 1)))))) (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«object» («K») («field») («S»)) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)))) (((@_root_.cleanStructure_ModuleSequence_9a71c2ab84293f6a1f06.«arrow» («K») («field») («S»)) (_root_.cleanNumeral_Natural_47460cb427d00c0cfbad (nat_lit 0)))))))

structure cleanStructure_GradedModule_76cc13b50fb929593cfb («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) : Type 1 where
  «component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)))

noncomputable def cleanConstructor_graded_module_66419f2272b65d4d8843 («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («component» : ((_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)))) : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field») :=
  @_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.mk «K» «field» «component»

noncomputable def cleanDefine_component_module_cbc7c7dbd7330b329add {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («p» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  ((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) «p»)

structure cleanStructure_GradedMap_30cbf44bd787dc89e48d («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («N» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) : Type where
  «component» : (clean_pi_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_pi_bound_1)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («N»)) clean_pi_bound_1))))

noncomputable def cleanConstructor_graded_map_5aef880729c8b2bfbcaa («K» : Type) («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («N» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («component» : (clean_pi_bound_1 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) → ((_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_pi_bound_1)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («N»)) clean_pi_bound_1))))) : _root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d («K») («field») («M») («N») :=
  @_root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d.mk «K» «field» «M» «N» «component»

noncomputable def cleanNotation_module_identity_3cffa414133766d157c3 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («M»)) :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M

noncomputable def cleanNotation_module_composition_622cd851b0bc174c8369 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («P» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («N») («P»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («P»)) :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g

noncomputable def cleanDefine_graded_identity_3f021ef33dbe20761256 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) : _root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d («K») («field») («M») («M») :=
  (@_root_.cleanConstructor_graded_map_5aef880729c8b2bfbcaa («K») («field») («M») («M») ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_identity_3cffa414133766d157c3 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_bound_0))))))

noncomputable def cleanDefine_graded_composition_f28d41a1a8dd12b256df {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («N» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («P» : _root_.cleanStructure_GradedModule_76cc13b50fb929593cfb («K») («field»)) («f» : _root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d («K») («field») («M») («N»)) («g» : _root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d («K») («field») («N») («P»)) : _root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d («K») («field») («M») («P») :=
  (@_root_.cleanConstructor_graded_map_5aef880729c8b2bfbcaa («K») («field») («M») («P») ((fun (clean_bound_0 : (_root_.cleanType_Natural_469c53b6dafb7a218246)) => (@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («M»)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («N»)) clean_bound_0)) (((@_root_.cleanStructure_GradedModule_76cc13b50fb929593cfb.«component» («K») («field») («P»)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d.«component» («K») («field») («M») («N») («f»)) clean_bound_0)) (((@_root_.cleanStructure_GradedMap_30cbf44bd787dc89e48d.«component» («K») («field») («N») («P») («g»)) clean_bound_0))))))

noncomputable def cleanNotation_module_product_04f013a1581701704d55 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  (letI : Field K := field; ModuleCat.of K (M.carrier × N.carrier))

noncomputable def cleanNotation_left_inclusion_718a71a8df6271214f84 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») («M») («N»)))) :=
  (letI : Field K := field; ModuleCat.ofHom (LinearMap.inl K M.carrier N.carrier))

noncomputable def cleanNotation_right_projection_3c7b9d9ec8ac22f60939 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») («M») («N»))) («N»)) :=
  (letI : Field K := field; ModuleCat.ofHom (LinearMap.snd K M.carrier N.carrier))

noncomputable def cleanNotation_pair_module_maps_b4a6fc1d2e36b305b210 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («L» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («L») («M»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («L») («N»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («L») ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») («M») («N»)))) :=
  (letI : Field K := field; ModuleCat.ofHom (f.hom.prod g.hom))

noncomputable def cleanNotation_merge_module_maps_2fb4ae0fac0ae9dea8f2 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («P» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («h» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («P»))) («k» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («N») («P»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») («M») («N»))) («P»)) :=
  (letI : Field K := field; ModuleCat.ofHom (h.hom.coprod k.hom))

noncomputable def cleanNotation_negative_module_map_ba91356131adf5b825bf {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))) («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («M») («N»)) :=
  (letI : Field K := field; ModuleCat.ofHom (-f.hom))

noncomputable def cleanDefine_signed_pair_3e4ce4f48a3f89b7cec3 {«K» : Type} {«field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))} {«L» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} {«M» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} {«N» : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»))} («f» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («L») («M»))) («g» : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («L») («N»))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») («L») ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») («M») («N»)))) :=
  (@_root_.cleanNotation_pair_module_maps_b4a6fc1d2e36b305b210 («K») («field») («L») («M») («N») («f») ((@_root_.cleanNotation_negative_module_map_ba91356131adf5b825bf («K») («field») («L») («N») («g»))))

noncomputable def cleanNotation_intersection_into_left_ea927ebf0c0726e3a164 {«T» : Type} («U» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («V» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))) («U»))) :=
  Set.inter_subset_left

noncomputable def cleanNotation_intersection_into_right_c5d77ed61d035b898961 {«T» : Type} («U» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («V» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))) («V»))) :=
  Set.inter_subset_right

noncomputable def cleanNotation_left_into_union_00ceb5d3353b3ee07f5d {«T» : Type} («U» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («V» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («U») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))))) :=
  Set.subset_union_left

noncomputable def cleanNotation_right_into_union_f36a51d8300dfbb96997 {«T» : Type} («U» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) («V» : (_root_.cleanType_Set_182ba6b3273812add6f5 («T»))) : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («V») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))))) :=
  Set.subset_union_right

noncomputable def cleanDefine_subset_homology_62b62f12b29c10fcc13e {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) : (_root_.cleanType_CoefficientModule_cb06282c8e98b088950e («K») («field»)) :=
  (@_root_.cleanNotation_homology_module_6ea9614881a1367f702e («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») («S»))))

noncomputable def cleanDefine_inclusion_homology_844c4672d6c063c1b98e {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («S» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («T» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («h» : ((_root_.cleanDefine_set_subset_05919499ab956b009bbe («S») («T»)))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («S»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («T»)))) :=
  (@_root_.cleanNotation_homology_linear_map_19884f753a5e3dc18a4f («K») («field») («H») ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») («S»))) ((@_root_.cleanNotation_subspace_be05096fbe15a380fc30 («X») («T»))) ((@_root_.cleanNotation_subspace_inclusion_12068e22f67bedee3fdf («X») («S») («T») («h»))))

noncomputable def cleanDefine_intersection_homology_map_e6bbcf52a3a3663c047e {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («U» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («V» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))))) ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («U»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («V»)))))) :=
  (@_root_.cleanDefine_signed_pair_3e4ce4f48a3f89b7cec3 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («U»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («V»))) ((@_root_.cleanDefine_inclusion_homology_844c4672d6c063c1b98e («K») («field») («H») («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))) («U») ((@_root_.cleanNotation_intersection_into_left_ea927ebf0c0726e3a164 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) («U») («V»))))) ((@_root_.cleanDefine_inclusion_homology_844c4672d6c063c1b98e («K») («field») («H») («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))) («V») ((@_root_.cleanNotation_intersection_into_right_c5d77ed61d035b898961 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) («U») («V»))))))

noncomputable def cleanDefine_union_homology_map_b9e127caebb6b6001c18 {«K» : Type} («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))) («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)) («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («U» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) («V» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))) : (_root_.cleanType_ModuleMap_cf75ef13ca99ba60b566 («K») («field») ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («U»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («V»))))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»)))))) :=
  (@_root_.cleanNotation_merge_module_maps_2fb4ae0fac0ae9dea8f2 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («U»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («V»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))))) ((@_root_.cleanDefine_inclusion_homology_844c4672d6c063c1b98e («K») («field») («H») («X») («U») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))) ((@_root_.cleanNotation_left_into_union_00ceb5d3353b3ee07f5d ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) («U») («V»))))) ((@_root_.cleanDefine_inclusion_homology_844c4672d6c063c1b98e («K») («field») («H») («X») («V») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))) ((@_root_.cleanNotation_right_into_union_f36a51d8300dfbb96997 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))) («U») («V»))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: construction
reference: functoriality and signed cancellation
relationship: original
-/
def «intersection_then_union_vanishes» : Prop :=
  ∀ («K» : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ («field» : (_root_.cleanType_FieldStructure_6c5b3bc7a67ff898144f («K»))),
  ∀ («H» : _root_.cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 («K») («field»)),
  ∀ («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ («U» «V» : (_root_.cleanType_Set_182ba6b3273812add6f5 ((_root_.cleanType_Point_076f4ea9c8be8cf2cd06 («X»))))),
  (_root_.cleanDefine_equal_5fac732a65dd209a83f4 ((@_root_.cleanNotation_module_composition_622cd851b0bc174c8369 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))))) ((@_root_.cleanNotation_module_product_04f013a1581701704d55 («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («U»))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») («V»))))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))))) ((@_root_.cleanDefine_intersection_homology_map_e6bbcf52a3a3663c047e («K») («field») («H») («X») («U») («V»))) ((@_root_.cleanDefine_union_homology_map_b9e127caebb6b6001c18 («K») («field») («H») («X») («U») («V»))))) ((@_root_.cleanNotation_module_zero_map_79f61b4235399bfd978b («K») («field») ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_intersection_b049bcd777db8c8dca54 («U») («V»))))) ((@_root_.cleanDefine_subset_homology_62b62f12b29c10fcc13e («K») («field») («H») («X») ((_root_.cleanNotation_set_union_8ded6f8d80349ff9fd80 («U») («V»))))))))

end CleanStatements

namespace MayerVietorisMapOracle
def interLeft {T : Type} (U V : cleanType_Set_182ba6b3273812add6f5 T) : (cleanDefine_set_subset_05919499ab956b009bbe (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V) U) := Set.inter_subset_left
def interRight {T : Type} (U V : cleanType_Set_182ba6b3273812add6f5 T) : (cleanDefine_set_subset_05919499ab956b009bbe (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V) V) := Set.inter_subset_right
def unionLeft {T : Type} (U V : cleanType_Set_182ba6b3273812add6f5 T) : (cleanDefine_set_subset_05919499ab956b009bbe U (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V)) := Set.subset_union_left
def unionRight {T : Type} (U V : cleanType_Set_182ba6b3273812add6f5 T) : (cleanDefine_set_subset_05919499ab956b009bbe V (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V)) := Set.subset_union_right
noncomputable def subsetHomology {K : Type} (field : cleanType_FieldStructure_6c5b3bc7a67ff898144f K) (H : cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (S : cleanType_Set_182ba6b3273812add6f5 (cleanType_Point_076f4ea9c8be8cf2cd06 X)) : cleanType_CoefficientModule_cb06282c8e98b088950e K field := cleanNotation_homology_module_6ea9614881a1367f702e field H (cleanNotation_subspace_be05096fbe15a380fc30 X S)
noncomputable def inclusionHomology {K : Type} (field : cleanType_FieldStructure_6c5b3bc7a67ff898144f K) (H : cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (S T : cleanType_Set_182ba6b3273812add6f5 (cleanType_Point_076f4ea9c8be8cf2cd06 X)) (h : (cleanDefine_set_subset_05919499ab956b009bbe S T)) :
 cleanType_ModuleMap_cf75ef13ca99ba60b566 K field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X S) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X T) :=
 cleanNotation_homology_linear_map_19884f753a5e3dc18a4f field H (cleanNotation_subspace_be05096fbe15a380fc30 X S) (cleanNotation_subspace_be05096fbe15a380fc30 X T) (cleanNotation_subspace_inclusion_12068e22f67bedee3fdf X S T h)
noncomputable def alpha {K : Type} (field : cleanType_FieldStructure_6c5b3bc7a67ff898144f K) (H : cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanType_Set_182ba6b3273812add6f5 (cleanType_Point_076f4ea9c8be8cf2cd06 X)) :
 cleanType_ModuleMap_cf75ef13ca99ba60b566 K field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V)) (cleanNotation_module_product_04f013a1581701704d55 field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X U) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X V)) :=
 cleanDefine_signed_pair_3e4ce4f48a3f89b7cec3 (cleanDefine_inclusion_homology_844c4672d6c063c1b98e field H X (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V) U (cleanNotation_intersection_into_left_ea927ebf0c0726e3a164 U V)) (cleanDefine_inclusion_homology_844c4672d6c063c1b98e field H X (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V) V (cleanNotation_intersection_into_right_c5d77ed61d035b898961 U V))
noncomputable def beta {K : Type} (field : cleanType_FieldStructure_6c5b3bc7a67ff898144f K) (H : cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanType_Set_182ba6b3273812add6f5 (cleanType_Point_076f4ea9c8be8cf2cd06 X)) :
 cleanType_ModuleMap_cf75ef13ca99ba60b566 K field (cleanNotation_module_product_04f013a1581701704d55 field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X U) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X V)) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V)) :=
 cleanNotation_merge_module_maps_2fb4ae0fac0ae9dea8f2 field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X U) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X V) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V))
  (cleanDefine_inclusion_homology_844c4672d6c063c1b98e field H X U (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V) (cleanNotation_left_into_union_00ceb5d3353b3ee07f5d U V)) (cleanDefine_inclusion_homology_844c4672d6c063c1b98e field H X V (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V) (cleanNotation_right_into_union_f36a51d8300dfbb96997 U V))
def vanishes : Prop := ∀ (K : cleanType_Type_c1fed1af64ab6f12e0ed) (field : cleanType_FieldStructure_6c5b3bc7a67ff898144f K) (H : cleanStructure_HomologyTheory_4718d9f8f2e4ebd2f2a2 K field)
 (X : cleanType_TopologicalSpace_d66be29262ccb5d89e3b) (U V : cleanType_Set_182ba6b3273812add6f5 (cleanType_Point_076f4ea9c8be8cf2cd06 X)),
 cleanDefine_equal_5fac732a65dd209a83f4 (cleanNotation_module_composition_622cd851b0bc174c8369 field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V)) (cleanNotation_module_product_04f013a1581701704d55 field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X U) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X V))
  (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V)) (cleanDefine_intersection_homology_map_e6bbcf52a3a3663c047e field H X U V) (cleanDefine_union_homology_map_b9e127caebb6b6001c18 field H X U V))
  (cleanNotation_module_zero_map_79f61b4235399bfd978b field (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_intersection_b049bcd777db8c8dca54 U V)) (cleanDefine_subset_homology_62b62f12b29c10fcc13e field H X (cleanNotation_set_union_8ded6f8d80349ff9fd80 U V)))
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

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

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
same_basic_target cleanNotation_intersection_into_left_ea927ebf0c0726e3a164 MayerVietorisMapOracle.interLeft
same_basic_target cleanNotation_intersection_into_right_c5d77ed61d035b898961 MayerVietorisMapOracle.interRight
same_basic_target cleanNotation_left_into_union_00ceb5d3353b3ee07f5d MayerVietorisMapOracle.unionLeft
same_basic_target cleanNotation_right_into_union_f36a51d8300dfbb96997 MayerVietorisMapOracle.unionRight
same_basic_target cleanDefine_subset_homology_62b62f12b29c10fcc13e MayerVietorisMapOracle.subsetHomology
same_basic_target cleanDefine_inclusion_homology_844c4672d6c063c1b98e MayerVietorisMapOracle.inclusionHomology
same_basic_target cleanDefine_intersection_homology_map_e6bbcf52a3a3663c047e MayerVietorisMapOracle.alpha
same_basic_target cleanDefine_union_homology_map_b9e127caebb6b6001c18 MayerVietorisMapOracle.beta
same_basic_target CleanStatements.intersection_then_union_vanishes MayerVietorisMapOracle.vanishes
