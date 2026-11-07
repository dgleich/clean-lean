# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import expression_tree,parse
ROOT=Path(__file__).resolve().parents[1]
class ActiveLabels(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/diagrams/active_labels.clean',cls.e)
    def locals(self):
        result={}
        for n,t in [('I','Type'),('n','Natural'),('a','Natural'),('m','Natural'),('h','Evidence((a+m ≤ n))'),('L','IntervalLabels(I,n)'),('v','Vertex((m+1))'),('support','ActiveLabelSupport(I,n,a,m,h,L,v)'),('x','OriginalActiveLabels(I,n,a,m,h,L,v)'),('y','RestrictedActiveLabels(I,n,a,m,L,v)')]:
            result[n]=Expr(n,n,self.e.type(t,result),tree=['Local',n])
        return result
    def test_tree(self):
        self.assertEqual(expression_tree(parse('restrict active label(I,n,a,m,h,L,v,support,x)','expression')),
            ['Call','restrict active label',[['Local',n] for n in ['I','n','a','m','h','L','v','support','x']]])
    def test_maps_have_opposite_carriers(self):
        local=self.locals()
        for source,expected in [('restrict active label(I,n,a,m,h,L,v,support,x)',local['y'].type),('restore active label(I,n,a,m,h,L,v,support,y)',local['x'].type)]:
            self.assertEqual(Expressions(self.e,local).parse(source).type,expected)
    def test_reversed_source_label_rejected(self):
        with self.assertRaises(CleanError):Expressions(self.e,self.locals()).parse('restrict active label(I,n,a,m,h,L,v,support,y)')
    def test_maps_and_equivalence_are_authored(self):
        for n in ['original active labels','restricted active labels','restrict active label','restore active label','active label equivalence']:
            self.assertEqual(self.e.definitions[n]['implementation'],'equals')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
