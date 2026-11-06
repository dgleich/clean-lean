# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Bounded, deterministic comparison normalization; never rewrite emitted terms."""
from .core import Expr,Expressions,binary


def comparison_normal_form(expression,environment,locals):
    env=environment
    elaborate=lambda tree:Expressions(env,locals).elaborate(tree)
    def normal(tree):return comparison_normal_form(elaborate(tree),env,locals)
    tree=expression.tree
    if not tree:return expression
    kind=tree[0]
    if kind=='Local':
        local=locals.get(tree[1])
        return local.local_normal if local is not None and local.local_normal is not None else expression
    if kind in ('Decimal','Lambda','Forall','Exists'):return expression
    if kind=='Operator':return binary(tree[1],normal(tree[2]),normal(tree[3]))
    if kind=='Unary':
        a=normal(tree[2]);op='-' if tree[1]=='-' else '¬'
        return Expr('('+op+a.lean+')',expression.tex,expression.type,tree=['Unary',tree[1],a.tree])
    if kind=='Apply':
        f=normal(tree[1]);args=[normal(a) for a in tree[2]]
        return Expr('('+f.lean+' '+args[0].lean+')',expression.tex,expression.type,
                    tree=['Apply',f.tree,[a.tree for a in args]])
    if kind=='Projection':
        from .structures import project
        base=normal(tree[1])
        result=project(env,base,tree[2],locals)
        # project may reduce a constructor field; its result is already normalized
        # if it is a stable projection, otherwise normalize its selected expression.
        if result.tree==['Projection',base.tree,tree[2]]:return result
        return comparison_normal_form(result,env,locals)
    if kind!='Call':return expression
    name=tree[1];args=[normal(a) for a in tree[2]]
    if name in locals and env.is_function_type(locals[name].type):
        head=normal(['Local',name])
        return Expr('('+head.lean+' '+args[0].lean+')',expression.tex,expression.type,
                    tree=['Apply',head.tree,[a.tree for a in args]])
    definition=env.definitions.get(name)
    if definition and definition['implementation']=='equals':
        parameters=env.data['functions'][name]['signature_tree'][2]
        implicit={p[1] for p in parameters if p[3]=='implicit'}
        body=definition['tree']
        def blocked(node):
            if not isinstance(node,list):return False
            if node and node[0] in ('Lambda','Forall','Exists'):return True
            if node and node[0]=='Local' and node[1] in implicit:return True
            return any(blocked(child) for child in node)
        if not blocked(body):
            bindings=dict(zip((p[1] for p in parameters if p[3]=='explicit'),args))
            def replace(node):
                if node[0]=='Local':return bindings[node[1]].tree if node[1] in bindings else node
                if node[0]=='Call':
                    arguments=[replace(a) for a in node[2]]
                    value=bindings.get(node[1])
                    if value is not None and env.is_function_type(value.type):
                        return ['Call',value.tree[1],arguments] if value.tree[0]=='Local' else ['Apply',value.tree,arguments]
                    return ['Call',node[1],arguments]
                if node[0]=='Projection':return ['Projection',replace(node[1]),node[2]]
                if node[0]=='Apply':return ['Apply',replace(node[1]),[replace(a) for a in node[2]]]
                if node[0]=='Operator':return ['Operator',node[1],replace(node[2]),replace(node[3])]
                if node[0]=='Unary':return ['Unary',node[1],replace(node[2])]
                return node
            expanded=normal(replace(body))
            if expanded.type==expression.type:return expanded
    return env.call(name,args,locals)

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
        normal=comparison_normal_form(value,environment,locals)
        if normal.type==value.type:result.local_normal=normal
    return result
