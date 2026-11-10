from pathlib import Path
import sys,unittest
from cleanlang.core import Environment,Expr,Type,NAT,Expressions,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.conversion import comparison_normal_form
from cleanlang.structures import declare
ROOT=Path(__file__).resolve().parents[1]
class InferredConversion(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/operators.clean',self.e);self.local={}
  notation('Define constant map(x):',['Let T: Type','Let x: T','Returns: Function(T,T)','Equals: function(y: T,x)'],self.e,authored=True)
  notation('Define apply endomap(f,x):',['Let T: Type','Let f: Function(T,T)','Let x: T','Returns: T','Equals: f(x)'],self.e,authored=True)
 def bind(self,n,t):
  self.local[n]=Expr(n,n,(Type('Type') if t=='Type' else self.e.type(t,self.local)),tree=['Local',n])
 def expr(self,s):return Expressions(self.e,self.local).parse(s)
 def normal(self,s):return comparison_normal_form(self.expr(s),self.e,self.local)
 def test_independent_tree(self):
  from cleanlang.syntax import parse,expression_tree
  self.assertEqual(expression_tree(parse('apply endomap(constant map(x),z)','expression')),
   ['Call','apply endomap',[['Call','constant map',[['Local','x']]],['Local','z']]])
 def test_computed_index_counts_as_value_position(self):
  from cleanlang.inferred_conversion import value_names
  self.assertEqual(value_names(['Lambda','x','Vector((carrier size(T)),Real)',['Local','x']]),
   {'carrier size','T','x'})
  self.assertNotIn('T',value_names(['Lambda','x','Function(T,Real)',['Local','x']]))
 def test_annotation_substitution_independent_tree(self):
  from cleanlang.hygiene import substitute
  self.bind('n','Natural')
  actual=self.e.type('Function(p: Natural,Vector(p,Real))',self.local)
  self.assertEqual(substitute(['Lambda','x','T',['Local','x']],{},self.e,self.local,{'T':actual}),
   ['Lambda','clean_conversion_bound_1','Function(clean_conversion_bound_0: Natural,Vector(clean_conversion_bound_0,Real))',['Local','clean_conversion_bound_1']])
 def test_inferred_metadata_declaration_order(self):
  notation('Define first value(x,y):',['Let U,T: Type','Let x: T','Let y: U','Returns: T','Equals: x'],self.e,authored=True)
  self.bind('x','Real');self.bind('n','Natural')
  self.assertEqual(self.expr('first value(x,n)').inferred_args,(('U',NAT),('T',Type('Real'))))
 def test_shadowed_module_stays_opaque(self):
  self.bind('x','Real');self.bind('z','Real')
  self.local['Vector']=Expr('Vector','Vector',Type('Type'),tree=['Local','Vector'])
  source='apply endomap(constant map(x),z)'
  self.assertEqual(self.normal(source).lean,self.expr(source).lean)
 def test_primitive_type_annotation(self):
  self.bind('x','Real');self.bind('z','Real')
  value=self.expr('apply endomap(constant map(x),z)')
  self.assertEqual(self.normal('apply endomap(constant map(x),z)').lean,'x')
  self.assertIn('cleanDefine_constant_map',value.lean)
  self.assertEqual(self.expr('constant map(x)').inferred_args,(('T',Type('Real')),))
 def test_compound_type_annotation(self):
  self.bind('n','Natural');self.bind('x','Vector(n,Real)');self.bind('z','Vector(n,Real)')
  self.assertEqual(self.normal('apply endomap(constant map(x),z)').lean,'x')
 def test_inserted_type_is_simultaneous_not_resubstituted(self):
  self.bind('T','Type');self.bind('x','Function(T,Real)');self.bind('z','Function(T,Real)')
  self.assertEqual(self.normal('apply endomap(constant map(x),z)').lean,'x')
 def test_bound_type_freshened_against_later_local(self):
  self.bind('x','Function(p: Natural,Vertex(p))');self.bind('z','Function(q: Natural,Vertex(q))')
  self.bind('p','Natural');self.bind('clean_conversion_bound_0','Natural')
  before=dict(self.local)
  self.assertEqual(self.normal('apply endomap(constant map(x),z)').lean,'x')
  self.assertEqual(self.local,before)
 def test_inferred_natural_expression(self):
  notation('Define vector dimension(v):',['Let n: Natural','Let v: Vector(n,Real)','Returns: Natural','Equals: n'],self.e,authored=True)
  self.bind('m','Natural');self.bind('v','Vector((m+1),Real)')
  self.assertEqual(self.normal('vector dimension(v)').lean,self.normal('m+1').lean)
 def test_inferred_natural_literal(self):
  notation('Define vector dimension(v):',['Let n: Natural','Let v: Vector(n,Real)','Returns: Natural','Equals: n'],self.e,authored=True)
  self.bind('v','Vector(3,Real)')
  constructor=self.e.data['types']['Natural']['numerals']['native_binding']
  self.assertEqual(self.normal('vector dimension(v)').lean,f'(_root_.{constructor} (nat_lit 3))')
 def box(self):
  declare('Structure Box(T: Type):',['Let value: T','Constructor: box value'],self.e)
  notation('Define box(x):',['Let T: Type','Let x: T','Returns: Box(T)','Equals: box value(T,x)'],self.e,authored=True)
 def test_named_type_value_legacy_call(self):
  self.box();self.bind('U','Type');self.bind('x','U')
  self.assertEqual(self.normal('box(x).value').lean,'x')
 def test_nonnamed_type_value_expands(self):
  self.box();self.bind('x','Real')
  self.assertEqual(self.normal('box(x).value').lean,'x')
 def test_named_type_in_dependent_call(self):
  load_module(ROOT/'library/diagrams/pullbacks.clean',self.e)
  for n,t in [('K','Type'),('field','FieldStructure(K)'),('V','Type'),('E','Type'),('W','Type'),('F','Type'),
   ('Q','DiagramShape(V,E)'),('R','DiagramShape(W,F)'),('f','DiagramShapeMap(V,E,W,F,Q,R)'),
   ('M','ModuleDiagram(K,field,W,F,R)'),('v','V')]:self.bind(n,t)
  from cleanlang.indices import index_value
  a=self.expr('pull back diagram(field,Q,R,f,M).object(v)');b=self.expr('M.object(f.vertices(v))')
  self.assertEqual(index_value(a,self.e,self.local),index_value(b,self.e,self.local))
if __name__=='__main__':unittest.main(verbosity=2)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
