# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Explicit foundation imports, overloaded selection, and retained numeral scope."""
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expressions,Expr,Type,CleanError
from cleanlang.modules import load_module
from cleanlang.bound_calls import bind,UnclosedBinding
from cleanlang.numeral_inference import declare_default
from cleanlang.syntax import parse,expression_tree
ROOT=Path(__file__).resolve().parents[1]
class DeclaredStandardOperators(unittest.TestCase):
    def test_types_do_not_supply_operators_or_default(self):
        env=Environment();load_module(ROOT/'library/types.clean',env)
        with self.assertRaisesRegex(CleanError,'Ambiguous numeral'):
            Expressions(env,{}).parse('1')
        scope={'x':Expr('x','x',Type('Real'),tree=['Local','x'])}
        with self.assertRaisesRegex(CleanError,'No declared meaning'):
            Expressions(env,scope).parse('x+x')

    def test_standard_scope_and_overloads(self):
        env=Environment();load_module(ROOT/'library/operators.clean',env)
        scope={}
        for name,typ in [('m','Natural'),('n','Natural'),('A','Matrix(m,n,Complex)'),('v','Vector(n,Complex)'),('z','Complex')]:
            scope[name]=Expr(name,name,env.type(typ,scope),tree=['Local',name])
        expr=lambda source:Expressions(env,scope).parse(source)
        self.assertEqual(expr('1').type,Type('Natural'))
        self.assertEqual(expr('z+1').type,Type('Complex'))
        value=expr('A*v');self.assertEqual(value.type,env.type('Vector(m,Complex)',scope))
        env.operator_overloads['*'].reverse()
        self.assertEqual(expr('A*v').lean,value.lean)
        with self.assertRaisesRegex(CleanError,'No declared meaning'):
            expr('v*A')

    def test_closed_operator_keeps_numeral_constructor(self):
        common=ROOT/'studies/module-numerals/Common.clean.proposed'
        a=Environment();load_module(common,a);declare_default('Counting',a)
        b=Environment();load_module(common,b);declare_default('Real',b)
        tree=bind(expression_tree(parse('1=1','expression')),a,{})
        self.assertTrue(all(x[0]=='BoundNumeral' and x[2]=='Counting' for x in tree[2]))
        actual=Expressions(b,{}).elaborate(tree).lean
        self.assertEqual(actual,Expressions(a,{}).parse('1=1').lean)
        self.assertNotEqual(actual,Expressions(b,{}).parse('1=1').lean)
        with self.assertRaises(UnclosedBinding):
            bind(expression_tree(parse('equal(1,1)','expression')),a,{})

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
