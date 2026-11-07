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

    def test_nested_call_uses_current_bindings(self):
        original=Expressions(self.env,self.local).parse('retain(retain(x))')
        self.bind('second','B')
        normalized=comparison_normal_form(original,self.env,self.local)
        fresh=Expressions(self.env,self.local).parse('retain(retain(x))')
        self.assertEqual(normalized.lean,fresh.lean)
        self.assertEqual(normalized.type,fresh.type)
        self.assertNotIn('first',normalized.lean)

    def test_public_entry_does_not_trust_retained_argument_metadata(self):
        self.original.checked_args=(Expr('wrong','wrong',self.env.type('B',self.local)),)
        self.bind('second','B')
        self.check_current_binding()

    def test_nested_recheck_is_linear_and_uses_current_scope(self):
        depth=12
        source='retain('*depth+'x'+')'*depth
        original=Expressions(self.env,self.local).parse(source)
        self.bind('second','B')
        call=self.env.call
        calls=[]
        def counted(*args,**kwargs):
            calls.append(args[0])
            return call(*args,**kwargs)
        self.env.call=counted
        try:normalized=comparison_normal_form(original,self.env,self.local)
        finally:self.env.call=call
        self.assertLessEqual(len(calls),depth)
        self.assertEqual(normalized.lean,Expressions(self.env,self.local).parse(source).lean)
        self.assertEqual(normalized.type,self.env.type('B',self.local))

    def test_same_tree_different_value(self):
        self.bind('second','A')
        self.check_current_binding()

    def test_same_tree_different_type(self):
        self.bind('second','B')
        self.check_current_binding()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
