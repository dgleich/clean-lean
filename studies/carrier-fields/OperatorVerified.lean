import Lean
import Mathlib.Topology.Basic

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_Topology_2eca621ea710e87cf174 (X : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanType_Counter_56b7a845b8b770165488  : Type :=
  Nat

noncomputable def cleanNotation_carrier_equality_6e5a650ea87b94d74074 {T : Type} (x : T) (y : T) : Prop :=
  x=y

noncomputable def cleanNotation_count_equality_dc3362d0615e08f2fc30  (x : Nat) (y : Nat) : Prop :=
  x=y

noncomputable def cleanNotation_negate_condition_8aaa3853f716694e3318  (p : Prop) : Prop :=
  ¬p

structure cleanStructure_PointedSpace_4b97411f5be9affa2443  : Type 1 where
  «carrier» : Type
  «topology» : TopologicalSpace «carrier»
  «point» : «carrier»

noncomputable def cleanConstructor_pointed_space_63873b521438f4b6aaf3 («carrier» : Type) («topology» : TopologicalSpace «carrier») («point» : «carrier») : cleanStructure_PointedSpace_4b97411f5be9affa2443 :=
  @cleanStructure_PointedSpace_4b97411f5be9affa2443.mk «carrier» «topology» «point»

noncomputable def cleanDefine_carrier_of_2a99826e44642f4a6809  (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Type :=
  (@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P))



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

noncomputable def expected_equality {T : Type} (x y : T) : Prop := x=y
noncomputable def expected_negation (p : Prop) : Prop := ¬p
same_basic_target cleanNotation_carrier_equality_6e5a650ea87b94d74074 expected_equality
same_basic_target cleanNotation_negate_condition_8aaa3853f716694e3318 expected_negation

def actual_carrier_operator (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Prop := (cleanNotation_carrier_equality_6e5a650ea87b94d74074 ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (P))) ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (P))))
def expected_carrier_operator (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Prop := @cleanNotation_carrier_equality_6e5a650ea87b94d74074 P.carrier P.point P.point
same_basic_target actual_carrier_operator expected_carrier_operator

def actual_carrier_negation (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Prop := (cleanNotation_negate_condition_8aaa3853f716694e3318 ((cleanNotation_negate_condition_8aaa3853f716694e3318 ((cleanNotation_carrier_equality_6e5a650ea87b94d74074 ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (P))) ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (P))))))))
def expected_carrier_negation (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Prop := cleanNotation_negate_condition_8aaa3853f716694e3318 (cleanNotation_negate_condition_8aaa3853f716694e3318 (@cleanNotation_carrier_equality_6e5a650ea87b94d74074 P.carrier P.point P.point))
same_basic_target actual_carrier_negation expected_carrier_negation

def actual_alias_operator (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) (x : cleanDefine_carrier_of_2a99826e44642f4a6809 P) : Prop := (cleanNotation_carrier_equality_6e5a650ea87b94d74074 (x) (x))
def expected_alias_operator (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) (x : cleanDefine_carrier_of_2a99826e44642f4a6809 P) : Prop := @cleanNotation_carrier_equality_6e5a650ea87b94d74074 (cleanDefine_carrier_of_2a99826e44642f4a6809 P) x x
same_basic_target actual_alias_operator expected_alias_operator

theorem carrier_operator_checked (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : actual_carrier_operator P := by rfl
theorem carrier_negation_checked (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : actual_carrier_negation P := by
 change ¬¬(P.point=P.point)
 intro h
 exact h rfl
theorem alias_operator_checked (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) (x : cleanDefine_carrier_of_2a99826e44642f4a6809 P) : actual_alias_operator P x := by rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
