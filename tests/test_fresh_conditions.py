# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Fresh condition traversal must retain current scope, never trust public metadata."""
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type
from cleanlang.modules import load_module,notation
from cleanlang.proof_types import index
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]

class FreshConditions(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/logic/evidence.clean',self.e)
  notation('Notation retain(x):',['Let A: Type','Let x: A','Returns: A','Means: x','Render latex: {x}'],self.e)
  self.scope={'A':Expr('A','A',Type('Type')),'B':Expr('B','B',Type('Type'))}
  self.bind('first','A')
 def bind(self,lean,typ):
  self.scope['x']=Expr(lean,'x',self.e.type(typ,self.scope),tree=['Local','x'])
 def test_checked_condition_checks_each_nested_call_once(self):
  depth=8;source='retain('*depth+'x'+')'*depth+' = x'
  original=self.e.call;calls=[]
  def counted(name,*args,**kwargs):
   if name=='retain':calls.append(name)
   return original(name,*args,**kwargs)
  self.e.call=counted
  try:proof=self.e.type('('+source+')',self.scope)
  finally:self.e.call=original
  self.assertEqual(len(calls),depth)
  self.assertIn('first',proof.args[0].lean)
 def test_public_condition_index_rechecks_changed_values_and_types(self):
  source='retain(retain(x)) = x'
  old=Expressions(self.e,self.scope).parse(source)
  self.bind('second','B')
  current=Expressions(self.e,self.scope).parse(source)
  self.assertEqual(index(old,self.e,self.scope).comparison_key(),index(current,self.e,self.scope).comparison_key())
  self.assertIn('second',str(index(old,self.e,self.scope).comparison_key()))
 def test_public_operator_ignores_poisoned_child_metadata(self):
  old=Expressions(self.e,self.scope).parse('retain(x) = x')
  old.checked_args=(Expr('wrong','wrong',Type('Natural')),)*2
  self.bind('second','B')
  actual=comparison_normal_form(old,self.e,self.scope)
  expected=comparison_normal_form(Expressions(self.e,self.scope).parse('retain(x) = x'),self.e,self.scope)
  self.assertEqual(actual.lean,expected.lean)
  self.assertNotIn('wrong',actual.lean)
 def test_nested_boolean_conditions_recheck_current_scope(self):
  source='(retain(x) = x) and (x = retain(x))'
  old=Expressions(self.e,self.scope).parse(source)
  self.bind('second','B')
  actual=comparison_normal_form(old,self.e,self.scope)
  expected=comparison_normal_form(Expressions(self.e,self.scope).parse(source),self.e,self.scope)
  self.assertEqual(actual.lean,expected.lean)

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
