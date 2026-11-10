# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Recover conditions from proof types without solving for proofs or conditions."""
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,PROP,lean
from cleanlang.modules import load_module
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]
RECOVER='''Define condition of(h):
  Let p: Proposition
  Let h: Evidence(p)
  Returns: Proposition
  Equals: p
'''
class InferredConditions(unittest.TestCase):
 def load(self,extra=''):
  e=Environment()
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'Example.clean';p.write_text('Import "'+str(ROOT/'library/logic/proof_equality.clean')+'"\n'+extra)
   load_module(p,e)
  return e
 def scope(self,e,entries=None):
  s={}
  for n,t in entries or [('p','Proposition'),('q','Proposition'),('h','Evidence(p)'),('k','Evidence(p)'),('j','Evidence(q)')]:
   s[n]=Expr(n,n,e.type(t,s),tree=['Local',n])
  return s
 def test_signature_tree_and_explicit_target(self):
  e=self.load();s=self.scope(e);spec=e.data['functions']['same evidence']
  self.assertEqual(spec['signature_tree'],['Signature','same evidence',[
   ['Parameter','p','Proposition','implicit'],['Parameter','h','((p))','explicit'],['Parameter','k','((p))','explicit']],'Proposition'])
  got=Expressions(e,s).parse('h=k')
  self.assertEqual(got.tree,['Operator','=', ['Local','h'],['Local','k']])
  self.assertEqual(got.lean,f"(@_root_.{spec['native_binding']} (p) (h) (k))")
  self.assertEqual(got.type,PROP)
  self.assertEqual(got.lean,Expressions(e,s).parse('same evidence(h,k)').lean)
  e.operator_overloads['='].reverse()
  self.assertEqual(got.lean,Expressions(e,s).parse('h=k').lean)
 def test_different_conditions_do_not_unify(self):
  e=self.load();s=self.scope(e)
  with self.assertRaisesRegex(CleanError,'Inconsistent dependent argument'):Expressions(e,s).parse('same evidence(h,j)')
  with self.assertRaisesRegex(CleanError,'No declared meaning'):Expressions(e,s).parse('h=j')
 def test_quantified_condition_and_authored_recovery(self):
  e=self.load(RECOVER);s=self.scope(e,[('h','Evidence((for every (x: Natural,x=x)))')])
  value=Expressions(e,s).parse('condition of(h)')
  self.assertEqual(comparison_normal_form(value,e,s).tree,value.tree)  # Existing hidden-binder boundary.
  equality=Expressions(e,s).parse('h=h')
  self.assertIn('∀',equality.lean)
 def test_recovered_caller_binding_and_poisoned_metadata(self):
  e=self.load(RECOVER);s=self.scope(e)
  value=Expressions(e,s).parse('condition of(h)');value.inferred_args=(('p','wrong'),)
  self.assertEqual(comparison_normal_form(value,e,s).tree,['Local','p'])
  s['p']=Expr('changed','p',PROP,tree=['Local','p'])
  with self.assertRaisesRegex(CleanError,'changed in the current scope'):Expressions(e,s).parse('h=h')
 def test_computed_condition_preserves_first_operand(self):
  e=self.load(RECOVER);s=self.scope(e)
  s['r']=Expr('r','r',e.type('Evidence((condition of(h)))',s),tree=['Local','r'])
  first=Expressions(e,s).parse('condition of(h)').lean
  key=e.data['functions']['same evidence']['native_binding']
  self.assertEqual(Expressions(e,s).parse('r=h').lean,f'(@_root_.{key} ({first}) (r) (h))')
  self.assertEqual(Expressions(e,s).parse('h=r').lean,f'(@_root_.{key} (p) (h) (r))')
 def test_no_inverse_condition_inference(self):
  with self.assertRaisesRegex(CleanError,'direct'):
   self.load('Define invalid(h):\n  Let p: Proposition\n  Let h: Evidence((p and p))\n  Returns: Proposition\n  Equals: p\n')
 def test_missing_condition_is_not_guessed(self):
  with self.assertRaisesRegex(CleanError,'direct'):
   self.load('Define invalid(h):\n  Let p: Proposition\n  Let h: Natural\n  Returns: Proposition\n  Equals: p\n')
 def test_competing_meanings_remain_ambiguous(self):
  e=self.load('Condition other evidence(h,k):\n  Let p: Proposition\n  Let h,k: Evidence(p)\n  Infix: =\n  From Lean: True\n  Render latex: {h}={k}\n');s=self.scope(e)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,s).parse('h=k')
 def test_equality_is_explicitly_imported(self):
  e=Environment();load_module(ROOT/'library/operators.clean',e);load_module(ROOT/'library/logic/evidence.clean',e)
  s=self.scope(e)
  with self.assertRaisesRegex(CleanError,'No declared meaning'):Expressions(e,s).parse('h=h')
 def test_no_recovery_of_a_bound_condition(self):
  e=self.load('Define invalid(f):\n  Let p: Proposition\n  Let f: Function(q: Proposition,Evidence(p))\n  Returns: Proposition\n  Equals: p\n')
  s=self.scope(e,[('f','Function(q: Proposition,Evidence(q))')])
  with self.assertRaisesRegex(CleanError,'binder cannot escape'):Expressions(e,s).parse('invalid(f)')

 def test_bound_equality_keeps_selected_declaration(self):
  from cleanlang.bound_calls import bind
  from cleanlang.modules import notation
  e=self.load();s=self.scope(e)
  tree=bind(Expressions(e,s).parse('h=k').tree,e,s)
  original=Expressions(e,s).elaborate(tree).lean
  notation('Notation later(h,k):',['Let p: Proposition','Let h,k: Evidence(p)',
   'Returns: Proposition','Infix: =','Means: k = h','Render latex: {h}={k}'],e)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,s).parse('h=k')
  self.assertEqual(Expressions(e,s).elaborate(tree).lean,original)
 def test_recovery_checks_changed_condition_type(self):
  e=self.load();s=self.scope(e)
  s['p']=Expr('p','p',e.type('Natural'),tree=['Local','p'])
  with self.assertRaises(CleanError):Expressions(e,s).parse('same evidence(h,k)')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
