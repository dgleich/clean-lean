# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Checked ground representatives, separate from declaration-choice inference."""
from dataclasses import dataclass
from constraint_model import Variable,Carrier,Incomplete,NoSolution,resolve,variables

@dataclass(frozen=True)
class Seed:
    output: object
    value: object
    priority: tuple

@dataclass(frozen=True)
class Plan:
    output: object
    inputs: tuple
    build: object
    priority: tuple

class Resolver:
    """One fixed environment/binding snapshot, with explicit representative order.

    validate(term,value) must check semantic agreement. assemble reconstructs a
    nominal carrier from checked argument representatives. Neither callback may
    mutate this snapshot. A failed preferred plan never falls through to another.
    Optional available(value,allowed_binders) checks the actual representative in
    each requested scope, including memo hits; semantic equality is insufficient.
    """
    def __init__(self,bindings,seeds=(),plans=(),*,validate,assemble,limit=4096,available=None,allowed_binders=frozenset()):
        if type(limit) is not int or limit<1:raise ValueError('Positive witness limit required')
        self.bindings=dict(bindings);self.validate=validate;self.assemble=assemble
        self.available=available;self.allowed_binders=frozenset(allowed_binders)
        self.limit=limit;self.visits=0;self.memo={};self.active=set();self.options={}
        for entry in (*seeds,*plans):
            if not isinstance(entry,(Seed,Plan)):raise ValueError('Unknown witness entry')
            if not isinstance(entry.priority,tuple) or not entry.priority or any(type(n) is not int or n<0 for n in entry.priority):
                raise ValueError('Witness priorities must be nonempty tuples of natural integers')
            term=self.ground(entry.output)
            options=self.options.setdefault(term,{})
            if entry.priority in options:raise Incomplete('Duplicate witness priority for one solved term')
            options[entry.priority]=entry

    def ground(self,term):
        try:term=resolve(term,self.bindings)
        except RecursionError as error:raise Incomplete('Witness binding resolution exhausted recursion') from error
        if variables(term):raise Incomplete('Witness reconstruction requires solved parameters')
        return term

    def get(self,term):
        try:
            allowed=term.allowed_binders if isinstance(term,Variable) else self.allowed_binders
            value=self._get(term)
            if self.available is not None and self.available(value,allowed) is not True:
                raise Incomplete('Preferred witness is unavailable in the requested binder scope')
            return value
        except NoSolution as error:raise Incomplete('Witness scope checking rejected a solved representative') from error
        except RecursionError as error:raise Incomplete('Witness reconstruction exhausted recursion') from error

    def _get(self,term):
        term=self.ground(term);self.visits+=1
        if self.visits>self.limit:raise Incomplete('Witness reconstruction budget exceeded')
        if term in self.memo:return self.memo[term]
        if term in self.active:raise Incomplete('Cyclic witness reconstruction')
        self.active.add(term)
        try:
            options=self.options.get(term)
            if options:
                selected=options[min(options)]
                if isinstance(selected,Seed):value=selected.value
                else:value=selected.build(tuple(self.get(x) for x in selected.inputs))
            elif isinstance(term,Carrier):
                value=self.assemble(term,tuple(self.get(x) for x in term.arguments))
            else:raise Incomplete('No checked representative for solved parameter')
            if not self.validate(term,value):raise Incomplete('Witness disagrees with solved parameter')
            self.memo[term]=value
            return value
        except NoSolution as error:
            raise Incomplete('Witness construction rejected a solved parameter') from error
        finally:self.active.remove(term)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
