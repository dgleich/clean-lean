# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent native oracles for the authored dependent-record specimen."""
from pathlib import Path
import ast,os,subprocess,tempfile
import cleanlang
from cleanlang.core import Environment,lean
from cleanlang.modules import load_module
ROOT=Path(cleanlang.__file__).resolve().parents[1]
env=Environment()
load_module(ROOT/'studies/literal-retention/Interfaces.clean',env)
f=lambda name:env.data['functions'][name]['native_binding']
t=lambda name:env.data['types'][name]['native_binding']
record=env.structures['SizedVector']['key']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
expected=f'''
noncomputable def expectedBundle (n : {t('Natural')}) : {record} :=
 @{f('sized vector')} n (@{f('vector zero')} n)
noncomputable def expectedFamily : (n : {t('Natural')}) → {t('Vector')} n {t('Complex')} :=
 fun n => @{f('vector zero')} n
def expectedContents (V : {record}) : {t('Proposition')} :=
 {f('equal')} (@{record}.«vector» V) (@{f('vector zero')} (@{record}.«size» V))
same_basic_target {f('zero bundle')} expectedBundle
same_basic_target {f('zero family')} expectedFamily
same_basic_target {f('zero bundle contents')} expectedContents
theorem zeroBundleContents (n : {t('Natural')}) : {f('zero bundle contents')} ({f('zero bundle')} n) := by rfl
theorem zeroFamilyCoordinate (n : {t('Natural')}) (i : Fin n) : {f('zero family')} n i = 0 := by rfl
'''
with tempfile.TemporaryDirectory(prefix='clean-literal-interfaces-') as directory:
 path=Path(directory)/'Interfaces.lean'
 path.write_text(lean([],env,['Lean'])+comparison+expected)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact dependent-interface targets and two proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
