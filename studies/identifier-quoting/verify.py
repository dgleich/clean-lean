# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'Keywords.clean',env)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
r=env.structures['Holder']['key']
expected=f'''
namespace IdentifierOracle
noncomputable def identity (x : {t('Real')}) : {t('Real')} := x
noncomputable def reflexive (x : {t('Real')}) : {t('Proposition')} := {f('equal')} x x
noncomputable def items (A : Type) : Type := List A
noncomputable def hold (A : Type) (x : A) : {r} A := @{r}.mk A x
noncomputable def objectStatement : Prop := ∀ (x : {t('Real')}), {f('reflexive keyword')} x
noncomputable def localStatement : Prop := ∀ (x : {t('Real')}),
  let y : {t('Real')} := {f('identity keyword')} x
  {f('equal')} y x
noncomputable def carrierStatement : Prop := ∀ (A : {t('Type')}) (x : A), {f('equal')} x x
noncomputable def constructorStatement : Prop := ∀ (x : {t('Real')}), {f('equal')} x x
noncomputable def dimensionStatement : Prop := ∀ (n : {t('Natural')}) (x : {t('Vector')} n {t('Real')}), {f('equal')} x x
end IdentifierOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
checks=f'''
same_basic_target {f('identity keyword')} IdentifierOracle.identity
same_basic_target {f('reflexive keyword')} IdentifierOracle.reflexive
same_basic_target {t('Items')} IdentifierOracle.items
same_basic_target {f('hold keyword')} IdentifierOracle.hold
same_basic_target CleanStatements.keyword_object IdentifierOracle.objectStatement
same_basic_target CleanStatements.keyword_local IdentifierOracle.localStatement
same_basic_target CleanStatements.keyword_carrier IdentifierOracle.carrierStatement
same_basic_target CleanStatements.keyword_constructor IdentifierOracle.constructorStatement
same_basic_target CleanStatements.keyword_dimension IdentifierOracle.dimensionStatement
'''
for name in ['keyword_object','keyword_local','keyword_carrier','keyword_constructor','keyword_dimension']:
 binders='A x' if name in ('keyword_carrier','keyword_dimension') else 'x'
 checks+=f'\ntheorem {name}_proved : CleanStatements.{name} := by\n  intro {binders}\n  rfl\n'
p=HERE/'Verified.lean';p.write_text(lean(results,env,['Lean'])+expected+comparison+checks)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Nine exact binder/reference targets and five keyword-binder proofs passed.')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
