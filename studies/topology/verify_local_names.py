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
def imageStatement : Prop := ∀ (K : CARRIER) (field : FIELD K) (H : THEORY K field)
  (X : SPACE) (Q : PAIR X) (h : @COMMUTES K field H X Q),
  let M : COEFFICIENT K field := @HOMOLOGY K field H X Q.source
  let N : COEFFICIENT K field := @HOMOLOGY K field H X Q.target
  let f : MODULEMAP K field (@HOMOLOGY K field H X Q.source) (@HOMOLOGY K field H X Q.target) := @HMAP K field H X Q h
  let U : SUBMODULE K field (@HOMOLOGY K field H X Q.target) := @IMAGE K field H X Q h
  ∀ (x : ELEMENT K field N), @BELONGS K field N x U ↔
    Exists (fun (y : ELEMENT K field M) => @VALUE K field M N f y = x)
def quotientStatement : Prop := ∀ (K : CARRIER) (field : FIELD K) (H : THEORY K field)
  (X : SPACE) (Q : PAIR X) (h : @COMMUTES K field H X Q),
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
# Local names remain in authored arguments; inferred map types retain their
# original source expressions. Type wrappers are explicit declaration references.
expected=expected.replace('MAPTYPE', 'CHAINMAP K field')
expected=expected.replace('CHAINTYPE', 'CHAINCOMPLEX K field')
for token,term in [('ASOURCE','(@SINGULAR K field H (@SUBSPACE X Q.source.ambient))'),
 ('ATARGET','(@SINGULAR K field H (@SUBSPACE X Q.target.ambient))'),
 ('CSOURCE','(@CHAINS K field H X Q.source)'),('CTARGET','(@CHAINS K field H X Q.target)')]:expected=expected.replace(token,term)
subs={'THEORY':e.structures['HomologyTheory']['key'],'PAIR':e.structures['PairInclusion']['key']}
for token,name in [('COMMUTES','pair chain commutes'),('HOMOLOGY','relative homology'),('HMAP','relative homology map'),
 ('IMAGE','relative homology image'),('BELONGS','belongs to module subspace'),('VALUE','module map value'),
 ('CMAP','relative chain map'),('PROJECTION','relative chain projection'),('AMBIENT','ambient chain map'),
 ('COMPOSE','compose chain maps'),('SINGULAR','singular chains'),('SUBSPACE','subspace'),('CHAINS','relative chains')]:subs[token]='_root_.'+e.data['functions'][name]['native_binding']
for token,name in [('CARRIER','Type'),('FIELD','FieldStructure'),('SPACE','TopologicalSpace'),
                   ('COEFFICIENT','CoefficientModule'),('MODULEMAP','ModuleMap'),
                   ('ELEMENT','ModuleElement'),('SUBMODULE','ModuleSubspace'),
                   ('CHAINMAP','ChainMap'),('CHAINCOMPLEX','ModuleChainComplex')]:
    subs[token]='_root_.'+e.data['types'][name]['native_binding']
for token in sorted(subs,key=len,reverse=True):expected=expected.replace(token,subs[token])
field_type=e.data['types']['FieldStructure']['native_binding']
chain_type=e.data['types']['ModuleChainComplex']['native_binding']
map_type=e.data['types']['ChainMap']['native_binding']
expected+=f"""
noncomputable def expected_local_chain_type (K : Type) (field : _root_.{field_type} K) : Type 1 :=
  letI : Field K := field
  ChainComplex (ModuleCat.{{0}} K) ℕ
noncomputable def expected_local_chain_map (K : Type) (field : _root_.{field_type} K)
    (C D : _root_.{chain_type} K field) : Type :=
  letI : Field K := field
  @Quiver.Hom (ChainComplex (ModuleCat.{{0}} K) ℕ) inferInstance C D
"""
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
comparison+=f'\nsame_target {chain_type} expected_local_chain_type\nsame_target {map_type} expected_local_chain_map\n'
p=here/'LocalNamesVerified.lean';p.write_text(source+expected+comparison)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Four exact local-name/chain-type targets and two proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
