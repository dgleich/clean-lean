# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
ROOT=Path(__file__).resolve().parents[1]
class IntervalClipping(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/diagrams/interval_clipping.clean',cls.e)
    def locals(self,items):
        result={}
        for n,t in items:result[n]=Expr(n,n,self.e.type(t,result),tree=['Local',n])
        return result
    def test_independent_tree(self):
        self.assertEqual(expression_tree(parse('clipped vertex(n,a,m,v)','expression')),
            ['Call','clipped vertex',[['Local',n] for n in ['n','a','m','v']]])
    def test_clipping_changes_vertex_carrier(self):
        local=self.locals([('n','Natural'),('a','Natural'),('m','Natural'),('v','Vertex((n+1))')])
        result=Expressions(self.e,local).parse('clipped vertex(n,a,m,v)')
        self.assertEqual(result.type,self.e.type('Vertex((m+1))',local))
    def test_wrong_input_carrier_rejected(self):
        local=self.locals([('n','Natural'),('a','Natural'),('m','Natural'),('v','Vertex(n)')])
        with self.assertRaises(CleanError):Expressions(self.e,local).parse('clipped vertex(n,a,m,v)')
    def test_wrong_bound_evidence_rejected(self):
        local=self.locals([('n','Natural'),('k','Natural'),('h','Evidence((n ≤ k))')])
        with self.assertRaises(CleanError):Expressions(self.e,local).parse('bounded vertex(n,k,h)')
    def test_restricted_labels_use_surviving_index_type(self):
        local=self.locals([('I','Type'),('n','Natural'),('a','Natural'),('m','Natural'),('L','IntervalLabels(I,n)')])
        result=Expressions(self.e,local).parse('restricted interval labels(I,n,a,m,L)')
        self.assertEqual(result.type,self.e.type('IntervalLabels(Element(I,(surviving interval labels(I,n,a,m,L))),m)',local))
    def test_order_evidence_requires_correct_direction(self):
        local=self.locals([('n','Natural'),('a','Natural'),('m','Natural'),('u','Vertex((n+1))'),('v','Vertex((n+1))'),('h','Evidence((v ≤ u))')])
        with self.assertRaises(CleanError):Expressions(self.e,local).parse('clipped vertices ordered(n,a,m,u,v,h)')
    def test_mathematical_definitions_are_authored(self):
        for n in ['clipped vertex','surviving interval labels','clipped vertices ordered','restricted interval labels']:
            self.assertEqual(self.e.definitions[n]['implementation'],'equals')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
