# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental recursive module calls with typed scoped arguments.

No child is independently selected/defaulted. Value-dependent signatures use
checked candidate prefixes; general backward contextual discovery is pending.
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
            from cleanlang.proof_types import callable_view
            template=callable_view(template,builder.env)
            if template is None or not builder.env.is_function_type(template):
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


def joined_row(parts,*,choice=0,result=(),equations=()):
    rows=[row for row,_ in parts]
    return Row((choice,),tuple(t for r in rows for t in r.carriers),
               tuple(t for r in rows for t in r.arguments)+tuple(result),
               tuple(eq for r in rows for eq in r.equations)+tuple(equations),
               tuple(check for r in rows for check in r.deferred))


def checked_prefix_value(builder,parts):
    """Check one enumerated prefix, without selecting or applying defaults."""
    bindings=saturate(joined_row(parts),limit=builder.limit)
    row,retain=parts[-1]
    arguments=tuple(resolve(t,bindings) for t in row.arguments)
    if any(variables(t) for t in arguments):
        raise Incomplete('Dependent scoped prefix needs unresolved contextual arguments')
    return retain(Selection(row.choices,arguments,(),None))


def prepare_call_alternatives(builder,tree,expected=None):
    """Carry checked value-dependent signatures through every argument branch.

    Prefix materialization is candidate validation, never a child selection.
    Unavailable checking in any still-viable branch prevents a success claim.
    """
    if builder.limit<=1:raise Incomplete('Scoped expression resource limit exceeded')
    env=builder.env;scope=builder.scope;name=tree[1] if tree[0]=='Call' else None
    local=tree[0]=='Apply' or (name in scope and env.is_function_type(scope[name].type))
    implicit_actuals={};head_tree=None;steps=0
    if local:
        if len(tree[2])!=1:raise NoSolution('Local scoped application requires exactly one argument')
        head_tree=tree[1] if tree[0]=='Apply' else ['Local',name]
        if holes(head_tree):
            child=Builder(env,scope,builder.limit-1,binder_ids=builder.binder_ids,
                          binder_path=builder.binder_path,row_namespace=builder.row_namespace+(1,))
            if head_tree[0]=='Lambda':
                rows,retain,typ=prepare_lambda_head(child,head_tree,expected)
                heads=[(row,retain,typ) for row in rows]
            elif head_tree[0] in ('Call','Apply'):
                heads=prepare_call_alternatives(child,head_tree)
            else:raise Incomplete('Scoped application head needs contextual type recovery')
            states=[(((row,retain),),{},typ,typ) for row,retain,typ in heads]
        else:
            typ=builder.check_candidate(head_tree).type
            states=[((),{},typ,typ)]
        explicit=None
    else:
        spec=env.data['functions'].get(name)
        if spec is None:raise NoSolution('Unknown scoped consumer')
        signature=builder.signature(spec)
        implicit_actuals=(recover_scoped_implicits(builder,spec,signature,tree[2])
                          if any(p.visibility!='explicit' for p in signature.parameters) else {})
        explicit=[p for p in signature.parameters if p.visibility=='explicit']
        if len(tree[2])!=len(explicit):raise NoSolution('Scoped consumer arity mismatch')
        states=[((),dict(implicit_actuals),None,None)]

    for i,source in enumerate(tree[2]):
        following=[]
        for parts,known,current,head_type in states:
            if local:
                from cleanlang.proof_types import callable_view
                view=callable_view(current,env)
                if view is None or not env.is_function_type(view):continue
                domain=view.args[0]
                dependent=isinstance(view,DependentFunctionType) and occurs(view.codomain,view.binder)
            else:
                parameter=explicit[i]
                domain=substitute(parameter.typ,known,env,scope)
                dependent=(occurs(signature.result,parameter.name) or
                           any(occurs(p.typ,parameter.name) for p in explicit[i+1:]))
            child=Builder(env,scope,builder.limit-1,binder_ids=builder.binder_ids,
                          binder_path=builder.binder_path,row_namespace=builder.row_namespace+(2,i))
            try:rows,retain=prepare_expression(child,source,domain)
            except NoSolution:continue
            for row in rows:
                steps+=1
                if steps>builder.limit:raise Incomplete('Scoped consumer candidate limit exceeded')
                candidate=parts+((row,retain),);values=dict(known)
                try:
                    actual=checked_prefix_value(builder,candidate) if dependent else None
                    if local:
                        result=(substitute(view.codomain,{view.binder:actual},env,scope)
                                if dependent else view.args[1])
                    else:
                        if dependent:values[parameter.name]=actual
                        result=None
                except NoSolution:continue
                following.append((candidate,values,result,head_type))
        states=following
        if not states:raise NoSolution('No checked scoped argument interpretation')

    alternatives=[]
    for parts,known,current,head_type in states:
        result_type=current if local else substitute(signature.result,known,env,scope)
        result_term=builder.typ(result_type,{})
        equations=() if expected is None else ((result_term,builder.typ(expected,{})),)
        row=joined_row(parts,result=(result_term,),equations=equations)
        head_part=local and holes(head_tree)
        def retain(selected,parts=parts,result_term=result_term,head_type=head_type,head_part=head_part):
            arguments=[];argument_offset=0;carrier_offset=0
            for child_row,child_retain in parts:
                width=len(child_row.arguments);count=len(child_row.carriers)
                trace=Selection(child_row.choices,selected.arguments[argument_offset:argument_offset+width],
                    tuple(p-carrier_offset for p in selected.defaulted_positions if carrier_offset<=p<carrier_offset+count),
                    selected.default_carrier)
                arguments.append(child_retain(trace))
                argument_offset+=width;carrier_offset+=count
            if local:
                if not head_part and builder.check_candidate(head_tree).type!=head_type:
                    raise Incomplete('Local scoped consumer type changed during reconstruction')
            else:builder.signature(spec)
            retained_head=tree[1]
            if head_part:
                retained=arguments.pop(0)
                if retained.type!=head_type:raise Incomplete('Retained application head type mismatch')
                retained_head=retained.tree
            value=builder.check_candidate([tree[0],retained_head,[arg.tree for arg in arguments]])
            retained_implicits=dict(value.inferred_args)
            for parameter_name,actual in implicit_actuals.items():
                retained=retained_implicits.get(parameter_name)
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
        alternatives.append((row,retain,result_type))
    return alternatives


def prepare_call(builder,tree,expected=None):
    alternatives=prepare_call_alternatives(builder,tree,expected)
    rows=tuple(Row((i,),r.carriers,r.arguments,r.equations,r.deferred)
               for i,(r,_,_) in enumerate(alternatives))
    def retain(selected):
        row,emit,_=alternatives[selected.choices[0]]
        return emit(Selection(row.choices,selected.arguments,selected.defaulted_positions,selected.default_carrier))
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
