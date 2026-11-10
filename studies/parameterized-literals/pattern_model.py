# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Executable design model only: determined-carrier literal pattern matching.

Input nodes are an independently specified symbolic IR, not Clean ASTs. This
module is not imported by the compiler and does not implement joint inference.
"""
from dataclasses import dataclass


class Ineligible(ValueError): pass
class NoMatch(ValueError): pass
class Incomplete(RuntimeError): pass


@dataclass(frozen=True)
class Parameter:
    identity: str


@dataclass(frozen=True)
class Constructor:
    identity: str
    arguments: tuple


@dataclass(frozen=True)
class Fixed:
    value: object


@dataclass(frozen=True)
class Check:
    identity: str
    dependencies: tuple


def validate(pattern, parameters):
    """Every formal must have a direct occurrence; checks never recover formals."""
    if len(set(parameters)) != len(parameters):
        raise Ineligible('Duplicate parameter identity')
    declared=set(parameters);direct=set();used=set()
    def visit(node):
        if isinstance(node,Parameter):direct.add(node.identity);used.add(node.identity)
        elif isinstance(node,Constructor):
            for child in node.arguments:visit(child)
        elif isinstance(node,Fixed):pass
        elif isinstance(node,Check):used.update(node.dependencies)
        else:raise Ineligible('Unsupported pattern constructor')
    visit(pattern)
    if used-declared:raise Ineligible('Undeclared parameter identity')
    if declared-direct:raise Ineligible('Parameter has no direct recovery occurrence')
    if not isinstance(pattern,Constructor):
        raise Ineligible('Result requires a declared carrier constructor')


def match(pattern, parameters, actual, *, equal, evaluate, typed):
    """Recover first, then validate all equations and the parameter telescope.

Actuals contain no inference metavariables. `equal` and `typed` must return
literal booleans; None signals incomplete analysis. `evaluate` must return a
fully determined term or raise Incomplete. No callback failure is swallowed.
"""
    validate(pattern,parameters)
    bindings={};equations=[];checks=[]
    def require(answer):
        if answer is None:raise Incomplete('Comparison or parameter typing unfinished')
        if answer is False:raise NoMatch('Pattern constraints do not hold')
        if answer is not True:raise TypeError('Expected True, False or None')
    def recover(node,value):
        if isinstance(node,Constructor):
            if not isinstance(value,Constructor):raise NoMatch('Different carrier shape')
            if (node.identity,len(node.arguments)) != (value.identity,len(value.arguments)):
                raise NoMatch('Different carrier constructor or arity')
            for child,arg in zip(node.arguments,value.arguments):recover(child,arg)
        elif isinstance(node,Parameter):
            if node.identity in bindings:equations.append((bindings[node.identity],value))
            else:bindings[node.identity]=value
        elif isinstance(node,Fixed):equations.append((node.value,value))
        elif isinstance(node,Check):checks.append((node,value))
    recover(pattern,actual)
    # Telescope checks receive earlier parameters only. A declaration cannot use
    # a later parameter in an earlier formal's type.
    earlier={}
    for parameter in parameters:
        require(typed(parameter,bindings[parameter],dict(earlier)))
        earlier[parameter]=bindings[parameter]
    for left,right in equations:require(equal(left,right))
    for node,value in checks:
        args=tuple(bindings[p] for p in node.dependencies)
        require(equal(evaluate(node.identity,args),value))
    return tuple(bindings[p] for p in parameters)

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
