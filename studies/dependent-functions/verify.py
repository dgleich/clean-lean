# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Available.clean',e)
source=lean(rs,e,['Lean']);(here/'Available.lean').write_text(source);(here/'Available.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={'GradedOracle.GradedModule':e.structures['GradedModule']['key'],
 'GradedOracle.gradedModule':f('graded module'),'GradedOracle.componentModule':f('component module'),
 'GradedOracle.gradedHomology':f('graded singular homology')}
expected=r'''
namespace GradedOracle
structure GradedModule (K : Type) (field : Field K) : Type 1 where
  component : ℕ → @ModuleCat.{0,0} K field.toRing
noncomputable def gradedModule (K : Type) (field : Field K)
  (component : ℕ → @ModuleCat.{0,0} K field.toRing) : GradedModule K field :=
  @GradedModule.mk K field component
noncomputable def componentModule {K : Type} (field : Field K) (M : GradedModule K field) (p : ℕ) :
  @ModuleCat.{0,0} K field.toRing := M.component p
noncomputable def gradedHomology (K : Type) (field : Field K) (X : TopCat.{0}) : GradedModule K field :=
  @gradedModule K field (fun p : ℕ => @HOMOLOGY K field (@SCALAR K field p) X)
def componentStatement : Prop := ∀ (K : Type) (field : Field K) (X : TopCat.{0}) (p : ℕ),
  @componentModule K field (@gradedHomology K field X) p = @HOMOLOGY K field (@SCALAR K field p) X
end GradedOracle
'''.replace('HOMOLOGY',f('homology module')).replace('SCALAR',f('scalar homology'))
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
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
'''
checks=[f'same_target {actual} {oracle}' for oracle,actual in mapping.items()]
checks += [f"same_target {e.structures['GradedModule']['key']}.{field} GradedOracle.GradedModule.{field}" for field in ['mk','component']]
checks += ['same_target CleanStatements.graded_homology_component GradedOracle.componentStatement']
proof='''
namespace GradedProofs
theorem component : CleanStatements.graded_homology_component := by
  intro K field X p
  rfl
end GradedProofs
'''
p=here/'Verified.lean';p.write_text(source+expected+comparison+'\n'.join(checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Seven exact graded-module targets and one component proof passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
