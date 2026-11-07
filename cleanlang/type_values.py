"""Explicit Type 0 values and structural source substitution."""
from .core import Expr,Type,Expressions

def substitute(tree,bindings,environment,locals):
    from .hygiene import substitute as hygienic
    from .dependent_functions import tree_names
    from .inferred_conversion import reify
    needed=tree_names(tree)
    actuals={};types={}
    for name,value in bindings.items():
        if name not in needed:continue
        if isinstance(value,Type):types[name]=value
        elif isinstance(value,Expr):actuals[name]=value
        else:actuals[name]=reify(value,environment,locals)
    return hygienic(tree,actuals,environment,locals,types)

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
