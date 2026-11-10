# generated: gpt-6 2026-11-10 role=assisted; syntax-only prototype
import unittest
from cleanlang.syntax import parse,expression_tree
from cleanlang.core import CleanError

class ClassifierSyntax(unittest.TestCase):
 def test_explicit_classifier_tree(self):
  self.assertEqual(expression_tree(parse('type(TopologicalSpace : LargeTypes)','expression')),
   ['ClassifiedTypeValue','TopologicalSpace','LargeTypes'])
 def test_nested_type_arguments_have_their_own_commas(self):
  self.assertEqual(expression_tree(parse('type(ModuleMap(K,field,M,N) : SmallTypes)','expression')),
   ['ClassifiedTypeValue','ModuleMap(K,field,M,N)','SmallTypes'])
 def test_old_form_tree_unchanged(self):
  self.assertEqual(expression_tree(parse('type(Real)','expression')),['TypeValue','Real'])
 def test_case_and_space(self):
  self.assertEqual(expression_tree(parse('TyPe(  TopologicalSpace:LargeTypes )','expression')),
   ['ClassifiedTypeValue','TopologicalSpace','LargeTypes'])
 def test_classifies_is_a_metadata_field(self):
  tree=parse('cLaSsIfIeS: 1','field')
  self.assertEqual(str(tree.children[0]).lower(),'classifies')
  self.assertEqual(str(tree.children[1]).strip(),'1')
 def test_malformed_forms_reject(self):
  for source in ['type(T:C:D)','type(T:)','type(:C)','type(T,C)','type(T:C,)']:
   with self.subTest(source=source),self.assertRaises(CleanError):parse(source,'expression')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
