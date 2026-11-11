# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental inversion of a ground contextual pattern, not joint lambda inference.

An occurrence supplies distinct explicit locals for an ordered formal telescope.
The solution is an explicit abstracted closure, never a renamed opaque atom.
"""
from dataclasses import dataclass
from constraint_model import (Atom, Carrier, IndexExpression, Reference, Bound,
    Binder, Variable, abstract, instantiate, well_scoped, variables, unify,
    Incomplete, NoSolution)

@dataclass(frozen=True)
class Parameter:
    name: object
    domain: object
    sort: str

@dataclass(frozen=True)
class Actual:
    reference: Reference
    typ: object

@dataclass(frozen=True)
class Solution:
    parameters: tuple
    closure: object
    allowed_free: frozenset

class Walk:
    def __init__(self,limit):
        if type(limit) is not int or limit < 1:raise ValueError('Positive contextual limit required')
        self.remaining=limit
    def visit(self):
        self.remaining-=1
        if self.remaining<0:raise Incomplete('Contextual pattern resource limit exceeded')
    def rename(self,term,mapping):
        self.visit()
        if isinstance(term,Reference):
            result=mapping.get(term.binder,term)
            if result.sort!=term.sort:raise NoSolution('Contextual reference sort mismatch')
            return result
        if isinstance(term,(Carrier,IndexExpression)):
            return type(term)(term.identity,tuple(self.rename(a,mapping) for a in term.arguments),term.sort)
        if isinstance(term,Binder):
            return Binder(term.identity,self.rename(term.domain,mapping),self.rename(term.body,mapping),term.sort)
        if isinstance(term,Atom):
            if term.free_binders.intersection(mapping):
                raise Incomplete('Opaque dependency cannot be structurally renamed')
            return term
        if isinstance(term,Bound):return term
        if isinstance(term,Variable):raise Incomplete('Contextual pattern right side is not ground')
        raise Incomplete('Unknown contextual term')
    def dependencies(self,term):
        self.visit()
        if isinstance(term,Reference):return {term.binder}
        if isinstance(term,Atom):return set(term.free_binders)
        if isinstance(term,(Carrier,IndexExpression)):
            return set().union(*(self.dependencies(a) for a in term.arguments))
        if isinstance(term,Binder):return self.dependencies(term.domain)|self.dependencies(term.body)
        if isinstance(term,Bound):return set()
        if isinstance(term,Variable):raise Incomplete('Contextual pattern is not ground')
        raise Incomplete('Unknown contextual term')

def _validate(parameters,actuals,allowed_free,walk,limit):
    if not isinstance(allowed_free,frozenset):raise TypeError('Free scope must be immutable')
    if len(parameters)!=len(actuals):raise Incomplete('Contextual substitution arity mismatch')
    names=[p.name for p in parameters]
    if len(set(names))!=len(names) or set(names)&allowed_free:
        raise Incomplete('Formal contextual names must be fresh and distinct')
    if any(not isinstance(a.reference,Reference) for a in actuals):
        raise Incomplete('Contextual pattern requires explicit local arguments')
    refs=[a.reference.binder for a in actuals]
    if len(set(refs))!=len(refs) or set(refs)&allowed_free:
        raise Incomplete('Contextual pattern arguments must be distinct from each other and free scope')
    substitution={};earlier=set()
    for parameter,actual in zip(parameters,actuals):
        walk.visit()
        if parameter.sort!=actual.reference.sort:raise NoSolution('Contextual argument sort mismatch')
        well_scoped(parameter.domain,limit=limit);well_scoped(actual.typ,limit=limit)
        if walk.dependencies(parameter.domain)-earlier-allowed_free:
            raise NoSolution('Contextual domain refers outside its preceding telescope')
        domain=walk.rename(parameter.domain,substitution)
        # Ground structural equality/conversion boundaries are the model's existing ones.
        # Unequal computed indices remain incomplete, not an inverse arithmetic proof.
        if variables(actual.typ):raise Incomplete('Contextual argument type is unresolved')
        unify(((domain,actual.typ),),limit=limit)
        earlier.add(parameter.name);substitution[parameter.name]=actual.reference
    return substitution

def solve_pattern(parameters,actuals,value,*,allowed_free=frozenset(),limit=4096):
    """Solve one ground pattern occurrence; no search, defaults or opaque inversion.

    Domain checks precede inversion. Actual locals are renamed simultaneously to
    formal locals; reverse-order abstraction then makes dependency explicit.
    """
    parameters=tuple(parameters);actuals=tuple(actuals);walk=Walk(limit)
    try:
        _validate(parameters,actuals,allowed_free,walk,limit)
        well_scoped(value,limit=limit)
        original_dependencies=walk.dependencies(value)
        renamed=walk.rename(value,{a.reference.binder:Reference(p.name,p.sort)
                                  for p,a in zip(parameters,actuals)})
        if original_dependencies-{a.reference.binder for a in actuals}-allowed_free:
            raise NoSolution('Contextual right side escapes the actual scope')
        if walk.dependencies(renamed)-{p.name for p in parameters}-allowed_free:
            raise NoSolution('Contextual solution escapes the permitted scope')
        closure=renamed
        for parameter in reversed(parameters):
            walk.visit()
            closure=abstract(parameter.name,parameter.domain,closure,
                             identity='Context',sort=closure.sort,limit=limit)
        return Solution(parameters,closure,allowed_free)
    except RecursionError as error:raise Incomplete('Contextual pattern recursion exhausted') from error

def apply_solution(solution,actuals,*,limit=4096):
    """Instantiate a contextual closure after checking its dependent telescope."""
    actuals=tuple(actuals);walk=Walk(limit)
    try:
        _validate(solution.parameters,actuals,solution.allowed_free,walk,limit)
        value=solution.closure
        for actual in actuals:
            walk.visit()
            if not isinstance(value,Binder) or value.identity!='Context':
                raise Incomplete('Malformed contextual closure')
            unify(((value.domain,actual.typ),),limit=limit)
            value=instantiate(value,actual.reference,limit=limit)
        if variables(value):raise Incomplete('Contextual solution remains unresolved')
        well_scoped(value,limit=limit)
        if walk.dependencies(value)-{a.reference.binder for a in actuals}-solution.allowed_free:
            raise NoSolution('Instantiated contextual solution escapes its scope')
        return value
    except RecursionError as error:raise Incomplete('Contextual application recursion exhausted') from error

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md


def callable_type(solution,function_identity,*,limit=4096):
    """Interpret a type-valued contextual telescope as a dependent callable type.

    This is structural model conversion. The checked type codec must still verify
    the supplied function declaration, domains, result and retained witnesses.
    """
    # Check that the stored closure actually has its declared telescope.
    actuals=tuple(Actual(Reference(p.name,p.sort),p.domain) for p in solution.parameters)
    apply_solution(solution,actuals,limit=limit)
    walk=Walk(limit)
    def convert(node,position):
        walk.visit()
        if position==len(solution.parameters):
            if node.sort!='type':raise Incomplete('Contextual callable result is not a type')
            return node
        if not isinstance(node,Binder) or node.identity!='Context' or node.sort!='type':
            raise Incomplete('Contextual callable requires a type-valued telescope')
        return Binder(function_identity,node.domain,convert(node.body,position+1))
    try:
        result=convert(solution.closure,0)
        well_scoped(result,limit=limit)
        return result
    except RecursionError as error:raise Incomplete('Contextual callable conversion exhausted recursion') from error
