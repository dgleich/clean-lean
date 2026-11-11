# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,CleanError,SignatureMismatch
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
from cleanlang.numeral_inference import complete_joint,IncompleteNumeralAnalysis
from cleanlang.joint_inference import complete,Incomplete
from cleanlang.joint_inference.constraint_model import DefaultConflict,NoSolution,Underdetermined
ROOT=Path(__file__).resolve().parents[1]

class JointErrorAdapter(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
 def tree(self,source):return expression_tree(parse(source,'expression'))
 def test_adapter_preserves_retained_target(self):
  typ=self.env.type('Vector(n,Complex)',self.scope);tree=self.tree('0')
  actual=complete_joint(tree,self.env,self.scope,typ)
  expected=complete(tree,self.env,self.scope,typ)
  self.assertEqual((actual.lean,actual.tree),(expected.lean,expected.tree))
 def test_ambiguity_count_is_exhaustive(self):
  del self.env.numeral_default
  with self.assertRaisesRegex(CleanError,'Ambiguous numeral interpretation: 3 interpretations'):
   complete_joint(self.tree('1+2'),self.env,self.scope)
 def test_resource_failure_remains_incomplete(self):
  with self.assertRaises(IncompleteNumeralAnalysis):complete_joint(self.tree('1+2'),self.env,self.scope,limit=1)
 def test_no_legacy_retry_on_incomplete(self):
  with patch('cleanlang.joint_inference.complete',side_effect=Incomplete('pending')):
   with patch('cleanlang.numeral_inference.complete',side_effect=AssertionError('fallback')):
    with self.assertRaises(IncompleteNumeralAnalysis):complete_joint(self.tree('1'),self.env,self.scope)
 def test_solver_failures_do_not_forge_trial_mismatch_ownership(self):
  owner=object();self.env._numeral_trial_owner=owner
  for error in (NoSolution('none'),DefaultConflict('conflict'),Underdetermined('unknown')):
   with self.subTest(error=type(error).__name__):
    with patch('cleanlang.joint_inference.complete',side_effect=error):
     with self.assertRaises(CleanError) as caught:complete_joint(self.tree('1'),self.env,self.scope)
    self.assertNotIsInstance(caught.exception,SignatureMismatch)
    self.assertIs(self.env._numeral_trial_owner,owner)
 def test_assigned_expression_preserves_existing_trial(self):
  owner=object();self.env._numeral_trial_owner=owner
  with self.assertRaises(SignatureMismatch) as caught:
   complete_joint(self.tree('n'),self.env,self.scope,self.env.type('Real'))
  self.assertIs(caught.exception.owner,owner)
  self.assertIs(self.env._numeral_trial_owner,owner)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
