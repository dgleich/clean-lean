"""Build an offline corpus browser. Run from anywhere: python3 tools/build_review.py.
Source and targets are embedded snapshots; no server, remote assets, or file writes at runtime.
"""
import hashlib
import html
import json
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean, CleanError, comment_lines
from cleanlang.modules import load_document, load_module
from cleanlang.literate import scan

GRAMMAR = ROOT/'editors/vscode/syntaxes/clean.tmLanguage.json'
RULES = [(re.compile(p['match']), p) for p in json.loads(GRAMMAR.read_text())['repository']['code']['patterns'] if 'match' in p]

def style(scope):
    if scope.startswith('invalid'): return 'invalid'
    if scope.startswith('comment'): return 'comment'
    if scope.startswith('keyword'): return 'keyword'
    if scope.startswith(('entity.name.type','meta.signature')): return 'type'
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

def highlight_source(source):
    result = []
    try:
        _, _, regions = scan(source)
    except CleanError:
        # Keep malformed files readable; collect reports their translation error.
        return [html.escape(line) for line in source.splitlines()]
    for raw, spans in zip(source.splitlines(), regions):
        pieces = []
        cursor = 0
        for start, end, kind in spans:
            pieces.append(highlight(raw[cursor:start]))
            css='comment' if kind=='comment' else 'string'
            pieces.append('<span class="'+css+'">' + html.escape(raw[start:end]) + '</span>')
            cursor = end
        pieces.append(highlight(raw[cursor:]))
        result.append(''.join(pieces))
    return result

DECL = re.compile(r'^ *(Result|Theorem|Context|Define|Notation|Condition|Structure|Type|Source)\s+(.+?):?\s*$',re.I)

# generated: gpt-6 2026-11-11 role=assisted; progressive snapshot and freshness checks
def inventory(root=ROOT):
    """Capture sources before translation; pending does not mean successful."""
    files=[]
    for folder in ('library','corpus','examples','studies'):
        paths=set((root/folder).rglob('*.clean')) | set((root/folder).rglob('*.clean.proposed'))
        for path in sorted(paths):
            source=path.read_text(); symbols=[]; imports=[]
            try:
                masked = comment_lines(source)
            except CleanError:
                masked = []
            for number,(line, _) in enumerate(masked,1):
                line = line.rstrip()
                if m:=DECL.fullmatch(line):
                    symbols.append({'kind':m[1].lower(),'name':m[2],'line':number})
                if m:=re.fullmatch(r'Import\s+"([^"\n]+)"',line,re.I):
                    target=(path.parent/m[1]).resolve()
                    imports.append({'label':m[1], 'path':str(target.relative_to(root)) if target.is_relative_to(root) else None})
            proposed=path.name.endswith('.clean.proposed') or path.is_relative_to(root/'examples/proposed')
            files.append({'path':str(path.relative_to(root)), 'source':source,
                'highlighted':highlight_source(source), 'symbols':symbols,
                'imports':imports,'lean':'',
                'status':'Proposed syntax · no translation attempted' if proposed else 'Translation pending',
                'error':None,'sha256':hashlib.sha256(source.encode()).hexdigest()})
    return files


def translate(file,root=ROOT,sources=None):
    if file['status']!='Translation pending':return
    path=root/file['path'];env=Environment()
    try:
        if path.read_text()!=file['source']:
            raise CleanError('Source changed during this build; rebuild the snapshot')
        is_document=any(s['kind'] in ('result','theorem','context') for s in file['symbols'])
        results=load_document(path,env) if is_document else []
        if not is_document:load_module(path,env)
        for dependency in env.loaded_modules:
            expected=(sources or {}).get(dependency)
            if expected is not None and dependency.read_text()!=expected:
                raise CleanError('Dependency changed during this build; rebuild the snapshot')
        if path.read_text()!=file['source']:
            raise CleanError('Source changed during translation; rebuild the snapshot')
        file['lean']=lean(results,env,[])
        for symbol in file['symbols']:
            name=symbol['name'].split('(')[0].strip()
            if name in env.definitions:symbol['leanName']=env.definitions[name]['key']
            elif symbol['kind']=='structure' and name in env.structures:symbol['leanName']=env.structures[name]['key']
            elif symbol['kind'] in ('result','theorem'):symbol['leanName']=re.sub(r'[_\s]+','_',name)
        file['status']='Translated · Lean not checked by this browser'
    except (CleanError,ValueError,OSError,KeyError,ImportError) as exc:
        file['lean']='';file['status']='Translation unavailable'
        file['error']=str(exc).replace(str(root)+'/', '')


def collect(root=ROOT, progress=None):
    files=inventory(root)
    sources={(root/file['path']).resolve():file['source'] for file in files}
    for file in files:
        if progress is not None:progress(file['path'])
        translate(file,root,sources)
    return files


def write_snapshot(payload,template,dest):
    data=json.dumps(payload,ensure_ascii=False).replace('<','\\u003c').replace('>','\\u003e').replace('&','\\u0026')
    temporary=dest.with_name(dest.name+'.tmp')
    temporary.write_text(template.replace('/* REVIEW_DATA */',data))
    temporary.replace(dest)


def build(verbose=True,progressive=False):
    files=inventory()
    payload={'files':files,'revision':subprocess.check_output(['git','rev-parse','--short','HEAD'],cwd=ROOT,text=True).strip(),
             'dirty':bool(subprocess.check_output(['git','status','--porcelain','--untracked-files=no'],cwd=ROOT,text=True).strip()),
             'complete':False}
    template=(ROOT/'tools/review/index.html').read_text();dest=ROOT/'docs/review.html'
    if progressive:write_snapshot(payload,template,dest)
    sources={(ROOT/file['path']).resolve():file['source'] for file in files}
    last_write=time.monotonic()
    for file in files:
        if verbose:print('Checking '+file['path'],file=sys.stderr,flush=True)
        translate(file,ROOT,sources)
        if progressive and time.monotonic()-last_write>=3:
            write_snapshot(payload,template,dest);last_write=time.monotonic()
    payload['complete']=True;write_snapshot(payload,template,dest)
    print(f'Built {dest}: {len(files)} files; '+str(sum(f['error'] is not None for f in files))+' translation errors')

if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser(description='Build the offline Clean review browser from current sources.')
    parser.add_argument('--quiet',action='store_true',help='Hide per-file progress; keep the final build summary.')
    parser.add_argument('--progressive',action='store_true',help='Publish pending sources first and atomically update translations during the full build')
    args=parser.parse_args()
    build(verbose=not args.quiet,progressive=args.progressive)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
