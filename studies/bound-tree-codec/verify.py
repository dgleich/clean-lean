# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Pinned encoding experiment over the retained-literal stack."""
from pathlib import Path
import os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='9e1ba7e91a9dbc135fed3ad7564107137aa7e9ff'
with tempfile.TemporaryDirectory(prefix='clean-bound-codec-study-') as directory:
 target=Path(directory);sys.path.insert(0,str(ROOT/'tools'))
 import study_checkout
 study_checkout.BASE_COMMIT=BASE
 study_checkout.create_study_checkout(target,ROOT)
 for name in ['literal-annotations','literal-retention']:
  subprocess.run(['git','apply',str(ROOT/'studies'/name/'prototype.patch')],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=os.pathsep.join([str(target/'studies/bound-tree-codec'),str(target/'studies/literal-retention'),str(target)])
 for args in [['tools/generate_parser.py'],['tools/generate_parser.py','--check'],['-m','unittest','test_codec','test_retention','-v'],['studies/bound-tree-codec/check_targets.py']]:
  subprocess.run([sys.executable,*args],cwd=target,env=env,check=True)
print('Retained-value codec checks passed in isolation; index-storage integration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
