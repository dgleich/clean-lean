# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Demanded candidate values reconstructed before literal defaults or selection."""
from dataclasses import dataclass
from .constraint_model import Variable,Carrier,Deferred,resolve,variables,unify,Incomplete,NoSolution
from .witness_model import Resolver,Seed,Plan
from cleanlang.core import Type,Expressions,CleanError
from cleanlang.numeral_inference import holes

@dataclass(frozen=True)
class ValuePlan:
    output: object
    path: tuple
    requirements: tuple
    result_type: object=None

@dataclass(frozen=True)
class IndexPlan:
    output: object
    template: object
    formals: tuple

    @property
    def inputs(self):return tuple(term for _,term in self.formals)

    @property
    def requirements(self):return self.inputs

@dataclass(frozen=True)
class TypePlan(IndexPlan):
    """Forward substitution into a checked type, without inverse type inference."""

@dataclass(frozen=True)
class ParameterPlan:
    output: object
    template: object
    formals: tuple
    signature: object
    actual_template: object
    actual_formals: tuple

    @property
    def inputs(self):return tuple(term for _,term in self.actual_formals)

    @property
    def requirements(self):return self.inputs

class CandidateValues:
    def __init__(self,builder,tree,fragment,equations,arguments):
        self.builder=builder;self.tree=tree;self.fragment=fragment
        self.bindings=unify(equations,limit=builder.limit)
        self.index_plans=tuple(p for p in fragment.deferred if isinstance(p,IndexPlan))
        self.parameter_plans=tuple(p for p in fragment.deferred if isinstance(p,ParameterPlan))
        self.positions=dict(holes(tree))
        self.choices={(kind,path):key for kind,path,key in fragment.choices}
        self.functions={s['native_binding']:n for n,s in builder.env.data['functions'].items()}
        self.types={builder.carrier_identity(n):n for n,s in builder.env.data['types'].items()
                    if 'native_binding' in s or n in builder.env.structures}
        needed=set()
        def need(term):
            term=resolve(term,self.bindings);needed.add(term)
            if isinstance(term,Carrier):
                for arg in term.arguments:need(arg)
        for term in arguments:need(term)
        for check in fragment.deferred:
            for term in check.inputs:need(term)
        active=[];remaining=list(fragment.plans)
        while True:
            ready=[p for p in remaining if resolve(p.output,self.bindings) in needed]
            if not ready:break
            for plan in ready:
                active.append(plan);remaining.remove(plan)
                for term in plan.requirements:need(term)
        # Source child-before-parent order is the representative order, independent
        # of the demand fixed point's visitation order.
        self.active=tuple(p for p in fragment.plans if p in active)

    def validate_ground_applications(self,bindings):
        """Check determined candidate applications after forward constraints settle.

        Symbolic families remain subject to the existing selection/default rules;
        this does not claim their universal telescope validity.
        """
        incomplete=False;mismatch=False
        for plan in self.fragment.plans:
            needed=plan.requirements+(() if plan.result_type is None else (plan.result_type,))
            if any(variables(resolve(t,bindings)) for t in needed):continue
            try:
                value=self.expression(plan.path,bindings)
                if plan.result_type is not None and self.builder.typ(value.type,{})!=resolve(plan.result_type,bindings):
                    mismatch=True
                expected=resolve(plan.output,bindings)
                if not variables(expected) and self.builder.index(value)[0]!=expected:
                    mismatch=True
            except Incomplete:incomplete=True
            except NoSolution:mismatch=True
        if incomplete:raise Incomplete('A determined candidate application check is incomplete')
        if mismatch:raise NoSolution('Checked application differs from candidate type or index')

    def checks(self):
        checks=[p for p in self.fragment.deferred if not isinstance(p,(IndexPlan,ParameterPlan))]
        for plan in self.fragment.deferred:
            if not isinstance(plan,ParameterPlan):continue
            def recover(inputs,plan=plan):
                bindings=unify(tuple(zip(plan.requirements,inputs)),self.bindings,limit=self.builder.limit)
                actual=self.index_expression(TypePlan(plan.output,plan.actual_template,plan.actual_formals),bindings)
                equations=self.builder.dependent_argument_constraints(plan.template,actual,dict(plan.formals),plan.signature)
                solved=unify(equations,bindings,limit=self.builder.limit)
                result=resolve(plan.output,solved)
                if variables(result):raise Incomplete('Dependent producer parameter is not structurally recoverable')
                return result
            checks.append(Deferred(plan.output,plan.requirements,recover))
        for plan in (*self.index_plans,*self.active):
            def evaluate(inputs,plan=plan):
                bindings=unify(tuple(zip(plan.requirements,inputs)),self.bindings,limit=self.builder.limit)
                value=(self.index_expression(plan,bindings) if isinstance(plan,IndexPlan)
                       else self.expression(plan.path,bindings))
                try:return self.builder.typ(value,{}) if isinstance(plan,TypePlan) else self.builder.index(value)[0]
                except CleanError as error:
                    raise Incomplete('Candidate index checking unavailable: '+str(error)) from error
            checks.append(Deferred(plan.output,plan.requirements,evaluate))
        return tuple(checks)

    def expression(self,path,bindings,defaulted=()):
        try:
            _,reconstruct,source=self._context(bindings,defaulted)
            return self.builder.check_candidate(reconstruct(source(path),path))
        except (CleanError,RecursionError) as error:
            raise Incomplete('Candidate value checking unavailable: '+str(error)) from error

    def index_expression(self,plan,bindings,defaulted=()):
        from cleanlang.inferred_conversion import reify
        try:
            representatives,_,_=self._context(bindings,defaulted)
            value=self._index_value(plan,representatives)
            return value if isinstance(plan,TypePlan) else reify(value,self.builder.env,self.builder.scope)
        except (CleanError,RecursionError) as error:
            raise Incomplete('Candidate formal-index checking unavailable: '+str(error)) from error

    def parameter_value(self,plan,bindings,defaulted=()):
        try:
            representatives,_,_=self._context(bindings,defaulted)
            return self._parameter_value(plan,representatives)
        except (CleanError,RecursionError) as error:
            raise Incomplete('Recovered parameter evidence unavailable: '+str(error)) from error

    def _parameter_value(self,plan,representatives):
        actual=self._index_value(TypePlan(plan.output,plan.actual_template,plan.actual_formals),representatives)
        _,evidence=self.builder.dependent_argument_constraints(plan.template,actual,dict(plan.formals),plan.signature,with_evidence=True)
        for variable,value in evidence:
            if variable==plan.output:return value
        raise Incomplete('Recovered parameter lacks checked type evidence')

    def _index_value(self,plan,representatives):
        from cleanlang.inferred_conversion import reify
        from cleanlang.indices import substitute_index
        b=self.builder;actuals={}
        for name,term in plan.formals:
            classifier=None
            if term.sort=='type':
                classifier=b.formal_classifiers.get(term)
                if classifier is None:raise Incomplete('Computed formal lacks captured classifier')
            elif term.sort!='index':raise Incomplete('Unsupported computed formal sort')
            actuals[name]=reify(representatives.get(term),b.env,b.scope,classifier=classifier)
        if isinstance(plan,TypePlan):
            from cleanlang.dependent_functions import substitute
            return substitute(plan.template,actuals,b.env,b.scope)
        return substitute_index(plan.template,actuals,b.env,b.scope)

    def _context(self,bindings,defaulted=()):
        b=self.builder;env=b.env;scope=b.scope
        from cleanlang.numerals import identity,digits
        from cleanlang.inferred_conversion import reify
        from cleanlang.bound_calls import bind
        from cleanlang.literal_binding import snapshot
        from cleanlang.annotations import Annotation,references
        seeds=[Seed(term,value,(0,i)) for i,(term,value) in enumerate(b.rigid.items())]
        for i,(where,text) in enumerate(self.positions.items()):
            key=self.choices.get(('numeral',where))
            if key is None:continue
            name=next(n for n,s in env.data['types'].items() if s.get('numerals',{}).get('native_binding')==key)
            value=Expressions(env,scope).elaborate(['BoundNumeral',text,name,identity(name,env),
                    'defaulted' if where in defaulted else 'inferred'])
            atom,index=b.index(value);seeds.append(Seed(atom,index,(1,i)))
        for i,(_,witness) in enumerate(self.fragment.witnesses):
            value=witness(defaulted);atom,index=b.index(value)
            seeds.append(Seed(atom,index,(2,i)))
        def source(where):
            node=self.tree
            for step in where:node=node[step]
            return node
        def reconstruct(node,where):
            if not holes(node):return node
            kind=node[0]
            if kind=='Decimal':
                origin='defaulted' if where in defaulted else 'inferred'
                key=self.choices.get(('numeral',where))
                if key is not None:
                    name=next(n for n,s in env.data['types'].items() if s.get('numerals',{}).get('native_binding')==key)
                    return ['BoundNumeral',node[1],name,identity(name,env),origin]
                name=self.functions[self.choices['literal',where]];spec=env.data['functions'][name]
                formal,_=b.telescope(spec,where)
                recovered={n:representatives.get(t) for n,t in formal.items()}
                target=representatives.get(b.dependent_type(spec['literal']['result'],formal,{},where+('literal result',))[0])
                args=[[p.name,p.visibility,bind(reify(recovered[p.name],env,scope,classifier=p.typ).tree,env,scope,binders=True)]
                      for p in b.signature(spec).parameters]
                return ['BoundLiteral',digits(node[1]),node[1],name,snapshot(name,env),args,
                        Annotation(str(target),target,references(target,scope)),origin]
            if kind=='Apply':return ['Apply',reconstruct(node[1],where+(1,)),[reconstruct(a,where+(2,i)) for i,a in enumerate(node[2])]]
            if kind=='Projection':return ['Projection',reconstruct(node[1],where+(1,)),node[2]]
            if kind=='Call' and ('local call',where) in self.choices:
                if self.choices['local call',where]!=node[1]:raise Incomplete('Changed local callable')
                return ['Call',node[1],[reconstruct(a,where+(2,i)) for i,a in enumerate(node[2])]]
            if kind in ('Call','Operator','Unary'):
                name=self.functions[self.choices['call',where]];spec=env.data['functions'][name]
                b.signature(spec)
                if kind=='Call':args=[reconstruct(a,where+(2,i)) for i,a in enumerate(node[2])]
                else:args=[reconstruct(node[i],where+(i,)) for i in range(2,len(node))]
                result=['ModuleCall',name,args,spec['lean']]
                if kind in ('Operator','Unary'):
                    from cleanlang.operator_bindings import token
                    fixity='infix' if kind=='Operator' else 'prefix'
                    result.append([fixity,token(node[1],fixity)])
                checked=b.check_candidate(result)
                formal,_=b.telescope(spec,where)
                inferred=dict(checked.inferred_args)
                for p in b.signature(spec).parameters:
                    if p.visibility!='implicit':continue
                    expected=resolve(formal[p.name],bindings)
                    if variables(expected):raise Incomplete('Candidate implicit argument remains unresolved')
                    if p.name not in inferred:raise Incomplete('Candidate implicit argument lacks checked evidence')
                    if b.typ(inferred[p.name],{})!=expected:
                        raise NoSolution('Checked implicit argument differs from candidate substitution')
                return result
            raise Incomplete('Candidate value reconstruction does not cover '+kind)
        plans=[]
        for i,plan in enumerate(self.index_plans):
            output=resolve(plan.output,bindings)
            if variables(output):continue
            plans.append(Plan(output,plan.requirements,
                lambda _,plan=plan:self._index_value(plan,representatives),(3,i)))
        for i,plan in enumerate(self.parameter_plans):
            output=resolve(plan.output,bindings)
            if variables(output):continue
            # Nominal carriers already have structural assembly. Installing a
            # speculative parameter witness there would mask a certified type
            # mismatch with a witness-validation failure in rejected rows.
            if isinstance(output,Carrier):continue
            plans.append(Plan(output,plan.requirements,
                lambda _,plan=plan:self._parameter_value(plan,representatives),(3,len(self.index_plans)+i)))
        for i,plan in enumerate(self.fragment.plans):
            output=resolve(plan.output,bindings)
            if variables(output):continue
            def build(_,plan=plan):
                value=b.check_candidate(reconstruct(source(plan.path),plan.path))
                return b.index(value)[1]
            plans.append(Plan(output,plan.requirements,build,(4,i)))
        representatives=Resolver(bindings,seeds,plans,
            validate=lambda term,value:b.typ(value,{})==term,
            assemble=lambda term,args:Type(self.types[term.identity],args),limit=b.limit,
            available=b.witness_available,allowed_binders=frozenset(b.binder_ids.values()))
        return representatives,reconstruct,source

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
