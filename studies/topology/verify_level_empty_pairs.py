# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Canonical targets and explicit empty-subspace certificates for level pairs."""
from pathlib import Path
import ast, os, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'LevelEmptyPairs.clean',env)
source=lean(results,env,['Lean']);(HERE/'LevelEmptyPairs.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('SPACE','TopologicalSpace'),('MAP','ContinuousRealMap'),('REAL','Real'),('PROP','Proposition')]}
mapping['DATA']=env.structures['SpacePairData']['key']
mapping.update({k:f(n) for k,n in [('EMPTY','empty space'),('SUBSPACE','subspace'),('EMPTYDATA','empty relative data'),('EMPTYREL','empty relative part'),('NESTED','nested pair'),('CERTIFY','certify pair data'),('LEVEL','level problem'),('EXPANDED','expanded pair'),('PERTURBED','perturbed pair'),('SHIFTED','shifted pair')]})
oracles='''
namespace LevelEmptyOracle
noncomputable def emptyData (X : SPACE) (Q : DATA X) : PROP := EMPTY (SUBSPACE X Q.relative)
def expanded : Prop := ∀ (X : SPACE) (f : MAP X) (a r : REAL), EMPTYDATA X (EXPANDED (LEVEL X f a) r)
def perturbed : Prop := ∀ (X : SPACE) (f g : MAP X) (a : REAL), EMPTYDATA X (PERTURBED (LEVEL X f a) g)
def shifted : Prop := ∀ (X : SPACE) (f : MAP X) (a t : REAL), EMPTYDATA X (SHIFTED (LEVEL X f a) t)
def nested : Prop := ∀ (X : SPACE) (Q : DATA X), EMPTYDATA X Q → NESTED X Q
def certified : Prop := ∀ (X : SPACE) (Q : DATA X), EMPTYDATA X Q → ∀ (nesting : NESTED X Q), EMPTYREL X (CERTIFY X Q nesting)
end LevelEmptyOracle

theorem expandedEmpty : CleanStatements.expanded_level_pair_has_empty_relative_data := by
 intro X f a r
 refine ⟨?_⟩
 intro x
 have hx := x.property
 change ((false = true ∧ a-r ≤ f x.val) ∧ f x.val ≤ a+r) ∨ ((false = true ∧ a-r ≤ f x.val) ∧ f x.val ≤ a+r) at hx
 simp at hx

theorem perturbedEmpty : CleanStatements.perturbed_level_pair_has_empty_relative_data := by
 intro X f g a
 refine ⟨?_⟩
 intro x
 have hx := x.property
 change (false = true ∧ g x.val = a) ∨ (false = true ∧ g x.val = a) at hx
 simp at hx

theorem shiftedEmpty : CleanStatements.shifted_level_pair_has_empty_relative_data := by
 intro X f a t
 refine ⟨?_⟩
 intro x
 have hx := x.property
 change (false = true ∧ f x.val = a+t) ∨ (false = true ∧ f x.val = a+t) at hx
 simp at hx

theorem emptyNested : CleanStatements.empty_relative_data_are_nested := by
 intro X Q empty x hx
 exact (empty.false ⟨x,hx⟩).elim

theorem certifiedEmpty : CleanStatements.certification_preserves_empty_relative_data := by
 intro X Q empty nesting
 exact empty
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f('empty relative data'),'LevelEmptyOracle.emptyData')]
pairs += [('CleanStatements.'+n,'LevelEmptyOracle.'+o) for n,o in [('expanded_level_pair_has_empty_relative_data','expanded'),('perturbed_level_pair_has_empty_relative_data','perturbed'),('shifted_level_pair_has_empty_relative_data','shifted'),('empty_relative_data_are_nested','nested'),('certification_preserves_empty_relative_data','certified')]]
path=HERE/'LevelEmptyPairsVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Six exact targets and five empty-relative-data/certification proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
