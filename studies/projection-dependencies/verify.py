# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check projection dependency closure independently of numeral-search changes."""
from pathlib import Path
import io,os,subprocess,sys,tarfile,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='e9760aa6eec7d2e8ba202af888ae0756cc9e13dd'
with tempfile.TemporaryDirectory(prefix='clean-projection-study-') as directory:
 target=Path(directory)
 archive=subprocess.check_output(['git','archive','--format=tar',BASE],cwd=ROOT)
 with tarfile.open(fileobj=io.BytesIO(archive),mode='r:') as tree:
  tree.extractall(target)  # Fixed trusted repository revision, owned empty directory.
 (target/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
 subprocess.run(['git','apply',str(Path(__file__).with_name('prototype.patch'))],cwd=target,check=True)
 env=os.environ.copy();env['PYTHONPATH']=str(target/'tests')+os.pathsep+str(target)
 subprocess.run([sys.executable,'-m','unittest','test_projection_dependencies','test_structures','test_binding_identity','-v'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'tools/check_projection_dependency_targets.py'],cwd=target,env=env,check=True)
print('Isolated projection dependency checks passed; production integration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
