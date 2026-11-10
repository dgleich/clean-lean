# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'ExplicitCarrierExample.clean',env)
assert results[0].conclusion.tree==['Operator','=', ['Call','retain small',[['Local','A'],['Local','x']]],['Local','x']]
assert results[1].conclusion.tree==['Call','equal in',[['Local','A'],['Call','retain large twice',[['Local','A'],['Local','x']]],['Local','x']]]
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
source=lean(results,env,['Lean'])
expected='''
namespace ExplicitCarrierOracle
noncomputable def small (A : Type) (x : A) : A := x
noncomputable def large (A : Type 1) (x : A) : A := x
noncomputable def twice (A : Type 1) (x : A) : A := KEEP_LARGE A (KEEP_LARGE A x)
noncomputable def equalIn (A : Type 1) (x y : A) : PROPOSITION := x = y
noncomputable def smallStatement : Prop := ∀ (A : SMALL) (x : A), EQ (KEEP_SMALL A x) x
noncomputable def largeStatement : Prop := ∀ (A : LARGE) (x : A), EQUAL_IN A (TWICE A x) x
end ExplicitCarrierOracle
'''
mapping={'KEEP_LARGE':f('retain large'),'KEEP_SMALL':f('retain small'),'TWICE':f('retain large twice'),'EQ':f('equal'),'EQUAL_IN':f('equal in'),'SMALL':t('SmallTypes'),'LARGE':t('LargeTypes'),'PROPOSITION':t('Proposition')}
for k,v in mapping.items():expected=re.sub(r'\b'+k+r'\b',v,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),oracle) for n,oracle in [('retain small','small'),('retain large','large'),('retain large twice','twice'),('equal in','equalIn')]]
pairs += [('CleanStatements.explicit_small_identity','smallStatement'),('CleanStatements.explicit_large_identity','largeStatement')]
source+=expected+comparison+'\n'.join('same_basic_target '+a+' ExplicitCarrierOracle.'+b for a,b in pairs)+'\n'
source+='theorem explicit_small_identity_proved : CleanStatements.explicit_small_identity := by\n  intro A x\n  rfl\n'
source+='theorem explicit_large_identity_proved : CleanStatements.explicit_large_identity := by\n  intro A x\n  rfl\n'
source+='\n-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
p=HERE/'ExplicitCarrierTargets.lean';p.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Two independent source trees, six exact explicit-carrier targets and two proofs passed.')
