# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent native targets for fixed universes and bundled topological spaces."""
from pathlib import Path
import os, subprocess, sys, tempfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document, type_declaration
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Spaces.clean',env)
source=lean(results,env,['Lean'])
(here/'Spaces.lean').write_text(source)
(here/'Spaces.tex').write_text(latex(results,env))
record=env.structures['TopologicalDiagram']['key']
function=lambda n:env.data['functions'][n]['lean'].split()[0]
typekey=lambda n:next(k for k in env.notation_definitions if k.startswith('cleanType_'+n+'_'))
mapping={'SpaceOracle.Diagram':record}
for n,t in [('spaceType','TopologicalSpace'),('pointType','Point'),('mapType','ContinuousMap')]:
    mapping['SpaceOracle.'+n]=typekey(t)
for n,t in [('bundle','topological space'),('topology','space topology'),
 ('underlying','underlying continuous map'),('value','continuous value'),
 ('identity','identity continuous map'),('compose','compose continuous maps'),
 ('diagram','topological diagram'),('identityDiagram','identity diagram')]:
    mapping['SpaceOracle.'+n]=function(t)
# Independent closed-sort fixtures exercise levels 0, 1 and 2.
levels=Environment()
for n,body,level in [('Zero','Nat',0),('One','Type',1),('Two','Type 1',2)]:
    type_declaration('Type '+n+'():',['Means: '+body,'Render latex: '+n,'Universe: '+str(level)],levels)
    mapping['SpaceOracle.level'+n]=next(k for k in levels.notation_definitions if k.startswith('cleanType_'+n+'_'))
source+='\n'+'\n'.join(levels.notation_definitions.values())
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
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical body differs: {a} vs {b}"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
        canonicalName x.induct == canonicalName y.induct do
      throwError "Constructor shape differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
        x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do
      throwError "Structure shape differs"
  | _,_ => throwError "Unexpected declaration kinds"
'''
expected=r'''
namespace SpaceOracle
noncomputable def levelZero : Type := Nat
noncomputable def levelOne : Type 1 := Type
noncomputable def levelTwo : Type 2 := Type 1
noncomputable def spaceType : Type 1 := TopCat.{0}
noncomputable def pointType (X : TopCat.{0}) : Type := TopCat.carrier X
noncomputable def mapType (X Y : TopCat.{0}) : Type :=
  @ContinuousMap X.carrier Y.carrier X.str Y.str
noncomputable def bundle (X : Type) (t : TopologicalSpace X) : TopCat.{0} := @TopCat.of.{0} X t
noncomputable def topology (X : TopCat.{0}) : TopologicalSpace X.carrier := TopCat.str X
noncomputable def underlying (X Y : TopCat.{0}) (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  X.carrier → Y.carrier := @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f
noncomputable def value (X Y : TopCat.{0}) (f : @ContinuousMap X.carrier Y.carrier X.str Y.str)
  (x : X.carrier) : Y.carrier := @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x
noncomputable def identity (X : TopCat.{0}) : @ContinuousMap X.carrier X.carrier X.str X.str :=
  @ContinuousMap.id X.carrier X.str
noncomputable def compose (X Y Z : TopCat.{0})
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str)
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  @ContinuousMap X.carrier Z.carrier X.str Z.str :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f
structure Diagram : Type 1 where
  source : TopCat.{0}
  target : TopCat.{0}
  arrow : @ContinuousMap source.carrier target.carrier source.str target.str
noncomputable def diagram (source target : TopCat.{0})
  (arrow : @ContinuousMap source.carrier target.carrier source.str target.str) : Diagram :=
  @Diagram.mk source target arrow
noncomputable def identityDiagram (X : TopCat.{0}) : Diagram := diagram X X (@identity X)
def identityStatement : Prop := ∀ (X : TopCat.{0}) (x : X.carrier), @value X X (@identity X) x=x
def composeStatement : Prop := ∀ (X Y Z : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str)
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str) (x : X.carrier),
  @value X Z (@compose X Y Z g f) x = @value Y Z g (@value X Y f x)
def leftIdentityStatement : Prop := ∀ (X Y : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str), @compose X Y Y (@identity Y) f=f
def diagramStatement : Prop := ∀ (X : TopCat.{0}), let D : Diagram := identityDiagram X;
  @Diagram.source D = X ∧ @Diagram.target D = X
def arrowStatement : Prop := ∀ (D : Diagram),
  @Exists (@ContinuousMap D.source.carrier D.target.carrier D.source.str D.target.str)
    (fun f => f = @Diagram.arrow D)
end SpaceOracle
'''
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target {record}.{n} SpaceOracle.Diagram.{n}' for n in ['mk','source','target','arrow']]
checks += [f'same_target CleanStatements.{n} SpaceOracle.{oracle}' for n,oracle in [
 ('continuous_identity_fixes_each_point','identityStatement'),
 ('continuous_composition_acts_pointwise','composeStatement'),
 ('identity_on_the_target_preserves_a_continuous_map','leftIdentityStatement'),
 ('identity_diagram_has_its_declared_spaces','diagramStatement'),
 ('diagram_supplies_its_continuous_map','arrowStatement')]]
proofs=r'''
namespace SpaceProofs
theorem continuous_identity_fixes_each_point : CleanStatements.continuous_identity_fixes_each_point := by
  intro X x
  rfl
theorem continuous_composition_acts_pointwise : CleanStatements.continuous_composition_acts_pointwise := by
  intro X Y Z f g x
  rfl
theorem identity_on_the_target_preserves_a_continuous_map : CleanStatements.identity_on_the_target_preserves_a_continuous_map := by
  intro X Y f
  exact ContinuousMap.id_comp f
theorem identity_diagram_has_its_declared_spaces : CleanStatements.identity_diagram_has_its_declared_spaces := by
  intro X
  exact ⟨rfl,rfl⟩
theorem diagram_supplies_its_continuous_map : CleanStatements.diagram_supplies_its_continuous_map := by
  intro D
  exact ⟨D.arrow,rfl⟩
end SpaceProofs
'''
path=here/'SpacesVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical space targets and five proofs passed.')

# Incorrect fixed sorts must fail kernel validation, not silently lift universes.
for body,diagnostic in [('noncomputable def bad : Type := TopCat.{0}', 'error: Type mismatch'),
             ('structure Bad : Type where\n  space : TopCat.{0}', 'error: Invalid universe level for field')]:
    with tempfile.TemporaryDirectory() as tmp:
        negative=Path(tmp)/'Negative.lean'
        negative.write_text('import Mathlib.Topology.Category.TopCat.Basic\n'+body+'\n')
        result=subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(negative)],
                              cwd=ROOT,capture_output=True,text=True)
        if result.returncode!=1 or diagnostic not in result.stdout:
            raise RuntimeError('Expected a Lean universe rejection: '+result.stdout+result.stderr)
print('Two incorrect-universe targets rejected by Lean.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
