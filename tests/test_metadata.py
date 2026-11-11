# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Declaration validation only; these tests do not exercise carrier inference."""
import unittest
from cleanlang.core import Environment,CleanError
from cleanlang.modules import type_declaration,classifier_metadata

class ClassifierMetadata(unittest.TestCase):
 def setUp(self):self.env=Environment()
 def declare(self,name='Carriers',level=1,body=None,extra=()):
  fields=[f'Universe: {level+1}',f'Classifies: {level}',
   'Means: '+(body if body is not None else f'Type {level}'),'Render latex: C',*extra]
  type_declaration(f'Type {name}():',fields,self.env)
  return classifier_metadata(self.env,name)
 def reject(self,fields,pattern,header='Type Invalid():'):
  before=dict(self.env.data['types']);native=dict(self.env.notation_definitions)
  with self.assertRaisesRegex(CleanError,pattern):type_declaration(header,fields,self.env)
  self.assertEqual(self.env.data['types'],before)
  self.assertEqual(self.env.notation_definitions,native)
 def test_closed_levels_and_arbitrary_names(self):
  for k in (0,1,2,5):
   name='Carriers'+str(k);key,level=self.declare(name,k)
   self.assertEqual(level,k)
   self.assertEqual(key,self.env.data['types'][name]['native_binding'])
   self.assertEqual(self.env.data['types'][name]['universe'],k+1)
 def test_zero_abbreviation_and_whitespace(self):
  self.assertEqual(self.declare('Small',0,'Type')[1],0)
  self.assertEqual(self.declare('Large',1,'Type   1')[1],1)
 def test_alias_chain_preserves_identity(self):
  original=self.declare()
  type_declaration('Type Alias():',['Equals: Carriers'],self.env)
  type_declaration('Type Again():',['Equals: Alias'],self.env)
  self.assertEqual(classifier_metadata(self.env,'Again'),original)
 def test_distinct_declarations_remain_distinct(self):
  self.assertNotEqual(self.declare('First'),self.declare('Second'))
 def test_ordinary_universe_is_not_classifier(self):
  for name in ('Bundle','Type'):
   type_declaration('Type '+name+'():',['Universe: 1','Means: Type','Render latex: T'],self.env)
   self.assertIsNone(classifier_metadata(self.env,name))
 def test_classifies_requires_explicit_successor_universe(self):
  for universe in ([],['Universe: 1'],['Universe: 3']):
   self.reject([*universe,'Classifies: 1','Means: Type 1','Render latex: C'],'explicit Universe')
 def test_noncanonical_levels_reject(self):
  for k in ('01','-1','+1','1.0','u'):
   self.reject(['Universe: 2','Classifies: '+k,'Means: Type 1','Render latex: C'],'nonnegative decimal')
 def test_primitive_correspondence_only(self):
  for body in ('Type','Type 0','Type 2','Type 01','Sort 2','(Type 1)','Other'):
   self.reject(['Universe: 2','Classifies: 1','Means: '+body,'Render latex: C'],'primitive Type')
 def test_parameters_reject(self):
  self.reject(['Universe: 2','Classifies: 1','Means: Type 1','Render latex: C'],
   'zero-parameter',header='Type Invalid(A: Type):')
 def test_numerals_reject(self):
  self.reject(['Universe: 2','Classifies: 1','Means: Type 1','Render latex: C','Numerals: fun n => n'],'cannot have Numerals')
 def test_alias_cannot_redeclare_classification(self):
  self.declare()
  self.reject(['Equals: Carriers','Classifies: 1'],'Type alias accepts')
 def test_duplicate_field_rejects(self):
  self.reject(['Universe: 2','Classifies: 1','Classifies: 1','Means: Type 1','Render latex: C'],'Duplicate')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
