# generated: gpt-6 2026-11-10 role=assisted
"""Explicit exact-literal selection with retained declared-constructor identity.

Unannotated joint operator/literal inference remains unsupported.
"""
from .core import Type,LocalType,ValueIndex,CleanError
from .numerals import digits,type_source

class Mismatch(Exception):pass

def formal(term,names):
    if isinstance(term,(LocalType,ValueIndex)) and term.name in names:return term.name
    if isinstance(term,str) and term in names:return term
    return None

def prepare(text,result,local,env):
    digit=digits(text)
    if type(result) is not Type or env.sort_level(result)!=1 or env.is_function_type(result):
        raise CleanError('Literal requires a declared Type-0 carrier result')
    direct=set()
    def visit(term):
        name=formal(term,local)
        if name is not None:direct.add(name)
        elif isinstance(term,Type):
            for arg in term.args:visit(arg)
    visit(result)
    missing=set(local)-direct
    if missing:raise CleanError('Literal parameter has no direct result occurrence: '+', '.join(sorted(missing)))
    return {'digits':digit,'result':result,'parameters':tuple(local)}

def recover(pattern,actual,parameters):
    bindings={}
    def walk(p,a):
        name=formal(p,parameters)
        if name is not None:
            if name in bindings and bindings[name]!=a:raise Mismatch()
            bindings[name]=a;return
        if isinstance(p,Type):
            if type(p) is not type(a) or p.name!=a.name or len(p.args)!=len(a.args):raise Mismatch()
            for x,y in zip(p.args,a.args):walk(x,y)
        elif isinstance(p,ValueIndex):
            # Final env.call result checking discharges computed/repeated indices
            # after every direct formal has been recovered. No arithmetic inversion.
            from .dependent_functions import occurs
            if not any(occurs(p,n) for n in parameters) and p!=a:raise Mismatch()
        elif p!=a:raise Mismatch()
    walk(pattern,actual)
    if set(bindings)!=set(parameters):raise Mismatch()
    return bindings

def explicit(tree,env,locals):
    text=digits(tree[1]);target=env.type(type_source(tree[2]),locals,phrases=False)
    matches=[]
    for name,spec in sorted(env.data['functions'].items()):
        attachment=spec.get('literal')
        if attachment is None or attachment['digits']!=text:continue
        key,template,declaration=attachment['snapshot']
        if (spec['native_binding'],spec['lean'],env.notation_definitions.get(key))!=(key,template,declaration):
            raise CleanError('Changed literal declaration: '+name)
        try:bindings=recover(attachment['result'],target,attachment['parameters'])
        except Mismatch:continue
        from .inferred_conversion import reify_parameter
        signature=spec['signature_tree'][2]
        args=[reify_parameter(bindings[p[1]],p,env,locals) for p in signature if p[3]=='explicit']
        value=env.call(name,args,locals)
        if value.type!=target:continue
        inferred=dict(value.inferred_args)
        if any(inferred.get(p[1])!=bindings[p[1]] for p in signature if p[3]=='implicit'):continue
        from .bound_calls import bind,identity
        from .literal_binding import make,elaborate
        value=elaborate(make(tree,name,bindings,env,locals),env,locals)
        matches.append(value)
    # Existing all-numeral carriers have equal priority with exact attachments.
    from .numerals import bind
    if type(target) is Type and not target.args and 'numerals' in env.data['types'].get(target.name,{}):
        bind(tree,env,locals)
        if matches:raise CleanError('Ambiguous literal interpretation')
        return None
    if len(matches)>1:raise CleanError('Ambiguous literal interpretation')
    if matches:return matches[0]
    return None

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
