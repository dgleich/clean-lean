# generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Independent parse/scope oracles for parenthesized typed functions."""
import unittest
from pathlib import Path
from cleanlang.core import Environment, Expressions, Expr, Type, CleanError
from cleanlang.modules import load_module, notation

ROOT=Path(__file__).resolve().parents[1]

class FunctionExpressions(unittest.TestCase):
    def setUp(self):
        self.env=Environment()
        load_module(ROOT/'library/types.clean',self.env)

    def parse(self,s,locals=None):
        return Expressions(self.env,locals or {}).parse(s)

    def test_independent_tree_and_target(self):
        e=self.parse('function(x: Real, x)')
        self.assertEqual(e.tree,['Lambda','x','Real',['Local','x']])
        self.assertEqual(e.lean,'(fun (clean_bound_0 : ℝ) => clean_bound_0)')
        self.assertEqual(e.type,Type('Function',(Type('Real'),Type('Real'))))

    def test_nested_capture_and_local_application(self):
        e=self.parse('function(f: Function(Real,Real), function(x: Real, f(x)))')
        self.assertEqual(e.tree,['Lambda','f','Function(Real,Real)',
            ['Lambda','x','Real',['Call','f',[['Local','x']]]]])
        self.assertIn('(clean_bound_0 clean_bound_1)',e.lean)

    def test_sibling_scope_and_deterministic_freshness(self):
        local={'clean_bound_0':Expr('clean_bound_0','z',Type('Real'))}
        e=self.parse('FUNCTION(x: Real, x + clean_bound_0)',local)
        self.assertIn('fun (clean_bound_1 : ℝ)',e.lean)
        self.assertEqual(e.lean,self.parse('FUNCTION(x: Real, x + clean_bound_0)',local).lean)
        with self.assertRaises(CleanError):self.parse('function(x: Real,x) + x')

    def test_rejections(self):
        for s in ('function(x, x)', 'function(x: Real)',
                  'function(x: Real, 1)', 'function(x: Real,x,x)',
                  'function(x: Real,function(x: Real,x))',
                  'function(n: Natural,function(i: Vertex(n),i))',
                  'function(Real: Natural,Real)', 'function(function: Real,function)'):
            with self.subTest(s=s),self.assertRaises(CleanError):self.parse(s)
        with self.assertRaises(CleanError):
            self.parse('function(x: Real,x)',{'x':Expr('x','x',Type('Real'))})

    def test_arrow_interface_is_module_declared(self):
        spec=self.env.data['types'].pop('Function')
        self.env.data['types']['Mapping']=spec
        self.assertEqual(self.parse('function(x: Real,x)').type.name,'Mapping')
        self.env.data['types']['SecondMapping']=dict(spec)
        with self.assertRaises(CleanError):self.parse('function(x: Real,x)')
        self.env.data['types'].pop('SecondMapping')
        self.env.data['types']['Mapping']['lean']='Prod {0} {1}'
        with self.assertRaises(CleanError):self.parse('function(x: Real,x)')

    def test_keyword_is_reserved_for_calls(self):
        with self.assertRaises(CleanError):
            notation('Notation function(x: Real): Real:', ['Means: x','Render latex: {x}'],self.env)
