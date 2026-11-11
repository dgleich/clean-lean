# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Declaration-time callable types for consumers that must not reparse spellings.

Internal metadata under a fixed checked environment, not a persistence format or
an integrity boundary against arbitrary Python mutation of checked type graphs.
"""
from dataclasses import dataclass
from .core import CleanError


def freeze(value):
    return tuple(freeze(x) for x in value) if isinstance(value,(list,tuple)) else value


@dataclass(frozen=True)
class Parameter:
    name: str
    typ: object
    visibility: str
    classifier: object


@dataclass(frozen=True)
class Signature:
    parameters: tuple
    result: object
    source: tuple
    native: tuple


def capture(env,name,parameters,result):
    spec=env.data['functions'][name]
    key=spec['native_binding']
    spec['checked_signature']=Signature(
        tuple(Parameter(n,t,v,env.classifier_info(t)) for n,t,v in parameters),
        result,freeze((spec['signature_tree'],spec['params'],spec['returns'])),
        (key,spec['lean'],env.notation_definitions[key]))


def require(env,spec):
    checked=spec.get('checked_signature')
    if not isinstance(checked,Signature):raise CleanError('Missing checked callable signature')
    key=spec.get('native_binding')
    if checked.native!=(key,spec.get('lean'),env.notation_definitions.get(key)):
        raise CleanError('Changed checked callable binding')
    if checked.source!=freeze((spec.get('signature_tree'),spec.get('params'),spec.get('returns'))):
        raise CleanError('Changed checked callable signature')
    if any(env.classifier_info(p.typ)!=p.classifier for p in checked.parameters):
        raise CleanError('Changed checked callable classifier')
    return checked

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
