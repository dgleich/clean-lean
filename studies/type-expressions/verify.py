from pathlib import Path
import os,sys,subprocess,re
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Statements.clean',e);source=lean(rs,e,['Lean']);(here/'Generated.lean').write_text(source);(here/'Statements.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
names={'BOX':e.structures['Box']['key'],'CTOR':f('box value'),'PACK':f('pack'),'AUTO':f('inferred box'),'REAL':f('real box'),'VECTOR':f('vector box'),'FAMILY':f('family box')}
def fill(s):return re.sub(r'\b('+'|'.join(names)+r')\b',lambda m:names[m[0]],s)
expected=fill('''
namespace TypeOracle
noncomputable def pack (T : Type) (x : T) : BOX T := CTOR T x
noncomputable def auto {T : Type} (x : T) : BOX T := PACK T x
noncomputable def real (x : ℝ) : BOX ℝ := PACK ℝ x
noncomputable def vector (n : ℕ) (v : Fin n → ℝ) : BOX (Fin n → ℝ) := PACK (Fin n → ℝ) v
noncomputable def family (f : (k : ℕ) → Fin k → ℝ) : BOX ((k : ℕ) → Fin k → ℝ) := PACK ((k : ℕ) → Fin k → ℝ) f
def vectorValue : Prop := ∀ (n : ℕ) (v : Fin n → ℝ), v = v
def realValue : Prop := ∀ x : ℝ, x = x
def functionValue : Prop := ∀ (f : (k : ℕ) → Fin k → ℝ) (g : (k : ℕ) → Fin k → ℝ),
 @AUTO ((k : ℕ) → Fin k → ℝ) f = PACK ((k : ℕ) → Fin k → ℝ) g → f = g
end TypeOracle
''')
comparison='\nopen Lean Elab Command\nprivate def canonicalName (n : Name) : Name := Id.run do\n\n  match n with\n  | .str p s => return .str (canonicalName p) s\n  | .num p i => return .num (canonicalName p) i\n  | .anonymous => return .anonymous\nprivate def canonical : Expr → Expr\n  | .const n u => .const (canonicalName n) u\n  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i\n  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i\n  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n\n  | .app f a => .app (canonical f) (canonical a)\n  | .mdata _ b => canonical b\n  | .proj n i b => .proj (canonicalName n) i (canonical b)\n  | e => e\nelab "same_target " a:ident b:ident : command => do\n  let env ← getEnv\n  let some x := env.find? a.getId | throwError "Missing actual target"\n  let some y := env.find? b.getId | throwError "Missing expected target"\n  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do\n    throwError "Canonical type differs: {a} vs {b}"\n  match x,y with\n  | .defnInfo x,.defnInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"\n  | .thmInfo x,.thmInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"\n  | .ctorInfo x,.ctorInfo y =>\n    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&\n      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"\n  | .inductInfo x,.inductInfo y =>\n    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&\n      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"\n  | _,_ => throwError "Unexpected declaration kinds"\n'
checks=[(f('pack'),'pack'),(f('inferred box'),'auto'),(f('real box'),'real'),(f('vector box'),'vector'),(f('family box'),'family'),('CleanStatements.vector_box_value','vectorValue'),('CleanStatements.real_box_value','realValue'),('CleanStatements.function_box_value','functionValue')]
proof=fill('''
theorem vector_value_proof : CleanStatements.vector_box_value := by intro n v; rfl
theorem real_value_proof : CleanStatements.real_box_value := by intro x; rfl
theorem function_value_proof : CleanStatements.function_box_value := by
 intro f g h
 exact congrArg BOX.value h
''')
p=here/'Verified.lean';p.write_text(source+expected+comparison+'\n'.join('same_target '+a+' TypeOracle.'+b for a,b in checks)+'\n'+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Eight exact targets and three proofs passed')

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
