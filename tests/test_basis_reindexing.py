# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
ROOT=Path(__file__).resolve().parents[1]
class BasisReindexing(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/algebra/basis_reindexing.clean',cls.e)
    def locals(self,items):
        result={}
        for name,typ in items:result[name]=Expr(name,name,self.e.type(typ,result),tree=['Local',name])
        return result
    def basis_locals(self,orientation='Equivalence(I,J)'):
        return self.locals([('K','Type'),('I','Type'),('J','Type'),('field','FieldStructure(K)'),('M','CoefficientModule(K,field)'),('b','ModuleBasis(K,field,M,I)'),('e',orientation)])
    def test_independent_tree(self):
        self.assertEqual(expression_tree(parse('reindex module basis(field,M,b,e)','expression')),
            ['Call','reindex module basis',[['Local',n] for n in ['field','M','b','e']]])
    def test_changes_index_carrier(self):
        local=self.basis_locals();value=Expressions(self.e,local).parse('reindex module basis(field,M,b,e)')
        self.assertEqual(value.type,self.e.type('ModuleBasis(K,field,M,J)',local))
    def test_reversed_equivalence_rejected(self):
        with self.assertRaises(CleanError):Expressions(self.e,self.basis_locals('Equivalence(J,I)')).parse('reindex module basis(field,M,b,e)')
    def test_forward_and_backward_domains(self):
        local=self.locals([('A','Type'),('B','Type'),('e','Equivalence(A,B)'),('x','A'),('y','B')])
        for source,typ in [('equivalence forward(e,x)','B'),('equivalence backward(e,y)','A')]:
            self.assertEqual(Expressions(self.e,local).parse(source).type,self.e.type(typ,local))
        for source in ['equivalence forward(e,y)','equivalence backward(e,x)']:
            with self.assertRaises(CleanError):Expressions(self.e,local).parse(source)
    def test_constructor_requires_inverse_evidence(self):
        local=self.locals([('A','Type'),('B','Type'),('f','Function(A,B)'),('g','Function(B,A)'),('left','Function(x: A,Evidence((x = x)))'),('right','Function(y: B,Evidence((f(g(y)) = y)))')])
        with self.assertRaises(CleanError):Expressions(self.e,local).parse('equivalence(A,B,f,g,left,right)')
    def test_identity_is_authored(self):
        self.assertEqual(self.e.definitions['identity equivalence']['implementation'],'equals')
    def test_no_implicit_equivalence_vocabulary(self):
        with self.assertRaises(CleanError):Environment().type('Equivalence(Natural,Natural)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
