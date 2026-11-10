# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check authored exactness and its Mathlib bridge; no Mayer-Vietoris claim."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'ExactSequences.clean',env)
source=lean(results,env,['Lean']);(HERE/'ExactSequences.lean').write_text(source)
(HERE/'ExactSequences.tex').write_text(latex(results,env))
f=lambda name:env.data['functions'][name]['native_binding']
t=lambda name:env.data['types'][name]['native_binding']
mapping={key:t(name) for key,name in [('TYPE','Type'),('NAT','Natural'),('PROP','Proposition'),('FIELD','FieldStructure'),('MOD','CoefficientModule'),('MAP','ModuleMap'),('SUB','ModuleSubspace'),('ELEM','ModuleElement')]}
mapping.update({key:f(name) for key,name in [('KERNEL','module map kernel'),('ZERO','module zero element'),('RANGE','module map range'),('EQ','equal'),('PAIR','exact pair'),('SHORT','exact'),('AT','exact pair at'),('EXACT','exact sequence interior'),('ADD','natural sum'),('VALUE','module map value')]})
mapping['SEQ']=env.structures['ModuleSequence']['key'];mapping['NUM']=env.data['types']['Natural']['numerals']['native_binding']
oracles='''
namespace ExactSequenceOracle
noncomputable def kernel {K : Type} (field : FIELD K) (M N : MOD K field) (f : MAP K field M N) : SUB K field M :=
 LinearMap.ker (@ModuleCat.Hom.hom K field.toRing M N f)
noncomputable def zero {K : Type} (field : FIELD K) (M : MOD K field) : ELEM K field M := (0 : M.carrier)
def pair {K : Type} (field : FIELD K) (M N P : MOD K field) (f : MAP K field M N) (g : MAP K field N P) : PROP :=
 EQ (RANGE field M N f) (KERNEL field N P g)
def short {K : Type} {field : FIELD K} {M N P : MOD K field} (f : MAP K field M N) (g : MAP K field N P) : PROP :=
 PAIR field M N P f g
def atPosition {K : Type} (field : FIELD K) (S : SEQ K field) (n : NAT) : PROP :=
 PAIR field (S.object (ADD (ADD n (NUM (nat_lit 1))) (NUM (nat_lit 1))))
  (S.object (ADD n (NUM (nat_lit 1)))) (S.object n)
  (S.arrow (ADD n (NUM (nat_lit 1)))) (S.arrow n)
def sequence {K : Type} (field : FIELD K) (S : SEQ K field) : PROP := ∀ n : NAT, AT field S n
noncomputable def makeSequence (K : Type) (field : FIELD K)
 (object : NAT → MOD K field)
 (arrow : (n : NAT) → MAP K field (object (ADD n (NUM (nat_lit 1)))) (object n)) : SEQ K field :=
 @SEQ.mk K field object arrow
def vanishes : Prop := ∀ (K : TYPE) (field : FIELD K) (M N P : MOD K field)
 (f : MAP K field M N) (g : MAP K field N P) (x : ELEM K field M),
 SHORT f g → EQ (VALUE field N P g (VALUE field M N f x)) (ZERO field P)
def eachPosition : Prop := ∀ (K : TYPE) (field : FIELD K) (S : SEQ K field) (n : NAT),
 EXACT field S → AT field S n
end ExactSequenceOracle

theorem exactPairMathlibAgreement {K : Type} (field : FIELD K) (M N P : MOD K field)
 (f : MAP K field M N) (g : MAP K field N P) :
 PAIR field M N P f g ↔ Function.Exact f.hom g.hom := by
 change LinearMap.range f.hom = LinearMap.ker g.hom ↔ Function.Exact f.hom g.hom
 rw [LinearMap.exact_iff]
 exact eq_comm

theorem exactMapsVanish : CleanStatements.exact_maps_vanish_on_the_image := by
 intro K field M N P f g x h
 have he := (exactPairMathlibAgreement field M N P f g).mp h
 exact he.apply_apply_eq_zero x

theorem exactSequenceAtPosition : CleanStatements.exact_sequence_interior_at_each_position := by
 intro K field S n h
 exact h n
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(name),'ExactSequenceOracle.'+oracle) for name,oracle in [('module map kernel','kernel'),('module zero element','zero'),('exact pair','pair'),('exact','short'),('exact pair at','atPosition'),('exact sequence interior','sequence'),('module sequence','makeSequence')]]
pairs += [('CleanStatements.exact_maps_vanish_on_the_image','ExactSequenceOracle.vanishes'),('CleanStatements.exact_sequence_interior_at_each_position','ExactSequenceOracle.eachPosition')]
verified=source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n'
p=HERE/'ExactSequencesVerified.lean';p.write_text(verified)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Nine exact sequence targets, a Mathlib agreement proof and two statement proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
