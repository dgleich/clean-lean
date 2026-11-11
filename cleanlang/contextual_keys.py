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
    # A pool belongs to one synchronous comparison under fixed declarations.
    # Snapshot semantic local values rather than trusting object identity or
    # disposable checked-argument caches. Never persist this memo on Environment.
    from .comparison_snapshot import snapshot,SnapshotUnavailable
    memo=getattr(pool,'comparison_memo',None)
    if memo is None:pool.comparison_memo={};memo=pool.comparison_memo
    cache_key=None
    if previous is not None and expression.tree[0] in ('Call','ModuleCall','Operator','Unary','Apply','Projection'):
        try:
            cache_key=(snapshot((expression.tree,expression.type,expression.lean,
                              tuple(sorted(locals.items())))),frozenset(before))
        except SnapshotUnavailable:
            pass  # Optional reuse is not a semantic analysis or rejection gate.
        if cache_key is not None and cache_key in memo:return memo[cache_key]
    def stable_opaque(value):
        # Only called on freshly normalized children, within this fixed traversal.
        tree=value.tree
        if not tree:return False
        if tree[0]=='Local':
            local=locals.get(tree[1])
            return local is not None and local.local_normal is None
        if tree[0] in ('Decimal','BoundNumeral'):return True
        if tree[0] in ('Operator','Unary'):
            if value.operator_binding is None:return False
            name,target,_=value.operator_binding
            if target!=identity(env,name):raise CleanError('Changed comparison operator')
        elif tree[0] in ('Call','ModuleCall'):
            name=tree[1]
            if tree[0]=='Call' and name in locals:return False
        else:return False
        definition=env.definitions.get(name)
        if definition and definition['implementation']=='equals':return False
        if value.checked_args is None:return False
        return all(stable_opaque(arg) for arg in value.checked_args)
    def emit(value,normalized=False):
        original=value
        if not normalized:value=_normal_form(value,env,locals,fresh=True)
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
        arguments=[emit(arg,normalized=stable_opaque(arg)) for arg in value.checked_args]
        if 'dependent_signature' not in spec:
            raw='('+spec['lean'].format(*(a.lean for a in value.checked_args))+')'
            if raw!=value.lean:raise CleanError('Unchecked comparison call template')
            return '('+spec['lean'].format(*arguments)+')'
        signature=spec['dependent_signature'];inferred=dict(value.inferred_args);implicit=[]
        for n,t in signature['implicit']:
            v=inferred[n]
            if t!=NAT and env.classifier_info(t) is None:rendered=reify(v,env,locals).lean
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
        result=key(result,owned) if any(t in owned for t in re.findall(ID,result)) else result
        if cache_key is not None and pool.owned==before:
            # Eviction affects work only. A comparison that allocates identities
            # is never reusable, even when its emitted term hides those names.
            if len(memo)>=256:memo.clear()
            memo[cache_key]=result
        return result
    finally:
        if previous is None:del env._comparison_pool
        else:env._comparison_pool=previous

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
