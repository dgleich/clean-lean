# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Bounded diagnostic of one declaration, not a validation or timeout policy."""
import argparse,cProfile,pstats,signal,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment
import cleanlang.modules as modules

class ObservationFinished(Exception):
    pass

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('module',type=Path)
    parser.add_argument('header',help='Exact stripped declaration header, including any trailing colon')
    parser.add_argument('--seconds',type=float,default=30)
    parser.add_argument('--output',type=Path,required=True,help='Destination cProfile statistics file')
    args=parser.parse_args()
    if not 0 < args.seconds < float('inf'):parser.error('--seconds must be positive and finite')
    if not hasattr(signal,'setitimer'):parser.error('This diagnostic requires POSIX interval timers')
    profile=cProfile.Profile();original=modules.notation;seen=False;finished=False
    def stop(*unused):raise ObservationFinished()
    previous=signal.signal(signal.SIGALRM,stop)
    def trace(header,fields,env,**kwargs):
        nonlocal seen,finished
        if header.strip()!=args.header:return original(header,fields,env,**kwargs)
        if seen:raise RuntimeError('Diagnostic header matched multiple declarations')
        seen=True
        print('Starting bounded observation:',header,flush=True)
        profile.enable();signal.setitimer(signal.ITIMER_REAL,args.seconds)
        try:
            result=original(header,fields,env,**kwargs)
            finished=True
            return result
        finally:
            signal.setitimer(signal.ITIMER_REAL,0);profile.disable()
    modules.notation=trace
    try:
        print('Loading prerequisites; the observation timer starts at the selected declaration.',flush=True)
        modules.load_module(args.module.resolve(),Environment())
    except ObservationFinished:
        print('Observation window ended. Translation incomplete; this is not a validation pass.',flush=True)
    finally:
        signal.setitimer(signal.ITIMER_REAL,0);profile.disable()
        modules.notation=original;signal.signal(signal.SIGALRM,previous)
        if seen:
            profile.dump_stats(str(args.output))
            pstats.Stats(profile).sort_stats('tottime').print_stats(30)
    if not seen:parser.error('Declaration header was not reached')
    if finished:print('Selected declaration completed; no native Lean validation was performed.')
    return 0 if finished else 2

if __name__=='__main__':raise SystemExit(main())

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
