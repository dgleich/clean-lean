import Lean
import Mathlib.Data.Real.Basic

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
noncomputable def cleanType_Scalar_26f57455726c067fc151  : Type :=
  Real

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanNotation_scalar_addition_29a21dac530425fdc4d4  (x : Real) (y : Real) : Real :=
  x+y

noncomputable def cleanNotation_scalar_product_384e96fe470620f72f6f  (x : Real) (y : Real) : Real :=
  x*y

noncomputable def cleanNotation_scalar_equality_3f1c601070baec9dbb6f  (x : Real) (y : Real) : Prop :=
  x=y

noncomputable def expected_add (x y : Real) : Real := x+y
noncomputable def expected_mul (x y : Real) : Real := x*y
noncomputable def expected_eq (x y : Real) : Prop := x=y
same_basic_target cleanNotation_scalar_addition_29a21dac530425fdc4d4 expected_add
same_basic_target cleanNotation_scalar_product_384e96fe470620f72f6f expected_mul
same_basic_target cleanNotation_scalar_equality_3f1c601070baec9dbb6f expected_eq
def actual_expression (x y : Real) : Prop := (cleanNotation_scalar_equality_3f1c601070baec9dbb6f ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (x) (y))) ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (y) (x))))
def expected_expression (x y : Real) : Prop := cleanNotation_scalar_equality_3f1c601070baec9dbb6f (cleanNotation_scalar_addition_29a21dac530425fdc4d4 x y) (cleanNotation_scalar_addition_29a21dac530425fdc4d4 y x)
same_basic_target actual_expression expected_expression
noncomputable def actual_nested (x y : Real) : Real := (cleanNotation_scalar_product_384e96fe470620f72f6f (x) ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (y) (x))))
noncomputable def expected_nested (x y : Real) : Real := cleanNotation_scalar_product_384e96fe470620f72f6f x (cleanNotation_scalar_addition_29a21dac530425fdc4d4 y x)
same_basic_target actual_nested expected_nested
theorem commutative_example (x y : Real) : actual_expression x y := by
 unfold actual_expression cleanNotation_scalar_equality_3f1c601070baec9dbb6f cleanNotation_scalar_addition_29a21dac530425fdc4d4
 exact add_comm x y

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
