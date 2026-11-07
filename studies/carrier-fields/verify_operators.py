# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Compose the two isolated patches without mathematical operator fallbacks."""
from pathlib import Path
import ast,os,shutil,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
if len(sys.argv)==1:
 with tempfile.TemporaryDirectory(prefix='clean-carrier-operators-') as td:
  dest=Path(td)
  for name in subprocess.check_output(['git','ls-files','-z'],cwd=ROOT,text=True).split('\0'):
   if name and (ROOT/name).is_file():
    out=dest/name;out.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/name,out)
  (dest/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
  for patch in [HERE/'prototype.patch',ROOT/'studies/module-operators/prototype.patch']:
   subprocess.run(['git','apply',str(patch)],cwd=dest,check=True)
  for args in [[],['--check']]:subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
  subprocess.run([sys.executable,str(Path(__file__).resolve()),str(dest)],cwd=dest,check=True)
 raise SystemExit(0)
COMPILER=Path(sys.argv[1]);sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree

e=Environment();load_module(HERE/'OperatorBundle.clean.proposed',e)
scope={n:Expr(n,n,e.type('PointedSpace'),tree=['Local',n]) for n in ['P','Q']}
scope['x']=Expr('x','x',e.type('(carrier of(P))',scope),tree=['Local','x'])
source='P.point = P.point';tree=['Operator','=', ['Projection',['Local','P'],'point'],['Projection',['Local','P'],'point']]
assert expression_tree(parse(source,'expression'))==tree
one=Expressions(e,scope).parse(source);assert one.tree==tree
negated=Expressions(e,scope).parse('not not (P.point = P.point)')
alias=Expressions(e,scope).parse('x=x')
e.operator_overloads['='].reverse()
assert Expressions(e,scope).parse(source).lean==one.lean

def reject(text,fragment):
 try:Expressions(e,scope).parse(text)
 except CleanError as error:assert fragment in str(error),(fragment,str(error));return str(error)
 raise AssertionError('Expected rejection: '+text)
reject('P.point = Q.point','No declared meaning')
f=lambda n:e.data['functions'][n]['lean'].split()[0]
eq,neg,carrier=(f(n) for n in ['carrier equality','negate condition','carrier of'])
record=e.structures['PointedSpace']['key']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=lean([],e,['Lean'])+comparison+f'''
noncomputable def expected_equality {{T : Type}} (x y : T) : Prop := x=y
noncomputable def expected_negation (p : Prop) : Prop := ¬p
same_basic_target {eq} expected_equality
same_basic_target {neg} expected_negation

def actual_carrier_operator (P : {record}) : Prop := {one.lean}
def expected_carrier_operator (P : {record}) : Prop := @{eq} P.carrier P.point P.point
same_basic_target actual_carrier_operator expected_carrier_operator

def actual_carrier_negation (P : {record}) : Prop := {negated.lean}
def expected_carrier_negation (P : {record}) : Prop := {neg} ({neg} (@{eq} P.carrier P.point P.point))
same_basic_target actual_carrier_negation expected_carrier_negation

def actual_alias_operator (P : {record}) (x : {carrier} P) : Prop := {alias.lean}
def expected_alias_operator (P : {record}) (x : {carrier} P) : Prop := @{eq} ({carrier} P) x x
same_basic_target actual_alias_operator expected_alias_operator

theorem carrier_operator_checked (P : {record}) : actual_carrier_operator P := by rfl
theorem carrier_negation_checked (P : {record}) : actual_carrier_negation P := by
 change ¬¬(P.point=P.point)
 intro h
 exact h rfl
theorem alias_operator_checked (P : {record}) (x : {carrier} P) : actual_alias_operator P x := by rfl
'''
notation('Notation another equality(x,y):',['Let T: Type','Let x,y: T','Returns: Proposition','Infix: =','Means: x=y','Render latex: {x}={y}'],e)
message=reject(source,'Ambiguous operator');e.operator_overloads['='].reverse()
assert reject(source,'Ambiguous operator')==message
p=COMPILER/'CarrierOperatorsVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
(HERE/'OperatorVerified.lean').write_text(native)
print('Carrier/operator composition: five exact targets, three proofs and order/ambiguity/wrong-carrier checks passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
