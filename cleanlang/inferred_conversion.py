"""Reify already checked implicit arguments using existing source expressions."""
from .core import Type,LocalType,Expr,NAT,Expressions
from .hygiene import UnrepresentableSubstitution

def reify_parameter(value,parameter,environment,locals):
    """Reconstruct a recovered value under its formal classifier, never visibility."""
    classifier=environment.type(parameter[2],phrases=False) if isinstance(value,Type) else None
    return reify(value,environment,locals,classifier=classifier)


def reify(value,environment,locals,*,classifier=None):
    if isinstance(value,Type):
        if isinstance(value,LocalType) and value.name in locals and environment.classifier_info(locals[value.name].type)==(value.classifier,value.universe) and locals[value.name].lean==value.lean and (classifier is None or locals[value.name].type==classifier):
            return Expressions(environment,locals).elaborate(['Local',value.name])
        from .annotations import Annotation,references
        from .type_values import select_classifier
        classifier=select_classifier(value,environment) if classifier is None else classifier
        tree=['ClassifiedTypeValue',Annotation(str(value),value,references(value,locals)),str(classifier)]
        return Expressions(environment,locals).elaborate(tree)
    from .core import ValueIndex
    from .dependent_functions import index_tree
    from .syntax import parse,expression_tree
    if isinstance(value,ValueIndex):tree=index_tree(value)
    elif isinstance(value,str):tree=expression_tree(parse(value,'expression'))
    else:raise UnrepresentableSubstitution('Inferred argument has no source expression')
    result=Expressions(environment,locals).elaborate(tree)
    from .indices import dimension_index,DimensionIndex,index_value
    from .proof_types import ProofIndex,index as proof_index
    checked=(proof_index(result,environment,locals,_fresh=True) if isinstance(value,ProofIndex) else
             dimension_index(result,environment,locals) if isinstance(value,(DimensionIndex,str))
             else index_value(result,environment,locals))
    if isinstance(value,ValueIndex) and checked!=value:
        raise UnrepresentableSubstitution('Inferred argument changed in the current scope')
    return result


def value_names(tree):
    """References in expression positions, including computed type indices."""
    from .syntax import parse,type_tree
    def type_values(node):
        if node[0]=='ComputedIndex':return value_names(node[1])
        if node[0]=='Projection':return {node[1][1]} if node[1][0]=='Name' else type_values(node[1])
        if node[0]=='Apply':return set().union(*(type_values(a) for a in node[2]))
        if node[0]=='BoundTypeApply':return type_values(node[3])|type_values(node[4])
        return set()
    kind=tree[0]
    if kind=='BoundLiteral':
        from .literal_binding import names
        return names(tree,value_names)
    if kind=='Local':return {tree[1]}
    if kind in ('Decimal','BoundNumeral'):return set()
    if kind=='NumeralAnnotation':
        from .numerals import type_source
        import re
        from .core import ID
        return set(re.findall(ID,type_source(tree[2])))
    if kind in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):return type_values(type_tree(parse(tree[1],'type_ref')))
    if kind=='ModuleCall':return set().union(*(value_names(a) for a in tree[2]))
    if kind=='Call':return {tree[1]}|set().union(*(value_names(a) for a in tree[2]))
    if kind=='Projection':return value_names(tree[1])
    if kind=='Apply':return value_names(tree[1])|set().union(*(value_names(a) for a in tree[2]))
    if kind=='Operator':return value_names(tree[2])|value_names(tree[3])
    if kind=='Unary':return value_names(tree[2])
    if kind in ('Lambda','Forall','Exists'):
        return type_values(type_tree(parse(tree[2],'type_ref')))|value_names(tree[3])
    raise UnrepresentableSubstitution('Unsupported expression in inferred-argument occurrence check')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
