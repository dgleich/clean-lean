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
function=lambda n:env.data['functions'][n]['native_binding']
typekey=lambda n:env.data['types'][n]['native_binding']
mapping={'HomologyOracle.Theory':record,
         'HomologyOracle.ClassInSpace':env.structures['ClassInSpace']['key']}
for n,t in [('carrierType','Type'),('fieldType','FieldStructure'),('naturalType','Natural'),
            ('spaceType','TopologicalSpace'),('continuousType','ContinuousMap'),
            ('conditionType','Proposition'),('setType','Set'),('coefficientType','CoefficientModule'),('elementType','ModuleElement'),('mapType','ModuleMap'),('subspaceType','ModuleSubspace')]:
    mapping['HomologyOracle.'+n]=typekey(t)
for n,t in [('bundle','coefficient module'),('theory','homology theory'),
 ('homology','homology module'),('value','induced homology value'),('induced','induced homology map'),
 ('classInSpace','class in space'),
 ('mapValue','module map value'),('mapRange','module map range'),
 ('carrier','module subspace carrier'),('belongs','belongs to module subspace'),
 ('linear','homology linear map'),('image','homology image'),
 ('identity','identity continuous map'),('compose','compose continuous maps')]:
    mapping['HomologyOracle.'+n]=function(t)
for n,t in [('equal','equal'),('member','set member'),('equivalent','equivalence')]:
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
noncomputable abbrev carrierType : Type 1 := Type
noncomputable abbrev fieldType (K : Type) : Type := Field K
noncomputable abbrev naturalType : Type := ℕ
noncomputable abbrev spaceType : Type 1 := TopCat.{0}
noncomputable abbrev continuousType (X Y : spaceType) : Type :=
  @ContinuousMap X.carrier Y.carrier X.str Y.str
noncomputable abbrev conditionType : Sort 1 := Prop
noncomputable abbrev setType (X : Type) : Type := Set X
noncomputable def equal {T : Type} (x y : T) : conditionType := x=y
noncomputable def member {T : Type} (x : T) (A : setType T) : conditionType := x ∈ A
noncomputable def equivalent (x y : conditionType) : conditionType := x ↔ y
noncomputable def coefficientType (K : Type) (field : fieldType K) : Type 1 := @ModuleCat.{0,0} K field.toRing
noncomputable def elementType (K : Type) (field : fieldType K) (M : coefficientType K field) : Type :=
  @ModuleCat.carrier K field.toRing M
noncomputable def bundle (K : carrierType) (field : fieldType K) (V : carrierType) (L : LINEARSPACE K field V) :
  coefficientType K field := @ModuleCat.of K field.toRing V L.addition L.action
structure Theory (K : Type) (field : fieldType K) : Type 1 where
  coefficients : coefficientType K field
  degree : naturalType
noncomputable def theory (K : Type) (field : fieldType K) (R : coefficientType K field) (n : naturalType) : Theory K field :=
  @Theory.mk K field R n
noncomputable def homology {K : Type} (field : fieldType K) (H : Theory K field) (X : spaceType) :
  coefficientType K field :=
  letI : Field K := field
  ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X
noncomputable def mapType (K : Type) (field : fieldType K)
  (M N : coefficientType K field) : Type := @ModuleCat.Hom K field.toRing M N
noncomputable def subspaceType (K : Type) (field : fieldType K) (M : coefficientType K field) : Type :=
  @Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule
noncomputable def mapValue {K : Type} (field : fieldType K) (M N : coefficientType K field)
  (f : mapType K field M N) (x : elementType K field M) :
  elementType K field N := (@ModuleCat.Hom.hom K field.toRing M N f) x
noncomputable def mapRange {K : Type} (field : fieldType K) (M N : coefficientType K field)
  (f : mapType K field M N) :
  subspaceType K field N :=
  LinearMap.range (@ModuleCat.Hom.hom K field.toRing M N f)
noncomputable def carrier {K : Type} (field : fieldType K) (M : coefficientType K field)
  (U : subspaceType K field M) :
  setType (elementType K field M) := U.carrier
noncomputable def belongs {K : Type} (field : fieldType K) (M : coefficientType K field)
  (x : elementType K field M)
  (U : subspaceType K field M) : conditionType :=
  member x (@carrier K field M U)
noncomputable def linear {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) : mapType K field MX MY :=
  letI : Field K := field
  ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g)
noncomputable def value {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) (x : CX) : CY :=
  @mapValue K field MX MY (@linear K field H X Y g) x
noncomputable def image {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) :
  subspaceType K field MY :=
  @mapRange K field MX MY (@linear K field H X Y g)
noncomputable def induced {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) : CX → CY :=
  fun (x : CX) => @value K field H X Y g x
noncomputable def identity (X : spaceType) : continuousType X X :=
  @ContinuousMap.id X.carrier X.str
noncomputable def compose (X Y Z : spaceType)
  (g : continuousType Y Z)
  (f : continuousType X Y) :
  continuousType X Z :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

structure ClassInSpace (K : Type) (field : fieldType K) (H : Theory K field) : Type 1 where
  space : spaceType
  element : elementType K field (@homology K field H space)
noncomputable def classInSpace (K : Type) (field : fieldType K) (H : Theory K field)
  (space : spaceType) (element : elementType K field (@homology K field H space)) :
  ClassInSpace K field H := @ClassInSpace.mk K field H space element

def identityStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X : spaceType) (x : CX), equal (@value K field H X X (@identity X) x) x
def compositionStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X Y Z : spaceType) (f : continuousType X Y)
  (g : continuousType Y Z) (x : CX),
  equal (@value K field H X Z (@compose X Y Z g f) x) (@value K field H Y Z g (@value K field H X Y f x))
def applicationStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X Y : spaceType) (f : continuousType X Y) (x : CX),
  let h : CX → CY := @induced K field H X Y f;
  equal (h x) (@value K field H X Y f x)
def rangeStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X Y : spaceType) (f : continuousType X Y) (x : CY),
  let h : CX → CY := @induced K field H X Y f;
  let U : subspaceType K field MY := @image K field H X Y f;
  equivalent (@belongs K field MY x U) (@Exists CX (fun y => equal (h y) x))
def fieldStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (P : ClassInSpace K field H),
  @Exists (elementType K field (@homology K field H (@ClassInSpace.space K field H P)))
    (fun x => equal x (@ClassInSpace.element K field H P))
end HomologyOracle
'''
# Independently authored native class type; textual expansion only avoids repeating
# this long expression in the oracle. It does not consult the Clean translator.
for name in ['X','Y']:
    native='(elementType K field (@homology K field H '+name+'))'
    expected=expected.replace('C'+name,native)
    expected=expected.replace('M'+name,'(@homology K field H '+name+')')
expected=expected.replace('LINEARSPACE',env.structures['LinearSpace']['key'])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target {record}.{n} HomologyOracle.Theory.{n}' for n in ['mk','coefficients','degree']]
checks += [f"same_target {env.structures['ClassInSpace']['key']}.{n} HomologyOracle.ClassInSpace.{n}" for n in ['mk','space','element']]
checks += [f'same_target CleanStatements.{n} HomologyOracle.{oracle}' for n,oracle in [
 ('homology_identity_fixes_classes','identityStatement'),
 ('homology_respects_composition','compositionStatement'),
 ('induced_function_acts_on_classes','applicationStatement'),
 ('homology_image_membership','rangeStatement'),
 ('bundled_class_has_its_declared_space','fieldStatement')]]
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
theorem homology_image_membership : CleanStatements.homology_image_membership := by
  intro K field H X Y f x
  rfl
theorem bundled_class_has_its_declared_space : CleanStatements.bundled_class_has_its_declared_space := by
  intro K field H P
  exact ⟨P.element,rfl⟩
end HomologyProofs
'''
path=here/'HomologyVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical homology targets and five proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
