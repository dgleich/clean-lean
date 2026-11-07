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

noncomputable def cleanDefine_reflexive_4f4bdb92e4dde5841aed   : Prop :=
  (∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))

noncomputable def cleanDefine_apply_reflexive_f2f3d852140cc1a3472e  (h : ((cleanDefine_reflexive_4f4bdb92e4dde5841aed))) (n : ℕ) : ((n = n)) :=
  (h n)

noncomputable def cleanDefine_consume_e82178d728e2b6b6a6e1  (g : (clean_pi_bound_0 : ℕ) → (((clean_pi_bound_0 = clean_pi_bound_0)))) (n : ℕ) : ((n = n)) :=
  (g n)

noncomputable def cleanDefine_use_named_b4c9187c0f53cc4d03d8  (h : ((cleanDefine_reflexive_4f4bdb92e4dde5841aed))) (n : ℕ) : ((n = n)) :=
  (@cleanDefine_consume_e82178d728e2b6b6a6e1 (h) (n))

noncomputable def cleanNotation_evidence_26ab725aaf66e3ab7c0f  (n : ℕ) : ℕ :=
  n+1

noncomputable def cleanDefine_pointwise_equal_cff4bb151ed55d2402d4 {T : Type} (f : (T) → (T)) (g : (T) → (T)) : Prop :=
  (∀ (clean_bound_0 : T), ((f clean_bound_0) = (g clean_bound_0)))

structure cleanStructure_UniversalWitness_3195751a509d392dc4d5 («T» : Type) : Type where
  «all» : ((∀ (clean_bound_0 : «T»), (clean_bound_0 = clean_bound_0)))

noncomputable def cleanConstructor_universal_witness_24995374acd51ecd8578 («T» : Type) («all» : ((∀ (clean_bound_0 : «T»), (clean_bound_0 = clean_bound_0)))) : cleanStructure_UniversalWitness_3195751a509d392dc4d5 («T») :=
  @cleanStructure_UniversalWitness_3195751a509d392dc4d5.mk «T» «all»


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: evidence
reference: direct assumption
relationship: original
-/
def direct : Prop :=
  ∀ (n : ℕ),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))),
  let p : ((n = n)) := («h» n);
  (p = p)

/--
source: evidence
reference: named assumption
relationship: original
-/
def named : Prop :=
  ∀ (n : ℕ),
  ∀ («h» : (cleanDefine_reflexive_4f4bdb92e4dde5841aed)),
  let p : ((n = n)) := («h» n);
  (p = p)

/--
source: evidence
reference: nested assumption
relationship: original
-/
def nested : Prop :=
  ∀ (n m : ℕ),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (∀ (clean_bound_1 : ℕ), ((clean_bound_0 + clean_bound_1) = (clean_bound_1 + clean_bound_0))))),
  let k : ((∀ (clean_bound_0 : ℕ), ((n + clean_bound_0) = (clean_bound_0 + n)))) := («h» n);
  let p : (((n + m) = (m + n))) := (k m);
  (p = p)

/--
source: evidence
reference: projected universal evidence
relationship: original
-/
def projected : Prop :=
  ∀ (w : cleanStructure_UniversalWitness_3195751a509d392dc4d5 (ℕ)),
  ∀ (n : ℕ),
  let p : ((n = n)) := ((@cleanStructure_UniversalWitness_3195751a509d392dc4d5.«all» (ℕ) (w)) n);
  (p = p)

/--
source: evidence
reference: universal evidence as an argument
relationship: original
-/
def proof_domain : Prop :=
  ∀ («r» : (∀ (clean_bound_0 : ((∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0)))), (∀ (clean_bound_1 : ℕ), (clean_bound_1 = clean_bound_1)))),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))),
  ∀ (n : ℕ),
  let k : ((∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))) := («r» «h»);
  let p : ((n = n)) := (k n);
  (p = p)

/--
source: evidence
reference: proof family as an argument
relationship: original
-/
def function_domain : Prop :=
  ∀ («r» : (∀ (clean_bound_0 : (clean_pi_bound_1 : ℕ) → (((clean_pi_bound_1 = clean_pi_bound_1)))), (∀ (clean_bound_1 : ℕ), (clean_bound_1 = clean_bound_1)))),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))),
  ∀ (n : ℕ),
  let k : ((∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))) := («r» «h»);
  let p : ((n = n)) := (k n);
  (p = p)

/--
source: evidence
reference: type scope preservation
relationship: original
-/
def captured_type : Prop :=
  ∀ («h» : (∀ (clean_bound_0 : ℝ), (clean_bound_0 = clean_bound_0))),
  ∀ (z : ℝ),
  ∀ (Real : Type),
  let p : ((z = z)) := («h» z);
  (p = p)

/--
source: evidence
reference: free variable preservation
relationship: original
-/
def captured_free : Prop :=
  ∀ (n : ℕ),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (∀ (clean_bound_1 : ℕ), ((clean_bound_0 + clean_bound_1) = n)))),
  ∀ (y : ℕ),
  let k : ((∀ (clean_bound_0 : ℕ), ((y + clean_bound_0) = n))) := («h» y);
  let p : (((y + n) = n)) := (k n);
  (p = p)

/--
source: evidence
reference: implication application
relationship: original
-/
def implication : Prop :=
  ∀ (n : ℕ),
  ∀ («h» : ((n = 0) → (n = n))),
  ∀ («p» : (n = 0)),
  let q : ((n = n)) := («h» «p»);
  (q = q)

/--
source: evidence
reference: local evidence alias
relationship: original
-/
def saved_assumption : Prop :=
  ∀ («all» : (∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))),
  let h : ((∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))) := «all»;
  ∀ (n : ℕ),
  let p : ((n = n)) := (h n);
  (p = p)

/--
source: evidence
reference: callable local precedence
relationship: original
-/
def local_precedence : Prop :=
  ∀ (n : ℕ),
  ∀ («evidence» : (∀ (clean_bound_0 : ℕ), (clean_bound_0 = clean_bound_0))),
  let p : ((n = n)) := («evidence» n);
  (p = p)

/--
source: evidence
reference: noncallable local preserves module resolution
relationship: original
-/
def global_fallback : Prop :=
  ∀ (n : ℕ),
  ∀ («evidence» : (n = n)),
  let p : ℕ := (cleanNotation_evidence_26ab725aaf66e3ab7c0f (n));
  (p = p)

/--
source: evidence
reference: inferred condition carrier
relationship: original
-/
def inferred_carrier : Prop :=
  ∀ (T : Type),
  ∀ (f g : (T) → (T)),
  ∀ (x : T),
  ∀ («h» : (cleanDefine_pointwise_equal_cff4bb151ed55d2402d4 (f) (g))),
  let p : (((f x) = (g x))) := («h» x);
  (p = p)

/--
source: evidence
reference: existential proof as result
relationship: original
-/
def existential_result : Prop :=
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (@Exists (ℕ) (fun (clean_bound_1 : ℕ) => (clean_bound_0 = clean_bound_1))))),
  ∀ (n : ℕ),
  let p : ((@Exists (ℕ) (fun (clean_bound_0 : ℕ) => (n = clean_bound_0)))) := («h» n);
  (p = p)

/--
source: evidence
reference: nested proof-family argument
relationship: original
-/
def nested_function_domain : Prop :=
  ∀ (n : ℕ),
  ∀ («r» : (∀ (clean_bound_0 : (clean_pi_bound_1 : ℕ) → ((clean_pi_bound_2 : ℕ) → ((((clean_pi_bound_1 + clean_pi_bound_2) = (clean_pi_bound_2 + clean_pi_bound_1)))))), (n = n))),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (∀ (clean_bound_1 : ℕ), ((clean_bound_0 + clean_bound_1) = (clean_bound_1 + clean_bound_0))))),
  let p : ((n = n)) := («r» «h»);
  (p = p)

end CleanStatements

namespace EvidenceOracle
def reflexive : Prop := ∀ x : ℕ, x = x
noncomputable def applyReflexive (h : cleanDefine_reflexive_4f4bdb92e4dde5841aed) (n : ℕ) : n = n := h n
noncomputable def consume (g : (x : ℕ) → x = x) (n : ℕ) : n = n := g n
noncomputable def useNamed (h : cleanDefine_reflexive_4f4bdb92e4dde5841aed) (n : ℕ) : n = n := cleanDefine_consume_e82178d728e2b6b6a6e1 h n
def direct : Prop := ∀ (n : ℕ) (h : ∀ x : ℕ, x = x), let p : n = n := h n; p = p
def named : Prop := ∀ (n : ℕ) (h : cleanDefine_reflexive_4f4bdb92e4dde5841aed), let p : n = n := h n; p = p
def nested : Prop := ∀ (n m : ℕ) (h : ∀ x y : ℕ, x+y = y+x),
 let k : ∀ y : ℕ, n+y = y+n := h n
 let p : n+m = m+n := k m
 p = p
def projected : Prop := ∀ (w : cleanStructure_UniversalWitness_3195751a509d392dc4d5 ℕ) (n : ℕ), let p : n = n := w.all n; p = p
def proof_domain : Prop := ∀ (r : (h : ∀ x : ℕ, x = x) → ∀ n : ℕ, n = n) (h : ∀ x : ℕ, x = x) (n : ℕ),
 let k : ∀ n : ℕ, n = n := r h
 let p : n = n := k n
 p = p
def function_domain : Prop := ∀ (r : (h : (x : ℕ) → x = x) → ∀ n : ℕ, n = n) (h : ∀ x : ℕ, x = x) (n : ℕ),
 let k : ∀ n : ℕ, n = n := r h
 let p : n = n := k n
 p = p
def captured_type : Prop := ∀ (h : ∀ x : ℝ, x = x) (z : ℝ) (Real : Type),
 let p : z = z := h z
 p = p
def captured_free : Prop := ∀ (n : ℕ) (h : ∀ x y : ℕ, x+y = n) (y : ℕ),
 let k : ∀ a : ℕ, y+a = n := h y
 let p : y+n = n := k n
 p = p
def implication : Prop := ∀ (n : ℕ) (h : n = 0 → n = n) (p : n = 0),
 let q : n = n := h p
 q = q
def saved_assumption : Prop := ∀ (all : ∀ x : ℕ, x = x),
 let h : ∀ x : ℕ, x = x := all
 ∀ n : ℕ, let p : n = n := h n; p = p
noncomputable def globalValue (n : ℕ) : ℕ := n+1
def pointwise {T : Type} (f g : T → T) : Prop := ∀ x : T, f x = g x
def local_precedence : Prop := ∀ (n : ℕ) (evidence : ∀ x : ℕ, x = x),
 let p : n = n := evidence n
 p = p
def global_fallback : Prop := ∀ (n : ℕ) (evidence : n = n),
 let p : ℕ := cleanNotation_evidence_26ab725aaf66e3ab7c0f n
 p = p
def inferred_carrier : Prop := ∀ (T : Type) (f g : T → T) (x : T) (h : @cleanDefine_pointwise_equal_cff4bb151ed55d2402d4 T f g),
 let p : f x = g x := h x
 p = p
def existential_result : Prop := ∀ (h : ∀ x : ℕ, ∃ y : ℕ, x = y) (n : ℕ),
 let p : ∃ y : ℕ, n = y := h n
 p = p
def nested_function_domain : Prop := ∀ (n : ℕ)
 (r : (h : (x : ℕ) → (y : ℕ) → x+y = y+x) → n = n)
 (h : ∀ x y : ℕ, x+y = y+x),
 let p : n = n := r h
 p = p
end EvidenceOracle

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
same_target cleanDefine_reflexive_4f4bdb92e4dde5841aed EvidenceOracle.reflexive
same_target cleanDefine_apply_reflexive_f2f3d852140cc1a3472e EvidenceOracle.applyReflexive
same_target cleanDefine_consume_e82178d728e2b6b6a6e1 EvidenceOracle.consume
same_target cleanDefine_use_named_b4c9187c0f53cc4d03d8 EvidenceOracle.useNamed
same_target cleanNotation_evidence_26ab725aaf66e3ab7c0f EvidenceOracle.globalValue
same_target cleanDefine_pointwise_equal_cff4bb151ed55d2402d4 EvidenceOracle.pointwise
same_target CleanStatements.direct EvidenceOracle.direct
same_target CleanStatements.named EvidenceOracle.named
same_target CleanStatements.nested EvidenceOracle.nested
same_target CleanStatements.projected EvidenceOracle.projected
same_target CleanStatements.proof_domain EvidenceOracle.proof_domain
same_target CleanStatements.function_domain EvidenceOracle.function_domain
same_target CleanStatements.captured_type EvidenceOracle.captured_type
same_target CleanStatements.captured_free EvidenceOracle.captured_free
same_target CleanStatements.implication EvidenceOracle.implication
same_target CleanStatements.saved_assumption EvidenceOracle.saved_assumption
same_target CleanStatements.local_precedence EvidenceOracle.local_precedence
same_target CleanStatements.global_fallback EvidenceOracle.global_fallback
same_target CleanStatements.inferred_carrier EvidenceOracle.inferred_carrier
same_target CleanStatements.existential_result EvidenceOracle.existential_result
same_target CleanStatements.nested_function_domain EvidenceOracle.nested_function_domain

theorem function_domain_proof : CleanStatements.function_domain := by intro r h n; rfl
theorem captured_type_proof : CleanStatements.captured_type := by intro h z Real; rfl
theorem captured_free_proof : CleanStatements.captured_free := by intro n h y; rfl
theorem implication_proof : CleanStatements.implication := by intro n h p; rfl
theorem saved_proof : CleanStatements.saved_assumption := by intro all; dsimp; intro n; rfl
theorem local_precedence_proof : CleanStatements.local_precedence := by intro n h; rfl
theorem global_fallback_proof : CleanStatements.global_fallback := by intro n h; rfl
theorem inferred_carrier_proof : CleanStatements.inferred_carrier := by intro T f g x h; rfl
theorem existential_result_proof : CleanStatements.existential_result := by intro h n; rfl
theorem nested_function_domain_proof : CleanStatements.nested_function_domain := by intro n r h; rfl
theorem direct_proof : CleanStatements.direct := by intro n h; rfl
theorem named_proof : CleanStatements.named := by intro n h; rfl
theorem projected_proof : CleanStatements.projected := by intro w n; rfl
theorem domain_proof : CleanStatements.proof_domain := by intro r h n; rfl
theorem nested_proof : CleanStatements.nested := by intro n m h; rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
