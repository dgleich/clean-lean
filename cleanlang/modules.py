"""Explicit Clean modules: all mathematical names originate in declarations."""
import hashlib
import re
import string
from pathlib import Path
from .core import CleanError, ID, Expr, Type, NAT, parse, split, textext, normalize_layout


def template(text, names, plain=False):
    """Compile named rendering placeholders; never interpret template expressions."""
    out = ''
    try:
        for literal, field, spec, conversion in string.Formatter().parse(text):
            if plain:
                literal = r'\text{' + textext(literal) + '}' if literal else ''
            out += literal.replace('{', '{{').replace('}', '}}')
            if field is not None:
                if field not in names or spec or conversion:
                    raise CleanError('Unknown or invalid rendering parameter: '+field)
                out += '{'+str(names.index(field))+'}'
    except ValueError as e:
        raise CleanError(str(e)) from e
    return out


def substitute(text, names):
    """Compile Lean/type expressions with bound parameter names into templates."""
    text = text.replace('{', '{{').replace('}', '}}')
    return re.sub(ID, lambda m: '{'+str(names.index(m[0]))+'}' if m[0] in names else m[0], text)


def fields_map(fields):
    values = {}
    for field in fields:
        if ':' not in field:
            raise CleanError('Expected field: value')
        key, value = field.split(':', 1)
        key, value = key.lower(), value.strip()
        if key in values or not value:
            raise CleanError('Duplicate or empty field: '+key)
        values[key] = value
    return values


def add_definition(env, prefix, name, body):
    key = prefix+hashlib.sha256((name+body).encode()).hexdigest()[:20]
    env.notation_definitions[key] = f'noncomputable def {key} {body}\n'
    return key


def type_declaration(header, fields, env):
    m = re.fullmatch(r'Type\s+('+ID+r')\((.*?)\):', header, re.I)
    if not m: raise CleanError('Expected Type Name(parameters):')
    name, parameters = m[1], split(m[2])
    if name in env.data['types'] or name in env.data['aliases']:
        raise CleanError('Duplicate type: '+name)
    names, kinds = [], []
    for parameter in parameters:
        p = re.fullmatch('('+ID+r'):\s*(Natural|Type)', parameter)
        if not p or p[1] in names: raise CleanError('Type parameters require distinct names and Natural or Type kinds')
        names.append(p[1]); kinds.append('dimension' if p[2]=='Natural' else 'type')
    values = fields_map(fields)
    if 'equals' in values:
        if set(values) != {'equals'}: raise CleanError('Type alias accepts only Equals')
        env.data['types'][name] = {'args': kinds, 'canonical': substitute(values['equals'], names)}
        local={n: Expr(n,n,NAT if k=='dimension' else Type('Type')) for n,k in zip(names,kinds)}
        env.type(name+'('+','.join(names)+')' if names else name, local)
        return
    if not {'means','render latex'} <= values.keys() or values.keys()-{'means','render latex','describe','describe plural'}:
        raise CleanError('Type requires Means and Render latex; optional Describe and Describe plural')
    spec={'args': kinds, 'lean': substitute(values['means'], names), 'latex': template(values['render latex'], names)}
    for src,dst in [('describe','prose'),('describe plural','prose_plural')]:
        if src in values: spec[dst] = template(values[src], names)
    env.data['types'][name] = spec
    signature=' '.join(f'({n} : '+('Nat' if k=='dimension' else 'Type')+')' for n,k in zip(names,kinds))
    sort='Sort 1' if values['means']=='Prop' else 'Type'
    add_definition(env, 'cleanType_', name, f'{signature} : {sort} :=\n  {values["means"]}')


def notation(header, fields, env):
    m = re.fullmatch(r'Notation\s+('+ID+r'(?: +'+ID+r')*)\((.*?)\):', header, re.I)
    if not m: raise CleanError('Invalid Notation header')
    name, params = re.sub(' +', ' ', m[1]), split(m[2])
    if len(set(params))!=len(params) or any(not re.fullmatch(ID,p) for p in params):
        raise CleanError('Invalid or duplicate parameters')
    if name in env.data['functions']: raise CleanError('Duplicate visible name: '+name)
    local, implicit, types, other = {}, {}, {}, []
    for field in fields:
        decl = re.fullmatch(r'Let\s+('+ID+r'):\s*(.+)', field, re.I)
        if not decl:
            other.append(field); continue
        n, text = decl[1], decl[2]
        if n in local: raise CleanError('Duplicate parameter: '+n)
        t = Type('Type') if text=='Type' else env.type(text,local)
        if n not in params:
            if types or t not in (NAT,Type('Type')): raise CleanError('Implicit dimensions/types must precede arguments')
            implicit[n] = t
        else: types[n] = t
        local[n] = Expr(n,n,t)
    values = fields_map(other)
    if list(types)!=params or not {'returns','means'} <= values.keys():
        raise CleanError('Declare parameters in header order and provide Returns, Means, Render')
    renders = set(values)&{'render','render latex'}
    if len(renders)!=1 or values.keys()-{'returns','means','render','render latex'}:
        raise CleanError('Provide exactly one Render or Render latex field')
    result = env.type(values['returns'],local)
    render = next(iter(renders))
    latex = template(values[render],params,plain=render=='render')
    signature=' '.join('{'+n+' : '+('Type' if t==Type('Type') else env.render_type(t,'lean'))+'}' for n,t in implicit.items())
    signature+=' '+ ' '.join(f'({p} : {env.render_type(types[p],"lean")})' for p in params)
    body=f'{signature} : {env.render_type(result,"lean")} :=\n  {values["means"]}'
    key=add_definition(env,'cleanNotation_',name,body)
    def pattern(t):
        return re.sub(ID, lambda m: '$'+m[0] if m[0] in implicit else m[0], str(t))
    # Every implicit parameter must be inferable from argument types.
    for n in implicit:
        if not any(re.search(r'\b'+re.escape(n)+r'\b',str(t)) for t in types.values()):
            raise CleanError('Implicit parameter is absent from argument types: '+n)
    env.data['functions'][name]={'params':[pattern(types[p]) for p in params], 'returns':pattern(result),
        'lean':key+''.join(' ({'+str(i)+'})' for i in range(len(params))), 'latex':latex}


def load_module(path, env, *, document=False):
    """Resolve imports into an explicitly provided, initially empty environment."""
    active=[]
    def visit(file, root=False):
        file=file.resolve()
        if file in active: raise CleanError('Cyclic Clean import: '+' -> '.join(map(str,active+[file])))
        if file in env.loaded_modules: return ''
        active.append(file)
        try:
            lines=normalize_layout(file.read_text()).splitlines()
        except CleanError as e:
            raise CleanError(f'{file}: {e}') from e
        output=['']*len(lines); i=0; started=False
        while i<len(lines):
            line=lines[i]
            if not line.strip() or line.lstrip().startswith('#'): i+=1; continue
            origin=f'{file}:{i+1}'
            try:
                if '\t' in line: raise CleanError('Tabs are not allowed')
                li=re.fullmatch(r'Import Lean\s+([A-Za-z_][\w.]*)',line,re.I)
                bi=re.fullmatch(r'Import BibTeX\s+"([^"\n]+)"',line,re.I)
                ci=re.fullmatch(r'Import\s+"([^"\n]+)"',line,re.I)
                block=re.match(r'(Notation|Type|Source)\s',line,re.I)
                alias=re.fullmatch(r'Alias\s+('+ID+r'):\s*('+ID+r')',line,re.I)
                phrase=re.fullmatch(r'Phrase\s+(.+?)\s+=>\s+(.+)',line,re.I)
                if any((li,bi,ci,block,alias,phrase)):
                    if started: raise CleanError('Imports and declarations must precede results')
                    if li:
                        if li[1] not in env.lean_imports: env.lean_imports.append(li[1])
                    elif bi: env.sources.import_bibtex(file.parent/bi[1])
                    elif ci: visit(file.parent/ci[1])
                    elif alias:
                        if alias[1] in env.data['types'] or alias[1] in env.data['aliases']: raise CleanError('Duplicate type alias')
                        if alias[2] not in env.data['types']: raise CleanError('Unknown alias target')
                        env.data['aliases'][alias[1]]=alias[2]
                    elif phrase:
                        re.compile(phrase[1])
                        env.data['phrases'].append({'pattern':phrase[1],'type':phrase[2]})
                    else:
                        fields=[];j=i+1
                        while j<len(lines) and (not lines[j].strip() or lines[j][0].isspace() or lines[j].lstrip().startswith('#')):
                            f=lines[j]
                            if f.strip() and not f.lstrip().startswith('#'):
                                if not f.startswith('    ') or f.startswith('     '): raise CleanError('Declaration fields must align at one indentation level')
                                fields.append(f.strip())
                            j+=1
                        kind=block[1].lower()
                        if kind=='notation': notation(line,fields,env)
                        elif kind=='type': type_declaration(line,fields,env)
                        else:
                            m=re.fullmatch(r'Source\s+('+ID+r'):',line,re.I)
                            if not m: raise CleanError('Invalid Source header')
                            env.sources.declare(m[1],fields_map(fields),file.parent)
                        i=j;continue
                else:
                    if not root: raise CleanError('Imported modules may contain only declarations and imports')
                    started=True;output[i]=line
                i+=1
            except (ValueError,KeyError) as e: raise CleanError(f'{origin}: {e}') from e
        active.pop();env.loaded_modules.add(file)
        return '\n'.join(output)
    return visit(Path(path),root=document)


def load_document(path, env):
    return parse(load_module(path, env, document=True),env)
