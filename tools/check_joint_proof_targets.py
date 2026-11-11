# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent targets for checked evidence in the explicit joint solver."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from cleanlang.joint_inference import complete
env=Environment();load_module(ROOT/'library/linear_algebra.clean',env);load_module(ROOT/'library/logic/evidence.clean',env)
scope={'n':Expr('n','n',env.type('Natural'),tree=['Local','n'])}
scope['h']=Expr('h','h',env.type('Evidence((n=n))',scope),tree=['Local','h'])
notation('Notation self equality(n: Natural): Evidence((n=n)):', ['Means: rfl','Render latex: e({n})'],env)
notation('Notation keep evidence(n: Natural,h: Evidence((n=n)),z: Real): Natural:', ['Means: n','Render latex: k({n},{h},{z})'],env)
f=lambda name:env.data['functions'][name]['native_binding']
t=lambda name:env.data['types'][name]['native_binding']
num=lambda name:env.data['types'][name]['numerals']['native_binding']
realzero=f'{num("Real")} (nat_lit 0)';natone=f'{num("Natural")} (nat_lit 1)'
shift=f'{f("natural sum")} n ({natone})'
comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(node,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in node.targets))
checks=[]
value=complete(expression_tree(parse('keep evidence(n,h,0)','expression')),env,scope,use_default=False)
checks.append(f'''
noncomputable def actualEvidence (n : {t('Natural')}) (h : {f('equal')} n n) : {t('Natural')} := {value.lean}
noncomputable def expectedEvidence (n : {t('Natural')}) (h : {f('equal')} n n) : {t('Natural')} := {f('keep evidence')} n h ({realzero})
same_basic_target actualEvidence expectedEvidence
theorem evidenceMeaning (n : {t('Natural')}) (h : {f('equal')} n n) : actualEvidence n h = n := by rfl
''')
value=complete(expression_tree(parse('self equality(n+1)','expression')),env,scope,use_default=False)
checks.append(f'''
noncomputable def actualProof (n : {t('Natural')}) : {f('equal')} ({shift}) ({shift}) := {value.lean}
noncomputable def expectedProof (n : {t('Natural')}) : {f('equal')} ({shift}) ({shift}) := {f('self equality')} ({shift})
same_basic_target actualProof expectedProof
theorem proofMeaning (n : {t('Natural')}) : actualProof n = expectedProof n := by rfl
''')
value=complete(expression_tree(parse('for every(k: Natural,keep evidence(k,self equality(k),0)=k)','expression')),env,scope,use_default=False)
checks.append(f'''
def actualQuantifiedEvidence : Prop := {value.lean}
def expectedQuantifiedEvidence : Prop := ∀ (k : {t('Natural')}), {f('equal')} ({f('keep evidence')} k ({f('self equality')} k) ({realzero})) k
same_basic_target actualQuantifiedEvidence expectedQuantifiedEvidence
theorem quantifiedEvidenceMeaning : actualQuantifiedEvidence := by intro k; rfl
''')
# Independent universal/implication targets retain the supplied proof head.
eq=f'{f("equal")} n n'
function=f'({t("Real")} → {t("Real")})'
for suffix,condition,source,extra,expected_body in [
 ('Scoped', 'for every(f: Function(Real,Real),n=n)', 'h(function(x: Real,0))', '', f'h (fun (x : {t("Real")}) => {realzero})'),
 ('Implication', 'for every(f: Function(Real,Real),(n=n) → (n=n))', 'h(function(x: Real,0))(q)', f'(q : {eq})', f'h (fun (x : {t("Real")}) => {realzero}) q'),
]:
 scope['h']=Expr('h','h',env.type('Evidence(('+condition+'))',scope),tree=['Local','h'])
 scope['q']=Expr('q','q',env.type('Evidence((n=n))',scope),tree=['Local','q'])
 value=complete(expression_tree(parse(source,'expression')),env,scope,use_default=False)
 proof_type=f'∀ (_ : {function}), '+(f'({eq}) → ({eq})' if suffix=='Implication' else eq)
 args='n h q' if extra else 'n h'
 checks.append(f'''
noncomputable def actual{suffix} (n : {t('Natural')}) (h : {proof_type}) {extra} : {eq} := {value.lean}
noncomputable def expected{suffix} (n : {t('Natural')}) (h : {proof_type}) {extra} : {eq} := {expected_body}
same_basic_target actual{suffix} expected{suffix}
theorem meaning{suffix} (n : {t('Natural')}) (h : {proof_type}) {extra} : actual{suffix} {args} = expected{suffix} {args} := by rfl
''')
# A supplied proof expectation constrains the lambda body through its callable
# view; the lambda itself retains its ordinary function type and expression.
notation('Notation proof with scalar(n: Natural,h: Evidence((n=n)),z: Real): Evidence((n=n)):', ['Means: h','Render latex: p({n},{h},{z})'],env)
notation('Notation use universal(n: Natural,h: Evidence((for every(x: Real,n=n)))): Natural:', ['Means: n','Render latex: u({n},{h})'],env)
scope['h']=Expr('h','h',env.type('Evidence((n=n))',scope),tree=['Local','h'])
for suffix,source,expectation,result_type,expected_body in [
 ('ProofLambda','function(x: Real,proof with scalar(n,h,0))','Evidence((for every(x: Real,n=n)))',f'{t("Real")} → {eq}',f'fun (x : {t("Real")}) => {f("proof with scalar")} n h ({realzero})'),
 ('ProofConsumer','use universal(n,function(x: Real,proof with scalar(n,h,0)))',None,t('Natural'),f'{f("use universal")} n (fun (x : {t("Real")}) => {f("proof with scalar")} n h ({realzero}))'),
 ('DependentProofLambda','function(j: Natural,proof with scalar(j,self equality(j),0))','Evidence((for every(k: Natural,k=k)))',f'∀ (j : {t("Natural")}), {f("equal")} j j',f'fun (j : {t("Natural")}) => {f("proof with scalar")} j ({f("self equality")} j) ({realzero})'),
 ('ImplicationLambda','function(premise: Evidence((n=n)),proof with scalar(n,premise,0))','Evidence(((n=n) → (n=n)))',f'({eq}) → ({eq})',f'fun (q : {eq}) => {f("proof with scalar")} n q ({realzero})'),
]:
 expected=env.type(expectation,scope) if expectation else None
 value=complete(expression_tree(parse(source,'expression')),env,scope,expected,use_default=False)
 checks.append(f'''
noncomputable def actual{suffix} (n : {t('Natural')}) (h : {eq}) : {env.render_type(value.type,'lean',scope)} := {value.lean}
noncomputable def expected{suffix} (n : {t('Natural')}) (h : {eq}) : {result_type} := {expected_body}
same_basic_target actual{suffix} expected{suffix}
theorem meaning{suffix} (n : {t('Natural')}) (h : {eq}) : actual{suffix} n h = expected{suffix} n h := by rfl
''')
notation('Notation implicit universal(n,p):',['Let T: Type','Let n: Natural','Let p: Evidence((for every(x: T,n=n)))','Returns: Natural','Means: n','Render latex: u({n},{p})'],env)
notation('Notation indexed universal(p):',['Let m: Natural','Let p: Evidence((for every(x: Vector(m,Complex),m=m)))','Returns: Natural','Means: m','Render latex: u({p})'],env)
for suffix,source,expected_body in [
 ('ImplicitProofDomain','implicit universal(n,function(y: Real,proof with scalar(n,h,0)))',f'@{f("implicit universal")} {t("Real")} n (fun (y : {t("Real")}) => {f("proof with scalar")} n h ({realzero}))'),
 ('IndexedProofDomain','indexed universal(function(y: Vector(n,Complex),proof with scalar(n,h,0)))',f'@{f("indexed universal")} n (fun (y : {t("Vector")} n {t("Complex")}) => {f("proof with scalar")} n h ({realzero}))'),
]:
 value=complete(expression_tree(parse(source,'expression')),env,scope,use_default=False)
 checks.append(f'''
noncomputable def actual{suffix} (n : {t('Natural')}) (h : {eq}) : {t('Natural')} := {value.lean}
noncomputable def expected{suffix} (n : {t('Natural')}) (h : {eq}) : {t('Natural')} := {expected_body}
same_basic_target actual{suffix} expected{suffix}
theorem meaning{suffix} (n : {t('Natural')}) (h : {eq}) : actual{suffix} n h = n := by rfl
''')
# Value-dependent scoped prefixes: actual result types come from Clean; each
# expected type and body below is independently written with explicit wrappers.
notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],env)
notation('Notation evaluate vector(k: Natural,f: Function(Real,Vector(k,Complex))): Vector(k,Complex):', ['Means: f 0','Render latex: e({k},{f})'],env)
notation('Notation vector maker(k: Natural,f: Function(Real,Real)): Function(Real,Vector(k,Complex)):', ['Means: fun _ _ => 0','Render latex: v({k},{f})'],env)
nattwo=f'{num("Natural")} (nat_lit 2)'
three=f'{f("natural sum")} ({nattwo}) ({natone})'
for suffix,source,index,expected_body in [
 ('DirectPrefix','(function(k: Natural,indexed zero(k,0)))(2)',nattwo,f'(fun (k : {t("Natural")}) => {f("indexed zero")} k ({realzero})) ({nattwo})'),
 ('ModulePrefix','evaluate vector(2,function(x: Real,0))',nattwo,f'{f("evaluate vector")} ({nattwo}) (fun (x : {t("Real")}) => @{f("complex vector zero")} ({nattwo}))'),
 ('ComputedPrefix','evaluate vector(2+1,function(x: Real,0))',three,f'{f("evaluate vector")} ({three}) (fun (x : {t("Real")}) => @{f("complex vector zero")} ({three}))'),
 ('AppliedPrefix','vector maker(2,function(x: Real,0))(0)',nattwo,f'{f("vector maker")} ({nattwo}) (fun (x : {t("Real")}) => {realzero}) ({realzero})'),
]:
 value=complete(expression_tree(parse(source,'expression')),env,{},use_default=False)
 checks.append(f'''
noncomputable def actual{suffix} : {env.render_type(value.type,'lean',{})} := {value.lean}
noncomputable def expected{suffix} : {t('Vector')} ({index}) {t('Complex')} := {expected_body}
same_basic_target actual{suffix} expected{suffix}
theorem meaning{suffix} : actual{suffix} = expected{suffix} := by rfl
''')
proof_scope={'r':Expr('r','r',env.type('Real'),tree=['Local','r'])}
proof_scope['h']=Expr('h','h',env.type('Evidence((for every(f: Function(Real,Real),f(r)=f(r))))',proof_scope),tree=['Local','h'])
value=complete(expression_tree(parse('h(function(x: Real,0))','expression')),env,proof_scope,use_default=False)
proof_head=f'∀ (f : {t("Real")} → {t("Real")}), {f("equal")} (f r) (f r)'
# Existing proof-index substitution beta-reduces the authored constant lambda.
application=f'({realzero})'
checks.append(f'''
noncomputable def actualDependentProof (r : {t('Real')}) (h : {proof_head}) : {env.render_type(value.type,'lean',proof_scope)} := {value.lean}
noncomputable def expectedDependentProof (r : {t('Real')}) (h : {proof_head}) : {f('equal')} {application} {application} := h (fun (x : {t('Real')}) => {realzero})
same_basic_target actualDependentProof expectedDependentProof
theorem meaningDependentProof (r : {t('Real')}) (h : {proof_head}) : actualDependentProof r h = expectedDependentProof r h := by rfl
''')
notation('Notation carry(p: Proposition,f: Function(Real,Real)): Evidence((p → p)):', ['Means: fun h => h','Render latex: c({p},{f})'],env)
value=complete(expression_tree(parse('carry(for every(x: Real,1=1),function(y: Real,0))','expression')),env,{})
predicate=f'(∀ (x : {t("Real")}), {f("equal")} ({natone}) ({natone}))'
checks.append(f'''
noncomputable def actualDefaultPrefix : {env.render_type(value.type,'lean',{})} := {value.lean}
noncomputable def expectedDefaultPrefix : {f('implication')} {predicate} {predicate} := {f('carry')} {predicate} (fun (y : {t('Real')}) => {realzero})
same_basic_target actualDefaultPrefix expectedDefaultPrefix
theorem meaningDefaultPrefix : actualDefaultPrefix = expectedDefaultPrefix := by rfl
''')
path=ROOT/'studies/parameterized-literals/ProofTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Seventeen exact evidence/prefix targets and seventeen interpretation proofs passed; general contextual recovery and production integration remain pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
