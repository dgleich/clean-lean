# generated: gpt-6 2026-11-10 role=assisted; isolated prototype
from pathlib import Path
import ast,os,subprocess,tempfile
from test_retention import ExactLiteralPrototype,ROOT
from cleanlang.core import Expressions,lean
case=ExactLiteralPrototype();e=case.load();scope=case.scope(e)
f=lambda n:e.data['functions'][n]['native_binding']
t=lambda n:e.data['types'][n]['native_binding']
vector=Expressions(e,scope).parse('(0: Vector(n,Complex))')
matrix=Expressions(e,scope).parse('(0: Matrix(m,n,Complex))')
from cleanlang.hygiene import substitute
replaced=Expressions(e,scope).elaborate(substitute(vector.tree,{'n':scope['m']},e,scope))
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
checks=f'''
noncomputable def actualVector (n : {t('Natural')}) : {t('Vector')} n {t('Complex')} := {vector.lean}
noncomputable def expectedVector (n : {t('Natural')}) : {t('Vector')} n {t('Complex')} := @{f('vector zero')} n
same_basic_target actualVector expectedVector
noncomputable def actualMatrix (m n : {t('Natural')}) : {t('Matrix')} m n {t('Complex')} := {matrix.lean}
noncomputable def expectedMatrix (m n : {t('Natural')}) : {t('Matrix')} m n {t('Complex')} := @{f('matrix zero')} m n
same_basic_target actualMatrix expectedMatrix
noncomputable def actualSubstitution (m : {t('Natural')}) : {t('Vector')} m {t('Complex')} := {replaced.lean}
noncomputable def expectedSubstitution (m : {t('Natural')}) : {t('Vector')} m {t('Complex')} := @{f('vector zero')} m
same_basic_target actualSubstitution expectedSubstitution
theorem vectorCoordinate (n : {t('Natural')}) (i : Fin n) : actualVector n i = 0 := by rfl
theorem matrixCoordinate (m n : {t('Natural')}) (i : Fin m) (j : Fin n) : actualMatrix m n i j = 0 := by rfl
'''
with tempfile.TemporaryDirectory(prefix='clean-literal-native-') as directory:
 p=Path(directory)/'Checks.lean';p.write_text(lean([],e,['Lean'])+comparison+checks)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Three exact annotation/substitution targets and two coordinate proofs passed; in-memory literal retention checked separately; unannotated inference and portable serialization remain pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
