# generated: gpt-6 2026-11-07 role=assisted
"""Closed-universe carriers obtained from checked classified expressions."""
from .core import Type,LocalType,ComputedCarrier,Expressions,CleanError

def carrier(expression,env,locals):
    info=env.classifier_info(expression.type)
    if info is None:raise CleanError('Carrier expression must have a declared classifier type')
    from .conversion import comparison_normal_form
    normal=comparison_normal_form(expression,env,locals)
    if normal.tree[0] in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):return env.type(normal.tree[1],locals,phrases=False)
    if normal.tree[0]=='Local':return LocalType(normal.tree[1],(),normal.lean,info[1],info[0])
    from .indices import index_value
    return ComputedCarrier('$carrier',(index_value(expression,env,locals),),info[1],info[0])

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

def substitute_carrier(typ,bindings,env,locals):
    from .indices import substitute_index
    from .dependent_functions import index_tree
    index=substitute_index(typ.args[0],bindings,env,locals)
    value=Expressions(env,locals).elaborate(index_tree(index))
    if env.classifier_info(value.type)!=(typ.classifier,typ.universe):
        raise CleanError('Computed carrier changed classifier or universe')
    return carrier(value,env,locals)
