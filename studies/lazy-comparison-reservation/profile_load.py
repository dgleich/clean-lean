# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Bounded diagnostic only: never interrupts an existing validation process."""
from pathlib import Path
import argparse,cProfile,pstats,signal
import cleanlang
from cleanlang.core import Environment
from cleanlang.modules import load_module
parser=argparse.ArgumentParser()
parser.add_argument('--seconds',type=int,default=15)
args=parser.parse_args()
if args.seconds<=0:parser.error('--seconds must be positive')
ROOT=Path(cleanlang.__file__).resolve().parents[1]
class SampleComplete(Exception):pass
def deadline(*unused):raise SampleComplete()
profile=cProfile.Profile();signal.signal(signal.SIGALRM,deadline)
print('Diagnostic compiler:',ROOT,flush=True)
profile.enable();signal.alarm(args.seconds)
try:
 load_module(ROOT/'library/diagrams/active_labels.clean',Environment())
 print('Diagnostic load completed; no theorem/proof validation was run.')
except SampleComplete:
 print('Diagnostic sample deadline reached; incomplete load, not a validation result.')
finally:
 signal.alarm(0);profile.disable()
 pstats.Stats(profile).strip_dirs().sort_stats('cumulative').print_stats(28)

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
