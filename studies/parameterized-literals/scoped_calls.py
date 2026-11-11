# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental direct module calls with typed scoped arguments.

No child is independently selected/defaulted. Signature dependencies must already
be determined by checked hole-free arguments; general contextual discovery is pending.
"""
from itertools import product
from cleanlang.dependent_functions import occurs,substitute
from cleanlang.numeral_inference import holes,default_carrier
from constraint_model import Row,Selection,Incomplete,NoSolution
from contextual_constraints import Candidate,select_contextual
from scoped_bodies import ScopedBody
from clean_rows import Builder


def materialize_call(builder,tree,expected=None,*,use_default=True):
    env=builder.env;scope=builder.scope;name=tree[1]
    if name in scope and env.is_function_type(scope[name].type):
        raise Incomplete('Scoped local-function calls need contextual signature integration')
    spec=env.data['functions'].get(name)
    if spec is None:raise NoSolution('Unknown scoped consumer')
    signature=builder.signature(spec)
    if any(p.visibility!='explicit' for p in signature.parameters):
        raise Incomplete('Scoped consumers with implicit parameters need joint signature recovery')
    if len(tree[2])!=len(signature.parameters):raise NoSolution('Scoped consumer arity mismatch')
    known={};unresolved=set();parts=[]
    for i,(parameter,source) in enumerate(zip(signature.parameters,tree[2])):
        if any(occurs(parameter.typ,n) for n in unresolved):
            raise Incomplete('Scoped parameter type depends on an unresolved earlier value')
        typ=substitute(parameter.typ,known,env,scope)
        path=builder.row_namespace+(2,i)
        if source[0] in ('Lambda','Forall','Exists'):
            if source[0]=='Lambda' and not env.is_function_type(typ):
                from cleanlang.proof_types import callable_view
                if callable_view(typ,env) is not None:
                    raise Incomplete('Scoped callable evidence needs joint proof-type integration')
            child=ScopedBody(env,scope,source,typ,path=path,limit=builder.limit,binder_ids=builder.binder_ids)
            rows=child.rows()
            retain=child.retain
        else:
            child=Builder(env,scope,builder.limit,binder_ids=builder.binder_ids,
                          binder_path=builder.binder_path,row_namespace=path)
            rows=child.rows(source,typ)
            retain=lambda selection,child=child,source=source,typ=typ:child.retain_selected(source,selection,typ)
        parts.append((rows,retain))
        if holes(source):unresolved.add(parameter.name)
        else:known[parameter.name]=builder.check_candidate(source)
    if any(occurs(signature.result,n) for n in unresolved):
        raise Incomplete('Scoped result depends on an unresolved selected value')
    result_type=substitute(signature.result,known,env,scope)
    result_term=builder.typ(result_type,{})
    expected_equations=() if expected is None else ((result_term,builder.typ(expected,{})),)
    count=1
    for rows,_ in parts:
        count*=len(rows)
        if count>builder.limit:raise Incomplete('Scoped consumer candidate limit exceeded')
    combinations=[];candidates=[]
    for rows in product(*(rows for rows,_ in parts)):
        row=Row((len(combinations),),tuple(t for r in rows for t in r.carriers),
                tuple(t for r in rows for t in r.arguments)+(result_term,),
                tuple(eq for r in rows for eq in r.equations)+expected_equations,
                tuple(check for r in rows for check in r.deferred))
        combinations.append(rows);candidates.append(Candidate(row))
    default_name=default_carrier(env) if use_default else None
    default=builder.typ(env.type(default_name),{}) if default_name is not None else None
    selected=select_contextual(candidates,default=default,limit=builder.limit).selection
    rows=combinations[selected.choices[0]];arguments=[];argument_offset=0;carrier_offset=0
    for row,(_,retain) in zip(rows,parts):
        width=len(row.arguments);count=len(row.carriers)
        trace=Selection(row.choices,selected.arguments[argument_offset:argument_offset+width],
            tuple(p-carrier_offset for p in selected.defaulted_positions if carrier_offset<=p<carrier_offset+count),
            selected.default_carrier)
        arguments.append(retain(trace))
        argument_offset+=width;carrier_offset+=count
    builder.signature(spec) # Revalidate the declaration identity before final emission.
    value=builder.check_candidate(['Call',name,[arg.tree for arg in arguments]])
    if builder.typ(value.type,{})!=result_term:
        raise Incomplete('Reconstructed scoped consumer result differs from the selected type')
    return value

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
