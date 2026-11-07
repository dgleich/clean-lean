# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Rebuild the seven-patch qualified-global experiment from tracked source."""
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
with tempfile.TemporaryDirectory(prefix='clean-qualified-globals-') as td:
    dest = Path(td)
    create_study_checkout(dest, ROOT)
    patches = [ROOT / 'studies/carrier-fields' / name for name in
               ['prototype.patch', 'bound-calls.patch', 'proof-bindings.patch', 'annotations.patch']]
    patches += [ROOT / 'studies/type-identity/local-types.patch',
                ROOT / 'studies/native-type-bindings/prototype.patch', HERE / 'prototype.patch']
    for patch in patches:
        subprocess.run(['git', 'apply', str(patch)], cwd=dest, check=True)
    for args in [[], ['--check']]:
        subprocess.run([sys.executable, str(dest / 'tools/generate_parser.py'), *args], cwd=dest, check=True)
    subprocess.run([sys.executable, str(HERE / 'verify_bindings.py'), str(dest)], cwd=dest, check=True)
    subprocess.run([sys.executable, str(dest / 'studies/carrier-fields/check_capture.py'), str(dest)],
                   cwd=dest, check=True)
    subprocess.run([sys.executable, str(dest / 'studies/native-type-bindings/verify_bindings.py'), str(dest)],
                   cwd=dest, check=True)
    env = dict(os.environ, PYTHONPATH=str(dest / 'tests'))
    subprocess.run([sys.executable, '-m', 'unittest',
        'test_type_expressions', 'test_structures', 'test_alias_descriptions', 'test_dependent_calls',
        'test_dependent_functions', 'test_dependent_type_syntax', 'test_callable_evidence',
        'test_scoped_family_keys', 'test_hygienic_conversion', 'test_inferred_conversion',
        'test_conditions', 'test_sequential_scope', 'test_quantified_beta', 'test_quantifiers',
        'test_proof_families', 'test_evidence', 'test_comparison_token_cache', 'test_bound_name_cache',
        '-v'], cwd=dest, env=env, check=True)
    subprocess.run([sys.executable, str(dest / 'verify_corpus.py')], cwd=dest, check=True)
    subprocess.run([os.environ.get('LAKE', '/home/claude/.elan/bin/lake'), 'env', 'lean',
                    str(dest / 'generated/VerifiedCorpus.lean')], cwd=dest, check=True)
print('Qualified globals: 23 exact targets, twelve proofs, 274 regressions and 92 corpus proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
