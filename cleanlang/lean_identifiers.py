# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Lexical quoting of validated source identifiers; never rewrite native code."""
from .core import CleanError

def quoted(name):
    if not name or any(c in name for c in '«»\r\n'):
        raise CleanError('Cannot quote invalid Lean identifier')
    return '«'+name+'»'

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
