# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Explicit carrier-owned numeral atoms; never infer a carrier from digits."""
from .core import CleanError,Type,Expr


def digits(text):
    if not isinstance(text,str) or not text or any(c not in '0123456789' for c in text):
        raise CleanError('Explicit numeral annotations require ASCII digits')
    return text.lstrip('0') or '0'


def type_source(node):
    from .syntax import condition_spelling
    kind=node[0]
    if kind in ('Name','Numeral'):return node[1]
    if kind=='Projection':return type_source(node[1])+'.'+node[2]
    if kind=='Apply':return node[1]+'('+','.join(type_source(a) for a in node[2])+')'
    if kind=='BoundTypeApply':return node[1]+'('+node[2]+': '+type_source(node[3])+','+type_source(node[4])+')'
    if kind=='ComputedIndex':return '('+condition_spelling(node[1])+')'
    raise CleanError('Unsupported numeral carrier syntax: '+kind)


def spelling(tree,*,canonical_digits=False):
    value=digits(tree[1]) if canonical_digits else tree[1]
    if len(tree)>4 and tree[4] in ('inferred','defaulted'):return value
    carrier=type_source(tree[2]) if tree[0]=='NumeralAnnotation' else tree[2]
    return '('+value+': '+carrier+')'


def identity(name,env):
    spec=env.data['types'].get(name)
    if spec is None or spec.get('args') or spec.get('universe')!=0 or 'canonical' in spec:
        raise CleanError('Numerals requires a closed module Type-0 carrier')
    attachment=spec.get('numerals')
    if attachment is None:raise CleanError('Carrier has no Numerals declaration: '+name)
    env.render_type(Type(name),'lean')
    carrier=spec['native_binding'];constructor=attachment['native_binding']
    expected=f'noncomputable def {constructor} (digits : Nat) : _root_.{carrier} :=\n  ({attachment["payload"]}) digits\n'
    if attachment['carrier_binding']!=carrier or attachment['native_declaration']!=expected or env.notation_definitions.get(constructor)!=expected:
        raise CleanError('Changed or missing numeral constructor: '+name)
    return [carrier,spec['native_declaration'],spec['native_template'],constructor,expected,attachment['payload']]


def bind(tree,env,locals):
    digits(tree[1])
    if tree[0]=='BoundNumeral':
        if tree[3]!=identity(tree[2],env):raise CleanError('Changed bound numeral carrier or constructor: '+tree[2])
        return tree
    typ=env.type(type_source(tree[2]),locals,phrases=False)
    if type(typ) is not Type or typ.args:
        raise CleanError('Numerals requires a closed module Type-0 carrier')
    return ['BoundNumeral',tree[1],typ.name,identity(typ.name,env)]


def elaborate(tree,env,locals):
    if tree[0]=='NumeralAnnotation':
        from .exact_literals import explicit
        selected=explicit(tree,env,locals)
        if selected is not None:return selected
    bound=bind(tree,env,locals)
    typ=Type(bound[2]);constructor=bound[3][3]
    lean='(_root_.'+constructor+' (nat_lit '+digits(bound[1])+'))'
    tex=bound[1] if len(bound)>4 and bound[4]=='inferred' else r'\left('+bound[1]+r' \: : \: '+env.render_type(typ,'latex')+r'\right)'
    return Expr(lean,tex,typ,tree=bound)

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
