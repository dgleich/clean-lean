# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import json,unittest
from dataclasses import replace
import test_classified_values
from cleanlang.core import Expr,Type,ComputedCarrier,Expressions,CleanError
from cleanlang.structures import declare
from cleanlang.modules import notation
from cleanlang.dependent_functions import substitute,type_key
from cleanlang.retained_codec import dumps,loads
from cleanlang.annotations import Annotation,validate

class ComputedCarriers(unittest.TestCase):
 def setUp(self):
  f=test_classified_values.ClassifiedValues();f.setUp();self.e=f.e;self.scope=f.local
  declare('Structure SpacePackage():',['Universe: 2','Let carrier: Large','Let point: carrier','Constructor: pack space'],self.e)
  self.scope['P']=Expr('P','P',self.e.type('SpacePackage'),tree=['Local','P'])
  self.scope['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
 def expr(self,s):return Expressions(self.e,self.scope).parse(s)
 def test_projected_level_and_identity(self):
  t=self.expr('P.point').type
  self.assertIsInstance(t,ComputedCarrier);self.assertEqual(self.e.sort_level(t),2)
  self.assertEqual(t.classifier,self.e.classifier_info(self.e.type('Large'))[0])
  self.assertEqual(str(t),'P.carrier')
 def test_constructor_projection(self):
  v=self.expr('pack space(type(TopologicalSpace : Large),X).point')
  self.assertEqual(v.type,self.scope['X'].type);self.assertEqual(v.lean,'X')
 def test_projected_type_expression(self):
  v=self.expr('type(P.carrier : Large)')
  self.assertEqual(v.type,self.e.type('Large'))
  self.assertIn('.«carrier»',v.lean)
 def test_inferred_generic_argument(self):
  notation('Define keep(x):',['Let A: Large','Let x: A','Returns: A','Equals: x'],self.e,authored=True)
  self.assertEqual(self.expr('keep(P.point)').type,self.expr('P.point').type)
 def test_substitution_preserves_metadata(self):
  self.scope['Q']=Expr('Q','Q',self.e.type('SpacePackage'),tree=['Local','Q'])
  t=substitute(self.expr('P.point').type,{'P':self.scope['Q']},self.e,self.scope)
  self.assertEqual(t,self.expr('Q.point').type);self.assertEqual(t.universe,1)
 def test_substitution_can_reduce_constructor(self):
  actual=self.expr('pack space(type(TopologicalSpace : Large),X)')
  t=substitute(self.expr('P.point').type,{'P':actual},self.e,self.scope)
  self.assertEqual(t,self.e.type('TopologicalSpace'))
 def test_type_key_preserves_level_and_classifier(self):
  t=self.expr('P.point').type
  self.assertNotEqual(type_key(t),type_key(replace(t,universe=0)))
  self.assertNotEqual(type_key(t),type_key(replace(t,classifier='other')))
 def test_schema_and_replay(self):
  t=self.expr('P.point').type;doc=json.loads(dumps(t))
  self.assertEqual(doc['version'],3);self.assertEqual(doc['value']['tag'],'ComputedCarrier')
  self.assertEqual(set(doc['value']['fields']),{'name','args','universe','classifier'})
  restored=loads(json.dumps(doc));validate(restored,self.e,self.scope)
  self.assertEqual(restored,t)
  with self.assertRaises(CleanError):validate(replace(restored,universe=0),self.e,self.scope)
 def test_changed_stored_native_target_rejects(self):
  t=self.expr('P.point').type
  index=replace(t.args[0],lean='Nat')
  with self.assertRaisesRegex(CleanError,'Stale computed carrier native target'):
   validate(replace(t,args=(index,)),self.e,self.scope)
 def test_missing_scope_rejects(self):
  t=loads(dumps(self.expr('P.point').type))
  with self.assertRaises(CleanError):validate(t,self.e,{})
 def test_plain_internal_type_rejected(self):
  t=self.expr('P.point').type;legacy=Type('$carrier',t.args)
  for action in [lambda:self.e.sort_level(legacy),lambda:self.e.render_type(legacy,'lean'),lambda:validate(legacy,self.e,self.scope)]:
   with self.assertRaises(CleanError):action()
 def test_small_carrier_projection(self):
  declare('Structure SmallPackage():',['Universe: 1','Let carrier: Type','Let point: carrier','Constructor: pack small'],self.e)
  self.scope['S']=Expr('S','S',self.e.type('SmallPackage'),tree=['Local','S'])
  t=self.expr('S.point').type
  self.assertIsInstance(t,ComputedCarrier);self.assertEqual(t.universe,0)
  self.assertEqual(self.e.sort_level(t),1)
 def test_older_payload_version_rejected(self):
  doc=json.loads(dumps(self.expr('P.point').type))
  for version in (1,2):
   doc['version']=version
   with self.assertRaises(CleanError):loads(json.dumps(doc))
 def test_wrong_record_universe_rejected(self):
  with self.assertRaises(CleanError):declare('Structure TooSmall():',['Universe: 1','Let carrier: Large','Let point: carrier','Constructor: too small'],self.e)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
