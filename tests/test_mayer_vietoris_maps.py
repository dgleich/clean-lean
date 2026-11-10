# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

class MayerVietorisMaps(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.env=Environment();load_module(ROOT/'library/topology/mayer_vietoris_maps.clean',cls.env)
 def setUp(self):
  self.scope={}
  for name,typ in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),('X','TopologicalSpace'),('U','Set(Point(X))'),('V','Set(Point(X))')]:
   self.scope[name]=Expr(name,name,self.env.type(typ,self.scope),tree=['Local',name])
 def expr(self,s):return Expressions(self.env,self.scope).parse(s)
 def test_maps_are_authored(self):
  for name in ['subset homology','inclusion homology','intersection homology map','union homology map']:
   with self.subTest(name=name):self.assertEqual(self.env.definitions[name]['implementation'],'equals')
 def test_intersection_tree_includes_signed_pair_and_evidence(self):
  loc=lambda n:['Local',n]
  inter=['Operator','∩',loc('U'),loc('V')]
  prefix=[loc('field'),loc('H'),loc('X'),inter]
  left=['Call','inclusion homology',prefix+[loc('U'),['Call','intersection into left',[loc('U'),loc('V')]]]]
  right=['Call','inclusion homology',prefix+[loc('V'),['Call','intersection into right',[loc('U'),loc('V')]]]]
  self.assertEqual(self.env.definitions['intersection homology map']['tree'],['Call','signed pair',[left,right]])
 def test_intersection_domain_and_sum_codomain(self):
  self.assertEqual(self.expr('intersection homology map(field,H,X,U,V)').type,self.env.type(
   'ModuleMap(K,field,(subset homology(field,H,X,(U ∩ V))),(module product(field,subset homology(field,H,X,U),subset homology(field,H,X,V))))',self.scope))
 def test_union_domain_and_union_codomain(self):
  self.assertEqual(self.expr('union homology map(field,H,X,U,V)').type,self.env.type(
   'ModuleMap(K,field,(module product(field,subset homology(field,H,X,U),subset homology(field,H,X,V))),(subset homology(field,H,X,(U ∪ V))))',self.scope))
 def test_wrong_inclusion_evidence_rejects(self):
  with self.assertRaises(CleanError):self.expr('inclusion homology(field,H,X,U ∩ V,U,left into union(U,V))')
 def test_reversed_composition_rejects(self):
  with self.assertRaises(CleanError):self.expr('module composition(field,subset homology(field,H,X,U ∩ V),module product(field,subset homology(field,H,X,U),subset homology(field,H,X,V)),subset homology(field,H,X,U ∪ V),union homology map(field,H,X,U,V),intersection homology map(field,H,X,U,V))')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
