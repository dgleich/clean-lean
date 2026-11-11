# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Explicit joint literal completion API; not yet the default elaborator."""
from .constraint_model import Incomplete,NoSolution,Ambiguous,Underdetermined


def complete(tree,env,locals,expected=None,*,limit=4096,use_default=True):
    """Return a checked retained Expr or a precise joint-analysis failure.

    Input must already be parsed; env/locals are explicit and fixed for the call.
    Unsupported candidates raise Incomplete, never fall back to another solver.
    The ordinary Expressions.elaborate entry point is unchanged.
    """
    from .clean_rows import Builder
    try:
        return Builder(env,dict(locals),limit).materialize(tree,expected,use_default=use_default)
    except RecursionError as error:
        raise Incomplete('Joint completion recursion limit exceeded') from error

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
