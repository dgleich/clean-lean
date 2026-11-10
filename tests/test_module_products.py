# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

class ModuleProducts(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.env=Environment();load_module(ROOT/'library/algebra/module_products.clean',cls.env)
 def setUp(self):
  self.scope={}
  for name,typ in [('K','Type'),('field','FieldStructure(K)'),('L','CoefficientModule(K,field)'),('P','CoefficientModule(K,field)'),('M','CoefficientModule(K,field)'),('N','CoefficientModule(K,field)'),('n','Natural'),('f','ModuleMap(K,field,L,M)'),('g','ModuleMap(K,field,L,N)'),('h','ModuleMap(K,field,M,P)'),('k','ModuleMap(K,field,N,P)')]:
   self.scope[name]=Expr(name,name,self.env.type(typ,self.scope),tree=['Local',name])
 def expr(self,s):return Expressions(self.env,self.scope).parse(s)
 def test_product_call_tree(self):
  self.assertEqual(self.expr('module product(field,M,N)').tree,['Call','module product',[['Local','field'],['Local','M'],['Local','N']]])
 def test_product_is_a_module(self):
  self.assertEqual(self.expr('module product(field,M,N)').type,self.env.type('CoefficientModule(K,field)',self.scope))
 def test_inclusion_and_projection_endpoints(self):
  for text,typ in [('left inclusion(field,M,N)','ModuleMap(K,field,M,(module product(field,M,N)))'),('right projection(field,M,N)','ModuleMap(K,field,(module product(field,M,N)),N)')]:
   with self.subTest(text=text):self.assertEqual(self.expr(text).type,self.env.type(typ,self.scope))
 def test_exact_pair_and_onto(self):
  for text in ['exact(left inclusion(field,M,N),right projection(field,M,N))','onto(right projection(field,M,N))']:
   with self.subTest(text=text):self.assertEqual(self.expr(text).type,Type('Proposition'))
 def test_wrong_middle_module_rejects(self):
  with self.assertRaises(CleanError):self.expr('exact(left inclusion(field,M,N),right projection(field,N,M))')
 def test_signed_pair_is_authored(self):
  definition=self.env.definitions['signed pair']
  self.assertEqual(definition['implementation'],'equals')
  self.assertEqual(definition['tree'],['Call','pair module maps',[
   ['Local','field'],['Local','L'],['Local','M'],['Local','N'],['Local','f'],
   ['Call','negative module map',[['Local','field'],['Local','L'],['Local','N'],['Local','g']]]]])
 def test_signed_pair_type_and_tree(self):
  result=self.expr('signed pair(f,g)')
  self.assertEqual(result.tree,['Call','signed pair',[['Local','f'],['Local','g']]])
  self.assertEqual(result.type,self.env.type('ModuleMap(K,field,L,(module product(field,M,N)))',self.scope))
 def test_merge_codomain_and_composition(self):
  self.assertEqual(self.expr('merge module maps(field,M,N,P,h,k)').type,
   self.env.type('ModuleMap(K,field,(module product(field,M,N)),P)',self.scope))
  self.assertEqual(self.expr('module composition(field,L,module product(field,M,N),P,signed pair(f,g),merge module maps(field,M,N,P,h,k))').type,
   self.env.type('ModuleMap(K,field,L,P)',self.scope))
 def test_pair_requires_common_domain(self):
  with self.assertRaises(CleanError):self.expr('signed pair(f,h)')
 def test_merge_requires_common_codomain(self):
  with self.assertRaises(CleanError):self.expr('merge module maps(field,L,M,N,f,h)')
 def test_nonmodule_argument_rejects(self):
  with self.assertRaises(CleanError):self.expr('module product(field,M,n)')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
