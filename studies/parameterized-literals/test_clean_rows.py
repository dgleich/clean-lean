# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.syntax import expression_tree,parse
from clean_rows import Builder
from constraint_model import Atom,Carrier,Ambiguous,Underdetermined,Incomplete,NoSolution

ROOT=Path(__file__).resolve().parents[2]
class CleanRows(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/linear_algebra.clean',self.e)
  self.scope={n:Expr(n,n,self.e.type('Natural'),tree=['Local',n]) for n in ('m','n')}
  for n,t in [('x','Vector(n,Complex)'),('A','Matrix(m,n,Real)'),('r','Real')]:
   self.scope[n]=Expr(n,n,self.e.type(t,self.scope),tree=['Local',n])
 def test_group_classifier_is_not_reparsed_sequentially(self):
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
  notation('Notation count types(Small,T):',
   ['Let Small,T: Small','Returns: Natural','Means: 0','Render latex: 0'],self.e)
  variables,_=Builder(self.e,{}).telescope(self.e.data['functions']['count types'],())
  self.assertEqual([(n,v.sort) for n,v in variables.items()],[('Small','type'),('T','type')])
 def test_missing_checked_signature_is_incomplete(self):
  del self.e.data['functions']['unequal']['checked_signature']
  with self.assertRaisesRegex(Incomplete,'Missing checked'):self.solve('x != 0')
 def test_constructor_telescope_uses_checked_descriptor(self):
  from cleanlang.structures import declare
  declare('Structure Cell(T: Type):',['Let entry: T','Constructor: cell'],self.e)
  variables,_=Builder(self.e,{}).telescope(self.e.data['functions']['cell'],())
  self.assertEqual([(n,v.sort) for n,v in variables.items()],[('T','type'),('entry','index')])
 def record(self):
  from cleanlang.structures import declare
  declare('Structure VectorCell(n: Natural):',
   ['Let entry: Vector(n,Complex)','Constructor: vector cell'],self.e)
 def test_scalar_constructor_constrains_zero(self):
  from cleanlang.structures import declare
  declare('Structure ScalarCell():',['Let entry: Real','Constructor: scalar cell'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('scalar cell(0)','expression')))
  self.assertEqual(value.type,self.e.type('ScalarCell'))
  self.assertEqual(value.tree[2][0][2],'Real')
 def test_constructor_recovers_dimension_without_vector_local(self):
  self.record();scope={'n':self.scope['n']}
  value=Builder(self.e,scope).materialize(expression_tree(parse('vector cell(n,0)','expression')))
  self.assertEqual(value.type,self.e.type('VectorCell(n)',scope))
  self.assertEqual(value.tree[2][1][5],[['n','explicit',['Local','n']]])
 def test_constructor_compares_normalized_index_but_retains_spelling(self):
  self.record()
  self.scope['k']=Expr('k','k',self.e.type('Natural'),tree=['Local','k'],
   local_normal=self.scope['n'],local_expand=True)
  target=self.e.type('VectorCell(n)',self.scope)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(k,0)','expression')),target)
  self.assertEqual(value.type,target)
  self.assertEqual(value.tree[2][1][5],[['n','explicit',['Local','k']]])
 def test_constructor_rejects_different_expected_dimension(self):
  self.record()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).solve(expression_tree(parse('vector cell(n,0)','expression')),
    self.e.type('VectorCell(m)',self.scope))
 def test_constructor_declaration_order_does_not_select_index_spelling(self):
  self.record();tree=expression_tree(parse('vector cell(n,0)','expression'))
  first=Builder(self.e,self.scope).materialize(tree)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  second=Builder(self.e,self.scope).materialize(tree)
  self.assertEqual(first.lean,second.lean)
 def test_literal_dimension_supplies_checked_zero_argument(self):
  self.record();tree=expression_tree(parse('vector cell(2,0)','expression'))
  value=Builder(self.e,{}).materialize(tree)
  self.assertEqual(value.type,self.e.type('VectorCell(2)'))
  dimension=value.tree[2][0]
  self.assertEqual(dimension[:3],['BoundNumeral','2','Natural'])
  self.assertEqual(dimension[4],'inferred')
  self.assertEqual(value.tree[2][1][5],[['n','explicit',dimension]])
 def test_annotated_dimension_and_inferred_dimension_have_same_target(self):
  self.record()
  values=[Builder(self.e,{}).materialize(expression_tree(parse(s,'expression')))
   for s in ['vector cell(2,0)','vector cell((2:Natural),0)']]
  self.assertEqual(values[0].lean,values[1].lean)
 def test_literal_dimension_is_context_forced_without_default(self):
  self.record();tree=expression_tree(parse('vector cell(2,0)','expression'))
  value=Builder(self.e,{}).materialize(tree,use_default=False)
  self.assertEqual(value.tree[2][0][4],'inferred')
  self.assertEqual(value.tree[2][1][7],'inferred')
 def test_literal_dimension_rejects_conflicting_expected_index(self):
  self.record()
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('vector cell(2,0)','expression')),
    self.e.type('VectorCell(3)'))
 def test_literal_dimension_replays_selected_native_arguments(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.record()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(2,0)','expression')))
  from cleanlang.numerals import identity
  self.e.numeral_default=('Real',tuple(identity('Real',self.e)))
  replay=Expressions(self.e,{}).elaborate(loads(dumps(value.tree)))
  self.assertEqual(value.lean,replay.lean)
 def test_literal_dimension_enumeration_order_is_irrelevant(self):
  self.record();tree=expression_tree(parse('vector cell(2,0)','expression'))
  first=Builder(self.e,{}).materialize(tree)
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.assertEqual(first.lean,Builder(self.e,{}).materialize(tree).lean)
 def successor(self):
  notation('Notation successor(n: Natural): Natural:',
   ['Means: Nat.succ n','Render latex: {n}+1'],self.e)
 def test_checked_computed_dimension_supplies_rigid_value(self):
  self.record();self.successor()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(successor(n),0)','expression')))
  self.assertEqual(value.type,self.e.type('VectorCell((successor(n)))',self.scope))
  self.assertEqual(value.tree[2][1][5][0][2][0],'ModuleCall')
  self.assertIn(self.e.data['functions']['successor']['native_binding'],value.lean)
 def test_checked_projected_dimension_supplies_rigid_value(self):
  from cleanlang.structures import declare
  self.record();declare('Structure Dimension():',['Let size: Natural','Constructor: dimension'],self.e)
  self.scope['D']=Expr('D','D',self.e.type('Dimension'),tree=['Local','D'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(D.size,0)','expression')))
  self.assertEqual(value.type,self.e.type('VectorCell((D.size))',self.scope))
  self.assertEqual(value.tree[2][1][5][0][2],['Projection',['Local','D'],'size'])
 def test_computed_dimension_keeps_operator_identity(self):
  self.record()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(n+n,0)','expression')))
  self.assertEqual(value.type,self.e.type('VectorCell((n+n))',self.scope))
  self.assertEqual(value.tree[2][1][5][0][2][0],'ModuleCall')
 def test_computed_dimension_rejects_different_expected_expression(self):
  self.record();self.successor()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(successor(n),0)','expression')),
    self.e.type('VectorCell((successor(m)))',self.scope))
 def test_deferred_call_dimension_is_checked_without_default(self):
  self.record();self.successor()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(successor(2),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell((successor((2:Natural))))',self.scope))
  self.assertEqual(value.tree[2][1][5][0][2][0],'ModuleCall')
 def test_deferred_chain_keeps_nested_calls(self):
  self.record();self.successor()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(successor(successor(2)),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell((successor(successor((2:Natural)))))',self.scope))
 def test_deferred_operator_result_supplies_dimension(self):
  self.record()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(n+1,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell((n+(1:Natural)))',self.scope))
 def test_deferred_conflicting_result_is_not_ignored(self):
  self.record();self.successor()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(successor(2),0)','expression')),
    self.e.type('VectorCell((successor((3:Natural))))',self.scope))
 def test_deferred_call_with_parameterized_literal_stays_unresolved(self):
  self.record()
  notation('Notation length of vector(x):',
   ['Let n: Natural','Let x: Vector(n,Complex)','Returns: Natural','Means: n','Render latex: len({x})'],self.e)
  with self.assertRaises(Underdetermined):
   Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(length of vector(0),0)','expression')),use_default=False)
 def test_deferred_known_binding_change_is_incomplete(self):
  self.record();self.successor()
  self.e.data['functions']['successor']['lean']='changed'
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(successor(2),0)','expression')))
 def test_deferred_default_origin_is_retained(self):
  notation('Notation same(x):',['Let T: Type','Let x: T','Returns: T','Means: x','Render latex: {x}'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('same(0)','expression')))
  self.assertEqual(value.tree[2][0][4],'defaulted')
 def test_default_origin_survives_copy_into_dependent_index(self):
  self.record()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(count(0),0)','expression')))
  source_numeral=value.tree[2][0][2][0]
  index_call=value.tree[2][1][5][0][2]
  self.assertEqual(source_numeral[4],'defaulted')
  self.assertEqual(index_call[0],'ModuleCall')
  self.assertEqual(index_call[2][0][4],'defaulted')
 def test_deferred_dimension_codec_preserves_call(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.record();self.successor()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(successor(2),0)','expression')))
  replay=Expressions(self.e,{}).elaborate(loads(dumps(value.tree)))
  self.assertEqual(value.lean,replay.lean)
 def test_computed_dimension_declaration_order_is_irrelevant(self):
  self.record();self.successor();tree=expression_tree(parse('vector cell(successor(n),0)','expression'))
  first=Builder(self.e,self.scope).materialize(tree)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.assertEqual(first.lean,Builder(self.e,self.scope).materialize(tree).lean)
 def test_deferred_operator_uses_module_binding_despite_local_shadow(self):
  self.record()
  notation('Notation plus(x: Natural,y: Natural): Natural:',
   ['Means: Nat.add x y','Infix: +','Render latex: {x}+{y}'],self.e)
  self.e.operator_overloads['+']=['plus']
  self.scope['plus']=Expr('f','f',self.e.type('Function(Natural,Function(Natural,Natural))'),tree=['Local','plus'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(2+2,0)','expression')))
  self.assertIn(self.e.data['functions']['plus']['native_binding'],value.lean)
  self.assertNotIn('(f)',value.lean)
 def test_declared_natural_prefix_can_supply_constructor_dimension(self):
  self.record()
  notation('Notation truncated opposite(x: Natural): Natural:',
   ['Means: 0 - x','Prefix: -','Render latex: -{x}'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(-2,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell((-(2:Natural)))',self.scope))
  self.assertIn(self.e.data['functions']['truncated opposite']['native_binding'],value.lean)
 def dimension(self):
  from cleanlang.structures import declare
  declare('Structure Dimension():',['Let size: Natural','Constructor: dimension'],self.e)
 def test_projection_from_literal_constructor(self):
  self.dimension()
  value=Builder(self.e,{}).materialize(expression_tree(parse('dimension(2).size','expression')),use_default=False)
  self.assertEqual(value.tree[:3],['BoundNumeral','2','Natural'])
 def test_hole_bearing_projection_supplies_dimension(self):
  self.record();self.dimension()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(dimension(2).size,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(2)'))
 def test_projection_substitutes_structure_parameter(self):
  self.record()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(2,0).entry','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(2,Complex)'))
  self.assertEqual(value.tree[0],'BoundLiteral')
 def test_unknown_field_and_nonrecord_projection_are_mismatches(self):
  self.dimension()
  for source in ['dimension(2).missing','2.size']:
   with self.subTest(source=source),self.assertRaises(NoSolution):
    Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')))
 def test_projected_field_type_is_not_chosen_by_expected_type(self):
  from cleanlang.structures import declare
  declare('Structure ScalarCell():',['Let entry: Real','Constructor: scalar cell'],self.e)
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('scalar cell(0).entry','expression')),self.e.type('Natural'))
 def payload(self):
  from cleanlang.structures import declare
  declare('Structure Payload():',['Let size: Natural','Let data: Vector(size,Complex)','Constructor: payload'],self.e)
 def test_constructor_field_value_determines_dependent_projection(self):
  self.payload()
  value=Builder(self.e,{}).materialize(expression_tree(parse('payload(2,0).data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(2,Complex)'))
  self.assertEqual(value.tree[0],'BoundLiteral')
 def test_constructor_field_value_can_supply_another_dimension(self):
  self.payload();self.record()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(payload(2,0).size,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(2)'))
 def test_nested_constructor_projection_keeps_field_evidence(self):
  from cleanlang.structures import declare
  self.payload();declare('Structure Box():',['Let value: Payload','Constructor: box'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('box(payload(2,0)).value.data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(2,Complex)'))
 def test_constructor_field_does_not_capture_same_named_caller(self):
  self.payload();self.scope['size']=self.scope['m']
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('payload(2,0).data','expression')))
  self.assertEqual(value.type,self.e.type('Vector(2,Complex)'))
 def test_constructor_dependent_field_rejects_wrong_expected_size(self):
  self.payload()
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('payload(2,0).data','expression')),self.e.type('Vector(3,Complex)'))
 def test_opaque_producer_field_dependencies_remain_incomplete(self):
  self.payload();key=self.e.data['functions']['payload']['native_binding']
  notation('Notation make payload(size: Natural,data: Vector(size,Complex)): Payload:',
   ['Means: _root_.'+key+' size data','Render latex: P({size},{data})'],self.e)
  with self.assertRaisesRegex(Incomplete,'unavailable record field values'):
   Builder(self.e,{}).materialize(expression_tree(parse('make payload(2,0).data','expression')))
 def test_projection_keeps_operator_ambiguity_audit(self):
  self.dimension()
  notation('Notation alternative(x: Natural,y: Natural): Natural:',
   ['Means: x+y','Infix: +','Render latex: {x}+{y}'],self.e)
  with self.assertRaises(Ambiguous):
   Builder(self.e,{}).materialize(expression_tree(parse('dimension(1+1).size','expression')))
 def test_projection_cannot_resolve_operator_input_signature_tie(self):
  from cleanlang.structures import declare
  self.dimension();declare('Structure Other():',['Let other: Natural','Constructor: other'],self.e)
  for name,typ,constructor in [('sized','Dimension','dimension'),('unsized','Other','other')]:
   key=self.e.data['functions'][constructor]['native_binding']
   notation('Notation '+name+'(x: Natural): '+typ+':',
    ['Means: _root_.'+key+' x','Prefix: -','Render latex: -{x}'],self.e)
  with self.assertRaisesRegex(Ambiguous,'independently of the expected result'):
   Builder(self.e,{}).materialize(expression_tree(parse('(-2).size','expression')))
 def solve(self,source,**kw):
  return Builder(self.e,self.scope).solve(expression_tree(parse(source,'expression')),**kw)
 def literal(self,result):return [key for kind,_,key in result[0] if kind=='literal']
 def test_operand_order_recovers_same_caller_dimension(self):
  left=self.solve('x != 0');right=self.solve('0 != x')
  key=self.e.data['functions']['complex vector zero']['native_binding']
  self.assertEqual(self.literal(left),[key]);self.assertEqual(self.literal(right),[key])
  self.assertEqual(left[1],right[1])
  expected=Carrier(self.e.data['types']['Vector']['native_binding'],
   (Atom(repr('n'),'index'),Carrier(self.e.data['types']['Complex']['native_binding'])))
  self.assertEqual(left[1][0],expected)
 def test_rectangular_recovery_keeps_both_dimensions(self):
  result=self.solve('A = 0')
  self.assertEqual(self.literal(result),[self.e.data['functions']['real matrix zero']['native_binding']])
  self.assertEqual(result[1][0].arguments[:2],(Atom(repr('m'),'index'),Atom(repr('n'),'index')))
 def test_named_call_uses_the_same_signature_constraints(self):
  self.assertEqual(self.solve('unequal(x,0)')[1],self.solve('x != 0')[1])
 def test_expected_carrier_determines_bare_zero(self):
  result=self.solve('0',expected=self.scope['x'].type)
  self.assertEqual(self.literal(result),[self.e.data['functions']['complex vector zero']['native_binding']])
 def test_unresolved_family_is_not_discarded(self):
  with self.assertRaises(Underdetermined):self.solve('0',use_default=False)
 def test_default_restricts_all_zeros_simultaneously(self):
  result=self.solve('0 = 0');native=self.e.data['types']['Natural']['numerals']['native_binding']
  self.assertEqual([key for kind,_,key in result[0] if kind=='numeral'],[native,native])
 def test_wrong_digit_has_no_vector_interpretation(self):
  with self.assertRaises(NoSolution):self.solve('x != 1')
 def test_equivalent_constructor_bodies_remain_ambiguous(self):
  notation('Notation another(n: Natural): Vector(n,Complex):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  with self.assertRaises(Ambiguous):self.solve('x != 0')
 def test_candidate_enumeration_order_does_not_choose_meaning(self):
  first=self.solve('x != 0')
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  self.assertEqual(self.solve('x != 0'),first)
 def test_renamed_nominal_carrier_has_no_math_name_dispatch(self):
  type_declaration('Type Parcel(k: Natural):',['Means: Fin k → Complex','Render latex: P({k})'],self.e)
  notation('Notation blank(k: Natural): Parcel(k):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  self.scope['p']=Expr('p','p',self.e.type('Parcel(n)',self.scope),tree=['Local','p'])
  self.assertEqual(self.literal(self.solve('p != 0')),[self.e.data['functions']['blank']['native_binding']])
 def test_row_exhaustion_is_incomplete(self):
  tree=expression_tree(parse('x != 0','expression'))
  with self.assertRaises(Incomplete):Builder(self.e,self.scope,limit=1).solve(tree)
 def test_binder_region_is_explicitly_incomplete(self):
  with self.assertRaises(Incomplete):self.solve('function(t: Real,t+0)')
 def padded(self):
  notation('Define padded(n: Natural,x: Vector((n+1),Complex)): Vector((n+1),Complex):',
   ['Equals: x','Render latex: P({n},{x})'],self.e,authored=True)
 def test_computed_formal_index_from_literal_argument(self):
  self.padded()
  value=Builder(self.e,{}).materialize(expression_tree(parse('padded(2,0)','expression')),use_default=False)
  expected=self.e.type('Vector(((2:Natural)+1),Complex)')
  self.assertEqual(value.type,expected)
  self.assertEqual(value.tree[2][1][0],'BoundLiteral')
 def test_computed_formal_index_from_caller_argument(self):
  self.padded()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('padded(n,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((n+1),Complex)',self.scope))
 def test_computed_formal_index_rejects_conflicting_expected(self):
  self.padded()
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('padded(2,0)','expression')),
    self.e.type('Vector(((3:Natural)+1),Complex)'))
 def test_computed_formal_index_retains_target_under_candidate_reordering(self):
  self.padded();tree=expression_tree(parse('padded(2,0)','expression'))
  first=Builder(self.e,{}).materialize(tree,use_default=False)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  second=Builder(self.e,{}).materialize(tree,use_default=False)
  self.assertEqual(first.lean,second.lean)
  self.assertEqual(first.tree,second.tree)

 def test_computed_field_index_from_constructor_evidence(self):
  from cleanlang.structures import declare
  declare('Structure PaddedPayload():',
   ['Let size: Natural','Let data: Vector((size+1),Complex)','Constructor: padded payload'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('padded payload(2,0).data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)'))
 def test_computed_implicit_index_without_evidence_is_incomplete(self):
  notation('Notation implicit padded(x):',
   ['Let n: Natural','Let x: Vector((n+1),Complex)','Returns: Vector((n+1),Complex)',
    'Means: x','Render latex: P({x})'],self.e)
  with self.assertRaises(Incomplete):
   Builder(self.e,{}).materialize(expression_tree(parse('implicit padded(0)','expression')),
    self.e.type('Vector(((2:Natural)+1),Complex)'))

 def test_computed_formal_index_preserves_default_origin(self):
  self.padded()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('padded(count(1),0)','expression')))
  self.assertEqual(value.tree[2][0][2][0][4],'defaulted')
  index=value.tree[2][1][5][0][2]
  found=[]
  def visit(node):
   if not isinstance(node,list):return
   if node and node[0]=='BoundNumeral' and node[4]=='defaulted':found.append(node[1])
   for child in node:visit(child)
  visit(index)
  self.assertEqual(found,['1'])
 def test_computed_formal_index_codec_replay(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.padded()
  value=Builder(self.e,{}).materialize(expression_tree(parse('padded(2,0)','expression')),use_default=False)
  replay=Expressions(self.e,{}).elaborate(loads(dumps(value.tree)))
  self.assertEqual(value.lean,replay.lean)
  self.assertEqual(value.type,replay.type)
 def test_computed_formal_argument_check_failure_remains_incomplete(self):
  self.padded()
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(expression_tree(parse('padded(2,x)','expression')),use_default=False)

 def test_computed_formal_index_does_not_default_unknown_competitor(self):
  self.padded()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  with self.assertRaises(Incomplete):
   Builder(self.e,{}).materialize(expression_tree(parse('padded(count(0),0)','expression')))

 def test_computed_formal_competitor_is_not_dropped(self):
  notation('Notation shifted(m: Natural): Matrix(m,(m+1),Complex):',
   ['Means: fun _ _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  with self.assertRaises(Incomplete):self.solve('x != 0')
 def test_expected_result_does_not_resolve_operator_input_tie(self):
  notation('Notation alternative(x: Real,y: Real): Complex:',
   ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.e)
  with self.assertRaises(Ambiguous):self.solve('r+0',expected=self.e.type('Real'))

 def test_materialized_vector_literal_retains_constructor_and_dimension(self):
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('x != 0','expression')))
  self.assertEqual(value.tree[3][0],'BoundLiteral')
  self.assertEqual(value.tree[3][3],'complex vector zero')
  self.assertEqual(value.tree[3][5][0][2],['Local','n'])
  self.assertEqual(value.tree[3][7],'inferred')
 def test_materialized_target_is_independent_of_candidate_order(self):
  tree=expression_tree(parse('0 != x','expression'))
  first=Builder(self.e,self.scope).materialize(tree)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  second=Builder(self.e,self.scope).materialize(tree)
  self.assertEqual(first.lean,second.lean)
  self.assertEqual(first.tree,second.tree)
 def test_materialization_does_not_hide_an_unresolved_default(self):
  with self.assertRaises(Underdetermined):Builder(self.e,self.scope).materialize(expression_tree(parse('0','expression')),use_default=False)
 def test_zero_times_vector_keeps_scalar_and_matrix_interpretations(self):
  with self.assertRaises(Ambiguous):self.solve('0*x = x')

 def test_default_origin_is_retained_and_visible(self):
  tree=expression_tree(parse('0','expression'))
  builder=Builder(self.e,self.scope);trace=builder.solve_with_trace(tree)
  self.assertEqual(trace.defaulted_positions,(0,))
  value=builder.materialize(tree)
  self.assertEqual(value.tree[4],'defaulted')
  self.assertIn(r'\mathbb{N}',value.tex)
 def test_simultaneous_defaults_are_both_retained(self):
  tree=expression_tree(parse('0 = 0','expression'))
  builder=Builder(self.e,self.scope);trace=builder.solve_with_trace(tree)
  self.assertEqual(trace.defaulted_positions,(0,1))
  value=builder.materialize(tree)
  self.assertEqual([value.tree[i][4] for i in (2,3)],['defaulted','defaulted'])
 def test_context_forced_numeral_is_not_marked_defaulted(self):
  tree=expression_tree(parse('r+0','expression'))
  builder=Builder(self.e,self.scope);trace=builder.solve_with_trace(tree)
  self.assertEqual(trace.defaulted_positions,());self.assertIsNone(trace.default_carrier)
  self.assertEqual(builder.materialize(tree).tree[3][4],'inferred')
 def test_expected_carrier_precedes_any_default(self):
  tree=expression_tree(parse('0','expression'));builder=Builder(self.e,self.scope)
  expected=self.e.type('Real');trace=builder.solve_with_trace(tree,expected)
  self.assertEqual(trace.defaulted_positions,())
  value=builder.materialize(tree,expected)
  self.assertEqual(value.type,expected);self.assertEqual(value.tree[4],'inferred')
 def test_annotated_literal_is_not_a_default_position(self):
  tree=expression_tree(parse('0 = (0: Natural)','expression'));builder=Builder(self.e,self.scope)
  self.assertEqual(builder.solve_with_trace(tree).defaulted_positions,())
  value=builder.materialize(tree)
  self.assertEqual(value.tree[2][4],'inferred');self.assertEqual(len(value.tree[3]),4)
 def test_default_does_not_prefer_numerals_over_exact_constructor(self):
  notation('Notation another natural zero(): Natural:',
   ['Means: 0','Literal: 0','Render latex: 0'],self.e)
  with self.assertRaises(Ambiguous):
   Builder(self.e,self.scope).materialize(expression_tree(parse('0','expression')))
 def test_retained_default_survives_new_default_and_codec(self):
  from cleanlang.numerals import identity
  from cleanlang.retained_codec import dumps,loads
  from cleanlang.core import Expressions
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('0','expression')))
  saved=dumps(value.tree)
  self.e.numeral_default=('Real',tuple(identity('Real',self.e)))
  replay=Expressions(self.e,self.scope).elaborate(loads(saved))
  self.assertEqual(replay.lean,value.lean);self.assertEqual(replay.tex,value.tex)
  self.assertEqual(replay.tree[4],'defaulted')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
