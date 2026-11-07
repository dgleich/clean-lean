# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent canonical target oracles for partially inferred dependent calls."""
from pathlib import Path
import ast,os,re,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,CleanError,lean
from cleanlang.modules import load_document
e=Environment();results=load_document(HERE/'Statements.clean',e)
expected_call=['Call','retain with law',[['Local','m'],['Lambda','x','Natural',['Local','n']],['Lambda','x','Natural',['Call','h',[['Local','x']]]],['Local','z']]]
assert results[0].conclusion.tree==['Operator','=',expected_call,['Local','z']]
s=lean(results,e,['Lean']);(HERE/'Generated.lean').write_text(s)
key=e.data['functions']['retain with law']['lean'].split()[0]
after=e.data['functions']['retain after family']['lean'].split()[0]
expected=r'''
namespace PartialInferenceOracle
noncomputable def retain {T : Type} (n : Nat) (f : Nat → Nat)
 (h : (x : Nat) → f x = n) (z : T) : T := z
def later : Prop := ∀ (n m : Nat) (z : Real) (h : ∀ x : Nat, n = m),
 @KEEP Real m (fun x : Nat => n) (fun x : Nat => h x) z = z
def direct : Prop := ∀ (n m : Nat) (z : Real) (h : ∀ x : Nat, n = m),
 @KEEP Real m (fun x : Nat => n) h z = z
noncomputable def afterFamily {T U : Type} (f : (x : Nat) → T) (z : U) : U := z
def codomain : Prop := ∀ (n : Nat) (z : Real),
 @AFTER Nat Real (fun x : Nat => n) z = z
end PartialInferenceOracle
'''.replace('KEEP',key).replace('AFTER',after)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
s+=expected+comparison+'\nsame_basic_target '+key+' PartialInferenceOracle.retain\n'
s+='same_basic_target CleanStatements.retain_with_later_inference PartialInferenceOracle.later\n'
s+='same_basic_target CleanStatements.retain_direct_evidence PartialInferenceOracle.direct\n'
s+='same_basic_target '+after+' PartialInferenceOracle.afterFamily\n'
s+='same_basic_target CleanStatements.infer_from_dependent_codomain PartialInferenceOracle.codomain\n'
s+='''
theorem later_inference_checked : CleanStatements.retain_with_later_inference := by
 intro n m z h
 rfl
theorem direct_evidence_checked : CleanStatements.retain_direct_evidence := by
 intro n m z h
 rfl
theorem codomain_inference_checked : CleanStatements.infer_from_dependent_codomain := by
 intro n z
 rfl
'''
p=HERE/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
source=(HERE/'Statements.clean').read_text().replace('../../library/logic/evidence.clean',str(ROOT/'library/logic/evidence.clean')).replace('for every(x: Natural,n = m)','for every(x: Natural,m = m)')
with tempfile.TemporaryDirectory() as td:
 p=Path(td)/'Wrong.clean';p.write_text(source)
 try:load_document(p,Environment())
 except CleanError as err:assert 'Dependent index mismatch' in str(err),str(err)
 else:raise AssertionError('Incorrect evidence accepted')
print('Independent call tree, five exact targets, three proofs, and incorrect-evidence rejection passed')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
