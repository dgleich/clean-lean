# generated: gpt-6 2026-11-07 role=assisted; experimental
from pathlib import Path
import sys,os
ROOT=Path(__file__).resolve().parents[2];here=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();r=load_document(here/'Statements.clean',e)
s=lean(r,e,['Lean'])
(here/'Generated.lean').write_text(s)
(here/'Statements.tex').write_text(latex(r,e))
print('Translated',len(r),'statements')
import ast,re,subprocess
f=lambda n:e.data['functions'][n]['lean'].split()[0]
names={'GLOBAL':f('evidence'),'POINTWISE':f('pointwise equal'),'WITNESS':e.structures['UniversalWitness']['key'],'REFLEXIVE':f('reflexive'),'CONSUME':f('consume')}
expected='''
namespace EvidenceOracle
def reflexive : Prop := ∀ x : ℕ, x = x
noncomputable def applyReflexive (h : REFLEXIVE) (n : ℕ) : n = n := h n
noncomputable def consume (g : (x : ℕ) → x = x) (n : ℕ) : n = n := g n
noncomputable def useNamed (h : REFLEXIVE) (n : ℕ) : n = n := CONSUME h n
def direct : Prop := ∀ (n : ℕ) (h : ∀ x : ℕ, x = x), let p : n = n := h n; p = p
def named : Prop := ∀ (n : ℕ) (h : REFLEXIVE), let p : n = n := h n; p = p
def nested : Prop := ∀ (n m : ℕ) (h : ∀ x y : ℕ, x+y = y+x),
 let k : ∀ y : ℕ, n+y = y+n := h n
 let p : n+m = m+n := k m
 p = p
def projected : Prop := ∀ (w : WITNESS ℕ) (n : ℕ), let p : n = n := w.all n; p = p
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
 let p : ℕ := GLOBAL n
 p = p
def inferred_carrier : Prop := ∀ (T : Type) (f g : T → T) (x : T) (h : @POINTWISE T f g),
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
'''
expected=re.sub(r'\b('+'|'.join(names)+r')\b',lambda m:names[m[0]],expected)
comparison='\nopen Lean Elab Command\nprivate def canonicalName (n : Name) : Name := Id.run do\n\n  match n with\n  | .str p s => return .str (canonicalName p) s\n  | .num p i => return .num (canonicalName p) i\n  | .anonymous => return .anonymous\nprivate def canonical : Expr → Expr\n  | .const n u => .const (canonicalName n) u\n  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i\n  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i\n  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n\n  | .app f a => .app (canonical f) (canonical a)\n  | .mdata _ b => canonical b\n  | .proj n i b => .proj (canonicalName n) i (canonical b)\n  | e => e\nelab "same_target " a:ident b:ident : command => do\n  let env ← getEnv\n  let some x := env.find? a.getId | throwError "Missing actual target"\n  let some y := env.find? b.getId | throwError "Missing expected target"\n  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do\n    throwError "Canonical type differs: {a} vs {b}"\n  match x,y with\n  | .defnInfo x,.defnInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"\n  | .thmInfo x,.thmInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"\n  | .ctorInfo x,.ctorInfo y =>\n    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&\n      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"\n  | .inductInfo x,.inductInfo y =>\n    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&\n      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"\n  | _,_ => throwError "Unexpected declaration kinds"\n'
pairs=[(f(a),b) for a,b in [('reflexive','reflexive'),('apply reflexive','applyReflexive'),('consume','consume'),('use named','useNamed'),('evidence','globalValue'),('pointwise equal','pointwise')]]+ [('CleanStatements.'+n,n) for n in ['direct','named','nested','projected','proof_domain','function_domain','captured_type','captured_free','implication','saved_assumption','local_precedence','global_fallback','inferred_carrier','existential_result','nested_function_domain']]
proof='''
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
'''
p=(here/'Verified.lean');p.write_text(s+expected+comparison+'\n'.join('same_target '+a+' EvidenceOracle.'+b for a,b in pairs)+'\n'+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Twenty-one exact targets and fifteen proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
