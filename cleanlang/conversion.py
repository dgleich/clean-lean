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


def index_comparison(expression,environment,locals,*,_fresh=False):
    """Materialize one checked normal tree for comparison, including binders.

    Whole-tree elaboration assigns fresh compiler binder identities in one scope.
    The resulting template is never fed back as an authored actual argument.
    """
    result=_normal_form(expression,environment,locals,fresh=_fresh)
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



def _producer_field(expression,field,env,locals):
    """Select a checked authored producer field before normalizing sibling fields."""
    from .hygiene import substitute,UnrepresentableSubstitution
    from .dependent_functions import tree_names
    from .inferred_conversion import reify,value_names
    if shadowed_globals(env,locals):return None
    tree=expression.tree
    if not tree or tree[0] not in ('Call','ModuleCall'):return None
    spec=env.structures.get(expression.type.name)
    if spec is None:return None
    if tree[1]==spec['constructor']:
        pos=len(spec['parameters'])+[n for n,_ in spec['fields']].index(field)
        return Expressions(env,locals).elaborate(tree[2][pos])
    definition=env.definitions.get(tree[1])
    if not definition or definition['implementation']!='equals':return None
    from .operator_bindings import scope_unchanged
    if not scope_unchanged(env,definition) and not (tree[0]=='ModuleCall' and definition.get('bound_tree') is not None):return None
    parameters=env.data['functions'][tree[1]]['signature_tree'][2]
    body=definition.get('bound_tree') or definition['tree']
    bindings=dict(zip((p[1] for p in parameters if p[3]=='explicit'),
                      (Expressions(env,locals).elaborate(a) for a in tree[2])))
    inferred=dict(expression.inferred_args);required=tree_names(body);values=value_names(body);types={}
    try:
        for p in parameters:
            n=p[1]
            if p[3]!='implicit' or n not in required:continue
            actual=inferred[n]
            if isinstance(actual,Type):
                types[n]=actual
                if n in values:bindings[n]=reify(actual,env,locals)
            else:bindings[n]=reify(actual,env,locals)
        expanded=substitute(body,bindings,env,locals,types)
    except UnrepresentableSubstitution:return None
    if expanded[0] in ('Call','ModuleCall') and expanded[1]==spec['constructor']:
        pos=len(spec['parameters'])+[n for n,_ in spec['fields']].index(field)
        return Expressions(env,locals).elaborate(expanded[2][pos])
    value=Expressions(env,locals).elaborate(expanded)
    if value.type!=expression.type:return None
    return _producer_field(value,field,env,locals)

def _normal_form(expression,environment,locals,*,fresh=False):
    env=environment
    elaborate=lambda tree:Expressions(env,locals).elaborate(tree)
    def normal(tree):return _normal_form(elaborate(tree),env,locals,fresh=True)
    tree=expression.tree
    if not tree:return expression
    kind=tree[0]
    if kind=='Local':
        local=locals.get(tree[1])
        if local is None or local.local_normal is None:return expression
        return _normal_form(local.local_normal,env,locals) if local.local_expand and not shadowed_globals(env,locals) else local.local_normal
    if kind in ('NumeralAnnotation','BoundNumeral'):return elaborate(tree)
    if kind in ('Decimal','Lambda','Forall','Exists'):return expression
    if kind=='Operator':return env.operator(tree[1],normal(tree[2]),normal(tree[3]),locals)
    if kind=='Unary':
        from .operator_bindings import apply_prefix
        return apply_prefix(env,tree[1],normal(tree[2]),locals)
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
        selected=_producer_field(elaborate(tree[1]),tree[2],env,locals)
        if selected is not None and selected.type==expression.type:
            return _normal_form(selected,env,locals)
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
    if kind not in ('Call','ModuleCall'):return expression
    name=tree[1]
    # Only a synchronous elaboration in this traversal establishes freshness.
    # Public entry points and stored local definitions never set this flag.
    typed=expression.checked_args if fresh and expression.checked_args is not None else tuple(elaborate(a) for a in tree[2])
    from .beta_indices import has_binder
    args=[]
    for argument in typed:
        value=_normal_form(argument,env,locals,fresh=True)
        args.append(argument if has_binder(value.tree) else value)
    if kind=='Call' and name in locals and env.is_function_type(locals[name].type):
        head=normal(['Local',name])
        return Expr('('+head.lean+' '+args[0].lean+')',expression.tex,expression.type,
                    tree=['Apply',head.tree,[a.tree for a in args]])
    def unchanged(a,b):
        return (a.tree==b.tree and a.lean==b.lean and a.tex==b.tex and
                a.precedence==b.precedence and a.type==b.type and
                env.render_type(a.type,'lean',locals)==env.render_type(b.type,'lean',locals) and
                a.inferred_args==b.inferred_args)
    reuse=(fresh and expression.checked_args is not None and
           len(args)==len(expression.checked_args) and
           all(unchanged(a,b) for a,b in zip(args,expression.checked_args)))
    if kind=='ModuleCall':
        from .bound_calls import elaborate as bound_elaborate,identity
        from .core import CleanError
        # Retained calls have the same traversal-local freshness witness as
        # ordinary calls. Always validate the retained declaration identity,
        # even when the already checked call's arguments are unchanged.
        if tree[3]!=identity(env,name):raise CleanError('Changed bound module callable: '+name)
        checked=expression if reuse else bound_elaborate(tree,env,locals,args)
    else:checked=expression if reuse else env.call(name,args,locals)
    definition=env.definitions.get(name)
    if definition and definition['implementation']=='equals':
        from .operator_bindings import scope_unchanged
        if not scope_unchanged(env,definition) and not (kind=='ModuleCall' and definition.get('bound_tree') is not None):return checked
        parameters=env.data['functions'][name]['signature_tree'][2]
        implicit={p[1] for p in parameters if p[3]=='implicit'}
        body=definition.get('bound_tree') or definition['tree']
        from .dependent_functions import tree_names
        from .hygiene import substitute,UnrepresentableSubstitution
        if kind=='ModuleCall' and definition.get('bound_tree') is not None or not shadowed_globals(env,locals):
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
    from .beta_indices import has_binder
    result=Expr(name,texid(name),value.type)
    if not has_binder(value.tree):
        normal=_normal_form(value,environment,locals)
        if normal.type==value.type:
            result.local_expand=has_binder(normal.tree)
            result.local_normal=value if result.local_expand else normal
    return result
