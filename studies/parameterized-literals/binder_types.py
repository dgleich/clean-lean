# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental checked-type bridge; not the production or joint-inference path."""
from cleanlang.core import Type,LocalType,ValueIndex,Expr,Expressions,CleanError,texid
from cleanlang.dependent_functions import DependentFunctionType,fresh_source,fresh_bound,substitute,make,index_tree
from cleanlang.inferred_conversion import reify
from cleanlang.indices import index_value
from cleanlang.retained_codec import dumps
from clean_rows import Builder
from constraint_model import Atom,Carrier,Reference,Binder,Variable,Incomplete,NoSolution,abstract,open_binder,well_scoped,instantiate

class CheckedBinderTypes:
    """One fixed explicit environment and caller scope, with retained atom evidence."""
    def __init__(self,env,scope,*,limit=4096):
        if type(limit) is not int or limit<1:raise ValueError('Positive binder type traversal limit required')
        self.env=env;self.scope=dict(scope);self.limit=limit;self.atoms={};self.names={}
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
                raise Incomplete('Opaque bound-index dependency needs structural expression lowering')
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
