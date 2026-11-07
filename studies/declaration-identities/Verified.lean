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
namespace IdentityCase0

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
-/

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_preserve_family_676ebf8399a57319f51e  (f : (clean_pi_bound_0 : ℕ) → (((clean_pi_bound_0 = clean_pi_bound_0)))) : (clean_pi_bound_1 : ℕ) → (((clean_pi_bound_1 = clean_pi_bound_1))) :=
  f

structure cleanStructure_FamilyRecord_c7c9f831719638e19ddd («A» : Type) : Type where
  «witness» : (clean_pi_bound_2 : «A») → (((clean_pi_bound_2 = clean_pi_bound_2)))

noncomputable def cleanConstructor_family_record_50ec8c04b2a1d632b91c («A» : Type) («witness» : (clean_pi_bound_2 : «A») → (((clean_pi_bound_2 = clean_pi_bound_2)))) : cleanStructure_FamilyRecord_c7c9f831719638e19ddd («A») :=
  @cleanStructure_FamilyRecord_c7c9f831719638e19ddd.mk «A» «witness»


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

end CleanStatements
end IdentityCase0
namespace IdentityCase1

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
-/

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_unrelated_family_77170390c300c95fc170  (g : (clean_pi_bound_0 : ℕ) → (((clean_pi_bound_0 = clean_pi_bound_0)))) : (clean_pi_bound_1 : ℕ) → (((clean_pi_bound_1 = clean_pi_bound_1))) :=
  g

noncomputable def cleanNotation_preserve_family_a5bc9843212af5787f27  (f : (clean_pi_bound_2 : ℕ) → (((clean_pi_bound_2 = clean_pi_bound_2)))) : (clean_pi_bound_3 : ℕ) → (((clean_pi_bound_3 = clean_pi_bound_3))) :=
  f

structure cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07 («A» : Type) : Type where
  «witness» : (clean_pi_bound_4 : «A») → (((clean_pi_bound_4 = clean_pi_bound_4)))

noncomputable def cleanConstructor_family_record_8f5b89a2896f962d77aa («A» : Type) («witness» : (clean_pi_bound_4 : «A») → (((clean_pi_bound_4 = clean_pi_bound_4)))) : cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07 («A») :=
  @cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07.mk «A» «witness»


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

end CleanStatements
end IdentityCase1

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

noncomputable def expected_family (f : (x : Nat) → x = x) : (y : Nat) → y = y := f
same_basic_target IdentityCase0.cleanNotation_preserve_family_676ebf8399a57319f51e expected_family
same_basic_target IdentityCase1.cleanNotation_preserve_family_a5bc9843212af5787f27 expected_family
same_basic_target IdentityCase0.cleanNotation_preserve_family_676ebf8399a57319f51e IdentityCase1.cleanNotation_preserve_family_a5bc9843212af5787f27

noncomputable def changed_family (f : (x : Nat) → x = x) : (y : Nat) → y = y := fun y => Eq.refl y
/-- error: Canonical type or value differs -/
#guard_msgs in
same_basic_target expected_family changed_family

structure ExpectedRecord (A : Type) : Type where
 witness : (x : A) → x = x
noncomputable def expected_record (A : Type) (witness : (x : A) → x = x) : ExpectedRecord A :=
 @ExpectedRecord.mk A witness

private def identityCanonical (names : List (Name × Name)) : Expr → Expr
 | .const n us => .const ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) us
 | .proj n i b => .proj ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) i (identityCanonical names b)
 | .lam _ t b i => .lam Name.anonymous (identityCanonical names t) (identityCanonical names b) i
 | .forallE _ t b i => .forallE Name.anonymous (identityCanonical names t) (identityCanonical names b) i
 | .letE _ t v b n => .letE Name.anonymous (identityCanonical names t) (identityCanonical names v) (identityCanonical names b) n
 | .app f a => .app (identityCanonical names f) (identityCanonical names a)
 | .mdata _ b => identityCanonical names b
 | e => e

run_cmd do
 let env ← getEnv
 let names : List (Name × Name) := [(`IdentityCase0.cleanStructure_FamilyRecord_c7c9f831719638e19ddd, `ExpectedRecord), (`IdentityCase0.cleanStructure_FamilyRecord_c7c9f831719638e19ddd.mk, `ExpectedRecord.mk)]
 let checks : List (Name × Name) := [(`IdentityCase0.cleanStructure_FamilyRecord_c7c9f831719638e19ddd, `ExpectedRecord), (`IdentityCase0.cleanStructure_FamilyRecord_c7c9f831719638e19ddd.mk, `ExpectedRecord.mk), (`IdentityCase0.cleanStructure_FamilyRecord_c7c9f831719638e19ddd.witness, `ExpectedRecord.witness), (`IdentityCase0.cleanConstructor_family_record_50ec8c04b2a1d632b91c, `expected_record)]

 for (a,b) in checks do
  let some x := env.find? a | throwError "Missing declaration {a}"
  let some y := env.find? b | throwError "Missing oracle {b}"
  unless x.levelParams == y.levelParams && Expr.equal (identityCanonical names x.type) (identityCanonical names y.type) do
   throwError "Declaration types differ: {a}"
  match x, y with
  | .defnInfo dx, .defnInfo dy =>
    unless Expr.equal (identityCanonical names dx.value) (identityCanonical names dy.value) do
      throwError "Declaration bodies differ: {a}"
  | .thmInfo dx, .thmInfo dy =>
    unless Expr.equal (identityCanonical names dx.value) (identityCanonical names dy.value) do
      throwError "Declaration proof bodies differ: {a}"
  | .inductInfo _, .inductInfo _ => pure ()
  | .ctorInfo _, .ctorInfo _ => pure ()
  | _, _ => throwError "Declaration kinds differ: {a}"

run_cmd do
 let env ← getEnv
 let names : List (Name × Name) := [(`IdentityCase1.cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07, `ExpectedRecord), (`IdentityCase1.cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07.mk, `ExpectedRecord.mk)]
 let checks : List (Name × Name) := [(`IdentityCase1.cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07, `ExpectedRecord), (`IdentityCase1.cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07.mk, `ExpectedRecord.mk), (`IdentityCase1.cleanStructure_FamilyRecord_92bde7c54cd3d7d20a07.witness, `ExpectedRecord.witness), (`IdentityCase1.cleanConstructor_family_record_8f5b89a2896f962d77aa, `expected_record)]

 for (a,b) in checks do
  let some x := env.find? a | throwError "Missing declaration {a}"
  let some y := env.find? b | throwError "Missing oracle {b}"
  unless x.levelParams == y.levelParams && Expr.equal (identityCanonical names x.type) (identityCanonical names y.type) do
   throwError "Declaration types differ: {a}"
  match x, y with
  | .defnInfo dx, .defnInfo dy =>
    unless Expr.equal (identityCanonical names dx.value) (identityCanonical names dy.value) do
      throwError "Declaration bodies differ: {a}"
  | .thmInfo dx, .thmInfo dy =>
    unless Expr.equal (identityCanonical names dx.value) (identityCanonical names dy.value) do
      throwError "Declaration proof bodies differ: {a}"
  | .inductInfo _, .inductInfo _ => pure ()
  | .ctorInfo _, .ctorInfo _ => pure ()
  | _, _ => throwError "Declaration kinds differ: {a}"

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
