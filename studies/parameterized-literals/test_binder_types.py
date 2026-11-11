# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr
from cleanlang.modules import load_module,notation
from binder_types import CheckedBinderTypes
from constraint_model import Binder,Carrier,Bound,Variable,Incomplete,NoSolution,instantiate
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
 def test_computed_bound_index_is_explicitly_incomplete(self):
  typ=self.env.type('Function(k: Natural,Vector((k+1),Complex))',self.scope)
  with self.assertRaisesRegex(Incomplete,'Opaque bound-index'):self.codec().encode(typ)
 def test_ignored_bound_source_is_not_silently_normalized_away(self):
  notation('Define ignore(k: Natural): Natural:', ['Equals: (0:Natural)','Render latex: ignore({k})'],self.env,authored=True)
  typ=self.env.type('Function(k: Natural,Matrix(k,(ignore(k)),Complex))',self.scope)
  with self.assertRaises(Incomplete):self.codec().encode(typ)
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
