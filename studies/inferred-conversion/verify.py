from pathlib import Path
import os,sys,re,subprocess
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Statements.clean',e)
source=lean(rs,e,['Lean']);(here/'Generated.lean').write_text(source);(here/'Statements.tex').write_text(latex(rs,e))
f=lambda name:e.data['functions'][name]['lean'].split()[0]
names={k:e.structures[n]['key'] for k,n in [('SHAPE','DiagramShape'),('DIAGRAM','ModuleDiagram'),('SMAP','DiagramShapeMap')]}
names.update({k:f(n) for k,n in [('PULL','pull back diagram'),('MID','module identity'),('REPEAT','repeat map'),('APPLY','apply endomap'),('SIZE','matrix size'),('ENTRY','matrix entry')]})
def fill(s):return re.sub(r'\b('+'|'.join(names)+r')\b',lambda m:names[m[0]],s)
expected=fill(r'''
namespace InferredOracle
noncomputable def repeatMap {T : Type} (x : T) : T → T := fun (_ : T) => x
noncomputable def applyMap {T : Type} (f : T → T) (x : T) : T := f x
noncomputable def size {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : ℕ := n
noncomputable def entry {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) : ℝ := A i j

def pullbackIdentity : Prop := ∀ (K : Type) (field : Field K) (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F)
 (f : SMAP V E W F Q R) (M : DIAGRAM K field W F R),
 let N : DIAGRAM K field V E Q := @PULL K V E W F field Q R f M
 ∀ v : V, @MID K field (N.object v) = @MID K field (M.object (f.vertices v))
def realApplication : Prop := ∀ x y : ℝ, @APPLY ℝ (@REPEAT ℝ x) y = x
def functionApplication : Prop := ∀ f g : ℝ → ℝ, @APPLY (ℝ → ℝ) (@REPEAT (ℝ → ℝ) f) g = f
def dependentApplication : Prop := ∀ (f : (n : ℕ) → Fin n → ℝ) (g : (m : ℕ) → Fin m → ℝ),
 @APPLY ((n : ℕ) → Fin n → ℝ) (@REPEAT ((n : ℕ) → Fin n → ℝ) f) g = f
def dimensionEntry : Prop := ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ)
 (B : Matrix (Fin (@SIZE n A)) (Fin (@SIZE n A)) ℝ), B = A →
 ∀ (i j : Fin n), @ENTRY n B i j = @ENTRY n A i j
def literalSize : Prop := ∀ A : Matrix (Fin 3) (Fin 3) ℝ, @SIZE 3 A = 3
end InferredOracle
''')
checks=[]
for name,oracle in [('repeat map','repeatMap'),('apply endomap','applyMap'),('matrix size','size'),('matrix entry','entry')]:checks.append((f(name),'InferredOracle.'+oracle))
for name,oracle in [('short_pullback_identity_map','pullbackIdentity'),('real_constant_application','realApplication'),('function_constant_application','functionApplication'),('dependent_constant_application','dependentApplication'),('inferred_dimension_entry','dimensionEntry'),('literal_matrix_size','literalSize')]:checks.append(('CleanStatements.'+name,'InferredOracle.'+oracle))
rename=''
comparison='''
open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
'''+rename+'''
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
'''
proof=r'''
namespace InferredProofs
theorem pullbackIdentity : CleanStatements.short_pullback_identity_map := by
 intro K field V E W F Q R f M
 dsimp only
 intro v
 rfl
theorem realApplication : CleanStatements.real_constant_application := by
 intro x y
 rfl
theorem functionApplication : CleanStatements.function_constant_application := by
 intro f g
 rfl
theorem dependentApplication : CleanStatements.dependent_constant_application := by
 intro f g
 rfl
theorem dimensionEntry : CleanStatements.inferred_dimension_entry := by
 intro n A B h i j
 cases h
 rfl
theorem literalSize : CleanStatements.literal_matrix_size := by
 intro A
 rfl
end InferredProofs
'''
p=here/'Verified.lean';p.write_text(source+expected+comparison+'\n'.join('same_target '+a+' '+b for a,b in checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print(str(len(checks))+' exact inferred-conversion targets and six proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
