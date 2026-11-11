# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex,Expressions,Expr
from cleanlang.modules import load_document,type_declaration,notation
from cleanlang.syntax import parse,expression_tree
from cleanlang.conversion import comparison_normal_form
env=Environment();HERE=Path(__file__).resolve().parent
results=load_document(HERE/'TypeValueExample.clean',env)
assert expression_tree(parse('type(TopologicalSpace : LargeTypes)','expression'))==['ClassifiedTypeValue','TopologicalSpace','LargeTypes']
assert results[0].conclusion.tree[2][0][2][0][0]=='BoundTypeValue'
scope={'X':Expr('X','X',env.type('TopologicalSpace'),tree=['Local','X'])}
assert comparison_normal_form(Expressions(env,scope).parse('retain inferred(X)'),env,scope).tree==['Local','X']
type_declaration('Type Indexed(T: LargeTypes):',['Means: Nat','Render latex: I({T})'],env)
notation('Notation tag(x):',['Let A: LargeTypes','Let x: A','Returns: Indexed(A)','Means: 0','Render latex: t({x})'],env)
indexed=Expressions(env,scope).parse('tag(X)')
if '--payload-only' in sys.argv:
 from dataclasses import replace
 from cleanlang.indices import index_value
 from cleanlang.dependent_functions import index_tree
 from cleanlang.retained_codec import dumps,loads
 # Reconstruct from encoded data with no cached tree. Lean targets below remain
 # independently authored, and are compared with the freshly elaborated value.
 stored=replace(loads(dumps(index_value(indexed,env,scope))),resolved=None)
 indexed=Expressions(env,scope).elaborate(index_tree(stored))
 carrier=Expressions(env,scope).parse('type(TopologicalSpace : LargeTypes)')
 restored=Expressions(env,scope).elaborate(loads(dumps(carrier.tree)))
 assert restored.lean==carrier.lean and restored.type==carrier.type
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
expected='''
namespace TypeValueOracle
noncomputable def carrier : CLASSIFIER := SPACE
noncomputable def retainIn (A : Type 1) (x : A) : A := x
noncomputable def inferred {A : Type 1} (x : A) : A := RETAIN A x
noncomputable def equalLarge {A : Type 1} (x y : A) : PROPOSITION := x = y
noncomputable def explicitStatement : Prop := ∀ (X : SPACE), EQUAL (RETAIN SPACE X) X
noncomputable def inferredStatement : Prop := ∀ (X : SPACE), EQUAL (INFERRED X) X
noncomputable def namedStatement : Prop := ∀ (X : SPACE), @EQUAL SPACE (RETAIN CARRIER X) X
def indexed (T : CLASSIFIER) : Type := Nat
noncomputable def tag {A : Type 1} (x : A) : INDEXED A := 0
noncomputable def applied (X : SPACE) : INDEXED SPACE := @TAG SPACE X
end TypeValueOracle
'''
# Historical study stacks retain their former classifier-wrapper binder.
# Current production explicitly selects the new generic parameter contract.
if '--classified-parameters' in sys.argv:
 expected=expected.replace('def indexed (T : CLASSIFIER)', 'def indexed (T : Type 1)')
mapping={'INDEXED':t('Indexed'),'TAG':f('tag'),'CARRIER':f('topology carrier'),'CLASSIFIER':t('LargeTypes'),'SPACE':t('TopologicalSpace'),'RETAIN':f('retain in'),'INFERRED':f('retain inferred'),'EQUAL':f('equal large'),'PROPOSITION':t('Proposition')}
for k,v in mapping.items():expected=re.sub(r'\b'+k+r'\b',v,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),o) for n,o in [('topology carrier','carrier'),('retain in','retainIn'),('retain inferred','inferred'),('equal large','equalLarge')]]
pairs += [(t('Indexed'),'indexed'),(f('tag'),'tag'),('TypeValueApplied','applied')]
pairs += [('CleanStatements.explicit_topology_carrier','explicitStatement'),('CleanStatements.inferred_topology_carrier','inferredStatement'),('CleanStatements.named_topology_carrier','namedStatement')]
application='\nnoncomputable def TypeValueApplied (X : '+env.render_type(env.type('TopologicalSpace'),'lean')+') : '+env.render_type(indexed.type,'lean',scope)+' := '+indexed.lean+'\n'
source=lean(results,env,['Lean'])+application+expected+comparison+'\n'.join('same_basic_target '+a+' TypeValueOracle.'+b for a,b in pairs)+'\n'
source+='theorem explicit_topology_carrier_proved : CleanStatements.explicit_topology_carrier := by\n  intro X\n  rfl\n'
source+='theorem inferred_topology_carrier_proved : CleanStatements.inferred_topology_carrier := by\n  intro X\n  rfl\n'
source+='theorem named_topology_carrier_proved : CleanStatements.named_topology_carrier := by\n  intro X\n  rfl\n'
source+='\n-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
p=HERE/'TypeValueTargets.lean';p.write_text(source)
(HERE/'TypeValueExample.tex').write_text(latex(results,env)+'\n% generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('First-class carrier source tree, reification, ten exact targets and three proofs passed.')
