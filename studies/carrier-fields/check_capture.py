# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Failing acceptance gate: module carrier callees must retain their binding.

Pass an isolated checkout with prototype.patch applied and parser regenerated.
This gate must reject the source at Clean checking; Lean rejection is insufficient.
"""
from pathlib import Path
import sys
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(Path(sys.argv[1]).resolve()))
from cleanlang.core import Environment,CleanError,lean
from cleanlang.modules import load_document

env=Environment()
try:
    results=load_document(HERE/'CapturedCarrier.clean.proposed',env)
except CleanError as error:
    # A parser/import failure is not evidence of the required type rejection.
    if str(error)!='Dependent index mismatch: (c(P))':
        raise
    print('Carrier capture rejected:',error)
else:
    output=Path(sys.argv[1]).resolve()/'CarrierCapture.lean'
    output.write_text(lean(results,env,[]))
    raise AssertionError('Clean accepted captured module carrier; generated counterexample: '+str(output))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
