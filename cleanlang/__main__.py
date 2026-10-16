import argparse
import copy
import json
from pathlib import Path
from .modules import load_document
from .core import CleanError, Registry, parse, lean, latex, bibliography

p=argparse.ArgumentParser(description='Translate Clean statements to Lean propositions or LaTeX.')
p.add_argument('command',choices=['check','lean','latex','build'])
p.add_argument('files',nargs='+',type=Path)
p.add_argument('--sources',type=Path,default=Path('sources.json'))
p.add_argument('--registry',action='append',default=[],type=Path)
p.add_argument('--output','-o',type=Path)
p.add_argument('--imports',default='imports.json',type=Path)
a=p.parse_args()
try:
    reg=Registry(sources=a.sources)
    for path in a.registry: reg.extend(path)
    imports=json.loads(a.imports.read_text()) if a.imports.exists() else ['Mathlib']
    batches=[]
    all_results=[]
    for path in a.files:
        local=copy.deepcopy(reg)
        try: results=load_document(path,local)
        except CleanError as e: raise CleanError(f'{path}: {e}') from e
        batches.append((path,results,local)); all_results+=results
    names=[r.name for r in all_results]
    if len(set(names))!=len(names): raise CleanError('Duplicate result names across input files')
    stems=[path.stem for path,_,_ in batches]
    if a.command=='build' and len(set(stems))!=len(stems):
        raise CleanError('Build input basenames must be unique')
    if a.command=='build':
        dest=a.output or Path('generated'); dest.mkdir(parents=True,exist_ok=True)
        for path,results,local in batches:
            (dest/(path.stem+'.tex')).write_text(latex(results,local))
            (dest/(path.stem+'.lean')).write_text(lean(results,local,imports))
            (dest/(path.stem+'.metadata.json')).write_text(json.dumps([{'name':r.name,'title':r.title,'line':r.line,'file':str(path),'contexts':[{'name':c.name,'title':c.title,'key':c.key,'line':c.line} for c in r.contexts],'attribution':r.attribution,'resolved_attribution':reg.sources.resolve(r.attribution)} for r in results],indent=2,ensure_ascii=False)+'\n')
        (dest/'references.tex').write_text(bibliography(all_results,reg))
    reg.notation_definitions={}
    reg.lean_imports=[]
    for _,_,local in batches:
        reg.notation_definitions.update(local.notation_definitions)
        reg.lean_imports.extend(local.lean_imports)
    if a.command in ('lean','latex'):
        output=lean(all_results,reg,imports) if a.command=='lean' else latex(all_results,reg)
        if a.output: a.output.write_text(output)
        else: print(output)
    else: print(f'{len(all_results)} statements parsed successfully')
except (CleanError, OSError, KeyError, ValueError) as e: p.exit(1,str(e)+'\n')
