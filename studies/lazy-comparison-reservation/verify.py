# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce delayed reservation without changing the working compiler."""
from pathlib import Path
import os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='61e83d6e0486fe845a36fa300ac89bb3b2e6063c'
with tempfile.TemporaryDirectory(prefix='clean-lazy-reservation-study-') as directory:
 target=Path(directory);sys.path.insert(0,str(ROOT/'tools'))
 import study_checkout
 study_checkout.BASE_COMMIT=BASE
 study_checkout.create_study_checkout(target,ROOT)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=os.pathsep.join([str(target/'studies/lazy-comparison-reservation'),str(target/'tests'),str(target)])
 names=['test_reservation','test_contextual_key_contract','test_contextual_family_comparison','test_quantified_beta','test_applied_indices','test_retained_conversion_scope','test_binding_identity','test_family_comparison','test_fresh_conditions','test_inferred_conditions','test_inferred_conversion','test_inferred_values','test_scoped_family_keys']
 subprocess.run([sys.executable,'-m','unittest',*names,'-v'],cwd=target,env=env,check=True)
 for script in ['tools/check_contextual_family_targets.py','studies/choice/verify.py']:
  subprocess.run([sys.executable,script],cwd=target,env=env,check=True)
print('Lazy reservation checks passed in isolation; full-suite cost remains unverified.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
