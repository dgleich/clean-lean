# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Bounded, deterministic comparison normalization; never rewrite emitted terms."""
from .core import Expr,Expressions,binary,Type


def shadowed_globals(environment,locals):
    return any((name in environment.data['functions'] and environment.is_function_type(value.type)) or
               (name in environment.data['types'] or name in environment.data['aliases']) and environment.classifier_info(value.type) is not None
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
    from .contextual_keys import comparison_key
    return comparison_key(expression,environment,locals,fresh=_fresh)



def _producer_field(expression,field,env,locals,*,fresh=False):
    """Select a checked authored producer field before normalizing sibling fields."""
    from .hygiene import substitute,UnrepresentableSubstitution
    from .dependent_functions import tree_names
    from .inferred_conversion import reify,value_names
    if shadowed_globals(env,locals):return None
    tree=expression.tree
    if not tree or tree[0] not in ('Call','ModuleCall'):return None
    spec=env.structures.get(expression.type.name)
    if spec is None:return None
    # Freshness is supplied only by a check in this synchronous traversal.
    # Direct callers continue to check authored argument trees; stored payloads
    # alone never establish freshness.
    checked=expression.checked_args if fresh else None
    if checked is not None and len(checked)!=len(tree[2]):checked=None
    if fresh and tree[0]=='ModuleCall':
        from .bound_calls import identity
        from .core import CleanError
        if tree[3]!=identity(env,tree[1]):raise CleanError('Changed bound module callable: '+tree[1])
    if tree[1]==spec['constructor']:
        pos=len(spec['parameters'])+[n for n,_ in spec['fields']].index(field)
        return checked[pos] if checked is not None else Expressions(env,locals).elaborate(tree[2][pos])
    definition=env.definitions.get(tree[1])
    if not definition or definition['implementation']!='equals':return None
    from .operator_bindings import scope_unchanged
    if not scope_unchanged(env,definition) and definition.get('bound_tree') is None:return None
    parameters=env.data['functions'][tree[1]]['signature_tree'][2]
    body=definition.get('bound_tree') or definition['tree']
    bindings=dict(zip((p[1] for p in parameters if p[3]=='explicit'),
                      checked if checked is not None else
                      (Expressions(env,locals).elaborate(a) for a in tree[2])))
    inferred=dict(expression.inferred_args);required=tree_names(body);values=value_names(body);types={}
    try:
        for p in parameters:
            n=p[1]
            if p[3]!='implicit' or n not in required:continue
            actual=inferred[n]
            if isinstance(actual,Type):
                types[n]=actual
                if n in values:bindings[n]=reify(actual,env,locals,classifier=env.type(p[2],phrases=False))
            else:bindings[n]=reify(actual,env,locals)
        expanded=substitute(body,bindings,env,locals,types)
    except UnrepresentableSubstitution:return None
    if expanded[0] in ('Call','ModuleCall') and expanded[1]==spec['constructor']:
        pos=len(spec['parameters'])+[n for n,_ in spec['fields']].index(field)
        return Expressions(env,locals).elaborate(expanded[2][pos])
    value=Expressions(env,locals).elaborate(expanded)
    if value.type!=expression.type:return None
    return _producer_field(value,field,env,locals,fresh=True)

def _normal_form(expression,environment,locals,*,fresh=False):
    env=environment
    elaborate=lambda tree:Expressions(env,locals).elaborate(tree)
    def normal(tree):return _normal_form(elaborate(tree),env,locals,fresh=True)
    def unchanged(a,b):
        return (a.tree==b.tree and a.lean==b.lean and a.tex==b.tex and
                a.precedence==b.precedence and a.type==b.type and
                env.render_type(a.type,'lean',locals)==env.render_type(b.type,'lean',locals) and
                a.inferred_args==b.inferred_args)
    tree=expression.tree
    if not tree:return expression
    kind=tree[0]
    if kind=='BoundLiteral':
        from .literal_binding import call
        return _normal_form(call(tree,env,locals),env,locals,fresh=True)
    if kind=='Local':
        local=locals.get(tree[1])
        if local is None or local.local_normal is None:return expression
        return _normal_form(local.local_normal,env,locals) if local.local_expand and not shadowed_globals(env,locals) else local.local_normal
    if kind in ('TypeValue','ClassifiedTypeValue','BoundTypeValue','NumeralAnnotation','BoundNumeral'):return elaborate(tree)
    if kind in ('Decimal','Lambda','Forall','Exists'):return expression
    if kind in ('Operator','Unary'):
        # Operators are declared calls too. Do not publish a hidden binder as
        # an authored operand when normalizing a definition inside the call.
        from .beta_indices import has_binder
        trees=tree[2:]
        typed=expression.checked_args if fresh and expression.checked_args is not None else tuple(elaborate(t) for t in trees)
        args=[]
        for actual in typed:
            value=_normal_form(actual,env,locals,fresh=True)
            args.append(actual if has_binder(value.tree) else value)
        if (fresh and expression.checked_args is not None and
            expression.operator_binding is not None and
            len(args)==len(expression.checked_args) and
            all(unchanged(a,b) for a,b in zip(args,expression.checked_args))):
            from .bound_calls import identity
            from .core import CleanError
            name,target,_=expression.operator_binding
            if target!=identity(env,name):raise CleanError('Changed comparison operator')
            # Selection was checked in this synchronous traversal under fixed
            # declarations. No changed operand or public stored cache is reused.
            return expression
        if kind=='Operator':return env.operator(tree[1],args[0],args[1],locals)
        from .operator_bindings import apply_prefix
        return apply_prefix(env,tree[1],args[0],locals)
    if kind=='Apply':
        # Application metadata is disposable. Only a synchronous check in this
        # traversal certifies its head and operands under the current scope.
        if not fresh or expression.checked_args is None:
            return _normal_form(elaborate(tree),env,locals,fresh=True)
        head,*operands=expression.checked_args
        f=_normal_form(head,env,locals,fresh=True)
        args=[_normal_form(a,env,locals,fresh=True) for a in operands]
        result=Expr('('+f.lean+' '+args[0].lean+')',expression.tex,expression.type,
                    tree=['Apply',f.tree,[a.tree for a in args]])
        from .beta_indices import contract_index
        reduced=contract_index(result,env,locals)
        return _normal_form(reduced,env,locals) if reduced.tree!=result.tree else result
    if kind=='Projection':
        from .structures import project,projection_reduction
        from .beta_indices import has_binder
        if not fresh or expression.checked_args is None:
            return _normal_form(elaborate(tree),env,locals,fresh=True)
        # One synchronous check supplies both producer inspection and base
        # normalization. Public entry still rechecks the stored source tree.
        checked_base=expression.checked_args[0]
        selected=_producer_field(checked_base,tree[2],env,locals,fresh=True)
        if selected is not None and selected.type==expression.type:
            return _normal_form(selected,env,locals,fresh=True)
        base=_normal_form(checked_base,env,locals,fresh=True)
        if has_binder(base.tree):
            selected=projection_reduction(env,base,tree[2],locals)
            # An opaque producer cannot publish its hidden binders as field indices.
            return expression if selected is None else _normal_form(selected,env,locals)
        if unchanged(base,checked_base):return expression
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
        if not scope_unchanged(env,definition) and definition.get('bound_tree') is None:return checked
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
                        if n in values:bindings[n]=reify(actual,env,locals,classifier=env.type(p[2],phrases=False))
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
