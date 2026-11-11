# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental checked-type bridge; not the production or joint-inference path."""
from cleanlang.core import Type,LocalType,ValueIndex,Expr,Expressions,CleanError,texid
from cleanlang.dependent_functions import DependentFunctionType,fresh_source,fresh_bound,substitute,make,index_tree
from cleanlang.inferred_conversion import reify
from cleanlang.indices import index_value
from cleanlang.retained_codec import dumps
from clean_rows import Builder
from constraint_model import Atom,Carrier,IndexExpression,Reference,Binder,Variable,Incomplete,NoSolution,abstract,open_binder,well_scoped,instantiate

class CheckedBinderTypes:
    """One fixed explicit environment and caller scope, with retained atom evidence."""
    def __init__(self,env,scope,*,limit=4096):
        if type(limit) is not int or limit<1:raise ValueError('Positive binder type traversal limit required')
        self.env=env;self.scope=dict(scope);self.limit=limit;self.atoms={};self.names={};self.templates={}
        for name,spec in env.data['types'].items():
            key=spec.get('native_binding') or env.structures.get(name,{}).get('key')
            if key is None:continue
            if key in self.names and self.names[key]!=name:raise Incomplete('Nonunique declared carrier key')
            self.names[key]=name

    def tick(self):
        self.visits+=1
        if self.visits>self.limit:raise Incomplete('Checked binder type traversal limit exceeded')

    def encode(self,typ):
        self.visits=0
        try:
            self.env.require_type_argument(typ,0)
            result=self._encode(typ,self.scope,{},())
            well_scoped(result,limit=self.limit)
            return result
        except (CleanError,RecursionError) as error:raise Incomplete('Checked binder encoding unavailable: '+str(error)) from error

    def _encode(self,typ,scope,locals,path):
        self.tick();builder=Builder(self.env,scope,self.limit,binder_ids=locals)
        if isinstance(typ,DependentFunctionType):
            self.env.require_type_argument(typ,0)
            domain=self._encode(typ.domain,scope,locals,path+(0,))
            name=fresh_source(typ.binder,self.env,scope,{})
            local=Expr(fresh_bound(self.env,scope),texid(name),typ.domain,tree=['Local',name])
            inner={**scope,name:local};identity=('encoded binder',path)
            codomain=substitute(typ.codomain,{typ.binder:local},self.env,inner)
            body=self._encode(codomain,inner,{**locals,name:identity},path+(1,))
            return abstract(identity,domain,body,identity=builder.carrier_identity(typ.constructor),limit=self.limit)
        if isinstance(typ,ValueIndex):
            tree=index_tree(typ)
            name=tree[1] if tree[0]=='Local' else None
            if name in locals:return Reference(locals[name],'index')
            checked=reify(typ,self.env,scope)
            if builder.dependencies(checked,normalize=False):
                return self._encode_expression(checked,scope,locals,path)
            atom=Atom(repr(('retained index',typ.comparison_key(),dumps(index_tree(typ)))),'index')
            self.atoms.setdefault(atom,typ)
            return atom
        if isinstance(typ,LocalType):
            if typ.name in locals:raise Incomplete('Type-valued binders remain unsupported')
            atom=Atom(repr(('local type',typ.name,typ.lean,typ.classifier,typ.universe)),'type')
            self.atoms.setdefault(atom,typ)
            return atom
        if type(typ) is not Type:raise Incomplete('Unsupported checked type constructor')
        return Carrier(builder.carrier_identity(typ.name),tuple(self._encode(a,scope,locals,path+(i,)) for i,a in enumerate(typ.args)))

    def _encode_expression(self,value,scope,locals,path):
        self.tick()
        from cleanlang.bound_calls import _bind_checked
        tree=_bind_checked(value,self.env,scope,binders=True)
        checked=Expressions(self.env,scope).elaborate(tree)
        kind=tree[0]
        if kind=='BoundTypeValue':
            carrier=self.env.type(tree[1],scope,phrases=False)
            skeleton=[kind,None,*tree[2:]]
            key=dumps((skeleton,1,()))
            self.templates.setdefault(key,(skeleton,1,()))
            return IndexExpression(key,(self._encode(carrier,scope,locals,path+('carrier',)),
                                        self._encode(checked.type,scope,locals,path+('result',))))
        if kind=='ModuleCall':
            operands=checked.checked_args
            if operands is None:raise Incomplete('Computed call lacks checked operands')
            skeleton=[kind,tree[1],None,*tree[3:]]
        elif kind=='Projection':
            operands=(Expressions(self.env,scope).elaborate(tree[1]),)
            skeleton=[kind,None,tree[2]]
        elif kind=='Apply':
            operands=(Expressions(self.env,scope).elaborate(tree[1]),)+tuple(Expressions(self.env,scope).elaborate(a) for a in tree[2])
            skeleton=[kind,None,None]
        else:raise Incomplete('Bound index expression constructor remains unsupported: '+kind)
        inferred=tuple(sorted(checked.inferred_args))
        names=tuple(n for n,_ in inferred)
        key=dumps((skeleton,len(operands),names))
        self.templates.setdefault(key,(skeleton,len(operands),names))
        children=tuple(self._encode(index_value(a,self.env,scope,_fresh=True),scope,locals,path+('operand',i)) for i,a in enumerate(operands))
        implicit=tuple(self._encode(t,scope,locals,path+('implicit',i)) for i,(_,t) in enumerate(inferred))
        result=self._encode(checked.type,scope,locals,path+('result',))
        return IndexExpression(key,children+implicit+(result,))

    def _decode_expression(self,term,scope,locals,path):
        if term.identity not in self.templates:raise Incomplete('Missing checked index-expression template')
        skeleton,count,names=self.templates[term.identity]
        if len(term.arguments)!=count+len(names)+1:raise Incomplete('Malformed index-expression operand count')
        values=tuple(self._decode(t,scope,locals,path+(i,)) for i,t in enumerate(term.arguments))
        tree=list(skeleton)
        if tree[0]=='BoundTypeValue':
            from cleanlang.annotations import Annotation,references
            carrier=values[0]
            tree[1]=Annotation(str(carrier),carrier,references(carrier,scope))
            operands=[]
        else:operands=[reify(v,self.env,scope).tree for v in values[:count]]
        if tree[0]=='BoundTypeValue':pass
        elif tree[0]=='ModuleCall':tree[2]=operands
        elif tree[0]=='Projection':tree[1]=operands[0]
        elif tree[0]=='Apply':tree[1]=operands[0];tree[2]=operands[1:]
        else:raise Incomplete('Unknown checked index-expression template')
        checked=Expressions(self.env,scope).elaborate(tree)
        if checked.type!=values[-1]:raise Incomplete('Computed index result type changed')
        inferred=dict(checked.inferred_args)
        if set(inferred)!=set(names):raise Incomplete('Computed index implicit arguments changed')
        for name,expected in zip(names,values[count:-1]):
            if inferred[name]!=expected:raise Incomplete('Computed index implicit argument differs')
        return index_value(checked,self.env,scope,_fresh=True)

    def decode(self,term):
        self.visits=0
        try:
            well_scoped(term,limit=self.limit)
            result=self._decode(term,self.scope,{},())
            self.env.require_type_argument(result,0)
            return result
        except (CleanError,RecursionError) as error:raise Incomplete('Checked binder reconstruction unavailable: '+str(error)) from error

    def apply(self,term,argument):
        """Check an explicit argument's domain before structural instantiation."""
        self.visits=0
        try:
            well_scoped(term,limit=self.limit)
            if not isinstance(term,Binder) or term.sort!='type':raise Incomplete('Typed instantiation requires a dependent type binder')
            if term.identity not in self.names or not self.env.is_function_type(Type(self.names[term.identity])):
                raise Incomplete('Typed instantiation requires a declared function constructor')
            domain=self._decode(term.domain,self.scope,{},(0,))
            self.env.require_type_argument(domain,0)
            actual=Expressions(self.env,self.scope).elaborate(argument.tree)
            if actual.type!=domain:raise NoSolution('Dependent function argument has the wrong domain')
            value=index_value(actual,self.env,self.scope,_fresh=True)
            encoded=self._encode(value,self.scope,{},('argument',))
            return self.decode(instantiate(term,encoded,limit=self.limit))
        except (CleanError,RecursionError) as error:raise Incomplete('Typed binder instantiation unavailable: '+str(error)) from error

    def nominal(self,name,args,scope):
        spec=self.env.data['types'][name]
        parameters=spec.get('parameter_types',[]);names=spec.get('parameter_names',[])
        if len(args)!=len(spec.get('args',[])) or len(parameters)!=len(args):raise Incomplete('Carrier telescope unavailable or wrong arity')
        previous={}
        for i,(argument,formal) in enumerate(zip(args,parameters)):
            expected=substitute(formal,previous,self.env,scope)
            classifier=self.env.classifier_info(expected)
            if classifier is not None:
                if not self.env.is_function_type(Type(name)) or classifier[1]!=0:
                    self.env.require_type_argument(argument,classifier[1])
            else:
                actual=reify(argument,self.env,scope)
                if actual.type!=expected:raise Incomplete('Reconstructed index has the wrong declared type')
            if i<len(names):previous[names[i]]=argument
        return Type(name,args)

    def _decode(self,term,scope,locals,path):
        self.tick()
        if isinstance(term,IndexExpression):return self._decode_expression(term,scope,locals,path)
        if isinstance(term,Reference):
            if term.binder not in locals or term.sort!='index':raise Incomplete('Unavailable lexical binder reference')
            return index_value(locals[term.binder],self.env,scope,_fresh=True)
        if isinstance(term,Atom):
            if term not in self.atoms:raise Incomplete('Missing retained atom representative')
            value=self.atoms[term]
            if isinstance(value,ValueIndex):reify(value,self.env,scope)
            elif isinstance(value,LocalType):
                current=scope.get(value.name)
                if current is None or current.lean!=value.lean or self.env.classifier_info(current.type)!=(value.classifier,value.universe):
                    raise Incomplete('Unavailable local type representative')
            return value
        if isinstance(term,Variable):raise Incomplete('Unsolved type metavariable')
        if not isinstance(term,(Binder,Carrier)) or term.identity not in self.names:
            raise Incomplete('Unknown declared carrier constructor')
        name=self.names[term.identity]
        if isinstance(term,Carrier):
            if term.sort!='type':raise Incomplete('Carrier has unsupported sort')
            args=tuple(self._decode(a,scope,locals,path+(i,)) for i,a in enumerate(term.arguments))
            return self.nominal(name,args,scope)
        if term.sort!='type' or not self.env.is_function_type(Type(name)):
            raise Incomplete('Binder constructor is not a declared function type')
        domain=self._decode(term.domain,scope,locals,path+(0,))
        self.env.require_type_argument(domain,0)
        source=fresh_source('bound',self.env,scope,{})
        bound=fresh_bound(self.env,scope)
        value=Expr(bound,texid(source),domain,tree=['Local',source]);identity=('decoded binder',path)
        inner={**scope,source:value}
        body=open_binder(term,identity,'index',limit=self.limit)
        codomain=self._decode(body,inner,{**locals,identity:value},path+(1,))
        self.env.require_type_argument(codomain,0)
        return make(name,source,bound,domain,codomain)

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
