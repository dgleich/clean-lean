# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Gate the mathematical meaning of the native constant capture specimen.

This fails on the earlier compiler even though its generated statement compiles.
The stronger exact-target/body checks are in verify_bindings.py.
"""
from pathlib import Path
import os
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(Path(sys.argv[1]).resolve()))
from cleanlang.core import Environment, lean
from cleanlang.modules import load_document

env = Environment()
results = load_document(HERE / 'Statements.clean.proposed', env)
native = lean([results[0]], env, ['Lean']) + '''
def expected_mathematical_statement : Prop := ∀ (A : Type) (x : Real), x=x
'''
lake = os.environ.get('LAKE', '/home/claude/.elan/bin/lake')
with tempfile.TemporaryDirectory(prefix='clean-native-capture-') as td:
    path = Path(td) / 'Capture.lean'
    path.write_text(native)
    # A compilation error is not evidence of absence of capture.
    subprocess.run([lake, 'env', 'lean', str(path)], cwd=ROOT, check=True)
    path.write_text(native + '''
theorem capture_is_absent : CleanStatements.native_constant_retains_scope =
    expected_mathematical_statement := rfl
''')
    subprocess.run([lake, 'env', 'lean', str(path)], cwd=ROOT, check=True)
print('Native type capture is absent; mathematical statement retained')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
