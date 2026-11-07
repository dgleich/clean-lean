import Lean
import Mathlib.Data.Real.Basic

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Natural_ed60542607241095b2d0  : Type :=
  Nat

noncomputable abbrev cleanType_Real_8457e8182afcbbac5a10  : Type :=
  Real

noncomputable abbrev cleanType_Function_c7021aafda499fb8cdb1 (T : Type) (U : Type) : Type :=
  (T) → (U)

noncomputable abbrev cleanType_Vector_05659923fab260da9b0c (n : Nat) (T : Type) : Type :=
  Fin n → T

noncomputable def cleanDefine_equal_59dc0f11ba9b345348cf {T : Type} (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_equal_types_407ed45e8fefd3377ad8  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (B : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  A=B

noncomputable def cleanDefine_real_equality_fd62683dae3907979268  (x : (_root_.cleanType_Real_8457e8182afcbbac5a10)) (y : (_root_.cleanType_Real_8457e8182afcbbac5a10)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanNotation_choose_first_e9e7510dbe5258843729 {T : Type} (x : T) (y : T) : T :=
  x

noncomputable def cleanNotation_choose_carrier_df4a9e0db2b8ea466a5a  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (B : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed) :=
  A

noncomputable def cleanNotation_generic_witness_b14cc73c8df04bbc3c4c {T : Type} (x : T) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (x)))) : T :=
  x

noncomputable def cleanNotation_carrier_witness_07aeca3f3dc73ce47d18  (A : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (h : ((@_root_.cleanDefine_equal_types_407ed45e8fefd3377ad8 (A) (A)))) : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed) :=
  A

noncomputable def cleanDefine_truth_9233a1fb3d57223a0c34   : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  True

noncomputable def cleanNotation_generic_marker_45b9e2b938ec96057e03 {T : Type} (x : T) : T :=
  x

noncomputable def cleanNotation_proof_marker_b6ad7c6f314de7e6d35d  (h : ((_root_.cleanDefine_truth_9233a1fb3d57223a0c34))) : ((_root_.cleanDefine_truth_9233a1fb3d57223a0c34)) :=
  h

noncomputable def cleanNotation_sum_3c9f2d3f5d945f2d0680  (x : (_root_.cleanType_Natural_ed60542607241095b2d0)) (y : (_root_.cleanType_Natural_ed60542607241095b2d0)) : (_root_.cleanType_Natural_ed60542607241095b2d0) :=
  x+y

noncomputable def cleanNotation_vector_sum_f57b3be99e3587017cb7 {n : (_root_.cleanType_Natural_ed60542607241095b2d0)} (v : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))) (w : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))) : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Real_8457e8182afcbbac5a10))) :=
  v+w

noncomputable def cleanDefine_double_natural_b86dcacac1aaadc09f5a  (n : (_root_.cleanType_Natural_ed60542607241095b2d0)) (m : (_root_.cleanType_Natural_ed60542607241095b2d0)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  m=n+n

noncomputable def cleanDefine_double_vector_eeaa8d74ff44c4e776e2  (n : (_root_.cleanType_Natural_ed60542607241095b2d0)) (v : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))) (w : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  w=v+v



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: local versus module carrier
relationship: original
-/
def local_carrier_avoids_concrete_overload : Prop :=
  ∀ (Real : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (x : Real),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (x))

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

noncomputable def expected_body_0 (A B : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) : _root_.cleanType_Type_c1fed1af64ab6f12e0ed := A
same_basic_target cleanNotation_choose_carrier_df4a9e0db2b8ea466a5a expected_body_0

noncomputable def expected_body_1 (A : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (h : @cleanDefine_equal_types_407ed45e8fefd3377ad8 A A) : _root_.cleanType_Type_c1fed1af64ab6f12e0ed := A
same_basic_target cleanNotation_carrier_witness_07aeca3f3dc73ce47d18 expected_body_1

noncomputable def expected_body_2 {T : Type} (x : T) (h : @cleanDefine_equal_59dc0f11ba9b345348cf T x x) : T := x
same_basic_target cleanNotation_generic_witness_b14cc73c8df04bbc3c4c expected_body_2

noncomputable def expected_body_3 (h : cleanDefine_truth_9233a1fb3d57223a0c34) : cleanDefine_truth_9233a1fb3d57223a0c34 := h
same_basic_target cleanNotation_proof_marker_b6ad7c6f314de7e6d35d expected_body_3

noncomputable def actual_use_0 (A B : Type) : Type := (@_root_.cleanNotation_choose_carrier_df4a9e0db2b8ea466a5a (A) (B))
noncomputable def expected_use_0 (A B : Type) : Type := @_root_.cleanNotation_choose_carrier_df4a9e0db2b8ea466a5a A B
same_basic_target actual_use_0 expected_use_0

noncomputable def actual_use_1 (A : Type) (ha : @cleanDefine_equal_types_407ed45e8fefd3377ad8 A A) : Type := (@_root_.cleanNotation_carrier_witness_07aeca3f3dc73ce47d18 (A) (ha))
noncomputable def expected_use_1 (A : Type) (ha : @cleanDefine_equal_types_407ed45e8fefd3377ad8 A A) : Type := @_root_.cleanNotation_carrier_witness_07aeca3f3dc73ce47d18 A ha
same_basic_target actual_use_1 expected_use_1

noncomputable def actual_use_2 (n : _root_.cleanType_Natural_ed60542607241095b2d0) (hn : @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n) : _root_.cleanType_Natural_ed60542607241095b2d0 := (@_root_.cleanNotation_generic_witness_b14cc73c8df04bbc3c4c ((_root_.cleanType_Natural_ed60542607241095b2d0)) (n) (hn))
noncomputable def expected_use_2 (n : _root_.cleanType_Natural_ed60542607241095b2d0) (hn : @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n) : _root_.cleanType_Natural_ed60542607241095b2d0 := @_root_.cleanNotation_generic_witness_b14cc73c8df04bbc3c4c _root_.cleanType_Natural_ed60542607241095b2d0 n hn
same_basic_target actual_use_2 expected_use_2

noncomputable def actual_use_3 (ht : cleanDefine_truth_9233a1fb3d57223a0c34) : cleanDefine_truth_9233a1fb3d57223a0c34 := (@_root_.cleanNotation_proof_marker_b6ad7c6f314de7e6d35d (ht))
noncomputable def expected_use_3 (ht : cleanDefine_truth_9233a1fb3d57223a0c34) : cleanDefine_truth_9233a1fb3d57223a0c34 := @_root_.cleanNotation_proof_marker_b6ad7c6f314de7e6d35d ht
same_basic_target actual_use_3 expected_use_3

def expected_local : Prop := ∀ (Real : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : Real), @cleanDefine_equal_59dc0f11ba9b345348cf Real x x
same_basic_target CleanStatements.local_carrier_avoids_concrete_overload expected_local
theorem local_checked : CleanStatements.local_carrier_avoids_concrete_overload := by intro Real x; rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
