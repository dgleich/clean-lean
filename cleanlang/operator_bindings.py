# generated: gpt-6 2026-11-07 role=assisted; isolated prototype
import re
from dataclasses import replace
from .core import CleanError,SignatureMismatch,NUM,Type,LocalType,split,Expressions
ALIASES={'!=':'≠','<=':'≤','>=':'≥','and':'∧','or':'∨'}
TOKENS={'↔','→','∨','∧','=','≠','<','>','≤','≥','∈','⊆','∣','+','-','∪','∩','*','/','^'}
def token(text,fixity='infix'):
    if fixity=='prefix':
        result='¬' if text.lower()=='not' else text
        if result not in {'-','¬'}:raise CleanError('Prefix requires one supported operator token')
        return result
    result=ALIASES.get(text.lower(),text)
    if result not in TOKENS:raise CleanError('Infix requires one supported operator token')
    return result

def validate(text,arity,fixity='infix'):
    token(text,fixity)
    expected=1 if fixity=='prefix' else 2
    if arity!=expected:raise CleanError(fixity.title()+' requires exactly '+('one explicit operand' if expected==1 else 'two explicit operands'))

def declare(env,text,name,fixity='infix'):
    op=token(text,fixity)
    attribute='prefix_overloads' if fixity=='prefix' else 'operator_overloads'
    if not hasattr(env,attribute):setattr(env,attribute,{})
    getattr(env,attribute).setdefault(op,[]).append(name)
    env.data['functions'][name]['operator_presentation']=[fixity,text]

def match(env,pattern,actual,bindings):
    if pattern.startswith('$'):
        if isinstance(actual,Type) and env.sort_level(actual)!=1:return False
        if pattern in bindings:return bindings[pattern]==actual
        bindings[pattern]=actual
        return True
    parsed=re.fullmatch(r'(\w+)(?:\((.*)\))?',pattern)
    if parsed is None:raise CleanError('Invalid operator signature: '+pattern)
    children=split(parsed[2] or '')
    if not isinstance(actual,Type) or isinstance(actual,LocalType) or actual.name!=parsed[1] or len(actual.args)!=len(children):return False
    for child,value in zip(children,actual.args):
        if isinstance(value,Type) or child.startswith('$'):
            if not match(env,child,value,bindings):return False
        elif child!=value:return False
    return True

def apply(env,text,a,b,locals):
    op=token(text)
    if NUM in (a.type,b.type):raise CleanError('Operator numeral interpretation is not specified in this prototype')
    result=select(env,op,[a,b],locals,getattr(env,'operator_overloads',{}))
    result.operator_binding=(result.tree[1],env.data['functions'][result.tree[1]]['lean'],['infix',op])
    result.tree=['Operator',op,a.tree,b.tree]
    return result

def apply_prefix(env,text,a,locals):
    op=token(text,'prefix')
    if a.type==NUM:raise CleanError('Operator numeral interpretation is not specified in this prototype')
    result=select(env,op,[a],locals,getattr(env,'prefix_overloads',{}))
    result.operator_binding=(result.tree[1],env.data['functions'][result.tree[1]]['lean'],['prefix',text])
    result.tree=['Unary',text,a.tree]
    return result

def select(env,op,args,locals,overloads):
    candidates=[];checked={}
    for name in overloads.get(op,[]):
        spec=env.data['functions'][name];bindings={}
        if 'dependent_signature' in spec:
            owner=object()
            try:checked[name]=env.dependent_call(name,spec,args,dict(locals),mismatch_owner=owner)
            except SignatureMismatch as error:
                if error.owner is not owner:raise
                continue
            candidates.append(name)
        elif all(match(env,formal,actual.type,bindings) for formal,actual in zip(spec['params'],args)):
            candidates.append(name)
    if not candidates:
        from .numeral_inference import mismatch
        mismatch(env,'No declared meaning for operator '+op)
    if len(candidates)>1:raise CleanError('Ambiguous operator '+op+': '+', '.join(sorted(candidates)))
    selected=candidates[0]
    return checked[selected] if selected in checked else env.call(selected,args,locals)

def scope_snapshot(env):
    return tuple((fixity,tuple(sorted((op,tuple(sorted(env.data['functions'][name]['lean'].split()[0]
                        for name in names))) for op,names in getattr(env,attribute,{}).items())))
                 for fixity,attribute in [('infix','operator_overloads'),('prefix','prefix_overloads')])

def scope_unchanged(env,definition):
    return definition.get('operator_scope',scope_snapshot(env))==scope_snapshot(env)


def present(env,name,args,result,presentation=None):
    """One precedence-aware renderer for named, operator and stored adapter calls."""
    spec=env.data['functions'][name]
    presentation=presentation or spec.get('operator_presentation')
    if presentation is None:return result
    fixity,text=presentation
    op=token(text,fixity)
    if fixity=='prefix':
        if len(args)!=1:raise CleanError('Bound prefix operator requires one operand')
        precedence=7 if op=='-' else 5
        rendered=[replace(args[0],tex=r'\left('+args[0].tex+r'\right)') if args[0].precedence<=precedence else args[0]]
    else:
        if len(args)!=2:raise CleanError('Bound infix operator requires two operands')
        precedence=Expressions.PREC.get(op,5)
        right_associative=op in ('^','→')
        rendered=[]
        for right,value in enumerate(args):
            needs=value.precedence<precedence or value.precedence==precedence and bool(right)!=right_associative
            rendered.append(replace(value,tex=r'\left('+value.tex+r'\right)') if needs else value)
    result.tex=spec['latex'].format(*(a.tex for a in rendered))
    result.precedence=precedence
    return result


def apply_bound(env,name,args,locals,presentation):
    """Instantiate one retained adapter, preserving its original presentation."""
    return present(env,name,args,env.call(name,args,locals),presentation)

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
