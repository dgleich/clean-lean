# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Diagnostic cold/warm comparison-token scans; not a compiler speed benchmark."""
from pathlib import Path
import argparse,json,sys,time
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Type
from cleanlang.modules import load_module
from cleanlang.binder_keys import Pool,environment_tokens
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--iterations',type=int,default=100)
args=parser.parse_args()
if args.iterations<1:parser.error('iterations must be positive')
e=Environment();load_module(ROOT/'library/logic/subtype_restriction.clean',e)
local={'x':Expr('clean_comparison_identity_0','x',Type('Natural'))}
tree=['Local','clean_comparison_identity_1']
def run(cold):
    start=time.perf_counter();names=[]
    for _ in range(args.iterations):
        if cold and hasattr(e,'_comparison_reserved_tokens'):del e._comparison_reserved_tokens
        names.append(Pool(e,local,tree).fresh(local))
    return time.perf_counter()-start,names
cold,cold_names=run(True);environment_tokens(e);warm,warm_names=run(False)
assert cold_names==warm_names
print(json.dumps({'iterations':args.iterations,'cold_seconds':cold,'warm_seconds':warm,
                  'same_fresh_names':True,'diagnostic_only':True},indent=2))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
