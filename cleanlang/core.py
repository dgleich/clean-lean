import hashlib
import re
from dataclasses import dataclass, field
from pathlib import Path
from .attribution import Sources, compact, normalize

class CleanError(ValueError): pass

class SignatureMismatch(CleanError):
    def __init__(self,message,owner=None):
        super().__init__(message)
        self.owner=owner

ID = r'[^\W\d]\w*'

def comment_lines(text):
    from .literate import scan
    lines, _, regions = scan(text)
    return [(line, [(a,b) for a,b,_ in spans]) for line,spans in zip(lines,regions)]


def _expression_lines(text, *, masked=False):
    """Join incomplete Clean expressions, keeping their first source line.

    Consumed physical lines remain blank, so diagnostics retain line numbers.
    Lean bodies, metadata, and rendering templates are deliberately opaque.
    """
    lines = text.splitlines() if masked else [line for line, _ in comment_lines(text)]
    output = list(lines)
    start = None
    depth = 0
    continuation_column = 0
    conclusion_column = None
    assumption_list = False
    def unfinished(line):
        last = re.search(r'('+ID+r'|[^\w\s])$', line)
        return (assumption_list and line.rstrip().endswith(',')) or bool(last and (last[0].lower() in Expressions.PREC or
                              last[0].lower() in ('not', '¬', '.')))
    for i, raw in enumerate(lines):
        stripped = raw.strip()
        if not stripped:
            continue
        column = len(raw) - len(raw.lstrip(' '))
        if start is None:
            if conclusion_column is not None and column <= conclusion_column:
                conclusion_column = None
            assumption_list = bool(re.match(r'Assume\b',stripped,re.I))
            if re.fullmatch(r'(?:Conclude|Equals|Holds when)\s*:', stripped, re.I) or re.fullmatch(r'Assume[ ]+[^:]+:', stripped, re.I):
                conclusion_column = column
                continue
            expression = conclusion_column is not None or re.match(
                r'(Let|Define|Notation|Condition|Structure|Type|Assume|Conclude|Returns|Equals|Holds when)\b', stripped, re.I) or re.match(r'Default[ ]+numerals[ ]*:',stripped,re.I)
            if not expression:
                continue
            depth = stripped.count('(') - stripped.count(')')
            if depth > 0 or unfinished(stripped):
                start = i
                continuation_column = column if conclusion_column is not None else column + 2
        else:
            if depth <= 0 and column < continuation_column:
                raise CleanError(f'line {i + 1}: continued expression must be indented at least two spaces beyond its first line')
            if re.match(r'(Let|Define|Condition|Structure|Constructor|Assume|Conclude|Result|Theorem|Context|Import|Attribution|Returns|Numerals|Means|Render|Holds when|Assumption name)(?=\s|:|$)', stripped, re.I) or re.match(r'Default[ ]+numerals[ ]*:',stripped,re.I):
                raise CleanError(f'line {i + 1}: expected a continued expression, not a new clause')
            output[start] += ' ' + stripped
            output[i] = ''
            depth += stripped.count('(') - stripped.count(')')
            if depth <= 0 and not unfinished(stripped):
                start = None
    if start is not None:
        reason = 'unclosed parentheses' if depth > 0 else 'unfinished expression after operator'
        raise CleanError(f'line {start + 1}: {reason} in continued expression')
    return output


def normalize_layout(text):
    """Validate source columns and map nesting to the parser's four-space units.

    Widths belong to blocks, not the file. Preserve physical line numbers;
    blank/comment lines neither open nor close a block. Tabs are always errors.
    """
    from .literate import scan, Prepared
    lines, prose, _ = scan(text)
    columns = [0]
    output = []
    for number, raw in enumerate(_expression_lines('\n'.join(lines), masked=True), 1):
        if '\t' in raw:
            raise CleanError(f'line {number}: tabs are not allowed')
        if not raw.strip():
            output.append(raw)
            continue
        column = len(raw) - len(raw.lstrip(' '))
        if column > columns[-1]:
            if column - columns[-1] < 2:
                raise CleanError(f'line {number}: indentation must increase by at least two spaces')
            columns.append(column)
        elif column < columns[-1]:
            if column not in columns:
                raise CleanError(f'line {number}: dedent must match an established indentation level')
            while columns[-1] > column:
                columns.pop()
        output.append(' ' * (4 * (len(columns) - 1)) + raw[column:])
    return Prepared('\n'.join(output), prose)

@dataclass(frozen=True)
class Type:
    name: str
    args: tuple = ()
    def __str__(self):
        if self.name=='$carrier':return self.args[0].name
        return self.name + ('(' + ','.join(map(str,self.args)) + ')' if self.args else '')
@dataclass(frozen=True)
class LocalType(Type):
    """A local carrier reference, distinct from a module constructor."""
    lean: str = ''
    universe: int = 0
    classifier: str = ''

@dataclass(frozen=True)
class ComputedCarrier(Type):
    """Carrier expression with retained closed level and classifier identity."""
    universe: int = 0
    classifier: str = ''

@dataclass(frozen=True, eq=False)
class ValueIndex:
    name: str
    lean: str
    tex: str = field(compare=False)
    comparison: object = field(default=None, kw_only=True)
    def __str__(self): return self.name
    def comparison_key(self):return self.lean if self.comparison is None else self.comparison
    def __eq__(self,other):
        if not isinstance(other,ValueIndex):return NotImplemented
        return self.comparison_key()==other.comparison_key()
    def __hash__(self):return hash(self.comparison_key())


@dataclass(frozen=True, init=False)
class ProofType(Type):
    """The proposition itself is the Lean type; no choice of proof is made."""
    def __init__(self,index):
        object.__setattr__(self,'name','$proof')
        object.__setattr__(self,'args',(index,))
    def __str__(self):return '('+str(self.args[0])+')'


def proof_type(condition,environment=None,locals=None,*,_fresh=False):
    from .indices import index_value
    if condition.type!=PROP:raise CleanError('A computed proof type must be a condition')
    from .proof_types import index
    return ProofType(index(condition,environment,locals or {},_fresh=_fresh))



def has_value_indices(t):
    from .dependent_functions import DependentFunctionType
    if isinstance(t,DependentFunctionType):return True
    return isinstance(t,Type) and any(isinstance(a,ValueIndex) or has_value_indices(a) for a in t.args)

@dataclass
class Expr:
    lean: str
    tex: str
    type: Type
    precedence: int = 99
    tree: object = None
    # Checked comparison value for a local definition; never used for emission.
    local_normal: object = None
    local_expand: bool = False
    # Ordered, checked implicit arguments; comparison metadata, not source syntax.
    inferred_args: tuple = field(default=(),compare=False,repr=False)
    # Typed children are reusable only with a traversal-local freshness witness.
    checked_args: object = field(default=None,compare=False,repr=False)
    operator_binding: object = field(default=None,compare=False,repr=False)
@dataclass
class Clause:
    kind: str
    names: list
    value: object
    line: int
    label: str = ''
    # Frozen presentation of the authored outer alias; never a semantic type.
    descriptions: dict = field(default_factory=dict,compare=False)
@dataclass
class Result:
    name: str
    attribution: dict = field(default_factory=dict)
    clauses: list = field(default_factory=list)
    conclusion: object = None
    line: int = 0
    contexts: list = field(default_factory=list)
    local_clauses: list = field(default_factory=list)
    documentation: object = None
    environment: object = field(default=None,compare=False,repr=False)
    @property
    def title(self): return self.name.replace('_', ' ')
PROP, NAT, NUM = Type('Proposition'), Type('Natural'), Type('_number')

def split(s):
    out=[]; depth=0; start=0
    for i,c in enumerate(s):
        if c=='(': depth+=1
        if c==')': depth-=1
        if depth<0: raise CleanError('Unmatched parenthesis')
        if c==',' and depth==0: out.append(s[start:i].strip()); start=i+1
    if depth: raise CleanError('Unmatched parenthesis')
    if s[start:].strip(): out.append(s[start:].strip())
    return out

def textext(s):
    d={'\\':r'\textbackslash{}','{':r'\{','}':r'\}','$':r'\$','&':r'\&','#':r'\#','%':r'\%','_':r'\_','~':r'\textasciitilde{}','^':r'\textasciicircum{}'}
    return ''.join(d.get(c,c) for c in s)
def texid(s):
    g={'μ':r'\mu','λ':r'\lambda','ε':r'\varepsilon','δ':r'\delta','α':r'\alpha','β':r'\beta','φ':r'\phi','ψ':r'\psi'}
    return g.get(s, s if len(s)==1 and s.isascii() else r'\mathit{'+textext(s)+'}')

def compatible(a,b):
    return a==b

class Environment:
    """Names introduced by explicit module declarations; initially empty."""
    def __init__(self):
        self.data={'types': {}, 'aliases': {}, 'phrases': [], 'functions': {}}
        self.structures={}
        self.sources=Sources()
        self.notation_definitions={}
        self.definitions={}
        self.lean_imports=[]
        self.loaded_modules=set()
        self.declaration_docs={}
        self.module_docs=[]
    def type(self,s,env=None,phrases=True,trail=(),*,presentation=None):
        from .annotations import Annotation,resolve
        if isinstance(s,Annotation):return resolve(s,self,env or {})
        s=re.sub(r'^(a|an)\s+','',s.strip(),flags=re.I)
        # Constructor applications have reserved structural syntax, never prose dispatch.
        if phrases and not s.startswith('(') and not re.match(ID+r'\s*\(',s):
            matches=[p['type'].format(**m.groupdict()) for p in self.data['phrases'] if (m:=re.fullmatch(p['pattern'],s,re.I))]
            if len(matches)>1: raise CleanError('Ambiguous type phrase: '+s)
            if matches: return self.type(matches[0],env,False,trail,presentation=presentation)
        from .syntax import parse as syntax_parse, type_spelling
        try:syntax=syntax_parse(s,'type_ref')
        except CleanError as e:raise CleanError('Unknown type phrase: '+s) from e
        if syntax.data in ('computed_index','index_reference'):
            from .syntax import expression_tree, type_spelling, parse
            tree=(expression_tree(syntax.children[0]) if syntax.data=='computed_index'
                  else expression_tree(parse(type_spelling(syntax),'expression')))
            value=Expressions(self,env or {}).elaborate(tree)
            if self.classifier_info(value.type) is not None:
                from .carrier_types import carrier
                return carrier(value,self,env or {})
            if syntax.data=='index_reference':raise CleanError('Type projection must have type Type')
            return proof_type(value,self,env or {},_fresh=True)
        if len(syntax.children)>1 and syntax.children[1].data=='bound_type_arguments':
            from .dependent_functions import parse_type
            return parse_type(syntax,self,env or {},trail)
        source_name=str(syntax.children[0])
        name=self.data.get('aliases',{}).get(source_name,source_name)
        args=[type_spelling(x) for x in syntax.children[1].children] if len(syntax.children)>1 else []
        if env and source_name in env and not args and (info:=self.classifier_info(env[source_name].type)) is not None:
            return LocalType(source_name,(),env[source_name].lean,info[1],info[0])
        if name in trail:raise CleanError('Cyclic type alias: '+name)
        if name not in self.data['types']: raise CleanError('Unknown type: '+name)
        kinds=self.data['types'][name].get('args',[])
        if len(args)!=len(kinds): raise CleanError(f'{name} expects {len(kinds)} parameters')
        out=[]
        for a,k in zip(args,kinds):
            if k=='type':
                value=self.type(a,env,trail=trail)
                if not self.is_function_type(Type(name)):self.require_type_argument(value)
                out.append(value);continue
            if isinstance(k,dict):
                if not (a.startswith('(') or re.fullmatch(ID+r'(?:\.'+ID+r')*',a)):
                    raise CleanError('Value index must be a previously declared name, field reference or parenthesized computation: '+a)
                if env is None:raise CleanError('Unknown value index: '+a)
                actual=Expressions(self,env).parse(a)
                spec=self.data['types'][name]
                if 'parameter_types' in spec:
                    from .dependent_functions import substitute
                    expected=substitute(spec['parameter_types'][len(out)],
                        dict(zip(spec['parameter_names'],out)),self,env or {})
                else:expected=self.type(k['value'].format(*map(str,out)),env,False)
                if actual.type!=expected:
                    raise CleanError(f'Value index {a} requires {expected}, got {actual.type}')
                from .indices import index_value
                from .proof_types import index as condition_index
                out.append(condition_index(actual,self,env or {},_fresh=True) if actual.type==PROP else index_value(actual,self,env or {}));continue
            if not (a.startswith('(') or re.fullmatch(r'\d+|'+ID+r'(?:\.'+ID+r')*',a)):
                raise CleanError('Dimension must be a numeral, natural parameter, field or parenthesized computation')
            if re.fullmatch(ID,a) and (env is None or a not in env or env[a].type!=NAT):
                raise CleanError('Declare dimension '+a+' as Natural first')
            from .indices import dimension_index
            actual=Expressions(self,env or {}).parse(a)
            out.append(dimension_index(actual,self,env or {}))
        if 'canonical' in self.data['types'][name]:
            if name in trail: raise CleanError('Cyclic type alias: '+name)
            spec=self.data['types'][name]
            if 'canonical_type' in spec:
                from .dependent_functions import substitute
                resolved=substitute(spec['canonical_type'],dict(zip(spec['parameter_names'],out)),self,env or {})
            else:
                expanded=spec['canonical'].format(*map(str,out))
                resolved=self.type(expanded,env,False,trail+(name,))
            if presentation is not None and any(k in self.data['types'][name] for k in ('prose','prose_plural')):
                spec=self.data['types'][name]
                rendered=[self.render_type(a,'latex') if isinstance(a,Type) else a.tex for a in out]
                for key in ('prose','prose_plural'):
                    if key in spec:presentation[key]=spec[key].format(*rendered)
                # Conservative dependencies: every authored actual, even if unused
                # by the template. Pruning must never retain a Lean binder for prose.
                presentation['dependencies']=set(re.findall(ID,','.join(args))).intersection(env or {})
            return resolved
        return Type(name,tuple(out))
    def render_type(self,t,target,bindings=None):
        from .dependent_functions import DependentFunctionType
        bindings=bindings or {}
        if isinstance(t,LocalType):return t.lean if target=='lean' else texid(t.name)
        if t.name=='$carrier':
            if not isinstance(t,ComputedCarrier):raise CleanError('Carrier type lacks retained classifier metadata')
            return '('+t.args[0].lean+')' if target=='lean' else t.args[0].tex
        if isinstance(t,DependentFunctionType):
            domain=self.render_type(t.domain,target,bindings);codomain=self.render_type(t.codomain,target,bindings)
            if target=='lean':return '('+t.bound+' : '+domain+') → ('+codomain+')'
            return r'\prod_{'+texid(t.binder)+':'+domain+'} '+codomain
        if isinstance(t,ProofType):
            return '('+t.args[0].lean+')' if target=='lean' else t.args[0].tex
        args=[self.render_type(a,target,bindings) if isinstance(a,Type) else
              (a.lean if target=='lean' else a.tex) if isinstance(a,ValueIndex) else
              bindings[a].lean if target=='lean' and a in bindings else
              texid(a) if target=='latex' and not a.isdigit() else a for a in t.args]
        if t.name not in self.data['types']:
            return bindings[t.name].lean if target=='lean' and t.name in bindings else t.name
        spec=self.data['types'][t.name]
        if target=='lean' and 'native_binding' in spec:
            if spec['lean']!=spec['native_template']:
                raise CleanError('Changed bound native type: '+t.name)
            if self.notation_definitions.get(spec['native_binding'])!=spec['native_declaration']:
                raise CleanError('Changed or missing bound native type declaration: '+t.name)
            if self.is_function_type(t) and len(args)==2:
                return '('+args[0]+') → ('+args[1]+')'
            return '(_root_.'+spec['native_binding']+''.join(' ('+a+')' for a in args)+')'
        return spec[target].format(*args)
    def is_function_type(self,t):
        if isinstance(t,LocalType):return False
        if isinstance(t,ProofType):
            from .proof_types import callable_view
            return callable_view(t,self) is not None
        from .dependent_functions import DependentFunctionType
        if isinstance(t,DependentFunctionType):return True
        spec=self.data['types'].get(t.name,{})
        return (spec.get('args')==['type','type'] and
                re.sub(r'\s+','',spec.get('lean',''))=='({0})→({1})')
    def is_proof_type(self,t):
        if isinstance(t,ProofType):return True
        return isinstance(t,Type) and self.is_function_type(t) and len(t.args)==2 and self.is_proof_type(t.args[1])
    def classifier_info(self,t):
        """Resolved declaration metadata, independent of a classifier's name."""
        if not isinstance(t,Type) or isinstance(t,LocalType) or t.args:return None
        spec=self.data['types'].get(t.name,{})
        if 'classifies' not in spec:return None
        return (spec['native_binding'],spec['classifies'])
    def sort_level(self,t):
        """Closed Lean Sort level; local carrier variables retain their closed level."""
        if not isinstance(t,Type) or t==NUM:
            raise CleanError('Cannot determine a closed universe for an unresolved type')
        if isinstance(t,(LocalType,ComputedCarrier)):return t.universe+1
        if t.name=='$carrier':raise CleanError('Carrier type lacks retained classifier metadata')
        if isinstance(t,ProofType):return 0
        if self.is_function_type(t) and len(t.args)==2:
            codomain=self.sort_level(t.args[1])
            return 0 if codomain==0 else max(self.sort_level(t.args[0]),codomain)
        spec=self.data['types'].get(t.name)
        if spec is None:return 1
        if 'canonical' in spec:raise CleanError('Universe checking requires a resolved type alias')
        return spec.get('universe',0)+1
    def require_type_argument(self,t,required=0):
        level=self.sort_level(t)
        if level==0:raise CleanError('Proof types cannot instantiate Type parameters')
        if level!=required+1:raise CleanError('Type parameter requires Lean Type '+str(required)+'; got Type '+str(level-1))
    def function_type(self,domain,codomain):
        names=[name for name in self.data['types'] if self.is_function_type(Type(name))]
        if len(names)!=1:
            raise CleanError('Function expressions require one explicit Lean arrow type binding')
        return Type(names[0],(domain,codomain))
    def describe_type(self,t,plural=False):
        if isinstance(t,LocalType):return ('elements of $' if plural else 'an element of $')+self.render_type(t,'latex')+'$'
        from .dependent_functions import DependentFunctionType
        if isinstance(t,DependentFunctionType):
            value='evidence that $' if self.is_proof_type(t.codomain) else 'a value of type $'
            return ('functions' if plural else 'a function')+' assigning to each $'+texid(t.binder)+' : '+self.render_type(t.domain,'latex')+'$ '+value+self.render_type(t.codomain,'latex')+'$'
        if isinstance(t,ProofType):return 'evidence that $'+self.render_type(t,'latex')+'$'
        spec=self.data['types'].get(t.name,{})
        template=spec.get('prose_plural' if plural else 'prose')
        if template:
            args=[self.render_type(a,'latex') if isinstance(a,Type) else a.tex if isinstance(a,ValueIndex) else (a if a.isdigit() else texid(a)) for a in t.args]
            return template.format(*args)
        return ('elements of $' if plural else 'an element of $')+self.render_type(t,'latex')+'$'
    def match(self,p,a,bind):
        from .numeral_inference import mismatch
        if p.startswith('$'):
            if isinstance(a,Type):self.require_type_argument(a)
            if p in bind and bind[p]!=a: mismatch(self,'Type or dimension mismatch: '+p)
            bind[p]=a; return
        m=re.fullmatch(r'(\w+)(?:\((.*)\))?',p)
        if not m: raise CleanError('Invalid notation signature: '+p)
        ps=split(m[2] or '')
        if not isinstance(a,Type) or isinstance(a,LocalType) or a.name!=m[1] or len(ps)!=len(a.args): mismatch(self,f'Expected {p}, got {a}')
        for p2,a2 in zip(ps,a.args):
            if isinstance(a2,Type) or p2.startswith('$'): self.match(p2,a2,bind)
            elif p2!=a2: mismatch(self,'Dimension mismatch')
    def instantiate(self,p,bind):
        if p.startswith('$'): return bind[p]
        m=re.fullmatch(r'(\w+)(?:\((.*)\))?',p)
        return Type(m[1],tuple(self.instantiate(a,bind) for a in split(m[2] or '')))
    def dependent_call(self, name, spec, args, locals, mismatch_owner=None):
        """Ordered structural substitution; never ask Lean to choose an index."""
        signature=spec['dependent_signature']
        implicit=dict(signature['implicit'])
        parameters=signature['parameters']
        actuals=dict(zip((n for n,_ in parameters),args))
        substitutions={}

        def bind(n,value):
            if n in substitutions and substitutions[n]!=value:
                raise SignatureMismatch('Inconsistent dependent argument: '+n,mismatch_owner)
            if n not in substitutions or (implicit.get(n)==NAT or self.classifier_info(implicit.get(n)) is not None):substitutions[n]=value

        def replacement_bindings(scope):
            from .inferred_conversion import reify
            values=dict(substitutions)
            for n,value in substitutions.items():
                classifier=implicit.get(n)
                if isinstance(value,Type) and self.classifier_info(classifier) is not None:
                    values[n]=reify(value,self,locals,classifier=classifier)
            return {**values,**actuals,**scope}

        def index(n,scope):
            from .indices import index_value, substitute_index
            if n in scope:return index_value(scope[n],self,locals)
            if n in actuals:return index_value(actuals[n],self,locals)
            return substitute_index(ValueIndex(n,'',''),replacement_bindings(scope),self,locals)

        def replace(t,scope=None):
            scope={} if scope is None else scope
            from .indices import ComputedIndex, DimensionIndex, substitute_index
            from .dependent_functions import DependentFunctionType,substitute
            if isinstance(t,DependentFunctionType):return substitute(t,replacement_bindings(scope),self,locals)
            if isinstance(t,ProofType):return ProofType(replace(t.args[0],scope))
            if isinstance(t,DimensionIndex) and t.name in substitutions:return substitutions[t.name]
            if isinstance(t,ComputedIndex):
                return substitute_index(t,replacement_bindings(scope),self,locals)
            if isinstance(t,ValueIndex):return index(t.name,scope)
            if isinstance(t,LocalType):return substitutions.get(t.name,t)
            if isinstance(t,ComputedCarrier):
                from .carrier_types import substitute_carrier
                return substitute_carrier(t,replacement_bindings(scope),self,locals)
            if isinstance(t,Type):
                return Type(t.name,tuple(replace(a,scope) for a in t.args))
            return substitutions.get(t,t)

        def match(pattern,actual,scope=None):
            scope={} if scope is None else scope
            from .proof_types import callable_view
            if isinstance(pattern,ProofType) != isinstance(actual,ProofType):
                pattern=callable_view(pattern,self) or pattern
                actual=callable_view(actual,self) or actual
            from .indices import DimensionIndex
            from .dependent_functions import DependentFunctionType,substitute,fresh_source,fresh_bound,direct_index_name
            if isinstance(pattern,DependentFunctionType) or isinstance(actual,DependentFunctionType) and self.is_function_type(pattern):
                if not self.is_function_type(pattern) or not self.is_function_type(actual):
                    raise SignatureMismatch('Dependent function type mismatch',mismatch_owner)
                pconstructor=pattern.constructor if isinstance(pattern,DependentFunctionType) else pattern.name
                aconstructor=actual.constructor if isinstance(actual,DependentFunctionType) else actual.name
                if pconstructor!=aconstructor:raise SignatureMismatch('Dependent function type mismatch',mismatch_owner)
                match(pattern.args[0],actual.args[0],scope)
                shared=fresh_source('clean_comparison_binder',self,locals,
                                    {**substitutions,**actuals,**scope,'__pattern':pattern,'__actual':actual})
                identity=fresh_bound(self,locals)
                value=Expr(identity,texid(shared),actual.args[0],tree=['Local',shared])
                locals[shared]=value
                try:
                    # Keep the pattern in declaration scope. Apply caller actuals
                    # and shared-binder replacements together only at a leaf.
                    # An instantiated codomain must never re-enter this matcher.
                    a=(substitute(actual.codomain,{actual.binder:value},self,locals)
                       if isinstance(actual,DependentFunctionType) else actual.args[1])
                    nested={**scope,pattern.binder:value} if isinstance(pattern,DependentFunctionType) else scope
                    match(pattern.args[1],a,nested)
                    from .dependent_functions import occurs
                    if any(occurs(v,shared) for v in substitutions.values()):
                        raise CleanError('A dependent function binder cannot escape into an inferred argument')
                finally:
                    del locals[shared]
            elif isinstance(pattern,DimensionIndex) and pattern.name in implicit:
                if implicit[pattern.name]!=NAT or not isinstance(actual,DimensionIndex):
                    raise SignatureMismatch('Expected a natural dimension: '+pattern.name,mismatch_owner)
                bind(pattern.name,actual)
            elif isinstance(pattern,ValueIndex) and direct_index_name(pattern) in implicit and direct_index_name(pattern) not in scope:
                if not isinstance(actual,ValueIndex):
                    raise SignatureMismatch('Expected an indexed value: '+direct_index_name(pattern),mismatch_owner)
                bind(direct_index_name(pattern),actual)
            elif isinstance(pattern,ValueIndex):
                if replace(pattern,scope)!=actual:
                    raise SignatureMismatch('Dependent index mismatch: '+pattern.name,mismatch_owner)
            elif isinstance(pattern,ComputedCarrier):
                if replace(pattern,scope)!=actual:
                    raise SignatureMismatch('Computed carrier mismatch',mismatch_owner)
            elif isinstance(pattern,Type):
                if isinstance(pattern,LocalType) and pattern.name in implicit:
                    info=self.classifier_info(implicit[pattern.name])
                    if info is None or not isinstance(actual,Type) or self.is_proof_type(actual):
                        raise SignatureMismatch('Expected a type argument: '+pattern.name,mismatch_owner)
                    level=self.sort_level(actual)
                    if level!=info[1]+1:
                        raise SignatureMismatch('Type parameter requires Lean Type '+str(info[1])+'; got Type '+str(level-1),mismatch_owner)
                    bind(pattern.name,actual)
                elif isinstance(pattern,LocalType) and pattern.name in substitutions:
                    if substitutions[pattern.name]!=actual:raise SignatureMismatch('Dependent type mismatch: '+pattern.name,mismatch_owner)
                else:
                    expected=replace(pattern if isinstance(pattern,LocalType) else Type(pattern.name),scope)
                    if not isinstance(actual,Type) or isinstance(expected,LocalType)!=isinstance(actual,LocalType) or (isinstance(expected,LocalType) and expected!=actual) or expected.name!=actual.name or len(pattern.args)!=len(actual.args):
                        raise SignatureMismatch(f'Expected type constructor {expected.name} with {len(pattern.args)} arguments, got {actual}',mismatch_owner)
                    for p,a in zip(pattern.args,actual.args):match(p,a,scope)
            elif replace(pattern,scope)!=actual:raise SignatureMismatch('Dimension mismatch',mismatch_owner)

        for n,t in parameters:
            match(t,actuals[n].type)
            if (info:=self.classifier_info(t)) is not None:
                from .carrier_types import carrier
                value=carrier(actuals[n],self,locals)
                self.require_type_argument(value,info[1])
                bind(n,value)
        for n in implicit:
            if n not in substitutions:raise CleanError('Cannot infer implicit parameter: '+n)
        # New value parameters are recovered from typed operand indices. Recheck
        # their terms in the caller scope and their dependent types in telescope
        # order; no native metavariable or typeclass search selects an argument.
        from .inferred_conversion import reify
        inferred_targets={}
        for n,t in signature['implicit']:
            if t!=NAT and self.classifier_info(t) is None:
                value=reify(substitutions[n],self,locals)
                inferred_targets[n]=value.lean
                if not compatible(value.type,replace(t)):
                    raise SignatureMismatch('Inferred value has the wrong dependent type: '+n,mismatch_owner)
        # With every inferred value fixed, verify the complete operand telescope.
        if any(t!=NAT and self.classifier_info(t) is None for _,t in signature['implicit']):
            for n,t in parameters:match(t,actuals[n].type)
        targets=[]
        for n,t in signature['implicit']:
            v=substitutions[n]
            targets.append(inferred_targets[n] if n in inferred_targets else self.render_type(v,'lean',locals) if isinstance(v,Type) else
                           v.lean if isinstance(v,ValueIndex) else locals[v].lean if v in locals else v)
        targets.extend(a.lean for a in args)
        target='(@_root_.'+signature['key']+''.join(' ('+v+')' for v in targets)+')'
        from .operator_bindings import present
        return present(self,name,args,Expr(target,spec['latex'].format(*(a.tex for a in args)),replace(signature['result']),
                    tree=['Call',name,[a.tree for a in args]],
                    inferred_args=tuple((n,substitutions[n]) for n in implicit),checked_args=tuple(args)))

    def operator(self,op,a,b,locals):
        from .operator_bindings import apply
        return apply(self,op,a,b,locals)

    def call(self,name,args,locals=None):
        if name not in self.data['functions']: raise CleanError('Unknown function: '+name)
        s=self.data['functions'][name]; bind={}
        if len(args)!=len(s['params']): raise CleanError('Wrong number of arguments for '+name)
        if 'dependent_signature' in s:return self.dependent_call(name,s,args,locals or {},mismatch_owner=getattr(self,'_numeral_trial_owner',None))
        for p,a in zip(s['params'],args): self.match(p,a.type,bind)
        from .operator_bindings import present
        return present(self,name,args,Expr('('+s['lean'].format(*(a.lean for a in args))+')',s['latex'].format(*(a.tex for a in args)),self.instantiate(s['returns'],bind),tree=['Call',name,[a.tree for a in args]],inferred_args=tuple((p[1],bind['$'+p[1]]) for p in s.get('signature_tree',[None,None,[]])[2] if p[3]=='implicit'),checked_args=tuple(args)))

class Expressions:
    # Presentation/continuation precedence; syntax precedence lives in grammar/clean.lark.
    PREC={'↔':1,'→':2,'or':3,'∨':3,'and':4,'∧':4,'=':5,'≠':5,'!=':5,'<':5,'>':5,'≤':5,'≥':5,'<=':5,'>=':5,'∈':5,'⊆':5,'∣':5,'+':6,'-':6,'∪':6,'∩':6,'*':7,'/':7,'^':8}
    def __init__(self,reg,env): self.reg,self.env=reg,env
    def parse(self,s,expected=None):
        from .syntax import parse,expression_tree
        return self.elaborate(expression_tree(parse(s,'expression')),expected)
    def elaborate(self,tree,expected=None):
        from .numeral_inference import complete
        return complete(tree,self.reg,self.env,expected)
    def _elaborate(self,tree):
        from .annotations import Annotation
        kind=tree[0]
        if kind in ('TypeValue','ClassifiedTypeValue','BoundTypeValue'):
            from .type_values import elaborate
            return elaborate(tree,self.reg,self.env)
        if kind=='BoundLiteral':
            from .literal_binding import elaborate
            return elaborate(tree,self.reg,self.env)
        if kind in ('NumeralAnnotation','BoundNumeral'):
            from .numerals import elaborate
            return elaborate(tree,self.reg,self.env)
        if kind=='Decimal':return Expr(tree[1],tree[1],NUM,tree=tree)
        if kind=='Local':
            if tree[1] not in self.env:raise CleanError('Unknown name: '+tree[1])
            value=self.env[tree[1]]
            if value.type==Type('$unavailableProof'):
                raise CleanError('Evidence for binder-bearing assumptions requires a named Condition declaration')
            return Expr(value.lean,value.tex,value.type,value.precedence,tree)
        if kind=='Apply':
            function=self._elaborate(tree[1]);args=[self._elaborate(a) for a in tree[2]]
            from .dependent_functions import application
            head=function.tex
            if function.tree[0] in ('Operator','Unary'):head='('+head+')'
            return application(function,args,self.reg,self.env,['Apply',function.tree,[a.tree for a in args]],head+'('+args[0].tex+')' if args else '')
        if kind=='Projection':
            from .structures import project
            return project(self.reg,self._elaborate(tree[1]),tree[2],self.env)
        if kind=='Operator':return self.reg.operator(tree[1],self._elaborate(tree[2]),self._elaborate(tree[3]),self.env)
        if kind=='Unary':
            from .operator_bindings import apply_prefix
            return apply_prefix(self.reg,tree[1],self._elaborate(tree[2]),self.env)
        if kind=='ModuleCall':
            from .bound_calls import elaborate
            return elaborate(tree,self.reg,self.env,[self._elaborate(a) for a in tree[2]])
        if kind=='Call':
            tok=tree[1];args=[self._elaborate(a) for a in tree[2]]
            if tok in self.env and self.reg.is_function_type(self.env[tok].type):
                from .dependent_functions import application
                return application(self.env[tok],args,self.reg,self.env,['Call',tok,[a.tree for a in args]],texid(tok)+'('+args[0].tex+')' if args else '')
            return self.reg.call(tok,args,self.env)
        if kind in ('Lambda','Forall','Exists'):
            name=tree[1]
            if name in self.env or name in self.reg.data['functions'] or name in self.reg.data['types'] or name in self.reg.data['aliases']:
                raise CleanError('Binder must be a fresh identifier')
            domain=self.reg.type(tree[2],self.env,phrases=False)
            lean_domain=self.reg.render_type(domain,'lean',self.env)
            occupied=set(self.env)
            for value in self.env.values():occupied.update(re.findall(ID,value.lean))
            while f'clean_bound_{self.bound_counter}' in occupied:self.bound_counter+=1
            bound=f'clean_bound_{self.bound_counter}';self.bound_counter+=1
            pool=getattr(self.reg,'_comparison_pool',None)
            if pool is not None:bound=pool.fresh(self.env)
            previous=self.env;self.env={**previous,name:Expr(bound,texid(name),domain)}
            try:body=self._elaborate(tree[3])
            finally:self.env=previous
            if kind in ('Forall','Exists'):
                if body.type != PROP: raise CleanError('Quantifier body must be a condition')
                truth=self.reg.data['types'].get('Proposition',{})
                if truth.get('args') != [] or truth.get('lean','').strip() != 'Prop':
                    raise CleanError('Quantifiers require the foundational Proposition binding to Lean Prop')
                lean_type=lean_domain
                target=(f'(∀ ({bound} : {lean_type}), {body.lean})' if kind=='Forall' else
                        f'(@Exists ({lean_type}) (fun ({bound} : {lean_type}) => {body.lean}))')
                words='for every' if kind=='Forall' else 'there exists'
                tex=(r'\left(\text{'+words+' }'+texid(name)+r' : '+
                     self.reg.render_type(domain,'latex')+r',\; '+body.tex+r'\right)')
                return Expr(target,tex,PROP,tree=[kind,name,tree[2] if isinstance(tree[2],Annotation) else str(domain),body.tree])
            if body.type==NUM:
                raise CleanError('Function body requires a determined return type')
            from .dependent_functions import inferred_type
            result=inferred_type(name,bound,domain,body.type,self.reg,self.env)
            return Expr(f'(fun ({bound} : {lean_domain}) => {body.lean})',
                        r'\left('+texid(name)+r' \mapsto '+body.tex+r'\right)',result,
                        tree=['Lambda',name,tree[2] if isinstance(tree[2],Annotation) else str(domain),body.tree])
        raise CleanError('Unknown syntax constructor: '+kind)

def binary(op,a,b):
    op={'!=':'≠','<=':'≤','>=':'≥','and':'∧','or':'∨'}.get(op,op)
    if Type('Type') in (a.type,b.type) and op not in ('=','≠'):
        raise CleanError('Type-valued operands support only equality and disequality')
    t=a.type if a.type!=NUM else b.type; lop=op
    if op in ('∧','∨','↔','→'):
        if a.type!=PROP or b.type!=PROP: raise CleanError('Logical operator requires propositions')
        t=PROP
    elif op in ('=','≠','<','>','≤','≥','∣'):
        if not compatible(a.type,b.type): raise CleanError(f'Cannot compare {a.type} and {b.type}')
        t=PROP
    elif op=='∈':
        if b.type.name not in ('Set','List') or not compatible(a.type,b.type.args[0]): raise CleanError('Membership type mismatch')
        t=PROP
    elif op in ('⊆','∪','∩'):
        if a.type!=b.type or a.type.name!='Set': raise CleanError('Set type mismatch')
        t=PROP if op=='⊆' else a.type
    elif op=='*':
        if a.type.name=='Matrix' and b.type.name=='Vector':
            m,n,k=a.type.args
            if b.type.args!=(n,k): raise CleanError('Matrix/vector dimension or field mismatch')
            t,lop=Type('Vector',(m,k)),'*ᵥ'
        elif a.type.name=='Matrix' and b.type.name=='Matrix':
            m,n,k=a.type.args; p,q,j=b.type.args
            if n!=p or k!=j: raise CleanError('Matrix dimension or field mismatch')
            t=Type('Matrix',(m,q,k))
        elif b.type.name in ('Vector','Matrix') and compatible(a.type,b.type.args[-1]): t,lop=b.type,'•'
        elif a.type.name in ('Vector','Matrix') or b.type.name in ('Vector','Matrix'): raise CleanError('Unsupported product')
        elif not compatible(a.type,b.type): raise CleanError('Product type mismatch')
    elif op=='^':
        if b.type not in (NUM,NAT): raise CleanError('Natural exponents required')
        t=a.type
    elif not compatible(a.type,b.type): raise CleanError('Arithmetic type mismatch')
    top={'∧':r'\text{ and }','∨':r'\text{ or }','↔':r'\text{ if and only if }','→':r'\text{ implies }','≠':r'\ne','≤':r'\le','≥':r'\ge','∈':r'\text{ belongs to }','⊆':r'\text{ is a subset of }','∪':r'\cup','∩':r'\cap','∣':r'\text{ divides }','*':r'\,'}.get(op,op)
    prec=Expressions.PREC.get(op,Expressions.PREC.get({'∧':'and','∨':'or'}.get(op,op),5))
    left='('+a.tex+')' if a.precedence<prec else a.tex
    right='('+b.tex+')' if b.precedence<=prec else b.tex
    tex=left+' '+top+' '+right
    if op=='^': tex='{'+left+'}^{'+b.tex+'}'
    if op=='/': tex=r'\frac{'+a.tex+'}{'+b.tex+'}'
    return Expr('('+a.lean+' '+lop+' '+b.lean+')',tex,t,prec,['Operator',op,a.tree,b.tree],checked_args=(a,b))

def _parse_flat(text,reg):
    results=[]; r=None; env={}; labels=set(); mode=None; conclusion=[]
    attribution_seen=False
    def finish():
        if r is None: return
        if conclusion: r.conclusion=Expressions(reg,env).parse(' '.join(conclusion))
        if r.conclusion is None or r.conclusion.type!=PROP: raise CleanError(r.name+': conclude must be a proposition')
        try:
            r.attribution=normalize(r.attribution)
            reg.sources.resolve(r.attribution)
        except ValueError as e: raise CleanError(f'{r.name}: {e}') from e
        results.append(r)
    for num,raw in enumerate(text.splitlines(),1):
        if '\t' in raw: raise CleanError(f'line {num}: tabs are not allowed')
        if not raw.strip(): continue
        indent=len(raw)-len(raw.lstrip()); s=raw.strip()
        try:
            if indent==0:
                from .syntax import parse as syntax_parse,name as syntax_name
                header=syntax_parse(s,'scope_header')
                if str(header.children[0]).lower() not in ('result','theorem'):raise CleanError('Expected Result')
                finish();r=Result(re.sub(r'[_\s]+','_',syntax_name(header.children[1])),line=num)
                env={};labels=set();mode=None;conclusion=[];attribution_seen=False
                if any(x.name==r.name for x in results): raise CleanError('Duplicate result name')
                continue
            if r is None: raise CleanError('Clause outside result')
            if indent==8 and mode=='attribution':
                k,sep,v=s.partition(':'); k=k.lower(); v=v.strip()
                if not sep or not v or not re.fullmatch(r'[a-z_]+',k): raise CleanError('Expected field: value')
                if k in r.attribution: raise CleanError('Duplicate attribution field')
                r.attribution[k]=v; continue
            if indent==8 and mode=='conclude': conclusion.append(s); continue
            if indent!=4: raise CleanError('Unexpected nesting: align sibling clauses within their block')
            if mode=='conclude': raise CleanError('Conclude must be last')
            mode=None
            if re.match(r'attribution\s*:',s,re.I):
                if attribution_seen: raise CleanError('Duplicate attribution clause')
                attribution_seen=True
                rest=s.split(':',1)[1].strip()
                if rest:
                    try: r.attribution=compact(rest)
                    except ValueError as e: raise CleanError(str(e)) from e
                else: mode='attribution'
                continue
            if re.match(r'conclude\b',s,re.I):
                mode='conclude'; rest=re.sub(r'^conclude\s*:?', '',s,flags=re.I).strip()
                if rest: conclusion.append(rest)
                continue
            m=re.fullmatch(r'assume\s+(.+)',s,re.I)
            if m:
                from .conditions import assumption_items
                for label,name,value in assumption_items(m[1],reg,env):
                    if name in env or label in env or name in labels or label in labels: raise CleanError('Duplicate assumption/local name: '+label)
                    labels.update((name,label))
                    r.clauses.append(Clause('assume',[name],value,num,label))
                    if re.fullmatch(ID,label):
                        try:evidence=proof_type(value,reg,env)
                        except CleanError as error:
                            if str(error)!='Computed indices do not introduce binders':raise
                            evidence=Type('$unavailableProof')
                        env[label]=Expr('«'+name+'»',texid(label),evidence)

                continue
            from .syntax import let_clause
            kind,names,payload=let_clause(s)
            if kind=='let':
                descriptions={}
                t=reg.type(payload,env,presentation=descriptions)
                for name in names:
                    if name in env or name in labels:raise CleanError('Invalid or duplicate name: '+name)
                    env[name]=Expr(name,texid(name),t)
                r.clauses.append(Clause('let',names,t,num,descriptions=descriptions))
            else:
                name=names[0]
                if name in env or name in labels:raise CleanError('Duplicate name: '+name)
                # A bare type name is never a value definition.
                if payload[0] in ('Local','Call') and (payload[1] in reg.data['types'] or payload[1] in reg.data['aliases']):
                    raise CleanError('Cannot use let x = Type; use let x: Type or let x be Type')
                value=Expressions(reg,env).elaborate(payload)
                if reg.classifier_info(value.type) is not None:raise CleanError('Type-valued local definitions are not implemented; use a top-level Type declaration')
                if value.type==NUM:raise CleanError('Local definition requires a resolved numeral interpretation')
                if value.type==PROP:raise CleanError('Local condition abbreviations are not implemented; use a top-level Condition declaration')
                from .conversion import local_definition
                env[name]=local_definition(name,value,reg,env)
                r.clauses.append(Clause('define',[name],value,num))
        except CleanError as e: raise CleanError(f'line {num}: {e}') from e
    finish()
    if not results: raise CleanError('No results found')
    return results

@dataclass
class Context:
    name: str
    key: str
    clauses: list
    parents: list
    line: int
    @property
    def title(self): return self.name.replace('_', ' ')


def _dependencies(value):
    text=value.lean if isinstance(value,Expr) else str(value)
    return set(re.findall(ID,text))


def _select_context_parameters(result,inherited):
    # Every assumption is retained. Only unused inherited objects/definitions may disappear.
    used=_dependencies(result.conclusion)
    kept=[]
    for i,clause in reversed(list(enumerate(result.clauses))):
        keep=i>=inherited or clause.kind=='assume'
        names=clause.names
        if clause.kind=='let' and not keep:
            names=[name for name in names if name in used]
            keep=bool(names)
        elif clause.kind=='define' and not keep:
            keep=clause.names[0] in used
        if keep:
            kept.append(Clause(clause.kind,names,clause.value,clause.line,clause.label,dict(clause.descriptions)))
            used.difference_update(names)
            used.update(_dependencies(clause.value))
    ordered=list(reversed(kept))
    available=set()
    for clause in ordered:
        if not clause.descriptions.get("dependencies",set()) <= available:
            clause.descriptions={}
        available.update(clause.names)
    return ordered


class Document(list):
    """Results remain list-compatible; events retain authored prose order."""
    def __init__(self, results=(), events=None):
        super().__init__(results)
        self.events=list(self) if events is None else events


def parse(text,reg):
    """Interpret generated context/result trees; inherited scope is semantic."""
    from .syntax import document,parse as syntax_parse,name as syntax_name
    nodes=document(normalize_layout(text)) if isinstance(text,str) else text
    results=[];events=[];names=set();context_names=set();cache={}
    file_key=hashlib.sha256((text if isinstance(text,str) else repr(nodes)).encode()).hexdigest()[:12]
    def walk(nodes,ancestors,scope_reg):
        for node in nodes:
            item_reg=getattr(node,'_environment',scope_reg)
            if node.kind=='prose':
                events.append(node.payload);continue
            if node.kind not in ('context','result'):raise CleanError('Expected Context or Result')
            header=syntax_parse(node.text,'scope_header')
            title=syntax_name(header.children[1]);name=re.sub(r'[_\s]+','_',title)
            if not re.fullmatch(ID+r'(?:[_\s]+\w+)*',title):raise CleanError('Invalid result/context name')
            if node.kind=='context':
                path=tuple(a['name'] for a in ancestors)+(name,)
                if path in context_names:raise CleanError(f'line {node.line}: Duplicate context name')
                context_names.add(path)
                declarations=[(c.line,c.text) for c in node.children if c.kind.startswith('context_')]
                children=[c for c in node.children if c.kind in ('context','result','prose')]
                item={'name':name,'key':file_key+'-'+str(node.line),'line':node.line,'declarations':declarations}
                walk(children,ancestors+[item],item_reg);continue
            if name in names:raise CleanError(f'line {node.line}: Duplicate result name')
            names.add(name)
            inherited=[d for a in ancestors for d in a['declarations']]
            flattened=['Result '+name+':']+['    '+txt for _,txt in inherited]
            original=[node.line]+[num for num,_ in inherited]
            def append(n,indent):
                flattened.append(' '*indent+n.text);original.append(n.line)
                for child in n.children:append(child,indent+4)
            for child in node.children:append(child,4)
            try:r=_parse_flat('\n'.join(flattened),item_reg)[0]
            except CleanError as e:
                message=re.sub(r'^line (\d+):',lambda m:'line '+str(original[int(m[1])-1])+':',str(e))
                raise CleanError(message) from e
            r.environment=item_reg
            r.line=node.line
            r.documentation=node.documentation
            for clause in r.clauses:clause.line=original[clause.line-1]
            offset=0;contexts=[]
            for a in ancestors:
                source_lines={num for num,_ in a['declarations']}
                count=sum(c.line in source_lines for c in r.clauses)
                if a['key'] not in cache:
                    cache[a['key']]=Context(a['name'],a['key'],r.clauses[offset:offset+count],list(contexts),a['line'])
                contexts.append(cache[a['key']]);offset+=count
            r.contexts=contexts;r.local_clauses=r.clauses[offset:]
            r.clauses=_select_context_parameters(r,offset);results.append(r);events.append(r)
    walk(nodes,[],reg)
    if not results and not events:raise CleanError('No results found')
    return Document(results,events)


def lean(results,reg,imports):
    from .literate import Prose, lean_documentation
    imports=list(dict.fromkeys([*imports,*getattr(reg,'lean_imports',[])]))
    definitions=[(lean_documentation(reg.declaration_docs[key],True) if key in reg.declaration_docs else '')+value for key,value in reg.notation_definitions.items()]
    out=[*(f'import {i}' for i in imports),'',*(lean_documentation(p) for p in reg.module_docs),*definitions,'',*(['open scoped Matrix'] if any(i == 'Mathlib' or 'Matrix' in i for i in imports) else []),'','-- Named hypothesis binders document assumptions even when not dependent.','set_option linter.unusedVariables false','','namespace CleanStatements','']
    for r in getattr(results,'events',results):
        if isinstance(r,Prose):
            if not r.attached: out.append(lean_documentation(r))
            continue
        statement_reg=r.environment or reg
        doc=r.documentation.body.replace('/-','/ -').replace('-/','- /') if r.documentation else ''
        out+=['/--']+([doc,''] if doc else [])+[k+': '+v.replace('/-','/ -').replace('-/','- /') for k,v in r.attribution.items()]+['-/',f'def {r.name} : Prop :=']
        for c in r.clauses:
            if c.kind=='let': out+=['  ∀ ('+' '.join(c.names)+' : '+statement_reg.render_type(c.value,'lean')+'),']
            elif c.kind=='assume': out+=[f'  ∀ («{c.names[0]}» : {c.value.lean}),']
            else: out+=[f'  let {c.names[0]} : {statement_reg.render_type(c.value.type,"lean")} := {c.value.lean};']
        out+=['  '+r.conclusion.lean,'']
    return '\n'.join(out+['end CleanStatements',''])

def _latex_clauses(clauses,reg):
    out=[]
    for c in clauses:
        ns=', '.join(texid(n) for n in c.names)
        if c.kind=='let':
            names=[texid(n) for n in c.names]
            subjects=('$'+names[0]+'$') if len(names)==1 else ', '.join('$'+n+'$' for n in names[:-1])+' and $'+names[-1]+'$'
            description=c.descriptions.get('prose_plural' if len(names)>1 else 'prose')
            out+=['Let '+subjects+' be '+(description or reg.describe_type(c.value,len(names)>1))+'.']
        elif c.kind=='define': out+=['Let $'+ns+' = '+c.value.tex+'$.']
        else: out+=['Assume $'+c.value.tex+r'$ (\texttt{'+textext(c.label or c.names[0])+'}).']
    return out


def _context_references(contexts):
    references=[r'Context (\cleancontextref{'+c.key+'})' for c in contexts]
    return 'Using '+(', '.join(references[:-1])+' and '+references[-1] if len(references)>1 else references[0])+'.'


def _latex_result(r,reg,referenced=False):
    resolved=reg.sources.resolve(r.attribution)
    label=resolved['source']['label']
    if resolved['source']['kind']!='lean': label+=', '+r.attribution['reference']
    citation='['+textext(label)+']'
    if resolved.get('url'): citation=r'\href{'+textext(resolved['url'])+'}{'+citation+'}'
    out=[r'\begin{cleanresult}{'+textext(r.title)+'}'+r'\cleanattribution{'+citation+'}']
    if r.documentation:
        from .literate import latex_prose
        out.append(latex_prose(r.documentation))
    if referenced and r.contexts: out.append(_context_references(r.contexts))
    out+=_latex_clauses(r.local_clauses if referenced else r.clauses,reg)
    out+=[r'Then \['+r.conclusion.tex+r'.\]']
    qualifications=[]
    if r.attribution.get('relationship')=='adapted': qualifications.append('Adapted from the cited source.')
    if 'scope' in r.attribution: qualifications.append('Scope: '+r.attribution['scope'].rstrip('.')+'.')
    for key in ('changes','note'):
        if key in r.attribution: qualifications.append(r.attribution[key].rstrip('.')+'.')
    if qualifications: out+=[r'\par\smallskip{\footnotesize '+textext(' '.join(qualifications))+'}']
    return out+[r'\end{cleanresult}','']


def latex(results,reg):
    from .literate import Prose, latex_prose
    out=['% Generated statements, not proof certificates.']
    seen=set()
    for r in getattr(results,'events',results):
        if isinstance(r,Prose):
            out.extend([latex_prose(r),'']);continue
        statement_reg=r.environment or reg
        if r.contexts:
            out.append(r'\ifcleanreferenced')
            for context in r.contexts:
                if context.key in seen: continue
                seen.add(context.key)
                out.append(r'\begin{cleancontext}{'+textext(context.title)+'}{'+context.key+'}')
                if context.parents: out.append(_context_references(context.parents))
                out+=_latex_clauses(context.clauses,statement_reg)
                out.append(r'\end{cleancontext}')
            out+=_latex_result(r,statement_reg,True)
            out.append(r'\else')
            out+=_latex_result(r,statement_reg)
            out.append(r'\fi')
        else: out+=_latex_result(r,statement_reg)
    return '\n'.join(out)


def bibliography(results,reg):
    # Include all explicitly imported sources, even if some are unused in these results.
    keys=list(reg.sources.entries)
    out=[r'\begin{description}']
    for key in keys:
        source=reg.sources.entries[key]
        text=source.get('author','')+'. '+source['title']
        for field in ('year','publisher','version'):
            if field in source: text += '. '+('Version ' if field=='version' else '')+str(source[field])
        if 'revision' in source: text += '. Revision '+source['revision'][:12]
        entry=textext(text.rstrip('.')+'.')
        if source.get('url'): entry+=r' \href{'+textext(source['url'])+r'}{Source}'
        out += [r'\item['+textext(source['label'])+'] '+entry]
    return '\n'.join(out+[r'\end{description}',''])

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
