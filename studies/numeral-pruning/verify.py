# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce local numeral search and authored vertex order on a pinned checkout."""
from pathlib import Path
import argparse,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='e9760aa6eec7d2e8ba202af888ae0756cc9e13dd'
parser=argparse.ArgumentParser();parser.add_argument('--active-labels',action='store_true');args=parser.parse_args()
with tempfile.TemporaryDirectory(prefix='clean-pruning-study-') as directory:
 target=Path(directory)
 sys.path.insert(0,str(ROOT/'tools'))
 import study_checkout
 study_checkout.BASE_COMMIT=BASE
 study_checkout.create_study_checkout(target,ROOT)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=str(target/'tests')+os.pathsep+str(target)
 subprocess.run([sys.executable,'-m','unittest','test_numeral_pruning','-v'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'tools/check_pruned_numeral_targets.py'],cwd=target,env=env,check=True)
 if args.active_labels:
  subprocess.run([sys.executable,'-m','unittest','test_active_labels','-v'],cwd=target,env=env,check=True)
print('Requested historical checks passed; current production validation is separate.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
