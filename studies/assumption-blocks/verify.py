# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce the named-assumption block prototype on its pinned baseline."""
import os,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
BASE='8763d4689eb1aabbac58aa1de44208b072024d1b'
with tempfile.TemporaryDirectory(prefix='clean-assumption-block-study-') as directory:
 target=Path(directory);sys.path.insert(0,str(ROOT/'tools'))
 import study_checkout
 study_checkout.BASE_COMMIT=BASE;study_checkout.create_study_checkout(target,ROOT)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 subprocess.run([sys.executable,'tools/generate_parser.py'],cwd=target,check=True)
 env={**os.environ,'PYTHONPATH':os.pathsep.join([str(target/'studies/assumption-blocks'),str(target/'tests'),str(target)])}
 subprocess.run([sys.executable,'-m','unittest','test_blocks','test_generated_parser','test_layout','test_conditions','-v'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'studies/assumption-blocks/check_targets.py'],cwd=target,env=env,check=True)
print('Named-assumption block prototype checked in isolation; production integration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
