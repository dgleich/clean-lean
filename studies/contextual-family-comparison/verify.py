# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce the contextual-key experiment without changing the working compiler."""
from pathlib import Path
import os,shutil,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='47a7452043ae9fc506ece3fd6d0c8dbc49085189'
with tempfile.TemporaryDirectory(prefix='clean-contextual-study-') as directory:
 target=Path(directory)
 sys.path.insert(0,str(ROOT/'tools'))
 import study_checkout
 study_checkout.BASE_COMMIT=BASE
 study_checkout.create_study_checkout(target,ROOT)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 shutil.copy2(Path(__file__).with_name('test_contract.py'),target/'tests/test_contextual_key_contract.py')
 env=os.environ.copy();env['PYTHONPATH']=str(target/'tests')+os.pathsep+str(target)
 names=['test_contextual_key_contract','test_contextual_family_comparison','test_quantified_beta','test_applied_indices',
        'test_retained_conversion_scope','test_binding_identity','test_family_comparison',
        'test_fresh_conditions','test_inferred_conditions','test_inferred_conversion',
        'test_inferred_values','test_scoped_family_keys']
 subprocess.run([sys.executable,'-m','unittest',*names,'-v'],cwd=target,env=env,check=True)
 for script in ['tools/check_contextual_family_targets.py','studies/choice/verify.py']:
  subprocess.run([sys.executable,script],cwd=target,env=env,check=True)
print('Pinned contextual-key experiment passed; working compiler still has the recorded comparison failures.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
