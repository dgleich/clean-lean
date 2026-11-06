# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Native singular homology targets and genuine functor-law proofs."""
from pathlib import Path
import os, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Homology.clean',env)
source=lean(results,env,['Lean'])
(here/'Homology.lean').write_text(source)
(here/'Homology.tex').write_text(latex(results,env))
record=env.structures['HomologyTheory']['key']
function=lambda n:env.data['functions'][n]['lean'].split()[0]
typekey=lambda n:next(k for k in env.notation_definitions if k.startswith('cleanType_'+n+'_'))
mapping={'HomologyOracle.Theory':record}
for n,t in [('coefficientType','CoefficientModule'),('elementType','ModuleElement'),('classType','HomologyClass')]:
    mapping['HomologyOracle.'+n]=typekey(t)
for n,t in [('bundle','coefficient module'),('theory','homology theory'),
 ('homology','homology module'),('value','induced homology value'),('induced','induced homology map'),
 ('identity','identity continuous map'),('compose','compose continuous maps')]:
    mapping['HomologyOracle.'+n]=function(t)
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
namespace HomologyOracle
noncomputable def coefficientType (K : Type) (field : Field K) : Type 1 := @ModuleCat.{0,0} K field.toRing
noncomputable def elementType (K : Type) (field : Field K) (M : @ModuleCat.{0,0} K field.toRing) : Type :=
  @ModuleCat.carrier K field.toRing M
noncomputable def bundle (K : Type) (field : Field K) (V : Type) (L : LINEARSPACE K field V) :
  @ModuleCat.{0,0} K field.toRing := @ModuleCat.of K field.toRing V L.addition L.action
structure Theory (K : Type) (field : Field K) : Type 1 where
  coefficients : @ModuleCat.{0,0} K field.toRing
  degree : ℕ
noncomputable def theory (K : Type) (field : Field K) (R : @ModuleCat.{0,0} K field.toRing) (n : ℕ) : Theory K field :=
  @Theory.mk K field R n
noncomputable def homology {K : Type} (field : Field K) (H : Theory K field) (X : TopCat.{0}) :
  @ModuleCat.{0,0} K field.toRing :=
  letI : Field K := field
  ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X
noncomputable def classType (K : Type) (field : Field K) (H : Theory K field) (X : TopCat.{0}) : Type := CX
noncomputable def value {K : Type} (field : Field K) (H : Theory K field) (X Y : TopCat.{0})
  (g : @ContinuousMap X.carrier Y.carrier X.str Y.str) (x : CX) : CY :=
  letI : Field K := field
  (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g)).hom x
noncomputable def induced {K : Type} (field : Field K) (H : Theory K field) (X Y : TopCat.{0})
  (g : @ContinuousMap X.carrier Y.carrier X.str Y.str) : CX → CY :=
  fun (x : CX) => @value K field H X Y g x
noncomputable def identity (X : TopCat.{0}) : @ContinuousMap X.carrier X.carrier X.str X.str :=
  @ContinuousMap.id X.carrier X.str
noncomputable def compose (X Y Z : TopCat.{0})
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str)
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  @ContinuousMap X.carrier Z.carrier X.str Z.str :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

def identityStatement : Prop := ∀ (K : Type) (field : Field K) (H : Theory K field)
  (X : TopCat.{0}) (x : CX), @value K field H X X (@identity X) x=x
def compositionStatement : Prop := ∀ (K : Type) (field : Field K) (H : Theory K field)
  (X Y Z : TopCat.{0}) (f : @ContinuousMap X.carrier Y.carrier X.str Y.str)
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str) (x : CX),
  @value K field H X Z (@compose X Y Z g f) x = @value K field H Y Z g (@value K field H X Y f x)
def applicationStatement : Prop := ∀ (K : Type) (field : Field K) (H : Theory K field)
  (X Y : TopCat.{0}) (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) (x : CX),
  let h : CX → CY := @induced K field H X Y f;
  h x = @value K field H X Y f x
end HomologyOracle
'''
# Independently authored native class type; textual expansion only avoids repeating
# this long expression in the oracle. It does not consult the Clean translator.
for name in ['X','Y']:
    native='(letI : Field K := field; ModuleCat.carrier (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj '+name+'))'
    expected=expected.replace('C'+name,native)
expected=expected.replace('LINEARSPACE',env.structures['LinearSpace']['key'])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target {record}.{n} HomologyOracle.Theory.{n}' for n in ['mk','coefficients','degree']]
checks += [f'same_target CleanStatements.{n} HomologyOracle.{oracle}' for n,oracle in [
 ('homology_identity_fixes_classes','identityStatement'),
 ('homology_respects_composition','compositionStatement'),
 ('induced_function_acts_on_classes','applicationStatement')]]
proofs=r'''
open CategoryTheory
namespace HomologyProofs
theorem homology_identity_fixes_classes : CleanStatements.homology_identity_fixes_classes := by
  intro K field H X x
  letI : Field K := field
  change (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (𝟙 X)).hom x = x
  rw [CategoryTheory.Functor.map_id]
  rfl

theorem homology_respects_composition : CleanStatements.homology_respects_composition := by
  intro K field H X Y Z f g x
  letI : Field K := field
  change (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map
    (TopCat.ofHom f ≫ TopCat.ofHom g)).hom x = _
  rw [CategoryTheory.Functor.map_comp]
  rfl

theorem induced_function_acts_on_classes : CleanStatements.induced_function_acts_on_classes := by
  intro K field H X Y f x
  rfl
end HomologyProofs
'''
path=here/'HomologyVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical homology targets and three proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
