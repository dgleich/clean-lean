# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent native check for literals with competing visible classifiers."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expressions,lean
from cleanlang.modules import load_module,type_declaration,notation
from cleanlang.retained_codec import dumps,loads
E=Environment();load_module(ROOT/'library/operators.clean',E)
type_declaration('Type OtherSmall():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],E)
notation('Notation empty(T):',['Let T: Type','Returns: List(T)','Means: []','Literal: 0','Render latex: []'],E)
value=Expressions(E,{}).parse('(0: List(Real))')
value=Expressions(E,{}).elaborate(loads(dumps(value.tree)))
t=lambda name:E.data['types'][name]['native_binding']
f=E.data['functions']['empty']['native_binding']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
source=lean([],E,['Lean'])+f'''
noncomputable def literalActual : {E.render_type(value.type,'lean')} := {value.lean}
noncomputable def literalExpected : {t('List')} {t('Real')} := {f} {t('Real')}
noncomputable def emptyExpected (T : Type) : {t('List')} T := []
'''+comparison+f'''
same_basic_target {f} emptyExpected
same_basic_target literalActual literalExpected
theorem literal_empty_proved : literalActual = ([] : List Real) := by rfl
'''
with tempfile.TemporaryDirectory(prefix='clean-literal-classifier-native-') as directory:
 p=Path(directory)/'Targets.lean';p.write_text(source)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Two exact classifier/literal targets and one payload-replay proof passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
