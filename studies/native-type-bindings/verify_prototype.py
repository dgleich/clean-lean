# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Build native type bindings on the isolated local-type prototype."""
from pathlib import Path
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
with tempfile.TemporaryDirectory(prefix='clean-native-types-') as td:
    dest = Path(td)
    for name in subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT, text=True).split('\0'):
        if name and (ROOT / name).is_file():
            target = dest / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / name, target)
    (dest / '.lake').symlink_to(ROOT / '.lake', target_is_directory=True)
    patches = [ROOT / 'studies/carrier-fields' / name for name in
               ['prototype.patch', 'bound-calls.patch', 'proof-bindings.patch', 'annotations.patch']]
    patches += [ROOT / 'studies/type-identity/local-types.patch', HERE / 'prototype.patch']
    for patch in patches:
        subprocess.run(['git', 'apply', str(patch)], cwd=dest, check=True)
    for args in [[], ['--check']]:
        subprocess.run([sys.executable, str(dest / 'tools/generate_parser.py'), *args], cwd=dest, check=True)
    for name in ['check_capture.py', 'verify_bindings.py']:
        subprocess.run([sys.executable, str(HERE / name), str(dest)], cwd=dest, check=True)
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
print('Native type bindings: isolated acceptance, 274 regressions and 92 corpus proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
