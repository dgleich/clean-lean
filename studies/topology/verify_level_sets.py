# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent level-set targets and set identities, not a well-group proof."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'LevelSets.clean',env)
source=lean(results,env,['Lean']);(HERE/'LevelSets.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('SPACE','TopologicalSpace'),('POINT','Point'),('REAL','Real'),('SET','Set'),('MAP','ContinuousRealMap')]}
mapping['PROBLEM']=env.structures['InterlevelProblem']['key']
mapping.update({k:f(n) for k,n in [('MK','interlevel problem'),('ENDS','endpoints'),('NONE','no endpoints'),('VALUE','real map value'),('SETOF','set of'),('EQ','equal'),('LE','real at most'),('ADD','real sum'),('SUB','real difference'),('AND','conjunction'),('NOT','negation'),('MEM','set member'),('LEVEL','level problem'),('FIBER','level fiber'),('BAND','level band'),('PERTURBED','perturbed pair'),('EXPANDED','expanded pair'),('SHIFTED','shifted pair'),('PREIMAGE','inverse image'),('UNDERLYING','underlying real map'),('CLOSED','closed interval'),('EXPINTERVAL','expanded interval'),('EXPENDS','expanded endpoints'),('SHIFTENDS','shifted endpoints'),('SELECTED','selected endpoints')]})
oracles='''
namespace LevelOracle
noncomputable def problem (X : SPACE) (f : MAP X) (a : REAL) : PROBLEM := MK X f (ENDS a a) NONE
noncomputable def fiber (X : SPACE) (f : MAP X) (a : REAL) : SET (POINT X) := SETOF (fun (x : POINT X) => EQ (VALUE X f x) a)
noncomputable def band (X : SPACE) (f : MAP X) (a r : REAL) : SET (POINT X) := SETOF (fun (x : POINT X) => AND (LE (SUB a r) (VALUE X f x)) (LE (VALUE X f x) (ADD a r)))
def fiberStatement : Prop := ∀ (X : SPACE) (f g : MAP X) (a : REAL), EQ (PREIMAGE (UNDERLYING X g) (CLOSED (ENDS a a))) (FIBER X g a)
def bandStatement : Prop := ∀ (X : SPACE) (f : MAP X) (a r : REAL), EQ (PREIMAGE (UNDERLYING X f) (EXPINTERVAL (ENDS a a) r)) (BAND X f a r)
def emptyStatement : Prop := ∀ (X : SPACE) (f : MAP X) (a r : REAL) (x : POINT X), NOT (MEM x (PREIMAGE (UNDERLYING X f) (EXPENDS (ENDS a a) NONE r)))
def shiftedStatement : Prop := ∀ (X : SPACE) (f : MAP X) (a t : REAL), EQ (PREIMAGE (UNDERLYING X f) (CLOSED (SHIFTENDS (ENDS a a) t))) (FIBER X f (ADD a t))
def perturbationEmptyStatement : Prop := ∀ (X : SPACE) (f g : MAP X) (a : REAL) (x : POINT X), NOT (MEM x (PREIMAGE (UNDERLYING X g) (SELECTED (ENDS a a) NONE)))
end LevelOracle

theorem levelFiber : CleanStatements.level_pair_has_fiber := by
 intro X f g a
 ext x
 change (a ≤ g x ∧ g x ≤ a) ↔ g x = a
 constructor
 · intro h; exact le_antisymm h.2 h.1
 · intro h; simp [h]

theorem levelBand : CleanStatements.expanded_level_pair_has_band := by
 intro X f a r
 rfl

theorem levelRelativeEmpty : CleanStatements.expanded_level_pair_has_no_relative_points := by
 intro X f a r x
 change ¬ (((false = true ∧ a-r ≤ f x) ∧ f x ≤ a+r) ∨ ((false = true ∧ a-r ≤ f x) ∧ f x ≤ a+r))
 simp

theorem shiftedLevelFiber : CleanStatements.shifted_level_pair_has_shifted_fiber := by
 intro X f a t
 ext x
 change (a+t ≤ f x ∧ f x ≤ a+t) ↔ f x = a+t
 constructor
 · intro h; exact le_antisymm h.2 h.1
 · intro h; simp [h]

theorem perturbationRelativeEmpty : CleanStatements.level_perturbation_pair_has_no_relative_points := by
 intro X f g a x
 change ¬ ((false = true ∧ g x = a) ∨ (false = true ∧ g x = a))
 simp
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'LevelOracle.'+o) for n,o in [('level problem','problem'),('level fiber','fiber'),('level band','band')]]
pairs += [('CleanStatements.'+n,'LevelOracle.'+o) for n,o in [('level_pair_has_fiber','fiberStatement'),('expanded_level_pair_has_band','bandStatement'),('expanded_level_pair_has_no_relative_points','emptyStatement'),('shifted_level_pair_has_shifted_fiber','shiftedStatement'),('level_perturbation_pair_has_no_relative_points','perturbationEmptyStatement')]]
path=HERE/'LevelSetsVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Eight exact targets and five level-set identities passed; ordinary/relative homology identification and the well-group formula remain pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
