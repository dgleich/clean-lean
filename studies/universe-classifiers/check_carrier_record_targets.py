# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'CarrierRecords.clean',env)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
record=env.structures['SpacePackage']['key']
expected=f'''
namespace CarrierRecordOracle
noncomputable def pack (carrier : {t('LargeTypes')}) (point : carrier) : {record} :=
  @{record}.mk carrier point
noncomputable def package (X : {t('TopologicalSpace')}) : {record} :=
  {f('pack space')} {t('TopologicalSpace')} X
noncomputable def packagedStatement : Prop := ∀ (X : {t('TopologicalSpace')}),
  {f('equal large')} X X
noncomputable def storedStatement : Prop := ∀ (P : {record}),
  @{f('equal large')} P.carrier P.point P.point
end CarrierRecordOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
source=lean(results,env,['Lean'])+expected+comparison+f'''
same_basic_target {f('pack space')} CarrierRecordOracle.pack
same_basic_target {f('package space')} CarrierRecordOracle.package
same_basic_target CleanStatements.packaged_space_entry CarrierRecordOracle.packagedStatement
same_basic_target CleanStatements.stored_entry_reflexivity CarrierRecordOracle.storedStatement
theorem packaged_space_entry_proved : CleanStatements.packaged_space_entry := by
  intro X
  rfl
theorem stored_entry_reflexivity_proved : CleanStatements.stored_entry_reflexivity := by
  intro P
  rfl
'''
source+='\n-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
p=HERE/'CarrierRecordTargets.lean';p.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Four exact carrier-record targets and two proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
