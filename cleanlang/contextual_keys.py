# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Comparison-only congruence for checked callable applications. Never feeds expanded arguments to calls."""
from .core import Expressions,Type,ValueIndex,CleanError,NAT
from .binder_keys import Pool,key

def comparison_key(expression,env,locals,*,fresh=False):
    from .conversion import _normal_form
    from .bound_calls import identity
    from .inferred_conversion import reify
    pool=getattr(env,'_comparison_pool',None)
    previous=pool
    if pool is None:pool=Pool(env,locals,expression.tree)
    before=set(pool.owned);env._comparison_pool=pool
    def emit(value):
        original=value
        value=_normal_form(value,env,locals,fresh=True)
        if value.type!=original.type:raise CleanError('Contextual comparison changed a type')
        tree=value.tree;kind=tree[0]
        if kind not in ('Call','ModuleCall','Operator','Unary'):return value.lean
        if kind in ('Operator','Unary'):
            if value.operator_binding is None:raise CleanError('Missing operator binding')
            name,target,_=value.operator_binding
        else:
            name=tree[1]
            if kind=='Call' and name in locals and env.is_function_type(locals[name].type):return value.lean
            target=tree[3] if kind=='ModuleCall' else identity(env,name)
        if target!=identity(env,name):raise CleanError('Changed comparison callable')
        spec=env.data['functions'][name]
        if value.checked_args is None:raise CleanError('Missing freshly checked call arguments')
        arguments=[emit(arg) for arg in value.checked_args]
        if 'dependent_signature' not in spec:
            raw='('+spec['lean'].format(*(a.lean for a in value.checked_args))+')'
            if raw!=value.lean:raise CleanError('Unchecked comparison call template')
            return '('+spec['lean'].format(*arguments)+')'
        signature=spec['dependent_signature'];inferred=dict(value.inferred_args);implicit=[]
        for n,t in signature['implicit']:
            v=inferred[n]
            if t not in (NAT,Type('Type')):rendered=reify(v,env,locals).lean
            elif isinstance(v,Type):rendered=env.render_type(v,'lean',locals)
            elif isinstance(v,ValueIndex):rendered=v.lean
            elif v in locals:rendered=locals[v].lean
            else:rendered=v
            implicit.append(rendered)
        def template(args):return '(@_root_.'+signature['key']+''.join(' ('+v+')' for v in implicit+args)+')'
        if template([a.lean for a in value.checked_args])!=value.lean:
            raise CleanError('Unchecked dependent comparison call template')
        return template(arguments)
    try:
        # Allocate binder identities over the complete original expression first.
        from .beta_indices import has_binder
        checked=expression if fresh and not has_binder(expression.tree) else Expressions(env,locals).elaborate(expression.tree)
        if checked.type!=expression.type:raise CleanError('Comparison expression type changed')
        result=emit(checked)
        owned=pool.owned-before
        import re
        from .core import ID
        return key(result,owned) if any(t in owned for t in re.findall(ID,result)) else result
    finally:
        if previous is None:del env._comparison_pool
        else:env._comparison_pool=previous

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
