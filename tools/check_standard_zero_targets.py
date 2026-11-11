# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent exact declarations/statements and proofs for standard zero wrappers."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document

env=Environment();results=load_document(ROOT/'examples/typed_zeros.clean',env)
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
checks=[]
for scalar in ('Complex','Real'):
 for shape,args in [('Vector',['n']),('Matrix',['m','n'])]:
  name=scalar.lower()+' '+shape.lower()+' zero'
  title=name.replace(' ','_')+'_interpretation'
  label=scalar+shape
  binders=' '.join('('+n+' : '+t('Natural')+')' for n in args)
  carrier=t(shape)+' '+' '.join(args)+' '+t(scalar)
  call=f(name)+' '+' '.join(args)
  body='fun '+('i' if shape=='Vector' else 'i j')+' => (0 : '+scalar+')'
  checks.append(f'''
noncomputable def expected{label} {binders} : {carrier} := {body}
same_basic_target {f(name)} expected{label}
def expected{label}Statement : Prop :=
 ∀ {binders}, @{f('equal')} ({carrier}) ({call}) ({call})
same_basic_target CleanStatements.{title} expected{label}Statement
theorem proof{label} : CleanStatements.{title} := by
 intro {' '.join(args)}
 rfl
''')
source=lean(results,env,['Lean'])+comparison+'\n'.join(checks)
path=ROOT/'generated/StandardZeros.lean';path.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Eight exact standard zero targets and four interpretation proofs passed.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
