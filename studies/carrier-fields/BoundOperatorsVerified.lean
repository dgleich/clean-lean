import Lean
import Mathlib.Data.Real.Basic

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_Natural_ed60542607241095b2d0  : Type :=
  Nat

noncomputable def cleanType_Real_8457e8182afcbbac5a10  : Type :=
  Real

noncomputable def cleanType_Function_c7021aafda499fb8cdb1 (T : Type) (U : Type) : Type :=
  (T) → (U)

noncomputable def cleanType_Vector_05659923fab260da9b0c (n : Nat) (T : Type) : Type :=
  Fin n → T

noncomputable def cleanDefine_equal_8889d46b70377f06b6f8 {T : Type} (x : T) (y : T) : Prop :=
  x=y

noncomputable def cleanDefine_implication_ba1904cc71f99e319c45  (p : Prop) (q : Prop) : Prop :=
  (∀ (clean_bound_0 : (p)), q)

noncomputable def cleanDefine_negation_0b958b86593632ba33ce  (p : Prop) : Prop :=
  ¬p

noncomputable def cleanNotation_sum_2b0ba5e0330bc80f2473  (x : Nat) (y : Nat) : Nat :=
  x+y

noncomputable def cleanDefine_retain_equation_3dfebfb17b0733fa183d {T : Type} (x : T) (h : ((cleanDefine_equal_8889d46b70377f06b6f8 (x) (x)))) : ((cleanDefine_equal_8889d46b70377f06b6f8 (x) (x))) :=
  h

noncomputable def cleanDefine_keep_quantified_370c49142f6ee8890f05  (n : Nat) (h : ((∀ (clean_bound_0 : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 (n) (n)) → Real), (cleanDefine_equal_8889d46b70377f06b6f8 (clean_bound_0) (clean_bound_0))))) : ((∀ (clean_bound_0 : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 (n) (n)) → Real), (cleanDefine_equal_8889d46b70377f06b6f8 (clean_bound_0) (clean_bound_0)))) :=
  h

noncomputable def cleanDefine_natural_equality_e814707e5958f10c3f51  (x : Nat) (y : Nat) : Prop :=
  x=y

noncomputable def cleanDefine_another_sum_a5e89abfaabfd4afd990  (x : Nat) (y : Nat) : Nat :=
  (cleanNotation_sum_2b0ba5e0330bc80f2473 (x) (y))

noncomputable def cleanDefine_another_negation_30ed083638a2008799a2  (p : Prop) : Prop :=
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
  ∀ (n : Nat),
  ∀ («h» : (cleanDefine_equal_8889d46b70377f06b6f8 (n) (n))),
  let q : ((cleanDefine_equal_8889d46b70377f06b6f8 (n) (n))) := (@cleanDefine_retain_equation_3dfebfb17b0733fa183d (Nat) (n) («h»));
  (cleanDefine_equal_8889d46b70377f06b6f8 (n) (n))

/--
source: local
reference: implication authored as a quantified condition
relationship: original
-/
def implication_application : Prop :=
  ∀ (P Q : Prop),
  ∀ («h» : (cleanDefine_implication_ba1904cc71f99e319c45 (P) (Q))),
  ∀ («p» : P),
  let q : (Q) := («h» «p»);
  Q

/--
source: local
reference: fixed operator inside a binder domain
relationship: original
-/
def saved_quantified_annotation : Prop :=
  ∀ (n : Nat),
  ∀ («h» : (∀ (clean_bound_0 : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 (n) (n)) → Real), (cleanDefine_equal_8889d46b70377f06b6f8 (clean_bound_0) (clean_bound_0)))),
  let q : ((∀ (clean_bound_0 : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 (n) (n)) → Real), (cleanDefine_equal_8889d46b70377f06b6f8 (clean_bound_0) (clean_bound_0)))) := (@cleanDefine_keep_quantified_370c49142f6ee8890f05 (n) («h»));
  (∀ (clean_bound_0 : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 (n) (n)) → Real), (cleanDefine_equal_8889d46b70377f06b6f8 (clean_bound_0) (clean_bound_0)))

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

def actual_retained (n : ℕ) (h : @cleanDefine_equal_8889d46b70377f06b6f8 ℕ n n) := (@cleanDefine_retain_equation_3dfebfb17b0733fa183d (Nat) (n) (h))
def expected_retained (n : ℕ) (h : @cleanDefine_equal_8889d46b70377f06b6f8 ℕ n n) := @cleanDefine_retain_equation_3dfebfb17b0733fa183d ℕ n h
same_basic_target actual_retained expected_retained
def actual_negation (P Q : Prop) : Prop := (cleanDefine_negation_0b958b86593632ba33ce ((cleanDefine_implication_ba1904cc71f99e319c45 (P) (Q))))
def expected_negation (P Q : Prop) : Prop := @cleanDefine_negation_0b958b86593632ba33ce (@cleanDefine_implication_ba1904cc71f99e319c45 P Q)
same_basic_target actual_negation expected_negation
def expected_implication (p q : Prop) : Prop := ∀ (_ : p), q
same_basic_target cleanDefine_implication_ba1904cc71f99e319c45 expected_implication
noncomputable def expected_another_sum (x y : ℕ) : ℕ := @cleanNotation_sum_2b0ba5e0330bc80f2473 x y
same_basic_target cleanDefine_another_sum_a5e89abfaabfd4afd990 expected_another_sum

def expected_saved : Prop := ∀ (n : ℕ) (h : @cleanDefine_equal_8889d46b70377f06b6f8 ℕ n n), let q : @cleanDefine_equal_8889d46b70377f06b6f8 ℕ n n := @cleanDefine_retain_equation_3dfebfb17b0733fa183d ℕ n h; @cleanDefine_equal_8889d46b70377f06b6f8 ℕ n n
same_basic_target CleanStatements.saved_equality expected_saved
def expected_application : Prop := ∀ (P Q : Prop) (h : @cleanDefine_implication_ba1904cc71f99e319c45 P Q) (p : P), let q : Q := h p; Q
same_basic_target CleanStatements.implication_application expected_application
def expected_quantified : Prop := ∀ (n : ℕ) (h : ∀ v : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 n n) → ℝ, @cleanDefine_equal_8889d46b70377f06b6f8 (Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 n n) → ℝ) v v), let q := @cleanDefine_keep_quantified_370c49142f6ee8890f05 n h; ∀ v : Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 n n) → ℝ, @cleanDefine_equal_8889d46b70377f06b6f8 (Fin (cleanNotation_sum_2b0ba5e0330bc80f2473 n n) → ℝ) v v
same_basic_target CleanStatements.saved_quantified_annotation expected_quantified

theorem saved_checked : CleanStatements.saved_equality := by intro n h; exact h
theorem application_checked : CleanStatements.implication_application := by intro P Q h p; exact h p
theorem quantified_checked : CleanStatements.saved_quantified_annotation := by intro n h; exact h

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
