# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from dataclasses import replace
import json,unittest
import test_retention
from cleanlang.retained_codec import dumps,loads
from cleanlang.core import Expressions,CleanError
from cleanlang.annotations import Annotation
from cleanlang.indices import index_value,dimension_index,substitute_index
from cleanlang.proof_types import index,substitute_proof
from cleanlang.dependent_functions import index_tree

class StoredIndices(unittest.TestCase):
 def setUp(self):
  fixture=test_retention.ExactLiteralPrototype();self.env=fixture.load();self.scope=fixture.scope(self.env)
 def value(self,text):return Expressions(self.env,self.scope).parse(text)
 def without_cache(self,saved):return replace(loads(dumps(saved)),resolved=None)
 def test_literal_from_payload_only_substitutes(self):
  saved=self.without_cache(index_value(self.value('(0: Vector(n,Complex))'),self.env,self.scope))
  self.assertIsInstance(index_tree(saved)[6],Annotation)
  changed=substitute_index(saved,{'n':self.scope['m']},self.env,self.scope)
  self.assertEqual(Expressions(self.env,self.scope).elaborate(index_tree(changed)).lean,self.value('vector zero(m)').lean)
 def test_quantified_proof_without_cache(self):
  saved=index(self.value('for every(k: Natural,(0: Vector(k,Complex))=(0: Vector(k,Complex)))'),self.env,self.scope)
  restored=self.without_cache(saved)
  self.assertIsInstance(index_tree(restored)[2],Annotation)
  self.assertEqual(substitute_proof(restored,{},self.env,self.scope),saved)
 def test_dimension_without_cache(self):
  saved=self.without_cache(dimension_index(self.value('n+1'),self.env,self.scope))
  changed=substitute_index(saved,{'n':self.scope['m']},self.env,self.scope)
  expected=dimension_index(self.value('m+1'),self.env,self.scope)
  self.assertEqual(changed,expected)
 def test_type_value_without_cache(self):
  saved=self.without_cache(index_value(self.value('type(Vector(n,Complex))'),self.env,self.scope))
  self.assertIsInstance(index_tree(saved)[1],Annotation)
  changed=substitute_index(saved,{'n':self.scope['m']},self.env,self.scope)
  self.assertEqual(Expressions(self.env,self.scope).elaborate(index_tree(changed)).lean,self.value('type(Vector(m,Complex))').lean)
 def test_payload_is_authoritative_over_stale_cache(self):
  saved=index_value(self.value('(0: Vector(n,Complex))'),self.env,self.scope)
  stale=replace(saved,resolved=self.value('(0: Vector(m,Complex))').tree)
  self.assertEqual(Expressions(self.env,self.scope).elaborate(index_tree(stale)).lean,self.value('vector zero(n)').lean)
 def test_legacy_or_unknown_payload_rejects(self):
  saved=index_value(self.value('(0: Vector(n,Complex))'),self.env,self.scope)
  old=json.dumps(saved.resolved)
  unknown=json.loads(saved.syntax);unknown['version']=2
  for payload in [old,json.dumps(unknown)]:
   with self.subTest(payload=payload[:35]),self.assertRaisesRegex(CleanError,'envelope or version'):
    index_tree(replace(saved,syntax=payload,resolved=None))

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
