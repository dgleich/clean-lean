# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
import sys,time,faulthandler
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment
import cleanlang.modules as modules
faulthandler.dump_traceback_later(120,repeat=True)
original=modules.notation
start=time.monotonic()
def measured(header,fields,env,**kwargs):
 before=time.monotonic();print('START',round(before-start,3),header,flush=True)
 result=original(header,fields,env,**kwargs)
 print('DONE',round(time.monotonic()-before,3),header,flush=True)
 return result
modules.notation=measured
e=Environment();modules.load_module(ROOT/'library/diagrams/active_labels.clean',e)
print('TOTAL',round(time.monotonic()-start,3),flush=True)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
