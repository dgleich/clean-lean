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
        from .syntax import parse as syntax_parse
        parsed=syntax_parse(field,'field')
        key,value=(str(c).strip() for c in parsed.children)
        key=key.lower()
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
    from .syntax import parse as syntax_parse
    syntax=syntax_parse(header,'type_header')
    name=str(syntax.children[0])
    if name in env.data['types'] or name in env.data['aliases']:raise CleanError('Duplicate type: '+name)
    names,kinds=[],[]
    parameters=syntax.children[1].children if len(syntax.children)>1 else []
    for parameter in parameters:
        p=str(parameter.children[0])
        kind=header[parameter.children[1].meta.start_pos:parameter.children[1].meta.end_pos].strip() if len(parameter.children)>1 else ''
        if kind not in ('Natural','Type') or p in names:raise CleanError('Type parameters require distinct names and Natural or Type kinds')
        names.append(p);kinds.append('dimension' if kind=='Natural' else 'type')
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
    sort={'Prop':'Sort 1', 'Type':'Type 1'}.get(values['means'],'Type')
    add_definition(env, 'cleanType_', name, f'{signature} : {sort} :=\n  {values["means"]}')


def signature_fields(header, fields):
    """Normalize the generated header AST before type/name resolution."""
    from .syntax import header as parse_header
    kind,name,parameters,result=parse_header(header)
    if kind not in ('notation','define'):raise CleanError('Expected Notation or Define')
    if result is None:
        if any(t is not None for _,t in parameters):raise CleanError('Expanded signatures require bare argument names')
        return name,[n for n,_ in parameters],list(fields)
    if any(re.match(r'(?:Let\b|Returns\s*:)', f,re.I) for f in fields):
        raise CleanError('Compact signatures cannot also contain Let or Returns fields')
    if any(t is None for _,t in parameters):raise CleanError('Every compact parameter requires name: Type')
    return name,[n for n,_ in parameters],['Let '+n+': '+t for n,t in parameters]+['Returns: '+result]+list(fields)


def notation(header, fields, env, *, authored=False):
    name, params, fields = signature_fields(header, fields)
    if len(set(params))!=len(params) or any(not re.fullmatch(ID,p) for p in params):
        raise CleanError('Invalid or duplicate parameters')
    if any(word.lower() in {'function','for','every','there','exists'} for word in name.split()):
        raise CleanError('Reserved expression binder word in declaration name: '+name)
    if name in env.data['functions']: raise CleanError('Duplicate visible name: '+name)
    local, implicit, types, other = {}, {}, {}, []
    for field in fields:
        if not re.match(r'Let\b',field,re.I):
            other.append(field);continue
        from .syntax import let_clause
        clause_kind,names,text=let_clause(field)
        if clause_kind!='let':raise CleanError('Declaration parameters require typed Let')
        # The group type is resolved before introducing any member of the group.
        t = Type('Type') if text=='Type' else env.type(text,local)
        for n in names:
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


def condition_declaration(header, fields, env):
    """A condition is an explicitly Prop-valued definition, not a hypothesis."""
    from .conditions import name_template
    truth=env.data['types'].get('Proposition',{})
    if truth.get('args') != [] or truth.get('lean','').strip() != 'Prop':
        raise CleanError('Condition requires the foundational Proposition binding to Lean Prop')
    from .syntax import header as parse_header
    kind,name,parameter_fields,result=parse_header(header)
    if kind!='condition' or result is not None:raise CleanError('Condition has no explicit return annotation')
    compact=any(t is not None for _,t in parameter_fields)
    if compact and any(t is None for _,t in parameter_fields):raise CleanError('Mixed condition parameter forms')
    parameters=', '.join(n+(': '+t if t is not None else '') for n,t in parameter_fields)
    values = fields_map([f for f in fields if not re.match(r'Let\b',f,re.I)])
    if 'returns' in values: raise CleanError('Condition already specifies a condition result; omit Returns')
    if set(values) - {'holds when','from lean','assumption name','render','render latex','attribution'}:
        raise CleanError('Unknown Condition field')
    if len(set(values) & {'holds when','from lean'}) != 1:
        raise CleanError('Condition requires exactly one Holds when or From Lean')
    params = [n for n,_ in parameter_fields]
    naming = name_template(values.get('assumption name'),name,params)
    transformed=[]
    for f in fields:
        key=f.split(':',1)[0].lower()
        if key=='assumption name': continue
        if key=='holds when': f='Equals:'+f.split(':',1)[1]
        transformed.append(f)
    normalized='Define '+name+'('+parameters+')'+(': Proposition:' if compact else ':')
    if not compact: transformed.append('Returns: Proposition')
    notation(normalized,transformed,env,authored=True)
    spec=env.data['functions'][name]
    spec['condition']={'parameters':params,'assumption_name':naming}
    spec['condition_tree']=['Condition',spec['signature_tree'],
        ['HoldsWhen',env.definitions[name]['tree']] if 'holds when' in values else ['FromLean',values['from lean']],
        ['AssumptionName',naming]]


def load_module(path, env, *, document=False):
    """Interpret generated module syntax; imports populate an explicit environment."""
    from .syntax import document as parse_document, parse as syntax_parse, fields as node_fields
    active=[]
    def visit(file,root=False):
        file=file.resolve()
        if file in active:raise CleanError('Cyclic Clean import: '+' -> '.join(map(str,active+[file])))
        if file in env.loaded_modules:return []
        active.append(file)
        try:
            try:
                normalized=normalize_layout(file.read_text())
                nodes=parse_document(normalized)
            except CleanError as e:raise CleanError(f'{file}: {e}') from e
            output=[];started=False
            for node in nodes:
                try:
                    if node.kind=='prose':
                        if root: output.append(node)
                        else: env.module_docs.append(node.payload)
                        continue
                    if node.kind in ('result','context'):
                        if not root:raise CleanError('Imported modules may contain only declarations and imports')
                        started=True
                        output.append(node);continue
                    if started:raise CleanError('Imports and declarations must precede results')
                    line=node.text
                    before=set(env.notation_definitions)
                    if node.kind=='import_stmt':
                        tree=syntax_parse(line,'import_line');value=str(tree.children[0])
                        if tree.data=='lean_import':
                            if value not in env.lean_imports:env.lean_imports.append(value)
                        elif tree.data=='bib_import':env.sources.import_bibtex(file.parent/value[1:-1])
                        else:visit(file.parent/value[1:-1])
                    elif node.kind=='alias_stmt':
                        alias,target=map(str,syntax_parse(line,'alias_line').children)
                        if alias in env.data['types'] or alias in env.data['aliases']:raise CleanError('Duplicate type alias')
                        if target not in env.data['types']:raise CleanError('Unknown alias target')
                        env.data['aliases'][alias]=target
                    elif node.kind=='phrase_stmt':
                        pattern,meaning=map(str,syntax_parse(line,'phrase_line').children)
                        pattern=pattern.strip();meaning=meaning.strip();re.compile(pattern)
                        env.data['phrases'].append({'pattern':pattern,'type':meaning})
                    else:
                        fields=node_fields(node.children)
                        kind=line.split(None,1)[0].lower()
                        if kind in ('notation','define'):notation(line,fields,env,authored=kind=='define')
                        elif kind=='condition':condition_declaration(line,fields,env)
                        elif kind=='type':type_declaration(line,fields,env)
                        else:
                            key=str(syntax_parse(line,'source_header').children[0])
                            env.sources.declare(key,fields_map(fields),file.parent)
                    if node.documentation:
                        keys=set(env.notation_definitions)-before
                        if len(keys)!=1:
                            raise CleanError('Documentation requires a declaration with one generated Lean definition')
                        env.declaration_docs[keys.pop()]=node.documentation
                        if root:
                            from .syntax import Node
                            output.append(Node('prose','',node.documentation.line,payload=node.documentation))
                except (ValueError,KeyError) as e:raise CleanError(f'{file}:{node.line}: {e}') from e
        finally:active.pop()
        env.loaded_modules.add(file)
        return output
    return visit(Path(path),root=document)


def load_document(path, env):
    return parse(load_module(path, env, document=True),env)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
