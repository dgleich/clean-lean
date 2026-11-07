# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Time active-label declarations; optionally sample the main Python stack."""
import argparse
import sys
import threading
import time
import traceback
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment
import cleanlang.modules as modules

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--stack-every',type=float,default=0,
                    help='Sample the main stack every N seconds; zero disables sampling')
args=parser.parse_args()
if args.stack_every<0:parser.error('--stack-every must be nonnegative')
main=threading.get_ident()
done=threading.Event()
def sample():
    while not done.wait(args.stack_every):
        # Acquiring frames and formatting stacks in a Python thread holds the
        # interpreter lock; do not use an asynchronous faulthandler timer here.
        frame=sys._current_frames().get(main)
        if frame is not None:
            print('Main-thread stack sample:',file=sys.stderr,flush=True)
            traceback.print_stack(frame,limit=40,file=sys.stderr)
            del frame
if args.stack_every:
    threading.Thread(target=sample,daemon=True).start()
original=modules.notation
start=time.monotonic()
def measured(header,fields,env,**kwargs):
    before=time.monotonic();print('START',round(before-start,3),header,flush=True)
    result=original(header,fields,env,**kwargs)
    print('DONE',round(time.monotonic()-before,3),header,flush=True)
    return result
modules.notation=measured
try:
    e=Environment();modules.load_module(ROOT/'library/diagrams/active_labels.clean',e)
    print('TOTAL',round(time.monotonic()-start,3),flush=True)
finally:
    done.set();modules.notation=original

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
