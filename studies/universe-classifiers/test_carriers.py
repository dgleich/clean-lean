# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,Expr,Expressions,LocalType,CleanError
from cleanlang.modules import load_module,type_declaration,notation
from cleanlang.dependent_functions import type_key,substitute
ROOT=Path(__file__).resolve().parents[2]
class HigherCarriers(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/types.clean',self.e)
  type_declaration('Type Large():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: L'],self.e)
  type_declaration('Type Bundle():',['Universe: 1','Means: Type','Render latex: B'],self.e)
  notation('Notation hold(x):',['Let A: Large','Let x: A','Returns: A','Means: x','Render latex: {x}'],self.e)
  self.local={'X':Expr('X','X',self.e.type('Bundle'),tree=['Local','X'])}
 def expr(self,s):return Expressions(self.e,self.local).parse(s)
 def test_loaded_declaration_has_metadata(self):
  self.assertEqual(self.e.classifier_info(self.e.type('Type'))[1],0)
 def test_document_classifier_parses_and_loads(self):
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'Classifiers.clean';p.write_text('Type Another():\n  Universe: 2\n  Classifies: 1\n  Means: Type 1\n  Render latex: A\n')
   load_module(p,self.e)
  self.assertEqual(self.e.classifier_info(self.e.type('Another'))[1],1)
 def test_local_carrier_preserves_level_and_identity(self):
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  t=self.e.type('A',self.local)
  self.assertIsInstance(t,LocalType);self.assertEqual(t.universe,1)
  self.assertEqual(t.classifier,self.e.classifier_info(self.e.type('Large'))[0])
  self.assertEqual(self.e.sort_level(t),2)
 def test_generic_native_call_infers_large_carrier(self):
  value=self.expr('hold(X)')
  self.assertEqual(value.type,self.e.type('Bundle'))
  self.assertEqual(dict(value.inferred_args),{'A':self.e.type('Bundle')})
 def test_small_argument_rejects(self):
  self.local['n']=Expr('n','n',self.e.type('Natural'),tree=['Local','n'])
  with self.assertRaisesRegex(CleanError,'Type 1; got Type 0'):self.expr('hold(n)')
 def test_larger_argument_rejects(self):
  self.local['C']=Expr('C','C',self.e.type('Large'),tree=['Local','C'])
  with self.assertRaisesRegex(CleanError,'Type 1; got Type 2'):self.expr('hold(C)')
 def test_alias_resolves_classifier_for_generic_parameter(self):
  type_declaration('Type Alias():',['Equals: Large'],self.e)
  notation('Notation alias hold(x):',['Let A: Alias','Let x: A','Returns: A','Means: x','Render latex: {x}'],self.e)
  self.assertEqual(self.expr('alias hold(X)').type,self.e.type('Bundle'))
 def test_ordinary_bundle_cannot_bind_a_carrier(self):
  with self.assertRaisesRegex(CleanError,'Unknown type: A'):
   notation('Notation bad(x):',['Let A: Bundle','Let x: A','Returns: A','Means: x','Render latex: {x}'],self.e)
 def test_substitution_checks_level(self):
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  t=self.e.type('A',self.local)
  self.assertEqual(substitute(t,{'A':self.e.type('Bundle')},self.e,self.local),self.e.type('Bundle'))
  with self.assertRaisesRegex(CleanError,'Type 1; got Type 0'):
   substitute(t,{'A':self.e.type('Natural')},self.e,self.local)
 def test_comparison_keys_preserve_level_and_identity(self):
  a=LocalType('A',(),'A',1,'classifier1')
  self.assertNotEqual(type_key(a),type_key(LocalType('A',(),'A',0,'classifier1')))
  self.assertNotEqual(type_key(a),type_key(LocalType('A',(),'A',1,'classifier2')))
 def test_local_higher_carrier_call(self):
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  self.local['x']=Expr('x','x',self.e.type('A',self.local),tree=['Local','x'])
  self.assertEqual(self.expr('hold(x)').type,self.local['x'].type)
 def test_repeated_implicit_carrier_requires_agreement(self):
  notation('Notation choose(x,y):',['Let A: Large','Let x,y: A','Returns: A','Means: x','Render latex: {x}'],self.e)
  type_declaration('Type OtherBundle():',['Universe: 1','Means: Type','Render latex: O'],self.e)
  self.local['Y']=Expr('Y','Y',self.e.type('OtherBundle'),tree=['Local','Y'])
  with self.assertRaisesRegex(CleanError,'Inconsistent dependent argument: A'):self.expr('choose(X,Y)')
 def test_expression_substitution_preserves_classifier_identity(self):
  type_declaration('Type OtherClassifier():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: O'],self.e)
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  self.local['B']=Expr('B','B',self.e.type('OtherClassifier'),tree=['Local','B'])
  with self.assertRaisesRegex(CleanError,'changed classifier identity'):
   substitute(self.e.type('A',self.local),{'A':self.local['B']},self.e,self.local)
 def test_reify_higher_local_preserves_its_binder(self):
  from cleanlang.inferred_conversion import reify
  self.local['A']=Expr('boundA','A',self.e.type('Large'),tree=['Local','A'])
  value=reify(self.e.type('A',self.local),self.e,self.local)
  self.assertEqual(value.tree,['Local','A']);self.assertEqual(value.lean,'boundA')
  self.assertEqual(value.type,self.e.type('Large'))
 def test_higher_dependent_type_binder_is_explicitly_pending(self):
  with self.assertRaisesRegex(CleanError,'Type-valued dependent function binders are not implemented'):
   self.e.type('Function(A: Large,A)')
if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
