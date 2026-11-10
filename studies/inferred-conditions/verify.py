# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Reproduce the condition-inference experiment without changing production files."""
from pathlib import Path
import io,os,subprocess,sys,tarfile,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='5525280d571a63e2fd122f627ed069878b51703a'
with tempfile.TemporaryDirectory(prefix='clean-condition-study-') as directory:
 target=Path(directory)
 archive=subprocess.check_output(['git','archive','--format=tar',BASE],cwd=ROOT)
 with tarfile.open(fileobj=io.BytesIO(archive),mode='r:') as tree:
  tree.extractall(target)  # Fixed, trusted repository revision; caller owns the empty directory.
 (target/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=str(target/'tests')+os.pathsep+str(target)
 subprocess.run([sys.executable,'-m','unittest','test_inferred_conditions','test_inferred_values',
  'test_retained_conversion_scope','test_equivalence_names','test_callable_evidence','-v'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'tools/check_inferred_condition_targets.py'],cwd=target,env=env,check=True)
print('Isolated condition-inference checks passed; production integration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
