# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();rs=load_document(HERE/'Statements.clean',e)
f=lambda n:e.data['functions'][n]['native_binding']
s=lean(rs,e,['Lean']);(HERE/'Generated.lean').write_text(s);(HERE/'Statements.tex').write_text(latex(rs,e))
expected=r'''
namespace ChoiceOracle
noncomputable def choose {A : Type} (condition : A → PROPOSITION) (h : ∃ x : A, condition x) : A :=
 Classical.choose h
noncomputable def satisfies {A : Type} (condition : A → PROPOSITION) (h : ∃ x : A, condition x) : condition (CHOOSE condition h) :=
 Classical.choose_spec h
noncomputable def element {A : Type} (S : SET A) (h : ∃ x : A, MEM x S) : A :=
 CHOOSE (fun x : A => MEM x S) h
noncomputable def membership {A : Type} (S : SET A) (h : ∃ x : A, MEM x S) : MEM (ELEMENT S h) S :=
 SATISFIES (fun x : A => MEM x S) h
def statement : Prop := ∀ (A : TYPE) (S : SET A) (inhabited : ∃ x : A, MEM x S), MEM (ELEMENT S inhabited) S
def appliedStatement : Prop := ∀ (A : TYPE) (S : SET A)
 (inhabited : ∃ x : A, (fun y : A => MEM y S) x), MEM (ELEMENT S inhabited) S
def universalStatement : Prop := ∀ (A : TYPE) (inhabited : ∃ x : A, ∀ y : A, EQ y x),
 ∀ y : A, EQ y (CHOOSE (fun x : A => ∀ z : A, EQ z x) inhabited)
end ChoiceOracle
'''
keys={'CHOOSE':f('choose witness'),'SATISFIES':f('chosen witness satisfies'),'ELEMENT':f('choose element'),'MEMBER':f('chosen element belongs')}
keys.update({k:e.data['types'][n]['native_binding'] for k,n in [('TYPE','Type'),('SET','Set'),('PROPOSITION','Proposition')]})
keys.update(MEM=f('set member'),EQ=f('equal'))
for key,value in keys.items():expected=re.sub(r'\b'+key+r'\b',value,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),v) for n,v in [('choose witness','choose'),('chosen witness satisfies','satisfies'),('choose element','element'),('chosen element belongs','membership')]]
pairs += [('CleanStatements.chosen_element_is_a_member','statement'),('CleanStatements.choice_from_an_applied_condition','appliedStatement'),('CleanStatements.choice_with_a_universal_condition','universalStatement')]
s+=expected+comparison+'\n'.join('same_basic_target '+a+' ChoiceOracle.'+b for a,b in pairs)+'\n'
s+='''
theorem chosen_membership_checked : CleanStatements.chosen_element_is_a_member := by
 intro A S h
 exact MEMBER S h
theorem applied_choice_checked : CleanStatements.choice_from_an_applied_condition := by
 intro A S h
 exact MEMBER S h
theorem universal_choice_checked : CleanStatements.choice_with_a_universal_condition := by
 intro A h y
 exact Classical.choose_spec h y
'''.replace('MEMBER',keys['MEMBER'])
p=HERE/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Seven exact choice targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
