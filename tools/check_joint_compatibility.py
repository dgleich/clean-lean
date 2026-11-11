# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Compare isolated legacy/joint loads; text agreement is not a canonical oracle."""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys,time,contextlib,io,os,runpy
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))


def worker(path,mode):
 from cleanlang.core import Environment,lean
 from cleanlang.modules import load_document
 from cleanlang import numeral_inference
 from cleanlang.joint_inference import complete,Incomplete,NoSolution,Ambiguous,Underdetermined
 from cleanlang.retained_codec import dumps
 original=numeral_inference.complete
 observations={'calls':0,'last_tree':None}
 def route(tree,env,locals,expected=None,*,limit=4096):
  if not numeral_inference.holes(tree):return original(tree,env,locals,expected,limit=limit)
  observations['calls']+=1;observations['last_tree']=dumps(tree)
  if mode in ('joint','corpus-joint'):return complete(tree,env,locals,expected,limit=limit)
  return original(tree,env,locals,expected,limit=limit)
 numeral_inference.complete=route
 started=time.monotonic()
 try:
  if mode=='corpus-joint':
   with contextlib.redirect_stdout(io.StringIO()):namespace=runpy.run_path(str(ROOT/'verify_corpus.py'))
   checked=subprocess.run([os.environ.get('LAKE','lake'),'env','lean','generated/VerifiedCorpus.lean'],cwd=ROOT,text=True,capture_output=True)
   if checked.returncode:raise RuntimeError(checked.stdout+checked.stderr)
   source=(ROOT/'generated/VerifiedCorpus.lean').read_text();results=namespace['results']
  else:
   env=Environment();results=load_document(path,env);source=lean(results,env,[])
  outcome={'status':'proved' if mode=='corpus-joint' else 'translated','results':len(results),'lean_sha256':hashlib.sha256(source.encode()).hexdigest()}
 except Exception as error:
  outcome={'status':'incomplete' if isinstance(error,Incomplete) else
            'no-solution' if isinstance(error,NoSolution) else
            'ambiguous' if isinstance(error,Ambiguous) else
            'underdetermined' if isinstance(error,Underdetermined) else 'error',
           'error_type':type(error).__name__,'message':str(error),'last_tree':observations['last_tree']}
 finally:numeral_inference.complete=original
 return {**outcome,'hole_calls':observations['calls'],'elapsed_seconds':round(time.monotonic()-started,3)}


def compare(legacy,joint):
 if legacy['status']!='translated':return 'baseline-unavailable'
 if joint['status']!='translated':return 'joint-'+joint['status']
 return 'same-generated-text' if legacy['lean_sha256']==joint['lean_sha256'] else 'different-generated-text'


def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('paths',nargs='*');parser.add_argument('--output',type=Path)
 parser.add_argument('--worker',choices=['legacy','joint','corpus-joint'],help=argparse.SUPPRESS)
 parser.add_argument('--verify-corpus',action='store_true',help='Regenerate and kernel-check the 92 corpus fixtures with joint inference')
 args=parser.parse_args()
 if args.worker:
  if args.worker!='corpus-joint' and len(args.paths)!=1:parser.error('Worker requires one input')
  print(json.dumps(worker(Path(args.paths[0]) if args.paths else None,args.worker)));return
 paths=args.paths or [str(p.relative_to(ROOT)) for p in sorted((ROOT/'corpus').glob('*.clean'))]
 report={'_provenance':{'origin':'llm','model':'gpt-6','date':'2026-11-11','role':'assisted'},
         'scope':'Isolated document translation; generated text hashes are diagnostics, not canonical Lean or proof validation.',
         'default_changed':False,'files':[]}
 for path in paths:
  modes={}
  for mode in ('legacy','joint'):
   print(f'Checking {path} ({mode})',file=sys.stderr,flush=True)
   completed=subprocess.run([sys.executable,str(Path(__file__).resolve()),'--worker',mode,path],cwd=ROOT,text=True,capture_output=True)
   if completed.returncode:
    modes[mode]={'status':'worker-failed','returncode':completed.returncode,'stderr':completed.stderr}
   else:modes[mode]=json.loads(completed.stdout)
  report['files'].append({'path':path,**modes,'comparison':compare(modes['legacy'],modes['joint'])})
  # Preserve completed observations even while later cases are still running.
  if args.output:args.output.write_text(json.dumps(report,indent=2)+'\n')
 if args.verify_corpus:
  checked=subprocess.run([sys.executable,str(Path(__file__).resolve()),'--worker','corpus-joint'],cwd=ROOT,text=True,capture_output=True)
  report['corpus_proofs']=json.loads(checked.stdout) if not checked.returncode else {'status':'worker-failed','stderr':checked.stderr}
  if args.output:args.output.write_text(json.dumps(report,indent=2)+'\n')
 if not args.output:print(json.dumps(report,indent=2))
 success=all(r['comparison']=='same-generated-text' for r in report['files'])
 if args.verify_corpus:success=success and report['corpus_proofs']['status']=='proved'
 return 0 if success else 1

if __name__=='__main__':raise SystemExit(main())

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
