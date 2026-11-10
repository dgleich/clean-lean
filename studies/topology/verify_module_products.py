# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent native targets and proofs for binary coefficient-module products."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'ModuleProducts.clean',env)
source=lean(results,env,['Lean'])
(HERE/'ModuleProducts.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('MOD','CoefficientModule'),('MAP','ModuleMap')]}
mapping.update({k:f(n) for k,n in [('PRODUCT','module product'),('INL','left inclusion'),('SND','right projection'),('EXACT','exact'),('ONTO','onto')]})
oracles='''
namespace ModuleProductOracle
noncomputable def product {K : Type} (field : FIELD K) (M N : MOD K field) : MOD K field :=
 letI : Field K := field
 ModuleCat.of K (M.carrier × N.carrier)
noncomputable def inclusion {K : Type} (field : FIELD K) (M N : MOD K field) :
 MAP K field M (PRODUCT field M N) :=
 letI : Field K := field
 ModuleCat.ofHom (LinearMap.inl K M.carrier N.carrier)
noncomputable def projection {K : Type} (field : FIELD K) (M N : MOD K field) :
 MAP K field (PRODUCT field M N) N :=
 letI : Field K := field
 ModuleCat.ofHom (LinearMap.snd K M.carrier N.carrier)
def exactStatement : Prop := ∀ (K : TYPE) (field : FIELD K) (M N : MOD K field),
 EXACT (INL field M N) (SND field M N)
def ontoStatement : Prop := ∀ (K : TYPE) (field : FIELD K) (M N : MOD K field),
 ONTO (SND field M N)
end ModuleProductOracle

theorem productSequenceChecked : CleanStatements.binary_module_sequence_is_exact := by
 intro K field M N
 letI : Field K := field
 change LinearMap.range (LinearMap.inl K M.carrier N.carrier) =
   LinearMap.ker (LinearMap.snd K M.carrier N.carrier)
 ext x
 rcases x with ⟨x,y⟩
 simp [eq_comm]

theorem projectionOntoChecked : CleanStatements.right_projection_is_onto := by
 intro K field M N y
 exact ⟨(0,y), rfl⟩
'''
for k,v in mapping.items():oracles=re.sub(r'\b'+k+r'\b',v,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'ModuleProductOracle.'+o) for n,o in [('module product','product'),('left inclusion','inclusion'),('right projection','projection')]]
pairs += [('CleanStatements.binary_module_sequence_is_exact','ModuleProductOracle.exactStatement'),('CleanStatements.right_projection_is_onto','ModuleProductOracle.ontoStatement')]
p=HERE/'ModuleProductsVerified.lean';p.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Five independent exact targets and two module-product proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
