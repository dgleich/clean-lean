# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Check the algebraic connecting map; no geometric Mayer–Vietoris claim."""
from pathlib import Path
import ast, os, re, subprocess, sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
HERE = Path(__file__).resolve().parent
env = Environment()
results = load_document(HERE / 'HomologySequence.clean', env)
source = lean(results, env, ['Lean'])
(HERE / 'HomologySequence.lean').write_text(source)
(HERE / 'HomologySequence.tex').write_text(latex(results, env))
f = lambda name: env.data['functions'][name]['native_binding']
t = lambda name: env.data['types'][name]['native_binding']
mapping = {key: t(name) for key, name in [
 ('TYPE','Type'), ('NAT','Natural'), ('FIELD','FieldStructure'),
 ('SEQ','ChainShortSequence'), ('CHAIN','ModuleChainComplex'),
 ('CHAINMAP','ChainMap'), ('MODMAP','ModuleMap'), ('PROP','Proposition')]}
functions = [('FIRST','sequence first chain'), ('MIDDLE','sequence middle chain'),
 ('LAST','sequence last chain'), ('F','sequence first chain map'),
 ('G','sequence last chain map'), ('MAKE','short chain sequence'),
 ('SHORT','short exact chain sequence'), ('DELTA','connecting homology map'),
 ('LEFT','connecting then first'), ('RIGHT','last then connecting'),
 ('HOMOLOGY','chain homology'), ('INDUCED','induced chain homology map'),
 ('COMP','module composition'), ('ZEROMAP','module zero map'),
 ('CHAINCOMP','compose chain maps'), ('CHAINZERO','zero chain map'),
 ('EQ','equal'), ('ADD','natural sum'), ('EXACT','exact'),
 ('HF','sequence first homology map'), ('HG','sequence last homology map')]
mapping.update({key: f(name) for key, name in functions})
mapping['NUM'] = env.data['types']['Natural']['numerals']['native_binding']
oracles = '''
namespace HomologySequenceOracle
noncomputable def sequence (K : Type) (field : FIELD K) : Type 1 :=
 (letI : Field K := field; CategoryTheory.ShortComplex (ChainComplex (ModuleCat.{0} K) ℕ))
noncomputable def first {K : Type} (field : FIELD K) (S : SEQ K field) : CHAIN K field :=
 (letI : Field K := field; S.X₁)
noncomputable def middle {K : Type} (field : FIELD K) (S : SEQ K field) : CHAIN K field :=
 (letI : Field K := field; S.X₂)
noncomputable def last {K : Type} (field : FIELD K) (S : SEQ K field) : CHAIN K field :=
 (letI : Field K := field; S.X₃)
noncomputable def firstMap {K : Type} (field : FIELD K) (S : SEQ K field) :
 CHAINMAP K field (FIRST field S) (MIDDLE field S) := (letI : Field K := field; S.f)
noncomputable def lastMap {K : Type} (field : FIELD K) (S : SEQ K field) :
 CHAINMAP K field (MIDDLE field S) (LAST field S) := (letI : Field K := field; S.g)
noncomputable def make {K : Type} (field : FIELD K) (A B C : CHAIN K field)
 (f : CHAINMAP K field A B) (g : CHAINMAP K field B C)
 (h : (EQ (CHAINCOMP field A B C g f) (CHAINZERO field A C))) : SEQ K field :=
 (letI : Field K := field; CategoryTheory.ShortComplex.mk f g h)
def short {K : Type} (field : FIELD K) (S : SEQ K field) : PROP :=
 (letI : Field K := field; S.ShortExact)
noncomputable def delta {K : Type} (field : FIELD K) (S : SEQ K field)
 (h : (SHORT field S)) (n : NAT) :
 MODMAP K field (HOMOLOGY field (LAST field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (FIRST field S) n) :=
 (letI : Field K := field; CategoryTheory.ShortComplex.ShortExact.δ h (n+1) n rfl)
noncomputable def left {K : Type} (field : FIELD K) (S : SEQ K field)
 (h : (SHORT field S)) (n : NAT) :
 MODMAP K field (HOMOLOGY field (LAST field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (MIDDLE field S) n) :=
 COMP field (HOMOLOGY field (LAST field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (FIRST field S) n) (HOMOLOGY field (MIDDLE field S) n)
 (DELTA field S h n) (INDUCED field (FIRST field S) (MIDDLE field S) (F field S) n)
noncomputable def right {K : Type} (field : FIELD K) (S : SEQ K field)
 (h : (SHORT field S)) (n : NAT) :
 MODMAP K field (HOMOLOGY field (MIDDLE field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (FIRST field S) n) :=
 COMP field (HOMOLOGY field (MIDDLE field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (LAST field S) (ADD n (NUM (nat_lit 1)))) (HOMOLOGY field (FIRST field S) n)
 (INDUCED field (MIDDLE field S) (LAST field S) (G field S) (ADD n (NUM (nat_lit 1))))
 (DELTA field S h n)
def leftVanishes : Prop := ∀ (K : TYPE) (field : FIELD K) (S : SEQ K field) (n : NAT),
 ∀ h : SHORT field S, EQ (LEFT field S h n)
 (ZEROMAP field (HOMOLOGY field (LAST field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (MIDDLE field S) n))
def rightVanishes : Prop := ∀ (K : TYPE) (field : FIELD K) (S : SEQ K field) (n : NAT),
 ∀ h : SHORT field S, EQ (RIGHT field S h n)
 (ZEROMAP field (HOMOLOGY field (MIDDLE field S) (ADD n (NUM (nat_lit 1))))
 (HOMOLOGY field (FIRST field S) n))
noncomputable def firstHomology {K : Type} (field : FIELD K) (S : SEQ K field) (n : NAT) :
 MODMAP K field (HOMOLOGY field (FIRST field S) n) (HOMOLOGY field (MIDDLE field S) n) :=
 INDUCED field (FIRST field S) (MIDDLE field S) (F field S) n
noncomputable def lastHomology {K : Type} (field : FIELD K) (S : SEQ K field) (n : NAT) :
 MODMAP K field (HOMOLOGY field (MIDDLE field S) n) (HOMOLOGY field (LAST field S) n) :=
 INDUCED field (MIDDLE field S) (LAST field S) (G field S) n
def exactFirst : Prop := ∀ (K : TYPE) (field : FIELD K) (S : SEQ K field) (n : NAT),
 ∀ h : SHORT field S, EXACT (DELTA field S h n) (HF field S n)
def exactMiddle : Prop := ∀ (K : TYPE) (field : FIELD K) (S : SEQ K field) (n : NAT),
 ∀ _h : SHORT field S, EXACT (HF field S n) (HG field S n)
def exactLast : Prop := ∀ (K : TYPE) (field : FIELD K) (S : SEQ K field) (n : NAT),
 ∀ h : SHORT field S, EXACT (HG field S (ADD n (NUM (nat_lit 1)))) (DELTA field S h n)
end HomologySequenceOracle

theorem connectingThenFirstChecked : CleanStatements.connecting_then_first_vanishes := by
 intro K field S n h
 letI : Field K := field
 exact CategoryTheory.ShortComplex.ShortExact.δ_comp (show S.ShortExact from h) (n+1) n rfl

theorem lastThenConnectingChecked : CleanStatements.last_then_connecting_vanishes := by
 intro K field S n h
 letI : Field K := field
 exact CategoryTheory.ShortComplex.ShortExact.comp_δ (show S.ShortExact from h) (n+1) n rfl

theorem homologyExactFirstChecked : CleanStatements.homology_exact_at_first := by
 intro K field S n h
 letI : Field K := field
 exact (CategoryTheory.ShortComplex.ShortExact.homology_exact₁
   (show S.ShortExact from h) (n+1) n rfl).moduleCat_range_eq_ker

theorem homologyExactMiddleChecked : CleanStatements.homology_exact_at_middle := by
 intro K field S n h
 letI : Field K := field
 exact (CategoryTheory.ShortComplex.ShortExact.homology_exact₂
   (show S.ShortExact from h) n).moduleCat_range_eq_ker

theorem homologyExactLastChecked : CleanStatements.homology_exact_at_last := by
 intro K field S n h
 letI : Field K := field
 exact (CategoryTheory.ShortComplex.ShortExact.homology_exact₃
   (show S.ShortExact from h) (n+1) n rfl).moduleCat_range_eq_ker
'''
for key, value in mapping.items():
 oracles = re.sub(r'\b' + key + r'\b', value, oracles)
comparison = next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and t.id == 'COMPARISON' for t in n.targets))
pairs = [(t('ChainShortSequence'), 'HomologySequenceOracle.sequence')]
pairs += [(f(name), 'HomologySequenceOracle.' + oracle) for name, oracle in [
 ('sequence first chain','first'), ('sequence middle chain','middle'), ('sequence last chain','last'),
 ('sequence first chain map','firstMap'), ('sequence last chain map','lastMap'),
 ('short chain sequence','make'), ('short exact chain sequence','short'),
 ('sequence first homology map','firstHomology'), ('sequence last homology map','lastHomology'),
 ('connecting homology map','delta'), ('connecting then first','left'), ('last then connecting','right')]]
pairs += [('CleanStatements.connecting_then_first_vanishes','HomologySequenceOracle.leftVanishes'),
 ('CleanStatements.last_then_connecting_vanishes','HomologySequenceOracle.rightVanishes')]
pairs += [('CleanStatements.homology_exact_at_' + name, 'HomologySequenceOracle.exact' + name.title()) for name in ['first','middle','last']]
verified = source + oracles + comparison + '\n'.join('same_basic_target '+a+' '+b for a,b in pairs) + '\n'
path = HERE / 'HomologySequenceVerified.lean'
path.write_text(verified)
subprocess.run([os.environ.get('LAKE','lake'), 'env', 'lean', str(path)], cwd=ROOT, check=True)
print('Eighteen canonical targets and five homology-sequence proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
