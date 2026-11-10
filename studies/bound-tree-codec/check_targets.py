# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import argparse,ast,os,subprocess,tempfile
from dataclasses import replace
from cleanlang.retained_codec import dumps,loads
import test_retention
from cleanlang.core import Expressions,lean
from cleanlang.indices import index_value,substitute_index
from cleanlang.dependent_functions import index_tree
from cleanlang.proof_types import index
parser=argparse.ArgumentParser()
parser.add_argument('--payload-only',action='store_true')
options=parser.parse_args()
ROOT=test_retention.ROOT
fixture=test_retention.ExactLiteralPrototype();env=fixture.load();scope=fixture.scope(env)
f=lambda name:env.data['functions'][name]['native_binding']
t=lambda name:env.data['types'][name]['native_binding']
vector=Expressions(env,scope).parse('(0: Vector(n,Complex))')
saved=loads(dumps(index_value(vector,env,scope)))
if options.payload_only:saved=replace(saved,resolved=None)
restored=Expressions(env,scope).elaborate(index_tree(saved))
changed=Expressions(env,scope).elaborate(index_tree(substitute_index(saved,{'n':scope['m']},env,scope)))
condition=Expressions(env,scope).parse('for every(k: Natural,(0: Vector(k,Complex))=(0: Vector(k,Complex)))')
proof=loads(dumps(index(condition,env,scope)))
if options.payload_only:proof=replace(proof,resolved=None)
quantified=Expressions(env,scope).elaborate(index_tree(proof))
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
expected=f'''
noncomputable def restoredVector (n : {t('Natural')}) : {t('Vector')} n {t('Complex')} := {restored.lean}
noncomputable def expectedVector (n : {t('Natural')}) : {t('Vector')} n {t('Complex')} := @{f('vector zero')} n
same_basic_target restoredVector expectedVector
noncomputable def substitutedVector (m : {t('Natural')}) : {t('Vector')} m {t('Complex')} := {changed.lean}
noncomputable def expectedSubstitution (m : {t('Natural')}) : {t('Vector')} m {t('Complex')} := @{f('vector zero')} m
same_basic_target substitutedVector expectedSubstitution
def restoredCondition : Prop := {quantified.lean}
def expectedCondition : Prop := ∀ (k : {t('Natural')}), {f('equal')} (@{f('vector zero')} k) (@{f('vector zero')} k)
same_basic_target restoredCondition expectedCondition
theorem restoredCoordinate (n : {t('Natural')}) (i : Fin n) : restoredVector n i = 0 := by rfl
theorem restoredReflexivity : restoredCondition := by intro n; rfl
'''
with tempfile.TemporaryDirectory(prefix='clean-codec-native-') as directory:
 path=Path(directory)/'Checks.lean';path.write_text(lean([],env,['Lean'])+comparison+expected)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact restored-index targets and two proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
