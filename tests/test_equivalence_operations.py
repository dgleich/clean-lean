# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment, Expr, Expressions, CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

class EquivalenceOperations(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.env=Environment()
        load_module(ROOT/'library/logic/equivalence_operations.clean',cls.env)

    def test_composes_with_existing_equality_chain_module(self):
        for names in [('equality_chains','equivalence_operations'),('equivalence_operations','equality_chains')]:
            env=Environment()
            for name in names:load_module(ROOT/('library/logic/'+name+'.clean'),env)
            self.assertIn('equality transitivity',env.data['functions'])
            self.assertIn('compose equivalences',env.data['functions'])

    def scope(self):
        local={}
        for name,kind in [('A','Type'),('B','Type'),('C','Type'),
                          ('e','Equivalence(A,B)'),('f','Equivalence(B,C)'),
                          ('x','A'),('y','B'),('z','C')]:
            local[name]=Expr(name,name,self.env.type(kind,local),tree=['Local',name])
        return local

    def test_composition_order(self):
        local=self.scope()
        value=Expressions(self.env,local).parse('compose equivalences(e,f)')
        self.assertEqual(value.type,self.env.type('Equivalence(A,C)',local))
        self.assertEqual([(n,str(t)) for n,t in value.inferred_args],[('A','A'),('B','B'),('C','C')])

    def test_inversion_reverses_carriers(self):
        local=self.scope()
        value=Expressions(self.env,local).parse('inverse equivalence(e)')
        self.assertEqual(value.type,self.env.type('Equivalence(B,A)',local))

    def test_wrong_composition_order_rejected(self):
        with self.assertRaises(CleanError):
            Expressions(self.env,self.scope()).parse('compose equivalences(f,e)')

    def test_wrong_inverse_argument_rejected(self):
        with self.assertRaises(CleanError):
            Expressions(self.env,self.scope()).parse('equivalence forward(inverse equivalence(e),x)')

    def test_inverse_laws_have_exact_propositions(self):
        local=self.scope()
        for source,condition in [
          ('equivalence left inverse(e,x)','equivalence backward(e,equivalence forward(e,x)) = x'),
          ('equivalence right inverse(e,y)','equivalence forward(e,equivalence backward(e,y)) = y')]:
            self.assertEqual(Expressions(self.env,local).parse(source).type,
                             self.env.type('Evidence(('+condition+'))',local))

    def test_constructions_are_authored(self):
        for name in ['inverse equivalence','compose equivalences']:
            self.assertEqual(self.env.definitions[name]['implementation'],'equals')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
