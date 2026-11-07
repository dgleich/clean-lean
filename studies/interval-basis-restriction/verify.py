# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Regenerate the Clean statement and check independent targets plus its proof."""
from pathlib import Path
import ast,os,re,runpy,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document,load_module

e=Environment();results=load_document(HERE/'Statements.clean',e)
(HERE/'Generated.lean').write_text(lean(results,e,['Lean']))
(HERE/'Statements.tex').write_text(latex(results,e))
print('Translated restricted-basis statement',flush=True)
# Extra foundations are used only by the proof, not the authored statement.
load_module(ROOT/'library/logic/subtype_restriction.clean',e)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
keys={k:f(v) for k,v in [('OLD','original active labels'),('NEW','restricted active labels'),('SUR','surviving interval labels'),('VECTOR','module basis vector'),('MAP','evaluate map'),('VALUE','element value')]}
keys['LABELS']=e.structures['IntervalLabels']['key']
expected=r'''
namespace RestrictedBasisOracle
-- Explicit coefficient instances are part of the expected target.
def statement : Prop := ∀ (K : Type) (field : Field K)
 (M : @ModuleCat.{0,0} K field.toRing) (I : Type) (n a m : ℕ)
 (bound : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1))
 (b : @Module.Basis {i : I // i ∈ OLD I n a m bound L v}
   K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (vectors : I → M.carrier)
 (realizes : ∀ x : {i : I // i ∈ OLD I n a m bound L v},
   VECTOR field M b x = MAP vectors (VALUE (OLD I n a m bound L v) x)),
 ∃ c : @Module.Basis
   {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v}
   K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule,
 ∀ y : {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v},
   VECTOR field M c y = MAP vectors (VALUE (SUR I n a m L) (VALUE (NEW I n a m L v) y))
end RestrictedBasisOracle
'''
for k,v in keys.items():expected=re.sub(r'\b'+k+r'\b',v,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
# Instantiate independently authored proof templates with current bindings.
# Generated names can differ with the binder-allocation context; never copy
# identifiers out of a different generated environment.
arithmetic=runpy.run_path(str(ROOT/'studies/active-labels/verify_arithmetic.py'))['render_arithmetic'](e)
module=ast.parse((HERE/'verify_native.py').read_text())
native=next(ast.literal_eval(n.value) for n in module.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='extra' for t in n.targets))
native_keys={**keys,'EVAL':f('equivalence forward')}
for k,v in native_keys.items():native=re.sub(r'\b'+k+r'\b',v,native)
s=lean(results,e,['Lean'])+'\n'+arithmetic+'\n'+native+'\n'+expected+comparison
s+='\nsame_basic_target '+keys['OLD']+' Arithmetic.old\n'
s+='same_basic_target '+keys['NEW']+' Arithmetic.new\n'
s+='same_basic_target CleanStatements.basis_at_a_restricted_vertex RestrictedBasisOracle.statement\n'
s+='''
theorem clean_restricted_basis_checked : CleanStatements.basis_at_a_restricted_vertex := by
 intro K field M I n a m bound L v b vectors realizes
 letI : Field K := field
 exact RestrictedBasis.exists_basis_at_restricted_vertex M I n a m bound L v b vectors realizes
'''
p=HERE/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Three exact targets and the generated Clean restricted-basis theorem proved',flush=True)

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
