# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent scope, syntax, and type oracles for quantified conditions."""
import unittest
from pathlib import Path
from cleanlang.core import Environment, Expressions, Expr, Type, CleanError
from cleanlang.modules import load_module, load_document
from cleanlang import syntax
ROOT=Path(__file__).resolve().parents[1]

class Quantifiers(unittest.TestCase):
    def setUp(self):
        self.env=Environment();load_module(ROOT/'library/types.clean',self.env)
    def parse(self,s,locals=None):
        return Expressions(self.env,locals or {}).parse(s)
    def test_independent_tree(self):
        source='for every (x: Real, there exists (y: Real, x = y))'
        expected=['Forall','x','Real',['Exists','y','Real',
            ['Operator','=', ['Local','x'],['Local','y']]]]
        self.assertEqual(syntax.expression_tree(syntax.parse(source,'expression')),expected)
        self.assertEqual(self.parse(source).tree,expected)
        self.assertEqual(self.parse(source).type,Type('Proposition'))
    def test_body_boundary_and_sibling_scope(self):
        e=self.parse('there exists (x: Real, x=x) and for every (x: Real, x=x)')
        self.assertEqual(e.tree[0:2],['Operator','∧'])
        self.assertIn('clean_bound_1',e.lean)
        with self.assertRaises(CleanError):self.parse('there exists (x: Real, x=x) and x=x')
    def test_assumption_commas(self):
        t=syntax.parse('witness: there exists (x: Real, x=x), reflexive: for every (y: Real, y=y)','assumptions')
        self.assertEqual(len(t.children),2)
    def test_case_and_latex(self):
        e=self.parse('FoR EvErY (x: Real, ThErE ExIsTs (y: Real, x=y))')
        self.assertIn(r'\text{for every }',e.tex)
        self.assertIn(r'\text{there exists }',e.tex)
        self.assertNotIn(r'\forall',e.tex)
    def test_rejected_forms(self):
        for s in ['for every x: Real, x=x','there exists (x: Real, x)',
                  'there exists (x: Real, 1)', 'there exists (x: Real, x=x, x=x)',
                  'for every (x: Real, there exists (x: Real, x=x))',
                  'for every (Real: Real, Real=Real)',
                  'there exists (there: Real, there=there)',
                  'for every (x: Missing, x=x)']:
            with self.subTest(s=s), self.assertRaises(CleanError):self.parse(s)
    def test_capture_and_restoration(self):
        locals={'clean_bound_0':Expr('clean_bound_0','a',Type('Real'))}
        e=self.parse('there exists (y: Real,y=clean_bound_0)',locals)
        self.assertIn('fun (clean_bound_1',e.lean)
        parser=Expressions(self.env,locals)
        with self.assertRaises(CleanError):parser.parse('for every (y: Real, unknown)')
        self.assertEqual(parser.env,locals)
    def test_lambda_interaction(self):
        e=self.parse('function(x: Real, there exists (y: Real, x=y))')
        self.assertEqual(e.type,Type('Function',(Type('Real'),Type('Proposition'))))
    def test_foundation_binding_required(self):
        self.env.data['types'].pop('Proposition')
        with self.assertRaisesRegex(CleanError,'foundational'):
            self.parse('for every (x: Real,x=x)')
    def test_dependent_domain_renaming(self):
        e=self.parse("for every (n: Natural, for every (x: Vector(n,Real), x=x))")
        self.assertIn("Fin clean_bound_0",e.lean)
        self.assertNotIn("Fin n",e.lean)

    def test_type_template_constants_are_not_local_names(self):
        e=self.parse('for every (Fin: Natural, for every (x: Vector(Fin,Real), x=x))')
        self.assertIn('Fin clean_bound_0',e.lean)
        self.assertNotIn('clean_bound_0 clean_bound_0',e.lean)

    def test_study_and_universe_binding(self):
        env=Environment();rs=load_document(ROOT/'studies/topology/Foundations.clean',env)
        self.assertEqual(len(rs),4)
        self.assertEqual(env.definitions['continuous between']['tree'][0],'Forall')
        self.assertEqual(env.definitions['image']['tree'][0],'Call')
        self.assertTrue(any(': Type 1 :=' in d for d in env.notation_definitions.values()))

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
