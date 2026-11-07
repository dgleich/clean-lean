# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Type,ValueIndex
from cleanlang.binder_keys import Pool,environment_tokens
class ComparisonTokenCache(unittest.TestCase):
 def test_warm_scan_reuses_only_token_result(self):
  e=Environment();e.notation_definitions['key']='opaque clean_comparison_identity_0'
  first=environment_tokens(e)
  with patch('cleanlang.binder_keys.re.findall',side_effect=AssertionError('rescan')):
   self.assertIs(environment_tokens(e),first)
  self.assertIn('key',first)
  self.assertIn('clean_comparison_identity_0',first)
 def test_nested_mutation_invalidates(self):
  e=Environment();e.data['functions']['f']={'signature_tree':['old',['nested']]}
  self.assertIn('old',environment_tokens(e))
  e.data['functions']['f']['signature_tree'][1][0]='new'
  self.assertIn('new',environment_tokens(e));self.assertNotIn('nested',environment_tokens(e))
 def test_declaration_replace_and_delete(self):
  e=Environment();e.notation_definitions['key']='old'
  old=environment_tokens(e)
  e.notation_definitions['key']='new'
  self.assertNotIn('old',environment_tokens(e));self.assertIn('new',environment_tokens(e))
  del e.notation_definitions['key']
  self.assertNotIn('key',environment_tokens(e))
  self.assertIn('old',old)
 def test_environment_keys_are_reserved(self):
  e=Environment();e.data['types']['clean_comparison_identity_0']={}
  self.assertEqual(Pool(e,{},[]).fresh({}),'clean_comparison_identity_1')
 def test_tree_is_rescanned_on_warm_environment(self):
  e=Environment();environment_tokens(e)
  tree=['Local','clean_comparison_identity_0']
  self.assertEqual(Pool(e,{},tree).fresh({}),'clean_comparison_identity_1')
  tree[1]='clean_comparison_identity_1'
  self.assertEqual(Pool(e,{},tree).fresh({}),'clean_comparison_identity_0')
 def test_mutated_locals_and_type_indices_are_rescanned(self):
  e=Environment();x=Expr('clean_comparison_identity_0','x',Type('Natural'))
  pool=Pool(e,{'x':x},[])
  x.lean='clean_comparison_identity_1'
  x.type=Type('Carrier',(ValueIndex('i','clean_comparison_identity_2','i'),))
  self.assertEqual(pool.fresh({'x':x}),'clean_comparison_identity_3')
  fresh=Pool(e,{'x':x},[])
  self.assertEqual(fresh.fresh({'x':x}),'clean_comparison_identity_0')
 def test_order_changes_preserve_union_and_fresh_names(self):
  e=Environment();e.notation_definitions={'a':'clean_comparison_identity_0','b':'clean_comparison_identity_2'}
  first=environment_tokens(e);one=Pool(e,{},[]).fresh({})
  e.notation_definitions=dict(reversed(list(e.notation_definitions.items())))
  self.assertEqual(environment_tokens(e),first)
  self.assertEqual(Pool(e,{},[]).fresh({}),one)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
