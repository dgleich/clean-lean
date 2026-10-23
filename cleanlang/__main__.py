import argparse
import json
from pathlib import Path
from .modules import load_document
from .core import CleanError, Environment, lean, latex, bibliography


def combine(environments):
    merged=Environment()
    for env in environments:
        for group in ('types','aliases','functions'):
            for name,value in env.data[group].items():
                if name in merged.data[group] and merged.data[group][name]!=value:
                    raise CleanError('Conflicting definitions across documents: '+name)
                merged.data[group][name]=value
        for name,value in env.sources.entries.items():
            if name in merged.sources.entries and merged.sources.entries[name]!=value:
                raise CleanError('Conflicting sources across documents: '+name)
            merged.sources.entries[name]=value
        merged.sources.references.update(env.sources.references)
        merged.notation_definitions.update(env.notation_definitions)
        merged.lean_imports.extend(i for i in env.lean_imports if i not in merged.lean_imports)
    return merged


def main():
    p=argparse.ArgumentParser(description='Translate explicitly imported Clean statements to Lean or LaTeX.')
    p.add_argument('command',choices=['check','lean','latex','build'])
    p.add_argument('files',nargs='+',type=Path)
    p.add_argument('--output','-o',type=Path)
    a=p.parse_args()
    try:
        batches=[]
        for path in a.files:
            env=Environment()
            results=load_document(path,env)
            batches.append((path,results,env))
        all_results=[r for _,rs,_ in batches for r in rs]
        names=[r.name for r in all_results]
        if len(set(names))!=len(names): raise CleanError('Duplicate result names across input files')
        merged=combine([env for _,_,env in batches])
        if a.command=='build':
            stems=[path.stem for path,_,_ in batches]
            if len(set(stems))!=len(stems): raise CleanError('Build input basenames must be unique')
            dest=a.output or Path('generated');dest.mkdir(parents=True,exist_ok=True)
            for path,results,env in batches:
                (dest/(path.stem+'.tex')).write_text(latex(results,env))
                (dest/(path.stem+'.lean')).write_text(lean(results,env,[]))
                metadata=[{'name':r.name,'title':r.title,'line':r.line,'file':str(path),
                    'contexts':[{'name':c.name,'title':c.title,'key':c.key,'line':c.line} for c in r.contexts],
                    'attribution':r.attribution,'resolved_attribution':env.sources.resolve(r.attribution)} for r in results]
                (dest/(path.stem+'.metadata.json')).write_text(json.dumps(metadata,indent=2,ensure_ascii=False)+'\n')
            (dest/'references.tex').write_text(bibliography(all_results,merged))
        if a.command in ('lean','latex'):
            output=lean(all_results,merged,[]) if a.command=='lean' else latex(all_results,merged)
            if a.output: a.output.write_text(output)
            else: print(output)
        else: print(f'{len(all_results)} statements parsed successfully')
    except (CleanError,OSError,KeyError,ValueError) as e: p.exit(1,str(e)+'\n')

if __name__=='__main__': main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
