# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Simultaneous source substitution with fresh expression and type binders."""
import re
from .core import ID,CleanError,Type
from .dependent_functions import tree_names
from .syntax import parse,type_tree,expression_spelling

class UnrepresentableSubstitution(CleanError):
    """A checked argument has no spelling in a source type annotation."""


def substitute(tree,bindings,environment,locals,type_bindings=None):
    """bindings map original parameter names to checked Expr values.

    Inserted trees are never recursively substituted. Freshen every traversed
    binder, including binders in domain annotations, before inserting arguments.
    """
    type_bindings=dict(type_bindings or {})
    for n,value in bindings.items():
        if value.type==Type('Type') and value.tree[0]=='TypeValue':
            type_bindings[n]=environment.type(value.tree[1],locals,phrases=False)
    occupied=set(locals)|set(environment.data['types'])|set(environment.data['aliases'])|set(environment.data['functions'])|tree_names(tree)
    replacements={n:v.tree for n,v in bindings.items()}
    heads={n for n,v in bindings.items() if environment.is_function_type(v.type)}
    for value in bindings.values():
        if value.tree is None:raise UnrepresentableSubstitution('Substitution requires a source tree')
        occupied.update(tree_names(value.tree))
    for value in type_bindings.values():occupied.update(re.findall(ID,str(value)))
    counter=0
    def fresh():
        nonlocal counter
        while 'clean_conversion_bound_'+str(counter) in occupied:counter+=1
        name='clean_conversion_bound_'+str(counter);counter+=1;occupied.add(name)
        return name
    def index(node):
        if node[0]=='Local':return node[1]
        if node[0]=='Decimal':return node[1]
        try:return '('+expression_spelling(node)+')'
        except CleanError as e:raise UnrepresentableSubstitution(str(e)) from e
    def type_expr(node):
        if node[0]=='Name':return ['Local',node[1]]
        if node[0]=='Projection':return ['Projection',type_expr(node[1]),node[2]]
        raise UnrepresentableSubstitution('Expected an index reference')
    def typ(node,mapping,callheads,type_mapping):
        kind=node[0]
        if kind=='Name':
            if node[1] in type_mapping:
                value=type_mapping[node[1]]
                try:
                    source=typ(type_tree(parse(str(value),'type_ref')),{},set(),{})
                    checked=environment.type(source,locals,phrases=False)
                except CleanError as e:raise UnrepresentableSubstitution(str(e)) from e
                if checked!=value:raise UnrepresentableSubstitution('Inferred type changed during source reification')
                return source
            return index(mapping[node[1]]) if node[1] in mapping else node[1]
        if kind=='Numeral':return node[1]
        if kind=='Projection':return index(expr(type_expr(node),mapping,callheads))
        if kind=='ComputedIndex':
            try:return '('+expression_spelling(expr(node[1],mapping,callheads))+')'
            except CleanError as e:raise UnrepresentableSubstitution(str(e)) from e
        if kind=='Apply':return node[1]+'('+','.join(typ(a,mapping,callheads,type_mapping) for a in node[2])+')'
        if kind=='BoundTypeApply':
            domain=typ(node[3],mapping,callheads,type_mapping);name=fresh()
            codomain=typ(node[4],{**mapping,node[2]:['Local',name]},callheads|{node[2]},type_mapping)
            return node[1]+'('+name+': '+domain+','+codomain+')'
        raise UnrepresentableSubstitution('Unsupported type syntax: '+kind)
    def expr(node,mapping,callheads):
        kind=node[0]
        if kind=='Local':return mapping.get(node[1],node)
        if kind=='Decimal':return node
        if kind=='TypeValue':return ['TypeValue',typ(type_tree(parse(node[1],'type_ref')),mapping,callheads,type_bindings)]
        if kind=='Call':
            args=[expr(a,mapping,callheads) for a in node[2]]
            if node[1] in mapping and node[1] in callheads:
                head=mapping[node[1]]
                return ['Call',head[1],args] if head[0]=='Local' else ['Apply',head,args]
            return ['Call',node[1],args]
        if kind=='Projection':return ['Projection',expr(node[1],mapping,callheads),node[2]]
        if kind=='Apply':return ['Apply',expr(node[1],mapping,callheads),[expr(a,mapping,callheads) for a in node[2]]]
        if kind=='Operator':return ['Operator',node[1],expr(node[2],mapping,callheads),expr(node[3],mapping,callheads)]
        if kind=='Unary':return ['Unary',node[1],expr(node[2],mapping,callheads)]
        if kind in ('Lambda','Forall','Exists'):
            domain=typ(type_tree(parse(node[2],'type_ref')),mapping,callheads,type_bindings);name=fresh()
            body=expr(node[3],{**mapping,node[1]:['Local',name]},callheads|{node[1]})
            return [kind,name,domain,body]
        raise UnrepresentableSubstitution('Unsupported expression syntax: '+kind)
    return expr(tree,replacements,heads)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
