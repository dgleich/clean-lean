# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Default directives, monotone import composition and independent Lean targets."""
from pathlib import Path
import ast,copy,json,os,subprocess,sys,tempfile,importlib.util,re,html
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,lean,latex,normalize_layout
from cleanlang.modules import load_document,load_module,notation
from cleanlang import syntax
from cleanlang.numeral_inference import declare_default,complete,IncompleteNumeralAnalysis
from cleanlang.numerals import identity

e=Environment();results=load_document(HERE/'Defaults.clean.proposed',e)
s={'x':Expr('x','x',Type('Real'),tree=['Local','x'])}
def expr(source,env=e,locals=s,expected=None):return Expressions(env,locals).parse(source,expected)
def rejects(action,message='',kind=CleanError):
    try:action()
    except kind as error:assert message in str(error),str(error)
    else:raise AssertionError('Expected rejection: '+message)

# Independent pure syntax tree, with capitalization and whitespace variants.
for source in ['Default numerals: Counting','dEfAuLt NuMeRaLs : Counting','Default   numerals: Counting','Default numerals: Counting(\n  )']:
    node=syntax.document(normalize_layout(source+'\n'))[0]
    assert node.kind=='default_numerals_stmt'
    assert str(node.payload.data)=='default_numerals_line'
    assert syntax.type_tree(node.payload.children[0]) in (['Name','Counting'],['Apply','Counting',[]])
rejects(lambda:syntax.parse('Defaultnumerals: Counting','default_numerals_line'))
for source in ['Defaultnumerals: Counting','Default numerals:', 'Default numerals: Counting:', 'Default numerals = Counting',
               'Default numerals: Counting\n  Means: Nat',
               'Type Bad():\n  Means: Nat\n  Default numerals: Counting\n  Render latex: N']:
    rejects(lambda source=source:syntax.document(normalize_layout(source+'\n')))

# A multiword callable does not become a directive merely because of its name.
node=syntax.document(normalize_layout('Result names:\n  Attribution: local; names\n  Conclude: f(\n    default numerals(x)\n  )\n'))[0]
assert syntax.expression_tree(node.children[-1].payload)==['Call','f',[['Call','default numerals',[['Local','x']]]]]

for source,explicit in [('1','(1: Counting)'),('1+2','(1: Counting)+(2: Counting)'),
                        ('x+1','x+(1: Real)'),('real sum(1,2)','real sum((1: Real),(2: Real))'),
                        ('-1','-(1: Real)'),('equal(1,1)','equal((1: Counting),(1: Counting))'),
                        ('(1: Real)=1','(1: Real)=(1: Real)')]:
    assert expr(source).lean==expr(explicit).lean,source
assert expr('1',expected=Type('Twin')).lean==expr('(1: Twin)').lean
assert expr('001').tex==r'\left(001 \: : \: \mathbb{N}\right)'
assert expr('x+1').tex=='x+1'
assert expr('1').tree[4]=='defaulted'
selected=expr('1')
other=Environment();load_module(HERE/'Common.clean.proposed',other);declare_default('Real',other)
assert expr('1',env=other).type==Type('Real')
assert Expressions(other,{}).elaborate(selected.tree).lean==selected.lean
assert Expressions(other,{}).elaborate(json.loads(json.dumps(selected.tree))).lean==selected.lean
# Repeated declarations of the same canonical binding are idempotent.
original=e.numeral_default
declare_default('Counting()',e);assert e.numeral_default==original
rejects(lambda:declare_default('Alias',e),'Conflicting numeral defaults')
assert e.numeral_default==original
for bad in ['Proposition','Missing','Function(Real,Real)']:
    rejects(lambda bad=bad:declare_default(bad,e))
    assert e.numeral_default==original
# A default is not an early exit, a budget override, or an ambiguity resolver.
tree=syntax.expression_tree(syntax.parse('1+2','expression'))
rejects(lambda:complete(tree,e,s,limit=8),'Incomplete numeral',IncompleteNumeralAnalysis)
original_call=e.call;observed=[]
def late_failure(name,args,locals=None):
    if args and args[0].type==Type('Twin'):
        assert observed
        raise TimeoutError('late unresolved alternative')
    result=original_call(name,args,locals);observed.append(result);return result
with patch.object(e,'call',side_effect=late_failure):
    rejects(lambda:expr('real sum(1,2)'),'late unresolved',TimeoutError)
assert not hasattr(e,'_numeral_trial_owner')
ambiguous=copy.deepcopy(e)
ambiguous.data['functions']['another sum']=copy.deepcopy(e.data['functions']['counting sum'])
ambiguous.operator_overloads['+'].append('another sum')
rejects(lambda:expr('1+2',env=ambiguous),'Ambiguous operator')
# Simultaneous defaults cannot choose one side of a symmetric mixed signature.
cross=copy.deepcopy(e)
for name,left,right in [('cross left','Real','Counting'),('cross right','Counting','Real')]:
    notation(f'Notation {name}(x: {left},y: {right}): Real:',
        ['Infix: ^','Means: 0','Render latex: {x}^{{{y}}}'],cross)
rejects(lambda:expr('1^2',env=cross),'conflicts across ambiguous positions')
rejects(lambda:expr('2^1',env=cross),'conflicts across ambiguous positions')
# Remove the default from viable solutions; it must not invent a new one.
without=copy.deepcopy(e);without.operator_overloads['+'].remove('counting sum')
notation('Notation twin sum(x: Twin,y: Twin): Twin:',
    ['Infix: +','Means: x+y','Render latex: {x}+{y}'],without)
rejects(lambda:expr('1+2',env=without),'Ambiguous numeral')
# Reversed enumeration preserves each selected target and each conflict.
reverse=copy.deepcopy(e);reverse.data['types']=dict(reversed(list(reverse.data['types'].items())))
for values in reverse.operator_overloads.values():values.reverse()
assert expr('1+2',env=reverse).lean==expr('1+2').lean
changed=copy.deepcopy(e);changed.notation_definitions.pop(e.numeral_default[1][3])
rejects(lambda:expr('1',env=changed),'Changed')

with tempfile.TemporaryDirectory(prefix='numeral-default-imports-') as directory:
    folder=Path(directory);common=str(HERE/'Common.clean.proposed')
    (folder/'A.clean').write_text(f'Import "{common}"\nDefault numerals: Counting\n')
    (folder/'B.clean').write_text(f'Import "{common}"\nAlias CountAlias: Counting\nDefault numerals: CountAlias\n')
    (folder/'Real.clean').write_text(f'Import "{common}"\nDefault numerals: Real\n')
    for order in [('A','B'),('B','A')]:
        root=folder/'Root.clean';root.write_text(''.join(f'Import "{name}.clean"\n' for name in order))
        imported=Environment();load_module(root,imported)
        assert imported.numeral_default==e.numeral_default
    for order in [('A','Real'),('Real','A')]:
        root.write_text(''.join(f'Import "{name}.clean"\n' for name in order))
        rejects(lambda:load_module(root,Environment()),'Conflicting numeral defaults')
    # The later directive must not retroactively resolve an earlier statement.
    root.write_text(f'Import "{common}"\nResult early:\n  Attribution: local; scope; original\n  Conclude: equal(1,1)\nDefault numerals: Counting\n')
    rejects(lambda:load_document(root,Environment()),'Ambiguous numeral')

# Portable browser/TextMate and native Vim scopes cover the new directive.
spec=importlib.util.spec_from_file_location('default_review',COMPILER/'tools/build_review.py')
review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)
line='Default numerals: Counting -- explicit convention'
rendered=review.highlight_source(line)[0]
assert 'class="keyword"' in rendered and 'class="type"' in rendered and 'class="comment"' in rendered
assert html.unescape(re.sub('<[^>]*>','',rendered))==line
assert 'Default +numerals' in (COMPILER/'editors/emacs/clean-math-mode.el').read_text()
vim=COMPILER/'default-scopes.vim'
vim.write_text("set nomore\nnew\ncall setline(1, ['Default numerals: Counting -- note'])\nsource "+str(COMPILER/'editors/vim/syntax/cleanmath.vim')+"\ncall assert_equal('cleanMathDefaultKeyword', synIDattr(synID(1, 2, 1), 'name'))\ncall assert_equal('cleanMathDefaultNumerals', synIDattr(synID(1, 19, 1), 'name'))\ncall assert_equal('cleanMathComment', synIDattr(synID(1, 31, 1), 'name'))\nif len(v:errors) | cquit | endif\nqa!\n")
subprocess.run(['vim','-Nu','NONE','-n','-es','-S',str(vim)],cwd=COMPILER,check=True)

r=lambda name:e.data['types'][name]['native_binding']
c=lambda name:e.data['types'][name]['numerals']['native_binding']
f=lambda name:e.data['functions'][name]['native_binding']
N=lambda name,value:f'_root_.{c(name)} (nat_lit {value})'
comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in node.targets))
native=lean(results,e,['Lean'])+comparison
uses=[('1','',r('Counting'),N('Counting',1)),
      ('1+2','',r('Counting'),f'_root_.{f("counting sum")} ({N("Counting",1)}) ({N("Counting",2)})'),
      ('x+1',f'(x : _root_.{r("Real")})',r('Real'),f'_root_.{f("real sum")} x ({N("Real",1)})'),
      ('-1','',r('Real'),f'_root_.{f("negative")} ({N("Real",1)})')]
for i,(source,binders,typ,target) in enumerate(uses):
    native+=f'\nnoncomputable def default_actual_{i} {binders} : _root_.{typ} := {expr(source).lean}\nnoncomputable def default_expected_{i} {binders} : _root_.{typ} := {target}\nsame_basic_target default_actual_{i} default_expected_{i}\n'
eq=lambda carrier,a,b:f'@_root_.{f("equal")} _root_.{r(carrier)} ({a}) ({b})'
statement_targets=[
 ('default_addition',eq('Counting',f'_root_.{f("counting sum")} ({N("Counting",1)}) ({N("Counting",2)})',N('Counting',3))),
 ('constrained_addition',f'∀ (x : _root_.{r("Real")}), '+eq('Real',f'_root_.{f("real sum")} x ({N("Real",1)})',f'_root_.{f("real sum")} ({N("Real",1)}) x')),
 ('explicit_annotation_constrains_inference',eq('Real',N('Real',1),N('Real',1))),
 ('default_named_assumption',eq('Counting',N('Counting',1),N('Counting',1))+' → '+eq('Counting',N('Counting',1),N('Counting',1)))]
for title,target in statement_targets:
    native+=f'\ndef expected_{title} : Prop := {target}\nsame_basic_target CleanStatements.{title} expected_{title}\n'
native+='''
theorem default_addition_proof : CleanStatements.default_addition := by rfl
theorem default_constraint_proof : CleanStatements.constrained_addition := by intro x; exact add_comm _ _
theorem explicit_constraint_proof : CleanStatements.explicit_annotation_constrains_inference := by rfl
theorem default_assumption_proof : CleanStatements.default_named_assumption := by intro h; exact h
'''
path=COMPILER/'NumeralDefaultsVerified.lean';path.write_text(native)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(path)],cwd=COMPILER,check=True)
# Exercise the public CLI's document-combination/emission path as well.
cli=COMPILER/'NumeralDefaultsCLI.lean'
subprocess.run([sys.executable,'-m','cleanlang','lean',str(HERE/'Defaults.clean.proposed'),'-o',str(cli)],cwd=COMPILER,check=True)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(cli)],cwd=COMPILER,check=True)
(HERE/'DefaultsVerified.lean').write_text(native)
(HERE/'Defaults.tex').write_text(latex(results,e))
print('Numeral defaults: eight exact targets, four proofs; syntax, import confluence, scope, simultaneous selection and incomplete-analysis checks passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
