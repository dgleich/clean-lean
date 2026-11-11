# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Checked annotations retain types and their free local references."""
class Annotation(str):
    def __new__(cls,source,typ,names=()):
        value=super().__new__(cls,source)
        value.typ=typ
        value.names=frozenset(names)
        return value
    def __setattr__(self,name,value):
        if hasattr(self,name):raise AttributeError('Checked annotations are immutable')
        object.__setattr__(self,name,value)
    def __reduce__(self):return (Annotation,(str(self),self.typ,self.names))
    def __eq__(self,other):
        return isinstance(other,Annotation) and str(self)==str(other) and self.typ==other.typ and self.names==other.names
    def __ne__(self,other):return not self==other
    def __hash__(self):return hash((str(self),self.typ,self.names))


def references(value,locals):
    from .core import Type,LocalType,ValueIndex,Expr
    from .dependent_functions import index_tree,DependentFunctionType
    def tree_names(tree):
        kind=tree[0]
        if kind=='BoundLiteral':
            from .literal_binding import names
            return names(tree,tree_names)
        if kind=='Local':return {tree[1]}
        if kind in ('Decimal','BoundNumeral'):return set()
        if kind=='NumeralAnnotation':
            from .numerals import type_source
            from .core import ID
            import re
            return set(re.findall(ID,type_source(tree[2]))).intersection(locals)
        if kind in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):
            if isinstance(tree[1],Annotation):return set(tree[1].names)
            from .core import ID
            import re
            return set(re.findall(ID,tree[1])).intersection(locals)
        if kind in ('Call','ModuleCall'):
            args=set().union(*(tree_names(a) for a in tree[2]))
            return args|({tree[1]} if kind=='Call' and tree[1] in locals else set())
        if kind=='Apply':return tree_names(tree[1])|set().union(*(tree_names(a) for a in tree[2]))
        if kind=='Projection':return tree_names(tree[1])
        if kind=='Operator':return tree_names(tree[2])|tree_names(tree[3])
        if kind=='Unary':return tree_names(tree[2])
        if kind in ('Forall','Exists','Lambda'):
            domain=set(tree[2].names) if isinstance(tree[2],Annotation) else set()
            return domain|tree_names(tree[3]).difference({tree[1]})
        from .core import CleanError
        raise CleanError('Uncovered annotation-reference constructor: '+kind)
    if isinstance(value,DependentFunctionType):
        return references(value.domain,locals)|references(value.codomain,locals).difference({value.binder})
    if isinstance(value,Type):
        names=set().union(*(references(a,locals) for a in value.args))
        if isinstance(value,LocalType):names.add(value.name)
        return names
    if isinstance(value,ValueIndex):return tree_names(index_tree(value))
    if isinstance(value,Expr):return tree_names(value.tree)
    return {value} if isinstance(value,str) and value in locals else set()


def checked(source,env,locals):
    value=env.type(source,locals,phrases=False)
    # Rebinding a saved annotation must not discover new free names from display text.
    names=source.names if isinstance(source,Annotation) else references(value,locals)
    return Annotation(str(source),value,names)


def replace(annotation,bindings,env,locals):
    from .dependent_functions import substitute
    selected={n:v for n,v in bindings.items() if n in annotation.names}
    value=substitute(annotation.typ,selected,env,locals)
    candidates=set(annotation.names).difference(selected)
    for actual in selected.values():candidates.update(references(actual,locals))
    return Annotation(str(value),value,candidates)


def resolve(annotation,env,locals):
    from .core import Expressions
    bindings={n:Expressions(env,locals).elaborate(['Local',n]) for n in sorted(annotation.names) if n in locals}
    value=replace(annotation,bindings,env,locals).typ
    validate(value,env,locals)
    return value


def validate(typ,env,locals):
    from .core import Type,ComputedCarrier,ValueIndex,CleanError
    from .dependent_functions import index_tree
    from .bound_calls import bind
    if isinstance(typ,ComputedCarrier):
        from .carrier_types import substitute_carrier
        fresh=substitute_carrier(typ,{},env,locals)
        if env.render_type(typ,'lean',locals)!=env.render_type(fresh,'lean',locals):
            raise CleanError('Stale computed carrier native target')
    if isinstance(typ,Type):
        if typ.name=='$carrier' and not isinstance(typ,ComputedCarrier):raise CleanError('Carrier type lacks retained classifier metadata')
        for arg in typ.args:validate(arg,env,locals)
    elif isinstance(typ,ValueIndex):bind(index_tree(typ),env,locals,binders=True)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
