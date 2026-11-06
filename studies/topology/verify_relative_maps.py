# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check preserved dependent Lean targets after source-level definition conversion."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'RelativeMaps.clean',env)
source=lean(results,env,['Lean'])
(here/'RelativeMaps.lean').write_text(source)
(here/'RelativeMaps.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['lean'].split()[0]
mapping={}
for oracle,name in [('projection','relative chain projection'),('commutes','pair chain commutes'),
 ('chainMap','relative chain map'),('homologyMap','relative homology map'),('image','relative homology image')]:
    mapping['RelativeMapOracle.'+oracle]=function(name)
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
  | .thmInfo x,.thmInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical proof projection differs"
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
namespace RelativeMapOracle
noncomputable def projection {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : PAIR X) : MAP((@SINGULAR K field H (@SUBSPACE X Q.ambient)),(@RELCHAINS K field H X Q)) :=
  @QUOTIENTPROJ K field (@SINGULAR K field H (@SUBSPACE X Q.relative))
    (@SINGULAR K field H (@SUBSPACE X Q.ambient)) (@PAIRMAP K field H X Q)
noncomputable def commutes {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : INCLUSION X) : Prop :=
  @COMPOSE K field A B D (@AMBIENT K field H X Q) (@PAIRMAP K field H X Q.source) =
    @COMPOSE K field A C D (@PAIRMAP K field H X Q.target) (@RELATIVE K field H X Q)
noncomputable def chainMap {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : INCLUSION X) (h : @commutes K field H X Q) :
  MAP((@RELCHAINS K field H X Q.source),(@RELCHAINS K field H X Q.target)) :=
  @QUOTIENTMAP K field A B C D (@PAIRMAP K field H X Q.source) (@PAIRMAP K field H X Q.target)
    (@RELATIVE K field H X Q) (@AMBIENT K field H X Q) h
noncomputable def homologyMap {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : INCLUSION X) (h : @commutes K field H X Q) : @ModuleCat.Hom K field.toRing MS MT :=
  @HOMOLOGYMAP K field (@RELCHAINS K field H X Q.source) (@RELCHAINS K field H X Q.target)
    (@chainMap K field H X Q h) H.degree
noncomputable def image {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : INCLUSION X) (h : @commutes K field H X Q) : SUBSPACE_T :=
  @RANGE K field MS MT (@homologyMap K field H X Q h)

def commutationStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
  (X : TopCat.{0}) (Q : INCLUSION X), @commutes K field H X Q
def quotientStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
  (X : TopCat.{0}) (Q : INCLUSION X) (h : @commutes K field H X Q),
  @COMPOSE K field B (@RELCHAINS K field H X Q.source) (@RELCHAINS K field H X Q.target)
    (@chainMap K field H X Q h) (@projection K field H X Q.source) =
  @COMPOSE K field B D (@RELCHAINS K field H X Q.target)
    (@projection K field H X Q.target) (@AMBIENT K field H X Q)
def imageStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
  (X : TopCat.{0}) (Q : INCLUSION X) (h : @commutes K field H X Q)
  (x : @ModuleCat.carrier K field.toRing MT),
  let f : @ModuleCat.Hom K field.toRing MS MT := @homologyMap K field H X Q h;
  let U : SUBSPACE_T := @image K field H X Q h;
  @BELONGS K field MT x U ↔ @Exists (@ModuleCat.carrier K field.toRing MS)
    (fun y => @VALUE K field MS MT f y = x)
end RelativeMapOracle
'''
# Independent abbreviation expansion, never reading generated Lean bodies.
import re
corners={n:f'(@SINGULAR K field H (@SUBSPACE X Q.{pair}.{subset}))'
         for n,pair,subset in [('A','source','relative'),('B','source','ambient'),
                              ('C','target','relative'),('D','target','ambient')]}
expected=re.sub(r'\b[A-D]\b',lambda m:corners[m[0]],expected)
expected=expected.replace('SUBSPACE_T','(@Submodule K MT.carrier field.toSemiring MT.isAddCommGroup.toAddCommMonoid MT.isModule)')
expected=expected.replace('MS','(@RELHOMOLOGY K field H X Q.source)').replace('MT','(@RELHOMOLOGY K field H X Q.target)')
while 'MAP(' in expected:
    start=expected.index('MAP(');i=start+4;depth=0;split=None
    while True:
        ch=expected[i]
        if ch=='(':depth+=1
        elif ch==')':
            if depth==0:break
            depth-=1
        elif ch==',' and depth==0:split=i
        i+=1
    a,b=expected[start+4:split],expected[split+1:i]
    expected=expected[:start]+f'(letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{{0}} K) ℕ) inferInstance {a} {b})'+expected[i+1:]
substitutions={'THEORY':env.structures['HomologyTheory']['key'],'PAIR':env.structures['TopologicalPair']['key'],
               'INCLUSION':env.structures['PairInclusion']['key']}
for placeholder,name in [('SINGULAR','singular chains'),('SUBSPACE','subspace'),('RELCHAINS','relative chains'),
 ('RELHOMOLOGY','relative homology'),('QUOTIENTPROJ','chain cokernel projection'),('PAIRMAP','pair chain inclusion'),
 ('COMPOSE','compose chain maps'),('AMBIENT','ambient chain map'),('RELATIVE','relative subset chain map'),
 ('QUOTIENTMAP','chain cokernel map'),('HOMOLOGYMAP','induced chain homology map'),('RANGE','module map range'),
 ('BELONGS','belongs to module subspace'),('VALUE','module map value')]:substitutions[placeholder]=function(name)
# Longest names first avoids replacing PAIR inside PAIRMAP.
for placeholder in sorted(substitutions,key=len,reverse=True):expected=expected.replace(placeholder,substitutions[placeholder])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target CleanStatements.{name} RelativeMapOracle.{oracle}' for name,oracle in [
 ('pair_chain_commutativity','commutationStatement'),('relative_quotient_maps_commute','quotientStatement'),
 ('relative_homology_image_membership','imageStatement')]]
proofs=r'''
namespace RelativeMapProofs
theorem pair_chain_commutativity : CleanStatements.pair_chain_commutativity := by
  intro K field H X Q
  letI : Field K := field
  simp only [COMMUTES, COMPOSE, PAIRMAP, INDUCED, AMBIENT, RELATIVE]
  rw [← CategoryTheory.Functor.map_comp, ← CategoryTheory.Functor.map_comp]
  rfl
theorem relative_quotient_maps_commute : CleanStatements.relative_quotient_maps_commute := by
  intro K field H X Q h
  letI : Field K := field
  exact CategoryTheory.Limits.cokernel.π_desc _ _ _
theorem relative_homology_image_membership : CleanStatements.relative_homology_image_membership := by
  intro K field H X Q h x
  rfl
end RelativeMapProofs
'''
substitutions.update(COMMUTES=function('pair chain commutes'),INDUCED=function('induced chain map'))
for placeholder in sorted(substitutions,key=len,reverse=True):proofs=proofs.replace(placeholder,substitutions[placeholder])
path=here/'RelativeMapsVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical relative-map targets and three proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
