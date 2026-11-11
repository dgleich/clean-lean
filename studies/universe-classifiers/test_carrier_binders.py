# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import unittest
import test_classified_values
from cleanlang.core import Expr,Expressions,CleanError
from cleanlang.modules import notation
from cleanlang.dependent_functions import DependentFunctionType,substitute
from cleanlang.retained_codec import dumps,loads

class CarrierBinders(unittest.TestCase):
 def setUp(self):
  f=test_classified_values.ClassifiedValues();f.setUp();self.e=f.e;self.scope=f.local
 def expr(self,s):return Expressions(self.e,self.scope).parse(s)
 def test_independent_source_tree(self):
  from cleanlang.syntax import parse
  def tree(node):
   return [str(node.data),*[tree(x) for x in node.children]] if hasattr(node,'data') else str(node)
  self.assertEqual(tree(parse('Function(A: Large,Function(x: A,A))','type_ref')),
   ['type_ref','Function',['bound_type_arguments','A',['type_ref','Large'],
    ['type_ref','Function',['bound_type_arguments','x',['type_ref','A'],['type_ref','A']]]]])
 def test_alpha_equivalence_and_hash(self):
  a=self.e.type('Function(A: Large,A)');b=self.e.type('Function(B: Large,B)')
  self.assertIsInstance(a,DependentFunctionType)
  self.assertEqual(a,b);self.assertEqual(hash(a),hash(b));self.assertEqual(self.e.sort_level(a),3)
 def test_classifier_identity_is_not_erased(self):
  test_classified_values.type_declaration('Type Other():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: O'],self.e)
  self.assertNotEqual(self.e.type('Function(A: Large,A)'),self.e.type('Function(A: Other,A)'))
 def test_inferred_lambda(self):
  value=self.expr('function(A: Large,function(x: A,x))')
  self.assertEqual(value.type,self.e.type('Function(B: Large,Function(y: B,B))'))
 def test_authored_family_application(self):
  notation('Define identity family():',['Returns: Function(A: Large,Function(x: A,A))','Equals: function(A: Large,function(x: A,x))'],self.e,authored=True)
  self.assertIn('dependent_signature',self.e.data['functions']['identity family'])
  self.scope['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
  self.assertEqual(self.expr('identity family()(type(TopologicalSpace : Large))(X)').type,self.scope['X'].type)
 def test_wrong_classifier_rejected(self):
  self.scope['f']=Expr('f','f',self.e.type('Function(A: Large,A)'),tree=['Local','f'])
  with self.assertRaises(CleanError):self.expr('f(type(Real))')
 def test_small_classifier_supported(self):
  self.scope['f']=Expr('f','f',self.e.type('Function(A: Type,Function(x: A,A))'),tree=['Local','f'])
  self.assertEqual(self.expr('f(type(Real))').type,self.e.type('Function(Real,Real)'))
 def test_capture_avoidance(self):
  self.scope['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  typ=self.e.type('Function(B: Large,Function(x: A,B))',self.scope)
  new=substitute(typ,{'A':self.e.type('TopologicalSpace')},self.e,{})
  self.assertEqual(new,self.e.type('Function(C: Large,Function(x: TopologicalSpace,C))'))
 def test_serialized_dependent_type(self):
  typ=self.e.type('Function(A: Large,Function(x: A,A))')
  restored=loads(dumps(typ))
  self.assertEqual(restored,typ)
  self.assertEqual(self.e.render_type(restored,'lean'),self.e.render_type(typ,'lean'))
 def test_binder_freshness(self):
  with self.assertRaises(CleanError):self.e.type('Function(A: Large,Function(A: Large,A))')

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
