# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental Clean-signature adapter for the joint constraint model.

Not production elaboration: binder/evidence/computed-formal constraints and general
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

class Builder:
    def __init__(self,env,scope,limit=4096):
        if type(limit) is not int or limit<1:raise ValueError('Positive row limit required')
        self.env=env;self.scope=scope;self.limit=limit;self.rigid={};self.known={};self.known_values={}

    def carrier_identity(self,name):
        spec=self.env.data['types'].get(name,{})
        key=spec.get('native_binding')
        if key is None:key=self.env.structures.get(name,{}).get('key')
        if key is None:raise Incomplete('Undeclared carrier identity')
        return key

    def index(self,value):
        from cleanlang.indices import index_value
        index=index_value(value,self.env,self.scope,_fresh=True)
        atom=Atom(repr(index.comparison_key()),'index')
        return atom,index

    def known_index(self,value):
        atom,index=self.index(value)
        self.rigid.setdefault(atom,index)
        return atom

    def typ(self,typ,formals=None):
        capture=formals is None
        formals={} if formals is None else formals
        if isinstance(typ,LocalType):
            if typ.name in formals:return formals[typ.name]
            if typ.universe!=0:raise Incomplete('Higher local carrier')
            atom=Atom(typ.lean,'type')
            if capture:self.rigid.setdefault(atom,typ)
            return atom
        if isinstance(typ,ValueIndex):
            if typ.name in formals:return formals[typ.name]
            from cleanlang.dependent_functions import occurs
            if any(occurs(typ,name) for name in formals):
                raise Incomplete('Computed formal index requires deferred checking')
            atom=Atom(repr(typ.comparison_key()),'index')
            if capture:self.rigid.setdefault(atom,typ)
            return atom
        if type(typ) is not Type:raise Incomplete('Unsupported carrier constructor: '+type(typ).__name__)
        key=self.carrier_identity(typ.name)
        if self.env.sort_level(typ)!=1:raise Incomplete('Only Type-0 carriers in this adapter')
        return Carrier(key,tuple(self.typ(a,None if capture else formals) for a in typ.args))

    def signature(self,spec):
        try:return require(self.env,spec)
        except CleanError as error:raise Incomplete(str(error)) from error

    def telescope(self,spec,path):
        variables={};implicit=[]
        for p in self.signature(spec).parameters:
            info=p.classifier
            if info is not None and info[1]!=0:raise Incomplete('Higher classifier parameter')
            variables[p.name]=Variable(repr((path,spec['native_binding'],p.name)), 'type' if info is not None else 'index')
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
        from cleanlang.dependent_functions import occurs
        results=[]
        for base in self.fragments(tree[1],path+(1,)):
            if not isinstance(base.typ,Carrier):raise Incomplete('Projection carrier remains unresolved')
            spec=next((s for s in self.env.structures.values() if s['key']==base.typ.identity),None)
            if spec is None or tree[2] not in dict(spec['fields']):continue
            field_type=dict(spec['fields'])[tree[2]]
            if any(occurs(field_type,n) for n,_ in spec['fields']):
                raise Incomplete('Projection type depends on record field values')
            if len(spec['parameters'])!=len(base.typ.arguments):raise Incomplete('Projection parameter arity mismatch')
            formals=dict(zip(spec['parameters'],base.typ.arguments))
            typ=self.typ(field_type,formals)
            output=Variable(repr((path,spec['key'],tree[2])),'index')
            syntax=None;origins=();deferred=base.deferred;witnesses=base.witnesses
            if base.syntax is not None:
                syntax=['Projection',base.syntax,tree[2]]
                origins=tuple(((1,)+local,source) for local,source in base.origins)
                witness=self.call_witness(None,None,syntax,origins)
                def evaluate(inputs,witness=witness,field_type=field_type,names=tuple(spec['parameters'])):
                    try:
                        value=witness()
                        expected=self.typ(field_type,dict(zip(names,inputs[1:])))
                        if self.typ(value.type,{})!=expected:raise NoSolution('Deferred projection type mismatch')
                        return self.index(value)[0]
                    except CleanError as error:raise Incomplete('Deferred projection checking is unavailable: '+str(error)) from error
                deferred+=(Deferred(output,(base.value,)+base.typ.arguments,evaluate),)
                witnesses+=((output,witness),)
            results.append(Fragment(typ,output,
                base.choices+(('projection',path,(spec['key'],tree[2])),),base.carriers,
                base.arguments,base.equations,deferred,witnesses,syntax,origins))
        return results

    def fragments(self,tree,path=()):
        if not holes(tree):
            if path not in self.known or path not in self.known_values:
                raise Incomplete('Known argument lacks checked index evidence')
            return [Fragment(self.typ(self.known[path].type),self.known_values[path],syntax=self.known[path].tree)]
        kind=tree[0]
        if kind=='Projection':return self.projection_fragments(tree,path)
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
                carrier=self.typ(attachment['result'],variables)
                found.append(Fragment(carrier,Variable(repr((path,key,'value')),'index'),
                    (('literal',path,key),),(carrier,),tuple(variables.values())))
            if len(found)>self.limit:raise Incomplete('Literal declaration row limit exceeded')
            return found
        if kind in ('Operator','Unary'):
            fixity='infix' if kind=='Operator' else 'prefix'
            names=getattr(self.env,'operator_overloads' if kind=='Operator' else 'prefix_overloads',{}).get(token(tree[1],fixity),[])
            children=[(tree[i],path+(i,)) for i in range(2,len(tree))]
        elif kind=='Call' and tree[1] not in self.scope:
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
            parameters=[self.typ(p.typ,variables) for p in explicit]
            result=self.typ(signature.result,variables)
            explicit=[p.name for p in explicit]
            for actuals in product(*parts):
                equations=tuple(eq for a in actuals for eq in a.equations)
                equations+=tuple(zip(parameters,(a.typ for a in actuals)))
                equations+=tuple((variables[n],a.value) for n,a in zip(explicit,actuals))
                output=Variable(repr((path,spec['native_binding'],'value')),'index')
                deferred=tuple(d for a in actuals for d in a.deferred)
                witnesses=tuple(w for a in actuals for w in a.witnesses)
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
                rows.append(Fragment(result,output,
                    tuple(c for a in actuals for c in a.choices)+(('call',path,spec['native_binding']),),
                    tuple(t for a in actuals for t in a.carriers),
                    tuple(t for a in actuals for t in a.arguments)+implicit,equations,
                    deferred,witnesses,syntax,origins))
        return rows

    def rows(self,tree,expected=None):
        # Caller representatives are collected in source order before any
        # declaration enumeration, so candidate order cannot choose an index's
        # emitted spelling. The explicit expected type is visited afterward.
        self.rigid={};self.known={};self.known_values={}
        def prepare(node,path):
            if not holes(node):
                value=Expressions(self.env,self.scope).elaborate(node)
                self.known[path]=value;self.typ(value.type)
                try:self.known_values[path]=self.known_index(value)
                except CleanError as error:
                    raise Incomplete('Known argument index is unsupported: '+str(error)) from error
                return
            if node[0]=='Projection':prepare(node[1],path+(1,))
            elif node[0]=='Call':
                for i,arg in enumerate(node[2]):prepare(arg,path+(2,i))
            elif node[0] in ('Operator','Unary'):
                for i in range(2,len(node)):prepare(node[i],path+(i,))
        prepare(tree,())
        if expected is not None:self.typ(expected)
        fragments=self.fragments(tree)
        self.row_witnesses={f.choices:f.witnesses for f in fragments}
        return [Row(f.choices,f.carriers,f.carriers+f.arguments+(f.typ,),
                    f.equations+(((f.typ,self.typ(expected)),) if expected is not None else ()),f.deferred)
                for f in fragments]

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
                    try:bindings=saturate(Row((),(),(),constraints,f.deferred),limit=self.limit)
                    except NoSolution:continue
                    if any(variables(resolve(t,bindings)) for t in f.arguments):
                        raise Incomplete('Operator input applicability remains unresolved')
                    viable.add(f.choices[-1][2])
                if len(viable)>1:raise Ambiguous('Operator input signatures are ambiguous independently of the expected result')
                for i in range(2,len(node)):walk(node[i],path+(i,))
            elif kind=='Projection':walk(node[1],path+(1,))
            elif kind=='Call':
                for i,arg in enumerate(node[2]):walk(arg,path+(2,i))
        walk(tree,())


    def materialize(self,tree,expected=None,*,use_default=True):
        """Recheck one selected row while retaining simultaneous default origins.

        This demonstrates retained targets; it does not discharge exhaustive
        validation of every partially solved dependent row for production use.
        """
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
        types={self.carrier_identity(n):n for n,s in self.env.data['types'].items()
               if 'native_binding' in s or n in self.env.structures}
        functions={s['native_binding']:n for n,s in self.env.data['functions'].items()}
        def actual(term):
            term=resolve(term,bindings)
            if isinstance(term,Carrier):return Type(types[term.identity],tuple(actual(a) for a in term.arguments))
            if isinstance(term,Atom) and term in self.rigid:return self.rigid[term]
            raise Incomplete('No checked representative for recovered parameter')
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
                target=actual(self.typ(spec['literal']['result'],formal))
                args=[[p.name,p.visibility,bind(reify(recovered[p.name],self.env,self.scope,
                                     classifier=p.typ).tree,self.env,self.scope,binders=True)]
                      for p in self.signature(spec).parameters]
                retained=['BoundLiteral',digits(node[1]),node[1],name,snapshot(name,self.env),args,
                          Annotation(str(target),target,references(target,self.scope)),origin]
                literal(retained,self.env,self.scope)
                return retained
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
            if source[0]=='Projection':
                check(Expressions(self.env,self.scope).elaborate(source[1]),path+(1,))
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
