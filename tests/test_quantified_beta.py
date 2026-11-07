# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

class QuantifiedBeta(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.env=Environment();load_module(ROOT/'library/logic/choice.clean',cls.env)
    def setUp(self):
        self.scope={}
        for n,t in [('A','Type'),('S','Set(A)'),('T','Set(A)'),('a','A'),
                    ('h','Evidence((there exists(x: A,x ∈ S)))')]:
            self.scope[n]=Expr(n,n,self.env.type(t,self.scope),tree=['Local',n])
    def proof(self,s):return self.env.type('Evidence(('+s+'))',self.scope)
    def expr(self,s):return Expressions(self.env,self.scope).parse(s)
    def test_exists_beta_and_emission_preserved(self):
        a=self.proof('there exists(x: A,(function(y: A,y ∈ S))(x))')
        b=self.proof('there exists(z: A,z ∈ S)')
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b))
        self.assertNotEqual(a.args[0].lean,b.args[0].lean)
        self.assertIn('fun',a.args[0].lean)
    def test_nested_quantifier_scope(self):
        self.assertEqual(self.proof('for every(x: A,there exists(y: A,(function(z: A,z = x))(y)))'),
                         self.proof('for every(u: A,there exists(v: A,v = u))'))
    def test_free_variable_is_not_captured(self):
        a=self.proof('there exists(x: A,(function(y: A,y = a))(x))')
        self.assertEqual(a,self.proof('there exists(z: A,z = a)'))
        self.assertNotEqual(a,self.proof('there exists(z: A,z = z)'))
    def test_wrong_condition_evidence_is_rejected(self):
        with self.assertRaises(CleanError):self.expr('choose element(T,h)')
    def test_wrong_domain_is_checked_before_reduction(self):
        with self.assertRaises(CleanError):self.proof('there exists(x: A,(function(y: Natural,y = y))(x))')
    def test_argument_with_inner_function(self):
        self.assertEqual(self.proof('(function(y: A,y ∈ S))(choose witness(function(z: A,z ∈ S),h))'),
                         self.proof('choose element(S,h) ∈ S'))
    def test_applied_body_with_quantifier_is_hygienic(self):
        self.assertEqual(self.proof('there exists(x: A,(function(y: A,for every(z: A,z = y)))(x))'),
                            self.proof('there exists(x: A,for every(z: A,z = x))'))
    def test_function_returning_function_contracts_without_capture(self):
        self.assertEqual(self.proof('there exists(x: A,((function(y: A,function(z: A,z = y)))(x))(a))'),
                         self.proof('there exists(x: A,a = x)'))
    def test_source_tree_remains_explicit(self):
        from cleanlang.syntax import parse,expression_tree
        self.assertEqual(expression_tree(parse('there exists(x: A,(function(y: A,y ∈ S))(x))','expression')),
          ['Exists','x','A',['Apply',['Lambda','y','A',['Operator','∈',['Local','y'],['Local','S']]],[['Local','x']]]])
    def test_authored_set_helpers(self):
        for n in ['choose element','chosen element belongs']:
            self.assertEqual(self.env.definitions[n]['implementation'],'equals')
        self.assertEqual(self.expr('chosen element belongs(S,h)').type,self.proof('choose element(S,h) ∈ S'))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
