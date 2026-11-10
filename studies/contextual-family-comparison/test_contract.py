# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Run only in the patched checkout; production has no contextual_keys module."""
from dataclasses import replace
import unittest
from unittest.mock import patch
import test_contextual_family_comparison as regression
from cleanlang.core import Expressions,CleanError
from cleanlang.conversion import index_comparison
from cleanlang.contextual_keys import comparison_key
from cleanlang.binder_keys import Pool

class ContextualKeyContract(unittest.TestCase):
    def setUp(self):
        fixture=regression.ContextualFamilyComparison();fixture.setUp()
        self.env,self.scope=fixture.env,fixture.scope
    def expression(self,source='sample(constant(a))'):
        return Expressions(self.env,self.scope).parse(source)
    def test_public_entry_ignores_mutated_call_metadata(self):
        value=self.expression();expected=index_comparison(value,self.env,self.scope)
        value.checked_args=(self.expression('b'),)
        self.assertEqual(index_comparison(value,self.env,self.scope),expected)
    def test_generated_key_does_not_rewrite_original_expression(self):
        value=self.expression();before=(value.lean,repr(value.tree),value.type,value.checked_args)
        index_comparison(value,self.env,self.scope)
        self.assertEqual((value.lean,repr(value.tree),value.type,value.checked_args),before)
    def test_invalid_call_shell_rejects_and_restores_empty_pool(self):
        value=self.expression('sample(function(x: Real,a))')
        def corrupt(expression,*args,**kwargs):
            return replace(expression,lean='invalid target') if expression.tree[0]=='Call' else expression
        with patch('cleanlang.conversion._normal_form',side_effect=corrupt):
            with self.assertRaisesRegex(CleanError,'comparison call template'):
                comparison_key(value,self.env,self.scope)
        self.assertFalse(hasattr(self.env,'_comparison_pool'))
    def test_error_restores_outer_pool(self):
        value=self.expression();outer=Pool(self.env,self.scope,value.tree)
        self.env._comparison_pool=outer
        with patch('cleanlang.conversion._normal_form',side_effect=CleanError('unfinished comparison')):
            with self.assertRaisesRegex(CleanError,'unfinished'):
                comparison_key(value,self.env,self.scope)
        self.assertIs(self.env._comparison_pool,outer)
    def test_success_restores_outer_pool(self):
        value=self.expression();outer=Pool(self.env,self.scope,value.tree)
        self.env._comparison_pool=outer
        comparison_key(value,self.env,self.scope)
        self.assertIs(self.env._comparison_pool,outer)
    def test_changed_retained_call_identity_rejects(self):
        from cleanlang.bound_calls import bind
        tree=bind(self.expression().tree,self.env,self.scope,binders=True)
        value=Expressions(self.env,self.scope).elaborate(tree)
        self.env.data['functions']['sample']['lean']='changed target'
        with self.assertRaisesRegex(CleanError,'Changed bound module callable'):
            index_comparison(value,self.env,self.scope)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
