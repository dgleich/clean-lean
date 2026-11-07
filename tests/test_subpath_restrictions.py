# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
ROOT=Path(__file__).resolve().parents[1]
class SubpathRestrictions(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.e=Environment();load_module(ROOT/'library/diagrams/subpaths.clean',cls.e)
 def setUp(self):
  self.local={}
  for n,t in [('n','Natural'),('a','Natural'),('m','Natural'),('h','Evidence((a+m ≤ n))'),
              ('d','Function(Vertex(n),Boolean)'),('hs','Evidence((subpath sources preserved(n,a,m,h,d)))'),
              ('ht','Evidence((subpath targets preserved(n,a,m,h,d)))'),('edge','Vertex(m)'),('vertex','Vertex((m+1))')]:
   self.local[n]=Expr(n,n,self.e.type(t,self.local),tree=['Local',n])
 def expr(self,s):return Expressions(self.e,self.local).parse(s)
 def test_independent_call_tree(self):
  self.assertEqual(expression_tree(parse('subpath shape map(n,a,m,h,d,hs,ht)','expression')),
                   ['Call','subpath shape map',[['Local',n] for n in ['n','a','m','h','d','hs','ht']]])
 def test_named_conditions_are_constructor_arguments(self):
  self.assertEqual(self.expr('subpath shape map(n,a,m,h,d,hs,ht)').type,
                   self.e.type('SubpathShapeMap(n,a,m,h,d)',self.local))
 def test_endpoint_certificates_cannot_be_swapped(self):
  with self.assertRaises(CleanError):self.expr('subpath shape map(n,a,m,h,d,ht,hs)')
 def test_bound_is_not_synthesized(self):
  self.local['bad']=Expr('bad','bad',self.e.type('Evidence((a ≤ n))',self.local),tree=['Local','bad'])
  with self.assertRaisesRegex(CleanError,'index mismatch'):self.expr('subpath edge(n,a,m,bad,edge)')
 def test_edge_and_vertex_carriers_are_distinct(self):
  with self.assertRaises(CleanError):self.expr('subpath edge(n,a,m,h,vertex)')
  self.assertEqual(self.expr('subpath vertex(n,a,m,h,vertex)').type,self.e.type('Vertex((n+1))',self.local))
 def test_construction_is_authored(self):
  for n in ['subpath edge','subpath vertex','subpath directions','subpath shape map','restricted zigzag']:
   self.assertEqual(self.e.definitions[n]['implementation'],'equals')
if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
