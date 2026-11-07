# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Apply carrier and binding prototypes, then check native callable identities."""
from pathlib import Path
import sys,ast,subprocess,os,shutil,tempfile,json
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
if len(sys.argv)==1:
 with tempfile.TemporaryDirectory(prefix='clean-bound-calls-') as td:
  dest=Path(td)
  for name in subprocess.check_output(['git','ls-files','-z'],cwd=ROOT,text=True).split('\0'):
   if name and (ROOT/name).is_file():
    out=dest/name;out.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/name,out)
  (dest/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
  for patch in ['prototype.patch','bound-calls.patch']:
   subprocess.run(['git','apply',str(HERE/patch)],cwd=dest,check=True)
  for args in [[],['--check']]:subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
  subprocess.run([sys.executable,str(Path(__file__).resolve()),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'check_capture.py'),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'verify_prototype.py'),str(dest)],cwd=dest,check=True)
 raise SystemExit(0)
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expressions,Expr,Type,CleanError,lean
from cleanlang.modules import load_module,notation
from cleanlang.indices import substitute_index
r=ROOT;e=Environment();load_module(r/'studies/carrier-fields/Bundle.clean.proposed',e)
notation('Define c(P: PointedSpace): Type:', ['Equals: P.carrier'],e,authored=True)
notation('Define retain(P,x):',['Let P: PointedSpace','Let x: (c(P))','Returns: (c(P))','Equals: x'],e,authored=True)
notation('Define retain family(F,P,x):',['Let F: Function(PointedSpace,Type)','Let P: PointedSpace','Let x: (F(P))','Returns: (F(P))','Equals: x'],e,authored=True)
notation('Define retain with label(c,P,x):',['Let c: PointedSpace','Let P: PointedSpace','Let x: (c(P))','Returns: (c(P))','Equals: x'],e,authored=True)
scope={}
def local(n,t):scope[n]=Expr(n,n,e.type(t,scope),tree=['Local',n])
local('P','PointedSpace');local('c','Function(PointedSpace,Type)');local('x','(c(P))');local('y','P.carrier')
try:Expressions(e,scope).parse('retain(P,x)')
except CleanError as error:assert str(error)=='Dependent index mismatch: (c(P))',str(error)
else:raise AssertionError('Accepted captured carrier')
good=Expressions(e,scope).parse('retain(P,y)')
parameter=Expressions(e,scope).parse('retain family(c,P,x)')
nonfunction=Expressions(e,scope).parse('retain with label(P,P,y)')
saved=e.data['functions']['retain']['dependent_signature']['parameters'][1][1].args[0]
from cleanlang.syntax import parse,expression_tree,expression_spelling
from cleanlang.conditions import source_expression
from cleanlang.dependent_functions import tree_names
assert expression_tree(parse('c(P)','expression'))==['Call','c',[['Local','P']]]
bound_tree=json.loads(saved.syntax)
assert bound_tree==['ModuleCall','c',[['Local','P']],e.data['functions']['c']['lean']]
assert source_expression(bound_tree)==expression_spelling(bound_tree)=='c(P)'
assert tree_names(bound_tree)=={'P'}
substituted=substitute_index(saved,{'P':scope['P']},e,scope)
assert 'ModuleCall' in substituted.syntax
assert substitute_index(substituted,{},e,scope)==substituted
original=e.data['functions']['c']['lean'];e.data['functions']['c']['lean']='different_target'
try:substitute_index(saved,{'P':scope['P']},e,scope)
except CleanError as error:assert str(error)=='Changed bound module callable: c',str(error)
else:raise AssertionError('Changed target accepted')
e.data['functions']['c']['lean']=original
# The shared dimension path must preserve the same module/local distinction.
notation('Define count(n: Natural): Natural:', ['Equals: n'],e,authored=True)
notation('Define retain vector(n,v):',['Let n: Natural','Let v: Vector((count(n)),Real)','Returns: Vector((count(n)),Real)','Equals: v'],e,authored=True)
local('n','Natural');local('count','Function(Natural,Natural)')
local('v','Vector((count(n)),Real)');local('w','Vector(n,Real)')
try:Expressions(e,scope).parse('retain vector(n,v)')
except CleanError as error:assert str(error)=='Dependent index mismatch: (count(n))',str(error)
else:raise AssertionError('Accepted captured dimension')
assert Expressions(e,scope).parse('retain vector(n,w)').type==scope['w'].type
# Preserve the explicit structural-annotation gap instead of silently losing heads.
notation('Notation marker(T: Type): Natural:', ['Means: 0','Render latex: marker({T})'],e)
from cleanlang.indices import index_value
try:index_value(Expressions(e,scope).parse('marker(type(Vector((count(n)),Real)))'),e,scope)
except CleanError as error:assert 'structural type annotations' in str(error),str(error)
else:raise AssertionError('Unsupported annotation binding was silently erased')
record=e.structures['PointedSpace']['key'];f=lambda n:e.data['functions'][n]['lean'].split()[0]
comparison=next(ast.literal_eval(n.value) for n in ast.parse((r/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=lean([],e,['Lean'])+comparison+f'''
noncomputable def actual_retain (P : {record}) (c : {record} → Type) (y : P.carrier) := {good.lean}
noncomputable def expected_retain (P : {record}) (c : {record} → Type) (y : P.carrier) := @{f('retain')} P y
same_basic_target actual_retain expected_retain
noncomputable def actual_family (P : {record}) (c : {record} → Type) (x : c P) := {parameter.lean}
noncomputable def expected_family (P : {record}) (c : {record} → Type) (x : c P) := @{f('retain family')} c P x
same_basic_target actual_family expected_family
noncomputable def actual_label (P : {record}) (c : {record} → Type) (y : P.carrier) := {nonfunction.lean}
noncomputable def expected_label (P : {record}) (c : {record} → Type) (y : P.carrier) := @{f('retain with label')} P P y
same_basic_target actual_label expected_label
theorem retain_checked (P : {record}) (c : {record} → Type) (y : P.carrier) : actual_retain P c y = y := rfl
theorem family_checked (P : {record}) (c : {record} → Type) (x : c P) : actual_family P c x = x := rfl
theorem label_checked (P : {record}) (c : {record} → Type) (y : P.carrier) : actual_label P c y = y := rfl
'''
p=COMPILER/'BoundCallsVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',p.name],cwd=p.parent,check=True)
print('Three exact targets and three proofs passed; capture, rebinding, repeated substitution and local parameters checked')
(HERE/'BoundCallsVerified.lean').write_text(native)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
