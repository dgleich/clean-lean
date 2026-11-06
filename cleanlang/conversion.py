# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Bounded, deterministic comparison normalization; never rewrite emitted terms."""
from .core import Expr,Expressions,binary,Type


def shadowed_globals(environment,locals):
    return any((name in environment.data['functions'] and environment.is_function_type(value.type)) or
               (name in environment.data['types'] or name in environment.data['aliases']) and value.type==Type('Type')
               for name,value in locals.items())


def comparison_normal_form(expression,environment,locals):
    from .beta_indices import has_binder
    result=_normal_form(expression,environment,locals)
    # Call reconstruction must not turn hidden binders into authored actuals.
    # Final index keys use the separate whole-tree materialization below.
    return expression if has_binder(result.tree) else result


def index_comparison(expression,environment,locals):
    """Materialize one checked normal tree for comparison, including binders.

    Whole-tree elaboration assigns fresh compiler binder identities in one scope.
    The resulting template is never fed back as an authored actual argument.
    """
    result=_normal_form(expression,environment,locals)
    from .beta_indices import has_binder
    if not has_binder(result.tree):return result.lean
    from .binder_keys import Pool,key
    previous=getattr(environment,'_comparison_pool',None)
    pool=previous if previous is not None else Pool(environment,locals,result.tree)
    before=set(pool.owned)
    environment._comparison_pool=pool
    try:
        result=Expressions(environment,locals).elaborate(result.tree)
        if result.type!=expression.type:
            from .core import CleanError
            raise CleanError('Index comparison requires an unchanged determined type')
        return key(result.lean,pool.owned-before)
    finally:
        if previous is None:del environment._comparison_pool
        else:environment._comparison_pool=previous


def _normal_form(expression,environment,locals):
    env=environment
    elaborate=lambda tree:Expressions(env,locals).elaborate(tree)
    def normal(tree):return _normal_form(elaborate(tree),env,locals)
    tree=expression.tree
    if not tree:return expression
    kind=tree[0]
    if kind=='Local':
        local=locals.get(tree[1])
        if local is None or local.local_normal is None:return expression
        return _normal_form(local.local_normal,env,locals) if local.local_expand and not shadowed_globals(env,locals) else local.local_normal
    if kind in ('Decimal','Lambda','Forall','Exists'):return expression
    if kind=='Operator':return binary(tree[1],normal(tree[2]),normal(tree[3]))
    if kind=='Unary':
        a=normal(tree[2]);op='-' if tree[1]=='-' else '¬'
        return Expr('('+op+a.lean+')',expression.tex,expression.type,tree=['Unary',tree[1],a.tree])
    if kind=='Apply':
        f=normal(tree[1]);args=[normal(a) for a in tree[2]]
        result=Expr('('+f.lean+' '+args[0].lean+')',expression.tex,expression.type,
                    tree=['Apply',f.tree,[a.tree for a in args]])
        from .beta_indices import contract_index
        reduced=contract_index(result,env,locals)
        return _normal_form(reduced,env,locals) if reduced.tree!=result.tree else result
    if kind=='Projection':
        from .structures import project,projection_reduction
        from .beta_indices import has_binder
        base=normal(tree[1])
        if has_binder(base.tree):
            selected=projection_reduction(env,base,tree[2],locals)
            # An opaque producer cannot publish its hidden binders as field indices.
            return expression if selected is None else _normal_form(selected,env,locals)
        result=project(env,base,tree[2],locals)
        # project may reduce a constructor field; its result is already normalized
        # if it is a stable projection, otherwise normalize its selected expression.
        if result.tree==['Projection',base.tree,tree[2]]:return result
        return _normal_form(result,env,locals)
    if kind!='Call':return expression
    name=tree[1];args=[comparison_normal_form(elaborate(a),env,locals) for a in tree[2]]
    if name in locals and env.is_function_type(locals[name].type):
        head=normal(['Local',name])
        return Expr('('+head.lean+' '+args[0].lean+')',expression.tex,expression.type,
                    tree=['Apply',head.tree,[a.tree for a in args]])
    checked=env.call(name,args,locals)
    definition=env.definitions.get(name)
    if definition and definition['implementation']=='equals':
        parameters=env.data['functions'][name]['signature_tree'][2]
        implicit={p[1] for p in parameters if p[3]=='implicit'}
        body=definition['tree']
        from .dependent_functions import tree_names
        from .hygiene import substitute,UnrepresentableSubstitution
        if not shadowed_globals(env,locals):
            bindings=dict(zip((p[1] for p in parameters if p[3]=='explicit'),args))
            required=tree_names(body).intersection(implicit)
            inferred=dict(checked.inferred_args)
            from .inferred_conversion import reify,value_names
            type_bindings={};values=value_names(body)
            try:
                for p in parameters:
                    n=p[1]
                    if n not in required:continue
                    actual=inferred[n]
                    if isinstance(actual,Type):
                        type_bindings[n]=actual
                        if n in values:bindings[n]=reify(actual,env,locals)
                    else:bindings[n]=reify(actual,env,locals)
                expanded_tree=substitute(body,bindings,env,locals,type_bindings)
            except UnrepresentableSubstitution:return checked
            expanded=(comparison_normal_form(bindings[body[1]],env,locals)
                      if body[0]=='Local' and body[1] in bindings else normal(expanded_tree))
            if expanded.type==expression.type:return expanded
    return checked

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md


def local_definition(name,value,environment,locals):
    """Freeze a binder-free definition's comparison value in its earlier scope."""
    from .core import texid
    def has_binder(node):
        if not isinstance(node,list):return False
        if node and isinstance(node[0],str) and node[0] in ('Lambda','Forall','Exists'):return True
        return any(has_binder(child) for child in node)
    result=Expr(name,texid(name),value.type)
    if not has_binder(value.tree):
        normal=_normal_form(value,environment,locals)
        if normal.type==value.type:
            result.local_expand=has_binder(normal.tree)
            result.local_normal=value if result.local_expand else normal
    return result
