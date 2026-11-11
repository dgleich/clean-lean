# generated: gpt-6 2026-11-10 role=assisted
"""Retained literal identity and checked replay, including versioned index payloads."""
from .core import CleanError,Expressions
from .annotations import Annotation,checked

def snapshot(name,env):
    spec=env.data['functions'].get(name)
    if spec is None or 'literal' not in spec:raise CleanError('Missing literal declaration: '+name)
    data=spec['literal'];key=spec['native_binding']
    return [key,spec['lean'],env.notation_definitions.get(key),data['digits'],
            repr(spec['signature_tree']),repr(spec.get('dependent_signature')),
            repr(data['result']),list(data['parameters'])]

def make(source,name,bindings,env,locals):
    from .inferred_conversion import reify_parameter
    from .bound_calls import bind
    from .numerals import digits,type_source
    spec=env.data['functions'][name]
    arguments=[[p[1],p[3],bind(reify_parameter(bindings[p[1]],p,env,locals).tree,env,locals,binders=True)]
               for p in spec['signature_tree'][2]]
    return ['BoundLiteral',digits(source[1]),source[1],name,snapshot(name,env),arguments,
            checked(type_source(source[2]),env,locals),'explicit']

def rebuild(tree,visit,annotation=None):
    return [*tree[:5],[[name,visibility,visit(value)] for name,visibility,value in tree[5]],
            tree[6] if annotation is None else annotation,tree[7]]

def names(tree,visit):
    if not isinstance(tree[6],Annotation):raise CleanError('Literal annotation lost its checked binding')
    return set(tree[6].names)|set().union(*(visit(value) for _,_,value in tree[5]))

def spelling(tree,canonical=False):
    value=tree[1] if canonical else tree[2]
    return value if tree[7]=='inferred' else '('+value+': '+str(tree[6])+')'

def call(tree,env,locals):
    if len(tree)!=8 or tree[7] not in ('explicit','inferred','defaulted'):
        raise CleanError('Malformed literal binding')
    if tree[4]!=snapshot(tree[3],env):raise CleanError('Changed retained literal declaration: '+tree[3])
    if not isinstance(tree[6],Annotation):raise CleanError('Literal annotation lost its checked binding')
    from .numerals import digits
    if tree[1]!=digits(tree[2]) or tree[1]!=env.data['functions'][tree[3]]['literal']['digits']:
        raise CleanError('Changed retained literal digits')
    from .numeral_inference import holes
    if any(holes(value) for _,_,value in tree[5]):raise CleanError('Unresolved literal constructor argument')
    signature=env.data['functions'][tree[3]]['signature_tree'][2]
    if [(a,b) for a,b,_ in tree[5]]!=[(p[1],p[3]) for p in signature]:
        raise CleanError('Changed literal parameter telescope')
    arguments=[(n,v,Expressions(env,locals).elaborate(t)) for n,v,t in tree[5]]
    explicit=[value for _,visibility,value in arguments if visibility=='explicit']
    result=env.call(tree[3],explicit,locals)
    from .inferred_conversion import reify_parameter
    inferred=dict(result.inferred_args)
    for name,visibility,value in arguments:
        if visibility=='implicit':
            expected=reify_parameter(inferred[name],next(p for p in signature if p[1]==name),env,locals)
            if value.type!=expected.type or value.lean!=expected.lean:
                raise CleanError('Changed recovered literal argument: '+name)
    target=env.type(tree[6],locals,phrases=False)
    if result.type!=target:raise CleanError('Literal result differs from checked carrier')
    from .bound_calls import identity
    result.tree=['ModuleCall',tree[3],[a.tree for a in explicit],identity(env,tree[3])]
    return result

def elaborate(tree,env,locals):
    result=call(tree,env,locals)
    result.tree=tree
    result.tex=tree[2] if tree[7]=='inferred' else r'\left('+tree[2]+r'\: : \: '+env.render_type(result.type,'latex')+r'\right)'
    return result

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
