import json
import hashlib
import re
from dataclasses import dataclass, field
from pathlib import Path
from .attribution import Sources, compact, normalize

class CleanError(ValueError): pass
ID = r'[^\W\d]\w*'

@dataclass(frozen=True)
class Type:
    name: str
    args: tuple = ()
    def __str__(self): return self.name + ('(' + ','.join(map(str,self.args)) + ')' if self.args else '')
@dataclass
class Expr:
    lean: str
    tex: str
    type: Type
    precedence: int = 99
@dataclass
class Clause:
    kind: str
    names: list
    value: object
    line: int
@dataclass
class Result:
    name: str
    attribution: dict = field(default_factory=dict)
    clauses: list = field(default_factory=list)
    conclusion: object = None
    line: int = 0
    contexts: list = field(default_factory=list)
    local_clauses: list = field(default_factory=list)
    @property
    def title(self): return self.name.replace('_', ' ')
PROP, NAT, NUM = Type('Proposition'), Type('Natural'), Type('_number')

def split(s):
    out=[]; depth=0; start=0
    for i,c in enumerate(s):
        if c=='(': depth+=1
        if c==')': depth-=1
        if depth<0: raise CleanError('Unmatched parenthesis')
        if c==',' and depth==0: out.append(s[start:i].strip()); start=i+1
    if depth: raise CleanError('Unmatched parenthesis')
    if s[start:].strip(): out.append(s[start:].strip())
    return out

def textext(s):
    d={'\\':r'\textbackslash{}','{':r'\{','}':r'\}','$':r'\$','&':r'\&','#':r'\#','%':r'\%','_':r'\_','~':r'\textasciitilde{}','^':r'\textasciicircum{}'}
    return ''.join(d.get(c,c) for c in s)
def texid(s):
    g={'μ':r'\mu','λ':r'\lambda','ε':r'\varepsilon','δ':r'\delta','α':r'\alpha','β':r'\beta'}
    return g.get(s, s if len(s)==1 and s.isascii() else r'\mathit{'+textext(s)+'}')

def compatible(a,b):
    return a==b or (a==NUM and b.name in ('Natural','Real','Complex','_number','Matrix','Vector')) or (b==NUM and a.name in ('Natural','Real','Complex','Matrix','Vector'))

class Registry:
    def __init__(self,path=None,sources=None):
        self.data=json.loads(Path(path or Path(__file__).with_name('registry.json')).read_text())
        self.sources=Sources(sources or Path(__file__).resolve().parents[1]/'sources.json')
    def extend(self,path):
        data=json.loads(Path(path).read_text())
        for group in ('types','functions'):
            for key,value in data.get(group,{}).items():
                if key in self.data[group]: raise CleanError('Duplicate registry entry: '+key)
                self.data[group][key]=value
        self.data['phrases']+=data.get('phrases',[])
    def type(self,s,env=None,phrases=True,trail=()):
        s=re.sub(r'^(a|an)\s+','',s.strip(),flags=re.I)
        if phrases:
            matches=[p['type'].format(**m.groupdict()) for p in self.data['phrases'] if (m:=re.fullmatch(p['pattern'],s,re.I))]
            if len(matches)>1: raise CleanError('Ambiguous type phrase: '+s)
            if matches: return self.type(matches[0],env,False)
        m=re.fullmatch(r'('+ID+r')(?:\((.*)\))?',s)
        if not m: raise CleanError('Unknown type phrase: '+s)
        name=self.data.get('aliases',{}).get(m[1],m[1]); args=split(m[2] or '')
        if name not in self.data['types']: raise CleanError('Unknown type: '+name)
        kinds=self.data['types'][name].get('args',[])
        if len(args)!=len(kinds): raise CleanError(f'{name} expects {len(kinds)} parameters')
        out=[]
        for a,k in zip(args,kinds):
            if k=='type': out.append(self.type(a,env)); continue
            if not re.fullmatch(r'\d+|'+ID,a): raise CleanError('Dimension must be a numeral or natural parameter')
            if env is not None and not a.isdigit() and (a not in env or env[a].type!=NAT): raise CleanError('Declare dimension '+a+' as Natural first')
            out.append(a)
        if 'canonical' in self.data['types'][name]:
            if name in trail: raise CleanError('Cyclic type alias: '+name)
            expanded=self.data['types'][name]['canonical'].format(*map(str,out))
            return self.type(expanded,env,False,trail+(name,))
        return Type(name,tuple(out))
    def render_type(self,t,target):
        args=[self.render_type(a,target) if isinstance(a,Type) else (texid(a) if target=='latex' and not a.isdigit() else a) for a in t.args]
        return self.data['types'][t.name][target].format(*args)
    def describe_type(self,t,plural=False):
        spec=self.data['types'][t.name]
        template=spec.get('prose_plural' if plural else 'prose')
        if template:
            args=[self.render_type(a,'latex') if isinstance(a,Type) else (a if a.isdigit() else texid(a)) for a in t.args]
            return template.format(*args)
        return ('elements of $' if plural else 'an element of $')+self.render_type(t,'latex')+'$'
    def match(self,p,a,bind):
        if p.startswith('$'):
            if p in bind and bind[p]!=a: raise CleanError('Type or dimension mismatch: '+p)
            bind[p]=a; return
        m=re.fullmatch(r'(\w+)(?:\((.*)\))?',p)
        if not m: raise CleanError('Invalid registry signature: '+p)
        ps=split(m[2] or '')
        if a==NUM and m[1] in ('Natural','Real','Complex'): return
        if not isinstance(a,Type) or a.name!=m[1] or len(ps)!=len(a.args): raise CleanError(f'Expected {p}, got {a}')
        for p2,a2 in zip(ps,a.args):
            if isinstance(a2,Type) or p2.startswith('$'): self.match(p2,a2,bind)
            elif p2!=a2: raise CleanError('Dimension mismatch')
    def instantiate(self,p,bind):
        if p.startswith('$'): return bind[p]
        m=re.fullmatch(r'(\w+)(?:\((.*)\))?',p)
        return Type(m[1],tuple(self.instantiate(a,bind) for a in split(m[2] or '')))
    def call(self,name,args):
        if name not in self.data['functions']: raise CleanError('Unknown function: '+name)
        s=self.data['functions'][name]; bind={}
        if len(args)!=len(s['params']): raise CleanError('Wrong number of arguments for '+name)
        for p,a in zip(s['params'],args): self.match(p,a.type,bind)
        return Expr('('+s['lean'].format(*(a.lean for a in args))+')',s['latex'].format(*(a.tex for a in args)),self.instantiate(s['returns'],bind))

TOKEN=re.compile(r'\s*(\d+|'+ID+r'|↔|→|≤|≥|≠|∧|∨|¬|∈|⊆|∪|∩|∣|<=|>=|!=|[(),+*/^=<>-])')
class Expressions:
    PREC={'↔':1,'→':2,'or':3,'∨':3,'and':4,'∧':4,'=':5,'≠':5,'!=':5,'<':5,'>':5,'≤':5,'≥':5,'<=':5,'>=':5,'∈':5,'⊆':5,'∣':5,'+':6,'-':6,'∪':6,'∩':6,'*':7,'/':7,'^':8}
    def __init__(self,reg,env): self.reg,self.env=reg,env
    def parse(self,s):
        # Match multiword function names only when followed by a call parenthesis.
        names=sorted((n for n in self.reg.data['functions'] if ' ' in n), key=len, reverse=True)
        phrase_token=re.compile(r'\s*('+'|'.join(re.escape(n).replace(r'\ ', r' +') for n in names)+r')(?=\s*\()') if names else None
        s=s.strip(); self.tokens=[]; pos=0; self.i=0
        while pos<len(s):
            m=(phrase_token.match(s,pos) if phrase_token else None) or TOKEN.match(s,pos)
            if not m: raise CleanError('Unsupported expression near '+repr(s[pos:pos+25]))
            self.tokens.append(re.sub(' +', ' ', m[1])); pos=m.end()
        if not self.tokens: raise CleanError('Empty expression')
        x=self.expr(0)
        if self.peek() is not None: raise CleanError('Unexpected token: '+self.peek())
        return x
    def peek(self): return self.tokens[self.i] if self.i<len(self.tokens) else None
    def take(self):
        t=self.peek()
        if t is None: raise CleanError('Unexpected end of expression')
        self.i+=1; return t
    def expr(self,minimum):
        tok=self.take()
        if tok=='(':
            x=self.expr(0)
            if self.take()!=')': raise CleanError('Expected )')
        elif tok in ('-','¬') or tok.lower()=='not':
            a=self.expr(8 if tok=='-' else 5)
            if tok!='-' and a.type!=PROP: raise CleanError('Not requires a proposition')
            inner=('('+a.tex+')') if a.precedence < 8 else a.tex
            tx=('-'+inner) if tok=='-' else (r'\text{not }('+a.tex+')')
            x=Expr('('+('-' if tok=='-' else '¬')+a.lean+')',tx,a.type,7 if tok=='-' else 5)
        elif tok.isdigit(): x=Expr(tok,tok,NUM)
        elif self.peek()=='(':
            self.take(); args=[]
            if self.peek()!=')':
                while True:
                    args.append(self.expr(0))
                    if self.peek()!=',': break
                    self.take()
            if self.take()!=')': raise CleanError('Expected )')
            if tok in self.env and self.env[tok].type.name=='Function':
                t=self.env[tok].type
                if len(args)!=1 or not compatible(args[0].type,t.args[0]): raise CleanError('Function argument mismatch')
                x=Expr('('+tok+' '+args[0].lean+')',texid(tok)+'('+args[0].tex+')',t.args[1])
            else: x=self.reg.call(tok,args)
        elif tok in self.env: x=self.env[tok]
        else: raise CleanError('Unknown name: '+tok)
        while self.peek() is not None:
            op=self.peek().lower(); prec=self.PREC.get(op,-1)
            if prec<minimum: break
            self.take(); b=self.expr(prec if op in ('^','→') else prec+1)
            x=binary(op,x,b)
        return x

def binary(op,a,b):
    op={'!=':'≠','<=':'≤','>=':'≥','and':'∧','or':'∨'}.get(op,op)
    t=a.type if a.type!=NUM else b.type; lop=op
    if op in ('∧','∨','↔','→'):
        if a.type!=PROP or b.type!=PROP: raise CleanError('Logical operator requires propositions')
        t=PROP
    elif op in ('=','≠','<','>','≤','≥','∣'):
        if not compatible(a.type,b.type): raise CleanError(f'Cannot compare {a.type} and {b.type}')
        t=PROP
    elif op=='∈':
        if b.type.name not in ('Set','List') or not compatible(a.type,b.type.args[0]): raise CleanError('Membership type mismatch')
        t=PROP
    elif op in ('⊆','∪','∩'):
        if a.type!=b.type or a.type.name!='Set': raise CleanError('Set type mismatch')
        t=PROP if op=='⊆' else a.type
    elif op=='*':
        if a.type.name=='Matrix' and b.type.name=='Vector':
            m,n,k=a.type.args
            if b.type.args!=(n,k): raise CleanError('Matrix/vector dimension or field mismatch')
            t,lop=Type('Vector',(m,k)),'*ᵥ'
        elif a.type.name=='Matrix' and b.type.name=='Matrix':
            m,n,k=a.type.args; p,q,j=b.type.args
            if n!=p or k!=j: raise CleanError('Matrix dimension or field mismatch')
            t=Type('Matrix',(m,q,k))
        elif b.type.name in ('Vector','Matrix') and compatible(a.type,b.type.args[-1]): t,lop=b.type,'•'
        elif a.type.name in ('Vector','Matrix') or b.type.name in ('Vector','Matrix'): raise CleanError('Unsupported product')
        elif not compatible(a.type,b.type): raise CleanError('Product type mismatch')
    elif op=='^':
        if b.type not in (NUM,NAT): raise CleanError('Natural exponents required')
        t=a.type
    elif not compatible(a.type,b.type): raise CleanError('Arithmetic type mismatch')
    top={'∧':r'\text{ and }','∨':r'\text{ or }','↔':r'\text{ if and only if }','→':r'\text{ implies }','≠':r'\ne','≤':r'\le','≥':r'\ge','∈':r'\text{ belongs to }','⊆':r'\text{ is a subset of }','∪':r'\cup','∩':r'\cap','∣':r'\text{ divides }','*':r'\,'}.get(op,op)
    prec=Expressions.PREC.get(op,Expressions.PREC.get({'∧':'and','∨':'or'}.get(op,op),5))
    left='('+a.tex+')' if a.precedence<prec else a.tex
    right='('+b.tex+')' if b.precedence<=prec else b.tex
    tex=left+' '+top+' '+right
    if op=='^': tex='{'+left+'}^{'+b.tex+'}'
    if op=='/': tex=r'\frac{'+a.tex+'}{'+b.tex+'}'
    return Expr('('+a.lean+' '+lop+' '+b.lean+')',tex,t,prec)

def _parse_flat(text,reg):
    results=[]; r=None; env={}; mode=None; conclusion=[]
    attribution_seen=False
    def finish():
        if r is None: return
        if conclusion: r.conclusion=Expressions(reg,env).parse(' '.join(conclusion))
        if r.conclusion is None or r.conclusion.type!=PROP: raise CleanError(r.name+': conclude must be a proposition')
        try:
            r.attribution=normalize(r.attribution)
            reg.sources.resolve(r.attribution)
        except ValueError as e: raise CleanError(f'{r.name}: {e}') from e
        results.append(r)
    for num,raw in enumerate(text.splitlines(),1):
        if '\t' in raw: raise CleanError(f'line {num}: tabs are not allowed')
        if not raw.strip() or raw.lstrip().startswith('#'): continue
        indent=len(raw)-len(raw.lstrip()); s=raw.strip()
        try:
            if indent==0:
                m=re.fullmatch(r'(?:result|theorem)\s+('+ID+r'(?:\s+\w+)*):',s,re.I)
                if not m: raise CleanError('Expected Result name: at column 1')
                finish(); r=Result(re.sub(r'[_\s]+', '_', m[1]),line=num); env={}; mode=None; conclusion=[]; attribution_seen=False
                if any(x.name==r.name for x in results): raise CleanError('Duplicate result name')
                continue
            if r is None: raise CleanError('Clause outside result')
            if indent==8 and mode=='attribution':
                k,sep,v=s.partition(':'); k=k.lower(); v=v.strip()
                if not sep or not v or not re.fullmatch(r'[a-z_]+',k): raise CleanError('Expected field: value')
                if k in r.attribution: raise CleanError('Duplicate attribution field')
                r.attribution[k]=v; continue
            if indent==8 and mode=='conclude': conclusion.append(s); continue
            if indent!=4: raise CleanError('Use 4 spaces for clauses and 8 for nested blocks')
            if mode=='conclude': raise CleanError('Conclude must be last')
            mode=None
            if re.match(r'attribution\s*:',s,re.I):
                if attribution_seen: raise CleanError('Duplicate attribution clause')
                attribution_seen=True
                rest=s.split(':',1)[1].strip()
                if rest:
                    try: r.attribution=compact(rest)
                    except ValueError as e: raise CleanError(str(e)) from e
                else: mode='attribution'
                continue
            if re.match(r'conclude\b',s,re.I):
                mode='conclude'; rest=re.sub(r'^conclude\s*:?', '',s,flags=re.I).strip()
                if rest: conclusion.append(rest)
                continue
            m=re.fullmatch(r'assume\s+('+ID+r')\s*:\s*(.+)',s,re.I)
            if m:
                name,expr=m.groups()
                if name in env: raise CleanError('Duplicate name: '+name)
                value=Expressions(reg,env).parse(expr)
                if value.type!=PROP: raise CleanError('Assume requires a proposition')
                r.clauses.append(Clause('assume',[name],value,num)); env[name]=Expr(name,texid(name),PROP); continue
            m=re.fullmatch(r'(let|define)\s+(.+)',s,re.I)
            if not m: raise CleanError('Expected Let, Define, Assume, Attribution, or Conclude')
            verb,tail=m.groups(); typed=re.fullmatch(r'(.+?)\s*(?::|\bbe\b)\s*(.+)',tail,re.I)
            if typed:
                if verb.lower()=='define': raise CleanError('Define is a synonym for value definitions only')
                ns,ts=typed.groups(); names=[n.strip() for n in ns.split(',')]; t=reg.type(ts,env)
                for name in names:
                    if not re.fullmatch(ID,name) or name in env: raise CleanError('Invalid or duplicate name: '+name)
                    env[name]=Expr(name,texid(name),t)
                r.clauses.append(Clause('let',names,t,num))
            else:
                m=re.fullmatch(r'('+ID+r')\s*=\s*(.+)',tail)
                if not m: raise CleanError('Expected let x: Type, let x be Type, or let x = expression')
                name,rhs=m.groups()
                if name in env: raise CleanError('Duplicate name: '+name)
                try: reg.type(rhs,env)
                except CleanError: pass
                else: raise CleanError('Cannot use let x = Type; use let x: Type or let x be Type')
                value=Expressions(reg,env).parse(rhs)
                if value.type==NUM: value.type=NAT
                if value.type==PROP: raise CleanError('Use Assume for named propositions')
                env[name]=Expr(name,texid(name),value.type); r.clauses.append(Clause('define',[name],value,num))
        except CleanError as e: raise CleanError(f'line {num}: {e}') from e
    finish()
    if not results: raise CleanError('No results found')
    return results

@dataclass
class Context:
    name: str
    key: str
    clauses: list
    parents: list
    line: int
    @property
    def title(self): return self.name.replace('_', ' ')


def _dependencies(value):
    text=value.lean if isinstance(value,Expr) else str(value)
    return set(re.findall(ID,text))


def _select_context_parameters(result,inherited):
    # Every assumption is retained. Only unused inherited objects/definitions may disappear.
    used=_dependencies(result.conclusion)
    kept=[]
    for i,clause in reversed(list(enumerate(result.clauses))):
        keep=i>=inherited or clause.kind=='assume'
        names=clause.names
        if clause.kind=='let' and not keep:
            names=[name for name in names if name in used]
            keep=bool(names)
        elif clause.kind=='define' and not keep:
            keep=clause.names[0] in used
        if keep:
            kept.append(Clause(clause.kind,names,clause.value,clause.line))
            used.difference_update(names)
            used.update(_dependencies(clause.value))
    return list(reversed(kept))


def parse(text,reg):
    # Parse indentation scopes, then reuse the statement parser on explicit expansions.
    lines=[]
    for number,raw in enumerate(text.splitlines(),1):
        if '\t' in raw: raise CleanError(f'line {number}: tabs are not allowed')
        if not raw.strip() or raw.lstrip().startswith('#'): continue
        indent=len(raw)-len(raw.lstrip())
        if indent%4: raise CleanError(f'line {number}: Use 4 spaces for each indentation level')
        lines.append((number,indent,raw.strip()))
    results=[]; names=set(); context_names=set(); cache={}
    file_key=hashlib.sha256(text.encode()).hexdigest()[:12]
    def scope(start,end,level,ancestors):
        i=start
        while i<end:
            number,indent,line=lines[i]
            if indent!=level: raise CleanError(f'line {number}: Expected a Context or Result at this indentation')
            match=re.fullmatch(r'(context|result|theorem)\s+('+ID+r'(?:\s+\w+)*):',line,re.I)
            if not match: raise CleanError(f'line {number}: Expected Context name: or Result name:')
            kind,title=match.groups(); kind=kind.lower(); name=re.sub(r'[_\s]+','_',title)
            stop=i+1
            while stop<end and lines[stop][1]>level: stop+=1
            if kind=='context':
                path=tuple(a['name'] for a in ancestors)+(name,)
                if path in context_names: raise CleanError(f'line {number}: Duplicate context name')
                context_names.add(path)
                child=i+1; declarations=[]
                while child<stop:
                    num,ind,txt=lines[child]
                    if ind==level+4 and re.match(r'(context|result|theorem)\b',txt,re.I): break
                    if ind!=level+4 or not re.match(r'(let|define|assume)\b',txt,re.I):
                        raise CleanError(f'line {num}: Contexts contain Let/Define/Assume clauses before nested results')
                    declarations.append((num,txt)); child+=1
                if child==stop: raise CleanError(f'line {number}: Context must contain a result')
                item={'name':name,'key':file_key+'-'+str(number),'line':number,'declarations':declarations}
                scope(child,stop,level+4,ancestors+[item])
            else:
                if name in names: raise CleanError(f'line {number}: Duplicate result name')
                names.add(name)
                inherited=[d for a in ancestors for d in a['declarations']]
                flattened=['Result '+name+':']+['    '+txt for _,txt in inherited]
                original=[number]+[num for num,_ in inherited]
                for num,ind,txt in lines[i+1:stop]:
                    flattened.append(' '*(ind-level)+txt); original.append(num)
                try: r=_parse_flat('\n'.join(flattened),reg)[0]
                except CleanError as e:
                    message=str(e)
                    message=re.sub(r'^line (\d+):',lambda m:'line '+str(original[int(m[1])-1])+':',message)
                    raise CleanError(message) from e
                r.line=number
                for clause in r.clauses: clause.line=original[clause.line-1]
                offset=0; contexts=[]
                for a in ancestors:
                    count=len(a['declarations'])
                    if a['key'] not in cache:
                        cache[a['key']]=Context(a['name'],a['key'],r.clauses[offset:offset+count],list(contexts),a['line'])
                    contexts.append(cache[a['key']]); offset+=count
                r.contexts=contexts
                r.local_clauses=r.clauses[len(inherited):]
                r.clauses=_select_context_parameters(r,len(inherited))
                results.append(r)
            i=stop
    scope(0,len(lines),0,[])
    if not results: raise CleanError('No results found')
    return results


def lean(results,reg,imports):
    imports=list(dict.fromkeys([*imports,*getattr(reg,'lean_imports',[])]))
    out=[*(f'import {i}' for i in imports),'',*getattr(reg,'notation_definitions',{}).values(),'','open scoped Matrix','','-- Named hypothesis binders document assumptions even when not dependent.','set_option linter.unusedVariables false','','namespace CleanStatements','']
    for r in results:
        out+=['/--']+[k+': '+v.replace('/-','/ -').replace('-/','- /') for k,v in r.attribution.items()]+['-/',f'def {r.name} : Prop :=']
        for c in r.clauses:
            if c.kind=='let': out+=['  ∀ ('+' '.join(c.names)+' : '+reg.render_type(c.value,'lean')+'),']
            elif c.kind=='assume': out+=[f'  ∀ ({c.names[0]} : {c.value.lean}),']
            else: out+=[f'  let {c.names[0]} : {reg.render_type(c.value.type,"lean")} := {c.value.lean};']
        out+=['  '+r.conclusion.lean,'']
    return '\n'.join(out+['end CleanStatements',''])

def _latex_clauses(clauses,reg):
    out=[]
    for c in clauses:
        ns=', '.join(texid(n) for n in c.names)
        if c.kind=='let':
            names=[texid(n) for n in c.names]
            subjects=('$'+names[0]+'$') if len(names)==1 else ', '.join('$'+n+'$' for n in names[:-1])+' and $'+names[-1]+'$'
            out+=['Let '+subjects+' be '+reg.describe_type(c.value,len(names)>1)+'.']
        elif c.kind=='define': out+=['Let $'+ns+' = '+c.value.tex+'$.']
        else: out+=['Assume $'+c.value.tex+r'$ (\texttt{'+textext(c.names[0])+'}).']
    return out


def _context_references(contexts):
    references=[r'Context (\cleancontextref{'+c.key+'})' for c in contexts]
    return 'Using '+(', '.join(references[:-1])+' and '+references[-1] if len(references)>1 else references[0])+'.'


def _latex_result(r,reg,referenced=False):
    resolved=reg.sources.resolve(r.attribution)
    label=resolved['source']['label']
    if resolved['source']['kind']!='lean': label+=', '+r.attribution['reference']
    citation='['+textext(label)+']'
    if resolved.get('url'): citation=r'\href{'+textext(resolved['url'])+'}{'+citation+'}'
    out=[r'\begin{cleanresult}{'+textext(r.title)+'}'+r'\cleanattribution{'+citation+'}']
    if referenced and r.contexts: out.append(_context_references(r.contexts))
    out+=_latex_clauses(r.local_clauses if referenced else r.clauses,reg)
    out+=[r'Then \['+r.conclusion.tex+r'.\]']
    qualifications=[]
    if r.attribution.get('relationship')=='adapted': qualifications.append('Adapted from the cited source.')
    if 'scope' in r.attribution: qualifications.append('Scope: '+r.attribution['scope'].rstrip('.')+'.')
    for key in ('changes','note'):
        if key in r.attribution: qualifications.append(r.attribution[key].rstrip('.')+'.')
    if qualifications: out+=[r'\par\smallskip{\footnotesize '+textext(' '.join(qualifications))+'}']
    return out+[r'\end{cleanresult}','']


def latex(results,reg):
    out=['% Generated statements, not proof certificates.']
    seen=set()
    for r in results:
        if r.contexts:
            out.append(r'\ifcleanreferenced')
            for context in r.contexts:
                if context.key in seen: continue
                seen.add(context.key)
                out.append(r'\begin{cleancontext}{'+textext(context.title)+'}{'+context.key+'}')
                if context.parents: out.append(_context_references(context.parents))
                out+=_latex_clauses(context.clauses,reg)
                out.append(r'\end{cleancontext}')
            out+=_latex_result(r,reg,True)
            out.append(r'\else')
            out+=_latex_result(r,reg)
            out.append(r'\fi')
        else: out+=_latex_result(r,reg)
    return '\n'.join(out)


def bibliography(results,reg):
    # Include the project's source registry once, so partial builds cannot erase references.
    keys=list(reg.sources.entries)
    out=[r'\begin{description}']
    for key in keys:
        source=reg.sources.entries[key]
        text=source.get('author','')+'. '+source['title']
        for field in ('year','publisher','version'):
            if field in source: text += '. '+('Version ' if field=='version' else '')+str(source[field])
        if 'revision' in source: text += '. Revision '+source['revision'][:12]
        entry=textext(text.rstrip('.')+'.')
        if source.get('url'): entry+=r' \href{'+textext(source['url'])+r'}{Source}'
        out += [r'\item['+textext(source['label'])+'] '+entry]
    return '\n'.join(out+[r'\end{description}',''])
