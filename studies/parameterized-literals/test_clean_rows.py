# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.syntax import expression_tree,parse
from clean_rows import Builder
from constraint_model import Variable,Atom,Carrier,Ambiguous,Underdetermined,Incomplete,NoSolution

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
  with self.assertRaises(Incomplete):
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
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(count(1),0)','expression')))
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
 def test_ground_literal_is_checked_before_selection(self):
  from unittest.mock import patch
  from cleanlang.literal_binding import call
  seen=[]
  def checked(tree,env,scope):
   seen.append(tree[3]);return call(tree,env,scope)
  with patch('cleanlang.literal_binding.call',checked):
   self.solve('0',expected=self.scope['x'].type,use_default=False)
  self.assertIn('complex vector zero',seen)
 def test_unavailable_ground_literal_check_blocks_selection(self):
  from unittest.mock import patch
  from cleanlang.core import CleanError
  with patch('cleanlang.literal_binding.call',side_effect=CleanError('Injected unavailable telescope checking')):
   with self.assertRaises(Incomplete):
    self.solve('0',expected=self.scope['x'].type,use_default=False)
 def test_unavailable_competing_ground_literal_is_not_dropped(self):
  from unittest.mock import patch
  from cleanlang.core import CleanError
  from cleanlang.literal_binding import call
  notation('Notation another(n: Natural): Vector(n,Complex):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  def checked(tree,env,scope):
   if tree[3]=='another':raise CleanError('Injected unavailable competitor check')
   return call(tree,env,scope)
  with patch('cleanlang.literal_binding.call',checked):
   with self.assertRaises(Incomplete):
    self.solve('0',expected=self.scope['x'].type,use_default=False)
 def test_ground_literal_batch_incomplete_precedes_mismatch(self):
  from types import SimpleNamespace
  from candidate_values import CandidateValues,ValuePlan
  def check(path,bindings):
   if path==(0,):raise NoSolution('Definite rejected application')
   raise Incomplete('Unavailable application')
  plans=(ValuePlan(Atom('a','index'),(0,),()),ValuePlan(Atom('b','index'),(1,),()))
  for ordered in (plans,plans[::-1]):
   with self.subTest(order=ordered):
    candidate=SimpleNamespace(fragment=SimpleNamespace(
     choices=(('literal',(0,),'a'),('literal',(1,),'b')),plans=ordered),expression=check)
    with self.assertRaises(Incomplete):CandidateValues.validate_ground_applications(candidate,{})
 def test_undemanded_call_checked_before_selection(self):
  from unittest.mock import patch
  from candidate_values import CandidateValues
  self.vector_count();seen=[];original=CandidateValues.expression
  def checked(candidate,path,bindings,defaulted=()):
   seen.append(path);return original(candidate,path,bindings,defaulted)
  with patch.object(CandidateValues,'expression',checked):
   self.solve('vector count(n,0)',use_default=False)
  self.assertIn((),seen)
 def test_unavailable_undemanded_call_blocks_selection(self):
  from unittest.mock import patch
  from candidate_values import CandidateValues
  self.vector_count();original=CandidateValues.expression
  def checked(candidate,path,bindings,defaulted=()):
   if path==():raise Incomplete('Unavailable root application')
   return original(candidate,path,bindings,defaulted)
  with patch.object(CandidateValues,'expression',checked):
   with self.assertRaises(Incomplete):self.solve('vector count(n,0)',use_default=False)
 def test_determined_application_type_mismatch_rejects_row(self):
  from types import SimpleNamespace
  from candidate_values import CandidateValues,ValuePlan
  expected=Carrier('expected');actual=Carrier('actual')
  plan=ValuePlan(Atom('output','index'),(),(),expected)
  candidate=SimpleNamespace(fragment=SimpleNamespace(plans=(plan,)),
   expression=lambda *_:SimpleNamespace(type=actual),
   builder=SimpleNamespace(typ=lambda t,_:t,index=lambda _: (Atom('output','index'),None)))
  with self.assertRaises(NoSolution):CandidateValues.validate_ground_applications(candidate,{})
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
 def test_computed_formal_argument_known_mismatch_rejects(self):
  self.padded()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('padded(2,x)','expression')),use_default=False)

 def test_computed_formal_index_does_not_default_unknown_competitor(self):
  self.padded()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  with self.assertRaises(Incomplete):
   Builder(self.e,{}).materialize(expression_tree(parse('padded(count(0),0)','expression')))

 def padded_cell(self):
  from cleanlang.structures import declare
  declare('Structure PaddedCell(n: Natural):',
   ['Let data: Vector((n+1),Complex)','Constructor: padded cell'],self.e)
 def test_computed_record_parameter_projection(self):
  self.padded_cell()
  value=Builder(self.e,{}).materialize(expression_tree(parse('padded cell(2,0).data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)'))
 def test_computed_record_parameter_from_caller(self):
  self.padded_cell()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('padded cell(n,0).data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((n+1),Complex)',self.scope))
 def test_nested_projection_retains_constructor_parameters(self):
  from cleanlang.structures import declare
  self.padded_cell()
  declare('Structure WrappedCell(n: Natural):',
   ['Let cell: PaddedCell(n)','Constructor: wrapped cell'],self.e)
  source='wrapped cell(2,padded cell(2,0)).cell.data'
  value=Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)'))
 def test_opaque_record_recovers_parameter_from_checked_nominal_type(self):
  self.padded_cell();key=self.e.data['functions']['padded cell']['native_binding']
  notation('Notation make padded cell(n: Natural,data: Vector((n+1),Complex)): PaddedCell(n):',
   ['Means: '+key+' n data','Render latex: C({n},{data})'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('make padded cell(2,0).data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)'))
  self.assertEqual(value.tree[0],'Projection')
  self.assertEqual(value.tree[1][1],'make padded cell')
 def test_record_parameter_evidence_respects_literal_origin(self):
  self.padded_cell()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('padded cell(count(1),0).data','expression')))
  from cleanlang.retained_codec import dumps,loads
  from cleanlang.core import Expressions
  replay=Expressions(self.e,{}).elaborate(loads(dumps(value.tree)))
  self.assertEqual(value.lean,replay.lean)
  def origins(node):
   if not isinstance(node,list):return []
   if node and node[0]=='BoundNumeral':return [(node[1],node[4])]
   return [p for child in node for p in origins(child)]
  self.assertIn(('1','defaulted'),origins(value.tree))

 def known_payload_holder(self):
  from cleanlang.structures import declare
  self.payload()
  declare('Structure PayloadHolder():',
   ['Let marker: Real','Let payload: Payload','Constructor: payload holder'],self.e)
 def test_known_constructor_fields_survive_mixed_literal_region(self):
  self.known_payload_holder()
  source='payload holder(0,payload((2:Natural),(0:Vector(2,Complex)))).payload.data'
  value=Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(2,Complex)'))
 def test_known_constructor_parameters_survive_mixed_literal_region(self):
  from cleanlang.structures import declare
  self.padded_cell()
  declare('Structure PaddedHolder(n: Natural):',
   ['Let marker: Real','Let cell: PaddedCell(n)','Constructor: padded holder'],self.e)
  source='padded holder(2,0,padded cell((2:Natural),(0:Vector(((2:Natural)+1),Complex)))).cell.data'
  value=Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)'))
 def test_known_opaque_producer_stays_without_field_evidence(self):
  self.known_payload_holder();key=self.e.data['functions']['payload']['native_binding']
  notation('Notation fixed payload(): Payload:',
   ['Means: '+key+' 2 (fun _ => 0)','Render latex: P'],self.e)
  with self.assertRaises(Incomplete):
   Builder(self.e,{}).materialize(expression_tree(parse('payload holder(0,fixed payload()).payload.data','expression')),use_default=False)

 def test_known_classifier_constructor_parameter_is_not_value_index(self):
  from cleanlang.structures import declare
  declare('Structure GenericCell(T: Type):',['Let data: T','Constructor: generic cell'],self.e)
  declare('Structure GenericHolder():',
   ['Let marker: Real','Let cell: GenericCell(Real)','Constructor: generic holder'],self.e)
  source='generic holder(0,generic cell(type(Real),(1:Real))).cell.data'
  value=Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
 def test_known_proof_parameter_does_not_require_index_evidence(self):
  from cleanlang.structures import declare
  load_module(ROOT/'library/logic/evidence.clean',self.e)
  declare('Structure Certified(n: Natural,h: Evidence((n=n))):',
   ['Let data: Real','Constructor: certified'],self.e)
  self.scope['h']=Expr('h','h',self.e.type('Evidence((n=n))',self.scope),tree=['Local','h'])
  source='certified(n,h,(1:Real))'
  value=Builder(self.e,self.scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Certified(n,h)',self.scope))

 def vector_count(self):
  self.record()
  notation('Define vector count(n: Natural,x: Vector(n,Complex)): Natural:',
   ['Equals: n','Render latex: len({x})'],self.e,authored=True)
 def test_dependent_call_checks_parameterized_literal_before_selection(self):
  self.vector_count()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(vector count(n,0),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(n)',self.scope))
  self.assertIn(self.e.data['functions']['vector count']['native_binding'],value.lean)
 def test_dependent_call_recovers_literal_parameter_from_scalar_argument(self):
  self.vector_count()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(vector count(2,0),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(2)'))
 def test_dependent_call_rejects_conflicting_expected_index(self):
  self.vector_count()
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('vector cell(vector count(2,0),0)','expression')),self.e.type('VectorCell(3)'))
 def test_unknown_literal_competitor_blocks_dependent_default(self):
  self.record()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  with self.assertRaises(Incomplete):
   Builder(self.e,{}).materialize(expression_tree(parse('vector cell(count(0),0)','expression')))
 def test_candidate_value_codec_replay(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.vector_count()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(vector count(2,0),0)','expression')),use_default=False)
  self.assertEqual(Expressions(self.e,{}).elaborate(loads(dumps(value.tree))).lean,value.lean)

 def test_nested_candidate_value_uses_checked_earlier_value(self):
  self.vector_count()
  source='vector cell(vector count(vector count(2,0),0),0)'
  value=Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(2)'))
 def test_candidate_value_result_does_not_break_operator_input_tie(self):
  self.record()
  notation('Define vector size(n: Natural,x: Vector(n,Complex)): Natural:',
   ['Equals: n','Infix: *','Render latex: size({x})'],self.e,authored=True)
  notation('Define vector real size(n: Natural,x: Vector(n,Complex)): Real:',
   ['Equals: (1:Real)','Infix: *','Render latex: size({x})'],self.e,authored=True)
  with self.assertRaises(Ambiguous):
   Builder(self.e,{}).materialize(expression_tree(parse('vector cell(2*0,0)','expression')),self.e.type('VectorCell(2)'),use_default=False)

 def test_nested_candidate_reconstructs_opaque_computed_parameter(self):
  self.vector_count()
  notation('Notation vector extent(n: Natural,x: Vector(n,Complex)): Natural:',
   ['Means: n','Render latex: extent({x})'],self.e)
  source='vector cell(vector count(vector extent(2,0),0),0)'
  value=Builder(self.e,{}).materialize(expression_tree(parse(source,'expression')),use_default=False)
  expected=self.e.type('VectorCell((vector extent((2:Natural),(0:Vector(2,Complex)))))')
  self.assertEqual(value.type,expected)
  self.assertIn(self.e.data['functions']['vector extent']['native_binding'],value.lean)
 def test_candidate_values_are_independent_of_declaration_enumeration(self):
  self.vector_count();tree=expression_tree(parse('vector cell(vector count(2,0),0)','expression'))
  first=Builder(self.e,{}).materialize(tree,use_default=False)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  second=Builder(self.e,{}).materialize(tree,use_default=False)
  self.assertEqual(first.lean,second.lean)
  self.assertEqual(first.tree,second.tree)

 def implicit_vector_count(self):
  self.record()
  notation('Define shared vector count(x,y):',
   ['Let n: Natural','Let x,y: Vector(n,Complex)','Returns: Natural','Equals: n',
    'Render latex: len({x},{y})'],self.e,authored=True)
 def test_candidate_checks_implicit_dimension_from_known_operand(self):
  self.implicit_vector_count()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(shared vector count(x,0),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(n)',self.scope))
 def test_nested_candidate_waits_for_child_implicit_arguments(self):
  self.implicit_vector_count()
  notation('Define vector count(n: Natural,x: Vector(n,Complex)): Natural:',
   ['Equals: n','Render latex: len({x})'],self.e,authored=True)
  source='vector cell(vector count(shared vector count(x,0),0),0)'
  value=Builder(self.e,self.scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(n)',self.scope))
 def test_candidate_reconstruction_rejects_inconsistent_implicit_binding(self):
  self.record()
  notation('Define inspect(x):',['Let T: Type','Let x: T','Returns: Natural',
   'Equals: (1:Natural)','Render latex: inspect({x})'],self.e,authored=True)
  tree=expression_tree(parse('vector cell(inspect(1),0)','expression'))
  builder=Builder(self.e,{})
  rows=builder.rows(tree)
  values=next(builder.row_values[row.choices] for row in rows
   if any(k=='numeral' and key==self.e.data['types']['Natural']['numerals']['native_binding']
          for k,path,key in row.choices))
  path=(2,0)
  formal,_=builder.telescope(self.e.data['functions']['inspect'],path)
  bindings=dict(values.bindings);bindings[formal['T']]=builder.typ(self.e.type('Real'))
  with self.assertRaisesRegex(NoSolution,'implicit argument differs'):
   values.expression(path,bindings)
  del bindings[formal['T']]
  with self.assertRaisesRegex(Incomplete,'implicit argument remains unresolved'):
   values.expression(path,bindings)

 def dependent_copy(self):
  notation('Notation vector extent(n: Natural,x: Vector(n,Complex)): Natural:',
   ['Means: n','Render latex: extent({x})'],self.e)
  notation('Define dependent copy(n: Natural,x: Vector(n,Complex),y: Vector((vector extent(n,x)),Complex)): Vector((vector extent(n,x)),Complex):',
   ['Equals: y','Render latex: copy({n},{x},{y})'],self.e,authored=True)
 def test_computed_formal_index_uses_parameterized_literal_value(self):
  self.dependent_copy()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('dependent copy(n,0,0)','expression')),use_default=False)
  expected=self.e.type('Vector((vector extent(n,(0:Vector(n,Complex)))),Complex)',self.scope)
  self.assertEqual(value.type,expected)
 def test_computed_formal_literal_value_recovers_scalar_dimension(self):
  self.dependent_copy()
  value=Builder(self.e,{}).materialize(expression_tree(parse('dependent copy(2,0,0)','expression')),use_default=False)
  expected=self.e.type('Vector((vector extent((2:Natural),(0:Vector(2,Complex)))),Complex)')
  self.assertEqual(value.type,expected)
 def test_computed_formal_literal_value_rejects_conflicting_expected_index(self):
  self.dependent_copy()
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('dependent copy(2,0,0)','expression')),self.e.type('Vector(3,Complex)'))
 def test_computed_record_field_index_uses_literal_field_value(self):
  from cleanlang.structures import declare
  self.dependent_copy()
  declare('Structure DependentPayload(n: Natural):',
   ['Let input: Vector(n,Complex)','Let output: Vector((vector extent(n,input)),Complex)',
    'Constructor: dependent payload'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('dependent payload(n,0,0).output','expression')),use_default=False)
  expected=self.e.type('Vector((vector extent(n,(0:Vector(n,Complex)))),Complex)',self.scope)
  self.assertEqual(value.type,expected)
 def test_computed_formal_literal_value_codec_replay(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.dependent_copy()
  value=Builder(self.e,{}).materialize(expression_tree(parse('dependent copy(2,0,0)','expression')),use_default=False)
  self.assertEqual(Expressions(self.e,{}).elaborate(loads(dumps(value.tree))).lean,value.lean)

 def test_dynamic_formal_index_does_not_invent_opaque_field_values(self):
  from cleanlang.structures import declare
  self.dependent_copy()
  declare('Structure DependentPayload(n: Natural):',
   ['Let input: Vector(n,Complex)','Let output: Vector((vector extent(n,input)),Complex)',
    'Constructor: dependent payload'],self.e)
  key=self.e.data['functions']['dependent payload']['native_binding']
  notation('Notation make dependent payload(n: Natural,x: Vector(n,Complex),y: Vector((vector extent(n,x)),Complex)): DependentPayload(n):',
   ['Means: '+key+' n x y','Render latex: P({n},{x},{y})'],self.e)
  self.scope['input']=self.scope['x']
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(expression_tree(parse('make dependent payload(n,0,0).output','expression')),use_default=False)
 def test_dynamic_formal_index_retains_default_origins(self):
  self.dependent_copy()
  notation('Notation count(x):',['Let T: Type','Let x: T','Returns: Natural','Means: 0','Render latex: count({x})'],self.e)
  value=Builder(self.e,{}).materialize(expression_tree(parse('dependent copy(count(1),0,0)','expression')))
  def origins(node):
   if not isinstance(node,list):return []
   if node and node[0]=='BoundNumeral' and node[1]=='1':return [node[4]]
   return [o for child in node for o in origins(child)]
  found=origins(value.tree)
  self.assertTrue(found)
  self.assertEqual(set(found),{'defaulted'})

 def typed_extent(self,classifier="Type"):
  notation(f'Notation carrier extent(T: {classifier}): Natural:',
   ['Means: 2','Render latex: extent({T})'],self.e)
  notation('Define typed vector(x,y):',
   [f'Let T: {classifier}','Let x: T','Let y: Vector((carrier extent(T)),Complex)',
    'Returns: Vector((carrier extent(T)),Complex)','Equals: y','Render latex: vector({x},{y})'],self.e,authored=True)
 def test_computed_index_uses_captured_implicit_classifier(self):
  self.typed_extent()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('typed vector(n,0)','expression')),use_default=False)
  expected=self.e.type('Vector((carrier extent(type(Natural))),Complex)',self.scope)
  self.assertEqual(value.type,expected)
 def test_computed_index_classifier_with_scalar_literal(self):
  self.typed_extent()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('typed vector(1,0)','expression')))
  self.assertEqual(value.type,self.e.type('Vector((carrier extent(type(Natural))),Complex)',self.scope))
 def test_computed_index_uses_declared_alternate_classifier(self):
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
  self.typed_extent('Small')
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('typed vector(n,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((carrier extent(type(Natural:Small))),Complex)',self.scope))
 def test_computed_index_missing_classifier_is_incomplete(self):
  from unittest.mock import patch
  self.typed_extent();original=Builder.telescope
  def capture(builder,spec,path):
   result=original(builder,spec,path);builder.formal_classifiers.clear();return result
  with patch.object(Builder,'telescope',capture):
   with self.assertRaises(Incomplete):self.solve('typed vector(n,0)',use_default=False)
 def test_computed_index_classifier_retained_codec(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.typed_extent()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('typed vector(n,0)','expression')),use_default=False)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def explicit_typed_vector(self,classifier='Type'):
  notation(f'Notation carrier extent(T: {classifier}): Natural:',
   ['Means: 2','Render latex: extent({T})'],self.e)
  notation(f'Define explicit vector(T: {classifier},x: T,y: Vector((carrier extent(T)),Complex)): Vector((carrier extent(T)),Complex):',
   ['Equals: y','Render latex: vector({T},{x},{y})'],self.e,authored=True)
 def test_explicit_carrier_operand_in_dependent_call(self):
  self.explicit_typed_vector()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('explicit vector(type(Real),1,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((carrier extent(type(Real))),Complex)',self.scope))
 def test_explicit_carrier_preserves_alternate_classifier(self):
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
  self.explicit_typed_vector('Small')
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('explicit vector(type(Real:Small),1,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((carrier extent(type(Real:Small))),Complex)',self.scope))
 def test_explicit_carrier_wrong_classifier_rejected(self):
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
  self.explicit_typed_vector('Small')
  with self.assertRaises(NoSolution):
   self.solve('explicit vector(type(Real:Type),1,0)',use_default=False)
 def test_explicit_local_carrier_operand(self):
  self.explicit_typed_vector()
  self.scope['T']=Expr('T','T',self.e.type('Type'),tree=['Local','T'])
  self.scope['z']=Expr('z','z',self.e.type('T',self.scope),tree=['Local','z'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('explicit vector(T,z,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((carrier extent(T)),Complex)',self.scope))
 def test_explicit_carrier_constructor_projection(self):
  from cleanlang.structures import declare
  self.explicit_typed_vector()
  declare('Structure TypedPayload(T: Type):',
   ['Let data: Vector((carrier extent(T)),Complex)','Constructor: typed payload'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('typed payload(type(Real),0).data','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((carrier extent(type(Real))),Complex)',self.scope))
 def test_local_function_constrains_vector_literal(self):
  self.scope['f']=Expr('f','f',self.e.type('Function(Vector(n,Complex),Real)',self.scope),tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
  self.assertEqual(value.tree[2][0][3],'complex vector zero')
 def test_local_dependent_function_computes_result_index(self):
  self.scope['f']=Expr('f','f',self.e.type('Function(k: Natural,Vector((k+1),Complex))',self.scope),tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)',self.scope))
 def test_local_function_result_supplies_dependent_argument(self):
  self.record()
  self.scope['f']=Expr('f','f',self.e.type('Function(Vector(n,Complex),Natural)',self.scope),tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(f(0),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell((f((0:Vector(n,Complex)))))',self.scope))
 def test_local_function_shadows_same_named_module_call(self):
  notation('Notation f(x: Real): Real:',['Means: x','Render latex: f({x})'],self.e)
  self.scope['f']=Expr('local_f','f',self.e.type('Function(Vector(n,Complex),Natural)',self.scope),tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Natural'))
  self.assertIn('local_f',value.lean)
  self.assertNotIn(self.e.data['functions']['f']['native_binding'],value.lean)
 def test_nonfunction_local_does_not_shadow_module_call(self):
  notation('Notation f(x: Real): Real:',['Means: x','Render latex: f({x})'],self.e)
  self.scope['f']=Expr('local_f','f',self.e.type('Real'),tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(0)','expression')),use_default=False)
  self.assertIn(self.e.data['functions']['f']['native_binding'],value.lean)
 def test_local_function_wrong_literal_rejected(self):
  self.scope['f']=Expr('f','f',self.e.type('Function(Vector(n,Complex),Real)',self.scope),tree=['Local','f'])
  with self.assertRaises(NoSolution):self.solve('f(1)',use_default=False)
 def test_local_function_literal_codec(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.scope['f']=Expr('f','f',self.e.type('Function(Vector(n,Complex),Real)',self.scope),tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(0)','expression')),use_default=False)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_nonfunction_local_without_module_has_no_call_interpretation(self):
  self.scope['f']=Expr('f','f',self.e.type('Real'),tree=['Local','f'])
  with self.assertRaises(NoSolution):self.solve('f(0)',use_default=False)
 def test_nested_local_calls_constrain_literal(self):
  self.scope['f']=Expr('f','f',self.e.type('Function(Vector(n,Complex),Natural)',self.scope),tree=['Local','f'])
  self.scope['g']=Expr('g','g',self.e.type('Function(Real,Vector(n,Complex))',self.scope),tree=['Local','g'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(g(0))','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Natural'))
  self.assertEqual(value.tree[2][0][2][0][2],'Real')
 def map_holder(self,dependent=False):
  from cleanlang.structures import declare
  function='Function(k: Natural,Vector((k+1),Complex))' if dependent else 'Function(Vector(n,Complex),Real)'
  declare('Structure MapHolder(n: Natural):',[f'Let map: {function}','Constructor: map holder'],self.e)
  self.scope['q']=Expr('q','q',self.e.type('MapHolder(n)',self.scope),tree=['Local','q'])
 def test_function_field_application_constrains_literal(self):
  self.map_holder()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('q.map(0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
  self.assertEqual(value.tree[0],'Apply')
  self.assertEqual(value.tree[2][0][3],'complex vector zero')
 def test_dependent_function_carrier_alpha_identity(self):
  builder=Builder(self.e,self.scope)
  left=self.e.type('Function(k: Natural,Vector((k+n),Complex))',self.scope)
  right=self.e.type('Function(j: Natural,Vector((j+n),Complex))',self.scope)
  different=self.e.type('Function(j: Natural,Vector((j+m),Complex))',self.scope)
  self.assertEqual(builder.typ(left),builder.typ(right))
  self.assertNotEqual(builder.typ(left),builder.typ(different))
 def test_dependent_function_carrier_preserves_outer_dependency(self):
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  typ=self.e.type('Function(k: Natural,Vector((k+n),Complex))',self.scope)
  for normalize in (True,False):
   self.assertEqual(builder.dependencies(typ,normalize=normalize),frozenset({('binder',())}))
  closed=self.e.type('Function(k: Natural,Vector(k,Complex))',self.scope)
  self.assertEqual(builder.dependencies(closed),frozenset())
 def test_dependent_function_inner_name_does_not_capture_outer_local(self):
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  typ=self.e.type('Function(n: Natural,Vector(n,Complex))',{})
  self.assertEqual(builder.dependencies(typ),frozenset())
  self.assertEqual(builder.dependencies(typ,normalize=False),frozenset())
 def test_dependent_function_dependency_budget_is_incomplete(self):
  typ=self.e.type('Function(k: Natural,Vector((k+n),Complex))',self.scope)
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope,limit=1,binder_ids={'n':('binder',())}).dependencies(typ)
 def test_dependent_function_argument_wrong_codomain_rejects(self):
  self.map_holder(True)
  notation('Notation consume wrong(f: Function(j: Natural,Vector(j,Complex)),x: Real): Real:',
   ['Means: x','Render latex: consume({f},{x})'],self.e)
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('consume wrong(q.map,0)','expression')),use_default=False)
 def test_dependent_function_symbolic_template_is_incomplete(self):
  typ=self.e.type('Function(k: Natural,Vector((k+n),Complex))',self.scope)
  with self.assertRaisesRegex(Incomplete,'Symbolic dependent'):
   Builder(self.e,self.scope).typ(typ,{'n':Variable('n','index')})
 def test_dependent_function_field_as_module_argument(self):
  self.map_holder(True)
  notation('Notation consume(f: Function(j: Natural,Vector((j+1),Complex)),x: Real): Real:',
   ['Means: x','Render latex: consume({f},{x})'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('consume(q.map,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
  self.assertEqual(value.tree[2][1][2],'Real')
 def test_dependent_function_field_application(self):
  self.map_holder(True)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('q.map(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)',self.scope))
 def dependent_map_producer(self,shifted=False):
  result='Vector((k+1),Complex)' if shifted else 'Vector(k,Complex)'
  notation(f'Notation make dependent(x: Real): Function(k: Natural,{result}):',
   ['Means: fun _ _ => (0 : Complex)','Render latex: map({x})'],self.e)
 def test_inferred_dependent_head(self):
  self.dependent_map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make dependent(0)(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(2,Complex)',self.scope))
  self.assertEqual(value.tree[1][2][0][2],'Real')
  self.assertEqual(value.tree[2][0][2],'Natural')
 def test_inferred_dependent_head_computed_codomain(self):
  self.dependent_map_producer(True)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make dependent(0)(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)',self.scope))
 def test_inferred_dependent_head_computed_argument(self):
  self.dependent_map_producer(True)
  notation('Define count real(x: Real): Natural:', ['Equals: (2:Natural)','Render latex: count({x})'],self.e,authored=True)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make dependent(0)(count real(0))','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)',self.scope))
 def test_inferred_dependent_projection_head(self):
  self.map_holder(True)
  typ=self.e.type('Function(j: Natural,Vector((j+1),Complex))',self.scope)
  self.scope['f']=Expr('f','f',typ,tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('map holder(0,f).map(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+1),Complex)',self.scope))
 def test_inferred_dependent_head_codec_and_order(self):
  from cleanlang.retained_codec import dumps,loads
  from cleanlang.core import Expressions
  self.dependent_map_producer(True)
  tree=expression_tree(parse('make dependent(0)(2)','expression'))
  first=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  second=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.assertEqual(first.tree,second.tree)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(first.tree))).lean,first.lean)
 def test_inferred_dependent_head_wrong_argument_rejects(self):
  self.dependent_map_producer()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('make dependent(0)(r)','expression')),use_default=False)
 def test_inferred_dependent_head_wrong_expected_result_rejects(self):
  self.dependent_map_producer()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('make dependent(0)(2)','expression')),self.e.type('Real'),use_default=False)
 def offset_map_producer(self):
  notation('Notation make offset(n: Natural,x: Real): Function(k: Natural,Vector((k+n),Complex)):',
   ['Means: fun _ _ => (0 : Complex)','Render latex: map({n},{x})'],self.e)
 def test_dependent_signature_substitutes_producer_parameter(self):
  self.offset_map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make offset(n,0)(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+n),Complex)',self.scope))
 def test_dependent_signature_substitutes_literal_parameter(self):
  self.offset_map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make offset(3,0)(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+(3:Natural)),Complex)',self.scope))
 def test_dependent_signature_substitutes_reconstructed_parameter(self):
  self.offset_map_producer()
  notation('Define count real(x: Real): Natural:', ['Equals: (3:Natural)','Render latex: count({x})'],self.e,authored=True)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make offset(count real(0),0)(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+(3:Natural)),Complex)',self.scope))
 def test_dependent_signature_parameter_type_checks_argument(self):
  notation('Notation consume offset(n: Natural,f: Function(k: Natural,Vector((k+n),Complex)),x: Real): Real:',
   ['Means: x','Render latex: consume({n},{f},{x})'],self.e)
  typ=self.e.type('Function(j: Natural,Vector((j+n),Complex))',self.scope)
  self.scope['f']=Expr('f','f',typ,tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('consume offset(n,f,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('consume offset(m,f,0)','expression')),use_default=False)
 def test_dependent_signature_substitutes_type_parameter(self):
  notation('Notation make constant(T: Type,item: T,x: Real): Function(k: Natural,Vector(k,T)):',
   ['Means: fun _ _ => item','Render latex: constant({item})'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make constant(type(Real:Type),r,0)(2)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(2,Real)',self.scope))
 def test_dependent_signature_substitution_preserves_outer_scope(self):
  self.offset_map_producer()
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  value=builder.materialize(expression_tree(parse('make offset(n,0)(2)','expression')),use_default=False)
  self.assertEqual(builder.dependencies(value.type),frozenset({('binder',())}))
 def test_candidate_mismatch_trial_restores_owner(self):
  from cleanlang.core import SignatureMismatch
  from unittest.mock import patch
  owner=object();self.e._numeral_trial_owner=owner
  def mismatch(*args,**kwargs):raise SignatureMismatch('wrong domain',self.e._numeral_trial_owner)
  with patch('cleanlang.core.Expressions.elaborate',side_effect=mismatch):
   with self.assertRaises(NoSolution):Builder(self.e,self.scope).check_candidate(['Local','r'])
  self.assertIs(self.e._numeral_trial_owner,owner)
 def test_candidate_foreign_mismatch_and_unknown_error_stay_incomplete(self):
  from cleanlang.core import SignatureMismatch,CleanError
  from unittest.mock import patch
  builder=Builder(self.e,self.scope)
  with patch('cleanlang.core.Expressions.elaborate',side_effect=SignatureMismatch('foreign',object())):
   with self.assertRaises(Incomplete):builder.check_candidate(['Local','r'])
  self.assertFalse(hasattr(self.e,'_numeral_trial_owner'))
  with patch('cleanlang.core.Expressions.elaborate',side_effect=CleanError('unavailable')):
   with self.assertRaises(Incomplete):builder.call_witness(None,None,['Local','r'],())()
  self.assertFalse(hasattr(self.e,'_numeral_trial_owner'))
 def test_candidate_trial_rejects_unassigned_literals(self):
  with self.assertRaises(Incomplete):Builder(self.e,self.scope).check_candidate(['Decimal','0'])
 def test_dependent_signature_unresolved_parameter_stays_incomplete(self):
  notation('Notation hidden offset(f,x):',
   ['Let n: Natural','Let f: Function(k: Natural,Vector((k+n),Complex))','Let x: Real','Returns: Real',
    'Means: x','Render latex: offset({f},{x})'],self.e)
  typ=self.e.type('Function(j: Natural,Vector((j+n),Complex))',self.scope)
  self.scope['f']=Expr('f','f',typ,tree=['Local','f'])
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(expression_tree(parse('hidden offset(f,0)','expression')),use_default=False)
 def nested_map_producer(self):
  notation('Notation nested maps(x: Real): Function(n: Natural,Function(k: Natural,Vector((n+k),Complex))):',
   ['Means: fun _ _ _ => (0 : Complex)','Render latex: nested({x})'],self.e)
 def test_chained_dependent_head_preserves_first_argument(self):
  self.nested_map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('nested maps(0)(2)(3)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+(3:Natural)),Complex)',self.scope))
 def test_chained_dependent_local_preserves_first_argument(self):
  typ=self.e.type('Function(j: Natural,Function(k: Natural,Vector((j+k),Complex)))',self.scope)
  self.scope['f']=Expr('f','f',typ,tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(2)(3)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+(3:Natural)),Complex)',self.scope))
 def test_chained_dependent_head_preserves_computed_first_argument(self):
  self.nested_map_producer()
  notation('Define count real(x: Real): Natural:', ['Equals: (2:Natural)','Render latex: count({x})'],self.e,authored=True)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('nested maps(0)(count real(0))(3)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+(3:Natural)),Complex)',self.scope))
 def test_chained_dependent_head_keeps_outer_free_dimension(self):
  self.nested_map_producer()
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  value=builder.materialize(expression_tree(parse('nested maps(0)(n)(3)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector((n+(3:Natural)),Complex)',self.scope))
  self.assertEqual(builder.dependencies(value.type),frozenset({('binder',())}))
 def test_chained_dependent_head_rejects_wrong_second_argument(self):
  self.nested_map_producer()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('nested maps(0)(2)(r)','expression')),use_default=False)
 def test_chained_dependent_head_retains_codec(self):
  from cleanlang.retained_codec import dumps,loads
  from cleanlang.core import Expressions
  self.nested_map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('nested maps(0)(2)(3)','expression')),use_default=False)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_chained_dependent_domain_constrains_vector_literal(self):
  typ=self.e.type('Function(j: Natural,Function(v: Vector(j,Complex),Function(k: Natural,Vector((j+k),Complex))))',self.scope)
  self.scope['f']=Expr('f','f',typ,tree=['Local','f'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('f(2)(0)(3)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Vector(((2:Natural)+(3:Natural)),Complex)',self.scope))
  self.assertEqual(value.tree[1][2][0][3],'complex vector zero')
 def map_producer(self):
  notation('Notation make map(n: Natural,x: Real): Function(Vector(n,Complex),Real):',
   ['Means: fun _ => x','Render latex: map({n},{x})'],self.e)
 def test_inferred_function_expression_application(self):
  self.map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make map(n,0)(0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
  self.assertEqual(value.tree[2][0][3],'complex vector zero')
 def test_application_conflicting_expected_type_rejected(self):
  self.map_producer()
  with self.assertRaises(NoSolution):
   self.solve('make map(n,0)(0)',expected=self.e.type('Complex'),use_default=False)
 def test_application_retained_codec(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.map_producer()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('make map(n,0)(0)','expression')),use_default=False)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_application_audits_operator_inside_callee(self):
  self.map_producer()
  notation('Notation alternative(x: Real,y: Real): Complex:',
   ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.e)
  with self.assertRaises(Ambiguous):self.solve('make map(n,r+0)(0)',use_default=False)
 def test_quantifier_body_infers_vector_zero(self):
  tree=['Forall','z','Vector(n,Complex)',['Operator','≠',['Local','z'],['Decimal','0']]]
  self.assertEqual(expression_tree(parse('for every (z: Vector(n,Complex), z != 0)','expression')),tree)
  value=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.assertEqual(value.type,self.e.type('Proposition'))
  self.assertEqual(value.tree[3][3][3],'complex vector zero')
 def test_nested_quantifier_retains_bound_dimension(self):
  tree=['Forall','k','Natural',['Exists','z','Vector(k,Complex)',['Operator','=', ['Local','z'],['Decimal','0']]]]
  value=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.assertNotIn('clean_pi_bound_',value.lean)
  self.assertIn('clean_bound_0',value.lean)
 def test_lambda_expected_result_constrains_literal(self):
  tree=['Lambda','z','Real',['Decimal','0']]
  expected=self.e.type('Function(Real,Vector(n,Complex))',self.scope)
  value=Builder(self.e,self.scope).materialize(tree,expected,use_default=False)
  self.assertEqual(value.type,expected)
  self.assertEqual(value.tree[3][3],'complex vector zero')
 def test_lambda_dependent_expected_result_rebinds_annotation(self):
  tree=['Lambda','k','Natural',['Decimal','0']]
  expected=self.e.type('Function(j: Natural,Vector(j,Complex))',self.scope)
  value=Builder(self.e,self.scope).materialize(tree,expected,use_default=False)
  self.assertEqual(value.type,expected)
  self.assertNotIn('clean_pi_bound_',value.lean)
 def test_quantified_literal_codec_rebinds_dimensions(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  tree=expression_tree(parse('for every (k: Natural, there exists (z: Vector(k,Complex), z = 0))','expression'))
  value=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_lambda_domain_mismatch_is_rejected(self):
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(['Lambda','z','Real',['Decimal','0']],self.e.type('Function(Natural,Real)'))
 def test_binder_name_collision_is_rejected(self):
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(['Forall','n','Natural',['Operator','=', ['Local','n'],['Decimal','0']]])
 def test_binder_resource_limit_is_incomplete(self):
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope,limit=1).materialize(['Forall','z','Real',['Operator','=', ['Local','z'],['Decimal','0']]])
 def test_quantifier_wrong_expected_type_is_rejected(self):
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(['Forall','z','Real',['Operator','=', ['Local','z'],['Decimal','0']]],self.e.type('Real'))
 def test_checked_dimension_records_lexical_binder_dependency(self):
  from constraint_model import unify
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',(3,))})
  dimension=builder.typ(self.e.type('Vector(n,Complex)',self.scope)).arguments[0]
  self.assertEqual(dimension.free_binders,frozenset({('binder',(3,))}))
  with self.assertRaises(NoSolution):unify([(builder.variable('inner','index'),dimension),(Variable('outer','index'),dimension)])
 def test_candidate_variables_receive_active_binder_permissions(self):
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',(3,))})
  formal,_=builder.telescope(self.e.data['functions']['complex vector zero'],())
  self.assertEqual(formal['n'].allowed_binders,frozenset({('binder',(3,))}))
 def test_normalization_removes_unused_binder_dependency(self):
  from cleanlang.core import Expressions
  notation('Define ignore(n: Natural): Natural:',
   ['Equals: (0:Natural)','Render latex: ignore({n})'],self.e,authored=True)
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  value=Expressions(self.e,self.scope).parse('ignore(n)')
  zero=Expressions(self.e,self.scope).parse('(0:Natural)')
  self.assertEqual(builder.index(value)[0],builder.index(zero)[0])
  self.assertFalse(builder.index(value)[0].free_binders)
 def test_same_printed_index_in_distinct_scopes_stays_distinct(self):
  typ=self.e.type('Vector(n,Complex)',self.scope)
  left=Builder(self.e,self.scope,binder_ids={'n':('binder',(1,))}).typ(typ).arguments[0]
  right=Builder(self.e,self.scope,binder_ids={'n':('binder',(2,))}).typ(typ).arguments[0]
  self.assertNotEqual(left,right)
 def test_opaque_index_tracks_implicit_carrier_dependency(self):
  from cleanlang.core import Expressions
  notation('Notation opaque count(item):',
   ['Let T: Type','Let item: T','Returns: Natural','Means: 0','Render latex: count({item})'],self.e)
  self.scope['T']=Expr('T','T',self.e.type('Type'),tree=['Local','T'])
  self.scope['item']=Expr('item','item',self.e.type('T',self.scope),tree=['Local','item'])
  builder=Builder(self.e,self.scope,binder_ids={'T':('binder',()),'item':('binder',(3,))})
  value=Expressions(self.e,self.scope).parse('opaque count(item)')
  self.assertEqual(builder.index(value)[0].free_binders,frozenset({('binder',()),('binder',(3,))}))
 def test_checked_binder_dependency_unknown_representation_is_incomplete(self):
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  with self.assertRaises(Incomplete):builder.dependencies(object())
 def test_checked_binder_dependency_budget_is_incomplete(self):
  builder=Builder(self.e,self.scope,limit=1,binder_ids={'n':('binder',())})
  with self.assertRaises(Incomplete):builder.dependencies(self.e.type('Vector(n,Complex)',self.scope))
 def test_source_witness_can_depend_on_erased_binder(self):
  from cleanlang.core import Expressions
  from witness_model import Resolver,Seed
  notation('Define ignore(n: Natural): Natural:',
   ['Equals: (0:Natural)','Render latex: ignore({n})'],self.e,authored=True)
  builder=Builder(self.e,self.scope,binder_ids={'n':('binder',())})
  term,value=builder.index(Expressions(self.e,self.scope).parse('ignore(n)'))
  self.assertFalse(term.free_binders)
  self.assertEqual(builder.dependencies(value,normalize=False),frozenset({('binder',())}))
  inner=builder.variable('inner','index');outer=Variable('outer','index')
  representatives=Resolver({inner:term,outer:term},[Seed(term,value,(0,))],
   validate=lambda t,v:builder.typ(v,{})==t,assemble=lambda *_:None,
   available=builder.witness_available,allowed_binders=frozenset(builder.binder_ids.values()))
  self.assertEqual(representatives.get(inner),value)
  with self.assertRaises(Incomplete):representatives.get(outer)
 def shifted_literal(self):
  notation('Notation shifted(m: Natural): Matrix(m,(m+1),Complex):',
   ['Means: fun _ _ => (0 : Complex)','Literal: 7','Render latex: 7'],self.e)
 def test_computed_literal_result_recovers_direct_parameter(self):
  self.shifted_literal()
  expected=self.e.type('Matrix(n,(n+1),Complex)',self.scope)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('7','expression')),expected,use_default=False)
  self.assertEqual(value.type,expected)
  self.assertEqual(value.tree[3],'shifted')
 def test_computed_literal_result_retained_codec(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.shifted_literal()
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('7','expression')),self.e.type('Matrix(n,(n+1),Complex)',self.scope),use_default=False)
  self.assertEqual(Expressions(self.e,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_computed_literal_result_duplicate_remains_ambiguous(self):
  self.shifted_literal()
  notation('Notation alternate shifted(m: Natural): Matrix(m,(m+1),Complex):',
   ['Means: fun _ _ => (0 : Complex)','Literal: 7','Render latex: 7'],self.e)
  with self.assertRaises(Ambiguous):
   Builder(self.e,self.scope).materialize(expression_tree(parse('7','expression')),self.e.type('Matrix(n,(n+1),Complex)',self.scope),use_default=False)
 def test_computed_literal_result_inside_dependent_call(self):
  self.record();self.shifted_literal()
  notation('Define shifted size(n: Natural,x: Matrix(n,(n+1),Complex)): Natural:',
   ['Equals: n','Render latex: size({x})'],self.e,authored=True)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(shifted size(n,7),0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('VectorCell(n)',self.scope))
 def test_computed_literal_result_rejects_conflicting_dimension(self):
  self.shifted_literal()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).materialize(expression_tree(parse('7','expression')),self.e.type('Matrix(n,n,Complex)',self.scope),use_default=False)
 def test_computed_literal_result_without_parameter_is_incomplete(self):
  self.shifted_literal()
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(expression_tree(parse('7','expression')))
 def test_computed_formal_unrelated_competitor_is_checked_by_shape(self):
  notation('Notation shifted(m: Natural): Matrix(m,(m+1),Complex):',
   ['Means: fun _ _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('x != 0','expression')))
  self.assertEqual(value.tree[3][3],'complex vector zero')
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


 def test_dependent_argument_recovers_implicit_carrier_before_literal_selection(self):
  notation('Notation read family(f,x):',
   ['Let T: Type','Let f: Function(k: Natural,Vector(k,T))','Let x: T','Returns: T',
    'Means: x','Render latex: read({f},{x})'],self.e)
  self.scope['family']=Expr('family','family',self.e.type('Function(j: Natural,Vector(j,Complex))',self.scope),tree=['Local','family'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('read family(family,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Complex'))
  self.assertEqual(dict(value.inferred_args)['T'],self.e.type('Complex'))
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  replay=Builder(self.e,self.scope).materialize(expression_tree(parse('read family(family,0)','expression')),use_default=False)
  self.assertEqual(replay.lean,value.lean)

 def test_dependent_argument_constraints_preserve_caller_type_parameter(self):
  notation('Notation read family(f,x):',
   ['Let T: Type','Let f: Function(k: Natural,Vector(k,T))','Let x: T','Returns: T',
    'Means: x','Render latex: read({f},{x})'],self.e)
  self.scope['U']=Expr('U','U',self.e.type('Type'),tree=['Local','U'])
  self.scope['family']=Expr('family','family',self.e.type('Function(j: Natural,Vector(j,U))',self.scope),tree=['Local','family'])
  self.scope['item']=Expr('item','item',self.e.type('U',self.scope),tree=['Local','item'])
  # The outer call still contains a literal, so this exercises candidate rows.
  notation('Notation wrap value(x,y):', ['Let U: Type','Let x: Real','Let y: U','Returns: U','Means: y','Render latex: wrap({x},{y})'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('read family(family,wrap value(0,item))','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('U',self.scope))

 def test_dependent_argument_does_not_capture_inner_dimension(self):
  notation('Notation read fixed width(f,x):',
   ['Let n: Natural','Let f: Function(k: Natural,Matrix(k,n,Complex))','Let x: Real','Returns: Real',
    'Means: x','Render latex: read({f},{x})'],self.e)
  self.scope['family']=Expr('family','family',self.e.type('Function(k: Natural,Matrix(k,k,Complex))',self.scope),tree=['Local','family'])
  with self.assertRaises(Incomplete):
   Builder(self.e,self.scope).materialize(expression_tree(parse('read fixed width(family,0)','expression')),use_default=False)

 def test_dependent_argument_recovers_caller_index_with_type_evidence(self):
  notation('Notation read width(f,x):',
   ['Let width: Natural','Let f: Function(k: Natural,Matrix(k,width,Complex))','Let x: Real','Returns: Real',
    'Means: x','Render latex: read({f},{x})'],self.e)
  self.scope['family']=Expr('family','family',self.e.type('Function(k: Natural,Matrix(k,n,Complex))',self.scope),tree=['Local','family'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('read width(family,0)','expression')),use_default=False)
  self.assertEqual(value.type,self.e.type('Real'))
  self.assertEqual(dict(value.inferred_args)['width'],self.e.type('Vector(n,Complex)',self.scope).args[0])
 def test_dependent_argument_supplies_only_carrier_witness(self):
  notation('Notation inspect family(f,x):',
   ['Let T: Type','Let f: Function(k: Natural,Vector(k,T))','Let x: Real','Returns: Real',
    'Means: x','Render latex: inspect({f},{x})'],self.e)
  self.scope['U']=Expr('U','U',self.e.type('Type'),tree=['Local','U'])
  self.scope['family']=Expr('family','family',self.e.type('Function(k: Natural,Vector(k,U))',self.scope),tree=['Local','family'])
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('inspect family(family,0)','expression')),use_default=False)
  self.assertEqual(dict(value.inferred_args)['T'],self.e.type('U',self.scope))

 def test_dependent_type_witnesses_follow_caller_visit_order(self):
  from cleanlang.dependent_functions import index_tree
  self.scope['alias']=Expr('alias','alias',self.e.type('Natural'),tree=['Local','alias'],local_normal=self.scope['n'],local_expand=True)
  alias_type=self.e.type('Function(k: Natural,Matrix(k,alias,Complex))',self.scope)
  plain_type=self.e.type('Function(k: Natural,Matrix(k,n,Complex))',self.scope)
  index=self.e.type('Vector(n,Complex)',self.scope).args[0]
  for first,second,name in [(alias_type,plain_type,'alias'),(plain_type,alias_type,'n')]:
   builder=Builder(self.e,self.scope);builder.typ(first);builder.typ(second)
   self.assertEqual(index_tree(builder.rigid[builder.typ(index,{})]),['Local',name])
 def test_dependent_type_witnesses_exclude_opened_binder(self):
  from cleanlang.annotations import references
  typ=self.e.type('Function(k: Natural,Matrix(k,n,Complex))',self.scope)
  builder=Builder(self.e,self.scope);builder.typ(typ)
  for value in builder.rigid.values():
   self.assertTrue(references(value,self.scope).issubset(self.scope))

 def family_producer_fixture(self):
  notation('Notation make family(x: Real): Function(k: Natural,Vector(k,Complex)):',
   ['Means: fun _ _ => (0 : Complex)','Render latex: family({x})'],self.e)
  notation('Notation read family(f,x):',
   ['Let T: Type','Let f: Function(k: Natural,Vector(k,T))','Let x: T','Returns: T',
    'Means: x','Render latex: read({f},{x})'],self.e)
  return expression_tree(parse('read family(make family(0),0)','expression'))
 def test_dependent_argument_from_inferred_producer(self):
  tree=self.family_producer_fixture()
  value=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.assertEqual(value.type,self.e.type('Complex'))
  self.assertEqual(dict(value.inferred_args)['T'],self.e.type('Complex'))

 def test_dependent_producer_unavailable_check_is_not_pruned(self):
  from unittest.mock import patch
  from cleanlang.core import CleanError
  tree=self.family_producer_fixture()
  with patch.object(Builder,'check_candidate',side_effect=CleanError('unavailable producer')):
   with self.assertRaisesRegex(Incomplete,'candidate checking unavailable'):
    Builder(self.e,self.scope).materialize(tree,use_default=False)
 def test_dependent_producer_declaration_order_is_irrelevant(self):
  tree=self.family_producer_fixture()
  first=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  second=Builder(self.e,self.scope).materialize(tree,use_default=False)
  self.assertEqual(first.lean,second.lean)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
