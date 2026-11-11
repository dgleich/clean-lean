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
class IndexExpression:
    """Retained checked syntax; its operation is not assumed injective."""
    identity: str
    arguments: tuple=()
    sort: str='index'

    def __post_init__(self):
        if self.sort!='index':raise ValueError('Index-expression sort must be index')

@dataclass(frozen=True)
class Reference:
    """A lexical local reference, distinct from an opaque checked atom."""
    binder: object
    sort: str

@dataclass(frozen=True)
class Bound:
    """De Bruijn reference: zero denotes the nearest enclosing Binder body."""
    level: int
    sort: str

    def __post_init__(self):
        if type(self.level) is not int or self.level<0:raise ValueError('Natural bound-reference level required')

@dataclass(frozen=True)
class Binder:
    identity: str
    domain: object
    body: object
    sort: str='type'


def well_scoped(term,*,limit=4096):
    """Validate explicit bound references before decomposing equations."""
    pending=[(term,0)];visits=0
    while pending:
        visits+=1
        if visits>limit:raise Incomplete('Binder well-scoping limit exceeded')
        node,depth=pending.pop()
        if isinstance(node,Bound):
            if node.level>=depth:raise Incomplete('Malformed input contains a dangling bound reference')
        elif isinstance(node,(Carrier,IndexExpression)):pending.extend((a,depth) for a in node.arguments)
        elif isinstance(node,Binder):pending.extend(((node.domain,depth),(node.body,depth+1)))
        elif not isinstance(node,(Variable,Atom,Reference)):raise Incomplete('Unknown scoped term')


def abstract(binder,domain,body,*,identity='Pi',sort='type',limit=4096):
    """Close explicit lexical references, without inspecting opaque atom text.

    A metavariable permitted to depend on the closing local needs contextual
    metavariable substitution, which is deliberately not approximated here.
    """
    visits=0
    def close(term,depth):
        nonlocal visits
        visits+=1
        if visits>limit:raise Incomplete('Binder abstraction limit exceeded')
        if isinstance(term,Reference):return Bound(depth,term.sort) if term.binder==binder else term
        if isinstance(term,Bound):
            if term.level>=depth:raise Incomplete('Input contains a dangling bound reference')
            return term
        if isinstance(term,Variable):
            if binder in term.allowed_binders:raise Incomplete('Contextual metavariable abstraction is not implemented')
            return term
        if isinstance(term,Atom):
            if binder in term.free_binders:raise Incomplete('Opaque binder dependency cannot be abstracted structurally')
            return term
        if isinstance(term,(Carrier,IndexExpression)):return type(term)(term.identity,tuple(close(a,depth) for a in term.arguments),term.sort)
        if isinstance(term,Binder):return Binder(term.identity,close(term.domain,depth),close(term.body,depth+1),term.sort)
        raise Incomplete('Unknown binder abstraction term')
    try:
        well_scoped(domain,limit=limit)
        return Binder(identity,domain,close(body,0),sort)
    except RecursionError as error:raise Incomplete('Binder abstraction recursion exhausted') from error


def instantiate(binder,argument,*,limit=4096):
    """Capture-free structural substitution; domain typing is a separate constraint.

    The argument must have no dangling de Bruijn references at its own root.
    Free lexical references are allowed and remain free under nested binders.
    """
    if not isinstance(binder,Binder):raise Incomplete('Instantiation requires a binder node')
    well_scoped(binder,limit=limit);well_scoped(argument,limit=limit)
    visits=0
    def replace(term,depth):
        nonlocal visits
        visits+=1
        if visits>limit:raise Incomplete('Binder instantiation limit exceeded')
        if isinstance(term,Bound):
            if term.level==depth:
                if term.sort!=argument.sort:raise NoSolution('Bound argument sort mismatch')
                return argument
            # A well-scoped root Binder has no references outside itself.
            if term.level>depth:raise Incomplete('Instantiation found an external bound reference')
            return term
        if isinstance(term,(Carrier,IndexExpression)):return type(term)(term.identity,tuple(replace(a,depth) for a in term.arguments),term.sort)
        if isinstance(term,Binder):return Binder(term.identity,replace(term.domain,depth),replace(term.body,depth+1),term.sort)
        if isinstance(term,(Variable,Atom,Reference)):return term
        raise Incomplete('Unknown binder instantiation term')
    try:
        result=replace(binder.body,0)
        well_scoped(result,limit=limit)
        return result
    except RecursionError as error:raise Incomplete('Binder instantiation recursion exhausted') from error


def open_binder(binder,local,sort,*,limit=4096):
    """Expose a binder with a genuinely fresh explicit lexical reference."""
    if not isinstance(binder,Binder):raise Incomplete('Opening requires a binder node')
    well_scoped(binder,limit=limit)
    pending=[binder];visits=0
    while pending:
        visits+=1
        if visits>limit:raise Incomplete('Binder opening freshness limit exceeded')
        term=pending.pop()
        if isinstance(term,Reference):occupied=term.binder==local
        elif isinstance(term,Atom):occupied=local in term.free_binders
        elif isinstance(term,Variable):occupied=local in term.allowed_binders
        else:occupied=False
        if occupied:raise Incomplete('Opening local is not fresh in the binder scope')
        if isinstance(term,(Carrier,IndexExpression)):pending.extend(term.arguments)
        elif isinstance(term,Binder):pending.extend((term.domain,term.body))
    return instantiate(binder,Reference(local,sort),limit=limit)


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
    if isinstance(term,(Carrier,IndexExpression)):return type(term)(term.identity,tuple(resolve(a,bindings) for a in term.arguments),term.sort)
    if isinstance(term,Binder):return Binder(term.identity,resolve(term.domain,bindings),resolve(term.body,bindings),term.sort)
    return term


def variables(term):
    if isinstance(term,Variable):return {term}
    if isinstance(term,(Carrier,IndexExpression)):return set().union(*(variables(a) for a in term.arguments))
    if isinstance(term,Binder):return variables(term.domain)|variables(term.body)
    return set()


def check_scopes(bindings,*,limit=4096):
    """Every solved metavariable may depend only on its declared binder scope.

    Revisit aliases on every unification boundary: a later substitution can expose
    a forbidden dependency through a previously unresolved inner variable.
    """
    visits=0
    for variable,value in bindings.items():
        pending=[(value,0)];seen=set()
        while pending:
            visits+=1
            if visits>limit:raise Incomplete('Scope dependency analysis limit exceeded')
            term,depth=pending.pop()
            if isinstance(term,Variable):
                if (term,depth) in seen:continue
                seen.add((term,depth))
                if term in bindings:pending.append((bindings[term],depth))
            elif isinstance(term,(Carrier,IndexExpression)):pending.extend((a,depth) for a in term.arguments)
            elif isinstance(term,Binder):pending.extend(((term.domain,depth),(term.body,depth+1)))
            elif isinstance(term,Bound):
                if term.level>=depth:raise NoSolution('Metavariable solution contains a dangling bound reference')
            elif isinstance(term,Reference):
                if term.binder not in variable.allowed_binders:raise NoSolution('Metavariable solution escapes its binder scope')
            elif isinstance(term,Atom):
                if not term.free_binders.issubset(variable.allowed_binders):
                    raise NoSolution('Metavariable solution escapes its binder scope')
            else:raise Incomplete('Unknown scoped constraint term')


def unify(equations,bindings=None,*,limit=4096):
    bindings=dict(bindings or {});pending=list(equations);steps=0
    for left,right in pending:
        well_scoped(left,limit=limit);well_scoped(right,limit=limit)
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
        if isinstance(left,Binder) and isinstance(right,Binder):
            if left.identity!=right.identity:raise NoSolution('Different binder constructors')
            pending[0:0]=[(left.domain,right.domain),(left.body,right.body)];continue
        if isinstance(left,IndexExpression) or isinstance(right,IndexExpression):
            raise Incomplete('Retained index expressions require checked conversion, not injective decomposition')
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
                if not isinstance(value,(Atom,Carrier,Binder,Reference,IndexExpression)) or variables(value):
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
