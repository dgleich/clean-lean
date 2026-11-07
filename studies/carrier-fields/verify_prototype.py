# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Isolated closed-universe carrier fields with independent native oracles."""
from pathlib import Path
import ast,os,shutil,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
if len(sys.argv)==1:
 with tempfile.TemporaryDirectory(prefix='clean-carrier-fields-') as td:
  dest=Path(td)
  for name in subprocess.check_output(['git','ls-files','-z'],cwd=ROOT,text=True).split('\0'):
   if name and (ROOT/name).is_file():
    out=dest/name;out.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/name,out)
  (dest/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
  subprocess.run(['git','apply',str(HERE/'prototype.patch')],cwd=dest,check=True)
  for args in [[],['--check']]:subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
  subprocess.run([sys.executable,str(Path(__file__).resolve()),str(dest)],cwd=dest,check=True)
 raise SystemExit(0)
COMPILER=Path(sys.argv[1]);sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,lean,latex
from cleanlang.modules import load_document
from cleanlang.structures import declare
from cleanlang.syntax import parse,type_tree

e=Environment();results=load_document(HERE/'Statements.clean.proposed',e)
assert len(results)==6
assert type_tree(parse('P.carrier','type_ref'))==['Projection',['Name','P'],'carrier']
assert type_tree(parse('Set(P.carrier)','type_ref'))==['Apply','Set',[['Projection',['Name','P'],'carrier']]]
assert type_tree(parse('(carrier of(P))','type_ref'))==['ComputedIndex',['Call','carrier of',[['Local','P']]]]
scope={n:Expr(n,n,e.type('PointedSpace'),tree=['Local',n]) for n in ['P','Q']}
for n,owner in [('x','P'),('y','Q')]:scope[n]=Expr(n,n,e.type(owner+'.carrier',scope),tree=['Local',n])
assert e.type('P.carrier',scope)==e.type('(carrier of(P))',scope)
assert e.type('P.carrier',scope)!=e.type('Q.carrier',scope)
assert e.type('P.carrier',scope)==Expressions(e,scope).parse('P.point').type
assert Expressions(e,scope).parse('selected point(Q)').type==e.type('Q.carrier',scope)
assert Expressions(e,scope).parse('pointed space(P.carrier,P.topology,x).point').type==scope['x'].type
assert '$carrier' not in latex(results,e)
assert e.type('(P.carrier)',scope)==e.type('P.carrier',scope)
assert type_tree(parse('P . carrier','type_ref'))==['Projection',['Name','P'],'carrier']
from cleanlang.conditions import assumption_items
label,encoded,_=next(assumption_items('bundle continuous(P,P,function(z: P.carrier,z))',e,scope))
assert 'P.carrier' in label and '$carrier' not in label and '$carrier' not in encoded
from cleanlang.hygiene import substitute
rewritten=substitute(['Lambda','x','P.carrier',['Local','x']],{'P':scope['Q']},e,scope)
assert rewritten[2]=='Q.carrier'
assert substitute(['TypeValue','P.carrier'],{'P':scope['Q']},e,scope)==['TypeValue','Q.carrier']
from cleanlang.dependent_functions import substitute as substitute_type
family=e.type('Function(z: P.carrier,Evidence((z = z)))',scope)
changed=substitute_type(family,{'P':scope['Q']},e,scope)
assert changed.args[0]==e.type('Q.carrier',scope)
higher=e.type('Function(space: PointedSpace,space.carrier)',scope)
assert higher==e.type('Function(object: PointedSpace,object.carrier)',scope)
scope['F']=Expr('F','F',e.type('CarrierFamily'),tree=['Local','F'])
assert Expressions(e,scope).parse('F.value(P)').type==e.type('P.carrier',scope)



def reject(action,fragment):
 try:action()
 except CleanError as error:assert fragment in str(error),(fragment,str(error));return
 raise AssertionError('Expected rejection: '+fragment)
reject(lambda:Expressions(e,scope).parse('pointed space(P.carrier,P.topology,y)'), 'mismatch')
reject(lambda:Expressions(e,scope).parse('F.value(x)'),'Function')
reject(lambda:e.type('Function(T: Type,T)',scope),'Type-valued dependent function binders')
reject(lambda:e.require_type_argument(higher),'Type parameter requires')
reject(lambda:e.type('P.topology',scope),'Type projection must have type Type')
reject(lambda:e.require_type_argument(e.type('PointedSpace')),'Type parameter requires')
before=dict(e.notation_definitions)
reject(lambda:declare('Structure TooSmall():',['Let carrier: Type','Constructor: too small'],e),'exceeds declared Universe 0')
assert e.notation_definitions==before and 'TooSmall' not in e.structures
reject(lambda:declare('Structure Forward():',['Universe: 1','Let point: carrier','Let carrier: Type','Constructor: forward'],e),'Unknown type')
# A renamed receiver changes both the dependent return type and its emitted projection.
renamed=Expressions(e,scope).parse('selected point(Q)')
assert 'Q' in renamed.type.args[0].lean and 'P)' not in renamed.type.args[0].lean

f=lambda n:e.data['functions'][n]['lean'].split()[0]
record=e.structures['PointedSpace']['key'];ctor=f('pointed space')
carrier,constant,continuous,selected=(f(n) for n in ['carrier of','constant map','bundle continuous','selected point'])
underlying=f('continuous between');evaluate=f('evaluate map')
family_record=e.structures['CarrierFamily']['key'];family_ctor=f('carrier family');family_helper=f('point family')
generated=lean(results,e,['Lean'])
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=generated+comparison+f'''
structure ExpectedPointedSpace : Type 1 where
 carrier : Type
 topology : TopologicalSpace carrier
 point : carrier
noncomputable def expected_constructor (carrier : Type) (topology : TopologicalSpace carrier) (point : carrier) : ExpectedPointedSpace :=
 @ExpectedPointedSpace.mk carrier topology point

structure ExpectedCarrierFamily : Type 1 where
 value : (space : ExpectedPointedSpace) → space.carrier
noncomputable def expected_family_constructor (value : (space : ExpectedPointedSpace) → space.carrier) : ExpectedCarrierFamily :=
 @ExpectedCarrierFamily.mk value
noncomputable def expected_point_family : {family_record} :=
 {family_ctor} (fun space : {record} => space.point)
same_basic_target {family_helper} expected_point_family

def expected_family_evaluation : Prop := ∀ (P : {record}),
 @{family_record}.value {family_helper} P = P.point
same_basic_target CleanStatements.family_evaluation expected_family_evaluation
theorem family_evaluation_checked : CleanStatements.family_evaluation := by intro P; rfl

noncomputable def expected_carrier (P : {record}) : Type := @{record}.carrier P
noncomputable def expected_constant (P : {record}) : P.carrier → P.carrier := fun x => @{record}.point P
noncomputable def expected_continuous (P Q : {record}) (f : P.carrier → Q.carrier) : Prop :=
 @{underlying} P.carrier Q.carrier f P.topology Q.topology
noncomputable def expected_selected (P : {record}) : P.carrier := @{record}.point P
same_basic_target {carrier} expected_carrier
same_basic_target {constant} expected_constant
same_basic_target {continuous} expected_continuous
same_basic_target {selected} expected_selected

def expected_point_equality : Prop := ∀ (P : {record}) (x : P.carrier), x = x
def expected_constant_continuous : Prop := ∀ (P : {record}), {continuous} P P ({constant} P)
def expected_carrier_alias : Prop := ∀ (P : {record}) (x : {carrier} P),
 @{evaluate} P.carrier P.carrier (fun y : P.carrier => y) x = x
def expected_constructor_point : Prop := ∀ (T : Type) (t : TopologicalSpace T) (x : T), x = x
def expected_selected_projection : Prop := ∀ (Q : {record}), {selected} Q = Q.point
same_basic_target CleanStatements.point_equality expected_point_equality
same_basic_target CleanStatements.constant_map_continuous expected_constant_continuous
same_basic_target CleanStatements.carrier_alias expected_carrier_alias
same_basic_target CleanStatements.constructor_point expected_constructor_point
same_basic_target CleanStatements.selected_point_projection expected_selected_projection

theorem point_equality_checked : CleanStatements.point_equality := by intro P x; rfl
theorem constant_continuous_checked : CleanStatements.constant_map_continuous := by
 intro P
 letI : TopologicalSpace P.carrier := P.topology
 change ∀ S : Set P.carrier, IsOpen S → IsOpen ((fun _ : P.carrier => P.point) ⁻¹' S)
 intro S hS
 exact hS.preimage continuous_const
theorem carrier_alias_checked : CleanStatements.carrier_alias := by intro P x; rfl
theorem constructor_point_checked : CleanStatements.constructor_point := by intro T t x; rfl
theorem selected_projection_checked : CleanStatements.selected_point_projection := by intro Q; rfl
'''
native+=r'''
private def carrierCanonical (names : List (Name × Name)) : Expr → Expr
 | .const n us => .const ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) us
 | .proj n i b => .proj ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) i (carrierCanonical names b)
 | .lam _ t b i => .lam Name.anonymous (carrierCanonical names t) (carrierCanonical names b) i
 | .forallE _ t b i => .forallE Name.anonymous (carrierCanonical names t) (carrierCanonical names b) i
 | .letE _ t v b n => .letE Name.anonymous (carrierCanonical names t) (carrierCanonical names v) (carrierCanonical names b) n
 | .app f a => .app (carrierCanonical names f) (carrierCanonical names a)
 | .mdata _ b => carrierCanonical names b
 | e => e
'''
pairs=[(record,'ExpectedPointedSpace')]+[(record+'.'+n,'ExpectedPointedSpace.'+n) for n in ['mk','carrier','topology','point']]
pairs += [(family_record,'ExpectedCarrierFamily')]+[(family_record+'.'+n,'ExpectedCarrierFamily.'+n) for n in ['mk','value']]
checks=pairs+[(ctor,'expected_constructor'),(family_ctor,'expected_family_constructor')]
native+='\nrun_cmd do\n let env ← getEnv\n let names : List (Name × Name) := ['+', '.join('(`'+a+', `'+b+')' for a,b in pairs)+']\n'
native+=' let checks : List (Name × Name) := ['+', '.join('(`'+a+', `'+b+')' for a,b in checks)+']\n'
native+=r'''
 for (a,b) in checks do
  let some x := env.find? a | throwError "Missing actual {a}"
  let some y := env.find? b | throwError "Missing expected {b}"
  unless x.levelParams == y.levelParams && Expr.equal (carrierCanonical names x.type) (carrierCanonical names y.type) do
   throwError "Carrier declaration type differs: {a}"
  match x, y with
  | .defnInfo dx, .defnInfo dy =>
    unless Expr.equal (carrierCanonical names dx.value) (carrierCanonical names dy.value) do
     throwError "Carrier declaration body differs: {a}"
  | .inductInfo _, .inductInfo _ => pure ()
  | .ctorInfo _, .ctorInfo _ => pure ()
  | _, _ => throwError "Carrier declaration kinds differ: {a}"
'''
p=COMPILER/'CarrierVerified.lean';p.write_text(native)
(COMPILER/'CarrierStatements.tex').write_text(latex(results,e))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
print('Carrier prototype: twenty-one exact targets, six proofs, and syntax/scope/negative checks passed')
regression_env=os.environ.copy();regression_env['PYTHONPATH']=str(COMPILER/'tests')
subprocess.run([sys.executable,'-m','unittest',
 'test_type_expressions','test_structures','test_alias_descriptions','test_dependent_calls',
 'test_dependent_functions','test_dependent_type_syntax','test_callable_evidence',
 'test_scoped_family_keys','test_hygienic_conversion','test_inferred_conversion',
 'test_conditions','test_sequential_scope','-v'],cwd=COMPILER,env=regression_env,check=True)


# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
