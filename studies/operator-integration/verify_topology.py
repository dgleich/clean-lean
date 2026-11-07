# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Port authored topology foundations to explicit declared operators."""
from pathlib import Path
import ast,sys,os,subprocess,tempfile,shutil
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean,latex
from cleanlang.modules import load_document,load_module
from cleanlang.syntax import expression_tree,parse

e=Environment();results=load_document(HERE/'foundations/TopologyStatements.clean.proposed',e)
assert len(results)==4
f=lambda name:e.data['functions'][name]['native_binding']
k=lambda name:e.data['types'][name]['native_binding']
ref=lambda name:'_root_.'+f(name)
K,P,S,T=('_root_.'+k(name) for name in ['Type','Proposition','Set','Topology'])
eq,conj,imp,iff,mem,inter,sets,opn,pre,img,compose,cont,select,family=(ref(name) for name in ['equal','conjunction','implication','equivalent','member','intersection','set of','open in','inverse image','image','compose maps','continuous between','selected elements','intersection family'])
# The neutral source tree is fixed before any declaration or instance checking.
assert expression_tree(parse('x ∈ S and f(x) = y','expression'))==['Operator','∧',['Operator','∈',['Local','x'],['Local','S']],['Operator','=', ['Call','f',[['Local','x']]],['Local','y']]]
scope={}
for name,typ in [('X','Type'),('Y','Type'),('f','Function(X,Y)'),('t','Topology(X)'),('u','Topology(Y)')]:
    scope[name]=Expr(name,name,e.type(typ,scope),tree=['Local',name])
valid=Expressions(e,scope).parse('continuous between(f,t,u)')
try:Expressions(e,scope).parse('continuous between(f,u,t)')
except CleanError:pass
else:raise AssertionError('Swapped topologies on different carriers were accepted')
# Removing membership metadata must prevent an authored inverse-image definition
# from quietly obtaining the former compiler built-in meaning.
with tempfile.TemporaryDirectory() as td:
    for path in (HERE/'foundations').glob('*.clean.proposed'):shutil.copy2(path,Path(td)/path.name)
    path=Path(td)/'Sets.clean.proposed';path.write_text(path.read_text().replace('  Infix: ∈\n',''))
    try:load_module(Path(td)/'Topology.clean.proposed',Environment())
    except CleanError as error:assert 'No declared meaning for operator ∈' in str(error),str(error)
    else:raise AssertionError('Authored topology used undeclared membership')

comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=lean(results,e,['Lean','Mathlib.Topology.Continuous'])+comparison
count=0

def target(actual,binders,typ,body):
    global native,count
    name='expected_topology_'+str(count);count+=1
    native+=f'\nnoncomputable def {name} {binders} : {typ} := {body}\nsame_basic_target {actual} {name}\n'

target(k('Topology'),'(X : Type)','Type','TopologicalSpace X')
for name,binders,typ,body in [
 ('set of',f'{{X : Type}} (condition : X → {P})',f'{S} X','setOf condition'),
 ('open in',f'{{X : Type}} (S : {S} X) (t : {T} X)',P,'@IsOpen X t S'),
 ('inverse image',f'{{X Y : Type}} (f : X → Y) (S : {S} Y)',f'{S} X',f'@{sets} X (fun x : X => @{mem} Y (f x) S)'),
 ('image',f'{{X Y : Type}} (f : X → Y) (S : {S} X)',f'{S} Y',f'@{sets} Y (fun y : Y => ∃ x : X, {conj} (@{mem} X x S) (@{eq} Y (f x) y))'),
 ('compose maps','{X Y Z : Type} (g : Y → Z) (f : X → Y)','X → Z','fun x : X => g (f x)'),
 ('continuous between',f'{{X Y : Type}} (f : X → Y) (t : {T} X) (u : {T} Y)',P,f'∀ S : {S} Y, {imp} (@{opn} Y S u) (@{opn} X (@{pre} X Y f S) t)'),
 ('selected elements',f'{{X : Type}} (S : {S} X) (condition : X → {P})',f'{S} X',f'@{sets} X (fun x : X => {conj} (@{mem} X x S) (condition x))'),
 ('intersection family',f'{{I X : Type}} (sets : I → {S} X)',f'{S} X',f'@{sets} X (fun x : X => ∀ i : I, @{mem} X x (sets i))')]:target(f(name),binders,typ,body)

expected=[
 f'∀ (X Y : {K}) (f : X → Y) (S T : {S} Y), @{eq} ({S} X) (@{pre} X Y f (@{inter} Y S T)) (@{inter} X (@{pre} X Y f S) (@{pre} X Y f T))',
 f'∀ (X Y : {K}) (f : X → Y) (S : {S} X) (y : Y), {iff} (@{mem} Y y (@{img} X Y f S)) (∃ x : X, {conj} (@{mem} X x S) (@{eq} Y (f x) y))',
 f'∀ (X Y Z : {K}) (t : {T} X) (u : {T} Y) (v : {T} Z) (f : X → Y) (g : Y → Z) (_ : @{cont} X Y f t u) (_ : @{cont} Y Z g u v), @{cont} X Z (@{compose} X Y Z g f) t v',
 f'∀ (I X : {K}) (sets : I → {S} X) (x : X), {iff} (@{mem} X x (@{family} I X sets)) (∀ i : I, @{mem} X x (sets i))']
for result,body in zip(results,expected):target('CleanStatements.'+result.name,'','Prop',body)
assert count==13
native+=f'''
-- Agreement with Mathlib is proved, not assumed by the foundation wrappers.
theorem inverse_image_agrees {{X Y : Type}} (f : X → Y) (S : Set Y) :
    {pre} f S = f ⁻¹' S := rfl

theorem image_agrees {{X Y : Type}} (f : X → Y) (S : Set X) :
    {img} f S = f '' S := rfl

theorem continuity_agrees {{X Y : Type}} (f : X → Y)
    (t : TopologicalSpace X) (u : TopologicalSpace Y) :
    {cont} f t u ↔ @Continuous X Y t u f := by
  letI : TopologicalSpace X := t
  letI : TopologicalSpace Y := u
  change (∀ S : Set Y, IsOpen S → IsOpen (f ⁻¹' S)) ↔ Continuous f
  exact continuous_def.symm

theorem inverse_image_intersection : CleanStatements.inverse_image_intersection := by
  intro X Y f S T
  rfl

theorem image_membership : CleanStatements.image_membership := by
  intro X Y f S y
  rfl

theorem continuous_composition : CleanStatements.continuous_composition := by
  intro X Y Z t u v f g hf hg
  change ∀ S : Set Z, @IsOpen Z v S → @IsOpen X t ((g ∘ f) ⁻¹' S)
  intro S hS
  exact hf (g ⁻¹' S) (hg S hS)

theorem family_intersection_membership : CleanStatements.family_intersection_membership := by
  intro I X sets x
  rfl
'''
p=COMPILER/'TopologyVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
(HERE/'TopologyVerified.lean').write_text(native)
(HERE/'Topology.tex').write_text(latex(results,e))
print('Topology migration: 13 exact targets, four statement proofs and three Mathlib agreement proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
