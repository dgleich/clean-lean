import Lean
import Mathlib.Data.Real.Basic

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Natural_ed60542607241095b2d0  : Type :=
  Nat

noncomputable abbrev cleanType_NativeReal_b95efecca0b9d98d45c9  : Type :=
  Real

noncomputable abbrev cleanType_NativeList_d4064e78eef5c8d38dc5 (T : Type) : Type :=
  List T

noncomputable abbrev cleanType_Function_c7021aafda499fb8cdb1 (T : Type) (U : Type) : Type :=
  (T) → (U)



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: constant capture regression
relationship: original
-/
def native_constant_retains_scope : Prop :=
  ∀ (Real : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (x : (_root_.cleanType_NativeReal_b95efecca0b9d98d45c9)),
  (x = x)

/--
source: local
reference: constructor capture regression
relationship: original
-/
def native_constructor_retains_scope : Prop :=
  ∀ (List : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (x : (_root_.cleanType_NativeList_d4064e78eef5c8d38dc5 ((_root_.cleanType_NativeReal_b95efecca0b9d98d45c9)))),
  (x = x)

/--
source: local
reference: declared arrow interface
relationship: original
-/
def proof_arrow_remains_structural : Prop :=
  ∀ (p q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)),
  ∀ (f : ((p)) → ((q))),
  (f = f)

/--
source: local
reference: reducible native binding
relationship: original
-/
def native_instances_remain_available : Prop :=
  ∀ (n : (_root_.cleanType_Natural_ed60542607241095b2d0)),
  ((n + n) = (n + n))

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

-- Independent adapter bodies: the mapping supplies names, never expected bodies.
def expected_type : Type 1 := Type
same_basic_target cleanType_Type_c1fed1af64ab6f12e0ed expected_type
def expected_prop : Sort 1 := Prop
same_basic_target cleanType_Proposition_ae4a13d2f060407bce35 expected_prop
def expected_nat : Type := Nat
same_basic_target cleanType_Natural_ed60542607241095b2d0 expected_nat
def expected_real : Type := Real
same_basic_target cleanType_NativeReal_b95efecca0b9d98d45c9 expected_real
def expected_list (T : Type) : Type := List T
same_basic_target cleanType_NativeList_d4064e78eef5c8d38dc5 expected_list
def expected_function (T : Type) (U : Type) : Type := T → U
same_basic_target cleanType_Function_c7021aafda499fb8cdb1 expected_function

def expected_constant : Prop := ∀ (Real : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : _root_.cleanType_NativeReal_b95efecca0b9d98d45c9), x = x
same_basic_target CleanStatements.native_constant_retains_scope expected_constant
def expected_constructor : Prop := ∀ (List : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : _root_.cleanType_NativeList_d4064e78eef5c8d38dc5 _root_.cleanType_NativeReal_b95efecca0b9d98d45c9), x = x
same_basic_target CleanStatements.native_constructor_retains_scope expected_constructor
def expected_arrow : Prop := ∀ (p q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) (f : p → q), f = f
same_basic_target CleanStatements.proof_arrow_remains_structural expected_arrow
def expected_instances : Prop := ∀ (n : _root_.cleanType_Natural_ed60542607241095b2d0), n+n = n+n
same_basic_target CleanStatements.native_instances_remain_available expected_instances

-- Deliberately give a local binder the generated global declaration's name.
def actual_generated_collision : Prop := ∀ (cleanType_NativeReal_b95efecca0b9d98d45c9 : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : (_root_.cleanType_NativeReal_b95efecca0b9d98d45c9)), x = x
def expected_generated_collision : Prop := ∀ (shadow : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (x : _root_.cleanType_NativeReal_b95efecca0b9d98d45c9), x = x
same_basic_target actual_generated_collision expected_generated_collision

theorem constant_checked : CleanStatements.native_constant_retains_scope := by intro A x; rfl
theorem constructor_checked : CleanStatements.native_constructor_retains_scope := by intro A x; rfl
theorem arrow_checked : CleanStatements.proof_arrow_remains_structural := by intro p q f; rfl
theorem instances_checked : CleanStatements.native_instances_remain_available := by intro n; rfl
theorem generated_collision_checked : actual_generated_collision := by intro A x; rfl
-- This also compares the wrapper-based statement with its ordinary mathematical reading.
theorem constant_has_original_meaning : CleanStatements.native_constant_retains_scope =
    (∀ (A : Type) (x : Real), x=x) := rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
