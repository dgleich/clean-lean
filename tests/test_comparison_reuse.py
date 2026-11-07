# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Argument source trees alone cannot certify reuse of a checked call.

These exercise the normalization API under replacement caller bindings. They
are not claims that a complete authored document currently triggers rebinding.
"""
from pathlib import Path
import unittest
from cleanlang.core import Environment, Expr, Expressions
from cleanlang.modules import load_module, notation
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]

class ComparisonReuse(unittest.TestCase):
    def setUp(self):
        self.env=Environment()
        load_module(ROOT/'library/logic/functions.clean',self.env)
        notation('Notation retain(x):', ['Let A: Type','Let x: A','Returns: A',
                 'Means: x','Render latex: {x}'],self.env)
        self.local={n:Expr(n,n,self.env.type('Type')) for n in ['A','B']}
        self.bind('first','A')
        self.original=Expressions(self.env,self.local).parse('retain(x)')

    def bind(self,target,typ):
        self.local['x']=Expr(target,'x',self.env.type(typ,self.local),tree=['Local','x'])

    def check_current_binding(self):
        normalized=comparison_normal_form(self.original,self.env,self.local)
        fresh=Expressions(self.env,self.local).parse('retain(x)')
        self.assertEqual(normalized.tree,self.original.tree)
        self.assertEqual(normalized.lean,fresh.lean)
        self.assertEqual(normalized.type,fresh.type)
        self.assertIn('second',normalized.lean)
        self.assertNotIn('first',normalized.lean)

    def test_same_tree_different_value(self):
        self.bind('second','A')
        self.check_current_binding()

    def test_same_tree_different_type(self):
        self.bind('second','B')
        self.check_current_binding()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
