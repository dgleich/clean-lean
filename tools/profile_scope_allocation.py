# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Diagnostic only: time scope allocation while loading subtype restriction."""
import argparse,json,sys,time
from pathlib import Path
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
args=parser.parse_args();root=args.root.resolve();sys.path.insert(0,str(root))
from cleanlang import dependent_functions,binder_keys
from cleanlang.core import Environment
from cleanlang.modules import load_module
stats={};start=time.perf_counter()
def timed(original,name):
    def call(*args,**kwargs):
        before=time.perf_counter()
        try:return original(*args,**kwargs)
        finally:
            count,total=stats.get(name,(0,0.))
            stats[name]=(count+1,total+time.perf_counter()-before)
    return call
dependent_functions.fresh_bound=timed(dependent_functions.fresh_bound,'fresh_bound')
binder_keys.Pool.__init__=timed(binder_keys.Pool.__init__,'Pool.__init__')
e=Environment();load_module(root/'library/logic/subtype_restriction.clean',e)
print(json.dumps({'root':str(root),'elapsed_seconds':time.perf_counter()-start,
                  'calls_and_seconds':stats},indent=2))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
