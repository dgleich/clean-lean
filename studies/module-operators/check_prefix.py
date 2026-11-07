# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent prefix parse/dispatch checks and canonical Lean oracles."""
from unittest.mock import patch

def check(HERE,source,load,native,emitted):
 from cleanlang.core import Expr,Expressions,CleanError
 from cleanlang.modules import notation
 from cleanlang.syntax import parse,expression_tree
 from cleanlang.conversion import comparison_normal_form
 e=load(source+'\n'+(HERE/'Prefix.clean.proposed').read_text())
 scope={n:Expr(n,n,e.type('Scalar'),tree=['Local',n]) for n in ['x','y']}
 scope['n']=Expr('n','n',e.type('Natural'),tree=['Local','n'])
 scope['v']=Expr('v','v',e.type('Row(n)',scope),tree=['Local','v'])
 def reject(text,fragment):
  try:Expressions(e,scope).parse(text)
  except CleanError as error:assert fragment in str(error),(fragment,str(error));return str(error)
  raise AssertionError('Accepted '+text)
 trees={
  '-x':['Unary','-',['Local','x']],
  '-(x+y)':['Unary','-',['Operator','+',['Local','x'],['Local','y']]],
  'not (x=y)':['Unary','not',['Operator','=',['Local','x'],['Local','y']]],
  '-v':['Unary','-',['Local','v']],
  '-(-x)':['Unary','-',['Unary','-',['Local','x']]],
  'x - -y':['Operator','-',['Local','x'],['Unary','-',['Local','y']]]}
 terms=[]
 for text,tree in trees.items():
  assert expression_tree(parse(text,'expression'))==tree
  term=Expressions(e,scope).parse(text);assert term.tree==tree
  terms.append(term)
 assert r'\left(' in terms[1].tex
 assert r'\left(' in terms[2].tex
 assert Expressions(e,scope).parse('NOT (x=y)').lean==terms[2].lean
 assert Expressions(e,scope).parse('¬(x=y)').lean==terms[2].lean
 # Syntax is independent of overloads and retains power/unary precedence.
 assert expression_tree(parse('-x^y','expression'))==['Unary','-',['Operator','^',['Local','x'],['Local','y']]]
 assert expression_tree(parse('(-x)^y','expression'))==['Operator','^',['Unary','-',['Local','x']],['Local','y']]
 reject('-1','numeral interpretation');reject('not x','No declared meaning')
 e.prefix_overloads['-'].reverse()
 for text,old in zip(trees,terms):
  new=Expressions(e,scope).parse(text);assert (new.lean,new.type)==(old.lean,old.type)
 e.prefix_overloads['-'].reverse()
 # Normalization must also use the declared prefix, never native negation.
 normalized=comparison_normal_form(terms[0],e,scope)
 assert normalized.lean==terms[0].lean
 # Reject Row(n) by its head without evaluating its uninferred n for a diagnostic.
 assert Expressions(e,{'x':scope['x']}).parse('-x').lean==terms[0].lean
 authored=Expressions(e,scope).parse('authored opposite(x)')
 assert comparison_normal_form(authored,e,scope).lean==terms[0].lean
 f=lambda name:e.data['functions'][name]['lean'].split()[0]
 neg,not_,sub,row,authored_name=(f(n) for n in ['scalar opposite','condition negation','scalar difference','row opposite','authored opposite'])
 add,eq=(f(n) for n in ['scalar addition','scalar equality'])
 for key,value in e.notation_definitions.items():
  if key in emitted:assert emitted[key]==value,'Conflicting native identity'
  else:native+=value+'\n'
 native+=f'''
noncomputable def expected_prefix_neg (x : Real) : Real := -x
noncomputable def expected_prefix_not (p : Prop) : Prop := ¬p
noncomputable def expected_prefix_sub (x y : Real) : Real := x-y
noncomputable def expected_prefix_row {{n : Nat}} (x : Fin n → Real) : Fin n → Real := -x
noncomputable def expected_authored_opposite (x : Real) : Real := {neg} x
same_basic_target {neg} expected_prefix_neg
same_basic_target {not_} expected_prefix_not
same_basic_target {sub} expected_prefix_sub
same_basic_target {row} expected_prefix_row
same_basic_target {authored_name} expected_authored_opposite
'''
 calls=[f'{neg} x',f'{neg} ({add} x y)',f'{not_} ({eq} x y)',f'@{row} n v',f'{neg} ({neg} x)',f'{sub} x ({neg} y)']
 types=['Real','Real','Prop','Fin n → Real','Real','Real']
 for i,(term,call,typ) in enumerate(zip(terms,calls,types)):
  binders='(n : Nat) (x y : Real) (v : Fin n → Real)'
  native+=f'noncomputable def actual_prefix_{i} {binders} : {typ} := {term.lean}\n'
  native+=f'noncomputable def expected_prefix_{i} {binders} : {typ} := {call}\n'
  native+=f'same_basic_target actual_prefix_{i} expected_prefix_{i}\n'
 native+=f'theorem prefix_double_opposite (x : Real) : {neg} ({neg} x) = x := by\n change -(-x) = x\n exact neg_neg x\n'
 # Invalid metadata must not publish a declaration or binding.
 for field,arity in [('Prefix: +',1),('Prefix: -',2),('Prefix: - extra',1)]:
  before=dict(e.data['functions']);bindings={k:list(v) for k,v in e.prefix_overloads.items()}
  params='x' if arity==1 else 'x,y'
  try:notation('Notation invalid('+params+'):', ['Let '+params+': Scalar','Returns: Scalar',field,'Means: x','Render latex: {x}'],e)
  except CleanError:pass
  else:raise AssertionError('Invalid prefix accepted')
  assert e.data['functions']==before and e.prefix_overloads==bindings
 # A generic competitor interrupted during matching invalidates uniqueness.
 notation('Notation generic prefix(x):',['Let T: Type','Let x: T','Returns: T','Prefix: -','Means: x','Render latex: {x}'],e)
 with patch.object(e,'require_type_argument',side_effect=TimeoutError('incomplete prefix')):
  try:Expressions(e,scope).parse('-x')
  except TimeoutError:pass
  else:raise AssertionError('Ignored interrupted prefix candidate')
 e.prefix_overloads['-'].remove('generic prefix')
 notation('Notation other opposite(x: Scalar): Scalar:',['Prefix: -','Means: -x','Render latex: -{x}'],e)
 message=reject('-x','Ambiguous operator');e.prefix_overloads['-'].reverse()
 assert reject('-x','Ambiguous operator')==message
 # Adding a prefix overload must freeze existing authored-body expansion.
 assert comparison_normal_form(authored,e,scope).lean==authored.lean
 e.prefix_overloads.clear();reject('-x','No declared meaning');reject('not (x=y)','No declared meaning')
 return native

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
