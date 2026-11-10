# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Compose pending language patches on one fixed baseline and check interactions."""
import argparse,os,shutil,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
BASE='45cf68e49450dd14a343f1c569c3d97471828f70'
PATCHES=['literal-annotations/prototype.patch','literal-retention/prototype.patch',
         'bound-tree-codec/storage.patch','lazy-comparison-reservation/prototype.patch',
         'stable-comparison-arguments/prototype.patch','assumption-blocks/prototype.patch']
TESTS=['test_interactions','test_retention','test_codec','test_storage','test_reservation','test_stable_arguments','test_blocks',
 'test_generated_parser','test_numeral_pruning','test_compact_signatures','test_applied_indices',
 'test_hygienic_conversion','test_quantified_beta','test_structures','test_layout','test_conditions',
 'test_contextual_key_contract','test_contextual_family_comparison','test_retained_conversion_scope',
 'test_binding_identity','test_family_comparison','test_fresh_conditions','test_inferred_conditions',
 'test_inferred_conversion','test_inferred_values','test_scoped_family_keys',
 'test_exact_sequences','test_module_products','test_mayer_vietoris_maps']
SCRIPTS=[['studies/composed-language/check_interactions.py'],['studies/literal-retention/check_targets.py'],['studies/literal-retention/check_interfaces.py'],
 ['studies/bound-tree-codec/check_targets.py','--payload-only'],['tools/check_contextual_family_targets.py'],
 ['studies/choice/verify.py'],['studies/assumption-blocks/check_targets.py'],
 ['studies/topology/verify_exact_sequences.py'],['studies/topology/verify_module_products.py'],
 ['studies/topology/verify_mayer_vietoris_maps.py'],['verify_corpus.py']]

def prepare(target):
 sys.path.insert(0,str(ROOT/'tools'));import study_checkout
 study_checkout.BASE_COMMIT=BASE;study_checkout.create_study_checkout(target,ROOT)
 shutil.copy2(ROOT/'studies/bound-tree-codec/codec.py',target/'cleanlang/retained_codec.py')
 for name in PATCHES:
  print('Applying:',name,flush=True)
  subprocess.run(['git','apply',str(ROOT/'studies'/name)],cwd=target,check=True)

def verify(target,full=False):
 paths=[target/'studies'/name for name in ['composed-language','literal-retention','bound-tree-codec',
  'lazy-comparison-reservation','stable-comparison-arguments','assumption-blocks']]+[target/'tests',target]
 env={**os.environ,'PYTHONPATH':os.pathsep.join(map(str,paths))}
 print('Combined checkout:',target,flush=True)
 for args in [['tools/generate_parser.py'],['tools/generate_parser.py','--check']]:
  subprocess.run([sys.executable,*args],cwd=target,env=env,check=True)
 failures=[]
 for args in [['-m','unittest',*TESTS,'-v'],*SCRIPTS]:
  print('Checking:',args,flush=True)
  result=subprocess.run([sys.executable,*args],cwd=target,env=env)
  if result.returncode:failures.append((args,result.returncode))
 result=subprocess.run([os.environ.get('LAKE','lake'),'env','lean','generated/VerifiedCorpus.lean'],cwd=target,env=env)
 if result.returncode:failures.append((['lake','env','lean','generated/VerifiedCorpus.lean'],result.returncode))
 if full:
  args=['-m','unittest','discover','-s','tests','-v']
  result=subprocess.run([sys.executable,*args],cwd=target,env=env)
  if result.returncode:failures.append((args,result.returncode))
 if failures:
  print('Combined failures:',failures,flush=True);return 1
 print('Combined selected checks passed; production integration is not implied.',flush=True)
 return 0

if __name__=='__main__':
 parser=argparse.ArgumentParser();parser.add_argument('--directory',type=Path,help='Keep a new empty checkout for inspection')
 parser.add_argument('--full',action='store_true',help='Also run complete unittest discovery, without a timeout')
 options=parser.parse_args()
 if options.directory:
  target=options.directory.resolve();prepare(target);raise SystemExit(verify(target,options.full))
 with tempfile.TemporaryDirectory(prefix='clean-composed-language-') as directory:
  target=Path(directory);prepare(target);raise SystemExit(verify(target,options.full))

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
