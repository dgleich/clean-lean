# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

class ExactSequences(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.env=Environment();load_module(ROOT/'library/algebra/exact_sequences.clean',cls.env)
 def setUp(self):
  self.scope={}
  for name,typ in [('K','Type'),('field','FieldStructure(K)'),('M','CoefficientModule(K,field)'),('N','CoefficientModule(K,field)'),('P','CoefficientModule(K,field)'),('S','ModuleSequence(K,field)'),('n','Natural'),('f','ModuleMap(K,field,M,N)'),('g','ModuleMap(K,field,N,P)')]:
   self.scope[name]=Expr(name,name,self.env.type(typ,self.scope),tree=['Local',name])
 def expr(self,text):return Expressions(self.env,self.scope).parse(text)
 def test_independent_structure_tree(self):
  self.assertEqual(self.env.structures['ModuleSequence']['tree'],['Structure','ModuleSequence',
   [['K','Type'],['field','FieldStructure(K)']],
   [['object','Function(Natural,CoefficientModule(K,field))'],
    ['arrow','Function(n: Natural,ModuleMap(K,field,((object)((n + 1))),((object)(n))))']],
   'module sequence'])
 def test_exactness_definitions_are_authored(self):
  for name in ['exact pair','exact','exact pair at','exact sequence interior','onto','exact sequence ending in zero']:
   with self.subTest(name=name):self.assertEqual(self.env.definitions[name]['implementation'],'equals')
 def test_arrow_direction_and_middle_object(self):
  arrow=self.expr('S.arrow(n)')
  self.assertEqual(arrow.type,self.env.type('ModuleMap(K,field,(S.object(n+1)),(S.object(n)))',self.scope))
  self.assertNotEqual(arrow.type,self.env.type('ModuleMap(K,field,(S.object(n)),(S.object(n+1)))',self.scope))
 def test_conditions_and_local_position(self):
  for text in ['exact pair(field,M,N,P,f,g)','exact(f,g)','exact pair at(field,S,n)','exact sequence interior(field,S)']:
   with self.subTest(text=text):self.assertEqual(self.expr(text).type,Type('Proposition'))
 def test_endpoint_conditions(self):
  for text in ['onto(f)','exact sequence ending in zero(field,S)']:
   with self.subTest(text=text):self.assertEqual(self.expr(text).type,Type('Proposition'))
  with self.assertRaises(CleanError):self.expr('onto(n)')
 def test_terminal_tree_requires_both_clauses(self):
  tree=self.env.definitions['exact sequence ending in zero']['tree']
  self.assertEqual(tree[:2],['Operator','∧'])
  self.assertEqual(tree[2],['Call','exact sequence interior',[['Local','field'],['Local','S']]])
  self.assertEqual(tree[3][:2],['Call','onto'])
  application=tree[3][2][0]
  self.assertEqual(application[:2],['Apply',['Projection',['Local','S'],'arrow']])
  self.assertEqual(len(application[2]),1)
  self.assertEqual(application[2][0][:3],['BoundNumeral','0','Natural'])
  self.assertEqual(application[2][0][-1],'inferred')
 def test_zero_map_endpoints(self):
  self.assertEqual(self.expr('module zero map(field,N,P)').type,self.env.type('ModuleMap(K,field,N,P)',self.scope))
  self.assertEqual(self.expr('exact(f,module zero map(field,N,P))').type,Type('Proposition'))
  with self.assertRaises(CleanError):self.expr('exact(g,module zero map(field,M,N))')
 def test_noncomposable_pair_rejects(self):
  with self.assertRaises(CleanError):self.expr('exact pair(field,M,N,P,g,f)')
 def test_kernel_lives_in_domain(self):
  self.assertEqual(self.expr('module map kernel(field,M,N,f)').type,self.env.type('ModuleSubspace(K,field,M)',self.scope))
  self.assertNotEqual(self.expr('module map kernel(field,M,N,f)').type,self.env.type('ModuleSubspace(K,field,N)',self.scope))

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
