# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Syntax, declaration metadata and native declarations; carrier elaboration is unimplemented."""
from pathlib import Path
import os,shutil,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='dde5d8ef4d76763b41d28c6c452f48c9129c6bdb'
with tempfile.TemporaryDirectory(prefix='clean-classifier-syntax-') as directory:
 target=Path(directory);sys.path.insert(0,str(ROOT/'tools'));import study_checkout
 study_checkout.BASE_COMMIT=BASE;study_checkout.create_study_checkout(target,ROOT)
 for patch in ('syntax.patch','metadata.patch'):
  subprocess.run(['git','apply',str(Path(__file__).with_name(patch))],cwd=target,check=True)
 env={**os.environ,'PYTHONPATH':os.pathsep.join([str(target/'studies/universe-classifiers'),str(target/'tests'),str(target)])}
 for args in [['tools/generate_parser.py'],['tools/generate_parser.py','--check'],['-m','unittest','test_syntax','test_metadata','test_generated_parser','test_type_expressions','test_closed_universes','test_universes','-v']]:
  subprocess.run([sys.executable,*args],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'studies/universe-classifiers/check_metadata_targets.py'],cwd=target,env=env,check=True)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean','studies/universe-classifiers/Targets.lean'],cwd=target,check=True)
 shutil.copy2(target/'studies/universe-classifiers/MetadataTargets.lean',Path(__file__).with_name('MetadataTargets.lean'))
print('Classifier syntax, declaration metadata and exact declaration targets passed; carrier elaboration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
