# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr
from cleanlang.modules import load_module,notation
from binder_types import CheckedBinderTypes
from constraint_model import Binder,Carrier,Bound,Variable,IndexExpression,Incomplete,NoSolution,instantiate
ROOT=Path(__file__).resolve().parents[2]

class CheckedBinderTypeBridge(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
 def codec(self,**kwargs):return CheckedBinderTypes(self.env,self.scope,**kwargs)
 def test_direct_dependent_type_round_trip(self):
  typ=self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope)
  codec=self.codec();term=codec.encode(typ)
  key=lambda n:self.env.data['types'][n]['native_binding']
  self.assertEqual(term,Binder(key('Function'),Carrier(key('Natural')),Carrier(key('Vector'),(Bound(0,'index'),Carrier(key('Complex'))))))
  self.assertEqual(codec.decode(term),typ)
 def test_alpha_renamed_checked_types_share_structure(self):
  codec=self.codec()
  left=codec.encode(self.env.type('Function(k: Natural,Matrix(k,n,Complex))',self.scope))
  right=codec.encode(self.env.type('Function(j: Natural,Matrix(j,n,Complex))',self.scope))
  self.assertEqual(left,right)
 def test_nested_binders_preserve_both_dimensions(self):
  typ=self.env.type('Function(j: Natural,Function(k: Natural,Matrix(j,k,Complex)))',self.scope)
  codec=self.codec();self.assertEqual(codec.decode(codec.encode(typ)),typ)
 def test_dependent_domain_in_ordinary_function_layer(self):
  typ=self.env.type('Function(k: Natural,Function(Vector(k,Complex),Real))',self.scope)
  codec=self.codec();self.assertEqual(codec.decode(codec.encode(typ)),typ)
 def test_outer_computed_index_keeps_retained_expression(self):
  typ=self.env.type('Function(k: Natural,Matrix(k,(n+1),Complex))',self.scope)
  codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertEqual(result,typ)
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(typ,'lean',self.scope))
 def test_computed_bound_index_preserves_selected_operation(self):
  typ=self.env.type('Function(k: Natural,Vector((k+1),Complex))',self.scope)
  codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertEqual(result,typ)
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(typ,'lean',self.scope))
 def test_ignored_bound_source_is_not_silently_normalized_away(self):
  notation('Define ignore(k: Natural): Natural:', ['Equals: (0:Natural)','Render latex: ignore({k})'],self.env,authored=True)
  typ=self.env.type('Function(k: Natural,Matrix(k,(ignore(k)),Complex))',self.scope)
  codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(typ,'lean',self.scope))
 def test_free_type_parameter_survives_reconstruction(self):
  self.scope['T']=Expr('T','T',self.env.type('Type'),tree=['Local','T'])
  typ=self.env.type('Function(k: Natural,Vector(k,T))',self.scope)
  codec=self.codec();self.assertEqual(codec.decode(codec.encode(typ)),typ)
 def test_fresh_output_name_avoids_caller_collision(self):
  self.scope['bound']=self.scope['n']
  typ=self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope)
  codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertNotEqual(result.binder,'bound');self.assertEqual(result,typ)
 def test_unknown_constructor_or_unsolved_variable_is_incomplete(self):
  for term in [Carrier('not declared'),Variable('T','type')]:
   with self.subTest(term=term),self.assertRaises(Incomplete):self.codec().decode(term)
 def test_reconstructed_wrong_index_type_is_incomplete(self):
  codec=self.codec();real=codec.encode(self.env.type('Real'))
  key=self.env.data['types']['Vector']['native_binding']
  with self.assertRaises(Incomplete):codec.decode(Carrier(key,(real,real)))
 def test_resource_limit_is_incomplete(self):
  typ=self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope)
  with self.assertRaises(Incomplete):self.codec(limit=1).encode(typ)

 def test_typed_instantiation_checks_and_substitutes_caller_argument(self):
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope))
  self.assertEqual(codec.apply(term,self.scope['n']),self.env.type('Vector(n,Complex)',self.scope))
 def test_typed_instantiation_rejects_wrong_domain(self):
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope))
  with self.assertRaises(NoSolution):codec.apply(term,self.scope['r'])
 def test_typed_instantiation_rechecks_argument_source(self):
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope))
  stale=Expr('n','n',self.env.type('Natural'),tree=['Local','missing'])
  with self.assertRaises(Incomplete):codec.apply(term,stale)

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md

 def test_typed_instantiation_rejects_wrong_binder_sort(self):
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Vector(k,Complex))',self.scope))
  with self.assertRaises(Incomplete):codec.apply(Binder(term.identity,term.domain,term.body,sort='index'),self.scope['n'])
 def test_retained_atom_evidence_is_not_guessed_in_another_codec(self):
  term=self.codec().encode(self.env.type('Vector(n,Complex)',self.scope))
  with self.assertRaisesRegex(Incomplete,'Missing retained'):self.codec().decode(term)

 def test_computed_index_refers_to_both_nested_binders(self):
  typ=self.env.type('Function(j: Natural,Function(k: Natural,Vector((j+k),Complex)))',self.scope)
  codec=self.codec();self.assertEqual(codec.decode(codec.encode(typ)),typ)
 def test_bound_callback_application_in_index(self):
  typ=self.env.type('Function(f: Function(Natural,Natural),Function(k: Natural,Vector((f(k)),Complex)))',self.scope)
  codec=self.codec();self.assertEqual(codec.decode(codec.encode(typ)),typ)
 def test_bound_record_projection_in_index(self):
  from cleanlang.structures import declare
  declare('Structure SizedPayload():',['Let size: Natural','Constructor: sized payload'],self.env)
  typ=self.env.type('Function(p: SizedPayload,Vector((p.size),Complex))',self.scope)
  codec=self.codec();self.assertEqual(codec.decode(codec.encode(typ)),typ)
 def test_computed_call_preserves_inferred_type_argument(self):
  notation('Notation count(item):',['Let T: Type','Let item: T','Returns: Natural','Means: 0','Render latex: count({item})'],self.env)
  typ=self.env.type('Function(k: Natural,Matrix(k,(count(k)),Complex))',self.scope)
  codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(typ,'lean',self.scope))
 def test_computed_index_typed_instantiation(self):
  typ=self.env.type('Function(k: Natural,Vector((k+1),Complex))',self.scope)
  codec=self.codec();result=codec.apply(codec.encode(typ),self.scope['n'])
  self.assertEqual(result,self.env.type('Vector((n+1),Complex)',self.scope))
 def test_bound_type_value_in_index_round_trip(self):
  notation('Notation count carrier(T: Type): Natural:', ['Means: 0','Render latex: count({T})'],self.env)
  typ=self.env.type('Function(k: Natural,Vector((count carrier(type(Vector(k,Complex):Type))),Complex))',self.scope)
  codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(typ,'lean',self.scope))

 def test_computed_bound_expression_is_alpha_stable(self):
  codec=self.codec()
  left=codec.encode(self.env.type('Function(k: Natural,Vector((k+1),Complex))',self.scope))
  right=codec.encode(self.env.type('Function(j: Natural,Vector((j+1),Complex))',self.scope))
  self.assertEqual(left,right)
 def test_changed_bound_operation_is_incomplete(self):
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Vector((k+1),Complex))',self.scope))
  self.env.data['functions']['natural sum']['lean']='changed target'
  with self.assertRaises(Incomplete):codec.decode(term)
 def test_computed_index_result_type_is_rechecked(self):
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Vector((k+1),Complex))',self.scope))
  expression=term.body.arguments[0]
  wrong=IndexExpression(expression.identity,expression.arguments[:-1]+(codec.encode(self.env.type('Complex')),))
  body=Carrier(term.body.identity,(wrong,term.body.arguments[1]))
  with self.assertRaisesRegex(Incomplete,'result type changed'):codec.decode(Binder(term.identity,term.domain,body))
 def test_computed_index_implicit_type_is_rechecked(self):
  notation('Notation count(item):',['Let T: Type','Let item: T','Returns: Natural','Means: 0','Render latex: count({item})'],self.env)
  codec=self.codec();term=codec.encode(self.env.type('Function(k: Natural,Matrix(k,(count(k)),Complex))',self.scope))
  expression=term.body.arguments[1]
  self.assertEqual(len(expression.arguments),3)
  wrong=IndexExpression(expression.identity,(expression.arguments[0],codec.encode(self.env.type('Real')),expression.arguments[2]))
  body=Carrier(term.body.identity,(term.body.arguments[0],wrong,term.body.arguments[2]))
  with self.assertRaisesRegex(Incomplete,'implicit argument differs'):codec.decode(Binder(term.identity,term.domain,body))

 def test_bound_type_value_alpha_stability_and_instantiation(self):
  notation('Notation count carrier(T: Type): Natural:', ['Means: 0','Render latex: count({T})'],self.env)
  codec=self.codec()
  source=lambda k:f'Function({k}: Natural,Vector((count carrier(type(Vector({k},Complex):Type))),Complex))'
  term=codec.encode(self.env.type(source('k'),self.scope))
  self.assertEqual(term,codec.encode(self.env.type(source('j'),self.scope)))
  actual=codec.apply(term,self.scope['n'])
  expected=self.env.type('Vector((count carrier(type(Vector(n,Complex):Type))),Complex)',self.scope)
  self.assertEqual(self.env.render_type(actual,'lean',self.scope),self.env.render_type(expected,'lean',self.scope))

 def test_bound_type_value_classifier_snapshot_is_rechecked(self):
  notation('Notation count carrier(T: Type): Natural:', ['Means: 0','Render latex: count({T})'],self.env)
  codec=self.codec()
  term=codec.encode(self.env.type('Function(k: Natural,Vector((count carrier(type(Vector(k,Complex):Type))),Complex))',self.scope))
  self.env.data['types']['Type']['native_declaration']='changed classifier declaration'
  with self.assertRaises(Incomplete):codec.decode(term)

 def literal_index(self,k='k'):
  if 'count vector' not in self.env.data['functions']:
   notation('Notation count vector(x):',['Let n: Natural','Let x: Vector(n,Complex)','Returns: Natural','Means: 0','Render latex: count({x})'],self.env)
  return self.env.type(f'Function({k}: Natural,Vector((count vector((0:Vector({k},Complex)))),Complex))',self.scope)
 def test_bound_literal_round_trip_preserves_target(self):
  typ=self.literal_index();codec=self.codec();result=codec.decode(codec.encode(typ))
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(typ,'lean',self.scope))
 def test_bound_literal_alpha_stability(self):
  codec=self.codec();self.assertEqual(codec.encode(self.literal_index('k')),codec.encode(self.literal_index('j')))
 def test_bound_literal_typed_instantiation(self):
  codec=self.codec();term=codec.encode(self.literal_index())
  result=codec.apply(term,self.scope['n'])
  expected=self.env.type('Vector((count vector((0:Vector(n,Complex)))),Complex)',self.scope)
  self.assertEqual(self.env.render_type(result,'lean',self.scope),self.env.render_type(expected,'lean',self.scope))

 def test_bound_literal_changed_declaration_is_incomplete(self):
  codec=self.codec();term=codec.encode(self.literal_index())
  self.env.data['functions']['complex vector zero']['literal']['digits']='1'
  with self.assertRaises(Incomplete):codec.decode(term)
