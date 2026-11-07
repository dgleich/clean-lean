# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Rebuild the isolated local-type repair and run its bounded acceptance checks."""
from pathlib import Path
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
with tempfile.TemporaryDirectory(prefix='clean-local-types-') as td:
    dest = Path(td)
    for name in subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT, text=True).split('\0'):
        if name and (ROOT / name).is_file():
            target = dest / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / name, target)
    (dest / '.lake').symlink_to(ROOT / '.lake', target_is_directory=True)
    for patch in ['prototype.patch', 'bound-calls.patch', 'proof-bindings.patch', 'annotations.patch']:
        subprocess.run(['git', 'apply', str(ROOT / 'studies/carrier-fields' / patch)], cwd=dest, check=True)
    subprocess.run(['git', 'apply', str(HERE / 'local-types.patch')], cwd=dest, check=True)
    for args in [[], ['--check']]:
        subprocess.run([sys.executable, str(dest / 'tools/generate_parser.py'), *args], cwd=dest, check=True)
    subprocess.run([sys.executable, str(HERE / 'check_identity.py'), '--compiler', str(dest), '--native'],
                   cwd=dest, check=True)
    subprocess.run([sys.executable, str(HERE / 'check_preservation.py'), str(dest)], cwd=dest, check=True)
    # Run old drivers from the temporary copy so their generated artifacts stay local.
    for name in ['check_capture.py', 'verify_annotations.py', 'verify_proof_bindings.py', 'verify_prototype.py']:
        subprocess.run([sys.executable, str(dest / 'studies/carrier-fields' / name), str(dest)],
                       cwd=dest, check=True)
    env = dict(os.environ, PYTHONPATH=str(dest / 'tests'))
    subprocess.run([sys.executable, '-m', 'unittest', 'test_quantified_beta', 'test_quantifiers',
                    'test_proof_families', 'test_evidence', 'test_comparison_token_cache',
                    'test_bound_name_cache', '-v'], cwd=dest, env=env, check=True)
print('Local-type prototype acceptance completed; main integration and operator composition remain pending')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
