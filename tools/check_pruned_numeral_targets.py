# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
e=Environment();load_module(ROOT/'library/diagrams/zigzags.clean',e)
typ=lambda name:e.data['types'][name]['native_binding']
key=lambda name:e.data['functions'][name]['native_binding']
nat,vertex,prop=map(typ,['Natural','Vertex','Proposition'])
add,number,le,vle=map(key,['natural sum','vertex number','natural at most','vertex at most'])
num=e.data['types']['Natural']['numerals']['native_binding']
s={}
for n,t in [('n','Natural'),('u','Vertex(n)'),('v','Vertex(n)')]:s[n]=Expr(n,n,e.type(t,s),tree=['Local',n])
actual=Expressions(e,s).parse('+'.join(['(n+1)']*9)).lean
order=Expressions(e,s).parse('u≤v').lean
one=f'{add} n ({num} (nat_lit 1))'
expected='('+one+')'
for _ in range(8):expected=f'({add} {expected} ({one}))'
checks=f'''
noncomputable def expectedVertexOrder {{n : {nat}}} (u v : {vertex} n) : {prop} :=
 {le} (@{number} n u) (@{number} n v)
same_basic_target {vle} expectedVertexOrder
noncomputable def actualOrder (n : {nat}) (u v : {vertex} n) : {prop} := {order}
noncomputable def expectedOrder (n : {nat}) (u v : {vertex} n) : {prop} := @{vle} n u v
same_basic_target actualOrder expectedOrder
noncomputable def actualLong (n : {nat}) : {nat} := {actual}
noncomputable def expectedLong (n : {nat}) : {nat} := {expected}
same_basic_target actualLong expectedLong
theorem vertexReflexive (n : {nat}) (u : {vertex} n) : actualOrder n u u := by
 change u.val ≤ u.val
 exact Nat.le_refl _
theorem vertexTransitive (n : {nat}) (u v w : {vertex} n)
 (h : actualOrder n u v) (k : actualOrder n v w) : actualOrder n u w := by
 exact Nat.le_trans h k
theorem longAtZero : actualLong 0 = 9 := by rfl
'''
with tempfile.TemporaryDirectory() as d:
 p=Path(d)/'Checks.lean';p.write_text(lean([],e,['Lean'])+comparison+checks)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Three canonical vertex-order/numeral targets and three proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
