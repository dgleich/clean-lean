# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check emitted targets and native equivalence for a failing Clean comparison."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'tests')]
from test_contextual_family_comparison import ContextualFamilyComparison
from cleanlang.core import lean
case=ContextualFamilyComparison();case.setUp();e=case.env
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
f=lambda name:e.data['functions'][name]['native_binding']
real=e.data['types']['Real']['native_binding']
eq,sample,constant,sampled=map(f,['equal','sample','constant','sampled'])
forms=[('Named','sample(constant(a)) = a',f'{eq} ({sample} ({constant} a)) a'),
       ('Outer','sampled(a) = a',f'{eq} ({sampled} a) a'),
       ('Explicit','sample(function(z: Real,a)) = a',f'{eq} ({sample} (fun (_ : {real}) => a)) a')]
checks=[]
for label,source,expected in forms:
 actual=case.proof(source).args[0].lean
 checks.append(f'''
noncomputable def actual{label} (a : {real}) : Prop := {actual}
noncomputable def expected{label} (a : {real}) : Prop := {expected}
same_basic_target actual{label} expected{label}
''')
checks.append(f'''
theorem named_equivalence (a : {real}) : actualNamed a = actualExplicit a := by rfl
theorem outer_equivalence (a : {real}) : actualOuter a = actualExplicit a := by rfl
''')
with tempfile.TemporaryDirectory(prefix='clean-contextual-targets-') as directory:
 path=Path(directory)/'Checks.lean';path.write_text(lean([],e,['Lean'])+comparison+''.join(checks))
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact emitted targets and two Lean equivalence proofs passed; this driver does not check Clean comparison success.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
