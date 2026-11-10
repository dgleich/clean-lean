# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent native checks for inferred values and authored conversion."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module

SOURCE='''Define recovered field(M):
  Let K: Type
  Let field: FieldStructure(K)
  Let M: CoefficientModule(K,field)
  Returns: FieldStructure(K)
  Equals: field

Define retained field(field):
  Let K: Type
  Let field: FieldStructure(K)
  Returns: FieldStructure(K)
  Equals: field

Define callable field(f):
  Let K: Type
  Let field: FieldStructure(K)
  Let f: Function(x: FieldStructure(K),CoefficientModule(K,field))
  Returns: FieldStructure(K)
  Equals: field
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
with tempfile.TemporaryDirectory(prefix='clean-inferred-values-') as directory:
 path=Path(directory)/'Example.clean';path.write_text('Import "'+str(ROOT/'library/algebra/module_spaces.clean')+'"\n'+SOURCE)
 e=Environment();load_module(path,e)
 key=lambda name:e.data['functions'][name]['native_binding']
 typ=lambda name:e.data['types'][name]['native_binding']
 field,module=typ('FieldStructure'),typ('CoefficientModule')
 recover,retain,callable_=map(key,['recovered field','retained field','callable field'])
 scope={}
 for name,source in [('F','Type'),('f','FieldStructure(F)'),('M','CoefficientModule(F,(retained field(f)))'),
                     ('g','Function(x: FieldStructure(F),CoefficientModule(F,f))')]:
  scope[name]=Expr(name,name,e.type(source,scope),tree=['Local',name])
 computed=Expressions(e,scope).parse('recovered field(M)').lean
 function=Expressions(e,scope).parse('callable field(g)').lean
 expected=f'''
noncomputable def expectedRecover {{K : Type}} {{field : {field} K}}
    (M : {module} K field) : {field} K := field
noncomputable def expectedRetain {{K : Type}} (field : {field} K) : {field} K := field
noncomputable def expectedCallable {{K : Type}} {{field : {field} K}}
    (f : (x : {field} K) → {module} K field) : {field} K := field
same_basic_target {recover} expectedRecover
same_basic_target {retain} expectedRetain
same_basic_target {callable_} expectedCallable
noncomputable def actualComputed (F : Type) (f : {field} F)
    (M : {module} F (@{retain} F f)) : {field} F := {computed}
noncomputable def expectedComputed (F : Type) (f : {field} F)
    (M : {module} F (@{retain} F f)) : {field} F := @{recover} F (@{retain} F f) M
same_basic_target actualComputed expectedComputed
noncomputable def actualCallable (F : Type) (f : {field} F)
    (g : (x : {field} F) → {module} F f) : {field} F := {function}
noncomputable def expectedCallableApplication (F : Type) (f : {field} F)
    (g : (x : {field} F) → {module} F f) : {field} F := @{callable_} F f g
same_basic_target actualCallable expectedCallableApplication
theorem computedRecovers (F : Type) (f : {field} F)
    (M : {module} F (@{retain} F f)) : actualComputed F f M = f := by rfl
theorem callableRecovers (F : Type) (f : {field} F)
    (g : (x : {field} F) → {module} F f) : actualCallable F f g = f := by rfl
'''
 native=Path(directory)/'Checks.lean';native.write_text(lean([],e,['Lean'])+comparison+expected)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(native)],cwd=ROOT,check=True)
print('Five canonical inferred-value targets and two proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
