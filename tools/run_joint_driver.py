# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Run an existing validation driver with isolated joint literal routing."""
from pathlib import Path
import argparse,runpy,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang import numeral_inference
from cleanlang.joint_inference import complete

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('driver',type=Path);parser.add_argument('arguments',nargs=argparse.REMAINDER)
 args=parser.parse_args();original=numeral_inference.complete;argv=sys.argv
 def route(tree,env,locals,expected=None,*,limit=4096):
  if not numeral_inference.holes(tree):return original(tree,env,locals,expected,limit=limit)
  return complete(tree,env,locals,expected,limit=limit)
 try:
  numeral_inference.complete=route;sys.argv=[str(args.driver),*args.arguments]
  runpy.run_path(str(args.driver),run_name='__main__')
 finally:numeral_inference.complete=original;sys.argv=argv

if __name__=='__main__':main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
