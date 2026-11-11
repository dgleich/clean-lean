# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental recursive module calls with typed scoped arguments.

No child is independently selected/defaulted. Signature dependencies must already
be determined by checked hole-free arguments; general contextual discovery is pending.
"""
from itertools import product
from cleanlang.dependent_functions import occurs,substitute,DependentFunctionType
from cleanlang.numeral_inference import holes,default_carrier
from .constraint_model import Row,Selection,Incomplete,NoSolution,saturate,resolve,variables
from .contextual_constraints import Candidate,select_contextual
from .scoped_bodies import ScopedBody
from .clean_rows import Builder


def prepare_lambda_head(builder,tree,expected_result=None):
    """Discover a common checked codomain without selecting body alternatives."""
    from cleanlang.core import Type
    from .witness_model import Resolver,Seed
    domain=builder.env.type(tree[2],builder.scope,phrases=False)
    # Only a closed nullary nominal expectation can be propagated here without
    # inventing an indexed/dependent codomain family from one application.
    expected=(builder.env.function_type(domain,expected_result)
              if type(expected_result) is Type and not expected_result.args else None)
    child=ScopedBody(builder.env,builder.scope,tree,expected,path=builder.row_namespace,
                     limit=builder.limit,binder_ids=builder.binder_ids)
    rows=child.rows();types=[];viable=[];body=child.builder
    names={body.carrier_identity(n):n for n,spec in builder.env.data['types'].items()
           if 'native_binding' in spec or n in builder.env.structures}
    def assemble(term,args):
        if term.identity not in names:raise Incomplete('Direct lambda codomain has no declared carrier')
        return Type(names[term.identity],args)
    for row in rows:
        try:bindings=saturate(row,limit=builder.limit)
        except NoSolution:continue
        result=resolve(row.arguments[-1],bindings)
        if variables(result):raise Incomplete('Direct lambda codomain remains unresolved')
        representatives=Resolver(bindings,
            [Seed(term,value,(0,i)) for i,(term,value) in enumerate(body.rigid.items())],
            validate=lambda term,value:body.typ(value,{})==term,
            assemble=assemble,limit=builder.limit,
            available=body.witness_available,allowed_binders=frozenset(body.binder_ids.values()))
        codomain=(body.row_values[row.choices].representative(result,bindings)
                  if not contains_scoped_holes(tree[3]) else representatives.get(result))
        if types and codomain!=types[0]:raise Incomplete('Direct lambda alternatives need joint codomain recovery')
        types.append(codomain);viable.append(row)
    if not viable:raise NoSolution('Direct lambda has no viable body')
    from cleanlang.dependent_functions import inferred_type
    name=tree[1]
    head_type=inferred_type(name,body.scope[name].lean,domain,types[0],builder.env,builder.scope)
    return tuple(viable),child.retain,head_type


def recover_scoped_implicits(builder,spec,signature,sources):
    """Recover only from checked argument types and explicit lambda domains.

    No body alternatives, defaults or result expectations participate here.
    All evidence is collected before choosing source-ordered representatives.
    """
    from .constraint_model import unify
    from cleanlang.inferred_conversion import reify
    from cleanlang.core import CleanError
    implicit=[p for p in signature.parameters if p.visibility!='explicit']
    explicit=[p for p in signature.parameters if p.visibility=='explicit']
    if len(sources)!=len(explicit):raise NoSolution('Scoped consumer arity mismatch')
    formals,_=builder.telescope(spec,builder.row_namespace+('scoped signature',))
    equations=[];evidence=[]
    checked={p.name:builder.check_candidate(source) for p,source in zip(explicit,sources) if not holes(source)}
    names={p.name for p in implicit}
    for parameter,source in zip(explicit,sources):
        template=parameter.typ
        if not any(occurs(template,n) for n in names):continue
        if source[0]=='Lambda':
            if not builder.env.is_function_type(template):
                raise Incomplete('Scoped implicit recovery needs a declared function domain')
            template=template.args[0]
            actual=builder.env.type(source[2],builder.scope,phrases=False)
        elif parameter.name in checked:actual=checked[parameter.name].type
        else:continue
        if not any(occurs(template,n) for n in names):continue
        eqs,values=builder.dependent_argument_constraints(template,actual,formals,signature,with_evidence=True)
        equations.extend(eqs);evidence.extend(values)
    bindings=unify(equations,limit=builder.limit)
    recovered={}
    for parameter in implicit:
        variable=formals[parameter.name];term=resolve(variable,bindings)
        if variables(term):raise Incomplete('Scoped implicit parameter lacks checked argument evidence: '+parameter.name)
        values=[value for candidate,value in evidence if candidate==variable]
        if not values:raise Incomplete('Scoped implicit parameter has no checked representative: '+parameter.name)
        value=values[0]  # Source argument order, then structural type order.
        if builder.typ(value,{})!=term:raise Incomplete('Scoped implicit representative disagrees with constraints')
        known={**checked,**recovered}
        if any(occurs(parameter.typ,p.name) and p.name not in known for p in signature.parameters):
            raise Incomplete('Scoped implicit classifier depends on an unresolved argument')
        classifier=substitute(parameter.typ,known,builder.env,builder.scope)
        try:actual=reify(value,builder.env,builder.scope,classifier=classifier if parameter.classifier is not None else None)
        except (CleanError,RecursionError) as error:
            raise Incomplete('Scoped implicit representative cannot be rechecked: '+str(error)) from error
        if actual.type!=classifier:raise NoSolution('Scoped implicit argument classifier mismatch')
        recovered[parameter.name]=actual
    return recovered


def prepare_typed_call(builder,tree,expected=None):
    if builder.limit<=1:raise Incomplete('Scoped expression resource limit exceeded')
    env=builder.env;scope=builder.scope;name=tree[1] if tree[0]=='Call' else None
    inputs=[];head_part=None;implicit_actuals={}
    if tree[0]=='Apply' or name in scope:
        if len(tree[2])!=1:raise NoSolution('Local scoped application requires exactly one argument')
        head_tree=tree[1] if tree[0]=='Apply' else ['Local',name]
        if holes(head_tree):
            child=Builder(env,scope,builder.limit-1,binder_ids=builder.binder_ids,
                          binder_path=builder.binder_path,row_namespace=builder.row_namespace+(1,))
            if head_tree[0]=='Lambda':
                head_rows,head_retain,head_type=prepare_lambda_head(child,head_tree,expected)
            elif head_tree[0] in ('Call','Apply'):
                head_rows,head_retain,head_type=prepare_typed_call(child,head_tree)
            else:raise Incomplete('Scoped application head needs contextual type recovery')
            head_part=(head_rows,head_retain)
        else:head_type=builder.check_candidate(head_tree).type
        # Evidence carries its condition, not a two-slot function signature.
        # Use the existing source-derived view while retaining the original head.
        from cleanlang.proof_types import callable_view
        current=callable_view(head_type,env)
        for source in tree[2]:
            if current is None or not env.is_function_type(current):
                raise NoSolution('Local scoped consumer has too many arguments or is not callable')
            inputs.append((current.args[0],source))
            if isinstance(current,DependentFunctionType) and occurs(current.codomain,current.binder):
                if holes(source):
                    raise Incomplete('Local scoped result depends on an unresolved selected value')
                actual=builder.check_candidate(source)
                current=substitute(current.codomain,{current.binder:actual},env,scope)
            else:current=current.args[1]
        result_type=current
        def revalidate():
            if head_part is None and builder.check_candidate(head_tree).type!=head_type:
                raise Incomplete('Local scoped consumer type changed during reconstruction')
    else:
        spec=env.data['functions'].get(name)
        if spec is None:raise NoSolution('Unknown scoped consumer')
        signature=builder.signature(spec)
        implicit_actuals=(recover_scoped_implicits(builder,spec,signature,tree[2])
                          if any(p.visibility!='explicit' for p in signature.parameters) else {})
        explicit=[p for p in signature.parameters if p.visibility=='explicit']
        if len(tree[2])!=len(explicit):raise NoSolution('Scoped consumer arity mismatch')
        known=dict(implicit_actuals);unresolved=set()
        for parameter,source in zip(explicit,tree[2]):
            if any(occurs(parameter.typ,n) for n in unresolved):
                raise Incomplete('Scoped parameter type depends on an unresolved earlier value')
            inputs.append((substitute(parameter.typ,known,env,scope),source))
            if holes(source):unresolved.add(parameter.name)
            else:known[parameter.name]=builder.check_candidate(source)
        if any(occurs(signature.result,n) for n in unresolved):
            raise Incomplete('Scoped result depends on an unresolved selected value')
        result_type=substitute(signature.result,known,env,scope)
        revalidate=lambda:builder.signature(spec)
    parts=[] if head_part is None else [head_part]
    for i,(typ,source) in enumerate(inputs):
        path=builder.row_namespace+(2,i)
        child=Builder(env,scope,builder.limit-1,binder_ids=builder.binder_ids,
                      binder_path=builder.binder_path,row_namespace=path)
        rows,retain=prepare_expression(child,source,typ)
        parts.append((rows,retain))
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
    def retain(selected):
        rows=combinations[selected.choices[0]];arguments=[];argument_offset=0;carrier_offset=0
        for row,(_,retain) in zip(rows,parts):
            width=len(row.arguments);count=len(row.carriers)
            trace=Selection(row.choices,selected.arguments[argument_offset:argument_offset+width],
                tuple(p-carrier_offset for p in selected.defaulted_positions if carrier_offset<=p<carrier_offset+count),
                selected.default_carrier)
            arguments.append(retain(trace))
            argument_offset+=width;carrier_offset+=count
        revalidate() # Recheck the local head or module declaration before emission.
        retained_head=tree[1]
        if head_part is not None:
            retained=arguments.pop(0)
            if retained.type!=head_type:raise Incomplete('Retained application head type mismatch')
            retained_head=retained.tree
        value=builder.check_candidate([tree[0],retained_head,[arg.tree for arg in arguments]])
        retained_implicits=dict(value.inferred_args)
        for name,actual in implicit_actuals.items():
            retained=retained_implicits.get(name)
            if retained is not None:
                from cleanlang.inferred_conversion import reify
                from cleanlang.core import CleanError
                try:retained=reify(retained,env,scope,classifier=actual.type if env.classifier_info(actual.type) is not None else None)
                except (CleanError,RecursionError) as error:
                    raise Incomplete('Retained scoped implicit cannot be rechecked: '+str(error)) from error
            if retained is None or retained.type!=actual.type or retained.lean!=actual.lean:
                raise Incomplete('Retained scoped implicit differs from its checked source representative')
        if builder.typ(value.type,{})!=result_term:
            raise Incomplete('Reconstructed scoped consumer result differs from the selected type')
        return value
    return tuple(c.row for c in candidates),retain,result_type


def prepare_call(builder,tree,expected=None):
    rows,retain,_=prepare_typed_call(builder,tree,expected)
    return rows,retain


def contains_scoped_holes(tree):
    pending=[tree]
    while pending:
        node=pending.pop()
        if not isinstance(node,list) or not node:continue
        if node[0] in ('Lambda','Forall','Exists') and holes(node):return True
        pending.extend(x for x in node if isinstance(x,list))
    return False


def prepare_expression(builder,tree,expected=None):
    """Enumerate recursively; never select or default a child expression."""
    if builder.limit<=1:raise Incomplete('Scoped expression resource limit exceeded')
    if tree[0] in ('Lambda','Forall','Exists'):
        if tree[0]=='Lambda' and expected is None:
            raise Incomplete('Nested lambda needs a determined callable expectation')
        if tree[0]=='Lambda' and not builder.env.is_function_type(expected):
            from cleanlang.proof_types import callable_view
            if callable_view(expected,builder.env) is not None:
                raise Incomplete('Scoped callable evidence needs joint proof-type integration')
        child=ScopedBody(builder.env,builder.scope,tree,expected,path=builder.row_namespace,
                         limit=builder.limit,binder_ids=builder.binder_ids)
        return child.rows(),child.retain
    if tree[0] in ('Call','Apply') and contains_scoped_holes(tree):
        return prepare_call(builder,tree,expected)
    return builder.rows(tree,expected),lambda selection:builder.retain_selected(tree,selection,expected)


def materialize_call(builder,tree,expected=None,*,use_default=True):
    try:
        rows,retain=prepare_call(builder,tree,expected)
        default_name=default_carrier(builder.env) if use_default else None
        default=builder.typ(builder.env.type(default_name),{}) if default_name is not None else None
        selected=select_contextual([Candidate(row) for row in rows],default=default,limit=builder.limit).selection
        return retain(selected)
    except RecursionError as error:
        raise Incomplete('Scoped expression recursion limit exceeded') from error

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
