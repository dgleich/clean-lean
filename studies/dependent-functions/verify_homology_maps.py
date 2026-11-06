# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'HomologyMaps.clean',e)
source=lean(rs,e,['Lean']);(here/'HomologyMaps.lean').write_text(source);(here/'HomologyMaps.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={'InducedOracle.induced':f('graded homology map')}
expected=r"""
namespace InducedOracle
noncomputable def induced (K : Type) (field : Field K) (X Y : TopCat.{0})
  (g : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  MAP K field (@HSTAR K field X) (@HSTAR K field Y) :=
  @MKMAP K field (@HSTAR K field X) (@HSTAR K field Y)
    (fun p : ℕ => @HMAP K field (@SCALAR K field p) X Y g)
def componentStatement : Prop := ∀ (K : Type) (field : Field K) (X Y : TopCat.{0})
  (g : @ContinuousMap X.carrier Y.carrier X.str Y.str) (p : ℕ),
  (@induced K field X Y g).component p = @HMAP K field (@SCALAR K field p) X Y g
def identityStatement : Prop := ∀ (K : Type) (field : Field K) (X : TopCat.{0}),
  @induced K field X X (@IDENTITY X) = @GIDENTITY K field (@HSTAR K field X)
def compositionStatement : Prop := ∀ (K : Type) (field : Field K) (X Y Z : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str)
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str),
  @induced K field X Z (@COMPOSE X Y Z g f) =
    @GCOMPOSE K field (@HSTAR K field X) (@HSTAR K field Y) (@HSTAR K field Z)
      (@induced K field X Y f) (@induced K field Y Z g)
end InducedOracle
"""
substitutions={'MKMAP':f('graded map'),'HSTAR':f('graded singular homology'),
 'HMAP':f('homology linear map'),'SCALAR':f('scalar homology'),
 'GIDENTITY':f('graded identity'),'GCOMPOSE':f('graded composition'),
 'IDENTITY':f('identity continuous map'),'COMPOSE':f('compose continuous maps'),
 'GRADED':e.structures['GradedModule']['key'],'MAP':e.structures['GradedMap']['key'],
 'COEFFICIENTS':f('scalar coefficient module')}
def fill(s):
    import re
    return re.sub(r'\b('+'|'.join(substitutions)+r')\b',lambda m:substitutions[m[0]],s)
expected=fill(expected)
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
checks += ['same_target CleanStatements.graded_induced_component InducedOracle.componentStatement',
 'same_target CleanStatements.graded_induced_identity InducedOracle.identityStatement',
 'same_target CleanStatements.graded_induced_composition InducedOracle.compositionStatement']
proof=fill(r"""
set_option maxHeartbeats 1000000
namespace InducedProofs
private theorem map_ext {K : Type} {field : Field K} {M N : GRADED K field}
  (f g : MAP K field M N) (h : f.component = g.component) : f = g := by
  cases f; cases g; cases h; rfl
 theorem component : CleanStatements.graded_induced_component := by
  intro K field X Y g p
  rfl
 theorem identity : CleanStatements.graded_induced_identity := by
  intro K field X
  apply map_ext
  funext p
  letI : Field K := field
  change (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) p).obj
    (@COEFFICIENTS K field)).map (CategoryTheory.CategoryStruct.id X)) = _
  rw [CategoryTheory.Functor.map_id]
  rfl
 theorem composition : CleanStatements.graded_induced_composition := by
  intro K field X Y Z f g
  apply map_ext
  funext p
  letI : Field K := field
  change (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) p).obj
    (@COEFFICIENTS K field)).map (CategoryTheory.CategoryStruct.comp (TopCat.ofHom f) (TopCat.ofHom g))) = _
  rw [CategoryTheory.Functor.map_comp]
  rfl
end InducedProofs
""")
p=here/'HomologyMapsVerified.lean';p.write_text(source+expected+comparison+'\n'.join(checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Four exact induced graded-homology targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
