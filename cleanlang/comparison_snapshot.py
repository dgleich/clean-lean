# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Ephemeral semantic graph snapshots; no persistent IDs or elaboration cache."""
from dataclasses import fields
from .annotations import Annotation
from .core import CleanError
from .retained_codec import SCHEMA,TRANSIENT


class SnapshotUnavailable(CleanError):
    """An optional cache key could not be built; perform ordinary comparison."""


def snapshot(value,*,limit=512):
    if type(limit) is not int or limit<1:raise ValueError('Snapshot limit must be positive')
    # Repeated objects are visited once per snapshot. Mutable values are read
    # afresh on every invocation; sharing can cause a safe cache miss, not a hit
    # between different semantic values. Retain references during traversal.
    nodes=[];seen={};active=set();references=[];visits=0
    def visit(item):
        nonlocal visits
        visits+=1
        if visits>limit:raise SnapshotUnavailable('Optional comparison snapshot budget exceeded')
        if type(item) in (str,int,bool) or item is None:
            return ('atom',type(item).__name__,item)
        identity=id(item)
        if identity in active:raise SnapshotUnavailable('Comparison snapshots do not support cycles')
        if identity in seen:return ('ref',seen[identity])
        ordinal=len(nodes);seen[identity]=ordinal;nodes.append(None);references.append(item)
        active.add(identity)
        try:
            if isinstance(item,Annotation):
                node=('Annotation',str(item),visit(item.typ),tuple(sorted(item.names)))
            elif type(item) in (list,tuple):
                node=(type(item).__name__,tuple(visit(x) for x in item))
            else:
                for tag,(cls,names) in SCHEMA.items():
                    if type(item) is cls:
                        if {f.name for f in fields(item)}!=set(names)|TRANSIENT.get(tag,set()):
                            raise SnapshotUnavailable('Comparison snapshot schema requires an update: '+tag)
                        node=(tag,tuple(visit(getattr(item,name)) for name in names))
                        break
                else:raise SnapshotUnavailable('Unsupported comparison snapshot value: '+type(item).__name__)
            nodes[ordinal]=node
            return ('ref',ordinal)
        finally:active.remove(identity)
    root=visit(value)
    return (root,tuple(nodes))

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
