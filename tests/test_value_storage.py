# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import json,unittest
from dataclasses import replace
from cleanlang.retained_codec import dumps,loads
from cleanlang.core import LocalType,Expr,Expressions,CleanError
from cleanlang.annotations import Annotation
from cleanlang.indices import index_value,substitute_index
from cleanlang.dependent_functions import index_tree
import test_classified_values

class ValueStorage(unittest.TestCase):
 def setUp(self):
  self.fixture=test_classified_values.ClassifiedValues();self.fixture.setUp()
  self.e=self.fixture.e;self.scope=self.fixture.local
 def expr(self,text):return self.fixture.expr(text)
 def test_independent_local_type_schema(self):
  value=LocalType('A',(),'A',universe=1,classifier='native_large')
  expected={'format':'clean-bound-tree','version':3,'value':{'tag':'LocalType','fields':
   {'name':'A','args':{'tag':'Tuple','items':[]},'lean':'A','universe':1,'classifier':'native_large'}}}
  self.assertEqual(json.loads(dumps(value)),expected)
  restored=loads(json.dumps(expected))
  self.assertEqual(restored.universe,1);self.assertEqual(restored.classifier,'native_large')
 def test_reject_old_and_malformed_schema(self):
  doc=json.loads(dumps(LocalType('A',(),'A',universe=1,classifier='native_large')))
  old=dict(doc,version=1)
  with self.assertRaises(CleanError):loads(json.dumps(old))
  for field,value in [('universe',True),('universe',-1),('classifier',None),('lean',4)]:
   bad=json.loads(json.dumps(doc));bad['value']['fields'][field]=value
   with self.subTest(field=field,value=value),self.assertRaises(CleanError):loads(json.dumps(bad))
 def test_type_value_payload_preserves_identity(self):
  value=self.expr('type(TopologicalSpace : Large)')
  encoded=dumps(value.tree);tree=loads(encoded)
  self.assertIsInstance(tree[1],Annotation);self.assertIsInstance(tree[2],Annotation)
  self.assertIsInstance(tree[3],tuple);self.assertEqual(dumps(tree),encoded)
  self.fixture.classifier('Another',1)
  actual=Expressions(self.e,self.scope).elaborate(tree)
  self.assertEqual(actual.type,value.type);self.assertEqual(actual.lean,value.lean)
 def test_payload_only_index_replay_and_substitution(self):
  self.scope['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  value=index_value(self.expr('type(A : Large)'),self.e,self.scope)
  restored=replace(loads(dumps(value)),resolved=None)
  self.assertIsInstance(index_tree(restored)[1],Annotation)
  changed=substitute_index(restored,{'A':self.e.type('TopologicalSpace')},self.e,{})
  tree=index_tree(replace(changed,resolved=None))
  self.assertEqual(Expressions(self.e,{}).elaborate(tree).lean,self.expr('type(TopologicalSpace : Large)').lean)
 def test_cache_cannot_override_payload(self):
  value=index_value(self.expr('type(TopologicalSpace : Large)'),self.e,self.scope)
  value=replace(value,resolved=['Decimal','987'])
  self.assertEqual(index_tree(value)[0],'BoundTypeValue')
 def test_replay_rejects_changed_classifier(self):
  tree=loads(dumps(self.expr('type(TopologicalSpace : Large)').tree))
  self.e.data['types']['Large']['universe']=3
  with self.assertRaises(CleanError):Expressions(self.e,self.scope).elaborate(tree)
 def test_replay_rejects_missing_local(self):
  self.scope['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  tree=loads(dumps(self.expr('type(A : Large)').tree))
  with self.assertRaisesRegex(CleanError,'Unbound carrier references'):
   Expressions(self.e,{}).elaborate(tree)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
