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

structure cleanStructure_Box_4a6a2836658be69a9399 («T» : Type) : Type where
  «value» : «T»

noncomputable def cleanConstructor_box_value_03c58b315bf4521d26a9 («T» : Type) («value» : «T») : cleanStructure_Box_4a6a2836658be69a9399 («T») :=
  @cleanStructure_Box_4a6a2836658be69a9399.mk «T» «value»

noncomputable def cleanDefine_pack_88c633d2873b7856ca7a  (T : Type) (x : T) : cleanStructure_Box_4a6a2836658be69a9399 (T) :=
  (@cleanConstructor_box_value_03c58b315bf4521d26a9 (T) (x))

noncomputable def cleanDefine_inferred_box_deb4cdf09d5c551e8121 {T : Type} (x : T) : cleanStructure_Box_4a6a2836658be69a9399 (T) :=
  (@cleanDefine_pack_88c633d2873b7856ca7a (T) (x))

noncomputable def cleanDefine_real_box_63ea08b490e4e657e96f  (x : ℝ) : cleanStructure_Box_4a6a2836658be69a9399 (ℝ) :=
  (@cleanDefine_pack_88c633d2873b7856ca7a (ℝ) (x))

noncomputable def cleanDefine_vector_box_0da62a6ef56506a94274  (n : ℕ) (v : Fin n → ℝ) : cleanStructure_Box_4a6a2836658be69a9399 (Fin n → ℝ) :=
  (@cleanDefine_pack_88c633d2873b7856ca7a (Fin n → ℝ) (v))

noncomputable def cleanDefine_family_box_805ca8d3fe502917c27d  (f : (clean_pi_bound_0 : ℕ) → (Fin clean_pi_bound_0 → ℝ)) : cleanStructure_Box_4a6a2836658be69a9399 ((clean_pi_bound_1 : ℕ) → (Fin clean_pi_bound_1 → ℝ)) :=
  (@cleanDefine_pack_88c633d2873b7856ca7a ((clean_pi_bound_1 : ℕ) → (Fin clean_pi_bound_1 → ℝ)) (f))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: typeExpressions
reference: explicit carrier specimen
relationship: original
-/
def real_box_value : Prop :=
  ∀ (x : ℝ),
  (x = x)

/--
source: typeExpressions
reference: inferred compound carrier specimen
relationship: original
-/
def function_box_value : Prop :=
  ∀ (f : (clean_pi_bound_2 : ℕ) → (Fin clean_pi_bound_2 → ℝ)),
  ∀ (g : (clean_pi_bound_3 : ℕ) → (Fin clean_pi_bound_3 → ℝ)),
  ∀ («same» : ((cleanDefine_inferred_box_deb4cdf09d5c551e8121 (f)) = (@cleanDefine_pack_88c633d2873b7856ca7a ((clean_pi_bound_4 : ℕ) → (Fin clean_pi_bound_4 → ℝ)) (g)))),
  (f = g)

/--
source: typeExpressions
reference: indexed carrier specimen
relationship: original
-/
def vector_box_value : Prop :=
  ∀ (n : ℕ),
  ∀ (v : Fin n → ℝ),
  (v = v)

end CleanStatements

namespace TypeOracle
noncomputable def pack (T : Type) (x : T) : cleanStructure_Box_4a6a2836658be69a9399 T := cleanConstructor_box_value_03c58b315bf4521d26a9 T x
noncomputable def auto {T : Type} (x : T) : cleanStructure_Box_4a6a2836658be69a9399 T := cleanDefine_pack_88c633d2873b7856ca7a T x
noncomputable def real (x : ℝ) : cleanStructure_Box_4a6a2836658be69a9399 ℝ := cleanDefine_pack_88c633d2873b7856ca7a ℝ x
noncomputable def vector (n : ℕ) (v : Fin n → ℝ) : cleanStructure_Box_4a6a2836658be69a9399 (Fin n → ℝ) := cleanDefine_pack_88c633d2873b7856ca7a (Fin n → ℝ) v
noncomputable def family (f : (k : ℕ) → Fin k → ℝ) : cleanStructure_Box_4a6a2836658be69a9399 ((k : ℕ) → Fin k → ℝ) := cleanDefine_pack_88c633d2873b7856ca7a ((k : ℕ) → Fin k → ℝ) f
def vectorValue : Prop := ∀ (n : ℕ) (v : Fin n → ℝ), v = v
def realValue : Prop := ∀ x : ℝ, x = x
def functionValue : Prop := ∀ (f : (k : ℕ) → Fin k → ℝ) (g : (k : ℕ) → Fin k → ℝ),
 @cleanDefine_inferred_box_deb4cdf09d5c551e8121 ((k : ℕ) → Fin k → ℝ) f = cleanDefine_pack_88c633d2873b7856ca7a ((k : ℕ) → Fin k → ℝ) g → f = g
end TypeOracle

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do

  match n with
  | .str p s => return .str (canonicalName p) s
  | .num p i => return .num (canonicalName p) i
  | .anonymous => return .anonymous
private def canonical : Expr → Expr
  | .const n u => .const (canonicalName n) u
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj (canonicalName n) i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some x := env.find? a.getId | throwError "Missing actual target"
  let some y := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do
    throwError "Canonical type differs: {a} vs {b}"
  match x,y with
  | .defnInfo x,.defnInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"
  | .thmInfo x,.thmInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
same_target cleanDefine_pack_88c633d2873b7856ca7a TypeOracle.pack
same_target cleanDefine_inferred_box_deb4cdf09d5c551e8121 TypeOracle.auto
same_target cleanDefine_real_box_63ea08b490e4e657e96f TypeOracle.real
same_target cleanDefine_vector_box_0da62a6ef56506a94274 TypeOracle.vector
same_target cleanDefine_family_box_805ca8d3fe502917c27d TypeOracle.family
same_target CleanStatements.vector_box_value TypeOracle.vectorValue
same_target CleanStatements.real_box_value TypeOracle.realValue
same_target CleanStatements.function_box_value TypeOracle.functionValue

theorem vector_value_proof : CleanStatements.vector_box_value := by intro n v; rfl
theorem real_value_proof : CleanStatements.real_box_value := by intro x; rfl
theorem function_value_proof : CleanStatements.function_box_value := by
 intro f g h
 exact congrArg cleanStructure_Box_4a6a2836658be69a9399.value h

-- generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
