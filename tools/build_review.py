"""Build an offline corpus browser. Run from anywhere: python3 tools/build_review.py.
Source and targets are embedded snapshots; no server, remote assets, or file writes at runtime.
"""
import hashlib
import html
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean, CleanError
from cleanlang.modules import load_document, load_module

GRAMMAR = ROOT/'editors/vscode/syntaxes/clean.tmLanguage.json'
RULES = [(re.compile(p['match']), p) for p in json.loads(GRAMMAR.read_text())['patterns']]

def style(scope):
    if scope.startswith('invalid'): return 'invalid'
    if scope.startswith('comment'): return 'comment'
    if scope.startswith('keyword'): return 'keyword'
    if scope.startswith('entity.name.type'): return 'type'
    if scope.startswith('entity'): return 'name'
    if scope.startswith('constant'): return 'number'
    if scope.startswith('string'): return 'string'
    if scope.startswith('meta.embedded'): return 'lean-body'
    return 'plain'

def highlight(line):
    """Use the grammar's deliberately portable single-line match/capture subset."""
    out=[]; pos=0
    while pos<len(line):
        candidates=[(m.start(),i,m,p) for i,(rx,p) in enumerate(RULES) if (m:=rx.search(line,pos))]
        if not candidates:
            out.append(html.escape(line[pos:])); break
        _,_,m,p=min(candidates,key=lambda c:c[:2])
        out.append(html.escape(line[pos:m.start()]))
        if 'name' in p:
            out.append(f'<span class="{style(p["name"])}">{html.escape(m[0])}</span>')
        else:
            cursor=m.start()
            for group, spec in sorted(p['captures'].items(),key=lambda x:int(x[0])):
                a,b=m.span(int(group))
                if a<0: continue
                out.append(html.escape(line[cursor:a]))
                out.append(f'<span class="{style(spec["name"])}">{html.escape(line[a:b])}</span>')
                cursor=b
            out.append(html.escape(line[cursor:m.end()]))
        pos=m.end()
    return ''.join(out)

DECL = re.compile(r'^ *(Result|Theorem|Context|Define|Notation|Type|Source)\s+(.+?):\s*$',re.I)

def collect(root=ROOT):
    files=[]
    for folder in ('library','corpus','examples'):
        for path in sorted((root/folder).rglob('*.clean')):
            source=path.read_text(); symbols=[]; imports=[]
            for number,line in enumerate(source.splitlines(),1):
                if m:=DECL.fullmatch(line):
                    symbols.append({'kind':m[1].lower(),'name':m[2],'line':number})
                if m:=re.fullmatch(r'Import\s+"([^"\n]+)"',line,re.I):
                    target=(path.parent/m[1]).resolve()
                    imports.append({'label':m[1], 'path':str(target.relative_to(root)) if target.is_relative_to(root) else None})
            env=Environment()
            try:
                is_document=any(s['kind'] in ('result','theorem','context') for s in symbols)
                results=load_document(path,env) if is_document else []
                if not is_document: load_module(path,env)
                target=lean(results,env,[])
                for symbol in symbols:
                    name=symbol['name'].split('(')[0].strip()
                    if name in env.definitions: symbol['leanName']=env.definitions[name]['key']
                    elif symbol['kind'] in ('result','theorem'): symbol['leanName']=re.sub(r'[_\s]+','_',name)
                status='Translated · Lean not checked by this browser'
                error=None
            except (CleanError, ValueError, OSError, KeyError, ImportError) as exc:
                target=''; status='Translation unavailable'; error=str(exc).replace(str(root)+'/', '')
            files.append({'path':str(path.relative_to(root)), 'source':source,
                'highlighted':[highlight(line) for line in source.splitlines()], 'symbols':symbols,
                'imports':imports,'lean':target,'status':status,'error':error,
                'sha256':hashlib.sha256(source.encode()).hexdigest()})
    return files

def build():
    payload={'files':collect(),'revision':subprocess.check_output(['git','rev-parse','--short','HEAD'],cwd=ROOT,text=True).strip(),
             'dirty':bool(subprocess.check_output(['git','status','--porcelain','--untracked-files=no'],cwd=ROOT,text=True).strip())}
    template=(ROOT/'tools/review/index.html').read_text()
    data=json.dumps(payload,ensure_ascii=False).replace('<','\\u003c').replace('>','\\u003e').replace('&','\\u0026')
    dest=ROOT/'docs/review.html'
    dest.write_text(template.replace('/* REVIEW_DATA */',data))
    print(f'Built {dest}: {len(payload["files"])} files; '+str(sum(f['error'] is not None for f in payload['files']))+' translation errors')

if __name__=='__main__': build()
