# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Explicit packaged API; these tests do not enable it as default inference."""
from pathlib import Path
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
from cleanlang.joint_inference import complete,Incomplete

ROOT=Path(__file__).resolve().parents[1]

class JointCompletion(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
 def test_vector_zero_uses_explicit_expected_carrier(self):
  expected=self.env.type('Vector(n,Complex)',self.scope)
  value=complete(expression_tree(parse('0','expression')),self.env,self.scope,expected,use_default=False)
  self.assertEqual(value.type,expected)
  self.assertEqual(value.tree[0],'BoundLiteral')
  self.assertEqual(value.tree[3],'complex vector zero')
 def test_local_scoped_application_uses_packaged_recursive_path(self):
  typ=self.env.type('Function(Function(Real,Real),Function(Complex,Real))')
  self.scope['h']=Expr('h','h',typ,tree=['Local','h'])
  tree=expression_tree(parse('h(function (a: Real,0))(0)','expression'))
  value=complete(tree,self.env,self.scope,use_default=False)
  self.assertEqual(value.tree[2][0][2],'Complex')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)
 def test_incomplete_never_falls_back_to_legacy_completion(self):
  typ=self.env.type('Function(k: Natural,Function(Function(Real,Vector(k,Complex)),Real))')
  self.scope['h']=Expr('h','h',typ,tree=['Local','h'])
  tree=expression_tree(parse('h(2)(function (a: Real,0))','expression'))
  # Checked subexpressions still use the ordinary no-hole elaborator. Verify
  # that an incomplete joint solve itself is propagated without a retry.
  with patch('cleanlang.joint_inference.clean_rows.Builder.materialize',side_effect=Incomplete('unresolved head')):
   with patch('cleanlang.numeral_inference.complete',side_effect=AssertionError('legacy fallback')):
    with self.assertRaises(Incomplete):complete(tree,self.env,self.scope)
 def test_caller_scope_dictionary_is_not_mutated(self):
  before=dict(self.scope)
  complete(expression_tree(parse('0','expression')),self.env,self.scope,self.env.type('Real'))
  self.assertEqual(self.scope,before)

 def test_analysis_identity_does_not_expand_impossible_child_rows(self):
  load_module(ROOT/'library/analysis.clean',self.env)
  self.scope['x']=Expr('x','x',self.env.type('Real'),tree=['Local','x'])
  tree=expression_tree(parse('sin(x)^2 + cos(x)^2 = 1','expression'))
  value=complete(tree,self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Proposition'))
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
