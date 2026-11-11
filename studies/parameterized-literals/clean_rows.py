# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental Clean-signature adapter for the joint constraint model.

Not production elaboration: general binder/evidence/dependent constraints and
retained-target construction remain explicit gaps. Unsupported competitors raise
Incomplete; they are never discarded as mismatches.
"""
from dataclasses import dataclass
from itertools import product
from cleanlang.core import Type,LocalType,ValueIndex,Expressions,CleanError
from cleanlang.callable_signatures import require
from cleanlang.numeral_inference import holes,default_carrier
from cleanlang.numerals import digits,identity
from cleanlang.operator_bindings import token
from constraint_model import Variable,Atom,Carrier,Row,Deferred,saturate,Incomplete,Ambiguous,NoSolution,select_with_trace,unify,resolve,variables

@dataclass(frozen=True)
class Fragment:
    typ: object
    value: object
    choices: tuple=()
    carriers: tuple=()
    arguments: tuple=()
    equations: tuple=()
    deferred: tuple=()
    witnesses: tuple=()
    syntax: object=None
    origins: tuple=()
    fields: tuple=()
    parameters: tuple=()
    plans: tuple=()

class Builder:
    def __init__(self,env,scope,limit=4096,*,binder_ids=None,binder_path=()):
        if type(limit) is not int or limit<1:raise ValueError('Positive row limit required')
        self.binder_ids=dict(binder_ids or {});self.binder_path=tuple(binder_path)
        if not set(self.binder_ids).issubset(scope):raise ValueError('Binder identities require checked locals')
        self.env=env;self.scope=scope;self.limit=limit;self.rigid={};self.known={};self.known_values={};self.formal_classifiers={}

    def variable(self,identity,sort):
        return Variable(identity,sort,frozenset(self.binder_ids.values()))

    def dependencies(self,value,*,normalize=True):
        if not self.binder_ids:return frozenset()
        from cleanlang.annotations import references
        from cleanlang.core import Expr
        from cleanlang.inferred_conversion import reify
        from cleanlang.conversion import comparison_normal_form
        from cleanlang.dependent_functions import DependentFunctionType
        pending=[value];seen={};names=set();bound_dependencies=set();visits=0
        while pending:
            visits+=1
            if visits>self.limit:raise Incomplete('Checked binder dependency limit exceeded')
            current=pending.pop()
            if id(current) in seen:continue
            seen[id(current)]=current
            if isinstance(current,ValueIndex):
                pending.append(reify(current,self.env,self.scope))
            elif isinstance(current,LocalType):names.update(references(current,self.scope))
            elif isinstance(current,DependentFunctionType):
                from cleanlang.dependent_functions import fresh_source,fresh_bound,substitute
                from cleanlang.core import texid
                if visits>=self.limit:raise Incomplete('Checked binder dependency limit exceeded')
                name=fresh_source(current.binder,self.env,self.scope,{})
                local=Expr(fresh_bound(self.env,self.scope),texid(name),current.domain,tree=['Local',name])
                scope={**self.scope,name:local}
                try:
                    codomain=substitute(current.codomain,{current.binder:local},self.env,scope)
                    child=Builder(self.env,scope,self.limit-visits,binder_ids=self.binder_ids)
                    bound_dependencies.update(child.dependencies(codomain,normalize=normalize))
                except (CleanError,RecursionError) as error:
                    raise Incomplete('Dependent binder dependency checking unavailable: '+str(error)) from error
                pending.append(current.domain)
            elif type(current) is Type:pending.extend(current.args)
            elif isinstance(current,Type):
                raise Incomplete('Binder dependencies of this type constructor remain unsupported')
            elif isinstance(current,Expr):
                checked=comparison_normal_form(current,self.env,self.scope) if normalize else current
                names.update(references(checked,self.scope))
                pending.append(checked.type)
                pending.extend(v for _,v in checked.inferred_args)
                if checked.checked_args is not None:pending.extend(checked.checked_args)
            else:raise Incomplete('Checked binder dependency representation unsupported')
        return frozenset(bound_dependencies)|frozenset(self.binder_ids[n] for n in names if n in self.binder_ids)

    def witness_available(self,value,allowed):
        if not self.binder_ids:return True
        if not self.dependencies(value,normalize=False).issubset(allowed):return False
        if isinstance(value,ValueIndex):
            from cleanlang.inferred_conversion import reify
            scope={n:v for n,v in self.scope.items() if n not in self.binder_ids or self.binder_ids[n] in allowed}
            try:reify(value,self.env,scope)
            except CleanError as error:raise Incomplete('Witness destination-scope checking unavailable: '+str(error)) from error
        return True

    def carrier_identity(self,name):
        spec=self.env.data['types'].get(name,{})
        key=spec.get('native_binding')
        if key is None:key=self.env.structures.get(name,{}).get('key')
        if key is None:raise Incomplete('Undeclared carrier identity')
        return key

    def index(self,value):
        classifier=self.env.classifier_info(value.type)
        if classifier is not None:
            if classifier[1]!=0:raise Incomplete('Higher classifier operand')
            from cleanlang.carrier_types import carrier
            checked=carrier(value,self.env,self.scope)
            return self.typ(checked,{}),checked
        from cleanlang.indices import index_value
        index=index_value(value,self.env,self.scope,_fresh=True)
        atom=Atom(repr(index.comparison_key()),'index',self.dependencies(index))
        return atom,index

    def known_index(self,value):
        atom,index=self.index(value)
        self.rigid.setdefault(atom,index)
        return atom

    def typ(self,typ,formals=None):
        capture=formals is None
        formals={} if formals is None else formals
        from cleanlang.dependent_functions import DependentFunctionType,type_key,occurs
        if isinstance(typ,DependentFunctionType):
            if self.env.sort_level(typ)!=1:raise Incomplete('Higher dependent function carrier')
            if any(occurs(typ,name) for name in formals):
                raise Incomplete('Symbolic dependent function template requires binder constraints')
            atom=Atom(repr(('dependent function',type_key(typ))),'type',self.dependencies(typ))
            if capture:self.rigid.setdefault(atom,typ)
            return atom
        if isinstance(typ,LocalType):
            if typ.name in formals:return formals[typ.name]
            if typ.universe!=0:raise Incomplete('Higher local carrier')
            atom=Atom(typ.lean,'type',self.dependencies(typ))
            if capture:self.rigid.setdefault(atom,typ)
            return atom
        if isinstance(typ,ValueIndex):
            if typ.name in formals:return formals[typ.name]
            from cleanlang.dependent_functions import occurs
            if any(occurs(typ,name) for name in formals):
                raise Incomplete('Computed formal index requires deferred checking')
            atom=Atom(repr(typ.comparison_key()),'index',self.dependencies(typ))
            if capture:self.rigid.setdefault(atom,typ)
            return atom
        if type(typ) is not Type:raise Incomplete('Unsupported carrier constructor: '+type(typ).__name__)
        key=self.carrier_identity(typ.name)
        classifier=self.env.classifier_info(typ)
        if self.env.sort_level(typ)!=1 and (classifier is None or classifier[1]!=0):
            raise Incomplete('Only Type-0 carriers and their closed classifiers in this adapter')
        return Carrier(key,tuple(self.typ(a,None if capture else formals) for a in typ.args))

    def dependent_type(self,typ,formals,evidence,path):
        """Forward-check computed formal indices from concrete argument witnesses.

        No inverse arithmetic and no candidate-provided caller representatives.
        Evidence is row-local and rechecked, including before retained emission.
        """
        from cleanlang.dependent_functions import occurs
        if isinstance(typ,ValueIndex) and typ.name not in formals:
            names=tuple(n for n in formals if occurs(typ,n))
            if names:
                output=self.variable(repr((path,'computed formal index')),'index')
                if any(n not in evidence for n in names):
                    from candidate_values import IndexPlan
                    return output,(IndexPlan(output,typ,tuple((n,formals[n]) for n in names)),),()
                def witness(defaulted=()):
                    from cleanlang.indices import substitute_index
                    from cleanlang.inferred_conversion import reify
                    if any(n not in evidence for n in names):
                        raise Incomplete('Computed formal index lacks concrete argument evidence')
                    try:
                        actuals={n:evidence[n](defaulted) for n in names}
                        return reify(substitute_index(typ,actuals,self.env,self.scope),self.env,self.scope)
                    except CleanError as error:
                        raise Incomplete('Computed formal index checking unavailable: '+str(error)) from error
                def evaluate(inputs):
                    if any(n not in evidence for n in names):
                        raise Incomplete('Computed formal index lacks concrete argument evidence')
                    for n,expected in zip(names,inputs):
                        actual=evidence[n]()
                        if self.index(actual)[0]!=expected:
                            raise NoSolution('Computed formal index argument mismatch')
                    return self.index(witness())[0]
                return output,(Deferred(output,tuple(formals[n] for n in names),evaluate),),((output,witness),)
        if type(typ) is Type:
            # The ordinary converter establishes the nominal carrier and sort.
            head=self.typ(Type(typ.name),{})
            children=[self.dependent_type(t,formals,evidence,path+(i,)) for i,t in enumerate(typ.args)]
            return (Carrier(head.identity,tuple(t for t,_,_ in children)),
                    tuple(d for _,ds,_ in children for d in ds),
                    tuple(w for _,_,ws in children for w in ws))
        return self.typ(typ,formals),(),()

    def signature(self,spec):
        try:return require(self.env,spec)
        except CleanError as error:raise Incomplete(str(error)) from error

    def telescope(self,spec,path):
        variables={};implicit=[]
        for p in self.signature(spec).parameters:
            info=p.classifier
            if info is not None and info[1]!=0:raise Incomplete('Higher classifier parameter')
            variables[p.name]=self.variable(repr((path,spec['native_binding'],p.name)), 'type' if info is not None else 'index')
            if info is not None:self.formal_classifiers[variables[p.name]]=p.typ
            if p.visibility=='implicit':implicit.append(variables[p.name])
        return variables,tuple(implicit)

    def call_witness(self,name,key,node,origins):
        def checked(defaulted=()):
            if name is not None:
                spec=self.env.data['functions'][name]
                self.signature(spec)
                if spec['native_binding']!=key:raise Incomplete('Changed deferred callable')
            syntax=node
            def replace_at(tree,path,origin):
                result=list(tree)
                if not path:
                    if tree[0]!='BoundNumeral':raise Incomplete('Missing deferred numeral origin')
                    result[4]=origin
                else:result[path[0]]=replace_at(tree[path[0]],path[1:],origin)
                return result
            for local_path,source_path in origins:
                syntax=replace_at(syntax,local_path,'defaulted' if source_path in defaulted else 'inferred')
            try:return Expressions(self.env,self.scope).elaborate(syntax)
            except CleanError as error:
                raise Incomplete('Deferred call requires unavailable checking: '+str(error)) from error
        return checked

    def projection_fragments(self,tree,path):
        from candidate_values import ValuePlan
        from cleanlang.dependent_functions import occurs
        results=[]
        for base in self.fragments(tree[1],path+(1,)):
            if not isinstance(base.typ,Carrier):raise Incomplete('Projection carrier remains unresolved')
            spec=next((s for s in self.env.structures.values() if s['key']==base.typ.identity),None)
            if spec is None or tree[2] not in dict(spec['fields']):continue
            field_type=dict(spec['fields'])[tree[2]]
            if len(spec['parameters'])!=len(base.typ.arguments):raise Incomplete('Projection parameter arity mismatch')
            formals=dict(zip(spec['parameters'],base.typ.arguments))
            fields=dict(base.fields)
            for name,_ in spec['fields']:
                if name==tree[2]:break
                if occurs(field_type,name):
                    if name not in fields:raise Incomplete('Projection type depends on unavailable record field values')
                    formals[name]=fields[name].value
            arguments=dict(base.parameters)
            if set(arguments).intersection(fields):raise Incomplete('Record parameter/field name collision')
            arguments.update(fields)
            evidence={n:self.call_witness(None,None,a.syntax,a.origins)
                      for n,a in arguments.items() if a.syntax is not None}
            typ,type_deferred,type_witnesses=self.dependent_type(field_type,formals,evidence,path+('field type',))
            selected_field=fields.get(tree[2])
            output=(selected_field.value if selected_field is not None else
                    self.variable(repr((path,spec['key'],tree[2])),'index'))
            syntax=None;origins=();deferred=base.deferred+type_deferred;witnesses=base.witnesses+type_witnesses
            if base.syntax is not None:
                syntax=['Projection',base.syntax,tree[2]]
                origins=tuple(((1,)+local,source) for local,source in base.origins)
                witness=self.call_witness(None,None,syntax,origins)
                def evaluate(inputs,witness=witness):
                    try:
                        value=witness()
                        if self.typ(value.type,{})!=inputs[1]:raise NoSolution('Deferred projection type mismatch')
                        return self.index(value)[0]
                    except CleanError as error:raise Incomplete('Deferred projection checking is unavailable: '+str(error)) from error
                deferred+=(Deferred(output,(base.value,typ),evaluate),)
                witnesses+=((output,witness),)
            plans=base.plans
            if syntax is None:
                requirements=tuple(dict.fromkeys(tuple(t for p in plans for t in p.requirements)+base.arguments))
                plans+=(ValuePlan(output,path,requirements,typ),)
            results.append(Fragment(typ,output,
                base.choices+(('projection',path,(spec['key'],tree[2])),),base.carriers,
                base.arguments,base.equations,deferred,witnesses,syntax,origins,
                selected_field.fields if selected_field is not None else (),
                selected_field.parameters if selected_field is not None else (),plans))
        return results

    def local_call_fragments(self,tree,path):
        return self.checked_application_fragments(self.scope[tree[1]],tree,path,('local call',path,tree[1]))

    def checked_application_fragments(self,function,tree,path,choice):
        from candidate_values import ValuePlan
        from cleanlang.dependent_functions import DependentFunctionType
        if not self.env.is_function_type(function.type) or len(function.type.args)!=2 or len(tree[2])!=1:
            raise Incomplete('Application requires a checked unary function')
        domain,codomain=function.type.args
        domain_term=self.typ(domain)
        results=[]
        for argument in self.fragments(tree[2][0],path+(2,0)):
            formals={};evidence={}
            if isinstance(function.type,DependentFunctionType):
                name=function.type.binder;formals[name]=argument.value
                if argument.syntax is not None:
                    evidence[name]=self.call_witness(None,None,argument.syntax,argument.origins)
            result,deferred,witnesses=self.dependent_type(codomain,formals,evidence,path+('local result',))
            output=self.variable(repr((path,'local application value')),'index')
            requirements=tuple(dict.fromkeys(tuple(t for p in argument.plans for t in p.requirements)+argument.arguments+(argument.typ,result)))
            results.append(Fragment(result,output,
                argument.choices+(choice,),argument.carriers,
                argument.arguments,argument.equations+((argument.typ,domain_term),),
                argument.deferred+deferred,argument.witnesses+witnesses,
                plans=argument.plans+(ValuePlan(output,path,requirements,result),)))
        return results

    def application_fragments(self,tree,path):
        from candidate_values import ValuePlan
        if len(tree[2])!=1:raise Incomplete('Application requires one argument')
        if not holes(tree[1]):
            return self.checked_application_fragments(self.known[path+(1,)],tree,path,('application',path,'checked'))
        heads=self.fragments(tree[1],path+(1,))
        arguments=self.fragments(tree[2][0],path+(2,0))
        if len(heads)*len(arguments)>self.limit:raise Incomplete('Application row limit exceeded')
        functions={self.carrier_identity(n) for n in self.env.data['types'] if self.env.is_function_type(Type(n))}
        results=[]
        for head,argument in product(heads,arguments):
            if not isinstance(head.typ,Carrier):raise Incomplete('Application head type unresolved')
            if head.typ.identity not in functions or len(head.typ.arguments)!=2:continue
            domain,result=head.typ.arguments
            output=self.variable(repr((path,'application value')),'index')
            plans=head.plans+argument.plans
            requirements=tuple(dict.fromkeys(tuple(t for p in plans for t in p.requirements)+head.arguments+argument.arguments+(head.typ,argument.typ,result)))
            results.append(Fragment(result,output,
                head.choices+argument.choices+(('application',path,'inferred'),),head.carriers+argument.carriers,
                head.arguments+argument.arguments,head.equations+argument.equations+((argument.typ,domain),),
                head.deferred+argument.deferred,head.witnesses+argument.witnesses,
                plans=plans+(ValuePlan(output,path,requirements,result),)))
        return results

    def known_fragment(self,value,atom=None,*,optional=False):
        """Expose direct, checked constructor evidence without claiming new holes.

        Child checks do not register representatives: caller priority was already
        established by the prepass. Type-0 classifier values retain their checked carrier evidence.
        """
        try:
            typ=self.typ(value.type,{})
            atom=self.index(value)[0] if atom is None else atom
        except (Incomplete,CleanError):
            if optional:return None
            raise
        base=Fragment(typ,atom,syntax=value.tree)
        tree=value.tree
        if not tree or tree[0] not in ('Call','ModuleCall'):return base
        if tree[0]=='Call' and tree[1] in self.scope and self.env.is_function_type(self.scope[tree[1]].type):return base
        record=next((s for s in self.env.structures.values() if isinstance(typ,Carrier) and s['key']==typ.identity),None)
        if record is None or tree[1]!=record['constructor']:return base
        spec=self.env.data['functions'][tree[1]]
        signature=self.signature(spec)
        if tree[0]=='ModuleCall' and tree[3]!=spec['lean']:raise Incomplete('Changed known constructor binding')
        parameters=signature.parameters
        if len(tree[2])!=len(parameters):raise Incomplete('Known constructor arity mismatch')
        arguments={}
        for p,node in zip(parameters,tree[2]):
            try:checked=Expressions(self.env,self.scope).elaborate(node)
            except CleanError as error:raise Incomplete('Known constructor argument check unavailable: '+str(error)) from error
            child=self.known_fragment(checked,optional=True)
            if child is not None:arguments[p.name]=child
        return Fragment(typ,atom,syntax=value.tree,
            fields=tuple((n,arguments[n]) for n,_ in record['fields'] if n in arguments),
            parameters=tuple((n,arguments[n]) for n in record['parameters'] if n in arguments))

    def fragments(self,tree,path=()):
        from candidate_values import ValuePlan
        if not holes(tree):
            if path not in self.known or path not in self.known_values:
                raise Incomplete('Known argument lacks checked index evidence')
            return [self.known_fragment(self.known[path],self.known_values[path])]
        kind=tree[0]
        if kind=='Projection':return self.projection_fragments(tree,path)
        if kind=='Apply':return self.application_fragments(tree,path)
        if kind=='Call' and tree[1] in self.scope and self.env.is_function_type(self.scope[tree[1]].type):
            return self.local_call_fragments(tree,path)
        if kind=='Decimal':
            text=digits(tree[1]);found=[]
            for name,spec in sorted(self.env.data['types'].items()):
                if 'numerals' not in spec:continue
                node=['BoundNumeral',text,name,identity(name,self.env),'inferred']
                value=Expressions(self.env,self.scope).elaborate(node)
                carrier=self.typ(value.type)
                found.append(Fragment(carrier,self.index(value)[0],
                    (('numeral',path,spec['numerals']['native_binding']),),(carrier,),
                    syntax=node,origins=(((),path),)))
            for name,spec in sorted(self.env.data['functions'].items()):
                attachment=spec.get('literal')
                if attachment is None or attachment['digits']!=text:continue
                key,template,declaration=attachment['snapshot']
                if (spec['native_binding'],spec['lean'],self.env.notation_definitions.get(key))!=(key,template,declaration):
                    raise Incomplete('Changed literal declaration')
                variables,_=self.telescope(spec,path)
                carrier,deferred,witnesses=self.dependent_type(attachment['result'],variables,{},path+('literal result',))
                output=self.variable(repr((path,key,'value')),'index')
                found.append(Fragment(carrier,output,
                    (('literal',path,key),),(carrier,),tuple(variables.values()),
                    deferred=deferred,witnesses=witnesses,plans=(ValuePlan(output,path,tuple(variables.values())+(carrier,),carrier),)))
            if len(found)>self.limit:raise Incomplete('Literal declaration row limit exceeded')
            return found
        if kind in ('Operator','Unary'):
            fixity='infix' if kind=='Operator' else 'prefix'
            names=getattr(self.env,'operator_overloads' if kind=='Operator' else 'prefix_overloads',{}).get(token(tree[1],fixity),[])
            children=[(tree[i],path+(i,)) for i in range(2,len(tree))]
        elif kind=='Call':
            if tree[1] not in self.env.data['functions']:return []
            names=[tree[1]];children=[(arg,path+(2,i)) for i,arg in enumerate(tree[2])]
        else:raise Incomplete('Joint row generation does not cover '+kind)
        parts=[self.fragments(child,childpath) for child,childpath in children]
        count=len(names)
        for part in parts:count*=len(part)
        if count>self.limit:raise Incomplete('Callable declaration row limit exceeded')
        rows=[]
        for name in sorted(names,key=lambda n:self.env.data['functions'][n]['native_binding']):
            spec=self.env.data['functions'][name]
            if len(spec['params'])!=len(children):raise Incomplete('Callable arity mismatch')
            variables,implicit=self.telescope(spec,path)
            signature=self.signature(spec)
            explicit=[p for p in signature.parameters if p.visibility=='explicit']
            for actuals in product(*parts):
                evidence={p.name:self.call_witness(None,None,a.syntax,a.origins)
                          for p,a in zip(explicit,actuals) if a.syntax is not None}
                converted=[self.dependent_type(p.typ,variables,evidence,path+('parameter',p.name)) for p in explicit]
                result,result_deferred,result_witnesses=self.dependent_type(signature.result,variables,evidence,path+('result',))
                parameters=[t for t,_,_ in converted]
                type_deferred=tuple(d for _,ds,_ in converted for d in ds)+result_deferred
                type_witnesses=tuple(w for _,_,ws in converted for w in ws)+result_witnesses
                equations=tuple(eq for a in actuals for eq in a.equations)
                equations+=tuple(zip(parameters,(a.typ for a in actuals)))
                equations+=tuple((variables[p.name],a.value) for p,a in zip(explicit,actuals))
                output=self.variable(repr((path,spec['native_binding'],'value')),'index')
                deferred=tuple(d for a in actuals for d in a.deferred)+type_deferred
                witnesses=tuple(w for a in actuals for w in a.witnesses)+type_witnesses
                syntax=None;origins=()
                if all(a.syntax is not None for a in actuals):
                    syntax=['ModuleCall',name,[a.syntax for a in actuals],spec['lean']]
                    if kind in ('Operator','Unary'):syntax.append([fixity,token(tree[1],fixity)])
                    origins=tuple(((2,i)+local,source) for i,a in enumerate(actuals) for local,source in a.origins)
                    witness=self.call_witness(name,spec['native_binding'],syntax,origins)
                    implicit_names=tuple(p.name for p in signature.parameters if p.visibility=='implicit')
                    def evaluate(inputs,witness=witness,implicit_names=implicit_names):
                        try:
                            value=witness()
                            if value.checked_args is None:raise Incomplete('Missing deferred checked arguments')
                            for actual,expected in zip(value.checked_args,inputs):
                                if self.index(actual)[0]!=expected:raise NoSolution('Deferred argument value mismatch')
                            inferred=dict(value.inferred_args)
                            for name,expected in zip(implicit_names,inputs[len(value.checked_args):]):
                                if name not in inferred:raise Incomplete('Missing deferred implicit argument')
                                if self.typ(inferred[name],{})!=expected:raise NoSolution('Deferred implicit argument mismatch')
                            return self.index(value)[0]
                        except CleanError as error:
                            raise Incomplete('Deferred checked index is unsupported: '+str(error)) from error
                    deferred+=(Deferred(output,tuple(a.value for a in actuals)+implicit,evaluate),)
                    witnesses+=((output,witness),)
                plans=tuple(p for a in actuals for p in a.plans)
                if syntax is None:
                    requirements=tuple(dict.fromkeys(tuple(t for p in plans for t in p.requirements)+tuple(t for a in actuals for t in a.arguments)+implicit))
                    plans+=(ValuePlan(output,path,requirements,result),)
                fields=();record_arguments=()
                if isinstance(result,Carrier):
                    record=next((s for s in self.env.structures.values() if s['key']==result.identity),None)
                    if record is not None and record['constructor']==name:
                        record_arguments=tuple(zip(record['parameters'],actuals[:len(record['parameters'])]))
                        values=actuals[len(record['parameters']):]
                        if len(values)!=len(record['fields']):raise Incomplete('Constructor field arity mismatch')
                        fields=tuple((n,a) for (n,_),a in zip(record['fields'],values))
                rows.append(Fragment(result,output,
                    tuple(c for a in actuals for c in a.choices)+(('call',path,spec['native_binding']),),
                    tuple(t for a in actuals for t in a.carriers),
                    tuple(t for a in actuals for t in a.arguments)+implicit,equations,
                    deferred,witnesses,syntax,origins,fields,record_arguments,plans))
        return rows

    def rows(self,tree,expected=None):
        # Caller representatives are collected in source order before any
        # declaration enumeration, so candidate order cannot choose an index's
        # emitted spelling. The explicit expected type is visited afterward.
        self.rigid={};self.known={};self.known_values={};self.formal_classifiers={}
        def prepare(node,path):
            if not holes(node):
                value=Expressions(self.env,self.scope).elaborate(node)
                self.known[path]=value;self.typ(value.type)
                try:self.known_values[path]=self.known_index(value)
                except CleanError as error:
                    raise Incomplete('Known argument index is unsupported: '+str(error)) from error
                return
            if node[0]=='Apply':
                if not holes(node[1]):
                    from cleanlang.dependent_functions import DependentFunctionType
                    head=Expressions(self.env,self.scope).elaborate(node[1])
                    self.known[path+(1,)]=head
                    if not isinstance(head.type,DependentFunctionType):self.typ(head.type)
                else:prepare(node[1],path+(1,))
                for i,arg in enumerate(node[2]):prepare(arg,path+(2,i))
            elif node[0]=='Projection':prepare(node[1],path+(1,))
            elif node[0]=='Call':
                for i,arg in enumerate(node[2]):prepare(arg,path+(2,i))
            elif node[0] in ('Operator','Unary'):
                for i in range(2,len(node)):prepare(node[i],path+(i,))
        prepare(tree,())
        if expected is not None:self.typ(expected)
        fragments=self.fragments(tree)
        from candidate_values import CandidateValues
        self.row_witnesses={f.choices:f.witnesses for f in fragments}
        self.row_values={};rows=[]
        for f in fragments:
            arguments=f.carriers+f.arguments+(f.typ,)
            equations=f.equations+(((f.typ,self.typ(expected)),) if expected is not None else ())
            try:values=CandidateValues(self,tree,f,equations,arguments)
            except NoSolution:continue
            self.row_values[f.choices]=values
            row=Row(f.choices,f.carriers,arguments,equations,values.checks())
            try:values.validate_ground_applications(saturate(row,limit=self.limit))
            except NoSolution:continue
            rows.append(row)
        return rows

    def solve_with_trace(self,tree,expected=None,*,use_default=True):
        name=default_carrier(self.env) if use_default else None
        default=self.typ(self.env.type(name)) if name is not None else None
        selected=select_with_trace(self.rows(tree,expected),default=default,limit=self.limit)
        self.audit_operators(tree,selected.result)
        return selected

    def solve(self,tree,expected=None,*,use_default=True):
        return self.solve_with_trace(tree,expected,use_default=use_default).result

    def audit_operators(self,tree,selected):
        # Return-type constraints must not break a tie between operators whose
        # input signatures accept the same already-selected literal assignment.
        choices,arguments=selected
        fixed=dict(zip((path for path,_ in holes(tree)),arguments))
        literals={(kind,path):key for kind,path,key in choices if kind in ('literal','numeral')}
        def walk(node,path):
            if not holes(node):return
            kind=node[0]
            if kind in ('Operator','Unary'):
                viable=set()
                local_paths=[path+relative for relative,_ in holes(node)]
                for f in self.fragments(node,path):
                    if any(literals.get((k,p))!=key for k,p,key in f.choices if k in ('literal','numeral')):continue
                    constraints=f.equations+tuple((t,fixed[p]) for t,p in zip(f.carriers,local_paths))
                    try:
                        from candidate_values import CandidateValues
                        values=CandidateValues(self,tree,f,constraints,f.carriers+f.arguments)
                        bindings=saturate(Row((),(),(),constraints,values.checks()),limit=self.limit)
                        values.validate_ground_applications(bindings)
                    except NoSolution:continue
                    if any(variables(resolve(t,bindings)) for t in f.arguments):
                        raise Incomplete('Operator input applicability remains unresolved')
                    viable.add(f.choices[-1][2])
                if len(viable)>1:raise Ambiguous('Operator input signatures are ambiguous independently of the expected result')
                for i in range(2,len(node)):walk(node[i],path+(i,))
            elif kind=='Apply':
                walk(node[1],path+(1,))
                for i,arg in enumerate(node[2]):walk(arg,path+(2,i))
            elif kind=='Projection':walk(node[1],path+(1,))
            elif kind=='Call':
                for i,arg in enumerate(node[2]):walk(arg,path+(2,i))
        walk(tree,())


    def materialize_binder(self,tree,expected,use_default):
        from cleanlang.core import Expr,texid
        from cleanlang.dependent_functions import fresh_bound,DependentFunctionType,substitute
        kind,name,domain_source,body_tree=tree
        if name in self.scope or any(name in self.env.data[k] for k in ('functions','types','aliases')):
            raise Incomplete('Binder must be fresh in the fixed source scope')
        domain=self.env.type(domain_source,self.scope,phrases=False)
        bound=fresh_bound(self.env,self.scope)
        local=Expr(bound,texid(name),domain,tree=['Local',name])
        scope={**self.scope,name:local}
        body_expected=None
        if kind in ('Forall','Exists'):
            body_expected=self.env.type('Proposition')
            if expected is not None and expected!=body_expected:raise NoSolution('Quantifier expected type mismatch')
        elif expected is not None:
            if not self.env.is_function_type(expected) or len(expected.args)!=2:
                raise NoSolution('Lambda expected type is not a supported function')
            if domain!=expected.args[0]:raise NoSolution('Lambda domain mismatch')
            body_expected=(substitute(expected.codomain,{expected.binder:local},self.env,scope)
                           if isinstance(expected,DependentFunctionType) else expected.args[1])
        if self.limit<=1:raise Incomplete('Binder traversal resource limit exceeded')
        binder_ids={**self.binder_ids,name:('binder',self.binder_path)}
        body=Builder(self.env,scope,self.limit-1,binder_ids=binder_ids,binder_path=self.binder_path+(3,)).materialize(
            body_tree,body_expected,use_default=use_default)
        # Re-elaborate the whole binder: annotations rebind their captured source
        # references to the compiler's final binder, not the temporary check name.
        return Expressions(self.env,self.scope).elaborate([kind,name,domain_source,body.tree],expected)

    def materialize(self,tree,expected=None,*,use_default=True):
        """Recheck one selected row while retaining simultaneous default origins.

        This demonstrates retained targets; it does not discharge exhaustive
        validation of every partially solved dependent row for production use.
        """
        if tree[0] in ('Forall','Exists','Lambda'):
            try:return self.materialize_binder(tree,expected,use_default)
            except RecursionError as error:raise Incomplete('Binder traversal recursion limit exceeded') from error
        selected=self.solve_with_trace(tree,expected,use_default=use_default)
        choices,actual_arguments=selected.result
        positions=holes(tree)
        defaulted={positions[i][0] for i in selected.defaulted_positions}
        row=next(row for row in self.rows(tree,expected) if row.choices==choices)
        bindings=saturate(Row(row.choices,row.carriers,row.arguments,
            row.equations+tuple(zip(row.arguments,actual_arguments)),row.deferred),limit=self.limit)
        from cleanlang.annotations import Annotation,references
        from cleanlang.bound_calls import bind
        from cleanlang.inferred_conversion import reify
        from cleanlang.literal_binding import snapshot,elaborate as literal
        selected_literals={(kind,path):key for kind,path,key in choices if kind in ('literal','numeral')}
        # Only the selected scalar interpretations can supply additional
        # representatives. Visit holes in source order, after caller evidence.
        for path,decimal in positions:
            key=selected_literals.get(('numeral',path))
            if key is None:continue
            name=next(n for n,s in self.env.data['types'].items()
                      if s.get('numerals',{}).get('native_binding')==key)
            origin='defaulted' if path in defaulted else 'inferred'
            value=Expressions(self.env,self.scope).elaborate(
                ['BoundNumeral',decimal,name,identity(name,self.env),origin])
            self.known_index(value)
        for output,witness in self.row_witnesses[choices]:
            value=witness(defaulted)
            if self.index(value)[0]!=resolve(output,bindings):raise Incomplete('Deferred result changed during retention')
            self.known_index(value)
        values=self.row_values[choices]
        for plan in values.index_plans:
            value=values.index_expression(plan,bindings,defaulted)
            if self.index(value)[0]!=resolve(plan.output,bindings):raise Incomplete('Formal index changed during retention')
            self.known_index(value)
        for plan in values.active:
            value=values.expression(plan.path,bindings,defaulted)
            if self.index(value)[0]!=resolve(plan.output,bindings):raise Incomplete('Candidate value changed during retention')
            self.known_index(value)
        types={self.carrier_identity(n):n for n,s in self.env.data['types'].items()
               if 'native_binding' in s or n in self.env.structures}
        functions={s['native_binding']:n for n,s in self.env.data['functions'].items()}
        from witness_model import Resolver,Seed
        representatives=Resolver(bindings,
            tuple(Seed(term,value,(i,)) for i,(term,value) in enumerate(self.rigid.items())),
            validate=lambda term,value:self.typ(value,{})==term,
            assemble=lambda term,args:Type(types[term.identity],args),limit=self.limit,
            available=self.witness_available,allowed_binders=frozenset(self.binder_ids.values()))
        actual=representatives.get
        def replace(node,path):
            if node[0]=='Decimal':
                origin='defaulted' if path in defaulted else 'inferred'
                if ('numeral',path) in selected_literals:
                    key=selected_literals['numeral',path]
                    name=next(n for n,s in self.env.data['types'].items() if s.get('numerals',{}).get('native_binding')==key)
                    return ['BoundNumeral',node[1],name,identity(name,self.env),origin]
                name=functions[selected_literals['literal',path]];spec=self.env.data['functions'][name]
                formal,_=self.telescope(spec,path)
                recovered={n:actual(value) for n,value in formal.items()}
                target=actual(self.dependent_type(spec['literal']['result'],formal,{},path+('literal result',))[0])
                args=[[p.name,p.visibility,bind(reify(recovered[p.name],self.env,self.scope,
                                     classifier=p.typ).tree,self.env,self.scope,binders=True)]
                      for p in self.signature(spec).parameters]
                retained=['BoundLiteral',digits(node[1]),node[1],name,snapshot(name,self.env),args,
                          Annotation(str(target),target,references(target,self.scope)),origin]
                literal(retained,self.env,self.scope)
                return retained
            if node[0]=='Apply':return ['Apply',replace(node[1],path+(1,)),[replace(a,path+(2,i)) for i,a in enumerate(node[2])]]
            if node[0]=='Projection':return [node[0],replace(node[1],path+(1,)),node[2]]
            if node[0]=='Call':return [node[0],node[1],[replace(a,path+(2,i)) for i,a in enumerate(node[2])]]
            if node[0] in ('Operator','Unary'):return [*node[:2],*[replace(node[i],path+(i,)) for i in range(2,len(node))]]
            return node
        rebuilt=replace(tree,())
        result=Expressions(self.env,self.scope).elaborate(rebuilt,expected)
        expected_calls={path:key for kind,path,key in choices if kind=='call'}
        def check(value,path):
            source=rebuilt
            for i in path:source=source[i]
            if source[0]=='Apply':
                check(Expressions(self.env,self.scope).elaborate(source[1]),path+(1,))
                for i,arg in enumerate(source[2]):check(Expressions(self.env,self.scope).elaborate(arg),path+(2,i))
                return
            if source[0]=='Projection':
                check(Expressions(self.env,self.scope).elaborate(source[1]),path+(1,))
                return
            if source[0]=='Call' and ('local call',path,source[1]) in choices:
                for i,arg in enumerate(source[2]):
                    check(Expressions(self.env,self.scope).elaborate(arg),path+(2,i))
                return
            if path not in expected_calls:return
            if value.tree[0] in ('Operator','Unary'):
                name=value.operator_binding[0];paths=[path+(i,) for i in range(2,len(value.tree))]
            else:name=value.tree[1];paths=[path+(2,i) for i in range(len(value.tree[2]))]
            if self.env.data['functions'][name]['native_binding']!=expected_calls[path]:
                raise Incomplete('Checked callable differs from symbolic choice')
            if value.checked_args is None:raise Incomplete('Missing checked callable arguments')
            for child,childpath in zip(value.checked_args,paths):check(child,childpath)
        check(result,())
        return result

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
