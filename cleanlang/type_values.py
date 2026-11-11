"""Closed-universe carrier values and structural source substitution."""
from .core import Expr,Type,Expressions,CleanError

def substitute(tree,bindings,environment,locals):
    from .hygiene import substitute as hygienic
    from .dependent_functions import tree_names
    from .inferred_conversion import reify
    needed=tree_names(tree)
    actuals={};types={}
    for name,value in bindings.items():
        if name not in needed:continue
        if isinstance(value,Type):types[name]=value
        elif isinstance(value,Expr):actuals[name]=value
        else:actuals[name]=reify(value,environment,locals)
    return hygienic(tree,actuals,environment,locals,types)

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md


KINDS=('TypeValue','ClassifiedTypeValue','BoundTypeValue')


def spelling(tree):
    if tree[0]=='TypeValue':return 'type('+str(tree[1])+')'
    explicit=tree[0]=='ClassifiedTypeValue' or tree[4]=='explicit'
    return 'type('+str(tree[1])+(' : '+str(tree[2]) if explicit else '')+')'


def classifier_snapshot(classifier,env):
    """Closed classifier contract, including its selected native declaration."""
    info=env.classifier_info(classifier)
    if info is None:raise CleanError('Type value requires a declared carrier classifier')
    spec=env.data['types'][classifier.name]
    from .modules import classifier_level
    level=classifier_level({'classifies':str(info[1]),'universe':str(spec.get('universe')),
        'means':spec.get('lean','')},spec.get('parameter_names',[]))
    if spec.get('args')!=[] or 'numerals' in spec:
        raise CleanError('Invalid closed carrier classifier')
    env.render_type(classifier,'lean')
    return (info[0],level,spec['universe'],spec['lean'],spec['native_declaration'])


def select_classifier(value,env):
    level=env.sort_level(value)-1
    if level<0:raise CleanError('Proof types cannot be first-class carrier values')
    candidates={}
    for name,spec in env.data['types'].items():
        if spec.get('args')!=[]:continue
        classifier=env.type(name,phrases=False)
        info=env.classifier_info(classifier)
        if info is None or info[1]!=level:continue
        snapshot=classifier_snapshot(classifier,env)
        previous=candidates.get(snapshot[0])
        if previous is not None and previous!=classifier:
            raise CleanError('Inconsistent aliases for one classifier identity')
        candidates[snapshot[0]]=classifier
    if not candidates:raise CleanError('No declared classifier for carrier level '+str(level))
    if len(candidates)!=1:raise CleanError('Ambiguous carrier classifier; use type(T : C)')
    return next(iter(candidates.values()))


def elaborate(tree,env,locals):
    from .annotations import Annotation,checked,references
    kind=tree[0]
    if kind=='BoundTypeValue':
        if len(tree)!=5 or not all(isinstance(x,Annotation) for x in tree[1:3]) or tree[4] not in ('implicit','explicit'):
            raise CleanError('Retained type value requires checked annotations and presentation')
        value=env.type(tree[1],locals,phrases=False)
        classifier=env.type(tree[2],locals,phrases=False)
        snapshot=classifier_snapshot(classifier,env)
        if tree[3]!=snapshot:raise CleanError('Changed retained carrier classifier')
        carrier_annotation,classifier_annotation=tree[1:3]
        presentation=tree[4]
    else:
        value=env.type(tree[1],locals,phrases=False)
        classifier=(select_classifier(value,env) if kind=='TypeValue'
                    else env.type(tree[2],locals,phrases=False))
        snapshot=classifier_snapshot(classifier,env)
        carrier_annotation=(checked(tree[1],env,locals) if isinstance(tree[1],Annotation)
                            else Annotation(str(value),value,references(value,locals)))
        classifier_annotation=checked(str(classifier),env,{})
        presentation='implicit' if kind=='TypeValue' else 'explicit'
    if not references(value,locals).issubset(carrier_annotation.names):
        raise CleanError('Untracked carrier references in retained annotation')
    missing=carrier_annotation.names.difference(locals)
    if missing:raise CleanError('Unbound carrier references: '+', '.join(sorted(missing)))
    if classifier_annotation.names:raise CleanError('Retained classifier annotation must be closed')
    env.require_type_argument(value,snapshot[1])
    retained=['BoundTypeValue',carrier_annotation,classifier_annotation,snapshot,presentation]
    tex=env.render_type(value,'latex',locals)
    if presentation=='explicit':tex=r'\left('+tex+r' : '+env.render_type(classifier,'latex')+r'\right)'
    return Expr(env.render_type(value,'lean',locals),tex,classifier,tree=retained)
