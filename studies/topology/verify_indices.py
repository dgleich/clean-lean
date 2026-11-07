# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Generate and check independent named-index target oracles and genuine proofs."""
from pathlib import Path
import os, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();rs=load_document(here/'ValueIndices.clean',env)
source=lean(rs,env,['Lean'])
(here/'ValueIndices.lean').write_text(source)
(here/'ValueIndices.tex').write_text(latex(rs,env))
pre=env.definitions['inverse image']['key']
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
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"
'''
k=lambda name:env.data['types'][name]['native_binding']
K,S,T,E,P=('_root_.'+k(name) for name in ['Type','Set','Topology','Element','Path'])
type_checks=''
for i,(name,binders,body) in enumerate([
    ('Type','','Type'),('Set','(X : Type)','Set X'),
    ('Topology','(X : Type)','TopologicalSpace X'),
    ('Element',f'(X : Type) (S : {S} X)','{x : X // x ∈ S}'),
    ('Path',f'(X : Type) (t : {T} X) (x y : X)','@Path X t x y')]):
    sort='Type 1' if name=='Type' else 'Type'
    type_checks+=f'\nnoncomputable def expected_index_type_{i} {binders} : {sort} := {body}\nsame_target {k(name)} expected_index_type_{i}\n'
expected=f"""
namespace ValueIndexOracles

def subsetElement : Prop :=
  ∀ (X : {K}) (S : {S} X) (x : {E} X S), x=x

def pathReflexivity : Prop :=
  ∀ (X : {K}) (t : {T} X) (x y : X) (p : {P} X t x y), p=p

def constantPath : Prop :=
  ∀ (X : {K}) (t : {T} X),
    ∀ (x : X), @Exists ({P} X t x x) (fun p => p=p)

def namedSubset : Prop :=
  ∀ (X Y : {K}) (f : X → Y) (S : {S} Y),
    let T : {S} X := @_root_.{pre} X Y f S
    ∀ (x : {E} X T), x=x

end ValueIndexOracles
same_target CleanStatements.subset_element_reflexivity ValueIndexOracles.subsetElement
same_target CleanStatements.path_reflexivity ValueIndexOracles.pathReflexivity
same_target CleanStatements.constant_path_exists ValueIndexOracles.constantPath
same_target CleanStatements.named_subset_expression ValueIndexOracles.namedSubset

namespace ValueIndexProofs

theorem subset_element_reflexivity : CleanStatements.subset_element_reflexivity := by
  intro X S x
  rfl

theorem path_reflexivity : CleanStatements.path_reflexivity := by
  intro X t x y p
  rfl

theorem constant_path_exists : CleanStatements.constant_path_exists := by
  intro X t x
  exact ⟨@Path.refl X t x, rfl⟩

theorem named_subset_expression : CleanStatements.named_subset_expression := by
  intro X Y f S
  dsimp
  intro x
  rfl

end ValueIndexProofs
"""
path=here/'ValueIndicesVerified.lean';path.write_text(source+comparison+type_checks+expected)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Nine canonical indexed-type/body/statement targets and four proofs passed.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
