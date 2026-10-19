"""Explicit Clean modules: all mathematical names originate in declarations."""
import hashlib
import re
import string
from pathlib import Path
from .core import CleanError, ID, Expr, Type, NAT, parse, split, textext, normalize_layout, Expressions, compatible


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
    # Retain readable words; encode non-ASCII characters into a safe Lean identifier.
    stem = ''.join('_' if c == ' ' else c if c.isascii() and (c.isalnum() or c == '_')
                   else f'_u{ord(c):x}_' for c in name)
    key = prefix + stem + '_' + hashlib.sha256((name+body).encode()).hexdigest()[:20]
    if key in env.notation_definitions:
        raise CleanError('Generated Lean identifier collision: ' + key)
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


def signature_fields(header, fields):
    """Normalize compact syntax before any type/name resolution.

    The first balanced closing parenthesis ends the parameter list. Only the
    suffix decides between the expanded ':' and compact ': ReturnType:' forms.
    """
    match = re.match(r'(?:Notation|Define)\s+('+ID+r'(?: +'+ID+r')*)\(', header, re.I)
    if not match: raise CleanError('Invalid Notation or Define header')
    name = re.sub(' +', ' ', match[1])
    rest = header[match.end():]
    depth = 1
    for end, char in enumerate(rest):
        if char == '(': depth += 1
        elif char == ')': depth -= 1
        if depth == 0: break
    else: raise CleanError('Unclosed parameter list')
    parameters, suffix = rest[:end], rest[end+1:].strip()
    if suffix == ':':
        return name, split(parameters), list(fields)
    compact = re.fullmatch(r':\s*(.+?)\s*:', suffix)
    if not compact: raise CleanError('Expected : or : ReturnType: after parameters')
    if any(re.match(r'(?:Let\b|Returns\s*:)', field, re.I) for field in fields):
        raise CleanError('Compact signatures cannot also contain Let or Returns fields')
    parts = split(parameters)
    if parameters.rstrip().endswith(','):
        raise CleanError('Trailing comma in compact parameter list')
    names, declarations = [], []
    for part in parts:
        parameter = re.fullmatch(r'('+ID+r')\s*:\s*(.+)', part)
        if not parameter:
            raise CleanError('Every compact parameter requires name: Type')
        names.append(parameter[1])
        declarations.append('Let '+parameter[1]+': '+parameter[2])
    return name, names, declarations + ['Returns: '+compact[1]] + list(fields)


def notation(header, fields, env, *, authored=False):
    name, params, fields = signature_fields(header, fields)
    if len(set(params))!=len(params) or any(not re.fullmatch(ID,p) for p in params):
        raise CleanError('Invalid or duplicate parameters')
    if name in env.data['functions']: raise CleanError('Duplicate visible name: '+name)
    local, implicit, types, other = {}, {}, {}, []
    for field in fields:
        decl = re.fullmatch(r'Let\s+('+ID+r'(?:\s*,\s*'+ID+r')*)\s*(?::|\bbe\b)\s*(.+)', field, re.I)
        if not decl:
            other.append(field); continue
        text = decl[2]
        # The group type is resolved before introducing any member of the group.
        t = Type('Type') if text=='Type' else env.type(text,local)
        for n in split(decl[1]):
            if n in local: raise CleanError('Duplicate parameter: '+n)
            if n not in params:
                if types or t not in (NAT,Type('Type')): raise CleanError('Implicit dimensions/types must precede arguments')
                implicit[n] = t
            else: types[n] = t
            local[n] = Expr(n,n,t)
    values = fields_map(other)
    if list(types)!=params or 'returns' not in values:
        raise CleanError('Declare parameters in header order and provide Returns')
    implementations = set(values) & ({'equals', 'from lean'} if authored else {'means'})
    allowed = {'returns', 'render', 'render latex'} | ({'equals', 'from lean', 'attribution'} if authored else {'means'})
    if len(implementations) != 1 or values.keys() - allowed:
        raise CleanError('Provide exactly one Equals or From Lean' if authored else 'Provide Means')
    renders = set(values)&{'render','render latex'}
    if len(renders)>1 or (not authored and not renders):
        raise CleanError('Provide exactly one Render or Render latex field')
    result = env.type(values['returns'],local)
    implementation = next(iter(implementations))
    expression = None
    if implementation == 'equals':
        expression = Expressions(env, local).parse(values[implementation])
        if not compatible(expression.type, result):
            raise CleanError(f'Definition body has type {expression.type}; expected {result}')
        meaning = expression.lean
    else:
        meaning = values[implementation]
    attribution = None
    if 'attribution' in values:
        from .attribution import compact
        attribution = compact(values['attribution'])
        env.sources.resolve(attribution)
    if renders:
        render = next(iter(renders))
        latex = template(values[render],params,plain=render=='render')
    else:
        latex = r'\operatorname{{' + textext(name).replace(' ', r'\ ').replace('{','{{').replace('}','}}') + '}}(' + ', '.join('{'+str(i)+'}' for i in range(len(params))) + ')'
    signature=' '.join('{'+n+' : '+('Type' if t==Type('Type') else env.render_type(t,'lean'))+'}' for n,t in implicit.items())
    signature+=' '+ ' '.join(f'({p} : {env.render_type(types[p],"lean")})' for p in params)
    body=f'{signature} : {env.render_type(result,"lean")} :=\n  {meaning}'
    # Install the name only after its body is resolved: no recursion/forward references.
    def pattern(t):
        return re.sub(ID, lambda m: '$'+m[0] if m[0] in implicit else m[0], str(t))
    # Every implicit parameter must be inferable from argument types.
    for n in implicit:
        if not any(re.search(r'\b'+re.escape(n)+r'\b',str(t)) for t in types.values()):
            raise CleanError('Implicit parameter is absent from argument types: '+n)
    key=add_definition(env,'cleanDefine_' if authored else 'cleanNotation_',name,body)
    env.data['functions'][name]={'params':[pattern(types[p]) for p in params], 'returns':pattern(result),
        'lean':key+''.join(' ({'+str(i)+'})' for i in range(len(params))), 'latex':latex,
        'signature_tree':['Signature', name,
            [['Parameter', n, str(v.type), 'implicit' if n in implicit else 'explicit'] for n,v in local.items()],
            str(result)]}
    if authored:
        env.definitions[name] = {'key': key, 'parameters': list(local), 'implementation': implementation,
            'tree': expression.tree if expression else None,
            'body': values[implementation], 'returns': str(result), 'attribution': attribution}


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
                block=re.match(r'(Notation|Define|Type|Source)\s',line,re.I)
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
                        fields=[];j=i+1; expression_block=False
                        while j<len(lines) and (not lines[j].strip() or lines[j][0].isspace() or lines[j].lstrip().startswith('#')):
                            f=lines[j]
                            if f.strip() and not f.lstrip().startswith('#'):
                                if f.startswith('        ') and block[1].lower() == 'define':
                                    if not expression_block:
                                        raise CleanError('Only Equals expression blocks are implemented; From Lean must be inline')
                                    if f.startswith('         '):
                                        raise CleanError('Expression block lines must align')
                                    fields[-1] += ' ' + f.strip()
                                else:
                                    if not f.startswith('    ') or f.startswith('     '): raise CleanError('Declaration fields must align at one indentation level')
                                    fields.append(f.strip())
                                    expression_block = bool(re.fullmatch(r'Equals\s*:', f.strip(), re.I))
                            j+=1
                        kind=block[1].lower()
                        if kind in ('notation', 'define'): notation(line,fields,env,authored=kind=='define')
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
