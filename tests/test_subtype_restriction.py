# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]
class SubtypeRestriction(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/logic/subtype_restriction.clean',cls.e)
    def locals(self):
        scope={}
        for n,t in [('A','Type'),('S','Set(A)'),('T','Set(A)'),('U','Set(Element(A,S))'),('support','SubtypeRestrictionSupport(A,S,T,U)'),('x','Element(A,T)'),('y','Element(Element(A,S),U)'),('i','A'),('h','Evidence((i ∈ T))')]:
            scope[n]=Expr(n,n,self.e.type(t,scope),tree=['Local',n])
        return scope
    def test_map_carriers(self):
        scope=self.locals()
        for source,t in [('restrict element(A,S,T,U,support,x)',scope['y'].type),('restore element(A,S,T,U,support,y)',scope['x'].type)]:
            self.assertEqual(Expressions(self.e,scope).parse(source).type,t)
    def test_reversed_label_rejected(self):
        with self.assertRaises(CleanError):Expressions(self.e,self.locals()).parse('restrict element(A,S,T,U,support,y)')
    def test_membership_evidence_belongs_to_requested_set(self):
        scope=self.locals()
        self.assertEqual(Expressions(self.e,scope).parse('element from membership(T,i,h)').type,scope['x'].type)
        with self.assertRaises(CleanError):Expressions(self.e,scope).parse('element from membership(S,i,h)')
    def test_explicit_support_fields(self):
        self.assertEqual([n for n,_ in self.e.structures['SubtypeRestrictionSupport']['fields']],['survives','active','original'])
    def test_mathematical_bodies_are_authored(self):
        for name in ['restrict element','restore element','subtype restriction equivalence']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
