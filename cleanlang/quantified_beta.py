# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Comparison-only immediate beta contraction in scoped proof conditions."""
from .core import Expr,Expressions,CleanError,texid
from .hygiene import substitute


def comparison_expression(expression,environment,locals):
    def eligible(tree):
        if not isinstance(tree,list) or not tree:return False
        kind=tree[0]
        if kind=='Lambda':return False
        if kind in ('Forall','Exists'):return eligible(tree[3])
        if kind=='Apply' and tree[1][0]=='Lambda' and len(tree[2])==1:
            return True
        return any(eligible(child) for child in tree if isinstance(child,list))
    if not eligible(expression.tree):return expression

    def walk(tree,scope):
        kind=tree[0]
        if kind in ('Forall','Exists'):
            from .dependent_functions import fresh_bound
            domain=environment.type(tree[2],scope,phrases=False)
            value=Expr(fresh_bound(environment,scope),texid(tree[1]),domain,tree=['Local',tree[1]])
            body=walk(tree[3],{**scope,tree[1]:value})
            return [kind,tree[1],tree[2],body]
        if kind=='Lambda':return tree
        if kind=='ModuleCall':rebuilt=[kind,tree[1],[walk(a,scope) for a in tree[2]],*tree[3:]]
        elif kind=='Call':rebuilt=[kind,tree[1],[walk(a,scope) for a in tree[2]]]
        elif kind=='Apply':rebuilt=[kind,walk(tree[1],scope),[walk(a,scope) for a in tree[2]]]
        elif kind=='Projection':rebuilt=[kind,walk(tree[1],scope),tree[2]]
        elif kind=='Operator':rebuilt=[kind,tree[1],walk(tree[2],scope),walk(tree[3],scope)]
        elif kind=='Unary':rebuilt=[kind,tree[1],walk(tree[2],scope)]
        else:return tree
        if kind=='Apply' and rebuilt[1][0]=='Lambda' and len(rebuilt[2])==1:
            # Recheck the complete application before discarding the binder.
            checked=Expressions(environment,scope).elaborate(rebuilt)
            actual=Expressions(environment,scope).elaborate(rebuilt[2][0])
            reduced=substitute(rebuilt[1][3],{rebuilt[1][1]:actual},environment,scope)
            result=Expressions(environment,scope).elaborate(reduced)
            if result.type!=checked.type:
                raise CleanError('Proof beta contraction requires an unchanged determined type')
            return walk(result.tree,scope)
        return rebuilt

    tree=walk(expression.tree,locals)
    if tree==expression.tree:return expression
    checked=Expressions(environment,locals).elaborate(tree)
    if checked.type!=expression.type:
        raise CleanError('Quantified beta comparison requires an unchanged determined type')
    return checked

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
