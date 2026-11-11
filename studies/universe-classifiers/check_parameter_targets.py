# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'ParameterizedRecords.clean',env)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
r=env.structures['Package']['key']
expected=f'''
namespace ParameterOracle
noncomputable def pack (A : Type 1) (point : A) : {r} A := @{r}.mk A point
noncomputable def unpack (A : Type 1) (P : {r} A) : A := P.point
noncomputable def sequences (A : Type 1) : Type 1 := List A
noncomputable def statement : Prop := ∀ (P : {r} {t('TopologicalSpace')}),
  @{f('equal large')} {t('TopologicalSpace')} ({f('unpack')} {t('TopologicalSpace')} P) P.point
end ParameterOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
source=lean(results,env,['Lean'])+expected+comparison+f'''
same_basic_target {f('package')} ParameterOracle.pack
same_basic_target {f('unpack')} ParameterOracle.unpack
same_basic_target {t('Sequences')} ParameterOracle.sequences
same_basic_target CleanStatements.packaged_topology_entry ParameterOracle.statement
theorem packaged_topology_entry_proved : CleanStatements.packaged_topology_entry := by
  intro P
  rfl
'''
p=HERE/'ParameterTargets.lean';p.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Four exact parameterized type/record targets and one projection proof passed.')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
