import sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
from cleanlang.core import Environment,Expr,Expressions,Type,NAT,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.structures import declare
from cleanlang.conversion import comparison_normal_form
from cleanlang.syntax import parse,expression_tree
from cleanlang.indices import index_value,substitute_index
from cleanlang.conditions import source_expression,lean_name
class TypeValues(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/logic/type_equality.clean',self.e);self.local={}
  notation('Notation marker(T):',['Let T: Type','Returns: Natural','Means: 0','Render latex: m({T})'],self.e)
 def expr(self,s):return Expressions(self.e,self.local).parse(s)
 def test_tree(self):
  for source in ['type(Vector(n,Real))','TYPE(Vector(n,Real))']:
   self.assertEqual(expression_tree(parse(source,'expression')),['TypeValue','Vector(n,Real)'])
 def test_not_value_call(self):
  with self.assertRaises(CleanError):self.expr('type(marker(3))')
 def test_universe_gate(self):
  declare('Structure Big():',['Universe: 1','Let value: Real','Constructor: big'],self.e)
  self.local['x']=Expr('x','x',Type('Real'),tree=['Local','x'])
  for source in ['type(Big)','type(Type)','type((x = x))']:
   with self.assertRaises(CleanError):self.expr(source)
  key=self.e.data['types']['Proposition']['native_binding']
  self.assertEqual(self.expr('type(Proposition)').lean,f'(_root_.{key})')
 def test_explicit_constructor(self):
  declare('Structure Box(T: Type):',['Let value: T','Constructor: box value'],self.e)
  self.local['x']=Expr('x','x',Type('Real'),tree=['Local','x'])
  self.assertEqual(self.expr('box value(type(Real),x)').type,Type('Box',(Type('Real'),)))
 def test_inferred_compound_constructor_projection(self):
  declare('Structure Box(T: Type):',['Let value: T','Constructor: box value'],self.e)
  notation('Define box(x):',['Let T: Type','Let x: T','Returns: Box(T)','Equals: box value(T,x)'],self.e,authored=True)
  self.local['f']=Expr('f','f',self.e.type('Function(Real,Real)'),tree=['Local','f'])
  self.assertEqual(comparison_normal_form(self.expr('box(f).value'),self.e,self.local).lean,'f')
 def test_dimension_substitution(self):
  self.local={n:Expr(n,n,NAT,tree=['Local',n]) for n in ['n','m']}
  a=index_value(self.expr('marker(type(Vector(n,Real)))'),self.e,self.local)
  b=substitute_index(a,{'n':self.local['m']},self.e,{'m':self.local['m']})
  self.assertEqual(b.name,'(marker(type(Vector(m,Real))))')
 def test_dependent_carrier_keys(self):
  a=index_value(self.expr('marker(type(Function(n: Natural,Vector(n,Real))))'),self.e,self.local)
  self.local['clean_pi_bound_0']=Expr('clean_pi_bound_0','q',NAT,tree=['Local','clean_pi_bound_0'])
  b=index_value(self.expr('marker(type(Function(m: Natural,Vector(m,Real))))'),self.e,self.local)
  self.assertEqual(a,b)
 def test_auto_name(self):
  source=source_expression(expression_tree(parse('type(Vector(n,Real))','expression')))
  self.assertEqual(source,'type(Vector(n,Real))')
  self.assertNotEqual(lean_name(source),lean_name('Vector(n,Real)'))
 def load_statement(self,clauses):
  from pathlib import Path
  import tempfile
  from cleanlang.modules import load_document
  source='Import "'+str(ROOT/'studies/topology/Common.clean')+'"\nAlias Scalar: Real\nCondition reflexive(T,x):\n  Let T: Type\n  Let x: T\n  Holds when: x = x\nResult names:\n  Attribution: topology; type names; original\n  Let x,y: Real\n'+clauses+'\n  Conclude: x = x\n'
  with tempfile.TemporaryDirectory() as d:
   path=Path(d)/'Names.clean';path.write_text(source)
   return load_document(path,Environment())
 def test_actual_condition_names_and_duplicates(self):
  results=self.load_statement('  Assume reflexive(type(Real),x), reflexive(type(Real),y)')
  self.assertEqual([c.label for c in results[0].clauses if c.kind=='assume'],
   ['reflexive(type(Real), x)','reflexive(type(Real), y)'])
  with self.assertRaisesRegex(CleanError,'Duplicate'):
   self.load_statement('  Assume reflexive(type(Real),x), reflexive(type(Scalar),x)')
 def test_local_type_definition_rejects(self):
  with self.assertRaisesRegex(CleanError,'Type-valued local definitions'):
   self.load_statement('  Let R = type(Real)')
 def test_malformed_and_keyword_boundaries(self):
  for source in ['type()','type(Real,Real)','type x']:
   with self.assertRaises(CleanError):parse(source,'expression')
  self.assertEqual(expression_tree(parse('type_value','expression')),['Local','type_value'])
 def test_free_type_index_not_captured(self):
  from cleanlang.hygiene import substitute
  self.local['n']=Expr('n','n',NAT,tree=['Local','n'])
  tree=['TypeValue','Function(k: Natural,Vector(n,Real))']
  actual=Expr('k','k',NAT,tree=['Local','k'])
  result=substitute(tree,{'n':actual},self.e,{'k':actual})
  self.assertEqual(result,['TypeValue','Function(clean_conversion_bound_0: Natural,Vector(k,Real))'])
 def test_meta_sort_cannot_instantiate_small_carrier(self):
  notation('Define retain(x):',['Let T: Type','Let x: T','Returns: T','Equals: x'],self.e,authored=True)
  with self.assertRaisesRegex(CleanError,'Type 0'):
   self.expr('retain(type(Real))')
 def test_explicit_foundation_required(self):
  del self.e.data['types']['Type']
  with self.assertRaisesRegex(CleanError,'foundational Type binding'):
   self.expr('type(Real)')
 def test_continuation_and_encoded_collision(self):
  results=self.load_statement('  Assume reflexive(\n    type(Real),x)')
  self.assertEqual([c.label for c in results[0].clauses if c.kind=='assume'],['reflexive(type(Real), x)'])
  with self.assertRaisesRegex(CleanError,'Duplicate'):
   self.load_statement('  Assume reflexive(type(Real),x), reflexive_u28_type_u28_Real_u29__u2c__x_u29_: reflexive(type(Real),y)')
 def test_browser_highlighting(self):
  import importlib.util
  spec=importlib.util.spec_from_file_location('type_expression_review',ROOT/'tools/build_review.py')
  review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)
  for keyword in ['type','TYPE']:
   self.assertIn('<span class="keyword">'+keyword+'</span>',review.highlight('pack('+keyword+'(Real),x)'))
  self.assertNotIn('class="keyword"',review.highlight('-- type(Real)'))
 def test_type_operators_are_restricted(self):
  for source in ['type(Real)+type(Real)','type(Real)*type(Real)',
                 'type(Real)^2','type(Real)<type(Real)','-type(Real)']:
   with self.subTest(source=source),self.assertRaisesRegex(CleanError,'No (declared meaning for operator|consistent numeral interpretation)'):
    self.expr(source)
  self.local['U']=Expr('U','U',Type('Type'),tree=['Local','U'])
  with self.assertRaisesRegex(CleanError,'No (declared meaning for operator|consistent numeral interpretation)'):self.expr('U+U')
  real=self.e.data['types']['Real']['native_binding'];complex=self.e.data['types']['Complex']['native_binding']
  eq=self.e.data['functions']['equal carriers']['native_binding']
  ne=self.e.data['functions']['unequal carriers']['native_binding']
  self.assertEqual(self.expr('type(Real)=type(Complex)').lean,f'(@_root_.{eq} ((_root_.{real})) ((_root_.{complex})))')
  self.assertEqual(self.expr('type(Real)!=type(Complex)').lean,f'(@_root_.{ne} ((_root_.{real})) ((_root_.{complex})))')
 def test_carrier_equality_requires_explicit_module(self):
  env=Environment();load_module(ROOT/'library/operators.clean',env)
  with self.assertRaisesRegex(CleanError,'No declared meaning for operator ='):
   Expressions(env,{}).parse('type(Real)=type(Real)')
  load_module(ROOT/'library/logic/type_equality.clean',env)
  self.assertEqual(Expressions(env,{}).parse('type(Real)=type(Real)').type,Type('Proposition'))
 def test_carrier_overload_does_not_replace_value_equality(self):
  self.local['x']=Expr('x','x',self.e.type('Real'),tree=['Local','x'])
  value=self.expr('x=x')
  self.assertEqual(value.operator_binding[0],'equal')
  self.assertEqual(self.expr('type(Real)=type(Real)').operator_binding[0],'equal carriers')
 def test_competing_carrier_equalities_are_ambiguous(self):
  from cleanlang.modules import condition_declaration
  condition_declaration('Condition other equality(A: Type,B: Type):',
   ['Infix: =','From Lean: A = B'],self.e)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):
   self.expr('type(Real)=type(Real)')
 def test_computed_type_is_an_explicit_carrier(self):
  declare('Structure Box(T: Type):',['Let value: T','Constructor: box value'],self.e)
  notation('Define real carrier(): Type:', ['Equals: type(Real)'],self.e,authored=True)
  self.local['x']=Expr('x','x',Type('Real'),tree=['Local','x'])
  self.assertEqual(self.expr('box value(real carrier(),x)').type,self.e.type('Box(Real)',self.local))
  self.assertEqual(self.expr('real carrier() = type(Real)').type,Type('Proposition'))
 def test_local_value_with_dependent_carrier_does_not_rebind(self):
  from cleanlang.conversion import local_definition
  declare('Structure Box(T: Type):',['Let value: T','Constructor: box value'],self.e)
  typ=self.e.type('Function(k: Natural,Vector(k,Real))',self.local)
  self.local['f']=Expr('f','f',typ,tree=['Local','f'])
  value=self.expr('box value(type(Function(k: Natural,Vector(k,Real))),f)')
  self.local['b']=local_definition('b',value,self.e,self.local)
  before=comparison_normal_form(self.expr('b.value'),self.e,self.local).lean
  self.local['Real']=Expr('R','R',Type('Type'),tree=['Local','Real'])
  self.assertEqual(comparison_normal_form(self.expr('b.value'),self.e,self.local).lean,before)
if __name__=='__main__':unittest.main(verbosity=2)

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
