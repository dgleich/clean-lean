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

noncomputable def cleanDefine_implication_1f3f9e2e944d6a1d3361  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (p)), q)

noncomputable def cleanDefine_negation_9dda1c9733c05d83ca6e  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ¬p

noncomputable def cleanNotation_sum_3c9f2d3f5d945f2d0680  (x : (_root_.cleanType_Natural_ed60542607241095b2d0)) (y : (_root_.cleanType_Natural_ed60542607241095b2d0)) : (_root_.cleanType_Natural_ed60542607241095b2d0) :=
  x+y

noncomputable def cleanDefine_retain_equation_28460992fa1cc57722a5 {T : Type} (x : T) (h : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (x)))) : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (x) (x))) :=
  h

noncomputable def cleanDefine_keep_quantified_5c35772c4430973f4bf5  (n : (_root_.cleanType_Natural_ed60542607241095b2d0)) (h : ((∀ (clean_bound_0 : (_root_.cleanType_Vector_05659923fab260da9b0c ((_root_.cleanNotation_sum_3c9f2d3f5d945f2d0680 (n) (n))) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) (clean_bound_0))))) : ((∀ (clean_bound_0 : (_root_.cleanType_Vector_05659923fab260da9b0c ((_root_.cleanNotation_sum_3c9f2d3f5d945f2d0680 (n) (n))) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) (clean_bound_0)))) :=
  h

noncomputable def cleanDefine_natural_equality_e5b519150babc21a67f1  (x : (_root_.cleanType_Natural_ed60542607241095b2d0)) (y : (_root_.cleanType_Natural_ed60542607241095b2d0)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_another_sum_ad19e393718154844d54  (x : (_root_.cleanType_Natural_ed60542607241095b2d0)) (y : (_root_.cleanType_Natural_ed60542607241095b2d0)) : (_root_.cleanType_Natural_ed60542607241095b2d0) :=
  (_root_.cleanNotation_sum_3c9f2d3f5d945f2d0680 (x) (y))

noncomputable def cleanDefine_another_negation_40604529997ffd7f0d1b  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ¬p



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: fixed operator selection
relationship: original
-/
def saved_equality : Prop :=
  ∀ (n : (_root_.cleanType_Natural_ed60542607241095b2d0)),
  ∀ («h» : (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (n) (n))),
  let q : ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf (n) (n))) := (@_root_.cleanDefine_retain_equation_28460992fa1cc57722a5 ((_root_.cleanType_Natural_ed60542607241095b2d0)) (n) («h»));
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (n) (n))

/--
source: local
reference: implication authored as a quantified condition
relationship: original
-/
def implication_application : Prop :=
  ∀ (P Q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)),
  ∀ («h» : (_root_.cleanDefine_implication_1f3f9e2e944d6a1d3361 (P) (Q))),
  ∀ («p» : P),
  let q : (Q) := («h» «p»);
  Q

/--
source: local
reference: fixed operator inside a binder domain
relationship: original
-/
def saved_quantified_annotation : Prop :=
  ∀ (n : (_root_.cleanType_Natural_ed60542607241095b2d0)),
  ∀ («h» : (∀ (clean_bound_0 : (_root_.cleanType_Vector_05659923fab260da9b0c ((_root_.cleanNotation_sum_3c9f2d3f5d945f2d0680 (n) (n))) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) (clean_bound_0)))),
  let q : ((∀ (clean_bound_0 : (_root_.cleanType_Vector_05659923fab260da9b0c ((_root_.cleanNotation_sum_3c9f2d3f5d945f2d0680 (n) (n))) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) (clean_bound_0)))) := (@_root_.cleanDefine_keep_quantified_5c35772c4430973f4bf5 (n) («h»));
  (∀ (clean_bound_0 : (_root_.cleanType_Vector_05659923fab260da9b0c ((_root_.cleanNotation_sum_3c9f2d3f5d945f2d0680 (n) (n))) ((_root_.cleanType_Real_8457e8182afcbbac5a10)))), (_root_.cleanDefine_equal_59dc0f11ba9b345348cf (clean_bound_0) (clean_bound_0)))

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

def expected_type : Type 1 := Type
same_basic_target cleanType_Type_c1fed1af64ab6f12e0ed expected_type
def expected_prop : Sort 1 := Prop
same_basic_target cleanType_Proposition_ae4a13d2f060407bce35 expected_prop
def expected_nat : Type := Nat
same_basic_target cleanType_Natural_ed60542607241095b2d0 expected_nat
def expected_real : Type := Real
same_basic_target cleanType_Real_8457e8182afcbbac5a10 expected_real
def expected_function (T U : Type) : Type := T → U
same_basic_target cleanType_Function_c7021aafda499fb8cdb1 expected_function
def expected_vector (n : Nat) (T : Type) : Type := Fin n → T
same_basic_target cleanType_Vector_05659923fab260da9b0c expected_vector
def expected_equal {T : Type} (x y : T) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := x=y
same_basic_target cleanDefine_equal_59dc0f11ba9b345348cf expected_equal
def expected_negation_body (p : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := ¬p
same_basic_target cleanDefine_negation_9dda1c9733c05d83ca6e expected_negation_body
noncomputable def expected_sum (x y : _root_.cleanType_Natural_ed60542607241095b2d0) : _root_.cleanType_Natural_ed60542607241095b2d0 := x+y
same_basic_target cleanNotation_sum_3c9f2d3f5d945f2d0680 expected_sum
def expected_natural_equality (x y : _root_.cleanType_Natural_ed60542607241095b2d0) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := x=y
same_basic_target cleanDefine_natural_equality_e5b519150babc21a67f1 expected_natural_equality

def actual_retained (n : _root_.cleanType_Natural_ed60542607241095b2d0) (h : @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n) := (@_root_.cleanDefine_retain_equation_28460992fa1cc57722a5 ((_root_.cleanType_Natural_ed60542607241095b2d0)) (n) (h))
def expected_retained (n : _root_.cleanType_Natural_ed60542607241095b2d0) (h : @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n) := @cleanDefine_retain_equation_28460992fa1cc57722a5 _root_.cleanType_Natural_ed60542607241095b2d0 n h
same_basic_target actual_retained expected_retained
def actual_negation (P Q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : Prop := (_root_.cleanDefine_negation_9dda1c9733c05d83ca6e ((_root_.cleanDefine_implication_1f3f9e2e944d6a1d3361 (P) (Q))))
def expected_negation (P Q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : Prop := @cleanDefine_negation_9dda1c9733c05d83ca6e (@cleanDefine_implication_1f3f9e2e944d6a1d3361 P Q)
same_basic_target actual_negation expected_negation
def expected_implication (p q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := ∀ (_ : p), q
same_basic_target cleanDefine_implication_1f3f9e2e944d6a1d3361 expected_implication
noncomputable def expected_another_sum (x y : _root_.cleanType_Natural_ed60542607241095b2d0) : _root_.cleanType_Natural_ed60542607241095b2d0 := @cleanNotation_sum_3c9f2d3f5d945f2d0680 x y
same_basic_target cleanDefine_another_sum_ad19e393718154844d54 expected_another_sum

def expected_saved : Prop := ∀ (n : _root_.cleanType_Natural_ed60542607241095b2d0) (h : @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n), let q : @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n := @cleanDefine_retain_equation_28460992fa1cc57722a5 _root_.cleanType_Natural_ed60542607241095b2d0 n h; @cleanDefine_equal_59dc0f11ba9b345348cf _root_.cleanType_Natural_ed60542607241095b2d0 n n
same_basic_target CleanStatements.saved_equality expected_saved
def expected_application : Prop := ∀ (P Q : _root_.cleanType_Proposition_ae4a13d2f060407bce35) (h : @cleanDefine_implication_1f3f9e2e944d6a1d3361 P Q) (p : P), let q : Q := h p; Q
same_basic_target CleanStatements.implication_application expected_application
def expected_quantified : Prop := ∀ (n : _root_.cleanType_Natural_ed60542607241095b2d0) (h : ∀ v : _root_.cleanType_Vector_05659923fab260da9b0c (cleanNotation_sum_3c9f2d3f5d945f2d0680 n n) _root_.cleanType_Real_8457e8182afcbbac5a10, @cleanDefine_equal_59dc0f11ba9b345348cf (_root_.cleanType_Vector_05659923fab260da9b0c (cleanNotation_sum_3c9f2d3f5d945f2d0680 n n) _root_.cleanType_Real_8457e8182afcbbac5a10) v v), let q := @cleanDefine_keep_quantified_5c35772c4430973f4bf5 n h; ∀ v : _root_.cleanType_Vector_05659923fab260da9b0c (cleanNotation_sum_3c9f2d3f5d945f2d0680 n n) _root_.cleanType_Real_8457e8182afcbbac5a10, @cleanDefine_equal_59dc0f11ba9b345348cf (_root_.cleanType_Vector_05659923fab260da9b0c (cleanNotation_sum_3c9f2d3f5d945f2d0680 n n) _root_.cleanType_Real_8457e8182afcbbac5a10) v v
same_basic_target CleanStatements.saved_quantified_annotation expected_quantified

theorem saved_checked : CleanStatements.saved_equality := by intro n h; exact h
theorem application_checked : CleanStatements.implication_application := by intro P Q h p; exact h p
theorem quantified_checked : CleanStatements.saved_quantified_annotation := by intro n h; exact h

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
