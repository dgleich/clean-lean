# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,sys,re,subprocess
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Statements.clean',e)
source=lean(rs,e,['Lean']);(here/'Generated.lean').write_text(source);(here/'Statements.tex').write_text(latex(rs,e))
f=lambda name:e.data['functions'][name]['lean'].split()[0]
names={k:e.structures[n]['key'] for k,n in [('SHAPE','DiagramShape'),('DIAGRAM','ModuleDiagram'),('DMAP','ModuleDiagramMap')]}
names.update({k:f(n) for k,n in [('COMMUTES','diagram maps commute'),('IDENTITY','diagram identity components'),('COMPOSITE','diagram composite components'),('CERTID','certified diagram identity'),('CERTCOMP','certified diagram composition'),('MK','diagram map'),('MID','module identity'),('COMP','module composition')]})
def fill(s):return re.sub(r'\b('+'|'.join(names)+r')\b',lambda m:names[m[0]],s)
expected=fill(r'''
namespace DiagramMapOracle
noncomputable def commutes (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y : DIAGRAM K field V E Q)
 (c : (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (Y.object v)) : Prop :=
 ∀ a : E, @COMP K field (X.object (Q.source a)) (X.object (Q.target a)) (Y.object (Q.target a)) (X.arrow a) (c (Q.target a)) =
 @COMP K field (X.object (Q.source a)) (Y.object (Q.source a)) (Y.object (Q.target a)) (c (Q.source a)) (Y.arrow a)
structure Map (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y : DIAGRAM K field V E Q) : Type where
 component : (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (Y.object v)
 commutes : @COMMUTES K field V E Q X Y component
noncomputable def identity (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X : DIAGRAM K field V E Q) : (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (X.object v) :=
 fun v : V => @MID K field (X.object v)
noncomputable def composite (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y Z : DIAGRAM K field V E Q) (f : DMAP K field V E Q X Y) (g : DMAP K field V E Q Y Z) :
 (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (Z.object v) :=
 fun v : V => @COMP K field (X.object v) (Y.object v) (Z.object v) (f.component v) (g.component v)
noncomputable def certifiedId (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X : DIAGRAM K field V E Q) (h : @COMMUTES K field V E Q X X (@IDENTITY K field V E Q X)) : DMAP K field V E Q X X :=
 @MK K field V E Q X X (@IDENTITY K field V E Q X) h
noncomputable def certifiedComp (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y Z : DIAGRAM K field V E Q) (f : DMAP K field V E Q X Y) (g : DMAP K field V E Q Y Z)
 (h : @COMMUTES K field V E Q X Z (@COMPOSITE K field V E Q X Y Z f g)) : DMAP K field V E Q X Z :=
 @MK K field V E Q X Z (@COMPOSITE K field V E Q X Y Z f g) h

def identityLaw : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X : DIAGRAM K field V E Q), @COMMUTES K field V E Q X X (@IDENTITY K field V E Q X)
def compositionLaw : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y Z : DIAGRAM K field V E Q) (f : DMAP K field V E Q X Y) (g : DMAP K field V E Q Y Z),
 @COMMUTES K field V E Q X Z (@COMPOSITE K field V E Q X Y Z f g)
def identityComponent : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X : DIAGRAM K field V E Q) (h : @COMMUTES K field V E Q X X (@IDENTITY K field V E Q X)) (v : V),
 (@IDENTITY K field V E Q X) v = @MID K field (X.object v)
def compositeComponent : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y Z : DIAGRAM K field V E Q) (f : DMAP K field V E Q X Y) (g : DMAP K field V E Q Y Z)
 (h : @COMMUTES K field V E Q X Z (@COMPOSITE K field V E Q X Y Z f g)) (v : V),
 (@COMPOSITE K field V E Q X Y Z f g) v = @COMP K field (X.object v) (Y.object v) (Z.object v) (f.component v) (g.component v)
def extensionality : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X Y : DIAGRAM K field V E Q) (f g : DMAP K field V E Q X Y),
 (∀ v : V, f.component v = g.component v) → f = g
def identityExists : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E)
 (X : DIAGRAM K field V E Q), ∃ f : DMAP K field V E Q X X, ∀ v : V, f.component v = @MID K field (X.object v)
end DiagramMapOracle
''')
mapping={'DiagramMapOracle.Map':names['DMAP'],'DiagramMapOracle.Map.mk':names['DMAP']+'.mk'}
for field in ['component','commutes']:mapping['DiagramMapOracle.Map.'+field]=names['DMAP']+'.'+field
checks=[(v,k) for k,v in mapping.items()]
for name,oracle in [('diagram maps commute','commutes'),('diagram identity components','identity'),('diagram composite components','composite'),('certified diagram identity','certifiedId'),('certified diagram composition','certifiedComp')]:checks.append((f(name),'DiagramMapOracle.'+oracle))
for name,oracle in [('identity_components_commute','identityLaw'),('composite_components_commute','compositionLaw'),('identity_diagram_component','identityComponent'),('composite_diagram_component','compositeComponent'),('diagram_map_extensionality','extensionality'),('identity_diagram_exists','identityExists')]:checks.append(('CleanStatements.'+name,'DiagramMapOracle.'+oracle))
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
proof=fill(r'''
open CategoryTheory
namespace DiagramMapProofs
theorem identityLaw : CleanStatements.identity_components_commute := by
 intro K field V E Q X
 letI : Field K := field
 change ∀ a : E, X.arrow a ≫ 𝟙 (X.object (Q.target a)) = 𝟙 (X.object (Q.source a)) ≫ X.arrow a
 intro a
 simp

theorem compositionLaw : CleanStatements.composite_components_commute := by
 intro K field V E Q X Y Z f g
 letI : Field K := field
 intro a
 apply ModuleCat.hom_ext
 ext x
 have hf := congrArg (fun h => h.hom x) (f.commutes a)
 have hg := congrArg (fun h => h.hom ((f.component (Q.source a)).hom x)) (g.commutes a)
 change (f.component (Q.target a)).hom ((X.arrow a).hom x) = (Y.arrow a).hom ((f.component (Q.source a)).hom x) at hf
 change (g.component (Q.target a)).hom ((Y.arrow a).hom ((f.component (Q.source a)).hom x)) =
  (Z.arrow a).hom ((g.component (Q.source a)).hom ((f.component (Q.source a)).hom x)) at hg
 change (g.component (Q.target a)).hom ((f.component (Q.target a)).hom ((X.arrow a).hom x)) =
  (Z.arrow a).hom ((g.component (Q.source a)).hom ((f.component (Q.source a)).hom x))
 exact (congrArg (fun y => (g.component (Q.target a)).hom y) hf).trans hg

theorem identityComponent : CleanStatements.identity_diagram_component := by
 intro K field V E Q X h v
 rfl

theorem compositeComponent : CleanStatements.composite_diagram_component := by
 intro K field V E Q X Y Z f g h v
 rfl

theorem extensionality : CleanStatements.diagram_map_extensionality := by
 intro K field V E Q X Y f g h
 have hc := funext h
 cases f with
 | mk fc fh =>
  cases g with
  | mk gc gh =>
   change fc = gc at hc
   cases hc
   rfl

theorem identityExists : CleanStatements.identity_diagram_exists := by
 intro K field V E Q X
 refine ⟨@MK K field V E Q X X (@IDENTITY K field V E Q X) (identityLaw K field V E Q X), ?_⟩
 intro v
 rfl
end DiagramMapProofs
''')
p=here/'Verified.lean';p.write_text(source+expected+comparison+'\n'.join('same_target '+a+' '+b for a,b in checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print(str(len(checks))+' exact diagram-map targets and six proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
