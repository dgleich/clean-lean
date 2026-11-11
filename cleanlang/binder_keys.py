# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Owned comparison identities, distinct from every fixed-environment token."""
from dataclasses import dataclass
import re
from .core import ID

@dataclass(frozen=True)
class ScopedKey:
    parts: tuple

    def abstract(self,bound):
        return tuple(('bound',len(bound)-1-bound.index(p[1]))
                     if isinstance(p,tuple) and p[0]=='free' and p[1] in bound else p
                     for p in self.parts)


def key(term,owned):
    parts=[];position=0;ordinals={}
    for match in re.finditer(ID,term):
        parts.append(term[position:match.start()]);token=match[0]
        if token in owned:
            if token not in ordinals:ordinals[token]=len(ordinals)
            parts.append(('owned',ordinals[token]))
        else:parts.append(('free',token))
        position=match.end()
    parts.append(term[position:])
    return ScopedKey(tuple(parts))


def environment_tokens(environment):
    """Cache only the pure token union of an identical immutable text snapshot."""
    texts=[]
    def collect(value):
        if isinstance(value,str):texts.append(str(value))
        elif isinstance(value,dict):
            for k,v in value.items():collect(k);collect(v)
        elif isinstance(value,(tuple,list)):
            for v in value:collect(v)
    collect(environment.data);collect(environment.notation_definitions)
    snapshot=tuple(texts)
    cached=getattr(environment,'_comparison_reserved_tokens',None)
    if cached is None or cached[0]!=snapshot:
        cached=(snapshot,frozenset(token for text in snapshot for token in re.findall(ID,text)))
        environment._comparison_reserved_tokens=cached
    return cached[1]


class Pool:
    def __init__(self,environment,locals,tree):
        self.reserved=set();self.owned=set();self.counter=0
        def reserve(value):
            from .annotations import Annotation
            if isinstance(value,Annotation):self.reserve_type(value.typ)
            if isinstance(value,str):self.reserved.update(re.findall(ID,value))
            elif isinstance(value,dict):
                for k,v in value.items():reserve(k);reserve(v)
            elif isinstance(value,(tuple,list)):
                for v in value:reserve(v)
        self._pending_environment=environment
        reserve(tree)
        self.reserve_locals(locals)
    def reserve_locals(self,locals):
        for name,value in locals.items():
            self.reserved.add(name)
            self.reserved.update(re.findall(ID,value.lean))
            self.reserved.update(re.findall(ID,str(value.type)))
            self.reserve_type(value.type)
    def reserve_type(self,typ):
        from .core import Type,LocalType,ValueIndex
        from .dependent_functions import DependentFunctionType
        if isinstance(typ,LocalType):self.reserved.update(re.findall(ID,typ.lean))
        if isinstance(typ,DependentFunctionType):self.reserved.add(typ.bound)
        if isinstance(typ,Type):
            for arg in typ.args:self.reserve_type(arg)
        elif isinstance(typ,ValueIndex):self.reserved.update(re.findall(ID,typ.lean))
    def fresh(self,locals):
        # Most comparisons allocate no binder. Scan the fixed declaration
        # environment only when a comparison-owned identity is actually needed.
        if self._pending_environment is not None:
            self.reserved.update(environment_tokens(self._pending_environment))
            self._pending_environment=None
        self.reserve_locals(locals)
        while 'clean_comparison_identity_'+str(self.counter) in self.reserved:self.counter+=1
        name='clean_comparison_identity_'+str(self.counter);self.counter+=1
        self.reserved.add(name);self.owned.add(name)
        return name

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
