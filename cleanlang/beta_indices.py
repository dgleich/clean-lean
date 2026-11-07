# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Contract checked, immediately applied binder-free lambdas in type indices."""
from .core import Expressions, CleanError


def has_binder(tree):
    if isinstance(tree,list) and tree and tree[0]=='TypeValue':
        from .syntax import parse,type_tree
        def inside(node):
            if not isinstance(node,list):return False
            return bool(node) and node[0] in ('BoundTypeApply','Lambda','Forall','Exists') or any(inside(c) for c in node)
        return inside(type_tree(parse(tree[1],'type_ref')))
    return isinstance(tree,list) and (
        bool(tree) and tree[0] in ('Lambda','Forall','Exists') or
        any(has_binder(child) for child in tree))


def contract_index(expression, environment, locals):
    # The caller has elaborated the complete original expression, including the
    # lambda domain and actual argument. Never erase an unchecked argument.
    def reduce(tree):
        if not isinstance(tree,list) or not tree:return tree
        if tree[0] in ('Lambda','Forall','Exists'):return tree
        if tree[0]=='Apply':
            function=reduce(tree[1]);args=[reduce(a) for a in tree[2]]
            if (function[0]=='Lambda' and len(args)==1 and
                not has_binder(function[3]) and not has_binder(args[0])):
                name=function[1];actual=args[0]
                def substitute(body):
                    if body[0]=='TypeValue':
                        from .type_values import substitute as replace_type
                        return replace_type(body,{name:Expressions(environment,locals).elaborate(actual)},environment,locals)
                    if body[0]=='Local':return actual if body[1]==name else body
                    if body[0]=='ModuleCall':return [body[0],body[1],[substitute(a) for a in body[2]],*body[3:]]
                    if body[0]=='Call':
                        arguments=[substitute(a) for a in body[2]]
                        if body[1]==name:
                            return ['Apply',actual,arguments]
                        return ['Call',body[1],arguments]
                    if body[0]=='Projection':return ['Projection',substitute(body[1]),body[2]]
                    if body[0]=='Apply':return ['Apply',substitute(body[1]),[substitute(a) for a in body[2]]]
                    if body[0]=='Operator':return ['Operator',body[1],substitute(body[2]),substitute(body[3])]
                    if body[0]=='Unary':return ['Unary',body[1],substitute(body[2])]
                    return body
                return reduce(substitute(function[3]))
            return ['Apply',function,args]
        if tree[0]=='ModuleCall':return [tree[0],tree[1],[reduce(a) for a in tree[2]],*tree[3:]]
        if tree[0]=='Call':return ['Call',tree[1],[reduce(a) for a in tree[2]]]
        if tree[0]=='Projection':return ['Projection',reduce(tree[1]),tree[2]]
        if tree[0]=='Operator':return ['Operator',tree[1],reduce(tree[2]),reduce(tree[3])]
        if tree[0]=='Unary':return ['Unary',tree[1],reduce(tree[2])]
        return tree
    tree=reduce(expression.tree)
    if tree==expression.tree:return expression
    result=Expressions(environment,locals).elaborate(tree)
    if result.type!=expression.type:
        raise CleanError('Applied function index reduction requires an unchanged determined type')
    return result

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
