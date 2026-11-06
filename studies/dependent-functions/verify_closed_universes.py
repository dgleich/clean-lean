# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'ClosedUniverses.clean',e)
source=lean(rs,e,['Lean']);(here/'ClosedUniverses.lean').write_text(source);(here/'ClosedUniverses.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={'UniverseOracle.Holder':e.structures['ModuleHolder']['key'],
 'UniverseOracle.Law':e.structures['ModuleLaw']['key'],
 'UniverseOracle.holder':f('module holder'),'UniverseOracle.law':f('module law'),
 'UniverseOracle.constantValue':f('constant module value'),
 'UniverseOracle.echo':f('module echo'),'UniverseOracle.identity':f('module identity operator')}
expected=r"""
namespace UniverseOracle
structure Holder (K : Type) (field : Field K) : Type 1 where
  object : @ModuleCat.{0,0} K field.toRing
structure Law (K : Type) (field : Field K) : Type where
  law : (M : @ModuleCat.{0,0} K field.toRing) → M = M
noncomputable def holder (K : Type) (field : Field K) (object : @ModuleCat.{0,0} K field.toRing) :
  Holder K field := @Holder.mk K field object
noncomputable def law (K : Type) (field : Field K)
  (law : (M : @ModuleCat.{0,0} K field.toRing) → M = M) : Law K field := @Law.mk K field law
noncomputable def echo {K : Type} (field : Field K) (M : @ModuleCat.{0,0} K field.toRing) :
  @ModuleCat.{0,0} K field.toRing := M
noncomputable def identity {K : Type} (field : Field K) :
  (@ModuleCat.{0,0} K field.toRing) → (@ModuleCat.{0,0} K field.toRing) :=
  fun M : @ModuleCat.{0,0} K field.toRing => M
noncomputable def constantValue {K : Type} (field : Field K) (n : ℕ) :
  (@ModuleCat.{0,0} K field.toRing) → ℕ :=
  fun _ : @ModuleCat.{0,0} K field.toRing => n
def holderStatement : Prop := ∀ (K : Type) (field : Field K) (M : @ModuleCat.{0,0} K field.toRing),
  let H : Holder K field := @holder K field M
  @echo K field H.object = M
def functionStatement : Prop := ∀ (K : Type) (field : Field K) (M : @ModuleCat.{0,0} K field.toRing),
  let f : (@ModuleCat.{0,0} K field.toRing) → (@ModuleCat.{0,0} K field.toRing) := @identity K field
  let N : @ModuleCat.{0,0} K field.toRing := f M
  N = M
def proofStatement : Prop := ∀ (K : Type) (field : Field K) (M : @ModuleCat.{0,0} K field.toRing)
  (law : (N : @ModuleCat.{0,0} K field.toRing) → N = N),
  let L : Law K field := @UniverseOracle.law K field law
  let h : M = M := L.law M
  M = M
end UniverseOracle
"""
rename='\n'.join(f'  if n == `{a} then return `{b}' for a,b in mapping.items())
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
checks=[f'same_target {actual} {oracle}' for oracle,actual in mapping.items()]
for name,oracle,field in [('ModuleHolder','Holder','object'),('ModuleLaw','Law','law')]:
    checks += [f"same_target {e.structures[name]['key']}.{part} UniverseOracle.{oracle}.{part}" for part in ['mk',field]]
checks += ['same_target CleanStatements.'+a+' UniverseOracle.'+b for a,b in [
 ('higher_universe_holder','holderStatement'),('higher_universe_function','functionStatement'),
 ('small_proof_field','proofStatement')]]
sorts=r"""
elab "declaration_sort " n:ident k:num : command => do
  let env ← getEnv
  let some info := env.find? n.getId | throwError "Missing declaration"
  liftTermElabM do
    let s ← Lean.Meta.whnf (← Lean.Meta.inferType info.type)
    unless s == Expr.sort (Lean.Level.ofNat k.getNat) do
      throwError "Incorrect sort: {s}"
"""
sorts+='\n'.join('declaration_sort '+f(name)+' 2' for name in
  ['module echo','module identity operator','constant module value'])
sorts+='\ndeclaration_sort '+e.structures['ModuleLaw']['key']+'.law 0\n'
proof=r"""
namespace UniverseProofs
 theorem holder : CleanStatements.higher_universe_holder := by
  intro K field M H
  rfl
 theorem identity : CleanStatements.higher_universe_function := by
  intro K field M f N
  rfl
 theorem proof_field : CleanStatements.small_proof_field := by
  intro K field M law L h
  exact h
end UniverseProofs
"""
p=here/'ClosedUniversesVerified.lean';p.write_text(source+expected+comparison+'\n'.join(checks)+sorts+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Fourteen exact closed-universe targets, four sort checks and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
