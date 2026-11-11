# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Native checks of selected experimental rows, not production joint inference."""
from pathlib import Path
import ast,os,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(ROOT),str(HERE)]
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
from clean_rows import Builder

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
scope={n:Expr(n,n,env.type('Natural'),tree=['Local',n]) for n in ('m','n')}
for name,source in [('x','Vector(n,Complex)'),('A','Matrix(m,n,Real)'),('r','Real')]:
 scope[name]=Expr(name,name,env.type(source,scope),tree=['Local',name])
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
vec=f"{t('Vector')} n {t('Complex')}";mat=f"{t('Matrix')} m n {t('Real')}"
binders=f"(m n : {t('Natural')}) (x : {vec}) (A : {mat}) (r : {t('Real')})"
zv=f"{f('complex vector zero')} n";zm=f"{f('real matrix zero')} m n"
nr=env.data['types']['Real']['numerals']['native_binding']
cases=[
 ('x != 0',t('Proposition'),f"@{f('unequal')} ({vec}) x ({zv})",'x ≠ (fun _ => (0 : Complex))'),
 ('0 != x',t('Proposition'),f"@{f('unequal')} ({vec}) ({zv}) x",'(fun _ => (0 : Complex)) ≠ x'),
 ('A = 0',t('Proposition'),f"@{f('equal')} ({mat}) A ({zm})",'A = (fun _ _ => (0 : Real))'),
 ('0 = A',t('Proposition'),f"@{f('equal')} ({mat}) ({zm}) A",'(fun _ _ => (0 : Real)) = A'),
 ('r + 0',t('Real'),f"{f('real sum')} r ({nr} (nat_lit 0))",None),
]
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
checks=[]
for i,(source,result,expected,meaning) in enumerate(cases):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
 checks.append(f'''
noncomputable def actualJoint{i} {binders} : {result} := {value.lean}
noncomputable def expectedJoint{i} {binders} : {result} := {expected}
same_basic_target actualJoint{i} expectedJoint{i}
''')
 if meaning is not None:
  checks.append(f'theorem meaningJoint{i} {binders} : actualJoint{i} m n x A r ↔ ({meaning}) := by rfl\n')
 else:
  checks.append(f'''theorem meaningJoint{i} {binders} : actualJoint{i} m n x A r = r := by
  simp [actualJoint{i}, {f('real sum')}, {nr}]
''')
nn=env.data['types']['Natural']['numerals']['native_binding']
nzero=f"{nn} (nat_lit 0)"
for i,(source,typ,expected) in enumerate([
 ('0',t('Natural'),nzero),
 ('0 = 0',t('Proposition'),f"@{f('equal')} {t('Natural')} ({nzero}) ({nzero})")]):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
 checks.append(f'''
noncomputable def actualDefault{i} : {typ} := {value.lean}
noncomputable def expectedDefault{i} : {typ} := {expected}
same_basic_target actualDefault{i} expectedDefault{i}
''')
checks.append('theorem meaningDefault0 : actualDefault0 = (0 : Nat) := by rfl\n')
checks.append('theorem meaningDefault1 : actualDefault1 := by rfl\n')
from cleanlang.structures import declare
declare('Structure ScalarCell():',['Let entry: Real','Constructor: scalar cell'],env)
declare('Structure VectorCell(n: Natural):',
 ['Let entry: Vector(n,Complex)','Constructor: vector cell'],env)
for i,(source,result,expected,meaning) in enumerate([
 ('scalar cell(0)',env.structures['ScalarCell']['key'],
  f"@{f('scalar cell')} ({nr} (nat_lit 0))",'(0 : Real)'),
 ('vector cell(n,0)',env.structures['VectorCell']['key']+' n',
  f"@{f('vector cell')} n ({zv})",'(fun _ => (0 : Complex))')]):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
 proof=f"by simp [actualConstructor{i}, {f('scalar cell')}, {nr}]" if i==0 else 'by rfl'
 checks.append(f"""
noncomputable def actualConstructor{i} {binders} : {result} := {value.lean}
noncomputable def expectedConstructor{i} {binders} : {result} := {expected}
same_basic_target actualConstructor{i} expectedConstructor{i}
theorem meaningConstructor{i} {binders} :
  (actualConstructor{i} m n x A r).entry = {meaning} := {proof}
""")
ntwo=f"{nn} (nat_lit 2)"
cell=env.structures['VectorCell']['key']
for i,source in enumerate(['vector cell(2,0)','vector cell((2:Natural),0)']):
 value=Builder(env,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualLiteralDimension{i} : {cell} ({ntwo}) := {value.lean}
noncomputable def expectedLiteralDimension{i} : {cell} ({ntwo}) :=
  @{f('vector cell')} ({ntwo}) (@{f('complex vector zero')} ({ntwo}))
same_basic_target actualLiteralDimension{i} expectedLiteralDimension{i}
theorem meaningLiteralDimension{i} :
  actualLiteralDimension{i}.entry = (fun _ => (0 : Complex)) := by rfl
""")
from cleanlang.modules import notation
notation('Notation successor(n: Natural): Natural:',
 ['Means: Nat.succ n','Render latex: {n}+1'],env)
declare('Structure Dimension():',['Let size: Natural','Constructor: dimension'],env)
dim=env.structures['Dimension']['key']
computed_scope={'n':scope['n'],'D':Expr('D','D',env.type('Dimension'),tree=['Local','D'])}
computed_binders=f"(n : {t('Natural')}) (D : {dim})"
for i,(source,index) in enumerate([
 ('vector cell(successor(n),0)',f"{f('successor')} n"),
 ('vector cell(D.size,0)',f"@{dim}.size D"),
 ('vector cell(n+n,0)',f"{f('natural sum')} n n")]):
 value=Builder(env,computed_scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualComputedDimension{i} {computed_binders} : {cell} ({index}) := {value.lean}
noncomputable def expectedComputedDimension{i} {computed_binders} : {cell} ({index}) :=
  @{f('vector cell')} ({index}) (@{f('complex vector zero')} ({index}))
same_basic_target actualComputedDimension{i} expectedComputedDimension{i}
theorem meaningComputedDimension{i} {computed_binders} :
  (actualComputedDimension{i} n D).entry = (fun _ => (0 : Complex)) := by rfl
""")
none=f"{nn} (nat_lit 1)"
for i,(source,index) in enumerate([
 ('vector cell(successor(2),0)',f"{f('successor')} ({ntwo})"),
 ('vector cell(successor(successor(2)),0)',f"{f('successor')} ({f('successor')} ({ntwo}))"),
 ('vector cell(n+1,0)',f"{f('natural sum')} n ({none})")]):
 value=Builder(env,computed_scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualDeferredDimension{i} {computed_binders} : {cell} ({index}) := {value.lean}
noncomputable def expectedDeferredDimension{i} {computed_binders} : {cell} ({index}) :=
  @{f('vector cell')} ({index}) (@{f('complex vector zero')} ({index}))
same_basic_target actualDeferredDimension{i} expectedDeferredDimension{i}
theorem meaningDeferredDimension{i} {computed_binders} :
  (actualDeferredDimension{i} n D).entry = (fun _ => (0 : Complex)) := by rfl
""")
for i,(source,result,expected,claim) in enumerate([
 ('dimension(2).size',t('Natural'),ntwo,'actualProjection0 = (2 : Nat)'),
 ('vector cell(dimension(2).size,0)',f"{cell} ({ntwo})",
  f"@{f('vector cell')} ({ntwo}) (@{f('complex vector zero')} ({ntwo}))",
  'actualProjection1.entry = (fun _ => (0 : Complex))'),
 ('vector cell(2,0).entry',f"{t('Vector')} ({ntwo}) {t('Complex')}",
  f"@{f('complex vector zero')} ({ntwo})",'actualProjection2 = (fun _ => (0 : Complex))')]):
 value=Builder(env,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualProjection{i} : {result} := {value.lean}
noncomputable def expectedProjection{i} : {result} := {expected}
same_basic_target actualProjection{i} expectedProjection{i}
theorem meaningProjection{i} : {claim} := by rfl
""")
declare('Structure Payload():',
 ['Let size: Natural','Let data: Vector(size,Complex)','Constructor: payload'],env)
declare('Structure Box():',['Let value: Payload','Constructor: box'],env)
for i,(source,result,expected,claim) in enumerate([
 ('payload(2,0).data',f"{t('Vector')} ({ntwo}) {t('Complex')}",
  f"@{f('complex vector zero')} ({ntwo})",'actualFieldValue0 n D = (fun _ => (0 : Complex))'),
 ('payload(n,0).data',f"{t('Vector')} n {t('Complex')}",
  f"@{f('complex vector zero')} n",'actualFieldValue1 n D = (fun _ => (0 : Complex))'),
 ('vector cell(payload(2,0).size,0)',f"{cell} ({ntwo})",
  f"@{f('vector cell')} ({ntwo}) (@{f('complex vector zero')} ({ntwo}))",
  '(actualFieldValue2 n D).entry = (fun _ => (0 : Complex))'),
 ('box(payload(2,0)).value.data',f"{t('Vector')} ({ntwo}) {t('Complex')}",
  f"@{f('complex vector zero')} ({ntwo})",'actualFieldValue3 n D = (fun _ => (0 : Complex))')]):
 value=Builder(env,computed_scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualFieldValue{i} {computed_binders} : {result} := {value.lean}
noncomputable def expectedFieldValue{i} {computed_binders} : {result} := {expected}
same_basic_target actualFieldValue{i} expectedFieldValue{i}
theorem meaningFieldValue{i} {computed_binders} : {claim} := by rfl
""")
notation('Define padded(n: Natural,x: Vector((n+1),Complex)): Vector((n+1),Complex):',
 ['Equals: x','Render latex: P({n},{x})'],env,authored=True)
declare('Structure PaddedPayload():',
 ['Let size: Natural','Let data: Vector((size+1),Complex)','Constructor: padded payload'],env)
one=f"{nn} (nat_lit 1)"
for i,(source,argument,projected) in enumerate([
 ('padded(2,0)',ntwo,False),('padded(n,0)','n',False),
 ('padded payload(2,0).data',ntwo,True)]):
 index=f"{f('natural sum')} ({argument}) ({one})"
 result=f"{t('Vector')} ({index}) {t('Complex')}"
 zero=f"@{f('complex vector zero')} ({index})"
 expected=zero if projected else f"@{f('padded')} ({argument}) ({zero})"
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualFormalIndex{i} (n : {t('Natural')}) : {result} := {value.lean}
noncomputable def expectedFormalIndex{i} (n : {t('Natural')}) : {result} := {expected}
same_basic_target actualFormalIndex{i} expectedFormalIndex{i}
theorem meaningFormalIndex{i} (n : {t('Natural')}) :
  actualFormalIndex{i} n = (fun _ => (0 : Complex)) := by rfl
""")
declare('Structure PaddedCell(n: Natural):',
 ['Let data: Vector((n+1),Complex)','Constructor: padded cell'],env)
declare('Structure WrappedCell(n: Natural):',
 ['Let cell: PaddedCell(n)','Constructor: wrapped cell'],env)
for i,(source,argument) in enumerate([
 ('padded cell(2,0).data',ntwo),('padded cell(n,0).data','n'),
 ('wrapped cell(2,padded cell(2,0)).cell.data',ntwo)]):
 index=f"{f('natural sum')} ({argument}) ({one})"
 result=f"{t('Vector')} ({index}) {t('Complex')}"
 expected=f"@{f('complex vector zero')} ({index})"
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualParameterProjection{i} (n : {t('Natural')}) : {result} := {value.lean}
noncomputable def expectedParameterProjection{i} (n : {t('Natural')}) : {result} := {expected}
same_basic_target actualParameterProjection{i} expectedParameterProjection{i}
theorem meaningParameterProjection{i} (n : {t('Natural')}) :
  actualParameterProjection{i} n = (fun _ => (0 : Complex)) := by rfl
""")
declare('Structure PayloadHolder():',
 ['Let marker: Real','Let payload: Payload','Constructor: payload holder'],env)
declare('Structure PaddedHolder(n: Natural):',
 ['Let marker: Real','Let cell: PaddedCell(n)','Constructor: padded holder'],env)
declare('Structure GenericCell(T: Type):',['Let data: T','Constructor: generic cell'],env)
declare('Structure GenericHolder():',
 ['Let marker: Real','Let cell: GenericCell(Real)','Constructor: generic holder'],env)
padded_index=f"{f('natural sum')} ({ntwo}) ({one})"
for i,(source,result,expected,meaning) in enumerate([
 ('payload holder(0,payload((2:Natural),(0:Vector(2,Complex)))).payload.data',
  f"{t('Vector')} ({ntwo}) {t('Complex')}",f"@{f('complex vector zero')} ({ntwo})",'(fun _ => (0 : Complex))'),
 ('padded holder(2,0,padded cell((2:Natural),(0:Vector(((2:Natural)+1),Complex)))).cell.data',
  f"{t('Vector')} ({padded_index}) {t('Complex')}",f"@{f('complex vector zero')} ({padded_index})",'(fun _ => (0 : Complex))'),
 ('generic holder(0,generic cell(type(Real),(1:Real))).cell.data',
  t('Real'),f"{nr} (nat_lit 1)",'(1 : Real)')]):
 value=Builder(env,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
 proof='rfl' if i<2 else f'simp [actualKnownConstructor{i}, {nr}]'
 checks.append(f"""
noncomputable def actualKnownConstructor{i} : {result} := {value.lean}
noncomputable def expectedKnownConstructor{i} : {result} := {expected}
same_basic_target actualKnownConstructor{i} expectedKnownConstructor{i}
theorem meaningKnownConstructor{i} : actualKnownConstructor{i} = {meaning} := by {proof}
""")
notation('Define vector count(n: Natural,x: Vector(n,Complex)): Natural:',
 ['Equals: n','Render latex: len({x})'],env,authored=True)
for i,(source,argument,nested) in enumerate([
 ('vector cell(vector count(n,0),0)','n',False),
 ('vector cell(vector count(2,0),0)',ntwo,False),
 ('vector cell(vector count(vector count(2,0),0),0)',ntwo,True)]):
 zero=f"@{f('complex vector zero')} ({argument})"
 count=f"@{f('vector count')} ({argument}) ({zero})"
 if nested:count=f"@{f('vector count')} ({count}) ({zero})"
 result=f"{cell} ({argument})"
 expected=f"@{f('vector cell')} ({count}) ({zero})"
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualCandidateValue{i} (n : {t('Natural')}) : {result} := {value.lean}
noncomputable def expectedCandidateValue{i} (n : {t('Natural')}) : {result} := {expected}
same_basic_target actualCandidateValue{i} expectedCandidateValue{i}
theorem meaningCandidateValue{i} (n : {t('Natural')}) :
  (actualCandidateValue{i} n).entry = (fun _ => (0 : Complex)) := by rfl
""")
notation('Notation vector extent(n: Natural,x: Vector(n,Complex)): Natural:',
 ['Means: n','Render latex: extent({x})'],env)
extent=f"@{f('vector extent')} ({ntwo}) (@{f('complex vector zero')} ({ntwo}))"
extent_zero=f"@{f('complex vector zero')} ({extent})"
extent_count=f"@{f('vector count')} ({extent}) ({extent_zero})"
source='vector cell(vector count(vector extent(2,0),0),0)'
value=Builder(env,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
checks.append(f"""
noncomputable def actualOpaqueCandidate : {cell} ({extent}) := {value.lean}
noncomputable def expectedOpaqueCandidate : {cell} ({extent}) :=
  @{f('vector cell')} ({extent_count}) ({extent_zero})
same_basic_target actualOpaqueCandidate expectedOpaqueCandidate
theorem meaningOpaqueCandidate : actualOpaqueCandidate.entry = (fun _ => (0 : Complex)) := by rfl
""")
notation('Define shared vector count(x,y):',
 ['Let n: Natural','Let x,y: Vector(n,Complex)','Returns: Natural','Equals: n',
  'Render latex: len({x},{y})'],env,authored=True)
for i,(source,nested) in enumerate([
 ('vector cell(shared vector count(x,0),0)',False),
 ('vector cell(vector count(shared vector count(x,0),0),0)',True)]):
 zero=f"@{f('complex vector zero')} n"
 count=f"@{f('shared vector count')} n x ({zero})"
 if nested:count=f"@{f('vector count')} ({count}) ({zero})"
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualImplicitCandidate{i} (n : {t('Natural')}) (x : {vec}) : {cell} n := {value.lean}
noncomputable def expectedImplicitCandidate{i} (n : {t('Natural')}) (x : {vec}) : {cell} n :=
  @{f('vector cell')} ({count}) ({zero})
same_basic_target actualImplicitCandidate{i} expectedImplicitCandidate{i}
theorem meaningImplicitCandidate{i} (n : {t('Natural')}) (x : {vec}) :
  (actualImplicitCandidate{i} n x).entry = (fun _ => (0 : Complex)) := by rfl
""")
notation('Define dependent copy(n: Natural,x: Vector(n,Complex),y: Vector((vector extent(n,x)),Complex)): Vector((vector extent(n,x)),Complex):',
 ['Equals: y','Render latex: copy({n},{x},{y})'],env,authored=True)
declare('Structure DependentPayload(n: Natural):',
 ['Let input: Vector(n,Complex)','Let output: Vector((vector extent(n,input)),Complex)',
  'Constructor: dependent payload'],env)
for i,(source,arg,projection) in enumerate([
 ('dependent copy(n,0,0)','n',False),('dependent copy(2,0,0)',ntwo,False),
 ('dependent payload(n,0,0).output','n',True)]):
 first_zero=f"@{f('complex vector zero')} ({arg})"
 index=f"@{f('vector extent')} ({arg}) ({first_zero})"
 second_zero=f"@{f('complex vector zero')} ({index})"
 result=f"{t('Vector')} ({index}) {t('Complex')}"
 expected=second_zero if projection else f"@{f('dependent copy')} ({arg}) ({first_zero}) ({second_zero})"
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualDynamicFormal{i} (n : {t('Natural')}) : {result} := {value.lean}
noncomputable def expectedDynamicFormal{i} (n : {t('Natural')}) : {result} := {expected}
same_basic_target actualDynamicFormal{i} expectedDynamicFormal{i}
theorem meaningDynamicFormal{i} (n : {t('Natural')}) :
  actualDynamicFormal{i} n = (fun _ => (0 : Complex)) := by rfl
""")
notation('Notation make padded cell(n: Natural,data: Vector((n+1),Complex)): PaddedCell(n):',
 ['Means: '+f('padded cell')+' n data','Render latex: C({n},{data})'],env)
value=Builder(env,{}).materialize(expression_tree(parse('make padded cell(2,0).data','expression')),use_default=False)
index=f"{f('natural sum')} ({ntwo}) ({one})"
result=f"{t('Vector')} ({index}) {t('Complex')}"
padded=env.structures['PaddedCell']['key']
checks.append(f"""
noncomputable def actualOpaqueParameter : {result} := {value.lean}
noncomputable def expectedOpaqueParameter : {result} :=
  @{padded}.data ({ntwo}) (@{f('make padded cell')} ({ntwo}) (@{f('complex vector zero')} ({index})))
same_basic_target actualOpaqueParameter expectedOpaqueParameter
theorem meaningOpaqueParameter : actualOpaqueParameter = (fun _ => (0 : Complex)) := by rfl
""")
notation('Notation shifted(m: Natural): Matrix(m,(m+1),Complex):',
 ['Means: fun _ _ => (0 : Complex)','Literal: 7','Render latex: 7'],env)
notation('Define shifted size(n: Natural,x: Matrix(n,(n+1),Complex)): Natural:',
 ['Equals: n','Render latex: size({x})'],env,authored=True)
shifted_type=env.type('Matrix(n,(n+1),Complex)',scope)
for i,(source,expected_type,result,expected,meaning) in enumerate([
 ('7',shifted_type,f"{t('Matrix')} n ({f('natural sum')} n ({one})) {t('Complex')}",
  f"@{f('shifted')} n",'(fun _ _ => (0 : Complex))'),
 ('vector cell(shifted size(n,7),0)',None,f"{cell} n",
  f"@{f('vector cell')} (@{f('shifted size')} n (@{f('shifted')} n)) (@{f('complex vector zero')} n)",None)]):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),expected_type,use_default=False)
 checks.append(f"""
noncomputable def actualComputedLiteral{i} (n : {t('Natural')}) : {result} := {value.lean}
noncomputable def expectedComputedLiteral{i} (n : {t('Natural')}) : {result} := {expected}
same_basic_target actualComputedLiteral{i} expectedComputedLiteral{i}
theorem meaningComputedLiteral{i} (n : {t('Natural')}) :
  {'actualComputedLiteral'+str(i)+' n = '+meaning if meaning else '(actualComputedLiteral'+str(i)+' n).entry = (fun _ => (0 : Complex))'} := by rfl
""")
value=Builder(env,scope).materialize(expression_tree(parse('vector count(n,0)','expression')),use_default=False)
checks.append(f"""
noncomputable def actualUndemandedCall (n : {t('Natural')}) : {t('Natural')} := {value.lean}
noncomputable def expectedUndemandedCall (n : {t('Natural')}) : {t('Natural')} :=
  @{f('vector count')} n (@{f('complex vector zero')} n)
same_basic_target actualUndemandedCall expectedUndemandedCall
theorem meaningUndemandedCall (n : {t('Natural')}) : actualUndemandedCall n = n := by rfl
""")
from cleanlang.modules import type_declaration
type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],env)
for j,classifier in enumerate(['Type','Small']):
 extent='carrier extent' if j==0 else 'small extent'
 copier='typed vector' if j==0 else 'small vector'
 notation(f'Notation {extent}(T: {classifier}): Natural:',
  ['Means: 2','Render latex: extent({T})'],env)
 notation(f'Define {copier}(x,y):',
  [f'Let T: {classifier}','Let x: T',f'Let y: Vector(({extent}(T)),Complex)',
   f'Returns: Vector(({extent}(T)),Complex)','Equals: y','Render latex: vector({x},{y})'],env,authored=True)
 for k,arg in enumerate(['n','1'] if j==0 else ['n']):
  source=f'{copier}({arg},0)'
  value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
  index=f"@{f(extent)} {t('Natural')}"
  zero=f"@{f('complex vector zero')} ({index})"
  actual_arg='n' if arg=='n' else one
  checks.append(f"""
noncomputable def actualClassifierIndex{j}_{k} (n : {t('Natural')}) : {t('Vector')} ({index}) {t('Complex')} := {value.lean}
noncomputable def expectedClassifierIndex{j}_{k} (n : {t('Natural')}) : {t('Vector')} ({index}) {t('Complex')} :=
  @{f(copier)} {t('Natural')} ({actual_arg}) ({zero})
same_basic_target actualClassifierIndex{j}_{k} expectedClassifierIndex{j}_{k}
theorem meaningClassifierIndex{j}_{k} (n : {t('Natural')}) :
  actualClassifierIndex{j}_{k} n = (fun _ => (0 : Complex)) := by rfl
""")
for j,classifier in enumerate(['Type','Small']):
 extent='carrier extent' if j==0 else 'small extent'
 copier='explicit vector' if j==0 else 'explicit small vector'
 notation(f'Define {copier}(T: {classifier},x: T,y: Vector(({extent}(T)),Complex)): Vector(({extent}(T)),Complex):',
  ['Equals: y','Render latex: vector({T},{x},{y})'],env,authored=True)
 value=Builder(env,scope).materialize(expression_tree(parse(f'{copier}(type(Real:{classifier}),1,0)','expression')),use_default=False)
 index=f"@{f(extent)} {t('Real')}";zero=f"@{f('complex vector zero')} ({index})"
 checks.append(f"""
noncomputable def actualExplicitCarrier{j} : {t('Vector')} ({index}) {t('Complex')} := {value.lean}
noncomputable def expectedExplicitCarrier{j} : {t('Vector')} ({index}) {t('Complex')} :=
  @{f(copier)} {t('Real')} ({nr} (nat_lit 1)) ({zero})
same_basic_target actualExplicitCarrier{j} expectedExplicitCarrier{j}
theorem meaningExplicitCarrier{j} : actualExplicitCarrier{j} = (fun _ => (0 : Complex)) := by rfl
""")
declare('Structure TypedPayload(T: Type):',
 ['Let data: Vector((carrier extent(T)),Complex)','Constructor: typed payload'],env)
value=Builder(env,scope).materialize(expression_tree(parse('typed payload(type(Real:Type),0).data','expression')),use_default=False)
index=f"@{f('carrier extent')} {t('Real')}"
checks.append(f"""
noncomputable def actualCarrierProjection : {t('Vector')} ({index}) {t('Complex')} := {value.lean}
noncomputable def expectedCarrierProjection : {t('Vector')} ({index}) {t('Complex')} :=
  @{f('complex vector zero')} ({index})
same_basic_target actualCarrierProjection expectedCarrierProjection
theorem meaningCarrierProjection : actualCarrierProjection = (fun _ => (0 : Complex)) := by rfl
""")
for i,(function_type,source,binders,result,expected,meaning) in enumerate([
 ('Function(Vector(n,Complex),Real)','callback(0)',
  f"(n : {t('Natural')}) (local_f : {t('Function')} ({vec}) {t('Real')})",
  t('Real'),f"local_f (@{f('complex vector zero')} n)",None),
 ('Function(k: Natural,Vector((k+1),Complex))','callback(2)',
  f"(n : {t('Natural')}) (local_f : (k : {t('Natural')}) → {t('Vector')} ({f('natural sum')} k ({one})) {t('Complex')})",
  f"{t('Vector')} ({f('natural sum')} ({ntwo}) ({one})) {t('Complex')}",f"local_f ({ntwo})",None),
 ('Function(Vector(n,Complex),Natural)','vector cell(callback(0),0)',
  f"(n : {t('Natural')}) (local_f : {t('Function')} ({vec}) {t('Natural')})",
  f"{cell} (local_f (@{f('complex vector zero')} n))",
  f"@{f('vector cell')} (local_f (@{f('complex vector zero')} n)) (@{f('complex vector zero')} (local_f (@{f('complex vector zero')} n)))",'entry')]):
 local_scope=dict(scope)
 local_scope['callback']=Expr('local_f','f',env.type(function_type,scope),tree=['Local','callback'])
 value=Builder(env,local_scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 checks.append(f"""
noncomputable def actualLocalCall{i} {binders} : {result} := {value.lean}
noncomputable def expectedLocalCall{i} {binders} : {result} := {expected}
same_basic_target actualLocalCall{i} expectedLocalCall{i}
theorem meaningLocalCall{i} {binders} :
  {'(actualLocalCall'+str(i)+' n local_f).entry = (fun _ => (0 : Complex))' if meaning else 'actualLocalCall'+str(i)+' n local_f = '+expected} := by rfl
""")
for i,dependent in enumerate([False,True]):
 name='DependentMapHolder' if dependent else 'MapHolder'
 function='Function(k: Natural,Vector((k+1),Complex))' if dependent else 'Function(Vector(n,Complex),Real)'
 declare(f'Structure {name}(n: Natural):',[f'Let map: {function}','Constructor: dependent holder' if dependent else 'Constructor: ordinary holder'],env)
 local_scope=dict(scope);local_scope['q']=Expr('q','q',env.type(f'{name}(n)',scope),tree=['Local','q'])
 source='q.map(2)' if dependent else 'q.map(0)'
 value=Builder(env,local_scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 record=env.structures[name]['key'];arg=ntwo if dependent else f"@{f('complex vector zero')} n"
 result=f"{t('Vector')} ({f('natural sum')} ({ntwo}) ({one})) {t('Complex')}" if dependent else t('Real')
 expected=f"(@{record}.map n q) ({arg})"
 checks.append(f"""
noncomputable def actualFieldApply{i} (n : {t('Natural')}) (q : {record} n) : {result} := {value.lean}
noncomputable def expectedFieldApply{i} (n : {t('Natural')}) (q : {record} n) : {result} := {expected}
same_basic_target actualFieldApply{i} expectedFieldApply{i}
theorem meaningFieldApply{i} (n : {t('Natural')}) (q : {record} n) : actualFieldApply{i} n q = {expected} := by rfl
""")
notation('Notation consume dependent(f: Function(j: Natural,Vector((j+1),Complex)),x: Real): Real:',
 ['Means: x','Render latex: consume({f},{x})'],env)
local_scope=dict(scope)
record=env.structures['DependentMapHolder']['key']
local_scope['q']=Expr('q','q',env.type('DependentMapHolder(n)',scope),tree=['Local','q'])
value=Builder(env,local_scope).materialize(expression_tree(parse('consume dependent(q.map,0)','expression')),use_default=False)
expected=f"@{f('consume dependent')} (@{record}.map n q) ({nr} (nat_lit 0))"
checks.append(f"""
noncomputable def actualDependentArgument (n : {t('Natural')}) (q : {record} n) : {t('Real')} := {value.lean}
noncomputable def expectedDependentArgument (n : {t('Natural')}) (q : {record} n) : {t('Real')} := {expected}
same_basic_target actualDependentArgument expectedDependentArgument
theorem meaningDependentArgument (n : {t('Natural')}) (q : {record} n) : actualDependentArgument n q = ({nr} (nat_lit 0)) := by rfl
""")
notation('Notation make map(n: Natural,x: Real): Function(Vector(n,Complex),Real):',
 ['Means: fun _ => x','Render latex: map({n},{x})'],env)
value=Builder(env,scope).materialize(expression_tree(parse('make map(n,0)(0)','expression')),use_default=False)
expected=f"(@{f('make map')} n ({nr} (nat_lit 0))) (@{f('complex vector zero')} n)"
checks.append(f"""
noncomputable def actualInferredApply (n : {t('Natural')}) : {t('Real')} := {value.lean}
noncomputable def expectedInferredApply (n : {t('Natural')}) : {t('Real')} := {expected}
same_basic_target actualInferredApply expectedInferredApply
theorem meaningInferredApply (n : {t('Natural')}) : actualInferredApply n = ({nr} (nat_lit 0)) := by rfl
""")
for i,shifted in enumerate([False,True]):
 name='make shifted dependent' if shifted else 'make dependent'
 result='Vector((k+1),Complex)' if shifted else 'Vector(k,Complex)'
 notation(f'Notation {name}(x: Real): Function(k: Natural,{result}):',
  ['Means: fun _ _ => (0 : Complex)','Render latex: map({x})'],env)
 value=Builder(env,scope).materialize(expression_tree(parse(f'{name}(0)(2)','expression')),use_default=False)
 dimension=f"{f('natural sum')} ({ntwo}) ({one})" if shifted else ntwo
 result_lean=f"{t('Vector')} ({dimension}) {t('Complex')}"
 expected=f"(@{f(name)} ({nr} (nat_lit 0))) ({ntwo})"
 checks.append(f"""
noncomputable def actualDependentHead{i} : {result_lean} := {value.lean}
noncomputable def expectedDependentHead{i} : {result_lean} := {expected}
same_basic_target actualDependentHead{i} expectedDependentHead{i}
theorem meaningDependentHead{i} : actualDependentHead{i} = (fun _ => (0 : Complex)) := by rfl
""")
local_scope=dict(scope)
function_type=env.type('Function(j: Natural,Vector((j+1),Complex))',scope)
local_scope['callback']=Expr('callback','f',function_type,tree=['Local','callback'])
value=Builder(env,local_scope).materialize(expression_tree(parse('dependent holder(0,callback).map(2)','expression')),use_default=False)
record=env.structures['DependentMapHolder']['key']
# Existing direct-constructor projection reduction selects the supplied field.
expected=f"callback ({ntwo})"
function_lean=f"(j : {t('Natural')}) → {t('Vector')} ({f('natural sum')} j ({one})) {t('Complex')}"
result_lean=f"{t('Vector')} ({f('natural sum')} ({ntwo}) ({one})) {t('Complex')}"
checks.append(f"""
noncomputable def actualDependentProjectionHead (callback : {function_lean}) : {result_lean} := {value.lean}
noncomputable def expectedDependentProjectionHead (callback : {function_lean}) : {result_lean} := {expected}
same_basic_target actualDependentProjectionHead expectedDependentProjectionHead
theorem meaningDependentProjectionHead (callback : {function_lean}) : actualDependentProjectionHead callback = callback ({ntwo}) := by rfl
""")
notation('Notation make offset(n: Natural,x: Real): Function(k: Natural,Vector((k+n),Complex)):',
 ['Means: fun _ _ => (0 : Complex)','Render latex: map({n},{x})'],env)
value=Builder(env,scope).materialize(expression_tree(parse('make offset(n,0)(2)','expression')),use_default=False)
result_lean=f"{t('Vector')} ({f('natural sum')} ({ntwo}) n) {t('Complex')}"
expected=f"(@{f('make offset')} n ({nr} (nat_lit 0))) ({ntwo})"
checks.append(f"""
noncomputable def actualParameterizedHead (n : {t('Natural')}) : {result_lean} := {value.lean}
noncomputable def expectedParameterizedHead (n : {t('Natural')}) : {result_lean} := {expected}
same_basic_target actualParameterizedHead expectedParameterizedHead
theorem meaningParameterizedHead (n : {t('Natural')}) : actualParameterizedHead n = (fun _ => (0 : Complex)) := by rfl
""")
notation('Notation make constant(T: Type,item: T,x: Real): Function(k: Natural,Vector(k,T)):',
 ['Means: fun _ _ => item','Render latex: constant({item})'],env)
value=Builder(env,scope).materialize(expression_tree(parse('make constant(type(Real:Type),r,0)(2)','expression')),use_default=False)
result_lean=f"{t('Vector')} ({ntwo}) {t('Real')}"
expected=f"(@{f('make constant')} {t('Real')} r ({nr} (nat_lit 0))) ({ntwo})"
checks.append(f"""
noncomputable def actualParameterizedCarrier (r : {t('Real')}) : {result_lean} := {value.lean}
noncomputable def expectedParameterizedCarrier (r : {t('Real')}) : {result_lean} := {expected}
same_basic_target actualParameterizedCarrier expectedParameterizedCarrier
theorem meaningParameterizedCarrier (r : {t('Real')}) : actualParameterizedCarrier r = (fun _ => r) := by rfl
""")
notation('Notation nested maps(x: Real): Function(n: Natural,Function(k: Natural,Vector((n+k),Complex))):',
 ['Means: fun _ _ _ => (0 : Complex)','Render latex: nested({x})'],env)
value=Builder(env,scope).materialize(expression_tree(parse('nested maps(0)(2)(3)','expression')),use_default=False)
three=f"{nn} (nat_lit 3)"
result_lean=f"{t('Vector')} ({f('natural sum')} ({ntwo}) ({three})) {t('Complex')}"
expected=f"((@{f('nested maps')} ({nr} (nat_lit 0))) ({ntwo})) ({three})"
checks.append(f"""
noncomputable def actualDependentChain : {result_lean} := {value.lean}
noncomputable def expectedDependentChain : {result_lean} := {expected}
same_basic_target actualDependentChain expectedDependentChain
theorem meaningDependentChain : actualDependentChain = (fun _ => (0 : Complex)) := by rfl
""")
local_scope=dict(scope)
local_scope['callback']=Expr('callback','f',env.type('Function(j: Natural,Function(k: Natural,Vector((j+k),Complex)))',scope),tree=['Local','callback'])
value=Builder(env,local_scope).materialize(expression_tree(parse('callback(2)(3)','expression')),use_default=False)
function_lean=f"(j k : {t('Natural')}) → {t('Vector')} ({f('natural sum')} j k) {t('Complex')}"
expected=f"callback ({ntwo}) ({three})"
checks.append(f"""
noncomputable def actualLocalDependentChain (callback : {function_lean}) : {result_lean} := {value.lean}
noncomputable def expectedLocalDependentChain (callback : {function_lean}) : {result_lean} := {expected}
same_basic_target actualLocalDependentChain expectedLocalDependentChain
theorem meaningLocalDependentChain (callback : {function_lean}) : actualLocalDependentChain callback = {expected} := by rfl
""")
local_scope=dict(scope)
local_scope['callback']=Expr('callback','f',env.type('Function(j: Natural,Function(v: Vector(j,Complex),Function(k: Natural,Vector((j+k),Complex))))',scope),tree=['Local','callback'])
value=Builder(env,local_scope).materialize(expression_tree(parse('callback(2)(0)(3)','expression')),use_default=False)
function_lean=f"(j : {t('Natural')}) → {t('Vector')} j {t('Complex')} → (k : {t('Natural')}) → {t('Vector')} ({f('natural sum')} j k) {t('Complex')}"
expected=f"callback ({ntwo}) (@{f('complex vector zero')} ({ntwo})) ({three})"
checks.append(f"""
noncomputable def actualMixedDependentChain (callback : {function_lean}) : {result_lean} := {value.lean}
noncomputable def expectedMixedDependentChain (callback : {function_lean}) : {result_lean} := {expected}
same_basic_target actualMixedDependentChain expectedMixedDependentChain
theorem meaningMixedDependentChain (callback : {function_lean}) : actualMixedDependentChain callback = {expected} := by rfl
""")
from binder_types import CheckedBinderTypes
for i,(source,binders,expected) in enumerate([
 ('Function(k: Natural,Vector(k,Complex))','',f"(k : {t('Natural')}) → {t('Vector')} k {t('Complex')}"),
 ('Function(j: Natural,Function(k: Natural,Matrix(j,k,Complex)))','',f"(j k : {t('Natural')}) → {t('Matrix')} j k {t('Complex')}"),
 ('Function(k: Natural,Function(Vector(k,Complex),Real))','',f"(k : {t('Natural')}) → ({t('Vector')} k {t('Complex')}) → {t('Real')}"),
 ('Function(k: Natural,Matrix(k,n,Complex))',f"(n : {t('Natural')})",f"(k : {t('Natural')}) → {t('Matrix')} k n {t('Complex')}"),
 ('Function(k: Natural,Matrix(k,(n+1),Complex))',f"(n : {t('Natural')})",f"(k : {t('Natural')}) → {t('Matrix')} k ({f('natural sum')} n ({one})) {t('Complex')}")]):
 codec=CheckedBinderTypes(env,scope)
 original=env.type(source,scope)
 reconstructed=codec.decode(codec.encode(original))
 actual=env.render_type(reconstructed,'lean',scope)
 args=' n' if binders else ''
 checks.append(f"""
def actualBinderType{i} {binders} : Type := {actual}
def expectedBinderType{i} {binders} : Type := {expected}
same_basic_target actualBinderType{i} expectedBinderType{i}
theorem meaningBinderType{i} {binders} : actualBinderType{i}{args} = expectedBinderType{i}{args} := by rfl
""")
codec=CheckedBinderTypes(env,scope)
encoded=codec.encode(env.type('Function(k: Natural,Vector(k,Complex))',scope))
result=codec.apply(encoded,scope['n'])
checks.append(f"""
def actualInstantiatedBinderType (n : {t('Natural')}) : Type := {env.render_type(result,'lean',scope)}
def expectedInstantiatedBinderType (n : {t('Natural')}) : Type := {t('Vector')} n {t('Complex')}
same_basic_target actualInstantiatedBinderType expectedInstantiatedBinderType
theorem meaningInstantiatedBinderType (n : {t('Natural')}) : actualInstantiatedBinderType n = expectedInstantiatedBinderType n := by rfl
""")
declare('Structure SizedPayload():',['Let size: Natural','Constructor: sized payload'],env)
record=env.structures['SizedPayload']['key']
notation('Notation binder count(item):',['Let T: Type','Let item: T','Returns: Natural','Means: 0','Render latex: count({item})'],env)
notation('Define binder ignore(k: Natural): Natural:', ['Equals: (0:Natural)','Render latex: ignore({k})'],env,authored=True)
for i,(source,expected) in enumerate([
 ('Function(k: Natural,Vector((k+1),Complex))',f"(k : {t('Natural')}) → {t('Vector')} ({f('natural sum')} k ({one})) {t('Complex')}"),
 ('Function(j: Natural,Function(k: Natural,Vector((j+k),Complex)))',f"(j k : {t('Natural')}) → {t('Vector')} ({f('natural sum')} j k) {t('Complex')}"),
 ('Function(f: Function(Natural,Natural),Function(k: Natural,Vector((f(k)),Complex)))',f"(f : {t('Natural')} → {t('Natural')}) → (k : {t('Natural')}) → {t('Vector')} (f k) {t('Complex')}"),
 ('Function(p: SizedPayload,Vector((p.size),Complex))',f"(p : {record}) → {t('Vector')} (@{record}.size p) {t('Complex')}"),
 ('Function(k: Natural,Matrix(k,(binder count(k)),Complex))',f"(k : {t('Natural')}) → {t('Matrix')} k (@{f('binder count')} {t('Natural')} k) {t('Complex')}"),
 ('Function(k: Natural,Matrix(k,(binder ignore(k)),Complex))',f"(k : {t('Natural')}) → {t('Matrix')} k (@{f('binder ignore')} k) {t('Complex')}")]):
 codec=CheckedBinderTypes(env,scope)
 typ=env.type(source,scope)
 reconstructed=codec.decode(codec.encode(typ))
 checks.append(f"""
def actualComputedBinderType{i} : Type := {env.render_type(reconstructed,'lean',scope)}
def expectedComputedBinderType{i} : Type := {expected}
same_basic_target actualComputedBinderType{i} expectedComputedBinderType{i}
theorem meaningComputedBinderType{i} : actualComputedBinderType{i} = expectedComputedBinderType{i} := by rfl
""")
codec=CheckedBinderTypes(env,scope)
encoded=codec.encode(env.type('Function(k: Natural,Vector((k+1),Complex))',scope))
result=codec.apply(encoded,scope['n'])
checks.append(f"""
def actualComputedInstantiation (n : {t('Natural')}) : Type := {env.render_type(result,'lean',scope)}
def expectedComputedInstantiation (n : {t('Natural')}) : Type := {t('Vector')} ({f('natural sum')} n ({one})) {t('Complex')}
same_basic_target actualComputedInstantiation expectedComputedInstantiation
theorem meaningComputedInstantiation (n : {t('Natural')}) : actualComputedInstantiation n = expectedComputedInstantiation n := by rfl
""")
notation('Notation binder carrier count(T: Type): Natural:', ['Means: 0','Render latex: count({T})'],env)
codec=CheckedBinderTypes(env,scope)
encoded=codec.encode(env.type('Function(k: Natural,Vector((binder carrier count(type(Vector(k,Complex):Type))),Complex))',scope))
for name,parameters,actual,expected in [
 ('BoundCarrierValue','',codec.decode(encoded),f"(k : {t('Natural')}) → {t('Vector')} (@{f('binder carrier count')} ({t('Vector')} k {t('Complex')})) {t('Complex')}"),
 ('InstantiatedCarrierValue',f"(n : {t('Natural')})",codec.apply(encoded,scope['n']),f"{t('Vector')} (@{f('binder carrier count')} ({t('Vector')} n {t('Complex')})) {t('Complex')}")]:
 checks.append(f"""
def actual{name} {parameters} : Type := {env.render_type(actual,'lean',scope)}
def expected{name} {parameters} : Type := {expected}
same_basic_target actual{name} expected{name}
theorem meaning{name} {parameters} : actual{name}{' n' if parameters else ''} = expected{name}{' n' if parameters else ''} := by rfl
""")
notation('Notation binder vector count(x):',['Let n: Natural','Let x: Vector(n,Complex)','Returns: Natural','Means: 0','Render latex: count({x})'],env)
codec=CheckedBinderTypes(env,scope)
encoded=codec.encode(env.type('Function(k: Natural,Vector((binder vector count((0:Vector(k,Complex)))),Complex))',scope))
for name,parameters,actual,expected in [
 ('BoundVectorLiteral','',codec.decode(encoded),f"(k : {t('Natural')}) → {t('Vector')} (@{f('binder vector count')} k ({f('complex vector zero')} k)) {t('Complex')}"),
 ('InstantiatedVectorLiteral',f"(n : {t('Natural')})",codec.apply(encoded,scope['n']),f"{t('Vector')} (@{f('binder vector count')} n ({f('complex vector zero')} n)) {t('Complex')}")]:
 checks.append(f"""
noncomputable def actual{name} {parameters} : Type := {env.render_type(actual,'lean',scope)}
noncomputable def expected{name} {parameters} : Type := {expected}
same_basic_target actual{name} expected{name}
theorem meaning{name} {parameters} : actual{name}{' n' if parameters else ''} = expected{name}{' n' if parameters else ''} := by rfl
""")
from constraint_model import Variable,unify,resolve
formal_scope={**scope,'T':Expr('T','T',env.type('Type'),tree=['Local','T'])}
for name,left_source,right_source,formals,expected in [
 ('RecoveredBinderCarrier','Function(k: Natural,Vector(k,T))','Function(j: Natural,Vector(j,Complex))',{'T':Variable('outer T','type')},f"(k : {t('Natural')}) → {t('Vector')} k {t('Complex')}"),
 ('RecoveredBinderIndex','Function(k: Natural,Matrix(k,n,Complex))','Function(j: Natural,Matrix(j,1,Complex))',{'n':Variable('outer n','index')},f"(k : {t('Natural')}) → {t('Matrix')} k ({one}) {t('Complex')}")]:
 codec=CheckedBinderTypes(env,formal_scope)
 left=codec.encode(env.type(left_source,formal_scope),formals)
 right=codec.encode(env.type(right_source,formal_scope))
 bindings=unify([(left,right)])
 actual=codec.decode(resolve(left,bindings))
 checks.append(f"""
def actual{name} : Type := {env.render_type(actual,'lean',formal_scope)}
def expected{name} : Type := {expected}
same_basic_target actual{name} expected{name}
theorem meaning{name} : actual{name} = expected{name} := by rfl
""")
notation('Notation read binder family(f,x):',
 ['Let T: Type','Let f: Function(k: Natural,Vector(k,T))','Let x: T','Returns: T',
  'Means: x','Render latex: read({f},{x})'],env)
family_type=env.type('Function(j: Natural,Vector(j,Complex))',scope)
family_scope={**scope,'family':Expr('family','family',family_type,tree=['Local','family'])}
value=Builder(env,family_scope).materialize(expression_tree(parse('read binder family(family,0)','expression')),use_default=False)
complex_numerals=env.data['types']['Complex']['numerals']['native_binding']
checks.append(f"""
noncomputable def actualRecoveredFamily (family : (k : {t('Natural')}) → {t('Vector')} k {t('Complex')}) : {t('Complex')} := {value.lean}
noncomputable def expectedRecoveredFamily (family : (k : {t('Natural')}) → {t('Vector')} k {t('Complex')}) : {t('Complex')} :=
  @{f('read binder family')} {t('Complex')} family ({complex_numerals} (nat_lit 0))
same_basic_target actualRecoveredFamily expectedRecoveredFamily
theorem meaningRecoveredFamily (family : (k : {t('Natural')}) → {t('Vector')} k {t('Complex')}) : actualRecoveredFamily family = (0 : Complex) := by simp [actualRecoveredFamily, {f('read binder family')}, {complex_numerals}]
""")
notation('Notation read binder width(f,x):',
 ['Let width: Natural','Let f: Function(k: Natural,Matrix(k,width,Complex))','Let x: Real','Returns: Real',
  'Means: x','Render latex: read({f},{x})'],env)
notation('Notation inspect binder carrier(f,x):',
 ['Let T: Type','Let f: Function(k: Natural,Vector(k,T))','Let x: Real','Returns: Real',
  'Means: x','Render latex: inspect({f},{x})'],env)
for name,call,parameter,formal_type,argument in [
 ('CallerWidth','read binder width',f"(n : {t('Natural')})",'Function(k: Natural,Matrix(k,n,Complex))','n'),
 ('CallerCarrier','inspect binder carrier',f"(U : {t('Type')})",'Function(k: Natural,Vector(k,U))','U')]:
 caller_scope={**scope,'U':Expr('U','U',env.type('Type'),tree=['Local','U'])}
 family_type=env.type(formal_type,caller_scope)
 caller_scope['family']=Expr('family','family',family_type,tree=['Local','family'])
 value=Builder(env,caller_scope).materialize(expression_tree(parse(call+'(family,0)','expression')),use_default=False)
 family_native=(f"(k : {t('Natural')}) → {t('Matrix')} k n {t('Complex')}" if name=='CallerWidth' else
                f"(k : {t('Natural')}) → {t('Vector')} k U")
 checks.append(f"""
noncomputable def actual{name} {parameter} (family : {family_native}) : {t('Real')} := {value.lean}
noncomputable def expected{name} {parameter} (family : {family_native}) : {t('Real')} := @{f(call)} {argument} family ({nr} (nat_lit 0))
same_basic_target actual{name} expected{name}
theorem meaning{name} {parameter} (family : {family_native}) : actual{name} {argument} family = (0 : Real) := by simp [actual{name}, {f(call)}, {nr}]
""")
notation('Notation make binder family(x: Real): Function(k: Natural,Vector(k,Complex)):',
 ['Means: fun _ _ => (0 : Complex)','Render latex: family({x})'],env)
value=Builder(env,scope).materialize(expression_tree(parse('read binder family(make binder family(0),0)','expression')),use_default=False)
checks.append(f"""
noncomputable def actualProducedFamily : {t('Complex')} := {value.lean}
noncomputable def expectedProducedFamily : {t('Complex')} := @{f('read binder family')} {t('Complex')}
  ({f('make binder family')} ({nr} (nat_lit 0))) ({complex_numerals} (nat_lit 0))
same_basic_target actualProducedFamily expectedProducedFamily
theorem meaningProducedFamily : actualProducedFamily = (0 : Complex) := by simp [actualProducedFamily, {f('read binder family')}, {complex_numerals}]
""")
source='for every (z: Vector(n,Complex), z != 0)'
value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
checks.append(f"""
def actualQuantifiedZero (n : {t('Natural')}) : Prop := {value.lean}
def expectedQuantifiedZero (n : {t('Natural')}) : Prop :=
  ∀ z : {vec}, @{f('unequal')} ({vec}) z (@{f('complex vector zero')} n)
same_basic_target actualQuantifiedZero expectedQuantifiedZero
theorem meaningQuantifiedZero (n : {t('Natural')}) :
  actualQuantifiedZero n ↔ ∀ z : Fin n → Complex, z ≠ (fun _ => 0) := by rfl
""")
source='for every (k: Natural, there exists (z: Vector(k,Complex), z = 0))'
value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
checks.append(f"""
def actualBoundDimension : Prop := {value.lean}
def expectedBoundDimension : Prop :=
  ∀ k : {t('Natural')}, @Exists ({t('Vector')} k {t('Complex')})
    (fun z => @{f('equal')} ({t('Vector')} k {t('Complex')}) z (@{f('complex vector zero')} k))
same_basic_target actualBoundDimension expectedBoundDimension
theorem meaningBoundDimension : actualBoundDimension := by
  intro k
  exact ⟨_, rfl⟩
""")
source='function (k: Natural, 0)'
expected_type=env.type('Function(j: Natural,Vector(j,Complex))',scope)
value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),expected_type,use_default=False)
checks.append(f"""
noncomputable def actualDependentLambda : (k : {t('Natural')}) → {t('Vector')} k {t('Complex')} := {value.lean}
noncomputable def expectedDependentLambda : (k : {t('Natural')}) → {t('Vector')} k {t('Complex')} :=
  fun k => @{f('complex vector zero')} k
same_basic_target actualDependentLambda expectedDependentLambda
theorem meaningDependentLambda (k : {t('Natural')}) : actualDependentLambda k = (fun _ => (0 : Complex)) := by rfl
""")
notation('Notation opaque count(item):',
 ['Let T: Type','Let item: T','Returns: Natural','Means: 0','Render latex: count({item})'],env)
source='for every (T: Type, for every (item: T, opaque count(item) = 0))'
value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
checks.append(f"""
def actualScopedCarrier : Prop := {value.lean}
def expectedScopedCarrier : Prop :=
  ∀ T : {t('Type')}, ∀ item : T, @{f('equal')} {t('Natural')} (@{f('opaque count')} T item) ({nn} (nat_lit 0))
same_basic_target actualScopedCarrier expectedScopedCarrier
theorem meaningScopedCarrier : actualScopedCarrier := by
  intro T item
  rfl
""")
path=HERE/'JointTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Ninety-four experimental targets and ninety-four meaning proofs passed; production joint inference remains unimplemented.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
