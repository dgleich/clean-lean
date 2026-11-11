# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
import json,unittest
from cleanlang.retained_codec import dumps,loads
import test_literal_retention as test_retention
from cleanlang.annotations import Annotation
from cleanlang.core import Type,LocalType,Expr,Expressions,CleanError,ProofType
from cleanlang.indices import index_value,substitute_index
from cleanlang.dependent_functions import index_tree
from cleanlang.proof_types import index,substitute_proof
from cleanlang.binder_keys import ScopedKey

class Codec(unittest.TestCase):
 def setUp(self):
  fixture=test_retention.ExactLiteralPrototype();self.env=fixture.load();self.scope=fixture.scope(self.env)
 def value(self,text):return Expressions(self.env,self.scope).parse(text)
 def roundtrip(self,value):
  encoded=dumps(value);restored=loads(encoded)
  self.assertEqual(dumps(restored),encoded)
  return restored
 def test_independent_annotation_schema(self):
  value=Annotation('T',LocalType('T',(),'native_T'),{'T'})
  self.assertEqual(json.loads(dumps(value)),{'format':'clean-bound-tree','version':4,'value':
   {'tag':'Annotation','source':'T','type':{'tag':'LocalType','fields':{'name':'T','args':{'tag':'Tuple','items':[]},'lean':'native_T','universe':0,'classifier':''}},'names':['T']}})
  self.assertEqual(self.roundtrip(value),value)
 def test_module_and_local_carriers_stay_distinct(self):
  self.assertNotEqual(dumps(Type('Real')),dumps(LocalType('Real',(),'R')))
  self.assertIs(type(loads(dumps(LocalType('Real',(),'R')))),LocalType)
 def test_retained_literal_restores_annotation(self):
  value=self.value('(000: Vector(n,Complex))');tree=self.roundtrip(value.tree)
  self.assertIsInstance(tree[6],Annotation)
  self.assertEqual(tree[2],'000')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(tree).lean,value.lean)
 def test_computed_index_survives_substitution(self):
  saved=index_value(self.value('(0: Vector(n,Complex))'),self.env,self.scope)
  restored=self.roundtrip(saved)
  changed=substitute_index(restored,{'n':self.scope['m']},self.env,self.scope)
  self.assertEqual(Expressions(self.env,self.scope).elaborate(index_tree(changed)).lean,self.value('vector zero(m)').lean)
 def test_proof_index_and_captured_scope(self):
  value=self.value('(0: Vector(n,Complex))=(0: Vector(n,Complex))')
  restored=self.roundtrip(index(value,self.env,self.scope))
  self.assertIsInstance(dict(restored.scope)['n'],Expr)
  changed=substitute_proof(restored,{'n':self.scope['m']},self.env,self.scope)
  expected=index(self.value('(0: Vector(m,Complex))=(0: Vector(m,Complex))'),self.env,self.scope)
  self.assertEqual(changed,expected)
  self.assertEqual(self.roundtrip(ProofType(restored)),ProofType(restored))
 def test_quantified_proof_retains_binder_annotation(self):
  original=index(self.value('for every(k: Natural,(0: Vector(k,Complex))=(0: Vector(k,Complex)))'),self.env,self.scope)
  restored=self.roundtrip(original)
  self.assertEqual(restored,original)
  self.assertIsInstance(index_tree(restored)[2],Annotation)
  self.assertEqual(substitute_proof(restored,{},self.env,self.scope),original)
 def test_dependent_function_and_scoped_key(self):
  typ=self.env.type('Function(k: Natural,Vector(k,Complex))')
  self.assertIs(type(self.roundtrip(typ)),type(typ))
  self.assertEqual(self.roundtrip(typ),typ)
  key=ScopedKey(('(',('owned',0),('free','x'),')'))
  self.assertEqual(self.roundtrip(key),key)
 def test_later_competitor_does_not_reselect_restored_literal(self):
  from cleanlang.modules import notation
  value=self.value('(0: Vector(n,Complex))');encoded=dumps(value.tree)
  notation('Notation other zero(n: Natural): Vector(n,Complex):',['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.env)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):self.value('(0: Vector(n,Complex))')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(loads(encoded)).lean,value.lean)
 def test_replay_checks_changed_constructor(self):
  encoded=dumps(self.value('(0: Vector(n,Complex))').tree)
  self.env.data['functions']['vector zero']['lean']='different target'
  with self.assertRaisesRegex(CleanError,'Changed retained literal'):
   Expressions(self.env,self.scope).elaborate(loads(encoded))
 def test_containers_are_not_conflated(self):
  value=[('x',1,True,None),['x',1]]
  self.assertEqual(self.roundtrip(value),value)
  self.assertIs(type(loads(dumps(value))[0]),tuple)
 def test_invalid_envelopes_and_tags_reject(self):
  for source in ['[]','{"format":"clean-bound-tree","version":true,"value":null}',
   '{"format":"clean-bound-tree","version":2,"value":null}',
   '{"format":"clean-bound-tree","version":4,"value":{"tag":"Unknown"}}',
   '{"format":"clean-bound-tree","version":4,"value":NaN}',
   '{"format":"clean-bound-tree","version":4,"version":4,"value":null}']:
   with self.subTest(source=source),self.assertRaises(CleanError):loads(source)
 def test_unknown_fields_and_lossy_annotation_reject(self):
  doc=json.loads(dumps(Annotation('Real',Type('Real'))));doc['value']['extra']=0
  with self.assertRaises(CleanError):loads(json.dumps(doc))
  del doc['value']['extra'];doc['value']['type']='Real'
  with self.assertRaises(CleanError):loads(json.dumps(doc))
 def test_unsupported_and_cyclic_values_reject(self):
  cycle=[];cycle.append(cycle)
  for value in [object(),1.5,cycle]:
   with self.subTest(kind=type(value).__name__),self.assertRaises(CleanError):dumps(value)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
