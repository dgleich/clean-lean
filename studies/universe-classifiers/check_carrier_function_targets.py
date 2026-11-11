# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'CarrierFunctions.clean',env)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
expected=f'''
namespace CarrierFunctionOracle
noncomputable def family : (A : {t('LargeTypes')}) → A → A :=
  fun A x => x
noncomputable def statement : Prop := ∀ (X : {t('TopologicalSpace')}),
  {f('equal large')} ({f('identity family')} {t('TopologicalSpace')} X) X
end CarrierFunctionOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
source=lean(results,env,['Lean'])+expected+comparison+f'''
same_basic_target {f('identity family')} CarrierFunctionOracle.family
same_basic_target CleanStatements.identity_family_on_spaces CarrierFunctionOracle.statement
theorem identity_family_on_spaces_proved : CleanStatements.identity_family_on_spaces := by
  intro X
  rfl
'''
source+='\n-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
p=HERE/'CarrierFunctionTargets.lean';p.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Two exact carrier-function targets and the topology-space identity proof passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
