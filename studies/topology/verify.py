# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Generate foundation targets and proofs; never assume a pending paper theorem."""
from pathlib import Path
import sys,ast,os,subprocess
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();rs=load_document(here/'Foundations.clean',env)
text=lean(rs,env,[])
(here/'Generated.lean').write_text(text)
pre=env.definitions['inverse image']['key']
image=env.definitions['image']['key']
continuous=env.definitions['continuous between']['key']
# Explicit declaration mappings; expected bodies are authored independently.
f=lambda name:env.data['functions'][name]['native_binding']
k=lambda name:env.data['types'][name]['native_binding']
ref=lambda name:'_root_.'+f(name)
K,P,S,T=('_root_.'+k(name) for name in ['Type','Proposition','Set','Topology'])
setof,opn,pre_ref,img,compose,cont,selected,family=(ref(name) for name in
    ['set of','open in','inverse image','image','compose maps','continuous between',
     'selected elements','intersection family'])
eq,member,inter,conj,iff,imp=(ref(name) for name in ['equal','set member','set intersection','conjunction','logical equivalence','implication'])
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
    if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
oracles='';count=0
def target(actual,binders,typ,body):
    global oracles,count
    expected='expected_topology_binding_'+str(count);count+=1
    oracles+=f'\nnoncomputable def {expected} {binders} : {typ} := {body}\nsame_basic_target {actual} {expected}\n'
for name,binders,typ,body in [
 ('Type','','Type 1','Type'),('Proposition','','Sort 1','Prop'),
 ('Set','(X : Type)','Type','Set X'),
 ('Function','(X Y : Type)','Type','X → Y'),
 ('Topology','(X : Type)','Type','TopologicalSpace X')]:target(k(name),binders,typ,body)
for name,binders,typ,body in [
 ('set of',f'{{X : Type}} (condition : X → {P})',f'{S} X','setOf condition'),
 ('open in',f'{{X : Type}} (S : {S} X) (t : {T} X)',P,'@IsOpen X t S'),
 ('inverse image',f'{{X Y : Type}} (f : X → Y) (S : {S} Y)',f'{S} X',f'@{setof} X (fun x : X => @{member} Y (f x) S)'),
 ('image',f'{{X Y : Type}} (f : X → Y) (S : {S} X)',f'{S} Y',f'@{setof} Y (fun y : Y => ∃ x : X, {conj} (@{member} X x S) (@{eq} Y (f x) y))'),
 ('compose maps','{X Y Z : Type} (g : Y → Z) (f : X → Y)','X → Z','fun x : X => g (f x)'),
 ('continuous between',f'{{X Y : Type}} (f : X → Y) (t : {T} X) (u : {T} Y)',P,f'∀ S : {S} Y, {imp} (@{opn} Y S u) (@{opn} X (@{pre_ref} X Y f S) t)'),
 ('selected elements',f'{{X : Type}} (S : {S} X) (condition : X → {P})',f'{S} X',f'@{setof} X (fun x : X => {conj} (@{member} X x S) (condition x))'),
 ('intersection family',f'{{I X : Type}} (sets : I → {S} X)',f'{S} X',f'@{setof} X (fun x : X => ∀ i : I, @{member} X x (sets i))')]:target(f(name),binders,typ,body)
expected_statements=[
 f'∀ (X Y : {K}) (f : X → Y) (S T : {S} Y), @{eq} ({S} X) (@{pre_ref} X Y f (@{inter} Y S T)) (@{inter} X (@{pre_ref} X Y f S) (@{pre_ref} X Y f T))',
 f'∀ (X Y : {K}) (f : X → Y) (S : {S} X) (y : Y), {iff} (@{member} Y y (@{img} X Y f S)) (∃ x : X, {conj} (@{member} X x S) (@{eq} Y (f x) y))',
 f'∀ (X Y Z : {K}) (t : {T} X) (u : {T} Y) (v : {T} Z) (f : X → Y) (g : Y → Z) (_ : @{cont} X Y f t u) (_ : @{cont} Y Z g u v), @{cont} X Z (@{compose} X Y Z g f) t v',
 f'∀ (I X : {K}) (sets : I → {S} X) (x : X), {iff} (@{member} X x (@{family} I X sets)) (∀ i : I, @{member} X x (sets i))']
for result,body in zip(rs,expected_statements):target('CleanStatements.'+result.name,'','Prop',body)
for name,binders,typ,body in [
 ('equal','{X : Type} (x y : X)',P,'x=y'),
 ('set member',f'{{X : Type}} (x : X) (A : {S} X)',P,'x ∈ A'),
 ('set intersection',f'{{X : Type}} (A B : {S} X)',f'{S} X','A ∩ B'),
 ('conjunction',f'(p q : {P})',P,'p ∧ q'),
 ('logical equivalence',f'(p q : {P})',P,'p ↔ q'),
 ('implication',f'(p q : {P})',P,'p → q')]:target(f(name),binders,typ,body)
assert count==23
proofs=f'''
namespace TopologyFoundationProofs

-- Agreement with independently named Lean constructions.
theorem inverse_image_agrees {{X Y : Type}} (f : X → Y) (S : Set Y) :
    {pre} f S = f ⁻¹' S := rfl

theorem image_agrees {{X Y : Type}} (f : X → Y) (S : Set X) :
    {image} f S = f '' S := rfl

theorem continuity_agrees {{X Y : Type}} (f : X → Y)
    (t : TopologicalSpace X) (u : TopologicalSpace Y) :
    {continuous} f t u ↔ @Continuous X Y t u f := by
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

end TopologyFoundationProofs
'''
verified='import Lean\nimport Mathlib.Topology.Continuous\n'+text+comparison+oracles+proofs
(here/'Verified.lean').write_text(verified)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(here/'Verified.lean')],cwd=ROOT,check=True)
(here/'Foundations.tex').write_text(latex(rs,env))
print('Checked twenty-three exact topology targets, four foundation proofs and three Mathlib agreement proofs on the working compiler.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
