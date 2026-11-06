# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Finite authored records and explicit field references; no structural subtyping."""
import hashlib
import re
from .core import CleanError, Type, ProofType, ValueIndex, Expr, NAT, ID, texid, textext


def reference_name(tree):
    if not tree:return None
    if tree[0]=='Local':return tree[1]
    if tree[0]=='Projection':
        base=reference_name(tree[1])
        return base+'.'+tree[2] if base is not None else None
    return None


def substitute_type(t, bindings, env=None, locals=None):
    from .indices import ComputedIndex, substitute_index
    if isinstance(t,ProofType):return ProofType(substitute_index(t.args[0],bindings,env,locals))
    if isinstance(t,ComputedIndex):return substitute_index(t,bindings,env,locals)
    if isinstance(t,ValueIndex):
        if t.name in bindings:return bindings[t.name]
        if '.' in t.name and t.name.split('.',1)[0] in bindings:
            return substitute_index(t,bindings,env,locals)
        raise CleanError('Unresolved structure index: '+t.name)
    if isinstance(t,Type):
        if not t.args and t.name in bindings:
            value=bindings[t.name]
            if not isinstance(value,Type):raise CleanError('Expected type parameter: '+t.name)
            return value
        return Type(t.name,tuple(substitute_type(a,bindings,env,locals) for a in t.args))
    return bindings.get(t,t)


def projection_reduction(env, base, field, locals):
    """Reduce constructor fields and explicit, binder-free authored producers only."""
    from .core import Expressions
    tree=base.tree
    if not tree or tree[0]!='Call':return None
    # A local function wins over a module callable, even if names coincide.
    if tree[1] in locals and env.is_function_type(locals[tree[1]].type):return None
    spec=env.structures[base.type.name]
    if tree[1]==spec['constructor']:
        position=len(spec['parameters'])+[n for n,_ in spec['fields']].index(field)
        return Expressions(env,locals).elaborate(tree[2][position])
    definition=env.definitions.get(tree[1])
    if not definition or definition['implementation']!='equals':return None
    signature=env.data['functions'][tree[1]]['signature_tree']
    parameters=signature[2]
    if any(p[3]=='implicit' for p in parameters):return None
    body=definition['tree']
    def has_binder(node):
        return isinstance(node,list) and (bool(node) and node[0] in ('Lambda','Forall','Exists')
            or any(has_binder(child) for child in node))
    if has_binder(body):return None
    bindings=dict(zip((p[1] for p in parameters),tree[2]))
    def replace(node):
        if node[0]=='Local':return bindings.get(node[1],node)
        if node[0]=='Call':
            args=[replace(a) for a in node[2]]
            if node[1] in bindings:
                callee=bindings[node[1]]
                if env.is_function_type(Expressions(env,locals).elaborate(callee).type):
                    return ['Call',callee[1],args] if callee[0]=='Local' else ['Apply',callee,args]
            return ['Call',node[1],args]
        if node[0]=='Projection':return ['Projection',replace(node[1]),node[2]]
        if node[0]=='Apply':return ['Apply',replace(node[1]),[replace(a) for a in node[2]]]
        if node[0]=='Operator':return ['Operator',node[1],replace(node[2]),replace(node[3])]
        if node[0]=='Unary':return ['Unary',node[1],replace(node[2])]
        return node
    return Expressions(env,locals).elaborate(['Projection',replace(body),field])


def project(env, base, field, locals):
    spec=env.structures.get(base.type.name)
    if spec is None:raise CleanError('Field access requires an authored structure; got '+str(base.type))
    ref=reference_name(base.tree)
    if field not in dict(spec['fields']):raise CleanError('Unknown field '+field+' of '+base.type.name)
    if ref is None:
        reduced=projection_reduction(env,base,field,locals)
        if reduced is not None:
            return Expr(reduced.lean,base.tex+r'.\mathrm{'+textext(field)+'}',reduced.type,tree=reduced.tree)
    bindings=dict(zip(spec['parameters'],base.type.args))
    targets=[env.render_type(a,'lean',locals) if isinstance(a,Type) else
             a.lean if isinstance(a,ValueIndex) else locals[a].lean if a in locals else a
             for a in base.type.args]
    for name,typ in spec['fields']:
        result_type=substitute_type(typ,bindings,env,locals)
        target='(@'+spec['key']+'.«'+name+'»'+''.join(' ('+v+')' for v in targets)+' ('+base.lean+'))'
        tex=base.tex+r'.\mathrm{'+textext(name)+'}'
        value=Expr(target,tex,result_type,tree=['Projection',base.tree,name])
        if name==field:return value
        from .indices import index_value
        bindings[name]=index_value(value,env,locals)
    raise CleanError('Missing field: '+field)


def declare(header, fields, env):
    from .syntax import parse, let_clause, structure_header
    from .modules import fields_map, template, substitute, add_definition, universe_level, universe_sort
    header_tree=structure_header(header)
    name=header_tree[1]
    if name in env.data['types'] or name in env.data['aliases']:
        raise CleanError('Duplicate type: '+name)
    params=[]; kinds=[]; local={}
    for n,spelling in header_tree[2]:
        if spelling is None:raise CleanError('Structure parameters require explicit types')
        if n in local or n in env.data['types'] or n in env.data['aliases']:
            raise CleanError('Structure parameter must be fresh: '+n)
        t=Type('Type') if spelling=='Type' else env.type(spelling,local)
        kinds.append('type' if t==Type('Type') else 'dimension' if t==NAT else
                     {'value':substitute(str(t),list(local))})
        params.append((n,t));local[n]=Expr('«'+n+'»',texid(n),t)
    members=[];metadata=[]
    for line in fields:
        if not re.match(r'Let\b',line,re.I):metadata.append(line);continue
        kind,names,spelling=let_clause(line)
        if kind!='let':raise CleanError('Structure fields require typed Let; defaults are not supported')
        t=env.type(spelling,local)
        if t==Type('Type'):raise CleanError('Carrier-type fields require higher-universe structures; use an explicit Type parameter for now')
        for n in names:
            if n in local or n in env.data['types'] or n in env.data['aliases'] or n in ('mk','rec','recOn','casesOn'):
                raise CleanError('Structure field must be fresh: '+n)
            members.append((n,t));local[n]=Expr('«'+n+'»',texid(n),t)
    values=fields_map(metadata)
    if not members:raise CleanError('Structure requires at least one field')
    if 'constructor' not in values or values.keys()-{'constructor','render latex','describe','describe plural','universe'}:
        raise CleanError('Structure requires Constructor; optional Render latex, Describe, Describe plural and Universe')
    level=universe_level(values)
    constructor=values['constructor']
    ctree=parse(constructor+'()','expression')
    # The same generated call grammar governs constructor names.
    from .syntax import expression_tree
    normalized=expression_tree(ctree)
    if normalized[0]!='Call' or normalized[2]:raise CleanError('Constructor must be an ordinary callable name')
    constructor=normalized[1]
    if constructor in env.data['functions'] or constructor in env.data['types'] or constructor in env.data['aliases'] or constructor==name:
        raise CleanError('Constructor must have a fresh callable name distinct from type names: '+constructor)
    pnames=[n for n,_ in params]
    signature=' '.join('(«'+n+'» : '+('Type' if t==Type('Type') else env.render_type(t,'lean',local))+')' for n,t in params)
    body=signature+' : '+universe_sort(level)+' where\n'+''.join('  «'+n+'» : '+env.render_type(t,'lean',local)+'\n' for n,t in members)
    stem=''.join(c if c.isascii() and (c.isalnum() or c=='_') else f'_u{ord(c):x}_' for c in name)
    key='cleanStructure_'+stem+'_'+hashlib.sha256((name+body).encode()).hexdigest()[:20]
    if key in env.notation_definitions:raise CleanError('Generated structure identifier collision')
    spec={'args':kinds,'lean':key+''.join(' ({'+str(i)+'})' for i in range(len(params))),
          'latex':template(values.get('render latex',r'\operatorname{{'+name+'}}'),pnames)}
    if level:spec['universe']=level
    for source,dest in [('describe','prose'),('describe plural','prose_plural')]:
        if source in values:spec[dest]=template(values[source],pnames)
    # Publish only after source-side signature validation. Lean checks the record's fixed sort.
    env.notation_definitions[key]='structure '+key+' '+body
    env.data['types'][name]=spec
    env.structures[name]={'key':key,'parameters':pnames,'parameter_types':params,'fields':members,
                          'constructor':constructor,
                          'tree':['Structure',name,[[n,str(t)] for n,t in params],
                                  [[n,str(t)] for n,t in members],constructor]}
    result=env.type(name+'('+','.join(pnames)+')' if pnames else name,local)
    allparams=params+members
    csig=' '.join('(«'+n+'» : '+('Type' if t==Type('Type') else env.render_type(t,'lean',local))+')' for n,t in allparams)
    cbody=csig+' : '+env.render_type(result,'lean',local)+' :=\n  @'+key+'.mk'+''.join(' «'+n+'»' for n,_ in allparams)
    ckey=add_definition(env,'cleanConstructor_',constructor,cbody)
    env.data['functions'][constructor]={'params':[str(t) for _,t in allparams], 'returns':str(result),
        'lean':ckey+''.join(' ({'+str(i)+'})' for i in range(len(allparams))),
        'latex':r'\operatorname{{'+textext(constructor).replace(' ',r'\ ')+'}}('+', '.join('{'+str(i)+'}' for i in range(len(allparams)))+')',
        'dependent_signature':{'implicit':[],'parameters':allparams,'result':result,'key':ckey},
        'signature_tree':['Constructor',constructor,name,[[n,str(t)] for n,t in allparams]]}
    env.definitions[constructor]={'key':ckey,'parameters':list(local),'implementation':'generated constructor',
                                  'tree':env.data['functions'][constructor]['signature_tree'],
                                  'body':'@'+key+'.mk','returns':str(result),'attribution':None}
    return key

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
