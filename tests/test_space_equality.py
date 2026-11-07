# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Type-1 space equality is explicitly declared, not inferred by universe lifting."""
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]
class SpaceEquality(unittest.TestCase):
    def setUp(self):
        self.env=Environment();load_module(ROOT/'library/topology/spaces.clean',self.env)
        typ=self.env.type('TopologicalSpace')
        self.locals={n:Expr(n,n,typ,tree=['Local',n]) for n in ['X','Y']}
    def test_explicit_large_carrier_adapter(self):
        e=self.env;s=self.locals
        self.assertEqual(e.sort_level(s['X'].type),2)
        value=Expressions(e,s).parse('X=Y')
        self.assertEqual(value.operator_binding[0],'same space')
        self.assertEqual(value.lean,Expressions(e,s).parse('same space(X,Y)').lean)
        expected=e.data['functions']['same space']['native_binding']
        self.assertEqual(value.lean,'(_root_.'+expected+' (X) (Y))')
        e.operator_overloads['='].reverse()
        self.assertEqual(Expressions(e,s).parse('X=Y').lean,value.lean)
    def test_missing_adapter_does_not_promote_generic_equality(self):
        e=self.env;e.operator_overloads['='].remove('same space')
        with self.assertRaisesRegex(CleanError,'No declared meaning'):
            Expressions(e,self.locals).parse('X=Y')
    def test_generic_small_carrier_equality_remains_distinct(self):
        e=self.env;t=e.type('Real')
        s={n:Expr(n,n,t,tree=['Local',n]) for n in ['x','y']}
        self.assertEqual(Expressions(e,s).parse('x=y').operator_binding[0],'equal')
        with self.assertRaises(CleanError):Expressions(e,{**s,**self.locals}).parse('X=x')

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
