# generated: gpt-6 2026-11-05 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Generated syntax trees plus explicit layout adapter; no Lean name/type lookup."""
from dataclasses import dataclass, field
from . import generated_parser as generated

_PARSER=generated.Lark_StandAlone()


def parse(text,start):
    from .core import CleanError
    source=text.strip()
    try:
        tree=_PARSER.parse(source+' ',start=start)
        # Opaque/type-text terminals may consume the synthetic EOF boundary.
        # Remove that boundary from token values; it is never authored payload.
        def trim(node):
            for i,child in enumerate(node.children):
                if isinstance(child,generated.Tree):trim(child)
                elif child.end_pos is not None and child.end_pos>len(source):
                    node.children[i]=generated.Token.new_borrow_pos(child.type,source[child.start_pos:],child)
        trim(tree)
        return tree
    except generated.UnexpectedInput as e:
        raise CleanError(f'Syntax error ({start}) at column {e.column}: '+str(e).splitlines()[0]) from e
    except (RecursionError,MemoryError) as e:
        raise CleanError('Incomplete syntax analysis: resource exhaustion') from e


def name(tree):return ' '.join(map(str,tree.children))


def type_spelling(tree):
    if isinstance(tree,generated.Token):return str(tree)
    if tree.data=='computed_index':return '('+condition_spelling(expression_tree(tree.children[0]))+')'
    if tree.data=='index_reference':return '.'.join(map(str,tree.children))
    if tree.data=='type_ref':
        head=str(tree.children[0])
        if len(tree.children)>1 and tree.children[1].data=='bound_type_arguments':
            binder,domain,codomain=tree.children[1].children
            return head+'('+str(binder)+': '+type_spelling(domain)+','+type_spelling(codomain)+')'
        return head+('('+','.join(type_spelling(x) for x in tree.children[1].children)+')' if len(tree.children)>1 else '')
    raise ValueError('Expected a type syntax tree')


def type_tree(tree):
    """Neutral constructor syntax: names are not classified as types or values here."""
    if isinstance(tree,generated.Token):return ['Numeral',str(tree)]
    if tree.data=='computed_index':return ['ComputedIndex',expression_tree(tree.children[0])]
    if tree.data=='index_reference':
        result=['Name',str(tree.children[0])]
        for field in tree.children[1:]:result=['Projection',result,str(field)]
        return result
    head=str(tree.children[0])
    if len(tree.children)==1:return ['Name',head]
    if tree.children[1].data=='bound_type_arguments':
        binder,domain,codomain=tree.children[1].children
        return ['BoundTypeApply',head,str(binder),type_tree(domain),type_tree(codomain)]
    return ['Apply',head,[type_tree(x) for x in tree.children[1].children]]


def expression_spelling(tree):
    """Canonical, fully grouped source for binder-free index expressions."""
    from .core import CleanError
    kind=tree[0]
    if kind in ('Local','Decimal'):return tree[1]
    if kind=='TypeValue':return 'type('+tree[1]+')'
    if kind=='Call':return tree[1]+'('+','.join(map(expression_spelling,tree[2]))+')'
    if kind=='Projection':
        base=expression_spelling(tree[1])
        if tree[1][0]=='Apply':base='('+base+')'
        return base+'.'+tree[2]
    if kind=='Apply':
        if tree[1][0] not in ('Local','Projection'):raise CleanError('Computed index application requires a named function or field')
        return expression_spelling(tree[1])+'('+','.join(map(expression_spelling,tree[2]))+')'
    if kind=='Operator':return '('+expression_spelling(tree[2])+' '+tree[1]+' '+expression_spelling(tree[3])+')'
    if kind=='Unary':return '('+tree[1]+' '+expression_spelling(tree[2])+')'
    raise CleanError('Computed indices do not introduce binders')


def expression_tree(tree):
    """Pure syntax normalization, independent of the binding environment."""
    kind=tree.data; c=tree.children
    if kind=='chain':
        result=expression_tree(c[0])
        for i in range(1,len(c),2):
            op=str(c[i]).lower();op={'!=':'≠','<=':'≤','>=':'≥','and':'∧','or':'∨'}.get(op,op)
            result=['Operator',op,result,expression_tree(c[i+1])]
        return result
    if kind=='projection':
        result=expression_tree(c[0])
        for field in c[1:]:
            if isinstance(field,generated.Tree):
                result=['Apply',result,[expression_tree(a) for a in field.children[0].children] if field.children else []]
            else:result=['Projection',result,str(field)]
        return result
    if kind=='group':return expression_tree(c[0])
    if kind=='local':return ['Local',str(c[0])]
    if kind=='type_value':return ['TypeValue',type_spelling(c[1])]
    if kind=='decimal':return ['Decimal',str(c[0])]
    if kind=='call':return ['Call',name(c[0]),[expression_tree(x) for x in c[1].children] if len(c)>1 else []]
    if kind=='unary':return ['Unary','-' if str(c[0])=='-' else 'not',expression_tree(c[1])]
    if kind in ('universal','existential'):
        return ['Forall' if kind=='universal' else 'Exists',str(c[2]),type_spelling(c[3]),expression_tree(c[4])]
    if kind=='function':return ['Lambda',str(c[1]),type_spelling(c[2]),expression_tree(c[3])]
    raise ValueError('Unknown generated expression node: '+kind)


def header(text):
    tree=parse(text,'header');kind,called=tree.children[:2];params=[];result=None
    for child in tree.children[2:]:
        if child.data=='parameters':
            params=[(str(p.children[0]),text[p.children[1].meta.start_pos:p.children[1].meta.end_pos].strip() if len(p.children)>1 else None) for p in child.children]
        else:result=text[child.meta.start_pos:child.meta.end_pos].strip()
    return str(kind).lower(),name(called),params,result


def structure_header(text):
    tree=parse(text,'structure_header')
    parameters=[]
    for p in (tree.children[1].children if len(tree.children)>1 else []):
        typ=text[p.children[1].meta.start_pos:p.children[1].meta.end_pos].strip() if len(p.children)>1 else None
        parameters.append([str(p.children[0]),typ])
    return ['StructureHeader',str(tree.children[0]),parameters]


class Layout:
    always_accept=('_NL',)
    def process(self,stream):
        levels=[0]
        for token in stream:
            yield token
            if token.type=='_NL':
                width=len(str(token).rsplit('\n',1)[-1])
                if width>levels[-1]:
                    levels.append(width);yield generated.Token.new_borrow_pos('_INDENT','',token)
                else:
                    while width<levels[-1]:
                        levels.pop();yield generated.Token.new_borrow_pos('_DEDENT','',token)
        while len(levels)>1:
            levels.pop();yield generated.Token('_DEDENT','')


_DOCUMENT=generated.Lark_StandAlone(postlex=Layout())

@dataclass
class Node:
    kind: str
    text: str
    line: int
    children: list = field(default_factory=list)
    payload: object = None
    documentation: object = None


def document(normalized):
    """Parse an already layout-normalized source; preserve original source lines."""
    from .core import CleanError
    lines=[(i,line.rstrip()) for i,line in enumerate(normalized.splitlines(),1)
           if line.strip()]
    if not lines:return []
    source='\n'.join(line for _,line in lines)+'\n'
    try:tree=_DOCUMENT.parse(source,start='document')
    except generated.UnexpectedInput as e:
        line=lines[min(e.line-1,len(lines)-1)][0]
        raise CleanError(f'line {line}: Unexpected nesting or syntax: '+str(e).splitlines()[0]) from e
    except (MemoryError,RecursionError) as e:raise CleanError('Incomplete syntax analysis: resource exhaustion') from e
    def convert(tree):
        token=tree.children[0]
        if tree.data in ('documented', 'documented_result'):
            node=convert(tree.children[1])
            node.documentation=normalized.prose[lines[token.line-1][0]]
            return node
        node=Node(str(tree.data),str(token).strip(),lines[token.line-1][0],
                  [convert(c) for c in tree.children[1:] if isinstance(c,generated.Tree)])
        if node.kind=='prose': node.payload=normalized.prose[node.line]
        return node
    nodes=[convert(c) for c in tree.children if isinstance(c,generated.Tree)]
    def validate(node):
        # Complete source syntax validation precedes module binding/elaboration.
        text=node.text
        try:
            if node.kind=='declaration':
                kind=text.split(None,1)[0].lower()
                start={'type':'type_header','source':'source_header','structure':'structure_header'}.get(kind,'header')
                node.payload=parse(text,start)
                if kind not in ('define','condition') and any(c.children for c in node.children):
                    raise CleanError('Expression blocks are only implemented for Define and Condition')
            elif node.kind in ('context','result'):node.payload=parse(text,'scope_header')
            elif node.kind=='import_stmt':node.payload=parse(text,'import_line')
            elif node.kind=='alias_stmt':node.payload=parse(text,'alias_line')
            elif node.kind=='phrase_stmt':node.payload=parse(text,'phrase_line')
            elif node.kind.endswith('_let'):node.payload=parse(text,'let_clause')
            elif node.kind.endswith('_assume'):node.payload=parse(text.split(None,1)[1],'assumptions')
            elif node.kind in ('expression_field','conclusion'):
                import re
                body=(re.sub(r'^Conclude\b\s*:?\s*','',text,flags=re.I) if node.kind=='conclusion' else text.split(':',1)[1]).strip()
                if node.children:
                    if body:raise CleanError('Unexpected nesting after complete expression field')
                    body=' '.join(c.text for c in node.children)
                node.payload=parse(body,'expression')
            elif node.kind in ('declaration_field','attribution_entry'):node.payload=parse(text,'field')
            for child in node.children:validate(child)
        except CleanError as e:raise CleanError(f'line {node.line}: {e}') from e
    for node in nodes:validate(node)
    return nodes


def let_clause(text):
    tree=parse(text,'let_clause')
    if tree.data=='typed_let':
        _,ids,typ=tree.children
        return 'let',[str(x) for x in ids.children],text[typ.meta.start_pos:typ.meta.end_pos].strip()
    keyword,identifier,body=tree.children
    return 'define',[str(identifier)],expression_tree(body)


def fields(nodes):
    from .core import CleanError
    result=[]
    for node in nodes:
        text=node.text
        if node.kind=='expression_field':
            if node.children and text.split(':',1)[1].strip():
                raise CleanError('Unexpected nesting after complete expression field')
            text+=' '.join(' '+child.text for child in node.children)
        result.append(text.strip())
    return result

def condition_spelling(tree):
    """Canonical source for scoped condition expressions; no environment lookup."""
    from .core import CleanError
    kind=tree[0]
    if kind in ('Local','Decimal'):return tree[1]
    if kind=='TypeValue':return 'type('+tree[1]+')'
    if kind=='Call':return tree[1]+'('+','.join(map(condition_spelling,tree[2]))+')'
    if kind=='Projection':
        base=condition_spelling(tree[1])
        if tree[1][0]=='Apply':base='('+base+')'
        return base+'.'+tree[2]
    if kind=='Apply':
        if tree[1][0] not in ('Local','Projection'):raise CleanError('Computed index application requires a named function or field')
        return condition_spelling(tree[1])+'('+','.join(map(condition_spelling,tree[2]))+')'
    if kind=='Operator':return '('+condition_spelling(tree[2])+' '+tree[1]+' '+condition_spelling(tree[3])+')'
    if kind=='Unary':return '('+tree[1]+' '+condition_spelling(tree[2])+')'
    if kind in ('Forall','Exists','Lambda'):
        word={'Forall':'for every','Exists':'there exists','Lambda':'function'}[kind]
        return word+'('+tree[1]+': '+tree[2]+','+condition_spelling(tree[3])+')'
    raise CleanError('Unsupported proof expression')
