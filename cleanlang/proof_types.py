# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Prototype scoped evidence indices and a source-derived callable view."""
from dataclasses import dataclass,field
import json
from .core import ProofType,Expr,Expressions,PROP,texid
from .indices import ComputedIndex

@dataclass(frozen=True,eq=False)
class ProofIndex(ComputedIndex):
    scope: tuple = field(default=(),compare=False)


def index(expression,env,locals):
    from .beta_indices import contract_index
    expression=contract_index(expression,env,locals)
    from .conversion import index_comparison
    from .syntax import condition_spelling
    from .quantified_beta import comparison_expression
    comparison=comparison_expression(expression,env,locals)
    return ProofIndex('('+condition_spelling(expression.tree)+')',expression.lean,expression.tex,
                      json.dumps(expression.tree,ensure_ascii=False),tuple(locals.items()),
                      comparison=index_comparison(comparison,env,locals))


def callable_view(typ,env):
    if not isinstance(typ,ProofType):return typ
    saved=typ.args[0]
    if not isinstance(saved,ProofIndex):return None
    from .hygiene import substitute
    from .conversion import _normal_form
    from .dependent_functions import fresh_bound,inferred_type
    scope=dict(saved.scope)
    tree=substitute(json.loads(saved.syntax),{},env,scope)
    condition=_normal_form(Expressions(env,scope).elaborate(tree),env,scope)
    if condition.tree[0]=='Operator' and condition.tree[1]=='→':
        left=Expressions(env,scope).elaborate(condition.tree[2])
        right=Expressions(env,scope).elaborate(condition.tree[3])
        return env.function_type(ProofType(index(left,env,scope)),ProofType(index(right,env,scope)))
    if condition.tree[0]!='Forall':return None
    _,name,annotation,body=condition.tree
    domain=env.type(annotation,scope,phrases=False)
    bound=fresh_bound(env,scope)
    scope[name]=Expr(bound,texid(name),domain,tree=['Local',name])
    result=Expressions(env,scope).elaborate(body)
    codomain=ProofType(index(result,env,scope))
    return inferred_type(name,bound,domain,codomain,env,scope)


def substitute_proof(saved,bindings,env,locals):
    from .hygiene import substitute
    from .core import Type,ValueIndex,CleanError
    from .dependent_functions import index_tree,tree_names
    from .syntax import parse,expression_tree
    captured=dict(saved.scope)
    used=tree_names(json.loads(saved.syntax))
    for name in sorted(used.intersection(captured).intersection(locals).difference(bindings)):
        before,after=captured[name],locals[name]
        if before.lean!=after.lean or before.type!=after.type:
            raise CleanError('Captured proof scope conflict: '+name)
    scope={**captured,**locals}
    values={}
    for k,v in bindings.items():
        if isinstance(v,Expr):values[k]=v
        elif isinstance(v,ValueIndex):values[k]=Expressions(env,locals).elaborate(index_tree(v))
        elif isinstance(v,str):values[k]=Expressions(env,locals).elaborate(expression_tree(parse(v,'expression')))
    types={k:v for k,v in bindings.items() if isinstance(v,Type)}
    tree=substitute(json.loads(saved.syntax),values,env,scope,types)
    tree=substitute(tree,{},env,scope)
    result=Expressions(env,scope).elaborate(tree)
    return index(result,env,scope)


def compatible_evidence(actual,expected,env,locals):
    """Compare determined types through callable views; never infer a parameter."""
    from .core import compatible
    from .dependent_functions import DependentFunctionType,substitute,fresh_source,fresh_bound
    if compatible(actual,expected):return True
    a=callable_view(actual,env) or actual
    b=callable_view(expected,env) or expected
    if compatible(a,b):return True
    if not env.is_function_type(a) or not env.is_function_type(b):return False
    ac=a.constructor if isinstance(a,DependentFunctionType) else a.name
    bc=b.constructor if isinstance(b,DependentFunctionType) else b.name
    if ac!=bc or not compatible_evidence(a.args[0],b.args[0],env,locals):return False
    name=fresh_source('clean_evidence_binder',env,locals,{'actual':a,'expected':b})
    value=Expr(fresh_bound(env,locals),texid(name),a.args[0],tree=['Local',name])
    scope={**locals,name:value}
    left=substitute(a.codomain,{a.binder:value},env,scope) if isinstance(a,DependentFunctionType) else a.args[1]
    right=substitute(b.codomain,{b.binder:value},env,scope) if isinstance(b,DependentFunctionType) else b.args[1]
    return compatible_evidence(left,right,env,scope)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
