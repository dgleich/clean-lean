# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent expression/consumer checks for declared numeral atoms."""
from pathlib import Path
import ast,copy,json,os,subprocess,sys,tempfile,importlib.util,re,html
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,lean,latex,parse as parse_document,normalize_layout
from cleanlang.modules import load_document,type_declaration
from cleanlang.bound_calls import bind
from cleanlang.hygiene import substitute
from cleanlang.conversion import index_comparison
from cleanlang.indices import index_value,substitute_index
from cleanlang.dependent_functions import tree_names
from cleanlang.inferred_conversion import value_names
from cleanlang.conditions import source_expression,lean_name
from cleanlang.syntax import expression_spelling,condition_spelling,parse,expression_tree
from cleanlang.annotations import references

e=Environment();results=load_document(HERE/'Expressions.clean.proposed',e)
def expr(source,env=e,locals=None):return Expressions(env,locals or {}).parse(source)
def rejects(action,text):
    try:action()
    except CleanError as error:assert text in str(error),str(error)
    else:raise AssertionError('Expected rejection: '+text)

r=lambda name:e.data['types'][name]['native_binding']
c=lambda name:e.data['types'][name]['numerals']['native_binding']
f=lambda name:e.data['functions'][name]['native_binding']
one=expr('(001: Real)')
assert one.tree[:3]==['BoundNumeral','001','Real']
assert one.lean=='(_root_.'+c('Real')+' (nat_lit 1))'
assert one.tex==r'\left(001 \: : \: \mathbb{R}\right)'
assert expr('(1: Alias)').lean==expr('(1: Real)').lean
assert expr('(1: Real())').lean==expr('(1: Real)').lean
assert expr('(1: Twin)').lean!=expr('(1: Real)').lean
assert expr('real sum((1: Real),(2: Real))').lean==expr('(1: Real)+(2: Real)').lean
assert expr('negative((1: Real))').lean==expr('-(1: Real)').lean
assert expr('(1: Counting)+(2: Counting)').type==Type('Counting')
rejects(lambda:expr('(1: Real)+(2: Counting)'),'No declared meaning')
rejects(lambda:expr('(1: Real)+2'),'numeral interpretation')
rejects(lambda:expr('(1: Function(Real,Real))'),'closed module')
rejects(lambda:expr('(1: Proposition)'),'no Numerals')
rejects(lambda:expr('(1: Missing)'),'Unknown type')
# An annotation is resolved once; its bound identity survives later local shadowing.
local={'Real':Expr('Real','Real',Type('Type'),tree=['Local','Real'])}
rejects(lambda:expr('(1: Real)',locals=local),'closed module')
assert Expressions(e,local).elaborate(one.tree).lean==one.lean
assert bind(one.tree,e,local)==one.tree
assert substitute(one.tree,{'Real':local['Real']},e,local)==one.tree
assert tree_names(one.tree)==value_names(one.tree)==set()
assert references(index_value(one,e,{}),local)==set()
for printer in [expression_spelling,condition_spelling]:assert printer(one.tree)=='(001: Real)'
assert source_expression(one.tree)=='(1: Real)'
assert source_expression(expr('(1: Alias)').tree)==source_expression(one.tree)
assert lean_name(source_expression(one.tree))!=lean_name(source_expression(expr('(1: Twin)').tree))
index=index_value(one,e,{})
assert Expressions(e,{}).elaborate(json.loads(index.syntax)).lean==one.lean
assert substitute_index(index,{},e,local).lean==one.lean
assert index_comparison(one,e,{})==index_comparison(expr('(1: Real)'),e,{})
assert index_comparison(one,e,{})!=index_comparison(expr('(1: Twin)'),e,{})
# No conversion to Python int: long digit strings are emitted canonically.
large=expr('('+'0'*5000+'1: Real)');assert large.lean==one.lean
huge=expr('('+'9'*5000+': Counting)');assert '9'*5000 in huge.lean
# Public comparison and rebinding cannot trust old checked leaf metadata.
for mutate in [
    lambda env:env.notation_definitions.pop(c('Real')),
    lambda env:env.data['types']['Real']['numerals'].__setitem__('payload','fun n : Nat => 0'),
    lambda env:env.notation_definitions.__setitem__(r('Real'),'changed'),
    lambda env:env.data['types']['Real'].__setitem__('universe',1),
    lambda env:env.data['types']['Real'].__setitem__('numerals',copy.deepcopy(env.data['types']['Twin']['numerals']))]:
    changed=copy.deepcopy(e);mutate(changed)
    for check in [lambda:Expressions(changed,{}).elaborate(one.tree),
                  lambda:bind(one.tree,changed,{}),lambda:index_comparison(one,changed,{}),
                  lambda:substitute(one.tree,{},changed,{})]:
        rejects(check,'')
# Syntactic metadata remains validated even for programmatic AST construction.
rejects(lambda:Expressions(e,{}).elaborate(['BoundNumeral','١',*one.tree[2:]]),'ASCII')

# Opaque native metadata is never stripped as a Clean block comment.
opaque='Type Opaque():\n  Means: Nat\n  Numerals: fun n : Nat => /- native -/ n\n  Render latex: N\n'
assert '/- native -/' in normalize_layout(opaque)
for declarations in [
    'Assume nonnegative((1: Real)), nonnegative((001: Alias))',
    'Assume '+lean_name('nonnegative((1: Real))')+': nonnegative((1: Real))\n  Assume nonnegative((1: Real))']:
    source='Result duplicate:\n  Attribution: local; naming; original\n  '+declarations+'\n  Conclude: nonnegative((1: Real))\n'
    rejects(lambda:parse_document(source,e),'Duplicate')
# Binder consumers and beta/index comparison retain the fixed global numeral.
beta=expr('(function(x: Real,(001: Real)))((2: Real))')
assert index_value(beta,e,{}).comparison==index_value(one,e,{}).comparison
quantified=expr('for every(x: Real,(1: Real)=(1: Real))')
assert index_comparison(quantified,e,{}) is not None
# Import the declarations through a separate file, keeping source metadata explicit.
with tempfile.TemporaryDirectory(prefix='numeral-import-') as directory:
    folder=Path(directory)
    common=(HERE/'Expressions.clean.proposed').read_text().split('Result addition with one:')[0]
    common=common.replace('References: references.json','References: '+str(HERE/'references.json'))
    (folder/'Common.clean').write_text(common)
    (folder/'Statements.clean').write_text('Import "Common.clean"\nResult imported:\n  Attribution: local; imports; original\n  Conclude: (1: Alias)=(1: Real)\n')
    imported=Environment();load_document(folder/'Statements.clean',imported)
    assert expr('(1: Alias)',env=imported).lean==expr('(1: Real)').lean

# The portable TextMate subset drives the offline browser as well as VS Code.
spec=importlib.util.spec_from_file_location('numeral_review',COMPILER/'tools/build_review.py')
review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)
source='  nUmErAlS: fun n : Nat => /- native 123 and -/ n'
rendered=review.highlight_source(source)[0]
assert 'class="lean-body"' in rendered and 'class="comment"' not in rendered and 'class="number"' not in rendered
assert html.unescape(re.sub('<[^>]*>','',rendered))==source
assert 'Numerals' in (COMPILER/'editors/emacs/clean-math-mode.el').read_text()
# Native Vim scopes: payload comments are Lean text, not Clean comment spans.
vim=COMPILER/'numeral-scopes.vim'
vim.write_text("set nomore\nnew\ncall setline(1, ['Numerals: fun n : Nat => /- native -/ n'])\nsource "+str(COMPILER/'editors/vim/syntax/cleanmath.vim')+"\ncall assert_equal('cleanMathLean', synIDattr(synID(1, 28, 1), 'name'))\nif len(v:errors) | cquit | endif\nqa!\n")
subprocess.run(['vim','-Nu','NONE','-n','-es','-S',str(vim)],cwd=COMPILER,check=True)

comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in node.targets))
native=lean(results,e,['Lean'])+comparison
uses=[]
for name in ['Real','Counting','Twin']:
    for source_digits,value in [('0','0'),('001','1'),('123','123'),('100000000000000000000000000000000000000','100000000000000000000000000000000000000')]:
        uses.append((f'({source_digits}: {name})','',r(name),f'_root_.{c(name)} (nat_lit {value})',{}))
uses.extend([
 ('(1: Alias)','',r('Real'),f'_root_.{c("Real")} (nat_lit 1)',{}),
 ('(1: Real)+(2: Real)','',r('Real'),f'_root_.{f("real sum")} (_root_.{c("Real")} (nat_lit 1)) (_root_.{c("Real")} (nat_lit 2))',{}),
 ('-(1: Real)','',r('Real'),f'_root_.{f("negative")} (_root_.{c("Real")} (nat_lit 1))',{})])
for collision in [r('Real'),c('Real')]:
    scope={collision:Expr(collision,collision,Type('Real'),tree=['Local',collision])}
    uses.append(('(1: Real)',f'({collision}: _root_.{r("Real")})',r('Real'),f'_root_.{c("Real")} (nat_lit 1)',scope))
for i,(source,binders,typ,expected,scope) in enumerate(uses):
    native+=f'\nnoncomputable def numeral_actual_{i} {binders} : _root_.{typ} := {expr(source,locals=scope).lean}\nnoncomputable def numeral_expected_{i} {binders} : _root_.{typ} := {expected}\nsame_basic_target numeral_actual_{i} numeral_expected_{i}\n'
native+=f'\nnoncomputable def expected_one : _root_.{r("Real")} := _root_.{c("Real")} (nat_lit 1)\nsame_basic_target {f("one")} expected_one\n'
native+=f'\ndef expected_commute : Prop := ∀ (x : _root_.{r("Real")}), @_root_.{f("equal")} _root_.{r("Real")} (_root_.{f("real sum")} x (_root_.{c("Real")} (nat_lit 1))) (_root_.{f("real sum")} (_root_.{c("Real")} (nat_lit 1)) x)\nsame_basic_target CleanStatements.addition_with_one expected_commute\n'
native+=f'\ntheorem commute_proof : CleanStatements.addition_with_one := by intro x; exact add_comm x (_root_.{c("Real")} (nat_lit 1))\ntheorem assumption_proof : CleanStatements.named_numeral_assumption := by intro h; exact h\n'
path=COMPILER/'NumeralExpressionsVerified.lean';path.write_text(native)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(path)],cwd=COMPILER,check=True)
(HERE/'ExpressionsVerified.lean').write_text(native)
(HERE/'Expressions.tex').write_text(latex(results,e))
print(f'Numeral expressions: {len(uses)+2} exact targets, two proofs; consumers, aliases, shadowing, mutation and collision checks passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
