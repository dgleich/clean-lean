# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Internal module-call binding for checked computed indices."""
from .core import CleanError,Expr,texid


class UnclosedBinding(CleanError):
    """This prototype cannot preserve every binding in the given constructor."""


def identity(env,name):
    spec=env.data['functions'].get(name)
    if spec is None:raise CleanError('Missing bound module callable: '+name)
    return spec['lean']


def bind(tree,env,locals,*,binders=False):
    kind=tree[0]
    if kind=='ModuleCall':
        if tree[3]!=identity(env,tree[1]):raise CleanError('Changed bound module callable: '+tree[1])
        return [kind,tree[1],[bind(a,env,locals,binders=binders) for a in tree[2]],tree[3]]
    if kind=='Call':
        args=[bind(a,env,locals,binders=binders) for a in tree[2]]
        if tree[1] in locals and env.is_function_type(locals[tree[1]].type):
            return ['Apply',['Local',tree[1]],args]
        return ['ModuleCall',tree[1],args,identity(env,tree[1])]
    if kind=='Projection':return [kind,bind(tree[1],env,locals,binders=binders),tree[2]]
    if kind=='Apply':return [kind,bind(tree[1],env,locals,binders=binders),[bind(a,env,locals,binders=binders) for a in tree[2]]]
    if kind=='Operator':return [kind,tree[1],bind(tree[2],env,locals,binders=binders),bind(tree[3],env,locals,binders=binders)]
    if kind=='Unary':return [kind,tree[1],bind(tree[2],env,locals,binders=binders)]
    if kind in ('Lambda','Forall','Exists') and binders:
        # Domain binding remains source-based; reject embedded calls rather than
        # silently closing a body while leaving its domain's calls unbound.
        from .annotations import checked
        annotation=checked(tree[2],env,locals)
        domain=annotation.typ
        value=Expr(tree[1],texid(tree[1]),domain,tree=['Local',tree[1]])
        return [kind,tree[1],annotation,bind(tree[3],env,{**locals,tree[1]:value},binders=True)]
    if kind=='TypeValue':
        from .annotations import checked
        return [kind,checked(tree[1],env,locals)]
    if kind in ('Local','Decimal'):return tree
    # Do not claim binding closure for source strings containing type expressions.
    raise UnclosedBinding('Bound callable prototype does not close '+kind)


def elaborate(tree,env,locals,arguments):
    if tree[3]!=identity(env,tree[1]):raise CleanError('Changed bound module callable: '+tree[1])
    result=env.call(tree[1],arguments,locals)
    result.tree=['ModuleCall',tree[1],[a.tree for a in arguments],tree[3]]
    return result

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
