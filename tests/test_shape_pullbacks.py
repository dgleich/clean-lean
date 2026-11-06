# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import sys,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
class ShapePullbacks(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.e=Environment();load_module(ROOT/'library/diagrams/pullbacks.clean',cls.e)
 def setUp(self):
  self.local={}
  for n,t in [('K','Type'),('field','FieldStructure(K)'),('V','Type'),('E','Type'),('W','Type'),('F','Type'),
   ('Q','DiagramShape(V,E)'),('R','DiagramShape(W,F)'),('f','DiagramShapeMap(V,E,W,F,Q,R)'),
   ('M','ModuleDiagram(K,field,W,F,R)'),('v','V'),('a','E')]:
   self.local[n]=Expr(n,n,self.e.type(t,self.local),tree=['Local',n])
 def expr(self,s):return Expressions(self.e,self.local).parse(s)
 def test_independent_tree(self):
  self.assertEqual(expression_tree(parse('diagram pullback(K,field,V,E,W,F,Q,R,f,M)','expression')),
   ['Call','diagram pullback',[['Local',n] for n in ['K','field','V','E','W','F','Q','R','f','M']]])
 def test_pullback_has_source_shape(self):
  self.assertEqual(self.expr('diagram pullback(K,field,V,E,W,F,Q,R,f,M)').type,
   self.e.type('ModuleDiagram(K,field,V,E,Q)',self.local))
 def test_requires_endpoint_evidence(self):
  with self.assertRaises(CleanError):self.expr('shape map(V,E,W,F,Q,R,f.vertices,f.edges)')
 def test_wrong_shape_rejects(self):
  self.local['S']=Expr('S','S',self.e.type('DiagramShape(W,F)',self.local),tree=['Local','S'])
  with self.assertRaises(CleanError):self.expr('diagram pullback(K,field,V,E,W,F,Q,S,f,M)')
 def test_wrong_transport_orientation_rejects(self):
  with self.assertRaises(CleanError):self.expr('module family transport(field,M.object,R.source(f.edges(a)),f.vertices(Q.source(a)),f.sources(a))')
 def test_transport_result_has_fixed_endpoints(self):
  r=self.expr('module family transport(field,M.object,f.vertices(Q.source(a)),R.source(f.edges(a)),f.sources(a))')
  t=self.e.type('ModuleMap(K,field,(M.object(f.vertices(Q.source(a)))) ,(M.object(R.source(f.edges(a)))))',self.local)
  self.assertEqual(r.type,t)
 def test_proof_fields_and_authored_definitions(self):
  self.assertEqual([n for n,t in self.e.structures['DiagramShapeMap']['fields']],['vertices','edges','sources','targets'])
  for n in ['identity shape map','composite shape map','diagram pullback']:
   self.assertEqual(self.e.definitions[n]['implementation'],'equals')
 def test_short_call_tree_and_carrier_inference(self):
  self.assertEqual(expression_tree(parse('pull back diagram(field,Q,R,f,M)','expression')),
   ['Call','pull back diagram',[['Local',n] for n in ['field','Q','R','f','M']]])
  self.assertEqual(self.expr('pull back diagram(field,Q,R,f,M)').type,
   self.expr('diagram pullback(K,field,V,E,W,F,Q,R,f,M)').type)
 def test_inferred_body_conversion_boundary(self):
  from cleanlang.indices import index_value
  short=self.expr('pull back diagram(field,Q,R,f,M).object(v)')
  explicit=self.expr('diagram pullback(K,field,V,E,W,F,Q,R,f,M).object(v)')
  self.assertNotEqual(index_value(short,self.e,self.local),index_value(explicit,self.e,self.local))
if __name__=='__main__':unittest.main(verbosity=2)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
