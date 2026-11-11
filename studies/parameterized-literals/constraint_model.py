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
    allowed_binders: frozenset=frozenset()

    def __post_init__(self):
        if not isinstance(self.allowed_binders,frozenset):raise TypeError('Binder permissions must be immutable')

@dataclass(frozen=True)
class Atom:
    identity: str
    sort: str
    free_binders: frozenset=frozenset()

    def __post_init__(self):
        if not isinstance(self.free_binders,frozenset):raise TypeError('Binder dependencies must be immutable')

@dataclass(frozen=True)
class Carrier:
    identity: str
    arguments: tuple=()
    sort: str='type'

@dataclass(frozen=True)
class Deferred:
    """Pure forward check: ground inputs -> checked ground value, no inversion."""
    output: object
    inputs: tuple
    evaluate: object


@dataclass(frozen=True)
class Row:
    choices: tuple
    carriers: tuple
    arguments: tuple
    equations: tuple=()
    deferred: tuple=()


def resolve(term,bindings):
    if isinstance(term,Variable) and term in bindings:return resolve(bindings[term],bindings)
    if isinstance(term,Carrier):return Carrier(term.identity,tuple(resolve(a,bindings) for a in term.arguments))
    return term


def variables(term):
    if isinstance(term,Variable):return {term}
    if isinstance(term,Carrier):return set().union(*(variables(a) for a in term.arguments))
    return set()


def check_scopes(bindings,*,limit=4096):
    """Every solved metavariable may depend only on its declared binder scope.

    Revisit aliases on every unification boundary: a later substitution can expose
    a forbidden dependency through a previously unresolved inner variable.
    """
    visits=0
    for variable,value in bindings.items():
        pending=[value];seen=set()
        while pending:
            visits+=1
            if visits>limit:raise Incomplete('Scope dependency analysis limit exceeded')
            term=pending.pop()
            if isinstance(term,Variable):
                if term in seen:continue
                seen.add(term)
                if term in bindings:pending.append(bindings[term])
            elif isinstance(term,Carrier):pending.extend(term.arguments)
            elif isinstance(term,Atom):
                if not term.free_binders.issubset(variable.allowed_binders):
                    raise NoSolution('Metavariable solution escapes its binder scope')
            else:raise Incomplete('Unknown scoped constraint term')


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
    check_scopes(bindings,limit=limit)
    return bindings


def saturate(row,*,limit=4096):
    """Resolve all forward obligations before considering defaults or selection.

    Callbacks must be deterministic and side-effect free under a fixed checked
    environment. NoSolution means a proved mismatch, never unavailable checking.
    Unsupported checking raises Incomplete and cannot discard a competitor.
    """
    bindings=unify(row.equations,limit=limit)
    pending=list(row.deferred);visits=0
    while pending:
        ready=[];waiting=[]
        for obligation in pending:
            visits+=1
            if visits>limit:raise Incomplete('Deferred constraint step limit exceeded')
            inputs=tuple(resolve(t,bindings) for t in obligation.inputs)
            if any(variables(t) for t in inputs):waiting.append(obligation)
            else:ready.append((obligation,inputs))
        if not ready:
            raise Incomplete('Deferred checking has unresolved inputs; defaults cannot establish applicability')
        equations=[];incomplete=False;mismatch=False
        for obligation,inputs in ready:
            try:
                value=obligation.evaluate(inputs)
                if not isinstance(value,(Atom,Carrier)) or variables(value):
                    raise Incomplete('Deferred check did not return a checked ground value')
                equations.append((obligation.output,value))
            except Incomplete:incomplete=True
            except NoSolution:mismatch=True
        # Batch outcomes do not depend on the order of independent ready checks.
        if incomplete:raise Incomplete('A deferred applicability check is incomplete')
        if mismatch:raise NoSolution('A deferred applicability check rejected the row')
        bindings=unify(equations,bindings,limit=limit)
        pending=waiting
    return bindings


@dataclass(frozen=True)
class Selection:
    choices: tuple
    arguments: tuple
    defaulted_positions: tuple
    default_carrier: object=None

    @property
    def result(self):return self.choices,self.arguments


def select_with_trace(rows,*,default=None,enumeration_complete=True,limit=4096):
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
        try:bindings=saturate(row,limit=limit)
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
    return Selection(row.choices,tuple(resolve(arg,bindings) for arg in row.arguments),
                     tuple(restrictions),default if restrictions else None)


def select(rows,*,default=None,enumeration_complete=True,limit=4096):
    """Return choices and arguments from the same exhaustive traced selection."""
    return select_with_trace(rows,default=default,
        enumeration_complete=enumeration_complete,limit=limit).result

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
