# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Later overloads cannot prevent comparison using an already retained body."""
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.conversion import comparison_normal_form,index_comparison
ROOT=Path(__file__).resolve().parents[1]
SOURCE='''Condition reflexive(x: Real):
  Holds when: x=x

Structure Box():
  Let value: Real
  Constructor: box

Define boxed(x: Real): Box:
  Equals: box(x)

Define selected(): Set(Real):
  Equals: set of(function(x: Real,x=x))

Condition included(S,T):
  Let S,T: Set(Real)
  Holds when: S ⊆ T
'''
class RetainedConversionScope(unittest.TestCase):
 def setUp(self):
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'Example.clean';p.write_text('Import "'+str(ROOT/'library/topology/basic.clean')+'"\n'+SOURCE)
   self.e=Environment();load_module(p,self.e)
  self.scope={'x':Expr('x','x',self.e.type('Real'),tree=['Local','x'])}
 def add_competitor(self):
  notation('Notation competing(x,y):',['Let x,y: Real','Returns: Proposition',
   'Infix: =','Means: x ≠ y','Render latex: {x}\\ne {y}'],self.e)
 def test_named_condition_uses_retained_operator_after_scope_change(self):
  e,s=self.e,self.scope
  expected=index_comparison(Expressions(e,s).parse('reflexive(x)'),e,s)
  self.add_competitor()
  with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,s).parse('x=x')
  value=Expressions(e,s).parse('reflexive(x)')
  self.assertEqual(index_comparison(value,e,s),expected)
  self.assertIn(e.data['functions']['reflexive']['native_binding'],value.lean)
 def test_authored_record_projection_survives_scope_change(self):
  e,s=self.e,self.scope;self.add_competitor()
  value=Expressions(e,s).parse('boxed(x).value')
  self.assertEqual(value.lean,'x')
  self.assertEqual(comparison_normal_form(value,e,s).tree,['Local','x'])
 def test_unretained_body_still_stops_after_scope_change(self):
  e,s=self.e,self.scope
  e.definitions['reflexive']['bound_tree']=None
  self.add_competitor()
  value=Expressions(e,s).parse('reflexive(x)')
  self.assertEqual(comparison_normal_form(value,e,s).lean,value.lean)
 def test_changed_retained_declaration_identity_is_rejected(self):
  e,s=self.e,self.scope
  e.data['functions']['equal']['lean']='changed identity'
  self.add_competitor()
  with self.assertRaisesRegex(CleanError,'Changed bound module callable'):
   comparison_normal_form(Expressions(e,s).parse('reflexive(x)'),e,s)

 def test_named_and_operator_calls_share_hidden_binder_boundary(self):
  e,s=self.e,self.scope
  s['S']=Expr('S','S',e.type('Set(Real)'),tree=['Local','S'])
  named=Expressions(e,s).parse('included(selected(),S)')
  operator=Expressions(e,s).parse('selected() ⊆ S')
  expected=index_comparison(named,e,s)
  self.assertEqual(index_comparison(operator,e,s),expected)
  different=Expressions(e,s).parse('S ⊆ selected()')
  self.assertNotEqual(index_comparison(different,e,s),expected)
  self.add_competitor()
  self.assertEqual(index_comparison(Expressions(e,s).parse('included(selected(),S)'),e,s),expected)
  self.assertEqual(index_comparison(Expressions(e,s).parse('selected() ⊆ S'),e,s),expected)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
