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

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable abbrev cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable abbrev cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable abbrev cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable abbrev cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable abbrev cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable abbrev cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable abbrev cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable abbrev cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace BasicCase0
namespace CleanStatements

/--
source: local
reference: identity
relationship: original
-/
def identity : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (x = x)

end CleanStatements
end BasicCase0

namespace BasicCase1
namespace CleanStatements

/--
source: local
reference: identity
relationship: original
-/
def identity : Prop :=
  ∀ (y : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (y = y)

end CleanStatements
end BasicCase1

namespace BasicCase2
namespace CleanStatements

/--
source: local
reference: identity
relationship: original
-/
def identity : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (x = x)

end CleanStatements
end BasicCase2

namespace BasicCase3
namespace CleanStatements

/--
source: local
reference: identity
relationship: original
-/
def identity : Prop :=
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (x = x)

end CleanStatements
end BasicCase3

def basic_real_expected : Type := ℝ
same_basic_target cleanType_Real_107b6641a486642ad8e1 basic_real_expected

def basic_expected : Prop := ∀ (x : _root_.cleanType_Real_107b6641a486642ad8e1), @Eq.{1} _root_.cleanType_Real_107b6641a486642ad8e1 x x
same_basic_target BasicCase0.CleanStatements.identity basic_expected
same_basic_target BasicCase1.CleanStatements.identity basic_expected
same_basic_target BasicCase2.CleanStatements.identity basic_expected
same_basic_target BasicCase3.CleanStatements.identity basic_expected

-- Definitional equality must not substitute for canonical structure equality.
def basic_alias : Prop := basic_expected
/-- error: Canonical type or value differs -/
#guard_msgs in
same_basic_target basic_alias basic_expected

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
