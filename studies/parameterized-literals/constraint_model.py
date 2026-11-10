# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Symbolic design experiment for joint literal constraints; not Clean inference.

Rows are supplied by an exhaustive declaration-choice enumerator. This model
neither parses source nor constructs rows from Clean signatures. Index atoms are
rigid; it does not invert arithmetic or inspect Lean terms.
"""
from dataclasses import dataclass

class NoSolution(ValueError): pass
class Underdetermined(ValueError): pass
class Ambiguous(ValueError): pass
class Incomplete(RuntimeError): pass

@dataclass(frozen=True)
class Variable:
    identity: str
    sort: str

@dataclass(frozen=True)
class Atom:
    identity: str
    sort: str

@dataclass(frozen=True)
class Carrier:
    identity: str
    arguments: tuple=()
    sort: str='type'

@dataclass(frozen=True)
class Row:
    choices: tuple
    carriers: tuple
    arguments: tuple
    equations: tuple=()


def resolve(term,bindings):
    if isinstance(term,Variable) and term in bindings:return resolve(bindings[term],bindings)
    if isinstance(term,Carrier):return Carrier(term.identity,tuple(resolve(a,bindings) for a in term.arguments))
    return term


def variables(term):
    if isinstance(term,Variable):return {term}
    if isinstance(term,Carrier):return set().union(*(variables(a) for a in term.arguments))
    return set()


def unify(equations,bindings=None,*,limit=4096):
    bindings=dict(bindings or {});pending=list(equations);steps=0
    while pending:
        steps+=1
        if steps>limit:raise Incomplete('Constraint step limit exceeded')
        left,right=pending.pop(0);left=resolve(left,bindings);right=resolve(right,bindings)
        if left==right:continue
        if left.sort!=right.sort:raise NoSolution('Different sorts')
        if isinstance(right,Variable) and not isinstance(left,Variable):left,right=right,left
        if isinstance(left,Variable):
            if left in variables(right):raise NoSolution('Occurs check')
            bindings[left]=right;continue
        if isinstance(left,Carrier) and isinstance(right,Carrier):
            if left.identity!=right.identity or len(left.arguments)!=len(right.arguments):
                raise NoSolution('Different carrier constructors')
            pending[0:0]=list(zip(left.arguments,right.arguments));continue
        raise NoSolution('Unequal rigid terms')
    return bindings


def select(rows,*,default=None,enumeration_complete=True,limit=4096):
    """Select only after all branches and simultaneous defaults are resolved.

    Each row's arguments include every emitted implicit/explicit parameter.
    Different declaration-choice rows remain different interpretations.
    """
    if not enumeration_complete:raise Incomplete('Declaration enumeration unfinished')
    if len(rows)>limit:raise Incomplete('Declaration row limit exceeded')
    if default is not None and variables(default):raise ValueError('Default must be determined')
    widths={len(row.carriers) for row in rows}
    if len(widths)>1:raise ValueError('Rows must describe the same literal positions')
    solutions=[]
    for row in rows:
        try:bindings=unify(row.equations,limit=limit)
        except NoSolution:continue
        solutions.append((row,bindings))
    if not solutions:raise NoSolution('No consistent interpretation')
    restrictions=[]
    if default is not None:
        for position in range(len(solutions[0][0].carriers)):
            carriers={resolve(row.carriers[position],b) for row,b in solutions}
            if len(carriers)==1 and not variables(next(iter(carriers))):continue
            compatible=False
            for carrier in carriers:
                try:unify([(carrier,default)],limit=limit)
                except NoSolution:continue
                compatible=True
            if compatible:restrictions.append(position)
        narrowed=[]
        for row,bindings in solutions:
            try:bindings=unify([(row.carriers[i],default) for i in restrictions],bindings,limit=limit)
            except NoSolution:continue
            narrowed.append((row,bindings))
        if not narrowed:raise NoSolution('Simultaneous defaults conflict')
        solutions=narrowed
    for row,bindings in solutions:
        if any(variables(resolve(term,bindings)) for term in row.carriers+row.arguments):
            raise Underdetermined('A competing interpretation has unresolved parameters')
    if len(solutions)!=1:raise Ambiguous('Multiple declaration interpretations')
    row,bindings=solutions[0]
    return row.choices,tuple(resolve(arg,bindings) for arg in row.arguments)

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
