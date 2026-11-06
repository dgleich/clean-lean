# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,NAT
from cleanlang.modules import load_module,notation,type_declaration
ROOT=Path(__file__).resolve().parents[1]
class ProofFamilies(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/logic/equalities.clean',self.e)
    def typ(self,s,local=None):return self.e.type(s,local or {})
    def test_proof_codomain_controls_sort(self):
        from cleanlang.syntax import type_tree,parse
        self.assertEqual(type_tree(parse('Function(v: Vertex(n),(v = v))','type_ref')),
          ['BoundTypeApply','Function','v',['Apply','Vertex',[['Name','n']]],
           ['ComputedIndex',['Operator','=', ['Local','v'],['Local','v']]]])
        self.assertIn('evidence that',self.e.describe_type(self.typ('Function(n: Natural,(n = n))')))

        for s in ['Function(n: Natural,(n = n))','Function(Natural,(0 = 0))',
                  'Function(n: Natural,Function((n = n),(n = n)))']:
            with self.subTest(s=s):self.assertTrue(self.e.is_proof_type(self.typ(s)))
        for s in ['Function((0 = 0),Natural)','Function(n: Natural,Function((n = n),Natural))',
                  'Function(Natural,Proposition)']:
            with self.subTest(s=s):self.assertFalse(self.e.is_proof_type(self.typ(s)))
    def test_constant_bound_arrow_roundtrip(self):
        a=self.typ('Function(h: (0 = 0),Natural)')
        self.assertEqual(a,self.typ(str(a)))
        self.assertEqual(a,self.typ('Function((0 = 0),Natural)'))
    def test_general_type_slots_reject_proof_families(self):
        for s in ['Set(Function(n: Natural,(n = n)))',
                  'Set(Function(Natural,(0 = 0)))','Set((0 = 0))']:
            with self.subTest(s=s),self.assertRaisesRegex(CleanError,'Proof types'):self.typ(s)
        self.typ('Set(Function((0 = 0),Natural))')
    def test_alias_parameter_contract_is_preserved(self):
        type_declaration('Type Mapping(A: Type,B: Type):',['Equals: Function(A,B)'],self.e)
        with self.assertRaisesRegex(CleanError,'Proof types'):
            self.typ('Mapping((0 = 0),Natural)')
        type_declaration('Type ReflexivityFamily():',
                         ['Equals: Function(n: Natural,(n = n))'],self.e)
        self.assertTrue(self.e.is_proof_type(self.typ('ReflexivityFamily')))
        with self.assertRaisesRegex(CleanError,'Proof types'):self.typ('Set(ReflexivityFamily)')
    def test_implicit_type_inference_rejects_proof_family(self):
        local={'h':Expr('h','h',self.typ('Function(n: Natural,(n = n))'))}
        with self.assertRaisesRegex(CleanError,'Expected a type argument'):
            Expressions(self.e,local).parse('equality reflexivity(h)')
    def test_legacy_type_inference_rejects_proof_family(self):
        notation('Notation hold(x):',['Let T: Type','Let x: T','Returns: T','Means: x','Render latex: {x}'],self.e)
        local={'h':Expr('h','h',self.typ('Function(n: Natural,(n = n))'))}
        with self.assertRaisesRegex(CleanError,'Proof types'):
            Expressions(self.e,local).parse('hold(h)')
    def test_inferred_proof_lambda_and_application(self):
        expr=Expressions(self.e,{}).parse('function(n: Natural,equality reflexivity(n))')
        self.assertEqual(expr.type,self.typ('Function(k: Natural,(k = k))'))
        local={'f':Expr('f','f',expr.type),'m':Expr('m','m',NAT)}
        self.assertEqual(Expressions(self.e,local).parse('f(m)').type,self.typ('(m = m)',local))
    def test_proof_domain_evidence_checked(self):
        local={'f':Expr('f','f',self.typ('Function((0 = 0),Natural)')),
               'h':Expr('h','h',self.typ('(0 = 0)')),'bad':Expr('bad','bad',self.typ('(0 = 1)'))}
        self.assertEqual(Expressions(self.e,local).parse('f(h)').type,NAT)
        with self.assertRaises(CleanError):Expressions(self.e,local).parse('f(bad)')
    def test_arrow_grant_is_module_declared(self):
        self.e.data['types']['Mapping']=self.e.data['types'].pop('Function')
        self.assertTrue(self.e.is_proof_type(self.typ('Mapping(n: Natural,(n = n))')))
        self.typ('Mapping((0 = 0),Natural)')
        self.e.data['types']['Mapping']['lean']='Prod {0} {1}'
        with self.assertRaises(CleanError):self.typ('Mapping((0 = 0),Natural)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
