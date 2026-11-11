# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Simultaneous source substitution with fresh expression and type binders."""
import re
from .core import ID,CleanError,Type
from .dependent_functions import tree_names
from .syntax import parse,type_tree,expression_spelling,condition_spelling

class UnrepresentableSubstitution(CleanError):
    """A checked argument has no spelling in a source type annotation."""


def substitute(tree,bindings,environment,locals,type_bindings=None):
    """bindings map original parameter names to checked Expr values.

    Inserted trees are never recursively substituted. Freshen every traversed
    binder, including binders in domain annotations, before inserting arguments.
    """
    type_bindings=dict(type_bindings or {})
    for n,value in bindings.items():
        if environment.classifier_info(value.type) is not None and value.tree[0]!='Local':
            from .carrier_types import carrier
            type_bindings[n]=carrier(value,environment,locals)
    occupied=set(locals)|set(environment.data['types'])|set(environment.data['aliases'])|set(environment.data['functions'])|tree_names(tree)
    replacements={n:v.tree for n,v in bindings.items()}
    heads=set()
    checked_heads={}
    def is_call_head(name):
        if name not in checked_heads:
            checked_heads[name]=name in bindings and environment.is_function_type(bindings[name].type)
        return checked_heads[name]
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
        if kind=='Projection':
            result=expr(type_expr(node),mapping,callheads)
            from .structures import reference_name
            return reference_name(result) or index(result)
        if kind=='ComputedIndex':
            try:return '('+condition_spelling(expr(node[1],mapping,callheads))+')'
            except CleanError as e:raise UnrepresentableSubstitution(str(e)) from e
        if kind=='Apply':return node[1]+'('+','.join(typ(a,mapping,callheads,type_mapping) for a in node[2])+')'
        if kind=='BoundTypeApply':
            domain=typ(node[3],mapping,callheads,type_mapping);name=fresh()
            codomain=typ(node[4],{**mapping,node[2]:['Local',name]},callheads|{node[2]},type_mapping)
            return node[1]+'('+name+': '+domain+','+codomain+')'
        raise UnrepresentableSubstitution('Unsupported type syntax: '+kind)
    bound_values={}
    def annotation(source,mapping,callheads):
        from .annotations import Annotation,replace
        if not isinstance(source,Annotation):return typ(type_tree(parse(source,'type_ref')),mapping,callheads,type_bindings)
        from .core import Expressions,Expr
        replacements={}
        scope=dict(locals)
        resolved={}
        # Raw syntax substitution stays syntactic. Resolve enclosing binder
        # domains only when a checked annotation needs their semantic scope.
        for original,(fresh_name,domain) in bound_values.items():
            value=Expr(fresh_name,fresh_name,environment.type(domain,scope,phrases=False),tree=['Local',fresh_name])
            resolved[original]=value;scope[fresh_name]=value
        # Fresh binder references have not yet entered the caller's semantic scope.
        for name,tree in mapping.items():
            if name in bindings and tree==bindings[name].tree:replacements[name]=bindings[name]
            elif tree[0]=='Local':
                from .dependent_functions import tree_names
                original=resolved.get(name) or locals.get(name)
                if original is not None:
                    value=Expr(tree[1],tree[1],original.type,tree=tree)
                    scope[tree[1]]=value;replacements[name]=value
                else:replacements[name]=tree[1]
            else:replacements[name]=Expressions(environment,scope).elaborate(tree)
        return replace(source,{**replacements,**type_bindings},environment,scope)
    def expr(node,mapping,callheads):
        kind=node[0]
        if kind=='BoundLiteral':
            from .literal_binding import rebuild
            return rebuild(node,lambda value:expr(value,mapping,callheads),annotation(node[6],mapping,callheads))
        if kind=='Local':return mapping.get(node[1],node)
        if kind=='Decimal':return node
        if kind=='BoundNumeral':
            from .numerals import bind
            return bind(node,environment,locals)
        if kind=='NumeralAnnotation':raise UnrepresentableSubstitution('Bind numeral annotations before substitution')
        if kind=='TypeValue':return ['TypeValue',annotation(node[1],mapping,callheads)]
        if kind=='ClassifiedTypeValue':return [kind,annotation(node[1],mapping,callheads),annotation(node[2],mapping,callheads)]
        if kind=='BoundTypeValue':return [kind,annotation(node[1],mapping,callheads),node[2],node[3],node[4]]
        if kind=='ModuleCall':return [kind,node[1],[expr(a,mapping,callheads) for a in node[2]],*node[3:]]
        if kind=='Call':
            args=[expr(a,mapping,callheads) for a in node[2]]
            if node[1] in mapping and (node[1] in callheads or is_call_head(node[1])):
                head=mapping[node[1]]
                return ['Call',head[1],args] if head[0]=='Local' else ['Apply',head,args]
            return ['Call',node[1],args]
        if kind=='Projection':return ['Projection',expr(node[1],mapping,callheads),node[2]]
        if kind=='Apply':return ['Apply',expr(node[1],mapping,callheads),[expr(a,mapping,callheads) for a in node[2]]]
        if kind=='Operator':return ['Operator',node[1],expr(node[2],mapping,callheads),expr(node[3],mapping,callheads)]
        if kind=='Unary':return ['Unary',node[1],expr(node[2],mapping,callheads)]
        if kind in ('Lambda','Forall','Exists'):
            domain=annotation(node[2],mapping,callheads);name=fresh()
            from .annotations import Annotation
            from .core import Expr
            previous=bound_values.get(node[1])
            bound_values[node[1]]=(name,domain)
            try:body=expr(node[3],{**mapping,node[1]:['Local',name]},callheads|{node[1]})
            finally:
                if previous is None:bound_values.pop(node[1],None)
                else:bound_values[node[1]]=previous
            return [kind,name,domain,body]
        raise UnrepresentableSubstitution('Unsupported expression syntax: '+kind)
    return expr(tree,replacements,heads)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
