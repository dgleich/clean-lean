# generated: gpt-6 2026-10-30 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Condition naming and depth-aware assumption lists; no mathematical name dispatch."""
import re
import string
from .core import CleanError, ID, PROP, Expressions


def separated(text, delimiter):
    parts=[]; start=0; depth=0
    for i,c in enumerate(text):
        if c=='(': depth+=1
        elif c==')': depth-=1
        if depth<0: raise CleanError('Unmatched assumption parenthesis')
        if c==delimiter and depth==0:
            parts.append(text[start:i].strip()); start=i+1
    if depth: raise CleanError('Unmatched assumption parenthesis')
    parts.append(text[start:].strip())
    if any(not p for p in parts): raise CleanError('Empty assumption item or label')
    return parts


def source_expression(tree):
    """Canonical source spelling for every current expression AST constructor."""
    kind=tree[0]
    if kind=='Local': return tree[1]
    if kind=='Decimal': return tree[1].lstrip('0') or '0'
    if kind=='Call': return tree[1]+'('+', '.join(map(source_expression,tree[2]))+')'
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
    for item in separated(text,','):
        labelled=separated(item,':')
        if len(labelled)>2: raise CleanError('Multiple assumption label colons')
        if len(labelled)==2:
            label,expression=labelled
            if not re.fullmatch(ID+r'(?: +'+ID+r')*',label):
                raise CleanError('An explicit assumption label must contain identifier words')
        else: expression=item; label=None
        value=Expressions(reg,env).parse(expression)
        if value.type!=PROP: raise CleanError('Assume requires a condition')
        if label is None:
            tree=value.tree
            if tree[0]!='Call' or tree[1] in env or 'condition' not in reg.data['functions'].get(tree[1],{}):
                raise CleanError('Automatic assumption naming requires a declared Condition call; supply a label')
            condition=reg.data['functions'][tree[1]]['condition']
            args={p:source_expression(arg) for p,arg in zip(condition['parameters'],tree[2])}
            label=condition['assumption_name'].format(**args)
        label=' '.join(label.split())
        if not label: raise CleanError('Empty assumption name')
        yield label,lean_name(label),value
