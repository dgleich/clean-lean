# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Experimental Clean-signature adapter for the joint constraint model.

Not production elaboration: binder/evidence/computed-formal constraints and general
retained-target construction remain explicit gaps. Unsupported competitors raise
Incomplete; they are never discarded as mismatches.
"""
from dataclasses import dataclass
from itertools import product
import re
from cleanlang.core import Type,LocalType,ValueIndex,Expr,Expressions,split
from cleanlang.numeral_inference import holes,default_carrier
from cleanlang.numerals import digits,identity
from cleanlang.operator_bindings import token
from constraint_model import Variable,Atom,Carrier,Row,Incomplete,Ambiguous,NoSolution,select,unify,resolve,variables

@dataclass(frozen=True)
class Fragment:
    typ: object
    value: object
    choices: tuple=()
    carriers: tuple=()
    arguments: tuple=()
    equations: tuple=()

class Builder:
    def __init__(self,env,scope,limit=4096):
        if type(limit) is not int or limit<1:raise ValueError('Positive row limit required')
        self.env=env;self.scope=scope;self.limit=limit;self.rigid={};self.known={}

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
        spec=self.env.data['types'].get(typ.name)
        if spec is None or 'native_binding' not in spec:raise Incomplete('Undeclared carrier identity')
        if self.env.sort_level(typ)!=1:raise Incomplete('Only Type-0 carriers in this adapter')
        return Carrier(spec['native_binding'],tuple(self.typ(a,None if capture else formals) for a in typ.args))

    def telescope(self,spec,path):
        local={};variables={};implicit=[]
        for _,name,source,visibility in spec['signature_tree'][2]:
            typ=self.env.type(source,local,phrases=False)
            info=self.env.classifier_info(typ)
            if info is not None and info[1]!=0:raise Incomplete('Higher classifier parameter')
            variables[name]=Variable(repr((path,spec['native_binding'],name)), 'type' if info is not None else 'index')
            local[name]=Expr(name,name,typ,tree=['Local',name])
            if visibility=='implicit':implicit.append(variables[name])
        return variables,tuple(implicit)

    def pattern(self,text,variables):
        if text.startswith('$'):
            if text[1:] not in variables:raise Incomplete('Unknown signature formal')
            return variables[text[1:]]
        match=re.fullmatch(r'(\w+)(?:\((.*)\))?',text)
        if match is None:raise Incomplete('Nonstructural signature pattern: '+text)
        spec=self.env.data['types'].get(match[1])
        if spec is None or 'native_binding' not in spec:raise Incomplete('Missing signature carrier')
        return Carrier(spec['native_binding'],tuple(self.pattern(x,variables) for x in split(match[2] or '')))

    def fragments(self,tree,path=()):
        if not holes(tree):
            value=self.known.get(path)
            if value is None:value=Expressions(self.env,self.scope).elaborate(tree)
            # Only plain locals and retained scalar numerals have direct rigid
            # value equations here. Other known values may still supply types.
            atom=(Atom(repr(value.lean),'index') if tree[0] in ('Local','BoundNumeral')
                  else Variable(repr((path,'deferred known value')),'index'))
            return [Fragment(self.typ(value.type),atom)]
        kind=tree[0]
        if kind=='Decimal':
            text=digits(tree[1]);found=[]
            for name,spec in sorted(self.env.data['types'].items()):
                if 'numerals' not in spec:continue
                node=['BoundNumeral',text,name,identity(name,self.env),'inferred']
                value=Expressions(self.env,self.scope).elaborate(node)
                carrier=self.typ(value.type)
                found.append(Fragment(carrier,Atom(repr(value.lean),'index'),
                    (('numeral',path,spec['numerals']['native_binding']),),(carrier,)))
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
            dep=spec.get('dependent_signature')
            if dep:
                parameters=[self.typ(t,variables) for _,t in dep['parameters']]
                result=self.typ(dep['result'],variables)
            else:
                parameters=[self.pattern(p,variables) for p in spec['params']]
                result=self.pattern(spec['returns'],variables)
            explicit=[p[1] for p in spec['signature_tree'][2] if p[3]=='explicit']
            for actuals in product(*parts):
                equations=tuple(eq for a in actuals for eq in a.equations)
                equations+=tuple(zip(parameters,(a.typ for a in actuals)))
                equations+=tuple((variables[n],a.value) for n,a in zip(explicit,actuals))
                rows.append(Fragment(result,Variable(repr((path,spec['native_binding'],'value')),'index'),
                    tuple(c for a in actuals for c in a.choices)+(('call',path,spec['native_binding']),),
                    tuple(t for a in actuals for t in a.carriers),
                    tuple(t for a in actuals for t in a.arguments)+implicit,equations))
        return rows

    def rows(self,tree,expected=None):
        # Caller representatives are collected in source order before any
        # declaration enumeration, so candidate order cannot choose an index's
        # emitted spelling. The explicit expected type is visited afterward.
        self.rigid={};self.known={}
        def prepare(node,path):
            if not holes(node):
                value=Expressions(self.env,self.scope).elaborate(node)
                self.known[path]=value;self.typ(value.type);return
            if node[0]=='Call':
                for i,arg in enumerate(node[2]):prepare(arg,path+(2,i))
            elif node[0] in ('Operator','Unary'):
                for i in range(2,len(node)):prepare(node[i],path+(i,))
        prepare(tree,())
        if expected is not None:self.typ(expected)
        return [Row(f.choices,f.carriers,f.carriers+f.arguments+(f.typ,),
                    f.equations+(((f.typ,self.typ(expected)),) if expected is not None else ()))
                for f in self.fragments(tree)]

    def solve(self,tree,expected=None,*,use_default=True):
        name=default_carrier(self.env) if use_default else None
        default=self.typ(self.env.type(name)) if name is not None else None
        selected=select(self.rows(tree,expected),default=default,limit=self.limit)
        self.audit_operators(tree,selected)
        return selected

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
                    try:bindings=unify(constraints,limit=self.limit)
                    except NoSolution:continue
                    if any(variables(resolve(t,bindings)) for t in f.arguments):
                        raise Incomplete('Operator input applicability remains unresolved')
                    viable.add(f.choices[-1][2])
                if len(viable)>1:raise Ambiguous('Operator input signatures are ambiguous independently of the expected result')
                for i in range(2,len(node)):walk(node[i],path+(i,))
            elif kind=='Call':
                for i,arg in enumerate(node[2]):walk(arg,path+(2,i))
        walk(tree,())


    def materialize(self,tree,expected=None):
        """Check one non-defaulted selected row with the existing elaborator.

        This demonstrates retained targets; it does not discharge exhaustive
        validation of every partially solved dependent row for production use.
        """
        selected=self.solve(tree,expected,use_default=False)
        choices,actual_arguments=selected
        row=next(row for row in self.rows(tree,expected) if row.choices==choices)
        bindings=unify(row.equations+tuple(zip(row.arguments,actual_arguments)),limit=self.limit)
        from cleanlang.annotations import Annotation,references
        from cleanlang.bound_calls import bind
        from cleanlang.inferred_conversion import reify_parameter
        from cleanlang.literal_binding import snapshot,elaborate as literal
        selected_literals={(kind,path):key for kind,path,key in choices if kind in ('literal','numeral')}
        types={s['native_binding']:n for n,s in self.env.data['types'].items() if 'native_binding' in s}
        functions={s['native_binding']:n for n,s in self.env.data['functions'].items()}
        def actual(term):
            term=resolve(term,bindings)
            if isinstance(term,Carrier):return Type(types[term.identity],tuple(actual(a) for a in term.arguments))
            if isinstance(term,Atom) and term in self.rigid:return self.rigid[term]
            raise Incomplete('No checked representative for recovered parameter')
        def replace(node,path):
            if node[0]=='Decimal':
                if ('numeral',path) in selected_literals:
                    key=selected_literals['numeral',path]
                    name=next(n for n,s in self.env.data['types'].items() if s.get('numerals',{}).get('native_binding')==key)
                    return ['BoundNumeral',node[1],name,identity(name,self.env),'inferred']
                name=functions[selected_literals['literal',path]];spec=self.env.data['functions'][name]
                formal,_=self.telescope(spec,path)
                recovered={n:actual(value) for n,value in formal.items()}
                target=actual(self.typ(spec['literal']['result'],formal))
                args=[[p[1],p[3],bind(reify_parameter(recovered[p[1]],p,self.env,self.scope).tree,
                                     self.env,self.scope,binders=True)] for p in spec['signature_tree'][2]]
                retained=['BoundLiteral',digits(node[1]),node[1],name,snapshot(name,self.env),args,
                          Annotation(str(target),target,references(target,self.scope)),'inferred']
                literal(retained,self.env,self.scope)
                return retained
            if node[0]=='Call':return [node[0],node[1],[replace(a,path+(2,i)) for i,a in enumerate(node[2])]]
            if node[0] in ('Operator','Unary'):return [*node[:2],*[replace(node[i],path+(i,)) for i in range(2,len(node))]]
            return node
        rebuilt=replace(tree,())
        result=Expressions(self.env,self.scope).elaborate(rebuilt,expected)
        expected_calls={path:key for kind,path,key in choices if kind=='call'}
        def check(value,path):
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
