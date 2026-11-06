# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'RelativeGraded.clean',e)
source=lean(rs,e,['Lean']);(here/'RelativeGraded.lean').write_text(source);(here/'RelativeGraded.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={
 'RelativeGradedOracle.identity':f('identity chain map'),
 'RelativeGradedOracle.graded':f('graded chain homology'),
 'RelativeGradedOracle.induced':f('graded chain homology map'),
 'RelativeGradedOracle.relative':f('graded relative homology'),
 'RelativeGradedOracle.relativeMap':f('graded relative homology map')}
substitutions={name:e.structures[source]['key'] for name,source in
 [('GRADED','GradedModule'),('MAP','GradedMap'),('THEORY','HomologyTheory'),
  ('PAIR','TopologicalPair'),('INCLUSION','PairInclusion')]}
substitutions.update({name:f(source) for name,source in
 [('MK','graded module'),('MKMAP','graded map'),('HOMOLOGY','chain homology'),
  ('HMAP','induced chain homology map'),('CHAINS','relative chains'),
  ('CHAINMAP','relative chain map'),('COMMUTES','pair chain commutes'),
  ('RELATIVE','relative homology'),('RELATIVEMAP','relative homology map'),
  ('IDENTITY','graded identity'),('COMPOSE','graded composition'),
  ('CHAINCOMPOSE','compose chain maps')]})
def fill(s):
    import re
    return re.sub(r'\b('+'|'.join(substitutions)+r')\b',lambda m:substitutions[m[0]],s)
expected=fill(r"""
namespace RelativeGradedOracle
noncomputable def identity {K : Type} (field : Field K)
 (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) :
 (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C C) :=
 (letI : Field K := field; CategoryTheory.CategoryStruct.id C)
noncomputable def graded (K : Type) (field : Field K)
 (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : GRADED K field :=
 @MK K field (fun p : ℕ => @HOMOLOGY K field C p)
noncomputable def induced (K : Type) (field : Field K)
 (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ))
 (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : MAP K field (graded K field C) (graded K field D) :=
 @MKMAP K field (graded K field C) (graded K field D)
  (fun p : ℕ => @HMAP K field C D f p)
noncomputable def relative (K : Type) (field : Field K) (H : THEORY K field)
 (X : TopCat.{0}) (P : PAIR X) : GRADED K field :=
 graded K field (@CHAINS K field H X P)
noncomputable def relativeMap (K : Type) (field : Field K) (H : THEORY K field)
 (X : TopCat.{0}) (Q : INCLUSION X) (h : @COMMUTES K field H X Q) :
 MAP K field (relative K field H X Q.source) (relative K field H X Q.target) :=
 induced K field (@CHAINS K field H X Q.source) (@CHAINS K field H X Q.target)
  (@CHAINMAP K field H X Q h)
def componentStatement : Prop := ∀ (K : Type) (field : Field K)
 (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ))
 (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) (p : ℕ),
 (induced K field C D f).component p = @HMAP K field C D f p
def identityStatement : Prop := ∀ (K : Type) (field : Field K)
 (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)),
 induced K field C C (@identity K field C) = @IDENTITY K field (graded K field C)
def compositionStatement : Prop := ∀ (K : Type) (field : Field K)
 (C D E : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ))
 (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) (g : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance D E)),
 induced K field C E (@CHAINCOMPOSE K field C D E g f) =
 @COMPOSE K field (graded K field C) (graded K field D) (graded K field E)
  (induced K field C D f) (induced K field D E g)
def relativeStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
 (X : TopCat.{0}) (P : PAIR X),
 (graded K field (@CHAINS K field H X P)).component H.degree = @RELATIVE K field H X P
def relativeMapStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
 (X : TopCat.{0}) (Q : INCLUSION X) (h : @COMMUTES K field H X Q),
 (induced K field (@CHAINS K field H X Q.source) (@CHAINS K field H X Q.target)
  (@CHAINMAP K field H X Q h)).component H.degree = @RELATIVEMAP K field H X Q h
end RelativeGradedOracle
""")
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
checks += [f'same_target CleanStatements.{actual} RelativeGradedOracle.{oracle}' for actual,oracle in
 [('graded_chain_component','componentStatement'),('graded_chain_identity','identityStatement'),
  ('graded_chain_composition','compositionStatement'),('graded_relative_component','relativeStatement'),
  ('graded_relative_map_component','relativeMapStatement')]]
proof=fill(r"""
set_option maxHeartbeats 1000000
namespace RelativeGradedProofs
private theorem map_ext {K : Type} {field : Field K} {M N : GRADED K field}
 (f g : MAP K field M N) (h : f.component = g.component) : f = g := by
 cases f; cases g; cases h; rfl
 theorem component : CleanStatements.graded_chain_component := by
 intro K field C D f p
 rfl
 theorem identity : CleanStatements.graded_chain_identity := by
 intro K field C
 apply map_ext
 funext p
 letI : Field K := field
 change (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) p).map
   (CategoryTheory.CategoryStruct.id C) = _
 rw [CategoryTheory.Functor.map_id]
 rfl
 theorem composition : CleanStatements.graded_chain_composition := by
 intro K field C D E f g
 apply map_ext
 funext p
 letI : Field K := field
 change (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) p).map
   (CategoryTheory.CategoryStruct.comp f g) = _
 rw [CategoryTheory.Functor.map_comp]
 rfl
 theorem relativeComponent : CleanStatements.graded_relative_component := by
 intro K field H X P
 rfl
 theorem relativeMapComponent : CleanStatements.graded_relative_map_component := by
 intro K field H X Q h
 rfl
end RelativeGradedProofs
""")
p=here/'RelativeGradedVerified.lean';p.write_text(source+'\nopen CategoryTheory\n'+expected+comparison+'\n'.join(checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Ten exact graded relative-homology targets and five proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
