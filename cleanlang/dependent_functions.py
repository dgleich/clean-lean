# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Explicit dependent arrows: scoped identities, alpha keys and substitution."""
from dataclasses import dataclass
import json,re
from .core import Type,ProofType,ValueIndex,Expr,CleanError,ID,NUM,texid


def index_tree(index):
    from .indices import ComputedIndex
    from .syntax import parse,expression_tree
    return json.loads(index.syntax) if isinstance(index,ComputedIndex) else expression_tree(parse(index.name,'expression'))


def tree_names(tree):
    kind=tree[0]
    if kind=='Local':return {tree[1]}
    if kind=='Decimal':return set()
    if kind=='Call':return {tree[1]}|set().union(*(tree_names(a) for a in tree[2]))
    if kind=='Projection':return tree_names(tree[1])
    if kind=='Apply':return tree_names(tree[1])|set().union(*(tree_names(a) for a in tree[2]))
    if kind=='Operator':return tree_names(tree[2])|tree_names(tree[3])
    if kind=='Unary':return tree_names(tree[2])
    if kind in ('Lambda','Forall','Exists'):
        return {tree[1]}|set(re.findall(ID,tree[2]))|tree_names(tree[3])
    raise CleanError('Unsupported expression in dependent function substitution: '+kind)


def occurs(typ,name):
    if isinstance(typ,DependentFunctionType):
        return occurs(typ.domain,name) or (typ.binder!=name and occurs(typ.codomain,name))
    if isinstance(typ,ValueIndex):return name in tree_names(index_tree(typ))
    if isinstance(typ,Type):return typ.name==name or any(occurs(a,name) for a in typ.args)
    return typ==name


def fresh_bound(env,locals):
    pool=getattr(env,'_comparison_pool',None)
    if pool is not None:return pool.fresh(locals)
    # A compiler binding identity cannot coincide with an opaque declaration's
    # constants, labels, local terms or already constructed type binders.
    occupied=set(locals)
    for text in env.notation_definitions.values():occupied.update(re.findall(ID,text))
    for value in locals.values():
        occupied.update(re.findall(ID,value.lean))
        occupied.update(re.findall(ID,env.render_type(value.type,'lean')))
    i=0
    while 'clean_pi_bound_'+str(i) in occupied:i+=1
    return 'clean_pi_bound_'+str(i)


def fresh_source(preferred,env,locals,bindings):
    occupied=set(locals)|set(env.data['types'])|set(env.data['aliases'])|set(env.data['functions'])
    for value in bindings.values():
        if isinstance(value,Expr):
            if value.tree is not None:occupied.update(tree_names(value.tree))
            occupied.update(re.findall(ID,value.lean))
        elif isinstance(value,ValueIndex):occupied.update(tree_names(index_tree(value)))
        elif isinstance(value,Type):occupied.update(re.findall(ID,str(value)))
    name=preferred;i=0
    while name in occupied:
        i+=1;name=preferred+'_'+str(i)
    return name


def abstract_template(term,bound):
    from .binder_keys import ScopedKey
    if isinstance(term,ScopedKey):return term.abstract(bound)
    # This is the compiler's selected index template, not pretty-printed native
    # Lean. Fresh allocation makes these tokens unforgeable binding references
    # within the stored scope; punctuation and every free identifier are retained.
    out=[];pos=0
    for m in re.finditer(ID,term):
        out.append(term[pos:m.start()]);token=m[0]
        out.append(('bound',len(bound)-1-bound.index(token)) if token in bound else ('free',token))
        pos=m.end()
    out.append(term[pos:]);return tuple(out)


def contains_free(key,name):
    if key==('free',name):return True
    return isinstance(key,tuple) and any(contains_free(part,name) for part in key)


def type_key(typ,bound=()):
    if isinstance(typ,DependentFunctionType):
        codomain=type_key(typ.codomain,bound)
        if not contains_free(codomain,typ.bound):
            return ('type',typ.constructor,(type_key(typ.domain,bound),codomain))
        return ('Pi',typ.constructor,type_key(typ.domain,bound),type_key(typ.codomain,bound+(typ.bound,)))
    if isinstance(typ,ValueIndex):return ('index',abstract_template(typ.comparison_key(),bound))
    if isinstance(typ,Type):return ('type',typ.name,tuple(type_key(a,bound) for a in typ.args))
    return ('literal',typ)


@dataclass(frozen=True,eq=False,init=False)
class DependentFunctionType(Type):
    constructor: str
    binder: str
    bound: str
    def __init__(self,constructor,binder,bound,domain,codomain):
        object.__setattr__(self,'name','$dependentFunction')
        object.__setattr__(self,'args',(domain,codomain))
        object.__setattr__(self,'constructor',constructor)
        object.__setattr__(self,'binder',binder)
        object.__setattr__(self,'bound',bound)
    @property
    def domain(self):return self.args[0]
    @property
    def codomain(self):return self.args[1]
    def __str__(self):return self.constructor+'('+self.binder+': '+str(self.domain)+','+str(self.codomain)+')'
    def __eq__(self,other):return isinstance(other,Type) and type_key(self)==type_key(other)
    def __hash__(self):
        key=type_key(self)
        return hash((self.constructor,(self.domain,self.codomain))) if key[0]=='type' else hash(key)


def make(constructor,binder,bound,domain,codomain):
    if not occurs(codomain,binder):return Type(constructor,(domain,codomain))
    return DependentFunctionType(constructor,binder,bound,domain,codomain)


def parse_type(syntax,env,locals,trail=()):
    from .syntax import type_spelling,parse,expression_tree
    head=str(syntax.children[0]);head=env.data['aliases'].get(head,head)
    if not env.is_function_type(Type(head)):raise CleanError('Bound type arguments require an explicit arrow binding')
    binder,domain,codomain=syntax.children[1].children;binder=str(binder)
    if expression_tree(parse(binder,'expression'))!=['Local',binder]:raise CleanError('Invalid dependent function binder')
    if binder in locals or binder in env.data['types'] or binder in env.data['aliases'] or binder in env.data['functions']:
        raise CleanError('Dependent function binder must be fresh')
    domain=env.type(type_spelling(domain),locals,phrases=False,trail=trail)
    if domain==Type('Type'):raise CleanError('Type-valued dependent function binders are not implemented')
    bound=fresh_bound(env,locals)
    scope={**locals,binder:Expr(bound,texid(binder),domain)}
    codomain=env.type(type_spelling(codomain),scope,phrases=False,trail=trail)
    return make(head,binder,bound,domain,codomain)


def substitute(typ,bindings,env,locals):
    from .indices import substitute_index
    if isinstance(typ,DependentFunctionType):
        domain=substitute(typ.domain,bindings,env,locals)
        binder=fresh_source(typ.binder,env,locals,bindings)
        bound=fresh_bound(env,locals)
        scope={**locals,binder:Expr(bound,texid(binder),domain,tree=['Local',binder])}
        replacement={**bindings,typ.binder:scope[binder]}
        codomain=substitute(typ.codomain,replacement,env,scope)
        return make(typ.constructor,binder,bound,domain,codomain)
    if isinstance(typ,ProofType):return ProofType(substitute_index(typ.args[0],bindings,env,locals))
    if isinstance(typ,ValueIndex):
        if not tree_names(index_tree(typ)).intersection(bindings):return typ
        return substitute_index(typ,bindings,env,locals)
    if isinstance(typ,Type):
        if not typ.args and typ.name in bindings:
            value=bindings[typ.name]
            if isinstance(value,Type):return value
            if isinstance(value,Expr) and value.type==Type('Type') and value.tree[0]=='Local':return Type(value.tree[1])
            raise CleanError('Expected a named type argument: '+typ.name)
        return Type(typ.name,tuple(substitute(a,bindings,env,locals) for a in typ.args))
    return bindings.get(typ,typ)


def application(function,args,env,locals,tree,tex):
    from .core import compatible
    if not env.is_function_type(function.type) or len(args)!=1 or not compatible(args[0].type,function.type.args[0]):
        raise CleanError('Function field argument mismatch' if tree[0]=='Apply' else 'Function argument mismatch')
    typ=function.type
    result=substitute(typ.codomain,{typ.binder:args[0]},env,locals) if isinstance(typ,DependentFunctionType) else typ.args[1]
    return Expr('('+function.lean+' '+args[0].lean+')',tex,result,tree=tree)


def inferred_type(name,bound,domain,codomain,env,locals):
    if not occurs(codomain,name):return env.function_type(domain,codomain)
    if domain==Type('Type'):raise CleanError('Type-valued dependent function binders are not implemented')
    constructor=env.function_type(domain,domain).name
    identity=fresh_bound(env,locals)
    scope={**locals,name:Expr(identity,texid(name),domain,tree=['Local',name])}
    codomain=substitute(codomain,{name:scope[name]},env,scope)
    return make(constructor,name,identity,domain,codomain)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
