# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce the first annotated-literal prototype; production stays unchanged."""
from pathlib import Path
import os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='027659500545c3290457a62d96389137879cdc6d'
with tempfile.TemporaryDirectory(prefix='clean-literal-annotation-study-') as directory:
 target=Path(directory);sys.path.insert(0,str(ROOT/'tools'))
 import study_checkout
 study_checkout.BASE_COMMIT=BASE
 study_checkout.create_study_checkout(target,ROOT)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=os.pathsep.join([str(target/'studies/literal-annotations'),str(target/'tests'),str(target)])
 for args in [['tools/generate_parser.py'],['tools/generate_parser.py','--check'],
              ['-m','unittest','test_annotations','test_generated_parser','test_numeral_pruning','test_compact_signatures','test_applied_indices','-v'],
              ['studies/literal-annotations/check_targets.py']]:
  subprocess.run([sys.executable,*args],cwd=target,env=env,check=True)
print('Isolated typed-literal prototype checks passed; unannotated inference and full literal representation remain pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
