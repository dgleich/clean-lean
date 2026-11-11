# generated: gpt-6 2026-10-30 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Condition naming and depth-aware assumption lists; no mathematical name dispatch."""
# generated: gpt-6 2026-11-06 role=assisted; structural argument naming.
import re
import string
from .core import CleanError, ID, PROP, Expressions


def source_expression(tree):
    """Canonical label spelling from normalized expression trees; no target-text parsing."""
    kind=tree[0]
    if kind=='BoundLiteral':
        from .literal_binding import spelling
        return spelling(tree,canonical=True)
    if kind in ('NumeralAnnotation','BoundNumeral'):
        from .numerals import spelling
        return spelling(tree,canonical_digits=True)
    if kind=='ModuleCall' and len(tree)>4:
        from .bound_calls import source_operator
        return source_operator(tree,source_expression)
    if kind=='Local': return tree[1]
    if kind in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):
        from .type_values import spelling
        return spelling(tree)
    if kind=='Decimal': return tree[1].lstrip('0') or '0'
    if kind in ('Call','ModuleCall'): return tree[1]+'('+', '.join(map(source_expression,tree[2]))+')'
    if kind=='Projection': return source_expression(tree[1])+'.'+tree[2]
    if kind=='Apply': return source_expression(tree[1])+'('+', '.join(map(source_expression,tree[2]))+')'
    if kind in ('Forall','Exists'):
        keyword='for every' if kind=='Forall' else 'there exists'
        return keyword+' ('+tree[1]+': '+tree[2]+', '+source_expression(tree[3])+')'
    if kind=='Unary': return '('+tree[1]+' '+source_expression(tree[2])+')'
    if kind=='Operator': return '('+source_expression(tree[2])+' '+tree[1]+' '+source_expression(tree[3])+')'
    if kind=='Lambda': return 'function('+tree[1]+': '+tree[2]+', '+source_expression(tree[3])+')'
    raise CleanError('Unsupported AST in assumption name')


def name_template(text,name,params):
    if text is None: text=name+'('+', '.join('{'+p+'}' for p in params)+')'
    try:
        for literal,key,spec,conversion in string.Formatter().parse(text):
            if key is not None and (key not in params or spec or conversion):
                raise CleanError('Assumption name placeholders must be explicit condition parameters')
        if not text.strip(): raise CleanError('Empty assumption name')
    except ValueError as e: raise CleanError(str(e)) from e
    return text


def lean_name(label):
    # Underscores and spaces intentionally normalize alike. Other punctuation is
    # encoded, never discarded. Any remaining collisions are rejected by callers.
    label=re.sub(r'[_\s]+','_',label.strip())
    out=''.join(c if re.fullmatch(r'\w',c) else f'_u{ord(c):x}_' for c in label)
    if not out or out[0].isdigit(): out='h_'+out
    return out


def assumption_items(text,reg,env):
    from .syntax import parse, name as syntax_name, expression_tree
    syntax=parse(text,'assumptions')
    for item in syntax.children:
        label=syntax_name(item.children[0]) if len(item.children)==2 else None
        value=Expressions(reg,env).elaborate(expression_tree(item.children[-1]))
        if value.type!=PROP: raise CleanError('Assume requires a condition')
        if label is None:
            tree=value.tree
            from .core import ProofType, Type
            local=env.get(tree[1]) if tree[0]=='Call' else None
            shadows=local is not None and not isinstance(local.type,ProofType) and local.type!=Type('$unavailableProof')
            if tree[0]!='Call' or shadows or 'condition' not in reg.data['functions'].get(tree[1],{}):
                raise CleanError('Automatic assumption naming requires a declared Condition call; supply a label')
            condition=reg.data['functions'][tree[1]]['condition']
            args={p:source_expression(arg) for p,arg in zip(condition['parameters'],tree[2])}
            label=condition['assumption_name'].format(**args)
        label=' '.join(label.split())
        if not label: raise CleanError('Empty assumption name')
        yield label,lean_name(label),value
