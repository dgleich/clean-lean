# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental simultaneous contextual constraints; no source-language entry point.

Ordinary equations and contextual occurrences share one substitution. No defaults
or declaration search occur here. Ground occurrences determine contextual closures;
known closures constrain all remaining occurrences by checked application.
"""
from dataclasses import dataclass
from .constraint_model import variables,resolve,unify,well_scoped,Incomplete,NoSolution
from .contextual_terms import Parameter,Actual,solve_pattern,apply_solution

@dataclass(frozen=True)
class Family:
    identity: str
    parameters: tuple
    sort: str
    allowed_free: frozenset=frozenset()

@dataclass(frozen=True)
class Occurrence:
    identity: str
    family: str
    actuals: tuple
    output: object

@dataclass(frozen=True)
class Result:
    bindings: dict
    solutions: dict


def solve(equations,families,occurrences,*,deferred=(),limit=4096):
    """Saturate a finite contextual problem or report its unresolved boundary.

    Ready occurrences are checked as a batch. An unavailable ready check dominates
    a mismatch in that batch, so iteration order cannot hide unknown applicability.
    """
    if type(limit) is not int or limit<1:raise ValueError('Positive contextual constraint limit required')
    declarations={}
    for family in families:
        if not isinstance(family.identity,str) or family.identity in declarations:
            raise Incomplete('Contextual family identities must be unique strings')
        declarations[family.identity]=family
    pending=list(occurrences)
    names=[o.identity for o in pending]
    if any(not isinstance(n,str) for n in names) or len(set(names))!=len(names):
        raise Incomplete('Contextual occurrence identities must be unique strings')
    if any(o.family not in declarations for o in pending):raise Incomplete('Unknown contextual family')
    bindings=unify(equations,limit=limit);solutions={};steps=0;forward=list(deferred)
    try:
        while pending or forward:
            ready=[];waiting=[];forward_ready=[];forward_waiting=[]
            for occurrence in pending:
                steps+=1
                if steps>limit:raise Incomplete('Contextual constraint step limit exceeded')
                family=declarations[occurrence.family]
                parameters=tuple(Parameter(p.name,resolve(p.domain,bindings),p.sort) for p in family.parameters)
                actuals=tuple(Actual(a.reference,resolve(a.typ,bindings)) for a in occurrence.actuals)
                output=resolve(occurrence.output,bindings)
                if (any(variables(p.domain) for p in parameters) or
                    any(variables(a.typ) for a in actuals) or
                    (variables(output) and family.identity not in solutions)):
                    waiting.append(occurrence)
                else:ready.append((occurrence,family,parameters,actuals,output))
            for obligation in forward:
                steps+=1
                if steps>limit:raise Incomplete('Contextual constraint step limit exceeded')
                inputs=tuple(resolve(t,bindings) for t in obligation.inputs)
                if any(variables(t) for t in inputs):forward_waiting.append(obligation)
                else:forward_ready.append((obligation,inputs))
            if not ready and not forward_ready:raise Incomplete('Contextual constraints have unresolved dependencies')
            proposals={};new_equations=[];incomplete=False;mismatch=False
            # Ordering controls only reproducible diagnostics, never acceptance.
            for occurrence,family,parameters,actuals,output in sorted(ready,key=lambda entry:entry[0].identity):
                try:
                    if output.sort!=family.sort:raise NoSolution('Contextual output sort mismatch')
                    if family.identity in solutions:
                        value=apply_solution(solutions[family.identity],actuals,limit=limit)
                        if value.sort!=family.sort:raise NoSolution('Contextual solution sort mismatch')
                        # Classify this checked occurrence before combining its equations.
                        # In particular, unavailable ground conversion cannot be
                        # hidden by a different ready occurrence's mismatch.
                        unify(((output,value),),bindings,limit=limit)
                        new_equations.append((occurrence.output,value))
                    else:
                        solution=solve_pattern(parameters,actuals,output,
                                               allowed_free=family.allowed_free,limit=limit)
                        prior=proposals.get(family.identity)
                        if prior is not None:unify(((prior.closure,solution.closure),),limit=limit)
                        else:proposals[family.identity]=solution
                except Incomplete:incomplete=True
                except NoSolution:mismatch=True
            for obligation,inputs in forward_ready:
                try:
                    value=obligation.evaluate(inputs)
                    well_scoped(value,limit=limit)
                    if variables(value):raise Incomplete('Forward check returned unresolved output')
                    unify(((resolve(obligation.output,bindings),value),),bindings,limit=limit)
                    new_equations.append((obligation.output,value))
                except Incomplete:incomplete=True
                except NoSolution:mismatch=True
            if incomplete:raise Incomplete('A contextual applicability check is incomplete')
            if mismatch:raise NoSolution('A contextual occurrence rejects the shared solution')
            bindings=unify(new_equations,bindings,limit=limit)
            solutions.update(proposals)
            pending=waiting;forward=forward_waiting
        return Result(bindings,solutions)
    except RecursionError as error:raise Incomplete('Contextual constraints exhausted recursion') from error


def saturate_contextual(row,families,occurrences,*,limit=4096):
    """Use one ordinary Row's equations/checks in the contextual fixed point.

    This does not select among rows or apply defaults. Callers must still validate
    all candidate rows, retained witnesses and emitted arguments before selection.
    """
    return solve(row.equations,families,occurrences,deferred=row.deferred,limit=limit)

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md

@dataclass(frozen=True)
class Candidate:
    row: object
    families: tuple=()
    occurrences: tuple=()

@dataclass(frozen=True)
class Selected:
    selection: object
    solutions: dict


def select_contextual(candidates,*,default=None,enumeration_complete=True,limit=4096):
    """Check every contextual candidate before ordinary simultaneous defaults.

    The fully checked bindings are retained as equations in an ordinary Row.
    Contextual outputs/domains are already ground and cannot be changed by defaults.
    """
    from .constraint_model import Row,Selection,select_with_trace
    if not enumeration_complete:raise Incomplete('Contextual candidate enumeration unfinished')
    candidates=tuple(candidates)
    if len(candidates)>limit:raise Incomplete('Contextual candidate row limit exceeded')
    if len({len(c.row.carriers) for c in candidates})>1:
        raise ValueError('Contextual rows must describe the same literal positions')
    checked=[];closures=[];source_choices=[]
    for candidate in candidates:
        try:result=saturate_contextual(candidate.row,candidate.families,candidate.occurrences,limit=limit)
        except NoSolution:continue
        row=candidate.row
        # No check is dropped: saturation has discharged every occurrence and
        # forward obligation. Selection retains all arguments and literal positions.
        checked.append(Row((len(checked),),row.carriers,row.arguments,tuple(result.bindings.items())))
        source_choices.append(row.choices)
        closures.append(result.solutions)
    selected=select_with_trace(checked,default=default,limit=limit)
    # The ordinal is an opaque association token, not a tie-breaker. The existing
    # selector must prove uniqueness before returning it; rejected rows are never
    # replayed against the selected row's emitted argument values.
    index=selected.choices[0]
    restored=Selection(source_choices[index],selected.arguments,
                       selected.defaulted_positions,selected.default_carrier)
    return Selected(restored,closures[index])
