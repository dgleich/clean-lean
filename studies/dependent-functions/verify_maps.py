# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Maps.clean',e)
source=lean(rs,e,['Lean']);(here/'Maps.lean').write_text(source);(here/'Maps.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={'MapOracle.GradedMap':e.structures['GradedMap']['key'],
 'MapOracle.gradedMap':f('graded map'), 'MapOracle.identity':f('graded identity'),
 'MapOracle.compose':f('graded composition'),
 'MapOracle.moduleIdentity':f('module identity'), 'MapOracle.moduleCompose':f('module composition')}
expected=r"""
namespace MapOracle
structure GradedMap (K : Type) (field : Field K) (M N : GRADED K field) : Type where
  component : (p : ℕ) → @ModuleCat.Hom K field.toRing (M.component p) (N.component p)
noncomputable def gradedMap (K : Type) (field : Field K) (M N : GRADED K field)
  (component : (p : ℕ) → @ModuleCat.Hom K field.toRing (M.component p) (N.component p)) :
  GradedMap K field M N := @GradedMap.mk K field M N component
noncomputable def moduleIdentity {K : Type} (field : Field K) (M : @ModuleCat.{0,0} K field.toRing) :
  @ModuleCat.Hom K field.toRing M M :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing)
    (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M
noncomputable def moduleCompose {K : Type} (field : Field K) (M N P : @ModuleCat.{0,0} K field.toRing)
  (f : @ModuleCat.Hom K field.toRing M N) (g : @ModuleCat.Hom K field.toRing N P) :
  @ModuleCat.Hom K field.toRing M P :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing)
    (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g
noncomputable def identity {K : Type} (field : Field K) (M : GRADED K field) : GradedMap K field M M :=
  @gradedMap K field M M (fun p : ℕ => @moduleIdentity K field (M.component p))
noncomputable def compose {K : Type} (field : Field K) (M N P : GRADED K field)
  (f : GradedMap K field M N) (g : GradedMap K field N P) : GradedMap K field M P :=
  @gradedMap K field M P (fun p : ℕ => @moduleCompose K field
    (M.component p) (N.component p) (P.component p) (f.component p) (g.component p))
def leftIdentity : Prop := ∀ (K : Type) (field : Field K) (M N : GRADED K field)
  (f : GradedMap K field M N), @compose K field M M N (@identity K field M) f = f
def rightIdentity : Prop := ∀ (K : Type) (field : Field K) (M N : GRADED K field)
  (f : GradedMap K field M N), @compose K field M N N f (@identity K field N) = f
def associativity : Prop := ∀ (K : Type) (field : Field K) (M N P Q : GRADED K field)
  (f : GradedMap K field M N) (g : GradedMap K field N P) (h : GradedMap K field P Q),
  @compose K field M P Q (@compose K field M N P f g) h =
    @compose K field M N Q f (@compose K field N P Q g h)
end MapOracle
""".replace('GRADED',e.structures['GradedModule']['key'])
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
checks += [f"same_target {e.structures['GradedMap']['key']}.{field} MapOracle.GradedMap.{field}" for field in ['mk','component']]
checks += ['same_target CleanStatements.graded_left_identity MapOracle.leftIdentity',
           'same_target CleanStatements.graded_right_identity MapOracle.rightIdentity',
           'same_target CleanStatements.graded_associativity MapOracle.associativity']
proof=r"""
namespace MapProofs
private theorem map_ext {K : Type} {field : Field K} {M N : GRADED K field}
  (f g : MAP K field M N) (h : f.component = g.component) : f = g := by
  cases f; cases g; cases h; rfl
 theorem left_identity : CleanStatements.graded_left_identity := by
  intro K field M N f
  apply map_ext
  funext p
  exact @CategoryTheory.Category.id_comp (@ModuleCat.{0,0} K field.toRing)
      (@ModuleCat.moduleCategory.{0,0} K field.toRing) (M.component p) (N.component p) (f.component p)
 theorem right_identity : CleanStatements.graded_right_identity := by
  intro K field M N f
  apply map_ext
  funext p
  exact @CategoryTheory.Category.comp_id (@ModuleCat.{0,0} K field.toRing)
      (@ModuleCat.moduleCategory.{0,0} K field.toRing) (M.component p) (N.component p) (f.component p)
 theorem associativity : CleanStatements.graded_associativity := by
  intro K field M N P Q f g h
  apply map_ext
  funext p
  exact @CategoryTheory.Category.assoc (@ModuleCat.{0,0} K field.toRing)
    (@ModuleCat.moduleCategory.{0,0} K field.toRing) (M.component p) (N.component p)
    (P.component p) (Q.component p) (f.component p) (g.component p) (h.component p)
end MapProofs
""".replace("GRADED",e.structures["GradedModule"]["key"]).replace("MAP",e.structures["GradedMap"]["key"])
p=here/'MapsVerified.lean';p.write_text(source+expected+comparison+'\n'.join(checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Eleven exact graded-map targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
