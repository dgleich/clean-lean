# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,type_declaration
from cleanlang.structures import declare
from cleanlang.syntax import structure_header
ROOT=Path(__file__).resolve().parents[1]

class ClassifiedParameters(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/topology/spaces.clean',self.e)
  type_declaration('Type Large():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: L'],self.e)
  declare('Structure Package(A: Large):',['Universe: 1','Let point: A','Constructor: package'],self.e)
 def test_type_spelling_without_classifier_does_not_bind_carrier(self):
  e=Environment()
  type_declaration('Type Type():',['Universe: 1','Means: Type','Render latex: T'],e)
  with self.assertRaisesRegex(CleanError,'Unknown type: A'):
   declare('Structure Bad(A: Type):',['Let point: A','Constructor: bad'],e)
 def test_independent_header_tree(self):
  self.assertEqual(structure_header('Structure Package(A: Large):'),['StructureHeader','Package',[['A','Large']]])
 def test_higher_parameter_and_constructor_projection(self):
  e=self.e;t=e.type('Package(TopologicalSpace)')
  self.assertEqual(t.args,(e.type('TopologicalSpace'),))
  scope={'X':Expr('X','X',e.type('TopologicalSpace'),tree=['Local','X'])}
  v=Expressions(e,scope).parse('package(type(TopologicalSpace : Large),X).point')
  self.assertEqual(v.type,e.type('TopologicalSpace'));self.assertEqual(v.lean,'X')
 def test_higher_arrow_parameter_keeps_declared_level(self):
  type_declaration('Type HighArrow(A: Large,B: Large):',
    ['Universe: 1','Means: (A) → (B)','Render latex: {A} to {B}'],self.e)
  with self.assertRaisesRegex(CleanError,'requires Lean Type 1'):
   self.e.type('HighArrow(Real,Real)')
  self.assertEqual(len(self.e.type('HighArrow(TopologicalSpace,TopologicalSpace)').args),2)
 def test_classifier_alias_fixes_the_same_parameter_level(self):
  type_declaration('Type ClassifierAlias():',['Equals: Large'],self.e)
  declare('Structure AliasPackage(A: ClassifierAlias):',
    ['Universe: 1','Let point: A','Constructor: alias package'],self.e)
  self.assertEqual(self.e.type('AliasPackage(TopologicalSpace)').args,
                   (self.e.type('TopologicalSpace'),))
  with self.assertRaises(CleanError):self.e.type('AliasPackage(Real)')
 def test_wrong_level_rejected(self):
  with self.assertRaisesRegex(CleanError,'requires Lean Type 1'):self.e.type('Package(Real)')
 def test_closed_constructor_and_alias(self):
  type_declaration('Type Container(A: Large):',['Universe: 1','Means: A','Render latex: C({A})'],self.e)
  type_declaration('Type Alias(A: Large):',['Equals: Container(A)'],self.e)
  self.assertEqual(self.e.type('Alias(TopologicalSpace)'),self.e.type('Container(TopologicalSpace)'))
  with self.assertRaises(CleanError):self.e.type('Alias(Real)')
 def test_renamed_small_classifier(self):
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
  declare('Structure Tiny(A: Small):',['Let point: A','Constructor: tiny'],self.e)
  self.assertEqual(self.e.type('Tiny(Real)').args,(self.e.type('Real'),))
 def test_competing_classifier_does_not_select_parameter(self):
  type_declaration('Type Other():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: O'],self.e)
  self.assertEqual(self.e.type('Package(TopologicalSpace)').args,(self.e.type('TopologicalSpace'),))
  with self.assertRaisesRegex(CleanError,'Ambiguous carrier classifier'):
   Expressions(self.e,{}).parse('type(TopologicalSpace)')
 def test_insufficient_record_universe_rejected(self):
  with self.assertRaisesRegex(CleanError,'exceeds declared Universe'):
   declare('Structure TooSmall(A: Large):',['Let point: A','Constructor: too small'],self.e)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
