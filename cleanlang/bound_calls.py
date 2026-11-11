# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Internal module-call binding for checked computed indices."""
from .core import CleanError,Expr,texid,Expressions


class UnclosedBinding(CleanError):
    """This prototype cannot preserve every binding in the given constructor."""


def identity(env,name):
    spec=env.data['functions'].get(name)
    if spec is None:raise CleanError('Missing bound module callable: '+name)
    return spec['lean']


def bind(tree,env,locals,*,binders=False):
    kind=tree[0]
    if kind=='BoundLiteral':
        from .literal_binding import call
        call(tree,env,locals)
        return tree
    if kind in ('NumeralAnnotation','BoundNumeral'):
        from .numerals import bind as numeral
        return numeral(tree,env,locals)
    if kind=='ModuleCall':
        if tree[3]!=identity(env,tree[1]):raise CleanError('Changed bound module callable: '+tree[1])
        return [kind,tree[1],[bind(a,env,locals,binders=binders) for a in tree[2]],*tree[3:]]
    if kind=='Call':
        args=[bind(a,env,locals,binders=binders) for a in tree[2]]
        if tree[1] in locals and env.is_function_type(locals[tree[1]].type):
            return ['Apply',['Local',tree[1]],args]
        return ['ModuleCall',tree[1],args,identity(env,tree[1])]
    if kind=='Projection':return [kind,bind(tree[1],env,locals,binders=binders),tree[2]]
    if kind=='Apply':return [kind,bind(tree[1],env,locals,binders=binders),[bind(a,env,locals,binders=binders) for a in tree[2]]]
    if kind in ('Operator','Unary'):
        checked=Expressions(env,locals).elaborate(tree)
        if checked.operator_binding is None:raise CleanError('Missing checked operator binding')
        name,target,presentation=checked.operator_binding
        actuals=checked.tree[2:] if kind=='Operator' else [checked.tree[2]]
        return ['ModuleCall',name,[bind(a,env,locals,binders=binders) for a in actuals],target,presentation]
    if kind in ('Lambda','Forall','Exists') and binders:
        # Domain binding remains source-based; reject embedded calls rather than
        # silently closing a body while leaving its domain's calls unbound.
        from .annotations import checked
        annotation=checked(tree[2],env,locals)
        domain=annotation.typ
        value=Expr(tree[1],texid(tree[1]),domain,tree=['Local',tree[1]])
        return [kind,tree[1],annotation,bind(tree[3],env,{**locals,tree[1]:value},binders=True)]
    if kind in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):
        from .type_values import elaborate
        return elaborate(tree,env,locals).tree
    if kind=='Decimal':raise UnclosedBinding('Numeral binding requires a checked interpretation')
    if kind=='Local':return tree
    # Do not claim binding closure for source strings containing type expressions.
    raise UnclosedBinding('Bound callable prototype does not close '+kind)


def elaborate(tree,env,locals,arguments):
    if tree[3]!=identity(env,tree[1]):raise CleanError('Changed bound module callable: '+tree[1])
    if len(tree)>4:
        from .operator_bindings import apply_bound
        result=apply_bound(env,tree[1],arguments,locals,tree[4])
    else:result=env.call(tree[1],arguments,locals)
    result.tree=['ModuleCall',tree[1],[a.tree for a in arguments],*tree[3:]]
    return result

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md


def source_operator(tree,spell):
    fixity,text=tree[4]
    args=tree[2]
    if fixity=='prefix':return '('+text+' '+spell(args[0])+')'
    return '('+spell(args[0])+' '+text+' '+spell(args[1])+')'


def _bind_checked(expression,env,locals,*,binders=False):
    """Close synchronously checked operands; never called for saved/public Exprs."""
    tree=expression.tree
    kind=tree[0]
    if kind not in ('Call','ModuleCall','Operator','Unary') or expression.checked_args is None:
        return bind(tree,env,locals,binders=binders)
    args=[_bind_checked(a,env,locals,binders=binders) for a in expression.checked_args]
    if kind in ('Operator','Unary'):
        if expression.operator_binding is None:raise CleanError('Missing checked operator binding')
        name,target,presentation=expression.operator_binding
        if target!=identity(env,name):raise CleanError('Changed bound module callable: '+name)
        return ['ModuleCall',name,args,target,presentation]
    if kind=='ModuleCall':
        if tree[3]!=identity(env,tree[1]):raise CleanError('Changed bound module callable: '+tree[1])
        return [kind,tree[1],args,*tree[3:]]
    if tree[1] in locals and env.is_function_type(locals[tree[1]].type):
        return ['Apply',['Local',tree[1]],args]
    return ['ModuleCall',tree[1],args,identity(env,tree[1])]
