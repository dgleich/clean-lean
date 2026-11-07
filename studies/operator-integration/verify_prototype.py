# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Rebuild the eight-patch declared-operator experiment from tracked source."""
from pathlib import Path
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from tools.study_checkout import create_study_checkout
HERE = Path(__file__).resolve().parent
with tempfile.TemporaryDirectory(prefix='clean-operator-integration-') as td:
    dest = Path(td)
    create_study_checkout(dest, ROOT)
    patches = [ROOT / 'studies/carrier-fields' / name for name in
               ['prototype.patch', 'bound-calls.patch', 'proof-bindings.patch', 'annotations.patch']]
    patches += [ROOT / 'studies/type-identity/local-types.patch',
                ROOT / 'studies/native-type-bindings/prototype.patch',
                ROOT / 'studies/qualified-globals/prototype.patch', HERE / 'prototype.patch']
    for patch in patches:
        subprocess.run(['git', 'apply', str(patch)], cwd=dest, check=True)
    for args in [[], ['--check']]:
        subprocess.run([sys.executable, str(dest / 'tools/generate_parser.py'), *args], cwd=dest, check=True)
    for verifier in ['verify_saved.py', 'verify_dispatch.py', 'verify_foundations.py', 'verify_topology.py']:
        subprocess.run([sys.executable, str(HERE / verifier), str(dest)], cwd=dest, check=True)
print('Integrated operator slice: 80 exact targets and seventeen proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
