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
path=HERE/'JointTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Forty-six experimental joint-row targets and forty-six meaning proofs passed; production joint inference remains unimplemented.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
