# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Reconstruct the numeral parser step on the pinned declared-operator stack."""
from pathlib import Path
import subprocess
import sys
import tempfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from tools.study_checkout import create_study_checkout
HERE=Path(__file__).resolve().parent
with tempfile.TemporaryDirectory(prefix='clean-numeral-parser-') as td:
    dest=Path(td)
    create_study_checkout(dest,ROOT)
    patches=[ROOT/'studies/carrier-fields'/n for n in
             ['prototype.patch','bound-calls.patch','proof-bindings.patch','annotations.patch']]
    patches += [ROOT/'studies/type-identity/local-types.patch',
                ROOT/'studies/native-type-bindings/prototype.patch',
                ROOT/'studies/qualified-globals/prototype.patch',
                ROOT/'studies/operator-integration/prototype.patch',HERE/'parser.patch']
    for patch in patches:subprocess.run(['git','apply',str(patch)],cwd=dest,check=True)
    for args in [[],['--check']]:
        subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
    subprocess.run([sys.executable,str(HERE/'verify_parser.py'),str(dest),'-v'],cwd=dest,check=True)
    subprocess.run([sys.executable,'-m','unittest','discover','-s','tests',
                    '-p','test_generated_parser.py','-v'],cwd=dest,check=True)
    subprocess.run(['git','apply',str(HERE/'adapters.patch')],cwd=dest,check=True)
    subprocess.run([sys.executable,str(HERE/'verify_adapters.py'),str(dest)],cwd=dest,check=True)
    subprocess.run(['git','apply',str(HERE/'expressions.patch')],cwd=dest,check=True)
    subprocess.run([sys.executable,str(HERE/'verify_expressions.py'),str(dest)],cwd=dest,check=True)
    subprocess.run(['git','apply',str(HERE/'inference.patch')],cwd=dest,check=True)
    subprocess.run([sys.executable,str(HERE/'verify_inference.py'),str(dest)],cwd=dest,check=True)
    subprocess.run([sys.executable,str(HERE/'verify_expressions.py'),str(dest),'--inferred'],cwd=dest,check=True)
    for verifier in ['verify_saved.py','verify_dispatch.py','verify_foundations.py','verify_topology.py']:
        subprocess.run([sys.executable,str(ROOT/'studies/operator-integration'/verifier),str(dest)],cwd=dest,check=True)
print('Isolated numeral inference, explicit-expression and operator checks passed; main integration and module defaults remain pending')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
