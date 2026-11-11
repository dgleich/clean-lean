# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Demanded candidate values reconstructed before literal defaults or selection."""
from dataclasses import dataclass
from constraint_model import Variable,Carrier,Deferred,resolve,variables,unify,Incomplete,NoSolution
from witness_model import Resolver,Seed,Plan
from cleanlang.core import Type,Expressions,CleanError
from cleanlang.numeral_inference import holes

@dataclass(frozen=True)
class ValuePlan:
    output: object
    path: tuple
    requirements: tuple

class CandidateValues:
    def __init__(self,builder,tree,fragment,equations,arguments):
        self.builder=builder;self.tree=tree;self.fragment=fragment
        self.bindings=unify(equations,limit=builder.limit)
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

    def checks(self):
        checks=[]
        for plan in self.active:
            def evaluate(inputs,plan=plan):
                bindings=unify(tuple(zip(plan.requirements,inputs)),self.bindings,limit=self.builder.limit)
                value=self.expression(plan.path,bindings)
                try:return self.builder.index(value)[0]
                except CleanError as error:
                    raise Incomplete('Candidate index checking unavailable: '+str(error)) from error
            checks.append(Deferred(plan.output,plan.requirements,evaluate))
        return tuple(checks)

    def expression(self,path,bindings,defaulted=()):
        try:return self._expression(path,bindings,defaulted)
        except (CleanError,RecursionError) as error:
            raise Incomplete('Candidate value checking unavailable: '+str(error)) from error

    def _expression(self,path,bindings,defaulted=()):
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
                target=representatives.get(b.typ(spec['literal']['result'],formal))
                args=[[p.name,p.visibility,bind(reify(recovered[p.name],env,scope,classifier=p.typ).tree,env,scope,binders=True)]
                      for p in b.signature(spec).parameters]
                return ['BoundLiteral',digits(node[1]),node[1],name,snapshot(name,env),args,
                        Annotation(str(target),target,references(target,scope)),origin]
            if kind=='Projection':return ['Projection',reconstruct(node[1],where+(1,)),node[2]]
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
                checked=Expressions(env,scope).elaborate(result)
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
        for i,plan in enumerate(self.fragment.plans):
            output=resolve(plan.output,bindings)
            if variables(output):continue
            def build(_,plan=plan):
                value=Expressions(env,scope).elaborate(reconstruct(source(plan.path),plan.path))
                return b.index(value)[1]
            plans.append(Plan(output,plan.requirements,build,(3,i)))
        representatives=Resolver(bindings,seeds,plans,
            validate=lambda term,value:b.typ(value,{})==term,
            assemble=lambda term,args:Type(self.types[term.identity],args),limit=b.limit)
        return Expressions(env,scope).elaborate(reconstruct(source(path),path))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
