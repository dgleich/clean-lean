# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Jointly select scoped bodies and sibling arguments; check complete native calls.

This explicit adapter supplies the consumer signature constraints. It is not the
source Builder's general nested-lambda elaboration path.
"""
from pathlib import Path
from itertools import product
import ast,os,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(ROOT),str(HERE)]
from cleanlang.core import Environment,Expressions,lean
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from clean_rows import Builder
from scoped_bodies import ScopedBody
from contextual_constraints import Candidate,select_contextual
from constraint_model import Row,Selection

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
num=lambda name:env.data['types'][name]['numerals']['native_binding']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
cases=[
 ('consume family','Function(k: Natural,Vector(k,Complex))','Natural','Real','x',
  f'fun (k : {t("Natural")}) => {f("complex vector zero")} k'),
 ('apply complex','Function(Complex,Complex)','Complex','Complex','f x',
  f'fun (z : {t("Complex")}) => {num("Complex")} (nat_lit 0)'),
 ('consume shifted family','Function(k: Natural,Vector((k+1),Complex))','Natural','Real','x',
  f'fun (k : {t("Natural")}) => {f("complex vector zero")} ({f("natural sum")} k ({num("Natural")} (nat_lit 1)))'),
]
checks=[]
for i,(name,function_type,domain,result,meaning,lambda_oracle) in enumerate(cases):
 notation(f'Notation {name}(f: {function_type},x: {result}): {result}:',
          ['Means: '+meaning,'Render latex: consume({f},{x})'],env)
 binder='z' if domain=='Complex' else 'k'
 source=f'{name}(function ({binder}: {domain}, 0),0)'
 tree=expression_tree(parse(source,'expression'))
 assert tree==['Call',name,[['Lambda',binder,domain,['Decimal','0']],['Decimal','0']]]
 # The complex scalar body's result is constrained by the consumer in the joint
 # row, rather than supplying its expected result to the child Builder early.
 body=ScopedBody(env,{},tree[2][0],None if i==1 else env.type(function_type),path=(2,0))
 sibling=Builder(env,{})
 body_rows=body.rows();sibling_rows=sibling.rows(tree[2][1]);combinations=[];candidates=[]
 expected_result=sibling.typ(env.type(result))
 for b,a in product(body_rows,sibling_rows):
  equations=b.equations+a.equations+((a.arguments[-1],expected_result),)
  if i==1:equations+=((b.arguments[-1],body.builder.typ(env.type('Complex'))),)
  row=Row((len(combinations),),b.carriers+a.carriers,b.arguments+a.arguments,equations,b.deferred+a.deferred)
  combinations.append((b,a));candidates.append(Candidate(row))
 selected=select_contextual(candidates,default=sibling.typ(env.type('Real'))).selection
 b,a=combinations[selected.choices[0]];width=len(b.arguments);count=len(b.carriers)
 body_trace=Selection(b.choices,selected.arguments[:width],
  tuple(p for p in selected.defaulted_positions if p<count),selected.default_carrier)
 sibling_trace=Selection(a.choices,selected.arguments[width:],
  tuple(p-count for p in selected.defaulted_positions if p>=count),selected.default_carrier)
 bvalue=body.retain(body_trace);avalue=sibling.retain_selected(tree[2][1],sibling_trace)
 whole=Expressions(env,{}).elaborate(['Call',name,[bvalue.tree,avalue.tree]])
 expected=f'{f(name)} ({lambda_oracle}) ({num(result)} (nat_lit 0))'
 checks.append(f'''
noncomputable def actualScoped{i} : {t(result)} := {whole.lean}
noncomputable def expectedScoped{i} : {t(result)} := {expected}
same_basic_target actualScoped{i} expectedScoped{i}
theorem scopedMeaning{i} : actualScoped{i} = 0 := by
  simp [actualScoped{i}, {f(name)}, {num(result)}]
''')
path=HERE/'ScopedBodyTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three complete scoped-lambda call targets and three interpretation proofs passed; general nested-source integration remains pending.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
