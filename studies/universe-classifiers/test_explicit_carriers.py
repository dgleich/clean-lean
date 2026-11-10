# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,type_declaration,notation
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[2]
class ExplicitCarriers(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/types.clean',self.e)
  for name,k in [('Small',0),('Large',1),('Higher',2),('AnotherLarge',1)]:
   type_declaration('Type '+name+'():',[f'Universe: {k+1}',f'Classifies: {k}',f'Means: Type {k}','Render latex: C'],self.e)
   notation('Define keep '+name+'(A,x):',['Let A: '+name,'Let x: A','Returns: A','Equals: x'],self.e,authored=True)
 def scope(self,classifier):
  scope={'A':Expr('A','A',self.e.type(classifier),tree=['Local','A'])}
  scope['x']=Expr('x','x',self.e.type('A',scope),tree=['Local','x']);return scope
 def call(self,text,scope):return Expressions(self.e,scope).parse(text)
 def test_explicit_zero_uses_arbitrary_classifier_name(self):
  scope=self.scope('Small');value=self.call('keep Small(A,x)',scope)
  self.assertEqual(value.type,scope['x'].type)
  self.assertIn('dependent_signature',self.e.data['functions']['keep Small'])
 def test_explicit_higher_levels(self):
  for name,k in [('Large',1),('Higher',2)]:
   scope=self.scope(name);value=self.call('keep '+name+'(A,x)',scope)
   self.assertEqual(value.type,scope['x'].type);self.assertEqual(value.type.universe,k)
 def test_normalization_uses_supplied_carrier(self):
  scope=self.scope('Large');value=self.call('keep Large(A,x)',scope)
  self.assertEqual(comparison_normal_form(value,self.e,scope).tree,['Local','x'])
 def test_explicit_alias_has_same_parameter_identity(self):
  type_declaration('Type Alias():',['Equals: Large'],self.e)
  notation('Define alias keep(A,x):',['Let A: Alias','Let x: A','Returns: A','Equals: x'],self.e,authored=True)
  scope=self.scope('Large');self.assertEqual(self.call('alias keep(A,x)',scope).type,scope['x'].type)
 def test_wrong_level_classifier_rejects(self):
  scope=self.scope('Small')
  with self.assertRaises(CleanError):self.call('keep Large(A,x)',scope)
 def test_equal_level_distinct_classifier_rejects(self):
  scope=self.scope('AnotherLarge')
  with self.assertRaises(CleanError):self.call('keep Large(A,x)',scope)
 def test_value_must_have_supplied_carrier(self):
  scope=self.scope('Large');scope['B']=Expr('B','B',self.e.type('Large'),tree=['Local','B'])
  scope['y']=Expr('y','y',self.e.type('B',scope),tree=['Local','y'])
  with self.assertRaisesRegex(CleanError,'Dependent type mismatch'):self.call('keep Large(A,y)',scope)
 def test_explicit_then_implicit_carrier(self):
  notation('Define combine(A,x,y):',['Let B: Large','Let A: Small','Let x: A','Let y: B','Returns: B','Equals: y'],self.e,authored=True)
  scope=self.scope('Small');scope['B']=Expr('B','B',self.e.type('Large'),tree=['Local','B'])
  scope['y']=Expr('y','y',self.e.type('B',scope),tree=['Local','y'])
  value=self.call('combine(A,x,y)',scope)
  self.assertEqual(dict(value.inferred_args),{'B':scope['y'].type})
  self.assertEqual(value.type,scope['y'].type)
 def test_grouped_explicit_carriers(self):
  notation('Define second(A,B,x,y):',['Let A,B: Large','Let x: A','Let y: B','Returns: B','Equals: y'],self.e,authored=True)
  scope=self.scope('Large');scope['B']=Expr('B','B',self.e.type('Large'),tree=['Local','B'])
  scope['y']=Expr('y','y',self.e.type('B',scope),tree=['Local','y'])
  self.assertEqual(self.call('second(A,B,x,y)',scope).type,scope['y'].type)
 def test_declared_type_foundation_is_required(self):
  with self.assertRaisesRegex(CleanError,'Unknown type: Type'):
   notation('Define identity(A,x):',['Let A: Type','Let x: A','Returns: A','Equals: x'],Environment(),authored=True)
 def test_compact_signature_is_equivalent(self):
  notation('Define compact keep(A: Large,x: A): A:',['Equals: x'],self.e,authored=True)
  scope=self.scope('Large');self.assertEqual(self.call('compact keep(A,x)',scope).type,scope['x'].type)
if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
