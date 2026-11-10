# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce local numeral search and authored vertex order on a pinned checkout."""
from pathlib import Path
import argparse,io,os,subprocess,sys,tarfile,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='e9760aa6eec7d2e8ba202af888ae0756cc9e13dd'
parser=argparse.ArgumentParser();parser.add_argument('--active-labels',action='store_true');args=parser.parse_args()
with tempfile.TemporaryDirectory(prefix='clean-pruning-study-') as directory:
 target=Path(directory)
 archive=subprocess.check_output(['git','archive','--format=tar',BASE],cwd=ROOT)
 with tarfile.open(fileobj=io.BytesIO(archive),mode='r:') as tree:
  tree.extractall(target)  # Fixed trusted revision, into an owned empty directory.
 (target/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=str(target/'tests')+os.pathsep+str(target)
 subprocess.run([sys.executable,'-m','unittest','test_numeral_pruning','-v'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'tools/check_pruned_numeral_targets.py'],cwd=target,env=env,check=True)
 if args.active_labels:
  subprocess.run([sys.executable,'-m','unittest','test_active_labels','-v'],cwd=target,env=env,check=True)
print('Requested isolated checks passed; production integration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
