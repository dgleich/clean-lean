# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Finite, exhaustive completion of expression-position numeral holes."""
from itertools import product
from .core import CleanError,SignatureMismatch,Expressions,Type
from .numerals import identity,digits

class IncompleteNumeralAnalysis(CleanError):pass


def mismatch(env,message):
    owner=getattr(env,'_numeral_trial_owner',None)
    if owner is None:raise CleanError(message)
    raise SignatureMismatch(message,owner)


def holes(tree):
    found=[]
    def visit(node,path):
        kind=node[0]
        if kind=='Decimal':digits(node[1]);found.append((path,node[1]));return
        if kind in ('Local','TypeValue','NumeralAnnotation','BoundNumeral'):return
        if kind in ('Call','ModuleCall'):
            for i,arg in enumerate(node[2]):visit(arg,path+(2,i))
        elif kind=='Apply':
            visit(node[1],path+(1,))
            for i,arg in enumerate(node[2]):visit(arg,path+(2,i))
        elif kind=='Projection':visit(node[1],path+(1,))
        elif kind=='Operator':visit(node[2],path+(2,));visit(node[3],path+(3,))
        elif kind=='Unary':visit(node[2],path+(2,))
        elif kind in ('Forall','Exists','Lambda'):visit(node[3],path+(3,))
        else:raise IncompleteNumeralAnalysis('Uncovered numeral-hole constructor: '+kind)
    visit(tree,())
    return found


def declare_default(source,env):
    typ=env.type(source,{},phrases=False)
    if type(typ) is not Type or typ.args:raise CleanError('Default numerals requires a closed module carrier')
    selected=(typ.name,tuple(identity(typ.name,env)))
    previous=getattr(env,'numeral_default',None)
    if previous is not None and previous!=selected:raise CleanError('Conflicting numeral defaults')
    env.numeral_default=selected


def default_carrier(env):
    selected=getattr(env,'numeral_default',None)
    if selected is None:return None
    name,snapshot=selected
    if tuple(identity(name,env))!=snapshot:raise CleanError('Changed numeral default binding')
    return name


def complete(tree,env,locals,expected=None,*,limit=4096):
    if type(limit) is not int or limit<1:raise ValueError('Numeral trial limit must be a positive integer')
    positions=holes(tree)
    def evaluate(node):
        worker=Expressions(env,dict(locals));worker.bound_counter=0
        return worker._elaborate(node)
    if not positions:
        result=evaluate(tree)
        if expected is not None and result.type!=expected:
            mismatch(env,f'Expression has type {result.type}; expected {expected}')
        return result
    preferred=default_carrier(env)
    choices=[(name,identity(name,env)) for name,spec in env.data['types'].items() if 'numerals' in spec]
    choices.sort(key=lambda item:tuple(item[1]))
    if not choices:raise CleanError('No declared numeral interpretation')
    owner=object();missing=object();previous=getattr(env,'_numeral_trial_owner',missing)
    successes=[]
    def rebuild(node,path,replacements):
        if path in replacements:return replacements[path]
        if isinstance(node,list):return [rebuild(v,path+(i,),replacements) for i,v in enumerate(node)]
        return node
    try:
        env._numeral_trial_owner=owner
        def solutions(node):
            local_positions=holes(node)
            if not local_positions:return [(evaluate(node),(),node)]
            kind=node[0]
            # Binder bodies are checked as a whole, in the scope introduced by
            # their own elaboration. Never inspect their locals in caller scope.
            paths=([(2,i) for i in range(len(node[2]))] if kind in ('Call','ModuleCall') else
                   [(1,)]+[(2,i) for i in range(len(node[2]))] if kind=='Apply' else
                   [(2,),(3,)] if kind=='Operator' else
                   [(2,)] if kind=='Unary' else [(1,)] if kind=='Projection' else [])
            def at(path):
                value=node
                for step in path:value=value[step]
                return value
            parts=[solutions(at(path)) for path in paths]
            widths=[len(part) for part in parts] if paths else [len(choices)]*len(local_positions)
            count=1
            for width in widths:count*=width
            if count>limit:
                raise IncompleteNumeralAnalysis(f'Incomplete numeral analysis: more than {limit} local assignments')
            found=[]
            assignments=product(*parts) if paths else product(choices,repeat=len(local_positions))
            for assignment in assignments:
                if paths:
                    replacements={path:item[2] for path,item in zip(paths,assignment)}
                    names=tuple(name for item in assignment for name in item[1])
                else:
                    replacements={path:['BoundNumeral',text,name,snapshot,'inferred']
                        for (path,text),(name,snapshot) in zip(local_positions,assignment)}
                    names=tuple(name for name,_ in assignment)
                candidate=rebuild(node,(),replacements)
                try:result=evaluate(candidate)
                except SignatureMismatch as error:
                    if error.owner is not owner:raise
                    continue
                found.append((result,names,candidate))
            return found
        successes=[item for item in solutions(tree)
            if expected is None or item[0].type==expected]
    finally:
        if previous is missing:del env._numeral_trial_owner
        else:env._numeral_trial_owner=previous
    if not successes:raise CleanError('No consistent numeral interpretation')
    restrictions=[]
    if len(successes)>1 and preferred is not None:
        # All restrictions are computed from the same complete solution set.
        # Applying them sequentially would make defaults depend on hole order.
        restrictions=[i for i in range(len(positions))
            if len({assignment[i] for _,assignment,_ in successes})>1
            and any(assignment[i]==preferred for _,assignment,_ in successes)]
        narrowed=[item for item in successes if all(item[1][i]==preferred for i in restrictions)]
        if not narrowed:raise CleanError('Numeral default conflicts across ambiguous positions; add annotations')
        successes=narrowed
    if len(successes)!=1:raise CleanError(f'Ambiguous numeral interpretation: {len(successes)} assignments')
    result,_,candidate=successes[0]
    if restrictions:
        # Keep defaults visible in standalone mathematical output. Ordinary
        # inferred numerals retain their unannotated presentation.
        replacements={}
        for i in restrictions:
            path,_=positions[i];node=candidate
            for step in path:node=node[step]
            replacements[path]=[*node[:4],'defaulted']
        result=evaluate(rebuild(candidate,(),replacements))
    return result

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
