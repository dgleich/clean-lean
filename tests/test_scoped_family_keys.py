# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
import test_family_comparison as fixtures
from cleanlang.core import Expr,Type,Expressions,CleanError
from cleanlang.indices import index_value
from cleanlang.binder_keys import key,ScopedKey
from cleanlang.dependent_functions import abstract_template

class ScopedFamilies(unittest.TestCase):
    def setUp(self):
        self.case=fixtures.FamilyComparison();self.case.setUp()
    def test_saved_key_survives_new_names(self):
        c=self.case;before=c.index('first(n)')
        for name in ['clean_bound_0','clean_pi_bound_0','clean_comparison_identity_0',
                     'clean_comparison_identity_1','clean_conversion_bound_0']:
            c.local[name]=Expr(name,name,Type('Natural'))
            with self.subTest(name=name):
                after=c.index('renamed(n)')
                self.assertEqual(before,after);self.assertEqual(hash(before),hash(after))
    def test_free_identity_is_not_owned(self):
        c=self.case;n='clean_comparison_identity_0'
        c.local[n]=Expr(n,n,Type('Natural'))
        value=c.index('first('+n+')')
        self.assertIn(('free',n),value.comparison_key().parts)
        self.assertNotEqual(value,c.index('first(n)'))
    def test_saved_dependent_domain(self):
        c=fixtures.NestedFamilies();c.setUp();c.test_dependent_domains_alpha()
        old=c.key('sized first()')
        local={'clean_pi_bound_0':Expr('clean_pi_bound_0','p',Type('Natural')),
               'clean_comparison_identity_0':Expr('clean_comparison_identity_0','q',Type('Natural'))}
        new=index_value(Expressions(c.e,local).parse('sized second()'),c.e,local)
        self.assertEqual(old,new)
    def test_no_comparison_state_leaks_to_emission(self):
        c=self.case;before=c.expr('first(n)').lean
        c.index('first(n)')
        self.assertFalse(hasattr(c.e,'_comparison_pool'))
        self.assertEqual(c.expr('first(n)').lean,before)
    def test_independent_tokens_and_outer_abstraction(self):
        expected=ScopedKey(('',('free','fun'),' (',('owned',0),' : ',('free','Nat'),') => (',
           ('owned',0),' + ',('free','outside'),')'))
        actual=key('fun (private : Nat) => (private + outside)',{'private','unused'})
        self.assertEqual(actual,expected)
        self.assertIn(('bound',0),abstract_template(actual,('outside',)))
        self.assertIn(('owned',0),abstract_template(actual,('outside',)))
        self.assertNotEqual(actual,key('fun (private : Nat) => (outside + private)',{'private'}))

    def test_exception_restores_comparison_scope(self):
        from unittest.mock import patch
        c=self.case
        with patch('cleanlang.binder_keys.Pool.fresh',side_effect=CleanError('allocation probe')):
            with self.assertRaisesRegex(CleanError,'allocation probe'):c.index('first(n)')
        self.assertFalse(hasattr(c.e,'_comparison_pool'))
        self.assertEqual(c.index('first(n)'),c.index('second(n)'))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

    def test_family_under_dependent_arrow_keeps_outer_binder(self):
        from cleanlang.modules import type_declaration
        c=self.case
        type_declaration('Type At(F: Family):',['Means: Nat','Render latex: A({F})'],c.e)
        before=c.e.type('Function(p: Natural,At((first(p))))',c.local)
        c.local['clean_pi_bound_0']=Expr('clean_pi_bound_0','q',Type('Natural'))
        after=c.e.type('Function(q: Natural,At((second(q))))',c.local)
        self.assertEqual(before,after);self.assertEqual(hash(before),hash(after))
        self.assertNotEqual(before,c.e.type('Function(q: Natural,At((first(n))))',c.local))
