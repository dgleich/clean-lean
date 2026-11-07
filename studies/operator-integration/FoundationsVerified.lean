import Lean
import Mathlib.Logic.Basic
import Mathlib.Data.Set.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.Matrix.Mul

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanDefine_equal_59dc0f11ba9b345348cf {T : Type} (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_conjunction_ae2d24c261b2e4e69e4e  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  p ∧ q

noncomputable def cleanDefine_implication_1f3f9e2e944d6a1d3361  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (p)), q)

noncomputable def cleanDefine_negation_9dda1c9733c05d83ca6e  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ¬p

noncomputable abbrev cleanType_Function_12d8de15d2a858a3dd9d (X : Type) (Y : Type) : Type :=
  (X) → (Y)

noncomputable def cleanDefine_equivalent_38494fec3ab77a8922dc  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  p ↔ q

noncomputable abbrev cleanType_Set_5f6d12891083226ff185 (T : Type) : Type :=
  Set T

noncomputable def cleanNotation_union_dcc6950eff8ce91fc4c5 {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Set_5f6d12891083226ff185 (T)) :=
  A ∪ B

noncomputable def cleanNotation_intersection_3664aeb82d8ed4eb3723 {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Set_5f6d12891083226ff185 (T)) :=
  A ∩ B

noncomputable def cleanDefine_subset_c18f8bc50dce9defa00e {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  A ⊆ B

noncomputable def cleanDefine_member_7c91d8d36d949b553ecb {T : Type} (x : T) (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∈ A

noncomputable def cleanDefine_common_part_dac9c8c8052d029840f9 {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Set_5f6d12891083226ff185 (T)) :=
  (_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (A) (B))

noncomputable abbrev cleanType_Real_8457e8182afcbbac5a10  : Type :=
  Real

noncomputable def cleanNotation_real_addition_2f9c0f4763f570a3d88b  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (y : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  x+y

noncomputable def cleanNotation_real_multiplication_d0c3228ee18f92e85dfc  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (y : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  x*y

noncomputable def cleanNotation_real_negative_4287e62987bfb0a81586  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  -x

noncomputable def cleanDefine_real_at_most_e358c3829d332446969b  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (y : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ≤ y

noncomputable def cleanDefine_real_difference_e669fb606a3082576233  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (y : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Real_8457e8182afcbbac5a10) :=
  (_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b (x) ((_root_.cleanNotation_real_negative_4287e62987bfb0a81586 (y))))

noncomputable abbrev cleanType_Natural_ed60542607241095b2d0  : Type :=
  Nat

noncomputable abbrev cleanType_Matrix_931ade84b5cc3b2b3285 (m : Nat) (n : Nat) : Type :=
  Matrix (Fin m) (Fin n) Real

noncomputable abbrev cleanType_Vector_6f95cf6726ca8c24260f (n : Nat) : Type :=
  Fin n → Real

noncomputable def cleanNotation_matrix_product_13c120c46037b521cd1a {m : (_root_.cleanType_Natural_ed60542607241095b2d0)} {n : (_root_.cleanType_Natural_ed60542607241095b2d0)} {p : (_root_.cleanType_Natural_ed60542607241095b2d0)} (A : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (m) (n))) (B : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (n) (p))) : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (m) (p)) :=
  A*B

noncomputable def cleanNotation_matrix_application_d95f015d11f6de7d4aeb {m : (_root_.cleanType_Natural_ed60542607241095b2d0)} {n : (_root_.cleanType_Natural_ed60542607241095b2d0)} (A : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (m) (n))) (x : (_root_.cleanType_Vector_6f95cf6726ca8c24260f (n))) : (_root_.cleanType_Vector_6f95cf6726ca8c24260f (m)) :=
  Matrix.mulVec A x

noncomputable def cleanNotation_scale_matrix_b8c46e89838abc1442fd {m : (_root_.cleanType_Natural_ed60542607241095b2d0)} {n : (_root_.cleanType_Natural_ed60542607241095b2d0)} (s : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (A : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (m) (n))) : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (m) (n)) :=
  s • A

noncomputable def cleanNotation_scale_vector_38dd53b8177c9787c58a {n : (_root_.cleanType_Natural_ed60542607241095b2d0)} (s : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (x : (_root_.cleanType_Vector_6f95cf6726ca8c24260f (n))) : (_root_.cleanType_Vector_6f95cf6726ca8c24260f (n)) :=
  s • x


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: add_comm
relationship: specialized
-/
def addition_commutes : Prop :=
  ∀ (x y : (_root_.cleanType_Real_8457e8182afcbbac5a10)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b (x) (y))) ((_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b (y) (x))))

/--
source: mathlib
reference: sub_eq_add_neg
relationship: adapted
-/
def subtraction_means_addition_of_the_negative : Prop :=
  ∀ (x y : (_root_.cleanType_Real_8457e8182afcbbac5a10)),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_real_difference_e669fb606a3082576233 (x) (y))) ((_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b (x) ((_root_.cleanNotation_real_negative_4287e62987bfb0a81586 (y))))))

/--
source: mathlib
reference: Set.inter_comm
relationship: adapted
-/
def intersection_commutes : Prop :=
  ∀ (T : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (A B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (A) (B))) ((_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (B) (A))))

/--
source: mathlib
reference: Set.inter_subset_left
relationship: adapted
-/
def common_part_is_contained : Prop :=
  ∀ (T : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (A B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))),
  (_root_.cleanDefine_subset_c18f8bc50dce9defa00e ((_root_.cleanDefine_common_part_dac9c8c8052d029840f9 (A) (B))) (A))

/--
source: mathlib
reference: Set.mem_inter
relationship: adapted
-/
def intersection_membership : Prop :=
  ∀ (T : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (x : T),
  ∀ (A B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))),
  ∀ («in_A» : (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) (A))),
  ∀ («in_B» : (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) (B))),
  (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) ((_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (A) (B))))

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: adapted
-/
def matrix_product_application : Prop :=
  ∀ (m n p : (_root_.cleanType_Natural_ed60542607241095b2d0)),
  ∀ (A : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (m) (n))),
  ∀ (B : (_root_.cleanType_Matrix_931ade84b5cc3b2b3285 (n) (p))),
  ∀ (x : (_root_.cleanType_Vector_6f95cf6726ca8c24260f (p))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb (m) (p) ((@_root_.cleanNotation_matrix_product_13c120c46037b521cd1a (m) (n) (p) (A) (B))) (x))) ((@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb (m) (n) (A) ((@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb (n) (p) (B) (x))))))

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

noncomputable def expected_foundation_0  : Type 1 := Type
same_basic_target cleanType_Type_c1fed1af64ab6f12e0ed expected_foundation_0

noncomputable def expected_foundation_1  : Sort 1 := Prop
same_basic_target cleanType_Proposition_ae4a13d2f060407bce35 expected_foundation_1

noncomputable def expected_foundation_2 (T : Type) : Type := Set T
same_basic_target cleanType_Set_5f6d12891083226ff185 expected_foundation_2

noncomputable def expected_foundation_3  : Type := Real
same_basic_target cleanType_Real_8457e8182afcbbac5a10 expected_foundation_3

noncomputable def expected_foundation_4  : Type := Nat
same_basic_target cleanType_Natural_ed60542607241095b2d0 expected_foundation_4

noncomputable def expected_foundation_5 (m n : Nat) : Type := Matrix (Fin m) (Fin n) Real
same_basic_target cleanType_Matrix_931ade84b5cc3b2b3285 expected_foundation_5

noncomputable def expected_foundation_6 (n : Nat) : Type := Fin n → Real
same_basic_target cleanType_Vector_6f95cf6726ca8c24260f expected_foundation_6

noncomputable def expected_foundation_7 (X Y : Type) : Type := X → Y
same_basic_target cleanType_Function_12d8de15d2a858a3dd9d expected_foundation_7

noncomputable def expected_foundation_8 {T : Type} (x y : T) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := x=y
same_basic_target cleanDefine_equal_59dc0f11ba9b345348cf expected_foundation_8

noncomputable def expected_foundation_9 (p q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := p ∧ q
same_basic_target cleanDefine_conjunction_ae2d24c261b2e4e69e4e expected_foundation_9

noncomputable def expected_foundation_10 (p q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := ∀ (_ : p), q
same_basic_target cleanDefine_implication_1f3f9e2e944d6a1d3361 expected_foundation_10

noncomputable def expected_foundation_11 (p : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := ¬p
same_basic_target cleanDefine_negation_9dda1c9733c05d83ca6e expected_foundation_11

noncomputable def expected_foundation_12 (p q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := p ↔ q
same_basic_target cleanDefine_equivalent_38494fec3ab77a8922dc expected_foundation_12

noncomputable def expected_foundation_13 {T : Type} (A B : _root_.cleanType_Set_5f6d12891083226ff185 T) : _root_.cleanType_Set_5f6d12891083226ff185 T := A ∪ B
same_basic_target cleanNotation_union_dcc6950eff8ce91fc4c5 expected_foundation_13

noncomputable def expected_foundation_14 {T : Type} (A B : _root_.cleanType_Set_5f6d12891083226ff185 T) : _root_.cleanType_Set_5f6d12891083226ff185 T := A ∩ B
same_basic_target cleanNotation_intersection_3664aeb82d8ed4eb3723 expected_foundation_14

noncomputable def expected_foundation_15 {T : Type} (A B : _root_.cleanType_Set_5f6d12891083226ff185 T) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := A ⊆ B
same_basic_target cleanDefine_subset_c18f8bc50dce9defa00e expected_foundation_15

noncomputable def expected_foundation_16 {T : Type} (x : T) (A : _root_.cleanType_Set_5f6d12891083226ff185 T) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := x ∈ A
same_basic_target cleanDefine_member_7c91d8d36d949b553ecb expected_foundation_16

noncomputable def expected_foundation_17 {T : Type} (A B : _root_.cleanType_Set_5f6d12891083226ff185 T) : _root_.cleanType_Set_5f6d12891083226ff185 T := @_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 T A B
same_basic_target cleanDefine_common_part_dac9c8c8052d029840f9 expected_foundation_17

noncomputable def expected_foundation_18 (x y : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := x+y
same_basic_target cleanNotation_real_addition_2f9c0f4763f570a3d88b expected_foundation_18

noncomputable def expected_foundation_19 (x y : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := x*y
same_basic_target cleanNotation_real_multiplication_d0c3228ee18f92e85dfc expected_foundation_19

noncomputable def expected_foundation_20 (x : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := -x
same_basic_target cleanNotation_real_negative_4287e62987bfb0a81586 expected_foundation_20

noncomputable def expected_foundation_21 (x y : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := x ≤ y
same_basic_target cleanDefine_real_at_most_e358c3829d332446969b expected_foundation_21

noncomputable def expected_foundation_22 (x y : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Real_8457e8182afcbbac5a10 := _root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b x (_root_.cleanNotation_real_negative_4287e62987bfb0a81586 y)
same_basic_target cleanDefine_real_difference_e669fb606a3082576233 expected_foundation_22

noncomputable def expected_foundation_23 {m n p : _root_.cleanType_Natural_ed60542607241095b2d0} (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m p := A*B
same_basic_target cleanNotation_matrix_product_13c120c46037b521cd1a expected_foundation_23

noncomputable def expected_foundation_24 {m n : _root_.cleanType_Natural_ed60542607241095b2d0} (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) : _root_.cleanType_Vector_6f95cf6726ca8c24260f m := Matrix.mulVec A x
same_basic_target cleanNotation_matrix_application_d95f015d11f6de7d4aeb expected_foundation_24

noncomputable def expected_foundation_25 {m n : _root_.cleanType_Natural_ed60542607241095b2d0} (s : _root_.cleanType_Real_8457e8182afcbbac5a10) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n := s • A
same_basic_target cleanNotation_scale_matrix_b8c46e89838abc1442fd expected_foundation_25

noncomputable def expected_foundation_26 {n : _root_.cleanType_Natural_ed60542607241095b2d0} (s : _root_.cleanType_Real_8457e8182afcbbac5a10) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) : _root_.cleanType_Vector_6f95cf6726ca8c24260f n := s • x
same_basic_target cleanNotation_scale_vector_38dd53b8177c9787c58a expected_foundation_26

noncomputable def expected_foundation_27  : Prop := ∀ (x y : _root_.cleanType_Real_8457e8182afcbbac5a10), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b x y) (_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b y x)
same_basic_target CleanStatements.addition_commutes expected_foundation_27

noncomputable def expected_foundation_28  : Prop := ∀ (x y : _root_.cleanType_Real_8457e8182afcbbac5a10), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Real_8457e8182afcbbac5a10 (_root_.cleanDefine_real_difference_e669fb606a3082576233 x y) (_root_.cleanNotation_real_addition_2f9c0f4763f570a3d88b x (_root_.cleanNotation_real_negative_4287e62987bfb0a81586 y))
same_basic_target CleanStatements.subtraction_means_addition_of_the_negative expected_foundation_28

noncomputable def expected_foundation_29  : Prop := ∀ (T : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (A B : _root_.cleanType_Set_5f6d12891083226ff185 T), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf (_root_.cleanType_Set_5f6d12891083226ff185 T) (@_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 T A B) (@_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 T B A)
same_basic_target CleanStatements.intersection_commutes expected_foundation_29

noncomputable def expected_foundation_30  : Prop := ∀ (T : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (A B : _root_.cleanType_Set_5f6d12891083226ff185 T), @_root_.cleanDefine_subset_c18f8bc50dce9defa00e T (@_root_.cleanDefine_common_part_dac9c8c8052d029840f9 T A B) A
same_basic_target CleanStatements.common_part_is_contained expected_foundation_30

noncomputable def expected_foundation_31  : Prop := ∀ (T : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : T) (A B : _root_.cleanType_Set_5f6d12891083226ff185 T) (_ : @_root_.cleanDefine_member_7c91d8d36d949b553ecb T x A) (_ : @_root_.cleanDefine_member_7c91d8d36d949b553ecb T x B), @_root_.cleanDefine_member_7c91d8d36d949b553ecb T x (@_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 T A B)
same_basic_target CleanStatements.intersection_membership expected_foundation_31

noncomputable def expected_foundation_32  : Prop := ∀ (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f p), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf (_root_.cleanType_Vector_6f95cf6726ca8c24260f m) (@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb m p (@_root_.cleanNotation_matrix_product_13c120c46037b521cd1a m n p A B) x) (@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb m n A (@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb n p B x))
same_basic_target CleanStatements.matrix_product_application expected_foundation_32

noncomputable def actual_application_0 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m p := (@_root_.cleanNotation_matrix_product_13c120c46037b521cd1a (m) (n) (p) (A) (B))

noncomputable def expected_foundation_33 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m p := @_root_.cleanNotation_matrix_product_13c120c46037b521cd1a m n p A B
same_basic_target actual_application_0 expected_foundation_33

noncomputable def actual_application_1 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Vector_6f95cf6726ca8c24260f m := (@_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb (m) (n) (A) (x))

noncomputable def expected_foundation_34 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Vector_6f95cf6726ca8c24260f m := @_root_.cleanNotation_matrix_application_d95f015d11f6de7d4aeb m n A x
same_basic_target actual_application_1 expected_foundation_34

noncomputable def actual_application_2 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n := (@_root_.cleanNotation_scale_matrix_b8c46e89838abc1442fd (m) (n) (s) (A))

noncomputable def expected_foundation_35 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n := @_root_.cleanNotation_scale_matrix_b8c46e89838abc1442fd m n s A
same_basic_target actual_application_2 expected_foundation_35

noncomputable def actual_application_3 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Vector_6f95cf6726ca8c24260f n := (@_root_.cleanNotation_scale_vector_38dd53b8177c9787c58a (n) (s) (x))

noncomputable def expected_foundation_36 (m n p : _root_.cleanType_Natural_ed60542607241095b2d0) (A : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 m n) (B : _root_.cleanType_Matrix_931ade84b5cc3b2b3285 n p) (x : _root_.cleanType_Vector_6f95cf6726ca8c24260f n) (s : _root_.cleanType_Real_8457e8182afcbbac5a10) : _root_.cleanType_Vector_6f95cf6726ca8c24260f n := @_root_.cleanNotation_scale_vector_38dd53b8177c9787c58a n s x
same_basic_target actual_application_3 expected_foundation_36

theorem addition_checked : CleanStatements.addition_commutes := by
  intro x y
  change x+y=y+x
  exact add_comm x y

theorem difference_checked : CleanStatements.subtraction_means_addition_of_the_negative := by
  intro x y
  rfl

theorem intersection_checked : CleanStatements.intersection_commutes := by
  intro T A B
  change A ∩ B = B ∩ A
  exact Set.inter_comm A B

theorem common_checked : CleanStatements.common_part_is_contained := by
  intro T A B
  change A ∩ B ⊆ A
  exact Set.inter_subset_left

theorem membership_checked : CleanStatements.intersection_membership := by
  intro T x A B hA hB
  exact ⟨hA,hB⟩

theorem matrix_checked : CleanStatements.matrix_product_application := by
  intro m n p A B x
  change (A*B).mulVec x = A.mulVec (B.mulVec x)
  exact (Matrix.mulVec_mulVec x A B).symm
namespace NamedAssumptions

/--
source: mathlib
reference: Set.mem_inter
relationship: adapted
-/
def intersection_membership : Prop :=
  ∀ (T : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (x : T),
  ∀ (A B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))),
  ∀ («member_u28_x_u2c__A_u29_» : (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) (A))),
  ∀ («member_u28_x_u2c__B_u29_» : (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) (B))),
  (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) ((_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (A) (B))))

end NamedAssumptions

noncomputable def expected_foundation_37  : Prop := ∀ (T : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : T) (A B : _root_.cleanType_Set_5f6d12891083226ff185 T) (_ : @_root_.cleanDefine_member_7c91d8d36d949b553ecb T x A) (_ : @_root_.cleanDefine_member_7c91d8d36d949b553ecb T x B), @_root_.cleanDefine_member_7c91d8d36d949b553ecb T x (@_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 T A B)
same_basic_target NamedAssumptions.intersection_membership expected_foundation_37

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
