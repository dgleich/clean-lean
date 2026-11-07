# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Retained module calls obey the same fresh-traversal rule as ordinary calls."""
from pathlib import Path
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,notation,condition_declaration
from cleanlang.bound_calls import bind
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]

class BoundComparisonReuse(unittest.TestCase):
    def setUp(self):
        self.env=Environment();load_module(ROOT/'library/logic/functions.clean',self.env)
        notation('Notation retain(x):',['Let A: Type','Let x: A','Returns: A',
                 'Means: x','Render latex: {x}'],self.env)
        condition_declaration('Condition equal(x,y):', ['Let T: Type','Let x,y: T',
                              'Infix: =','From Lean: x=y','Render latex: {x}={y}'],self.env)
        self.local={n:Expr(n,n,self.env.type('Type')) for n in ['A','B']}
        self.rebind('first','A')

    def rebind(self,target,typ):
        self.local['x']=Expr(target,'x',self.env.type(typ,self.local),tree=['Local','x'])

    def expression(self,depth=1):
        tree=['Local','x']
        for _ in range(depth):tree=['Call','retain',[tree]]
        tree=bind(tree,self.env,self.local)
        return Expressions(self.env,self.local).elaborate(tree)

    def test_nested_bound_checks_each_call_once(self):
        depth=12;old=self.expression(depth)
        self.rebind('second','B')
        with patch.object(self.env,'call',wraps=self.env.call) as calls:
            actual=comparison_normal_form(old,self.env,self.local)
        self.assertLessEqual(calls.call_count,depth)
        expected=self.expression(depth)
        self.assertEqual((actual.lean,actual.type,actual.tree),
                         (expected.lean,expected.type,expected.tree))

    def test_public_entry_rechecks_changed_value(self):
        old=self.expression();self.rebind('second','A')
        actual=comparison_normal_form(old,self.env,self.local)
        self.assertEqual(actual.lean,self.expression().lean)
        self.assertNotIn('first',actual.lean)

    def test_public_entry_ignores_mutated_checked_arguments(self):
        old=self.expression();old.checked_args=(Expr('bogus','bogus',self.env.type('B',self.local)),)
        self.rebind('second','B')
        actual=comparison_normal_form(old,self.env,self.local)
        expected=self.expression()
        self.assertEqual((actual.lean,actual.type),(expected.lean,expected.type))
        self.assertNotIn('bogus',actual.lean)

    def test_changed_bound_template_rejects(self):
        old=self.expression(3)
        self.env.data['functions']['retain']['lean']+=' changed'
        with self.assertRaisesRegex(CleanError,'Changed bound module callable'):
            comparison_normal_form(old,self.env,self.local)

    def test_incomplete_recheck_propagates(self):
        old=self.expression(3)
        with patch.object(self.env,'call',side_effect=TimeoutError('incomplete call')):
            with self.assertRaises(TimeoutError):comparison_normal_form(old,self.env,self.local)

    def test_fresh_reuse_still_checks_bound_identity(self):
        term=self.expression()
        original=Expressions(self.env,self.local).elaborate(['Operator','=',term.tree,term.tree])
        call=self.env.call
        def change_after_check(*args,**kwargs):
            result=call(*args,**kwargs)
            self.env.data['functions']['retain']['lean']+=' changed'
            return result
        with patch.object(self.env,'call',side_effect=change_after_check):
            with self.assertRaisesRegex(CleanError,'Changed bound module callable'):
                comparison_normal_form(original,self.env,self.local)

    def test_changed_normalized_argument_rechecks_parent(self):
        self.local['z']=Expr('z','z',self.local['x'].type,tree=['Local','z'],
                             local_normal=self.local['x'])
        tree=bind(['Call','retain',[['Call','retain',[['Local','z']]]]],self.env,self.local)
        old=Expressions(self.env,self.local).elaborate(tree)
        with patch.object(self.env,'call',wraps=self.env.call) as calls:
            actual=comparison_normal_form(old,self.env,self.local)
        self.assertEqual(calls.call_count,3)
        self.assertEqual(actual.lean,self.expression(2).lean)
        self.assertNotIn('(z)',actual.lean)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
