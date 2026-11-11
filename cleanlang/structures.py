# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Finite authored records and explicit field references; no structural subtyping."""
import hashlib
import re
from .core import CleanError, Type, LocalType, ComputedCarrier, ProofType, ValueIndex, Expr, NAT, ID, texid, textext


def reference_name(tree):
    if not tree:return None
    if tree[0]=='Local':return tree[1]
    if tree[0]=='Projection':
        base=reference_name(tree[1])
        return base+'.'+tree[2] if base is not None else None
    return None


def substitute_type(t, bindings, env=None, locals=None):
    from .indices import ComputedIndex, substitute_index
    from .dependent_functions import DependentFunctionType,substitute
    if isinstance(t,DependentFunctionType):return substitute(t,bindings,env,locals)
    if isinstance(t,ComputedCarrier):
        from .carrier_types import substitute_carrier
        return substitute_carrier(t,bindings,env,locals)
    if isinstance(t,ProofType):return ProofType(substitute_index(t.args[0],bindings,env,locals))
    if isinstance(t,ComputedIndex):return substitute_index(t,bindings,env,locals)
    if isinstance(t,ValueIndex):
        if t.name in bindings:return bindings[t.name]
        if '.' in t.name and t.name.split('.',1)[0] in bindings:
            return substitute_index(t,bindings,env,locals)
        raise CleanError('Unresolved structure index: '+t.name)
    if isinstance(t,Type):
        if isinstance(t,LocalType) and t.name in bindings:
            value=bindings[t.name]
            if not isinstance(value,Type):raise CleanError('Expected type parameter: '+t.name)
            if env is not None:env.require_type_argument(value,t.universe)
            elif isinstance(value,LocalType) and value.universe!=t.universe:
                raise CleanError('Carrier substitution changed universe')
            elif t.universe!=0:raise CleanError('Higher carrier substitution requires an environment')
            return value
        if isinstance(t,LocalType):return t
        return Type(t.name,tuple(substitute_type(a,bindings,env,locals) for a in t.args))
    return bindings.get(t,t)


def projection_reduction(env, base, field, locals):
    """Reduce constructor fields and explicit, binder-free authored producers only."""
    from .core import Expressions
    tree=base.tree
    if not tree or tree[0] not in ('Call','ModuleCall'):return None
    # A local function wins over a module callable, even if names coincide.
    if tree[0]=='Call' and tree[1] in locals and env.is_function_type(locals[tree[1]].type):return None
    spec=env.structures[base.type.name]
    if tree[1]==spec['constructor']:
        position=len(spec['parameters'])+[n for n,_ in spec['fields']].index(field)
        return Expressions(env,locals).elaborate(tree[2][position])
    definition=env.definitions.get(tree[1])
    if not definition or definition['implementation']!='equals':return None
    from .operator_bindings import scope_unchanged
    if not scope_unchanged(env,definition) and definition.get('bound_tree') is None:return None
    signature=env.data['functions'][tree[1]]['signature_tree']
    parameters=signature[2]
    if any(p[3]=='implicit' for p in parameters):return None
    body=definition.get('bound_tree') or definition['tree']
    from .beta_indices import has_binder
    if has_binder(body):return None
    bindings=dict(zip((p[1] for p in parameters),tree[2]))
    def replace(node):
        if node[0] in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):
            from .type_values import substitute
            return substitute(node,{n:Expressions(env,locals).elaborate(t) for n,t in bindings.items()},env,locals)
        if node[0]=='Local':return bindings.get(node[1],node)
        if node[0]=='ModuleCall':return [node[0],node[1],[replace(a) for a in node[2]],*node[3:]]
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
    # Recover exactly the preceding fields needed by the selected field type.
    # Field telescopes are declaration-checked, so dependencies point backward.
    from .dependent_functions import occurs
    selected=next(i for i,(name,_) in enumerate(spec['fields']) if name==field)
    needed={field}
    for i in range(selected,-1,-1):
        name,typ=spec['fields'][i]
        if name in needed:
            needed.update(n for n,_ in spec['fields'][:i] if occurs(typ,n))
    for name,typ in spec['fields'][:selected+1]:
        if name not in needed:continue
        result_type=substitute_type(typ,bindings,env,locals)
        target='(@_root_.'+spec['key']+'.«'+name+'»'+''.join(' ('+v+')' for v in targets)+' ('+base.lean+'))'
        tex=base.tex+r'.\mathrm{'+textext(name)+'}'
        value=Expr(target,tex,result_type,tree=['Projection',base.tree,name])
        if name==field:return value
        from .indices import index_value
        if env.classifier_info(result_type) is not None:
            from .carrier_types import carrier
            bindings[name]=carrier(value,env,locals)
        else:bindings[name]=index_value(value,env,locals)
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
        t=env.type(spelling,local)
        kinds.append('type' if env.classifier_info(t) is not None else 'dimension' if t==NAT else
                     {'value':substitute(str(t),list(local))})
        params.append((n,t));local[n]=Expr('«'+n+'»',texid(n),t)
    members=[];metadata=[]
    for line in fields:
        if not re.match(r'Let\b',line,re.I):metadata.append(line);continue
        kind,names,spelling=let_clause(line)
        if kind!='let':raise CleanError('Structure fields require typed Let; defaults are not supported')
        t=env.type(spelling,local)
        for n in names:
            if n in local or n in env.data['types'] or n in env.data['aliases'] or n in ('mk','rec','recOn','casesOn'):
                raise CleanError('Structure field must be fresh: '+n)
            members.append((n,t));local[n]=Expr('«'+n+'»',texid(n),t)
    values=fields_map(metadata)
    if not members:raise CleanError('Structure requires at least one field')
    if 'constructor' not in values or values.keys()-{'constructor','render latex','describe','describe plural','universe'}:
        raise CleanError('Structure requires Constructor; optional Render latex, Describe, Describe plural and Universe')
    level=universe_level(values)
    for field_name,field_type in members:
        if env.sort_level(field_type)>level+1:
            raise CleanError('Structure field '+field_name+' exceeds declared Universe '+str(level))
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
    signature=' '.join('(«'+n+'» : '+(universe_sort(info[1]) if (info:=env.classifier_info(t)) is not None else env.render_type(t,'lean',local))+')' for n,t in params)
    body=signature+' : '+universe_sort(level)+' where\n'+''.join('  «'+n+'» : '+env.render_type(t,'lean',local)+'\n' for n,t in members)
    stem=''.join(c if c.isascii() and (c.isalnum() or c=='_') else f'_u{ord(c):x}_' for c in name)
    key='cleanStructure_'+stem+'_'+hashlib.sha256((name+body).encode()).hexdigest()[:20]
    if key in env.notation_definitions:raise CleanError('Generated structure identifier collision')
    spec={'args':kinds,'lean':'_root_.'+key+''.join(' ({'+str(i)+'})' for i in range(len(params))),
          'latex':template(values.get('render latex',r'\operatorname{{'+name+'}}'),pnames)}
    spec['parameter_names']=pnames
    spec['parameter_types']=[t for _,t in params]
    spec['universe']=level
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
    csig=' '.join('(«'+n+'» : '+(universe_sort(info[1]) if n in pnames and (info:=env.classifier_info(t)) is not None else 'Type' if t==Type('Type') else env.render_type(t,'lean',local))+')' for n,t in allparams)
    cbody=csig+' : '+env.render_type(result,'lean',local)+' :=\n  @_root_.'+key+'.mk'+''.join(' «'+n+'»' for n,_ in allparams)
    ckey=add_definition(env,'cleanConstructor_',constructor,cbody)
    env.data['functions'][constructor]={'params':[str(t) for _,t in allparams], 'returns':str(result),
        'native_binding':ckey,'lean':'_root_.'+ckey+''.join(' ({'+str(i)+'})' for i in range(len(allparams))),
        'latex':r'\operatorname{{'+textext(constructor).replace(' ',r'\ ')+'}}('+', '.join('{'+str(i)+'}' for i in range(len(allparams)))+')',
        'dependent_signature':{'implicit':[],'parameters':allparams,'result':result,'key':ckey},
        'signature_tree':['Constructor',constructor,name,[[n,str(t)] for n,t in allparams]]}
    from .callable_signatures import capture
    capture(env,constructor,((n,t,'explicit') for n,t in allparams),result)
    env.definitions[constructor]={'key':ckey,'parameters':list(local),'implementation':'generated constructor',
                                  'tree':env.data['functions'][constructor]['signature_tree'],
                                  'body':'@_root_.'+key+'.mk','returns':str(result),'attribution':None}
    return key

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
