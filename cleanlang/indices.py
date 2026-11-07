# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Source-preserving indices with bounded comparison normalization."""
import json
from dataclasses import dataclass
from .core import ValueIndex, Type, CleanError

@dataclass(frozen=True, eq=False)
class ComputedIndex(ValueIndex):
    syntax: str


def index_value(expression,environment=None,locals=None):
    from .structures import reference_name
    from .syntax import expression_spelling
    if environment is not None:
        from .beta_indices import contract_index
        expression=contract_index(expression,environment,locals or {})
    tree=expression.tree
    def check(node):
        if not isinstance(node,list):return
        if node and node[0] in ('Lambda','Forall','Exists'):
            raise CleanError('Computed indices do not introduce binders')
        for child in node:check(child)
    check(tree)
    comparison=None
    if environment is not None:
        from .conversion import index_comparison
        comparison=index_comparison(expression,environment,locals or {})
    ref=reference_name(tree)
    if ref is not None:return ValueIndex(ref,expression.lean,expression.tex,comparison=comparison)
    return ComputedIndex('('+expression_spelling(tree)+')',expression.lean,expression.tex,
                         json.dumps(tree,ensure_ascii=False,separators=(',',':')),comparison=comparison)


def substitute_index(index,bindings,env,locals):
    from .core import Expressions,Expr
    from .syntax import parse,expression_tree
    tree=json.loads(index.syntax) if isinstance(index,ComputedIndex) else expression_tree(parse(index.name,'expression'))
    def reference(value):
        if isinstance(value,Expr):return value.tree
        if isinstance(value,ComputedIndex):return json.loads(value.syntax)
        if isinstance(value,ValueIndex):return expression_tree(parse(value.name,'expression'))
        if isinstance(value,Type):
            from .inferred_conversion import reify
            return reify(value,env,locals).tree
        return expression_tree(parse(str(value),'expression'))
    def replace(node):
        if node[0]=='TypeValue':
            from .type_values import substitute
            return substitute(node,bindings,env,locals)
        if node[0]=='Local' and node[1] in bindings:return reference(bindings[node[1]])
        if node[0]=='Call':
            args=[replace(a) for a in node[2]]
            value=bindings.get(node[1])
            # Call heads resolve to a local only when that local has Function type.
            # A same-named nonfunction parameter does not shadow a module callable.
            if isinstance(value,(Expr,ValueIndex)):
                callee=reference(value)
                actual=Expressions(env,locals).elaborate(callee)
                if env.is_function_type(actual.type):
                    if callee[0]=='Local':return ['Call',callee[1],args]
                    return ['Apply',callee,args]
            return ['Call',node[1],args]
        if node[0]=='Projection':return ['Projection',replace(node[1]),node[2]]
        if node[0]=='Apply':return ['Apply',replace(node[1]),[replace(a) for a in node[2]]]
        if node[0]=='Operator':return ['Operator',node[1],replace(node[2]),replace(node[3])]
        if node[0]=='Unary':return ['Unary',node[1],replace(node[2])]
        return node
    result=Expressions(env,locals).elaborate(replace(tree))
    return dimension_index(result,env,locals) if isinstance(index,DimensionIndex) else index_value(result,env,locals)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md


@dataclass(frozen=True, eq=False)
class DimensionIndex(ComputedIndex):
    """Natural-number slot, retaining its checked source expression."""


def dimension_index(expression,environment,locals):
    from .core import NAT,NUM
    if expression.type==NUM and expression.tree[0]=='Decimal':
        from .core import Expr
        expression=Expr(expression.lean,expression.tex,NAT,expression.precedence,expression.tree)
    if expression.type!=NAT:raise CleanError('Dimension reference must be Natural')
    from .conversion import comparison_normal_form
    def negative(node):
        if node[0]=='Unary' and node[1]=='-':return True
        if node[0]=='Operator':return negative(node[2]) or negative(node[3])
        return False
    if negative(comparison_normal_form(expression,environment,locals).tree):
        raise CleanError('Natural dimensions do not support unary negation')
    value=index_value(expression,environment,locals)
    syntax=value.syntax if isinstance(value,ComputedIndex) else json.dumps(expression.tree,ensure_ascii=False,separators=(',',':'))
    name=expression.tree[1] if expression.tree[0]=='Decimal' else value.name
    return DimensionIndex(name,value.lean,value.tex,syntax,comparison=value.comparison)
