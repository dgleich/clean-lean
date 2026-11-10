# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent canonical oracles for recovering conditions from proof operands."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module
SOURCE='''Define condition of(h):
  Let p: Proposition
  Let h: Evidence(p)
  Returns: Proposition
  Equals: p
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
with tempfile.TemporaryDirectory(prefix='clean-inferred-conditions-') as directory:
 path=Path(directory)/'Example.clean';path.write_text('Import "'+str(ROOT/'library/logic/proof_equality.clean')+'"\n'+SOURCE)
 e=Environment();load_module(path,e)
 key=lambda name:e.data['functions'][name]['native_binding']
 same,recover,implication=map(key,['same evidence','condition of','implication'])
 prop=e.data['types']['Proposition']['native_binding']
 scope={}
 for name,source in [('p','Proposition'),('h','Evidence(p)'),('k','Evidence(p)'),('r','Evidence((condition of(h)))')]:
  scope[name]=Expr(name,name,e.type(source,scope),tree=['Local',name])
 direct=Expressions(e,scope).parse('h=k').lean
 computed=Expressions(e,scope).parse('r=h').lean
 quantified_scope={'h':Expr('h','h',e.type('Evidence((for every (p: Proposition,p)))',{}),tree=['Local','h'])}
 quantified=Expressions(e,quantified_scope).parse('h=h').lean
 imp_scope={}
 for name,source in [('p','Proposition'),('q','Proposition'),('h','Evidence((p → q))'),('k','Evidence(p)')]:
  imp_scope[name]=Expr(name,name,e.type(source,imp_scope),tree=['Local',name])
 applied=Expressions(e,imp_scope).parse('h(k)').lean
 expected=f'''
noncomputable def expectedSame {{p : {prop}}} (h k : p) : {prop} := h = k
noncomputable def expectedRecover {{p : {prop}}} (h : p) : {prop} := p
same_basic_target {same} expectedSame
same_basic_target {recover} expectedRecover
noncomputable def expectedImplication (x y : {prop}) : {prop} := x → y
same_basic_target {implication} expectedImplication
noncomputable def actualApplied (p q : {prop}) (h : {implication} p q) (k : p) : q := {applied}
noncomputable def expectedApplied (p q : {prop}) (h : {implication} p q) (k : p) : q := h k
same_basic_target actualApplied expectedApplied
theorem implicationApplies (p q : {prop}) (h : {implication} p q) (k : p) : q := actualApplied p q h k
noncomputable def actualDirect (p : {prop}) (h k : p) : {prop} := {direct}
noncomputable def expectedDirect (p : {prop}) (h k : p) : {prop} := @{same} p h k
same_basic_target actualDirect expectedDirect
noncomputable def actualComputed (p : {prop}) (h : p) (r : @{recover} p h) : {prop} := {computed}
noncomputable def expectedComputed (p : {prop}) (h : p) (r : @{recover} p h) : {prop} :=
  @{same} (@{recover} p h) r h
same_basic_target actualComputed expectedComputed
noncomputable def actualQuantified (h : ∀ p : {prop}, p) : {prop} := {quantified}
noncomputable def expectedQuantified (h : ∀ p : {prop}, p) : {prop} :=
  @{same} (∀ p : {prop}, p) h h
same_basic_target actualQuantified expectedQuantified
theorem proofsEqual (p : {prop}) (h k : p) : actualDirect p h k := by rfl
theorem recoverCondition (p : {prop}) (h : p) : @{recover} p h = p := by rfl
theorem computedProofsEqual (p : {prop}) (h : p) (r : @{recover} p h) : actualComputed p h r := by rfl
'''
 native=Path(directory)/'Checks.lean';native.write_text(lean([],e,['Lean'])+comparison+expected)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(native)],cwd=ROOT,check=True)
print('Seven canonical inferred-condition/implication targets and four proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
