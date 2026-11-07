# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from tools.study_checkout import create_study_checkout,BASE_COMMIT
root=ROOT
with tempfile.TemporaryDirectory() as td:
 dest=Path(td);create_study_checkout(dest,root)
 for name in ['cleanlang/core.py','grammar/clean.lark','tests/test_structures.py','tools/generate_parser.py']:
  expected=subprocess.check_output(['git','show',BASE_COMMIT+':'+name],cwd=root)
  assert (dest/name).read_bytes()==expected,name
 for name in ['studies/operator-integration/verify_prototype.py','studies/operator-integration/foundations/Topology.clean.proposed','tools/study_checkout.py']:
  assert (dest/name).read_bytes()==(root/name).read_bytes(),name
 assert not (dest/'.github_token').exists()
 assert (dest/'.lake').resolve()==(root/'.lake').resolve()
 try:create_study_checkout(dest,root)
 except ValueError:pass
 else:raise AssertionError('Nonempty destination overwritten')
 for rel in ['studies/carrier-fields/prototype.patch','studies/carrier-fields/bound-calls.patch','studies/carrier-fields/proof-bindings.patch','studies/carrier-fields/annotations.patch','studies/type-identity/local-types.patch','studies/native-type-bindings/prototype.patch','studies/qualified-globals/prototype.patch','studies/operator-integration/prototype.patch']:
  subprocess.run(['git','apply',str(root/rel)],cwd=dest,check=True)
 print('Pinned baseline, current study overlay, dependency reuse and eight-patch application checked')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
