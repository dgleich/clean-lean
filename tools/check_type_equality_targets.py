# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Canonical targets for explicit equality of Type-0 carriers."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expressions,lean
from cleanlang.modules import load_module
env=Environment();load_module(ROOT/'library/logic/type_equality.clean',env)
f=lambda name:env.data['functions'][name]['native_binding']
t=lambda name:env.data['types'][name]['native_binding']
eq=Expressions(env,{}).parse('type(Real)=type(Complex)')
ne=Expressions(env,{}).parse('type(Real)!=type(Complex)')
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
expected=f'''
def expectedEquality (A B : {t('Type')}) : {t('Proposition')} := A = B
def expectedInequality (A B : {t('Type')}) : {t('Proposition')} := A ≠ B
same_basic_target {f('equal carriers')} expectedEquality
same_basic_target {f('unequal carriers')} expectedInequality
def actualEquality : {t('Proposition')} := {eq.lean}
def actualInequality : {t('Proposition')} := {ne.lean}
def expectedEqualityUse : {t('Proposition')} := @{f('equal carriers')} {t('Real')} {t('Complex')}
def expectedInequalityUse : {t('Proposition')} := @{f('unequal carriers')} {t('Real')} {t('Complex')}
same_basic_target actualEquality expectedEqualityUse
same_basic_target actualInequality expectedInequalityUse
theorem carrierReflexivity (A : {t('Type')}) : {f('equal carriers')} A A := by rfl
theorem carrierIrreflexivity (A : {t('Type')}) : ¬ {f('unequal carriers')} A A := by
 intro h
 exact h rfl
'''
with tempfile.TemporaryDirectory(prefix='clean-type-equality-') as directory:
 path=Path(directory)/'Checks.lean';path.write_text(lean([],env,['Lean'])+comparison+expected)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Four exact carrier-equality targets and two proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
