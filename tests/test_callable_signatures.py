# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,CleanError,LocalType
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.structures import declare
from cleanlang.callable_signatures import require

ROOT=Path(__file__).resolve().parents[1]

class CheckedSignatures(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/operators.clean',self.e)
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
 def add(self):
  notation('Notation count types(Small,T):',
   ['Let Small,T: Small','Returns: Natural','Means: 0','Render latex: 0'],self.e)
  return self.e.data['functions']['count types']
 def test_grouped_parameters_retain_pre_group_classifier(self):
  spec=self.add();s=require(self.e,spec)
  classifier=self.e.classifier_info(self.e.type('Small'))
  self.assertEqual([(p.name,p.visibility,p.classifier) for p in s.parameters],
   [('Small','explicit',classifier),('T','explicit',classifier)])
  self.assertEqual(s.parameters[0].typ,s.parameters[1].typ)
 def test_separate_groups_observe_prior_shadow(self):
  notation('Notation carrier value(Small,x):',
   ['Let Small: Small','Let x: Small','Returns: Natural','Means: 0','Render latex: 0'],self.e)
  s=require(self.e,self.e.data['functions']['carrier value'])
  self.assertIsNotNone(s.parameters[0].classifier)
  self.assertIsNone(s.parameters[1].classifier)
  self.assertIsInstance(s.parameters[1].typ,LocalType)
 def test_alias_resolution_is_captured(self):
  type_declaration('Type Nick():',['Equals: Real'],self.e)
  notation('Notation alias value(x: Nick): Nick:', ['Means: x','Render latex: {x}'],self.e)
  spec=self.e.data['functions']['alias value'];s=require(self.e,spec)
  self.assertEqual(s.parameters[0].typ,self.e.type('Real'))
  # A later source-spelling lookup is deliberately made unusable.
  original=self.e.type
  self.e.type=lambda *a,**k: (_ for _ in ()).throw(AssertionError('reparsed'))
  try:self.assertIs(require(self.e,spec),s)
  finally:self.e.type=original
 def test_structure_constructor_has_same_descriptor(self):
  declare('Structure Cell(T: Type):',['Let entry: T','Constructor: cell'],self.e)
  s=require(self.e,self.e.data['functions']['cell'])
  self.assertEqual([p.name for p in s.parameters],['T','entry'])
  self.assertEqual([p.visibility for p in s.parameters],['explicit','explicit'])
  self.assertIsNotNone(s.parameters[0].classifier)
  self.assertIsInstance(s.parameters[1].typ,LocalType)
  self.assertEqual(s.result.name,'Cell')
 def test_changed_source_signature_is_rejected(self):
  spec=self.add();spec['signature_tree'][2][1][2]='Real'
  with self.assertRaisesRegex(CleanError,'Changed checked callable signature'):require(self.e,spec)
 def test_changed_native_binding_is_rejected(self):
  spec=self.add();self.e.notation_definitions[spec['native_binding']]+='\n-- changed'
  with self.assertRaisesRegex(CleanError,'Changed checked callable binding'):require(self.e,spec)
 def test_changed_classifier_is_rejected(self):
  spec=self.add();self.e.data['types']['Small']['classifies']=1
  with self.assertRaisesRegex(CleanError,'Changed checked callable classifier'):require(self.e,spec)
 def test_missing_descriptor_is_not_reconstructed(self):
  spec=self.add();del spec['checked_signature']
  with self.assertRaisesRegex(CleanError,'Missing checked'):require(self.e,spec)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
