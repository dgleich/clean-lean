# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
from dataclasses import replace
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions
from cleanlang.modules import load_module,notation
from cleanlang.retained_codec import dumps,loads
from constraint_model import Row,Selection,select_with_trace,Incomplete,NoSolution,Ambiguous
from clean_rows import Builder
from scoped_bodies import ScopedBody
ROOT=Path(__file__).resolve().parents[2]

class ScopedBodies(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
 def body(self):
  return ScopedBody(self.env,self.scope,['Lambda','k','Natural',['Decimal','0']],
   self.env.type('Function(j: Natural,Vector(j,Complex))',self.scope),path=(2,0))
 def test_body_retention_does_not_select_again(self):
  body=self.body();selection=select_with_trace(body.rows())
  with patch.object(Builder,'solve_with_trace',side_effect=AssertionError('second selection')):
   value=body.retain(selection)
  self.assertEqual(value.type,body.expected)
  self.assertEqual(value.tree[3][3],'complex vector zero')
  self.assertEqual(value.tree[3][-1],'inferred')
  self.assertNotIn('clean_pi_bound_',value.lean)
 def test_body_rows_can_share_constraints_with_an_outer_row(self):
  body=ScopedBody(self.env,self.scope,['Lambda','z','Real',['Decimal','0']],path=(2,0))
  real=body.builder.typ(self.env.type('Real'))
  rows=[Row(r.choices,r.carriers,r.arguments,r.equations+((r.arguments[-1],real),),r.deferred) for r in body.rows()]
  selection=select_with_trace(rows)
  value=body.retain(selection)
  self.assertEqual(value.type,self.env.type('Function(Real,Real)'))
 def test_retained_binder_survives_codec(self):
  body=self.body();value=body.retain(select_with_trace(body.rows()))
  self.assertEqual(Expressions(self.env,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_source_paths_distinguish_lexical_scope(self):
  a=self.body();b=ScopedBody(self.env,self.scope,a.tree,a.expected,path=(2,1))
  self.assertNotEqual(a.builder.variable('same','type'),b.builder.variable('same','type'))
 def test_selected_argument_arity_is_checked(self):
  body=self.body();selection=select_with_trace(body.rows())
  with self.assertRaises(Incomplete):body.retain(replace(selection,arguments=()))
 def test_bad_default_trace_is_rejected(self):
  body=self.body();selection=select_with_trace(body.rows())
  with self.assertRaises(Incomplete):body.retain(replace(selection,defaulted_positions=(8,)))
  with self.assertRaises(NoSolution):body.retain(replace(selection,defaulted_positions=(0,),default_carrier=body.builder.typ(self.env.type('Real'))))
 def test_unavailable_selected_row_is_rejected(self):
  body=self.body();selection=select_with_trace(body.rows())
  with self.assertRaises(Incomplete):body.retain(replace(selection,choices=('missing',)))
 def test_external_selection_cannot_bypass_operator_input_ambiguity(self):
  notation('Notation alternative(x: Real,y: Real): Complex:',
   ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.env)
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  builder=Builder(self.env,self.scope)
  tree=['Operator','+',['Local','r'],['Decimal','0']]
  expected=self.env.type('Real')
  selection=select_with_trace(builder.rows(tree,expected))
  with self.assertRaises(Ambiguous):builder.retain_selected(tree,selection,expected)
 def test_nested_scope_cannot_reuse_its_parent_identity(self):
  with self.assertRaises(Incomplete):
   ScopedBody(self.env,self.scope,['Lambda','k','Natural',['Decimal','0']],path=(2,0),
    binder_ids={'n':('binder',(2,0))})
 def test_domain_mismatch_is_rejected(self):
  with self.assertRaises(NoSolution):ScopedBody(self.env,self.scope,['Lambda','k','Natural',['Decimal','0']],self.env.type('Function(Real,Real)'),path=())
 def test_changed_scope_cannot_reuse_a_selected_body(self):
  body=self.body();selection=select_with_trace(body.rows())
  body.builder.scope['k']=Expr('k','k',self.env.type('Real'),tree=['Local','k'])
  with self.assertRaises((Incomplete,NoSolution,ValueError)):body.retain(selection)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
