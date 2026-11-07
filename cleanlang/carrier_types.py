# generated: gpt-6 2026-11-07 role=assisted; isolated prototype
"""Type-0 carriers obtained from checked type-valued expressions."""
from .core import Type,LocalType,CleanError

def carrier(expression,env,locals):
    if expression.type!=Type('Type'):raise CleanError('Carrier expression must have type Type')
    from .conversion import comparison_normal_form
    normal=comparison_normal_form(expression,env,locals)
    if normal.tree[0]=='TypeValue':return env.type(normal.tree[1],locals,phrases=False)
    if normal.tree[0]=='Local':return LocalType(normal.tree[1],(),normal.lean)
    from .indices import index_value
    return Type('$carrier',(index_value(expression,env,locals),))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
