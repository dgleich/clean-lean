# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Compare native propositions with explicit lets and check two supporting proofs."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'LocalNames.clean',e)
source=lean(rs,e,['Lean'])
(here/'LocalNames.lean').write_text(source)
(here/'LocalNames.tex').write_text(latex(rs,e))
expected=r'''
namespace LocalNamesOracle
def imageStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
  (X : TopCat.{0}) (Q : PAIR X) (h : @COMMUTES K field H X Q),
  let M : @ModuleCat.{0,0} K field.toRing := @HOMOLOGY K field H X Q.source
  let N : @ModuleCat.{0,0} K field.toRing := @HOMOLOGY K field H X Q.target
  let f : @ModuleCat.Hom K field.toRing (@HOMOLOGY K field H X Q.source) (@HOMOLOGY K field H X Q.target) := @HMAP K field H X Q h
  let U : @Submodule K (@HOMOLOGY K field H X Q.target).carrier field.toSemiring
    (@HOMOLOGY K field H X Q.target).isAddCommGroup.toAddCommMonoid (@HOMOLOGY K field H X Q.target).isModule := @IMAGE K field H X Q h
  ∀ (x : @ModuleCat.carrier K field.toRing N), @BELONGS K field N x U ↔
    Exists (fun (y : @ModuleCat.carrier K field.toRing M) => @VALUE K field M N f y = x)
def quotientStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
  (X : TopCat.{0}) (Q : PAIR X) (h : @COMMUTES K field H X Q),
  let A : CHAINTYPE := ASOURCE
  let B : CHAINTYPE := ATARGET
  let C : CHAINTYPE := CSOURCE
  let D : CHAINTYPE := CTARGET
  let f : MAPTYPE CSOURCE CTARGET := @CMAP K field H X Q h
  let p : MAPTYPE ASOURCE CSOURCE := @PROJECTION K field H X Q.source
  let q : MAPTYPE ATARGET CTARGET := @PROJECTION K field H X Q.target
  let g : MAPTYPE ASOURCE ATARGET := @AMBIENT K field H X Q
  @COMPOSE K field A C D f p = @COMPOSE K field A B D q g
end LocalNamesOracle
'''
# Native types and original inferred annotations are deliberate: local names are
# retained in authored arguments; they do not rewrite the inferred type of f/U.
expected=expected.replace('MAPTYPE','(fun A B : CHAINTYPE => (letI : Field K := field; A ⟶ B))')
# A beta-redex here would violate the exact-target oracle; write native type applications directly.
import re
expected=re.sub(r'\(fun A B : CHAINTYPE => \(letI : Field K := field; A ⟶ B\)\) (\w+) (\w+)',
 lambda m:'(letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance '+m[1]+' '+m[2]+')',expected)
expected=expected.replace('CHAINTYPE','(letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)')
for token,term in [('ASOURCE','(@SINGULAR K field H (@SUBSPACE X Q.source.ambient))'),
 ('ATARGET','(@SINGULAR K field H (@SUBSPACE X Q.target.ambient))'),
 ('CSOURCE','(@CHAINS K field H X Q.source)'),('CTARGET','(@CHAINS K field H X Q.target)')]:expected=expected.replace(token,term)
subs={'THEORY':e.structures['HomologyTheory']['key'],'PAIR':e.structures['PairInclusion']['key']}
for token,name in [('COMMUTES','pair chain commutes'),('HOMOLOGY','relative homology'),('HMAP','relative homology map'),
 ('IMAGE','relative homology image'),('BELONGS','belongs to module subspace'),('VALUE','module map value'),
 ('CMAP','relative chain map'),('PROJECTION','relative chain projection'),('AMBIENT','ambient chain map'),
 ('COMPOSE','compose chain maps'),('SINGULAR','singular chains'),('SUBSPACE','subspace'),('CHAINS','relative chains')]:subs[token]=e.data['functions'][name]['lean'].split()[0]
for token in sorted(subs,key=len,reverse=True):expected=expected.replace(token,subs[token])
comparison=r'''
open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual definition"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected definition"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) &&
    Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical target differs: {a} vs {b}"
same_target CleanStatements.named_relative_homology_image_membership LocalNamesOracle.imageStatement
same_target CleanStatements.named_relative_quotient_maps_commute LocalNamesOracle.quotientStatement
namespace LocalNamesProofs
theorem image_membership : CleanStatements.named_relative_homology_image_membership := by
  intro K field H X Q h
  dsimp only
  intro x
  rfl
theorem quotient_commutation : CleanStatements.named_relative_quotient_maps_commute := by
  intro K field H X Q h
  letI : Field K := field
  exact CategoryTheory.Limits.cokernel.π_desc _ _ _
end LocalNamesProofs
'''
p=here/'LocalNamesVerified.lean';p.write_text(source+expected+comparison)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Two exact local-name statement targets and two proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
